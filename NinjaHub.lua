-- ==========================================
-- 🥷 NINJA HUB — Código Completo
-- Ícone Flutuante + Interface Integrada
-- ==========================================

-- 🔹 PARTE 1: BIBLIOTECA E JANELA PRINCIPAL
-- ==========================================
-- ⚠️ IMPORTANTE: Substitua "Library" pela sua biblioteca real!
-- Exemplos: UI, Lib, MyLibrary, etc.
local Library = loadstring(game:HttpGet("COLE_AQUI_O_LINK_DA_SUA_BIBLIOTECA"))()

-- Janela Principal
local Window = Library:Window({
    Name = "NINJA HUB",
    Theme = "DarkRed",
    Size = UDim2.new(0, 520, 0, 400)
})

-- 🏠 ABA: HOME
local HomeTab = Window:Tab({Name = "🏠 Home"})
HomeTab:Toggle({Name = "Auto Level", Default = false})
HomeTab:Toggle({Name = "Anti-AFK", Default = true})
HomeTab:Toggle({Name = "Auto Claim Rewards", Default = true})
HomeTab:Slider({Name = "Walkspeed", Min = 16, Max = 100, Default = 16})
HomeTab:Slider({Name = "Jump Power", Min = 50, Max = 200, Default = 50})

-- 🌊 ABA: FARM
local FarmTab = Window:Tab({Name = "🌊 Sea & Farm"})
FarmTab:Toggle({Name = "Auto Quest", Default = false})
FarmTab:Toggle({Name = "Auto Kill NPC", Default = false})
FarmTab:Toggle({Name = "Auto Collect Drops", Default = true})
FarmTab:Dropdown({
    Name = "Target Priority",
    Options = {"Mais Perto", "Menos Vida", "Mais Vida"},
    Default = "Mais Perto"
})
FarmTab:Slider({Name = "Farm Distance", Min = 10, Max = 200, Default = 80})

-- 🍎 ABA: FRUTAS
local FruitTab = Window:Tab({Name = "🍎 Fruits"})
FruitTab:Toggle({Name = "Fruit Notifier", Default = true})
FruitTab:Toggle({Name = "Auto Store Fruit", Default = true})
FruitTab:Toggle({Name = "Fruit ESP", Default = true})
FruitTab:Toggle({Name = "Apenas Raras/Lendárias", Default = false})

-- ⚔️ ABA: RAID
local RaidTab = Window:Tab({Name = "⚔️ Raid System"})
RaidTab:Dropdown({
    Name = "Select Chip",
    Options = {"Flame", "Ice", "Quake", "Light", "Dark", "Spider", 
               "Rumble", "Magma", "Buddha", "Sand", "Phoenix", "Dough"},
    Default = "Flame"
})
RaidTab:Toggle({Name = "Auto Buy Chip ($100k)", Default = false})
RaidTab:Toggle({Name = "Start Raid", Default = false})
RaidTab:Toggle({Name = "Kill Aura", Default = false})
RaidTab:Toggle({Name = "Auto Next Island", Default = true})
RaidTab:Toggle({Name = "Auto Awake V2", Default = false})
RaidTab:Toggle({Name = "Trocar Fruta Barata", Default = false})
RaidTab:Toggle({Name = "Auto Leave Boss", Default = true})

-- 🐉 ABA: EVENTOS DO MAR
local SeaTab = Window:Tab({Name = "🐉 Sea Events"})
SeaTab:Toggle({Name = "Auto Sea Event", Default = false})
SeaTab:Toggle({Name = "Notify Events", Default = true})
SeaTab:Toggle({Name = "Auto Sea Beast", Default = false})
SeaTab:Toggle({Name = "Auto Leviathan", Default = false})

-- 👁️ ABA: VISUAL
local VisualTab = Window:Tab({Name = "👁️ Visual"})
VisualTab:Toggle({Name = "Player ESP", Default = false})
VisualTab:Toggle({Name = "NPC ESP", Default = false})
VisualTab:Toggle({Name = "Show Distance", Default = true})
VisualTab:Toggle({Name = "Show Name", Default = true})
VisualTab:Slider({Name = "ESP Distance", Min = 50, Max = 1000, Default = 400})

-- 🔹 PARTE 2: ÍCONE FLUTUANTE — ABRIR/FECHAR
-- ==========================================
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Estado da interface
local HubOpen = false

-- Criar Ícone Flutuante
local FloatingIcon = Instance.new("ScreenGui")
FloatingIcon.Name = "NinjaHub_Icon"
FloatingIcon.ResetOnSpawn = false
FloatingIcon.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local IconContainer = Instance.new("Frame")
IconContainer.Name = "IconContainer"
IconContainer.Size = UDim2.new(0, 55, 0, 55)
IconContainer.Position = UDim2.new(0.02, 0, 0.15, 0)
IconContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
IconContainer.BorderSizePixel = 0
IconContainer.Parent = FloatingIcon

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(0.5, 0)
IconCorner.Parent = IconContainer

local IconLabel = Instance.new("TextLabel")
IconLabel.Name = "NinjaIcon"
IconLabel.Size = UDim2.new(1, 0, 1, 0)
IconLabel.BackgroundTransparency = 1
IconLabel.Text = "🥷"
IconLabel.Font = Enum.Font.GothamBold
IconLabel.TextSize = 30
IconLabel.Parent = IconContainer

-- Efeito de brilho vermelho
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(220, 30, 60)
UIStroke.Transparency = 0.3
UIStroke.Parent = IconContainer

FloatingIcon.Parent = PlayerGui

-- ⚠️ IMPORTANTE: Esconde a janela no início
if Window then Window.Enabled = false end

-- Função Abrir/Fechar
local function ToggleHub()
    HubOpen = not HubOpen
    if HubOpen then
        -- Abrir
        IconContainer.BackgroundColor3 = Color3.fromRGB(30, 15, 15)
        UIStroke.Transparency = 0
        if Window then Window.Enabled = true end
        print("[🥷 NINJA HUB] ABERTO ✅")
    else
        -- Fechar
        IconContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        UIStroke.Transparency = 0.3
        if Window then Window.Enabled = false end
        print("[🥷 NINJA HUB] FECHADO ❌")
    end
end

-- Detectar Clique
IconContainer.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        task.wait(0.1) -- Evita clique duplo acidental
        ToggleHub()
    end
end)

-- Mensagem de inicialização
print("==========================================")
print("🥷 NINJA HUB carregado com sucesso!")
print("Clique no ícone 🥷 para ABRIR/FECHAR")
print("==========================================")
