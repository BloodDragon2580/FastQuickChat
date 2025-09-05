local addonName = ...

-- Lokalisierung
local locale = GetLocale()
local L = {}
if locale == "deDE" then
    L = {
        title="FastQuickChat", desc="FastQuickChat Einstellungen",
        say="Sagen", guild="Gilde", party="Gruppe", raid="Schlachtzug",
        instance="Instanz", roll="Würfeln", readycheck="Bereitschaft",
        pull="Pull", ["break"]="Pause", reload="Neuladen",
        showMinimap="Minimap-Button anzeigen", resetPos="Position zurücksetzen",
        scale="Skalierung", transparentBackground="Transparenter Hintergrund",
        styleLabel="Button-Stil",
        style_default="Standard", style_dark="Dunkel (Schwarz/Weiß)",
        style_blue="Blau/Gelb", style_green="Grün", style_red="Rot",
        style_transparent="Transparent", style_neon="Neon",
        moveInfo="Shift + Linksklick auf die Leiste, um sie zu verschieben."
    }
elseif locale == "ruRU" then
    L = {
        title="FastQuickChat", desc="Настройки FastQuickChat",
        say="Сказать", guild="Гильдия", party="Группа", raid="Рейд",
        instance="Подземелье", roll="Бросок", readycheck="Проверка готовности",
        pull="Пул", ["break"]="Перерыв", reload="Перезагрузить",
        showMinimap="Показывать кнопку у миникарты", resetPos="Сброс позиции",
        scale="Масштаб", transparentBackground="Прозрачный фон",
        styleLabel="Стиль кнопки", style_default="Стандарт", style_dark="Тёмный (Чёрный/Белый)",
        style_blue="Синий/Жёлтый", style_green="Зелёный", style_red="Красный",
        style_transparent="Прозрачный", style_neon="Неоновый",
        moveInfo="Shift + Левый клик, чтобы переместить панель."
    }
elseif locale == "frFR" then
    L = {
        title="FastQuickChat", desc="Paramètres de FastQuickChat",
        say="Dire", guild="Guilde", party="Groupe", raid="Raid",
        instance="Instance", roll="Lancer", readycheck="Vérification de prêt",
        pull="Pull", ["break"]="Pause", reload="Recharger",
        showMinimap="Afficher le bouton de la minicarte", resetPos="Réinitialiser la position",
        scale="Échelle", transparentBackground="Arrière-plan transparent",
        styleLabel="Style de bouton", style_default="Standard", style_dark="Sombre (Noir/Blanc)",
        style_blue="Bleu/Jaune", style_green="Vert", style_red="Rouge",
        style_transparent="Transparent", style_neon="Néon",
        moveInfo="Shift + Clic gauche pour déplacer la barre."
    }
elseif locale == "esES" then
    L = {
        title="FastQuickChat", desc="Configuración de FastQuickChat",
        say="Decir", guild="Hermandad", party="Grupo", raid="Banda",
        instance="Instancia", roll="Tirar", readycheck="Comprobación de preparación",
        pull="Pull", ["break"]="Pausa", reload="Recargar",
        showMinimap="Mostrar botón en el minimapa", resetPos="Restablecer posición",
        scale="Escala", transparentBackground="Fondo transparente",
        styleLabel="Estilo de botón", style_default="Estándar", style_dark="Oscuro (Negro/Blanco)",
        style_blue="Azul/Amarillo", style_green="Verde", style_red="Rojo",
        style_transparent="Transparente", style_neon="Neón",
        moveInfo="Shift + Clic izquierdo para mover la barra."
    }
elseif locale == "itIT" then
    L = {
        title="FastQuickChat", desc="Impostazioni di FastQuickChat",
        say="Dire", guild="Gilda", party="Gruppo", raid="Incursione",
        instance="Istanza", roll="Tira", readycheck="Controllo di Prontezza",
        pull="Pull", ["break"]="Pausa", reload="Ricarica",
        showMinimap="Mostra pulsante minimappa", resetPos="Ripristina posizione",
        scale="Scala", transparentBackground="Sfondo trasparente",
        styleLabel="Stile pulsante", style_default="Standard", style_dark="Scuro (Nero/Bianco)",
        style_blue="Blu/Giallo", style_green="Verde", style_red="Rosso",
        style_transparent="Trasparente", style_neon="Neon",
        moveInfo="Shift + Click sinistro per spostare la barra."
    }
