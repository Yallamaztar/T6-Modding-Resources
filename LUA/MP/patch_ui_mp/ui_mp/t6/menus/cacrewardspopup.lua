require("T6.RewardGridButton")
require("T6.SelectedReward")
CoD.Rewards = {}
CoD.Rewards.GridColumns = 6
CoD.Rewards.GridItemSpacing = 8
CoD.Rewards.GridItemWidth = (CoD.Menu.Width - CoD.Rewards.GridItemSpacing * (CoD.Rewards.GridColumns - 1)) / CoD.Rewards.GridColumns
CoD.Rewards.GridItemHeight = 64 + CoD.ContentGridButton.TitleHeight + 10
LUI.createMenu.Rewards = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("Rewards")
	f1_local0:addLargePopupBackground()
	f1_local0.m_ownerController = f1_arg0
	f1_local0:addTitle(Engine.Localize("MENU_SCORE_STREAKS_CAPS"))
	f1_local0.goBack = CoD.Rewards.GoBack
	f1_local0:registerEventHandler("content_button_highlighted", CoD.Rewards.ContentButtonHighlighted)
	f1_local0:registerEventHandler("content_button_selected", CoD.Rewards.ContentButtonSelected)
	f1_local0:registerEventHandler("equip", CoD.Rewards.Equip)
	f1_local0:registerEventHandler("unequip", CoD.Rewards.Unequip)
	f1_local0:registerEventHandler("purchased", CoD.Rewards.Purchased)
	f1_local0:registerEventHandler("button_prompt_clear_all_rewards", CoD.Rewards.ClearAllRewards)
	f1_local0:registerEventHandler("prestige_unlock", CoD.Rewards.PrestigeUnlock)
	f1_local0:registerEventHandler("remove_prestige_unlock_button", CoD.Rewards.RemovePrestigeUnlockButton)
	f1_local0:registerEventHandler("add_prestige_unlock_button", CoD.Rewards.AddPrestigeUnlockButton)
	if not Engine.AreAllItemsFree() then
		local f1_local1 = Engine.GetPlayerStats(f1_arg0)
		if f1_local1.PlayerStatsList.PLEVEL.StatValue:get() < tonumber(CoD.MAX_PRESTIGE) then
			local f1_local2 = CoD.CAC.CreateUnlockTokensFooter(f1_local0, f1_arg0)
			CoD.CAC.SetUnlockItemText(f1_local2, f1_arg0)
			f1_local0:addElement(f1_local2)
		end
	end
	CoD.Rewards.AddElements(f1_local0)
	CoD.Rewards.UpdateSelectedRewards(f1_local0, f1_arg0)
	return f1_local0
end

CoD.Rewards.GoBack = function (f2_arg0, f2_arg1)
	f2_arg0.contentGrid:saveState()
	Engine.Exec(f2_arg1, "uploadstats")
	Engine.CommitProfileChanges(f2_arg1)
	Engine.PartyHostClearUIState()
	if f2_arg0.occludedMenu then
		f2_arg0.occludedMenu:processEvent({
			name = "scorestreaks_closed",
			controller = f2_arg1
		})
	end
	CoD.Menu.goBack(f2_arg0, f2_arg1)
end

CoD.Rewards.AddDeselectButtonPrompt = function (f3_arg0)
	local f3_local0 = false
	f3_arg0:removeSelectButton()
	f3_arg0:removeBackButton()
	if f3_arg0.prestigeUnlockButton then
		f3_local0 = true
		f3_arg0.prestigeUnlockButton:close()
		f3_arg0.prestigeUnlockButton = nil
	end
	f3_arg0:addSelectButton(Engine.Localize("MPUI_CLEAR"))
	f3_arg0:addBackButton()
	if f3_local0 == true then
		f3_arg0:addPrestigeUnlockButton()
	end
end

CoD.Rewards.AddSelectButtonPrompt = function (f4_arg0)
	local f4_local0 = false
	f4_arg0:removeSelectButton()
	f4_arg0:removeBackButton()
	if f4_arg0.prestigeUnlockButton then
		f4_local0 = true
		f4_arg0.prestigeUnlockButton:close()
		f4_arg0.prestigeUnlockButton = nil
	end
	f4_arg0:addSelectButton()
	f4_arg0:addBackButton()
	if f4_local0 == true then
		f4_arg0:addPrestigeUnlockButton()
	end
