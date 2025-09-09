require("T6.CoDBase")
CoD.RewardSelection = {}
CoD.RewardSelection.SelectorSideLength = 64
CoD.RewardSelection.HeightOffset = -96
CoD.RewardSelection.Spacing = -28
CoD.RewardSelection.RewardCount = 3
CoD.RewardSelection.RewardInventoryCount = 1
CoD.RewardSelection.RewardTotalCount = CoD.RewardSelection.RewardCount + CoD.RewardSelection.RewardInventoryCount
CoD.RewardSelection.ArrowMaterial = nil
CoD.RewardSelection.Arrow = {}
CoD.RewardSelection.Arrow.r = 0.9
CoD.RewardSelection.Arrow.g = 0.9
CoD.RewardSelection.Arrow.b = 0.1
CoD.RewardSelection.InventoryAnimationDuration = 250
CoD.RewardSelection.DisabledAlpha = 0.35
CoD.RewardSelection.ProgressBarTop = 6
CoD.RewardSelection.ProgressBarRight = -52
CoD.RewardSelection.RewardGainedFocusEvent = {
	name = "reward_gained_focus"
}
CoD.RewardSelection.FontName = "Default"
CoD.RewardSelection.textBottom = -100
CoD.RewardSelection.textLeft = -100
CoD.RewardSelection.RewardSelectionDelay = 1000
CoD.RewardSelection.RewardSelectionFadeout = 250
LUI.createMenu.RewardSelection = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("RewardSelection", f1_arg0)
	f1_local0:setOwner(f1_arg0)
	f1_local0.rewards = {}
	f1_local0.scaleContainer = CoD.SplitscreenScaler.new(nil, CoD.SplitscreenMultiplier)
	f1_local0.scaleContainer:setLeftRight(false, true, 0, 0)
	f1_local0.scaleContainer:setTopBottom(false, true, 0, 0)
	f1_local0:addElement(f1_local0.scaleContainer)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	f1_local0.scaleContainer:addElement(Widget)
	f1_local0.alphaController = Widget
	local f1_local2 = 0
	local f1_local3 = LUI.UIVerticalList.new({
		left = f1_local2 - CoD.RewardSelection.SelectorSideLength,
		top = -30 + CoD.RewardSelection.HeightOffset - (CoD.RewardSelection.SelectorSideLength + CoD.RewardSelection.Spacing) * CoD.RewardSelection.RewardTotalCount,
		right = f1_local2,
		bottom = 720,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = CoD.RewardSelection.Spacing
	})
	f1_local0.alphaController:addElement(f1_local3)
	f1_local3.disableWrapping = true
	f1_local3:addNavigationFocusSound("cac_killstreak_nav")
	f1_local3:addNavigationFailSound("cac_killstreak_blocked")
	local f1_local4 = CoD.RewardSelection.NewSelectorButton(0)
	f1_local4.arrayIndex = 0
	f1_local3:addElement(f1_local4)
	f1_local3:addSpacer(-CoD.RewardSelection.Spacing + 12)
	f1_local0.inventoryReward = f1_local4
	for f1_local5 = 1, CoD.RewardSelection.RewardCount, 1 do
		local f1_local8 = CoD.RewardSelection.NewSelectorButton(f1_local5)
		f1_local8.arrayIndex = f1_local5
		f1_local3:addElement(f1_local8)
		f1_local0.rewards[f1_local5] = f1_local8
	end
	local f1_local5 = CoD.RewardSelection.FontName
	local f1_local6 = CoD.fonts[f1_local5]
	local f1_local7 = CoD.textSize[f1_local5]
	local f1_local9 = LUI.UIText.new()
	f1_local9:setLeftRight(true, true, -1, -1)
	f1_local9:setTopBottom(false, true, CoD.RewardSelection.textBottom - CoD.textSize.Default, CoD.RewardSelection.textBottom)
	f1_local9:setAlpha(1)
	f1_local9:setFont(f1_local6)
	f1_local0.scaleContainer:addElement(f1_local9)
	f1_local0.rewardText = f1_local9
	if not CoD.RewardSelection.ProgressBarMaterial then
		CoD.RewardSelection.ProgressBarMaterial = RegisterMaterial("hud_mp_vis_ks_bar")
		CoD.RewardSelection.ProgressBarBGMaterial = RegisterMaterial("hud_mp_vis_ks_bar_backing")
	end
	f1_local0.progressBarBackground = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = true,
		left = CoD.RewardSelection.ProgressBarRight - 64,
		right = CoD.RewardSelection.ProgressBarRight,
		topAnchor = false,
		bottomAnchor = true,
		top = CoD.RewardSelection.ProgressBarTop + CoD.RewardSelection.HeightOffset - 128,
		bottom = CoD.RewardSelection.ProgressBarTop + CoD.RewardSelection.HeightOffset,
		material = CoD.RewardSelection.ProgressBarBGMaterial
	})
	f1_local0.alphaController:addElement(f1_local0.progressBarBackground)
	f1_local0.progressBarArrow = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		material = RegisterMaterial("hud_mp_vis_ks_prog_arrow"),
		alpha = 0
	})
	f1_local0.alphaController:addElement(f1_local0.progressBarArrow)
	f1_local0.progressBarStencil = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = true,
		left = CoD.RewardSelection.ProgressBarRight - 64,
		right = CoD.RewardSelection.ProgressBarRight,
		topAnchor = false,
		bottomAnchor = true,
		top = CoD.RewardSelection.ProgressBarTop + CoD.RewardSelection.HeightOffset,
		bottom = CoD.RewardSelection.ProgressBarTop + CoD.RewardSelection.HeightOffset
	})
	f1_local0.progressBarStencil:setUseStencil(true)
	f1_local0.progressBarStencil:setAlpha(0)
	f1_local0.alphaController:addElement(f1_local0.progressBarStencil)
	f1_local0.progressBarStencil:addElement(LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -128,
		bottom = 0,
		material = CoD.RewardSelection.ProgressBarMaterial
	}))
	f1_local0.progressBarStencil:registerEventHandler("transition_complete_update_momentum", CoD.RewardSelection.ProgressBar_TransitionCompleteUpdateMomentum)
	f1_local0:registerEventHandler("reward_gained_focus", CoD.RewardSelection.RewardGainedFocus)
	f1_local0:registerEventHandler("hud_update_rewards", CoD.RewardSelection.UpdateRewards)
	f1_local0:registerEventHandler("hud_update_actionslots_ammo", CoD.RewardSelection.UpdateActionSlotsAmmo)
	f1_local0.rewardSelectionList = f1_local3
	f1_local0.visible = true
	f1_local3.visible = true
	f1_local0:registerEventHandler("hud_update_refresh", CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_AMMO_COUNTER_HIDE, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_FLASH_BANGED, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_PLAYER_DEAD, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_HARDCORE, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SELECTING_LOCATION, CoD.RewardSelection.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_inventory_weapon", CoD.RewardSelection.UpdateInventoryWeapon)
	f1_local0:registerEventHandler("hud_update_momentum", CoD.RewardSelection.UpdateMomentum)
	f1_local0:registerEventHandler("reward_selection_done", CoD.RewardSelection.RewardSelectionDone)
	if CoD.isWIIU then
		local f1_local8 = LUI.UIText.new()
		f1_local8:setLeftRight(true, false, -122, 0)
		f1_local8:setTopBottom(true, false, CoD.RewardSelection.textBottom - CoD.textSize.Default - 5, CoD.RewardSelection.textBottom - 5)
		f1_local8:setFont(f1_local6)
		f1_local8:setText("")
		f1_local0.carouselText = f1_local8
		f1_local0.alphaController:addElement(f1_local8)
		f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_CAROUSEL_ACTIVE, CoD.RewardSelection.UpdateVisibility)
	end
	return f1_local0
