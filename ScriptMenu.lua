-- LOTOS | Base Settings Menu UI

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local UserInputService = game:GetService("UserInputService")

local TweenService = game:GetService("TweenService")

local Lighting = game:GetService("Lighting")



local LocalPlayer = Players.LocalPlayer

local Camera = workspace.CurrentCamera



local TITLE_NAME = "LOTOS | Settings Menu Template"



-- Очистка прошлых версий

local ParentGui = (gethui and gethui()) or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

if ParentGui:FindFirstChild("LotosScriptGui") then

    ParentGui.LotosScriptGui:Destroy()

end



local OriginalLighting = {

    Brightness = Lighting.Brightness,

    ClockTime = Lighting.ClockTime,

    FogEnd = Lighting.FogEnd,

    GlobalShadows = Lighting.GlobalShadows

}



local Colors = {

    Background = Color3.fromRGB(20, 20, 24),

    Sidebar = Color3.fromRGB(25, 25, 30),

    Panel = Color3.fromRGB(28, 28, 35),

    Header = Color3.fromRGB(23, 23, 28),

    Accent = Color3.fromRGB(225, 120, 160),

    AccentHover = Color3.fromRGB(245, 140, 180),

    Text = Color3.fromRGB(230, 230, 240),

    TextDark = Color3.fromRGB(130, 130, 145),

    Element = Color3.fromRGB(35, 35, 45),

    ElementHover = Color3.fromRGB(48, 48, 62),

    Border = Color3.fromRGB(48, 48, 58),

    InputBg = Color3.fromRGB(16, 16, 20)

}



