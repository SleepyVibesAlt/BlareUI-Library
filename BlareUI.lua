--// Destroy other instances
for _,v in pairs(game.CoreGui:GetChildren()) do
    if v.Name == "dark_UI" then
        v:Destroy()
    end
end

local dark_UI = Instance.new("ScreenGui")
dark_UI.Name = "dark_UI"
dark_UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
dark_UI.Parent = game.CoreGui

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HTTPService = game:GetService("HttpService")

local Library = {}

function Library:Create(table)
    local windowName = table.Name
    local useKey = table.UseKey or false
    local key = table.Key or "DEFAULT_KEY"

    local main = Instance.new("Frame")
    main.Name = "main"
    main.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    main.Position = UDim2.fromScale(0.244, 0.292)
    main.Size = UDim2.fromOffset(488, 299)
    main.Parent = dark_UI

    if useKey then
        main.Visible = false
        
        local keyFrame = Instance.new("Frame")
        keyFrame.Name = "keySystem"
        keyFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        keyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        keyFrame.Size = UDim2.fromOffset(400, 200)
        keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        keyFrame.Parent = dark_UI
        
        local keyGradient = Instance.new("UIGradient")
        keyGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 28)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
        })
        keyGradient.Parent = keyFrame
        
        local keyCorner = Instance.new("UICorner")
        keyCorner.CornerRadius = UDim.new(0, 6)
        keyCorner.Parent = keyFrame
        
        local keyTitle = Instance.new("TextLabel")
        keyTitle.Name = "title"
        keyTitle.Font = Enum.Font.GothamBold
        keyTitle.Text = windowName .. " Key System"
        keyTitle.TextColor3 = Color3.fromRGB(168, 168, 168)
        keyTitle.TextSize = 22
        keyTitle.BackgroundTransparency = 1
        keyTitle.Position = UDim2.fromScale(0.5, 0.1)
        keyTitle.Size = UDim2.fromOffset(300, 28)
        keyTitle.AnchorPoint = Vector2.new(0.5, 0)
        keyTitle.Parent = keyFrame
    
        local keySubtitle = Instance.new("TextLabel")
        keySubtitle.Font = Enum.Font.Gotham
        keySubtitle.Text = "Enter your key to access " .. windowName
        keySubtitle.TextColor3 = Color3.fromRGB(120, 120, 120)
        keySubtitle.TextSize = 14
        keySubtitle.BackgroundTransparency = 1
        keySubtitle.Position = UDim2.fromScale(0.5, 0.25)
        keySubtitle.Size = UDim2.fromOffset(300, 20)
        keySubtitle.AnchorPoint = Vector2.new(0.5, 0)
        keySubtitle.Parent = keyFrame
    
        local keyInput = Instance.new("TextBox")
        keyInput.Size = UDim2.new(0.8, 0, 0, 35)
        keyInput.Position = UDim2.new(0.5, 0, 0.45, 0)
        keyInput.AnchorPoint = Vector2.new(0.5, 0)
        keyInput.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
        keyInput.PlaceholderText = "Enter Key"
        keyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
        keyInput.Text = ""
        keyInput.TextColor3 = Color3.fromRGB(195, 195, 195)
        keyInput.Font = Enum.Font.GothamSemibold
        keyInput.TextSize = 19
        keyInput.Parent = keyFrame
        
        local keyInputPadding = Instance.new("UIPadding")
        keyInputPadding.PaddingLeft = UDim.new(0, 10)
        keyInputPadding.Parent = keyInput
    
        local keyInputCorner = Instance.new("UICorner")
        keyInputCorner.CornerRadius = UDim.new(0, 6)
        keyInputCorner.Parent = keyInput
    
        local keyButton = Instance.new("TextButton")
        keyButton.Size = UDim2.new(0.3, 0, 0, 35)
        keyButton.Position = UDim2.new(0.5, 0, 0.75, 0)
        keyButton.AnchorPoint = Vector2.new(0.5, 0)
        keyButton.BackgroundColor3 = Color3.fromRGB(45,45,45)
        keyButton.Text = "Submit"
        keyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        keyButton.Font = Enum.Font.GothamBold
        keyButton.TextSize = 14
        keyButton.Parent = keyFrame
        
        local keyButtonCorner = Instance.new("UICorner")
        keyButtonCorner.CornerRadius = UDim.new(0, 6)
        keyButtonCorner.Parent = keyButton
    
        local getKeyButton = Instance.new("TextButton")
        getKeyButton.Size = UDim2.new(0.3, 0, 0, 35)
        getKeyButton.Position = UDim2.new(0.8, 0, 0.75, 0)
        getKeyButton.AnchorPoint = Vector2.new(0.5, 0)
        getKeyButton.BackgroundColor3 = Color3.fromRGB(23, 143, 75)
        getKeyButton.Text = "Get Key"
        getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        getKeyButton.Font = Enum.Font.GothamBold
        getKeyButton.TextSize = 14
        getKeyButton.Parent = keyFrame
    
        local getKeyCorner = Instance.new("UICorner")
        getKeyCorner.CornerRadius = UDim.new(0, 6)
        getKeyCorner.Parent = getKeyButton
    
        local discordButton = Instance.new("TextButton")
        discordButton.Size = UDim2.new(0.3, 0, 0, 35)
        discordButton.Position = UDim2.new(0.2, 0, 0.75, 0)
        discordButton.AnchorPoint = Vector2.new(0.5, 0)
        discordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        discordButton.Text = "Discord"
        discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        discordButton.Font = Enum.Font.GothamBold
        discordButton.TextSize = 14
        discordButton.Parent = keyFrame    
        local discordCorner = Instance.new("UICorner")
        discordCorner.CornerRadius = UDim.new(0, 6)
        discordCorner.Parent = discordButton

        local Toggle = Instance.new("TextButton")
        Toggle.Name = "Toggle"
        Toggle.Size = UDim2.new(0, 160, 0, 20)
        Toggle.Position = UDim2.new(0.5, -90, 0, -36)
        Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Toggle.BackgroundTransparency = 0.5
        Toggle.Text = "Toggle Ui"
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.TextSize = 12
        Toggle.Visible = false
        Toggle.Parent = dark_UI
        Toggle.Font = Enum.Font.Gotham

        Toggle.MouseButton1Click:Connect(function()
            main.Visible = not main.Visible
        end)
    
        getKeyButton.MouseButton1Click:Connect(function()
            setclipboard(table.KeyLink)
            Library:CreateNotification("Success", "Key link copied to clipboard!", 2)
        end)
    
        discordButton.MouseButton1Click:Connect(function()
            setclipboard(table.Discord)
            Library:CreateNotification("Success", "Discord link copied to clipboard!", 2)
        end)
    
        keyButton.MouseButton1Click:Connect(function()
            if keyInput.Text == key then
                keyFrame:Destroy()
                Library:CreateNotification("Success", "Key Verified!", 2)
                main.Visible = true
                Toggle.Visible = true
            else
                Library:CreateNotification("Error", "Invalid Key!", 2)
            end
        end)
    end
    
    local title = Instance.new("TextLabel")
    title.Name = "title"
    title.Font = Enum.Font.Gotham
    title.Text = windowName
    title.TextColor3 = Color3.fromRGB(168, 168, 168)
    title.TextSize = 20
    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Position = UDim2.fromScale(0.41, 0.0543)
    title.Size = UDim2.fromOffset(83, 28)
    title.Parent = main

    local uICorner = Instance.new("UICorner")
    uICorner.Name = "uICorner"
    uICorner.Parent = main

    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "tabContainer"
    tabContainer.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    tabContainer.Position = UDim2.fromScale(0.0342, 0.188)
    tabContainer.Size = UDim2.fromOffset(454, 30)

    local uICorner1 = Instance.new("UICorner")
    uICorner1.Name = "uICorner1"
    uICorner1.CornerRadius = UDim.new(0, 6)
    uICorner1.Parent = tabContainer

    local uIListLayout = Instance.new("UIListLayout")
    uIListLayout.Name = "uIListLayout"
    uIListLayout.Padding = UDim.new(0, 8)
    uIListLayout.FillDirection = Enum.FillDirection.Horizontal
    uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uIListLayout.Parent = tabContainer

    local uIPadding = Instance.new("UIPadding")
    uIPadding.Name = "uIPadding"
    uIPadding.PaddingLeft = UDim.new(0, 7)
    uIPadding.PaddingTop = UDim.new(0, 4)
    uIPadding.Parent = tabContainer

    tabContainer.Parent = main
    main.AnchorPoint = Vector2.new(0.5,0.5)
    main.Position = UDim2.new(0.5,0,0.5,0)

    local UICorner15 = Instance.new("UICorner")
    UICorner15.Name = "UICorner2"
    UICorner15.Parent = Toggle   

    local tabHandler = {}

    function tabHandler:Exit()
        dark_UI:Destroy()
    end

    function tabHandler:Tab(name)
        --// Creating the yttab
        local main1 = Instance.new("TextButton")
        main1.Name = name
        main1.Font = Enum.Font.Gotham
        main1.Text = name
        main1.TextColor3 = Color3.fromRGB(195, 195, 195)
        main1.TextSize = 13
        main1.TextTransparency = 0.5
        main1.AutomaticSize = Enum.AutomaticSize.X
        main1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        main1.BackgroundTransparency = 1
        main1.Size = UDim2.fromOffset(10, 24)
        main1.Parent = tabContainer

        --// Creating the container
        local container = Instance.new("Frame")
        container.Name = "container"
        container.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
        container.Position = UDim2.fromScale(0.0342, 0.31)
        container.Size = UDim2.fromOffset(454, 183)
        
        local uICorner2 = Instance.new("UICorner")
        uICorner2.Name = "uICorner2"
        uICorner2.CornerRadius = UDim.new(0, 6)
        uICorner2.Parent = container
        
        local holder = Instance.new("ScrollingFrame")
        holder.Name = "holder"
        holder.ScrollBarImageColor3 = Color3.fromRGB(76, 76, 76)
        holder.ScrollBarThickness = 2
        holder.ScrollingDirection = Enum.ScrollingDirection.Y
        holder.Active = true
        holder.AutomaticCanvasSize = Enum.AutomaticSize.Y
        holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        holder.BackgroundTransparency = 1
        holder.BorderColor3 = Color3.fromRGB(33, 33, 33)
        holder.Position = UDim2.fromScale(0.0022, 0.00404)
        holder.Size = UDim2.fromOffset(452, 182)
        holder.CanvasSize = UDim2.fromOffset(0, 0)


        local uIPadding1 = Instance.new("UIPadding")
        uIPadding1.Name = "uIPadding1"
        uIPadding1.PaddingLeft = UDim.new(0, 5)
        uIPadding1.PaddingTop = UDim.new(0, 7)
        uIPadding1.Parent = holder

        local uIListLayout1 = Instance.new("UIListLayout")
        uIListLayout1.Name = "uIListLayout1"
        uIListLayout1.Padding = UDim.new(0, 3)
        uIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
        uIListLayout1.Parent = holder

        local uICorner11 = Instance.new("UICorner")
        uICorner11.Name = "uICorner11"
        uICorner11.CornerRadius = UDim.new(0, 6)
        uICorner11.Parent = holder

        holder.Parent = container
        container.Parent = main
        container.Visible = false

        --// Event
        main1.MouseButton1Click:Connect(function()
            for _,v in pairs(game.CoreGui:FindFirstChild('dark_UI').main:GetChildren()) do
                if v.Name == "container" then
                    v.Visible = false
                end
            end
            for _,v in pairs(game.CoreGui['dark_UI'].main.tabContainer:GetChildren()) do
                if v:IsA('TextButton') then
                    game:GetService('TweenService'):Create(v, TweenInfo.new(0.3), {TextTransparency = 0.5}):Play()
                end
            end
            container.Visible = true
            game:GetService('TweenService'):Create(main1, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        end)

        --// Elements
        local ElementHandler = {}

        function ElementHandler:Label(Name, text)
            local label = Instance.new("Frame")
            label.Name = Name
            label.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            label.Size = UDim2.fromOffset(441, 32)
            label.Parent = holder
    
            local uICorner3 = Instance.new("UICorner")
            uICorner3.Name = "uICorner3"
            uICorner3.CornerRadius = UDim.new(0, 6)
            uICorner3.Parent = label

            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "textLabel"
            textLabel.Font = Enum.Font.Gotham
            textLabel.Text = text
            textLabel.TextColor3 = Color3.fromRGB(195, 195, 195)
            textLabel.TextSize = 13
            textLabel.TextStrokeColor3 = Color3.fromRGB(195, 195, 195)
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textLabel.BackgroundTransparency = 1
            textLabel.Position = UDim2.fromScale(0.0181, 0)
            textLabel.Size = UDim2.fromOffset(1, 32)
            textLabel.Parent = label
        end

        function ElementHandler:EditLabel(Name, text)
            local Label = holder:WaitForChild(Name)
            local textLabel = Label:WaitForChild("textLabel")
            textLabel.Text = text
        end

        function ElementHandler:Section(text)
            local section = Instance.new("Frame")
            section.Name = "section"
            section.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
            section.Size = UDim2.fromOffset(441, 36)
            
            local sectionTitle = Instance.new("TextLabel")
            sectionTitle.Name = "sectionTitle"
            sectionTitle.Font = Enum.Font.GothamBold
            sectionTitle.Text = text
            sectionTitle.TextColor3 = Color3.fromRGB(195, 195, 195)
            sectionTitle.TextSize = 14
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.Position = UDim2.fromScale(0.0181, 0)
            sectionTitle.Size = UDim2.fromOffset(441, 36)
            sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            sectionTitle.Parent = section
            
            local uICorner = Instance.new("UICorner")
            uICorner.CornerRadius = UDim.new(0, 6)
            uICorner.Parent = section
            
            section.Parent = holder
        end

        function ElementHandler:Keybind(text, default, callback)
            text = text or "Keybind"
            default = default or Enum.KeyCode.Unknown
            callback = callback or function() end
            
            local keybind = Instance.new("Frame")
            keybind.Name = "keybind"
            keybind.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            keybind.Size = UDim2.fromOffset(441, 32)
            
            local uICorner = Instance.new("UICorner")
            uICorner.CornerRadius = UDim.new(0, 6)
            uICorner.Parent = keybind
            
            local title = Instance.new("TextLabel")
            title.Name = "title"
            title.Font = Enum.Font.Gotham
            title.Text = text
            title.TextColor3 = Color3.fromRGB(195, 195, 195)
            title.TextSize = 13
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.BackgroundTransparency = 1
            title.Position = UDim2.fromScale(0.0181, 0)
            title.Size = UDim2.fromOffset(1, 32)
            title.Parent = keybind
            
            local bindButton = Instance.new("TextButton")
            bindButton.Name = "bindButton"
            bindButton.Font = Enum.Font.Gotham
            bindButton.Text = default.Name
            bindButton.TextColor3 = Color3.fromRGB(195, 195, 195)
            bindButton.TextSize = 13
            bindButton.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
            bindButton.Position = UDim2.fromScale(0.864, 0.188)
            bindButton.Size = UDim2.fromOffset(52, 19)
            bindButton.AutoButtonColor = false
            
            local uICorner2 = Instance.new("UICorner")
            uICorner2.CornerRadius = UDim.new(0, 6)
            uICorner2.Parent = bindButton
            
            bindButton.Parent = keybind
            keybind.Parent = holder
            
            local binding = false
            local currentKey = default
            
            bindButton.MouseButton1Click:Connect(function()
                binding = true
                bindButton.Text = "..."
            end)
            
            UserInputService.InputBegan:Connect(function(input)
                if binding and input.UserInputType == Enum.UserInputType.Keyboard then
                    binding = false
                    currentKey = input.KeyCode
                    bindButton.Text = currentKey.Name
                    callback(currentKey)
                end
            end)
            
            return {
                GetKey = function()
                    return currentKey
                end,
                SetKey = function(key)
                    currentKey = key
                    bindButton.Text = key.Name
                end
            }
        end        
        
        function ElementHandler:Separator()
            local separator = Instance.new("Frame")
            separator.Name = "separator"
            separator.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            separator.Size = UDim2.fromOffset(441, 4)
            separator.Parent = holder
            
            local uICorner = Instance.new("UICorner")
            uICorner.CornerRadius = UDim.new(0, 6)
            uICorner.Parent = separator
        end        

        function ElementHandler:Button(text, callback)
            text = text or "Button"
            callback = callback or function() end

            local button = Instance.new("TextButton")
            button.Name = "button"
            button.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            button.Position = UDim2.fromScale(0, 0.135)
            button.Size = UDim2.fromOffset(441, 32)
            button.Text = ""
            button.AutoButtonColor = false

            local uICorner12 = Instance.new("UICorner")
            uICorner12.Name = "uICorner12"
            uICorner12.CornerRadius = UDim.new(0, 6)
            uICorner12.Parent = button

            local textLabel5 = Instance.new("TextLabel")
            textLabel5.Name = "textLabel5"
            textLabel5.Font = Enum.Font.Gotham
            textLabel5.Text = text
            textLabel5.TextColor3 = Color3.fromRGB(195, 195, 195)
            textLabel5.TextSize = 13
            textLabel5.TextStrokeColor3 = Color3.fromRGB(195, 195, 195)
            textLabel5.TextXAlignment = Enum.TextXAlignment.Left
            textLabel5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textLabel5.BackgroundTransparency = 1
            textLabel5.Position = UDim2.fromScale(0.0181, 0)
            textLabel5.Size = UDim2.fromOffset(1, 32)
            textLabel5.Parent = button

            local imageLabel = Instance.new("ImageLabel")
            imageLabel.Name = "imageLabel"
            imageLabel.Image = "http://www.roblox.com/asset/?id=9584292194"
            imageLabel.ImageColor3 = Color3.fromRGB(195, 195, 195)
            imageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            imageLabel.BackgroundTransparency = 1
            imageLabel.Position = UDim2.fromScale(0.943, 0.219)
            imageLabel.Size = UDim2.fromOffset(18, 18)
            imageLabel.Parent = button

            button.Parent = holder

            button.MouseEnter:Connect(function()
                game:GetService('TweenService'):Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(43,43,43)}):Play()
            end)

            button.MouseLeave:Connect(function()
                game:GetService('TweenService'):Create(button, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(38,38,38)}):Play()
            end)

            button.MouseButton1Click:Connect(function()
                callback()
            end)
        end

        function ElementHandler:Dropdown(text, list, callback)
            text = text or "Dropdown"
            list = list or {}
            callback = callback or function() end
        
            local dropdown = Instance.new("Frame")
            dropdown.Name = "dropdown"
            dropdown.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            dropdown.Size = UDim2.fromOffset(441, 32)
            dropdown.ZIndex = 1
        
            local uICorner = Instance.new("UICorner")
            uICorner.CornerRadius = UDim.new(0, 6)
            uICorner.Parent = dropdown
        
            local dropButton = Instance.new("TextButton")
            dropButton.Name = "dropButton"
            dropButton.BackgroundTransparency = 1
            dropButton.Size = UDim2.fromScale(1, 1)
            dropButton.Text = ""
            dropButton.ZIndex = 2
            dropButton.Parent = dropdown
        
            local title = Instance.new("TextLabel")
            title.Name = "title"
            title.Font = Enum.Font.Gotham
            title.Text = text
            title.TextColor3 = Color3.fromRGB(195, 195, 195)
            title.TextSize = 13
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.BackgroundTransparency = 1
            title.Position = UDim2.fromScale(0.0181, 0)
            title.Size = UDim2.fromOffset(1, 32)
            title.ZIndex = 2
            title.Parent = dropdown
        
            local arrow = Instance.new("ImageLabel")
            arrow.Name = "arrow"
            arrow.Image = "rbxassetid://6034818372"
            arrow.ImageColor3 = Color3.fromRGB(195, 195, 195)
            arrow.BackgroundTransparency = 1
            arrow.Position = UDim2.fromScale(0.943, 0.219)
            arrow.Size = UDim2.fromOffset(18, 18)
            arrow.ZIndex = 2
            arrow.Parent = dropdown
        
            local selectedText = Instance.new("TextLabel")
            selectedText.Name = "selectedText"
            selectedText.Font = Enum.Font.Gotham
            selectedText.Text = "None"
            selectedText.TextColor3 = Color3.fromRGB(195, 195, 195)
            selectedText.TextSize = 13
            selectedText.TextXAlignment = Enum.TextXAlignment.Right
            selectedText.BackgroundTransparency = 1
            selectedText.Position = UDim2.fromScale(-0.7, 0)
            selectedText.Size = UDim2.fromOffset(125, 32)
            selectedText.ZIndex = 2
            selectedText.Parent = dropdown
        
            local dropFrame = Instance.new("Frame")
            dropFrame.Name = "dropFrame"
            dropFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            dropFrame.Position = UDim2.fromOffset(0, 40)
            dropdown.Size = UDim2.fromOffset(441, 32)
            dropFrame.ClipsDescendants = true
            dropFrame.Visible = false
            dropFrame.ZIndex = 1
            dropFrame.Parent = holder
        
            local uICornerDrop = Instance.new("UICorner")
            uICornerDrop.CornerRadius = UDim.new(0, 6)
            uICornerDrop.Parent = dropFrame
        
            local itemHolder = Instance.new("Frame")
            itemHolder.Name = "itemHolder"
            itemHolder.BackgroundTransparency = 1
            itemHolder.Size = UDim2.fromScale(1, 1)
            itemHolder.ZIndex = 51
            itemHolder.Parent = dropFrame
        
            local itemList = Instance.new("UIListLayout")
            itemList.SortOrder = Enum.SortOrder.LayoutOrder
            itemList.Padding = UDim.new(0, 3)
            itemList.HorizontalAlignment = Enum.HorizontalAlignment.Center
            itemList.Parent = itemHolder   
                 
            local padding = Instance.new("UIPadding")
            padding.PaddingTop = UDim.new(0, 5)
            padding.PaddingBottom = UDim.new(0, 5)
            padding.Parent = itemHolder
        
            local dropped = false
        
            local function createItem(itemText)
                local item = Instance.new("TextButton")
                item.Name = itemText
                item.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                item.Size = UDim2.new(1, -10, 0, 30)
                item.Position = UDim2.fromScale(0, 0)
                item.Text = itemText
                item.TextColor3 = Color3.fromRGB(195, 195, 195)
                item.TextSize = 13
                item.Font = Enum.Font.Gotham
                item.ZIndex = 51
                item.AutoButtonColor = false
                
                local itemCorner = Instance.new("UICorner")
                itemCorner.CornerRadius = UDim.new(0, 6)
                itemCorner.Parent = item
                
                item.Parent = itemHolder
        
                item.MouseEnter:Connect(function()
                    game:GetService('TweenService'):Create(item, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(43,43,43)}):Play()
                end)
        
                item.MouseLeave:Connect(function()
                    game:GetService('TweenService'):Create(item, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(33,33,33)}):Play()
                end)
        
                item.MouseButton1Click:Connect(function()
                    selectedText.Text = itemText
                    callback(itemText)
                    dropped = false
                    game:GetService('TweenService'):Create(arrow, TweenInfo.new(0.3), {Rotation = 0}):Play()
                    game:GetService('TweenService'):Create(dropFrame, TweenInfo.new(0.2), {Size = UDim2.fromOffset(441, 0)}):Play()
                    wait(0.2)
                    dropFrame.Visible = false
                end)
            end
        
            for _, item in ipairs(list) do
                createItem(item)
            end
        
            dropButton.MouseEnter:Connect(function()
                game:GetService('TweenService'):Create(dropdown, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(43,43,43)}):Play()
            end)
        
            dropButton.MouseLeave:Connect(function()
                game:GetService('TweenService'):Create(dropdown, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(38,38,38)}):Play()
            end)
        
            dropButton.MouseButton1Click:Connect(function()
                dropped = not dropped
                dropFrame.Visible = true
                if dropped then
                    game:GetService('TweenService'):Create(arrow, TweenInfo.new(0.3), {Rotation = 180}):Play()
                    game:GetService('TweenService'):Create(dropFrame, TweenInfo.new(0.2), {Size = UDim2.fromOffset(441, (#list * 35) + 10)}):Play()
                else
                    game:GetService('TweenService'):Create(arrow, TweenInfo.new(0.3), {Rotation = 0}):Play()
                    game:GetService('TweenService'):Create(dropFrame, TweenInfo.new(0.2), {Size = UDim2.fromOffset(441, 0)}):Play()
                    wait(0.2)
                    dropFrame.Visible = false
                end
            end)
        
            dropdown.Parent = holder
            return dropdown
        end        

        function Library:CreateNotification(title, description, duration)
            duration = duration or 3
            
            local notifContainer = Instance.new("TextButton")  -- Changed to TextButton
            notifContainer.Name = "NotificationContainer"
            notifContainer.Size = UDim2.new(0, 250, 0, 80)
            notifContainer.Position = UDim2.new(1, -260, 1, -90)
            notifContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
            notifContainer.Text = ""  -- Empty text for button
            notifContainer.AutoButtonColor = false  -- Disable button color change
            notifContainer.Parent = dark_UI
            
            local uICorner = Instance.new("UICorner")
            uICorner.CornerRadius = UDim.new(0, 6)
            uICorner.Parent = notifContainer
            
            -- Title
            local titleLabel = Instance.new("TextLabel")
            titleLabel.Name = "Title"
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.Text = title
            titleLabel.TextColor3 = Color3.fromRGB(195, 195, 195)
            titleLabel.TextSize = 14
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.BackgroundTransparency = 1
            titleLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
            titleLabel.Size = UDim2.new(0.9, 0, 0, 20)
            titleLabel.Parent = notifContainer
            
            -- Description
            local descLabel = Instance.new("TextLabel")
            descLabel.Name = "Description"
            descLabel.Font = Enum.Font.Gotham
            descLabel.Text = description
            descLabel.TextColor3 = Color3.fromRGB(195, 195, 195)
            descLabel.TextSize = 13
            descLabel.TextXAlignment = Enum.TextXAlignment.Left
            descLabel.TextWrapped = true
            descLabel.BackgroundTransparency = 1
            descLabel.Position = UDim2.new(0.05, 0, 0.4, 0)
            descLabel.Size = UDim2.new(0.9, 0, 0.5, 0)
            descLabel.Parent = notifContainer
            
            -- Progress bar
            local progressBar = Instance.new("Frame")
            progressBar.Name = "ProgressBar"
            progressBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            progressBar.Position = UDim2.new(0, 0, 0.95, 0)
            progressBar.Size = UDim2.new(1, 0, 0, 3)
            progressBar.Parent = notifContainer
            
            local progress = Instance.new("Frame")
            progress.Name = "Progress"
            progress.BackgroundColor3 = Color3.fromRGB(195, 195, 195)
            progress.Size = UDim2.new(1, 0, 1, 0)
            progress.Parent = progressBar
            
            -- Animations
            notifContainer.Position = UDim2.new(1, 0, 1, -90)
            local tweenIn = TweenService:Create(notifContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -260, 1, -90)})
            local tweenOut = TweenService:Create(notifContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(1, 0, 1, -90)})
            local progressTween = TweenService:Create(progress, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)})
            
            tweenIn:Play()
            progressTween:Play()
            
            local function closeNotification()
                tweenOut:Play()
                tweenOut.Completed:Wait()
                notifContainer:Destroy()
            end
            
            notifContainer.MouseButton1Click:Connect(closeNotification)
            
            task.delay(duration, closeNotification)
        end        
        function ElementHandler:Slider(text, default, min, max, callback)
            text = text or "Slider"
            callback = callback or function() end

            local slider = Instance.new("TextButton")
            slider.Name = "slider"
            slider.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            slider.Size = UDim2.fromOffset(441, 32)
            slider.Text = ""
            slider.AutoButtonColor = false

            local uICorner4 = Instance.new("UICorner")
            uICorner4.Name = "uICorner4"
            uICorner4.CornerRadius = UDim.new(0, 6)
            uICorner4.Parent = slider

            local textLabel1 = Instance.new("TextLabel")
            textLabel1.Name = "textLabel1"
            textLabel1.Font = Enum.Font.Gotham
            textLabel1.Text = text
            textLabel1.TextColor3 = Color3.fromRGB(195, 195, 195)
            textLabel1.TextSize = 13
            textLabel1.TextStrokeColor3 = Color3.fromRGB(195, 195, 195)
            textLabel1.TextXAlignment = Enum.TextXAlignment.Left
            textLabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textLabel1.BackgroundTransparency = 1
            textLabel1.Position = UDim2.fromScale(0.0181, 0)
            textLabel1.Size = UDim2.fromOffset(1, 32)
            textLabel1.Parent = slider

            local frame = Instance.new("Frame")
            frame.Name = "frame"
            frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
            frame.Position = UDim2.fromScale(0.753, 0.375)
            frame.Size = UDim2.fromOffset(102, 8)

            local uICorner5 = Instance.new("UICorner")
            uICorner5.Name = "uICorner5"
            uICorner5.CornerRadius = UDim.new(0, 3)
            uICorner5.Parent = frame

            local frame1 = Instance.new("Frame")
            frame1.Name = "frame1"
            frame1.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            frame1.Position = UDim2.fromScale(-0.00207, 0)
            frame1.Size = UDim2.fromOffset(44, 8)

            local uICorner6 = Instance.new("UICorner")
            uICorner6.Name = "uICorner6"
            uICorner6.CornerRadius = UDim.new(0, 3)
            uICorner6.Parent = frame1

            frame1.Parent = frame

            frame.Parent = slider

            local textLabel2 = Instance.new("TextLabel")
            textLabel2.Name = "textLabel2"
            textLabel2.Font = Enum.Font.Gotham
            textLabel2.Text = "7"
            textLabel2.TextColor3 = Color3.fromRGB(195, 195, 195)
            textLabel2.TextSize = 13
            textLabel2.TextStrokeColor3 = Color3.fromRGB(195, 195, 195)
            textLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textLabel2.BackgroundTransparency = 1
            textLabel2.Position = UDim2.fromScale(0.653, 0)
            textLabel2.Size = UDim2.fromOffset(44, 32)
            textLabel2.Parent = slider

            slider.Parent = holder
            textLabel2.Text = tostring(default)

            local hovered = false
            local down = false

            slider.MouseEnter:Connect(function()
                hovered = true
                game:GetService('TweenService'):Create(slider, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(43,43,43)}):Play()
            end)

            slider.MouseLeave:Connect(function()
                if not down then
                    game:GetService('TweenService'):Create(slider, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(38,38,38)}):Play()
                end
            end)
    
            game:GetService('UserInputService').InputEnded:connect(function(key)
                if key.UserInputType == Enum.UserInputType.MouseButton1 then
                    down = false
                    game:GetService('TweenService'):Create(slider, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(38,38,38)}):Play()
                end
            end)
    
            slider.MouseButton1Down:connect(function()
                game:GetService('TweenService'):Create(slider, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(47,47,47)}):Play()
                down = true
                while RunService.RenderStepped:wait() and down do
                    local percentage = math.clamp((Mouse.X - frame1.AbsolutePosition.X) / (frame1.AbsoluteSize.X), 0, 1)
                    local value = ((max - min) * percentage) + min
                    value = math.floor(value)
                    textLabel2.Text = value
                    local tween = game:GetService('TweenService'):Create(frame1, TweenInfo.new(0.06), {Size = UDim2.fromScale(percentage, 1)}):Play()
                    callback(value)
                end
            end)
            slider.MouseButton1Up:connect(function()
                down = false
            end)
           
        end
        
        function ElementHandler:Toggle(text, callback)
            text = text or "Toggle"
            callback = callback or function() end
        
            local toggle1 = Instance.new("TextButton")
            toggle1.Name = "toggle1"
            toggle1.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            toggle1.Size = UDim2.fromOffset(441, 32)
            toggle1.Text = ""
            toggle1.AutoButtonColor = false
        
            local uICorner9 = Instance.new("UICorner")
            uICorner9.Name = "uICorner9"
            uICorner9.CornerRadius = UDim.new(0, 6)
            uICorner9.Parent = toggle1
        
            local textLabel4 = Instance.new("TextLabel")
            textLabel4.Name = "textLabel4"
            textLabel4.Font = Enum.Font.Gotham
            textLabel4.Text = text
            textLabel4.TextColor3 = Color3.fromRGB(195, 195, 195)
            textLabel4.TextSize = 13
            textLabel4.TextStrokeColor3 = Color3.fromRGB(195, 195, 195)
            textLabel4.TextXAlignment = Enum.TextXAlignment.Left
            textLabel4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textLabel4.BackgroundTransparency = 1
            textLabel4.Position = UDim2.fromScale(0.0181, 0)
            textLabel4.Size = UDim2.fromOffset(1, 32)
            textLabel4.Parent = toggle1
        
            local frame3 = Instance.new("Frame")
            frame3.Name = "frame3"
            frame3.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            frame3.Position = UDim2.fromScale(0.943, 0.219)
            frame3.Size = UDim2.fromOffset(18, 18)
        
            local uICorner10 = Instance.new("UICorner")
            uICorner10.Name = "uICorner10"
            uICorner10.CornerRadius = UDim.new(0, 3)
            uICorner10.Parent = frame3
        
            local uIStroke1 = Instance.new("UIStroke")
            uIStroke1.Name = "uIStroke1"
            uIStroke1.Color = Color3.fromRGB(76, 76, 76)
            uIStroke1.Parent = frame3
        
            frame3.Parent = toggle1
            toggle1.Parent = holder
        
            local toggleState = false
        
            toggle1.MouseEnter:Connect(function()
                game:GetService('TweenService'):Create(toggle1, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(43,43,43)}):Play()
            end)
        
            toggle1.MouseLeave:Connect(function()
                game:GetService('TweenService'):Create(toggle1, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(38,38,38)}):Play()
            end)
        
            toggle1.MouseButton1Click:Connect(function()
                toggleState = not toggleState
                
                if toggleState then
                    game:GetService('TweenService'):Create(frame3, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(23, 143, 75)}):Play()
                    game:GetService('TweenService'):Create(uIStroke1, TweenInfo.new(0.2), {Color = Color3.fromRGB(32, 202, 106)}):Play()
                else
                    game:GetService('TweenService'):Create(frame3, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                    game:GetService('TweenService'):Create(uIStroke1, TweenInfo.new(0.2), {Color = Color3.fromRGB(76, 76, 76)}):Play()
                end
        
                task.spawn(function()
                    callback(toggleState)
                end)
            end)         
        
            return {
                SetState = function(state)
                    toggleState = state
                    if toggleState then
                        frame3.BackgroundColor3 = Color3.fromRGB(23, 143, 75)
                        uIStroke1.Color = Color3.fromRGB(32, 202, 106)
                    else
                        frame3.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                        uIStroke1.Color = Color3.fromRGB(76, 76, 76)
                    end
                    callback(toggleState)
                end,
                GetState = function()
                    return toggleState
                end
            }
        end
        
        function ElementHandler:Comment(text)
            local comment = Instance.new("TextLabel")
            comment.Name = "comment"
            comment.Font = Enum.Font.Gotham
            comment.Text = text
            comment.TextColor3 = Color3.fromRGB(114, 114, 114)
            comment.TextSize = 11
            comment.TextXAlignment = Enum.TextXAlignment.Left
            comment.BackgroundTransparency = 1
            comment.Size = UDim2.fromOffset(441, 20)
            comment.Parent = holder
            
            local listLayout = holder:FindFirstChildWhichIsA('UIListLayout')
            if listLayout then
                holder.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
            end
        end        

        function ElementHandler:Textbox(text, callback)
            text = text or "Textbox"
            callback = callback or function() end

            local textbox = Instance.new("Frame")
            textbox.Name = "textbox"
            textbox.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            textbox.Size = UDim2.fromOffset(441, 32)

            local uICorner13 = Instance.new("UICorner")
            uICorner13.Name = "uICorner13"
            uICorner13.CornerRadius = UDim.new(0, 6)
            uICorner13.Parent = textbox

            local textLabel6 = Instance.new("TextLabel")
            textLabel6.Name = "textLabel6"
            textLabel6.Font = Enum.Font.Gotham
            textLabel6.Text = text
            textLabel6.TextColor3 = Color3.fromRGB(195, 195, 195)
            textLabel6.TextSize = 13
            textLabel6.TextStrokeColor3 = Color3.fromRGB(195, 195, 195)
            textLabel6.TextXAlignment = Enum.TextXAlignment.Left
            textLabel6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            textLabel6.BackgroundTransparency = 1
            textLabel6.Position = UDim2.fromScale(0.0181, 0)
            textLabel6.Size = UDim2.fromOffset(1, 32)
            textLabel6.Parent = textbox

            local textBox = Instance.new("TextBox")
            textBox.Name = "textBox"
            textBox.Font = Enum.Font.SourceSans
            textBox.Text = ""
            textBox.TextColor3 = Color3.fromRGB(195, 195, 195)
            textBox.TextSize = 12
            textBox.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
            textBox.Position = UDim2.fromScale(0.864, 0.188)
            textBox.Size = UDim2.fromOffset(52, 19)

            local uICorner14 = Instance.new("UICorner")
            uICorner14.Name = "uICorner14"
            uICorner14.CornerRadius = UDim.new(0, 6)
            uICorner14.Parent = textBox

            textBox.Parent = textbox
            textbox.Parent = holder

            textbox.MouseEnter:Connect(function()
                game:GetService('TweenService'):Create(textbox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(43,43,43)}):Play()
            end)

            textbox.MouseLeave:Connect(function()
                game:GetService('TweenService'):Create(textbox, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(38,38,38)}):Play()
            end)

            textBox.FocusLost:Connect(function()
                callback(textBox.Text)
            end)
        end

        return ElementHandler
    end

    local UIS = game:GetService("UserInputService")

    local dragging = false
    local dragStart = nil
    local startPos = nil

    local function startDrag(frame, input)
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end

    local function updateDrag(frame, input)
        if dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end

    local function makeDraggable(frame)
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                startDrag(frame, input)
            end
        end)

        frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                updateDrag(frame, input)
            end
        end)

        frame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end

    local DragFrames = {
        main,
        keyFrame,
    }

    for _, frame in ipairs(DragFrames) do
        if frame:IsA("Frame") or frame:IsA("ImageLabel") then
            makeDraggable(frame)
        end
    end
    game.CoreGui['dark_UI'].main.tabContainer.ChildAdded:Connect(function()
        game.CoreGui['dark_UI'].main:WaitForChild('container').Visible = true
        pcall(function()
            repeat wait() until game.CoreGui['dark_UI'].main:FindFirstChild('tabContainer'):FindFirstChildWhichIsA('TextButton')
        end)
        game:GetService('TweenService'):Create(game.CoreGui['dark_UI'].main:FindFirstChild('tabContainer'):FindFirstChildWhichIsA('TextButton'), TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    end)

    spawn(function()
        if table.StartupSound.PlaySound and table.StartupSound.SoundID ~= nil then
            local sound = Instance.new('Sound', game.CoreGui)
            sound.Name = "Startup Sound"
            sound.SoundId = "rbxassetid://6958727243"
            sound.Volume = 2
            sound.TimePosition = table.StartupSound.TimePosition
            sound:Play()
            sound.Stopped:Wait()
            sound:Destroy()
        end
    end)

    return tabHandler
end

local executor = "Unknown"
executor = getexecutorname()
print('===================================')
print('Welcome to BlareUi-Library')
print('Library Version 1.0.0')
print('Executor : '.. executor)
print('Status : Functional')
print('===================================')

return Library