
                    local SYC = {
    Modules = {
        UI = {}
    }
}
local CheatName = "drax"

-- check if there is no global variable SYC, and if there is none, it will set it to the table above.
-- erm its basically prefetch ifykyk
if not getgenv().SYC then
    getgenv().SYC = SYC
end

if not getgenv().load_game then
    getgenv().load_game = "da_hood"
end

if not isfolder(CheatName) then
    makefolder(CheatName)
end

if not isfolder(CheatName .. "/configs") then
    makefolder(CheatName .. "/configs")
end

if not isfolder(CheatName.. "/configs/da_hood") then
    makefolder(CheatName .. "/configs/da_hood")
end

-- make services global. self-explanatory.
getgenv().playerService = game:GetService("Players")
getgenv().coreguiService = game:GetService("CoreGui")
getgenv().tweenService = game:GetService("TweenService")
getgenv().inputService = game:GetService("UserInputService")
getgenv().rsService = game:GetService("RunService")
getgenv().replicatedStorage = game:GetService("ReplicatedStorage")
getgenv().textService = game:GetService("TextService")
getgenv().httpService = game:GetService("HttpService")
getgenv().userSettings = UserSettings()
getgenv().userGameSettings = userSettings:GetService("UserGameSettings")
getgenv().inputManager = game:GetService("VirtualInputManager")

local LocalPlayer = playerService.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- localization of lua libraries. this reduces the need to repeatedly look up these global libraries.
-- what the actual fuck weda.
local MathHuge, MathAbs, MathAcos, MathAsin, MathAtan, MathAtan2, MathCeil, MathCos, MathCosh, MathDeg, MathExp, MathFloor, MathFmod, MathFrexp, MathLdexp, MathLog, MathLog10, MathMax, MathMin, MathModf, MathPi, MathPow, MathRad, MathRandom, MathRandomseed, MathSin, MathSinh, MathSqrt, MathTan, MathTanh = math.huge, math.abs, math.acos, math.asin, math.atan, math.atan2, math.ceil, math.cos, math.cosh, math.deg, math.exp, math.floor, math.fmod, math.frexp, math.ldexp, math.log, math.log10, math.max, math.min, math.modf, math.pi, math.pow, math.rad, math.random, math.randomseed, math.sin, math.sinh, math.sqrt, math.tan, math.tanh
local TableConcat, TableInsert, TablePack, TableRemove, TableSort, TableUnpack, TableClear, TableFind = table.concat, table.insert, table.pack, table.remove, table.sort, table.unpack, table.clear, table.find
local Vector2New, Vector2Zero, Vector2New = Vector2.new, Vector2.zero, Vector2.new
local Vector3New, Vector3Zero, Vector3One, Vector3FromNormalId, Vector3FromAxis = Vector3.new, Vector3.zero, Vector3.one, Vector3.FromNormalId, Vector3.FromAxis
local UDim2New = UDim2.new
local CFrameNew, CFrameAngles, CFrameFromAxisAngle, CFrameFromEulerAnglesXYZ, CFrameFromMatrix, CFrameFromOrientation, CFrameFromQuaternion = CFrame.new, CFrame.Angles, CFrame.fromAxisAngle, CFrame.fromEulerAnglesXYZ, CFrame.fromMatrix, CFrame.fromOrientation, CFrame.fromQuaternion
local Color3New, Color3FromRGB, Color3FromHSV = Color3.new, Color3.fromRGB, Color3.fromHSV
local InstanceNew = Instance.new
local TaskDelay, TaskSpawn, TaskWait = task.delay, task.spawn, task.wait
local RaycastParamsNew = RaycastParams.new
local DrawingNew = Drawing.new

-- importing of files, this is bundled with a bundler.
local ModuleHandler = (function() -- src/Lua/Modules/ModuleHandler.lua
    -- similar to lua require, but it is for a certain table. Such as SYC.Modules
    
    local ModuleHandler = {}
    
    function ModuleHandler:include(ModuleName)
        if not SYC then return end
        if not SYC.Modules then return end
    
        if not type(ModuleName) == "string" then return end
    
        local Modules = SYC.Modules
        return Modules[ModuleName]
    end
    
    getgenv().include = function (modname) return ModuleHandler:include(modname) end 
    return ModuleHandler
end)()

do -- src/Lua/Modules/Base/
    do -- src/Lua/Modules/Base/Connection.lua
        function SYC.Modules.Connect(onething, secondthing)
            local connection = onething:Connect(secondthing)
            return connection
        end
    end
    do -- src/Lua/Modules/Base/Draw.lua
        local DrawingClass = {}
        DrawingClass.__index = DrawingClass
        DrawingClass.Objects = {}
        
        local DrawingMeta = {}
        
        DrawingMeta.__call = function (self, Arguments)
            if Arguments then
                local newObject = Drawing.new(Arguments[1])
                
                for property, value in next, Arguments[2] do
                    newObject[property] = value
                end
        
                table.insert(self.Objects, newObject)
                return newObject
            end
        end
        
        setmetatable(DrawingClass, DrawingMeta)
        
        SYC.Modules.DrawingClass = DrawingClass
    end
    do -- src/Lua/Modules/Base/Lerp.lua
        function SYC.Modules.lerp(a, b, t)
            return a + (b - a) * t
        end
    end
    do -- src/Lua/Modules/Base/Loops.lua
        local Loops = {Heartbeat = {}, RenderStepped = {}}
        function Loops:AddToHeartbeat(Name, Function)
            if Loops["Heartbeat"][Name] == nil then
                Loops["Heartbeat"][Name] = rsService.Heartbeat:Connect(Function)
            end
        end
        function Loops:RemoveFromHeartbeat(Name)
            if Loops["Heartbeat"][Name] then
                Loops["Heartbeat"][Name]:Disconnect()
                Loops["Heartbeat"][Name] = nil
            end
        end
        function Loops:AddToRenderStepped(Name, Function)
            if Loops["RenderStepped"][Name] == nil then
                Loops["RenderStepped"][Name] = rsService.RenderStepped:Connect(Function)
            end
        end
        function Loops:RemoveFromRenderStepped(Name)
            if Loops["RenderStepped"][Name] then
                Loops["RenderStepped"][Name]:Disconnect()
                Loops["RenderStepped"][Name] = nil
            end
        end
        
        SYC.Modules.Loops = Loops
    end
    do -- src/Lua/Modules/Base/PerlinNoise.lua
        -- useful shit for legit ig
        function SYC.Modules.PerlinNoise(offset, speed, time)
            local value = math.noise(time * speed + offset)
            return math.clamp(value, -0.5, 0.5)
        end
    end
    do -- src/Lua/Modules/Base/UI - Rich to Plain.lua
        -- @https://devforum.roblox.com/t/how-to-ensure-a-plain-text-string-when-using-rich-text-field/1640202
        function SYC.Modules.UI.RichTextToNormalText(str)
            local output_string = str
            while true do 
                if not output_string:find("<") and not output_string:find(">") then break end -- If not found  any <...>
                if (output_string:find("<") and not output_string:find(">")) or (output_string:find(">") and not output_string:find("<")) then return error("Invalid RichText") end -- if found only "<..." or "...>"
                output_string = output_string:gsub(output_string:sub(output_string:find("<"),output_string:find(">")),"",1) -- Removing this "<...>"
                TaskWait()
            end
            return output_string
        end
    end
    do -- src/Lua/Modules/Base/UI -GetTextBoundary.lua
        function SYC.Modules.UI:GetTextBoundary(Text, Font, Size, Resolution)
            local Bounds = textService:GetTextSize(Text, Size, Font, Resolution or Vector2New(1920, 1080))
            return Bounds.X, Bounds.Y
        end
    end
