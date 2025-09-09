require("T6.Menus.CareerLeaderboard")
CoD.LeaderboardOverviewMenu = {}
local f0_local0 = 60
local f0_local1 = 430
local f0_local2 = 40
local f0_local3 = {
	r = 0.4,
	g = 0.92,
	b = 0.86
}
local f0_local4, f0_local5, f0_local6, f0_local7, f0_local8, f0_local9, f0_local10, f0_local11, f0_local12, f0_local13, f0_local14 = nil
f0_local14 = function (f1_arg0)
	local f1_local0 = {}
	local f1_local1 = f0_local9()
	local f1_local2 = Dvar.ui_mapname:get()
	local f1_local3 = UIExpression.GetXUID(controller)
	for f1_local10, f1_local11 in ipairs(CoD.AARUtility.MapList) do
		if not f1_local11.isDevLevel and not f1_local11.isRTSMap and f1_local11.doStats then
			Dvar.ui_mapname:set(f1_local11.name)
			local f1_local7 = Engine.Localize("SPUI_" .. f1_local11.alias .. "_MISSION_NAME")
			if f1_local10 <= f1_local1 then
				local f1_local8 = UIExpression.GetLevelBestStat(controller, "levelScore")
				if f1_local8 == 0 then
					f1_local8 = "--"
				end
				local f1_local9 = UIExpression.GetOtherPlayerLevelBestStat(controller, "levelScore")
				if f1_local9 == 0 or f1_local3 == f1_arg0.xuid then
					f1_local9 = "--"
				end
				table.insert(f1_local0, {
					f1_local7,
					f1_local8,
					f1_local9
				})
			end
		end
	end
	for f1_local10, f1_local11 in ipairs(CoD.AARUtility.MapList) do
		if not f1_local11.isDevLevel and f1_local11.isRTSMap and f1_local11.doStats then
			Dvar.ui_mapname:set(f1_local11.name)
			local f1_local7 = Engine.Localize("SPUI_" .. f1_local11.alias .. "_MISSION_NAME")
			if f1_local11.rtsStart <= f1_local1 then
				local f1_local8 = UIExpression.GetLevelBestStat(controller, "levelScore")
				if f1_local8 == 0 then
					f1_local8 = "--"
				end
				local f1_local9 = UIExpression.GetOtherPlayerLevelBestStat(controller, "levelScore")
				if f1_local9 == 0 or f1_local3 == f1_arg0.xuid then
					f1_local9 = "--"
				end
				table.insert(f1_local0, {
					f1_local7,
					f1_local8,
					f1_local9
				})
			end
		end
	end
	Dvar.ui_mapname:set(f1_local2)
	return f1_local0
end

f0_local8 = function ()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	
	local contentPane = LUI.UIElement.new()
	contentPane:setLeftRight(true, true, 0, 0)
	contentPane:setTopBottom(true, true, f0_local0, 0)
	Widget:addElement(contentPane)
	Widget.contentPane = contentPane
	
	Widget.compareboard = nil
	return Widget
end

f0_local10 = function ()
	Engine.LoadLeaderboard("LB_SP_CAMPAIGN", "TRK_ALLTIME")
	Engine.RequestLeaderboardData(UIExpression.GetPrimaryController(), CoD.LB_FILTER_FRIENDS)
end

f0_local9 = function ()
	return UIExpression.GetDStat(UIExpression.GetPrimaryController(), "PlayerStatsList", "HIGHESTLEVELCOMPLETED", "personalBest") + 1
end

f0_local11 = function (f5_arg0, f5_arg1)
	DebugPrint("OnFriendSelection: "" .. f5_arg1.button.playerName .. "" xuid " .. f5_arg1.button.xuid)
	if not f5_arg0.inProgressFetch then
		f5_arg0.inProgressFetch = {
			name = f5_arg1.button.playerName,
			xuid = f5_arg1.button.xuid,
			button = f5_arg1.button
		}
		f5_arg0:registerEventHandler("service_record_fetched", f0_local12)
		f5_arg0:registerEventHandler("service_record_fetch_failed", OnPlayerDataFetchFail)
		Engine.Exec(f5_arg1.controller, "getServiceRecord " .. f5_arg1.button.xuid)
	end
end

