CoD.JetwingHud = {}
CoD.JetwingHud.DefaultAlpha = 1
CoD.JetwingHud.GlowAlpha = 0.8
CoD.JetwingHud.TextDefaultAlpha = 0.75
CoD.JetwingHud.ContainerWidth = 400
CoD.JetwingHud.OuterBracketWidth = 105
CoD.JetwingHud.OuterBracketHeight = CoD.JetwingHud.OuterBracketWidth * 2
CoD.JetwingHud.SpinNeedleDuration = 500
CoD.JetwingHud.BlueColor = CoD.greenBlue
CoD.JetwingHud.InfoBarWidth = 140
CoD.JetwingHud.InfoBarHeight = CoD.JetwingHud.InfoBarWidth / 4
CoD.JetwingHud.ArrowWidth = 8
CoD.JetwingHud.ArrowHeight = CoD.JetwingHud.ArrowWidth * 4
CoD.JetwingHud.HorizonBoxHeight = 365
CoD.JetwingHud.HorizonLineWidth = 750
CoD.JetwingHud.HorizonLineHeight = 2
LUI.createMenu.JetwingHud = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewFromState("JetwingHud", {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	CoD.JetwingHud.SPDBracketMaterial = RegisterMaterial("hud_haiti_fly_spd_bracket")
	CoD.JetwingHud.SPDFillMaterial = RegisterMaterial("hud_haiti_fly_spd_fill")
	CoD.JetwingHud.SPDSlideTriangleMaterial = RegisterMaterial("hud_haiti_fly_spd_slide_triangle")
	CoD.JetwingHud.RCSemiCircleMaterial = RegisterMaterial("hud_haiti_fly_rc_semi_circle")
	CoD.JetwingHud.RCSemiCircleFillMaterial = RegisterMaterial("hud_haiti_fly_rc_semi_circle_fill")
	local f1_local1, f1_local2 = Engine.GetUserSafeArea()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f1_local1 / 2, f1_local1 / 2)
	Widget:setTopBottom(false, false, -f1_local2 / 2, f1_local2 / 2)
	f1_local0:addElement(Widget)
	local f1_local4 = 720
	local f1_local5 = f1_local4 * Engine.GetAspectRatio()
	local f1_local6 = RegisterMaterial("hud_haiti_fly_glow")
	local f1_local7 = LUI.UIImage.new()
	f1_local7:setLeftRight(true, false, 0, f1_local5 / 2)
	f1_local7:setTopBottom(true, false, 0, f1_local4 / 2)
	f1_local7:setImage(f1_local6)
	f1_local7:setAlpha(CoD.JetwingHud.GlowAlpha)
	f1_local0:addElement(f1_local7)
	f1_local7 = LUI.UIImage.new()
	f1_local7:setLeftRight(false, true, 0, -f1_local5 / 2)
	f1_local7:setTopBottom(true, false, 0, f1_local4 / 2)
	f1_local7:setImage(f1_local6)
	f1_local7:setAlpha(CoD.JetwingHud.GlowAlpha)
	f1_local0:addElement(f1_local7)
	f1_local7 = LUI.UIImage.new()
	f1_local7:setLeftRight(true, false, 0, f1_local5 / 2)
	f1_local7:setTopBottom(false, true, 0, -f1_local4 / 2)
	f1_local7:setImage(f1_local6)
	f1_local7:setAlpha(CoD.JetwingHud.GlowAlpha)
	f1_local0:addElement(f1_local7)
	f1_local7 = LUI.UIImage.new()
	f1_local7:setLeftRight(false, true, 0, -f1_local5 / 2)
	f1_local7:setTopBottom(false, true, 0, -f1_local4 / 2)
	f1_local7:setImage(f1_local6)
	f1_local7:setAlpha(CoD.JetwingHud.GlowAlpha)
	f1_local0:addElement(f1_local7)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.JetwingHud.ContainerWidth)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -CoD.JetwingHud.ContainerWidth, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.JetwingHud.ContainerWidth / 2, CoD.JetwingHud.ContainerWidth / 2)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	CoD.JetwingHud.CreateOuterBrackets(Widget, Widget)
	CoD.JetwingHud.AddLeftSideStuff(Widget, Widget)
	CoD.JetwingHud.AddRightSideStuff(Widget)
	CoD.JetwingHud.AddCenterStuff(Widget, Widget)
	Widget:registerEventHandler("hud_update_vehicledata", CoD.JetwingHud.UpdateVehicleData)
	Widget:registerEventHandler("hud_update_refresh", CoD.JetwingHud.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.JetwingHud.UpdateVisibility)
	Widget:registerEventHandler("hud_jetwing_alpha", CoD.JetwingHud.JetwingAlpha)
	return f1_local0
