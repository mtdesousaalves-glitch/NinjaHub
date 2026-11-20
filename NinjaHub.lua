-- NinjaHub V15 - Kill Aura so o nome
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RS = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")

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
Main.Size = UDim2.new(0, 580, 0, 420)
Main.Position = UDim2.new(0.5, -290, 0.5, -210)
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
    f.CanvasSize = UDim2.new(0,0,0,1000)
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
local AutoChest = false
local AutoHaki = false
local ArmaSelecionada = "Espada"
local UltimoGiro = 0
local function Notificar(m) game:GetService("StarterGui"):SetCore("SendNotification", {Title="NINJA HUB", Text=m, Duration=5}) end
local function GetFruit()
    for _, v in pairs(workspace:GetDescendants()) do if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") then return v end end
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
local function EquiparArma()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChild("Humanoid")
        if not hum then return end
        if ArmaSelecionada == "Soco" then for _, t in pairs(char:GetChildren()) do if t:IsA("Tool") then t.Parent = LocalPlayer.Backpack end end return end
        for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                local nome = tool.Name:lower()
                local achou = false
                if ArmaSelecionada == "Espada" and (string.find(nome, "sword") or string.find(nome, "katana") or string.find(nome, "blade") or string.find(nome, "saber") or string.find(nome, "trident") or string.find(nome, "pole")) then achou = true end
                if ArmaSelecionada == "Fruta" and (string.find(nome, "fruit") or string.find(nome, "flame") or string.find(nome, "ice") or string.find(nome, "dark") or string.find(nome, "light") or string.find(nome, "magma")) then achou = true end
                if ArmaSelecionada == "Arma" and (string.find(nome, "gun") or string.find(nome, "pistol") or string.find(nome, "rifle") or string.find(nome, "musket") or string.find(nome, "bazooka") or string.find(nome, "kabucha")) then achou = true end
                if achou then hum:EquipTool(tool) return end
            end
        end
    end)
end
local function Bater()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then tool:Activate() end
        VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait(0.05)
        VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("Attack") end)
    end)
end
local function FormatarTempo(segundos)
    local h = math.floor(segundos / 3600)
    local m = math.floor((segundos % 3600) / 60)
    local s = segundos % 60
    if h > 0 then return h.."h "..m.."min "..s.."s"
    elseif m > 0 then return m.."min "..s.."s"
    else return s.."s" end
end
local GiroLabel
local function GirarFruta()
    local agora = os.time()
    local COOLDOWN = 2 * 60 * 60
    if UltimoGiro ~= 0 and agora - UltimoGiro < COOLDOWN then
        local falta = COOLDOWN - (agora - UltimoGiro)
        local msg = "Voce tem "..FormatarTempo(falta).." ate girar de novo!"
        if GiroLabel then GiroLabel.Text = "  "..msg end
        Notificar(msg)
        return
    end
    Notificar("Indo ate o Cousin (Gacha) pra girar...")
    if GiroLabel then GiroLabel.Text = "  Indo ate o Cousin pra girar..." end
    task.spawn(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local cousinPos = nil
            for _, npc in pairs(workspace:GetDescendants()) do if npc:IsA("Model") and npc.Name == "Cousin" then cousinPos = npc:GetPivot().Position break end end
            if not cousinPos then cousinPos = Vector3.new(-379.8, 73.9, -245.9) end
            for i = 1, 60 do
                if not char:FindFirstChild("HumanoidRootPart") then break end
                hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(cousinPos + Vector3.new(0, 3, 3)), 0.15)
                task.wait(0.05)
                if (hrp.Position - cousinPos).Magnitude < 8 then break end
            end
            task.wait(0.8)
            pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "Buy") end)
            UltimoGiro = os.time()
            local msg2 = "Voce girou a fruta! Proximo giro em 2h!"
            if GiroLabel then GiroLabel.Text = "  "..msg2 end
            Notificar(msg2)
        end
    end)
end

