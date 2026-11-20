-- ==========================================
-- 🎯 URIEL XITER ANDROID 1.108.X — ATUALIZADO
-- Ícone Flutuante + Aimbot Funcional + ESP Esqueleto Branco
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer

-- 🔹 CONFIGURAÇÕES GLOBAIS
local Config = {
    JanelaAberta = false,
    
    -- Aimbot
    AimbotAtivo = true,
    BalaMagica = false,
    CabecaSeta = false,
    ExibirFOV = false,
    ValorFOV = 18,
    ModoFOV = "Regular FOV",
    Alvo = "Cabeça",
    
    -- ESP
    ESPAtivo = false,
    EsqueletoBranco = true,
    NomeJogador = true,
    Distancia = true,
    TimeColor = false
}

-- ==========================================
-- 🔹 PARTE 1: ÍCONE FLUTUANTE
-- ==========================================

local IconoSistema = Instance.new("ScreenGui")
IconoSistema.Name = "UrielXiter_Icon"
IconoSistema.ResetOnSpawn = false

local BotaoIcone = Instance.new("Frame")
BotaoIcone.Name = "BotaoIcone"
BotaoIcone.Size = UDim2.new(0, 70, 0, 70)
BotaoIcone.Position = UDim2.new(0.02, 0, 0.15, 0)
BotaoIcone.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
BotaoIcone.BorderSizePixel = 0
BotaoIcone.CornerRadius = UDim.new(0, 12)
BotaoIcone.Parent = IconoSistema

local Contorno = Instance.new("UIStroke")
Contorno.Thickness = 3
Contorno.Color = Color3.fromRGB(220, 30, 60)
Contorno.Transparency = 0.1
Contorno.Parent = BotaoIcone

local TextoIcone = Instance.new("TextLabel")
TextoIcone.Size = UDim2.new(1, 0, 1, 0)
TextoIcone.BackgroundTransparency = 1
TextoIcone.Text = "UX"
TextoIcone.Font = Enum.Font.GothamBold
TextoIcone.TextColor3 = Color3.fromRGB(255, 40, 70)
TextoIcone.TextSize = 28
TextoIcone.Parent = BotaoIcone

IconoSistema.Parent = PlayerGui

-- ==========================================
-- 🔹 PARTE 2: JANELA PRINCIPAL
-- ==========================================

local JanelaSistema = Instance.new("ScreenGui")
JanelaSistema.Name = "UrielXiter_Window"
JanelaSistema.Enabled = false

local Janela = Instance.new("Frame")
Janela.Name = "Janela"
Janela.Size = UDim2.new(0, 360, 0, 340)
Janela.Position = UDim2.new(0.5, -180, 0.5, -170)
Janela.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Janela.BorderSizePixel = 0
Janela.CornerRadius = UDim.new(0, 6)
Janela.Parent = JanelaSistema

-- Barra do topo
local BarraTopo = Instance.new("Frame")
BarraTopo.Name = "BarraTopo"
BarraTopo.Size = UDim2.new(1, 0, 0, 32)
BarraTopo.BackgroundColor3 = Color3.fromRGB(190, 20, 50)
BarraTopo.CornerRadius = UDim.new(0, 6)
BarraTopo.Parent = Janela

local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, -10, 1, 0)
Titulo.Position = UDim2.new(0, 10, 0, 0)
Titulo.BackgroundTransparency = 1
Titulo.Text = "URIEL XITER ANDROID 1.108.X"
Titulo.Font = Enum.Font.GothamBold
Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
Titulo.TextSize = 14
Titulo.TextXAlignment = Enum.TextXAlignment.Left
Titulo.Parent = BarraTopo

-- Abas
local AbaContainer = Instance.new("Frame")
AbaContainer.Size = UDim2.new(1, 0, 0, 30)
AbaContainer.Position = UDim2.new(0, 0, 0, 35)
AbaContainer.BackgroundTransparency = 1
AbaContainer.Parent = Janela