end

CoD.JetwingHud.CreateOuterBrackets = function (f2_arg0, f2_arg1)
	local f2_local0 = RegisterMaterial("hud_haiti_fly_outer_bracket")
	local f2_local1 = CoD.JetwingHud.OuterBracketWidth
	local f2_local2 = CoD.JetwingHud.OuterBracketHeight
	local f2_local3 = f2_local1 * 0.85
	local f2_local4 = f2_local2 * 0.85
	local f2_local5 = 70
	local f2_local6 = 20
	local f2_local7 = 120
	local f2_local8 = LUI.UIImage.new()
	f2_local8:setLeftRight(true, false, f2_local6, f2_local1 + f2_local6)
	f2_local8:setTopBottom(true, false, f2_local5, f2_local2 + f2_local5)
	f2_local8:setImage(f2_local0)
	f2_arg0:addElement(f2_local8)
	local f2_local9 = LUI.UIImage.new()
	f2_local9:setLeftRight(true, false, f2_local6, f2_local1 + f2_local6)
	f2_local9:setTopBottom(false, true, -f2_local2 - f2_local7, -f2_local7)
	f2_local9:setImage(f2_local0)
	f2_local9:setXRot(180)
	f2_arg0:addElement(f2_local9)
	local f2_local10 = LUI.UIImage.new()
	f2_local10:setLeftRight(false, true, -f2_local3 - f2_local6, -f2_local6)
	f2_local10:setTopBottom(true, false, f2_local5, f2_local4 + f2_local5)
	f2_local10:setImage(f2_local0)
	f2_local10:setXRot(180)
	f2_arg1:addElement(f2_local10)
	local f2_local11 = LUI.UIImage.new()
	f2_local11:setLeftRight(false, true, -f2_local3 - f2_local6, -f2_local6)
	f2_local11:setTopBottom(false, true, -f2_local4 - f2_local7, -f2_local7)
	f2_local11:setImage(f2_local0)
	f2_arg1:addElement(f2_local11)
end

