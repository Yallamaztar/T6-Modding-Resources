require("T6.AllocationBar")
require("T6.WeaponLevel")
CoD.WeaponAttachmentChallenges = {}
CoD.WeaponAttachmentChallenges.SlotListLineMaterialName = "menu_mp_cac_attach_line"
CoD.WeaponAttachmentChallenges.GridTop = 60
CoD.WeaponAttachmentChallenges.GridColumns = 6
CoD.WeaponAttachmentChallenges.GridItemSpacing = 8
CoD.WeaponAttachmentChallenges.GridItemWidth = (CoD.Menu.Width - CoD.WeaponAttachmentChallenges.GridItemSpacing * (CoD.WeaponAttachmentChallenges.GridColumns - 1)) / CoD.WeaponAttachmentChallenges.GridColumns
CoD.WeaponAttachmentChallenges.GridItemHeight = 64 + CoD.ContentGridButton.TitleHeight + 10
CoD.WeaponAttachmentChallenges.SlotListSize = 64
CoD.WeaponAttachmentChallenges.SlotListSpacing = 20
CoD.WeaponAttachmentChallenges.SlotListLeft = 5
LUI.createMenu.WeaponAttachmentChallenges = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("WeaponAttachmentChallenges")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:setPreviousMenu("WeaponChallengeType")
	f1_local0:addBackButton()
	local f1_local1 = CoD.perController[f1_arg0].weaponIndex
	f1_local0:registerEventHandler("content_button_highlighted", CoD.WeaponAttachmentChallenges.ContentButtonHighlighted)
	local f1_local2 = 0
	f1_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize(UIExpression.GetItemName(nil, f1_local1)) .. " " .. Engine.Localize("MPUI_ATTACHMENTS_CAPS")))
	f1_local2 = f1_local2 + CoD.textSize.Big + 15
	f1_local0.contentGrid = CoD.ContentGrid.new(CoD.WeaponAttachmentChallenges.GridColumns, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local2,
		bottom = 0
	}, CoD.WeaponAttachmentChallenges.GridItemWidth, CoD.WeaponAttachmentChallenges.GridItemHeight, CoD.WeaponAttachmentChallenges.GridItemSpacing)
	f1_local0:addElement(f1_local0.contentGrid)
	local f1_local3 = math.ceil((Engine.GetNumAttachments(f1_local1) - 1) / CoD.WeaponAttachmentChallenges.GridColumns)
	f1_local2 = f1_local2 + CoD.WeaponAttachmentChallenges.GridItemHeight * 3 + CoD.WeaponAttachmentChallenges.GridItemSpacing * 2 + 3 + CoD.HintText.Height + 5
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f1_local2, 0)
	f1_local0:addElement(Widget)
	local f1_local5 = 0
	f1_local0.attachmentTitle = LUI.UIText.new()
	f1_local0.attachmentTitle:setLeftRight(true, false, 0, 1)
	f1_local0.attachmentTitle:setTopBottom(true, false, f1_local5, f1_local5 + CoD.textSize.Big)
	f1_local0.attachmentTitle:setFont(CoD.fonts.Big)
	f1_local0.attachmentTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(f1_local0.attachmentTitle)
	f1_local5 = f1_local5 + CoD.textSize.Big
	f1_local0.attachmentDescription = LUI.UIText.new()
	f1_local0.attachmentDescription:setLeftRight(true, false, 0, CoD.Menu.Width / 2)
	f1_local0.attachmentDescription:setTopBottom(true, false, f1_local5, f1_local5 + CoD.textSize.Default)
	f1_local0.attachmentDescription:setAlignment(LUI.Alignment.Left)
	f1_local0.attachmentDescription:setFont(CoD.fonts.Default)
	f1_local0.attachmentDescription:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.attachmentDescription:setAlpha(0.4)
	Widget:addElement(f1_local0.attachmentDescription)
	f1_local5 = f1_local5 + CoD.textSize.Default * 2 + 10
	local f1_local6 = CoD.Menu.Width / 2
	f1_local0.weaponAttributesList = CoD.WeaponAttributeList.new(f1_local6 - 60, {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f1_local6,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local5,
		bottom = 80
	})
	Widget:addElement(f1_local0.weaponAttributesList)
	local f1_local7 = CoD.Menu.Width * 0.33
	f1_local0.weaponLevel = CoD.WeaponLevel.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f1_local7,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local5,
		bottom = 0
	}, f1_local7)
	Widget:addElement(f1_local0.weaponLevel)
	f1_local0.weaponLevel:update(f1_arg0, f1_local1)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -(CoD.Menu.Width / 2) + 10, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local f1_local9 = 300
	local f1_local10 = f1_local9 / 2
	local f1_local11 = -40
	f1_local0.weaponImage = LUI.UIImage.new()
	f1_local0.weaponImage:setLeftRight(false, true, -f1_local9 + 10, 10)
	f1_local0.weaponImage:setTopBottom(true, false, f1_local11, f1_local11 + f1_local10)
	Widget:addElement(f1_local0.weaponImage)
	local f1_local12 = -CoD.ButtonPrompt.Height - 30
	local f1_local13 = CoD.CACAttachments.SlotListSize + 10
	local f1_local14 = CoD.WeaponAttachmentChallenges.GetSlotlistBackgroundWidth(2)
	f1_local0.slotListBackground = LUI.UIElement.new()
	f1_local0.slotListBackground:setLeftRight(true, false, CoD.CACAttachments.SlotListLeft, CoD.CACAttachments.SlotListLeft + f1_local14)
	f1_local0.slotListBackground:setTopBottom(false, true, f1_local12 - f1_local13, f1_local12)
	Widget:addElement(f1_local0.slotListBackground)
	f1_local0.slotListBackground.border = CoD.BorderDip.new(1, 1, 1, 1, 0.05, nil, f1_local14, 2)
	f1_local0.slotListBackground:addElement(f1_local0.slotListBackground.border)
	f1_local0.slotListBackground.border:hide()
	local f1_local15 = -2
	f1_local0.slotListTitle = LUI.UIText.new()
	f1_local0.slotListTitle:setLeftRight(true, true, 0, 0)
	f1_local0.slotListTitle:setTopBottom(true, false, f1_local15 - CoD.textSize.Default, f1_local15)
	f1_local0.slotListTitle:setAlpha(0.5)
	f1_local0.slotListTitle:setFont(CoD.fonts.Default)
	f1_local0.slotListTitle:setAlignment(LUI.Alignment.Left)
	f1_local0.slotListBackground:addElement(f1_local0.slotListTitle)
	local f1_local16 = CoD.CACAttachments.SlotListSpacing / 2
	local f1_local17 = CoD.CACAttachments.SlotListSize - 10
	f1_local0.rewardImage = LUI.UIImage.new()
	f1_local0.rewardImage:setLeftRight(true, false, f1_local16, f1_local16 + f1_local17)
	f1_local0.rewardImage:setTopBottom(false, false, -f1_local17 / 2, f1_local17 / 2)
	f1_local0.rewardImage:setAlpha(0)
	f1_local0.slotListBackground:addElement(f1_local0.rewardImage)
	local f1_local18 = f1_local16 + CoD.CACAttachments.SlotListSize + CoD.CACAttachments.SlotListSpacing + CoD.CACAttachments.SlotListSize / 2
	local f1_local19 = CoD.CACAttachments.SlotListSize + CoD.CACAttachments.SlotListSpacing * 2
	f1_local0.rewardXP = LUI.UIText.new()
	f1_local0.rewardXP:setLeftRight(true, false, f1_local18 - f1_local19 / 2, f1_local18 + f1_local19 / 2)
	f1_local0.rewardXP:setTopBottom(false, false, -CoD.textSize.ExtraSmall / 2, CoD.textSize.ExtraSmall / 2)
	f1_local0.rewardXP:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f1_local0.rewardXP:setAlpha(0)
	f1_local0.rewardXP:setFont(CoD.fonts.ExtraSmall)
	f1_local0.rewardXP:setAlignment(LUI.Alignment.Center)
	f1_local0.slotListBackground:addElement(f1_local0.rewardXP)
	CoD.WeaponAttachmentChallenges.AddAttachments(f1_local0, f1_arg0, f1_local1)
	return f1_local0
