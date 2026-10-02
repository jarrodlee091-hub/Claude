-- 9.2-9.8 按前端等级分组的7日累计投注额分位数与GGR分位数
-- 前端等级以9.2快照为准
-- 用户分组：LV1-3, LV4, LV5, LV6-9

WITH
-- 前端等级（9.2快照）
user_level AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        lv
    FROM (
        SELECT
            LOWER(TRIM(login_name)) AS login_name,
            lv,
            ROW_NUMBER() OVER (
                PARTITION BY LOWER(TRIM(login_name))
                ORDER BY lv DESC
            ) AS rn
        FROM superengineproject.dwd_user_bp_lv_3_df
        WHERE pt = '20260902'
    ) t
    WHERE rn = 1
),

-- 每用户7日累计投注额和GGR
user_agg AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        SUM(CAST(totalvalidamount AS DOUBLE)) AS total_bet,
        SUM(CAST(bingoggr AS DOUBLE)) AS total_ggr
    FROM superengineproject.t_daily_bet_all
    WHERE pt >= '20260902' AND pt <= '20260908'
      AND bet_site_id IN (1,5,6,11,33)
    GROUP BY LOWER(TRIM(login_name))
    HAVING SUM(CAST(totalvalidamount AS DOUBLE)) > 0
),

-- 关联等级并分组
user_data AS (
    SELECT
        u.login_name,
        u.total_bet,
        u.total_ggr,
        CASE
            WHEN COALESCE(l.lv, 0) BETWEEN 1 AND 3 THEN 'LV1-3'
            WHEN COALESCE(l.lv, 0) = 4 THEN 'LV4'
            WHEN COALESCE(l.lv, 0) = 5 THEN 'LV5'
            WHEN COALESCE(l.lv, 0) >= 6 THEN 'LV6-9'
            ELSE 'LV1-3'
        END AS user_group
    FROM user_agg u
    LEFT JOIN user_level l ON u.login_name = l.login_name
)

-- ============================================================
-- 第一部分：投注额分位数
-- ============================================================
SELECT
    '2026-09-02 ~ 2026-09-08' AS 日期,
    user_group AS 用户分组,
    ROUND(SUM(total_bet), 2) AS 投注额总和,
    ROUND(PERCENTILE_APPROX(total_bet, 0.10), 2) AS p10投注额,
    ROUND(PERCENTILE_APPROX(total_bet, 0.20), 2) AS p20投注额,
    ROUND(PERCENTILE_APPROX(total_bet, 0.30), 2) AS p30投注额,
    ROUND(PERCENTILE_APPROX(total_bet, 0.40), 2) AS p40投注额,
    ROUND(PERCENTILE_APPROX(total_bet, 0.50), 2) AS p50投注额,
    ROUND(PERCENTILE_APPROX(total_bet, 0.60), 2) AS p60投注额,
    ROUND(PERCENTILE_APPROX(total_bet, 0.70), 2) AS p70投注额,
    ROUND(PERCENTILE_APPROX(total_bet, 0.80), 2) AS p80投注额,
    ROUND(PERCENTILE_APPROX(total_bet, 0.90), 2) AS p90投注额,
    ROUND(PERCENTILE_APPROX(total_bet, 0.95), 2) AS p95投注额,
    ROUND(PERCENTILE_APPROX(total_bet, 0.99), 2) AS p99投注额,
    ROUND(MAX(total_bet), 2) AS p100投注额,
    COUNT(1) AS 投注人数
FROM user_data
GROUP BY user_group
ORDER BY user_group
;

-- ============================================================
-- 第二部分：GGR分位数 + 输赢统计
-- ============================================================
SELECT
    '2026-09-02 ~ 2026-09-08' AS 日期,
    user_group AS 用户分组,
    ROUND(SUM(total_ggr), 2) AS GGR,
    ROUND(PERCENTILE_APPROX(total_ggr, 0.10), 2) AS p10用户GGR,
    ROUND(PERCENTILE_APPROX(total_ggr, 0.20), 2) AS p20用户GGR,
    ROUND(PERCENTILE_APPROX(total_ggr, 0.30), 2) AS p30用户GGR,
    ROUND(PERCENTILE_APPROX(total_ggr, 0.40), 2) AS p40用户GGR,
    ROUND(PERCENTILE_APPROX(total_ggr, 0.50), 2) AS p50用户GGR,
    ROUND(PERCENTILE_APPROX(total_ggr, 0.60), 2) AS p60用户GGR,
    ROUND(PERCENTILE_APPROX(total_ggr, 0.70), 2) AS p70用户GGR,
    ROUND(PERCENTILE_APPROX(total_ggr, 0.80), 2) AS p80用户GGR,
    ROUND(PERCENTILE_APPROX(total_ggr, 0.90), 2) AS p90用户GGR,
    ROUND(PERCENTILE_APPROX(total_ggr, 0.95), 2) AS p95用户GGR,
    ROUND(PERCENTILE_APPROX(total_ggr, 0.99), 2) AS p99用户GGR,
    ROUND(MAX(total_ggr), 2) AS p100用户GGR,
    SUM(CASE WHEN total_ggr > 0 THEN 1 ELSE 0 END) AS 输家人数,
    ROUND(SUM(CASE WHEN total_ggr > 0 THEN total_ggr ELSE 0 END), 2) AS 输家GGR,
    SUM(CASE WHEN total_ggr <= 0 THEN 1 ELSE 0 END) AS 赢家人数,
    ROUND(SUM(CASE WHEN total_ggr <= 0 THEN total_ggr ELSE 0 END), 2) AS 赢家GGR
FROM user_data
GROUP BY user_group
ORDER BY user_group
;
