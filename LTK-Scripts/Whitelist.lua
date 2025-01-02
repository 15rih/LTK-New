local httpService = game:GetService("HttpService")


local env = getfenv(0)
local userKey = env.script_key
if not userKey or userKey == "" then
    error("No script_key provided! Usage:\nscript_key=\"YOUR_KEY\"; loadstring(game:HttpGet(\"URL\"))()")
end


local userHWID = nil
if gethwid then
    userHWID = gethwid() 
else
    error("Could not obtain HWID from exploit. Is gethwid() supported?")
end

if not userHWID or userHWID == "" then
    error("HWID is empty or invalid.")
end


_G.UserKey = userKey
_G.UserHWID = userHWID
_G.LoaderVerified = true


local validationUrl = "http://melo.pylex.xyz:9350/validate_key?key=" 
    .. userKey .. "&hwid=" .. userHWID


local success, response = pcall(function()
    return game:HttpGet(validationUrl)
end)

if not success then
    error("Failed to contact validation server: " .. tostring(response))
end

local data
success, data = pcall(function()
    return httpService:JSONDecode(response)
end)
if not success or type(data) ~= "table" then
    error("Server returned invalid JSON: " .. tostring(response))
end

if not data.valid then
    error("Invalid key / blacklisted / HWID mismatch. Reason: " .. tostring(data.reason))
end


local mainScriptUrl = "https://raw.githubusercontent.com/15rih/LTK-New/refs/heads/main/LTK-Scripts/LTK-Hub.lua"
local success2, mainCode = pcall(function()
    return game:HttpGet(mainScriptUrl)
end)
if not success2 then
    error("Failed to execute main script: " .. tostring(mainCode))
end


local func, loadErr = loadstring(mainCode)
if not func then
    error("Error loading main script: " .. tostring(loadErr))
end

func()
