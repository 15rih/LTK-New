--[[
 _    _____ _   __  _   _       _     
| |  |_   _| | / / | | | |     | |    
| |    | | | |/ /  | |_| |_   _| |__  
| |    | | |    \  |  _  | | | | '_ \ 
| |____| | | |\  \ | | | | |_| | |_) |
\_____/\_/ \_| \_/ \_| |_/\__,_|_.__/ 



Credits:
Cytox | @wtwcaws - Owner/Lead Developer
EstPlugs | @justaconfessionn - Owner/Developer
Spazz | @btkbantu - Co Owner
Rotation | @iminrotation - Tester

LTK Hub is owned, Coded, Developed, and Managed by Cytox & EstPlugs alone. Anyone else who claims to be a Developer is an impersonator.
This version of LTK Hub is Paid, wanna buy? - https://discord.gg/dfzHWSGdPc

Any attempts at Stealing & or Cracking LTK Hub will result in a valid takedown request *.

Thanks for using LTK Hub [Buyers]! ^-^
]]


repeat wait(0.1) until game:IsLoaded()
if game.PlaceId == (9874911474) then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/15rih/LTK-New/refs/heads/main/LTK-Scripts/Auth.lua"))()
elseif game.PlaceId == (16472538603) then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/15rih/LTK-New/refs/heads/main/LTK-Scripts/Auth.lua"))()
else
  game.Players.LocalPlayer:Kick("LTK Hub | Unsupported Game, If this is an error Contact a Creator | Discord was copied to clipboard")
  setclipboard("https://discord.gg/dfzHWSGdPc")
end
