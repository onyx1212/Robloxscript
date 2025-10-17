-- إنشاء زر في الشاشة
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 120, 0, 40)
button.Position = UDim2.new(0.5, -60, 0.5, -20) -- مركّز
button.AnchorPoint = Vector2.new(0.5, 0.5)
button.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.Text = "امشي متر"
button.BorderSizePixel = 0
button.Parent = game:GetService("CoreGui")

-- حدث الضغط
button.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
    
    if humanoidRootPart then
        -- اتجاه النظر (إلى الأمام من كاميرا اللاعب)
        local camera = game.Workspace.CurrentCamera
        local lookVector = camera.CFrame.LookVector
        
        -- تحريك اللاعب متر واحد للأمام
        humanoidRootPart.CFrame = humanoidRootPart.CFrame + (lookVector * 1)
    end
end)
