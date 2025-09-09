LUI.UIElement = {
	id = "LUIElement",
	m_defaultAnimationState = {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		bottomAnchor = false,
		rightAnchor = false,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1,
		alphaMultiplier = 1
	}
}
LUI.UIContainer = {}
LUI.UIElement.addElement = function (self, ChildElement)
	if self:canAddElement(ChildElement) then
		self:addElementToC(ChildElement)
	end
end

LUI.UIElement.addElementBefore = function (self, ChildElement)
	local ParentElement = ChildElement:getParent()
	if not ParentElement then
		error("LUI Error: Element has no parent!")
		return 
	elseif ParentElement:canAddElement(self) then
		self:addElementBeforeInC(ChildElement)
	end
end

LUI.UIElement.addElementAfter = function (self, ChildElement)
	local ParentElement = ChildElement:getParent()
	if not ParentElement then
		error("LUI Error: Element has no parent!")
		return 
	elseif ParentElement:canAddElement(self) then
		self:addElementAfterInC(ChildElement)
	end
end

LUI.UIElement.canAddElement = function (self, ChildElement)
	if ChildElement == nil then
		error("LUI Error: Tried to add nil element!")
		return false
	elseif ChildElement:getParent() == self then
		return false
	else
		return true
	end
end

LUI.UIElement.isClosed = function (self)
	return self:getParent() == nil
end

LUI.UIElement.close = function (ChildElement)
	local ParentElement = ChildElement:getParent()
	if ParentElement ~= nil then
		ParentElement:removeElement(ChildElement)
	end
end

LUI.UIElement.closeAndRefocus = function (self, f7_arg1)
	if self:isInFocus() then
		self:processEvent(LUI.UIButton.LoseFocusEvent)
		f7_arg1:processEvent(LUI.UIButton.GainFocusEvent)
	end
	self:close()
end

LUI.UIElement.getFullID = function (self)
	local Id = self.id
	local ParentElement = self:getParent()
	while ParentElement do
		Id = ParentElement.id .. "/" .. Id
		ParentElement = ParentElement:getParent()
	end
	return Id
end

LUI.UIElement.isInputDisabledOnChain = function (self)
	while self do
		if self.m_inputDisabled then
			return true
		end
		self = self:getParent()
	end
	return false
end

LUI.UIElement.setMouseDisabled = function (self, DisableMouse)
	self.m_leftMouseDown = nil
	self.m_rightMouseDown = nil
	self.m_mouseDisabled = DisableMouse
	if CoD.isPC then
		CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_NORMAL)
	end
end

LUI.UIElement.setRestrictMouseInsideElement = function (self, RestrictMouse)
	self.m_restrictMouseInside = RestrictMouse
end

LUI.UIElement.setHandleMouseAnim = function (self, HandleMouseAnim)
	self.handleMouseAnim = HandleMouseAnim
end

LUI.UIElement.setHandleMouse = function (self, HandleMouse)
	self.handleMouseMove = HandleMouse
	self.handleMouseButton = HandleMouse
end

LUI.UIElement.setHandleMouseMove = function (self, HandleMouse)
	self.handleMouseMove = HandleMouse
end

LUI.UIElement.setHandleMouseButton = function (self, HandleMouse)
	self.handleMouseButton = HandleMouse
end

LUI.UIElement.IsMouseInsideElement = function (self, Event)
	local IsMouseInsideElement = false
	local MouseX, MouseY = ProjectRootCoordinate(Event.rootName, Event.x, Event.y)
	if MouseX == nil or MouseY == nil then
		return IsMouseInsideElement
	end
	local Left, Top, Right, Bottom = self:getRect()
	if Left ~= nil and Top <= MouseY and MouseY <= Bottom and Left <= MouseX and MouseX <= Right then
		IsMouseInsideElement = true
	end
	return IsMouseInsideElement, MouseX, MouseY
end

LUI.UIElement.MouseClear = function (self, Event)
	self.m_leftMouseDown = nil
	self.m_rightMouseDown = nil
	self:dispatchEventToChildren(Event)
