local frame = CreateFrame("Frame", "FastQuickChat_MainCfgFrame", UIParent)
frame.name = "FastQuickChat"
frame:SetSize(400, 300)  -- Optional: Setze die Größe des Frames

-- Neue Methode, um das Panel zu den Interface-Optionen hinzuzufügen
local category = Settings.RegisterCanvasLayoutCategory(frame, frame.name)
Settings.RegisterAddOnCategory(category)

FastQuickChat.mainConfigurationFrame = frame

function frame:OnAddonLoaded()
    -- Sicherstellen, dass andere Konfigurationsrahmen vorhanden sind
    if FastQuickChat.generalConfigurationFrame then
        FastQuickChat.generalConfigurationFrame:OnAddonLoaded()
    end
    if FastQuickChat.buttonsConfigurationFrame then
        FastQuickChat.buttonsConfigurationFrame:OnAddonLoaded()
    end

    local l = FastQuickChat_GetLocalization()

    local title = frame:CreateFontString("FastQuickChat_MainCfgFrame_Title", "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOP", frame, "TOP", 0, -10)
    title:SetText(l["TITLE"])

    local info = frame:CreateFontString("FastQuickChat_BtnCfgFrame_Info", "OVERLAY", "GameFontHighlight")
    info:SetPoint("TOP", frame, "TOP", 0, -40)
    info:SetText(l["StartInfo"])

    local vertText = frame:CreateFontString("FastQuickChat_MainCfgFrame_Thx", "OVERLAY", "GameFontHighlight")
    vertText:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
    vertText:SetText(l["THX"])
end

-- Event-Handler zur Registrierung des Addons
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" and (...) == "FastQuickChat" then
        self:OnAddonLoaded()
    end
end)

-- Registriere die Events
frame:RegisterEvent("ADDON_LOADED")
