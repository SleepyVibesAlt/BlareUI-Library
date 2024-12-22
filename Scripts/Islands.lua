local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()
assert(BlareLib, "Failed to load BlareLib")

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local PlayerName = Player.Name
local Health = Character:WaitForChild("CurrentHealth").Value
local MaxHealth = Character:WaitForChild("MaxHealth").Value
local TweenService = game:GetService("TweenService")

local win = BlareLib:Create({
    Name = "Islands Script",
    UseKey = false,
    Key = "1",
    Comment = "The key is 1",
    StartupSound = {
        Toggle = true,
        SoundID = "rbxassetid://6958727243",
        TimePosition = 1
    },
    Discord = "https://discord.gg/yourserver", 
    KeyLink = "https://linkvertise.com/yourkey"
})

local function MoveToTarget(targetPosition)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        if ShouldGoto then
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
            Humanoid:MoveTo(targetPosition)
            return Humanoid.MoveToFinished
        end
    end
end

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
            
            -- Apply zero gravity to character parts only
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA('BasePart') then
                    part.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0, 0, 1, 1)
                end
            end
        else
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA('BasePart') then
                    part.CanCollide = true
                    -- Reset physical properties
                    part.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1)
                end
            end
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
            humanoid:ChangeState(7)
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


BlareLib:CreateNotification("Island Script Initiated", "Welcome " .. PlayerName .. ", we hope u enjoy!", 2)