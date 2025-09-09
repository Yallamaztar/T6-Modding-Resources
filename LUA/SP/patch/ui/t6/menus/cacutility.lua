require("T6.MFSlide")
require("T6.MFSlidePanel")
require("T6.CoD9Button")
require("T6.GrenadeGridButton")
require("T6.PerkGridButton")
CoD.CACUtility = {}
CoD.CACUtility.ButtonActionSound = "uin_navigation_select_main"
CoD.CACUtility.LockImageMaterial = "menu_mp_lobby_locked"
CoD.CACUtility.LockImageBigMaterial = "menu_mp_lobby_locked_big"
CoD.CACUtility.NewImageMaterial = "menu_mp_lobby_new"
CoD.CACUtility.EquipImageMaterial = "mutually_excl"
CoD.CACUtility.ButtonGridLockImageSize = 20
CoD.CACUtility.ButtonGridBigLockImageSize = 48
CoD.CACUtility.ButtonGridNewImageWidth = 40
CoD.CACUtility.ButtonGridNewImageHeight = 20
CoD.CACUtility.FadeInTime = 250
CoD.CACUtility.CommonWeapons = {
	{
		name = "weapon_smg",
		text = Engine.Localize("MPUI_WEAPON_SMG_CAPS")
	},
	{
		name = "weapon_assault",
		text = Engine.Localize("MPUI_WEAPON_ASSAULT_CAPS")
	},
	{
		name = "weapon_cqb",
		text = Engine.Localize("MPUI_WEAPON_CQB_CAPS")
	},
	{
		name = "weapon_lmg",
		text = Engine.Localize("MPUI_WEAPON_LMG_CAPS")
	},
	{
		name = "weapon_sniper",
		text = Engine.Localize("MPUI_WEAPON_SNIPER_CAPS")
	},
	{
		name = "weapon_pistol",
		text = Engine.Localize("MPUI_WEAPON_PISTOL_CAPS")
	},
	{
		name = "weapon_launcher",
		text = Engine.Localize("MPUI_WEAPON_LAUNCHER_CAPS")
	},
	{
		name = "weapon_special",
		text = Engine.Localize("MPUI_WEAPON_SPECIAL_CAPS")
	}
}
CoD.CACUtility.EightiesOnlyWeapons = {}
CoD.CACUtility.TwentiesOnlyWeapons = {}
CoD.CACUtility.slotContainerAlpha = 0.04
CoD.CACUtility.maxCustomClass = 1
CoD.CACUtility.maxGrenades = 2
CoD.CACUtility.maxSpecialtySlots = 6
CoD.CACUtility.maxPerks = 12
CoD.CACUtility.maxPerksSlots = 3
CoD.CACUtility.maxRewards = 3
CoD.CACUtility.maxRewardSlots = 6
CoD.CACUtility.maxAttachments = 3
CoD.CACUtility.attributesTable = "sp/attributesTable.csv"
CoD.CACUtility.ElementTitleFont = "Big"
CoD.CACUtility.ElementDescriptionFont = "Default"
CoD.CACUtility.ElementRecommendedFont = "Default"
CoD.CACUtility.ElementLineSpacing = 5
CoD.CACUtility.TopAnchor = CoD.Menu.TitleHeight + 7
CoD.CACUtility.denySFX = "uin_cmn_deny"
CoD.CACUtility.EquipSFX = "uin_equipment_add"
CoD.CACUtility.UnequipSFX = "uin_equipment_remove"
CoD.CACUtility.RestoreDefault = "uin_cmn_backout"
CoD.CACUtility.loadoutSlotNames = {
	primaryWeapon = "primary",
	secondaryWeapon = "secondary",
	primaryGrenade = "primarygrenade",
	specialGrenade = "specialgrenade",
	specialty1 = "specialty1",
	specialty2 = "specialty2",
	specialty3 = "specialty3",
	specialty4 = "specialty4",
	specialty5 = "specialty5",
	specialty6 = "specialty6",
	specialty7 = "specialty7",
	specialty8 = "specialty8",
	specialty9 = "specialty9",
	specialty10 = "specialty10",
	specialty11 = "specialty11",
	specialty12 = "specialty12"
}
CoD.CACUtility.attachmentPointNames = {
	"top",
	"bottom",
	"trigger",
	"muzzle",
	"gunperk"
}
CoD.CACUtility.weaponGroupNames = {
	camo = 0,
	tag = 1,
	emblem = 2,
	reticle = 3,
	lens = 4,
	reticleColor = 5
}
CoD.CACUtility.GainFocusSFX = "cac_loadout_nav"
CoD.CACUtility.WildcardGainFocusSFX = "cac_loadout_wildcard_nav"
CoD.CACUtility.SetupElementForClassData = function (f1_arg0)
	f1_arg0.primaryWeaponLabels = {}
	f1_arg0.secondaryWeaponLabels = {}
	f1_arg0.attachmentLabels = {}
	f1_arg0.attachmentContainers = {}
	f1_arg0.attachmentImageBGs = {}
	f1_arg0.attachmentImages = {}
	f1_arg0.grenadeImages = {}
	f1_arg0.grenadeImageBGs = {}
	f1_arg0.grenadeCountLabels = {}
	f1_arg0.equipmentImages = {}
	f1_arg0.equipmentCountLabels = {}
	f1_arg0.perkLabels = {}
	f1_arg0.perkImages = {}
	f1_arg0.perkBrackets = {}
	f1_arg0.itemLabelTabs = {}
	f1_arg0.verticalLines = {}
	f1_arg0.horizontalLines = {}
