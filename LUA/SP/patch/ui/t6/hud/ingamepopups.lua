require("T6.HUD.InGameMenus")
require("T6.HUD.InGamePopupMenu")
CoD.InGamePopups = {}
LUI.createMenu.LowerDifficultyPopup = function (f1_arg0)
	local f1_local0, f1_local1 = nil
	local f1_local2 = Engine.GetProfileVarInt(f1_arg0, "g_gameskill")
	if f1_local2 == 1 then
		f1_local0 = Engine.Localize("MENU_LOWER_DIFFICULTY_1_0")
		f1_local1 = Engine.Localize("MENU_LOWER_DIFFICULTY_1_0_BUTTON")
	elseif f1_local2 == 2 then
		f1_local0 = Engine.Localize("MENU_LOWER_DIFFICULTY_2_1")
		f1_local1 = Engine.Localize("MENU_LOWER_DIFFICULTY_2_1_BUTTON")
	elseif f1_local2 == 3 then
		f1_local0 = Engine.Localize("MENU_LOWER_DIFFICULTY_3_2")
		f1_local1 = Engine.Localize("MENU_LOWER_DIFFICULTY_3_2_BUTTON")
	else
		DebugPrint("LUI WARNING: LowerDifficultyPopup retreived an unapproved gameskill of " .. f1_local2)
		return nil
	end
	local f1_local3 = CoD.InGamePopupMenu.New("LowerDifficultyPopup", f1_arg0, "default", Engine.Localize("MENU_LOWER_DIFFICULTY_CAPS"), f1_local0, {
		{
			text = Engine.Localize("MENU_CANCEL_CAPS"),
			event = "cancel"
		},
		{
			text = f1_local1,
			event = "lower_difficulty"
		}
	}, true)
	f1_local3:registerEventHandler("lower_difficulty", CoD.InGamePopups.LowerDifficultyEvent)
	f1_local3:registerEventHandler("cancel", CoD.InGamePopups.CancelEvent)
	return f1_local3
end

LUI.createMenu.QuitGamePopup = function (f2_arg0)
	local f2_local0 = Engine.GameModeIsMode(CoD.GAMEMODE_RTS)
	local f2_local1 = nil
	if f2_local0 then
		f2_local1 = "MENU_RTS_QUIT_WARNING_DESC"
	else
		f2_local1 = "MENU_NOPROFILE_QUIT_WARNING_DESC"
	end
	local f2_local2 = CoD.InGamePopupMenu.New("QuitGamePopup", f2_arg0, "default", Engine.Localize("MENU_QUIT_WARNING"), Engine.Localize(f2_local1), {
		{
			text = Engine.Localize("MENU_RESUMEGAME_CAPS"),
			event = "resume_game"
		},
		{
			text = Engine.Localize("PLATFORM_QUIT_CAPS"),
			event = "quit_game"
		}
	}, true)
	f2_local2:registerEventHandler("quit_game", CoD.InGamePopups.QuitGameEvent)
	f2_local2:registerEventHandler("resume_game", CoD.InGamePopups.ResumeGameEvent)
	return f2_local2
end

LUI.createMenu.SaveAndQuitGamePopup = function (f3_arg0)
	local f3_local0 = nil
	if CoD.isXBOX then
		f3_local0 = Engine.Localize("MENU_SAVEQUIT_TEXT_WITH_DEVICE_CHANGE")
	else
		f3_local0 = Engine.Localize("MENU_SAVEQUIT_TEXT_WITHOUT_DEVICE_CHANGE")
	end
	local f3_local1, f3_local2 = nil
	if Dvar.sv_saveDeviceAvailable:get() then
		f3_local1 = "save_and_quit_available"
		f3_local2 = CoD.InGamePopups.SaveAndQuitGameEvent
	else
		f3_local1 = "save_and_quit_unavailable"
		f3_local2 = CoD.InGamePopups.SaveAndQuitGameUnavailableEvent
	end
	local f3_local3 = CoD.InGamePopupMenu.New("SaveAndQuitGamePopup", f3_arg0, "default", Engine.Localize("MENU_CONTINUE_SAVING"), f3_local0, {
		{
			text = Engine.Localize("MENU_RESUMEGAME_CAPS"),
			event = "resume_game"
		},
		{
			text = Engine.Localize("MENU_SAVE_AND_QUIT_CAPS"),
			event = f3_local1
		}
	}, true)
	f3_local3:registerEventHandler("resume_game", CoD.InGamePopups.SaveAndQuitGamePopupResume)
	f3_local3:registerEventHandler(f3_local1, f3_local2)
	return f3_local3
