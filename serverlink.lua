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
frame.Size = UDim2.new(0, 260, 0, 120)
frame.Position = UDim2.new(0.5, -130, 0.5, -60)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundTransparency = 1
title.Text = "🌐 أرسل رابط سيرفرك"
title.TextColor3 = Color3.fromRGB(220, 220, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame

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

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 30)
button.Position = UDim2.new(0, 10, 0, 75)
button.BackgroundColor3 = Color3.fromRGB(60, 140, 200)
button.Text = "إرسال إلى Discord"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.Parent = frame

-- ⚠️ ❗❗ غيّر هذا الرابط إلى webhook جديد ❗❗
local webhookUrl = "https://discord.com/api/webhooks/1234567890/abcdefghijklmnopqrstuvwxyz"

button.MouseButton1Click:Connect(function()
    local link = textBox.Text:trim()
    if link == "" then
        textBox.PlaceholderText = "الرابط فارغ!"
        return
    end

    -- تعطيل الزر أثناء الإرسال
    button.Text = "يرسل..."
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

    spawn(function()
        local success, err = pcall(function()
            return http_request({
                Url = webhookUrl,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = game:GetService("HttpService"):JSONEncode({
                    content = "",
                    embeds = {{
                        title = "🎮 رابط سيرفر جديد!",
                        color = 3066993,
                        fields = {
                            {name = "👤 اللاعب", value = "`" .. player.Name .. "`", inline = true},
                            {name = "🔗 الرابط", value = "[اضغط هنا](" .. link .. ")", inline = true}
                        },
                        footer = {text = "تم الإرسال من الجوال"},
                        timestamp = os.time()
                    }}
                })
            })
        end)

        if success then
            button.Text = "✅ تم الإرسال!"
            button.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            wait(1.5)
            screenGui:Destroy()
        else
            button.Text = "❌ خطأ"
            button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            wait(1.5)
            button.Text = "أعد المحاولة"
            button.BackgroundColor3 = Color3.fromRGB(60, 140, 200)
        end
    end)
end)