end

LUI.UIElement.MouseMoveEvent = function (self, Event)
	if self.m_inputDisabled or self.m_mouseDisabled then
		return 
	elseif self.handleMouseMove and not Event.waitingForKeyBind then
		local Inside, MouseX, MouseY = LUI.UIElement.IsMouseInsideElement(self, Event)
		if Inside then
			if self.m_focusable and not self:isInFocus() then
				if LUI.currentMouseFocus ~= nil then
					LUI.currentMouseFocus:processEvent({
						name = "lose_focus",
						controller = Event.controller
					})
					LUI.currentMouseFocus.m_mouseOver = nil
				end
				self:processEvent({
					name = "gain_focus",
					controller = Event.controller
				})
				if self.gainFocusSFX ~= nil then
					Engine.PlaySound(self.gainFocusSFX)
				end
				LUI.currentMouseFocus = self
			end
			if self.m_mouseOver == nil then
				self.m_mouseOver = true
				if self.m_eventHandlers.mouseenter ~= nil then
					self.m_eventHandlers:mouseenter({
						name = "mouseenter",
						controller = Event.controller,
						root = Event.root,
						x = MouseX,
						y = MouseY
					})
				end
			end
			if self.m_eventHandlers.mouseover ~= nil then
				self.m_eventHandlers:mouseover({
					name = "mouseover",
					controller = Event.controller,
					root = Event.root,
					x = MouseX,
					y = MouseY
				})
			end
			if self.handleMouseAnim and self.m_leftMouseDown == nil then
				CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_GRABOPEN)
				CoD.Mouse.InGrabMode = true
			end
		elseif self ~= LUI.currentMouseFocus then
			if self:isInFocus() then
				self:processEvent({
					name = "lose_focus",
					controller = Event.controller
				})
			end
			if self.m_mouseOver ~= nil then
				self.m_mouseOver = nil
				if self.m_eventHandlers.mouseleave ~= nil then
					self.m_eventHandlers:mouseleave({
						name = "mouseleave",
						controller = Event.controller,
						root = Event.root
					})
				end
				if self.handleMouseAnim and self.m_leftMouseDown == nil then
					CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_NORMAL)
				end
			end
		end
		if self.m_eventHandlers.mousedrag ~= nil and self.m_leftMouseDown ~= nil then
			self.m_eventHandlers:mousedrag({
				name = "mousedrag",
				controller = Event.controller,
				root = Event.root,
				x = MouseX,
				y = MouseY
			})
		end
	end
	if not self.m_restrictMouseInside or LUI.UIElement.IsMouseInsideElement(self, Event) then
		self:dispatchEventToChildren(Event)
	end
end

