CoD.CACSelectPerks = {}
CoD.CACSelectPerks.GridTop = 60
CoD.CACSelectPerks.GridColumns = 6
CoD.CACSelectPerks.GridItemSpacing = 12
CoD.CACSelectPerks.GridWidth = CoD.Menu.Width * 0.85
CoD.CACSelectPerks.GridItemWidth = (CoD.CACSelectPerks.GridWidth - CoD.CACSelectPerks.GridItemSpacing * (CoD.CACSelectPerks.GridColumns - 1)) / CoD.CACSelectPerks.GridColumns
CoD.CACSelectPerks.GridItemHeight = 120
CoD.CACSelectPerks.defaultAttachments = {}
LUI.createMenu.CACSelectPerks = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CACSelectPerks")
	f1_local0:addTitle(Engine.Localize("MENU_SELECT_PERKS_CAPS"), LUI.Alignment.Center)
	f1_local0:setOwner(f1_arg0)
	f1_local0.equippedItemIndices = {}
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	local f1_local1 = CoD.ButtonPrompt.new
	local f1_local2 = "alt2"
	local f1_local3 = Engine.Localize("SPUI_RESTORE_DEFAULTS")
	local Widget = f1_local0
	local f1_local5 = "button_restore_defaults"
	local Widget, f1_local7 = false
	local f1_local8, f1_local9 = false
	f1_local0.restoreDefaultsPrompt = f1_local1(f1_local2, f1_local3, Widget, f1_local5, Widget, f1_local7, f1_local8, f1_local9, "R")
	f1_local0:addLeftButtonPrompt(f1_local0.restoreDefaultsPrompt)
	f1_local0:registerEventHandler("content_button_highlighted", CoD.CACSelectPerks.ContentButtonHighlighted)
	f1_local0:registerEventHandler("content_button_selected", CoD.CACSelectPerks.ContentButtonSelected)
	f1_local0:registerEventHandler("equip", CoD.CACSelectPerks.Equip)
	f1_local0:registerEventHandler("button_restore_defaults", CoD.CACSelectPerks.RestoreDefaults)
	f1_local0:registerEventHandler("deselect_button", CoD.CACSelectPerks.DeselectButton)
	f1_local0:registerEventHandler("select_button", CoD.CACSelectPerks.SelectButton)
	f1_local0:registerEventHandler("button_prompt_back", CoD.CACSelectPerks.ButtonPromptBack)
	f1_local1 = CoD.CACSelectPerks.GridTop
	f1_local0.contentGrid = CoD.ContentGrid.new(CoD.CACSelectPerks.GridColumns, {
		leftAnchor = false,
		rightAnchor = false,
		left = -CoD.CACSelectPerks.GridWidth / 2,
		right = CoD.CACSelectPerks.GridWidth / 2,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local1,
		bottom = 0
	}, CoD.CACSelectPerks.GridItemWidth, CoD.CACSelectPerks.GridItemHeight, CoD.CACSelectPerks.GridItemSpacing)
	f1_local0:addElement(f1_local0.contentGrid)
	f1_local1 = f1_local1 + CoD.CACSelectPerks.GridItemHeight * 3 + CoD.ContentGrid.Spacing * 2 + 6
	f1_local3 = 10
	f1_local0.hintTextElement = CoD.HintText.new()
	f1_local0.hintTextElement:setLeftRight(false, false, -CoD.CACSelectPerks.GridWidth / 2 + f1_local3, CoD.CACSelectPerks.GridWidth / 2)
	f1_local0.hintTextElement:setTopBottom(true, false, f1_local1, f1_local1 + CoD.HintText.Height)
	f1_local0:addElement(f1_local0.hintTextElement)
	f1_local1 = f1_local1 + CoD.HintText.Height + 12
	Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.CACSelectPerks.GridWidth / 2, CoD.CACSelectPerks.GridWidth / 2)
	Widget:setTopBottom(true, true, f1_local1, 0)
	f1_local0:addElement(Widget)
	f1_local5 = 0
	f1_local0.perkTitle = LUI.UIText.new()
	f1_local0.perkTitle:setLeftRight(true, false, f1_local3, 1)
	f1_local0.perkTitle:setTopBottom(true, false, f1_local5, f1_local5 + CoD.textSize.Big)
	f1_local0.perkTitle:setFont(CoD.fonts.Big)
	f1_local0.perkTitle:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	Widget:addElement(f1_local0.perkTitle)
	f1_local5 = f1_local5 + CoD.textSize.Big
	f1_local0.perkDescription = LUI.UIText.new()
	f1_local0.perkDescription:setLeftRight(true, false, f1_local3, CoD.CACSelectPerks.GridWidth / 2)
	f1_local0.perkDescription:setTopBottom(true, false, f1_local5, f1_local5 + CoD.textSize.Default)
	f1_local0.perkDescription:setAlignment(LUI.Alignment.Left)
	f1_local0.perkDescription:setFont(CoD.fonts.Default)
	Widget:addElement(f1_local0.perkDescription)
	f1_local5 = f1_local5 + CoD.textSize.Default * 2 + 8
	Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -(CoD.CACSelectPerks.GridWidth / 2.2), 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	f1_local0.attachmentIndexToReplace = CoD.perController[f1_arg0].slotIndex
	CoD.perController[f1_arg0].slotIndex = nil
	CoD.CACSelectPerks.AddPerks(f1_local0, f1_arg0, CoD.perController[f1_arg0].classNumInternal)
	return f1_local0
