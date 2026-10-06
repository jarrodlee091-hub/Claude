-- =============================================================
-- 9.29-10.5 PayMaya存款用户抽奖次数明细
-- 抽奖次数 = FLOOR(PayMaya存款总额 / 500)
-- =============================================================

SELECT
    login_name                                    AS 用户,
    SUM(dep_amt)                                  AS 存款总额,
    CAST(FLOOR(SUM(dep_amt) / 500) AS BIGINT)     AS 抽奖次数
FROM (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        CAST(amount AS DOUBLE)  AS dep_amt
    FROM superengineproject.dwd_c66_deposit_trans_i_d
    WHERE pt >= '20260929' AND pt <= '20261005'
      AND trans_site_id IN (1,5,6,11,33)
      AND status = 2
      AND deposit_channel = 'PayMaya'
) t
GROUP BY login_name
HAVING SUM(dep_amt) >= 500
ORDER BY 抽奖次数 DESC
;
