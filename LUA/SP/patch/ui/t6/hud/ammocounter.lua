require("T6.HUD.DPadSelection")
require("T6.HUD.DPadArea")
CoD.AmmoCounter = {}
CoD.AmmoCounter.BootupAppearDuration = 500
CoD.AmmoCounter.BootupExpandDuration = 500
CoD.AmmoCounter.BootupTestDuration = 500
CoD.AmmoCounter.BootupShrinkDuration = 500
CoD.AmmoCounter.BracketWidth = 64
CoD.AmmoCounter.BracketHeight = 64
CoD.AmmoCounter.BracketMaterialName = "menu_vis_bracket_skew"
CoD.AmmoCounter.BracketLeftMaterialName = "menu_vis_bracket_skew_left"
CoD.AmmoCounter.AmmoHexMaterial = "menu_vis_ammo_hex"
CoD.AmmoCounter.FullWidth = 158
CoD.AmmoCounter.Width = 180
CoD.AmmoCounter.FontName = "Big"
CoD.AmmoCounter.LowAmmoFadeTime = 500
CoD.AmmoCounter.PulseDuration = 500
CoD.AmmoCounter.DefaultAlpha = 1
CoD.AmmoCounter.BracketAlpha = 1
CoD.AmmoCounter.BracketColorValue = 0.3
CoD.AmmoCounter.BracketFrontendColorValue = 0.1
CoD.AmmoCounter.BracketOffset = 21
CoD.AmmoCounter.TextAlpha = 0.75
CoD.AmmoCounter.NumbersBottom = -15
CoD.AmmoCounter.NumbersRight = -10
CoD.AmmoCounter.DefaultStyle = "twenties"
CoD.AmmoCounter.EightiesAlpha = 1
CoD.AmmoCounter.EightiesBacking_Large = "hud_sp_rectangle_large_80s"
CoD.AmmoCounter.EightiesBacking_Medium = "hud_sp_rectangle_mid_80s"
CoD.AmmoCounter.EightiesBacking_Small = "hud_sp_rectangle_small_80s"
CoD.AmmoCounter.EightiesBacking_Bracket = "hud_sp_white_bracket_80s"
CoD.AmmoCounter.new = function (f1_arg0)
	local f1_local0 = -CoD.OffhandIcons.Size
	local f1_local1 = -63
	local Widget = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = true,
		left = f1_local1 - CoD.AmmoCounter.BracketWidth,
		right = f1_local1,
		topAnchor = false,
		bottomAnchor = true,
		top = f1_local0 - CoD.AmmoCounter.BracketHeight,
		bottom = f1_local0
	})
	Widget:registerAnimationState("expand", {
		leftAnchor = false,
		rightAnchor = true,
		left = f1_local1 - CoD.AmmoCounter.FullWidth,
		right = f1_local1
	})
	Widget.id = Widget.id .. ".AmmoCounter"
	Widget.hexBg = LUI.UIImage.new()
	Widget.hexBg:setLeftRight(true, true, 0, 0)
	Widget.hexBg:setTopBottom(true, true, 0, 0)
	Widget.hexBg:setImage(RegisterMaterial(CoD.AmmoCounter.AmmoHexMaterial))
	Widget.hexBg:setRGB(0, 0, 0)
	Widget.hexBg.id = Widget.hexBg.id .. ".HexBg"
	Widget:addElement(Widget.hexBg)
	Widget.background = LUI.UIImage.new()
	Widget.background:setLeftRight(true, true, 0, 0)
	Widget.background:setTopBottom(true, true, 0, 0)
	Widget.background:setAlpha(0)
	Widget:addElement(Widget.background)
	Widget.bracketContainer = LUI.UIElement.new()
	Widget.bracketContainer:setLeftRight(true, true, 0, 0)
	Widget.bracketContainer:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget.bracketContainer)
	Widget.leftBracket = LUI.UIImage.new()
	Widget.leftBracket:setLeftRight(true, false, -CoD.AmmoCounter.BracketOffset, -CoD.AmmoCounter.BracketOffset + CoD.AmmoCounter.BracketWidth)
	Widget.leftBracket:setTopBottom(false, false, -CoD.AmmoCounter.BracketHeight / 2, CoD.AmmoCounter.BracketHeight / 2)
	Widget.leftBracket:setImage(RegisterMaterial(CoD.AmmoCounter.BracketLeftMaterialName))
	Widget.leftBracket:setRGB(CoD.AmmoCounter.BracketColorValue, CoD.AmmoCounter.BracketColorValue, CoD.AmmoCounter.BracketColorValue)
	Widget.leftBracket:setAlpha(CoD.AmmoCounter.BracketAlpha)
	Widget.leftBracket:registerAnimationState("fade_out", {
		alpha = 0
	})
	Widget.leftBracket.id = Widget.leftBracket.id .. ".LeftBracket"
	Widget.bracketContainer:addElement(Widget.leftBracket)
	Widget.rightBracket = LUI.UIImage.new()
	Widget.rightBracket:setLeftRight(false, true, CoD.AmmoCounter.BracketOffset - CoD.AmmoCounter.BracketWidth, CoD.AmmoCounter.BracketOffset)
	Widget.rightBracket:setTopBottom(false, false, -CoD.AmmoCounter.BracketHeight / 2, CoD.AmmoCounter.BracketHeight / 2)
	Widget.rightBracket:setImage(RegisterMaterial(CoD.AmmoCounter.BracketMaterialName))
	Widget.rightBracket:setRGB(CoD.AmmoCounter.BracketColorValue, CoD.AmmoCounter.BracketColorValue, CoD.AmmoCounter.BracketColorValue)
	Widget.rightBracket:setAlpha(CoD.AmmoCounter.BracketAlpha)
	Widget.rightBracket:registerAnimationState("fade_out", {
		alpha = 0
	})
	Widget.rightBracket.id = Widget.rightBracket.id .. ".RightBracket"
	Widget.bracketContainer:addElement(Widget.rightBracket)
	local f1_local3 = CoD.HUDDigit.BigBottomNumbersY
	local f1_local4 = CoD.HUDDigit.Width
	local f1_local5 = CoD.HUDDigit.BigNumbersHeight
	local f1_local6 = CoD.HUDDigit.Spacing
	Widget.ammoDigits = {}
	for f1_local7 = 1, 11, 1 do
		local f1_local10 = f1_local7
		local f1_local11 = CoD.HUDDigit.new()
		f1_local11:setLeftRight(false, true, -f1_local4, 0)
		f1_local11:setTopBottom(false, true, f1_local3, f1_local3 + f1_local5)
		f1_local11:setAlpha(0)
		Widget:addElement(f1_local11)
		table.insert(Widget.ammoDigits, f1_local11)
	end
	Widget.visibleDigitCount = 0
	Widget.currentStyle = nil
	Widget.setStyle = CoD.AmmoCounter.SetStyle
	Widget:registerEventHandler("test_advance", CoD.AmmoCounter.BootupTestAdvance)
	Widget:registerEventHandler("test_retreat", CoD.AmmoCounter.BootupTestRetreat)
	Widget:registerEventHandler("bootup_appear", CoD.AmmoCounter.BootupAppear)
	Widget:registerEventHandler("bootup_expand", CoD.AmmoCounter.BootupExpand)
	Widget:registerEventHandler("bootup_test_up", CoD.AmmoCounter.BootupTestUp)
	Widget:registerEventHandler("bootup_test_down", CoD.AmmoCounter.BootupTestDown)
	Widget:registerEventHandler("bootup_sequence", CoD.AmmoCounter.BootupSequence)
	Widget:registerEventHandler("bootup_shrink", CoD.AmmoCounter.BootupShrink)
	Widget:registerEventHandler("bootup_switch_to_hud", CoD.AmmoCounter.BootupSwitchToHUD)
	Widget:registerEventHandler("hud_update_ammo", CoD.AmmoCounter.UpdateAmmo)
	Widget:registerEventHandler("showAmmo", CoD.AmmoCounter.AmmoText_ShowAnimEvent)
	Widget:registerEventHandler("hideAmmo", CoD.AmmoCounter.AmmoText_HideAnimEvent)
	Widget:registerEventHandler("update_style", CoD.AmmoCounter.UpdateStyle)
	Widget:addElement(CoD.DPadSelection.new())
	return Widget
