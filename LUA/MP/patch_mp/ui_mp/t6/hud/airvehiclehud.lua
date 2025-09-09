CoD.AirVehicleHUD = {}
CoD.AirVehicleHUD.TopBarHeight = 64
CoD.AirVehicleHUD.BottomBarHeight = 70
CoD.AirVehicleHUD.LeftBarWidth = 64
CoD.AirVehicleHUD.BottomTextOffset = 8
CoD.AirVehicleHUD.WeaponTypeWidth = 40
CoD.AirVehicleHUD.WeaponTypeHeight = CoD.textSize.Condensed
CoD.AirVehicleHUD.Alpha = 0.5
CoD.AirVehicleHUD.WeaponTypeSpacing = 25
CoD.AirVehicleHUD.HUDColor = {
	r = 0.18,
	g = 0.7,
	b = 0.59
}
CoD.AirVehicleHUD.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5)
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	Widget.filterName = f1_arg5
	Widget.vehicle = f1_arg0
	Widget.controller = f1_arg1
	if not f1_arg2 then
		f1_arg2 = CoD.AirVehicleHUD.HUDColor.r
		f1_arg3 = CoD.AirVehicleHUD.HUDColor.g
		f1_arg4 = CoD.AirVehicleHUD.HUDColor.b
	end
	Widget.colorR = f1_arg2
	Widget.colorG = f1_arg3
	Widget.colorB = f1_arg4
	local f1_local1, f1_local2 = Engine.GetUserSafeArea()
	f1_local1 = 4 * f1_local2 / 3
	
	local centerBox = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f1_local1 / 2,
		right = f1_local1 / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = -f1_local2 / 2,
		bottom = f1_local2 / 2
	})
	Widget:addElement(centerBox)
	Widget.centerBox = centerBox
	
	Widget.safeAreaContainer = LUI.UIElement.new()
	Widget.safeAreaContainer:sizeToSafeArea(f1_arg1)
	Widget:addElement(Widget.safeAreaContainer)
	local f1_local4 = CoD.SplitscreenScaler.new(nil, CoD.SplitscreenMultiplier)
	f1_local4:setLeftRight(true, false, 0, 0)
	f1_local4:setTopBottom(false, true, 0, 0)
	Widget.safeAreaContainer:addElement(f1_local4)
	Widget.leftButtonPrompts = LUI.UIElement.new()
	Widget.leftButtonPrompts:setLeftRight(true, true, 0, 0)
	Widget.leftButtonPrompts:setTopBottom(true, true, 0, 0)
	f1_local4:addElement(Widget.leftButtonPrompts)
	local f1_local5 = CoD.SplitscreenScaler.new(nil, CoD.SplitscreenMultiplier)
	f1_local5:setLeftRight(false, true, 0, 0)
	f1_local5:setTopBottom(false, true, 0, 0)
	Widget.safeAreaContainer:addElement(f1_local5)
	Widget.rightButtonPrompts = LUI.UIElement.new()
	Widget.rightButtonPrompts:setLeftRight(true, true, 0, 0)
	Widget.rightButtonPrompts:setTopBottom(true, true, 0, 0)
	f1_local5:addElement(Widget.rightButtonPrompts)
	Widget.addIRToggle = CoD.AirVehicleHUD.AddIRToggle
	Widget.addCompass = CoD.AirVehicleHUD.AddCompass
	Widget.addCrosshairDistance = CoD.AirVehicleHUD.AddCrosshairDistance
	Widget.addPitchMeters = CoD.AirVehicleHUD.AddPitchMeters
	Widget.addFakeHighAuto = CoD.AirVehicleHUD.AddFakeHighAuto
	Widget.addFake50mmAuto = CoD.AirVehicleHUD.AddFake50mmAuto
	Widget.addRecBox = CoD.AirVehicleHUD.AddRecBox
	Widget.addSignalBox = CoD.AirVehicleHUD.AddSignalBox
	Widget:registerEventHandler("killstreak_damage", CoD.AirVehicleHUD.KillstreakDamage)
	Widget:registerEventHandler("killstreak_damage_animate", CoD.AirVehicleHUD.KillstreakDamageAnimate)
	Widget:registerEventHandler("hud_update_killstreak_hud", CoD.AirVehicleHUD.UpdateKillstreakHUD)
	Widget:registerEventHandler("hud_update_refresh", CoD.AirVehicleHUD.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.AirVehicleHUD.UpdateVisibility)
	Widget:setAlpha(0)
	CoD.AirVehicleHUD.UpdateVisibility(Widget, {
		controller = f1_arg1
	})
	Engine.SetSceneFilterConstant(f1_arg1, 4, 0, 0)
	Engine.SetSceneFilterConstant(f1_arg1, 4, 0, 0)
	Engine.SetSceneFilterConstant(f1_arg1, 4, 1, 0)
	return Widget
