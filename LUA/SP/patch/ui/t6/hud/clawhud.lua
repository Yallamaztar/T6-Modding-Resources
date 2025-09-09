CoD.ClawHud = {}
CoD.ClawHud.ContainerWidth = 512
CoD.ClawHud.BracketArrowHeight = 32
CoD.ClawHud.BracketArrowWidth = 128
CoD.ClawHud.BracketHeight = 512
CoD.ClawHud.BracketWidth = 64
CoD.ClawHud.SliderArrowHeight = 16
CoD.ClawHud.SliderArrowWidth = CoD.ClawHud.SliderArrowHeight * 2
CoD.ClawHud.OverheatIconWidth = 16
CoD.ClawHud.OverheatIconHeight = CoD.ClawHud.OverheatIconWidth * 8
CoD.ClawHud.FontName = "Default"
CoD.ClawHud.GLAmmoIconWidth = 45
CoD.ClawHud.GLAmmoIconHeight = CoD.ClawHud.GLAmmoIconWidth / 2
CoD.ClawHud.GLAmmoCount = 5
CoD.ClawHud.TrangleWidth = 26
CoD.ClawHud.TrangleHeight = CoD.ClawHud.TrangleWidth
CoD.ClawHud.PulseTime = 500
CoD.ClawHud.GLContainerHeight = 100
CoD.ClawHud.GLContainerWidth = 20
CoD.ClawHud.DefaultAlpha = 1
CoD.ClawHud.BlueColor = {}
CoD.ClawHud.BlueColor.r = 0.23
CoD.ClawHud.BlueColor.g = 0.55
CoD.ClawHud.BlueColor.b = 0.44
CoD.ClawHud.new = function ()
	CoD.ClawHud.BracketArrowMaterial = RegisterMaterial("hud_rts_mech_arrow")
	CoD.ClawHud.BracketMaterial = RegisterMaterial("hud_rts_mech_bracket")
	CoD.ClawHud.SliderArrow = RegisterMaterial("mech_flame_arrow")
	CoD.ClawHud.GLAmmoIconMaterial = RegisterMaterial("mech_check_line")
	CoD.ClawHud.GLAmmoIconFillMaterial = RegisterMaterial("mech_check_fill")
	CoD.ClawHud.CannonKeyLineMaterial = RegisterMaterial("mech_flame_bar")
	CoD.ClawHud.TriangleMaterial = RegisterMaterial("hud_sp_triangle")
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget.id = Widget.id .. ".ClawHud"
	Widget:addElement(CoD.ClawHud.CreateBrackets(Widget))
	Widget.addFlamethrower = CoD.ClawHud.AddFlamethrower
	Widget.addGrenadeLauncher = CoD.ClawHud.AddGrenadeLauncher
	Widget.removeGrenadeLauncher = CoD.ClawHud.RemoveGrenadeLauncher
	Widget.addMainTurret = CoD.ClawHud.AddMainTurret
	Widget:registerEventHandler("hud_weapon_heat", CoD.ClawHud.UpdateWeaponHeat)
	Widget:registerEventHandler("plr_veh_gren_fire", CoD.ClawHud.PlayerVehicleGunnerFire)
	Widget:registerEventHandler("reload_grenade_launcher", CoD.ClawHud.ReloadGrenadeLauncher)
	Widget:registerEventHandler("hud_claw_grenade_fire", CoD.ClawHud.ClawGrenadeFire)
	Widget:registerEventHandler("hud_update_refresh", CoD.ClawHud.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.ClawHud.UpdateVisibility)
	return Widget
end

