require("T6.AllocationBar")
require("T6.AllocationStatus")
require("T6.EquipNotification")
require("T6.CACGrenadesButton")
require("T6.CACWeaponButton")
require("T6.BonusCardTitle")
require("T6.BonusCardButton")
CoD.CustomClass = {}
CoD.CustomClass.MajorGridSpacing = 9
CoD.CustomClass.MinorGridSpacing = 9
CoD.CustomClass.AttachmentButtonSpacing = 9
CoD.CustomClass.BonusCardButtonSpacing = 9
CoD.CustomClass.ButtonHeight = 71
CoD.CustomClass.PrimaryWeaponButtonHeight = CoD.CustomClass.ButtonHeight * 2 + CoD.CustomClass.MinorGridSpacing
CoD.CustomClass.LeftSideButtonWidth = 500
CoD.CustomClass.RightSideButtonWidth = 864 - CoD.CustomClass.LeftSideButtonWidth + CoD.CustomClass.MajorGridSpacing
CoD.CustomClass.Width = CoD.CustomClass.LeftSideButtonWidth + CoD.CustomClass.MajorGridSpacing + CoD.CustomClass.RightSideButtonWidth
CoD.CustomClass.BonusCardGainFocusFunctions = {}
CoD.CustomClass.BonusCardLoseFocusFunctions = {}
CoD.CustomClass.New = function (f1_arg0, f1_arg1, f1_arg2)
	local Widget = LUI.UIElement.new(f1_arg0)
	Widget.m_inputDisabled = true
	Widget.preview = f1_arg1
	Widget.id = "CustomClass"
	Widget.restoreFocus = CoD.CustomClass.RestoreFocus
	Widget:registerEventHandler("bonus_card_gain_focus", CoD.CustomClass.BonusCardGainFocus)
	Widget:registerEventHandler("bonus_card_lose_focus", CoD.CustomClass.BonusCardLoseFocus)
	Widget:registerEventHandler("bonus_card_unequipped", CoD.CustomClass.BonusCardUnequipped)
	Widget:registerEventHandler("item_unequipped", CoD.CustomClass.ItemUnequipped)
	Widget:registerEventHandler("update_class", CoD.CustomClass.UpdateClass)
	CoD.CustomClass.AddWidgets(Widget, f1_arg1, f1_arg2)
	if f1_arg1 then
		Widget.processEvent = CoD.NullFunction
	end
	return Widget
end