local Localization = {

    CurrentLanguage = "English",

    Languages = {

        "English", "简体中文", "Español", "हिन्दी", "العربية", 

        "Português", "Русский", "日本語", "Deutsch", "Français", 

        "한국어", "Türkçe", "Tiếng Việt", "Bahasa Indonesia", "Italiano", "ไทย"

    },

    Dict = {

        ["English"] = {Settings="Settings", Menu="Menu", Game="Game", Languages="Languages", UIScale="UI Scale", UIAnimation="UI Animation", LowGraphics="Low Graphics / FPS Boost", Fullbright="Fullbright", CameraFOV="Camera FOV", Reset="Reset"},

        ["简体中文"] = {Settings="设置", Menu="菜单", Game="游戏", Languages="语言", UIScale="UI 缩放", UIAnimation="UI 动画", LowGraphics="FPS 提升", Fullbright="高亮模式", CameraFOV="视角 (FOV)", Reset="重置"},

        ["Español"] = {Settings="Ajustes", Menu="Menú", Game="Juego", Languages="Idiomas", UIScale="Escala UI", UIAnimation="Animaciones UI", LowGraphics="Bajos Gráficos / FPS Boost", Fullbright="Brillo Total", CameraFOV="FOV Cámara", Reset="Restablecer"},

        ["हिन्दी"] = {Settings="सेटिंग्स", Menu="मेनू", Game="गेम", Languages="भाषाएँ", UIScale="UI स्केलिंग", UIAnimation="UI एनिमेसन", LowGraphics="FPS बूस्ट", Fullbright="फुल ब्राइट", CameraFOV="कैमरा FOV", Reset="रीसेट"},

        ["العربية"] = {Settings="الإعدادات", Menu="القائمة", Game="اللعبة", Languages="اللغات", UIScale="حجم الواجهة", UIAnimation="رسوم الواجهة", LowGraphics="تسريع اللعبة (FPS)", Fullbright="إضاءة كاملة", CameraFOV="زاوية الرؤية (FOV)", Reset="إعادة ضبط"},

        ["Português"] = {Settings="Configurações", Menu="Menu", Game="Jogo", Languages="Idiomas", UIScale="Escala da UI", UIAnimation="Animações UI", LowGraphics="FPS Boost / Gráficos Leves", Fullbright="Brilho Total", CameraFOV="FOV da Câmera", Reset="Redefinir"},

        ["Русский"] = {Settings="Настройки", Menu="Меню", Game="Игра", Languages="Языки", UIScale="Размер UI", UIAnimation="Анимации UI", LowGraphics="FPS Буст / Низкая графа", Fullbright="Фуллбрайт (Яркость)", CameraFOV="Угол Обзора (FOV)", Reset="Сброс"},

        ["日本語"] = {Settings="設定", Menu="メニュー", Game="ゲーム", Languages="言語", UIScale="UIスケール", UIAnimation="UIアニメーション", LowGraphics="FPSブースト", Fullbright="フルブライト", CameraFOV="カメラFOV", Reset="リセット"},

        ["Deutsch"] = {Settings="Einstellungen", Menu="Menü", Game="Spiel", Languages="Sprachen", UIScale="UI Skalierung", UIAnimation="UI Animationen", LowGraphics="FPS Boost", Fullbright="Volllicht", CameraFOV="Kamera FOV", Reset="Zurücksetzen"},

        ["Français"] = {Settings="Paramètres", Menu="Menu", Game="Jeu", Languages="Langues", UIScale="Taille UI", UIAnimation="Animations UI", LowGraphics="FPS Boost / Graphismes Bas", Fullbright="Luminosité Max", CameraFOV="FOV Caméra", Reset="Réinitialiser"},

        ["한국어"] = {Settings="설정", Menu="메뉴", Game="게임", Languages="언어", UIScale="UI 크기", UIAnimation="UI 애니메이션", LowGraphics="FPS 부스트", Fullbright="밝게 하기", CameraFOV="카메라 FOV", Reset="초기화"},

        ["Türkçe"] = {Settings="Ayarlar", Menu="Menü", Game="Oyun", Languages="Diller", UIScale="UI Boyutu", UIAnimation="UI Animasyonları", LowGraphics="FPS Artırma", Fullbright="Tam Parlaklık", CameraFOV="Kamera FOV", Reset="Sıfırla"},

        ["Tiếng Việt"] = {Settings="Cài đặt", Menu="Menu", Game="Trò chơi", Languages="Ngôn ngữ", UIScale="Tỷ lệ UI", UIAnimation="Hiệu ứng UI", LowGraphics="Tăng FPS", Fullbright="Độ sáng tối đa", CameraFOV="Góc nhìn FOV", Reset="Đặt lại"},

        ["Bahasa Indonesia"] = {Settings="Pengaturan", Menu="Menu", Game="Game", Languages="Bahasa", UIScale="Ukuran UI", UIAnimation="Animasi UI", LowGraphics="FPS Boost", Fullbright="Terang Maksimal", CameraFOV="FOV Kamera", Reset="Reset"},

        ["Italiano"] = {Settings="Impostazioni", Menu="Menu", Game="Gioco", Languages="Lingue", UIScale="Dimensione UI", UIAnimation="Animazioni UI", LowGraphics="FPS Boost", Fullbright="Luminosité Max", CameraFOV="FOV Telecamera", Reset="Ripristina"},

        ["ไทย"] = {Settings="ตั้งค่า", Menu="เมนู", Game="เกม", Languages="ภาษา", UIScale="ขนาด UI", UIAnimation="แอนิเมชัน UI", LowGraphics="เพิ่ม FPS", Fullbright="สว่างสูงสุด", CameraFOV="มุมมอง FOV", Reset="รีเซ็ต"}

    }

}



local RegisteredTextLabels = {}

local function registerTranslation(textLabel, key)

    RegisteredTextLabels[textLabel] = key

    local currentDict = Localization.Dict[Localization.CurrentLanguage] or Localization.Dict["English"]

    if currentDict[key] then

        textLabel.Text = currentDict[key]

    end

end



local function setLanguage(lang)

    if not Localization.Dict[lang] then return end

    Localization.CurrentLanguage = lang

    local dict = Localization.Dict[lang]

    for lbl, key in pairs(RegisteredTextLabels) do

        if lbl and lbl.Parent and dict[key] then

            lbl.Text = dict[key]

        end

    end

end



local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "LotosScriptGui"

ScreenGui.ResetOnSpawn = false

ScreenGui.Parent = ParentGui



-- Мобильная кнопка переключения

local ToggleBtn = Instance.new("TextButton")

ToggleBtn.Name = "MobileToggle"

ToggleBtn.Parent = ScreenGui

ToggleBtn.Size = UDim2.new(0, 130, 0, 32)

ToggleBtn.Position = UDim2.new(0.02, 0, 0.1, 0)

ToggleBtn.BackgroundColor3 = Colors.Panel

ToggleBtn.TextColor3 = Colors.Accent

ToggleBtn.TextSize = 11

