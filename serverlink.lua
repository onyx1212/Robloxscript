-- تأكد أننا في وضع اللعبة
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- حذف النافذة القديمة إن وُجدت
local screen = game:GetService("CoreGui")
if screen:FindFirstChild("DraggableServerLinkUI") then
    screen.DraggableServerLinkUI:Destroy()
end

-- إنشاء الإطار الرئيسي
local frame = Instance.new("Frame")
frame.Name = "DraggableServerLinkUI"
frame.Size = UDim2.new(0, 280, 0, 140)
frame.Position = UDim2.new(0.5, -140, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Parent = screen

-- جعل النافذة قابلة للسحب
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function updateInput(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- شريط العنوان مع زر الإغلاق
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 25)
titleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
titleBar.Parent = frame

local title = Instance.new("TextLabel")
title.Text = "🌐 أرسل رابط سيرفرك"
title.Size = UDim2.new(1, -25, 1, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = titleBar

-- زر الإغلاق (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 20, 1, 0)
closeButton.Position = UDim2.new(1, -20, 0, 0)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 100, 100)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.BackgroundTransparency = 1
closeButton.Parent = titleBar

closeButton.MouseButton1Click:Connect(function()
    frame:Destroy()
end)

-- مربع إدخال الرابط
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
sendButton.Text = "إرسال إلى Discord"
sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sendButton.Font = Enum.Font.GothamBold
sendButton.Parent = frame

-- ⚠️ غيّر هذا الرابط إلى webhook جديد آمن!
local webhookUrl = "https://discord.com/api/webhooks/1427968647116099584/45RoB84Ju4KfNZ0-FsAOQfZqOrULE2qLVTylT-kuSKfDuU0WX2MnjnrAQLDEpyet8QmO"

sendButton.MouseButton1Click:Connect(function()
    local link = textBox.Text:trim()
    if link == "" then
        textBox.PlaceholderText = "الرابط فارغ! أعد المحاولة"
        return
    end

    -- إرسال البيانات
    spawn(function()
        pcall(function()
            http_request({
                Url = webhookUrl,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = game:GetService("HttpService"):JSONEncode({
                    content = "",
                    embeds = {{
                        title = "🎮 رابط سيرفر جديد!",
                        color = 3066993,
                        fields = {
                            {name = "👤 اللاعب", value = "`" .. game.Players.LocalPlayer.Name .. "`", inline = true},
                            {name = "🔗 الرابط", value = "[اضغط هنا](" .. link .. ")", inline = true}
                        },
                        footer = {text = "تم الإرسال من الهاتف"},
                        timestamp = os.time()
                    }}
                })
            })
            -- إظهار رسالة نجاح
            sendButton.Text = "✅ تم الإرسال!"
            wait(1.5)
            frame:Destroy()
        end)
    end)
end)
