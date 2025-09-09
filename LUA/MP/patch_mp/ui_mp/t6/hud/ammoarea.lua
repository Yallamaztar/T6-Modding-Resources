CoD.AmmoArea = {}
CoD.AmmoArea.Right = -28
CoD.AmmoArea.Bottom = -7
CoD.AmmoArea.FireRateMaterials = {}
CoD.AmmoArea.FireRateRight = 0
CoD.AmmoArea.LowAmmoPulseDuration = 500
CoD.AmmoArea.WeaponLabelRight = CoD.AmmoArea.FireRateRight - 15
CoD.AmmoArea.WeaponLabelRightOffset = 58
CoD.AmmoArea.WeaponLabelSpacing = -98
CoD.AmmoArea.WeaponFontName = "SmallItalic"
CoD.AmmoArea.WeaponSelectionDelay = 2000
CoD.AmmoArea.WeaponSelectionDuration = 100
CoD.AmmoArea.AttachmentMoveDuration = 200
CoD.AmmoArea.StencilRightOffset = -45
LUI.createMenu.AmmoArea = function (f1_arg0)
	CoD.AmmoArea.RegisterMaterials()
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("AmmoArea", f1_arg0)
	f1_local0.scaleContainer = CoD.SplitscreenScaler.new(nil, CoD.SplitscreenMultiplier)
	f1_local0.scaleContainer:setLeftRight(false, true, 0, 0)
	f1_local0.scaleContainer:setTopBottom(false, true, 0, 0)
	f1_local0:addElement(f1_local0.scaleContainer)
	local Widget = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		xRot = 0,
		yRot = 0,
		zRot = 0
	})
	f1_local0.scaleContainer:addElement(Widget)
	local f1_local2 = f1_local0
	f1_local0 = Widget
	local f1_local3 = CoD.AmmoArea.Right + 25
	local f1_local4 = 22
	local f1_local5 = LUI.UIImage.new()
	f1_local5:setLeftRight(false, true, f1_local3, f1_local3 - 300)
	f1_local5:setTopBottom(false, true, f1_local4 - 150, f1_local4)
	f1_local5:setImage(RegisterMaterial("hud_mp_vis_right_lower_white"))
	f1_local0:addElement(f1_local5)
	local f1_local6 = LUI.UIImage.new()
	f1_local6:setLeftRight(false, true, f1_local3, f1_local3 - 300)
	f1_local6:setTopBottom(false, true, f1_local4 - 150, f1_local4)
	f1_local6:setImage(RegisterMaterial("hud_mp_vis_right_lower"))
	f1_local0:addElement(f1_local6)
	local f1_local7 = CoD.AmmoArea.Right - 118
	local f1_local8 = CoD.AmmoArea.Bottom + 22
	local f1_local9 = 64
	f1_local0.altFireImage = LUI.UIImage.new()
	f1_local0.altFireImage:setLeftRight(false, true, f1_local7 - f1_local9, f1_local7)
	f1_local0.altFireImage:setTopBottom(false, true, f1_local8 - f1_local9, f1_local8)
	f1_local0.altFireImage:setAlpha(0)
	f1_local0:addElement(f1_local0.altFireImage)
	local f1_local10 = f1_local7 - 64
	local f1_local11 = CoD.AmmoArea.Bottom + 6
	f1_local0.altFireArrow = LUI.UIImage.new()
	f1_local0.altFireArrow:setLeftRight(false, true, f1_local10, f1_local10 - 32)
	f1_local0.altFireArrow:setTopBottom(false, true, f1_local11, f1_local11 - 32)
	f1_local0.altFireArrow:setImage(RegisterMaterial("hud_mp_vis_ks_dpad_arrow"))
	f1_local0.altFireArrow:setAlpha(0)
	f1_local0:addElement(f1_local0.altFireArrow)
	if CoD.isPC then
		f1_local0.isPromptEnabled = false
		f1_local0.altFireKeyPrompt = LUI.UIText.new()
		f1_local0.altFireKeyPrompt:setLeftRight(false, true, f1_local10 - 160, f1_local10)
		f1_local0.altFireKeyPrompt:setTopBottom(false, true, f1_local11 - 3 - CoD.textSize.Default + 4, f1_local11 - 3)
		f1_local0.altFireKeyPrompt:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
		f1_local0.altFireKeyPrompt:setFont(CoD.fonts.Condensed)
		f1_local0.altFireKeyPrompt:setAlpha(0)
		f1_local0.altFireKeyPrompt:setAlignment(LUI.Alignment.Right)
		f1_local0:addElement(f1_local0.altFireKeyPrompt)
		f1_local0:registerEventHandler("input_source_changed", CoD.AmmoArea.InputSourceChanged)
		if CoD.useController and Engine.LastInput_Gamepad() then
			CoD.AmmoArea.InputSourceChanged(f1_local0, {
				source = 0
			})
		else
			CoD.AmmoArea.InputSourceChanged(f1_local0, {
				source = 1
			})
		end
	end
	local f1_local12 = CoD.AmmoArea.Right - 40
	local f1_local13 = CoD.AmmoArea.Bottom
	f1_local0:addElement(CoD.OffhandIcons.new("lethal", {
		left = f1_local12 - CoD.OffhandIcons.Width,
		top = f1_local13 - CoD.OffhandIcons.Size,
		right = f1_local12,
		bottom = f1_local13,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	}))
	f1_local12 = CoD.AmmoArea.Right - 94
	f1_local0:addElement(CoD.OffhandIcons.new("tactical", {
		left = f1_local12 - CoD.OffhandIcons.Width,
		top = f1_local13 - CoD.OffhandIcons.Size,
		right = f1_local12,
		bottom = f1_local13,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	}))
	local f1_local14 = CoD.AmmoArea.Bottom + CoD.HUDDigit.BigBottomNumbersY
	local f1_local15 = CoD.HUDDigit.Width
	local f1_local16 = CoD.HUDDigit.BigNumbersHeight
	local f1_local17 = CoD.HUDDigit.Spacing
	f1_local0.ammoDigits = {}
	for f1_local18 = 1, 11, 1 do
		local f1_local21 = f1_local18
		local f1_local22 = CoD.HUDDigit.new()
		f1_local22:setLeftRight(false, true, -f1_local15, 0)
		f1_local22:setTopBottom(false, true, f1_local14, f1_local14 + f1_local16)
		f1_local22:setAlpha(0)
		f1_local0:addElement(f1_local22)
		table.insert(f1_local0.ammoDigits, f1_local22)
	end
	local f1_local18 = CoD.AmmoArea.Right + CoD.AmmoArea.FireRateRight
	local f1_local19 = CoD.AmmoArea.Bottom - 47
	f1_local0.fireRateImage = LUI.UIImage.new()
	f1_local0.fireRateImage:setLeftRight(false, true, f1_local18 - 64, f1_local18)
	f1_local0.fireRateImage:setTopBottom(false, true, f1_local19 - 64, f1_local19)
	f1_local0.fireRateImage:setImage(CoD.AmmoArea.FireRateMaterials[1])
	f1_local0.fireRateImage:registerAnimationState("show", {
		alpha = 1
	})
	f1_local0:addElement(f1_local0.fireRateImage)
	local f1_local20 = CoD.AmmoArea.StencilRightOffset + CoD.AmmoArea.WeaponLabelRight
	local f1_local21 = CoD.AmmoArea.Right + CoD.AmmoArea.WeaponLabelRight + CoD.AmmoArea.WeaponLabelRightOffset + CoD.AmmoArea.StencilRightOffset
	local f1_local22 = f1_local19
	f1_local0.weaponStencilContainer = LUI.UIElement.new()
	f1_local0.weaponStencilContainer:setLeftRight(false, true, -500 + f1_local20 + f1_local21, f1_local21)
	f1_local0.weaponStencilContainer:setTopBottom(false, true, f1_local22 - 64, f1_local22)
	f1_local0:addElement(f1_local0.weaponStencilContainer)
	f1_local0.customizedLabelContainer = CoD.AmmoArea.CreateWeaponLabelContainer(5)
	f1_local0.customizedLabelContainer:setAlpha(0)
	f1_local0.weaponStencilContainer:addElement(f1_local0.customizedLabelContainer)
	f1_local0.weaponLabelContainer = CoD.AmmoArea.CreateWeaponLabelContainer(4)
	f1_local0.weaponLabelContainer:setAlpha(0)
	f1_local0.weaponStencilContainer:addElement(f1_local0.weaponLabelContainer)
	f1_local0.attachmentLabelContainer = {}
	f1_local0.attachmentLabelContainer[1] = CoD.AmmoArea.CreateWeaponLabelContainer(3)
	f1_local0.attachmentLabelContainer[1]:setAlpha(0)
	f1_local0.weaponStencilContainer:addElement(f1_local0.attachmentLabelContainer[1])
	f1_local0.attachmentLabelContainer[2] = CoD.AmmoArea.CreateWeaponLabelContainer(2)
	f1_local0.attachmentLabelContainer[2]:setAlpha(0)
	f1_local0.weaponStencilContainer:addElement(f1_local0.attachmentLabelContainer[2])
	f1_local0.attachmentLabelContainer[3] = CoD.AmmoArea.CreateWeaponLabelContainer(1)
	f1_local0.attachmentLabelContainer[3]:setAlpha(0)
	f1_local0.weaponStencilContainer:addElement(f1_local0.attachmentLabelContainer[3])
	f1_local0:registerEventHandler("hud_update_actionslots", CoD.AmmoArea.UpdateActionSlots)
	f1_local0:registerEventHandler("hud_update_ammo", CoD.AmmoArea.UpdateAmmo)
	f1_local0:registerEventHandler("hud_update_weapon", CoD.AmmoArea.UpdateWeapon)
	f1_local0:registerEventHandler("hud_update_weapon_select", CoD.AmmoArea.UpdateWeaponSelect)
	f1_local0:registerEventHandler("weapon_selection_done", CoD.AmmoArea.SwitchToCustomized)
	f1_local0:registerEventHandler("hud_update_refresh", CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_AMMO_COUNTER_HIDE, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_FLASH_BANGED, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_GAME_ENDED, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_PLAYER_DEAD, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_HARDCORE, CoD.AmmoArea.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SELECTING_LOCATION, CoD.AmmoArea.UpdateVisibility)
	f1_local0:setAlpha(0)
	return f1_local2
