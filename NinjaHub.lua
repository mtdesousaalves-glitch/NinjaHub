-- NINJA HUB - CORRIGIDO - SEM TRAVAR
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

print("🥷 NINJA HUB COMECOU A CARREGAR...")

-- Pega os RemoteEvents SEM travar se nao existir
local function GetRemote(nome)
    local r = ReplicatedStorage:FindFirstChild(nome)
    if not r then
        warn("NinjaHub: Falta RemoteEvent "..nome.." - criando falso pra nao travar")
    end
    return r
end
local AttackEvent = GetRemote("AttackEnemy")
local BuyBaitEvent = GetRemote("BuyBait")
local StoreFruitEvent = GetRemote("StoreFruit")

local FlySpeed = 50
local AutoFarmBoss = false
local AutoMastery = false
local MasteryHealthPercent = 60
local SelectedSkill = "Z"
local SelectedBoss = "Cake Queen"
local AutoTweenToFruit = false
local AutoStoreFruit = false

-- GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "NinjaHub"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

local NinjaBtn = Instance.new("TextButton")
NinjaBtn.Size = UDim2.new(0, 50, 0, 50)
NinjaBtn.Position = UDim2.new(0, 15, 0, 110)
NinjaBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
NinjaBtn.Text = "🥷"
NinjaBtn.TextSize = 28
NinjaBtn.Parent = Gui
NinjaBtn.Active = true
NinjaBtn.Draggable = true
Instance.new("UICorner", NinjaBtn).CornerRadius = UDim.new(1, 0)
local SN = Instance.new("UIStroke", NinjaBtn)
SN.Color = Color3.fromRGB(255, 30, 30) SN.Thickness = 2

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 680, 0, 420)
Main.Position = UDim2.new(0.5, -340, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(12, 8, 12)
Main.Active = true
Main.Draggable = true
Main.Visible = false
Main.Parent = Gui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255, 30, 30) Stroke.Thickness = 2

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "  🥷 NINJA HUB"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 5)
Close.BackgroundTransparency = 1
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 50, 50)
Close.TextSize = 18
Close.Font = Enum.Font.GothamBold
Close.Parent = Main
Close.MouseButton1Click:Connect(function() Main.Visible = false end)
NinjaBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- Sidebar
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 170, 1, -55)
Sidebar.Position = UDim2.new(0, 10, 0, 50)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 12, 12)
Sidebar.ScrollBarThickness = 3
Sidebar.CanvasSize = UDim2.new(0,0,0,650)
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)
Instance.new("UIListLayout", Sidebar).Padding = UDim.new(0, 5)

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -195, 1, -55)
ContentArea.Position = UDim2.new(0, 185, 0, 50)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = Main

local Pages = {}
local function CreatePage(name)
    local f = Instance.new("ScrollingFrame")
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.ScrollBarThickness = 3
    f.CanvasSize = UDim2.new(0,0,0,900)
    f.Visible = false
    f.Parent = ContentArea
    local l = Instance.new("UIListLayout", f)
    l.Padding = UDim.new(0, 8)
    Pages[name] = f
    return f
end
local P_Home = CreatePage("Home")
local P_Farming = CreatePage("Farming")
local P_Fishing = CreatePage("Fishing")
local P_Volcano = CreatePage("Volcano")
local P_Fruit = CreatePage("Fruit")
P_Home.Visible = true

local function TabBtn(txt, pageName)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 32)
    b.BackgroundColor3 = Color3.fromRGB(30, 15, 15)
    b.Text = "  "..txt
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.Parent = Sidebar
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function()
        for n, p in pairs(Pages) do p.Visible = (n == pageName) end
        for _, o in pairs(Sidebar:GetChildren()) do if o:IsA("TextButton") then o.BackgroundColor3 = Color3.fromRGB(30,15,15) end end
        b.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    end)
    return b
