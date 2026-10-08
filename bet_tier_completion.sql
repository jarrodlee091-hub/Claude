-- =============================================================
-- 9.30-10.6 投注送：按集团VIP等级分组统计各档位达标人数
-- 集团等级：V0-3, V4-5
-- 投注门槛为7天累计，4个档位，高档达标用户同时计入低档
-- =============================================================

WITH
thresholds AS (
    SELECT 'V0-3' AS lv_grp, 1 AS sort_lv,
           4000 AS t1, 10000 AS t2, 30000 AS t3, 60000 AS t4
    UNION ALL
    SELECT 'V4-5', 2,
           40000, 100000, 600000, 1000000
),

vip AS (
    SELECT login_name, level_current
    FROM (
        SELECT
            LOWER(TRIM(login_name)) AS login_name,
            level_current,
            ROW_NUMBER() OVER (PARTITION BY LOWER(TRIM(login_name)) ORDER BY level_current DESC) AS rn
        FROM dgsg_prod.dws_coo_user_detail_metrics_ext_di
        WHERE business_line = 'BP'
          AND pt = MAX_PT('dgsg_prod.dws_coo_user_detail_metrics_ext_di')
    ) t
    WHERE rn = 1
),

bet AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        SUM(CAST(totalvalidamount AS DOUBLE)) AS bet_amt
    FROM superengineproject.t_daily_bet_all
    WHERE pt >= '20260930' AND pt <= '20261006'
      AND bet_site_id IN (1,5,6,11,33)
    GROUP BY LOWER(TRIM(login_name))
    HAVING SUM(CAST(totalvalidamount AS DOUBLE)) > 0
),

user_tier AS (
    SELECT /*+MAPJOIN(th)*/
        b.login_name, b.bet_amt, th.lv_grp, th.sort_lv,
        CASE
            WHEN b.bet_amt >= th.t4 THEN 4
            WHEN b.bet_amt >= th.t3 THEN 3
            WHEN b.bet_amt >= th.t2 THEN 2
            WHEN b.bet_amt >= th.t1 THEN 1
            ELSE 0
        END AS tier
    FROM bet b
    JOIN vip v ON v.login_name = b.login_name
    JOIN thresholds th
        ON th.lv_grp = CASE
            WHEN v.level_current IN ('V0','V1','V2','V3') THEN 'V0-3'
            WHEN v.level_current IN ('V4','V5')            THEN 'V4-5'
        END
    WHERE v.level_current IN ('V0','V1','V2','V3','V4','V5')
)

SELECT
    lv_grp                                    AS 等级分组,
    COUNT(*)                                  AS 投注人数,
    ROUND(SUM(bet_amt), 2)                    AS 投注总额,
    SUM(IF(tier >= 1, 1, 0))                  AS 档位1达标人数,
    SUM(IF(tier >= 2, 1, 0))                  AS 档位2达标人数,
    SUM(IF(tier >= 3, 1, 0))                  AS 档位3达标人数,
    SUM(IF(tier >= 4, 1, 0))                  AS 档位4达标人数
FROM user_tier
GROUP BY lv_grp, sort_lv
ORDER BY sort_lv
;