ToggleBtn.Text = "LOTOS [Open]"

ToggleBtn.Font = Enum.Font.GothamBold



local UICornerBtn = Instance.new("UICorner")

UICornerBtn.CornerRadius = UDim.new(0, 6)

UICornerBtn.Parent = ToggleBtn



local UIStrokeBtn = Instance.new("UIStroke")

UIStrokeBtn.Color = Colors.Accent

UIStrokeBtn.Thickness = 1

UIStrokeBtn.Parent = ToggleBtn



-- Главное окно UI

local MainFrame = Instance.new("Frame")

MainFrame.Name = "MainFrame"

MainFrame.Parent = ScreenGui

MainFrame.Size = UDim2.new(0, 720, 0, 450)

MainFrame.Position = UDim2.new(0.5, -360, 0.5, -225)

MainFrame.BackgroundColor3 = Colors.Background

MainFrame.BorderSizePixel = 0

MainFrame.Active = true

MainFrame.ClipsDescendants = true



local MainScale = Instance.new("UIScale")

MainScale.Parent = MainFrame

MainScale.Scale = 1.0



local UICornerMain = Instance.new("UICorner")

UICornerMain.CornerRadius = UDim.new(0, 6)

UICornerMain.Parent = MainFrame



local UIStrokeMain = Instance.new("UIStroke")

UIStrokeMain.Color = Colors.Border

UIStrokeMain.Thickness = 1

UIStrokeMain.Parent = MainFrame



-- Drag Engine (Перетаскивание)

local dragging, dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true

        dragStart = input.Position

        startPos = MainFrame.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then dragging = false end

        end)

    end

end)

MainFrame.InputChanged:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then

        dragInput = input

    end

end)

UserInputService.InputChanged:Connect(function(input)

    if input == dragInput and dragging then

        local delta = input.Position - dragStart

        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)

    end

end)



-- Шапка

local TopBar = Instance.new("Frame")

TopBar.Parent = MainFrame

TopBar.Size = UDim2.new(1, 0, 0, 32)

TopBar.BackgroundColor3 = Colors.Header

TopBar.BorderSizePixel = 0



local TitleText = Instance.new("TextLabel")

TitleText.Parent = TopBar

TitleText.Size = UDim2.new(1, -40, 1, 0)

TitleText.Position = UDim2.new(0, 12, 0, 0)

TitleText.BackgroundTransparency = 1

TitleText.Text = TITLE_NAME

TitleText.TextColor3 = Colors.Text

TitleText.TextSize = 10

TitleText.Font = Enum.Font.GothamBold

TitleText.TextXAlignment = Enum.TextXAlignment.Left

TitleText.TextTruncate = Enum.TextTruncate.AtEnd



local CloseBtn = Instance.new("TextButton")

CloseBtn.Parent = TopBar

CloseBtn.Size = UDim2.new(0, 24, 0, 24)

CloseBtn.Position = UDim2.new(1, -28, 0, 4)

CloseBtn.BackgroundColor3 = Colors.Element

CloseBtn.Text = "✕"

CloseBtn.TextColor3 = Colors.TextDark

CloseBtn.TextSize = 12

CloseBtn.Font = Enum.Font.GothamBold



local CloseCorner = Instance.new("UICorner")

CloseCorner.CornerRadius = UDim.new(0, 4)

CloseCorner.Parent = CloseBtn



-- Боковое меню

local Sidebar = Instance.new("Frame")

Sidebar.Parent = MainFrame

Sidebar.Size = UDim2.new(0, 130, 1, -32)

Sidebar.Position = UDim2.new(0, 0, 0, 32)

Sidebar.BackgroundColor3 = Colors.Sidebar

Sidebar.BorderSizePixel = 0



local SidebarLayout = Instance.new("UIListLayout")

SidebarLayout.Parent = Sidebar

SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder

SidebarLayout.Padding = UDim.new(0, 4)



local SidebarPadding = Instance.new("UIPadding")

SidebarPadding.Parent = Sidebar

SidebarPadding.PaddingTop = UDim.new(0, 6)



-- Контентная область

local ContentArea = Instance.new("Frame")

ContentArea.Parent = MainFrame

ContentArea.Size = UDim2.new(1, -135, 1, -36)

ContentArea.Position = UDim2.new(0, 135, 0, 36)

ContentArea.BackgroundTransparency = 1



