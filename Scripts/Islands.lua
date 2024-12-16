local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local PlayerName = Player.Name
local Health = Humanoid.Health
local MaxHealth = Humanoid.MaxHealth
local Radius = 50
local TweenSpd = 1
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

AutoFarmTab:Textbox('Tween Speed', function(value)
    local TweenSpeed = tonumber(value)
    if TweenSpeed then
        TweenSpd = TweenSpeed
        print("Speed set to:", TweenSpeed)
        BlareLib:CreateNotification("Speed Updated", "Speed set to: " .. TweenSpeed, 3)
    else
        BlareLib:CreateNotification("Invalid Input", "Please enter a number, words don't work!", 3)
    end
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
                local tweenInfo = TweenInfo.new(TweenSpd, Enum.EasingStyle.Linear)
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
                local tweenInfo = TweenInfo.new(TweenSpd, Enum.EasingStyle.Linear)
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

AutoFarmTab:Separator()

AutoFarmTab:Toggle('Gather Red Mushrooms', function(v)
    print("Gather Red Mushrooms toggled:", v)
    wait(1)
    RedMushrooms = v
    while RedMushrooms do
        local mushrooms = workspace:GetDescendants()
        local closestMushroom = nil
        local closestDistance = math.huge
        
        for _, mushroom in pairs(mushrooms) do
            if mushroom.Name == "mushroomRed" and mushroom:IsA("Part") then
                local distance = (mushroom.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance <= Radius and distance < closestDistance then
                    closestMushroom = mushroom
                    closestDistance = distance
                end
            end
        end
        
        if closestMushroom then
            local tweenInfo = TweenInfo.new(TweenSpd, Enum.EasingStyle.Linear)
            local tween = TweenService:Create(Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(closestMushroom.Position)})
            tween:Play()
            tween.Completed:Wait()
            
            local args = {
                [1] = {
                    ["player"] = game:GetService("Players").LocalPlayer,
                    ["tukiqepvhyyBj"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nFOenfsq",
                    ["model"] = closestMushroom
                }
            }
            
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_HARVEST_CROP_REQUEST:InvokeServer(unpack(args))
        end
        task.wait(1)
    end
end)
BlareLib:CreateNotification("Island Script Initiated", "Welcome " .. PlayerName .. "!", 2)