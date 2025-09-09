LUI.UITimer = {}
LUI.UITimer.priority = 10000
LUI.UITimer.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 1,
		bottom = 1,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	Widget.id = "LUITimer"
	Widget:setPriority(LUI.UITimer.priority)
	Widget.reset = LUI.UITimer.Reset
	Widget.interval = math.max(1, f1_arg0)
	Widget.disposable = f1_arg2
	if type(f1_arg1) == "string" then
		Widget.timerEvent = {
			name = f1_arg1,
			timer = Widget
		}
	else
		f1_arg1.timer = Widget
		Widget.timerEvent = f1_arg1
	end
	Widget.timerEventTarget = f1_arg3
	Widget:reset()
	return Widget
end

LUI.UITimer.Reset = function (f2_arg0)
	f2_arg0:registerEventHandler("transition_complete_default", nil)
	f2_arg0:animateToState("default", f2_arg0.interval)
	f2_arg0:registerEventHandler("transition_complete_default", LUI.UITimer.Tick)
end

LUI.UITimer.Tick = function (f3_arg0, f3_arg1)
	if f3_arg1.interrupted then
		return 
	end
	local f3_local0 = nil
	if f3_arg0.timerEventTarget ~= nil then
		f3_local0 = f3_arg0.timerEventTarget
	else
		f3_local0 = f3_arg0:getParent()
	end
	local f3_local1 = f3_arg0.timerEvent
	f3_local1.timeElapsed = f3_arg0.interval + f3_arg1.lateness
	f3_local0:processEvent(f3_local1)
	if f3_arg0.disposable then
		f3_arg0:close()
	else
		f3_arg0:reset()
	end
end

