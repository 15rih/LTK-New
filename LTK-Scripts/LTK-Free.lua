if game.PlaceId == (109109677622036) then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/15rih/LTK-New/refs/heads/main/LTK-Scripts/ChicagoTrenches.lua"))()
elseif game.PlaceId == (2512643572) then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/15rih/LTK-New/refs/heads/main/LTK-Scripts/BGS.lua"))()
else
    game.Players.LocalPlayer:Kick("LTK Hub [Free] | Unsupported Game, If this is an error Contact a Creator | Discord was copied to clipboard")
    setclipboard("https://discord.gg/dfzHWSGdPc")
end
