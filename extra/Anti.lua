--//bypass adonis--//
local debugMode = true

local function isAdonisAC(table) -- basic stupid checks
    return rawget(table, "Detected") and typeof(rawget(table, "Detected")) == "function" and rawget(table, "RLocked")
end
local function dwarn(func, ...)
    if debugMode then
        --print("debug mode enable")
        func(...)
    end
end

dwarn(warn, "------------------------------")

for _, v in next, getgc(true) do
    if typeof(v) == "table" and isAdonisAC(v) then
        dwarn(warn, "uwu")
        for i, v in next, v do
            dwarn(print, i, typeof(v))
            if rawequal(i, "Detected") then
                dwarn(warn, "^^^^^^^")
                local old;
                old = hookfunction(v, function(action, info, nocrash)
                    if rawequal(action, "_") and rawequal(info, "_") and rawequal(nocrash, true) then
                        -- warn("checkup")
                        return old(action, info, nocrash)
                    end
                    dwarn(warn, "detected for :", action, info, nocrash)
                    return task.wait(9e9)
                end)
            end
        end
    end
end

warn("bypassed adonis ac")
--//Bypass//--
local old
old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    if not checkcaller() then
        local func = getnamecallmethod()
        local cScript = getcallingscript()
        local args = {...}
        if rawequal(func, "FireServer") and tonumber(self) then
            warn(self.Name)
            return wait(9e9)
    
        end
    end
    return old(self, ...)
end))
