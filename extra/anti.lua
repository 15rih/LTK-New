local a=true;local function b(c)return rawget(c,"Detected")and typeof(rawget(c,"Detected"))=="function"and rawget(c,"RLocked")end;local function d(e,...)if a then e(...)end end;d(warn,"[TeraSeal] Adonis detected, hooking...")for f,g in next,getgc(true)do if typeof(g)=="table"and b(g)then d(warn,"phase1")for h,g in next,g do d(print,h,typeof(g))if rawequal(h,"Detected")then d(warn,"phase2")local old=hookfunction(g,function(i,j,k)if rawequal(i,"_")and rawequal(j,"_")and rawequal(k,true)then return old(i,j,k)end;d(warn,"detected for :",i,j,k)return task.wait(9e9)end)end end end end;warn("Finished")wait(2)warn("WebSocket: fetching TeraSeal")wait(0.3)warn("Response: found")
