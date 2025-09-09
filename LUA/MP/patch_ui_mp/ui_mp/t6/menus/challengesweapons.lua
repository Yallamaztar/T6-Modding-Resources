require("T6.Menus.WeaponChallengeType")
CoD.ChallengesWeapons = {}
LUI.createMenu.ChallengesWeapons = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("ChallengesWeapons")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:setPreviousMenu("Barracks")
	f1_local0.goBack = CoD.ChallengesWeapons.GoBack
	f1_local0:registerEventHandler("card_gain_focus", CoD.ChallengesWeapons.CardGainFocus)
	f1_local0:registerEventHandler("card_lose_focus", CoD.ChallengesWeapons.CardLoseFocus)
	f1_local0:registerEventHandler("open_weapon_challenges_type", CoD.ChallengesWeapons.OpenChallengesType)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	local f1_local1 = CoD.perController[f1_arg0].weaponSlot
	local f1_local2 = "MENU_CHALLENGES_PRIMARY_WEAPON_UNLOCKS"
	if f1_local1 == "secondary" then
		f1_local2 = "MENU_CHALLENGES_SECONDARY_WEAPON_UNLOCKS"
	end
	f1_local0:addTitle(Engine.Localize(f1_local2))
	local f1_local3 = CoD.textSize.Big + 10
	local f1_local4 = CoD.CardCarouselList.new(nil, f1_arg0, CoD.Barracks.ItemWidth, CoD.Barracks.ItemHeight, CoD.Barracks.HighlightedItemWidth, CoD.Barracks.HighligtedItemHeight, CoD.Barracks.HintTextParams)
	f1_local4:setLeftRight(true, true, 0, 0)
	f1_local4:setTopBottom(true, true, f1_local3, -CoD.ButtonPrompt.Height)
	f1_local0:addElement(f1_local4)
	f1_local4.popup = f1_local0
	f1_local4.titleListContainer.spacing = 0
	f1_local4.titleListContainer:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = -CoD.CoD9Button.Height,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local4.cardCarouselSize + 70,
		bottom = 0
	})
	f1_local4.titleListContainer:animateToState("default")
	f1_local3 = f1_local3 + f1_local4.cardCarouselSize - 7
	if f1_local1 ~= nil then
		CoD.ChallengesWeapons.AddCarousels(f1_local4, f1_arg0, f1_local1)
		f1_local0.weaponSlot = f1_local1
	end
	if CoD.ChallengesWeapons.CurrentCarouselInfo then
		f1_local4:setInitialCarousel(CoD.ChallengesWeapons.CurrentCarouselInfo.carouselIndex, CoD.ChallengesWeapons.CurrentCarouselInfo.cardIndex)
	end
	local f1_local5 = f1_local3 + 97
	local f1_local6 = LUI.UIImage.new()
	f1_local6:setLeftRight(true, false, 0, CoD.Menu.Width / 2 - 85)
	f1_local6:setTopBottom(true, false, f1_local5, f1_local5 + 1)
	f1_local6:setAlpha(0.05)
	f1_local0:addElement(f1_local6)
	f1_local4:focusCurrentCardCarousel(f1_arg0)
	return f1_local0
end

CoD.ChallengesWeapons.OpenChallengesType = function (f2_arg0, f2_arg1)
	CoD.ChallengesWeapons.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo(f2_arg1.button)
	CoD.perController[f2_arg1.controller].weaponIndex = f2_arg1.button.weaponItemIndex
	f2_arg0:openMenu("WeaponChallengeType", f2_arg1.controller)
	f2_arg0:close()
end

CoD.ChallengesWeapons.GoBack = function (f3_arg0, f3_arg1)
	CoD.ChallengesWeapons.CurrentCarouselInfo = nil
	CoD.Menu.goBack(f3_arg0, f3_arg1)
end

CoD.ChallengesWeapons.CardGainFocus = function (f4_arg0, f4_arg1)
	local f4_local0 = nil
	if f4_arg1.card.isLocked then
		f4_local0 = CoD.GetUnlockStringForItemIndex(f4_arg1.controller, f4_arg1.card.weaponItemIndex)
		f4_arg0:removeSelectButton()
	elseif UIExpression.IsItemPurchased(controller, f4_arg1.card.weaponItemIndex) == 0 then
		f4_local0 = Engine.Localize("MENU_CHALLENGES_WEAPON_HINTTEXT_UNLOCK")
		f4_arg0:removeSelectButton()
	else
		f4_local0 = Engine.Localize("MENU_CHALLENGES_WEAPON_HINTTEXT_AVAILABLE", UIExpression.GetItemName(nil, f4_arg1.card.weaponItemIndex))
		f4_arg0:addSelectButtonWithPrestigeUnlock()
	end
	f4_arg0:dispatchEventToChildren({
		name = "hint_text_fade_in",
		hintText = f4_local0
	})
end

