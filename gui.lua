--// Steal Hub GUI
-- Bu kodu bir LocalScript'e koy (örneğin StarterGui içine)
-- veya loadstring ile çalıştırılacak hale getirebilirsin

-- GUI oluştur
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Ana Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- Başlık
local Title = Instance.new("TextLabel")
Title.Text = "Steal Hub"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = MainFrame

-- Örnek Buton
local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1, -20, 0, 40)
Button.Position = UDim2.new(0, 10, 0, 50)
Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Button.Text = "Example Button"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.Gotham
Button.TextSize = 18
Button.Parent = MainFrame

Button.MouseButton1Click:Connect(function()
	print("Butona tıklandı!")
end)

-- Sağ Shift ile aç/kapat
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		MainFrame.Visible = not MainFrame.Visible
	end
end)