CoD.CustomClass.AddWidgets = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = CoD.CustomClass.MajorGridSpacing
	local f2_local1 = CoD.CustomClass.MinorGridSpacing
	local f2_local2 = CoD.CustomClass.PrimaryWeaponButtonHeight
	local f2_local3 = CoD.CustomClass.ButtonHeight
	local f2_local4 = CoD.CustomClass.AttachmentButtonSpacing
	local f2_local5 = CoD.CustomClass.ButtonHeight
	local f2_local6 = CoD.CustomClass.LeftSideButtonWidth
	local f2_local7 = CoD.CustomClass.RightSideButtonWidth
	local f2_local8 = CoD.CustomClass.Width
	if f2_arg1 == true then
		f2_local6 = CoD.CustomClass.LeftSideButtonWidth - 80
		f2_local7 = CoD.CustomClass.RightSideButtonWidth - 30
		f2_local8 = f2_local6 + CoD.CustomClass.MajorGridSpacing + f2_local7
	end
	local f2_local9 = f2_local8
	local f2_local10 = f2_local9 - CoD.AllocationStatus.Width
	local f2_local11 = 3
	f2_arg0:addElement(CoD.AllocationStatus.new(f2_arg2, {
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local10,
		right = f2_local9,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local11 - CoD.AllocationStatus.Height,
		bottom = f2_local11
	}))
	local f2_local12 = f2_local8 - CoD.AllocationStatus.Width + 30
	local f2_local13 = 0
	local f2_local14 = 2
	f2_arg0:addElement(CoD.EquipNotification.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local13,
		right = f2_local12,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local14 - CoD.EquipNotification.Height,
		bottom = f2_local14
	}))
	local f2_local15 = 10
	local f2_local16 = f2_local11
	f2_arg0.allocationBar = CoD.AllocationBar.New(f2_arg2, f2_local8, {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f2_local8,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local16,
		bottom = f2_local16 + f2_local15
	})
	f2_arg0:addElement(f2_arg0.allocationBar)
	local f2_local17 = 0
	local f2_local18 = f2_local17 + f2_local6 + f2_local0
	local f2_local19 = f2_local15 + 15
	local f2_local20 = (f2_local2 + f2_local4 + f2_local5 - f2_local1 * 2) / 3
	local f2_local21 = f2_local3
	f2_arg0.primaryWeaponButton = CoD.CACWeaponButton.new(CoD.CACUtility.loadoutSlotNames.primaryWeapon, f2_local2, {
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local17,
		right = f2_local17 + f2_local6,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local19,
		bottom = f2_local19 + f2_local2
	})
	f2_arg0.primaryWeaponButton:setGainFocusSFX(CoD.CACUtility.GainFocusSFX)
	CoD.GrowingGridButton.SetPrimaryWeaponSubtitle(f2_arg0.primaryWeaponButton, "")
	f2_arg0.primaryWeaponButton.buttonRef = "primary"
	f2_arg0.primaryWeaponButton:registerEventHandler("gain_focus", CoD.CustomClass.Button_GainFocus)
	f2_arg0.primaryWeaponButton:registerEventHandler("button_over", CoD.CustomClass.PrimaryWeapon_Button_Over)
	f2_arg0.primaryWeaponButton:registerEventHandler("button_up", CoD.CustomClass.PrimaryWeapon_Button_Up)
	f2_arg0:addElement(f2_arg0.primaryWeaponButton)
	local f2_local22 = f2_local19
	f2_arg0.perk1Button = CoD.CACPerksButton.new(1, f2_local20, {
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local18,
		right = f2_local18 + f2_local7,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local22,
		bottom = f2_local22 + f2_local20
	})
	f2_arg0:addElement(f2_arg0.perk1Button)
	f2_arg0.perk1Button.buttonRef = "perkCategory1"
	f2_arg0.perk1Button:registerEventHandler("gain_focus", CoD.CustomClass.Perk12Button_GainFocus)
	f2_arg0.perk1Button:setTitle(Engine.Localize("MPUI_PERK1_CAPS"))
	f2_arg0.perk1Button:setSubtitle("")
	f2_arg0.perk1Button:setSubtitle2("")
	f2_arg0.perk1Button:setSlotListButtonGainFocusSFX(CoD.CACUtility.GainFocusSFX)
	f2_arg0.perk1Button.grid:setRGB(0, 0, 0)
	f2_local22 = f2_local22 + f2_local20 + f2_local1
	f2_arg0.perk2Button = CoD.CACPerksButton.new(2, f2_local20, {
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local18,
		right = f2_local18 + f2_local7,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local22,
		bottom = f2_local22 + f2_local20
	})
	f2_arg0:addElement(f2_arg0.perk2Button)
	f2_arg0.perk2Button.buttonRef = "perkCategory2"
	f2_arg0.perk2Button:registerEventHandler("gain_focus", CoD.CustomClass.Perk12Button_GainFocus)
	f2_arg0.perk2Button:setTitle(Engine.Localize("MPUI_PERK2_CAPS"))
	f2_arg0.perk2Button:setSubtitle("")
	f2_arg0.perk2Button:setSubtitle2("")
	f2_arg0.perk2Button:setSlotListButtonGainFocusSFX(CoD.CACUtility.GainFocusSFX)
	f2_arg0.perk2Button.grid:setRGB(0, 0, 0)
	f2_local22 = f2_local22 + f2_local20 + f2_local1
	f2_arg0.perk3Button = CoD.CACPerksButton.new(3, f2_local20, {
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local18,
		right = f2_local18 + f2_local7,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local22,
		bottom = f2_local22 + f2_local20
	})
	f2_arg0:addElement(f2_arg0.perk3Button)
	f2_arg0.perk3Button.buttonRef = "perkCategory3"
	f2_arg0.perk3Button:registerEventHandler("gain_focus", CoD.CustomClass.Button_GainFocus)
	f2_arg0.perk3Button:setTitle(Engine.Localize("MPUI_PERK3_CAPS"))
	f2_arg0.perk3Button:setSubtitle("")
	f2_arg0.perk3Button:setSubtitle2("")
	f2_arg0.perk3Button:setSlotListButtonGainFocusSFX(CoD.CACUtility.GainFocusSFX)
	f2_arg0.perk3Button.grid:setRGB(0, 0, 0)
	f2_local19 = f2_local19 + f2_local2 + f2_local4
	f2_arg0.primaryWeaponAttachmentsButton = CoD.CACAttachmentsButton.new(CoD.CACUtility.loadoutSlotNames.primaryWeapon, f2_local5, {
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local17,
		right = f2_local17 + f2_local6,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local19,
		bottom = f2_local19 + f2_local5
	})
	f2_arg0.primaryWeaponAttachmentsButton:setSlotListButtonGainFocusSFX(CoD.CACUtility.GainFocusSFX)
	f2_arg0.primaryWeaponAttachmentsButton.buttonRef = "primaryAttachments"
	f2_arg0.primaryWeaponAttachmentsButton:registerEventHandler("gain_focus", CoD.CustomClass.Button_GainFocus)
	f2_arg0:addElement(f2_arg0.primaryWeaponAttachmentsButton)
	f2_arg0.primaryWeaponAttachmentsButton.grid:setRGB(0, 0, 0)
	f2_local19 = f2_local19 + f2_local5 + f2_local0
	f2_arg0.secondaryWeaponButton = CoD.CACWeaponButton.new(CoD.CACUtility.loadoutSlotNames.secondaryWeapon, f2_local3, {
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local17,
		right = f2_local17 + f2_local6,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local19,
		bottom = f2_local19 + f2_local3
	})
	f2_arg0.secondaryWeaponButton:setGainFocusSFX(CoD.CACUtility.GainFocusSFX)
	CoD.GrowingGridButton.SetSecondaryWeaponSubtitle(f2_arg0.secondaryWeaponButton, "")
	f2_arg0.secondaryWeaponButton.buttonRef = "secondary"
	f2_arg0.secondaryWeaponButton:registerEventHandler("gain_focus", CoD.CustomClass.Button_GainFocus)
	f2_arg0.secondaryWeaponButton:registerEventHandler("button_over", CoD.CustomClass.SecondaryWeapon_Button_Over)
	f2_arg0.secondaryWeaponButton:registerEventHandler("button_up", CoD.CustomClass.SecondaryWeapon_Button_Up)
	f2_arg0:addElement(f2_arg0.secondaryWeaponButton)
	f2_arg0.lethalButton = CoD.CACGrenadesButton.new(CoD.CACUtility.loadoutSlotNames.primaryGrenade, f2_local21, {
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local18,
		right = f2_local18 + f2_local7,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local19,
		bottom = f2_local19 + f2_local21
	})
	f2_arg0.lethalButton:setTitle(Engine.Localize("MPUI_PRIMARY_GRENADE_CAPS"))
	f2_arg0.lethalButton:setSubtitle("")
	f2_arg0.lethalButton:setSubtitle2("")
	f2_arg0.lethalButton:setSlotListButtonGainFocusSFX(CoD.CACUtility.GainFocusSFX)
	f2_arg0.lethalButton.grid:setRGB(0, 0, 0)
	f2_arg0.lethalButton.buttonRef = "lethal"
	f2_arg0.lethalButton:registerEventHandler("gain_focus", CoD.CustomClass.Button_GainFocus)
	f2_arg0:addElement(f2_arg0.lethalButton)
	local f2_local23 = f2_local19 + f2_local21 + f2_local1
	f2_arg0.tacticalButton = CoD.CACGrenadesButton.new(CoD.CACUtility.loadoutSlotNames.specialGrenade, f2_local21, {
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local18,
		right = f2_local18 + f2_local7,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local23,
		bottom = f2_local23 + f2_local21
	})
	f2_arg0.tacticalButton:setTitle(Engine.Localize("MPUI_SPECIAL_GRENADE_CAPS"))
	f2_arg0.tacticalButton:setSubtitle("")
	f2_arg0.tacticalButton:setSubtitle2("")
	f2_arg0.tacticalButton:setSlotListButtonGainFocusSFX(CoD.CACUtility.GainFocusSFX)
	f2_arg0.tacticalButton.grid:setRGB(0, 0, 0)
	f2_arg0.tacticalButton.buttonRef = "tactical"
	f2_arg0.tacticalButton:registerEventHandler("gain_focus", CoD.CustomClass.Button_GainFocus)
	f2_arg0:addElement(f2_arg0.tacticalButton)
	f2_local19 = f2_local19 + f2_local3 + f2_local4
	f2_arg0.secondaryWeaponAttachmentsButton = CoD.CACAttachmentsButton.new(CoD.CACUtility.loadoutSlotNames.secondaryWeapon, f2_local5, {
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local17,
		right = f2_local17 + f2_local6,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local19,
		bottom = f2_local19 + f2_local5
	})
	f2_arg0.secondaryWeaponAttachmentsButton:setSlotListButtonGainFocusSFX(CoD.CACUtility.GainFocusSFX)
	f2_arg0.secondaryWeaponAttachmentsButton.buttonRef = "secondaryAttachments"
	f2_arg0.secondaryWeaponAttachmentsButton:registerEventHandler("gain_focus", CoD.CustomClass.Button_GainFocus)
	f2_arg0:addElement(f2_arg0.secondaryWeaponAttachmentsButton)
	f2_arg0.secondaryWeaponAttachmentsButton.grid:setRGB(0, 0, 0)
	f2_local19 = f2_local19 + f2_local21 + 5
	local f2_local24 = CoD.textSize.ExtraSmall
	f2_arg0.bonusCardTitle = CoD.BonusCardTitle.New({
		leftAnchor = true,
		rightAnchor = false,
		left = 2,
		right = 2 + f2_local8,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local19,
		bottom = f2_local19 + f2_local24,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		font = CoD.fonts.ExtraSmall
	})
	f2_arg0.bonusCardTitle:update(Engine.Localize("MENU_WILDCARDS_CAPS"))
	f2_arg0:addElement(f2_arg0.bonusCardTitle)
	if Engine.WeaponGroupHasNewItem(f2_arg2, "bonuscard") then
		local f2_local25, f2_local26, f2_local27, f2_local28 = GetTextDimensions(Engine.Localize("MENU_WILDCARDS_CAPS"), CoD.fonts.ExtraSmall, f2_local24)
		local f2_local29 = f2_local27 - f2_local25 + 10
		local f2_local30 = LUI.UIImage.new()
		f2_local30:setLeftRight(true, false, 2 + f2_local29, 2 + f2_local29 + CoD.CACUtility.ButtonGridNewImageWidth)
		f2_local30:setTopBottom(true, false, f2_local19 + f2_local24 / 2 - CoD.CACUtility.ButtonGridNewImageHeight / 2, f2_local19 + f2_local24 / 2 + CoD.CACUtility.ButtonGridNewImageHeight / 2)
		f2_local30:setImage(RegisterMaterial(CoD.CACUtility.NewImageMaterial))
		f2_arg0:addElement(f2_local30)
	end
	f2_local19 = f2_local19 + f2_local24 + 2
	local f2_local25 = f2_local17
	local f2_local26 = (f2_local8 - CoD.CustomClass.BonusCardButtonSpacing * (CoD.CACUtility.maxBonusCards - 1)) / CoD.CACUtility.maxBonusCards
	local f2_local27 = CoD.CustomClass.ButtonHeight
	f2_arg0.bonusCardButtons = {}
	for f2_local28 = 1, CoD.CACUtility.maxBonusCards, 1 do
		local f2_local31 = CoD.BonusCardButton.new(f2_local28, f2_local27, {
			leftAnchor = true,
			rightAnchor = false,
			left = f2_local25,
			right = f2_local25 + f2_local26,
			topAnchor = true,
			bottomAnchor = false,
			top = f2_local19,
			bottom = f2_local19 + f2_local27
		})
		table.insert(f2_arg0.bonusCardButtons, f2_local31)
		f2_arg0:addElement(f2_local31)
		f2_local31.buttonRef = "bonusCard" .. f2_local28
		f2_local31:registerEventHandler("gain_focus", CoD.CustomClass.BonusCardButton_GainFocus)
		f2_local31:setGainFocusSFX(CoD.CACUtility.WildcardGainFocusSFX)
		f2_local25 = f2_local25 + f2_local26 + CoD.CustomClass.BonusCardButtonSpacing
		if f2_local28 == CoD.CACUtility.maxBonusCards then
			CoD.GrowingGridButton.SetupUnequipButton(f2_local31, 5, 0, 20, 8)
		else
			CoD.GrowingGridButton.SetupUnequipButton(f2_local31, 5, 5, 20)
		end
	end
	f2_local19 = f2_local19 + CoD.BonusCardButton.Height + f2_local0 + 10
	f2_arg0.hintText = CoD.HintText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local17,
		right = f2_local17 + CoD.Menu.Width,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local19,
		bottom = f2_local19 + CoD.textSize.Default,
		font = CoD.fonts.Default,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b
	})
	f2_arg0:addElement(f2_arg0.hintText)
	f2_local19 = f2_local19 + CoD.textSize.Default
	f2_arg0.primaryWeaponButton.navigation.up = f2_arg0.bonusCardButtons[1]
	f2_arg0.primaryWeaponButton.navigation.down = f2_arg0.primaryWeaponAttachmentsButton
	f2_arg0.primaryWeaponButton.navigation.right = f2_arg0.perk1Button
	f2_arg0.primaryWeaponAttachmentsButton.navigation.up = f2_arg0.primaryWeaponButton
	f2_arg0.primaryWeaponAttachmentsButton.navigation.down = f2_arg0.secondaryWeaponButton
	f2_arg0.primaryWeaponAttachmentsButton.navigation.left = f2_arg0.perk3Button
	f2_arg0.primaryWeaponAttachmentsButton.navigation.right = f2_arg0.perk3Button
	f2_arg0.secondaryWeaponButton.navigation.up = f2_arg0.primaryWeaponAttachmentsButton
	f2_arg0.secondaryWeaponButton.navigation.down = f2_arg0.secondaryWeaponAttachmentsButton
	f2_arg0.secondaryWeaponButton.navigation.right = f2_arg0.lethalButton
	f2_arg0.secondaryWeaponAttachmentsButton.navigation.up = f2_arg0.secondaryWeaponButton
	f2_arg0.secondaryWeaponAttachmentsButton.navigation.down = f2_arg0.bonusCardButtons[1]
	f2_arg0.secondaryWeaponAttachmentsButton.navigation.right = f2_arg0.tacticalButton
	f2_arg0.perk1Button.navigation.up = f2_arg0.bonusCardButtons[3]
	f2_arg0.perk1Button.navigation.down = f2_arg0.perk2Button
	f2_arg0.perk1Button.navigation.left = f2_arg0.primaryWeaponButton
	f2_arg0.perk1Button.navigation.right = f2_arg0.primaryWeaponButton
	f2_arg0.perk2Button.navigation.up = f2_arg0.perk1Button
	f2_arg0.perk2Button.navigation.down = f2_arg0.perk3Button
	f2_arg0.perk2Button.navigation.left = f2_arg0.primaryWeaponButton
	f2_arg0.perk2Button.navigation.right = f2_arg0.primaryWeaponButton
	f2_arg0.perk3Button.navigation.up = f2_arg0.perk2Button
	f2_arg0.perk3Button.navigation.down = f2_arg0.lethalButton
	f2_arg0.perk3Button.navigation.left = f2_arg0.primaryWeaponAttachmentsButton
	f2_arg0.perk3Button.navigation.right = f2_arg0.primaryWeaponAttachmentsButton
	f2_arg0.lethalButton.navigation.up = f2_arg0.perk3Button
	f2_arg0.lethalButton.navigation.down = f2_arg0.tacticalButton
	f2_arg0.lethalButton.navigation.left = f2_arg0.secondaryWeaponButton
	f2_arg0.lethalButton.navigation.right = f2_arg0.secondaryWeaponButton
	f2_arg0.tacticalButton.navigation.up = f2_arg0.lethalButton
	f2_arg0.tacticalButton.navigation.down = f2_arg0.bonusCardButtons[3]
	f2_arg0.tacticalButton.navigation.left = f2_arg0.secondaryWeaponAttachmentsButton
	f2_arg0.tacticalButton.navigation.right = f2_arg0.secondaryWeaponAttachmentsButton
	f2_arg0.bonusCardButtons[1].navigation.up = f2_arg0.secondaryWeaponAttachmentsButton
	f2_arg0.bonusCardButtons[1].navigation.down = f2_arg0.primaryWeaponButton
	f2_arg0.bonusCardButtons[1].navigation.right = f2_arg0.bonusCardButtons[2]
	f2_arg0.bonusCardButtons[2].navigation.up = f2_arg0.secondaryWeaponAttachmentsButton
	f2_arg0.bonusCardButtons[2].navigation.down = f2_arg0.primaryWeaponButton
	f2_arg0.bonusCardButtons[2].navigation.left = f2_arg0.bonusCardButtons[1]
	f2_arg0.bonusCardButtons[2].navigation.right = f2_arg0.bonusCardButtons[3]
	f2_arg0.bonusCardButtons[3].navigation.up = f2_arg0.tacticalButton
	f2_arg0.bonusCardButtons[3].navigation.down = f2_arg0.perk1Button
	f2_arg0.bonusCardButtons[3].navigation.left = f2_arg0.bonusCardButtons[2]
