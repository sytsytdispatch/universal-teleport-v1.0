local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

local ScreenGui1 = Instance.new("ScreenGui")
ScreenGui1.Parent = PlayerGui
ScreenGui1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Frame1 = Instance.new("Frame")
Frame1.Parent = ScreenGui1
Frame1.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Frame1.BorderSizePixel = 0
Frame1.Position = UDim2.new(0.374, 0, 0.215, 0)
Frame1.Size = UDim2.new(0, 203, 0, 207)

local UICorner1 = Instance.new("UICorner")
UICorner1.CornerRadius = UDim.new(0, 30)
UICorner1.Parent = Frame1

local TextLabel1 = Instance.new("TextLabel")
TextLabel1.Parent = Frame1
TextLabel1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextLabel1.Position = UDim2.new(0, 0, 0.097, 0)
TextLabel1.Size = UDim2.new(0, 200, 0, 50)
TextLabel1.Font = Enum.Font.LuckiestGuy
TextLabel1.Text = "CREDITS"
TextLabel1.TextColor3 = Color3.fromRGB(255, 0, 0)
TextLabel1.TextScaled = true

local TextLabel2 = Instance.new("TextLabel")
TextLabel2.Parent = Frame1
TextLabel2.BackgroundColor3 = Color3.fromRGB(6, 53, 23)
TextLabel2.Position = UDim2.new(0, 0, 0.338, 0)
TextLabel2.Size = UDim2.new(0, 200, 0, 50)
TextLabel2.Font = Enum.Font.SourceSans
TextLabel2.Text = "MADE BY SYTSYTDISPATCH"
TextLabel2.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel2.TextScaled = true

local TextLabel3 = Instance.new("TextLabel")
TextLabel3.Parent = Frame1
TextLabel3.BackgroundColor3 = Color3.fromRGB(8, 34, 204)
TextLabel3.Position = UDim2.new(0, 0, 0.58, 0)
TextLabel3.Size = UDim2.new(0, 200, 0, 31)
TextLabel3.Font = Enum.Font.SourceSans
TextLabel3.Text = "https://discord.gg/4xPkdpE6A8"
TextLabel3.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel3.TextStrokeColor3 = Color3.fromRGB(223, 216, 12)
TextLabel3.TextScaled = true

local TextButton1 = Instance.new("TextButton")
TextButton1.Parent = Frame1
TextButton1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
TextButton1.Position = UDim2.new(0.182, 0, 0.758, 0)
TextButton1.Size = UDim2.new(0, 120, 0, 43)
TextButton1.Font = Enum.Font.LuckiestGuy
TextButton1.Text = "NEXT"
TextButton1.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton1.TextScaled = true

local ScreenGui2 = Instance.new("ScreenGui")
ScreenGui2.Parent = PlayerGui
ScreenGui2.Enabled = false

local Frame2 = Instance.new("Frame")
Frame2.Size = UDim2.new(0.3, 0, 0.6, 0)
Frame2.Position = UDim2.new(0.35, 0, 0.2, 0)
Frame2.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Frame2.Parent = ScreenGui2

local TopBar = Instance.new("TextLabel")
TopBar.Size = UDim2.new(1, 0, 0, 60)
TopBar.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
TopBar.Text = "Universal Teleportation"
TopBar.TextScaled = true
TopBar.Font = Enum.Font.LuckiestGuy
TopBar.Parent = Frame2

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 0, 0)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.LuckiestGuy
CloseButton.Parent = TopBar

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 1, -60)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 60)
ScrollingFrame.ScrollBarThickness = 10
ScrollingFrame.Parent = Frame2

local function createPlayerButton(player)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -20, 0, 50)
    Button.Text = player.Name
    Button.TextScaled = true
    Button.Parent = ScrollingFrame

    local Avatar = Instance.new("ImageLabel")
    Avatar.Size = UDim2.new(0, 50, 0, 50)
    Avatar.Position = UDim2.new(0, 0, 0, 0)
    Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
    Avatar.Parent = Button

    Button.MouseButton1Click:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame)
        end
    end)

    return Button
end

local function updatePlayerList()
    local existingPlayers = {}
    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        if child:IsA("TextButton") then
            existingPlayers[child.Text] = child
        end
    end

    local yOffset = 0
    for _, player in ipairs(Players:GetPlayers()) do
        local Button = existingPlayers[player.Name]
        if not Button then
            Button = createPlayerButton(player)
        end
        Button.Position = UDim2.new(0, 10, 0, yOffset)
        yOffset = yOffset + 60
    end

    for name, Button in pairs(existingPlayers) do
        if not Players:FindFirstChild(name) then
            Button:Destroy()
        end
    end

    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
game:GetService("RunService").Stepped:Connect(updatePlayerList)

local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    Frame2.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame2.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui2.Enabled = false
    game.StarterGui:SetCore("SendNotification", {
        Title = "Universal Teleportation",
        Text = "Press L to bring back the GUI",
        Duration = 5
    })
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.L then
        ScreenGui2.Enabled = not ScreenGui2.Enabled
    end
end)

TextButton1.MouseButton1Click:Connect(function()
    ScreenGui1.Enabled = false
    ScreenGui2.Enabled = true
end)
