require("T6.MFSlide")
require("T6.MFSlidePanel")
require("T6.CoD9Button")
require("T6.AttributeBarList")
CoD.CAC.ButtonGridDisabledAlpha = 0.2
CoD.CAC.createPanel.WeaponTypeSelection = function (f1_arg0)
	local f1_local0 = 30
	local f1_local1 = 30
	local f1_local2 = 350
	local f1_local3 = 400
	local f1_local4 = {
		left = -f1_local2,
		top = f1_local1,
		right = 0,
		bottom = f1_local3,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}
	local f1_local5 = {
		left = f1_local0,
		top = f1_local1,
		right = f1_local2,
		bottom = f1_local3,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}
	local f1_local6 = CoD.MFSlidePanel.new(f1_local4)
	f1_local6:registerAnimationState("primary", f1_local5)
	f1_local6.buttonList = CoD.ButtonList.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	f1_local6:addElement(f1_local6.buttonList)
	f1_local6.buttons = {}
	local f1_local7 = f1_local6.buttonList:addButton(Engine.Localize("MPUI_WEAPON_SMG_CAPS"))
	f1_local7.weaponGroup = "weapon_smg"
	f1_local6.buttons[f1_local7.weaponGroup] = f1_local7
	local f1_local8 = f1_local6.buttonList:addButton(Engine.Localize("MPUI_WEAPON_ASSAULT_CAPS"))
	f1_local8.weaponGroup = "weapon_assault"
	f1_local6.buttons[f1_local8.weaponGroup] = f1_local8
	local f1_local9 = f1_local6.buttonList:addButton(Engine.Localize("MPUI_WEAPON_CQB_CAPS"))
	f1_local9.weaponGroup = "weapon_cqb"
	f1_local6.buttons[f1_local9.weaponGroup] = f1_local9
	local f1_local10 = f1_local6.buttonList:addButton(Engine.Localize("MPUI_WEAPON_LMG_CAPS"))
	f1_local10.weaponGroup = "weapon_lmg"
	f1_local6.buttons[f1_local10.weaponGroup] = f1_local10
	local f1_local11 = f1_local6.buttonList:addButton(Engine.Localize("MPUI_WEAPON_SNIPER_CAPS"))
	f1_local11.weaponGroup = "weapon_sniper"
	f1_local6.buttons[f1_local11.weaponGroup] = f1_local11
	local f1_local12 = f1_local6.buttonList:addButton(Engine.Localize("MPUI_WEAPON_PISTOL_CAPS"))
	f1_local12.weaponGroup = "weapon_pistol"
	f1_local6.buttons[f1_local12.weaponGroup] = f1_local12
	local f1_local13 = f1_local6.buttonList:addButton(Engine.Localize("MPUI_WEAPON_LAUNCHER_CAPS"))
	f1_local13.weaponGroup = "weapon_launcher"
	f1_local6.buttons[f1_local13.weaponGroup] = f1_local13
	local f1_local14 = f1_local6.buttonList:addButton(Engine.Localize("MPUI_WEAPON_SPECIAL_CAPS"))
	f1_local14.weaponGroup = "weapon_special"
	f1_local6.buttons[f1_local14.weaponGroup] = f1_local14
	for f1_local18, f1_local19 in pairs(f1_local6.buttons) do
		f1_local19.CAC = f1_arg0
		f1_local19:registerEventHandler("button_action", CACWeaponSlot_WeaponTypeButtonAction)
		f1_local19:registerEventHandler("button_over", CACWeaponSlot_WeaponTypeButtonOver)
	end
	f1_local6:registerEventHandler("on_activate", CACWeaponSlot_WeaponTypeSelectionOnActivate)
	f1_local6.CAC = f1_arg0
	return f1_local6
end

function CACWeaponSlot_WeaponTypeSelectionOnActivate(f2_arg0, f2_arg1)
	local f2_local0 = CoD.perController[f2_arg1.controller].weaponGroup
	if f2_local0 == nil then
		f2_local0 = "weapon_smg"
	end
	if CoD.useController then
		f2_arg0.buttons[f2_local0]:processEvent({
			name = "gain_focus"
		})
	end
	local f2_local1 = f2_arg0.CAC:getAllocationSubtitle()
	f2_local1:setAllocationChange(nil)
end

function CACWeaponSlot_WeaponTypeSelectionBack(f3_arg0, f3_arg1)
	f3_arg0:closePanel("ItemsGrid")
	f3_arg0:closePanel("WeaponTypeSelection")
	f3_arg0:openClassPreview()
	f3_arg0:openPanel("LoadOutSelection")
	local f3_local0 = CoD.perController[f3_arg1.controller].classNumInternal
	local f3_local1 = f3_arg0
	local f3_local2 = f3_arg0.fadeInTitle
	local f3_local3 = CoD.CACUtility.GetLoadoutNameFromIndex(f3_arg1.controller, f3_local0)
	f3_local2(f3_local1, f3_local3:get())
	f3_arg0:registerEventHandler("button_prompt_back", CACLoadOut_LoadOutBack)
end

