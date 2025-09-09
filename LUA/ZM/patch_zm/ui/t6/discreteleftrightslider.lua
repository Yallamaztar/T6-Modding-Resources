CoD.DiscreteLeftRightSlider = {}
CoD.DiscreteLeftRightSlider.Width = 100
CoD.DiscreteLeftRightSlider.Height = 32
CoD.DiscreteLeftRightSlider.SetSliderCallback = function (f1_arg0, f1_arg1)
	f1_arg0.m_sliderCallback = f1_arg1
end

CoD.DiscreteLeftRightSlider.UpdateBar = function (f2_arg0)
	f2_arg0.bar:setupDashes(20, math.ceil((f2_arg0.m_currentValue - f2_arg0.m_barMin) / (f2_arg0.m_barMax - f2_arg0.m_barMin) * 20 - 0.5), 0, 8)
	f2_arg0.valueText:setText(f2_arg0.m_currentValue)
end

CoD.DiscreteLeftRightSlider.Slider_Move = function (f3_arg0, f3_arg1)
	if f3_arg0:isInFocus() then
		if f3_arg1.name == "discrete_slider_left" then
			f3_arg0.m_currentValue = LUI.clamp(f3_arg0.m_currentValue - f3_arg0.m_barStep, f3_arg0.m_barMin, f3_arg0.m_barMax)
		elseif f3_arg1.name == "discrete_slider_right" then
			f3_arg0.m_currentValue = LUI.clamp(f3_arg0.m_currentValue + f3_arg0.m_barStep, f3_arg0.m_barMin, f3_arg0.m_barMax)
		end
		CoD.DiscreteLeftRightSlider.UpdateBar(f3_arg0)
		if f3_arg0.m_sliderCallback ~= nil then
			f3_arg0:m_sliderCallback(f3_arg0.m_currentValue)
		end
	end
end

CoD.DiscreteLeftRightSlider.new = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6, f4_arg7)
	local f4_local0 = CoD.OptionElement.new(f4_arg0, f4_arg1, f4_arg7)
	if f4_arg2 == nil then
		f4_arg2 = CoD.DiscreteLeftRightSlider.Width
	end
	f4_local0.id = "DLRSlider." .. f4_arg0
	f4_local0.bar = LUI.UIElement.new({
		left = 0,
		top = -CoD.DiscreteLeftRightSlider.Height / 2,
		right = 16,
		bottom = CoD.DiscreteLeftRightSlider.Height / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	f4_local0.horizontalList:addElement(f4_local0.bar)
	f4_local0.bar:setupDashes(20, 0, 0, 18)
	f4_local0.m_barWidth = f4_arg2
	f4_local0.m_barMin = f4_arg4
	f4_local0.m_barMax = f4_arg5
	if f4_arg3 == nil then
		f4_local0.m_currentValue = (f4_arg4 + f4_arg5) / 2
	else
		f4_local0.m_currentValue = f4_arg3
	end
	f4_local0.setSliderCallback = CoD.DiscreteLeftRightSlider.SetSliderCallback
	if f4_arg6 == nil then
		f4_arg6 = 1
	end
	f4_local0.m_barStep = f4_arg6
	f4_local0.horizontalList:addSpacer(160)
	f4_local0.valueText = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.CoD9Button.TextHeight / 2,
		bottom = CoD.CoD9Button.TextHeight / 2,
		alpha = 1,
		font = CoD.fonts.Condensed
	})
	if CoD.isSinglePlayer then
		f4_local0.valueText:registerAnimationState("disabled", {
			red = CoD.visorBlue2.r,
			green = CoD.visorBlue2.g,
			blue = CoD.visorBlue2.b
		})
	else
		f4_local0.valueText:registerAnimationState("disabled", {
			red = CoD.offWhite.r,
			green = CoD.offWhite.g,
			blue = CoD.offWhite.b,
			alpha = 0.5
		})
	end
	f4_local0.valueText:registerAnimationState("default", {
		red = CoD.ButtonTextColor.r,
		green = CoD.ButtonTextColor.g,
		blue = CoD.ButtonTextColor.b,
		alpha = 1
	})
	f4_local0.valueText:registerAnimationState("button_over", {
		red = CoD.BOIIOrange.r,
		green = CoD.BOIIOrange.g,
		blue = CoD.BOIIOrange.b,
		alpha = 1
	})
	f4_local0.horizontalList:addElement(f4_local0.valueText)
	CoD.CoD9Button.SetupTextElement(f4_local0.valueText)
	f4_local0.valueText.overDuration = nil
	f4_local0.valueText.upDuration = nil
	f4_local0.buttonRepeaterLeft = LUI.UIButtonRepeater.new("left", "discrete_slider_left")
	f4_local0:addElement(f4_local0.buttonRepeaterLeft)
	f4_local0.buttonRepeaterRight = LUI.UIButtonRepeater.new("right", "discrete_slider_right")
	f4_local0:addElement(f4_local0.buttonRepeaterRight)
	f4_local0:registerEventHandler("discrete_slider_left", CoD.DiscreteLeftRightSlider.Slider_Move)
	f4_local0:registerEventHandler("discrete_slider_right", CoD.DiscreteLeftRightSlider.Slider_Move)
	f4_local0:registerEventHandler("gain_focus", CoD.LeftRightSlider.GainFocus)
	f4_local0:registerEventHandler("lose_focus", CoD.LeftRightSlider.LoseFocus)
	CoD.DiscreteLeftRightSlider.UpdateBar(f4_local0)
	return f4_local0
end

