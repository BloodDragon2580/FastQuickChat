local cfgFrame = CreateFrame("Frame", "QuickChat_CfgFrame", UIParent)
cfgFrame.name = "QuickChat"
InterfaceOptions_AddCategory(cfgFrame)
QuickChat.cfgFrame = cfgFrame

function cfgFrame:onAddonLoaded()
    local l = QuickChat_GetLocalization()

    createCheckButton("Roll", l["RO"], QC_Settings.enableRoll, function(checked)
        QC_Settings.enableRoll = checked
    end)

    createCheckButton("ReadyCheck", l["RC"], QC_Settings.enableReadyCheck, function(checked)
        QC_Settings.enableReadyCheck = checked
    end)

    createCheckButton("Pull", l["PULL"], QC_Settings.enablePull, function(checked)
        QC_Settings.enablePull = checked
    end)

    createCheckButton("Break", l["BREAK"], QC_Settings.enableBreak, function(checked)
        QC_Settings.enableBreak = checked
    end)

    createCheckButton("Reload", l["RELOAD"], QC_Settings.enableReload, function(checked)
        QC_Settings.enableReload = checked
    end)
end

local previousButton = nil
function createCheckButton(name, text, checked, onCheckedChanged)
    local b = CreateFrame("CheckButton", "QuickChat_CfgFrame_CheckButton" .. name, cfgFrame, "ChatConfigCheckButtonTemplate")
    -- The first button is positioned at the top of its parent.
    -- Other buttons are positioned at the bottom of the previous button
    if previousButton then
        b:SetPoint("TOPLEFT", previousButton, "BOTTOMLEFT")
    else
        b:SetPoint("TOPLEFT")
    end
    b:SetChecked(checked)
    b:SetScript("OnClick", function()
        onCheckedChanged(b:GetChecked())
    end)
    -- CheckButton has SetText, but it doesn't work
    getglobal(b:GetName() .. "Text"):SetText(text)
    -- Remember the created button to position next buttons after it
    previousButton = b
end

local QuickChatTitle = QuickChat_CfgFrame:CreateFontString("QuickChatTitle", "OVERLAY", "ChatFontNormal")
QuickChatTitle:SetPoint("TOP", QuickChat_CfgFrame, "TOP",0,-10) 
QuickChatTitle:SetText("|cffe1a500 QuickChat Settings")

local QuickChatVertText = QuickChat_CfgFrame:CreateFontString("vertText", "OVERLAY", "ChatFontNormal")
QuickChatVertText:SetPoint("TOP", QuickChat_CfgFrame , "TOP",0,-40)
QuickChatVertText:SetText("|cffffffff Here you can check or uncheck the buttons,\ndepending on which buttons you want to use.")

local QuickChatVertText = QuickChat_CfgFrame:CreateFontString("vertText", "OVERLAY", "ChatFontNormal")
QuickChatVertText:SetPoint("BOTTOM", QuickChat_CfgFrame , "BOTTOM",0,10)
QuickChatVertText:SetText("|cffff6060 A big Thx at KalitaAlexey for the settings Page.")