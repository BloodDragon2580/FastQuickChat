-- Erzeugt einen Check-Button.
-- `name` wird verwendet, um einen global eindeutigen Namen für den Check-Button zu erstellen.
-- `text` ist der Text des Check-Buttons.
-- `parent` ist das übergeordnete Frame des Check-Buttons.
-- `relativeFrame` (falls nicht nil) wird verwendet, um den oberen Rand des Check-Buttons am unteren Rand des relativen Frames zu positionieren.
-- `checked` gibt an, ob der Check-Button anfänglich aktiviert ist.
-- `onCheckedChanged` ist die Callback-Funktion, die aufgerufen wird, wenn sich der Status des Check-Buttons ändert.
-- Gibt den Check-Button zurück
function FastQuickChatConfiguration_CreateCheckButton(name, text, parent, relativeFrame, checked, onCheckedChanged)
    -- Erstellen des CheckButtons mit einer einzigartigen ID
    local checkButton = CreateFrame("CheckButton", "FastQuickChat_CheckButton_" .. name, parent, "ChatConfigCheckButtonTemplate")
    
    -- Positionierung des Buttons relativ zum gegebenen Frame oder zu einem festen Punkt
    if relativeFrame then
        checkButton:SetPoint("TOP", relativeFrame, "BOTTOM", 0, -8) -- Fügt etwas Abstand zum relativen Frame hinzu
    else
        checkButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 16, -16) -- Fallback-Position
    end
    
    -- Setzt den anfänglichen Zustand des Buttons
    checkButton:SetChecked(checked)
    
    -- Callback für den Statuswechsel des Buttons
    checkButton:SetScript("OnClick", function()
        onCheckedChanged(checkButton:GetChecked())
    end)
    
    -- Setzt den Text des Buttons
    local textLabel = _G[checkButton:GetName() .. "Text"]
    if textLabel then
        textLabel:SetText(text)
    end
    
    return checkButton
end
