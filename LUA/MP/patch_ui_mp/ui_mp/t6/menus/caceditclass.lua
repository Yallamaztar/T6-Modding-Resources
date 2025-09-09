require("T6.CACWeaponsP")
require("T6.CACPerksP")
require("T6.CustomClass")
CoD.CACEditClass = {}
CoD.CACEditClass.WeaponSelectSFX = "cac_loadout_edit_sel"
CoD.CACEditClass.SubmenuSelectSFX = "cac_loadout_edit_submenu"
LUI.createMenu.CACEditClass = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CACEditClass")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	if CoD.perController[f1_arg0].isPreset then
		f1_local0:setPreviousMenu("EditDefaultClasses")
	else
		f1_local0:setPreviousMenu("CACChooseClass")
	end
	f1_local0:setBackOutSFX("cac_cmn_backout")
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	local f1_local1 = CoD.ButtonPrompt.new
	local f1_local2 = "select"
	local f1_local3 = Engine.Localize("MPUI_PERSONALIZE_KNIFE")
	local f1_local4 = f1_local0
	local f1_local5 = "button_prompt_knife"
	local f1_local6, f1_local7 = false
	local f1_local8, f1_local9 = false
	f1_local0.knifePersonalization = f1_local1(f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local7, f1_local8, f1_local9, "TAB")
	f1_local0:addLeftButtonPrompt(f1_local0.knifePersonalization)
	f1_local0:registerEventHandler("attachment_slot_chosen", CoD.CACEditClass.AttachmentSlotChosen)
	f1_local0:registerEventHandler("perk_slot_chosen", CoD.CACEditClass.PerkSlotChosen)
	f1_local0:registerEventHandler("grenades_chosen", CoD.CACEditClass.GrenadesChosen)
	f1_local0:registerEventHandler("bonuscard_chosen", CoD.CACEditClass.BonusCardChosen)
	f1_local0:registerEventHandler("equip_grenade", CoD.CACEditClass.EquipGrenade)
	f1_local0:registerEventHandler("slotlist_editing_start", CoD.CACEditClass.SlotListEditingStart)
	f1_local0:registerEventHandler("slotlist_editing_stop", CoD.CACEditClass.SlotListEditingStop)
	f1_local0:registerEventHandler("weapon_chosen", CoD.CACEditClass.WeaponChosen)
	f1_local0:registerEventHandler("add_select_button", CoD.CACEditClass.AddSelectButton)
	f1_local0:registerEventHandler("remove_select_button", CoD.CACEditClass.RemoveSelectButton)
	f1_local0:registerEventHandler("button_prompt_back", CoD.CACEditClass.Back)
	f1_local0:registerEventHandler("add_unequip_button", CoD.CACEditClass.AddUnequipButton)
	f1_local0:registerEventHandler("remove_unequip_button", CoD.CACEditClass.RemoveUnequipButton)
	f1_local0:registerEventHandler("button_prompt_unequip", CoD.CACEditClass.ButtonPromptUnequip)
	f1_local0:registerEventHandler("add_camo_button", CoD.CACEditClass.AddCamoButton)
	f1_local0:registerEventHandler("remove_camo_button", CoD.CACEditClass.RemoveCamoButton)
	f1_local0:registerEventHandler("add_reticle_button", CoD.CACEditClass.AddReticleButton)
	f1_local0:registerEventHandler("remove_reticle_button", CoD.CACEditClass.RemoveReticleButton)
	f1_local0:registerEventHandler("button_prompt_reticle", CoD.CACEditClass.ButtonPromptReticle)
	f1_local0:registerEventHandler("button_prompt_camo", CoD.CACEditClass.ButtonPromptCamo)
	f1_local0:registerEventHandler("purchased", CoD.CACEditClass.Purchased)
	f1_local0:registerEventHandler("button_prompt_knife", CoD.CACEditClass.OpenKnifePersonalization)
	f1_local2 = f1_local0
	f1_local1 = f1_local0.addTitle
	f1_local3 = Engine.Localize
	f1_local4 = CoD.CACUtility.GetLoadoutNameFromIndex(f1_arg0, CoD.perController[f1_arg0].classNum)
	f1_local1(f1_local2, f1_local3(f1_local4:get()))
	f1_local0.customClass = CoD.CustomClass.New({
		leftAnchor = false,
		rightAnchor = false,
		left = -CoD.CustomClass.Width / 2,
		right = CoD.CustomClass.Width / 2,
		topAnchor = true,
		bottomAnchor = true,
		top = 60,
		bottom = 0
	}, false, f1_arg0)
	f1_local0:addElement(f1_local0.customClass)
	if not Engine.AreAllItemsFree() then
		f1_local2 = Engine.GetPlayerStats(f1_arg0)
		if f1_local2.PlayerStatsList.PLEVEL.StatValue:get() < tonumber(CoD.MAX_PRESTIGE) then
			f1_local4 = CoD.CAC.CreateUnlockTokensFooter(f1_local0, f1_arg0)
			CoD.CAC.SetUnlockItemText(f1_local4, f1_arg0)
			f1_local0:addElement(f1_local4)
		end
	end
	f1_local0:dispatchEventToChildren({
		name = "update_class",
		controller = f1_arg0,
		classNum = CoD.perController[f1_arg0].classNum
	})
	f1_local0.customClass:restoreFocus(f1_arg0)
	CoD.SetPreviousAllocation(f1_arg0)
	return f1_local0
