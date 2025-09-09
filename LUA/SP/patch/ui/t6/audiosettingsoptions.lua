require("T6.Options")
CoD.AudioSettings = {}
CoD.AudioSettings.AdjustSFX = "uin_loadout_nav"
CoD.AudioSettings.CycleSFX = "cac_grid_nav"
CoD.AudioSettings.TREYARCH_MIX = 0
CoD.AudioSettings.BASS_BOOST = 1
CoD.AudioSettings.HIGH_BOOST = 2
CoD.AudioSettings.SUPERCRUNCH = 3
CoD.AudioSettings.HEADPHONES = 4
CoD.AudioSettings.SupportsHearingImpairment = function ()
	local f1_local0 = Dvar.loc_language:get()
	if CoD.isSinglePlayer == true then
		return true
	else
		return false
	end
end

CoD.AudioSettings.Button_SystemTestButton = function (f2_arg0, f2_arg1)
	Engine.PlaySound("tst_test_system")
end

LUI.createMenu.AudioSettings = function (f3_arg0, f3_arg1)
	local f3_local0 = nil
	if UIExpression.IsInGame() == 1 then
		f3_local0 = CoD.InGameMenu.New("AudioSettings", f3_arg0, Engine.Localize("MENU_AUDIO_SETTINGS_CAPS"), CoD.isSinglePlayer)
		if CoD.isSinglePlayer == false and UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
			f3_local0:sizeToSafeArea(f3_arg0)
			f3_local0:updateTitleForSplitscreen()
			f3_local0:updateButtonPromptBarsForSplitscreen()
		end
	else
		f3_local0 = CoD.Menu.New("AudioSettings")
		f3_local0:setOwner(f3_arg0)
		f3_local0:addTitle(Engine.Localize("MENU_AUDIO_SETTINGS_CAPS"))
		if CoD.isSinglePlayer == false then
			f3_local0:addLargePopupBackground()
			f3_local0:registerEventHandler("signed_out", CoD.Options.SignedOut_MPZM)
		end
	end
	f3_local0:setPreviousMenu("OptionsMenu")
	f3_local0.controller = f3_arg0
	f3_local0:setOwner(f3_arg0)
	f3_local0:registerEventHandler("open_speaker_setup", CoD.AudioSettings.OpenSpeakerSetup)
	if CoD.isSinglePlayer == true and CoD.perController[f3_arg0].firstTime then
		f3_local0.acceptButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_ACCEPT"), f3_local0, "accept_button")
		f3_local0:addLeftButtonPrompt(f3_local0.acceptButton)
		f3_local0:registerEventHandler("accept_button", CoD.AudioSettings.CloseFirstTime)
		f3_local0:registerEventHandler("remove_accept_button", CoD.AudioSettings.RemoveAcceptButton)
		f3_local0:registerEventHandler("readd_accept_button", CoD.AudioSettings.ReaddAcceptButton)
		CoD.AudioSettings.ListHeight = 511.25
	else
		f3_local0:addSelectButton()
		f3_local0:addBackButton()
	end
	f3_local0.close = CoD.Options.Close
	local f3_local1 = 0
	if UIExpression.IsInGame() == 1 and CoD.isSinglePlayer == false and Engine.IsSplitscreen() == true then
		f3_local1 = CoD.Menu.SplitscreenSideOffset
	end
	local f3_local2 = CoD.ButtonList.new()
	f3_local2:setLeftRight(true, false, f3_local1, f3_local1 + CoD.ButtonList.DefaultWidth - 20)
	f3_local2:setTopBottom(true, false, CoD.Menu.TitleHeight, CoD.Menu.TitleHeight + 720)
	if CoD.isSinglePlayer then
		f3_local0:addElement(f3_local2)
		if f3_arg1 and f3_arg1.height ~= nil then
			f3_local2:setLeftRight(false, false, -CoD.Options.Width / 2, CoD.Options.Width / 2)
			f3_local2:setTopBottom(false, false, -f3_arg1.height / 2, f3_arg1.height / 2)
			CoD.AudioSettings.ListHeight = f3_arg1.height
		elseif CoD.AudioSettings.ListHeight then
			f3_local2:setLeftRight(false, false, -CoD.Options.Width / 2, CoD.Options.Width / 2)
			f3_local2:setTopBottom(false, false, -CoD.AudioSettings.ListHeight / 2, CoD.AudioSettings.ListHeight / 2)
		end
	else
		local f3_local3 = CoD.SplitscreenScaler.new(nil, 1.5)
		f3_local3:setLeftRight(true, false, 0, 0)
		f3_local3:setTopBottom(true, false, 0, 0)
		f3_local0:addElement(f3_local3)
		f3_local3:addElement(f3_local2)
	end
	local f3_local3 = f3_local2:addProfileLeftRightSlider(f3_arg0, Engine.Localize("MENU_VOICE_VOLUME_CAPS"), "snd_menu_voice", 0, 1, Engine.Localize("MENU_VOICE_VOLUME_DESC"), nil, nil, CoD.SafeArea.AdjustSFX)
	local f3_local4 = f3_local2:addProfileLeftRightSlider(f3_arg0, Engine.Localize("MENU_MUSIC_VOLUME_CAPS"), "snd_menu_music", 0, 1, Engine.Localize("MENU_MUSIC_VOLUME_DESC"), nil, nil, CoD.SafeArea.AdjustSFX)
	local f3_local5 = f3_local2:addProfileLeftRightSlider(f3_arg0, Engine.Localize("MENU_SFX_VOLUME_CAPS"), "snd_menu_sfx", 0, 1, Engine.Localize("MENU_SFX_VOLUME_DESC"), nil, nil, CoD.SafeArea.AdjustSFX)
	local f3_local6 = f3_local2:addProfileLeftRightSlider(f3_arg0, Engine.Localize("MENU_MASTER_VOLUME_CAPS"), "snd_menu_master", 0, 1, Engine.Localize("MENU_MASTER_VOLUME_DESC"), nil, nil, CoD.SafeArea.AdjustSFX)
	if CoD.isSinglePlayer == true then
		local f3_local7 = f3_local2:addProfileLeftRightSlider(f3_arg0, Engine.Localize("MENU_CINEMATICS_VOLUME_CAPS"), "snd_menu_cinematic", 0, 1, Engine.Localize("MENU_CINEMATICS_VOLUME_DESC"), nil, nil, CoD.SafeArea.AdjustSFX)
	end
	if CoD.isSinglePlayer == false and CoD.isZombie == false then
		local f3_local7 = f3_local2:addProfileLeftRightSlider(f3_arg0, Engine.Localize("MENU_SHOUTCAST_GAME_VOLUME_CAPS"), "snd_shoutcast_game", 0, 2, Engine.Localize("MENU_SHOUTCAST_GAME_VOLUME_DESC"), nil, nil, CoD.SafeArea.AdjustSFX)
		local f3_local8 = f3_local2:addProfileLeftRightSlider(f3_arg0, Engine.Localize("MENU_SHOUTCAST_VOIP_VOLUME_CAPS"), "snd_shoutcast_voip", 0, 2, Engine.Localize("MENU_SHOUTCAST_VOIP_VOLUME_DESC"), nil, nil, CoD.SafeArea.AdjustSFX)
	end
	if CoD.AudioSettings.SupportsHearingImpairment() then
		CoD.Options.Button_AddChoices_OnOrOff(f3_local2:addProfileLeftRightSelector(f3_arg0, Engine.Localize("MENU_HEARING_IMPAIRED_CAPS"), "snd_menu_hearing_impaired", Engine.Localize("MENU_HEARING_IMPAIRED_DESC"), nil, nil, CoD.AudioSettings.CycleSFX))
	end
	f3_local2:addSpacer(CoD.CoD9Button.Height / 2)
	CoD.AudioSettings.Button_AudioPresets_AddChoices(f3_local2:addProfileLeftRightSelector(f3_arg0, Engine.Localize("MENU_AUDIO_PRESETS_CAPS"), "snd_menu_presets", "", nil, nil, CoD.AudioSettings.CycleSFX))
	if UIExpression.IsInGame() == 0 and not (UIExpression.IsDemoPlaying(f3_arg0) ~= 0) then
		local f3_local9 = f3_local2:addButton(Engine.Localize("MENU_SYSTEM_TEST_CAPS"), Engine.Localize("MENU_SYSTEM_TEST_DESC"))
		f3_local9:registerEventHandler("button_action", CoD.AudioSettings.Button_SystemTestButton)
		if CoD.isSinglePlayer == true and CoD.perController[f3_arg0].firstTime then
			f3_local9:registerEventHandler("gain_focus", CoD.AudioSettings.SystemTextGainFocus)
			f3_local9:registerEventHandler("lose_focus", CoD.AudioSettings.SystemTextLoseFocus)
		end
	end
	if CoD.useController and not f3_local0:restoreState() then
		f3_local3:processEvent({
			name = "gain_focus"
		})
	end
	f3_local0.buttonList = f3_local2
	return f3_local0
