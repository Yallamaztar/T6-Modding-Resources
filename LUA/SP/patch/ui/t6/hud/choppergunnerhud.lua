CoD.ChopperGunnerHUD = {}
CoD.ChopperGunnerHUD.DefaultAlpha = 1
CoD.ChopperGunnerHUD.BaseColorBlue = CoD.greenBlue
CoD.ChopperGunnerHUD.BaseColor = {}
CoD.ChopperGunnerHUD.BaseColor.r = 1
CoD.ChopperGunnerHUD.BaseColor.g = 1
CoD.ChopperGunnerHUD.BaseColor.b = 1
CoD.ChopperGunnerHUD.AlphaEmpty = 1
CoD.ChopperGunnerHUD.ContainerHeight = 512
CoD.ChopperGunnerHUD.ContainerWidth = 700
CoD.ChopperGunnerHUD.PulseTime = 500
CoD.ChopperGunnerHUD.SliderArrowHeight = 16
CoD.ChopperGunnerHUD.SliderArrowWidth = CoD.ChopperGunnerHUD.SliderArrowHeight * 2
CoD.ChopperGunnerHUD.OverheatIconWidth = 16
CoD.ChopperGunnerHUD.OverheatIconHeight = CoD.ChopperGunnerHUD.OverheatIconWidth * 8
LUI.createMenu.ChopperGunnerHud = function (f1_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.ChopperGunnerHUD.ContainerWidth / 2, CoD.ChopperGunnerHUD.ContainerWidth / 2)
	Widget:setTopBottom(false, false, -CoD.ChopperGunnerHUD.ContainerHeight / 2, CoD.ChopperGunnerHUD.ContainerHeight / 2)
	CoD.ChopperGunnerHUD.AddBrackets(Widget)
	Widget.addMissiles = CoD.ChopperGunnerHUD.AddMissiles
	Widget.missilesOffline = CoD.ChopperGunnerHUD.MissilesOffline
	Widget.addMainTurret = CoD.ChopperGunnerHUD.AddMainTurret
	Widget.disableOverheatTurret = CoD.ChopperGunnerHUD.DisableOverheatTurret
	Widget:registerEventHandler("hud_update_refresh", CoD.ChopperGunnerHUD.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.ChopperGunnerHUD.UpdateVisibility)
	return Widget
end

CoD.ChopperGunnerHUD.AddBrackets = function (f2_arg0)
	local f2_local0 = RegisterMaterial("mp_hud_wasp_bracket")
	local f2_local1 = 64
	local f2_local2 = 512
	local f2_local3 = LUI.UIImage.new()
	f2_local3:setLeftRight(true, false, 0, f2_local1)
	f2_local3:setTopBottom(false, false, -f2_local2 / 2, f2_local2 / 2)
	f2_local3:setImage(f2_local0)
	f2_local3:setXRot(180)
	f2_arg0:addElement(f2_local3)
	local f2_local4 = LUI.UIImage.new()
	f2_local4:setLeftRight(false, true, 0, -f2_local1)
	f2_local4:setTopBottom(false, false, -f2_local2 / 2, f2_local2 / 2)
	f2_local4:setImage(f2_local0)
	f2_arg0:addElement(f2_local4)
	local f2_local5 = 15
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -234, 234)
	Widget:setTopBottom(false, true, -f2_local5, 64 - f2_local5)
	Widget:setImage(RegisterMaterial("hud_horizontal_compass"))
	Widget:setShaderVector(0, 1, -0.5, 0, 0)
	Widget:setupHorizontalCompass()
	f2_arg0:addElement(Widget)
	local f2_local7 = LUI.UIImage.new()
	f2_local7:setupRollLevel(1)
	f2_local7:setLeftRight(false, false, -256, 256)
	f2_local7:setTopBottom(false, false, -128, 128)
	f2_local7:setImage(RegisterMaterial("mp_hud_wasp_inner"))
	f2_arg0:addElement(f2_local7)
	local f2_local8 = LUI.UIImage.new()
	f2_local8:setupRollLevel(-1)
	f2_local8:setLeftRight(false, false, -256, 256)
	f2_local8:setTopBottom(false, false, -256, 256)
	f2_local8:setImage(RegisterMaterial("mp_hud_wasp_outer"))
	f2_arg0:addElement(f2_local8)
	local f2_local9 = LUI.UIImage.new()
	f2_local9:setLeftRight(false, false, -32, 32)
	f2_local9:setTopBottom(false, false, -32, 32)
	f2_local9:setImage(RegisterMaterial("mp_hud_wasp_crosshair"))
	f2_arg0:addElement(f2_local9)
