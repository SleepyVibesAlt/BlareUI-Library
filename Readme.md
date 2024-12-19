## Blare Library Made & Managed By Sleepyvibes
## Repository: https://github.com/SleepyVibesAlt/BlareUI-Library
## License: MIT
## This is the only verified repository for the BlareUI Library.

## Update
```lua
--> Added Toggle
--> Added Keybinds
--> Added Dropdown
--> Added Notification
--> Drag Mobile Supported
--> Added Key System
```

## To Be Added
```lua

```

## Getting Loadstring
```lua
local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()```

## Creating UI Library Window
```lua
local win = BlareLib:Create({
    Name = "Blare Library",
    UseKey = true,
    Key = "12345",
    StartupSound = {
        PlaySound = true,
        SoundID = "rbxassetid://6958727243",
        TimePosition = 1
    }
}) --> Name, UseKey, Key, PlaySound, SoundID, TimeBeforePlay
--> The key with be DEFAULT_KEY is not added already.
```

## Creating Tab
```lua
local maintab = win:Tab('Main')
```

## Creating Section
```lua
maintab:Section('Section 1')
```

## Creating Label
```lua
maintab:Label('Label Name', 'Label Text') --> The label name is specifically used for the edit label function which requires the label name to be the same to edit.
```

## Edit Label
```lua
maintab:EditLabel('Label Name', 'New Text')
--> Label Name, New Text
```

## Creating Button
```lua
maintab:Button('Button Name', function()
    print('Button Pressed')
end) --> Name, CallBack
```

## Creating Keybind
```lua
maintab:Keybind('Keybind Text', Enum.KeyCode.F, function(key)
    print("New keybind:", key)
end) --> Default, Key, CallBack
```

## Creating Toggle
```lua
maintab:Toggle('Toggle Text', function(state)
    print("Toggle state:", state)
end) --> Default, CallBack
```
## Creating Notification
```lua
BlareLib:CreateNotification("Success", "Operation completed successfully!", 3)
--> Title, Description, Duration
```

## Creating Slider
```lua
maintab:Slider('Slider Text', 50, 0, 100, function(value)
    print("Slider value:", value)
end) --> Default, Min, Max, CallBack
```

## Creating Dropdown
```lua
maintab:Dropdown('Dropdown Text', {'Option 1', 'Option 2', 'Option 3'}, function(selected)
    print("Selected:", selected)
end) --> Default, Options, CallBack
```

## Creating Textbox
```lua
maintab:Textbox('Textbox Text', function(text)
    print("Input text:", text)
end) --> Default, CallBack
```

## Creating Separator
```lua
maintab:Separator()
```

## Exit
```lua
win:Exit()
```