require("T6.HUD.OffhandIcons")
CoD.DPadArea = {}
CoD.DPadArea.CircleSize = 128
CoD.DPadArea.InterlacedLinesWidth = 512
CoD.DPadArea.InterlacedLinesHeight = 256
CoD.DPadArea.DPadImageSize = 80
CoD.DPadArea.RewardIconBackgroundBottomColor = {
	r = 0.5,
	g = 0.5,
	b = 0.5
}
CoD.DPadArea.RewardIconBackgroundSize = 64
CoD.DPadArea.RewardIconBackgroundAlpha = 0.7
CoD.DPadArea.RewardIconBackgroundOffset = 40
CoD.DPadArea.RewardIconBackgroundColor = CoD.blue
CoD.DPadArea.RewardIconBackgroundStreakColor = CoD.yellowGlow
CoD.DPadArea.RewardIconOffset = 5
CoD.DPadArea.RewardIconSize = 64
CoD.DPadArea.RewardIconDisabledAlpha = 1
CoD.DPadArea.RewardIconEnabledAlpha = 1
CoD.DPadArea.RewardIconColor = {
	r = 1,
	g = 1,
	b = 1
}
CoD.DPadArea.RewardMeterOffset = 11 * CoD.DPadArea.CircleSize / 128
CoD.DPadArea.RewardMeterSize = 128
CoD.DPadArea.RewardMeterEmptyAlpha = 0.1
CoD.DPadArea.RewardSegmentAspectRatio = 1.6
CoD.DPadArea.InventoryAnimationDuration = 250
CoD.DPadArea.MomentumMeterGradientLength = 6
CoD.DPadArea.MomentumMeterThickness = 0.15
CoD.DPadArea.MomentumMeterEdgeHarshness = 50
CoD.DPadArea.RewardOpenDuration = 50
CoD.DPadArea.StickThreshold = 0.5
CoD.DPadArea.ArrowColor = {
	r = 1,
	g = 1,
	b = 1
}
CoD.DPadArea.RampageColor = CoD.orange
CoD.DPadArea.RewardCostOffset = 23
CoD.DPadArea.RewardCostFont = "Default"
CoD.DPadArea.RewardFont = "Morris"
CoD.DPadArea.RampageSplashSize = 256
CoD.DPadArea.RampageMaxAlpha = 1
CoD.DPadArea.RampagePulseTime = 800
CoD.DPadArea.QuantityTextSize = CoD.textSize.Condensed
CoD.DPadArea.QuantityFont = CoD.fonts.Condensed
CoD.DPadArea.new = function (f1_arg0, f1_arg1, f1_arg2)
	if CoD.DPadArea.InterlacedLinesMaterial == nil then
		CoD.DPadArea.InterlacedLinesMaterial = RegisterMaterial("hud_lui_bottomright_rez")
	end
	if CoD.DPadArea.CircleBackgroundMaterial == nil then
		CoD.DPadArea.CircleBackgroundMaterial = RegisterMaterial("hud_lui_dpad_circle")
	end
	if CoD.DPadArea.RewardMeterBracketShadowMaterial == nil then
		CoD.DPadArea.RewardMeterBracketShadowMaterial = RegisterMaterial("hud_lui_meter_bracket_shadow")
	end
	if CoD.DPadArea.RewardMeterBracketMaterial == nil then
		CoD.DPadArea.RewardMeterBracketMaterial = RegisterMaterial("hud_lui_meter_bracket")
	end
	if CoD.DPadArea.AmmoBackgroundMaterial == nil then
		CoD.DPadArea.AmmoBackgroundMaterial = RegisterMaterial("hud_lui_ammo")
	end
	if CoD.DPadArea.AmmoBackgroundShadowMaterial == nil then
		CoD.DPadArea.AmmoBackgroundShadowMaterial = RegisterMaterial("hud_lui_ammo_shadow")
	end
	if CoD.DPadArea.ArrowMaterial == nil then
		CoD.DPadArea.ArrowMaterial = RegisterMaterial("hud_lui_arrow_global")
	end
	local Widget = LUI.UIElement.new(f1_arg1)
	Widget:registerAnimationState("hide", {
		alphaMultiplier = 0
	})
	Widget:registerAnimationState("show", {
		alphaMultiplier = 1
	})
	Widget:animateToState("hide")
	Widget:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		material = CoD.DPadArea.CircleBackgroundMaterial
	}))
	local f1_local1 = -30
	Widget:addElement(LUI.UIImage.new({
		left = f1_local1,
		top = 0,
		right = f1_local1 + CoD.DPadArea.CircleSize,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		material = CoD.DPadArea.RewardMeterBracketShadowMaterial
	}))
	if f1_arg2 == nil then
		local f1_local2 = 128
		local rewardMeter = 128
		local f1_local4 = 12
		local f1_local5 = f1_local1 - 87
		Widget:addElement(LUI.UIImage.new({
			left = f1_local5,
			top = f1_local4 - rewardMeter,
			right = f1_local5 + f1_local2,
			bottom = f1_local4,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = true,
			green = 0,
			blue = 0,
			material = CoD.DPadArea.AmmoBackgroundShadowMaterial
		}))
		Widget:addElement(CoD.AmmoCounter.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true
		}))
		local f1_local6 = -70
		local f1_local7 = -131
		Widget:addElement(CoD.WeaponLabel.new({
			left = f1_local7 - 100,
			top = f1_local6 - CoD.WeaponLabel.TextHeight,
			right = f1_local7,
			bottom = f1_local6,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true
		}))
		local f1_local8 = -128
		local inventoryWeapon = -1
		Widget:addElement(CoD.OffhandIcons.new("lethal", {
			left = f1_local8 - CoD.OffhandIcons.Width,
			top = inventoryWeapon - CoD.OffhandIcons.Size,
			right = f1_local8,
			bottom = inventoryWeapon,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true
		}))
		Widget:addElement(CoD.OffhandIcons.new("tactical", {
			left = f1_local8 - CoD.OffhandIcons.Width * 2,
			top = inventoryWeapon - CoD.OffhandIcons.Size,
			right = f1_local8 - CoD.OffhandIcons.Width,
			bottom = inventoryWeapon,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true
		}))
	end
	local f1_local2 = 116
	
	local rewardMeter = LUI.UIImage.new({
		left = -f1_local2 / 2,
		top = -f1_local2 / 2,
		right = f1_local2 / 2,
		bottom = f1_local2 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		material = RegisterMaterial("hud_momentum_meter"),
		shaderVector0 = {
			0,
			CoD.DPadArea.MomentumMeterGradientLength,
			CoD.DPadArea.MomentumMeterThickness,
			CoD.DPadArea.MomentumMeterEdgeHarshness
		},
		shaderVector1 = {
			-1,
			-1,
			-1,
			-1
		},
		shaderVector2 = {
			0,
			0,
			0,
			0
		}
	})
	Widget:addElement(rewardMeter)
	Widget.rewardMeter = rewardMeter
	
	Widget.currentMomentum = 0
	Widget:addElement(LUI.UIImage.new({
		left = f1_local1,
		top = 0,
		right = f1_local1 + CoD.DPadArea.CircleSize,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		material = CoD.DPadArea.RewardMeterBracketMaterial
	}))
	Widget.carouselArrows = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget:addElement(Widget.carouselArrows)
	local f1_local5 = 8
	local f1_local10 = 8
	local f1_local11 = 4
	Widget.carouselArrows:addElement(LUI.UIImage.new({
		left = -f1_local5 / 2,
		top = -f1_local11 - f1_local10,
		right = f1_local5 / 2,
		bottom = -f1_local11,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = CoD.DPadArea.ArrowColor.r,
		green = CoD.DPadArea.ArrowColor.g,
		blue = CoD.DPadArea.ArrowColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.DPadArea.ArrowMaterial
	}))
	Widget.carouselArrows:addElement(LUI.UIImage.new({
		left = -f1_local5 / 2,
		top = f1_local11,
		right = f1_local5 / 2,
		bottom = f1_local11 + f1_local10,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = CoD.DPadArea.ArrowColor.r,
		green = CoD.DPadArea.ArrowColor.g,
		blue = CoD.DPadArea.ArrowColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.DPadArea.ArrowMaterial,
		zRot = 180
	}))
	Widget.carouselArrows:addElement(LUI.UIImage.new({
		left = -f1_local11 - f1_local10 / 2 - f1_local5 / 2,
		top = -f1_local10 / 2,
		right = -f1_local11 - f1_local10 / 2 + f1_local5 / 2,
		bottom = f1_local10 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = CoD.DPadArea.ArrowColor.r,
		green = CoD.DPadArea.ArrowColor.g,
		blue = CoD.DPadArea.ArrowColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.DPadArea.ArrowMaterial,
		zRot = 90
	}))
	Widget.carouselArrows:addElement(LUI.UIImage.new({
		left = f1_local11 + f1_local10 / 2 - f1_local5 / 2,
		top = -f1_local10 / 2,
		right = f1_local11 + f1_local10 / 2 + f1_local5 / 2,
		bottom = f1_local10 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		red = CoD.DPadArea.ArrowColor.r,
		green = CoD.DPadArea.ArrowColor.g,
		blue = CoD.DPadArea.ArrowColor.b,
		alpha = CoD.HUDAlphaFull,
		material = CoD.DPadArea.ArrowMaterial,
		zRot = -90
	}))
	local f1_local8 = 3
	
	local inventoryWeapon = LUI.UIElement.new({
		left = 0,
		top = f1_local8 - CoD.DPadArea.RewardIconSize,
		right = CoD.DPadArea.CircleSize / 2,
		bottom = f1_local8,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		alpha = 0
	})
	inventoryWeapon:registerAnimationState("show", {
		alpha = 1
	})
	Widget:addElement(inventoryWeapon)
	Widget.inventoryWeapon = inventoryWeapon
	
	local inventoryWeaponIcon = LUI.UIImage.new({
		left = -CoD.DPadArea.RewardIconSize / 2,
		top = 10,
		right = CoD.DPadArea.RewardIconSize / 2,
		bottom = 10 + CoD.DPadArea.RewardIconSize,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		alpha = CoD.DPadArea.RewardIconEnabledAlpha
	})
	inventoryWeapon:addElement(inventoryWeaponIcon)
	Widget.inventoryWeaponIcon = inventoryWeaponIcon
	
	local f1_local13 = CoD.DistFieldText.new({
		left = -1,
		top = -2,
		right = 1,
		bottom = 16,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	}, nil, nil, -1, -1, 0.1)
	f1_local13:setText(Engine.Localize("MPUI_HINT_INVENTORY_CAPS", UIExpression.KeyBinding(f1_arg0, "+weapnext_inventory")))
	inventoryWeapon:addElement(f1_local13)
	local f1_local14 = 32
	Widget:addElement(LUI.UIImage.new({
		left = -CoD.DPadArea.InterlacedLinesWidth,
		top = f1_local14 - CoD.DPadArea.InterlacedLinesHeight,
		right = 0,
		bottom = f1_local14,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		material = CoD.DPadArea.InterlacedLinesMaterial
	}))
	Widget.visible = true
	Widget:registerEventHandler("hud_update_refresh", CoD.DPadArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.DPadArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.DPadArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.DPadArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.DPadArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.DPadArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC, CoD.DPadArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_AMMO_COUNTER_HIDE, CoD.DPadArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_FLASH_BANGED, CoD.DPadArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.DPadArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.DPadArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.DPadArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_actionslots", CoD.DPadArea.UpdateActionSlots)
	Widget:registerEventHandler("hud_update_inventory_weapon", CoD.DPadArea.UpdateInventoryWeapon)
	Widget:registerEventHandler("score", CoD.DPadArea.Score)
	return Widget
end

CoD.DPadArea.UpdateVisibility = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_EMP_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_VEHICLE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_GUIDED_MISSILE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_AMMO_COUNTER_HIDE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_FLASH_BANGED) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_SCOREBOARD_OPEN) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_SPECTATING_CLIENT) == 0 and CoD.FSM_VISIBILITY(f2_local0) == 0 then
		if f2_arg0.visible ~= true then
			f2_arg0:animateToState("show")
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible == true then
		f2_arg0:animateToState("hide")
		f2_arg0.visible = nil
	end
	f2_arg0:dispatchEventToChildren(f2_arg1)
