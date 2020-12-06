-- The global table used by other files of the addon
QuickChat = {}

local BUTTON_PADDING = 4
local BUTTON_MARGIN = 0
local BUTTON_MINIMUM_WIDTH = 40
local FRAME_PADDING = 8
local frame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
local L = QuickChat_GetLocalization()
local QC={};
local backdrop = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",   
    edgeSize = 16,
    insets = { left = 3, right = 3, top = 3, bottom = 3 }
}

function Open_chat(channel)
	local editBox = ChatEdit_ChooseBoxForSend();
	local txt = editBox:GetText();
	local chatFrame = editBox.chatFrame;
	ChatFrame_OpenChat(channel..txt, chatFrame); 
	ChatEdit_UpdateHeader(editBox);
end
function Add_Frame(w,h)
	local CF = CreateFrame("FRAME", "addcomentframe_frame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
	CF:EnableMouse(true)
	if not QC_Settings.fixedFrame then
		CF:SetMovable(true)
		CF:SetClampedToScreen(true)
		CF:SetScript("OnMouseDown", CF.StartMoving) 
		CF:SetScript("OnMouseUp", function(self, event, ...)
			self:StopMovingOrSizing()
			local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint(n)
			QC_Point = {pnt = point, x = xOfs, y = yOfs}
		end)
	end
	local pad = QC_Point.pnt or "BOTTOMLEFT"
	CF:SetWidth(w)
	CF:SetHeight(h)
	CF:SetPoint(pad, QC_Point.x, QC_Point.y)
	CF:SetBackdrop(backdrop)
	CF:SetBackdropColor(0.2, 0.2, 0.2, 1)
	CF:SetBackdropBorderColor(0.2, 0.1, 0.1, 1)
	CF:Hide()
	return CF;
end

-- The function must be called after the button has font and text set, otherwise Button's GetTextWidth won't work
function QuickChat_SetButtonWidth(button)
	local w = button:GetTextWidth() + BUTTON_PADDING
	if w < BUTTON_MINIMUM_WIDTH then
		w = BUTTON_MINIMUM_WIDTH
	end
	button:SetWidth(w)
end

-- Contains accumulation of the frame's width. Add_Button increases it
local frameWidth = 0
-- Contains the previously created button. Add_Button uses it to place a new button by the previous button
local relativeButton = nil

function Add_Button(text, command, parentFrame, color)
	local Button = CreateFrame("Button", nil, parentFrame)
	-- The first button is placed related to the frame. Next buttons are placed after the previous
	if relativeButton ~= nil then
		Button:SetPoint("LEFT", relativeButton, "RIGHT", BUTTON_MARGIN, 0);
		frameWidth = frameWidth + BUTTON_MARGIN
	else
		Button:SetPoint("LEFT", parentFrame, "LEFT", FRAME_PADDING, 0)
		frameWidth = frameWidth + FRAME_PADDING
	end
	Button:SetNormalFontObject("GameFontHighlightSmall");
	Button:SetText(text)
	QuickChat_SetButtonWidth(Button)
	frameWidth = frameWidth + Button:GetWidth()
	Button:SetHeight(Button:GetTextHeight() + BUTTON_PADDING)
	Button:RegisterForClicks("AnyUp") 
	local textureFrame4 = Button:CreateTexture("ARTWORK")
	textureFrame4:SetColorTexture(color[1], color[2], color[3], color[4])
	textureFrame4:SetAllPoints(Button)
	Button:SetScript("OnClick", function() 
        if command=="/pull 10" then
            SlashCmdList.DEADLYBOSSMODSPULL(10)
    elseif command=="/roll" then
        RandomRoll("1","100")
    elseif command=="/readycheck" then
        DoReadyCheck()
    elseif command=="/reload" then
        ReloadUI()
    elseif command=="/script C_PartyInfo.LeaveParty()" then
        C_PartyInfo.LeaveParty()
    elseif command=="/break 10" then
            SlashCmdList.DEADLYBOSSMODSBREAK(10)
    else
            Open_chat(command)
        end
	end)
	relativeButton = Button
	return Button;
end
function Add_Button_NOc(text,x,y,parent,color) 
	local Button = CreateFrame("Button", nil, parent)
	-- Button:SetWidth(65)
	-- Button:SetHeight(20)
	Button:SetPoint("CENTER",parent, "LEFT", x, y);
	Button:SetNormalFontObject("GameFontHighlightSmall");
	Button:SetText(text)
	Button:RegisterForClicks("AnyUp") 
	local textureFrame4 = Button:CreateTexture("ARTWORK")
	textureFrame4:SetColorTexture(color[1],color[2],color[3],color[4])
	textureFrame4:SetAllPoints(Button)
	return Button;
end

--background
function update_frame_btn()
	if type(QC) == "table" and QC.F ~= nil then
		QC.F:Hide()
		QC = {}
	end
	inInstance, instanceType = IsInInstance()
	QC.F = Add_Frame(10, 30)
	local W=45
	if type(QC_Settings) == "table" then
		if QC_Settings.bt ~= 1 then
			for key, val in pairs(L) do
				L[key] = ""
			end
		end
	end
	frameWidth = 0
	relativeButton = nil
	QC.b = Add_Button(L["S"], "/s ", QC.F, {0.5, 0.5, 0.5, 1})
	if IsInGuild() then
		QC.b1 = Add_Button(L["G"], "/g ", QC.F, {0.3, 0.6, 0.4, 1})
	end
	if IsInGroup() then
		QC.b2 = Add_Button(L["P"], "/p ", QC.F, {0.2, 0.3, 0.4, 1})
	end

	if HasLFGRestrictions() then
		QC.dungeonButton = Add_Button(L["I"], "/i ", QC.F, {1, 0.5, 0, 1})
	end

	if IsInRaid() then
		QC.b3 = Add_Button(L["R"], "/raid ", QC.F, {0.5, 0.0, 0.4, 1})
	end

	if QC_Settings.enableRoll then
		QC.b4 = Add_Button(L["RO"], "/roll", QC.F, {0.7, 0.4, 0,1})
	end

	if QC_Settings.enableReadyCheck then
		if IsInGroup() or (inInstance ~= nil and instanceType == "party") or (inInstance ~= nil and instanceType == "raid") then
			QC.b5 = Add_Button(L["RC"], "/readycheck", QC.F, {0.1, 0.2, 0, 1})
		end
	end

	if QC_Settings.enablePull then
		if IsInGroup() or (inInstance ~= nil and instanceType == "party") or (inInstance ~= nil and instanceType == "raid") then
			QC.b6 = Add_Button(L["PULL"], "/pull 10", QC.F, {0.7, 0.7, 0.2, 1})
		end
	end

	if QC_Settings.enableBreak then
		if IsInGroup() or (inInstance ~= nil and instanceType == "party") or (inInstance ~= nil and instanceType == "raid") then
			QC.b7 = Add_Button(L["BREAK"], "/break 10", QC.F, {0.1, 0.1, 0.5, 1})
		end
	end

	if QC_Settings.enableReload then
		QC.b9 = Add_Button(L["RELOAD"], "/reload", QC.F, {0.8, 0.0, 0.0, 1})
	end
	
	frameWidth = frameWidth + FRAME_PADDING

	QC.F:SetWidth(frameWidth);
	QC.F:Show(); 
end

function frame:ADDON_LOADED(arg1)
	if arg1 == "QuickChat" then
		if QC_Point == nil then
			QC_Point = {
				x = GetScreenWidth() * 0.5,
				y = GetScreenHeight() * 0.5
			}
		end

		if QC_Settings == nil then
			QC_Settings = {}
		end

		if QC_Settings.bt == nil then
			QC_Settings.bt = 1
		end
		-- ~= false means true if nil
		QC_Settings.fixedFrame = QC_Settings.fixedFrame == true
		QC_Settings.enableRoll = QC_Settings.enableRoll ~= false
		QC_Settings.enableReadyCheck = QC_Settings.enableReadyCheck ~= false
		QC_Settings.enablePull = QC_Settings.enablePull ~= false
		QC_Settings.enableBreak = QC_Settings.enableBreak ~= false
		QC_Settings.enableReload = QC_Settings.enableReload ~= false
		QuickChat.mainConfigurationFrame:OnAddonLoaded()
		if QC.F == nil then
			update_frame_btn()
		end
	end
end

function frame:GROUP_ROSTER_UPDATE(arg1)	
	if type(QC_Point)=="table" and QC.F~=nil then update_frame_btn(); end
end
function frame:CONSOLE_MESSAGE(arg1)
	if type(QC_Point)=="table" and QC.F~=nil then update_frame_btn(); end 
end

frame:RegisterEvent("CONSOLE_MESSAGE");
frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("GROUP_ROSTER_UPDATE");
frame:SetScript("OnEvent",function(self, event, ...) self[event](self, ...) end)
