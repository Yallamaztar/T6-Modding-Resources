CoD.RateMatchPopup = {}
local f0_local0 = 0
local f0_local1 = CoD.textSize.Big
local f0_local2 = 30
local f0_local3 = CoD.textSize.Condensed
local f0_local4 = 400
local f0_local5 = nil
local f0_local6 = 0
local f0_local7 = 256
local f0_local8 = 10
local f0_local9 = 370
local f0_local10 = false
local f0_local11 = false
CoD.RateMatchPopup.CreateHeader = function (f1_arg0, f1_arg1)
	f1_arg0.headerLabel = LUI.UIText.new()
	f1_arg0.headerLabel:setLeftRight(true, true, 0, 0)
	f1_arg0.headerLabel:setTopBottom(true, false, 0, f0_local1)
	f1_arg0.headerLabel:setAlpha(CoD.textAlpha)
	f1_arg0.headerLabel:setAlignment(LUI.Alignment.Left)
	f1_arg0.headerLabel:setFont(CoD.fonts.Condensed)
	f1_arg0.headerLabel:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f1_arg0.headerLabel:setText(Engine.Localize(f1_arg1))
	f1_arg0:addElement(f1_arg0.headerLabel)
end

CoD.RateMatchPopup.CreateMessage = function (f2_arg0)
	UPVAL0 = f0_local2
	f2_arg0.messageLabel = LUI.UIText.new()
	f2_arg0.messageLabel:setLeftRight(true, false, 0, f0_local4)
	f2_arg0.messageLabel:setTopBottom(true, false, f0_local0 + f0_local2, f0_local0 + f0_local2 + f0_local3)
	f2_arg0.messageLabel:setAlignment(LUI.Alignment.Left)
	f2_arg0.messageLabel:setFont(CoD.fonts.Condensed)
	f2_arg0.messageLabel:setText(Engine.Localize("MENU_NETWORK_QUALITY_DESCRIPTION"))
	f2_arg0:addElement(f2_arg0.messageLabel)
end

CoD.RateMatchPopup.AddLargeLogo = function (f3_arg0, f3_arg1, f3_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f0_local7, 0)
	Widget:setTopBottom(false, false, -(f0_local7 / 2) - f0_local8, f0_local7 / 2 - f0_local8)
	UPVAL2 = LUI.UIImage.new()
	f0_local5:setLeftRight(true, true, 0, 0)
	f0_local5:setTopBottom(true, true, 0, 0)
	f0_local5:setImage(RegisterMaterial(f3_arg2))
	Widget:addElement(f0_local5)
	f3_arg0:addElement(Widget)
end

CoD.RateMatchPopup.CreateButtonList = function (f4_arg0)
	f4_arg0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f0_local0 + f0_local9,
		bottom = 0
	})
	f4_arg0:addElement(f4_arg0.buttonList)
	local f4_local0 = f4_arg0.buttonList:addButton(Engine.Localize("MENU_NETWORK_QUALITY_DECLINE"), Engine.Localize("MENU_NETWORK_QUALITY_DECLINE_HINT"))
	f4_local0:setActionEventName("track_match_rating_decline")
	local f4_local1 = f4_arg0.buttonList:addButton(Engine.Localize("MENU_NETWORK_QUALITY_EXCELLENT"), Engine.Localize("MENU_NETWORK_QUALITY_EXCELLENT_HINT"))
	f4_local1:setActionEventName("track_match_rating_excellent")
	local f4_local2 = f4_arg0.buttonList:addButton(Engine.Localize("MENU_NETWORK_QUALITY_GOOD"), Engine.Localize("MENU_NETWORK_QUALITY_GOOD_HINT"))
	f4_local2:setActionEventName("track_match_rating_good")
	local f4_local3 = f4_arg0.buttonList:addButton(Engine.Localize("MENU_NETWORK_QUALITY_POOR"), Engine.Localize("MENU_NETWORK_QUALITY_POOR_HINT"))
	f4_local3:setActionEventName("track_match_rating_poor")
	f4_arg0.buttonList:processEvent({
		name = "gain_focus"
	})
end

