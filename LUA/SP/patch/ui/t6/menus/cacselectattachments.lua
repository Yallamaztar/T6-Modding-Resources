CoD.CACSelectAttachments = {}
CoD.CACSelectAttachments.GridTop = 60
CoD.CACSelectAttachments.GridColumns = 7
CoD.CACSelectAttachments.GridItemSpacing = 2.5
CoD.CACSelectAttachments.GridWidth = CoD.Menu.Width * 1
CoD.CACSelectAttachments.GridItemWidth = (CoD.CACSelectAttachments.GridWidth - CoD.CACSelectAttachments.GridItemSpacing * (CoD.CACSelectAttachments.GridColumns - 1)) / CoD.CACSelectAttachments.GridColumns
CoD.CACSelectAttachments.GridItemHeight = 120
CoD.CACSelectAttachments.defaultAttachments = {}
LUI.createMenu.CACSelectAttachments = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CACSelectAttachments")
	f1_local0:addTitle(Engine.Localize("MENU_SELECT_ATTACHMENTS_CAPS"), LUI.Alignment.Center)
	f1_local0:setOwner(f1_arg0)
	local f1_local1 = CoD.perController[f1_arg0].classNumInternal
	local f1_local2 = CoD.perController[f1_arg0].weaponSlot
	f1_local0.maxNumAttachments = CoD.CACUtility.maxAttachments
	if f1_local0.weaponStatName ~= "" then
		f1_local0.maxNumAttachments = math.min(f1_local0.maxNumAttachments, Engine.GetNumAttachments(CoD.GetClassItem(f1_arg0, f1_local1, f1_local2)))
	end
	f1_local0.equippedItemIndices = {}
	f1_local0.currentSelectionIndex = 1
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("content_button_highlighted", CoD.CACSelectAttachments.ContentButtonHighlighted)
	f1_local0:registerEventHandler("content_button_selected", CoD.CACSelectAttachments.ContentButtonSelected)
	f1_local0:registerEventHandler("equip", CoD.CACSelectAttachments.Equip)
	f1_local0:registerEventHandler("update_class", CoD.CACSelectAttachments.UpdateClass)
	f1_local0:registerEventHandler("deselect_button", CoD.CACSelectAttachments.DeselectButton)
	f1_local0:registerEventHandler("select_button", CoD.CACSelectAttachments.SelectButton)
	f1_local0:registerEventHandler("button_prompt_back", CoD.CACSelectAttachments.ButtonPromptBack)
	local f1_local3 = CoD.CACSelectAttachments.GridTop
	f1_local0.contentGrid = CoD.ContentGrid.new(CoD.CACSelectAttachments.GridColumns, {
		leftAnchor = false,
		rightAnchor = false,
		left = -CoD.CACSelectAttachments.GridWidth / 2,
		right = CoD.CACSelectAttachments.GridWidth / 2,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local3,
		bottom = 0
	}, CoD.CACSelectAttachments.GridItemWidth, CoD.CACSelectAttachments.GridItemHeight, CoD.CACSelectAttachments.GridItemSpacing)
	f1_local0:addElement(f1_local0.contentGrid)
	f1_local3 = f1_local3 + CoD.CACSelectAttachments.GridItemHeight * 2 + CoD.ContentGrid.Spacing + 6
	f1_local0.hintTextElement = CoD.HintText.new()
	f1_local0.hintTextElement:setLeftRight(true, true, 0, 0)
	f1_local0.hintTextElement:setTopBottom(true, false, f1_local3, f1_local3 + CoD.HintText.Height)
	f1_local0:addElement(f1_local0.hintTextElement)
	f1_local3 = f1_local3 + CoD.HintText.Height + 12
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f1_local3, 0)
	f1_local0:addElement(Widget)
	local f1_local5 = 0
	f1_local0.attachmentTitle = LUI.UIText.new()
	f1_local0.attachmentTitle:setLeftRight(true, false, 0, 1)
	f1_local0.attachmentTitle:setTopBottom(true, false, f1_local5, f1_local5 + CoD.textSize.Big)
	f1_local0.attachmentTitle:setFont(CoD.fonts.Big)
	f1_local0.attachmentTitle:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	Widget:addElement(f1_local0.attachmentTitle)
	f1_local5 = f1_local5 + CoD.textSize.Big
	f1_local0.attachmentDescription = LUI.UIText.new()
	f1_local0.attachmentDescription:setLeftRight(true, false, 0, CoD.Menu.Width / 2)
	f1_local0.attachmentDescription:setTopBottom(true, false, f1_local5, f1_local5 + CoD.textSize.Default)
	f1_local0.attachmentDescription:setAlignment(LUI.Alignment.Left)
	f1_local0.attachmentDescription:setFont(CoD.fonts.Default)
	Widget:addElement(f1_local0.attachmentDescription)
	f1_local5 = f1_local5 + CoD.textSize.Default * 2 + 8
	local f1_local6 = CoD.Menu.Width / 2
	f1_local0.weaponAttributesList = CoD.WeaponAttributeList.new(f1_local6 - 60, {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f1_local6,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local5,
		bottom = 0
	}, CoD.CACUtility.attributesTable)
	Widget:addElement(f1_local0.weaponAttributesList)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -(CoD.Menu.Width / 2), 0)
	Widget:setTopBottom(true, true, f1_local5 - 6, 0)
	Widget:addElement(Widget)
	local f1_local8 = 250
	local f1_local9 = f1_local8 / 2
	f1_local0.weaponImage = LUI.UIImage.new()
	f1_local0.weaponImage:setLeftRight(false, true, -f1_local8 - 20, -20)
	f1_local0.weaponImage:setTopBottom(true, false, 0, f1_local9)
	Widget:addElement(f1_local0.weaponImage)
	f1_local0.weaponName = LUI.UIText.new()
	f1_local0.weaponName:setLeftRight(true, true, 0, -f1_local8 - 40)
	f1_local0.weaponName:setTopBottom(true, false, 0, CoD.textSize.Big)
	f1_local0.weaponName:setFont(CoD.fonts.Big)
	f1_local0.weaponName:setAlignment(LUI.Alignment.Right)
	Widget:addElement(f1_local0.weaponName)
	CoD.CACSelectAttachments.AddAttachments(f1_local0, f1_arg0, CoD.perController[f1_arg0].classNumInternal, f1_local2)
	return f1_local0
