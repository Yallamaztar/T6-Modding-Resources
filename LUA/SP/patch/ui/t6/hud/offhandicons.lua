CoD.OffhandIcons = {}
CoD.OffhandIcons.LethalOffset = -24
CoD.OffhandIcons.LethalDockOffset = -33
CoD.OffhandIcons.TacticalOffset = -34
CoD.OffhandIcons.Size = 25
CoD.OffhandIcons.AltFireOffset = -220
CoD.OffhandIcons.AltFireDockOffset = -66
CoD.OffhandIcons.BracketWidth = CoD.OffhandIcons.Size
CoD.OffhandIcons.BracketHeight = CoD.OffhandIcons.Size
CoD.OffhandIcons.Spacing = 0.25
CoD.OffhandIcons.AlphaMultiplier = 0.75
CoD.OffhandIcons.DefaultAlpha = 1
CoD.OffhandIcons.Width = 67
CoD.OffhandIcons.EightiesWidth = 72
CoD.OffhandIcons.BracketMaterialName = "menu_vis_bracket_skew_small"
CoD.OffhandIcons.BracketOffset = 8
CoD.OffhandIcons.BootupAppearDuration = 500
CoD.OffhandIcons.BootupExpandDuration = 500
CoD.OffhandIcons.BootupShrinkDuration = 500
CoD.OffhandIcons.BootupDockDuration = 500
CoD.OffhandIcons.BracketColorValue = 0.3
CoD.OffhandIcons.BracketFrontendColorValue = 0.1
CoD.OffhandIcons.MaxBottomOffset = -50
CoD.OffhandIcons.DefaultStyle = "twenties"
CoD.OffhandIcons.EightiesAlpha = 1
CoD.OffhandIcons.EightiesBacking_Medium = "hud_sp_rectangle_mid_80s"
CoD.OffhandIcons.EightiesBacking_Small = "hud_sp_rectangle_small_80s"
CoD.OffhandIcons.new = function (f1_arg0)
	local Widget = nil
	local f1_local1, f1_local2 = Engine.GetUserSafeArea()
	local f1_local3 = math.min((f1_local2 - 720) / 2, CoD.OffhandIcons.MaxBottomOffset)
	Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = CoD.OffhandIcons.BracketWidth,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.OffhandIcons.BracketHeight
	})
	Widget.twentiesExpand = {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = CoD.OffhandIcons.Width,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.OffhandIcons.BracketHeight
	}
	Widget.eightiesExpand = {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = CoD.OffhandIcons.EightiesWidth,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.OffhandIcons.BracketHeight + 8
	}
	Widget:registerAnimationState("expand", Widget.twentiesExpand)
	Widget:registerAnimationState("dock", {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = CoD.OffhandIcons.BracketWidth
	})
	Widget:registerAnimationState("appear", {
		alpha = CoD.OffhandIcons.DefaultAlpha
	})
	Widget:registerAnimationState("disappear", {
		alpha = 0
	})
	Widget:animateToState("disappear")
	Widget:registerEventHandler("bootup_appear", CoD.OffhandIcons.BootupAppear)
	Widget:registerEventHandler("bootup_expand", CoD.OffhandIcons.BootupExpand)
	Widget:registerEventHandler("bootup_shrink", CoD.OffhandIcons.BootupShrink)
	Widget:registerEventHandler("bootup_dock", CoD.OffhandIcons.BootupDock)
	Widget:registerEventHandler("bootup_switch_to_hud", CoD.OffhandIcons.BootupSwitchToHUD)
	Widget:registerEventHandler("bootup_sequence", CoD.OffhandIcons.BootupSequence)
	Widget:registerEventHandler("update_style", CoD.OffhandIcons.UpdateStyle)
	Widget.background = LUI.UIImage.new()
	Widget.background:setLeftRight(true, true, 0, 0)
	Widget.background:setTopBottom(true, true, 0, 0)
	Widget.background:setAlpha(0)
	Widget:addElement(Widget.background)
	Widget.bracketContainer = LUI.UIElement.new()
	Widget.bracketContainer:setLeftRight(true, true, 0, 0)
	Widget.bracketContainer:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget.bracketContainer)
	Widget.leftBracket = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = false,
		left = -CoD.OffhandIcons.BracketOffset,
		right = -CoD.OffhandIcons.BracketOffset + CoD.OffhandIcons.Size,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.OffhandIcons.Size / 2,
		bottom = CoD.OffhandIcons.Size / 2,
		material = RegisterMaterial(CoD.OffhandIcons.BracketMaterialName),
		zRot = 180,
		red = CoD.OffhandIcons.BracketColorValue,
		green = CoD.OffhandIcons.BracketColorValue,
		blue = CoD.OffhandIcons.BracketColorValue,
		alpha = CoD.AmmoCounter.BracketAlpha
	})
	Widget.bracketContainer:addElement(Widget.leftBracket)
	Widget.leftBracket:registerAnimationState("dim", {
		red = CoD.OffhandIcons.BracketFrontendColorValue,
		green = CoD.OffhandIcons.BracketFrontendColorValue,
		blue = CoD.OffhandIcons.BracketFrontendColorValue
	})
	Widget.leftBracket:registerAnimationState("fade_out", {
		alpha = 0
	})
	Widget.rightBracket = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = true,
		left = CoD.OffhandIcons.BracketOffset - CoD.OffhandIcons.Size,
		right = CoD.OffhandIcons.BracketOffset,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.OffhandIcons.Size / 2,
		bottom = CoD.OffhandIcons.Size / 2,
		material = RegisterMaterial(CoD.OffhandIcons.BracketMaterialName),
		red = CoD.OffhandIcons.BracketColorValue,
		green = CoD.OffhandIcons.BracketColorValue,
		blue = CoD.OffhandIcons.BracketColorValue,
		alpha = CoD.AmmoCounter.BracketAlpha
	})
	Widget.bracketContainer:addElement(Widget.rightBracket)
	Widget.rightBracket:registerAnimationState("dim", {
		red = CoD.OffhandIcons.BracketFrontendColorValue,
		green = CoD.OffhandIcons.BracketFrontendColorValue,
		blue = CoD.OffhandIcons.BracketFrontendColorValue
	})
	Widget.rightBracket:registerAnimationState("fade_out", {
		alpha = 0
	})
	Widget.currentStyle = CoD.OffhandIcons.DefaultStyle
	Widget.type = f1_arg0
	Widget.setMaterialAndQuantity = CoD.OffhandIcons.SetMaterialAndQuantity
	if f1_arg0 == "altfire" and not Widget.arrow then
		local f1_local4 = 28
		local f1_local5 = 56
		local f1_local6 = CoD.OffhandIcons.BracketWidth + 15
		Widget.arrow = LUI.UIImage.new()
		Widget.arrow:setLeftRight(true, false, -f1_local6, f1_local5 - f1_local6)
		Widget.arrow:setTopBottom(false, false, -f1_local4 / 2, f1_local4 / 2)
		Widget.arrow:setImage(RegisterMaterial("hud_mp_vis_ks_dpad_arrow"))
		Widget.arrow:setZRot(180)
		Widget:addElement(Widget.arrow)
		if CoD.isPC then
			Widget.altFireKeyPrompt = LUI.UIText.new()
			Widget.altFireKeyPrompt:setLeftRight(false, true, -2 * f1_local6 - 160, -2 * f1_local6)
			Widget.altFireKeyPrompt:setTopBottom(false, false, -(CoD.textSize.Default - 4) / 2, (CoD.textSize.Default - 4) / 2)
			Widget.altFireKeyPrompt:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
			Widget.altFireKeyPrompt:setFont(CoD.fonts.Condensed)
			Widget.altFireKeyPrompt:setAlignment(LUI.Alignment.Right)
			Widget:addElement(Widget.altFireKeyPrompt)
			Widget:registerEventHandler("input_source_changed", CoD.OffhandIcons.InputSourceChanged)
			if CoD.useController and Engine.LastInput_Gamepad() then
				CoD.OffhandIcons.InputSourceChanged(Widget, {
					source = 0
				})
			else
				CoD.OffhandIcons.InputSourceChanged(Widget, {
					source = 1
				})
			end
		end
	end
	return Widget