end

CoD.AirVehicleHUD.UpdateVisibility = function (f2_arg0, f2_arg1)
	if UIExpression.IsVisibilityBitSet(f2_arg1.controller, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 then
		if f2_arg0.visible ~= true then
			f2_arg0:setAlpha(1)
			f2_arg0.visible = true
			Engine.EnableSceneFilter(f2_arg1.controller, 4, RegisterMaterial(f2_arg0.filterName or "digital_noise_filter"))
		end
	elseif f2_arg0.visible == true then
		f2_arg0:setAlpha(0)
		f2_arg0.visible = nil
		Engine.DisableSceneFilter(f2_arg1.controller, 4)
	end
end

CoD.AirVehicleHUD.KillstreakDamage = function (f3_arg0, f3_arg1)
	if f3_arg1.damage < 0 then
		return 
	end
	f3_arg1.damage = math.max(f3_arg1.damage, 25)
	if not f3_arg0.killstreakDamageTimer then
		f3_arg0.killstreakDamageTimer = LUI.UITimer.new(1, {
			name = "killstreak_damage_animate",
			controller = f3_arg1.controller
		}, false, f3_arg0)
	end
	f3_arg0:addElement(f3_arg0.killstreakDamageTimer)
	local f3_local0 = math.min(2, f3_arg1.damage / 200)
	local f3_local1 = math.min(1000, 1000 * f3_arg1.damage / 100)
	if f3_arg1.damage >= 600 then
		f3_local1 = 5000
		f3_arg0:setAlpha(0)
	end
	if not f3_arg0.killstreakDamageValue then
		f3_arg0.killstreakDamageValue = f3_local0
		f3_arg0.killstreakDamageDuration = f3_local1
		f3_arg0.killstreakDamageTime = 0
	else
		f3_arg0.killstreakDamageValue = math.max(f3_arg0.killstreakDamageValue, f3_local0)
		if f3_arg0.killstreakDamageDuration - f3_arg0.killstreakDamageTime < f3_local1 then
			f3_arg0.killstreakDamageDuration = f3_local1
			f3_arg0.killstreakDamageTime = 0
		end
	end
end

CoD.AirVehicleHUD.KillstreakDamageAnimate = function (f4_arg0, f4_arg1)
	f4_arg0.killstreakDamageTime = f4_arg0.killstreakDamageTime + f4_arg1.timeElapsed
	local f4_local0 = 1 - f4_arg0.killstreakDamageTime / f4_arg0.killstreakDamageDuration
	if f4_local0 < 0 then
		f4_arg0.killstreakDamageValue = nil
		f4_arg0.killstreakDamageTime = nil
		f4_arg0.killstreakDamageDuration = nil
		f4_local0 = 0
		f4_arg1.timer:close()
		Engine.SetSceneFilterConstant(f4_arg1.controller, 4, 0, 0)
		return 
	else
		Engine.SetSceneFilterConstant(f4_arg1.controller, 4, 0, f4_arg0.killstreakDamageValue * f4_local0)
	end
end

CoD.AirVehicleHUD.UpdateKillstreakHUD = function (f5_arg0, f5_arg1)
	if f5_arg1[f5_arg0.vehicle] ~= true then
		f5_arg0:close()
		Engine.DisableSceneFilter(f5_arg1.controller, 4)
		return 
	elseif f5_arg0.opticalContainerText ~= nil then
		if f5_arg1.infrared == true then
			f5_arg0.opticalBorder:animateToState("disabled")
			f5_arg0.opticalContainerText:animateToState("disabled")
			f5_arg0.IRBorder:animateToState("enabled")
			f5_arg0.IRContainerText:animateToState("enabled")
		else
			f5_arg0.opticalBorder:animateToState("enabled")
			f5_arg0.opticalContainerText:animateToState("enabled")
			f5_arg0.IRBorder:animateToState("disabled")
			f5_arg0.IRContainerText:animateToState("default")
		end
	end
end

CoD.AirVehicleHUD.RecordingTimerTick = function (f6_arg0, f6_arg1)
	f6_arg0.milliseconds = f6_arg0.milliseconds + f6_arg1.timeElapsed
	if f6_arg0.milliseconds >= 1000 then
		f6_arg0.seconds = f6_arg0.seconds + 1
		f6_arg0.milliseconds = f6_arg0.milliseconds - 1000
	end
	local f6_local0 = f6_arg0.minutes
	local f6_local1 = f6_arg0.seconds
	local f6_local2 = math.floor(f6_arg0.milliseconds / 10)
	local f6_local3 = nil
	if f6_local1 < 10 then
		f6_local3 = "0" .. f6_local1
	else
		f6_local3 = f6_local1
	end
	local f6_local4 = nil
	if f6_local2 < 10 then
		f6_local4 = "0" .. f6_local2
	else
		f6_local4 = f6_local2
	end
	f6_arg0:setText("00:" .. f6_local3 .. "." .. f6_local4)
end

CoD.AirVehicleHUD.Pulse = function (f7_arg0, f7_arg1)
	if not f7_arg1.interrupted then
		f7_arg0:animateToState("default", 500)
	end
end

CoD.AirVehicleHUD.Pulse2 = function (f8_arg0, f8_arg1)
	if not f8_arg1.interrupted then
		f8_arg0:animateToState("pulse", 500)
	end
end

CoD.AirVehicleHUD.AddIRToggle = function (f9_arg0)
	if CoD.IS_KILLCAM_OR_SPECTATE(f9_arg0.controller) == 0 and UIExpression.IsDemoPlaying(f9_arg0.controller) == 0 then
		local f9_local0 = f9_arg0.centerBox
		local f9_local1 = 2
		local f9_local2 = (CoD.AirVehicleHUD.WeaponTypeWidth + CoD.AirVehicleHUD.WeaponTypeSpacing) * 2 + 12
		local f9_local3 = 39
		local f9_local4 = -f9_local3 / 2 - f9_local3 / 2
		local f9_local5 = LUI.UIText.new({
			left = 83,
			top = f9_local4 + f9_local3 / 2 - CoD.textSize.Default / 2,
			right = 83,
			bottom = f9_local4 + f9_local3 / 2 + CoD.textSize.Default / 2,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = true
		})
		f9_local0:addElement(f9_local5)
		f9_local5:setText(Engine.Localize(" ^3[{+weapnext_inventory}]^7 "))
		local Widget = LUI.UIElement.new({
			left = CoD.AirVehicleHUD.WeaponTypeSpacing - 3,
			top = -f9_local3 + 3,
			right = CoD.AirVehicleHUD.WeaponTypeSpacing + CoD.AirVehicleHUD.WeaponTypeWidth + 6,
			bottom = -3,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = true
		})
		f9_local0:addElement(Widget)
		
		local IRBorder = CoD.Border.new(2, f9_arg0.colorR, f9_arg0.colorG, f9_arg0.colorB, 0)
		IRBorder:registerAnimationState("enabled", {
			alpha = CoD.AirVehicleHUD.Alpha
		})
		IRBorder:registerAnimationState("disabled", {
			alpha = 0
		})
		Widget:addElement(IRBorder)
		f9_arg0.IRBorder = IRBorder
		
		local f9_local8 = LUI.UIText.new({
			left = 0,
			top = -CoD.AirVehicleHUD.WeaponTypeHeight / 2,
			right = 0,
			bottom = CoD.AirVehicleHUD.WeaponTypeHeight / 2,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = false,
			red = f9_arg0.colorR,
			green = f9_arg0.colorG,
			blue = f9_arg0.colorB,
			alpha = 0.25,
			font = CoD.fonts.Condensed
		})
		Widget:addElement(f9_local8)
		f9_local8:registerAnimationState("enabled", {
			alpha = 1
		})
		f9_local8:setText("FLIR")
		f9_arg0.IRContainerText = f9_local8
		local Widget = LUI.UIElement.new({
			left = -CoD.AirVehicleHUD.WeaponTypeWidth - CoD.AirVehicleHUD.WeaponTypeSpacing - 3,
			top = -f9_local3 + 3,
			right = -CoD.AirVehicleHUD.WeaponTypeSpacing + 3,
			bottom = -3,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = true
		})
		f9_local0:addElement(Widget)
		
		local opticalBorder = CoD.Border.new(2, f9_arg0.colorR, f9_arg0.colorG, f9_arg0.colorB, CoD.AirVehicleHUD.Alpha)
		opticalBorder:registerAnimationState("enabled", {
			alpha = CoD.AirVehicleHUD.Alpha
		})
		opticalBorder:registerAnimationState("disabled", {
			alpha = 0
		})
		Widget:addElement(opticalBorder)
		f9_arg0.opticalBorder = opticalBorder
		
		local f9_local11 = LUI.UIText.new({
			left = 0,
			top = -CoD.AirVehicleHUD.WeaponTypeHeight / 2,
			right = 0,
			bottom = CoD.AirVehicleHUD.WeaponTypeHeight / 2,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = false,
			red = f9_arg0.colorR,
			green = f9_arg0.colorG,
			blue = f9_arg0.colorB,
			alpha = 1,
			font = CoD.fonts.Condensed
		})
		Widget:addElement(f9_local11)
		f9_local11:registerAnimationState("enabled", {
			alpha = 1
		})
		f9_local11:registerAnimationState("disabled", {
			alpha = 0.25
		})
		f9_local11:setText("OPT")
		f9_arg0.opticalContainerText = f9_local11
	end
end

CoD.AirVehicleHUD.AddCompass = function (f10_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -234, 234)
	Widget:setTopBottom(true, false, 50, 114)
	Widget:setImage(RegisterMaterial("hud_horizontal_compass_white"))
	Widget:setRGB(f10_arg0.colorR, f10_arg0.colorG, f10_arg0.colorB)
	Widget:setShaderVector(0, 1, -0.5, 0, 0)
	Widget:setupHorizontalCompass()
	f10_arg0:addElement(Widget)
end

CoD.AirVehicleHUD.AddCrosshairDistance = function (f11_arg0, f11_arg1)
	local f11_local0 = f11_arg0.centerBox
	local Widget = LUI.UIElement.new({
		left = 0,
		top = -CoD.textSize.Condensed - 4 - 120,
		right = 40,
		bottom = -120,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	})
	f11_local0:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, f11_arg0.colorR, f11_arg0.colorG, f11_arg0.colorB, CoD.AirVehicleHUD.Alpha))
	local f11_local2 = LUI.UIText.new({
		left = 0,
		top = -CoD.textSize.Condensed,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		red = f11_arg0.colorR,
		green = f11_arg0.colorG,
		blue = f11_arg0.colorB,
		font = CoD.fonts.Condensed,
		alpha = CoD.AirVehicleHUD.Alpha
	})
	f11_local2:setText(f11_arg1)
	Widget:addElement(f11_local2)
	local Widget = LUI.UIElement.new({
		left = 0,
		top = -CoD.textSize.Condensed / 2,
		right = 0,
		bottom = CoD.textSize.Condensed / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		red = f11_arg0.colorR,
		green = f11_arg0.colorG,
		blue = f11_arg0.colorB,
		font = CoD.fonts.Condensed
	})
	Widget:setupCrosshairDistance()
	Widget:addElement(Widget)