end

CoD.CACSelectAttachments.AddAttachments = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	local f2_local0 = Engine.GetCustomClass(f2_arg1, f2_arg2)
	local f2_local1 = CoD.GetClassItem(f2_arg1, f2_arg2, f2_arg3)
	f2_arg0.weaponItemIndex = f2_local1
	local f2_local2 = nil
	f2_arg0.weaponImage:beginAnimation("weapon_image")
	f2_arg0.weaponImage:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f2_local1) .. "_big"))
	f2_arg0.weaponName:setText(Engine.Localize(UIExpression.GetItemName(nil, f2_local1)))
	if f2_local1 == nil then
		return 
	end
	local f2_local3 = Engine.GetNumAttachments(f2_local1)
	for f2_local7, f2_local8 in pairs(CoD.GetAttachments(f2_local1)) do
		local f2_local9 = Engine.GetAttachmentName(f2_local1, f2_local8.attachmentIndex)
		local f2_local10 = CoD.AttachmentGridButton.new(f2_local1, f2_local8.attachmentIndex, CoD.Unlockables.IsAttachmentUnlocked(f2_local1, f2_local8.attachmentIndex))
		if f2_local10.border then
			f2_local10.border:close()
			f2_local10.border = nil
		end
		f2_arg0.contentGrid:addButton(f2_local10)
		if f2_arg0.attachmentIndexToReplace == f2_local8.attachmentIndex or not f2_local2 then
			f2_local2 = f2_local10
		end
		if f2_local8.attachmentIndex == CoD.GetClassItem(f2_arg1, f2_arg2, f2_arg3 .. "attachment" .. Engine.GetAttachmentAttachPoint(f2_local1, f2_local8.attachmentIndex)) then
			table.insert(f2_arg0.equippedItemIndices, f2_local8.attachmentIndex)
		end
	end
	f2_arg0:processEvent({
		name = "update_class",
		controller = f2_arg1
	})
	if f2_local2 then
		f2_local2:processEvent({
			name = "gain_focus",
			controller = f2_arg1
		})
	end
