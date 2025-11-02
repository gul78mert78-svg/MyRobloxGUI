-- Steal Hub Modern Koyu Kırmızı GUI

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = game.Players.LocalPlayer

-- GUI oluştur
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Ana Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 220)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 0, 0) -- koyu kırmızı
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui
MainFrame.Selectable = true
MainFrame.AutoButtonColor = false
MainFrame.Modal = true

-- Yuvarlatılmış köşeler
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Başlık Barı
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(75, 0, 0) -- daha açık kırmızı
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "Steal Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255, 180, 180)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Kapatma Butonu
local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 24
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.BackgroundTransparency = 1
CloseButton.Size = UDim2.new(0, 40, 1, 0)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
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

-- Buton Oluşturma Fonksiyonu
local function createButton(text, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
    btn.BackgroundTransparency = 0.1
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 180, 180)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    btn.AutoButtonColor = false
    btn.Parent = MainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        btn.TextColor3 = Color3.fromRGB(255, 220, 220)
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
        btn.TextColor3 = Color3.fromRGB(255, 180, 180)
    end)

    return btn
end

-- Save Your Base Butonu
local saveBasePos = nil
local SaveBaseBtn = createButton("Save Your Base", 50)
SaveBaseBtn.MouseButton1Click:Connect(function()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        saveBasePos = character.HumanoidRootPart.Position
        print("Base saved at:", saveBasePos)
        SaveBaseBtn.Text = "Base Saved!"
        wait(1.5)
        SaveBaseBtn.Text = "Save Your Base"
    end
end)

-- Go Your Base Butonu
local GoBaseBtn = createButton("Go Your Base", 100)
GoBaseBtn.MouseButton1Click:Connect(function()
    local character = player.Character
    if not saveBasePos then
        print("No base saved!")
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

-- Örnek Başka Butonlar
local exampleBtn1 = createButton("Instant Stealer", 150)
exampleBtn1.MouseButton1Click:Connect(function()
    print("Instant Stealer clicked!")
end)

local exampleBtn2 = createButton("Admin Command", 200)
exampleBtn2.MouseButton1Click:Connect(function()
    print("Admin Command clicked!")
end)

-- F tuşu ile aç/kapat
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.F then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