end

CoD.Rewards.AddClearAllButtonPrompt = function (f5_arg0)
	if not f5_arg0.clearAllButtonPrompt then
		local f5_local0 = CoD.ButtonPrompt.new
		local f5_local1 = "alt1"
		local f5_local2 = Engine.Localize("MENU_CLEAR_ALL")
		local f5_local3 = f5_arg0
		local f5_local4 = "button_prompt_clear_all_rewards"
		local f5_local5, f5_local6 = false
		local f5_local7, f5_local8 = false
		f5_arg0.clearAllButtonPrompt = f5_local0(f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6, f5_local7, f5_local8, "C")
		f5_arg0:addRightButtonPrompt(f5_arg0.clearAllButtonPrompt)
	end
end

CoD.Rewards.RemoveClearAllButtonPrompt = function (f6_arg0)
	if f6_arg0.clearAllButtonPrompt then
		f6_arg0.clearAllButtonPrompt:close()
		f6_arg0.clearAllButtonPrompt = nil
	end
end

CoD.Rewards.RemovePrestigeUnlockButton = function (f7_arg0, f7_arg1)
	if f7_arg0.prestigeUnlockButton then
		f7_arg0.prestigeUnlockButton:close()
		f7_arg0.prestigeUnlockButton = nil
	end
end

CoD.Rewards.AddPrestigeUnlockButton = function (f8_arg0, f8_arg1)
	if f8_arg0.prestigeUnlockButton == nil then
		f8_arg0:addPrestigeUnlockButton()
	end
end

CoD.Rewards.IsSelected = function (f9_arg0, f9_arg1)
	return CoD.CACUtility.HowManyInClassData(f9_arg0, f9_arg1) > 0
end

CoD.Rewards.GetSelectedRewardCount = function (f10_arg0)
	local f10_local0 = CoD.GetUnlockablesByGroupName("killstreak")
	local f10_local1 = CoD.CACUtility.GetClassData(f10_arg0, CoD.perController[f10_arg0].classNumInternal)
	local f10_local2 = 0
	for f10_local6, f10_local7 in pairs(f10_local0) do
		if CoD.Rewards.IsSelected(f10_local7, f10_local1) == true then
			f10_local2 = f10_local2 + 1
		end
	end
	return f10_local2
end

CoD.Rewards.GetLockedRewardCount = function (f11_arg0)
	local f11_local0 = CoD.GetUnlockablesByGroupName("killstreak")
	local f11_local1 = CoD.CACUtility.GetClassData(f11_arg0, CoD.perController[f11_arg0].classNumInternal)
	local f11_local2 = 0
	for f11_local6, f11_local7 in pairs(f11_local0) do
		if UIExpression.IsItemLocked(f11_arg0, f11_local7) == 1 then
			f11_local2 = f11_local2 + 1
		end
	end
	return f11_local2
end

