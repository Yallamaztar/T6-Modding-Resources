CoD.LockOut = {}
CoD.LockOut.FontName = "Condensed"
CoD.LockOut.PulseFadeTime = 750
CoD.LockOut.OpenMainMenu = function (f1_arg0, f1_arg1)
	Engine.ExecNow(controller, "remapcontrollertoprimaryandactivate")
	Engine.Exec(UIExpression.GetPrimaryController(), "select_save_device")
end

CoD.LockOut.FinishOpenMainMenu = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	Engine.ExecNow(f2_local0, "disableallbutprimaryclients")
	if CoD.ShadesHud.bootupComplete ~= true and UIExpression.DvarBool(nil, "ui_skipMainLockout") == 0 then
		Engine.SendMenuResponse(f2_local0, "lockout", "need_glasses")
		Engine.SendMenuResponse(f2_local0, "lockout", "deactivated")
	else
		CoD.Menu.targetLandingMenu = "LockOutMenu"
		CoD.Menu.CanHideHud = true
		Engine.PlaySound("uin_main_edit")
		Engine.SendMenuResponse(f2_local0, "lockout", "deactivated")
		f2_arg0:dispatchEventToParent({
			name = "open_main_menu",
			controller = f2_local0
		})
	end
	Dvar.ui_onLockOutMenu:set(false)
	f2_arg0:close()
end

LUI.createMenu.LockOutMenu = function (f3_arg0)
	local f3_local0 = CoD.Menu.New("LockOutMenu")
	f3_local0.anyControllerAllowed = true
	Dvar.ui_onLockOutMenu:set(true)
	f3_local0:registerEventHandler("open_main_menu", CoD.LockOut.OpenMainMenu)
	f3_local0:registerEventHandler("save_device_selected", CoD.LockOut.FinishOpenMainMenu)
	f3_local0:registerEventHandler("mouseup", CoD.LockOut.MouseUp)
	if f3_arg0 == nil then
		f3_arg0 = UIExpression.GetPrimaryController()
	end
	Engine.SendMenuResponse(f3_arg0, "lockout", "activated")
	local f3_local1 = 720
	local f3_local2 = 1280
	local f3_local3 = 720
	local f3_local4 = f3_local3 * 4
	f3_local0:addElement(CoD.LockOut.CreateImage("menu_sp_press_start_temp", f3_local2, f3_local1, 1))
	local f3_local5 = 350
	local f3_local6 = f3_local5 / 4
	local f3_local7 = -200
	local f3_local8 = -60
	if true == Dvar.wideScreen:get() then
		f3_local7 = -328
		f3_local8 = -45
		f3_local5 = 360
		f3_local6 = f3_local5 / 4
	end
	local f3_local9 = LUI.UIImage.new()
	f3_local9:setLeftRight(false, false, -f3_local5 / 2 + f3_local7, f3_local5 / 2 + f3_local7)
	f3_local9:setTopBottom(false, false, -f3_local6 / 2 + f3_local8, f3_local6 / 2 + f3_local8)
	f3_local9:setImage(RegisterMaterial("logo"))
	f3_local0:addElement(f3_local9)
	f3_local0:addElement(CoD.LockOut.CreateImage("sp_lockout_fogscroll", f3_local4, f3_local3, 0.5))
	f3_local0:addElement(CoD.LockOut.CreateImage("menu_sp_press_start_temp_mid", f3_local2, f3_local1, 1))
	f3_local0:addElement(CoD.LockOut.CreateImage("sp_lockout_fogscrollthin", f3_local4, f3_local3, 0.5))
	f3_local0:addElement(CoD.LockOut.CreateImage("menu_sp_press_start_temp_front", f3_local2, f3_local1, 1))
	f3_local0:addElement(CoD.LockOut.CreateImage("sp_lockout_blur_fogscroll", f3_local4, f3_local3, 0.5))
	local f3_local10 = CoD.textSize[CoD.LockOut.FontName]
	local f3_local11 = 200
	local f3_local12 = -210
	local f3_local13 = 15
	if true == Dvar.wideScreen:get() then
		f3_local12 = 0
		f3_local13 = 35
	end
	local f3_local14 = LUI.UIButton.new()
	f3_local14:setLeftRight(false, false, -f3_local11 / 2 + f3_local12, f3_local11 / 2 + f3_local12)
	if true == Dvar.wideScreen:get() then
		f3_local14:setLeftRight(true, false, f3_local12, f3_local11 + f3_local12)
	end
	f3_local14:setTopBottom(false, false, -f3_local10 / 2 + f3_local13, f3_local10 / 2 + f3_local13)
	f3_local14.actionEventName = "open_main_menu"
	f3_local14:setAlpha(0)
	f3_local14.labelText = LUI.UIText.new()
	f3_local14.labelText:setLeftRight(true, true, 0, 0)
	f3_local14.labelText:setTopBottom(true, false, 0, CoD.textSize[CoD.LockOut.FontName])
	f3_local14.labelText:setFont(CoD.fonts[CoD.LockOut.FontName])
	f3_local14:addElement(f3_local14.labelText)
	f3_local14.labelText:setText(Engine.Localize("PLATFORM_PRESS_START_BUTTON"))
	f3_local14:flicker(0, 1, 0.2, 0.7, 250, 500)
	if not CoD.isWIIU then
		f3_local14:addElement(CoD.ButtonPrompt.new("start", "", f3_local14, "button_action", true))
	end
	f3_local14:setHandleMouse(false)
	f3_local0:addElement(f3_local14)
	local f3_local15 = "Default"
	local f3_local16 = LUI.UIText.new()
	f3_local16:setLeftRight(true, true, 0, 0)
	f3_local16:setTopBottom(false, true, -CoD.textSize[f3_local15], 0)
	f3_local16:setFont(CoD.fonts[f3_local15])
	f3_local16:setAlignment(LUI.Alignment.Center)
	f3_local16:setText(Engine.Localize("MENU_LEGAL_LINE"))
	f3_local0:addElement(f3_local16)
	if CoD.useController then
		f3_local14:processEvent({
			name = "gain_focus"
		})
	end
	f3_local0.PressStartButton = f3_local14
	CoD.Menu.CanHideHud = false
	Engine.ExecNow(f3_arg0, "mapallcontrollersactive")
	return f3_local0
end

CoD.LockOut.CreateImage = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	local f4_local0 = LUI.UIImage.new()
	f4_local0:setLeftRight(false, false, -f4_arg1 / 2, f4_arg1 / 2)
	f4_local0:setTopBottom(false, false, -f4_arg2 / 2, f4_arg2 / 2)
	f4_local0:setImage(RegisterMaterial(f4_arg0))
	f4_local0:setAlpha(f4_arg3)
	return f4_local0
end

CoD.LockOut.MouseUp = function (f5_arg0, f5_arg1)
	f5_arg0.PressStartButton:processEvent({
		name = "button_action",
		controller = f5_arg1.controller
	})
end