end

CoD.CustomClass.UpdateClass = function (f3_arg0, f3_arg1)
	if f3_arg1 then
		f3_arg0.m_ownerController = f3_arg1.controller
		f3_arg0.classNum = f3_arg1.classNum
		f3_arg0.className = f3_arg1.className
	end
	local f3_local0 = f3_arg0.m_ownerController
	local f3_local1 = f3_arg0.classNum
	local f3_local2 = f3_arg0.className
	if f3_local2 then
		f3_local1 = Engine.GetClassIndexFromName(f3_local2)
	end
	f3_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f3_local0,
		classNum = f3_local1,
		class = Engine.GetCustomClass(f3_local0, f3_local1),
		preview = f3_arg0.preview
	})
end

CoD.CustomClass.RestoreFocus = function (f4_arg0, f4_arg1)
	local f4_local0 = CoD.perController[f4_arg0.m_ownerController]
	local f4_local1 = f4_local0.weaponSlot
	local f4_local2 = f4_local0.slotIndex
	local f4_local3 = f4_local0.grenadeSlot
	local f4_local4 = f4_local0.bonusCardSlot
	local f4_local5 = f4_local0.perkCategory
	local f4_local6 = f4_local0.slotIndex
	f4_local0.weaponSlot = nil
	f4_local0.grenadeSlot = nil
	f4_local0.bonusCardSlot = nil
	f4_local0.perkCategory = nil
	f4_local0.slotIndex = nil
	local f4_local7 = f4_local0.lastCustomClassButtonHighlightedRef
	f4_local0.lastCustomClassButtonHighlightedRef = nil
	f4_arg0.m_inputDisabled = nil
	if CoD.useController then
		if f4_local7 == "primary" then
			f4_arg0.primaryWeaponButton:processEvent({
				name = "gain_focus",
				controller = f4_arg1
			})
		elseif f4_local7 == "primaryAttachments" then
			f4_arg0.primaryWeaponAttachmentsButton:processEvent({
				name = "gain_focus",
				controller = f4_arg1
			})
		elseif f4_local7 == "secondary" then
			f4_arg0.secondaryWeaponButton:processEvent({
				name = "gain_focus",
				controller = f4_arg1
			})
		elseif f4_local7 == "secondaryAttachments" then
			f4_arg0.secondaryWeaponAttachmentsButton:processEvent({
				name = "gain_focus",
				controller = f4_arg1
			})
		elseif f4_local7 == "lethal" then
			f4_arg0.lethalButton:processEvent({
				name = "gain_focus",
				controller = f4_arg1
			})
		elseif f4_local7 == "tactical" then
			f4_arg0.tacticalButton:processEvent({
				name = "gain_focus",
				controller = f4_arg1
			})
		elseif f4_local7 == "perkCategory1" then
			f4_arg0.perk1Button:processEvent({
				name = "gain_focus",
				controller = f4_arg1
			})
		elseif f4_local7 == "perkCategory2" then
			f4_arg0.perk2Button:processEvent({
				name = "gain_focus",
				controller = f4_arg1
			})
		elseif f4_local7 == "perkCategory3" then
			f4_arg0.perk3Button:processEvent({
				name = "gain_focus",
				controller = f4_arg1
			})
		elseif f4_local7 == "bonusCard1" then
			f4_arg0.bonusCardButtons[1]:processEvent({
				name = "gain_focus",
				controller = f4_arg1
			})
		elseif f4_local7 == "bonusCard2" then
			f4_arg0.bonusCardButtons[2]:processEvent({
				name = "gain_focus",
				controller = f4_arg1
			})
		elseif f4_local7 == "bonusCard3" then
			f4_arg0.bonusCardButtons[3]:processEvent({
				name = "gain_focus",
				controller = f4_arg1
			})
		else
			f4_arg0.primaryWeaponButton:processEvent({
				name = "gain_focus",
				controller = f4_arg1
			})
		end
	end