end

CoD.AirVehicleHUD.AddPitchMeters = function (f12_arg0)
	local f12_local0 = f12_arg0.centerBox
	local f12_local1 = 280.8
	local Widget = LUI.UIElement.new({
		left = -f12_local1 / 2,
		top = -32,
		right = f12_local1 / 2,
		bottom = 32,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		zRot = 90
	})
	f12_local0:addElement(Widget)
	local Widget = LUI.UIElement.new({
		left = 0,
		top = -1,
		right = 0,
		bottom = -1,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = f12_arg0.colorR,
		green = f12_arg0.colorG,
		blue = f12_arg0.colorB,
		material = RegisterMaterial("hud_pitch_meter"),
		shaderVector0 = {
			f12_local1 / 468,
			-0.5,
			0,
			0
		}
	})
	Widget:setupPitchMeter()
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 35,
		right = 0,
		bottom = 5,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, f12_arg0.colorR, f12_arg0.colorG, f12_arg0.colorB, CoD.AirVehicleHUD.Alpha))
	local Widget = LUI.UIElement.new({
		left = -f12_local1 / 2,
		top = -32,
		right = f12_local1 / 2,
		bottom = 32,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		zRot = -90
	})
	f12_local0:addElement(Widget)
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 31,
		right = 0,
		bottom = -31,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		red = f12_arg0.colorR,
		green = f12_arg0.colorG,
		blue = f12_arg0.colorB,
		material = RegisterMaterial("hud_pitch_meter"),
		shaderVector0 = {
			f12_local1 / 468,
			-0.5,
			0,
			0
		}
	})
	Widget:setupPitchMeter()
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new({
		left = 0,
		top = -5,
		right = 0,
		bottom = -36,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, f12_arg0.colorR, f12_arg0.colorG, f12_arg0.colorB, CoD.AirVehicleHUD.Alpha))
