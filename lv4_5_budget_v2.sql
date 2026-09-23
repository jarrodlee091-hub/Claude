-- =============================================================
-- LV4-5用户权益分组与预算测算（V2版）
-- =============================================================
-- 业务背景：
--   针对LV4-5用户设计6类互斥权益（按优先级分组，每个用户只进一个组）
--   优先级：断存 > 存款下滑 > 投注下滑 > 高输值 > 高活跃 > 保底
--
-- 日期说明：
--   VIP快照    ：9.21（pt='20260921'）→ 确定用户等级
--   过去7日     ：9.15-9.21（相对于9.21）→ 近期行为窗口
--   过去30日    ：8.23-9.21（相对于9.21）→ 长期行为窗口
--   高输值判断  ：9.21当日GGR（非7日累计）
--   预算测算日  ：9.22（pt='20260922'）→ 用当日实际数据估算各组预算
--
-- 分组规则（按优先级，互斥）：
--   1. 断存高价值  ：30日有存款 + 7日无存款 → 存送10%，LV4上限50 / LV5上限200
--   2. 存款下滑    ：7日日均存款 < 30日日均存款×50%（分母=有存款天数）→ 存送5%，LV4上限50 / LV5上限200
--   3. 投注下滑    ：7日日均投注 < 30日日均投注×50%（分母=有投注天数）→ 投注达标返（阶梯）
--   4. 高输值      ：9.21当日 LV4 GGR≥1000 / LV5 GGR≥3000 → 输返5%，LV4上限100 / LV5上限500
--   5. 高活跃      ：近7日投注天数≥4天 → 投注达标返（阶梯，门槛高于组3）
--   6. 保底        ：其余全部 → 投注返1%，LV4上限50 / LV5上限200
--
-- 投注达标返门槛明细：
--   组3-投注下滑：
--     LV4：≥1600返16，≥8500按1%返（上限100）
--     LV5：≥6000返60，≥35000按1%返（上限500）
--   组5-高活跃：
--     LV4：≥3000返30，≥15000按1%返（上限500）
--     LV5：≥15000返150，≥80000按1%返（上限1500）
--
-- NULL处理：
--   LEFT JOIN后无数据为NULL，NULL比较返回NULL（不满足），自动落入下一优先级
-- =============================================================

WITH

-- ============================
-- 第一部分：VIP等级快照
-- ============================
-- 取9.21当天的前端VIP等级，只保留LV4和LV5
-- 同一用户可能有多条记录（多站点），取最高等级
user_level AS (
    SELECT login_name, lv
    FROM (
        SELECT LOWER(TRIM(login_name)) AS login_name, lv,
               ROW_NUMBER() OVER (PARTITION BY LOWER(TRIM(login_name)) ORDER BY lv DESC) AS rn
        FROM superengineproject.dwd_user_bp_lv_3_df
        WHERE pt = '20260921'
    ) t
    WHERE rn = 1
      AND lv IN (4, 5)
),

-- ============================
-- 第二部分：存款行为统计（分组判断用，相对于9.21）
-- ============================

-- 过去30日存款统计（8.23-9.21）
-- 先按用户+日期聚合得到每日存款额，再统计：
--   total_dep_30d = 30日内总存款额
--   dep_days_30d  = 30日内有存款的天数（作为日均分母）
--   avg_dep_30d   = 日均存款 = 总额 / 有存款天数
dep_30d AS (
    SELECT login_name,
           SUM(daily_dep) AS total_dep_30d,
           COUNT(1)       AS dep_days_30d,
           SUM(daily_dep) / COUNT(1) AS avg_dep_30d
    FROM (
        SELECT LOWER(TRIM(login_name)) AS login_name, pt,
               SUM(CAST(deposit_amount AS DOUBLE)) AS daily_dep
        FROM SuperEngineProject.dws_user_deposit_sum_di
        WHERE pt >= '20260823' AND pt <= '20260921'
          AND trans_site_id IN (1,5,6,11,33)
        GROUP BY LOWER(TRIM(login_name)), pt
        HAVING SUM(CAST(deposit_amount AS DOUBLE)) > 0
    ) t
    GROUP BY login_name
),

