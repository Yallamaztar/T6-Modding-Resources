CoD.AirVehicleHUD = {}
CoD.AirVehicleHUD.TopBarHeight = 64
CoD.AirVehicleHUD.BottomBarHeight = 39
CoD.AirVehicleHUD.LeftBarWidth = 64
CoD.AirVehicleHUD.BottomTextOffset = 8
CoD.AirVehicleHUD.WeaponTypeWidth = 40
CoD.AirVehicleHUD.WeaponTypeHeight = CoD.textSize.Condensed
CoD.AirVehicleHUD.Alpha = 0.25
CoD.AirVehicleHUD.WeaponTypeSpacing = 25
CoD.AirVehicleHUD.HUDColor = {
	r = 0,
	g = 0.96,
	b = 1
}
CoD.AirVehicleHUD.ArrowMaterial = RegisterMaterial("hud_lui_arrow_global")
CoD.AirVehicleHUD.new = function (f1_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget.vehicle = f1_arg0
	local f1_local1, f1_local2 = Engine.GetUserSafeArea()
	f1_local1 = 4 * f1_local2 / 3
	
	local centerBox = LUI.UIElement.new()
	centerBox:setLeftRight(false, false, -f1_local1 / 2, f1_local1 / 2)
	centerBox:setTopBottom(false, false, -f1_local2 / 2, f1_local2 / 2)
	Widget:addElement(centerBox)
	Widget.centerBox = centerBox
	
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -100, 0)
	Widget:setTopBottom(false, true, -CoD.textSize.Condensed - 4 - CoD.AirVehicleHUD.BottomBarHeight, -CoD.AirVehicleHUD.BottomBarHeight)
	centerBox:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b, CoD.AirVehicleHUD.Alpha))
	local f1_local5 = LUI.UIText.new()
	f1_local5:setLeftRight(true, false, -40, 0)
	f1_local5:setTopBottom(false, false, -CoD.textSize.Condensed / 2, CoD.textSize.Condensed / 2)
	f1_local5:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	f1_local5:setFont(CoD.fonts.Condensed)
	f1_local5:setAlpha(CoD.AirVehicleHUD.Alpha)
	f1_local5:setText("REC")
	Widget:addElement(f1_local5)
	local f1_local6 = LUI.UIText.new()
	f1_local6:setLeftRight(true, false, 13, 14)
	f1_local6:setTopBottom(false, false, -CoD.textSize.Condensed / 2, CoD.textSize.Condensed / 2)
	f1_local6:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	f1_local6:setFont(CoD.fonts.Condensed)
	f1_local6:setAlpha(CoD.AirVehicleHUD.Alpha)
	f1_local6:setText("00:00.00")
	f1_local6.milliseconds = 0
	f1_local6.seconds = 0
	f1_local6:registerEventHandler("countup_tick", CoD.AirVehicleHUD.RecordingTimerTick)
	f1_local6:addElement(LUI.UITimer.new(10, "countup_tick"))
	Widget:addElement(f1_local6)
	Widget.addIRToggle = CoD.AirVehicleHUD.AddIRToggle
	Widget.addCompass = CoD.AirVehicleHUD.AddCompass
	Widget.addCrosshairDistance = CoD.AirVehicleHUD.AddCrosshairDistance
	Widget.addPitchMeters = CoD.AirVehicleHUD.AddPitchMeters
	Widget.addFakeHighAuto = CoD.AirVehicleHUD.AddFakeHighAuto
	Widget.addFake50mmAuto = CoD.AirVehicleHUD.AddFake50mmAuto
	Widget:registerEventHandler("hud_update_killstreak_hud", CoD.AirVehicleHUD.UpdateKillstreakHUD)
	return Widget
end

CoD.AirVehicleHUD.UpdateKillstreakHUD = function (f2_arg0, f2_arg1)
	if f2_arg1[f2_arg0.vehicle] ~= true then
		f2_arg0:close()
		return 
	elseif f2_arg0.opticalContainerText ~= nil then
		if f2_arg1.infrared == true then
			f2_arg0.opticalBorder:animateToState("disabled")
			f2_arg0.opticalContainerText:animateToState("default")
			f2_arg0.IRBorder:animateToState("enabled")
			f2_arg0.IRContainerText:animateToState("enabled")
		else
			f2_arg0.opticalBorder:animateToState("default")
			f2_arg0.opticalContainerText:animateToState("enabled")
			f2_arg0.IRBorder:animateToState("default")
			f2_arg0.IRContainerText:animateToState("default")
		end
	end
end

