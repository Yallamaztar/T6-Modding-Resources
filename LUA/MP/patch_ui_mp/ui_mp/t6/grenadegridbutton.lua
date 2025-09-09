CoD.GrenadeGridButton = {}
CoD.GrenadeGridButton.glowBackColor = {}
CoD.GrenadeGridButton.glowBackColor.r = 1
CoD.GrenadeGridButton.glowBackColor.g = 1
CoD.GrenadeGridButton.glowBackColor.b = 1
CoD.GrenadeGridButton.glowFrontColor = {}
CoD.GrenadeGridButton.glowFrontColor.r = 1
CoD.GrenadeGridButton.glowFrontColor.g = 1
CoD.GrenadeGridButton.glowFrontColor.b = 1
CoD.GrenadeGridButton.new = function (f1_arg0)
	local f1_local0 = CoD.ContentGridButton.new(f1_arg0)
	f1_local0.statIndex = f1_arg0
	CoD.ContentGridButton.SetupButtonText(f1_local0, Engine.Localize(UIExpression.GetItemName(nil, f1_arg0)))
	CoD.GrenadeGridButton.SetupButtonImages(f1_local0, UIExpression.GetItemImage(nil, f1_arg0))
	f1_local0:setRestrictedImage(Engine.IsItemIndexRestricted(f1_arg0))
	f1_local0:registerEventHandler("update_class", CoD.GrenadeGridButton.UpdateClass)
	f1_local0.actionSFX = "cac_equipment_add"
	return f1_local0
end

CoD.GrenadeGridButton.SetupButtonImages = function (f2_arg0, f2_arg1)
	local f2_local0 = 75
	local f2_local1 = f2_local0
	local f2_local2 = 15
	f2_arg0:setImage(f2_arg1 .. "_256", f2_local1, f2_local0)
	f2_arg0.itemImage:setTopBottom(true, false, f2_local2, f2_local2 + f2_local0)
	f2_arg0.itemImage:setPriority(-70)
	CoD.ContentGridButton.SetupButtonImages(f2_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
end

CoD.GrenadeGridButton.UpdateClass = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1.controller
	local f3_local1 = f3_arg1.classNum
	local f3_local2, f3_local3 = nil
	if CoD.perController[f3_local0].grenadeSlot == CoD.CACUtility.loadoutSlotNames.primaryGrenade then
		f3_local3 = CoD.CACUtility.loadoutSlotNames.specialGrenade
	else
		f3_local3 = CoD.CACUtility.loadoutSlotNames.primaryGrenade
	end
	f3_local2 = CoD.GetClassItem(f3_local0, f3_local1, f3_local3)
	if Engine.IsItemNew(f3_local0, f3_arg0.statIndex) then
		f3_arg0:setNew(true, f3_local0)
	else
		f3_arg0:setNew(false, f3_local0)
	end
	f3_arg0:setHintText(nil)
	if f3_arg0.contentIndex == f3_local2 then
		f3_arg0:setInUseFill()
	end
	if UIExpression.IsItemLocked(f3_local0, f3_arg0.contentIndex) ~= 0 then
		f3_arg0:setLocked(true, f3_local0, true)
	else
		f3_arg0:setLocked(false)
		if UIExpression.IsItemPurchased(f3_local0, f3_arg0.contentIndex) ~= 0 then
			f3_arg0:setPurchased(true)
		else
			f3_arg0:setPurchased(false)
		end
	end
	if f3_arg0.mutuallyExclusiveIcon == nil and f3_arg0.lockImage == nil and f3_arg0.tokenImage == nil then
		f3_arg0:setHintText(nil)
	end
end