elseif locale == "zhCN" then
    L = {
        title="FastQuickChat", desc="FastQuickChat 设置",
        say="说", guild="公会", party="队伍", raid="团队",
        instance="副本", roll="掷骰子", readycheck="准备确认",
        pull="拉怪", ["break"]="休息", reload="重载界面",
        showMinimap="显示小地图按钮", resetPos="重置位置",
        scale="缩放", transparentBackground="透明背景",
        styleLabel="按钮样式", style_default="标准", style_dark="深色（黑/白）",
        style_blue="蓝/黄", style_green="绿色", style_red="红色",
        style_transparent="透明", style_neon="霓虹",
        moveInfo="Shift + 左键点击移动条。"
    }
elseif locale == "koKR" then
    L = {
        title="FastQuickChat", desc="FastQuickChat 설정",
        say="말하기", guild="길드", party="파티", raid="공격대",
        instance="인스턴스", roll="주사위", readycheck="준비 확인",
        pull="풀링", ["break"]="휴식", reload="재로딩",
        showMinimap="미니맵 버튼 표시", resetPos="위치 초기화",
        scale="크기 조정", transparentBackground="투명 배경",
        styleLabel="버튼 스타일", style_default="표준", style_dark="어두운 (검정/흰색)",
        style_blue="파랑/노랑", style_green="초록", style_red="빨강",
        style_transparent="투명", style_neon="네온",
        moveInfo="Shift + 왼쪽 클릭으로 바 이동."
    }
else
    L = {
        title="FastQuickChat", desc="FastQuickChat Settings",
        say="Say", guild="Guild", party="Party", raid="Raid",
        instance="Instance", roll="Roll", readycheck="Ready Check",
        pull="Pull", ["break"]="Break", reload="Reload",
        showMinimap="Show Minimap Button", resetPos="Reset Position",
        scale="Scale", transparentBackground="Transparent Background",
        styleLabel="Button Style", style_default="Standard", style_dark="Dark (Black/White)",
        style_blue="Blue/Yellow", style_green="Green", style_red="Red",
        style_transparent="Transparent", style_neon="Neon",
        moveInfo="Shift + LeftClick to move the bar."
    }
end

-- Default Einstellungen
local defaults = {
    enableSay=true, enableGuild=true, enableParty=true, enableRaid=true,
    enableInstance=true, enableRoll=true, enableReadyCheck=true,
    enablePull=true, enableBreak=true, enableReload=true, showMinimap=true,
    frameX=nil, frameY=nil, frameScale=1,
    transparentBackground=false,
	buttonStyle="default",
    minimap = {}
}

-- Hauptframe
local frame = CreateFrame("Frame","FastQuickChatFrame",UIParent,"BackdropTemplate")
frame:SetSize(10,40)
frame:SetPoint("CENTER")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:SetClampedToScreen(true)
frame:SetBackdrop({
    bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize=16,
    insets={left=3,right=3,top=3,bottom=3}
})
frame:SetBackdropColor(0.15,0.15,0.15,0.9)
frame:SetBackdropBorderColor(0.4,0.4,0.4,1)

-- Funktion für Hintergrund
local function UpdateBackground()
    if FastQuickChatDB.transparentBackground then
        frame:SetBackdrop(nil)
    else
        frame:SetBackdrop({
            bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize=16,
            insets={left=3,right=3,top=3,bottom=3}
        })
        frame:SetBackdropColor(0.15,0.15,0.15,0.9)
        frame:SetBackdropBorderColor(0.4,0.4,0.4,1)
    end
end

-- Globale Tabelle
FastQuickChat = FastQuickChat or {}
local QC = {}
QC.F = frame
QC.buttons = {}

local BUTTON_PADDING=8
local BUTTON_MARGIN=4
local BUTTON_MIN_WIDTH=50
local FRAME_PADDING=10

