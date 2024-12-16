local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local PlayerName = Player.Name
local Health = Humanoid.Health
local MaxHealth = Humanoid.MaxHealth
local Radius = 10
local TweenService = game:GetService("TweenService")

local win = BlareLib:Create({
    Name = "Islands Script",
    StartupSound = {
        Toggle = true,
        SoundID = "rbxassetid://6958727243",
        TimePosition = 1
    }
})

local AutoFarmTab = win:Tab('AutoFarms')
AutoFarmTab:Section('Settings')
AutoFarmTab:Toggle('Auto Tween', function(v)
    ShouldTween = v
end)

AutoFarmTab:Textbox('Autofarm Radius', function(value)
    local newRadius = tonumber(value)
    if newRadius then
        Radius = newRadius
        print("Radius set to:", Radius)
        BlareLib:CreateNotification("Radius Updated", "Radius set to: " .. Radius, 3)
    else
        BlareLib:CreateNotification("Invalid Input", "Please enter a number, words don't work!", 3)
    end
end)
AutoFarmTab:Comment('Lower these for better chance of the anticheat not detecting')

AutoFarmTab:Section('Resource Farming')

AutoFarmTab:Toggle('Iron Ore', function(v)
    IronOre = v
    while IronOre do
        if ShouldTween then
            local ironOre = workspace:FindFirstChild("rockIron")
            if ironOre then
                local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
                local tween = TweenService:Create(Character.HumanoidRootPart, tweenInfo, {CFrame = ironOre.CFrame * CFrame.new(0, 3, 0)})
                tween:Play()
                tween.Completed:Wait()
            end
        end
        
        local args = {
            [1] = {
                ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                ["part"] = workspace:FindFirstChild("rockIron"):FindFirstChild("1"),
                ["block"] = workspace:FindFirstChild("rockIron"),
                ["norm"] = Vector3.new(-3459.94384765625, 37.332237243652344, -3543.42919921875),
                ["pos"] = Vector3.new(-0.26722002029418945, 0.8833552598953247, -0.3850674331188202)
            }
        }

        game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
        task.wait(0.1)
    end
end)
BlareLib:CreateNotification("Island Script Initiated", "Welcome " .. PlayerName .. "!", 4)