end

CoD.AmmoCounter.UpdateStyle = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.style
	if f2_local0 == nil then
		f2_local0 = CoD.AmmoCounter.DefaultStyle
		f2_arg1.style = f2_local0
	end
	f2_arg0:dispatchEventToChildren(f2_arg1)
	if f2_local0 == f2_arg0.currentStyle then
		return 
	elseif f2_local0 == "eighties" then
		f2_arg0.background:setAlpha(CoD.AmmoCounter.EightiesAlpha)
		f2_arg0.bracketContainer:setAlpha(0)
	else
		f2_arg0.bracketContainer:setAlpha(1)
		f2_arg0.background:setAlpha(0)
	end
	f2_arg0.currentStyle = f2_local0
end

CoD.AmmoCounter.GetThreeDigits = function (f3_arg0)
	local f3_local0 = math.floor(f3_arg0 / 100)
	f3_arg0 = f3_arg0 - f3_local0 * 100
	local f3_local1 = math.floor(f3_arg0 / 10)
	f3_arg0 = f3_arg0 - f3_local1 * 10
	local f3_local2 = f3_local0 == 0
	local f3_local3
	if f3_local2 == 0 then
		f3_local3 = f3_local2
	else
		f3_local3 = f3_local1 == 0
	end
	return f3_local0, f3_local1, f3_arg0, f3_local2, f3_local3
