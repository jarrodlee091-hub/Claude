-- =============================================================
-- S级活动核销用户分析（活动时间 9.11-9.24）
-- 人群：活动期间核销过15个S级活动任意一个的用户
-- 分组：用户集团等级 × 输赢情况（活动期间GGR）
-- 输赢：活动期GGR>0 用户输；GGR<=0（含0/无投注）用户赢
--
-- 指标：
--   核销人数               = S级核销用户数
--   S级核销总金额          = 9.11-9.24 15个S级活动核销金额
--   平台总核销金额         = 这批用户 9.11-9.24 在平台全部活动的核销金额
--   S级核销占比            = S级核销总金额 / 平台总核销金额
--   活动期GGR              = 9.11-9.24 GGR合计
--   活动前GGR              = 9.1-9.10 GGR合计
--   活动前平台总核销金额   = 这批用户 9.1-9.10 在平台全部活动的核销金额
--
-- 核销表：
--   superengineproject.bi_dwd_all_promo_user_redeem_info_di
--   核销金额 = redeem_amount
--   仅统计有效核销 is_valid_redeem = 1
--
-- 站点：投注 1,5,6,11,33
-- =============================================================

WITH

-- =============================================================
-- 1. 15个S级活动核销
-- 活动期：9.11-9.24
-- 按用户聚合
-- =============================================================
redeem_agg AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,

        -- 15个S级活动活动期核销总金额
        SUM(CAST(redeem_amount AS DOUBLE)) AS total_redeem

    FROM superengineproject.bi_dwd_all_promo_user_redeem_info_di

    WHERE pt >= '20260911'
      AND pt <= '20260924'

      -- 仅统计有效核销
      AND is_valid_redeem = 1

      -- 如需限制预算来源，可打开以下条件
      AND budget_source_product_line IN ('BP', 'COMMUNITY', 'VIBER')

      -- 15个S级活动
      AND activity_id IN (
          '6aa103bbe4b07fc7051c16be',
          '6aa10b8be4b07fc726c4c142',
          '6aa10478e4b07fc755e79ad2',
          '6aa10c70e4b07fc77262a6dc',
          '6aa1054ce4b07fc7051c2255',
          '6aa10d5de4b07fc7c517568f',
          '6aa10698e4b07fc7051c28a2',
          '6aa10e47e4b07fc7436a8057',
          '6aa10730e4b07fc7e0cb951c',
          '6aa10f22e4b07fc7c517676a',
          '6aa107afe4b07fc7e0cb974a',
          '6aa1101be4b07fc742522dd2',
          '6aa125ace4b07fc7dccce891',
          '6aa114bfe4b07fc759b3f4c2',
          '6aa11550e4b07fc749ab00b9'
      )

    GROUP BY LOWER(TRIM(login_name))
),

-- =============================================================
-- 2. 平台全部活动核销
-- 活动期：9.11-9.24
-- 活动前：9.1-9.10
-- =============================================================
redeem_all AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,

        -- 活动期平台全部活动核销
        SUM(
            IF(
                pt >= '20260911',
                CAST(redeem_amount AS DOUBLE),
                0
            )
        ) AS all_redeem,

        -- 活动前平台全部活动核销
        SUM(
            IF(
                pt <= '20260910',
                CAST(redeem_amount AS DOUBLE),
                0
            )
        ) AS all_redeem_pre

    FROM superengineproject.bi_dwd_all_promo_user_redeem_info_di

    WHERE pt >= '20260901'
      AND pt <= '20260924'

      -- 仅统计有效核销
      AND is_valid_redeem = 1

      AND budget_source_product_line IN ('BP', 'COMMUNITY', 'VIBER')

    GROUP BY LOWER(TRIM(login_name))
),

-- =============================================================
-- 3. 集团用户等级
-- 取最新快照（pt最大值）
-- 同一用户多条记录时取最新pt
-- =============================================================
user_level AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        level_current
    FROM dgsg_prod.dws_coo_user_detail_metrics_ext_di
    WHERE business_line = 'BP'
      AND pt = MAX_PT('dgsg_prod.dws_coo_user_detail_metrics_ext_di')
),

