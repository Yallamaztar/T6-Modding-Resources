CoD.DrcPanelButton = {}
CoD.DrcPanelButton.EnabledMaterial = "wiiu_drc_button_frame"
CoD.DrcPanelButton.DisabledMaterial = "menu_mp_cac_wcard_line"
CoD.DrcPanelButton.GlowMaterial = "menu_mp_cac_wcard_wc"
CoD.DrcPanelButton.Highlightmaterial = "menu_mp_cac_wcard_hl"
CoD.DrcPanelButton.AnimateUp = 50
CoD.DrcPanelButton.AnimateDown = 90
CoD.DrcPanelButton.WedgeWidth = 108
CoD.DrcPanelButton.WedgeHeight = 68
CoD.DrcPanelButton.WedgeColorUp = {
	red = 0.2,
	green = 0.23,
	blue = 0.29
}
CoD.DrcPanelButton.WedgeColorDown = {
	red = 1,
	green = 0.4,
	blue = 0,
	alpha = 1
}
CoD.DrcPanelButton.Width = 256
CoD.DrcPanelButton.Height = 256
CoD.DrcPanelButton.SensorOffsetLeft = 25 / CoD.DrcPanelButton.Height
CoD.DrcPanelButton.SensorOffsetRight = -28 / CoD.DrcPanelButton.Height
CoD.DrcPanelButton.SensorOffsetTop = 65 / CoD.DrcPanelButton.Height
CoD.DrcPanelButton.SensorOffsetBottom = -65 / CoD.DrcPanelButton.Height
CoD.DrcPanelButton.PulseDuration = 1
CoD.DrcPanelButton.PulseAnimations = {
	{
		name = "pulse_low",
		anim = {
			alpha = 1
		}
	},
	{
		name = "pulse_high",
		anim = {
			alpha = 0.3
		}
	}
}
CoD.DrcPanelButton.ButtonAnimTranslate = 8
CoD.DrcPanelButton.PulseDuration = CoD.CoD9Button.PulseDuration
CoD.DrcPanelButton.SetLabel = function (f1_arg0, f1_arg1)
	f1_arg0.label.prevText = f1_arg0.label.text
	f1_arg0.label.text = f1_arg1
	f1_arg0.label.upText = f1_arg1
	f1_arg0.label:setText(f1_arg1)
end

local f0_local0 = function (f2_arg0)
	f2_arg0.downPulseAnimations = CoD.DrcPanelButton.PulseAnimations
	for f2_local3, f2_local4 in ipairs(f2_arg0.downPulseAnimations) do
		f2_arg0:registerAnimationState(f2_local4.name, f2_local4.anim)
	end
	f2_arg0.downPulseDuration = CoD.DrcPanelButton.PulseDuration
	f2_arg0.downPulseFrame = 0
end

local f0_local1 = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg0.pulseAnimationFrame
	f3_arg0.pulseAnimationFrame = (f3_arg0.pulseAnimationFrame + 1) % 2
	f3_arg0:animateToState(f3_arg0.downPulseAnimations[1 + f3_local0].name, f3_arg0.downPulseDuration)
	f3_arg0.pulsing = true
end

CoD.DrcPanelButton.ButtonDown = function (f4_arg0, f4_arg1)
	if f4_arg0.container.glow and not f4_arg0.container.glow.disabled then
		f4_arg0.container.glow:animateToState("button_over")
	end
	if not f4_arg0.container.wedge.disabled then
		f4_arg0.container.wedge:animateToState("button_over")
	end
	local f4_local0 = f4_arg0.drawnContainer
	f4_local0:beginAnimation("press_animation", f4_arg0.animDownTime)
	f4_local0:setLeftRight(true, true, f4_local0.animTranslate, f4_local0.animTranslate)
	f4_local0:setTopBottom(true, true, f4_local0.animTranslate, f4_local0.animTranslate)
	local f4_local1 = f4_local0.label
	if f4_local1.downText then
		f4_local1:setText(f4_local1.downText)
	end
	if f4_local1.downColor then
		f4_local1:setRGB(f4_local1.downColor.red, f4_local1.downColor.green, f4_local1.downColor.blue)
	end
	if f4_local1.downPulseDuration and not f4_local1.downPulseTimer then
		f4_local1.downPulseTimer = LUI.UITimer.new(f4_local1.downPulseDuration, {
			name = "button_down_label_pulse"
		}, false, f4_local1)
		f4_local1:addElement(f4_local1.downPulseTimer)
		f4_local1.pulseAnimationFrame = 0
		f0_local1(f4_local1)
	end
end

