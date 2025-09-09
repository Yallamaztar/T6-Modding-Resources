CoD.OptionsSettings = {}
CoD.OptionsSettings.CurrentTabIndex = 1
CoD.OptionsSettings.NeedVidRestart = false
CoD.OptionsSettings.NeedPicmip = false
CoD.OptionsSettings.NeedSndRestart = false
CoD.OptionsSettings.ResetRestartFlags = function ()
	CoD.OptionsSettings.NeedVidRestart = false
	CoD.OptionsSettings.NeedPicmip = false
	CoD.OptionsSettings.NeedSndRestart = false
end

CoD.OptionsSettings.LeaveApplyPopup_DeclineApply = function (f2_arg0, f2_arg1)
	f2_arg0:setPreviousMenu("OptionsMenu")
	CoD.OptionsSettings.ResetRestartFlags()
	f2_arg0:goBack(f2_arg1.controller)
end

CoD.OptionsSettings.ApplyPopup_DeclineApply = function (f3_arg0, f3_arg1)
	CoD.OptionsSettings.ResetRestartFlags()
	f3_arg0:goBack(f3_arg1.controller)
end

CoD.OptionsSettings.ApplyPopup_ApplyChanges = function (f4_arg0, f4_arg1)
	CoD.OptionsSettings.ApplyChanges()
	f4_arg0:goBack(f4_arg1.controller)
end

CoD.OptionsSettings.Back = function (f5_arg0, f5_arg1)
	if CoD.OptionsSettings.NeedVidRestart or CoD.OptionsSettings.NeedPicmip or CoD.OptionsSettings.NeedSndRestart then
		local f5_local0 = f5_arg0:openMenu("LeaveApplyConfirmPopup", f5_arg1.controller)
		f5_local0:registerEventHandler("confirm_action", CoD.OptionsSettings.ApplyPopup_ApplyChanges)
		f5_local0:registerEventHandler("decline_action", CoD.OptionsSettings.LeaveApplyPopup_DeclineApply)
		f5_arg0:close()
	else
		CoD.Options.UpdateWindowPosition()
		Engine.Exec(f5_arg1.controller, "updategamerprofile")
		Engine.SaveHardwareProfile()
		Engine.ApplyHardwareProfileSettings()
		if CoD.isSinglePlayer == true then
			Engine.SendMenuResponse(f5_arg1.controller, "luisystem", "modal_stop")
		end
		f5_arg0:goBack(f5_arg1.controller)
	end
end

CoD.OptionsSettings.TabChanged = function (f6_arg0, f6_arg1)
	f6_arg0.buttonList = f6_arg0.tabManager.buttonList
	local f6_local0 = f6_arg0.buttonList:getFirstChild()
	while not f6_local0.m_focusable do
		f6_local0 = f6_local0:getNextSibling()
	end
	if f6_local0 ~= nil then
		f6_local0:processEvent({
			name = "gain_focus"
		})
	end
	CoD.OptionsSettings.CurrentTabIndex = f6_arg1.tabIndex
end

CoD.OptionsSettings.SelectorChanged = function (f7_arg0, f7_arg1)
	if f7_arg1.userRequested ~= true then
		return 
	end
	local f7_local0 = f7_arg0.buttonList.m_selectors
	local f7_local1 = f7_arg1.selector
	local f7_local2 = f7_local1.m_profileVarName
	if f7_local2 == "r_fullscreen" and f7_local0.r_monitor ~= nil and f7_local0.r_mode ~= nil then
		local f7_local3 = f7_local1:getCurrentValue()
		local f7_local4 = f7_local0.r_monitor
		local f7_local5 = f7_local0.r_mode
		if f7_local3 == "0" then
			f7_local4:setChoice(0)
			f7_local4:disableSelector()
			f7_local5:enableSelector()
		elseif f7_local3 == "2" then
			f7_local4:enableSelector()
			f7_local5:disableSelector()
		else
			f7_local4:enableSelector()
			f7_local5:enableSelector()
		end
	end
	if f7_local2 == "r_vsync" and f7_local0.com_maxfps ~= nil then
		local f7_local3 = f7_local0.com_maxfps
		if f7_local1:getCurrentValue() == "1" then
			f7_local3:setChoice(0)
			f7_local3:disableSelector()
		else
			f7_local3:enableSelector()
		end
	end
	if f7_local2 == "r_monitor" and f7_local0.r_mode ~= nil then
		CoD.OptionsSettings.Button_AddChoices_Resolution(f7_local0.r_mode)
	end
	if f7_local2 == "r_fullscreen" or f7_local2 == "r_mode" or f7_local2 == "r_aaSamples" or f7_local2 == "r_monitor" or f7_local2 == "r_texFilterQuality" then
		CoD.OptionsSettings.NeedVidRestart = true
		f7_arg0:addApplyPrompt()
	end
	if f7_local2 == "r_picmip" then
		CoD.OptionsSettings.NeedPicmip = true
		f7_arg0:addApplyPrompt()
	end
	if f7_local2 == "sd_xa2_device_name" then
		CoD.OptionsSettings.NeedSndRestart = true
		f7_arg0:addApplyPrompt()
	end
end

CoD.OptionsSettings.ResolutionChanged = function (f8_arg0, f8_arg1)
	CoD.OptionsSettings.RefreshMenu(f8_arg0)
	CoD.Menu.ResolutionChanged(f8_arg0, f8_arg1)
end

CoD.OptionsSettings.OpenBrightness = function (f9_arg0, f9_arg1)
	f9_arg0:saveState()
	f9_arg0:openMenu("Brightness", f9_arg1.controller)
	f9_arg0:close()
	CoD.OptionsSettings.DoNotSyncProfile = true
end

CoD.OptionsSettings.OpenMatureContent = function (f10_arg0, f10_arg1)
	f10_arg0:saveState()
	f10_arg0:openMenu("MatureContentPopup", f10_arg1.controller)
	f10_arg0:close()
	CoD.OptionsSettings.DoNotSyncProfile = true
end

