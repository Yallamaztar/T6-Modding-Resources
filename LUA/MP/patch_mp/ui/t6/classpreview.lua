require("T6.AllocationBar")
require("T6.AllocationStatus")
require("T6.CACGrenadesButton")
require("T6.BonusCardButton")
require("T6.Menus.CACUtility")
require("T6.WeaponLevel")
CoD.ClassPreview = {}
CoD.ClassPreview.New = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget.m_inputDisabled = true
	Widget.id = "ClassPreview"
	Widget.width = InstanceRef
	Widget.update = CoD.ClassPreview.UpdateClass
	CoD.ClassPreview.AddWidgets(Widget, HudRef)
	return Widget
end

CoD.ClassPreview.GetCamoSwatch = function ()
	local f2_local0 = 5
	local f2_local1 = 50
	local f2_local2 = 50
	local f2_local3 = 30
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, 0, 0)
	Widget:setTopBottom(false, true, 0, 0)
	Widget:setUseStencil(true)
	
	local camoSwatchImage = LUI.UIImage.new()
	camoSwatchImage:setLeftRight(false, true, -140, 0)
	camoSwatchImage:setTopBottom(false, true, -70, 0)
	Widget:addElement(camoSwatchImage)
	Widget.camoSwatchImage = camoSwatchImage
	
	camoSwatchImage:hide()
	return Widget
end

CoD.ClassPreview.SetupMTXCamoSwatch = function (f3_arg0)
	f3_arg0.camoSwatchImage:setLeftRight(false, true, -32, 0)
	f3_arg0.camoSwatchImage:setTopBottom(false, true, -32, 0)
end

CoD.ClassPreview.SetupDefaultCamoSwatch = function (f4_arg0)
	f4_arg0.camoSwatchImage:setLeftRight(false, true, -140, 0)
	f4_arg0.camoSwatchImage:setTopBottom(false, true, -70, 0)
end