end

CoD.CustomClass.PrimaryWeapon_Button_Over = function (f5_arg0, f5_arg1)
	if not Engine.IsBetaBuild() then
		local f5_local0 = "primary"
		local f5_local1 = Engine.GetCustomClass(f5_arg1.controller, CoD.perController[f5_arg1.controller].classNum)
		if f5_local1[f5_local0] ~= nil then
			CoD.perController[f5_arg1.controller].weaponSlot = f5_local0
			f5_arg0:dispatchEventToParent({
				name = "add_camo_button",
				controller = f5_arg1.controller,
				itemIndex = f5_local1[f5_local0]
			})
		end
	end
	CoD.CACWeaponButton.ButtonOver(f5_arg0, f5_arg1)
end

CoD.CustomClass.PrimaryWeapon_Button_Up = function (f6_arg0, f6_arg1)
	CoD.perController[f6_arg1.controller].weaponSlot = nil
	f6_arg0:dispatchEventToParent({
		name = "remove_camo_button",
		controller = f6_arg1.controller
	})
	CoD.CACWeaponButton.ButtonUp(f6_arg0, f6_arg1)
end

CoD.CustomClass.SecondaryWeapon_Button_Over = function (f7_arg0, f7_arg1)
	if not Engine.IsBetaBuild() then
		local f7_local0 = Engine.GetCustomClass(f7_arg1.controller, CoD.perController[f7_arg1.controller].classNum)
		local f7_local1 = "secondary"
		if f7_local0[f7_local1] ~= nil then
			CoD.perController[f7_arg1.controller].weaponSlot = f7_local1
			f7_arg0:dispatchEventToParent({
				name = "add_camo_button",
				controller = f7_arg1.controller,
				itemIndex = f7_local0[f7_local1]
			})
		end
	end
	CoD.CACWeaponButton.ButtonOver(f7_arg0, f7_arg1)