CoD.JetwingHud.AddInfoTitleAndBar = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local f3_local0 = 5
	local f3_local1 = CoD.textSize.ExtraSmall
	local f3_local2 = CoD.fonts.ExtraSmall
	f3_arg3 = f3_arg3 + (f3_arg1 - 1) * f3_local1
	local f3_local3 = LUI.UIText.new()
	f3_local3:setLeftRight(true, true, f3_local0, 0)
	f3_local3:setTopBottom(true, false, f3_arg3, f3_local1 + f3_arg3)
	f3_local3:setRGB(CoD.JetwingHud.BlueColor.r, CoD.JetwingHud.BlueColor.g, CoD.JetwingHud.BlueColor.b)
	f3_local3:setAlpha(CoD.JetwingHud.TextDefaultAlpha)
	f3_local3:setFont(f3_local2)
	f3_local3:setAlignment(LUI.Alignment.Left)
	f3_arg0:addElement(f3_local3)
	f3_local3:setText(f3_arg2)
	local f3_local4 = 3
	local f3_local5 = 50
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f3_local5, 0)
	Widget:setTopBottom(true, false, f3_arg3 - f3_local4, f3_local1 + f3_arg3 + f3_local4)
	f3_arg0:addElement(Widget)
	local f3_local7 = LUI.UIImage.new()
	f3_local7:setLeftRight(true, false, 0, CoD.JetwingHud.InfoBarWidth)
	f3_local7:setTopBottom(false, false, -CoD.JetwingHud.InfoBarHeight / 2, CoD.JetwingHud.InfoBarHeight / 2)
	f3_local7:setImage(CoD.JetwingHud.SPDBracketMaterial)
	Widget:addElement(f3_local7)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.JetwingHud.InfoBarWidth / 2)
	Widget:setTopBottom(false, false, -CoD.JetwingHud.InfoBarHeight / 2, CoD.JetwingHud.InfoBarHeight / 2)
	Widget:setUseStencil(true)
	Widget:addElement(Widget)
	local f3_local9 = LUI.UIImage.new()
	f3_local9:setLeftRight(true, true, 0, 0)
	f3_local9:setTopBottom(true, true, 0, 0)
	f3_local9:setImage(CoD.JetwingHud.SPDFillMaterial)
	Widget:addElement(f3_local9)
	local f3_local10 = LUI.UIImage.new()
	f3_local10:setLeftRight(true, false, CoD.JetwingHud.InfoBarWidth / 2, CoD.JetwingHud.ArrowWidth / 2 + CoD.JetwingHud.InfoBarWidth / 2)
	f3_local10:setTopBottom(false, false, -CoD.JetwingHud.ArrowHeight / 2, CoD.JetwingHud.ArrowHeight / 2)
	f3_local10:setImage(CoD.JetwingHud.SPDSlideTriangleMaterial)
	Widget:addElement(f3_local10)
	local f3_local11 = 1
	local f3_local12 = 10
	local f3_local13 = LUI.UIText.new()
	f3_local13:setLeftRight(true, false, f3_local12, CoD.JetwingHud.InfoBarWidth + f3_local12)
	f3_local13:setTopBottom(false, false, -f3_local1 / 2 + f3_local11, f3_local1 / 2 + f3_local11)
	f3_local13:setFont(f3_local2)
	Widget:addElement(f3_local13)
	f3_local13:setText("0")
	return f3_local13, Widget, f3_local10
end

