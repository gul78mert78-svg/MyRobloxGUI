-- Basit GUI deneme kodu
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Eski GUI varsa sil
local oldGui = playerGui:FindFirstChild("MyTestGui")
if oldGui then oldGui:Destroy() end

-- Ana ScreenGui oluştur
local gui = Instance.new("ScreenGui")
gui.Name = "MyTestGui"
gui.Parent = playerGui

-- Frame (pencere)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(40,40,60)
frame.Parent = gui

-- Başlık
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Deneme GUI"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundColor3 = Color3.fromRGB(30,30,45)
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = frame

-- Buton
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 120, 0, 40)
button.Position = UDim2.new(0.5, -60, 0.5, -20)
button.Text = "Tıkla!"
button.Font = Enum.Font.Gotham
button.TextSize = 16
button.BackgroundColor3 = Color3.fromRGB(70,130,180)
button.TextColor3 = Color3.fromRGB(255,255,255)
button.Parent = frame

button.MouseButton1Click:Connect(function()
	button.Text = "Tıklandı!"
	print("Butona basıldı.")
end)

print("GUI yüklendi!")