end

CoD.AmmoCounter.UpdateWeapon = function (f4_arg0, f4_arg1)
	if f4_arg1.fireType then
		if f4_arg1.weapon and (Engine.IsWeaponType(f4_arg1.weapon, "melee") or Engine.IsWeaponType(f4_arg1.weapon, "riotshield") or Engine.IsWeaponType(f4_arg1.weapon, "grenade")) then
			f4_arg0.fireType = nil
			f4_arg0.hideAmmo = true
		else
			f4_arg0.fireType = f4_arg1.fireType
			f4_arg0.hideAmmo = nil
		end
	end
	CoD.AmmoCounter.UpdateVisibility(f4_arg0, f4_arg1)
	f4_arg0:dispatchEventToChildren(f4_arg1)
end

CoD.AmmoCounter.UpdateAmmo = function (f5_arg0, f5_arg1)
	local f5_local0 = #f5_arg0.ammoDigits
	if f5_arg0.hideAmmo or UIExpression.InVehicle() == 1 then
		for f5_local1 = 1, f5_local0, 1 do
			f5_arg0.ammoDigits[f5_local1]:setAlpha(0)
		end
		return 
	else
		local f5_local1 = f5_arg1.lowClip
		local f5_local2 = CoD.AmmoCounter.NumbersRight
		local f5_local3 = CoD.HUDDigit.Width
		local f5_local4 = CoD.HUDDigit.Spacing
		local f5_local5 = CoD.HUDDigit.BigBottomNumbersY - CoD.AmmoCounter.NumbersBottom
		local f5_local6 = CoD.HUDDigit.BigNumbersHeight
		local f5_local7 = f5_local3 * CoD.HUDDigit.SmallDigitScale
		local f5_local8 = f5_local4 * CoD.HUDDigit.SmallDigitScale
		local f5_local9 = f5_local5 + CoD.HUDDigit.SmallDigitHeightDifference
		local f5_local10 = f5_local6 * CoD.HUDDigit.SmallDigitScale
		if f5_arg0.currentStyle == "eighties" then
			f5_local7 = f5_local3
			f5_local8 = f5_local4
			f5_local9 = f5_local5
			f5_local10 = f5_local6
		end
		local f5_local11, f5_local12, f5_local13, f5_local14, f5_local15 = CoD.AmmoCounter.GetThreeDigits(f5_arg1.ammoStock)
		local f5_local16 = 1
		f5_arg0.ammoDigits[1]:setDigit(f5_local13)
		f5_arg0.ammoDigits[1]:setLeftRight(false, true, f5_local2 - f5_local7, f5_local2)
		f5_arg0.ammoDigits[1]:setTopBottom(false, true, f5_local9, f5_local9 + f5_local10)
		f5_local2 = f5_local2 - f5_local8
		if f5_arg0.currentStyle == "eighties" or not f5_local15 then
			f5_arg0.ammoDigits[2]:setDigit(f5_local12, nil, f5_local15)
			f5_arg0.ammoDigits[2]:setLeftRight(false, true, f5_local2 - f5_local7, f5_local2)
			f5_arg0.ammoDigits[2]:setTopBottom(false, true, f5_local9, f5_local9 + f5_local10)
			f5_local2 = f5_local2 - f5_local8
			f5_local16 = 2
		end
		if f5_arg0.currentStyle == "eighties" or not f5_local14 then
			f5_arg0.ammoDigits[3]:setDigit(f5_local11, nil, f5_local14)
			f5_arg0.ammoDigits[3]:setLeftRight(false, true, f5_local2 - f5_local7, f5_local2)
			f5_arg0.ammoDigits[3]:setTopBottom(false, true, f5_local9, f5_local9 + f5_local10)
			f5_local2 = f5_local2 - f5_local8
			f5_local16 = 3
		end
		f5_local16 = f5_local16 + 1
		f5_arg0.ammoDigits[f5_local16]:setDigit(CoD.HUDDigit.Slash)
		f5_arg0.ammoDigits[f5_local16]:setLeftRight(false, true, f5_local2 - f5_local7, f5_local2)
		f5_arg0.ammoDigits[f5_local16]:setTopBottom(false, true, f5_local9, f5_local9 + f5_local10)
		f5_local2 = f5_local2 - f5_local8
		f5_local16 = f5_local16 + 1
		local f5_local17, f5_local18, f5_local19, f5_local20, f5_local21 = CoD.AmmoCounter.GetThreeDigits(f5_arg1.ammoInClip)
		f5_local15 = f5_local21
		f5_local14 = f5_local20
		f5_local13 = f5_local19
		f5_local12 = f5_local18
		f5_local11 = f5_local17
		f5_arg0.ammoDigits[f5_local16]:setDigit(f5_local13, f5_local1)
		f5_arg0.ammoDigits[f5_local16]:setLeftRight(false, true, f5_local2 - f5_local3, f5_local2)
		f5_arg0.ammoDigits[f5_local16]:setTopBottom(false, true, f5_local5, f5_local5 + f5_local6)
		f5_local2 = f5_local2 - f5_local4
		if f5_arg0.currentStyle == "eighties" or not f5_local15 then
			f5_local16 = f5_local16 + 1
			f5_arg0.ammoDigits[f5_local16]:setDigit(f5_local12, f5_local1, f5_local15)
			f5_arg0.ammoDigits[f5_local16]:setLeftRight(false, true, f5_local2 - f5_local3, f5_local2)
			f5_arg0.ammoDigits[f5_local16]:setTopBottom(false, true, f5_local5, f5_local5 + f5_local6)
			f5_local2 = f5_local2 - f5_local4
		end
		if f5_arg0.currentStyle ~= "eighties" and not f5_local14 then
			f5_local16 = f5_local16 + 1
			f5_arg0.ammoDigits[f5_local16]:setDigit(f5_local11, f5_local1, f5_local14)
			f5_arg0.ammoDigits[f5_local16]:setLeftRight(false, true, f5_local2 - f5_local3, f5_local2)
			f5_arg0.ammoDigits[f5_local16]:setTopBottom(false, true, f5_local5, f5_local5 + f5_local6)
			f5_local2 = f5_local2 - f5_local4
		end
		if f5_arg1.ammoInDWClip then
			f5_local16 = f5_local16 + 1
			f5_arg0.ammoDigits[f5_local16]:setDigit(CoD.HUDDigit.Line)
			f5_arg0.ammoDigits[f5_local16]:setLeftRight(false, true, f5_local2 - f5_local3, f5_local2)
			f5_arg0.ammoDigits[f5_local16]:setTopBottom(false, true, f5_local5, f5_local5 + f5_local6)
			f5_local2 = f5_local2 - f5_local4
			f5_local17 = f5_arg1.lowDWClip
			f5_local16 = f5_local16 + 1
			local f5_local18, f5_local19, f5_local20, f5_local21, f5_local22 = CoD.AmmoCounter.GetThreeDigits(f5_arg1.ammoInDWClip)
			f5_local15 = f5_local22
			f5_local14 = f5_local21
			f5_local13 = f5_local20
			f5_local12 = f5_local19
			f5_local11 = f5_local18
			f5_arg0.ammoDigits[f5_local16]:setDigit(f5_local13, f5_local17)
			f5_arg0.ammoDigits[f5_local16]:setLeftRight(false, true, f5_local2 - f5_local3, f5_local2)
			f5_arg0.ammoDigits[f5_local16]:setTopBottom(false, true, f5_local5, f5_local5 + f5_local6)
			f5_local2 = f5_local2 - f5_local4
			if f5_arg0.currentStyle == "eighties" or not f5_local15 then
				f5_local16 = f5_local16 + 1
				f5_arg0.ammoDigits[f5_local16]:setDigit(f5_local12, f5_local17, f5_local15)
				f5_arg0.ammoDigits[f5_local16]:setLeftRight(false, true, f5_local2 - f5_local3, f5_local2)
				f5_arg0.ammoDigits[f5_local16]:setTopBottom(false, true, f5_local5, f5_local5 + f5_local6)
				f5_local2 = f5_local2 - f5_local4
			end
			if f5_arg0.currentStyle ~= "eighties" and not f5_local14 then
				f5_local16 = f5_local16 + 1
				f5_arg0.ammoDigits[f5_local16]:setDigit(f5_local11, f5_local17, f5_local14)
				f5_arg0.ammoDigits[f5_local16]:setLeftRight(false, true, f5_local2 - f5_local3, f5_local2)
				f5_arg0.ammoDigits[f5_local16]:setTopBottom(false, true, f5_local5, f5_local5 + f5_local6)
				f5_local2 = f5_local2 - f5_local4
			end
		end
		f5_arg0.visibleDigitCount = f5_local16
		for f5_local17 = f5_local16 + 1, f5_local0, 1 do
			f5_arg0.ammoDigits[f5_local17]:setAlpha(0)
		end
		f5_arg0:dispatchEventToChildren(f5_arg1)
	end