end

CoD.RewardSelection.NewSelectorButton = function (f2_arg0)
	local f2_local0 = 0
	if f2_arg0 == 1 then
		f2_local0 = -6
	elseif f2_arg0 == 2 then
		f2_local0 = -12
	elseif f2_arg0 == 3 then
		f2_local0 = -18
	elseif f2_arg0 == 4 then
		f2_local0 = -24
	end
	local f2_local1 = LUI.UIButton.new({
		left = f2_local0,
		top = 0,
		right = f2_local0,
		bottom = CoD.RewardSelection.SelectorSideLength,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f2_local1:setAlpha(0)
	f2_local1:clearGainFocusSFX()
	f2_local1:clearActionSFX()
	if not CoD.RewardSelection.SelectorButtonBackgroundBlendMaterial then
		CoD.RewardSelection.SelectorButtonBackgroundBlendMaterial = RegisterMaterial("hud_mp_vis_ks_dpad_box_back")
		CoD.RewardSelection.SelectorButtonBackgroundBlendLitMaterial = RegisterMaterial("hud_mp_vis_ks_dpad_box_back_lit")
	end
	f2_local1.selectorButtonBlend = LUI.UIImage.new()
	f2_local1.selectorButtonBlend:setLeftRight(true, true, 0, 0)
	f2_local1.selectorButtonBlend:setTopBottom(true, true, 0, 0)
	f2_local1.selectorButtonBlend:setImage(CoD.RewardSelection.SelectorButtonBackgroundBlendMaterial)
	f2_local1:addElement(f2_local1.selectorButtonBlend)
	local f2_local2 = {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = 1,
		material = RegisterMaterial("hud_mp_vis_ks_dpad_box")
	}
	f2_local1.selectorButtonBackground = LUI.UIImage.new(f2_local2)
	f2_local1:addElement(f2_local1.selectorButtonBackground)
	local f2_local3 = 64
	f2_local1.selectorButtonImage = LUI.UIImage.new()
	f2_local1.selectorButtonImage:setLeftRight(false, false, -f2_local3 / 2, f2_local3 / 2)
	f2_local1.selectorButtonImage:setTopBottom(false, false, -f2_local3 / 2, f2_local3 / 2)
	f2_local1:addElement(f2_local1.selectorButtonImage)
	f2_local1.brackets = LUI.UIImage.new(f2_local2)
	f2_local1:addElement(f2_local1.brackets)
	f2_local1.brackets:setImage(RegisterMaterial("hud_mp_vis_ks_dpad_bracket"))
	f2_local1.brackets:setAlpha(0)
	if CoD.RewardSelection.ArrowMaterial == nil then
		CoD.RewardSelection.ArrowMaterial = RegisterMaterial("hud_mp_vis_ks_dpad_arrow")
	end
	local f2_local4 = -8
	f2_local1.rightArrow = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = true,
		left = f2_local4,
		right = f2_local4 + 32,
		topAnchor = false,
		bottomAnchor = false,
		top = -16,
		bottom = 16,
		material = CoD.RewardSelection.ArrowMaterial
	})
	f2_local1:addElement(f2_local1.rightArrow)
	f2_local1.rightArrow:setAlpha(0)
	local f2_local5 = 2
	local f2_local6 = 18
	f2_local1.upArrow = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = f2_local5 - 16,
		right = f2_local5 + 16,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local6 - 32,
		bottom = f2_local6,
		material = CoD.RewardSelection.ArrowMaterial,
		zRot = 90
	})
	f2_local1:addElement(f2_local1.upArrow)
	f2_local1.upArrow:setAlpha(0)
	f2_local1.downArrow = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f2_local5 - 16,
		right = -f2_local5 + 16,
		topAnchor = false,
		bottomAnchor = true,
		top = -f2_local6,
		bottom = -f2_local6 + 32,
		material = CoD.RewardSelection.ArrowMaterial,
		zRot = -90
	})
	f2_local1:addElement(f2_local1.downArrow)
	f2_local1.downArrow:setAlpha(0)
	f2_local1:registerEventHandler("gain_focus", RewardSelection_RewardGainFocus)
	f2_local1:registerEventHandler("lose_focus", RewardSelection_RewardLoseFocus)
	f2_local1.handleGamepadButton = RewardSelection_HandleGamepadButton
	return f2_local1
