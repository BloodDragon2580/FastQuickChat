local frame = CreateFrame("Frame", "QuickChat_MainCfgFrame", UIParent)
frame.name = "QuickChat"
frame:SetSize(400, 300)  -- Optional: Setze die Größe des Frames

-- Neue Methode, um das Panel zu den Interface-Optionen hinzuzufügen
local category = Settings.RegisterCanvasLayoutCategory(frame, frame.name)
Settings.RegisterAddOnCategory(category)

QuickChat.mainConfigurationFrame = frame

function frame:OnAddonLoaded()
    -- Sicherstellen, dass andere Konfigurationsrahmen vorhanden sind
    if QuickChat.generalConfigurationFrame then
        QuickChat.generalConfigurationFrame:OnAddonLoaded()
    end
    if QuickChat.buttonsConfigurationFrame then
        QuickChat.buttonsConfigurationFrame:OnAddonLoaded()
    end

    local l = QuickChat_GetLocalization()

    local title = frame:CreateFontString("QuickChat_MainCfgFrame_Title", "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOP", frame, "TOP", 0, -10)
    title:SetText(l["TITLE"])

    local info = frame:CreateFontString("QuickChat_BtnCfgFrame_Info", "OVERLAY", "GameFontHighlight")
    info:SetPoint("TOP", frame, "TOP", 0, -40)
    info:SetText(l["StartInfo"])

    local vertText = frame:CreateFontString("QuickChat_MainCfgFrame_Thx", "OVERLAY", "GameFontHighlight")
    vertText:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
    vertText:SetText(l["THX"])
end

-- Event-Handler zur Registrierung des Addons
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" and (...) == "QuickChat" then
        self:OnAddonLoaded()
    end
end)

-- Registriere die Events
frame:RegisterEvent("ADDON_LOADED")
