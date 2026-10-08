-- 10.7 10:00至今 有效投注额超过3000W的用户
-- 表：superengineproject.dwd_order_detail_basic_di
-- 结算时间：reckontime >= '2026-10-07 10:00:00'
-- flag=1, bet_site_id IN (1,5,6,11,33)

SELECT
    LOWER(TRIM(login_name))                          AS 用户,
    ROUND(SUM(CAST(valid_account AS DOUBLE)), 2)     AS 有效投注总额
FROM superengineproject.dwd_order_detail_basic_di
WHERE pt >= '20261007'
  AND reckontime >= '2026-10-07 10:00:00'
  AND bet_site_id IN (1,5,6,11,33)
  AND flag = 1
GROUP BY LOWER(TRIM(login_name))
HAVING SUM(CAST(valid_account AS DOUBLE)) >= 30000000
ORDER BY 有效投注总额 DESC
;
