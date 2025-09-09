LUI.UITimer = {}
LUI.UITimer.priority = 10000
LUI.UITimer.new = function (intervalMs, eventName, isDisposable, timerEventTarget)
	local timer = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 1,
		bottom = 1,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	timer.id = "LUITimer"
	timer:setPriority(LUI.UITimer.priority)
	timer.reset = LUI.UITimer.Reset
	timer.interval = math.max(1, intervalMs)
	timer.disposable = isDisposable
	if type(eventName) == "string" then
		timer.timerEvent = {
			name = eventName,
			timer = timer
		}
	else
		eventName.timer = timer
		timer.timerEvent = eventName
	end
	timer.timerEventTarget = timerEventTarget
	timer:reset()
	return timer
end

LUI.UITimer.Reset = function ( self )
	self:registerEventHandler( "transition_complete_default", nil )
	self:animateToState( "default", self.interval )
	self:registerEventHandler( "transition_complete_default", LUI.UITimer.Tick )
end

LUI.UITimer.Tick = function (self, event)
	if event.interrupted then
		return 
	end
	local element = nil
	if self.timerEventTarget ~= nil then
		element = self.timerEventTarget
	else
		element = self:getParent()
	end
	local f3_local1 = self.timerEvent
	f3_local1.timeElapsed = self.interval + event.lateness
	element:processEvent(f3_local1)
	if self.disposable then
		self:close()
	else
		self:reset()
	end
end