end

CoD.AudioSettings.RemoveAcceptButton = function (f4_arg0, f4_arg1)
	f4_arg0.acceptButton:close()
	f4_arg0.acceptButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_SELECT"), f4_arg0)
	f4_arg0:addLeftButtonPrompt(f4_arg0.acceptButton)
end

CoD.AudioSettings.ReaddAcceptButton = function (f5_arg0, f5_arg1)
	f5_arg0.acceptButton:close()
	f5_arg0.acceptButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_ACCEPT"), f5_arg0, "accept_button")
	f5_arg0:addLeftButtonPrompt(f5_arg0.acceptButton)
end

CoD.AudioSettings.SystemTextGainFocus = function (f6_arg0, f6_arg1)
	LUI.UIButton.gainFocus(f6_arg0, f6_arg1)
	f6_arg0:dispatchEventToParent({
		name = "remove_accept_button"
	})
end

CoD.AudioSettings.SystemTextLoseFocus = function (f7_arg0, f7_arg1)
	LUI.UIButton.loseFocus(f7_arg0, f7_arg1)
	f7_arg0:dispatchEventToParent({
		name = "readd_accept_button"
	})
end

CoD.AudioSettings.CloseFirstTime = function (f8_arg0, f8_arg1)
	if CoD.isPC then
		if not CoD.Options.SupportsMatureContent() then
			Engine.ExecNow(f8_arg1.controller, "setprofile com_first_time 0")
			Engine.ExecNow(f8_arg1.controller, "updategamerprofile")
			f8_arg0:dispatchEventToParent({
				name = "open_main_menu",
				controller = f8_arg1.controller
			})
			CoD.perController[f8_arg1.controller].firstTime = nil
		else
			f8_arg0:openMenu("MatureContentPopup", f8_arg1.controller)
		end
		f8_arg0:close()
	else
		f8_arg0:openMenu("SafeArea", f8_arg1.controller)
		f8_arg0:close()
	end