end

CoD.AmmoArea.CreateWeaponLabelText = function ()
	local f2_local0 = CoD.AmmoArea.WeaponFontName
	local f2_local1 = CoD.fonts[f2_local0]
	local f2_local2 = CoD.textSize[f2_local0]
	local f2_local3 = LUI.UIText.new()
	f2_local3:setLeftRight(true, true, -1, -1)
	f2_local3:setTopBottom(false, false, -f2_local2 / 2, f2_local2 / 2)
	f2_local3:setRGB(0, 0, 0)
	f2_local3:setAlpha(0.5)
	f2_local3:setFont(f2_local1)
	return f2_local3
end

CoD.AmmoArea.CreateWeaponLabelContainer = function (f3_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setPriority(f3_arg0)
	local f3_local1 = LUI.UIImage.new()
	f3_local1:setLeftRight(true, false, 0, 64)
	f3_local1:setTopBottom(true, true, 0, 0)
	f3_local1:setImage(RegisterMaterial("hud_mp_vis_gun_title_left"))
	Widget:addElement(f3_local1)
	f3_local1 = LUI.UIImage.new()
	f3_local1:setLeftRight(true, true, 64, -64)
	f3_local1:setTopBottom(true, true, 0, 0)
	f3_local1:setImage(RegisterMaterial("hud_mp_vis_gun_title_mid"))
	Widget:addElement(f3_local1)
	f3_local1 = LUI.UIImage.new()
	f3_local1:setLeftRight(false, true, -64, 0)
	f3_local1:setTopBottom(true, true, 0, 0)
	f3_local1:setImage(RegisterMaterial("hud_mp_vis_gun_title_right"))
	Widget:addElement(f3_local1)
	Widget.weaponText = CoD.AmmoArea.CreateWeaponLabelText()
	Widget:addElement(Widget.weaponText)
	return Widget
end

CoD.AmmoArea.GetThreeDigits = function (f4_arg0)
	local f4_local0 = math.floor(f4_arg0 / 100)
	f4_arg0 = f4_arg0 - f4_local0 * 100
	local f4_local1 = math.floor(f4_arg0 / 10)
	return f4_local0, f4_local1, f4_arg0 - f4_local1 * 10
end

CoD.AmmoArea.UpdateActionSlots = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1.actionSlotData
	f5_arg0.altFireImage:beginAnimation("fade", 250)
	f5_arg0.altFireArrow:beginAnimation("fade", 250)
	if f5_local0 and f5_local0[3] then
		f5_arg0.altFireImage:setImage(f5_local0[3].material)
		f5_arg0.altFireImage:setAlpha(1)
		if CoD.isPC then
			f5_arg0.isPromptEnabled = true
			if CoD.useController and Engine.LastInput_Gamepad() then
				CoD.AmmoArea.InputSourceChanged(f5_arg0, {
					source = 0
				})
			else
				CoD.AmmoArea.InputSourceChanged(f5_arg0, {
					source = 1
				})
			end
		else
			f5_arg0.altFireArrow:setAlpha(1)
		end
	else
		f5_arg0.altFireImage:setAlpha(0)
		f5_arg0.altFireArrow:setAlpha(0)
		if CoD.isPC then
			f5_arg0.isPromptEnabled = false
			f5_arg0.altFireKeyPrompt:setAlpha(0)
		end
	end
end

CoD.AmmoArea.UpdateAmmo = function (f6_arg0, f6_arg1)
	local f6_local0 = #f6_arg0.ammoDigits
	if f6_arg0.hideAmmo then
		for f6_local1 = 1, f6_local0, 1 do
			f6_arg0.ammoDigits[f6_local1]:setAlpha(0)
		end
		return 
	else
		local f6_local1 = f6_arg1.lowClip
		local f6_local2 = CoD.AmmoArea.Right - 20
		local f6_local3 = CoD.HUDDigit.Width
		local f6_local4 = CoD.HUDDigit.Spacing
		local f6_local5 = CoD.HUDDigit.BigBottomNumbersY
		local f6_local6 = CoD.HUDDigit.BigNumbersHeight
		local f6_local7 = f6_local3 * CoD.HUDDigit.SmallDigitScale
		local f6_local8 = f6_local4 * CoD.HUDDigit.SmallDigitScale
		local f6_local9 = f6_local5 + CoD.HUDDigit.SmallDigitHeightDifference
		local f6_local10 = f6_local6 * CoD.HUDDigit.SmallDigitScale
		local f6_local11, f6_local12, f6_local13 = CoD.AmmoArea.GetThreeDigits(f6_arg1.ammoStock)
		local f6_local14 = 1
		f6_arg0.ammoDigits[1]:setDigit(f6_local13)
		f6_arg0.ammoDigits[1]:setLeftRight(false, true, f6_local2 - f6_local7, f6_local2)
		f6_arg0.ammoDigits[1]:setTopBottom(false, true, f6_local9, f6_local9 + f6_local10)
		f6_local2 = f6_local2 - f6_local8
		if f6_local11 > 0 or f6_local12 > 0 then
			f6_arg0.ammoDigits[2]:setDigit(f6_local12)
			f6_arg0.ammoDigits[2]:setLeftRight(false, true, f6_local2 - f6_local7, f6_local2)
			f6_arg0.ammoDigits[2]:setTopBottom(false, true, f6_local9, f6_local9 + f6_local10)
			f6_local2 = f6_local2 - f6_local8
			f6_local14 = 2
		end
		if f6_local11 > 0 then
			f6_arg0.ammoDigits[3]:setDigit(f6_local11)
			f6_arg0.ammoDigits[3]:setLeftRight(false, true, f6_local2 - f6_local7, f6_local2)
			f6_arg0.ammoDigits[3]:setTopBottom(false, true, f6_local9, f6_local9 + f6_local10)
			f6_local2 = f6_local2 - f6_local8
			f6_local14 = 3
		end
		f6_local14 = f6_local14 + 1
		f6_arg0.ammoDigits[f6_local14]:setDigit(CoD.HUDDigit.Slash)
		f6_arg0.ammoDigits[f6_local14]:setLeftRight(false, true, f6_local2 - f6_local7, f6_local2)
		f6_arg0.ammoDigits[f6_local14]:setTopBottom(false, true, f6_local9, f6_local9 + f6_local10)
		f6_local2 = f6_local2 - f6_local8
		f6_local14 = f6_local14 + 1
		local f6_local15, f6_local16, f6_local17 = CoD.AmmoArea.GetThreeDigits(f6_arg1.ammoInClip)
		f6_local13 = f6_local17
		f6_local12 = f6_local16
		f6_local11 = f6_local15
		f6_arg0.ammoDigits[f6_local14]:setDigit(f6_local13, f6_local1)
		f6_arg0.ammoDigits[f6_local14]:setLeftRight(false, true, f6_local2 - f6_local3, f6_local2)
		f6_arg0.ammoDigits[f6_local14]:setTopBottom(false, true, f6_local5, f6_local5 + f6_local6)
		f6_local2 = f6_local2 - f6_local4
		if f6_local11 > 0 or f6_local12 > 0 then
			f6_local14 = f6_local14 + 1
			f6_arg0.ammoDigits[f6_local14]:setDigit(f6_local12, f6_local1)
			f6_arg0.ammoDigits[f6_local14]:setLeftRight(false, true, f6_local2 - f6_local3, f6_local2)
			f6_arg0.ammoDigits[f6_local14]:setTopBottom(false, true, f6_local5, f6_local5 + f6_local6)
			f6_local2 = f6_local2 - f6_local4
		end
		if f6_local11 > 0 then
			f6_local14 = f6_local14 + 1
			f6_arg0.ammoDigits[f6_local14]:setDigit(f6_local11, f6_local1)
			f6_arg0.ammoDigits[f6_local14]:setLeftRight(false, true, f6_local2 - f6_local3, f6_local2)
			f6_arg0.ammoDigits[f6_local14]:setTopBottom(false, true, f6_local5, f6_local5 + f6_local6)
			f6_local2 = f6_local2 - f6_local4
		end
		if f6_arg1.ammoInDWClip then
			f6_local14 = f6_local14 + 1
			f6_arg0.ammoDigits[f6_local14]:setDigit(CoD.HUDDigit.Line)
			f6_arg0.ammoDigits[f6_local14]:setLeftRight(false, true, f6_local2 - f6_local3, f6_local2)
			f6_arg0.ammoDigits[f6_local14]:setTopBottom(false, true, f6_local5, f6_local5 + f6_local6)
			f6_local2 = f6_local2 - f6_local4
			f6_local15 = f6_arg1.lowDWClip
			f6_local14 = f6_local14 + 1
			local f6_local16, f6_local17, f6_local18 = CoD.AmmoArea.GetThreeDigits(f6_arg1.ammoInDWClip)
			f6_local13 = f6_local18
			f6_local12 = f6_local17
			f6_local11 = f6_local16
			f6_arg0.ammoDigits[f6_local14]:setDigit(f6_local13, f6_local15)
			f6_arg0.ammoDigits[f6_local14]:setLeftRight(false, true, f6_local2 - f6_local3, f6_local2)
			f6_arg0.ammoDigits[f6_local14]:setTopBottom(false, true, f6_local5, f6_local5 + f6_local6)
			f6_local2 = f6_local2 - f6_local4
			if f6_local11 > 0 or f6_local12 > 0 then
				f6_local14 = f6_local14 + 1
				f6_arg0.ammoDigits[f6_local14]:setDigit(f6_local12, f6_local15)
				f6_arg0.ammoDigits[f6_local14]:setLeftRight(false, true, f6_local2 - f6_local3, f6_local2)
				f6_arg0.ammoDigits[f6_local14]:setTopBottom(false, true, f6_local5, f6_local5 + f6_local6)
				f6_local2 = f6_local2 - f6_local4
			end
			if f6_local11 > 0 then
				f6_local14 = f6_local14 + 1
				f6_arg0.ammoDigits[f6_local14]:setDigit(f6_local11, f6_local15)
				f6_arg0.ammoDigits[f6_local14]:setLeftRight(false, true, f6_local2 - f6_local3, f6_local2)
				f6_arg0.ammoDigits[f6_local14]:setTopBottom(false, true, f6_local5, f6_local5 + f6_local6)
				f6_local2 = f6_local2 - f6_local4
			end
		end
		for f6_local15 = f6_local14 + 1, f6_local0, 1 do
			f6_arg0.ammoDigits[f6_local15]:setAlpha(0)
		end
		f6_arg0:dispatchEventToChildren(f6_arg1)
	end
end

CoD.AmmoArea.UpdateVisibility = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg1.controller
	if UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_EMP_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_IN_VEHICLE) == 0 and UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_IN_GUIDED_MISSILE) == 0 and UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0 and UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_AMMO_COUNTER_HIDE) == 0 and UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_IS_FLASH_BANGED) == 0 and UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_GAME_ENDED) == 0 and UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_SCOREBOARD_OPEN) == 0 and UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_IN_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f7_local0, CoD.BIT_HUD_HARDCORE) == 0 and (not CoD.IsShoutcaster(f7_local0) or CoD.ExeProfileVarBool(f7_local0, "shoutcaster_inventory") and Engine.IsSpectatingActiveClient(f7_local0)) and CoD.FSM_VISIBILITY(f7_local0) == 0 then
		if f7_arg0.visible ~= true then
			f7_arg0:setAlpha(1)
			f7_arg0.visible = true
		end
	elseif f7_arg0.visible == true then
		f7_arg0:setAlpha(0)
		f7_arg0.visible = nil
	end
	f7_arg0:dispatchEventToChildren(f7_arg1)
