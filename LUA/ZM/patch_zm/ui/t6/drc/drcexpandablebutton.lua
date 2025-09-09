require("T6.Drc.DrcProfileDiscreteLeftRightSlider")
require("T6.Drc.DrcProfileToggle")
require("T6.Drc.DrcRadioButtonList")
require("T6.BorderFrame")
CoD.DrcExpandableButton = {}
CoD.DrcExpandableButton.ButtonHeight = 112
CoD.DrcExpandableButton.TextItemWidth = 1000
CoD.DrcExpandableButton.TextHeight = CoD.DrcOptionElement.TextHeight
CoD.DrcExpandableButton.ButtonIconSize = 88
CoD.DrcExpandableButton.ItemLeft = 32
CoD.DrcExpandableButton.ButtonIconMaterial = RegisterMaterial("wiiu_drc_expandable_button")
CoD.DrcExpandableButton.ResizeAnimateTime = 200
CoD.DrcExpandableButton.HintTextHeight = 32
CoD.DrcExpandableButton.HintTextBoxHeight = CoD.DrcExpandableButton.HintTextHeight * 3
CoD.DrcExpandableButton.TapDistThreshold = 16
CoD.DrcExpandableButton.Control_HintTextListener_GainFocus = function (f1_arg0, f1_arg1)
	local f1_local0 = f1_arg0:getParent()
	local f1_local1 = f1_local0.hintTextOwner
	if f1_local1 ~= nil and f1_local1.hintText ~= nil then
		if f1_local0.hintText ~= nil then
			f1_local1.hintText:updateText(f1_local0.hintText)
		else
			f1_local1.hintText:removeText()
		end
	end
end

CoD.DrcExpandableButton.Control_HintTextListener_LoseFocus = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0:getParent()
	local f2_local1 = f2_local0.hintTextOwner
	if f2_local1 ~= nil and f2_local1.hintText ~= nil then
		f2_local1.hintText:removeText()
	end
end

CoD.DrcExpandableButton.AssociateHintTextListenerToButton = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	InstanceRef:addElement(Widget)
	InstanceRef.hintTextOwner = HudRef
	Widget:registerEventHandler("gain_focus", CoD.DrcExpandableButton.Control_HintTextListener_GainFocus)
	Widget:registerEventHandler("lose_focus", CoD.DrcExpandableButton.Control_HintTextListener_LoseFocus)
end

CoD.DrcExpandableButton.AddDiscreteLeftRightSlider = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6)
	local f4_local0 = CoD.DrcDiscreteLeftRightSlider.new(f4_arg1, f4_arg5, nil, f4_arg2, f4_arg3, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.DrcOptionElement.Height
	})
	f4_local0.hintText = f4_arg4
	f4_local0:setPriority(f4_arg6)
	f4_arg0:addElement(f4_local0)
	CoD.DrcExpandableButton.AssociateHintTextListenerToButton(f4_arg0, f4_local0)
	return f4_local0
end

CoD.DrcExpandableButton.AddProfileDiscreteLeftRightSlider = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5, f5_arg6, f5_arg7, f5_arg8, f5_arg9, f5_arg10)
	local f5_local0 = CoD.DrcProfileDiscreteLeftRightSlider.new(f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5, f5_arg7, f5_arg8, f5_arg9, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.DrcOptionElement.Height
	})
	f5_local0.hintText = f5_arg6
	f5_local0:setPriority(f5_arg10)
	f5_arg0:addElement(f5_local0)
	CoD.DrcExpandableButton.AssociateHintTextListenerToButton(f5_arg0, f5_local0)
	return f5_local0
end

CoD.DrcExpandableButton.AddProfileToggle = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5, f6_arg6)
	local f6_local0 = CoD.DrcProfileToggle.new(f6_arg1, f6_arg2, f6_arg3, f6_arg5, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.DrcOptionElement.Height
	})
	f6_local0.hintText = f6_arg4
	f6_local0:setPriority(f6_arg6)
	f6_arg0:addElement(f6_local0)
	CoD.DrcExpandableButton.AssociateHintTextListenerToButton(f6_arg0, f6_local0)
	return f6_local0
end

