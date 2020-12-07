local frame = CreateFrame("Frame", "QuickChat_GenCfgFrame", QuickChat.mainConfigurationFrame)
frame.name = "General"
frame.parent = QuickChat.mainConfigurationFrame.name
InterfaceOptions_AddCategory(frame)
QuickChat.generalConfigurationFrame = frame

function frame:OnAddonLoaded()

    local l = QuickChat_GetLocalization()
    
    local title = frame:CreateFontString("QuickChat_MainCfgFrame_Title", "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOP", frame, "TOP", 0, -10) 
    title:SetText(l["GENERALTITLE"])

    local info = frame:CreateFontString("QuickChat_BtnCfgFrame_Info", "OVERLAY", "GameFontHighlight")
    info:SetPoint("TOP", frame, "TOP", 0, -40)
    info:SetText(l["GENERALINFO"])
	
    local info = frame:CreateFontString("QuickChat_BtnCfgFrame_Info1", "OVERLAY", "GameFontHighlightLarge")
    info:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
    info:SetText(l["AfterReload"])

    frame:CreateCheckButton("LockFramePosition", (l["LockFramePosition"]), QC_Settings.lockFramePosition, function(checked)
        QC_Settings.lockFramePosition = checked
    end)	
end

local previousButton = nil
function frame:CreateCheckButton(name, text, checked, onCheckedChanged)
    QuickChatConfiguration_CreateCheckButton(name, text, frame, previousButton, checked, onCheckedChanged)
end