end

CoD.CustomClass.SecondaryWeapon_Button_Up = function (f8_arg0, f8_arg1)
	CoD.perController[f8_arg1.controller].weaponSlot = nil
	f8_arg0:dispatchEventToParent({
		name = "remove_camo_button",
		controller = f8_arg1.controller
	})
	CoD.CACWeaponButton.ButtonUp(f8_arg0, f8_arg1)
end

CoD.CustomClass.Button_GainFocus = function (f9_arg0, f9_arg1)
	CoD.perController[f9_arg1.controller].lastCustomClassButtonHighlightedRef = f9_arg0.buttonRef
	LUI.UIButton.gainFocus(f9_arg0, f9_arg1)
end

CoD.CustomClass.Perk12Button_GainFocus = function (f10_arg0, f10_arg1)
	CoD.CustomClass.Button_GainFocus(f10_arg0, f10_arg1)
	f10_arg0.navigation.left.navigation.right = f10_arg0
end

CoD.CustomClass.BonusCardButton_GainFocus = function (f11_arg0, f11_arg1)
	CoD.perController[f11_arg1.controller].lastCustomClassButtonHighlightedRef = f11_arg0.buttonRef
	CoD.BonusCardButton.GainFocus(f11_arg0, f11_arg1)
	f11_arg0.navigation.up.navigation.down = f11_arg0
	f11_arg0.navigation.down.navigation.up = f11_arg0
