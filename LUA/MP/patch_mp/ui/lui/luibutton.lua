LUI.UIButton = InheritFrom(LUI.UIElement)

LUI.UIButton.GainFocusEvent = {
	name = "gain_focus"
}

LUI.UIButton.LoseFocusEvent = {
	name = "lose_focus"
}

LUI.UIButton.MouseEnter = function (self, Event)
	if self.m_leftMouseDown == nil then
		if self.m_focusable and not self:isInFocus() then
			self:processEvent({
				name = "button_over",
				controller = Event.controller
			})
		end
	elseif self.m_leftMouseDown ~= nil then
		self:processEvent({
			name = "button_over_down",
			controller = Event.controller
		})
	end
end

LUI.UIButton.MouseLeave = function (self, Event)
	if self.m_leftMouseDown == nil then
		self:processEvent({
			name = "button_up",
			controller = Event.controller
		})
	else
		self:processEvent({
			name = "button_down",
			controller = Event.controller
		})
	end
end

LUI.UIButton.LeftMouseDown = function (self, Event)
	self:processEvent({
		name = "button_over_down",
		controller = Event.controller
	})
end

LUI.UIButton.RightMouseDown = function (self, Event)
	self:processEvent({
		name = "button_over_down",
		controller = Event.controller
	})
end

LUI.UIButton.LeftMouseUp = function (self, Event)
	if Event.inside and not self.disabled then
		local EventRetVal = self:processEvent({
			name = "button_action",
			controller = Event.controller,
			mouse = true
		})
		if EventRetVal then
			return EventRetVal
		end
	end
end

LUI.UIButton.RightMouseUp = function (self, Event)
	if Event.inside and not self.disabled then
		local EventRetVal = self:processEvent({
			name = "button_actionsecondary",
			controller = Event.controller,
			mouse = true
		})
		if EventRetVal then
			return EventRetVal
		end
	end
end

LUI.UIButton.GamepadButton = function (self, Event)
	if self:handleGamepadButton(Event) then
		return true
	elseif self:isInFocus() and Event.down == true and Event.button == "primary" then
		if not self.disabled then
			self:processEvent({
				name = "button_action",
				controller = Event.controller
			})
		end
		return true
	else
		return self:dispatchEventToChildren(Event)
	end
end

LUI.UIButton.gainFocus = function (self, Event)
	local f8_local0 = self:isInFocus()
	LUI.UIButton.super.gainFocus(self, Event)
	self:processEvent({
		name = "button_over",
		controller = Event.controller
	})
	if self.actionPromptString and (not CoD.isPC or self.actionEventName) then
		self:dispatchEventToParent({
			name = "set_action_prompt_string",
			promptString = self.actionPromptString
		})
	end
end

LUI.UIButton.loseFocus = function (self, Event)
	LUI.UIButton.super.loseFocus(self, Event)
	self:processEvent({
		name = "button_up",
		controller = Event.controller
	})
end

LUI.UIButton.Up = function (self, Event)
	if self.disabled and self.m_animationStates.disabled ~= nil then
		self:animateToState("disabled", self.disableDuration)
	else
		self:animateToState("default", self.upDuration, self.upEaseIn, self.upEaseOut)
	end
	self:dispatchEventToChildren(Event)
	if self:isInFocus() then
		self:processEvent(LUI.UIButton.GainFocusEvent)
	end
end

LUI.UIButton.Over = function (self, Event)
	if self.disabled and self.m_animationStates.button_over_disabled ~= nil then
		self:animateToState("button_over_disabled", self.disableDuration)
	elseif self.m_animationStates.button_over ~= nil then
		self:animateToState("button_over", self.overDuration, self.overEaseIn, self.overEaseOut)
	end
	self:dispatchEventToChildren(Event)
end

LUI.UIButton.ElementUp = function (self, Event)

end

LUI.UIButton.ElementDown = function (self, Event)
	if self.m_animationStates.button_down ~= nil then
		self:animateToState("button_down", self.downDuration)
	else
		LUI.UIButton.ElementUp(self, Event)
	end
	self:dispatchEventToChildren(Event)
end

