-- Globales Table, das von anderen Dateien des Addons verwendet wird
FastQuickChat = {}

local BUTTON_PADDING = 4
local BUTTON_MARGIN = 0
local BUTTON_MINIMUM_WIDTH = 40
local FRAME_PADDING = 8
local frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
local L = FastQuickChat_GetLocalization()
local QC = {}
local backdrop = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize = 16,
    insets = { left = 3, right = 3, top = 3, bottom = 3 }
}

-- Funktion zum Öffnen des Chat-Eingabefelds
local function Open_chat(channel)
    local editBox = ChatEdit_ChooseBoxForSend()
    local txt = editBox:GetText()
    local chatFrame = editBox.chatFrame
    ChatFrame_OpenChat(channel .. txt, chatFrame)
    ChatEdit_UpdateHeader(editBox)
end

-- Funktion zum Hinzufügen eines Frames
local function Add_Frame(w, h)
    local CF = CreateFrame("FRAME", "FastQuickChatFrame", UIParent, "BackdropTemplate")
    CF:EnableMouse(true)
    if not FQC_Settings.lockFramePosition then
        CF:SetMovable(true)
        CF:SetClampedToScreen(true)
        CF:SetScript("OnMouseDown", CF.StartMoving)
        CF:SetScript("OnMouseUp", function(self)
            self:StopMovingOrSizing()
            local point, _, _, xOfs, yOfs = self:GetPoint()
            FQC_Point = { pnt = point, x = xOfs, y = yOfs }
        end)
    end
    local pad = FQC_Point.pnt or "BOTTOMLEFT"
    CF:SetSize(w, h)
    CF:SetPoint(pad, FQC_Point.x, FQC_Point.y)
    CF:SetBackdrop(backdrop)
    CF:SetBackdropColor(0.2, 0.2, 0.2, 1)
    CF:SetBackdropBorderColor(0.2, 0.1, 0.1, 1)
    CF:Hide()
    return CF
end

-- Setzt die Breite des Buttons
local function FastQuickChat_SetButtonWidth(button)
    local w = button:GetTextWidth() + BUTTON_PADDING
    button:SetWidth(math.max(w, BUTTON_MINIMUM_WIDTH))
end

-- Globale Variablen für Rahmenbreite und vorherigen Button
local frameWidth = 0
local relativeButton = nil

-- Funktion zum Hinzufügen eines Buttons
local function Add_Button(text, command, parentFrame, color)
    local Button = CreateFrame("Button", nil, parentFrame)
    if relativeButton then
        Button:SetPoint("LEFT", relativeButton, "RIGHT", BUTTON_MARGIN, 0)
        frameWidth = frameWidth + BUTTON_MARGIN
    else
        Button:SetPoint("LEFT", parentFrame, "LEFT", FRAME_PADDING, 0)
        frameWidth = frameWidth + FRAME_PADDING
    end
    Button:SetNormalFontObject("GameFontHighlightSmall")
    Button:SetText(text)
    FastQuickChat_SetButtonWidth(Button)
    frameWidth = frameWidth + Button:GetWidth()
    Button:SetHeight(Button:GetTextHeight() + BUTTON_PADDING)
    Button:RegisterForClicks("AnyUp")
    
    local textureFrame = Button:CreateTexture("ARTWORK")
    textureFrame:SetColorTexture(unpack(color))
    textureFrame:SetAllPoints(Button)
    
    Button:SetScript("OnClick", function()
        if command == "/pull 10" then
            SlashCmdList.DEADLYBOSSMODSPULL(10)
        elseif command == "/roll" then
            RandomRoll("1", "100")
        elseif command == "/readycheck" then
            DoReadyCheck()
        elseif command == "/reload" then
            ReloadUI()
        elseif command == "/script C_PartyInfo.LeaveParty()" then
            C_PartyInfo.LeaveParty()
        elseif command == "/break 10" then
            SlashCmdList.DEADLYBOSSMODSBREAK(10)
        else
            Open_chat(command)
        end
    end)
    
    relativeButton = Button
    return Button
end

-- Funktion zum Hinzufügen eines Buttons ohne Klick-Verarbeitung
local function Add_Button_NOc(text, x, y, parent, color)
    local Button = CreateFrame("Button", nil, parent)
    Button:SetPoint("CENTER", parent, "LEFT", x, y)
    Button:SetNormalFontObject("GameFontHighlightSmall")
    Button:SetText(text)
    Button:RegisterForClicks("AnyUp")
    
    local textureFrame = Button:CreateTexture("ARTWORK")
    textureFrame:SetColorTexture(unpack(color))
    textureFrame:SetAllPoints(Button)
    
    return Button
