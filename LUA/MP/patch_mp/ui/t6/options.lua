require("T6.HardwareProfileLeftRightSelector")
require("T6.HardwareProfileLeftRightSlider")
require("T6.KeyBindSelector")
require("T6.CategoryCarousel")
require("T6.Menus.OptionsControls")
require("T6.Menus.OptionsSettings")
require("T6.Menus.SafeAreaMenu")
require("T6.Menus.SystemInfoMenu")
require("T6.AudioSettingsOptions")
require("T6.BrightnessOptions")
require("T6.ButtonLayoutOptions")
require("T6.StickLayoutOptions")
CoD.Options = {}
CoD.Options.ButtonListWidth = 500
CoD.Options.Width = 540
CoD.Options.AdjustSFX = "cac_safearea"
CoD.Options.Back = function (f1_arg0, f1_arg1)
	CoD.Options.UpdateWindowPosition()
	Engine.Exec(f1_arg1.controller, "updategamerprofile")
	Engine.SaveHardwareProfile()
	Engine.ApplyHardwareProfileSettings()
	if CoD.isSinglePlayer == true then
		Engine.SendMenuResponse(f1_arg1.controller, "luisystem", "modal_stop")
	end
	f1_arg0:goBack(f1_arg1.controller)
end

CoD.Options.CloseMenu = function (f2_arg0, f2_arg1)
	CoD.Options.UpdateWindowPosition()
	Engine.Exec(f2_arg1.controller, "updategamerprofile")
	Engine.SaveHardwareProfile()
	Engine.ApplyHardwareProfileSettings()
	f2_arg0:close()
end

CoD.Options.Close = function (f3_arg0)
	Engine.Exec(f3_arg0:getOwner(), "updategamerprofile")
	CoD.Menu.close(f3_arg0)
end

CoD.Options.ApplyChanges = function (f4_arg0, f4_arg1)
	CoD.Options.SetDvarChanges(f4_arg0)
	Engine.Exec(f4_arg1.controller, "vid_restart")
end

CoD.Options.OpenControls = function (f5_arg0, f5_arg1)
	if f5_arg0:getParent() then
		f5_arg0:saveState()
		f5_arg0:openMenu("OptionsControlsMenu", f5_arg1.controller)
		f5_arg0:close()
	end
end

CoD.Options.OpenSettings = function (f6_arg0, f6_arg1)
	if f6_arg0:getParent() then
		f6_arg0:saveState()
		f6_arg0:openMenu("OptionsSettingsMenu", f6_arg1.controller)
		f6_arg0:close()
	end
end

CoD.Options.OpenSystemInfo = function (f7_arg0, f7_arg1)
	f7_arg0:saveState()
	f7_arg0:openMenu("SystemInfo", f7_arg1.controller)
	Engine.PlaySound("cac_grid_nav")
	f7_arg0:close()
end

CoD.Options.IsCommonLoaded = function (f8_arg0, f8_arg1)
	if Engine.IsCommonLoaded() then
		f8_arg0.timer:close()
		f8_arg0.spinner:close()
		f8_arg0.message:close()
		CoD.Options.AddOptionCategories(f8_arg0)
	end
end

CoD.Options.SupportsSubtitles = function ()
	local f9_local0 = Dvar.loc_language:get()
	if f9_local0 == CoD.LANGUAGE_ENGLISH or f9_local0 == CoD.LANGUAGE_BRITISH or f9_local0 == CoD.LANGUAGE_POLISH or f9_local0 == CoD.LANGUAGE_JAPANESE or f9_local0 == CoD.LANGUAGE_FULLJAPANESE then
		return true
	else
		return false
	end
end

CoD.Options.SupportsMatureContent = function ()
	if Dvar.loc_language:get() == CoD.LANGUAGE_ENGLISH then
		return true
	else
		return false
	end
end

CoD.Options.Button_EnumProfile_SelectionChanged = function (f11_arg0)
	Engine.SetProfileVar(f11_arg0.parentSelectorButton.m_currentController, f11_arg0.parentSelectorButton.m_profileVarName, f11_arg0.value)
	f11_arg0.parentSelectorButton.hintText = f11_arg0.extraParams.associatedHintText
	local f11_local0 = f11_arg0.parentSelectorButton:getParent()
	if f11_local0 ~= nil and f11_local0.hintText ~= nil then
		f11_local0.hintText:updateText(f11_arg0.parentSelectorButton.hintText)
	end
