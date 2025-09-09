require("T6.GrowingGridButton")
require("T6.Border")
CoD.CACWeaponGridButton = {}
CoD.CACWeaponGridButton.AspectRatio = 2
CoD.CACWeaponGridButton.ImageBorder = 10
CoD.CACWeaponGridButton.PrimaryLineMaterialName = ""
CoD.CACWeaponGridButton.PrimaryHighlightMaterialName = "menu_mp_cac_prim_hl"
if CoD.isSinglePlayer then
	CoD.CACWeaponGridButton.SecondaryLineMaterialName = "menu_mp_cac_prim_fill"
	CoD.CACWeaponGridButton.SecondaryHighlightMaterialName = "menu_mp_cac_prim_hl"
else
	CoD.CACWeaponGridButton.SecondaryLineMaterialName = "menu_mp_cac_second_fill"
	CoD.CACWeaponGridButton.SecondaryHighlightMaterialName = "menu_mp_cac_second_hl"
end
CoD.CACWeaponGridButton.new = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = nil
	if f1_arg0 == "primary" or CoD.isSinglePlayer then
		f1_local0 = CoD.CACWeaponGridButton.PrimaryWeaponSetup
	elseif f1_arg0 == "secondary" then
		f1_local0 = CoD.CACWeaponGridButton.SecondaryWeaponSetup
	end
	local f1_local1 = CoD.GrowingGridButton.new(f1_arg2, f1_local0)
	f1_local1.weaponStatName = f1_arg0
	f1_local1.id = f1_local1.id .. "." .. f1_arg0
	local f1_local2 = f1_arg1 - CoD.CACWeaponGridButton.ImageBorder * 2
	local f1_local3 = f1_local2 * CoD.CACWeaponGridButton.AspectRatio
	f1_local1.weaponImage = LUI.UIImage.new()
	f1_local1.weaponImage:setLeftRight(false, true, -CoD.CACWeaponGridButton.ImageBorder - f1_local3, -CoD.CACWeaponGridButton.ImageBorder)
	f1_local1.weaponImage:setTopBottom(false, false, -f1_local2 / 2, f1_local2 / 2)
	f1_local1:addToBody(f1_local1.weaponImage)
	f1_local1.weaponImage:registerAnimationState("hide", {
		alpha = 0
	})
	f1_local1.handleUnequipPrompt = CoD.CACWeaponGridButton.ButtonPromptUnequip
	f1_local1:registerEventHandler("button_up", CoD.CACWeaponGridButton.ButtonUp)
	f1_local1:registerEventHandler("button_over", CoD.CACWeaponGridButton.ButtonOver)
	f1_local1:registerEventHandler("button_action", CoD.CACWeaponGridButton.ButtonAction)
	if CoD.isSinglePlayer == true then
		f1_local1:registerEventHandler("update_class", CoD.CACWeaponGridButton.UpdateClassDataSP)
	else
		f1_local1:registerEventHandler("update_class", CoD.CACWeaponGridButton.UpdateClassData)
	end
	return f1_local1
end

CoD.CACWeaponGridButton.ButtonPromptUnequip = function (f2_arg0, f2_arg1)
	CoD.CACRemoveItem.RemoveWeapon(f2_arg1.controller, CoD.perController[f2_arg1.controller].classNum, f2_arg0.weaponStatName)
	CoD.GrowingGridButton.ButtonPromptUnequip(f2_arg0, f2_arg1)
end

CoD.CACWeaponGridButton.ButtonUp = function (f3_arg0, f3_arg1)
	if f3_arg0.background ~= nil then
		f3_arg0.background:setRGB(CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b)
		f3_arg0.background:setAlpha(CoD.CACClassLoadout.DefaultButtonAlpha)
		if f3_arg0.highlight ~= nil then
			f3_arg0.highlight:close()
		end
	end
	f3_arg0:highlightSubtitle(1, true)
	CoD.GrowingGridButton.Up(f3_arg0, f3_arg1)