end

CoD.ChopperGunnerHUD.AddMissiles = function (f3_arg0, f3_arg1)
	local f3_local0 = RegisterMaterial("hud_pak_drone_rocket")
	local f3_local1 = RegisterMaterial("hud_pak_drone_rocket_outline")
	if not f3_arg1 then
		f3_arg1 = 1
	end
	local f3_local2 = 25
	local f3_local3 = 90
	local f3_local4 = 55
	f3_arg0.missileStencilRight = {}
	f3_arg0.missileContainerRight = {}
	for f3_local5 = 1, f3_arg1, 1 do
		f3_arg0.missileContainerRight[f3_local5] = LUI.UIElement.new()
		f3_arg0.missileContainerRight[f3_local5]:setLeftRight(false, true, f3_local2 * (f3_local5 - 1) - 5 * (f3_local5 - 1), f3_local2 * f3_local5 - 5 * (f3_local5 - 1))
		f3_arg0.missileContainerRight[f3_local5]:setTopBottom(false, true, -f3_local3 - f3_local4, -f3_local4)
		f3_arg0.missileContainerRight[f3_local5]:registerEventHandler("reload_done", CoD.ChopperGunnerHUD.MissileReloadDone)
		local f3_local8 = LUI.UIImage.new()
		f3_local8:setLeftRight(true, true, 0, 0)
		f3_local8:setTopBottom(true, true, 0, 0)
		f3_local8:setRGB(CoD.ChopperGunnerHUD.BaseColor.r, CoD.ChopperGunnerHUD.BaseColor.g, CoD.ChopperGunnerHUD.BaseColor.b)
		f3_local8:setImage(f3_local0)
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:setUseStencil(true)
		f3_arg0.missileStencilRight[f3_local5] = Widget
		local missileStatusRightTextContainer = LUI.UIImage.new()
		missileStatusRightTextContainer:setLeftRight(true, true, 0, 0)
		missileStatusRightTextContainer:setTopBottom(false, true, -f3_local3, 0)
		missileStatusRightTextContainer:setRGB(CoD.ChopperGunnerHUD.BaseColor.r, CoD.ChopperGunnerHUD.BaseColor.g, CoD.ChopperGunnerHUD.BaseColor.b)
		missileStatusRightTextContainer:setImage(f3_local1)
		Widget:addElement(missileStatusRightTextContainer)
		f3_arg0.missileContainerRight[f3_local5]:addElement(f3_local8)
		f3_arg0.missileContainerRight[f3_local5]:addElement(Widget)
		f3_arg0:addElement(f3_arg0.missileContainerRight[f3_local5])
	end
	local f3_local5 = 50
	local f3_local6 = 35
	local f3_local7 = CoD.textSize.Default
	local f3_local11 = CoD.fonts.Default
	local f3_local8 = 50
	local Widget = 20
	
	local missileStatusRightTextContainer = LUI.UIElement.new()
	missileStatusRightTextContainer:setLeftRight(false, true, -f3_local8 + f3_local5, f3_local5)
	missileStatusRightTextContainer:setTopBottom(false, true, -Widget - f3_local6, -f3_local6)
	missileStatusRightTextContainer:registerEventHandler("on", CoD.ChopperGunnerHUD.BlinkOn)
	missileStatusRightTextContainer:registerEventHandler("off", CoD.ChopperGunnerHUD.BlinkOff)
	f3_arg0:addElement(missileStatusRightTextContainer)
	f3_arg0.missileStatusRightTextContainer = missileStatusRightTextContainer
	
	local missileStatusRightText = LUI.UIText.new()
	missileStatusRightText:setLeftRight(true, true, 0, 0)
	missileStatusRightText:setTopBottom(false, false, -f3_local7 / 2, f3_local7 / 2)
	missileStatusRightText:setFont(f3_local11)
	missileStatusRightText:setRGB(CoD.ChopperGunnerHUD.BaseColorBlue.r, CoD.ChopperGunnerHUD.BaseColorBlue.g, CoD.ChopperGunnerHUD.BaseColorBlue.b)
	missileStatusRightText:setAlpha(0.5)
	missileStatusRightText:setAlignment(LUI.Alignment.Left)
	missileStatusRightText:setText("RDY")
	missileStatusRightText:registerEventHandler("reload_done", CoD.ChopperGunnerHUD.ReloadDone)
	missileStatusRightTextContainer:addElement(missileStatusRightText)
	f3_arg0.missileStatusRightText = missileStatusRightText
	
	f3_arg0.missileStencilLeft = {}
	f3_arg0.missileContainerLeft = {}
	for missileStatusLeftTextContainer = 1, f3_arg1, 1 do
		f3_arg0.missileContainerLeft[missileStatusLeftTextContainer] = LUI.UIElement.new()
		f3_arg0.missileContainerLeft[missileStatusLeftTextContainer]:setLeftRight(true, false, -(f3_local2 * missileStatusLeftTextContainer) + 5 * (missileStatusLeftTextContainer - 1), -f3_local2 * (missileStatusLeftTextContainer - 1) + 5 * (missileStatusLeftTextContainer - 1))
		f3_arg0.missileContainerLeft[missileStatusLeftTextContainer]:setTopBottom(false, true, -f3_local3 - f3_local4, -f3_local4)
		f3_arg0.missileContainerLeft[missileStatusLeftTextContainer]:registerEventHandler("reload_done", CoD.ChopperGunnerHUD.MissileReloadDone)
		local f3_local16 = LUI.UIImage.new()
		f3_local16:setLeftRight(true, true, 0, 0)
		f3_local16:setTopBottom(true, true, 0, 0)
		f3_local16:setRGB(CoD.ChopperGunnerHUD.BaseColor.r, CoD.ChopperGunnerHUD.BaseColor.g, CoD.ChopperGunnerHUD.BaseColor.b)
		f3_local16:setImage(f3_local0)
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:setUseStencil(true)
		f3_arg0.missileStencilLeft[missileStatusLeftTextContainer] = Widget
		local f3_local18 = LUI.UIImage.new()
		f3_local18:setLeftRight(true, true, 0, 0)
		f3_local18:setTopBottom(false, true, -f3_local3, 0)
		f3_local18:setRGB(CoD.ChopperGunnerHUD.BaseColor.r, CoD.ChopperGunnerHUD.BaseColor.g, CoD.ChopperGunnerHUD.BaseColor.b)
		f3_local18:setImage(f3_local1)
		Widget:addElement(f3_local18)
		f3_arg0.missileContainerLeft[missileStatusLeftTextContainer]:addElement(Widget)
		f3_arg0.missileContainerLeft[missileStatusLeftTextContainer]:addElement(f3_local16)
		f3_arg0:addElement(f3_arg0.missileContainerLeft[missileStatusLeftTextContainer])
	end
	local missileStatusLeftTextContainer = LUI.UIElement.new()
	missileStatusLeftTextContainer:setLeftRight(true, false, -f3_local5, f3_local8 - f3_local5)
	missileStatusLeftTextContainer:setTopBottom(false, true, -Widget - f3_local6, -f3_local6)
	missileStatusLeftTextContainer:registerEventHandler("on", CoD.ChopperGunnerHUD.BlinkOn)
	missileStatusLeftTextContainer:registerEventHandler("off", CoD.ChopperGunnerHUD.BlinkOff)
	f3_arg0:addElement(missileStatusLeftTextContainer)
	f3_arg0.missileStatusLeftTextContainer = missileStatusLeftTextContainer
	
	local missileStatusLeftText = LUI.UIText.new()
	missileStatusLeftText:setLeftRight(true, true, 0, 0)
	missileStatusLeftText:setTopBottom(false, false, -f3_local7 / 2, f3_local7 / 2)
	missileStatusLeftText:setFont(f3_local11)
	missileStatusLeftText:setRGB(CoD.ChopperGunnerHUD.BaseColorBlue.r, CoD.ChopperGunnerHUD.BaseColorBlue.g, CoD.ChopperGunnerHUD.BaseColorBlue.b)
	missileStatusLeftText:setAlpha(0.5)
	missileStatusLeftText:setAlignment(LUI.Alignment.Right)
	missileStatusLeftText:setText("RDY")
	missileStatusLeftText:registerEventHandler("reload_done", CoD.ChopperGunnerHUD.ReloadDone)
	missileStatusLeftTextContainer:addElement(missileStatusLeftText)
	f3_arg0.missileStatusLeftText = missileStatusLeftText
	
	f3_arg0:registerEventHandler("hud_gunner_missile_fire", CoD.ChopperGunnerHUD.UpdateMissiles)