CoD.OptionsSettings.OpenApplyPopup = function (f11_arg0, f11_arg1)
	local f11_local0 = f11_arg0:openMenu("ApplyChangesPopup", f11_arg1.controller)
	f11_local0:registerEventHandler("confirm_action", CoD.OptionsSettings.ApplyPopup_ApplyChanges)
	f11_local0:registerEventHandler("decline_action", CoD.OptionsSettings.ApplyPopup_DeclineApply)
	f11_arg0:close()
end

CoD.OptionsSettings.OpenDefaultPopup = function (f12_arg0, f12_arg1)
	local f12_local0 = f12_arg0:openMenu("SetDefaultPopup", f12_arg1.controller)
	f12_local0:registerEventHandler("confirm_action", CoD.OptionsSettings.DefaultPopup_RestoreDefaultSettings)
	f12_local0:registerEventHandler("decline_action", CoD.OptionsSettings.DefaultPopup_Decline)
	f12_arg0:close()
end

CoD.OptionsSettings.ApplyChanges = function ()
	CoD.Options.UpdateWindowPosition()
	Engine.SaveHardwareProfile()
	Engine.ApplyHardwareProfileSettings()
	if CoD.OptionsSettings.NeedPicmip then
		Engine.Exec(nil, "r_applyPicmip")
	end
	if CoD.OptionsSettings.NeedVidRestart then
		Engine.Exec(nil, "vid_restart")
	end
	if CoD.OptionsSettings.NeedSndRestart then
		Engine.Exec(nil, "snd_restart")
	end
	CoD.OptionsSettings.ResetRestartFlags()
end

CoD.OptionsSettings.ResetSoundToDefault = function (f14_arg0)
	Engine.SetProfileVar(f14_arg0, "snd_menu_voice", 1)
	Engine.SetProfileVar(f14_arg0, "snd_menu_music", 1)
	Engine.SetProfileVar(f14_arg0, "snd_menu_sfx", 1)
	Engine.SetProfileVar(f14_arg0, "snd_menu_master", 1)
	if CoD.isSinglePlayer == true then
		Engine.SetProfileVar(f14_arg0, "snd_menu_cinematic", 1)
	else
		Engine.SetProfileVar(f14_arg0, "snd_shoutcast_game", 0.25)
		Engine.SetProfileVar(f14_arg0, "snd_shoutcast_voip", 1)
		Engine.SetProfileVar(f14_arg0, "snd_voicechat_record_level", 1)
		Engine.SetProfileVar(f14_arg0, "snd_voicechat_volume", 1)
	end
	Engine.SetProfileVar(f14_arg0, "snd_menu_headphones", 0)
	Engine.SetProfileVar(f14_arg0, "snd_menu_hearing_impaired", 0)
	Engine.SetProfileVar(f14_arg0, "snd_menu_presets", CoD.AudioSettings.TREYARCH_MIX)
end

CoD.OptionsSettings.ResetGameToDefault = function (f15_arg0)
	if CoD.isSinglePlayer then
		local f15_local0 = Dvar.loc_language:get()
		if f15_local0 == CoD.LANGUAGE_POLISH or f15_local0 == CoD.LANGUAGE_JAPANESE then
			Engine.SetProfileVar(f15_arg0, "cg_subtitles", 1)
		else
			Engine.SetProfileVar(f15_arg0, "cg_subtitles", 0)
		end
		Engine.SetProfileVar(f15_arg0, "cg_blood", 1)
		Engine.SetProfileVar(f15_arg0, "cg_mature", 1)
	else
		Engine.SetProfileVar(f15_arg0, "team_indicator", 0)
		Engine.SetProfileVar(f15_arg0, "colorblind_assist", 0)
		Engine.SetHardwareProfileValue("cg_drawLagometer", 0)
	end
	Engine.SetProfileVar(f15_arg0, "safeAreaTweakable_vertical", 1)
	Engine.SetProfileVar(f15_arg0, "safeAreaTweakable_horizontal", 1)
	Engine.SetProfileVar(f15_arg0, "r_gamma", 0.9)
end

CoD.OptionsSettings.ResetDvars = function (f16_arg0)
	Engine.Exec(f16_arg0, "reset r_fullscreen")
	Engine.Exec(f16_arg0, "reset r_vsync")
	Engine.Exec(f16_arg0, "reset r_picmip_manual")
	Engine.Exec(f16_arg0, "reset r_dofHDR")
	Engine.Exec(f16_arg0, "reset cg_chatHeight")
	Engine.Exec(f16_arg0, "reset cg_fov_default")
	Engine.Exec(f16_arg0, "reset cl_voice")
	Engine.Exec(f16_arg0, "reset com_maxfps")
	Engine.Exec(f16_arg0, "reset cg_drawFPS")
	Engine.SetDvar("sd_xa2_device_name", 0)
	Engine.SetDvar("sd_xa2_device_guid", 0)
end

CoD.OptionsSettings.DefaultPopup_RestoreDefaultSettings = function (f17_arg0, f17_arg1)
	CoD.OptionsSettings.ResetDvars(f17_arg1.controller)
	Engine.ResetHardwareProfileSettings(f17_arg1.controller)
	Engine.Exec(f17_arg1.controller, "r_applyPicmip")
	Engine.Exec(f17_arg1.controller, "vid_restart")
	Engine.Exec(f17_arg1.controller, "snd_restart")
	CoD.OptionsSettings.ResetSoundToDefault(f17_arg1.controller)
	CoD.OptionsSettings.ResetGameToDefault(f17_arg1.controller)
	Engine.SaveHardwareProfile()
	f17_arg0:goBack(f17_arg1.controller)
end

CoD.OptionsSettings.DefaultPopup_Decline = function (f18_arg0, f18_arg1)
	CoD.OptionsSettings.DoNotSyncProfile = true
	f18_arg0:goBack(f18_arg1.controller)
end