end

CoD.InGamePopups.SaveAndQuitGamePopupResume = function (f4_arg0, f4_arg1)
	Engine.RevertSave(f4_arg1.controller)
	CoD.InGamePopups.ResumeGameEvent(f4_arg0, f4_arg1)
end

LUI.createMenu.UnableToWriteSaveGamePopup = function (f5_arg0)
	local f5_local0, f5_local1, f5_local2 = nil
	if Dvar.sv_saveDeviceAvailable:get() then
		f5_local0 = Engine.Localize("MENU_RETRY_SAVE")
		f5_local1 = "retry_save_game"
		f5_local2 = CoD.InGamePopups.RetrySaveGameEvent
	elseif not CoD.isPS3 then
		f5_local0 = Engine.Localize("PLATFORM_SELECT_SAVE_DEVICE_CAPS")
		f5_local1 = "retry_save_game"
		f5_local2 = CoD.InGamePopups.SelectSaveDeviceWarningEvent
	end
	local f5_local3 = CoD.InGamePopupMenu.New("UnableToWriteSaveGamePopup", f5_arg0, "default", Engine.Localize("MENU_QUIT_WARNING"), Engine.Localize("MENU_NOPROFILE_QUIT_WARNING_DESC"), {
		{
			text = f5_local0,
			[1] = f5_local1
		},
		{
			text = Engine.Localize("MENU_RESUMEGAME_CAPS"),
			event = "resume_no_save"
		},
		{
			text = Engine.Localize("MENU_QUIT_NO_SAVE"),
			event = "quit_no_save"
		}
	})
	f5_local3:registerEventHandler("resume_no_save", CoD.InGamePopups.NoSaveResumeGameEvent)
	f5_local3:registerEventHandler("quit_no_save", CoD.InGamePopups.NoSaveQuitGameEvent)
	f5_local3:registerEventHandler(f5_local1, f5_local2)
	return f5_local3
end

LUI.createMenu.SaveGameErrorPopup = function (f6_arg0, f6_arg1)
	local f6_local0, f6_local1, f6_local2, f6_local3, f6_local4 = nil
	if Dvar.sv_saveDeviceAvailable:get() then
		f6_local0 = Engine.Localize("PLATFORM_SAVE_ERROR_NOW_OKAY")
		f6_local1 = Engine.Localize("MENU_NO_SAVE_DEVICE_WARNING_NOW_OKAY")
		f6_local2 = Engine.Localize("MENU_RETRY_SAVE")
		f6_local3 = "retry_save_game"
		f6_local4 = CoD.InGamePopups.RetrySaveGameEvent
	elseif not CoD.isPS3 then
		f6_local0 = Engine.Localize("PLATFORM_SAVE_ERROR")
		f6_local1 = Engine.Localize("MENU_NO_SAVE_DEVICE_WARNING")
		f6_local2 = Engine.Localize("PLATFORM_SELECT_SAVE_DEVICE_CAPS")
		f6_local3 = "retry_save_game"
		f6_local4 = CoD.InGamePopups.SelectSaveDeviceWarningEvent
	end
	local f6_local5 = {
		{
			text = f6_local2,
			event = f6_local3
		},
		{
			text = Engine.Localize("MENU_RESUMEGAME_CAPS"),
			event = "resume_no_save"
		},
		{
			text = Engine.Localize("MENU_QUIT_NO_SAVE"),
			event = "quit_no_save"
		}
	}
	if f6_arg1 and f6_arg1.saveGameErrorPopupFromCode then
		local f6_local6 = Engine.Localize("MENU_QUIT_NO_SAVE")
		for f6_local7 = 1, #f6_local5, 1 do
			if f6_local5[f6_local7].text == f6_local6 then
				table.remove(f6_local5, f6_local7)
			end
		end
	end
	local f6_local6 = CoD.InGamePopupMenu.New("SaveGameErrorPopup", f6_arg0, "default", f6_local0, f6_local1, f6_local5)
	f6_local6:registerEventHandler("svSaveDeviceAvailableModified", CoD.InGamePopups.SaveDeviceAvailable)
	f6_local6:registerEventHandler("resume_no_save", CoD.InGamePopups.NoSaveResumeGameEvent)
	f6_local6:registerEventHandler("quit_no_save", CoD.InGamePopups.NoSaveQuitGameEvent)
	f6_local6:registerEventHandler(f6_local3, f6_local4)
	return f6_local6
