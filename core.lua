-- Create Marker Frame
local EasyMarkerFrame = CreateFrame("Frame", "EasyMarkerFrame", UIParent);
EasyMarkerFrame:SetBackdrop( {
	bgFile = "Interface\\AddOns\\EasyWorldMarker\\media\\flat.tga",
	edgeFile = "Interface\\AddOns\\EasyWorldMarker\\media\\flat.tga",
	tile = false, tileSize = 0, edgeSize = 1,
	insets = {left = -1, right = -1, top = -1, bottom = -1}
	} );
EasyMarkerFrame:RegisterForDrag("LeftButton");
EasyMarkerFrame:EnableMouse(true);
EasyMarkerFrame:SetMovable(true);
EasyMarkerFrame:SetScript("OnDragStart", EasyMarkerFrame.StartMoving);
EasyMarkerFrame:SetScript("OnDragStop", EasyMarkerFrame.StopMovingOrSizing);
EasyMarkerFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 100, -100);
EasyMarkerFrame:SetBackdropColor(.1, .1, .1, .5);
EasyMarkerFrame:SetBackdropBorderColor(.2, .2, .2, .8);
EasyMarkerFrame:SetWidth(80);
EasyMarkerFrame:SetHeight(110);
EasyMarkerFrame:Show();
local ewm_visible = true;

-- Create Marker Button function
local function CreateEasyMarkerButton(btnName, btnText, point, relativeTo, pointRel)
	local frame = CreateFrame("Button", btnName, EasyMarkerFrame, "SecureActionButtonTemplate");
	frame:SetPoint(point, relativeTo, pointRel, 0, -3);
	frame:SetWidth(80);
	frame:SetHeight(15);
	frame:SetFrameLevel(EasyMarkerFrame:GetFrameLevel() + 1);
	frame:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	
	local t = frame:CreateFontString(nil, "OVERLAY", frame);
	t:SetFont("Interface\\AddOns\\EasyWorldMarker\\media\\font.ttf", 10, "OUTLINE");
	t:SetText(btnText);
	t:SetPoint("CENTER");
	t:SetJustifyH("CENTER");
	
	frame:SetAttribute("type", "macro");
end

-- Create Marker Buttons
CreateEasyMarkerButton("EWM_BlueFlare", "|cff71a1d4Blue Flare|r", "TOPLEFT", EasyMarkerFrame, "TOPLEFT");
EWM_BlueFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button1
]]);

CreateEasyMarkerButton("EWM_GreenFlare", "|cff7de87fGreen Flare|r", "TOPLEFT", EWM_BlueFlare, "BOTTOMLEFT");
EWM_GreenFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button2
]]);

CreateEasyMarkerButton("EWM_PurpleFlare", "|cffc05ef8Purple Flare|r", "TOPLEFT", EWM_GreenFlare, "BOTTOMLEFT");
EWM_PurpleFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button3
]]);

CreateEasyMarkerButton("EWM_RedFlare", "|cfff1385bRed Flare|r", "TOPLEFT", EWM_PurpleFlare, "BOTTOMLEFT");
EWM_RedFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button4
]]);

CreateEasyMarkerButton("EWM_YellowFlare", "|cfff5de61Yellow Flare|r", "TOPLEFT", EWM_RedFlare, "BOTTOMLEFT");
EWM_YellowFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button5
]]);

CreateEasyMarkerButton("EWM_ClearFlare", "|cffFFFFFFClear Flares|r", "TOPLEFT", EWM_YellowFlare, "BOTTOMLEFT");
EWM_ClearFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button6
]]);

local function EWM_Toggle()
	if(ewm_visible == true) then
		EasyMarkerFrame:Hide();
		ewm_visible = false;
	else
		EasyMarkerFrame:Show();
		ewm_visible = true;
	end
end

-- Create slash command
SLASH_EASYWORLDMARKER1 = "/ewm";
SLASH_EASYWORLDMARKER2 = "/wm";
SlashCmdList["EASYWORLDMARKER"] = function() EWM_Toggle(); end
