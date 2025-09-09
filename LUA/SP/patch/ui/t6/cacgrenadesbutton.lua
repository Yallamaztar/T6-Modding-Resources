require("T6.SlotListGridButton")
CoD.CACGrenadesButton = {}
CoD.CACGrenadesButton.IconSizeRatio = 0.75
CoD.CACGrenadesButton.new = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = CoD.SlotListGridButton.new("CACGrenadesButton." .. f1_arg0, f1_arg2, math.min(f1_arg1, CoD.SlotList.SlotHeight))
	f1_local0.weaponStatName = f1_arg0
	f1_local0.slotList.canEdit = CoD.CACGrenadesButton.CanEdit
	f1_local0.slotList.setupElementsFunction = CoD.CACGrenadesButton.GrenadeSetup
	f1_local0.slotList.addPreviewElementsFunction = CoD.CACGrenadesButton.AddBonusCardPreviewElements
	f1_local0:registerEventHandler("button_over", CoD.CACGrenadesButton.ButtonOver)
	f1_local0:registerEventHandler("slotlist_button_action", CoD.CACGrenadesButton.SlotListButtonAction)
	f1_local0:registerEventHandler("slotlist_unequip", CoD.CACGrenadesButton.SlotListUnequip)
	f1_local0:registerEventHandler("update_class", CoD.CACGrenadesButton.UpdateClassData)
	return f1_local0
end

CoD.CACGrenadesButton.SlotListButtonAction = function (f2_arg0, f2_arg1)
	f2_arg0:dispatchEventToParent({
		name = "grenades_chosen",
		controller = f2_arg1.controller,
		weaponSlot = f2_arg0.weaponStatName,
		slotIndex = f2_arg1.slotIndex,
		button = f2_arg0.slotList.slots[f2_arg1.slotIndex]
	})
end

CoD.CACGrenadesButton.ButtonPromptUnequip = function (f3_arg0, f3_arg1)
	f3_arg0:removeUnequipPrompt()
	f3_arg0:dispatchEventToParent({
		name = "grenades_chosen",
		controller = f3_arg1.controller,
		weaponSlot = f3_arg0.weaponStatName,
		slotIndex = f3_arg0.slotIndex,
		button = f3_arg0
	})
end

CoD.CACGrenadesButton.UpdateClassData = function (f4_arg0, f4_arg1)
	if f4_arg0.weaponStatName == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
		if CoD.CACUtility.IsBonusCardEquippedByName(f4_arg1.class, "bonuscard_two_tacticals") then
			f4_arg0:setTitle(Engine.Localize("MPUI_SECOND_SPECIAL_GRENADE_CAPS"))
		else
			f4_arg0:setTitle(Engine.Localize("MPUI_PRIMARY_GRENADE_CAPS"))
		end
	end
	local f4_local0 = f4_arg1.class[f4_arg0.weaponStatName]
	local f4_local1 = f4_arg1.class[f4_arg0.weaponStatName .. "count"]
	local f4_local2 = CoD.CACUtility.IsBonusCardEquippedByName(f4_arg1.class, "bonuscard_danger_close")
	if f4_local2 then
		f4_local2 = f4_arg0.weaponStatName == CoD.CACUtility.loadoutSlotNames.primaryGrenade
	end
	local f4_local3 = CoD.CACUtility.IsBonusCardEquippedByName(f4_arg1.class, "bonuscard_two_tacticals")
	if not f4_local1 then
		f4_local1 = 0
	end
	local f4_local4 = {}
	local f4_local5 = nil
	local f4_local6 = 0
	if f4_arg0.weaponStatName == CoD.CACUtility.loadoutSlotNames.primaryGrenade and not f4_local3 then
		f4_local5 = 1
		if f4_local2 or f4_arg0.showBonuscardPreview == true then
			f4_local6 = 1
		end
	else
		f4_local5 = 2
	end
	if f4_local5 == 0 then
		f4_local5 = 1
	end
	if f4_local0 ~= nil then
		local f4_local7 = math.min(f4_local5 + f4_local6, Engine.GetMaxAmmoForItem(f4_local0))
		if f4_local7 < f4_local5 + f4_local6 then
			f4_local5 = f4_local7
			f4_local6 = 0
		end
	end
	local f4_local7 = 0
	local f4_local8 = nil
	if f4_local0 ~= nil then
		for f4_local9 = 1, f4_local5 + f4_local6, 1 do
			if Engine.GetClassItem(f4_arg1.controller, f4_arg1.classNum, f4_arg0.weaponStatName .. "status" .. f4_local9) == 1 then
				f4_local4[f4_local9] = UIExpression.GetItemImage(nil, f4_local0) .. "_256"
				f4_local7 = f4_local7 + 1
			end
		end
		f4_local8 = Engine.IsItemIndexRestricted(f4_local0)
		f4_arg0.slotList.hasGrenades = true
	else
		f4_arg0.slotList.hasGrenades = false
	end
	if f4_local7 > 0 and f4_local0 ~= nil then
		local f4_local9 = Engine.Localize(UIExpression.GetItemName(nil, f4_local0))
		if f4_local7 > 1 then
			f4_local9 = f4_local9 .. " x" .. f4_local7
		end
		f4_arg0:setSubtitle(f4_local9)
	else
		f4_arg0:setSubtitle("")
	end
	f4_arg0.slotList:update(f4_local5, f4_local6, f4_local4, f4_arg1.preview, nil, f4_local2)
	local f4_local9 = f4_arg0.slotList.slotHeight * CoD.CACGrenadesButton.IconSizeRatio
	local f4_local10 = f4_arg0.slotList.slots[1]
	f4_local10.icon:setLeftRight(false, false, -f4_local9 / 2, f4_local9 / 2)
	f4_local10.icon:setTopBottom(false, false, -f4_local9 / 2, f4_local9 / 2)
	local f4_local11 = RegisterMaterial("kd_chart_plus")
	for f4_local12 = 2, f4_local5 + f4_local6, 1 do
		local f4_local15 = f4_arg0.slotList.slots[f4_local12]
		CoD.CACGrenadesButton.SetupSmallGrenadeButton(f4_arg0.slotList, f4_local15, f4_local12)
		f4_local15.handleUnequipPrompt = CoD.CACGrenadesButton.ButtonPromptUnequip
		f4_local15.weaponStatName = f4_arg0.weaponStatName
		f4_local15.slotIndex = f4_local12
		if f4_local15.plusSign then
			f4_local15.plusSign:close()
			f4_local15.plusSign = nil
		end
		if f4_arg1.preview ~= true then
			if f4_local7 == 0 then
				f4_local15.icon:setAlpha(0)
			end
			if f4_local7 == 1 then
				f4_local15.icon:setAlpha(0)
				local f4_local16 = 40
				f4_local15.plusSign = LUI.UIImage.new()
				f4_local15.plusSign:setLeftRight(false, false, -f4_local16 / 2, f4_local16 / 2)
				f4_local15.plusSign:setTopBottom(false, false, -f4_local16 / 2, f4_local16 / 2)
				f4_local15.plusSign:setImage(f4_local11)
				f4_local15:addElement(f4_local15.plusSign)
			end
			if f4_local7 > 1 then

			end
		end
	end
	for f4_local17, f4_local15 in ipairs(f4_arg0.slotList.slots) do
		f4_local15:setRestrictedImage(f4_local8)
	end
	if not CoD.isSinglePlayer then
		f4_arg0:setNew(Engine.IsLoadoutSlotNew(f4_arg1.controller, f4_arg0.weaponStatName))
	end