CoD.JetwingHud.AddLeftSideStuff = function (f4_arg0, f4_arg1)
	local f4_local0 = CoD.JetwingHud.OuterBracketWidth
	local f4_local1 = CoD.JetwingHud.OuterBracketHeight
	local f4_local2 = 60
	local f4_local3 = 25
	local f4_local4 = 20
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f4_local4, 0)
	Widget:setTopBottom(false, false, -f4_local2 / 2 - f4_local3, f4_local2 / 2 - f4_local3)
	f4_arg1:addElement(Widget)
	local f4_local6 = 5
	local f4_local7 = CoD.textSize.ExtraSmall
	local f4_local8 = 5
	local f4_local9, f4_local10, f4_local11 = CoD.JetwingHud.AddInfoTitleAndBar(Widget, 1, "THR", f4_local8)
	f4_arg0.thrBarArrows = f4_local11
	f4_arg0.thrBarContainerStencil = f4_local10
	f4_arg0.thrTextValue = f4_local9
	local f4_local10, f4_local11, f4_local12 = CoD.JetwingHud.AddInfoTitleAndBar(Widget, 2, "MPH", f4_local8 + 10)
	f4_arg0.mphBarArrows = f4_local12
	f4_arg0.mphBarContainerStencil = f4_local11
	f4_arg0.mphTextValue = f4_local10
	f4_local10 = f4_local1 * 0.3
	f4_local11 = -50
	f4_local12 = 80
	local f4_local13 = 35
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f4_local0 + f4_local11, f4_local11)
	Widget:setTopBottom(false, true, -f4_local12 - f4_local10, -f4_local10)
	Widget:setYRot(-f4_local13)
	f4_arg1:addElement(Widget)
	local f4_local15 = CoD.textSize.Condensed
	local f4_local16 = CoD.fonts.Condensed
	local f4_local17 = 20
	local f4_local18 = LUI.UIText.new()
	f4_local18:setLeftRight(true, true, 2, 0)
	f4_local18:setTopBottom(true, false, -f4_local17, f4_local15 - f4_local17)
	f4_local18:setRGB(CoD.JetwingHud.BlueColor.r, CoD.JetwingHud.BlueColor.g, CoD.JetwingHud.BlueColor.b)
	f4_local18:setAlpha(CoD.JetwingHud.TextDefaultAlpha)
	f4_local18:setFont(f4_local16)
	f4_local18:setAlignment(LUI.Alignment.Left)
	Widget:addElement(f4_local18)
	f4_local18:setText("ALT ---- FT")
	f4_arg0.altimeterText = f4_local18
	local f4_local19 = 75
	local f4_local20 = f4_local19 / 2
	CoD.JetwingHud.AddRCSemiCircles(Widget, 0, f4_local19, f4_local20, "R")
	local f4_local21 = f4_local19 + 10
	CoD.JetwingHud.AddRCSemiCircles(Widget, f4_local21, f4_local19 + f4_local21, f4_local20, "C")
	local f4_local22 = 150
	local f4_local23 = f4_local19 + f4_local21 + 20
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f4_local23, f4_local22 + f4_local23)
	Widget:setTopBottom(false, false, -f4_local22 / 2, f4_local22 / 2)
	Widget:addElement(Widget)
	local f4_local25 = LUI.UIImage.new()
	f4_local25:setupRollLevel(-1)
	f4_local25:setLeftRight(true, true, 0, 0)
	f4_local25:setTopBottom(true, true, 0, 0)
	f4_local25:setImage(RegisterMaterial("hud_haiti_fly_crosshair_grid_circle"))
	Widget:addElement(f4_local25)
	local f4_local26 = 50
	local f4_local27 = LUI.UIImage.new()
	f4_local27:setupRollLevel(1)
	f4_local27:setLeftRight(true, true, 0, 0)
	f4_local27:setTopBottom(true, true, 0, 0)
	f4_local27:setImage(RegisterMaterial("hud_haiti_fly_crosshair_middle"))
	Widget:addElement(f4_local27)
end