end

CoD.CACEditClass.WeaponChosen = function (f2_arg0, f2_arg1)
	CoD.SetPreviousAllocation(f2_arg1.controller)
	CoD.perController[f2_arg1.controller].weaponSlot = f2_arg1.weaponSlot
	Engine.PlaySound(CoD.CACEditClass.WeaponSelectSFX)
	CoD.EquipNotification.ClearNotificationQueue()
	f2_arg0:openMenu("CACPrimaryWeapons", f2_arg1.controller)
	f2_arg0:close()
end

CoD.CACEditClass.AttachmentSlotChosen = function (f3_arg0, f3_arg1)
	CoD.SetPreviousAllocation(f3_arg1.controller)
	CoD.perController[f3_arg1.controller].weaponSlot = f3_arg1.weaponSlot
	CoD.perController[f3_arg1.controller].slotIndex = f3_arg1.slotIndex
	Engine.PlaySound(CoD.CACEditClass.SubmenuSelectSFX)
	CoD.EquipNotification.ClearNotificationQueue()
	f3_arg0:openMenu("CACAttachments", f3_arg1.controller)
	f3_arg0:close()
end

CoD.CACEditClass.PerkSlotChosen = function (f4_arg0, f4_arg1)
	CoD.SetPreviousAllocation(f4_arg1.controller)
	CoD.perController[f4_arg1.controller].perkCategory = f4_arg1.perkCategory
	CoD.perController[f4_arg1.controller].slotIndex = f4_arg1.slotIndex
	Engine.PlaySound(CoD.CACEditClass.SubmenuSelectSFX)
	CoD.EquipNotification.ClearNotificationQueue()
	f4_arg0:openMenu("CACPerksP", f4_arg1.controller)
	f4_arg0:close()
end

CoD.CACEditClass.BonusCardChosen = function (f5_arg0, f5_arg1)
	CoD.SetPreviousAllocation(f5_arg1.controller)
	CoD.perController[f5_arg1.controller].bonusCardSlot = f5_arg1.bonusCardSlot
	Engine.PlaySound(CoD.CACEditClass.SubmenuSelectSFX)
	CoD.EquipNotification.ClearNotificationQueue()
	f5_arg0:openMenu("CACBonusCards", f5_arg1.controller)
	f5_arg0:close()
end

CoD.CACEditClass.GrenadesChosen = function (f6_arg0, f6_arg1)
	CoD.SetPreviousAllocation(f6_arg1.controller)
	local f6_local0 = f6_arg1.controller
	local f6_local1 = f6_arg1.weaponSlot
	CoD.perController[f6_local0].grenadeSlot = f6_local1
	CoD.perController[f6_local0].slotIndex = f6_arg1.slotIndex
	CoD.EquipNotification.ClearNotificationQueue()
	if f6_arg1.slotIndex == 1 then
		Engine.PlaySound(CoD.CACEditClass.SubmenuSelectSFX)
		f6_arg0:openMenu("CACGrenades", f6_arg1.controller)
		f6_arg0:close()
	else
		local f6_local2 = CoD.perController[f6_local0].classNum
		local f6_local3 = Engine.GetCustomClass(f6_local0, f6_local2)
		local f6_local4 = f6_local1 .. "count"
		local f6_local5 = f6_local3[f6_local4]
		if f6_local5 and f6_local5 > 0 then
			if Engine.GetClassItem(f6_local0, f6_local2, f6_local1 .. "status" .. f6_arg1.slotIndex) == 0 then
				CoD.perController[f6_local0].chosenItem = f6_arg1.slotIndex
				if f6_local3.allocationSpent < Engine.GetMaxAllocation(f6_local0) then
					f6_arg0:processEvent({
						name = "equip_grenade",
						controller = f6_local0
					})
					f6_arg1.button:addUnequipPrompt()
					Engine.PlaySound("cac_grid_equip_item")
				else
					local f6_local6 = f6_arg0:openPopup("CACRemoveItem", f6_local0)
					f6_local6:setEquipEventName("equip_grenade")
				end
			else
				CoD.EquipNotification.AddToNotificationQueue("item", "unequipped", UIExpression.GetItemName(nil, Engine.GetClassItem(f6_local0, f6_local2, f6_local1)))
				Engine.SetClassItem(f6_local0, f6_local2, f6_local4, f6_local5 - 1)
				Engine.SetClassItem(f6_local0, f6_local2, f6_local1 .. "status" .. f6_arg1.slotIndex, 0)
				f6_arg0:dispatchEventToChildren({
					name = "update_class",
					controller = f6_local0,
					classNum = f6_local2
				})
				f6_arg1.button:removeUnequipPrompt()
				CoD.perController[f6_local0].grenadeSlot = nil
				Engine.PlaySound("cac_grid_equip_item")
			end
		end
	end
