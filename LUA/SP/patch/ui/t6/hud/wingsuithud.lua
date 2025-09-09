CoD.WingsuitHud = {}
CoD.WingsuitHud.DefaultAlpha = 1
CoD.WingsuitHud.GlowAlpha = 0.8
CoD.WingsuitHud.TextDefaultAlpha = 0.75
CoD.WingsuitHud.ContainerWidth = 400
CoD.WingsuitHud.OuterBracketWidth = 105
CoD.WingsuitHud.OuterBracketHeight = CoD.WingsuitHud.OuterBracketWidth * 2
CoD.WingsuitHud.SpinNeedleDuration = 500
CoD.WingsuitHud.BlueColor = CoD.greenBlue
CoD.WingsuitHud.ArrowWidth = 8
CoD.WingsuitHud.ArrowHeight = CoD.WingsuitHud.ArrowWidth * 4
CoD.WingsuitHud.HorizonLineWidth = 750
CoD.WingsuitHud.HorizonLineHeight = 2
CoD.WingsuitHud.LowerBoxAlpha = 0.75
CoD.WingsuitHud.BracketRowAlpha = 0.75
CoD.WingsuitHud.TargetTextFont = "Default"
LUI.createMenu.WingsuitHud = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewFromState("WingsuitHud", {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	local f1_local1, f1_local2 = Engine.GetUserSafeArea()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f1_local1 / 2, f1_local1 / 2)
	Widget:setTopBottom(false, false, -f1_local2 / 2, f1_local2 / 2)
	f1_local0:addElement(Widget)
	CoD.WingsuitHud.ArrowMaterial = RegisterMaterial("hud_monsoon_arrow")
	CoD.WingsuitHud.HarperTargetMaterial = RegisterMaterial("hud_monsoon_harper_head")
	CoD.WingsuitHud.SalazarTargetMaterial = RegisterMaterial("hud_monsoon_salazar_head")
	local f1_local4 = 720
	local f1_local5 = f1_local4 * Engine.GetAspectRatio()
	local f1_local6 = RegisterMaterial("hud_haiti_fly_glow")
	local f1_local7 = LUI.UIImage.new()
	f1_local7:setLeftRight(true, false, 0, f1_local5 / 2)
	f1_local7:setTopBottom(true, false, 0, f1_local4 / 2)
	f1_local7:setImage(f1_local6)
	f1_local7:setAlpha(CoD.WingsuitHud.GlowAlpha)
	f1_local0:addElement(f1_local7)
	f1_local7 = LUI.UIImage.new()
	f1_local7:setLeftRight(false, true, 0, -f1_local5 / 2)
	f1_local7:setTopBottom(true, false, 0, f1_local4 / 2)
	f1_local7:setImage(f1_local6)
	f1_local7:setAlpha(CoD.WingsuitHud.GlowAlpha)
	f1_local0:addElement(f1_local7)
	f1_local7 = LUI.UIImage.new()
	f1_local7:setLeftRight(true, false, 0, f1_local5 / 2)
	f1_local7:setTopBottom(false, true, 0, -f1_local4 / 2)
	f1_local7:setImage(f1_local6)
	f1_local7:setAlpha(CoD.WingsuitHud.GlowAlpha)
	f1_local0:addElement(f1_local7)
	f1_local7 = LUI.UIImage.new()
	f1_local7:setLeftRight(false, true, 0, -f1_local5 / 2)
	f1_local7:setTopBottom(false, true, 0, -f1_local4 / 2)
	f1_local7:setImage(f1_local6)
	f1_local7:setAlpha(CoD.WingsuitHud.GlowAlpha)
	f1_local0:addElement(f1_local7)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.WingsuitHud.ContainerWidth)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -CoD.WingsuitHud.ContainerWidth, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.WingsuitHud.ContainerWidth / 2, CoD.WingsuitHud.ContainerWidth / 2)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	CoD.WingsuitHud.AddLeftSideStuff(Widget, Widget)
	CoD.WingsuitHud.AddRightSideStuff(Widget)
	CoD.WingsuitHud.AddCenterStuff(Widget, Widget)
	Widget:registerEventHandler("hud_update_vehicle_entity", CoD.WingsuitHud.UpdateVehicleEntity)
	Widget:registerEventHandler("hud_update_friendly", CoD.WingsuitHud.AddFriendly)
	Widget:registerEventHandler("hud_update_distance_obj", CoD.WingsuitHud.UpdateDistanceObj)
	Widget:registerEventHandler("hud_update_refresh", CoD.WingsuitHud.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.WingsuitHud.UpdateVisibility)
	return f1_local0
