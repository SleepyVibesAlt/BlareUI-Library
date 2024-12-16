## Blare Library Made & Managed By Sleepyvibes
## Repository: https://github.com/SleepyVibesAlt/BlareUI-Library
## License: MIT
## This is the only verified repository for the BlareUI Library.

## Update
```lua
- Added Textbox
- Added Seperator
- Fixed crashing
- Added Toggle
- Drag Mobile Supported
```

## Getting Loadstring
```lua
local BlareLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SleepyVibesAlt/BlareUI-Library/refs/heads/main/BlareUI.lua"))()```

## Create UI Library Window
```lua
local win = BlareLib:Create({
    Name = "Blare Library",
    StartupSound = {
        Toggle = true,
        SoundID = "rbxassetid://6958727243",
        TimePosition = 1
    }
})
```

## Create Tab
```lua
local maintab = win:Tab('Main')
```

## Create Section
```lua
maintab:Section('Section 1')
```

## Create Label
```lua
maintab:Label('Label Name', 'Label Text')
```

## Edit Label
```lua
maintab:EditLabel('Label Name', 'New Text')
```

## Create Button
```lua
maintab:Button('Button Name', function()
    print('Button Pressed')
end)
```

## Create Keybind
```lua
maintab:Keybind('Keybind Text', Enum.KeyCode.F, function(key)
    print("New keybind:", key)
end)


## Create Toggle
```lua
maintab:Toggle('Toggle Text', function(state)
    print("Toggle state:", state)
end)
```

## Create Slider
```lua
maintab:Slider('Slider Text', 50, 0, 100, function(value)
    print("Slider value:", value)
end)
```

## Create Dropdown
```lua
maintab:Dropdown('Dropdown Text', {'Option 1', 'Option 2', 'Option 3'}, function(selected)
    print("Selected:", selected)
end)
```

## Create Textbox
```lua
maintab:Textbox('Textbox Text', function(text)
    print("Input text:", text)
end)
```

## Create Seperator
```lua
maintab:Separator()
```

## Exit
```lua
win:Exit()
```