CoD.ClawHud.CreateBrackets = function (f2_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.ClawHud.ContainerWidth / 2 - CoD.ClawHud.BracketWidth, CoD.ClawHud.ContainerWidth / 2 + CoD.ClawHud.BracketWidth)
	Widget:setTopBottom(false, false, -CoD.ClawHud.BracketHeight / 2, CoD.ClawHud.BracketHeight / 2)
	Widget.id = Widget.id .. ".BracketContainer"
	f2_arg0.bracketContainer = Widget
	local f2_local1 = LUI.UIImage.new()
	f2_local1:setLeftRight(true, false, 0, CoD.ClawHud.BracketWidth)
	f2_local1:setTopBottom(true, true, 0, 0)
	f2_local1:setImage(CoD.ClawHud.BracketMaterial)
	f2_local1.id = f2_local1.id .. ".LeftBracket"
	Widget:addElement(f2_local1)
	local f2_local2 = LUI.UIImage.new()
	f2_local2:setLeftRight(false, true, -CoD.ClawHud.BracketWidth, 0)
	f2_local2:setTopBottom(true, true, 0, 0)
	f2_local2:setImage(CoD.ClawHud.BracketMaterial)
	f2_local2:setYRot(180)
	f2_local2.id = f2_local2.id .. ".BracketRight"
	Widget:addElement(f2_local2)
	local f2_local3 = 17
	local f2_local4 = LUI.UIImage.new()
	f2_local4:setLeftRight(true, false, f2_local3, CoD.ClawHud.BracketArrowWidth + f2_local3)
	f2_local4:setTopBottom(false, false, -CoD.ClawHud.BracketArrowHeight / 2, CoD.ClawHud.BracketArrowHeight / 2)
	f2_local4:setImage(CoD.ClawHud.BracketArrowMaterial)
	f2_local4.id = f2_local4.id .. ".LeftArrow"
	Widget:addElement(f2_local4)
	local f2_local5 = LUI.UIImage.new()
	f2_local5:setLeftRight(false, true, -CoD.ClawHud.BracketArrowWidth - f2_local3, -f2_local3)
	f2_local5:setTopBottom(false, false, -CoD.ClawHud.BracketArrowHeight / 2, CoD.ClawHud.BracketArrowHeight / 2)
	f2_local5:setImage(CoD.ClawHud.BracketArrowMaterial)
	f2_local5:setZRot(180)
	f2_local5.id = f2_local5.id .. ".RightArrow"
	Widget:addElement(f2_local5)
	CoD.ClawHud.AddGrenadeLauncher(f2_arg0)
	return Widget
end

CoD.ClawHud.AddMainTurret = function (f3_arg0)
	local f3_local0 = 35
	local f3_local1 = LUI.UIImage.new()
	f3_local1:setLeftRight(false, false, -CoD.ClawHud.BracketArrowWidth / 2, CoD.ClawHud.BracketArrowWidth / 2)
	f3_local1:setTopBottom(true, false, f3_local0, CoD.ClawHud.BracketArrowHeight + f3_local0)
	f3_local1:setImage(CoD.ClawHud.BracketArrowMaterial)
	f3_local1:setZRot(-90)
	f3_local1.id = f3_local1.id .. ".TopArrow"
	f3_arg0.bracketContainer:addElement(f3_local1)
	local f3_local2 = 40
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.ClawHud.BracketArrowWidth / 2, CoD.ClawHud.BracketArrowWidth / 2)
	Widget:setTopBottom(true, false, -f3_local2, CoD.textSize[CoD.ClawHud.FontName] - f3_local2)
	Widget:setAlpha(0)
	Widget.id = Widget.id .. "TopArrowTextContainer"
	Widget:registerEventHandler("transition_complete_pulse_low", CoD.ClawHud.OverheatPulseLow)
	Widget:registerEventHandler("transition_complete_pulse_high", CoD.ClawHud.OverheatPulseHigh)
	f3_arg0.bracketContainer:addElement(Widget)
	f3_arg0.topArrowTextContainer = Widget
	
	local topArrowText = LUI.UIText.new()
	topArrowText:setLeftRight(true, true, 0, 0)
	topArrowText:setTopBottom(true, true, 0, 0)
	topArrowText:setFont(CoD.fonts[CoD.ClawHud.FontName])
	topArrowText:setRGB(CoD.ClawHud.BlueColor.r, CoD.ClawHud.BlueColor.g, CoD.ClawHud.BlueColor.b)
	topArrowText.id = topArrowText.id .. ".TopArrowText"
	Widget:addElement(topArrowText)
	f3_arg0.topArrowText = topArrowText
	
	local f3_local5 = "40MM CANNON"
	topArrowText:setText(f3_local5)
	local f3_local6, f3_local7, f3_local8, f3_local9 = GetTextDimensions(f3_local5, CoD.fonts[CoD.ClawHud.FontName], CoD.textSize[CoD.ClawHud.FontName])
	local f3_local10 = 16
	local f3_local11 = f3_local8 - f3_local6 + CoD.ClawHud.TrangleWidth + 20
	local f3_local12 = LUI.UIImage.new()
	f3_local12:setLeftRight(false, false, -CoD.ClawHud.TrangleWidth / 2 - f3_local11 / 2, CoD.ClawHud.TrangleWidth / 2 - f3_local11 / 2)
	f3_local12:setTopBottom(true, false, -CoD.ClawHud.TrangleHeight - f3_local10, -f3_local10)
	f3_local12:setImage(CoD.ClawHud.TriangleMaterial)
	f3_local12:setAlpha(0)
	f3_local12.id = f3_local12.id .. ".MainWeaponOverheatImageL"
	f3_local12:registerEventHandler("transition_complete_pulse_low", CoD.ClawHud.OverheatPulseLow)
	f3_local12:registerEventHandler("transition_complete_pulse_high", CoD.ClawHud.OverheatPulseHigh)
	f3_arg0.bracketContainer:addElement(f3_local12)
	f3_arg0.mainWeaponOverheatL = f3_local12
	local f3_local13 = LUI.UIImage.new()
	f3_local13:setLeftRight(false, false, -CoD.ClawHud.TrangleWidth / 2 + f3_local11 / 2, CoD.ClawHud.TrangleWidth / 2 + f3_local11 / 2)
	f3_local13:setTopBottom(true, false, -CoD.ClawHud.TrangleHeight - f3_local10, -f3_local10)
	f3_local13:setImage(CoD.ClawHud.TriangleMaterial)
	f3_local13:setAlpha(0)
	f3_local13.id = f3_local13.id .. ".MainWeaponOverheatImageR"
	f3_local13:registerEventHandler("transition_complete_pulse_low", CoD.ClawHud.OverheatPulseLow)
	f3_local13:registerEventHandler("transition_complete_pulse_high", CoD.ClawHud.OverheatPulseHigh)
	f3_arg0.bracketContainer:addElement(f3_local13)
	f3_arg0.mainWeaponOverheatR = f3_local13