end

CoD.Options.Button_AddChoices = function (f12_arg0)
	if f12_arg0.strings == nil or #f12_arg0.strings == 0 then
		return 
	end
	for f12_local0 = 1, #f12_arg0.strings, 1 do
		f12_arg0:addChoice(f12_arg0.strings[f12_local0], f12_arg0.values[f12_local0])
	end
end

CoD.Options.Button_AddChoices_EnabledOrDisabled = function (f13_arg0)
	local f13_local0 = {}
	local f13_local1 = Engine.Localize("MENU_DISABLED_CAPS")
	local f13_local2 = Engine.Localize("MENU_ENABLED_CAPS")
	f13_arg0.strings = f13_local1
	f13_arg0.values = {
		0,
		1
	}
	CoD.Options.Button_AddChoices(f13_arg0)
end

CoD.Options.Button_AddChoices_OnOrOff = function (f14_arg0)
	local f14_local0 = {}
	local f14_local1 = Engine.Localize("MENU_OFF_CAPS")
	local f14_local2 = Engine.Localize("MENU_ON_CAPS")
	f14_arg0.strings = f14_local1
	f14_arg0.values = {
		0,
		1
	}
	CoD.Options.Button_AddChoices(f14_arg0)
end

CoD.Options.Button_AddChoices_YesOrNo = function (f15_arg0)
	local f15_local0 = {}
	local f15_local1 = Engine.Localize("MENU_NO_CAPS")
	local f15_local2 = Engine.Localize("MENU_YES_CAPS")
	f15_arg0.strings = f15_local1
	f15_arg0.values = {
		0,
		1
	}
	CoD.Options.Button_AddChoices(f15_arg0)
end

CoD.Options.AddHardwareProfileLeftRightSelector = function (f16_arg0, f16_arg1, f16_arg2, f16_arg3, f16_arg4, f16_arg5)
	local f16_local0 = CoD.HardwareProfileLeftRightSelector.new(f16_arg1, f16_arg2, f16_arg4, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.CoD9Button.Height
	})
	f16_local0.hintText = f16_arg3
	f16_local0:setPriority(f16_arg5)
	CoD.ButtonList.AssociateHintTextListenerToButton(f16_local0)
	f16_arg0.m_selectors[f16_arg2] = f16_local0
	f16_arg0:addElement(f16_local0)
	return f16_local0
end

CoD.Options.AddHardwareProfileLeftRightSlider = function (f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4, f17_arg5, f17_arg6, f17_arg7)
	local f17_local0 = CoD.HardwareProfileLeftRightSlider.new(f17_arg1, f17_arg2, f17_arg3, f17_arg4, f17_arg6, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.CoD9Button.Height
	})
	f17_local0.hintText = f17_arg5
	f17_local0:setPriority(f17_arg7)
	CoD.ButtonList.AssociateHintTextListenerToButton(f17_local0)
	f17_arg0.m_selectors[f17_arg2] = f17_local0
	f17_arg0:addElement(f17_local0)
	return f17_local0
end

CoD.Options.AddLeftRightSelector = function (f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4, f18_arg5)
	local f18_local0 = CoD.LeftRightSelector.new(f18_arg1, f18_arg2, f18_arg4, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.CoD9Button.Height
	})
	f18_local0.hintText = f18_arg3
	f18_local0:setPriority(f18_arg5)
	CoD.ButtonList.AssociateHintTextListenerToButton(f18_local0)
	f18_arg0:addElement(f18_local0)
	return f18_local0
end

CoD.Options.AddVoiceMeter = function (f19_arg0, f19_arg1, f19_arg2, f19_arg3)
	local f19_local0 = CoD.OptionElement.new(f19_arg1, nil, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.CoD9Button.Height
	})
	f19_local0.id = "VoiceMeter"
	f19_local0.hintText = f19_arg2
	CoD.ButtonList.AssociateHintTextListenerToButton(f19_local0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, 300)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setupVoiceMeter(20)
	f19_local0.horizontalList:addElement(Widget)
	f19_arg0:addElement(f19_local0)
end

