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
        showMinimap="Minimap-Button anzeigen", resetPos="Position zurücksetzen"
    }
elseif locale == "ruRU" then
    L = {
        title="FastQuickChat", desc="Настройки FastQuickChat",
        say="Сказать", guild="Гильдия", party="Группа", raid="Рейд",
        instance="Подземелье", roll="Разыграть", readycheck="Готовность",
        pull="Пул", ["break"]="Перерыв", reload="Перезагрузить",
        showMinimap="Показывать кнопку у миникарты", resetPos="Сброс позиции"
    }
elseif locale == "frFR" then
    L = {
        title="FastQuickChat", desc="Paramètres de FastQuickChat",
        say="Dire", guild="Guilde", party="Groupe", raid="Raid",
        instance="Instance", roll="Lancer", readycheck="Vérification",
        pull="Pull", ["break"]="Pause", reload="Recharger",
        showMinimap="Afficher le bouton Minimap", resetPos="Réinitialiser la position"
    }
elseif locale == "esES" then
    L = {
        title="FastQuickChat", desc="Configuración de FastQuickChat",
        say="Decir", guild="Hermandad", party="Grupo", raid="Banda",
        instance="Instancia", roll="Tirar", readycheck="Chequeo",
        pull="Pull", ["break"]="Pausa", reload="Recargar",
        showMinimap="Mostrar botón en el minimapa", resetPos="Restablecer posición"
    }
elseif locale == "itIT" then
    L = {
        title="FastQuickChat", desc="Impostazioni di FastQuickChat",
        say="Dire", guild="Gilda", party="Gruppo", raid="Incursione",
        instance="Istanza", roll="Tira", readycheck="Verifica Pronti",
        pull="Pull", ["break"]="Pausa", reload="Ricarica",
        showMinimap="Mostra pulsante minimappa", resetPos="Ripristina posizione"
    }
elseif locale == "zhCN" then
    L = {
        title="FastQuickChat", desc="FastQuickChat 设置",
        say="说", guild="公会", party="队伍", raid="团队",
        instance="副本", roll="掷骰子", readycheck="准备确认",
        pull="拉怪", ["break"]="休息", reload="重载界面",
        showMinimap="显示小地图按钮", resetPos="重置位置"
    }
elseif locale == "koKR" then
    L = {
        title="FastQuickChat", desc="FastQuickChat 설정",
        say="말하기", guild="길드", party="파티", raid="공격대",
        instance="인스턴스", roll="주사위", readycheck="준비 확인",
        pull="풀", ["break"]="휴식", reload="재로딩",
        showMinimap="미니맵 버튼 표시", resetPos="위치 초기화"
    }
else
    L = {
        title="FastQuickChat", desc="FastQuickChat Settings",
        say="Say", guild="Guild", party="Party", raid="Raid",
        instance="Instance", roll="Roll", readycheck="Ready Check",
        pull="Pull", ["break"]="Break", reload="Reload",
        showMinimap="Show Minimap Button", resetPos="Reset Position"
    }
end

