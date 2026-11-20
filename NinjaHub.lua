-- NinjaHub V3 - Botao Ninja + X fecha tudo
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RS = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local Gui = Instance.new("ScreenGui")
Gui.Name = "NinjaHub"
Gui.ResetOnSpawn = false
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- BOTAO NINJA FLUTUANTE
local NinjaBtn = Instance.new("TextButton")
NinjaBtn.Size = UDim2.new(0, 55, 0, 55)
NinjaBtn.Position = UDim2.new(0, 20, 0.5, -27)
NinjaBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
NinjaBtn.Text = "🥷"
NinjaBtn.TextSize = 30
NinjaBtn.Font = Enum.Font.GothamBold
NinjaBtn.Parent = Gui
NinjaBtn.Active = true
NinjaBtn.Draggable = true
Instance.new("UICorner", NinjaBtn).CornerRadius = UDim.new(1, 0)
local StrokeN = Instance.new("UIStroke", NinjaBtn)
StrokeN.Color = Color3.fromRGB(255, 30, 30)
StrokeN.Thickness = 2

-- JANELA PRINCIPAL
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 560, 0, 360)
Main.Position = UDim2.new(0.5, -280, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(12, 8, 12)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Visible = false -- comeca fechado, so o ninja aparece
Main.Parent = Gui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255, 30, 30)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "  NINJA HUB"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local function TabBtn(txt, x)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 90, 0, 28)
    b.Position = UDim2.new(0, x, 0, 52)
    b.BackgroundColor3 = Color3.fromRGB(30, 15, 15)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.Parent = Main
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    return b
end
TabBtn("Main", 15)
TabBtn("Home", 115)
TabBtn("Sub Farm", 215)
TabBtn("Sea Event", 315)
TabBtn("Player", 415)

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -30, 1, -110)
Content.Position = UDim2.new(0, 15, 0, 95)
Content.BackgroundTransparency = 1
Content.Parent = Main

local function Toggle(text, y, x, func)
    local on = false
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.48, 0, 0, 38)
    b.Position = UDim2.new(x, 0, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(25, 20, 25)
    b.Text = "★ "..text.." : OFF"
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.TextSize = 13
    b.Font = Enum.Font.Gotham
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.Parent = Content
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function()
        on = not on
        b.Text = "★ "..text.." : "..(on and "ON" or "OFF")
        b.BackgroundColor3 = on and Color3.fromRGB(150, 20, 20) or Color3.fromRGB(25,20,25)
        func(on)
    end)
end

local KillAura = false
Toggle("Kill Aura", 0, 0, function(v) KillAura = v end)
Toggle("Auto Farm", 48, 0, function(v) _G.AutoFarm = v end)
Toggle("Auto Sea Event", 96, 0, function(v) _G.SeaEvent = v end)
Toggle("Auto Dragon / Dojo", 144, 0, function(v) _G.Dragon = v end)
Toggle("Anti-AFK", 0, 0.52, function(v)
    if v then
        LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new(0,0))
        end)
    end
end)

-- BOTAO NINJA ABRE / FECHA
NinjaBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- X FECHA DE VEZ
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 5)
Close.BackgroundTransparency = 1
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 50, 50)
Close.TextSize = 18
Close.Font = Enum.Font.GothamBold
Close.Parent = Main
Close.MouseButton1Click:Connect(function()
    Gui:Destroy() -- some TUDO, ate o ninja
end)

-- LOOP KILL AURA
RS.Heartbeat:Connect(function()
    if not KillAura then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local tool = char:FindFirstChildOfClass("Tool")
    if not hrp then return end
    pcall(function()
        for _, mob in pairs(workspace.Enemies:GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
                if (mob.HumanoidRootPart.Position - hrp.Position).Magnitude < 25 then
                    if tool then tool:Activate() end
                end
            end
        end
    end)
end)

print("NinjaHub V3 carregado!")
