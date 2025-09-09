LUI.UITouchpadButton = InheritFrom(LUI.UIButton)
LUI.UITouchpadButton.ButtonOverEvent = {
	name = "button_over"
}
LUI.UITouchpadButton.ButtonUpEvent = {
	name = "button_up"
}
LUI.UITouchpadButton.ButtonDownAnimationCompleteEvent = {
	name = "touchpad_down_animation_complete"
}
LUI.UITouchpadButton.TouchpadDown = function (f1_arg0, f1_arg1)
	f1_arg0.buttonDownTimer = LUI.UITimer.new(CoD.Wiiu.DRAG_DISABLED_AFTER, {
		name = "touchpad_down_delay",
		controller = f1_arg1.controller
	}, true, f1_arg0)
	f1_arg0:addElement(f1_arg0.buttonDownTimer)
	f1_arg0.touchpadDownX = f1_arg1.x
	f1_arg0.touchpadDownY = f1_arg1.y
end

LUI.UITouchpadButton.TouchpadDownDelay = function (f2_arg0, f2_arg1)
	if f2_arg0.touchpadDownX then
		f2_arg0:processEvent({
			name = "button_over_down",
			controller = f2_arg1.controller
		})
	end
	f2_arg0.buttonDownTimer = nil
	f2_arg0.buttonDownAnimFinished = false
end

LUI.UITouchpadButton.TouchpadUp = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg0.touchpadDownX
	local f3_local1 = f3_arg0.touchpadDownY
	f3_arg0.touchpadDownX = nil
	f3_arg0.touchpadDownY = nil
	local f3_local2 = nil
	if f3_arg0.buttonDownTimer then
		f3_arg0.buttonDownTimer:close()
		f3_arg0.buttonDownTimer = nil
		f3_local2 = true
	end
	if f3_arg1.inside and f3_local0 and not f3_arg0.disabled then
		local f3_local3 = f3_arg1.x - f3_local0
		local f3_local4 = f3_arg1.y - f3_local1
		if f3_local3 * f3_local3 + f3_local4 * f3_local4 < CoD.Wiiu.DRAG_THRESHOLD_SQUARED then
			if not f3_arg0.downAnimationCompleteEvent then
				LUI.UIButton.buttonAction(f3_arg0, {
					name = "button_action",
					controller = f3_arg1.controller,
					mouse = true
				})
			elseif f3_local2 then
				f3_arg0.buttonClicked = true
				f3_arg0:processEvent({
					name = "button_over_down",
					controller = f3_arg1.controller
				})
			elseif f3_arg0.buttonDownAnimFinished then
				f3_arg0.buttonClicked = true
				LUI.UITouchpadButton.DownAnimationComplete(f3_arg0, f3_arg1)
			elseif f3_arg0.downAnimationCompleteEvent then
				f3_arg0.buttonClicked = true
			end
		else
			f3_arg0:processEvent(LUI.UITouchpadButton.ButtonUpEvent)
		end
	end
end

LUI.UITouchpadButton.DownAnimationComplete = function (f4_arg0, f4_arg1)
	if f4_arg0.buttonClicked then
		LUI.UIButton.buttonAction(f4_arg0, {
			name = "button_action",
			controller = f4_arg1.controller,
			mouse = true
		})
		f4_arg0:addElement(LUI.UITimer.new(333, LUI.UITouchpadButton.ButtonUpEvent, true, f4_arg0))
	end
	f4_arg0.buttonClicked = false
	f4_arg0.buttonDownAnimFinished = true
end

LUI.UITouchpadButton.TouchpadMove = function (f5_arg0, f5_arg1)
	if f5_arg0.m_inputDisabled then
		return 
	elseif not f5_arg0.touchpadDownX then
		return 
	end
	local f5_local0, f5_local1 = ProjectRootCoordinate(f5_arg1.rootName, f5_arg1.x, f5_arg1.y)
	if f5_local0 == nil or f5_local1 == nil then
		return 
	end
	local f5_local2 = false
	local f5_local3, f5_local4, f5_local5, f5_local6 = f5_arg0:getRect()
	if not f5_arg1.mouse_outside and f5_local3 and f5_local4 <= f5_local1 and f5_local1 <= f5_local6 and f5_local3 <= f5_local0 and f5_local0 <= f5_local5 then
		local f5_local7 = f5_local0 - f5_arg0.touchpadDownX
		local f5_local8 = f5_local1 - f5_arg0.touchpadDownY
		if f5_local7 * f5_local7 + f5_local8 * f5_local8 > CoD.Wiiu.DRAG_THRESHOLD_SQUARED then
			f5_arg0:processEvent(LUI.UITouchpadButton.ButtonUpEvent)
			f5_arg0.touchpadDownX = nil
			f5_arg0.touchpadDownY = nil
			if f5_arg0.buttonDownTimer then
				f5_arg0.buttonDownTimer:close()
				f5_arg0.buttonDownTimer = nil
			end
		end
	else
		f5_arg0:dispatchEventToChildren(f5_arg1)
	end
end

LUI.UITouchpadButton.new = function (f6_arg0, f6_arg1)
	local f6_local0 = LUI.UIButton.new(f6_arg0, f6_arg1)
	f6_local0:setClass(LUI.UITouchpadButton)
	f6_local0.id = "LUITouchpadButton"
	f6_local0.buttonClicked = false
	f6_local0.downAnimationCompleteEvent = LUI.UITouchpadButton.ButtonDownAnimationCompleteEvent
	return f6_local0
end

LUI.UITouchpadButton:registerEventHandler("leftmousedown", LUI.UITouchpadButton.TouchpadDown)
LUI.UITouchpadButton:registerEventHandler("leftmouseup", LUI.UITouchpadButton.TouchpadUp)
LUI.UITouchpadButton:registerEventHandler("mousemove", LUI.UITouchpadButton.TouchpadMove)
LUI.UITouchpadButton:registerEventHandler("touchpad_move", LUI.UITouchpadButton.TouchpadMove)
LUI.UITouchpadButton:registerEventHandler("touchpad_down_delay", LUI.UITouchpadButton.TouchpadDownDelay)
LUI.UITouchpadButton:registerEventHandler("touchpad_down_animation_complete", LUI.UITouchpadButton.DownAnimationComplete)
