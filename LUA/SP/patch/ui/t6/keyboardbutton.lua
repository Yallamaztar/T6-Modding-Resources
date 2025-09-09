CoD.KeyboardButton = {}
CoD.KeyboardButton.TextHeight = 2.5 * CoD.textSize.Condensed
CoD.KeyboardButton.SetLabel = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	f1_arg0.id = "KeyboardButton." .. f1_arg1
	f1_arg0.label:setText(f1_arg1)
end

CoD.KeyboardButton.GainFocus = function (f2_arg0, f2_arg1)
	LUI.UIButton.gainFocus(f2_arg0, f2_arg1)
	f2_arg0.label:animateToState("selected", CoD.KeyboardButton.ButtonOverAnimTime)
	f2_arg0.background:animateToState("selected", CoD.KeyboardButton.ButtonOverAnimTime)
end

CoD.KeyboardButton.LoseFocus = function (f3_arg0, f3_arg1)
	LUI.UIButton.loseFocus(f3_arg0, f3_arg1)
	f3_arg0.label:animateToState("default", CoD.KeyboardButton.ButtonOverAnimTime)
	f3_arg0.background:animateToState("default", CoD.KeyboardButton.ButtonOverAnimTime)
end

CoD.KeyboardButton.SetupTextElement = function (f4_arg0)
	f4_arg0:registerAnimationState("selected", {
		alpha = 1
	})
	LUI.UIButton.SetupElement(f4_arg0)
end

CoD.KeyboardButton.Pressed = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.def[1 + f5_arg0.showIndex]
	if f5_local0 == nil then
		f5_local0 = f5_arg0.def[1]
	end
	f5_arg0.keyboardMenu:processEvent({
		name = f5_arg0.keyActionEvent,
		key = f5_local0
	})
end

CoD.KeyboardButton.PressedAnimationComplete = function (f6_arg0)
	f6_arg0:animateToState("selected", 250)
end

CoD.KeyboardButton.IndexLabel = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg0.def[f7_arg1 + 1]
	if f7_local0 ~= nil then
		f7_arg0:setLabel(f7_local0)
		f7_arg0.showIndex = f7_arg1
	end
end

CoD.KeyboardButton.new = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4, f8_arg5)
	if f8_arg0.width ~= nil then
		f8_arg1.right = f8_arg1.right + f8_arg0.width[f8_arg4]
	end
	local f8_local0 = LUI.UIButton.new(f8_arg1, f8_arg3)
	f8_local0.keyboardMenu = f8_arg2
	f8_local0.def = f8_arg0
	f8_local0.showIndex = 0
	f8_local0.setLabel = CoD.KeyboardButton.SetLabel
	f8_local0.indexLabel = CoD.KeyboardButton.IndexLabel
	f8_local0:registerEventHandler("gain_focus", CoD.KeyboardButton.GainFocus)
	f8_local0:registerEventHandler("lose_focus", CoD.KeyboardButton.LoseFocus)
	f8_local0.container = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	f8_local0:addElement(f8_local0.container)
	local f8_local1 = 7
	local f8_local2 = 8
	f8_local0.background = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = f8_local1,
		right = -f8_local1,
		topAnchor = true,
		bottomAnchor = true,
		top = f8_local2,
		bottom = -f8_local2,
		red = 0.6,
		green = 0.6,
		blue = 0.6,
		alpha = 0.95
	})
	f8_local0.background:registerAnimationState("selected", {
		red = 0.9,
		blue = 0.9,
		green = 0.9,
		alpha = 1
	})
	f8_local0.background:registerAnimationState("pressed", {
		red = 0.9,
		blue = 0,
		green = 0,
		alpha = 1
	})
	f8_local0.background:registerEventHandler("transition_complete_pressed", CoD.KeyboardButton.PressedAnimationComplete)
	LUI.UIButton.SetupElement(f8_local0.background)
	f8_local0.container:addElement(f8_local0.background)
	local f8_local3 = "Condensed"
	local f8_local4 = f8_arg0[1]
	local f8_local5, f8_local6, f8_local7, f8_local8 = GetTextDimensions(f8_local4, CoD.fonts[f8_local3], CoD.textSize[f8_local3])
	local f8_local9 = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f8_local7 / 2,
		right = f8_local7 / 2,
		top = -f8_arg5 / 2,
		bottom = f8_arg5 / 2,
		topAnchor = false,
		bottomAnchor = false,
		alpha = 0.5,
		font = CoD.fonts.Condensed,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.5
	})
	f8_local0.label = f8_local9
	f8_local9:registerAnimationState("selected", {
		red = 0,
		green = 0,
		blue = 0,
		alpha = 1
	})
	LUI.UIButton.SetupElement(f8_local9)
	f8_local0:addElement(f8_local9)
	f8_local0:setLabel(f8_local4)
	return f8_local0
end