end

function RewardSelection_HandleGamepadButton(f3_arg0, f3_arg1)
	if CoD.isWIIU then
		local f3_local0 = UIExpression.GetControllerType(f3_arg1.controller)
		if (f3_local0 == "remote" or f3_local0 == "classic") and (f3_arg1.tag == nil or f3_arg1.tag ~= "reward") then
			return true
		end
	end
	local f3_local0 = nil
	local f3_local1 = f3_arg0:isInFocus()
	if f3_local1 == 0 then
		f3_local0 = f3_local1
	else
		f3_local1 = f3_arg0.enabled
		if f3_local1 == 0 then
			f3_local0 = f3_local1
		else
			f3_local1 = f3_arg0.highlighted
			if f3_local1 == 0 then
				f3_local0 = f3_local1
			elseif f3_arg1.button ~= "right" or f3_arg1.qualifier ~= "dpad" or f3_arg1.down ~= true then
				f3_local0 = false
			else
				f3_local0 = true
			end
		end
	end
	if f3_local0 then
		if f3_arg0.arrayIndex == 0 then
			Engine.SwitchToInventoryWeapon(f3_arg1.controller)
		else
			Engine.ActionSlotSelectWeapon(f3_arg1.controller, f3_arg0.slotIndex)
		end
	end
	return LUI.UIElement.handleGamepadButton(f3_arg0, f3_arg1)