CoD.Options.AddApplyPrompt = function (f20_arg0)
	if f20_arg0.applyPrompt == nil then
		local f20_local0 = CoD.ButtonPrompt.new
		local f20_local1 = "alt1"
		local f20_local2 = Engine.Localize("MENU_APPLY_CAPS")
		local f20_local3 = f20_arg0
		local f20_local4 = "open_apply_popup"
		local f20_local5, f20_local6 = false
		local f20_local7, f20_local8 = false
		f20_arg0.applyPrompt = f20_local0(f20_local1, f20_local2, f20_local3, f20_local4, f20_local5, f20_local6, f20_local7, f20_local8, "F")
	end
	f20_arg0:addRightButtonPrompt(f20_arg0.applyPrompt)
end

CoD.Options.AddResetPrompt = function (f21_arg0)
	if f21_arg0.resetPrompt == nil then
		local f21_local0 = CoD.ButtonPrompt.new
		local f21_local1 = "alt2"
		local f21_local2 = Engine.Localize("MENU_RESET_TO_DEFAULT")
		local f21_local3 = f21_arg0
		local f21_local4 = "open_default_popup"
		local f21_local5, f21_local6 = false
		local f21_local7, f21_local8 = false
		f21_arg0.resetPrompt = f21_local0(f21_local1, f21_local2, f21_local3, f21_local4, f21_local5, f21_local6, f21_local7, f21_local8, "R")
	end
	f21_arg0:addRightButtonPrompt(f21_arg0.resetPrompt)
end

CoD.Options.RegisterSocialEventHandlers = function (f22_arg0)
	f22_arg0:registerEventHandler("check_for_youtube_account", CoD.Options.CheckForYouTubeAccount)
	f22_arg0:registerEventHandler("youtube_connect_complete", CoD.Options.YouTubeConnectComplete)
	f22_arg0:registerEventHandler("check_for_twitter_account", CoD.Options.CheckForTwitterAccount)
	f22_arg0:registerEventHandler("twitter_connect_complete", CoD.Options.TwitterConnectComplete)
	f22_arg0:registerEventHandler("check_for_twitch_account", CoD.Options.CheckForTwitchAccount)
	f22_arg0:registerEventHandler("twitch_connect_complete", CoD.Options.TwitchConnectComplete)
end

CoD.Options.AddYouTubeButton = function (f23_arg0, f23_arg1)
	f23_arg0.youtubeAccountButton = f23_arg0.buttonList:addButton(Engine.Localize("MENU_LINK_TO_YOUTUBE_CAPS"), Engine.Localize("MENU_LINK_YOUTUBE_DESC"))
	CoD.Options.UpdateYouTubeButtonText(f23_arg0.youtubeAccountButton, f23_arg1)
	if Engine.IsPlayerUnderage(f23_arg1) then
		f23_arg0.youtubeAccountButton:disable()
		f23_arg0.youtubeAccountButton.hintText = Engine.Localize("MENU_GENERIC_UNDERAGE_MESSAGE")
	else
		f23_arg0.youtubeAccountButton:setActionEventName("youtube_connect")
	end
end

CoD.Options.UpdateYouTubeButtonText = function (f24_arg0, f24_arg1)
	if not Engine.IsYouTubeAccountRegistered(f24_arg1) then
		f24_arg0:setLabel(Engine.Localize("MENU_LINK_TO_YOUTUBE_CAPS"))
	else
		f24_arg0:setLabel(Engine.Localize("MENU_UNLINK_FROM_YOUTUBE_CAPS"))
	end
	if CoD.isZombie and f24_arg0.brackets then
		f24_arg0.brackets:setAlpha(0)
	end
end

CoD.Options.CheckForYouTubeAccount = function (f25_arg0, f25_arg1)
	if not Engine.IsYouTubeAccountChecked(f25_arg1.controller) then
		return 
	else
		CoD.Options.AddYouTubeButton(f25_arg0, f25_arg1.controller)
		f25_arg0.youtubeCheckTimer:close()
		f25_arg0.youtubeCheckTimer = nil
	end
end

CoD.Options.OpenYouTubeConnect = function (f26_arg0, f26_arg1)
	if not Engine.IsYouTubeAccountChecked(controller) or not Engine.IsYouTubeAccountRegistered(controller) then
		f26_arg0:openPopup("YouTube_Connect", f26_arg1.controller)
	else
		f26_arg0:openPopup("YouTube_UnRegister", f26_arg1.controller)
	end
end