CoD.JetwingHud.AddRCSemiCircles = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	local f5_local0 = 8
	local f5_local1 = LUI.UIImage.new()
	f5_local1:setLeftRight(true, false, f5_arg1, f5_arg2)
	f5_local1:setTopBottom(false, true, -f5_arg3 - f5_local0, -f5_local0)
	f5_local1:setImage(CoD.JetwingHud.RCSemiCircleMaterial)
	f5_arg0:addElement(f5_local1)
	local f5_local2 = LUI.UIImage.new()
	f5_local2:setLeftRight(true, false, f5_arg1, f5_arg2)
	f5_local2:setTopBottom(false, true, -f5_arg3 - f5_local0, -f5_local0)
	f5_local2:setImage(CoD.JetwingHud.RCSemiCircleFillMaterial)
	f5_arg0:addElement(f5_local2)
	local f5_local3 = CoD.textSize.ExtraSmall
	local f5_local4 = CoD.fonts.ExtraSmall
	local f5_local5 = f5_arg3 + f5_local0 - 3
	local f5_local6 = 3
	local f5_local7 = 10
	local f5_local8 = LUI.UIText.new()
	f5_local8:setLeftRight(true, false, f5_arg1 + f5_local6, 10 + f5_arg1 + f5_local6)
	f5_local8:setTopBottom(false, true, -f5_local3 - f5_local5, -f5_local5)
	f5_local8:setRGB(CoD.JetwingHud.BlueColor.r, CoD.JetwingHud.BlueColor.g, CoD.JetwingHud.BlueColor.b)
	f5_local8:setAlpha(CoD.JetwingHud.TextDefaultAlpha)
	f5_local8:setFont(f5_local4)
	f5_local8:setAlignment(LUI.Alignment.Left)
	f5_arg0:addElement(f5_local8)
	f5_local8:setText("0")
	local f5_local9 = LUI.UIText.new()
	f5_local9:setLeftRight(true, false, f5_arg2 - f5_local7, 10 + f5_arg2 - f5_local7)
	f5_local9:setTopBottom(false, true, -f5_local3 - f5_local5, -f5_local5)
	f5_local9:setRGB(CoD.JetwingHud.BlueColor.r, CoD.JetwingHud.BlueColor.g, CoD.JetwingHud.BlueColor.b)
	f5_local9:setAlpha(CoD.JetwingHud.TextDefaultAlpha)
	f5_local9:setFont(f5_local4)
	f5_arg0:addElement(f5_local9)
	f5_local9:setText("9")
	local f5_local10 = (f5_arg1 + f5_arg2) / 2 - 2
	local f5_local11 = 25 + f5_local0
	local f5_local12 = LUI.UIText.new()
	f5_local12:setLeftRight(true, false, f5_local10, 10 + f5_local10)
	f5_local12:setTopBottom(false, true, -f5_local3 - f5_local11, -f5_local11)
	f5_local12:setRGB(CoD.JetwingHud.BlueColor.r, CoD.JetwingHud.BlueColor.g, CoD.JetwingHud.BlueColor.b)
	f5_local12:setAlpha(CoD.JetwingHud.TextDefaultAlpha)
	f5_local12:setFont(f5_local4)
	f5_local12:setAlignment(LUI.Alignment.Left)
	f5_arg0:addElement(f5_local12)
	f5_local12:setText(f5_arg4)
end

CoD.JetwingHud.LSpinningNeedle = function (f6_arg0, f6_arg1)
	f6_arg0:beginAnimation("rotate_needle", f6_arg1.timer.interval)
	f6_arg0:setZRot(math.random(-270, 0))
	f6_arg1.timer.interval = math.random(500, 750)
end