end

CoD.OffhandIcons.UpdateStyle = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.style
	if f2_local0 == nil then
		f2_local0 = CoD.OffhandIcons.DefaultStyle
		f2_arg1.style = f2_local0
	end
	if f2_arg0.currentStyle == f2_local0 then
		return 
	elseif f2_local0 == "eighties" then
		f2_arg0:registerAnimationState("expand", f2_arg0.eightiesExpand)
		f2_arg0.background:setAlpha(CoD.OffhandIcons.EightiesAlpha)
		f2_arg0.bracketContainer:setAlpha(0)
	else
		f2_arg0:registerAnimationState("expand", f2_arg0.twentiesExpand)
		f2_arg0.background:setAlpha(0)
		f2_arg0.bracketContainer:setAlpha(1)
	end
	f2_arg0.currentStyle = f2_local0
end

CoD.OffhandIcons.HUDUpdateVehicle = function (f3_arg0, f3_arg1)

end

CoD.OffhandIcons.HUDMissileFire = function (f4_arg0, f4_arg1)
	if f4_arg0.f35Text then
		f4_arg0.f35Text:animateToState("hide")
		f4_arg0.f35Text:animateToState("show", 1000)
	end
end

CoD.OffhandIcons.SetMaterialAndQuantity = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	local f5_local0 = nil
	if f5_arg0.icons == nil then
		f5_local0 = {}
		f5_arg0.icons = f5_local0
	else
		f5_local0 = f5_arg0.icons
	end
	if f5_arg3 == nil then
		f5_arg3 = 1
	end
	local f5_local1 = CoD.OffhandIcons.Size
	local f5_local2 = f5_local1 * f5_arg3
	local f5_local3 = f5_local2 * CoD.OffhandIcons.Spacing
	local f5_local4 = -CoD.OffhandIcons.Width / 2 + (f5_local2 + f5_local3 * (f5_arg2 - 1)) / 2
	local f5_local5 = CoD.OffhandIcons.AlphaMultiplier
	local f5_local6 = CoD.HUDAlphaFull * math.pow(f5_local5, f5_arg2 - 1)
	for f5_local7 = 1, f5_arg2, 1 do
		local f5_local10 = f5_local0[f5_local7]
		local f5_local11 = CoD.HUDAlphaFull * f5_local7 / f5_arg2
		local f5_local12 = {
			left = f5_local4 - f5_local2,
			top = -f5_local1 / 2,
			right = f5_local4,
			bottom = f5_local1 / 2,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = false,
			red = CoD.HUDBaseColor.r,
			green = CoD.HUDBaseColor.g,
			blue = CoD.HUDBaseColor.b,
			alpha = f5_local11,
			material = f5_arg1
		}
		if f5_local10 ~= nil then
			f5_local10:registerAnimationState("default", f5_local12)
			f5_local10:animateToState("default")
		else
			f5_local10 = LUI.UIImage.new(f5_local12)
			f5_local0[f5_local7] = f5_local10
			f5_arg0:addElement(f5_local10)
		end
		f5_local10:registerAnimationState("hide", {
			alpha = 0
		})
		f5_local10:registerAnimationState("show", {
			alpha = f5_local11
		})
		if CoD.ShadesHud.InScriptedAnimation == true then
			f5_local10:animateToState("hide")
		end
		f5_local4 = f5_local4 - f5_local3
		f5_local6 = f5_local6 / f5_local5
	end
	local f5_local7 = #f5_local0
	for f5_local8 = f5_arg2 + 1, f5_local7, 1 do
		f5_local0[f5_local8]:close()
		f5_local0[f5_local8] = nil
	end