local function createTabFrame()

    local Frame = Instance.new("ScrollingFrame")

    Frame.Parent = ContentArea

    Frame.Size = UDim2.new(1, 0, 1, 0)

    Frame.BackgroundTransparency = 1

    Frame.ScrollBarThickness = 4

    Frame.CanvasSize = UDim2.new(0, 0, 0, 0)

    Frame.AutomaticCanvasSize = Enum.AutomaticSize.X

    Frame.ClipsDescendants = true

    Frame.Visible = false



    local Layout = Instance.new("UIListLayout")

    Layout.Parent = Frame

    Layout.FillDirection = Enum.FillDirection.Horizontal

    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    Layout.Padding = UDim.new(0, 12)



    local Padding = Instance.new("UIPadding")

    Padding.Parent = Frame

    Padding.PaddingLeft = UDim.new(0, 6)

    Padding.PaddingTop = UDim.new(0, 6)

    Padding.PaddingRight = UDim.new(0, 10)

    return Frame

end



local SettingsTabFrame = createTabFrame()

SettingsTabFrame.Visible = true



local AnimationsEnabled = true



local function tweenObj(obj, info, properties)

    if AnimationsEnabled then

        TweenService:Create(obj, info, properties):Play()

    else

        for k, v in pairs(properties) do obj[k] = v end

    end

end



local function toggleMenuVisibility(visible)

    if visible then

        MainFrame.Visible = true

        MainScale.Scale = 0.6

        tweenObj(MainScale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})

        ToggleBtn.Text = "LOTOS [Close]"

    else

        local tw = TweenService:Create(MainScale, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Scale = 0.6})

        tw:Play()

        tw.Completed:Connect(function()

            if not MainFrame.Visible then return end

            MainFrame.Visible = false

        end)

        ToggleBtn.Text = "LOTOS [Open]"

    end

end



CloseBtn.MouseButton1Click:Connect(function() toggleMenuVisibility(false) end)

ToggleBtn.MouseButton1Click:Connect(function() toggleMenuVisibility(not MainFrame.Visible) end)



local tabs = {

    Settings = SettingsTabFrame

}



local activeTabBtn = nil



local function switchTab(targetFrame, targetBtn)

    for name, frame in pairs(tabs) do

        if frame == targetFrame then

            frame.Visible = true

            frame.Position = UDim2.new(0, 15, 0, 0)

            tweenObj(frame, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)})

        else

            frame.Visible = false

        end

    end

    

    for _, child in pairs(Sidebar:GetChildren()) do

        if child:IsA("TextButton") then

            tweenObj(child, TweenInfo.new(0.2), {TextColor3 = Colors.TextDark, BackgroundTransparency = 1})

        end

    end

    activeTabBtn = targetBtn

    tweenObj(targetBtn, TweenInfo.new(0.2), {TextColor3 = Colors.Accent})

end



local function createTabBtn(dictKey, active, targetFrame)

    local Btn = Instance.new("TextButton")

    Btn.Parent = Sidebar

    Btn.Size = UDim2.new(1, -10, 0, 32)

    Btn.Position = UDim2.new(0, 5, 0, 0)

    Btn.BackgroundTransparency = 1

    Btn.BackgroundColor3 = Colors.Element

    Btn.Text = "    " .. dictKey

    Btn.TextColor3 = active and Colors.Accent or Colors.TextDark

    Btn.TextSize = 12

    Btn.Font = Enum.Font.GothamMedium

    Btn.TextXAlignment = Enum.TextXAlignment.Left



    registerTranslation(Btn, dictKey)



    local Corner = Instance.new("UICorner")

    Corner.CornerRadius = UDim.new(0, 5)

    Corner.Parent = Btn



    if active then activeTabBtn = Btn end



    Btn.MouseEnter:Connect(function()

        if activeTabBtn ~= Btn then

            tweenObj(Btn, TweenInfo.new(0.2), {TextColor3 = Colors.Text, BackgroundTransparency = 0.8})

        end

    end)

    Btn.MouseLeave:Connect(function()

        if activeTabBtn ~= Btn then

            tweenObj(Btn, TweenInfo.new(0.2), {TextColor3 = Colors.TextDark, BackgroundTransparency = 1})

        end

    end)



    Btn.MouseButton1Click:Connect(function()

        switchTab(targetFrame, Btn)

    end)

    return Btn

