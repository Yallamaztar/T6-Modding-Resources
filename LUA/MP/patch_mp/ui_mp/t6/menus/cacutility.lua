require("T6.MFSlide")
require("T6.MFSlidePanel")
require("T6.CoD9Button")
CoD.CACUtility = {}
CoD.CACUtility.slotContainerAlpha = 0.04
CoD.CACUtility.maxCustomClass = 5
CoD.CACUtility.maxGrenades = 2
CoD.CACUtility.maxSpecialtySlots = 6
CoD.CACUtility.maxPerks = 12
CoD.CACUtility.maxRewards = 3
CoD.CACUtility.maxRewardSlots = 3
CoD.CACUtility.maxAttachments = 2
CoD.CACUtility.maxPerkCategories = 3
CoD.CACUtility.maxPerksInEachCategory = 2
CoD.CACUtility.maxBonusCards = 3
CoD.CACUtility.maxDefaultClass = 5
CoD.CACUtility.maxMTXWeaponPacks = 10
CoD.CACUtility.ButtonGridLockImageSize = 40
CoD.CACUtility.LockImageMaterial = "menu_mp_lobby_locked"
CoD.CACUtility.ButtonGridBigLockImageSize = 64
CoD.CACUtility.ButtonGridNewImageWidth = 64
CoD.CACUtility.ButtonGridNewImageHeight = 32
CoD.CACUtility.ButtonGridNewImageRightAlignWidth = 32
CoD.CACUtility.LockImageBigMaterial = "menu_mp_lobby_locked_big"
CoD.CACUtility.NewImageMaterial = "menu_mp_lobby_new_small"
CoD.CACUtility.removeSFX = "cac_cmn_item_remove"
CoD.CACUtility.denySFX = "cac_cmn_deny"
CoD.CACUtility.carouselLRSFX = "cac_slide_nav_lr"
CoD.CACUtility.carouselUpSFX = "cac_slide_nav_up"
CoD.CACUtility.carouselDownSFX = "cac_slide_nav_down"
CoD.CACUtility.carouselEquipSFX = "cac_slide_equip_item"
CoD.CACUtility.EquipImageMaterial = "mutually_excl"
CoD.CACUtility.GainFocusSFX = "cac_loadout_nav"
CoD.CACUtility.WildcardGainFocusSFX = "cac_loadout_wildcard_nav"
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
	bonuscard1 = "bonuscard1",
	bonuscard2 = "bonuscard2",
	bonuscard3 = "bonuscard3",
	reward1 = "killstreak1",
	reward2 = "killstreak2",
	reward3 = "killstreak3"
}
CoD.CACUtility.WEAPONOPTION_GROUP_CAMO = 0
CoD.CACUtility.WEAPONOPTION_GROUP_TAG = 1
CoD.CACUtility.WEAPONOPTION_GROUP_EMBLEM = 2
CoD.CACUtility.WEAPONOPTION_GROUP_RETICLE = 3
CoD.CACUtility.WEAPONOPTION_GROUP_LENS = 4
CoD.CACUtility.WEAPONOPTION_GROUP_RETICLE_COLOR = 5
CoD.CACUtility.weaponOptionGroupNames = {
	WEAPONOPTION_GROUP_CAMO = "camo",
	WEAPONOPTION_GROUP_RETICLE = "reticle",
	WEAPONOPTION_GROUP_LENS = "lens",
	WEAPONOPTION_GROUP_TAG = "tag",
	WEAPONOPTION_GROUP_EMBLEM = "emblem",
	WEAPONOPTION_GROUP_RETICLE_COLOR = "reticle_color"
}
CoD.CACUtility.ATTACHMENT_NONE = 1
CoD.CACUtility.ATTACHMENT_ACOG = 2
CoD.CACUtility.ATTACHMENT_DUALCLIP = 3
CoD.CACUtility.ATTACHMENT_DUALOPTIC = 4
CoD.CACUtility.ATTACHMENT_DW = 5
CoD.CACUtility.ATTACHMENT_EXTBARREL = 6
CoD.CACUtility.ATTACHMENT_EXTCLIP = 7
CoD.CACUtility.ATTACHMENT_EXTRAMAGS = 8
CoD.CACUtility.ATTACHMENT_FASTADS = 9
CoD.CACUtility.ATTACHMENT_FASTRELOAD = 10
CoD.CACUtility.ATTACHMENT_FMJ = 11
CoD.CACUtility.ATTACHMENT_GL = 12
CoD.CACUtility.ATTACHMENT_GRIP = 13
CoD.CACUtility.ATTACHMENT_HOLO = 14
CoD.CACUtility.ATTACHMENT_IR = 15
CoD.CACUtility.ATTACHMENT_IRONSIGHTS = 16
CoD.CACUtility.ATTACHMENT_LONGBREATH = 17
CoD.CACUtility.ATTACHMENT_MK = 18
CoD.CACUtility.ATTACHMENT_MMS = 19
CoD.CACUtility.ATTACHMENT_RANGEFINDER = 20
CoD.CACUtility.ATTACHMENT_REFLEX = 21
CoD.CACUtility.ATTACHMENT_RF = 22
CoD.CACUtility.ATTACHMENT_SELECTFIRE = 23
CoD.CACUtility.ATTACHMENT_SILENCER = 24
CoD.CACUtility.ATTACHMENT_STACKFIRE = 25
CoD.CACUtility.ATTACHMENT_STALKER = 26
CoD.CACUtility.ATTACHMENT_STEADYAIM = 27
CoD.CACUtility.ATTACHMENT_SWAYREDUC = 28
CoD.CACUtility.ATTACHMENT_TACKNIFE = 29
CoD.CACUtility.ATTACHMENT_VZOOM = 30
CoD.CACUtility.ATTACHMENT_TYPE_COUNT = 31
CoD.CACUtility.ATTACHMENT_INVALID = 31
CoD.CACUtility.attachmentReferences = {
	"none",
	"acog",
	"dualclip",
	"dualoptic",
	"dw",
	"extbarrel",
	"extclip",
	"extramags",
	"fastads",
	"fastreload",
	"fmj",
	"gl",
	"grip",
	"holo",
	"ir",
	"is",
	"longbreath",
	"mk",
	"mms",
	"rangefinder",
	"reflex",
	"rf",
	"sf",
	"silencer",
	"stackfire",
	"stalker",
	"steadyaim",
	"swayreduc",
	"tacknife",
	"vzoom"
}
CoD.CACUtility.attachmentsWithCustReticle = {
	"reflex",
	"holo",
	"acog",
	"dualoptic"
}
CoD.CACUtility.defaultClassNames = {
	"class_custom_assault",
	"class_custom_smg",
	"class_custom_lmg",
	"class_custom_cqb",
	"class_custom_sniper"
}
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
	f1_arg0.rewardImages = {}
	f1_arg0.itemLabelTabs = {}
	f1_arg0.verticalLines = {}
	f1_arg0.horizontalLines = {}
	f1_arg0.camoImageContainers = {}
	f1_arg0.camoImages = {}
	f1_arg0.modsPrompts = {}
	f1_arg0.customizePrompts = {}