end

LUI.createMenu.SaveGameWarningPopup = function (f7_arg0)
	local f7_local0 = CoD.InGamePopupMenu.New("SaveGameWarningPopup", f7_arg0, "default", Engine.Localize("MENU_NOTICE"), Engine.Localize("MENU_WARNING_SELECTSAVEDEVICE"), {
		{
			text = Engine.Localize("MENU_OK"),
			event = "force_select_save"
		}
	})
	f7_local0:registerEventHandler("force_select_save", CoD.InGamePopups.ForceSelectSaveDeviceEvent)
	return f7_local0
end

LUI.createMenu.SaveDeviceWarningPopup = function (f8_arg0)
	local f8_local0 = CoD.InGamePopupMenu.New("SaveDeviceWarningPopup", f8_arg0, "default", Engine.Localize("MENU_NOTICE"), Engine.Localize("MENU_WARNING_SELECTSAVEDEVICE"), {
		{
			text = Engine.Localize("MENU_OK"),
			event = "force_select_save"
		}
	})
	f8_local0:registerEventHandler("force_select_save", CoD.InGamePopups.SaveDeviceWarningEvent)
	f8_local0:registerEventHandler("button_prompt_back", CoD.InGamePopups.CancelEvent)
	return f8_local0
end

LUI.createMenu.SaveGameSavingPopup = function (f9_arg0, f9_arg1)
	local f9_local0 = CoD.InGamePopupMenu.New("SaveGameSavingPopup", f9_arg0, "saving", Engine.Localize("PLATFORM_NOW_SAVING"))
	if f9_arg1 == true then
		Engine.DelayAndWriteSave(true)
	else
		Engine.DelayAndWriteSave(false)
	end
	f9_local0.saveTimeUp = false
	f9_local0.saveSaved = false
	f9_local0.controller = f9_arg0
	f9_local0:registerEventHandler("notify_save_complete", CoD.InGamePopups.SaveSaved)
	f9_local0:registerEventHandler("notify_save_timeup", CoD.InGamePopups.SaveTimeUp)
	f9_local0:registerEventHandler("notify_save_forceclose", CoD.InGamePopups.SaveForceClose)
	f9_local0:addElement(LUI.UITimer.new(4000, "notify_save_timeup", true, f9_local0))
	f9_local0:setPriority(10000)
	return f9_local0
end

LUI.createMenu.RestartLevelPopup = function (f10_arg0)
	local f10_local0 = CoD.InGamePopupMenu.New("RestartLevelPopup", f10_arg0, "default", Engine.Localize("MENU_CONTINUE_RESTART"), Engine.Localize("MENU_RESTART_LEVEL_TEXT"), {
		{
			text = Engine.Localize("MENU_RESUMEGAME_CAPS"),
			event = "resume_game"
		},
		{
			text = Engine.Localize("MENU_RESTART_LEVEL_CAPS"),
			event = "restart_level"
		}
	}, true)
	f10_local0:registerEventHandler("restart_level", CoD.InGamePopups.RestartLevelEvent)
	f10_local0:registerEventHandler("resume_game", CoD.InGamePopups.ResumeGameEvent)
	return f10_local0
end

LUI.createMenu.RestartFromCheckpointPopup = function (f11_arg0)
	local f11_local0 = CoD.InGamePopupMenu.New("RestartFromCheckpointPopup", f11_arg0, "default", Engine.Localize("MENU_CONTINUE_RESTART_CHECKPOINT"), Engine.Localize("MENU_CHECKPOINT_RESTART_TEXT"), {
		{
			text = Engine.Localize("MENU_RESUMEGAME_CAPS"),
			event = "resume_game"
		},
		{
			text = Engine.Localize("MENU_RESTART_CHECKPOINT_CAPS"),
			event = "restart_from_checkpoint"
		}
	}, true)
	f11_local0:registerEventHandler("restart_from_checkpoint", CoD.InGamePopups.RestartFromCheckpointEvent)
	f11_local0:registerEventHandler("resume_game", CoD.InGamePopups.ResumeGameEvent)
	return f11_local0