end

CoD.ClawHud.AddFlamethrower = function (f4_arg0)
	local f4_local0 = 17
	local f4_local1 = 10
	local f4_local2 = LUI.UIText.new()
	f4_local2:setLeftRight(true, false, -f4_local1, f4_local0 - f4_local1)
	f4_local2:setTopBottom(true, false, CoD.ClawHud.BracketHeight / 2 - CoD.textSize[CoD.ClawHud.FontName] / 2, CoD.ClawHud.BracketHeight / 2 + CoD.textSize[CoD.ClawHud.FontName] / 2)
	f4_local2:setFont(CoD.fonts[CoD.ClawHud.FontName])
	f4_local2:setAlignment(LUI.Alignment.Right)
	f4_local2:setRGB(CoD.ClawHud.BlueColor.r, CoD.ClawHud.BlueColor.g, CoD.ClawHud.BlueColor.b)
	f4_local2.id = f4_local2.id .. ".LeftArrowText"
	f4_arg0.bracketContainer:addElement(f4_local2)
	f4_local2:setText("FT")
	local f4_local3 = 35
	local f4_local4 = 10
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, -CoD.ClawHud.OverheatIconWidth + f4_local4, f4_local4)
	Widget:setTopBottom(false, true, -CoD.ClawHud.OverheatIconHeight - f4_local3, -f4_local3)
	Widget.id = Widget.id .. ".CannonLeftContainer"
	f4_arg0.bracketContainer:addElement(Widget)
	local f4_local6 = LUI.UIImage.new()
	f4_local6:setLeftRight(false, false, -CoD.ClawHud.OverheatIconWidth / 2, CoD.ClawHud.OverheatIconWidth / 2)
	f4_local6:setTopBottom(false, true, -CoD.ClawHud.OverheatIconHeight, 0)
	f4_local6:setImage(CoD.ClawHud.CannonKeyLineMaterial)
	f4_local6.id = f4_local6.id .. ".CannonLeftLine"
	Widget:addElement(f4_local6)
	
	local cannonLeftFill = LUI.UIImage.new()
	cannonLeftFill:setLeftRight(true, true, 6, -6)
	cannonLeftFill:setTopBottom(false, true, 0, 0)
	cannonLeftFill:setRGB(CoD.ClawHud.BlueColor.r, CoD.ClawHud.BlueColor.g, CoD.ClawHud.BlueColor.b)
	cannonLeftFill:setAlpha(0.75)
	cannonLeftFill.id = cannonLeftFill.id .. ".CannonLeftFill"
	Widget:addElement(cannonLeftFill)
	f4_arg0.cannonLeftFill = cannonLeftFill
	
	local cannonLeftArrowL = LUI.UIImage.new()
	cannonLeftArrowL:setLeftRight(true, false, -CoD.ClawHud.SliderArrowWidth, 0)
	cannonLeftArrowL:setTopBottom(false, true, -CoD.ClawHud.SliderArrowHeight / 2, CoD.ClawHud.SliderArrowHeight / 2)
	cannonLeftArrowL:setImage(CoD.ClawHud.SliderArrow)
	cannonLeftArrowL.id = cannonLeftArrowL.id .. ".CannonLeftArrowL"
	Widget:addElement(cannonLeftArrowL)
	f4_arg0.cannonLeftArrowL = cannonLeftArrowL
	
	local f4_local9 = CoD.ClawHud.OverheatIconHeight + 40
	local f4_local10 = CoD.ClawHud.TrangleWidth - 16
	local f4_local11 = LUI.UIImage.new()
	f4_local11:setLeftRight(true, false, -f4_local10, CoD.ClawHud.TrangleWidth - f4_local10)
	f4_local11:setTopBottom(false, true, -CoD.ClawHud.TrangleHeight - f4_local9, -f4_local9)
	f4_local11:setImage(CoD.ClawHud.TriangleMaterial)
	f4_local11:setAlpha(0)
	f4_local11.id = f4_local11.id .. ".CannonLeftOverheat"
	f4_local11:registerEventHandler("transition_complete_pulse_low", CoD.ClawHud.OverheatPulseLow)
	f4_local11:registerEventHandler("transition_complete_pulse_high", CoD.ClawHud.OverheatPulseHigh)
	f4_arg0.bracketContainer:addElement(f4_local11)
	f4_arg0.cannonLeftOverheat = f4_local11