end

CoD.CACUtility.SetupElementForClassData1 = function (f2_arg0)
	f2_arg0.primaryWeaponLabels = {}
	f2_arg0.secondaryWeaponLabels = {}
	f2_arg0.attachmentLabels = {}
	f2_arg0.attachmentContainers = {}
	f2_arg0.attachmentImageBGs = {}
	f2_arg0.attachmentImages = {}
	f2_arg0.grenadeImages = {}
	f2_arg0.grenadeImageBGs = {}
	f2_arg0.grenadeCountLabels = {}
	f2_arg0.equipmentImages = {}
	f2_arg0.equipmentCountLabels = {}
	f2_arg0.perkLabels = {}
	f2_arg0.perkImages = {}
	f2_arg0.perkBrackets = {}
	f2_arg0.itemLabelTabs = {}
	f2_arg0.verticalLines = {}
	f2_arg0.horizontalLines = {}
end

CoD.CACUtility.GetAllocationSpentFromClassData = function (f3_arg0)
	return CoD.SumClassItemCosts(f3_arg0.primaryWeapon) + CoD.SumClassItemCosts(f3_arg0.primaryAttachments) + CoD.SumClassItemCosts(f3_arg0.secondaryWeapon) + CoD.SumClassItemCosts(f3_arg0.secondaryAttachments) + CoD.SumClassItemCosts(f3_arg0.grenades) + CoD.SumClassItemCosts(f3_arg0.perks)
end

CoD.CACUtility.HowManyInClassData = function (f4_arg0, f4_arg1)
	return CoD.HowManyInClassSlot(f4_arg0, f4_arg1.primaryWeapon) + CoD.HowManyInClassSlot(f4_arg0, f4_arg1.secondaryWeapon) + CoD.HowManyInClassSlot(f4_arg0, f4_arg1.grenades) + CoD.HowManyInClassSlot(f4_arg0, f4_arg1.perks)
end