function CACWeaponSlot_WeaponTypeButtonAction(f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.CAC
	f4_local0:closePanel("WeaponTypeSelection")
	f4_local0:openPanel("ItemInfo")
	f4_local0:openPanel("WeaponAttributes")
	f4_local0:openPanel("ItemsGrid")
	CoD.perController[f4_arg1.controller].weaponGroup = f4_arg0.weaponGroup
	f4_local0:registerEventHandler("button_prompt_back", CACWeaponSlot_ItemGridBack)
end

function CACWeaponSlot_WeaponTypeButtonOver(f5_arg0, f5_arg1)
	LUI.UIButton.Over(f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.CAC
	local f5_local1 = f5_local0:getPanel("ItemsGrid")
	local f5_local2 = f5_local0:getAllocationSubtitle()
	if f5_local1 ~= nil then
		f5_local1:populate(f5_local1:createWeaponsGrid(f5_arg0.weaponGroup))
		f5_local1:updateButtonGrid(f5_local2)
	end
end

CoD.CAC.createPanel.ItemsGrid = function (f6_arg0)
	local f6_local0 = -30
	local f6_local1 = 30
	local f6_local2 = 400
	local f6_local3 = 465
	local f6_local4 = f6_local0 - f6_local2
	local f6_local5 = f6_local1 + f6_local3
	local f6_local6 = {
		left = 0,
		top = f6_local1,
		right = f6_local2,
		bottom = f6_local1 + f6_local3,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}
	local f6_local7 = {
		left = f6_local4,
		top = f6_local1,
		right = f6_local0,
		bottom = f6_local5,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}
	local f6_local8 = {
		left = 30,
		top = f6_local1,
		right = f6_local2 + 30,
		bottom = f6_local5,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}
	local f6_local9 = {
		left = -f6_local2,
		top = f6_local1,
		right = 0,
		bottom = f6_local1 + f6_local3,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}
	local f6_local10 = CoD.MFSlidePanel.new(f6_local6)
	f6_local10:registerAnimationState("primary", f6_local8)
	f6_local10:registerAnimationState("secondary", f6_local7)
	f6_local10:registerAnimationState("hidden_left", f6_local9)
	f6_local10:registerEventHandler("on_activate", CACWeaponSlot_ItemsGridOnActivate)
	f6_local10:registerEventHandler("on_close", CACWeaponSlot_ItemsGridOnClose)
	f6_local10.populate = CACWeaponSlot_ItemsGridPopulate
	f6_local10.createWeaponsGrid = CACWeaponSlot_CreateWeaponsGrid
	f6_local10.createAttachmentsGrid = CACWeaponSlot_CreateAttachmentsGrid
	f6_local10.createGrenadesGrid = CACGrenadeSelection_CreateGrenadesGrid
	f6_local10.createPerksGrid = CACPerksSelection_CreatePerksGrid
	f6_local10.updateButtonGrid = CACWeaponSlot_UpdateButtonGrid
	f6_local10.restrictMouseInputTo = CACWeaponSlot_ButtonGridRestrictMouseInputTo
	f6_local10.CAC = f6_arg0
	return f6_local10
end

function CACWeaponSlot_ItemsGridOnActivate(f7_arg0, f7_arg1)
	local f7_local0 = f7_arg0.CAC
	local f7_local1 = f7_local0:getPanel("ItemsInfo")
	local f7_local2 = f7_local0:getAllocationSubtitle()
	local f7_local3 = f7_arg0.buttonGrid
	local f7_local4 = f7_local3.buttons[1]
	if f7_local3 ~= nil then
		f7_arg0:updateButtonGrid(f7_local2)
		if f7_local4 ~= nil and CoD.useController then
			f7_local4:processEvent({
				name = "gain_focus"
			})
			if f7_local1 ~= nil then
				f7_local1:update(f7_local4)
			end
		end
	end
end

function CACWeaponSlot_ItemsGridOnClose(f8_arg0, f8_arg1)
	if f8_arg0.buttonGrid ~= nil then
		f8_arg0.buttonGrid:close()
		f8_arg0.buttonGrid = nil
	end
end

function CACWeaponSlot_ItemGridBack(f9_arg0, f9_arg1)
	f9_arg0:closePanel("ItemInfo")
	f9_arg0:closePanel("WeaponAttributes")
	f9_arg0:openPanel("ItemsGrid", "secondary")
	f9_arg0:openPanel("WeaponTypeSelection")
	f9_arg0:registerEventHandler("button_prompt_back", CACWeaponSlot_WeaponTypeSelectionBack)
end

function CACWeaponSlot_ItemsGridPopulate(f10_arg0, f10_arg1)
	if f10_arg0.buttonGrid ~= nil then
		f10_arg0.buttonGrid:close()
		f10_arg0.buttonGrid = nil
	end
	f10_arg0.buttonGrid = f10_arg1
	f10_arg0:addElement(f10_arg1)
	f10_arg0.buttonGrid:animateIn()
end

function CACWeaponSlot_ButtonGridRestrictMouseInputTo(f11_arg0, f11_arg1)
	local f11_local0 = f11_arg0.buttonGrid
	if f11_local0 == nil then
		return 
	elseif f11_arg1 ~= nil then
		for f11_local4, f11_local5 in pairs(f11_local0.buttons) do
			if f11_local5 == f11_arg1 then
				f11_local5.handleMouseInput = true
			else
				f11_local5.handleMouseInput = false
			end
		end
	else
		for f11_local4, f11_local5 in pairs(f11_local0.buttons) do
			f11_local5.handleMouseInput = true
		end
	end
end

function CACWeaponSlot_UpdateButtonGrid(f12_arg0, f12_arg1)
	local f12_local0 = f12_arg0.CAC.m_ownerController
	local f12_local1 = CoD.perController[f12_local0].classNumInternal
	local f12_local2 = f12_arg0.buttonGrid
	if f12_local2 == nil or f12_arg1 == nil then
		return 
	end
	local f12_local3 = CoD.CAC.GetUnlockCountForGroup(controllerIndex, f12_arg0.buttonGrid.weaponGroup)
	local f12_local4 = UIExpression.GetUnlockIndexFromGroupName(nil, f12_arg0.buttonGrid.weaponGroup)
	if f12_arg0.buttonGrid.unlockTokenText ~= nil then
		f12_arg0.buttonGrid.unlockTokenText:setText(CoD.CAC.GetUnlockTokenText(f12_local3, f12_local4, "MPUI_UNLOCK_TOKENS_AVAILABLE", "MPUI_UNLOCK_TOKEN_AVAILABLE"))
	end
	local f12_local5 = f12_local2.maxSelections
	local f12_local6 = 0
	for f12_local14, f12_local15 in pairs(f12_local2.buttons) do
		if f12_arg1:canAfford(f12_local15.itemCost) ~= true then
			f12_local15.itemImage:animateToState("disabled")
			f12_local15.disabled = true
			f12_local15.cannotAfford = true
		else
			f12_local15.itemImage:animateToState("default")
			f12_local15.disabled = nil
			f12_local15.cannotAfford = nil
		end
		if f12_local15.itemIndex ~= nil and CoD.IsWeapon(f12_local15.itemIndex) then
			local f12_local10 = CoD.perController[f12_local0].weaponSlot
			local f12_local11 = CoD.GetClassItem(f12_local0, f12_local1, CoD.CACUtility.loadoutSlotNames.primaryWeapon)
			local f12_local12 = CoD.GetClassItem(f12_local0, f12_local1, CoD.CACUtility.loadoutSlotNames.secondaryWeapon)
			if f12_local11 == f12_local15.itemIndex or f12_local12 == f12_local15.itemIndex then
				f12_local15.itemImage:animateToState("disabled")
				f12_local15.disabled = true
				if f12_local11 == f12_local15.itemIndex then
					local f12_local13 = Engine.Localize("MPUI_PRIMARY_WEAPON_CAPS")
					f12_local15.slotLabel:setText(f12_local13)
					f12_local15.equipped = f12_local13
				elseif f12_local12 == f12_local15.itemIndex then
					local f12_local13 = Engine.Localize("MPUI_SECONDARY_WEAPON_CAPS")
					f12_local15.slotLabel:setText(f12_local13)
					f12_local15.equipped = f12_local13
				else
					f12_local15.equipped = nil
				end
			end
		end
		if f12_local15.attachmentIndex ~= nil then
			local f12_local10 = CoD.GetClassItem(f12_local0, f12_local1, f12_local15.loadoutSlot) ~= 0
			local f12_local11 = Engine.GetItemAttachmentLocked(f12_local0, f12_local15.weaponIndex, f12_local15.attachmentIndex) ~= 0
			if f12_local10 then
				f12_local15.itemImage:animateToState("disabled")
				f12_local15.disabled = true
				f12_local15.slotOccupied = true
			else
				f12_local15.slotOccupied = nil
			end
			if f12_local11 then
				f12_local15.itemImage:animateToState("disabled")
				f12_local15.disabled = true
				f12_local15.lockImage:animateToState("show")
			end
			if CoD.GetClassItem(f12_local0, f12_local1, f12_local15.loadoutSlot) == f12_local15.attachmentIndex then
				f12_local6 = f12_local6 + 1
				f12_local15.itemImage:animateToState("default")
				f12_local15.background:animateToState("selected")
				f12_local15.selected = true
				f12_local15.disabled = nil
			else
				f12_local15.background:animateToState("default")
				f12_local15.selected = nil
			end
		end
		if f12_local15.itemIndex ~= nil and CoD.IsGrenade(f12_local15.itemIndex) then
			local f12_local11 = CoD.CACUtility.HowManyInClassData(f12_local15.itemIndex, CoD.CACUtility.GetClassData(f12_local0, f12_local1))
			if f12_local11 > 0 then
				f12_local6 = f12_local6 + 1
				f12_local15.itemImage:animateToState("disabled")
				f12_local15.background:animateToState("selected")
				f12_local15.currentQuantity = f12_local11
				if f12_local11 > 1 then
					f12_local15.quantityLabel:setText(Engine.Localize("MENU_MULTIPLIER_X", f12_local11))
				else
					f12_local15.quantityLabel:setText("")
				end
				f12_local15.disabled = nil
				f12_local15.selected = true
			else
				f12_local15.background:animateToState("default")
				f12_local15.quantityLabel:setText("")
				f12_local15.selected = nil
			end
		end
		if f12_local15.itemIndex ~= nil and CoD.IsPerk(f12_local15.itemIndex) then
			for f12_local10 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
				if CoD.GetClassItem(f12_local0, f12_local1, CoD.CACUtility.loadoutSlotNames["specialty" .. f12_local10]) == f12_local15.itemIndex then
					f12_local6 = f12_local6 + 1
					f12_local15.itemImage:animateToState("default")
					f12_local15.background:animateToState("selected")
					f12_local15.selected = true
					f12_local15.disabled = nil
					break
				end
				f12_local15.background:animateToState("default")
				f12_local15.selected = nil
			end
		end
		if f12_local15.itemIndex ~= nil then
			if UIExpression.IsItemPurchased(controllerIndex, f12_local15.itemIndex) ~= 1 then
				f12_local15.itemImage:animateToState("default")
				f12_local15.lockImage:animateToState("show")
				f12_local15.locked = true
				f12_local15.disabled = nil
			else
				f12_local15.lockImage:animateToState("default")
				f12_local15.locked = nil
			end
		end
		if f12_local15.itemIndex ~= nil then
			if UIExpression.GetItemCost(nil, f12_local15.itemIndex) <= f12_local3 then
				f12_local15.lockImage:animateToState("can_afford")
			else
				f12_local15.lockImage:animateToState("cannot_afford")
			end
		end
		if f12_local15.disabled == true then
			f12_local15.brackets:processEvent({
				name = "fade",
				red = 0.5,
				green = 0.5,
				blue = 0.5,
				alpha = 1
			})
		else
			f12_local15.brackets:processEvent({
				name = "fade",
				red = CoD.green.r,
				green = CoD.green.g,
				blue = CoD.green.b,
				alpha = 1
			})
		end
	end
	if f12_local5 <= f12_local6 then
		for f12_local14, f12_local15 in pairs(f12_local2.buttons) do
			if f12_local15.selected ~= true and f12_local15.locked ~= true then
				f12_local15.itemImage:animateToState("disabled")
				f12_local15.disabled = true
			else
				f12_local15.itemImage:animateToState("default")
				f12_local15.disabled = nil
				f12_local15.brackets:processEvent({
					name = "fade",
					red = CoD.green.r,
					green = CoD.green.g,
					blue = CoD.green.b,
					alpha = 1
				})
			end
		end
	end
end

function CACWeaponSlot_CreateAttachmentsGrid(f13_arg0)
	local f13_local0 = f13_arg0.CAC
	local f13_local1 = f13_local0.m_ownerController
	local f13_local2 = CoD.perController[f13_local1].classNumInternal
	local f13_local3 = CoD.perController[f13_local1].weaponSlot
	local f13_local4 = f13_local0:getAllocationSubtitle()
	local f13_local5 = CoD.GetAttachments(CoD.GetClassItem(f13_local1, f13_local2, f13_local3))
	local f13_local6 = CoD.ButtonGrid.new(4, {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}, 70, 70)
	f13_local6.maxSelections = CoD.CACUtility.maxAttachments
	table.sort(f13_local5, CoD.CACAttachmentComparisonFunction)
	for f13_local15, f13_local16 in pairs(f13_local5) do
		local f13_local17 = f13_local16.weaponItemIndex
		local f13_local18 = f13_local16.attachmentIndex
		local f13_local19 = Engine.GetAttachmentName(f13_local17, f13_local18)
		if f13_local19 ~= "MPUI_DW" then
			local f13_local10 = f13_local6:addButton()
			f13_local10.weaponIndex = f13_local17
			f13_local10.attachmentIndex = f13_local18
			f13_local10.loadoutSlot = CoD.GetLoadoutSlotForAttachment(f13_local3, f13_local17, f13_local18)
			f13_local10.itemName = UIExpression.ToUpper(nil, Engine.Localize(f13_local19))
			f13_local10.itemDescription = Engine.Localize(Engine.GetAttachmentDesc(f13_local17, f13_local18))
			f13_local10.itemCost = Engine.GetAttachmentAllocationCost(f13_local17, f13_local18)
			f13_local10.CAC = f13_local0
			f13_local10:registerEventHandler("button_over", CACWeaponSlot_ItemButtonOver)
			f13_local10:registerEventHandler("button_action", CACWeaponSlot_AttachmentButtonAction)
			local f13_local11 = RegisterMaterial(Engine.GetAttachmentImage(f13_local17, f13_local18))
			
			local itemImage = LUI.UIImage.new({
				left = 0,
				top = 0,
				right = 0,
				bottom = 0,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = true,
				bottomAnchor = true,
				material = f13_local11,
				alpha = 1
			})
			itemImage:registerAnimationState("disabled", {
				alpha = CoD.CAC.ButtonGridDisabledAlpha
			})
			f13_local10:addElement(itemImage)
			f13_local10.itemImage = itemImage
			
			f13_local10.itemMaterial = f13_local11
			local f13_local13 = 5
			local f13_local14 = LUI.UIImage.new({
				left = -CoD.CAC.ButtonGridLockImageSize - f13_local13,
				top = -CoD.CAC.ButtonGridLockImageSize - f13_local13,
				right = -f13_local13,
				bottom = -f13_local13,
				leftAnchor = false,
				topAnchor = false,
				rightAnchor = true,
				bottomAnchor = true,
				red = 1,
				green = 1,
				blue = 1,
				material = CoD.CAC.LockImageMaterial,
				alpha = 0
			})
			f13_local14:registerAnimationState("show", {
				alpha = 1
			})
			f13_local14:registerAnimationState("can_afford", {
				red = 1,
				green = 1,
				blue = 1
			})
			f13_local14:registerAnimationState("cannot_afford", {
				red = CoD.red.r,
				green = CoD.red.g,
				blue = CoD.red.b
			})
			f13_local10:addElement(f13_local14)
			f13_local10.lockImage = f13_local14
		end
	end
	return f13_local6
end

function CACWeaponSlot_AttachmentButtonAction(f14_arg0, f14_arg1)
	if f14_arg0.disabled == true then
		return 
	end
	local f14_local0 = f14_arg0.CAC
	local f14_local1 = f14_local0.m_ownerController
	local f14_local2 = CoD.perController[f14_local1].classNumInternal
	local f14_local3 = f14_arg0.attachmentIndex
	local f14_local4 = f14_arg0.loadoutSlot
	local f14_local5 = f14_local0:getPanel("ItemsGrid")
	local f14_local6 = f14_local0:getPanel("ItemInfo")
	local f14_local7 = f14_local0:getAllocationSubtitle()
	if f14_arg0.selected == true then
		CoD.SetClassItem(f14_local1, f14_local2, f14_local4, 0)
	else
		CoD.SetClassItem(f14_local1, f14_local2, f14_local4, f14_local3)
	end
	f14_local0:update()
	f14_local5:updateButtonGrid(f14_local7)
	f14_local6:update(f14_arg0)
	if f14_arg0.selected == true then
		f14_local7:setAllocationChange(f14_arg0.itemCost)
	else
		f14_local7:setAllocationChange(-f14_arg0.itemCost)
	end
	Engine.PlaySound(CoD.CAC.ButtonActionSound)
end

function CACWeaponSlot_CreateWeaponsGrid(f15_arg0, f15_arg1)
	local f15_local0 = f15_arg0.CAC
	local f15_local1 = CoD.ButtonGrid.new(3, {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}, 120, 80)
	f15_local1.maxSelections = 1
	f15_local1.weaponGroup = f15_arg1
	local f15_local2 = CoD.GetUnlockablesByGroupName(f15_arg1)
	table.sort(f15_local2, CoD.CACItemComparisonFunction)
	for f15_local6, f15_local7 in pairs(f15_local2) do
		local f15_local8 = f15_local1:addButton()
		f15_local8.itemIndex = f15_local7
		f15_local8.itemName = UIExpression.ToUpper(nil, Engine.Localize(UIExpression.GetItemName(nil, f15_local7)))
		f15_local8.itemDescription = Engine.Localize(UIExpression.GetItemDesc(nil, f15_local7))
		f15_local8.itemCost = UIExpression.GetItemAllocationCost(nil, f15_local7)
		f15_local8.CAC = f15_local0
		f15_local8:registerEventHandler("button_over", CACWeaponSlot_ItemButtonOver)
		f15_local8:registerEventHandler("button_action", CACWeaponSlot_WeaponButtonAction)
		local f15_local9 = UIExpression.GetItemImage(nil, f15_local7)
		local f15_local10 = RegisterMaterial(f15_local9)
		local f15_local11 = RegisterMaterial(f15_local9 .. "_big")
		local f15_local12 = LUI.UIImage.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true,
			material = f15_local10
		})
		f15_local12:registerAnimationState("disabled", {
			alpha = CoD.CAC.ButtonGridDisabledAlpha
		})
		f15_local8:addElement(f15_local12)
		local f15_local13 = 5
		local f15_local14 = LUI.UIText.new({
			left = -f15_local13,
			top = -CoD.textSize.Condensed - f15_local13,
			right = -f15_local13,
			bottom = -f15_local13,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true,
			red = 0,
			green = 0,
			blue = 0,
			alpha = CoD.textAlpha,
			font = CoD.fonts.Condensed
		})
		f15_local8:addElement(f15_local14)
		f15_local8.itemImage = f15_local12
		f15_local8.itemMaterial = f15_local10
		f15_local8.itemMaterialBig = f15_local11
		f15_local8.slotLabel = f15_local14
		local f15_local15 = 5
		local f15_local16 = LUI.UIImage.new({
			left = -CoD.CAC.ButtonGridLockImageSize - f15_local15,
			top = -CoD.CAC.ButtonGridLockImageSize - f15_local15,
			right = -f15_local15,
			bottom = -f15_local15,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true,
			red = 1,
			green = 1,
			blue = 1,
			material = CoD.CAC.LockImageMaterial,
			alpha = 0
		})
		f15_local16:registerAnimationState("show", {
			alpha = 1
		})
		f15_local16:registerAnimationState("can_afford", {
			red = CoD.green.r,
			green = CoD.green.g,
			blue = CoD.green.b
		})
		f15_local16:registerAnimationState("cannot_afford", {
			red = 1,
			green = 1,
			blue = 1
		})
		f15_local8:addElement(f15_local16)
		f15_local8.lockImage = f15_local16
	end
	CoD.CAC.AddUnlockTokenText(f15_local1, f15_arg1, true, false, 150)
	return f15_local1