CoD.OptionsSettings.RefreshMenu = function (f19_arg0)
	Engine.SyncHardwareProfileWithDvars()
	f19_arg0:dispatchEventToChildren({
		name = "refresh_choice"
	})
	local f19_local0 = f19_arg0.buttonList.m_selectors
	local f19_local1 = f19_local0.r_picmip
	if Engine.GetHardwareProfileValueAsString("r_picmip_manual") == "0" and f19_local1 ~= nil then
		f19_local1:setChoice(-1)
	end
	local f19_local2 = f19_local0.sm_spotQuality
	if Engine.GetHardwareProfileValueAsString("sm_enable") == "0" and f19_local2 ~= nil then
		f19_local2:setChoice(-1)
	end
	local f19_local3 = f19_local0.r_aaSamples
	if f19_local3 ~= nil then
		CoD.OptionsSettings.AdjustAntiAliasingSettings(f19_local3)
	end
	local f19_local4 = f19_local0.r_mode
	if f19_local4 then
		CoD.OptionsSettings.Button_AddChoices_Resolution(f19_local4)
	end
	local f19_local5 = Engine.GetHardwareProfileValueAsString("r_fullscreen")
	local f19_local6 = f19_local0.r_monitor
	local f19_local7 = f19_local0.r_mode
	if f19_local6 and f19_local7 then
		if f19_local5 == "0" then
			f19_local6:setChoice(0)
			f19_local6:disableSelector()
			f19_local7:enableSelector()
		elseif f19_local5 == "2" then
			f19_local6:enableSelector()
			f19_local7:disableSelector()
		else
			f19_local6:enableSelector()
			f19_local7:enableSelector()
		end
	end
end

CoD.OptionsSettings.DisableOptionsInGame = function (f20_arg0)
	for f20_local3, f20_local4 in ipairs({
		"r_mode",
		"r_fullscreen",
		"r_monitor",
		"r_aaSamples",
		"r_texFilterQuality",
		"r_picmip"
	}) do
		if f20_arg0[f20_local4] then
			f20_arg0[f20_local4]:disableSelector()
		end
	end
end

CoD.OptionsSettings.Button_AddChoices_Resolution = function (f21_arg0)
	local f21_local0 = nil
	f21_arg0:clearChoices()
	if Dvar.r_fullscreen:get() == 0 then
		for f21_local4, f21_local5 in ipairs(Dvar.r_mode:getDomainEnumStrings()) do
			f21_arg0:addChoice(f21_local5, f21_local5)
		end
	else
		local f21_local1 = Engine.GetHardwareProfileValueAsString("r_monitor")
		if tonumber(f21_local1) > Dvar.r_monitorCount:get() then
			f21_local1 = "0"
		end
		if f21_local1 == "0" then
			f21_local0 = Dvar.r_mode:getDomainEnumStrings()
		else
			f21_local0 = Dvar["r_mode" .. f21_local1].getDomainEnumStrings(f21_local2["r_mode" .. f21_local1])
		end
		for f21_local5, f21_local6 in ipairs(f21_local0) do
			f21_arg0:addChoice(f21_local6, f21_local6)
		end
	end
end

CoD.OptionsSettings.Button_AddChoices_DisplayMode = function (f22_arg0)
	f22_arg0:addChoice(Engine.Localize("PLATFORM_WINDOWED"), 0)
	f22_arg0:addChoice(Engine.Localize("MENU_FULLSCREEN"), 1)
	f22_arg0:addChoice(Engine.Localize("PLATFORM_WINDOWED_FULLSCREEN"), 2)
end

CoD.OptionsSettings.AdjustAntiAliasingSettings = function (f23_arg0)
	local f23_local0 = Engine.GetHardwareProfileValueAsString("r_aaSamples")
	if Dvar.r_txaaSupported:get() == true and Engine.GetHardwareProfileValueAsString("r_txaa") == "1" then
		if f23_local0 == "2" then
			f23_arg0:setChoice(17)
		elseif f23_local0 == "4" then
			f23_arg0:setChoice(18)
		end
	else
		Engine.SetHardwareProfile("r_txaa", 0)
	end
end

CoD.OptionsSettings.AntiAliasingChangeCallback = function (f24_arg0, f24_arg1)
	if f24_arg1 ~= true then
		return 
	elseif f24_arg0.value <= 16 then
		Engine.SetHardwareProfileValue("r_aaSamples", f24_arg0.value)
		Engine.SetHardwareProfileValue("r_txaa", 0)
	elseif f24_arg0.value == 17 then
		Engine.SetHardwareProfileValue("r_aaSamples", 2)
		Engine.SetHardwareProfileValue("r_txaa", 1)
		Engine.SetHardwareProfileValue("r_fxaa", 0)
	elseif f24_arg0.value == 18 then
		Engine.SetHardwareProfileValue("r_aaSamples", 4)
		Engine.SetHardwareProfileValue("r_txaa", 1)
		Engine.SetHardwareProfileValue("r_fxaa", 0)
	else
		Engine.SetHardwareProfileValue("r_aaSamples", 1)
		Engine.SetHardwareProfileValue("r_txaa", 0)
		Engine.SetHardwareProfileValue("r_fxaa", 0)
	end
end

CoD.OptionsSettings.Button_AddChoices_AntiAliasing = function (f25_arg0)
	f25_arg0:addChoice(Engine.Localize("MENU_OFF_CAPS"), 1, nil, CoD.OptionsSettings.AntiAliasingChangeCallback)
	f25_arg0:addChoice(Engine.Localize("PLATFORM_2X_MSAA_CAPS"), 2, nil, CoD.OptionsSettings.AntiAliasingChangeCallback)
	f25_arg0:addChoice(Engine.Localize("PLATFORM_4X_MSAA_CAPS"), 4, nil, CoD.OptionsSettings.AntiAliasingChangeCallback)
	f25_arg0:addChoice(Engine.Localize("PLATFORM_8X_MSAA_CAPS"), 8, nil, CoD.OptionsSettings.AntiAliasingChangeCallback)
	if Dvar.r_aaSamplesMax:get() == 16 then
		f25_arg0:addChoice(Engine.Localize("PLATFORM_16X_CSAA_CAPS"), 16, nil, CoD.OptionsSettings.AntiAliasingChangeCallback)
	end
	if Dvar.r_txaaSupported:get() == true then
		f25_arg0:addChoice(Engine.Localize("PLATFORM_2X_TXAA_CAPS"), 17, nil, CoD.OptionsSettings.AntiAliasingChangeCallback)
		f25_arg0:addChoice(Engine.Localize("PLATFORM_4X_TXAA_CAPS"), 18, nil, CoD.OptionsSettings.AntiAliasingChangeCallback)
	end