end

CoD.DPadArea.UpdateActionSlots = function (f3_arg0, f3_arg1)
	if f3_arg0.actionSlots == nil then
		f3_arg0.actionSlots = {}
	else
		for f3_local3, f3_local4 in pairs(f3_arg0.actionSlots) do
			f3_local4:close()
		end
		f3_arg0.actionSlots = {}
	end
	for f3_local4, f3_local8 in pairs(f3_arg1.actionSlotData) do
		local f3_local9 = CoD.DPadArea.CircleSize / 4
		local f3_local10 = f3_local9 * f3_local8.aspectRatio
		local f3_local5 = nil
		if f3_local8.ammo > 0 then
			f3_local5 = CoD.HUDAlphaFull
		else
			f3_local5 = CoD.HUDAlphaEmpty
		end
		local Widget = nil
		if f3_local4 == 1 then
			Widget = LUI.UIElement.new({
				left = -f3_local10 / 2,
				top = CoD.DPadArea.CircleSize / 4 - f3_local9 / 2,
				right = f3_local10 / 2,
				bottom = CoD.DPadArea.CircleSize / 4 + f3_local9 / 2,
				leftAnchor = false,
				topAnchor = true,
				rightAnchor = false,
				bottomAnchor = false,
				alphaMultiplier = 1
			})
		elseif f3_local4 == 2 then
			Widget = LUI.UIElement.new({
				left = -f3_local10 / 2,
				top = -CoD.DPadArea.CircleSize / 4 - f3_local9 / 2,
				right = f3_local10 / 2,
				bottom = -CoD.DPadArea.CircleSize / 4 + f3_local9 / 2,
				leftAnchor = false,
				topAnchor = false,
				rightAnchor = false,
				bottomAnchor = true,
				alphaMultiplier = 1
			})
		elseif f3_local4 == 3 then
			Widget = LUI.UIElement.new({
				left = CoD.DPadArea.CircleSize / 4 - f3_local10 / 2,
				top = -f3_local9 / 2,
				right = CoD.DPadArea.CircleSize / 4 + f3_local10 / 2,
				bottom = f3_local9 / 2,
				leftAnchor = true,
				topAnchor = false,
				rightAnchor = false,
				bottomAnchor = false,
				alphaMultiplier = 1
			})
		elseif f3_local4 == 4 then
			Widget = LUI.UIElement.new({
				left = -CoD.DPadArea.CircleSize / 4 - f3_local10 / 2,
				top = -f3_local9 / 2,
				right = -CoD.DPadArea.CircleSize / 4 + f3_local10 / 2,
				bottom = f3_local9 / 2,
				leftAnchor = false,
				topAnchor = false,
				rightAnchor = true,
				bottomAnchor = false
			})
		end
		if Widget ~= nil then
			f3_arg0:addElement(Widget)
			f3_arg0.actionSlots[f3_local4] = Widget
			Widget:addElement(LUI.UIImage.new({
				left = 0,
				top = 0,
				right = 0,
				bottom = 0,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = true,
				bottomAnchor = true,
				red = CoD.HUDBaseColor.r,
				green = CoD.HUDBaseColor.g,
				blue = CoD.HUDBaseColor.b,
				alpha = f3_local5,
				material = f3_local8.material
			}))
			local f3_local7 = LUI.UIText.new({
				left = -10,
				top = -CoD.textSize.Default / 2,
				right = 10,
				bottom = CoD.textSize.Default / 2,
				leftAnchor = false,
				topAnchor = false,
				rightAnchor = false,
				bottomAnchor = false,
				red = 1,
				green = 1,
				blue = 1,
				alpha = CoD.HUDAlphaFull
			})
			f3_local7:setText(f3_local8.ammo)
			Widget:addElement(f3_local7)
		end
	end
end

CoD.DPadArea.UpdateInventoryWeapon = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.inventoryWeapon
	local f4_local1 = nil
	if f4_arg1.teleported ~= true then
		f4_local1 = CoD.DPadArea.InventoryAnimationDuration
	end
	if f4_arg1.materialName ~= nil then
		local f4_local2 = f4_arg0.inventoryWeaponIcon
		f4_local2:registerAnimationState("default", {
			material = f4_arg1.material
		})
		f4_local2:animateToState("default")
		f4_local0:animateToState("show", f4_local1)
	else
		f4_local0:animateToState("default", f4_local1)
	end
end

