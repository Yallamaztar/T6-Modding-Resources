CoD.CamoGridButton = {}
CoD.CamoGridButton.HighlightMaterialName = "menu_mp_camo_box"
CoD.CamoGridButton.new = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.ContentGridButton.new(f1_arg0, selected)
	f1_local0.camoItemIndex = f1_arg0
	f1_local0.itemIsOld = true
	f1_local0.statIndex = UIExpression.GetWeaponOptionGroupIndex(nil, f1_arg0 - 1, CoD.CACUtility.weaponGroupNames.camo)
	f1_local0.newCamo = f1_arg1
	f1_local0.setupButtonImages = CoD.CamoGridButton.SetupButtonImages
	f1_local0.gainFocusSFX = "cac_grid_nav"
	f1_local0.actionSFX = "cac_grid_equip_item"
	f1_local0:registerEventHandler("update_class", CoD.CamoGridButton.UpdateClass)
	f1_local0.setNew = CoD.CamoGridButton.SetNew
	return f1_local0
end

CoD.CamoGridButton.SetNew = function (f2_arg0, f2_arg1, f2_arg2)
	if not f2_arg1 then
		CoD.Unlockables.SetCamoUnlocked(f2_arg0.camoItemIndex - 1, false, true)
	end
	CoD.ContentGridButton.SetNew(f2_arg0, f2_arg1, f2_arg2)
end

CoD.CamoGridButton.SetupButtonImages = function (f3_arg0)
	local f3_local0 = UIExpression.GetWeaponOptionImage(nil, f3_arg0.statIndex)
	local f3_local1 = 1.36 * f3_arg0.itemWidth
	local f3_local2 = 1.78 * f3_arg0.itemHeight - 6
	local f3_local3 = 0
	f3_arg0.borderImage = CoD.Border.new(1, CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b, CoD.CACClassLoadout.DefaultButtonAlpha * 2, -2)
	f3_arg0:addElement(f3_arg0.borderImage)
	f3_arg0.highlight = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f3_local1 / 2,
		right = f3_local1 / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = -f3_local2 / 2,
		bottom = f3_local2 / 2,
		alpha = 0,
		material = RegisterMaterial(CoD.CamoGridButton.HighlightMaterialName)
	})
	f3_arg0.highlight:setPriority(100)
	f3_arg0:addElement(f3_arg0.highlight)
	f3_arg0.highlight:registerAnimationState("button_over", {
		alpha = 1
	})
	LUI.UIButton.SetupElement(f3_arg0.highlight)
	if f3_arg0.grid then
		f3_arg0.grid:close()
		f3_arg0.grid = nil
	end
	if f3_arg0.border then
		f3_arg0.border:close()
		f3_arg0.border = nil
	end
	if f3_local0 ~= "weapon_missing_image" then
		local f3_local4 = f3_arg0.itemWidth + 2
		local f3_local5 = f3_arg0.itemHeight + 2
		f3_arg0:setImage(f3_local0, 0, 0)
		f3_arg0.itemImage:setLeftRight(false, false, -f3_local4 / 2, f3_local4 / 2)
		f3_arg0.itemImage:setTopBottom(false, false, -f3_local5 / 2, f3_local5 / 2)
	else
		local f3_local4 = LUI.UIText.new()
		f3_local4:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
		f3_local4:setLeftRight(true, true, 0, 0)
		f3_local4:setAlignment(LUI.Alignment.Center)
		f3_local4:setFont(CoD.fonts.Default)
		f3_local4:setText(UIExpression.ToUpper(nil, Engine.Localize("MPUI_NONE")))
		f3_local4:setAlpha(0.7)
		f3_arg0:addElement(f3_local4)
	end
	f3_arg0:setHintText(Engine.Localize(UIExpression.GetWeaponOptionName(controller, f3_arg0.statIndex)), nil)
	f3_arg0.shadow = LUI.UIImage.new()
	f3_arg0.shadow:setLeftRight(true, true, -12, 12)
	f3_arg0.shadow:setTopBottom(true, true, -1, 1)
	f3_arg0.shadow:setImage(RegisterMaterial("menu_camo_inner_shadow"))
	f3_arg0:addElement(f3_arg0.shadow)
	if f3_arg0.newCamo ~= nil and f3_arg0.newCamo then
		f3_arg0:setNew(f3_arg0.newCamo)
		local f3_local4 = 3
		local f3_local5 = -1
		local f3_local6 = CoD.CACUtility.ButtonGridNewImageWidth
		local f3_local7 = CoD.CACUtility.ButtonGridNewImageHeight
		f3_arg0.newImage:setLeftRight(false, true, -f3_local6 - f3_local5, -f3_local5)
		f3_arg0.newImage:setTopBottom(true, false, f3_local4, f3_local4 + f3_local7)
	end
end

CoD.CamoGridButton.UpdateClass = function (f4_arg0, f4_arg1)
	if f4_arg0.contentIndex == f4_arg1.selectedItem then
		f4_arg0:setInUse(true, 5, 5)
	else
		f4_arg0:setInUse(false, 5, 5)
	end
	if f4_arg0.itemImage then
		if Engine.GetWeaponOptionLocked(f4_arg1.controller, f4_arg0.statIndex) == 0 then
			f4_arg0:setLocked(false)
		else
			f4_arg0:setLocked(true, UIExpression.GetPrimaryController(), true)
			f4_arg0.lockImage:setTopBottom(false, false, -CoD.CACUtility.ButtonGridBigLockImageSize / 2, CoD.CACUtility.ButtonGridBigLockImageSize / 2)
			f4_arg0.lockImage:registerAnimationState("default", {
				topAnchor = false,
				bottomAnchor = false,
				top = -CoD.CACUtility.ButtonGridBigLockImageSize / 2,
				bottom = CoD.CACUtility.ButtonGridBigLockImageSize / 2
			})
		end
	end
end

