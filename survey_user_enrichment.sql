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
    SELECT login_name
    FROM (
        VALUES
        ('bingoplusffnfb4'), ('bingoplusd2tgdw'), ('bingopluswwwibn'), ('bingoplustlrnru'), ('bingoplusqqbk42'), ('bingoplushcaxtm'), ('bingoplusva8qq3'), ('bingoplus6nuwgt'), ('bingoplus2n6mjx'), ('bingoplustwu9zs'),
    ('bingoplusi1qbj5'), ('bingoplus54qsfz'), ('gpujv7vz'), ('bingopluslb2iov'), ('bingoplusl3piwe'), ('lpyun7pra'), ('lp93sp9ln'), ('bingoplus8wz8hm'), ('bingoplusmf1pko'), ('bingopluszdtk2p'),
    ('bingoplusnb6op4'), ('bingoplusaerb50'), ('bingopluspxk4me'), ('bingoplusv3tgdj'), ('lpdmebba6'), ('bingopluslpeoe7'), ('bingoplus75r64p'), ('bingoplus4kx7ev'), ('peryafen9sd7'), ('bingoplusf245d6'),
    ('bingoplusf4prg4'), ('bingoplusfyn4r5'), ('bingoplusvwj0cd'), ('bingoplusbzswz0'), ('bingoplusqk7lo2'), ('lp0ngi4do'), ('bingoplusdu5j5t'), ('bingoplusn31hdl'), ('gp3ng4kx'), ('bingoplusxs2t8u'),
    ('bingoplus4cebnb'), ('bingoplusxd5442'), ('bingoplusyi7jh6'), ('lp5k0ow9y'), ('bingoplusbtzbo4'), ('bingoplusefg9q8'), ('bingoplusvknr5r'), ('bingoplushq93zt'), ('bingopluswv5qjs'), ('bingoplusceu3ht'),
    ('bingoplusk1uuk6'), ('gp4az2x4'), ('bingopluszxcyqc'), ('bingopluspiuh0k'), ('perya1sq3nkn'), ('bingopluspssrvl'), ('bingoplusuuq8z6'), ('bingoplus0z4n7p'), ('bingopluse8xys1'), ('gp5k7njv'),
    ('lpih3uz2y'), ('bingoplusvzwv9p'), ('bingopluszhs9v8'), ('bingopluspt1pv6'), ('bingoplusk82g3q'), ('viber19z6mb0'), ('bingopluscx6420'), ('bingoplus8qshc9'), ('bingoplus4ia3pc'), ('bingoplususveic'),
    ('bingopluskyua9w'), ('bingoplusjv5usk'), ('bingoplus7hborz'), ('bingopluswfz7te'), ('bingopluscwwnyk'), ('bingoplusabqrho'), ('gp83p5zm'), ('bingoplusv09zwb'), ('peryai4prspv'), ('peryahpm16kc'),
    ('bingoplushciooe'), ('bingoplusvba3in'), ('gpsr57b9'), ('bingoplusj599m0'), ('bingopluskdetug'), ('bingoplusumkz45'), ('lp26wi8p9'), ('gpj46mmh'), ('bingoplusrp5dr0'), ('peryau0ixai6'),
    ('bingoplusglrqve'), ('bingoplusob1yj6'), ('gphpcgjp'), ('gp8n78rk'), ('bingoplus0abo6t'), ('lplmxlq5f'), ('bingoplusjwt8fv'), ('bingoplussp8q28'), ('riverlou03'), ('bingoplusznbbkk'),
    ('bingoplusofiok6'), ('bingoplusq0zm1z'), ('lpcmf4iwo'), ('bingoplusj8j57s'), ('bingoplus46exyy'), ('bingoplusprnjjj'), ('lpgjcokx5'), ('bingoplus8isp05'), ('bingoplusi80rk6'), ('jerome03061997'),
    ('bingoplusoejgon'), ('bingopluswk9f5j'), ('bingoplusq0k1qh'), ('gp3vmrtm'), ('bingoplus243py9'), ('hkklq819'), ('bingoplusnyhx27'), ('bingopluspybikc'), ('bingoplusdjs3az'), ('bingoplus4n98p7'),
    ('bingoplus2jeg35'), ('peryayr1yv13'), ('bingoplusfdojr4'), ('peryaw6sdbjs'), ('bingoplustsz15q'), ('bingoplus8vtbkj'), ('gphybdzx'), ('bingoplus0z6dc2'), ('bingoplusq7d4je'), ('bingoplusfy4ecr'),
    ('bingoplus5yfwd2'), ('bingoplusc0u5se'), ('bingoplus3z9e6r'), ('lpjr87dx'), ('lpys4abp'), ('lpsx7dik1'), ('bingopluspc4umu'), ('bingoplusa5bfr8'), ('bingoplusjvust7'), ('bingoplusiein8s'),
    ('bingoplusailr1h'), ('bingoplusx4ujad'), ('lp2gk64p'), ('bingoplustw7u4q'), ('bingopluso0j2sn'), ('bingoplus12uy09'), ('bingoplus1zxjyk'), ('bingoplus097wyy'), ('bingoplus7mp8kq'), ('peryaiuj8nss'),
    ('bingopluskqf9pc'), ('bingopluslcav2xi'), ('lpucqsadc'), ('bingoplus3n98jb'), ('bingoplus7e6zww'), ('bingoplusuz31xg'), ('bingoplus29cgdz'), ('perya6asw2p5'), ('bingopluskdva3f'), ('peryayeq30r3'),
    ('bingopluswguo23'), ('bingoplusz8an8v'), ('bingoplusiwuhf0'), ('bingoplusvzsm7q'), ('bingoplus55guen'), ('lp8ac7b38'), ('bingoplusvm0748'), ('bingoplusjppr5l'), ('bingoplusg8amjj'), ('bingopluszlqmkr'),
    ('bingoplusm27oje'), ('bingoplusj4rdd2'), ('bingoplusd79uea'), ('lp2n8x5q'), ('bingoplusnz858i'), ('bingoplusgi4533'), ('bingopluse38294'), ('bingoplusqpvkdf'), ('bingoplusc1pjj1'), ('bingoplusl60nra'),
    ('bingoplus8cm6vy'), ('bingoplusd3n9up'), ('bingopluspktrit'), ('bingoplusfvy5xq'), ('bingoplusekmlpi'), ('bingoplus4trjvn'), ('gp73c9gb'), ('bingoplustr4xsv'), ('bingoplusxvnq4i'), ('bingoplusolhzaf'),
    ('bingoplusxsybgz'), ('lps1fkxl8'), ('bingoplus5kj4bp'), ('bingopluss337fg'), ('bingoplusaqcov4'), ('bingoplusn5jfmt'), ('bingoplus6nwtqt'), ('bingoplustm4hvu'), ('lphtqwusx'), ('bingoplusn05a1y'),
    ('lpkijfr3o'), ('bingoplusiq0ibw'), ('bingopluskgj5xk'), ('perya1vjg77c'), ('bingoplust3ew5g'), ('bingopluspb7oqu'), ('lpzam9sk6'), ('bingoplushkdx65'), ('lpgnfxfa'), ('bingopluskgajes'),
    ('lp00tnwmp'), ('bingopluslsamcu'), ('lpapj6h06'), ('bingoplus5acc8c'), ('bingoplusjll3tk'), ('bingopluso2gyqd'), ('bingoplusuijtk1'), ('bingopluslgranz'), ('bingoplus25kp6c'), ('bingoplusatn4ni'),
    ('bingoplusadhsgi'), ('bingoplusdnnkzb'), ('lpic74cyo'), ('bingoplushmr4u3'), ('lp618dfpc'), ('bingoplus8d7yff'), ('bingoplustt2snd'), ('bingoplus9onn9k'), ('spinfxdws9'), ('gpfyfupw'),
    ('bingoplusvrh6si'), ('lpmf9buej'), ('bingoplusdvh83o'), ('gp7npuas'), ('bingoplusjrnvvx'), ('lp01ic5i1'), ('bingoplus8cxi8a'), ('lpk47aa02'), ('bingoplust7gqe4'), ('lpjlyd4jd'),
    ('bingoplus1eiocc'), ('bingoplus04j4gz'), ('bingopluswv5cmo'), ('bingoplusmxrqu8'), ('bingoplusu5ebdy'), ('bingoplusvrmas6'), ('bingoplus0123ak'), ('lpna59eg3'), ('bingoplust9ssja'), ('bingoplusekk548'),
    ('bingoplus4xar7o'), ('bingoplusih6yls'), ('bingoplusqqmsb5'), ('gp3jxpn3'), ('bingoplus7zrkie'), ('lpy2p3zxu'), ('spinmrf2wli'), ('bingoplus5c4vks'), ('bingoplusow920m'), ('bingoplusrz9dxr'),
    ('bingoplus34b62p'), ('bingoplusww6wm8'), ('peryar9b5x99'), ('lpkf25a9'), ('bingoplusphtoav'), ('lp8cu7sdk'), ('peryanipnaxn'), ('bingoplusjhempy'), ('bingoplus9k6dtg'), ('lpidzehm1'),
    ('gpeg7ezc'), ('bingoplusg8f6w0'), ('cmrjames78'), ('bingoplusmjxnzb'), ('bingoplus5sk9zm'), ('bingoplus5lrwqv'), ('lpz3oymt9'), ('peryaapyfgm7'), ('bingoplusvskxjs'), ('bingoplusaya245'),
    ('bingopluszicpns'), ('gpyh5f35'), ('bingoplusvx8cm2'), ('bingoplus8v7dgs'), ('perya7o68752'), ('bingoplusjn6bgt'), ('bingoplussxlcv1'), ('gp83e9df'), ('gp92hng5'), ('bingoplusx9g2rw'),
    ('lppfi0f1q'), ('lpy7z8duf'), ('bingoplus5l7xeu'), ('bingopluso6v9hc'), ('gpfw425f'), ('bingoplus7e499k'), ('bingopluswi46bj'), ('bingoplusedeznm'), ('bingopluskh22la'), ('bingoplus88rs9j'),
    ('bingoplus9m63aj'), ('bingoplusymvhkk'), ('bingoplus1cz7ua'), ('bingoplus1f14aq'), ('lpth4b7na'), ('bingoplusvuwv9h'), ('bingoplusxaktlk'), ('bingoplus0pi3q8'), ('bingoplusgcbmbg'), ('bingoplusnk9gtp'),
    ('bingoplusiylop5'), ('bingopluszv9txt'), ('bingoplusvab6vd'), ('bingoplusy49nq7'), ('lpwf3a9vw'), ('bingopluspwxsux'), ('bingopluswe47sj'), ('bingoplusda7ywn'), ('bingoplus86xpfs'), ('bingoplusuetaxr'),
    ('bingoplusvgy8hv'), ('gpcp4t23'), ('bingoplusemexnc'), ('bingoplusmpwj7f'), ('spin56b7jhd'), ('bingopluste9g9e'), ('bingoplusmwov32'), ('bingoplusjasmx9'), ('bingoplus264jzv'), ('lp225o6vh'),
    ('bingoplus7k3n00'), ('bingoplusn66mqm'), ('lp460gl05'), ('bingoplusk27ndw'), ('bingoplus3n6cde'), ('bingoplusr7bktf'), ('bingoplusezxt74'), ('bingopluszeu7sb'), ('lp0r8zc8t'), ('bingoplusi5u70t'),
    ('bingoplusuhvim9'), ('bingoplusr1wxhn'), ('lpdxruvhi'), ('bingoplusvbdowo'), ('bingopluslwz1e3'), ('bingoplusbbub92'), ('bingoplus0vityf'), ('lps9h3bmj'), ('bingoplusqur63q'), ('bingoplusj9s3p4'),
    ('bingoplusj9vvax'), ('bingoplus0qdy91'), ('bingoplusqbpv9z'), ('bingoplusmu3w69'), ('bingopluswr3bsb'), ('bingoplusd8cpbk'), ('bingoplusjlz9zw'), ('bingoplusar0pk7'), ('lp66ur8n2'), ('lpfxf4as3'),
    ('bingoplus367tzv'), ('bingoplus3c2hem'), ('bingoplussdn6vb'), ('bingoplustix8xo'), ('lprfz2wl0'), ('bingopluszd2ytu'), ('bingoplusxpr9bq'), ('bingoplus2mtllr'), ('bingoplusdga7xu'), ('bingoplus4ngyfn'),
    ('bingoplus4pl10a'), ('lpmdms5eb'), ('bingopluswao9h4'), ('bingoplusl0cmz4'), ('bingoplusfachak'), ('bingoplusoa10gs'), ('bingopluscozdtc'), ('lp3kcos9c'), ('bingoplusra5emy'), ('bingoplus9nbc4a'),
    ('bingoplusj2x6f3'), ('bingoplusz905lc'), ('bingoplushogwyj'), ('peryazu90h7w'), ('bingoplus4vqtsj'), ('bingoplus5gdle1'), ('bingopluspyv856'), ('bingoplushgccqd'), ('bingoplusf837bl'), ('bingoplusrpp8dr'),
    ('bingoplus4hqm8y'), ('bingoplusi3jncv'), ('bingoplusvmwnua'), ('bingoplus8ixea5'), ('bingoplus7lsk30'), ('gpcab8b6'), ('bingoplus0s351c'), ('bingoplusvf8wfp'), ('gpsxrhfe'), ('bingoplusfl32xt'),
    ('bingoplus8cwxmk'), ('bingoplusx83z2n'), ('bingoplus8nemb6'), ('gpkvf5mf'), ('bingoplusm92e4s'), ('spinvrg0nm6'), ('lpkuv8evc'), ('bingoplusplmi6h'), ('bingoplusaiuql5'), ('bingoplusysky3u'),
    ('alwx3fc8'), ('bingoplusifu30h'), ('bingoplus7yvc2d'), ('lpnqy9ssw'), ('lp4u0p2cj'), ('bingoplus1jhpio'), ('bingoplus86cdop'), ('bingoplusr6snxx'), ('bingoplusnyp7on'), ('peryaatnjcpf'),
    ('bingoplussizcoc'), ('bingoplus1pd3m2'), ('bingoplus6llplc'), ('bingoplus46m4qt'), ('bingopluspuft8t'), ('bingopluseqn5yr'), ('bingoplusj4waiz'), ('bingoplusxc8jv4'), ('bingopluszqafi3'), ('bingoplus8v8ly6'),
    ('brisulda31'), ('lph6efzj5'), ('bingoplus6cwkyu'), ('bingoplus45ujby'), ('lpbhvdxcu'), ('bingopluspucxqd'), ('bingoplusvzfpea'), ('bingoplusq33kxu'), ('bingoplusuotq3d'), ('gpryh8ch'),
    ('bingoplusv7sbcm'), ('bingopluswrjy09'), ('bingoplusp35ngz'), ('bingoplus0bz0aj'), ('bingoplus2k4d6k'), ('spingcbe85'), ('bingoplusnbpex8'), ('bingoplusplh595'), ('bingoplusybnzfs'), ('bingoplusgabsmf'),
    ('bingoplusuow0od'), ('bingoplusiwxv0t'), ('bingoplus9nm2nn'), ('bingoplustzplwi'), ('bingoplus1kobrn'), ('bingoplus6b4yj2'), ('bingoplusb0riiz'), ('bingoplusj8n0sy'), ('bingopluse5bwnx'), ('bingoplusxw3ags'),
    ('gp9acqcb'), ('bingopluszdnn2g'), ('bingoplus2868cg'), ('lpdd0fhef'), ('bingopluslz36fp'), ('bingoplustmts0ul'), ('lprall40l'), ('bingoplusijd2w6'), ('bingoplusrn5rwk'), ('bingoplus3y78j8'),
    ('bingoplusjddgmz'), ('bingoplus0yj51y'), ('bingoplusw5hwbn'), ('bingopluskg2zl8'), ('bingoplus3iogs8'), ('bingoplusa5q29v'), ('bingoplus4g0dxd'), ('bingoplusyas4yb'), ('bingoplusyq5qvn'), ('1234rl123'),
    ('bingoplusw9ks0n'), ('lpcsoczaa'), ('bingoplusgkfi9m'), ('lpnc6qqsz'), ('bingoplusdj5kwh'), ('gp5ftbqb'), ('bingoplusc7a4zr'), ('bingoplusabudb4'), ('bingoplusjwuqgx'), ('bingoplus9hgtgn'),
    ('bingopluszs6wv5'), ('bingoplusbklnaz'), ('lp456jpjc'), ('bingoplusfx3mue'), ('bingopluswwgtuq'), ('bingopluschds7i'), ('gp6evxq2'), ('bingoplusjzumph'), ('bingoplusrme4xi'), ('bingoplusuhpuzm'),
    ('bingoplusdi4mtg'), ('bingoplusgx4n6z'), ('bingoplushn9b2a'), ('bingoplus0m7qo1'), ('lpjp318j4'), ('bingoplusnq7315'), ('lp9wmza9f'), ('bingoplus9kwpn3'), ('bingoplusvq2tyy'), ('peryayq5ilfy'),
    ('bingoplusygfhnb'), ('lphtmkxsq'), ('bingoplusbgcesi'), ('bingoplus8k5n6c'), ('bingoplusymdnwh'), ('bingoplus5pnye4'), ('bingoplusm7uqoi'), ('bingopluszuuk89'), ('bingoplusvwqqvs'), ('bingoplussuk4kq'),
    ('bingoplusg54y33'), ('bingoplus6yjrz5'), ('bingopluswixf2c'), ('bingoplus5kh0mp'), ('lpuun0gwr'), ('bingoplus7wfcx2'), ('lpy7c07o5'), ('gp5g72qq'), ('bingoplusi01di4'), ('bingoplusix9x7z'),
    ('bingoplusd2a1r8'), ('bingoplusxczzjd'), ('bingoplus84x57f'), ('bingoplusm409ug'), ('bingoplus2jf5yq'), ('bingoplus9w1xct'), ('bingoplus81yvod'), ('bingopluss3zqbj'), ('bingopluslw6fcj'), ('bingoplus2h0xvh'),
    ('gptywbph'), ('bingoplusw9u5tx'), ('bingoplusfu64bb'), ('bingopluswz2ily'), ('bingoplusy3zhis'), ('bingoplusjo7077'), ('peryaaldcel2'), ('bingoplusjkd286'), ('gprme7vv'), ('bingopluskdwvho'),
    ('bingoplusvpn94v'), ('bingoplus6ie2pr'), ('bingoplusvw222e'), ('bingoplus5xi2gt'), ('bingopluszshvvt'), ('bingoplus5ae853'), ('bingoplusdwz31u'), ('bingoplus4j6ks9'), ('bingoplusj8utaa'), ('bingoplusrkncro'),
    ('bingopluspxabhd'), ('bingoplus21tp60'), ('gpg4kh3p'), ('lpfhzm27'), ('bingopluspewxz7'), ('bingoplusbjyl23'), ('bingoplusn3f7fd'), ('bingoplusn9ns8p'), ('sp3jvdaxu'), ('bingoplus2237j7'),
    ('bingoplusqko937'), ('xixuc139'), ('papa1'), ('bingoplusww0ppq'), ('bingoplus94tp0q'), ('bingopluszt5scs'), ('gp6v5ccd'), ('bingoplusjnmkdq'), ('bingoplusrqqbfu'), ('bingoplusvdvye7'),
    ('bingopluslzoeft'), ('bingoplus8ddmtw'), ('bingoplusawa142'), ('bingoplus4into1'), ('bingoplus6hmzuq'), ('lp3dvbkn'), ('bingopluseu0pm0'), ('bingoplussck51a'), ('bingopluskpr251'), ('bingoplusgydfrv'),
    ('bingopluswiyexj'), ('bingoplusoyeqsa'), ('bingoplus1bm989'), ('bingoplus3qwx0h'), ('bingoplus091si6'), ('bingoplusxastxk'), ('lp9p9j2c'), ('bingoplustaajj8'), ('bingoplusryafwp'), ('bingoplus0jl744'),
    ('bingoplusacinu6'), ('bingoplusv01b6u'), ('bingoplusolkr8y'), ('bingopluss0qtw9'), ('bingoplusrcc5mn'), ('bingoplus2dxp13'), ('bingoplus3m1h22'), ('bingoplusijbvox'), ('bingoplus8kezys'), ('bingoplusag3tr8'),
    ('bingoplusp8c24d'), ('bingoplusdf8v4z'), ('viberu5hvufy'), ('bingoplusoglj8d'), ('lp6t280fe'), ('spinnmsxp7r'), ('gp5j9r2d'), ('bingoplusx30ogl'), ('gprpvfcu'), ('bingoplus4ubqwg'),
    ('bingopluscejhvy'), ('gpz3hf33'), ('bingopluswiudnz'), ('bingoplus3tqowb'), ('lp09ovq4h'), ('bingoplustmr6e0'), ('bingoplus56tmez'), ('bingoplus5qm8sf'), ('bingoplus373sgz'), ('bingoplusd8aox0'),
    ('bingoplustfp5cj'), ('bingoplusuqlu6s'), ('bingoplus1n6y3v'), ('bingoplusbh5q48'), ('bingoplusbkhrmz'), ('bingoplusif8pmj'), ('gpvb5bu2'), ('bingoplus54qttz'), ('bingoplusrtje8t'), ('bingoplusfe1cl5'),
    ('bingopluskiz6jy'), ('bingoplush08az9'), ('gpuh7a3j'), ('bingoplusd2vdwi'), ('bingoplusogxsxs'), ('bingoplusuhkfj8'), ('bingoplusqymyid'), ('gphnvwt4'), ('bingoplusv67cf7'), ('lpi1r5ked'),
    ('bingoplusnrbflt'), ('bingoplusec0g5w'), ('bingoplus6xjzho'), ('bingoplusz7fulz'), ('bingoplus3pq7hy'), ('lp56cjry'), ('bingoplusr8rwfy'), ('bingoplusawx7ke'), ('perya94p5ize'), ('bingoplus7whh8t'),
    ('gpjekj3c'), ('bingoplusejkbdc'), ('bingoplus1sz2nn'), ('bingoplush5dxi4'), ('gpqj5fua'), ('bingoplusd92ml1'), ('bingoplusnehrfo'), ('bingoplus9pzdkz'), ('lpwcpev3x'), ('bingoplus0a710y'),
    ('bingoplusgxydve'), ('bingoplusqknv2v'), ('gp9tnpab'), ('lpbyh7hy'), ('gpwcpwyh'), ('bingoplus12c7cj'), ('gpey9223'), ('bingoplus14a2cn'), ('bingoplusd2qwqv'), ('lpzbjh3s'),
    ('bingoplust37hnp'), ('bingoplusu16xhi'), ('gp3vmt2j'), ('gpb5b68m'), ('gphvudgw'), ('bingopluswr98wm'), ('bingopluscsj0qp'), ('bingoplusgnoidk'), ('bingoplusagjgue'), ('bingoplusd3a6gy'),
    ('bingoplusdwhub3'), ('bingoplusj2afwn'), ('bingoplusje6uaa'), ('bingopluswn61xs'), ('bingopluso1prhi'), ('bingopluschb6s6'), ('bingoplusne7yzg'), ('bingoplusze9hkp'), ('bingoplus8hh1j3'), ('bingoplus70gqmz'),
    ('bingoplus8jacpm'), ('bingoplus1jetya'), ('lpg3eee1i'), ('bingoplusab43t5'), ('bingoplusi14tgz'), ('peryawarf1ni'), ('aquarius26'), ('bingoplusxmcf68'), ('bingoplus616w14'), ('bingoplusb2r3nv'),
    ('bingoplusn7dkw6'), ('gpv79b9w'), ('bingoplus4seta2'), ('bingopluskewy6d'), ('bingoplusd3o04o'), ('gpy9vq2s'), ('bingopluszff7bl'), ('bingoplus2u1o66'), ('gp5z9gy4'), ('bingoplusvdr5m4'),
    ('bingoplusogb1rs'), ('bingoplusjlfo9x'), ('bingoplusuh7tu8'), ('bingoplusdmqx9v'), ('bingoplus5u2bz3'), ('bingoplusg141l5'), ('bingoplus6jp677'), ('bingoplus9h3gzh'), ('bingoplusbz3nd9'), ('bingopluspksaay'),
    ('bingoplus4rl8cx'), ('bingopluszr2fve'), ('bingoplusgstfub'), ('bingoplus25td5g'), ('peryaj8du8uu'), ('bingoplush6hvt2'), ('peryangq1dhl'), ('bingoplusjvfdeu'), ('bingoplus7dfgv7'), ('bingoplus99j729'),
    ('bingoplusds198t'), ('bingoplusfc02l7'), ('bingopluslnzkq7'), ('bingopluspu0sbd'), ('bingoplusmrax4b'), ('lpki9oujh'), ('bingoplus97unsx'), ('bingoplusswrjdy'), ('bingopluscrwqfb'), ('bingoplusaqwjj0'),
    ('aivy20'), ('bingoplus2aow2a'), ('lp22rhh4p'), ('bingoplustkrfrv'), ('bingopluswxf4bx'), ('bingoplusrqg0ta'), ('bingopluspy7r1m'), ('bingoplusfsyufv'), ('bingoplus21m6wk'), ('bingoplusel89rx'),
    ('lpzh8j4n'), ('bingoplusf4430j'), ('lpa9hnxt'), ('bingopluskgdktr'), ('perya4ivu3u5'), ('bingoplusjkwqef'), ('gp5qgkfk'), ('bingoplusaa2cg4'), ('bingoplussw4wuw'), ('gpeg94uv'),
    ('bingoplusa9tthh'), ('bingoplusk6zvjf'), ('bingoplusd415b4'), ('bingoplus0ebfx7'), ('bingopluspqe39n'), ('bingoplusr882r7'), ('peryav2etuat'), ('bingoplusiupusb'), ('bingoplusqh55ad'), ('april06'),
    ('bingoplus0g3777'), ('bingoplushg6w9m'), ('bingoplus4ddfc3'), ('bingoplus383oh1'), ('bingoplust5issz'), ('bingoplusd659hv'), ('bingoplus9ya5qy'), ('bingoplusj4eg1h'), ('bingopluspqoygt'), ('bingoplus75w8z8'),
    ('bingoplusrx5lu7'), ('bingoplus89l6f8'), ('wnxjh648'), ('lp8yhfjg2'), ('lpnp9jg0w'), ('bingoplus2ivonl'), ('bingoplusyfwy9w'), ('bingoplusj5vq9e'), ('bingoplus216pfy'), ('lp66bx64y'),
    ('bingoplusy2pqzb'), ('bingoplusyknspl'), ('bingoplustlx8f2'), ('bingoplusx98vpm'), ('bingopluskxh7mv'), ('bingoplusanbzxf'), ('bingoplus2m6dhe'), ('bingoplusglxbnz'), ('bingoplusse34aa'), ('bingoplus5p1e1s'),
    ('bingoplustdw4bk'), ('bingoplus7z8oyk'), ('bingoplusyjjp3z'), ('bingoplus6o3tqx'), ('bingoplusy9ezk4'), ('bingoplusqzp452'), ('bingoplus6k38zg'), ('bingoplusz8q3vz'), ('bingoplusbzuwee'), ('bingoplusi2oi44'),
    ('lptojxkkh'), ('bingoplusvqxdua'), ('bingoplus3ac7ht'), ('bingoplusu3o2gx'), ('bingoplus3wtpmy'), ('perya8k8arlk'), ('bingoplusayupvd'), ('lpb7qxn5'), ('bingoplusm08hsy'), ('lpajv2gti'),
    ('bingoplusrajn8b'), ('bingoplusnvp47d'), ('bingoplusf7x5m8'), ('bingoplustozkpl'), ('gpmb68df'), ('bingoplusfktkds'), ('bingoplus2gmtnp'), ('bingoplusl54uqo'), ('bingoplusw8twax'), ('lpuz88uat'),
    ('peryag41cd2p'), ('bingoplus6hw8em'), ('bingoplus8a7v72'), ('bingoplusxhwach'), ('bingoplus5btfdm'), ('bingoplusm6xtkd'), ('bingoplusl7ltck'), ('bingoplusrfdnhd'), ('bingoplus6anb6s'), ('spin86mcwt'),
    ('bingoplus6fadg8'), ('bingoplusajrok2'), ('lpw9efrve'), ('bingoplus4drz0i'), ('bingoplusuty8bd'), ('bingoplus2j4ren'), ('bingopluscs2029'), ('bingopluszdvtq5'), ('lpwwbgecu'), ('bingoplus56m8fe'),
    ('sadclown0204'), ('bingoplusrs7dgs'), ('bingoplusa97582'), ('bingoplusjha0nz'), ('gpfsntan'), ('perya7g4xsnc'), ('gpczbmmy'), ('bingoplusxscaq4'), ('lpg00w5hp'), ('bingoplus9frkpm'),
    ('bingoplusdky2ud'), ('bingoplustdxh7o'), ('bingopluscljf58'), ('bingoplussc6rtl'), ('bingoplusq7ctqh'), ('bingoplus2yr2jg'), ('bingoplusv2m6tl'), ('bingopluso6o3vv'), ('bingoplusrdjg1s'), ('bingopluslvdrbk'),
    ('bingoplusm4jbse'), ('bingoplus04h6lq'), ('lpf7jch46'), ('bingopluscbxb87'), ('bingoplusgyng9w'), ('bingoplus6d6vsk'), ('lp4idbjkl'), ('bingoplust9gf6b'), ('peryap0gtcg1'), ('bingopluszrgtiq'),
    ('bingoplusy2vmue'), ('bingoplusl4uf9y'), ('bingoplus7g8gpu'), ('bingoplusiik3qf'), ('bingoplusjvwfoz'), ('bingoplusce2j5n'), ('bingoplus9ya4so'), ('bingoplusnc2q4e'), ('bingoplusjd7jee'), ('bingoplusvkx9ht'),
    ('lpd7cj3c7'), ('lpfiilt3u'), ('bingoplusdajjny'), ('bingoplusjyn7uz'), ('bingoplusm92qfj'), ('bingopluslcxd50'), ('bingoplusd7he5s'), ('bingoplus7jbm6t'), ('perya9lja76l'), ('bingoplusm4w2ak'),
    ('lpb03jsp2'), ('bingoplus9dlxsp'), ('gp5w4jef'), ('bingoplus72t40t'), ('bingoplusn33n99'), ('lpmrgnz0l'), ('bingoplusnqrhxg'), ('bingoplusvbaun9'), ('bingoplusq2tmrj'), ('bingoplus5kt29m'),
    ('bingoplusg1ueqb'), ('bingoplus9gsyxg'), ('bingoplusjz634m'), ('bingoplusq58kf1'), ('bingoplus6latm4'), ('bingoplus5zqjs9'), ('bingoplusr9hhjf'), ('bingoplusm872gy'), ('bingoplus62y7ca'), ('bingoplus91vqlk'),
    ('bingopluso2v4lb'), ('bingoplushuhiel'), ('vibercgwsrs3'), ('gpnh42f6'), ('bingoplusfsgw1v'), ('bingoplusa8vuzs'), ('lpdz6px6l'), ('bingoplus0yw0q8'), ('bingoplusv9jrqc'), ('bingoplusvkanud'),
    ('gpd2dtss'), ('peryam4qbm1n'), ('bingoplusrc7hpu'), ('bingoplusgms45h'), ('bingoplussnd98q'), ('lpbmnp6xy'), ('bingoplusrr0kfl'), ('bingoplusdpb7qe'), ('lpcatvll5'), ('gpfch2we'),
    ('rbmarzan09'), ('lphaa45x'), ('bingopluscuz0q6'), ('bingopluswa33mc'), ('bingoplusseb64n'), ('bingoplus24cq83'), ('bingoplusd8n8i9'), ('bingoplusirfp65'), ('lph0cye04'), ('jeeno1968'),
    ('bingoplus4aqmcz'), ('bingoplus9l9fyc'), ('bingopluswnnfff'), ('bingoplusg6dxof'), ('bingoplusxnb7fr'), ('gpj328da'), ('bingoplusw5q5zk'), ('bingoplusql0j7z'), ('bingoplus3r3ygy'), ('bingoplus8ddd43'),
    ('lp0p2ru0u'), ('bingoplusg0dtin'), ('gpxmcjhd'), ('bingoplus2geow0'), ('lpf036ncj'), ('bingoplusges2fw'), ('bingoplusfmwzqm'), ('bingoplus94folr'), ('gpwwkz5p'), ('bingoplusg2f2dj'),
    ('bingoplusrh4nqu'), ('lpxzz1x8s'), ('tg8lmmylm'), ('bingoplusq4kjkx'), ('bingoplus979a6u'), ('bingoplusccxmat'), ('bingoplusxy8avi'), ('bingoplusqhk08d'), ('bingoplus1l2mip'), ('lphd9zpd'),
    ('bingoplusy2sc37'), ('bingoplusc5t3sk'), ('peryai0wdqiv'), ('bingoplusw0go3f'), ('bingoplusrlkgzm'), ('bingoplusr1org9'), ('bingopluss2snwt'), ('bingoplusp5jpgm'), ('bingoplusy8rjnu'), ('bingopluswzzya2'),
    ('bingoplusugrsh7'), ('bingoplusuucdro'), ('bingoplusxgwcb3'), ('bingoplusltby4e'), ('bingoplus2gplae'), ('bingoplus4gn6j8'), ('bingoplus5r7xcw'), ('bingoplusp9d5q8'), ('bingoplushr8zmx'), ('bingoplus4zpu0m'),
    ('bingoplus4a84u7'), ('lp46bmr9'), ('lpzslbf1x'), ('bingoplus5rpj16'), ('gpcxncgm'), ('lpv894dpf'), ('perya8x6rhr7'), ('bingoplus8c16ax'), ('lpg22zrhb'), ('bingoplusqgvwco'),
    ('bingoplusf7m9jb'), ('lpax55hj5'), ('bingoplusrpxhky'), ('bingoplusv2e7be'), ('bingopluspqhssv'), ('bingopluscjn1vd'), ('lpvjwh7m3'), ('bingoplusxv8ver'), ('lpwe8z62z'), ('bingoplusgmcrfm'),
    ('bingoplusck4paj'), ('bingoplus1m63zm'), ('bingoplusj8d8kn'), ('bingoplusd7sdcf'), ('bingoplus44bgd1'), ('bingoplustl1x8m'), ('bingoplusadqxf2'), ('bingoplusxo2u0b'), ('bingoplusb70f8o'), ('bingoplusptoz43'),
    ('bingopluslg1zta'), ('bingopluscj97wp'), ('lpgn7wppu'), ('lp8umggv'), ('bingoplusz5x1r2'), ('bingoplus5umtvo'), ('bingoplus2ufdzk'), ('bingoplus7ljsra'), ('bingoplusemmygf'), ('bingoplusybvy2f'),
    ('lpvc87mzo'), ('bingoplus8gpnkg'), ('bingoplusaah8ho'), ('bingoplus1fmhyf'), ('bingoplusuquylj'), ('bingoplus6eilus'), ('gpc6z6p2'), ('bingoplushgf1mn'), ('bingoplusipmlsx'), ('gprub56k'),
    ('bingoplus9ce0yj'), ('bingoplus9thwq4'), ('lph3rf4wl'), ('bingopluspvf0rg'), ('bingoplusr2y34v'), ('bingoplusjwq3eq'), ('bingoplus3y9gcz'), ('bingoplus7uno9a'), ('gpbm8xyp'), ('bingoplusjyikxu'),
    ('bingoplusjcny5s'), ('lpbvna66x'), ('lp5oyv3cv'), ('bingoplussmwqhm'), ('bingoplus66qgn8'), ('gppsgcfm'), ('bingoplus5vjj1t'), ('bingoplush5bysz'), ('bingoplus97cax0'), ('bingoplusbu83ss'),
    ('bingoplusctj4gg'), ('benigno1974'), ('bingopluscobx7p'), ('bingoplus4f5hxe'), ('bingoplusbtuenf'), ('gp4da3vk'), ('bingoplus0afe28'), ('bingoplus4bfaqk'), ('bingoplus69gxrn'), ('bingoplus820veb'),
    ('bingoplus2wenk5'), ('bingoplus561qvr'), ('bingoplusry3qto'), ('bingoplusb39wzq'), ('bingoplush3gjzv'), ('bingoplusw4pxz5'), ('bingoplusgoizs3'), ('bingoplus7ta0ev'), ('bingoplusgiu4xp'), ('bingoplusyzka26'),
    ('gphy8m35'), ('bingopluskpcw7j'), ('bingoplus01zmi3'), ('bingoplus5zfp3m'), ('bingoplusaxjag8'), ('lpaa11s80'), ('bingoplusu8vvmg'), ('lp422wfy7'), ('bingoplusuzr47m'), ('bingoplusp7zz2u'),
    ('bingoplus85h3mz'), ('bingoplus7fsnsm'), ('bingoplusjq3s23'), ('bingoplus6qf1p4'), ('bingopluson4xt8'), ('peryabx0sjot'), ('bingoplushuzyt0'), ('bingoplus9vdlki'), ('bingoplusjyamby'), ('bingoplusb4en64'),
    ('bingoplus5twfq6'), ('lp0ganypx'), ('bingoplushhvnm9'), ('bingoplusgdhso1'), ('bingoplusg69xdq'), ('bingoplusddudfc'), ('bingoplusc4gw7k'), ('bingoplusc42htt'), ('peryasdo56iv'), ('bingoplusomn3do'),
    ('bingoplusv4b2qd'), ('bingoplus53vlmu'), ('bingoplusbteth8'), ('bingoplus7pa5ln'), ('bingoplusgwy4t2'), ('bingoplusqqgglk'), ('bingoplusw9efmy'), ('bingoplusmp5ebc'), ('bingoplush437ih'), ('bingopluscn801i'),
    ('bingoplusecsipj'), ('bingoplusjj1w9o'), ('bingoplusrn3dsj'), ('bingoplusu9fm6t'), ('bingoplusyv01pd'), ('bingoplusdwxjlo'), ('bingoplus0ym4i8'), ('bingoplusovnn2t'), ('bingoplusjp141b'), ('bingoplusw9wkj6'),
    ('lpe5xtwk'), ('peryageoigtk'), ('bingoplusjpvkyi'), ('lp4uc3ytm'), ('gp5txcr4'), ('bingoplusaz6pzj'), ('bingoplusf3k2m6'), ('lp0035xsa'), ('bingoplusy2hp45'), ('bingoplus9sk2sf'),
    ('bingoplusvk7c6l'), ('gpjgwaux'), ('bingoplusnibkbo'), ('bingoplusehpr0z'), ('bingoplusswczt7'), ('lp9umpsuj'), ('peryayv3ds3c'), ('bingoplus2ruzyg'), ('bingoplus5tzw8d'), ('bingoplus6nzvdg'),
    ('bingoplust7irwz'), ('bingoplus4egmbt'), ('bingoplusw0hdny'), ('bingopluss623y0'), ('bingoplus19nrve'), ('bingoplus59yyij'), ('lpsvoks76'), ('bingoplusi2xlft'), ('bingoplus2ddp3a'), ('bingoplus8cprvm'),
    ('bingopluspnbv6f'), ('bingoplus52e7mu'), ('bingoplusy3p3xm'), ('bingoplusj4njim'), ('bingoplusp00yqw'), ('lpfwkjvkq'), ('bingoplus55iq0b'), ('bingoplusearb69'), ('bingoplusxgik1p'), ('bingopluskme900'),
    ('bingoplus33nc4a'), ('bingoplusdhwawo'), ('bingoplusjbatcu'), ('bingopluscvk61z'), ('bingoplus3kyajp'), ('lpkkhyqtx'), ('perya3e5snhs'), ('bingoplusuenj5v'), ('bingoplus6jsmk0'), ('bingoplus1zlnym'),
    ('bingoplus7p2ve4'), ('bingoplusmj27mb'), ('lpkbxueqz'), ('bingoplus8boxoz'), ('bingopluspnxpj9'), ('lpyzvv7li'), ('peryaterkkzy'), ('bingoplusp8p2fm'), ('lp958cns'), ('bingoplusbjbtq5'),
    ('bingoplusqcncrb'), ('lp74ootiq'), ('bingoplus8kgkde'), ('lpm29g0ng'), ('bingoplushdgu27'), ('bingoplusr6drdm'), ('bingopluss0u6rv'), ('bingoplus57meoh'), ('bingoplus6z9tjq'), ('bingoplusab80cw'),
    ('bingoplusuahy43'), ('gpxgawer'), ('bingopluss31cnx'), ('bingoplus24gx7m'), ('bingoplus2vm17l'), ('bingoplusihytj5'), ('bingoplustwn6a9'), ('bingoplus8clq74'), ('bingoplusx6j9gw'), ('bingoplusyaa8g4'),
    ('bingoplusmqs9d3'), ('bingoplushuvbyu'), ('bingoplustrj57j'), ('bingopluslc7dov'), ('bingoplusgzxlda'), ('bingoplusnwpb2r'), ('bingoplusq37xbk'), ('perya7holf59'), ('bingoplus0x7alr'), ('bingoplusv2zi9y'),
    ('gpvey73v'), ('bingoplusvgvca6'), ('bingoplusfc6iaj'), ('bingoplussnmw2w'), ('bingopluslv28w9'), ('bingoplus3naiko'), ('harleneabay'), ('bingoplusuhgsx8'), ('bingoplus8mlgw3'), ('bingoplusiel45n'),
    ('bingoplus2xw56d'), ('bingoplus8jrxj3'), ('bingoplus68qcuf'), ('bingoplusosuqqd'), ('bingoplus0hyhsc'), ('bingoplusjqrm6j'), ('bingoplus3p69zm'), ('lputyacm6'), ('bingoplusd8s72c'), ('bingoplus9v0fzc'),
    ('peryaaj02q9x'), ('lpdlj00b9'), ('bingoplushvx2ok'), ('bingoplus6fickt'), ('bingoplusmyq3oq'), ('bingopluslx0mg9'), ('bingopluspm7wn0'), ('perya8opxjmh'), ('peryagtmfggf'), ('bingoplusgy449m'),
    ('bingopluspwsamn'), ('bingoplusw7d1ss'), ('bingoplus7solyo'), ('bingoplusa7hnss'), ('bingoplus81pcrl'), ('bingoplusgpdtdd'), ('bingoplus34awwv'), ('bingopluscm6sw7'), ('bingopluscj1tco'), ('bingoplusyk6q0o'),
    ('bingoplus5v5g6j'), ('bingopluss3qp9t'), ('bingoplusvzu3s3'), ('lp7jnmn0o'), ('atvbc639'), ('bingoplusavvvkg'), ('lppks4ic0'), ('johnmarquez'), ('bingopluse0a0x3'), ('lpwm42kcc'),
    ('peryat3q6368'), ('bingopluswb9xws'), ('bingoplus5gsxm2'), ('bingoplusesqpcv'), ('bingoplus6mcybu'), ('bingoplus8zl618'), ('bingoplus5k9c55'), ('bingoplus34wq51'), ('bingoplusg46wio'), ('bingoplusm46ast'),
    ('bingopluslgtn4s'), ('bingopluscvqxaa'), ('bingopluscfmf1y'), ('lp844yt8'), ('bingoplusdewqg7'), ('bingoplusxofhkg'), ('bingoplusxu9fyg'), ('lp1uic7yw'), ('lp60zmnrr'), ('bingoplusqsj6a7'),
    ('bingopluscfxogo'), ('bingoplus3r83qg'), ('bingoplusckblr1'), ('bingoplusu1k7dq'), ('bingoplusfdixo7'), ('peryaif7dzdp'), ('bingoplusnkslzg'), ('bingoplusk09mm0'), ('bingoplusdxba8c'), ('lp9dni42x'),
    ('bingoplus6hkdy7'), ('gpjuvwta'), ('bingoplusibgijh'), ('lpurz0s7q'), ('bingoplusywzpxb'), ('bingoplusivkvay'), ('bingoplusskgdsn'), ('lp7ehz1fj'), ('bingoplus7uwpdk'), ('gpfprfrw'),
    ('bingoplusn6brmd'), ('bingoplushc6ggh'), ('bingoplusc8j1hf'), ('bingoplus1s8cgw'), ('bingoplusx054rv'), ('peryaknbn6lt'), ('bingoplusnt3um1'), ('bingopluswqy2x7'), ('bingoplushxbizg'), ('lp8oi08bd'),
    ('bingoplus4n333f'), ('bingoplus2erwsu'), ('lp6bry6c'), ('bingoplusyhh01d'), ('bingoplusqhx0wq'), ('bingoplusu2w354'), ('lpt8e7pt'), ('bingoplusbhe26f'), ('bingoplusb61kte'), ('bingoplus1jj2v0'),
    ('bingoplushj2e6g'), ('bingoplusyoxsvn'), ('bingoplusbgqqj5'), ('perya53fhk2t'), ('bingoplus7hhp8m'), ('bingoplusy3he7s'), ('bingoplus6ce1gy'), ('gela96'), ('bingoplusd8euqt'), ('bingoplus9uax15'),
    ('bingoplus4faz2g'), ('bingopluspcdubp'), ('bingoplush5ae1c'), ('bingoplusfw7z1e'), ('gpzmqmds'), ('bingoplusvaq9tv'), ('bingoplusay6uxl'), ('bingoplusllqwx6'), ('bingoplusfh4oam'), ('bingoplusu03h1p'),
    ('bingoplussu9o0x'), ('bingoplusqu94cv'), ('bingoplusgfva5d'), ('bingoplusizx64g'), ('bingoplus35wm4x'), ('lpzqc6zgj'), ('bingoplus045sue'), ('bingoplush61f7u'), ('bingoplus3714zp'), ('bingoplusvtbi5n'),
    ('bingoplusmvkd1e'), ('bingoplusk86zwf'), ('bingoplus0o8rs5'), ('bingopluszc1xmr'), ('bingoplus17zxkz'), ('bingoplusbt8ru2'), ('bingopluslfe8bt')
    ) t(login_name)
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
    FROM horizon_workspace_bingoplus_3.ods_mms_t_user_fragments_di
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
    v.level_current                  AS vip_level,
    COALESCE(d.dice_count, 0)       AS dice_born_count,
    COALESCE(tr.task_redeem_amount, 0)     AS task_redeem_amount,
    COALESCE(mr.map_redeem_amount, 0)      AS map_redeem_amount,
    COALESCE(t3.top300_redeem_amount, 0)   AS top300_redeem_amount,
    COALESCE(mp.monopoly_redeem_amount, 0) AS monopoly_redeem_amount,
    COALESCE(ot.other_redeem_amount, 0)    AS other_redeem_amount,
    COALESCE(ot.other_activity_count, 0)   AS other_activity_count,
    COALESCE(g.ggr, 0)              AS ggr
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
