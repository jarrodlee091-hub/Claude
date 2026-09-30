-- ============================================================
-- 问卷用户数据补充查询
-- 活动时间: 9.11 - 9.24
-- 统计项: VIP等级, 骰子发放个数, 任务/地图/TOP300/大富翁核销金额,
--         其他活动核销金额及个数, GGR
-- ============================================================

-- 任务核销返水金 activity_id (12个)
-- '6aa103bbe4b07fc7051c16be','6aa10b8be4b07fc726c4c142',
-- '6aa10478e4b07fc755e79ad2','6aa10c70e4b07fc77262a6dc',
-- '6aa1054ce4b07fc7051c2255','6aa10d5de4b07fc7c517568f',
-- '6aa10698e4b07fc7051c28a2','6aa10e47e4b07fc7436a8057',
-- '6aa10730e4b07fc7e0cb951c','6aa10f22e4b07fc7c517676a',
-- '6aa107afe4b07fc7e0cb974a','6aa1101be4b07fc742522dd2'

-- 地图核销金额 activity_id (2个)
-- '6aa125ace4b07fc7dccce898','6aa114bfe4b07fc759b3f4c2'

-- TOP 300 核销金额 activity_id (1个)
-- '6aa11550e4b07fc749ab00b9'

-- 大富翁核销金额 = 以上15个activity_id的合计