end

CoD.OptionsSettings.Button_AddChoices_TextureFiltering = function (f26_arg0)
	f26_arg0:addChoice(Engine.Localize("PLATFORM_LOW_CAPS"), 0)
	f26_arg0:addChoice(Engine.Localize("PLATFORM_MEDIUM_CAPS"), 1)
	f26_arg0:addChoice(Engine.Localize("PLATFORM_HIGH_CAPS"), 2)
end

CoD.OptionsSettings.TextureQualitySelectionChangeCallback = function (f27_arg0, f27_arg1)
	if f27_arg1 ~= true then
		return 
	elseif f27_arg0.value == -1 then
		Engine.SetHardwareProfileValue("r_picmip_manual", 0)
	else
		Engine.SetHardwareProfileValue("r_picmip_manual", 1)
		Engine.SetHardwareProfileValue("r_picmip", f27_arg0.value)
		Engine.SetHardwareProfileValue("r_picmip_bump", f27_arg0.value)
		Engine.SetHardwareProfileValue("r_picmip_spec", f27_arg0.value)
	end
end

CoD.OptionsSettings.Button_AddChoices_TextureQuality = function (f28_arg0)
	f28_arg0:addChoice(Engine.Localize("MENU_AUTOMATIC_CAPS"), -1, nil, CoD.OptionsSettings.TextureQualitySelectionChangeCallback)
	f28_arg0:addChoice(Engine.Localize("PLATFORM_LOW_CAPS"), 3, nil, CoD.OptionsSettings.TextureQualitySelectionChangeCallback)
	f28_arg0:addChoice(Engine.Localize("MENU_NORMAL_CAPS"), 2, nil, CoD.OptionsSettings.TextureQualitySelectionChangeCallback)
	f28_arg0:addChoice(Engine.Localize("PLATFORM_HIGH_CAPS"), 1, nil, CoD.OptionsSettings.TextureQualitySelectionChangeCallback)
	f28_arg0:addChoice(Engine.Localize("MENU_EXTRA_CAPS"), 0, nil, CoD.OptionsSettings.TextureQualitySelectionChangeCallback)
end

CoD.OptionsSettings.ShadowsChangeCallback = function (f29_arg0, f29_arg1)
	if f29_arg1 ~= true then
		return 
	elseif f29_arg0.value == -1 then
		Engine.SetHardwareProfileValue("sm_enable", 0)
		Engine.SetHardwareProfileValue("sm_spotQuality", 0)
		Engine.SetHardwareProfileValue("sm_sunQuality", 0)
	else
		Engine.SetHardwareProfileValue("sm_enable", 1)
		Engine.SetHardwareProfileValue("sm_spotQuality", f29_arg0.value)
		Engine.SetHardwareProfileValue("sm_sunQuality", f29_arg0.value)
	end
end

CoD.OptionsSettings.Button_AddChoices_Shadows = function (f30_arg0)
	f30_arg0:addChoice(Engine.Localize("MENU_OFF_CAPS"), -1, nil, CoD.OptionsSettings.ShadowsChangeCallback)
	f30_arg0:addChoice(Engine.Localize("PLATFORM_LOW_CAPS"), 0, nil, CoD.OptionsSettings.ShadowsChangeCallback)
	f30_arg0:addChoice(Engine.Localize("PLATFORM_MEDIUM_CAPS"), 1, nil, CoD.OptionsSettings.ShadowsChangeCallback)
	f30_arg0:addChoice(Engine.Localize("PLATFORM_HIGH_CAPS"), 2, nil, CoD.OptionsSettings.ShadowsChangeCallback)
end

CoD.OptionsSettings.Button_PlayerNameIndicator_SelectionChanged = function (f31_arg0)
	Engine.SetProfileVar(f31_arg0.parentSelectorButton.m_currentController, f31_arg0.parentSelectorButton.m_profileVarName, f31_arg0.value)
	f31_arg0.parentSelectorButton.hintText = f31_arg0.extraParams.associatedHintText
	local f31_local0 = f31_arg0.parentSelectorButton:getParent()
	if f31_local0 ~= nil and f31_local0.hintText ~= nil then
		f31_local0.hintText:updateText(f31_arg0.parentSelectorButton.hintText)
	end
end

CoD.OptionsSettings.Button_AddChoices_PlayerNameIndicator = function (f32_arg0)
	f32_arg0:addChoice(Engine.Localize("PLATFORM_INDICATOR_FULL_CAPS"), 0, {
		associatedHintText = Engine.Localize("PLATFORM_INDICATOR_FULL_DESC")
	}, CoD.OptionsSettings.Button_PlayerNameIndicator_SelectionChanged)
	f32_arg0:addChoice(Engine.Localize("MENU_INDICATOR_ABBREVIATED_CAPS"), 1, {
		associatedHintText = Engine.Localize("PLATFORM_INDICATOR_ABBREVIATED_DESC")
	}, CoD.OptionsSettings.Button_PlayerNameIndicator_SelectionChanged)
	f32_arg0:addChoice(Engine.Localize("MENU_INDICATOR_ICON_CAPS"), 2, {
		associatedHintText = Engine.Localize("MENU_INDICATOR_ICON_DESC")
	}, CoD.OptionsSettings.Button_PlayerNameIndicator_SelectionChanged)
end

CoD.OptionsSettings.Button_AddChoices_ChatHeight = function (f33_arg0)
	f33_arg0:addChoice(Engine.Localize("MENU_SHOW_CAPS"), 8)
	f33_arg0:addChoice(Engine.Localize("MENU_HIDE_CAPS"), 0)
end

CoD.OptionsSettings.Button_AddChoices_SoundDevices = function (f34_arg0)
	for f34_local4, f34_local5 in ipairs(Dvar.sd_xa2_device_name:getDomainEnumStrings()) do
		local f34_local3 = f34_local5
		if string.len(f34_local5) > 32 then
			f34_local3 = string.sub(f34_local5, 1, 32) .. "..."
		end
		f34_arg0:addChoice(f34_local3, f34_local5)
	end