-- 过去7日存款统计（9.15-9.21）
-- 结构同上，用于判断"断存"（7日无数据=NULL）和"存款下滑"（7日均 < 30日均×50%）
dep_7d AS (
    SELECT login_name,
           SUM(daily_dep) AS total_dep_7d,
           COUNT(1)       AS dep_days_7d,
           SUM(daily_dep) / COUNT(1) AS avg_dep_7d
    FROM (
        SELECT LOWER(TRIM(login_name)) AS login_name, pt,
               SUM(CAST(deposit_amount AS DOUBLE)) AS daily_dep
        FROM SuperEngineProject.dws_user_deposit_sum_di
        WHERE pt >= '20260915' AND pt <= '20260921'
          AND trans_site_id IN (1,5,6,11,33)
        GROUP BY LOWER(TRIM(login_name)), pt
        HAVING SUM(CAST(deposit_amount AS DOUBLE)) > 0
    ) t
    GROUP BY login_name
),

-- ============================
-- 第三部分：投注行为统计（分组判断用，相对于9.21）
-- ============================

-- 过去30日投注统计（8.23-9.21）
-- 结构同存款：日均投注 = 总投注额 / 有投注天数
bet_30d AS (
    SELECT login_name,
           SUM(daily_bet) AS total_bet_30d,
           COUNT(1)       AS bet_days_30d,
           SUM(daily_bet) / COUNT(1) AS avg_bet_30d
    FROM (
        SELECT LOWER(TRIM(login_name)) AS login_name, pt,
               SUM(CAST(totalvalidamount AS DOUBLE)) AS daily_bet
        FROM superengineproject.t_daily_bet_all
        WHERE pt >= '20260823' AND pt <= '20260921'
          AND bet_site_id IN (1,5,6,11,33)
        GROUP BY LOWER(TRIM(login_name)), pt
        HAVING SUM(CAST(totalvalidamount AS DOUBLE)) > 0
    ) t
    GROUP BY login_name
),

-- 过去7日投注统计（9.15-9.21）
-- bet_days_7d 同时用于：
--   ① 判断"投注下滑"（7日日均 < 30日日均×50%）
--   ② 判断"高活跃"（投注天数≥4）
bet_7d AS (
    SELECT login_name,
           SUM(daily_bet) AS total_bet_7d,
           COUNT(1)       AS bet_days_7d,
           SUM(daily_bet) / COUNT(1) AS avg_bet_7d
    FROM (
        SELECT LOWER(TRIM(login_name)) AS login_name, pt,
               SUM(CAST(totalvalidamount AS DOUBLE)) AS daily_bet
        FROM superengineproject.t_daily_bet_all
        WHERE pt >= '20260915' AND pt <= '20260921'
          AND bet_site_id IN (1,5,6,11,33)
        GROUP BY LOWER(TRIM(login_name)), pt
        HAVING SUM(CAST(totalvalidamount AS DOUBLE)) > 0
    ) t
    GROUP BY login_name
),

-- ============================
-- 第四部分：9.21当日GGR（高输值判断用）
-- ============================
-- 改为仅使用9.21当日GGR（非7日累计）
-- GGR>0表示用户输钱（平台赢钱）
-- LV4 当日GGR≥1000 或 LV5 当日GGR≥3000 → 进高输值组
ggr_1d AS (
    SELECT LOWER(TRIM(login_name)) AS login_name,
           SUM(CAST(bingoggr AS DOUBLE)) AS ggr_sum
    FROM superengineproject.t_daily_bet_all
    WHERE pt = '20260921'
      AND bet_site_id IN (1,5,6,11,33)
    GROUP BY LOWER(TRIM(login_name))
),