CoD.ClassPreview.AddWidgets = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.width
	local f5_local1 = f5_local0 - CoD.AllocationStatus.Width
	local f5_local2 = 5
	local f5_local3 = f5_local2 - CoD.AllocationStatus.Height
	f5_arg0.allocationStatus = CoD.AllocationStatus.new(f5_arg1)
	f5_arg0.allocationStatus:setLeftRight(true, false, f5_local1, f5_local0)
	f5_arg0.allocationStatus:setTopBottom(true, false, f5_local3, f5_local2)
	f5_arg0:addElement(f5_arg0.allocationStatus)
	local f5_local4 = 10
	local f5_local5 = f5_local2
	f5_arg0.allocationBar = CoD.AllocationBar.New(f5_arg1, f5_arg0.width)
	f5_arg0.allocationBar:setLeftRight(true, false, 0, f5_arg0.width)
	f5_arg0.allocationBar:setTopBottom(true, false, f5_local5, f5_local5 + f5_local4)
	f5_arg0:addElement(f5_arg0.allocationBar)
	local f5_local6 = 4
	local f5_local7 = 71
	local f5_local8 = 32
	local f5_local9 = (f5_arg0.width - f5_local6) * 0.53
	local f5_local10 = (f5_arg0.width - f5_local6) * 0.47
	local f5_local11 = f5_local9 / 2
	local f5_local12 = "ExtraSmall"
	local f5_local13 = CoD.fonts[f5_local12]
	local f5_local14 = CoD.textSize[f5_local12]
	local f5_local15 = "Condensed"
	local f5_local16 = CoD.fonts[f5_local15]
	local f5_local17 = CoD.textSize[f5_local15]
	local f5_local18 = 0
	local f5_local19 = f5_local18 + 3
	local f5_local20 = f5_local18 + f5_local9 + f5_local6
	local f5_local21 = f5_local20 + 3
	local f5_local22 = f5_local5 + f5_local4 + 15
	f5_arg0.primaryWeaponBackground = LUI.UIImage.new()
	f5_arg0.primaryWeaponBackground:setLeftRight(true, false, f5_local18, f5_local18 + f5_local9)
	f5_arg0.primaryWeaponBackground:setTopBottom(true, false, f5_local22, f5_local22 + f5_local11)
	f5_arg0.primaryWeaponBackground:setRGB(0, 0, 0)
	f5_arg0.primaryWeaponBackground:setAlpha(0.1)
	f5_arg0:addElement(f5_arg0.primaryWeaponBackground)
	f5_arg0.primaryWeaponBackgroundContainer = LUI.UIElement.new()
	f5_arg0.primaryWeaponBackgroundContainer:setLeftRight(true, false, f5_local18 - 2, f5_local18 - 2 + f5_local9)
	f5_arg0.primaryWeaponBackgroundContainer:setTopBottom(true, false, f5_local22, f5_local22 + f5_local11)
	f5_arg0:addElement(f5_arg0.primaryWeaponBackgroundContainer)
	if CoD.ShouldShowWeaponLevel() then
		f5_arg0.primaryWeaponLevelIconContainer = CoD.WeaponLevel.GetWeaponLevelIcon(40, 40, "ExtraSmall", 0, 1, 1)
		f5_arg0.primaryWeaponBackgroundContainer:addElement(f5_arg0.primaryWeaponLevelIconContainer)
		f5_arg0.primaryWeaponLevelIconContainer:hide()
	end
	f5_arg0:addElement(f5_arg0.primaryWeaponBackgroundContainer)
	f5_arg0.primaryWeaponSlotNameLabel = LUI.UIText.new()
	f5_arg0.primaryWeaponSlotNameLabel:setLeftRight(true, false, f5_local19, f5_local19 + f5_local9)
	f5_arg0.primaryWeaponSlotNameLabel:setTopBottom(true, false, f5_local22, f5_local22 + f5_local14)
	f5_arg0.primaryWeaponSlotNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.primaryWeaponSlotNameLabel:setAlpha(0.5)
	f5_arg0.primaryWeaponSlotNameLabel:setFont(f5_local13)
	f5_arg0.primaryWeaponSlotNameLabel:setAlignment(LUI.Alignment.Left)
	f5_arg0.primaryWeaponSlotNameLabel:setText(Engine.Localize("MPUI_PRIMARY_CAPS"))
	f5_arg0:addElement(f5_arg0.primaryWeaponSlotNameLabel)
	local f5_local23 = 50
	local f5_local24 = f5_local11 * 0.9
	local f5_local25 = f5_local24 * 1.8
	f5_arg0.primaryWeaponImage = LUI.UIImage.new()
	f5_arg0.primaryWeaponImage:setLeftRight(true, false, f5_local18 + f5_local9 - f5_local25 - f5_local23, f5_local18 + f5_local9 - f5_local23)
	f5_arg0.primaryWeaponImage:setTopBottom(true, false, f5_local22, f5_local22 + f5_local24)
	f5_arg0.primaryWeaponImage:setAlpha(0)
	f5_arg0:addElement(f5_arg0.primaryWeaponImage)
	local f5_local26 = 45
	local f5_local27 = 5
	local f5_local28 = 31
	local f5_local29 = 31
	local f5_local30 = CoD.ClassPreview.GetCamoSwatch()
	f5_local30:setLeftRight(false, true, -f5_local26 - f5_local28, -f5_local26)
	f5_local30:setTopBottom(false, true, -f5_local27 - f5_local29, -f5_local27)
	f5_arg0.primaryCamoImageContainer = f5_local30
	f5_arg0.primaryWeaponBackgroundContainer:addElement(f5_local30)
	local f5_local31 = f5_local18 + f5_local9 - f5_local25 / 2 - f5_local8 / 2
	local f5_local32 = f5_local22 + f5_local11 / 2 - f5_local8 / 2
	f5_arg0.primaryWeaponRestrictedImage = LUI.UIImage.new()
	f5_arg0.primaryWeaponRestrictedImage:setLeftRight(true, false, f5_local31, f5_local31 + f5_local8)
	f5_arg0.primaryWeaponRestrictedImage:setTopBottom(true, false, f5_local32, f5_local32 + f5_local8)
	f5_arg0.primaryWeaponRestrictedImage:setAlpha(0)
	f5_arg0.primaryWeaponRestrictedImage:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.primaryWeaponRestrictedImage)
	f5_arg0.primaryWeaponNameLabel = LUI.UIText.new()
	f5_arg0.primaryWeaponNameLabel:setLeftRight(true, false, f5_local19, f5_local19 + f5_local9)
	f5_arg0.primaryWeaponNameLabel:setTopBottom(true, false, f5_local22 + f5_local11 - f5_local17, f5_local22 + f5_local11)
	f5_arg0.primaryWeaponNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.primaryWeaponNameLabel:setAlpha(1)
	f5_arg0.primaryWeaponNameLabel:setFont(f5_local16)
	f5_arg0.primaryWeaponNameLabel:setAlignment(LUI.Alignment.Left)
	f5_arg0.primaryWeaponNameLabel:setText("")
	f5_arg0:addElement(f5_arg0.primaryWeaponNameLabel)
	local f5_local33 = f5_local22
	local f5_local34 = (f5_local11 + f5_local6 + f5_local7 - f5_local6 * 2) / 3
	f5_arg0.perk1Background = LUI.UIImage.new()
	f5_arg0.perk1Background:setLeftRight(true, false, f5_local20, f5_local20 + f5_local10)
	f5_arg0.perk1Background:setTopBottom(true, false, f5_local33, f5_local33 + f5_local34)
	f5_arg0.perk1Background:setRGB(0, 0, 0)
	f5_arg0.perk1Background:setAlpha(0.1)
	f5_arg0:addElement(f5_arg0.perk1Background)
	f5_arg0.perk1SlotNameLabel = LUI.UIText.new()
	f5_arg0.perk1SlotNameLabel:setLeftRight(true, false, f5_local21, f5_local21 + f5_local10)
	f5_arg0.perk1SlotNameLabel:setTopBottom(true, false, f5_local33, f5_local33 + f5_local14)
	f5_arg0.perk1SlotNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.perk1SlotNameLabel:setAlpha(0.5)
	f5_arg0.perk1SlotNameLabel:setFont(f5_local13)
	f5_arg0.perk1SlotNameLabel:setAlignment(LUI.Alignment.Left)
	f5_arg0.perk1SlotNameLabel:setText(Engine.Localize("MPUI_PERK1_CAPS"))
	f5_arg0:addElement(f5_arg0.perk1SlotNameLabel)
	local f5_local35 = f5_local34
	local f5_local36 = 0
	local f5_local37 = f5_local20 + f5_local10 - f5_local35 * 2 - f5_local36 * 2
	local f5_local38 = f5_local20 + f5_local10 - f5_local35 * 1 - f5_local36 * 1
	f5_arg0.perk1Image1 = LUI.UIImage.new()
	f5_arg0.perk1Image1:setLeftRight(true, false, f5_local37, f5_local37 + f5_local35)
	f5_arg0.perk1Image1:setTopBottom(true, false, f5_local33, f5_local33 + f5_local35)
	f5_arg0.perk1Image1:setAlpha(0)
	f5_arg0:addElement(f5_arg0.perk1Image1)
	f5_arg0.perk1Image2 = LUI.UIImage.new()
	f5_arg0.perk1Image2:setLeftRight(true, false, f5_local38, f5_local38 + f5_local35)
	f5_arg0.perk1Image2:setTopBottom(true, false, f5_local33, f5_local33 + f5_local35)
	f5_arg0.perk1Image2:setAlpha(0)
	f5_arg0:addElement(f5_arg0.perk1Image2)
	local f5_local39 = f5_local37 + f5_local35 / 2 - f5_local8 / 2
	local f5_local40 = f5_local38 + f5_local35 / 2 - f5_local8 / 2
	local f5_local41 = f5_local33 + f5_local35 / 2 - f5_local8 / 2
	f5_arg0.perk1RestrictedImage1 = LUI.UIImage.new()
	f5_arg0.perk1RestrictedImage1:setLeftRight(true, false, f5_local39, f5_local39 + f5_local8)
	f5_arg0.perk1RestrictedImage1:setTopBottom(true, false, f5_local41, f5_local41 + f5_local8)
	f5_arg0.perk1RestrictedImage1:setAlpha(0)
	f5_arg0.perk1RestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.perk1RestrictedImage1)
	f5_arg0.perk1RestrictedImage2 = LUI.UIImage.new()
	f5_arg0.perk1RestrictedImage2:setLeftRight(true, false, f5_local40, f5_local40 + f5_local8)
	f5_arg0.perk1RestrictedImage2:setTopBottom(true, false, f5_local41, f5_local41 + f5_local8)
	f5_arg0.perk1RestrictedImage2:setAlpha(0)
	f5_arg0.perk1RestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.perk1RestrictedImage2)
	local f5_local42 = f5_local33 + f5_local14
	f5_arg0.perk1NameLabel1 = LUI.UIText.new()
	f5_arg0.perk1NameLabel1:setLeftRight(true, false, f5_local21, f5_local21 + f5_local10)
	f5_arg0.perk1NameLabel1:setTopBottom(true, false, f5_local42, f5_local42 + f5_local14)
	f5_arg0.perk1NameLabel1:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.perk1NameLabel1:setAlpha(1)
	f5_arg0.perk1NameLabel1:setFont(f5_local13)
	f5_arg0.perk1NameLabel1:setAlignment(LUI.Alignment.Left)
	f5_arg0.perk1NameLabel1:setText("")
	f5_arg0:addElement(f5_arg0.perk1NameLabel1)
	f5_local42 = f5_local42 + f5_local14
	f5_arg0.perk1NameLabel2 = LUI.UIText.new()
	f5_arg0.perk1NameLabel2:setLeftRight(true, false, f5_local21, f5_local21 + f5_local10)
	f5_arg0.perk1NameLabel2:setTopBottom(true, false, f5_local42, f5_local42 + f5_local14)
	f5_arg0.perk1NameLabel2:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.perk1NameLabel2:setAlpha(1)
	f5_arg0.perk1NameLabel2:setFont(f5_local13)
	f5_arg0.perk1NameLabel2:setAlignment(LUI.Alignment.Left)
	f5_arg0.perk1NameLabel2:setText("")
	f5_arg0:addElement(f5_arg0.perk1NameLabel2)
	f5_local33 = f5_local33 + f5_local34 + f5_local6
	f5_arg0.perk2Background = LUI.UIImage.new()
	f5_arg0.perk2Background:setLeftRight(true, false, f5_local20, f5_local20 + f5_local10)
	f5_arg0.perk2Background:setTopBottom(true, false, f5_local33, f5_local33 + f5_local34)
	f5_arg0.perk2Background:setRGB(0, 0, 0)
	f5_arg0.perk2Background:setAlpha(0.1)
	f5_arg0:addElement(f5_arg0.perk2Background)
	f5_arg0.perk2SlotNameLabel = LUI.UIText.new()
	f5_arg0.perk2SlotNameLabel:setLeftRight(true, false, f5_local21, f5_local21 + f5_local10)
	f5_arg0.perk2SlotNameLabel:setTopBottom(true, false, f5_local33, f5_local33 + f5_local14)
	f5_arg0.perk2SlotNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.perk2SlotNameLabel:setAlpha(0.5)
	f5_arg0.perk2SlotNameLabel:setFont(f5_local13)
	f5_arg0.perk2SlotNameLabel:setAlignment(LUI.Alignment.Left)
	f5_arg0.perk2SlotNameLabel:setText(Engine.Localize("MPUI_PERK2_CAPS"))
	f5_arg0:addElement(f5_arg0.perk2SlotNameLabel)
	f5_arg0.perk2Image1 = LUI.UIImage.new()
	f5_arg0.perk2Image1:setLeftRight(true, false, f5_local37, f5_local37 + f5_local35)
	f5_arg0.perk2Image1:setTopBottom(true, false, f5_local33, f5_local33 + f5_local35)
	f5_arg0.perk2Image1:setAlpha(0)
	f5_arg0:addElement(f5_arg0.perk2Image1)
	f5_arg0.perk2Image2 = LUI.UIImage.new()
	f5_arg0.perk2Image2:setLeftRight(true, false, f5_local38, f5_local38 + f5_local35)
	f5_arg0.perk2Image2:setTopBottom(true, false, f5_local33, f5_local33 + f5_local35)
	f5_arg0.perk2Image2:setAlpha(0)
	f5_arg0:addElement(f5_arg0.perk2Image2)
	f5_local41 = f5_local33 + f5_local35 / 2 - f5_local8 / 2
	f5_arg0.perk2RestrictedImage1 = LUI.UIImage.new()
	f5_arg0.perk2RestrictedImage1:setLeftRight(true, false, f5_local39, f5_local39 + f5_local8)
	f5_arg0.perk2RestrictedImage1:setTopBottom(true, false, f5_local41, f5_local41 + f5_local8)
	f5_arg0.perk2RestrictedImage1:setAlpha(0)
	f5_arg0.perk2RestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.perk2RestrictedImage1)
	f5_arg0.perk2RestrictedImage2 = LUI.UIImage.new()
	f5_arg0.perk2RestrictedImage2:setLeftRight(true, false, f5_local40, f5_local40 + f5_local8)
	f5_arg0.perk2RestrictedImage2:setTopBottom(true, false, f5_local41, f5_local41 + f5_local8)
	f5_arg0.perk2RestrictedImage2:setAlpha(0)
	f5_arg0.perk2RestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.perk2RestrictedImage2)
	f5_local42 = f5_local33 + f5_local14
	f5_arg0.perk2NameLabel1 = LUI.UIText.new()
	f5_arg0.perk2NameLabel1:setLeftRight(true, false, f5_local21, f5_local21 + f5_local10)
	f5_arg0.perk2NameLabel1:setTopBottom(true, false, f5_local42, f5_local42 + f5_local14)
	f5_arg0.perk2NameLabel1:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.perk2NameLabel1:setAlpha(1)
	f5_arg0.perk2NameLabel1:setFont(f5_local13)
	f5_arg0.perk2NameLabel1:setAlignment(LUI.Alignment.Left)
	f5_arg0.perk2NameLabel1:setText("")
	f5_arg0:addElement(f5_arg0.perk2NameLabel1)
	f5_local42 = f5_local42 + f5_local14
	f5_arg0.perk2NameLabel2 = LUI.UIText.new()
	f5_arg0.perk2NameLabel2:setLeftRight(true, false, f5_local21, f5_local21 + f5_local10)
	f5_arg0.perk2NameLabel2:setTopBottom(true, false, f5_local42, f5_local42 + f5_local14)
	f5_arg0.perk2NameLabel2:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.perk2NameLabel2:setAlpha(1)
	f5_arg0.perk2NameLabel2:setFont(f5_local13)
	f5_arg0.perk2NameLabel2:setAlignment(LUI.Alignment.Left)
	f5_arg0.perk2NameLabel2:setText("")
	f5_arg0:addElement(f5_arg0.perk2NameLabel2)
	f5_local33 = f5_local33 + f5_local34 + f5_local6
	f5_arg0.perk3Background = LUI.UIImage.new()
	f5_arg0.perk3Background:setLeftRight(true, false, f5_local20, f5_local20 + f5_local10)
	f5_arg0.perk3Background:setTopBottom(true, false, f5_local33, f5_local33 + f5_local34)
	f5_arg0.perk3Background:setRGB(0, 0, 0)
	f5_arg0.perk3Background:setAlpha(0.1)
	f5_arg0:addElement(f5_arg0.perk3Background)
	f5_arg0.perk3SlotNameLabel = LUI.UIText.new()
	f5_arg0.perk3SlotNameLabel:setLeftRight(true, false, f5_local21, f5_local21 + f5_local10)
	f5_arg0.perk3SlotNameLabel:setTopBottom(true, false, f5_local33, f5_local33 + f5_local14)
	f5_arg0.perk3SlotNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.perk3SlotNameLabel:setAlpha(0.5)
	f5_arg0.perk3SlotNameLabel:setFont(f5_local13)
	f5_arg0.perk3SlotNameLabel:setAlignment(LUI.Alignment.Left)
	f5_arg0.perk3SlotNameLabel:setText(Engine.Localize("MPUI_PERK3_CAPS"))
	f5_arg0:addElement(f5_arg0.perk3SlotNameLabel)
	f5_arg0.perk3Image1 = LUI.UIImage.new()
	f5_arg0.perk3Image1:setLeftRight(true, false, f5_local37, f5_local37 + f5_local35)
	f5_arg0.perk3Image1:setTopBottom(true, false, f5_local33, f5_local33 + f5_local35)
	f5_arg0.perk3Image1:setAlpha(0)
	f5_arg0:addElement(f5_arg0.perk3Image1)
	f5_arg0.perk3Image2 = LUI.UIImage.new()
	f5_arg0.perk3Image2:setLeftRight(true, false, f5_local38, f5_local38 + f5_local35)
	f5_arg0.perk3Image2:setTopBottom(true, false, f5_local33, f5_local33 + f5_local35)
	f5_arg0.perk3Image2:setAlpha(0)
	f5_arg0:addElement(f5_arg0.perk3Image2)
	f5_local41 = f5_local33 + f5_local35 / 2 - f5_local8 / 2
	f5_arg0.perk3RestrictedImage1 = LUI.UIImage.new()
	f5_arg0.perk3RestrictedImage1:setLeftRight(true, false, f5_local39, f5_local39 + f5_local8)
	f5_arg0.perk3RestrictedImage1:setTopBottom(true, false, f5_local41, f5_local41 + f5_local8)
	f5_arg0.perk3RestrictedImage1:setAlpha(0)
	f5_arg0.perk3RestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.perk3RestrictedImage1)
	f5_arg0.perk3RestrictedImage2 = LUI.UIImage.new()
	f5_arg0.perk3RestrictedImage2:setLeftRight(true, false, f5_local40, f5_local40 + f5_local8)
	f5_arg0.perk3RestrictedImage2:setTopBottom(true, false, f5_local41, f5_local41 + f5_local8)
	f5_arg0.perk3RestrictedImage2:setAlpha(0)
	f5_arg0.perk3RestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.perk3RestrictedImage2)
	f5_local42 = f5_local33 + f5_local14
	f5_arg0.perk3NameLabel1 = LUI.UIText.new()
	f5_arg0.perk3NameLabel1:setLeftRight(true, false, f5_local21, f5_local21 + f5_local10)
	f5_arg0.perk3NameLabel1:setTopBottom(true, false, f5_local42, f5_local42 + f5_local14)
	f5_arg0.perk3NameLabel1:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.perk3NameLabel1:setAlpha(1)
	f5_arg0.perk3NameLabel1:setFont(f5_local13)
	f5_arg0.perk3NameLabel1:setAlignment(LUI.Alignment.Left)
	f5_arg0.perk3NameLabel1:setText("")
	f5_arg0:addElement(f5_arg0.perk3NameLabel1)
	f5_local42 = f5_local42 + f5_local14
	f5_arg0.perk3NameLabel2 = LUI.UIText.new()
	f5_arg0.perk3NameLabel2:setLeftRight(true, false, f5_local21, f5_local21 + f5_local10)
	f5_arg0.perk3NameLabel2:setTopBottom(true, false, f5_local42, f5_local42 + f5_local14)
	f5_arg0.perk3NameLabel2:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.perk3NameLabel2:setAlpha(1)
	f5_arg0.perk3NameLabel2:setFont(f5_local13)
	f5_arg0.perk3NameLabel2:setAlignment(LUI.Alignment.Left)
	f5_arg0.perk3NameLabel2:setText("")
	f5_arg0:addElement(f5_arg0.perk3NameLabel2)
	f5_local22 = f5_local22 + f5_local11 + f5_local6
	f5_arg0.primaryWeaponAttachmentsBackground = LUI.UIImage.new()
	f5_arg0.primaryWeaponAttachmentsBackground:setLeftRight(true, false, f5_local18, f5_local18 + f5_local9)
	f5_arg0.primaryWeaponAttachmentsBackground:setTopBottom(true, false, f5_local22, f5_local22 + f5_local7)
	f5_arg0.primaryWeaponAttachmentsBackground:setRGB(0, 0, 0)
	f5_arg0.primaryWeaponAttachmentsBackground:setAlpha(0.1)
	f5_arg0:addElement(f5_arg0.primaryWeaponAttachmentsBackground)
	local f5_local43 = 5
	local f5_local44 = f5_local7 - f5_local43 * 2
	local f5_local45 = f5_local6
	local f5_local46 = f5_local18 + f5_local9 - f5_local44 * 3 - f5_local45 * 3
	local f5_local47 = f5_local18 + f5_local9 - f5_local44 * 2 - f5_local45 * 2
	local f5_local48 = f5_local18 + f5_local9 - f5_local44 * 1 - f5_local45 * 1
	f5_arg0.primaryWeaponAttachmentsImage1 = LUI.UIImage.new()
	f5_arg0.primaryWeaponAttachmentsImage1:setLeftRight(true, false, f5_local46, f5_local46 + f5_local44)
	f5_arg0.primaryWeaponAttachmentsImage1:setTopBottom(true, false, f5_local22 + f5_local43, f5_local22 + f5_local43 + f5_local44)
	f5_arg0.primaryWeaponAttachmentsImage1:setAlpha(0)
	f5_arg0:addElement(f5_arg0.primaryWeaponAttachmentsImage1)
	f5_arg0.primaryWeaponAttachmentsImage2 = LUI.UIImage.new()
	f5_arg0.primaryWeaponAttachmentsImage2:setLeftRight(true, false, f5_local47, f5_local47 + f5_local44)
	f5_arg0.primaryWeaponAttachmentsImage2:setTopBottom(true, false, f5_local22 + f5_local43, f5_local22 + f5_local43 + f5_local44)
	f5_arg0.primaryWeaponAttachmentsImage2:setAlpha(0)
	f5_arg0:addElement(f5_arg0.primaryWeaponAttachmentsImage2)
	f5_arg0.primaryWeaponAttachmentsImage3 = LUI.UIImage.new()
	f5_arg0.primaryWeaponAttachmentsImage3:setLeftRight(true, false, f5_local48, f5_local48 + f5_local44)
	f5_arg0.primaryWeaponAttachmentsImage3:setTopBottom(true, false, f5_local22 + f5_local43, f5_local22 + f5_local43 + f5_local44)
	f5_arg0.primaryWeaponAttachmentsImage3:setAlpha(0)
	f5_arg0:addElement(f5_arg0.primaryWeaponAttachmentsImage3)
	local f5_local49 = f5_local46 + f5_local44 / 2 - f5_local8 / 2
	local f5_local50 = f5_local47 + f5_local44 / 2 - f5_local8 / 2
	local f5_local51 = f5_local48 + f5_local44 / 2 - f5_local8 / 2
	local f5_local52 = f5_local22 + f5_local43 + f5_local44 / 2 - f5_local8 / 2
	f5_arg0.primaryWeaponAttachmentsRestrictedImage1 = LUI.UIImage.new()
	f5_arg0.primaryWeaponAttachmentsRestrictedImage1:setLeftRight(true, false, f5_local49, f5_local49 + f5_local8)
	f5_arg0.primaryWeaponAttachmentsRestrictedImage1:setTopBottom(true, false, f5_local52, f5_local52 + f5_local8)
	f5_arg0.primaryWeaponAttachmentsRestrictedImage1:setAlpha(0)
	f5_arg0.primaryWeaponAttachmentsRestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.primaryWeaponAttachmentsRestrictedImage1)
	f5_arg0.primaryWeaponAttachmentsRestrictedImage2 = LUI.UIImage.new()
	f5_arg0.primaryWeaponAttachmentsRestrictedImage2:setLeftRight(true, false, f5_local50, f5_local50 + f5_local8)
	f5_arg0.primaryWeaponAttachmentsRestrictedImage2:setTopBottom(true, false, f5_local52, f5_local52 + f5_local8)
	f5_arg0.primaryWeaponAttachmentsRestrictedImage2:setAlpha(0)
	f5_arg0.primaryWeaponAttachmentsRestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.primaryWeaponAttachmentsRestrictedImage2)
	f5_arg0.primaryWeaponAttachmentsRestrictedImage3 = LUI.UIImage.new()
	f5_arg0.primaryWeaponAttachmentsRestrictedImage3:setLeftRight(true, false, f5_local51, f5_local51 + f5_local8)
	f5_arg0.primaryWeaponAttachmentsRestrictedImage3:setTopBottom(true, false, f5_local52, f5_local52 + f5_local8)
	f5_arg0.primaryWeaponAttachmentsRestrictedImage3:setAlpha(0)
	f5_arg0.primaryWeaponAttachmentsRestrictedImage3:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.primaryWeaponAttachmentsRestrictedImage3)
	local f5_local53 = f5_local22
	f5_arg0.primaryWeaponAttachmentsNameLabel1 = LUI.UIText.new()
	f5_arg0.primaryWeaponAttachmentsNameLabel1:setLeftRight(true, false, f5_local19, f5_local19 + f5_local9)
	f5_arg0.primaryWeaponAttachmentsNameLabel1:setTopBottom(true, false, f5_local53, f5_local53 + f5_local14)
	f5_arg0.primaryWeaponAttachmentsNameLabel1:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.primaryWeaponAttachmentsNameLabel1:setAlpha(1)
	f5_arg0.primaryWeaponAttachmentsNameLabel1:setFont(f5_local13)
	f5_arg0.primaryWeaponAttachmentsNameLabel1:setAlignment(LUI.Alignment.Left)
	f5_arg0.primaryWeaponAttachmentsNameLabel1:setText("")
	f5_arg0:addElement(f5_arg0.primaryWeaponAttachmentsNameLabel1)
	f5_local53 = f5_local53 + f5_local14
	f5_arg0.primaryWeaponAttachmentsNameLabel2 = LUI.UIText.new()
	f5_arg0.primaryWeaponAttachmentsNameLabel2:setLeftRight(true, false, f5_local19, f5_local19 + f5_local9)
	f5_arg0.primaryWeaponAttachmentsNameLabel2:setTopBottom(true, false, f5_local53, f5_local53 + f5_local14)
	f5_arg0.primaryWeaponAttachmentsNameLabel2:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.primaryWeaponAttachmentsNameLabel2:setAlpha(1)
	f5_arg0.primaryWeaponAttachmentsNameLabel2:setFont(f5_local13)
	f5_arg0.primaryWeaponAttachmentsNameLabel2:setAlignment(LUI.Alignment.Left)
	f5_arg0.primaryWeaponAttachmentsNameLabel2:setText("")
	f5_arg0:addElement(f5_arg0.primaryWeaponAttachmentsNameLabel2)
	f5_local53 = f5_local53 + f5_local14
	f5_arg0.primaryWeaponAttachmentsNameLabel3 = LUI.UIText.new()
	f5_arg0.primaryWeaponAttachmentsNameLabel3:setLeftRight(true, false, f5_local19, f5_local19 + f5_local9)
	f5_arg0.primaryWeaponAttachmentsNameLabel3:setTopBottom(true, false, f5_local53, f5_local53 + f5_local14)
	f5_arg0.primaryWeaponAttachmentsNameLabel3:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.primaryWeaponAttachmentsNameLabel3:setAlpha(1)
	f5_arg0.primaryWeaponAttachmentsNameLabel3:setFont(f5_local13)
	f5_arg0.primaryWeaponAttachmentsNameLabel3:setAlignment(LUI.Alignment.Left)
	f5_arg0.primaryWeaponAttachmentsNameLabel3:setText("")
	f5_arg0:addElement(f5_arg0.primaryWeaponAttachmentsNameLabel3)
	f5_local22 = f5_local22 + f5_local7 + f5_local6
	f5_arg0.secondaryWeaponBackground = LUI.UIImage.new()
	f5_arg0.secondaryWeaponBackground:setLeftRight(true, false, f5_local18, f5_local18 + f5_local9)
	f5_arg0.secondaryWeaponBackground:setTopBottom(true, false, f5_local22, f5_local22 + f5_local7)
	f5_arg0.secondaryWeaponBackground:setRGB(0, 0, 0)
	f5_arg0.secondaryWeaponBackground:setAlpha(0.1)
	f5_arg0:addElement(f5_arg0.secondaryWeaponBackground)
	f5_arg0.secondaryWeaponBackgroundContainer = LUI.UIElement.new()
	f5_arg0.secondaryWeaponBackgroundContainer:setLeftRight(true, false, f5_local18 - 2, f5_local18 - 2 + f5_local9)
	f5_arg0.secondaryWeaponBackgroundContainer:setTopBottom(true, false, f5_local22, f5_local22 + f5_local7)
	f5_arg0:addElement(f5_arg0.secondaryWeaponBackgroundContainer)
	if CoD.ShouldShowWeaponLevel() then
		f5_arg0.secondaryWeaponLevelIconContainer = CoD.WeaponLevel.GetWeaponLevelIcon(40, 40, "ExtraSmall", 0, 1, 1)
		f5_arg0.secondaryWeaponBackgroundContainer:addElement(f5_arg0.secondaryWeaponLevelIconContainer)
		f5_arg0.secondaryWeaponLevelIconContainer:hide()
	end
	f5_arg0:addElement(f5_arg0.secondaryWeaponBackgroundContainer)
	f5_arg0.secondaryWeaponSlotNameLabel = LUI.UIText.new()
	f5_arg0.secondaryWeaponSlotNameLabel:setLeftRight(true, false, f5_local19, f5_local19 + f5_local9)
	f5_arg0.secondaryWeaponSlotNameLabel:setTopBottom(true, false, f5_local22, f5_local22 + f5_local14)
	f5_arg0.secondaryWeaponSlotNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.secondaryWeaponSlotNameLabel:setAlpha(0.5)
	f5_arg0.secondaryWeaponSlotNameLabel:setFont(f5_local13)
	f5_arg0.secondaryWeaponSlotNameLabel:setAlignment(LUI.Alignment.Left)
	f5_arg0.secondaryWeaponSlotNameLabel:setText(Engine.Localize("MPUI_SECONDARY_CAPS"))
	f5_arg0:addElement(f5_arg0.secondaryWeaponSlotNameLabel)
	local f5_local54 = 80
	local f5_local55 = f5_local22 + 5
	local f5_local56 = f5_local7 * 0.8
	local f5_local57 = f5_local56 * 2
	f5_arg0.secondaryWeaponImage = LUI.UIImage.new()
	f5_arg0.secondaryWeaponImage:setLeftRight(true, false, f5_local18 + f5_local9 - f5_local57 - f5_local54, f5_local18 + f5_local9 - f5_local54)
	f5_arg0.secondaryWeaponImage:setTopBottom(true, false, f5_local55, f5_local55 + f5_local56)
	f5_arg0.secondaryWeaponImage:setAlpha(0)
	f5_arg0:addElement(f5_arg0.secondaryWeaponImage)
	local f5_local58 = 45
	local f5_local59 = 5
	local f5_local60 = 31
	local f5_local61 = 31
	local f5_local62 = CoD.ClassPreview.GetCamoSwatch()
	f5_local62:setLeftRight(false, true, -f5_local58 - f5_local60, -f5_local58)
	f5_local62:setTopBottom(false, true, -f5_local59 - f5_local61, -f5_local59)
	f5_arg0.secondaryCamoImageContainer = f5_local62
	f5_arg0.secondaryWeaponBackgroundContainer:addElement(f5_local62)
	local f5_local63 = f5_local18 + f5_local9 - f5_local57 / 2 - f5_local8 / 2
	local f5_local64 = f5_local22 + f5_local7 / 2 - f5_local8 / 2
	f5_arg0.secondaryWeaponRestrictedImage = LUI.UIImage.new()
	f5_arg0.secondaryWeaponRestrictedImage:setLeftRight(true, false, f5_local63, f5_local63 + f5_local8)
	f5_arg0.secondaryWeaponRestrictedImage:setTopBottom(true, false, f5_local64, f5_local64 + f5_local8)
	f5_arg0.secondaryWeaponRestrictedImage:setAlpha(0)
	f5_arg0.secondaryWeaponRestrictedImage:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.secondaryWeaponRestrictedImage)
	f5_arg0.secondaryWeaponNameLabel = LUI.UIText.new()
	f5_arg0.secondaryWeaponNameLabel:setLeftRight(true, false, f5_local19, f5_local19 + f5_local9)
	f5_arg0.secondaryWeaponNameLabel:setTopBottom(true, false, f5_local22 + f5_local7 - f5_local17, f5_local22 + f5_local7)
	f5_arg0.secondaryWeaponNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.secondaryWeaponNameLabel:setAlpha(1)
	f5_arg0.secondaryWeaponNameLabel:setFont(f5_local16)
	f5_arg0.secondaryWeaponNameLabel:setAlignment(LUI.Alignment.Left)
	f5_arg0.secondaryWeaponNameLabel:setText("")
	f5_arg0:addElement(f5_arg0.secondaryWeaponNameLabel)
	f5_arg0.primarygrenadeBackground = LUI.UIImage.new()
	f5_arg0.primarygrenadeBackground:setLeftRight(true, false, f5_local20, f5_local20 + f5_local10)
	f5_arg0.primarygrenadeBackground:setTopBottom(true, false, f5_local22, f5_local22 + f5_local7)
	f5_arg0.primarygrenadeBackground:setRGB(0, 0, 0)
	f5_arg0.primarygrenadeBackground:setAlpha(0.1)
	f5_arg0:addElement(f5_arg0.primarygrenadeBackground)
	f5_arg0.primarygrenadeSlotNameLabel = LUI.UIText.new()
	f5_arg0.primarygrenadeSlotNameLabel:setLeftRight(true, false, f5_local21, f5_local21 + f5_local10)
	f5_arg0.primarygrenadeSlotNameLabel:setTopBottom(true, false, f5_local22, f5_local22 + f5_local14)
	f5_arg0.primarygrenadeSlotNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.primarygrenadeSlotNameLabel:setAlpha(0.5)
	f5_arg0.primarygrenadeSlotNameLabel:setFont(f5_local13)
	f5_arg0.primarygrenadeSlotNameLabel:setAlignment(LUI.Alignment.Left)
	f5_arg0.primarygrenadeSlotNameLabel:setText(Engine.Localize("MPUI_PRIMARY_GRENADE_CAPS"))
	f5_arg0:addElement(f5_arg0.primarygrenadeSlotNameLabel)
	local f5_local65 = f5_local7 * 0.75
	local f5_local66 = f5_local36
	local f5_local67 = f5_local22 + f5_local7 / 2 - f5_local65 / 2
	local f5_local68 = f5_local20 + f5_local10 - f5_local7 * 2 - f5_local36 * 2 + f5_local7 / 2 - f5_local65 / 2
	local f5_local69 = f5_local20 + f5_local10 - f5_local7 * 1 - f5_local36 * 1 + f5_local7 / 2 - f5_local65 / 2
	f5_arg0.primarygrenadeImage1 = LUI.UIImage.new()
	f5_arg0.primarygrenadeImage1:setLeftRight(true, false, f5_local68, f5_local68 + f5_local65)
	f5_arg0.primarygrenadeImage1:setTopBottom(true, false, f5_local67, f5_local67 + f5_local65)
	f5_arg0.primarygrenadeImage1:setAlpha(0)
	f5_arg0:addElement(f5_arg0.primarygrenadeImage1)
	f5_arg0.primarygrenadeImage2 = LUI.UIImage.new()
	f5_arg0.primarygrenadeImage2:setLeftRight(true, false, f5_local69, f5_local69 + f5_local65)
	f5_arg0.primarygrenadeImage2:setTopBottom(true, false, f5_local67, f5_local67 + f5_local65)
	f5_arg0.primarygrenadeImage2:setAlpha(0)
	f5_arg0:addElement(f5_arg0.primarygrenadeImage2)
	local f5_local70 = f5_local68 + f5_local65 / 2 - f5_local8 / 2
	local f5_local71 = f5_local69 + f5_local65 / 2 - f5_local8 / 2
	local f5_local72 = f5_local67 + f5_local65 / 2 - f5_local8 / 2
	f5_arg0.primarygrenadeRestrictedImage1 = LUI.UIImage.new()
	f5_arg0.primarygrenadeRestrictedImage1:setLeftRight(true, false, f5_local70, f5_local70 + f5_local8)
	f5_arg0.primarygrenadeRestrictedImage1:setTopBottom(true, false, f5_local72, f5_local72 + f5_local8)
	f5_arg0.primarygrenadeRestrictedImage1:setAlpha(0)
	f5_arg0.primarygrenadeRestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.primarygrenadeRestrictedImage1)
	f5_arg0.primarygrenadeRestrictedImage2 = LUI.UIImage.new()
	f5_arg0.primarygrenadeRestrictedImage2:setLeftRight(true, false, f5_local71, f5_local71 + f5_local8)
	f5_arg0.primarygrenadeRestrictedImage2:setTopBottom(true, false, f5_local72, f5_local72 + f5_local8)
	f5_arg0.primarygrenadeRestrictedImage2:setAlpha(0)
	f5_arg0.primarygrenadeRestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.primarygrenadeRestrictedImage2)
	local f5_local73 = f5_local22 + f5_local14
	f5_arg0.primarygrenadeNameLabel = LUI.UIText.new()
	f5_arg0.primarygrenadeNameLabel:setLeftRight(true, false, f5_local21, f5_local21 + f5_local10)
	f5_arg0.primarygrenadeNameLabel:setTopBottom(true, false, f5_local73, f5_local73 + f5_local14)
	f5_arg0.primarygrenadeNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.primarygrenadeNameLabel:setAlpha(1)
	f5_arg0.primarygrenadeNameLabel:setFont(f5_local13)
	f5_arg0.primarygrenadeNameLabel:setAlignment(LUI.Alignment.Left)
	f5_arg0.primarygrenadeNameLabel:setText("")
	f5_arg0:addElement(f5_arg0.primarygrenadeNameLabel)
	f5_local22 = f5_local22 + f5_local7 + f5_local6
	f5_arg0.specialgrenadeBackground = LUI.UIImage.new()
	f5_arg0.specialgrenadeBackground:setLeftRight(true, false, f5_local20, f5_local20 + f5_local10)
	f5_arg0.specialgrenadeBackground:setTopBottom(true, false, f5_local22, f5_local22 + f5_local7)
	f5_arg0.specialgrenadeBackground:setRGB(0, 0, 0)
	f5_arg0.specialgrenadeBackground:setAlpha(0.1)
	f5_arg0:addElement(f5_arg0.specialgrenadeBackground)
	f5_arg0.specialgrenadeSlotNameLabel = LUI.UIText.new()
	f5_arg0.specialgrenadeSlotNameLabel:setLeftRight(true, false, f5_local21, f5_local21 + f5_local10)
	f5_arg0.specialgrenadeSlotNameLabel:setTopBottom(true, false, f5_local22, f5_local22 + f5_local14)
	f5_arg0.specialgrenadeSlotNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.specialgrenadeSlotNameLabel:setAlpha(0.5)
	f5_arg0.specialgrenadeSlotNameLabel:setFont(f5_local13)
	f5_arg0.specialgrenadeSlotNameLabel:setAlignment(LUI.Alignment.Left)
	f5_arg0.specialgrenadeSlotNameLabel:setText(Engine.Localize("MPUI_SPECIAL_GRENADE_CAPS"))
	f5_arg0:addElement(f5_arg0.specialgrenadeSlotNameLabel)
	local f5_local74 = f5_local7 * 0.75
	local f5_local75 = f5_local36
	local f5_local76 = f5_local22 + f5_local7 / 2 - f5_local74 / 2
	local f5_local77 = f5_local20 + f5_local10 - f5_local7 * 2 - f5_local36 * 2 + f5_local7 / 2 - f5_local74 / 2
	local f5_local78 = f5_local20 + f5_local10 - f5_local7 * 1 - f5_local36 * 1 + f5_local7 / 2 - f5_local74 / 2
	f5_arg0.specialgrenadeImage1 = LUI.UIImage.new()
	f5_arg0.specialgrenadeImage1:setLeftRight(true, false, f5_local77, f5_local77 + f5_local74)
	f5_arg0.specialgrenadeImage1:setTopBottom(true, false, f5_local76, f5_local76 + f5_local74)
	f5_arg0.specialgrenadeImage1:setAlpha(0)
	f5_arg0:addElement(f5_arg0.specialgrenadeImage1)
	f5_arg0.specialgrenadeImage2 = LUI.UIImage.new()
	f5_arg0.specialgrenadeImage2:setLeftRight(true, false, f5_local78, f5_local78 + f5_local74)
	f5_arg0.specialgrenadeImage2:setTopBottom(true, false, f5_local76, f5_local76 + f5_local74)
	f5_arg0.specialgrenadeImage2:setAlpha(0)
	f5_arg0:addElement(f5_arg0.specialgrenadeImage2)
	local f5_local79 = f5_local77 + f5_local74 / 2 - f5_local8 / 2
	local f5_local80 = f5_local78 + f5_local74 / 2 - f5_local8 / 2
	local f5_local81 = f5_local76 + f5_local74 / 2 - f5_local8 / 2
	f5_arg0.specialgrenadeRestrictedImage1 = LUI.UIImage.new()
	f5_arg0.specialgrenadeRestrictedImage1:setLeftRight(true, false, f5_local79, f5_local79 + f5_local8)
	f5_arg0.specialgrenadeRestrictedImage1:setTopBottom(true, false, f5_local81, f5_local81 + f5_local8)
	f5_arg0.specialgrenadeRestrictedImage1:setAlpha(0)
	f5_arg0.specialgrenadeRestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.specialgrenadeRestrictedImage1)
	f5_arg0.specialgrenadeRestrictedImage2 = LUI.UIImage.new()
	f5_arg0.specialgrenadeRestrictedImage2:setLeftRight(true, false, f5_local80, f5_local80 + f5_local8)
	f5_arg0.specialgrenadeRestrictedImage2:setTopBottom(true, false, f5_local81, f5_local81 + f5_local8)
	f5_arg0.specialgrenadeRestrictedImage2:setAlpha(0)
	f5_arg0.specialgrenadeRestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.specialgrenadeRestrictedImage2)
	local f5_local82 = f5_local22 + f5_local14
	f5_arg0.specialgrenadeNameLabel = LUI.UIText.new()
	f5_arg0.specialgrenadeNameLabel:setLeftRight(true, false, f5_local21, f5_local21 + f5_local10)
	f5_arg0.specialgrenadeNameLabel:setTopBottom(true, false, f5_local82, f5_local82 + f5_local14)
	f5_arg0.specialgrenadeNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.specialgrenadeNameLabel:setAlpha(1)
	f5_arg0.specialgrenadeNameLabel:setFont(f5_local13)
	f5_arg0.specialgrenadeNameLabel:setAlignment(LUI.Alignment.Left)
	f5_arg0.specialgrenadeNameLabel:setText("")
	f5_arg0:addElement(f5_arg0.specialgrenadeNameLabel)
	f5_arg0.secondaryWeaponAttachmentsBackground = LUI.UIImage.new()
	f5_arg0.secondaryWeaponAttachmentsBackground:setLeftRight(true, false, f5_local18, f5_local18 + f5_local9)
	f5_arg0.secondaryWeaponAttachmentsBackground:setTopBottom(true, false, f5_local22, f5_local22 + f5_local7)
	f5_arg0.secondaryWeaponAttachmentsBackground:setRGB(0, 0, 0)
	f5_arg0.secondaryWeaponAttachmentsBackground:setAlpha(0.1)
	f5_arg0:addElement(f5_arg0.secondaryWeaponAttachmentsBackground)
	f5_arg0.secondaryWeaponAttachmentsImage1 = LUI.UIImage.new()
	f5_arg0.secondaryWeaponAttachmentsImage1:setLeftRight(true, false, f5_local46, f5_local46 + f5_local44)
	f5_arg0.secondaryWeaponAttachmentsImage1:setTopBottom(true, false, f5_local22 + f5_local43, f5_local22 + f5_local43 + f5_local44)
	f5_arg0.secondaryWeaponAttachmentsImage1:setAlpha(0)
	f5_arg0:addElement(f5_arg0.secondaryWeaponAttachmentsImage1)
	f5_arg0.secondaryWeaponAttachmentsImage2 = LUI.UIImage.new()
	f5_arg0.secondaryWeaponAttachmentsImage2:setLeftRight(true, false, f5_local47, f5_local47 + f5_local44)
	f5_arg0.secondaryWeaponAttachmentsImage2:setTopBottom(true, false, f5_local22 + f5_local43, f5_local22 + f5_local43 + f5_local44)
	f5_arg0.secondaryWeaponAttachmentsImage2:setAlpha(0)
	f5_arg0:addElement(f5_arg0.secondaryWeaponAttachmentsImage2)
	local f5_local83 = f5_local22 + f5_local43 + f5_local44 / 2 - f5_local8 / 2
	f5_arg0.secondaryWeaponAttachmentsRestrictedImage1 = LUI.UIImage.new()
	f5_arg0.secondaryWeaponAttachmentsRestrictedImage1:setLeftRight(true, false, f5_local49, f5_local49 + f5_local8)
	f5_arg0.secondaryWeaponAttachmentsRestrictedImage1:setTopBottom(true, false, f5_local83, f5_local83 + f5_local8)
	f5_arg0.secondaryWeaponAttachmentsRestrictedImage1:setAlpha(0)
	f5_arg0.secondaryWeaponAttachmentsRestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.secondaryWeaponAttachmentsRestrictedImage1)
	f5_arg0.secondaryWeaponAttachmentsRestrictedImage2 = LUI.UIImage.new()
	f5_arg0.secondaryWeaponAttachmentsRestrictedImage2:setLeftRight(true, false, f5_local50, f5_local50 + f5_local8)
	f5_arg0.secondaryWeaponAttachmentsRestrictedImage2:setTopBottom(true, false, f5_local83, f5_local83 + f5_local8)
	f5_arg0.secondaryWeaponAttachmentsRestrictedImage2:setAlpha(0)
	f5_arg0.secondaryWeaponAttachmentsRestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f5_arg0:addElement(f5_arg0.secondaryWeaponAttachmentsRestrictedImage2)
	local f5_local84 = f5_local22
	f5_arg0.secondaryWeaponAttachmentsNameLabel1 = LUI.UIText.new()
	f5_arg0.secondaryWeaponAttachmentsNameLabel1:setLeftRight(true, false, f5_local19, f5_local19 + f5_local9)
	f5_arg0.secondaryWeaponAttachmentsNameLabel1:setTopBottom(true, false, f5_local84, f5_local84 + f5_local14)
	f5_arg0.secondaryWeaponAttachmentsNameLabel1:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.secondaryWeaponAttachmentsNameLabel1:setAlpha(1)
	f5_arg0.secondaryWeaponAttachmentsNameLabel1:setFont(f5_local13)
	f5_arg0.secondaryWeaponAttachmentsNameLabel1:setAlignment(LUI.Alignment.Left)
	f5_arg0.secondaryWeaponAttachmentsNameLabel1:setText("")
	f5_arg0:addElement(f5_arg0.secondaryWeaponAttachmentsNameLabel1)
	f5_local84 = f5_local84 + f5_local14
	f5_arg0.secondaryWeaponAttachmentsNameLabel2 = LUI.UIText.new()
	f5_arg0.secondaryWeaponAttachmentsNameLabel2:setLeftRight(true, false, f5_local19, f5_local19 + f5_local9)
	f5_arg0.secondaryWeaponAttachmentsNameLabel2:setTopBottom(true, false, f5_local84, f5_local84 + f5_local14)
	f5_arg0.secondaryWeaponAttachmentsNameLabel2:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.secondaryWeaponAttachmentsNameLabel2:setAlpha(1)
	f5_arg0.secondaryWeaponAttachmentsNameLabel2:setFont(f5_local13)
	f5_arg0.secondaryWeaponAttachmentsNameLabel2:setAlignment(LUI.Alignment.Left)
	f5_arg0.secondaryWeaponAttachmentsNameLabel2:setText("")
	f5_arg0:addElement(f5_arg0.secondaryWeaponAttachmentsNameLabel2)
	f5_local22 = f5_local22 + f5_local7 + f5_local6
	local f5_local85 = Engine.Localize("MENU_WILDCARDS_CAPS")
	f5_arg0.bonusCardSlotNameLabel = LUI.UIText.new()
	f5_arg0.bonusCardSlotNameLabel:setLeftRight(true, false, f5_local19, f5_local19 + f5_arg0.width)
	f5_arg0.bonusCardSlotNameLabel:setTopBottom(true, false, f5_local22, f5_local22 + f5_local14)
	f5_arg0.bonusCardSlotNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.bonusCardSlotNameLabel:setAlpha(0.5)
	f5_arg0.bonusCardSlotNameLabel:setFont(f5_local13)
	f5_arg0.bonusCardSlotNameLabel:setAlignment(LUI.Alignment.Left)
	f5_arg0.bonusCardSlotNameLabel:setText(f5_local85)
	f5_arg0:addElement(f5_arg0.bonusCardSlotNameLabel)
	f5_local22 = f5_local22 + f5_local14
	local f5_local86 = f5_local18
	local f5_local87 = (f5_arg0.width - f5_local6 * (CoD.CACUtility.maxBonusCards - 1)) / CoD.CACUtility.maxBonusCards
	local f5_local88 = f5_local22 - 11
	local f5_local89 = f5_local7 + 10
	local f5_local90 = f5_local89 * 2
	local f5_local91 = -20
	for f5_local92 = 1, CoD.CACUtility.maxBonusCards, 1 do
		local f5_local95 = LUI.UIImage.new()
		f5_local95:setLeftRight(true, false, f5_local86, f5_local86 + f5_local87)
		f5_local95:setTopBottom(true, false, f5_local22, f5_local22 + f5_local7)
		f5_local95:setRGB(0, 0, 0)
		f5_local95:setAlpha(0.1)
		f5_arg0:addElement(f5_local95)
		local f5_local96 = 3
		local f5_local97 = LUI.UIText.new()
		f5_local97:setLeftRight(true, false, f5_local86 + f5_local96, f5_local86 + f5_local96 + f5_local87)
		f5_local97:setTopBottom(true, false, f5_local22, f5_local22 + f5_local14)
		f5_local97:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f5_local97:setAlpha(1)
		f5_local97:setFont(f5_local13)
		f5_local97:setAlignment(LUI.Alignment.Left)
		f5_local97:setText("")
		f5_arg0:addElement(f5_local97)
		f5_arg0["bonusCardNameLabel" .. f5_local92] = f5_local97
		local f5_local98 = f5_local86 + f5_local87 - f5_local90 + 30
		local f5_local99 = LUI.UIImage.new()
		f5_local99:setLeftRight(true, false, f5_local98, f5_local98 + f5_local90)
		f5_local99:setTopBottom(true, false, f5_local88, f5_local88 + f5_local89)
		f5_local99:setAlpha(0)
		f5_arg0:addElement(f5_local99)
		f5_arg0["bonusCardImage" .. f5_local92] = f5_local99
		local f5_local100 = f5_local98 + f5_local90 / 2 - f5_local8 / 2
		local f5_local101 = f5_local88 + f5_local89 / 2 - f5_local8 / 2
		local f5_local102 = LUI.UIImage.new()
		f5_local102:setLeftRight(true, false, f5_local100, f5_local100 + f5_local8)
		f5_local102:setTopBottom(true, false, f5_local101, f5_local101 + f5_local8)
		f5_local102:setAlpha(0)
		f5_local102:setImage(RegisterMaterial("cac_restricted"))
		f5_arg0:addElement(f5_local102)
		f5_arg0["bonusCardRestrictedImage" .. f5_local92] = f5_local102
		f5_local86 = f5_local86 + f5_local87 + f5_local6
	end
