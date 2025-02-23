local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()
assert(BlareLib, "Failed to load BlareLib")

local win = BlareLib:Create({
    Name = "Basketball Script",
    KeySettings = {
        UseKey = false,
        Key = "",
        GrabFromSite = false,
        Site = "",
        Comment = "The key is 1 if GrabFromSite is off it is 2",
        Discord = "https://discord.gg/yourserver",
        KeyLink = "https://linkvertise.com/yourkey"
    },
    
    StartupSound = {
        Toggle = true,
        SoundID = "rbxassetid://6958727243",
        TimePosition = 1
    }
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local maintab = win:Tab('Main', 'rbxassetid://6034837797')

maintab:Toggle('Infinite Range', function(isEnabled)
    local Hitbox = game:GetService("Workspace")[LocalPlayer.Name]:FindFirstChild("Hitbox")
    Hitbox.Size = isEnabled and Vector3.new(1000, 1000, 1000) or Vector3.new(7, 6.5, 2.5)
end)

maintab:Toggle('Sprint Speed & JumpHeight', function(isEnabled)
    LocalPlayer.Character.Humanoid.JumpHeight = isEnabled and 85 or 50
    LocalPlayer.Character.Humanoid.WalkSpeed = isEnabled and 26 or 16
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    if maintab.Toggles["Sprint Speed & JumpHeight"].Value then
        humanoid.JumpHeight = 85
        humanoid.WalkSpeed = 26
    else
        humanoid.JumpHeight = 50
        humanoid.WalkSpeed = 16
    end
end)

game:GetService("Workspace").ChildAdded:Connect(function(child)
    if child.Name == LocalPlayer.Name then
        local hitbox = child:WaitForChild("Hitbox")
        if maintab.Toggles["Infinite Range"].Value then
            hitbox.Size = Vector3.new(1000, 1000, 1000)
        else
            hitbox.Size = Vector3.new(7, 6.5, 2.5)
        end
    end
end)