-- NinjaHub | Blox Fruits
-- by mtdesousaalves-glitch

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NinjaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 320, 0, 380)
Main.Position = UDim2.new(0.5, -160, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "🥷 NINJA HUB"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

local function CreateButton(text, y, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 40)
    Btn.Position = UDim2.new(0.05, 0, 0, y)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255,255,255)
    Btn.TextSize = 15
    Btn.Font = Enum.Font.Gotham
    Btn.Parent = Main
    local C = Instance.new("UICorner")
    C.CornerRadius = UDim.new(0, 8)
    C.Parent = Btn
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local AutoFarm = false
CreateButton("Auto Farm: OFF", 70, function(btn)
    AutoFarm = not AutoFarm
    btn.Text = AutoFarm and "Auto Farm: ON" or "Auto Farm: OFF"
    btn.BackgroundColor3 = AutoFarm and Color3.fromRGB(0, 170, 80) or Color3.fromRGB(30,30,40)
end)

CreateButton("Auto Sea Event", 120, function()
    print("NinjaHub: Sea Event ativado")
end)

CreateButton("Auto Dragon / Dojo", 170, function()
    print("NinjaHub: Dragon ativado")
end)

CreateButton("Teleport: Sea 1 / 2 / 3", 220, function()
    print("NinjaHub: Teleport")
end)

CreateButton("Fechar Hub", 280, function()
    ScreenGui:Destroy()
end)

print("NinjaHub carregado com sucesso!")
