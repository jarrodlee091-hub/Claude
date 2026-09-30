-- 活动领取&核销统计 - 新名单
-- 活动周期: 9.11-9.24
-- 用户数: 312

WITH survey_users AS (
    SELECT *
    FROM (
        VALUES
        ('bingoplus6hkdy7', 2696, 'V7', '不知道这个活动', '是', 5118, 49),
        ('bingoplus3naiko', 2577, 'V8', '不知道这个活动', '是', 2906, 18),
        ('bingoplust7irwz', 2462, 'V5', '不知道这个活动', '是', 2838, 27),
        ('lp1uic7yw', 2677, 'V8', '知道但没参加', '是', 2561, 47),
        ('bingoplus19nrve', 2469, 'V5', '不知道这个活动', '是', 2314, 11),
        ('bingoplusk86zwf', 2793, 'V5', '知道但没参加', '是', 2056, 10),
        ('bingopluspm7wn0', 2610, 'V6', '不知道这个活动', '是', 1719, 25),
        ('bingopluslfe8bt', 2804, 'V7', '不知道这个活动', '是', 1500, 15),
        ('peryaknbn6lt', 2725, 'V7', '知道但没参加', '是', 1356, 8),
        ('bingoplus0hyhsc', 2591, 'V7', '不知道这个活动', '是', 1235, 13),
        ('bingoplusizx64g', 2784, 'V7', '不知道这个活动', '是', 1199, 39),
        ('bingoplusdhwawo', 2500, 'V8', '不知道这个活动', '是', 947, 31),
        ('bingoplusvuwv9h', 589, 'V6', '不知道这个活动', '是', 637, 12),
        ('lpbhvdxcu', 839, 'V6', '知道但没参加', '是', 599, 20),
        ('bingopluspwxsux', 608, 'V5', '不知道这个活动', '是', 554, 9),
        ('bingoplus3p69zm', 2594, 'V5', '不知道这个活动', '是', 532, 10),
        ('bingoplus9uax15', 2763, 'V4', '不知道这个活动', '是', 433.5, 45),
        ('bingoplus561qvr', 2293, 'V5', '不知道这个活动', '是', 400.5, 35),
        ('gpjuvwta', 2698, 'V4', '不知道这个活动', '是', 386.5, 44),
        ('bingoplusg46wio', 2659, 'V4', '知道但没参加', '是', 385, 51),
        ('bingoplusy3p3xm', 2489, 'V5', '知道但没参加', '是', 358, 41),
        ('gppsgcfm', 2255, 'V4', '知道但没参加', '是', 356.5, 32),
        ('atvbc639', 2640, 'V7', '知道但没参加', '是', 354, 29),
        ('bingoplusmj27mb', 2518, 'V4', '不知道这个活动', '是', 324, 16),
        ('gpfprfrw', 2713, 'V4', '知道但没参加', '是', 305, 5),
        ('bingoplus59yyij', 2472, 'V4', '知道但没参加', '是', 277.5, 31),
        ('bingoplusw0hdny', 2466, 'V4', '知道但没参加', '是', 231.5, 35),
        ('bingopluss31cnx', 2545, 'V4', '不知道这个活动', '是', 226, 45),
        ('bingoplusp00yqw', 2492, 'V4', '知道但没参加', '是', 218.5, 37),
        ('bingoplus0pi3q8', 592, 'V5', '知道但没参加', '是', 214, 29),
        ('bingoplushgccqd', 740, 'V5', '知道但没参加', '是', 213.5, 44),
        ('bingopluss3qp9t', 2636, 'V4', '知道但没参加', '是', 212, 25),
        ('bingoplusuenj5v', 2511, 'V5', '知道但没参加', '是', 194, 30),
        ('bingoplus17zxkz', 2799, 'V5', '不知道这个活动', '是', 188, 38),
        ('bingoplus5k9c55', 2657, 'V4', '不知道这个活动', '是', 185.5, 29),
        ('bingoplus2j4ren', 1772, 'V6', '知道但没参加', '是', 182, 10),
        ('bingoplusvzu3s3', 2637, 'V4', '不知道这个活动', '是', 182, 30),
        ('perya3e5snhs', 2508, 'V4', '知道但没参加', '是', 174, 26),
        ('gpfsntan', 1793, 'V8', '不知道这个活动', '是', 173, 11),
        ('bingoplus4egmbt', 2465, 'V4', '不知道这个活动', '是', 172, 24),
        ('bingoplus2gplae', 2088, 'V7', '知道但没参加', '是', 170, 17),
        ('bingoplus8clq74', 2551, 'V5', '知道但没参加', '是', 169, 35),
        ('bingoplusvf8wfp', 759, 'V4', '不知道这个活动', '是', 158, 29),
        ('bingoplusqgvwco', 2121, 'V7', '不知道这个活动', '是', 155, 11),
        ('bingoplususveic', 130, 'V5', '不知道这个活动', '是', 154, 16),
        ('bingoplusaz6pzj', 2432, 'V4', '知道但没参加', '是', 145.5, 31),
        ('bingoplus94tp0q', 1154, 'V5', '不知道这个活动', '是', 145, 10),
        ('bingoplusrr0kfl', 1973, 'V4', '不知道这个活动', '是', 138.5, 14),
        ('bingoplusuhvim9', 660, 'V7', '不知道这个活动', '是', 130, 9),
        ('bingoplus5twfq6', 2340, 'V3', '不知道这个活动', '是', 129, 25),
        ('bingoplus1jhpio', 797, 'V4', '知道但没参加', '是', 106, 29),
        ('bingoplusu5ebdy', 474, 'V4', '知道但没参加', '是', 104, 31),
        ('bingoplusf837bl', 741, 'V7', '不知道这个活动', '是', 100, 1),
        ('bingoplusq7ctqh', 1808, 'V3', '知道但没参加', '是', 96, 10),
        ('bingoplus2aow2a', 1543, 'V5', '知道但没参加', '是', 83.5, 28),
        ('bingoplusijbvox', 1221, 'V5', '知道但没参加', '是', 79, 26),
        ('bingoplusagjgue', 1410, 'V4', '知道但没参加', '是', 78, 22),
        ('bingoplusq33kxu', 846, 'V4', '知道但没参加', '是', 75.5, 12),
        ('bingoplus1pd3m2', 809, 'V7', '不知道这个活动', '是', 75, 19),
        ('peryam4qbm1n', 1965, 'V4', '不知道这个活动', '是', 72.5, 18),
        ('lp09ovq4h', 1276, 'V4', '知道但没参加', '是', 72, 30),
        ('bingoplus5rpj16', 2103, 'V6', '不知道这个活动', '是', 69, 10),
        ('bingopluss623y0', 2467, 'V4', '知道但没参加', '是', 69, 27),
        ('bingoplus0a710y', 1363, 'V4', '不知道这个活动', '是', 68.5, 21),
        ('bingoplusuzr47m', 2319, 'V4', '知道但没参加', '是', 65.5, 19),
        ('bingoplusbz3nd9', 1490, 'V4', '知道但没参加', '是', 63.5, 23),
        ('bingoplus8k5n6c', 1009, 'V4', '知道但没参加', '是', 62, 10),
        ('bingoplusryafwp', 1201, 'V4', '知道但没参加', '是', 61.5, 30),
        ('bingoplusjj1w9o', 2396, 'V4', '知道但没参加', '是', 60.5, 10),
        ('bingoplus6ie2pr', 1103, 'V4', '知道但没参加', '是', 59.5, 14),
        ('aquarius26', 1446, 'V4', '不知道这个活动', '是', 59.5, 17),
        ('bingoplushn9b2a', 984, 'V4', '不知道这个活动', '是', 58, 17),
        ('bingoplusnb6op4', 34, 'V4', '知道但没参加', '是', 56.5, 20),
        ('bingoplus75w8z8', 1620, 'V3', '知道但没参加', '是', 54, 18),
        ('bingoplusseb64n', 1992, 'V4', '不知道这个活动', '是', 53.5, 18),
        ('bingoplusvpn94v', 1099, 'V4', '知道但没参加', '是', 52, 23),
        ('bingoplusra5emy', 725, 'V6', '不知道这个活动', '是', 49, 21),
        ('lpbvna66x', 2248, 'V4', '不知道这个活动', '是', 47.5, 22),
        ('bingoplusd79uea', 315, 'V3', '知道但没参加', '是', 46, 6),
        ('bingoplusq0k1qh', 202, 'V3', '知道但没参加', '是', 45.5, 4),
        ('bingoplusg8f6w0', 528, 'V7', '不知道这个活动', '是', 44.5, 17),
        ('perya7g4xsnc', 1795, 'V3', '知道但没参加', '是', 43.5, 13),
        ('peryaiuj8nss', 271, 'V4', '不知道这个活动', '是', 38.5, 8),
        ('bingoplusekmlpi', 336, 'V4', '知道但没参加', '是', 37, 11),
        ('bingoplusnrbflt', 1325, 'V4', '不知道这个活动', '是', 35, 3),
        ('bingoplushuhiel', 1943, 'V4', '知道但没参加', '是', 33, 17),
        ('bingoplus0jl744', 1202, 'V6', '不知道这个活动', '是', 32, 9),
        ('bingoplusaya245', 537, 'V3', '知道但没参加', '是', 31, 11),
        ('bingoplus6k38zg', 1690, 'V4', '知道但没参加', '是', 30.5, 10),
        ('bingopluszhs9v8', 113, 'V3', '知道但没参加', '是', 29.5, 11),
        ('bingoplusgcbmbg', 594, 'V4', '知道但没参加', '是', 29.5, 18),
        ('bingoplus4ia3pc', 128, 'V4', '知道但没参加', '是', 28, 10),
        ('spinfxdws9', 427, 'V3', '不知道这个活动', '是', 26.5, 7),
        ('bingoplusar0pk7', 684, 'V3', '知道但没参加', '是', 26, 10),
        ('bingoplusgydfrv', 1183, 'V4', '不知道这个活动', '是', 24.5, 9),
        ('peryag41cd2p', 1742, 'V3', '不知道这个活动', '是', 24.5, 11),
        ('bingoplusqqgglk', 2383, 'V4', '不知道这个活动', '是', 23, 10),
        ('peryaw6sdbjs', 221, 'V4', '不知道这个活动', '是', 22.5, 11),
        ('peryau0ixai6', 156, 'V3', '不知道这个活动', '是', 22, 8),
        ('bingoplus8ddd43', 2015, 'V3', '知道但没参加', '是', 22, 10),
        ('bingopluscobx7p', 2273, 'V4', '不知道这个活动', '是', 21.5, 8),
        ('lpucqsadc', 274, 'V3', '知道但没参加', '是', 21, 8),
        ('bingoplusix9x7z', 1053, 'V6', '知道但没参加', '是', 20, 2),
        ('bingoplusj9s3p4', 674, 'V4', '知道但没参加', '是', 18.5, 8),
        ('bingoplusaiuql5', 785, 'V4', '知道但没参加', '是', 17, 3),
        ('bingoplus14a2cn', 1382, 'V3', '知道但没参加', '是', 17, 9),
        ('bingoplusc5t3sk', 2068, 'V3', '知道但没参加', '是', 17, 3),
        ('bingoplusih6yls', 486, 'V4', '不知道这个活动', '是', 16.5, 6),
        ('bingoplusdpb7qe', 1975, 'V3', '不知道这个活动', '是', 15.5, 5),
        ('bingoplus820veb', 2290, 'V4', '知道但没参加', '是', 15.5, 6),
        ('gp5j9r2d', 1244, 'V3', '不知道这个活动', '是', 14.5, 10),
        ('bingoplus21m6wk', 1559, 'V4', '知道但没参加', '是', 14, 8),
        ('lph0cye04', 1997, 'V3', '不知道这个活动', '是', 12.5, 5),
        ('bingoplus9l9fyc', 2003, 'V4', '知道但没参加', '是', 12.5, 7),
        ('bingoplusuz31xg', 280, 'V5', '知道但没参加', '是', 12, 9),
        ('bingoplus5lrwqv', 533, 'V3', '知道但没参加', '是', 11, 9),
        ('bingoplus5l7xeu', 565, 'V4', '知道但没参加', '是', 11, 4),
        ('bingoplusxv8ver', 2133, 'V4', '知道但没参加', '是', 11, 4),
        ('gpsr57b9', 148, 'V3', '知道但没参加', '是', 10.5, 2),
        ('lp4u0p2cj', 795, 'V4', '不知道这个活动', '是', 10.5, 3),
        ('bingoplus3tqowb', 1274, 'V4', '不知道这个活动', '是', 10.5, 8),
        ('bingoplus4hqm8y', 747, 'V3', '不知道这个活动', '是', 10, 4),
        ('bingoplus5pnye4', 1013, 'V3', '知道但没参加', '是', 9, 6),
        ('bingoplussw4wuw', 1575, 'V3', '知道但没参加', '是', 9, 3),
        ('bingoplusphtoav', 516, 'V4', '不知道这个活动', '是', 8.5, 7),
        ('bingoplus3c2hem', 696, 'V4', '知道但没参加', '是', 8, 3),
        ('lp3kcos9c', 723, 'V4', '知道但没参加', '是', 8, 4),
        ('lp8cu7sdk', 517, 'V3', '不知道这个活动', '是', 7.5, 3),
        ('bingoplusdwhub3', 1417, 'V3', '知道但没参加', '是', 7.5, 3),
        ('lpuz88uat', 1741, 'V3', '不知道这个活动', '是', 7.5, 5),
        ('peryasdo56iv', 2360, 'V4', '知道但没参加', '是', 7.5, 5),
        ('bingoplusnyhx27', 208, 'V5', '知道但没参加', '是', 7, 2),
        ('bingopluso2gyqd', 397, 'V3', '不知道这个活动', '是', 7, 2),
        ('bingopluspqhssv', 2129, 'V4', '不知道这个活动', '是', 7, 2),
        ('gphy8m35', 2308, 'V3', '知道但没参加', '是', 7, 2),
        ('bingoplusabqrho', 140, 'V5', '不知道这个活动', '是', 6, 5),
        ('bingoplustt2snd', 424, 'V4', '不知道这个活动', '是', 6, 3),
        ('bingoplusbkhrmz', 1295, 'V3', '不知道这个活动', '是', 6, 2),
        ('perya9lja76l', 1886, 'V3', '知道但没参加', '是', 6, 3),
        ('bingoplusfyn4r5', 58, 'V3', '知道但没参加', '是', 5.5, 2),
        ('bingoplusu3o2gx', 1706, 'V4', '不知道这个活动', '是', 5.5, 4),
        ('bingopluskdva3f', 284, 'V3', '不知道这个活动', '是', 5, 5),
        ('bingoplus8v7dgs', 543, 'V5', '不知道这个活动', '是', 5, 3),
        ('bingoplus9h3gzh', 1489, 'V4', '不知道这个活动', '是', 5, 2),
        ('bingoplusg2f2dj', 2041, 'V4', '知道但没参加', '是', 5, 3),
        ('gp4da3vk', 2282, 'V3', '知道但没参加', '是', 5, 1),
        ('bingoplus84x57f', 1057, 'V3', '知道但没参加', '是', 4, 4),
        ('bingopluswr98wm', 1404, 'V2', '不知道这个活动', '是', 4, 2),
        ('bingoplusajrok2', 1766, 'V4', '知道但没参加', '是', 3.5, 2),
        ('lp26wi8p9', 152, 'V4', '不知道这个活动', '是', 3, 2),
        ('bingoplus1zxjyk', 265, 'V4', '不知道这个活动', '是', 3, 3),
        ('lpjr87dx', 239, 'V3', '不知道这个活动', '是', 2.5, 2),
        ('bingoplusj4rdd2', 311, 'V2', '知道但没参加', '是', 2.5, 2),
        ('lpgnfxfa', 378, 'V3', '知道但没参加', '是', 2.5, 2),
        ('bingoplusd7sdcf', 2144, 'V3', '知道但没参加', '是', 2.5, 2),
        ('bingoplus6nzvdg', 2461, 'V3', '知道但没参加', '是', 2.5, 2),
        ('bingoplus75r64p', 50, 'V5', '知道但没参加', '是', 2, 1),
        ('bingoplus4kx7ev', 51, 'V1', '知道但没参加', '是', 2, 1),
        ('bingoplusj8j57s', 188, 'V4', '不知道这个活动', '是', 2, 1),
        ('bingoplustsz15q', 223, 'V4', '不知道这个活动', '是', 2, 1),
        ('bingoplus12uy09', 264, 'V2', '不知道这个活动', '是', 2, 1),
        ('bingopluss337fg', 355, 'V3', '不知道这个活动', '是', 2, 1),
        ('lpy2p3zxu', 495, 'V3', '知道但没参加', '是', 2, 3),
        ('bingoplus1cz7ua', 586, 'V3', '知道但没参加', '是', 2, 1),
        ('lprfz2wl0', 701, 'V3', '不知道这个活动', '是', 2, 1),
        ('bingoplusn9ns8p', 1140, 'V3', '不知道这个活动', '是', 2, 3),
        ('bingoplus4rl8cx', 1494, 'V4', '知道但没参加', '是', 2, 1),
        ('gpeg94uv', 1578, 'V4', '不知道这个活动', '是', 2, 1),
        ('bingoplusj4eg1h', 1617, 'V4', '不知道这个活动', '是', 2, 1),
        ('bingoplusw9wkj6', 2417, 'V2', '不知道这个活动', '是', 2, 1),
        ('bingoplusn05a1y', 364, 'V4', '知道但没参加', '是', 1.5, 2),
        ('peryanipnaxn', 518, 'V4', '不知道这个活动', '是', 1.5, 2),
        ('bingoplusa5q29v', 925, 'V2', '不知道这个活动', '是', 1.5, 2),
        ('wnxjh648', 1624, 'V4', '不知道这个活动', '是', 1.5, 2),
        ('lpih3uz2y', 111, 'V3', '不知道这个活动', '是', 1, 1),
        ('lp2n8x5q', 316, 'V2', '不知道这个活动', '是', 1, 1),
        ('bingoplustm4hvu', 359, 'V4', '知道但没参加', '是', 1, 2),
        ('lpkf25a9', 515, 'V4', '不知道这个活动', '是', 1, 1),
        ('bingopluscozdtc', 722, 'V3', '不知道这个活动', '是', 1, 1),
        ('gpsxrhfe', 761, 'V3', '知道但没参加', '是', 1, 1),
        ('gprme7vv', 1097, 'V1', '不知道这个活动', '是', 1, 1),
        ('bingoplusrkncro', 1124, 'V3', '不知道这个活动', '是', 1, 1),
        ('bingoplus7whh8t', 1344, 'V4', '不知道这个活动', '是', 1, 2),
        ('bingoplusyknspl', 1648, 'V4', '知道但没参加', '是', 1, 1),
        ('bingoplusjz634m', 1923, 'V4', '不知道这个活动', '是', 1, 1),
        ('bingoplus4cebnb', 73, 'V2', '知道但没参加', '是', 0.5, 1),
        ('perya1vjg77c', 370, 'V4', '知道但没参加', '是', 0.5, 1),
        ('bingoplus5c4vks', 497, 'V3', '不知道这个活动', '是', 0.5, 1),
        ('bingoplusrpp8dr', 743, 'V4', '知道但没参加', '是', 0.5, 1),
        ('bingopluswrjy09', 852, 'V4', '知道但没参加', '是', 0.5, 1),
        ('bingoplusrn5rwk', 909, 'V3', '知道但没参加', '是', 0.5, 1),
        ('bingoplustmr6e0', 1278, 'V3', '知道但没参加', '是', 0.5, 1),
        ('bingopluscs2029', 1773, 'V3', '知道但没参加', '是', 0.5, 1),
        ('jeeno1968', 1999, 'V3', '不知道这个活动', '是', 0.5, 1),
        ('tg8lmmylm', 2044, 'V1', '不知道这个活动', '是', 0.5, 1),
        ('bingoplus01zmi3', 2310, 'V6', '知道但没参加', '是', 0.5, 1),
        ('bingoplusu8vvmg', 2317, 'V2', '不知道这个活动', '是', 0.5, 1),
        ('bingoplusva8qq3', 17, 'V0', '不知道这个活动', '否', 0, 0),
        ('lp93sp9ln', 30, 'V3', '不知道这个活动', '否', 0, 0),
        ('bingopluslpeoe7', 46, 'V5', '不知道这个活动', '否', 0, 0),
        ('peryafen9sd7', 53, 'V2', '知道但没参加', '否', 0, 0),
        ('bingoplusf4prg4', 57, 'V5', '知道但没参加', '否', 0, 0),
        ('bingoplusqk7lo2', 64, 'V3', '知道但没参加', '否', 0, 0),
        ('perya1sq3nkn', 97, 'V3', '知道但没参加', '否', 0, 0),
        ('bingopluswfz7te', 137, 'V4', '不知道这个活动', '否', 0, 0),
        ('bingopluscwwnyk', 139, 'V4', '知道但没参加', '否', 0, 0),
        ('bingoplusv09zwb', 143, 'V4', '不知道这个活动', '否', 0, 0),
        ('bingoplus0abo6t', 170, 'V3', '不知道这个活动', '否', 0, 0),
        ('bingoplusofiok6', 184, 'V5', '知道但没参加', '否', 0, 0),
        ('bingoplusq0zm1z', 185, 'V3', '不知道这个活动', '否', 0, 0),
        ('bingoplusi80rk6', 195, 'V3', '不知道这个活动', '否', 0, 0),
        ('bingoplus243py9', 205, 'V4', '不知道这个活动', '否', 0, 0),
        ('bingoplus2jeg35', 216, 'V3', '不知道这个活动', '否', 0, 0),
        ('bingoplusfy4ecr', 233, 'V6', '知道但没参加', '否', 0, 0),
        ('bingopluspc4umu', 246, 'V1', '知道但没参加', '否', 0, 0),
        ('bingoplusailr1h', 255, 'V4', '知道但没参加', '否', 0, 0),
        ('bingoplus29cgdz', 282, 'V4', '知道但没参加', '否', 0, 0),
        ('bingoplus55guen', 299, 'V1', '不知道这个活动', '否', 0, 0),
        ('bingoplus4trjvn', 337, 'V3', '知道但没参加', '否', 0, 0),
        ('bingoplus5kj4bp', 352, 'V4', '知道但没参加', '否', 0, 0),
        ('bingopluskgj5xk', 369, 'V1', '知道但没参加', '否', 0, 0),
        ('lpzam9sk6', 375, 'V1', '知道但没参加', '否', 0, 0),
        ('bingoplushkdx65', 376, 'V4', '知道但没参加', '否', 0, 0),
        ('bingoplus25kp6c', 403, 'V3', '知道但没参加', '否', 0, 0),
        ('bingoplusadhsgi', 410, 'V3', '知道但没参加', '否', 0, 0),
        ('lp618dfpc', 422, 'V2', '不知道这个活动', '否', 0, 0),
        ('bingoplusjrnvvx', 440, 'V1', '不知道这个活动', '否', 0, 0),
        ('lp01ic5i1', 441, 'V2', '不知道这个活动', '否', 0, 0),
        ('lpna59eg3', 478, 'V4', '不知道这个活动', '否', 0, 0),
        ('bingoplusww6wm8', 513, 'V4', '知道但没参加', '否', 0, 0),
        ('bingoplusjn6bgt', 546, 'V1', '知道但没参加', '否', 0, 0),
        ('lppfi0f1q', 556, 'V6', '不知道这个活动', '否', 0, 0),
        ('bingopluskh22la', 577, 'V2', '不知道这个活动', '否', 0, 0),
        ('bingoplusvab6vd', 599, 'V3', '知道但没参加', '否', 0, 0),
        ('bingoplusda7ywn', 610, 'V4', '不知道这个活动', '否', 0, 0),
        ('bingoplus264jzv', 632, 'V3', '不知道这个活动', '否', 0, 0),
        ('lp460gl05', 642, 'V4', '不知道这个活动', '否', 0, 0),
        ('bingoplusr7bktf', 648, 'V4', '知道但没参加', '否', 0, 0),
        ('bingoplus0vityf', 669, 'V2', '不知道这个活动', '否', 0, 0),
        ('lpmdms5eb', 714, 'V1', '知道但没参加', '否', 0, 0),
        ('bingoplusj2x6f3', 730, 'V4', '知道但没参加', '否', 0, 0),
        ('bingopluspyv856', 739, 'V1', '不知道这个活动', '否', 0, 0),
        ('bingoplus8v8ly6', 830, 'V3', '不知道这个活动', '否', 0, 0),
        ('gpryh8ch', 848, 'V1', '不知道这个活动', '否', 0, 0),
        ('spingcbe85', 869, 'V3', '不知道这个活动', '否', 0, 0),
        ('bingopluskg2zl8', 918, 'V4', '知道但没参加', '否', 0, 0),
        ('bingopluszs6wv5', 958, 'V3', '知道但没参加', '否', 0, 0),
        ('bingopluschds7i', 970, 'V5', '知道但没参加', '否', 0, 0),
        ('bingoplusrme4xi', 979, 'V4', '知道但没参加', '否', 0, 0),
        ('bingoplus2jf5yq', 1060, 'V2', '知道但没参加', '否', 0, 0),
        ('bingoplus9w1xct', 1063, 'V1', '不知道这个活动', '否', 0, 0),
        ('bingoplus2h0xvh', 1078, 'V3', '知道但没参加', '否', 0, 0),
        ('bingoplusw9u5tx', 1080, 'V3', '知道但没参加', '否', 0, 0),
        ('lp3dvbkn', 1174, 'V3', '知道但没参加', '否', 0, 0),
        ('lp9p9j2c', 1196, 'V0', '不知道这个活动', '否', 0, 0),
        ('bingoplusrtje8t', 1300, 'V1', '知道但没参加', '否', 0, 0),
        ('bingoplusawx7ke', 1337, 'V1', '知道但没参加', '否', 0, 0),
        ('gpjekj3c', 1347, 'V2', '知道但没参加', '否', 0, 0),
        ('bingoplush5dxi4', 1353, 'V6', '知道但没参加', '否', 0, 0),
        ('lpwcpev3x', 1361, 'V7', '不知道这个活动', '否', 0, 0),
        ('gpwcpwyh', 1373, 'V1', '不知道这个活动', '否', 0, 0),
        ('lpzbjh3s', 1385, 'V1', '不知道这个活动', '否', 0, 0),
        ('bingoplusd3a6gy', 1412, 'V3', '知道但没参加', '否', 0, 0),
        ('bingoplusxmcf68', 1447, 'V4', '知道但没参加', '否', 0, 0),
        ('bingoplusb2r3nv', 1453, 'V3', '知道但没参加', '否', 0, 0),
        ('bingoplus4seta2', 1459, 'V3', '知道但没参加', '否', 0, 0),
        ('bingoplusd3o04o', 1461, 'V3', '知道但没参加', '否', 0, 0),
        ('bingoplusg141l5', 1485, 'V3', '知道但没参加', '否', 0, 0),
        ('bingoplush6hvt2', 1502, 'V3', '不知道这个活动', '否', 0, 0),
        ('bingoplusds198t', 1518, 'V4', '知道但没参加', '否', 0, 0),
        ('bingoplusmrax4b', 1527, 'V2', '知道但没参加', '否', 0, 0),
        ('lpzh8j4n', 1561, 'V1', '知道但没参加', '否', 0, 0),
        ('lpa9hnxt', 1564, 'V1', '不知道这个活动', '否', 0, 0),
        ('bingopluskgdktr', 1567, 'V1', '不知道这个活动', '否', 0, 0),
        ('bingoplusiupusb', 1598, 'V4', '不知道这个活动', '否', 0, 0),
        ('bingoplusqh55ad', 1600, 'V3', '知道但没参加', '否', 0, 0),
        ('bingopluskxh7mv', 1653, 'V2', '不知道这个活动', '否', 0, 0),
        ('bingoplusglxbnz', 1665, 'V3', '知道但没参加', '否', 0, 0),
        ('bingoplusayupvd', 1713, 'V0', '不知道这个活动', '否', 0, 0),
        ('gpmb68df', 1730, 'V3', '不知道这个活动', '否', 0, 0),
        ('peryap0gtcg1', 1839, 'V4', '不知道这个活动', '否', 0, 0),
        ('bingoplusce2j5n', 1854, 'V0', '知道但没参加', '否', 0, 0),
        ('bingoplusnc2q4e', 1859, 'V4', '知道但没参加', '否', 0, 0),
        ('bingoplusjd7jee', 1861, 'V4', '不知道这个活动', '否', 0, 0),
        ('bingoplusm92qfj', 1879, 'V3', '知道但没参加', '否', 0, 0),
        ('lpb03jsp2', 1893, 'V4', '知道但没参加', '否', 0, 0),
        ('lpmrgnz0l', 1905, 'V3', '知道但没参加', '否', 0, 0),
        ('bingoplusg1ueqb', 1919, 'V3', '知道但没参加', '否', 0, 0),
        ('bingoplusm872gy', 1935, 'V1', '知道但没参加', '否', 0, 0),
        ('bingoplus0yw0q8', 1961, 'V3', '不知道这个活动', '否', 0, 0),
        ('lphaa45x', 1987, 'V1', '知道但没参加', '否', 0, 0),
        ('bingoplusql0j7z', 2012, 'V4', '不知道这个活动', '否', 0, 0),
        ('lpxzz1x8s', 2043, 'V4', '不知道这个活动', '否', 0, 0),
        ('bingoplus1l2mip', 2062, 'V4', '知道但没参加', '否', 0, 0),
        ('bingoplus4zpu0m', 2096, 'V3', '不知道这个活动', '否', 0, 0),
        ('gpcxncgm', 2107, 'V3', '不知道这个活动', '否', 0, 0),
        ('lpgn7wppu', 2163, 'V4', '知道但没参加', '否', 0, 0),
        ('lpvc87mzo', 2188, 'V4', '知道但没参加', '否', 0, 0),
        ('bingoplus8gpnkg', 2193, 'V1', '知道但没参加', '否', 0, 0),
        ('bingoplusjyikxu', 2245, 'V3', '不知道这个活动', '否', 0, 0),
        ('lp5oyv3cv', 2249, 'V3', '知道但没参加', '否', 0, 0),
        ('lp422wfy7', 2318, 'V5', '知道但没参加', '否', 0, 0),
        ('bingoplusddudfc', 2348, 'V3', '知道但没参加', '否', 0, 0),
        ('bingoplusbteth8', 2372, 'V4', '知道但没参加', '否', 0, 0),
        ('bingoplusw9efmy', 2384, 'V4', '不知道这个活动', '否', 0, 0),
        ('bingoplus0ym4i8', 2412, 'V4', '不知道这个活动', '否', 0, 0),
        ('gpjgwaux', 2442, 'V3', '知道但没参加', '否', 0, 0),
        ('lp9umpsuj', 2453, 'V1', '不知道这个活动', '否', 0, 0),
        ('peryayv3ds3c', 2454, 'V1', '不知道这个活动', '否', 0, 0),
        ('bingoplus5tzw8d', 2459, 'V3', '不知道这个活动', '否', 0, 0),
        ('bingoplus1jj2v0', 2745, 'V5', '知道但没参加', '否', 0, 0),
        ('bingoplus35wm4x', 2785, 'V1', '知道但没参加', '否', 0, 0)
    ) t (login_name, survey_id, company_vip, participation, has_reward, reward_amount, claim_count)
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

-- 骰子发放个数
dice AS (
    SELECT
        LOWER(TRIM(login_name)) AS login_name,
        SUM(born_count) AS dice_count
    FROM superengineproject.ods_mms_t_user_fragments_di
    WHERE pt >= '20260911' AND pt <= '20260924'
    GROUP BY LOWER(TRIM(login_name))
),

-- 核销明细（公共CTE）
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

-- 任务核销返水金 (12 activity IDs)
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

-- 地图核销金额 (2 activity IDs)
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

-- TOP 300 核销金额 (1 activity ID)
top300_redeem AS (
    SELECT
        login_name,
        SUM(redeem_amount) AS top300_redeem_amount
    FROM redeem_all
    WHERE activity_id = '6aa11550e4b07fc749ab00b9'
    GROUP BY login_name
),

-- 大富翁核销金额 (全部15个活动ID)
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

-- 其他活动核销金额 & 核销活动个数 (NOT IN 上述15个)
other_redeem AS (
    SELECT
        login_name,
        SUM(redeem_amount) AS other_redeem_amount,
        COUNT(DISTINCT activity_id) AS other_activity_count
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
    su.survey_id,
    su.login_name,
    su.company_vip,
    su.participation,
    su.has_reward,
    su.reward_amount,
    su.claim_count,
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
LEFT JOIN vip v ON su.login_name = v.login_name
LEFT JOIN dice d ON su.login_name = d.login_name
LEFT JOIN task_redeem tr ON su.login_name = tr.login_name
LEFT JOIN map_redeem mr ON su.login_name = mr.login_name
LEFT JOIN top300_redeem t3 ON su.login_name = t3.login_name
LEFT JOIN monopoly_redeem mp ON su.login_name = mp.login_name
LEFT JOIN other_redeem ot ON su.login_name = ot.login_name
LEFT JOIN ggr g ON su.login_name = g.login_name
;