end

CoD.CACUtility.GetAllocationSpentFromClassData = function (f2_arg0)
	return CoD.SumClassItemCosts(f2_arg0.primaryWeapon) + CoD.SumClassItemCosts(f2_arg0.primaryAttachments) + CoD.SumClassItemCosts(f2_arg0.secondaryWeapon) + CoD.SumClassItemCosts(f2_arg0.secondaryAttachments) + CoD.SumClassItemCosts(f2_arg0.grenades) + CoD.SumClassItemCosts(f2_arg0.perks) + CoD.SumClassItemCosts(f2_arg0.rewards)
end

CoD.CACUtility.HowManyInClassData = function (f3_arg0, f3_arg1)
	return CoD.HowManyInClassSlot(f3_arg0, f3_arg1.primaryWeapon) + CoD.HowManyInClassSlot(f3_arg0, f3_arg1.secondaryWeapon) + CoD.HowManyInClassSlot(f3_arg0, f3_arg1.grenades) + CoD.HowManyInClassSlot(f3_arg0, f3_arg1.perks) + CoD.HowManyInClassSlot(f3_arg0, f3_arg1.rewards)
end

CoD.CACUtility.GetClassData = function (f4_arg0, f4_arg1)
	local f4_local0 = {}
	if f4_arg1 == nil then
		f4_arg1 = CoD.perController[f4_arg0].classNumInternal
	end
	local f4_local1 = CoD.CACUtility.loadoutSlotNames
	f4_local0.primaryWeapon = {}
	CoD.AddClassItemData(f4_local0.primaryWeapon, CoD.GetClassItem(f4_arg0, f4_arg1, f4_local1.primaryWeapon))
	f4_local0.secondaryWeapon = {}
	CoD.AddClassItemData(f4_local0.secondaryWeapon, CoD.GetClassItem(f4_arg0, f4_arg1, f4_local1.secondaryWeapon))
	f4_local0.primaryAttachments = {}
	f4_local0.secondaryAttachments = {}
	local f4_local2 = CoD.GetClassItem(f4_arg0, f4_arg1, f4_local1.primaryWeapon)
	local f4_local3 = CoD.GetClassItem(f4_arg0, f4_arg1, f4_local1.secondaryWeapon)
	for f4_local4 = 0, 2, 1 do
		CoD.AddClassAttachmentData(f4_local0.primaryAttachments, f4_local2, CoD.GetClassItem(f4_arg0, f4_arg1, f4_local1.primaryWeapon .. "attachment" .. f4_local4 + 1))
		CoD.AddClassAttachmentData(f4_local0.secondaryAttachments, f4_local3, CoD.GetClassItem(f4_arg0, f4_arg1, f4_local1.secondaryWeapon .. "attachment" .. f4_local4 + 1))
	end
	f4_local0.grenades = {}
	CoD.AddClassItemData(f4_local0.grenades, CoD.GetClassItem(f4_arg0, f4_arg1, f4_local1.primaryGrenade), CoD.GetClassItem(f4_arg0, f4_arg1, "primarygrenadecount"), f4_local1.primaryGrenade)
	CoD.AddClassItemData(f4_local0.grenades, CoD.GetClassItem(f4_arg0, f4_arg1, f4_local1.specialGrenade), CoD.GetClassItem(f4_arg0, f4_arg1, "specialgrenadecount"), f4_local1.specialGrenade)
	local f4_local4 = CoD.CACUtility.maxSpecialtySlots
	f4_local0.perks = {}
	for f4_local5 = 1, f4_local4, 1 do
		CoD.AddClassItemData(f4_local0.perks, CoD.GetClassItem(f4_arg0, f4_arg1, f4_local1["specialty" .. f4_local5]))
	end
	local f4_local5 = CoD.CACUtility.maxRewards
	f4_local0.rewards = {}
	for f4_local6 = 1, f4_local5, 1 do
		CoD.AddClassItemData(f4_local0.rewards, CoD.GetClassItem(f4_arg0, f4_arg1, "killstreak" .. f4_local6))
	end
	table.sort(f4_local0.rewards, function (f28_arg0, f28_arg1)
		return f28_arg0.momentumCost < f28_arg1.momentumCost
	end)
	return f4_local0