end

CoD.WingsuitHud.AddLeftSideStuff = function (f2_arg0, f2_arg1)
	local f2_local0 = CoD.WingsuitHud.OuterBracketWidth
	local f2_local1 = CoD.WingsuitHud.OuterBracketHeight * 0.4
	local f2_local2 = 80
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f2_local0, 0)
	Widget:setTopBottom(false, true, -f2_local2 - f2_local1, -f2_local1)
	f2_arg1:addElement(Widget)
end

CoD.WingsuitHud.AddRCSemiCircles = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4)
	local f3_local0 = RegisterMaterial("hud_haiti_fly_rc_semi_circle")
	local f3_local1 = RegisterMaterial("hud_haiti_fly_rc_semi_circle_fill")
	local f3_local2 = 8
	local f3_local3 = LUI.UIImage.new()
	f3_local3:setLeftRight(false, true, f3_arg1, f3_arg2)
	f3_local3:setTopBottom(false, true, -f3_arg3 - f3_local2, -f3_local2)
	f3_local3:setImage(f3_local0)
	f3_arg0:addElement(f3_local3)
	local f3_local4 = LUI.UIImage.new()
	f3_local4:setLeftRight(false, true, f3_arg1, f3_arg2)
	f3_local4:setTopBottom(false, true, -f3_arg3 - f3_local2, -f3_local2)
	f3_local4:setImage(f3_local1)
	f3_arg0:addElement(f3_local4)
	local f3_local5 = CoD.textSize.ExtraSmall
	local f3_local6 = CoD.fonts.ExtraSmall
	local f3_local7 = f3_arg3 + f3_local2 - 3
	local f3_local8 = 3
	local f3_local9 = 10
	local f3_local10 = LUI.UIText.new()
	f3_local10:setLeftRight(false, true, f3_arg1 + f3_local8, 10 + f3_arg1 + f3_local8)
	f3_local10:setTopBottom(false, true, -f3_local5 - f3_local7, -f3_local7)
	f3_local10:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f3_local10:setAlpha(CoD.WingsuitHud.TextDefaultAlpha)
	f3_local10:setFont(f3_local6)
	f3_local10:setAlignment(LUI.Alignment.Left)
	f3_arg0:addElement(f3_local10)
	f3_local10:setText("0")
	local f3_local11 = LUI.UIText.new()
	f3_local11:setLeftRight(false, true, f3_arg2 - f3_local9, 10 + f3_arg2 - f3_local9)
	f3_local11:setTopBottom(false, true, -f3_local5 - f3_local7, -f3_local7)
	f3_local11:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f3_local11:setAlpha(CoD.WingsuitHud.TextDefaultAlpha)
	f3_local11:setFont(f3_local6)
	f3_arg0:addElement(f3_local11)
	f3_local11:setText("9")
	local f3_local12 = (f3_arg1 + f3_arg2) / 2 - 2
	local f3_local13 = 25 + f3_local2
	local f3_local14 = LUI.UIText.new()
	f3_local14:setLeftRight(false, true, f3_local12, 10 + f3_local12)
	f3_local14:setTopBottom(false, true, -f3_local5 - f3_local13, -f3_local13)
	f3_local14:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f3_local14:setAlpha(CoD.WingsuitHud.TextDefaultAlpha)
	f3_local14:setFont(f3_local6)
	f3_local14:setAlignment(LUI.Alignment.Left)
	f3_arg0:addElement(f3_local14)
	f3_local14:setText(f3_arg4)
