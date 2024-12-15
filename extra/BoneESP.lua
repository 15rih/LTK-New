-- credits to whoever made this, not property of LTK HUB.

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Function to create a line using the Drawing API
local function createLine()
    local line = Drawing.new("Line")
    line.Thickness = 2 -- Thicker line
    line.Transparency = 1
    line.Color = Color3.new(1, 1, 1) -- White color
    return line
end

-- Table to store all the skeleton lines
local bones = {}

-- Function to update the ESP lines
local function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            
            if humanoid and humanoid.Health > 0 then
                local joints = {
                    {"Head", "UpperTorso"},
                    {"UpperTorso", "LowerTorso"},
                    {"UpperTorso", "LeftUpperArm"},
                    {"LeftUpperArm", "LeftLowerArm"},
                    {"LeftLowerArm", "LeftHand"},
                    {"UpperTorso", "RightUpperArm"},
                    {"RightUpperArm", "RightLowerArm"},
                    {"RightLowerArm", "RightHand"},
                    {"LowerTorso", "LeftUpperLeg"},
                    {"LeftUpperLeg", "LeftLowerLeg"},
                    {"LeftLowerLeg", "LeftFoot"},
                    {"LowerTorso", "RightUpperLeg"},
                    {"RightUpperLeg", "RightLowerLeg"},
                    {"RightLowerLeg", "RightFoot"}
                }
                
                if not bones[player] then
                    bones[player] = {}
                end

                for i, joint in pairs(joints) do
                    local part1 = character:FindFirstChild(joint[1])
                    local part2 = character:FindFirstChild(joint[2])
                    
                    if part1 and part2 then
                        if not bones[player][i] then
                            bones[player][i] = createLine()
                        end
                        
                        local line = bones[player][i]
                        local pos1, onScreen1 = workspace.CurrentCamera:WorldToViewportPoint(part1.Position)
                        local pos2, onScreen2 = workspace.CurrentCamera:WorldToViewportPoint(part2.Position)
                        
                        if onScreen1 and onScreen2 then
                            line.From = Vector2.new(pos1.X, pos1.Y)
                            line.To = Vector2.new(pos2.X, pos2.Y)
                            line.Visible = true
                        else
                            line.Visible = false
                        end
                    else
                        if bones[player][i] then
                            bones[player][i].Visible = false
                        end
                    end
                end
            else
                if bones[player] then
                    for _, line in pairs(bones[player]) do
                        line.Visible = false
                    end
                end
            end
        else
            if bones[player] then
                for _, line in pairs(bones[player]) do
                    line.Visible = false
                end
            end
        end
    end
end

-- Clean up ESP lines when a player leaves
Players.PlayerRemoving:Connect(function(player)
    if bones[player] then
        for _, line in pairs(bones[player]) do
            line:Remove()
        end
        bones[player] = nil
    end
end)

-- Run the update function every frame
RunService.RenderStepped:Connect(updateESP)