end

CoD.CACSelectPerks.ButtonPromptBack = function (f2_arg0, f2_arg1)
	if f2_arg0.highlightedButton ~= nil then
		f2_arg0.highlightedButton:setNew(false, f2_arg1.controller)
	end
	f2_arg0:goBack(f2_arg1.controller)
end

CoD.CACSelectPerks.DeselectButton = function (f3_arg0, f3_arg1)
	if f3_arg0.selectButton then
		f3_arg0.selectButton:setText(Engine.Localize("MENU_DESELECT"))
	end
end

CoD.CACSelectPerks.SelectButton = function (f4_arg0, f4_arg1)
	if f4_arg0.selectButton then
		f4_arg0.selectButton:setText(Engine.Localize("MENU_SELECT"))
	end
end

CoD.CACSelectPerks.AddPerks = function (f5_arg0, f5_arg1, f5_arg2)
	f5_arg0.perksList = {}
	f5_arg0.perksSlotNames = {}
	for f5_local0 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
		LUI.ConcatenateToTable(f5_arg0.perksList, CoD.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames["specialty" .. f5_local0]))
		f5_arg0.perksSlotNames[f5_local0] = "specialty" .. f5_local0
	end
	local f5_local0 = {}
	for f5_local1 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
		f5_local0[CoD.GetClassItem(f5_arg1, f5_arg2, CoD.CACUtility.loadoutSlotNames["specialty" .. f5_local1])] = true
	end
	local f5_local1 = nil
	f5_arg0.perksButtonList = {}
	for f5_local5, f5_local6 in pairs(f5_arg0.perksList) do
		local f5_local7 = CoD.PerkGridButton.new(f5_local6)
		if f5_local7.border then
			f5_local7.border:close()
			f5_local7.border = nil
		end
		f5_arg0.contentGrid:addButton(f5_local7)
		if f5_arg0.attachmentIndexToReplace == f5_local6 or not f5_local1 then
			f5_local1 = f5_local7
		end
		if f5_local0[f5_local6] then
			table.insert(f5_arg0.equippedItemIndices, f5_local6)
		end
	end
	f5_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f5_arg1,
		classNum = f5_arg2,
		class = class,
		attachmentIndexToReplace = f5_arg0.attachmentIndexToReplace
	})
	f5_local1:processEvent({
		name = "gain_focus"
	})
end

CoD.CACSelectPerks.ContentButtonHighlighted = function (f6_arg0, f6_arg1)
	if f6_arg1.contentIndex then
		local f6_local0 = UIExpression.GetItemName(nil, f6_arg1.contentIndex)
		if UIExpression.IsItemLocked(f6_arg1.controller, f6_arg1.contentIndex) ~= 0 then
			f6_arg0.perkTitle:setText("")
			f6_arg0.perkDescription:setText("")
		else
			f6_arg0.perkTitle:setText(Engine.Localize(UIExpression.GetItemName(nil, f6_arg1.contentIndex)))
			f6_arg0.perkDescription:setText(Engine.Localize(UIExpression.GetItemDesc(nil, f6_arg1.contentIndex)))
		end
	else
		f6_arg0.perkTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f6_arg0.perkDescription:setText("")
	end
	f6_arg0.hintTextElement:updateText(f6_arg1.hintText)
	f6_arg0.hintTextElement:updateImage(f6_arg1.hintImage)
	f6_arg0.highlightedButton = f6_arg1.button
end

CoD.CACSelectPerks.EquippedPerks = function (f7_arg0)
	local f7_local0 = 0
	local f7_local1 = 0
	for f7_local2 = 1, CoD.CACUtility.maxPerksSlots, 1 do
		if f7_arg0.equippedItemIndices[f7_local2] ~= nil then
			f7_local0 = f7_local0 + 1
		end
		if f7_local1 == 0 then
			f7_local1 = f7_local2
		end
	end
	return f7_local0, f7_local1
end

