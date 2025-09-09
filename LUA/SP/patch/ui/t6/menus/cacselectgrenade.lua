CoD.CACSelectGrenade = {}
CoD.CACSelectGrenade.GridTop = 60
CoD.CACSelectGrenade.GridColumns = 6
CoD.CACSelectGrenade.GridItemSpacing = 12
CoD.CACSelectGrenade.GridWidth = CoD.Menu.Width * 0.85
CoD.CACSelectGrenade.GridItemWidth = (CoD.CACSelectGrenade.GridWidth - CoD.CACSelectGrenade.GridItemSpacing * (CoD.CACSelectGrenade.GridColumns - 1)) / CoD.CACSelectGrenade.GridColumns
CoD.CACSelectGrenade.GridItemHeight = 120
LUI.createMenu.CACSelectGrenade = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CACSelectGrenade")
	f1_local0:addTitle(Engine.Localize("MENU_SELECT_GRENADES_CAPS"), LUI.Alignment.Center)
	f1_local0:setOwner(f1_arg0)
	f1_local0.equippedItemIndices = {}
	f1_local0.currentSelectionIndex = nil
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
	f1_local0:registerEventHandler("content_button_highlighted", CoD.CACSelectGrenade.ContentButtonHighlighted)
	f1_local0:registerEventHandler("content_button_selected", CoD.CACSelectGrenade.ContentButtonSelected)
	f1_local0:registerEventHandler("equip", CoD.CACSelectGrenade.Equip)
	f1_local0:registerEventHandler("button_restore_defaults", CoD.CACSelectGrenade.RestoreDefaults)
	f1_local0:registerEventHandler("deselect_button", CoD.CACSelectGrenade.DeselectButton)
	f1_local0:registerEventHandler("select_button", CoD.CACSelectGrenade.SelectButton)
	f1_local0:registerEventHandler("button_prompt_back", CoD.CACSelectGrenade.ButtonPromptBack)
	f1_local1 = CoD.CACSelectGrenade.GridTop
	f1_local0.contentGrid = CoD.ContentGrid.new(CoD.CACSelectGrenade.GridColumns, {
		leftAnchor = false,
		rightAnchor = false,
		left = -CoD.CACSelectGrenade.GridWidth / 2,
		right = CoD.CACSelectGrenade.GridWidth / 2,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local1,
		bottom = 0
	}, CoD.CACSelectGrenade.GridItemWidth, CoD.CACSelectGrenade.GridItemHeight, CoD.CACSelectGrenade.GridItemSpacing)
	f1_local0:addElement(f1_local0.contentGrid)
	f1_local1 = f1_local1 + CoD.CACSelectGrenade.GridItemHeight * 2 + CoD.ContentGrid.Spacing * 2 + 6
	f1_local3 = 10
	f1_local0.hintTextElement = CoD.HintText.new()
	f1_local0.hintTextElement:setLeftRight(false, false, -CoD.CACSelectGrenade.GridWidth / 2 + f1_local3, CoD.CACSelectGrenade.GridWidth / 2)
	f1_local0.hintTextElement:setTopBottom(true, false, f1_local1, f1_local1 + CoD.HintText.Height)
	f1_local0:addElement(f1_local0.hintTextElement)
	f1_local1 = f1_local1 + CoD.HintText.Height + 12 + CoD.CACSelectGrenade.GridItemHeight
	Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.CACSelectGrenade.GridWidth / 2, CoD.CACSelectGrenade.GridWidth / 2)
	Widget:setTopBottom(true, true, f1_local1, 0)
	f1_local0:addElement(Widget)
	f1_local5 = 0
	f1_local0.grenadeTitle = LUI.UIText.new()
	f1_local0.grenadeTitle:setLeftRight(true, false, f1_local3, 1)
	f1_local0.grenadeTitle:setTopBottom(true, false, f1_local5, f1_local5 + CoD.textSize.Big)
	f1_local0.grenadeTitle:setFont(CoD.fonts.Big)
	f1_local0.grenadeTitle:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	Widget:addElement(f1_local0.grenadeTitle)
	f1_local5 = f1_local5 + CoD.textSize.Big
	f1_local0.grenadeDescription = LUI.UIText.new()
	f1_local0.grenadeDescription:setLeftRight(true, false, f1_local3, CoD.CACSelectGrenade.GridWidth / 2)
	f1_local0.grenadeDescription:setTopBottom(true, false, f1_local5, f1_local5 + CoD.textSize.Default)
	f1_local0.grenadeDescription:setAlignment(LUI.Alignment.Left)
	f1_local0.grenadeDescription:setFont(CoD.fonts.Default)
	Widget:addElement(f1_local0.grenadeDescription)
	f1_local5 = f1_local5 + CoD.textSize.Default * 2 + 8
	Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -(CoD.CACSelectGrenade.GridWidth / 2.2), 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	f1_local0.attachmentIndexToReplace = CoD.perController[f1_arg0].slotIndex
	CoD.perController[f1_arg0].slotIndex = nil
	CoD.CACSelectGrenade.AddGrenades(f1_local0, f1_arg0, CoD.perController[f1_arg0].classNumInternal)
	return f1_local0