WITH survey_users AS (
    SELECT login_name, q4_satisfaction, q5_reward_attract, q8_rule_clarity, q26_future_interest
    FROM (
        VALUES
    ('bingoplusffnfb4', 7, 7, 4, 7), ('bingoplusd2tgdw', 7, 7, 7, 7), ('bingopluswwwibn', 7, 7, 2, 7), ('bingoplustlrnru', 7, 7, 4, 7), ('bingoplusqqbk42', 6, 5, 4, 6),
    ('bingoplushcaxtm', 7, 7, 7, 7), ('bingoplusva8qq3', NULL, NULL, NULL, 7), ('bingoplus6nuwgt', 7, 7, 6, 7), ('bingoplus2n6mjx', 7, 7, 7, 7), ('bingoplustwu9zs', 7, 7, 6, 7),
    ('bingoplusi1qbj5', 7, 7, 7, 7), ('bingoplus54qsfz', 4, 4, 5, 4), ('gpujv7vz', 7, 7, 7, 7), ('bingopluslb2iov', 7, 6, 6, 7), ('bingoplusl3piwe', 7, 7, 3, 7),
    ('lpyun7pra', 4, 4, 4, 3), ('lp93sp9ln', NULL, NULL, NULL, 7), ('bingoplus8wz8hm', 7, 7, 6, 7), ('bingoplusmf1pko', 7, 7, 4, 7), ('bingopluszdtk2p', 3, 3, 4, 4),
    ('bingoplusnb6op4', NULL, NULL, NULL, 7), ('bingoplusaerb50', 1, 1, 7, 1), ('bingopluspxk4me', 6, 6, 7, 7), ('bingoplusv3tgdj', 4, 4, 4, 4), ('lpdmebba6', 7, 7, 7, 7),
    ('bingopluslpeoe7', NULL, NULL, NULL, 5), ('bingoplus75r64p', NULL, NULL, NULL, 7), ('bingoplus4kx7ev', NULL, NULL, NULL, 7), ('peryafen9sd7', NULL, NULL, NULL, 7), ('bingoplusf245d6', 7, 7, 6, 7),
    ('bingoplusf4prg4', NULL, NULL, NULL, 7), ('bingoplusfyn4r5', NULL, NULL, NULL, 4), ('bingoplusvwj0cd', 7, 7, 7, 7), ('bingoplusbzswz0', 7, 7, 4, 7), ('bingoplusqk7lo2', NULL, NULL, NULL, 6),
    ('lp0ngi4do', 4, 7, 7, 7), ('bingoplusdu5j5t', 7, 7, 7, 6), ('bingoplusn31hdl', 7, 7, 1, 7), ('gp3ng4kx', 7, 7, 6, 7), ('bingoplusxs2t8u', 7, 7, 6, 7),
    ('bingoplus4cebnb', NULL, NULL, NULL, 7), ('bingoplusxd5442', 7, 7, 7, 7), ('bingoplusyi7jh6', 4, 4, 6, 4), ('lp5k0ow9y', 5, 5, 5, 7), ('bingoplusbtzbo4', 7, 7, 7, 7),
    ('bingoplusefg9q8', 4, 4, 5, 4), ('bingoplusvknr5r', 7, 7, 7, 7), ('bingoplushq93zt', 7, 7, 7, 7), ('bingopluswv5qjs', 7, 7, 6, 7), ('bingoplusceu3ht', 7, 7, 6, 7),
    ('bingoplusk1uuk6', 7, 7, 2, 7), ('gp4az2x4', 7, 7, 7, 7), ('bingopluszxcyqc', 2, 1, 4, 2), ('bingopluspiuh0k', 7, 7, 7, 7), ('perya1sq3nkn', NULL, NULL, NULL, 7),
    ('bingopluspssrvl', 6, 6, 6, 6), ('bingoplusuuq8z6', 7, 7, 7, 7), ('bingoplus0z4n7p', 7, 7, 2, 5), ('bingopluse8xys1', 7, 7, 7, 7), ('gp5k7njv', 7, 7, 6, 7),
    ('lpih3uz2y', NULL, NULL, NULL, 7), ('bingoplusvzwv9p', 1, 4, 5, 3), ('bingopluszhs9v8', NULL, NULL, NULL, 1), ('bingopluspt1pv6', 7, 7, 2, 7), ('bingoplusk82g3q', 7, 7, 6, 7),
    ('viber19z6mb0', 7, 7, 7, 7), ('bingopluscx6420', 6, 6, 6, 7), ('bingoplus8qshc9', 3, 2, 6, 4), ('bingoplus4ia3pc', NULL, NULL, NULL, 7), ('bingoplususveic', NULL, NULL, NULL, 7),
    ('bingopluskyua9w', 7, 7, 7, 7), ('bingoplusjv5usk', 7, 7, 4, 7), ('bingoplus7hborz', 7, 7, 6, 7), ('bingopluswfz7te', NULL, NULL, NULL, 7), ('bingopluscwwnyk', NULL, NULL, NULL, 7),
    ('bingoplusabqrho', NULL, NULL, NULL, 7), ('gp83p5zm', 7, 7, 7, 7), ('bingoplusv09zwb', NULL, NULL, NULL, 7), ('peryai4prspv', 7, 7, 7, 7), ('peryahpm16kc', 7, 7, 7, 7),
    ('bingoplushciooe', 7, 3, 7, 5), ('bingoplusvba3in', 7, 7, 7, 7), ('gpsr57b9', NULL, NULL, NULL, 7), ('bingoplusj599m0', 7, 7, 6, 7), ('bingopluskdetug', 5, 5, 5, 5),
    ('bingoplusumkz45', 5, 5, 2, 7), ('lp26wi8p9', NULL, NULL, NULL, 7), ('gpj46mmh', 4, 5, 3, 6), ('bingoplusrp5dr0', 7, 7, 7, 7), ('peryau0ixai6', NULL, NULL, NULL, 5),
    ('bingoplusglrqve', 5, 5, 7, 5), ('bingoplusob1yj6', 5, 5, 6, 5), ('gphpcgjp', 7, 7, 5, 7), ('gp8n78rk', 4, 4, 4, 4), ('bingoplus0abo6t', NULL, NULL, NULL, 7),
    ('lplmxlq5f', 5, 6, 6, 7), ('bingoplusjwt8fv', 7, 7, 7, 5), ('bingoplussp8q28', 7, 7, 7, 7), ('riverlou03', 5, 4, 4, 4), ('bingoplusznbbkk', 7, 1, 4, 1),
    ('bingoplusofiok6', NULL, NULL, NULL, 7), ('bingoplusq0zm1z', NULL, NULL, NULL, 3), ('lpcmf4iwo', 7, 7, 6, 6), ('bingoplusj8j57s', NULL, NULL, NULL, 7), ('bingoplus46exyy', 7, 7, 4, 7),
    ('bingoplusprnjjj', 7, 7, 7, 7), ('lpgjcokx5', 6, 5, 6, 5), ('bingoplus8isp05', 7, 7, 1, 7), ('bingoplusi80rk6', NULL, NULL, NULL, 4), ('jerome03061997', 7, 7, 7, 7),
    ('bingoplusoejgon', 7, 7, 7, 7), ('bingopluswk9f5j', 7, 7, 7, 7), ('bingoplusq0k1qh', NULL, NULL, NULL, 7), ('gp3vmrtm', 7, 7, 6, 7), ('bingoplus243py9', NULL, NULL, NULL, 7),
    ('hkklq819', 1, 1, 1, 5), ('bingoplusnyhx27', NULL, NULL, NULL, 7), ('bingopluspybikc', 5, 5, 5, 6), ('bingoplusdjs3az', 5, 4, 6, 4), ('bingoplus4n98p7', 2, 6, 7, 6),
    ('bingoplus2jeg35', NULL, NULL, NULL, 7), ('peryayr1yv13', 5, 5, 6, 4), ('bingoplusfdojr4', 2, 2, 6, 3), ('peryaw6sdbjs', NULL, NULL, NULL, 4), ('bingoplustsz15q', NULL, NULL, NULL, 7),
    ('bingoplus8vtbkj', 7, 7, 7, 7), ('gphybdzx', 7, 7, 7, 7), ('bingoplus0z6dc2', 7, 7, 7, 7), ('bingoplusq7d4je', 6, 6, 1, 6), ('bingoplusfy4ecr', NULL, NULL, NULL, 7),
    ('bingoplus5yfwd2', 6, 6, 7, 7), ('bingoplusc0u5se', 7, 7, 7, 7), ('bingoplus3z9e6r', 3, 4, 4, 3), ('lpjr87dx', NULL, NULL, NULL, 7), ('lpys4abp', 7, 7, 6, 7),
    ('lpsx7dik1', 6, 6, 5, 5), ('bingopluspc4umu', NULL, NULL, NULL, 4), ('bingoplusa5bfr8', 4, 4, 7, 7), ('bingoplusjvust7', 7, 7, 7, 7), ('bingoplusiein8s', 4, 4, 4, 4),
    ('bingoplusailr1h', NULL, NULL, NULL, 7), ('bingoplusx4ujad', 6, 6, 6, 7), ('lp2gk64p', 7, 7, 6, 7), ('bingoplustw7u4q', 7, 7, 7, 7), ('bingopluso0j2sn', 5, 4, 5, 5),
    ('bingoplus12uy09', NULL, NULL, NULL, 2), ('bingoplus1zxjyk', NULL, NULL, NULL, 7), ('bingoplus097wyy', 7, 7, 7, 7), ('bingoplus7mp8kq', 7, 7, 7, 7), ('peryaiuj8nss', NULL, NULL, NULL, 7),
    ('bingopluskqf9pc', 7, 7, 7, 7), ('bingopluslcav2xi', 5, 3, 5, 7), ('lpucqsadc', NULL, NULL, NULL, 7), ('bingoplus3n98jb', 7, 7, 7, 7), ('bingoplus7e6zww', 7, 7, 6, 7),
    ('bingoplusuz31xg', NULL, NULL, NULL, 7), ('bingoplus29cgdz', NULL, NULL, NULL, 5), ('perya6asw2p5', 7, 6, 6, 6), ('bingopluskdva3f', NULL, NULL, NULL, 7), ('peryayeq30r3', 7, 7, 7, 7),
    ('bingopluswguo23', 4, 5, 6, 5), ('bingoplusz8an8v', 7, 7, 7, 7), ('bingoplusiwuhf0', 7, 7, 7, 7), ('bingoplusvzsm7q', 7, 7, 7, 7), ('bingoplus55guen', NULL, NULL, NULL, 7),
    ('lp8ac7b38', 7, 7, 7, 7), ('bingoplusvm0748', 5, 6, 6, 5), ('bingoplusjppr5l', 7, 7, 6, 7), ('bingoplusg8amjj', 7, 7, 7, 6), ('bingopluszlqmkr', 7, 7, 7, 7),
    ('bingoplusm27oje', 7, 7, 5, 7), ('bingoplusj4rdd2', NULL, NULL, NULL, 7), ('bingoplusd79uea', NULL, NULL, NULL, 7), ('lp2n8x5q', NULL, NULL, NULL, 7), ('bingoplusnz858i', 1, 1, 5, 5),
    ('bingoplusgi4533', 4, 4, 6, 4), ('bingopluse38294', 2, 5, 4, 7), ('bingoplusqpvkdf', 4, 2, 6, 4), ('bingoplusc1pjj1', 7, 7, 7, 7), ('bingoplusl60nra', 4, 5, 5, 5),
    ('bingoplus8cm6vy', 7, 7, 4, 6), ('bingoplusd3n9up', 6, 6, 6, 6), ('bingopluspktrit', 3, 2, 3, 2), ('bingoplusfvy5xq', 7, 7, 7, 7), ('bingoplusekmlpi', NULL, NULL, NULL, 7),
    ('bingoplus4trjvn', NULL, NULL, NULL, 7), ('gp73c9gb', 7, 7, 7, 7), ('bingoplustr4xsv', 4, 4, 5, 4), ('bingoplusxvnq4i', 3, 7, 7, 7), ('bingoplusolhzaf', 7, 7, 4, 7),
    ('bingoplusxsybgz', 7, 7, 6, 7), ('lps1fkxl8', 7, 7, 7, 7), ('bingoplus5kj4bp', NULL, NULL, NULL, 7), ('bingopluss337fg', NULL, NULL, NULL, 1), ('bingoplusaqcov4', 7, 7, 1, 7),
    ('bingoplusn5jfmt', 7, 7, 7, 7), ('bingoplus6nwtqt', 1, 2, 6, 1), ('bingoplustm4hvu', NULL, NULL, NULL, 1), ('lphtqwusx', 7, 3, 3, 3), ('bingoplusn05a1y', NULL, NULL, NULL, 7),
    ('lpkijfr3o', 7, 7, 7, 7), ('bingoplusiq0ibw', 7, 7, 4, 7), ('bingopluskgj5xk', NULL, NULL, NULL, 7), ('perya1vjg77c', NULL, NULL, NULL, 7), ('bingoplust3ew5g', 7, 7, 7, 7),
    ('bingopluspb7oqu', 7, 7, 6, 7), ('lpzam9sk6', NULL, NULL, NULL, 7), ('bingoplushkdx65', NULL, NULL, NULL, 6), ('lpgnfxfa', NULL, NULL, NULL, 5), ('bingopluskgajes', 7, 7, 6, 7),
    ('lp00tnwmp', 4, 6, 6, 5), ('bingopluslsamcu', 7, 1, 6, 3), ('lpapj6h06', 5, 4, 5, 5), ('bingoplus5acc8c', 6, 6, 6, 5), ('bingoplusjll3tk', 5, 5, 7, 5),
    ('bingopluso2gyqd', NULL, NULL, NULL, 7), ('bingoplusuijtk1', 7, 7, 6, 6), ('bingopluslgranz', 7, 4, 6, 6), ('bingoplus25kp6c', NULL, NULL, NULL, 2), ('bingoplusatn4ni', 7, 7, 6, 7),
    ('bingoplusadhsgi', NULL, NULL, NULL, 7), ('bingoplusdnnkzb', 7, 7, 4, 7), ('lpic74cyo', 7, 7, 7, 7), ('bingoplushmr4u3', 2, 2, 1, 4), ('lp618dfpc', NULL, NULL, NULL, 7),
    ('bingoplus8d7yff', 6, 5, 7, 5), ('bingoplustt2snd', NULL, NULL, NULL, 7), ('bingoplus9onn9k', 7, 7, 1, 1), ('spinfxdws9', NULL, NULL, NULL, 4), ('gpfyfupw', 7, 7, 6, 5),
    ('bingoplusvrh6si', 7, 7, 7, 7), ('lpmf9buej', 2, 4, 4, 3), ('bingoplusdvh83o', 7, 7, 7, 7), ('gp7npuas', 6, 6, 4, 6), ('bingoplusjrnvvx', NULL, NULL, NULL, 3),
    ('lp01ic5i1', NULL, NULL, NULL, 7), ('bingoplus8cxi8a', 7, 7, 7, 7), ('lpk47aa02', 7, 4, 4, 7), ('bingoplust7gqe4', 3, 3, 4, 1), ('lpjlyd4jd', 7, 1, 5, 7),
    ('bingoplus1eiocc', 7, 7, 7, 7), ('bingoplus04j4gz', 4, 3, 4, 3), ('bingopluswv5cmo', 5, 5, 5, 7), ('bingoplusmxrqu8', 7, 7, 7, 7), ('bingoplusu5ebdy', NULL, NULL, NULL, 6),
    ('bingoplusvrmas6', 7, 5, 7, 5), ('bingoplus0123ak', 7, 7, 5, 7), ('lpna59eg3', NULL, NULL, NULL, 3), ('bingoplust9ssja', 7, 7, 7, 7), ('bingoplusekk548', 7, 7, 7, 7),
    ('bingoplus4xar7o', 7, 7, 2, 7), ('bingoplusih6yls', NULL, NULL, NULL, 5), ('bingoplusqqmsb5', 7, 7, 1, 7), ('gp3jxpn3', 7, 7, 7, 7), ('bingoplus7zrkie', 7, 7, 7, 7),
    ('lpy2p3zxu', NULL, NULL, NULL, 7), ('spinmrf2wli', 7, 7, 4, 7), ('bingoplus5c4vks', NULL, NULL, NULL, 7), ('bingoplusow920m', 7, 7, 7, 7), ('bingoplusrz9dxr', 7, 7, 7, 7),
    ('bingoplus34b62p', 7, 7, 7, 7), ('bingoplusww6wm8', NULL, NULL, NULL, 2), ('peryar9b5x99', 5, 5, 5, 5), ('lpkf25a9', NULL, NULL, NULL, 7), ('bingoplusphtoav', NULL, NULL, NULL, 7),
    ('lp8cu7sdk', NULL, NULL, NULL, 6), ('peryanipnaxn', NULL, NULL, NULL, 4), ('bingoplusjhempy', 7, 7, 6, 7), ('bingoplus9k6dtg', 1, 1, 1, 1), ('lpidzehm1', 7, 7, 6, 7),
    ('gpeg7ezc', 7, 7, 5, 7), ('bingoplusg8f6w0', NULL, NULL, NULL, 6), ('cmrjames78', 7, 7, 7, 7), ('bingoplusmjxnzb', 7, 7, 7, 7), ('bingoplus5sk9zm', 7, 7, 4, 7),
    ('bingoplus5lrwqv', NULL, NULL, NULL, 7), ('lpz3oymt9', 4, 4, 4, 5), ('peryaapyfgm7', 7, 7, 6, 7), ('bingoplusvskxjs', 7, 7, 7, 7), ('bingoplusaya245', NULL, NULL, NULL, 2),
    ('bingopluszicpns', 6, 5, 6, 6), ('gpyh5f35', 7, 7, 6, 7), ('bingoplusvx8cm2', 7, 7, 7, 7), ('bingoplus8v7dgs', NULL, NULL, NULL, 6), ('perya7o68752', 2, 1, 7, 1),
    ('bingoplusjn6bgt', NULL, NULL, NULL, 7), ('bingoplussxlcv1', 7, 7, 7, 7), ('gp83e9df', 7, 7, 6, 7), ('gp92hng5', 5, 7, 4, 7), ('bingoplusx9g2rw', 7, 7, 6, 7),
    ('lppfi0f1q', NULL, NULL, NULL, 7), ('lpy7z8duf', 5, 5, 7, 5), ('bingoplus5l7xeu', NULL, NULL, NULL, 6), ('bingopluso6v9hc', 5, 7, 6, 5), ('gpfw425f', 1, 1, 6, 1),
    ('bingoplus7e499k', 7, 7, 5, 7), ('bingopluswi46bj', 5, 5, 4, 5), ('bingoplusedeznm', 6, 6, 6, 6), ('bingopluskh22la', NULL, NULL, NULL, 5), ('bingoplus88rs9j', 4, 5, 6, 5),
    ('bingoplus9m63aj', 1, 1, 6, 1), ('bingoplusymvhkk', 4, 4, 4, 4), ('bingoplus1cz7ua', NULL, NULL, NULL, 7), ('bingoplus1f14aq', 7, 7, 1, 7), ('lpth4b7na', 7, 7, 3, 7),
    ('bingoplusvuwv9h', NULL, NULL, NULL, 7), ('bingoplusxaktlk', 7, 7, 7, 7), ('bingoplus0pi3q8', NULL, NULL, NULL, 7), ('bingoplusgcbmbg', NULL, NULL, NULL, 4), ('bingoplusnk9gtp', 3, 3, 3, 4),
    ('bingoplusiylop5', 2, 2, 4, 4), ('bingopluszv9txt', 1, 1, 1, 1), ('bingoplusvab6vd', NULL, NULL, NULL, 7), ('bingoplusy49nq7', 7, 7, 7, 7), ('lpwf3a9vw', 7, 7, 7, 7),
    ('bingopluspwxsux', NULL, NULL, NULL, 7), ('bingopluswe47sj', 7, 7, 4, 7), ('bingoplusda7ywn', NULL, NULL, NULL, 7), ('bingoplus86xpfs', 4, 4, 4, 4), ('bingoplusuetaxr', 5, 5, 7, 5),
    ('bingoplusvgy8hv', 7, 7, 7, 7), ('gpcp4t23', 7, 7, 7, 7), ('bingoplusemexnc', 7, 7, 7, 7), ('bingoplusmpwj7f', 5, 7, 6, 5), ('spin56b7jhd', 7, 7, 6, 7),
    ('bingopluste9g9e', 7, 7, 7, 7), ('bingoplusmwov32', 7, 5, 5, 7), ('bingoplusjasmx9', 7, 7, 7, 7), ('bingoplus264jzv', NULL, NULL, NULL, 4), ('lp225o6vh', 7, 7, 6, 7),
    ('bingoplus7k3n00', 1, 1, 6, 7), ('bingoplusn66mqm', 7, 7, 6, 7), ('lp460gl05', NULL, NULL, NULL, 1), ('bingoplusk27ndw', 5, 5, 4, 5), ('bingoplus3n6cde', 7, 7, 6, 7),
    ('bingoplusr7bktf', NULL, NULL, NULL, 7), ('bingoplusezxt74', 4, 4, 3, 7), ('bingopluszeu7sb', 5, 5, 6, 4), ('lp0r8zc8t', 7, 7, 7, 7), ('bingoplusi5u70t', 7, 7, 7, 7),
    ('bingoplusuhvim9', NULL, NULL, NULL, 4), ('bingoplusr1wxhn', 7, 7, 7, 7), ('lpdxruvhi', 7, 4, 4, 7), ('bingoplusvbdowo', 7, 7, 7, 7), ('bingopluslwz1e3', 7, 5, 5, 7),
    ('bingoplusbbub92', 7, 7, 6, 7), ('bingoplus0vityf', NULL, NULL, NULL, 7), ('lps9h3bmj', 7, 7, 4, 7), ('bingoplusqur63q', 3, 3, 2, 3), ('bingoplusj9s3p4', NULL, NULL, NULL, 7),
    ('bingoplusj9vvax', 7, 7, 7, 7), ('bingoplus0qdy91', 7, 7, 6, 3), ('bingoplusqbpv9z', 4, 4, 7, 4), ('bingoplusmu3w69', 3, 6, 5, 4), ('bingopluswr3bsb', 7, 7, 7, 7),
    ('bingoplusd8cpbk', 7, 7, 7, 7), ('bingoplusjlz9zw', 7, 4, 4, 7), ('bingoplusar0pk7', NULL, NULL, NULL, 6), ('lp66ur8n2', 4, 5, 5, 5), ('lpfxf4as3', 6, 6, 6, 6),
    ('bingoplus367tzv', 7, 7, 7, 7), ('bingoplus3c2hem', NULL, NULL, NULL, 5), ('bingoplussdn6vb', 5, 6, 6, 7), ('bingoplustix8xo', 7, 7, 7, 7), ('lprfz2wl0', NULL, NULL, NULL, 1),
    ('bingopluszd2ytu', 6, 7, 7, 6), ('bingoplusxpr9bq', 1, 2, 6, 2), ('bingoplus2mtllr', 2, 2, 4, 4), ('bingoplusdga7xu', 7, 7, 1, 7), ('bingoplus4ngyfn', 7, 7, 7, 7),
    ('bingoplus4pl10a', 4, 4, 4, 4), ('lpmdms5eb', NULL, NULL, NULL, 7), ('bingopluswao9h4', 7, 7, 7, 6), ('bingoplusl0cmz4', 7, 7, 7, 7), ('bingoplusfachak', 7, 3, 7, 3),
    ('bingoplusoa10gs', 7, 7, 7, 7), ('bingopluscozdtc', NULL, NULL, NULL, 3), ('lp3kcos9c', NULL, NULL, NULL, 2), ('bingoplusra5emy', NULL, NULL, NULL, 7), ('bingoplus9nbc4a', 7, 7, 7, 7),
    ('bingoplusj2x6f3', NULL, NULL, NULL, 7), ('bingoplusz905lc', 7, 7, 7, 7), ('bingoplushogwyj', 5, 7, 5, 7), ('peryazu90h7w', 4, 5, 6, 7), ('bingoplus4vqtsj', 7, 7, 7, 7),
    ('bingoplus5gdle1', 7, 7, 7, 7), ('bingopluspyv856', NULL, NULL, NULL, 7), ('bingoplushgccqd', NULL, NULL, NULL, 5), ('bingoplusf837bl', NULL, NULL, NULL, 7), ('bingoplusrpp8dr', NULL, NULL, NULL, 7),
    ('bingoplus4hqm8y', NULL, NULL, NULL, 7), ('bingoplusi3jncv', 5, 5, 6, 5), ('bingoplusvmwnua', 4, 6, 7, 6), ('bingoplus8ixea5', 7, 7, 6, 7), ('bingoplus7lsk30', 7, 7, 7, 7),
    ('gpcab8b6', 7, 7, 4, 7), ('bingoplus0s351c', 7, 7, 4, 7), ('bingoplusvf8wfp', NULL, NULL, NULL, 7), ('gpsxrhfe', NULL, NULL, NULL, 7), ('bingoplusfl32xt', 7, 7, 7, 7),
    ('bingoplus8cwxmk', 7, 7, 5, 5), ('bingoplusx83z2n', 7, 7, 7, 7), ('bingoplus8nemb6', 7, 7, 7, 7), ('gpkvf5mf', 7, 7, 7, 7), ('bingoplusm92e4s', 7, 7, 7, 7),
    ('spinvrg0nm6', 7, 7, 7, 7), ('lpkuv8evc', 7, 7, 7, 7), ('bingoplusplmi6h', 7, 7, 1, 7), ('bingoplusaiuql5', NULL, NULL, NULL, 4), ('bingoplusysky3u', 7, 7, 7, 7),
    ('alwx3fc8', 7, 7, 7, 7), ('bingoplusifu30h', 6, 6, 6, 5), ('bingoplus7yvc2d', 7, 7, 7, 7), ('lpnqy9ssw', 7, 7, 3, 7), ('lp4u0p2cj', NULL, NULL, NULL, 7),
    ('bingoplus1jhpio', NULL, NULL, NULL, 7), ('bingoplus86cdop', 5, 5, 7, 4), ('bingoplusr6snxx', 5, 3, 6, 3), ('bingoplusnyp7on', 5, 6, 7, 7), ('peryaatnjcpf', 5, 4, 6, 7),
    ('bingoplussizcoc', 7, 7, 7, 7), ('bingoplus1pd3m2', NULL, NULL, NULL, 7), ('bingoplus6llplc', 6, 1, 7, 4), ('bingoplus46m4qt', 7, 6, 6, 6), ('bingopluspuft8t', 7, 7, 7, 7),
    ('bingopluseqn5yr', 7, 7, 6, 7), ('bingoplusj4waiz', 7, 7, 7, 7), ('bingoplusxc8jv4', 4, 3, 1, 1), ('bingopluszqafi3', 7, 7, 7, 7), ('bingoplus8v8ly6', NULL, NULL, NULL, 6),
    ('brisulda31', 7, 7, 7, 7), ('lph6efzj5', 6, 6, 6, 6), ('bingoplus6cwkyu', 7, 7, 6, 4), ('bingoplus45ujby', 4, 3, 7, 3), ('lpbhvdxcu', NULL, NULL, NULL, 7),
    ('bingopluspucxqd', 7, 7, 7, 7), ('bingoplusvzfpea', 7, 7, 7, 7), ('bingoplusq33kxu', NULL, NULL, NULL, 7), ('bingoplusuotq3d', 2, 2, 5, 2), ('gpryh8ch', NULL, NULL, NULL, 5),
    ('bingoplusv7sbcm', 7, 7, 7, 7), ('bingopluswrjy09', NULL, NULL, NULL, 7), ('bingoplusp35ngz', 7, 7, 4, 4), ('bingoplus0bz0aj', 7, 7, 7, 7), ('bingoplus2k4d6k', 4, 3, 2, 7),
    ('spingcbe85', NULL, NULL, NULL, 7), ('bingoplusnbpex8', 7, 7, 7, 7), ('bingoplusplh595', 7, 7, 6, 7), ('bingoplusybnzfs', 7, 7, 5, 6), ('bingoplusgabsmf', 1, 1, 2, 1),
    ('bingoplusuow0od', 4, 4, 6, 7), ('bingoplusiwxv0t', 5, 5, 7, 5), ('bingoplus9nm2nn', 7, 7, 4, 7), ('bingoplustzplwi', 7, 7, 7, 7), ('bingoplus1kobrn', 7, 4, 6, 7),
    ('bingoplus6b4yj2', 7, 7, 7, 7), ('bingoplusb0riiz', 6, 7, 6, 5), ('bingoplusj8n0sy', 7, 7, 7, 7), ('bingopluse5bwnx', 7, 7, 7, 7), ('bingoplusxw3ags', 7, 7, 6, 7),
    ('gp9acqcb', 4, 7, 4, 5), ('bingopluszdnn2g', 3, 3, 4, 3), ('bingoplus2868cg', 7, 7, 5, 7), ('lpdd0fhef', 6, 6, 6, 6), ('bingopluslz36fp', 7, 7, 7, 7),
    ('bingoplustmts0ul', 7, 7, 7, 7), ('lprall40l', 7, 7, 7, 7), ('bingoplusijd2w6', 7, 7, 7, 5), ('bingoplusrn5rwk', NULL, NULL, NULL, 4), ('bingoplus3y78j8', 7, 7, 7, 7),
    ('bingoplusjddgmz', 7, 7, 7, 3), ('bingoplus0yj51y', 7, 7, 7, 7), ('bingoplusw5hwbn', 3, 2, 1, 2), ('bingopluskg2zl8', NULL, NULL, NULL, 2), ('bingoplus3iogs8', 7, 7, 7, 7),
    ('bingoplusa5q29v', NULL, NULL, NULL, 1), ('bingoplus4g0dxd', 1, 1, 3, 5), ('bingoplusyas4yb', 7, 4, 7, 5), ('bingoplusyq5qvn', 7, 7, 7, 7), ('1234rl123', 7, 7, 7, 7),
    ('bingoplusw9ks0n', 7, 7, 7, 7), ('lpcsoczaa', 7, 7, 4, 7), ('bingoplusgkfi9m', 7, 7, 7, 7), ('lpnc6qqsz', 7, 7, 6, 7), ('bingoplusdj5kwh', 7, 5, 7, 7),
    ('gp5ftbqb', 7, 7, 7, 7), ('bingoplusc7a4zr', 7, 7, 5, 7), ('bingoplusabudb4', 7, 6, 6, 7), ('bingoplusjwuqgx', 3, 3, 6, 3), ('bingoplus9hgtgn', 7, 7, 7, 6),
    ('bingopluszs6wv5', NULL, NULL, NULL, 7), ('bingoplusbklnaz', 7, 7, 6, 7), ('lp456jpjc', 7, 7, 6, 7), ('bingoplusfx3mue', 5, 7, 5, 7), ('bingopluswwgtuq', 7, 7, 7, 7),
    ('bingopluschds7i', NULL, NULL, NULL, 7), ('gp6evxq2', 5, 5, 5, 5), ('bingoplusjzumph', 4, 5, 4, 7), ('bingoplusrme4xi', NULL, NULL, NULL, 7), ('bingoplusuhpuzm', 7, 7, 6, 4),
    ('bingoplusdi4mtg', 7, 7, 6, 6), ('bingoplusgx4n6z', 7, 7, 7, 7), ('bingoplushn9b2a', NULL, NULL, NULL, 6), ('bingoplus0m7qo1', 7, 7, 7, 7), ('lpjp318j4', 7, 7, 6, 7),
    ('bingoplusnq7315', 7, 7, 6, 7), ('lp9wmza9f', 7, 7, 6, 7), ('bingoplus9kwpn3', 7, 7, 4, 7), ('bingoplusvq2tyy', 5, 4, 6, 6), ('peryayq5ilfy', 7, 7, 7, 7),
    ('bingoplusygfhnb', 7, 7, 7, 7), ('lphtmkxsq', 7, 7, 7, 7), ('bingoplusbgcesi', 7, 7, 5, 7), ('bingoplus8k5n6c', NULL, NULL, NULL, 7), ('bingoplusymdnwh', 7, 7, 7, 7),
    ('bingoplus5pnye4', NULL, NULL, NULL, 6), ('bingoplusm7uqoi', 4, 4, 5, 5), ('bingopluszuuk89', 5, 7, 6, 6), ('bingoplusvwqqvs', 7, 7, 7, 7), ('bingoplussuk4kq', 7, 7, 7, 7),
    ('bingoplusg54y33', 7, 7, 6, 7), ('bingoplus6yjrz5', 3, 7, 7, 1), ('bingopluswixf2c', 7, 7, 7, 7), ('bingoplus5kh0mp', 7, 7, 7, 7), ('lpuun0gwr', 4, 2, 5, 4),
    ('bingoplus7wfcx2', 7, 7, 7, 7), ('lpy7c07o5', 4, 3, 4, 3), ('gp5g72qq', 7, 7, 6, 7), ('bingoplusi01di4', 7, 7, 6, 7), ('bingoplusix9x7z', NULL, NULL, NULL, 5),
    ('bingoplusd2a1r8', 7, 7, 7, 7), ('bingoplusxczzjd', 1, 1, 1, 1), ('bingoplus84x57f', NULL, NULL, NULL, 3), ('bingoplusm409ug', 7, 7, 7, 7), ('bingoplus2jf5yq', NULL, NULL, NULL, 7),
    ('bingoplus9w1xct', NULL, NULL, NULL, 7), ('bingoplus81yvod', 4, 1, 1, 1), ('bingopluss3zqbj', 7, 6, 6, 4), ('bingopluslw6fcj', 5, 5, 6, 3), ('bingoplus2h0xvh', NULL, NULL, NULL, 6),
    ('gptywbph', 7, 7, 7, 7), ('bingoplusw9u5tx', NULL, NULL, NULL, 1), ('bingoplusfu64bb', 7, 7, 1, 7), ('bingopluswz2ily', 7, 7, 4, 7), ('bingoplusy3zhis', 5, 3, 7, 6),
    ('bingoplusjo7077', 5, 5, 5, 5), ('peryaaldcel2', 7, 7, 7, 7), ('bingoplusjkd286', 7, 7, 6, 7), ('gprme7vv', NULL, NULL, NULL, 7), ('bingopluskdwvho', 3, 3, 4, 3),
    ('bingoplusvpn94v', NULL, NULL, NULL, 7), ('bingoplus6ie2pr', NULL, NULL, NULL, 6), ('bingoplusvw222e', 7, 7, 4, 7), ('bingoplus5xi2gt', 5, 5, 6, 5), ('bingopluszshvvt', 6, 6, 6, 6),
    ('bingoplus5ae853', 7, 7, 7, 7), ('bingoplusdwz31u', 1, 1, 1, 1), ('bingoplus4j6ks9', 1, 1, 4, 1), ('bingoplusj8utaa', 7, 7, 4, 7), ('bingoplusrkncro', NULL, NULL, NULL, 7),
    ('bingopluspxabhd', 7, 7, 4, 7), ('bingoplus21tp60', 3, 2, 6, 3), ('gpg4kh3p', 7, 7, 1, 6), ('lpfhzm27', 7, 7, 7, 7), ('bingopluspewxz7', 7, 7, 7, 7),
    ('bingoplusbjyl23', 5, 5, 6, 5), ('bingoplusn3f7fd', 7, 7, 7, 7), ('bingoplusn9ns8p', NULL, NULL, NULL, 5), ('sp3jvdaxu', 7, 7, 4, 7), ('bingoplus2237j7', 4, 4, 3, 5),
    ('bingoplusqko937', 7, 7, 7, 6), ('xixuc139', 7, 7, 7, 7), ('papa1', 7, 7, 7, 7), ('bingoplusww0ppq', 7, 7, 7, 7), ('bingoplus94tp0q', NULL, NULL, NULL, 7),
    ('bingopluszt5scs', 7, 7, 7, 7), ('gp6v5ccd', 7, 7, 7, 7), ('bingoplusjnmkdq', 7, 7, 7, 7), ('bingoplusrqqbfu', 7, 7, 7, 7), ('bingoplusvdvye7', 7, 7, 2, 7),
    ('bingopluslzoeft', 7, 7, 7, 7), ('bingoplus8ddmtw', 5, 5, 4, 5), ('bingoplusawa142', 6, 5, 6, 5), ('bingoplus4into1', 7, 7, 3, 7), ('bingoplus6hmzuq', 7, 7, 6, 7),
    ('lp3dvbkn', NULL, NULL, NULL, 7), ('bingopluseu0pm0', 7, 7, 7, 7), ('bingoplussck51a', 4, 7, 6, 6), ('bingopluskpr251', 1, 1, 7, 1), ('bingoplusgydfrv', NULL, NULL, NULL, 1),
    ('bingopluswiyexj', 7, 7, 7, 7), ('bingoplusoyeqsa', 1, 1, 1, 1), ('bingoplus1bm989', 6, 5, 3, 5), ('bingoplus3qwx0h', 7, 7, 7, 7), ('bingoplus091si6', 7, 7, 6, 7),
    ('bingoplusxastxk', 6, 5, 6, 6), ('lp9p9j2c', NULL, NULL, NULL, 7), ('bingoplustaajj8', 3, 5, 5, 5), ('bingoplusryafwp', NULL, NULL, NULL, 1), ('bingoplus0jl744', NULL, NULL, NULL, 5),
    ('bingoplusacinu6', 2, 1, 4, 1), ('bingoplusv01b6u', 6, 4, 4, 6), ('bingoplusolkr8y', 7, 7, 7, 7), ('bingopluss0qtw9', 7, 7, 7, 7), ('bingoplusrcc5mn', 7, 7, 6, 7),
    ('bingoplus2dxp13', 7, 7, 7, 7), ('bingoplus3m1h22', 7, 7, 6, 7), ('bingoplusijbvox', NULL, NULL, NULL, 7), ('bingoplus8kezys', 7, 7, 6, 7), ('bingoplusag3tr8', 7, 7, 7, 7),
    ('bingoplusp8c24d', 7, 7, 6, 7), ('bingoplusdf8v4z', 6, 7, 6, 7), ('viberu5hvufy', 7, 7, 7, 7), ('bingoplusoglj8d', 7, 7, 6, 7), ('lp6t280fe', 6, 6, 6, 7),
    ('spinnmsxp7r', 3, 3, 4, 3), ('gp5j9r2d', NULL, NULL, NULL, 1), ('bingoplusx30ogl', 1, 6, 6, 7), ('gprpvfcu', 7, 7, 4, 7), ('bingoplus4ubqwg', 1, 5, 5, 4),
    ('bingopluscejhvy', 5, 5, 7, 7), ('gpz3hf33', 6, 7, 7, 6), ('bingopluswiudnz', 5, 5, 6, 4), ('bingoplus3tqowb', NULL, NULL, NULL, 7), ('lp09ovq4h', NULL, NULL, NULL, 1),
    ('bingoplustmr6e0', NULL, NULL, NULL, 7), ('bingoplus56tmez', 1, 1, 4, 3), ('bingoplus5qm8sf', 6, 5, 6, 5), ('bingoplus373sgz', 6, 7, 6, 7), ('bingoplusd8aox0', 7, 4, 3, 7),
    ('bingoplustfp5cj', 4, 6, 4, 4), ('bingoplusuqlu6s', 7, 7, 7, 7), ('bingoplus1n6y3v', 1, 1, 1, 1), ('bingoplusbh5q48', 5, 3, 5, 7), ('bingoplusbkhrmz', NULL, NULL, NULL, 4),
    ('bingoplusif8pmj', 7, 7, 7, 7), ('gpvb5bu2', 7, 7, 7, 7), ('bingoplus54qttz', 4, 1, 6, 4), ('bingoplusrtje8t', NULL, NULL, NULL, 7), ('bingoplusfe1cl5', 7, 7, 7, 7),
    ('bingopluskiz6jy', 7, 7, 7, 7), ('bingoplush08az9', 1, 1, 2, 1), ('gpuh7a3j', 1, 1, 7, 1), ('bingoplusd2vdwi', 4, 4, 6, 5), ('bingoplusogxsxs', 1, 1, 7, 2),
    ('bingoplusuhkfj8', 7, 7, 7, 7), ('bingoplusqymyid', 5, 6, 7, 5), ('gphnvwt4', 7, 7, 6, 7), ('bingoplusv67cf7', 7, 7, 7, 4), ('lpi1r5ked', 7, 7, 7, 7),
    ('bingoplusnrbflt', NULL, NULL, NULL, 7), ('bingoplusec0g5w', 7, 7, 7, 7), ('bingoplus6xjzho', 5, 5, 5, 4), ('bingoplusz7fulz', 3, 2, 4, 7), ('bingoplus3pq7hy', 5, 3, 4, 4),
    ('lp56cjry', 6, 6, 4, 6), ('bingoplusr8rwfy', 7, 7, 4, 7), ('bingoplusawx7ke', NULL, NULL, NULL, 4), ('perya94p5ize', 7, 7, 5, 6), ('bingoplus7whh8t', NULL, NULL, NULL, 7),
    ('gpjekj3c', NULL, NULL, NULL, 7), ('bingoplusejkbdc', 7, 7, 7, 7), ('bingoplus1sz2nn', 4, 4, 4, 4), ('bingoplush5dxi4', NULL, NULL, NULL, 7), ('gpqj5fua', 7, 7, 6, 7),
    ('bingoplusd92ml1', 5, 7, 4, 7), ('bingoplusnehrfo', 7, 7, 7, 7), ('bingoplus9pzdkz', 7, 7, 7, 7), ('lpwcpev3x', NULL, NULL, NULL, 4), ('bingoplus0a710y', NULL, NULL, NULL, 7),
    ('bingoplusgxydve', 7, 7, 6, 6), ('bingoplusqknv2v', 7, 7, 7, 7), ('gp9tnpab', 6, 7, 6, 7), ('lpbyh7hy', 6, 4, 5, 6), ('gpwcpwyh', NULL, NULL, NULL, 7),
    ('bingoplus12c7cj', 7, 6, 6, 5), ('gpey9223', 5, 6, 4, 5), ('bingoplus14a2cn', NULL, NULL, NULL, 7), ('bingoplusd2qwqv', 6, 4, 4, 3), ('lpzbjh3s', NULL, NULL, NULL, 7),
    ('bingoplust37hnp', 7, 7, 6, 6), ('bingoplusu16xhi', 7, 7, 7, 7), ('gp3vmt2j', 7, 7, 6, 7), ('gpb5b68m', 7, 7, 6, 7), ('gphvudgw', 5, 5, 6, 5),
    ('bingopluswr98wm', NULL, NULL, NULL, 3), ('bingopluscsj0qp', 7, 7, 7, 7), ('bingoplusgnoidk', 7, 7, 1, 7), ('bingoplusagjgue', NULL, NULL, NULL, 4), ('bingoplusd3a6gy', NULL, NULL, NULL, 7),
    ('bingoplusdwhub3', NULL, NULL, NULL, 1), ('bingoplusj2afwn', 7, 7, 1, 7), ('bingoplusje6uaa', 7, 7, 4, 7), ('bingopluswn61xs', 7, 2, 5, 1), ('bingopluso1prhi', 4, 3, 2, 3),
    ('bingopluschb6s6', 7, 7, 7, 6), ('bingoplusne7yzg', 5, 5, 5, 5), ('bingoplusze9hkp', 7, 7, 6, 7), ('bingoplus8hh1j3', 7, 7, 6, 7), ('bingoplus70gqmz', 1, 1, 7, 1),
    ('bingoplus8jacpm', 5, 4, 6, 5), ('bingoplus1jetya', 7, 7, 4, 7), ('lpg3eee1i', 5, 5, 6, 5), ('bingoplusab43t5', 1, 1, 1, 1), ('bingoplusi14tgz', 7, 7, 7, 7),
    ('peryawarf1ni', 1, 1, 7, 7), ('aquarius26', NULL, NULL, NULL, 2), ('bingoplusxmcf68', NULL, NULL, NULL, 7), ('bingoplus616w14', 4, 2, 6, 6), ('bingoplusb2r3nv', NULL, NULL, NULL, 3),
    ('bingoplusn7dkw6', 7, 7, 6, 5), ('gpv79b9w', 7, 7, 6, 7), ('bingoplus4seta2', NULL, NULL, NULL, 7), ('bingopluskewy6d', 7, 7, 6, 7), ('bingoplusd3o04o', NULL, NULL, NULL, 7),
    ('gpy9vq2s', 7, 7, 6, 7), ('bingopluszff7bl', 5, 4, 5, 5), ('bingoplus2u1o66', 7, 7, 7, 7), ('gp5z9gy4', 5, 5, 4, 5), ('bingoplusvdr5m4', 7, 6, 6, 7),
    ('bingoplusogb1rs', 7, 7, 7, 7), ('bingoplusjlfo9x', 7, 7, 7, 4), ('bingoplusuh7tu8', 6, 7, 5, 7), ('bingoplusdmqx9v', 7, 7, 4, 7), ('bingoplus5u2bz3', 4, 5, 6, 5),
    ('bingoplusg141l5', NULL, NULL, NULL, 7), ('bingoplus6jp677', 6, 6, 6, 6), ('bingoplus9h3gzh', NULL, NULL, NULL, 7), ('bingoplusbz3nd9', NULL, NULL, NULL, 7), ('bingopluspksaay', 7, 7, 4, 7),
    ('bingoplus4rl8cx', NULL, NULL, NULL, 7), ('bingopluszr2fve', 5, 4, 5, 5), ('bingoplusgstfub', 7, 3, 6, 7), ('bingoplus25td5g', 1, 1, 7, 2), ('peryaj8du8uu', 7, 7, 1, 7),
    ('bingoplush6hvt2', NULL, NULL, NULL, 7), ('peryangq1dhl', 4, 4, 5, 5), ('bingoplusjvfdeu', 1, 1, 4, 2), ('bingoplus7dfgv7', 7, 7, 6, 6), ('bingoplus99j729', 4, 6, 4, 4),
    ('bingoplusds198t', NULL, NULL, NULL, 7), ('bingoplusfc02l7', 6, 7, 7, 7), ('bingopluslnzkq7', 4, 4, 3, 5), ('bingopluspu0sbd', 7, 7, 7, 7), ('bingoplusmrax4b', NULL, NULL, NULL, 7),
    ('lpki9oujh', 7, 7, 2, 1), ('bingoplus97unsx', 7, 7, 7, 7), ('bingoplusswrjdy', 7, 7, 6, 7), ('bingopluscrwqfb', 6, 7, 6, 7), ('bingoplusaqwjj0', 6, 6, 6, 5),
    ('aivy20', 7, 7, 7, 7), ('bingoplus2aow2a', NULL, NULL, NULL, 7), ('lp22rhh4p', 7, 7, 6, 7), ('bingoplustkrfrv', 7, 7, 7, 7), ('bingopluswxf4bx', 2, 2, 1, 2),
    ('bingoplusrqg0ta', 7, 7, 4, 7), ('bingopluspy7r1m', 1, 1, 4, 7), ('bingoplusfsyufv', 4, 2, 7, 2), ('bingoplus21m6wk', NULL, NULL, NULL, 5), ('bingoplusel89rx', 7, 7, 6, 3),
    ('lpzh8j4n', NULL, NULL, NULL, 6), ('bingoplusf4430j', 7, 7, 6, 6), ('lpa9hnxt', NULL, NULL, NULL, 7), ('bingopluskgdktr', NULL, NULL, NULL, 6), ('perya4ivu3u5', 7, 6, 6, 7),
    ('bingoplusjkwqef', 7, 7, 7, 7), ('gp5qgkfk', 6, 7, 6, 6), ('bingoplusaa2cg4', 7, 7, 4, 6), ('bingoplussw4wuw', NULL, NULL, NULL, 7), ('gpeg94uv', NULL, NULL, NULL, 7),
    ('bingoplusa9tthh', 6, 6, 6, 7), ('bingoplusk6zvjf', 7, 7, 6, 7), ('bingoplusd415b4', 6, 4, 6, 6), ('bingoplus0ebfx7', 5, 5, 5, 5), ('bingopluspqe39n', 7, 7, 7, 7),
    ('bingoplusr882r7', 7, 5, 6, 6), ('peryav2etuat', 7, 7, 6, 7), ('bingoplusiupusb', NULL, NULL, NULL, 7), ('bingoplusqh55ad', NULL, NULL, NULL, 1), ('april06', 1, 1, 3, 1),
    ('bingoplus0g3777', 6, 6, 7, 6), ('bingoplushg6w9m', 4, 3, 4, 4), ('bingoplus4ddfc3', 7, 7, 7, 7), ('bingoplus383oh1', 7, 7, 4, 7), ('bingoplust5issz', 5, 5, 5, 4),
    ('bingoplusd659hv', 7, 7, 6, 7), ('bingoplus9ya5qy', 2, 1, 7, 1), ('bingoplusj4eg1h', NULL, NULL, NULL, 7), ('bingopluspqoygt', 5, 5, 6, 6), ('bingoplus75w8z8', NULL, NULL, NULL, 6),
    ('bingoplusrx5lu7', 7, 7, 7, 7), ('bingoplus89l6f8', 7, 6, 4, 6), ('wnxjh648', NULL, NULL, NULL, 7), ('lp8yhfjg2', 7, 4, 7, 7), ('lpnp9jg0w', 7, 7, 4, 7),
    ('bingoplus2ivonl', 7, 7, 7, 7), ('bingoplusyfwy9w', 7, 4, 2, 5), ('bingoplusj5vq9e', 7, 7, 7, 7), ('bingoplus216pfy', 7, 7, 5, 7), ('lp66bx64y', 7, 7, 6, 6),
    ('bingoplusy2pqzb', 7, 7, 6, 7), ('bingoplusyknspl', NULL, NULL, NULL, 6), ('bingoplustlx8f2', 4, 3, 2, 3), ('bingoplusx98vpm', 7, 4, 3, 7), ('bingopluskxh7mv', NULL, NULL, NULL, 2),
    ('bingoplusanbzxf', 6, 5, 4, 7), ('bingoplus2m6dhe', 7, 7, 7, 7), ('bingoplusglxbnz', NULL, NULL, NULL, 5), ('bingoplusse34aa', 1, 1, 4, 2), ('bingoplus5p1e1s', 5, 5, 4, 5),
    ('bingoplustdw4bk', 6, 6, 4, 5), ('bingoplus7z8oyk', 7, 7, 7, 7), ('bingoplusyjjp3z', 4, 4, 6, 4), ('bingoplus6o3tqx', 6, 6, 6, 5), ('bingoplusy9ezk4', 7, 5, 4, 4),
    ('bingoplusqzp452', 7, 7, 6, 7), ('bingoplus6k38zg', NULL, NULL, NULL, 7), ('bingoplusz8q3vz', 7, 7, 6, 7), ('bingoplusbzuwee', 6, 7, 7, 7), ('bingoplusi2oi44', 5, 7, 6, 5),
    ('lptojxkkh', 7, 7, 7, 7), ('bingoplusvqxdua', 7, 7, 7, 7), ('bingoplus3ac7ht', 7, 7, 4, 7), ('bingoplusu3o2gx', NULL, NULL, NULL, 7), ('bingoplus3wtpmy', 7, 7, 6, 7),
    ('perya8k8arlk', 5, 5, 7, 4), ('bingoplusayupvd', NULL, NULL, NULL, 4), ('lpb7qxn5', 7, 7, 7, 7), ('bingoplusm08hsy', 5, 4, 6, 4), ('lpajv2gti', 7, 4, 6, 7),
    ('bingoplusrajn8b', 5, 5, 4, 4), ('bingoplusnvp47d', 7, 7, 4, 7), ('bingoplusf7x5m8', 7, 7, 1, 7), ('bingoplustozkpl', 6, 6, 4, 6), ('gpmb68df', NULL, NULL, NULL, 7),
    ('bingoplusfktkds', 7, 7, 6, 7), ('bingoplus2gmtnp', 7, 7, 7, 4), ('bingoplusl54uqo', 7, 5, 6, 6), ('bingoplusw8twax', 7, 7, 4, 7), ('lpuz88uat', NULL, NULL, NULL, 5),
    ('peryag41cd2p', NULL, NULL, NULL, 7), ('bingoplus6hw8em', 6, 5, 4, 5), ('bingoplus8a7v72', 7, 5, 6, 6), ('bingoplusxhwach', 7, 7, 7, 7), ('bingoplus5btfdm', 3, 1, 4, 1),
    ('bingoplusm6xtkd', 7, 7, 7, 7), ('bingoplusl7ltck', 7, 7, 6, 7), ('bingoplusrfdnhd', 7, 7, 7, 5), ('bingoplus6anb6s', 4, 4, 5, 4), ('spin86mcwt', 7, 7, 7, 7),
    ('bingoplus6fadg8', 4, 4, 4, 5), ('bingoplusajrok2', NULL, NULL, NULL, 5), ('lpw9efrve', 7, 7, 4, 7), ('bingoplus4drz0i', 7, 7, 5, 7), ('bingoplusuty8bd', 5, 7, 4, 2),
    ('bingoplus2j4ren', NULL, NULL, NULL, 6), ('bingopluscs2029', NULL, NULL, NULL, 7), ('bingopluszdvtq5', 7, 7, 7, 7), ('lpwwbgecu', 7, 7, 7, 7), ('bingoplus56m8fe', 6, 6, 4, 4),
    ('sadclown0204', 5, 3, 6, 4), ('bingoplusrs7dgs', 7, 7, 6, 7), ('bingoplusa97582', 1, 1, 1, 1), ('bingoplusjha0nz', 5, 4, 7, 3), ('gpfsntan', NULL, NULL, NULL, 7),
    ('perya7g4xsnc', NULL, NULL, NULL, 7), ('gpczbmmy', 7, 7, 6, 7), ('bingoplusxscaq4', 4, 4, 2, 4), ('lpg00w5hp', 7, 7, 7, 7), ('bingoplus9frkpm', 1, 5, 4, 2),
    ('bingoplusdky2ud', 7, 7, 7, 7), ('bingoplustdxh7o', 7, 7, 6, 7), ('bingopluscljf58', 7, 7, 7, 7), ('bingoplussc6rtl', 7, 7, 6, 7), ('bingoplusq7ctqh', NULL, NULL, NULL, 7),
    ('bingoplus2yr2jg', 4, 4, 6, 4), ('bingoplusv2m6tl', 3, 3, 4, 4), ('bingopluso6o3vv', 7, 7, 7, 7), ('bingoplusrdjg1s', 7, 7, 7, 6), ('bingopluslvdrbk', 1, 1, 7, 1),
    ('bingoplusm4jbse', 7, 7, 6, 7), ('bingoplus04h6lq', 7, 7, 7, 7), ('lpf7jch46', 7, 7, 6, 7), ('bingopluscbxb87', 7, 7, 6, 6), ('bingoplusgyng9w', 7, 7, 7, 7),
    ('bingoplus6d6vsk', 1, 2, 7, 3), ('lp4idbjkl', 5, 5, 6, 7), ('bingoplust9gf6b', 7, 7, 6, 7), ('peryap0gtcg1', NULL, NULL, NULL, 7), ('bingopluszrgtiq', 6, 5, 6, 6),
    ('bingoplusy2vmue', 7, 7, 7, 7), ('bingoplusl4uf9y', 7, 6, 4, 7), ('bingoplus7g8gpu', 4, 4, 4, 4), ('bingoplusiik3qf', 7, 7, 6, 7), ('bingoplusjvwfoz', 7, 7, 7, 7),
    ('bingoplusce2j5n', NULL, NULL, NULL, 7), ('bingoplus9ya4so', 7, 7, 6, 7), ('bingoplusnc2q4e', NULL, NULL, NULL, 3), ('bingoplusjd7jee', NULL, NULL, NULL, 6), ('bingoplusvkx9ht', 6, 6, 7, 7),
    ('lpd7cj3c7', 7, 7, 7, 7), ('lpfiilt3u', 7, 7, 7, 7), ('bingoplusdajjny', 7, 7, 5, 5), ('bingoplusjyn7uz', 7, 7, 7, 7), ('bingoplusm92qfj', NULL, NULL, NULL, 6),
    ('bingopluslcxd50', 7, 7, 7, 7), ('bingoplusd7he5s', 7, 7, 1, 7), ('bingoplus7jbm6t', 2, 1, 4, 1), ('perya9lja76l', NULL, NULL, NULL, 5), ('bingoplusm4w2ak', 7, 7, 7, 7),
    ('lpb03jsp2', NULL, NULL, NULL, 7), ('bingoplus9dlxsp', 6, 7, 2, 6), ('gp5w4jef', 7, 7, 7, 7), ('bingoplus72t40t', 5, 5, 6, 6), ('bingoplusn33n99', 1, 1, 1, 1),
    ('lpmrgnz0l', NULL, NULL, NULL, 7), ('bingoplusnqrhxg', 4, 5, 4, 5), ('bingoplusvbaun9', 7, 7, 7, 7), ('bingoplusq2tmrj', 7, 7, 6, 7), ('bingoplus5kt29m', 7, 7, 6, 7),
    ('bingoplusg1ueqb', NULL, NULL, NULL, 7), ('bingoplus9gsyxg', 6, 7, 1, 6), ('bingoplusjz634m', NULL, NULL, NULL, 7), ('bingoplusq58kf1', 7, 7, 7, 6), ('bingoplus6latm4', 7, 7, 7, 7),
    ('bingoplus5zqjs9', 7, 7, 7, 7), ('bingoplusr9hhjf', 7, 7, 7, 7), ('bingoplusm872gy', NULL, NULL, NULL, 4), ('bingoplus62y7ca', 7, 7, 3, 7), ('bingoplus91vqlk', 4, 6, 4, 4),
    ('bingopluso2v4lb', 7, 7, 7, 7), ('bingoplushuhiel', NULL, NULL, NULL, 7), ('vibercgwsrs3', 7, 7, 7, 7), ('gpnh42f6', 7, 7, 2, 7), ('bingoplusfsgw1v', 7, 7, 7, 7),
    ('bingoplusa8vuzs', 7, 7, 7, 7), ('lpdz6px6l', 7, 7, 7, 7), ('bingoplus0yw0q8', NULL, NULL, NULL, 7), ('bingoplusv9jrqc', 2, 1, 7, 2), ('bingoplusvkanud', 7, 7, 6, 7),
    ('gpd2dtss', 7, 7, 6, 7), ('peryam4qbm1n', NULL, NULL, NULL, 7), ('bingoplusrc7hpu', 1, 1, 3, 6), ('bingoplusgms45h', 5, 5, 4, 5), ('bingoplussnd98q', 3, 3, 5, 4),
    ('lpbmnp6xy', 6, 7, 7, 1), ('bingoplusrr0kfl', NULL, NULL, NULL, 7), ('bingoplusdpb7qe', NULL, NULL, NULL, 1), ('lpcatvll5', 7, 7, 7, 7), ('gpfch2we', 7, 7, 7, 7),
    ('rbmarzan09', 5, 5, 6, 5), ('lphaa45x', NULL, NULL, NULL, 1), ('bingopluscuz0q6', 7, 7, 4, 7), ('bingopluswa33mc', 4, 2, 4, 3), ('bingoplusseb64n', NULL, NULL, NULL, 1),
    ('bingoplus24cq83', 5, 6, 6, 6), ('bingoplusd8n8i9', 6, 6, 7, 6), ('bingoplusirfp65', 7, 7, 7, 7), ('lph0cye04', NULL, NULL, NULL, 7), ('jeeno1968', NULL, NULL, NULL, 5),
    ('bingoplus4aqmcz', 7, 7, 7, 7), ('bingoplus9l9fyc', NULL, NULL, NULL, 2), ('bingopluswnnfff', 7, 7, 6, 7), ('bingoplusg6dxof', 7, 5, 1, 2), ('bingoplusxnb7fr', 4, 5, 6, 7),
    ('gpj328da', 7, 7, 7, 7), ('bingoplusw5q5zk', 7, 7, 7, 7), ('bingoplusql0j7z', NULL, NULL, NULL, 7), ('bingoplus3r3ygy', 7, 7, 7, 7), ('bingoplus8ddd43', NULL, NULL, NULL, 7),
    ('lp0p2ru0u', 7, 7, 6, 7), ('bingoplusg0dtin', 3, 2, 4, 2), ('gpxmcjhd', 3, 3, 4, 4), ('bingoplus2geow0', 5, 5, 1, 7), ('lpf036ncj', 7, 7, 7, 7),
    ('bingoplusges2fw', 6, 6, 2, 6), ('bingoplusfmwzqm', 7, 7, 7, 7), ('bingoplus94folr', 7, 7, 5, 7), ('gpwwkz5p', 7, 7, 7, 7), ('bingoplusg2f2dj', NULL, NULL, NULL, 7),
    ('bingoplusrh4nqu', 7, 7, 7, 7), ('lpxzz1x8s', NULL, NULL, NULL, 5), ('tg8lmmylm', NULL, NULL, NULL, 7), ('bingoplusq4kjkx', 7, 7, 7, 7), ('bingoplus979a6u', 4, 4, 4, 4),
    ('bingoplusccxmat', 6, 6, 6, 6), ('bingoplusxy8avi', 1, 1, 1, 1), ('bingoplusqhk08d', 7, 7, 7, 7), ('bingoplus1l2mip', NULL, NULL, NULL, 7), ('lphd9zpd', 3, 3, 3, 2),
    ('bingoplusy2sc37', 7, 7, 7, 7), ('bingoplusc5t3sk', NULL, NULL, NULL, 7), ('peryai0wdqiv', 5, 5, 3, 1), ('bingoplusw0go3f', 5, 5, 4, 4), ('bingoplusrlkgzm', 7, 6, 6, 7),
    ('bingoplusr1org9', 6, 6, 6, 6), ('bingopluss2snwt', 4, 4, 5, 4), ('bingoplusp5jpgm', 3, 5, 4, 5), ('bingoplusy8rjnu', 7, 7, 6, 7), ('bingopluswzzya2', 1, 1, 2, 1),
    ('bingoplusugrsh7', 4, 4, 6, 5), ('bingoplusuucdro', 7, 7, 7, 7), ('bingoplusxgwcb3', 7, 7, 7, 7), ('bingoplusltby4e', 7, 7, 6, 6), ('bingoplus2gplae', NULL, NULL, NULL, 7),
    ('bingoplus4gn6j8', 4, 4, 4, 6), ('bingoplus5r7xcw', 7, 7, 4, 7), ('bingoplusp9d5q8', 7, 4, 4, 7), ('bingoplushr8zmx', 7, 7, 5, 4), ('bingoplus4zpu0m', NULL, NULL, NULL, 7),
    ('bingoplus4a84u7', 1, 1, 4, 1), ('lp46bmr9', 7, 4, 6, 7), ('lpzslbf1x', 5, 3, 3, 4), ('bingoplus5rpj16', NULL, NULL, NULL, 7), ('gpcxncgm', NULL, NULL, NULL, 7),
    ('lpv894dpf', 5, 5, 4, 5), ('perya8x6rhr7', 7, 7, 6, 7), ('bingoplus8c16ax', 6, 5, 5, 6), ('lpg22zrhb', 4, 4, 6, 7), ('bingoplusqgvwco', NULL, NULL, NULL, 7),
    ('bingoplusf7m9jb', 7, 7, 7, 7), ('lpax55hj5', 7, 7, 6, 7), ('bingoplusrpxhky', 2, 2, 7, 1), ('bingoplusv2e7be', 6, 7, 5, 7), ('bingopluspqhssv', NULL, NULL, NULL, 4),
    ('bingopluscjn1vd', 7, 7, 7, 7), ('lpvjwh7m3', 7, 7, 4, 7), ('bingoplusxv8ver', NULL, NULL, NULL, 7), ('lpwe8z62z', 7, 7, 3, 7), ('bingoplusgmcrfm', 7, 7, 7, 7),
    ('bingoplusck4paj', 7, 7, 6, 7), ('bingoplus1m63zm', 7, 7, 7, 7), ('bingoplusj8d8kn', 7, 7, 6, 7), ('bingoplusd7sdcf', NULL, NULL, NULL, 2), ('bingoplus44bgd1', 4, 4, 3, 3),
    ('bingoplustl1x8m', 2, 2, 5, 4), ('bingoplusadqxf2', 7, 7, 7, 7), ('bingoplusxo2u0b', 7, 7, 7, 7), ('bingoplusb70f8o', 7, 7, 7, 7), ('bingoplusptoz43', 7, 7, 7, 7),
    ('bingopluslg1zta', 3, 1, 4, 2), ('bingopluscj97wp', 5, 4, 4, 7), ('lpgn7wppu', NULL, NULL, NULL, 7), ('lp8umggv', 7, 3, 4, 6), ('bingoplusz5x1r2', 7, 7, 6, 7),
    ('bingoplus5umtvo', 7, 7, 6, 7), ('bingoplus2ufdzk', 7, 7, 6, 7), ('bingoplus7ljsra', 7, 5, 7, 7), ('bingoplusemmygf', 7, 5, 6, 7), ('bingoplusybvy2f', 7, 5, 6, 6),
    ('lpvc87mzo', NULL, NULL, NULL, 7), ('bingoplus8gpnkg', NULL, NULL, NULL, 4), ('bingoplusaah8ho', 7, 7, 6, 7), ('bingoplus1fmhyf', 7, 7, 7, 7), ('bingoplusuquylj', 7, 7, 4, 7),
    ('bingoplus6eilus', 7, 7, 7, 7), ('gpc6z6p2', 5, 5, 7, 7), ('bingoplushgf1mn', 6, 6, 7, 6), ('bingoplusipmlsx', 7, 7, 7, 7), ('gprub56k', 5, 5, 6, 6),
    ('bingoplus9ce0yj', 4, 3, 4, 4), ('bingoplus9thwq4', 7, 1, 7, 2), ('lph3rf4wl', 7, 7, 6, 7), ('bingopluspvf0rg', 7, 7, 7, 7), ('bingoplusr2y34v', 7, 7, 7, 7),
    ('bingoplusjwq3eq', 5, 4, 5, 5), ('bingoplus3y9gcz', 7, 7, 7, 7), ('bingoplus7uno9a', 5, 5, 5, 5), ('gpbm8xyp', 7, 7, 6, 7), ('bingoplusjyikxu', NULL, NULL, NULL, 7),
    ('bingoplusjcny5s', 7, 7, 7, 7), ('lpbvna66x', NULL, NULL, NULL, 1), ('lp5oyv3cv', NULL, NULL, NULL, 5), ('bingoplussmwqhm', 1, 1, 7, 1), ('bingoplus66qgn8', 4, 4, 6, 4),
    ('gppsgcfm', NULL, NULL, NULL, 2), ('bingoplus5vjj1t', 1, 1, 7, 7), ('bingoplush5bysz', 7, 7, 6, 7), ('bingoplus97cax0', 3, 3, 4, 2), ('bingoplusbu83ss', 7, 1, 7, 7),
    ('bingoplusctj4gg', 7, 7, 6, 7), ('benigno1974', 4, 4, 5, 4), ('bingopluscobx7p', NULL, NULL, NULL, 7), ('bingoplus4f5hxe', 7, 7, 6, 7), ('bingoplusbtuenf', 5, 6, 4, 4),
    ('gp4da3vk', NULL, NULL, NULL, 5), ('bingoplus0afe28', 7, 7, 4, 7), ('bingoplus4bfaqk', 4, 5, 2, 7), ('bingoplus69gxrn', 7, 7, 6, 7), ('bingoplus820veb', NULL, NULL, NULL, 4),
    ('bingoplus2wenk5', 7, 7, 7, 7), ('bingoplus561qvr', NULL, NULL, NULL, 7), ('bingoplusry3qto', 7, 7, 4, 7), ('bingoplusb39wzq', 7, 7, 6, 7), ('bingoplush3gjzv', 6, 6, 5, 7),
    ('bingoplusw4pxz5', 7, 6, 4, 4), ('bingoplusgoizs3', 7, 7, 4, 7), ('bingoplus7ta0ev', 7, 7, 3, 7), ('bingoplusgiu4xp', 5, 4, 4, 4), ('bingoplusyzka26', 5, 1, 7, 1),
    ('gphy8m35', NULL, NULL, NULL, 7), ('bingopluskpcw7j', 7, 7, 6, 7), ('bingoplus01zmi3', NULL, NULL, NULL, 3), ('bingoplus5zfp3m', 5, 4, 6, 5), ('bingoplusaxjag8', 7, 7, 7, 7),
    ('lpaa11s80', 7, 7, 7, 7), ('bingoplusu8vvmg', NULL, NULL, NULL, 7), ('lp422wfy7', NULL, NULL, NULL, 7), ('bingoplusuzr47m', NULL, NULL, NULL, 7), ('bingoplusp7zz2u', 7, 7, 7, 7),
    ('bingoplus85h3mz', 7, 7, 7, 7), ('bingoplus7fsnsm', 7, 7, 3, 4), ('bingoplusjq3s23', 7, 7, 5, 7), ('bingoplus6qf1p4', 7, 5, 6, 5), ('bingopluson4xt8', 7, 7, 7, 7),
    ('peryabx0sjot', 7, 7, 1, 7), ('bingoplushuzyt0', 6, 3, 4, 5), ('bingoplus9vdlki', 7, 7, 7, 7), ('bingoplusjyamby', 7, 6, 7, 7), ('bingoplusb4en64', 6, 5, 7, 6),
    ('bingoplus5twfq6', NULL, NULL, NULL, 4), ('lp0ganypx', 6, 4, 4, 5), ('bingoplushhvnm9', 4, 2, 7, 4), ('bingoplusgdhso1', 5, 7, 7, 4), ('bingoplusg69xdq', 7, 7, 7, 5),
    ('bingoplusddudfc', NULL, NULL, NULL, 5), ('bingoplusc4gw7k', 1, 7, 2, 1), ('bingoplusc42htt', 5, 4, 6, 5), ('peryasdo56iv', NULL, NULL, NULL, 6), ('bingoplusomn3do', 6, 6, 6, 6),
    ('bingoplusv4b2qd', 7, 7, 7, 7), ('bingoplus53vlmu', 5, 4, 6, 4), ('bingoplusbteth8', NULL, NULL, NULL, 5), ('bingoplus7pa5ln', 7, 7, 7, 7), ('bingoplusgwy4t2', 7, 7, 6, 7),
    ('bingoplusqqgglk', NULL, NULL, NULL, 7), ('bingoplusw9efmy', NULL, NULL, NULL, 7), ('bingoplusmp5ebc', 4, 5, 3, 3), ('bingoplush437ih', 2, 2, 2, 2), ('bingopluscn801i', 5, 4, 7, 6),
    ('bingoplusecsipj', 6, 6, 7, 5), ('bingoplusjj1w9o', NULL, NULL, NULL, 6), ('bingoplusrn3dsj', 7, 7, 4, 7), ('bingoplusu9fm6t', 7, 7, 6, 7), ('bingoplusyv01pd', 4, 4, 5, 4),
    ('bingoplusdwxjlo', 7, 7, 7, 6), ('bingoplus0ym4i8', NULL, NULL, NULL, 6), ('bingoplusovnn2t', 7, 7, 7, 7), ('bingoplusjp141b', 7, 6, 7, 7), ('bingoplusw9wkj6', NULL, NULL, NULL, 5),
    ('lpe5xtwk', 1, 7, 6, 7), ('peryageoigtk', 4, 4, 7, 4), ('bingoplusjpvkyi', 6, 6, 6, 7), ('lp4uc3ytm', 4, 4, 5, 4), ('gp5txcr4', 7, 7, 7, 7),
    ('bingoplusaz6pzj', NULL, NULL, NULL, 4), ('bingoplusf3k2m6', 7, 7, 7, 7), ('lp0035xsa', 5, 6, 7, 5), ('bingoplusy2hp45', 7, 7, 5, 7), ('bingoplus9sk2sf', 7, 7, 7, 7),
    ('bingoplusvk7c6l', 7, 7, 7, 7), ('gpjgwaux', NULL, NULL, NULL, 5), ('bingoplusnibkbo', 6, 6, 6, 6), ('bingoplusehpr0z', 7, 7, 7, 7), ('bingoplusswczt7', 7, 6, 6, 6),
    ('lp9umpsuj', NULL, NULL, NULL, 6), ('peryayv3ds3c', NULL, NULL, NULL, 7), ('bingoplus2ruzyg', 7, 7, 7, 7), ('bingoplus5tzw8d', NULL, NULL, NULL, 4), ('bingoplus6nzvdg', NULL, NULL, NULL, 5),
    ('bingoplust7irwz', NULL, NULL, NULL, 7), ('bingoplus4egmbt', NULL, NULL, NULL, 7), ('bingoplusw0hdny', NULL, NULL, NULL, 7), ('bingopluss623y0', NULL, NULL, NULL, 5), ('bingoplus19nrve', NULL, NULL, NULL, 7),
    ('bingoplus59yyij', NULL, NULL, NULL, 7), ('lpsvoks76', 7, 7, 7, 7), ('bingoplusi2xlft', 7, 7, 7, 7), ('bingoplus2ddp3a', 7, 7, 7, 7), ('bingoplus8cprvm', 7, 7, 6, 6),
    ('bingopluspnbv6f', 7, 7, 7, 7), ('bingoplus52e7mu', 6, 7, 6, 7), ('bingoplusy3p3xm', NULL, NULL, NULL, 7), ('bingoplusj4njim', 7, 7, 7, 7), ('bingoplusp00yqw', NULL, NULL, NULL, 4),
    ('lpfwkjvkq', 6, 6, 7, 6), ('bingoplus55iq0b', 1, 1, 1, 1), ('bingoplusearb69', 4, 4, 5, 4), ('bingoplusxgik1p', 7, 7, 6, 7), ('bingopluskme900', 2, 1, 1, 1),
    ('bingoplus33nc4a', 5, 6, 5, 3), ('bingoplusdhwawo', NULL, NULL, NULL, 4), ('bingoplusjbatcu', 5, 7, 7, 7), ('bingopluscvk61z', 6, 7, 6, 6), ('bingoplus3kyajp', 6, 4, 2, 6),
    ('lpkkhyqtx', 4, 4, 5, 4), ('perya3e5snhs', NULL, NULL, NULL, 7), ('bingoplusuenj5v', NULL, NULL, NULL, 7), ('bingoplus6jsmk0', 6, 6, 6, 4), ('bingoplus1zlnym', 7, 7, 4, 7),
    ('bingoplus7p2ve4', 7, 7, 7, 7), ('bingoplusmj27mb', NULL, NULL, NULL, 4), ('lpkbxueqz', 7, 7, 4, 7), ('bingoplus8boxoz', 7, 7, 4, 7), ('bingopluspnxpj9', 7, 7, 6, 7),
    ('lpyzvv7li', 7, 7, 4, 7), ('peryaterkkzy', 7, 7, 5, 6), ('bingoplusp8p2fm', 7, 7, 7, 7), ('lp958cns', 7, 7, 6, 7), ('bingoplusbjbtq5', 7, 7, 7, 7),
    ('bingoplusqcncrb', 5, 5, 4, 4), ('lp74ootiq', 7, 7, 6, 7), ('bingoplus8kgkde', 7, 7, 5, 7), ('lpm29g0ng', 7, 7, 7, 7), ('bingoplushdgu27', 7, 7, 7, 7),
    ('bingoplusr6drdm', 7, 7, 7, 4), ('bingopluss0u6rv', 7, 7, 7, 7), ('bingoplus57meoh', 7, 7, 7, 7), ('bingoplus6z9tjq', 5, 3, 6, 5), ('bingoplusab80cw', 6, 7, 5, 7),
    ('bingoplusuahy43', 7, 7, 7, 7), ('gpxgawer', 7, 7, 7, 7), ('bingopluss31cnx', NULL, NULL, NULL, 7), ('bingoplus24gx7m', 7, 7, 7, 7), ('bingoplus2vm17l', 7, 7, 7, 7),
    ('bingoplusihytj5', 7, 7, 7, 7), ('bingoplustwn6a9', 7, 4, 3, 7), ('bingoplus8clq74', NULL, NULL, NULL, 7), ('bingoplusx6j9gw', 7, 7, 7, 7), ('bingoplusyaa8g4', 7, 7, 7, 7),
    ('bingoplusmqs9d3', 7, 7, 6, 7), ('bingoplushuvbyu', 6, 5, 6, 5), ('bingoplustrj57j', 7, 7, 6, 7), ('bingopluslc7dov', 2, 2, 4, 4), ('bingoplusgzxlda', 6, 6, 4, 4),
    ('bingoplusnwpb2r', 7, 7, 7, 7), ('bingoplusq37xbk', 1, 7, 4, 7), ('perya7holf59', 7, 7, 7, 7), ('bingoplus0x7alr', 7, 7, 7, 7), ('bingoplusv2zi9y', 7, 7, 6, 7),
    ('gpvey73v', 4, 3, 6, 4), ('bingoplusvgvca6', 4, 3, 4, 6), ('bingoplusfc6iaj', 4, 4, 5, 4), ('bingoplussnmw2w', 7, 7, 7, 7), ('bingopluslv28w9', 6, 6, 5, 5),
    ('bingoplus3naiko', NULL, NULL, NULL, 4), ('harleneabay', 7, 7, 4, 3), ('bingoplusuhgsx8', 5, 6, 3, 5), ('bingoplus8mlgw3', 7, 4, 4, 4), ('bingoplusiel45n', 1, 1, 4, 1),
    ('bingoplus2xw56d', 7, 7, 6, 7), ('bingoplus8jrxj3', 1, 1, 1, 1), ('bingoplus68qcuf', 7, 7, 2, 7), ('bingoplusosuqqd', 7, 7, 7, 7), ('bingoplus0hyhsc', NULL, NULL, NULL, 7),
    ('bingoplusjqrm6j', 7, 7, 7, 7), ('bingoplus3p69zm', NULL, NULL, NULL, 7), ('lputyacm6', 7, 7, 6, 7), ('bingoplusd8s72c', 7, 7, 4, 7), ('bingoplus9v0fzc', 7, 7, 6, 6),
    ('peryaaj02q9x', 7, 7, 7, 7), ('lpdlj00b9', 7, 7, 7, 7), ('bingoplushvx2ok', 6, 6, 7, 6), ('bingoplus6fickt', 7, 7, 7, 7), ('bingoplusmyq3oq', 7, 7, 7, 7),
    ('bingopluslx0mg9', 7, 7, 7, 7), ('bingopluspm7wn0', NULL, NULL, NULL, 5), ('perya8opxjmh', 7, 7, 7, 7), ('peryagtmfggf', 7, 7, 7, 7), ('bingoplusgy449m', 7, 7, 7, 7),
    ('bingopluspwsamn', 5, 5, 4, 5), ('bingoplusw7d1ss', 5, 5, 6, 6), ('bingoplus7solyo', 7, 7, 7, 7), ('bingoplusa7hnss', 5, 5, 6, 7), ('bingoplus81pcrl', 7, 7, 7, 7),
    ('bingoplusgpdtdd', 7, 7, 5, 7), ('bingoplus34awwv', 7, 7, 6, 7), ('bingopluscm6sw7', 6, 6, 6, 6), ('bingopluscj1tco', 7, 7, 4, 7), ('bingoplusyk6q0o', 7, 7, 7, 7),
    ('bingoplus5v5g6j', 7, 7, 7, 7), ('bingopluss3qp9t', NULL, NULL, NULL, 1), ('bingoplusvzu3s3', NULL, NULL, NULL, 7), ('lp7jnmn0o', 5, 3, 7, 4), ('atvbc639', NULL, NULL, NULL, 5),
    ('bingoplusavvvkg', 7, 4, 5, 6), ('lppks4ic0', 7, 7, 7, 7), ('johnmarquez', 7, 7, 7, 7), ('bingopluse0a0x3', 5, 5, 6, 5), ('lpwm42kcc', 7, 7, 4, 7),
    ('peryat3q6368', 6, 7, 7, 7), ('bingopluswb9xws', 7, 7, 7, 7), ('bingoplus5gsxm2', 7, 7, 7, 7), ('bingoplusesqpcv', 6, 6, 6, 6), ('bingoplus6mcybu', 7, 7, 7, 7),
    ('bingoplus8zl618', 7, 7, 7, 7), ('bingoplus5k9c55', NULL, NULL, NULL, 7), ('bingoplus34wq51', 7, 7, 7, 7), ('bingoplusg46wio', NULL, NULL, NULL, 5), ('bingoplusm46ast', 7, 7, 3, 7),
    ('bingopluslgtn4s', 7, 7, 6, 7), ('bingopluscvqxaa', 7, 7, 7, 7), ('bingopluscfmf1y', 1, 1, 1, 1), ('lp844yt8', 4, 4, 5, 5), ('bingoplusdewqg7', 3, 4, 5, 4),
    ('bingoplusxofhkg', 7, 7, 7, 7), ('bingoplusxu9fyg', 7, 7, 6, 7), ('lp1uic7yw', NULL, NULL, NULL, 7), ('lp60zmnrr', 7, 7, 6, 5), ('bingoplusqsj6a7', 7, 7, 7, 7),
    ('bingopluscfxogo', 7, 7, 7, 7), ('bingoplus3r83qg', 7, 7, 7, 7), ('bingoplusckblr1', 7, 7, 7, 7), ('bingoplusu1k7dq', 5, 6, 4, 4), ('bingoplusfdixo7', 5, 3, 6, 7),
    ('peryaif7dzdp', 5, 5, 6, 5), ('bingoplusnkslzg', 7, 7, 7, 7), ('bingoplusk09mm0', 6, 6, 6, 6), ('bingoplusdxba8c', 7, 7, 7, 7), ('lp9dni42x', 7, 7, 7, 7),
    ('bingoplus6hkdy7', NULL, NULL, NULL, 7), ('gpjuvwta', NULL, NULL, NULL, 7), ('bingoplusibgijh', 2, 4, 4, 4), ('lpurz0s7q', 7, 7, 6, 7), ('bingoplusywzpxb', 7, 7, 7, 7),
    ('bingoplusivkvay', 7, 7, 6, 7), ('bingoplusskgdsn', 7, 7, 7, 6), ('lp7ehz1fj', 7, 7, 7, 7), ('bingoplus7uwpdk', 7, 7, 7, 7), ('gpfprfrw', NULL, NULL, NULL, 7),
    ('bingoplusn6brmd', 7, 7, 4, 7), ('bingoplushc6ggh', 7, 7, 7, 7), ('bingoplusc8j1hf', 7, 6, 3, 5), ('bingoplus1s8cgw', 7, 7, 4, 7), ('bingoplusx054rv', 5, 5, 5, 5),
    ('peryaknbn6lt', NULL, NULL, NULL, 7), ('bingoplusnt3um1', 7, 7, 7, 7), ('bingopluswqy2x7', 7, 7, 7, 7), ('bingoplushxbizg', 7, 7, 7, 7), ('lp8oi08bd', 7, 4, 7, 7),
    ('bingoplus4n333f', 7, 7, 7, 7), ('bingoplus2erwsu', 7, 7, 6, 7), ('lp6bry6c', 7, 7, 7, 7), ('bingoplusyhh01d', 7, 7, 7, 7), ('bingoplusqhx0wq', 6, 6, 6, 6),
    ('bingoplusu2w354', 7, 7, 6, 3), ('lpt8e7pt', 5, 4, 3, 5), ('bingoplusbhe26f', 7, 5, 6, 7), ('bingoplusb61kte', 7, 7, 7, 7), ('bingoplus1jj2v0', NULL, NULL, NULL, 7),
    ('bingoplushj2e6g', 6, 6, 6, 7), ('bingoplusyoxsvn', 7, 7, 7, 7), ('bingoplusbgqqj5', 7, 7, 6, 7), ('perya53fhk2t', 7, 7, 7, 7), ('bingoplus7hhp8m', 7, 7, 5, 7),
    ('bingoplusy3he7s', 5, 5, 4, 6), ('bingoplus6ce1gy', 4, 4, 6, 3), ('gela96', 7, 7, 7, 7), ('bingoplusd8euqt', 7, 7, 7, 7), ('bingoplus9uax15', NULL, NULL, NULL, 5),
    ('bingoplus4faz2g', 7, 7, 5, 7), ('bingopluspcdubp', 6, 6, 5, 6), ('bingoplush5ae1c', 7, 7, 7, 7), ('bingoplusfw7z1e', 7, 7, 6, 7), ('gpzmqmds', 5, 4, 7, 7),
    ('bingoplusvaq9tv', 4, 3, 4, 5), ('bingoplusay6uxl', 6, 6, 6, 6), ('bingoplusllqwx6', 7, 7, 6, 7), ('bingoplusfh4oam', 7, 7, 7, 7), ('bingoplusu03h1p', 7, 7, 7, 7),
    ('bingoplussu9o0x', 6, 5, 6, 5), ('bingoplusqu94cv', 5, 5, 5, 4), ('bingoplusgfva5d', 7, 7, 7, 7), ('bingoplusizx64g', NULL, NULL, NULL, 7), ('bingoplus35wm4x', NULL, NULL, NULL, 7),
    ('lpzqc6zgj', 7, 7, 6, 7), ('bingoplus045sue', 7, 7, 7, 7), ('bingoplush61f7u', 7, 7, 7, 7), ('bingoplus3714zp', 7, 7, 7, 7), ('bingoplusvtbi5n', 6, 3, 4, 5),
    ('bingoplusmvkd1e', 7, 7, 7, 7), ('bingoplusk86zwf', NULL, NULL, NULL, 7), ('bingoplus0o8rs5', 7, 7, 7, 7), ('bingopluszc1xmr', 7, 7, 7, 7), ('bingoplus17zxkz', NULL, NULL, NULL, 7),
    ('bingoplusbt8ru2', 7, 7, 6, 7), ('bingopluslfe8bt', NULL, NULL, NULL, 7)
    ) t(login_name, q4_satisfaction, q5_reward_attract, q8_rule_clarity, q26_future_interest)
),

