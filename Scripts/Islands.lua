local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local PlayerName = Player.Name
local Health = Humanoid.Health
local MaxHealth = Humanoid.MaxHealth
local Radius = 50
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
        BlareLib:CreateNotification("Radius Updated", "Radius set to: " .. Radius, 2)
    else
        BlareLib:CreateNotification("Invalid Input", "Please enter a number, words don't work!", 3)
    end
end)

AutoFarmTab:Comment('Lower these for better chance of the anticheat not detecting')

AutoFarmTab:Section('Resource Farming')

AutoFarmTab:Toggle('Iron Ore', function(v)
    print("Iron Ore toggled:", v)
    wait(1)
    IronOre = v
    while IronOre do
        local rocks = workspace:GetDescendants()
        local closestRock = nil
        local closestDistance = math.huge
        
        for _, rock in pairs(rocks) do
            if rock.Name == "rockIron" and rock:IsA("Part") then
                local distance = (rock.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance <= Radius and distance < closestDistance then
                    closestRock = rock
                    closestDistance = distance
                end
            end
        end
        
        if closestRock then
            if ShouldTween then
                local tweenInfo = TweenInfo.new(distance/50, Enum.EasingStyle.Linear)
                local tween = TweenService:Create(Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(closestRock.Position)})
                tween:Play()
                tween.Completed:Wait()
            end
            local args = {
                [1] = {
                    ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                    ["part"] = closestRock:FindFirstChild("1"),
                    ["block"] = closestRock,
                    ["norm"] = closestRock.Position,
                    ["pos"] = closestRock.Position - Character.HumanoidRootPart.Position
                }
            }
            
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
        end
        task.wait(1)
    end
end)

AutoFarmTab:Toggle('Eletrite Ore', function(v)
    print("Eletrite Ore toggled:", v)
    wait(1)
    EletriteOre = v
    while EletriteOre do
        local rocks = workspace:GetDescendants()
        local closestRock = nil
        local closestDistance = math.huge
        
        for _, rock in pairs(rocks) do
            if rock.Name == "rockElectrite" and rock:IsA("Part") then
                local distance = (rock.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance <= Radius and distance < closestDistance then
                    closestRock = rock
                    closestDistance = distance
                end
            end
        end
        
        if closestRock then
            if ShouldTween then
                local tweenInfo = TweenInfo.new(distance/50, Enum.EasingStyle.Linear)
                local tween = TweenService:Create(Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(closestRock.Position)})
                tween:Play()
                tween.Completed:Wait()
            end
            local args = {
                [1] = {
                    ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                    ["part"] = closestRock:FindFirstChild("1"),
                    ["block"] = closestRock,
                    ["norm"] = closestRock.Position,
                    ["pos"] = closestRock.Position - Character.HumanoidRootPart.Position
                }
            }
            
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
        end
        task.wait(1)
    end
end)

local MobFarmTab = win:Tab('Mob Farm')
MobFarmTab:Section('Settings')

MobFarmTab:Textbox('Red Berry Slot', function(value)
    local newPos = tonumber(value)
    local Position = 3
    if newPos then
        Position = newPos
        print("Food Position set to:", Position)
        BlareLib:CreateNotification("Updated!", "Food positon updated: "..  2)
    else
        BlareLib:CreateNotification("Invalid Input", "Please enter a number, words don't work!", 3)
    end
end)
MobFarmTab:Comment('The slot where the Red Berries is, slots 1-9')

MobFarmTab:Toggle('Auto Heal (Red Berries)', function(v)
    AutoHeal = v
    while AutoHeal do
        local Health = Character:WaitForChild("Humanoid").Health
        local MaxHealth = Character:WaitForChild("Humanoid").MaxHealth
        
        if Health < MaxHealth then
            local virtualInput = game:GetService("VirtualInputManager")
            virtualInput:SendKeyEvent(true, tostring(Position), false, game)
            task.wait(0.1)
            print("Red Berries used")
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Section('Slime Island')

MobFarmTab:Toggle('Farm Slimes', function(v)
    local Slimes = game.workspace.WildernessIsland.Entities
    SlimeFarm = v
    while SlimeFarm do
        local closestSlime = nil
        local closestDistance = math.huge
        
        for _, slime in pairs(Slimes:GetChildren()) do
            if slime.Name == "slime" and slime:FindFirstChild("Humanoid") and slime.Humanoid.Health > 0 and SlimeFarm then
                local distance = (slime.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestSlime = slime
                    closestDistance = distance
                end
            end
        end
        
        if closestSlime then
            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
            local tween = TweenService:Create(Character.HumanoidRootPart, tweenInfo, {
                CFrame = closestSlime.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
            })
            tween:Play()
            tween.Completed:Wait()
            
            while closestSlime:FindFirstChild("Humanoid") and closestSlime.Humanoid.Health > 0 and SlimeFarm do
                Character.HumanoidRootPart.CFrame = closestSlime.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait(0.1)
                virtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                task.wait()
            end
            print("Slime defeated!")
        end
        task.wait(1)
    end
end)

BlareLib:CreateNotification("Island Script Initiated", "Welcome " .. PlayerName .. "!", 2)