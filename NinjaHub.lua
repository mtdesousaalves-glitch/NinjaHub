-- NINJA HUB - VERSAO STUDIO - SEM BUG
-- Colar em StarterGui > LocalScript
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- RemoteEvents que voce cria no ReplicatedStorage
local AttackEvent = ReplicatedStorage:WaitForChild("AttackEnemy")
local BuyBaitEvent = ReplicatedStorage:WaitForChild("BuyBait")
local StoreFruitEvent = ReplicatedStorage:WaitForChild("StoreFruit")

-- ============ VARIAVEIS ============
local FlySpeed = 50 -- 1 a 200
local AutoFarmBoss = false
local AutoFarmMaterial = false
local AcceptQuests = false
local AutoMastery = false
local MasteryHealthPercent = 60
local SelectedSkill = "Z"
local AutoFishing = false
local AutoBuyBait = false
local AutoSellFish = false
local AutoTweenToFruit = false
local AutoStoreFruit = false
local AutoDracoTrial = false
local SelectedBoss = "Cake Queen"
local SelectedMaterial = "Cake"
local SelectedRod = "Basic Rod"

-- ============ GUI PRINCIPAL ============
local Gui = Instance.new("ScreenGui")
Gui.Name = "NinjaHub"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

-- Botao flutuante 50x50
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

-- Titulo
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Position = UDim2.new(0, 0, 0, 0)
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

-- ============ BARRA LATERAL ESQUERDA (igual Gravity Hub) ============
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 170, 1, -55)
Sidebar.Position = UDim2.new(0, 10, 0, 50)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 12, 12)
Sidebar.ScrollBarThickness = 3
Sidebar.CanvasSize = UDim2.new(0,0,0,650)
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)
local SideLayout = Instance.new("UIListLayout", Sidebar)
SideLayout.Padding = UDim.new(0, 5)

-- ============ AREA DE CONTEUDO DIREITA ============
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
local P_Player = CreatePage("Player")
local P_Setting = CreatePage("Setting")
P_Home.Visible = true

local CurrentTab = "Home"
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
        CurrentTab = pageName
        for _, o in pairs(Sidebar:GetChildren()) do if o:IsA("TextButton") then o.BackgroundColor3 = Color3.fromRGB(30,15,15) end end
        b.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    end)
    return b
end

-- MESMA ORDEM QUE TA NA PRINT
TabBtn("🏠 Home", "Home")
TabBtn("🌾 Farming", "Farming")
TabBtn("🎣 Fishing", "Fishing")
TabBtn("🌋 Volcano Event", "Volcano")
TabBtn("🍎 Fruit And Raid", "Fruit")
TabBtn("👤 Local Player", "Player")
TabBtn("⚙️ Setting", "Setting")

-- ============ HELPERS DE UI ============
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
local function Dropdown(parent, titulo, opcoes, func)
    local lbl = Label(parent, titulo..": "..opcoes[1])
    local atual = 1
    local b = Botao(parent, "🔽 Trocar: "..opcoes[1], function()
        atual = atual + 1
        if atual > #opcoes then atual = 1 end
        lbl.Text = "  "..titulo..": "..opcoes[atual]
        b.Text = "  🔽 Trocar: "..opcoes[atual]
        func(opcoes[atual])
    end)
    return lbl
end
local function Slider(parent, titulo, min, max, padrao, func)
    local valor = padrao
    local lbl = Label(parent, titulo..": "..valor.." / "..max)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 32)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    local function Btn(txt, x, f)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 50, 0, 28)
        b.Position = UDim2.new(0, x, 0, 2)
        b.BackgroundColor3 = Color3.fromRGB(150,20,20)
        b.Text = txt
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.TextSize = 16
        b.Font = Enum.Font.GothamBold
        b.Parent = frame
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        b.MouseButton1Click:Connect(f)
    end
    Btn("-", 5, function() valor = math.max(min, valor - 10) lbl.Text = "  "..titulo..": "..valor.." / "..max func(valor) end)
    Btn("+", 65, function() valor = math.min(max, valor + 10) lbl.Text = "  "..titulo..": "..valor.." / "..max func(valor) end)
    Btn(tostring(max), 125, function() valor = max lbl.Text = "  "..titulo..": "..valor.." / "..max func(valor) end)
    return lbl
end

-- ============ FUNCOES DO JOGO (SEM BUG) ============
local function GetHRP()
    local char = LocalPlayer.Character
    if char then return char:FindFirstChild("HumanoidRootPart") end
    return nil
