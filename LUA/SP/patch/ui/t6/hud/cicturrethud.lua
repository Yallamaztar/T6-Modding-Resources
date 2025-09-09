require("T6.CoDBase")
CoD.CICTurretHud = {}
CoD.CICTurretHud.OuterWidth = 512
CoD.CICTurretHud.OuterHeight = 256
CoD.CICTurretHud.DefaultAlpha = 1
CoD.CICTurretHud.PulseTime = 500
CoD.CICTurretHud.SliderArrowHeight = 16
CoD.CICTurretHud.SliderArrowWidth = CoD.CICTurretHud.SliderArrowHeight * 2
CoD.CICTurretHud.OverheatIconWidth = 16
CoD.CICTurretHud.OverheatIconHeight = CoD.CICTurretHud.OverheatIconWidth * 8
CoD.CICTurretHud.TrangleWidth = 26
CoD.CICTurretHud.TrangleHeight = CoD.CICTurretHud.TrangleWidth
CoD.CICTurretHud.BlueColor = CoD.greenBlue
LUI.createMenu.CICTurretHud = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("CICTurretHud", f1_arg0)
	CoD.CICTurretHud.InnerMaterial = RegisterMaterial("mp_hud_sentry_inner")
	CoD.CICTurretHud.OuterMaterial = RegisterMaterial("mp_hud_sentry_outer")
	CoD.CICTurretHud.SliderArrow = RegisterMaterial("mech_flame_arrow_flipped")
	CoD.CICTurretHud.CannonKeyLineMaterial = RegisterMaterial("mech_flame_bar")
	CoD.CICTurretHud.TriangleMaterial = RegisterMaterial("hud_sp_triangle")
	local f1_local1 = LUI.UIImage.new()
	f1_local1:setLeftRight(false, false, -256, 256)
	f1_local1:setTopBottom(false, false, -256, 256)
	f1_local1:setImage(CoD.CICTurretHud.InnerMaterial)
	f1_local0:addElement(f1_local1)
	local f1_local2 = 80
	local f1_local3 = 20
	local f1_local4 = LUI.UIImage.new()
	f1_local4:setLeftRight(false, false, f1_local2, CoD.CICTurretHud.OuterWidth + f1_local2)
	f1_local4:setTopBottom(false, false, f1_local3, CoD.CICTurretHud.OuterHeight + f1_local3)
	f1_local4:setImage(CoD.CICTurretHud.OuterMaterial)
	f1_local0:addElement(f1_local4)
	local f1_local5 = LUI.UIImage.new()
	f1_local5:setLeftRight(false, false, -f1_local2, -CoD.CICTurretHud.OuterWidth - f1_local2)
	f1_local5:setTopBottom(false, false, f1_local3, CoD.CICTurretHud.OuterHeight + f1_local3)
	f1_local5:setImage(CoD.CICTurretHud.OuterMaterial)
	f1_local0:addElement(f1_local5)
	local f1_local6 = LUI.UIImage.new()
	f1_local6:setLeftRight(false, false, f1_local2, CoD.CICTurretHud.OuterWidth + f1_local2)
	f1_local6:setTopBottom(false, false, -f1_local3, -CoD.CICTurretHud.OuterHeight - f1_local3)
	f1_local6:setImage(CoD.CICTurretHud.OuterMaterial)
	f1_local0:addElement(f1_local6)
	local f1_local7 = LUI.UIImage.new()
	f1_local7:setLeftRight(false, false, -f1_local2, -CoD.CICTurretHud.OuterWidth - f1_local2)
	f1_local7:setTopBottom(false, false, -f1_local3, -CoD.CICTurretHud.OuterHeight - f1_local3)
	f1_local7:setImage(CoD.CICTurretHud.OuterMaterial)
	f1_local0:addElement(f1_local7)
	local f1_local8 = 0
	if Engine.GameModeIsMode(CoD.GAMEMODE_RTS) then
		f1_local8 = 40
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.CICTurretHud.OverheatIconWidth / 2, CoD.CICTurretHud.OverheatIconWidth / 2)
	Widget:setTopBottom(true, false, f1_local8, CoD.CICTurretHud.OverheatIconHeight + f1_local8)
	Widget:setZRot(-90)
	Widget.id = Widget.id .. ".CannonLeftContainer"
	f1_local0:addElement(Widget)
	local f1_local10 = LUI.UIImage.new()
	f1_local10:setLeftRight(true, true, 0, 0)
	f1_local10:setTopBottom(true, true, 0, 0)
	f1_local10:setImage(CoD.CICTurretHud.CannonKeyLineMaterial)
	f1_local10.id = f1_local10.id .. ".CannonLeftLine"
	Widget:addElement(f1_local10)
	
	local cannonLeftFill = LUI.UIImage.new()
	cannonLeftFill:setLeftRight(true, true, 6, -6)
	cannonLeftFill:setTopBottom(false, true, 0, 0)
	cannonLeftFill:setRGB(CoD.CICTurretHud.BlueColor.r, CoD.CICTurretHud.BlueColor.g, CoD.CICTurretHud.BlueColor.b)
	cannonLeftFill.id = cannonLeftFill.id .. ".CannonLeftFill"
	Widget:addElement(cannonLeftFill)
	f1_local0.cannonLeftFill = cannonLeftFill
	
	local cannonLeftArrow = LUI.UIImage.new()
	cannonLeftArrow:setLeftRight(false, true, 0, CoD.CICTurretHud.SliderArrowWidth)
	cannonLeftArrow:setTopBottom(false, true, -CoD.CICTurretHud.SliderArrowHeight / 2, CoD.CICTurretHud.SliderArrowHeight / 2)
	cannonLeftArrow:setImage(CoD.CICTurretHud.SliderArrow)
	cannonLeftArrow.id = cannonLeftArrow.id .. ".CannonLeftArrow"
	Widget:addElement(cannonLeftArrow)
	f1_local0.cannonLeftArrow = cannonLeftArrow
	
	local f1_local13 = CoD.CICTurretHud.OverheatIconHeight / 2 + 2
	local f1_local14 = CoD.CICTurretHud.OverheatIconHeight / 2
	if Engine.GameModeIsMode(CoD.GAMEMODE_RTS) then
		f1_local13 = f1_local13 + 40
	end
	local cannonOverheatL = LUI.UIImage.new()
	cannonOverheatL:setLeftRight(false, false, -CoD.CICTurretHud.TrangleWidth - f1_local14 - 20, -f1_local14 - 20)
	cannonOverheatL:setTopBottom(true, false, -CoD.CICTurretHud.TrangleHeight / 2 + f1_local13, CoD.CICTurretHud.TrangleHeight / 2 + f1_local13)
	cannonOverheatL:setImage(CoD.CICTurretHud.TriangleMaterial)
	cannonOverheatL:setAlpha(0)
	cannonOverheatL.id = cannonOverheatL.id .. ".CannonOverheatL"
	cannonOverheatL:registerEventHandler("transition_complete_pulse_low", CoD.CICTurretHud.OverheatPulseLow)
	cannonOverheatL:registerEventHandler("transition_complete_pulse_high", CoD.CICTurretHud.OverheatPulseHigh)
	f1_local0:addElement(cannonOverheatL)
	f1_local0.cannonOverheatL = cannonOverheatL
	
	local cannonOverheatR = LUI.UIImage.new()
	cannonOverheatR:setLeftRight(false, false, f1_local14 + 20, CoD.CICTurretHud.TrangleWidth + f1_local14 + 20)
	cannonOverheatR:setTopBottom(true, false, -CoD.CICTurretHud.TrangleHeight / 2 + f1_local13, CoD.CICTurretHud.TrangleHeight / 2 + f1_local13)
	cannonOverheatR:setImage(CoD.CICTurretHud.TriangleMaterial)
	cannonOverheatR:setAlpha(0)
	cannonOverheatR.id = cannonOverheatR.id .. ".CannonOverheatR"
	cannonOverheatR:registerEventHandler("transition_complete_pulse_low", CoD.CICTurretHud.OverheatPulseLow)
	cannonOverheatR:registerEventHandler("transition_complete_pulse_high", CoD.CICTurretHud.OverheatPulseHigh)
	f1_local0:addElement(cannonOverheatR)
	f1_local0.cannonOverheatR = cannonOverheatR
	
	f1_local0:registerEventHandler("hud_update_refresh", CoD.CICTurretHud.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.CICTurretHud.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.CICTurretHud.UpdateVisibility)
	f1_local0:registerEventHandler("hud_cic_weapon_heat", CoD.CICTurretHud.UpdateWeaponHeat)
	return f1_local0
