local frame = CreateFrame("Frame", "QuickChat_BtnCfgFrame", QuickChat.mainConfigurationFrame)
frame.name = "Buttons"
frame.parent = QuickChat.mainConfigurationFrame.name
InterfaceOptions_AddCategory(frame)
QuickChat.buttonsConfigurationFrame = frame

function frame:OnAddonLoaded()
    local l = QuickChat_GetLocalization()
    
    local info = frame:CreateFontString("QuickChat_BtnCfgFrame_Info", "OVERLAY", "GameFontHighlight")
    info:SetPoint("TOP", frame, "TOP", 0, -40)
    info:SetText(l["INFO"])

    frame:CreateCheckButton("Roll", l["RO"], QC_Settings.enableRoll, function(checked)
        QC_Settings.enableRoll = checked
    end)

    frame:CreateCheckButton("ReadyCheck", l["RC"], QC_Settings.enableReadyCheck, function(checked)
        QC_Settings.enableReadyCheck = checked
    end)

    frame:CreateCheckButton("Pull", l["PULL"], QC_Settings.enablePull, function(checked)
        QC_Settings.enablePull = checked
    end)

    frame:CreateCheckButton("Break", l["BREAK"], QC_Settings.enableBreak, function(checked)
        QC_Settings.enableBreak = checked
    end)

    frame:CreateCheckButton("Reload", l["RELOAD"], QC_Settings.enableReload, function(checked)
        QC_Settings.enableReload = checked
    end)
end

local previousButton = nil
function frame:CreateCheckButton(name, text, checked, onCheckedChanged)
    previousButton = QuickChatConfiguration_CreateCheckButton(name, text, frame, previousButton, checked, onCheckedChanged)
end