end

CoD.ClawHud.AddGrenadeLauncher = function (f5_arg0, f5_arg1)
	local f5_local0 = 17
	local f5_local1 = 10
	local f5_local2 = LUI.UIText.new()
	f5_local2:setLeftRight(false, true, -f5_local0 + f5_local1, f5_local1)
	f5_local2:setTopBottom(true, false, CoD.ClawHud.BracketHeight / 2 - CoD.textSize[CoD.ClawHud.FontName] / 2, CoD.ClawHud.BracketHeight / 2 + CoD.textSize[CoD.ClawHud.FontName] / 2)
	f5_local2:setFont(CoD.fonts[CoD.ClawHud.FontName])
	f5_local2:setRGB(CoD.ClawHud.BlueColor.r, CoD.ClawHud.BlueColor.g, CoD.ClawHud.BlueColor.b)
	f5_local2.id = f5_local2.id .. ".RightArrowText"
	f5_arg0.bracketContainer:addElement(f5_local2)
	f5_local2:setText("GL")
	local f5_local3 = 10
	local f5_local4 = 42
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -CoD.ClawHud.GLContainerWidth + f5_local3, f5_local3)
	Widget:setTopBottom(false, true, -CoD.ClawHud.GLContainerHeight - f5_local4, -f5_local4)
	Widget.id = Widget.id .. ".GrenadeLauncherContainer"
	f5_arg0.bracketContainer:addElement(Widget)
	f5_arg0.gLAmmoIcons = {}
	local f5_local6 = 12
	for f5_local7 = 1, CoD.ClawHud.GLAmmoCount, 1 do
		local f5_local10 = f5_local6 * f5_local7 - 1
		local f5_local11 = LUI.UIImage.new()
		f5_local11:setLeftRight(false, false, -CoD.ClawHud.GLAmmoIconWidth / 2, CoD.ClawHud.GLAmmoIconWidth / 2)
		f5_local11:setTopBottom(false, true, CoD.ClawHud.GLAmmoIconHeight - f5_local10, -f5_local10)
		f5_local11:setImage(CoD.ClawHud.GLAmmoIconMaterial)
		f5_local11:setAlpha(0.2)
		f5_local11.id = f5_local11.id .. ".AmmoIconEmpty" .. f5_local7
		Widget:addElement(f5_local11)
		local f5_local12 = LUI.UIImage.new()
		f5_local12:setLeftRight(false, false, -CoD.ClawHud.GLAmmoIconWidth / 2, CoD.ClawHud.GLAmmoIconWidth / 2)
		f5_local12:setTopBottom(false, true, CoD.ClawHud.GLAmmoIconHeight - f5_local10, -f5_local10)
		f5_local12:setImage(CoD.ClawHud.GLAmmoIconFillMaterial)
		f5_local12:setAlpha(0)
		f5_local12.id = f5_local12.id .. ".AmmoIcon_" .. f5_local7
		f5_local12:registerEventHandler("hide_gl_ammo", CoD.ClawHud.HideGLAmmo)
		Widget:addElement(f5_local12)
		table.insert(f5_arg0.gLAmmoIcons, f5_local12)
	end
