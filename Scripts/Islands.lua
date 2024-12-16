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
            local ironOre = workspace:GetDescendants("IronOre")[1]
            if ironOre then
                local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
                local tween = TweenService:Create(Character.HumanoidRootPart, tweenInfo, {CFrame = ironOre.CFrame * CFrame.new(0, 3, 0)})
                tween:Play()
                tween.Completed:Wait()
            end
        end
        local rockIron = workspace:FindFirstChild("rockIron")
        if rockIron then
            local part = rockIron:FindFirstChild("1")
            if part then
                local args = {
                    [1] = {
                        ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                        ["part"] = part,
                        ["block"] = rockIron,
                        ["norm"] = part.Position - Character.HumanoidRootPart.Position,
                        ["pos"] = (part.Position - rockIron.Position).Unit
                    }
                }

                game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
            end
        end
        task.wait(0.1)
    end
end)
BlareLib:CreateNotification("Island Script Initiated", "Welcome " .. PlayerName .. "!", 4)