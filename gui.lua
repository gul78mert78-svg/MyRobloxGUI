--// Güvenli & Görsel Steal Hub GUI //--
-- Yapan: Sen :)

-- GUI zaten varsa sil
if game.CoreGui:FindFirstChild("StealHubGUI") then
    game.CoreGui.StealHubGUI:Destroy()
end

-- Ana GUI
local gui = Instance.new("ScreenGui")
gui.Name = "StealHubGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = game.CoreGui

-- Ana Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.4, 0, 0.4, 0)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 0
frame.Parent = gui

-- Ortadaki yazı
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Steal Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Alt yazı
local speed = Instance.new("TextLabel")
speed.Size = UDim2.new(1, 0, 0.2, 0)
speed.Position = UDim2.new(0, 0, 0.8, 0)
speed.BackgroundTransparency = 1
speed.Text = "Speed"
speed.TextColor3 = Color3.fromRGB(255, 255, 255)
speed.TextScaled = true
speed.Font = Enum.Font.Gotham
speed.Parent = frame

-- Açılış ve kapanış sesi
local openSound = Instance.new("Sound")
openSound.SoundId = "rbxassetid://12222140" -- bir örnek "click" sesi
openSound.Volume = 1
openSound.Parent = gui

local closeSound = Instance.new("Sound")
closeSound.SoundId = "rbxassetid://12222058"
closeSound.Volume = 1
closeSound.Parent = gui

-- Başta kapalı
gui.Enabled = false

-- Tuş atama (G tuşu)
local toggleKey = Enum.KeyCode.G
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == toggleKey then
        gui.Enabled = not gui.Enabled
        if gui.Enabled then
            openSound:Play()
        else
            closeSound:Play()
        end
    end
end)
