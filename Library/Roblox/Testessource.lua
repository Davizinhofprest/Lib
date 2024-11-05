local TestHub = {}
TestHub.Name = "Test Hub"

function TestHub:CreateGUI(customName)
    if customName then
        self.Name = customName
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Visible = true
    mainFrame.Parent = screenGui

    local function applyUICorner(instance, radius)
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, radius)
        uiCorner.Parent = instance
    end

    applyUICorner(mainFrame, 8)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Text = self.Name
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 24
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    titleLabel.Parent = mainFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 100, 0, 50)
    toggleButton.Position = UDim2.new(0.5, -50, 0, 60)
    toggleButton.Text = "Toggle Hub"
    toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    toggleButton.Parent = mainFrame
    applyUICorner(toggleButton, 8)

    local tabs = {}
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 1, -50)
    tabContainer.Position = UDim2.new(0, 0, 0, 50)
    tabContainer.Parent = mainFrame

    applyUICorner(tabContainer, 8)

    function TestHub:AddTab(tabName)
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 100, 0, 50)
        tabButton.Text = tabName
        tabButton.Parent = tabContainer
        applyUICorner(tabButton, 8)

        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabFrame.Visible = false
        tabFrame.Parent = tabContainer

        function tabButton.MouseButton1Click()
            for _, tab in pairs(tabs) do
                tab.Frame.Visible = false
            end
            tabFrame.Visible = true
        end

        tabs[tabName] = { Button = tabButton, Frame = tabFrame }
    end

    function TestHub:AddButton(tabIndex, buttonName, callback)
        local tab = tabs[tabIndex]
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 100, 0, 50)
        button.Text = buttonName
        button.Parent = tab.Frame
        applyUICorner(button, 8)

        button.MouseButton1Click:Connect(callback)
    end

    function TestHub:AddToggle(tabIndex, toggleName, callback)
        local tab = tabs[tabIndex]
        local toggleButton = Instance.new("TextButton")
        toggleButton.Size = UDim2.new(0, 100, 0, 50)
        toggleButton.Text = toggleName
        toggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        toggleButton.Parent = tab.Frame
        applyUICorner(toggleButton, 8)

        local toggled = false
        toggleButton.MouseButton1Click:Connect(function()
            toggled = not toggled
            toggleButton.BackgroundColor3 = toggled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(70, 70, 70)
            callback(toggled)
        end)
    end

    function TestHub:AddTextBox(tabIndex, placeholder, callback)
        local tab = tabs[tabIndex]
        local textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(1, -20, 0, 50)
        textBox.Position = UDim2.new(0, 10, 0, 10)
        textBox.PlaceholderText = placeholder
        textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        textBox.Parent = tab.Frame
        applyUICorner(textBox, 8)

        local executeButton = Instance.new("TextButton")
        executeButton.Size = UDim2.new(0, 100, 0, 50)
        executeButton.Position = UDim2.new(0.5, -50, 1, 10)
        executeButton.Text = "Executar"
        executeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        executeButton.Parent = tab.Frame
        applyUICorner(executeButton, 8)

        executeButton.MouseButton1Click:Connect(function()
            local script = textBox.Text
            callback(script)
        end)
    end

    return TestHub
end

return TestHub
