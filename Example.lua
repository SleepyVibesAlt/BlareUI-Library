local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()
assert(BlareLib, "Failed to load BlareLib")

local win = BlareLib:Create({
    Name = "Example Script",
    KeySettings = {
        UseKey = true,
        Key = "2",
        GrabFromSite = true,
        Site = "https://pastebin.com/raw/D2RWz0XT",
        Comment = "The key is 2 if grafromsite is disabled",
        Discord = "https://discord.gg/yourserver",
        KeyLink = "https://linkvertise.com/yourkey"
    },
    
    StartupSound = {
        Toggle = true,
        SoundID = "rbxassetid://6958727243",
        TimePosition = 1
    }
})

local maintab = win:Tab('Main', 'rbxassetid://6034837797')
local charactertab = win:Tab('Character', 'rbxassetid://6034287594')
local uitab = win:Tab('UI', 'rbxassetid://6034509993')

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

maintab:Comment('This is a comment')

BlareLib:CreateNotification("Success", "Operation completed successfully!", 3)

maintab:Keybind('Keybind Text', Enum.KeyCode.F, function(key)
    print("New keybind:", key)
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