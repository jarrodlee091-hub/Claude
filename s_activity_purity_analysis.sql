-- =============================================================
-- S级活动核销用户 × 纯净度梯度分析
-- 人群：9.11-9.24核销过15个S级活动任意一个的用户
-- 纯净度 = 9.11-9.24 大富翁核销 / 同期全站核销
-- 分组：集团VIP等级 × 纯净度梯队（区间左开右闭）
-- =============================================================

WITH

-- 15个S级活动核销（用户级）
redeem_agg AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        SUM(CAST(redeem_amount AS DOUBLE)) AS s_redeem
    FROM superengineproject.bi_dwd_all_promo_user_redeem_info_di
    WHERE pt >= '20260911' AND pt <= '20260924'
      AND is_valid_redeem = 1
      AND budget_source_product_line IN ('BP', 'COMMUNITY', 'VIBER')
      AND activity_id IN (
          '6aa103bbe4b07fc7051c16be','6aa10b8be4b07fc726c4c142',
          '6aa10478e4b07fc755e79ad2','6aa10c70e4b07fc77262a6dc',
          '6aa1054ce4b07fc7051c2255','6aa10d5de4b07fc7c517568f',
          '6aa10698e4b07fc7051c28a2','6aa10e47e4b07fc7436a8057',
          '6aa10730e4b07fc7e0cb951c','6aa10f22e4b07fc7c517676a',
          '6aa107afe4b07fc7e0cb974a','6aa1101be4b07fc742522dd2',
          '6aa125ace4b07fc7dccce891','6aa114bfe4b07fc759b3f4c2',
          '6aa11550e4b07fc749ab00b9'
      )
    GROUP BY LOWER(TRIM(login_name))
),

-- 平台全部核销（活动前 + 活动期）
redeem_all AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        SUM(IF(pt >= '20260911', CAST(redeem_amount AS DOUBLE), 0)) AS all_redeem,
        SUM(IF(pt <= '20260910', CAST(redeem_amount AS DOUBLE), 0)) AS all_redeem_pre
    FROM superengineproject.bi_dwd_all_promo_user_redeem_info_di
    WHERE pt >= '20260901' AND pt <= '20260924'
      AND is_valid_redeem = 1
      AND budget_source_product_line IN ('BP', 'COMMUNITY', 'VIBER')
    GROUP BY LOWER(TRIM(login_name))
),

-- 集团等级
user_level AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        level_current
    FROM dgsg_prod.dws_coo_user_detail_metrics_ext_di
    WHERE business_line = 'BP'
      AND pt = MAX_PT('dgsg_prod.dws_coo_user_detail_metrics_ext_di')
),

-- GGR（活动前 + 活动期）
ggr_agg AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        SUM(IF(pt >= '20260911', CAST(bingoggr AS DOUBLE), 0)) AS ggr_act,
        SUM(IF(pt <= '20260910', CAST(bingoggr AS DOUBLE), 0)) AS ggr_pre
    FROM superengineproject.t_daily_bet_all
    WHERE pt >= '20260901' AND pt <= '20260924'
      AND bet_site_id IN (1,5,6,11,33)
    GROUP BY LOWER(TRIM(login_name))
),

-- 用户明细 + 纯净度计算
user_detail AS (
    SELECT
        r.login_name,

        COALESCE(CONCAT('V', CAST(l.level_current AS STRING)), '无等级') AS vip_level,
        COALESCE(l.level_current, -1) AS vip_sort,

        r.s_redeem,
        COALESCE(a.all_redeem, 0) AS all_redeem,
        COALESCE(a.all_redeem_pre, 0) AS all_redeem_pre,
        COALESCE(g.ggr_act, 0) AS ggr_act,
        COALESCE(g.ggr_pre, 0) AS ggr_pre,

        -- 纯净度 = 大富翁核销 / 全站核销
        CASE
            WHEN COALESCE(a.all_redeem, 0) > 0
                THEN r.s_redeem / a.all_redeem
            ELSE 1.0
        END AS purity,

        -- 纯净度梯队（左开右闭）
        CASE
            WHEN COALESCE(a.all_redeem, 0) <= 0              THEN '0-20%'
            WHEN r.s_redeem / a.all_redeem <= 0.20            THEN '0-20%'
            WHEN r.s_redeem / a.all_redeem <= 0.40            THEN '20-40%'
            WHEN r.s_redeem / a.all_redeem <= 0.60            THEN '40-60%'
            WHEN r.s_redeem / a.all_redeem <= 0.80            THEN '60-80%'
            ELSE                                                   '80-100%'
        END AS purity_tier,

        CASE
            WHEN COALESCE(a.all_redeem, 0) <= 0              THEN 1
            WHEN r.s_redeem / a.all_redeem <= 0.20            THEN 1
            WHEN r.s_redeem / a.all_redeem <= 0.40            THEN 2
            WHEN r.s_redeem / a.all_redeem <= 0.60            THEN 3
            WHEN r.s_redeem / a.all_redeem <= 0.80            THEN 4
            ELSE                                                   5
        END AS purity_sort

    FROM redeem_agg r
    LEFT JOIN user_level l   ON r.login_name = l.login_name
    LEFT JOIN redeem_all a   ON r.login_name = a.login_name
    LEFT JOIN ggr_agg g      ON r.login_name = g.login_name
)

SELECT
    IF(GROUPING(vip_level) = 1, '全部', vip_level) AS VIP层级,

    IF(GROUPING(purity_tier) = 1, '合计', purity_tier) AS 纯净度梯队,

    COUNT(1) AS 人数,

    ROUND(SUM(ggr_pre), 2) AS "9.1-9.10 GGR",
    ROUND(SUM(all_redeem_pre), 2) AS "9.1-9.10 核销总额",
    ROUND(SUM(ggr_act), 2) AS "9.11-9.24 GGR",
    ROUND(SUM(all_redeem), 2) AS "9.11-9.24 核销总额",
    ROUND(SUM(s_redeem), 2) AS "9.11-9.24 大富翁核销总额"

FROM user_detail

GROUP BY
    vip_level, vip_sort,
    purity_tier, purity_sort

GROUPING SETS (
    (vip_level, vip_sort, purity_tier, purity_sort),
    (vip_level, vip_sort),
    ()
)

ORDER BY
    CASE WHEN GROUPING(vip_level) = 1 THEN 99 ELSE vip_sort END,
    CASE WHEN GROUPING(purity_tier) = 1 THEN 0 ELSE purity_sort END
;
