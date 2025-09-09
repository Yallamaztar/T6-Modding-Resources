CoD.BonusCardButton = {}
CoD.BonusCardButton.Width = 97
CoD.BonusCardButton.Height = 69
CoD.BonusCardButton.LabelFontName = "Big"
CoD.BonusCardButton.LabelFont = CoD.fonts[CoD.BonusCardButton.LabelFontName]
CoD.BonusCardButton.LabelFontHeight = CoD.textSize[CoD.BonusCardButton.LabelFontName]
CoD.BonusCardButton.BonusCardEquipped = {}
CoD.BonusCardButton.BonusCardUnequipped = {}
CoD.BonusCardButton.EquipSFX = {
	bonuscard_primary_gunfighter = "cac_wildcard_equip_1",
	bonuscard_secondary_gunfighter = "cac_wildcard_equip_2",
	bonuscard_overkill = "cac_wildcard_equip_3",
	bonuscard_danger_close = "cac_wildcard_equip_4",
	bonuscard_perk_1_greed = "cac_wildcard_equip_5",
	bonuscard_perk_2_greed = "cac_wildcard_equip_6",
	bonuscard_perk_3_greed = "cac_wildcard_equip_7"
}
CoD.BonusCardButton.new = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = CoD.GrowingGridButton.new(f1_arg2, CoD.BonusCardButton.BonusCardSetup)
	f1_local0.id = f1_local0.id .. ".BonusCardButton." .. f1_arg0
	f1_local0.equipped = false
	f1_local0.bonusCardSlot = f1_arg0
	f1_local0.weaponStatName = "bonuscard" .. f1_arg0
	f1_local0:setHintText("")
	f1_local0.handleUnequipPrompt = CoD.BonusCardButton.Unequip
	local f1_local1 = f1_arg1 + 10
	local f1_local2 = f1_local1 * 2
	local f1_local3 = -11
	local f1_local4 = 30
	f1_local0.image = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = true,
		left = f1_local4 - f1_local2,
		right = f1_local4,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local3,
		bottom = f1_local3 + f1_local1,
		alpha = 0
	})
	LUI.UIButton.SetupElement(f1_local0.image)
	f1_local0.image:setPriority(0)
	f1_local0:addElement(f1_local0.image)
	f1_local0.body:registerAnimationState("enabled", {
		alpha = 1
	})
	f1_local0.body:registerAnimationState("disabled", {
		alpha = 0.2
	})
	f1_local0.body:animateToState("enabled")
	f1_local0:registerEventHandler("gain_focus", CoD.BonusCardButton.GainFocus)
	f1_local0:registerEventHandler("lose_focus", CoD.BonusCardButton.LoseFocus)
	f1_local0:registerEventHandler("button_action", CoD.BonusCardButton.ButtonAction)
	f1_local0:registerEventHandler("update_class", CoD.BonusCardButton.UpdateClass)
	return f1_local0
end

CoD.BonusCardButton.GainFocus = function (f2_arg0, f2_arg1)
	LUI.UIButton.gainFocus(f2_arg0, f2_arg1)
	f2_arg0.name:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f2_arg0:dispatchEventToParent({
		name = "bonus_card_gain_focus",
		bonusCardSlot = f2_arg0.bonusCardSlot,
		controller = f2_arg1.controller
	})
end

CoD.BonusCardButton.LoseFocus = function (f3_arg0, f3_arg1)
	LUI.UIButton.loseFocus(f3_arg0, f3_arg1)
	f3_arg0.name:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f3_arg0:dispatchEventToParent({
		name = "bonus_card_lose_focus",
		bonusCardSlot = f3_arg0.bonusCardSlot,
		controller = f3_arg1.controller
	})
end

CoD.BonusCardButton.Unequip = function (f4_arg0, f4_arg1)
	CoD.GrowingGridButton.ButtonPromptUnequip(f4_arg0, f4_arg1)
	local f4_local0 = CoD.perController[f4_arg1.controller].classNum
	local f4_local1 = Engine.GetCustomClass(f4_arg1.controller, f4_local0)
	local f4_local2 = "bonuscard" .. f4_arg0.bonusCardSlot
	local f4_local3 = UIExpression.GetItemRef(f4_arg1.controller, f4_local1[f4_local2])
	Engine.SetClassItem(f4_arg1.controller, f4_local0, f4_local2, 0)
	local f4_local4 = CoD.BonusCardButton.BonusCardUnequipped[f4_local3]
	if f4_local4 then
		f4_local4(f4_arg1.controller)
	end
	Engine.PlaySound("cac_wildcard_remove")
	f4_arg0:dispatchEventToParent({
		name = "bonus_card_unequipped",
		cardName = f4_local3
	})
end

