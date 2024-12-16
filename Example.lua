local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()

local win = BlareLib:Create({
    Name = "Blare Library",
    StartupSound = {
        Toggle = true,
        SoundID = "rbxassetid://6958727243",
        TimePosition = 1
    }
})

local maintab = win:Tab('Main')
local charactertab = win:Tab('Character')
local uitab = win:Tab('UI')

uitab:Button('Destroy GUI', function()
    win:Exit()
end)

maintab:Toggle('Aimbot', function(isEnabled)
    aimbot = isEnabled
    print("Aimbot toggled:", isEnabled)
end)

maintab:Textbox('FOV', function(value)
    fov = tonumber(value)
    print("FOV set to:", fov)
end)

maintab:Slider('FOV', 30, 0, 120, function(value)
    fov = value
    print("FOV adjusted to:", value)
end)

maintab:Label('info_label', 'This is a label')

maintab:Dropdown("Select Option", {"Option 1", "Option 2", "Option 3"}, function(selected)
    print("Selected: " .. selected)
end)

maintab:Button('Edit Label', function()
    maintab:EditLabel('info_label', 'Updated Label Text')
    print("Label text updated.")
end)

maintab:Dropdown("Select Option", {"Option 1", "Option 2", "Option 3"}, function(selected)
    print("Selected: " .. selected)
end)

maintab:Comment('This is a comment')

maintab:Separator()
maintab:Section('Section 1')

maintab:Keybind('Keybind Text', Enum.KeyCode.F, function(key)
    print("New keybind:", key)
end)