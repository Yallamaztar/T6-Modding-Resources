require("T6.AllocationBar")
require("T6.WeaponLevel")
CoD.CACAttachments = {}
CoD.CACAttachments.SlotListLineMaterialName = "menu_mp_cac_attach_line"
CoD.CACAttachments.GridTop = 60
CoD.CACAttachments.GridColumns = 6
CoD.CACAttachments.GridItemSpacing = 8
CoD.CACAttachments.GridItemWidth = (CoD.Menu.Width - CoD.CACAttachments.GridItemSpacing * (CoD.CACAttachments.GridColumns - 1)) / CoD.CACAttachments.GridColumns
CoD.CACAttachments.GridItemHeight = 64 + CoD.ContentGridButton.TitleHeight + 10
CoD.CACAttachments.SlotListSize = 64
CoD.CACAttachments.SlotListSpacing = 20
CoD.CACAttachments.SlotListLeft = 5
LUI.createMenu.CACAttachments = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CACAttachments")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("content_button_highlighted", CoD.CACAttachments.ContentButtonHighlighted)
	f1_local0:registerEventHandler("content_button_selected", CoD.CACAttachments.ContentButtonSelected)
	f1_local0:registerEventHandler("equip", CoD.CACAttachments.Equip)
	local f1_local1 = CoD.perController[f1_arg0].weaponSlot
	local f1_local2 = Engine.GetCustomClass(f1_arg0, CoD.perController[f1_arg0].classNum)
	local f1_local3 = Engine.Localize(UIExpression.GetItemName(nil, f1_local2[f1_local1])) .. " " .. Engine.Localize("MPUI_ATTACHMENTS_CAPS")
	local f1_local4 = 0
	local f1_local5 = LUI.UIText.new()
	f1_local5:setLeftRight(true, false, 0, 1)
	f1_local5:setTopBottom(true, false, f1_local4, f1_local4 + CoD.textSize.Big)
	f1_local5:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local5:setFont(CoD.fonts.Big)
	f1_local5:setText(f1_local3)
	f1_local0:addElement(f1_local5)
	f1_local4 = f1_local4 + CoD.textSize.Big
	local f1_local6 = CoD.Menu.Width
	local f1_local7 = f1_local6 - CoD.AllocationStatus.Width
	local f1_local8 = f1_local4 + 15
	f1_local0:addElement(CoD.AllocationStatus.new(f1_arg0, {
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local7,
		right = f1_local6,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local8 - CoD.AllocationStatus.Height,
		bottom = f1_local8
	}))
	local f1_local9 = 10
	local f1_local10 = f1_local8
	f1_local0.allocationBar = CoD.AllocationBar.New(f1_arg0, CoD.Menu.Width)
	f1_local0.allocationBar:setLeftRight(true, false, 0, CoD.Menu.Width)
	f1_local0.allocationBar:setTopBottom(true, false, f1_local10, f1_local10 + f1_local9)
	f1_local0:addElement(f1_local0.allocationBar)
	f1_local4 = f1_local4 + f1_local9 + 25
	f1_local0.contentGrid = CoD.ContentGrid.new(CoD.CACAttachments.GridColumns, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local4,
		bottom = 0
	}, CoD.CACAttachments.GridItemWidth, CoD.CACAttachments.GridItemHeight, CoD.CACAttachments.GridItemSpacing)
	f1_local0:addElement(f1_local0.contentGrid)
	local f1_local11 = math.ceil((Engine.GetNumAttachments(f1_local2[f1_local1]) - 1) / CoD.CACAttachments.GridColumns)
	local f1_local12 = f1_local4 + CoD.CACAttachments.GridItemHeight * f1_local11 + CoD.CACAttachments.GridItemSpacing * (f1_local11 - 1) + 3
	f1_local0.hintTextElement = CoD.HintText.new()
	f1_local0.hintTextElement:setLeftRight(true, true, 0, 0)
	f1_local0.hintTextElement:setTopBottom(true, false, f1_local12, f1_local12 + CoD.HintText.Height)
	f1_local0:addElement(f1_local0.hintTextElement)
	f1_local0.hintTextElement:setColor(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b, 0.4)
	f1_local4 = f1_local4 + CoD.CACAttachments.GridItemHeight * 3 + CoD.CACAttachments.GridItemSpacing * 2 + 3 + CoD.HintText.Height + 5
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f1_local4, 0)
	f1_local0:addElement(Widget)
	local f1_local14 = 0
	f1_local0.attachmentTitle = LUI.UIText.new()
	f1_local0.attachmentTitle:setLeftRight(true, false, 0, 1)
	f1_local0.attachmentTitle:setTopBottom(true, false, f1_local14, f1_local14 + CoD.textSize.Big)
	f1_local0.attachmentTitle:setFont(CoD.fonts.Big)
	f1_local0.attachmentTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(f1_local0.attachmentTitle)
	f1_local14 = f1_local14 + CoD.textSize.Big
	f1_local0.attachmentDescription = LUI.UIText.new()
	f1_local0.attachmentDescription:setLeftRight(true, false, 0, CoD.Menu.Width / 2)
	f1_local0.attachmentDescription:setTopBottom(true, false, f1_local14, f1_local14 + CoD.textSize.Default)
	f1_local0.attachmentDescription:setAlignment(LUI.Alignment.Left)
	f1_local0.attachmentDescription:setFont(CoD.fonts.Default)
	f1_local0.attachmentDescription:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.attachmentDescription:setAlpha(0.4)
	Widget:addElement(f1_local0.attachmentDescription)
	f1_local14 = f1_local14 + CoD.textSize.Default * 2 + 10
	local f1_local15 = CoD.Menu.Width / 2
	f1_local0.weaponAttributesList = CoD.WeaponAttributeList.new(f1_local15 - 60, {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f1_local15,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local14,
		bottom = 80
	})
	Widget:addElement(f1_local0.weaponAttributesList)
	local f1_local16 = CoD.Menu.Width * 0.33
	f1_local0.weaponLevel = CoD.WeaponLevel.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f1_local16,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local14,
		bottom = 0
	}, f1_local16)
	Widget:addElement(f1_local0.weaponLevel)
	f1_local0.weaponLevel:update(f1_arg0, f1_local2[f1_local1])
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -(CoD.Menu.Width / 2) + 10, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local f1_local18 = 300
	local f1_local19 = f1_local18 / 2
	local f1_local20 = -40
	f1_local0.weaponImage = LUI.UIImage.new()
	f1_local0.weaponImage:setLeftRight(false, true, -f1_local18 + 10, 10)
	f1_local0.weaponImage:setTopBottom(true, false, f1_local20, f1_local20 + f1_local19)
	Widget:addElement(f1_local0.weaponImage)
	local f1_local21 = -CoD.ButtonPrompt.Height - 30
	local f1_local22 = CoD.CACAttachments.SlotListSize + 10
	local f1_local23 = CoD.CACAttachments.GetSlotlistBackgroundWidth(CoD.CACAttachments.GetSlotListDipCount(f1_local1, f1_local2))
	f1_local0.slotListBackground = LUI.UIElement.new()
	f1_local0.slotListBackground:setLeftRight(true, false, CoD.CACAttachments.SlotListLeft, CoD.CACAttachments.SlotListLeft + f1_local23)
	f1_local0.slotListBackground:setTopBottom(false, true, f1_local21 - f1_local22, f1_local21)
	Widget:addElement(f1_local0.slotListBackground)
	CoD.CACAttachments.SetupSlotlistBorder(f1_local0.slotListBackground, f1_arg0)
	local f1_local24 = -2
	f1_local0.slotListTitle = LUI.UIText.new()
	f1_local0.slotListTitle:setLeftRight(true, true, 0, 0)
	f1_local0.slotListTitle:setTopBottom(true, false, f1_local24 - CoD.textSize.Default, f1_local24)
	f1_local0.slotListTitle:setAlpha(0.5)
	f1_local0.slotListTitle:setFont(CoD.fonts.Default)
	f1_local0.slotListTitle:setAlignment(LUI.Alignment.Left)
	f1_local0.slotListBackground:addElement(f1_local0.slotListTitle)
	f1_local0.slotList = CoD.SlotList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = CoD.CACAttachments.SlotListLeft + CoD.CACAttachments.SlotListSpacing / 2,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = f1_local21 - f1_local22,
		bottom = f1_local21
	}, CoD.CACAttachments.SlotListSize, CoD.CACAttachments.SlotListSize, CoD.CACAttachments.SlotListSpacing)
	f1_local0.slotList.setupElementsFunction = CoD.CACAttachments.SlotlistButtonSetup
	f1_local0.slotList.lineMaterial = RegisterMaterial(CoD.CACAttachments.SlotListLineMaterialName)
	f1_local0.slotList.addPreviewElementsFunction = CoD.NullFunction
	Widget:addElement(f1_local0.slotList)
	local f1_local25 = CoD.CACAttachments.SlotListSpacing / 2
	local f1_local26 = CoD.CACAttachments.SlotListSize - 10
	f1_local0.rewardImage = LUI.UIImage.new()
	f1_local0.rewardImage:setLeftRight(true, false, f1_local25, f1_local25 + f1_local26)
	f1_local0.rewardImage:setTopBottom(false, false, -f1_local26 / 2, f1_local26 / 2)
	f1_local0.rewardImage:setAlpha(0)
	f1_local0.slotListBackground:addElement(f1_local0.rewardImage)
	local f1_local27 = f1_local25 + CoD.CACAttachments.SlotListSize + CoD.CACAttachments.SlotListSpacing + CoD.CACAttachments.SlotListSize / 2
	local f1_local28 = CoD.CACAttachments.SlotListSize + CoD.CACAttachments.SlotListSpacing * 2
	f1_local0.rewardXP = LUI.UIText.new()
	f1_local0.rewardXP:setLeftRight(true, false, f1_local27 - f1_local28 / 2, f1_local27 + f1_local28 / 2)
	f1_local0.rewardXP:setTopBottom(false, false, -CoD.textSize.ExtraSmall / 2, CoD.textSize.ExtraSmall / 2)
	f1_local0.rewardXP:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f1_local0.rewardXP:setAlpha(0)
	f1_local0.rewardXP:setFont(CoD.fonts.ExtraSmall)
	f1_local0.rewardXP:setAlignment(LUI.Alignment.Center)
	f1_local0.slotListBackground:addElement(f1_local0.rewardXP)
	CoD.CACAttachments.AddAttachments(f1_local0, f1_arg0, CoD.perController[f1_arg0].classNum, f1_local1)
	f1_local0.slotList:processEvent({
		name = "lose_focus"
	})
	return f1_local0
