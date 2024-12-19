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

local SettingsTab = win:Tab('Settings')
SettingsTab:Section('Global Settings')

SettingsTab:Toggle('Auto Goto', function(v)
    ShouldGoto = v
end)

SettingsTab:Textbox('Global Radius', function(value)
    local newRadius = tonumber(value)
    if newRadius then
        Radius = newRadius
        print("Radius set to:", Radius)
        BlareLib:CreateNotification("Radius Updated", "Radius set to: " .. Radius, 2)
    else
        BlareLib:CreateNotification("Invalid Input", "Please enter a number!", 3)
    end
end)

local AntiStuckEnabled = false
SettingsTab:Toggle('Anti-Stuck', function(v)
    AntiStuckEnabled = v
    if AntiStuckEnabled then
        spawn(function()
            while AntiStuckEnabled do
                local noclipConnection
                noclipConnection = game:GetService('RunService').Stepped:Connect(function()
                    if Character and Character:FindFirstChild("Humanoid") then
                        for _, part in pairs(Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
                
                wait(5)
                
                if noclipConnection then
                    noclipConnection:Disconnect()
                end
                
                wait(5)
                
                if not AntiStuckEnabled then break end
            end
        end)
    end
end)

SettingsTab:Comment('Anti-Stuck will toggle noclip every 5 seconds to help prevent getting stuck')

BlareLib:CreateNotification("Island Script Initiated", "Welcome " .. PlayerName .. ", we hope u enjoy!", 2)