end

CoD.CACSelectGrenade.ButtonPromptBack = function (f2_arg0, f2_arg1)
	if f2_arg0.highlightedButton ~= nil then
		f2_arg0.highlightedButton:setNew(false, f2_arg1.controller)
	end
	f2_arg0:goBack(f2_arg1.controller)
end

CoD.CACSelectGrenade.DeselectButton = function (f3_arg0, f3_arg1)
	if f3_arg0.selectButton then
		f3_arg0.selectButton:setText(Engine.Localize("MENU_DESELECT"))
	end
end

CoD.CACSelectGrenade.SelectButton = function (f4_arg0, f4_arg1)
	if f4_arg0.selectButton then
		f4_arg0.selectButton:setText(Engine.Localize("MENU_SELECT"))
	end
end

CoD.CACSelectGrenade.AddGrenades = function (f5_arg0, f5_arg1, f5_arg2)
	f5_arg0.grenadeList = CoD.CACUtility.GetAllGrenadesAndEquipment()
	f5_arg0.grenadeSlotNames = {}
	f5_arg0.grenadeSlotNames[1] = "primarygrenade"
	f5_arg0.grenadeSlotNames[2] = "specialgrenade"
	local f5_local0 = {
		[CoD.GetClassItem(f5_arg1, f5_arg2, "primarygrenade")] = true,
		[CoD.GetClassItem(f5_arg1, f5_arg2, "specialgrenade")] = true
	}
	local f5_local1 = nil
	for f5_local5, f5_local6 in pairs(f5_arg0.grenadeList) do
		local f5_local7 = CoD.GrenadeGridButton.new(f5_local6)
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
	f5_arg0.currentSelectionIndex = #f5_arg0.equippedItemIndices + 1
	if f5_arg0.currentSelectionIndex > CoD.CACUtility.maxGrenades then
		f5_arg0.currentSelectionIndex = 1
	end
	f5_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f5_arg1,
		classNum = f5_arg2,
		attachmentIndexToReplace = f5_arg0.attachmentIndexToReplace
	})
	f5_arg0.classNum = f5_arg2
	f5_local1:processEvent({
		name = "gain_focus"
	})
end

CoD.CACSelectGrenade.ContentButtonHighlighted = function (f6_arg0, f6_arg1)
	if f6_arg1.contentIndex then
		local f6_local0 = UIExpression.GetItemName(nil, f6_arg1.contentIndex)
		if UIExpression.IsItemLocked(f6_arg1.controller, f6_arg1.contentIndex) ~= 0 then
			f6_arg0.grenadeTitle:setText("")
			f6_arg0.grenadeDescription:setText("")
		else
			f6_arg0.grenadeTitle:setText(Engine.Localize(UIExpression.GetItemName(nil, f6_arg1.contentIndex)))
			f6_arg0.grenadeDescription:setText(Engine.Localize(UIExpression.GetItemDesc(nil, f6_arg1.contentIndex)))
		end
	else
		f6_arg0.grenadeTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f6_arg0.grenadeDescription:setText("")
	end
	f6_arg0.hintTextElement:updateText(f6_arg1.hintText)
	f6_arg0.hintTextElement:updateImage(f6_arg1.hintImage)
	f6_arg0.highlightedButton = f6_arg1.button
end

CoD.CACSelectGrenade.EquippedPerks = function (f7_arg0)
	local f7_local0 = 0
	local f7_local1 = 0
	for f7_local2 = 1, CoD.CACUtility.maxGrenades, 1 do
		if f7_arg0.equippedItemIndices[f7_local2] ~= nil then
			f7_local0 = f7_local0 + 1
		end
		if f7_local1 == 0 then
			f7_local1 = f7_local2
		end
	end
	return f7_local0, f7_local1
end