-- Button Style anwenden
local function ApplyButtonStyle(btn)
    local style = FastQuickChatDB.buttonStyle or "default"

    -- Standard-Einstellungen für alle Buttons
    btn:SetBackdrop({
        bgFile = "Interface/ChatFrame/ChatFrameBackground",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })

    if style == "default" then
        -- kleiner schwarzer Rahmen, goldene Schrift
        btn:SetBackdropColor(0, 0, 0, 0.8)
        btn:SetBackdropBorderColor(0.2, 0.2, 0.2)
        btn.text:SetTextColor(1, 0.82, 0)

    elseif style == "dark" then
        -- dunkler Button, weiße Schrift
        btn:SetBackdropColor(0.05, 0.05, 0.05, 0.9)
        btn:SetBackdropBorderColor(0.8, 0.8, 0.8)
        btn.text:SetTextColor(1, 1, 1)

    elseif style == "blue" then
        -- Blau mit gelber Schrift
        btn:SetBackdropColor(0, 0.2, 0.6, 0.9)
        btn:SetBackdropBorderColor(1, 0.84, 0)
        btn.text:SetTextColor(1, 0.9, 0.2)

    elseif style == "green" then
        -- Grün, leicht transparent
        btn:SetBackdropColor(0, 0.5, 0, 0.8)
        btn:SetBackdropBorderColor(0.8, 1, 0.8)
        btn.text:SetTextColor(0.9, 1, 0.9)

    elseif style == "red" then
        -- Rot für wichtige Buttons
        btn:SetBackdropColor(0.6, 0, 0, 0.9)
        btn:SetBackdropBorderColor(1, 0.5, 0.5)
        btn.text:SetTextColor(1, 0.8, 0.8)

    elseif style == "transparent" then
        -- Fast unsichtbar, nur Schrift sichtbar
        btn:SetBackdropColor(0, 0, 0, 0)
        btn:SetBackdropBorderColor(0, 0, 0, 0)
        btn.text:SetTextColor(0.8, 0.8, 1)

    elseif style == "neon" then
        -- Neon-Look
        btn:SetBackdropColor(0, 0, 0, 0.7)
        btn:SetBackdropBorderColor(0, 1, 1) -- leuchtendes Cyan
        btn.text:SetTextColor(0, 1, 1)
    end
end

-- Button erstellen (Retail-kompatibel)
local function AddButton(text, command)
    local btn = CreateFrame("Button", nil, QC.F, "BackdropTemplate") -- wichtig: BackdropTemplate für SetBackdrop
    btn:SetHeight(28)

    -- FontString hinzufügen
    btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    btn.text:SetPoint("CENTER")
    btn.text:SetText(text)

    -- Dynamische Breite
    local width = math.max(BUTTON_MIN_WIDTH, btn.text:GetStringWidth() + BUTTON_PADDING)
    btn:SetWidth(width)

    -- Hover-Effekt
    btn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(0.3, 0.3, 0.3, 0.9)
    end)
    btn:SetScript("OnLeave", function(self)
        ApplyButtonStyle(self)
    end)

    -- Klick-Event
    btn:SetScript("OnClick", function()
        if command == "/pull 10" and SlashCmdList.DEADLYBOSSMODSPULL then
            SlashCmdList.DEADLYBOSSMODSPULL(10)
        elseif command == "/break 10" and SlashCmdList.DEADLYBOSSMODSBREAK then
            SlashCmdList.DEADLYBOSSMODSBREAK(10)
        elseif command == "/roll" then RandomRoll(1, 100)
        elseif command == "/readycheck" then DoReadyCheck()
        elseif command == "/reload" then ReloadUI()
        else
            local editBox = ChatEdit_ChooseBoxForSend()
            ChatFrame_OpenChat(command, editBox.chatFrame)
        end
    end)

    -- Style anwenden
    ApplyButtonStyle(btn)

    return btn
end

-- Prüfen, ob DBM verfügbar ist
local hasDBM = SlashCmdList.DEADLYBOSSMODSPULL and SlashCmdList.DEADLYBOSSMODSBREAK

-- Buttons updaten
local function UpdateButtons()
    for _,b in pairs(QC.buttons) do b:Hide() end
    QC.buttons = {}
    local x = FRAME_PADDING
    local y = 0
    local inInstance, instanceType = IsInInstance()
    local scale = FastQuickChatDB.frameScale or 1

