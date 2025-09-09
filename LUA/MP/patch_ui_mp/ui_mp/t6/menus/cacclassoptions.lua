require("T6.Menus.CACCopyClass")
require("T6.Menus.CACResetClass")
CoD.ClassOptions = {}
LUI.createMenu.ClassOptions = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("ClassOptions", nil, nil, CoD.Menu.SmallPopupWidth, CoD.Menu.SmallPopupHeight + 15)
	f1_local0:setOwner(f1_arg0)
	f1_local0:registerEventHandler("rename_class", CoD.ClassOptions.RenameClass)
	f1_local0:registerEventHandler("ui_keyboard_input", CoD.ClassOptions.Renamed)
	f1_local0:registerEventHandler("open_copy_class", CoD.ClassOptions.OpenCopyClass)
	f1_local0:registerEventHandler("clear_class", CoD.ClassOptions.Clear)
	f1_local0:registerEventHandler("update_class_buttons", CoD.ClassOptions.UpdateClassButtons)
	f1_local0:registerEventHandler("open_reset_class", CoD.ClassOptions.OpenResetClass)
	f1_local0:registerEventHandler("update_class_preview", CoD.ClassOptions.UpdateClassPreview)
	f1_local0:registerEventHandler("class_reset", CoD.ClassOptions.ButtonPromptBack)
	f1_local0:registerEventHandler("class_copied", CoD.ClassOptions.ButtonPromptBack)
	f1_local0:registerEventHandler("button_prompt_back", CoD.ClassOptions.ButtonPromptBack)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	local f1_local1 = CoD.fonts.Big
	local f1_local2 = CoD.textSize.Big
	local f1_local3 = 0
	local f1_local4 = 0
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
	f1_local0:addElement(f1_local0.header)
	f1_local0.classNum = CoD.perController[f1_arg0].classNum
	local f1_local5 = CoD.CACUtility.GetLoadoutNameFromIndex(f1_arg0, f1_local0.classNum)
	f1_local5 = f1_local5:get()
	f1_local0.header:setText(UIExpression.ToUpper(f1_arg0, Engine.Localize("MENU_CLASS_OPTIONS")))
	local f1_local6 = LUI.UIText.new()
	f1_local6:setLeftRight(true, false, f1_local3, 0)
	f1_local6:setTopBottom(true, false, f1_local4 + f1_local2, f1_local4 + f1_local2 + CoD.textSize.Default)
	f1_local6:setFont(CoD.fonts.Default)
	f1_local6:setText(Engine.Localize(f1_local5))
	f1_local6:setAlpha(0.5)
	f1_local0:addElement(f1_local6)
	local f1_local7 = f1_local3
	f1_local0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = f1_local7,
		right = -f1_local7,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local4 + f1_local2 + CoD.textSize.Default + 20,
		bottom = 0
	})
	f1_local0:addElement(f1_local0.buttonList)
	f1_local0.renameButton = f1_local0.buttonList:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_RENAME")))
	f1_local0.renameButton:setActionEventName("rename_class")
	f1_local0.copyButton = f1_local0.buttonList:addButton(Engine.Localize("MENU_COPY_CAPS"))
	f1_local0.copyButton:setActionEventName("open_copy_class")
	f1_local0.resetButton = f1_local0.buttonList:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_RESET_TO_DEFAULT")))
	f1_local0.resetButton:setActionEventName("open_reset_class")
	f1_local0.clearButton = f1_local0.buttonList:addButton(Engine.Localize("MENU_CLEAR_LOADOUT_CAPS"))
	f1_local0.clearButton:setActionEventName("clear_class")
	f1_local0.renameButton:processEvent({
		name = "gain_focus"
	})
	Engine.PlaySound("cac_loadout_edit_sel")
	return f1_local0
end

CoD.ClassOptions.RenameClass = function (f2_arg0, f2_arg1)
	local f2_local0 = CoD.CACUtility.GetLoadoutNameFromIndex(f2_arg1.controller, f2_arg0.classNum)
	f2_local0 = f2_local0:get()
	Engine.Exec(f2_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_CUSTOM_CLASS)
end

CoD.ClassOptions.ButtonPromptBack = function (f3_arg0, f3_arg1)
	CoD.Menu.ButtonPromptBack(f3_arg0, f3_arg1)
end

CoD.ClassOptions.Renamed = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.m_ownerController
	local f4_local1 = f4_arg1.input
	local f4_local2 = CoD.perController[f4_local0].classNum
	if f4_local1 ~= nil then
		local f4_local3 = CoD.CACUtility.GetLoadoutNameFromIndex(f4_local0, f4_local2)
		f4_local3:set(f4_local1)
		f4_arg0.header:setText(f4_local1)
		f4_arg0.occludedMenu:processEvent({
			name = "update_class_buttons",
			classNum = f4_local2
		})
		f4_arg0:goBack(f4_arg1.controller)
	end
end

CoD.ClassOptions.OpenCopyClass = function (f5_arg0, f5_arg1)
	f5_arg0:openPopup("CopyClass", f5_arg1.controller)
end

CoD.ClassOptions.UpdateClassButtons = function (f6_arg0, f6_arg1)
	f6_arg0.occludedMenu:processEvent({
		name = "update_class_buttons",
		classNum = f6_arg0.classNum
	})
end

CoD.ClassOptions.OpenResetClass = function (f7_arg0, f7_arg1)
	f7_arg0:openPopup("ResetClass", f7_arg1.controller)
end

CoD.ClassOptions.UpdateClassPreview = function (f8_arg0, f8_arg1)
	f8_arg0.occludedMenu:processEvent({
		name = "update_class_preview",
		classNum = f8_arg0.classNum
	})
end

CoD.ClassOptions.Clear = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg1.controller
	local f9_local1 = CoD.perController[f9_local0].classNum
	CoD.SetClassItem(f9_local0, f9_local1, "primary", 0)
	CoD.SetClassItem(f9_local0, f9_local1, "secondary", 0)
	CoD.SetClassItem(f9_local0, f9_local1, CoD.CACUtility.loadoutSlotNames.primaryGrenade, 0)
	CoD.SetClassItem(f9_local0, f9_local1, CoD.CACUtility.loadoutSlotNames.specialGrenade, 0)
	CoD.SetClassItem(f9_local0, f9_local1, CoD.CACUtility.loadoutSlotNames.primaryGrenade .. "count", 0)
	CoD.SetClassItem(f9_local0, f9_local1, CoD.CACUtility.loadoutSlotNames.specialGrenade .. "count", 0)
	for f9_local2 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
		CoD.SetClassItem(f9_local0, f9_local1, "specialty" .. f9_local2, 0)
	end
	for f9_local2 = 1, CoD.CACUtility.maxBonusCards, 1 do
		CoD.SetClassItem(f9_local0, f9_local1, "bonuscard" .. f9_local2, 0)
	end
	f9_arg0.occludedMenu:processEvent({
		name = "update_class_preview",
		classNum = f9_local1
	})
	f9_arg0:processEvent({
		name = "button_prompt_back",
		controller = f9_local0
	})
end