end

CoD.CACSelectAttachments.ButtonPromptBack = function (f3_arg0, f3_arg1)
	if f3_arg0.highlightedButton ~= nil then
		f3_arg0.highlightedButton:setNew(false, f3_arg1.controller)
	end
	f3_arg0:goBack(f3_arg1.controller)
end

CoD.CACSelectAttachments.DeselectButton = function (f4_arg0, f4_arg1)
	if f4_arg0.selectButton then
		f4_arg0.selectButton:setText(Engine.Localize("MENU_DESELECT"))
	end
end

CoD.CACSelectAttachments.SelectButton = function (f5_arg0, f5_arg1)
	if f5_arg0.selectButton then
		f5_arg0.selectButton:setText(Engine.Localize("MENU_SELECT"))
	end
end

CoD.CACSelectAttachments.ContentButtonHighlighted = function (f6_arg0, f6_arg1)
	if f6_arg1.contentIndex then
		f6_arg0.attachmentTitle:setText(Engine.Localize(Engine.GetAttachmentName(f6_arg0.weaponItemIndex, f6_arg1.contentIndex)))
		if Engine.GetItemAttachmentLocked(f6_arg1.controller, f6_arg0.weaponItemIndex, f6_arg1.contentIndex) ~= 0 then
			f6_arg0.attachmentDescription:setText("")
		else
			f6_arg0.attachmentDescription:setText(Engine.Localize(Engine.GetAttachmentDesc(f6_arg0.weaponItemIndex, f6_arg1.contentIndex)))
		end
	else
		f6_arg0.attachmentTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f6_arg0.attachmentDescription:setText("")
	end
	f6_arg0.weaponAttributesList:updateWeaponAttributes(f6_arg0.weaponItemIndex, f6_arg1.contentIndex)
	f6_arg0.hintTextElement:updateText(f6_arg1.hintText)
	f6_arg0.hintTextElement:updateImage(f6_arg1.hintImage)
	f6_arg0.highlightedButton = f6_arg1.button
end

CoD.CACSelectAttachments.EquippedAttachments = function (f7_arg0)
	local f7_local0 = 0
	local f7_local1 = 0
	for f7_local2 = 1, f7_arg0.maxNumAttachments, 1 do
		if f7_arg0.equippedItemIndices[f7_local2] ~= nil then
			f7_local0 = f7_local0 + 1
		end
		if f7_local1 == 0 then
			f7_local1 = f7_local2
		end
	end
	return f7_local0, f7_local1
end

CoD.CACSelectAttachments.IsMutuallyReplaceable = function (f8_arg0, f8_arg1, f8_arg2)
	if f8_arg2 ~= nil then
		local f8_local0 = {}
		for f8_local5, f8_local6 in ipairs(f8_arg2) do
			for f8_local4 = 1, #f8_arg0.equippedItemIndices, 1 do
				if f8_local6 == f8_arg0.equippedItemIndices[f8_local4] then
					table.insert(f8_local0, {
						f8_local4,
						f8_local6
					})
				end
			end
		end
		if #f8_local0 > 0 then
			return true, f8_local0
		end
	end
	return false
end

