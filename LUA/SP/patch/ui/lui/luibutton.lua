LUI.UIButton = InheritFrom(LUI.UIElement)
LUI.UIButton.GainFocusEvent = {
	name = "gain_focus"
}
LUI.UIButton.LoseFocusEvent = {
	name = "lose_focus"
}
LUI.UIButton.MouseEnter = function (f1_arg0, f1_arg1)
	if f1_arg0.m_leftMouseDown == nil then
		if f1_arg0.m_focusable and not f1_arg0:isInFocus() then
			f1_arg0:processEvent({
				name = "button_over",
				controller = f1_arg1.controller
			})
		end
	elseif f1_arg0.m_leftMouseDown ~= nil then
		f1_arg0:processEvent({
			name = "button_over_down",
			controller = f1_arg1.controller
		})
	end
end

LUI.UIButton.MouseLeave = function (f2_arg0, f2_arg1)
	if f2_arg0.m_leftMouseDown == nil then
		f2_arg0:processEvent({
			name = "button_up",
			controller = f2_arg1.controller
		})
	else
		f2_arg0:processEvent({
			name = "button_down",
			controller = f2_arg1.controller
		})
	end
end

LUI.UIButton.LeftMouseDown = function (f3_arg0, f3_arg1)
	f3_arg0:processEvent({
		name = "button_over_down",
		controller = f3_arg1.controller
	})
end

LUI.UIButton.RightMouseDown = function (f4_arg0, f4_arg1)
	f4_arg0:processEvent({
		name = "button_over_down",
		controller = f4_arg1.controller
	})
end

LUI.UIButton.LeftMouseUp = function (f5_arg0, f5_arg1)
	if f5_arg1.inside and not f5_arg0.disabled then
		local f5_local0 = f5_arg0:processEvent({
			name = "button_action",
			controller = f5_arg1.controller,
			mouse = true
		})
		if f5_local0 then
			return f5_local0
		end
	end
end

LUI.UIButton.RightMouseUp = function (f6_arg0, f6_arg1)
	if f6_arg1.inside and not f6_arg0.disabled then
		local f6_local0 = f6_arg0:processEvent({
			name = "button_actionsecondary",
			controller = f6_arg1.controller,
			mouse = true
		})
		if f6_local0 then
			return f6_local0
		end
	end
end

LUI.UIButton.GamepadButton = function (f7_arg0, f7_arg1)
	if f7_arg0:handleGamepadButton(f7_arg1) then
		return true
	elseif f7_arg0:isInFocus() and f7_arg1.down == true and f7_arg1.button == "primary" then
		if not f7_arg0.disabled then
			f7_arg0:processEvent({
				name = "button_action",
				controller = f7_arg1.controller
			})
		end
		return true
	else
		return f7_arg0:dispatchEventToChildren(f7_arg1)
	end
end

LUI.UIButton.gainFocus = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg0:isInFocus()
	LUI.UIButton.super.gainFocus(f8_arg0, f8_arg1)
	f8_arg0:processEvent({
		name = "button_over",
		controller = f8_arg1.controller
	})
end

LUI.UIButton.loseFocus = function (f9_arg0, f9_arg1)
	LUI.UIButton.super.loseFocus(f9_arg0, f9_arg1)
	f9_arg0:processEvent({
		name = "button_up",
		controller = f9_arg1.controller
	})
end

LUI.UIButton.Up = function (f10_arg0, f10_arg1)
	if f10_arg0.disabled and f10_arg0.m_animationStates.disabled ~= nil then
		f10_arg0:animateToState("disabled", f10_arg0.disableDuration)
	else
		f10_arg0:animateToState("default", f10_arg0.upDuration, f10_arg0.upEaseIn, f10_arg0.upEaseOut)
	end
	f10_arg0:dispatchEventToChildren(f10_arg1)
	if f10_arg0:isInFocus() then
		f10_arg0:processEvent(LUI.UIButton.GainFocusEvent)
	end
end

