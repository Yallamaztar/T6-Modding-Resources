CoD.DrcOptionElement = {}
CoD.DrcOptionElement.Height = 96
CoD.DrcOptionElement.TextHeight = 40
CoD.DrcOptionElement.HorizontalGap = 300
CoD.DrcOptionElement.HighlightColor = {
	red = 1,
	green = 0.4,
	blue = 0,
	alpha = 1
}
CoD.DrcOptionElement.DefaultColor = {
	red = CoD.offWhite.r,
	green = CoD.offWhite.g,
	blue = CoD.offWhite.b,
	alpha = 1
}
CoD.DrcOptionElement.SetupTextElement = function (f1_arg0)
	f1_arg0:registerAnimationState("highlight", CoD.DrcOptionElement.HighlightColor)
	f1_arg0:registerAnimationState("default", CoD.DrcOptionElement.DefaultColor)
end

CoD.DrcOptionElement.GainFocus = function (f2_arg0, f2_arg1)
	LUI.UIElement.gainFocus(f2_arg0, f2_arg1)
	f2_arg0.label:animateToState("highlight")
end

CoD.DrcOptionElement.LoseFocus = function (f3_arg0, f3_arg1)
	LUI.UIElement.loseFocus(f3_arg0, f3_arg1)
	f3_arg0.label:animateToState("default")
end

CoD.DrcOptionElement.new = function (f4_arg0, f4_arg1, f4_arg2)
	local Widget = LUI.UIElement.new(f4_arg2)
	Widget:makeFocusable()
	if f4_arg1 == nil then
		f4_arg1 = CoD.DrcOptionElement.HorizontalGap
	end
	Widget.horizontalGap = f4_arg1
	Widget.horizontalList = LUI.UIHorizontalList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	Widget:addElement(Widget.horizontalList)
	Widget.label = LUI.UIText.new()
	Widget.label:setLeftRight(true, false, 0, f4_arg1)
	Widget.label:setTopBottom(false, false, -CoD.DrcOptionElement.TextHeight / 2, CoD.DrcOptionElement.TextHeight / 2)
	Widget.label:setFont(CoD.fonts.Condensed)
	Widget.label:setRGB(CoD.DrcOptionElement.DefaultColor.red, CoD.DrcOptionElement.DefaultColor.green, CoD.DrcOptionElement.DefaultColor.blue)
	CoD.DrcOptionElement.SetupTextElement(Widget.label)
	Widget.horizontalList:addElement(Widget.label)
	Widget.label:setText(f4_arg0)
	Widget:registerEventHandler("gain_focus", CoD.DrcOptionElement.GainFocus)
	Widget:registerEventHandler("lose_focus", CoD.DrcOptionElement.LoseFocus)
	return Widget
end