local function place(btn)
    -- Breite des Buttons dynamisch anhand Text berechnen
    local btnText = btn.text:GetText()
    local width = math.max(BUTTON_MIN_WIDTH, btn.text:GetStringWidth() + BUTTON_PADDING)
    local height = 28

    btn:SetSize(width * scale, height * scale)
    btn:SetPoint("LEFT", QC.F, "LEFT", x, 0)

    -- Abstand individuell anpassen
    local margin = BUTTON_MARGIN
    if btnText == L["break"] or btnText == L.reload then
        margin = margin + 4 -- extra Abstand
    end

    x = x + (width * scale) + margin
    table.insert(QC.buttons, btn)
    btn:Show()
end

    local function add(text, command)
        local btn = AddButton(text, command)
        btn.baseWidth = math.max(BUTTON_MIN_WIDTH, btn:GetTextWidth() + BUTTON_PADDING)
        btn.baseHeight = 28
        return btn
    end

    if FastQuickChatDB.enableSay then place(add(L.say, "/s ")) end
    if FastQuickChatDB.enableGuild and IsInGuild() then place(add(L.guild, "/g ")) end
    if FastQuickChatDB.enableParty and IsInGroup() then place(add(L.party, "/p ")) end
    if FastQuickChatDB.enableRaid and (IsInRaid() or (inInstance and instanceType=="raid")) then place(add(L.raid, "/raid ")) end
    if FastQuickChatDB.enableInstance and (inInstance and instanceType=="party") then place(add(L.instance, "/i ")) end
    if FastQuickChatDB.enableRoll then place(add(L.roll, "/roll")) end
    if FastQuickChatDB.enableReadyCheck and IsInGroup() then place(add(L.readycheck, "/readycheck")) end
    if hasDBM then
        if FastQuickChatDB.enablePull then place(add(L.pull, "/pull 10")) end
        if FastQuickChatDB.enableBreak then place(add(L["break"], "/break 10")) end
    end
    if FastQuickChatDB.enableReload then place(add(L.reload, "/reload")) end

    QC.F:SetWidth(x + FRAME_PADDING)
end

-- UpdateButtonFonts anpassen
local function UpdateButtonFonts(scale)
    local baseFontSize = 12
    for _, btn in pairs(QC.buttons) do
        if btn.text then
            local font, _, flags = btn.text:GetFont()
            btn.text:SetFont(font, baseFontSize * scale, flags)
            
            -- Breite dynamisch anpassen nach Text + Padding
            local width = math.max(BUTTON_MIN_WIDTH, btn.text:GetStringWidth() + BUTTON_PADDING)
            btn:SetWidth(width)
        end
    end
end

-- Options Panel
local panel = CreateFrame("Frame","FastQuickChatOptionsPanel",InterfaceOptionsFramePanelContainer)
panel.name=L.title
local title=panel:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
title:SetPoint("TOPLEFT",16,-16)
title:SetText(L.desc)

local moveInfo = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
moveInfo:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
moveInfo:SetText(L.moveInfo)

-- Checkbox erstellen (muss vor Aufruf stehen!)
local function CreateCheckbox(label,key,yOffset)
    local cb=CreateFrame("CheckButton",nil,panel,"InterfaceOptionsCheckButtonTemplate")
    cb:SetPoint("TOPLEFT",title,"BOTTOMLEFT",0,yOffset)
    cb.Text:SetText(label)
    cb:SetScript("OnShow",function() cb:SetChecked(FastQuickChatDB[key]) end)
    cb:SetScript("OnClick",function(self)
        FastQuickChatDB[key] = self:GetChecked() and true or false
        UpdateButtons()
        UpdateButtonFonts(FastQuickChatDB.frameScale or 1)
        if key=="showMinimap" then
            if FastQuickChat.ldbIcon then
                if FastQuickChatDB.showMinimap then FastQuickChat.ldbIcon:Show("FastQuickChat") else FastQuickChat.ldbIcon:Hide("FastQuickChat") end
            end
        elseif key=="transparentBackground" then
            UpdateBackground()
        end
    end)
    return cb
end

-- Checkboxen erstellen
local yStart=-16
local i=0
local keys={"enableSay","enableGuild","enableParty","enableRaid","enableInstance","enableRoll","enableReadyCheck","enableReload"}
for _,v in pairs(keys) do
    local label = L[string.lower(v:sub(7))]
    CreateCheckbox(label,v,yStart-(i*30))
    i=i+1