-- ============================
-- 第五部分：按优先级互斥分组
-- ============================
-- CASE按顺序判断，匹配第一个满足条件即停止 → 天然互斥
-- 被更高优先级捕获的用户不会再出现在低优先级组中
user_group AS (
    SELECT ul.login_name, ul.lv,
        CASE
            -- ① 断存高价值：过去30日有存款记录，但过去7日完全没有存款
            --    d30有数据(IS NOT NULL) + d7无数据(IS NULL) → 近期断存
            WHEN d30.login_name IS NOT NULL
                 AND d7.login_name IS NULL                      THEN 1

            -- ② 存款下滑：7日日均存款 < 30日日均存款 × 50%
            --    分母为各自周期内有存款的天数
            --    若d7或d30为NULL，NULL < value = NULL → 不满足 → 跳过
            WHEN d7.avg_dep_7d < d30.avg_dep_30d * 0.5          THEN 2

            -- ③ 投注下滑：7日日均投注 < 30日日均投注 × 50%
            --    逻辑同存款下滑，换成投注维度
            WHEN b7.avg_bet_7d < b30.avg_bet_30d * 0.5          THEN 3

            -- ④ 高输值：9.21当日GGR达到等级门槛
            --    LV4 ≥ 1000，LV5 ≥ 3000
            --    无投注数据时COALESCE为0，不满足 → 跳过
            WHEN (ul.lv = 4 AND COALESCE(g1.ggr_sum, 0) >= 1000)
              OR (ul.lv = 5 AND COALESCE(g1.ggr_sum, 0) >= 3000) THEN 4

            -- ⑤ 高活跃：过去7日投注天数 ≥ 4天
            WHEN COALESCE(b7.bet_days_7d, 0) >= 4               THEN 5

            -- ⑥ 其余用户保底
            ELSE                                                      6
        END AS grp_id
    FROM user_level ul
    LEFT JOIN dep_30d d30  ON ul.login_name = d30.login_name
    LEFT JOIN dep_7d d7    ON ul.login_name = d7.login_name
    LEFT JOIN bet_30d b30  ON ul.login_name = b30.login_name
    LEFT JOIN bet_7d b7    ON ul.login_name = b7.login_name
    LEFT JOIN ggr_1d g1    ON ul.login_name = g1.login_name
),

-- ============================
-- 第六部分：9.22 预算测算数据
-- ============================
-- 用9.22当天实际发生的存款/投注/GGR估算各组预算成本

-- 9.22 存款（组1断存、组2存款下滑的预算基础）
budget_dep AS (
    SELECT LOWER(TRIM(login_name)) AS login_name,
           SUM(CAST(deposit_amount AS DOUBLE)) AS dep_amt
    FROM SuperEngineProject.dws_user_deposit_sum_di
    WHERE pt = '20260922'
      AND trans_site_id IN (1,5,6,11,33)
    GROUP BY LOWER(TRIM(login_name))
),

-- 9.22 GGR（组4高输值的预算基础：GGR>0时用户输钱，才触发输返）
budget_ggr AS (
    SELECT LOWER(TRIM(login_name)) AS login_name,
           SUM(CAST(bingoggr AS DOUBLE)) AS ggr
    FROM superengineproject.t_daily_bet_all
    WHERE pt = '20260922'
      AND bet_site_id IN (1,5,6,11,33)
    GROUP BY LOWER(TRIM(login_name))
),

-- 9.22 总投注额（组3/5投注达标返、组6保底的预算基础）
budget_bet AS (
    SELECT LOWER(TRIM(login_name)) AS login_name,
           SUM(CAST(totalvalidamount AS DOUBLE)) AS total_bet
    FROM superengineproject.t_daily_bet_all
    WHERE pt = '20260922'
      AND bet_site_id IN (1,5,6,11,33)
    GROUP BY LOWER(TRIM(login_name))
),