end

CoD.CACWeaponGridButton.ButtonOver = function (f4_arg0, f4_arg1)
	if CoD.CACUtility.highLightedGridButtonColumn ~= nil then
		CoD.CACUtility.lastHighLightedGridButtonColumn = CoD.CACUtility.highLightedGridButtonColumn
	end
	CoD.CACUtility.highLightedGridButtonColumn = "left"
	if f4_arg0.background ~= nil then
		f4_arg0.background:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f4_arg0.background:setAlpha(1)
		local f4_local0 = LUI.UIImage.new()
		f4_local0:setLeftRight(true, true, -62, 64)
		if f4_arg0.weaponStatName == "primary" then
			f4_local0:setTopBottom(true, true, -55, 54)
		else
			f4_local0:setTopBottom(true, true, -49, 48)
		end
		f4_local0:setImage(RegisterMaterial("menu_mp_cac_caro_gren_hl"))
		f4_arg0:addElement(f4_local0)
		f4_arg0.highlight = f4_local0
	end
	f4_arg0:highlightSubtitle(1)
	CoD.GrowingGridButton.Over(f4_arg0, f4_arg1)
end

CoD.CACWeaponGridButton.ButtonAction = function (f5_arg0, f5_arg1)
	Engine.PlaySound("uin_main_enter")
	f5_arg0:dispatchEventToParent({
		name = "weapon_chosen",
		controller = f5_arg1.controller,
		weaponSlot = f5_arg0.weaponStatName
	})
end

CoD.CACWeaponGridButton.UpdateClassData = function (f6_arg0, f6_arg1)
	local f6_local0 = CoD.CACUtility.IsBonusCardEquippedByName(f6_arg1.class, "bonuscard_overkill")
	if f6_arg0.weaponStatName == "secondary" then
		if f6_local0 == true then
			f6_arg0:setTitle(Engine.Localize("MPUI_SECOND_PRIMARY_CAPS"))
			if f6_arg0.bonusCardPreviewBackground then
				f6_arg0.bonusCardPreviewBackground:animateToState("show")
			end
		else
			f6_arg0:setTitle(Engine.Localize("MPUI_" .. f6_arg0.weaponStatName .. "_CAPS"))
			if f6_arg0.bonusCardPreviewBackground then
				f6_arg0.bonusCardPreviewBackground:animateToState("default")
			end
		end
		if f6_arg0.bonusCardPreviewBackgroundPulse then
			if f6_arg1.showBonuscardPreview == true and f6_local0 == false then
				f6_arg0.bonusCardPreviewBackgroundPulse:animateToState("show")
			else
				f6_arg0.bonusCardPreviewBackgroundPulse:animateToState("default")
			end
		end
	else
		f6_arg0:setTitle(Engine.Localize("MPUI_" .. f6_arg0.weaponStatName .. "_CAPS"))
		if f6_arg0.bonusCardPreviewBackground then
			f6_arg0.bonusCardPreviewBackground:animateToState("default")
		end
	end
	local f6_local1 = f6_arg1.class[f6_arg0.weaponStatName]
	if f6_local1 == nil then
		if f6_arg0.weaponStatName == "secondary" then
			f6_arg0.background:setImage(RegisterMaterial(CoD.CACWeaponGridButton.SecondaryLineMaterialName))
		end
		if f6_arg0.weaponImage then
			f6_arg0.weaponImage:animateToState("hide")
			f6_arg0:setSubtitle("")
		end
		f6_arg0:setRestrictedImage(false)
		f6_arg0.canBeRemoved = nil
	else
		f6_arg0.weaponIndex = f6_local1
		if f6_arg0.weaponStatName == "secondary" then
			f6_arg0.background:setImage(RegisterMaterial(CoD.CACWeaponGridButton.SecondaryLineMaterialName))
		end
		local f6_local2 = UIExpression.GetItemName(nil, f6_local1)
		f6_arg0.weaponImage:registerAnimationState("change_material", {
			alpha = 1,
			material = RegisterMaterial(UIExpression.GetItemImage(nil, f6_local1) .. "_big")
		})
		f6_arg0.weaponImage:animateToState("change_material")
		f6_arg0:setRestrictedImage(Engine.IsItemIndexRestricted(f6_local1))
		f6_arg0:setSubtitle(Engine.Localize(f6_local2))
		f6_arg0.canBeRemoved = true
	end