end

LUI.createMenu.RestartMissionPopup = function (f12_arg0)
	local f12_local0 = CoD.InGamePopupMenu.New("RestartMissionPopup", f12_arg0, "default", Engine.Localize("MENU_CONTINUE_RESTART"), Engine.Localize("MENU_RESTART_MISSION_TEXT"), {
		{
			text = Engine.Localize("MENU_RESUMEGAME_CAPS"),
			event = "resume_game"
		},
		{
			text = Engine.Localize("MENU_RESTART_MISSION_CAPS"),
			event = "restart_mission"
		}
	}, true)
	f12_local0:registerEventHandler("restart_mission", CoD.InGamePopups.RestartMissionEvent)
	f12_local0:registerEventHandler("resume_game", CoD.InGamePopups.ResumeGameEvent)
	return f12_local0
end

LUI.createMenu.ControllerRemovedPopup = function (f13_arg0)
	local f13_local0 = CoD.InGamePopupMenu.New("ControllerRemovedPopup", f13_arg0, "default", Engine.Localize("PLATFORM_CONTROLLER_DISCONNECTED") .. UIExpression.DvarString(nil, "disconnected_ctrls"), "", {
		{
			text = Engine.Localize("MENU_RESUMEGAME_CAPS"),
			event = "resume_game"
		}
	})
	f13_local0:registerEventHandler("resume_game", CoD.InGamePopups.ResumeGameEvent)
	return f13_local0
end

LUI.createMenu.RetryMissionPopup = function (f14_arg0)
	local f14_local0 = CoD.InGamePopupMenu.New("RetryMissionPopup", f14_arg0, "default", Engine.Localize("MENU_CONTINUE_RETRY"), Engine.Localize("MENU_RETRY_MISSION_TEXT"), {
		{
			text = Engine.Localize("MENU_RESUMEGAME_CAPS"),
			event = "resume_game"
		},
		{
			text = Engine.Localize("MENU_CONFIRM_CAPS"),
			event = "restart_mission"
		}
	}, true)
	f14_local0:registerEventHandler("restart_mission", CoD.InGamePopups.RetryRTSMissionEvent)
	f14_local0:registerEventHandler("resume_game", CoD.InGamePopups.ResumeGameEvent)
	return f14_local0
end

LUI.createMenu.RTSTutorialPopup = function (f15_arg0)
	local f15_local0 = CoD.InGamePopupMenu.newCustom("RTSTutorialPopup", f15_arg0)
	local f15_local1 = nil
	if CoD.isPS3 then
		f15_local1 = CoD.ButtonPrompt.new("emblem_move", Engine.Localize("PLATFORM_CHANGE_PAGES"))
	else
		f15_local1 = CoD.ButtonPrompt.new("left_stick_up", Engine.Localize("PLATFORM_CHANGE_PAGES"))
	end
	f15_local0:addLeftButtonPrompt(f15_local1)
	if CoD.isPC then
		f15_local1:registerEventHandler("input_source_changed", function (f40_arg0, f40_arg1)
			if f40_arg1.source == 0 then
				CoD.ButtonPrompt.InputSourceChanged(f40_arg0, f40_arg1)
				f40_arg0:setAlpha(1)
			else
				f40_arg0:setAlpha(0)
			end
		end)
		if not Engine.LastInput_Gamepad() then
			f15_local1:setAlpha(0)
		end
	end
	f15_local0:addBackButton()
	f15_local0:registerEventHandler("button_prompt_back", CoD.InGamePopups.CloseRTSTutorialEvent)
	f15_local0.tutorial = CoD.RTSTutorial.new()
	f15_local0:addElement(f15_local0.tutorial)
	return f15_local0
end

LUI.createMenu.SkipTutorialPopup = function (f16_arg0)
	local f16_local0 = CoD.InGamePopupMenu.New("SkipTutorialPopup", f16_arg0, "default", Engine.Localize("MENU_CONTINUE_SKIP"), Engine.Localize("MENU_CONTINUE_SKIP_TEXT"), {
		{
			text = Engine.Localize("MENU_RESUMEGAME_CAPS"),
			event = "resume_game"
		},
		{
			text = Engine.Localize("MENU_SKIP_TUTORIAL_CAPS"),
			event = "skip_tutorial"
		}
	})
	f16_local0:registerEventHandler("resume_game", CoD.InGamePopups.ResumeGameEvent)
	f16_local0:registerEventHandler("skip_tutorial", CoD.InGamePopups.SkipTutorial)
	return f16_local0