LUI.UIElement.MouseButtonEvent = function (self, Event)
	if self.m_inputDisabled or self.m_mouseDisabled then
		return 
	elseif self.handleMouseButton then
		local Inside, MouseX, MouseY = LUI.UIElement.IsMouseInsideElement(self, Event)
		if Event.name == "mouseup" or Event.name == "touchpad_up" then
			if Event.button == "left" then
				if self.handleMouseAnim then
					if Inside then
						CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_GRABOPEN)
					else
						CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_NORMAL)
					end
				end
				if self.m_leftMouseDown ~= nil or Event.name == "touchpad_up" then
					self.m_leftMouseDown = nil
					if self.m_eventHandlers.leftmouseup ~= nil then
						local returnValue = self.m_eventHandlers:leftmouseup({
							name = "leftmouseup",
							controller = Event.controller,
							root = Event.root,
							x = MouseX,
							y = MouseY,
							inside = Inside
						})
						if returnValue then
							return returnValue
						end
					end
				elseif not Inside and self.m_eventHandlers.leftmouseup_outside ~= nil then
					local returnValue = self.m_eventHandlers:leftmouseup_outside({
						name = "leftmouseup_outside",
						controller = Event.controller,
						root = Event.root,
						x = MouseX,
						y = MouseY,
						inside = Inside
					})
					if returnValue then
						return returnValue
					end
				end
			end
			if Event.button == "right" and self.m_rightMouseDown ~= nil then
				self.m_rightMouseDown = nil
				if self.m_eventHandlers.rightmouseup ~= nil then
					local returnValue = self.m_eventHandlers:rightmouseup({
						name = "rightmouseup",
						controller = Event.controller,
						root = Event.root,
						x = MouseX,
						y = MouseY,
						inside = Inside
					})
					if returnValue then
						return returnValue
					end
				end
			end
		end
		if Inside and (Event.name == "mousedown" or Event.name == "touchpad_down") then
			if Event.button == "left" and self.m_eventHandlers.leftmousedown ~= nil and self.m_leftMouseDown == nil then
				self.m_leftMouseDown = true
				self.m_eventHandlers:leftmousedown({
					name = "leftmousedown",
					controller = Event.controller,
					root = Event.root,
					x = MouseX,
					y = MouseY,
					inside = Inside
				})
				if self.handleMouseAnim then
					CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_GRABCLOSE)
				end
			end
			if Event.button == "right" and self.m_eventHandlers.rightmousedown ~= nil and self.m_rightMouseDown == nil then
				self.m_rightMouseDown = true
				self.m_eventHandlers:rightmousedown({
					name = "rightmousedown",
					controller = Event.controller,
					root = Event.root,
					x = MouseX,
					y = MouseY,
					inside = Inside
				})
			end
		end
	end
	if not self.m_restrictMouseInside or LUI.UIElement.IsMouseInsideElement(self, Event) then
		self:dispatchEventToChildren(Event)
	end
end

LUI.UIElement.GamepadButton = function (self, Event)
	if self.m_inputDisabled then
		return 
	elseif not self:handleGamepadButton(Event) then
		if self.m_ownerController == nil or self.m_ownerController == Event.controller then
			return self:dispatchEventToChildren(Event)
		else

		end
	else
		return true
	end
end

LUI.UIElement.GamepadButton_DPadOnly = function (self, Event)
	if Event.qualifier ~= "dpad" then
		return 
	else
		LUI.UIElement.GamepadButton(self, Event)
	end
end

LUI.UIElement.handleGamepadButton = function (self, Event)
	if self:isInFocus() and Event.down == true and self.m_disableNavigation ~= true then
		if self.navigationSounds and self.navigationSounds[Event.button] then
			Engine.PlaySound(self.navigationSounds[Event.button])
		end
		if self.navigation[Event.button] and self.navigation[Event.button].m_focusable then
			self:processEvent({
				name = "lose_focus",
				controller = Event.controller,
				button = Event.button
			})
			self.navigation[Event.button]:processEvent({
				name = "gain_focus",
				controller = Event.controller,
				button = Event.button
			})
			if self.navigation[Event.button].gainFocusSFX then
				Engine.PlaySound(self.navigation[Event.button].gainFocusSFX)
			end
			return true
		end
	end
end

LUI.UIElement.gainFocus = function (self, Event)
	if self.m_focusable then
		self:setFocus(true)
		LUI.currentMouseFocus = self
	end
	self:dispatchEventToChildren(Event)
end

LUI.UIElement.loseFocus = function (self, Event)
	if self.m_focusable and self:isInFocus() then
		self:setFocus(false)
	end
	self:dispatchEventToChildren(Event)
end

LUI.UIElement.processEvent = function (self, Event)
	local eventHandler = self.m_eventHandlers[Event.name]
	if eventHandler ~= nil then
		return eventHandler(self, Event)
	else
		return self:dispatchEventToChildren(Event)
	end
end

LUI.UIElement.getRoot = function (self)
	if not self then
		return 
	end
	local Parent = self:getParent()
	while Parent do
		self = Parent
		Parent = Parent:getParent()
	end
	return self
end

LUI.UIElement.dispatchEventToRoot = function (self, Event)
	local Parent = self:getParent()
	while Parent do
		local NewParent = Parent:getParent()
		if NewParent == nil then
			local EventHandler = Parent.m_eventHandlers[Event.name]
			if EventHandler ~= nil then
				EventHandler(Parent, Event)
			end
			Parent:dispatchEventToChildren(Event)
			return 
		end
		Parent = NewParent
	end