end

CoD.OptionsSettings.Button_AddChoices_Monitor = function (f35_arg0)
	local f35_local0 = Dvar.r_monitorCount:get()
	for f35_local1 = 1, f35_local0, 1 do
		f35_arg0:addChoice(f35_local1, f35_local1)
	end
end

CoD.OptionsSettings.Button_AddChoices_MaxCorpses = function (f36_arg0)
	f36_arg0:addChoice(Engine.Localize("MENU_TINY"), 3)
	f36_arg0:addChoice(Engine.Localize("MENU_SMALL"), 5)
	f36_arg0:addChoice(Engine.Localize("MENU_MEDIUM"), 10)
	f36_arg0:addChoice(Engine.Localize("MENU_LARGE"), 16)
end

CoD.OptionsSettings.DrawFPSCallback = function (f37_arg0, f37_arg1)
	if f37_arg1 ~= true then
		return 
	else
		Engine.SetDvar("cg_drawFPS", f37_arg0.value)
		Engine.SetHardwareProfileValue("cg_drawFPS", f37_arg0.value)
	end
end

CoD.OptionsSettings.Button_AddChoices_DrawFPS = function (f38_arg0)
	f38_arg0:addChoice(Engine.Localize("MENU_NO_CAPS"), "Off", nil, CoD.OptionsSettings.DrawFPSCallback)
	f38_arg0:addChoice(Engine.Localize("MENU_YES_CAPS"), "Simple", nil, CoD.OptionsSettings.DrawFPSCallback)
end

CoD.OptionsSettings.Button_AddChoices_DepthOfField = function (f39_arg0)
	f39_arg0:addChoice(Engine.Localize("PLATFORM_LOW_CAPS"), 0)
	f39_arg0:addChoice(Engine.Localize("PLATFORM_MEDIUM_CAPS"), 1)
	f39_arg0:addChoice(Engine.Localize("PLATFORM_HIGH_CAPS"), 2)
end

CoD.OptionsSettings.Button_AddChoices_MaxFPS = function (f40_arg0)
	f40_arg0:addChoice(Engine.Localize("MENU_UNLIMITED"), 0)
	f40_arg0:addChoice("30", 30)
	f40_arg0:addChoice("45", 45)
	f40_arg0:addChoice("60", 60)
	f40_arg0:addChoice("90", 90)
	f40_arg0:addChoice("120", 120)
end

CoD.OptionsSettings.CreateGraphicsTab = function (f41_arg0, f41_arg1)
	local f41_local0 = LUI.UIContainer.new()
	local f41_local1 = UIExpression.IsInGame() == 1
	local f41_local2 = CoD.Options.CreateButtonList()
	f41_arg0.buttonList = f41_local2
	f41_local0:addElement(f41_local2)
	local f41_local3 = f41_local2:addHardwareProfileLeftRightSelector(Engine.Localize("PLATFORM_VIDEO_MODE_CAPS"), "r_mode", Engine.Localize("PLATFORM_VIDEO_MODE_DESC"))
	CoD.OptionsSettings.Button_AddChoices_Resolution(f41_local3)
	local f41_local4 = f41_local2:addHardwareProfileLeftRightSelector(Engine.Localize("PLATFORM_DISPLAY_MODE_CAPS"), "r_fullscreen", Engine.Localize("PLATFORM_DISPLAY_MODE_DESC"))
	CoD.OptionsSettings.Button_AddChoices_DisplayMode(f41_local4)
	if f41_local4:getCurrentValue() == "2" then
		f41_local3:disableSelector()
	end
	local f41_local5 = f41_local2:addHardwareProfileLeftRightSelector(Engine.Localize("PLATFORM_MONITOR_CAPS"), "r_monitor", Engine.Localize("PLATFORM_MONITOR_DESC"))
	CoD.OptionsSettings.Button_AddChoices_Monitor(f41_local5)
	if f41_local4:getCurrentValue() == "0" then
		f41_local5:setChoice(0)
		f41_local5:disableSelector()
	end
	f41_local2:addSpacer(CoD.CoD9Button.Height / 2)
	local f41_local6 = f41_local2:addButton(Engine.Localize("MENU_BRIGHTNESS_CAPS"), Engine.Localize("PLATFORM_BRIGHTNESS_DESC"))
	f41_local6:setActionEventName("open_brightness")
	local f41_local7 = f41_local2:addHardwareProfileLeftRightSlider(Engine.Localize("PLATFORM_FIELD_OF_VIEW_CAPS"), "cg_fov_default", 65, 90, Engine.Localize("PLATFORM_FOV_DESC"))
	f41_local7:setNumericDisplayFormatString("%d")
	if CoD.isSinglePlayer and f41_local1 then
		f41_local7:disableCycling()
	end
	f41_local2:addSpacer(CoD.CoD9Button.Height / 2)
	local f41_local8 = f41_local2:addHardwareProfileLeftRightSelector(Engine.Localize("MENU_SHADOWS_CAPS"), "sm_spotQuality", Engine.Localize("PLATFORM_SHADOWS_DESC"))
	CoD.OptionsSettings.Button_AddChoices_Shadows(f41_local8)
	if Engine.GetHardwareProfileValueAsString("sm_enable") == "0" then
		f41_local8:setChoice(-1)
	end
	if not CoD.isSinglePlayer then
		CoD.Options.Button_AddChoices_EnabledOrDisabled(f41_local2:addHardwareProfileLeftRightSelector(Engine.Localize("PLATFORM_RAGDOLL_CAPS"), "ragdoll_enable", Engine.Localize("PLATFORM_RAGDOLL_DESC")))
	end
	f41_local2:addSpacer(CoD.CoD9Button.Height / 2)
	if CoD.isSinglePlayer then
		if CoD.Options.SupportsSubtitles() then
			CoD.Options.Button_AddChoices_EnabledOrDisabled(f41_local2:addProfileLeftRightSelector(f41_arg1, Engine.Localize("MENU_SUBTITLES_CAPS"), "cg_subtitles", Engine.Localize("MENU_SUBTITLES_DESC")))
		end
		if CoD.Options.SupportsMatureContent() then
			local f41_local9 = f41_local2:addProfileLeftRightSelector(f41_arg1, Engine.Localize("MENU_MATURE_CAPS"), "cg_mature", Engine.Localize("MENU_MATURE_CONTENT_DESC"))
			CoD.Options.Button_AddChoices_EnabledOrDisabled(f41_local9)
			f41_local9:disableCycling()
			f41_local9:registerEventHandler("button_action", function (f46_arg0, f46_arg1)
				f46_arg0:dispatchEventToParent({
					name = "open_mature_content",
					controller = f46_arg1.controller
				})
			end)
		end
	else
		CoD.OptionsSettings.Button_AddChoices_PlayerNameIndicator(f41_local2:addProfileLeftRightSelector(f41_arg1, Engine.Localize("MENU_TEAM_INDICATOR_CAPS"), "team_indicator", ""))
		CoD.Options.Button_AddChoices_OnOrOff(f41_local2:addProfileLeftRightSelector(f41_arg1, Engine.Localize("MENU_COLOR_BLIND_ASSIST_CAPS"), "colorblind_assist", Engine.Localize("MENU_COLOR_BLIND_ASSIST_DESC")))
		CoD.OptionsSettings.Button_AddChoices_ChatHeight(f41_local2:addHardwareProfileLeftRightSelector(Engine.Localize("PLATFORM_CHATMESSAGES_CAPS"), "cg_chatHeight", Engine.Localize("PLATFORM_CHATMESSAGES_DESC")))
	end
	return f41_local0