end

CoD.ClassPreview.UpdateClass = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	if f6_arg3 then
		f6_arg2 = Engine.GetClassIndexFromName(f6_arg3)
	end
	local f6_local0 = Engine.GetCustomClass(f6_arg1, f6_arg2)
	CoD.AllocationStatus.Update(f6_arg0.allocationStatus, {
		class = f6_local0
	})
	f6_arg0.allocationBar:processEvent({
		name = "update_class",
		class = f6_local0
	})
	local f6_local1 = f6_local0.primary
	if f6_local1 == nil then
		f6_arg0.primaryWeaponImage:hide()
		f6_arg0.primaryWeaponRestrictedImage:hide()
		f6_arg0.primaryWeaponNameLabel:setText("")
		f6_arg0.primaryWeaponBackgroundContainer:hide()
		f6_arg0.primaryCamoImageContainer.camoSwatchImage:hide()
	else
		f6_arg0.primaryWeaponImage:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f6_local1) .. "_big"))
		f6_arg0.primaryWeaponImage:show()
		f6_arg0.primaryWeaponNameLabel:setText(Engine.Localize(UIExpression.GetItemName(nil, f6_local1)))
		f6_arg0.primaryWeaponBackgroundContainer:show()
		if f6_arg0.primaryWeaponLevelIconContainer then
			f6_arg0.primaryWeaponLevelIconContainer:update(f6_arg1, f6_local1)
		end
		local f6_local2 = f6_local0.primarycamo
		f6_arg0.primaryCamoImageContainer.camoSwatchImage:hide()
		if f6_local2 and f6_local2 ~= 0 and f6_arg0.primaryCamoImageContainer then
			f6_arg0.primaryCamoImageContainer.camoSwatchImage:show()
			local f6_local3 = UIExpression.GetWeaponOptionImage(nil, f6_local2)
			if CoD.CACUtility.IsWeaponOptionMTX(f6_local2) then
				f6_local3 = f6_local3 .. "_32"
				CoD.ClassPreview.SetupMTXCamoSwatch(f6_arg0.primaryCamoImageContainer)
			else
				CoD.ClassPreview.SetupDefaultCamoSwatch(f6_arg0.primaryCamoImageContainer)
			end
			if string.find(f6_local3, "_128") then
				CoD.ClassPreview.SetupMTXCamoSwatch(f6_arg0.primaryCamoImageContainer)
				f6_local3 = string.gsub(f6_local3, "_128", "_32")
			end
			f6_arg0.primaryCamoImageContainer.camoSwatchImage:setImage(RegisterMaterial(f6_local3))
		end
		local f6_local3 = 0
		if not Engine.HasDLCForItem(f6_arg1, f6_local1) or Engine.IsItemIndexRestricted(f6_local1) then
			f6_local3 = 1
		end
		f6_arg0.primaryWeaponRestrictedImage:setAlpha(f6_local3)
	end
	CoD.ClassPreview.UpdatePerkCategory(f6_arg0, 1, f6_local0)
	CoD.ClassPreview.UpdatePerkCategory(f6_arg0, 2, f6_local0)
	CoD.ClassPreview.UpdatePerkCategory(f6_arg0, 3, f6_local0)
	CoD.ClassPreview.UpdateAttachments(f6_arg0, f6_arg1, "primary", f6_local0, f6_arg2)
	local f6_local2 = f6_local0.secondary
	if f6_local2 == nil then
		f6_arg0.secondaryWeaponImage:hide()
		f6_arg0.secondaryWeaponRestrictedImage:hide()
		f6_arg0.secondaryWeaponNameLabel:setText("")
		f6_arg0.secondaryWeaponBackgroundContainer:hide()
		f6_arg0.secondaryCamoImageContainer.camoSwatchImage:hide()
	else
		f6_arg0.secondaryWeaponImage:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f6_local2) .. "_big"))
		f6_arg0.secondaryWeaponImage:show()
		f6_arg0.secondaryWeaponNameLabel:setText(Engine.Localize(UIExpression.GetItemName(nil, f6_local2)))
		f6_arg0.secondaryWeaponBackgroundContainer:show()
		if f6_arg0.secondaryWeaponLevelIconContainer then
			f6_arg0.secondaryWeaponLevelIconContainer:update(f6_arg1, f6_local2)
		end
		f6_arg0.secondaryCamoImageContainer.camoSwatchImage:hide()
		local f6_local3 = f6_local0.secondarycamo
		if f6_local3 and f6_local3 ~= 0 and f6_arg0.secondaryCamoImageContainer then
			f6_arg0.secondaryCamoImageContainer.camoSwatchImage:show()
			local f6_local4 = UIExpression.GetWeaponOptionImage(nil, f6_local3)
			if CoD.CACUtility.IsWeaponOptionMTX(f6_local3) then
				f6_local4 = f6_local4 .. "_32"
				CoD.ClassPreview.SetupMTXCamoSwatch(f6_arg0.secondaryCamoImageContainer)
			else
				CoD.ClassPreview.SetupDefaultCamoSwatch(f6_arg0.secondaryCamoImageContainer)
			end
			if string.find(f6_local4, "_128") then
				CoD.ClassPreview.SetupMTXCamoSwatch(f6_arg0.secondaryCamoImageContainer)
				f6_local4 = string.gsub(f6_local4, "_128", "_32")
			end
			f6_arg0.secondaryCamoImageContainer.camoSwatchImage:setImage(RegisterMaterial(f6_local4))
		end
		local f6_local4 = 0
		if not Engine.HasDLCForItem(f6_arg1, f6_local2) or Engine.IsItemIndexRestricted(f6_local2) then
			f6_local4 = 1
		end
		f6_arg0.secondaryWeaponRestrictedImage:setAlpha(f6_local4)
	end
	if CoD.CACUtility.IsBonusCardEquippedByName(f6_local0, "bonuscard_two_tacticals") then
		f6_arg0.primarygrenadeSlotNameLabel:setText(Engine.Localize("MPUI_SECOND_SPECIAL_GRENADE_CAPS"))
	else
		f6_arg0.primarygrenadeSlotNameLabel:setText(Engine.Localize("MPUI_PRIMARY_GRENADE_CAPS"))
	end
	CoD.ClassPreview.UpdateGrenades(f6_arg0, f6_arg1, "primarygrenade", f6_local0, f6_arg2)
	CoD.ClassPreview.UpdateGrenades(f6_arg0, f6_arg1, "specialgrenade", f6_local0, f6_arg2)
	CoD.ClassPreview.UpdateAttachments(f6_arg0, f6_arg1, "secondary", f6_local0, f6_arg2)
	CoD.ClassPreview.UpdateBonusCards(f6_arg0, f6_local0)