local BotaoAimbot = Instance.new("TextButton")
BotaoAimbot.Name = "Aba_Aimbot"
BotaoAimbot.Size = UDim2.new(0.333, 0, 1, 0)
BotaoAimbot.BackgroundColor3 = Color3.fromRGB(50, 15, 25)
BotaoAimbot.Font = Enum.Font.GothamBold
BotaoAimbot.Text = "🎯 Aimbot"
BotaoAimbot.TextColor3 = Color3.fromRGB(255, 60, 90)
BotaoAimbot.TextSize = 12
BotaoAimbot.AutoButtonColor = false
BotaoAimbot.Parent = AbaContainer

local BotaoEsp = Instance.new("TextButton")
BotaoEsp.Name = "Aba_Esp"
BotaoEsp.Size = UDim2.new(0.333, 0, 1, 0)
BotaoEsp.Position = UDim2.new(0.333, 0, 0, 0)
BotaoEsp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BotaoEsp.Font = Enum.Font.Gotham
BotaoEsp.Text = "👁️ Esp"
BotaoEsp.TextColor3 = Color3.fromRGB(200, 200, 200)
BotaoEsp.TextSize = 12
BotaoEsp.AutoButtonColor = false
BotaoEsp.Parent = AbaContainer

local BotaoInfo = Instance.new("TextButton")
BotaoInfo.Name = "Aba_Info"
BotaoInfo.Size = UDim2.new(0.334, 0, 1, 0)
BotaoInfo.Position = UDim2.new(0.666, 0, 0, 0)
BotaoInfo.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BotaoInfo.Font = Enum.Font.Gotham
BotaoInfo.Text = "ℹ️ Info"
BotaoInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
BotaoInfo.TextSize = 12
BotaoInfo.AutoButtonColor = false
BotaoInfo.Parent = AbaContainer

-- Área de conteúdo
local ConteudoAimbot = Instance.new("ScrollingFrame")
ConteudoAimbot.Name = "ConteudoAimbot"
ConteudoAimbot.Size = UDim2.new(1, -16, 1, -80)
ConteudoAimbot.Position = UDim2.new(0, 8, 0, 70)
ConteudoAimbot.BackgroundTransparency = 1
ConteudoAimbot.ScrollBarThickness = 4
ConteudoAimbot.ScrollBarColor3 = Color3.fromRGB(100, 100, 100)
ConteudoAimbot.CanvasSize = UDim2.new(0, 0, 0, 350)
ConteudoAimbot.Visible = true
ConteudoAimbot.Parent = Janela

local ConteudoEsp = Instance.new("ScrollingFrame")
ConteudoEsp.Name = "ConteudoEsp"
ConteudoEsp.Size = UDim2.new(1, -16, 1, -80)
ConteudoEsp.Position = UDim2.new(0, 8, 0, 70)
ConteudoEsp.BackgroundTransparency = 1
ConteudoEsp.ScrollBarThickness = 4
ConteudoEsp.ScrollBarColor3 = Color3.fromRGB(100, 100, 100)
ConteudoEsp.CanvasSize = UDim2.new(0, 0, 0, 300)
ConteudoEsp.Visible = false
ConteudoEsp.Parent = Janela

local ConteudoInfo = Instance.new("ScrollingFrame")
ConteudoInfo.Name = "ConteudoInfo"
ConteudoInfo.Size = UDim2.new(1, -16, 1, -80)
ConteudoInfo.Position = UDim2.new(0, 8, 0, 70)
ConteudoInfo.BackgroundTransparency = 1
ConteudoInfo.ScrollBarThickness = 4
ConteudoInfo.ScrollBarColor3 = Color3.fromRGB(100, 100, 100)
ConteudoInfo.CanvasSize = UDim2.new(0, 0, 0, 200)
ConteudoInfo.Visible = false
ConteudoInfo.Parent = Janela

-- ==========================================
-- 🔹 FUNÇÕES AUXILIARES — TOGGLE COM CONTROLE
-- ==========================================