end

CoD.CACUtility.GetDefaultClassData = function (f5_arg0, f5_arg1)
	local f5_local0 = {}
	local f5_local1 = CoD.CACUtility.loadoutSlotNames
	local f5_local2 = UIExpression.GetDefaultClassSlot(f5_arg0, f5_arg1, f5_local1.primaryWeapon)
	local f5_local3 = UIExpression.GetDefaultClassSlot(f5_arg0, f5_arg1, f5_local1.secondaryWeapon)
	f5_local0.primaryWeapon = {}
	CoD.AddClassItemData(f5_local0.primaryWeapon, f5_local2)
	f5_local0.secondaryWeapon = {}
	CoD.AddClassItemData(f5_local0.secondaryWeapon, f5_local3)
	f5_local0.primaryAttachments = {}
	f5_local0.secondaryAttachments = {}
	for f5_local4 = 0, 2, 1 do
		CoD.AddClassAttachmentData(f5_local0.primaryAttachments, f5_local2, UIExpression.GetDefaultClassSlot(f5_arg0, f5_arg1, f5_local1.primaryWeapon .. "attachment" .. f5_local4 + 1))
		CoD.AddClassAttachmentData(f5_local0.secondaryAttachments, f5_local3, UIExpression.GetDefaultClassSlot(f5_arg0, f5_arg1, f5_local1.secondaryWeapon .. "attachment" .. f5_local4 + 1))
	end
	f5_local0.grenades = {}
	CoD.AddClassItemData(f5_local0.grenades, UIExpression.GetDefaultClassSlot(f5_arg0, f5_arg1, f5_local1.primaryGrenade), UIExpression.GetDefaultClassSlot(f5_arg0, f5_arg1, "primarygrenadecount"), f5_local1.primaryGrenade)
	CoD.AddClassItemData(f5_local0.grenades, UIExpression.GetDefaultClassSlot(f5_arg0, f5_arg1, f5_local1.specialGrenade), UIExpression.GetDefaultClassSlot(f5_arg0, f5_arg1, "specialgrenadecount"), f5_local1.specialGrenade)
	local f5_local4 = CoD.CACUtility.maxSpecialtySlots
	f5_local0.perks = {}
	for f5_local5 = 1, f5_local4, 1 do
		CoD.AddClassItemData(f5_local0.perks, UIExpression.GetDefaultClassSlot(f5_arg0, f5_arg1, f5_local1["specialty" .. f5_local5]))
	end
	local f5_local5 = CoD.CACUtility.maxRewards
	f5_local0.rewards = {}
	for f5_local6 = 1, f5_local5, 1 do
		CoD.AddClassItemData(f5_local0.rewards, UIExpression.GetDefaultClassSlot(f5_arg0, f5_arg1, "killstreak" .. f5_local6))
	end
	table.sort(f5_local0.rewards, function (f29_arg0, f29_arg1)
		return f29_arg0.momentumCost < f29_arg1.momentumCost
	end)
	return f5_local0
