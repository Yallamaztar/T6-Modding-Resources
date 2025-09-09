CoD.RemoveReward = {}
CoD.RemoveReward.ItemRatio = 1.7
CoD.RemoveReward.ItemWidth = CoD.Rewards.GridItemWidth * CoD.RemoveReward.ItemRatio
CoD.RemoveReward.ItemHeight = CoD.Rewards.GridItemHeight * CoD.RemoveReward.ItemRatio
CoD.RemoveReward.HighlightedItemRatio = 2.5
CoD.RemoveReward.HighlightedItemWidth = CoD.Rewards.GridItemWidth * CoD.RemoveReward.HighlightedItemRatio
CoD.RemoveReward.HighlightedItemHeight = CoD.Rewards.GridItemHeight * CoD.RemoveReward.HighlightedItemRatio
LUI.createMenu.RemoveReward = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewMediumPopup("RemoveReward")
	f1_local0:setOwner(f1_arg0)
	f1_local0.equipEventName = "equip"
	f1_local0:addSelectButton(Engine.Localize("MPUI_REPLACE"))
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("remove_killstreak", CoD.RemoveReward.RemoveKillstreak)
	f1_local0.header = LUI.UIText.new()
	f1_local0.header:setLeftRight(true, false, 0, 1)
	f1_local0.header:setTopBottom(true, false, 0, CoD.textSize.Big)
	f1_local0.header:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.header:setFont(CoD.fonts.Big)
	f1_local0.header:setText(Engine.Localize("MPUI_TOO_MANY_STREAKS_CAPS"))
	f1_local0:addElement(f1_local0.header)
	local f1_local1 = 2
	f1_local0.subtitle = LUI.UIText.new()
	f1_local0.subtitle:setLeftRight(true, false, f1_local1, f1_local1 + 1)
	f1_local0.subtitle:setTopBottom(true, false, CoD.textSize.Big, CoD.textSize.Big + CoD.textSize.Default)
	f1_local0.subtitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.subtitle:setFont(CoD.fonts.Default)
	f1_local0.subtitle:setText(Engine.Localize("MPUI_TOO_MANY_STREAKS_DESC"))
	f1_local0:addElement(f1_local0.subtitle)
	local f1_local2 = CoD.CardCarouselList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.textSize.Big + 35,
		bottom = 0
	}, f1_arg0, CoD.RemoveReward.ItemWidth, CoD.RemoveReward.ItemHeight, CoD.RemoveReward.HighlightedItemWidth, CoD.RemoveReward.HighlightedItemHeight)
	f1_local2:setLRSFX(CoD.CACUtility.carouselLRSFX)
	f1_local2:setUpSFX(CoD.CACUtility.carouselUpSFX)
	f1_local2:setDownSFX(CoD.CACUtility.carouselDownSFX)
	f1_local2:setEquipSFX(CoD.CACUtility.carouselEquipSFX)
	f1_local0:addElement(f1_local2)
	CoD.RemoveReward.AddRewardCards(f1_local2:addCardCarousel(""), f1_arg0)
	f1_local2.cardCarousels[f1_local2.m_currentCardCarouselIndex].horizontalList:processEvent({
		name = "gain_focus"
	})
	return f1_local0
end

