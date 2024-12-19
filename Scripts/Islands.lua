local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local PlayerName = Player.Name
local Health = Humanoid.Health
local MaxHealth = Humanoid.MaxHealth
local TweenService = game:GetService("TweenService")

local win = BlareLib:Create({
    Name = "Islands Script",
    StartupSound = {
        Toggle = true,
        SoundID = "rbxassetid://6958727243",
        TimePosition = 1
    }
})

local PathfindingService = game:GetService("PathfindingService")

local path = PathfindingService:CreatePath({
    AgentRadius = 5,
    AgentHeight = 7,
    AgentCanJump = true,
    WaypointSpacing = 4,
    Costs = {
        Water = 50,
        Jump = 5
    }
})

local function smartMoveTo(destination)
    local currentDistance = (Character.HumanoidRootPart.Position - destination).Magnitude
    if currentDistance < 5 then return end

    local success, errorMessage = pcall(function()
        path:ComputeAsync(Character.HumanoidRootPart.Position, destination)
    end)

    if success and path.Status == Enum.PathStatus.Success then
        local waypoints = path:GetWaypoints()
        
        for i, waypoint in ipairs(waypoints) do
            if i > 1 then
                local targetPosition = waypoint.Position + Vector3.new(0, 0.5, 0)
                Humanoid:MoveTo(targetPosition)
                local reachedWaypoint = Humanoid.MoveToFinished:Wait()
                if not reachedWaypoint then
                    Humanoid.Jump = true
                    task.wait(0.2)
                    if (Character.HumanoidRootPart.Position - targetPosition).Magnitude > 3 then
                        local sideStep = CFrame.new(Character.HumanoidRootPart.Position) * CFrame.new(3, 0, 0)
                        Humanoid:MoveTo(sideStep.Position)
                        task.wait(0.2)
                    end
                end
                if (destination - Character.HumanoidRootPart.Position).Magnitude < 5 then
                    break
                end
            end
        end
    end
end


local AutoFarmTab = win:Tab('AutoFarms')
AutoFarmTab:Section('Setting')
local Radius = 50
AutoFarmTab:Toggle('Auto Goto', function(v)
    ShouldGoto = v
end)

AutoFarmTab:Toggle('Anti-Stuck', function(v)
    AntiStuck = v
    while AntiStuck do
        Character.HumanoidRootPart.CanCollide = false
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        wait(5)
        if not AntiStuck then break end
        Character.HumanoidRootPart.CanCollide = true
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        wait(5)
    end
    Character.HumanoidRootPart.CanCollide = true
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end)

AutoFarmTab:Textbox('Auto-Mine Detect Radius', function(value)
    local newRadius = tonumber(value)
    if newRadius then
        Radius = newRadius
        print("Radius set to:", Radius)
        BlareLib:CreateNotification("Radius Updated", "Radius set to: " .. Radius, 2)
    else
        BlareLib:CreateNotification("Invalid Input", "Please enter a number, words don't work!", 3)
    end
end)

AutoFarmTab:Textbox('Walk Speed', function(value)
    local newSpeed = tonumber(value)
    if newSpeed then
        _G.WalkSpeedValue = newSpeed
        if not _G.WalkSpeedLoop then
            _G.WalkSpeedLoop = true
            spawn(function()
                while _G.WalkSpeedLoop do
                    if Humanoid then
                        Humanoid.WalkSpeed = _G.WalkSpeedValue
                    end
                    task.wait()
                end
            end)
        end
        print("Walk Speed set to:", newSpeed)
        BlareLib:CreateNotification("Speed Updated", "Walk Speed set to: " .. newSpeed, 2)
    else
        BlareLib:CreateNotification("Invalid Input", "Please enter a number!", 3)
    end
end)

AutoFarmTab:Section('Resource Farming')

AutoFarmTab:Toggle('Iron Ore', function(v)
    print("Iron Ore toggled:", v)
    wait(1)
    IronOre = v
    local currentTarget = nil
    
    while IronOre do
        if not currentTarget or not currentTarget:IsA("Part") then
            local rocks = workspace:GetDescendants()
            local closestDistance = math.huge
            
            for _, rock in pairs(rocks) do
                if rock.Name == "rockIron" and rock:IsA("Part") then
                    local distance = (rock.Position - Character.HumanoidRootPart.Position).Magnitude
                    if distance <= Radius and distance < closestDistance then
                        currentTarget = rock
                        closestDistance = distance
                    end
                end
            end
        end
        
        if currentTarget then
            if ShouldGoto then
                smartMoveTo(currentTarget.Position)
            end
            local args = {
                [1] = {
                    ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                    ["part"] = currentTarget:FindFirstChild("1"),
                    ["block"] = currentTarget,
                    ["norm"] = currentTarget.Position,
                    ["pos"] = currentTarget.Position - Character.HumanoidRootPart.Position
                }
            }
            
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
        end
        task.wait(0.2)
    end
end)

