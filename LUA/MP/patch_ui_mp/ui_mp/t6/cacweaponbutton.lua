require("T6.GrowingGridButton")
CoD.CACWeaponButton = {}
CoD.CACWeaponButton.AspectRatio = 2
CoD.CACWeaponButton.ImageBorder = 10
CoD.CACWeaponButton.new = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = nil
	if f1_arg0 == "primary" then
		f1_local0 = CoD.CACWeaponButton.PrimaryWeaponSetup
	elseif f1_arg0 == "secondary" then
		f1_local0 = CoD.CACWeaponButton.SecondaryWeaponSetup
	end
	local f1_local1 = CoD.GrowingGridButton.new(f1_arg2, f1_local0)
	f1_local1.weaponStatName = f1_arg0
	f1_local1.id = f1_local1.id .. "." .. f1_arg0
	local f1_local2 = 80
	local f1_local3 = f1_arg1 - CoD.CACWeaponButton.ImageBorder * 2
	local f1_local4 = f1_local3 * CoD.CACWeaponButton.AspectRatio
	f1_local1.weaponImage = LUI.UIImage.new()
	f1_local1.weaponImage:setLeftRight(false, true, -CoD.CACWeaponButton.ImageBorder - f1_local4 - f1_local2, -CoD.CACWeaponButton.ImageBorder - f1_local2)
	f1_local1.weaponImage:setTopBottom(false, false, -f1_local3 / 2, f1_local3 / 2)
	f1_local1:addToBody(f1_local1.weaponImage)
	f1_local1.weaponImage:registerAnimationState("hide", {
		alpha = 0
	})
	if CoD.ShouldShowWeaponLevel() then
		local f1_local5 = 42
		local f1_local6 = 9
		local f1_local7 = 5
		local f1_local8 = CoD.WeaponLevel.GetWeaponLevelIcon(f1_local5, f1_local5, "ExtraSmall", 1, 0, 1)
		f1_local8:setLeftRight(false, true, -f1_local6 - f1_local5, -f1_local6)
		f1_local8:setTopBottom(false, true, -f1_local7 - f1_local5, -f1_local7)
		f1_local1.weaponLevelIconContainer = f1_local8
		f1_local1:addToBody(f1_local8)
	end
	local f1_local5 = CoD.CACWeaponButton.GetCamoSwatch()
	f1_local1.camoSwatchImage = f1_local5.camoSwatchImage
	f1_local1:addToBody(f1_local5)
	f1_local1.handleUnequipPrompt = CoD.CACWeaponButton.ButtonPromptUnequip
	f1_local1:registerEventHandler("button_up", CoD.CACWeaponButton.ButtonUp)
	f1_local1:registerEventHandler("button_over", CoD.CACWeaponButton.ButtonOver)
	f1_local1:registerEventHandler("button_action", CoD.CACWeaponButton.ButtonAction)
	f1_local1:registerEventHandler("update_class", CoD.CACWeaponButton.UpdateClassData)
	return f1_local1
end

CoD.CACWeaponButton.GetCamoSwatch = function ()
	local f2_local0 = 5
	local f2_local1 = 39
	local f2_local2 = 32
	local f2_local3 = 32
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -CoD.CACWeaponButton.ImageBorder - f2_local1 - f2_local2, -CoD.CACWeaponButton.ImageBorder - f2_local1)
	Widget:setTopBottom(false, true, -f2_local0 - f2_local3, -f2_local0)
	Widget:setUseStencil(true)
	
	local camoSwatchImage = LUI.UIImage.new()
	camoSwatchImage:setLeftRight(false, true, -140, 0)
	camoSwatchImage:setTopBottom(false, true, -70, 0)
	Widget:addElement(camoSwatchImage)
	Widget.camoSwatchImage = camoSwatchImage
	
	camoSwatchImage:hide()
	return Widget
end

CoD.CACWeaponButton.ButtonPromptUnequip = function (f3_arg0, f3_arg1)
	CoD.CACRemoveItem.RemoveWeapon(f3_arg1.controller, CoD.perController[f3_arg1.controller].classNum, f3_arg0.weaponStatName)
	CoD.GrowingGridButton.ButtonPromptUnequip(f3_arg0, f3_arg1)
	f3_arg0:dispatchEventToParent({
		name = "remove_camo_button"
	})
end

CoD.CACWeaponButton.ButtonUp = function (f4_arg0, f4_arg1)
	f4_arg0:highlightSubtitle(1, true)
	CoD.GrowingGridButton.Up(f4_arg0, f4_arg1)
end

CoD.CACWeaponButton.ButtonOver = function (f5_arg0, f5_arg1)
	if CoD.CACUtility.highLightedGridButtonColumn ~= nil then
		CoD.CACUtility.lastHighLightedGridButtonColumn = CoD.CACUtility.highLightedGridButtonColumn
	end
	CoD.CACUtility.highLightedGridButtonColumn = "left"
	f5_arg0:highlightSubtitle(1)
	CoD.GrowingGridButton.Over(f5_arg0, f5_arg1)
end

CoD.CACWeaponButton.ButtonAction = function (f6_arg0, f6_arg1)
	f6_arg0:dispatchEventToParent({
		name = "weapon_chosen",
		controller = f6_arg1.controller,
		weaponSlot = f6_arg0.weaponStatName
	})
end

