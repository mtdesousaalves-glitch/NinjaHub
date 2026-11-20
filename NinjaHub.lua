-- NinjaHub | Blox Fruits
-- by mtdesousaalves-glitch

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NinjaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 330, 0, 400)
Main.Position = UDim2.new(0.5, -165, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "NINJA HUB"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

local function CreateButton(text, y, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 38)
    Btn.Position = UDim2.new(0.05, 0, 0, y)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255,255,255)
    Btn.TextSize = 14
    Btn.Font = Enum.Font.Gotham
    Btn.Parent = Main
    local C = Instance.new("UICorner")
    C.CornerRadius = UDim.new(0, 8)
    C.Parent = Btn
    Btn.MouseButton1Click:Connect(function() callback(Btn) end)
    return Btn
end

local AntiAFK = false
CreateButton("Anti-AFK: OFF", 60, function(btn)
    AntiAFK = not AntiAFK
    btn.Text = AntiAFK and "Anti-AFK: ON" or "Anti-AFK: OFF"
    btn.BackgroundColor3 = AntiAFK and Color3.fromRGB(0, 170, 80) or Color3.fromRGB(30,30,40)
    if AntiAFK then
        LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new(0,0))
        end)
    end
end)

local AutoFarm = false
CreateButton("Auto Farm: OFF", 105, function(btn)
    AutoFarm = not AutoFarm
    btn.Text = AutoFarm and "Auto Farm: ON" or "Auto Farm: OFF"
    btn.BackgroundColor3 = AutoFarm and Color3.fromRGB(0, 170, 80) or Color3.fromRGB(30,30,40)
end)

CreateButton("Auto Sea Event", 150, function() print("Sea Event") end)
CreateButton("Auto Dragon / Dojo", 195, function() print("Dragon") end)
CreateButton("Teleport Sea 1 / 2 / 3", 240, function() print("Teleport") end)
CreateButton("Fechar Hub", 300, function() ScreenGui:Destroy() end)

print("NinjaHub carregado!")
