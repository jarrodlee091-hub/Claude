-- 10个用户的任务发放与核销查询
-- 任务活动ID: 12个
-- 活动周期: 9.11-9.24

WITH users AS (
    SELECT *
    FROM (
        VALUES
        ('bingoplusiopp7r'),
        ('bingoplusdie9sw'),
        ('bingoplus82jsse'),
        ('bingoplus5n2bz4'),
        ('bingoplus5noqhn'),
        ('bingoplusb8hjkb'),
        ('lpmlph9u2'),
        ('bingoplusv7va4v'),
        ('lpzxgzppo'),
        ('bingoplus6v1bai')
    ) t (login_name)
),

-- VIP等级
vip AS (
    SELECT login_name, level_current
    FROM (
        SELECT
            LOWER(TRIM(login_name)) AS login_name,
            level_current,
            ROW_NUMBER() OVER (PARTITION BY LOWER(TRIM(login_name)) ORDER BY pt DESC) AS rn
        FROM dgsg_prod.dws_coo_user_detail_metrics_ext_di
        WHERE business_line = 'BP'
          AND pt >= '20260901'
    ) t
    WHERE rn = 1
),

-- 任务发放金额
task_release AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        SUM(voucher_amount) AS task_release_amount
    FROM superengineproject.dwd_mms_user_release_info_di
    WHERE pt >= '20260911' AND pt <= '20260924'
      AND activity_id IN (
        '6aa103bbe4b07fc7051c16be','6aa10b8be4b07fc726c4c142',
        '6aa10478e4b07fc755e79ad2','6aa10c70e4b07fc77262a6dc',
        '6aa1054ce4b07fc7051c2255','6aa10d5de4b07fc7c517568f',
        '6aa10698e4b07fc7051c28a2','6aa10e47e4b07fc7436a8057',
        '6aa10730e4b07fc7e0cb951c','6aa10f22e4b07fc7c517676a',
        '6aa107afe4b07fc7e0cb974a','6aa1101be4b07fc742522dd2'
      )
    GROUP BY LOWER(TRIM(login_name))
),

-- 任务核销金额
task_redeem AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        SUM(CAST(redeem_amount AS DOUBLE)) AS task_redeem_amount
    FROM superengineproject.bi_dwd_all_promo_user_redeem_info_di
    WHERE pt >= '20260911' AND pt <= '20260924'
      AND is_valid_redeem = 1
      AND budget_source_product_line IN ('BP', 'VIBER', 'COMMUNITY')
      AND activity_id IN (
        '6aa103bbe4b07fc7051c16be','6aa10b8be4b07fc726c4c142',
        '6aa10478e4b07fc755e79ad2','6aa10c70e4b07fc77262a6dc',
        '6aa1054ce4b07fc7051c2255','6aa10d5de4b07fc7c517568f',
        '6aa10698e4b07fc7051c28a2','6aa10e47e4b07fc7436a8057',
        '6aa10730e4b07fc7e0cb951c','6aa10f22e4b07fc7c517676a',
        '6aa107afe4b07fc7e0cb974a','6aa1101be4b07fc742522dd2'
      )
    GROUP BY LOWER(TRIM(login_name))
)

SELECT
    /*+MAPJOIN(u)*/
    u.login_name,
    v.level_current                  AS vip_level,
    tr.task_release_amount,
    td.task_redeem_amount
FROM users u
LEFT JOIN vip v ON u.login_name = v.login_name
LEFT JOIN task_release tr ON u.login_name = tr.login_name
LEFT JOIN task_redeem td ON u.login_name = td.login_name
;