end

CoD.CACUtility.UpdateUIFromClassData = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	CoD.PopulateWeaponInfo(f6_arg0.primaryWeapon, f6_arg1.primaryWeaponLabel, f6_arg1.primaryWeaponImage)
	CoD.PopulateWeaponAttachmentInfo(f6_arg0.primaryAttachments, f6_arg1.attachmentLabels.primary)
	CoD.PopulateWeaponInfo(f6_arg0.secondaryWeapon, f6_arg1.secondaryWeaponLabel, f6_arg1.secondaryWeaponImage)
	CoD.PopulateWeaponAttachmentInfo(f6_arg0.secondaryAttachments, f6_arg1.attachmentLabels.secondary)
	if f6_arg0.primaryWeapon == nil and f6_arg1.primaryWeaponLabel ~= nil then
		f6_arg1.primaryWeaponLabel:setText(Engine.Localize("MPUI_PRIMARY_CAPS"))
	end
	if f6_arg0.secondaryWeapon == nil and f6_arg1.secondaryWeaponLabel ~= nil then
		f6_arg1.secondaryWeaponLabel:setText(Engine.Localize("MPUI_SECONDARY_CAPS"))
	end
	CoD.PopulateGrenadeLabel(f6_arg0.grenades, f6_arg1.grenadeLabel)
	CoD.PopulateClassLabels(f6_arg0.perks, f6_arg1.perkLabels)
	local f6_local0 = CoD.CACGetWeaponAvailableAttachments(f6_arg0.primaryWeapon, f6_arg2)
	local f6_local1 = CoD.CACGetWeaponAvailableAttachments(f6_arg0.secondaryWeapon, f6_arg2)
	CoD.PopulateClassBGImages(f6_arg1, f6_arg0.primaryWeapon, "primary", f6_arg0.primaryAttachments, f6_arg1.attachmentImageBGs.primary, f6_local0)
	CoD.PopulateClassImages(f6_arg0.primaryAttachments, f6_arg1.attachmentImages.primary)
	CoD.PopulateCamoImage(f6_arg1, f6_arg0.primaryWeapon, "primary", f6_local0)
	CoD.PopulateClassBGImages(f6_arg1, f6_arg0.secondaryWeapon, "secondary", f6_arg0.secondaryAttachments, f6_arg1.attachmentImageBGs.secondary, f6_local1)
	CoD.PopulateClassImages(f6_arg0.secondaryAttachments, f6_arg1.attachmentImages.secondary)
	CoD.PopulateCamoImage(f6_arg1, f6_arg0.secondaryWeapon, "secondary", f6_local1)
	CoD.PopulateClassBGImages(f6_arg1, f6_arg0.grenades, "grenades")
	CoD.PopulateGrenadeImages(f6_arg0.grenades, f6_arg1.grenadeImages, f6_arg1.grenadeImageBGs)
	CoD.PopulateClassBGImages(f6_arg1, f6_arg0.perks, "perks")
	CoD.PopulateClassImages(f6_arg0.perks, f6_arg1.perkImages)
	CoD.PopulateClassImages(f6_arg0.rewards, f6_arg1.rewardImages)
	CoD.PopulateGrenadeCountLabels(f6_arg0.grenades, f6_arg1.grenadeCountLabels)
	if f6_arg3 ~= nil then
		f6_arg3:setRemainingAllocation(CoD.AllocationSubtitle.MaxAllocation - CoD.CACUtility.GetAllocationSpentFromClassData(f6_arg0))
	end