end

CoD.CACGrenadesButton.SetupSmallGrenadeButton = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = f5_arg0.slotHeight * 0.7
	local f5_local1 = f5_local0 * 1.1
	local f5_local2 = 0
	local f5_local3 = f5_arg0.slotWidth + f5_arg0.spacing + f5_local1 * (f5_arg2 - 2)
	f5_arg1:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = false,
		left = f5_local3,
		right = f5_local3 + f5_local1,
		topAnchor = true,
		bottomAnchor = false,
		top = f5_local2,
		bottom = f5_local2 + f5_local0,
		zoom = 0
	})
	f5_arg1:animateToState("default")
	if f5_arg1.icon then
		local f5_local4 = f5_local0 * CoD.CACGrenadesButton.IconSizeRatio
		f5_arg1.icon:registerAnimationState("default", {
			leftAnchor = false,
			rightAnchor = false,
			left = -f5_local4 / 2,
			right = f5_local4 / 2,
			topAnchor = false,
			bottomAnchor = false,
			top = -f5_local4 / 2,
			bottom = f5_local4 / 2
		})
		f5_arg1.icon:animateToState("default")
	end
	CoD.GrowingGridButton.SetupUnequipButton(f5_arg1, nil, nil, nil)
end

CoD.CACGrenadesButton.CanEdit = function (f6_arg0)
	return CoD.SlotList.CanEdit(f6_arg0)
end

CoD.CACGrenadesButton.SlotListUnequip = function (f7_arg0, f7_arg1)
	local controller = f7_arg1.controller
	local classNum = nil
	if CoD.isSinglePlayer == true then
		classNum = CoD.perController[controller].classNumInternal
	else
		classNum = CoD.perController[controller].classNum
	end
	local slotName = f7_arg0.weaponStatName
	CoD.EquipNotification.AddToNotificationQueue("item", "unequipped", UIExpression.GetItemName(nil, Engine.GetClassItem(controller, classNum, slotName)))
	Engine.SetClassItem(controller, classNum, slotName, 0)
	Engine.SetClassItem(controller, classNum, slotName .. "status1", 0)
	Engine.SetClassItem(controller, classNum, slotName .. "status2", 0)
	Engine.SetClassItem(controller, classNum, slotName .. "status3", 0)
	Engine.SetClassItem(controller, classNum, slotName .. "count", 0)
end

CoD.CACGrenadesButton.GrenadeSetup = function (f8_arg0)
	CoD.CustomClass.SetupButtonImages(f8_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
	CoD.GrowingGridButton.SetupUnequipButton(f8_arg0, 5, -4, 20, 8)
end

CoD.CACGrenadesButton.AddBonusCardPreviewElements = function (f9_arg0, f9_arg1, f9_arg2)
	CoD.CACGrenadesButton.SetupSmallGrenadeButton(f9_arg1, f9_arg0, f9_arg2)
	CoD.CustomClass.AddBonusCardPreviewElements(f9_arg0)
end

CoD.CACGrenadesButton.ButtonOver = function (f10_arg0, f10_arg1)
	if CoD.CACUtility.highLightedGridButtonColumn ~= nil then
		CoD.CACUtility.lastHighLightedGridButtonColumn = CoD.CACUtility.highLightedGridButtonColumn
	end
	CoD.CACUtility.highLightedGridButtonColumn = "right"
	CoD.SlotListGridButton.ButtonOver(f10_arg0, f10_arg1)
end