end

CoD.WeaponAttachmentChallenges.GetSlotlistBackgroundWidth = function (f2_arg0)
	return CoD.CACAttachments.SlotListSpacing / 2 + CoD.CACAttachments.SlotListSize * f2_arg0 + CoD.CACAttachments.SlotListSpacing * (f2_arg0 - 1) + CoD.CACAttachments.SlotListSpacing / 2
end

CoD.WeaponAttachmentChallenges.AddAttachments = function (f3_arg0, f3_arg1, f3_arg2)
	f3_arg0.weaponItemIndex = f3_arg2
	f3_arg0.weaponImage:registerAnimationState("weapon_image", {
		material = RegisterMaterial(UIExpression.GetItemImage(nil, f3_arg0.weaponItemIndex) .. "_big")
	})
	f3_arg0.weaponImage:animateToState("weapon_image")
	local f3_local0 = Engine.GetNumAttachments(f3_arg0.weaponItemIndex)
	local f3_local1 = nil
	for f3_local2 = 1, f3_local0 - 1, 1 do
		local f3_local5 = CoD.AttachmentGridButton.new(f3_arg0.weaponItemIndex, f3_local2)
		f3_local5.actionSFX = nil
		f3_arg0.contentGrid:addButton(f3_local5)
		if f3_local1 == nil then
			f3_local1 = f3_local5
		end
		if Engine.GetItemAttachmentLocked(f3_arg1, f3_arg0.weaponItemIndex, f3_local2) ~= 0 then
			f3_local5:setLocked(true)
		else
			f3_local5:setLocked(false)
		end
	end
	f3_local1:processEvent({
		name = "gain_focus"
	})