CoD.BonusCardButton.ButtonAction = function (f5_arg0, f5_arg1)
	f5_arg0:dispatchEventToParent({
		name = "bonuscard_chosen",
		controller = f5_arg1.controller,
		bonusCardSlot = f5_arg0.bonusCardSlot,
		class = f5_arg0.class
	})
end

CoD.BonusCardButton.UpdateClass = function (f6_arg0, f6_arg1)
	f6_arg0.allocationSpent = f6_arg1.class.allocationSpent
	local f6_local0 = f6_arg1.class["bonuscard" .. f6_arg0.bonusCardSlot]
	if f6_local0 ~= nil then
		f6_arg0.image:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f6_local0)))
		f6_arg0.image:setAlpha(1)
		f6_arg0.name:setText(Engine.Localize(UIExpression.GetItemRef(nil, f6_local0)))
		f6_arg0.desc:setText(Engine.Localize(UIExpression.GetItemDesc(nil, f6_local0)))
		f6_arg0.equipped = true
		f6_arg0.glowGradBack:animateToState("equipped")
		f6_arg0.glowGradBack:setAlpha(0.2)
		f6_arg0.glowGradFront:animateToState("equipped")
		if f6_arg1.preview then
			f6_arg0.body:animateToState("enabled")
		end
		if Engine.IsItemIndexRestricted(f6_local0) then
			f6_arg0:setRestrictedImage(true)
			local f6_local1 = -30
			f6_arg0.restrictedImage:setLeftRight(false, true, f6_local1 - 32, f6_local1)
		end
		f6_arg0.canBeRemoved = true
	else
		f6_arg0.image:setAlpha(0)
		f6_arg0.name:setText("")
		f6_arg0.desc:setText("")
		f6_arg0.equipped = false
		f6_arg0.glowGradBack:animateToState("unequipped")
		f6_arg0.glowGradFront:animateToState("unequipped")
		if f6_arg1.preview then
			f6_arg0.body:animateToState("disabled")
		end
		f6_arg0:setRestrictedImage(false)
		f6_arg0.canBeRemoved = nil
	end
end

CoD.BonusCardButton.BonusCardEquipped.bonuscard_overkill = function (f7_arg0)
	local f7_local0 = CoD.perController[f7_arg0].classNum
	Engine.SetClassItem(f7_arg0, f7_local0, CoD.CACUtility.loadoutSlotNames.secondaryWeapon, 0)
	for f7_local1 = 0, 2, 1 do
		Engine.SetClassItem(f7_arg0, f7_local0, "secondaryattachment" .. f7_local1 + 1, 0)
	end
end

CoD.BonusCardButton.BonusCardEquipped.bonuscard_two_tacticals = function (f8_arg0)
	local f8_local0 = CoD.perController[f8_arg0].classNum
	local f8_local1 = Engine.GetCustomClass(f8_arg0, f8_local0)
	local f8_local2 = CoD.CACUtility.loadoutSlotNames.primaryGrenade .. "count"
	Engine.SetClassItem(f8_arg0, f8_local0, CoD.CACUtility.loadoutSlotNames.primaryGrenade, 0)
	Engine.SetClassItem(f8_arg0, f8_local0, f8_local2, 0)
	Engine.SetClassItem(f8_arg0, f8_local0, CoD.CACUtility.loadoutSlotNames.primaryGrenade .. "status1", 0)
	Engine.SetClassItem(f8_arg0, f8_local0, CoD.CACUtility.loadoutSlotNames.primaryGrenade .. "status2", 0)
	Engine.SetClassItem(f8_arg0, f8_local0, CoD.CACUtility.loadoutSlotNames.primaryGrenade .. "status3", 0)
end

CoD.BonusCardButton.BonusCardUnequipped.bonuscard_primary_gunfighter = function (f9_arg0)
	Engine.SetClassItem(f9_arg0, CoD.perController[f9_arg0].classNum, "primaryattachment3", 0)
end

CoD.BonusCardButton.BonusCardUnequipped.bonuscard_secondary_gunfighter = function (f10_arg0)
	Engine.SetClassItem(f10_arg0, CoD.perController[f10_arg0].classNum, "secondaryattachment2", 0)
end

CoD.BonusCardButton.BonusCardUnequipped.bonuscard_danger_close = function (f11_arg0)
	local f11_local0 = CoD.perController[f11_arg0].classNum
	local f11_local1 = Engine.GetCustomClass(f11_arg0, f11_local0)
	local f11_local2 = CoD.CACUtility.loadoutSlotNames.primaryGrenade .. "count"
	if f11_local1[f11_local2] == 3 then
		Engine.SetClassItem(f11_arg0, f11_local0, f11_local2, 2)
		Engine.SetClassItem(f11_arg0, f11_local0, CoD.CACUtility.loadoutSlotNames.primaryGrenade .. "status3", 0)
	elseif f11_local1[f11_local2] == 2 then
		Engine.SetClassItem(f11_arg0, f11_local0, f11_local2, 1)
		Engine.SetClassItem(f11_arg0, f11_local0, CoD.CACUtility.loadoutSlotNames.primaryGrenade .. "status2", 0)
		Engine.SetClassItem(f11_arg0, f11_local0, CoD.CACUtility.loadoutSlotNames.primaryGrenade .. "status3", 0)
	end