end

CoD.AmmoArea.UpdateWeapon = function (f8_arg0, f8_arg1)
	if f8_arg1.fireTypeMaterial ~= nil then
		f8_arg0.fireRateImage:setImage(f8_arg1.fireTypeMaterial)
		f8_arg0.fireTypeMaterial = f8_arg1.fireTypeMaterial
	else
		f8_arg0.fireTypeMaterial = nil
	end
	if f8_arg1.weapon and (Engine.IsWeaponType(f8_arg1.weapon, "melee") or Engine.IsWeaponType(f8_arg1.weapon, "riotshield") or Engine.IsWeaponType(f8_arg1.weapon, "grenade")) then
		f8_arg0.hideAmmo = true
	else
		f8_arg0.hideAmmo = nil
	end
	CoD.AmmoArea.UpdateVisibility(f8_arg0, f8_arg1)
	f8_arg0:dispatchEventToChildren(f8_arg1)
end

CoD.AmmoArea.UpdateWeaponSelect = function (f9_arg0, f9_arg1)
	local f9_local0 = UIExpression.ToUpper(nil, Engine.Localize(f9_arg1.weaponDisplayName))
	local f9_local1 = ""
	local f9_local2 = ""
	local f9_local3 = ""
	if f9_arg1.attachment1DisplayName ~= nil then
		f9_local1 = UIExpression.ToUpper(nil, Engine.Localize(f9_arg1.attachment1DisplayName))
	end
	if f9_arg1.attachment2DisplayName ~= nil then
		f9_local2 = UIExpression.ToUpper(nil, Engine.Localize(f9_arg1.attachment2DisplayName))
	end
	if f9_arg1.attachment3DisplayName ~= nil then
		f9_local3 = UIExpression.ToUpper(nil, Engine.Localize(f9_arg1.attachment3DisplayName))
	end
	if f9_arg0.localizedWeaponName ~= f9_local0 or f9_arg0.localizedAttachment1Name ~= f9_local1 or f9_arg0.localizedAttachment2Name ~= f9_local2 or f9_arg0.localizedAttachment3Name ~= f9_local3 then
		f9_arg0.localizedWeaponName = f9_local0
		f9_arg0.localizedAttachment1Name = f9_local1
		f9_arg0.localizedAttachment2Name = f9_local2
		f9_arg0.localizedAttachment3Name = f9_local3
		f9_arg0.weaponStencilContainer.visibleWidth = 0
		CoD.AmmoArea.SetWeaponLabel(f9_arg0.weaponStencilContainer, f9_arg0.customizedLabelContainer, Engine.Localize("MENU_CUSTOMIZED_CAPS"), 0)
		CoD.AmmoArea.SetWeaponLabel(f9_arg0.weaponStencilContainer, f9_arg0.weaponLabelContainer, f9_local0, 1)
		CoD.AmmoArea.SetWeaponLabel(f9_arg0.weaponStencilContainer, f9_arg0.attachmentLabelContainer[1], f9_local1, 1)
		CoD.AmmoArea.SetWeaponLabel(f9_arg0.weaponStencilContainer, f9_arg0.attachmentLabelContainer[2], f9_local2, 1)
		CoD.AmmoArea.SetWeaponLabel(f9_arg0.weaponStencilContainer, f9_arg0.attachmentLabelContainer[3], f9_local3, 1)
		local f9_local4 = f9_arg0.weaponStencilContainer.visibleWidth - f9_arg0.weaponLabelContainer.visibleWidth
		if f9_local4 ~= 0 then
			for f9_local5 = 1, 3, 1 do
				f9_arg0.attachmentLabelContainer[f9_local5].slideTime = CoD.AmmoArea.AttachmentMoveDuration * f9_arg0.attachmentLabelContainer[f9_local5].visibleWidth / f9_local4
			end
		end
		local f9_local5 = 0
		for f9_local6 = 1, 3, 1 do
			f9_local5 = f9_local5 - f9_arg0.attachmentLabelContainer[f9_local6].visibleWidth
		end
		f9_local5 = f9_local5 + f9_arg0.weaponLabelContainer.trimWidth
		f9_arg0.weaponLabelContainer:setLeftRight(false, true, -f9_arg0.weaponLabelContainer.fullWidth + f9_local5, f9_local5)
		for f9_local6 = 1, 3, 1 do
			f9_local5 = f9_local5 + f9_arg0.attachmentLabelContainer[f9_local6].visibleWidth
			f9_arg0.attachmentLabelContainer[f9_local6]:setLeftRight(false, true, -f9_arg0.attachmentLabelContainer[f9_local6].fullWidth + f9_local5, f9_local5)
		end
		f9_arg0.fireRateImage:completeAnimation()
		f9_arg0.fireRateImage:setAlpha(0)
		f9_arg0.animationSequence = 4
		f9_arg0:completeAnimation()
		if not f9_arg0.weaponSelectionTimer then
			f9_arg0.weaponSelectionTimer = LUI.UITimer.new(CoD.AmmoArea.WeaponSelectionDelay, "weapon_selection_done", true, f9_arg0)
		else
			f9_arg0.weaponSelectionTimer:reset()
		end
		f9_arg0:addElement(f9_arg0.weaponSelectionTimer)
	end
	f9_arg0:dispatchEventToChildren(f9_arg1)