CoD.JetwingHud.AddRightSideStuff = function (f7_arg0)
	local f7_local0 = RegisterMaterial("hud_haiti_fly_l1_circle")
	local f7_local1 = RegisterMaterial("hud_haiti_fly_l_circle_line")
	local f7_local2 = CoD.JetwingHud.OuterBracketWidth
	local f7_local3 = CoD.JetwingHud.OuterBracketHeight
	local f7_local4 = 60
	local f7_local5 = 38
	local f7_local6 = f7_local2 * 0.6
	local f7_local7 = CoD.fonts.ExtraSmall
	local f7_local8 = CoD.textSize.ExtraSmall
	local f7_local9 = 10
	local f7_local10 = f7_local4 * 0.25
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f7_local4 - f7_local6, -f7_local6)
	Widget:setTopBottom(false, false, -f7_local4 - f7_local5, -f7_local5)
	f7_arg0:addElement(Widget)
	local f7_local12 = LUI.UIImage.new()
	f7_local12:setLeftRight(true, true, 0, 0)
	f7_local12:setTopBottom(true, true, 0, 0)
	f7_local12:setImage(f7_local0)
	Widget:addElement(f7_local12)
	local f7_local13 = LUI.UIText.new()
	f7_local13:setLeftRight(true, true, 0, 0)
	f7_local13:setTopBottom(true, false, -f7_local8 + f7_local9, f7_local9)
	f7_local13:setRGB(CoD.JetwingHud.BlueColor.r, CoD.JetwingHud.BlueColor.g, CoD.JetwingHud.BlueColor.b)
	f7_local13:setAlpha(CoD.JetwingHud.TextDefaultAlpha)
	f7_local13:setFont(f7_local7)
	Widget:addElement(f7_local13)
	f7_local13:setText("L1")
	local f7_local14 = LUI.UIImage.new()
	f7_local14:setLeftRight(true, true, 0, 0)
	f7_local14:setTopBottom(true, true, 0, 0)
	f7_local14:setImage(f7_local1)
	f7_local14:registerEventHandler("spinning_needle", CoD.JetwingHud.LSpinningNeedle)
	Widget:addElement(f7_local14)
	f7_local14:setZRot(-119)
	Widget:addElement(LUI.UITimer.new(CoD.JetwingHud.SpinNeedleDuration, "spinning_needle", false, f7_local14))
	local f7_local15 = f7_local4 - f7_local5 + 30
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f7_local4 - f7_local6, -f7_local6)
	Widget:setTopBottom(false, false, -f7_local4 + f7_local15, f7_local15)
	f7_arg0:addElement(Widget)
	local f7_local17 = LUI.UIImage.new()
	f7_local17:setLeftRight(true, true, 0, 0)
	f7_local17:setTopBottom(true, true, 0, 0)
	f7_local17:setImage(f7_local0)
	Widget:addElement(f7_local17)
	local f7_local18 = LUI.UIText.new()
	f7_local18:setLeftRight(true, true, 0, 0)
	f7_local18:setTopBottom(true, false, -f7_local8 + f7_local9, f7_local9)
	f7_local18:setRGB(CoD.JetwingHud.BlueColor.r, CoD.JetwingHud.BlueColor.g, CoD.JetwingHud.BlueColor.b)
	f7_local18:setAlpha(CoD.JetwingHud.TextDefaultAlpha)
	f7_local18:setFont(f7_local7)
	Widget:addElement(f7_local18)
	f7_local18:setText("L2")
	local f7_local19 = LUI.UIImage.new()
	f7_local19:setLeftRight(true, true, 0, 0)
	f7_local19:setTopBottom(true, true, 0, 0)
	f7_local19:setImage(f7_local1)
	f7_local19:registerEventHandler("spinning_needle", CoD.JetwingHud.LSpinningNeedle)
	Widget:addElement(f7_local19)
	f7_local19:setZRot(-16)
	Widget:addElement(LUI.UITimer.new(CoD.JetwingHud.SpinNeedleDuration, "spinning_needle", false, f7_local19))
	local f7_local20 = 35
	local f7_local21 = f7_local3 * 0.4
	local f7_local22 = 40
	local f7_local23 = 80
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f7_local22, -f7_local2 + f7_local22)
	Widget:setTopBottom(false, true, -f7_local23 - f7_local21, -f7_local21)
	Widget:setYRot(f7_local20)
	f7_arg0:addElement(Widget)
	local f7_local25 = RegisterMaterial("hud_haiti_fly_ptc_quarter_circle")
	local f7_local26 = 35
	local f7_local27 = f7_local26 * 2
	local f7_local28 = 5
	local f7_local29 = LUI.UIImage.new()
	f7_local29:setLeftRight(false, true, -f7_local26, 0)
	f7_local29:setTopBottom(false, false, -f7_local27 / 2 + f7_local28, f7_local27 / 2 + f7_local28)
	f7_local29:setImage(RegisterMaterial("hud_haiti_fly_ptc_on"))
	Widget:addElement(f7_local29)
	local f7_local30 = 200
	local f7_local31 = 0
	local f7_local32 = LUI.UIImage.new()
	f7_local32:setLeftRight(false, false, -f7_local30 / 2 + f7_local31, f7_local30 / 2 + f7_local31)
	f7_local32:setTopBottom(false, false, -f7_local30 / 2, f7_local30 / 2)
	f7_local32:setImage(RegisterMaterial("hud_haiti_fly_ptc_grid_circle"))
	Widget:addElement(f7_local32)
	local f7_local33 = LUI.UIImage.new()
	f7_local33:setLeftRight(false, false, -f7_local30 / 2, f7_local30 / 2)
	f7_local33:setTopBottom(false, false, -f7_local30 / 2, f7_local30 / 2)
	f7_local33:setImage(f7_local25)
	Widget:addElement(f7_local33)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f7_local30 / 2 - f7_local31, f7_local30 / 2 - f7_local31)
	Widget:setTopBottom(false, false, -f7_local30 / 2, f7_local30 / 2)
	Widget:addElement(Widget)
	local f7_local35 = LUI.UIImage.new()
	f7_local35:setLeftRight(true, true, 0, 0)
	f7_local35:setTopBottom(true, true, 0, 0)
	f7_local35:setImage(RegisterMaterial("hud_haiti_fly_outer_circle_meter"))
	f7_local35:setRGB(CoD.JetwingHud.BlueColor.r, CoD.JetwingHud.BlueColor.g, CoD.JetwingHud.BlueColor.b)
	f7_local35:setZRot(69)
	f7_local35:setShaderVector(0, 0.75, 0, 0, 0)
	f7_local35:registerEventHandler("decrease_o2_meter", CoD.JetwingHud.DecreaseO2Meter)
	Widget:addElement(f7_local35)
	f7_local35:processEvent({
		name = "decrease_o2_meter",
		duration = 60
	})
	local f7_local36 = LUI.UIImage.new()
	f7_local36:setLeftRight(true, true, 0, 0)
	f7_local36:setTopBottom(true, true, 0, 0)
	f7_local36:setImage(RegisterMaterial("hud_haiti_fly_inner_circle_meter"))
	f7_local36:setRGB(CoD.JetwingHud.BlueColor.r, CoD.JetwingHud.BlueColor.g, CoD.JetwingHud.BlueColor.b)
	f7_local36:setZRot(18)
	f7_local36:setShaderVector(0, 0.5, 0, 0, 0)
	f7_local36:registerEventHandler("pressure_meter", CoD.JetwingHud.PressureMeter)
	Widget:addElement(f7_local36)
	Widget:addElement(LUI.UITimer.new(CoD.JetwingHud.SpinNeedleDuration, "pressure_meter", false, f7_local36))
	local f7_local37 = LUI.UIImage.new()
	f7_local37:setLeftRight(true, true, 0, 0)
	f7_local37:setTopBottom(true, true, 0, 0)
	f7_local37:setImage(RegisterMaterial("hud_haiti_fly_ptc_quarter_circle_white"))
	Widget:addElement(f7_local37)