-- 最新集团用户等级
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

-- 骰子发放个数 (9.11-9.24)
dice AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        SUM(born_count) AS dice_count
    FROM superengineproject.ods_mms_t_user_fragments_di
    WHERE pt >= '20260911' AND pt <= '20260924'
    GROUP BY LOWER(TRIM(login_name))
),

-- 核销数据 (9.11-9.24)
redeem_all AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        activity_id,
        CAST(redeem_amount AS DOUBLE) AS redeem_amount
    FROM superengineproject.bi_dwd_all_promo_user_redeem_info_di
    WHERE pt >= '20260911' AND pt <= '20260924'
      AND is_valid_redeem = 1
      AND budget_source_product_line IN ('BP', 'VIBER', 'COMMUNITY')
),

-- 任务核销返水金 (12个activity_id)
task_redeem AS (
    SELECT
        login_name,
        SUM(redeem_amount) AS task_redeem_amount
    FROM redeem_all
    WHERE activity_id IN (
        '6aa103bbe4b07fc7051c16be','6aa10b8be4b07fc726c4c142',
        '6aa10478e4b07fc755e79ad2','6aa10c70e4b07fc77262a6dc',
        '6aa1054ce4b07fc7051c2255','6aa10d5de4b07fc7c517568f',
        '6aa10698e4b07fc7051c28a2','6aa10e47e4b07fc7436a8057',
        '6aa10730e4b07fc7e0cb951c','6aa10f22e4b07fc7c517676a',
        '6aa107afe4b07fc7e0cb974a','6aa1101be4b07fc742522dd2'
    )
    GROUP BY login_name
),

