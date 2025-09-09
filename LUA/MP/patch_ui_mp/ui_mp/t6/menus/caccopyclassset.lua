CoD.CopyClassSet = {}
LUI.createMenu.CopyClassSet = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("CopyClassSet", nil, nil, CoD.Menu.SmallPopupWidth, CoD.Menu.SmallPopupHeight + 8 * CoD.CoD9Button.Height)
	f1_local0:setOwner(f1_arg0)
	f1_local0:registerEventHandler("copy_class_set", CoD.CopyClassSet.Copy)
	f1_local0:registerEventHandler("purchase_class_sets", CoD.CopyClassSet.PurchaseClassSets)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	local f1_local1 = CoD.fonts.Condensed
	local f1_local2 = CoD.textSize.Condensed
	local f1_local3 = 0
	local f1_local4 = 0
	f1_local0.header = LUI.UIText.new()
	f1_local0.header:setLeftRight(true, true, 0, 0)
	f1_local0.header:setTopBottom(true, false, 0, f1_local2)
	f1_local0.header:setFont(f1_local1)
	f1_local0.header:setAlignment(LUI.Alignment.Left)
	f1_local0:addElement(f1_local0.header)
	local f1_local5 = Engine.GetCurrentClassSetIndex(f1_arg0)
	local f1_local6 = Engine.GetClassSetName(f1_arg0, f1_local5)
	f1_local0.header:setText(Engine.Localize("MPUI_COPY_CLASS_TITLE", f1_local6))
	f1_local0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 14 - 5,
		bottom = 0
	})
	f1_local0:addElement(f1_local0.buttonList)
	local f1_local7 = Dvar.tu8_purchasedClassSetCount:get()
	local f1_local8 = Engine.GetNumberOfClassSetsOwned(f1_arg0)
	local f1_local9 = Engine.Localize("MENU_CLASS_SET_OPTIONS1", f1_local6)
	f1_local0.buttons = {}
	for f1_local10 = 0, f1_local7 - 1, 1 do
		local f1_local13 = f1_local0.buttonList:addButton(Engine.GetClassSetName(f1_arg0, f1_local10))
		f1_local13.classSetIndex = f1_local10
		f1_local13:setActionEventName("copy_class_set")
		table.insert(f1_local0.buttons, f1_local13)
		if f1_local10 == f1_local5 then
			f1_local13:disable()
		elseif f1_local8 <= f1_local10 then
			f1_local13.downloadImage = LUI.UIImage.new()
			f1_local13.downloadImage:setLeftRight(false, true, -CoD.CoD9Button.Height, -6)
			f1_local13.downloadImage:setTopBottom(true, true, 3, -3)
			f1_local13.downloadImage:setImage(RegisterMaterial("menu_purchase_unlock_token_64"))
			f1_local13:addElement(f1_local13.downloadImage)
			f1_local13:setActionEventName("purchase_class_sets")
			f1_local13:setActionPromptString(Engine.Localize("MENU_PURCHASE"))
		end
		f1_local13.hintText = f1_local9
	end
	f1_local0.buttons[1]:processEvent({
		name = "gain_focus"
	})
	return f1_local0
end

CoD.CopyClassSet.Copy = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.button.classSetIndex
	Engine.CopyToClassSet(f2_arg1.controller, f2_local0)
	local f2_local1 = f2_arg0.occludedMenu
	f2_arg0:goBack(f2_arg1.controller)
	f2_local1:processEvent({
		name = "class_set_copied",
		classSetIndex = f2_local0
	})
end

CoD.CopyClassSet.PurchaseClassSets = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg0.occludedMenu
	f3_arg0:goBack(f3_arg1.controller)
	f3_local0:processEvent(f3_arg1)
end