end

CoD.ChopperGunnerHUD.MissilesOffline = function (f4_arg0, f4_arg1)
	if not f4_arg1 then
		f4_arg1 = 1
	end
	for f4_local0 = 1, f4_arg1, 1 do
		if f4_arg0.missileContainerRight[f4_local0] then
			f4_arg0.missileContainerRight[f4_local0]:setAlpha(0.5)
		end
		if f4_arg0.missileContainerLeft[f4_local0] then
			f4_arg0.missileContainerLeft[f4_local0]:setAlpha(0.5)
		end
	end
	f4_arg0.missileStatusRightText:setText("----")
	f4_arg0.missileStatusLeftText:setText("----")
end

CoD.ChopperGunnerHUD.AddMainTurret = function (f5_arg0)
	local f5_local0 = "Default"
	local f5_local1 = 40
	local f5_local2 = 128
	local f5_local3 = 40
	
	local topArrowTextContainer = LUI.UIElement.new()
	topArrowTextContainer:setLeftRight(false, false, -f5_local2 / 2, f5_local2 / 2)
	topArrowTextContainer:setTopBottom(true, false, -f5_local3, CoD.textSize[f5_local0] - f5_local3)
	topArrowTextContainer.id = topArrowTextContainer.id .. "TopArrowTextContainer"
	topArrowTextContainer:registerEventHandler("transition_complete_pulse_low", CoD.ChopperGunnerHUD.OverheatPulseLow)
	topArrowTextContainer:registerEventHandler("transition_complete_pulse_high", CoD.ChopperGunnerHUD.OverheatPulseHigh)
	f5_arg0:addElement(topArrowTextContainer)
	f5_arg0.topArrowTextContainer = topArrowTextContainer
	
	local topArrowText = LUI.UIText.new()
	topArrowText:setLeftRight(true, true, 0, 0)
	topArrowText:setTopBottom(true, true, 0, 0)
	topArrowText:setFont(CoD.fonts[f5_local0])
	topArrowText:setRGB(CoD.ChopperGunnerHUD.BaseColorBlue.r, CoD.ChopperGunnerHUD.BaseColorBlue.g, CoD.ChopperGunnerHUD.BaseColorBlue.b)
	topArrowText.id = topArrowText.id .. ".TopArrowText"
	topArrowTextContainer:addElement(topArrowText)
	f5_arg0.topArrowText = topArrowText
	
	local f5_local6 = "40MM CANNON"
	topArrowText:setText(f5_local6)
	local f5_local7 = CoD.ChopperGunnerHUD.SliderArrowHeight
	local f5_local8 = CoD.ChopperGunnerHUD.SliderArrowWidth
	local f5_local9 = CoD.ChopperGunnerHUD.OverheatIconWidth
	local f5_local10 = CoD.ChopperGunnerHUD.OverheatIconHeight
	local f5_local11 = -70
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f5_local9 / 2, f5_local9 / 2)
	Widget:setTopBottom(true, false, f5_local11, f5_local10 + f5_local11)
	Widget:setZRot(-90)
	Widget.id = Widget.id .. ".CannonLeftContainer"
	f5_arg0:addElement(Widget)
	local f5_local13 = LUI.UIImage.new()
	f5_local13:setLeftRight(true, true, 0, 0)
	f5_local13:setTopBottom(true, true, 0, 0)
	f5_local13:setImage(RegisterMaterial("mech_flame_bar"))
	f5_local13.id = f5_local13.id .. ".CannonLeftLine"
	Widget:addElement(f5_local13)
	f5_arg0.overheatContainer = Widget
	
	local cannonLeftFill = LUI.UIImage.new()
	cannonLeftFill:setLeftRight(true, true, 6, -6)
	cannonLeftFill:setTopBottom(false, true, 0, 0)
	cannonLeftFill:setRGB(CoD.ChopperGunnerHUD.BaseColorBlue.r, CoD.ChopperGunnerHUD.BaseColorBlue.g, CoD.ChopperGunnerHUD.BaseColorBlue.b)
	cannonLeftFill.id = cannonLeftFill.id .. ".CannonLeftFill"
	Widget:addElement(cannonLeftFill)
	f5_arg0.cannonLeftFill = cannonLeftFill
	
	local cannonLeftArrow = LUI.UIImage.new()
	cannonLeftArrow:setLeftRight(false, true, 0, f5_local8)
	cannonLeftArrow:setTopBottom(false, true, -f5_local7 / 2, f5_local7 / 2)
	cannonLeftArrow:setImage(RegisterMaterial("mech_flame_arrow_flipped"))
	cannonLeftArrow.id = cannonLeftArrow.id .. ".CannonLeftArrow"
	Widget:addElement(cannonLeftArrow)
	f5_arg0.cannonLeftArrow = cannonLeftArrow
	
	local f5_local16 = 26
	local f5_local17 = f5_local16
	local f5_local18 = RegisterMaterial("hud_sp_triangle")
	local f5_local19, f5_local20, f5_local21, f5_local22 = GetTextDimensions(f5_local6, CoD.fonts[f5_local0], CoD.textSize[f5_local0])
	local f5_local23 = 16
	local f5_local24 = f5_local21 - f5_local19 + f5_local16 + 20
	
	local mainWeaponOverheatL = LUI.UIImage.new()
	mainWeaponOverheatL:setLeftRight(false, false, -f5_local16 / 2 - f5_local24 / 2, f5_local16 / 2 - f5_local24 / 2)
	mainWeaponOverheatL:setTopBottom(true, false, -f5_local17 - f5_local23, -f5_local23)
	mainWeaponOverheatL:setImage(f5_local18)
	mainWeaponOverheatL:setAlpha(0)
	mainWeaponOverheatL.id = mainWeaponOverheatL.id .. ".MainWeaponOverheatImageL"
	mainWeaponOverheatL:registerEventHandler("transition_complete_pulse_low", CoD.ChopperGunnerHUD.OverheatPulseLow)
	mainWeaponOverheatL:registerEventHandler("transition_complete_pulse_high", CoD.ChopperGunnerHUD.OverheatPulseHigh)
	f5_arg0:addElement(mainWeaponOverheatL)
	f5_arg0.mainWeaponOverheatL = mainWeaponOverheatL
	
	local mainWeaponOverheatR = LUI.UIImage.new()
	mainWeaponOverheatR:setLeftRight(false, false, -f5_local16 / 2 + f5_local24 / 2, f5_local16 / 2 + f5_local24 / 2)
	mainWeaponOverheatR:setTopBottom(true, false, -f5_local17 - f5_local23, -f5_local23)
	mainWeaponOverheatR:setImage(f5_local18)
	mainWeaponOverheatR:setAlpha(0)
	mainWeaponOverheatR.id = mainWeaponOverheatR.id .. ".MainWeaponOverheatImageR"
	mainWeaponOverheatR:registerEventHandler("transition_complete_pulse_low", CoD.ChopperGunnerHUD.OverheatPulseLow)
	mainWeaponOverheatR:registerEventHandler("transition_complete_pulse_high", CoD.ChopperGunnerHUD.OverheatPulseHigh)
	f5_arg0:addElement(mainWeaponOverheatR)
	f5_arg0.mainWeaponOverheatR = mainWeaponOverheatR
	
	f5_arg0:registerEventHandler("hud_weapon_cg_heat", CoD.ChopperGunnerHUD.UpdateWeaponHeat)