end

CoD.WeaponAttachmentChallenges.ContentButtonHighlighted = function (f4_arg0, f4_arg1)
	if f4_arg1.contentIndex then
		f4_arg0.attachmentTitle:setText(Engine.Localize(Engine.GetAttachmentName(f4_arg0.weaponItemIndex, f4_arg1.contentIndex)))
		if f4_arg1.locked == true then
			f4_arg0.slotListBackground.border:show()
			f4_arg0.attachmentDescription:setText(CoD.AttachmentGridButton.GetRequiredGunLevel(f4_arg0.m_ownerController, f4_arg0.weaponItemIndex, f4_arg1.contentIndex))
			f4_arg0.slotListTitle:setText(Engine.Localize("MPUI_REWARDS"))
			f4_arg0.weaponAttributesList:beginAnimation("hide")
			f4_arg0.weaponAttributesList:setAlpha(0)
			f4_arg0.weaponLevel:show()
			f4_arg0.rewardImage:setImage(RegisterMaterial(Engine.GetAttachmentImage(f4_arg0.weaponItemIndex, f4_arg1.contentIndex)))
			f4_arg0.rewardImage:beginAnimation("show")
			f4_arg0.rewardImage:setAlpha(1)
			f4_arg0.rewardXP:setText(CoD.AttachmentGridButton.GetRewardXP(f4_arg0.m_ownerController, f4_arg0.weaponItemIndex, f4_arg1.contentIndex))
			f4_arg0.rewardXP:beginAnimation("show")
			f4_arg0.rewardXP:setAlpha(1)
		else
			f4_arg0.slotListBackground.border:hide()
			f4_arg0.attachmentDescription:setText(Engine.Localize(Engine.GetAttachmentDesc(f4_arg0.weaponItemIndex, f4_arg1.contentIndex)))
			f4_arg0.slotListTitle:setText("")
			f4_arg0.weaponLevel:hide()
			f4_arg0.rewardImage:beginAnimation("hide")
			f4_arg0.rewardImage:setAlpha(0)
			f4_arg0.rewardXP:beginAnimation("hide")
			f4_arg0.rewardXP:setAlpha(0)
			f4_arg0.weaponAttributesList:updateWeaponAttributes(f4_arg0.weaponItemIndex, f4_arg1.contentIndex)
			f4_arg0.weaponAttributesList:beginAnimation("show")
			f4_arg0.weaponAttributesList:setAlpha(1)
		end
	else
		f4_arg0.attachmentTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f4_arg0.attachmentDescription:setText("")
	end
end

