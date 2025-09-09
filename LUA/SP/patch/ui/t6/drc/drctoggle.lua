require("T6.Drc.DrcOptionElement")
require("T6.Drc.DrcDiscreteLeftRightSlider")
CoD.DrcToggle = {}
CoD.DrcToggle.Height = 72
CoD.DrcToggle.ButtonIconSize = 72
CoD.DrcToggle.ToggleWidth = 160
CoD.DrcToggle.ToggleBackgroundMaterial = RegisterMaterial("wiiu_drc_toggle_slider_background")
CoD.DrcToggle.KnobButtonIconMaterial = RegisterMaterial("wiiu_drc_slider_knob")
CoD.DrcToggle.TouchRectLeft = CoD.DrcDiscreteLeftRightSlider.TouchRectLeft
CoD.DrcToggle.TouchRectRight = CoD.DrcToggle.TouchRectLeft + CoD.DrcToggle.ToggleWidth
CoD.DrcToggle.EnabledXPos = CoD.DrcToggle.TouchRectRight - CoD.DrcToggle.ButtonIconSize
CoD.DrcToggle.DisabledXPos = CoD.DrcToggle.TouchRectLeft
CoD.DrcToggle.ToggleAnimTime = 100
CoD.DrcToggle.VerticalReleaseThreshold = 64
CoD.DrcToggle.TapDistThreshold = 16
CoD.DrcToggle.SetToggleCallback = function (f1_arg0, f1_arg1)
	f1_arg0.m_toggleCallback = f1_arg1
end

CoD.DrcToggle.UpdateToggle = function (f2_arg0)
	f2_arg0.m_knobButtonIcon:beginAnimation("toggle", CoD.DrcToggle.ToggleAnimTime)
	if f2_arg0.m_currentValue > 0 then
		f2_arg0.m_knobButtonIcon:setLeftRight(true, false, CoD.DrcToggle.EnabledXPos, CoD.DrcToggle.EnabledXPos + CoD.DrcToggle.ButtonIconSize)
		f2_arg0.valueText:setText(Engine.Localize("MENU_ENABLED_CAPS"))
	else
		f2_arg0.m_knobButtonIcon:setLeftRight(true, false, CoD.DrcToggle.DisabledXPos, CoD.DrcToggle.DisabledXPos + CoD.DrcToggle.ButtonIconSize)
		f2_arg0.valueText:setText(Engine.Localize("MENU_DISABLED_CAPS"))
	end
end

CoD.DrcToggle.UpdateValue = function (f3_arg0, f3_arg1)
	local f3_local0, f3_local1 = ProjectRootCoordinate(f3_arg1.rootName, f3_arg1.x, f3_arg1.y)
	local f3_local2, f3_local3, f3_local4, f3_local5 = f3_arg0.m_touchRect:getRect()
	if f3_local2 + (CoD.DrcToggle.TouchRectRight - CoD.DrcToggle.TouchRectLeft) / 2 < f3_local0 then
		f3_arg0.m_currentValue = 1
	else
		f3_arg0.m_currentValue = 0
	end
end

CoD.DrcToggle.ToggleTouchpadMove = function (f4_arg0, f4_arg1)
	local f4_local0, f4_local1 = ProjectRootCoordinate(f4_arg1.rootName, f4_arg1.x, f4_arg1.y)
	if not f4_arg0.owner.m_touchActive and f4_arg0.owner:isInFocus() then
		local f4_local2, f4_local3, f4_local4, f4_local5 = f4_arg0:getRect()
		if f4_local2 <= f4_local0 and f4_local0 <= f4_local4 and f4_local3 <= f4_local1 and f4_local1 <= f4_local5 then
			f4_arg0.owner.m_touchActive = true
			f4_arg0.m_lastTouchX = f4_local0
			f4_arg0.m_lastTouchY = f4_local1
			f4_arg0.m_startTouchY = f4_local1
			f4_arg0.m_touchThresholdSq = CoD.Wiiu.DRAG_THRESHOLD_SQUARED
		end
	end
	if f4_arg0.owner.m_touchActive then
		local f4_local2 = math.abs(f4_local0 - f4_arg0.m_lastTouchX)
		local f4_local3 = math.abs(f4_local1 - f4_arg0.m_lastTouchY)
		local f4_local4 = f4_local2 * f4_local2 + f4_local3 * f4_local3
		local f4_local5 = false
		if f4_arg0.m_touchThresholdSq <= f4_local4 then
			if f4_arg0.m_touchThresholdSq == CoD.Wiiu.DRAG_THRESHOLD_SQUARED then
				LUI.roots.UIRootDrc:processEvent({
					name = "disable_drag"
				})
			end
			f4_arg0.m_lastTouchX = f4_local0
			f4_arg0.m_lastTouchY = f4_local1
			f4_arg0.m_touchThresholdSq = 2
			f4_local5 = true
		end
		if f4_local5 then
			local f4_local6 = f4_arg0.owner.m_currentValue
			CoD.DrcToggle.UpdateValue(f4_arg0.owner, f4_arg1)
			if f4_arg0.owner.m_currentValue ~= f4_local6 then
				CoD.DrcToggle.UpdateToggle(f4_arg0.owner)
				Engine.PlaySound(f4_arg0.owner.m_toggleSFX)
			end
			if f4_arg0.owner.m_toggleCallback ~= nil then
				f4_arg0.owner:m_toggleCallback(f4_arg0.owner.m_currentValue)
			end
		end
	end