CoD.Rewards.AddElements = function (f12_arg0)
	CoD.perController[f12_arg0.m_ownerController].classNumInternal = 0
	f12_arg0:addSelectButton()
	f12_arg0:addBackButton()
	local f12_local0 = CoD.textSize.Big + 5
	f12_arg0.contentGrid = CoD.ContentGrid.new(CoD.Rewards.GridColumns, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f12_local0,
		bottom = 0
	}, CoD.Rewards.GridItemWidth, CoD.Rewards.GridItemHeight, CoD.Rewards.GridItemSpacing)
	f12_arg0:addElement(f12_arg0.contentGrid)
	local f12_local1 = math.ceil(#CoD.GetUnlockablesByGroupName("killstreak") / CoD.Rewards.GridColumns)
	local f12_local2 = f12_local0 + CoD.Rewards.GridItemHeight * f12_local1 + CoD.Rewards.GridItemSpacing * (f12_local1 - 1) + 3
	f12_arg0.hintTextElement = CoD.HintText.new()
	f12_arg0.hintTextElement:setLeftRight(true, true, 0, 0)
	f12_arg0.hintTextElement:setTopBottom(true, false, f12_local2, f12_local2 + CoD.HintText.Height)
	f12_arg0.hintTextElement:setColor(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b, 0.4)
	f12_arg0:addElement(f12_arg0.hintTextElement)
	f12_local0 = f12_local0 + CoD.Rewards.GridItemHeight * 4 + CoD.CACAttachments.GridItemSpacing * 3 + 3 + CoD.HintText.Height + 5
	local f12_local3 = 0
	f12_arg0.infoContainer = LUI.UIElement.new()
	f12_arg0.infoContainer:setLeftRight(true, true, 0, 0)
	f12_arg0.infoContainer:setTopBottom(true, true, f12_local0, 0)
	f12_arg0:addElement(f12_arg0.infoContainer)
	f12_arg0.itemNameLabel = LUI.UIText.new()
	f12_arg0.itemNameLabel:setLeftRight(true, false, 0, 1)
	f12_arg0.itemNameLabel:setTopBottom(true, false, f12_local3, f12_local3 + CoD.textSize.Big)
	f12_arg0.itemNameLabel:setFont(CoD.fonts.Big)
	f12_arg0.itemNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f12_arg0.infoContainer:addElement(f12_arg0.itemNameLabel)
	f12_local3 = f12_local3 + CoD.textSize.Big
	local f12_local4 = Engine.Localize("MENU_SCORE_STREAK_REQ") .. ":"
	f12_arg0.requirementLabel = LUI.UIText.new()
	f12_arg0.requirementLabel:setLeftRight(true, false, 0, CoD.Menu.Width / 2)
	f12_arg0.requirementLabel:setTopBottom(true, false, f12_local3, f12_local3 + CoD.textSize.Default)
	f12_arg0.requirementLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f12_arg0.requirementLabel:setFont(CoD.fonts.Default)
	f12_arg0.requirementLabel:setAlignment(LUI.Alignment.Left)
	f12_arg0.requirementLabel:setText(f12_local4)
	f12_arg0.infoContainer:addElement(f12_arg0.requirementLabel)
	local f12_local5 = {}
	f12_local5 = GetTextDimensions(f12_local4, CoD.fonts.Default, CoD.textSize.Default)
	local f12_local6 = f12_local5[3] + 5
	f12_arg0.itemMomentumCostLabel = LUI.UIText.new()
	f12_arg0.itemMomentumCostLabel:setLeftRight(true, false, f12_local6, f12_local6 + 1)
	f12_arg0.itemMomentumCostLabel:setTopBottom(true, false, f12_local3, f12_local3 + CoD.textSize.Default)
	f12_arg0.itemMomentumCostLabel:setFont(CoD.fonts.Default)
	f12_arg0.itemMomentumCostLabel:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f12_arg0.itemMomentumCostLabel:setAlignment(LUI.Alignment.Left)
	f12_arg0.infoContainer:addElement(f12_arg0.itemMomentumCostLabel)
	f12_local3 = f12_local3 + CoD.textSize.Default
	f12_arg0.itemDescriptionLabel = LUI.UIText.new()
	f12_arg0.itemDescriptionLabel:setLeftRight(true, false, 0, CoD.Menu.Width / 2 + 30)
	f12_arg0.itemDescriptionLabel:setTopBottom(true, false, f12_local3, f12_local3 + CoD.textSize.Default)
	f12_arg0.itemDescriptionLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f12_arg0.itemDescriptionLabel:setFont(CoD.fonts.Default)
	f12_arg0.itemDescriptionLabel:setAlignment(LUI.Alignment.Left)
	f12_arg0.itemDescriptionLabel:setAlpha(0.4)
	f12_arg0.infoContainer:addElement(f12_arg0.itemDescriptionLabel)
	f12_local3 = f12_local3 + CoD.textSize.Default
	local f12_local7 = 0.7
	local f12_local8 = CoD.Rewards.GridItemWidth * f12_local7
	local f12_local9 = (CoD.Rewards.GridItemHeight - CoD.textSize[CoD.ContentGridButton.FontName] - 4) * f12_local7
	local f12_local10 = 130 * f12_local7
	local f12_local11 = 30
	local f12_local12 = f12_local8 * CoD.CACUtility.maxRewardSlots + f12_local11 * CoD.CACUtility.maxRewardSlots
	local f12_local13 = -156
	local Widget = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = true,
		left = -f12_local12,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = f12_local13,
		bottom = f12_local13 + 90
	})
	f12_arg0.infoContainer:addElement(Widget)
	local f12_local15 = 3
	Widget.border = CoD.BorderDip.new(1, 1, 1, 1, 0.1, nil, (f12_local8 + f12_local11) * f12_local15, f12_local15)
	Widget:addElement(Widget.border)
	local f12_local16 = LUI.UIText.new()
	f12_local16:setLeftRight(true, true, 0, 0)
	f12_local16:setTopBottom(true, false, -CoD.textSize.Default, 0)
	f12_local16:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f12_local16:setAlpha(0.4)
	f12_local16:setFont(CoD.fonts.Default)
	f12_local16:setAlignment(LUI.Alignment.Left)
	f12_local16:setText(Engine.Localize("MPUI_SELECTED_SCORE_STREAKS") .. ":")
	Widget:addElement(f12_local16)
	local f12_local17 = 8
	local f12_local18 = f12_local11 / 2
	f12_arg0.selectedRewards = {}
	for f12_local19 = 1, CoD.CACUtility.maxRewardSlots, 1 do
		f12_arg0.selectedRewards[f12_local19] = CoD.SelectedReward.New({
			leftAnchor = true,
			rightAnchor = false,
			left = f12_local18,
			right = f12_local18 + f12_local8,
			topAnchor = true,
			bottomAnchor = false,
			top = f12_local17,
			bottom = f12_local17 + f12_local9
		}, f12_local10)
		Widget:addElement(f12_arg0.selectedRewards[f12_local19])
		local f12_local22 = 20
		local f12_local23 = 10
		local f12_local24 = f12_local18 + f12_local8 + f12_local11 / 2 - f12_local22 / 2
		local f12_local25 = f12_local17 + f12_local9 / 2 - f12_local22 / 2
		if f12_local19 < CoD.CACUtility.maxRewardSlots then
			local f12_local26 = LUI.UIImage.new()
			f12_local26:setLeftRight(true, false, f12_local24, f12_local24 + f12_local22)
			f12_local26:setTopBottom(true, false, f12_local25, f12_local25 + f12_local22)
			f12_local26:setImage(RegisterMaterial("demo_timeline_arrow"))
			f12_local26:setZRot(270)
			f12_local26:setAlpha(0.2)
			Widget:addElement(f12_local26)
		end
		f12_local18 = f12_local18 + f12_local8 + f12_local11
	end
	f12_local17 = f12_local17 + f12_local9 + f12_local11
	f12_arg0.unlockTokenLabel = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f12_local17,
		bottom = f12_local17 + CoD.textSize.Default,
		font = CoD.fonts.Default
	})
	CoD.Rewards.AddRewards(f12_arg0, f12_arg0.m_ownerController)