end

CoD.OffhandIcons.UpdateOffhand = function (f6_arg0, f6_arg1)
	if f6_arg0.type == "altfire" then
		return 
	end
	local f6_local0 = f6_arg1[f6_arg0.type]
	if f6_local0 == nil then
		f6_arg0:setMaterialAndQuantity(nil, 0)
	else
		f6_arg0:setMaterialAndQuantity(f6_local0.material, f6_local0.ammo, f6_local0.aspectRatio)
	end
end

CoD.OffhandIcons.UpdateActionSlots = function (f7_arg0, f7_arg1)
	if f7_arg0.type ~= "altfire" then
		return 
	end
	local f7_local0 = CoD.HUD.DPadOrder.left
	local f7_local1 = f7_arg1.actionSlotData
	if f7_local1[f7_local0] then
		local f7_local2 = f7_local1[f7_local0]
		f7_arg0:setMaterialAndQuantity(f7_local2.material, 1, f7_local2.aspectRatio)
		f7_arg0:setAlpha(1)
	else
		f7_arg0:setAlpha(0)
	end
end

CoD.OffhandIcons.BootupAppear = function (f8_arg0, f8_arg1)
	f8_arg0:animateToState("appear", CoD.OffhandIcons.BootupAppearDuration)
end

CoD.OffhandIcons.BootupExpand = function (f9_arg0, f9_arg1)
	f9_arg0:animateToState("expand", CoD.OffhandIcons.BootupExpandDuration, true, true)