local f0_local2 = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.button.downAnimationCompleteEvent
	if f5_local0 then
		f5_arg0.button:processEvent(f5_local0)
	end
	f5_arg0.down = true
end

CoD.DrcPanelButton.ButtonUp = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0.drawnContainer
	f6_local0:beginAnimation("up", f6_arg0.animUpTime)
	f6_local0:setLeftRight(true, true, 0, 0)
	f6_local0:setTopBottom(true, true, 0, 0)
end

local f0_local3 = function (f7_arg0, f7_arg1)
	f7_arg0.down = nil
	if not f7_arg0.wedge.disabled then
		f7_arg0.wedge:animateToState("visible", 0)
	end
	if f7_arg0.glow and not f7_arg0.glow.disabled then
		f7_arg0.glow:animateToState("hidden", 0)
	end
	local f7_local0 = f7_arg0.label
	if f7_local0.upText then
		f7_local0:setText(f7_local0.upText)
	end
	if f7_local0.upColor then
		f7_local0:setRGB(f7_local0.upColor.red, f7_local0.upColor.green, f7_local0.upColor.blue)
	end
	if f7_local0.downPulseTimer then
		f7_local0:setAlpha(1)
		f7_local0.downPulseTimer:close()
		f7_local0.downPulseTimer = nil
	end
	if f7_arg0.icon then
		f7_arg0.icon:setAlpha(1)
	end
end

local f0_local4 = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	local f8_local0 = f8_arg0.drawnContainer
	local f8_local1 = f8_local0.icon
	if not f8_local1 then
		f8_local1 = f8_arg3.new(f8_arg2)
		f8_local1:setPriority(100)
		if not f8_arg2 then
			f8_local1:setLeftRight(true, true, 0, 0)
			f8_local1:setTopBottom(true, true, 0, 0)
		end
		f8_local0:addElement(f8_local1)
		f8_local0.icon = f8_local1
	end
	if f8_arg1 then
		f8_local1:setImage(RegisterMaterial(f8_arg1))
	end
	return f8_local1
end

CoD.DrcPanelButton.SetIcon = function (f9_arg0, f9_arg1, f9_arg2)
	return f0_local4(f9_arg0, f9_arg1, f9_arg2, LUI.UIImage)
end

CoD.DrcPanelButton.SetStreamedIcon = function (f10_arg0, f10_arg1, f10_arg2)
	return f0_local4(f10_arg0, f10_arg1, f10_arg2, LUI.UIStreamedImage)
end

CoD.DrcPanelButton.AddGlow = function (f11_arg0)
	if not CoD.DrcPanelButton.DefaultAnimState_Glow then
		CoD.DrcPanelButton.DefaultAnimState_Glow = {
			alpha = 0,
			leftAnchor = true,
			rightAnchor = true,
			topAnchor = true,
			bottomAnchor = true,
			left = 0,
			right = 0,
			top = 0,
			bottom = 0
		}
	end
	local f11_local0 = LUI.UIImage.new(CoD.DrcPanelButton.DefaultAnimState_Glow)
	f11_local0.debugName = "DrcPanelButton.glow"
	f11_local0:setImage(RegisterMaterial(CoD.DrcPanelButton.GlowMaterial))
	f11_local0:registerAnimationState("button_over", {
		alpha = 1
	})
	f11_local0:registerAnimationState("hidden", {
		alpha = 0
	})
	f11_local0:setPriority(20)
	f11_arg0.drawnContainer.glow = f11_local0
	f11_arg0.drawnContainer:addElement(f11_local0)
	f11_arg0.glow = f11_local0
end

