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
Whitelist("6f7a83db9b62a141fcb7aad2609439559dcbaf7f5f4d53") -- mari
Whitelist("ed52a464d2992e0efe5aa348176587cb429308c75f4d53") -- mari 2
Whitelist("6e875bf45c2de4610e59233d82be08f1950ad62fe911f7cbb562210fc6d1579e") -- plugd
Whitelist("fcd65acf9385489d8cc2d38ab584e041d005feee9544fbeff1d03023ebf54cac24090189d9bb6444ef72c44f1f57017c") -- 332362857671032832
Whitelist("32386463336434396230393937376265326139613963623861663635303835383761643264313334373139653764653764326332366435616439636162623236") -- spazz
Whitelist("eb140dbe-4408-11ef-8b13-806e6f6e6963") -- bantu / xeno
Whitelist("2BB0BD3B2B9AF478A1FB4CF9575F0A9F9AFF03CF457C9BAC816373E301C92DA7CEB913DA549338646BB8F1A99610960434931D8716BEB07680305CC725A43988") -- 1118243486089613462
Whitelist("31313239383164343065646235363466633033313566316438393534303031336534393766643230383038613432623866393662333738646336613837323361") -- minato
Whitelist("62396639363166333830623465373030313162663737303839326236373065393466386536363863393166336463653934666233346162643831393031323262") -- 1279918039256530954 / won giveaway

return Hwids
