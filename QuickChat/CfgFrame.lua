local cfgFrame = CreateFrame("Frame", "QuickChat_CfgFrame", UIParent)
local L = QuickChat_GetLocalization()
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
        b:SetPoint("TOP", previousButton, "BOTTOM")
    else
        b:SetPoint("TOP",-120,-100)
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

local QuickChatTitle = QuickChat_CfgFrame:CreateFontString("QuickChatTitle", "OVERLAY", "GameFontHighlightLarge")
QuickChatTitle:SetPoint("TOP", QuickChat_CfgFrame, "TOP",0,-10) 
QuickChatTitle:SetText(L["TITLE"])

local QuickChatVertText = QuickChat_CfgFrame:CreateFontString("vertText", "OVERLAY", "GameFontHighlight")
QuickChatVertText:SetPoint("TOP", QuickChat_CfgFrame , "TOP",0,-40)
QuickChatVertText:SetText(L["INFO"])

local QuickChatVertText = QuickChat_CfgFrame:CreateFontString("vertText", "OVERLAY", "GameFontHighlight")
QuickChatVertText:SetPoint("BOTTOM", QuickChat_CfgFrame , "BOTTOM",0,10)
QuickChatVertText:SetText(L["THX"])
