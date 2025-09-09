require("T6.MFSlide")
require("T6.MFSlidePanel")
require("T6.CoD9Button")
CoD.CAC.createPanel.LoadOutSelection = function (f1_arg0)
	local f1_local0 = 30
	local f1_local1 = 30
	local f1_local2 = 350
	local f1_local3 = 200
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
	f1_local6.id = "MFSlidePanel.LoadOutButtonPane"
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
	f1_local6.buttonList.hintText:close()
	f1_local6.buttonList.id = "ButtonList.LoadoutButtonList"
	f1_local6:addElement(f1_local6.buttonList)
	f1_local6.buttons = {}
	local f1_local7 = Engine.Localize("MPUI_PRIMARY_WEAPON_CAPS")
	local f1_local8 = f1_local6.buttonList:addButton(f1_local7)
	f1_local8:registerEventHandler("button_action", CACLoadOut_WeaponButtonAction)
	f1_local8:registerEventHandler("button_prompt_clear", CACLoadOut_WeaponClear)
	f1_local8:registerEventHandler("edit_attachments", CACLoadOut_EditAttachments)
	f1_local8.weaponSlot = CoD.CACUtility.loadoutSlotNames.primaryWeapon
	f1_local8.label = f1_local7
	f1_local8.paneName = "PrimaryWeapon"
	f1_local8.id = "CoD9Button.PrimaryWeapon"
	f1_local6.buttons.primary = f1_local8
	local f1_local9 = Engine.Localize("MPUI_SECONDARY_WEAPON_CAPS")
	local f1_local10 = f1_local6.buttonList:addButton(f1_local9)
	f1_local10:registerEventHandler("button_action", CACLoadOut_WeaponButtonAction)
	f1_local10:registerEventHandler("button_prompt_clear", CACLoadOut_WeaponClear)
	f1_local10:registerEventHandler("edit_attachments", CACLoadOut_EditAttachments)
	f1_local10.weaponSlot = CoD.CACUtility.loadoutSlotNames.secondaryWeapon
	f1_local10.label = f1_local9
	f1_local10.paneName = "SecondaryWeapon"
	f1_local10.id = "CoD9Button.SecondaryWeapon"
	f1_local6.buttons.secondary = f1_local10
	local f1_local11 = Engine.Localize("MPUI_GRENADES_AND_EQUIPMENT_CAPS")
	local f1_local12 = f1_local6.buttonList:addButton(f1_local11)
	f1_local12:registerEventHandler("button_action", CACLoadOut_GrenadesButtonAction)
	f1_local12:registerEventHandler("button_prompt_clear", CACLoadOut_GrenadesClear)
	f1_local12.label = f1_local11
	f1_local12.paneName = "Grenades"
	f1_local12.id = "CoD9Button.Grenades"
	f1_local6.buttons.grenades = f1_local12
	local f1_local13 = UIExpression.ToUpper(nil, Engine.Localize("MPUI_PERKS"))
	local f1_local14 = f1_local6.buttonList:addButton(f1_local13)
	f1_local14:registerEventHandler("button_action", CACLoadOut_PerksButtonAction)
	f1_local14:registerEventHandler("button_prompt_clear", CACLoadOut_PerksClear)
	f1_local14.label = f1_local13
	f1_local14.paneName = "Perks"
	f1_local14.id = "CoD9Button.Perks"
	f1_local6.buttons.perks = f1_local14
	for f1_local18, f1_local19 in pairs(f1_local6.buttons) do
		f1_local19:registerEventHandler("button_over", CACLoadOut_LoadOutButtonOver)
		f1_local19.CAC = f1_arg0
	end
	f1_local6:registerEventHandler("on_activate", CACLoadOut_LoadOutOnActivate)
	f1_local6:registerEventHandler("on_deactivate", CACLoadOut_LoadOutOnDeactivate)
	f1_local6.CAC = f1_arg0
	return f1_local6
end

