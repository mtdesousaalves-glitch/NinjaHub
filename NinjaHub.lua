-- NinjaHub V7 - Auto Elite no Sub Farm
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RS = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local Gui = Instance.new("ScreenGui")
Gui.Name = "NinjaHub"
Gui.ResetOnSpawn = false
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local NinjaBtn = Instance.new("TextButton")
NinjaBtn.Size = UDim2.new(0, 50, 0, 50)
NinjaBtn.Position = UDim2.new(0, 15, 0, 110)
NinjaBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
NinjaBtn.Text = "🥷"
NinjaBtn.TextSize = 28
NinjaBtn.Parent = Gui
NinjaBtn.Active = true
NinjaBtn.Draggable = true
NinjaBtn.ZIndex = 10
Instance.new("UICorner", NinjaBtn).CornerRadius = UDim.new(1, 0)
local SN = Instance.new("UIStroke", NinjaBtn)
SN.Color = Color3.fromRGB(255, 30, 30) SN.Thickness = 2

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 580, 0, 380)
Main.Position = UDim2.new(0.5, -290, 0.5, -190)
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
Title.Text = "  NINJA HUB"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local Pages = {}
local function CreatePage(name)
    local f = Instance.new("ScrollingFrame")
    f.Size = UDim2.new(1, -30, 1, -110)
    f.Position = UDim2.new(0, 15, 0, 95)
    f.BackgroundTransparency = 1
    f.ScrollBarThickness = 3
    f.CanvasSize = UDim2.new(0,0,0,800)
    f.Visible = false
    f.Parent = Main
    local layout = Instance.new("UIListLayout", f)
    layout.Padding = UDim.new(0, 8)
    Pages[name] = f
    return f
end
local P_Main = CreatePage("Main")
local P_Home = CreatePage("Home")
local P_Farm = CreatePage("Farm")
local P_Sea = CreatePage("Sea")
local P_Player = CreatePage("Player")
P_Main.Visible = true

local function TabBtn(txt, x, pageName)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 95, 0, 28)
    b.Position = UDim2.new(0, x, 0, 52)
    b.BackgroundColor3 = Color3.fromRGB(30, 15, 15)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.Parent = Main
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function()
        for n, p in pairs(Pages) do p.Visible = (n == pageName) end
        for _, o in pairs(Main:GetChildren()) do if o:IsA("TextButton") and o.Text ~= "X" then o.BackgroundColor3 = Color3.fromRGB(30,15,15) end end
        b.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    end)
    return b
end
TabBtn("Main", 15, "Main")
TabBtn("Home", 120, "Home")
TabBtn("Sub Farm", 225, "Farm")
TabBtn("Sea Event", 330, "Sea")
TabBtn("Player", 435, "Player")

local function Toggle(parent, text, func)
    local on = false
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(25, 20, 25)
    b.Text = "  ★ "..text.." : OFF"
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.TextSize = 13
    b.Font = Enum.Font.Gotham
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function()
        on = not on
        b.Text = "  ★ "..text.." : "..(on and "ON" or "OFF")
        b.BackgroundColor3 = on and Color3.fromRGB(150, 20, 20) or Color3.fromRGB(25,20,25)
        func(on)
    end)
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
end
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

local KillAura = false
local AutoFarm = false
local FruitESP = false
local EliteHunt = false
local function Notificar(m) game:GetService("StarterGui"):SetCore("SendNotification", {Title="NINJA HUB", Text=m, Duration=5}) end
local function GetFruit()
    for _, v in pairs(workspace:GetChildren()) do if v:IsA("Tool") and string.find(v.Name, "Fruit") then return v end end
    return nil
end
local function GetPlayerInfo(plr)
    local level, bounty, fruit = "?", "?", "Sem Fruta"
    pcall(function()
        if plr:FindFirstChild("leaderstats") then
            local ls = plr.leaderstats
            if ls:FindFirstChild("Bounty/Honor") then bounty = tostring(ls["Bounty/Honor"].Value) end
            if ls:FindFirstChild("Level") then level = tostring(ls.Level.Value) end
        end
        local data = plr:FindFirstChild("Data")
        if data then
            if data:FindFirstChild("Level") then level = tostring(data.Level.Value) end
            if data:FindFirstChild("Bounty/Honor") then bounty = tostring(data["Bounty/Honor"].Value) end
            if data:FindFirstChild("DevilFruit") then fruit = tostring(data.DevilFruit.Value) end
        end
    end)
    return level, bounty, fruit
end

-- MAIN
Toggle(P_Main, "Kill Aura", function(v) KillAura = v end)
Toggle(P_Main, "Auto Farm", function(v) AutoFarm = v end)
Toggle(P_Main, "Anti-AFK", function(v) if v then LocalPlayer.Idled:Connect(function() VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new(0,0)) end) end end)

