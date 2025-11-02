-- gui.lua
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui", player.PlayerGui)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0, 50, 0, 50)
mainFrame.BackgroundTransparency = 0.5
mainFrame.Visible = false

local mainButton = Instance.new("TextButton", screenGui)
mainButton.Text = "Main"
mainButton.Position = UDim2.new(0, 50, 0, 20)
mainButton.Size = UDim2.new(0, 100, 0, 50)

mainButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Save/Go base
local savedPosition = nil

local saveButton = Instance.new("TextButton", mainFrame)
saveButton.Text = "Save Your Base"
saveButton.Size = UDim2.new(0, 150, 0, 50)
saveButton.Position = UDim2.new(0, 10, 0, 10)
saveButton.MouseButton1Click:Connect(function()
    savedPosition = player.Character.HumanoidRootPart.Position
end)

local goButton = Instance.new("TextButton", mainFrame)
goButton.Text = "Go Your Base"
goButton.Size = UDim2.new(0, 150, 0, 50)
goButton.Position = UDim2.new(0, 10, 0, 70)
goButton.MouseButton1Click:Connect(function()
    if savedPosition then
        local hrp = player.Character.HumanoidRootPart
        local tween = TweenService:Create(hrp, TweenInfo.new(3), {Position = savedPosition})
        tween:Play()
    end
end)