end

CoD.CustomClass.BonusCardGainFocus = function (f12_arg0, f12_arg1)
	CoD.SetPreviousAllocation(f12_arg0.m_ownerController)
	CoD.CustomClass.UpdateClass(f12_arg0)
	local f12_local0 = Engine.GetCustomClass(f12_arg0.m_ownerController, f12_arg0.classNum)
	if f12_local0["bonuscard" .. f12_arg1.bonusCardSlot] ~= nil then

	else

	end
end

CoD.CustomClass.BonusCardLoseFocus = function (f13_arg0, f13_arg1)
	CoD.SetPreviousAllocation(f13_arg0.m_ownerController)
	CoD.CustomClass.UpdateClass(f13_arg0)
	local f13_local0 = Engine.GetCustomClass(f13_arg0.m_ownerController, f13_arg0.classNum)
	if f13_local0["bonuscard" .. f13_arg1.bonusCardSlot] ~= nil then

	else

	end
end

CoD.CustomClass.BonusCardUnequipped = function (f14_arg0, f14_arg1)
	CoD.EquipNotification.AddToNotificationQueue("bonusCard", "unequipped", f14_arg1.cardName)
	CoD.CustomClass.UpdateClass(f14_arg0)
end

CoD.CustomClass.ItemUnequipped = function (f15_arg0, f15_arg1)
	Engine.PlaySound("cac_equipment_remove")
	CoD.CustomClass.UpdateClass(f15_arg0)
end

CoD.CustomClass.UpdateAttachmentSlotlistPreview = function (f16_arg0, f16_arg1, f16_arg2, f16_arg3, f16_arg4, f16_arg5)
	f16_arg1.slotList:update(f16_arg2 - f16_arg3, f16_arg3, CoD.SlotList.GetAttachmentImages(f16_arg0.m_ownerController, f16_arg0.classNum, f16_arg1.weaponStatName), false, f16_arg4, f16_arg5)
end

CoD.CustomClass.BonusCardGainFocusFunctions.bonuscard_primary_gunfighter = function (f17_arg0)

end

CoD.CustomClass.BonusCardLoseFocusFunctions.bonuscard_primary_gunfighter = function (f18_arg0)

end

CoD.CustomClass.BonusCardGainFocusFunctions.bonuscard_secondary_gunfighter = function (f19_arg0)
	local f19_local0 = CoD.CACUtility.IsBonusCardEquippedByName(Engine.GetCustomClass(f19_arg0.m_ownerController, f19_arg0.classNum), "bonuscard_secondary_gunfighter")
	local f19_local1 = 0
	local f19_local2 = 0
	if CoD.SlotList.GetAttachmentCountByStatName(f19_arg0.m_ownerController, f19_arg0.classNum, f19_arg0.secondaryWeaponAttachmentsButton.weaponStatName) > 0 then
		f19_local1 = 2
		f19_local2 = 1
	end
	CoD.CustomClass.UpdateAttachmentSlotlistPreview(f19_arg0, f19_arg0.secondaryWeaponAttachmentsButton, f19_local1, f19_local2, true, f19_local0)
end

CoD.CustomClass.BonusCardLoseFocusFunctions.bonuscard_secondary_gunfighter = function (f20_arg0)
	local f20_local0 = CoD.CACUtility.IsBonusCardEquippedByName(Engine.GetCustomClass(f20_arg0.m_ownerController, f20_arg0.classNum), "bonuscard_secondary_gunfighter")
	local f20_local1 = 0
	local f20_local2 = 0
	if CoD.SlotList.GetAttachmentCountByStatName(f20_arg0.m_ownerController, f20_arg0.classNum, f20_arg0.secondaryWeaponAttachmentsButton.weaponStatName) > 0 then
		f20_local1 = 1
	end
	if f20_local0 == true then
		f20_local2 = 1
	end
	CoD.CustomClass.UpdateAttachmentSlotlistPreview(f20_arg0, f20_arg0.secondaryWeaponAttachmentsButton, f20_local1 + f20_local2, f20_local2, false, f20_local0)
end

CoD.CustomClass.BonusCardGainFocusFunctions.bonuscard_overkill = function (f21_arg0)
	local f21_local0 = f21_arg0.m_ownerController
	local f21_local1 = f21_arg0.classNum
	f21_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f21_local0,
		classNum = f21_local1,
		class = Engine.GetCustomClass(f21_local0, f21_local1),
		preview = f21_arg0.preview,
		showBonuscardPreview = true
	})
