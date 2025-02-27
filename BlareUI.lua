local Version = "1.0.0"
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
local Active = false

local Library = {}

function Library:Create(table)
    local windowName = table.Name
    local keySettings = table.KeySettings or {}
    local useKey = keySettings.UseKey or false
    local key = keySettings.Key or "DEFAULT_KEY"
    local Comment = keySettings.Comment or "Enter your key to gain access."
    local Site = keySettings.Site
    local GrabFromSite = keySettings.GrabFromSite

    local main = Instance.new("Frame")
    main.Name = "main"
    main.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    main.Position = UDim2.fromScale(0.244, 0.292)
    main.Size = UDim2.fromOffset(586, 359)
    main.ClipsDescendants = true
    main.Parent = dark_UI

    if useKey then
        main.Visible = false
        if GrabFromSite then
            local httpRequest = syn and syn.request or (http and http.request) or nil
            
            if httpRequest then
                local response = httpRequest({
                    Url = Site,
                    Method = "GET"
                })
                if response.Success then
                    key = response.Body:gsub("[\n\r]", ""):gsub(" ", "")
                    print('===========================================')
                    print("Key System Status: Active")
                    print("Site Connection: Success") 
                    print("Fetched Key")
                    print('===========================================')
                else
                    print("Key System Status: Error")
                    print("Site Connection: Failed")
                    print("Status code:", response.StatusCode)
                    key = keySettings.Key
                end
            else
                print("Key System Status: Fallback")
                print("HTTP requests not supported - using default key")
                key = keySettings.Key
            end
        else
            Active = false
        end
        
        local keyFrame = Instance.new("Frame")
        keyFrame.Name = "keySystem"
        keyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
        keyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        keyFrame.Size = UDim2.fromOffset(480, 240)
        keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        keyFrame.Parent = dark_UI
        
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
        keySubtitle.Text = Comment
        keySubtitle.TextColor3 = Color3.fromRGB(120, 120, 120)
        keySubtitle.TextSize = 14
        keySubtitle.BackgroundTransparency = 1
        keySubtitle.Position = UDim2.fromScale(0.5, 0.25)
        keySubtitle.Size = UDim2.fromOffset(300, 20)
        keySubtitle.AnchorPoint = Vector2.new(0.5, 0)
        keySubtitle.Parent = keyFrame
    
        local keyInput = Instance.new("TextBox")
        keyInput.Size = UDim2.new(0.8, 0, 0, 42)
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
        keyButton.Size = UDim2.new(0.25, 0, 0, 42)
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
        getKeyButton.Size = UDim2.new(0.25, 0, 0, 42)
        getKeyButton.Position = UDim2.new(0.78, 0, 0.75, 0)
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
        discordButton.Size = UDim2.new(0.25, 0, 0, 42)
        discordButton.Position = UDim2.new(0.22, 0, 0.75, 0)
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
        Toggle.Size = UDim2.new(0, 192, 0, 24)
        Toggle.Position = UDim2.new(0.5, -90, 0, -36)
        Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Toggle.BackgroundTransparency = 0.5
        Toggle.Text = "Toggle Ui"
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.TextSize = 12
        Toggle.Visible = not useKey
        Toggle.Parent = dark_UI
        Toggle.Font = Enum.Font.Gotham

        local UICorner15 = Instance.new("UICorner")
        UICorner15.Name = "UICorner2"
        UICorner15.Parent = Toggle  

        local toggleKey = keySettings.ToggleUI or Enum.KeyCode.LeftAlt
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and Active and input.KeyCode == toggleKey then
                if main.Visible then
                    local slideOut = TweenService:Create(main,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                        {Position = UDim2.new(1.5, 0, 0.5, 0)}
                    )
                    slideOut:Play()
                    slideOut.Completed:Wait()
                    main.Visible = false
                else
                    main.Visible = true
                    main.Position = UDim2.new(-0.5, 0, 0.5, 0)
                    local slideIn = TweenService:Create(main,
                        TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {Position = UDim2.new(0.5, 0, 0.5, 0)}
                    )
                    slideIn:Play()
                end
            end
        end)     
                      
        getKeyButton.MouseButton1Click:Connect(function()
            setclipboard(keySettings.KeyLink)
            Library:CreateNotification("Success", "Key link copied to clipboard!", 2)
        end)
    
        discordButton.MouseButton1Click:Connect(function()
            setclipboard(keySettings.Discord)
            Library:CreateNotification("Success", "Discord link copied to clipboard!", 2)
        end)
    
        keyButton.MouseButton1Click:Connect(function()
            if keyInput.Text == key then
                keyFrame:Destroy()
                Library:CreateNotification("Success", "Key Verified!", 2)
                main.Visible = true
                Toggle.Visible = true
                Active = true
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

    local OtherToggle = Instance.new("TextButton")
    OtherToggle.Name = "Toggle"
    OtherToggle.Size = UDim2.new(0, 192, 0, 24)
    OtherToggle.Position = UDim2.new(0.5, -90, 0, -36)
    OtherToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    OtherToggle.BackgroundTransparency = 0.5
    OtherToggle.Text = "Toggle Ui"
    OtherToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    OtherToggle.TextSize = 12
    OtherToggle.Visible = not useKey
    OtherToggle.Parent = dark_UI
    OtherToggle.Font = Enum.Font.Gotham

    local UICorner15 = Instance.new("UICorner")
    UICorner15.Name = "UICorner2"
    UICorner15.Parent = OtherToggle  

    OtherToggle.MouseButton1Click:Connect(function()
        if main.Visible then
            local slideOut = TweenService:Create(main,
                TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                {Position = UDim2.new(1.5, 0, 0.5, 0)}
            )
            slideOut:Play()
            slideOut.Completed:Wait()
            main.Visible = false
        else
            main.Visible = true
            main.Position = UDim2.new(-0.5, 0, 0.5, 0)
            local slideIn = TweenService:Create(main,
                TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Position = UDim2.new(0.5, 0, 0.5, 0)}
            )
            slideIn:Play()
        end
    end)

    local tabContainerLook = Instance.new("Frame")
    tabContainerLook.Name = "tabContainerLook"
    tabContainerLook.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    tabContainerLook.Position = UDim2.fromScale(0.0342, 0.188)
    tabContainerLook.Size = UDim2.fromOffset(545, 36)
    tabContainerLook.Parent = main
    
    local tabContainer = Instance.new("ScrollingFrame")
    tabContainer.Name = "tabContainer"
    tabContainer.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    tabContainer.Position = UDim2.fromScale(0.0342, 0.188)
    tabContainer.Size = UDim2.fromOffset(545, 36)
    tabContainer.ScrollBarThickness = 2
    tabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContainer.ScrollingDirection = Enum.ScrollingDirection.X
    tabContainer.Active = true
    tabContainer.AutomaticCanvasSize = Enum.AutomaticSize.X
    tabContainer.ClipsDescendants = true
    tabContainer.Transparency = 1

    local spacerTab = Instance.new("Frame")
    spacerTab.Name = "SpacerTab"
    spacerTab.BackgroundTransparency = 1
    spacerTab.Size = UDim2.fromOffset(1, 5)
    spacerTab.Parent = tabContainer

    local uIListLayout = Instance.new("UIListLayout")
    uIListLayout.Name = "uIListLayout"
    uIListLayout.Padding = UDim.new(0, 15)
    uIListLayout.FillDirection = Enum.FillDirection.Horizontal
    uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    uIListLayout.Parent = tabContainer

    tabContainer.ChildAdded:Connect(function()
        local uIListLayout = tabContainer:FindFirstChildWhichIsA('UIListLayout')
        if uIListLayout then
            tabContainer.CanvasSize = UDim2.new(0, uIListLayout.AbsoluteContentSize.X + 10, 0, 0)
        end
    end)

    local UICorner = Instance.new("UICorner")
    UICorner.Name = "UICorner" 
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = tabContainerLook

    local uIListLayout = Instance.new("UIListLayout")
    uIListLayout.Name = "uIListLayout"
    uIListLayout.Padding = UDim.new(0, 15)
    uIListLayout.FillDirection = Enum.FillDirection.Horizontal
    uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uIListLayout.Parent = tabContainer

    local uIPadding = Instance.new("UIPadding")
    uIPadding.Name = "uIPadding"
    uIPadding.PaddingLeft = UDim.new(0, 7)
    uIPadding.PaddingTop = UDim.new(0, 4)
    uIPadding.Parent = tabContainer

    tabContainer.Parent = main
    main.AnchorPoint = Vector2.new(0.5,0.5)
    main.Position = UDim2.new(0.5,0,0.5,0) 

    local tabHandler = {}

    function tabHandler:Exit()
        dark_UI:Destroy()
    end

    function tabHandler:ReactiveNotification(title, description)
        local notifContainer = Instance.new("Frame")
        notifContainer.Name = "ReactionNotificationContainer"
        notifContainer.Size = UDim2.new(0, 300, 0, 120)
        notifContainer.Position = UDim2.new(1, 0, 1, -130) 
        notifContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        notifContainer.BackgroundTransparency = 1
        notifContainer.Parent = dark_UI
        
        local uICorner = Instance.new("UICorner")
        uICorner.CornerRadius = UDim.new(0, 6)
        uICorner.Parent = notifContainer
        
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
        titleLabel.TextTransparency = 1
        titleLabel.Parent = notifContainer
        
        local descLabel = Instance.new("TextLabel")
        descLabel.Name = "Description"
        descLabel.Font = Enum.Font.Gotham
        descLabel.Text = description
        descLabel.TextColor3 = Color3.fromRGB(195, 195, 195)
        descLabel.TextSize = 13
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.TextWrapped = true
        descLabel.BackgroundTransparency = 1
        descLabel.Position = UDim2.new(0.05, 0, 0.3, 0)
        descLabel.Size = UDim2.new(0.9, 0, 0, 40)
        descLabel.TextTransparency = 1
        descLabel.Parent = notifContainer
    
        local buttonHolder = Instance.new("Frame")
        buttonHolder.Name = "ButtonHolder"
        buttonHolder.BackgroundTransparency = 1
        buttonHolder.Position = UDim2.new(0, 0, 0.75, 0)
        buttonHolder.Size = UDim2.new(1, 0, 0, 30)
        buttonHolder.Parent = notifContainer
    
        local confirmButton = Instance.new("TextButton")
        confirmButton.Name = "ConfirmButton"
        confirmButton.Size = UDim2.new(0.4, 0, 1, 0)
        confirmButton.Position = UDim2.new(0.05, 0, -0.2, 0)
        confirmButton.BackgroundColor3 = Color3.fromRGB(23, 143, 75)
        confirmButton.Text = "Yes"
        confirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        confirmButton.TextSize = 14
        confirmButton.Font = Enum.Font.GothamBold
        confirmButton.BackgroundTransparency = 1
        confirmButton.TextTransparency = 1
        confirmButton.Parent = buttonHolder
    
        local denyButton = Instance.new("TextButton")
        denyButton.Name = "DenyButton"
        denyButton.Size = UDim2.new(0.4, 0, 1, 0)
        denyButton.Position = UDim2.new(0.55, 0, -0.2, 0)
        denyButton.BackgroundColor3 = Color3.fromRGB(184, 41, 41)
        denyButton.Text = "No"
        denyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        denyButton.TextSize = 14
        denyButton.Font = Enum.Font.GothamBold
        denyButton.BackgroundTransparency = 1
        denyButton.TextTransparency = 1
        denyButton.Parent = buttonHolder    

        local confirmCorner = Instance.new("UICorner")
        confirmCorner.CornerRadius = UDim.new(0, 6)
        confirmCorner.Parent = confirmButton
    
        local denyCorner = Instance.new("UICorner")
        denyCorner.CornerRadius = UDim.new(0, 6)
        denyCorner.Parent = denyButton
    
        local tweenIn = TweenService:Create(notifContainer, 


            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
            {Position = UDim2.new(1, -310, 1, -130), BackgroundTransparency = 0}
        )

        local titleTween = TweenService:Create(titleLabel,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.2),
            {TextTransparency = 0}
        )

        local descTween = TweenService:Create(descLabel,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.3),
            {TextTransparency = 0}
        )

        local confirmTween = TweenService:Create(confirmButton,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.4),
            {BackgroundTransparency = 0, TextTransparency = 0}
        )

        local denyTween = TweenService:Create(denyButton,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.5),
            {BackgroundTransparency = 0, TextTransparency = 0}
        )

        tweenIn:Play()
        titleTween:Play()
        descTween:Play()
        confirmTween:Play()
        denyTween:Play()
    
        local result = Instance.new("BindableEvent")
    
        confirmButton.MouseButton1Click:Connect(function()
            local tweenOut = TweenService:Create(notifContainer,


                TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Position = UDim2.new(1, 0, 1, -130), BackgroundTransparency = 1}
            )
            
            local elementsFadeOut = {
                TweenService:Create(titleLabel, TweenInfo.new(0.3), {TextTransparency = 1}),
                TweenService:Create(descLabel, TweenInfo.new(0.3), {TextTransparency = 1}),
                TweenService:Create(confirmButton, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1}),
                TweenService:Create(denyButton, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1})
            }

            for _, tween in ipairs(elementsFadeOut) do
                tween:Play()
            end

            tweenOut:Play()
            tweenOut.Completed:Wait()
            notifContainer:Destroy()
            result:Fire(true)
        end)
    
        denyButton.MouseButton1Click:Connect(function()
            local tweenOut = TweenService:Create(notifContainer,


                TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Position = UDim2.new(1, 0, 1, -130), BackgroundTransparency = 1}
            )
            
            local elementsFadeOut = {
                TweenService:Create(titleLabel, TweenInfo.new(0.3), {TextTransparency = 1}),
                TweenService:Create(descLabel, TweenInfo.new(0.3), {TextTransparency = 1}),
                TweenService:Create(confirmButton, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1}),
                TweenService:Create(denyButton, TweenInfo.new(0.3), {BackgroundTransparency = 1, TextTransparency = 1})
            }

            for _, tween in ipairs(elementsFadeOut) do
                tween:Play()
            end

            tweenOut:Play()
            tweenOut.Completed:Wait()
            notifContainer:Destroy()
            result:Fire(false)
        end)
    
        return result.Event

    end
    function tabHandler:Tab(name)
        local tabCount = 0
        for _, child in ipairs(tabContainer:GetChildren()) do
            if child:IsA("TextButton") then
                tabCount = tabCount + 1
            end
        end
    
        if tabCount >= 15 then
            Library:CreateNotification("Warning", "Maximum tab limit reached (15/15). Cannot create more tabs.", 20)
            return
        end   

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
        
        local container = Instance.new("Frame")
        container.Name = "container"
        container.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
        container.Position = UDim2.fromScale(0.0342, 0.31)
        container.Size = UDim2.fromOffset(545, 220)
        
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
        holder.Size = UDim2.fromOffset(542, 218)
        holder.CanvasSize = UDim2.fromOffset(0, 0)
        holder.ClipsDescendants = true

        holder.ChildAdded:Connect(function()
            local listLayout = holder:FindFirstChildWhichIsA('UIListLayout')
            if listLayout then
                holder.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
            end
        end)        

        local uIPadding1 = Instance.new("UIPadding")
        uIPadding1.Name = "uIPadding1"
        uIPadding1.PaddingLeft = UDim.new(0, 5)
        uIPadding1.PaddingTop = UDim.new(0, 7)
        uIPadding1.Parent = holder

        local uIListLayout1 = Instance.new("UIListLayout")
        uIListLayout1.Name = "uIListLayout1"
        uIListLayout1.Padding = UDim.new(0, 6)
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
            label.Size = UDim2.fromOffset(529, 34)
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

        function ElementHandler:Button(text, callback)
            text = text or "Button"
            callback = callback or function() end

            local button = Instance.new("TextButton")
            button.Name = "button"
            button.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            button.Position = UDim2.fromScale(0, 0.135)
            button.Size = UDim2.fromOffset(529, 34)
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

        function ElementHandler:Section(text)
            local section = Instance.new("Frame")
            section.Name = "section"
            section.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
            section.Size = UDim2.fromOffset(529, 43)
            
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
            keybind.Size = UDim2.fromOffset(529, 34)
            
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
            bindButton.Size = UDim2.fromOffset(62, 23)
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
                elseif not binding and input.KeyCode == currentKey then
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
            separator.Size = UDim2.fromOffset(529, 4)
            separator.Parent = holder
            
            local uICorner = Instance.new("UICorner")
            uICorner.CornerRadius = UDim.new(0, 6)
            uICorner.Parent = separator
        end        

        function ElementHandler:Dropdown(text, list, callback)
            text = text or "Dropdown"
            list = list or {}
            callback = callback or function() end
        
            local dropdown = Instance.new("Frame")
            dropdown.Name = "dropdown"
            dropdown.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            dropdown.Size = UDim2.fromOffset(529, 34)
            dropdown.ZIndex = 3
        
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
        
            local dropFrame = Instance.new("ScrollingFrame")
            dropFrame.Name = "dropFrame"
            dropFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            dropFrame.Position = UDim2.fromOffset(0, 40)
            dropFrame.Size = UDim2.fromOffset(529, 34)
            dropFrame.ClipsDescendants = true
            dropFrame.Visible = false
            dropFrame.ZIndex = 2
            dropFrame.ScrollBarThickness = 0
            dropFrame.ScrollingDirection = Enum.ScrollingDirection.Y
            dropFrame.Parent = dropdown
        
            local uICornerDrop = Instance.new("UICorner")
            uICornerDrop.CornerRadius = UDim.new(0, 6)
            uICornerDrop.Parent = dropFrame
        
            local itemHolder = Instance.new("Frame")
            itemHolder.Name = "itemHolder"
            itemHolder.BackgroundTransparency = 1
            itemHolder.Size = UDim2.fromOffset(529, 34)
            itemHolder.ZIndex = 2
            itemHolder.Parent = dropFrame
        
            local itemList = Instance.new("UIListLayout")
            itemList.SortOrder = Enum.SortOrder.LayoutOrder
            itemList.Padding = UDim.new(0, 5)
            itemList.HorizontalAlignment = Enum.HorizontalAlignment.Center
            itemList.Parent = itemHolder   
                 
            local padding = Instance.new("UIPadding")
            padding.PaddingTop = UDim.new(0, 5)
            padding.PaddingBottom = UDim.new(0, 5)
            padding.Parent = itemHolder
        
            local dropped = false
            local selectedItems = {}
        
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
                item.ZIndex = 2
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
                    selectedItems = {itemText}
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
                    game:GetService('TweenService'):Create(dropFrame, TweenInfo.new(0.2), {Size = UDim2.fromOffset(529, (#list * 45) + 15)}):Play()
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
            
            if not self.NotificationList then
                self.NotificationList = Instance.new("UIListLayout")
                self.NotificationList.Name = "NotificationList"
                self.NotificationList.HorizontalAlignment = Enum.HorizontalAlignment.Right
                self.NotificationList.VerticalAlignment = Enum.VerticalAlignment.Bottom
                self.NotificationList.Padding = UDim.new(0, 5)
                
                self.NotificationHolder = Instance.new("Frame")
                self.NotificationHolder.Name = "NotificationHolder"
                self.NotificationHolder.Size = UDim2.new(1, 0, 1, 0)
                self.NotificationHolder.Position = UDim2.new(0, 0, 0, 0)
                self.NotificationHolder.BackgroundTransparency = 1
                self.NotificationHolder.Parent = dark_UI
                
                self.NotificationList.Parent = self.NotificationHolder
            end
            
            local notifContainer = Instance.new("TextButton")
            notifContainer.Name = "NotificationContainer"
            notifContainer.Size = UDim2.new(0, 250, 0, 0)
            notifContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
            notifContainer.BackgroundTransparency = 1
            notifContainer.Text = ""
            notifContainer.AutoButtonColor = false
            notifContainer.Parent = self.NotificationHolder
            
            local uICorner = Instance.new("UICorner")
            uICorner.CornerRadius = UDim.new(0, 6)
            uICorner.Parent = notifContainer
            
            local titleLabel = Instance.new("TextLabel")
            titleLabel.Name = "Title"
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.Text = title
            titleLabel.TextColor3 = Color3.fromRGB(195, 195, 195)
            titleLabel.TextTransparency = 1
            titleLabel.TextSize = 14
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.BackgroundTransparency = 1
            titleLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
            titleLabel.Size = UDim2.new(0.9, 0, 0, 20)
            titleLabel.Parent = notifContainer
            
            local descLabel = Instance.new("TextLabel")
            descLabel.Name = "Description"
            descLabel.Font = Enum.Font.Gotham
            descLabel.Text = description
            descLabel.TextColor3 = Color3.fromRGB(195, 195, 195)
            descLabel.TextTransparency = 1
            descLabel.TextSize = 13
            descLabel.TextXAlignment = Enum.TextXAlignment.Left
            descLabel.TextWrapped = true
            descLabel.BackgroundTransparency = 1
            descLabel.Position = UDim2.new(0.05, 0, 0.4, 0)
            descLabel.Size = UDim2.new(0.9, 0, 0.5, 0)
            descLabel.Parent = notifContainer
            
            local progressBar = Instance.new("Frame")
            progressBar.Name = "ProgressBar"
            progressBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            progressBar.BackgroundTransparency = 1
            progressBar.Position = UDim2.new(0, 0, 0.95, 0)
            progressBar.Size = UDim2.new(1, 0, 0, 3)
            progressBar.Parent = notifContainer
            
            local progress = Instance.new("Frame")
            progress.Name = "Progress"
            progress.BackgroundColor3 = Color3.fromRGB(195, 195, 195)
            progress.BackgroundTransparency = 1
            progress.Size = UDim2.new(1, 0, 1, 0)
            progress.Parent = progressBar
            
            notifContainer.Position = UDim2.new(1.1, 0, 0, 0)
            
            local function animateIn()
                local heightTween = TweenService:Create(notifContainer, 
                    TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 250, 0, 80)}
                )
                
                local fadeTween = TweenService:Create(notifContainer,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                    {BackgroundTransparency = 0}
                )
                
                local slideTween = TweenService:Create(notifContainer,
                    TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    {Position = UDim2.new(0, 0, 0, 0)}
                )
                
                local titleFadeTween = TweenService:Create(titleLabel,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                    {TextTransparency = 0}
                )
                
                local descFadeTween = TweenService:Create(descLabel,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                    {TextTransparency = 0}
                )
                
                local progressBarFadeTween = TweenService:Create(progressBar,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                    {BackgroundTransparency = 0}
                )
                
                local progressFadeTween = TweenService:Create(progress,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                    {BackgroundTransparency = 0}
                )
                
                heightTween:Play()
                wait(0.1)
                fadeTween:Play()
                slideTween:Play()
                titleFadeTween:Play()
                descFadeTween:Play()
                progressBarFadeTween:Play()
                progressFadeTween:Play()
            end
            
            local function animateOut()
                local fadeOutTween = TweenService:Create(notifContainer,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {BackgroundTransparency = 1, Position = UDim2.new(1.1, 0, 0, 0)}
                )
                
                local titleFadeOutTween = TweenService:Create(titleLabel,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {TextTransparency = 1}
                )
                
                local descFadeOutTween = TweenService:Create(descLabel,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {TextTransparency = 1}
                )
                
                local progressBarFadeOutTween = TweenService:Create(progressBar,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {BackgroundTransparency = 1}
                )
                
                local progressFadeOutTween = TweenService:Create(progress,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {BackgroundTransparency = 1}
                )
                
                local shrinkTween = TweenService:Create(notifContainer,
                    TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                    {Size = UDim2.new(0, 250, 0, 0)}
                )
                
                fadeOutTween:Play()
                titleFadeOutTween:Play()
                descFadeOutTween:Play()
                progressBarFadeOutTween:Play()
                progressFadeOutTween:Play()
                wait(0.15)
                shrinkTween:Play()
                shrinkTween.Completed:Wait()
                notifContainer:Destroy()
            end
            
            animateIn()
            
            local progressTween = TweenService:Create(progress,
                TweenInfo.new(duration, Enum.EasingStyle.Linear),
                {Size = UDim2.new(0, 0, 1, 0)}
            )
            progressTween:Play()
            
            notifContainer.MouseEnter:Connect(function()
                TweenService:Create(notifContainer, TweenInfo.new(0.2), 
                    {BackgroundColor3 = Color3.fromRGB(33, 33, 33)}):Play()
            end)
            
            notifContainer.MouseLeave:Connect(function()
                TweenService:Create(notifContainer, TweenInfo.new(0.2), 
                    {BackgroundColor3 = Color3.fromRGB(28, 28, 28)}):Play()
            end)
            
            notifContainer.MouseButton1Click:Connect(animateOut)
            task.delay(duration, animateOut)
        end
        
        function ElementHandler:Slider(text, default, min, max, callback)
            text = text or "Slider"
            callback = callback or function() end

            local slider = Instance.new("TextButton")
            slider.Name = "slider"
            slider.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            slider.Size = UDim2.fromOffset(529, 34)
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
            frame.Size = UDim2.fromOffset(122, 10)

            local uICorner5 = Instance.new("UICorner")
            uICorner5.Name = "uICorner5"
            uICorner5.CornerRadius = UDim.new(0, 3)
            uICorner5.Parent = frame

            local frame1 = Instance.new("Frame")
            frame1.Name = "frame1"
            frame1.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            frame1.Position = UDim2.fromScale(-0.00207, 0)
            frame1.Size = UDim2.fromOffset(53, 10)

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
            toggle1.Size = UDim2.fromOffset(529, 34)
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
            frame3.Size = UDim2.fromOffset(22, 22)
        
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
            comment.Size = UDim2.fromOffset(529, 24)
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
            textbox.Size = UDim2.fromOffset(529, 34)

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
            textBox.Size = UDim2.fromOffset(62, 23)

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
        Key
    }

    for _, frame in ipairs(DragFrames) do
        if frame:IsA("Frame") or frame:IsA("ImageLabel") then
            makeDraggable(frame)
        end
    end
    game.CoreGui['dark_UI'].main.tabContainer.ChildAdded:Connect(function()
        local container = game.CoreGui['dark_UI'].main:FindFirstChild('container')
        if container then
            container.Visible = true
        end
        
        pcall(function()
            repeat wait() until game.CoreGui['dark_UI'].main:FindFirstChild('tabContainer'):FindFirstChildWhichIsA('TextButton')
        end)
        
        local firstTab = game.CoreGui['dark_UI'].main:FindFirstChild('tabContainer'):FindFirstChildWhichIsA('TextButton')
        if firstTab then
            game:GetService('TweenService'):Create(firstTab, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        end
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

if not useKey then
    main.Visible = true
end
    return tabHandler
end

local executor = getexecutorname() or "Unknown Executor"
print(' ')
print('===========================================')
print('Welcome to BlareUi-Library')
print('Library Version : '.. Version)
print('Executor : '.. executor)
print('Status : Functional')
print('Game Name: '.. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
print('Game ID: '.. game.PlaceId) 
print('Player Name : '.. game.Players.LocalPlayer.Name)
print('Player ID : '.. game.Players.LocalPlayer.UserId)
print('Current Time : '.. os.date("%I:%M %p"))
print('Memory Usage : '.. math.floor(game:GetService("Stats"):GetTotalMemoryUsageMb()) ..' MB')
print('===========================================')
print(' ')

return Library