CoD.AirVehicleHUD.RecordingTimerTick = function (f3_arg0, f3_arg1)
	f3_arg0.milliseconds = f3_arg0.milliseconds + f3_arg1.timeElapsed
	if f3_arg0.milliseconds >= 1000 then
		f3_arg0.seconds = f3_arg0.seconds + 1
		f3_arg0.milliseconds = f3_arg0.milliseconds - 1000
	end
	local f3_local0 = f3_arg0.minutes
	local f3_local1 = f3_arg0.seconds
	local f3_local2 = math.floor(f3_arg0.milliseconds / 10)
	local f3_local3 = nil
	if f3_local1 < 10 then
		f3_local3 = "0" .. f3_local1
	else
		f3_local3 = f3_local1
	end
	local f3_local4 = nil
	if f3_local2 < 10 then
		f3_local4 = "0" .. f3_local2
	else
		f3_local4 = f3_local2
	end
	f3_arg0:setText("00:" .. f3_local3 .. "." .. f3_local4)
end

CoD.AirVehicleHUD.Pulse = function (f4_arg0, f4_arg1)
	f4_arg0:animateToState("default", 500)
end

CoD.AirVehicleHUD.Pulse2 = function (f5_arg0, f5_arg1)
	f5_arg0:animateToState("pulse", 500)
end

CoD.AirVehicleHUD.AddIRToggle = function (f6_arg0)
	local f6_local0 = f6_arg0.centerBox
	local f6_local1 = 2
	local f6_local2 = (CoD.AirVehicleHUD.WeaponTypeWidth + CoD.AirVehicleHUD.WeaponTypeSpacing) * 2 + 12
	local f6_local3 = CoD.AirVehicleHUD.BottomBarHeight
	local f6_local4 = -CoD.AirVehicleHUD.BottomBarHeight / 2 - f6_local3 / 2
	local f6_local5 = LUI.UIText.new()
	f6_local5:setLeftRight(true, true, 0, 0)
	f6_local5:setTopBottom(false, true, f6_local4 + f6_local3 / 2 - CoD.textSize.Default / 2, f6_local4 + f6_local3 / 2 + CoD.textSize.Default / 2)
	f6_local0:addElement(f6_local5)
	f6_local5:setText(Engine.Localize(" ^3[{+activate}]^7 "))
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.AirVehicleHUD.WeaponTypeWidth - CoD.AirVehicleHUD.WeaponTypeSpacing - 3, -CoD.AirVehicleHUD.WeaponTypeSpacing + 3)
	Widget:setTopBottom(false, true, -CoD.AirVehicleHUD.BottomBarHeight + 3, -3)
	f6_local0:addElement(Widget)
	
	local IRBorder = CoD.Border.new(2, CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b, 0)
	IRBorder:registerAnimationState("enabled", {
		alpha = CoD.AirVehicleHUD.Alpha
	})
	Widget:addElement(IRBorder)
	f6_arg0.IRBorder = IRBorder
	
	local f6_local8 = LUI.UIText.new({
		left = 0,
		top = -CoD.AirVehicleHUD.WeaponTypeHeight / 2,
		right = 0,
		bottom = CoD.AirVehicleHUD.WeaponTypeHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		red = CoD.AirVehicleHUD.HUDColor.r,
		green = CoD.AirVehicleHUD.HUDColor.g,
		blue = CoD.AirVehicleHUD.HUDColor.b,
		alpha = 0.25
	})
	Widget:addElement(f6_local8)
	f6_local8:registerAnimationState("enabled", {
		alpha = 1
	})
	f6_local8:setText("FLIR")
	f6_arg0.IRContainerText = f6_local8
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, CoD.AirVehicleHUD.WeaponTypeSpacing - 3, CoD.AirVehicleHUD.WeaponTypeSpacing + CoD.AirVehicleHUD.WeaponTypeWidth + 3)
	Widget:setTopBottom(false, true, -CoD.AirVehicleHUD.BottomBarHeight + 3, -3)
	f6_local0:addElement(Widget)
	
	local opticalBorder = CoD.Border.new(2, CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b, CoD.AirVehicleHUD.Alpha)
	opticalBorder:registerAnimationState("disabled", {
		alpha = 0
	})
	Widget:addElement(opticalBorder)
	f6_arg0.opticalBorder = opticalBorder
	
	local f6_local11 = LUI.UIText.new({
		left = 0,
		top = -CoD.AirVehicleHUD.WeaponTypeHeight / 2,
		right = 0,
		bottom = CoD.AirVehicleHUD.WeaponTypeHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		red = CoD.AirVehicleHUD.HUDColor.r,
		green = CoD.AirVehicleHUD.HUDColor.g,
		blue = CoD.AirVehicleHUD.HUDColor.b,
		alpha = 0.25
	})
	Widget:addElement(f6_local11)
	f6_local11:registerAnimationState("enabled", {
		alpha = 1
	})
	f6_local11:setText("OPT")
	f6_arg0.opticalContainerText = f6_local11