CoD.CACSelectPerks.ContentButtonSelected = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg0.m_ownerController
	CoD.perController[f8_local0].chosenItem = f8_arg1.contentIndex
	local f8_local1 = f8_arg1.contentIndex
	local f8_local2, f8_local3 = CoD.CACSelectPerks.EquippedPerks(f8_arg0)
	if CoD.CACSelectPerks.IsEquipped(f8_arg0, f8_local1) then
		for f8_local4 = 1, CoD.CACUtility.maxPerksSlots, 1 do
			if f8_local1 == f8_arg0.equippedItemIndices[f8_local4] then
				f8_arg0.equippedItemIndices[f8_local4] = nil
				break
			end
		end
		CoD.CACSelectPerks.UnequipPerk(f8_arg0, f8_local1)
		f8_arg0:processEvent({
			name = "update_class",
			controller = f8_local0
		})
		return 
	elseif f8_local2 == CoD.CACUtility.maxPerksSlots then
		Engine.PlaySound(CoD.CACUtility.denySFX)
		return 
	else
		f8_arg0:processEvent({
			name = "equip",
			controller = f8_local0,
			itemIndex = f8_local1
		})
		f8_arg0:dispatchEventToChildren({
			name = "update_class",
			controller = f8_local0,
			classNum = f8_arg0.classNum
		})
		f8_arg0.equippedItemIndices[f8_local3] = f8_local1
		f8_arg1.button:processEvent({
			name = "button_over"
		})
	end
end

CoD.CACSelectPerks.Equip = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg1.controller
	local f9_local1 = CoD.perController[f9_local0].classNumInternal
	local f9_local2 = nil
	local f9_local3 = f9_arg1.itemIndex
	for f9_local4 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
		local f9_local7 = CoD.CACUtility.loadoutSlotNames["specialty" .. f9_local4]
		local f9_local8 = CoD.GetClassItem(f9_local0, f9_local1, f9_local7)
		if f9_local8 == nil or f9_local8 == 0 or f9_local8 == UIExpression.GetItemIndex(f9_local0, CoD.nullSpecialtyName) then
			CoD.SetClassItem(f9_local0, f9_local1, f9_local7, f9_local3)
			Engine.PlaySound(CoD.CACUtility.EquipSFX)
			break
		end
	end
end

CoD.CACSelectPerks.UnequipPerk = function (f10_arg0, f10_arg1)
	if f10_arg1 == nil then
		return true
	end
	local f10_local0 = f10_arg0.m_ownerController
	local f10_local1 = CoD.perController[f10_local0].classNumInternal
	local f10_local2 = false
	for f10_local3 = 1, #f10_arg0.perksSlotNames, 1 do
		local f10_local6 = f10_arg0.perksSlotNames[f10_local3]
		if f10_arg1 == CoD.GetClassItem(f10_local0, f10_local1, f10_local6) then
			CoD.SetClassItem(f10_local0, f10_local1, f10_local6, 0)
			Engine.PlaySound(CoD.CACUtility.UnequipSFX)
			f10_local2 = true
			break
		end
	end
	return f10_local2
end

CoD.CACSelectPerks.IsEquipped = function (f11_arg0, f11_arg1)
	if f11_arg1 == nil then
		return false
	end
	local f11_local0 = f11_arg0.m_ownerController
	local f11_local1 = CoD.perController[f11_local0].classNumInternal
	local f11_local2 = false
	for f11_local3 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
		if f11_arg1 == CoD.GetClassItem(f11_local0, f11_local1, CoD.CACUtility.loadoutSlotNames["specialty" .. f11_local3]) then
			f11_local2 = true
			break
		end
	end
	return f11_local2
end

CoD.CACSelectPerks.RestoreDefaults = function (f12_arg0, f12_arg1)
	local f12_local0 = nil
	local f12_local1 = CoD.perController[f12_arg1.controller].classNumInternal
	local f12_local2 = f12_arg1.controller
	for f12_local3 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
		local f12_local6 = CoD.CACUtility.loadoutSlotNames["specialty" .. f12_local3]
		if CoD.GetClassItem(f12_local2, f12_local1, f12_local6) then
			CoD.SetClassItem(f12_local2, f12_local1, f12_local6, 0)
		end
	end
	local f12_local3 = CoD.CACUtility.GetCurrentSPMapDefaultPerks(f12_local2)
	for f12_local4 = 1, #f12_local3, 1 do
		if f12_local4 <= #f12_arg0.perksSlotNames then
			CoD.SetClassItem(f12_local2, f12_local1, CoD.CACUtility.loadoutSlotNames["specialty" .. f12_local4], f12_local3[f12_local4])
		end
	end
	f12_arg0:processEvent({
		name = "button_prompt_back",
		controller = f12_local2
	})
end