local function CriarToggle(Nome, Posicao, ConfigKey, ConteudoPai)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 28)
    Container.Position = Posicao
    Container.BackgroundTransparency = 1
    Container.Parent = ConteudoPai

    local Check = Instance.new("Frame")
    Check.Size = UDim2.new(0, 18, 0, 18)
    Check.Position = UDim2.new(0, 0, 0.5, -9)
    Check.BackgroundColor3 = Config[ConfigKey] and Color3.fromRGB(220, 30, 60) or Color3.fromRGB(60, 60, 60)
    Check.BorderSizePixel = 0
    Check.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -26, 1, 0)
    Label.Position = UDim2.new(0, 26, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = Nome
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container

    local Botao = Instance.new("TextButton")
    Botao.Size = UDim2.new(1, 0, 1, 0)
    Botao.BackgroundTransparency = 1
    Botao.Text = ""
    Botao.Parent = Container

    Botao.MouseButton1Click:Connect(function()
        Config[ConfigKey] = not Config[ConfigKey]
        Check.BackgroundColor3 = Config[ConfigKey] and Color3.fromRGB(220, 30, 60) or Color3.fromRGB(60, 60, 60)
        print("✅ " .. Nome .. ": " .. (Config[ConfigKey] and "ATIVADO" or "DESATIVADO"))
    end)
    return Container
end

local function CriarSlider(Nome, ValorMin, ValorMax, ConfigKey, Posicao, ConteudoPai)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 40)
    Container.Position = Posicao
    Container.BackgroundTransparency = 1
    Container.Parent = ConteudoPai

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 18)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = Nome .. ": " .. Config[ConfigKey]
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container

    local FundoBarra = Instance.new("Frame")
    FundoBarra.Size = UDim2.new(1, 0, 0, 8)
    FundoBarra.Position = UDim2.new(0, 0, 0, 22)
    FundoBarra.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    FundoBarra.Parent = Container

    local Barra = Instance.new("Frame")
    Barra.Size = UDim2.new((Config[ConfigKey] - ValorMin) / (ValorMax - ValorMin), 0, 1, 0)
    Barra.BackgroundColor3 = Color3.fromRGB(220, 30, 60)
    Barra.Parent = FundoBarra

    return Container
end

local function CriarDropdown(Nome, Opcoes, ConfigKey, Posicao, ConteudoPai)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 28)
    Container.Position = Posicao
    Container.BackgroundTransparency = 1
    Container.Parent = ConteudoPai

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 180, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = Nome
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container

    local Caixa = Instance.new("TextButton")
    Caixa.Size = UDim2.new(0, 140, 0, 22)
    Caixa.Position = UDim2.new(1, -140, 0.5, -11)
    Caixa.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Caixa.Font = Enum.Font.Gotham
    Caixa.Text = Config[ConfigKey]
    Caixa.TextColor3 = Color3.fromRGB(255, 255, 255)
    Caixa.TextSize = 11
    Caixa.AutoButtonColor = false
    Caixa.Parent = Container

    return Container
end

-- ==========================================
-- 🔹 ABA AIMBOT
-- ==========================================

CriarToggle("Ativar Aimbot", UDim2.new(0, 0, 0, 0), "AimbotAtivo", ConteudoAimbot)
CriarToggle("Bala mágica", UDim2.new(0, 0, 0, 35), "BalaMagica", ConteudoAimbot)
CriarToggle("Cabeça + Seta", UDim2.new(0, 0, 0, 70), "CabecaSeta", ConteudoAimbot)
CriarToggle("Exibir Círculo do FOV", UDim2.new(0, 0, 0, 105), "ExibirFOV", ConteudoAimbot)
CriarSlider("FOV", 0, 300, "ValorFOV", UDim2.new(0, 0, 0, 145), ConteudoAimbot)
CriarDropdown("Modo FOV", {"Regular FOV", "Dinâmico"}, "ModoFOV", UDim2.new(0, 0, 0, 200), ConteudoAimbot)
CriarDropdown("Alvo", {"Cabeça", "Peito", "Pés"}, "Alvo", UDim2.new(0, 0, 0, 240), ConteudoAimbot)

-- ==========================================
-- 🔹 ABA ESP — ESQUELETO BRANCO
-- ==========================================

CriarToggle("Ativar ESP", UDim2.new(0, 0, 0, 0), "ESPAtivo", ConteudoEsp)
CriarToggle("Esqueleto Branco", UDim2.new(0, 0, 0, 35), "EsqueletoBranco", ConteudoEsp)
CriarToggle("Nome do Jogador", UDim2.new(0, 0, 0, 70), "NomeJogador", ConteudoEsp)
CriarToggle("Mostrar Distância", UDim2.new(0, 0, 0, 105), "Distancia", ConteudoEsp)
CriarToggle("Cor por Time", UDim2.new(0, 0, 0, 140), "TimeColor", ConteudoEsp)

