-- انتظر حتى يُحمّل المشهد
if not game:IsLoaded() then game.Loaded:Wait() end

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- حذف النافذة القديمة إن وُجدت
if playerGui:FindFirstChild("ServerLinkUI") then
    playerGui.ServerLinkUI:Destroy()
end

-- إنشاء الواجهة داخل PlayerGui (يعمل على الجوال)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ServerLinkUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- الإطار الرئيسي (في المنتصف، حجم وسط)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 120)
frame.Position = UDim2.new(0.5, -130, 0.5, -60) -- منتصف الشاشة
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- عنوان
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundTransparency = 1
title.Text = "🌐 أرسل رابط سيرفرك"
title.TextColor3 = Color3.fromRGB(220, 220, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame

-- مربع إدخال
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -20, 0, 30)
textBox.Position = UDim2.new(0, 10, 0, 35)
textBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.ClearTextOnFocus = false
textBox.PlaceholderText = "الصق الرابط هنا"
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.Parent = frame

-- زر إرسال
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 30)
button.Position = UDim2.new(0, 10, 0, 75)
button.BackgroundColor3 = Color3.fromRGB(60, 140, 200)
button.Text = "إرسال"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.Parent = frame

-- عند الضغط
button.MouseButton1Click:Connect(function()
    local link = textBox.Text:trim()
    if link == "" then
        textBox.PlaceholderText = "الرابط فارغ!"
        return
    end

    -- عرض رسالة تأكيد (بدون إرسال لتجنب المشاكل)
    local confirm = Instance.new("TextLabel")
    confirm.Size = UDim2.new(1, 0, 0, 20)
    confirm.Position = UDim2.new(0, 0, 1, 5)
    confirm.BackgroundTransparency = 1
    confirm.Text = "✅ تم الاستلام!"
    confirm.TextColor3 = Color3.fromRGB(100, 255, 100)
    confirm.Font = Enum.Font.Gotham
    confirm.TextSize = 14
    confirm.Parent = frame

    wait(2)
    screenGui:Destroy()
end)