end

CoD.AirVehicleHUD.AddCompass = function (f7_arg0)
	local f7_local0 = f7_arg0.centerBox
	local f7_local1 = -16
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -234, 234)
	Widget:setTopBottom(true, false, f7_local1, f7_local1 + CoD.AirVehicleHUD.TopBarHeight)
	Widget:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	Widget:setImage(RegisterMaterial("hud_horizontal_compass"))
	Widget:setShaderVector(0, 1, -0.5, 0, 0)
	Widget:setupHorizontalCompass()
	f7_local0:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -234, 234)
	Widget:setTopBottom(true, false, 5, CoD.AirVehicleHUD.TopBarHeight + f7_local1 + 1)
	f7_local0:addElement(Widget)
	local f7_local4 = LUI.UIImage.new()
	f7_local4:setLeftRight(false, false, -8, 8)
	f7_local4:setTopBottom(false, true, -12, 4)
	f7_local4:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	f7_local4:setImage(CoD.AirVehicleHUD.ArrowMaterial)
	Widget:addElement(f7_local4)
	Widget:addElement(CoD.Border.new(2, CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b, CoD.AirVehicleHUD.Alpha))
end

CoD.AirVehicleHUD.AddCrosshairDistance = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg0.centerBox
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, 40)
	Widget:setTopBottom(false, true, -CoD.textSize.Condensed - 4 - CoD.AirVehicleHUD.BottomBarHeight, -CoD.AirVehicleHUD.BottomBarHeight)
	f8_local0:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b, CoD.AirVehicleHUD.Alpha))
	local f8_local2 = LUI.UIText.new()
	f8_local2:setLeftRight(true, true, 0, 0)
	f8_local2:setTopBottom(true, false, -CoD.textSize.Condensed, 0)
	f8_local2:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	f8_local2:setFont(CoD.fonts.Condensed)
	f8_local2:setAlpha(CoD.AirVehicleHUD.Alpha)
	f8_local2:setText(f8_arg1)
	Widget:addElement(f8_local2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(false, false, -CoD.textSize.Condensed / 2, CoD.textSize.Condensed / 2)
	Widget:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	Widget:setFont(CoD.fonts.Condensed)
	Widget:setupCrosshairDistance()
	Widget:addElement(Widget)
end

CoD.AirVehicleHUD.AddPitchMeters = function (f9_arg0)
	local f9_local0 = f9_arg0.centerBox
	local f9_local1 = 280.8
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, -f9_local1 / 2, f9_local1 / 2)
	Widget:setTopBottom(false, false, -32, 32)
	Widget:setZRot(90)
	f9_local0:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, -1, -1)
	Widget:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	Widget:setImage(RegisterMaterial("hud_pitch_meter"))
	Widget:setShaderVector(0, f9_local1 / 468, -0.5, 0, 0)
	Widget:setupPitchMeter()
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 35, 5)
	Widget:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b, CoD.AirVehicleHUD.Alpha))
	local f9_local5 = LUI.UIImage.new()
	f9_local5:setLeftRight(false, false, -8, 8)
	f9_local5:setTopBottom(false, true, -7, 9)
	f9_local5:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	f9_local5:setImage(CoD.AirVehicleHUD.ArrowMaterial)
	Widget:addElement(f9_local5)
	local f9_local6 = LUI.UIImage.new()
	f9_local6:setLeftRight(false, false, -8, 8)
	f9_local6:setTopBottom(true, false, 47, 31)
	f9_local6:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	f9_local6:setImage(CoD.AirVehicleHUD.ArrowMaterial)
	Widget:addElement(f9_local6)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f9_local1 / 2, f9_local1 / 2)
	Widget:setTopBottom(false, false, -32, 32)
	Widget:setZRot(-90)
	f9_local0:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(false, false, 31, -31)
	Widget:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	Widget:setImage(RegisterMaterial("hud_pitch_meter"))
	Widget:setShaderVector(0, f9_local1 / 468, -0.5, 0, 0)
	Widget:setupPitchMeter()
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, -5, -36)
	Widget:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b, CoD.AirVehicleHUD.Alpha))
	local f9_local10 = LUI.UIImage.new()
	f9_local10:setLeftRight(false, false, -8, 8)
	f9_local10:setTopBottom(false, true, -48, -32)
	f9_local10:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	f9_local10:setImage(CoD.AirVehicleHUD.ArrowMaterial)
	Widget:addElement(f9_local10)
	local f9_local11 = LUI.UIImage.new()
	f9_local11:setLeftRight(false, false, -8, 8)
	f9_local11:setTopBottom(true, false, 7, -9)
	f9_local11:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	f9_local11:setImage(CoD.AirVehicleHUD.ArrowMaterial)
	Widget:addElement(f9_local11)