end

CoD.CACAttachments.GetSlotListDipCount = function (f2_arg0, f2_arg1)
	local f2_local0 = 1
	if f2_arg0 == "primary" then
		f2_local0 = 2
	end
	if CoD.CACUtility.IsBonusCardEquippedByName(f2_arg1, "bonuscard_" .. f2_arg0 .. "_gunfighter") then
		f2_local0 = f2_local0 + 1
	end
	return f2_local0
end

CoD.CACAttachments.GetSlotlistBackgroundWidth = function (f3_arg0)
	return CoD.CACAttachments.SlotListSpacing / 2 + CoD.CACAttachments.SlotListSize * f3_arg0 + CoD.CACAttachments.SlotListSpacing * (f3_arg0 - 1) + CoD.CACAttachments.SlotListSpacing / 2
end

CoD.CACAttachments.SetupSlotlistBorder = function (f4_arg0, f4_arg1, f4_arg2)
	if f4_arg0.border then
		f4_arg0.border:close()
		f4_arg0.border = nil
	end
	if f4_arg2 == nil then
		f4_arg2 = CoD.CACAttachments.GetSlotListDipCount(CoD.perController[f4_arg1].weaponSlot, Engine.GetCustomClass(f4_arg1, CoD.perController[f4_arg1].classNum))
	end
	local f4_local0 = CoD.CACAttachments.GetSlotlistBackgroundWidth(f4_arg2)
	f4_arg0:beginAnimation("width_change")
	f4_arg0:setLeftRight(true, false, CoD.CACAttachments.SlotListLeft, CoD.CACAttachments.SlotListLeft + f4_local0)
	f4_arg0.border = CoD.BorderDip.new(1, 1, 1, 1, 0.05, nil, f4_local0, f4_arg2)
	f4_arg0:addElement(f4_arg0.border)