CoD.CACUtility.GetClassData = function (f5_arg0, f5_arg1)
	local f5_local0 = {}
	if f5_arg1 == nil then
		f5_arg1 = CoD.perController[f5_arg0].classNumInternal
	end
	local f5_local1 = CoD.CACUtility.loadoutSlotNames
	f5_local0.primaryWeapon = {}
	CoD.AddClassItemData(f5_local0.primaryWeapon, CoD.GetClassItem(f5_arg0, f5_arg1, f5_local1.primaryWeapon))
	f5_local0.secondaryWeapon = {}
	CoD.AddClassItemData(f5_local0.secondaryWeapon, CoD.GetClassItem(f5_arg0, f5_arg1, f5_local1.secondaryWeapon))
	f5_local0.primaryAttachments = {}
	f5_local0.secondaryAttachments = {}
	local f5_local2 = CoD.GetClassItem(f5_arg0, f5_arg1, f5_local1.primaryWeapon)
	local f5_local3 = CoD.GetClassItem(f5_arg0, f5_arg1, f5_local1.secondaryWeapon)
	for f5_local7, f5_local8 in pairs(CoD.CACUtility.attachmentPointNames) do
		CoD.AddClassAttachmentData(f5_local0.primaryAttachments, f5_local2, CoD.GetClassItem(f5_arg0, f5_arg1, f5_local1.primaryWeapon .. "attachment" .. f5_local8))
		CoD.AddClassAttachmentData(f5_local0.secondaryAttachments, f5_local3, CoD.GetClassItem(f5_arg0, f5_arg1, f5_local1.secondaryWeapon .. "attachment" .. f5_local8))
	end
	f5_local0.grenades = {}
	CoD.AddClassItemData(f5_local0.grenades, CoD.GetClassItem(f5_arg0, f5_arg1, f5_local1.primaryGrenade), CoD.GetClassItem(f5_arg0, f5_arg1, "primarygrenadecount"), f5_local1.primaryGrenade)
	CoD.AddClassItemData(f5_local0.grenades, CoD.GetClassItem(f5_arg0, f5_arg1, f5_local1.specialGrenade), CoD.GetClassItem(f5_arg0, f5_arg1, "specialgrenadecount"), f5_local1.specialGrenade)
	f5_local4 = CoD.CACUtility.maxSpecialtySlots
	f5_local0.perks = {}
	for f5_local5 = 1, f5_local4, 1 do
		CoD.AddClassItemData(f5_local0.perks, CoD.GetClassItem(f5_arg0, f5_arg1, f5_local1["specialty" .. f5_local5]))
	end
	return f5_local0
end

CoD.CACUtility.GetClassData1 = function (f6_arg0, f6_arg1)
	local f6_local0 = {}
	if f6_arg1 == nil then
		f6_arg1 = CoD.perController[f6_arg0].classNumInternal
	end
	local f6_local1 = CoD.CACUtility.loadoutSlotNames
	f6_local0.primaryWeapon = {}
	CoD.AddClassItemData(f6_local0.primaryWeapon, CoD.GetClassItem(f6_arg0, f6_arg1, f6_local1.primaryWeapon))
	f6_local0.secondaryWeapon = {}
	CoD.AddClassItemData(f6_local0.secondaryWeapon, CoD.GetClassItem(f6_arg0, f6_arg1, f6_local1.secondaryWeapon))
	f6_local0.primaryAttachments = {}
	f6_local0.secondaryAttachments = {}
	local f6_local2 = CoD.GetClassItem(f6_arg0, f6_arg1, f6_local1.primaryWeapon)
	local f6_local3 = CoD.GetClassItem(f6_arg0, f6_arg1, f6_local1.secondaryWeapon)
	for f6_local7, f6_local8 in pairs(CoD.CACUtility.attachmentPointNames) do
		CoD.AddClassAttachmentData(f6_local0.primaryAttachments, f6_local2, CoD.GetClassItem(f6_arg0, f6_arg1, f6_local1.primaryWeapon .. "attachment" .. f6_local8))
		CoD.AddClassAttachmentData(f6_local0.secondaryAttachments, f6_local3, CoD.GetClassItem(f6_arg0, f6_arg1, f6_local1.secondaryWeapon .. "attachment" .. f6_local8))
	end
	f6_local0.grenades = {}
	CoD.AddClassItemData(f6_local0.grenades, CoD.GetClassItem(f6_arg0, f6_arg1, f6_local1.primaryGrenade), CoD.GetClassItem(f6_arg0, f6_arg1, "primarygrenadecount"), f6_local1.primaryGrenade)
	CoD.AddClassItemData(f6_local0.grenades, CoD.GetClassItem(f6_arg0, f6_arg1, f6_local1.specialGrenade), CoD.GetClassItem(f6_arg0, f6_arg1, "specialgrenadecount"), f6_local1.specialGrenade)
	f6_local4 = CoD.CACUtility.maxSpecialtySlots
	f6_local0.perks = {}
	for f6_local5 = 1, f6_local4, 1 do
		CoD.AddClassItemData(f6_local0.perks, CoD.GetClassItem(f6_arg0, f6_arg1, f6_local1["specialty" .. f6_local5]))
	end
	return f6_local0
