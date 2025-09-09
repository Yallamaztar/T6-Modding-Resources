require("T6.AllocationBar")
require("T6.AllocationStatus")
require("T6.CACGrenadesButton")
require("T6.BonusCardButton")
require("T6.Menus.CACUtility")
require("T6.WeaponLevel")
CoD.SplitscreenClassPreview = {}
CoD.SplitscreenClassPreview.New = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget.m_inputDisabled = true
	Widget.id = "ClassPreview"
	Widget.width = InstanceRef
	Widget.update = CoD.SplitscreenClassPreview.UpdateClass
	CoD.SplitscreenClassPreview.AddWidgets(Widget, HudRef)
	return Widget
end

CoD.SplitscreenClassPreview.AddWidgets = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.width
	local f2_local1 = f2_local0 - CoD.AllocationStatus.Width
	local f2_local2 = 5
	local f2_local3 = f2_local2 - CoD.AllocationStatus.Height
	f2_arg0.allocationStatus = CoD.AllocationStatus.new(f2_arg1)
	f2_arg0.allocationStatus:setLeftRight(true, false, f2_local1, f2_local0)
	f2_arg0.allocationStatus:setTopBottom(true, false, f2_local3, f2_local2)
	f2_arg0:addElement(f2_arg0.allocationStatus)
	local f2_local4 = 10
	local f2_local5 = f2_local2
	f2_arg0.allocationBar = CoD.AllocationBar.New(f2_arg1, f2_arg0.width)
	f2_arg0.allocationBar:setLeftRight(true, false, 0, f2_arg0.width)
	f2_arg0.allocationBar:setTopBottom(true, false, f2_local5, f2_local5 + f2_local4)
	f2_arg0:addElement(f2_arg0.allocationBar)
	local f2_local6 = 4
	local f2_local7 = 60
	local f2_local8 = 32
	local f2_local9 = (f2_arg0.width - f2_local6) * 0.57
	local f2_local10 = (f2_arg0.width - f2_local6) * 0.43
	local f2_local11 = f2_local9 / 2
	local f2_local12 = "ExtraSmall"
	local f2_local13 = CoD.fonts[f2_local12]
	local f2_local14 = CoD.textSize[f2_local12]
	local f2_local15 = "Condensed"
	local f2_local16 = CoD.fonts[f2_local15]
	local f2_local17 = CoD.textSize[f2_local15]
	local f2_local18 = 0
	local f2_local19 = f2_local18 + 3
	local f2_local20 = f2_local18 + f2_local9 + f2_local6
	local f2_local21 = f2_local20 + 3
	local f2_local22 = f2_local5 + f2_local4 + 15
	f2_arg0.primaryWeaponBackground = LUI.UIImage.new()
	f2_arg0.primaryWeaponBackground:setLeftRight(true, false, f2_local18, f2_local18 + f2_local9)
	f2_arg0.primaryWeaponBackground:setTopBottom(true, false, f2_local22, f2_local22 + f2_local11)
	f2_arg0.primaryWeaponBackground:setRGB(0, 0, 0)
	f2_arg0.primaryWeaponBackground:setAlpha(0.1)
	f2_arg0:addElement(f2_arg0.primaryWeaponBackground)
	f2_arg0.primaryWeaponBackgroundContainer = LUI.UIElement.new()
	f2_arg0.primaryWeaponBackgroundContainer:setLeftRight(true, false, f2_local18, f2_local18 + f2_local9)
	f2_arg0.primaryWeaponBackgroundContainer:setTopBottom(true, false, f2_local22, f2_local22 + f2_local11)
	f2_arg0:addElement(f2_arg0.primaryWeaponBackgroundContainer)
	if CoD.ShouldShowWeaponLevel() then
		f2_arg0.primaryWeaponLevelIconContainer = CoD.WeaponLevel.GetWeaponLevelIcon(40, 40, "ExtraSmall", 0)
		f2_arg0.primaryWeaponBackgroundContainer:addElement(f2_arg0.primaryWeaponLevelIconContainer)
		f2_arg0.primaryWeaponLevelIconContainer:hide()
	end
	f2_arg0:addElement(f2_arg0.primaryWeaponBackgroundContainer)
	local f2_local23 = 20
	local f2_local24 = f2_local11 * 0.9
	local f2_local25 = f2_local24 * 2
	f2_arg0.primaryWeaponImage = LUI.UIImage.new()
	f2_arg0.primaryWeaponImage:setLeftRight(true, false, f2_local18 + f2_local9 - f2_local25 - f2_local23, f2_local18 + f2_local9 - f2_local23)
	f2_arg0.primaryWeaponImage:setTopBottom(true, false, f2_local22, f2_local22 + f2_local24)
	f2_arg0.primaryWeaponImage:setAlpha(0)
	f2_arg0:addElement(f2_arg0.primaryWeaponImage)
	local f2_local26 = f2_local18 + f2_local9 - f2_local25 / 2 - f2_local8 / 2
	local f2_local27 = f2_local22 + f2_local11 / 2 - f2_local8 / 2
	f2_arg0.primaryWeaponRestrictedImage = LUI.UIImage.new()
	f2_arg0.primaryWeaponRestrictedImage:setLeftRight(true, false, f2_local26, f2_local26 + f2_local8)
	f2_arg0.primaryWeaponRestrictedImage:setTopBottom(true, false, f2_local27, f2_local27 + f2_local8)
	f2_arg0.primaryWeaponRestrictedImage:setAlpha(0)
	f2_arg0.primaryWeaponRestrictedImage:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.primaryWeaponRestrictedImage)
	local f2_local28 = f2_local22
	local f2_local29 = (f2_local11 + f2_local6 + f2_local7 - f2_local6 * 2) / 3
	f2_arg0.perk1Background = LUI.UIImage.new()
	f2_arg0.perk1Background:setLeftRight(true, false, f2_local20, f2_local20 + f2_local10)
	f2_arg0.perk1Background:setTopBottom(true, false, f2_local28, f2_local28 + f2_local29)
	f2_arg0.perk1Background:setRGB(0, 0, 0)
	f2_arg0.perk1Background:setAlpha(0.1)
	f2_arg0:addElement(f2_arg0.perk1Background)
	local f2_local30 = f2_local29
	local f2_local31 = 0
	local f2_local32 = f2_local20 + f2_local10 - f2_local30 * 2 - f2_local31 * 2
	local f2_local33 = f2_local20 + f2_local10 - f2_local30 * 1 - f2_local31 * 1
	f2_arg0.perk1Image1 = LUI.UIImage.new()
	f2_arg0.perk1Image1:setLeftRight(true, false, f2_local32, f2_local32 + f2_local30)
	f2_arg0.perk1Image1:setTopBottom(true, false, f2_local28, f2_local28 + f2_local30)
	f2_arg0.perk1Image1:setAlpha(0)
	f2_arg0:addElement(f2_arg0.perk1Image1)
	f2_arg0.perk1Image2 = LUI.UIImage.new()
	f2_arg0.perk1Image2:setLeftRight(true, false, f2_local33, f2_local33 + f2_local30)
	f2_arg0.perk1Image2:setTopBottom(true, false, f2_local28, f2_local28 + f2_local30)
	f2_arg0.perk1Image2:setAlpha(0)
	f2_arg0:addElement(f2_arg0.perk1Image2)
	local f2_local34 = f2_local32 + f2_local30 / 2 - f2_local8 / 2
	local f2_local35 = f2_local33 + f2_local30 / 2 - f2_local8 / 2
	local f2_local36 = f2_local28 + f2_local30 / 2 - f2_local8 / 2
	f2_arg0.perk1RestrictedImage1 = LUI.UIImage.new()
	f2_arg0.perk1RestrictedImage1:setLeftRight(true, false, f2_local34, f2_local34 + f2_local8)
	f2_arg0.perk1RestrictedImage1:setTopBottom(true, false, f2_local36, f2_local36 + f2_local8)
	f2_arg0.perk1RestrictedImage1:setAlpha(0)
	f2_arg0.perk1RestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.perk1RestrictedImage1)
	f2_arg0.perk1RestrictedImage2 = LUI.UIImage.new()
	f2_arg0.perk1RestrictedImage2:setLeftRight(true, false, f2_local35, f2_local35 + f2_local8)
	f2_arg0.perk1RestrictedImage2:setTopBottom(true, false, f2_local36, f2_local36 + f2_local8)
	f2_arg0.perk1RestrictedImage2:setAlpha(0)
	f2_arg0.perk1RestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.perk1RestrictedImage2)
	f2_local28 = f2_local28 + f2_local29 + f2_local6
	f2_arg0.perk2Background = LUI.UIImage.new()
	f2_arg0.perk2Background:setLeftRight(true, false, f2_local20, f2_local20 + f2_local10)
	f2_arg0.perk2Background:setTopBottom(true, false, f2_local28, f2_local28 + f2_local29)
	f2_arg0.perk2Background:setRGB(0, 0, 0)
	f2_arg0.perk2Background:setAlpha(0.1)
	f2_arg0:addElement(f2_arg0.perk2Background)
	f2_arg0.perk2Image1 = LUI.UIImage.new()
	f2_arg0.perk2Image1:setLeftRight(true, false, f2_local32, f2_local32 + f2_local30)
	f2_arg0.perk2Image1:setTopBottom(true, false, f2_local28, f2_local28 + f2_local30)
	f2_arg0.perk2Image1:setAlpha(0)
	f2_arg0:addElement(f2_arg0.perk2Image1)
	f2_arg0.perk2Image2 = LUI.UIImage.new()
	f2_arg0.perk2Image2:setLeftRight(true, false, f2_local33, f2_local33 + f2_local30)
	f2_arg0.perk2Image2:setTopBottom(true, false, f2_local28, f2_local28 + f2_local30)
	f2_arg0.perk2Image2:setAlpha(0)
	f2_arg0:addElement(f2_arg0.perk2Image2)
	f2_local36 = f2_local28 + f2_local30 / 2 - f2_local8 / 2
	f2_arg0.perk2RestrictedImage1 = LUI.UIImage.new()
	f2_arg0.perk2RestrictedImage1:setLeftRight(true, false, f2_local34, f2_local34 + f2_local8)
	f2_arg0.perk2RestrictedImage1:setTopBottom(true, false, f2_local36, f2_local36 + f2_local8)
	f2_arg0.perk2RestrictedImage1:setAlpha(0)
	f2_arg0.perk2RestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.perk2RestrictedImage1)
	f2_arg0.perk2RestrictedImage2 = LUI.UIImage.new()
	f2_arg0.perk2RestrictedImage2:setLeftRight(true, false, f2_local35, f2_local35 + f2_local8)
	f2_arg0.perk2RestrictedImage2:setTopBottom(true, false, f2_local36, f2_local36 + f2_local8)
	f2_arg0.perk2RestrictedImage2:setAlpha(0)
	f2_arg0.perk2RestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.perk2RestrictedImage2)
	f2_local28 = f2_local28 + f2_local29 + f2_local6
	f2_arg0.perk3Background = LUI.UIImage.new()
	f2_arg0.perk3Background:setLeftRight(true, false, f2_local20, f2_local20 + f2_local10)
	f2_arg0.perk3Background:setTopBottom(true, false, f2_local28, f2_local28 + f2_local29)
	f2_arg0.perk3Background:setRGB(0, 0, 0)
	f2_arg0.perk3Background:setAlpha(0.1)
	f2_arg0:addElement(f2_arg0.perk3Background)
	f2_arg0.perk3Image1 = LUI.UIImage.new()
	f2_arg0.perk3Image1:setLeftRight(true, false, f2_local32, f2_local32 + f2_local30)
	f2_arg0.perk3Image1:setTopBottom(true, false, f2_local28, f2_local28 + f2_local30)
	f2_arg0.perk3Image1:setAlpha(0)
	f2_arg0:addElement(f2_arg0.perk3Image1)
	f2_arg0.perk3Image2 = LUI.UIImage.new()
	f2_arg0.perk3Image2:setLeftRight(true, false, f2_local33, f2_local33 + f2_local30)
	f2_arg0.perk3Image2:setTopBottom(true, false, f2_local28, f2_local28 + f2_local30)
	f2_arg0.perk3Image2:setAlpha(0)
	f2_arg0:addElement(f2_arg0.perk3Image2)
	f2_local36 = f2_local28 + f2_local30 / 2 - f2_local8 / 2
	f2_arg0.perk3RestrictedImage1 = LUI.UIImage.new()
	f2_arg0.perk3RestrictedImage1:setLeftRight(true, false, f2_local34, f2_local34 + f2_local8)
	f2_arg0.perk3RestrictedImage1:setTopBottom(true, false, f2_local36, f2_local36 + f2_local8)
	f2_arg0.perk3RestrictedImage1:setAlpha(0)
	f2_arg0.perk3RestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.perk3RestrictedImage1)
	f2_arg0.perk3RestrictedImage2 = LUI.UIImage.new()
	f2_arg0.perk3RestrictedImage2:setLeftRight(true, false, f2_local35, f2_local35 + f2_local8)
	f2_arg0.perk3RestrictedImage2:setTopBottom(true, false, f2_local36, f2_local36 + f2_local8)
	f2_arg0.perk3RestrictedImage2:setAlpha(0)
	f2_arg0.perk3RestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.perk3RestrictedImage2)
	f2_local22 = f2_local22 + f2_local11 + f2_local6
	f2_arg0.primaryWeaponAttachmentsBackground = LUI.UIImage.new()
	f2_arg0.primaryWeaponAttachmentsBackground:setLeftRight(true, false, f2_local18, f2_local18 + f2_local9)
	f2_arg0.primaryWeaponAttachmentsBackground:setTopBottom(true, false, f2_local22, f2_local22 + f2_local7)
	f2_arg0.primaryWeaponAttachmentsBackground:setRGB(0, 0, 0)
	f2_arg0.primaryWeaponAttachmentsBackground:setAlpha(0.1)
	f2_arg0:addElement(f2_arg0.primaryWeaponAttachmentsBackground)
	local f2_local37 = 5
	local f2_local38 = f2_local7 - f2_local37 * 2
	local f2_local39 = f2_local6
	local f2_local40 = f2_local18 + f2_local9 - f2_local38 * 3 - f2_local39 * 3
	local f2_local41 = f2_local18 + f2_local9 - f2_local38 * 2 - f2_local39 * 2
	local f2_local42 = f2_local18 + f2_local9 - f2_local38 * 1 - f2_local39 * 1
	f2_arg0.primaryWeaponAttachmentsImage1 = LUI.UIImage.new()
	f2_arg0.primaryWeaponAttachmentsImage1:setLeftRight(true, false, f2_local40, f2_local40 + f2_local38)
	f2_arg0.primaryWeaponAttachmentsImage1:setTopBottom(true, false, f2_local22 + f2_local37, f2_local22 + f2_local37 + f2_local38)
	f2_arg0.primaryWeaponAttachmentsImage1:setAlpha(0)
	f2_arg0:addElement(f2_arg0.primaryWeaponAttachmentsImage1)
	f2_arg0.primaryWeaponAttachmentsImage2 = LUI.UIImage.new()
	f2_arg0.primaryWeaponAttachmentsImage2:setLeftRight(true, false, f2_local41, f2_local41 + f2_local38)
	f2_arg0.primaryWeaponAttachmentsImage2:setTopBottom(true, false, f2_local22 + f2_local37, f2_local22 + f2_local37 + f2_local38)
	f2_arg0.primaryWeaponAttachmentsImage2:setAlpha(0)
	f2_arg0:addElement(f2_arg0.primaryWeaponAttachmentsImage2)
	f2_arg0.primaryWeaponAttachmentsImage3 = LUI.UIImage.new()
	f2_arg0.primaryWeaponAttachmentsImage3:setLeftRight(true, false, f2_local42, f2_local42 + f2_local38)
	f2_arg0.primaryWeaponAttachmentsImage3:setTopBottom(true, false, f2_local22 + f2_local37, f2_local22 + f2_local37 + f2_local38)
	f2_arg0.primaryWeaponAttachmentsImage3:setAlpha(0)
	f2_arg0:addElement(f2_arg0.primaryWeaponAttachmentsImage3)
	local f2_local43 = f2_local40 + f2_local38 / 2 - f2_local8 / 2
	local f2_local44 = f2_local41 + f2_local38 / 2 - f2_local8 / 2
	local f2_local45 = f2_local42 + f2_local38 / 2 - f2_local8 / 2
	local f2_local46 = f2_local22 + f2_local37 + f2_local38 / 2 - f2_local8 / 2
	f2_arg0.primaryWeaponAttachmentsRestrictedImage1 = LUI.UIImage.new()
	f2_arg0.primaryWeaponAttachmentsRestrictedImage1:setLeftRight(true, false, f2_local43, f2_local43 + f2_local8)
	f2_arg0.primaryWeaponAttachmentsRestrictedImage1:setTopBottom(true, false, f2_local46, f2_local46 + f2_local8)
	f2_arg0.primaryWeaponAttachmentsRestrictedImage1:setAlpha(0)
	f2_arg0.primaryWeaponAttachmentsRestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.primaryWeaponAttachmentsRestrictedImage1)
	f2_arg0.primaryWeaponAttachmentsRestrictedImage2 = LUI.UIImage.new()
	f2_arg0.primaryWeaponAttachmentsRestrictedImage2:setLeftRight(true, false, f2_local44, f2_local44 + f2_local8)
	f2_arg0.primaryWeaponAttachmentsRestrictedImage2:setTopBottom(true, false, f2_local46, f2_local46 + f2_local8)
	f2_arg0.primaryWeaponAttachmentsRestrictedImage2:setAlpha(0)
	f2_arg0.primaryWeaponAttachmentsRestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.primaryWeaponAttachmentsRestrictedImage2)
	f2_arg0.primaryWeaponAttachmentsRestrictedImage3 = LUI.UIImage.new()
	f2_arg0.primaryWeaponAttachmentsRestrictedImage3:setLeftRight(true, false, f2_local45, f2_local45 + f2_local8)
	f2_arg0.primaryWeaponAttachmentsRestrictedImage3:setTopBottom(true, false, f2_local46, f2_local46 + f2_local8)
	f2_arg0.primaryWeaponAttachmentsRestrictedImage3:setAlpha(0)
	f2_arg0.primaryWeaponAttachmentsRestrictedImage3:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.primaryWeaponAttachmentsRestrictedImage3)
	f2_local22 = f2_local22 + f2_local7 + f2_local6
	f2_arg0.secondaryWeaponBackground = LUI.UIImage.new()
	f2_arg0.secondaryWeaponBackground:setLeftRight(true, false, f2_local18, f2_local18 + f2_local9)
	f2_arg0.secondaryWeaponBackground:setTopBottom(true, false, f2_local22, f2_local22 + f2_local7)
	f2_arg0.secondaryWeaponBackground:setRGB(0, 0, 0)
	f2_arg0.secondaryWeaponBackground:setAlpha(0.1)
	f2_arg0:addElement(f2_arg0.secondaryWeaponBackground)
	f2_arg0.secondaryWeaponBackgroundContainer = LUI.UIElement.new()
	f2_arg0.secondaryWeaponBackgroundContainer:setLeftRight(true, false, f2_local18, f2_local18 + f2_local9)
	f2_arg0.secondaryWeaponBackgroundContainer:setTopBottom(true, false, f2_local22, f2_local22 + f2_local7)
	f2_arg0:addElement(f2_arg0.secondaryWeaponBackgroundContainer)
	if CoD.ShouldShowWeaponLevel() then
		f2_arg0.secondaryWeaponLevelIconContainer = CoD.WeaponLevel.GetWeaponLevelIcon(40, 40, "ExtraSmall", 0)
		f2_arg0.secondaryWeaponBackgroundContainer:addElement(f2_arg0.secondaryWeaponLevelIconContainer)
		f2_arg0.secondaryWeaponLevelIconContainer:hide()
	end
	f2_arg0:addElement(f2_arg0.secondaryWeaponBackgroundContainer)
	local f2_local47 = 30
	local f2_local48 = f2_local7 * 2
	f2_arg0.secondaryWeaponImage = LUI.UIImage.new()
	f2_arg0.secondaryWeaponImage:setLeftRight(true, false, f2_local18 + f2_local9 - f2_local48 - f2_local47, f2_local18 + f2_local9 - f2_local47)
	f2_arg0.secondaryWeaponImage:setTopBottom(true, false, f2_local22, f2_local22 + f2_local7)
	f2_arg0.secondaryWeaponImage:setAlpha(0)
	f2_arg0:addElement(f2_arg0.secondaryWeaponImage)
	local f2_local49 = f2_local18 + f2_local9 - f2_local48 / 2 - f2_local8 / 2
	local f2_local50 = f2_local22 + f2_local7 / 2 - f2_local8 / 2
	f2_arg0.secondaryWeaponRestrictedImage = LUI.UIImage.new()
	f2_arg0.secondaryWeaponRestrictedImage:setLeftRight(true, false, f2_local49, f2_local49 + f2_local8)
	f2_arg0.secondaryWeaponRestrictedImage:setTopBottom(true, false, f2_local50, f2_local50 + f2_local8)
	f2_arg0.secondaryWeaponRestrictedImage:setAlpha(0)
	f2_arg0.secondaryWeaponRestrictedImage:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.secondaryWeaponRestrictedImage)
	f2_arg0.primarygrenadeBackground = LUI.UIImage.new()
	f2_arg0.primarygrenadeBackground:setLeftRight(true, false, f2_local20, f2_local20 + f2_local10)
	f2_arg0.primarygrenadeBackground:setTopBottom(true, false, f2_local22, f2_local22 + f2_local7)
	f2_arg0.primarygrenadeBackground:setRGB(0, 0, 0)
	f2_arg0.primarygrenadeBackground:setAlpha(0.1)
	f2_arg0:addElement(f2_arg0.primarygrenadeBackground)
	local f2_local51 = f2_local7 * 0.75
	local f2_local52 = f2_local31
	local f2_local53 = f2_local22 + f2_local7 / 2 - f2_local51 / 2
	local f2_local54 = f2_local20 + f2_local10 - f2_local7 * 2 - f2_local31 * 2 + f2_local7 / 2 - f2_local51 / 2
	local f2_local55 = f2_local20 + f2_local10 - f2_local7 * 1 - f2_local31 * 1 + f2_local7 / 2 - f2_local51 / 2
	f2_arg0.primarygrenadeImage1 = LUI.UIImage.new()
	f2_arg0.primarygrenadeImage1:setLeftRight(true, false, f2_local54, f2_local54 + f2_local51)
	f2_arg0.primarygrenadeImage1:setTopBottom(true, false, f2_local53, f2_local53 + f2_local51)
	f2_arg0.primarygrenadeImage1:setAlpha(0)
	f2_arg0:addElement(f2_arg0.primarygrenadeImage1)
	f2_arg0.primarygrenadeImage2 = LUI.UIImage.new()
	f2_arg0.primarygrenadeImage2:setLeftRight(true, false, f2_local55, f2_local55 + f2_local51)
	f2_arg0.primarygrenadeImage2:setTopBottom(true, false, f2_local53, f2_local53 + f2_local51)
	f2_arg0.primarygrenadeImage2:setAlpha(0)
	f2_arg0:addElement(f2_arg0.primarygrenadeImage2)
	local f2_local56 = f2_local54 + f2_local51 / 2 - f2_local8 / 2
	local f2_local57 = f2_local55 + f2_local51 / 2 - f2_local8 / 2
	local f2_local58 = f2_local53 + f2_local51 / 2 - f2_local8 / 2
	f2_arg0.primarygrenadeRestrictedImage1 = LUI.UIImage.new()
	f2_arg0.primarygrenadeRestrictedImage1:setLeftRight(true, false, f2_local56, f2_local56 + f2_local8)
	f2_arg0.primarygrenadeRestrictedImage1:setTopBottom(true, false, f2_local58, f2_local58 + f2_local8)
	f2_arg0.primarygrenadeRestrictedImage1:setAlpha(0)
	f2_arg0.primarygrenadeRestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.primarygrenadeRestrictedImage1)
	f2_arg0.primarygrenadeRestrictedImage2 = LUI.UIImage.new()
	f2_arg0.primarygrenadeRestrictedImage2:setLeftRight(true, false, f2_local57, f2_local57 + f2_local8)
	f2_arg0.primarygrenadeRestrictedImage2:setTopBottom(true, false, f2_local58, f2_local58 + f2_local8)
	f2_arg0.primarygrenadeRestrictedImage2:setAlpha(0)
	f2_arg0.primarygrenadeRestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.primarygrenadeRestrictedImage2)
	f2_local22 = f2_local22 + f2_local7 + f2_local6
	f2_arg0.specialgrenadeBackground = LUI.UIImage.new()
	f2_arg0.specialgrenadeBackground:setLeftRight(true, false, f2_local20, f2_local20 + f2_local10)
	f2_arg0.specialgrenadeBackground:setTopBottom(true, false, f2_local22, f2_local22 + f2_local7)
	f2_arg0.specialgrenadeBackground:setRGB(0, 0, 0)
	f2_arg0.specialgrenadeBackground:setAlpha(0.1)
	f2_arg0:addElement(f2_arg0.specialgrenadeBackground)
	local f2_local59 = f2_local7 * 0.75
	local f2_local60 = f2_local31
	local f2_local61 = f2_local22 + f2_local7 / 2 - f2_local59 / 2
	local f2_local62 = f2_local20 + f2_local10 - f2_local7 * 2 - f2_local31 * 2 + f2_local7 / 2 - f2_local59 / 2
	local f2_local63 = f2_local20 + f2_local10 - f2_local7 * 1 - f2_local31 * 1 + f2_local7 / 2 - f2_local59 / 2
	f2_arg0.specialgrenadeImage1 = LUI.UIImage.new()
	f2_arg0.specialgrenadeImage1:setLeftRight(true, false, f2_local62, f2_local62 + f2_local59)
	f2_arg0.specialgrenadeImage1:setTopBottom(true, false, f2_local61, f2_local61 + f2_local59)
	f2_arg0.specialgrenadeImage1:setAlpha(0)
	f2_arg0:addElement(f2_arg0.specialgrenadeImage1)
	f2_arg0.specialgrenadeImage2 = LUI.UIImage.new()
	f2_arg0.specialgrenadeImage2:setLeftRight(true, false, f2_local63, f2_local63 + f2_local59)
	f2_arg0.specialgrenadeImage2:setTopBottom(true, false, f2_local61, f2_local61 + f2_local59)
	f2_arg0.specialgrenadeImage2:setAlpha(0)
	f2_arg0:addElement(f2_arg0.specialgrenadeImage2)
	local f2_local64 = f2_local62 + f2_local59 / 2 - f2_local8 / 2
	local f2_local65 = f2_local63 + f2_local59 / 2 - f2_local8 / 2
	local f2_local66 = f2_local61 + f2_local59 / 2 - f2_local8 / 2
	f2_arg0.specialgrenadeRestrictedImage1 = LUI.UIImage.new()
	f2_arg0.specialgrenadeRestrictedImage1:setLeftRight(true, false, f2_local64, f2_local64 + f2_local8)
	f2_arg0.specialgrenadeRestrictedImage1:setTopBottom(true, false, f2_local66, f2_local66 + f2_local8)
	f2_arg0.specialgrenadeRestrictedImage1:setAlpha(0)
	f2_arg0.specialgrenadeRestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.specialgrenadeRestrictedImage1)
	f2_arg0.specialgrenadeRestrictedImage2 = LUI.UIImage.new()
	f2_arg0.specialgrenadeRestrictedImage2:setLeftRight(true, false, f2_local65, f2_local65 + f2_local8)
	f2_arg0.specialgrenadeRestrictedImage2:setTopBottom(true, false, f2_local66, f2_local66 + f2_local8)
	f2_arg0.specialgrenadeRestrictedImage2:setAlpha(0)
	f2_arg0.specialgrenadeRestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.specialgrenadeRestrictedImage2)
	f2_arg0.secondaryWeaponAttachmentsBackground = LUI.UIImage.new()
	f2_arg0.secondaryWeaponAttachmentsBackground:setLeftRight(true, false, f2_local18, f2_local18 + f2_local9)
	f2_arg0.secondaryWeaponAttachmentsBackground:setTopBottom(true, false, f2_local22, f2_local22 + f2_local7)
	f2_arg0.secondaryWeaponAttachmentsBackground:setRGB(0, 0, 0)
	f2_arg0.secondaryWeaponAttachmentsBackground:setAlpha(0.1)
	f2_arg0:addElement(f2_arg0.secondaryWeaponAttachmentsBackground)
	f2_arg0.secondaryWeaponAttachmentsImage1 = LUI.UIImage.new()
	f2_arg0.secondaryWeaponAttachmentsImage1:setLeftRight(true, false, f2_local40, f2_local40 + f2_local38)
	f2_arg0.secondaryWeaponAttachmentsImage1:setTopBottom(true, false, f2_local22 + f2_local37, f2_local22 + f2_local37 + f2_local38)
	f2_arg0.secondaryWeaponAttachmentsImage1:setAlpha(0)
	f2_arg0:addElement(f2_arg0.secondaryWeaponAttachmentsImage1)
	f2_arg0.secondaryWeaponAttachmentsImage2 = LUI.UIImage.new()
	f2_arg0.secondaryWeaponAttachmentsImage2:setLeftRight(true, false, f2_local41, f2_local41 + f2_local38)
	f2_arg0.secondaryWeaponAttachmentsImage2:setTopBottom(true, false, f2_local22 + f2_local37, f2_local22 + f2_local37 + f2_local38)
	f2_arg0.secondaryWeaponAttachmentsImage2:setAlpha(0)
	f2_arg0:addElement(f2_arg0.secondaryWeaponAttachmentsImage2)
	local f2_local67 = f2_local22 + f2_local37 + f2_local38 / 2 - f2_local8 / 2
	f2_arg0.secondaryWeaponAttachmentsRestrictedImage1 = LUI.UIImage.new()
	f2_arg0.secondaryWeaponAttachmentsRestrictedImage1:setLeftRight(true, false, f2_local43, f2_local43 + f2_local8)
	f2_arg0.secondaryWeaponAttachmentsRestrictedImage1:setTopBottom(true, false, f2_local67, f2_local67 + f2_local8)
	f2_arg0.secondaryWeaponAttachmentsRestrictedImage1:setAlpha(0)
	f2_arg0.secondaryWeaponAttachmentsRestrictedImage1:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.secondaryWeaponAttachmentsRestrictedImage1)
	f2_arg0.secondaryWeaponAttachmentsRestrictedImage2 = LUI.UIImage.new()
	f2_arg0.secondaryWeaponAttachmentsRestrictedImage2:setLeftRight(true, false, f2_local44, f2_local44 + f2_local8)
	f2_arg0.secondaryWeaponAttachmentsRestrictedImage2:setTopBottom(true, false, f2_local67, f2_local67 + f2_local8)
	f2_arg0.secondaryWeaponAttachmentsRestrictedImage2:setAlpha(0)
	f2_arg0.secondaryWeaponAttachmentsRestrictedImage2:setImage(RegisterMaterial("cac_restricted"))
	f2_arg0:addElement(f2_arg0.secondaryWeaponAttachmentsRestrictedImage2)
	f2_local22 = f2_local22 + f2_local7 + f2_local6
	local f2_local68 = f2_local18
	local f2_local69 = (f2_arg0.width - f2_local6 * (CoD.CACUtility.maxBonusCards - 1)) / CoD.CACUtility.maxBonusCards
	local f2_local70 = f2_local22 - 11
	local f2_local71 = f2_local7 + 10
	local f2_local72 = f2_local71 * 2
	local f2_local73 = -20
	for f2_local74 = 1, CoD.CACUtility.maxBonusCards, 1 do
		local f2_local77 = LUI.UIImage.new()
		f2_local77:setLeftRight(true, false, f2_local68, f2_local68 + f2_local69)
		f2_local77:setTopBottom(true, false, f2_local22, f2_local22 + f2_local7)
		f2_local77:setRGB(0, 0, 0)
		f2_local77:setAlpha(0.1)
		f2_arg0:addElement(f2_local77)
		local f2_local78 = f2_local68 + f2_local69 - f2_local72 + 30
		local f2_local79 = LUI.UIImage.new()
		f2_local79:setLeftRight(true, false, f2_local78, f2_local78 + f2_local72)
		f2_local79:setTopBottom(true, false, f2_local70, f2_local70 + f2_local71)
		f2_local79:setAlpha(0)
		f2_arg0:addElement(f2_local79)
		f2_arg0["bonusCardImage" .. f2_local74] = f2_local79
		local f2_local80 = f2_local78 + f2_local72 / 2 - f2_local8 / 2
		local f2_local81 = f2_local70 + f2_local71 / 2 - f2_local8 / 2
		local f2_local82 = LUI.UIImage.new()
		f2_local82:setLeftRight(true, false, f2_local80, f2_local80 + f2_local8)
		f2_local82:setTopBottom(true, false, f2_local81, f2_local81 + f2_local8)
		f2_local82:setAlpha(0)
		f2_local82:setImage(RegisterMaterial("cac_restricted"))
		f2_arg0:addElement(f2_local82)
		f2_arg0["bonusCardRestrictedImage" .. f2_local74] = f2_local82
		f2_local68 = f2_local68 + f2_local69 + f2_local6
	end
