require("T6.Menus.WeaponAttachmentChallenges")
require("T6.Menus.WeaponCamoChallenges")
require("T6.Menus.WeaponMasteryChallenges")
CoD.WeaponChallengeType = {}
LUI.createMenu.WeaponChallengeType = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("WeaponChallengeType")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:setPreviousMenu("ChallengesWeapons")
	f1_local0.goBack = CoD.WeaponChallengeType.GoBack
	f1_local0:registerEventHandler("open_weapon_attachments_challenges", CoD.WeaponChallengeType.OpenAttachmentChallenges)
	f1_local0:registerEventHandler("open_weapon_camo_challenges", CoD.WeaponChallengeType.OpenCamoChallenges)
	f1_local0:registerEventHandler("open_weapon_mastery_challenges", CoD.WeaponChallengeType.OpenMasteryChallenges)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	local f1_local1 = CoD.perController[f1_arg0].weaponIndex
	local f1_local2 = CoD.perController[f1_arg0].weaponSlot
	local f1_local3 = ""
	if f1_local1 ~= nil then
		f1_local3 = UIExpression.ToUpper(nil, Engine.Localize("MENU_CHALLENGES_WEAPON_CHALLENGE_TYPE", UIExpression.GetItemName(nil, f1_local1)))
	end
	f1_local0:addTitle(f1_local3)
	local f1_local4 = CoD.CardCarouselList.new(nil, f1_arg0, CoD.Barracks.ItemWidth, CoD.Barracks.ItemHeight, CoD.Barracks.HighlightedItemWidth, CoD.Barracks.HighligtedItemHeight, CoD.Barracks.HintTextParams)
	f1_local4:setLeftRight(true, true, 0, 0)
	f1_local4:setTopBottom(true, true, CoD.textSize.Big + 10, 0)
	f1_local0:addElement(f1_local4)
	f1_local4.popup = f1_local0
	if f1_local1 ~= nil and f1_local2 ~= nil then
		CoD.WeaponChallengeType.AddCarousels(f1_local4, f1_arg0, f1_local2, f1_local1)
	end
	if CoD.WeaponChallengeType.CurrentCarouselInfo then
		f1_local4:setInitialCarousel(CoD.WeaponChallengeType.CurrentCarouselInfo.carouselIndex, CoD.WeaponChallengeType.CurrentCarouselInfo.cardIndex)
	end
	f1_local4:focusCurrentCardCarousel(f1_arg0)
	return f1_local0
end

CoD.WeaponChallengeType.OpenAttachmentChallenges = function (f2_arg0, f2_arg1)
	CoD.WeaponChallengeType.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo(f2_arg1.button)
	f2_arg0:openMenu("WeaponAttachmentChallenges", f2_arg1.controller)
	f2_arg0:close()
end

CoD.WeaponChallengeType.OpenCamoChallenges = function (f3_arg0, f3_arg1)
	CoD.WeaponChallengeType.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo(f3_arg1.button)
	f3_arg0:openMenu("WeaponCamoChallenges", f3_arg1.controller)
	f3_arg0:close()
end

CoD.WeaponChallengeType.OpenMasteryChallenges = function (f4_arg0, f4_arg1)
	CoD.WeaponChallengeType.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo(f4_arg1.button)
	f4_arg0:openMenu("WeaponMasteryChallenges", f4_arg1.controller)
	f4_arg0:close()
end

CoD.WeaponChallengeType.GoBack = function (f5_arg0, f5_arg1)
	CoD.WeaponChallengeType.CurrentCarouselInfo = nil
	CoD.Menu.goBack(f5_arg0, f5_arg1)
end

CoD.WeaponChallengeType.AddCard = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5)
	local f6_local0 = f6_arg0:addNewCard()
	f6_local0.hintText = f6_arg5
	f6_local0.weaponItemIndex = f6_arg3
	f6_local0.weaponSlot = f6_arg2
	f6_local0.iconMaterial = RegisterMaterial(UIExpression.GetItemImage(nil, f6_arg3) .. "_big")
	f6_local0.icon = LUI.UIImage.new()
	f6_local0.icon:setLeftRight(true, true, 10, -10)
	f6_local0.icon:setTopBottom(true, true, 20, -30)
	f6_local0.icon:setRGB(1, 1, 1)
	f6_local0.icon:setImage(f6_local0.iconMaterial)
	f6_local0:addElement(f6_local0.icon)
	f6_local0.title = LUI.UIText.new()
	f6_local0.title:setLeftRight(true, true, 5, 0)
	f6_local0.title:setTopBottom(false, true, -CoD.textSize.Default, 0)
	f6_local0.title:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f6_local0.title:setAlignment(LUI.Alignment.Left)
	f6_local0.title:setFont(CoD.fonts.Default)
	f6_local0.title:setText(f6_arg1)
	f6_local0.title:registerAnimationState("button_over", {
		red = CoD.BOIIOrange.r,
		green = CoD.BOIIOrange.g,
		blue = CoD.BOIIOrange.b
	})
	LUI.UIButton.SetupElement(f6_local0.title)
	f6_local0:addElement(f6_local0.title)
	f6_local0:setActionEventName(f6_arg4)
	if f6_local0.border then
		f6_local0.border:close()
	end
	if f6_local0.highlightedborder then
		f6_local0.highlightedborder:close()
	end
	CoD.ContentGridButton.SetupButtonImages(f6_local0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
end

CoD.WeaponChallengeType.AddCarousels = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	local f7_local0 = f7_arg0:addCardCarousel("")
	local f7_local1 = Engine.GetNumAttachments(f7_arg3) - 1
	if f7_local1 < 0 then
		f7_local1 = 0
	end
	if f7_local1 > 0 then
		CoD.WeaponChallengeType.AddCard(f7_local0, Engine.Localize("MPUI_ATTACHMENTS"), f7_arg2, f7_arg3, "open_weapon_attachments_challenges", Engine.Localize("MENU_CHALLENGES_ATTACHMENTS_HINT", UIExpression.GetItemName(nil, f7_arg3)))
	end
	CoD.WeaponChallengeType.AddCard(f7_local0, Engine.Localize("MPUI_CAMO"), f7_arg2, f7_arg3, "open_weapon_camo_challenges", Engine.Localize("MENU_CHALLENGES_CAMO_HINT", UIExpression.GetItemName(nil, f7_arg3)))
	CoD.WeaponChallengeType.AddCard(f7_local0, Engine.Localize("MENU_CHALLENGES_WEAPON_MASTERY", UIExpression.GetItemName(nil, f7_arg3)), f7_arg2, f7_arg3, "open_weapon_mastery_challenges", Engine.Localize("MENU_CHALLENGES_WEAPON_MASTERY_HINT", UIExpression.GetItemName(nil, f7_arg3)))
end