end



createTabBtn("Settings", true, SettingsTabFrame)



local function createGroupBox(parent, dictKeyTitle)

    local GroupBox = Instance.new("Frame")

    GroupBox.Parent = parent

    GroupBox.Size = UDim2.new(0, 260, 0, 390)

    GroupBox.BackgroundColor3 = Colors.Panel

    GroupBox.BorderSizePixel = 0



    local UICornerGroup = Instance.new("UICorner")

    UICornerGroup.CornerRadius = UDim.new(0, 6)

    UICornerGroup.Parent = GroupBox



    local UIStrokeGroup = Instance.new("UIStroke")

    UIStrokeGroup.Color = Colors.Border

    UIStrokeGroup.Thickness = 1

    UIStrokeGroup.Parent = GroupBox



    local GroupLine = Instance.new("Frame")

    GroupLine.Parent = GroupBox

    GroupLine.Size = UDim2.new(1, -20, 0, 2)

    GroupLine.Position = UDim2.new(0, 10, 0, 26)

    GroupLine.BackgroundColor3 = Colors.Accent

    GroupLine.BorderSizePixel = 0



    local GroupTitle = Instance.new("TextLabel")

    GroupTitle.Parent = GroupBox

    GroupTitle.Size = UDim2.new(1, -20, 0, 24)

    GroupTitle.Position = UDim2.new(0, 10, 0, 2)

    GroupTitle.BackgroundTransparency = 1

    GroupTitle.Text = dictKeyTitle

    GroupTitle.TextColor3 = Colors.Text

    GroupTitle.TextSize = 12

    GroupTitle.Font = Enum.Font.GothamBold

    GroupTitle.TextXAlignment = Enum.TextXAlignment.Left



    registerTranslation(GroupTitle, dictKeyTitle)



    local ScrollContainer = Instance.new("ScrollingFrame")

    ScrollContainer.Parent = GroupBox

    ScrollContainer.Size = UDim2.new(1, -12, 1, -36)

    ScrollContainer.Position = UDim2.new(0, 6, 0, 32)

    ScrollContainer.BackgroundTransparency = 1

    ScrollContainer.ScrollBarThickness = 3

    ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

    ScrollContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y

    ScrollContainer.ClipsDescendants = true



    local Layout = Instance.new("UIListLayout")

    Layout.Parent = ScrollContainer

    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    Layout.Padding = UDim.new(0, 8)



    local Padding = Instance.new("UIPadding")

    Padding.Parent = ScrollContainer

    Padding.PaddingRight = UDim.new(0, 4)

    Padding.PaddingTop = UDim.new(0, 2)



    return ScrollContainer

end



local MenuSettingsContainer = createGroupBox(SettingsTabFrame, "Menu")

local GameSettingsContainer = createGroupBox(SettingsTabFrame, "Game")

local LanguageSettingsContainer = createGroupBox(SettingsTabFrame, "Languages")



