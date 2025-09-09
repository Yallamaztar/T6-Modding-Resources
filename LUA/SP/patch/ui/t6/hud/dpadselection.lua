require("T6.CoDBase")
CoD.DPadSelection = {}
CoD.DPadSelection.SelectorSideLength = 64
CoD.DPadSelection.HeightOffset = -96
CoD.DPadSelection.Spacing = -28
CoD.DPadSelection.RewardCount = 3
CoD.DPadSelection.RewardInventoryCount = 1
CoD.DPadSelection.RewardTotalCount = CoD.DPadSelection.RewardCount + CoD.DPadSelection.RewardInventoryCount
CoD.DPadSelection.ArrowMaterial = nil
CoD.DPadSelection.Arrow = {}
CoD.DPadSelection.Arrow.r = 0.9
CoD.DPadSelection.Arrow.g = 0.9
CoD.DPadSelection.Arrow.b = 0.1
CoD.DPadSelection.InventoryAnimationDuration = 250
CoD.DPadSelection.DisabledAlpha = 0.35
CoD.DPadSelection.ProgressBarTop = 6
CoD.DPadSelection.ProgressBarRight = -52
CoD.DPadSelection.RewardGainedFocusEvent = {
	name = "reward_gained_focus"
}
CoD.DPadSelection.DefaultStyle = "twenties"
CoD.DPadSelection.ActionSlotDrawOrder = {
	"down",
	"right",
	"up"
}
CoD.DPadSelection.new = function ()
	local f1_local0 = LUI.UIVerticalList.new()
	if CoD.isPC then
		f1_local0:setLeftRight(false, true, -210, 27)
		f1_local0:setTopBottom(false, true, -110, -110)
	else
		f1_local0:setLeftRight(false, true, -200, 37)
		f1_local0:setTopBottom(false, true, -100, -100)
	end
	f1_local0:setAlignment(LUI.Alignment.Bottom)
	CoD.AddDebugBackground(f1_local0)
	f1_local0.visible = true
	f1_local0:registerEventHandler("hud_update_refresh", CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_AMMO_COUNTER_HIDE, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_FLASH_BANGED, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_PLAYER_DEAD, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_SCOPED, CoD.DPadSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_actionslots", CoD.DPadSelection.UpdateActionSlots)
	f1_local0.currentStyle = CoD.HUDDigit.DefaultStyle
	f1_local0:registerEventHandler("update_style", CoD.DPadSelection.UpdateStyle)
	return f1_local0
end

CoD.DPadSelection.UpdateStyle = function (f2_arg0, f2_arg1)
	f2_arg0.currentStyle = f2_arg1.style
	if f2_arg0.currentStyle == nil then
		f2_arg0.currentStyle = CoD.DPadSelection.DefaultStyle
	end
end

CoD.DPadSelection.UpdateActionSlots = function (f3_arg0, f3_arg1)
	f3_arg0:removeAllChildren()
	local f3_local0 = f3_arg1.actionSlotData
	local f3_local1 = #f3_local0
	for f3_local10, f3_local11 in ipairs(CoD.DPadSelection.ActionSlotDrawOrder) do
		local f3_local12 = CoD.HUD.DPadOrder[f3_local11]
		if f3_local0[f3_local12] ~= nil then
			local f3_local5 = f3_local11
			local f3_local6 = f3_local0[f3_local12]
			local f3_local7 = 25 * f3_local6.aspectRatio
			local f3_local8 = nil
			if f3_local6.ammo > 0 then
				f3_local8 = CoD.HUDAlphaFull
			else
				f3_local8 = CoD.HUDAlphaEmpty
			end
			local f3_local9 = nil
			if f3_arg0.currentStyle == "eighties" then
				f3_local9 = CoD.DPadSelection.NewElementEightiesButton(f3_local11, f3_local1, f3_local6.material, f3_local6.aspectRatio, f3_local6.ammo)
			else
				f3_local9 = CoD.DPadSelection.NewElementFutureButton(f3_local11, f3_local1, f3_local6.material, f3_local6.aspectRatio, f3_local6.ammo)
			end
			f3_arg0:addElement(f3_local9)
			f3_local1 = f3_local1 - 1
		end
	end
end

CoD.DPadSelection.NewElementFutureButton = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	local f4_local0 = 0
	if f4_arg1 == 1 then
		f4_local0 = -7
	elseif f4_arg1 == 2 then
		f4_local0 = -14
	elseif f4_arg1 == 3 then
		f4_local0 = -21
	elseif f4_arg1 == 4 then
		f4_local0 = -28
	end
	local f4_local1 = 50
	local Widget = LUI.UIElement.new({
		left = f4_local0 - f4_local1,
		top = 0,
		right = f4_local0,
		bottom = 50,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	Widget:setAlpha(1)
	Widget.selectorButtonBackground = LUI.UIImage.new({
		left = -15,
		top = -15,
		right = 15,
		bottom = 15,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = 0.8,
		red = CoD.visorDeepBlue.r,
		green = CoD.visorDeepBlue.g,
		blue = CoD.visorDeepBlue.b,
		material = RegisterMaterial("hud_mp_vis_ks_dpad_box")
	})
	Widget:addElement(Widget.selectorButtonBackground)
	local f4_local3 = 28
	local f4_local4 = 56
	local f4_local5 = nil
	local f4_local6 = 0
	if f4_arg0 == "up" then
		local f4_local7 = 2
		local f4_local8 = 0
		f4_local6 = 90
		f4_local5 = {
			leftAnchor = false,
			rightAnchor = false,
			left = f4_local7 - f4_local3,
			right = f4_local7 + f4_local3,
			topAnchor = true,
			bottomAnchor = false,
			top = f4_local8 - f4_local4,
			bottom = f4_local8,
			material = RegisterMaterial("hud_sp_vis_ks_dpad_arrow")
		}
	elseif f4_arg0 == "right" then
		local f4_local7 = 10
		f4_local6 = 0
		f4_local5 = {
			leftAnchor = false,
			rightAnchor = true,
			left = f4_local7,
			right = f4_local7 + f4_local4,
			topAnchor = false,
			bottomAnchor = false,
			top = -f4_local3,
			bottom = f4_local3,
			material = RegisterMaterial("hud_mp_vis_ks_dpad_arrow")
		}
	elseif f4_arg0 == "down" then
		local f4_local7 = 2
		local f4_local8 = 2
		f4_local6 = -90
		f4_local5 = {
			leftAnchor = false,
			rightAnchor = false,
			left = -f4_local7 - f4_local3,
			right = -f4_local7 + f4_local3,
			topAnchor = false,
			bottomAnchor = true,
			top = -f4_local8,
			bottom = -f4_local8 + f4_local4,
			material = RegisterMaterial("hud_sp_vis_ks_dpad_arrow")
		}
	end
	if f4_local5 ~= nil then
		Widget.arrow = LUI.UIImage.new(f4_local5)
		if Widget.arrow ~= nil then
			Widget.arrow:setRGB(CoD.visorDeepBlue.r, CoD.visorDeepBlue.g, CoD.visorDeepBlue.b)
			Widget.arrow:setZRot(f4_local6)
			Widget:addElement(Widget.arrow)
			if CoD.isPC then
				Widget.direction = f4_arg0
				Widget.keyPrompt = LUI.UIText.new(f4_local5)
				Widget.keyPrompt:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
				Widget.keyPrompt:setFont(CoD.fonts.Condensed)
				Widget.keyPrompt:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
				Widget.keyPrompt:setLeftRight(false, true, -f4_local1 - 120, -f4_local1 - 10)
				Widget.keyPrompt:setAlpha(0.5)
				Widget:setAlignment(LUI.Alignment.Right)
				Widget:registerEventHandler("input_source_changed", CoD.DPadSelection.InputSourceChanged)
				Widget:addElement(Widget.keyPrompt)
				if CoD.useController and Engine.LastInput_Gamepad() then
					CoD.DPadSelection.InputSourceChanged(Widget, {
						source = 0
					})
				else
					CoD.DPadSelection.InputSourceChanged(Widget, {
						source = 1
					})
				end
			end
		end
	end
	local f4_local9 = 25
	f4_local1 = f4_local9 * f4_arg3
	Widget:addElement(LUI.UIImage.new({
		left = -f4_local1 / 2 + 5,
		top = -f4_local9 / 2,
		right = f4_local1 / 2 + 5,
		bottom = f4_local9 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = CoD.HUDBaseColor.r,
		green = CoD.HUDBaseColor.g,
		blue = CoD.HUDBaseColor.b,
		alpha = alpha,
		material = f4_arg2
	}))
	return Widget
end

CoD.DPadSelection.NewElementEightiesButton = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	local f5_local0 = -29
	local f5_local1 = 50
	local Widget = LUI.UIElement.new({
		left = f5_local0 - f5_local1,
		top = 0,
		right = f5_local0,
		bottom = 50,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	Widget:setAlpha(1)
	Widget.selectorButtonBackground = LUI.UIImage.new({
		left = -8,
		top = -2,
		right = 8,
		bottom = 2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		material = RegisterMaterial("hud_sp_rectangle_mid_80s")
	})
	Widget:addElement(Widget.selectorButtonBackground)
	local f5_local3 = RegisterMaterial("hud_sp_white_bracket_80s")
	local f5_local4 = -5
	local f5_local5 = 4
	local f5_local6 = 9
	local f5_local7 = -11
	local f5_local8 = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = false,
		left = f5_local4,
		right = f5_local5,
		top = f5_local6,
		bottom = f5_local6 + 1,
		material = f5_local3,
		alpha = 0.4
	})
	local f5_local9 = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = false,
		bottomAnchor = true,
		left = f5_local4,
		right = f5_local5,
		top = f5_local7 - 1,
		bottom = f5_local7,
		material = f5_local3,
		alpha = 0.4
	})
	local f5_local10 = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = true,
		left = f5_local4,
		right = f5_local4 + 1,
		top = f5_local6,
		bottom = f5_local7,
		material = f5_local3,
		alpha = 0.4
	})
	local f5_local11 = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		left = f5_local5 - 1,
		right = f5_local5,
		top = f5_local6,
		bottom = f5_local7,
		material = f5_local3,
		alpha = 0.4
	})
	Widget:addElement(f5_local8)
	Widget:addElement(f5_local9)
	Widget:addElement(f5_local10)
	Widget:addElement(f5_local11)
	local f5_local12 = nil
	local f5_local13 = 0
	if f5_arg0 == "up" then
		local f5_local14 = 2
		local f5_local15 = 0
		f5_local13 = 90
		f5_local12 = {
			leftAnchor = false,
			rightAnchor = false,
			left = f5_local14 - 16,
			right = f5_local14 + 16,
			topAnchor = true,
			bottomAnchor = false,
			top = f5_local15 - 32,
			bottom = f5_local15,
			material = RegisterMaterial("hud_sp_vis_ks_dpad_arrow")
		}
	elseif f5_arg0 == "right" then
		local f5_local14 = 10
		f5_local13 = 0
		f5_local12 = {
			leftAnchor = false,
			rightAnchor = true,
			left = f5_local14,
			right = f5_local14 + 32,
			topAnchor = false,
			bottomAnchor = false,
			top = -16,
			bottom = 16,
			material = RegisterMaterial("hud_sp_vis_ks_dpad_arrow")
		}
	elseif f5_arg0 == "down" then
		local f5_local14 = 2
		local f5_local15 = 2
		f5_local13 = -90
		f5_local12 = {
			leftAnchor = false,
			rightAnchor = false,
			left = -f5_local14 - 16,
			right = -f5_local14 + 16,
			topAnchor = false,
			bottomAnchor = true,
			top = -f5_local15,
			bottom = -f5_local15 + 32,
			material = RegisterMaterial("hud_sp_vis_ks_dpad_arrow")
		}
	end
	if f5_local12 ~= nil then
		Widget.arrow = LUI.UIImage.new(f5_local12)
		if Widget.arrow ~= nil then
			Widget.arrow:setZRot(f5_local13)
			Widget:addElement(Widget.arrow)
			if CoD.isPC then
				Widget.direction = f5_arg0
				Widget.keyPrompt = LUI.UIText.new(f5_local12)
				Widget.keyPrompt:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
				Widget.keyPrompt:setFont(CoD.fonts.Condensed)
				Widget.keyPrompt:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
				Widget.keyPrompt:setLeftRight(false, true, -f5_local1 - 120, -f5_local1 - 10)
				Widget.keyPrompt:setAlpha(0.5)
				Widget:setAlignment(LUI.Alignment.Right)
				Widget:registerEventHandler("input_source_changed", CoD.DPadSelection.InputSourceChanged)
				Widget:addElement(Widget.keyPrompt)
				if CoD.useController and Engine.LastInput_Gamepad() then
					CoD.DPadSelection.InputSourceChanged(Widget, {
						source = 0
					})
				else
					CoD.DPadSelection.InputSourceChanged(Widget, {
						source = 1
					})
				end
			end
		end
	end
	local f5_local16 = 25
	f5_local1 = f5_local16 * f5_arg3
	Widget:addElement(LUI.UIImage.new({
		left = -f5_local1 / 2 + 5,
		top = -f5_local16 / 2,
		right = f5_local1 / 2 + 5,
		bottom = f5_local16 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = CoD.HUDBaseColor.r,
		green = CoD.HUDBaseColor.g,
		blue = CoD.HUDBaseColor.b,
		alpha = alpha,
		material = f5_arg2
	}))
	local f5_local15 = LUI.UIText.new({
		left = 0,
		top = -CoD.textSize.Default - 10,
		right = 0,
		bottom = -10,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = 1,
		green = 1,
		blue = 1,
		alpha = CoD.HUDAlphaFull
	})
	f5_local15:setText(f5_arg4)
	f5_local15:setAlignment(LUI.Alignment.Left)
	Widget:addElement(f5_local15)
	return Widget
