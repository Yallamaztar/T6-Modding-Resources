require("T6.Drc.DrcOptionElement")
CoD.DrcDiscreteLeftRightSlider = {}
CoD.DrcDiscreteLeftRightSlider.Height = 72
CoD.DrcDiscreteLeftRightSlider.BarWidth = 454
CoD.DrcDiscreteLeftRightSlider.ButtonIconSize = 72
CoD.DrcDiscreteLeftRightSlider.IncButtonIconMaterial = RegisterMaterial("wiiu_drc_slider_inc_button")
CoD.DrcDiscreteLeftRightSlider.DecButtonIconMaterial = RegisterMaterial("wiiu_drc_slider_dec_button")
CoD.DrcDiscreteLeftRightSlider.KnobButtonIconMaterial = RegisterMaterial("wiiu_drc_slider_knob")
CoD.DrcDiscreteLeftRightSlider.TouchRectLeft = CoD.DrcOptionElement.HorizontalGap + CoD.DrcDiscreteLeftRightSlider.ButtonIconSize + 4 + 16
CoD.DrcDiscreteLeftRightSlider.TouchRectRight = CoD.DrcDiscreteLeftRightSlider.TouchRectLeft + CoD.DrcDiscreteLeftRightSlider.BarWidth - 6
CoD.DrcDiscreteLeftRightSlider.VerticalReleaseThreshold = 64
CoD.DrcDiscreteLeftRightSlider.DashParams = {
	totalDashes = 40,
	delta = 0,
	dashXOffset = 16
}
CoD.DrcDiscreteLeftRightSlider.SetSliderCallback = function (f1_arg0, f1_arg1)
	f1_arg0.m_sliderCallback = f1_arg1
end

CoD.DrcDiscreteLeftRightSlider.UpdateBar = function (f2_arg0)
	local f2_local0 = (f2_arg0.m_currentValue - f2_arg0.m_barMin) / (f2_arg0.m_barMax - f2_arg0.m_barMin)
	local f2_local1 = CoD.DrcDiscreteLeftRightSlider.DashParams
	f2_arg0.bar:setupDashes(f2_local1.totalDashes, math.ceil(f2_local0 * f2_local1.totalDashes - 0.5), f2_local1.delta, f2_local1.dashXOffset)
	local f2_local2 = CoD.DrcDiscreteLeftRightSlider.TouchRectLeft
	local f2_local3 = CoD.DrcDiscreteLeftRightSlider.TouchRectRight
	local f2_local4 = LUI.clamp(f2_local2 + f2_local0 * (f2_local3 - f2_local2), f2_local2, f2_local3)
	f2_arg0.m_knobButtonIcon:setLeftRight(true, false, f2_local4 - CoD.DrcDiscreteLeftRightSlider.ButtonIconSize / 2, f2_local4 + CoD.DrcDiscreteLeftRightSlider.ButtonIconSize / 2)
	f2_arg0.valueText:setText(f2_arg0.m_currentValue)
end

CoD.DrcDiscreteLeftRightSlider.UpdateValue = function (f3_arg0, f3_arg1)
	local f3_local0, f3_local1 = ProjectRootCoordinate(f3_arg1.rootName, f3_arg1.x, f3_arg1.y)
	local f3_local2, f3_local3, f3_local4, f3_local5 = f3_arg0.m_touchRect:getRect()
	local f3_local6 = LUI.clamp((f3_local0 - f3_local2) / (f3_local4 - f3_local2), 0, 1)
	local f3_local7 = f3_arg0.m_currentValue
	f3_arg0.m_currentValue = LUI.clamp(f3_arg0.m_barMin + math.ceil(f3_local6 * (f3_arg0.m_barMax - f3_arg0.m_barMin) - 0.5), f3_arg0.m_barMin, f3_arg0.m_barMax)
	if f3_arg0.m_currentValue < f3_local7 then
		Engine.PlaySound(f3_arg0.m_SFXDec)
	end
	if f3_local7 < f3_arg0.m_currentValue then
		Engine.PlaySound(f3_arg0.m_SFXInc)
	end
