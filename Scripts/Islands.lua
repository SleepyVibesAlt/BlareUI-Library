local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()
local Player = game.Players.LocalPlayer
local Humanoid = Player.Character.Humanoid
local Health = Humanoid.Health
local MaxHealth = Humanoid.MaxHealth

local win = BlareLib:Create({
    Name = "Islands Script",
    StartupSound = {
        Toggle = true,
        SoundID = "rbxassetid://6958727243",
        TimePosition = 1
    }
})

BlareLib:Blacklist({"BLXOO7I", "Player2", "Player3"})

local AutoFarmTab = win:Tab('AutoFarms')
AutoFarmTab:Section('Settings')
AutoFarmTab:Toggle('Auto Tween', function(v)
    tweenEnabled = v
end)

AutoFarmTab:Textbox('Autofarm Radius', function(value)
    Radius = tonumber(value)
    print("Radius set to:", fov)
end)
AutoFarmTab:Comment('Lower these for better chance of the anticheat not detecting')

AutoFarmTab:Section('Resource Farming')
AutoFarmTab:Toggle('Auto Fish', function(v)
    autoFish = v
    if autoFish then
        spawn(function()
            while autoFish do
                local args = {
                    [1] = "cdf239f8-f9a1-4ca0-86a5-413afe000191",
                    [2] = {
                        [1] = {
                            ["playerLocation"] = game.Players.LocalPlayer.Character.HumanoidRootPart.Position,
                            ["direction"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector,
                            ["strength"] = 0.5
                        }
                    }
                }
                
                game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("jtEIwpvoyxfyedcIomzEcuywKczW/rpjmsslmMwtNp"):FireServer(unpack(args))
                wait(10)
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

AutoFarmTab:Toggle('Autofarm Wood', function(v)
    getWood = v
    if getWood then
        spawn(function()
            while getWood do
                for _, v in pairs(workspace:GetDescendants()) do
                    if v.Name == "trunk" and (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= Radius then
                        if tweenEnabled then
                            local tweenService = game:GetService("TweenService")
                            local tweenInfo = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
                            local tween = tweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, tweenInfo, {
                                CFrame = CFrame.new(v.Position + Vector3.new(0, 3, 0))
                            })
                            tween:Play()
                            tween.Completed:Wait()
                        end
                        local args = {
                            [1] = {
                                ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                                ["part"] = v,
                                ["block"] = v.Parent,
                                ["norm"] = Vector3.new(-3226.57763671875, 54.39141845703125, -3405.1630859375),
                                ["pos"] = Vector3.new(-0.8084943294525146, -0.4702897071838379, -0.35378578305244446)
                            }
                        }
                        game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
                        wait(1)
                    end
                end
                wait()
            end
        end)
    end
end)

AutoFarmTab:Section('Ore Farming')
AutoFarmTab:Toggle('AutoFarm IronOre', function(v)
    getIron = v
    if getIron then
        spawn(function()
            while getIron do
                for _, v in pairs(workspace:GetDescendants()) do
                    if v.Name == "rockIron" and (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= Radius then
                        if tweenEnabled then
                            local tweenService = game:GetService("TweenService")
                            local tweenInfo = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
                            local tween = tweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, tweenInfo, {
                                CFrame = CFrame.new(v.Position + Vector3.new(0, 3, 0))
                            })
                            tween:Play()
                            tween.Completed:Wait()
                        end
                        local args = {
                            [1] = {
                                ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                                ["part"] = v:FindFirstChild("1"),
                                ["block"] = v,
                                ["norm"] = v.Position,
                                ["pos"] = (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Unit
                            }
                        }
                        game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
                        wait(0.5)
                    end
                end
                wait()
            end
        end)
    end
end)

AutoFarmTab:Toggle('AutoFarm Electrite', function(v)
    getElectrite = v
    if getElectrite then
        spawn(function()
            while getElectrite do
                for _, v in pairs(workspace:GetDescendants()) do
                    if v.Name == "rockElectrite" and (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= Radius then
                        if tweenEnabled then
                            local tweenService = game:GetService("TweenService")
                            local tweenInfo = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
                            local tween = tweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, tweenInfo, {
                                CFrame = CFrame.new(v.Position + Vector3.new(0, 3, 0))
                            })
                            tween:Play()
                            tween.Completed:Wait()
                        end
                        local args = {
                            [1] = {
                                ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                                ["part"] = v:FindFirstChild("1"),
                                ["block"] = v,
                                ["norm"] = v.Position,
                                ["pos"] = (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Unit
                            }
                        }
                        game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
                        wait(0.5)
                    end
                end
                wait()
            end
        end)
    end
end)

AutoFarmTab:Section('Auto Collect')
AutoFarmTab:Toggle('Collect Starfruits', function(v)
    getStarfruit = v
    if getStarfruit then
        spawn(function()
            while getStarfruit do
                for _, starfruit in pairs(workspace:GetDescendants()) do
                    if starfruit.Name == "starfruit" and starfruit:IsA("Part") then
                        local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                        local humanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if humanoid and humanoidRootPart then
                            local distance = (starfruit.Position - humanoidRootPart.Position).Magnitude
                            if distance <= Radius then
                                if tweenEnabled then
                                    local tweenService = game:GetService("TweenService")
                                    local tweenInfo = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
                                    local tween = tweenService:Create(humanoidRootPart, tweenInfo, {
                                        CFrame = CFrame.new(starfruit.Position + Vector3.new(0, 3, 0))
                                    })
                                    tween:Play()
                                    tween.Completed:Wait()
                                end
                                
                                local args = {
                                    [1] = {
                                        ["player"] = game:GetService("Players").LocalPlayer,
                                        ["tukiqepvhyyBj"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nFOenfsq",
                                        ["model"] = starfruit
                                    }
                                }
                                
                                game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_HARVEST_CROP_REQUEST:InvokeServer(unpack(args))
                                wait(1)
                            end
                        end
                    end
                end
                wait(0.1)
            end
        end)
    end
end)

AutoFarmTab:Toggle('Collect Red Mushrooms', function(v)
    getMushroom = v
    if getMushroom then
        spawn(function()
            while getMushroom do
                for _, mushroom in pairs(workspace:GetDescendants()) do
                    if mushroom.Name == "mushroomRed" and mushroom:IsA("Part") then
                        local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                        local humanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if humanoid and humanoidRootPart then
                            local distance = (mushroom.Position - humanoidRootPart.Position).Magnitude
                            if distance <= Radius then
                                if tweenEnabled then
                                    local tweenService = game:GetService("TweenService")
                                    local tweenInfo = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
                                    local tween = tweenService:Create(humanoidRootPart, tweenInfo, {
                                        CFrame = CFrame.new(mushroom.Position + Vector3.new(0, 3, 0))
                                    })
                                    tween:Play()
                                    tween.Completed:Wait()
                                end
                                
                                local args = {
                                    [1] = {
                                        ["player"] = game:GetService("Players").LocalPlayer,
                                        ["tukiqepvhyyBj"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nFOenfsq",
                                        ["model"] = mushroom
                                    }
                                }
                                
                                game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_HARVEST_CROP_REQUEST:InvokeServer(unpack(args))
                                wait(1)
                            end
                        end
                    end
                end
                wait(0.1)
            end
        end)
    end
end)

local charactertab = win:Tab('Character')
charactertab:Section('Player Settings')
charactertab:Button('Anti-AFK', function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:CaptureController()
    vu:ClickButton2(Vector2.new())
    end)    
end)

local uitab = win:Tab('UI')
uitab:Section('Interface Options')
uitab:Button('Destroy GUI', function()
    win:Exit()
end)

BlareLib:CreateNotification("Success", "Operation completed successfully!", 3)