end

CoD.ChopperGunnerHUD.DisableOverheatTurret = function (f6_arg0, f6_arg1)
	if f6_arg0.overheatContainer then
		f6_arg0.overheatContainer:close()
	end
	if f6_arg0.mainWeaponOverheatL then
		f6_arg0.mainWeaponOverheatL:close()
	end
	if f6_arg0.mainWeaponOverheatR then
		f6_arg0.mainWeaponOverheatR:close()
	end
end

CoD.ChopperGunnerHUD.UpdateWeaponHeat = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg1.data[1] / 100
	local f7_local1 = f7_arg1.data[2]
	local f7_local2 = CoD.ChopperGunnerHUD.OverheatIconHeight - 1
	local f7_local3 = CoD.ChopperGunnerHUD.SliderArrowHeight
	if f7_arg0.cannonLeftFill then
		f7_arg0.cannonLeftFill:beginAnimation("fill", 50, false, false)
		f7_arg0.cannonLeftFill:setTopBottom(false, true, -f7_local2 * f7_local0, -1)
	end
	if f7_arg0.cannonLeftArrow then
		f7_arg0.cannonLeftArrow:beginAnimation("fill", 50, false, false)
		f7_arg0.cannonLeftArrow:setTopBottom(false, true, -f7_local2 * f7_local0 - f7_local3 / 2, -f7_local2 * f7_local0 + f7_local3 / 2)
	end
	if f7_arg0.mainWeaponOverheatL and f7_arg0.mainWeaponOverheatR and f7_arg0.topArrowText then
		if f7_local1 == 1 and not f7_arg0.mainWeaponOverheatL.overheat then
			f7_arg0.mainWeaponOverheatL.overheat = true
			f7_arg0.mainWeaponOverheatL:beginAnimation("pulse_low")
			f7_arg0.mainWeaponOverheatL:setAlpha(0.2)
			f7_arg0.mainWeaponOverheatR:beginAnimation("pulse_low")
			f7_arg0.mainWeaponOverheatR:setAlpha(0.2)
			f7_arg0.topArrowTextContainer:beginAnimation("pulse_low")
			f7_arg0.topArrowTextContainer:setAlpha(0.2)
			f7_arg0.topArrowText:beginAnimation("red_alert")
			f7_arg0.topArrowText:setRGB(1, 0, 0)
			f7_arg0.cannonLeftFill:beginAnimation("red_alert")
			f7_arg0.cannonLeftFill:setRGB(1, 0, 0)
		elseif f7_local1 == 0 and f7_arg0.mainWeaponOverheatL.overheat == true then
			f7_arg0.mainWeaponOverheatL.overheat = nil
			f7_arg0.mainWeaponOverheatL:beginAnimation("hide")
			f7_arg0.mainWeaponOverheatL:setAlpha(0)
			f7_arg0.mainWeaponOverheatR:beginAnimation("hide")
			f7_arg0.mainWeaponOverheatR:setAlpha(0)
			f7_arg0.topArrowTextContainer:beginAnimation("default")
			f7_arg0.topArrowTextContainer:setAlpha(1)
			f7_arg0.topArrowText:beginAnimation("default", 250)
			f7_arg0.topArrowText:setRGB(CoD.ChopperGunnerHUD.BaseColorBlue.r, CoD.ChopperGunnerHUD.BaseColorBlue.g, CoD.ChopperGunnerHUD.BaseColorBlue.b)
			f7_arg0.cannonLeftFill:beginAnimation("default")
			f7_arg0.cannonLeftFill:setTopBottom(false, true, 0, 0)
			f7_arg0.cannonLeftFill:setRGB(CoD.ChopperGunnerHUD.BaseColorBlue.r, CoD.ChopperGunnerHUD.BaseColorBlue.g, CoD.ChopperGunnerHUD.BaseColorBlue.b)
		end
	end