end

CoD.DrcToggle.TapTimerExpired = function (f5_arg0, f5_arg1)
	if f5_arg0.tapTimer then
		f5_arg0.tapTimer:close()
		f5_arg0.tapTimer = nil
	end
end

CoD.DrcToggle.ToggleTouchpadDown = function (f6_arg0, f6_arg1)
	local f6_local0, f6_local1 = ProjectRootCoordinate(f6_arg1.rootName, f6_arg1.x, f6_arg1.y)
	local f6_local2, f6_local3, f6_local4, f6_local5 = f6_arg0:getRect()
	if f6_local2 <= f6_local0 and f6_local0 <= f6_local4 and f6_local3 <= f6_local1 and f6_local1 <= f6_local5 then
		if f6_arg0.tapTimer then
			f6_arg0.tapTimer:close()
			f6_arg0.tapTimer = nil
		end
		f6_arg0.downX = f6_local0
		f6_arg0.downY = f6_local1
		f6_arg0.tapTimer = LUI.UITimer.new(CoD.Wiiu.DRAG_DISABLED_AFTER, "tap_timer_expired", true, f6_arg0)
		f6_arg0:addElement(f6_arg0.tapTimer)
	end
end

CoD.DrcToggle.ToggleTouchpadUp = function (f7_arg0, f7_arg1)
	f7_arg0.owner.m_touchActive = false
	if f7_arg0.tapTimer then
		local f7_local0, f7_local1 = ProjectRootCoordinate(f7_arg1.rootName, f7_arg1.x, f7_arg1.y)
		local f7_local2 = math.abs(f7_arg0.downX - f7_local0)
		local f7_local3 = math.abs(f7_arg0.downY - f7_local1)
		if math.sqrt(f7_local2 * f7_local2 + f7_local3 * f7_local3) < CoD.DrcToggle.TapDistThreshold then
			if f7_arg0.owner.m_currentValue > 0 then
				f7_arg0.owner.m_currentValue = 0
			else
				f7_arg0.owner.m_currentValue = 1
			end
			CoD.DrcToggle.UpdateToggle(f7_arg0.owner)
			Engine.PlaySound(f7_arg0.owner.m_toggleSFX)
			if f7_arg0.owner.m_toggleCallback ~= nil then
				f7_arg0.owner:m_toggleCallback(f7_arg0.owner.m_currentValue)
			end
		end
		f7_arg0.tapTimer:close()
		f7_arg0.tapTimer = nil
	end
end

CoD.DrcToggle.GainFocus = function (f8_arg0, f8_arg1)
	CoD.DrcOptionElement.GainFocus(f8_arg0, f8_arg1)
	f8_arg0.valueText:animateToState("highlight")
	f8_arg0.m_knobButtonIcon:animateToState("highlight")
	return f8_arg0:dispatchEventToChildren(f8_arg1)
end

CoD.DrcToggle.LoseFocus = function (f9_arg0, f9_arg1)
	CoD.DrcOptionElement.LoseFocus(f9_arg0, f9_arg1)
	f9_arg0.valueText:animateToState("default")
	f9_arg0.m_knobButtonIcon:animateToState("default")
	return f9_arg0:dispatchEventToChildren(f9_arg1)
end