CoD.CACSelectGrenade.ContentButtonSelected = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg0.m_ownerController
	CoD.perController[f8_local0].chosenItem = f8_arg1.contentIndex
	local f8_local1 = f8_arg1.contentIndex
	local f8_local2 = f8_arg0.currentSelectionIndex
	local f8_local3, f8_local4 = CoD.CACSelectGrenade.EquippedPerks(f8_arg0)
	if CoD.CACSelectGrenade.IsEquipped(f8_arg0, f8_local1) then
		for f8_local5 = 1, #f8_arg0.equippedItemIndices, 1 do
			if f8_local1 == f8_arg0.equippedItemIndices[f8_local5] then
				f8_arg0.equippedItemIndices[f8_local5] = nil
				f8_arg0.currentSelectionIndex = f8_local5
				break
			end
		end
		CoD.CACSelectGrenade.UnequipGrenade(f8_arg0, f8_local1)
		f8_arg0:processEvent({
			name = "update_class",
			controller = f8_local0
		})
		return 
	else
		if f8_local3 == CoD.CACUtility.maxGrenades then
			Engine.PlaySound(CoD.CACUtility.denySFX)
			return 
		end
		f8_arg0.attachmentIndexToReplace = f8_arg0.equippedItemIndices[f8_local2]
		f8_arg0.currentSelectionIndex = f8_arg0.currentSelectionIndex + 1
		if f8_arg0.currentSelectionIndex > CoD.CACUtility.maxGrenades then
			f8_arg0.currentSelectionIndex = 1
		end
		if CoD.CACSelectGrenade.UnequipGrenade(f8_arg0, f8_arg0.attachmentIndexToReplace) then
			f8_arg0:processEvent({
				name = "equip",
				controller = f8_local0,
				itemIndex = f8_local1
			})
		end
		f8_arg0.attachmentIndexToReplace = f8_local1
		f8_arg0:dispatchEventToChildren({
			name = "update_class",
			controller = f8_local0,
			classNum = f8_arg0.classNum,
			attachmentIndexToReplace = f8_arg0.attachmentIndexToReplace
		})
		f8_arg0.equippedItemIndices[f8_local2] = f8_local1
	end
end

CoD.CACSelectGrenade.Equip = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg1.controller
	local f9_local1 = CoD.perController[f9_local0].classNumInternal
	local f9_local2 = f9_arg1.itemIndex
	local f9_local3 = CoD.GetClassItem(f9_local0, f9_local1, CoD.CACUtility.loadoutSlotNames.primaryGrenade)
	if f9_local3 == nil or f9_local3 == 0 or f9_local3 == f9_local2 then
		CoD.SetClassItem(f9_local0, f9_local1, CoD.CACUtility.loadoutSlotNames.primaryGrenade, f9_local2)
	else
		CoD.SetClassItem(f9_local0, f9_local1, CoD.CACUtility.loadoutSlotNames.specialGrenade, f9_local2)
	end
	Engine.PlaySound(CoD.CACUtility.EquipSFX)
end

CoD.CACSelectGrenade.UnequipGrenade = function (f10_arg0, f10_arg1)
	if f10_arg1 == nil then
		return true
	end
	local f10_local0 = f10_arg0.m_ownerController
	local f10_local1 = CoD.perController[f10_local0].classNumInternal
	local f10_local2 = false
	for f10_local3 = 1, #f10_arg0.grenadeSlotNames, 1 do
		local f10_local6 = f10_arg0.grenadeSlotNames[f10_local3]
		if f10_arg1 == CoD.GetClassItem(f10_local0, f10_local1, f10_local6) then
			CoD.SetClassItem(f10_local0, f10_local1, f10_local6, 0)
			Engine.PlaySound(CoD.CACUtility.UnequipSFX)
			f10_local2 = true
			break
		end
	end
	return f10_local2
end

CoD.CACSelectGrenade.IsEquipped = function (f11_arg0, f11_arg1)
	if f11_arg1 == nil then
		return false
	end
	local f11_local0 = false
	local f11_local1 = f11_arg0.m_ownerController
	local f11_local2 = CoD.perController[f11_local1].classNumInternal
	for f11_local3 = 1, #f11_arg0.grenadeSlotNames, 1 do
		if f11_arg1 == CoD.GetClassItem(f11_local1, f11_local2, f11_arg0.grenadeSlotNames[f11_local3]) then
			f11_local0 = true
			break
		end
	end
	return f11_local0
end

CoD.CACSelectGrenade.RestoreDefaults = function (f12_arg0, f12_arg1)
	local f12_local0 = nil
	local f12_local1 = f12_arg1.controller
	local f12_local2 = CoD.perController[f12_local1].classNumInternal
	for f12_local3 = 1, #f12_arg0.grenadeSlotNames, 1 do
		local f12_local6 = f12_arg0.grenadeSlotNames[f12_local3]
		if CoD.GetClassItem(f12_local1, f12_local2, f12_local6) then
			CoD.SetClassItem(f12_local1, f12_local2, f12_local6, 0)
			break
		end
	end
	local f12_local3 = CoD.CACUtility.GetCurrentSPMapDefaultGrenadesAndEquipment(f12_local1)
	for f12_local4 = 1, #f12_local3, 1 do
		if f12_local4 <= #f12_arg0.grenadeSlotNames then
			CoD.SetClassItem(f12_local1, f12_local2, f12_arg0.grenadeSlotNames[f12_local4], f12_local3[f12_local4])
		end
	end
	f12_arg0:processEvent({
		name = "button_prompt_back",
		controller = f12_local1
	})
end

