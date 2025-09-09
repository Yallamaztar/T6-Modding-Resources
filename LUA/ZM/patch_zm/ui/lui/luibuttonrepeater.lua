require("LUI.LUITimer")
LUI.UIButtonRepeater = {}
LUI.UIButtonRepeater.FirstDelay = 420
LUI.UIButtonRepeater.Delay = 210
LUI.UIButtonRepeater.DelayReduction = 25
LUI.UIButtonRepeater.AccelInterval = 100
LUI.UIButtonRepeater.MinDelay = 33
LUI.UIButtonRepeater.new = function (ButtonName, EventOrName, EventTarget)
	local Widget = LUI.UIElement.new()
	Widget.id = "LUIButtonRepeater"
	Widget:setPriority(-1000)
	Widget.buttonName = ButtonName
	if type(EventOrName) == "string" then
		Widget.event = {
			name = EventOrName,
			buttonRepeat = true
		}
	else
		EventOrName.buttonRepeat = true
		Widget.event = EventOrName
	end
	Widget.eventTarget = EventTarget
	Widget.firstDelay = LUI.UIButtonRepeater.FirstDelay
	Widget.delay = LUI.UIButtonRepeater.Delay
	Widget.delayReduction = LUI.UIButtonRepeater.DelayReduction
	Widget.accelInterval = LUI.UIButtonRepeater.AccelInterval
	Widget.minDelay = LUI.UIButtonRepeater.MinDelay
	Widget.handleGamepadButton = LUI.UIButtonRepeater.HandleGamepadButton
	Widget.cancelRepetition = LUI.UIButtonRepeater.CancelRepetition
	Widget.sendButtonRepeat = LUI.UIButtonRepeater.SendButtonRepeat
	Widget:registerEventHandler("repeat", LUI.UIButtonRepeater.Repeat)
	Widget:registerEventHandler("accelerate", LUI.UIButtonRepeater.Accelerate)
	Widget:registerEventHandler("menu_occluded", LUI.UIButtonRepeater.CancelRepetition)
	Widget:registerEventHandler("controller_backed_out", LUI.UIButtonRepeater.CancelRepetition)
	if LUI.startswith(ButtonName, "mouse") or LUI.startswith(ButtonName, "touchpad") then
		Widget:setHandleMouseButton(true)
		Widget:registerEventHandler("leftmousedown", LUI.UIButtonRepeater.LeftMouseDown)
		Widget:registerEventHandler("leftmouseup", LUI.UIButtonRepeater.LeftMouseUp)
	end
	return Widget
end

LUI.UIButtonRepeater.HandleGamepadButton = function (self, Event)
	if LUI.UIElement.handleGamepadButton(self, Event) then
		return true
	elseif Event.button == self.buttonName and not Event.buttonRepeat then
		self:cancelRepetition()
		if Event.down == true then
			self.controller = Event.controller
			
			local repeatTimer = LUI.UITimer.new(self.firstDelay, {
				name = "repeat",
				numRepeats = 1
			})
			self:addElement(repeatTimer)
			self.repeatTimer = repeatTimer
			
			if Event.name ~= self.event.name then
				self:sendButtonRepeat()
			end
		end
	end
end

LUI.UIButtonRepeater.LeftMouseDown = function (self, Event)
	if not Event.buttonRepeat then
		self:cancelRepetition()
		self.controller = Event.controller
		
		local repeatTimer = LUI.UITimer.new(self.firstDelay, {
			name = "repeat",
			numRepeats = 1
		})
		self:addElement(repeatTimer)
		self.repeatTimer = repeatTimer
		
		if Event.name ~= self.event.name then
			self:sendButtonRepeat()
		end
	end
end

LUI.UIButtonRepeater.LeftMouseUp = function (self, Event)
	if not Event.buttonRepeat then
		self:cancelRepetition()
	end
end

LUI.UIButtonRepeater.CancelRepetition = function (self)
	local RepeatTimer = self.repeatTimer
	if RepeatTimer ~= nil then
		RepeatTimer:close()
		self.repeatTimer = nil
	end
	local AccelTimer = self.accelTimer
	if AccelTimer ~= nil then
		AccelTimer:close()
		self.accelTimer = nil
	end
	self.currentDelay = nil
end

LUI.UIButtonRepeater.SendButtonRepeat = function (self)
	local EventTarget = self.eventTarget
	if EventTarget == nil then
		EventTarget = self:getParent()
	end
	local Event = self.event
	Event.controller = self.controller
	return EventTarget:processEvent(Event)
end

LUI.UIButtonRepeater.Repeat = function (self, Event)
	local RepeatTimer = self.repeatTimer
	local NumRepeats = Event.numRepeats
	if self.currentDelay == nil then
		RepeatTimer.interval = self.delay
		if self.accelTimer == nil then
			local accelTimer = LUI.UITimer.new(self.accelInterval, "accelerate")
			self:addElement(accelTimer)
			self.accelTimer = accelTimer
			
		end
	else
		RepeatTimer.interval = self.currentDelay
	end
	if self:isInputDisabledOnChain() then
		self:cancelRepetition()
	else
		self:sendButtonRepeat()
		Event.numRepeats = NumRepeats + 1
	end
end

LUI.UIButtonRepeater.Accelerate = function (self, Event)
	local CurrentDelay = self.currentDelay
	if CurrentDelay == nil then
		CurrentDelay = self.delay
	else
		CurrentDelay = CurrentDelay - self.delayReduction
		if CurrentDelay < self.minDelay then
			CurrentDelay = self.minDelay
		end
	end
	self.currentDelay = CurrentDelay
end

