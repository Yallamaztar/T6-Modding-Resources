CoD.AdditiveTextOverlay = {}
CoD.AdditiveTextOverlay.PulseInTime = 500
CoD.AdditiveTextOverlay.PulseOutTime = 250
CoD.AdditiveTextOverlay.ColorShiftTime = 500
CoD.AdditiveTextOverlay.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6)
	if f1_arg6 == nil then
		if nil == CoD.AdditiveTextOverlay.GlowMaterial then
			CoD.AdditiveTextOverlay.GlowMaterial = RegisterMaterial("hud_lui_scorefeed_glow")
		end
		f1_arg6 = CoD.AdditiveTextOverlay.GlowMaterial
	end
	local Widget = LUI.UIElement.new(f1_arg5)
	local f1_local1 = -5
	local f1_local2 = f1_arg0 * 2.5
	local f1_local3 = f1_arg1 * 4
	
	local glow = LUI.UIImage.new({
		left = -f1_local2 / 2,
		top = -f1_local3 / 2 + f1_local1,
		right = f1_local2 / 2,
		bottom = f1_local3 / 2 + f1_local1,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = f1_arg2.r,
		green = f1_arg2.g,
		blue = f1_arg2.b,
		material = f1_arg6
	})
	glow:registerAnimationState("initial", {
		red = 1,
		green = 1,
		blue = 1
	})
	glow:registerAnimationState("out", {
		left = -f1_arg0 / 2,
		top = 0,
		right = f1_arg0 / 2,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = 0,
		green = 0,
		blue = 0
	})
	glow:animateToState("initial")
	glow:animateToState("default", CoD.AdditiveTextOverlay.PulseInTime)
	Widget:addElement(glow)
	Widget.glow = glow
	
	local f1_local5 = f1_local2 * 0.5
	local f1_local6 = f1_local3 * 0.5
	
	local innerGlow = LUI.UIImage.new({
		left = -f1_local5 / 2,
		top = -f1_local6 / 2 + f1_local1,
		right = f1_local5 / 2,
		bottom = f1_local6 / 2 + f1_local1,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = f1_arg3.r,
		green = f1_arg3.g,
		blue = f1_arg3.b,
		material = f1_arg6
	})
	innerGlow:registerAnimationState("color", {
		red = f1_arg3.r,
		green = f1_arg3.g,
		blue = f1_arg3.b
	})
	innerGlow:registerAnimationState("color2", {
		red = f1_arg4.r,
		green = f1_arg4.g,
		blue = f1_arg4.b
	})
	innerGlow:animateToState("color2", CoD.AdditiveTextOverlay.ColorShiftTime, true, true)
	innerGlow:registerEventHandler("transition_complete_color", CoD.AdditiveTextOverlay.Color)
	innerGlow:registerEventHandler("transition_complete_color2", CoD.AdditiveTextOverlay.Color2)
	Widget:addElement(innerGlow)
	Widget.innerGlow = innerGlow
	
	Widget.out = CoD.AdditiveTextOverlay.Out
	Widget:registerEventHandler("out", CoD.AdditiveTextOverlay.Out)
	return Widget
end

CoD.AdditiveTextOverlay.newWithText = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6)
	local f2_local0 = CoD.fonts[f2_arg1]
	local f2_local1 = CoD.textSize[f2_arg1]
	local f2_local2, f2_local3, f2_local4, f2_local5 = GetTextDimensions(f2_arg0, f2_local0, f2_local1)
	local f2_local6 = f2_local4 + f2_local2
	local Widget = LUI.UIElement.new(f2_arg5)
	local f2_local8 = nil
	if f2_arg6 == LUI.Alignment.Left then
		f2_local8 = {
			left = 0,
			top = 0,
			right = f2_local6,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		}
	else
		f2_local8 = {
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true
		}
	end
	local label = LUI.UIText.new()
	label:setLeftRight(true, true, 0, 0)
	label:setTopBottom(true, true, 0, 0)
	label:setFont(f2_local0)
	label:setText(f2_arg0)
	if f2_arg6 then
		label:setAlignment(f2_arg6)
	end
	Widget.text = f2_arg0
	Widget:addElement(label)
	Widget.label = label
	
	local glow = CoD.AdditiveTextOverlay.new(f2_local6, f2_local1, f2_arg2, f2_arg3, f2_arg4, f2_local8)
	Widget:addElement(glow)
	Widget.glow = glow
	
	Widget.innerColor1 = f2_arg3
	Widget.addAnimationStateForFont = CoD.AdditiveTextOverlay.TextContainer_AddAnimationStateForFont
	Widget.out = CoD.AdditiveTextOverlay.TextContainer_Out
	Widget.closeAfterTime = CoD.AdditiveTextOverlay.TextContainer_CloseAfterTime
	return Widget
end

CoD.AdditiveTextOverlay.Color = function (f3_arg0, f3_arg1)
	if f3_arg1.interrupted ~= true then
		f3_arg0:animateToState("color2", CoD.AdditiveTextOverlay.ColorShiftTime, true, true)
	end
end

CoD.AdditiveTextOverlay.Color2 = function (f4_arg0, f4_arg1)
	if f4_arg1.interrupted ~= true then
		f4_arg0:animateToState("color", CoD.AdditiveTextOverlay.ColorShiftTime, true, true)
	end
end

CoD.AdditiveTextOverlay.Out = function (f5_arg0, f5_arg1)
	f5_arg0.glow:animateToState("initial")
	f5_arg0.glow:animateToState("out", CoD.AdditiveTextOverlay.PulseOutTime)
	f5_arg0.innerGlow:close()
end

CoD.AdditiveTextOverlay.TextContainer_AddAnimationStateForFont = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = CoD.fonts[f6_arg1]
	local f6_local1 = CoD.textSize[f6_arg1]
	local f6_local2, f6_local3, f6_local4, f6_local5 = GetTextDimensions(f6_arg0.text, f6_local0, f6_local1)
	local f6_local6 = f6_local4 + f6_local2
	local f6_local7 = -5
	local f6_local8 = f6_local6 * 2.5
	local f6_local9 = f6_local1 * 4
	f6_arg0.glow.glow:registerAnimationState(f6_arg2, {
		left = -f6_local8 / 2,
		top = -f6_local9 / 2 + f6_local7,
		right = f6_local8 / 2,
		bottom = f6_local9 / 2 + f6_local7,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	local f6_local10 = f6_local8 * 0.5
	local f6_local11 = f6_local9 * 0.5
	f6_arg0.glow.innerGlow:registerAnimationState(f6_arg2, {
		left = -f6_local10 / 2,
		top = -f6_local11 / 2 + f6_local7,
		right = f6_local10 / 2,
		bottom = f6_local11 / 2 + f6_local7,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = f6_arg0.innerColor1.r,
		green = f6_arg0.innerColor1.g,
		blue = f6_arg0.innerColor1.b
	})
	f6_arg0.glow.innerGlow:registerEventHandler("transition_complete_" .. f6_arg2, CoD.AdditiveTextOverlay.Color)
end

CoD.AdditiveTextOverlay.TextContainer_Out = function (f7_arg0, f7_arg1)
	f7_arg0.glow:out()
	f7_arg0.label:close()
end

CoD.AdditiveTextOverlay.TextContainer_CloseAfterTime = function (f8_arg0, f8_arg1)
	f8_arg0:addElement(LUI.UITimer.new(f8_arg1, "out", true, f8_arg0.glow))
	f8_arg0:addElement(LUI.UITimer.new(f8_arg1, "close", true, f8_arg0.label))
end