f0_local12 = function (f6_arg0, f6_arg1)
	DebugPrint("OnPlayerDataFetchComplete "" .. f6_arg0.inProgressFetch.name .. "" xuid " .. f6_arg0.inProgressFetch.xuid)
	local f6_local0 = f6_arg0.inProgressFetch
	f6_arg0.inProgressFetch = nil
	if f6_arg0.compareboard then
		f6_arg0.compareboard:close()
		f6_arg0.compareboard = nil
	end
	f6_arg0.compareboard = f0_local4(f6_arg1.controller, f6_local0)
	f6_arg0.contentPane:addElement(f6_arg0.compareboard)
	f6_arg0.previousCompletedFetch = f6_local0
end

function OnPlayerDataFetchFail(f7_arg0, f7_arg1)
	DebugPrint("OnPlayerDataFetchFail "" .. f7_arg0.inProgressFetch.name .. "" xuid " .. f7_arg0.inProgressFetch.xuid)
	local f7_local0 = f7_arg0.inProgressFetch
	f7_arg0.inProgressFetch = nil
	if f7_arg0.compareboard then
		f7_arg0.compareboard:close()
		f7_arg0.compareboard = nil
	end
	f7_arg0.previousCompletedFetch = f7_local0
end

f0_local4 = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f0_local1 + f0_local2, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(f0_local5(HudRef, InstanceRef))
	return Widget
end

f0_local13 = function (f9_arg0, f9_arg1)
	if f9_arg1.totalresults == nil then
		f9_arg0:showError(Engine.Localize("MPUI_LB_ERROR"))
		return 
	elseif f0_local9() == 1 then
		f9_arg0.fakeEntry = true
		f9_arg0:setTotalItems(f9_arg1.totalresults + 1)
	else
		f9_arg0.fakeEntry = false
		f9_arg0:setTotalItems(f9_arg1.totalresults)
	end
	if f9_arg0.loadedXuid == UIExpression.GetXUID(controller) then
		f9_arg0:processEvent({
			name = "listbox_move_down"
		})
		f9_arg0:processEvent({
			name = "listbox_focussed_button_click"
		})
	end
end

f0_local5 = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	local f10_local1 = {
		220,
		100,
		-1
	}
	local f10_local2 = {
		LUI.Alignment.Left,
		LUI.Alignment.Center,
		LUI.Alignment.Center
	}
	local f10_local3 = {}
	local f10_local4 = Engine.Localize("MENU_LEVEL_NAME_CAPS")
	local Widget = Engine.Localize("MENU_HIGH_SCORE_CAPS")
	local f10_local6 = Engine.Localize("MENU_VERSUS_CAPS")
	f10_local3 = f10_local4
	f10_local4 = "Default"
	Widget = LUI.UIElement.new()
	f10_local6 = CoD.textSize[f10_local4]
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, CoD.textSize[f10_local4])
	Widget:addElement(Widget)
	local f10_local7 = 0
	for f10_local11, f10_local12 in ipairs(f10_local1) do
		local f10_local13 = LUI.UIText.new()
		f10_local13:setFont(CoD.fonts[f10_local4])
		f10_local13:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
		if f10_local12 >= 0 then
			f10_local13:setLeftRight(true, false, f10_local7, f10_local7 + f10_local12)
		else
			f10_local13:setLeftRight(true, true, f10_local7, 0)
		end
		f10_local13:setTopBottom(true, true, 0, 0)
		f10_local13:setAlignment(f10_local2[f10_local11])
		f10_local13:setText(f10_local3[f10_local11])
		Widget:addElement(f10_local13)
		f10_local7 = f10_local7 + f10_local12
	end
	f10_local8 = f0_local14(InstanceRef)
	f10_local9 = CoD.CoD9Button.Height * 0.95
	f10_local10 = "Default"
	f10_local11 = {
		CoD.white,
		f0_local3,
		CoD.AARUtility.OtherPlayerStatColor
	}
	f10_local12 = CoD.ScrollingVerticalList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f10_local6,
		bottom = 0
	}, 2)
	Widget:addElement(f10_local12)
	for f10_local22, f10_local23 in ipairs(f10_local8) do
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, false, 0, f10_local9)
		f10_local12:addElementToList(Widget)
		f10_local7 = 0
		local f10_local25 = {}
		local f10_local26 = {
			5,
			0,
			0
		}
		for f10_local18, f10_local19 in ipairs(f10_local1) do
			local f10_local21 = LUI.UIText.new()
			f10_local21:setFont(CoD.fonts[f10_local10])
			f10_local21:setRGB(f10_local11[f10_local18].r, f10_local11[f10_local18].g, f10_local11[f10_local18].b)
			f10_local21:setAlpha(1)
			if f10_local19 >= 0 then
				f10_local21:setLeftRight(true, false, f10_local26[f10_local18] + f10_local7, f10_local7 + f10_local19)
			else
				f10_local21:setLeftRight(true, true, f10_local26[f10_local18] + f10_local7, 0)
			end
			f10_local21:setTopBottom(true, true, 0, 0)
			local f10_local16 = Dvar.loc_language:get()
			if f10_local16 == CoD.LANGUAGE_FULLJAPANESE or f10_local16 == CoD.LANGUAGE_JAPANESE then
				local f10_local17 = CoD.CoD9Button.Height * 0.65
				f10_local21:setTopBottom(false, false, -f10_local17 / 2, f10_local17 / 2)
			end
			f10_local21:setAlignment(f10_local2[f10_local18])
			f10_local21:setText(f10_local23[f10_local18])
			local f10_local17 = LUI.UIImage.new()
			if f10_local19 >= 0 then
				f10_local17:setLeftRight(true, false, f10_local7, f10_local7 + f10_local19)
			else
				f10_local17:setLeftRight(true, true, f10_local7, 0)
			end
			f10_local17:setTopBottom(true, true, 0, 0)
			table.insert(f10_local25, f10_local17)
			Widget:addElement(f10_local17)
			Widget:addElement(f10_local21)
			f10_local7 = f10_local7 + f10_local19
		end
		CoD.AARUtility.DecorateButtonRow(f10_local25)
	end
	f10_local8 = nil
	return Widget