CoD.DrcPanelButton.new = function (f12_arg0, f12_arg1, f12_arg2, f12_arg3)
	if not f12_arg0 then
		if not CoD.DrcPanelButton.DefaultAnimState_Container then
			CoD.DrcPanelButton.DefaultAnimState_Container = {
				leftAnchor = true,
				rightAnchor = false,
				topAnchor = true,
				bottomAnchor = false,
				left = 0,
				right = CoD.DrcPanelButton.Width,
				top = 0,
				bottom = CoD.DrcPanelButton.Height
			}
		end
		f12_arg0 = CoD.DrcPanelButton.DefaultAnimState_Container
	end
	local f12_local0 = f12_arg0.right - f12_arg0.left
	local f12_local1 = f12_arg0.bottom - f12_arg0.top
	if not CoD.DrcPanelButton.DefaultAnimState_Full then
		CoD.DrcPanelButton.DefaultAnimState_Full = {
			leftAnchor = true,
			rightAnchor = true,
			topAnchor = true,
			bottomAnchor = true,
			left = 0,
			right = 0,
			top = 0,
			bottom = 0,
			red = CoD.DrcPanelButton.WedgeColorUp.red,
			green = CoD.DrcPanelButton.WedgeColorUp.green,
			blue = CoD.DrcPanelButton.WedgeColorUp.blue
		}
	end
	local f12_local2 = LUI.UIImage.new(CoD.DrcPanelButton.DefaultAnimState_Full)
	f12_local2.debugName = "DrcPanelButton.wedge"
	f12_local2:setImage(RegisterMaterial(CoD.DrcPanelButton.EnabledMaterial))
	f12_local2:registerAnimationState("button_over", CoD.DrcPanelButton.WedgeColorDown)
	f12_local2:registerAnimationState("visible", CoD.DrcPanelButton.WedgeColorUp)
	f12_local2:setPriority(20)
	local f12_local3 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = false,
		left = -120,
		right = 0,
		top = 64,
		bottom = 64 + CoD.CoD9Button.TextHeight
	})
	f12_local3.pulseAnimationFrame = 0
	f12_local3:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f12_local3.fontName = "Condensed"
	f12_local3:setFont(CoD.fonts[f12_local3.fontName])
	f12_local3.debugName = "DrcPanelButton.text"
	f12_local3:registerEventHandler("button_down_label_pulse", f0_local1)
	f12_local3.setupButtonDownPulsing = f0_local0
	local Widget = LUI.UIElement.new(CoD.DrcPanelButton.DefaultAnimState_Full)
	Widget.animTranslate = CoD.DrcPanelButton.ButtonAnimTranslate * f12_local0 / CoD.DrcPanelButton.Width
	Widget.wedge = f12_local2
	Widget.label = f12_local3
	Widget:addElement(f12_local2)
	Widget:addElement(f12_local3)
	Widget:registerAnimationState("press_animation", {
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		left = 8,
		right = 8,
		top = 8,
		bottom = 8
	})
	Widget:registerEventHandler("transition_complete_press_animation", f0_local2)
	Widget:registerEventHandler("transition_complete_up", f0_local3)
	local f12_local5 = {
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		left = f12_local0 * CoD.DrcPanelButton.SensorOffsetLeft,
		right = f12_local0 * CoD.DrcPanelButton.SensorOffsetRight,
		top = f12_local1 * CoD.DrcPanelButton.SensorOffsetTop,
		bottom = f12_local1 * CoD.DrcPanelButton.SensorOffsetBottom
	}
	if not f12_arg2 then
		f12_arg2 = LUI.UITouchpadButton
	end
	local f12_local6 = f12_arg2.new(f12_local5, f12_arg1, f12_arg3)
	if f12_arg3 then
		f12_local6.debugName = "button.UIButton." .. f12_arg3
	end
	f12_local6:registerEventHandler("button_over_down", CoD.DrcPanelButton.ButtonDown)
	f12_local6:registerEventHandler("button_up", CoD.DrcPanelButton.ButtonUp)
	f12_local6.actionSFX = "uin_button_press_drc"
	f12_local6.drawnContainer = Widget
	f12_local6.animUpTime = CoD.DrcPanelButton.AnimateUp
	f12_local6.animDownTime = CoD.DrcPanelButton.AnimateDown
	f12_local6:setHandleMouseButton(true)
	local Widget = LUI.UIElement.new(f12_arg0)
	Widget:addElement(Widget)
	Widget:addElement(f12_local6)
	Widget.wedge = f12_local2
	Widget.label = f12_local3
	Widget.button = f12_local6
	Widget.getHeight = function (f13_arg0)
		return CoD.DrcPanelButton.Height / 1.75
	end

	Widget.drawnContainer = Widget
	Widget.setLabel = CoD.DrcPanelButton.SetLabel
	Widget.setIcon = CoD.DrcPanelButton.SetIcon
	Widget.setStreamedIcon = CoD.DrcPanelButton.SetStreamedIcon
	Widget.setupLabelFocusedAndUnfocused = CoD.DrcPanelButton.SetupLabelFocusedAndUnfocused
	Widget.setActionEventName = function (f14_arg0, f14_arg1)
		f14_arg0.button.actionEventName = f14_arg1
	end

	local f12_local8 = function (f15_arg0, f15_arg1)

	end

	Widget.gainFocus = f12_local8
	Widget.loseFocus = f12_local8
	Widget.addGlow = CoD.DrcPanelButton.AddGlow
	f12_local6.container = Widget
	Widget.button = f12_local6
	Widget:registerEventHandler("gain_focus", CoD.DrcPanelButton.GainFocus)
	Widget:registerEventHandler("lose_focus", CoD.DrcPanelButton.LoseFocus)
	return Widget
end

