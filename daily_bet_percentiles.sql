-- 9.25-10.1 每日投注额分位数，以9.25的前端用户等级
-- 维度：日期 × 用户分组（LV1-3, LV4, LV5, LV7-9）
-- 指标：投注额总和、p10/p20/p30/p40/p50/p60/p70/p80/p90/p95/p99/p100投注额、投注人数

WITH
-- 前端等级（9.25快照）
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
        WHERE pt = '20260925'
    ) t
    WHERE rn = 1
),

-- 每日每用户投注额
daily_user_bet AS (
    SELECT
        b.pt,
        LOWER(TRIM(b.login_name)) AS login_name,
        SUM(CAST(b.totalvalidamount AS DOUBLE)) AS daily_bet
    FROM superengineproject.t_daily_bet_all b
    WHERE b.pt >= '20260925' AND b.pt <= '20261001'
      AND b.bet_site_id IN (1,5,6,11,33)
    GROUP BY b.pt, LOWER(TRIM(b.login_name))
    HAVING SUM(CAST(b.totalvalidamount AS DOUBLE)) > 0
),

-- 关联等级并分组
user_bet_grp AS (
    SELECT
        d.pt,
        d.login_name,
        d.daily_bet,
        CASE
            WHEN COALESCE(l.lv, 0) BETWEEN 1 AND 3 THEN 'LV1-3'
            WHEN COALESCE(l.lv, 0) = 4 THEN 'LV4'
            WHEN COALESCE(l.lv, 0) = 5 THEN 'LV5'
            WHEN COALESCE(l.lv, 0) BETWEEN 6 AND 6 THEN 'LV6'
            WHEN COALESCE(l.lv, 0) >= 7 THEN 'LV7-9'
            ELSE 'LV1-3'
        END AS user_group
    FROM daily_user_bet d
    LEFT JOIN user_level l ON d.login_name = l.login_name
)

SELECT
    pt AS 日期,
    user_group AS 用户分组,
    ROUND(SUM(daily_bet), 2) AS 投注额总和,
    ROUND(PERCENTILE_APPROX(daily_bet, 0.10), 2) AS p10投注额,
    ROUND(PERCENTILE_APPROX(daily_bet, 0.20), 2) AS p20投注额,
    ROUND(PERCENTILE_APPROX(daily_bet, 0.30), 2) AS p30投注额,
    ROUND(PERCENTILE_APPROX(daily_bet, 0.40), 2) AS p40投注额,
    ROUND(PERCENTILE_APPROX(daily_bet, 0.50), 2) AS p50投注额,
    ROUND(PERCENTILE_APPROX(daily_bet, 0.60), 2) AS p60投注额,
    ROUND(PERCENTILE_APPROX(daily_bet, 0.70), 2) AS p70投注额,
    ROUND(PERCENTILE_APPROX(daily_bet, 0.80), 2) AS p80投注额,
    ROUND(PERCENTILE_APPROX(daily_bet, 0.90), 2) AS p90投注额,
    ROUND(PERCENTILE_APPROX(daily_bet, 0.95), 2) AS p95投注额,
    ROUND(PERCENTILE_APPROX(daily_bet, 0.99), 2) AS p99投注额,
    ROUND(MAX(daily_bet), 2) AS p100投注额,
    COUNT(1) AS 投注人数
FROM user_bet_grp
GROUP BY pt, user_group
ORDER BY pt, user_group
;
