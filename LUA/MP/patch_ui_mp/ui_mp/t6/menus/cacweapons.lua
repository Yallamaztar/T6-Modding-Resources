require("T6.CACGridSelectionMenu")
local f0_local0, f0_local1, f0_local2, f0_local3, f0_local4, f0_local5 = nil
LUI.createMenu.CACWeapons = function ()
	local f1_local0 = CoD.CACGridSelectionMenu.new()
	f1_local0.addGridElements = f0_local1
	f1_local0.updateUIFromClassData = f0_local3
	f1_local0:registerEventHandler("add_slide_elements", f0_local0)
	f1_local0:registerEventHandler("edit_attachments", f0_local2)
	return f1_local0
end

f0_local0 = function (f2_arg0, f2_arg1)
	local f2_local0 = CoD.perController[f2_arg0.m_ownerController].weaponSlot
	CoD.CACGridSelectionMenu.AddSlideElements(f2_arg0, f2_arg1)
	local f2_local1 = CoD.ButtonPrompt.new
	local f2_local2 = "alt1"
	local f2_local3 = Engine.Localize("MPUI_EDIT_MODS_CAPS")
	local f2_local4 = f2_arg0
	local f2_local5 = "edit_attachments"
	local f2_local6, f2_local7 = false
	local f2_local8, f2_local9 = false
	f2_local1 = f2_local1(f2_local2, f2_local3, f2_local4, f2_local5, f2_local6, f2_local7, f2_local8, f2_local9, "M")
	f2_local2 = f2_arg0.body
	f2_local2.attachmentsPrompt = f2_local1
	f2_local2.contextualPrompt = f2_local1
	f2_local2.contextualCheck = f0_local5
end

f0_local1 = function (f3_arg0)
	local f3_local0 = f3_arg0.body.buttonGrid
	f3_local0.aspectRatio = 2
	local f3_local1 = CoD.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames.primaryWeapon)
	LUI.ConcatenateToTable(f3_local1, CoD.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames.secondaryWeapon))
	table.sort(f3_local1, CoD.CACItemComparisonFunction)
	CoD.CACGridSelectionMenu.AddItemsToButtonGrid(f3_arg0, f3_local1)
	f3_local0.maxSelections = 1
end

f0_local3 = function (f4_arg0)
	CoD.CACGridSelectionMenu.UpdateUIFromClassData(f4_arg0)
	local f4_local0 = f4_arg0.frame.allocationSubtitle
	local f4_local1 = f4_arg0.body.classData
	local f4_local2 = f4_arg0.m_ownerController
	local f4_local3 = CoD.perController[f4_local2]
	local f4_local4 = f4_local3.weaponSlot
	local f4_local5 = f4_local3.classNumInternal
	local f4_local6 = f4_arg0.body.buttonGrid
	local f4_local7 = f4_local6.buttons
	local f4_local8 = 0
	for f4_local14, f4_local15 in pairs(f4_local7) do
		local f4_local16 = CoD.CACGridSelectionMenu.ItemButton_GetQuantity(f4_local15)
		local f4_local12 = true
		if f4_local15.attachmentIndex ~= nil and CoD.GetClassItem(f4_local2, f4_local5, f4_local15.loadoutSlot) ~= 0 then
			f4_local12 = false
		end
		if f4_local16 == 0 and f4_local0:canAfford(f4_local15.itemCost) == true and f4_local12 == true then
			f4_local15.image:animateToState("selectable")
			f4_local15.selectable = true
		else
			f4_local15.image:animateToState("default")
			f4_local15.selectable = nil
		end
		local f4_local13 = nil
		if f4_local15.attachmentIndex ~= nil then
			f4_local13 = f4_local16 > 0
		else
			f4_local13 = CoD.GetClassItem(f4_local2, f4_local5, f4_local4) == f4_local15.itemIndex
		end
		if f4_local13 == true then
			f4_local8 = f4_local8 + 1
			f4_local15.image:animateToState("selectable")
			f4_local15.background:animateToState("selected")
			if #f4_local15.quantityChoices > 1 then
				f4_local15.quantityLabel:setText(Engine.Localize("MENU_MULTIPLIER_X", f4_local16))
			end
			f4_local15.selectable = true
		else
			f4_local15.background:animateToState("default")
			f4_local15.quantityLabel:setText("")
		end
		CoD.CACGridSelectionMenu.ItemButton_UpdateSelectionPreview(f4_local15)
	end
	f4_local9 = f4_local6.maxSelections
	if f4_local9 ~= nil and f4_local9 <= f4_local8 then
		for f4_local15, f4_local16 in pairs(f4_local7) do
			if CoD.CACGridSelectionMenu.ItemButton_GetQuantity(f4_local16) == 0 then
				f4_local16.image:animateToState("default")
				f4_local16.selectable = nil
			end
		end
	end
end

f0_local2 = function (f5_arg0)
	local f5_local0 = f5_arg0.m_ownerController
	local f5_local1 = CoD.perController[f5_local0]
	local f5_local2 = CoD.GetAttachments(CoD.GetClassItem(f5_local0, f5_local1.classNumInternal, f5_local1.weaponSlot))
	if f5_local2 == nil then
		return 
	end
	local f5_local3 = f5_arg0.buttonGridItemsWide
	local f5_local4 = f5_local3 * CoD.ButtonGrid.ItemSize + (f5_local3 - 1) * CoD.ButtonGrid.Spacing
	local f5_local5 = f5_arg0.buttonGridBorder
	local f5_local6 = CoD.ButtonGrid.new(f5_local3, {
		left = f5_local5,
		top = CoD.frameSubtitleHeight + f5_local5,
		right = f5_local5 + f5_local4,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		alphaMultiplier = 1
	})
	local f5_local7 = f5_arg0.body
	f5_local7.attachmentsGrid = f5_local6
	table.sort(f5_local2, CoD.CACAttachmentComparisonFunction)
	CoD.CACGridSelectionMenu.AddAttachmentsToButtonGrid(f5_arg0, f5_local2, f5_local6)
	f5_local6.maxSelections = 2
	f5_local7.weaponGrid = f5_local7.buttonGrid
	local f5_local8, f5_local9 = f5_local7.weaponGrid:animateOut()
	f5_local7.buttonGrid = f5_local6
	f5_local7:addElement(f5_local6)
	f5_local6:animateIn(f5_local8, f5_local9)
	f5_local7.contextualPrompt:close()
	f5_local7.contextualPrompt = nil
	f5_arg0:registerEventHandler("button_prompt_back", f0_local4)
	if CoD.useController then
		local f5_local10 = f5_local7.buttonGrid.buttons[1]
		if f5_local10 ~= nil then
			f5_local10:processEvent({
				name = "gain_focus"
			})
		end
	end
	f5_arg0:updateUIFromClassData()
end

f0_local4 = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0.body
	local f6_local1, f6_local2 = f6_local0.attachmentsGrid:animateOut()
	f6_local0.attachmentsGrid = nil
	f6_local0.buttonGrid = f6_local0.weaponGrid
	f6_local0:addElement(f6_local0.weaponGrid)
	f6_local0.weaponGrid:animateIn(f6_local1, f6_local2)
	f6_local0.contextualPrompt = f6_local0.attachmentsPrompt
	f6_arg0:registerEventHandler("button_prompt_back", CoD.MFSlide.buttonPromptBack)
	f6_arg0:updateUIFromClassData()
end

f0_local5 = function (f7_arg0)
	local f7_local0 = CoD.GetAttachments(f7_arg0.itemIndex)
	if f7_local0 == nil or #f7_local0 == 0 then
		return false
	else
		return true
	end
end

