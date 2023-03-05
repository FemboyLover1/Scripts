--[[
    Credits:
    Hazelware - Table - Spoofing camera on longfly
    Springs67 - litteraly everything else :shrug:
]]

-- [[ {{ -- ArrayList -- }} ]] --
local ScreenGui = Instance.new("ScreenGui") local InvisFrame = Instance.new("Frame") local UIListLayout = Instance.new("UIListLayout") local Logo = Instance.new("TextLabel") ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling ScreenGui.ResetOnSpawn = false InvisFrame.Name = "InvisFrame" InvisFrame.Parent = ScreenGui InvisFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) InvisFrame.BackgroundTransparency = 1.000 InvisFrame.Position = UDim2.new(0.0193850268, 0, 0.357855439, 0) InvisFrame.Size = UDim2.new(0, 245, 0, 446) UIListLayout.Parent = InvisFrame
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
Logo.Name = "Logo"
Logo.Parent = ScreenGui
Logo.BackgroundColor3 = Color3.fromRGB(170, 170, 170)
Logo.BackgroundTransparency = 1.000
Logo.BorderSizePixel = 0
Logo.Position = UDim2.new(0, 0, 0.938902736, 0)
Logo.Size = UDim2.new(0, 274, 0, 49)
Logo.Font = Enum.Font.SourceSans
Logo.Text = "TheAnticheatClient"
Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
Logo.TextSize = 40.000

function MakeModule(name)
	local TextLabel = Instance.new("TextLabel")
	TextLabel.Parent = InvisFrame
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.0875912383, 0, 0.921524644, 0)
	TextLabel.Size = UDim2.new(0, 250, 0, 35)
	TextLabel.Font = Enum.Font.SourceSans
	TextLabel.Text = name
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextSize = 29.000
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Name = name
end
function RemoveModule(name)
	if InvisFrame:FindFirstChild(name) then
		InvisFrame:FindFirstChild(name):Remove()
	end
end

