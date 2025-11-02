local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI oluştur
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealHubGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 200)
MainFrame.Position = UDim2.new(0.3, 0, -0.5, 0) -- başta gizli üstten
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Başlık
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(120, 20, 20)
Title.BackgroundTransparency = 0.2
Title.Text = "Steal Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.TextColor3 = Color3.fromRGB(255, 200, 200)
Title.Parent = MainFrame

-- Buton oluşturma fonksiyonu
local function createButton(text, posX, posY, width, height)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, width, 0, height)
    btn.Position = UDim2.new(0, posX, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
    btn.BackgroundTransparency = 0.15
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 210, 210)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 20
    btn.AutoButtonColor = false
    btn.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
        btn.TextColor3 = Color3.fromRGB(255, 240, 240)
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.15}):Play()
        btn.TextColor3 = Color3.fromRGB(255, 210, 210)
    end)

    return btn
end

-- Sol ve sağ butonlar
local mainBtn = createButton("Main", 20, 60, 120, 40)
local saveBaseBtn = createButton("Save Your Base", 260, 60, 120, 40)
local goBaseBtn = createButton("Go Your Base", 260, 120, 120, 40)

-- Base kaydetme
local savedBase = nil
saveBaseBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedBase = char.HumanoidRootPart.Position
        saveBaseBtn.Text = "Base Saved!"
        wait(1.5)
        saveBaseBtn.Text = "Save Your Base"
    end
end)

-- Base gitme
goBaseBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if not savedBase then
        goBaseBtn.Text = "No Base Saved!"
        wait(1.5)
        goBaseBtn.Text = "Go Your Base"
        return
    end
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        local distance = (savedBase - hrp.Position).Magnitude
        local tweenInfo = TweenInfo.new(distance / 50, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(savedBase)})
        tween:Play()
    end
end)

-- Aç/kapa animasyonu
local openTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0.3,0,0.3,0)})
local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(0.3,0,-0.5,0)})

local guiVisible = false
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.F then
        guiVisible = not guiVisible
        if guiVisible then
            MainFrame.Visible = true
            openTween:Play()
        else
            closeTween:Play()
            wait(0.5)
            MainFrame.Visible = false
        end
    end
end)