end

CoD.SplitscreenClassPreview.UpdateClass = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	if f3_arg3 then
		f3_arg2 = Engine.GetClassIndexFromName(f3_arg3)
	end
	local f3_local0 = Engine.GetCustomClass(f3_arg1, f3_arg2)
	CoD.AllocationStatus.Update(f3_arg0.allocationStatus, {
		class = f3_local0
	})
	f3_arg0.allocationBar:processEvent({
		name = "update_class",
		class = f3_local0
	})
	local f3_local1 = f3_local0.primary
	if f3_local1 == nil then
		f3_arg0.primaryWeaponImage:hide()
		f3_arg0.primaryWeaponRestrictedImage:hide()
		f3_arg0.primaryWeaponBackgroundContainer:hide()
	else
		f3_arg0.primaryWeaponImage:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f3_local1) .. "_big"))
		f3_arg0.primaryWeaponImage:show()
		f3_arg0.primaryWeaponBackgroundContainer:show()
		if f3_arg0.primaryWeaponLevelIconContainer then
			f3_arg0.primaryWeaponLevelIconContainer:update(f3_arg1, f3_local1)
		end
		local f3_local2 = 0
		if Engine.IsItemIndexRestricted(f3_local1) then
			f3_local2 = 1
		end
		f3_arg0.primaryWeaponRestrictedImage:setAlpha(f3_local2)
	end
	CoD.SplitscreenClassPreview.UpdatePerkCategory(f3_arg0, 1, f3_local0)
	CoD.SplitscreenClassPreview.UpdatePerkCategory(f3_arg0, 2, f3_local0)
	CoD.SplitscreenClassPreview.UpdatePerkCategory(f3_arg0, 3, f3_local0)
	CoD.SplitscreenClassPreview.UpdateAttachments(f3_arg0, f3_arg1, "primary", f3_local0, f3_arg2)
	local f3_local2 = f3_local0.secondary
	if f3_local2 == nil then
		f3_arg0.secondaryWeaponImage:hide()
		f3_arg0.secondaryWeaponRestrictedImage:hide()
		f3_arg0.secondaryWeaponBackgroundContainer:hide()
	else
		f3_arg0.secondaryWeaponImage:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f3_local2) .. "_big"))
		f3_arg0.secondaryWeaponImage:show()
		f3_arg0.secondaryWeaponBackgroundContainer:show()
		if f3_arg0.secondaryWeaponLevelIconContainer then
			f3_arg0.secondaryWeaponLevelIconContainer:update(f3_arg1, f3_local2)
		end
		local f3_local3 = 0
		if Engine.IsItemIndexRestricted(f3_local2) then
			f3_local3 = 1
		end
		f3_arg0.secondaryWeaponRestrictedImage:setAlpha(f3_local3)
	end
	CoD.SplitscreenClassPreview.UpdateGrenades(f3_arg0, f3_arg1, "primarygrenade", f3_local0, f3_arg2)
	CoD.SplitscreenClassPreview.UpdateGrenades(f3_arg0, f3_arg1, "specialgrenade", f3_local0, f3_arg2)
	CoD.SplitscreenClassPreview.UpdateAttachments(f3_arg0, f3_arg1, "secondary", f3_local0, f3_arg2)
	CoD.SplitscreenClassPreview.UpdateBonusCards(f3_arg0, f3_local0)