end

CoD.AmmoCounter.UpdateVisibility = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.controller
	if f6_arg1.weapon then
		f6_arg0.weapon = f6_arg1.weapon
	end
	if UIExpression.IsVisibilityBitSet(f6_local0, CoD.BIT_IN_VEHICLE) == 0 and f6_arg0.weapon and Engine.IsWeaponType(f6_arg0.weapon, "melee") == false then
		if f6_arg0.visible ~= true then
			f6_arg0:setAlpha(1)
			f6_arg0.visible = true
		end
	elseif f6_arg0.visible == true then
		f6_arg0:setAlpha(0)
		f6_arg0.visible = nil
	end
end

CoD.AmmoCounter.Ammo_PulseHigh = function (f7_arg0, f7_arg1)
	if f7_arg1.interrupted ~= true then
		f7_arg0:beginAnimation("pulse_low", CoD.AmmoCounter.LowAmmoFadeTime, true, false)
		f7_arg0:setRGB(1, 0.5, 0.5)
	end
end

CoD.AmmoCounter.Ammo_PulseLow = function (f8_arg0, f8_arg1)
	if f8_arg1.interrupted ~= true then
		f8_arg0:beginAnimation("pulse_high", CoD.AmmoCounter.LowAmmoFadeTime, false, true)
		f8_arg0:setRGB(1, 0, 0)
	end