-- ==========================================
-- 🔹 ABA INFO
-- ==========================================

local InfoTexto = Instance.new("TextLabel")
InfoTexto.Size = UDim2.new(1, 0, 1, 0)
InfoTexto.BackgroundTransparency = 1
InfoTexto.Text = "URIEL XITER ANDROID\nVersão: 1.108.X\n\nDesenvolvido para Servidor Privado\nUse com seu amigo apenas!\n\n⚠️ Não use em jogos públicos"
InfoTexto.Font = Enum.Font.Gotham
InfoTexto.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoTexto.TextSize = 13
InfoTexto.TextWrapped = true
InfoTexto.TextXAlignment = Enum.TextXAlignment.Center
InfoTexto.TextYAlignment = Enum.TextYAlignment.Center
InfoTexto.Parent = ConteudoInfo

JanelaSistema.Parent = PlayerGui

-- ==========================================
-- 🔹 SISTEMA DE ESP — ESQUELETO BRANCO
-- ==========================================

local ESPStorage = {}
local Bonecos = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "LowerTorso"},
    {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"},
    {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"},
    {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"},
    {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"},
}

local function CriarESPJogador(Jogador)
    local ESP = {
        Linhas = {},
        NomeLabel = nil,
        DistanciaLabel = nil
    }
    
    -- Criar linhas do esqueleto
    for _, Boneco in ipairs(Bonecos) do
        local Linha = Drawing.new("Line")
        Linha.Visible = false
        Linha.Thickness = 1.5
        Linha.Color = Color3.new(1, 1, 1) -- BRANCO
        Linha.Transparency = 1
        table.insert(ESP.Linhas, Linha)
    end
    
    -- Nome do jogador
    ESP.NomeLabel = Drawing.new("Text")
    ESP.NomeLabel.Visible = false
    ESP.NomeLabel.Center = true
    ESP.NomeLabel.Outline = true
    ESP.NomeLabel.Font = 2
    ESP.NomeLabel.Size = 13
    ESP.NomeLabel.Color = Color3.new(1, 1, 1)
    
    -- Distância
    ESP.DistanciaLabel = Drawing.new("Text")
    ESP.DistanciaLabel.Visible = false
    ESP.DistanciaLabel.Center = true
    ESP.DistanciaLabel.Outline = true
    ESP.DistanciaLabel.Font = 2
    ESP.DistanciaLabel.Size = 11
    ESP.DistanciaLabel.Color = Color3.new(1, 1, 1)
    
    ESPStorage[Jogador] = ESP
end

local function RemoverESPJogador(Jogador)
    if ESPStorage[Jogador] then
        for _, Linha in ipairs(ESPStorage[Jogador].Linhas) do
            Linha:Remove()
        end
        if ESPStorage[Jogador].NomeLabel then ESPStorage[Jogador].NomeLabel:Remove() end
        if ESPStorage[Jogador].DistanciaLabel then ESPStorage[Jogador].DistanciaLabel:Remove() end
        ESPStorage[Jogador] = nil
    end
end

-- Loop de atualização do ESP
RunService.RenderStepped:Connect(function()
    -- Limpar ESP de jogadores que saíram
    for Jogador, _ in pairs(ESPStorage) do
        if not Jogador:IsDescendantOf(Players) or Jogador == LocalPlayer then
            RemoverESPJogador(Jogador)
        end
    end
    
    -- Se ESP desativado, esconde tudo
    if not Config.ESPAtivo then
        for _, ESP in pairs(ESPStorage) do
            for _, Linha in ipairs(ESP.Linhas) do
                Linha.Visible = false
            end
            if ESP.NomeLabel then ESP.NomeLabel.Visible = false end
            if ESP.DistanciaLabel then ESP.DistanciaLabel.Visible = false end
        end
        return
    end
    
    -- Atualizar ESP de cada jogador
    for _, Jogador in ipairs(Players:GetPlayers()) do
        if Jogador == LocalPlayer then continue end
        
        if not ESPStorage[Jogador] then
            CriarESPJogador(Jogador)
        end
        
        local ESP = ESPStorage[Jogador]
        local Personagem = Jogador.Character
        if not Personagem then
            for _, Lin