end

function RewardSelection_SetRewardLabel(f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = CoD.RewardSelection.FontName
	local f4_local1, f4_local2, f4_local3, f4_local4 = GetTextDimensions(f4_arg2, CoD.fonts[f4_local0], CoD.textSize[f4_local0])
	local f4_local5 = f4_local1 + f4_local3 - 18
	if f4_local5 < 0 then
		f4_local5 = 0
	end
	f4_arg1:setLeftRight(false, true, CoD.RewardSelection.textLeft - f4_local5, CoD.RewardSelection.textLeft)
	f4_arg1:setText(f4_arg2)
	f4_arg1:completeAnimation()
	f4_arg1:setAlpha(1)
	if not f4_arg0.textNameTimer then
		f4_arg0.textNameTimer = LUI.UITimer.new(CoD.RewardSelection.RewardSelectionDelay, "reward_selection_done", true, f4_arg0)
	else
		f4_arg0.textNameTimer:reset()
	end
	f4_arg0:addElement(f4_arg0.textNameTimer)
	if f4_arg2 == "" then
		f4_arg1:close()
	else
		f4_arg0.scaleContainer:addElement(f4_arg1)
	end
end

CoD.RewardSelection.RewardSelectionDone = function (f5_arg0, f5_arg1)
	f5_arg0.rewardText:beginAnimation("fade_out", CoD.RewardSelection.RewardSelectionFadeout)
	f5_arg0.rewardText:setAlpha(0)
end

function RewardSelection_RewardLoseFocus(f6_arg0, f6_arg1)
	f6_arg0.highlighted = false
	LUI.UIButton.loseFocus(f6_arg0, f6_arg1)
	f6_arg0.rightArrow:setAlpha(0)
	f6_arg0.brackets:setAlpha(0)
	f6_arg0.upArrow:setAlpha(0)
	f6_arg0.downArrow:setAlpha(0)
	if f6_arg0.enabled == true then
		f6_arg0.selectorButtonBackground:setAlpha(1)
	else
		f6_arg0.selectorButtonBackground:setAlpha(CoD.RewardSelection.DisabledAlpha)
		f6_arg0:makeNotFocusable()
	end
	f6_arg0.selectorButtonImage:setAlpha(1)
end

function RewardSelection_RewardGainFocus(f7_arg0, f7_arg1)
	f7_arg0.highlighted = true
	LUI.UIButton.gainFocus(f7_arg0, f7_arg1)
	f7_arg0.brackets:setAlpha(1)
	f7_arg0.rightArrow:setAlpha(1)
	if f7_arg0.navigation.up and f7_arg0.navigation.up.m_focusable then
		f7_arg0.upArrow:setAlpha(1)
	else
		f7_arg0.upArrow:setAlpha(0)
	end
	if f7_arg0.navigation.down and f7_arg0.navigation.down.m_focusable then
		f7_arg0.downArrow:setAlpha(1)
	else
		f7_arg0.downArrow:setAlpha(0)
	end
	f7_arg0:setAlpha(1)
	CoD.RewardSelection.RewardGainedFocusEvent.rewardToHighlight = f7_arg0.arrayIndex
	f7_arg0:dispatchEventToParent(CoD.RewardSelection.RewardGainedFocusEvent)
end

CoD.RewardSelection.RewardGainedFocus = function (f8_arg0, f8_arg1)
	f8_arg0.rewardToHighlight = f8_arg1.rewardToHighlight
	if f8_arg0.lastRewardHighlighted ~= f8_arg0.rewardToHighlight then
		if f8_arg0.rewardToHighlight == 0 and f8_arg0.inventoryReward.itemName ~= nil then
			RewardSelection_SetRewardLabel(f8_arg0, f8_arg0.rewardText, f8_arg0.inventoryReward.itemName)
		elseif f8_arg0.rewards[f8_arg0.rewardToHighlight] ~= nil and f8_arg0.rewards[f8_arg0.rewardToHighlight].rewardData ~= nil and f8_arg0.rewards[f8_arg0.rewardToHighlight].rewardData.itemName ~= nil then
			RewardSelection_SetRewardLabel(f8_arg0, f8_arg0.rewardText, f8_arg0.rewards[f8_arg0.rewardToHighlight].rewardData.itemName)
		end
	end
	f8_arg0.lastRewardHighlighted = f8_arg0.rewardToHighlight
end

CoD.RewardSelection.UpdateRewards = function (f9_arg0, f9_arg1)
	local f9_local0 = false
	for f9_local4, f9_local5 in ipairs(f9_arg0.rewards) do
		local f9_local6 = f9_arg1[f9_local4]
		local f9_local7 = f9_local5.enabled
		f9_local5.enabled = nil
		f9_local5:makeFocusable()
		if f9_local6 == nil then
			f9_local5.rewardData = nil
			f9_local5.momentumCost = 0
			f9_local5.material = nil
			f9_local5:setAlpha(0)
			f9_local5.selectorButtonImage:setAlpha(0)
		end
		f9_local5.rewardData = f9_local6
		f9_local5.slotIndex = f9_local6.slotIndex
		f9_local5:setAlpha(1)
		f9_local5.brackets:setAlpha(0)
		f9_local5.selectorButtonImage:setAlpha(1)
		f9_local5.selectorButtonImage:setImage(f9_local6.material)
		f9_local5.selectorButtonBlend:setImage(CoD.RewardSelection.SelectorButtonBackgroundBlendMaterial)
		if f9_local6.ammo > 0 then
			if f9_local7 ~= true and f9_local0 == false then
				f9_local0 = true
				f9_arg0.rewardToHighlight = f9_local4
				f9_arg0.lastRewardHighlighted = nil
			end
			f9_local5.enabled = true
			f9_local5.selectorButtonBlend:setImage(CoD.RewardSelection.SelectorButtonBackgroundBlendLitMaterial)
		end
	end
	CoD.RewardSelection.UpdateNavigation(f9_arg0)
end

CoD.RewardSelection.UpdateNavigation = function (f10_arg0)
	if Engine.IsShoutcaster(f10_arg0.m_ownerController) or Engine.IsDemoShoutcaster() or UIExpression.IsVisibilityBitSet(f10_arg0.m_ownerController, CoD.BIT_SPECTATING_CLIENT) == 1 then
		return 
	else
		local f10_local0 = f10_arg0.rewardToHighlight
		f10_arg0.inventoryReward:processEvent({
			name = "lose_focus"
		})
		f10_arg0.rewardSelectionList:processEvent({
			name = "lose_focus"
		})
		f10_arg0.rewardToHighlight = f10_local0
		LUI.UIVerticalList.UpdateNavigation(f10_arg0.rewardSelectionList)
		CoD.RewardSelection.SetTopRewardHiglighted(f10_arg0)
	end
end

CoD.RewardSelection.UpdateActionSlotsAmmo = function (f11_arg0, f11_arg1)
	local f11_local0 = false
	for f11_local4, f11_local5 in ipairs(f11_arg0.rewards) do
		local f11_local6 = f11_local5.rewardData
		local f11_local7 = f11_local5.enabled
		f11_local5.enabled = nil
		f11_local5:makeFocusable()
		if f11_local6 ~= nil then
			f11_local5:setAlpha(1)
			f11_local5.brackets:setAlpha(0)
			f11_local5.selectorButtonImage:setAlpha(1)
			f11_local5.selectorButtonImage:setImage(f11_local6.material)
			f11_local5.selectorButtonBlend:setImage(CoD.RewardSelection.SelectorButtonBackgroundBlendMaterial)
			if f11_arg1[f11_local4] ~= nil and f11_arg1[f11_local4].ammo ~= nil and f11_arg1[f11_local4].ammo > 0 then
				if f11_local7 ~= true and f11_local0 == false then
					f11_local0 = true
					f11_arg0.rewardToHighlight = f11_local4
					f11_arg0.lastRewardHighlighted = nil
				end
				f11_local5.enabled = true
				f11_local6.quantity = f11_arg1[f11_local4].ammo
				f11_local5.selectorButtonBlend:setImage(CoD.RewardSelection.SelectorButtonBackgroundBlendLitMaterial)
			end
			f11_local6.quantity = 0
		end
		f11_local5.selectorButtonImage:setAlpha(0)
	end
	CoD.RewardSelection.UpdateNavigation(f11_arg0)
end

CoD.RewardSelection.SetTopRewardHiglighted = function (f12_arg0)
	local f12_local0 = false
	if f12_arg0.rewardToHighlight ~= nil then
		local f12_local1 = nil
		if f12_arg0.rewardToHighlight == 0 then
			f12_local1 = f12_arg0.inventoryReward
		else
			f12_local1 = f12_arg0.rewards[f12_arg0.rewardToHighlight]
		end
		if f12_local1.m_focusable == true and f12_local1.enabled == true then
			f12_local1:processEvent({
				name = "gain_focus"
			})
			f12_local0 = true
		end
	end
	if f12_local0 == false then
		if f12_arg0.inventoryReward.m_focusable == true and f12_arg0.inventoryReward.enabled == true then
			f12_arg0.inventoryReward:processEvent({
				name = "gain_focus"
			})
		else
			for f12_local4, f12_local5 in ipairs(f12_arg0.rewards) do
				if f12_local5.m_focusable == true and f12_local5.enabled == true then
					f12_local5:processEvent({
						name = "gain_focus"
					})
					break
				end
			end
		end
	end
end

CoD.RewardSelection.UpdateVisibility = function (f13_arg0, f13_arg1)
	local f13_local0 = f13_arg1.controller
	local f13_local1 = false
	local f13_local2 = true
	if UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_EMP_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_IN_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_IN_VEHICLE) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_IN_GUIDED_MISSILE) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_AMMO_COUNTER_HIDE) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_IS_FLASH_BANGED) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_SCOREBOARD_OPEN) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_HUD_HARDCORE) == 0 and (not CoD.IsShoutcaster(f13_local0) or CoD.ExeProfileVarBool(f13_local0, "shoutcaster_scorestreaks") and Engine.IsSpectatingActiveClient(f13_local0)) and CoD.FSM_VISIBILITY(f13_local0) == 0 then
		f13_local1 = true
	end
	if UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_IN_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_EMP_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_IN_VEHICLE) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_IN_GUIDED_MISSILE) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_SCOREBOARD_OPEN) == 0 and (not CoD.IsShoutcaster(f13_local0) or CoD.ExeProfileVarBool(f13_local0, "shoutcaster_scorestreaks") and Engine.IsSpectatingActiveClient(f13_local0)) and CoD.FSM_VISIBILITY(f13_local0) == 0 then
		f13_local2 = false
	end
	if CoD.isWIIU then
		local f13_local3 = UIExpression.GetControllerType(f13_local0)
		if f13_local3 == "remote" or f13_local3 == "classic" then
			if UIExpression.IsVisibilityBitSet(f13_local0, CoD.BIT_CAROUSEL_ACTIVE) == 1 then
				f13_arg0.carouselText:setText("^BBUTTON_CAROUSEL_STICK^")
				f13_arg0.rewardSelectionList:setAlpha(1)
			else
				f13_arg0.carouselText:setText(Engine.Localize("PLATFORM_ACTIONSLOT_CAROUSEL"))
				f13_arg0.rewardSelectionList:setAlpha(0.4)
			end
		else
			f13_arg0.carouselText:setText("")
			f13_arg0.rewardSelectionList:setAlpha(1)
		end
	end
	if f13_local1 == true then
		if f13_arg0.visible ~= true then
			f13_arg0.alphaController:setAlpha(1)
			f13_arg0.visible = true
		end
	elseif f13_arg0.visible == true then
		f13_arg0.alphaController:setAlpha(0)
		f13_arg0.visible = nil
	end
	if f13_local2 == true then
		f13_arg0.m_inputDisabled = true
	else
		f13_arg0.m_inputDisabled = nil
	end
	f13_arg0:dispatchEventToChildren(f13_arg1)