end

CoD.AmmoCounter.BootupAppear = function (f9_arg0, f9_arg1)
	f9_arg0:beginAnimation("appear", CoD.AmmoCounter.BootupAppearDuration)
	f9_arg0:setAlpha(CoD.AmmoCounter.DefaultAlpha)
end

CoD.AmmoCounter.BootupExpand = function (f10_arg0, f10_arg1)
	f10_arg0:animateToState("expand", CoD.AmmoCounter.BootupExpandDuration, true, true)
	CoD.AmmoCounter.HexBg_AppearAnim(f10_arg0.hexBg, CoD.AmmoCounter.BootupExpandDuration, true, true)
end

CoD.AmmoCounter.BootupTestUp = function (f11_arg0, f11_arg1)
	CoD.AmmoCounter.UpdateAmmo(f11_arg0, {
		ammoStock = 0,
		ammoInClip = 0
	})
	f11_arg0.testTime = 0
	f11_arg0:addElement(LUI.UITimer.new(33, "test_advance", false, f11_arg0))
end

CoD.AmmoCounter.BootupTestDown = function (f12_arg0, f12_arg1)
	CoD.AmmoCounter.UpdateAmmo(f12_arg0, {
		ammoStock = 999,
		ammoInClip = 999
	})
	f12_arg0.testTime = 0
	f12_arg0:addElement(LUI.UITimer.new(33, "test_retreat", false, f12_arg0))