-- KILL AURA - O NOME E SO "Kill Aura", SEM ESTRELA, SEM ON/OFF
local KillAuraBtn = Instance.new("TextButton")
KillAuraBtn.Size = UDim2.new(1, -10, 0, 38)
KillAuraBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 25)
KillAuraBtn.Text = "Kill Aura"
KillAuraBtn.TextColor3 = Color3.fromRGB(255,255,255)
KillAuraBtn.TextSize = 13
KillAuraBtn.Font = Enum.Font.GothamBold
KillAuraBtn.Parent = P_Main
Instance.new("UICorner", KillAuraBtn).CornerRadius = UDim.new(0, 8)
KillAuraBtn.MouseButton1Click:Connect(function()
    KillAura = not KillAura
    KillAuraBtn.BackgroundColor3 = KillAura and Color3.fromRGB(150, 20, 20) or Color3.fromRGB(25,20,25)
    KillAuraBtn.Text = "Kill Aura"
    Notificar(KillAura and "Kill Aura LIGADO" or "Kill Aura DESLIGADO")
    if KillAura then EquiparArma() end
end)

Toggle(P_Main, "Auto Farm", function(v) AutoFarm = v end)
Toggle(P_Main, "Anti-AFK", function(v) if v then LocalPlayer.Idled:Connect(function() VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new(0,0)) end) end end)

Label(P_Home, "--- FRUTA - GACHA ---")
GiroLabel = Label(P_Home, "Voce ainda nao girou!")
Botao(P_Home, "🎲 Girar Fruta (Gacha)", function() GirarFruta() end, true)
Botao(P_Home, "📦 Armazenar Fruta", function()
    local achou = false
    pcall(function()
        local char = LocalPlayer.Character
        if char then for _, tool in pairs(char:GetChildren()) do if tool:IsA("Tool") and string.find(tool.Name:lower(), "fruit") then ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", tool.Name, tool) achou = true Notificar("Guardada: "..tool.Name) return end end end
        for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do if tool:IsA("Tool") and string.find(tool.Name:lower(), "fruit") then if char then char.Humanoid:EquipTool(tool) end task.wait(0.5) ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", tool.Name, tool) achou = true Notificar("Guardada: "..tool.Name) return end end
    end)
    if not achou then Notificar("Sem fruta pra guardar!") end
end)
local FrutaServerLabel = Label(P_Home, "Nenhuma fruta no servidor...")
Toggle(P_Home, "Notificacao de Fruta", function(v) FruitESP = v end)
Botao(P_Home, "🍎 Ver se tem Fruta no Servidor", function()
    local f = GetFruit()
    if f then FrutaServerLabel.Text = "  TEM FRUTA! "..f.Name Notificar("TEM FRUTA! "..f.Name) else FrutaServerLabel.Text = "  Nenhuma fruta..." Notificar("Nenhuma fruta...") end
end)
Botao(P_Home, "🍎 Ir ate a Fruta Spawnada", function()
    local f = GetFruit()
    if f and LocalPlayer.Character then local pos = f:FindFirstChild("Handle") and f.Handle.Position or f:GetPivot().Position LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0,3,0)) end
end)

Label(P_Farm, "--- ESCOLHER ARMA DO FARM ---")
local ArmaLabel = Label(P_Farm, "Arma atual: Espada ⚔️")
for _, info in pairs({{"👊 Soco / Melee","Soco"},{"🍎 Fruta","Fruta"},{"⚔️ Espada","Espada"},{"🔫 Arma / Gun","Arma"}}) do
    Botao(P_Farm, info[1], function() ArmaSelecionada = info[2] ArmaLabel.Text = "Arma atual: "..info[1] EquiparArma() Notificar("Arma: "..info[2]) end)
end
Label(P_Farm, "--- AUTO FARM VOANDO ---")
Toggle(P_Farm, "Auto Farm Voando", function(v) AutoFarm = v if v then EquiparArma() end end)
Toggle(P_Farm, "Auto Bau / Chests", function(v) AutoChest = v end)
Toggle(P_Farm, "Auto Haki", function(v) AutoHaki = v end)
Label(P_Farm, "--- ELITE HUNTER ---")
Toggle(P_Farm, "Auto Elite Hunter", function(v) EliteHunt = v end)
Botao(P_Farm, "⚔️ Ir para Elite Hunter NPC", function() if LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5418, 314, -2820) end end)

Toggle(P_Sea, "Auto Sea Event", function(v) _G.SeaEvent = v end)
Toggle(P_Sea, "Auto Shark", function(v) _G.AutoShark = v end)
Toggle(P_Sea, "Auto Leviathan", function(v) _G.AutoLeviathan = v end)