function CACLoadOut_LoadOutOnActivate(f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.buttons.primary
	if f2_arg0.clearButtonPrompt == nil then
		f2_arg0.clearButtonPrompt = CoD.ButtonPrompt.new("select", Engine.Localize("MPUI_CLEAR"), f2_arg0, "button_prompt_clear")
		f2_arg0.clearButtonPrompt:setPriority(100)
		f2_arg0.CAC.body.leftBottomButtonBar:addElement(f2_arg0.clearButtonPrompt)
	end
	f2_arg0.CAC:update()
	f2_local0:processEvent({
		name = "gain_focus"
	})
end

function CACLoadOut_LoadOutOnDeactivate(f3_arg0, f3_arg1)
	if f3_arg0.clearButtonPrompt ~= nil then
		f3_arg0.clearButtonPrompt:close()
		f3_arg0.clearButtonPrompt = nil
	end
end

local f0_local0 = function (f4_arg0, f4_arg1)
	if f4_arg0 ~= nil and f4_arg1 ~= nil then
		if f4_arg1.modsPrompts[f4_arg0] ~= nil and f4_arg1.modsPrompts[f4_arg0].prompt ~= nil then
			f4_arg1.modsPrompts[f4_arg0].prompt:close()
			f4_arg1.modsPrompts[f4_arg0].prompt = nil
		end
		if f4_arg1.customizePrompts[f4_arg0] ~= nil and f4_arg1.customizePrompts[f4_arg0].prompt ~= nil then
			f4_arg1.customizePrompts[f4_arg0].prompt:close()
			f4_arg1.customizePrompts[f4_arg0].prompt = nil
		end
	end
end

function CACLoadOut_LoadOutBack(f5_arg0, f5_arg1)
	f5_arg0:closePanel("LoadOutSelection")
	f5_arg0:openPanel("ClassSelection")
	local f5_local0 = f5_arg0:getPanel("LoadOutSelection")
	local f5_local1 = f5_local0.buttonList:getFirstChild()
	while f5_local1 do
		local f5_local2 = f5_arg0:getPanel(f5_local1.paneName)
		if f5_local2 ~= nil then
			f5_local2:animateToState("primary", 300)
		end
		f0_local0(f5_local1.weaponSlot, f5_arg0.body.classItems)
		f5_local1 = f5_local1:getNextSibling()
	end
	f5_arg0:fadeInTitle(Engine.Localize("MENU_CREATE_A_CLASS_CAPS"))
	f5_arg0:registerEventHandler("button_prompt_back", CAC_ButtonPromptBack)
end

function CACLoadOut_LoadOutButtonOver(f6_arg0, f6_arg1)
	LUI.UIButton.Over(f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0.CAC
	local f6_local1 = f6_local0:getPanel("LoadOutSelection")
	local f6_local2 = f6_local0.m_ownerController
	local f6_local3 = CoD.perController[f6_local2].classNumInternal
	CoD.perController[f6_local2].weaponSlot = f6_arg0.weaponSlot
	local f6_local4 = f6_local1.clearButtonPrompt
	if f6_local4 ~= nil then
		f6_local4.label:setText(Engine.Localize("MPUI_CLEAR") .. " " .. f6_arg0.label)
	end
	local f6_local5 = CoD.ButtonPrompt.new
	local f6_local6 = "alt1"
	local f6_local7 = Engine.Localize("MENU_MODS_CAPS")
	local f6_local8 = f6_arg0
	local f6_local9 = "edit_attachments"
	local f6_local10, f6_local11 = false
	local f6_local12, f6_local13 = false
	f6_local5 = f6_local5(f6_local6, f6_local7, f6_local8, f6_local9, f6_local10, f6_local11, f6_local12, f6_local13, "M")
	f6_local6 = CoD.ButtonPrompt.new
	f6_local7 = "alt2"
	f6_local8 = Engine.Localize("MENU_CUSTOMIZE_CAPS")
	f6_local9 = f6_arg0
	f6_local10, f6_local11 = false
	f6_local12, f6_local13 = false
	f6_local6 = f6_local6(f6_local7, f6_local8, f6_local9, f6_local10, f6_local11, f6_local12, f6_local13, "C")
	f6_local7 = f6_local1.buttonList:getFirstChild()
	while f6_local7 do
		f6_local8 = f6_local0:getPanel(f6_local7.paneName)
		if f6_local8 ~= nil then
			if f6_arg0.paneName == f6_local7.paneName then
				f6_local8:animateToState("selected", 300)
				if f6_local7.weaponSlot ~= nil then
					if f6_local0.body.classItems.modsPrompts[f6_local7.weaponSlot] ~= nil and CoD.IsWeaponSlotEquippedAndModifiable(f6_local2, f6_local3, f6_local7.weaponSlot) and f6_local0.body.classItems.modsPrompts[f6_local7.weaponSlot].prompt == nil then
						f6_local0.body.classItems.modsPrompts[f6_local7.weaponSlot].prompt = f6_local5
						f6_local0.body.classItems.modsPrompts[f6_local7.weaponSlot]:addElement(f6_local5)
					end
					if f6_local0.body.classItems.customizePrompts[f6_local7.weaponSlot] ~= nil and f6_local0.body.classItems.customizePrompts[f6_local7.weaponSlot].prompt == nil then
						f6_local0.body.classItems.customizePrompts[f6_local7.weaponSlot].prompt = f6_local6
						f6_local0.body.classItems.customizePrompts[f6_local7.weaponSlot]:addElement(f6_local6)
					end
				end
			else
				f6_local8:animateToState("not_selected", 300)
				f0_local0(f6_local7.weaponSlot, f6_local0.body.classItems)
			end
		end
		f6_local7 = f6_local7:getNextSibling()
	end
end

function CACLoadOut_WeaponClear(f7_arg0, f7_arg1)
	if f7_arg0:isInFocus() then
		local f7_local0 = f7_arg0.CAC
		local f7_local1 = f7_arg1.controller
		CoD.SetClassItem(f7_local1, CoD.perController[f7_local1].classNumInternal, f7_arg0.weaponSlot, 0)
		f7_arg0:processEvent({
			name = "button_over"
		})
		f7_local0:update()
		Engine.PlaySound(CoD.CAC.ButtonActionSound)
	end
end

function CACLoadOut_GrenadesClear(f8_arg0, f8_arg1)
	if f8_arg0:isInFocus() then
		local f8_local0 = f8_arg0.CAC
		local f8_local1 = f8_arg1.controller
		local f8_local2 = CoD.perController[f8_local1].classNumInternal
		CoD.SetClassItem(f8_local1, f8_local2, CoD.CACUtility.loadoutSlotNames.primaryGrenade, 0)
		CoD.SetClassItem(f8_local1, f8_local2, CoD.CACUtility.loadoutSlotNames.specialGrenade, 0)
		f8_local0:update()
		Engine.PlaySound(CoD.CAC.ButtonActionSound)
	end
end

function CACLoadOut_PerksClear(f9_arg0, f9_arg1)
	if f9_arg0:isInFocus() then
		local f9_local0 = f9_arg0.CAC
		local f9_local1 = f9_arg1.controller
		local f9_local2 = CoD.perController[f9_local1].classNumInternal
		for f9_local3 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
			CoD.SetClassItem(f9_local1, f9_local2, "specialty" .. f9_local3, 0)
		end
		f9_local0:update()
		Engine.PlaySound(CoD.CAC.ButtonActionSound)
	end
end

function CACLoadOut_WeaponButtonAction(f10_arg0, f10_arg1)
	local f10_local0 = f10_arg0.CAC
	local f10_local1 = f10_arg1.controller
	local f10_local2 = CoD.perController[f10_local1].classNumInternal
	CoD.perController[f10_local1].weaponSlot = f10_arg0.weaponSlot
	local f10_local3 = CoD.CACUtility.GetClassData(f10_local1, f10_local2)
	local f10_local4 = CoD.SumClassItemCosts(f10_local3[f10_arg0.weaponSlot .. "Weapon"]) + CoD.SumClassItemCosts(f10_local3[f10_arg0.weaponSlot .. "Attachments"])
	local f10_local5 = f10_local0:getAllocationSubtitle()
	f10_local5:setAllocationChange(f10_local4)
	f10_local5:commitChange()
	f10_local0:openPanel("ItemsGrid", "default", 0)
	f10_local0:closeClassPreview()
	f10_local0:closePanel("LoadOutSelection")
	f10_local0:openPanel("ItemsGrid", "secondary")
	f10_local0:openPanel("WeaponTypeSelection")
	f10_local0:fadeInTitle(f10_arg0.label)
	f10_local0:registerEventHandler("button_prompt_back", CACWeaponSlot_WeaponTypeSelectionBack)
end

function CACLoadOut_EditAttachmentsBack(f11_arg0, f11_arg1)
	f11_arg0:openClassPreview()
	f11_arg0:openPanel("LoadOutSelection")
	f11_arg0:closePanel("ItemsGrid", "hidden_left")
	f11_arg0:closePanel("ItemInfo")
	f11_arg0:closePanel("WeaponAttributes")
	local f11_local0 = CoD.perController[f11_arg1.controller].classNumInternal
	local f11_local1 = f11_arg0
	local f11_local2 = f11_arg0.fadeInTitle
	local f11_local3 = CoD.CACUtility.GetLoadoutNameFromIndex(f11_arg1.controller, f11_local0)
	f11_local2(f11_local1, f11_local3:get())
	f11_arg0:registerEventHandler("button_prompt_back", CACLoadOut_LoadOutBack)
end

function CACLoadOut_EditAttachments(f12_arg0, f12_arg1)
	if f12_arg0:isInFocus() then
		local f12_local0 = f12_arg0.CAC
		CoD.perController[f12_local0.m_ownerController].weaponSlot = f12_arg0.weaponSlot
		f12_local0:closePanel("LoadOutSelection")
		f12_local0:closeClassPreview()
		f12_local0:createPanel("ItemInfo")
		local f12_local1 = f12_local0:createPanel("ItemsGrid")
		f12_local1:populate(f12_local1:createAttachmentsGrid())
		f12_local0:openPanel("WeaponAttributes")
		f12_local0:openPanel("ItemsGrid", "hidden_left", 0)
		f12_local0:openPanel("ItemsGrid")
		f12_local0:openPanel("ItemInfo")
		f12_local0:fadeInTitle(Engine.Localize("MPUI_EDIT_MODS_CAPS"))
		f12_local0:registerEventHandler("button_prompt_back", CACLoadOut_EditAttachmentsBack)
	end
end

function CACLoadOut_GrenadesBack(f13_arg0, f13_arg1)
	f13_arg0:closePanel("ItemsGrid", "hidden_left")
	f13_arg0:closePanel("ItemInfo")
	f13_arg0:openClassPreview()
	f13_arg0:openPanel("LoadOutSelection")
	local f13_local0 = f13_arg0:getPanel("Grenades")
	if f13_local0 ~= nil and f13_local0.swapButtonPrompt ~= nil then
		f13_local0.swapButtonPrompt:close()
		f13_local0.swapButtonPrompt = nil
	end
	f13_local0.shoulderLeftImage:animateToState("default")
	f13_local0.shoulderRightImage:animateToState("default")
	local f13_local1 = CoD.perController[f13_arg1.controller].classNumInternal
	local f13_local2 = f13_arg0
	local f13_local3 = f13_arg0.fadeInTitle
	local f13_local4 = CoD.CACUtility.GetLoadoutNameFromIndex(f13_arg1.controller, f13_local1)
	f13_local3(f13_local2, f13_local4:get())
	f13_arg0:registerEventHandler("button_prompt_back", CACLoadOut_LoadOutBack)
end

function CACLoadOut_GrenadesButtonAction(f14_arg0, f14_arg1)
	local f14_local0 = f14_arg0.CAC
	local f14_local1 = f14_local0:getAllocationSubtitle()
	f14_local0:closePanel("PrimaryWeapon")
	f14_local0:closePanel("SecondaryWeapon")
	f14_local0:closePanel("Perks")
	f14_local0:closePanel("LoadOutSelection")
	f14_local0:openPanel("ItemsGrid", "hidden_left", 0)
	f14_local0:createPanel("ItemInfo")
	local f14_local2 = f14_local0:getPanel("ItemsGrid")
	local f14_local3 = f14_local2.buttonGrid
	if f14_local3 == nil or f14_local3.typeName ~= "grenades" then
		f14_local2:populate(f14_local2:createGrenadesGrid())
	else
		f14_local2:updateButtonGrid(f14_local1)
	end
	local f14_local4 = f14_local0:getPanel("Grenades")
	if f14_local4 ~= nil and f14_local4.swapButtonPrompt == nil then
		local f14_local5 = CoD.ButtonPrompt.new
		local f14_local6 = "alt1"
		local f14_local7 = Engine.Localize("MENU_SWAP_CAPS")
		local f14_local8 = f14_local0
		local f14_local9 = "button_prompt_swap"
		local f14_local10, f14_local11 = false
		local f14_local12, f14_local13 = false
		f14_local4.swapButtonPrompt = f14_local5(f14_local6, f14_local7, f14_local8, f14_local9, f14_local10, f14_local11, f14_local12, f14_local13, "B")
		f14_local4.buttonPromptContainer:addElement(f14_local4.swapButtonPrompt)
	end
	f14_local4.shoulderLeftImage:animateToState("show")
	f14_local4.shoulderRightImage:animateToState("show")
	local f14_local5 = f14_local0.body.classItems
	f14_local5.grenadeLabel:animateToState("hide")
	f14_local5.itemLabelTabs.grenades:animateToState("hide")
	for f14_local6 = 1, CoD.CACUtility.maxGrenades, 1 do
		f14_local5.grenadeImageBGs[f14_local6]:animateToState("default")
	end
	f14_local0:openPanel("Grenades", "secondary")
	f14_local0:openPanel("ItemsGrid")
	f14_local0:openPanel("ItemInfo")
	f14_local4.m_inputDisabled = nil
	f14_local0:fadeInTitle(f14_arg0.label)
	f14_local0:registerEventHandler("button_prompt_back", CACLoadOut_GrenadesBack)
end

function CACLoadOut_PerksBack(f15_arg0, f15_arg1)
	f15_arg0:closePanel("ItemsGrid", "hidden_left")
	f15_arg0:closePanel("ItemInfo")
	f15_arg0:openClassPreview()
	f15_arg0:openPanel("LoadOutSelection")
	local f15_local0 = CoD.perController[f15_arg1.controller].classNumInternal
	local f15_local1 = f15_arg0
	local f15_local2 = f15_arg0.fadeInTitle
	local f15_local3 = CoD.CACUtility.GetLoadoutNameFromIndex(f15_arg1.controller, f15_local0)
	f15_local2(f15_local1, f15_local3:get())
	f15_arg0:registerEventHandler("button_prompt_back", CACLoadOut_LoadOutBack)
end

function CACLoadOut_PerksButtonAction(f16_arg0, f16_arg1)
	local f16_local0 = f16_arg0.CAC
	f16_local0:closePanel("PrimaryWeapon")
	f16_local0:closePanel("SecondaryWeapon")
	f16_local0:closePanel("Grenades")
	f16_local0:closePanel("LoadOutSelection")
	f16_local0:openPanel("ItemsGrid", "hidden_left", 0)
	f16_local0:createPanel("ItemInfo")
	local f16_local1 = f16_local0:getPanel("ItemsGrid")
	local f16_local2 = f16_local1.buttonGrid
	if f16_local2 == nil or f16_local2.typeName ~= "perks" then
		f16_local1:populate(f16_local1:createPerksGrid())
	end
	f16_local0:openPanel("ItemsGrid")
	f16_local0:openPanel("ItemInfo")
	f16_local0:fadeInTitle(f16_arg0.label)
	f16_local0:registerEventHandler("button_prompt_back", CACLoadOut_PerksBack)
end

CoD.CAC.createPanel.Allocation = function (f17_arg0)
	local f17_local0 = 12
	local f17_local1 = 816
	local f17_local2 = {
		left = 0,
		top = 0,
		right = 0,
		bottom = CoD.AllocationSubtitle.Height,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	}
	local f17_local3 = {
		left = 0,
		top = -CoD.AllocationSubtitle.Height,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	}
	local f17_local4 = CoD.MFSlidePanel.new(f17_local2)
	f17_local4:registerAnimationState("primary", f17_local3)
	f17_local4:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		material = RegisterMaterial("lui_overlay_combatload")
	}))
	local f17_local5 = CoD.AllocationSubtitle.new(f17_local1, {
		left = f17_local0,
		top = 30,
		right = -f17_local0,
		bottom = -f17_local0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	f17_local4:addElement(f17_local5)
	f17_local4:registerEventHandler("on_activate", CACLoadOut_AllocationOnActivate)
	f17_local4.update = CACLoadOut_UpdateAllocation
	f17_local4.allocationSubtitle = f17_local5
	f17_local4.CAC = f17_arg0
	return f17_local4
end

function CACLoadOut_AllocationOnActivate(f18_arg0, f18_arg1)
	f18_arg0:update()
end

function CACLoadOut_UpdateAllocation(f19_arg0)
	local f19_local0 = f19_arg0.CAC.m_ownerController
	local f19_local1 = CoD.CACUtility.GetClassData(f19_local0, CoD.perController[f19_local0].classNumInternal)
	f19_arg0.allocationSubtitle:setAllocationChange(nil)
	f19_arg0.allocationSubtitle:setRemainingAllocation(CoD.AllocationSubtitle.MaxAllocation - CoD.CACUtility.GetAllocationSpentFromClassData(f19_local1))
end