end

CoD.AmmoCounter.BootupTestAdvance = function (f13_arg0, f13_arg1)
	f13_arg0.testTime = f13_arg0.testTime + f13_arg1.timeElapsed
	local f13_local0 = f13_arg0.testTime / CoD.AmmoCounter.BootupTestDuration
	if f13_local0 > 1 then
		f13_arg1.timer:close()
		f13_local0 = 1
		CoD.AmmoCounter.UpdateAmmo(f13_arg0, {
			ammoStock = 999,
			ammoInClip = 999
		})
	end
	local f13_local1 = math.floor(999 * f13_local0)
	CoD.AmmoCounter.UpdateAmmo(f13_arg0, {
		ammoStock = f13_local1,
		ammoInClip = math.min(999, f13_local1 + 3)
	})
end

CoD.AmmoCounter.BootupTestRetreat = function (f14_arg0, f14_arg1)
	f14_arg0.testTime = f14_arg0.testTime + f14_arg1.timeElapsed
	local f14_local0 = 1 - f14_arg0.testTime / CoD.AmmoCounter.BootupTestDuration
	if f14_local0 < 0 then
		f14_arg1.timer:close()
		f14_local0 = 0
		f14_arg0.hideAmmo = true
		CoD.AmmoCounter.UpdateAmmo(f14_arg0)
		return 
	else
		local f14_local1 = math.floor(999 * f14_local0)
		CoD.AmmoCounter.UpdateAmmo(f14_arg0, {
			ammoStock = f14_local1,
			ammoInClip = math.min(999, f14_local1 + 3)
		})
	end
end

CoD.AmmoCounter.BootupSequence = function (f15_arg0, f15_arg1)
	f15_arg0:animateToState("default")
	f15_arg0:animateToState("expand")
	f15_arg0:beginAnimation("appear", CoD.AmmoCounter.BootupExpandDuration)
	f15_arg0:setAlpha(CoD.AmmoCounter.DefaultAlpha)
	local f15_local0 = CoD.AmmoCounter.BootupExpandDuration
	f15_arg0:addElement(LUI.UITimer.new(f15_local0, "bootup_test_up", true, f15_arg0))
	f15_arg0:addElement(LUI.UITimer.new(f15_local0 + CoD.AmmoCounter.BootupTestDuration, "bootup_test_down", true, f15_arg0))
	f15_arg0:addElement(LUI.UITimer.new(f15_local0 + CoD.OffhandIcons.BootupExpandDuration + CoD.OffhandIcons.BootupShrinkDuration, "bootup_shrink", true, f15_arg0))