end

CoD.SplitscreenClassPreview.UpdatePerkCategory = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = 2
	for f4_local1 = 1, f4_local0, 1 do
		local f4_local4 = f4_arg2["specialty" .. f4_arg1 + f4_local1 - 1 * CoD.CACUtility.maxPerkCategories]
		if f4_local4 == nil then
			local f4_local5 = "perk"
			local f4_local6 = f4_arg1
			f4_arg0[f4_local5 .. f4_arg1 .. "Image" .. f4_local1]:setAlpha(0)
			f4_local5 = "perk"
			f4_local6 = f4_arg1
			f4_arg0[f4_local5 .. f4_arg1 .. "RestrictedImage" .. f4_local1]:setAlpha(0)
		end
		local f4_local5 = "perk"
		f4_arg0["perk" .. f4_arg1 .. "Image" .. f4_local1]:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f4_local4)))
		f4_local5 = "perk"
		local f4_local6 = f4_arg1
		f4_arg0[f4_local5 .. f4_arg1 .. "Image" .. f4_local1]:setAlpha(1)
		f4_local5 = 0
		if Engine.IsItemIndexRestricted(f4_local4) then
			f4_local5 = 1
		end
		f4_local6 = "perk"
		local f4_local7 = f4_arg1
		f4_arg0[f4_local6 .. f4_arg1 .. "RestrictedImage" .. f4_local1]:setAlpha(f4_local5)
	end