end

CoD.AirVehicleHUD.AddFakeHighAuto = function (f13_arg0)
	local f13_local0 = f13_arg0.centerBox
	local Widget = LUI.UIElement.new({
		left = 0,
		top = CoD.AirVehicleHUD.TopBarHeight,
		right = 50,
		bottom = CoD.AirVehicleHUD.TopBarHeight + CoD.textSize.Condensed + 4,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	f13_local0:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, f13_arg0.colorR, f13_arg0.colorG, f13_arg0.colorB, CoD.AirVehicleHUD.Alpha))
	local f13_local2 = LUI.UIText.new({
		left = 0,
		top = -CoD.textSize.Condensed / 2,
		right = 0,
		bottom = CoD.textSize.Condensed / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		red = f13_arg0.colorR,
		green = f13_arg0.colorG,
		blue = f13_arg0.colorB,
		alpha = 1,
		font = CoD.fonts.Condensed
	})
	f13_local2:setText("HIGH")
	f13_local2:registerAnimationState("pulse", {
		alpha = 0.4
	})
	f13_local2:registerEventHandler("transition_complete_pulse", CoD.AirVehicleHUD.Pulse)
	f13_local2:registerEventHandler("transition_complete_default", CoD.AirVehicleHUD.Pulse2)
	f13_local2:animateToState("pulse")
	Widget:addElement(f13_local2)
	local f13_local3 = LUI.UIText.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = CoD.textSize.Condensed,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = f13_arg0.colorR,
		green = f13_arg0.colorG,
		blue = f13_arg0.colorB,
		font = CoD.fonts.Condensed,
		alpha = 0.25
	})
	f13_local3:setText("AUTO")
	Widget:addElement(f13_local3)