end

CoD.BonusCardButton.BonusCardUnequipped.bonuscard_two_tacticals = function (f12_arg0)
	local f12_local0 = CoD.perController[f12_arg0].classNum
	local f12_local1 = Engine.GetCustomClass(f12_arg0, f12_local0)
	local f12_local2 = CoD.CACUtility.loadoutSlotNames.primaryGrenade .. "count"
	Engine.SetClassItem(f12_arg0, f12_local0, CoD.CACUtility.loadoutSlotNames.primaryGrenade, 0)
	Engine.SetClassItem(f12_arg0, f12_local0, f12_local2, 0)
	Engine.SetClassItem(f12_arg0, f12_local0, CoD.CACUtility.loadoutSlotNames.primaryGrenade .. "status1", 0)
	Engine.SetClassItem(f12_arg0, f12_local0, CoD.CACUtility.loadoutSlotNames.primaryGrenade .. "status2", 0)
	Engine.SetClassItem(f12_arg0, f12_local0, CoD.CACUtility.loadoutSlotNames.primaryGrenade .. "status3", 0)
end

CoD.BonusCardButton.BonusCardUnequipped.bonuscard_overkill = function (f13_arg0)
	CoD.CACRemoveItem.RemoveWeapon(f13_arg0, CoD.perController[f13_arg0].classNum, CoD.CACUtility.loadoutSlotNames.secondaryWeapon)
end

CoD.BonusCardButton.PerkBonusCardUnequipped = function (f14_arg0, f14_arg1)
	Engine.SetClassItem(f14_arg1, CoD.perController[f14_arg1].classNum, "specialty" .. f14_arg0 + CoD.CACUtility.maxPerkCategories, 0)
end

CoD.BonusCardButton.BonusCardUnequipped.bonuscard_perk_1_greed = function (f15_arg0)
	CoD.BonusCardButton.PerkBonusCardUnequipped(1, f15_arg0)
end

CoD.BonusCardButton.BonusCardUnequipped.bonuscard_perk_2_greed = function (f16_arg0)
	CoD.BonusCardButton.PerkBonusCardUnequipped(2, f16_arg0)
end

CoD.BonusCardButton.BonusCardUnequipped.bonuscard_perk_3_greed = function (f17_arg0)
	CoD.BonusCardButton.PerkBonusCardUnequipped(3, f17_arg0)
end

CoD.BonusCardButton.BonusCardSetup = function (f18_arg0)
	local f18_local0 = LUI.UIImage.new()
	f18_local0:setLeftRight(true, true, 0, 0)
	f18_local0:setTopBottom(true, true, 0, 0)
	f18_local0:setRGB(0, 0, 0)
	f18_local0:setAlpha(0.3)
	f18_local0:setPriority(-110)
	f18_arg0:addElement(f18_local0)
	CoD.CustomClass.SetupButtonImages(f18_arg0, CoD.BonusCardGridButton.glowBackColor, CoD.BonusCardGridButton.glowFrontColor)
	local f18_local1 = 3
	local f18_local2 = 6
	f18_arg0.name = LUI.UIText.new()
	f18_arg0.name:setLeftRight(true, true, f18_local2, 0)
	f18_arg0.name:setTopBottom(true, false, f18_local1, f18_local1 + CoD.textSize.ExtraSmall)
	f18_arg0.name:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f18_arg0.name:setFont(CoD.fonts.ExtraSmall)
	f18_arg0.name:setAlignment(LUI.Alignment.Left)
	f18_arg0.name:setPriority(100)
	f18_arg0:addElement(f18_arg0.name)
	f18_local1 = f18_local1 + CoD.textSize.ExtraSmall + 3
	f18_arg0.desc = LUI.UIText.new()
	f18_arg0.desc:setLeftRight(true, true, f18_local2, -80)
	f18_arg0.desc:setTopBottom(true, false, f18_local1, f18_local1 + CoD.textSize.ExtraSmall)
	f18_arg0.desc:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f18_arg0.desc:setAlpha(0.5)
	f18_arg0.desc:setFont(CoD.fonts.ExtraSmall)
	f18_arg0.desc:setAlignment(LUI.Alignment.Left)
	f18_arg0.desc:setPriority(100)
	f18_arg0:addElement(f18_arg0.desc)
end