end

CoD.CACWeaponGridButton.UpdateClassDataSP = function (f7_arg0, f7_arg1)
	if not CoD.isSinglePlayer then
		return 
	elseif f7_arg0.weaponStatName == "secondary" then
		f7_arg0:setTitle(Engine.Localize("MPUI_SECONDARY_CAPS"))
	else
		f7_arg0:setTitle(Engine.Localize("MPUI_PRIMARY_CAPS"))
	end
	local f7_local0 = nil
	if f7_arg0.weaponStatName == "primary" then
		f7_local0 = f7_arg1.class.primaryWeapon
	elseif f7_arg0.weaponStatName == "secondary" then
		f7_local0 = f7_arg1.class.secondaryWeapon
	end
	if f7_local0[1] == nil then
		if f7_arg0.weaponStatName == "secondary" then
			f7_arg0.background:setImage(RegisterMaterial(CoD.CACWeaponGridButton.SecondaryLineMaterialName))
		end
		if f7_arg0.weaponImage then
			f7_arg0.weaponImage:animateToState("hide")
			f7_arg0:setSubtitle("")
		end
		f7_arg0.canBeRemoved = nil
	else
		f7_arg0.weaponIndex = f7_local0[1]
		if f7_arg0.weaponStatName == "secondary" then
			f7_arg0.background:setImage(RegisterMaterial(CoD.CACWeaponGridButton.SecondaryLineMaterialName))
		end
		local f7_local1 = f7_arg0.weaponIndex.name
		f7_arg0.weaponImage:registerAnimationState("change_material", {
			alpha = 1,
			material = f7_arg0.weaponIndex.material
		})
		f7_arg0.weaponImage:animateToState("change_material")
		f7_arg0:setSubtitle(Engine.Localize(f7_local1))
		f7_arg0.canBeRemoved = true
	end
end

CoD.CACWeaponGridButton.PrimaryWeaponSetup = function (f8_arg0)
	local f8_local0 = 26
	local f8_local1 = 54
	f8_arg0.background = CoD.Border.new(2, CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b, CoD.CACClassLoadout.DefaultButtonAlpha, -2)
	f8_arg0:addElement(f8_arg0.background)
	local f8_local2 = LUI.UIImage.new()
	f8_local2:setTopBottom(true, true, 0, 0)
	f8_local2:setLeftRight(true, true, 0, 0)
	f8_local2:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f8_local2:setRGB(CoD.CACClassLoadout.DefaultBackgroundColor.r, CoD.CACClassLoadout.DefaultBackgroundColor.g, CoD.CACClassLoadout.DefaultBackgroundColor.b)
	f8_local2:setAlpha(CoD.CACClassLoadout.DefaultBackgroundAlpha)
	f8_arg0:addElement(f8_local2)
	f8_arg0.body = LUI.UIElement.new()
	f8_arg0.body:setLeftRight(true, true, CoD.GrowingGridButton.InnerBorder, -CoD.GrowingGridButton.InnerBorder)
	f8_arg0.body:setTopBottom(true, true, CoD.GrowingGridButton.InnerBorder, -CoD.GrowingGridButton.InnerBorder)
	f8_arg0:addElement(f8_arg0.body)
	f8_arg0.body:registerAnimationState("small", {
		leftAnchor = true,
		rightAnchor = true,
		left = 100,
		right = -CoD.GrowingGridButton.InnerBorder,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.GrowingGridButton.InnerBorder,
		bottom = -CoD.GrowingGridButton.InnerBorder
	})
	CoD.GrowingGridButton.SetupUnequipButton(f8_arg0, 0, 0, 25)