AutoFarmTab:Toggle('Eletrite Ore', function(v)
    print("Eletrite Ore toggled:", v)
    wait(1)
    EletriteOre = v
    local currentTarget = nil
    
    while EletriteOre do
        if not currentTarget or not currentTarget:IsA("Part") then
            local rocks = workspace:GetDescendants()
            local closestDistance = math.huge
            
            for _, rock in pairs(rocks) do
                if rock.Name == "rockElectrite" and rock:IsA("Part") then
                    local distance = (rock.Position - Character.HumanoidRootPart.Position).Magnitude
                    if distance <= Radius and distance < closestDistance then
                        currentTarget = rock
                        closestDistance = distance
                    end
                end
            end
        end
        
        if currentTarget then
            if ShouldGoto then
                smartMoveTo(currentTarget.Position)
            end
            local args = {
                [1] = {
                    ["xkpOrfvithbzcvKundjsvoamBnpkqBsXm"] = "\7\240\159\164\163\240\159\164\161\7\n\7\n\7\nkyaxebDphmkcyha",
                    ["part"] = currentTarget:FindFirstChild("1"),
                    ["block"] = currentTarget,
                    ["norm"] = currentTarget.Position,
                    ["pos"] = currentTarget.Position - Character.HumanoidRootPart.Position
                }
            }
            
            game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
        end
        task.wait(0.2)
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
    local currentTarget = nil
    
    while SlimeFarm do
        if not currentTarget or not currentTarget:FindFirstChild("Humanoid") or currentTarget.Humanoid.Health <= 0 then
            local closestDistance = math.huge
            for _, slime in pairs(Slimes:GetChildren()) do
                if slime.Name == "slime" and slime:FindFirstChild("Humanoid") and slime.Humanoid.Health > 0 then
                    local distance = (slime.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                    if distance < closestDistance and distance <= SearchDistance then
                        currentTarget = slime
                        closestDistance = distance
                    end
                end
            end
        end
        
        if currentTarget and currentTarget:FindFirstChild("Humanoid") and currentTarget.Humanoid.Health > 0 then
            smartMoveTo(currentTarget.HumanoidRootPart.Position)
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, currentTarget.HumanoidRootPart.Position)
            
            local virtualInput = game:GetService("VirtualInputManager")
            virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
            task.wait(0.2)
            virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
            task.wait(0.2)
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Toggle('Farm slimeKing', function(v)
    local Slimes = game.workspace.WildernessIsland.Entities
    SlimeKingFarm = v
    local currentTarget = nil
    
    while SlimeKingFarm do
        if not currentTarget or not currentTarget:FindFirstChild("Humanoid") or currentTarget.Humanoid.Health <= 0 then
            local closestDistance = math.huge
            for _, slime in pairs(Slimes:GetChildren()) do
                if slime.Name == "slimeKing" and slime:FindFirstChild("Humanoid") and slime.Humanoid.Health > 0 then
                    local distance = (slime.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                    if distance < closestDistance and distance <= SearchDistance then
                        currentTarget = slime
                        closestDistance = distance
                    end
                end
            end
        end
        
        if currentTarget and currentTarget:FindFirstChild("Humanoid") and currentTarget.Humanoid.Health > 0 then
            smartMoveTo(currentTarget.HumanoidRootPart.Position)
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, currentTarget.HumanoidRootPart.Position)
            
            local virtualInput = game:GetService("VirtualInputManager")
            virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
            task.wait(0.2)
            virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
            task.wait(0.2)
        end
        task.wait(0.1)
    end
end)

MobFarmTab:Section('Buffalkor Island')

MobFarmTab:Toggle('Farm buffalkor', function(v)
    local Entities = game.workspace.WildernessIsland.Entities
    BuffalkorFarm = v
    local currentTarget = nil
    
    while BuffalkorFarm do
        if not currentTarget or not currentTarget:FindFirstChild("Humanoid") or currentTarget.Humanoid.Health <= 0 then
            local closestDistance = math.huge
            for _, mob in pairs(Entities:GetChildren()) do
                if mob.Name == "buffalkor" and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    local distance = (mob.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                    if distance < closestDistance and distance <= SearchDistance then
                        currentTarget = mob
                        closestDistance = distance
                    end
                end
            end
        end
        
        if currentTarget and currentTarget:FindFirstChild("Humanoid") and currentTarget.Humanoid.Health > 0 then
            smartMoveTo(currentTarget.HumanoidRootPart.Position)
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, currentTarget.HumanoidRootPart.Position)
            
            local virtualInput = game:GetService("VirtualInputManager")
            virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, true, game, 1)
            task.wait(0.2)
            virtualInput:SendMouseButtonEvent(game.Workspace.CurrentCamera.ViewportSize.X/2, game.Workspace.CurrentCamera.ViewportSize.Y/2, 0, false, game, 1)
            task.wait(0.2)
        end
        task.wait(0.1)
    end
end)

BlareLib:CreateNotification("Island Script Initiated", "Welcome " .. PlayerName .. ", we hope u enjoy!", 2)