CoD.Options.YouTubeConnectComplete = function (f27_arg0, f27_arg1)
	CoD.Options.UpdateYouTubeButtonText(f27_arg0.youtubeAccountButton, f27_arg1.controller)
end

CoD.Options.AddTwitterButton = function (f28_arg0, f28_arg1)
	f28_arg0.twitterAccountButton = f28_arg0.buttonList:addButton(Engine.Localize("MENU_LINK_TO_TWITTER_CAPS"), Engine.Localize("MENU_LINK_TWITTER_DESC"))
	CoD.Options.UpdateTwitterButtonText(f28_arg0.twitterAccountButton, f28_arg1)
	if Engine.IsPlayerUnderage(f28_arg1) then
		f28_arg0.twitterAccountButton:disable()
		f28_arg0.twitterAccountButton.hintText = Engine.Localize("MENU_GENERIC_UNDERAGE_MESSAGE")
	else
		f28_arg0.twitterAccountButton:setActionEventName("twitter_connect")
	end
end

CoD.Options.UpdateTwitterButtonText = function (f29_arg0, f29_arg1)
	if not Engine.IsTwitterAccountRegistered(f29_arg1) then
		f29_arg0.label:setText(Engine.Localize("MENU_LINK_TO_TWITTER_CAPS"))
	else
		f29_arg0.label:setText(Engine.Localize("MENU_UNLINK_FROM_TWITTER_CAPS"))
	end
end

CoD.Options.CheckForTwitterAccount = function (f30_arg0, f30_arg1)
	if not Engine.IsTwitterAccountChecked(f30_arg1.controller) then
		return 
	else
		CoD.Options.AddTwitterButton(f30_arg0, f30_arg1.controller)
		f30_arg0.twitterCheckTimer:close()
		f30_arg0.twitterCheckTimer = nil
	end
end

CoD.Options.OpenTwitterConnect = function (f31_arg0, f31_arg1)
	if not Engine.IsTwitterAccountChecked(f31_arg1.controller) or not Engine.IsTwitterAccountRegistered(f31_arg1.controller) then
		f31_arg0:openPopup("Twitter_Connect", f31_arg1.controller)
	else
		f31_arg0:openPopup("Twitter_UnRegister", f31_arg1.controller)
	end
end

CoD.Options.TwitterConnectComplete = function (f32_arg0, f32_arg1)
	CoD.Options.UpdateTwitterButtonText(f32_arg0.twitterAccountButton, f32_arg1.controller)
end

CoD.Options.AddTwitchButton = function (f33_arg0, f33_arg1)
	f33_arg0.twitchAccountButton = f33_arg0.buttonList:addButton(Engine.Localize("MENU_LINK_TO_TWITCH_CAPS"), Engine.Localize("MENU_LINK_TWITCH_DESC"))
	CoD.Options.UpdateTwitchButtonText(f33_arg0.twitchAccountButton, f33_arg1)
	if Engine.IsPlayerUnderage(f33_arg1) then
		f33_arg0.twitchAccountButton:disable()
		f33_arg0.twitchAccountButton.hintText = Engine.Localize("MENU_GENERIC_UNDERAGE_MESSAGE")
	else
		f33_arg0.twitchAccountButton:setActionEventName("twitch_connect")
	end
end

CoD.Options.UpdateTwitchButtonText = function (f34_arg0, f34_arg1)
	if not Engine.IsTwitchAccountRegistered(f34_arg1) then
		f34_arg0.label:setText(Engine.Localize("MENU_LINK_TO_TWITCH_CAPS"))
	else
		f34_arg0.label:setText(Engine.Localize("MENU_UNLINK_FROM_TWITCH_CAPS"))
	end
end

CoD.Options.CheckForTwitchAccount = function (f35_arg0, f35_arg1)
	if not Engine.IsTwitchAccountChecked(f35_arg1.controller) then
		return 
	else
		CoD.Options.AddTwitchButton(f35_arg0, f35_arg1.controller)
		f35_arg0.twitchCheckTimer:close()
		f35_arg0.twitchCheckTimer = nil
	end
end

CoD.Options.OpenTwitchConnect = function (f36_arg0, f36_arg1)
	if not Engine.IsTwitchAccountRegistered(f36_arg1.controller) then
		f36_arg0:openPopup("Twitch_Connect", f36_arg1.controller)
	else
		f36_arg0:openPopup("Twitch_UnRegister", f36_arg1.controller)
	end