CoD.RateMatchPopup.TrackEvent = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	f5_arg0:processEvent({
		name = "button_prompt_back"
	})
	Engine.SetDvar("tu_10_matchRatingSampleChance", 0)
	if f5_arg3 then
		CoD.AfterActionReport.RateMatchSurveyComplete = true
	end
	local f5_local0 = ""
	local f5_local1 = CoD.AfterActionReport.Stats
	if f5_local1.currentStats ~= nil then
		local f5_local2 = f5_local1.currentStats.AfterActionReportStats.demoFileID:get()
		if f5_local2 ~= nil and f5_local2 ~= "0" then
			f5_local0 = f5_local2
		end
	end
	f5_local0 = f5_local0 .. ", " .. f5_arg2 .. ", " .. Engine.GetConnectionType()
	print("SendRecordEvent: " .. f5_local0)
	Engine.SendRecordEvent(f5_arg1.controller, CoD.RECORD_EVENT_RATE_MATCH, f5_local0)
end

CoD.RateMatchPopup.TrackEvent_Decline = function (f6_arg0, f6_arg1)
	if f0_local10 ~= true then
		CoD.RateMatchPopup.TrackEvent(f6_arg0, f6_arg1, "DECLINE", false)
	end
	f6_arg0:processEvent({
		name = "button_prompt_back"
	})
	UPVAL0 = true
end

CoD.RateMatchPopup.TrackEvent_Excellent = function (f7_arg0, f7_arg1)
	CoD.RateMatchPopup.TrackEvent(f7_arg0, f7_arg1, "EXCELLENT", true)
end

CoD.RateMatchPopup.TrackEvent_Good = function (f8_arg0, f8_arg1)
	CoD.RateMatchPopup.TrackEvent(f8_arg0, f8_arg1, "GOOD", true)
end

CoD.RateMatchPopup.TrackEvent_Poor = function (f9_arg0, f9_arg1)
	CoD.RateMatchPopup.TrackEvent(f9_arg0, f9_arg1, "POOR", true)
end

CoD.RateMatchPopup.TrackEvent_Exit = function (f10_arg0, f10_arg1)
	if f0_local11 ~= true then
		CoD.RateMatchPopup.TrackEvent(f10_arg0, f10_arg1, "EXIT", false)
	end
	f10_arg0:processEvent({
		name = "button_prompt_back"
	})
	UPVAL0 = true
end

LUI.createMenu.RateMatchPopup = function (f11_arg0)
	local f11_local0 = CoD.Menu.New("RateMatchPopup")
	f11_local0:setOwner(f11_arg0)
	f11_local0:addLargePopupBackground()
	CoD.RateMatchPopup.CreateHeader(f11_local0, Engine.Localize("MENU_NETWORK_QUALITY_PROMPT"))
	CoD.RateMatchPopup.CreateMessage(f11_local0)
	CoD.RateMatchPopup.CreateButtonList(f11_local0)
	CoD.RateMatchPopup.AddLargeLogo(f11_local0, f11_arg0, "menu_motd_survey")
	f11_local0.primaryButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_NETWORK_QUALITY_ACCEPT"), nil, "")
	f11_local0:addLeftButtonPrompt(f11_local0.primaryButton)
	f11_local0.secondaryButton = CoD.ButtonPrompt.new("secondary", Engine.Localize("MENU_BACK"), f11_local0, "track_match_rating_exit")
	f11_local0:addLeftButtonPrompt(f11_local0.secondaryButton)
	f11_local0:registerEventHandler("track_match_rating_decline", CoD.RateMatchPopup.TrackEvent_Decline)
	f11_local0:registerEventHandler("track_match_rating_excellent", CoD.RateMatchPopup.TrackEvent_Excellent)
	f11_local0:registerEventHandler("track_match_rating_good", CoD.RateMatchPopup.TrackEvent_Good)
	f11_local0:registerEventHandler("track_match_rating_poor", CoD.RateMatchPopup.TrackEvent_Poor)
	f11_local0:registerEventHandler("track_match_rating_exit", CoD.RateMatchPopup.TrackEvent_Exit)
	return f11_local0
end

