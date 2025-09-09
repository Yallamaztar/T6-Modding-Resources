require("T6.ProfileLeftRightSelector")
require("T6.HardwareProfileLeftRightSelector")
CoD.SearchPreferences = {}
CoD.SearchPreferences.UpdateHint = function (f1_arg0)
	f1_arg0.parentSelectorButton.hintText = f1_arg0.extraParams.associatedHintText
	local f1_local0 = f1_arg0.parentSelectorButton:getParent()
	if f1_local0 ~= nil and f1_local0.hintText ~= nil then
		f1_local0.hintText:updateText(f1_arg0.parentSelectorButton.hintText)
	end
end

CoD.SearchPreferences.SelectionChanged = function (f2_arg0)
	Engine.SetProfileVar(f2_arg0.parentSelectorButton.m_currentController, f2_arg0.parentSelectorButton.m_profileVarName, f2_arg0.value)
	CoD.SearchPreferences.UpdateHint(f2_arg0)
end

CoD.SearchPreferences.ButtonPromptResetMaxPing = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg0.pingSlider
	if f3_local0 then
		CoD.LeftRightSlider.SetCurrentValue(f3_local0, Dvar.goodPing:get())
	end
	if Dvar.tu12_searchSessionOverrideGeoLocation:get() and f3_arg0.serverLocations then
		Engine.SetHardwareProfileValue("dedicatedPingLog_ServerLocation", "")
		f3_arg0:dispatchEventToChildren({
			name = "refresh_choice"
		})
	end
end

CoD.SearchPreferences.IsRefreshingDone = function (f4_arg0, f4_arg1)
	f4_arg0.msg:setText(Engine.DedicatedPingLog_GetProgressText())
	if f4_arg1.timer.timeElapsedSinceStart > 30000 or not Engine.DedicatedPingLog_IsRefreshing() then
		f4_arg0:goBack(f4_arg1.timer.controller)
	end
	f4_arg1.timer.timeElapsedSinceStart = f4_arg1.timer.timeElapsedSinceStart + f4_arg1.timeElapsed
end

CoD.SearchPreferences.ClosePopUp = function (f5_arg0, f5_arg1)
	f5_arg0:goBack()
end

LUI.createMenu.popup_testingserver = function (f6_arg0)
	local f6_local0 = CoD.Popup.SetupPopupBusy("popup_testingserver", f6_arg0)
	f6_local0.anyControllerAllowed = true
	f6_local0.title:setText(Engine.Localize("PLATFORM_TESTING_SERVERS"))
	f6_local0:registerEventHandler("is_pingservers_done", CoD.SearchPreferences.IsRefreshingDone)
	f6_local0:registerEventHandler("callback_auto_select_location", CoD.SearchPreferences.ClosePopUp)
	local f6_local1 = LUI.UITimer.new(100, "is_pingservers_done", false)
	f6_local1.controller = f6_arg0
	f6_local1.timeElapsedSinceStart = 0
	f6_local0:addElement(f6_local1)
	f6_local0.msg:setText(Engine.DedicatedPingLog_GetProgressText())
	return f6_local0
end

CoD.SearchPreferences.ButtonPromptAutoSelectServerLocation = function (f7_arg0, f7_arg1)
	Engine.DedicatedPingLog_RefreshServers()
	f7_arg0.connectingPopup = f7_arg0:openPopup("popup_testingserver", f7_arg1.controller)
end

CoD.SearchPreferences.AutoSelectServerLocationCallback = function (f8_arg0, f8_arg1)
	Engine.SetHardwareProfileValue("dedicatedPingLog_ServerLocation", Engine.DedicatedPingLog_BestLocation())
	f8_arg0:dispatchEventToChildren({
		controller = f8_arg1.controller,
		name = "refresh_choice"
	})
	local f8_local0 = Engine.DedicatedPingLog_BestPing()
	if f8_local0 > 0 then
		local f8_local1 = Dvar.live_minMatchMakingPing:get()
		local f8_local2 = Dvar.live_maxMatchMakingPing:get()
		f8_local0 = math.ceil((f8_local0 + Dvar.excellentPing:get() / 2) / 10) * 10
		if f8_local0 < f8_local1 then
			f8_local0 = f8_local1
		elseif f8_local2 < f8_local0 then
			f8_local0 = f8_local2
		end
		SetPreferredPing(f8_arg1.controller, f8_local0)
		f8_arg0:dispatchEventToChildren({
			controller = f8_arg1.controller,
			name = "update_bar_from_profile"
		})
	end
end

CoD.SearchPreferences.addServerLocationChoices = function (f9_arg0)
	f9_arg0:addChoice(Engine.Localize("MPUI_NONE_SELECTED_CAPS"), "")
	for f9_local3, f9_local4 in pairs(Engine.DedicatedPingLog_GetLocations()) do
		f9_arg0:addChoice(Engine.Localize(f9_local4), f9_local4)
	end
end