end

f0_local6 = function (f11_arg0, f11_arg1)
	local f11_local0 = UIExpression.GetPrimaryController()
	local f11_local1 = false
	local f11_local2 = false
	local f11_local3 = UIExpression.IsSignedInToLive(f11_local0) ~= 0
	if f11_arg0.checkSignIn and f11_local3 == f11_arg0.isSignedIn then
		return false
	end
	f11_arg0.isSignedIn = f11_local3
	if f11_local3 then
		local Widget = CoD.isPS3
		if Widget == 0 then
			f11_local1 = Widget
		else
			f11_local1 = UIExpression.IsContentRatingAllowed(f11_local0) == 0
		end
		f11_local2 = Engine.IsSignedInToDemonware(f11_local0) == true
	end
	if not f11_local1 and f11_local2 and f11_local3 then
		if f11_arg0.signInText then
			f11_arg0.signInText:close()
			f11_arg0.signInText = nil
		end
		if f11_arg0.leaderboardSection then
			if f11_arg0.leaderboardSection.listbox then
				f11_arg0.leaderboardSection.listbox:close()
			end
			f11_arg0.leaderboardSection:close()
			f11_arg0.leaderboardSection = nil
		end
		if f11_arg0.compareboard then
			f11_arg0.compareboard:close()
			f11_arg0.compareboard = nil
		end
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, 0, f0_local1)
		Widget:setTopBottom(true, true, 0, 0)
		
		local listbox = CoD.CareerLeaderboard.new({
			leftAnchor = true,
			rightAnchor = false,
			left = 0,
			right = f0_local1,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0
		}, f11_local0)
		Widget:addElement(listbox)
		Widget.listbox = listbox
		
		local f11_local6 = listbox:getListBox()
		f11_local6:registerEventHandler("leaderboardlist_update", f0_local13)
		f0_local10()
		f11_arg0.contentPane:addElement(Widget)
		f11_arg0.leaderboardSection = Widget
		f11_arg0:dispatchEventToParent({
			name = "tab_changed",
			tabIndex = 3
		})
	else
		if f11_arg0.signInText == nil then
			local Widget = LUI.UIText.new()
			Widget:setLeftRight(true, true, 0, 0)
			Widget:setTopBottom(false, false, -CoD.textSize.Condensed / 2, CoD.textSize.Condensed / 2)
			Widget:setFont(CoD.fonts.Condensed)
			Widget:setAlignment(LUI.Alignment.Center)
			f11_arg0:addElement(Widget)
			f11_arg0.signInText = Widget
		end
		if f11_arg0.leaderboardSection then
			if f11_arg0.leaderboardSection.listbox then
				f11_arg0.leaderboardSection.listbox:close()
			end
			f11_arg0.leaderboardSection:close()
			f11_arg0.leaderboardSection = nil
		end
		if f11_arg0.compareboard then
			f11_arg0.compareboard:close()
			f11_arg0.compareboard = nil
		end
		if f11_local1 then
			f11_arg0.signInText:setText(Engine.Localize("XBOXLIVE_MPNOTALLOWED"))
		elseif not f11_local3 then
			f11_arg0.signInText:setText(Engine.Localize("XBOXLIVE_LIVE_LEADERBOARD"))
			if not f11_arg0.checkSignIn and CoD.isPS3 then
				Engine.Exec(f11_local0, "xsigninlive")
			end
		else
			f11_arg0.signInText:setText(Engine.Localize("MENU_SERVER_NOT_AVAILABLE_TRY_LATER"))
		end
		f11_arg0:dispatchEventToParent({
			name = "tab_changed",
			tabIndex = 3
		})
	end
	f11_arg0.checkSignIn = true
	return false
