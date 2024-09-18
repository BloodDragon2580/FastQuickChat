-- Funktion zum Erstellen und Hinzufügen eines Panels zu den Interface-Optionen
local function CreateOptionsPanel(name, displayName, parentName, onLoadFunction)
    -- Erstelle das Frame für das Optionspanel
    local panel = CreateFrame("Frame", name, UIParent)
    panel.name = displayName
    panel.parent = parentName

    -- Füge die Widgets zum Panel hinzu
    if onLoadFunction then
        onLoadFunction(panel)
    end

    -- Manuelles Hinzufügen zu den Interface-Optionen
    local category = Settings.RegisterCanvasLayoutCategory(panel, displayName)
    Settings.RegisterAddOnCategory(category)

    return panel
end

-- Funktion zum Erstellen eines CheckButtons
local function CreateCheckButton(parent, name, text, checked, onCheckedChanged)
    if not parent.checkButtons then
        parent.checkButtons = {}
    end

    -- Positionierung basierend auf der Anzahl der vorhandenen Checkbuttons
    local numButtons = #parent.checkButtons

    local checkButton = CreateFrame("CheckButton", name, parent, "InterfaceOptionsCheckButtonTemplate")
    checkButton:SetPoint("TOPLEFT", 16, -16 - (24 * numButtons))
    checkButton.Text:SetText(text)
    checkButton:SetChecked(checked)
    checkButton:SetScript("OnClick", function(self)
        local isChecked = self:GetChecked()
        onCheckedChanged(isChecked)
        print(name .. " CheckButton clicked: " .. tostring(isChecked))  -- Debugging-Ausgabe
    end)
    
    table.insert(parent.checkButtons, checkButton)
end

-- Callback-Funktion für das OnLoad-Ereignis des Panels
local function OnAddonLoaded(panel)
    if not FQC_Settings then
        FQC_Settings = {
            enableRoll = false,
            enableReadyCheck = false,
            enablePull = false,
            enableBreak = false,
            enableReload = false
        }
    end
    
    local l = FastQuickChat_GetLocalization()

    -- Erstelle UI-Elemente
    local title = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOP", panel, "TOP", 0, -10)
    title:SetText(l["BUTTONTITLE"])
    
    local info = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    info:SetPoint("TOP", panel, "TOP", 0, -40)
    info:SetText(l["BUTTONINFO"])
    
    local info1 = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    info1:SetPoint("BOTTOM", panel, "BOTTOM", 0, 10)
    info1:SetText(l["AfterReload"])

    -- Füge CheckButtons hinzu und füge Debugging-Ausgaben hinzu
    CreateCheckButton(panel, "RollCheckButton", l["RO"], FQC_Settings.enableRoll, function(checked)
        FQC_Settings.enableRoll = checked
        print("RollCheckButton state updated to: " .. tostring(checked))
    end)
    CreateCheckButton(panel, "ReadyCheckButton", l["RC"], FQC_Settings.enableReadyCheck, function(checked)
        FQC_Settings.enableReadyCheck = checked
        print("ReadyCheckButton state updated to: " .. tostring(checked))
    end)
    CreateCheckButton(panel, "PullCheckButton", l["PULL"], FQC_Settings.enablePull, function(checked)
        FQC_Settings.enablePull = checked
        print("PullCheckButton state updated to: " .. tostring(checked))
    end)
    CreateCheckButton(panel, "BreakCheckButton", l["BREAK"], FQC_Settings.enableBreak, function(checked)
        FQC_Settings.enableBreak = checked
        print("BreakCheckButton state updated to: " .. tostring(checked))
    end)
    CreateCheckButton(panel, "ReloadCheckButton", l["RELOAD"], FQC_Settings.enableReload, function(checked)
        FQC_Settings.enableReload = checked
        print("ReloadCheckButton state updated to: " .. tostring(checked))
    end)
end

-- Variable, um sicherzustellen, dass das Panel nur einmal initialisiert wird
local mainPanelInitialized = false

-- Event-Handler für das Addon
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "FastQuickChat" then
        -- Initialisiere das Haupt-Optionspanel nur einmal nach dem Laden des Addons
        if not mainPanelInitialized then
            mainPanelInitialized = true
            local mainPanel = CreateOptionsPanel("FastQuickChat_BtnCfgFrame", "FastQuickChat Buttons", "FastQuickChat", OnAddonLoaded)
        end
    end
end)