end

CoD.RewardSelection.UpdateInventoryWeapon = function (f14_arg0, f14_arg1)
	local f14_local0 = f14_arg0.inventoryWeapon
	local f14_local1 = f14_arg0.inventoryReward.enabled
	if f14_arg1.materialName ~= nil then
		f14_arg0.rewardToHighlight = 0
		f14_arg0.inventoryReward.enabled = true
		f14_arg0.inventoryReward:setAlpha(1)
		f14_arg0.inventoryReward.selectorButtonImage:setAlpha(1)
		f14_arg0.inventoryReward:makeFocusable()
		local f14_local2 = f14_arg0.inventoryWeaponIcon
		f14_arg0.inventoryReward.selectorButtonBlend:setImage(CoD.RewardSelection.SelectorButtonBackgroundBlendLitMaterial)
		f14_arg0.inventoryReward.selectorButtonImage:setImage(f14_arg1.material)
		f14_arg0.inventoryReward.itemName = f14_arg1.itemName
		if f14_local1 ~= true then
			f14_arg0.lastRewardHighlighted = nil
		end
	else
		f14_arg0.inventoryReward.enabled = false
		f14_arg0.inventoryReward:setAlpha(0)
		f14_arg0.inventoryReward.selectorButtonImage:setAlpha(0)
	end
	f14_arg0.inventoryReward.brackets:setAlpha(0)
	CoD.RewardSelection.UpdateNavigation(f14_arg0)
