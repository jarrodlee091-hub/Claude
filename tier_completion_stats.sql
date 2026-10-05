-- =============================================================
-- 9.2-9.8 各用户分组阶梯投注门槛完成人数
-- 前端等级：9.2快照
-- 分组：LV1-3, LV4, LV5
-- 完成高档的用户同时计入低档
-- =============================================================

WITH
user_level AS (
    SELECT login_name, lv
    FROM (
        SELECT
            LOWER(TRIM(login_name)) AS login_name, lv,
            ROW_NUMBER() OVER (PARTITION BY LOWER(TRIM(login_name)) ORDER BY lv DESC) AS rn
        FROM superengineproject.dwd_user_bp_lv_3_df
        WHERE pt = '20260902'
    ) t WHERE rn = 1
),

user_bet AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        SUM(CAST(totalvalidamount AS DOUBLE)) AS total_bet
    FROM superengineproject.t_daily_bet_all
    WHERE pt >= '20260902' AND pt <= '20260908'
      AND bet_site_id IN (1,5,6,11,33)
    GROUP BY LOWER(TRIM(login_name))
    HAVING SUM(CAST(totalvalidamount AS DOUBLE)) > 0
),

user_data AS (
    SELECT
        b.login_name,
        b.total_bet,
        CASE
            WHEN COALESCE(l.lv, 0) BETWEEN 1 AND 3 THEN 'LV1-3'
            WHEN COALESCE(l.lv, 0) = 4              THEN 'LV4'
            WHEN COALESCE(l.lv, 0) = 5              THEN 'LV5'
            ELSE 'LV1-3'
        END AS user_group
    FROM user_bet b
    LEFT JOIN user_level l ON b.login_name = l.login_name
    WHERE COALESCE(l.lv, 0) <= 5
),

tiers AS (
    SELECT 1 AS tier_sort, '第一档' AS tier_name,
           500    AS t13,  4  AS r13, '0.80%' AS p13,
           7000   AS t4,  70  AS r4,  '1.00%' AS p4,
           30000  AS t5, 300  AS r5,  '1.00%' AS p5
    UNION ALL
    SELECT 2, '第二档',
           1500,   8, '0.80%',
           15000, 80, '1.00%',
           80000, 500, '1.00%'
    UNION ALL
    SELECT 3, '第三档',
           3000,   15, '0.77%',
           30000, 180, '0.87%',
           150000, 1000, '1.00%'
    UNION ALL
    SELECT 4, '第四档',
           7000,   35, '0.71%',
           70000, 350, '0.76%',
           250000, 0, '0.40%'
    UNION ALL
    SELECT 5, '第五档',
           15000,  65, '0.67%',
           120000, 500, '0.71%',
           450000, 0, '0.00%'
)

SELECT
    t.tier_name                                                    AS 阶梯档位,

    t.t13                                                          AS "LV1-3 累计门槛",
    t.r13                                                          AS "LV1-3 返水金",
    t.p13                                                          AS "LV1-3 投返比",
    SUM(IF(u.user_group = 'LV1-3' AND u.total_bet >= t.t13, 1, 0)) AS "LV1-3 完成人数",

    t.t4                                                           AS "LV4 累计门槛",
    t.r4                                                           AS "LV4 返水金",
    t.p4                                                           AS "LV4 投返比",
    SUM(IF(u.user_group = 'LV4'   AND u.total_bet >= t.t4,  1, 0)) AS "LV4 完成人数",

    t.t5                                                           AS "LV5 累计门槛",
    t.r5                                                           AS "LV5 返水金",
    t.p5                                                           AS "LV5 投返比",
    SUM(IF(u.user_group = 'LV5'   AND u.total_bet >= t.t5,  1, 0)) AS "LV5 完成人数"

FROM user_data u
CROSS JOIN tiers t
GROUP BY
    t.tier_sort, t.tier_name,
    t.t13, t.r13, t.p13,
    t.t4,  t.r4,  t.p4,
    t.t5,  t.r5,  t.p5
ORDER BY t.tier_sort
;
