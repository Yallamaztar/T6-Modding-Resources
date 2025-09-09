CoD.CACRemoveItem = {}
CoD.CACRemoveItem.ItemWidth = 192
CoD.CACRemoveItem.ItemHeight = 146
CoD.CACRemoveItem.HighlightedItemWidth = 345.6
CoD.CACRemoveItem.HighlightedItemHeight = 217.8
LUI.createMenu.CACRemoveItem = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewMediumPopup("CACRemoveItem")
	f1_local0:setOwner(f1_arg0)
	f1_local0.equipEventName = "equip"
	f1_local0.setEquipEventName = CoD.CACRemoveItem.SetEquipEventName
	f1_local0:addSelectButton(Engine.Localize("MENU_REMOVE"))
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("remove_weapon", CoD.CACRemoveItem.RemoveWeaponEvent)
	f1_local0:registerEventHandler("remove_attachment", CoD.CACRemoveItem.RemoveAttachmentEvent)
	f1_local0:registerEventHandler("remove_grenade", CoD.CACRemoveItem.RemoveGrenade)
	f1_local0:registerEventHandler("remove_perk", CoD.CACRemoveItem.RemovePerkEvent)
	f1_local0:registerEventHandler("remove_bonus_card", CoD.CACRemoveItem.RemoveBonusCard)
	local f1_local1 = LUI.UIText.new()
	f1_local1:setLeftRight(true, false, 0, 1)
	f1_local1:setTopBottom(true, false, 0, CoD.textSize.Big)
	f1_local1:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local1:setFont(CoD.fonts.Big)
	f1_local1:setText(Engine.Localize("MENU_TOO_MANY_ITEMS_CAPS"))
	f1_local0:addElement(f1_local1)
	local f1_local2 = 2
	local f1_local3 = LUI.UIText.new()
	f1_local3:setLeftRight(true, false, f1_local2, f1_local2 + 1)
	f1_local3:setTopBottom(true, false, CoD.textSize.Big, CoD.textSize.Big + CoD.textSize.Default)
	f1_local3:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local3:setFont(CoD.fonts.Default)
	f1_local3:setText(Engine.Localize("MENU_TOO_MANY_ITEMS_DESC"))
	f1_local0:addElement(f1_local3)
	local f1_local4 = CoD.CardCarouselList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.textSize.Big + 35,
		bottom = 0
	}, f1_arg0, CoD.CACRemoveItem.ItemWidth, CoD.CACRemoveItem.ItemHeight, CoD.CACRemoveItem.HighlightedItemWidth, CoD.CACRemoveItem.HighlightedItemHeight)
	f1_local0:addElement(f1_local4)
	local f1_local5 = f1_local4:addCardCarousel("")
	local f1_local6 = Engine.GetCustomClass(f1_arg0, CoD.perController[f1_arg0].classNum)
	CoD.CACRemoveItem.AddWeaponCard(f1_arg0, f1_local6, CoD.CACUtility.loadoutSlotNames.primaryWeapon, f1_local5)
	CoD.CACRemoveItem.AddWeaponCard(f1_arg0, f1_local6, CoD.CACUtility.loadoutSlotNames.secondaryWeapon, f1_local5)
	CoD.CACRemoveItem.AddPerkCards(f1_arg0, f1_local6, 1, f1_local5)
	CoD.CACRemoveItem.AddPerkCards(f1_arg0, f1_local6, 2, f1_local5)
	CoD.CACRemoveItem.AddPerkCards(f1_arg0, f1_local6, 3, f1_local5)
	CoD.CACRemoveItem.AddGrenadeCards(f1_arg0, f1_local6, CoD.CACUtility.loadoutSlotNames.primaryGrenade, f1_local5)
	CoD.CACRemoveItem.AddGrenadeCards(f1_arg0, f1_local6, CoD.CACUtility.loadoutSlotNames.specialGrenade, f1_local5)
	CoD.CACRemoveItem.AddBonusCardCards(f1_arg0, f1_local6, f1_local5)
	f1_local4.cardCarousels[f1_local4.m_currentCardCarouselIndex].horizontalList:processEvent({
		name = "gain_focus"
	})
	return f1_local0
end