-- 地图核销金额 (2个activity_id)
map_redeem AS (
    SELECT
        login_name,
        SUM(redeem_amount) AS map_redeem_amount
    FROM redeem_all
    WHERE activity_id IN (
        '6aa125ace4b07fc7dccce898','6aa114bfe4b07fc759b3f4c2'
    )
    GROUP BY login_name
),

-- TOP 300 核销金额 (1个activity_id)
top300_redeem AS (
    SELECT
        login_name,
        SUM(redeem_amount) AS top300_redeem_amount
    FROM redeem_all
    WHERE activity_id = '6aa11550e4b07fc749ab00b9'
    GROUP BY login_name
),

-- 大富翁核销金额 (全部15个activity_id)
monopoly_redeem AS (
    SELECT
        login_name,
        SUM(redeem_amount) AS monopoly_redeem_amount
    FROM redeem_all
    WHERE activity_id IN (
        '6aa103bbe4b07fc7051c16be','6aa10b8be4b07fc726c4c142',
        '6aa10478e4b07fc755e79ad2','6aa10c70e4b07fc77262a6dc',
        '6aa1054ce4b07fc7051c2255','6aa10d5de4b07fc7c517568f',
        '6aa10698e4b07fc7051c28a2','6aa10e47e4b07fc7436a8057',
        '6aa10730e4b07fc7e0cb951c','6aa10f22e4b07fc7c517676a',
        '6aa107afe4b07fc7e0cb974a','6aa1101be4b07fc742522dd2',
        '6aa125ace4b07fc7dccce898','6aa114bfe4b07fc759b3f4c2',
        '6aa11550e4b07fc749ab00b9'
    )
    GROUP BY login_name
),