end

CoD.WingsuitHud.LSpinningNeedle = function (f4_arg0, f4_arg1)
	f4_arg0:beginAnimation("rotate_needle", f4_arg1.timer.interval)
	f4_arg0:setZRot(math.random(-270, 0))
	f4_arg1.timer.interval = math.random(500, 750)
end

CoD.WingsuitHud.AddRightSideStuff = function (f5_arg0)
	local f5_local0 = RegisterMaterial("hud_haiti_fly_l1_circle")
	local f5_local1 = RegisterMaterial("hud_haiti_fly_l_circle_line")
	local f5_local2 = CoD.WingsuitHud.OuterBracketWidth
	local f5_local3 = CoD.WingsuitHud.OuterBracketHeight
	local f5_local4 = 60
	local f5_local5 = 38
	local f5_local6 = f5_local2 * 0.6
	local f5_local7 = CoD.fonts.ExtraSmall
	local f5_local8 = CoD.textSize.ExtraSmall
	local f5_local9 = 10
	local f5_local10 = f5_local4 * 0.25
	local f5_local11 = f5_local3 * 0.4
	local f5_local12 = f5_local4 * 2 + 20
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, -f5_local2)
	Widget:setTopBottom(false, true, -f5_local12 - f5_local11, -f5_local11)
	Widget:setAlpha(CoD.WingsuitHud.LowerBoxAlpha)
	f5_arg0:addElement(Widget)
	local f5_local14 = 10
	local f5_local15 = -8
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f5_local4 + f5_local15, f5_local15)
	Widget:setTopBottom(true, false, f5_local14, f5_local4 + f5_local14)
	Widget:addElement(Widget)
	local f5_local17 = LUI.UIImage.new()
	f5_local17:setLeftRight(true, true, 0, 0)
	f5_local17:setTopBottom(true, true, 0, 0)
	f5_local17:setImage(f5_local0)
	Widget:addElement(f5_local17)
	local f5_local18 = LUI.UIText.new()
	f5_local18:setLeftRight(true, true, 0, 0)
	f5_local18:setTopBottom(true, false, -f5_local8 + f5_local9, f5_local9)
	f5_local18:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f5_local18:setAlpha(CoD.WingsuitHud.TextDefaultAlpha)
	f5_local18:setFont(f5_local7)
	Widget:addElement(f5_local18)
	f5_local18:setText("L2")
	local f5_local19 = LUI.UIImage.new()
	f5_local19:setLeftRight(true, true, 0, 0)
	f5_local19:setTopBottom(true, true, 0, 0)
	f5_local19:setImage(f5_local1)
	f5_local19:registerEventHandler("spinning_needle", CoD.WingsuitHud.LSpinningNeedle)
	Widget:addElement(f5_local19)
	f5_local19:setZRot(-16)
	f5_local19:addElement(LUI.UITimer.new(CoD.WingsuitHud.SpinNeedleDuration, "spinning_needle", false, f5_local19))
	local f5_local20 = f5_local14
	local f5_local21 = f5_local6 - f5_local15 + 20
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f5_local4 - f5_local21, -f5_local21)
	Widget:setTopBottom(true, false, f5_local20, f5_local4 + f5_local20)
	Widget:addElement(Widget)
	local f5_local23 = LUI.UIImage.new()
	f5_local23:setLeftRight(true, true, 0, 0)
	f5_local23:setTopBottom(true, true, 0, 0)
	f5_local23:setImage(f5_local0)
	Widget:addElement(f5_local23)
	local f5_local24 = LUI.UIText.new()
	f5_local24:setLeftRight(true, true, 0, 0)
	f5_local24:setTopBottom(true, false, -f5_local8 + f5_local9, f5_local9)
	f5_local24:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f5_local24:setAlpha(CoD.WingsuitHud.TextDefaultAlpha)
	f5_local24:setFont(f5_local7)
	Widget:addElement(f5_local24)
	f5_local24:setText("L1")
	local f5_local25 = LUI.UIImage.new()
	f5_local25:setLeftRight(true, true, 0, 0)
	f5_local25:setTopBottom(true, true, 0, 0)
	f5_local25:setImage(f5_local1)
	f5_local25:registerEventHandler("spinning_needle", CoD.WingsuitHud.LSpinningNeedle)
	Widget:addElement(f5_local25)
	f5_local25:setZRot(-119)
	f5_local25:addElement(LUI.UITimer.new(CoD.WingsuitHud.SpinNeedleDuration, "spinning_needle", false, f5_local25))
	local f5_local26 = 75
	local f5_local27 = f5_local26 / 2
	CoD.WingsuitHud.AddRCSemiCircles(Widget, -f5_local26, 0, f5_local27, "C")
	local f5_local28 = f5_local26 + 10
	CoD.WingsuitHud.AddRCSemiCircles(Widget, -f5_local26 - f5_local28, -f5_local28, f5_local27, "R")
