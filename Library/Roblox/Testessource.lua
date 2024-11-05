-- TestHub Library
local TestHub = {}

-- Inicializa a biblioteca
function TestHub:CreateGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Frame principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Visible = false
    mainFrame.Parent = screenGui
    
    local function applyUICorner(instance, radius)
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, radius)
        uiCorner.Parent = instance
    end
    applyUICorner(mainFrame, 8)
    
    -- Título do GUI
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Text = "Test Hub"
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 24
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    titleLabel.Parent = mainFrame
    applyUICorner(titleLabel, 8)
    
    -- Animação de abertura e fechamento
    local function toggleGUI()
        if mainFrame.Visible then
            mainFrame:TweenSize(UDim2.new(0, 400, 0, 0), "Out", "Sine", 0.5, true, function()
                mainFrame.Visible = false
            end)
        else
            mainFrame.Visible = true
            mainFrame:TweenSize(UDim2.new(0, 400, 0, 350), "Out", "Sine", 0.5, true)
        end
    end

    -- Botão para abrir/fechar GUI
    local openCloseButton = Instance.new("TextButton")
    openCloseButton.Size = UDim2.new(0, 100, 0, 30)
    openCloseButton.Position = UDim2.new(0.5, -50, 0, 20)
    openCloseButton.Text = "Abrir GUI"
    openCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    openCloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    applyUICorner(openCloseButton, 8)
    openCloseButton.Parent = screenGui
    openCloseButton.MouseButton1Click:Connect(toggleGUI)
    
    -- Estrutura para as abas e o conteúdo das abas
    local tabs = {}
    function TestHub:AddTab(tabName)
        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, 0, 1, -70)
        tabFrame.Position = UDim2.new(0, 0, 0, 70)
        tabFrame.BackgroundTransparency = 0.1
        tabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tabFrame.Visible = (#tabs == 0)
        applyUICorner(tabFrame, 8)
        tabFrame.Parent = mainFrame
        table.insert(tabs, tabFrame)
        
        -- Botão da aba
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 90, 0, 30)
        tabButton.Position = UDim2.new(0, (#tabs - 1) * 100, 0, 40)
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        applyUICorner(tabButton, 8)
        tabButton.Parent = mainFrame

        tabButton.MouseButton1Click:Connect(function()
            for j, tab in ipairs(tabs) do
                tab.Visible = (tab == tabFrame)
            end
        end)
        
        return tabFrame
    end
    
    -- Função de Toggle
    function TestHub:AddToggle(tabFrame, labelText, toggleFunction)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(0, 100, 0, 30)
        toggleFrame.Position = UDim2.new(0, 10, 0, 10 + (#tabFrame:GetChildren() * 35))
        toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        applyUICorner(toggleFrame, 8)
        toggleFrame.Parent = tabFrame

        local toggleButton = Instance.new("TextButton")
        toggleButton.Size = UDim2.new(1, 0, 1, 0)
        toggleButton.Text = labelText
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        applyUICorner(toggleButton, 8)
        toggleButton.Parent = toggleFrame

        local toggled = false
        toggleButton.MouseButton1Click:Connect(function()
            toggled = not toggled
            toggleFunction(toggled)
            toggleButton.Text = toggled and "On" or "Off"
        end)
    end

    -- Função de Executor de Script
    function TestHub:AddExecutor(tabFrame)
        local executorFrame = Instance.new("Frame")
        executorFrame.Size = UDim2.new(0, 250, 0, 100)
        executorFrame.Position = UDim2.new(0, 10, 0, 10 + (#tabFrame:GetChildren() * 35))
        executorFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        applyUICorner(executorFrame, 8)
        executorFrame.Parent = tabFrame

        local textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(1, 0, 0.5, 0)
        textBox.Position = UDim2.new(0, 0, 0, 0)
        textBox.PlaceholderText = "Insira o script aqui"
        textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        applyUICorner(textBox, 8)
        textBox.Parent = executorFrame

        local executeButton = Instance.new("TextButton")
        executeButton.Size = UDim2.new(1, 0, 0.5, 0)
        executeButton.Position = UDim2.new(0, 0, 0.5, 0)
        executeButton.Text = "Executar"
        executeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        executeButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        applyUICorner(executeButton, 8)
        executeButton.Parent = executorFrame

        executeButton.MouseButton1Click:Connect(function()
            local scriptText = textBox.Text
            loadstring(scriptText)()
        end)
    end

    return screenGui
end

return TestHub