end

if hasDBM then
    CreateCheckbox(L.pull,"enablePull",yStart-(i*30))
    i=i+1
    CreateCheckbox(L["break"],"enableBreak",yStart-(i*30))
    i=i+1
end

CreateCheckbox(L.showMinimap,"showMinimap",yStart-(i*30))
i=i+1
CreateCheckbox(L.transparentBackground,"transparentBackground",yStart-(i*30))
i=i+1

-- Reset Position Button
local resetBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
resetBtn:SetNormalFontObject("GameFontNormal")
resetBtn:SetText(L.resetPos)

-- Dynamische Breite basierend auf Text
local padding = 16
local width = resetBtn:GetTextWidth() + padding
resetBtn:SetSize(width, 22)

resetBtn:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, yStart-(i*30))
resetBtn:SetScript("OnClick", function()
    FastQuickChatDB.framePoint = nil
    FastQuickChatDB.frameRelativePoint = nil
    FastQuickChatDB.frameX = nil
    FastQuickChatDB.frameY = nil
    frame:ClearAllPoints()
    frame:SetPoint("CENTER")
end)

i=i+1

-- Skalierungs-Slider hinzufügen
local scaleSlider = CreateFrame("Slider", nil, panel, "OptionsSliderTemplate")
scaleSlider:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, yStart-(i*30)-50)
scaleSlider:SetMinMaxValues(0.5, 2)
scaleSlider:SetValueStep(0.05)
scaleSlider:SetObeyStepOnDrag(true)
scaleSlider:SetWidth(200)
scaleSlider.Text = scaleSlider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
scaleSlider.Text:SetPoint("TOP", scaleSlider, "BOTTOM", 0, -2)

scaleSlider:SetScript("OnShow", function()
    scaleSlider:SetValue(FastQuickChatDB.frameScale or 1)
    scaleSlider.Text:SetText(L.scale .. ": " .. string.format("%.2f", FastQuickChatDB.frameScale or 1))
end)

scaleSlider:SetScript("OnValueChanged", function(self, value)
    FastQuickChatDB.frameScale = value
    frame:SetScale(value)
    UpdateButtons()
    UpdateButtonFonts(value)
    self.Text:SetText(L.scale .. ": " .. string.format("%.2f", value))
end)

-- Label für Button Style
local styleLabelText = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
styleLabelText:SetPoint("BOTTOMLEFT", scaleSlider, "TOPLEFT", 0, 0) -- leicht versetzt über Slider
styleLabelText:SetText(L.styleLabel)

-- Button Style Dropdown
local styleDropdown = CreateFrame("Frame", "FQCStyleDropdown", panel, "UIDropDownMenuTemplate")
styleDropdown:SetPoint("TOPLEFT", scaleSlider, "BOTTOMLEFT", -15, -60)

UIDropDownMenu_SetWidth(styleDropdown, 160)
UIDropDownMenu_SetText(styleDropdown, L.styleLabel)

local function UpdateStyleDropdownText()
    local style = FastQuickChatDB.buttonStyle or "default"
    local label = L.style_default
    if style == "dark" then label = L.style_dark end
    if style == "blue" then label = L.style_blue end
    if style == "green" then label = L.style_green end
    if style == "red" then label = L.style_red end
    if style == "transparent" then label = L.style_transparent end
    if style == "neon" then label = L.style_neon end
    UIDropDownMenu_SetText(styleDropdown, label)
end