end

LUI.UIElement.dispatchEventToParent = function (self, Event)
	local Parent = self:getParent()
	while Parent do
		local eventHandler = Parent.m_eventHandlers[Event.name]
		if eventHandler then
			return eventHandler(Parent, Event)
		end
		Parent = Parent:getParent()
	end
end

LUI.UIElement.dispatchEventToChildren = function (self, Event)
	local Child = self:getFirstChild()
	if Child == nil then
		return 
	end
	while Child ~= nil do
		local NextChild = Child:getNextSibling()
		local ReturnValue = Child:processEvent(Event)
		if ReturnValue then
			return ReturnValue
		end
		Child = NextChild
	end
end

LUI.UIElement.registerChildEventHandler = function (self, EventName)
	self.m_eventsHandledByChildren[EventName] = true
	local Parent = self:getParent()
	if Parent ~= nil then
		Parent:registerChildEventHandler(EventName)
	end
end

LUI.UIElement.registerEventHandler = function (self, EventName, EventHandler)
	self.m_eventHandlers[EventName] = EventHandler
end

LUI.UIElement.isFocusable = function (self)
	return self.m_focusable
end

LUI.UIElement.makeFocusable = function (self)
	self.m_focusable = true
	self.navigation = {}
end

LUI.UIElement.makeNotFocusable = function (self)
	self.m_focusable = false
end

LUI.UIElement.isIDNamed = function (self)
	if string.find(self.id, ".") then
		return true
	else
		return false
	end
end

LUI.UIElement.getFirstInFocus = function (parent)
	if parent:isInFocus() then
		return parent
	end
	local firstChild = parent:getFirstChild()
	while firstChild do
		local nextChild = firstChild:getFirstInFocus()
		if nextChild then
			return nextChild
		end
		firstChild = firstChild:getNextSibling()
	end
	local nextSibling = parent:getNextSibling()
	if nextSibling then
		return nextSibling:getFirstInFocus()
	end
end

LUI.UIElement.saveState = function (self)
	if not self:isIDNamed() then
		error("LUI Error: Tried to save menu state, but element has no name: " .. self:getFullID())
		return 
	elseif self:getFirstChild() then
		local FirstChild = self:getFirstChild()
		FirstChild = FirstChild:getFirstInFocus()
		if FirstChild then
			if not FirstChild:isIDNamed() then
				error("LUI Error: Tried to save menu state, but focused element has no name: " .. FirstChild:getFullID())
				return 
			end
			LUI.savedMenuStates[self.id] = {
				id = FirstChild.id,
				data = FirstChild.saveData
			}
		else
			LUI.savedMenuStates[self.id] = nil
		end
	end
end

LUI.UIElement.clearSavedState = function (FirstChild)
	if not FirstChild:isIDNamed() then
		error("LUI Error: Tried to save menu state, but element has no name: " .. FirstChild:getFullID())
		return 
	else
		LUI.savedMenuStates[FirstChild.id] = nil
	end
end

LUI.UIElement.restoreState = function (FirstChild)
	if not FirstChild:isIDNamed() then
		error("LUI Error: Tried to restore menu state, but element has no name: " .. FirstChild:getFullID())
		return 
	else
		local SavedState = LUI.savedMenuStates[FirstChild.id]
		if SavedState ~= nil and SavedState.id then
			return FirstChild:processEvent({
				name = "restore_focus",
				id = SavedState.id,
				data = SavedState.data
			})
		else

		end
	end
end

LUI.UIElement.restoreFocus = function (self, Event)
	if self.id == Event.id then
		self:processEvent({
			name = "gain_focus"
		})
		return true
	else
		return self:dispatchEventToChildren(Event)
	end
end