end

CoD.CACUtility.GetAllGrenadesAndEquipment = function ()
	local f7_local0 = {}
	LUI.ConcatenateToTable(f7_local0, CoD.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames.primaryGrenade))
	LUI.ConcatenateToTable(f7_local0, CoD.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames.specialGrenade))
	return f7_local0
end

CoD.CACUtility.SetCurrentSPMapDefaults = function (f8_arg0, f8_arg1)
	CoD.CACUtility.lastMap = f8_arg1
	if CoD.CACUtility[f8_arg1] ~= nil then
		return 
	end
	local f8_local0 = CoD.perController[f8_arg0].classNumInternal
	if f8_local0 == nil then
		f8_local0 = 0
	end
	local f8_local1 = CoD.CACUtility.GetClassData1(f8_arg0, f8_local0)
	CoD.CACUtility[f8_arg1] = {}
	for f8_local5, f8_local6 in pairs(f8_local1.primaryWeapon) do
		if CoD.IsWeapon(f8_local6.itemIndex) then
			CoD.CACUtility[f8_arg1].defaultPrimary = f8_local6.itemIndex
		end
	end
	for f8_local5, f8_local6 in pairs(f8_local1.secondaryWeapon) do
		if CoD.IsWeapon(f8_local6.itemIndex) then
			CoD.CACUtility[f8_arg1].defaultSecondary = f8_local6.itemIndex
		end
	end
	CoD.CACUtility[f8_arg1].grenadesAndEquipment = {}
	for f8_local5, f8_local6 in pairs(f8_local1.grenades) do
		if CoD.IsGrenade(f8_local6.itemIndex) then
			table.insert(CoD.CACUtility[f8_arg1].grenadesAndEquipment, f8_local6.itemIndex)
		end
	end
	CoD.CACUtility[f8_arg1].perks = {}
	for f8_local5, f8_local6 in pairs(f8_local1.perks) do
		if CoD.IsPerk(f8_local6.itemIndex) then
			table.insert(CoD.CACUtility[f8_arg1].perks, f8_local6.itemIndex)
		end
	end
	CoD.CACUtility[f8_arg1].defaultPrimaryAttachments = {}
	if CoD.CACUtility[f8_arg1].defaultPrimary then
		for f8_local5, f8_local6 in pairs(f8_local1.primaryAttachments) do
			if CoD.IsWeaponAttachment(f8_local6.attachmentIndex, CoD.CACUtility[f8_arg1].defaultPrimary) then
				CoD.CACUtility[f8_arg1].defaultPrimaryAttachments[Engine.GetAttachmentRef(CoD.CACUtility[f8_arg1].defaultPrimary, f8_local6.attachmentIndex)] = true
			end
		end
	end
	CoD.CACUtility[f8_arg1].defaultSecondaryAttachments = {}
	if CoD.CACUtility[f8_arg1].defaultSecondary then
		for f8_local5, f8_local6 in pairs(f8_local1.secondaryAttachments) do
			if CoD.IsWeaponAttachment(f8_local6.attachmentIndex, CoD.CACUtility[f8_arg1].defaultSecondary) then
				CoD.CACUtility[f8_arg1].defaultSecondaryAttachments[Engine.GetAttachmentRef(CoD.CACUtility[f8_arg1].defaultSecondary, f8_local6.attachmentIndex)] = true
			end
		end
	end