end


        local UserInterface = (function() -- src/Lua/Interface/Interface.Lua
    local UserInterface = {
        Instances = {},
        Popup = nil,
        KeybindsListObjects = {},
        KeybindList = nil,
    
        Flags = {},
        ConfigFlags = {}
    }
    getgenv().uishit = UserInterface
    
    getgenv().theme = {
        accent = Color3FromRGB(168, 157, 159)
    }
    
    getgenv().theme_event = Instance.new('BindableEvent')
    
    getgenv().UI = UserInterface.Instances
    local UIModule = include "UI"
    
    local dragging, dragInput, dragStart, startPos, dragObject
    
    local Keys = {
        [Enum.KeyCode.LeftShift] = "LS",
        [Enum.KeyCode.RightShift] = "RS", 
        [Enum.KeyCode.LeftControl] = "LC",
        [Enum.KeyCode.RightControl] = "RC",
        [Enum.KeyCode.LeftAlt] = "LA",
        [Enum.KeyCode.RightAlt] = "RA",
        [Enum.KeyCode.CapsLock] = "CAPS",
        [Enum.KeyCode.Return] = "ENT",
        [Enum.KeyCode.PageDown] = "PGD",
        [Enum.KeyCode.PageUp] = "PGU",
        [Enum.KeyCode.ScrollLock] = "SCL",
        [Enum.KeyCode.One] = "1",
        [Enum.KeyCode.Two] = "2",
        [Enum.KeyCode.Three] = "3",
        [Enum.KeyCode.Four] = "4",
        [Enum.KeyCode.Five] = "5",
        [Enum.KeyCode.Six] = "6",
        [Enum.KeyCode.Seven] = "7",
        [Enum.KeyCode.Eight] = "8",
        [Enum.KeyCode.Nine] = "9",
        [Enum.KeyCode.Zero] = "0",
        [Enum.KeyCode.KeypadOne] = "1",
        [Enum.KeyCode.KeypadTwo] = "2",
        [Enum.KeyCode.KeypadThree] = "3",
        [Enum.KeyCode.KeypadFour] = "4",
        [Enum.KeyCode.KeypadFive] = "5",
        [Enum.KeyCode.KeypadSix] = "6",
        [Enum.KeyCode.KeypadSeven] = "7",
        [Enum.KeyCode.KeypadEight] = "8",
        [Enum.KeyCode.KeypadNine] = "9",
        [Enum.KeyCode.KeypadZero] = "0",
        [Enum.KeyCode.Minus] = "-",
        [Enum.KeyCode.Equals] = "=",
        [Enum.KeyCode.Tilde] = "~",
        [Enum.KeyCode.LeftBracket] = "[",
        [Enum.KeyCode.RightBracket] = "]",
        [Enum.KeyCode.RightParenthesis] = ")",
        [Enum.KeyCode.LeftParenthesis] = "(",
        [Enum.KeyCode.Semicolon] = ",",
        [Enum.KeyCode.Quote] = "'",
        [Enum.KeyCode.BackSlash] = "\\",
        [Enum.KeyCode.Comma] = ",",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Slash] = "/",
        [Enum.KeyCode.Asterisk] = "*",
        [Enum.KeyCode.Plus] = "+",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Backquote] = "`",
        [Enum.KeyCode.Insert] = "INS",
        [Enum.UserInputType.MouseButton1] = "MB1",
        [Enum.UserInputType.MouseButton2] = "MB2",
        [Enum.UserInputType.MouseButton3] = "MB3",
        [Enum.KeyCode.Backspace] = "BS",
        [Enum.KeyCode.Escape] = "ESC",
        [Enum.KeyCode.Space] = "SPC",
    }
    
    local FlagCount = 0
    function UserInterface:GetNextFlag()
        FlagCount = FlagCount + 1
        return tostring(FlagCount)
    end
    
    function UserInterface:Create(OptionsLaughtOutLouds)
        local Configuration = {
            Tabs = {},
            Title = OptionsLaughtOutLouds.title or 'syndicate<font color="rgb(129, 127, 127)">.club</font>'
        }
    
        local Texts = {
            "v2.3.6 | Paid"--"user",
        }
    
        local function ChangeText(Object, NewText) -- this is for the thing in the top-right in the ui what
            tweenService:Create(Object, TweenInfo.new(0.2), {TextTransparency = 0.5}):Play()
            Object.Text = NewText
            TaskWait(0.1)
    
            tweenService:Create(Object, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
        end
        
        UI["1"] = InstanceNew("ScreenGui", coreguiService)
        UI["1"]["Name"] = [[syndicate.club]]
        UI["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Global
          
        UI["2"] = InstanceNew("Frame", UI["1"])
        UI["2"]["BorderSizePixel"] = 0
        UI["2"]["BackgroundColor3"] = Color3FromRGB(24, 24, 24)
        UI["2"]["Size"] = UDim2New(0, 562, 0, 459)
	UI["2"]["Position"] = UDim2New(0.5, -155, 0.5, -235)	-- kinda good: (0.5, -134, 0.5, -229)
        --UI["2"]["Position"] = UDim2New(0, 527, 0, 168)
        UI["2"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
        UI["2"]["Name"] = [[BackgroundFrame]]
        
        UI["3"] = InstanceNew("UICorner", UI["2"])
        UI["3"]["Name"] = [[BackgroundCorner]]
        
        UI["4"] = InstanceNew("UIStroke", UI["2"])
        UI["4"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
        UI["4"]["Name"] = [[BackgroundStroke]]
        UI["4"]["Thickness"] = 2
        UI["4"]["Color"] = Color3FromRGB(31, 33, 31)
        
        UI["5"] = InstanceNew("TextLabel", UI["2"])
        UI["5"]["TextStrokeTransparency"] = 0
        UI["5"]["BorderSizePixel"] = 0
        UI["5"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
        UI["5"]["TextSize"] = 16
        UI["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        UI["5"]["TextColor3"] = Color3FromRGB(255, 255, 255)
        UI["5"]["BackgroundTransparency"] = 1
        UI["5"]["Size"] = UDim2New(0, 81, 0, 20)
        UI["5"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
        UI["5"]["Text"] = Configuration.Title
        UI["5"]["Name"] = [[MainTitle]]
        UI["5"]["Position"] = UDim2New(0, 15, 0, 12)
        UI["5"]["RichText"] = true
        UI["5"]["TextXAlignment"] = Enum.TextXAlignment.Left
    
        UI["6"] = InstanceNew("Frame", UI["2"])
        UI["6"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
        UI["6"]["Size"] = UDim2New(0, 1, 0, 16)
        UI["6"]["Position"] = UDim2New(0, 98, 0, 14)
        UI["6"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
        UI["6"]["Name"] = [[BackgroundAccent]]
    
        UI["7"] = InstanceNew("Frame", UI["2"])
        UI["7"]["BorderSizePixel"] = 0
        UI["7"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
        UI["7"]["Size"] = UDim2New(0, 456, 0, 16)
        UI["7"]["Position"] = UDim2New(0, 105, 0, 14)
        UI["7"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
        UI["7"]["Name"] = [[TabsList]]
        UI["7"]["BackgroundTransparency"] = 1
    
        UI["9"] = InstanceNew("UIListLayout", UI["7"])
        UI["9"]["Padding"] = UDim.new(0, 5)
        UI["9"]["SortOrder"] = Enum.SortOrder.LayoutOrder
        UI["9"]["Name"] = [[TabsListLayout]]
        UI["9"]["FillDirection"] = Enum.FillDirection.Horizontal
    
        UI["a"] = InstanceNew("TextLabel", UI["2"])
        UI["a"]["TextWrapped"] = false
        UI["a"]["TextStrokeTransparency"] = 0
        UI["a"]["BorderSizePixel"] = 0
        UI["a"]["TextXAlignment"] = Enum.TextXAlignment.Right
        UI["a"]["TextScaled"] = false
        UI["a"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
        UI["a"]["TextSize"] = 16
        UI["a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        UI["a"]["TextColor3"] = Color3FromRGB(255, 255, 255)
        UI["a"]["BackgroundTransparency"] = 1
        UI["a"]["Size"] = UDim2New(0, 452, 0, 19)
        UI["a"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
        UI["a"]["Text"] = [[powered by ltkhub.xyz]]
        UI["a"]["Name"] = [[CreditTitle]]
        UI["a"]["Position"] = UDim2New(0, 96, 0, 428)
    
        UI["b"] = InstanceNew("Frame", UI["2"])
        UI["b"]["BorderSizePixel"] = 0
        UI["b"]["BackgroundColor3"] = Color3FromRGB(17, 17, 17)
        UI["b"]["Size"] = UDim2New(0, 533, 0, 378)
        UI["b"]["Position"] = UDim2New(0.027, 0,0.095, 0)
        UI["b"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
        UI["b"]["Name"] = [[MainFrame]]
    
        local MainFrameShadow1 = Instance.new("Frame")
        local MF_SHADOW1 = Instance.new("UIGradient")
        
        MainFrameShadow1.Name = "MainFrameShadow1"
        MainFrameShadow1.Parent = UI["b"]
        MainFrameShadow1.ZIndex = 2
        MainFrameShadow1.Size = UDim2.new(1, 0, 0.039682541, 0)
        MainFrameShadow1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        MainFrameShadow1.Position = UDim2.new(0, 0, 0.960317433, 0)
        MainFrameShadow1.BorderSizePixel = 0
        MainFrameShadow1.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        
        MF_SHADOW1.Name = "MF_SHADOW1"
        MF_SHADOW1.Parent = MainFrameShadow1
        MF_SHADOW1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.004552352242171764, 0.11475414037704468), NumberSequenceKeypoint.new(0.030349012464284897, 0.3606557846069336), NumberSequenceKeypoint.new(0.6358118057250977, 1), NumberSequenceKeypoint.new(0.9998999834060669, 1), NumberSequenceKeypoint.new(1, 0)})
        MF_SHADOW1.Rotation = -90
    
        local MainFrameShadow2 = Instance.new("Frame")
        local MF_SHADOW2 = Instance.new("UIGradient")
        
        MainFrameShadow2.Name = "MainFrameShadow2"
        MainFrameShadow2.Parent = UI["b"]
        MainFrameShadow2.ZIndex = 2
        MainFrameShadow2.Size = UDim2.new(1, 0, 0.0399999991, 0)
        MainFrameShadow2.BorderColor3 = Color3.fromRGB(0, 0, 0)
        MainFrameShadow2.BorderSizePixel = 0
        MainFrameShadow2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        
        MF_SHADOW2.Name = "MF_SHADOW2"
        MF_SHADOW2.Parent = MainFrameShadow2
        MF_SHADOW2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.004552352242171764, 0.11475414037704468), NumberSequenceKeypoint.new(0.030349012464284897, 0.3606557846069336), NumberSequenceKeypoint.new(0.6358118057250977, 1), NumberSequenceKeypoint.new(0.9998999834060669, 1), NumberSequenceKeypoint.new(1, 0)})
        MF_SHADOW2.Rotation = 90
    
        UI["c"] = InstanceNew("UICorner", UI["b"])
        UI["c"]["Name"] = [[MainFrameCorner]]
    
        UI["d"] = InstanceNew("UIStroke", UI["b"])
        UI["d"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
        UI["d"]["Name"] = [[MainFrameStroke]]
        UI["d"]["Color"] = Color3FromRGB(29, 29, 29)
    
        UI["e"] = InstanceNew("Folder", UI["2"])
        UI["e"]["Name"] = [[Sections]]
    
        local Shadow1 = Instance.new("ImageLabel")
    
        Shadow1.Name = "Shadow1"
        Shadow1.Parent = UI["2"]
        Shadow1.AnchorPoint = Vector2.new(0.5, 0.5)
        Shadow1.ZIndex = 0
        Shadow1.Size = UDim2.new(1.7, 0,2.843, 0)
        Shadow1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Shadow1.Rotation = 90
        Shadow1.BackgroundTransparency = 1
        Shadow1.Position = UDim2.new(0.468, 0,0.495, 0)
        Shadow1.BorderSizePixel = 0
        Shadow1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Shadow1.ImageColor3 = Color3.fromRGB(0, 0, 0)
        Shadow1.ScaleType = Enum.ScaleType.Tile
        Shadow1.Image = "rbxassetid://8992230677"
        Shadow1.SliceCenter = Rect.new(Vector2.new(0, 0), Vector2.new(99, 99))
    
        local text_coroutine = coroutine.create(function ()
            while TaskWait() do
                for i = 1, #Texts do
                    TaskWait(2)
                    ChangeText(UI["a"], Texts[i])
                end
            end
        end)
        coroutine.resume(text_coroutine)
    
        function Configuration:Tab( Tab_Name )
            if not type(Tab_Name) == "string" then return end
    
            local TabConfiguration = { Sections = {} }
    
            local X = UIModule:GetTextBoundary(Tab_Name, Enum.Font.SourceSans, 16)
            UI["8"] = InstanceNew("TextButton", UI["7"])
            UI["8"]["TextStrokeTransparency"] = 0
            UI["8"]["BorderSizePixel"] = 0
            UI["8"]["TextSize"] = 16
            UI["8"]["TextColor3"] = Color3FromRGB(137, 137, 139)
            UI["8"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
            UI["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            UI["8"]["Size"] = UDim2New(0, X, 1, 0)
            UI["8"]["BackgroundTransparency"] = 1
            UI["8"]["Name"] = [[TabButton]]
            UI["8"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
            UI["8"]["Text"] = Tab_Name
    
            UI["f"] = InstanceNew("Frame", UI["e"])
            UI["f"]["Active"] = true
            UI["f"]["BorderSizePixel"] = 0
            UI["f"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
            UI["f"]["Name"] = [[MainSectionFrame]]
            UI["f"]["Position"] = UDim2New(0.028, 0,0.142, 0)
            UI["f"]["Size"] = UDim2New(0, 530, 0, 378)
            UI["f"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
            UI["f"]["BackgroundTransparency"] = 1
            UI["f"]["Position"] = UDim2New(0.027, 0, 0.095, 0)
    
            local MSFrame = UI["f"]
    
            local leftblah = InstanceNew("ScrollingFrame", UI["f"])
            leftblah["Active"] = true
            leftblah["BorderSizePixel"] = 0
            leftblah["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
            leftblah["Name"] = [[Left]]
            leftblah["ScrollBarImageTransparency"] = 0
            leftblah["Size"] = UDim2New(0, 265, 1, 0)
            leftblah["ScrollBarImageColor3"] = Color3FromRGB(0, 255, 255)
            leftblah["BorderColor3"] = Color3FromRGB(0, 0, 0)
            leftblah["ScrollBarThickness"] = 3
            leftblah["BackgroundTransparency"] = 1
            leftblah.AutomaticCanvasSize = Enum.AutomaticSize.Y
            leftblah["Position"] = UDim2New(0, 0, 0, 0)
            leftblah.BottomImage = ""
            leftblah.TopImage = ""
    
            theme_event.Event:Connect(function ()
                leftblah.ScrollBarImageColor3 = theme.scroll
            end)
    
            UI["11"] = InstanceNew("UIPadding", leftblah)
            UI["11"]["PaddingTop"] = UDim.new(0, 18)
            UI["11"]["Name"] = [[LeftColumnPadding]]
            UI["11"]["PaddingLeft"] = UDim.new(0, 7)
    
            local rightblahInstance = InstanceNew("ScrollingFrame", UI["f"])
            rightblahInstance["Active"] = true
            rightblahInstance["BorderSizePixel"] = 0
            rightblahInstance["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
            rightblahInstance["Name"] = [[Right]]
            rightblahInstance["ScrollBarImageTransparency"] = 0
            rightblahInstance["Size"] = UDim2New(0, 265, 1, 0)
            rightblahInstance["ScrollBarImageColor3"] = Color3FromRGB(0, 255, 255)
            rightblahInstance["BorderColor3"] = Color3FromRGB(0, 0, 0)
            rightblahInstance["ScrollBarThickness"] = 3
            rightblahInstance["BackgroundTransparency"] = 1
            rightblahInstance.AutomaticCanvasSize = Enum.AutomaticSize.Y
            rightblahInstance["Position"] = UDim2New(0, 265, 0, 0)
            rightblahInstance.BottomImage = ""
            rightblahInstance.TopImage = ""
    
            theme_event.Event:Connect(function ()
                rightblahInstance.ScrollBarImageColor3 = theme.scroll
            end)
    
            UI["20"] = InstanceNew("UIPadding", rightblahInstance)
            UI["20"]["PaddingTop"] = UDim.new(0, 18)
            UI["20"]["PaddingRight"] = UDim.new(0, 7)
            UI["20"]["PaddingLeft"] = UDim.new(0, 6)
            UI["20"]["Name"] = [[RightColumnPadding]]
    
            UI["LISTLAYOUT_LEFT"] = InstanceNew("UIListLayout")
            UI["LISTLAYOUT_LEFT"].Name = "LeftColumnList"
            UI["LISTLAYOUT_LEFT"].Parent = leftblah
            UI["LISTLAYOUT_LEFT"].SortOrder = Enum.SortOrder.LayoutOrder
            UI["LISTLAYOUT_LEFT"].Padding = UDim.new(0, 19)
    
            UI["LISTLAYOUT_RIGHT"] = InstanceNew("UIListLayout")
            UI["LISTLAYOUT_RIGHT"].Name = "RightColumnList"
            UI["LISTLAYOUT_RIGHT"].Parent = rightblahInstance
            UI["LISTLAYOUT_RIGHT"].SortOrder = Enum.SortOrder.LayoutOrder
            UI["LISTLAYOUT_RIGHT"].Padding = UDim.new(0, 19)
    
            local localization = UI['LISTLAYOUT_LEFT']
            local localization2 = UI["LISTLAYOUT_RIGHT"]
    
            localization.Changed:Connect(function ()
                leftblah.CanvasSize = UDim2New(0, 0, 0, 100 + localization.AbsoluteContentSize.Y)
            end)
    
            localization2.Changed:Connect(function ()
                rightblahInstance.CanvasSize = UDim2New(0, 0, 0, 100 + localization2.AbsoluteContentSize.Y)
            end)
    
            TabConfiguration.Button = UI["8"]
            TabConfiguration.MainSectionFrame = MSFrame
            TabConfiguration.Left = leftblah
            TabConfiguration.Right = rightblahInstance
    
            function TabConfiguration:Select()
                for i, v in next, UI["e"]:GetChildren() do
                    if v:IsA("UIListLayout") then return end
                    v.Visible = false
                end
                for i, v in next, UI["7"]:GetChildren() do
                    if v:IsA("TextButton") then
                        v.TextColor3 = Color3FromRGB(137, 137, 139)
                    end
                end
                TabConfiguration.Button.TextColor3 = Color3FromRGB(255,255,255)
                TabConfiguration.MainSectionFrame.Visible = true
            end
            
            TabConfiguration.Button.MouseButton1Click:Connect(function ()
                TabConfiguration:Select()
            end)
    
            function TabConfiguration:Section( Section_Name, Side )
                if not type(Section_Name) == "string" then return end
                if not type(Side) == "string" then return end
    
                local SectionSide = Side == "right" and TabConfiguration.Right or TabConfiguration.Left
                local Options = {}
    
                local MainFrameThingy = InstanceNew("Frame", SectionSide)
                MainFrameThingy["BorderSizePixel"] = 0
                MainFrameThingy["BackgroundColor3"] = Color3FromRGB(28, 28, 28)
                MainFrameThingy["Size"] = UDim2New(0, 247, 0, 20)
                MainFrameThingy["Position"] = UDim2New(0, 6, 0, 0)
                MainFrameThingy["BorderColor3"] = Color3FromRGB(0, 0, 0)
                MainFrameThingy["Name"] = [[Column]]
    
                local MFSTROKE = InstanceNew("UIStroke", MainFrameThingy)
                MFSTROKE["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
                MFSTROKE["Name"] = [[ColumnStroke]]
                MFSTROKE["Color"] = Color3FromRGB(37, 37, 37)
    
                local uicornerthingyy = InstanceNew("UICorner", MainFrameThingy)
                uicornerthingyy["Name"] = [[ColumnCorner]]
    
                local titlethinggyy = InstanceNew("TextLabel", MainFrameThingy)
                titlethinggyy["TextStrokeTransparency"] = 0
                titlethinggyy["BorderSizePixel"] = 0
                titlethinggyy["TextXAlignment"] = Enum.TextXAlignment.Left
                titlethinggyy["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
                titlethinggyy["TextSize"] = 14
                titlethinggyy["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                titlethinggyy["TextColor3"] = Color3FromRGB(255, 255, 255)
                titlethinggyy["BackgroundTransparency"] = 1
                titlethinggyy["Size"] = UDim2New(0, 229, 0, -4)
                titlethinggyy["BorderColor3"] = Color3FromRGB(0, 0, 0)
                titlethinggyy["Text"] = Section_Name
                titlethinggyy["Name"] = [[ColumnTitle]]
                titlethinggyy["Position"] = UDim2New(0, 8, 0, 0)
    
                local uilistlayoutthingy = InstanceNew("UIListLayout", MainFrameThingy)
                uilistlayoutthingy["Padding"] = UDim.new(0, 13)
                uilistlayoutthingy["SortOrder"] = Enum.SortOrder.LayoutOrder
                uilistlayoutthingy["Name"] = [[ColumnListLayout]]
    
                local paddingthingy = InstanceNew("UIPadding", MainFrameThingy)
                paddingthingy["Name"] = [[ColumnPadding]]
                paddingthingy["PaddingLeft"] = UDim.new(0, 9)
    
                local SectionColumnComponents = InstanceNew("Frame", MainFrameThingy)
                SectionColumnComponents["BorderSizePixel"] = 0
                SectionColumnComponents["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
                SectionColumnComponents["Size"] = UDim2New(0, 229, 0, 0)
                SectionColumnComponents["Position"] = UDim2New(0, 0, 0, 13)
                SectionColumnComponents["BorderColor3"] = Color3FromRGB(0, 0, 0)
                SectionColumnComponents["Name"] = tostring(math.random(10000,16384))
                SectionColumnComponents["BackgroundTransparency"] = 1
    
                local aujodnousnd = InstanceNew("UIListLayout", SectionColumnComponents)
                aujodnousnd["Padding"] = UDim.new(0, 4)
                aujodnousnd["SortOrder"] = Enum.SortOrder.LayoutOrder
                aujodnousnd["Name"] = [[ColumnComponentsList]]
    
                local function increaseYSize(sizeY, Custom)
                    SectionColumnComponents["Size"] += UDim2New(0, 0, 0, sizeY)
                    MainFrameThingy.Size = UDim2New(0, 247, 0, 22 + aujodnousnd.AbsoluteContentSize.Y)
                end
    
                do -- src/Lua/Interface/Components/
                    do -- src/Lua/Interface/Components/BoneSelector.lua
                        function Options:BoneSelector(Configuration)
                            local BoneSelectorOptions = {
                                Type = Configuration.type or "R15",
                                Callback = Configuration.callback or function() end,
                                Default = Configuration.default or nil,
                                Flag = UserInterface:GetNextFlag(),
                                Multi = Configuration.multi or false
                            }
                        
                            local BoneSelector = {
                                FValues = {},
                                FValue = BoneSelectorOptions.Multi and {} or "",
                            }
                        
                            local BoneSelectorHolder = InstanceNew("Frame")
                            local BSHStroke = InstanceNew("UIStroke")
                            local BSHCorner = InstanceNew("UICorner")
                            local R15 = InstanceNew("Frame")
                            local Head = Instance.new("TextButton")
                            local HumanoidRootPart = Instance.new("TextButton")
                            local LeftHand = Instance.new("TextButton")
                            local LeftLowerArm = Instance.new("TextButton")
                            local LowerTorso = Instance.new("TextButton")
                            local LeftUpperArm = Instance.new("TextButton")
                            local RightHand = Instance.new("TextButton")
                            local RightUpperArm = Instance.new("TextButton")
                            local RightLowerArm = Instance.new("TextButton")
                            local UpperTorso = Instance.new("TextButton")
                            local LeftUpperLeg = Instance.new("TextButton")
                            local LeftLowerLeg = Instance.new("TextButton")
                            local LeftFoot = Instance.new("TextButton")
                            local RightFoot = Instance.new("TextButton")
                            local RightUpperLeg = Instance.new("TextButton")
                            local RightLowerLeg = Instance.new("TextButton")
                            local R6 = InstanceNew("Frame")
                            local Head_2 = InstanceNew("TextButton")
                            local LeftArm_2 = InstanceNew("TextButton")
                            local RightArm_2 = InstanceNew("TextButton")
                            local RightLeg_2 = InstanceNew("TextButton")
                            local LeftLeg_2 = InstanceNew("TextButton")
                            local Torso_3 = InstanceNew("TextButton")
                            local HumanoidRootPart_2 = InstanceNew("TextButton")
                            
                            BoneSelectorHolder.Name = "BoneSelectorHolder"
                            BoneSelectorHolder.Parent = SectionColumnComponents
                            BoneSelectorHolder.Size = UDim2.new(1, 0, 0, 316)
                            BoneSelectorHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            BoneSelectorHolder.Position = UDim2.new(0, 0, -1.17375305e-06, 0)
                            BoneSelectorHolder.BorderSizePixel = 0
                            BoneSelectorHolder.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
                            
                            BSHStroke.Name = "BSHStroke"
                            BSHStroke.Parent = BoneSelectorHolder
                            BSHStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                            BSHStroke.Color = Color3.fromRGB(36, 36, 36)
                            
                            BSHCorner.Name = "BSHCorner"
                            BSHCorner.Parent = BoneSelectorHolder
                            
                            R15.Name = "R15"
                            R15.Parent = BoneSelectorHolder
                            R15.Size = UDim2.new(0, 217, 0, 308)
                            R15.Visible = true
                            R15.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            R15.BackgroundTransparency = 1
                            R15.Position = UDim2.new(0.0262008738, 0, 0.0187500007, 0)
                            R15.BorderSizePixel = 0
                            R15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            
                            Head.Name = "Head"
                            Head.Parent = R15
                            Head.Size = UDim2.new(0, 60, 0, 68)
                            Head.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            Head.Position = UDim2.new(0.358999997, 0, 0.0579999983, 0)
                            Head.BorderSizePixel = 2
                            Head.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            Head.TextColor3 = Color3.fromRGB(0, 0, 0)
                            Head.Text = ""
                            Head.TextSize = 14
                            Head.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            HumanoidRootPart.Name = "HumanoidRootPart"
                            HumanoidRootPart.Parent = R15
                            HumanoidRootPart.ZIndex = 2
                            HumanoidRootPart.Size = UDim2.new(0, 22, 0, 25)
                            HumanoidRootPart.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            HumanoidRootPart.Position = UDim2.new(0.446557671, 0, 0.402155876, 0)
                            HumanoidRootPart.BorderSizePixel = 2
                            HumanoidRootPart.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            HumanoidRootPart.TextColor3 = Color3.fromRGB(0, 0, 0)
                            HumanoidRootPart.Text = ""
                            HumanoidRootPart.TextSize = 14
                            HumanoidRootPart.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LeftHand.Name = "LeftHand"
                            LeftHand.Parent = R15
                            LeftHand.Size = UDim2.new(0, 53, 0, 20)
                            LeftHand.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftHand.Position = UDim2.new(0.0778940767, 0, 0.548259795, 0)
                            LeftHand.BorderSizePixel = 2
                            LeftHand.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftHand.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftHand.Text = ""
                            LeftHand.TextSize = 14
                            LeftHand.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LeftLowerArm.Name = "LeftLowerArm"
                            LeftLowerArm.Parent = R15
                            LeftLowerArm.Size = UDim2.new(0, 53, 0, 44)
                            LeftLowerArm.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftLowerArm.Position = UDim2.new(0.0778940767, 0, 0.405238956, 0)
                            LeftLowerArm.BorderSizePixel = 2
                            LeftLowerArm.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftLowerArm.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftLowerArm.Text = ""
                            LeftLowerArm.TextSize = 14
                            LeftLowerArm.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LowerTorso.Name = "LowerTorso"
                            LowerTorso.Parent = R15
                            LowerTorso.Size = UDim2.new(0, 76, 0, 20)
                            LowerTorso.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LowerTorso.Position = UDim2.new(0.32213372, 0, 0.54809612, 0)
                            LowerTorso.BorderSizePixel = 2
                            LowerTorso.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LowerTorso.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LowerTorso.Text = ""
                            LowerTorso.TextSize = 14
                            LowerTorso.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LeftUpperArm.Name = "LeftUpperArm"
                            LeftUpperArm.Parent = R15
                            LeftUpperArm.Size = UDim2.new(0, 53, 0, 38)
                            LeftUpperArm.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftUpperArm.Position = UDim2.new(0.0778940767, 0, 0.278615594, 0)
                            LeftUpperArm.BorderSizePixel = 2
                            LeftUpperArm.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftUpperArm.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftUpperArm.Text = ""
                            LeftUpperArm.TextSize = 14
                            LeftUpperArm.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            RightHand.Name = "RightHand"
                            RightHand.Parent = R15
                            RightHand.Size = UDim2.new(0, 49, 0, 19)
                            RightHand.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightHand.Position = UDim2.new(0.672364116, 0, 0.548259795, 0)
                            RightHand.BorderSizePixel = 2
                            RightHand.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightHand.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightHand.Text = ""
                            RightHand.TextSize = 14
                            RightHand.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            RightUpperArm.Name = "RightUpperArm"
                            RightUpperArm.Parent = R15
                            RightUpperArm.Size = UDim2.new(0, 53, 0, 38)
                            RightUpperArm.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightUpperArm.Position = UDim2.new(0.672364116, 0, 0.278615594, 0)
                            RightUpperArm.BorderSizePixel = 2
                            RightUpperArm.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightUpperArm.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightUpperArm.Text = ""
                            RightUpperArm.TextSize = 14
                            RightUpperArm.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            RightLowerArm.Name = "RightLowerArm"
                            RightLowerArm.Parent = R15
                            RightLowerArm.Size = UDim2.new(0, 53, 0, 44)
                            RightLowerArm.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightLowerArm.Position = UDim2.new(0.672364116, 0, 0.405238956, 0)
                            RightLowerArm.BorderSizePixel = 2
                            RightLowerArm.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightLowerArm.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightLowerArm.Text = ""
                            RightLowerArm.TextSize = 14
                            RightLowerArm.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            UpperTorso.Name = "UpperTorso"
                            UpperTorso.Parent = R15
                            UpperTorso.Size = UDim2.new(0, 76, 0, 82)
                            UpperTorso.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            UpperTorso.Position = UDim2.new(0.32213372, 0, 0.279000014, 0)
                            UpperTorso.BorderSizePixel = 2
                            UpperTorso.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            UpperTorso.TextColor3 = Color3.fromRGB(0, 0, 0)
                            UpperTorso.Text = ""
                            UpperTorso.TextSize = 14
                            UpperTorso.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LeftUpperLeg.Name = "LeftUpperLeg"
                            LeftUpperLeg.Parent = R15
                            LeftUpperLeg.Size = UDim2.new(0, 38, 0, 62)
                            LeftUpperLeg.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftUpperLeg.Position = UDim2.new(0.32213372, 0, 0.613031149, 0)
                            LeftUpperLeg.BorderSizePixel = 2
                            LeftUpperLeg.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftUpperLeg.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftUpperLeg.Text = ""
                            LeftUpperLeg.TextSize = 14
                            LeftUpperLeg.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LeftLowerLeg.Name = "LeftLowerLeg"
                            LeftLowerLeg.Parent = R15
                            LeftLowerLeg.Size = UDim2.new(0, 38, 0, 32)
                            LeftLowerLeg.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftLowerLeg.Position = UDim2.new(0.32213372, 0, 0.814329863, 0)
                            LeftLowerLeg.BorderSizePixel = 2
                            LeftLowerLeg.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftLowerLeg.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftLowerLeg.Text = ""
                            LeftLowerLeg.TextSize = 14
                            LeftLowerLeg.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            LeftFoot.Name = "LeftFoot"
                            LeftFoot.Parent = R15
                            LeftFoot.Size = UDim2.new(0, 38, 0, 9)
                            LeftFoot.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftFoot.Position = UDim2.new(0.32213372, 0, 0.918225944, 0)
                            LeftFoot.BorderSizePixel = 2
                            LeftFoot.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftFoot.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftFoot.Text = ""
                            LeftFoot.TextSize = 14
                            LeftFoot.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            RightFoot.Name = "RightFoot"
                            RightFoot.Parent = R15
                            RightFoot.Size = UDim2.new(0, 38, 0, 9)
                            RightFoot.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightFoot.Position = UDim2.new(0.497248918, 0, 0.918225944, 0)
                            RightFoot.BorderSizePixel = 2
                            RightFoot.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightFoot.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightFoot.Text = ""
                            RightFoot.TextSize = 14
                            RightFoot.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            RightUpperLeg.Name = "RightUpperLeg"
                            RightUpperLeg.Parent = R15
                            RightUpperLeg.Size = UDim2.new(0, 38, 0, 62)
                            RightUpperLeg.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightUpperLeg.Position = UDim2.new(0.497248918, 0, 0.613031149, 0)
                            RightUpperLeg.BorderSizePixel = 2
                            RightUpperLeg.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightUpperLeg.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightUpperLeg.Text = ""
                            RightUpperLeg.TextSize = 14
                            RightUpperLeg.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            RightLowerLeg.Name = "RightLowerLeg"
                            RightLowerLeg.Parent = R15
                            RightLowerLeg.Size = UDim2.new(0, 38, 0, 32)
                            RightLowerLeg.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightLowerLeg.Position = UDim2.new(0.497248918, 0, 0.814329863, 0)
                            RightLowerLeg.BorderSizePixel = 2
                            RightLowerLeg.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightLowerLeg.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightLowerLeg.Text = ""
                            RightLowerLeg.TextSize = 14
                            RightLowerLeg.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            R6.Name = "R6"
                            R6.Parent = BoneSelectorHolder
                            R6.Size = UDim2.new(0, 217, 0, 308)
                            R6.Visible = false
                            R6.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            R6.BackgroundTransparency = 1
                            R6.Position = UDim2.new(0.0262008738, 0, 0.0187500007, 0)
                            R6.BorderSizePixel = 0
                            R6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            
                            Head_2.Name = "Head"
                            Head_2.Parent = R6
                            Head_2.Size = UDim2.new(0, 76, 0, 68)
                            Head_2.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            Head_2.Position = UDim2.new(0.322580636, 0, 0.058441557, 0)
                            Head_2.BorderSizePixel = 2
                            Head_2.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            Head_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                            Head_2.Text = ""
                            Head_2.TextSize = 14
                            Head_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            LeftArm_2.Name = "Left Arm"
                            LeftArm_2.Parent = R6
                            LeftArm_2.Size = UDim2.new(0, 53, 0, 103)
                            LeftArm_2.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftArm_2.Position = UDim2.new(0.0783410147, 0, 0.27922079, 0)
                            LeftArm_2.BorderSizePixel = 2
                            LeftArm_2.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftArm_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftArm_2.Text = ""
                            LeftArm_2.TextSize = 14
                            LeftArm_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            RightArm_2.Name = "Right Arm"
                            RightArm_2.Parent = R6
                            RightArm_2.Size = UDim2.new(0, 53, 0, 103)
                            RightArm_2.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightArm_2.Position = UDim2.new(0.672811031, 0, 0.27922079, 0)
                            RightArm_2.BorderSizePixel = 2
                            RightArm_2.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightArm_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightArm_2.Text = ""
                            RightArm_2.TextSize = 14
                            RightArm_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            RightLeg_2.Name = "Right Leg"
                            RightLeg_2.Parent = R6
                            RightLeg_2.Size = UDim2.new(0, 38, 0, 103)
                            RightLeg_2.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            RightLeg_2.Position = UDim2.new(0.497695863, 0, 0.613636374, 0)
                            RightLeg_2.BorderSizePixel = 2
                            RightLeg_2.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            RightLeg_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                            RightLeg_2.Text = ""
                            RightLeg_2.TextSize = 14
                            RightLeg_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            LeftLeg_2.Name = "Left Leg"
                            LeftLeg_2.Parent = R6
                            LeftLeg_2.Size = UDim2.new(0, 38, 0, 103)
                            LeftLeg_2.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            LeftLeg_2.Position = UDim2.new(0.322580636, 0, 0.613636374, 0)
                            LeftLeg_2.BorderSizePixel = 2
                            LeftLeg_2.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            LeftLeg_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                            LeftLeg_2.Text = ""
                            LeftLeg_2.TextSize = 14
                            LeftLeg_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            Torso_3.Name = "Torso"
                            Torso_3.Parent = R6
                            Torso_3.Size = UDim2.new(0, 76, 0, 103)
                            Torso_3.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            Torso_3.Position = UDim2.new(0.322580636, 0, 0.27922079, 0)
                            Torso_3.BorderSizePixel = 2
                            Torso_3.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            Torso_3.TextColor3 = Color3.fromRGB(0, 0, 0)
                            Torso_3.Text = ""
                            Torso_3.TextSize = 14
                            Torso_3.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            HumanoidRootPart_2.Name = "HumanoidRootPart"
                            HumanoidRootPart_2.Parent = R6
                            HumanoidRootPart_2.Size = UDim2.new(0, 31, 0, 30)
                            HumanoidRootPart_2.BorderColor3 = Color3.fromRGB(36, 36, 36)
                            HumanoidRootPart_2.Position = UDim2.new(0.42396313, 0, 0.373376638, 0)
                            HumanoidRootPart_2.BorderSizePixel = 2
                            HumanoidRootPart_2.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            HumanoidRootPart_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                            HumanoidRootPart_2.Text = ""
                            HumanoidRootPart_2.TextSize = 14
                            HumanoidRootPart_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                        
                            local function R15_function()
                                for _, bodypart in pairs(R15:GetChildren()) do
                                    bodypart.AutoButtonColor = false
                        
                                    local name = bodypart.Name
                                    --if string.find(name, "frame") then continue end
                        
                                    local self_conn = nil
                                    local function ButtonClick()
                                        tweenService:Create(bodypart, TweenInfo.new(0.2), { BackgroundColor3 = theme.accent }):Play()
                                        BoneSelector["FValues"][name].Selected = true
                        
                                        if not self_conn then
                                            self_conn = theme_event.Event:Connect(function ()
                                                if BoneSelector["FValues"][name].Selected then
                                                    bodypart.BackgroundColor3 = theme.accent
                                                end
                                            end)
                                        end
                                    end
                        
                                    local function ButtonUnClick()
                                        tweenService:Create(bodypart, TweenInfo.new(0.2), { BackgroundColor3 = Color3FromRGB(27, 27, 27) }):Play()
                                        BoneSelector["FValues"][name].Selected = false
                        
                                        if self_conn then
                                            self_conn:Disconnect(); self_conn = nil
                                        end
                                    end
                        
                                    bodypart.MouseButton1Click:Connect(function ()
                                        BoneSelectorOptions:Set(name)
                                    end)
                        
                                    BoneSelector["FValues"][name] = {
                                        Click = ButtonClick,
                                        UnClick = ButtonUnClick,
                                        Selected = false,
                                    }
                                end
                            end
                        
                            local function R6_FUNCTION()
                                for _, bodypart in pairs(R6:GetChildren()) do
                                    local name = bodypart.Name
                        
                                    local self_conn = nil
                                    local function ButtonClick()
                                        bodypart.BackgroundColor3 = theme.accent
                                        BoneSelector["FValues"][name].Selected = true
                        
                                        if not self_conn then
                                            self_conn = theme_event.Event:Connect(function ()
                                                if BoneSelector["FValues"][name].Selected then
                                                    bodypart.BackgroundColor3 = theme.accent
                                                end
                                            end)
                                        end
                                    end
                        
                                    local function ButtonUnClick()
                                        bodypart.BackgroundColor3 = Color3FromRGB(27, 27, 27)
                                        BoneSelector["FValues"][name].Selected = false
                        
                                        if self_conn then
                                            self_conn:Disconnect(); self_conn = nil
                                        end
                                    end
                        
                                    bodypart.MouseButton1Click:Connect(function ()
                                        BoneSelectorOptions:Set(name)
                                    end)
                        
                                    BoneSelector["FValues"][name] = {
                                        Click = ButtonClick,
                                        UnClick = ButtonUnClick,
                                        Selected = false,
                                    }
                        
                        
                                end
                            end
                        
                            R15_function()
                        
                            function BoneSelectorOptions:Update()
                                for _, v in pairs(BoneSelector.FValues) do
                                    if BoneSelector.FValue == _ then
                                        v.Click()
                                    else
                                        v.UnClick()
                                    end
                                end
                        
                                return BoneSelector
                            end
                        
                            function BoneSelectorOptions:Set(value)
                                if BoneSelectorOptions.Multi then
                                    if type(value) == "table" then
                                        BoneSelectorOptions:Refresh()
                            
                                        for _,v in pairs(value) do
                                            if not table.find(BoneSelector.FValue, _) then
                                                BoneSelectorOptions:Set(v)
                                            end
                                        end
                            
                                        local RemovedButtons = {}
                            
                                        for _,v in pairs(BoneSelector.FValue) do
                                            if not table.find(value, _) then
                                                RemovedButtons[#RemovedButtons + 1] = v
                                            end
                                        end
                            
                                        pcall(BoneSelectorOptions.Callback, BoneSelector.FValue)
                                        UserInterface.Flags[BoneSelectorOptions.Flag] = BoneSelector.FValue
                                        UserInterface.Flags[BoneSelectorOptions.Flag .. "f"] = { [1] = function(value)  end, [2] = function(value) BoneSelectorOptions:Set(value) end }
                            
                                        return
                                    end
                            
                                    local Index = table.find(BoneSelector.FValue, value)
                            
                                    if Index then
                                        table.remove(BoneSelector.FValue, Index)
                            
                                        BoneSelector.FValues[value].UnClick()
                            
                                        pcall(BoneSelectorOptions.Callback, BoneSelector.FValue)
                                        UserInterface.Flags[BoneSelectorOptions.Flag] = BoneSelector.FValue
                                        UserInterface.Flags[BoneSelectorOptions.Flag .. "f"] = { [1] = function() BoneSelectorOptions:Refresh() end, [2] = function(value) BoneSelectorOptions:Set(value) end }
                                    else
                                        BoneSelector.FValue[#BoneSelector.FValue + 1] = value
                            
                                        BoneSelector.FValues[value].Click()
                            
                                        pcall(BoneSelectorOptions.Callback, BoneSelector.FValue)
                                        UserInterface.Flags[BoneSelectorOptions.Flag] = BoneSelector.FValue
                                        UserInterface.Flags[BoneSelectorOptions.Flag .. "f"] = { [1] = function() BoneSelectorOptions:Refresh() end, [2] = function(value) BoneSelectorOptions:Set(value) end }
                                    end
                                else
                                    BoneSelector.FValue = value
                        
                                    for _, v in pairs(BoneSelector.FValues) do
                                        v.UnClick()
                                    end
                                    BoneSelector["FValues"][BoneSelector.FValue].Click()
                        
                                    pcall(BoneSelectorOptions.Callback, BoneSelector.FValue)
                                    UserInterface.Flags[BoneSelectorOptions.Flag] = BoneSelector.FValue
                                    UserInterface.Flags[BoneSelectorOptions.Flag .. "f"] = { [1] = function() BoneSelectorOptions:Refresh() end, [2] = function(value) BoneSelectorOptions:Set(value) end }
                                end 
                            end
                        
                            function BoneSelectorOptions:GetValues()
                                return BoneSelector.FValue
                            end
                        
                            function BoneSelectorOptions:Refresh()
                                for i, v in next, BoneSelector.FValues do
                                    if v.UnClick then
                                        v.UnClick()
                                    end
                                end
                            end
                        
                            function BoneSelectorOptions:SetMulti(bool)
                                if BoneSelectorOptions.Multi == bool then return end
                                self:Refresh()
                                BoneSelectorOptions.Multi = bool
                                BoneSelector.FValue = bool and {} or ""
                            end
                        
                            UserInterface.ConfigFlags[BoneSelectorOptions.Flag] = function(state) BoneSelectorOptions:Set(state) end
                            increaseYSize(308)
                            return BoneSelectorOptions
                        end
                    end
                    do -- src/Lua/Interface/Components/Button.lua
                        function Options:Button(Configuration)
                            local ButtonOptions = {
                                title = Configuration.title or "button",
                                callback = Configuration.callback or function () end
                            }
                            
                            local Button = InstanceNew("TextButton")
                            local ButtonCorner = InstanceNew("UICorner")
                        
                            Button.Name = "Button"
                            Button.Parent = SectionColumnComponents
                            Button.BackgroundColor3 = Color3FromRGB(21, 21, 21)
                            Button.BorderColor3 = Color3FromRGB(0, 0, 0)
                            Button.BorderSizePixel = 0
                            Button.Size = UDim2New(0, 159, 0, 23)
                            Button.AutoButtonColor = false
                            Button.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]])
                            Button.Text = ButtonOptions.title
                            Button.TextColor3 = Color3FromRGB(255, 255, 255)
                            Button.TextSize = 14
                            Button.TextStrokeTransparency = 0
                            Button.TextWrapped = true
                        
                            ButtonCorner.CornerRadius = UDim.new(0, 2)
                            ButtonCorner.Name = "ButtonCorner"
                            ButtonCorner.Parent = Button
                        
                            local ButtonStroke = InstanceNew("UIStroke", Button)
                            ButtonStroke["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
                            ButtonStroke["Name"] = [[ButtonStroke]]
                            ButtonStroke["Color"] = Color3FromRGB(37, 37, 37)
                            
                            local Tweens = {
                                OnClick = function ()
                                    local ButtonTween, ButtonStrokeTween = 
                                    tweenService:Create(Button, TweenInfo.new(0), {BackgroundColor3 = Color3FromRGB(36, 36, 36)}),
                                    tweenService:Create(ButtonStroke, TweenInfo.new(0), {Color = Color3FromRGB(45, 43, 46)})
                                    ButtonTween:Play();ButtonStrokeTween:Play()
                                end,
                                OnHover = function ()
                                    local ButtonTween, ButtonStrokeTween = 
                                    tweenService:Create(Button, TweenInfo.new(0), {BackgroundColor3 = Color3FromRGB(28, 28, 28)}),
                                    tweenService:Create(ButtonStroke, TweenInfo.new(0), {Color = Color3FromRGB(36, 36, 36)})
                                    ButtonTween:Play();ButtonStrokeTween:Play()
                                end,
                                OnMouseLeave = function ()
                                    local ButtonTween, ButtonStrokeTween = 
                                    tweenService:Create(Button, TweenInfo.new(0), {BackgroundColor3 = Color3FromRGB(21, 21, 21)}),
                                    tweenService:Create(ButtonStroke, TweenInfo.new(0), {Color = Color3FromRGB(40, 40, 40)})
                                    ButtonTween:Play();ButtonStrokeTween:Play()
                                end
                            }
                        
                            local function OnClick()
                                Tweens.OnClick()
                                pcall(ButtonOptions.callback)
                        
                                TaskWait(0.1)
                                Tweens.OnHover()
                            end
                        
                            Button.MouseButton1Click:Connect(OnClick)
                            Button.MouseEnter:Connect(Tweens.OnHover)
                            Button.MouseLeave:Connect(Tweens.OnMouseLeave)
                        
                            increaseYSize(23)
                        end
                    end
                    do -- src/Lua/Interface/Components/Colorpicker.lua
                        function Options:Colorpicker(Configuration, ToggleOption)
                            local ColorpickerOptions = {
                                Title = Configuration.title or "colorpicker",
                                Default = Configuration.default or Color3FromRGB(255,255,255),
                                Transparency = Configuration.transparency or 0,
                                Callback = Configuration.callback or function() end,
                                Flag = UserInterface:GetNextFlag()
                            }
                        
                            local Colorpicker = {
                                TransparencyValue = 0,
                        		ColorValue = nil,
                        		HuePosition = 0,
                                SlidingSat = false,
                        		SlidingHue = false,
                        		SlidingAlpha = false,
                            }
                        
                            local ColorpickerHolder = InstanceNew("Frame")
                            local ColorpickerTitle = InstanceNew("TextLabel")
                            local ColorpickerButton = InstanceNew("TextButton")
                            local ColorpickerStatus = InstanceNew("Frame")
                            local ColorpickerInline = InstanceNew("Frame")
                            local CPInlineCorner = InstanceNew("UICorner")
                            local ColorpickerContent = InstanceNew("Frame")
                            local Accent = InstanceNew("Frame")
                            local HueBackground = InstanceNew("Frame")
                            local CPHueGradient = InstanceNew("UIGradient")
                            local HuePicker = InstanceNew("ImageLabel")
                            local TextButton = InstanceNew("TextButton")
                            local SaturationBackground = InstanceNew("Frame")
                            local SaturationImage = InstanceNew("ImageLabel")
                            local SaturationPicker = InstanceNew("ImageLabel")
                            local SaturationButton = InstanceNew("TextButton")
                            local TransparencyBackground = InstanceNew("Frame")
                            local TransparencyGradient = InstanceNew("UIGradient")
                            local TransparencyPicker = InstanceNew("ImageLabel")
                            local TransparencyButton = InstanceNew("TextButton")
                        
                            ColorpickerHolder.Name = tostring(math.random(1000, 16384))
                            ColorpickerHolder.Parent = ToggleOption == nil and SectionColumnComponents or ToggleOption
                            ColorpickerHolder.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            ColorpickerHolder.BackgroundTransparency = 1.000
                            ColorpickerHolder.BorderColor3 = Color3FromRGB(0, 0, 0)
                            ColorpickerHolder.BorderSizePixel = 0
                            ColorpickerHolder.Size = UDim2New(0, 229, 0, 13)
                            
                            if ToggleOption == nil then
                                ColorpickerTitle.Name = "ColorpickerTitle"
                                ColorpickerTitle.Parent = ColorpickerHolder
                                ColorpickerTitle.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                                ColorpickerTitle.BackgroundTransparency = 1.000
                                ColorpickerTitle.BorderColor3 = Color3FromRGB(0, 0, 0)
                                ColorpickerTitle.BorderSizePixel = 0
                                ColorpickerTitle.Size = UDim2New(0, 216, 0, 13)
                                ColorpickerTitle.Font = Enum.Font.SourceSans
                                ColorpickerTitle.Text = ColorpickerOptions.Title
                                ColorpickerTitle.TextColor3 = Color3FromRGB(255, 255, 255)
                                ColorpickerTitle.TextSize = 14.000
                                ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left 
                            end
                            
                            ColorpickerButton.Name = "ColorpickerButton"
                            ColorpickerButton.Parent = ColorpickerHolder
                            ColorpickerButton.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            ColorpickerButton.BackgroundTransparency = 1.000
                            ColorpickerButton.BorderColor3 = Color3FromRGB(0, 0, 0)
                            ColorpickerButton.BorderSizePixel = 0
                            ColorpickerButton.Position = UDim2New(0.943231463, 0, 0, 0)
                            ColorpickerButton.Size = UDim2New(0, 13, 0, 13)
                            ColorpickerButton.Font = Enum.Font.SourceSans
                            ColorpickerButton.Text = ""
                            ColorpickerButton.TextColor3 = Color3FromRGB(0, 0, 0)
                            ColorpickerButton.TextSize = 14.000
                            
                            ColorpickerStatus.Name = "ColorpickerStatus"
                            ColorpickerStatus.Parent = ColorpickerHolder
                            ColorpickerStatus.BackgroundColor3 = Color3FromRGB(170, 170, 255)
                            ColorpickerStatus.BorderColor3 = Color3FromRGB(0, 0, 0)
                            ColorpickerStatus.BorderSizePixel = 0
                            ColorpickerStatus.Position = UDim2New(0.943231463, 0, 0, 0)
                            ColorpickerStatus.Size = UDim2New(0, 13, 0, 13)
                            
                            ColorpickerInline.Name = "ColorpickerInline"
                            ColorpickerInline.Parent = ColorpickerHolder
                            ColorpickerInline.BackgroundColor3 = Color3FromRGB(170, 170, 255)
                            ColorpickerInline.BackgroundTransparency = 1.000
                            ColorpickerInline.BorderColor3 = Color3FromRGB(0, 0, 0)
                            ColorpickerInline.BorderSizePixel = 0
                            ColorpickerInline.Position = UDim2New(0.943231463, 0, 0, 0)
                            ColorpickerInline.Size = UDim2New(0, 13, 0, 13)
                            ColorpickerInline.Visible = false
                            ColorpickerInline.ZIndex = 3
                            
                            CPInlineCorner.CornerRadius = UDim.new(0, 2)
                            CPInlineCorner.Name = "CPInlineCorner"
                            CPInlineCorner.Parent = ColorpickerInline
                        
                            local ColorpickerStatusCorner = InstanceNew("UICorner")
                            ColorpickerStatusCorner.CornerRadius = UDim.new(0, 4)
                            ColorpickerStatusCorner.Name = "ColorpickerStatusCorner"
                            ColorpickerStatusCorner.Parent = ColorpickerStatus
                            
                            ColorpickerContent.Name = "ColorpickerContent"
                            ColorpickerContent.Parent = ColorpickerInline
                            ColorpickerContent.BackgroundColor3 = Color3FromRGB(23, 23, 23)
                            ColorpickerContent.BorderColor3 = Color3FromRGB(0, 0, 0)
                            ColorpickerContent.Position = UDim2New(-9.46153831, 0, 0, 0)
                            ColorpickerContent.Size = UDim2New(0, 136, 0, 139)
                            ColorpickerContent.ZIndex = 3
                        
                            Accent.Name = "Accent"
                            Accent.Parent = ColorpickerContent
                            Accent.BackgroundColor3 = Color3FromRGB(168, 157, 159)
                            Accent.BorderColor3 = Color3FromRGB(0, 0, 0)
                            Accent.Size = UDim2New(1, 0, 0, 1)
                            
                            HueBackground.Name = "HueBackground"
                            HueBackground.Parent = ColorpickerContent
                            HueBackground.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            HueBackground.BorderColor3 = Color3FromRGB(0, 0, 0)
                            HueBackground.BorderSizePixel = 0
                            HueBackground.Position = UDim2New(0.879000008, 0, 0.0680000037, 0)
                            HueBackground.Size = UDim2New(0, 9, 0, 106)
                            
                            CPHueGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3FromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.17, Color3FromRGB(255, 0, 255)), ColorSequenceKeypoint.new(0.33, Color3FromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.50, Color3FromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.67, Color3FromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.83, Color3FromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3FromRGB(255, 0, 0))}
                            CPHueGradient.Rotation = 90
                            CPHueGradient.Name = "CPHueGradient"
                            CPHueGradient.Parent = HueBackground
                            
                            HuePicker.Name = "HuePicker"
                            HuePicker.Parent = HueBackground
                            HuePicker.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            HuePicker.BackgroundTransparency = 1
                            HuePicker.BorderColor3 = Color3FromRGB(0, 0, 0)
                            HuePicker.BorderSizePixel = 0
                            HuePicker.Position = UDim2New(0, -4, 0, -2)
                            HuePicker.Size = UDim2New(0, 17, 0, 5)
                            HuePicker.Image = "rbxassetid://13900818694"
                            
                            TextButton.Parent = HueBackground
                            TextButton.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            TextButton.BackgroundTransparency = 1.000
                            TextButton.BorderColor3 = Color3FromRGB(0, 0, 0)
                            TextButton.BorderSizePixel = 0
                            TextButton.Size = UDim2New(1, 0, 1, 0)
                            TextButton.Font = Enum.Font.SourceSans
                            TextButton.Text = ""
                            TextButton.TextColor3 = Color3FromRGB(0, 0, 0)
                            TextButton.TextSize = 14.000
                            
                            SaturationBackground.Name = "SaturationBackground"
                            SaturationBackground.Parent = ColorpickerContent
                            SaturationBackground.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            SaturationBackground.BorderColor3 = Color3FromRGB(0, 0, 0)
                            SaturationBackground.Position = UDim2New(0.0661764741, 0, 0.0676691756, 0)
                            SaturationBackground.Size = UDim2New(0, 102, 0, 106)
                            
                            SaturationImage.Name = "SaturationImage"
                            SaturationImage.Parent = SaturationBackground
                            SaturationImage.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            SaturationImage.BackgroundTransparency = 1.000
                            SaturationImage.BorderColor3 = Color3FromRGB(0, 0, 0)
                            SaturationImage.Size = UDim2New(1, 0, 1, 0)
                            SaturationImage.Image = "rbxassetid://13901004307"
                            
                            SaturationPicker.Name = "SaturationPicker"
                            SaturationPicker.Parent = SaturationBackground
                            SaturationPicker.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            SaturationPicker.BackgroundTransparency = 1.000
                            SaturationPicker.BorderColor3 = Color3FromRGB(0, 0, 0)
                            SaturationPicker.Position = UDim2New(0, -1, 0, -1)
                            SaturationPicker.Size = UDim2New(0, 5, 0, 5)
                            SaturationPicker.Image = "rbxassetid://13900819741"
                            
                            SaturationButton.Name = "SaturationButton"
                            SaturationButton.Parent = SaturationBackground
                            SaturationButton.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            SaturationButton.BackgroundTransparency = 1.000
                            SaturationButton.BorderColor3 = Color3FromRGB(0, 0, 0)
                            SaturationButton.BorderSizePixel = 0
                            SaturationButton.Size = UDim2New(1, 0, 1, 0)
                            SaturationButton.Font = Enum.Font.SourceSans
                            SaturationButton.Text = ""
                            SaturationButton.TextColor3 = Color3FromRGB(0, 0, 0)
                            SaturationButton.TextSize = 14.000
                            
                            TransparencyBackground.Name = "TransparencyBackground"
                            TransparencyBackground.Parent = ColorpickerContent
                            TransparencyBackground.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            TransparencyBackground.BorderColor3 = Color3FromRGB(0, 0, 0)
                            TransparencyBackground.BorderSizePixel = 0
                            TransparencyBackground.Position = UDim2New(0.0441176482, 0, 0.880901992, 0)
                            TransparencyBackground.Size = UDim2New(0, 123, 0, 6)
                            
                            TransparencyGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3FromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.57, Color3FromRGB(150, 150, 150)), ColorSequenceKeypoint.new(1.00, Color3FromRGB(0, 0, 0))}
                            TransparencyGradient.Name = "TransparencyGradient"
                            TransparencyGradient.Parent = TransparencyBackground
                            
                            TransparencyPicker.Name = "TransparencyPicker"
                            TransparencyPicker.Parent = TransparencyBackground
                            TransparencyPicker.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            TransparencyPicker.BackgroundTransparency = 1.000
                            TransparencyPicker.BorderColor3 = Color3FromRGB(0, 0, 0)
                            TransparencyPicker.BorderSizePixel = 0
                            TransparencyPicker.Position = UDim2New(0, -2, 0, -2)
                            TransparencyPicker.Size = UDim2New(0, 5, 0, 17)
                            TransparencyPicker.Image = "rbxassetid://14248606745"
                            
                            TransparencyButton.Name = "TransparencyButton"
                            TransparencyButton.Parent = TransparencyBackground
                            TransparencyButton.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            TransparencyButton.BackgroundTransparency = 1.000
                            TransparencyButton.BorderColor3 = Color3FromRGB(0, 0, 0)
                            TransparencyButton.BorderSizePixel = 0
                            TransparencyButton.Size = UDim2New(1, 0, 1, 0)
                            TransparencyButton.Font = Enum.Font.SourceSans
                            TransparencyButton.Text = ""
                            TransparencyButton.TextColor3 = Color3FromRGB(0, 0, 0)
                            TransparencyButton.TextSize = 14.000
                        
                            for _, object in next, ColorpickerContent:GetDescendants() do
                                if object:IsA("UIGradient") then continue end
                        
                                if object.ZIndex then
                                    object.ZIndex = 3
                                end
                            end
                        
                            local Hue, Sat, Val = ColorpickerOptions.Default:ToHSV()
                        
                            local contentAnimations = {
                                Open = function ( self )
                                    ColorpickerContent.Visible = true
                                    ColorpickerInline.Visible = true
                        
                                    local ContentTween = tweenService:Create(ColorpickerContent, TweenInfo.new(0.15), { BackgroundTransparency = 0,  Position = UDim2New(-10.923, 0,0, 0) })
                                    ContentTween:Play()
                                    self:FadeIn()
                                end,
                                FadeIn = function ()
                                    for _, object in pairs( ColorpickerContent:GetDescendants() ) do
                                        if object:IsA("Frame") then
                                            tweenService:Create(object, TweenInfo.new(0.15), { BackgroundTransparency = 0 }):Play()
                                        elseif object:IsA("ImageLabel") then
                                            tweenService:Create(object, TweenInfo.new(0.15), { ImageTransparency = 0 }):Play()
                                        end
                                    end
                                end,
                                FadeOut = function ()
                                    for _, object in pairs( ColorpickerContent:GetDescendants() ) do
                                        if object:IsA("Frame") then
                                            tweenService:Create(object, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()
                                        elseif object:IsA("ImageLabel") then
                                            tweenService:Create(object, TweenInfo.new(0.15), { ImageTransparency = 1 }):Play()
                                        end
                                    end
                                end
                            }
                        
                            -- to those who code, they will understand why I did this.
                            function contentAnimations:Close()
                                local ContentTween = tweenService:Create(ColorpickerContent, TweenInfo.new(0.15), { BackgroundTransparency = 1, Position = UDim2New(-9.46153831, 0,0, 0) })
                                ContentTween:Play()
                        
                                contentAnimations:FadeOut()
                        
                                TaskWait(0.15)
                        
                                ColorpickerContent.Visible = false
                                ColorpickerInline.Visible = false
                            end
                        
                            local function FromRGBA (r, g, b)
                                local rgb = Color3FromRGB(r, g, b)
                            
                                return rgb
                            end
                        
                            function ColorpickerOptions:Set(color, trans, ignore)
                                if not ColorpickerOptions.Transparency then
                                    Colorpicker.TransparencyValue = 1
                                end
                        
                                trans = trans or Colorpicker.TransparencyValue
                        
                                if typeof(color) == "table" then
                                    local OldColor = color
                        
                                    color = Color3.fromHex(OldColor[1])
                                    --trans = OldColor[2]
                                end
                        
                                Hue, Sat, Val = color:ToHSV()
                        
                                Colorpicker.ColorValue = color
                                Colorpicker.TransparencyValue = trans
                        
                                SaturationBackground.BackgroundColor3 = Color3.fromHSV(Colorpicker.HuePosition, 1, 1)
                                
                                ColorpickerStatus.BackgroundColor3 = color
                                
                                if not ignore then
                                    SaturationPicker.Position = UDim2New(0, math.clamp(Sat * SaturationBackground.AbsoluteSize.X, 0, SaturationBackground.AbsoluteSize.X - 3), 0, math.clamp(SaturationBackground.AbsoluteSize.Y - Val * SaturationBackground.AbsoluteSize.Y, 0, SaturationBackground.AbsoluteSize.Y - 3))
                                    Colorpicker.HuePosition = Hue
                                    HuePicker.Position = UDim2New(0, -2, 1 - Hue, -2)
                                end
                                pcall(ColorpickerOptions.Callback, FromRGBA(color.R * 255, color.G * 255, color.B * 255), trans)
                                UserInterface.Flags[ColorpickerOptions.Flag] = FromRGBA(color.R * 255, color.G * 255, color.B * 255)
                            end
                            ColorpickerOptions:Set(ColorpickerOptions.Default, ColorpickerOptions.Transparency)
                            
                            local function SlideSaturation(input)
                                local SizeX = math.clamp((input.Position.X - SaturationBackground.AbsolutePosition.X) / SaturationBackground.AbsoluteSize.X, 0, 1)
                                local SizeY = 1 - math.clamp((input.Position.Y - SaturationBackground.AbsolutePosition.Y) / SaturationBackground.AbsoluteSize.Y, 0, 1)
                                local PosY = math.clamp(((input.Position.Y - SaturationBackground.AbsolutePosition.Y) / SaturationBackground.AbsoluteSize.Y) * SaturationBackground.AbsoluteSize.Y, 0, SaturationBackground.AbsoluteSize.Y - 3)
                                local PosX = math.clamp(((input.Position.X - SaturationBackground.AbsolutePosition.X) / SaturationBackground.AbsoluteSize.X) * SaturationBackground.AbsoluteSize.X, 0, SaturationBackground.AbsoluteSize.X - 3)
                                
                                SaturationPicker.Position = UDim2New(0, PosX, 0, PosY)
                                ColorpickerOptions:Set(Color3.fromHSV(Colorpicker.HuePosition, SizeX, SizeY), Colorpicker.TransparencyValue, true)
                            end
                        
                            SaturationButton.MouseButton1Down:Connect(function (input)
                                Colorpicker.SlidingSat = true
                        
                                SlideSaturation({ Position = game.UserInputService:GetMouseLocation() - Vector2New(0, 36) })
                            end)
                        
                            local function SlideHue(input)
                                local SizeY = 1 - math.clamp((input.Position.Y - HueBackground.AbsolutePosition.Y) / HueBackground.AbsoluteSize.Y, 0, 1)
                                local PosY = math.clamp(((input.Position.Y - HueBackground.AbsolutePosition.Y) / HueBackground.AbsoluteSize.Y) * HueBackground.AbsoluteSize.Y, 0, HueBackground.AbsoluteSize.Y - 2)
                            
                                HuePicker.Position = UDim2New(0, -2, 0, PosY - 2)
                                Colorpicker.HuePosition = SizeY
                        
                                ColorpickerOptions:Set(Color3.fromHSV(SizeY, Sat, Val), Colorpicker.TransparencyValue, true)
                            end
                        
                            TextButton.MouseButton1Down:Connect(function (input)
                                Colorpicker.SlidingHue = true
                        
                                SlideHue({ Position = game.UserInputService:GetMouseLocation() - Vector2New(0, 36) })
                            end)
                        
                            local function SlideTrans(input)
                                local SizeX = 1 - math.clamp((input.Position.X - TransparencyBackground.AbsolutePosition.X) / TransparencyBackground.AbsoluteSize.X, 0, 1)
                                local PosX = math.clamp(((input.Position.X - TransparencyBackground.AbsolutePosition.X) / TransparencyBackground.AbsoluteSize.X) * TransparencyBackground.AbsoluteSize.X, 0, TransparencyBackground.AbsoluteSize.X - 3)
                        
                                TransparencyPicker.Position = UDim2New(0, PosX, 0, -2)
                        
                                ColorpickerOptions:Set(Color3.fromHSV(Colorpicker.HuePosition, Sat, Val), SizeX, true)
                            end
                        
                            TransparencyButton.MouseButton1Down:Connect(function (input)
                                Colorpicker.SlidingAlpha = true
                        
                                SlideTrans({ Position = game.UserInputService:GetMouseLocation() - Vector2New(0, 36) })
                            end)
                        
                            inputService.InputEnded:Connect(function (input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    Colorpicker.SlidingSat, Colorpicker.SlidingHue, Colorpicker.SlidingAlpha = false, false, false
                                end
                            end)
                        
                            inputService.InputChanged:Connect(function (input)
                                if input.UserInputType == Enum.UserInputType.MouseMovement then
                                    if Colorpicker.SlidingSat then
                                        SlideSaturation(input)
                                    elseif Colorpicker.SlidingHue then
                                        SlideHue(input)
                                    elseif Colorpicker.SlidingAlpha then
                                        SlideTrans(input)
                                    end
                                end
                            end)
                        
                            ColorpickerButton.MouseButton1Click:Connect(function ()
                                if UserInterface.Popup and UserInterface.Popup.ID ~= ColorpickerHolder.Name then
                                    UserInterface:RemovePopups()
                                end
                                if ColorpickerInline.Visible then
                                    contentAnimations:Close()
                                else
                                    UserInterface:NewPopup({ Remove = contentAnimations.Close, ID = ColorpickerHolder.Name })
                                    contentAnimations:Open()
                                end
                            end)
                        
                            increaseYSize(13)
                        
                            UserInterface.ConfigFlags[ColorpickerOptions.Flag] = function(value) ColorpickerOptions:Set(value) end
                        
                            return ColorpickerOptions
                        end
                    end
                    do -- src/Lua/Interface/Components/Dropdowns.lua
                        function Options:Dropdown(Configuration)
                            local DropdownOptions = {
                                Title = Configuration.title or "",
                                Content = Configuration.values or {},
                                Default = Configuration.default or "-",
                                Multi = Configuration.multi or false,
                                Callback = Configuration.callback or function () end,
                                Flag = UserInterface:GetNextFlag()
                            }
                        
                            local Dropdown = {
                                FValues = {},
                                FValue = DropdownOptions.Multi and {} or "",
                            }
                        
                            local DropdownHolder = InstanceNew("Frame")
                            local DropdownTitle = InstanceNew("TextLabel")
                        
                            DropdownHolder.Name = tostring(math.random(100, 16030))
                            DropdownHolder.Parent = SectionColumnComponents
                            DropdownHolder.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            DropdownHolder.BackgroundTransparency = 1.000
                            DropdownHolder.BorderColor3 = Color3FromRGB(0, 0, 0)
                            DropdownHolder.BorderSizePixel = 0
                            DropdownHolder.Size = UDim2New(0, 229, 0, 40)
                            
                            DropdownTitle.Name = "DropdownTitle"
                            DropdownTitle.Parent = DropdownHolder
                            DropdownTitle.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            DropdownTitle.BackgroundTransparency = 1.000
                            DropdownTitle.BorderColor3 = Color3FromRGB(0, 0, 0)
                            DropdownTitle.BorderSizePixel = 0
                            DropdownTitle.Size = UDim2New(0, 164, 0, 13)
                            DropdownTitle.Font = Enum.Font.SourceSans
                            DropdownTitle.Text = DropdownOptions.Title
                            DropdownTitle.TextColor3 = Color3FromRGB(255, 255, 255)
                            DropdownTitle.TextSize = 14.000
                            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
                        
                            local xcxcxcxcxc = InstanceNew("UIListLayout", DropdownHolder)
                            xcxcxcxcxc["Padding"] = UDim.new(0, 5)
                            xcxcxcxcxc["SortOrder"] = Enum.SortOrder.LayoutOrder
                            xcxcxcxcxc["Name"] = [[ColumnListLayout]]
                            
                            local OpenButton = InstanceNew("TextButton")
                        	local OpenButtonCorner = InstanceNew("UICorner")
                        	local OpenButtonStroke = InstanceNew("UIStroke")
                        	local DropdownImage = InstanceNew("ImageLabel")
                        	local DropdownText = InstanceNew("TextLabel")
                        
                            OpenButton.Name = "OpenButton"
                            OpenButton.Parent = DropdownHolder
                            OpenButton.ZIndex = 2
                            OpenButton.Size = UDim2New(0, 230, 0, 22)
                            OpenButton.BorderColor3 = Color3FromRGB(34, 34, 34)
                            OpenButton.Position = UDim2New(0, 0, 0.576923072, 0)
                            OpenButton.BackgroundColor3 = Color3FromRGB(21, 21, 21)
                            OpenButton.AutoButtonColor = false
                            OpenButton.TextColor3 = Color3FromRGB(255, 255, 255)
                            OpenButton.Text = ""
                            OpenButton.TextXAlignment = Enum.TextXAlignment.Left
                            OpenButton.TextSize = 14
                            OpenButton.TextTruncate = Enum.TextTruncate.AtEnd
                            OpenButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            OpenButtonCorner.Name = "OpenButtonCorner"
                            OpenButtonCorner.Parent = OpenButton
                            OpenButtonCorner.CornerRadius = UDim.new(0, 3)
                            
                            OpenButtonStroke.Name = "OpenButtonStroke"
                            OpenButtonStroke.Parent = OpenButton
                            OpenButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                            OpenButtonStroke.Color = Color3FromRGB(15, 15, 15)
                            
                            DropdownImage.Name = "DropdownImage"
                            DropdownImage.Parent = OpenButton
                            DropdownImage.ZIndex = 3
                            DropdownImage.Size = UDim2New(0, 9, 0, 6)
                            DropdownImage.BorderColor3 = Color3FromRGB(0, 0, 0)
                            DropdownImage.BackgroundTransparency = 1
                            DropdownImage.Position = UDim2New(0.939999938, 0, 0.342727214, 0)
                            DropdownImage.BorderSizePixel = 0
                            DropdownImage.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            DropdownImage.Image = "rbxassetid://17830630301"
                            
                            DropdownText.Name = "DropdownText"
                            DropdownText.Parent = OpenButton
                            DropdownText.ZIndex = 3
                            DropdownText.Size = UDim2New(0, 204, 0, 22)
                            DropdownText.BorderColor3 = Color3FromRGB(0, 0, 0)
                            DropdownText.BackgroundTransparency = 1
                            DropdownText.Position = UDim2New(0.0130434781, 0, 0, 0)
                            DropdownText.BorderSizePixel = 0
                            DropdownText.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            DropdownText.TextColor3 = Color3FromRGB(255, 255, 255)
                            DropdownText.Text = DropdownOptions.Default
                            DropdownText.TextXAlignment = Enum.TextXAlignment.Left
                            DropdownText.TextSize = 14
                            DropdownText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            DropdownText.TextTruncate = "AtEnd"
                        
                            local Inline = InstanceNew("Frame")
                            local InlineCorner = InstanceNew("UICorner")
                            local InlineStroke = InstanceNew("UIStroke")
                            local InlineList = InstanceNew("UIListLayout")
                        
                            Inline.Name = "Inline"
                            Inline.Parent = OpenButton
                            Inline.Size = UDim2New(0, 229, 0, 0)
                            Inline.BorderColor3 = Color3FromRGB(0, 0, 0)
                            Inline.Position = UDim2New(0, 0, 1, 0)
                            Inline.BorderSizePixel = 0
                            Inline.BackgroundColor3 = Color3FromRGB(15, 15, 15)
                            Inline.Visible = false
                            Inline.ZIndex = 3
                            
                            InlineCorner.Name = "InlineCorner"
                            InlineCorner.Parent = Inline
                            InlineCorner.CornerRadius = UDim.new(0, 3)
                            
                            InlineStroke.Name = "InlineStroke"
                            InlineStroke.Parent = Inline
                            InlineStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                            InlineStroke.Color = Color3FromRGB(37, 37, 37)
                            
                            InlineList.Name = "InlineList"
                            InlineList.Parent = Inline
                        
                            local contentAnimations = {
                                Open = function ( self )
                                    Inline.Visible = true
                        
                                    local ImageRotation = tweenService:Create(DropdownImage, TweenInfo.new(0.15), { Rotation = 180 })
                                    ImageRotation:Play()
                        
                                    local ContentTween = tweenService:Create(Inline, TweenInfo.new(0.15), { BackgroundTransparency = 0 })
                                    ContentTween:Play()
                                    self:FadeIn()
                                end,
                                FadeIn = function ()
                                    for _, object in pairs( Inline:GetDescendants() ) do
                                        if object:IsA("Frame") then
                                            tweenService:Create(object, TweenInfo.new(0.15), { BackgroundTransparency = 0 }):Play()
                                        elseif object:IsA("TextButton") then
                                            tweenService:Create(object, TweenInfo.new(0.15), { TextTransparency = 0 }):Play()
                                        elseif object:IsA("UIStroke") then
                                            tweenService:Create(object, TweenInfo.new(0.15), { Transparency = 0 }):Play()
                                        elseif object:IsA("TextLabel") then
                                            tweenService:Create(object, TweenInfo.new(0.15), { TextTransparency = 0 }):Play()
                                        end
                                    end
                                end,
                                FadeOut = function ()
                                    for _, object in pairs( Inline:GetDescendants() ) do
                                        if object:IsA("Frame") then
                                            tweenService:Create(object, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()
                                        elseif object:IsA("TextButton") then
                                            tweenService:Create(object, TweenInfo.new(0.15), { TextTransparency = 1 }):Play()
                                        elseif object:IsA("TextLabel") then
                                            tweenService:Create(object, TweenInfo.new(0.15), { TextTransparency = 1 }):Play()
                                        elseif object:IsA("UIStroke") then
                                            tweenService:Create(object, TweenInfo.new(0.15), { Transparency = 1 }):Play()
                                        end
                                    end
                                end
                            }
                            
                            function contentAnimations:Close()
                                local ContentTween = tweenService:Create(Inline, TweenInfo.new(0.15), { BackgroundTransparency = 1 })
                                ContentTween:Play()
                        
                                local ImageRotation = tweenService:Create(DropdownImage, TweenInfo.new(0.15), { Rotation = 0 })
                                ImageRotation:Play()
                        
                                contentAnimations:FadeOut()
                        
                                TaskWait(0.15)
                        
                                Inline.Visible = false
                            end
                        
                            local Count = 0
                        
                            function Dropdown:CreateValue(name)
                                if not Dropdown.FValues[name] then
                                    local Objects = {}
                        
                                    local DropdownButton = InstanceNew("TextButton")
                                    local DBStroke = InstanceNew("UIStroke")
                                    local DBCorner = InstanceNew("UICorner")
                                    local DBName = InstanceNew("TextLabel")
                        
                                    DropdownButton.Name = "DropdownButton"
                                    DropdownButton.Parent = Inline
                                    DropdownButton.Size = UDim2.new(1, 0, 0, 14)
                                    DropdownButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                                    DropdownButton.BackgroundTransparency = 1
                                    DropdownButton.Position = UDim2.new(0.0131004369, 0, 0, 0)
                                    DropdownButton.BorderSizePixel = 0
                                    DropdownButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    DropdownButton.Text = ""
                                    DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
                                    DropdownButton.TextSize = 14
                                    DropdownButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                                    DropdownButton.TextTransparency = 1
                                    DropdownButton.ZIndex = 4
                        
                                    DBStroke.Name = "DBStroke"
                                    DBStroke.Parent = DropdownButton
                                    DBStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                                    DBStroke.Color = Color3.fromRGB(24, 24, 24)
                                    
                                    DBCorner.Name = "DBCorner"
                                    DBCorner.Parent = DropdownButton
                                    DBCorner.CornerRadius = UDim.new(0, 3)
                                    
                                    DBName.Name = "DBName"
                                    DBName.Parent = DropdownButton
                                    DBName.Size = UDim2.new(0, 226, 1, 0)
                                    DBName.BorderColor3 = Color3.fromRGB(0, 0, 0)
                                    DBName.BackgroundTransparency = 1
                                    DBName.Position = UDim2.new(0.0131004369, 0, 0, 0)
                                    DBName.BorderSizePixel = 0
                                    DBName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                    DBName.TextColor3 = Color3.fromRGB(129, 129, 127)
                                    DBName.TextXAlignment = Enum.TextXAlignment.Left
                                    DBName.TextSize = 14
                                    DBName.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                                    DBName.Text = name
                                    DBName.ZIndex = 4
                        
                                    Objects.Name = DropdownButton
                        
                                    Inline.Size += UDim2.new(0, 0, 0, 14)
                        
                                    local function Click()
                                        DBName.TextColor3 = Color3.fromRGB(168, 157, 159)
                                        Dropdown.FValues[name].Selected = true
                                    end
                        
                                    local function Unclick()
                                        DBName.TextColor3 = Color3.fromRGB(129, 129, 127)
                                        Dropdown.FValues[name].Selected = false
                                    end
                        
                                    DropdownButton.MouseButton1Down:Connect(function ()
                                        Dropdown:Set(name)
                                    end)
                                    
                                    Count += 1
                        
                                    Dropdown.FValues[name] = {
                                        Click = Click,
                                        Unclick = Unclick,
                                        Objects = Objects,
                                        Selected = false,
                                    }
                        
                                    theme_event.Event:Connect(function ()
                                        if Dropdown["FValues"][name].Selected then
                                            DBName.TextColor3 = theme.accent
                                        end
                                    end)
                                end
                        
                                return Dropdown
                            end
                        
                            function Dropdown:Update()
                                for _, v in pairs(Dropdown.FValues) do
                                    if Dropdown.FValue == _ then
                                        v.Click()
                                    else
                                        v.Unclick()
                                    end
                                end
                        
                                return Dropdown
                            end
                        
                            function Dropdown:Display()
                                if DropdownOptions.Multi then
                                    local CurrentText = {}
                        
                                    if #Dropdown.FValue > 0 then
                                        for _,v in pairs(Dropdown.FValue) do
                                            CurrentText[#CurrentText + 1] = v
                        
                                            local Text = table.concat(CurrentText, ", ")
                                            DropdownText.Text = Text
                                        end
                                    else
                                        DropdownText.Text = "-"
                                    end
                                else
                                    DropdownText.Text = Dropdown.FValue ~= "" and Dropdown.FValue or "-"
                                end
                        
                                return Dropdown
                            end
                        
                            function Dropdown:Set(value)
                                if DropdownOptions.Multi then
                                    if typeof(value) == "table" then
                                        for _,v in pairs(value) do
                                            if not table.find(Dropdown.FValue, _) then
                                                Dropdown:Set(v)
                                            end
                                        end
                        
                                        local RemovedButtons = {}
                        
                                        for _,v in pairs(Dropdown.FValue) do
                                            if not table.find(value, _) then
                                                RemovedButtons[#RemovedButtons + 1] = v
                                            end
                                        end
                        
                                        pcall(DropdownOptions.Callback, Dropdown.FValue)
                                        UserInterface.Flags[DropdownOptions.Flag] = Dropdown.FValue
                                        UserInterface.Flags[DropdownOptions.Flag .. "f"] = { [1] = function(value) Dropdown:Refresh(value) end, [2] = function(value) Dropdown:Set(value) end }
                        
                                        return
                                    end
                        
                                    local Index = table.find(Dropdown.FValue, value)
                        
                                    if Index then
                                        table.remove(Dropdown.FValue, Index)
                        
                                        Dropdown:Display()
                        
                                        Dropdown.FValues[value].Unclick()
                        
                                        pcall(DropdownOptions.Callback, Dropdown.FValue)
                                        UserInterface.Flags[DropdownOptions.Flag] = Dropdown.FValue
                                        UserInterface.Flags[DropdownOptions.Flag .. "f"] = { [1] = function(value) Dropdown:Refresh(value) end, [2] = function(value) Dropdown:Set(value) end }
                                    else
                                        Dropdown.FValue[#Dropdown.FValue + 1] = value
                        
                                        Dropdown:Display()
                        
                                        Dropdown.FValues[value].Click()
                        
                                        pcall(DropdownOptions.Callback, Dropdown.FValue)
                                        UserInterface.Flags[DropdownOptions.Flag] = Dropdown.FValue
                                        UserInterface.Flags[DropdownOptions.Flag .. "f"] = { [1] = function(value) Dropdown:Refresh(value) end, [2] = function(value) Dropdown:Set(value) end }
                                    end
                                else
                                    Dropdown.FValue = value
                        
                                    self:Update()
                        
                                    Dropdown:Display()
                                    pcall(DropdownOptions.Callback, Dropdown.FValue)
                                    UserInterface.Flags[DropdownOptions.Flag] = Dropdown.FValue
                                    UserInterface.Flags[DropdownOptions.Flag .. "f"] = { [1] = function(value) Dropdown:Refresh(value) end, [2] = function(value) Dropdown:Set(value) end }
                                end
                        
                                return Dropdown
                            end
                        
                            function Dropdown:Refresh(tbl)
                                for _,v in pairs(Dropdown.FValues) do
                                    v.Objects.Name:Destroy()
                                    v = nil
                                end
                        
                                Inline.Size = UDim2New(0, 229, 0, 0)
                                table.clear(Dropdown.FValues)
                        
                                if DropdownOptions.Multi then
                                    table.clear(Dropdown.FValue)
                                    Count = 0
                        
                                    for _,v in pairs(tbl) do
                                        Dropdown:CreateValue(v)
                                    end
                        
                                    Dropdown:Display()
                        
                                    pcall(DropdownOptions.Callback, Dropdown.FValue)
                                    UserInterface.Flags[DropdownOptions.Flag] = Dropdown.FValue
                                    UserInterface.Flags[DropdownOptions.Flag .. "f"] = { [1] = function(value) Dropdown:Refresh(value) end, [2] = function(value) Dropdown:Set(value) end }
                                else
                                    Count = 0
                        
                                    for _,v in pairs(tbl) do
                                        Dropdown:CreateValue(v)
                                    end
                        
                                    Dropdown.FValue = nil
                        
                                    Dropdown:Update()
                                    Dropdown:Display()
                        
                                    pcall(DropdownOptions.Callback, Dropdown.FValue)
                                    UserInterface.Flags[DropdownOptions.Flag] = Dropdown.FValue
                                    UserInterface.Flags[DropdownOptions.Flag .. "f"] = { [1] = function(value) Dropdown:Refresh(value) end, [2] = function(value) Dropdown:Set(value) end }
                                end
                        
                                for _, v in pairs(tbl) do
                                    Dropdown:CreateValue(v)
                                end
                            
                                Dropdown:Set(DropdownOptions.Default)
                        
                                return Dropdown
                            end
                        
                            for _, v in pairs(DropdownOptions.Content) do
                                Dropdown:CreateValue(v)
                            end
                        
                            Dropdown:Set(DropdownOptions.Default)
                        
                            OpenButton.MouseButton1Click:Connect(function ()
                                if UserInterface.Popup and UserInterface.Popup.ID ~= DropdownHolder.Name then
                                    UserInterface:RemovePopups()
                                end
                                if Inline.Visible then
                                    contentAnimations:Close()
                                    Inline.ZIndex = 3
                                else
                                    UserInterface:NewPopup({ Remove = contentAnimations.Close, ID = DropdownHolder.Name })
                                    Inline.ZIndex = 4
                                    contentAnimations:Open()
                                end
                            end)
                        
                            UserInterface.ConfigFlags[DropdownOptions.Flag] = function(state) Dropdown:Set(state) end
                        
                            increaseYSize(40)
                            return DropdownOptions, Dropdown
                        end
                    end
                    do -- src/Lua/Interface/Components/Keybind.lua
                        function Options:Keybind(Configuration, toggle)
                            
                            local KeybindOptions = {
                                Title = Configuration.title or "",
                                Mode = Configuration.mode or "Toggle",
                                Key = Configuration.key or "",
                                Callback = Configuration.callback or function() end,
                                KeybindsList = Configuration.keybindlist or false,
                                KeybindListName = Configuration.keybindname or self.Title,
                                Flag = UserInterface:GetNextFlag()
                            }
                        
                            local Keybind = {
                                FMode = KeybindOptions.Mode,
                                FKey = KeybindOptions.Key,
                                Toggled = false,
                                Picking = false,
                                Modes = {},
                            }
                        
                            local KeybindHolder = InstanceNew("Frame")
                            local KeybindButton = InstanceNew("TextButton")
                        
                            KeybindHolder.Name = tostring(math.random(1000, 16384))
                            KeybindHolder.Parent = toggle == nil and SectionColumnComponents or toggle
                            KeybindHolder.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            KeybindHolder.BackgroundTransparency = 1.000
                            KeybindHolder.BorderColor3 = Color3FromRGB(0, 0, 0)
                            KeybindHolder.BorderSizePixel = 0
                            KeybindHolder.Size = UDim2New(0, 229, 0, 14)
                            
                            if toggle == nil then
                                local KeybindTitle = InstanceNew("TextLabel")
                                KeybindTitle.Name = "KeybindTitle"
                                KeybindTitle.Parent = KeybindHolder
                                KeybindTitle.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                                KeybindTitle.BackgroundTransparency = 1.000
                                KeybindTitle.BorderColor3 = Color3FromRGB(0, 0, 0)
                                KeybindTitle.BorderSizePixel = 0
                                KeybindTitle.Size = UDim2New(0, 161, 0, 14)
                                KeybindTitle.Font = Enum.Font.SourceSans
                                KeybindTitle.Text = KeybindOptions.Title
                                KeybindTitle.TextColor3 = Color3FromRGB(255, 255, 255)
                                KeybindTitle.TextSize = 14.000
                                KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left
                            end
                        
                            KeybindButton.Name = "KeybindButton"
                            KeybindButton.Parent = KeybindHolder
                            KeybindButton.BackgroundColor3 = Color3FromRGB(21, 21, 21)
                            KeybindButton.BorderColor3 = Color3FromRGB(34, 34, 34)
                            KeybindButton.Position = UDim2New(0.703056753, 0, 0, 0)
                            KeybindButton.Size = UDim2New(0, 68, 0, 14)
                            KeybindButton.Font = Enum.Font.SourceSans
                            KeybindButton.Text = "key : NONE"
                            KeybindButton.TextColor3 = Color3FromRGB(255, 255, 255)
                            KeybindButton.TextSize = 14.000
                            KeybindButton.ZIndex = 2
                            KeybindButton.AutoButtonColor = false
                        
                            local KeybindInline = InstanceNew("Frame")
                            local KeybindContent = InstanceNew("Frame")
                            local KBContent = InstanceNew("UIListLayout")
                        
                            KeybindInline.Name = "KeybindInline"
                            KeybindInline.Parent = KeybindHolder
                            KeybindInline.BackgroundColor3 = Color3FromRGB(170, 170, 255)
                            KeybindInline.BackgroundTransparency = 1.000
                            KeybindInline.BorderColor3 = Color3FromRGB(0, 0, 0)
                            KeybindInline.BorderSizePixel = 0
                            KeybindInline.Position = UDim2New(0.943231463, 0, 0, 0)
                            KeybindInline.Size = UDim2New(0, 13, 0, 13)
                            KeybindInline.Visible = false
                            
                            KeybindContent.Name = "KeybindContent"
                            KeybindContent.Parent = KeybindInline
                            KeybindContent.BackgroundColor3 = Color3FromRGB(21, 21, 21)
                            KeybindContent.BorderColor3 = Color3FromRGB(34, 34, 34)
                            KeybindContent.Position = UDim2New(-4.23076916, 0, 1.2, 0)
                            KeybindContent.Size = UDim2New(0, 68, 0, 0)
                            KeybindContent.ZIndex = 3
                        
                            KBContent.Name = "KBContent"
                            KBContent.Parent = KeybindContent
                            KBContent.SortOrder = Enum.SortOrder.LayoutOrder
                        
                            local contentAnimations = {
                                Open = function ( self )
                                    KeybindContent.Visible = true
                                    KeybindInline.Visible = true
                        
                                    self:FadeIn()
                                end,
                                FadeIn = function ()
                                    for _, object in pairs( KeybindContent:GetDescendants() ) do
                                        if object:IsA("Frame") then
                                            tweenService:Create(object, TweenInfo.new(0.1), { BackgroundTransparency = 0 }):Play()
                                        elseif object:IsA("TextButton") then
                                            tweenService:Create(object, TweenInfo.new(0.1), { TextTransparency = 0 }):Play()
                                        end
                                    end
                                end,
                                FadeOut = function ()
                                    for _, object in pairs( KeybindContent:GetDescendants() ) do
                                        if object:IsA("Frame") then
                                            tweenService:Create(object, TweenInfo.new(0.1), { BackgroundTransparency = 1 }):Play()
                                        elseif object:IsA("TextButton") then
                                            tweenService:Create(object, TweenInfo.new(0.1), { TextTransparency = 1 }):Play()
                                        end
                                    end
                                end
                            }
                            
                            function contentAnimations:Close()
                                contentAnimations:FadeOut()
                        
                                TaskWait(0.05)
                        
                                KeybindContent.Visible = false
                                KeybindInline.Visible = false
                            end
                        
                            function Keybind:UpdateList()
                                if UserInterface.KeybindList and KeybindOptions.KeybindsList then
                                    UserInterface.KeybindList:Add(KeybindOptions.KeybindListName, Keybind.FMode)
                                    UserInterface.KeybindList:SetVisibility(KeybindOptions.KeybindListName, KeybindOptions:GetState())
                                    UserInterface.KeybindList:SetMode(KeybindOptions.KeybindListName, Keybind.FMode)
                                end
                            end
                        
                            function Keybind:Value(info)
                                if info then
                                    if info[1] then
                                        local Key = info[1]
                                        KeybindButton.Text = "key : " .. (Key == "NONE" or Key == "" and "NONE" or Key)
                                        Keybind.FKey = Key
                                    else
                                        KeybindButton.Text = "key : NONE"
                                    end
                        
                                    if info[2] then
                                        Keybind.Modes[info[2]]:Click(info[2] == "Toggle" and true or false)
                                    end
                        
                                    Keybind:UpdateList()
                                end
                        
                                return Keybind
                            end
                        
                            function KeybindOptions:GetState()
                                if Keybind.FMode == "Always" then
                                    return true
                                elseif Keybind.FMode == "Hold" then
                                    if Keybind.FKey == "NONE" then
                                        return false
                                    end
                        
                                    return Keybind.Toggled
                                else
                                    if Keybind.FKey == "NONE" then
                                        return false
                                    end
                        
                                    return Keybind.Toggled
                                end
                            end
                        
                            for _, v in pairs({ "Toggle", "Hold", "Always" }) do
                                local Button = {}
                                local KB_Button = InstanceNew("TextButton")
                                KB_Button.Name = "KB_Button"
                                KB_Button.Parent = KeybindContent
                                KB_Button.BackgroundColor3 = Color3FromRGB(21, 21, 21)
                                KB_Button.BackgroundTransparency = 0
                                KB_Button.BorderColor3 = Color3FromRGB(34, 34, 34)
                                KB_Button.BorderSizePixel = 0
                                KB_Button.Position = UDim2New(0, 0, 0.0416666679, 0)
                                KB_Button.Size = UDim2New(0, 68, 0, 14)
                                KB_Button.ZIndex = 3
                                KB_Button.Font = Enum.Font.SourceSans
                                KB_Button.Text = tostring(v)
                                KB_Button.TextColor3 = Color3FromRGB(129, 129, 127)
                                KB_Button.TextSize = 14.000
                                
                                local TextBoundY = KB_Button.TextBounds.Y
                                KeybindContent.Size += UDim2New(0, 0, 0, TextBoundY)
                        
                                function Button:Click(igr)
                                    for _,v in pairs(Keybind.Modes) do
                                        v:Unclick()
                                    end
                        
                                    Keybind.FMode = v
                                    KeybindInline.Visible = false
                                    Keybind:UpdateList()
                        
                                    KB_Button.TextColor3 = Color3FromRGB(168, 157, 159)
                        
                                    if not igr then
                                        pcall(KeybindOptions.Callback, KeybindOptions:GetState())
                                    end
                                end
                        
                                function Button:Unclick()
                                    KB_Button.TextColor3 = Color3FromRGB(129, 129, 127)
                                end
                                    
                                if v == Keybind.FMode then
                                    Button:Click()
                                end
                        
                                KB_Button.MouseButton1Down:Connect(Button.Click)
                        
                                theme_event.Event:Connect(function ()
                                    if v == Keybind.FMode then
                                        KB_Button.TextColor3 = theme.accent
                                    end
                                end)
                                
                                Keybind.Modes[v] = Button
                            end
                        
                            KeybindButton.InputBegan:Connect(function (input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    Keybind.Picking = true
                        
                                    KeybindButton.Text = "..."
                        
                                    TaskWait(0.02)
                        
                                    local Event; Event = inputService.InputBegan:Connect(function (input)
                                        local Key
                                        local KeyName = input.KeyCode.Name == "Escape" and "NONE" or Keys[input.KeyCode] or Keys[input.UserInputType] or input.KeyCode.Name
                        
                                        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == "Escape" then
                                            Keybind.FKey = "NONE"
                                        elseif input.UserInputType == Enum.UserInputType.Keyboard then
                                            Keybind.FKey = input.KeyCode.Name
                                        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                                            Keybind.FKey = "MB1"
                                        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                                            Keybind.FKey = "MB2"
                                        end
                        
                                        Break = true
                                        Keybind.Picking = false
                        
                                        KeybindButton.Text = "key : " .. KeyName
                        
                                        pcall(KeybindOptions.Callback, KeybindOptions:GetState())
                                        UserInterface.Flags[KeybindOptions.Flag] = KeybindOptions:GetState()
                                        UserInterface.Flags[KeybindOptions.Flag .. "_info"] = {Keybind.FKey, Keybind.FMode}
                                        Keybind:UpdateList()
                        
                                        Event:Disconnect()
                                    end)
                                end
                                
                                if input.UserInputType == Enum.UserInputType.MouseButton2 then
                                    if UserInterface.Popup and UserInterface.Popup.ID ~= KeybindHolder.Name then
                                        UserInterface:RemovePopups()
                                    end
                                    if KeybindInline.Visible then
                                        contentAnimations:Close()
                                    else
                                        UserInterface:NewPopup({ Remove = contentAnimations.Close, ID = KeybindHolder.Name })
                                        contentAnimations:Open()
                                    end
                                end
                            end)
                        
                            inputService.InputBegan:Connect(function ( input, gameprocessing )
                                if gameprocessing then return end
                        
                                -- mousebutton niggassss
                                local mb = Keybind.FKey == "MB2" and "MouseButton2" or Keybind.FKey == "MB1" and "MouseButton1"
                                if input.KeyCode.Name == Keybind.FKey or input.UserInputType.Name == mb then
                                    if Keybind.FMode == 'Toggle' then
                                        Keybind.Toggled = not Keybind.Toggled
                                    elseif Keybind.FMode == 'Hold' then
                                        Keybind.Toggled = true
                        
                                        local c; c = inputService.InputEnded:Connect(function ( input )
                                            if input.KeyCode.Name == Keybind.FKey or input.UserInputType.Name == mb then
                                                c:Disconnect()
                                                Keybind.Toggled = false
                                                pcall(KeybindOptions.Callback, KeybindOptions:GetState())
                                                Keybind:UpdateList()
                                            end
                                        end)
                                    end
                                    
                                    pcall(KeybindOptions.Callback, KeybindOptions:GetState())
                                    UserInterface.Flags[KeybindOptions.Flag] = KeybindOptions:GetState()
                                    UserInterface.Flags[KeybindOptions.Flag .. "_info"] = {Keybind.FKey, Keybind.FMode}
                                    Keybind:UpdateList()
                                end
                            end)
                        
                            if Keybind.FKey ~= "" then
                                Keybind:Value({ Keybind.FKey, Keybind.FMode })
                            end
                        
                            increaseYSize(14)
                        
                            UserInterface.Flags[KeybindOptions.Flag] = KeybindOptions:GetState()
                            UserInterface.Flags[KeybindOptions.Flag .. "_info"] = {Keybind.FKey, Keybind.FMode}
                        
                            UserInterface.ConfigFlags[KeybindOptions.Flag .. "_info"] = function(info) Keybind:Value(info) end
                        
                            return KeybindOptions
                        end
                    end
                    do -- src/Lua/Interface/Components/Label.lua
                        function Options:Label(text, richtext)
                            local LabelOptions = {}
                        
                            local RichTextEnabled = richtext ~= nil and richtext == true and true or false
                        
                            local Label = InstanceNew("TextLabel")
                            Label.Name = "Label"
                            Label.Parent = SectionColumnComponents
                            Label.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            Label.BackgroundTransparency = 1.000
                            Label.BorderColor3 = Color3FromRGB(0, 0, 0)
                            Label.BorderSizePixel = 0
                            Label.Size = UDim2New(0, 229, 0, 14)
                            Label.Font = Enum.Font.SourceSans
                            Label.Text = text
                            Label.TextColor3 = Color3FromRGB(255, 255, 255)
                            Label.TextSize = 14.000
                            Label.TextXAlignment = Enum.TextXAlignment.Left
                            Label.RichText = RichTextEnabled
                            Label.TextTruncate = "AtEnd"
                        
                            function LabelOptions:ChangeText(newtext)
                                if not type(newtext) == "string" then return end
                                local new = tostring(newtext)
                                Label.Text = new
                            end
                            
                            increaseYSize(14)
                        
                            return LabelOptions
                        end
                    end
                    do -- src/Lua/Interface/Components/Playerlist.lua
                        function Options:PlayerList()
                            local PlayerlistHolder = InstanceNew("Frame")
                            local SearchBar = InstanceNew("TextBox")
                            local SearchTitle = InstanceNew("TextLabel")
                            local Players = InstanceNew("ScrollingFrame")
                            local ListLayout = InstanceNew("UIListLayout")
                        
                            PlayerlistHolder.Name = "PlayerlistHolder"
                            PlayerlistHolder.Parent = SectionColumnComponents
                            PlayerlistHolder.Size = UDim2New(1, 0, 0, 316)
                            PlayerlistHolder.BorderColor3 = Color3FromRGB(0, 0, 0)
                            PlayerlistHolder.BackgroundTransparency = 1
                            PlayerlistHolder.Position = UDim2New(0, 0, -1.17375305e-06, 0)
                            PlayerlistHolder.BorderSizePixel = 0
                            PlayerlistHolder.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            
                            SearchBar.Name = "SearchBar"
                            SearchBar.Parent = PlayerlistHolder
                            SearchBar.Size = UDim2New(0, 160, 0, 17)
                            SearchBar.BorderColor3 = Color3FromRGB(31, 31, 31)
                            SearchBar.BackgroundColor3 = Color3FromRGB(21, 21, 21)
                            SearchBar.TextSize = 14
                            SearchBar.TextColor3 = Color3FromRGB(255, 255, 255)
                            SearchBar.Text = ""
                            SearchBar.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            SearchBar.TextXAlignment = Enum.TextXAlignment.Left
                            
                            SearchTitle.Name = "SearchTitle"
                            SearchTitle.Parent = SearchBar
                            SearchTitle.Size = UDim2New(0, 63, 0, 17)
                            SearchTitle.BorderColor3 = Color3FromRGB(0, 0, 0)
                            SearchTitle.BackgroundTransparency = 1
                            SearchTitle.Position = UDim2New(1.03750002, 0, 0, 0)
                            SearchTitle.BorderSizePixel = 0
                            SearchTitle.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            SearchTitle.TextColor3 = Color3FromRGB(255, 255, 255)
                            SearchTitle.Text = "search"
                            SearchTitle.TextXAlignment = Enum.TextXAlignment.Left
                            SearchTitle.TextSize = 14
                            SearchTitle.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            
                            Players.Name = "Players"
                            Players.Parent = PlayerlistHolder
                            Players.Active = true
                            Players.Size = UDim2New(0, 229, 0, 300)
                            Players.BorderColor3 = Color3FromRGB(0, 0, 0)
                            Players.BackgroundTransparency = 1
                            Players.Position = UDim2New(0, 0, 0.075000003, 0)
                            Players.BorderSizePixel = 0
                            Players.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            Players.ScrollBarImageColor3 = Color3FromRGB(0, 255, 255)
                            Players.AutomaticCanvasSize = Enum.AutomaticSize.Y
                            Players.ScrollBarThickness = 5
                            
                            ListLayout.Name = "ListLayout"
                            ListLayout.Parent = Players
                            ListLayout.Padding = UDim.new(0, 7)
                        
                            ListLayout.Changed:Connect(function ()
                                Players.CanvasSize = UDim2New(0, 0, 0, 8 + ListLayout.AbsoluteContentSize.Y)
                            end)
                        
                            local PlayerOptions = {
                                CurrentPlayer = ""
                            }
                        
                            function PlayerOptions:Clear()
                                for _, child in ipairs(Players:GetChildren()) do
                                    if child:IsA("Frame") then
                                        child:Destroy()
                                    end
                                end
                            end
                        
                            function PlayerOptions:Add(player, player_name)
                                local PlayerFrame = InstanceNew("Frame")
                                local PlayerImage = InstanceNew("ImageLabel")
                                local PlayerName = InstanceNew("TextButton")
                        
                                local DisplayName
                                if player.Character then
                                    local hum = player.Character:FindFirstChild("Humanoid")
                                    if hum then
                                        DisplayName = player.Character.Humanoid.DisplayName
                                    else
                                        DisplayName = player_name
                                    end
                                else
                                    DisplayName = player_name
                                end
                        
                                PlayerFrame.Name = player_name .. " " .. DisplayName
                                PlayerFrame.Parent = Players
                                PlayerFrame.Size = UDim2New(1, 0, 0, 19)
                                PlayerFrame.BorderColor3 = Color3FromRGB(0, 0, 0)
                                PlayerFrame.BackgroundTransparency = 1
                                PlayerFrame.BorderSizePixel = 0
                                PlayerFrame.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                                
                                PlayerImage.Name = "PlayerImage"
                                PlayerImage.Parent = PlayerFrame
                                PlayerImage.Size = UDim2New(0, 19, 0, 19)
                                PlayerImage.BorderColor3 = Color3FromRGB(0, 0, 0)
                                PlayerImage.BorderSizePixel = 0
                                PlayerImage.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                                PlayerImage.BackgroundTransparency = 1
                                PlayerImage.Image = "https://www.roblox.com/bust-thumbnail/image?userId=" .. player.UserId .. "&width=19&height=19&format=png"
                                
                                PlayerName.Name = "PlayerName"
                                PlayerName.Parent = PlayerImage
                                PlayerName.Size = UDim2New(0, 205, 0, 19)
                                PlayerName.BorderColor3 = Color3FromRGB(0, 0, 0)
                                PlayerName.BackgroundTransparency = 1
                                PlayerName.Position = UDim2New(1.26315784, 0, 0, 0)
                                PlayerName.BorderSizePixel = 0
                                PlayerName.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                                PlayerName.TextColor3 = Color3FromRGB(129, 129, 127)
                                PlayerName.Text = string.format("%s (@%s)", player_name, DisplayName)
                                PlayerName.TextXAlignment = Enum.TextXAlignment.Left
                                PlayerName.TextSize = 14
                                PlayerName.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                                PlayerName.TextTruncate = "AtEnd"
                        
                                local self_conn = nil
                                local function fucking_click()
                                    if PlayerOptions.CurrentPlayer == player_name then
                                        PlayerName.TextColor3 = Color3FromRGB(129, 129, 127)
                                        PlayerOptions.CurrentPlayer = nil
                        
                                        if self_conn then
                                            self_conn:Disconnect(); self_conn = nil
                                        end
                                    else
                                        for i, v in ipairs(Players:GetDescendants()) do
                                            if v.Name == "PlayerName" then
                                                v.TextColor3 = Color3FromRGB(129, 129, 127)
                                            end
                                        end
                                        PlayerName.TextColor3 = theme.accent
                                        PlayerOptions.CurrentPlayer = player_name
                        
                                        if not self_conn then
                                            self_conn = theme_event.Event:Connect(function ()
                                                if PlayerOptions.CurrentPlayer == player_name then
                                                    PlayerName.TextColor3 = theme.accent
                                                end
                                            end)
                                        end
                                    end
                                end
                        
                                PlayerName.MouseButton1Click:Connect(fucking_click)
                            end
                        
                            function PlayerOptions:Refresh()
                                PlayerOptions:Clear()
                        
                                for _, player in ipairs(playerService:GetPlayers()) do
                                    if player == LocalPlayer then continue end
                        
                                    local name = player.Name
                                    PlayerOptions:Add(player, name)
                                end
                            end
                        
                            function PlayerOptions:GetPlayers()
                                return Players:GetChildren()
                            end
                        
                            function PlayerOptions:Search()
                                local search = string.lower(SearchBar.Text)
                                for i, v in pairs(Players:GetChildren()) do
                                    if v:IsA("Frame") then
                                        if search ~= "" then
                                            local commanditemlist = string.lower(v.Name)
                                            if string.find(commanditemlist, search) then
                                                v.Visible = true
                                            else
                                                v.Visible = false
                                            end
                                        else
                                            v.Visible = true
                                        end
                                    end
                                end
                            end
                        
                            function PlayerOptions:GetCurrentPlayer()
                                return PlayerOptions.CurrentPlayer
                            end
                        
                            function PlayerOptions:Init()
                                -- init
                                PlayerOptions:Refresh()
                        
                                SearchBar.Changed:Connect(PlayerOptions.Search)
                                playerService.PlayerAdded:Connect(PlayerOptions.Refresh)
                                playerService.PlayerRemoving:Connect(PlayerOptions.Refresh)
                            end
                        
                            PlayerOptions:Init()
                        
                            increaseYSize(310)
                            return PlayerOptions
                        end
                    end
                    do -- src/Lua/Interface/Components/Slider.lua
                        function Options:Slider(Configuration)
                            local SliderOptions = {
                                 Title = Configuration.title or "slider",
                                 Min = Configuration.min or 1,
                                 Max = Configuration.max or 10,
                                 Float = Configuration.float or 1,
                                 Default = Configuration.default or 0,
                                 Value = 0,
                                 Callback = Configuration.callback or function() end,
                                 Sliding = false,
                                 Suffix = Configuration.suffix or "",
                                 Flag = UserInterface:GetNextFlag(),
                            }
                            SliderOptions.MinText = Configuration.mintext or tostring(SliderOptions.Min)
                            SliderOptions.MaxText = Configuration.maxtext or tostring(SliderOptions.Max)
                        
                            local Slider = InstanceNew("Frame")
                            local SliderInline = InstanceNew("Frame")
                            local InlineCorner = InstanceNew("UICorner")
                            local SliderBackground = InstanceNew("Frame")
                            local BackgroundCorner = InstanceNew("UICorner")
                            local SliderFill = InstanceNew("Frame")
                            local FillCorner = InstanceNew("UICorner")
                            local SliderDrag = InstanceNew("Frame")
                            local DragCorner = InstanceNew("UICorner")
                            local SliderName = InstanceNew("TextLabel")
                            local SliderValue = InstanceNew("TextLabel")
                        
                            Slider.Name = "Slider"
                            Slider.Parent = SectionColumnComponents
                            Slider.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            Slider.BackgroundTransparency = 1.000
                            Slider.BorderColor3 = Color3FromRGB(0, 0, 0)
                            Slider.BorderSizePixel = 0
                            Slider.Size = UDim2New(0, 229, 0, 30)
                        
                            SliderInline.Name = "SliderInline"
                            SliderInline.Parent = Slider
                            SliderInline.BackgroundColor3 = Color3FromRGB(21, 21, 21)
                            SliderInline.BorderColor3 = Color3FromRGB(0, 0, 0)
                            SliderInline.BorderSizePixel = 0
                            SliderInline.Position = UDim2New(0, 0, 0.766666651, 0)
                            SliderInline.Size = UDim2New(0, 160, 0, 7)
                            
                            InlineCorner.CornerRadius = UDim.new(0, 2)
                            InlineCorner.Name = "InlineCorner"
                            InlineCorner.Parent = SliderInline
                            
                            SliderBackground.Name = "SliderBackground"
                            SliderBackground.Parent = SliderInline
                            SliderBackground.BackgroundColor3 = Color3FromRGB(21, 21, 21)
                            SliderBackground.BorderColor3 = Color3FromRGB(0, 0, 0)
                            SliderBackground.BorderSizePixel = 0
                            SliderBackground.Position = UDim2New(0, 0, -0.00999999978, 0)
                            SliderBackground.Size = UDim2New(0, 160, 1, 0)
                            
                            BackgroundCorner.CornerRadius = UDim.new(0, 2)
                            BackgroundCorner.Name = "BackgroundCorner"
                            BackgroundCorner.Parent = SliderBackground
                            
                            SliderFill.Name = "SliderFill"
                            SliderFill.Parent = SliderBackground
                            SliderFill.BackgroundColor3 = Color3FromRGB(172, 153, 159)
                            SliderFill.BorderColor3 = Color3FromRGB(0, 0, 0)
                            SliderFill.BorderSizePixel = 0
                            SliderFill.Position = UDim2New(0, 0, 0, 0)
                            SliderFill.Size = UDim2New(0, 0, 1, 0)
                            
                            FillCorner.CornerRadius = UDim.new(0, 2)
                            FillCorner.Name = "FillCorner"
                            FillCorner.Parent = SliderFill
                            
                            SliderDrag.Name = "SliderDrag"
                            SliderDrag.Parent = SliderBackground
                            SliderDrag.BackgroundColor3 = Color3FromRGB(21, 21, 21)
                            SliderDrag.BackgroundTransparency = 1.000
                            SliderDrag.BorderColor3 = Color3FromRGB(0, 0, 0)
                            SliderDrag.BorderSizePixel = 0
                            SliderDrag.Position = UDim2New(0, 0, -0.00999999978, 0)
                            SliderDrag.Size = UDim2New(1, 0, 1, 0)
                            
                            DragCorner.CornerRadius = UDim.new(0, 2)
                            DragCorner.Name = "DragCorner"
                            DragCorner.Parent = SliderDrag
                        
                            local X = UIModule:GetTextBoundary(SliderOptions.Title, Enum.Font.SourceSans, 14)
                            SliderName.Name = "SliderName"
                            SliderName.Parent = Slider
                            SliderName.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            SliderName.BackgroundTransparency = 1.000
                            SliderName.BorderColor3 = Color3FromRGB(0, 0, 0)
                            SliderName.BorderSizePixel = 0
                            SliderName.Size = UDim2New(0, 28, 0, 20)
                            SliderName.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]])
                            SliderName.Text = SliderOptions.Title
                            SliderName.TextColor3 = Color3FromRGB(255, 255, 255)
                            SliderName.TextSize = 14.000
                            SliderName.TextXAlignment = Enum.TextXAlignment.Left
                        
                            SliderValue.Name = "SliderValue"
                            SliderValue.Parent = Slider
                            SliderValue.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                            SliderValue.BackgroundTransparency = 1.000
                            SliderValue.BorderColor3 = Color3FromRGB(0, 0, 0)
                            SliderValue.BorderSizePixel = 0
                            SliderValue.Position = UDim2New(0, X + 3, 0, 0)
                            SliderValue.Size = UDim2New(0, SliderValue.TextBounds.X, 0, 20)
                            SliderValue.Font = Enum.Font.SourceSans
                            SliderValue.Text = SliderOptions.Value .. SliderOptions.Suffix
                            SliderValue.TextColor3 = Color3FromRGB(124, 124, 124)
                            SliderValue.TextSize = 14.000
                            SliderValue.TextXAlignment = Enum.TextXAlignment.Left
                        
                            local INLINESTROKE = InstanceNew("UIStroke", SliderInline)
                            INLINESTROKE["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
                            INLINESTROKE["Name"] = [[INLINESTROKE]]
                            INLINESTROKE["Color"] = Color3FromRGB(32, 32, 32)
                        
                            local SliderBackgroundStroke = InstanceNew("UIStroke", SliderBackground)
                            SliderBackgroundStroke["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
                            SliderBackgroundStroke["Name"] = [[SliderBackgroundStroke]]
                            SliderBackgroundStroke["Color"] = Color3FromRGB(32, 32, 32)
                        
                            local SliderFillStroke = InstanceNew("UIStroke", SliderFill)
                            SliderFillStroke["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
                            SliderFillStroke["Name"] = [[SliderFillStroke]]
                            SliderFillStroke["Color"] = Color3FromRGB(172, 153, 159)
                            SliderFillStroke["Transparency"] = 0.5
                        
                            theme_event.Event:Connect(function ()
                                SliderFill.BackgroundColor3 = theme.accent
                                SliderFillStroke.Color = theme.accent
                            end)
                            
                            local function Round(number, float)
                                return float * math.round(number / float)
                            end
                        
                            function SliderOptions:Set(value)
                                value = math.clamp(Round(value, SliderOptions.Float), SliderOptions.Min, SliderOptions.Max)
                        
                                local Size = (value - SliderOptions.Min) / (SliderOptions.Max - SliderOptions.Min)
                        
                                SliderOptions.Value = value
                        
                                tweenService:Create(SliderFill, TweenInfo.new(0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2New(Size, 0, 1, 0)}):Play()
                        
                                SliderOptions.Callback(value)
                                UserInterface.Flags[SliderOptions.Flag] = SliderOptions.Value
                        
                                local text = SliderOptions.Value == SliderOptions.Min and SliderOptions.MinText or SliderOptions.Value == SliderOptions.Max and SliderOptions.MaxText or string.format("%.14g%s", SliderOptions.Value, SliderOptions.Suffix)
                                SliderValue.Text = text
                            end
                        
                            function SliderOptions:Slide(input)
                                local Size = (input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X
                                local Value = math.clamp((SliderOptions.Max - SliderOptions.Min) * Size + SliderOptions.Min, SliderOptions.Min, SliderOptions.Max)
                        
                                self:Set(Value)
                            end
                        
                            SliderOptions:Set(SliderOptions.Default)
                        
                            SliderDrag.MouseEnter:Connect(function ()
                                tweenService:Create(SliderBackgroundStroke, TweenInfo.new(0.2), {Color = Color3FromRGB(255,255,255) }):Play()
                            end)
                        
                            SliderDrag.MouseLeave:Connect(function ()
                                tweenService:Create(SliderBackgroundStroke, TweenInfo.new(0.2), {Color = Color3FromRGB(32, 32, 32) }):Play()
                            end)
                        
                            SliderDrag.InputBegan:Connect(function (input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    SliderOptions.Sliding = true
                                    SliderOptions:Slide(input)
                                end
                            end)
                        
                            SliderDrag.InputEnded:Connect(function (input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    SliderOptions.Sliding = false
                                    SliderOptions:Slide(input)
                                end
                            end)
                        
                            SliderDrag.InputChanged:Connect(function (input)
                                if input.UserInputType == Enum.UserInputType.MouseMovement and SliderOptions.Sliding then
                                    SliderOptions:Slide(input)
                                end
                            end)
                        
                            UserInterface.ConfigFlags[SliderOptions.Flag] = function(value) SliderOptions:Set(value) end
                        
                            increaseYSize(30)
                            return SliderOptions
                        end
                    end
                    do -- src/Lua/Interface/Components/Textbox.lua
                        function Options:TextBox(Configuration)
                            local TextBoxOptions = {
                                Title = Configuration.title or "textbox",
                                Default = Configuration.default or "",
                                Placeholder = Configuration.placeholder or "",
                                ClearTextOnFocus = Configuration.cleartextonfocus or Configuration.ctf or true,
                                Callback = Configuration.callback or function() end,
                                Text = "",
                                Flag = UserInterface:GetNextFlag()
                            }
                        
                            if TextBoxOptions.Title ~= "NO TITLE" then
                                self:Label(TextBoxOptions.Title)
                            end
                        
                            local TextBox = InstanceNew("TextBox")
                            local TextboxCorner = InstanceNew("UICorner")
                            TextBox.Parent = SectionColumnComponents
                            TextBox.BackgroundColor3 = Color3FromRGB(23, 23, 23)
                            TextBox.BorderColor3 = Color3FromRGB(0, 0, 0)
                            TextBox.BorderSizePixel = 0
                            TextBox.Size = UDim2New(0, 229, 0, 14)
                            TextBox.Font = Enum.Font.SourceSans
                            TextBox.PlaceholderText = TextBoxOptions.Placeholder
                            TextBox.Text = ""
                            TextBox.TextColor3 = Color3FromRGB(255, 255, 255)
                            TextBox.TextSize = 14.000
                            TextBox.TextXAlignment = Enum.TextXAlignment.Left
                            TextBox.TextTruncate = "AtEnd"
                            TextBox.ClearTextOnFocus = TextBoxOptions.ClearTextOnFocus
                        
                            TextboxCorner.CornerRadius = UDim.new(0, 4)
                            TextboxCorner.Name = "TextboxCorner"
                            TextboxCorner.Parent = TextBox
                            
                            local TextBoxStroke = InstanceNew("UIStroke", TextBox)
                            TextBoxStroke["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
                            TextBoxStroke["Name"] = [[TextBoxStroke]]
                            TextBoxStroke["Color"] = Color3FromRGB(37, 37, 37)
                        
                            function TextBoxOptions:Set(Text)
                                Text = Text or ""
                                
                                TextBox.Text = Text
                                TextBoxOptions.Text = TextBox.Text
                                UserInterface.Flags[TextBoxOptions.Flag] = TextBoxOptions.Text
                                UserInterface.Flags[TextBoxOptions.Flag .. "f"] = function(value) TextBoxOptions:Set(value) end
                                pcall(TextBoxOptions.Callback, TextBoxOptions.Text)
                            end
                        
                            local function OnFocusLost()
                                TextBoxOptions.Text = TextBox.Text
                                UserInterface.Flags[TextBoxOptions.Flag] = TextBoxOptions.Text
                                UserInterface.Flags[TextBoxOptions.Flag .. "f"] = function(value) TextBoxOptions:Set(value) end
                                pcall(TextBoxOptions.Callback, TextBoxOptions.Text)
                            end
                        
                            TextBox.FocusLost:Connect(OnFocusLost)
                        
                            increaseYSize(14)
                            UserInterface.ConfigFlags[TextBoxOptions.Flag] = function(text) TextBoxOptions:Set(text) end
                        
                            return TextBoxOptions
                        end
                    end
                    do -- src/Lua/Interface/Components/Toggle.lua
                        function Options:Toggle(Configuration)
                            local ToggleOptions = { 
                                title = Configuration.title or "toggle",
                                default = Configuration.default or false,
                                state = false,
                                callback = Configuration.callback or function() end,
                                Flag = UserInterface:GetNextFlag()
                            }
                            
                            UI["19"] = InstanceNew("TextButton", SectionColumnComponents)
                            UI["19"]["BorderSizePixel"] = 0
                            UI["19"]["TextTransparency"] = 1
                            UI["19"]["TextSize"] = 14
                            UI["19"]["TextColor3"] = Color3FromRGB(255, 255, 255)
                            UI["19"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
                            UI["19"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
                            UI["19"]["Size"] = UDim2New(0, 229, 0, 15)
                            UI["19"]["BackgroundTransparency"] = 1
                            UI["19"]["Name"] = [[ToggleButton]]
                            UI["19"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
                            UI["19"]["Text"] = [[Toggle]]
                        
                            UI["1a"] = InstanceNew("Frame", UI["19"])
                            UI["1a"]["BorderSizePixel"] = 0
                            UI["1a"]["BackgroundColor3"] = Color3FromRGB(20, 20, 17)
                            UI["1a"]["Size"] = UDim2New(0, 13, 0, 13)
                            UI["1a"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
                            UI["1a"]["Position"] = UDim2New(0, 0, 0.077, 0)
                            UI["1a"]["Name"] = [[ToggleStatus]]
                        
                            UI["1b"] = InstanceNew("UICorner", UI["1a"])
                            UI["1b"]["Name"] = [[ToggleStatusCorner]]
                            UI["1b"]["CornerRadius"] = UDim.new(0, 4)
                        
                            UI["1c"] = InstanceNew("UIStroke", UI["1a"])
                            UI["1c"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
                            UI["1c"]["Name"] = [[ToggleUIStroke]]
                            UI["1c"]["Color"] = Color3FromRGB(37, 37, 37)
                        
                            UI["1d"] = InstanceNew("TextLabel", UI["19"])
                            UI["1d"]["TextStrokeTransparency"] = 1
                            UI["1d"]["BorderSizePixel"] = 0
                            UI["1d"]["TextXAlignment"] = Enum.TextXAlignment.Left
                            UI["1d"]["BackgroundColor3"] = Color3FromRGB(255, 255, 255)
                            UI["1d"]["TextSize"] = 14
                            UI["1d"].FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Thin, Enum.FontStyle.Normal)
                            UI["1d"]["TextColor3"] = Color3FromRGB(129, 129, 127)
                            UI["1d"]["BackgroundTransparency"] = 1
                            UI["1d"]["Size"] = UDim2New(1, 0, 0, 13)
                            UI["1d"]["BorderColor3"] = Color3FromRGB(0, 0, 0)
                            UI["1d"]["Text"] = ToggleOptions.title
                            UI["1d"]["Name"] = [[ToggleName]]
                            UI["1d"]["Position"] = UDim2New(0, 18, 0, 0)
                        
                            local Button = UI["19"]
                            local ToggleStatus = UI["1a"]
                            local ToggleName = UI["1d"]
                        
                            local TS_ON = tweenService:Create(ToggleStatus, TweenInfo.new(0.2), {
                                BackgroundColor3 = Color3FromRGB(168, 157, 159)
                            })
                            local TN_ON = tweenService:Create(ToggleName, TweenInfo.new(0.2), {
                                TextColor3 = Color3FromRGB(255, 255, 255)
                            })
                            local TS_OFF = tweenService:Create(ToggleStatus, TweenInfo.new(0.2), {
                                BackgroundColor3 = Color3FromRGB(20, 20, 17)
                            })
                            local TN_OFF = tweenService:Create(ToggleName, TweenInfo.new(0.2), {
                                TextColor3 = Color3FromRGB(129, 129, 127)
                            })
                        
                            theme_event.Event:Connect(function ()
                                TS_ON = tweenService:Create(ToggleStatus, TweenInfo.new(0.2), {
                                    BackgroundColor3 = theme.accent
                                })
                        
                                if ToggleOptions.state then
                                    ToggleStatus.BackgroundColor3 = theme.accent
                                end
                            end)
                        
                            local function ToggleOn()
                                TS_ON:Play();TN_ON:Play()
                            end
                        
                            local function ToggleOff()
                                TS_OFF:Play();TN_OFF:Play()
                            end
                        
                            function ToggleOptions:Set(boolean)
                                ToggleOptions.state = boolean
                                pcall(ToggleOptions.callback, ToggleOptions.state)
                                UserInterface.Flags[ToggleOptions.Flag] = ToggleOptions.state
                                if ToggleOptions.state == true then
                                    ToggleOn()
                                elseif not ToggleOptions.state then
                                    ToggleOff()
                                end
                            end
                        
                            function ToggleOptions:Keybind(Configuration)
                                Options:Keybind(Configuration, Button)
                            end
                        
                            function ToggleOptions:Colorpicker(Configuration)
                                Options:Colorpicker(Configuration, Button)
                            end
                            
                            local function OnClick()
                                ToggleOptions.state = not ToggleOptions.state
                                ToggleOptions:Set(ToggleOptions.state)
                            end
                        
                            Button.MouseButton1Click:Connect(OnClick)
                        
                            ToggleOptions:Set(ToggleOptions.default)
                            increaseYSize(15)     
                        
                            UserInterface.ConfigFlags[ToggleOptions.Flag] = function(state) ToggleOptions:Set(state) end
                        
                            return ToggleOptions
                        end
                    end
                end
    
                return Options
            end
    
            if #Configuration.Tabs > 0 then
                Configuration.Tabs[1]:Select()
            end
    
            table.insert(Configuration.Tabs, #Configuration.Tabs + 1, TabConfiguration)
            return TabConfiguration
        end
    
        local function isMouseInFrame()
            local framePosition = UI["b"].AbsolutePosition
            local frameSize = UI["b"].AbsoluteSize
    
            local player = playerService.LocalPlayer
            local mouse = player:GetMouse()
            
            local mouseX, mouseY = mouse.X, mouse.Y
            
            if mouseX >= framePosition.X and mouseX <= framePosition.X + frameSize.X and
               mouseY >= framePosition.Y and mouseY <= framePosition.Y + frameSize.Y then
                return true
            else
                return false
            end
        end
    
        UI["2"].InputBegan:Connect(function (input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and not isMouseInFrame() then
                dragObject = UI["2"]
                dragging = true
                dragStart = input.Position
                startPos = dragObject.Position
            end
        end)
        UI["2"].InputEnded:Connect(function (input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        UI["2"].InputChanged:Connect(function (input)
            if dragging and input.UserInputType.Name == "MouseMovement" then
                dragInput = input
            end
        end)
    
        inputService.InputChanged:Connect(function (input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                local yPos = (startPos.Y.Offset + delta.Y) < -36 and -36 or startPos.Y.Offset + delta.Y
                dragObject:TweenPosition(UDim2New(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, yPos), "Out", "Quad", .15, true)
            end
        end)
    
        do -- src/Lua/Interface/Others/
            do -- src/Lua/Interface/Others/CloseOpen.lua
                inputService.InputBegan:Connect(function(input, gameproc)
                    if gameproc then return end
                
                    if input.KeyCode == Enum.KeyCode.RightShift then
                        UI["2"].Visible = not UI["2"].Visible
                    end
                end)
            end
            do -- src/Lua/Interface/Others/Config.lua
                function UserInterface:GetConfig()
                    local ConfigTable = {}
                
                    for _, v in pairs(UserInterface.ConfigFlags) do
                        local Value = UserInterface.Flags[_]
                
                        if typeof(Value) == "EnumItem" then
                            ConfigTable[_] = Value
                		elseif typeof(Value) == "Color3" then
                			ConfigTable[_] = { Value:ToHex() }
                        else
                            ConfigTable[_] = Value
                        end
                    end
                
                    return httpService:JSONEncode(ConfigTable)
                end
                
                function UserInterface:LoadConfig(config)
                    local Config = httpService:JSONDecode(config)
                    
                    for _, v in pairs(Config) do
                        local Func = UserInterface.ConfigFlags[_]
                
                        if Func then
                            Func(v)
                        end
                    end
                end
            end
            do -- src/Lua/Interface/Others/KeybindsList.lua
                function UserInterface:KeybindsList()
                    local KeybindsList = InstanceNew("Frame")
                    local KeybindsListCorner = InstanceNew("UICorner")
                    local KeybindsListTitle = InstanceNew("TextLabel")
                    local ObjectsList = InstanceNew("Frame")
                    local ObjectsList_2 = InstanceNew("UIListLayout")
                
                    KeybindsList.Name = "KeybindsList"
                    KeybindsList.Parent = UI["1"]
                    KeybindsList.BackgroundColor3 = Color3FromRGB(23, 21, 21)
                    KeybindsList.BorderColor3 = Color3FromRGB(0, 0, 0)
                    KeybindsList.BorderSizePixel = 0
                    KeybindsList.Position = UDim2New(0.00636042422, 0, 0.43246755, 0)
                    KeybindsList.Size = UDim2New(0, 102, 0, 19)
                    UI.KeybindListo = KeybindsList
                    
                    KeybindsListCorner.CornerRadius = UDim.new(0, 4)
                    KeybindsListCorner.Name = "KeybindsListCorner"
                    KeybindsListCorner.Parent = KeybindsList
                    
                    KeybindsListTitle.Name = "KeybindsListTitle"
                    KeybindsListTitle.Parent = KeybindsList
                    KeybindsListTitle.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                    KeybindsListTitle.BackgroundTransparency = 1.000
                    KeybindsListTitle.BorderColor3 = Color3FromRGB(0, 0, 0)
                    KeybindsListTitle.BorderSizePixel = 0
                    KeybindsListTitle.Size = UDim2New(1, 0, 1, 0)
                    KeybindsListTitle.Font = Enum.Font.RobotoMono
                    KeybindsListTitle.Text = "hotkeys"
                    KeybindsListTitle.TextColor3 = Color3FromRGB(255, 255, 255)
                    KeybindsListTitle.TextSize = 12.000
                    
                    ObjectsList.Name = "ObjectsList"
                    ObjectsList.Parent = KeybindsList
                    ObjectsList.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                    ObjectsList.BackgroundTransparency = 1.000
                    ObjectsList.BorderColor3 = Color3FromRGB(0, 0, 0)
                    ObjectsList.BorderSizePixel = 0
                    ObjectsList.Position = UDim2New(0, 0, 1, 0)
                    ObjectsList.Size = UDim2New(0, 102, 0, 13)
                    
                    ObjectsList_2.Name = "ObjectsList"
                    ObjectsList_2.Parent = ObjectsList
                    ObjectsList_2.SortOrder = Enum.SortOrder.LayoutOrder
                
                    local KeybindsListOptions = {}
                    UserInterface.KeybindList = KeybindsListOptions
                
                    function KeybindsListOptions:Add(title, state)
                        if table.find(UserInterface.KeybindsListObjects, title) then return end
                
                        local HotkeyFrame = InstanceNew("Frame")
                        local HotkeyTitle = InstanceNew("TextLabel")
                        local HotkeyState = InstanceNew("TextLabel")
                
                        HotkeyFrame.Name = title
                        HotkeyFrame.Parent = ObjectsList
                        HotkeyFrame.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                        HotkeyFrame.BackgroundTransparency = 1.000
                        HotkeyFrame.BorderColor3 = Color3FromRGB(0, 0, 0)
                        HotkeyFrame.BorderSizePixel = 0
                        HotkeyFrame.Size = UDim2New(0, 102, 0, 12)
                
                        HotkeyTitle.Name = "HotkeyTitle"
                        HotkeyTitle.Parent = HotkeyFrame
                        HotkeyTitle.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                        HotkeyTitle.BackgroundTransparency = 1.000
                        HotkeyTitle.BorderColor3 = Color3FromRGB(0, 0, 0)
                        HotkeyTitle.BorderSizePixel = 0
                        HotkeyTitle.Size = UDim2New(1, 0, 0, 12)
                        HotkeyTitle.Font = Enum.Font.RobotoMono
                        HotkeyTitle.Text = title
                        HotkeyTitle.TextColor3 = Color3FromRGB(255, 255, 255)
                        HotkeyTitle.TextSize = 12.000
                        HotkeyTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                        HotkeyState.Name = "HotkeyState"
                        HotkeyState.Parent = HotkeyFrame
                        HotkeyState.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                        HotkeyState.BackgroundTransparency = 1.000
                        HotkeyState.BorderColor3 = Color3FromRGB(0, 0, 0)
                        HotkeyState.BorderSizePixel = 0
                        HotkeyState.Size = UDim2New(1, 0, 0, 12)
                        HotkeyState.Font = Enum.Font.RobotoMono
                        HotkeyState.Text = string.lower(state)
                        HotkeyState.TextColor3 = Color3FromRGB(255, 255, 255)
                        HotkeyState.TextSize = 12.000
                        HotkeyState.TextXAlignment = Enum.TextXAlignment.Right
                
                        table.insert(UserInterface.KeybindsListObjects, title)
                        return Options
                    end
                
                    function KeybindsListOptions:SetVisibility(Title, Visibility)
                        local object = ObjectsList:FindFirstChild(Title)
                        if object then
                            ObjectsList:FindFirstChild(Title).Visible = Visibility
                        end
                    end
                
                    function KeybindsListOptions:SetMode(Title, Mode)
                        local object = ObjectsList:FindFirstChild(Title)
                        if object then
                            ObjectsList:FindFirstChild(Title)["HotkeyState"].Text = string.lower(Mode)
                        end
                    end
                
                    function KeybindsListOptions:SetInterfaceVisibility(Visibility)
                        KeybindsList.Visible = Visibility
                    end
                
                    return KeybindsListOptions
                end
            end
            do -- src/Lua/Interface/Others/Popups.lua
                function UserInterface:RemovePopups()
                    if UserInterface.Popup then
                        UserInterface.Popup:Remove()
                        UserInterface.Popup = nil
                    end
                end
                
                function UserInterface:NewPopup(Configuration)
                    UserInterface.Popup = {
                        Remove = Configuration.Remove,
                        ID = Configuration.ID
                    }
                end
            end
            do -- src/Lua/Interface/Others/Watermark.lua
                function UserInterface:Watermark(text)
                    -- add more customization to this shit please.
                
                    --[[
                        Adding Soon : 
                            Watermark Text Triggers
                    ]]
                
                    local Watermark = InstanceNew("Frame")
                    local WatermarkCorner = InstanceNew("UICorner")
                    local WatermarkTitle = InstanceNew("TextLabel")
                
                    local TextBoundX = UIModule:GetTextBoundary("syndicate.club", Enum.Font.Code, 13)
                    Watermark.Name = "Watermark"
                    Watermark.Parent = UI["1"]
                    Watermark.BackgroundColor3 = Color3FromRGB(23, 21, 21)
                    Watermark.BorderColor3 = Color3FromRGB(0, 0, 0)
                    Watermark.BorderSizePixel = 0
                    Watermark.Position = UDim2New(0, 10, 0, 10)
                    Watermark.Size = UDim2New(0, TextBoundX + 10, 0, 20)
                
                    WatermarkCorner.CornerRadius = UDim.new(0, 4)
                    WatermarkCorner.Name = "WatermarkCorner"
                    WatermarkCorner.Parent = Watermark
                
                    WatermarkTitle.Name = "WatermarkTitle"
                    WatermarkTitle.Parent = Watermark
                    WatermarkTitle.BackgroundColor3 = Color3FromRGB(255, 255, 255)
                    WatermarkTitle.BackgroundTransparency = 1.000
                    WatermarkTitle.BorderColor3 = Color3FromRGB(0, 0, 0)
                    WatermarkTitle.BorderSizePixel = 0
                    WatermarkTitle.Size = UDim2New(1, 0, 1, 0)
                    WatermarkTitle.Font = Enum.Font.Code
                    WatermarkTitle.Text = text
                    WatermarkTitle.TextColor3 = Color3FromRGB(255, 255, 255)
                    WatermarkTitle.TextSize = 13.000
                    WatermarkTitle.RichText = true
                
                    local WatermarkOptions = {}
                
                    function WatermarkOptions:ChangeText(newtext)
                        if type(newtext) ~= "string" then return end
                        WatermarkTitle.Text = tostring(newtext)
                
                        local TBX = UIModule:GetTextBoundary(newtext, Enum.Font.Code, 13)
                        Watermark.Size = UDim2New(0, TBX + 10, 0, 20)
                    end
                
                    function WatermarkOptions:SetVisibility(visibility)
                        Watermark.Visible = visibility
                    end
                
                    function WatermarkOptions:SetPosition(v2Pos)
                        Watermark.Position = UDim2New(0, v2Pos.X, 0, v2Pos.Y)
                    end
                
                    return WatermarkOptions
                end
            end
        end
    
        return Configuration
    end
    
    return UserInterface
end)()
return UserInterface