end

CoD.OptionsSettings.CreateAdvancedTab = function (f42_arg0, f42_arg1)
	local f42_local0 = LUI.UIContainer.new()
	local f42_local1 = UIExpression.IsInGame() == 1
	local f42_local2 = CoD.Options.CreateButtonList()
	f42_arg0.buttonList = f42_local2
	f42_local0.buttonList = f42_local2
	f42_local0:addElement(f42_local2)
	local f42_local3 = f42_local2:addHardwareProfileLeftRightSelector(Engine.Localize("MENU_TEXTURE_QUALITY_CAPS"), "r_picmip", Engine.Localize("PLATFORM_TEXTURE_QUALITY_DESC"))
	CoD.OptionsSettings.Button_AddChoices_TextureQuality(f42_local3)
	if Engine.GetHardwareProfileValueAsString("r_picmip_manual") == "0" then
		f42_local3:setChoice(-1)
	end
	if f42_local1 and CoD.isMultiplayer then
		f42_local3:disableSelector()
	end
	CoD.OptionsSettings.Button_AddChoices_TextureFiltering(f42_local2:addHardwareProfileLeftRightSelector(Engine.Localize("MENU_TEXTURE_MIPMAPS_CAPS"), "r_texFilterQuality", Engine.Localize("PLATFORM_TEXTURE_FILTERING_DESC")))
	local f42_local4 = f42_local2:addHardwareProfileLeftRightSelector(Engine.Localize("MENU_ANTIALIASING_CAPS"), "r_aaSamples", Engine.Localize("PLATFORM_ANTIALIASING_DESC"))
	CoD.OptionsSettings.Button_AddChoices_AntiAliasing(f42_local4)
	CoD.OptionsSettings.AdjustAntiAliasingSettings(f42_local4)
	CoD.Options.Button_AddChoices_YesOrNo(f42_local2:addHardwareProfileLeftRightSelector(Engine.Localize("PLATFORM_FXAA_CAPS"), "r_fxaa", Engine.Localize("PLATFORM_FXAA_DESC")))
	CoD.Options.Button_AddChoices_OnOrOff(f42_local2:addHardwareProfileLeftRightSelector(Engine.Localize("PLATFORM_AMBIENT_OCCLUSION_CAPS"), "r_ssao", Engine.Localize("PLATFORM_AMBIENT_OCCLUSION_DESC")))
	CoD.OptionsSettings.Button_AddChoices_DepthOfField(f42_local2:addHardwareProfileLeftRightSelector(Engine.Localize("PLATFORM_DEPTH_OF_FIELD_CAPS"), "r_dofHDR", Engine.Localize("PLATFORM_DEPTH_OF_FIELD_DESC")))
	f42_local2:addSpacer(CoD.CoD9Button.Height / 2)
	if CoD.isSinglePlayer then
		CoD.OptionsSettings.Button_AddChoices_MaxCorpses(f42_local2:addHardwareProfileLeftRightSelector(Engine.Localize("MENU_NUMBER_OF_CORPSES_CAPS"), "ai_corpseCount", Engine.Localize("PLATFORM_MAX_CORPSES_DESC")))
	end
	f42_local2:addSpacer(CoD.CoD9Button.Height / 2)
	CoD.Options.Button_AddChoices_YesOrNo(f42_local2:addHardwareProfileLeftRightSelector(Engine.Localize("MENU_SYNC_EVERY_FRAME_CAPS"), "r_vsync", Engine.Localize("PLATFORM_VSYNC_DESC")))
	local f42_local5 = f42_local2:addHardwareProfileLeftRightSelector(Engine.Localize("PLATFORM_MAX_FPS_CAPS"), "com_maxfps", Engine.Localize("PLATFORM_MAX_FPS_DESC"))
	CoD.OptionsSettings.Button_AddChoices_MaxFPS(f42_local5)
	if Engine.GetHardwareProfileValueAsString("r_vsync") == "1" then
		f42_local5:setChoice(0)
		f42_local5:disableSelector()
	end
	CoD.OptionsSettings.Button_AddChoices_DrawFPS(f42_local2:addHardwareProfileLeftRightSelector(Engine.Localize("PLATFORM_DRAW_FPS_CAPS"), "cg_drawFPS", Engine.Localize("PLATFORM_DRAW_FPS_DESC")))
	f42_local2:addSpacer(CoD.CoD9Button.Height / 2)
	CoD.Options.RegisterSocialEventHandlers(f42_local0)
	if CoD.isMultiplayer == true and UIExpression.IsInGame() == 0 and Engine.IsSignedInToDemonware(f42_arg1) then
		if Engine.IsYouTubeAccountChecked(f42_arg1) then
			CoD.Options.AddYouTubeButton(f42_local0, f42_arg1)
		elseif f42_local0.youtubeCheckTimer == nil then
			f42_local0.youtubeCheckTimer = LUI.UITimer.new(200, {
				name = "check_for_youtube_account",
				controller = f42_arg1
			})
			f42_local0:addElement(f42_local0.youtubeCheckTimer)
		end
		if not CoD.isZombie then
			if UIExpression.DvarBool(nil, "twEnabled") == 1 then
				if Engine.IsTwitterAccountChecked(f42_arg1) then
					CoD.Options.AddTwitterButton(f42_local0, f42_arg1)
				elseif f42_local0.twitterCheckTimer == nil then
					f42_local0.twitterCheckTimer = LUI.UITimer.new(200, {
						name = "check_for_twitter_account",
						controller = f42_arg1
					})
					f42_local0:addElement(f42_local0.twitterCheckTimer)
				end
			end
			if CoD.LiveStream.TwitchEnabled() then
				if Engine.IsTwitchAccountChecked(f42_arg1) then
					CoD.Options.AddTwitchButton(f42_local0, f42_arg1)
				elseif f42_local0.twitchCheckTimer == nil then
					f42_local0.twitchCheckTimer = LUI.UITimer.new(200, {
						name = "check_for_twitch_account",
						controller = f42_arg1
					})
					f42_local0:addElement(f42_local0.twitchCheckTimer)
				end
			end
		end
	end
	return f42_local0