end

CoD.CICTurretHud.UpdateWeaponHeat = function (f2_arg0, f2_arg1)
	if f2_arg1.data then
		local f2_local0 = f2_arg1.data[1] / 100
		local f2_local1 = f2_arg1.data[2]
		local f2_local2 = CoD.CICTurretHud.OverheatIconHeight - 1
		local f2_local3 = CoD.CICTurretHud.SliderArrowHeight
		local f2_local4 = 0.75
		if f2_arg0.cannonLeftFill then
			f2_arg0.cannonLeftFill:beginAnimation("fill", 50, false, false)
			f2_arg0.cannonLeftFill:setTopBottom(false, true, -f2_local2 * f2_local0, -1)
		end
		if f2_arg0.cannonLeftArrow then
			f2_arg0.cannonLeftArrow:beginAnimation("fill", 50, false, false)
			f2_arg0.cannonLeftArrow:setTopBottom(false, true, -f2_local2 * f2_local0 - f2_local3 / 2, -f2_local2 * f2_local0 + f2_local3 / 2)
		end
		if f2_arg0.cannonOverheatR and f2_arg0.cannonOverheatL and f2_arg0.cannonLeftFill then
			if f2_local1 == 1 and not f2_arg0.cannonOverheatR.overheat then
				f2_arg0.cannonOverheatR.overheat = true
				f2_arg0.cannonOverheatR:beginAnimation("pulse_low")
				f2_arg0.cannonOverheatR:setAlpha(0.2)
				f2_arg0.cannonOverheatL:beginAnimation("pulse_low")
				f2_arg0.cannonOverheatL:setAlpha(0.2)
				f2_arg0.cannonLeftFill:beginAnimation("red_alert")
				f2_arg0.cannonLeftFill:setRGB(1, 0, 0)
			elseif f2_local1 == 0 and f2_arg0.cannonOverheatR.overheat == true then
				f2_arg0.cannonOverheatR.overheat = nil
				f2_arg0.cannonOverheatR:beginAnimation("hide")
				f2_arg0.cannonOverheatR:setAlpha(0)
				f2_arg0.cannonOverheatL:beginAnimation("hide")
				f2_arg0.cannonOverheatL:setAlpha(0)
				f2_arg0.cannonLeftFill:beginAnimation("default")
				f2_arg0.cannonLeftFill:setTopBottom(false, true, 0, 0)
				f2_arg0.cannonLeftFill:setRGB(CoD.CICTurretHud.BlueColor.r, CoD.CICTurretHud.BlueColor.g, CoD.CICTurretHud.BlueColor.b)
			end
		end
	end
end

CoD.CICTurretHud.OverheatPulseHigh = function (f3_arg0, f3_arg1)
	if f3_arg1.interrupted ~= true then
		f3_arg0:beginAnimation("pulse_low", CoD.CICTurretHud.PulseTime, true, false)
		f3_arg0:setAlpha(0.2)
	end
end

CoD.CICTurretHud.OverheatPulseLow = function (f4_arg0, f4_arg1)
	if f4_arg1.interrupted ~= true then
		f4_arg0:beginAnimation("pulse_high", CoD.CICTurretHud.PulseTime, false, true)
		f4_arg0:setAlpha(0.7)
	end
end

CoD.CICTurretHud.UpdateVisibility = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1.controller
	if UIExpression.IsVisibilityBitSet(f5_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f5_local0, CoD.BIT_UI_ACTIVE) == 0 then
		if f5_arg0.visible ~= true then
			f5_arg0:setAlpha(CoD.CICTurretHud.DefaultAlpha)
			f5_arg0.visible = true
		end
	elseif f5_arg0.visible == true then
		f5_arg0:setAlpha(0)
		f5_arg0.visible = nil
	end
	f5_arg0:dispatchEventToChildren(f5_arg1)
end