-- 其他活动核销 (排除上述15个activity_id)
other_redeem AS (
    SELECT
        login_name,
        COUNT(DISTINCT activity_id) AS other_activity_count,
        SUM(redeem_amount) AS other_redeem_amount
    FROM redeem_all
    WHERE activity_id NOT IN (
        '6aa103bbe4b07fc7051c16be','6aa10b8be4b07fc726c4c142',
        '6aa10478e4b07fc755e79ad2','6aa10c70e4b07fc77262a6dc',
        '6aa1054ce4b07fc7051c2255','6aa10d5de4b07fc7c517568f',
        '6aa10698e4b07fc7051c28a2','6aa10e47e4b07fc7436a8057',
        '6aa10730e4b07fc7e0cb951c','6aa10f22e4b07fc7c517676a',
        '6aa107afe4b07fc7e0cb974a','6aa1101be4b07fc742522dd2',
        '6aa125ace4b07fc7dccce898','6aa114bfe4b07fc759b3f4c2',
        '6aa11550e4b07fc749ab00b9'
    )
    GROUP BY login_name
),

-- GGR (9.11-9.24)
ggr AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        SUM(bingoggr) AS ggr
    FROM superengineproject.t_daily_bet_all
    WHERE pt >= '20260911' AND pt <= '20260924'
      AND bet_site_id IN (1,5,6,11,33)
    GROUP BY LOWER(TRIM(login_name))
)

SELECT
    /*+MAPJOIN(su)*/
    su.login_name,
    su.q4_satisfaction,
    su.q5_reward_attract,
    su.q8_rule_clarity,
    su.q26_future_interest,
    v.level_current                  AS vip_level,
    d.dice_count                     AS dice_born_count,
    tr.task_redeem_amount,
    mr.map_redeem_amount,
    t3.top300_redeem_amount,
    mp.monopoly_redeem_amount,
    ot.other_redeem_amount,
    ot.other_activity_count,
    g.ggr
FROM survey_users su
LEFT JOIN vip v
    ON su.login_name = v.login_name
LEFT JOIN dice d
    ON su.login_name = d.login_name
LEFT JOIN task_redeem tr
    ON su.login_name = tr.login_name
LEFT JOIN map_redeem mr
    ON su.login_name = mr.login_name
LEFT JOIN top300_redeem t3
    ON su.login_name = t3.login_name
LEFT JOIN monopoly_redeem mp
    ON su.login_name = mp.login_name
LEFT JOIN other_redeem ot
    ON su.login_name = ot.login_name
LEFT JOIN ggr g
    ON su.login_name = g.login_name
;