end

CoD.CACUtility.GetCurrentSPMapDefaultWeapons = function (f9_arg0, f9_arg1)
	if f9_arg1 == nil then
		f9_arg1 = CoD.CACUtility.lastMap
		if f9_arg1 == nil then
			return -1, -1
		end
	end
	if CoD.CACUtility[f9_arg1] == nil then
		CoD.CACUtility.SetCurrentSPMapDefaults(f9_arg1)
		if CoD.CACUtility[f9_arg1] == nil then
			return -1, -1
		end
	end
	return CoD.CACUtility[f9_arg1].defaultPrimary, CoD.CACUtility[f9_arg1].defaultSecondary
end

CoD.CACUtility.GetCurrentSPMapDefaultGrenadesAndEquipment = function (f10_arg0, f10_arg1)
	if f10_arg1 == nil then
		f10_arg1 = CoD.CACUtility.lastMap
		if f10_arg1 == nil then
			return {}
		end
	end
	if CoD.CACUtility[f10_arg1] == nil then
		CoD.CACUtility.SetCurrentSPMapDefaults(f10_arg1)
		if CoD.CACUtility[f10_arg1] == nil then
			return {}
		end
	end
	return CoD.CACUtility[f10_arg1].grenadesAndEquipment
end

CoD.CACUtility.GetCurrentSPMapDefaultPerks = function (f11_arg0, f11_arg1)
	if f11_arg1 == nil then
		f11_arg1 = CoD.CACUtility.lastMap
		if f11_arg1 == nil then
			return {}
		end
	end
	if CoD.CACUtility[f11_arg1] == nil then
		CoD.CACUtility.SetCurrentSPMapDefaults(f11_arg1)
		if CoD.CACUtility[f11_arg1] == nil then
			return {}
		end
	end
	return CoD.CACUtility[f11_arg1].perks
end

CoD.CACUtility.GetCurrentSPMapDefaultAttachments = function (f12_arg0, f12_arg1, f12_arg2)
	if f12_arg2 == nil then
		f12_arg2 = CoD.CACUtility.lastMap
		if f12_arg2 == nil then
			return {}
		end
	end
	if CoD.CACUtility[f12_arg2] == nil then
		CoD.CACUtility.SetCurrentSPMapDefaults(f12_arg2)
		if CoD.CACUtility[f12_arg2] == nil then
			return {}
		end
	end
	if f12_arg1 == CoD.CACUtility.loadoutSlotNames.primaryWeapon then
		return CoD.CACUtility[f12_arg2].defaultPrimaryAttachments
	end
	return CoD.CACUtility[f12_arg2].defaultSecondaryAttachments
end

