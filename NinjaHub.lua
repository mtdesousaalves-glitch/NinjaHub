-- NinjaHub V14 - Giro de Fruta CORRIGIDO
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RS = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Gui = Instance.new("ScreenGui")
Gui.Name = "NinjaHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- ICONE SHURIKEN
local NinjaBtn = Instance.new("TextButton")
NinjaBtn.Size = UDim2.new(0, 70, 0, 70)
NinjaBtn.Position = UDim2.new(0, 20, 0.5, -35)
NinjaBtn.BackgroundTransparency = 1
NinjaBtn.Text = "✦"
NinjaBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
NinjaBtn.TextSize = 70
NinjaBtn.Font = Enum.Font.GothamBlack
NinjaBtn.Parent = Gui
NinjaBtn.Active = true
NinjaBtn.Draggable = true
NinjaBtn.ZIndex = 10
local Centro = Instance.new("Frame")
Centro.Size = UDim2.new(0, 14, 0, 14)
Centro.Position = UDim2.new(0.5, -7, 0.5, -7)
Centro.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
Centro.Parent = NinjaBtn
Instance.new("UICorner", Centro).CornerRadius = UDim.new(1,0)

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 720, 0, 440)
Main.Position = UDim2.new(0.5, -360, 0.5, -220)
Main.BackgroundColor3 = Color3.fromRGB(8, 5, 10)
Main.Active = true
Main.Draggable = true
Main.Visible = false
Main.Parent = Gui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)
local Borda = Instance.new("UIStroke", Main)
Borda.Color = Color3.fromRGB(255, 30, 30) Borda.Thickness = 2 Borda.Transparency = 0.3

local Topo = Instance.new("Frame")
Topo.Size = UDim2.new(1, 0, 0, 55)
Topo.BackgroundTransparency = 1
Topo.Parent = Main
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 220, 0, 40)
Logo.Position = UDim2.new(0, 15, 0, 8)
Logo.BackgroundTransparency = 1
Logo.Text = "🩸 NINJA HUB"
Logo.TextColor3 = Color3.fromRGB(255,255,255)
Logo.TextSize = 22
Logo.Font = Enum.Font.GothamBlack
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = Topo
local Fechar = Instance.new("TextButton")
Fechar.Size = UDim2.new(0, 30, 0, 30)
Fechar.Position = UDim2.new(1, -35, 0, 10)
Fechar.BackgroundTransparency = 1
Fechar.Text = "X"
Fechar.TextColor3 = Color3.fromRGB(255,255,255)
Fechar.TextSize = 20
Fechar.Font = Enum.Font.GothamBold
Fechar.Parent = Topo
Fechar.MouseButton1Click:Connect(function() Gui:Destroy() end)

local Pages = {}
local function CreatePage(name)
    local f = Instance.new("ScrollingFrame")
    f.Size = UDim2.new(1, -20, 1, -110)
    f.Position = UDim2.new(0, 10, 0, 100)
    f.BackgroundTransparency = 1
    f.ScrollBarThickness = 3
    f.CanvasSize = UDim2.new(0,0,0,900)
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
    b.Size = UDim2.new(0, 105, 0, 32)
    b.Position = UDim2.new(0, x, 0, 62)
    b.BackgroundTransparency = 1
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(180, 180, 180)
    b.TextSize = 14
    b.Font = Enum.Font.GothamBold
    b.Parent = Main
    b.MouseButton1Click:Connect(function()
        for n, p in pairs(Pages) do p.Visible = (n == pageName) end
        b.TextColor3 = Color3.fromRGB(255,255,255)
    end)
    return b
end
TabBtn("⭕ Main", 195, "Main")
TabBtn("🏠 Home", 300, "Home")
TabBtn("✖️ Sub Farm", 405, "Farm")
TabBtn("🌊 Sea Event", 510, "Sea")
TabBtn("👤 Player", 615, "Player")

local function Toggle(parent, text, func)
    local on = false
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 48)
    b.BackgroundColor3 = Color3.fromRGB(18, 10, 16)
    b.Text = ""
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", b).Color = Color3.fromRGB(255,30,30)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "★ "..text
    lbl.TextColor3 = Color3.fromRGB(255,255,255)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = b
    local bolinha = Instance.new("Frame")
    bolinha.Size = UDim2.new(0, 24, 0, 24)
    bolinha.Position = UDim2.new(1, -35, 0.5, -12)
    bolinha.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    bolinha.Parent = b
    Instance.new("UICorner", bolinha).CornerRadius = UDim.new(1,0)
    b.MouseButton1Click:Connect(function()
        on = not on
        bolinha.BackgroundColor3 = on and Color3.fromRGB(255, 30, 30) or Color3.fromRGB(80,80,80)
        func(on)
    end)
    return b
