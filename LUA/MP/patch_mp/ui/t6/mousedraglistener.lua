CoD.MouseDragListener = {}
CoD.MouseDragListener.DefaultDragDistance = 10
CoD.MouseDragListener.new = function (f1_arg0)
	local Widget = LUI.UIElement.new()
	Widget.id = "MouseDragListener"
	if f1_arg0 then
		Widget.m_dragDistance = f1_arg0
	else
		Widget.m_dragDistance = CoD.MouseDragListener.DefaultDragDistance
	end
	Widget:makeNotFocusable()
	Widget:setHandleMouse(true)
	Widget:setHandleMouseAnim(true)
	Widget:registerEventHandler("leftmousedown", CoD.MouseDragListener.LeftMouseDown)
	Widget:registerEventHandler("leftmouseup", CoD.MouseDragListener.LeftMouseUp)
	Widget:registerEventHandler("mousedrag", CoD.MouseDragListener.MouseDrag)
	return Widget
end

CoD.MouseDragListener.LeftMouseDown = function (f2_arg0, f2_arg1)
	f2_arg0.m_curX = f2_arg1.x
	f2_arg0.m_curY = f2_arg1.y
end

CoD.MouseDragListener.LeftMouseUp = function (f3_arg0, f3_arg1)
	f3_arg0.m_curX = nil
	f3_arg0.m_curY = nil
	if f3_arg0.m_mouseDrag then
		f3_arg0.m_mouseDrag = nil
	end
end

CoD.MouseDragListener.MouseDrag = function (f4_arg0, f4_arg1)
	if f4_arg0.m_curX == nil and f4_arg0.m_curY == nil then
		return 
	end
	local f4_local0 = nil
	if f4_arg0.m_dragDistance < math.abs(f4_arg0.m_curX - f4_arg1.x) then
		if f4_arg0.m_curX < f4_arg1.x then
			f4_local0 = "right"
		else
			f4_local0 = "left"
		end
		f4_arg0.m_curX = f4_arg1.x
		f4_arg0.m_mouseDrag = true
		f4_arg0:dispatchEventToParent({
			name = "listener_mouse_drag",
			controller = f4_arg1.controller,
			direction = f4_local0
		})
	end
	if f4_arg0.m_dragDistance < math.abs(f4_arg0.m_curY - f4_arg1.y) then
		if f4_arg0.m_curY < f4_arg1.y then
			f4_local0 = "down"
		else
			f4_local0 = "up"
		end
		f4_arg0.m_curY = f4_arg1.y
		f4_arg0.m_mouseDrag = true
		local f4_local1 = f4_arg0
		local f4_local2 = f4_arg0.dispatchEventToParent
		local f4_local3 = {
			name = "listener_mouse_drag"
		}
		local f4_local4 = controller
		local f4_local5 = f4_arg1.controller
		f4_local3.direction = f4_local0
		f4_local3[1] = f4_local4
		f4_local3[2] = f4_local5
		f4_local2(f4_local1, f4_local3)
	end
end

