CoD.VerticalScrollbar = {}
CoD.VerticalScrollbar.InactiveDelay = 500
CoD.VerticalScrollbar.InactiveDuration = 250
CoD.VerticalScrollbar.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	local f1_local0 = 10
	local f1_local1 = 10
	local f1_local2 = 10
	local Widget = LUI.UIElement.new({
		left = f1_local2,
		top = 0,
		right = f1_local2 + f1_local1,
		bottom = 0,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget.id = "LVerticalScrollbar"
	Widget:registerAnimationState("inactive", {
		left = f1_local2,
		right = f1_local2 + f1_local0,
		leftAnchor = false,
		rightAnchor = true
	})
	Widget:animateToState("inactive")
	local f1_local4 = LUI.UIImage.new()
	f1_local4:setLeftRight(false, false, -f1_local1 / 10, f1_local1 / 10)
	f1_local4:setTopBottom(true, true, 0, 0)
	f1_local4:setAlpha(0.5)
	f1_local4:setRGB(0.15, 0.15, 0.15)
	Widget:addElement(f1_local4)
	local f1_local5 = 16
	local f1_local6 = 0
	local f1_local7 = 5
	local f1_local8 = LUI.UIImage.new()
	f1_local8:setLeftRight(true, false, f1_local7 - f1_local5 / 2, f1_local7 + f1_local5 / 2)
	f1_local8:setTopBottom(true, false, -f1_local6 - f1_local5, -f1_local6)
	f1_local8:setImage(RegisterMaterial("menu_sp_small_arrow"))
	f1_local8:setZRot(180)
	Widget:addElement(f1_local8)
	local f1_local9 = LUI.UIImage.new()
	f1_local9:setLeftRight(true, false, f1_local7 - f1_local5 / 2, f1_local7 + f1_local5 / 2)
	f1_local9:setTopBottom(false, true, f1_local6, f1_local6 + f1_local5)
	f1_local9:setImage(RegisterMaterial("menu_sp_small_arrow"))
	Widget:addElement(f1_local9)
	Widget.image = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		red = f1_arg1,
		green = f1_arg2,
		blue = f1_arg3,
		alpha = f1_arg4
	})
	Widget:addElement(Widget.image)
	Widget.verticalList = f1_arg0
	Widget:registerEventHandler("list_scroll", CoD.VerticalScrollbar.UpdateScrollbar)
	Widget:registerEventHandler("focus_changed", CoD.VerticalScrollbar.FocusChanged)
	Widget:registerEventHandler("inactive", CoD.VerticalScrollbar.Inactive)
	if CoD.useMouse then
		Widget:setHandleMouse(true)
		Widget:registerEventHandler("leftmousedown", CoD.NullFunction)
		Widget:registerEventHandler("leftmouseup", CoD.VerticalScrollbar.MouseAction)
		Widget:registerEventHandler("mousedrag", CoD.VerticalScrollbar.MouseAction)
	end
	return Widget
end

CoD.VerticalScrollbar.UpdateScrollbar = function (f2_arg0, f2_arg1)
	if f2_arg1.list == f2_arg0.verticalList then
		f2_arg0.image:registerAnimationState("default", {
			top = f2_arg1.scrollHandlePosition,
			bottom = f2_arg1.scrollHandlePosition + f2_arg1.scrollHandleSize,
			topAnchor = true,
			bottomAnchor = false,
			alpha = activeAlpha
		})
		f2_arg0.image:animateToState("default")
	end
	f2_arg0:dispatchEventToChildren(f2_arg1)
end

CoD.VerticalScrollbar.FocusChanged = function (f3_arg0, f3_arg1)
	if not CoD.useController then
		f3_arg0:animateToState("default")
	end
	if f3_arg0.inactiveTimer then
		f3_arg0.inactiveTimer:close()
		f3_arg0.inactiveTimer:reset()
		f3_arg0:addElement(f3_arg0.inactiveTimer)
	else
		f3_arg0.inactiveTimer = LUI.UITimer.new(CoD.VerticalScrollbar.InactiveDelay, "inactive", true)
		f3_arg0:addElement(f3_arg0.inactiveTimer)
	end
end

CoD.VerticalScrollbar.Inactive = function (f4_arg0, f4_arg1)
	f4_arg0:animateToState("inactive", CoD.VerticalScrollbar.InactiveDuration)
end

CoD.VerticalScrollbar.MouseAction = function (f5_arg0, f5_arg1)
	local f5_local0, f5_local1, f5_local2, f5_local3 = f5_arg0:getRect()
	f5_arg0:dispatchEventToParent({
		name = "scrollbar_update",
		controller = f5_arg1.controller,
		scrollBarPos = (f5_arg1.y - f5_local1) / (f5_local3 - f5_local1)
	})
end

