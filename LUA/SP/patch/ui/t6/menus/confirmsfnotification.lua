CoD.ConfirmSFNotification = {}
LUI.createMenu.ConfirmSFNotification = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.Menu.NewSmallPopup("ConfirmSFNotification", true)
	f1_local0:registerEventHandler("confirm_request", CoD.ConfirmSFNotification.ConfirmRequest)
	f1_local0:registerEventHandler("input_source_changed", CoD.ConfirmSFNotification.InputSourceChanged)
	local f1_local1 = 0
	local f1_local2 = "Default"
	f1_local0.title = LUI.UIText.new()
	f1_local0.title:setLeftRight(true, true, 0, 0)
	f1_local0.title:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize[f1_local2])
	f1_local0.title:setFont(CoD.fonts[f1_local2])
	f1_local0.title:setAlignment(LUI.Alignment.Left)
	f1_local0:addElement(f1_local0.title)
	if CoD.useController and Engine.LastInput_Gamepad() then
		f1_local0.title:setText(Engine.Localize("MENU_SFNOTIFICATION_CAPS"))
	else
		f1_local0.title:setText(Engine.Localize("MENU_SFNOTIFICATION_CAPS_KEYBOARD"))
	end
	f1_local0:addSelectButton()
	local f1_local3 = CoD.ButtonList.new()
	f1_local3:setLeftRight(true, true, 0, 0)
	f1_local3:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height - 21, -15)
	f1_local0:addElement(f1_local3)
	local f1_local4 = f1_local3:addButton(Engine.Localize("MENU_CONFIRM_CAPS"))
	f1_local4:setActionEventName("confirm_request")
	f1_local3:processEvent({
		name = "gain_focus"
	})
	return f1_local0
end

CoD.ConfirmSFNotification.ConfirmRequest = function (f2_arg0, f2_arg1)
	f2_arg0:goBack(f2_arg1.controller)
	f2_arg0.occludedMenu:processEvent({
		name = "open_sf_available_popup"
	})
end

CoD.ConfirmSFNotification.InputSourceChanged = function (f3_arg0, f3_arg1)
	if CoD.useMouse then
		if CoD.useController and f3_arg1.source == 0 then
			f3_arg0.title:setText(Engine.Localize("MENU_SFNOTIFICATION_CAPS"))
		else
			f3_arg0.title:setText(Engine.Localize("MENU_SFNOTIFICATION_CAPS_KEYBOARD"))
		end
	end
end

