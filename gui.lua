-- Steal Hub GUI v1
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Önceki GUI varsa sil
local oldGui = playerGui:FindFirstChild("StealHubGUI")
if oldGui then oldGui:Destroy() end

-- Ana ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StealHubGUI"
screenGui.Parent = playerGui

-- Frame (pencere)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 250)
frame.Position = UDim2.new(0.5, -200, 0.5, -125)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
frame.BorderSizePixel = 0
frame.Visible = false -- Shift ile açılacak
frame.Parent = screenGui

-- Başlık çubuğu
local titlebar = Instance.new("Frame")
titlebar.Size = UDim2.new(1, 0, 0, 35)
titlebar.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- kırmızı
titlebar.BorderSizePixel = 0
titlebar.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "Steal Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = titlebar

-- Kapatma butonu
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.fromOffset(30, 30)
closeBtn.Position = UDim2.new(1, -35, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 220, 0) -- sarı
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.TextColor3 = Color3.fromRGB(0,0,0)
closeBtn.Parent = titlebar

closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

-- Buton örneği
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 120, 0, 40)
button.Position = UDim2.new(0.5, -60, 0.5, -20)
button.Text = "Click Me!"
button.Font = Enum.Font.Gotham
button.TextSize = 16
button.BackgroundColor3 = Color3.fromRGB(50, 200, 150) -- yeşil-mavi
button.TextColor3 = Color3.fromRGB(255,255,255)
button.Parent = frame

button.MouseButton1Click:Connect(function()
    button.Text = "Clicked!"
    print("Steal Hub butonuna basıldı!")
end)

-- GUI draggable (başlık üzerinden sürükleme)
local dragging, dragInput, dragStart, startPos
titlebar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titlebar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Sağ Shift tuşuna basınca GUI aç/kapa
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        frame.Visible = not frame.Visible
    end
end)

print("Steal Hub GUI hazır! Sağ Shift ile aç/kapa.")
