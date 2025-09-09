CoD.Stereoscopic3DConfirmation = {}
CoD.Stereoscopic3DConfirmation.Button_Confirm = function (f1_arg0, f1_arg1)
	Engine.Exec(f1_arg1.controller, "toggle r_stereo3DOn")
end

CoD.Stereoscopic3DConfirmation.DarkBackgound = function (f2_arg0)
	local f2_local0 = LUI.UIImage.new()
	f2_local0:setLeftRight(false, false, -1280, 1280)
	f2_local0:setTopBottom(false, false, -360, 360)
	f2_local0:setRGB(0, 0, 0)
	f2_local0:setAlpha(0.7)
	f2_local0:setPriority(-100)
	f2_arg0:addElement(f2_local0)
end

LUI.createMenu.Stereoscopic3DConfirmation = function (f3_arg0)
	local f3_local0 = nil
	if CoD.isSinglePlayer == true then
		f3_local0 = true
	end
	local f3_local1 = CoD.Menu.NewSmallPopup("Stereoscopic3DConfirmation", f3_local0, 0.75)
	CoD.Stereoscopic3DConfirmation.DarkBackgound(f3_local1)
	f3_local1:addSelectButton()
	f3_local1:addBackButton()
	f3_local1:registerEventHandler("confirm_action", CoD.Stereoscopic3DConfirmation.Button_Confirm)
	f3_local1:registerEventHandler("cancel_action", CoD.Menu.goBack)
	local f3_local2 = 5
	local f3_local3 = LUI.UIText.new()
	f3_local3:setLeftRight(true, true, 0, 0)
	f3_local3:setTopBottom(true, false, f3_local2, f3_local2 + CoD.textSize.Default)
	f3_local3:setFont(CoD.fonts.Default)
	f3_local3:setAlignment(LUI.Alignment.Left)
	f3_local1:addElement(f3_local3)
	if Dvar.r_stereo3DOn:get() then
		f3_local3:setText(Engine.Localize("PLATFORM_3D_OPTION_TITLE_OFF"))
	else
		f3_local3:setText(Engine.Localize("PLATFORM_3D_OPTION_TITLE_ON"))
	end
	local f3_local4 = CoD.ButtonList.new()
	f3_local4:setLeftRight(true, true, 0, 0)
	f3_local4:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10, 0)
	f3_local1:addElement(f3_local4)
	local f3_local5 = Engine.Localize("MENU_CONTINUE_CAPS")
	if CoD.isMultiplayer == true then
		f3_local5 = Engine.Localize("MENU_CONTINUE")
	end
	local f3_local6 = f3_local4:addButton(f3_local5)
	f3_local6:setActionEventName("confirm_action")
	local f3_local7 = Engine.Localize("MENU_CANCEL_CAPS")
	if CoD.isMultiplayer == true then
		f3_local7 = Engine.Localize("MENU_CANCEL")
	end
	local f3_local8 = f3_local4:addButton(f3_local7)
	f3_local8:setActionEventName("cancel_action")
	f3_local8:processEvent({
		name = "gain_focus"
	})
	return f3_local1
end

