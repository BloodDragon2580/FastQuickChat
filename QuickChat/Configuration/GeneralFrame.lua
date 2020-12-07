local frame = CreateFrame("Frame", "QuickChat_GenCfgFrame", QuickChat.mainConfigurationFrame)
frame.name = "General"
frame.parent = QuickChat.mainConfigurationFrame.name
InterfaceOptions_AddCategory(frame)
QuickChat.generalConfigurationFrame = frame

function frame:OnAddonLoaded()
    frame:CreateCheckButton("LockFramePosition", "Lock frame position", QC_Settings.lockFramePosition, function(checked)
        QC_Settings.lockFramePosition = checked
    end)
end

local previousButton = nil
function frame:CreateCheckButton(name, text, checked, onCheckedChanged)
    QuickChatConfiguration_CreateCheckButton(name, text, frame, previousButton, checked, onCheckedChanged)
end