UIDropDownMenu_Initialize(styleDropdown, function(self, level, menuList)
    local info = UIDropDownMenu_CreateInfo()

    info.text = L.style_default
    info.func = function()
        FastQuickChatDB.buttonStyle = "default"
        UpdateButtons()
        UpdateStyleDropdownText()
    end
    UIDropDownMenu_AddButton(info)

    info.text = L.style_dark
    info.func = function()
        FastQuickChatDB.buttonStyle = "dark"
        UpdateButtons()
        UpdateStyleDropdownText()
    end
    UIDropDownMenu_AddButton(info)

    info.text = L.style_blue
    info.func = function()
        FastQuickChatDB.buttonStyle = "blue"
        UpdateButtons()
        UpdateStyleDropdownText()
    end
    UIDropDownMenu_AddButton(info)

    info.text = L.style_green
    info.func = function()
        FastQuickChatDB.buttonStyle = "green"
        UpdateButtons()
        UpdateStyleDropdownText()
    end
    UIDropDownMenu_AddButton(info)

    info.text = L.style_red
    info.func = function()
        FastQuickChatDB.buttonStyle = "red"
        UpdateButtons()
        UpdateStyleDropdownText()
    end
    UIDropDownMenu_AddButton(info)

    info.text = L.style_transparent
    info.func = function()
        FastQuickChatDB.buttonStyle = "transparent"
        UpdateButtons()
        UpdateStyleDropdownText()
    end
    UIDropDownMenu_AddButton(info)

    info.text = L.style_neon
    info.func = function()
        FastQuickChatDB.buttonStyle = "neon"
        UpdateButtons()
        UpdateStyleDropdownText()
    end
    UIDropDownMenu_AddButton(info)
end)

styleDropdown:SetScript("OnShow", function()
    UpdateStyleDropdownText()
end)

panel:Hide()
if Settings and Settings.RegisterAddOnCategory then
    local category = Settings.RegisterCanvasLayoutCategory(panel, L.title)
    category.ID = L.title
    Settings.RegisterAddOnCategory(category)
else
    InterfaceOptions_AddCategory(panel)
end

-- Drag nur mit Shift
frame:SetScript("OnMouseDown", function(self, button)
    if button=="LeftButton" and IsShiftKeyDown() then
        self:StartMoving()
    end
end)

frame:SetScript("OnMouseUp", function(self, button)
    if button=="LeftButton" then
        self:StopMovingOrSizing()
        local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
        FastQuickChatDB.framePoint = point
        FastQuickChatDB.frameRelativePoint = relativePoint
        FastQuickChatDB.frameX = xOfs
        FastQuickChatDB.frameY = yOfs
    end
end)

-- Slash Command
SLASH_FQC1="/fqc"
SlashCmdList["FQC"]=function()
    if QC.F:IsShown() then QC.F:Hide() else QC.F:Show() end
end

-- Event Handling
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then
        -- DB initialisieren
        FastQuickChatDB = FastQuickChatDB or {}
        for k, v in pairs(defaults) do
            if FastQuickChatDB[k] == nil then FastQuickChatDB[k] = v end
        end

        -- Scale anwenden
        frame:SetScale(FastQuickChatDB.frameScale or 1)

        -- Position anwenden (mit Punkt)
        if FastQuickChatDB.framePoint then
            frame:ClearAllPoints()
            frame:SetPoint(
                FastQuickChatDB.framePoint,
                UIParent,
                FastQuickChatDB.frameRelativePoint,
                FastQuickChatDB.frameX,
                FastQuickChatDB.frameY
            )
        else
            frame:SetPoint("CENTER")
        end

        UpdateButtons()
        UpdateButtonFonts(FastQuickChatDB.frameScale or 1)
        UpdateBackground()

        -- Minimap via LDB
        local ldb = LibStub("LibDataBroker-1.1", true)
        local ldbIcon = LibStub("LibDBIcon-1.0", true)
        if ldb and ldbIcon then
            local dataObj = ldb:NewDataObject("FastQuickChat", {
                type = "data source",
                text = "FQC",
                icon = 134217,
                OnClick = function(_, button)
                    if button == "LeftButton" then
                        if QC.F:IsShown() then QC.F:Hide() else QC.F:Show() end
                    end
                end,
                OnTooltipShow = function(tt)
                    tt:AddLine("FastQuickChat")
                    tt:AddLine("Click to toggle bar", 0.2, 1, 0.2)
                end
            })
            if dataObj then
                if FastQuickChatDB.showMinimap then
                    ldbIcon:Register("FastQuickChat", dataObj, FastQuickChatDB.minimap)
                end
                FastQuickChat.ldbIcon = ldbIcon
            end
        end

    elseif event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD" then
        UpdateButtons()
        UpdateButtonFonts(FastQuickChatDB.frameScale or 1)

    elseif event == "PLAYER_LOGOUT" then
        _G["FastQuickChatDB"] = FastQuickChatDB
    end
end)
