loadstring([===[
-- Delta Roblox Executor - Desync Script for "Steal a Brainrot"
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

-- UI for Mobile (Simple Button)
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0.5, -75, 0.9, -30) -- أسفل الشاشة، مركّز
button.AnchorPoint = Vector2.new(0.5, 0.5)
button.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.Text = "تشغيل ديسنك"
button.BorderSizePixel = 0
button.Parent = game:GetService("CoreGui")

-- Variable to track if desync is active
local desyncActive = false

-- Function to desync the character
local function desyncCharacter()
    while desyncActive do
        -- Disable collisions
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end

        -- Teleport the character to a random position
        local randomX = math.random(-100, 100)
        local randomY = math.random(10, 50)
        local randomZ = math.random(-100, 100)
        character:MoveTo(Vector3.new(randomX, randomY, randomZ))

        -- Wait for a short period before repeating
        task.wait(0.1)
    end
end

-- Toggle desync on button click
button.MouseButton1Click:Connect(function()
    desyncActive = not desyncActive
    if desyncActive then
        button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        button.Text = "إيقاف ديسنك"
        spawn(desyncCharacter)
    else
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
        button.Text = "تشغيل ديسنك"
    end
end)

-- Also toggle with "E" key (for PC/Keyboard users)
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.E then
        desyncActive = not desyncActive
        if desyncActive then
            button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            button.Text = "إيقاف ديسنك"
            spawn(desyncCharacter)
        else
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            button.Text = "تشغيل ديسنك"
        end
    end
end)
]===])()