end

CoD.AmmoCounter.BootupShrink = function (f16_arg0, f16_arg1)
	f16_arg0:animateToState("default", CoD.AmmoCounter.BootupShrinkDuration, true, true)
	CoD.AmmoCounter.HexBg_DefaultAnim(f16_arg0.hexBg, CoD.AmmoCounter.BootupShrinkDuration, true, true)
end

CoD.AmmoCounter.BootupSwitchToHUD = function (f17_arg0, f17_arg1)
	f17_arg0:setAlpha(CoD.AmmoCounter.DefaultAlpha)
	if f17_arg1.isFrontEnd ~= true then
		f17_arg0:animateToState("expand")
		CoD.AmmoCounter.HexBg_AppearAnim(f17_arg0.hexBg, 0, nil, nil)
		f17_arg0:registerEventHandler("hud_update_refresh", CoD.AmmoCounter.UpdateVisibility)
		f17_arg0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.AmmoCounter.UpdateVisibility)
		f17_arg0:registerEventHandler("hud_update_weapon", CoD.AmmoCounter.UpdateVisibility)
		f17_arg0:registerEventHandler("hud_update_ammo", CoD.AmmoCounter.UpdateAmmo)
	else
		CoD.AmmoCounter.Bracket_DimAnim(f17_arg0.leftBracket)
		CoD.AmmoCounter.Bracket_DimAnim(f17_arg0.rightBracket)
	end
end

CoD.AmmoCounter.HexBg_DefaultAnim = function (f18_arg0, f18_arg1, f18_arg2, f18_arg3)
	f18_arg0:beginAnimation("default", f18_arg1, f18_arg2, f18_arg3)
	f18_arg0:setRGB(0, 0, 0)
end

CoD.AmmoCounter.HexBg_AppearAnim = function (f19_arg0, f19_arg1, f19_arg2, f19_arg3)
	f19_arg0:beginAnimation("appear", f19_arg1, f19_arg2, f19_arg3)
	f19_arg0:setRGB(1, 1, 1)
end

CoD.AmmoCounter.Bracket_DimAnim = function (f20_arg0)
	local f20_local0 = CoD.AmmoCounter.BracketFrontendColorValue
	f20_arg0:setRGB(f20_local0, f20_local0, f20_local0)
	f20_arg0:animateToState("fade_out", 250)
end

CoD.AmmoCounter.AmmoText_HideAnimEvent = function (f21_arg0, f21_arg1)
	CoD.AmmoCounter.AmmoText_HideAnim(f21_arg0, f21_arg1.duration, f21_arg1.easeIn, f21_arg1.easeOut)
end

CoD.AmmoCounter.AmmoText_HideAnim = function (f22_arg0, f22_arg1, f22_arg2, f22_arg3)
	f22_arg0.hideAmmo = true
	for f22_local3, f22_local4 in ipairs(f22_arg0.ammoDigits) do
		if f22_local4 then
			f22_local4:beginAnimation("hide", f22_arg1, f22_arg2, f22_arg3)
			f22_local4:setAlpha(0)
		end
	end
end

CoD.AmmoCounter.AmmoText_ShowAnimEvent = function (f23_arg0, f23_arg1)
	local f23_local0 = f23_arg1.duration
	local f23_local1 = f23_arg1.easeIn
	local f23_local2 = f23_arg1.easeOut
	f23_arg0.hideAmmo = false
	for f23_local6, f23_local7 in ipairs(f23_arg0.ammoDigits) do
		if f23_local7 and f23_local6 <= f23_arg0.visibleDigitCount then
			f23_local7:beginAnimation("show", f23_local0, f23_local1, f23_local2)
			f23_local7:setAlpha(CoD.AmmoCounter.TextAlpha)
		end
	end
end