end

CoD.CustomClass.BonusCardLoseFocusFunctions.bonuscard_overkill = function (f22_arg0)
	local f22_local0 = f22_arg0.m_ownerController
	local f22_local1 = f22_arg0.classNum
	f22_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f22_local0,
		classNum = f22_local1,
		class = Engine.GetCustomClass(f22_local0, f22_local1),
		preview = f22_arg0.preview,
		showBonuscardPreview = false
	})
end

CoD.CustomClass.UpdateGrenadeSlotlistPreview = function (f23_arg0, f23_arg1, f23_arg2, f23_arg3, f23_arg4, f23_arg5)
	f23_arg1.slotList:update(f23_arg2 - f23_arg3, f23_arg3, CoD.SlotList.GetGrenadeImages(f23_arg0.m_ownerController, f23_arg0.classNum, f23_arg1.weaponStatName, f23_arg2), false, f23_arg4, f23_arg5)
end

CoD.CustomClass.BonusCardGainFocusFunctions.bonuscard_danger_close = function (f24_arg0)
	CoD.CustomClass.UpdateGrenadeSlotlistPreview(f24_arg0, f24_arg0.lethalButton, 2, 1, true, CoD.CACUtility.IsBonusCardEquippedByName(Engine.GetCustomClass(f24_arg0.m_ownerController, f24_arg0.classNum), "bonuscard_danger_close"))
end

CoD.CustomClass.BonusCardLoseFocusFunctions.bonuscard_danger_close = function (f25_arg0)
	local f25_local0 = CoD.CACUtility.IsBonusCardEquippedByName(Engine.GetCustomClass(f25_arg0.m_ownerController, f25_arg0.classNum), "bonuscard_danger_close")
	local f25_local1 = 0
	if f25_local0 == true then
		f25_local1 = 1
	end
	CoD.CustomClass.UpdateGrenadeSlotlistPreview(f25_arg0, f25_arg0.lethalButton, 1 + f25_local1, f25_local1, false, f25_local0)
end

CoD.CustomClass.UpdatePerkSlotlistPreview = function (f26_arg0, f26_arg1, f26_arg2, f26_arg3, f26_arg4, f26_arg5)
	f26_arg1.slotList:update(f26_arg2 - f26_arg3, f26_arg3, CoD.SlotList.GetPerkImages(f26_arg1.perkCategory, f26_arg2, Engine.GetCustomClass(f26_arg0.m_ownerController, f26_arg0.classNum)), false, f26_arg4, f26_arg5)
end

CoD.CustomClass.BonusCardGainFocusFunctions.bonuscard_perk_1_greed = function (f27_arg0)
	CoD.CustomClass.UpdatePerkSlotlistPreview(f27_arg0, f27_arg0.perk1Button, 2, 1, true, CoD.CACUtility.IsBonusCardEquippedByName(Engine.GetCustomClass(f27_arg0.m_ownerController, f27_arg0.classNum), "bonuscard_perk_1_greed"))
end

CoD.CustomClass.BonusCardLoseFocusFunctions.bonuscard_perk_1_greed = function (f28_arg0)
	local f28_local0 = CoD.CACUtility.IsBonusCardEquippedByName(Engine.GetCustomClass(f28_arg0.m_ownerController, f28_arg0.classNum), "bonuscard_perk_1_greed")
	local f28_local1 = 0
	if f28_local0 == true then
		f28_local1 = 1
	end
	CoD.CustomClass.UpdatePerkSlotlistPreview(f28_arg0, f28_arg0.perk1Button, 1 + f28_local1, f28_local1, false, f28_local0)
end

CoD.CustomClass.BonusCardGainFocusFunctions.bonuscard_perk_2_greed = function (f29_arg0)
	CoD.CustomClass.UpdatePerkSlotlistPreview(f29_arg0, f29_arg0.perk2Button, 2, 1, true, CoD.CACUtility.IsBonusCardEquippedByName(Engine.GetCustomClass(f29_arg0.m_ownerController, f29_arg0.classNum), "bonuscard_perk_2_greed"))
end

CoD.CustomClass.BonusCardLoseFocusFunctions.bonuscard_perk_2_greed = function (f30_arg0)
	local f30_local0 = CoD.CACUtility.IsBonusCardEquippedByName(Engine.GetCustomClass(f30_arg0.m_ownerController, f30_arg0.classNum), "bonuscard_perk_2_greed")
	local f30_local1 = 0
	if f30_local0 == true then
		f30_local1 = 1
	end
	CoD.CustomClass.UpdatePerkSlotlistPreview(f30_arg0, f30_arg0.perk2Button, 1 + f30_local1, f30_local1, false, f30_local0)
end

CoD.CustomClass.BonusCardGainFocusFunctions.bonuscard_perk_3_greed = function (f31_arg0)
	CoD.CustomClass.UpdatePerkSlotlistPreview(f31_arg0, f31_arg0.perk3Button, 2, 1, true, CoD.CACUtility.IsBonusCardEquippedByName(Engine.GetCustomClass(f31_arg0.m_ownerController, f31_arg0.classNum), "bonuscard_perk_3_greed"))
end

CoD.CustomClass.BonusCardLoseFocusFunctions.bonuscard_perk_3_greed = function (f32_arg0)
	local f32_local0 = CoD.CACUtility.IsBonusCardEquippedByName(Engine.GetCustomClass(f32_arg0.m_ownerController, f32_arg0.classNum), "bonuscard_perk_3_greed")
	local f32_local1 = 0
	if f32_local0 == true then
		f32_local1 = 1
	end
	CoD.CustomClass.UpdatePerkSlotlistPreview(f32_arg0, f32_arg0.perk3Button, 1 + f32_local1, f32_local1, false, f32_local0)
