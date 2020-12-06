-- Creates a check button.
-- `name` is used to make a globally unique name for the check button.
-- `text` is the check button's text.
-- `parent` is the check button's.
-- `relativeFrame` (if not nil) is used to position the top of the check button to the bottom of the relative frame.
-- `checked` indicates if the check button is initially checked
-- `onCheckedChanged` is the callback that to be called if the check button's status is changed
-- Returns the check button
function QuickChatConfiguration_CreateCheckButton(name, text, parent, relativeFrame, checked, onCheckedChanged)
    local b = CreateFrame("CheckButton", "QuickChat_CheckButton" .. name, parent, "ChatConfigCheckButtonTemplate")
    if relativeFrame then
        b:SetPoint("TOP", relativeFrame, "BOTTOM")
    else
        b:SetPoint("TOP", -120, -100)
    end
    b:SetChecked(checked)
    b:SetScript("OnClick", function()
        onCheckedChanged(b:GetChecked())
    end)
    -- CheckButton has SetText, but it doesn't work
    getglobal(b:GetName() .. "Text"):SetText(text)
    return b
end