end

CoD.CACAttachments.SlotlistButtonSetup = function (f5_arg0)
	local f5_local0 = 20
	local f5_local1 = 25
	f5_arg0.icon = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -27,
		right = 27,
		topAnchor = false,
		bottomAnchor = false,
		top = -27,
		bottom = 27,
		alpha = 0
	})
	f5_arg0:addElement(f5_arg0.icon)
end

CoD.CACAttachments.AddAttachments = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	local f6_local0 = Engine.GetCustomClass(f6_arg1, f6_arg2)
	local f6_local1 = f6_local0[f6_arg3]
	f6_arg0.weaponItemIndex = f6_local1
	f6_arg0.weaponImage:registerAnimationState("weapon_image", {
		material = RegisterMaterial(UIExpression.GetItemImage(nil, f6_local1) .. "_big")
	})
	f6_arg0.weaponImage:animateToState("weapon_image")
	local f6_local2 = {}
	local f6_local3 = {}
	for f6_local4 = 0, 2, 1 do
		local f6_local7 = f6_local0[f6_arg3 .. "attachment" .. f6_local4 + 1]
		if f6_local7 ~= nil and f6_local7 ~= 0 then
			f6_local2[f6_local4 + 1] = f6_local7
			f6_local3[f6_local7] = f6_local4
		end
	end
	local f6_local4 = CoD.perController[f6_arg1].slotIndex
	f6_arg0.attachmentIndexToReplace = f6_local2[f6_local4]
	local f6_local5 = Engine.GetNumAttachments(f6_local1)
	local f6_local6 = nil
	for f6_local8 = 1, f6_local5 - 1, 1 do
		local f6_local10 = CoD.AttachmentGridButton.new(f6_local1, f6_local8)
		f6_arg0.contentGrid:addButton(f6_local10)
		if f6_arg0.attachmentIndexToReplace == f6_local8 or not f6_local6 then
			f6_local6 = f6_local10
		end
	end
	f6_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f6_arg1,
		classNum = f6_arg2,
		class = f6_local0,
		attachmentIndexToReplace = f6_arg0.attachmentIndexToReplace
	})
	CoD.SlotList.PopulateWithAttachments(f6_arg0.slotList, f6_arg1, f6_arg2, f6_arg3)
	f6_arg0.slotList:highlightSlot(f6_local4)
	f6_local6:processEvent({
		name = "gain_focus",
		controller = f6_arg1
	})