end

CoD.CACWeaponGridButton.SecondaryWeaponSetup = function (f9_arg0)
	local f9_local0 = 26
	local f9_local1 = 30
	f9_arg0.background = LUI.UIImage.new()
	f9_arg0.background:setLeftRight(true, true, -f9_local0 + 5, f9_local0)
	f9_arg0.background:setTopBottom(true, true, -f9_local1, f9_local1)
	f9_arg0.background:setImage(RegisterMaterial(CoD.CACWeaponGridButton.SecondaryLineMaterialName))
	f9_arg0:addElement(f9_arg0.background)
	f9_arg0.bonusCardPreviewBackground = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = -f9_local0 + 5,
		right = f9_local0,
		topAnchor = true,
		bottomAnchor = true,
		top = -f9_local1,
		bottom = f9_local1,
		alpha = 0,
		material = RegisterMaterial("menu_mp_cac_second_wc")
	})
	f9_arg0.bonusCardPreviewBackground:registerAnimationState("show", {
		alpha = 1
	})
	f9_arg0:addElement(f9_arg0.bonusCardPreviewBackground)
	f9_arg0.bonusCardPreviewBackgroundPulse = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = -f9_local0 + 5,
		right = f9_local0,
		topAnchor = true,
		bottomAnchor = true,
		top = -f9_local1,
		bottom = f9_local1,
		alpha = 0,
		material = RegisterMaterial("menu_mp_cac_second_wc")
	})
	f9_arg0.bonusCardPreviewBackgroundPulse:registerAnimationState("hide", {
		alpha = 0.2,
		material = RegisterMaterial("menu_mp_cac_second_wc")
	})
	f9_arg0.bonusCardPreviewBackgroundPulse:registerAnimationState("show", {
		alpha = 1,
		material = RegisterMaterial("menu_mp_cac_second_wc")
	})
	f9_arg0.bonusCardPreviewBackgroundPulse:registerEventHandler("transition_complete_show", f9_arg0.bonusCardPreviewBackgroundPulse:animateToNextState("hide", 1000))
	f9_arg0.bonusCardPreviewBackgroundPulse:registerEventHandler("transition_complete_hide", f9_arg0.bonusCardPreviewBackgroundPulse:animateToNextState("show", 1000))
	f9_arg0:addElement(f9_arg0.bonusCardPreviewBackgroundPulse)
	f9_arg0.body = LUI.UIElement.new()
	f9_arg0.body:setLeftRight(true, true, CoD.GrowingGridButton.InnerBorder, -CoD.GrowingGridButton.InnerBorder)
	f9_arg0.body:setTopBottom(true, true, CoD.GrowingGridButton.InnerBorder, -CoD.GrowingGridButton.InnerBorder)
	f9_arg0:addElement(f9_arg0.body)
	f9_arg0.body:registerAnimationState("small", {
		leftAnchor = true,
		rightAnchor = true,
		left = 100,
		right = -CoD.GrowingGridButton.InnerBorder,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.GrowingGridButton.InnerBorder,
		bottom = -CoD.GrowingGridButton.InnerBorder
	})
	f9_arg0.highlight = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = -f9_local0 + 5,
		right = f9_local0,
		topAnchor = true,
		bottomAnchor = true,
		top = -f9_local1,
		bottom = f9_local1,
		alpha = 0,
		material = RegisterMaterial(CoD.CACWeaponGridButton.SecondaryHighlightMaterialName)
	})
	f9_arg0.highlight:setPriority(100)
	f9_arg0:addElement(f9_arg0.highlight)
	f9_arg0.highlight:registerAnimationState("button_over", {
		alpha = 1
	})
	LUI.UIButton.SetupElement(f9_arg0.highlight)
	CoD.GrowingGridButton.SetupUnequipButton(f9_arg0, 0, 0, 20)
end