end
local function Botao(parent, text, func)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(18, 10, 16)
    b.Text = "  "..text
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", b).Color = Color3.fromRGB(255,30,30)
    b.MouseButton1Click:Connect(func)
    return b
end
local function Label(parent, text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -10, 0, 28)
    l.BackgroundTransparency = 1
    l.Text = "  "..text
    l.TextColor3 = Color3.fromRGB(255, 200, 100)
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
local function Notificar(m) game:GetService("StarterGui"):SetCore("SendNotification", {Title="NINJA HUB", Text=m, Duration=6}) end
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
                if ArmaSelecionada == "Espada" and (string.find(nome, "sword") or string.find(nome, "katana") or string.find(nome, "blade") or string.find(nome, "saber")) then achou = true end
                if ArmaSelecionada == "Fruta" and (string.find(nome, "fruit") or string.find(nome, "flame") or string.find(nome, "ice") or string.find(nome, "dark") or string.find(nome, "light")) then achou = true end
                if ArmaSelecionada == "Arma" and (string.find(nome, "gun") or string.find(nome, "pistol") or string.find(nome, "rifle") or string.find(nome, "kabucha")) then achou = true end
                if achou then hum:EquipTool(tool) return end
            end
        end
    end)
end

-- ===== FORMATA TEMPO: 1h 23min 45s / 23min 10s / 45s =====
local function FormatarTempo(segundos)
    local h = math.floor(segundos / 3600)
    local m = math.floor((segundos % 3600) / 60)
    local s = segundos % 60
    if h > 0 then
        return h.."h "..m.."min "..s.."s"
    elseif m > 0 then
        return m.."min "..s.."s"
    else
        return s.."s"
    end
end

-- ===== GIRO DE FRUTA - NOVO JEITO =====
local GiroLabel
local function GirarFruta()
    local agora = os.time()
    local COOLDOWN = 2 * 60 * 60 -- 2 horas do Blox Fruits

    -- SE JA GIROU: mostra quanto falta
    if UltimoGiro ~= 0 and agora - UltimoGiro < COOLDOWN then
        local falta = COOLDOWN - (agora - UltimoGiro)
        local tempoTexto = FormatarTempo(falta)
        local msg = "Voce tem "..tempoTexto.." ate girar de novo!"
        if GiroLabel then GiroLabel.Text = "  "..msg end
        Notificar(msg)
        return
    end

    -- SE NAO GIROU: vai ate o NPC Cousin e gira normal
    Notificar("Indo ate o Cousin (Gacha) pra girar...")
    if GiroLabel then GiroLabel.Text = "  Indo ate o Cousin pra girar..." end

    -- Posicao do Cousin (Gacha) - 2nd Sea / Cafe
    -- Se voce ja tiver la perto, ele gira na hora. Se nao, ele vai voando ate la
    task.spawn(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            -- Procura o NPC Cousin no mapa
            local cousinPos = nil
            for _, npc in pairs(workspace:GetDescendants()) do
                if npc:IsA("Model") and (npc.Name == "Cousin" or npc.Name == "Gacha") then
                    local hum = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Humanoid")
                    if hum then cousinPos = hum.Position or npc:GetPivot().Position break end
                end
            end
            -- Se nao achar o NPC, vai pra posicao do Cafe / 2nd Sea onde ele fica
            if not cousinPos then cousinPos = Vector3.new(-379.8, 73.9, -245.9) end

            -- Vai ate o NPC (voando suave)
            for i = 1, 50 do
                if not char or not char:FindFirstChild("HumanoidRootPart") then break end
                hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(cousinPos + Vector3.new(0, 3, 3)), 0.15)
                task.wait(0.05)
                -- Se ja chegou perto, para
                if (hrp.Position - cousinPos).Magnitude < 8 then break end
            end
            task.wait(0.8)
            -- AGORA GIRA NORMAL
            local sucesso = pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "Buy")
            end)
            if sucesso then
                UltimoGiro = os.time()
                local msg2 = "Voce girou a fruta! Boa sorte! Proximo giro em 2h!"
                if GiroLabel then GiroLabel.Text = "  "..msg2 end
                Notificar(msg2)
            else
                Notificar("Cheguei no Cousin mas nao deu pra girar. Fala com ele!")
            end
        end
    end)
end