local function createAdvancedFeature(parent, dictKey, defaultVal, resetVal, onToggle, onValChange)

    local Frame = Instance.new("Frame")

    Frame.Parent = parent

    Frame.Size = UDim2.new(1, 0, 0, 58)

    Frame.BackgroundColor3 = Colors.Element



    local Corner = Instance.new("UICorner")

    Corner.CornerRadius = UDim.new(0, 5)

    Corner.Parent = Frame



    local ClickArea = Instance.new("TextButton")

    ClickArea.Parent = Frame

    ClickArea.Size = UDim2.new(1, 0, 0, 26)

    ClickArea.BackgroundTransparency = 1

    ClickArea.Text = ""



    local CheckBoxBox = Instance.new("Frame")

    CheckBoxBox.Parent = ClickArea

    CheckBoxBox.Size = UDim2.new(0, 14, 0, 14)

    CheckBoxBox.Position = UDim2.new(0, 8, 0, 6)

    CheckBoxBox.BackgroundColor3 = Colors.Background



    local CheckBoxCorner = Instance.new("UICorner")

    CheckBoxCorner.CornerRadius = UDim.new(0, 3)

    CheckBoxCorner.Parent = CheckBoxBox



    local CheckBoxStroke = Instance.new("UIStroke")

    CheckBoxStroke.Color = Colors.Border

    CheckBoxStroke.Thickness = 1

    CheckBoxStroke.Parent = CheckBoxBox



    local CheckMark = Instance.new("Frame")

    CheckMark.Parent = CheckBoxBox

    CheckMark.Size = UDim2.new(1, -4, 1, -4)

    CheckMark.Position = UDim2.new(0, 2, 0, 2)

    CheckMark.BackgroundColor3 = Colors.Accent

    CheckMark.Visible = false



    local MarkCorner = Instance.new("UICorner")

    MarkCorner.CornerRadius = UDim.new(0, 2)

    MarkCorner.Parent = CheckMark



    local Label = Instance.new("TextLabel")

    Label.Parent = ClickArea

    Label.Size = UDim2.new(1, -30, 1, 0)

    Label.Position = UDim2.new(0, 28, 0, 0)

    Label.BackgroundTransparency = 1

    Label.Text = dictKey

    Label.TextColor3 = Colors.TextDark

    Label.TextSize = 11

    Label.Font = Enum.Font.Gotham

    Label.TextXAlignment = Enum.TextXAlignment.Left



    registerTranslation(Label, dictKey)



    local active = false

    ClickArea.MouseButton1Click:Connect(function()

        active = not active

        CheckMark.Visible = active

        tweenObj(Label, TweenInfo.new(0.15), {TextColor3 = active and Colors.Text or Colors.TextDark})

        tweenObj(CheckBoxStroke, TweenInfo.new(0.15), {Color = active and Colors.Accent or Colors.Border})

        if onToggle then onToggle(active) end

    end)



    local InputFrame = Instance.new("Frame")

    InputFrame.Parent = Frame

    InputFrame.Size = UDim2.new(1, -16, 0, 22)

    InputFrame.Position = UDim2.new(0, 8, 0, 28)

    InputFrame.BackgroundTransparency = 1



    local ValueInput = Instance.new("TextBox")

    ValueInput.Parent = InputFrame

    ValueInput.Size = UDim2.new(0.68, 0, 1, 0)

    ValueInput.BackgroundColor3 = Colors.InputBg

    ValueInput.Text = tostring(defaultVal)

    ValueInput.TextColor3 = Colors.Text

    ValueInput.TextSize = 11

    ValueInput.Font = Enum.Font.Gotham

    ValueInput.ClearTextOnFocus = false



    local InputCorner = Instance.new("UICorner")

    InputCorner.CornerRadius = UDim.new(0, 3)

    InputCorner.Parent = ValueInput



    local InputStroke = Instance.new("UIStroke")

    InputStroke.Color = Colors.Border

    InputStroke.Thickness = 1

    InputStroke.Parent = ValueInput



    local ResetBtn = Instance.new("TextButton")

    ResetBtn.Parent = InputFrame

    ResetBtn.Size = UDim2.new(0.28, 0, 1, 0)

    ResetBtn.Position = UDim2.new(0.72, 0, 0, 0)

    ResetBtn.BackgroundColor3 = Colors.Background

    ResetBtn.Text = "Reset"

    ResetBtn.TextColor3 = Colors.Accent

    ResetBtn.TextSize = 10

    ResetBtn.Font = Enum.Font.GothamBold



    registerTranslation(ResetBtn, "Reset")



    local ResetCorner = Instance.new("UICorner")

    ResetCorner.CornerRadius = UDim.new(0, 3)

    ResetCorner.Parent = ResetBtn



    ValueInput.FocusLost:Connect(function()

        local num = tonumber(ValueInput.Text)

        if num and onValChange then onValChange(num) else ValueInput.Text = tostring(defaultVal) end

    end)



    ResetBtn.MouseButton1Click:Connect(function()

        ValueInput.Text = tostring(resetVal)

        if onValChange then onValChange(resetVal) end

    end)

end