-- =============================================================
-- 4. GGR
-- 活动期：9.11-9.24
-- 活动前：9.1-9.10
-- 站点：1,5,6,11,33
-- =============================================================
ggr_agg AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,

        -- 活动期 GGR
        SUM(
            IF(
                pt >= '20260911',
                CAST(bingoggr AS DOUBLE),
                0
            )
        ) AS ggr_act,

        -- 活动前 GGR
        SUM(
            IF(
                pt <= '20260910',
                CAST(bingoggr AS DOUBLE),
                0
            )
        ) AS ggr_pre

    FROM superengineproject.t_daily_bet_all

    WHERE pt >= '20260901'
      AND pt <= '20260924'
      AND bet_site_id IN (1,5,6,11,33)

    GROUP BY LOWER(TRIM(login_name))
),

-- =============================================================
-- 5. 用户明细
-- S级核销用户 + 集团等级 + 平台核销 + GGR + 输赢
-- =============================================================
user_detail AS (
    SELECT
        r.login_name,

        -- 集团等级
        COALESCE(
            CONCAT('LV', CAST(l.level_current AS STRING)),
            '无等级'
        ) AS lv_name,

        -- 等级排序
        COALESCE(l.level_current, -1) AS lv_sort,

        -- S级活动核销金额
        r.total_redeem AS s_redeem,

        -- 活动期平台全部核销
        COALESCE(a.all_redeem, 0) AS all_redeem,

        -- 活动前平台全部核销
        COALESCE(a.all_redeem_pre, 0) AS all_redeem_pre,

        -- 活动期 GGR
        COALESCE(g.ggr_act, 0) AS ggr_act,

        -- 活动前 GGR
        COALESCE(g.ggr_pre, 0) AS ggr_pre,

        -- =====================================================
        -- 输赢定义：
        -- GGR > 0  = 用户输
        -- GGR <= 0 = 用户赢
        -- 包含 GGR = 0、无投注用户
        -- =====================================================
        IF(
            COALESCE(g.ggr_act, 0) > 0,
            '1-输',
            '2-赢'
        ) AS win_lose

    FROM redeem_agg r

    LEFT JOIN user_level l
        ON r.login_name = l.login_name

    LEFT JOIN redeem_all a
        ON r.login_name = a.login_name

    LEFT JOIN ggr_agg g
        ON r.login_name = g.login_name
)

-- =============================================================
-- 6. 汇总
-- 维度：集团等级 × 输赢
-- 另外增加总计
-- =============================================================
SELECT

    IF(
        GROUPING(lv_name) = 1,
        '全部',
        lv_name
    ) AS 集团等级,

    IF(
        GROUPING(win_lose) = 1,
        '全部',
        win_lose
    ) AS 输赢情况,

    -- S级核销用户数
    COUNT(1) AS 核销人数,

    -- S级活动核销总金额
    ROUND(
        SUM(s_redeem),
        2
    ) AS S级核销总金额,

    -- 平台全部活动核销总金额
    ROUND(
        SUM(all_redeem),
        2
    ) AS 平台总核销金额,

    -- S级核销金额 / 平台总核销金额
    ROUND(
        SUM(s_redeem) / SUM(all_redeem),
        4
    ) AS S级核销占比,

    -- 人均S级核销
    ROUND(
        SUM(s_redeem) / COUNT(1),
        2
    ) AS 人均S级核销,

    -- 活动期GGR
    ROUND(
        SUM(ggr_act),
        2
    ) AS 活动期GGR_0911_0924,

    -- 活动前GGR
    ROUND(
        SUM(ggr_pre),
        2
    ) AS 活动前GGR_0901_0910,

    -- 人均活动期GGR
    ROUND(
        SUM(ggr_act) / COUNT(1),
        2
    ) AS 人均活动期GGR,

    -- 人均活动前GGR
    ROUND(
        SUM(ggr_pre) / COUNT(1),
        2
    ) AS 人均活动前GGR,

    -- 活动前平台总核销
    ROUND(
        SUM(all_redeem_pre),
        2
    ) AS 活动前平台总核销_0901_0910

FROM user_detail

GROUP BY
    lv_name,
    lv_sort,
    win_lose

GROUPING SETS (
    -- 等级 × 输赢
    (lv_name, lv_sort, win_lose),

    -- 总计
    ()
)

ORDER BY

    -- LV1 → LV9 → 全部
    CASE
        WHEN GROUPING(lv_name) = 1 THEN 99
        ELSE lv_sort
    END,

    -- 输 → 赢 → 全部
    CASE
        WHEN GROUPING(win_lose) = 1 THEN '9'
        ELSE win_lose
    END
;