end

CoD.Rewards.AddRewards = function (f13_arg0, f13_arg1)
	local f13_local0 = CoD.GetUnlockablesByGroupName("killstreak")
	table.sort(f13_local0, CoD.CACRewardComparisonFunction)
	local f13_local1 = CoD.CACUtility.GetClassData(f13_arg1, CoD.perController[f13_arg1].classNumInternal)
	local f13_local2, f13_local3 = nil
	for f13_local7, f13_local8 in pairs(f13_local0) do
		local f13_local9 = CoD.RewardGridButton.new(f13_local8)
		if CoD.Rewards.IsSelected(f13_local8, f13_local1) == true then
			f13_local3 = f13_local8
		end
		f13_arg0.contentGrid:addButton(f13_local9)
		if f13_local2 == nil then
			f13_local2 = f13_local9
		end
	end
	f13_arg0:dispatchEventToChildren({
		name = "highlighted",
		controller = f13_arg1,
		weaponItemIndex = f13_local3
	})
	f13_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f13_arg1,
		classData = f13_local1
	})
	CoD.Rewards.UpdateSelectedRewards(f13_arg0, f13_arg1)
	if CoD.useController and not f13_arg0.contentGrid:restoreState() then
		f13_local2:processEvent({
			name = "gain_focus",
			controller = f13_arg1
		})
	end
end

