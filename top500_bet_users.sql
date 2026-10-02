-- 9.25-10.1 TOP 500 投注额用户
-- 指标：投注额、GGR、存款、取款、投注天数
-- 按投注总额降序排序

SELECT
    ROW_NUMBER() OVER (ORDER BY SUM(CAST(bet_amount AS DOUBLE)) DESC) AS 排名,
    LOWER(TRIM(login_name)) AS 用户,
    ROUND(SUM(CAST(bet_amount AS DOUBLE)), 2) AS 投注,
    ROUND(SUM(CAST(bingoggr AS DOUBLE)), 2) AS GGR,
    ROUND(SUM(CAST(deposit AS DOUBLE)), 2) AS 存款,
    ROUND(SUM(CAST(withdraw AS DOUBLE)), 2) AS 取款,
    COUNT(DISTINCT pt) AS 投注天数
FROM superengineproject.t_daily_bet_all
WHERE pt >= '20260925' AND pt <= '20261001'
  AND bet_site_id IN (1,5,6,11,33)
GROUP BY LOWER(TRIM(login_name))
ORDER BY 投注 DESC
LIMIT 500
;