Label(P_Player, "--- MEU STATUS ---")
local MeuStatusLabel = Label(P_Player, "Carregando...")
Botao(P_Player, "🔄 Atualizar Meu Status", function() local lvl, bounty, fruit = GetPlayerInfo(LocalPlayer) MeuStatusLabel.Text = "  Level: "..lvl.." | Bounty: "..bounty.." | Fruta: "..fruit end, true)
Botao(P_Player, "♻️ Resetar Meus Status", function() pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1") ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2") end) end)
Toggle(P_Player, "Speed 80", function(v) if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = v and 80 or 16 end end)
Label(P_Player, "--- JOGADORES ---")
local PlayersListLabel = Label(P_Player, "Clique em Ver Status")
Botao(P_Player, "👀 Ver Status de Todos", function() local txt = "" for _, plr in pairs(Players:GetPlayers()) do local lvl, bounty, fruit = GetPlayerInfo(plr) txt = txt..plr.Name.." | Lv: "..lvl.." | Bounty: "..bounty.."\n" end PlayersListLabel.Text = txt end, true)

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
local chestCooldown = 0
local equipCooldown = 0
local baterCooldown = 0
RS.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if KillAura then
        pcall(function()
            if tick() > baterCooldown then
                for _, mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
                        local dist = (mob.HumanoidRootPart.Position - hrp.Position).Magnitude
                        if dist < 20 then Bater() baterCooldown = tick() + 0.3 break end
                    end
                end
            end
        end)
        return
    end
    if AutoFarm then
        pcall(function()
            if tick() > equipCooldown then equipCooldown = tick() + 2 EquiparArma() end
            local closest, dist = nil, 9999
            for _, mob in pairs(workspace.Enemies:GetChildren()) do if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then local d = (mob.HumanoidRootPart.Position - hrp.Position).Magnitude if d < dist then dist = d; closest = mob end end end
            if closest then hrp.CFrame = hrp.CFrame:Lerp(closest.HumanoidRootPart.CFrame * CFrame.new(0, 5, 3), 0.2) hrp.Velocity = Vector3.new(0,0,0) if dist < 12 and tick() > baterCooldown then Bater() baterCooldown = tick() + 0.3 end end
        end)
    end
    if EliteHunt then
        pcall(function()
            for _, mob in pairs(workspace.Enemies:GetChildren()) do if string.find(mob.Name, "Elite") or string.find(mob.Name, "Diablo") or string.find(mob.Name, "Deandre") or string.find(mob.Name, "Urban") then if mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then hrp.CFrame = hrp.CFrame:Lerp(mob.HumanoidRootPart.CFrame * CFrame.new(0,5,3), 0.2) if tick() > baterCooldown then Bater() baterCooldown = tick() + 0.3 end break end end end
        end)
    end
    if AutoChest and tick() > chestCooldown then
        pcall(function()
            local closestChest, dist = nil, 9999
            for _, obj in pairs(workspace:GetDescendants()) do if obj.Name == "Chest1" or obj.Name == "Chest2" or obj.Name == "Chest3" then if obj:IsA("Part") or obj:IsA("MeshPart") then local d = (obj.Position - hrp.Position).Magnitude if d < dist then dist = d; closestChest = obj end end end end
            if closestChest then hrp.CFrame = hrp.CFrame:Lerp(closestChest.CFrame * CFrame.new(0,3,0), 0.3) chestCooldown = tick() + 1.5 end
        end)
    end
    local fruta = GetFruit()
    if FruitESP then
        if fruta then if not jaAvisou then jaAvisou = true FrutaServerLabel.Text = "  TEM FRUTA! "..fruta.Name Notificar("🍎 FRUTA SPAWNOU: "..fruta.Name.."!") end else jaAvisou = false FrutaServerLabel.Text = "  Nenhuma fruta... Vigiando..." end
    end
end)
task.spawn(function()
    while task.wait(3) do
        if not Gui.Parent then break end
        local lvl, bounty, fruit = GetPlayerInfo(LocalPlayer)
        MeuStatusLabel.Text = "  Level: "..lvl.." | Bounty: "..bounty.." | Fruta: "..fruit
    end
end)
print("NinjaHub V15 carregado!")