CoD.Rewards.UpdateSelectedRewards = function (f14_arg0, f14_arg1)
	local f14_local0 = f14_arg0.selectedRewards
	local f14_local1 = CoD.CACUtility.GetClassData(f14_arg1, CoD.perController[f14_arg1].classNumInternal)
	local f14_local2 = f14_local1.rewards
	for f14_local3 = 1, CoD.CACUtility.maxRewardSlots, 1 do
		CoD.SelectedReward.Update(f14_local0[f14_local3], f14_local2[f14_local3])
	end
	if #f14_local2 > 0 then
		CoD.Rewards.AddClearAllButtonPrompt(f14_arg0)
	end
	if #f14_local2 == 0 then
		CoD.Rewards.RemoveClearAllButtonPrompt(f14_arg0)
		CoD.Rewards.AddSelectButtonPrompt(f14_arg0)
	end
end

CoD.Rewards.ItemButtonUpdateSelectionPreview = function (f15_arg0, f15_arg1)
	if not f15_arg0:isInFocus() then
		return 
	else
		f15_arg0:dispatchEventToParent({
			name = "update_selection_preview",
			controller = f15_arg1.controller,
			rewardInfo = f15_arg0.rewardInfo
		})
	end
end

CoD.Rewards.ContentButtonHighlighted = function (f16_arg0, f16_arg1)
	local f16_local0 = f16_arg0.m_ownerController
	local f16_local1 = CoD.CACUtility.GetClassData(f16_local0, CoD.perController[f16_local0].classNumInternal)
	if f16_arg1.contentIndex then
		f16_arg0.itemNameLabel:setText(Engine.Localize(UIExpression.GetItemName(nil, f16_arg1.contentIndex)))
		f16_arg0.itemDescriptionLabel:setText(Engine.Localize(UIExpression.GetItemDesc(nil, f16_arg1.contentIndex)))
		f16_arg0.itemMomentumCostLabel:setText(UIExpression.GetItemMomentumCost(nil, f16_arg1.contentIndex))
		if CoD.Rewards.IsSelected(f16_arg1.contentIndex, f16_local1) == true then
			CoD.Rewards.AddDeselectButtonPrompt(f16_arg0)
		elseif CoD.CAC.GetUnlockCountForGroup(f16_local0, UIExpression.GetItemGroup(nil, f16_arg1.contentIndex)) == 0 or f16_arg1.locked == true then
			f16_arg0:removeSelectButton()
		else
			CoD.Rewards.AddSelectButtonPrompt(f16_arg0)
		end
	else
		f16_arg0.itemNameLabel:setText("")
		f16_arg0.itemDescriptionLabel:setText("")
		f16_arg0.itemMomentumCostLabel:setText("")
	end
	f16_arg0:dispatchEventToChildren({
		name = "highlighted",
		controller = f16_arg1.controller,
		weaponItemIndex = f16_arg1.contentIndex
	})
	f16_arg0.weaponItemIndexHighlighted = f16_arg1.contentIndex
	f16_arg0.highlightedButton = f16_arg1.button
	f16_arg0.hintTextElement:updateText(f16_arg1.hintText)
end

CoD.Rewards.PrestigeUnlock = function (f17_arg0, f17_arg1)
	CoD.ConfirmPrestigeUnlock.OpenIfNecessary(f17_arg0, f17_arg1.controller, f17_arg0.weaponItemIndexHighlighted, f17_arg0.highlightedButton)
end

CoD.Rewards.ContentButtonSelected = function (f18_arg0, f18_arg1)
	CoD.perController[f18_arg1.controller].chosenItem = f18_arg1.contentIndex
	local f18_local0 = f18_arg1.contentIndex
	local f18_local1 = f18_arg1.controller
	local f18_local2 = CoD.CACUtility.GetClassData(f18_local1, CoD.perController[f18_local1].classNumInternal)
	if CoD.ConfirmPurchase.OpenIfNecessary(f18_arg0, f18_local1, f18_local0, f18_arg1.button) ~= nil then
		return 
	elseif CoD.Rewards.IsSelected(f18_local0, f18_local2) == true then
		f18_arg0:processEvent({
			name = "unequip",
			controller = f18_local1,
			itemIndex = f18_local0
		})
		CoD.Rewards.AddSelectButtonPrompt(f18_arg0)
	elseif UIExpression.IsItemPurchased(f18_local1, f18_local0) == 0 then
		Engine.PlaySound(CoD.CACUtility.denySFX)
	elseif f18_arg1.button.inactive == true then
		local f18_local3 = f18_arg0:openPopup("RemoveReward", f18_local1)
		if f18_arg1.button.currentCostConflict == true then
			f18_local3.header:setText(Engine.Localize("MPUI_STREAK_REQ_CONFLICT_CAPS"))
			f18_local3.subtitle:setText(Engine.Localize("MPUI_STREAK_REQ_CONFLICT_DESC"))
		end
	else
		f18_arg0:processEvent({
			name = "equip",
			controller = f18_local1,
			itemIndex = f18_local0
		})
		CoD.Rewards.AddDeselectButtonPrompt(f18_arg0)
	end