end

CoD.AirVehicleHUD.AddFakeHighAuto = function (f10_arg0)
	local f10_local0 = f10_arg0.centerBox
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, 50)
	Widget:setTopBottom(true, false, CoD.AirVehicleHUD.TopBarHeight, CoD.AirVehicleHUD.TopBarHeight + CoD.textSize.Condensed + 4)
	f10_local0:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b, CoD.AirVehicleHUD.Alpha))
	local f10_local2 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.textSize.Condensed / 2,
		bottom = CoD.textSize.Condensed / 2,
		red = CoD.AirVehicleHUD.HUDColor.r,
		green = CoD.AirVehicleHUD.HUDColor.g,
		blue = CoD.AirVehicleHUD.HUDColor.b,
		font = CoD.fonts.Condensed
	})
	f10_local2:setText("HIGH")
	f10_local2:registerAnimationState("pulse", {
		alpha = 0.4
	})
	f10_local2:registerEventHandler("transition_complete_pulse", CoD.AirVehicleHUD.Pulse)
	f10_local2:registerEventHandler("transition_complete_default", CoD.AirVehicleHUD.Pulse2)
	f10_local2:animateToState("pulse")
	Widget:addElement(f10_local2)
	local f10_local3 = LUI.UIText.new()
	f10_local3:setLeftRight(true, true, 0, 0)
	f10_local3:setTopBottom(false, true, 0, CoD.textSize.Condensed)
	f10_local3:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	f10_local3:setFont(CoD.fonts.Condensed)
	f10_local3:setAlpha(0.25)
	f10_local3:setText("AUTO")
	Widget:addElement(f10_local3)
end

CoD.AirVehicleHUD.AddFake50mmAuto = function (f11_arg0)
	local f11_local0 = f11_arg0.centerBox
	local f11_local1 = 20
	local f11_local2 = 55
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f11_local2 - CoD.AirVehicleHUD.WeaponTypeSpacing - 3, -CoD.AirVehicleHUD.WeaponTypeSpacing + 3)
	Widget:setTopBottom(true, false, f11_local1 + 3, f11_local1 + CoD.AirVehicleHUD.BottomBarHeight - 3)
	f11_local0:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b, CoD.AirVehicleHUD.Alpha))
	local f11_local4 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.AirVehicleHUD.WeaponTypeHeight / 2,
		bottom = CoD.AirVehicleHUD.WeaponTypeHeight / 2,
		red = CoD.AirVehicleHUD.HUDColor.r,
		green = CoD.AirVehicleHUD.HUDColor.g,
		blue = CoD.AirVehicleHUD.HUDColor.b
	})
	Widget:addElement(f11_local4)
	f11_local4:setText("50MM")
	f11_local4:registerAnimationState("pulse", {
		alpha = 0.4
	})
	f11_local4:registerEventHandler("transition_complete_pulse", CoD.AirVehicleHUD.Pulse)
	f11_local4:registerEventHandler("transition_complete_default", CoD.AirVehicleHUD.Pulse2)
	f11_local4:animateToState("pulse")
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, CoD.AirVehicleHUD.WeaponTypeSpacing - 3, CoD.AirVehicleHUD.WeaponTypeSpacing + f11_local2 + 3)
	Widget:setTopBottom(true, false, f11_local1 + 3, f11_local1 + CoD.AirVehicleHUD.BottomBarHeight - 3)
	f11_local0:addElement(Widget)
	Widget:addElement(CoD.Border.new(2, CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b, CoD.AirVehicleHUD.Alpha))
	local f11_local6 = LUI.UIText.new()
	f11_local6:setLeftRight(true, true, 0, 0)
	f11_local6:setTopBottom(false, false, -CoD.AirVehicleHUD.WeaponTypeHeight / 2, CoD.AirVehicleHUD.WeaponTypeHeight / 2)
	f11_local6:setRGB(CoD.AirVehicleHUD.HUDColor.r, CoD.AirVehicleHUD.HUDColor.g, CoD.AirVehicleHUD.HUDColor.b)
	Widget:addElement(f11_local6)
	f11_local6:setText("AUTO")
end