end

CoD.ClawHud.UpdateWeaponHeat = function (f6_arg0, f6_arg1)
	if f6_arg1.data ~= nil then
		local f6_local0 = f6_arg1.data[1] / 100
		local f6_local1 = f6_arg1.data[2] / 100
		local f6_local2 = f6_arg1.data[3]
		local f6_local3 = f6_arg1.data[4]
		local f6_local4 = CoD.ClawHud.OverheatIconHeight - 2
		local f6_local5 = CoD.ClawHud.SliderArrowHeight
		local f6_local6 = 0.75
		if f6_arg0.mainWeaponOverheatL ~= nil and f6_arg0.mainWeaponOverheatR ~= nil and f6_arg0.topArrowText ~= nil then
			if f6_local6 < f6_local0 and f6_arg0.mainWeaponOverheatL.overheat ~= true then
				f6_arg0.mainWeaponOverheatL.overheat = true
				f6_arg0.mainWeaponOverheatL:beginAnimation("pulse_low")
				f6_arg0.mainWeaponOverheatL:setAlpha(0.2)
				f6_arg0.mainWeaponOverheatR:beginAnimation("pulse_low")
				f6_arg0.mainWeaponOverheatR:setAlpha(0.2)
				f6_arg0.topArrowTextContainer:beginAnimation("pulse_low")
				f6_arg0.topArrowTextContainer:setAlpha(0.2)
				f6_arg0.topArrowText:beginAnimation("red_alert")
				f6_arg0.topArrowText:setRGB(1, 0, 0)
			elseif f6_local0 <= f6_local6 and f6_local2 == 0 and f6_arg0.mainWeaponOverheatL.overheat == true then
				f6_arg0.mainWeaponOverheatL.overheat = nil
				f6_arg0.mainWeaponOverheatL:beginAnimation("hide")
				f6_arg0.mainWeaponOverheatL:setAlpha(0)
				f6_arg0.mainWeaponOverheatR:beginAnimation("hide")
				f6_arg0.mainWeaponOverheatR:setAlpha(0)
				f6_arg0.topArrowTextContainer:beginAnimation("default")
				f6_arg0.topArrowTextContainer:setAlpha(1)
				f6_arg0.topArrowText:beginAnimation("default", 250)
				f6_arg0.topArrowText:setRGB(CoD.ClawHud.BlueColor.r, CoD.ClawHud.BlueColor.g, CoD.ClawHud.BlueColor.b)
			end
		end
		if f6_arg0.cannonLeftFill ~= nil then
			f6_arg0.cannonLeftFill:beginAnimation("fill", 50, false, false)
			f6_arg0.cannonLeftFill:setTopBottom(false, true, -f6_local4 * f6_local1, -2)
		end
		if f6_arg0.cannonLeftArrowL ~= nil then
			f6_arg0.cannonLeftArrowL:beginAnimation("fill", 50, false, false)
			f6_arg0.cannonLeftArrowL:setTopBottom(false, true, -f6_local4 * f6_local1 - f6_local5 / 2, -f6_local4 * f6_local1 + f6_local5 / 2)
		end
		if f6_arg0.cannonLeftOverheat ~= nil and f6_arg0.cannonLeftFill ~= nil then
			if f6_local3 == 1 and f6_arg0.cannonLeftOverheat.overheat ~= true then
				f6_arg0.cannonLeftOverheat.overheat = true
				f6_arg0.cannonLeftOverheat:beginAnimation("pulse_low")
				f6_arg0.cannonLeftOverheat:setAlpha(0.2)
				f6_arg0.cannonLeftFill:beginAnimation("red_alert")
				f6_arg0.cannonLeftFill:setRGB(1, 0, 0)
			elseif f6_local3 == 0 and f6_arg0.cannonLeftOverheat.overheat == true then
				f6_arg0.cannonLeftOverheat.overheat = nil
				f6_arg0.cannonLeftOverheat:beginAnimation("hide")
				f6_arg0.cannonLeftOverheat:setAlpha(0)
				f6_arg0.cannonLeftFill:beginAnimation("default")
				f6_arg0.cannonLeftFill:setTopBottom(false, true, 0, 0)
				f6_arg0.cannonLeftFill:setRGB(CoD.ClawHud.BlueColor.r, CoD.ClawHud.BlueColor.g, CoD.ClawHud.BlueColor.b)
			end
		end
	end