end

f0_local7 = function (f12_arg0, f12_arg1)
	local f12_local0 = UIExpression.GetPrimaryController()
	local f12_local1 = false
	local f12_local2 = false
	local f12_local3 = UIExpression.IsSignedInToLive(f12_local0) ~= 0
	local f12_local4 = UIExpression.IsSignedIn(f12_local0) ~= 0
	if f12_local3 then
		local Widget = CoD.isPS3
		if Widget == 0 then
			f12_local1 = Widget
		else
			f12_local1 = UIExpression.IsContentRatingAllowed(f12_local0) == 0
		end
		f12_local2 = Engine.IsSignedInToDemonware(f12_local0) == true
	end
	if not f12_local1 and f12_local2 and f12_local3 then
		if f12_arg0.signInText then
			f12_arg0.signInText:close()
		end
		if f12_arg0.timer then
			f12_arg0.timer:close()
		end
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, 0, f0_local1)
		Widget:setTopBottom(true, true, 0, 0)
		local f12_local6 = CoD.CareerLeaderboard.new({
			leftAnchor = true,
			rightAnchor = false,
			left = 0,
			right = f0_local1,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0
		}, f12_local0)
		Widget:addElement(f12_local6)
		local f12_local7 = f12_local6:getListBox()
		f12_local7:registerEventHandler("leaderboardlist_update", f0_local13)
		f0_local10()
		f12_arg0.contentPane:addElement(Widget)
		f12_arg0:dispatchEventToParent({
			name = "tab_changed",
			tabIndex = 3
		})
		return true
	elseif f12_arg0.signInText == nil then
		local Widget = LUI.UIText.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(false, false, -CoD.textSize.Condensed / 2, CoD.textSize.Condensed / 2)
		Widget:setFont(CoD.fonts.Condensed)
		Widget:setAlignment(LUI.Alignment.Center)
		f12_arg0:addElement(Widget)
		f12_arg0.signInText = Widget
	end
	if f12_local1 then
		f12_arg0.signInText:setText(Engine.Localize("XBOXLIVE_MPNOTALLOWED"))
		if f12_arg0.timer then
			f12_arg0.timer:close()
		end
	elseif not f12_local3 then
		f12_arg0.signInText:setText(Engine.Localize("XBOXLIVE_LIVE_LEADERBOARD"))
		if not f12_arg0.checkSignIn and CoD.isPS3 then
			Engine.Exec(f12_local0, "xsigninlive")
		end
	else
		f12_arg0.signInText:setText(Engine.Localize("MENU_SERVER_NOT_AVAILABLE_TRY_LATER"))
	end
	f12_arg0.checkSignIn = true
	return false
end

CoD.LeaderboardOverviewMenu.new = function ()
	local f13_local0 = f0_local8()
	f13_local0:registerEventHandler("leaderboard_button_action", f0_local11)
	f13_local0.isSignedIn = false
	f13_local0.checkSignIn = false
	if CoD.isPS3 then
		if not f0_local6(f13_local0) then
			f13_local0.timer = LUI.UITimer.new(1000, "check_login", false, f13_local0)
			f13_local0:addElement(f13_local0.timer)
			f13_local0:registerEventHandler("check_login", f0_local6)
		end
	elseif not f0_local7(f13_local0) then
		f13_local0.timer = LUI.UITimer.new(1000, "check_login", false, f13_local0)
		f13_local0:addElement(f13_local0.timer)
		f13_local0:registerEventHandler("check_login", f0_local7)
	end
	return f13_local0
end