LUI.UIButton.Over = function (f11_arg0, f11_arg1)
	if f11_arg0.disabled and f11_arg0.m_animationStates.button_over_disabled ~= nil then
		f11_arg0:animateToState("button_over_disabled", f11_arg0.disableDuration)
	elseif f11_arg0.m_animationStates.button_over ~= nil then
		f11_arg0:animateToState("button_over", f11_arg0.overDuration, f11_arg0.overEaseIn, f11_arg0.overEaseOut)
	end
	f11_arg0:dispatchEventToChildren(f11_arg1)
end

LUI.UIButton.ElementUp = function (f12_arg0, f12_arg1)

end

LUI.UIButton.ElementDown = function (f13_arg0, f13_arg1)
	if f13_arg0.m_animationStates.button_down ~= nil then
		f13_arg0:animateToState("button_down", f13_arg0.downDuration)
	else
		LUI.UIButton.ElementUp(f13_arg0, f13_arg1)
	end
	f13_arg0:dispatchEventToChildren(f13_arg1)
end

LUI.UIButton.ElementOverDown = function (f14_arg0, f14_arg1)
	if f14_arg0.m_animationStates.button_over_down ~= nil then
		f14_arg0:animateToState("button_over_down", f14_arg0.overDownDuration)
	else

	end
	f14_arg0:dispatchEventToChildren(f14_arg1)
end

LUI.UIButton.ElementEnable = function (f15_arg0, f15_arg1)
	f15_arg0.disabled = nil
	f15_arg0:dispatchEventToChildren(f15_arg1)
	f15_arg0:processEvent({
		name = "button_up"
	})
end

LUI.UIButton.ElementDisable = function (f16_arg0, f16_arg1)
	f16_arg0.disabled = true
	f16_arg0:dispatchEventToChildren(f16_arg1)
	f16_arg0:processEvent({
		name = "button_up"
	})
end

LUI.UIButton.enable = function (f17_arg0)
	f17_arg0:processEvent({
		name = "enable"
	})
	f17_arg0:processEvent({
		name = "button_up"
	})
end

LUI.UIButton.disable = function (f18_arg0)
	f18_arg0:processEvent({
		name = "disable"
	})
	f18_arg0:processEvent({
		name = "button_up"
	})
end

LUI.UIButton.SetupElement = function (f19_arg0)
	f19_arg0:registerEventHandler("enable", LUI.UIButton.ElementEnable)
	f19_arg0:registerEventHandler("disable", LUI.UIButton.ElementDisable)
	f19_arg0:registerEventHandler("button_up", LUI.UIButton.Up)
	f19_arg0:registerEventHandler("button_over", LUI.UIButton.Over)
	f19_arg0:registerEventHandler("button_down", LUI.UIButton.ElementDown)
	f19_arg0:registerEventHandler("button_over_down", LUI.UIButton.ElementOverDown)
end

LUI.UIButton.buttonAction = function (f20_arg0, f20_arg1)
	if f20_arg0.actionEventName ~= nil then
		f20_arg0:dispatchEventToParent({
			name = f20_arg0.actionEventName,
			controller = f20_arg1.controller,
			button = f20_arg0
		})
		if f20_arg0.actionSFX ~= nil then
			Engine.PlaySound(f20_arg0.actionSFX)
		end
	end
end

LUI.UIButton.setActionEventName = function (f21_arg0, f21_arg1)
	f21_arg0.actionEventName = f21_arg1
end

LUI.UIButton.setGainFocusSFX = function (f22_arg0, f22_arg1)
	f22_arg0.gainFocusSFX = f22_arg1
end

LUI.UIButton.setActionSFX = function (f23_arg0, f23_arg1)
	f23_arg0.actionSFX = f23_arg1
end

LUI.UIButton.clearGainFocusSFX = function (f24_arg0)
	f24_arg0.gainFocusSFX = nil
end

LUI.UIButton.clearActionSFX = function (f25_arg0)
	f25_arg0.actionSFX = nil
end

LUI.UIButton.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new(HudRef)
	Widget:setClass(LUI.UIButton)
	Widget.id = "LUIButton"
	Widget:makeFocusable()
	Widget:setHandleMouse(true)
	Widget.actionEventName = InstanceRef
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