end

CoD.DPadSelection.UpdateVisibility = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.controller
	if UIExpression.IsVisibilityBitSet(f6_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f6_local0, CoD.BIT_EMP_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f6_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and UIExpression.IsVisibilityBitSet(f6_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(f6_local0, CoD.BIT_IN_VEHICLE) == 0 and UIExpression.IsVisibilityBitSet(f6_local0, CoD.BIT_IN_GUIDED_MISSILE) == 0 and UIExpression.IsVisibilityBitSet(f6_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0 and UIExpression.IsVisibilityBitSet(f6_local0, CoD.BIT_AMMO_COUNTER_HIDE) == 0 and UIExpression.IsVisibilityBitSet(f6_local0, CoD.BIT_IS_FLASH_BANGED) == 0 and UIExpression.IsVisibilityBitSet(f6_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f6_local0, CoD.BIT_SCOREBOARD_OPEN) == 0 and UIExpression.IsVisibilityBitSet(f6_local0, CoD.BIT_IS_SCOPED) == 0 and (not CoD.IsShoutcaster(f6_local0) or CoD.ExeProfileVarBool(f6_local0, "shoutcaster_scorestreaks") and Engine.IsSpectatingActiveClient(f6_local0)) and CoD.FSM_VISIBILITY(f6_local0) == 0 then
		if f6_arg0.visible ~= true then
			f6_arg0:setAlpha(1)
			f6_arg0.visible = true
		end
	elseif f6_arg0.visible == true then
		f6_arg0:setAlpha(0)
		f6_arg0.visible = nil
	end
	f6_arg0:dispatchEventToChildren(f6_arg1)
end

CoD.DPadSelection.SetKeyBind = function (f7_arg0)
	local f7_local0, f7_local1 = nil
	if f7_arg0.keyPrompt ~= nil and f7_arg0.direction ~= nil then
		if f7_arg0.direction == "right" then
			f7_local1 = "+actionslot 4"
		elseif f7_arg0.direction == "left" then
			f7_local1 = "+actionslot 3"
		elseif f7_arg0.direction == "up" then
			f7_local1 = "+actionslot 1"
		elseif f7_arg0.direction == "down" then
			f7_local1 = "+actionslot 2"
		end
		if f7_local1 ~= nil then
			f7_arg0.keyPrompt:setText(Engine.GetKeyBindingLocalizedString(0, f7_local1, 0))
		end
	end
end

CoD.DPadSelection.InputSourceChanged = function (f8_arg0, f8_arg1)
	if CoD.isPC then
		if CoD.useController and f8_arg1.source == 0 then
			if f8_arg0.keyPrompt ~= nil then
				f8_arg0.keyPrompt:setAlpha(0)
			end
			if f8_arg0.arrow ~= nil then
				f8_arg0.arrow:setAlpha(1)
			end
		else
			CoD.DPadSelection.SetKeyBind(f8_arg0)
			if f8_arg0.keyPrompt ~= nil then
				f8_arg0.keyPrompt:setAlpha(1)
			end
			if f8_arg0.arrow ~= nil then
				f8_arg0.arrow:setAlpha(0)
			end
		end
	end
end

