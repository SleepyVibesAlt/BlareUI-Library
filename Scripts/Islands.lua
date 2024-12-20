local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()
assert(BlareLib, "Failed to load BlareLib")

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local PlayerName = Player.Name
local Health = Humanoid.Health
local MaxHealth = Humanoid.MaxHealth
local TweenService = game:GetService("TweenService")

local win = BlareLib:Create({
    Name = "Islands Script",
    UseKey = true,
    Key = "123456",
    Comment = "Key = 123456"
    StartupSound = {
        Toggle = true,
        SoundID = "rbxassetid://6958727243",
        TimePosition = 1,
    },
    Discord = "https://discord.gg/yourserver", 
    KeyLink = "https://linkvertise.com/yourkey"
})

local function MoveToTarget(targetPosition)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        if ShouldGoto then
            local startTime = tick()
            local function switchMovement()
                if tick() - startTime < 4 then
                    local tweenInfo = TweenInfo.new(
                        (character.HumanoidRootPart.Position - targetPosition).Magnitude / 35,
                        Enum.EasingStyle.Linear
                    )
                    
                    local tween = TweenService:Create(character.HumanoidRootPart, tweenInfo, {
                        CFrame = CFrame.new(targetPosition)
                    })
                    tween:Play()
                    return tween
                else
                    startTime = tick()
                    Humanoid:MoveTo(targetPosition)
                    return Humanoid.MoveToFinished
                end
            end
            return switchMovement()
        else
            Humanoid:MoveTo(targetPosition)
            return Humanoid.MoveToFinished
        end
    end
end
-- Settings Tab
local SettingsTab = win:Tab('Settings')

SettingsTab:Section('Movement Settings')
SettingsTab:Toggle('Auto Tween', function(v)
    ShouldGoto = v
end)

SettingsTab:Toggle('Anti-Cheat Debuffer', function(v)
    local noclip = v
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    local function updateNoclip()
        if noclip then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA('BasePart') and part ~= rootPart then
                    part.CanCollide = false
                end
            end
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
            humanoid:ChangeState(11)
            workspace.Gravity = 0
        else
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA('BasePart') then
                    part.CanCollide = true
                end
            end
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
            humanoid:ChangeState(7)
            workspace.Gravity = 196.2
        end
    end
    
    local connection
    connection = game:GetService('RunService').Heartbeat:Connect(function()
        if character and character:FindFirstChild("Humanoid") then
            updateNoclip()
        else
            if connection then
                connection:Disconnect()
            end
        end
    end)
end)

SettingsTab:Comment('When using Auto-Tween enable the Anti-Cheat Debuffer.')
SettingsTab:Comment('Anti-Cheat Debuffer in BETA.')

local Distance = 300

SettingsTab:Section('Range Settings')
SettingsTab:Textbox('Search Distance', function(value)
    local newDistance = tonumber(value)
    if newDistance then
        Distance = newDistance
        print("Distance set to:", Distance)
        BlareLib:CreateNotification("Distance Updated", "Search Distance set to: " .. Distance, 2)
    else
        BlareLib:CreateNotification("Invalid Input", "Please enter a number!", 3)
    end
end)
SettingsTab:Comment('Lower or Disable some settings to reduce Anti-Cheat detection')

-- AutoFarm Tab
local ResourceTab = win:Tab('Resource Farming')
ResourceTab:Section('Ores')

ResourceTab:Toggle('Iron Ore', function(v)
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
                if distance <= Distance and distance < closestDistance then
                    closestRock = rock
                    closestDistance = distance
                end
            end
        end
        
        if closestRock then
            local movement = MoveToTarget(closestRock.Position)
            if ShouldGoto then
                movement.Completed:Wait()
            else
                movement:Wait()
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
        task.wait(0.1)
    end
end)

ResourceTab:Toggle('Eletrite Ore', function(v)
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
                if distance <= Distance and distance < closestDistance then
                    closestRock = rock
                    closestDistance = distance
                end
            end
        end
        
        if closestRock then
            local movement = MoveToTarget(closestRock.Position)
            if ShouldGoto then
                movement.Completed:Wait()
            else
                movement:Wait()
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
        task.wait(0.1)
    end
end)

ResourceTab:Section('Stones')