LUI.UIElement.animate = function (self, f41_arg1)
	if self.m_animationStates[f41_arg1.animationStateName] then
		self:animateToState(f41_arg1.animationStateName, f41_arg1.duration, f41_arg1.easeIn, f41_arg1.easeOut)
		if f41_arg1.animateChildren then
			self:dispatchEventToChildren(f41_arg1)
		end
	else
		self:dispatchEventToChildren(f41_arg1)
	end
end

LUI.UIElement.hide = function (self)
	self:setAlpha(0)
	self.m_inputDisabled = true
end

LUI.UIElement.show = function (self)
	self:setAlpha(1)
	self.m_inputDisabled = nil
end

LUI.UIElement.rotateRandomly = function (self, f44_arg1)
	if not self.m_eventHandlers.rotate_randomly then
		self:registerEventHandler("rotate_randomly", LUI.UIElement.rotateRandomly)
		self:addElement(LUI.UITimer.new(2500, "rotate_randomly", false, self))
	end
	self:beginAnimation("rotate_randomly", 2500, true, true)
	self:setXRot(math.random(-45, 45))
	self:setYRot(math.random(-45, 45))
end

LUI.UIElement.spinRandomly = function (self, Event)
	if not self.m_eventHandlers.spin_randomly then
		self:registerEventHandler("spin_randomly", LUI.UIElement.rotateRandomly)
		self:addElement(LUI.UITimer.new(2500, "spin_randomly", false, self))
	end
	self:beginAnimation("rotate_randomly", 2500, true, true)
	self:setZRot(math.random(-90, 90))
end

LUI.UIElement.flicker = function (self, Duration, DefaultAlpha, AlphaLow, AlphaHigh, RandomTimeLow, RandomTimeHigh)
	if not Duration then
		Duration = 1000
	end
	if not DefaultAlpha then
		DefaultAlpha = 1
	end
	if not AlphaLow then
		AlphaLow = 0.2
	end
	if not AlphaHigh then
		AlphaHigh = 0.7
	end
	if not RandomTimeLow then
		RandomTimeLow = 50
	end
	if not RandomTimeHigh then
		RandomTimeHigh = 150
	end
	self.lowFlickerAlpha = AlphaLow
	self.highFlickerAlpha = AlphaHigh
	self.endFlickerAlpha = DefaultAlpha
	self:registerEventHandler("close_flicker_timer", LUI.UIElement.CloseFlickerTimer)
	self:alternateStates(Duration, LUI.UIElement.LowFlickerAlternate, LUI.UIElement.HighFlickerAlternate, RandomTimeLow, RandomTimeHigh, LUI.UIElement.EndFlickerAlternate)
end

LUI.UIElement.LowFlickerAlternate = function (self, Time)
	self:beginAnimation("lower_alpha", Time)
	self:setAlpha(self.lowFlickerAlpha)
end

LUI.UIElement.HighFlickerAlternate = function (self, Time)
	self:beginAnimation("raise_alpha", Time)
	self:setAlpha(self.highFlickerAlpha)
end

LUI.UIElement.EndFlickerAlternate = function (self, Time)
	self:beginAnimation("end_alpha", Time)
	self:setAlpha(self.endFlickerAlpha)
	self.lowFlickerAlpha = nil
	self.highFlickerAlpha = nil
	self.endFlickerAlpha = nil
end

LUI.UIElement.CloseFlickerTimer = function (self, Event)
	if self.lowFlickerAlpha then
		self:closeStateAlternator()
	end
end

LUI.UIElement.closeStateAlternator = function (self)
	if self.alternatorTimer then
		self.alternatorTimer:close()
		self.alternatorTimer = nil
	end
	if self.alternatorEnd then
		self:alternatorEnd()
		self.alternatorEnd = nil
	end
end

