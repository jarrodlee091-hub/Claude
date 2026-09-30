-- 基准线分析: 复投率 (Re-betting Rate)
-- 基准线1: 9.11-9.24期间投注但未参与任何大富翁活动核销的用户，活动后1/3/7天复投率
-- 基准线2: 8月同期大盘 (8.11-8.24所有投注用户)，活动后1/3/7天复投率

-- ============================================================
-- 基准线1: 同期未参与用户
-- 活动期: 9.11-9.24
-- 活动后: Day1=9.25, Day3=9.25~9.27, Day7=9.25~10.01
-- ============================================================

WITH
-- 9.11-9.24期间有投注的用户
active_bettors AS (
    SELECT DISTINCT LOWER(TRIM(login_name)) AS login_name
    FROM superengineproject.t_daily_bet_all
    WHERE pt >= '20260911' AND pt <= '20260924'
      AND bet_site_id IN (1,5,6,11,33)
),

-- 9.11-9.24期间参与了大富翁活动核销的用户 (15个活动全部排除)
monopoly_redeemers AS (
    SELECT DISTINCT LOWER(TRIM(login_name)) AS login_name
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
        '6aa107afe4b07fc7e0cb974a','6aa1101be4b07fc742522dd2',
        '6aa125ace4b07fc7dccce898','6aa114bfe4b07fc759b3f4c2',
        '6aa11550e4b07fc749ab00b9'
      )
),

-- 未参与大富翁的投注用户
non_participating AS (
    SELECT ab.login_name
    FROM active_bettors ab
    LEFT JOIN monopoly_redeemers mr ON ab.login_name = mr.login_name
    WHERE mr.login_name IS NULL
),

-- 活动后投注标记
post_flags AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        MAX(CASE WHEN pt = '20260925' THEN 1 ELSE 0 END) AS bet_day1,
        MAX(CASE WHEN pt >= '20260925' AND pt <= '20260927' THEN 1 ELSE 0 END) AS bet_day3,
        MAX(CASE WHEN pt >= '20260925' AND pt <= '20261001' THEN 1 ELSE 0 END) AS bet_day7
    FROM superengineproject.t_daily_bet_all
    WHERE pt >= '20260925' AND pt <= '20261001'
      AND bet_site_id IN (1,5,6,11,33)
    GROUP BY LOWER(TRIM(login_name))
)

SELECT
    '基准线1: 同期未参与用户' AS baseline,
    COUNT(*) AS total_users,
    SUM(CASE WHEN pf.bet_day1 = 1 THEN 1 ELSE 0 END) AS rebet_day1_users,
    SUM(CASE WHEN pf.bet_day3 = 1 THEN 1 ELSE 0 END) AS rebet_day3_users,
    SUM(CASE WHEN pf.bet_day7 = 1 THEN 1 ELSE 0 END) AS rebet_day7_users,
    ROUND(SUM(CASE WHEN pf.bet_day1 = 1 THEN 1 ELSE 0 END) * 100.0
          / COUNT(*), 2) AS rebet_rate_day1_pct,
    ROUND(SUM(CASE WHEN pf.bet_day3 = 1 THEN 1 ELSE 0 END) * 100.0
          / COUNT(*), 2) AS rebet_rate_day3_pct,
    ROUND(SUM(CASE WHEN pf.bet_day7 = 1 THEN 1 ELSE 0 END) * 100.0
          / COUNT(*), 2) AS rebet_rate_day7_pct
FROM non_participating np
LEFT JOIN post_flags pf ON np.login_name = pf.login_name
;


-- ============================================================
-- 基准线2: 8月同期大盘
-- 投注期: 8.11-8.24
-- 投注后: Day1=8.25, Day3=8.25~8.27, Day7=8.25~8.31
-- ============================================================

WITH
-- 8.11-8.24期间所有投注用户
aug_bettors AS (
    SELECT DISTINCT LOWER(TRIM(login_name)) AS login_name
    FROM superengineproject.t_daily_bet_all
    WHERE pt >= '20260811' AND pt <= '20260824'
      AND bet_site_id IN (1,5,6,11,33)
),

-- 8月后投注标记
aug_post_flags AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        MAX(CASE WHEN pt = '20260825' THEN 1 ELSE 0 END) AS bet_day1,
        MAX(CASE WHEN pt >= '20260825' AND pt <= '20260827' THEN 1 ELSE 0 END) AS bet_day3,
        MAX(CASE WHEN pt >= '20260825' AND pt <= '20260831' THEN 1 ELSE 0 END) AS bet_day7
    FROM superengineproject.t_daily_bet_all
    WHERE pt >= '20260825' AND pt <= '20260831'
      AND bet_site_id IN (1,5,6,11,33)
    GROUP BY LOWER(TRIM(login_name))
)

SELECT
    '基准线2: 8月同期大盘' AS baseline,
    COUNT(*) AS total_users,
    SUM(CASE WHEN apf.bet_day1 = 1 THEN 1 ELSE 0 END) AS rebet_day1_users,
    SUM(CASE WHEN apf.bet_day3 = 1 THEN 1 ELSE 0 END) AS rebet_day3_users,
    SUM(CASE WHEN apf.bet_day7 = 1 THEN 1 ELSE 0 END) AS rebet_day7_users,
    ROUND(SUM(CASE WHEN apf.bet_day1 = 1 THEN 1 ELSE 0 END) * 100.0
          / COUNT(*), 2) AS rebet_rate_day1_pct,
    ROUND(SUM(CASE WHEN apf.bet_day3 = 1 THEN 1 ELSE 0 END) * 100.0
          / COUNT(*), 2) AS rebet_rate_day3_pct,
    ROUND(SUM(CASE WHEN apf.bet_day7 = 1 THEN 1 ELSE 0 END) * 100.0
          / COUNT(*), 2) AS rebet_rate_day7_pct
FROM aug_bettors ab
LEFT JOIN aug_post_flags apf ON ab.login_name = apf.login_name
;