end

CoD.ChopperGunnerHUD.OverheatPulseHigh = function (f8_arg0, f8_arg1)
	if f8_arg1.interrupted ~= true then
		f8_arg0:beginAnimation("pulse_low", CoD.ChopperGunnerHUD.PulseTime, true, false)
		f8_arg0:setAlpha(0.2)
	end
end

CoD.ChopperGunnerHUD.OverheatPulseLow = function (f9_arg0, f9_arg1)
	if f9_arg1.interrupted ~= true then
		f9_arg0:beginAnimation("pulse_high", CoD.ChopperGunnerHUD.PulseTime, false, true)
		f9_arg0:setAlpha(0.7)
	end
end

CoD.ChopperGunnerHUD.UpdateMissiles = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg1.data[1]
	if f10_local0 % 2 ~= 0 then
		f10_local0 = math.floor(f10_local0 / 2) + 1
		if f10_arg0.missileStencilRight[f10_local0] then
			f10_arg0.missileStencilRight[f10_local0]:beginAnimation("fired")
			f10_arg0.missileStencilRight[f10_local0]:setTopBottom(false, true, 0, 0)
			f10_arg0.missileStencilRight[f10_local0]:beginAnimation("reload", f10_arg1.data[2], true, true)
			f10_arg0.missileStencilRight[f10_local0]:setTopBottom(true, true, 0, 0)
		end
		if f10_arg0.missileContainerRight[f10_local0] then
			f10_arg0.missileContainerRight[f10_local0]:beginAnimation("fired")
			f10_arg0.missileContainerRight[f10_local0]:setAlpha(0.4)
			f10_arg0.missileContainerRight[f10_local0]:addElement(LUI.UITimer.new(f10_arg1.data[2], "reload_done", true))
		end
		if f10_arg0.missileStatusRightText and not f10_arg0.missileStatusRightText.reloading then
			f10_arg0.missileStatusRightText.reloading = true
			f10_arg0.missileStatusRightText:setText("WAIT")
			f10_arg0.missileStatusRightTextContainer:processEvent({
				name = "on"
			})
			f10_arg0.missileStatusRightTextContainer:addElement(LUI.UITimer.new(f10_arg1.data[2], "reload_done", true))
		end
		if f10_arg0.missileStencilLeft[f10_local0] then
			f10_arg0.missileStencilLeft[f10_local0]:beginAnimation("fired")
			f10_arg0.missileStencilLeft[f10_local0]:setTopBottom(false, true, 0, 0)
			f10_arg0.missileStencilLeft[f10_local0]:beginAnimation("reload", f10_arg1.data[2], true, true)
			f10_arg0.missileStencilLeft[f10_local0]:setTopBottom(true, true, 0, 0)
		end
		if f10_arg0.missileContainerLeft[f10_local0] then
			f10_arg0.missileContainerLeft[f10_local0]:beginAnimation("fired")
			f10_arg0.missileContainerLeft[f10_local0]:setAlpha(0.4)
			f10_arg0.missileContainerLeft[f10_local0]:addElement(LUI.UITimer.new(f10_arg1.data[2], "reload_done", true))
		end
		if f10_arg0.missileStatusLeftText and not f10_arg0.missileStatusLeftText.reloading then
			f10_arg0.missileStatusLeftText.reloading = true
			f10_arg0.missileStatusLeftText:setText("WAIT")
			f10_arg0.missileStatusLeftTextContainer:processEvent({
				name = "on"
			})
			f10_arg0.missileStatusLeftTextContainer:addElement(LUI.UITimer.new(f10_arg1.data[2], "reload_done", true))
		end
	end