end

CoD.DrcDiscreteLeftRightSlider.SliderTouchpadMove = function (f4_arg0, f4_arg1)
	local f4_local0, f4_local1 = ProjectRootCoordinate(f4_arg1.rootName, f4_arg1.x, f4_arg1.y)
	if not f4_arg0.owner.m_touchActive and f4_arg0.owner:isInFocus() then
		local f4_local2, f4_local3, f4_local4, f4_local5 = f4_arg0.owner.m_knobButtonIcon:getRect()
		if f4_local2 <= f4_local0 and f4_local0 <= f4_local4 and f4_local3 <= f4_local1 and f4_local1 <= f4_local5 then
			f4_arg0.owner.m_touchActive = true
			f4_arg0.m_lastTouchX = f4_local0
			f4_arg0.m_lastTouchY = f4_local1
			f4_arg0.m_startTouchY = f4_local1
			f4_arg0.m_touchThresholdSq = CoD.Wiiu.DRAG_THRESHOLD_SQUARED
			Engine.PlaySound(f4_arg0.owner.m_SFXGrab)
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
			CoD.DrcDiscreteLeftRightSlider.UpdateValue(f4_arg0.owner, f4_arg1)
			CoD.DrcDiscreteLeftRightSlider.UpdateBar(f4_arg0.owner)
			if f4_arg0.owner.m_sliderCallback ~= nil then
				f4_arg0.owner:m_sliderCallback(f4_arg0.owner.m_currentValue)
			end
		end
	end
end

CoD.DrcDiscreteLeftRightSlider.SliderTouchpadUp = function (f5_arg0, f5_arg1)
	if f5_arg0.owner.m_touchActive == true then
		Engine.PlaySound(f5_arg0.owner.m_SFXRelease)
	end
	f5_arg0.owner.m_touchActive = false
end

CoD.DrcDiscreteLeftRightSlider.DecButtonDown = function (f6_arg0, f6_arg1)
	if f6_arg0.owner.m_hasFocus then
		if f6_arg0.owner.m_barMin < f6_arg0.owner.m_currentValue then
			Engine.PlaySound(f6_arg0.owner.m_SFXDec)
		end
		f6_arg0.owner.m_currentValue = LUI.clamp(f6_arg0.owner.m_currentValue - 1, f6_arg0.owner.m_barMin, f6_arg0.owner.m_barMax)
		CoD.DrcDiscreteLeftRightSlider.UpdateBar(f6_arg0.owner)
		if f6_arg0.owner.m_sliderCallback ~= nil then
			f6_arg0.owner:m_sliderCallback(f6_arg0.owner.m_currentValue)
		end
	end
end

CoD.DrcDiscreteLeftRightSlider.IncButtonDown = function (f7_arg0, f7_arg1)
	if f7_arg0.owner.m_hasFocus then
		if f7_arg0.owner.m_currentValue < f7_arg0.owner.m_barMax then
			Engine.PlaySound(f7_arg0.owner.m_SFXInc)
		end
		f7_arg0.owner.m_currentValue = LUI.clamp(f7_arg0.owner.m_currentValue + 1, f7_arg0.owner.m_barMin, f7_arg0.owner.m_barMax)
		CoD.DrcDiscreteLeftRightSlider.UpdateBar(f7_arg0.owner)
		if f7_arg0.owner.m_sliderCallback ~= nil then
			f7_arg0.owner:m_sliderCallback(f7_arg0.owner.m_currentValue)
		end
	end
end

CoD.DrcDiscreteLeftRightSlider.GainFocus = function (f8_arg0, f8_arg1)
	CoD.DrcOptionElement.GainFocus(f8_arg0, f8_arg1)
	f8_arg0.valueText:animateToState("highlight")
	f8_arg0.m_decButtonIcon:animateToState("highlight")
	f8_arg0.m_incButtonIcon:animateToState("highlight")
	f8_arg0.m_knobButtonIcon:animateToState("highlight")
	f8_arg0.m_hasFocus = true
	return f8_arg0:dispatchEventToChildren(f8_arg1)