CoD.ChallengesWeapons.CardLoseFocus = function (f5_arg0, f5_arg1)
	f5_arg0:dispatchEventToChildren({
		name = "hint_text_fade_out"
	})
end

CoD.ChallengesWeapons.AddCarousels = function (f6_arg0, f6_arg1, f6_arg2)
	if f6_arg2 == "primary" then
		CoD.ChallengesWeapons.AddWeaponGroupCarousel(f6_arg0, f6_arg1, "weapon_smg")
		CoD.ChallengesWeapons.AddWeaponGroupCarousel(f6_arg0, f6_arg1, "weapon_assault")
		CoD.ChallengesWeapons.AddWeaponGroupCarousel(f6_arg0, f6_arg1, "weapon_cqb")
		CoD.ChallengesWeapons.AddWeaponGroupCarousel(f6_arg0, f6_arg1, "weapon_lmg")
		CoD.ChallengesWeapons.AddWeaponGroupCarousel(f6_arg0, f6_arg1, "weapon_sniper")
		CoD.ChallengesWeapons.AddWeaponGroupCarousel(f6_arg0, f6_arg1, "weapon_special")
	else
		CoD.ChallengesWeapons.AddWeaponGroupCarousel(f6_arg0, f6_arg1, "weapon_pistol")
		CoD.ChallengesWeapons.AddWeaponGroupCarousel(f6_arg0, f6_arg1, "weapon_launcher")
		CoD.ChallengesWeapons.AddWeaponGroupCarousel(f6_arg0, f6_arg1, "weapon_special")
	end
end

CoD.ChallengesWeapons.AddWeaponGroupCarousel = function (f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = f7_arg0:addCardCarousel(Engine.Localize("MPUI_" .. f7_arg2 .. "_CAPS"))
	local f7_local1 = CoD.GetUnlockablesByGroupName(f7_arg2)
	local f7_local2 = CoD.perController[f7_arg1].weaponSlot
	local f7_local3 = RegisterMaterial(CoD.CACUtility.LockImageBigMaterial)
	CoD.Barracks.SetupCardCarouselTitleTextPosition(f7_local0, f7_arg0)
	for f7_local8, f7_local9 in ipairs(f7_local1) do
		if Engine.GetLoadoutSlotForItem(f7_local9) == f7_local2 then
			local f7_local7 = f7_local0:addNewCard()
			f7_local7.weaponItemIndex = f7_local9
			f7_local7.iconMaterial = RegisterMaterial(UIExpression.GetItemImage(nil, f7_local9) .. "_big")
			f7_local7.icon = LUI.UIImage.new()
			f7_local7.icon:setLeftRight(true, true, 10, -10)
			f7_local7.icon:setTopBottom(true, true, 20, -30)
			f7_local7.icon:setRGB(1, 1, 1)
			f7_local7.icon:setImage(f7_local7.iconMaterial)
			f7_local7.title = LUI.UIText.new()
			f7_local7.title:setLeftRight(true, true, 5, 0)
			f7_local7.title:setTopBottom(false, true, -CoD.textSize.Default, 0)
			f7_local7.title:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
			f7_local7.title:setAlignment(LUI.Alignment.Left)
			f7_local7.title:setFont(CoD.fonts.Default)
			f7_local7.title:setText(Engine.Localize(UIExpression.GetItemName(nil, f7_local9)))
			f7_local7.title:registerAnimationState("button_over", {
				red = CoD.BOIIOrange.r,
				green = CoD.BOIIOrange.g,
				blue = CoD.BOIIOrange.b
			})
			LUI.UIButton.SetupElement(f7_local7.title)
			f7_local7:addElement(f7_local7.title)
			if UIExpression.IsItemLocked(f7_arg1, f7_local9) == 1 then
				f7_local7.lockedIcon = CoD.CAC.SetLockIcon(f7_local7, 64, f7_local3)
				f7_local7.isLocked = true
				f7_local7.icon:setAlpha(0.25)
				f7_local7.title:registerAnimationState("button_over", {
					red = CoD.offWhite.r,
					green = CoD.offWhite.g,
					blue = CoD.offWhite.b
				})
			elseif UIExpression.IsItemPurchased(f7_arg1, f7_local9) == 0 then
				f7_local7.lockedIcon = CoD.CAC.SetLockIcon(f7_local7, 64, f7_local3)
				f7_local7.icon:setAlpha(0.25)
				f7_local7.title:registerAnimationState("button_over", {
					red = CoD.offWhite.r,
					green = CoD.offWhite.g,
					blue = CoD.offWhite.b
				})
			else
				f7_local7:setActionEventName("open_weapon_challenges_type")
				f7_local7:addElement(f7_local7.icon)
			end
			if f7_local7.border then
				f7_local7.border:close()
			end
			if f7_local7.highlightedborder then
				f7_local7.highlightedborder:close()
			end
			CoD.ContentGridButton.SetupButtonImages(f7_local7, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
		end
	end
end