CoD.DrcToggle.new = function (f10_arg0, f10_arg1, f10_arg2, f10_arg3)
	local f10_local0 = CoD.DrcOptionElement.new(f10_arg0, f10_arg1, f10_arg3)
	f10_local0.id = "DLRToggle." .. f10_arg0
	f10_local0.m_toggleCallback = nil
	if f10_arg2 ~= 1 then
		f10_local0.m_currentValue = 0
	else
		f10_local0.m_currentValue = 1
	end
	f10_local0.setToggleCallback = CoD.DrcToggle.SetToggleCallback
	f10_local0.m_touchActive = false
	f10_local0.m_toggleSFX = "uin_toggle_drc"
	f10_local0.horizontalList:addSpacer(CoD.DrcToggle.ButtonIconSize + 20)
	local f10_local1 = LUI.UIImage.new()
	f10_local1:setLeftRight(true, false, 0, CoD.DrcToggle.ToggleWidth)
	f10_local1:setTopBottom(false, false, -CoD.DrcToggle.ButtonIconSize / 2, CoD.DrcToggle.ButtonIconSize / 2)
	f10_local1:setImage(CoD.DrcToggle.ToggleBackgroundMaterial)
	f10_local0.horizontalList:addElement(f10_local1)
	f10_local0.m_toggleBackground = f10_local1
	f10_local0.horizontalList:addSpacer(16)
	f10_local0.valueText = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.DrcOptionElement.TextHeight / 2,
		bottom = CoD.DrcOptionElement.TextHeight / 2,
		red = CoD.DrcOptionElement.DefaultColor.red,
		green = CoD.DrcOptionElement.DefaultColor.green,
		blue = CoD.DrcOptionElement.DefaultColor.blue,
		alpha = CoD.DrcOptionElement.DefaultColor.alpha,
		font = CoD.fonts.Condensed
	})
	f10_local0.valueText:setAlignment(LUI.Alignment.Left)
	f10_local0.horizontalList:addElement(f10_local0.valueText)
	f10_local0.valueText:registerAnimationState("highlight", CoD.DrcOptionElement.HighlightColor)
	f10_local0.valueText:registerAnimationState("default", CoD.DrcOptionElement.DefaultColor)
	f10_local0.m_touchRect = LUI.UIElement.new({
		left = CoD.DrcToggle.TouchRectLeft,
		top = -CoD.DrcToggle.Height / 2,
		right = CoD.DrcToggle.TouchRectRight,
		bottom = CoD.DrcToggle.Height / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	f10_local0.m_touchRect.owner = f10_local0
	f10_local0.m_touchRect.downX = 0
	f10_local0.m_touchRect.downY = 0
	f10_local0:addElement(f10_local0.m_touchRect)
	
	local m_knobButtonIcon = LUI.UIImage.new()
	m_knobButtonIcon:setImage(CoD.DrcToggle.KnobButtonIconMaterial)
	m_knobButtonIcon:setTopBottom(false, false, -CoD.DrcToggle.ButtonIconSize / 2, CoD.DrcToggle.ButtonIconSize / 2)
	m_knobButtonIcon:setRGB(CoD.DrcOptionElement.DefaultColor.red, CoD.DrcOptionElement.DefaultColor.green, CoD.DrcOptionElement.DefaultColor.blue)
	m_knobButtonIcon:registerAnimationState("highlight", CoD.DrcOptionElement.HighlightColor)
	m_knobButtonIcon:registerAnimationState("default", CoD.DrcOptionElement.DefaultColor)
	f10_local0:addElement(m_knobButtonIcon)
	f10_local0.m_knobButtonIcon = m_knobButtonIcon
	
	local f10_local3, f10_local4 = nil
	local f10_local5 = "touchpad_down"
	if CoD.isWIIU then
		f10_local3 = "touchpad_move"
		f10_local4 = "touchpad_up"
	else
		f10_local3 = "mousemove"
		f10_local4 = "mouseup"
	end
	f10_local0.m_touchRect:registerEventHandler(f10_local3, CoD.DrcToggle.ToggleTouchpadMove)
	f10_local0.m_touchRect:registerEventHandler(f10_local4, CoD.DrcToggle.ToggleTouchpadUp)
	f10_local0.m_touchRect:registerEventHandler(f10_local5, CoD.DrcToggle.ToggleTouchpadDown)
	f10_local0.m_touchRect:registerEventHandler("tap_timer_expired", CoD.DrcToggle.TapTimerExpired)
	f10_local0:registerEventHandler("gain_focus", CoD.DrcToggle.GainFocus)
	f10_local0:registerEventHandler("lose_focus", CoD.DrcToggle.LoseFocus)
	CoD.DrcToggle.UpdateToggle(f10_local0)
	return f10_local0
end