end

function CACWeaponSlot_ItemButtonOver(f16_arg0, f16_arg1)
	LUI.UIButton.Over(f16_arg0, f16_arg1)
	local f16_local0 = f16_arg0.CAC
	local f16_local1 = f16_local0:getPanel("ItemInfo")
	local f16_local2 = f16_local0:getPanel("Allocation")
	if f16_local1 ~= nil then
		f16_local1:update(f16_arg0)
	end
	if f16_local2 ~= nil and f16_local2.allocationSubtitle ~= nil then
		if f16_arg0.selected == true then
			f16_local2.allocationSubtitle:setAllocationChange(f16_arg0.itemCost)
		else
			f16_local2.allocationSubtitle:setAllocationChange(-f16_arg0.itemCost)
		end
	end
	local f16_local3 = f16_local0:getPanel("WeaponAttributes")
	if f16_arg0.itemIndex ~= nil and CoD.IsWeapon(f16_arg0.itemIndex) then
		f16_local3:updateWeaponAttribute(f16_arg0.itemIndex)
	elseif f16_arg0.attachmentIndex ~= nil then
		local f16_local4 = f16_local0.m_ownerController
		f16_local3:updateWeaponAttribute(CoD.GetClassItem(f16_local4, CoD.perController[f16_local4].classNumInternal, CoD.perController[f16_local4].weaponSlot), f16_arg0.attachmentIndex)
	end
	Engine.PlaySound("uin_navigation_click")