end

CoD.CustomClass.SetupButtonImages = function (f33_arg0, f33_arg1, f33_arg2)
	f33_arg0.outline = CoD.Border.new(1, 1, 1, 1, 0.1)
	f33_arg0.outline:setPriority(-100)
	f33_arg0:addElement(f33_arg0.outline)
	f33_arg0.body = LUI.UIElement.new()
	f33_arg0.body.id = "UIElement.body"
	f33_arg0.body:setLeftRight(true, true, 0, 0)
	f33_arg0.body:setTopBottom(true, true, 0, 0)
	f33_arg0:addElement(f33_arg0.body)
	f33_arg0.body:registerAnimationState("small", {
		leftAnchor = true,
		rightAnchor = true,
		left = 100,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	local f33_local0 = LUI.UIImage.new()
	f33_local0.id = "UIImage.blackGrad"
	f33_local0:setLeftRight(true, true, 2, -2)
	f33_local0:setTopBottom(true, true, 1, -1)
	f33_local0:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f33_local0:setRGB(0, 0, 0)
	f33_local0:setAlpha(0.7)
	f33_local0:setPriority(-80)
	f33_arg0:addElement(f33_local0)
	if f33_arg1 ~= nil then
		local f33_local1 = 40
		f33_arg0.glowGradBack = LUI.UIImage.new()
		f33_arg0.glowGradBack.id = "UIImage.glowGradBack"
		f33_arg0.glowGradBack:setLeftRight(true, true, 1, -1)
		f33_arg0.glowGradBack:setTopBottom(false, true, -1 - f33_local1, -1)
		f33_arg0.glowGradBack:setImage(RegisterMaterial("menu_mp_cac_grad_stretch_add"))
		f33_arg0.glowGradBack:setRGB(f33_arg1.r, f33_arg1.g, f33_arg1.b)
		f33_arg0.glowGradBack:setAlpha(0.05)
		f33_arg0.glowGradBack:setPriority(-80)
		f33_arg0:addElement(f33_arg0.glowGradBack)
		f33_arg0.glowGradBack:registerAnimationState("equipped", {
			red = f33_arg1.r,
			green = f33_arg1.g,
			blue = f33_arg1.b,
			alpha = 0.05
		})
		f33_arg0.glowGradBack:registerAnimationState("unequipped", {
			red = f33_arg1.r,
			green = f33_arg1.g,
			blue = f33_arg1.b,
			alpha = 0
		})
		f33_arg0.glowGradBack:animateToState("unequipped")
	end
	if f33_arg2 ~= nil then
		local f33_local1 = 20
		f33_arg0.glowGradFront = LUI.UIImage.new()
		f33_arg0.glowGradFront.id = "UIImage.glowGradFront"
		f33_arg0.glowGradFront:setLeftRight(true, true, 1, -1)
		f33_arg0.glowGradFront:setTopBottom(false, true, -1 - f33_local1, -1)
		f33_arg0.glowGradFront:setImage(RegisterMaterial("menu_mp_cac_grad_stretch_add_v2"))
		f33_arg0.glowGradFront:setRGB(f33_arg2.r, f33_arg2.g, f33_arg2.b)
		f33_arg0.glowGradFront:setAlpha(0.05)
		f33_arg0.glowGradFront:setPriority(-80)
		f33_arg0:addElement(f33_arg0.glowGradFront)
		f33_arg0.glowGradFront:registerAnimationState("equipped", {
			red = f33_arg2.r,
			green = f33_arg2.g,
			blue = f33_arg2.b,
			alpha = 0.05
		})
		f33_arg0.glowGradFront:registerAnimationState("unequipped", {
			red = f33_arg2.r,
			green = f33_arg2.g,
			blue = f33_arg2.b,
			alpha = 0
		})
		f33_arg0.glowGradFront:animateToState("unequipped")
	end
	local f33_local1 = LUI.UIImage.new()
	f33_local1.id = "UIImage.whiteGrad"
	f33_local1:setLeftRight(true, true, 4, -4)
	f33_local1:setTopBottom(true, false, 3, 33)
	f33_local1:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f33_local1:setPriority(100)
	f33_local1:setAlpha(0.1)
	f33_arg0:addElement(f33_local1)
	f33_arg0.highlight = CoD.Border.new(1, CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b, 0)
	f33_arg0.highlight:setPriority(100)
	f33_arg0.highlight:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 0
	})
	f33_arg0.highlight:registerAnimationState("button_over", {
		alpha = 1
	})
	LUI.UIButton.SetupElement(f33_arg0.highlight)
	f33_arg0:addElement(f33_arg0.highlight)
end

CoD.CustomClass.AddBonusCardPreviewElements = function (f34_arg0)
	if f34_arg0.glowGradBack ~= nil then
		f34_arg0.glowGradBack:registerAnimationState("equipped", {
			red = CoD.BonusCardGridButton.glowBackColor.r,
			green = CoD.BonusCardGridButton.glowBackColor.g,
			blue = CoD.BonusCardGridButton.glowBackColor.b,
			alpha = 0.1
		})
	end
	if f34_arg0.glowGradFront ~= nil then
		f34_arg0.glowGradFront:registerAnimationState("equipped", {
			red = CoD.BOIIOrange.r,
			green = CoD.BOIIOrange.g,
			blue = CoD.BOIIOrange.b,
			alpha = 0.05
		})
	end
end

