-- delete safe data
for i,v in ipairs(game:GetService("Players").LocalPlayer.InvData:GetChildren()) do
    if v ~= nil then
        v:Destroy()
    end
end

-- drop money
game:GetService("RunService"):BindToRenderStep("MoneyDrop", 0, function()
game:GetService("ReplicatedStorage"):WaitForChild("BankProcessRemote"):InvokeServer("Drop", 10000)
end)