CoD.CACRemoveItem.SetEquipEventName = function (f2_arg0, f2_arg1)
	f2_arg0.equipEventName = f2_arg1
end

CoD.CACRemoveItem.SetupCard = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	f3_arg0.titleElement = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 5,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.textSize.Default - 2,
		bottom = -2,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Left
	})
	f3_arg0.titleText = Engine.Localize(f3_arg1)
	f3_arg0.titleElement:setText(f3_arg0.titleText)
	f3_arg0.titleElement:registerAnimationState("button_over", {
		red = CoD.BOIIOrange.r,
		green = CoD.BOIIOrange.g,
		blue = CoD.BOIIOrange.b
	})
	LUI.UIButton.SetupElement(f3_arg0.titleElement)
	f3_arg0:addElement(f3_arg0.titleElement)
	if f3_arg0.border then
		f3_arg0.border:close()
	end
	if f3_arg0.highlightedborder then
		f3_arg0.highlightedborder:close()
	end
	CoD.ContentGridButton.SetupButtonImages(f3_arg0, f3_arg2, f3_arg3)
end

CoD.CACRemoveItem.AddWeaponCard = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	local f4_local0 = f4_arg1[f4_arg2]
	if not f4_local0 then
		return 
	elseif CoD.perController[f4_arg0].weaponSlot == f4_arg2 then
		return 
	else
		local f4_local1 = f4_arg3:addNewCard()
		f4_local1.loadoutSlot = f4_arg2
		f4_local1.iconMaterial = RegisterMaterial(UIExpression.GetItemImage(nil, f4_local0) .. "_big")
		f4_local1.icon = LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 10,
			bottom = -40,
			red = 1,
			green = 1,
			blue = 1,
			material = f4_local1.iconMaterial
		})
		f4_local1:addElement(f4_local1.icon)
		CoD.CACRemoveItem.SetupCard(f4_local1, UIExpression.GetItemName(nil, f4_local0), CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
		f4_local1:setActionEventName("remove_weapon")
		CoD.CACRemoveItem.AddAttachmentCards(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		return f4_local1
	end
end

CoD.CACRemoveItem.AddAttachmentCards = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	local f5_local0 = CoD.perController[f5_arg0].classNum
	local f5_local1 = f5_arg1[f5_arg2]
	local f5_local2 = Engine.Localize(UIExpression.GetItemName(nil, f5_local1))
	for f5_local3 = 0, 2, 1 do
		local f5_local6 = f5_arg1[f5_arg2 .. "attachment" .. f5_local3 + 1]
		if f5_local6 then
			local f5_local7 = f5_arg3:addNewCard()
			f5_local7.loadoutSlot = f5_arg2
			f5_local7.slotIndex = f5_local3 + 1
			f5_local7.iconMaterial = RegisterMaterial(Engine.GetAttachmentImage(f5_local1, f5_local6))
			f5_local7.icon = LUI.UIImage.new({
				leftAnchor = false,
				rightAnchor = false,
				left = -48,
				right = 48,
				topAnchor = true,
				bottomAnchor = false,
				top = 10,
				bottom = 106,
				red = 1,
				green = 1,
				blue = 1,
				material = f5_local7.iconMaterial
			})
			f5_local7.icon:registerAnimationState("button_over", {
				leftAnchor = false,
				rightAnchor = false,
				left = -96,
				right = 96,
				topAnchor = true,
				bottomAnchor = false,
				top = 10,
				bottom = 202
			})
			LUI.UIButton.SetupElement(f5_local7.icon)
			f5_local7.icon.overDuration = CoD.CardCarousel.CardGrowShrinkTime
			f5_local7.icon.upDuration = CoD.CardCarousel.CardGrowShrinkTime
			f5_local7:addElement(f5_local7.icon)
			CoD.CACRemoveItem.SetupCard(f5_local7, Engine.GetAttachmentName(f5_local1, f5_local6), CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
			f5_local7.hintText = Engine.Localize("MENU_ATTACHED_TO_ITEM", f5_local2)
			f5_local7:setActionEventName("remove_attachment")
		end
	end
end

CoD.CACRemoveItem.AddGrenadeCards = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	local f6_local0 = f6_arg1[f6_arg2]
	if not f6_local0 then
		return 
	elseif CoD.perController[f6_arg0].grenadeSlot == f6_arg2 then
		return 
	end
	local f6_local1 = f6_arg1[f6_arg2 .. "count"]
	for f6_local2 = 1, f6_local1, 1 do
		local f6_local5 = f6_local2
		local f6_local6 = f6_arg3:addNewCard()
		f6_local6.loadoutSlot = f6_arg2
		f6_local6.quantity = f6_local1
		f6_local6.iconMaterial = RegisterMaterial(UIExpression.GetItemImage(nil, f6_local0) .. "_256")
		f6_local6.icon = LUI.UIImage.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -36,
			right = 36,
			topAnchor = true,
			bottomAnchor = false,
			top = 25,
			bottom = 97,
			red = 1,
			green = 1,
			blue = 1,
			material = f6_local6.iconMaterial
		})
		f6_local6.icon:registerAnimationState("button_over", {
			leftAnchor = false,
			rightAnchor = false,
			left = -72,
			right = 72,
			topAnchor = true,
			bottomAnchor = false,
			top = 40,
			bottom = 184
		})
		LUI.UIButton.SetupElement(f6_local6.icon)
		f6_local6.icon.overDuration = CoD.CardCarousel.CardGrowShrinkTime
		f6_local6.icon.upDuration = CoD.CardCarousel.CardGrowShrinkTime
		f6_local6:addElement(f6_local6.icon)
		CoD.CACRemoveItem.SetupCard(f6_local6, UIExpression.GetItemName(nil, f6_local0), CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
		f6_local6:setActionEventName("remove_grenade")
	end
	return card
end

CoD.CACRemoveItem.AddPerkCards = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	for f7_local0 = 1, CoD.CACUtility.maxPerksInEachCategory, 1 do
		local f7_local3 = CoD.CACPerksP.GetLoadoutSlot(f7_arg2, f7_local0)
		local f7_local4 = f7_arg1[f7_local3]
		if f7_local4 then
			local f7_local5 = f7_arg3:addNewCard()
			f7_local5.loadoutSlot = f7_local3
			f7_local5.iconMaterial = RegisterMaterial(UIExpression.GetItemImage(nil, f7_local4) .. "_256")
			f7_local5.icon = LUI.UIImage.new({
				leftAnchor = false,
				rightAnchor = false,
				left = -48,
				right = 48,
				topAnchor = true,
				bottomAnchor = false,
				top = 10,
				bottom = 106,
				red = 1,
				green = 1,
				blue = 1,
				material = f7_local5.iconMaterial
			})
			f7_local5.icon:registerAnimationState("button_over", {
				leftAnchor = false,
				rightAnchor = false,
				left = -96,
				right = 96,
				topAnchor = true,
				bottomAnchor = false,
				top = 10,
				bottom = 202
			})
			LUI.UIButton.SetupElement(f7_local5.icon)
			f7_local5.icon.overDuration = CoD.CardCarousel.CardGrowShrinkTime
			f7_local5.icon.upDuration = CoD.CardCarousel.CardGrowShrinkTime
			f7_local5:addElement(f7_local5.icon)
			CoD.CACRemoveItem.SetupCard(f7_local5, UIExpression.GetItemName(nil, f7_local4), CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
			f7_local5:setActionEventName("remove_perk")
		end
	end
	return card
end

CoD.CACRemoveItem.AddBonusCardCards = function (f8_arg0, f8_arg1, f8_arg2)
	local f8_local0 = CoD.perController[f8_arg0]
	local f8_local1, f8_local2 = nil
	if f8_local0.weaponSlot == "primary" and f8_local0.slotIndex == 3 then
		f8_local1 = "bonuscard_primary_gunfighter"
	elseif f8_local0.weaponSlot == "secondary" then
		f8_local1 = "bonuscard_overkill"
		if f8_local0.slotIndex == 2 then
			f8_local2 = "bonuscard_secondary_gunfighter"
		end
	elseif f8_local0.grenadeSlot == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
		f8_local1 = "bonuscard_two_tacticals"
		if f8_local0.slotIndex == 2 then
			f8_local2 = "bonuscard_danger_close"
		end
	elseif f8_local0.perkCategory and f8_local0.slotIndex == 2 then
		f8_local1 = "bonuscard_perk_" .. f8_local0.perkCategory .. "_greed"
	end
	local f8_local3 = CoD.CACUtility.maxBonusCards
	for f8_local4 = 1, f8_local3, 1 do
		local f8_local7 = f8_arg1["bonuscard" .. f8_local4]
		if f8_local7 then
			local f8_local8 = UIExpression.GetItemRef(nil, f8_local7)
			if f8_local8 ~= f8_local1 and f8_local8 ~= f8_local2 then
				local f8_local9 = f8_arg2:addNewCard()
				f8_local9.bonusCardName = f8_local8
				f8_local9.bonusCardSlot = f8_local4
				local f8_local10 = CoD.ContentGridButton.TitleHeight + 4
				local f8_local11 = CoD.CACRemoveItem.ItemHeight - f8_local10
				local f8_local12 = f8_local11 * 2
				local f8_local13 = CoD.CACRemoveItem.HighlightedItemHeight - f8_local10
				local f8_local14 = f8_local13 * 2
				f8_local9.iconMaterial = RegisterMaterial(UIExpression.GetItemImage(nil, f8_local7))
				f8_local9.icon = LUI.UIImage.new({
					leftAnchor = false,
					rightAnchor = false,
					left = -f8_local12 / 2,
					right = f8_local12 / 2,
					topAnchor = false,
					bottomAnchor = true,
					top = -f8_local10 - f8_local11,
					bottom = -f8_local10,
					material = f8_local9.iconMaterial
				})
				f8_local9.icon:registerAnimationState("button_over", {
					leftAnchor = false,
					rightAnchor = false,
					left = -f8_local14 / 2,
					right = f8_local14 / 2,
					topAnchor = false,
					bottomAnchor = true,
					top = -f8_local10 - f8_local13,
					bottom = -f8_local10
				})
				LUI.UIButton.SetupElement(f8_local9.icon)
				f8_local9.icon.overDuration = CoD.CardCarousel.CardGrowShrinkTime
				f8_local9.icon.upDuration = CoD.CardCarousel.CardGrowShrinkTime
				f8_local9:addElement(f8_local9.icon)
				CoD.CACRemoveItem.SetupCard(f8_local9, UIExpression.GetItemName(nil, f8_local7), CoD.BonusCardGridButton.glowBackColor, CoD.BonusCardGridButton.glowFrontColor)
				f8_local9:setActionEventName("remove_bonus_card")
			end
		end
	end
end

CoD.CACRemoveItem.RemoveWeaponEvent = function (f9_arg0, f9_arg1)
	CoD.CACRemoveItem.RemoveWeapon(f9_arg1.controller, CoD.perController[f9_arg1.controller].classNum, f9_arg1.button.loadoutSlot)
	f9_arg0:goBack(f9_arg1.controller)
	f9_arg0.occludedMenu:processEvent({
		name = f9_arg0.equipEventName,
		controller = f9_arg1.controller
	})
end

CoD.CACRemoveItem.RemoveWeapon = function (f10_arg0, f10_arg1, f10_arg2)
	CoD.EquipNotification.AddToNotificationQueue("item", "unequipped", UIExpression.GetItemName(nil, Engine.GetClassItem(f10_arg0, f10_arg1, f10_arg2)))
	Engine.SetClassItem(f10_arg0, f10_arg1, f10_arg2, 0)
	for f10_local0 = 0, 2, 1 do
		Engine.SetClassItem(f10_arg0, f10_arg1, f10_arg2 .. "attachment" .. f10_local0 + 1, 0)
	end
	for f10_local0 = 1, CoD.CACUtility.maxBonusCards, 1 do
		if UIExpression.GetItemRef(nil, CoD.GetClassItem(f10_arg0, f10_arg1, "bonuscard" .. f10_local0)) == "bonuscard_" .. f10_arg2 .. "_gunfighter" then
			Engine.SetClassItem(f10_arg0, f10_arg1, "bonuscard" .. f10_local0, 0)
		end
	end
end

CoD.CACRemoveItem.RemoveAttachmentEvent = function (f11_arg0, f11_arg1)
	CoD.CACRemoveItem.RemoveAttachment(f11_arg1.controller, CoD.perController[f11_arg1.controller].classNum, f11_arg1.button.loadoutSlot, f11_arg1.button.slotIndex)
	f11_arg0:goBack(f11_arg1.controller)
	f11_arg0.occludedMenu:processEvent({
		name = f11_arg0.equipEventName,
		controller = f11_arg1.controller
	})
end

CoD.CACRemoveItem.RemoveAttachment = function (f12_arg0, f12_arg1, f12_arg2, f12_arg3)
	CoD.EquipNotification.AddToNotificationQueue("item", "unequipped", Engine.GetAttachmentName(Engine.GetClassItem(f12_arg0, f12_arg1, f12_arg2), Engine.GetClassItem(f12_arg0, f12_arg1, f12_arg2 .. "attachment" .. f12_arg3)))
	Engine.SetClassItem(f12_arg0, f12_arg1, f12_arg2 .. "attachment" .. f12_arg3, 0)
end

CoD.CACRemoveItem.RemoveGrenade = function (f13_arg0, f13_arg1)
	local f13_local0 = f13_arg1.controller
	local f13_local1 = CoD.perController[f13_local0].classNum
	local f13_local2 = f13_arg1.button.loadoutSlot
	local f13_local3 = f13_arg1.button.quantity
	CoD.EquipNotification.AddToNotificationQueue("item", "unequipped", UIExpression.GetItemName(nil, Engine.GetClassItem(f13_local0, f13_local1, f13_local2)))
	if f13_local3 == 1 then
		Engine.SetClassItem(f13_local0, f13_local1, f13_local2, 0)
		Engine.SetClassItem(f13_local0, f13_local1, f13_local2 .. "status1", 0)
	else
		for f13_local4 = 2, 1, -1 do
			if Engine.GetClassItem(f13_local0, f13_local1, f13_local2 .. "status" .. f13_local4 + 1) == 1 then
				Engine.SetClassItem(f13_local0, f13_local1, f13_local2 .. "status" .. f13_local4 + 1, 0)
				break
			end
		end
	end
	Engine.SetClassItem(f13_local0, f13_local1, f13_local2 .. "count", f13_local3 - 1)
	f13_arg0:goBack(f13_arg1.controller)
	f13_arg0.occludedMenu:processEvent({
		name = f13_arg0.equipEventName,
		controller = f13_local0
	})
end

CoD.CACRemoveItem.RemovePerkEvent = function (f14_arg0, f14_arg1)
	CoD.CACRemoveItem.RemovePerk(f14_arg1.controller, CoD.perController[f14_arg1.controller].classNum, f14_arg1.button.loadoutSlot)
	f14_arg0:goBack(f14_arg1.controller)
	f14_arg0.occludedMenu:processEvent({
		name = f14_arg0.equipEventName,
		controller = f14_arg1.controller
	})
end

CoD.CACRemoveItem.RemovePerk = function (f15_arg0, f15_arg1, f15_arg2)
	CoD.EquipNotification.AddToNotificationQueue("item", "unequipped", UIExpression.GetItemName(nil, Engine.GetClassItem(f15_arg0, f15_arg1, f15_arg2)))
	Engine.SetClassItem(f15_arg0, f15_arg1, f15_arg2, 0)
end

CoD.CACRemoveItem.RemoveBonusCard = function (f16_arg0, f16_arg1)
	local f16_local0 = f16_arg1.controller
	local f16_local1 = CoD.perController[f16_local0].classNum
	local f16_local2 = f16_arg1.button.bonusCardName
	local f16_local3 = "bonuscard" .. f16_arg1.button.bonusCardSlot
	CoD.EquipNotification.AddToNotificationQueue("bonusCard", "unequipped", f16_local2)
	Engine.SetClassItem(f16_local0, f16_local1, f16_local3, 0)
	local f16_local4 = CoD.BonusCardButton.BonusCardUnequipped[f16_local2]
	if f16_local4 then
		f16_local4(f16_local0)
	end
	f16_arg0:goBack(f16_arg1.controller)
	f16_arg0.occludedMenu:processEvent({
		name = f16_arg0.equipEventName,
		controller = f16_local0
	})
end