end

CoD.CACEditClass.EquipGrenade = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg1.controller
	local f7_local1 = CoD.perController[f7_local0].classNum
	local f7_local2 = CoD.perController[f7_local0].grenadeSlot
	local f7_local3 = Engine.GetCustomClass(f7_local0, f7_local1)
	local f7_local4 = f7_local2 .. "count"
	local f7_local5 = f7_local3[f7_local4]
	local f7_local6 = CoD.perController[f7_local0].chosenItem
	CoD.perController[f7_local0].chosenItem = nil
	CoD.perController[f7_local0].grenadeSlot = nil
	CoD.SetPreviousAllocation(f7_arg1.controller)
	Engine.SetClassItem(f7_local0, f7_local1, f7_local4, f7_local5 + 1)
	CoD.EquipNotification.AddToNotificationQueue("item", "equipped", UIExpression.GetItemName(nil, Engine.GetClassItem(f7_local0, f7_local1, f7_local2)))
	Engine.SetClassItem(f7_local0, f7_local1, f7_local2 .. "status" .. f7_local6, 1)
	f7_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f7_local0,
		classNum = f7_local1
	})
end

CoD.CACEditClass.SlotListEditingStart = function (f8_arg0, f8_arg1)
	f8_arg0:dispatchEventToParent(f8_arg1)
end

CoD.CACEditClass.SlotListEditingStop = function (f9_arg0, f9_arg1)
	f9_arg0:registerEventHandler("button_prompt_back", CoD.Menu.ButtonPromptBack)
	f9_arg0:dispatchEventToParent(f9_arg1)
end

CoD.CACEditClass.Purchased = function (f10_arg0, f10_arg1)
	f10_arg1.button:setUnpurchasedImage(false)
	f10_arg1.button.image:setAlpha(1)
end

CoD.CACEditClass.AddSelectButton = function (f11_arg0, f11_arg1)
	f11_arg0:removeBackButton()
	f11_arg0:removeSelectButton()
	f11_arg0:addSelectButton()
	f11_arg0:addBackButton()
end

CoD.CACEditClass.RemoveSelectButton = function (f12_arg0, f12_arg1)
	f12_arg0:removeSelectButton()
end

CoD.CACEditClass.Back = function (f13_arg0, f13_arg1)
	CoD.EquipNotification.ClearNotificationQueue()
	CoD.previousAllocationAmount = nil
	CoD.Menu.ButtonPromptBack(f13_arg0, f13_arg1)
end

CoD.CACEditClass.AddUnequipButton = function (f14_arg0, f14_arg1)
	if f14_arg0.unequipButton == nil then
		local f14_local0 = CoD.ButtonPrompt.new
		local f14_local1 = "alt1"
		local f14_local2 = Engine.Localize("MENU_REMOVE")
		local f14_local3 = f14_arg0
		local f14_local4 = "button_prompt_unequip"
		local f14_local5, f14_local6 = false
		local f14_local7, f14_local8 = false
		f14_arg0.unequipButton = f14_local0(f14_local1, f14_local2, f14_local3, f14_local4, f14_local5, f14_local6, f14_local7, f14_local8, "R")
	end
	f14_arg0:addRightButtonPrompt(f14_arg0.unequipButton)
end

CoD.CACEditClass.RemoveUnequipButton = function (f15_arg0, f15_arg1)
	if f15_arg0.unequipButton ~= nil then
		f15_arg0.unequipButton:close()
		f15_arg0.unequipButton = nil
	end
