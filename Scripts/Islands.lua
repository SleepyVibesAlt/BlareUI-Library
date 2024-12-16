local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Health = Humanoid.Health
local MaxHealth = Humanoid.MaxHealth
local Radius = 10 -- Default radius value

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
    tweenEnabled = v
end)

AutoFarmTab:Textbox('Autofarm Radius', function(value)
    Radius = tonumber(value) or 10 -- Set default to 10 if invalid input
    print("Radius set to:", Radius)
end)
AutoFarmTab:Comment('Lower these for better chance of the anticheat not detecting')

AutoFarmTab:Section('Resource Farming')
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

AutoFarmTab:Toggle('Autofarm Wood', function(v)
    getWood = v
    if getWood then
        spawn(function()
            while getWood and task.wait() do
                if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then continue end
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if not getWood then break end
                    if v.Name == "trunk" and (v.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= Radius then
                        if tweenEnabled then
                            local tweenService = game:GetService("TweenService")
                            local tweenInfo = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
                            local tween = tweenService:Create(Player.Character.HumanoidRootPart, tweenInfo, {
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
                        task.wait(1)
                    end
                end
            end
        end)
    end
end)

AutoFarmTab:Section('Ore Farming')
AutoFarmTab:Toggle('AutoFarm IronOre', function(v)
    getIron = v
    if getIron then
        spawn(function()
            while getIron and task.wait() do
                if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then continue end
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if not getIron then break end
                    if v.Name == "rockIron" and (v.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= Radius then
                        if tweenEnabled then
                            local tweenService = game:GetService("TweenService")
                            local tweenInfo = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
                            local tween = tweenService:Create(Player.Character.HumanoidRootPart, tweenInfo, {
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
                                ["pos"] = (v.Position - Player.Character.HumanoidRootPart.Position).Unit
                            }
                        }
                        game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
                        task.wait(0.5)
                    end
                end
            end
        end)
    end
end)

AutoFarmTab:Toggle('AutoFarm Electrite', function(v)
    getElectrite = v
    if getElectrite then
        spawn(function()
            while getElectrite and task.wait() do
                if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then continue end
                
                for _, v in pairs(workspace:GetDescendants()) do
                    if not getElectrite then break end
                    if v.Name == "rockElectrite" and (v.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= Radius then
                        if tweenEnabled then
                            local tweenService = game:GetService("TweenService")
                            local tweenInfo = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
                            local tween = tweenService:Create(Player.Character.HumanoidRootPart, tweenInfo, {
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
                                ["pos"] = (v.Position - Player.Character.HumanoidRootPart.Position).Unit
                            }
                        }
                        game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
                        task.wait(0.5)
                    end
                end
            end
        end)
    end
end)

AutoFarmTab:Section('Auto Collect')
AutoFarmTab:Toggle('Collect Starfruits', function(v)
    getStarfruit = v
    if getStarfruit then
        spawn(function()
            while getStarfruit and task.wait(0.1) do
                if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then continue end
                
                for _, starfruit in pairs(workspace:GetDescendants()) do
                    if not getStarfruit then break end
                    if starfruit.Name == "starfruit" and starfruit:IsA("Part") then
                        local humanoid = Player.Character:FindFirstChild("Humanoid")
                        local humanoidRootPart = Player.Character:FindFirstChild("HumanoidRootPart")
                        
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
                                        ["player"] = Player,
                                        ["tukiqepvhyyBj"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nFOenfsq",
                                        ["model"] = starfruit
                                    }
                                }
                                
                                game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_HARVEST_CROP_REQUEST:InvokeServer(unpack(args))
                                task.wait(1)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

AutoFarmTab:Toggle('Collect Red Mushrooms', function(v)
    getMushroom = v
    if getMushroom then
        spawn(function()
            while getMushroom and task.wait(0.1) do
                if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then continue end
                
                for _, mushroom in pairs(workspace:GetDescendants()) do
                    if not getMushroom then break end
                    if mushroom.Name == "mushroomRed" and mushroom:IsA("Part") then
                        local humanoid = Player.Character:FindFirstChild("Humanoid")
                        local humanoidRootPart = Player.Character:FindFirstChild("HumanoidRootPart")
                        
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
                                        ["player"] = Player,
                                        ["tukiqepvhyyBj"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nFOenfsq",
                                        ["model"] = mushroom
                                    }
                                }
                                
                                game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_HARVEST_CROP_REQUEST:InvokeServer(unpack(args))
                                task.wait(1)
                            end
                        end
                    end
                end
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