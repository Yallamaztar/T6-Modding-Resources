CoD.FrontendSaveGameErrorPopup = {}
CoD.FrontendSaveGameErrorPopup.SaveGameErrorPopup = false
LUI.createMenu.FrontendSaveGameErrorPopup = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("ConfirmNoSaveDevicePopup", true)
	local f1_local1 = "Default"
	local f1_local2 = 0
	local f1_local3, f1_local4, f1_local5, f1_local6, f1_local7 = nil
	if Dvar.sv_saveDeviceAvailable:get() then
		f1_local3 = "PLATFORM_SAVE_ERROR_NOW_OKAY"
		f1_local4 = "MENU_NO_SAVE_DEVICE_WARNING_NOW_OKAY"
		f1_local5 = Engine.Localize("MENU_RETRY_SAVE")
		f1_local6 = "retry_save_game"
		f1_local7 = CoD.FrontendSaveGameErrorPopup.RetrySaveGameEvent
	elseif not CoD.isPS3 then
		f1_local3 = "PLATFORM_SAVE_ERROR"
		f1_local4 = "MENU_NO_SAVE_DEVICE_WARNING"
		f1_local5 = Engine.Localize("PLATFORM_SELECT_SAVE_DEVICE_CAPS")
		f1_local6 = "retry_save_game"
		f1_local7 = CoD.FrontendSaveGameErrorPopup.SelectSaveDeviceWarningEvent
	end
	f1_local0.title = LUI.UIText.new()
	f1_local0.title:setLeftRight(true, true, 0, 0)
	f1_local0.title:setTopBottom(true, false, f1_local2, f1_local2 + CoD.textSize[f1_local1])
	f1_local0.title:setAlignment(LUI.Alignment.Left)
	f1_local0.title:setFont(CoD.fonts[f1_local1])
	f1_local0.title:setText(Engine.Localize(f1_local3))
	f1_local0:addElement(f1_local0.title)
	local f1_local8 = f1_local2 + CoD.textSize[f1_local1] + 7
	f1_local0.description = LUI.UIText.new()
	f1_local0.description:setLeftRight(true, true, 0, 0)
	f1_local0.description:setTopBottom(true, false, f1_local8, f1_local8 + CoD.textSize[f1_local1])
	f1_local0.description:setAlignment(LUI.Alignment.Left)
	f1_local0.description:setFont(CoD.fonts[f1_local1])
	f1_local0.description:setText(Engine.Localize(f1_local4))
	f1_local0:addElement(f1_local0.description)
	f1_local0.listButtons = {}
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	local f1_local9 = CoD.ButtonList.new()
	f1_local9:setLeftRight(true, true, 0, 0)
	f1_local9:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 2 - 21, -15)
	f1_local0:addElement(f1_local9)
	if f1_local5 then
		local f1_local10 = f1_local9:addButton(f1_local5)
		f1_local10:setActionEventName(f1_local6)
		table.insert(f1_local0.listButtons, f1_local10)
	end
	local f1_local10 = f1_local9:addButton(Engine.Localize("MENU_RESUMEGAME_CAPS"))
	f1_local10:setActionEventName("resume_no_save")
	table.insert(f1_local0.listButtons, f1_local10)
	f1_local0.listButtons[1]:processEvent({
		name = "gain_focus"
	})
	f1_local0:registerEventHandler(f1_local6, f1_local7)
	f1_local0:registerEventHandler("resume_no_save", f1_local0.goBack)
	f1_local0:registerEventHandler("svSaveDeviceAvailableModified", CoD.FrontendSaveGameErrorPopup.SaveDeviceAvailable)
	return f1_local0
end

CoD.FrontendSaveGameErrorPopup.SelectSaveDeviceWarningEvent = function (f2_arg0, f2_arg1)
	f2_arg0.occludedMenu:processEvent({
		name = "open_FrontendSaveGameWarningPopup",
		controller = f2_arg1.controller
	})
	f2_arg0:close()
end

CoD.FrontendSaveGameErrorPopup.RetrySaveGameEvent = function (f3_arg0, f3_arg1)
	f3_arg0:openMenu("SaveGameSavingPopup", f3_arg1.controller, true)
	f3_arg0:close()
end

CoD.FrontendSaveGameErrorPopup.ForceSelectSaveDeviceEvent = function (f4_arg0, f4_arg1)
	Engine.ExecNow(f4_arg1.controller, "force_select_save_device")
	f4_arg0.occludedMenu:processEvent({
		name = "open_FrontendSaveGameErrorPopup",
		controller = f4_arg1.controller
	})
	f4_arg0:close()
end

CoD.FrontendSaveGameErrorPopup.SaveDeviceAvailable = function (f5_arg0, f5_arg1)
	f5_arg0.occludedMenu:processEvent({
		name = "open_FrontendSaveGameErrorPopup",
		controller = f5_arg1.controller
	})
	f5_arg0:close()
end

LUI.createMenu.FrontendSaveGameWarningPopup = function (f6_arg0)
	local f6_local0 = CoD.Menu.NewSmallPopup("ConfirmNoSaveDevicePopup", true)
	local f6_local1 = "Default"
	local f6_local2 = 0
	f6_local0.title = LUI.UIText.new()
	f6_local0.title:setLeftRight(true, true, 0, 0)
	f6_local0.title:setTopBottom(true, false, f6_local2, f6_local2 + CoD.textSize[f6_local1])
	f6_local0.title:setAlignment(LUI.Alignment.Left)
	f6_local0.title:setFont(CoD.fonts[f6_local1])
	f6_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f6_local0:addElement(f6_local0.title)
	local f6_local3 = f6_local2 + CoD.textSize[f6_local1] + 7
	f6_local0.description = LUI.UIText.new()
	f6_local0.description:setLeftRight(true, true, 0, 0)
	f6_local0.description:setTopBottom(true, false, f6_local3, f6_local3 + CoD.textSize[f6_local1])
	f6_local0.description:setAlignment(LUI.Alignment.Left)
	f6_local0.description:setFont(CoD.fonts[f6_local1])
	f6_local0.description:setText(Engine.Localize("MENU_WARNING_SELECTSAVEDEVICE"))
	f6_local0:addElement(f6_local0.description)
	f6_local0:addSelectButton()
	f6_local0:addBackButton()
	local f6_local4 = CoD.ButtonList.new()
	f6_local4:setLeftRight(true, true, 0, 0)
	f6_local4:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 1 - 21, -15)
	f6_local0:addElement(f6_local4)
	local f6_local5 = f6_local4:addButton(Engine.Localize("MENU_OK"))
	f6_local5:setActionEventName("force_select_save")
	f6_local0:registerEventHandler("force_select_save", CoD.FrontendSaveGameErrorPopup.ForceSelectSaveDeviceEvent)
	f6_local4:processEvent({
		name = "gain_focus"
	})
	return f6_local0
end