end

CoD.RewardSelection.UpdateMomentum = function (f15_arg0, f15_arg1)
	local f15_local0 = f15_arg1.momentum
	local f15_local1 = 0
	local f15_local2, f15_local3 = nil
	for f15_local8, f15_local9 in ipairs(f15_arg0.rewards) do
		if f15_local9.rewardData ~= nil then
			local f15_local7 = f15_local9.rewardData.momentumCost
			if f15_local7 <= f15_local0 and f15_local1 < f15_local7 then
				f15_local1 = f15_local7
			end
			if f15_local0 < f15_local7 and (not f15_local2 or f15_local7 < f15_local2) then
				f15_local2 = f15_local7
				f15_local3 = f15_local8
			end
		end
	end
	f15_local4 = 0
	if f15_local2 then
		f15_local4 = (f15_local0 - f15_local1) / (f15_local2 - f15_local1)
	end
	if f15_arg1.teleported then
		if f15_local4 == 0 then
			f15_arg0.progressBarStencil:setAlpha(0)
		else
			f15_arg0.progressBarStencil:setAlpha(1)
		end
		f15_arg0.progressBarStencil:completeAnimation()
		CoD.RewardSelection.SetProgressBarStencilTopBottom(f15_arg0.progressBarStencil, f15_local4)
		f15_arg0.progressBarStencil.momentumPercentage = f15_local4
	else
		f15_arg0.progressBarStencil:setAlpha(1)
		if f15_arg0.progressBarStencil:getAnimationFraction() then
			f15_arg0.progressBarStencil.percentageTarget = f15_local4
		else
			CoD.RewardSelection.AnimateProgressBar(f15_arg0.progressBarStencil, f15_local4)
		end
	end
	f15_local5, f15_local6 = nil
	if f15_local3 == 1 then
		f15_local5 = CoD.RewardSelection.ProgressBarRight - 21
		f15_local6 = -87
	elseif f15_local3 == 2 then
		f15_local5 = CoD.RewardSelection.ProgressBarRight - 26
		f15_local6 = -50
	elseif f15_local3 == 3 then
		f15_local5 = CoD.RewardSelection.ProgressBarRight - 32
		f15_local6 = -14
	end
	if f15_local5 and f15_local6 then
		f15_arg0.progressBarArrow:setTopBottom(false, true, f15_local6 + CoD.RewardSelection.ProgressBarTop + CoD.RewardSelection.HeightOffset - 32, f15_local6 + CoD.RewardSelection.ProgressBarTop + CoD.RewardSelection.HeightOffset)
		f15_arg0.progressBarArrow:setLeftRight(false, true, f15_local5, f15_local5 + 32)
		if f15_arg0.progressBarArrow.nextRewardIndex ~= f15_local3 then
			f15_arg0.progressBarArrow.nextRewardIndex = f15_local3
			if not f15_arg1.teleported then
				f15_arg0.progressBarArrow:setAlpha(0)
				f15_arg0.progressBarArrow:beginAnimation("fade_in", 250)
			end
		end
		f15_arg0.progressBarBackground:setAlpha(1)
		f15_arg0.progressBarArrow:setAlpha(1)
	else
		f15_arg0.progressBarBackground:setAlpha(0)
		f15_arg0.progressBarArrow:setAlpha(0)
	end