end

CoD.WingsuitHud.AddCenterStuff = function (f6_arg0, f6_arg1)
	local f6_local0 = CoD.textSize.Condensed
	local f6_local1 = CoD.fonts.Condensed
	local f6_local2 = 50
	local f6_local3 = LUI.UIText.new()
	f6_local3:setLeftRight(false, false, -200, 200)
	f6_local3:setTopBottom(true, false, f6_local2, f6_local0 + f6_local2)
	f6_local3:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f6_local3:setAlpha(CoD.WingsuitHud.TextDefaultAlpha)
	f6_local3:setFont(f6_local1)
	f6_local3:setAlignment(LUI.Alignment.Center)
	f6_arg1:addElement(f6_local3)
	f6_local3:setText("ALT ---- FT")
	f6_arg0.altimeterText = f6_local3
	local f6_local4 = RegisterMaterial("hud_haiti_fly_aim_bracket_long")
	local f6_local5 = RegisterMaterial("hud_haiti_fly_aim_bracket_short")
	local f6_local6, f6_local7 = nil
	f6_local6 = 75
	f6_local7 = -175
	CoD.WingsuitHud.CreateBracketRow(f6_arg1, f6_local4, true, 180, 0, f6_local6, f6_local7)
	CoD.WingsuitHud.CreateBracketRow(f6_arg1, f6_local5, nil, 180, 0, f6_local6 + 5, f6_local7 + 60)
	local f6_local8 = 150
	local f6_local9 = LUI.UIImage.new()
	f6_local9:setLeftRight(false, false, -f6_local8 / 2, f6_local8 / 2)
	f6_local9:setTopBottom(false, false, -f6_local8 / 2, f6_local8 / 2)
	f6_local9:setAlpha(0.5)
	f6_local9:setImage(RegisterMaterial("hud_haiti_fly_aim_circle"))
	f6_arg1:addElement(f6_local9)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.WingsuitHud.HorizonLineWidth / 2, CoD.WingsuitHud.HorizonLineWidth / 2)
	Widget:setTopBottom(false, false, -CoD.WingsuitHud.HorizonLineHeight / 2, CoD.WingsuitHud.HorizonLineHeight / 2)
	Widget:setupRollLevel(-1)
	f6_arg1:addElement(Widget)
	local f6_local11 = LUI.UIImage.new()
	f6_local11:setLeftRight(true, true, 0, 0)
	f6_local11:setTopBottom(true, true, 0, 0)
	f6_local11:setAlpha(0.3)
	f6_local11:setImage(RegisterMaterial("hud_haiti_fly_hzn"))
	Widget:addElement(f6_local11)
	f6_local6 = 75
	f6_local7 = 175
	CoD.WingsuitHud.CreateBracketRow(f6_arg1, f6_local4, true, 180, 180, f6_local6, f6_local7)
	CoD.WingsuitHud.CreateBracketRow(f6_arg1, f6_local5, nil, 180, 180, f6_local6 + 5, f6_local7 - 60)
	local f6_local12 = CoD.fonts.Default
	local f6_local13 = CoD.textSize.Default
	local f6_local14 = 165
	local f6_local15 = LUI.UIText.new()
	f6_local15:setLeftRight(false, false, -50, 50)
	f6_local15:setTopBottom(false, false, -f6_local13 / 2 + f6_local14, f6_local13 / 2 + f6_local14)
	f6_local15:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f6_local15:setFont(f6_local12)
	f6_arg1:addElement(f6_local15)
	f6_local15:setText("DTT")
	local f6_local16 = f6_local14 + f6_local13 + 10
	local f6_local17 = LUI.UIText.new()
	f6_local17:setLeftRight(false, false, -50, 50)
	f6_local17:setTopBottom(false, false, -f6_local13 / 2 + f6_local16, f6_local13 / 2 + f6_local16)
	f6_local17:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f6_local17:setFont(f6_local12)
	f6_local17:registerEventHandler("dtt_update_text", CoD.WingsuitHud.UpdateDTTText)
	f6_arg1:addElement(f6_local17)
	f6_local17:setText("---- M")
	f6_arg0.dttValueText = f6_local17
