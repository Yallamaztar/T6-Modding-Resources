CoD.AttachmentGridButton = {}
CoD.AttachmentGridButton.LineMaterialName = "menu_mp_cac_gren_fill"
CoD.AttachmentGridButton.HighlightMaterialName = "menu_mp_cac_gren_hl"
CoD.AttachmentGridButton.new = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = CoD.ContentGridButton.new(f1_arg1)
	f1_local0.itemIsOld = true
	f1_local0.newAttachment = f1_arg2
	f1_local0.weaponItemIndex = f1_arg0
	f1_local0:setBottomTitle(Engine.Localize(Engine.GetAttachmentName(f1_arg0, f1_arg1)))
	CoD.AttachmentGridButton.SetupButtonImages(f1_local0, Engine.GetAttachmentImage(f1_arg0, f1_arg1))
	f1_local0.attachmentNum = f1_arg1
	local f1_local1 = Engine.GetItemAttachment(f1_arg0, f1_arg1)
	if f1_local1 and Engine.IsAttachmentIndexRestricted(f1_local1) then
		f1_local0.restrictedIcon = LUI.UIImage.new()
		f1_local0.restrictedIcon:setLeftRight(false, false, -16, 16)
		f1_local0.restrictedIcon:setTopBottom(false, false, -16, 16)
		f1_local0.restrictedIcon:setImage(RegisterMaterial("cac_restricted"))
		f1_local0:addElement(f1_local0.restrictedIcon)
	end
	f1_local0:registerEventHandler("update_class", CoD.AttachmentGridButton.UpdateClass)
	f1_local0.gainFocusSFX = "cac_grid_nav"
	f1_local0.actionSFX = "cac_grid_equip_item"
	f1_local0.setNew = CoD.AttachmentGridButton.SetNew
	return f1_local0
end

CoD.AttachmentGridButton.SetNew = function (f2_arg0, f2_arg1, f2_arg2)
	if not f2_arg1 then
		CoD.Unlockables.SetAttachmentUnlocked(f2_arg0.weaponItemIndex, f2_arg0.attachmentNum, false, true)
	end
	CoD.ContentGridButton.SetNew(f2_arg0, f2_arg1, f2_arg2)
end

CoD.AttachmentGridButton.SetupButtonImages = function (f3_arg0, f3_arg1)
	local f3_local0 = 75
	local f3_local1 = 75
	f3_arg0:setImage(f3_arg1, f3_local0, f3_local1)
	f3_arg0.itemImage:setTopBottom(true, false, 15, 15 + f3_local1)
	f3_arg0.background = CoD.Border.new(1, CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b, CoD.CACClassLoadout.DefaultButtonAlpha * 2, 3, 8)
	f3_arg0:addElement(f3_arg0.background)
	
	local highlight = LUI.UIImage.new()
	highlight:setLeftRight(true, true, -4, 4)
	highlight:setTopBottom(true, true, -3, 6)
	highlight:setImage(RegisterMaterial("menu_mp_cac_caro_perk_line"))
	highlight:setAlpha(0)
	f3_arg0:addElement(highlight)
	f3_arg0.highlight = highlight
	
	if f3_arg0.backgroundGradient then
		f3_arg0.backgroundGradient:setTopBottom(true, true, 8, 0)
		f3_arg0.backgroundGradient:setLeftRight(true, true, 3, -3)
	end
	if f3_arg0.grid then
		f3_arg0.grid:close()
	end
	if f3_arg0.newAttachment ~= nil and f3_arg0.newAttachment then
		f3_arg0:setNew(f3_arg0.newAttachment)
	end
end

CoD.AttachmentGridButton.GetRequiredXP = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = ""
	if f4_arg2 ~= nil and Engine.GetItemAttachmentLocked(f4_arg0, f4_arg1, f4_arg2) ~= 0 then
		local f4_local1 = Engine.GetItemAttachmentXP(f4_arg1, f4_arg2)
		local f4_local2 = UIExpression.GetDStat(f4_arg0, "itemstats", f4_arg1, "xp")
		if f4_local2 < f4_local1 then
			f4_local0 = Engine.Localize("MPUI_GUN_XP_REQUIRED", f4_local1 - f4_local2)
		end
	end
	return f4_local0
end

CoD.AttachmentGridButton.UpdateClass = function (f5_arg0, f5_arg1)
	if Engine.GetItemAttachmentLocked(f5_arg1.controller, f5_arg0.weaponItemIndex, f5_arg0.contentIndex) ~= 0 then
		f5_arg0:setLocked(true, UIExpression.GetPrimaryController(), true)
		return 
	end
	f5_arg0:setLocked(false)
	f5_arg0:setMutuallyExclusive(nil)
	f5_arg0:setHintText(nil, nil)
	f5_arg0:setInUse(false, CoD.ContentGridButton.InUseDefaultSize.left + 3)
	local f5_local0 = Engine.GetAttachmentAttachPoint(f5_arg0.weaponItemIndex, f5_arg0.contentIndex)
	local f5_local1 = CoD.perController[f5_arg1.controller].weaponSlot
	for f5_local6, f5_local7 in ipairs(CoD.CACUtility.attachmentPointNames) do
		local f5_local8 = f5_arg1.class[f5_local1 .. "attachment" .. f5_local7]
		if f5_local8 == f5_arg0.contentIndex then
			f5_arg0:setInUse(true, CoD.ContentGridButton.InUseDefaultSize.left + 3)
			f5_arg0:setHintText(Engine.Localize("SPUI_ITEM_CURRENTLY_EQUIPPED"), nil)
		end
		if f5_local8 ~= nil and f5_local8 ~= 0 and Engine.AreAttachmentsCompatible(f5_arg0.weaponItemIndex, f5_local8, f5_arg0.contentIndex) ~= true then
			f5_arg0:setMutuallyExclusive(f5_local8)
			local f5_local5 = f5_arg0.mutuallyExclusiveIndices
			if #f5_local5 == 1 then
				f5_arg0:setHintText(Engine.Localize("MPUI_ITEM_MUTUALLY_EXCLUSIVE", Engine.Localize(Engine.GetAttachmentName(f5_arg0.weaponItemIndex, f5_local5[1]))), CoD.CACUtility.EquipImageMaterial)
			end
			if #f5_arg0.mutuallyExclusiveIndices == 2 then
				f5_arg0:setHintText(Engine.Localize("MPUI_ITEM_MUTUALLY_EXCLUSIVE_2", Engine.Localize(Engine.GetAttachmentName(f5_arg0.weaponItemIndex, f5_local5[1])), Engine.Localize(Engine.GetAttachmentName(f5_arg0.weaponItemIndex, f5_local5[2]))), CoD.CACUtility.EquipImageMaterial)
			end
			if #f5_arg0.mutuallyExclusiveIndices == 3 then
				f5_arg0:setHintText(Engine.Localize("MPUI_ITEM_MUTUALLY_EXCLUSIVE_3", Engine.Localize(Engine.GetAttachmentName(f5_arg0.weaponItemIndex, f5_local5[1])), Engine.Localize(Engine.GetAttachmentName(f5_arg0.weaponItemIndex, f5_local5[2])), Engine.Localize(Engine.GetAttachmentName(f5_arg0.weaponItemIndex, f5_local5[3]))), CoD.CACUtility.EquipImageMaterial)
			end
		end
	end
end