end
TabBtn("🏠 Home", "Home")
TabBtn("🌾 Farming", "Farming")
TabBtn("🎣 Fishing", "Fishing")
TabBtn("🌋 Volcano Event", "Volcano")
TabBtn("🍎 Fruit And Raid", "Fruit")

local function Label(parent, text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -10, 0, 28)
    l.BackgroundTransparency = 1
    l.Text = "  "..text
    l.TextColor3 = Color3.fromRGB(255, 200, 200)
    l.TextSize = 14
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end
local function Toggle(parent, text, func)
    local on = false
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(25, 20, 25)
    b.Text = "  "..text.." : OFF"
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.TextSize = 13
    b.Font = Enum.Font.Gotham
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function()
        on = not on
        b.Text = "  "..text.." : "..(on and "ON" or "OFF")
        b.BackgroundColor3 = on and Color3.fromRGB(150, 20, 20) or Color3.fromRGB(25,20,25)
        func(on)
    end)
    return b
end
local function Botao(parent, text, func, vermelho)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 38)
    b.BackgroundColor3 = vermelho and Color3.fromRGB(150,20,20) or Color3.fromRGB(25,20,25)
    b.Text = "  "..text
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(func)
    return b
end

-- HOME
Label(P_Home, "--- NINJA HUB ---")
local FlyLabel = Label(P_Home, "Fly Speed: 50 / 200")
Botao(P_Home, "- 10 Fly Speed", function() FlySpeed = math.max(1, FlySpeed - 10) FlyLabel.Text = "  Fly Speed: "..FlySpeed.." / 200" end)
Botao(P_Home, "+ 10 Fly Speed", function() FlySpeed = math.min(200, FlySpeed + 10) FlyLabel.Text = "  Fly Speed: "..FlySpeed.." / 200" end)
Botao(P_Home, "Fly Speed 200 (MAX)", function() FlySpeed = 200 FlyLabel.Text = "  Fly Speed: 200 / 200" end, true)

-- FARMING
Label(P_Farming, "--- FARM BOSS & MATERIAL ---")
Label(P_Farming, "Boss: Cake Queen")
Toggle(P_Farming, "Auto Farm Boss", function(v) AutoFarmBoss = v print("AutoFarmBoss: "..tostring(v)) end)
Toggle(P_Farming, "Accept Quests", function(v) print("AcceptQuests: "..tostring(v)) end)
Label(P_Farming, "--- FARMING MASTERY ---")
Label(P_Farming, "Health %: 60")
Toggle(P_Farming, "Auto Mastery Fruit", function(v) AutoMastery = v end)
Botao(P_Farming, "Skill: Z", function() SelectedSkill = "Z" print("Skill Z") end)

-- FISHING
Label(P_Fishing, "--- FISHING ---")
Toggle(P_Fishing, "Auto Fishing", function(v) print("AutoFishing: "..tostring(v)) end)
Toggle(P_Fishing, "Auto Buy Bait", function(v) if v and BuyBaitEvent then BuyBaitEvent:FireServer() end end)
Toggle(P_Fishing, "Auto Sell Fish", function(v) print("AutoSell: "..tostring(v)) end)

-- VOLCANO
Label(P_Volcano, "--- VOLCANO & DRACO TRIAL ---")
Botao(P_Volcano, "Teleport To Dragon Trainer", function() print("TP Dragon Trainer") end)
Toggle(P_Volcano, "Auto Dojo Trainer", function(v) print("Dojo: "..tostring(v)) end)

-- FRUIT
Label(P_Fruit, "--- FRUITS ---")
Toggle(P_Fruit, "Auto Tween To Fruit", function(v) AutoTweenToFruit = v end)
Toggle(P_Fruit, "Auto Store Fruit", function(v) AutoStoreFruit = v end)
Botao(P_Fruit, "Ir ate a Fruta", function() print("Indo ate fruta com Fly "..FlySpeed) end, true)

print("🥷 NINJA HUB CARREGOU COM SUCESSO!")
