CoD.BonusCardGridButton = {}
CoD.BonusCardGridButton.glowBackColor = {}
CoD.BonusCardGridButton.glowBackColor.r = 0.6
CoD.BonusCardGridButton.glowBackColor.g = 0
CoD.BonusCardGridButton.glowBackColor.b = 0
CoD.BonusCardGridButton.glowFrontColor = {}
CoD.BonusCardGridButton.glowFrontColor.r = CoD.BOIIOrange.r
CoD.BonusCardGridButton.glowFrontColor.g = CoD.BOIIOrange.g
CoD.BonusCardGridButton.glowFrontColor.b = CoD.BOIIOrange.b
CoD.BonusCardGridButton.new = function (f1_arg0)
	local f1_local0 = CoD.ContentGridButton.new(f1_arg0)
	f1_local0.statIndex = f1_arg0
	CoD.ContentGridButton.SetupButtonText(f1_local0, Engine.Localize(UIExpression.GetItemName(nil, f1_arg0)))
	CoD.BonusCardGridButton.SetupButtonImages(f1_local0, UIExpression.GetItemImage(nil, f1_arg0))
	f1_local0:setRestrictedImage(Engine.IsItemIndexRestricted(f1_arg0))
	f1_local0:registerEventHandler("update_class", CoD.BonusCardGridButton.UpdateClass)
	return f1_local0
end

CoD.BonusCardGridButton.SetupButtonImages = function (f2_arg0, f2_arg1)
	local f2_local0 = 120
	local f2_local1 = f2_local0 * 2
	local f2_local2 = -19
	f2_arg0:setImage(f2_arg1, f2_local1, f2_local0)
	f2_arg0.itemImage:setTopBottom(true, false, f2_local2, f2_local2 + f2_local0)
	f2_arg0.itemImage:setPriority(-70)
	CoD.ContentGridButton.SetupButtonImages(f2_arg0, CoD.BonusCardGridButton.glowBackColor, CoD.BonusCardGridButton.glowFrontColor)
end

CoD.BonusCardGridButton.UpdateClass = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1.controller
	local f3_local1 = f3_arg1.classNum
	local f3_local2 = CoD.GetUnlockablesByGroupName("bonuscard")
	local f3_local3 = {}
	local f3_local4 = 1
	for f3_local8, f3_local9 in ipairs(f3_local2) do
		if CoD.CACUtility.IsBonusCardEquippedByIndex(f3_arg1.class, f3_local9) then
			f3_local3[f3_local4] = f3_local9
			f3_local4 = f3_local4 + 1
		end
	end
	for f3_local5 = 1, #f3_local3, 1 do
		f3_arg0:setHintText(nil)
		if f3_arg0.contentIndex == f3_local3[f3_local5] then
			f3_arg0:setMutuallyExclusive(f3_arg0.contentIndex)
			f3_arg0:setHintText(Engine.Localize("MPUI_ITEM_CURRENTLY_EQUIPPED_IN_ANOTHER_SLOT"))
			break
		end
	end
	if f3_arg0.statIndex ~= nil then
		if Engine.IsItemNew(f3_local0, f3_arg0.statIndex) then
			f3_arg0:setNew(true, f3_local0)
		else
			f3_arg0:setNew(false, f3_local0)
		end
		if UIExpression.IsItemLocked(f3_local0, f3_arg0.statIndex) ~= 0 then
			f3_arg0:setLocked(true, f3_local0, true)
		else
			f3_arg0:setLocked(false)
			if UIExpression.IsItemPurchased(f3_local0, f3_arg0.statIndex) ~= 0 then
				f3_arg0:setPurchased(true)
				f3_arg0:setInactive(false)
			else
				f3_arg0:setPurchased(false)
			end
		end
		f3_local5 = UIExpression.GetItemRef(nil, f3_arg0.statIndex)
		if CoD.BonusCardGridButton.CanEquipGunfighterPerk(f3_local0, f3_local1, f3_local5, "primary") == false then
			f3_arg0:setInactive(true)
			f3_arg0:setHintText(Engine.Localize("MENU_BONUSCARD_PRIMARY_GUNFIGHTER_NA"))
		end
		if CoD.BonusCardGridButton.CanEquipGunfighterPerk(f3_local0, f3_local1, f3_local5, "secondary") == false then
			f3_arg0:setInactive(true)
			f3_arg0:setHintText(Engine.Localize("MENU_BONUSCARD_SECONDARY_GUNFIGHTER_NA"))
		end
		f3_local6 = UIExpression.GetItemIndex(nil, "bonuscard_danger_close")
		if f3_local5 == "bonuscard_two_tacticals" and CoD.CACUtility.IsBonusCardEquippedByIndex(f3_arg1.class, f3_local6) then
			f3_arg0:setMutuallyExclusive(f3_local6)
			f3_arg0:setHintText(Engine.Localize("MENU_BONUSCARD_TWO_TACTICALS_NA"))
		end
		f3_local7 = UIExpression.GetItemIndex(nil, "bonuscard_two_tacticals")
		if f3_local5 == "bonuscard_danger_close" and CoD.CACUtility.IsBonusCardEquippedByIndex(f3_arg1.class, f3_local7) then
			f3_arg0:setMutuallyExclusive(f3_local7)
			f3_arg0:setHintText(Engine.Localize("MENU_BONUSCARD_DANGER_CLOSE_NA"))
		end
	end
	if f3_arg0.mutuallyExclusiveIcon == nil and f3_arg0.lockImage == nil and f3_arg0.tokenImage == nil then
		f3_arg0:setHintText(nil)
	end
end

CoD.BonusCardGridButton.CanEquipGunfighterPerk = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	if f4_arg2 == "bonuscard_" .. f4_arg3 .. "_gunfighter" and CoD.SlotList.GetAttachmentCountByStatName(f4_arg0, f4_arg1, f4_arg3) == 0 then
		return false
	else
		return true
	end
end