end

CoD.ClawHud.OverheatPulseHigh = function (f7_arg0, f7_arg1)
	if f7_arg1.interrupted ~= true then
		f7_arg0:beginAnimation("pulse_low", CoD.ClawHud.PulseTime, true, false)
		f7_arg0:setAlpha(0.2)
	end
end

CoD.ClawHud.OverheatPulseLow = function (f8_arg0, f8_arg1)
	if f8_arg1.interrupted ~= true then
		f8_arg0:beginAnimation("pulse_high", CoD.ClawHud.PulseTime, false, true)
		f8_arg0:setAlpha(0.7)
	end
end

CoD.ClawHud.HideGLAmmo = function (f9_arg0, f9_arg1)
	f9_arg0:beginAnimation("hide")
	f9_arg0:setAlpha(0)
end

CoD.ClawHud.ReloadGrenadeLauncher = function (f10_arg0, f10_arg1)
	if f10_arg0.gLAmmoIcons ~= nil then
		local f10_local0 = f10_arg1.reload_time / CoD.ClawHud.GLAmmoCount
		for f10_local1 = 1, CoD.ClawHud.GLAmmoCount, 1 do
			f10_arg0.gLAmmoIcons[f10_local1]:beginAnimation("default")
			f10_arg0.gLAmmoIcons[f10_local1]:setAlpha(1)
			f10_arg0.gLAmmoIcons[f10_local1]:addElement(LUI.UITimer.new(f10_local0 * (CoD.ClawHud.GLAmmoCount - f10_local1), "hide_gl_ammo", true, f10_arg0.gLAmmoIcons[f10_local1]))
		end
	end
end

CoD.ClawHud.ClawGrenadeFire = function (f11_arg0, f11_arg1)
	if f11_arg1.data ~= nil then
		f11_arg0:processEvent({
			name = "reload_grenade_launcher",
			reload_time = f11_arg1.data[1]
		})
	end
end

CoD.ClawHud.PlayerVehicleGunnerFire = function (f12_arg0, f12_arg1)
	f12_arg0:processEvent({
		name = "reload_grenade_launcher",
		reload_time = f12_arg1.reload_time
	})
end

CoD.ClawHud.UpdateVisibility = function (f13_arg0, f13_arg1)
	if UIExpression.IsVisibilityBitSet(f13_arg1.controller, CoD.BIT_UI_ACTIVE) == 0 then
		if f13_arg0.visible ~= true then
			f13_arg0:setAlpha(CoD.ClawHud.DefaultAlpha)
			f13_arg0.visible = true
		end
	elseif f13_arg0.visible == true then
		f13_arg0:setAlpha(0)
		f13_arg0.visible = nil
	end
	f13_arg0:dispatchEventToChildren(f13_arg1)
end