end

CoD.CACEditClass.AddCamoButton = function (f16_arg0, f16_arg1)
	if f16_arg0.camoButton == nil then
		local f16_local0 = CoD.ButtonPrompt.new
		local f16_local1 = "alt2"
		local f16_local2 = Engine.Localize("MPUI_PERSONALIZE_WEAPON")
		local f16_local3 = f16_arg0
		local f16_local4 = "button_prompt_camo"
		local f16_local5, f16_local6 = false
		local f16_local7, f16_local8 = false
		f16_arg0.camoButton = f16_local0(f16_local1, f16_local2, f16_local3, f16_local4, f16_local5, f16_local6, f16_local7, f16_local8, "C")
		f16_local0 = Engine.IsWeaponOptionGroupNew(f16_arg1.controller, f16_arg1.itemIndex, CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
		if not f16_local0 then
			f16_local0 = Engine.IsWeaponOptionGroupNew(f16_arg1.controller, f16_arg1.itemIndex, CoD.CACUtility.WEAPONOPTION_GROUP_TAG)
			if not f16_local0 then
				f16_local0 = Engine.IsWeaponOptionGroupNew(f16_arg1.controller, f16_arg1.itemIndex, CoD.CACUtility.WEAPONOPTION_GROUP_EMBLEM)
			end
		end
		f16_arg0.camoButton:setNew(f16_local0)
	end
	f16_arg0:addRightButtonPrompt(f16_arg0.camoButton)
end

CoD.CACEditClass.RemoveCamoButton = function (f17_arg0, f17_arg1)
	if f17_arg0.camoButton ~= nil then
		f17_arg0.camoButton:close()
		f17_arg0.camoButton = nil
	end
end

CoD.CACEditClass.ButtonPromptCamo = function (f18_arg0, f18_arg1)
	Engine.PlaySound(CoD.CACEditClass.WeaponSelectSFX)
	CoD.perController[f18_arg1.controller].knifePersonalization = false
	f18_arg0:openMenu("CACCamo", f18_arg1.controller)
	f18_arg0:close()
end

CoD.CACEditClass.AddReticleButton = function (f19_arg0, f19_arg1)
	if f19_arg0.reticleButton == nil then
		local f19_local0 = CoD.ButtonPrompt.new
		local f19_local1 = "alt2"
		local f19_local2 = Engine.Localize("MENU_SELECT_RETICLE")
		local f19_local3 = f19_arg0
		local f19_local4 = "button_prompt_reticle"
		local f19_local5, f19_local6 = false
		local f19_local7, f19_local8 = false
		f19_arg0.reticleButton = f19_local0(f19_local1, f19_local2, f19_local3, f19_local4, f19_local5, f19_local6, f19_local7, f19_local8, "O")
		f19_arg0.reticleButton:setNew(Engine.IsWeaponOptionGroupNew(f19_arg1.controller, f19_arg1.eAttachment, CoD.CACUtility.WEAPONOPTION_GROUP_RETICLE))
	end
	f19_arg0.reticleButton.attachmentIndex = f19_arg1.attachmentIndex
	f19_arg0:addRightButtonPrompt(f19_arg0.reticleButton)
end

CoD.CACEditClass.RemoveReticleButton = function (f20_arg0, f20_arg1)
	if f20_arg0.reticleButton ~= nil then
		f20_arg0.reticleButton:close()
		f20_arg0.reticleButton = nil
	end
end

CoD.CACEditClass.ButtonPromptReticle = function (f21_arg0, f21_arg1)
	CoD.perController[f21_arg1.controller].attachmentIndex = f21_arg0.reticleButton.attachmentIndex
	Engine.PlaySound(CoD.CACEditClass.WeaponSelectSFX)
	f21_arg0:openMenu("CACReticles", f21_arg1.controller)
	f21_arg0:close()
end

CoD.CACEditClass.ButtonPromptUnequip = function (f22_arg0, f22_arg1)
	f22_arg0:dispatchEventToChildren({
		name = "button_prompt_unequip",
		controller = f22_arg1.controller
	})
end

CoD.CACEditClass.OpenKnifePersonalization = function (f23_arg0, f23_arg1)
	Engine.PlaySound(CoD.CACEditClass.WeaponSelectSFX)
	CoD.perController[f23_arg1.controller].knifePersonalization = true
	f23_arg0:openMenu("CACCamo", f23_arg1.controller)
	f23_arg0:close()
end

