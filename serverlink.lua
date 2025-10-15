-- إنشاء واجهة المستخدم
local screen = game:GetService("CoreGui")

if screen:FindFirstChild("ServerLinkGUI") then
    screen.ServerLinkGUI:Destroy()
end

local frame = Instance.new("Frame")
frame.Name = "ServerLinkGUI"
frame.Size = UDim2.new(0, 320, 0, 130)
frame.Position = UDim2.new(0.5, -160, 0.5, -65)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Parent = screen

local title = Instance.new("TextLabel")
title.Text = "أدخل رابط السيرفر الخاص بك"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 200)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -20, 0, 30)
textBox.Position = UDim2.new(0, 10, 0, 40)
textBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.ClearTextOnFocus = false
textBox.PlaceholderText = "مثل: https://www.roblox.com/games/123456789"
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 30)
button.Position = UDim2.new(0, 10, 0, 80)
button.BackgroundColor3 = Color3.fromRGB(60, 150, 200)
button.Text = "إرسال الرابط"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.Parent = frame

-- ⚠️ ضع هنا رابط webhook **الجديد** بعد حذف القديم!
local webhookUrl = "https://discord.com/api/webhooks/1427968647116099584/45RoB84Ju4KfNZ0-FsAOQfZqOrULE2qLVTylT-kuSKfDuU0WX2MnjnrAQLDEpyet8QmO"

button.MouseButton1Click:Connect(function()
    local link = textBox.Text:trim()
    if link == "" then
        warn("الرابط فارغ!")
        return
    end

    spawn(function()
        local success, res = pcall(function()
            return http_request({
                Url = webhookUrl,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = game:GetService("HttpService"):JSONEncode({
                    content = "",
                    embeds = {{
                        title = "🎮 رابط سيرفر جديد!",
                        color = 3066993, -- أخضر
                        fields = {
                            {
                                name = "👤 اللاعب",
                                value = "`" .. game.Players.LocalPlayer.Name .. "`",
                                inline = true
                            },
                            {
                                name = "🔗 الرابط",
                                value = "[اضغط هنا](" .. link .. ")",
                                inline = true
                            }
                        },
                        footer = {text = "تم الإرسال في " .. os.date("%Y-%m-%d %H:%M")},
                        timestamp = os.time()
                    }}
                })
            })
        end)

        if success then
            print("✅ تم إرسال الرابط إلى Discord!")
        else
            warn("❌ خطأ:", res)
        end
    end)
end)