-- HOME
Toggle(P_Home, "Notificacao de Fruta", function(v) FruitESP = v end)
Botao(P_Home, "🍎 Ir ate a Fruta Spawnada", function()
    local f = GetFruit()
    if f and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = f.Handle.CFrame
        Notificar("Voce foi ate a fruta: "..f.Name)
    else Notificar("Nenhuma fruta spawnada!") end
end)
Botao(P_Home, "📦 Armazenar Fruta", function() pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit") end) Notificar("Armazenando fruta...") end)
Botao(P_Home, "🎲 Girar Fruta (Gacha)", function() pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy") end) Notificar("Girando fruta... Boa sorte!") end, true)

-- SUB FARM - AGORA COM AUTO ELITE AQUI ✅
Toggle(P_Farm, "Auto Farm Level", function(v) AutoFarm = v end)
Toggle(P_Farm, "Auto Bau / Chests", function(v) _G.AutoChest = v end)
Toggle(P_Farm, "Auto Haki", function(v) _G.AutoHaki = v end)
Label(P_Farm, "--- ELITE HUNTER ---")
Toggle(P_Farm, "Auto Elite Hunter", function(v) EliteHunt = v Notificar(v and "Elite Hunter LIGADO!" or "Elite Hunter DESLIGADO") end)
Botao(P_Farm, "⚔️ Ir para Elite Hunter NPC", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5418, 314, -2820)
        Notificar("Voce foi ate o Elite Hunter!")
    end
end)

-- SEA EVENT
Toggle(P_Sea, "Auto Sea Event", function(v) _G.SeaEvent = v end)
Toggle(P_Sea, "Auto Shark", function(v) _G.AutoShark = v end)
Toggle(P_Sea, "Auto Leviathan", function(v) _G.AutoLeviathan = v end)

-- PLAYER - SEM ELITE, SO STATUS
Label(P_Player, "--- MEU STATUS ---")
local MeuStatusLabel = Label(P_Player, "Carregando...")
Botao(P_Player, "🔄 Atualizar Meu Status", function()
    local lvl, bounty, fruit = GetPlayerInfo(LocalPlayer)
    MeuStatusLabel.Text = "  Level: "..lvl.." | Bounty: "..bounty.." | Fruta: "..fruit
    Notificar("Status atualizado! Level "..lvl.." - Bounty "..bounty)
end, true)
Botao(P_Player, "♻️ Resetar Meus Status (Refund)", function()
    pcall(function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
    end)
    Notificar("Tentando resetar status...")
end)
Toggle(P_Player, "Speed 80", function(v) if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = v and 80 or 16 end end)
Toggle(P_Player, "Auto Dragon / Dojo", function(v) _G.Dragon = v end)
Label(P_Player, "--- JOGADORES NO SERVIDOR ---")
local PlayersListFrame = Instance.new("Frame")
PlayersListFrame.Size = UDim2.new(1, -10, 0, 200)
PlayersListFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 20)
PlayersListFrame.Parent = P_Player
Instance.new("UICorner", PlayersListFrame).CornerRadius = UDim.new(0, 8)
local PlayersListLabel = Instance.new("TextLabel")
PlayersListLabel.Size = UDim2.new(1, -10, 1, -10)
PlayersListLabel.Position = UDim2.new(0, 5, 0, 5)
PlayersListLabel.BackgroundTransparency = 1
PlayersListLabel.Text = "Carregando jogadores..."
PlayersListLabel.TextColor3 = Color3.fromRGB(255,255,255)
PlayersListLabel.TextSize = 12
PlayersListLabel.Font = Enum.Font.Gotham
PlayersListLabel.TextXAlignment = Enum.TextXAlignment.Left
PlayersListLabel.TextYAlignment = Enum.TextYAlignment.Top
PlayersListLabel.TextWrapped = true
PlayersListLabel.Parent = PlayersListFrame
Botao(P_Player, "👀 Ver Status de Todos", function()
    local txt = ""
    for _, plr in pairs(Players:GetPlayers()) do
        local lvl, bounty, fruit = GetPlayerInfo(plr)
        txt = txt .. plr.Name .. " | Lv: " .. lvl .. " | Bounty: " .. bounty .. " | " .. fruit .. "\n"
    end
    PlayersListLabel.Text = txt
    Notificar("Lista atualizada!")
end, true)

NinjaBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 5)
Close.BackgroundTransparency = 1
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 50, 50)
Close.TextSize = 18
Close.Font = Enum.Font.GothamBold
Close.Parent = Main
Close.MouseButton1Click:Connect(function() Gui:Destroy() end)

local jaAvisou = false
RS.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if KillAura then
        pcall(function()
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
                    if (mob.HumanoidRootPart.Position - hrp.Position).Magnitude < 30 then
                        mob.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0,0,-3)
                        if tool then tool:Activate() end
                    end
                end
            end
        end)
    end
    if AutoFarm then
        pcall(function()
            local closest, dist = nil, 9999
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
                    local d = (mob.HumanoidRootPart.Position - hrp.Position).Magnitude
                    if d < dist then dist = d; closest = mob end
                end
            end
            if closest then hrp.CFrame = closest.HumanoidRootPart.CFrame * CFrame.new(0,5,5) if tool then tool:Activate() end end
        end)
    end
    if EliteHunt then
        pcall(function()
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if string.find(mob.Name, "Elite") or string.find(mob.Name, "Diablo") or string.find(mob.Name, "Deandre") or string.find(mob.Name, "Urban") then
                    if mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                        hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,5,5)
                        if tool then tool:Activate() end
                        break
                    end
                end
            end
        end)
    end
    local fruta = GetFruit()
    if FruitESP and fruta then
        if not jaAvisou then jaAvisou = true Notificar("🍎 FRUTA SPAWNOU: "..fruta.Name.."! Vai em Home > Ir ate a Fruta!") end
    elseif not fruta then jaAvisou = false end
end)
task.spawn(function()
    while task.wait(3) do
        if not Gui.Parent then break end
        local lvl, bounty, fruit = GetPlayerInfo(LocalPlayer)
        MeuStatusLabel.Text = "  Level: "..lvl.." | Bounty: "..bounty.." | Fruta: "..fruit
    end
end)
print("NinjaHub V7 carregado!")
