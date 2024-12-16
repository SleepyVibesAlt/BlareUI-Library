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

AutoFarmTab:Section('Resource')
AutoFarmTab:Toggle('Auto Fish', function(v)
    autoFish = v
    if autoFish then
        spawn(function()
            while autoFish and task.wait(10) do
                if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then continue end
                
                local args = {
                    [1] = "cdf239f8-f9a1-4ca0-86a5-413afe000191",
                    [2] = {
                        [1] = {
                            ["playerLocation"] = Player.Character.HumanoidRootPart.Position,
                            ["direction"] = Player.Character.HumanoidRootPart.CFrame.LookVector,
                            ["strength"] = 0.5
                        }
                    }
                }
                
                game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("jtEIwpvoyxfyedcIomzEcuywKczW/rpjmsslmMwtNp"):FireServer(unpack(args))
                task.wait(1)
                local args = {
                    [1] = {
                        ["success"] = true
                    }
                }
                
                game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("jtEIwpvoyxfyedcIomzEcuywKczW/vxdJepVeLTscuViRAjHftcqjvpyomnsl"):FireServer(unpack(args))
            end
        end)
    end
end)

AutoFarmTab:Toggle('Iron Ore', function(v)
    ironFarm = v
    if ironFarm then
        spawn(function()
            while ironFarm and task.wait() do
                local iron = getNil("rockIron", "Part")
                if iron and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (iron.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                    if distance > Radius then
                        local tweenInfo = TweenInfo.new(distance/50, Enum.EasingStyle.Linear)
                        local tween = TweenService:Create(Player.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(iron.Position + Vector3.new(0, 3, 0))})
                        tween:Play()
                        tween.Completed:Wait()
                    end
                    
                    local args = {
                        [1] = {
                            ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                            ["part"] = iron:FindFirstChild("1"),
                            ["block"] = iron,
                            ["norm"] = Vector3.new(-3459.94384765625, 37.332237243652344, -3543.42919921875),
                            ["pos"] = Vector3.new(-0.26722002029418945, 0.8833552598953247, -0.3850674331188202)
                        }
                    }

                    game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
                end
            end
        end)
    end
end)

AutoFarmTab:Toggle('Electrite', function(v)
    electriteFarm = v
    if electriteFarm then
        spawn(function()
            while electriteFarm and task.wait() do
                local electrite = getNil("rockElectrite", "Part")
                if electrite and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (electrite.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                    if distance > Radius then
                        local tweenInfo = TweenInfo.new(distance/50, Enum.EasingStyle.Linear)
                        local tween = TweenService:Create(Player.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(electrite.Position + Vector3.new(0, 3, 0))})
                        tween:Play()
                        tween.Completed:Wait()
                    end
                    
                    local args = {
                        [1] = {
                            ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                            ["part"] = electrite:FindFirstChild("1"),
                            ["block"] = electrite,
                            ["norm"] = Vector3.new(-3459.94384765625, 37.332237243652344, -3543.42919921875),
                            ["pos"] = Vector3.new(-0.26722002029418945, 0.8833552598953247, -0.3850674331188202)
                        }
                    }

                    game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
                end
            end
        end)
    end
end)

BlareLib:CreateNotification("Island Script Initiated", "Welcome " .. PlayerName .. "!", 4)