CoD.CACSelectAttachments.ContentButtonSelected = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0.m_ownerController
	local f9_local1 = f9_arg1.contentIndex
	local f9_local2 = nil
	local f9_local3, f9_local4 = CoD.CACSelectAttachments.EquippedAttachments(f9_arg0)
	local f9_local5, f9_local6 = CoD.CACSelectAttachments.IsMutuallyReplaceable(f9_arg0, f9_local1, f9_arg1.mutuallyExclusiveIndices)
	if f9_local5 then
		f9_local2 = f9_local6[1][1]
	else
		f9_local2 = f9_local4
	end
	if CoD.CACSelectAttachments.IsEquipped(f9_arg0, f9_local1) then
		for f9_local7 = 1, f9_arg0.maxNumAttachments, 1 do
			if f9_local1 == f9_arg0.equippedItemIndices[f9_local7] then
				f9_arg0.equippedItemIndices[f9_local7] = nil
				break
			end
		end
		CoD.CACSelectAttachments.UnequipAttachment(f9_arg0, f9_local1)
		f9_arg0:processEvent({
			name = "update_class",
			controller = f9_local0
		})
		return 
	else
		if f9_local3 == f9_arg0.maxNumAttachments and not f9_local5 then
			Engine.PlaySound(CoD.CACUtility.denySFX)
			return 
		elseif f9_local5 then
			for f9_local7 = 1, #f9_local6, 1 do
				CoD.CACSelectAttachments.UnequipAttachment(f9_arg0, f9_local6[f9_local7][2])
				f9_arg0.equippedItemIndices[f9_local6[f9_local7][1]] = nil
			end
		end
		f9_arg0.equippedItemIndices[f9_local2] = f9_local1
		f9_arg0:processEvent({
			name = "equip",
			controller = f9_local0,
			itemIndex = f9_local1
		})
		f9_arg0:processEvent({
			name = "update_class",
			controller = f9_local0
		})
	end
end

CoD.CACSelectAttachments.IsEquipped = function (f10_arg0, f10_arg1)
	if f10_arg1 == nil then
		return false
	else
		local f10_local0 = f10_arg0.m_ownerController
		return CoD.GetClassItem(f10_local0, CoD.perController[f10_local0].classNumInternal, CoD.perController[f10_local0].weaponSlot .. "attachment" .. Engine.GetAttachmentAttachPoint(f10_arg0.weaponItemIndex, f10_arg1)) == f10_arg1
	end
end

CoD.CACSelectAttachments.Equip = function (f11_arg0, f11_arg1)
	local f11_local0 = f11_arg1.controller
	local f11_local1 = CoD.perController[f11_local0].classNumInternal
	local f11_local2 = f11_arg1.itemIndex
	local f11_local3 = CoD.perController[f11_local0].weaponSlot .. "attachment" .. Engine.GetAttachmentAttachPoint(f11_arg0.weaponItemIndex, f11_local2)
	local f11_local4 = CoD.GetClassItem(f11_local0, f11_local1, f11_local3)
	if f11_local4 ~= nil and f11_local4 ~= 0 then
		return 
	else
		Engine.PlaySound(CoD.CACUtility.EquipSFX)
		Engine.SetClassItem(f11_local0, f11_local1, f11_local3, f11_local2)
	end
end

CoD.CACSelectAttachments.UnequipAttachment = function (f12_arg0, f12_arg1)
	if f12_arg1 == nil then
		return true
	end
	local f12_local0 = f12_arg0.m_ownerController
	local f12_local1 = CoD.perController[f12_local0].classNumInternal
	local f12_local2 = CoD.perController[f12_local0].weaponSlot
	local f12_local3 = false
	local f12_local4 = f12_local2 .. "attachment" .. Engine.GetAttachmentAttachPoint(f12_arg0.weaponItemIndex, f12_arg1)
	if f12_arg1 == CoD.GetClassItem(f12_local0, f12_local1, f12_local4) then
		Engine.PlaySound(CoD.CACUtility.UnequipSFX)
		Engine.SetClassItem(f12_local0, f12_local1, f12_local4, 0)
		f12_local3 = true
	end
	return f12_local3
end

CoD.CACSelectAttachments.UpdateClass = function (f13_arg0, f13_arg1)
	f13_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f13_arg1.controller,
		classNum = f13_arg0.classNum,
		class = Engine.GetCustomClass(f13_arg1.controller, CoD.perController[f13_arg1.controller].classNumInternal),
		attachmentIndexToReplace = f13_arg0.attachmentIndexToReplace
	})
end