end

CoD.OptionsSettings.CreateSoundTab = function (f43_arg0, f43_arg1)
	local f43_local0 = LUI.UIContainer.new()
	local f43_local1 = UIExpression.IsInGame() == 1
	local f43_local2 = CoD.Options.CreateButtonList()
	f43_arg0.buttonList = f43_local2
	f43_local0:addElement(f43_local2)
	local f43_local3 = f43_local2:addProfileLeftRightSlider(f43_arg1, Engine.Localize("MENU_VOICE_VOLUME_CAPS"), "snd_menu_voice", 0, 1, Engine.Localize("MENU_VOICE_VOLUME_DESC"), nil, nil, CoD.Options.AdjustSFX)
	local f43_local4 = f43_local2:addProfileLeftRightSlider(f43_arg1, Engine.Localize("MENU_MUSIC_VOLUME_CAPS"), "snd_menu_music", 0, 1, Engine.Localize("MENU_MUSIC_VOLUME_DESC"), nil, nil, CoD.Options.AdjustSFX)
	local f43_local5 = f43_local2:addProfileLeftRightSlider(f43_arg1, Engine.Localize("MENU_SFX_VOLUME_CAPS"), "snd_menu_sfx", 0, 1, Engine.Localize("MENU_SFX_VOLUME_DESC"), nil, nil, CoD.Options.AdjustSFX)
	local f43_local6 = f43_local2:addProfileLeftRightSlider(f43_arg1, Engine.Localize("MENU_MASTER_VOLUME_CAPS"), "snd_menu_master", 0, 1, Engine.Localize("MENU_MASTER_VOLUME_DESC"), nil, nil, CoD.Options.AdjustSFX)
	if CoD.isSinglePlayer == true then
		local f43_local7 = f43_local2:addProfileLeftRightSlider(f43_arg1, Engine.Localize("MENU_CINEMATICS_VOLUME_CAPS"), "snd_menu_cinematic", 0, 1, Engine.Localize("MENU_CINEMATICS_VOLUME_DESC"), nil, nil, CoD.Options.AdjustSFX)
	else
		local f43_local7 = f43_local2:addProfileLeftRightSlider(f43_arg1, Engine.Localize("MENU_SHOUTCAST_GAME_VOLUME_CAPS"), "snd_shoutcast_game", 0, 2, Engine.Localize("MENU_SHOUTCAST_GAME_VOLUME_DESC"), nil, nil, CoD.Options.AdjustSFX)
		local f43_local8 = f43_local2:addProfileLeftRightSlider(f43_arg1, Engine.Localize("MENU_SHOUTCAST_VOIP_VOLUME_CAPS"), "snd_shoutcast_voip", 0, 2, Engine.Localize("MENU_SHOUTCAST_VOIP_VOLUME_DESC"), nil, nil, CoD.Options.AdjustSFX)
	end
	f43_local2:addSpacer(CoD.CoD9Button.Height / 2)
	CoD.Options.Button_AddChoices_OnOrOff(f43_local2:addProfileLeftRightSelector(f43_arg1, Engine.Localize("MENU_HEARING_IMPAIRED_CAPS"), "snd_menu_hearing_impaired", Engine.Localize("MENU_HEARING_IMPAIRED_DESC")))
	if UIExpression.DvarBool(nil, "sd_can_switch_device") == 0 then

	else
		local f43_local8 = f43_local2:addHardwareProfileLeftRightSelector(Engine.Localize("PLATFORM_SOUND_DEVICE_CAPS"), "sd_xa2_device_name")
		CoD.OptionsSettings.Button_AddChoices_SoundDevices(f43_local8)
		if 1 >= Dvar.sd_xa2_num_devices:get() or f43_local1 then
			f43_local8:disableSelector()
		end
	end
	f43_local2:addSpacer(CoD.CoD9Button.Height / 2)
	CoD.AudioSettings.Button_AudioPresets_AddChoices(f43_local2:addProfileLeftRightSelector(f43_arg1, Engine.Localize("MENU_AUDIO_PRESETS_CAPS"), "snd_menu_presets", "", nil, nil, CoD.AudioSettings.CycleSFX))
	if UIExpression.IsInGame() == 0 and not (UIExpression.IsDemoPlaying(f43_arg1) ~= 0) then
		local f43_local9 = f43_local2:addButton(Engine.Localize("MENU_SYSTEM_TEST_CAPS"), Engine.Localize("MENU_SYSTEM_TEST_DESC"))
		f43_local9:registerEventHandler("button_action", CoD.AudioSettings.Button_SystemTestButton)
	end
	return f43_local0
