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

win:SetStatus("Loading...", Color3.fromRGB(255, 255, 0))

local AutoFarmTab = win:Tab('AutoFarms')
AutoFarmTab:Section('Settings')
AutoFarmTab:Toggle('Auto Goto', function(v)
    ShouldGoto = v
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
            if ShouldGoto then
                Humanoid:MoveTo(closestRock.Position)
                Humanoid.MoveToFinished:Wait()
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
            if ShouldGoto then
                Humanoid:MoveTo(closestRock.Position)
                Humanoid.MoveToFinished:Wait()
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

local SearchDistance = 300

MobFarmTab:Textbox('Search Distance', function(value)
    local newDistance = tonumber(value)
    if newDistance then
        SearchDistance = newDistance
        print("Search Distance set to:", SearchDistance)
        BlareLib:CreateNotification("Distance Updated", "Search Distance set to: " .. SearchDistance, 2)
    else
        BlareLib:CreateNotification("Invalid Input", "Please enter a number!", 3)
    end
end)

MobFarmTab:Comment('Please equip your sword before enabling and also go to the island first. Sometimes the autofarm might bug the gui due to the automatic clicking!')
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
                if distance < closestDistance and distance <= SearchDistance then
                    closestSlime = slime
                    closestDistance = distance
                end
            end
        end
       
        if closestSlime then
            while closestSlime:FindFirstChild("Humanoid") and closestSlime.Humanoid.Health > 0 and SlimeFarm do
                Humanoid:MoveTo(closestSlime.HumanoidRootPart.Position)
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestSlime.HumanoidRootPart.Position)
               
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait()
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait()
            end
            print("Slime defeated!")
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Toggle('Farm Slimes', function(v)
    local Slimes = game.workspace.WildernessIsland.Entities
    SlimeFarm = v
    while SlimeFarm do
        local closestSlime = nil
        local closestDistance = math.huge
       
        for _, slime in pairs(Slimes:GetChildren()) do
            if slime.Name == "slime" and slime:FindFirstChild("Humanoid") and slime.Humanoid.Health > 0 and SlimeFarm then
                local distance = (slime.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance <= SearchDistance then
                    closestSlime = slime
                    closestDistance = distance
                end
            end
        end
       
        if closestSlime then
            while closestSlime:FindFirstChild("Humanoid") and closestSlime.Humanoid.Health > 0 and SlimeFarm do
                Humanoid:MoveTo(closestSlime.HumanoidRootPart.Position)
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestSlime.HumanoidRootPart.Position)
                local EntityUUID = slime.EntityUUID
                local args = {
                    [1] = EntityUUID,
                    [2] = {
                        [1] = {
                            ["UiItXhnkf"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nTwudhybaivliemzqrcNmf",
                            ["hitUnit"] = workspace.WildernessIsland.Entities[slime]
                        }
                    }
                }
                
                game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("jiqEhnmoMV/ZlgessyomwyEX"):FireServer(unpack(args))
                print(EntityUUID)
                print("Remote fired!")
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
                if distance < closestDistance and distance <= SearchDistance then
                    closestSlime = slime
                    closestDistance = distance
                end
            end
        end
       
        if closestSlime then
            while closestSlime:FindFirstChild("Humanoid") and closestSlime.Humanoid.Health > 0 and SlimeKingFarm do
                Humanoid:MoveTo(closestSlime.HumanoidRootPart.Position)
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestSlime.HumanoidRootPart.Position)
               
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait()
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait()
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
                if distance < closestDistance and distance <= SearchDistance then
                    closestBuffalkor = mob
                    closestDistance = distance
                end
            end
        end
       
        if closestBuffalkor then
            while closestBuffalkor:FindFirstChild("Humanoid") and closestBuffalkor.Humanoid.Health > 0 and BuffalkorFarm do
                Humanoid:MoveTo(closestBuffalkor.HumanoidRootPart.Position)
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestBuffalkor.HumanoidRootPart.Position)
               
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
                task.wait()
                virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
                task.wait()
            end
            print("Buffalkor defeated!")
        end
        task.wait(0.1)
    end
end)

BlareLib:CreateNotification("Island Script Initiated", "Welcome " .. PlayerName .. ", we hope u enjoy!", 2)