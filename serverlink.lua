local HttpService = game:GetService("HttpService")
local webhook = "https://discord.com/api/webhooks/..." -- ضع webhook جديد هنا

spawn(function()
    local success, msg = pcall(function()
        HttpService:PostAsync(webhook, HttpService:JSONEncode({content = "اختبار من الجوال!"}))
    end)
    print("النتيجة:", success, msg)
end)
