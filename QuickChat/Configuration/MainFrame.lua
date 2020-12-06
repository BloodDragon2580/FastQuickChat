local frame = CreateFrame("Frame", "QuickChat_MainCfgFrame", UIParent)
frame.name = "QuickChat"
InterfaceOptions_AddCategory(frame)
QuickChat.mainConfigurationFrame = frame

function frame:OnAddonLoaded()
    QuickChat.generalConfigurationFrame:OnAddonLoaded()
    QuickChat.buttonsConfigurationFrame:OnAddonLoaded()

    local l = QuickChat_GetLocalization()

    local title = frame:CreateFontString("QuickChat_MainCfgFrame_Title", "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOP", frame, "TOP", 0, -10) 
    title:SetText(l["TITLE"])

    local vertText = frame:CreateFontString("QuickChat_MainCfgFrame_Thx", "OVERLAY", "GameFontHighlight")
    vertText:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
    vertText:SetText(l["THX"])
end