end

CoD.AirVehicleHUD.AddFake50mmAuto = function (f14_arg0)
	local f14_local0 = f14_arg0.centerBox
	local f14_local1 = 20
	local f14_local2 = 55
	local Widget = LUI.UIElement.new({
		left = -f14_local2 - CoD.AirVehicleHUD.WeaponTypeSpacing - 3,
		top = f14_local1 + 3,
		right = -CoD.AirVehicleHUD.WeaponTypeSpacing + 3,
		bottom = f14_local1 + CoD.AirVehicleHUD.BottomBarHeight - 3,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	f14_local0:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, f14_arg0.colorR, f14_arg0.colorG, f14_arg0.colorB, CoD.AirVehicleHUD.Alpha))
	local f14_local4 = LUI.UIText.new({
		left = 0,
		top = -CoD.AirVehicleHUD.WeaponTypeHeight / 2,
		right = 0,
		bottom = CoD.AirVehicleHUD.WeaponTypeHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		red = f14_arg0.colorR,
		green = f14_arg0.colorG,
		blue = f14_arg0.colorB,
		alpha = 1
	})
	Widget:addElement(f14_local4)
	f14_local4:setText("50MM")
	f14_local4:registerAnimationState("pulse", {
		alpha = 0.4
	})
	f14_local4:registerEventHandler("transition_complete_pulse", CoD.AirVehicleHUD.Pulse)
	f14_local4:registerEventHandler("transition_complete_default", CoD.AirVehicleHUD.Pulse2)
	f14_local4:animateToState("pulse")
	local Widget = LUI.UIElement.new({
		left = CoD.AirVehicleHUD.WeaponTypeSpacing - 3,
		top = f14_local1 + 3,
		right = CoD.AirVehicleHUD.WeaponTypeSpacing + f14_local2 + 3,
		bottom = f14_local1 + CoD.AirVehicleHUD.BottomBarHeight - 3,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	f14_local0:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, f14_arg0.colorR, f14_arg0.colorG, f14_arg0.colorB, CoD.AirVehicleHUD.Alpha))
	local f14_local6 = LUI.UIText.new({
		left = 0,
		top = -CoD.AirVehicleHUD.WeaponTypeHeight / 2,
		right = 0,
		bottom = CoD.AirVehicleHUD.WeaponTypeHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		red = f14_arg0.colorR,
		green = f14_arg0.colorG,
		blue = f14_arg0.colorB,
		alpha = 1
	})
	Widget:addElement(f14_local6)
	f14_local6:setText("AUTO")