local function createSimpleCheckbox(parent, dictKey, defaultState, onToggle)

    local Frame = Instance.new("Frame")

    Frame.Parent = parent

    Frame.Size = UDim2.new(1, 0, 0, 32)

    Frame.BackgroundColor3 = Colors.Element



    local Corner = Instance.new("UICorner")

    Corner.CornerRadius = UDim.new(0, 5)

    Corner.Parent = Frame



    local ClickArea = Instance.new("TextButton")

    ClickArea.Parent = Frame

    ClickArea.Size = UDim2.new(1, 0, 1, 0)

    ClickArea.BackgroundTransparency = 1

    ClickArea.Text = ""



    local CheckBoxBox = Instance.new("Frame")

    CheckBoxBox.Parent = ClickArea

    CheckBoxBox.Size = UDim2.new(0, 14, 0, 14)

    CheckBoxBox.Position = UDim2.new(0, 8, 0.5, -7)

    CheckBoxBox.BackgroundColor3 = Colors.Background



    local CheckBoxCorner = Instance.new("UICorner")

    CheckBoxCorner.CornerRadius = UDim.new(0, 3)

    CheckBoxCorner.Parent = CheckBoxBox



    local CheckBoxStroke = Instance.new("UIStroke")

    CheckBoxStroke.Color = defaultState and Colors.Accent or Colors.Border

    CheckBoxStroke.Thickness = 1

    CheckBoxStroke.Parent = CheckBoxBox



    local CheckMark = Instance.new("Frame")

    CheckMark.Parent = CheckBoxBox

    CheckMark.Size = UDim2.new(1, -4, 1, -4)

    CheckMark.Position = UDim2.new(0, 2, 0, 2)

    CheckMark.BackgroundColor3 = Colors.Accent

    CheckMark.Visible = defaultState or false



    local MarkCorner = Instance.new("UICorner")

    MarkCorner.CornerRadius = UDim.new(0, 2)

    MarkCorner.Parent = CheckMark



    local Label = Instance.new("TextLabel")

    Label.Parent = ClickArea

    Label.Size = UDim2.new(1, -30, 1, 0)

    Label.Position = UDim2.new(0, 28, 0, 0)

    Label.BackgroundTransparency = 1

    Label.Text = dictKey

    Label.TextColor3 = defaultState and Colors.Text or Colors.TextDark

    Label.TextSize = 11

    Label.Font = Enum.Font.Gotham

    Label.TextXAlignment = Enum.TextXAlignment.Left



    registerTranslation(Label, dictKey)



    local active = defaultState or false

    ClickArea.MouseButton1Click:Connect(function()

        active = not active

        CheckMark.Visible = active

        tweenObj(Label, TweenInfo.new(0.15), {TextColor3 = active and Colors.Text or Colors.TextDark})

        tweenObj(CheckBoxStroke, TweenInfo.new(0.15), {Color = active and Colors.Accent or Colors.Border})

        if onToggle then onToggle(active) end

    end)

end



local function createButton(parent, nameText, callback)

    local Btn = Instance.new("TextButton")

    Btn.Parent = parent

    Btn.Size = UDim2.new(1, 0, 0, 28)

    Btn.BackgroundColor3 = Colors.Element

    Btn.Text = nameText

    Btn.TextColor3 = Colors.Text

    Btn.TextSize = 11

    Btn.Font = Enum.Font.GothamMedium



    local Corner = Instance.new("UICorner")

    Corner.CornerRadius = UDim.new(0, 5)

    Corner.Parent = Btn



    local Stroke = Instance.new("UIStroke")

    Stroke.Color = Colors.Border

    Stroke.Thickness = 1

    Stroke.Parent = Btn



    Btn.MouseEnter:Connect(function()

        tweenObj(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Colors.ElementHover})

    end)

    Btn.MouseLeave:Connect(function()

        tweenObj(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Colors.Element})

    end)



    Btn.MouseButton1Click:Connect(function()

        tweenObj(Btn, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(0.96, 0, 0, 26)})

        task.wait(0.08)

        tweenObj(Btn, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.new(1, 0, 0, 28)})

        if callback then callback() end

    end)

end



