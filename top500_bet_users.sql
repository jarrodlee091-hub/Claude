-- 9.25-10.1 TOP 500 投注额用户
-- 指标：投注额、GGR、存款、取款、投注天数
-- 按投注总额降序排序

WITH
-- 投注 & GGR
bet AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        ROUND(SUM(CAST(totalvalidamount AS DOUBLE)), 2) AS bet_amount,
        ROUND(SUM(CAST(bingoggr AS DOUBLE)), 2) AS ggr,
        COUNT(DISTINCT pt) AS bet_days
    FROM superengineproject.t_daily_bet_all
    WHERE pt >= '20260925' AND pt <= '20261001'
      AND bet_site_id IN (1,5,6,11,33)
    GROUP BY LOWER(TRIM(login_name))
    HAVING SUM(CAST(totalvalidamount AS DOUBLE)) > 0
),

-- 存款
dep AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        ROUND(SUM(CAST(deposit_amount AS DOUBLE)), 2) AS deposit_amount
    FROM SuperEngineProject.dws_user_deposit_sum_di
    WHERE pt >= '20260925' AND pt <= '20261001'
      AND trans_site_id IN (1,5,6,11,33)
    GROUP BY LOWER(TRIM(login_name))
),

-- 取款
wdr AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        ROUND(SUM(CAST(amount AS DOUBLE)), 2) AS withdraw_amount
    FROM superengineproject.dwd_c66_withdrawal_requests_i_d
    WHERE pt >= '20260925' AND pt <= '20261001'
      AND trans_site_id IN (1,5,6,11,33)
      AND flag = 2
    GROUP BY LOWER(TRIM(login_name))
),

-- 大富翁地图核销（两个活动合并）
map_redeem AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        ROUND(SUM(CAST(redeem_amount AS DOUBLE)), 2) AS map_redeem_amount
    FROM superengineproject.bi_dwd_all_promo_user_redeem_info_di
    WHERE pt >= '20260925' AND pt <= '20261001'
      AND is_valid_redeem = 1
      AND budget_source_product_line IN ('BP', 'COMMUNITY', 'VIBER')
      AND activity_id IN ('6aa125ace4b07fc7dccce891', '6aa114bfe4b07fc759b3f4c2')
    GROUP BY LOWER(TRIM(login_name))
)

SELECT
    ROW_NUMBER() OVER (ORDER BY b.bet_amount DESC) AS 排名,
    b.login_name AS 用户,
    b.bet_amount AS 投注,
    b.ggr AS GGR,
    d.deposit_amount AS 存款,
    w.withdraw_amount AS 取款,
    b.bet_days AS 投注天数,
    mr.map_redeem_amount AS 核销大富翁地图金额
FROM bet b
LEFT JOIN dep d ON b.login_name = d.login_name
LEFT JOIN wdr w ON b.login_name = w.login_name
LEFT JOIN map_redeem mr ON b.login_name = mr.login_name
ORDER BY b.bet_amount DESC
LIMIT 500
;