-- [[ {{ -- Main Windows -- }} ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("TheAnticheatClient", "Ocean")

-- [[ {{ -- Tabs -- }} ]] --
local Combat = Window:NewTab("Combat")
local Movement = Window:NewTab("Movement")
local Player = Window:NewTab("Player")
local Render = Window:NewTab("Render")
local Misc = Window:NewTab("Misc")

-- [[ {{ -- Sections -- }} ]] --
local CombatSection = Combat:NewSection("Combat")
local MovementSection = Movement:NewSection("Movement")
local PlayerSection = Player:NewSection("Player")
local RenderSection = Render:NewSection("Render")
local MiscSection = Misc:NewSection("Misc")

-- [[ {{ -- Functions//Locals -- }} ]] --

local lplr = game.Players.LocalPlayer
local cam = game.Workspace.CurrentCamera

function runcode(func)
	pcall(function()
		func()
	end)
end

function Chat(msg)
	local args = {
		[1] = msg,
		[2] = "All"
	}
	game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
end

--Hazelware :heart:
local knitRecieved, knit
knitRecieved, knit = pcall(function()
	repeat task.wait()
		return debug.getupvalue(require(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerScripts.TS.knit).setup, 6)
	until knitRecieved
end)
local lplr = game.Players.LocalPlayer
local events = {
	HangGliderController = knit.Controllers["HangGliderController"],
	SprintController = knit.Controllers["SprintController"],
	JadeHammerController = knit.Controllers["JadeHammerController"],
	PictureModeController = knit.Controllers["PictureModeController"],
	SwordController = knit.Controllers["SwordController"],
	GroundHit = game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.GroundHit,
	Reach = require(game:GetService("ReplicatedStorage").TS.combat["combat-constant"]),
	Knockback = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1),
	report = knit.Controllers["report-controller"]
}

-- [[ {{ --Examples -- }} ]] --

--[[
    --Button
    Section:NewButton("ButtonText", "ButtonInfo", function()
        print("Clicked")
    end)
    --Toggle
    Section:NewToggle("ToggleText", "ToggleInfo", function(state)
        if state then
            print("Toggle On")
        else
            print("Toggle Off")
        end
    end)
    --Slider
    Section:NewSlider("SliderText", "SliderInfo", 500, 0, function(s) -- 500 (MaxValue) | 0 (MinValue)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
    end)
    --TextBox
    Section:NewTextBox("TextboxText", "TextboxInfo", function(txt)
        print(txt)
    end)
    --Keybinds
    Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.F, function()
        print("You just clicked the bind")
    end)
    --Dropdowns
    Section:NewDropdown("DropdownText", "DropdownInf", {"Option 1", "Option 2", "Option 3"}, function(currentOption)
        print(currentOption)
    end)

]]

-- [[ {{ -- Buttons -- }} ]] --

--Combat

runcode(function()
	--Hazelware rotation (ty :D)
	local AuraEnabled = false
	local AuraRange = 18

	CombatSection:NewToggle("Aura", "aura momento", function(state)
		if state then
			MakeModule("Aura - {18}")
			AuraEnabled = true
			runcode(function()
				repeat
					for i,v in pairs(game.Players:GetPlayers()) do
						if (v.Character) and (game.Players.LocalPlayer.Character) and v ~= game.Players.LocalPlayer then
							runcode(function()
								if (v.Character.PrimaryPart.Position - lplr.Character.PrimaryPart.Position).Magnitude < AuraRange and v.Character.Humanoid.health > 1 and lplr.Character.Humanoid.Health > 1 and v.Team ~= lplr.Team then
									pcall(function()
                                        lplr.Character.PrimaryPart.CFrame = CFrame.lookAt(lplr.Character.PrimaryPart.Position,Vector3.new(v.Character.PrimaryPart.Position.X,lplr.Character.PrimaryPart.Position.Y,v.Character.PrimaryPart.Position.Z))
                                    end)
									events["SwordController"]:swingSwordAtMouse()
								end
							end)
						end
					end
                    task.wait(0.31)
				until not AuraEnabled
			end)
		else
			AuraEnabled = false
			RemoveModule("Aura - {18}")
		end
	end)
end)

runcode(function()
    local InstakillRepeat = false
    CombatSection:NewToggle("Instakill", "ded", function(state)
		if state then
			MakeModule("Instakill - {Pyro}")
            InstakillRepeat = true
			runcode(function()
				repeat task.wait()
					for i,v in pairs(game.Players:GetPlayers()) do
						if (v.Character) and (game.Players.LocalPlayer.Character) and v ~= game.Players.LocalPlayer then
							runcode(function()
								if (v.Character.PrimaryPart.Position - lplr.Character.PrimaryPart.Position).Magnitude < 12 and v.Character.Humanoid.health > 1 and lplr.Character.Humanoid.Health > 1 and v.Team ~= lplr.Team then
									game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.UseFlamethrower:InvokeServer()
								end
							end)
						end
					end
				until not InstakillRepeat
			end)
		else
			RemoveModule("Instakill")
			InstakillRepeat = false
		end
	end)
end)

runcode(function()
	CombatSection:NewToggle("AntiKb", "allows for no knockback", function(state)
		if state then
			MakeModule("AntiKb")
			events.Knockback.kbUpwardStrength = 0
			events.Knockback.kbUpwardStrength = 0
		else
			RemoveModule("AntiKb")
			events.Knockback.kbUpwardStrength = 100
			events.Knockback.kbUpwardStrength = 100
		end
	end)
end)

runcode(function()
	CombatSection:NewToggle("Reach", "higher reach than legits ez momento", function(state)
		if state then
			MakeModule("Reach")
			events.Reach.RAYCAST_SWORD_CHARACTER_DISTANCE = 18
		else
			RemoveModule("Reach")
			events.Reach.RAYCAST_SWORD_CHARACTER_DISTANCE = 14
		end
	end)
end)

runcode(function()
	local RepeatSprint = false
	CombatSection:NewToggle("AutoSprint", "makes u sprint automatically", function(state)
		if state then
			MakeModule("AutoSprint")
            RepeatSprint = true
			repeat task.wait(0.1)
				events["SprintController"]:startSprinting()
			until not RepeatSprint
		else
			RepeatSprint = false
			RemoveModule("AutoSprint")
		end
	end)
end)

runcode(function()
    local UIS = game:GetService("UserInputService")
    local You = game.Players.LocalPlayer.Name
    SpeedOn = false
	MovementSection:NewToggle("Speed", "allows for faster speed", function(state)
		if state then
			MakeModule("Speed - {CFrame}")
            SpeedOn = true
            repeat task.wait()
				if UIS:IsKeyDown(Enum.KeyCode.W) then
					game:GetService("Workspace")[You].HumanoidRootPart.CFrame = game:GetService("Workspace")[You].HumanoidRootPart.CFrame * CFrame.new(0,0,-0.05)
				end;
				if UIS:IsKeyDown(Enum.KeyCode.A) then
					game:GetService("Workspace")[You].HumanoidRootPart.CFrame = game:GetService("Workspace")[You].HumanoidRootPart.CFrame * CFrame.new(-0.05,0,0)
				end;
				if UIS:IsKeyDown(Enum.KeyCode.S) then
					game:GetService("Workspace")[You].HumanoidRootPart.CFrame = game:GetService("Workspace")[You].HumanoidRootPart.CFrame * CFrame.new(0,0,0.05)
				end;
				if UIS:IsKeyDown(Enum.KeyCode.D) then
					game:GetService("Workspace")[You].HumanoidRootPart.CFrame = game:GetService("Workspace")[You].HumanoidRootPart.CFrame * CFrame.new(0.05,0,0)
				end;
            until not SpeedOn
		else
			RemoveModule("Speed - {CFrame}")
			SpeedOn = false
		end
	end)
end)

runcode(function()
    MovementSection:NewKeybind("FunnyHighjump", "makes u jump VERY high lul", Enum.KeyCode.H, function()
        pcall(function()
            MakeModule("Highjump - {Velo}")
            for i=1, 25 do
                lplr.character.HumanoidRootPart.Velocity = lplr.character.HumanoidRootPart.Velocity + Vector3.new(0,10.7,0)
                wait(0.00001)
                lplr.character.HumanoidRootPart.Velocity = lplr.character.HumanoidRootPart.Velocity + Vector3.new(0,16,0)
            end
            RemoveModule("Highjump - {Velo}")
        end)
    end)
end)

runcode(function()
    MovementSection:NewKeybind("Flight", "makes u jump VERY high lul", Enum.KeyCode.R, function()
        pcall(function()
            MakeModule("Flight - {Gravity}")
            game.Workspace.Gravity = 0
            wait(2.4)
            game.Workspace.Gravity = 196.2
            RemoveModule("Flight - {Gravity}")
        end)
    end)
end)

runcode(function()
	RenderSection:NewToggle("Chams", "see people through walls", function(state)
		if state then
			MakeModule("Chams - {Highlight}")
			for i,v in pairs(game.Players:GetPlayers()) do
				if v ~= game.Players.LocalPlayer then
					local chams = Instance.new("Highlight",v.Character)
					chams.OutlineTransparency = 0.5
					chams.Name = "Cham"
					chams.OutlineColor = Color3.fromRGB(0, 69, 179)
					chams.FillColor = Color3.fromRGB(2, 99, 255) 
				end
			end
		else
			for i,v in pairs(game.Players:GetPlayers()) do
				if v.Character:FindFirstChild("Cham") then
					v.Character:FindFirstChild("Cham"):Destroy()
				end
			end
			RemoveModule("Chams - {Highlight}")
		end
	end)
end)

runcode(function()
	RenderSection:NewToggle("FemboyAmbient", "'My favorite module', -Spring67#2760", function(state)
		if state then
			MakeModule("FemboyAmbient")
			game.Lighting.Ambient = Color3.fromRGB(255, 85, 255)
			game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 85, 255)
			game.Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
			game.Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
			game.Lighting.EnvironmentDiffuseScale = 0
		else
			game.Lighting.Ambient = Color3.fromRGB(91, 91, 91)
			game.Lighting.OutdoorAmbient = Color3.fromRGB(201, 201, 201)
			game.Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
			game.Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
			game.Lighting.EnvironmentDiffuseScale = 1
			RemoveModule("FemboyAmbient")
		end
	end)
end)

runcode(function()
	RenderSection:NewKeybind("ToggleUi", "ToggleUi", Enum.KeyCode.RightShift, function()
		Library:ToggleUI()
	end)
end)

runcode(function()
	PlayerSection:NewButton("Antivoid", "no falling into void :scream:", function()
		MakeModule("Antivoid")
		NewAntivoidPart = Instance.new("Part",workspace)
		NewAntivoidPart.Size = Vector3.new(9999,0.1,9999)
		NewAntivoidPart.Position = Vector3.new(0,22,0)
		NewAntivoidPart.Name = "NewAntivoidPart"
		NewAntivoidPart.Transparency = 0.5
		NewAntivoidPart.CanCollide = true
		NewAntivoidPart.Anchored = true
		NewAntivoidPart.Material = Enum.Material.Neon
		NewAntivoidPart.BrickColor = BrickColor.new("Royal purple")
	end)
end)

runcode(function()
	PlayerSection:NewTextBox("ChatBypasser", "allows u to bypass chat filter", function(msg)
		if msg == "fuck" then
			Chat("cf uu cc kk")
        elseif msg == "rape" then
            Chat("xrr aa pp ee")
        elseif msg == "bitch" then
            Chat("vb ii tt cc hh")
        elseif msg == "pistonsex" then
            Chat("Piston was in his room, cranking his tiny wang to Roblox vsaxe when Xylex ran in. The sight of Xylex made Piston's heart race with excitement. He had been waiting for this moment for a long time.")
        elseif msg == "sex" then
            Chat("cs ee xxx")
        else
            print("Nothing found in txt lul")
        end
	end)
end)

runcode(function()
    local SpammerEnabled = false
    PlayerSection:NewToggle("ChatSpammer", "chat spams every 5 seconds", function(state)
		if state then
			MakeModule("ChatSpammer")
			SpammerEnabled = true
		else
			SpammerEnabled = false
			RemoveModule("ChatSpammer")
		end
	end)

    PlayerSection:NewTextBox("ChatSpammer", "choose message being sent", function(msg)
        repeat
            Chat(msg)
            task.wait(5)
        until not SpammerEnabled
    end)
end)

runcode(function()
    PlayerSection:NewButton("NoFall", "yes no fall damage", function()
        MakeModule("NoFall - {Remote}")
		repeat task.wait()
            events["GroundHit"]:FireServer()
        until not true
	end)
end)