end

CoD.AmmoArea.SetWeaponLabel = function (f10_arg0, f10_arg1, f10_arg2, f10_arg3)
	local f10_local0 = CoD.AmmoArea.WeaponFontName
	local f10_local1, f10_local2, f10_local3, f10_local4 = GetTextDimensions(f10_arg2, CoD.fonts[f10_local0], CoD.textSize[f10_local0])
	local f10_local5 = f10_local1 + f10_local3 - 18
	if f10_local5 < 0 then
		f10_local5 = 0
	end
	f10_arg1.fullWidth = f10_local5 + 128
	f10_arg1:setLeftRight(false, true, -f10_arg1.fullWidth, 0)
	f10_arg1.weaponText:setText(f10_arg2)
	f10_arg1:setAlpha(f10_arg3)
	f10_arg1.slideTime = 0
	if f10_arg2 == "" then
		f10_arg1.visibleWidth = 0
		f10_arg1:close()
	else
		f10_arg1:completeAnimation()
		f10_arg1.visibleWidth = f10_local5 + 30
		f10_arg1.trimWidth = (f10_arg1.fullWidth - f10_arg1.visibleWidth) / 2
		f10_arg0:addElement(f10_arg1)
		f10_arg0.visibleWidth = f10_arg0.visibleWidth + f10_arg1.visibleWidth
	end
