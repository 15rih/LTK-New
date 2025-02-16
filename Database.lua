local Hwids = {}

function Whitelist(Hwid)
    table.insert(Hwids,Hwid)
end
function Blacklist(Hwid)
    table.remove(Hwids, Hwids[Hwid])
end

--Whitelist("fd95c696a102412d73789c3c362d4f746fc9f75623429d5d5f5e785538eaa156")
--Whitelist("a739a809c3ccf6a0c41a1b2e432ff0d20403e9b7a5f516fb274e1ee7058d89068903c0e4ca96cbe85568b092189622b3")
Whitelist("c08a56c0192c5651b92a8357ca821ab045593980a7faf5a19e14f0b72bd2a392") -- Plugs
Whitelist("60a52042f2dcfbd7689d26190db73f1d7730f73be510a7930ce33e873cfb3534") -- Alu
Whitelist("8727d7b0685b948d616058bd8fd0b706b583bc555c684a03d8989f1396de58b2") -- llDarkSausagell
Whitelist("5384bd0f628dadac2fb47f13c92c5c56c66d78db669130f64eec0c275ba28de2") -- Stk
Whitelist("06de0831f06fec42e6ba535e075955594811c7fc5949b280a1201af35219a628") -- Damari
Whitelist("e63771b6d8074d5ea67dd51caaec8c7005db237477066d6bbd19e1bea562b8db") -- Nightcore
Whitelist("1cd32c7eb74cb7939ee706df07719e91e6087dd7f7ac8f87b4e1670cedf7a8df") -- Thug
Whitelist("723dc6b0cc2691f6f519475b9f43cc4438e85b74a374c8d0d12e9d6b760e63b0")
Whitelist("65636461623461633565346665323666393639336436396263383138633835366463303934393735353831353737313930643266343634313162633566623832") -- slra
Whitelist("37366464663332303931343835366462663862646162303830623535666535343637313733363766353039626138323161663361643730323264646537633963") -- netta
Whitelist("53b4f4b544bf74e56ff35f285d4d4fd38d5e0ae0de1e1381e550fbdeb624fdf475fec1f14165f26ac6214e580ef2d560") -- 728161631254609991
Whitelist("e07a1d8c15b88b2b51f5555a413d80723dca0a214e0df44a1078c76b13977020d5ebb16628d49275751365a88717d260") -- 1090348000527781888
Whitelist("62663566616632323365386564353862373834366332636137643063336538323030353038626338306432303132653334666562373933353639313934333935") -- 1247345153992032300
Whitelist("e7e7ac1f5c177f89e53af9b9850faf92bcc20e375f4d53") -- 1247345153992032300 / Rotation (Macsploit)
Whitelist("32386463336434396230393937376265326139613963623861663635303835383761643264313334373139653764653764326332366435616439636162623236") -- Spazz / 1155304839945924710
Whitelist("6e875bf45c2de4610e59233d82be08f1950ad62fe911f7cbb562210fc6d1579e") -- plugd
Whitelist("fcd65acf9385489d8cc2d38ab584e041d005feee9544fbeff1d03023ebf54cac24090189d9bb6444ef72c44f1f57017c") -- 332362857671032832
Whitelist("32386463336434396230393937376265326139613963623861663635303835383761643264313334373139653764653764326332366435616439636162623236") -- spazz
Whitelist("eb140dbe-4408-11ef-8b13-806e6f6e6963") -- bantu / xeno
Whitelist("2BB0BD3B2B9AF478A1FB4CF9575F0A9F9AFF03CF457C9BAC816373E301C92DA7CEB913DA549338646BB8F1A99610960434931D8716BEB07680305CC725A43988") -- 1118243486089613462
Whitelist("31313239383164343065646235363466633033313566316438393534303031336534393766643230383038613432623866393662333738646336613837323361") -- minato
Whitelist("62396639363166333830623465373030313162663737303839326236373065393466386536363863393166336463653934666233346162643831393031323262") -- 1279918039256530954 / won giveaway
Whitelist("64616463653435643130303265396265316635643536653236343264386564393931333963666163393236303965623261396330616335353863356362383634") -- 995815053553049742 / won giveaway
Whitelist("E8D87861109AE58B1E5FD2290FC5D3101CC88982C0723D2552BA77A60770068995318CD598CA55CA70FEC08C0B2BA0429AB2A283712DA865C57A28B5A55D7F02") -- spazz on Synapse Z
Whitelist("07471FEF3604291294201FC964018F2DC7D5CAA06CBD86A29F87F2F54D9F02C4B946A77D634CF76B77CB36CA5DA118CA9DADC78574C5B30918D41B25969F5642") -- 648712331366498316
Whitelist("ff23c426-ae9f-11ef-ad22-806e6f6e6963") -- Princeking / 1166868509784018976 [Xeno]
Whitelist("04563FGTHJ3604291294201FV5667218F2DC7D5CAA06CBD86A29F87F2F54D9F02C4B946A77D634CF76B77CB36CA5DA118CA9DADC78574C5B30918D41B25969F5642") -- // SevBlock
Whitelist("61653236333536663537383130663530343664616331613433363465656364323730653731343931346237343939376134643765353630656234316163613335") -- 801547730249973780
Whitelist("43cc4cd1-cb57-11ee-a8bf-806e6f6e6963") -- Jamo
Whitelist("31313239383164343065646235363466633033313566316438393534303031336534393766643230383038613432623866393662333738646336613837323361") -- minato 
Whitelist("63343563303730656464366435396363353532343036666131643838366339636630353066393166376465393336336334346262313564373262393535663133") -- 1260787408555741275
Whitelist("36386231356164333166346162303766356531356633633064373864383732623765613035333064616261336635353132636532363566386430373532393237") -- 298479579897528321 / Erick
Whitelist("000c424661e29d9fc141fc797923f73428eeb44fe9fbf0655e97eb0bfc69981ff58ecf8649b2a8760b1c54c9bc782a34") -- Btkbantu
Whitelist("eb345dad-c8ce-11ef-ad2f-806e6f6e6963") -- BtkBantu (xeno)
Whitelist("2205f2a4-59cf-11ef-97ee-806e6f6e6963")
Whitelist("64616463653435643130303265396265316635643536653236343264386564393931333963666163393236303965623261396330616335353863356362383634")
Whitelist("30373535653631323937303463646562663437366630353430616565666530336537616362333233363032396232393839343966313731653966376431313866") -- 1007397004231577680
Whitelist("c06a93d7-c0da-11ef-af8c-806e6f6e6963") -- 1007397004231577680
Whitelist("48fdae6d1733f329a91622c347f4443960b47aee5f4d53") -- 1285082544353841215
Whitelist("caf04540-e2eb-11ee-a9c3-806e6f6e6963") -- 807784119755866153 [Tester 1]
Whitelist("71a93ea9-d7f1-11ef-a9ba-806e6f6e6963") -- 792113514822107167
Whitelist("32333066613833653262623930663364373035373665396163653139393866646331346337336238336662363536653232653462306631343434373366303930") -- 798649925403410483
Whitelist("64616463653435643130303265396265316635643536653236343264386564393931333963666163393236303965623261396330616335353863356362383634") -- 995815053553049742
Whitelist("31333862356639333331386433383838396239636632363435626265386633366332353937346537643065633866353935393837386634376335346239393434") -- 1193033802260418651 [Tester 2]
Whitelist("30343163333532393234316634653636396530316336333834363564366536393561353961353237633633376162633432613337353034633338643666323535") -- 1321959511204036618
Whitelist("64643630663331386466663061333234623734316632373435383664343035326435323636666338663561383936323363313661336139666164383834323065") -- 1256928454402904175 [Tester 3]
Whitelist("30323032303436313666396561303133336230303639326363653663343761616662363533376534326237663263393562613466353433306433616364383032") -- 1126322427878723724
Whitelist("69dd3cdc-b073-11ef-8f0d-806e6f6e6963") -- 1148222402225000448
Whitelist("abface547e485e94f2124e4f195223a65c0881eb88e0d77e51af812bda265c4d") -- Staff yng 3 gud
Whitelist("29319da8-c84a-11ef-b706-806e6f6e6963")
Whitelist("a23951a540cd9c482a9185d8a38f5b78e3da49f0d4530f01a793411db7ad95d3") -- meeeeeeeee
Whitelist("c5e2881d-89b8-11ed-ac5c-806e6f6e6963") -- 1259413392599420938
Whitelist("abface547e485e94f2124e4f195223a65c0881eb88e0d77e51af812bda265c4d") -- staff yng 3 gud
Whitelist("3645c7097d600624ab1fc2a4577a3ac2de886b0aa5c488dfccaf2c2706a37a81")
Whitelist("30343163333532393234316634653636396530316336333834363564366536393561353961353237633633376162633432613337353034633338643666323535") 
Whitelist("b6f6008a-c956-11ef-9fc7-806e6f6e6963") -- 499068458252763136
Whitelist("a62920c0-6212-11ed-92b5-806e6f6e6963") -- zud
Whitelist("71928df6d4c388c2b9826f532e6a323478236e4d9cf46e8f38b02a4eb95e27a9") -- 868867709415333908
Whitelist("abface547e485e94f2124e4f195223a65c0881eb88e0d77e51af812bda265c4d")
Whitelist("a23951a540cd9c482a9185d8a38f5b78e3da49f0d4530f01a793411db7ad95d3")
Whitelist("7fbb4160-c3da-11ef-818b-806e6f6e6963") -- //1203820563198648412 
Whitelist("36373337623533353131616331323536613562363565356436323863623831646461303736343565336665343731336635373532336462333961653264623135") -- 570431918789885973
Whitelist("83a1dde17e635848961dedbc2ac52a9d3ta8dtd1d223a643cbcfcaa199fab50") -- 1168037383111979079 (Giveaway)
Whitelist("81f658c1-0305-11ee-bf11-806e6f6e6963") -- 1101190687707369643
Whitelist("65623264653363613061333334336266353935623932626634353461396464386433373332616239323266346532663431316136313839336465616533393631") -- 1111425155076472862
Whitelist("30326465336336343532316464306366326331396365653937343130306239663466656132326138613866376465356638346563636261343464353537313665") -- 879464947199922259
Whitelist("34313638393134363965353930643732333762623334613738303734663936393636373034613132353566373062336332363366333139633761613139316437") -- 1151374829329580032
Whitelist("34306664393031633539396462373035613832623935306562303632353834346130333965386363663166363932623632303839383931303764616633383431") -- 825115502728183848
Whitelist("90bb7901-a7b8-11ef-bd2c-806e6f6e6963") -- 879464947199922259
Whitelist("35313763353839646437613233343166336235613032323962366663396536663539353430393261643331363062383831623839623332663038336562633435") -- 772540182112895056
Whitelist("a9fef7ca-e0f9-11ef-b0a3-806e6f6e6963") -- 1151374829329580032
Whitelist("02162c89-e6b4-11ef-91a3-806e6f6e6963") -- 1085498790326325301
Whitelist("38e18e40-bf6d-11ed-b62f-806e6f6e6963") -- 1286487644129198092
Whitelist("37a6e37b-dbca-11ef-acce-806e6f6e6963") -- oge

return Hwids