end

CoD.Rewards.UpdateUIFromClassData = function (f19_arg0, f19_arg1)
	f19_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f19_arg1
	})
	CoD.Rewards.UpdateSelectedRewards(f19_arg0, f19_arg1)
	local f19_local0 = CoD.CAC.GetUnlockCountForGroup(f19_arg1, "killstreak")
	if CoD.Rewards.GetLockedRewardCount(f19_arg1) > 0 then
		f19_arg0.unlockTokenLabel:setText(f19_local0 .. " " .. Engine.Localize("MPUI_UNLOCKS_CAPS"))
	else
		f19_arg0.unlockTokenLabel:setText("")
	end
end

CoD.Rewards.Equip = function (f20_arg0, f20_arg1)
	local f20_local0 = f20_arg1.controller
	local f20_local1 = f20_arg1.itemIndex
	local f20_local2 = CoD.perController[f20_local0].classNumInternal
	for f20_local3 = 1, CoD.CACUtility.maxRewardSlots, 1 do
		local f20_local6 = CoD.CACUtility.loadoutSlotNames["reward" .. f20_local3]
		local f20_local7 = CoD.GetClassItem(f20_local0, f20_local2, f20_local6)
		if UIExpression.IsItemPurchased(f20_local0, f20_local1) ~= 0 and (f20_local7 == nil or f20_local7 == 0 or f20_local7 == UIExpression.GetItemIndex(f20_local0, CoD.nullSpecialtyName)) then
			CoD.SetClassItem(f20_local0, f20_local2, f20_local6, f20_local1)
			break
		end
	end
	CoD.Rewards.UpdateUIFromClassData(f20_arg0, f20_local0)
end

CoD.Rewards.Purchased = function (f21_arg0, f21_arg1)
	f21_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f21_arg1.controller
	})
	f21_arg0:dispatchEventToChildren(f21_arg1)
	f21_arg0.hintTextElement:updateText(nil)
	if f21_arg1.button.itemNameText then
		if CoD.Rewards.GetSelectedRewardCount(f21_arg1.controller) == CoD.CACUtility.maxRewardSlots then
			f21_arg1.button.itemNameText:registerAnimationState("button_over", {
				red = CoD.offWhite.r,
				green = CoD.offWhite.g,
				blue = CoD.offWhite.b
			})
		else
			f21_arg1.button.itemNameText:registerAnimationState("button_over", {
				red = CoD.BOIIOrange.r,
				green = CoD.BOIIOrange.g,
				blue = CoD.BOIIOrange.b
			})
		end
		f21_arg1.button.itemNameText:animateToState("button_over")
	end
	if f21_arg1.button.highlight then
		f21_arg1.button.highlight:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	end
	CoD.Rewards.AddSelectButtonPrompt(f21_arg0)
	f21_arg0:processEvent({
		name = "remove_prestige_unlock_button"
	})
end

CoD.Rewards.Unequip = function (f22_arg0, f22_arg1)
	local f22_local0 = f22_arg1.controller
	CoD.RemoveItemFromClass(f22_local0, CoD.perController[f22_local0].classNumInternal, f22_arg1.itemIndex)
	CoD.Rewards.UpdateUIFromClassData(f22_arg0, f22_local0)
end

CoD.Rewards.ClearAllRewards = function (f23_arg0, f23_arg1)
	local f23_local0 = f23_arg1.controller
	local f23_local1 = CoD.perController[f23_local0].classNumInternal
	for f23_local2 = 1, CoD.CACUtility.maxRewardSlots, 1 do
		CoD.SetClassItem(f23_local0, f23_local1, CoD.CACUtility.loadoutSlotNames["reward" .. f23_local2], 0)
	end
	Engine.PlaySound("cac_grid_equip_item")
	CoD.Rewards.UpdateUIFromClassData(f23_arg0, f23_local0)
end