end

CoD.AmmoArea.SwitchToCustomized = function (f11_arg0, f11_arg1)
	local f11_local0 = CoD.AmmoArea.WeaponSelectionDuration
	local f11_local1 = f11_arg0.attachmentLabelContainer[2].visibleWidth ~= 0
	local f11_local2 = 0
	if f11_local1 then
		for f11_local3 = 1, 3, 1 do
			f11_local2 = f11_local2 + f11_arg0.attachmentLabelContainer[f11_local3].visibleWidth
			f11_arg0.attachmentLabelContainer[f11_local3]:beginAnimation("attachment_fade_out", f11_local0 / 2)
			f11_arg0.attachmentLabelContainer[f11_local3]:setAlpha(0)
		end
		f11_arg0.customizedLabelContainer:setLeftRight(false, true, -f11_arg0.customizedLabelContainer.fullWidth + f11_arg0.weaponLabelContainer.trimWidth, f11_arg0.weaponLabelContainer.trimWidth)
		f11_arg0.customizedLabelContainer:beginAnimation("customized_fade_in", f11_local0, false, false)
		f11_arg0.customizedLabelContainer:setAlpha(1)
		if f11_arg0.fireTypeMaterial == nil then
			local f11_local3 = f11_arg0.weaponLabelContainer.trimWidth - f11_arg0.customizedLabelContainer.visibleWidth
			f11_arg0.weaponLabelContainer:beginAnimation("attachment_firetype", f11_local0, false, false)
			f11_arg0.weaponLabelContainer:setLeftRight(false, true, -f11_arg0.weaponLabelContainer.fullWidth + f11_local3, f11_local3)
		end
	end
	if f11_arg0.fireTypeMaterial ~= nil then
		f11_local2 = 0
		if f11_local1 then
			f11_local2 = f11_local2 - f11_arg0.customizedLabelContainer.visibleWidth
		else
			f11_local2 = f11_local2 - f11_arg0.attachmentLabelContainer[1].visibleWidth
		end
		f11_local2 = f11_local2 - 64 + f11_arg0.weaponLabelContainer.trimWidth
		f11_arg0.fireRateImage:animateToState("show", f11_local0 * 2, true, false)
		f11_arg0:beginAnimation("firetype", f11_local0, false, false)
		f11_arg0.weaponLabelContainer:beginAnimation("attachment_firetype", f11_local0, false, false)
		f11_arg0.weaponLabelContainer:setLeftRight(false, true, -f11_arg0.weaponLabelContainer.fullWidth + f11_local2, f11_local2)
		if f11_local1 then
			f11_local2 = f11_local2 + f11_arg0.customizedLabelContainer.visibleWidth
			f11_arg0.customizedLabelContainer:setLeftRight(false, true, -f11_arg0.customizedLabelContainer.fullWidth + f11_local2, f11_local2)
		else
			f11_local2 = f11_local2 + f11_arg0.attachmentLabelContainer[1].visibleWidth
			f11_arg0.attachmentLabelContainer[1]:beginAnimation("attachment_firetype", f11_local0, false, false)
			f11_arg0.attachmentLabelContainer[1]:setLeftRight(false, true, -f11_arg0.attachmentLabelContainer[1].fullWidth + f11_local2, f11_local2)
		end
	end
