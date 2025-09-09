require("T6.SlotListGridButton")
CoD.CACPerksButton = {}
CoD.CACPerksButton.SetupFunctions = {}
CoD.CACPerksButton.new = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = CoD.SlotListGridButton.new("PerkCategory" .. f1_arg0, f1_arg2, math.min(f1_arg1, CoD.SlotList.SlotHeight))
	f1_local0.perkCategory = f1_arg0
	f1_local0.slotList.setupElementsFunction = CoD.CACPerksButton.SetupFunctions[f1_arg0]
	f1_local0.slotList.addPreviewElementsFunction = CoD.CustomClass.AddBonusCardPreviewElements
	f1_local0:registerEventHandler("button_over", CoD.CACPerksButton.ButtonOver)
	f1_local0:registerEventHandler("slotlist_button_action", CoD.CACPerksButton.SlotListButtonAction)
	f1_local0:registerEventHandler("slotlist_unequip", CoD.CACPerksButton.SlotListUnequip)
	f1_local0:registerEventHandler("update_class", CoD.CACPerksButton.UpdateClassData)
	return f1_local0
end

CoD.CACPerksButton.SetPerkNames = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	local f2_local0 = 1
	for f2_local1 = 1, f2_arg2, 1 do
		local f2_local4 = f2_arg3["specialty" .. f2_arg1 + f2_local1 - 1 * CoD.CACUtility.maxPerkCategories]
		local f2_local5 = ""
		if f2_local4 ~= nil then
			f2_local5 = UIExpression.GetItemName(nil, f2_local4)
		end
		if f2_local0 == 1 then
			f2_arg0:setSubtitle(Engine.Localize(f2_local5))
		elseif f2_local0 == 2 then
			f2_arg0:setSubtitle2(Engine.Localize(f2_local5))
		end
		f2_local0 = f2_local0 + 1
	end
end

CoD.CACPerksButton.UpdateClassData = function (f3_arg0, f3_arg1)
	f3_arg0.class = f3_arg1.class
	CoD.SlotList.PopulateWithPerks(f3_arg0.slotList, f3_arg1.controller, f3_arg1.classNum, f3_arg0.perkCategory, f3_arg1.class, f3_arg1.preview)
	CoD.CACPerksButton.SetPerkNames(f3_arg0, f3_arg0.perkCategory, 2, f3_arg1.class)
	if not CoD.isSinglePlayer then
		f3_arg0:setNew(Engine.IsLoadoutSlotNew(f3_arg1.controller, "specialty" .. f3_arg0.perkCategory))
	end
end

CoD.CACPerksButton.SlotListButtonAction = function (f4_arg0, f4_arg1)
	f4_arg0:dispatchEventToParent({
		name = "perk_slot_chosen",
		controller = f4_arg1.controller,
		perkCategory = f4_arg0.perkCategory,
		slotIndex = f4_arg1.slotIndex,
		class = f4_arg0.class
	})
end

CoD.CACPerksButton.SlotListUnequip = function (f5_arg0, f5_arg1)
	CoD.CACRemoveItem.RemovePerk(f5_arg1.controller, CoD.perController[f5_arg1.controller].classNum, CoD.CACPerksP.GetLoadoutSlot(f5_arg0.perkCategory, f5_arg1.slotIndex))
end

CoD.CACPerksButton.PerkSetup = function (f6_arg0, f6_arg1)
	CoD.CustomClass.SetupButtonImages(f6_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
	CoD.GrowingGridButton.SetupUnequipButton(f6_arg0, 5, -4, 20, 8)
end

CoD.CACPerksButton.SetupFunctions[1] = function (f7_arg0)
	CoD.CACPerksButton.PerkSetup(f7_arg0, 1)
end

CoD.CACPerksButton.SetupFunctions[2] = function (f8_arg0)
	CoD.CACPerksButton.PerkSetup(f8_arg0, 2)
end

CoD.CACPerksButton.SetupFunctions[3] = function (f9_arg0)
	CoD.CACPerksButton.PerkSetup(f9_arg0, 3)
end

CoD.CACPerksButton.ButtonOver = function (f10_arg0, f10_arg1)
	if CoD.CACUtility.highLightedGridButtonColumn ~= nil then
		CoD.CACUtility.lastHighLightedGridButtonColumn = CoD.CACUtility.highLightedGridButtonColumn
	end
	CoD.CACUtility.highLightedGridButtonColumn = "right"
	CoD.SlotListGridButton.ButtonOver(f10_arg0, f10_arg1)
end

