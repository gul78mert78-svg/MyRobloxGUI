local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(255,0,0)
frame.Visible = false

game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.RightShift then
        frame.Visible = not frame.Visible
    end
end)