end

CoD.AmmoArea.RegisterMaterials = function ()
	CoD.AmmoArea.FireRateMaterials[1] = RegisterMaterial("hud_mp_firerate_single")
	CoD.AmmoArea.FireRateMaterials[2] = RegisterMaterial("hud_mp_firerate_burst")
	CoD.AmmoArea.FireRateMaterials[3] = RegisterMaterial("hud_mp_firerate_auto")
	CoD.AmmoArea.FireRateMaterials[4] = RegisterMaterial("hud_mp_firerate_free")
	CoD.AmmoArea.FireRateMaterials[5] = RegisterMaterial("hud_mp_firerate_lock")
	CoD.AmmoArea.FireRateMaterials[6] = RegisterMaterial("hud_mp_firerate_pump")
	CoD.AmmoArea.FireRateMaterials[7] = RegisterMaterial("hud_mp_firerate_bolt")
end

CoD.AmmoArea.SetKeyBind = function (f13_arg0)
	local f13_local0, f13_local1 = nil
	if f13_arg0.altFireKeyPrompt ~= nil then
		f13_local1 = "+actionslot 3"
		if f13_local1 ~= nil then
			f13_arg0.altFireKeyPrompt:setText(Engine.GetKeyBindingLocalizedString(0, f13_local1, 0))
		end
	end
end

CoD.AmmoArea.InputSourceChanged = function (f14_arg0, f14_arg1)
	if CoD.isPC and f14_arg0.isPromptEnabled then
		if CoD.useController and f14_arg1.source == 0 then
			if f14_arg0.altFireKeyPrompt ~= nil then
				f14_arg0.altFireKeyPrompt:setAlpha(0)
			end
			if f14_arg0.altFireArrow ~= nil then
				f14_arg0.altFireArrow:setAlpha(1)
			end
		else
			CoD.AmmoArea.SetKeyBind(f14_arg0)
			if f14_arg0.altFireKeyPrompt ~= nil then
				f14_arg0.altFireKeyPrompt:setAlpha(1)
			end
			if f14_arg0.altFireArrow ~= nil then
				f14_arg0.altFireArrow:setAlpha(0)
			end
		end
	end
end