end

function CACWeaponSlot_WeaponButtonAction(f17_arg0, f17_arg1)
	if f17_arg0.disabled == true then
		return 
	end
	local f17_local0 = f17_arg1.controller
	local f17_local1 = CoD.perController[f17_local0].classNumInternal
	local f17_local2 = CoD.perController[f17_local0].weaponSlot
	local f17_local3 = f17_arg0.itemIndex
	CoD.CAC.PurchaseItemIfPossible(f17_arg0.CAC, f17_local0, f17_arg0)
	if UIExpression.IsItemPurchased(f17_local0, f17_local3) ~= 0 then
		Engine.SetClassItem(f17_local0, f17_local1, f17_local2, f17_local3)
		local f17_local4 = f17_arg0.CAC
		f17_local4:update()
		f17_local4:closePanel("ItemInfo")
		f17_local4:closePanel("ItemsGrid")
		f17_local4:closePanel("WeaponAttributes")
		f17_local4:openClassPreview()
		f17_local4:openPanel("LoadOutSelection")
		f17_local4:registerEventHandler("button_prompt_back", CACLoadOut_LoadOutBack)
	end
end

CoD.CAC.createPanel.ItemInfo = function (f18_arg0)
	local f18_local0 = -30
	local f18_local1 = 22
	local f18_local2 = 400
	local f18_local3 = 400
	local f18_local4 = f18_local0 - f18_local2
	local f18_local5 = f18_local1 + f18_local3
	local f18_local6 = {
		left = 0,
		top = f18_local1,
		right = f18_local2,
		bottom = f18_local1 + f18_local3,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}
	local f18_local7 = {
		left = f18_local4,
		top = f18_local1,
		right = f18_local0,
		bottom = f18_local5,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}
	local f18_local8 = CoD.MFSlidePanel.new(f18_local6)
	f18_local8:registerAnimationState("primary", f18_local7)
	local f18_local9 = CoD.textSize.Big
	local f18_local10 = CoD.fonts.Big
	local f18_local11 = 0
	local f18_local12 = f18_local11 + f18_local9
	
	local nameText = LUI.UIText.new({
		left = 0,
		top = f18_local11,
		right = 0,
		bottom = f18_local12,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		font = f18_local10
	})
	f18_local8:addElement(nameText)
	f18_local8.nameText = nameText
	
	local f18_local14 = CoD.textSize.Condensed
	local f18_local15 = CoD.fonts.Condensed
	local f18_local16 = f18_local12
	local f18_local17 = f18_local16 + f18_local14
	
	local statusText = LUI.UIText.new({
		left = 0,
		top = f18_local16,
		right = 0,
		bottom = f18_local17,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		font = f18_local15
	})
	statusText:registerAnimationState("can_afford", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.3
	})
	statusText:registerAnimationState("cannot_afford", {
		red = CoD.red.r,
		green = CoD.red.g,
		blue = CoD.red.b,
		alpha = 1
	})
	statusText:animateToState("cannot_afford")
	f18_local8:addElement(statusText)
	f18_local8.statusText = statusText
	
	local f18_local19 = 2
	local f18_local20 = 180
	local f18_local21 = f18_local20 * f18_local19
	local f18_local22 = f18_local17
	local f18_local23 = f18_local22 + f18_local20
	
	local imageContainer = LUI.UIElement.new({
		left = -f18_local20,
		top = f18_local22,
		right = 0,
		bottom = f18_local23,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	imageContainer:registerAnimationState("weapon_state", {
		left = -f18_local21,
		top = f18_local22,
		right = 0,
		bottom = f18_local23,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f18_local8:addElement(imageContainer)
	f18_local8.imageContainer = imageContainer
	
	local itemImage = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	imageContainer:addElement(itemImage)
	f18_local8.itemImage = itemImage
	
	local f18_local26 = 0
	
	local lockImage = LUI.UIImage.new({
		left = -80 - f18_local26,
		top = -80 - f18_local26,
		right = -f18_local26,
		bottom = -f18_local26,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = 1,
		green = 1,
		blue = 1,
		material = CoD.CAC.LockImageBigMaterial,
		alpha = 0
	})
	lockImage:registerAnimationState("show", {
		alpha = 1
	})
	lockImage:registerAnimationState("can_afford", {
		red = CoD.green.r,
		green = CoD.green.g,
		blue = CoD.green.b
	})
	lockImage:registerAnimationState("cannot_afford", {
		red = 1,
		green = 1,
		blue = 1
	})
	imageContainer:addElement(lockImage)
	f18_local8.lockImage = lockImage
	
	local f18_local28 = 0
	local f18_local29 = CoD.textSize.Condensed
	local f18_local30 = CoD.fonts.Condensed
	local f18_local31 = 0
	local f18_local32 = f18_local31 - f18_local29
	
	local costLabelText = LUI.UIText.new({
		left = -f18_local28,
		top = f18_local32,
		right = -f18_local28,
		bottom = f18_local31,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = 0,
		green = 0,
		blue = 0,
		font = f18_local30
	})
	costLabelText:registerAnimationState("can_afford", {
		red = CoD.green.r,
		green = CoD.green.g,
		blue = CoD.green.b
	})
	costLabelText:registerAnimationState("cannot_afford", {
		red = 0.5,
		green = 0.5,
		blue = 0.5
	})
	imageContainer:addElement(costLabelText)
	f18_local8.costLabelText = costLabelText
	
	local f18_local34 = CoD.textSize.Big
	local f18_local35 = CoD.fonts.Big
	local f18_local36 = f18_local32
	
	local costText = LUI.UIText.new({
		left = -f18_local28,
		top = f18_local36 - f18_local34,
		right = -f18_local28,
		bottom = f18_local36,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		font = f18_local35
	})
	costText:registerAnimationState("can_afford", {
		red = CoD.green.r,
		green = CoD.green.g,
		blue = CoD.green.b
	})
	costText:registerAnimationState("cannot_afford", {
		red = CoD.red.r,
		green = CoD.red.g,
		blue = CoD.red.b
	})
	imageContainer:addElement(costText)
	f18_local8.costText = costText
	
	local f18_local38 = 45
	local f18_local39 = 45
	local f18_local40 = 0
	f18_local8.attachmentImages = {}
	for f18_local41 = 1, CoD.CACUtility.maxAttachments, 1 do
		local itemDescText = LUI.UIImage.new({
			left = f18_local40,
			top = -f18_local39,
			right = f18_local40 + f18_local38,
			bottom = 0,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = true,
			alpha = 1
		})
		imageContainer:addElement(itemDescText)
		f18_local8.attachmentImages[f18_local41] = itemDescText
		f18_local40 = f18_local40 + f18_local38
	end
	local f18_local41 = CoD.textSize.Default
	local f18_local42 = CoD.fonts.Default
	local f18_local43 = f18_local23
	
	local itemDescText = LUI.UIText.new({
		left = 100,
		top = f18_local43,
		right = 0,
		bottom = f18_local43 + f18_local41,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		font = f18_local42,
		alignment = LUI.Alignment.Left
	})
	f18_local8:addElement(itemDescText)
	f18_local8.itemDescText = itemDescText
	
	f18_local8.update = CACWeaponSlot_ItemInfoUpdate
	f18_local8.CAC = f18_arg0
	return f18_local8
end

function CACWeaponSlot_ItemInfoUpdate(f19_arg0, f19_arg1)
	if f19_arg1 ~= nil then
		local f19_local0 = f19_arg0.CAC.m_ownerController
		local f19_local1 = CoD.CACUtility.GetClassData(f19_local0, CoD.perController[f19_local0].classNumInternal)
		local f19_local2 = CoD.perController[f19_local0].weaponSlot
		f19_arg0.nameText:setText(f19_arg1.itemName)
		f19_arg0.itemDescText:setText(f19_arg1.itemDescription)
		f19_arg0.costText:setText(CoD.separateNumberWithCommas(f19_arg1.itemCost))
		f19_arg0.costLabelText:setText("PTS")
		if f19_arg1.disabled == true then
			f19_arg0.costText:animateToState("cannot_afford")
			f19_arg0.costLabelText:animateToState("cannot_afford")
		else
			f19_arg0.costText:animateToState("can_afford")
			f19_arg0.costLabelText:animateToState("can_afford")
		end
		if f19_arg1.attachmentIndex == nil and UIExpression.IsItemPurchased(f19_local0, f19_arg1.itemIndex) ~= 1 then
			f19_arg0.lockImage:animateToState("show")
			f19_arg0.costText:setText("")
			f19_arg0.costLabelText:setText("")
			f19_arg0.statusText:animateToState("can_afford")
			f19_arg0.statusText:setText(Engine.Localize("MPUI_LOCKED_CAPS"))
			if CoD.CAC.CanAffordUnlocksForItemIndex(f19_local0, f19_arg1.itemIndex) ~= true then
				f19_arg0.lockImage:animateToState("cannot_afford")
			else
				f19_arg0.lockImage:animateToState("can_afford")
			end
		elseif f19_arg1.attachmentIndex ~= nil and Engine.GetItemAttachmentLocked(f19_local0, f19_arg1.weaponIndex, f19_arg1.attachmentIndex) ~= 0 then
			f19_arg0.lockImage:animateToState("show")
			f19_arg0.lockImage:animateToState("cannot_afford")
			f19_arg0.statusText:setText(Engine.GetItemAttachmentXP(f19_arg1.weaponIndex, f19_arg1.attachmentIndex) - UIExpression.GetDStat(f19_local0, "itemstats", f19_arg1.weaponIndex, "xp") .. " XP")
			f19_arg0.statusText:animateToState("cannot_afford")
			f19_arg0.costText:setText("")
			f19_arg0.costLabelText:setText("")
		else
			f19_arg0.lockImage:animateToState("default")
			f19_arg0.statusText:setText(Engine.Localize(""))
			if f19_arg1.equipped ~= nil then
				f19_arg0.statusText:animateToState("can_afford")
				f19_arg0.statusText:setText(Engine.Localize("MPUI_EQUIPPED_CAPS") .. " " .. f19_arg1.equipped)
			elseif f19_arg1.cannotAfford ~= nil and f19_arg1.selected == nil then
				f19_arg0.statusText:animateToState("cannot_afford")
				f19_arg0.statusText:setText("Not Enough Points")
			elseif f19_arg1.attachmentIndex ~= nil and f19_arg1.slotOccupied == true and f19_arg1.selected == nil then
				f19_arg0.statusText:animateToState("can_afford")
				f19_arg0.statusText:setText("Mod Slot Occupied")
			end
		end
		local f19_local3 = f19_arg0.imageContainer
		local f19_local4 = f19_arg0.itemImage
		if f19_local4 ~= nil then
			if f19_arg1.attachmentIndex ~= nil then
				f19_local4:registerAnimationState("material_change", {
					material = RegisterMaterial(UIExpression.GetItemImage(nil, CoD.GetClassItem(f19_local0, CoD.perController[f19_local0].classNumInternal, f19_local2)) .. "_big"),
					alpha = 1
				})
				f19_local4:animateToState("material_change")
				f19_local3:animateToState("weapon_state")
			else
				if f19_arg1.itemMaterialBig ~= nil then
					f19_local4:registerAnimationState("material_change", {
						material = f19_arg1.itemMaterialBig,
						alpha = 1
					})
				else
					f19_local4:registerAnimationState("material_change", {
						material = f19_arg1.itemMaterial,
						alpha = 1
					})
				end
				f19_local4:animateToState("material_change")
				if f19_arg1.itemIndex ~= nil and CoD.IsWeapon(f19_arg1.itemIndex) then
					f19_local3:animateToState("weapon_state")
				else
					f19_local3:animateToState("default")
				end
			end
		end
		for f19_local8, f19_local9 in pairs(f19_arg0.attachmentImages) do
			f19_local9:registerAnimationState("material_change", {
				material = nil,
				alpha = 0
			})
			f19_local9:animateToState("material_change")
		end
		if f19_arg1.attachmentIndex ~= nil then
			for f19_local8, f19_local9 in pairs(f19_local1[f19_local2 .. "Attachments"]) do
				local f19_local10 = f19_arg0.attachmentImages[f19_local8]
				f19_local10:registerAnimationState("material_change", {
					material = f19_local9.material,
					alpha = 1
				})
				f19_local10:animateToState("material_change")
			end
		end
	end
end

CoD.CAC.createPanel.WeaponAttributes = function (f20_arg0)
	local f20_local0 = -30
	local f20_local1 = 400
	local f20_local2 = 370
	local f20_local3 = 150
	local f20_local4 = f20_local0 - f20_local2
	local f20_local5 = f20_local1 + f20_local3
	local f20_local6 = {
		left = 0,
		top = f20_local1,
		right = f20_local2,
		bottom = f20_local1 + f20_local3,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}
	local f20_local7 = {
		left = f20_local4,
		top = f20_local1,
		right = f20_local0,
		bottom = f20_local5,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}
	local f20_local8 = CoD.MFSlidePanel.new(f20_local6)
	f20_local8:registerAnimationState("primary", f20_local7)
	local f20_local9 = CoD.AttributeBarList.new(300, {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	f20_local8.attributeBarList = f20_local9
	f20_local8:addElement(f20_local9)
	f20_local9:addAttributeBar("damage", Engine.Localize("MPUI_DAMAGE_CAPS"), 0, 100)
	f20_local9:addAttributeBar("range", Engine.Localize("MPUI_RANGE_CAPS"), 0, 100)
	f20_local9:addAttributeBar("accuracy", Engine.Localize("MPUI_ACCURACY_CAPS"), 0, 100)
	f20_local9:addAttributeBar("mobility", Engine.Localize("MPUI_MOBILITY_CAPS"), 0, 100)
	f20_local9:addAttributeBar("fire_rate", Engine.Localize("MPUI_FIRE_RATE_CAPS"), 0, 100)
	f20_local8.updateWeaponAttribute = CACWeaponSlot_UpdateWeaponAttributes
	f20_local8.CAC = f20_arg0
	return f20_local8
end

function CACWeaponSlot_UpdateWeaponAttributes(f21_arg0, f21_arg1, f21_arg2)
	local f21_local0 = 3
	local f21_local1 = 4
	local f21_local2 = 2
	local f21_local3 = 6
	local f21_local4 = 5
	local f21_local5 = "mp/attributesTable.csv"
	local f21_local6 = UIExpression.GetItemRef(nil, f21_arg1)
	local f21_local7 = tonumber(UIExpression.TableLookup(nil, f21_local5, 1, f21_local6, f21_local0))
	local f21_local8 = tonumber(UIExpression.TableLookup(nil, f21_local5, 1, f21_local6, f21_local1))
	local f21_local9 = tonumber(UIExpression.TableLookup(nil, f21_local5, 1, f21_local6, f21_local2))
	local f21_local10 = tonumber(UIExpression.TableLookup(nil, f21_local5, 1, f21_local6, f21_local3))
	local f21_local11 = tonumber(UIExpression.TableLookup(nil, f21_local5, 1, f21_local6, f21_local4))
	local f21_local12 = f21_arg0.attributeBarList
	local f21_local13 = 250
	f21_local12:changeBarValue("damage", f21_local7, f21_local13)
	f21_local12:changeBarValue("range", f21_local8, f21_local13)
	f21_local12:changeBarValue("accuracy", f21_local9, f21_local13)
	f21_local12:changeBarValue("mobility", f21_local10, f21_local13)
	f21_local12:changeBarValue("fire_rate", f21_local11, f21_local13)
	if f21_arg2 ~= nil then
		local f21_local14 = Engine.GetAttachmentRef(f21_arg1, f21_arg2)
		local f21_local15 = tonumber(UIExpression.TableLookup(nil, f21_local5, 1, f21_local14, 9, f21_local6, f21_local0))
		local f21_local16 = tonumber(UIExpression.TableLookup(nil, f21_local5, 1, f21_local14, 9, f21_local6, f21_local1))
		local f21_local17 = tonumber(UIExpression.TableLookup(nil, f21_local5, 1, f21_local14, 9, f21_local6, f21_local2))
		local f21_local18 = tonumber(UIExpression.TableLookup(nil, f21_local5, 1, f21_local14, 9, f21_local6, f21_local3))
		local f21_local19 = tonumber(UIExpression.TableLookup(nil, f21_local5, 1, f21_local14, 9, f21_local6, f21_local4))
		f21_local12:showModifiedValue("damage", f21_local15)
		f21_local12:showModifiedValue("range", f21_local16)
		f21_local12:showModifiedValue("accuracy", f21_local17)
		f21_local12:showModifiedValue("mobility", f21_local18)
		f21_local12:showModifiedValue("fire_rate", f21_local19)
	else
		f21_local12:showModifiedValue("damage", 0)
		f21_local12:showModifiedValue("range", 0)
		f21_local12:showModifiedValue("accuracy", 0)
		f21_local12:showModifiedValue("mobility", 0)
		f21_local12:showModifiedValue("fire_rate", 0)
	end
end

