CoD.PopupMenus = {}
CoD.PopupMenus.SetupConfirmPopup = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	f1_arg0:registerEventHandler("confirm_action", f1_arg3)
	f1_arg0:registerEventHandler("decline_action", f1_arg4)
	local f1_local0 = "Default"
	local f1_local1 = 0
	local f1_local2 = 45
	
	local titleText = LUI.UIText.new()
	titleText:setLeftRight(true, true, 0, 0)
	titleText:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize[f1_local0])
	titleText:setAlignment(LUI.Alignment.Left)
	titleText:setFont(CoD.fonts[f1_local0])
	titleText:setText(Engine.Localize(f1_arg1))
	f1_arg0:addElement(titleText)
	f1_arg0.titleText = titleText
	
	f1_local1 = f1_local1 + CoD.textSize[f1_local0] + 5
	local f1_local4 = "Default"
	
	local messageText = LUI.UIText.new()
	messageText:setLeftRight(true, true, 0, 0)
	messageText:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize[f1_local4])
	messageText:setAlignment(LUI.Alignment.Left)
	messageText:setFont(CoD.fonts[f1_local4])
	messageText:setText(Engine.Localize(f1_arg2))
	f1_arg0:addElement(messageText)
	f1_arg0.messageText = messageText
	
	local f1_local6 = CoD.ButtonList.new()
	f1_local6:setLeftRight(true, true, 0, 0)
	f1_local6:setTopBottom(false, true, -(CoD.CoD9Button.Height * 2) - f1_local2, 0)
	f1_arg0:addElement(f1_local6)
	local f1_local7, f1_local8 = nil
	if f1_arg4 ~= nil then
		f1_local7 = f1_local6:addButton(Engine.Localize("MENU_YES_CAPS"))
		f1_local7:setActionEventName("confirm_action")
		f1_local8 = f1_local6:addButton(Engine.Localize("MENU_NO_CAPS"))
		f1_local8:setActionEventName("decline_action")
		f1_arg0.confirmButton = f1_local7
		f1_arg0.declineButton = f1_local8
	else
		f1_local7 = f1_local6:addButton(Engine.Localize("MENU_OK_CAPS"))
		f1_local7:setActionEventName("confirm_action")
		f1_arg0.confirmButton = f1_local7
	end
	Engine.PlaySound("cac_main_exit_cac")
end

CoD.PopupMenus.GoBack = function (f2_arg0, f2_arg1)
	f2_arg0:goBack(f2_arg1.controller)
end

LUI.createMenu.QuitPopup = function (f3_arg0)
	local f3_local0 = nil
	f3_local0 = CoD.Menu.NewSmallPopup("QuitPopup")
	CoD.PopupMenus.SetupConfirmPopup(f3_local0, "MENU_ARE_YOU_SURE_QUIT", "", CoD.PopupMenus.AcceptQuit, CoD.Menu.ButtonPromptBack)
	f3_local0:setOwner(f3_arg0)
	f3_local0.declineButton:processEvent({
		name = "gain_focus"
	})
	return f3_local0
end

CoD.PopupMenus.AcceptQuit = function (f4_arg0, f4_arg1)
	Engine.Exec(f4_arg1.controller, "quit")
end

LUI.createMenu.LeaveApplyConfirmPopup = function (f5_arg0)
	local f5_local0 = CoD.Menu.NewSmallPopup("LeaveApplyConfirmPopup")
	CoD.PopupMenus.SetupConfirmPopup(f5_local0, "MENU_APPLY_CAPS", "PLATFORM_LEAVE_APPLY_CONFIRM", CoD.PopupMenus.GoBack, CoD.PopupMenus.GoBack)
	f5_local0:setOwner(f5_arg0)
	f5_local0.declineButton:processEvent({
		name = "gain_focus"
	})
	return f5_local0
end

LUI.createMenu.ApplyChangesPopup = function (f6_arg0)
	local f6_local0 = CoD.Menu.NewSmallPopup("ApplyChangesPopup")
	CoD.PopupMenus.SetupConfirmPopup(f6_local0, "MENU_APPLY_CAPS", "MENU_APPLY_SETTINGS", CoD.PopupMenus.GoBack, CoD.PopupMenus.GoBack)
	f6_local0:setOwner(f6_arg0)
	f6_local0.declineButton:processEvent({
		name = "gain_focus"
	})
	return f6_local0
end

LUI.createMenu.SetDefaultPopup = function (f7_arg0)
	local f7_local0 = CoD.Menu.NewSmallPopup("SetDefaultPopup")
	CoD.PopupMenus.SetupConfirmPopup(f7_local0, "PLATFORM_DEFAULT_SYSTEM_SETTINGS_CAPS", "PLATFORM_RESTORE_GRAPHICS", CoD.PopupMenus.GoBack, CoD.PopupMenus.GoBack)
	f7_local0:setOwner(f7_arg0)
	f7_local0.declineButton:processEvent({
		name = "gain_focus"
	})
	return f7_local0
end

LUI.createMenu.SetDefaultControlsPopup = function (f8_arg0)
	local f8_local0 = CoD.Menu.NewSmallPopup("SetDefaultControlsPopup")
	CoD.PopupMenus.SetupConfirmPopup(f8_local0, "MENU_SET_DEFAULT_CONTROLS_CAPS", "PLATFORM_RESTORE_CONTROLS", CoD.PopupMenus.GoBack, CoD.PopupMenus.GoBack)
	f8_local0:setOwner(f8_arg0)
	f8_local0.declineButton:processEvent({
		name = "gain_focus"
	})
	return f8_local0
