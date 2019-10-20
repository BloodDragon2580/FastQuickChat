local frame = CreateFrame("Frame",nil,UIParent)
local L=QCL[GetLocale()];
if type(L)~="table" then L=QCL["enUS"]; end
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
	local CF = CreateFrame("FRAME","addcomentframe_frame",UIParent);
	CF:SetMovable(true)
	CF:EnableMouse(true)
	CF:SetClampedToScreen(true)
	CF:SetScript("OnMouseDown", CF.StartMoving) 
	CF:SetScript("OnMouseUp",function(self, event, ...)
			self:StopMovingOrSizing();
			local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint(n);
			QC_Point={pnt=point,x=xOfs,y=yOfs};
	end)
	local pad = QC_Point.pnt or "BOTTOMLEFT";
	CF:SetWidth(w);   
	CF:SetHeight(h);
	CF:SetPoint(pad,QC_Point.x,QC_Point.y );
	CF:SetBackdrop(backdrop);
	CF:SetBackdropColor(0.2,0.2,0.2,1);
	CF:SetBackdropBorderColor(0.2,0.1,0.1,1);
	CF:Hide()
	return CF;
end
function Add_Button(text,command,x,y,parent,color) 
	local Button = CreateFrame("Button", nil, parent) 
	Button:SetWidth(80)
	Button:SetHeight(20)
	Button:SetPoint("CENTER",parent, "LEFT", x, y);
	Button:SetNormalFontObject("GameFontHighlight");
	Button:SetText(text)
	Button:RegisterForClicks("AnyUp") 
	local textureFrame4 = Button:CreateTexture("ARTWORK")
	textureFrame4:SetColorTexture(color[1],color[2],color[3],color[4])
	textureFrame4:SetAllPoints(Button)
	Button:SetScript("OnClick", function() 
		Open_chat(command);
	end )
	return Button;
end
function Add_Button_NOc(text,x,y,parent,color) 
	local Button = CreateFrame("Button", nil, parent)
	Button:SetWidth(80)
	Button:SetHeight(20)
	Button:SetPoint("CENTER",parent, "LEFT", x, y);
	Button:SetNormalFontObject("GameFontHighlight");
	Button:SetText(text)
	Button:RegisterForClicks("AnyUp") 
	local textureFrame4 = Button:CreateTexture("ARTWORK")
	textureFrame4:SetColorTexture(color[1],color[2],color[3],color[4])
	textureFrame4:SetAllPoints(Button)
	return Button;
end

--background
function update_frame_btn()
	if type(QC)=="table" and QC.F~=nil then QC.F:Hide(); QC={}; end
	inInstance, instanceType = IsInInstance();
	QC.F = Add_Frame(10,30); local W=50;
	if type(QC_Settings)=="table" then
		if QC_Settings.bt~=1 then for key, val in pairs(L) do L[key]=""; end end
	end
--background
	QC.b=Add_Button(L["S"],"/s ",W,0,QC.F,{0.5,0.5,0.5,1});W=W+81;
	if IsInGuild() then QC.b7=Add_Button(L["G"],"/g ",W,0,QC.F,{0.3,0.6,0.4,1});W=W+81; end
	QC.b=Add_Button(L["P"],"/p ",W,0,QC.F,{0.2,0.3,0.4,1});W=W+81;
	QC.b=Add_Button(L["R"],"/raid  ",W,0,QC.F,{0.5,0.0,0.4,1});W=W+81;
	QC.b=Add_Button(L["I"],"/i ",W,0,QC.F,{0.9,0.5,0.3,1});W=W+81;
	QC.b=Add_Button(L["RO"],"/roll",W,0,QC.F,{0.7,0.4,0,1});W=W+81;
	QC.b=Add_Button(L["RC"],"/readycheck",W,0,QC.F,{0.7,0.4,0,1});W=W+81;
	QC.b=Add_Button(L["PULL"],"/pull 6",W,0,QC.F,{0.8,0.7,0.9,1});W=W+50;
	
	QC.F:SetWidth(W);
	QC.F:Show();
	 
end

function frame:ADDON_LOADED(arg1)  
	if (arg1 == "QC_Settings" and type(QC_Settings)~="table") or not QC_Settings then QC_Settings={bt=1}; end

	if (arg1 == "QC_Point" and type(QC_Point)~="table") or not QC_Point then QC_Point={x=(GetScreenWidth()*0.5),y=(GetScreenHeight()*0.5)}; end
	if type(QC_Point)=="table" and QC.F==nil then update_frame_btn(); end 
end

function frame:GROUP_ROSTER_UPDATE(arg1)	
	if type(QC_Point)=="table" and QC.F~=nil then update_frame_btn(); end
end
function frame:CONSOLE_MESSAGE(arg1)
	if type(QC_Point)=="table" and QC.F~=nil then update_frame_btn(); end 
end
function frame:PLAYER_STOPPED_MOVING(arg1)
	if type(QC_Point)=="table" and QC.F~=nil then update_frame_btn(); end
end
function frame:PLAYER_STARTED_MOVING(arg1)
	if type(QC_Point)=="table" and QC.F~=nil then update_frame_btn(); end
end
function frame:CRITERIA_UPDATE(arg1)
	if type(QC_Point)=="table" and QC.F~=nil then update_frame_btn(); end
end

frame:RegisterEvent("CONSOLE_MESSAGE");
frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("GROUP_ROSTER_UPDATE");
frame:RegisterEvent("PLAYER_STOPPED_MOVING");
frame:RegisterEvent("PLAYER_STARTED_MOVING");
frame:RegisterEvent("CRITERIA_UPDATE");
frame:SetScript("OnEvent",function(self, event, ...) self[event](self, ...) end)