end

-- Aktualisiert das Haupt-Frame und fügt Buttons hinzu
local function update_frame_btn()
    if QC.F then
        QC.F:Hide()
        QC = {}
    end
    
    QC.F = Add_Frame(10, 30)
    frameWidth = 0
    relativeButton = nil

    if FQC_Settings.bt ~= 1 then
        for key in pairs(L) do
            L[key] = ""
        end
    end

    QC.b = Add_Button(L["S"], "/s ", QC.F, {0.5, 0.5, 0.5, 1})
    
    if IsInGuild() then
        QC.b1 = Add_Button(L["G"], "/g ", QC.F, {0.3, 0.6, 0.4, 1})
    end
    
    if IsInGroup() then
        QC.b2 = Add_Button(L["P"], "/p ", QC.F, {0.2, 0.3, 0.4, 1})
    end
    
    if HasLFGRestrictions() then
        QC.dungeonButton = Add_Button(L["I"], "/i ", QC.F, {1, 0.5, 0, 1})
    end
    
    if IsInRaid() then
        QC.b3 = Add_Button(L["R"], "/raid ", QC.F, {0.5, 0.0, 0.4, 1})
    end
    
    if FQC_Settings.enableRoll then
        QC.b4 = Add_Button(L["RO"], "/roll", QC.F, {0.7, 0.4, 0, 1})
    end
    
    if FQC_Settings.enableReadyCheck then
        if IsInGroup() or (inInstance and (instanceType == "party" or instanceType == "raid")) then
            QC.b5 = Add_Button(L["RC"], "/readycheck", QC.F, {0.1, 0.2, 0, 1})
        end
    end
    
    if FQC_Settings.enablePull then
        if IsInGroup() or (inInstance and (instanceType == "party" or instanceType == "raid")) then
            QC.b6 = Add_Button(L["PULL"], "/pull 10", QC.F, {0.7, 0.7, 0.2, 1})
        end
    end
    
    if FQC_Settings.enableBreak then
        if IsInGroup() or (inInstance and (instanceType == "party" or instanceType == "raid")) then
            QC.b7 = Add_Button(L["BREAK"], "/break 10", QC.F, {0.1, 0.1, 0.5, 1})
        end
    end
    
    if FQC_Settings.enableReload then
        QC.b9 = Add_Button(L["RELOAD"], "/reload", QC.F, {0.8, 0.0, 0.0, 1})
    end
    
    frameWidth = frameWidth + FRAME_PADDING
    QC.F:SetWidth(frameWidth)
    QC.F:Show()
end

-- Event-Handler für ADDON_LOADED
function frame:ADDON_LOADED(arg1)
    if arg1 == "FastQuickChat" then
        if not FQC_Point then
            FQC_Point = { x = GetScreenWidth() * 0.5, y = GetScreenHeight() * 0.5 }
        end
        
        FQC_Settings = FQC_Settings or {}
        FQC_Settings.bt = FQC_Settings.bt or 1
        FQC_Settings.fixedFrame = FQC_Settings.fixedFrame == true
        FQC_Settings.enableRoll = FQC_Settings.enableRoll ~= false
        FQC_Settings.enableReadyCheck = FQC_Settings.enableReadyCheck ~= false
        FQC_Settings.enablePull = FQC_Settings.enablePull ~= false
        FQC_Settings.enableBreak = FQC_Settings.enableBreak ~= false
        FQC_Settings.enableReload = FQC_Settings.enableReload ~= false
        
        FastQuickChat.mainConfigurationFrame:OnAddonLoaded()
        if not QC.F then
            update_frame_btn()
        end
    end
end

-- Event-Handler für GROUP_ROSTER_UPDATE
function frame:GROUP_ROSTER_UPDATE()
    if FQC_Point and QC.F then
        update_frame_btn()
    end
end

-- Event-Handler für CONSOLE_MESSAGE
function frame:CONSOLE_MESSAGE()
    if FQC_Point and QC.F then
        update_frame_btn()
    end
end

-- Registriert die Event-Handler
frame:RegisterEvent("CONSOLE_MESSAGE")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:SetScript("OnEvent", function(self, event, ...)
    self[event](self, ...)
end)
