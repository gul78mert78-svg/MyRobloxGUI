local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 240)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(70, 15, 15)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false -- Başlangıçta kapalı
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(130, 25, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "Steal Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.TextColor3 = Color3.fromRGB(255, 200, 200)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 26
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.BackgroundTransparency = 1
CloseButton.Size = UDim2.new(0, 45, 1, 0)
CloseButton.Position = UDim2.new(1, -45, 0, 0)
CloseButton.Parent = TitleBar
CloseButton.AutoButtonColor = false

CloseButton.MouseEnter:Connect(function()
    CloseButton.TextColor3 = Color3.fromRGB(255, 50, 50)
end)
CloseButton.MouseLeave:Connect(function()
    CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
end)
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

local function createButton(text, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(110, 20, 20)
    btn.BackgroundTransparency = 0.15
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 210, 210)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 20
    btn.AutoButtonColor = false
    btn.Parent = MainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        btn.TextColor3 = Color3.fromRGB(255, 240, 240)
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundTransparency = 0.15}):Play()
        btn.TextColor3 = Color3.fromRGB(255, 210, 210)
    end)

    return btn
end

local saveBasePos = nil
local SaveBaseBtn = createButton("Save Your Base", 60)
SaveBaseBtn.MouseButton1Click:Connect(function()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        saveBasePos = character.HumanoidRootPart.Position
        SaveBaseBtn.Text = "Base Saved!"
        wait(1.5)
        SaveBaseBtn.Text = "Save Your Base"
    end
end)

local GoBaseBtn = createButton("Go Your Base", 110)
GoBaseBtn.MouseButton1Click:Connect(function()
    local character = player.Character
    if not saveBasePos then
        GoBaseBtn.Text = "No Base Saved!"
        wait(1.5)
        GoBaseBtn.Text = "Go Your Base"
        return
    end
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local distance = (saveBasePos - hrp.Position).Magnitude
        local tweenInfo = TweenInfo.new(distance / 50, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(saveBasePos)})
        tween:Play()
    end
end)

local exampleBtn = createButton("Instant Stealer", 160)
exampleBtn.MouseButton1Click:Connect(function()
    print("Instant Stealer clicked!")
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.F then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