end

CoD.OffhandIcons.BootupShrink = function (f10_arg0, f10_arg1)
	f10_arg0:animateToState("default", CoD.OffhandIcons.BootupShrinkDuration, true, true)
end

CoD.OffhandIcons.BootupDock = function (f11_arg0, f11_arg1)
	f11_arg0:animateToState("dock", CoD.OffhandIcons.BootupDockDuration, true, true)
end

CoD.OffhandIcons.BootupSequence = function (f12_arg0, f12_arg1)
	f12_arg0:animateToState("default")
	f12_arg0:animateToState("appear", CoD.AmmoCounter.BootupExpandDuration)
	local f12_local0 = CoD.AmmoCounter.BootupExpandDuration
	if f12_arg0.type == "tactical" then
		f12_arg0:addElement(LUI.UITimer.new(f12_local0, "bootup_expand", true, f12_arg0))
	end
	f12_local0 = f12_local0 + CoD.OffhandIcons.BootupExpandDuration / 2
	if f12_arg0.type == "lethal" then
		f12_arg0:addElement(LUI.UITimer.new(f12_local0, "bootup_expand", true, f12_arg0))
	end
	f12_local0 = f12_local0 + CoD.OffhandIcons.BootupExpandDuration / 2
	if f12_arg0.type == "tactical" then
		f12_arg0:addElement(LUI.UITimer.new(f12_local0, "bootup_shrink", true, f12_arg0))
	end
	f12_local0 = f12_local0 + CoD.AmmoCounter.BootupShrinkDuration / 2
	if f12_arg0.type == "lethal" then
		f12_arg0:addElement(LUI.UITimer.new(f12_local0, "bootup_shrink", true, f12_arg0))
	end
	f12_local0 = f12_local0 + CoD.AmmoCounter.BootupShrinkDuration / 2
	if f12_arg0.type == "tactical" then
		f12_arg0:addElement(LUI.UITimer.new(f12_local0, "bootup_dock", true, f12_arg0))
	end
end

CoD.OffhandIcons.BootupSwitchToHUD = function (f13_arg0, f13_arg1)
	f13_arg0:animateToState("appear")
	if f13_arg1.isFrontEnd ~= true then
		f13_arg0:animateToState("expand")
	else
		f13_arg0.leftBracket:animateToState("dim")
		f13_arg0.rightBracket:animateToState("dim")
		if f13_arg0.type == "tactical" then
			f13_arg0:animateToState("dock")
		end
		f13_arg0.leftBracket:animateToState("fade_out", 250)
		f13_arg0.rightBracket:animateToState("fade_out", 250)
	end
	if f13_arg0.type == "altfire" then
		f13_arg0:registerEventHandler("hud_update_actionslots", CoD.OffhandIcons.UpdateActionSlots)
	else
		f13_arg0:registerEventHandler("hud_update_offhand", CoD.OffhandIcons.UpdateOffhand)
	end
end

CoD.OffhandIcons.SetKeyBind = function (f14_arg0)
	local f14_local0, f14_local1 = nil
	if f14_arg0.altFireKeyPrompt ~= nil then
		f14_local1 = "+actionslot 3"
		if f14_local1 ~= nil then
			f14_arg0.altFireKeyPrompt:setText(Engine.GetKeyBindingLocalizedString(0, f14_local1, 0))
		end
	end
end

CoD.OffhandIcons.InputSourceChanged = function (f15_arg0, f15_arg1)
	if CoD.isPC then
		if CoD.useController and f15_arg1.source == 0 then
			if f15_arg0.altFireKeyPrompt ~= nil then
				f15_arg0.altFireKeyPrompt:setAlpha(0)
			end
			if f15_arg0.arrow ~= nil then
				f15_arg0.arrow:setAlpha(1)
			end
		else
			CoD.OffhandIcons.SetKeyBind(f15_arg0)
			if f15_arg0.altFireKeyPrompt ~= nil then
				f15_arg0.altFireKeyPrompt:setAlpha(1)
			end
			if f15_arg0.arrow ~= nil then
				f15_arg0.arrow:setAlpha(0)
			end
		end
	end
end