-- ============================
-- 第七部分：最终分组 + 返利计算
-- ============================
user_final AS (
    SELECT
        ug.login_name, ug.lv, ug.grp_id,

        -- ---------- 分组名称 ----------
        CASE ug.grp_id
            WHEN 1 THEN '1-断存高价值-存送10%'
            WHEN 2 THEN '2-存款下滑-存送5%'
            WHEN 3 THEN '3-投注下滑-投注达标返'
            WHEN 4 THEN '4-高输值-输返5%'
            WHEN 5 THEN '5-高活跃-投注达标返'
            WHEN 6 THEN '6-保底-投注返1%'
        END AS grp_name,

        -- ---------- 排序号 ----------
        ug.grp_id AS grp_sort,

        -- ---------- 基础金额（9.22，各组含义不同） ----------
        -- 组1/2 = 存款额   组3/5/6 = 投注额   组4 = GGR
        CASE ug.grp_id
            WHEN 1 THEN COALESCE(bd.dep_amt, 0)
            WHEN 2 THEN COALESCE(bd.dep_amt, 0)
            WHEN 3 THEN COALESCE(bb.total_bet, 0)
            WHEN 4 THEN COALESCE(bg.ggr, 0)
            WHEN 5 THEN COALESCE(bb.total_bet, 0)
            WHEN 6 THEN COALESCE(bb.total_bet, 0)
        END AS base_val,

        -- ---------- 返利金额（含上限） ----------
        CASE
            -- ===== 组1：断存高价值 → 存送10% =====
            -- LV5 上限200，LV4 上限50
            WHEN ug.grp_id = 1 THEN
                IF(ug.lv = 5,
                   LEAST(COALESCE(bd.dep_amt, 0) * 0.10, 200),
                   LEAST(COALESCE(bd.dep_amt, 0) * 0.10, 50))

            -- ===== 组2：存款下滑 → 存送5% =====
            -- LV5 上限200，LV4 上限50
            WHEN ug.grp_id = 2 THEN
                IF(ug.lv = 5,
                   LEAST(COALESCE(bd.dep_amt, 0) * 0.05, 200),
                   LEAST(COALESCE(bd.dep_amt, 0) * 0.05, 50))

            -- ===== 组3：投注下滑 → 投注达标返（阶梯） =====
            -- LV5：≥35000 按1%返(上限500)，≥6000 返60，<6000 返0
            -- LV4：≥8500 按1%返(上限100)，≥1600 返16，<1600 返0
            WHEN ug.grp_id = 3 THEN
                IF(ug.lv = 5,
                   CASE
                       WHEN COALESCE(bb.total_bet, 0) >= 35000
                            THEN LEAST(COALESCE(bb.total_bet, 0) * 0.01, 500)
                       WHEN COALESCE(bb.total_bet, 0) >= 6000 THEN 60
                       ELSE 0
                   END,
                   CASE
                       WHEN COALESCE(bb.total_bet, 0) >= 8500
                            THEN LEAST(COALESCE(bb.total_bet, 0) * 0.01, 100)
                       WHEN COALESCE(bb.total_bet, 0) >= 1600 THEN 16
                       ELSE 0
                   END)

            -- ===== 组4：高输值 → 输返5% =====
            -- 仅9.22 GGR > 0（用户当天输钱）时产生返利
            -- LV5 上限500，LV4 上限100
            WHEN ug.grp_id = 4 THEN
                IF(COALESCE(bg.ggr, 0) > 0,
                   IF(ug.lv = 5,
                      LEAST(COALESCE(bg.ggr, 0) * 0.05, 500),
                      LEAST(COALESCE(bg.ggr, 0) * 0.05, 100)),
                   0)

            -- ===== 组5：高活跃 → 投注达标返（阶梯，门槛高于组3） =====
            -- LV5：≥80000 按1%返(上限1500)，≥15000 返150，<15000 返0
            -- LV4：≥15000 按1%返(上限500)，≥3000 返30，<3000 返0
            WHEN ug.grp_id = 5 THEN
                IF(ug.lv = 5,
                   CASE
                       WHEN COALESCE(bb.total_bet, 0) >= 80000
                            THEN LEAST(COALESCE(bb.total_bet, 0) * 0.01, 1500)
                       WHEN COALESCE(bb.total_bet, 0) >= 15000 THEN 150
                       ELSE 0
                   END,
                   CASE
                       WHEN COALESCE(bb.total_bet, 0) >= 15000
                            THEN LEAST(COALESCE(bb.total_bet, 0) * 0.01, 500)
                       WHEN COALESCE(bb.total_bet, 0) >= 3000 THEN 30
                       ELSE 0
                   END)

            -- ===== 组6：保底 → 投注返1% =====
            -- LV5 上限200，LV4 上限50
            ELSE
                IF(ug.lv = 5,
                   LEAST(COALESCE(bb.total_bet, 0) * 0.01, 200),
                   LEAST(COALESCE(bb.total_bet, 0) * 0.01, 50))
        END AS rebate_amt,

        -- ---------- 是否触达返利上限 ----------
        CASE
            -- 组1 存送10%：LV5>200, LV4>50
            WHEN ug.grp_id = 1 AND ug.lv = 5
                 AND COALESCE(bd.dep_amt, 0) * 0.10 > 200     THEN 1
            WHEN ug.grp_id = 1 AND ug.lv = 4
                 AND COALESCE(bd.dep_amt, 0) * 0.10 > 50      THEN 1

            -- 组2 存送5%：LV5>200, LV4>50
            WHEN ug.grp_id = 2 AND ug.lv = 5
                 AND COALESCE(bd.dep_amt, 0) * 0.05 > 200     THEN 1
            WHEN ug.grp_id = 2 AND ug.lv = 4
                 AND COALESCE(bd.dep_amt, 0) * 0.05 > 50      THEN 1

            -- 组3 投注达标返：仅最高档（按1%返）才有上限
            -- LV4：投注≥8500 且 bet×1%>100（即bet>10000）
            WHEN ug.grp_id = 3 AND ug.lv = 4
                 AND COALESCE(bb.total_bet, 0) >= 8500
                 AND COALESCE(bb.total_bet, 0) * 0.01 > 100   THEN 1
            -- LV5：投注≥35000 且 bet×1%>500（即bet>50000）
            WHEN ug.grp_id = 3 AND ug.lv = 5
                 AND COALESCE(bb.total_bet, 0) >= 35000
                 AND COALESCE(bb.total_bet, 0) * 0.01 > 500   THEN 1

            -- 组4 输返5%：LV5>500, LV4>100
            WHEN ug.grp_id = 4 AND ug.lv = 5
                 AND COALESCE(bg.ggr, 0) * 0.05 > 500         THEN 1
            WHEN ug.grp_id = 4 AND ug.lv = 4
                 AND COALESCE(bg.ggr, 0) * 0.05 > 100         THEN 1

            -- 组5 投注达标返：仅最高档才有上限
            -- LV4：投注≥15000 且 bet×1%>500（即bet>50000）
            WHEN ug.grp_id = 5 AND ug.lv = 4
                 AND COALESCE(bb.total_bet, 0) >= 15000
                 AND COALESCE(bb.total_bet, 0) * 0.01 > 500   THEN 1
            -- LV5：投注≥80000 且 bet×1%>1500（即bet>150000）
            WHEN ug.grp_id = 5 AND ug.lv = 5
                 AND COALESCE(bb.total_bet, 0) >= 80000
                 AND COALESCE(bb.total_bet, 0) * 0.01 > 1500  THEN 1

            -- 组6 投注返1%：LV5>200, LV4>50
            WHEN ug.grp_id = 6 AND ug.lv = 5
                 AND COALESCE(bb.total_bet, 0) * 0.01 > 200   THEN 1
            WHEN ug.grp_id = 6 AND ug.lv = 4
                 AND COALESCE(bb.total_bet, 0) * 0.01 > 50    THEN 1

            ELSE 0
        END AS is_capped

    FROM user_group ug
    LEFT JOIN budget_dep bd ON ug.login_name = bd.login_name
    LEFT JOIN budget_ggr bg ON ug.login_name = bg.login_name
    LEFT JOIN budget_bet bb ON ug.login_name = bb.login_name
)

-- ============================
-- 第八部分：汇总输出
-- ============================
-- GROUPING SETS 产生两层：
--   (grp_name, grp_sort, lv) → LV4、LV5 分行
--   (grp_name, grp_sort)     → 每组"总计"行
SELECT
    grp_name                                                        AS 权益类型,
    IF(GROUPING(lv) = 1, '总计', CONCAT('LV', CAST(lv AS STRING))) AS VIP等级,
    COUNT(1)                                                        AS 进组人数,
    SUM(IF(rebate_amt > 0, 1, 0))                                  AS 有效用户数,
    ROUND(SUM(base_val), 2)                                        AS 基础金额合计,
    ROUND(SUM(rebate_amt), 2)                                      AS 预算总额,
    ROUND(AVG(IF(rebate_amt > 0, rebate_amt, NULL)), 2)            AS 有效用户人均,
    SUM(is_capped)                                                  AS 达到上限人数
FROM user_final
GROUP BY grp_name, grp_sort, lv
GROUPING SETS (
    (grp_name, grp_sort, lv),
    (grp_name, grp_sort)
)
ORDER BY
    grp_sort,
    CASE WHEN GROUPING(lv) = 1 THEN 99 ELSE lv END
;