end

CoD.ClassPreview.UpdatePerkCategory = function (f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = 2
	for f7_local1 = 1, f7_local0, 1 do
		local f7_local4 = f7_arg2["specialty" .. f7_arg1 + f7_local1 - 1 * CoD.CACUtility.maxPerkCategories]
		if f7_local4 == nil then
			local f7_local5 = "perk"
			local f7_local6 = f7_arg1
			f7_arg0[f7_local5 .. f7_arg1 .. "Image" .. f7_local1]:setAlpha(0)
			f7_local5 = "perk"
			f7_local6 = f7_arg1
			f7_arg0[f7_local5 .. f7_arg1 .. "RestrictedImage" .. f7_local1]:setAlpha(0)
			f7_local5 = "perk"
			f7_local6 = f7_arg1
			f7_arg0[f7_local5 .. f7_arg1 .. "NameLabel" .. f7_local1]:setText("")
		end
		local f7_local5 = "perk"
		f7_arg0["perk" .. f7_arg1 .. "Image" .. f7_local1]:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f7_local4)))
		f7_local5 = "perk"
		local f7_local6 = f7_arg1
		f7_arg0[f7_local5 .. f7_arg1 .. "Image" .. f7_local1]:setAlpha(1)
		f7_local5 = "perk"
		f7_arg0["perk" .. f7_arg1 .. "NameLabel" .. f7_local1]:setText(Engine.Localize(UIExpression.GetItemName(nil, f7_local4)))
		f7_local5 = 0
		if Engine.IsItemIndexRestricted(f7_local4) then
			f7_local5 = 1
		end
		f7_local6 = "perk"
		local f7_local7 = f7_arg1
		f7_arg0[f7_local6 .. f7_arg1 .. "RestrictedImage" .. f7_local1]:setAlpha(f7_local5)
	end