end

CoD.SplitscreenClassPreview.UpdateAttachments = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	local f5_local0 = f5_arg3[f5_arg2]
	local f5_local1 = 2
	if f5_arg2 == "primary" then
		f5_local1 = 3
	end
	for f5_local2 = 1, f5_local1, 1 do
		local f5_local5 = f5_arg2
		f5_arg0[f5_arg2 .. "WeaponAttachmentsImage" .. f5_local2]:setAlpha(0)
		f5_local5 = f5_arg2
		f5_arg0[f5_arg2 .. "WeaponAttachmentsRestrictedImage" .. f5_local2]:setAlpha(0)
	end
	if f5_local0 ~= nil then
		for f5_local2 = 0, 2, 1 do
			local f5_local5 = f5_arg3[f5_arg2 .. "attachment" .. f5_local2 + 1]
			if f5_local5 ~= nil and f5_local5 ~= 0 then
				local f5_local6 = Engine.GetAttachmentImage(f5_local0, f5_local5)
				local f5_local7 = f5_arg2
				f5_arg0[f5_arg2 .. "WeaponAttachmentsImage" .. f5_local2 + 1]:setImage(RegisterMaterial(f5_local6))
				f5_local7 = f5_arg2
				f5_arg0[f5_arg2 .. "WeaponAttachmentsImage" .. f5_local2 + 1]:setAlpha(1)
				f5_local7 = 0
				local f5_local8 = Engine.GetItemAttachment(f5_local0, f5_local5)
				local f5_local9 = Engine.IsAttachmentIndexRestricted(f5_local8)
				if Engine.IsAttachmentIndexRestricted(f5_local8) then
					f5_local7 = 1
				end
				local f5_local10 = f5_arg2
				f5_arg0[f5_arg2 .. "WeaponAttachmentsRestrictedImage" .. f5_local2 + 1]:setAlpha(f5_local7)
			end
		end
	end