LUI.UIButton.ElementOverDown = function (self, Event)
	if self.m_animationStates.button_over_down ~= nil then
		self:animateToState("button_over_down", self.overDownDuration)
	else

	end
	self:dispatchEventToChildren(Event)
end

LUI.UIButton.ElementEnable = function (self, Event)
	self.disabled = nil
	self:dispatchEventToChildren(Event)
	self:processEvent({
		name = "button_up"
	})
end

LUI.UIButton.ElementDisable = function (self, Event)
	self.disabled = true
	self:dispatchEventToChildren(Event)
	self:processEvent({
		name = "button_up"
	})
end

LUI.UIButton.enable = function (self)
	self:processEvent({
		name = "enable"
	})
	self:processEvent({
		name = "button_up"
	})
end

LUI.UIButton.disable = function (self)
	self:processEvent({
		name = "disable"
	})
	self:processEvent({
		name = "button_up"
	})
end

LUI.UIButton.SetupElement = function (self)
	self:registerEventHandler("enable", LUI.UIButton.ElementEnable)
	self:registerEventHandler("disable", LUI.UIButton.ElementDisable)
	self:registerEventHandler("button_up", LUI.UIButton.Up)
	self:registerEventHandler("button_over", LUI.UIButton.Over)
	self:registerEventHandler("button_down", LUI.UIButton.ElementDown)
	self:registerEventHandler("button_over_down", LUI.UIButton.ElementOverDown)
end

LUI.UIButton.buttonAction = function (self, Event)
	if self.actionEventName ~= nil then
		self:dispatchEventToParent({
			name = self.actionEventName,
			controller = Event.controller,
			button = self
		})
		if self.actionSFX ~= nil then
			Engine.PlaySound(self.actionSFX)
		end
	end
end

LUI.UIButton.setActionEventName = function (self, EventName)
	self.actionEventName = EventName
end

LUI.UIButton.setActionPromptString = function (self, PromptString)
	self.actionPromptString = PromptString
end

LUI.UIButton.setGainFocusSFX = function (self, FocusSFX)
	self.gainFocusSFX = FocusSFX
end

LUI.UIButton.setActionSFX = function (self, ActionSFX)
	self.actionSFX = ActionSFX
end

LUI.UIButton.clearGainFocusSFX = function (self)
	self.gainFocusSFX = nil
end

LUI.UIButton.clearActionSFX = function (self)
	self.actionSFX = nil
end

LUI.UIButton.new = function (ParentElement, Event)
	local Widget = LUI.UIElement.new(ParentElement)
	Widget:setClass(LUI.UIButton)
	Widget.id = "LUIButton"
	Widget:makeFocusable()
	Widget:setHandleMouse(true)
	Widget.actionEventName = Event
	if CoD.isSinglePlayer then
		if CoD.isPC then
			Widget.gainFocusSFX = "cac_grid_nav"
		else
			Widget.gainFocusSFX = "uin_slide_nav_up"
		end
		Widget.actionSFX = "uin_main_enter"
	else
		Widget.gainFocusSFX = "cac_grid_nav"
		Widget.actionSFX = "cac_grid_equip_item"
	end
	return Widget
end

LUI.UIButton:registerEventHandler("mouseenter", LUI.UIButton.MouseEnter)
LUI.UIButton:registerEventHandler("mouseleave", LUI.UIButton.MouseLeave)
LUI.UIButton:registerEventHandler("leftmousedown", LUI.UIButton.LeftMouseDown)
LUI.UIButton:registerEventHandler("leftmouseup", LUI.UIButton.LeftMouseUp)
LUI.UIButton:registerEventHandler("rightmousedown", LUI.UIButton.RightMouseDown)
LUI.UIButton:registerEventHandler("rightmouseup", LUI.UIButton.RightMouseUp)
LUI.UIButton:registerEventHandler("gamepad_button", LUI.UIButton.GamepadButton)
LUI.UIButton:registerEventHandler("gain_focus", LUI.UIButton.gainFocus)
LUI.UIButton:registerEventHandler("lose_focus", LUI.UIButton.loseFocus)
LUI.UIButton:registerEventHandler("button_action", LUI.UIButton.buttonAction)
LUI.UIButton:SetupElement()