end

CoD.WingsuitHud.CreateBracketRow = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4, f7_arg5, f7_arg6)
	local f7_local0 = 150
	local f7_local1 = f7_local0 / 8
	if not f7_arg2 then
		f7_local0 = f7_local0 / 2
		f7_local1 = f7_local0 / 4
	end
	local f7_local2 = LUI.UIImage.new()
	f7_local2:setLeftRight(false, false, -f7_local0 / 2 - f7_arg5, f7_local0 / 2 - f7_arg5)
	f7_local2:setTopBottom(false, false, -f7_local1 / 2 + f7_arg6, f7_local1 / 2 + f7_arg6)
	f7_local2:setImage(f7_arg1)
	f7_local2:setXRot(f7_arg4)
	f7_local2:setYRot(f7_arg3)
	f7_local2:setAlpha(CoD.WingsuitHud.BracketRowAlpha)
	f7_arg0:addElement(f7_local2)
	local f7_local3 = LUI.UIImage.new()
	f7_local3:setLeftRight(false, false, -f7_local0 / 2 + f7_arg5, f7_local0 / 2 + f7_arg5)
	f7_local3:setTopBottom(false, false, -f7_local1 / 2 + f7_arg6, f7_local1 / 2 + f7_arg6)
	f7_local3:setXRot(f7_arg4)
	f7_local3:setImage(f7_arg1)
	f7_local3:setAlpha(CoD.WingsuitHud.BracketRowAlpha)
	f7_arg0:addElement(f7_local3)
end

CoD.WingsuitHud.UpdateVehicleEntity = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg1.data[1]
	if not f8_local0 then
		return 
	end
	local f8_local1 = f8_arg1.data[2] or 10000
	if f8_arg0.altimeterText then
		f8_arg0.altimeterText:setupAltitudeValue(f8_local0, f8_local1)
	end
end

CoD.WingsuitHud.MarkerWidth = 80
CoD.WingsuitHud.MarkerHeight = 80
CoD.WingsuitHud.CircleSize = 40
CoD.WingsuitHud.AddFriendly = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg1.data[1]
	if not f9_local0 then
		return 
	end
	local f9_local1 = nil
	local f9_local2 = f9_arg1.data[2]
	if f9_local2 == 1 then
		f9_local1 = CoD.WingsuitHud.HarperTargetMaterial
	elseif f9_local2 == 2 then
		f9_local1 = CoD.WingsuitHud.SalazarTargetMaterial
	end
	local f9_local3 = CoD.WingsuitHud.AddFriendlyMarker(f9_local0, f9_local1)
	f9_local3:setPriority(50)
	f9_arg0:addElement(f9_local3)
