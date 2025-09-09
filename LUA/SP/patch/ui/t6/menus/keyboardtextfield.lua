CoD.KeyboardTextField = {}
CoD.KeyboardTextField.HeaderFontName = "Big"
CoD.KeyboardTextField.InputFontName = "Big"
CoD.KeyboardTextField.InputLeft = 5
CoD.KeyboardTextField.CursorAlpha = 0.8
LUI.createMenu.KeyboardTextField = function (f1_arg0)
	local f1_local0 = nil
	if CoD.isSinglePlayer then
		f1_local0 = CoD.Menu.NewSmallPopup("KeyboardTextField", true, 0.9)
	else
		f1_local0 = CoD.Menu.NewSmallPopup("KeyboardTextField")
	end
	f1_local0:setOwner(f1_arg0)
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("ui_keyboard_update", CoD.KeyboardTextField.Update)
	f1_local0:registerEventHandler("ui_keyboard_complete", CoD.KeyboardTextField.Complete)
	f1_local0:registerEventHandler("blink_cursor", CoD.KeyboardTextField.BlinkCursor)
	f1_local0:registerEventHandler("button_prompt_back", CoD.KeyboardTextField.ButtonPromptBack)
	local f1_local1 = CoD.KeyboardTextField.HeaderFontName
	local f1_local2 = CoD.fonts[f1_local1]
	local f1_local3 = CoD.textSize[f1_local1]
	local f1_local4 = 0
	local f1_local5 = 0
	f1_local0.header = LUI.UIText.new()
	f1_local0.header:setLeftRight(true, false, f1_local4, 0)
	f1_local0.header:setTopBottom(true, false, f1_local5, f1_local5 + f1_local3)
	f1_local0.header:setFont(f1_local2)
	f1_local0:addElement(f1_local0.header)
	local f1_local6 = CoD.KeyboardTextField.InputFontName
	local f1_local7 = CoD.fonts[f1_local6]
	local f1_local8 = CoD.textSize[f1_local6]
	local f1_local9 = f1_local5 + f1_local3 + 40
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f1_local4, -f1_local4)
	Widget:setTopBottom(true, false, f1_local9, f1_local9 + f1_local8)
	Widget:setUseStencil(true)
	f1_local0:addElement(Widget)
	f1_local0.inputContainerWidth = CoD.Menu.SmallPopupWidth - f1_local4 * 2 - 15
	local f1_local11 = LUI.UIImage.new()
	f1_local11:setLeftRight(true, true, 0, 0)
	f1_local11:setTopBottom(true, true, 0, 0)
	f1_local11:setRGB(0.5, 0.5, 0.5)
	f1_local11:setAlpha(0.5)
	Widget:addElement(f1_local11)
	local f1_local12 = LUI.UITightText.new()
	f1_local12:setLeftRight(true, false, CoD.KeyboardTextField.InputLeft, 0)
	f1_local12:setTopBottom(true, true, 0, 0)
	f1_local12:setFont(f1_local7)
	f1_local0.inputText = f1_local12
	Widget:addElement(f1_local0.inputText)
	local f1_local13 = LUI.UITightText.new()
	f1_local13:setLeftRight(true, false, CoD.KeyboardTextField.InputLeft, 0)
	f1_local13:setTopBottom(true, true, 0, 0)
	f1_local13:setFont(f1_local7)
	f1_local13:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f1_local13:setAlpha(CoD.KeyboardTextField.CursorAlpha)
	f1_local0.cursorText = f1_local13
	Widget:addElement(f1_local0.cursorText)
	f1_local0.cursor = "|"
	f1_local0.cursorAlpha = CoD.KeyboardTextField.CursorAlpha
	local f1_local14 = f1_local9 + 80
	f1_local0.okButton = CoD.CoD9Button.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local4,
		right = f1_local4 + 100,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local14,
		bottom = f1_local14 + CoD.CoD9Button.Height
	}, "ui_keyboard_complete")
	f1_local0.okButton:setLabel(Engine.Localize("MENU_OK_CAPS"))
	f1_local0:addElement(f1_local0.okButton)
	f1_local0.okButton:processEvent({
		name = "gain_focus"
	})
	f1_local0:addElement(LUI.UITimer.new(500, "blink_cursor", false, f1_local0))
	f1_local0:addElement(LUI.UITimer.new(50, {
		name = "ui_keyboard_update",
		controller = f1_arg0,
		overstrike = false
	}, true, f1_local0))
	return f1_local0
end

CoD.KeyboardTextField.ButtonPromptBack = function (f2_arg0, f2_arg1)
	Engine.Exec(f2_arg1.controller, "ui_keyboard_cancel")
	f2_arg0:goBack(f2_arg1.controller)
end

CoD.KeyboardTextField.BlinkCursor = function (f3_arg0, f3_arg1)
	if f3_arg0.cursorAlpha == 0 then
		f3_arg0.cursorAlpha = CoD.KeyboardTextField.CursorAlpha
	else
		f3_arg0.cursorAlpha = 0
	end
	f3_arg0.cursorText:beginAnimation("cursor_alpha", 0)
	f3_arg0.cursorText:setAlpha(f3_arg0.cursorAlpha)
end

CoD.KeyboardTextField.Complete = function (f4_arg0, f4_arg1)
	Engine.Exec(f4_arg1.controller, "ui_keyboard_complete")
	f4_arg0:goBack(f4_arg1.controller)
end

CoD.KeyboardTextField.Update = function (f5_arg0, f5_arg1)
	local f5_local0 = Dvar.ui_keyboardtitle:get()
	if f5_local0 ~= nil then
		f5_arg0.header:setText(f5_local0)
	end
	local f5_local1 = Dvar.ui_keyboard_dvar_edit:get()
	if f5_local1 ~= nil then
		f5_arg0.inputText:setText(f5_local1)
		local f5_local2 = 0
		if f5_arg1.overstrike then
			f5_arg0.cursor = "_"
		else
			f5_arg0.cursor = "|"
			f5_local2 = -4
		end
		if not f5_arg1.cursorPos then
			f5_arg1.cursorPos = string.len(f5_local1)
		end
		f5_local1 = string.sub(f5_local1, 1, f5_arg1.cursorPos)
		local f5_local3 = CoD.KeyboardTextField.InputFontName
		local f5_local4 = {}
		f5_local4 = GetTextDimensions(f5_local1, CoD.fonts[f5_local3], CoD.textSize[f5_local3])
		f5_arg0.cursorText:setText(f5_arg0.cursor)
		local f5_local5 = f5_local4[3] - f5_arg0.inputContainerWidth
		if f5_local5 > 0 then
			f5_arg0.inputText:setLeftRight(true, false, CoD.KeyboardTextField.InputLeft - f5_local5 - 15, 0)
			f5_arg0.cursorText:setLeftRight(true, false, CoD.KeyboardTextField.InputLeft - f5_local5 - 15 + f5_local4[3] + f5_local2, 0)
		else
			f5_arg0.inputText:setLeftRight(true, false, CoD.KeyboardTextField.InputLeft, 0)
			f5_arg0.cursorText:setLeftRight(true, false, CoD.KeyboardTextField.InputLeft + f5_local4[3] + f5_local2, 0)
		end
	end
end

