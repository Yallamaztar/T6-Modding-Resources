LUI.UIScrollable = {}
local f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg0.container:addElement(f1_arg1)
end

local f0_local1 = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4)
	f2_arg0.container:registerAnimationState("scroll_target", {
		left = f2_arg1,
		right = f2_arg1 + f2_arg0.containerWidth,
		leftAnchor = true
	})
	f2_arg0.container:animateToState("scroll_target", f2_arg2, f2_arg3, f2_arg4)
end

local f0_local2 = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4)
	local f3_local0 = f3_arg0:getHeight()
	if f3_arg1 > 0 then
		f3_arg1 = 0
	elseif f3_arg1 < -f3_arg0.containerHeight + f3_local0 then
		f3_arg1 = -f3_arg0.containerHeight + f3_local0
	end
	f3_arg0.container:registerAnimationState("scroll_target", {
		top = f3_arg1,
		bottom = f3_arg1 + f3_arg0.containerHeight,
		topAnchor = true,
		bottomAnchor = false
	})
	f3_arg0.container:animateToState("scroll_target", f3_arg2, f3_arg3, f3_arg4)
end

LUI.UIScrollable.new = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	if f4_arg1 == nil or f4_arg2 == nil then
		error("Cannot create scrollable component without valid dimensions!")
		return 
	end
	local Widget = LUI.UIElement.new(f4_arg0)
	Widget.id = "LUIScrollable"
	Widget:setHandleMouse(true)
	if f4_arg3 == true then
		Widget.container = LUI.UIElement.new({
			left = -f4_arg1 / 2,
			top = -f4_arg2 / 2,
			right = f4_arg1 / 2,
			bottom = f4_arg2 / 2,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false,
			zoom = 0
		})
	else
		Widget.container = LUI.UIElement.new({
			left = 0,
			top = 0,
			right = f4_arg1,
			bottom = f4_arg2,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false,
			zoom = 0
		})
	end
	Widget.container.id = "LUIScrollable_Container"
	Widget:setUseStencil(true)
	Widget.containerWidth = f4_arg1
	Widget.containerHeight = f4_arg2
	Widget:addElement(Widget.container)
	Widget.addElement = f0_local0
	Widget.scrollX = f0_local1
	Widget.scrollY = f0_local2
	return Widget
end

