CoD.ResetClass = {}
LUI.createMenu.ResetClass = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("ResetClass")
	f1_local0:setOwner(f1_arg0)
	f1_local0:registerEventHandler("reset_class", CoD.ResetClass.Reset)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	local f1_local1 = CoD.fonts.Condensed
	local f1_local2 = CoD.textSize.Condensed
	local f1_local3 = 0
	local f1_local4 = 5
	f1_local0.header = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local3,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local4,
		bottom = f1_local4 + f1_local2,
		font = f1_local1
	})
	f1_local0.header:setLeftRight(true, true, 0, 0)
	f1_local0.header:setTopBottom(true, false, f1_local4, f1_local4 + f1_local2)
	f1_local0.header:setFont(f1_local1)
	f1_local0.header:setAlignment(LUI.Alignment.Left)
	f1_local0:addElement(f1_local0.header)
	f1_local0.classNum = CoD.perController[f1_arg0].classNum
	f1_local0.header:setText(Engine.Localize("MENU_WHICH_DEFAULT_CLASS"))
	f1_local0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * (CoD.CACUtility.maxDefaultClass + 1) + 5,
		bottom = 0
	})
	f1_local0:addElement(f1_local0.buttonList)
	f1_local0.buttons = {}
	for f1_local5 = 1, CoD.CACUtility.maxDefaultClass, 1 do
		local f1_local8, f1_local9 = nil
		if CoD.perController[f1_arg0].isPreset then
			f1_local8 = Engine.GetDefaultClassName(f1_local5 - 1)
			f1_local9 = f1_local8
		else
			f1_local8 = CoD.CACUtility.GetDefaultLoadoutNameFromIndex(f1_local5)
			f1_local9 = "CLASS_SLOT" .. f1_local5
		end
		local f1_local10 = f1_local0.buttonList:addButton(Engine.Localize(f1_local9))
		f1_local10.className = f1_local8
		f1_local10.classText = f1_local9
		f1_local10:setActionEventName("reset_class")
		f1_local0.buttons[f1_local5] = f1_local10
	end
	f1_local0.buttons[1]:processEvent({
		name = "gain_focus"
	})
	return f1_local0
end

CoD.ResetClass.Reset = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.classNum
	Engine.ExecNow(f2_arg1.controller, "uiEquipDefaultClass " .. f2_local0 .. " " .. f2_arg1.button.className)
	local f2_local1 = CoD.CACUtility.GetLoadoutNameFromIndex(f2_arg1.controller, f2_local0)
	f2_local1:set(Engine.Localize(f2_arg1.button.classText))
	f2_local1 = f2_arg0.occludedMenu
	f2_local1:processEvent({
		name = "update_class_preview"
	})
	f2_local1:processEvent({
		name = "update_class_buttons"
	})
	f2_arg0:goBack(f2_arg1.controller)
	f2_local1:processEvent({
		name = "class_reset"
	})
end