end

CoD.AudioSettings.Button_AudioPresets_SelectionChanged = function (f9_arg0)
	Engine.SetProfileVar(f9_arg0.parentSelectorButton.m_currentController, f9_arg0.parentSelectorButton.m_profileVarName, f9_arg0.value)
	f9_arg0.parentSelectorButton.hintText = f9_arg0.extraParams.associatedHintText
	local f9_local0 = f9_arg0.parentSelectorButton:getParent()
	if f9_local0 ~= nil and f9_local0.hintText ~= nil then
		f9_local0.hintText:updateText(f9_arg0.parentSelectorButton.hintText)
	end
end

CoD.AudioSettings.Button_AudioPresets_AddChoices = function (f10_arg0)
	f10_arg0:addChoice(Engine.Localize("MENU_TREYARCH_MIX_CAPS"), CoD.AudioSettings.TREYARCH_MIX, {
		associatedHintText = Engine.Localize("MENU_TREYARCH_MIX_DESC")
	}, CoD.Options.Button_EnumProfile_SelectionChanged)
	f10_arg0:addChoice(Engine.Localize("MENU_BASS_BOOST_CAPS"), CoD.AudioSettings.BASS_BOOST, {
		associatedHintText = Engine.Localize("MENU_BASS_BOOST_DESC")
	}, CoD.Options.Button_EnumProfile_SelectionChanged)
	f10_arg0:addChoice(Engine.Localize("MENU_HIGH_BOOST_CAPS"), CoD.AudioSettings.HIGH_BOOST, {
		associatedHintText = Engine.Localize("MENU_HIGH_BOOST_DESC")
	}, CoD.Options.Button_EnumProfile_SelectionChanged)
	f10_arg0:addChoice(Engine.Localize("MENU_SUPERCRUNCH_CAPS"), CoD.AudioSettings.SUPERCRUNCH, {
		associatedHintText = Engine.Localize("MENU_SUPERCRUNCH_DESC")
	}, CoD.Options.Button_EnumProfile_SelectionChanged)
	f10_arg0:addChoice(Engine.Localize("MENU_HEADPHONES_CAPS"), CoD.AudioSettings.HEADPHONES, {
		associatedHintText = Engine.Localize("MENU_HEADPHONES_DESC")
	}, CoD.Options.Button_EnumProfile_SelectionChanged)
end