end

CoD.ChopperGunnerHUD.ReloadDone = function (f11_arg0, f11_arg1)
	f11_arg0:setText("RDY")
	f11_arg0:beginAnimation("on")
	f11_arg0:setAlpha(1)
	f11_arg0.reloading = nil
end

CoD.ChopperGunnerHUD.MissileReloadDone = function (f12_arg0, f12_arg1)
	f12_arg0:beginAnimation("reload_done")
	f12_arg0:setAlpha(1)
end

CoD.ChopperGunnerHUD.BlinkOn = function (f13_arg0, f13_arg1)
	if f13_arg0.reloading ~= nil then
		f13_arg0:beginAnimation("on")
		f13_arg0:setAlpha(1)
		f13_arg0:addElement(LUI.UITimer.new(250, "off", true))
	end
end

CoD.ChopperGunnerHUD.BlinkOff = function (f14_arg0, f14_arg1)
	if f14_arg0.reloading ~= nil then
		f14_arg0:beginAnimation("off")
		f14_arg0:setAlpha(0)
		f14_arg0:addElement(LUI.UITimer.new(250, "on", true))
	end
end

CoD.ChopperGunnerHUD.UpdateVisibility = function (f15_arg0, f15_arg1)
	if UIExpression.IsVisibilityBitSet(f15_arg1.controller, CoD.BIT_UI_ACTIVE) == 0 then
		if f15_arg0.visible ~= true then
			f15_arg0:setAlpha(CoD.ChopperGunnerHUD.DefaultAlpha)
			f15_arg0.visible = true
		end
	elseif f15_arg0.visible == true then
		f15_arg0:setAlpha(0)
		f15_arg0.visible = nil
	end
	f15_arg0:dispatchEventToChildren(f15_arg1)
end