end

CoD.CACAttachments.ContentButtonHighlighted = function (f7_arg0, f7_arg1)
	if f7_arg1.contentIndex then
		f7_arg0.attachmentTitle:setText(Engine.Localize(Engine.GetAttachmentName(f7_arg0.weaponItemIndex, f7_arg1.contentIndex)))
		if f7_arg1.locked == true then
			CoD.CACAttachments.SetupSlotlistBorder(f7_arg0.slotListBackground, f7_arg0.m_ownerController, 2)
			f7_arg0.attachmentDescription:setText(CoD.AttachmentGridButton.GetRequiredGunLevel(f7_arg0.m_ownerController, f7_arg0.weaponItemIndex, f7_arg1.contentIndex))
			f7_arg0.slotListTitle:setText(Engine.Localize("MPUI_REWARDS"))
			f7_arg0.weaponAttributesList:beginAnimation("hide")
			f7_arg0.weaponAttributesList:setAlpha(0)
			f7_arg0.weaponLevel:beginAnimation("show")
			f7_arg0.weaponLevel:setAlpha(1)
			f7_arg0.slotList:beginAnimation("hide")
			f7_arg0.slotList:setAlpha(0)
			f7_arg0.rewardImage:setImage(RegisterMaterial(Engine.GetAttachmentImage(f7_arg0.weaponItemIndex, f7_arg1.contentIndex)))
			f7_arg0.rewardImage:beginAnimation("show")
			f7_arg0.rewardImage:setAlpha(1)
			f7_arg0.rewardXP:setText(CoD.AttachmentGridButton.GetRewardXP(f7_arg0.m_ownerController, f7_arg0.weaponItemIndex, f7_arg1.contentIndex))
			f7_arg0.rewardXP:beginAnimation("show")
			f7_arg0.rewardXP:setAlpha(1)
			f7_arg0:removeSelectButton()
		else
			CoD.CACAttachments.SetupSlotlistBorder(f7_arg0.slotListBackground, f7_arg0.m_ownerController)
			f7_arg0.attachmentDescription:setText(Engine.Localize(Engine.GetAttachmentDesc(f7_arg0.weaponItemIndex, f7_arg1.contentIndex)))
			f7_arg0.slotListTitle:setText(Engine.Localize("MPUI_EQUIPPED"))
			f7_arg0.weaponLevel:beginAnimation("hide")
			f7_arg0.weaponLevel:setAlpha(0)
			f7_arg0.rewardImage:beginAnimation("hide")
			f7_arg0.rewardImage:setAlpha(0)
			f7_arg0.rewardXP:beginAnimation("hide")
			f7_arg0.rewardXP:setAlpha(0)
			f7_arg0.slotList:beginAnimation("show")
			f7_arg0.slotList:setAlpha(1)
			f7_arg0.weaponAttributesList:updateWeaponAttributes(f7_arg0.weaponItemIndex, f7_arg1.contentIndex)
			f7_arg0.weaponAttributesList:beginAnimation("show")
			f7_arg0.weaponAttributesList:setAlpha(1)
			f7_arg0:addSelectButtonWithPrestigeUnlock()
		end
	else
		f7_arg0.attachmentTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f7_arg0.attachmentDescription:setText("")
	end
	f7_arg0.hintTextElement:updateText(f7_arg1.hintText)