end

CoD.WingsuitHud.AddFriendlyMarker = function (f10_arg0, f10_arg1)
	local f10_local0 = 15
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.WingsuitHud.MarkerWidth / 2, CoD.WingsuitHud.MarkerWidth / 2)
	Widget:setTopBottom(false, false, -CoD.WingsuitHud.MarkerHeight - f10_local0, -f10_local0)
	local f10_local2 = LUI.UIImage.new()
	f10_local2:setLeftRight(true, true, 15, -15)
	f10_local2:setTopBottom(true, true, 15, -15)
	f10_local2:setImage(f10_arg1)
	Widget:addElement(f10_local2)
	local f10_local3 = CoD.fonts[CoD.WingsuitHud.TargetTextFont]
	local f10_local4 = CoD.textSize[CoD.WingsuitHud.TargetTextFont]
	local f10_local5 = 15
	local f10_local6 = LUI.UIText.new()
	f10_local6:setLeftRight(true, true, 0, 0)
	f10_local6:setTopBottom(true, false, -f10_local5, f10_local4 - f10_local5)
	f10_local6:setFont(f10_local3)
	f10_local6:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	Widget:addElement(f10_local6)
	Widget.edgePointerContainer = LUI.UIElement.new()
	Widget.edgePointerContainer:setLeftRight(true, true, 0, 0)
	Widget.edgePointerContainer:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget.edgePointerContainer)
	local f10_local7 = 20
	local f10_local8 = f10_local7 * 2
	local f10_local9 = -15
	local f10_local10 = LUI.UIImage.new()
	f10_local10:setLeftRight(false, false, -f10_local7 / 2, f10_local7 / 2)
	f10_local10:setTopBottom(false, true, f10_local9, f10_local8 + f10_local9)
	f10_local10:setImage(CoD.WingsuitHud.ArrowMaterial)
	f10_local10:setAlpha(0.3)
	Widget.edgePointerContainer:addElement(f10_local10)
	Widget:registerEventHandler("entity_container_clamped", CoD.WingsuitHud.Clamped)
	Widget:registerEventHandler("entity_container_unclamped", CoD.WingsuitHud.Unclamped)
	Widget:setupEntityContainer(f10_arg0)
	Widget:setEntityContainerClamp(true)
	Widget:setEntityContainerScaleClamp(true)
	f10_local6:setupDistanceIndicator()
	return Widget
end

CoD.WingsuitHud.Clamped = function (f11_arg0, f11_arg1)
	if f11_arg0.edgePointerContainer then
		f11_arg0.edgePointerContainer:setupEdgePointer(90)
	end
end

CoD.WingsuitHud.Unclamped = function (f12_arg0, f12_arg1)
	if f12_arg0.edgePointerContainer then
		f12_arg0.edgePointerContainer:setupUIElement()
		f12_arg0.edgePointerContainer:setZRot(0)
	end
end

CoD.WingsuitHud.UpdateDistanceObj = function (f13_arg0, f13_arg1)
	local f13_local0 = f13_arg1.data[1]
	local f13_local1 = f13_arg1.data[2]
	local f13_local2 = f13_arg1.data[3]
	if f13_arg0.dttValueText then
		f13_arg0.dttValueText:setupDistanceIndicator(f13_local0, f13_local1, f13_local2)
	end
end

CoD.WingsuitHud.UpdateVisibility = function (f14_arg0, f14_arg1)
	if UIExpression.IsVisibilityBitSet(f14_arg1.controller, CoD.BIT_UI_ACTIVE) == 0 then
		if f14_arg0.visible ~= true then
			f14_arg0:setAlpha(CoD.WingsuitHud.DefaultAlpha)
			f14_arg0.visible = true
		end
	elseif f14_arg0.visible == true then
		f14_arg0:setAlpha(0)
		f14_arg0.visible = nil
	end
	f14_arg0:dispatchEventToChildren(f14_arg1)
end

