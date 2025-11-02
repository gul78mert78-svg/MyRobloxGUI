--// Steal Hub Modern GUI (2025 Style)
if game:GetService("CoreGui"):FindFirstChild("StealHub") then
	game:GetService("CoreGui").StealHub:Destroy()
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Ana GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealHub"
ScreenGui.ResetOnSpawn = false
local ok = pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
if not ok then ScreenGui.Parent = player:WaitForChild("PlayerGui") end

-- Ana Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 230)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -115)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- Köşe yuvarlama
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Gölge efekti
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.75
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10,10,118,118)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.Position = UDim2.new(0, -15, 0, -15)
Shadow.BackgroundTransparency = 1
Shadow.ZIndex = 0
Shadow.Parent = MainFrame

-- Başlık
local Title = Instance.new("TextLabel")
Title.Text = "Steal Hub"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.BackgroundTransparency = 0.4
Title.TextColor3 = Color3.fromRGB(200, 200, 200)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Buton örneği
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1, -40, 0, 45)
Button.Position = UDim2.new(0, 20, 0, 60)
Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Button.BackgroundTransparency = 0.3
Button.Text = "Example Action"
Button.TextColor3 = Color3.fromRGB(220, 220, 220)
Button.Font = Enum.Font.Gotham
Button.TextSize = 18
Button.AutoButtonColor = false
Button.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 10)
ButtonCorner.Parent = Button

Button.MouseEnter:Connect(function()
	TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
end)
Button.MouseLeave:Connect(function()
	TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
end)
Button.MouseButton1Click:Connect(function()
	print("Steal Hub butonu tıklandı!")
end)

-- Manual Drag (yumuşak)
do
	local dragging, dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end

	Title.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			update(input)
		end
	end)
end

-- 🎹 F TUŞU ile aç/kapa (fade animasyonlu)
local isVisible = true
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.F then
		isVisible = not isVisible
		if isVisible then
			MainFrame.Visible = true
			MainFrame.BackgroundTransparency = 1
			TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0.3}):Play()
		else
			local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1})
			tween:Play()
			tween.Completed:Connect(function()
				MainFrame.Visible = false
			end)
		end
	end
end)

print("✅ Steal Hub GUI yüklendi! F tuşuyla aç/kapa.")