end

LUI.createMenu.ReadingSaveDevice = function (f17_arg0)
	local f17_local0 = CoD.InGamePopupMenu.New("ReadingSaveDevice", f17_arg0, "saving", Engine.Localize("PLATFORM_READING_SAVE_DEVICE_CAPS"))
	f17_local0:registerEventHandler("close_readingsavedevice", function (f41_arg0, f41_arg1)
		f41_arg0:close()
	end)
	return f17_local0
end

CoD.InGamePopups.SaveSaved = function (f18_arg0, f18_arg1)
	f18_arg0.saveSaved = true
	if f18_arg0.saveTimeUp == true then
		Engine.SaveComplete(f18_arg0.controller)
		f18_arg0.previousMenuName = nil
		f18_arg0:animateOutAndGoBack()
		f18_arg0 = nil
	end
end

CoD.InGamePopups.SaveTimeUp = function (f19_arg0, f19_arg1)
	f19_arg0.saveTimeUp = true
	if f19_arg0.saveSaved == true then
		Engine.SaveComplete(f19_arg0.controller)
		f19_arg0.previousMenuName = nil
		f19_arg0:animateOutAndGoBack()
		f19_arg0 = nil
	end
end

CoD.InGamePopups.SaveForceClose = function (f20_arg0, f20_arg1)
	Engine.SaveComplete(f20_arg0.controller)
	f20_arg0.previousMenuName = nil
	f20_arg0:animateOutAndGoBack()
	f20_arg0 = nil
end

CoD.InGamePopups.SaveDeviceAvailable = function (f21_arg0, f21_arg1)
	f21_arg0:openMenu("SaveGameErrorPopup", f21_arg1.controller)
	f21_arg0:close()
end

CoD.InGamePopups.ResumeGameEvent = function (f22_arg0, f22_arg1)
	f22_arg0:processEvent({
		name = "close_all_ingame_menus",
		controller = f22_arg1.controller
	})
end

CoD.InGamePopups.RetrySaveGameEvent = function (f23_arg0, f23_arg1)
	f23_arg0:openMenu("SaveGameSavingPopup", f23_arg1.controller, true)
	f23_arg0:processEvent({
		name = "close_all_ingame_menus",
		controller = f23_arg1.controller
	})
end

CoD.InGamePopups.NoSaveResumeGameEvent = function (f24_arg0, f24_arg1)
	f24_arg0:processEvent({
		name = "close_all_ingame_menus",
		controller = f24_arg1.controller
	})
	Engine.RevertSave(f24_arg1.controller)
end

CoD.InGamePopups.NoSaveQuitGameEvent = function (f25_arg0, f25_arg1)
	f25_arg0:processEvent({
		name = "close_all_ingame_menus",
		controller = f25_arg1.controller
	})
	Engine.RevertSave(f25_arg1.controller)
	Engine.Exec(f25_arg1.controller, "disconnect")
	Dvar.ui_saveandquit:set(1)
end

CoD.InGamePopups.SelectSaveDeviceWarningEvent = function (f26_arg0, f26_arg1)
	f26_arg0:openMenu("SaveGameWarningPopup", f26_arg1.controller)
	f26_arg0:close()
end

CoD.InGamePopups.ForceSelectSaveDeviceEvent = function (f27_arg0, f27_arg1)
	Engine.ExecNow(f27_arg1.controller, "force_select_save_device")
	f27_arg0:openMenu("SaveGameErrorPopup", f27_arg1.controller)
	f27_arg0:close()
end

CoD.InGamePopups.SaveDeviceWarningEvent = function (f28_arg0, f28_arg1)
	Engine.ExecNow(f28_arg1.controller, "force_select_save_device")
	f28_arg0:goBack(f28_arg1.controller)
end

CoD.InGamePopups.CancelEvent = function (f29_arg0, f29_arg1)
	f29_arg0:goBack(f29_arg1.controller)
end

CoD.InGamePopups.SkipTutorial = function (f30_arg0, f30_arg1)
	Dvar.ui_isrtstutorial:set(0)
	Engine.Exec(f30_arg1.controller, "launchlevel " .. Dvar.ui_aarmapname:get())
end