end

CoD.CACUtility.SetDefaultCACRoot = function (f7_arg0)
	if CoD.isOnlineGame() ~= true then
		local f7_local0 = CoD.perController[f7_arg0]
		local f7_local1 = Engine.GetPlayerExeGamerProfile(f7_arg0)
		f7_local0.cacRoot = f7_local1.cacLoadouts
	elseif Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
		local f7_local0 = CoD.perController[f7_arg0]
		local f7_local1 = Engine.GetPlayerStats(f7_arg0)
		f7_local0.cacRoot = f7_local1.leagueCacLoadouts
	elseif Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) then
		local f7_local0 = CoD.perController[f7_arg0]
		local f7_local1 = Engine.GetPlayerStats(f7_arg0)
		f7_local0.cacRoot = f7_local1.customMatchCacLoadouts
	else
		local f7_local0 = CoD.perController[f7_arg0]
		local f7_local1 = Engine.GetPlayerStats(f7_arg0)
		f7_local0.cacRoot = f7_local1.cacLoadouts
	end
end

CoD.CACUtility.SetGametypeSettingsCACRoot = function (f8_arg0, f8_arg1)
	local f8_local0 = nil
	if f8_arg1 == CoD.TEAM_FREE then
		f8_local0 = 0
	else
		f8_local0 = f8_arg1 - CoD.TEAM_FIRST_PLAYING_TEAM + 1
	end
	local f8_local1 = CoD.perController[f8_arg0]
	local f8_local2 = Engine.GetGametypeSettings()
	f8_local1.cacRoot = f8_local2.cacLoadouts[f8_local0]
end

CoD.CACUtility.GetCACRoot = function (f9_arg0)
	return CoD.perController[f9_arg0].cacRoot
end

CoD.CACUtility.GetLoadoutNames = function (f10_arg0)
	local f10_local0 = CoD.CACUtility.GetCACRoot(f10_arg0)
	if f10_local0 then
		return f10_local0.customClassName
	else
		return nil
	end
end

CoD.CACUtility.GetLoadoutNameFromIndex = function (f11_arg0, f11_arg1)
	if CoD.isSinglePlayer == true then
		return CoD.CACUtility.GetLoadoutNames(f11_arg0)
	else
		local f11_local0 = CoD.CACUtility.GetLoadoutNames(f11_arg0)
		if f11_local0 then
			return f11_local0[f11_arg1]
		else
			return nil
		end
	end
end

CoD.CACUtility.GetDefaultLoadoutNameFromIndex = function (f12_arg0)
	if f12_arg0 < 1 or f12_arg0 > CoD.CACUtility.maxDefaultClass then
		error("LUI Error: Default loadout out with index " .. f12_arg0 .. " doesn't exist.")
	end
	return CoD.CACUtility.defaultClassNames[f12_arg0]
end

CoD.CACUtility.SetupCACLock = function (f13_arg0)
	CoD.SetupButtonLock(f13_arg0, nil, "FEATURE_CREATE_A_CLASS", "FEATURE_CREATE_A_CLASS_DESC")
end

CoD.CACUtility.SetupCACNew = function (f14_arg0)
	f14_arg0:registerEventHandler("cac_closed", CoD.CACUtility.SetupCACNew)
	f14_arg0:showNewIcon(Engine.IsAnythingInCACNew(UIExpression.GetPrimaryController()))