end

CoD.SplitscreenClassPreview.UpdateGrenades = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	local f6_local0 = f6_arg3[f6_arg2]
	local f6_local1 = 2
	if f6_local0 == nil then
		for f6_local2 = 1, f6_local1, 1 do
			local f6_local5 = f6_arg2
			f6_arg0[f6_arg2 .. "Image" .. f6_local2]:setAlpha(0)
			f6_local5 = f6_arg2
			f6_arg0[f6_arg2 .. "RestrictedImage" .. f6_local2]:setAlpha(0)
		end
	else
		local f6_local2 = 0
		for f6_local3 = 1, f6_local1, 1 do
			if Engine.GetClassItem(f6_arg1, f6_arg4, f6_arg2 .. "status" .. f6_local3) == 1 then
				f6_arg0[f6_arg2 .. "Image" .. f6_local3]:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f6_local0) .. "_256"))
				local f6_local7 = f6_arg2
				f6_arg0[f6_arg2 .. "Image" .. f6_local3]:setAlpha(1)
				f6_local7 = 0
				if Engine.IsItemIndexRestricted(f6_local0) then
					f6_local7 = 1
				end
				local f6_local8 = f6_arg2
				f6_arg0[f6_arg2 .. "RestrictedImage" .. f6_local3]:setAlpha(f6_local7)
				f6_local2 = f6_local2 + 1
			end
			local f6_local7 = f6_arg2
			f6_arg0[f6_arg2 .. "Image" .. f6_local3]:setAlpha(0)
			f6_local7 = f6_arg2
			f6_arg0[f6_arg2 .. "RestrictedImage" .. f6_local3]:setAlpha(0)
		end
	end
end

CoD.SplitscreenClassPreview.UpdateBonusCards = function (f7_arg0, f7_arg1)
	for f7_local0 = 1, CoD.CACUtility.maxBonusCards, 1 do
		local f7_local3 = f7_arg1["bonuscard" .. f7_local0]
		if f7_local3 ~= nil then
			local f7_local4 = UIExpression.GetItemRef(nil, f7_local3)
			f7_arg0["bonusCardImage" .. f7_local0]:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f7_local3)))
			f7_arg0["bonusCardImage" .. f7_local0]:setAlpha(1)
			local f7_local5 = 0
			if Engine.IsItemIndexRestricted(f7_local3) then
				f7_local5 = 1
			end
			f7_arg0["bonusCardRestrictedImage" .. f7_local0]:setAlpha(f7_local5)
		end
		f7_arg0["bonusCardImage" .. f7_local0]:setAlpha(0)
		f7_arg0["bonusCardRestrictedImage" .. f7_local0]:setAlpha(0)
	end
end

