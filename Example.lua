local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()
assert(BlareLib, "Failed to load BlareLib")

local win = BlareLib:Create({
    Name = "Example Script",

    KeySettings = {
        UseKey = true,
        Key = "2",
        GrabFromSite = true,
        Site = "https://pastebin.com/raw/D2RWz0XT",
        Comment = "The key is 1 if GrabFromSite is off it is 2",
        Discord = "https://discord.gg/yourserver",
        KeyLink = "https://linkvertise.com/yourkey",
        ToggleUI = Enum.KeyCode.LeftAlt
    },
    
    StartupSound = {
        Toggle = true,
        SoundID = "rbxassetid://6958727243",
        TimePosition = 1
    }
})

local maintab = win:Tab('Main')
local charactertab = win:Tab('Character')
local uitab = win:Tab('UI')
local combattab = win:Tab('Combat')
local visualstab = win:Tab('Visuals')
local misctab = win:Tab('Misc')
local settingstab = win:Tab('Settings')
local teleporttab = win:Tab('Teleport')
local farmtab = win:Tab('Farming')
local playertab = win:Tab('Player')
local weaponstab = win:Tab('Weapons')

local autotab = win:Tab('Auto')uitab:Button('Destroy GUI', function()
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

maintab:Comment('This is a comment')

BlareLib:CreateNotification("Success", "1!", 3)
BlareLib:CreateNotification("Success", "Operation completed successfully!", 3)

maintab:Keybind('Keybind Text', Enum.KeyCode.F, function(key)
    print("Keybind used")
end)

maintab:Separator()
maintab:Section('Section 1')

task.wait(10)

win:ReactiveNotification("Confirm Action", "Are you sure you want to proceed?"):Connect(function(confirmed)
    if confirmed then
        print("User clicked confirm")
    else
        print("User clicked deny")
    end
end)