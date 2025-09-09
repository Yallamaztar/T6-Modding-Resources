CoD.CopyClass = {}
LUI.createMenu.CopyClass = function (f1_arg0)
	local f1_local0 = CoD.Menu.SmallPopupHeight
	local f1_local1 = Engine.GetCustomClassCount(f1_arg0)
	if f1_local1 == nil then
		f1_local1 = 5
	end
	if f1_local1 > 5 then
		f1_local0 = f1_local0 + (f1_local1 - 5) * CoD.CoD9Button.Height
	end
	local f1_local2 = CoD.Menu.NewSmallPopup("CopyClass", nil, nil, CoD.Menu.SmallPopupWidth, f1_local0)
	f1_local2:setOwner(f1_arg0)
	f1_local2:registerEventHandler("copy_class", CoD.CopyClass.Copy)
	f1_local2:addSelectButton()
	f1_local2:addBackButton()
	local f1_local3 = CoD.fonts.Condensed
	local f1_local4 = CoD.textSize.Condensed
	local f1_local5 = 0
	local f1_local6 = 0
	f1_local2.header = LUI.UIText.new()
	f1_local2.header:setLeftRight(true, true, 0, 0)
	f1_local2.header:setTopBottom(true, false, 0, f1_local4)
	f1_local2.header:setFont(f1_local3)
	f1_local2.header:setAlignment(LUI.Alignment.Left)
	f1_local2:addElement(f1_local2.header)
	f1_local2.classNum = CoD.perController[f1_arg0].classNum
	local f1_local7 = CoD.CACUtility.GetLoadoutNameFromIndex(f1_arg0, f1_local2.classNum)
	f1_local2.header:setText(Engine.Localize("MPUI_COPY_CLASS_TITLE", f1_local7:get()))
	f1_local2.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * (f1_local1 + 1) - 5,
		bottom = 0
	})
	f1_local2:addElement(f1_local2.buttonList)
	f1_local2.buttons = {}
	for f1_local8 = 1, f1_local1, 1 do
		local f1_local11 = f1_local8 - 1
		local f1_local12 = CoD.CACUtility.GetLoadoutNameFromIndex(f1_arg0, f1_local11)
		local f1_local13 = f1_local2.buttonList:addButton(Engine.Localize(f1_local12:get()), nil, f1_local11)
		f1_local13.classNum = f1_local11
		f1_local13:setActionEventName("copy_class")
		f1_local2.buttons[f1_local8] = f1_local13
		if f1_local11 == f1_local2.classNum then
			f1_local13:disable()
		end
	end
	f1_local2.buttons[1]:processEvent({
		name = "gain_focus"
	})
	return f1_local2
end

CoD.CopyClass.Copy = function (f2_arg0, f2_arg1)
	Engine.ExecNow(f2_arg1.controller, "copyClass " .. f2_arg0.classNum .. " " .. f2_arg1.button.classNum)
	local f2_local0 = f2_arg0.occludedMenu
	f2_local0:processEvent({
		name = "update_class_buttons"
	})
	f2_arg0:goBack(f2_arg1.controller)
	f2_local0:processEvent({
		name = "class_copied"
	})
end