LUI.createMenu.SearchPreferences = function (f10_arg0)
	local f10_local0 = CoD.Menu.NewSmallPopup("SearchPreferences")
	f10_local0:setOwner(f10_arg0)
	f10_local0:addTitle(Engine.Localize("MPUI_SEARCH_PREFERENCES_CAPS"))
	f10_local0:addBackButton()
	local f10_local1 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.textSize.Big + 20,
		bottom = 0
	})
	f10_local0:addElement(f10_local1)
	if CoD.usePCMatchmaking() then
		local f10_local2 = Dvar.live_minMatchMakingPing:get()
		local f10_local3 = Dvar.live_maxMatchMakingPing:get()
		FixPreferredPing(f10_arg0, f10_local2, f10_local3)
		local f10_local4 = f10_local1:addProfileLeftRightSlider(f10_arg0, Engine.Localize("PLATFORM_MAX_PING"), "PreferredPing", f10_local2, f10_local3, Engine.Localize("PLATFORM_MAX_PING_DESC"), 200, nil, CoD.SafeArea.AdjustSFX)
		f10_local4:setNumericDisplayFormatString("%d")
		f10_local4:setStepValue(10)
		f10_local4:setBarSpeed(0.2)
		f10_local0.pingSlider = f10_local4
		if Dvar.tu12_searchSessionOverrideGeoLocation:get() then
			local serverLocations = CoD.HardwareProfileLeftRightSelector.new(Engine.Localize("PLATFORM_SERVER_LOCTATION_SEL_LABEL"), "dedicatedPingLog_ServerLocation", 200, {
				leftAnchor = true,
				rightAnchor = true,
				left = 0,
				right = 0,
				topAnchor = true,
				bottomAnchor = false,
				top = 0,
				bottom = CoD.CoD9Button.Height
			}, CoD.SafeArea.AdjustSFX)
			CoD.SearchPreferences.addServerLocationChoices(serverLocations)
			serverLocations.hintText = Engine.Localize("PLATFORM_SERVER_LOCTATION_SEL_DESC")
			CoD.ButtonList.AssociateHintTextListenerToButton(serverLocations)
			f10_local1:addElement(serverLocations)
			f10_local0.serverLocations = serverLocations
			
			if Engine.DedicatedPingLog_IsRefreshAvailable() then
				local f10_local6 = CoD.ButtonPrompt.new
				local f10_local7 = "alt2"
				local f10_local8 = Engine.Localize("PLATFORM_AUTO_SERVER_LOCATION")
				local f10_local9 = f10_local0
				local f10_local10 = "button_prompt_auto_select_location"
				local f10_local11, f10_local12 = false
				local f10_local13, f10_local14 = false
				f10_local0:addRightButtonPrompt(f10_local6(f10_local7, f10_local8, f10_local9, f10_local10, f10_local11, f10_local12, f10_local13, f10_local14, "L"))
				f10_local0:registerEventHandler("button_prompt_auto_select_location", CoD.SearchPreferences.ButtonPromptAutoSelectServerLocation)
				f10_local0:registerEventHandler("callback_auto_select_location", CoD.SearchPreferences.AutoSelectServerLocationCallback)
			end
		end
		local f10_local15 = CoD.ButtonPrompt.new
		local serverLocations = "alt1"
		local f10_local6 = Engine.Localize("MENU_RESET_TO_DEFAULT")
		local f10_local7 = f10_local0
		local f10_local8 = "button_prompt_reset_max_ping"
		local f10_local9, f10_local10 = false
		local f10_local11, f10_local12 = false
		f10_local0:addRightButtonPrompt(f10_local15(serverLocations, f10_local6, f10_local7, f10_local8, f10_local9, f10_local10, f10_local11, f10_local12, "R"))
		f10_local0:registerEventHandler("button_prompt_reset_max_ping", CoD.SearchPreferences.ButtonPromptResetMaxPing)
		if CoD.useController and not f10_local0:restoreState() then
			f10_local4:processEvent({
				name = "gain_focus"
			})
		end
	else
		local f10_local2 = f10_local1:addProfileLeftRightSelector(f10_arg0, Engine.Localize("MPUI_CONNECTION_TYPE_CAPS"), "geographicalMatchmaking", "", 260)
		f10_local2:addChoice(Engine.Localize("MPUI_CONNECTION_BEST_CAPS"), 1, {
			associatedHintText = Engine.Localize("MPUI_CONNECTION_BEST_DESC")
		}, CoD.SearchPreferences.SelectionChanged)
		f10_local2:addChoice(Engine.Localize("MPUI_CONNECTION_NORMAL_CAPS"), 0, {
			associatedHintText = Engine.Localize("MPUI_CONNECTION_NORMAL_DESC")
		}, CoD.SearchPreferences.SelectionChanged)
		f10_local2:addChoice(Engine.Localize("MPUI_CONNECTION_ANY_CAPS"), 2, {
			associatedHintText = Engine.Localize("MPUI_CONNECTION_ANY_DESC")
		}, CoD.SearchPreferences.SelectionChanged)
		if CoD.useController and not f10_local0:restoreState() then
			f10_local2:processEvent({
				name = "gain_focus"
			})
		end
	end
	f10_local0:registerEventHandler("button_prompt_back", CoD.SearchPreferences.Back)
	return f10_local0
end

CoD.SearchPreferences.Back = function (f11_arg0, f11_arg1)
	if Dvar.tu12_searchSessionOverrideGeoLocation:get() then
		Engine.SaveHardwareProfile()
		Engine.ApplyHardwareProfileSettings()
	end
	if CoD.usePCMatchmaking() then
		Engine.CommitProfileChanges(f11_arg1.controller)
	end
	f11_arg0:saveState()
	f11_arg0:goBack(f11_arg1.controller)
end

