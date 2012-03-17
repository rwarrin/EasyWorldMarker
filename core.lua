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
EasyMarkerFrame:SetBackdropColor(.1, .1, .1, .8);
EasyMarkerFrame:SetBackdropBorderColor(.2, .2, .2, .9);
EasyMarkerFrame:SetWidth(101);
EasyMarkerFrame:SetHeight(120);
local dragtext = EasyMarkerFrame:CreateFontString(nil, "OVERLAY", frame);
dragtext:SetFont("Interface\\AddOns\\EasyWorldMarker\\media\\font.ttf", 10, "OUTLINE");
dragtext:SetText("|cff525252Click to Drag|r");
dragtext:SetPoint("CENTER", EasyMarkerFrame, "CENTER", 1, -50);
dragtext:SetJustifyH("CENTER")
dragtext:SetJustifyV("Bottom");
EasyMarkerFrame:Hide();
local ewm_visible = false;

-- Create Marker Button function
local function CreateEasyMarkerButton(btnName, btnText, point, relativeTo, pointRel, btnType)
	local frame = CreateFrame("Button", btnName, EasyMarkerFrame, "SecureActionButtonTemplate");
	if(btnType == "add") then
        frame:SetPoint(point, relativeTo, pointRel, 0, 0);
        frame:SetWidth(81);
        frame:SetHeight(17);
    elseif (btnType == "clear") then
        frame:SetPoint(point, relativeTo, pointRel, -1, 0);
        frame:SetWidth(21);
        frame:SetHeight(17);
    elseif (btnType == "big") then
        frame:SetPoint(point, relativeTo, pointRel, 0, 0);
        frame:SetWidth(101);
        frame:SetHeight(17);
    end
	frame:SetFrameLevel(EasyMarkerFrame:GetFrameLevel() + 1);
	frame:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	frame:SetBackdrop( {
		bgFile = nil,
		edgeFile = "Interface\\AddOns\\EasyWorldMarker\\media\\flat.tga",
		tile = false, tileSize = 0, edgeSize = 1,
		insets = {left = -1, right = -1, top = -1, bottom = -1}
	});
    frame:SetBackdropBorderColor(0.2, 0.2, 0.2, 0.9)
	
	local t = frame:CreateFontString(nil, "OVERLAY", frame);
	t:SetFont("Interface\\AddOns\\EasyWorldMarker\\media\\font.ttf", 10, "OUTLINE");
	t:SetText(btnText);
	t:SetPoint("CENTER", frame, "CENTER", 1, 0);
	t:SetJustifyH("CENTER");
    t:SetJustifyV("MIDDLE");
	
	frame:SetAttribute("type", "macro");
end

-- Create blue flare set button
CreateEasyMarkerButton("EWM_BlueFlareSet", "|cff71a1d4Blue Flare|r", "TOPLEFT", EasyMarkerFrame, "TOPLEFT", "add");
EWM_BlueFlareSet:SetAttribute("macrotext", "/wm 1");

-- Create blue flare clear button
CreateEasyMarkerButton("EWM_BlueFlareClear", "|cffDBDBD9X|r", "TOPLEFT", EWM_BlueFlareSet, "TOPRIGHT", "clear");
EWM_BlueFlareClear:SetAttribute("macrotext", "/cwm 1");

-- Create green flare set button 
CreateEasyMarkerButton("EWM_GreenFlareSet", "|cff7de87fGreen Flare|r", "TOPLEFT", EWM_BlueFlareSet, "BOTTOMLEFT", "add");
EWM_GreenFlareSet:SetAttribute("macrotext", "/wm 2");

-- Create green flare clear button
CreateEasyMarkerButton("EWM_GreenFlareClear", "|cffDBDBD9X|r", "TOPLEFT", EWM_GreenFlareSet, "TOPRIGHT", "clear");
EWM_GreenFlareClear:SetAttribute("macrotext", "/cwm 2");

-- Create purple flare set button
CreateEasyMarkerButton("EWM_PurpleFlareSet", "|cffc05ef8Purple Flare|r", "TOPLEFT", EWM_GreenFlareSet, "BOTTOMLEFT", "add");
EWM_PurpleFlareSet:SetAttribute("macrotext", "/wm 3");

-- Create purple flare clear button
CreateEasyMarkerButton("EWM_PurpleFlareClear", "|cffDBDBD9X|r", "TOPLEFT", EWM_PurpleFlareSet, "TOPRIGHT", "clear");
EWM_PurpleFlareClear:SetAttribute("macrotext", "/cwm 3");

-- Create red flare set button
CreateEasyMarkerButton("EWM_RedFlareSet", "|cfff1385bRed Flare|r", "TOPLEFT", EWM_PurpleFlareSet, "BOTTOMLEFT", "add");
EWM_RedFlareSet:SetAttribute("macrotext", "/wm 4");

-- Create red flare clear button
CreateEasyMarkerButton("EWM_RedFlareClear", "|cffDBDBD9X|r", "TOPLEFT", EWM_RedFlareSet, "TOPRIGHT", "clear");
EWM_RedFlareClear:SetAttribute("macrotext", "/cwm 4");

-- Create yellow flare set button
CreateEasyMarkerButton("EWM_YellowFlareSet", "|cfff5de61Yellow Flare|r", "TOPLEFT", EWM_RedFlareSet, "BOTTOMLEFT", "add");
EWM_YellowFlareSet:SetAttribute("macrotext", "/wm 5");

-- Create red flare clear button
CreateEasyMarkerButton("EWM_YellowFlareClear", "|cffDBDBD9X|r", "TOPLEFT", EWM_YellowFlareSet, "TOPRIGHT", "clear");
EWM_YellowFlareClear:SetAttribute("macrotext", "/cwm 5");

-- Create clear all flares button
CreateEasyMarkerButton("EWM_ClearFlare", "|cffFFFFFFRemove Flares|r", "TOPLEFT", EWM_YellowFlareSet, "BOTTOMLEFT", "big");
EWM_ClearFlare:SetAttribute("macrotext", "/cwm all");

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
