CoD.PerkGridButton = {}
CoD.PerkGridButton.glowBackColors = {}
CoD.PerkGridButton.glowFrontColors = {}
CoD.PerkGridButton.new = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.ContentGridButton.new(f1_arg0)
	f1_local0.statIndex = f1_arg0
	CoD.ContentGridButton.SetupButtonText(f1_local0, Engine.Localize(UIExpression.GetItemName(nil, f1_arg0)))
	CoD.PerkGridButton.SetupButtonImages(f1_local0, UIExpression.GetItemImage(nil, f1_arg0), f1_arg1)
	f1_local0:setRestrictedImage(Engine.IsItemIndexRestricted(f1_arg0))
	f1_local0:registerEventHandler("update_class", CoD.PerkGridButton.UpdateClass)
	return f1_local0
end

CoD.PerkGridButton.SetupButtonImages = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = 100
	local f2_local1 = f2_local0
	local f2_local2 = 2
	f2_arg0:setImage(f2_arg1 .. "_256", f2_local1, f2_local0)
	f2_arg0.itemImage:setTopBottom(true, false, f2_local2, f2_local2 + f2_local0)
	f2_arg0.itemImage:setPriority(-70)
	CoD.ContentGridButton.SetupButtonImages(f2_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
end

CoD.PerkGridButton.UpdateClass = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1.controller
	local f3_local1 = f3_arg1.classNum
	local f3_local2 = {}
	for f3_local3 = CoD.perController[f3_local0].perkCategory, CoD.CACUtility.maxSpecialtySlots, 3 do
		table.insert(f3_local2, CoD.GetClassItem(f3_local0, f3_local1, CoD.CACUtility.loadoutSlotNames["specialty" .. f3_local3]))
	end
	for f3_local6, f3_local7 in ipairs(f3_local2) do
		if f3_local6 ~= CoD.perController[f3_local0].slotIndex and f3_arg0.contentIndex == f3_local7 then
			f3_arg0:setInUseFill()
			break
		end
	end
	if Engine.IsItemNew(f3_local0, f3_arg0.statIndex) then
		f3_arg0:setNew(true)
	else
		f3_arg0:setNew(false)
	end
	if UIExpression.IsItemLocked(f3_local0, f3_arg0.statIndex) ~= 0 then
		f3_arg0:setLocked(true, f3_local0, true)
	else
		f3_arg0:setLocked(false)
		if UIExpression.IsItemPurchased(f3_local0, f3_arg0.statIndex) ~= 0 then
			f3_arg0:setPurchased(true)
		else
			f3_arg0:setPurchased(false)
		end
	end
	if f3_arg0.mutuallyExclusiveIcon == nil and f3_arg0.lockImage == nil and f3_arg0.tokenImage == nil then
		f3_arg0:setHintText(nil)
	end
end