local function createScaleStepper(parent)

    local Frame = Instance.new("Frame")

    Frame.Parent = parent

    Frame.Size = UDim2.new(1, 0, 0, 42)

    Frame.BackgroundColor3 = Colors.Element



    local Corner = Instance.new("UICorner")

    Corner.CornerRadius = UDim.new(0, 5)

    Corner.Parent = Frame



    local Label = Instance.new("TextLabel")

    Label.Parent = Frame

    Label.Size = UDim2.new(0.5, 0, 1, 0)

    Label.Position = UDim2.new(0, 8, 0, 0)

    Label.BackgroundTransparency = 1

    Label.Text = "UIScale"

    Label.TextColor3 = Colors.Text

    Label.TextSize = 11

    Label.Font = Enum.Font.Gotham

    Label.TextXAlignment = Enum.TextXAlignment.Left



    registerTranslation(Label, "UIScale")



    local ControlsFrame = Instance.new("Frame")

    ControlsFrame.Parent = Frame

    ControlsFrame.Size = UDim2.new(0, 100, 0, 24)

    ControlsFrame.Position = UDim2.new(1, -108, 0.5, -12)

    ControlsFrame.BackgroundTransparency = 1



    local MinusBtn = Instance.new("TextButton")

    MinusBtn.Parent = ControlsFrame

    MinusBtn.Size = UDim2.new(0, 24, 1, 0)

    MinusBtn.BackgroundColor3 = Colors.Background

    MinusBtn.Text = "-"

    MinusBtn.TextColor3 = Colors.Accent

    MinusBtn.TextSize = 12

    MinusBtn.Font = Enum.Font.GothamBold



    local MinusCorner = Instance.new("UICorner")

    MinusCorner.CornerRadius = UDim.new(0, 3)

    MinusCorner.Parent = MinusBtn



    local ValueLabel = Instance.new("TextLabel")

    ValueLabel.Parent = ControlsFrame

    ValueLabel.Size = UDim2.new(0, 44, 1, 0)

    ValueLabel.Position = UDim2.new(0, 28, 0, 0)

    ValueLabel.BackgroundTransparency = 1

    ValueLabel.Text = string.format("%.1f", MainScale.Scale)

    ValueLabel.TextColor3 = Colors.Text

    ValueLabel.TextSize = 11

    ValueLabel.Font = Enum.Font.GothamBold



    local PlusBtn = Instance.new("TextButton")

    PlusBtn.Parent = ControlsFrame

    PlusBtn.Size = UDim2.new(0, 24, 1, 0)

    PlusBtn.Position = UDim2.new(1, -24, 0, 0)

    PlusBtn.BackgroundColor3 = Colors.Background

    PlusBtn.Text = "+"

    PlusBtn.TextColor3 = Colors.Accent

    PlusBtn.TextSize = 12

    PlusBtn.Font = Enum.Font.GothamBold



    local PlusCorner = Instance.new("UICorner")

    PlusCorner.CornerRadius = UDim.new(0, 3)

    PlusCorner.Parent = PlusBtn



    MinusBtn.MouseButton1Click:Connect(function()

        MainScale.Scale = math.clamp(MainScale.Scale - 0.1, 0.5, 1.5)

        ValueLabel.Text = string.format("%.1f", MainScale.Scale)

    end)



    PlusBtn.MouseButton1Click:Connect(function()

        MainScale.Scale = math.clamp(MainScale.Scale + 0.1, 0.5, 1.5)

        ValueLabel.Text = string.format("%.1f", MainScale.Scale)

    end)

end



-- ==================== НАПОЛНЕНИЕ НАСТРОЕК ====================



-- 1. Настройки Меню

createScaleStepper(MenuSettingsContainer)



createSimpleCheckbox(MenuSettingsContainer, "UIAnimation", true, function(state)

    AnimationsEnabled = state

end)



-- 2. Настройки Игры

createSimpleCheckbox(GameSettingsContainer, "LowGraphics", false, function(state)

    for _, v in pairs(game:GetDescendants()) do

        if v:IsA("BasePart") and not v:IsA("MeshPart") then

            v.Material = state and Enum.Material.SmoothPlastic or Enum.Material.Plastic

        end

    end

end)



createSimpleCheckbox(GameSettingsContainer, "Fullbright", false, function(state)

    if state then

        Lighting.Brightness = 2

        Lighting.ClockTime = 14

        Lighting.FogEnd = 100000

        Lighting.GlobalShadows = false

    else

        Lighting.Brightness = OriginalLighting.Brightness

        Lighting.ClockTime = OriginalLighting.ClockTime

        Lighting.FogEnd = OriginalLighting.FogEnd

        Lighting.GlobalShadows = OriginalLighting.GlobalShadows

    end

end)



createAdvancedFeature(GameSettingsContainer, "CameraFOV", math.floor(Camera.FieldOfView), 70, nil, function(val)

    Camera.FieldOfView = val

end)



-- 3. Выбор Языков

for _, lang in ipairs(Localization.Languages) do

    createButton(LanguageSettingsContainer, lang, function()

        setLanguage(lang)

    end)

end