end

CoD.CACAttachments.ContentButtonSelected = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg0.m_ownerController
	CoD.perController[f8_local0].chosenItem = f8_arg1.contentIndex
	local f8_local1 = false
	if CoD.CACAttachments.UnequipAttachment(f8_arg0, f8_arg0.attachmentIndexToReplace) then
		f8_local1 = true
	end
	if f8_arg1.mutuallyExclusiveIndices then
		for f8_local5, f8_local6 in ipairs(f8_arg1.mutuallyExclusiveIndices) do
			if CoD.CACAttachments.UnequipAttachment(f8_arg0, f8_local6) then
				f8_local1 = true
			end
		end
	end
	if f8_arg1.contentIndex then
		if CoD.CACAttachments.UnequipAttachment(f8_arg0, f8_arg1.contentIndex) then
			f8_local1 = true
		end
	else
		f8_local1 = true
	end
	if not f8_local1 then
		local f8_local2 = Engine.GetCustomClass(f8_local0, CoD.perController[f8_local0].classNum)
		if f8_local2.allocationSpent < Engine.GetMaxAllocation(f8_local0) then
			f8_local1 = true
		end
	end
	if f8_local1 then
		f8_arg0:processEvent({
			name = "equip",
			controller = f8_arg0.m_ownerController
		})
	else
		f8_arg0:openPopup("CACRemoveItem", f8_local0)
	end
end

CoD.CACAttachments.Equip = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg1.controller
	local f9_local1 = CoD.perController[f9_local0].classNum
	local f9_local2 = CoD.perController[f9_local0].weaponSlot
	local f9_local3 = CoD.perController[f9_local0].chosenItem
	CoD.perController[f9_local0].chosenItem = nil
	if f9_local3 then
		Engine.SetClassItem(f9_local0, f9_local1, f9_local2 .. "attachment" .. CoD.perController[f9_local0].slotIndex, f9_local3)
		CoD.EquipNotification.AddToNotificationQueue("item", "equipped", Engine.GetAttachmentName(f9_arg0.weaponItemIndex, f9_local3))
		if CoD.CACUtility.AttachmentHasCustomReticle(Engine.GetAttachmentRef(f9_arg0.weaponItemIndex, f9_local3)) then
			Engine.SetClassItem(f9_local0, f9_local1, f9_local2 .. "reticle", UIExpression.GetWeaponOptionGroupIndex(nil, 0, CoD.CACUtility.WEAPONOPTION_GROUP_RETICLE))
		end
	end
	f9_arg0:processEvent({
		name = "button_prompt_back",
		controller = f9_local0
	})
end

CoD.CACAttachments.UnequipAttachment = function (f10_arg0, f10_arg1)
	if not f10_arg1 then
		return 
	end
	local f10_local0 = f10_arg0.m_ownerController
	local f10_local1 = nil
	if CoD.isSinglePlayer == true then
		f10_local1 = CoD.perController[f10_local0].classNumInternal
	else
		f10_local1 = CoD.perController[f10_local0].classNum
	end
	local f10_local2 = Engine.GetCustomClass(f10_local0, f10_local1)
	local f10_local3 = CoD.perController[f10_local0].weaponSlot
	local f10_local4 = CoD.CACUtility.attachmentPointNames
	for f10_local5 = 0, 2, 1 do
		local f10_local8 = f10_local3 .. "attachment" .. f10_local5 + 1
		if f10_local2[f10_local8] == f10_arg1 then
			Engine.SetClassItem(f10_local0, f10_local1, f10_local8, 0)
			return true
		end
	end
end