LUI.UIElement.UpdateStateAlternater = function (self, Event)
	if Event.next ~= "first" and Event.next ~= "second" then
		self:closeStateAlternator()
		return 
	end
	local Next = "first"
	local fn = Event.func2
	if Event.next == "first" then
		Next = "second"
		fn = Event.func1
	end
	local Time = math.random(Event.lowTime, Event.highTime)
	if Event.timeLeft <= Time and not Event.isInfinite then
		Time = Event.timeLeft + 1
		Next = "final"
	end
	fn(self, Time)
	local TimeLeft = -1
	if not Event.isInfinite then
		TimeLeft = Event.timeLeft - Time
	end
	self.alternatorTimer = LUI.UITimer.new(Time, {
		name = "update_state_alternate",
		isInfinite = Event.isInfinite,
		next = Next,
		func1 = Event.func1,
		func2 = Event.func2,
		timeLeft = TimeLeft,
		lowTime = Event.lowTime,
		highTime = Event.highTime
	}, true, self)
	self:addElement(self.alternatorTimer)
end

LUI.UIElement.alternateStates = function (self, Duration, Function1, Function2, RandomTimeLow, RandomTimeHigh, EndFunction)
	if self.alternatorEnd then
		return 
	elseif not Duration then
		Duration = 1000
	end
	if Function1 == nil or Function2 == nil then
		return 
	elseif EndFunction == nil then
		EndFunction = Function2
	end
	if not RandomTimeLow then
		RandomTimeLow = 50
	end
	if not RandomTimeHigh then
		RandomTimeHigh = 150
	end
	self.alternatorEnd = EndFunction
	self:registerEventHandler("update_state_alternate", LUI.UIElement.UpdateStateAlternater)
	self:processEvent({
		name = "update_state_alternate",
		isInfinite = Duration == 0,
		next = "first",
		func1 = Function1,
		func2 = Function2,
		timeLeft = Duration,
		lowTime = RandomTimeLow,
		highTime = RandomTimeHigh
	})
end

LUI.UIElement.CloseAnimationQueue = function (self)
	if self.queueTimer then
		self.queueTimer:close()
		self.queueTimer = nil
	end
end

LUI.UIElement.QueueAnimation = function (self, Event)
	if #Event.queue == 0 or not self.queueTimer then
		LUI.UIElement.CloseAnimationQueue(self)
		return 
	end
	local Queue = Event.queue
	local fn = Queue[1].funct
	local Time = Queue[1].time
	if Time == nil then
		Time = 0
	end
	if fn then
		fn(self, Time, Queue[1])
	end
	if Event.repeats then
		table.insert(Queue, Queue[1])
	end
	table.remove(Queue, 1)
	self.queueTimer.interval = Time
end

LUI.UIElement.animationQueue = function (self, Queue, StartWait, Repeats)
	if self.queueTimer or not Queue then
		return 
	end
	self:registerEventHandler("queue_animation", LUI.UIElement.QueueAnimation)
	local Time = 0
	if StartWait then
		Time = StartWait
	end
	self.queueTimer = LUI.UITimer.new(Time, {
		name = "queue_animation",
		repeats = Repeats,
		queue = Queue
	}, false, self)
	self:addElement(self.queueTimer)
end

LUI.UIElement.ViewportAnimation = function (self, Event)
	if not self.viewportScaleTime then
		self.viewportScaleTime = Event.timeElapsed
	else
		self.viewportScaleTime = self.viewportScaleTime + Event.timeElapsed
	end
	local scaleFraction = self.viewportScaleTime / Event.scaleDuration
	if scaleFraction > 1 then
		scaleFraction = 1
		Event.timer:close()
		self.viewportScaleTime = nil
	end
	local Scale = Event.startScale + (Event.endScale - Event.startScale) * scaleFraction
	Engine.SetViewport(Event.controller, 0.1 - Scale / 10, 0.5 - Scale / 2, Scale)
end

LUI.UIElement.animateViewport = function (self, Controller, StartScale, EndScale, Duration)
	self:addElement(LUI.UITimer.new(1, {
		name = "viewport_animation",
		controller = Controller,
		startScale = StartScale,
		endScale = EndScale,
		scaleDuration = Duration
	}, false, self))
end

LUI.UIElement.animateToNextState = function (self, StateName, Duration, EaseIn, EaseOut)
	return function (self, Event)
		if not Event.interrupted then
			self:animateToState(StateName, Duration, EaseIn, EaseOut)
		end
	end