end

CoD.Options.TwitchConnectComplete = function (f37_arg0, f37_arg1)
	CoD.Options.UpdateTwitchButtonText(f37_arg0.twitchAccountButton, f37_arg1.controller)
end

CoD.Options.UpdateWindowPosition = function ()
	Engine.SetHardwareProfileValue("vid_xpos", Dvar.vid_xpos:get())
	Engine.SetHardwareProfileValue("vid_ypos", Dvar.vid_ypos:get())
	Engine.SetHardwareProfileValue("sd_xa2_device_guid", UIExpression.DvarString(nil, "sd_xa2_device_guid"))
end

CoD.Options.BumperControlOverride = function (f39_arg0, f39_arg1)
	if LUI.UIElement.handleGamepadButton(f39_arg0, f39_arg1) == true then
		return true
	end
	local f39_local0 = nil
	if f39_arg1.down == true then
		if f39_arg1.button == "shoulderr" then
			f39_local0 = 1
		elseif f39_arg1.button == "shoulderl" then
			f39_local0 = -1
		end
	end
	if f39_local0 ~= nil and f39_arg0.m_currentItem ~= nil then
		f39_arg0:scrollToItem(f39_arg0.m_currentItem + f39_local0, f39_arg0.m_scrollTime)
	end
end

CoD.Options.SetupTabManager = function (f40_arg0, f40_arg1)
	local f40_local0 = CoD.Menu.TitleHeight + CoD.MFTabManager.TabHeight + 15
	local f40_local1 = CoD.ButtonPrompt.Height
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f40_local0, -f40_local1)
	f40_arg0:addElement(Widget)
	local f40_local3 = CoD.Menu.TitleHeight + 15
	local f40_local4 = CoD.MFTabManager.new(Widget, nil, nil, CoD.BOIIOrange)
	if f40_arg1 then
		f40_local4:setLeftRight(false, false, -f40_arg1 / 2, f40_arg1 / 2)
	else
		f40_local4:setLeftRight(true, true, 0, 0)
	end
	f40_local4:setTopBottom(true, false, f40_local3, f40_local3 + CoD.MFTabManager.TabHeight)
	f40_local4:setTabAlignment(LUI.Alignment.Center)
	f40_local4:setTabSpacing(20)
	f40_arg0.tabManager = f40_local4
	f40_arg0:addElement(f40_local4)
	return f40_local4
end

CoD.Options.CreateButtonList = function ()
	local f41_local0 = CoD.Options.ButtonListWidth
	local f41_local1 = 20
	local f41_local2 = CoD.ButtonList.new()
	if CoD.isSinglePlayer then
		f41_local2:setLeftRight(false, false, -f41_local0 / 2, f41_local0 / 2)
		f41_local2:setTopBottom(true, true, f41_local1, 0)
	else
		f41_local2:setLeftRight(true, false, 0, f41_local0)
		f41_local2:setTopBottom(true, true, f41_local1, 0)
		f41_local2.hintText:setLeftRight(true, false, 0, 800)
	end
	f41_local2.addHardwareProfileLeftRightSelector = CoD.Options.AddHardwareProfileLeftRightSelector
	f41_local2.addHardwareProfileLeftRightSlider = CoD.Options.AddHardwareProfileLeftRightSlider
	f41_local2.addLeftRightSelector = CoD.Options.AddLeftRightSelector
	f41_local2.addVoiceMeter = CoD.Options.AddVoiceMeter
	f41_local2.m_selectors = {}
	return f41_local2
end

