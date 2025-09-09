require("T6.Menus.CACCopyClassSet")
CoD.ClassSetOptions = {}
LUI.createMenu.ClassSetOptions = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("ClassSetOptions")
	f1_local0:setOwner(f1_arg0)
	f1_local0:registerEventHandler("rename_class_set", CoD.ClassSetOptions.RenameClassSet)
	f1_local0:registerEventHandler("ui_keyboard_input", CoD.ClassSetOptions.Renamed)
	f1_local0:registerEventHandler("open_copy_class_set", CoD.ClassSetOptions.OpenCopyClassSet)
	f1_local0:registerEventHandler("class_set_copied", CoD.ClassSetOptions.ClassSetCopied)
	f1_local0:registerEventHandler("purchase_class_sets", CoD.ClassSetOptions.PurchaseClassSets)
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
	local f1_local5 = Engine.GetCurrentClassSetIndex(f1_arg0)
	f1_local0.header:setText(UIExpression.ToUpper(f1_arg0, Engine.Localize("MENU_CLASS_SET_OPTIONS")))
	local f1_local6 = LUI.UIText.new()
	f1_local6:setLeftRight(true, false, f1_local3, 0)
	f1_local6:setTopBottom(true, false, f1_local4 + f1_local2, f1_local4 + f1_local2 + CoD.textSize.Default)
	f1_local6:setFont(CoD.fonts.Default)
	f1_local6:setText(Engine.GetClassSetName(f1_arg0, f1_local5))
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
	f1_local0.renameButton:setActionEventName("rename_class_set")
	f1_local0.copyButton = f1_local0.buttonList:addButton(Engine.Localize("MENU_COPY_CAPS"))
	f1_local0.copyButton:setActionEventName("open_copy_class_set")
	f1_local0.renameButton:processEvent({
		name = "gain_focus"
	})
	Engine.PlaySound("cac_loadout_edit_sel")
	return f1_local0
end

CoD.ClassSetOptions.ClassSetCopied = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.occludedMenu
	CoD.Menu.ButtonPromptBack(f2_arg0, f2_arg1)
	if f2_local0 then
		f2_local0:processEvent(f2_arg1)
	end
end

CoD.ClassSetOptions.RenameClassSet = function (f3_arg0, f3_arg1)
	Engine.Exec(f3_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_CLASS_SET)
end

CoD.ClassSetOptions.Renamed = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0:getOwner()
	local f4_local1 = f4_arg1.input
	if f4_local1 then
		Engine.SetClassSetName(f4_local0, Engine.GetCurrentClassSetIndex(f4_local0), f4_local1)
		f4_arg0.occludedMenu:processEvent({
			name = "update_class_set_header",
			controller = f4_local0
		})
		f4_arg0:goBack(f4_local0)
	end
end

CoD.ClassSetOptions.OpenCopyClassSet = function (f5_arg0, f5_arg1)
	f5_arg0:openPopup("CopyClassSet", f5_arg1.controller)
end

CoD.ClassSetOptions.PurchaseClassSets = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0.occludedMenu
	f6_arg0:goBack(f6_arg1.controller)
	f6_local0:processEvent(f6_arg1)
end

