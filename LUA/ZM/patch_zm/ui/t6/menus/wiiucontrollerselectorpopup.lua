CoD.WiiUControllerSelectorPopup = {}
CoD.WiiUControllerSelectorPopup.Close = function (f1_arg0)
	if f1_arg0.unpauseOnClose then
		Engine.SetDvar("cl_paused", 0)
	end
	Engine.SetDvar("wiiu_controller_selector_popup_open", 0)
	CoD.Menu.close(f1_arg0)
	if f1_arg0.hiddenMenu ~= nil then
		f1_arg0.hiddenMenu:show()
	end
end

CoD.WiiUControllerSelectorPopup.CancelAction = function (f2_arg0, f2_arg1)
	Engine.AssignController(f2_arg1.controller, false)
	CoD.Menu.ButtonPromptBack(f2_arg0, f2_arg1)
	if f2_arg0.hiddenMenu ~= nil then
		f2_arg0.hiddenMenu:show()
	end
end

CoD.WiiUControllerSelectorPopup.OkButtonOverride = function (f3_arg0, f3_arg1)
	if not f3_arg0.disabled and f3_arg1.down == false and f3_arg1.button == "primary" then
		Engine.AssignController(f3_arg1.controller, true)
		CoD.Menu.ButtonPromptBack(f3_arg0.popup, f3_arg1)
	end
	if f3_arg0.hiddenMenu ~= nil then
		f3_arg0.hiddenMenu:show()
	end
end

CoD.WiiUControllerSelectorPopup.Init = function (f4_arg0, f4_arg1)
	f4_arg0.msg:setText(f4_arg1.msg)
end

CoD.WiiUControllerSelectorPopup.SetOccludedMenu = function (f5_arg0, f5_arg1)
	f5_arg0.hiddenMenu = f5_arg1
	f5_arg1:hide()
	f5_arg0:baseSetOccludedMenu(f5_arg1)
end

LUI.createMenu.WiiUControllerSelectorPopup = function (f6_arg0)
	local f6_local0 = CoD.Menu.NewSmallPopup("WiiUControllerSelectorPopup")
	local f6_local1
	if UIExpression.IsInGame() ~= 1 then
		f6_local1 = CoD.isSinglePlayer
	else
		f6_local1 = true
	end
	if f6_local1 then
		f6_local0:setOwner(f6_arg0)
		Engine.LockInput(f6_arg0, true)
		Engine.SetUIActive(f6_arg0, true)
	end
	f6_local0.close = CoD.WiiUControllerSelectorPopup.Close
	f6_local0.okButton = LUI.UIElement.new()
	f6_local0:addElement(f6_local0.okButton)
	f6_local0.cancelButton = CoD.ButtonPrompt.new("secondary", Engine.Localize("MENU_CANCEL"), f6_local0, "cancel_action")
	f6_local0:addLeftButtonPrompt(f6_local0.cancelButton)
	f6_local0:registerEventHandler("close_controller_selector_popup", CoD.Menu.ButtonPromptBack)
	f6_local0:registerEventHandler("cancel_action", CoD.WiiUControllerSelectorPopup.CancelAction)
	f6_local0.okButton.popup = f6_local0
	f6_local0.okButton:registerEventHandler("gamepad_button", CoD.WiiUControllerSelectorPopup.OkButtonOverride)
	local f6_local2 = 5
	local f6_local3 = LUI.UIText.new()
	f6_local3:setLeftRight(true, true, 0, 0)
	f6_local3:setTopBottom(true, false, f6_local2, f6_local2 + CoD.textSize.Default)
	f6_local3:setFont(CoD.fonts.Default)
	f6_local3:setAlignment(LUI.Alignment.Left)
	f6_local3:setText(Engine.Localize("PLATFORM_FOUND_NEW_CONTROLLER"))
	f6_local0:addElement(f6_local3)
	f6_local2 = f6_local2 + CoD.textSize.Default + 10
	f6_local0.msg = LUI.UIText.new()
	f6_local0.msg:setLeftRight(true, true, 0, 0)
	f6_local0.msg:setTopBottom(true, false, f6_local2, f6_local2 + CoD.textSize.Default)
	f6_local0.msg:setFont(CoD.fonts.Default)
	f6_local0.msg:setAlignment(LUI.Alignment.Left)
	f6_local0:addElement(f6_local0.msg)
	if CoD.isSinglePlayer == true then
		if 0 == Dvar.cl_paused:get() then
			f6_local0.unpauseOnClose = true
			Engine.SetDvar("cl_paused", 1)
		else
			f6_local0.unpauseOnClose = false
		end
	end
	f6_local0.init = CoD.WiiUControllerSelectorPopup.Init
	return f6_local0
end