CoD.CACWeaponButton.UpdateClassData = function (f7_arg0, f7_arg1)
	local f7_local0 = CoD.CACUtility.IsBonusCardEquippedByName(f7_arg1.class, "bonuscard_overkill")
	local f7_local1 = nil
	if f7_arg0.weaponStatName == "secondary" then
		if f7_local0 == true then
			f7_arg0:setTitle(Engine.Localize("MPUI_SECOND_PRIMARY_CAPS"))
			if f7_arg0.bonusCardPreviewBackground then
				f7_arg0.bonusCardPreviewBackground:animateToState("show")
			end
		else
			f7_arg0:setTitle(Engine.Localize("MPUI_" .. f7_arg0.weaponStatName .. "_CAPS"))
			f7_local1 = Engine.IsLoadoutSlotNew(f7_arg1.controller, CoD.CACUtility.loadoutSlotNames.secondaryWeapon)
			if f7_arg0.bonusCardPreviewBackground then
				f7_arg0.bonusCardPreviewBackground:animateToState("default")
			end
		end
		if f7_arg0.bonusCardPreviewBackgroundPulse then
			if f7_arg1.showBonuscardPreview == true and f7_local0 == false then
				f7_arg0.bonusCardPreviewBackgroundPulse:animateToState("show")
			else
				f7_arg0.bonusCardPreviewBackgroundPulse:animateToState("default")
			end
		end
	else
		f7_arg0:setTitle(Engine.Localize("MPUI_" .. f7_arg0.weaponStatName .. "_CAPS"))
		f7_local1 = Engine.IsLoadoutSlotNew(f7_arg1.controller, CoD.CACUtility.loadoutSlotNames.primaryWeapon)
		if f7_arg0.bonusCardPreviewBackground then
			f7_arg0.bonusCardPreviewBackground:animateToState("default")
		end
	end
	f7_arg0:setNew(f7_local1)
	local f7_local2 = f7_arg1.class[f7_arg0.weaponStatName]
	if f7_local2 == nil then
		if f7_arg0.glowGradBack then
			f7_arg0.glowGradBack:animateToState("unequipped")
		end
		if f7_arg0.glowGradFront then
			f7_arg0.glowGradFront:animateToState("unequipped")
		end
		if f7_arg0.weaponImage then
			f7_arg0.weaponImage:animateToState("hide")
			f7_arg0:setSubtitle("")
		end
		if f7_arg0.weaponLevelIconContainer then
			f7_arg0.weaponLevelIconContainer:hide()
		end
		if f7_arg0.camoSwatchImage then
			f7_arg0.camoSwatchImage:hide()
		end
		f7_arg0:setRestrictedImage(false)
		f7_arg0.canBeRemoved = nil
	else
		f7_arg0.weaponIndex = f7_local2
		if f7_arg0.glowGradBack then
			if f7_arg0.weaponStatName == "secondary" and CoD.CACUtility.IsBonusCardEquippedByName(f7_arg1.class, "bonuscard_overkill") then
				CoD.CustomClass.AddBonusCardPreviewElements(f7_arg0)
			end
			f7_arg0.glowGradBack:animateToState("equipped")
		end
		if f7_arg0.glowGradFront then
			if f7_arg0.weaponStatName == "secondary" and CoD.CACUtility.IsBonusCardEquippedByName(f7_arg1.class, "bonuscard_overkill") then
				CoD.CustomClass.AddBonusCardPreviewElements(f7_arg0)
			end
			f7_arg0.glowGradFront:animateToState("equipped")
		end
		local f7_local3 = UIExpression.GetItemName(nil, f7_local2)
		f7_arg0.weaponImage:registerAnimationState("change_material", {
			alpha = 1,
			material = RegisterMaterial(UIExpression.GetItemImage(nil, f7_local2) .. "_big")
		})
		f7_arg0.weaponImage:animateToState("change_material")
		if f7_arg0.weaponLevelIconContainer then
			f7_arg0.weaponLevelIconContainer:update(f7_arg1.controller, f7_local2)
		end
		local f7_local4 = f7_arg1.class[f7_arg0.weaponStatName .. "camo"]
		if f7_local4 and f7_local4 ~= 0 and f7_arg0.camoSwatchImage then
			local f7_local5 = UIExpression.GetWeaponOptionImage(nil, f7_local4)
			if CoD.CACUtility.IsWeaponOptionMTX(f7_local4) then
				f7_local5 = f7_local5 .. "_32"
				CoD.ClassPreview.SetupMTXCamoSwatch(f7_arg0)
			end
			f7_arg0.camoSwatchImage:setImage(RegisterMaterial(f7_local5))
			f7_arg0.camoSwatchImage:show()
		end
		if not Engine.HasDLCForItem(f7_arg1.controller, f7_local2) or Engine.IsItemIndexRestricted(f7_local2) then
			f7_arg0:setRestrictedImage(true)
		else
			f7_arg0:setRestrictedImage(false)
		end
		f7_arg0:setSubtitle(Engine.Localize(f7_local3))
		f7_arg0.canBeRemoved = true
	end
end

CoD.CACWeaponButton.PrimaryWeaponSetup = function (f8_arg0)
	CoD.CustomClass.SetupButtonImages(f8_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
	CoD.GrowingGridButton.SetupUnequipButton(f8_arg0, 5, 5, 25)
end

CoD.CACWeaponButton.SecondaryWeaponSetup = function (f9_arg0)
	CoD.CustomClass.SetupButtonImages(f9_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
	CoD.GrowingGridButton.SetupUnequipButton(f9_arg0, 5, 5, 20)
end