end

CoD.OptionsSettings.CreateVoiceChatTab = function (f44_arg0, f44_arg1)
	local f44_local0 = LUI.UIContainer.new()
	local f44_local1 = CoD.Options.CreateButtonList()
	f44_arg0.buttonList = f44_local1
	f44_local0:addElement(f44_local1)
	CoD.Options.Button_AddChoices_OnOrOff(f44_local1:addHardwareProfileLeftRightSelector(Engine.Localize("MENU_VOICECHAT_CAPS"), "cl_voice", Engine.Localize("PLATFORM_VOICECHAT_DESC")))
	f44_local1:addSpacer(CoD.CoD9Button.Height / 2)
	local f44_local2 = f44_local1:addProfileLeftRightSlider(f44_arg1, Engine.Localize("PLATFORM_VOICECHAT_VOLUME"), "snd_voicechat_volume", 0, 1, Engine.Localize("PLATFORM_VOICECHAT_VOLUME_DESC"), nil, nil, CoD.Options.AdjustSFX)
	local f44_local3 = f44_local1:addProfileLeftRightSlider(f44_arg1, Engine.Localize("PLATFORM_VOICECHAT_RECORD_LEVEL"), "snd_voicechat_record_level", 0, 1, Engine.Localize("PLATFORM_VOICECHAT_RECORD_LEVEL_DESC"), nil, nil, CoD.Options.AdjustSFX)
	f44_local1:addSpacer(CoD.CoD9Button.Height / 2)
	local f44_local4 = f44_local1:addVoiceMeter(Engine.Localize("MENU_VOICECHAT_LEVEL_INDICATOR_CAPS"), Engine.Localize("PLATFORM_VOICEMETER_DESC"))
	return f44_local0
end

LUI.createMenu.OptionsSettingsMenu = function (f45_arg0)
	local f45_local0 = nil
	local f45_local1 = UIExpression.IsInGame() == 1
	if f45_local1 then
		f45_local0 = CoD.InGameMenu.New("OptionsSettingsMenu", f45_arg0, Engine.Localize("MENU_SETTINGS_CAPS"))
	else
		f45_local0 = CoD.Menu.New("OptionsSettingsMenu")
		f45_local0:addTitle(Engine.Localize("MENU_SETTINGS_CAPS"), LUI.Alignment.Center)
		if CoD.isSinglePlayer == false then
			f45_local0:addLargePopupBackground()
		end
	end
	if CoD.isSinglePlayer == true then
		Engine.SendMenuResponse(f45_arg0, "luisystem", "modal_start")
	end
	f45_local0.addApplyPrompt = CoD.Options.AddApplyPrompt
	f45_local0.addResetPrompt = CoD.Options.AddResetPrompt
	f45_local0:setPreviousMenu("OptionsMenu")
	f45_local0:setOwner(f45_arg0)
	f45_local0:registerEventHandler("add_apply_prompt", CoD.Options.AddApplyPrompt)
	f45_local0:registerEventHandler("button_prompt_back", CoD.OptionsSettings.Back)
	f45_local0:registerEventHandler("tab_changed", CoD.OptionsSettings.TabChanged)
	f45_local0:registerEventHandler("selector_changed", CoD.OptionsSettings.SelectorChanged)
	f45_local0:registerEventHandler("resolution_changed", CoD.OptionsSettings.ResolutionChanged)
	f45_local0:registerEventHandler("apply_changes", CoD.OptionsSettings.ApplyChanges)
	f45_local0:registerEventHandler("restore_default_settings", CoD.OptionsSettings.RestoreDefaultSettings)
	f45_local0:registerEventHandler("open_brightness", CoD.OptionsSettings.OpenBrightness)
	f45_local0:registerEventHandler("open_mature_content", CoD.OptionsSettings.OpenMatureContent)
	f45_local0:registerEventHandler("open_speaker_setup", CoD.AudioSettings.OpenSpeakerSetup)
	f45_local0:registerEventHandler("open_apply_popup", CoD.OptionsSettings.OpenApplyPopup)
	f45_local0:registerEventHandler("open_default_popup", CoD.OptionsSettings.OpenDefaultPopup)
	f45_local0:registerEventHandler("youtube_connect", CoD.Options.OpenYouTubeConnect)
	f45_local0:registerEventHandler("twitter_connect", CoD.Options.OpenTwitterConnect)
	f45_local0:registerEventHandler("twitch_connect", CoD.Options.OpenTwitchConnect)
	f45_local0:addSelectButton()
	f45_local0:addBackButton()
	if not f45_local1 then
		f45_local0:addResetPrompt()
	end
	if CoD.OptionsSettings.NeedVidRestart or CoD.OptionsSettings.NeedPicmip or CoD.OptionsSettings.NeedSndRestart then
		f45_local0:addApplyPrompt()
	end
	if not CoD.OptionsSettings.DoNotSyncProfile then
		Engine.SyncHardwareProfileWithDvars()
	end
	CoD.OptionsSettings.DoNotSyncProfile = nil
	local f45_local2 = CoD.Options.SetupTabManager(f45_local0, 500)
	f45_local2:addTab(f45_arg0, "MENU_GRAPHICS_CAPS", CoD.OptionsSettings.CreateGraphicsTab)
	f45_local2:addTab(f45_arg0, "MENU_ADVANCED_CAPS", CoD.OptionsSettings.CreateAdvancedTab)
	f45_local2:addTab(f45_arg0, "MENU_SOUND_CAPS", CoD.OptionsSettings.CreateSoundTab)
	if CoD.isMultiplayer then
		f45_local2:addTab(f45_arg0, "MENU_VOICECHAT_CAPS", CoD.OptionsSettings.CreateVoiceChatTab)
	end
	if CoD.OptionsSettings.CurrentTabIndex then
		f45_local2:loadTab(f45_arg0, CoD.OptionsSettings.CurrentTabIndex)
	else
		f45_local2:refreshTab(f45_arg0)
	end
	return f45_local0
end

