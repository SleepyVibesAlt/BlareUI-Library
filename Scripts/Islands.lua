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

BlareLib:CreateNotification("Island Script Initiated", "Welcome " .. PlayerName .. "!", 4)