end

CoD.JetwingHud.DecreaseO2Meter = function (f8_arg0, f8_arg1)
	f8_arg0:beginAnimation("decrease_meter", f8_arg1.duration * 1000)
	f8_arg0:setShaderVector(0, 0, 0, 0, 0)
end

CoD.JetwingHud.PressureMeter = function (f9_arg0, f9_arg1)
	local f9_local0 = math.random(800) * 0
	f9_arg0:beginAnimation("randomize_meter", f9_arg1.timer.interval)
	f9_arg0:setShaderVector(0, f9_local0, 0, 0, 0)
	f9_arg1.timer.interval = math.random(750, 1000)
end

CoD.JetwingHud.AddCenterStuff = function (f10_arg0, f10_arg1)
	local f10_local0 = 15
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -234, 234)
	Widget:setTopBottom(true, false, 0, 64)
	Widget:setImage(RegisterMaterial("hud_horizontal_compass"))
	Widget:setShaderVector(0, 1, -0.5, 0, 0)
	Widget:setupHorizontalCompass()
	f10_arg1:addElement(Widget)
	local f10_local2 = RegisterMaterial("hud_haiti_fly_aim_bracket_long")
	local f10_local3, f10_local4 = nil
	f10_local3 = 75
	f10_local4 = -175
	f10_local3 = f10_local3 + 5
	f10_local4 = f10_local4 + 60
	CoD.JetwingHud.CreateBracketRow(f10_arg1, f10_local2, true, 180, 180, 75 + 5, 115 + 60)
end