CoD.DrcExpandableButton.AddRadioButtonList = function (f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = CoD.DrcRadioButtonList.new(f7_arg1, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	f7_local0.hintText = f7_arg0.hintText
	f7_local0:setPriority(f7_arg2)
	f7_arg0:addElement(f7_local0, f7_local0.typeParams.itemHeight)
	return f7_local0
end

CoD.DrcExpandableButton.AddElement = function (f8_arg0, f8_arg1, f8_arg2)
	if f8_arg2 == nil then
		f8_arg2 = CoD.DrcOptionElement.Height
	end
	f8_arg0.verticalList:addElement(f8_arg1)
	f8_arg0.expandedHeight = f8_arg0.expandedHeight + f8_arg2
	local f8_local0 = f8_arg0.expandedHeight - CoD.DrcExpandableButton.HintTextBoxHeight
	f8_arg0.hintText:setTopBottom(true, false, f8_local0, f8_local0 + CoD.DrcExpandableButton.HintTextHeight)
end

CoD.DrcExpandableButton.TapTimerExpired = function (f9_arg0, f9_arg1)
	if f9_arg0.tapTimer then
		f9_arg0.tapTimer:close()
		f9_arg0.tapTimer = nil
	end
	f9_arg0:dispatchEventToChildren(f9_arg1)
end

CoD.DrcExpandableButton.TouchpadDown = function (f10_arg0, f10_arg1)
	local f10_local0, f10_local1 = ProjectRootCoordinate(f10_arg1.rootName, f10_arg1.x, f10_arg1.y)
	f10_arg0.downX = f10_local0
	f10_arg0.downY = f10_local1
	if f10_arg0.tapTimer then
		f10_arg0.tapTimer:close()
		f10_arg0.tapTimer = nil
	end
	f10_arg0.tapTimer = LUI.UITimer.new(CoD.Wiiu.DRAG_DISABLED_AFTER, "tap_timer_expired", true, f10_arg0)
	LUI.UIElement.addElement(f10_arg0, f10_arg0.tapTimer)
	if f10_arg0.expanded then
		f10_arg0:dispatchEventToChildren(f10_arg1)
	end
end

CoD.DrcExpandableButton.TouchpadUp = function (f11_arg0, f11_arg1)
	if f11_arg0.tapTimer then
		local f11_local0, f11_local1 = ProjectRootCoordinate(f11_arg1.rootName, f11_arg1.x, f11_arg1.y)
		local f11_local2 = math.abs(f11_arg0.downX - f11_local0)
		local f11_local3 = math.abs(f11_arg0.downY - f11_local1)
		if math.sqrt(f11_local2 * f11_local2 + f11_local3 * f11_local3) < CoD.DrcExpandableButton.TapDistThreshold then
			local f11_local4 = f11_arg0.expandRect
			if f11_arg0.expanded then
				f11_local4 = f11_arg0.buttonIcon
			end
			local f11_local5, f11_local6, f11_local7, f11_local8 = f11_local4:getRect()
			if f11_local5 <= f11_local0 and f11_local0 <= f11_local7 and f11_local1 <= f11_local8 and f11_local6 <= f11_local1 and f11_arg1.button == "left" then
				if f11_arg0.expanded then
					f11_arg0:processEvent({
						name = "collapse",
						controller = f11_arg1.controller
					})
				else
					f11_arg0:processEvent({
						name = "expand",
						controller = f11_arg1.controller
					})
				end
			end
		end
		f11_arg0.tapTimer:close()
		f11_arg0.tapTimer = nil
	end
	if f11_arg0.expanded then
		f11_arg0:dispatchEventToChildren(f11_arg1)
	end
end

CoD.DrcExpandableButton.TransitionComplete_ExpandOrCollapse = function (f12_arg0, f12_arg1)
	f12_arg0.owner.buttonList:finishAddingElements()
end

CoD.DrcExpandableButton.Expand = function (f13_arg0, f13_arg1)
	f13_arg0.expanded = true
	f13_arg0.buttonIcon:setZRot(-90)
	f13_arg0:beginAnimation("expand", CoD.DrcExpandableButton.ResizeAnimateTime)
	f13_arg0:setTopBottom(true, false, 0, f13_arg0.expandedHeight)
	f13_arg0.owner:processEvent({
		name = "button_expanded",
		resizeAnimTime = CoD.DrcExpandableButton.ResizeAnimateTime
	})
end

CoD.DrcExpandableButton.Collapse = function (f14_arg0, f14_arg1)
	f14_arg0.expanded = false
	f14_arg0.buttonIcon:setZRot(0)
	f14_arg0:beginAnimation("collapse", CoD.DrcExpandableButton.ResizeAnimateTime)
	f14_arg0:setTopBottom(true, false, 0, CoD.DrcExpandableButton.ButtonHeight)
	f14_arg0.owner:processEvent({
		name = "button_collapsed",
		button = f14_arg0
	})
	f14_arg0:saveState()
end

CoD.DrcExpandableButton.new = function (f15_arg0, f15_arg1, f15_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, CoD.DrcExpandableButton.ButtonHeight)
	Widget:setUseStencil(true)
	Widget.controller = f15_arg1
	Widget.expanded = false
	Widget.expandedHeight = CoD.DrcExpandableButton.ButtonHeight + CoD.DrcExpandableButton.HintTextBoxHeight
	Widget.downX = 0
	Widget.downY = 0
	Widget.owner = f15_arg0
	Widget:addElement(CoD.BorderFrame.new(0.24, 0.24, 0.24, 1, 2))
	local f15_local1 = LUI.UIImage.new()
	f15_local1:setLeftRight(true, false, 0, CoD.DrcExpandableButton.ButtonIconSize)
	local f15_local2 = (CoD.DrcExpandableButton.ButtonHeight - CoD.DrcExpandableButton.ButtonIconSize) / 2
	f15_local1:setTopBottom(true, false, f15_local2, f15_local2 + CoD.DrcExpandableButton.ButtonIconSize)
	f15_local1:setImage(CoD.DrcExpandableButton.ButtonIconMaterial)
	f15_local1:setRGB(CoD.DrcOptionElement.DefaultColor.red, CoD.DrcOptionElement.DefaultColor.green, CoD.DrcOptionElement.DefaultColor.blue)
	Widget.buttonIcon = f15_local1
	Widget:addElement(f15_local1)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f15_local2, f15_local2 + CoD.DrcExpandableButton.ButtonIconSize)
	Widget.expandRect = Widget
	Widget:addElement(Widget)
	local f15_local4 = LUI.UIText.new()
	f15_local4:setAlignment(LUI.Alignment.Left)
	f15_local4:setLeftRight(true, false, CoD.DrcExpandableButton.ButtonIconSize, CoD.DrcExpandableButton.ButtonIconSize + CoD.DrcExpandableButton.TextItemWidth)
	local f15_local5 = (CoD.DrcExpandableButton.ButtonHeight - CoD.DrcExpandableButton.TextHeight) / 2
	f15_local4:setTopBottom(true, false, f15_local5, f15_local5 + CoD.DrcExpandableButton.TextHeight)
	f15_local4:setFont(CoD.fonts.Condensed)
	f15_local4:setText(f15_arg2)
	f15_local4:setRGB(CoD.DrcOptionElement.DefaultColor.red, CoD.DrcOptionElement.DefaultColor.green, CoD.DrcOptionElement.DefaultColor.blue)
	Widget:addElement(f15_local4)
	
	local verticalList = LUI.UIVerticalList.new()
	verticalList:setLeftRight(true, true, CoD.DrcExpandableButton.ItemLeft, 0)
	verticalList:setTopBottom(true, false, CoD.DrcExpandableButton.ButtonHeight, CoD.DrcExpandableButton.ButtonHeight + 4096)
	Widget:addElement(verticalList)
	Widget.verticalList = verticalList
	
	Widget.hintText = CoD.HintText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.DrcExpandableButton.ItemLeft,
		right = CoD.DrcExpandableButton.TextItemWidth,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.DrcExpandableButton.HintTextHeight
	})
	local f15_local7 = CoD.DrcExpandableButton.HintTextHeight - 8
	local f15_local8 = -5
	Widget.hintText.hintArrow:setLeftRight(true, false, f15_local8, f15_local8 + f15_local7)
	Widget.hintText.hintArrow:setTopBottom(false, false, -f15_local7 / 2, f15_local7 / 2)
	Widget.hintText.hint:setLeftRight(true, true, f15_local8 + f15_local7, 0)
	Widget.hintText.hint:setTopBottom(true, false, 0, CoD.DrcExpandableButton.HintTextHeight)
	Widget.hintText:setPriority(100)
	Widget:addElement(Widget.hintText)
	Widget.addElement = CoD.DrcExpandableButton.AddElement
	Widget.addDiscreteLeftRightSlider = CoD.DrcExpandableButton.AddDiscreteLeftRightSlider
	Widget.addProfileDiscreteLeftRightSlider = CoD.DrcExpandableButton.AddProfileDiscreteLeftRightSlider
	Widget.addProfileToggle = CoD.DrcExpandableButton.AddProfileToggle
	Widget.addRadioButtonList = CoD.DrcExpandableButton.AddRadioButtonList
	Widget:registerEventHandler("touchpad_down", CoD.DrcExpandableButton.TouchpadDown)
	Widget:registerEventHandler("touchpad_up", CoD.DrcExpandableButton.TouchpadUp)
	Widget:registerEventHandler("tap_timer_expired", CoD.DrcExpandableButton.TapTimerExpired)
	Widget:registerEventHandler("transition_complete_expand", CoD.DrcExpandableButton.TransitionComplete_ExpandOrCollapse)
	Widget:registerEventHandler("transition_complete_collapse", CoD.DrcExpandableButton.TransitionComplete_ExpandOrCollapse)
	Widget:registerEventHandler("expand", CoD.DrcExpandableButton.Expand)
	Widget:registerEventHandler("collapse", CoD.DrcExpandableButton.Collapse)
	return Widget
end