-- Default Einstellungen
local defaults = {
    enableSay=true, enableGuild=true, enableParty=true, enableRaid=true,
    enableInstance=true, enableRoll=true, enableReadyCheck=true,
    enablePull=true, enableBreak=true, enableReload=true, showMinimap=true,
    frameX=nil, frameY=nil, frameScale=1,
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

-- Globale Tabelle
FastQuickChat = FastQuickChat or {}
local QC = {}
QC.F = frame
QC.buttons = {}

local BUTTON_PADDING=8
local BUTTON_MARGIN=4
local BUTTON_MIN_WIDTH=50
local FRAME_PADDING=10

-- Button erstellen
local function AddButton(text,command)
    local btn = CreateFrame("Button",nil,QC.F,"UIPanelButtonTemplate")
    btn:SetText(text)
    btn:SetNormalFontObject("GameFontNormal")
    local width = math.max(BUTTON_MIN_WIDTH, btn:GetTextWidth()+BUTTON_PADDING)
    btn:SetSize(width,28)
    btn:SetScript("OnClick", function()
        if command=="/pull 10" and SlashCmdList.DEADLYBOSSMODSPULL then
            SlashCmdList.DEADLYBOSSMODSPULL(10)
        elseif command=="/break 10" and SlashCmdList.DEADLYBOSSMODSBREAK then
            SlashCmdList.DEADLYBOSSMODSBREAK(10)
        elseif command=="/roll" then RandomRoll(1,100)
        elseif command=="/readycheck" then DoReadyCheck()
        elseif command=="/reload" then ReloadUI()
        else
            local editBox=ChatEdit_ChooseBoxForSend()
            ChatFrame_OpenChat(command,editBox.chatFrame)
        end
    end)
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

    local function place(btn)
        btn:SetPoint("LEFT", QC.F, "LEFT", x, y)
        x = x + btn:GetWidth() + BUTTON_MARGIN
        table.insert(QC.buttons, btn)
        btn:Show()
    end

    if FastQuickChatDB.enableSay then place(AddButton(L.say, "/s ")) end
    if FastQuickChatDB.enableGuild and IsInGuild() then place(AddButton(L.guild, "/g ")) end
    if FastQuickChatDB.enableParty and IsInGroup() then place(AddButton(L.party, "/p ")) end
    if FastQuickChatDB.enableRaid and (IsInRaid() or (inInstance and instanceType=="raid")) then place(AddButton(L.raid, "/raid ")) end
    if FastQuickChatDB.enableInstance and (inInstance and instanceType=="party") then place(AddButton(L.instance, "/i ")) end
    if FastQuickChatDB.enableRoll then place(AddButton(L.roll, "/roll")) end
    if FastQuickChatDB.enableReadyCheck and IsInGroup() then place(AddButton(L.readycheck, "/readycheck")) end
    if hasDBM then
        if FastQuickChatDB.enablePull then place(AddButton(L.pull, "/pull 10")) end
        if FastQuickChatDB.enableBreak then place(AddButton(L["break"], "/break 10")) end
    end
    if FastQuickChatDB.enableReload then place(AddButton(L.reload, "/reload")) end

    QC.F:SetWidth(x + FRAME_PADDING)
end

-- Options Panel
local panel = CreateFrame("Frame","FastQuickChatOptionsPanel",InterfaceOptionsFramePanelContainer)
panel.name=L.title
local title=panel:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
title:SetPoint("TOPLEFT",16,-16)
title:SetText(L.desc)

-- Checkbox erstellen (muss vor Aufruf stehen!)
local function CreateCheckbox(label,key,yOffset)
    local cb=CreateFrame("CheckButton",nil,panel,"InterfaceOptionsCheckButtonTemplate")
    cb:SetPoint("TOPLEFT",title,"BOTTOMLEFT",0,yOffset)
    cb.Text:SetText(label)
    cb:SetScript("OnShow",function() cb:SetChecked(FastQuickChatDB[key]) end)
    cb:SetScript("OnClick",function(self)
        FastQuickChatDB[key] = self:GetChecked() and true or false
        UpdateButtons()
        if key=="showMinimap" then
            if FastQuickChat.ldbIcon then
                if FastQuickChatDB.showMinimap then FastQuickChat.ldbIcon:Show("FastQuickChat") else FastQuickChat.ldbIcon:Hide("FastQuickChat") end
            end
        end
    end)
    return cb
end

-- Checkboxen erstellen
local yStart=-16
local i=0
local keys={"enableSay","enableGuild","enableParty","enableRaid","enableInstance","enableRoll","enableReadyCheck"}
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

-- Reset Position Button
local resetBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
resetBtn:SetNormalFontObject("GameFontNormal")
resetBtn:SetText(L.resetPos)

-- Dynamische Breite basierend auf Text
local padding = 16 -- etwas Puffer links/rechts
local width = resetBtn:GetTextWidth() + padding
resetBtn:SetSize(width, 22)

resetBtn:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, yStart-(i*30))
resetBtn:SetScript("OnClick", function()
    FastQuickChatDB.frameX = nil
    FastQuickChatDB.frameY = nil
    frame:ClearAllPoints()
    frame:SetPoint("CENTER")
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
        local x,y=self:GetLeft(),self:GetTop()
        FastQuickChatDB.frameX=x
        FastQuickChatDB.frameY=y
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

frame:SetScript("OnEvent",function(self,event,arg1,...)
    if event=="ADDON_LOADED" and arg1==addonName then
        FastQuickChatDB = FastQuickChatDB or {}
        for k,v in pairs(defaults) do
            if FastQuickChatDB[k]==nil then FastQuickChatDB[k]=v end
        end

        frame:SetScale(FastQuickChatDB.frameScale or 1)
        if FastQuickChatDB.frameX and FastQuickChatDB.frameY then
            frame:ClearAllPoints()
            frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", FastQuickChatDB.frameX, FastQuickChatDB.frameY)
        end

        UpdateButtons()

        -- Minimap via LDB
        local ldb = LibStub("LibDataBroker-1.1", true)
        local ldbIcon = LibStub("LibDBIcon-1.0", true)
        if ldb and ldbIcon then
            local dataObj = ldb:NewDataObject("FastQuickChat", {
                type="data source", text="FQC", icon=134217,
                OnClick = function(_, button)
                    if button=="LeftButton" then
                        if QC.F:IsShown() then QC.F:Hide() else QC.F:Show() end
                    end
                end,
                OnTooltipShow=function(tt)
                    tt:AddLine("FastQuickChat")
                    tt:AddLine("Click to toggle bar",0.2,1,0.2)
                end
            })
            if dataObj then
                if FastQuickChatDB.showMinimap then
                    ldbIcon:Register("FastQuickChat", dataObj, FastQuickChatDB.minimap)
                end
                FastQuickChat.ldbIcon = ldbIcon
            end
        end
    elseif event=="GROUP_ROSTER_UPDATE" or event=="PLAYER_ENTERING_WORLD" then
        UpdateButtons()
    elseif event=="PLAYER_LOGOUT" then
        _G["FastQuickChatDB"] = FastQuickChatDB
    end
end)