CoD.JetwingHud.CreateBracketRow = function (f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_arg4, f11_arg5, f11_arg6)
	local f11_local0 = 150
	local f11_local1 = f11_local0 / 8
	if not f11_arg2 then
		f11_local0 = f11_local0 / 2
		f11_local1 = f11_local0 / 4
	end
	local f11_local2 = LUI.UIImage.new()
	f11_local2:setLeftRight(false, false, -f11_local0 / 2 - f11_arg5, f11_local0 / 2 - f11_arg5)
	f11_local2:setTopBottom(false, false, -f11_local1 / 2 + f11_arg6, f11_local1 / 2 + f11_arg6)
	f11_local2:setImage(f11_arg1)
	f11_local2:setXRot(f11_arg4)
	f11_local2:setYRot(f11_arg3)
	f11_arg0:addElement(f11_local2)
	local f11_local3 = LUI.UIImage.new()
	f11_local3:setLeftRight(false, false, -f11_local0 / 2 + f11_arg5, f11_local0 / 2 + f11_arg5)
	f11_local3:setTopBottom(false, false, -f11_local1 / 2 + f11_arg6, f11_local1 / 2 + f11_arg6)
	f11_local3:setXRot(f11_arg4)
	f11_local3:setImage(f11_arg1)
	f11_arg0:addElement(f11_local3)
end

CoD.JetwingHud.UpdateVehicleData = function (f12_arg0, f12_arg1)
	if f12_arg0.altimeterText and f12_arg1.alt then
		f12_arg0.altimeterText:setText("ALT " .. f12_arg1.alt .. " FT")
	end
	if f12_arg0.thrTextValue and f12_arg0.thrBarContainerStencil and f12_arg0.thrBarArrows and f12_arg1.thrust then
		f12_arg0.thrTextValue:setText(f12_arg1.thrust)
		local f12_local0 = CoD.JetwingHud.InfoBarWidth * f12_arg1.thrust * 0.01
		f12_arg0.thrBarContainerStencil:beginAnimation("update_thrust")
		f12_arg0.thrBarContainerStencil:setLeftRight(true, false, 0, f12_local0)
		f12_arg0.thrBarArrows:beginAnimation("update_thrust")
		f12_arg0.thrBarArrows:setLeftRight(true, false, f12_local0 - 3, CoD.JetwingHud.ArrowWidth / 2 + f12_local0 - 3)
	end
	if f12_arg0.mphTextValue and f12_arg0.mphBarContainerStencil and f12_arg0.mphBarArrows and f12_arg1.speed and f12_arg1.maxSpeed then
		f12_arg0.mphTextValue:setText(f12_arg1.speed)
		local f12_local0 = CoD.JetwingHud.InfoBarWidth * f12_arg1.speed / f12_arg1.maxSpeed - 10
		f12_arg0.mphBarContainerStencil:beginAnimation("update_thrust")
		f12_arg0.mphBarContainerStencil:setLeftRight(true, false, 0, f12_local0)
		f12_arg0.mphBarArrows:beginAnimation("update_thrust")
		f12_arg0.mphBarArrows:setLeftRight(true, false, f12_local0 - 3, CoD.JetwingHud.ArrowWidth / 2 + f12_local0 - 3)
	end
end

CoD.JetwingHud.JetwingAlpha = function (f13_arg0, f13_arg1)
	if f13_arg1.data[1] then
		f13_arg0:setAlpha(f13_arg1.data[1] * 0.01)
	end
end

CoD.JetwingHud.UpdateVisibility = function (f14_arg0, f14_arg1)
	if UIExpression.IsVisibilityBitSet(f14_arg1.controller, CoD.BIT_UI_ACTIVE) == 0 then
		if f14_arg0.visible ~= true then
			f14_arg0:setAlpha(CoD.JetwingHud.DefaultAlpha)
			f14_arg0.visible = true
		end
	elseif f14_arg0.visible == true then
		f14_arg0:setAlpha(0)
		f14_arg0.visible = nil
	end
	f14_arg0:dispatchEventToChildren(f14_arg1)
end