end

CoD.RewardSelection.AnimateProgressBar = function (f16_arg0, f16_arg1)
	if not f16_arg0.momentumPercentage then
		f16_arg0.momentumPercentage = 0
	end
	local f16_local0 = f16_arg1 - f16_arg0.momentumPercentage
	if f16_local0 < 0 then
		f16_arg0.percentageTarget = f16_arg1
		f16_arg1 = 1
		f16_local0 = 1 - f16_arg0.momentumPercentage
	end
	f16_arg0.momentumPercentage = f16_arg1
	f16_arg0:beginAnimation("update_momentum", 500 * f16_local0)
	CoD.RewardSelection.SetProgressBarStencilTopBottom(f16_arg0, f16_arg1)
end

CoD.RewardSelection.SetProgressBarStencilTopBottom = function (f17_arg0, f17_arg1)
	local f17_local0 = 12
	f17_arg0:setTopBottom(false, true, CoD.RewardSelection.ProgressBarTop + CoD.RewardSelection.HeightOffset - (114 - f17_local0) * f17_arg1 - f17_local0, CoD.RewardSelection.ProgressBarTop + CoD.RewardSelection.HeightOffset)
end

CoD.RewardSelection.ProgressBar_TransitionCompleteUpdateMomentum = function (f18_arg0)
	local f18_local0 = f18_arg0.percentageTarget
	if f18_local0 then
		f18_arg0.percentageTarget = nil
		if f18_local0 < f18_arg0.momentumPercentage then
			f18_arg0.momentumPercentage = 0
			f18_arg0:setTopBottom(false, true, CoD.RewardSelection.ProgressBarTop + CoD.RewardSelection.HeightOffset, CoD.RewardSelection.ProgressBarTop + CoD.RewardSelection.HeightOffset)
		end
		CoD.RewardSelection.AnimateProgressBar(f18_arg0, f18_local0)
	end
end