end

CoD.ClassPreview.UpdateAttachments = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4)
	local f8_local0 = f8_arg3[f8_arg2]
	local f8_local1 = 2
	if f8_arg2 == "primary" then
		f8_local1 = 3
	end
	for f8_local2 = 1, f8_local1, 1 do
		local f8_local5 = f8_arg2
		f8_arg0[f8_arg2 .. "WeaponAttachmentsImage" .. f8_local2]:setAlpha(0)
		f8_local5 = f8_arg2
		f8_arg0[f8_arg2 .. "WeaponAttachmentsRestrictedImage" .. f8_local2]:setAlpha(0)
		f8_local5 = f8_arg2
		f8_arg0[f8_arg2 .. "WeaponAttachmentsNameLabel" .. f8_local2]:setText("")
	end
	if f8_local0 ~= nil then
		for f8_local2 = 0, f8_local1 - 1, 1 do
			local f8_local5 = f8_arg3[f8_arg2 .. "attachment" .. f8_local2 + 1]
			if f8_local5 ~= nil and f8_local5 ~= 0 then
				local f8_local6 = Engine.GetAttachmentImage(f8_local0, f8_local5)
				local f8_local7 = f8_arg2
				f8_arg0[f8_arg2 .. "WeaponAttachmentsImage" .. f8_local2 + 1]:setImage(RegisterMaterial(f8_local6))
				f8_local7 = f8_arg2
				f8_arg0[f8_arg2 .. "WeaponAttachmentsImage" .. f8_local2 + 1]:setAlpha(1)
				f8_local7 = Engine.GetAttachmentName(f8_local0, f8_local5)
				local f8_local8 = f8_arg2
				f8_arg0[f8_arg2 .. "WeaponAttachmentsNameLabel" .. f8_local2 + 1]:setText(Engine.Localize(f8_local7))
				f8_local8 = 0
				local f8_local9 = Engine.GetItemAttachment(f8_local0, f8_local5)
				local f8_local10 = Engine.IsAttachmentIndexRestricted(f8_local9)
				if Engine.IsAttachmentIndexRestricted(f8_local9) then
					f8_local8 = 1
				end
				local f8_local11 = f8_arg2
				f8_arg0[f8_arg2 .. "WeaponAttachmentsRestrictedImage" .. f8_local2 + 1]:setAlpha(f8_local8)
			end
		end
	end
