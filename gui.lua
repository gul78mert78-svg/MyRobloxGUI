--// Modern Steal Hub GUI - Loadstring Compatible
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ScreenGui oluştur
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StealHubModern"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Ana Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 220)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.BackgroundTransparency = 0.25 -- şeffaflık
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Visible = true
mainFrame.Parent = screenGui
mainFrame.ClipsDescendants = true

-- Köşeleri yuvarlat
local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(0, 12)
uicorner.Parent = mainFrame

-- Başlık
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Steal Hub"
title.TextColor3 = Color3.fromRGB(200,200,200)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = mainFrame

-- Örnek Buton
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -40, 0, 40)
button.Position = UDim2.new(0,20,0,60)
button.BackgroundColor3 = Color3.fromRGB(60,60,60)
button.TextColor3 = Color3.fromRGB(230,230,230)
button.Text = "Example Button"
button.Font = Enum.Font.Gotham
button.TextSize = 18
button.Parent = mainFrame

-- Buton hover efekti
button.MouseEnter:Connect(function()
	button.BackgroundColor3 = Color3.fromRGB(80,80,80)
end)
button.MouseLeave:Connect(function()
	button.BackgroundColor3 = Color3.fromRGB(60,60,60)
end)

button.MouseButton1Click:Connect(function()
	print("Button clicked!")
end)

-- Drag (sürükleme)
local dragging, dragInput, dragStart, startPos
local function update(input)
	local delta = input.Position - dragStart
	mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- F tuşu ile aç/kapat
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.F then
		mainFrame.Visible = not mainFrame.Visible
	end
end)

print("✅ Modern Steal Hub GUI loaded!")