CoD.InGamePopups.CloseRTSTutorialEvent = function (f31_arg0, f31_arg1)
	f31_arg0.tutorial:close()
	f31_arg0:goBack(f31_arg1.controller)
end

CoD.InGamePopups.LowerDifficultyEvent = function (f32_arg0, f32_arg1)
	local f32_local0 = Engine.GetProfileVarInt(f32_arg1.controller, "g_gameskill")
	if f32_local0 > 0 then
		Engine.SetProfileVar(f32_arg1.controller, "g_gameskill", f32_local0 - 1)
		Dvar.saved_gameskill:set(f32_local0 - 1 .. "")
	end
	Engine.Exec(f32_arg1.controller, "updategamerprofile")
	Engine.Exec(f32_arg1.controller, "updateDifficultyFromProfile")
	f32_arg0:goBack(f32_arg1.controller)
end

CoD.InGamePopups.QuitGameEvent = function (f33_arg0, f33_arg1)
	f33_arg0:processEvent({
		name = "close_all_ingame_menus",
		controller = f33_arg1.controller
	})
	if Dvar.ui_singlemission:get() ~= 0 then
		Engine.ExecNow(f33_arg1.controller, "checkinvite")
	end
	Engine.Exec(f33_arg1.controller, "disconnect")
	Dvar.ui_saveandquit:set(1)
	Dvar.ui_isrtstutorial:set(0)
end

CoD.InGamePopups.SaveAndQuitGameEvent = function (f34_arg0, f34_arg1)
	Engine.SetSaveExecOnSuccess("disconnect")
	Engine.Exec(f34_arg1.controller, "updategamerprofile")
	f34_arg0:openMenu("SaveGameSavingPopup", f34_arg1.controller, true)
	f34_arg0:close()
	Dvar.ui_saveandquit:set(1)
	Engine.SetDvar("ui_skipMainLockout", 1)
end

CoD.InGamePopups.SaveAndQuitGameUnavailableEvent = function (f35_arg0, f35_arg1)
	f35_arg0:openMenu("SaveGameErrorPopup", f35_arg1.controller)
	f35_arg0:close()
	Engine.SetDvar("ui_skipMainLockout", 1)
end

CoD.InGamePopups.RetryRTSMissionEvent = function (f36_arg0, f36_arg1)
	Engine.SendMenuResponse(f36_arg1.controller, "rts_action", "rts_restart_mission")
	f36_arg0:processEvent({
		name = "close_all_ingame_menus",
		controller = f36_arg1.controller
	})
end

CoD.InGamePopups.RestartMissionEvent = function (f37_arg0, f37_arg1)
	Dvar.ui_busyBlockIngameMenu:set(1)
	f37_arg0:processEvent({
		name = "close_all_ingame_menus",
		controller = f37_arg1.controller
	})
	Engine.Exec(f37_arg1.controller, "stopControllerRumble")
	Engine.Exec(f37_arg1.controller, "fade 0 0 0 255 0 0 1")
	Engine.Exec(f37_arg1.controller, "silence")
	Engine.Exec(f37_arg1.controller, "mission_restart")
end

CoD.InGamePopups.RestartLevelEvent = function (f38_arg0, f38_arg1)
	Dvar.ui_busyBlockIngameMenu:set(1)
	f38_arg0:processEvent({
		name = "close_all_ingame_menus",
		controller = f38_arg1.controller
	})
	Engine.Exec(f38_arg1.controller, "stopControllerRumble")
	Engine.Exec(f38_arg1.controller, "fade 0 0 0 255 0 0 1")
	Engine.Exec(f38_arg1.controller, "silence")
	Engine.Exec(f38_arg1.controller, "fast_restart")
end

CoD.InGamePopups.RestartFromCheckpointEvent = function (f39_arg0, f39_arg1)
	Dvar.ui_busyBlockIngameMenu:set(1)
	f39_arg0:dispatchEventToRoot({
		name = "flush_dynamic_hud"
	})
	f39_arg0:processEvent({
		name = "close_all_ingame_menus",
		controller = f39_arg1.controller
	})
	Engine.Exec(f39_arg1.controller, "fade 0 0 0 255 0 0 1")
	Engine.Exec(f39_arg1.controller, "stopControllerRumble")
	Engine.Exec(f39_arg1.controller, "silence")
	Engine.Exec(f39_arg1.controller, "checkpoint_restart")
end