end

CoD.AirVehicleHUD.AddRecBox = function (f15_arg0)
	local Widget = LUI.UIElement.new({
		left = -110,
		top = -CoD.textSize.Condensed - 4 - CoD.AirVehicleHUD.BottomBarHeight,
		right = -10,
		bottom = -CoD.AirVehicleHUD.BottomBarHeight,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	})
	f15_arg0.centerBox:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, f15_arg0.colorR, f15_arg0.colorG, f15_arg0.colorB, CoD.AirVehicleHUD.Alpha * 0.5))
	local f15_local1 = LUI.UIText.new({
		left = -40,
		top = -CoD.textSize.Condensed / 2,
		right = 0,
		bottom = CoD.textSize.Condensed / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = f15_arg0.colorR,
		green = f15_arg0.colorG,
		blue = f15_arg0.colorB,
		font = CoD.fonts.Condensed,
		alpha = CoD.AirVehicleHUD.Alpha * 0.5
	})
	f15_local1:setText("REC")
	Widget:addElement(f15_local1)
	local f15_local2 = LUI.UIText.new({
		left = 13,
		top = -CoD.textSize.Condensed / 2,
		right = 14,
		bottom = CoD.textSize.Condensed / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = f15_arg0.colorR,
		green = f15_arg0.colorG,
		blue = f15_arg0.colorB,
		font = CoD.fonts.Condensed,
		alpha = CoD.AirVehicleHUD.Alpha * 0.5
	})
	f15_local2:setUseGameTime(true)
	f15_local2:setText("00:00.00")
	f15_local2.milliseconds = 0
	f15_local2.seconds = 0
	f15_local2:registerEventHandler("countup_tick", CoD.AirVehicleHUD.RecordingTimerTick)
	Widget:addElement(LUI.UITimer.new(10, "countup_tick", false, f15_local2))
	Widget:addElement(f15_local2)
end

CoD.AirVehicleHUD.AddSignalBox = function (f16_arg0)
	local Widget = LUI.UIElement.new({
		left = -110,
		top = -CoD.textSize.Condensed - 4 - CoD.AirVehicleHUD.BottomBarHeight - 42,
		right = -10,
		bottom = -CoD.AirVehicleHUD.BottomBarHeight - 42,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	})
	f16_arg0.centerBox:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, f16_arg0.colorR, f16_arg0.colorG, f16_arg0.colorB, CoD.AirVehicleHUD.Alpha * 0.5))
	local f16_local1 = LUI.UIText.new({
		left = -68,
		top = -CoD.textSize.Condensed / 2,
		right = 0,
		bottom = CoD.textSize.Condensed / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = f16_arg0.colorR,
		green = f16_arg0.colorG,
		blue = f16_arg0.colorB,
		font = CoD.fonts.Condensed,
		alpha = CoD.AirVehicleHUD.Alpha * 0.5
	})
	f16_local1:setText("SIGNAL")
	Widget:addElement(f16_local1)
	local f16_local2 = LUI.UIText.new({
		left = 0,
		top = -CoD.textSize.Condensed / 2,
		right = 0,
		bottom = CoD.textSize.Condensed / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = f16_arg0.colorR,
		green = f16_arg0.colorG,
		blue = f16_arg0.colorB,
		font = CoD.fonts.Condensed,
		alpha = CoD.AirVehicleHUD.Alpha * 0.5
	})
	f16_local2:setText("STRONG")
	Widget:addElement(f16_local2)
end