end

LUI.createMenu.ConfigureSettingsPopup = function (f9_arg0)
	local f9_local0 = CoD.Menu.NewSmallPopup("ConfigureSettingsPopup")
	CoD.perController[f9_arg0].firstTime = true
	CoD.PopupMenus.SetupConfirmPopup(f9_local0, "MENU_SETUP_CAPS", "MENU_SETUP_INSTRUCTIONS", CoD.PopupMenus.OpenBrightness)
	f9_local0.confirmButton:processEvent({
		name = "gain_focus"
	})
	return f9_local0
end

CoD.PopupMenus.OpenBrightness = function (f10_arg0, f10_arg1)
	f10_arg0:saveState()
	f10_arg0:openMenu("Brightness", f10_arg1.controller)
	f10_arg0:close()
end

LUI.createMenu.MatureContentPopup = function (f11_arg0)
	local f11_local0 = CoD.Menu.NewSmallPopup("ConfigureSettingsPopup")
	CoD.PopupMenus.SetupConfirmPopup(f11_local0, "MENU_GRAPHIC_CONTENT_CAPS", "MENU_DOYOUWANT_MATURE_CONTENT", CoD.PopupMenus.AcceptMatureContent, CoD.PopupMenus.DeclineMatureContent)
	f11_local0.closePopup = CoD.PopupMenus.CloseMatureContentPopup
	if UIExpression.ProfileInt(f11_arg0, "cg_mature") == 0 then
		f11_local0.declineButton:processEvent({
			name = "gain_focus"
		})
	else
		f11_local0.confirmButton:processEvent({
			name = "gain_focus"
		})
	end
	return f11_local0
end

CoD.PopupMenus.AcceptMatureContent = function (f12_arg0, f12_arg1)
	local f12_local0 = f12_arg1.controller
	Engine.ExecNow(f12_local0, "setprofile cg_blood 1")
	Engine.ExecNow(f12_local0, "setprofile cg_mature 1")
	f12_arg0:closePopup(f12_local0)
end

CoD.PopupMenus.DeclineMatureContent = function (f13_arg0, f13_arg1)
	local f13_local0 = f13_arg1.controller
	Engine.ExecNow(f13_local0, "setprofile cg_blood 0")
	Engine.ExecNow(f13_local0, "setprofile cg_mature 0")
	f13_arg0:closePopup(f13_local0)
end

CoD.PopupMenus.CloseMatureContentPopup = function (f14_arg0, f14_arg1)
	Engine.ExecNow(f14_arg1, "setprofile com_first_time 0")
	Engine.ExecNow(f14_arg1, "updategamerprofile")
	if CoD.perController[f14_arg1].firstTime then
		f14_arg0:dispatchEventToParent({
			name = "open_main_menu",
			controller = f14_arg1
		})
	else
		f14_arg0:goBack(f14_arg1)
	end
	CoD.perController[f14_arg1].firstTime = nil
	f14_arg0:close()
end

LUI.createMenu.SwitchToSPPopup = function (f15_arg0)
	local f15_local0 = CoD.Menu.NewSmallPopup("SetDefaultPopup")
	CoD.PopupMenus.SetupConfirmPopup(f15_local0, "", "PLATFORM_CONFIRM_SWITCH_TO_SP", CoD.PopupMenus.SwitchToSP, CoD.PopupMenus.GoBack)
	f15_local0:setOwner(f15_arg0)
	f15_local0.declineButton:processEvent({
		name = "gain_focus"
	})
	return f15_local0
end

CoD.PopupMenus.SwitchToSP = function (f16_arg0, f16_arg1)
	Engine.Exec(f16_arg1.controller, "startSingleplayer")
end

LUI.createMenu.SwitchToMPPopup = function (f17_arg0)
	local f17_local0 = CoD.Menu.NewSmallPopup("SetDefaultPopup")
	CoD.PopupMenus.SetupConfirmPopup(f17_local0, "", "PLATFORM_CONFIRM_SWITCH_TO_MP", CoD.PopupMenus.SwitchToMP, CoD.PopupMenus.GoBack)
	f17_local0:setOwner(f17_arg0)
	f17_local0.declineButton:processEvent({
		name = "gain_focus"
	})
	return f17_local0
end

CoD.PopupMenus.SwitchToMP = function (f18_arg0, f18_arg1)
	Engine.Exec(f18_arg1.controller, "startMultiplayer")
end

LUI.createMenu.SwitchToZMPopup = function (f19_arg0)
	local f19_local0 = CoD.Menu.NewSmallPopup("SetDefaultPopup")
	CoD.PopupMenus.SetupConfirmPopup(f19_local0, "", "PLATFORM_CONFIRM_SWITCH_TO_ZM", CoD.PopupMenus.SwitchToZM, CoD.PopupMenus.GoBack)
	f19_local0:setOwner(f19_arg0)
	f19_local0.declineButton:processEvent({
		name = "gain_focus"
	})
	return f19_local0
end

CoD.PopupMenus.SwitchToZM = function (f20_arg0, f20_arg1)
	Engine.Exec(f20_arg1.controller, "startZombies")
end

