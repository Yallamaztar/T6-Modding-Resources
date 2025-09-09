CoD.ConfirmDefaultWeapons = {}
LUI.createMenu.ConfirmDefaultWeapons = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.Menu.NewSmallPopup("ConfirmDefaultWeapons", true)
	f1_local0:registerEventHandler("confirm_default", CoD.ConfirmDefaultWeapons.ConfirmRequest)
	f1_local0:registerEventHandler("cancel_request", CoD.ConfirmDefaultWeapons.CancelRequest)
	f1_local0.background = CoD.ConfirmDefaultWeapons.CreateBlackBackground(f1_arg1.loadout)
	local f1_local1 = 0
	local f1_local2 = "Default"
	f1_local0.title = LUI.UIText.new()
	f1_local0.title:setLeftRight(true, true, 0, 0)
	f1_local0.title:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize[f1_local2])
	f1_local0.title:setFont(CoD.fonts[f1_local2])
	f1_local0.title:setAlignment(LUI.Alignment.Left)
	f1_local0:addElement(f1_local0.title)
	f1_local1 = f1_local1 + CoD.textSize[f1_local2] + CoD.textSize[f1_local2] * 0.5
	f1_local0.title:setText(Engine.Localize("MENU_DEFAULT_WEAPONS_Q"))
	f1_local0.text = LUI.UIText.new()
	f1_local0.text:setLeftRight(true, true, 0, 0)
	f1_local0.text:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize[f1_local2])
	f1_local0.text:setFont(CoD.fonts[f1_local2])
	f1_local0.text:setAlignment(LUI.Alignment.Left)
	f1_local0:addElement(f1_local0.text)
	f1_local0.text:setText(Engine.Localize("MENU_DEFAULT_WEAPONS_TEXT"))
	local f1_local3 = CoD.ButtonList.new()
	f1_local3:setLeftRight(true, true, 0, 0)
	f1_local3:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 2 - 21, -15)
	f1_local0:addElement(f1_local3)
	local f1_local4 = f1_local3:addButton(Engine.Localize("MENU_CANCEL_CAPS"))
	f1_local4:setActionEventName("cancel_request")
	local f1_local5 = f1_local3:addButton(Engine.Localize("MENU_CONFIRM_CAPS"))
	f1_local5:setActionEventName("confirm_default")
	f1_local4:processEvent({
		name = "gain_focus"
	})
	if f1_arg1 ~= nil then
		f1_local0.loadout = f1_arg1.loadout
	end
	f1_local0.close = CoD.ConfirmDefaultWeapons.CloseBackground
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	return f1_local0
end

CoD.ConfirmDefaultWeapons.ConfirmRequest = function (f2_arg0, f2_arg1)
	CoD.CACLoadOutMenu.RestoreDefaults()
	if f2_arg0.loadout ~= nil then
		f2_arg0.loadout.loadoutUI:update(f2_arg1.controller)
	end
	f2_arg0:goBack(f2_arg1.controller)
end

CoD.ConfirmDefaultWeapons.CancelRequest = function (f3_arg0, f3_arg1)
	f3_arg0:goBack(f3_arg1.controller)
end

CoD.ConfirmDefaultWeapons.CloseBackground = function (f4_arg0)
	f4_arg0.background:close()
	CoD.Menu.close(f4_arg0)
end

CoD.ConfirmDefaultWeapons.CreateBlackBackground = function (f5_arg0)
	local f5_local0 = 720
	local f5_local1 = f5_local0 * Engine.GetAspectRatio()
	local f5_local2 = LUI.UIImage.new()
	f5_local2:setLeftRight(false, false, -f5_local1 / 2, f5_local1 / 2)
	f5_local2:setTopBottom(false, false, -f5_local0 / 2, f5_local0 / 2)
	f5_local2:setRGB(0, 0, 0)
	f5_local2:setAlpha(0.5)
	f5_arg0:addElement(f5_local2)
	return f5_local2
end