end

CoD.ClassPreview.UpdateGrenades = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4)
	local f9_local0 = f9_arg3[f9_arg2]
	local f9_local1 = 2
	if f9_local0 == nil then
		for f9_local2 = 1, f9_local1, 1 do
			local f9_local5 = f9_arg2
			f9_arg0[f9_arg2 .. "Image" .. f9_local2]:setAlpha(0)
			f9_local5 = f9_arg2
			f9_arg0[f9_arg2 .. "RestrictedImage" .. f9_local2]:setAlpha(0)
		end
		f9_arg0[f9_arg2 .. "NameLabel"]:setText("")
	else
		local f9_local2 = 0
		for f9_local3 = 1, f9_local1, 1 do
			if Engine.GetClassItem(f9_arg1, f9_arg4, f9_arg2 .. "status" .. f9_local3) == 1 then
				f9_arg0[f9_arg2 .. "Image" .. f9_local3]:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f9_local0) .. "_256"))
				local f9_local7 = f9_arg2
				f9_arg0[f9_arg2 .. "Image" .. f9_local3]:setAlpha(1)
				f9_local7 = 0
				if Engine.IsItemIndexRestricted(f9_local0) then
					f9_local7 = 1
				end
				local f9_local8 = f9_arg2
				f9_arg0[f9_arg2 .. "RestrictedImage" .. f9_local3]:setAlpha(f9_local7)
				f9_local2 = f9_local2 + 1
			end
			local f9_local7 = f9_arg2
			f9_arg0[f9_arg2 .. "Image" .. f9_local3]:setAlpha(0)
			f9_local7 = f9_arg2
			f9_arg0[f9_arg2 .. "RestrictedImage" .. f9_local3]:setAlpha(0)
		end
		local f9_local3 = Engine.Localize(UIExpression.GetItemName(nil, f9_local0))
		if f9_local2 > 1 then
			f9_local3 = f9_local3 .. " x" .. f9_local2
		end
		f9_arg0[f9_arg2 .. "NameLabel"]:setText(f9_local3)
	end
end

CoD.ClassPreview.UpdateBonusCards = function (f10_arg0, f10_arg1)
	for f10_local0 = 1, CoD.CACUtility.maxBonusCards, 1 do
		local f10_local3 = f10_arg1["bonuscard" .. f10_local0]
		if f10_local3 ~= nil then
			f10_arg0["bonusCardNameLabel" .. f10_local0]:setText(Engine.Localize(UIExpression.GetItemRef(nil, f10_local3)))
			f10_arg0["bonusCardImage" .. f10_local0]:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f10_local3)))
			f10_arg0["bonusCardImage" .. f10_local0]:setAlpha(1)
			local f10_local4 = 0
			if Engine.IsItemIndexRestricted(f10_local3) then
				f10_local4 = 1
			end
			f10_arg0["bonusCardRestrictedImage" .. f10_local0]:setAlpha(f10_local4)
		end
		f10_arg0["bonusCardNameLabel" .. f10_local0]:setText("")
		f10_arg0["bonusCardImage" .. f10_local0]:setAlpha(0)
		f10_arg0["bonusCardRestrictedImage" .. f10_local0]:setAlpha(0)
	end
end