end

CoD.CACUtility.SetupScorestreaksNew = function (f15_arg0)
	f15_arg0:registerEventHandler("scorestreaks_closed", CoD.CACUtility.SetupScorestreaksNew)
	f15_arg0:showNewIcon(Engine.WeaponGroupHasNewItem(UIExpression.GetPrimaryController(), "killstreak"))
end

CoD.CACUtility.IsBonusCardEquippedByName = function (f16_arg0, f16_arg1)
	local f16_local0 = UIExpression.GetItemIndex(nil, f16_arg1)
	for f16_local1 = 1, CoD.CACUtility.maxBonusCards, 1 do
		if f16_local0 ~= nil and f16_arg0["bonuscard" .. f16_local1] == f16_local0 then
			return true
		end
	end
	return false
end

CoD.CACUtility.IsBonusCardEquippedByIndex = function (f17_arg0, f17_arg1)
	for f17_local0 = 1, CoD.CACUtility.maxBonusCards, 1 do
		if f17_arg1 ~= nil and f17_arg0["bonuscard" .. f17_local0] == f17_arg1 then
			return true
		end
	end
	return false
end

CoD.CACUtility.GetBonusCardLoadoutSlot = function (f18_arg0, f18_arg1)
	for f18_local0 = 1, CoD.CACUtility.maxBonusCards, 1 do
		local f18_local3 = "bonuscard" .. f18_local0
		if f18_arg1 ~= nil and f18_arg0[f18_local3] == f18_arg1 then
			return f18_local3
		end
	end
end

CoD.CACUtility.AttachmentHasCustomReticle = function (f19_arg0)
	for f19_local3, f19_local4 in ipairs(CoD.CACUtility.attachmentsWithCustReticle) do
		if f19_local4 == f19_arg0 then
			return f19_local4
		end
	end
	return nil
end

CoD.CACUtility.GetWeaponOptionMTXName = function (f20_arg0)
	return UIExpression.TableLookup(nil, CoD.attachmentTable, 0, f20_arg0, 16)
end

CoD.CACUtility.GetBackingMTXName = function (f21_arg0)
	return UIExpression.TableLookup(nil, "mp/emblemsOrBackings.csv", 0, "background", 1, f21_arg0, 10)
end

CoD.CACUtility.IsWeaponOptionMTX = function (f22_arg0)
	local f22_local0 = CoD.CACUtility.GetWeaponOptionMTXName(f22_arg0)
	local f22_local1
	if f22_local0 == 0 then
		f22_local1 = f22_local0
	else
		f22_local1 = f22_local0 ~= ""
	end
	return f22_local1
end

CoD.CACUtility.IsBackingMTX = function (f23_arg0)
	local f23_local0 = CoD.CACUtility.GetBackingMTXName(f23_arg0)
	local f23_local1
	if f23_local0 == 0 then
		f23_local1 = f23_local0
	else
		f23_local1 = f23_local0 ~= ""
	end
	return f23_local1
end

CoD.CACUtility.IsAnyWeaponMTXAvailable = function ()
	for f24_local0 = 0, CoD.CACUtility.maxMTXWeaponPacks, 1 do
		if Engine.IsMTXAvailable("mtx_weapon" .. f24_local0) then
			return true
		end
	end
	return false
end

CoD.CACUtility.HasAnyWeaponMTX = function (f25_arg0)
	for f25_local0 = 0, CoD.CACUtility.maxMTXWeaponPacks, 1 do
		if Engine.HasMTX(f25_arg0, "mtx_weapon" .. f25_local0) then
			return true
		end
	end
	return false
end

CoD.CACUtility.ShouldDisplayWeaponOptionMTX = function (f26_arg0, f26_arg1)
	if Engine.SkipMTXItem(CoD.CACUtility.GetWeaponOptionMTXName(f26_arg1)) == true then
		return false
	else
		return true
	end
end

CoD.CACUtility.GetMTXPurchaseMsg = function (f27_arg0)
	return "MPUI_" .. UIExpression.TableLookup(nil, "mp/mtxitems.csv", 1, f27_arg0, 3) .. "_MSG"
end