CoD.CACUtility.SetupElementForItemInformation = function (f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4, f13_arg5)
	if f13_arg0 == nil or f13_arg1 == nil then
		return 
	elseif not f13_arg3 then
		local f13_local0 = LUI.UIText.new()
		f13_local0:setLeftRight(true, false, 0, f13_arg1)
		f13_local0:setTopBottom(true, false, 0, CoD.textSize[CoD.CACUtility.ElementTitleFont])
		f13_local0:setFont(CoD.fonts[CoD.CACUtility.ElementTitleFont])
		f13_local0:setAlignment(LUI.Alignment.Left)
		f13_local0:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f13_arg0.titleText = f13_local0
		f13_arg0:addElement(f13_local0)
	end
	if not f13_arg4 then
		local f13_local0 = LUI.UIText.new()
		f13_local0:setLeftRight(true, false, 0, f13_arg1)
		f13_local0:setTopBottom(true, false, 0, 0)
		f13_local0:setFont(CoD.fonts[CoD.CACUtility.ElementDescriptionFont])
		f13_local0:setAlignment(LUI.Alignment.Left)
		f13_arg0.descriptionText = f13_local0
		f13_arg0:addElement(f13_local0)
	end
	if not f13_arg5 then
		local f13_local0 = LUI.UIText.new()
		f13_local0:setLeftRight(true, false, 0, f13_arg1)
		f13_local0:setTopBottom(true, false, 0, 0)
		f13_local0:setFont(CoD.fonts[CoD.CACUtility.ElementRecommendedFont])
		f13_local0:setAlignment(LUI.Alignment.Left)
		f13_local0:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f13_arg0.recommendedText = f13_local0
		f13_arg0:addElement(f13_local0)
	end
	if f13_arg2 then
		local f13_local0 = CoD.WeaponAttributeList.new(f13_arg1 - 60, {
			left = -f13_arg1 / 2 + 15,
			right = f13_arg1 / 2 + 15,
			leftAnchor = false,
			rightAnchor = false,
			top = f13_arg2,
			bottom = f13_arg2 + 300,
			topAnchor = true,
			bottomAnchor = false
		}, CoD.CACUtility.attributesTable)
		f13_arg0.attributesBar = f13_local0
		f13_arg0:addElement(f13_local0)
	end
end

CoD.CACUtility.UpdateElementWithItemInformation = function (f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4, f14_arg5)
	local f14_local0 = 0
	local f14_local1 = 0
	if f14_arg0.titleText then
		f14_arg0.titleText:setText(f14_arg2)
		if not (not f14_arg3 or f14_arg3 == "") or f14_arg4 and f14_arg4 ~= "" then
			f14_local0 = f14_local0 + Engine.GetNumTextLines(f14_arg2, CoD.fonts[CoD.CACUtility.ElementTitleFont], CoD.textSize[CoD.CACUtility.ElementTitleFont], f14_arg1) * CoD.textSize[CoD.CACUtility.ElementTitleFont] + CoD.CACUtility.ElementLineSpacing
		end
	end
	if f14_arg0.descriptionText then
		f14_arg0.descriptionText:setTopBottom(true, false, f14_local0, f14_local0 + CoD.textSize[CoD.CACUtility.ElementDescriptionFont])
		f14_arg0.descriptionText:setText(f14_arg3)
		if f14_arg4 and f14_arg4 ~= "" then
			f14_local0 = f14_local0 + Engine.GetNumTextLines(f14_arg3, CoD.fonts[CoD.CACUtility.ElementDescriptionFont], CoD.textSize[CoD.CACUtility.ElementDescriptionFont], f14_arg1) * CoD.textSize[CoD.CACUtility.ElementDescriptionFont] + CoD.CACUtility.ElementLineSpacing
		end
	end
	if f14_arg0.recommendedText then
		f14_arg0.recommendedText:setTopBottom(true, false, f14_local0, f14_local0 + CoD.textSize[CoD.CACUtility.ElementRecommendedFont])
		f14_arg0.recommendedText:setText(f14_arg4)
		if f14_arg4 and f14_arg4 ~= "" then
			f14_local0 = f14_local0 + Engine.GetNumTextLines(f14_arg4, CoD.fonts[CoD.CACUtility.ElementDescriptionFont], CoD.textSize[CoD.CACUtility.ElementDescriptionFont], f14_arg1) * CoD.textSize[CoD.CACUtility.ElementRecommendedFont] + CoD.CACUtility.ElementLineSpacing
		end
	end
	if f14_arg0.attributesBar then
		if f14_arg5 then
			f14_arg0.attributesBar:updateWeaponAttributes(f14_arg5)
			f14_arg0.attributesBar:beginAnimation("show")
			f14_arg0.attributesBar:setAlpha(1)
		else
			f14_arg0.attributesBar:updateWeaponAttributes(0)
			f14_arg0.attributesBar:beginAnimation("hide")
			f14_arg0.attributesBar:setAlpha(0)
		end
	end
end