ResourceTab:Toggle('Slate Rock', function(v)
    print("Slate Rock toggled:", v)
    wait(1)
    SlateRock = v
    while SlateRock do
        local rocks = workspace:GetDescendants()
        local closestRock = nil
        local closestDistance = math.huge
        
        for _, rock in pairs(rocks) do
            if rock.Name == "rockSlate" and rock:IsA("Part") then
                local distance = (rock.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance <= Distance and distance < closestDistance then
                    closestRock = rock
                    closestDistance = distance
                end
            end
        end
        
        if closestRock then
            local movement = MoveToTarget(closestRock.Position)
            if ShouldGoto then
                movement.Completed:Wait()
            else
                movement:Wait()
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
        task.wait(0.1)
    end
end)

ResourceTab:Toggle('Marble Rock', function(v)
    print("Marble Rock toggled:", v)
    wait(1)
    MarbleRock = v
    while MarbleRock do
        local rocks = workspace:GetDescendants()
        local closestRock = nil
        local closestDistance = math.huge
        
        for _, rock in pairs(rocks) do
            if rock.Name == "rockMarble" and rock:IsA("Part") then
                local distance = (rock.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance <= Distance and distance < closestDistance then
                    closestRock = rock
                    closestDistance = distance
                end
            end
        end
        
        if closestRock then
            local movement = MoveToTarget(closestRock.Position)
            if ShouldGoto then
                movement.Completed:Wait()
            else
                movement:Wait()
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
        task.wait(0.1)
    end
end)

ResourceTab:Toggle('Obsidian Rock', function(v)
    print("Obsidian Rock toggled:", v)
    wait(1)
    ObsidianRock = v
    while ObsidianRock do
        local rocks = workspace:GetDescendants()
        local closestRock = nil
        local closestDistance = math.huge
        
        for _, rock in pairs(rocks) do
            if rock.Name == "rockObsidian" and rock:IsA("Part") then
                local distance = (rock.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance <= Distance and distance < closestDistance then
                    closestRock = rock
                    closestDistance = distance
                end
            end
        end
        
        if closestRock then
            local movement = MoveToTarget(closestRock.Position)
            if ShouldGoto then
                movement.Completed:Wait()
            else
                movement:Wait()
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
        task.wait(0.1)
    end
end)
local MobFarmTab = win:Tab('Mob Farm')
MobFarmTab:Comment('Please equip your sword before enabling and also go to the island first.')

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
                if distance < closestDistance and distance <= Distance then
                    closestSlime = slime
                    closestDistance = distance
                end
            end
        end
        
        if closestSlime then
            while closestSlime:FindFirstChild("Humanoid") and closestSlime.Humanoid.Health > 0 and SlimeFarm do
                local movement = MoveToTarget(closestSlime.HumanoidRootPart.Position)
                if ShouldGoto then
                    movement.Completed:Wait()
                else
                    movement:Wait()
                end
                
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestSlime.HumanoidRootPart.Position)
                
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait(0.1)
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait(0.1)
            end
            print("Slime defeated!")
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Toggle('Farm slimeKing', function(v)
    local Slimes = game.workspace.WildernessIsland.Entities
    SlimeKingFarm = v
    while SlimeKingFarm do
        local closestSlime = nil
        local closestDistance = math.huge
        
        for _, slime in pairs(Slimes:GetChildren()) do
            if slime.Name == "slimeKing" and slime:FindFirstChild("Humanoid") and slime.Humanoid.Health > 0 and SlimeKingFarm then
                local distance = (slime.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance <= Distance then
                    closestSlime = slime
                    closestDistance = distance
                end
            end
        end
        
        if closestSlime then
            while closestSlime:FindFirstChild("Humanoid") and closestSlime.Humanoid.Health > 0 and SlimeKingFarm do
                local movement = MoveToTarget(closestSlime.HumanoidRootPart.Position)
                if ShouldGoto then
                    movement.Completed:Wait()
                else
                    movement:Wait()
                end
                
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestSlime.HumanoidRootPart.Position)
                
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait(0.1)
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait(0.1)
            end
            print("Slime King defeated!")
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Section('Buffalkor Island')
MobFarmTab:Toggle('Farm buffalkor', function(v)
    local Entities = game.workspace.WildernessIsland.Entities
    BuffalkorFarm = v
    while BuffalkorFarm do
        local closestBuffalkor = nil
        local closestDistance = math.huge
        
        for _, mob in pairs(Entities:GetChildren()) do
            if mob.Name == "buffalkor" and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and BuffalkorFarm then
                local distance = (mob.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance <= Distance then
                    closestBuffalkor = mob
                    closestDistance = distance
                end
            end
        end
        
        if closestBuffalkor then
            while closestBuffalkor:FindFirstChild("Humanoid") and closestBuffalkor.Humanoid.Health > 0 and BuffalkorFarm do
                local movement = MoveToTarget(closestBuffalkor.HumanoidRootPart.Position)
                if ShouldGoto then
                    movement.Completed:Wait()
                else
                    movement:Wait()
                end
                
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestBuffalkor.HumanoidRootPart.Position)
                
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait(0.1)
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait(0.1)
            end
            print("Buffalkor defeated!")
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Section('Wizard Island')
MobFarmTab:Toggle('Farm Lizard Wizard', function(v)
    local Entities = game.workspace.WildernessIsland.Entities
    WizardFarm = v
    while WizardFarm do
        local closestWizard = nil
        local closestDistance = math.huge
        
        for _, mob in pairs(Entities:GetChildren()) do
            if mob.Name == "wizardLizard" and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and WizardFarm then
                local distance = (mob.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance <= Distance then
                    closestWizard = mob
                    closestDistance = distance
                end
            end
        end
        
        if closestWizard then
            while closestWizard:FindFirstChild("Humanoid") and closestWizard.Humanoid.Health > 0 and WizardFarm do
                local movement = MoveToTarget(closestWizard.HumanoidRootPart.Position)
                if ShouldGoto then
                    movement.Completed:Wait()
                else
                    movement:Wait()
                end
                
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestWizard.HumanoidRootPart.Position)
                
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait(0.1)
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait(0.1)
            end
            print("Wizard Lizard defeated!")
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Toggle('Farm Wizard Boss', function(v)
    local Entities = game.workspace.WildernessIsland.Entities
    WizardBossFarm = v
    while WizardBossFarm do
        local closestWizardBoss = nil
        local closestDistance = math.huge
        
        for _, mob in pairs(Entities:GetChildren()) do
            if mob.Name == "wizardBoss" and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and WizardBossFarm then
                local distance = (mob.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance <= Distance then
                    closestWizardBoss = mob
                    closestDistance = distance
                end
            end
        end
        
        if closestWizardBoss then
            while closestWizardBoss:FindFirstChild("Humanoid") and closestWizardBoss.Humanoid.Health > 0 and WizardBossFarm do
                local movement = MoveToTarget(closestWizardBoss.HumanoidRootPart.Position)
                if ShouldGoto then
                    movement.Completed:Wait()
                else
                    movement:Wait()
                end
                
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestWizardBoss.HumanoidRootPart.Position)
                
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait(0.1)
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait(0.1)
            end
            print("Wizard Boss defeated!")
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Section('Pirate Island')

MobFarmTab:Toggle('Farm Skeleton Pirate', function(v)
    local Entities = game.workspace.WildernessIsland.Entities
    PirateFarm = v
    while PirateFarm do
        local closestPirate = nil
        local closestDistance = math.huge
        
        for _, mob in pairs(Entities:GetChildren()) do
            if mob.Name == "skeletonPirate" and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and PirateFarm then
                local distance = (mob.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance <= Distance then
                    closestPirate = mob
                    closestDistance = distance
                end
            end
        end
        
        if closestPirate then
            while closestPirate:FindFirstChild("Humanoid") and closestPirate.Humanoid.Health > 0 and PirateFarm do
                local movement = MoveToTarget(closestPirate.HumanoidRootPart.Position)
                if ShouldGoto then
                    movement.Completed:Wait()
                else
                    movement:Wait()
                end
                
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestPirate.HumanoidRootPart.Position)
                
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait(0.1)
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait(0.1)
            end
            print("Pirate defeated!")
        end
        task.wait(0.1)
    end
end)

BlareLib:CreateNotification("Island Script Initiated", "Welcome " .. PlayerName .. ", we hope u enjoy!", 2)