end

CoD.DrcDiscreteLeftRightSlider.LoseFocus = function (f9_arg0, f9_arg1)
	CoD.DrcOptionElement.LoseFocus(f9_arg0, f9_arg1)
	f9_arg0.valueText:animateToState("default")
	f9_arg0.m_decButtonIcon:animateToState("default")
	f9_arg0.m_incButtonIcon:animateToState("default")
	f9_arg0.m_knobButtonIcon:animateToState("default")
	f9_arg0.m_hasFocus = false
	f9_arg0.m_touchActive = false
	return f9_arg0:dispatchEventToChildren(f9_arg1)
end

CoD.DrcDiscreteLeftRightSlider.new = function (f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4, f10_arg5)
	local f10_local0 = CoD.DrcOptionElement.new(f10_arg0, f10_arg1, f10_arg5)
	f10_local0.id = "DLRSlider." .. f10_arg0
	f10_local0.m_hasFocus = false
	f10_local0.m_SFXInc = "uin_slider_inc_drc"
	f10_local0.m_SFXDec = "uin_slider_dec_drc"
	f10_local0.m_SFXGrab = "uin_slider_grab_drc"
	f10_local0.m_SFXRelease = "uin_slider_release_drc"
	local f10_local1 = LUI.UIImage.new()
	f10_local1:setLeftRight(true, false, 0, CoD.DrcDiscreteLeftRightSlider.ButtonIconSize)
	f10_local1:setTopBottom(false, false, -CoD.DrcDiscreteLeftRightSlider.Height / 2, CoD.DrcDiscreteLeftRightSlider.ButtonIconSize / 2)
	f10_local1:setImage(CoD.DrcDiscreteLeftRightSlider.DecButtonIconMaterial)
	f10_local1:setRGB(CoD.DrcOptionElement.DefaultColor.red, CoD.DrcOptionElement.DefaultColor.green, CoD.DrcOptionElement.DefaultColor.blue)
	f10_local1:registerAnimationState("highlight", CoD.DrcOptionElement.HighlightColor)
	f10_local1:registerAnimationState("default", CoD.DrcOptionElement.DefaultColor)
	f10_local1.owner = f10_local0
	f10_local0.horizontalList:addElement(f10_local1)
	f10_local0.m_decButtonIcon = f10_local1
	f10_local0.horizontalList:addSpacer(16)
	f10_local0.bar = LUI.UIElement.new({
		left = 0,
		top = -CoD.DrcDiscreteLeftRightSlider.Height / 2,
		right = 27,
		bottom = CoD.DrcDiscreteLeftRightSlider.Height / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	f10_local0.horizontalList:addElement(f10_local0.bar)
	local f10_local2 = CoD.DrcDiscreteLeftRightSlider.DashParams
	f10_local0.bar:setupDashes(f10_local2.totalDashes, 0, f10_local2.delta, f10_local2.dashXOffset)
	f10_local0.m_barMin = f10_arg3
	f10_local0.m_barMax = f10_arg4
	f10_local0.m_sliderCallback = nil
	if f10_arg2 == nil then
		f10_local0.m_currentValue = (f10_arg3 + f10_arg4) / 2
	else
		f10_local0.m_currentValue = f10_arg2
	end
	f10_local0.setSliderCallback = CoD.DrcDiscreteLeftRightSlider.SetSliderCallback
	f10_local0.m_touchActive = false
	f10_local0.horizontalList:addSpacer(CoD.DrcDiscreteLeftRightSlider.BarWidth - 30)
	f10_local0.horizontalList:addSpacer(16)
	local f10_local3 = LUI.UIImage.new()
	f10_local3:setLeftRight(true, false, 0, CoD.DrcDiscreteLeftRightSlider.ButtonIconSize)
	f10_local3:setTopBottom(false, false, -CoD.DrcDiscreteLeftRightSlider.Height / 2, CoD.DrcDiscreteLeftRightSlider.ButtonIconSize / 2)
	f10_local3:setImage(CoD.DrcDiscreteLeftRightSlider.IncButtonIconMaterial)
	f10_local3:setRGB(CoD.DrcOptionElement.DefaultColor.red, CoD.DrcOptionElement.DefaultColor.green, CoD.DrcOptionElement.DefaultColor.blue)
	f10_local3:registerAnimationState("highlight", CoD.DrcOptionElement.HighlightColor)
	f10_local3:registerAnimationState("default", CoD.DrcOptionElement.DefaultColor)
	f10_local3.owner = f10_local0
	f10_local0.horizontalList:addElement(f10_local3)
	f10_local0.m_incButtonIcon = f10_local3
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
		left = CoD.DrcDiscreteLeftRightSlider.TouchRectLeft,
		top = -CoD.DrcDiscreteLeftRightSlider.Height / 2,
		right = CoD.DrcDiscreteLeftRightSlider.TouchRectRight,
		bottom = CoD.DrcDiscreteLeftRightSlider.Height / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	f10_local0.m_touchRect.owner = f10_local0
	f10_local0:addElement(f10_local0.m_touchRect)
	
	local m_knobButtonIcon = LUI.UIImage.new()
	m_knobButtonIcon:setImage(CoD.DrcDiscreteLeftRightSlider.KnobButtonIconMaterial)
	m_knobButtonIcon:setTopBottom(false, false, -CoD.DrcDiscreteLeftRightSlider.Height / 2, CoD.DrcDiscreteLeftRightSlider.ButtonIconSize / 2)
	m_knobButtonIcon:setRGB(CoD.DrcOptionElement.DefaultColor.red, CoD.DrcOptionElement.DefaultColor.green, CoD.DrcOptionElement.DefaultColor.blue)
	m_knobButtonIcon:registerAnimationState("highlight", CoD.DrcOptionElement.HighlightColor)
	m_knobButtonIcon:registerAnimationState("default", CoD.DrcOptionElement.DefaultColor)
	f10_local0:addElement(m_knobButtonIcon)
	f10_local0.m_knobButtonIcon = m_knobButtonIcon
	
	local f10_local5, f10_local6 = nil
	local f10_local7 = "touchpad_down"
	if CoD.isWIIU then
		f10_local5 = "touchpad_move"
		f10_local6 = "touchpad_up"
	else
		f10_local5 = "mousemove"
		f10_local6 = "mouseup"
	end
	f10_local0.m_touchRect:registerEventHandler(f10_local5, CoD.DrcDiscreteLeftRightSlider.SliderTouchpadMove)
	f10_local0.m_touchRect:registerEventHandler(f10_local6, CoD.DrcDiscreteLeftRightSlider.SliderTouchpadUp)
	local f10_local8 = LUI.UIButtonRepeater.new(f10_local7, "dec_button_down")
	f10_local8:setLeftRight(true, true, 0, 0)
	f10_local8:setTopBottom(true, true, 0, 0)
	f10_local0.m_decButtonIcon:addElement(f10_local8)
	f10_local0.m_decButtonIcon:registerEventHandler("dec_button_down", CoD.DrcDiscreteLeftRightSlider.DecButtonDown)
	local f10_local9 = LUI.UIButtonRepeater.new(f10_local7, "inc_button_down")
	f10_local9:setLeftRight(true, true, 0, 0)
	f10_local9:setTopBottom(true, true, 0, 0)
	f10_local0.m_incButtonIcon:addElement(f10_local9)
	f10_local0.m_incButtonIcon:registerEventHandler("inc_button_down", CoD.DrcDiscreteLeftRightSlider.IncButtonDown)
	f10_local0:registerEventHandler("gain_focus", CoD.DrcDiscreteLeftRightSlider.GainFocus)
	f10_local0:registerEventHandler("lose_focus", CoD.DrcDiscreteLeftRightSlider.LoseFocus)
	CoD.DrcDiscreteLeftRightSlider.UpdateBar(f10_local0)
	return f10_local0
end

