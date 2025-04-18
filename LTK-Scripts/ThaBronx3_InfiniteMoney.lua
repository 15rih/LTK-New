-- FUCK ALL DA SKIDS YUHHH WE ON YO AZ | FUCK ALL DA SKIDS YUHHH WE ON YO AZ
-- FUCK ALL DA SKIDS YUHHH WE ON YO AZ | FUCK ALL DA SKIDS YUHHH WE ON YO AZ
-- FUCK ALL DA SKIDS YUHHH WE ON YO AZ | FUCK ALL DA SKIDS YUHHH WE ON YO AZ
-- FUCK ALL DA SKIDS YUHHH WE ON YO AZ | FUCK ALL DA SKIDS YUHHH WE ON YO AZ
-- FUCK ALL DA SKIDS YUHHH WE ON YO AZ | FUCK ALL DA SKIDS YUHHH WE ON YO AZ
-- FUCK ALL DA SKIDS YUHHH WE ON YO AZ | FUCK ALL DA SKIDS YUHHH WE ON YO AZ
-- FUCK ALL DA SKIDS YUHHH WE ON YO AZ | FUCK ALL DA SKIDS YUHHH WE ON YO AZ
-- FUCK ALL DA SKIDS YUHHH WE ON YO AZ | FUCK ALL DA SKIDS YUHHH WE ON YO AZ


-- DMCA GON HURT LIKE A BIH
-- COVERED BY: [ GNU AFFERO GENERAL PUBLIC LICENSE v3 ] - do not ignore


--[[
⚠️ WARNING: Unauthorized use of this code will not be accepted.
This code is licensed under the GNU Affero General Public License V3. 
The AGPL mandates that any modified versions of the code, when shared, must also be licensed under the AGPL and include the source code for any changes made. 
Be aware that DMCA claims will be filed if you do not comply with the license!
]]






for i=1,999 do
	fireproximityprompt(workspace["IceFruit Sell"].ProximityPrompt)
end


task.wait(4.5) do
	if LocalPlayer.stored.FilthyStack.Value == LocalPlayer:GetAttribute("MaxMoney") then
			CoreGui.RobloxGui.Backpack.Visible =           true
			LocalPlayer.PlayerGui.Hunger.Enabled =         true
			LocalPlayer.PlayerGui.HealthGui.Enabled =      true
			LocalPlayer.PlayerGui.Run.Enabled =            true
			LocalPlayer.PlayerGui.SleepGui.Enabled =       true
			LocalPlayer.PlayerGui.MoneyGui.Enabled =       true
			LocalPlayer.PlayerGui.NewMoneyGui.Enabled =    true
			LocalPlayer.Character.HumanoidRootPart.CFrame = oldPos
			Notifications:Notify("[ LTK: Hub ] Money Dupe has been completed, you can now go wash your money & repeat.", 10, "success")
    end
end