CoD.RemoveReward.SetupCard = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	if f2_arg0.border then
		f2_arg0.border:close()
	end
	if f2_arg0.highlightedborder then
		f2_arg0.highlightedborder:close()
	end
	local f2_local0 = 30
	local f2_local1 = 40
	CoD.ContentGridButton.CarouselSetupButtonImages(f2_arg0, f2_local0, f2_local1, f2_arg2, f2_arg3)
	f2_arg0.titleElement = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 7,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.textSize.Default - 4,
		bottom = -4,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Left
	})
	f2_arg0.titleText = Engine.Localize(f2_arg1)
	f2_arg0.titleElement:setText(f2_arg0.titleText)
	f2_arg0.titleElement:registerAnimationState("button_over", {
		leftAnchor = true,
		rightAnchor = true,
		left = 8,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.textSize.Condensed - 5,
		bottom = -5,
		red = CoD.BOIIOrange.r,
		green = CoD.BOIIOrange.g,
		blue = CoD.BOIIOrange.b,
		font = CoD.fonts.Condensed,
		alignment = LUI.Alignment.Left
	})
	LUI.UIButton.SetupElement(f2_arg0.titleElement)
	f2_arg0:addElement(f2_arg0.titleElement)
	f2_arg0.imageStencilContainer = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 2,
		right = -2,
		topAnchor = true,
		bottomAnchor = true,
		top = 2,
		bottom = -f2_local0 - 2
	})
	f2_arg0.imageStencilContainer:registerAnimationState("button_over", {
		leftAnchor = true,
		rightAnchor = true,
		left = 2,
		right = -2,
		topAnchor = true,
		bottomAnchor = true,
		top = 1,
		bottom = -f2_local1 - 2
	})
	f2_arg0.imageStencilContainer:setPriority(-70)
	f2_arg0:addElement(f2_arg0.imageStencilContainer)
	f2_arg0.imageStencilContainer:setUseStencil(true)
	LUI.UIButton.SetupElement(f2_arg0.imageStencilContainer)
end

CoD.RemoveReward.AddRewardCards = function (f3_arg0, f3_arg1)
	local f3_local0 = CoD.CACUtility.GetClassData(f3_arg1, CoD.perController[f3_arg1].classNumInternal)
	local f3_local1 = f3_local0.rewards
	for f3_local2 = 1, CoD.CACUtility.maxRewardSlots, 1 do
		local f3_local5 = f3_local1[f3_local2]
		if f3_local5 ~= nil and f3_local5.itemIndex then
			local f3_local6 = f3_arg0:addNewCard()
			f3_local6.itemIndex = f3_local5.itemIndex
			CoD.RemoveReward.SetupCard(f3_local6, f3_local5.name, CoD.RewardGridButton.glowBackColor, CoD.RewardGridButton.glowFrontColor)
			local f3_local7 = 130 * CoD.RemoveReward.ItemRatio
			local f3_local8 = f3_local7
			local f3_local9 = -20 * CoD.RemoveReward.ItemRatio
			local f3_local10 = 130 * CoD.RemoveReward.HighlightedItemRatio
			local f3_local11 = f3_local10
			local f3_local12 = -20 * CoD.RemoveReward.HighlightedItemRatio
			f3_local6.iconMaterial = RegisterMaterial(UIExpression.GetItemImage(nil, f3_local5.itemIndex) .. "_menu")
			f3_local6.icon = LUI.UIImage.new({
				leftAnchor = false,
				rightAnchor = false,
				left = -f3_local8 / 2,
				right = f3_local8 / 2,
				topAnchor = true,
				bottomAnchor = false,
				top = f3_local9,
				bottom = f3_local9 + f3_local7,
				material = f3_local6.iconMaterial
			})
			f3_local6.icon:registerAnimationState("button_over", {
				leftAnchor = false,
				rightAnchor = false,
				left = -f3_local11 / 2,
				right = f3_local11 / 2,
				topAnchor = true,
				bottomAnchor = false,
				top = f3_local12,
				bottom = f3_local12 + f3_local10
			})
			LUI.UIButton.SetupElement(f3_local6.icon)
			f3_local6.icon.overDuration = CoD.CardCarousel.CardGrowShrinkTime
			f3_local6.icon.upDuration = CoD.CardCarousel.CardGrowShrinkTime
			f3_local6.imageStencilContainer:addElement(f3_local6.icon)
			f3_local6.hintText = Engine.Localize("MENU_SCORE_STREAK_REQ") .. ": " .. f3_local5.momentumCost
			f3_local6:setActionEventName("remove_killstreak")
		end
	end
end

CoD.RemoveReward.RemoveKillstreak = function (f4_arg0, f4_arg1)
	local f4_local0 = CoD.perController[f4_arg1.controller].classNumInternal
	local f4_local1 = CoD.perController[f4_arg1.controller].chosenItem
	CoD.RemoveItemFromClass(f4_arg1.controller, f4_local0, f4_arg1.button.itemIndex)
	f4_arg0:goBack(f4_arg1.controller)
	f4_arg0.occludedMenu:processEvent({
		name = f4_arg0.equipEventName,
		controller = f4_arg1.controller,
		itemIndex = f4_local1
	})
end