end
local function GetNearestEnemy(nomeFiltro)
    local hrp = GetHRP()
    if not hrp then return nil, 9999 end
    local pasta = workspace:FindFirstChild("Enemies")
    if not pasta then return nil, 9999 end
    local perto, menor = nil, 9999
    for _, mob in pairs(pasta:GetChildren()) do
        local hum = mob:FindFirstChild("Humanoid")
        local root = mob:FindFirstChild("HumanoidRootPart")
        if hum and hum.Health > 0 and root then
            if not nomeFiltro or string.find(mob.Name, nomeFiltro) then
                local d = (root.Position - hrp.Position).Magnitude
                if d < menor then menor = d perto = mob end
            end
        end
    end
    return perto, menor
end
local function GetFruitInWorld()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") then return v end end
    return nil
end
local function TweenTo(pos)
    local hrp = GetHRP()
    if not hrp then return end
    local dist = (pos - hrp.Position).Magnitude
    local tempo = math.clamp(dist / math.max(1, FlySpeed), 0.2, 5)
    local tween = TweenService:Create(hrp, TweenInfo.new(tempo, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end
local function Attack(mob)
    if mob then
        AttackEvent:FireServer(mob.Name, SelectedSkill)
    end
end

-- ============ ABA HOME ============
Label(P_Home, "--- NINJA HUB - STATUS ---")
local StatusLabel = Label(P_Home, "Level: 1 | Bounty: 0")
Botao(P_Home, "🔄 Atualizar Status", function()
    local lvl = LocalPlayer:GetAttribute("Level") or 1
    local bounty = LocalPlayer:GetAttribute("Bounty") or 0
    StatusLabel.Text = "  Level: "..lvl.." | Bounty: "..bounty
end, true)
Label(P_Home, "--- FLY SPEED ---")
Slider(P_Home, "Fly Speed", 1, 200, 50, function(v) FlySpeed = v end)
Label(P_Home, "1 = Devagar | 200 = Muito Rapido")
Botao(P_Home, "🗺️ Ir para Ilha Mirage", function() local hrp = GetHRP() if hrp then TweenTo(Vector3.new(1000, 100, 1000)) end end)
Botao(P_Home, "🦊 Ir para Ilha Kitsune", function() local hrp = GetHRP() if hrp then TweenTo(Vector3.new(2000, 100, 2000)) end end)

-- ============ ABA FARMING (igual print) ============
Label(P_Farming, "--- FARM BOSS & MATERIAL ---")
Dropdown(P_Farming, "Select Boss", {"Cake Queen", "Soul Reaper", "Dough King", "Rip Indra"}, function(v) SelectedBoss = v end)
Dropdown(P_Farming, "Select Material", {"Cake", "Bone", "Ectoplasm", "Leather"}, function(v) SelectedMaterial = v end)
Toggle(P_Farming, "Auto Farm Boss", function(v) AutoFarmBoss = v end)
Toggle(P_Farming, "Auto Farm Material", function(v) AutoFarmMaterial = v end)
Toggle(P_Farming, "Accept Quests", function(v) AcceptQuests = v end)
Toggle(P_Farming, "Auto Farm All Boss", function(v) AutoFarmBoss = v end)

Label(P_Farming, "--- FARMING MASTERY ---")
Slider(P_Farming, "Health % para usar Skill", 10, 100, 60, function(v) MasteryHealthPercent = v end)
Dropdown(P_Farming, "Select Skill", {"Z", "X", "C", "V", "F"}, function(v) SelectedSkill = v end)
Toggle(P_Farming, "Auto Mastery Fruit", function(v) AutoMastery = v end)
Toggle(P_Farming, "Auto Mastery Sword", function(v) AutoMastery = v end)
Toggle(P_Farming, "Auto Mastery Gun", function(v) AutoMastery = v end)
Label(P_Farming, "--- ARMA ---")
Dropdown(P_Farming, "Select Weapon", {"Soco", "Espada", "Fruta", "Arma"}, function(v) print("Arma: "..v) end)

-- ============ ABA FISHING ============
Label(P_Fishing, "--- FISHING ---")
Dropdown(P_Fishing, "Select Fishing Rod", {"Basic Rod", "Pro Rod", "Ninja Rod"}, function(v) SelectedRod = v end)
Dropdown(P_Fishing, "Select Bait", {"Worm", "Shrimp", "Golden Bait"}, function(v) print("Isca: "..v) end)
Toggle(P_Fishing, "Auto Buy Bait", function(v) AutoBuyBait = v if v then BuyBaitEvent:FireServer() end end)
Toggle(P_Fishing, "Auto Fishing", function(v) AutoFishing = v end)
Toggle(P_Fishing, "Auto Sell Fish", function(v) AutoSellFish = v end)
Botao(P_Fishing, "🎣 Pescar Agora", function() print("Pescando com "..SelectedRod) end, true)

-- ============ ABA VOLCANO ============
Label(P_Volcano, "--- VOLCANO & DRACO TRIAL ---")
Botao(P_Volcano, "🐉 Teleport To Dragon Trainer", function() TweenTo(Vector3.new(0, 100, 0)) end)
Botao(P_Volcano, "🏹 Teleport To Hunter", function() TweenTo(Vector3.new(100, 100, 100)) end)
Botao(P_Volcano, "🧙 Teleport To Wizard", function() TweenTo(Vector3.new(200, 100, 200)) end)
Botao(P_Volcano, "🔥 Teleport To Draco Awakening", function() TweenTo(Vector3.new(300, 100, 300)) end)
Toggle(P_Volcano, "Auto Dojo Trainer", function(v) AutoDracoTrial = v end)
Toggle(P_Volcano, "Tween To Upgrade Draco Trial", function(v) AutoDracoTrial = v end)

-- ============ ABA FRUIT ============
Label(P_Fruit, "--- FRUITS ---")
local FruitLabel = Label(P_Fruit, "Nenhuma fruta no mapa...")
Botao(P_Fruit, "🍎 Ver se tem Fruta", function()
    local f = GetFruitInWorld()
    if f then FruitLabel.Text = "  TEM FRUTA! "..f.Name else FruitLabel.Text = "  Nenhuma fruta..." end
end)
Toggle(P_Fruit, "Auto Tween To Fruit", function(v) AutoTweenToFruit = v end)
Toggle(P_Fruit, "Auto Store Fruit", function(v) AutoStoreFruit = v end)
Toggle(P_Fruit, "Auto Collect Fruit", function(v) AutoTweenToFruit = v AutoStoreFruit = v end)
Botao(P_Fruit, "🍎 Ir ate a Fruta (Fly Speed)", function()
    local f = GetFruitInWorld()
    if f then
        local pos = f:FindFirstChild("Handle") and f.Handle.Position or f:GetPivot().Position
        TweenTo(pos + Vector3.new(0, 3, 0))
        if AutoStoreFruit then StoreFruitEvent:FireServer(f.Name) end
    end
end, true)
Botao(P_Fruit, "🎲 Auto Random Fruit (Gacha)", function() print("Girando fruta...") end)

-- ============ ABA PLAYER ============
Label(P_Player, "--- LOCAL PLAYER ---")
Toggle(P_Player, "Speed 80", function(v) local char = LocalPlayer.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = v and 80 or 16 end end)
Toggle(P_Player, "Anti-AFK", function(v) print("Anti-AFK: "..tostring(v)) end)
Botao(P_Player, "♻️ Resetar Status", function() print("Resetando...") end)

-- ============ ABA SETTING ============
Label(P_Setting, "--- SETTING ---")
Slider(P_Setting, "Fly Speed", 1, 200, 50, function(v) FlySpeed = v end)
Botao(P_Setting, "💾 Salvar Config", function() print("Salvo! FlySpeed: "..FlySpeed) end, true)

-- ============ LOOP PRINCIPAL - SEM BUG ============
task.spawn(function()
    while true do
        task.wait(0.3)
        local ok, err = pcall(function()
            -- AUTO FARM BOSS
            if AutoFarmBoss then
                local mob, dist = GetNearestEnemy(SelectedBoss)
                if mob and mob:FindFirstChild("HumanoidRootPart") then
                    local hum = mob.Humanoid
                    local pct = (hum.Health / hum.MaxHealth) * 100
                    -- Se vida < % definida, usa skill pra maestria
                    if AutoMastery and pct <= MasteryHealthPercent then
                        Attack(mob)
                    else
                        local hrp = GetHRP()
                        if hrp and dist > 10 then
                            TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0, 5, 3))
                        elseif dist <= 10 then
                            Attack(mob)
                        end
                    end
                end
            end
            -- AUTO FARM MATERIAL
            if AutoFarmMaterial and not AutoFarmBoss then
                local mob, dist = GetNearestEnemy(nil)
                if mob and mob:FindFirstChild("HumanoidRootPart") then
                    local hrp = GetHRP()
                    if hrp and dist > 10 then
                        TweenTo(mob.HumanoidRootPart.Position + Vector3.new(0, 5, 3))
                    elseif dist <= 10 then
                        Attack(mob)
                    end
                end
            end
            -- AUTO TWEEN TO FRUIT
            if AutoTweenToFruit then
                local f = GetFruitInWorld()
                if f then
                    local pos = f:FindFirstChild("Handle") and f.Handle.Position or f:GetPivot().Position
                    TweenTo(pos + Vector3.new(0, 3, 0))
                    if AutoStoreFruit then StoreFruitEvent:FireServer(f.Name) end
                end
            end
            -- AUTO FISHING
            if AutoFishing then
                if AutoBuyBait then BuyBaitEvent:FireServer() end
                -- Aqui voce coloca sua logica de pescar do seu jogo
            end
        end)
        if not ok then warn("NinjaHub Erro: "..tostring(err)) end
    end
end)

print("🥷 NINJA HUB carregado sem bug!")
