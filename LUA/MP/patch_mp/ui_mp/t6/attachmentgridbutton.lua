CoD.AttachmentGridButton = {}
CoD.AttachmentGridButton.new = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.ContentGridButton.new(f1_arg1)
	f1_local0.itemIsOld = true
	f1_local0.weaponItemIndex = f1_arg0
	CoD.ContentGridButton.SetupButtonText(f1_local0, Engine.Localize(Engine.GetAttachmentName(f1_arg0, f1_arg1) .. "_SHORT"))
	CoD.AttachmentGridButton.SetupButtonImages(f1_local0, Engine.GetAttachmentImage(f1_arg0, f1_arg1))
	f1_local0.attachmentNum = f1_arg1
	local f1_local1 = Engine.GetItemAttachment(f1_arg0, f1_arg1)
	local f1_local2 = f1_local0
	local f1_local3 = f1_local0.setRestrictedImage
	local f1_local4
	if f1_local1 == 0 then
		f1_local4 = f1_local1
	else
		f1_local4 = Engine.IsAttachmentIndexRestricted(f1_local1)
	end
	f1_local3(f1_local2, f1_local4)
	f1_local0:registerEventHandler("update_class", CoD.AttachmentGridButton.UpdateClass)
	f1_local0.actionSFX = "cac_equipment_add"
	return f1_local0
end

CoD.AttachmentGridButton.SetupButtonImages = function (f2_arg0, f2_arg1)
	local f2_local0 = 60
	local f2_local1 = f2_local0
	local f2_local2 = 5
	f2_arg0:setImage(f2_arg1, f2_local1, f2_local0)
	f2_arg0.itemImage:setTopBottom(true, false, f2_local2, f2_local2 + f2_local0)
	f2_arg0.itemImage:setPriority(-70)
	CoD.ContentGridButton.SetupButtonImages(f2_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
end

CoD.AttachmentGridButton.GetRequiredXP = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = ""
	if f3_arg2 ~= nil and Engine.GetItemAttachmentLocked(f3_arg0, f3_arg1, f3_arg2) ~= 0 then
		local f3_local1 = Engine.GetItemAttachmentXP(f3_arg1, f3_arg2)
		local f3_local2 = UIExpression.GetDStat(f3_arg0, "itemstats", f3_arg1, "xp")
		if f3_local2 < f3_local1 then
			f3_local0 = Engine.Localize("MPUI_GUN_XP_REQUIRED", f3_local1 - f3_local2)
		end
	end
	return f3_local0
end

CoD.AttachmentGridButton.GetRewardXP = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = ""
	if f4_arg2 ~= nil and Engine.GetItemAttachmentLocked(f4_arg0, f4_arg1, f4_arg2) ~= 0 then
		local f4_local1 = Engine.GetItemAttachmentReward(f4_arg1, f4_arg2)
		if f4_local1 ~= nil and f4_local1 > 0 then
			f4_local0 = Engine.Localize("RANK_XP", f4_local1)
		end
	end
	return f4_local0
end

CoD.AttachmentGridButton.GetRequiredGunLevel = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = ""
	if f5_arg2 ~= nil and Engine.GetItemAttachmentLocked(f5_arg0, f5_arg1, f5_arg2) ~= 0 then
		local f5_local1 = Engine.GetItemAttachmentRank(f5_arg1, f5_arg2)
		if f5_local1 ~= nil then
			f5_local0 = Engine.Localize("MPUI_REQUIRES_WEAPON_LEVEL", f5_local1 + 2)
		end
	end
	return f5_local0
end

CoD.AttachmentGridButton.UpdateClass = function (f6_arg0, f6_arg1)
	if Engine.GetItemAttachmentLocked(f6_arg1.controller, f6_arg0.weaponItemIndex, f6_arg0.contentIndex) ~= 0 then
		f6_arg0:setLocked(true)
	else
		f6_arg0:setLocked(false)
	end
	if Engine.IsAttachmentNew(f6_arg1.controller, f6_arg0.weaponItemIndex, f6_arg0.contentIndex) then
		f6_arg0:setNew(true, f6_arg1.controller)
	else
		f6_arg0:setNew(false, f6_arg1.controller)
	end
	if f6_arg0.contentIndex ~= f6_arg1.attachmentIndexToReplace then
		local f6_local0 = Engine.GetAttachmentAttachPoint(f6_arg0.weaponItemIndex, f6_arg0.contentIndex)
		local f6_local1 = CoD.perController[f6_arg1.controller].weaponSlot
		for f6_local2 = 0, 2, 1 do
			local f6_local5 = f6_arg1.class[f6_local1 .. "attachment" .. f6_local2 + 1]
			if f6_arg0.lockImage ~= nil then

			end
			if f6_local5 == f6_arg0.contentIndex then
				f6_arg0:setInUseFill()
			end
			if f6_local5 ~= nil and f6_local5 ~= 0 and f6_local5 ~= f6_arg1.attachmentIndexToReplace and Engine.AreAttachmentsCompatible(f6_arg0.weaponItemIndex, f6_local5, f6_arg0.contentIndex) ~= true then
				f6_arg0:setMutuallyExclusive(f6_local5)
				local f6_local6 = f6_arg0.mutuallyExclusiveIndices
				if #f6_local6 == 1 then
					f6_arg0:setHintText(Engine.Localize("MPUI_ITEM_MUTUALLY_EXCLUSIVE", Engine.Localize(Engine.GetAttachmentName(f6_arg0.weaponItemIndex, f6_local6[1]))), CoD.CACUtility.EquipImageMaterial)
				end
				if #f6_arg0.mutuallyExclusiveIndices == 2 then
					f6_arg0:setHintText(Engine.Localize("MPUI_ITEM_MUTUALLY_EXCLUSIVE_2", Engine.Localize(Engine.GetAttachmentName(f6_arg0.weaponItemIndex, f6_local6[1])), Engine.Localize(Engine.GetAttachmentName(f6_arg0.weaponItemIndex, f6_local6[2]))), CoD.CACUtility.EquipImageMaterial)
				end
				if #f6_arg0.mutuallyExclusiveIndices == 3 then
					f6_arg0:setHintText(Engine.Localize("MPUI_ITEM_MUTUALLY_EXCLUSIVE_3", Engine.Localize(Engine.GetAttachmentName(f6_arg0.weaponItemIndex, f6_local6[1])), Engine.Localize(Engine.GetAttachmentName(f6_arg0.weaponItemIndex, f6_local6[2])), Engine.Localize(Engine.GetAttachmentName(f6_arg0.weaponItemIndex, f6_local6[3]))), CoD.CACUtility.EquipImageMaterial)
				end
			end
		end
	end
end