Toggle(P_Main, "Kill Aura - Bate em quem chegar perto", function(v) KillAura = v end)
Toggle(P_Main, "Auto Farm Voando", function(v) AutoFarm = v if v then EquiparArma() end end)
Toggle(P_Main, "Anti-AFK", function(v) if v then LocalPlayer.Idled:Connect(function() VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new(0,0)) end) end end)

-- HOME - FRUTA CORRIGIDA
Label(P_Home, "--- FRUTA - GACHA ---")
GiroLabel = Label(P_Home, "Voce ainda nao girou nessa sessao!")
Botao(P_Home, "🎲 Girar Fruta (Gacha)", function() GirarFruta() end)
Label(P_Home, "Se ja girou, vai aparecer quanto falta. Se nao girou, vai ate o NPC e gira!")
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
Toggle(P_Home, "Notificacao de Fruta no Servidor", function(v) FruitESP = v end)
Botao(P_Home, "🍎 Ver se tem Fruta no Servidor", function()
    local f = GetFruit()
    if f then FrutaServerLabel.Text = "  TEM FRUTA! "..f.Name Notificar("TEM FRUTA! "..f.Name) else FrutaServerLabel.Text = "  Nenhuma fruta..." Notificar("Nenhuma fruta...") end
end)
Botao(P_Home, "🍎 Ir ate a Fruta Spawnada", function()
    local f = GetFruit()
    if f and LocalPlayer.Character then local pos = f:FindFirstChild("Handle") and f.Handle.Position or f:GetPivot().Position LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0,3,0)) end
end)

Label(P_Farm, "--- ESCOLHER ARMA ---")
local ArmaLabel = Label(P_Farm, "Arma atual: Espada ⚔️")
for _, info in pairs({{"👊 Soco / Melee","Soco"},{"🍎 Fruta","Fruta"},{"⚔️ Espada","Espada"},{"🔫 Arma / Gun","Arma"}}) do
    Botao(P_Farm, info[1], function() ArmaSelecionada = info[2] ArmaLabel.Text = "Arma atual: "..info[1] EquiparArma() Notificar("Arma: "..info[2]) end)
end
Label(P_Farm, "--- AUTO FARM ---")
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
Botao(P_Player, "🔄 Atualizar Meu Status", function() local lvl, bounty, fruit = GetPlayerInfo(LocalPlayer) MeuStatusLabel.Text = "  Level: "..lvl.." | Bounty: "..bounty.." | Fruta: "..fruit end)
Botao(P_Player, "♻️ Resetar Meus Status", function() pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1") ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2") end) end)
Toggle(P_Player, "Speed 80", function(v) if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = v and 80 or 16 end end)
Label(P_Player, "--- JOGADORES ---")
local PlayersListLabel = Label(P_Player, "Clique em Ver Status")
Botao(P_Player, "👀 Ver Status de Todos", function() local txt = "" for _, plr in pairs(Players:GetPlayers()) do local lvl, bounty, fruit = GetPlayerInfo(plr) txt = txt..plr.Name.." | Lv: "..lvl.." | Bounty: "..bounty.."\n" end PlayersListLabel.Text = txt end)

NinjaBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

local jaAvisou = false
local chestCooldown = 0
local equipCooldown = 0
RS.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if KillAura then
        pcall(function()
            if tool then for _, mob in pairs(workspace.Enemies:GetChildren()) do if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then if (mob.HumanoidRootPart.Position - hrp.Position).Magnitude < 18 then tool:Activate() break end end end end
        end)
        return
    end
    if AutoFarm then
        pcall(function()
            if tick() > equipCooldown then equipCooldown = tick() + 2 EquiparArma() end
            local closest, dist = nil, 9999
            for _, mob in pairs(workspace.Enemies:GetChildren()) do if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then local d = (mob.HumanoidRootPart.Position - hrp.Position).Magnitude if d < dist then dist = d; closest = mob end end end
            if closest then hrp.CFrame = hrp.CFrame:Lerp(closest.HumanoidRootPart.CFrame * CFrame.new(0, 5, 3), 0.2) hrp.Velocity = Vector3.new(0,0,0) if dist < 12 then tool = char:FindFirstChildOfClass("Tool") if tool then tool:Activate() end end end
        end)
    end
    if EliteHunt then
        pcall(function()
            for _, mob in pairs(workspace.Enemies:GetChildren()) do if string.find(mob.Name, "Elite") or string.find(mob.Name, "Diablo") or string.find(mob.Name, "Deandre") or string.find(mob.Name, "Urban") then if mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then hrp.CFrame = hrp.CFrame:Lerp(mob.HumanoidRootPart.CFrame * CFrame.new(0,5,3), 0.2) if tool then tool:Activate() end break end end end
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
print("NinjaHub V14 carregado!")