end

LUI.UIElement.CompleteAnimationEvent = function (self, Event)
	self:completeAnimation()
	self:dispatchEventToChildren(Event)
end

LUI.UIElement.UpdateSafeArea = function (self, Event, Controller)
	if Controller == nil and Event ~= nil then
		Controller = Event.controller
	end
	local SafeAreaLeft, SafeAreaTop, SafeAreaRight, SafeAreaBottom = Engine.GetUserSafeAreaForController(Controller)
	self:setLeftRight(false, false, SafeAreaLeft, SafeAreaRight)
	self:setTopBottom(false, false, SafeAreaTop, SafeAreaBottom)
end

LUI.UIElement.sizeToSafeArea = function (self, Controller)
	self:UpdateSafeArea(nil, Controller)
	self:registerEventHandler("update_safe_area", self.UpdateSafeArea)
end

LUI.UIElement.playBitchinFX = function (self, Duration, EaseIn, EaseOut)
	self:setShaderVector(0, 0, 0, 0, 0)
	self:beginAnimation("bitchin", Duration, EaseIn, EaseOut)
	self:setShaderVector(0, 1, 0, 0, 0)
end

LUI.UIElement.playBitchinFXReverse = function ( self, duration, easeIn, easeOut )
	self:setShaderVector( 0, 1, 0, 0, 0 )
	self:beginAnimation( "bitchin", duration, easeIn, easeOut )
	self:setShaderVector( 0, 0, 0, 0, 0 )
end

LUI.UIElement.setClass = function ( self, class )
	local elementMetatable = getmetatable( self )
	local elementTable = elementMetatable.__newindex
	local elementTableMetatable = getmetatable( elementTable )
	if not elementTableMetatable then
		setmetatable( elementTable, {
			__index = class
		} )
	else
		elementTableMetatable.__index = class
	end
	local eventHandlersMetatable = getmetatable( elementTable.m_eventHandlers )
	if not eventHandlersMetatable then
		setmetatable( elementTable.m_eventHandlers, {
			__index = class.m_eventHandlers
		} )
	else
		eventHandlersMetatable.__index = class.m_eventHandlers
	end
end

LUI.UIElement.m_eventHandlers = {
	complete_animation = LUI.UIElement.CompleteAnimationEvent,
	mousemove = LUI.UIElement.MouseMoveEvent,
	mousedown = LUI.UIElement.MouseButtonEvent,
	mouseup = LUI.UIElement.MouseButtonEvent,
	mouseclear = LUI.UIElement.MouseClear,
	gamepad_button = LUI.UIElement.GamepadButton,
	gain_focus = LUI.UIElement.gainFocus,
	lose_focus = LUI.UIElement.loseFocus,
	restore_focus = LUI.UIElement.restoreFocus,
	close = LUI.UIElement.close,
	animate = LUI.UIElement.animate,
	viewport_animation = LUI.UIElement.ViewportAnimation,
	touchpad_move = LUI.UIElement.MouseMoveEvent,
	touchpad_down = LUI.UIElement.MouseButtonEvent,
	touchpad_up = LUI.UIElement.MouseButtonEvent
}
LUI.UIElement.new = function (ElementForAnimState)
	local UIElement = ConstructLUIElement()
	LUI.UIElement.setClass(UIElement, LUI.UIElement)
	UIElement:setLayoutCached(false)
	if not ElementForAnimState then
		UIElement:registerAnimationState("default", LUI.UIElement.m_defaultAnimationState)
	else
		UIElement:registerAnimationState("default", ElementForAnimState)
	end
	UIElement:animateToState("default")
	return UIElement
end

LUI.UIElement.ContainerState = {
	left = 0,
	top = 0,
	right = 0,
	bottom = 0,
	leftAnchor = true,
	topAnchor = true,
	rightAnchor = true,
	bottomAnchor = true
}
LUI.UIContainer.new = function ()
	return LUI.UIElement.new(LUI.UIElement.ContainerState)
end