CoD.Options.AddOptionCategories = function (f42_arg0)
	if UIExpression.IsInGame() == 0 then
		f42_arg0.systemInfoButton = CoD.ButtonPrompt.new("select", Engine.Localize("MENU_SYSTEM_INFO_CAPS"), f42_arg0, "open_system_info", nil, nil, nil, nil, "S")
		f42_arg0:addRightButtonPrompt(f42_arg0.systemInfoButton)
	end
	local f42_local0, f42_local1 = nil
	local f42_local2 = CoD.ButtonList.new()
	if UIExpression.IsInGame() == 0 then
		local f42_local3 = 50
		local f42_local4 = 30
		local f42_local5 = 300
		local f42_local6 = 2 * (f42_local3 + f42_local4) - f42_local4
		f42_local2:setLeftRight(false, false, -f42_local5 / 2, f42_local5 / 2)
		f42_local2:setTopBottom(false, false, -f42_local6 / 2, f42_local6 / 2 + 100)
		f42_local2:setSpacing(f42_local4)
		f42_local0 = f42_local2:addNavButton(Engine.Localize("MENU_SETTINGS_CAPS"), "open_settings")
		f42_local1 = f42_local2:addNavButton(Engine.Localize("MENU_CONTROLS_CAPS"), "open_controls")
		if not CoD.isSinglePlayer then
			f42_local0.brackets:close()
			f42_local0.m_skipAnimation = true
			f42_local1.brackets:close()
			f42_local1.m_skipAnimation = true
		end
	else
		if CoD.isSinglePlayer then
			f42_local2:setLeftRight(false, false, -CoD.ObjectiveInfoMenu.ElementWidth - CoD.ObjectiveInfoMenu.ElementSpacing / 2, -CoD.ObjectiveInfoMenu.ElementSpacing / 2)
			f42_local2:setTopBottom(true, true, CoD.ObjectiveInfoMenu.Pause_ButtonsTopAnchor, 0)
		else
			f42_local2:setLeftRight(true, false, 0, CoD.ButtonList.DefaultWidth)
			f42_local2:setTopBottom(true, true, CoD.Menu.TitleHeight + 50, 0)
		end
		if not CoD.isMultiplayer then
			f42_local2:setButtonBackingAnimationState({
				leftAnchor = true,
				rightAnchor = true,
				left = -5,
				right = 0,
				topAnchor = true,
				bottomAnchor = true,
				top = 0,
				bottom = 0,
				material = RegisterMaterial("menu_mp_small_row")
			})
		end
		f42_local0 = f42_local2:addButton(Engine.Localize("MENU_SETTINGS_CAPS"))
		f42_local0:setActionEventName("open_settings")
		f42_local1 = f42_local2:addButton(Engine.Localize("MENU_CONTROLS_CAPS"))
		f42_local1:setActionEventName("open_controls")
	end
	f42_arg0:addElement(f42_local2)
	if not f42_arg0:restoreState() then
		f42_local0:processEvent({
			name = "gain_focus"
		})
	end
	if CoD.isSinglePlayer == true and Engine.IsMenuLevel() == true then
		f42_arg0:setPreviousMenu("CampaignMenu")
	end
	Engine.SyncHardwareProfileWithDvars()
end

LUI.createMenu.OptionsMenu = function (f43_arg0)
	local f43_local0 = nil
	if UIExpression.IsInGame() == 1 then
		f43_local0 = CoD.InGameMenu.New("OptionsMenu", f43_arg0, Engine.Localize("MENU_OPTIONS_CAPS"))
		if CoD.isSinglePlayer == true then
			f43_local0:setPreviousMenu("ObjectiveInfoMenu")
		elseif UIExpression.IsDemoPlaying(f43_arg0) ~= 0 then
			f43_local0:setPreviousMenu("Demo_InGame")
		else
			f43_local0:setPreviousMenu("class")
		end
	else
		f43_local0 = CoD.Menu.New("OptionsMenu")
		f43_local0.anyControllerAllowed = true
		f43_local0:addTitle(Engine.Localize("MENU_OPTIONS_CAPS"), LUI.Alignment.Center)
		if CoD.isSinglePlayer == false then
			f43_local0:addLargePopupBackground()
		end
	end
	if CoD.isSinglePlayer == true then
		Engine.SendMenuResponse(f43_arg0, "luisystem", "modal_start")
	end
	f43_local0:registerEventHandler("button_prompt_back", CoD.Options.Back)
	f43_local0:registerEventHandler("apply_changes", CoD.Options.ApplyChanges)
	f43_local0:registerEventHandler("open_controls", CoD.Options.OpenControls)
	f43_local0:registerEventHandler("open_settings", CoD.Options.OpenSettings)
	f43_local0:registerEventHandler("open_system_info", CoD.Options.OpenSystemInfo)
	f43_local0:registerEventHandler("is_common_loaded", CoD.Options.IsCommonLoaded)
	f43_local0:addSelectButton()
	f43_local0:addBackButton()
	CoD.Options.AddOptionCategories(f43_local0)
	return f43_local0
end

