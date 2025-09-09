require("T6.AllocationBar")
require("T6.CardCarouselList")
require("T6.WeaponLevel")
CoD.CACPrimaryWeapons = {}
CoD.CACPrimaryWeapons.ItemWidth = 192
CoD.CACPrimaryWeapons.ItemHeight = 146
CoD.CACPrimaryWeapons.HighlightedItemWidth = 345.6
CoD.CACPrimaryWeapons.HighlightedItemHeight = 217.8
LUI.createMenu.CACPrimaryWeapons = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CACPrimaryWeapons")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("equip", CoD.CACPrimaryWeapons.Equip)
	f1_local0:registerEventHandler("purchased", CoD.CACPrimaryWeapons.Purchased)
	f1_local0:registerEventHandler("weapon_chosen", CoD.CACPrimaryWeapons.WeaponChosen)
	f1_local0:registerEventHandler("card_gain_focus", CoD.CACPrimaryWeapons.CardGainFocus)
	f1_local0:registerEventHandler("card_lose_focus", CoD.CACPrimaryWeapons.CardLoseFocus)
	f1_local0:registerEventHandler("prestige_unlock", CoD.CACPrimaryWeapons.PrestigeUnlock)
	f1_local0:registerEventHandler("weapon_prestige", CoD.CACPrimaryWeapons.WeaponPrestige)
	f1_local0:registerEventHandler("remove_select_button", CoD.CACPrimaryWeapons.RemoveSelectButton)
	f1_local0:registerEventHandler("add_select_button", CoD.CACPrimaryWeapons.AddSelectButton)
	f1_local0:registerEventHandler("remove_prestige_unlock_button", CoD.CACPrimaryWeapons.RemovePrestigeUnlockButton)
	f1_local0:registerEventHandler("add_prestige_unlock_button", CoD.CACPrimaryWeapons.AddPrestigeUnlockButton)
	local f1_local1 = CoD.perController[f1_arg0].classNum
	local f1_local2 = CoD.perController[f1_arg0].weaponSlot
	local f1_local3 = Engine.GetCustomClass(f1_arg0, f1_local1)
	local f1_local4 = 0
	local f1_local5 = Engine.Localize("MPUI_" .. f1_local2 .. "_CAPS")
	if f1_local2 == "secondary" and CoD.CACUtility.IsBonusCardEquippedByName(f1_local3, "bonuscard_overkill") then
		f1_local5 = Engine.Localize("MPUI_SECOND_PRIMARY_WEAPON_CAPS")
	end
	f1_local0.header = LUI.UIText.new()
	f1_local0.header:setLeftRight(true, false, 0, 1)
	f1_local0.header:setTopBottom(true, false, f1_local4, f1_local4 + CoD.textSize.Big)
	f1_local0.header:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.header:setFont(CoD.fonts.Big)
	f1_local0.header:setText(f1_local5)
	f1_local0:addElement(f1_local0.header)
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
	local f1_local11 = CoD.CardCarouselList.new(nil, f1_arg0, CoD.CACPrimaryWeapons.ItemWidth, CoD.CACPrimaryWeapons.ItemHeight, CoD.CACPrimaryWeapons.HighlightedItemWidth, CoD.CACPrimaryWeapons.HighlightedItemHeight, {
		hintTextLeft = 0,
		hintTextWidth = 350,
		hintTextTop = -7
	})
	f1_local11:setLeftRight(true, true, 0, 0)
	f1_local11:setTopBottom(true, true, f1_local4, 0)
	f1_local0:addElement(f1_local11)
	f1_local11.titleListContainer.spacing = 0
	f1_local11.titleListContainer:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = -CoD.CoD9Button.Height,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local11.cardCarouselSize + 70,
		bottom = 0
	})
	f1_local11.titleListContainer:animateToState("default")
	CoD.CACPrimaryWeapons.AddCarousels(f1_local11, f1_arg0, f1_local3)
	f1_local0:dispatchEventToChildren({
		name = "update_class",
		controller = f1_arg0,
		classNum = f1_local1,
		class = f1_local3
	})
	f1_local4 = f1_local4 + f1_local11.cardCarouselSize - 41
	local f1_local12 = CoD.CACPrimaryWeapons.HighlightedItemWidth + 80
	local f1_local13 = CoD.Menu.Width / 2
	local f1_local14 = 100
	f1_local0.weaponAttributesList = CoD.WeaponAttributeList.new(f1_local13 - 60, {
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local12,
		right = f1_local12 + f1_local13,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local4,
		bottom = f1_local4 + f1_local14
	})
	f1_local0:addElement(f1_local0.weaponAttributesList)
	if CoD.ShouldShowWeaponLevel() then
		local f1_local15 = f1_local4 + f1_local14
		local f1_local16 = f1_local13 - 80
		f1_local0.weaponLevel = CoD.WeaponLevel.new({
			leftAnchor = true,
			rightAnchor = false,
			left = f1_local12,
			right = f1_local12 + f1_local16,
			topAnchor = true,
			bottomAnchor = false,
			top = f1_local15,
			bottom = f1_local15 + 50
		}, f1_local16)
		f1_local0:addElement(f1_local0.weaponLevel)
		f1_local0.weaponLevel:update(f1_arg0, f1_local3[f1_local2])
	end
	local f1_local15 = f1_local4 + 130
	local f1_local16 = LUI.UIImage.new()
	f1_local16:setLeftRight(true, false, 0, CoD.Menu.Width / 2 - 85)
	f1_local16:setTopBottom(true, false, f1_local15, f1_local15 + 1)
	f1_local16:setAlpha(0.05)
	f1_local0:addElement(f1_local16)
	if not Engine.AreAllItemsFree() then
		local f1_local17 = Engine.GetPlayerStats(f1_arg0)
		if f1_local17.PlayerStatsList.PLEVEL.StatValue:get() < tonumber(CoD.MAX_PRESTIGE) then
			local f1_local18 = CoD.CAC.CreateUnlockTokensFooter(f1_local0, f1_arg0)
			CoD.CAC.SetUnlockItemText(f1_local18, f1_arg0)
			f1_local0:addElement(f1_local18)
		end
	end
	f1_local11.cardCarousels[f1_local11.m_currentCardCarouselIndex].horizontalList:processEvent({
		name = "gain_focus",
		controller = f1_arg0
	})
	return f1_local0
end

CoD.CACPrimaryWeapons.RemoveSelectButton = function (f2_arg0, f2_arg1)
	if f2_arg0.selectButton then
		f2_arg0.selectButton:close()
		f2_arg0.selectButton = nil
	end
end

CoD.CACPrimaryWeapons.AddSelectButton = function (f3_arg0, f3_arg1)
	local f3_local0 = false
	local f3_local1 = false
	if f3_arg0.backButton then
		f3_local0 = true
		f3_arg0.backButton:close()
		f3_arg0.backButton = nil
	end
	if f3_arg0.prestigeUnlockButton then
		f3_local1 = true
		f3_arg0.prestigeUnlockButton:close()
		f3_arg0.prestigeUnlockButton = nil
	end
	if f3_arg0.selectButton then
		f3_arg0.selectButton:close()
		f3_arg0.selectButton = nil
	end
	f3_arg0:addSelectButton()
	if f3_local0 == true then
		f3_arg0:addBackButton()
	end
	if f3_local1 == true then
		f3_arg0:addPrestigeUnlockButton()
	end
end

CoD.CACPrimaryWeapons.RemovePrestigeUnlockButton = function (f4_arg0, f4_arg1)
	if f4_arg0.prestigeUnlockButton then
		f4_arg0.prestigeUnlockButton:close()
		f4_arg0.prestigeUnlockButton = nil
	end
end

CoD.CACPrimaryWeapons.AddPrestigeUnlockButton = function (f5_arg0, f5_arg1)
	if f5_arg0.prestigeUnlockButton == nil then
		f5_arg0:addPrestigeUnlockButton()
	end
end

CoD.CACPrimaryWeapons.CardGainFocus = function (f6_arg0, f6_arg1)
	f6_arg0.weaponAttributesList:updateWeaponAttributes(f6_arg1.card.weaponItemIndex, f6_arg1.contentIndex)
	local f6_local0 = nil
	if f6_arg1.card.isLocked then
		f6_arg0.weaponAttributesList:setAlpha(0)
		f6_local0 = CoD.GetUnlockStringForItemIndex(f6_arg1.controller, f6_arg1.card.weaponItemIndex)
		if f6_arg0.weaponLevel then
			f6_arg0.weaponLevel:beginAnimation("hide")
			f6_arg0.weaponLevel:setAlpha(0)
		end
		f6_arg0:processEvent({
			name = "remove_select_button"
		})
	else
		f6_arg0.weaponAttributesList:setAlpha(1)
		f6_local0 = Engine.Localize(UIExpression.GetItemDesc(f6_arg1.controller, f6_arg1.card.weaponItemIndex))
		if f6_arg0.weaponLevel then
			f6_arg0.weaponLevel:beginAnimation("show")
			f6_arg0.weaponLevel:setAlpha(1)
			f6_arg0.weaponLevel:update(f6_arg1.controller, f6_arg1.card.weaponItemIndex)
		end
		f6_arg0:processEvent({
			name = "add_select_button"
		})
	end
	f6_arg0:dispatchEventToChildren({
		name = "highlighted",
		controller = f6_arg1.controller,
		weaponItemIndex = f6_arg1.card.weaponItemIndex
	})
	f6_arg0.weaponItemIndexHighlighted = f6_arg1.card.weaponItemIndex
	f6_arg0.highlightedButton = f6_arg1.card
	f6_arg0:dispatchEventToChildren({
		name = "hint_text_fade_in",
		hintText = f6_local0
	})
end

CoD.CACPrimaryWeapons.CardLoseFocus = function (f7_arg0, f7_arg1)
	CoD.CAC.SetNewIcon(f7_arg1.card, false)
	Engine.SetItemAsOld(f7_arg1.controller, f7_arg1.card.weaponItemIndex)
	f7_arg0:dispatchEventToChildren({
		name = "hint_text_fade_out"
	})
end

CoD.CACPrimaryWeapons.AddCarousels = function (f8_arg0, f8_arg1, f8_arg2)
	local f8_local0 = CoD.perController[f8_arg1].weaponSlot
	local f8_local1 = f8_arg2[f8_local0]
	local f8_local2 = CoD.CACUtility.IsBonusCardEquippedByName(f8_arg2, "bonuscard_overkill")
	local f8_local3 = nil
	if f8_local2 then
		if f8_local0 == CoD.CACUtility.loadoutSlotNames.primaryWeapon then
			f8_local3 = f8_arg2[CoD.CACUtility.loadoutSlotNames.secondaryWeapon]
		elseif f8_local0 == CoD.CACUtility.loadoutSlotNames.secondaryWeapon then
			f8_local3 = f8_arg2[CoD.CACUtility.loadoutSlotNames.primaryWeapon]
		end
	end
	if f8_local0 == "primary" or f8_local2 then
		CoD.CACPrimaryWeapons.AddWeaponGroupCarousel(f8_arg0, f8_arg1, "weapon_smg", f8_local3, f8_local1, f8_local2)
		CoD.CACPrimaryWeapons.AddWeaponGroupCarousel(f8_arg0, f8_arg1, "weapon_assault", f8_local3, f8_local1, f8_local2)
		CoD.CACPrimaryWeapons.AddWeaponGroupCarousel(f8_arg0, f8_arg1, "weapon_cqb", f8_local3, f8_local1, f8_local2)
		CoD.CACPrimaryWeapons.AddWeaponGroupCarousel(f8_arg0, f8_arg1, "weapon_lmg", f8_local3, f8_local1, f8_local2)
		CoD.CACPrimaryWeapons.AddWeaponGroupCarousel(f8_arg0, f8_arg1, "weapon_sniper", f8_local3, f8_local1, f8_local2)
		if CoD.CACPrimaryWeapons.GroupCount(f8_arg1, "weapon_special", f8_local3, f8_local2) > 0 then
			CoD.CACPrimaryWeapons.AddWeaponGroupCarousel(f8_arg0, f8_arg1, "weapon_special", f8_local3, f8_local1, f8_local2)
		end
	else
		CoD.CACPrimaryWeapons.AddWeaponGroupCarousel(f8_arg0, f8_arg1, "weapon_pistol", f8_local3, f8_local1, f8_local2)
		CoD.CACPrimaryWeapons.AddWeaponGroupCarousel(f8_arg0, f8_arg1, "weapon_launcher", f8_local3, f8_local1, f8_local2)
		CoD.CACPrimaryWeapons.AddWeaponGroupCarousel(f8_arg0, f8_arg1, "weapon_special", f8_local3, f8_local1, f8_local2)
	end
	if f8_arg0.initialCarousel ~= nil and f8_arg0.initialCard ~= nil then
		f8_arg0:setInitialCarousel(f8_arg0.initialCarousel, f8_arg0.initialCard)
	end
end

CoD.CACPrimaryWeapons.Border_CardSmall = function (f9_arg0, f9_arg1)
	f9_arg0:animateToState("default")
end

CoD.CACPrimaryWeapons.Border_CardBig = function (f10_arg0, f10_arg1)
	f10_arg0:animateToState("big")
end

CoD.CACPrimaryWeapons.GroupCount = function (f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	local f11_local0 = 0
	local f11_local1 = CoD.GetUnlockablesByGroupName(f11_arg1)
	local f11_local2 = CoD.perController[f11_arg0].weaponSlot
	if f11_arg3 == true then
		f11_local2 = "primary"
	end
	for f11_local6, f11_local7 in ipairs(f11_local1) do
		if f11_local7 ~= f11_arg2 and Engine.GetLoadoutSlotForItem(f11_local7) == f11_local2 then
			f11_local0 = f11_local0 + 1
		end
	end
	return f11_local0
end

CoD.CACPrimaryWeapons.AddWeaponGroupCarousel = function (f12_arg0, f12_arg1, f12_arg2, f12_arg3, f12_arg4, f12_arg5)
	local f12_local0 = CoD.perController[f12_arg1].weaponSlot
	if f12_arg5 == true then
		f12_local0 = "primary"
	end
	local f12_local1 = f12_arg0:addCardCarousel(Engine.Localize("MPUI_" .. f12_arg2 .. "_CAPS"), nil, function (f18_arg0)
		return Engine.WeaponGroupHasNewItem(f12_arg1, f12_arg2, f12_local0)
	end)
	local f12_local2 = CoD.GetUnlockablesByGroupName(f12_arg2)
	local f12_local3 = RegisterMaterial("cac_restricted")
	local f12_local4 = RegisterMaterial("menu_mp_lobby_locked_big")
	local f12_local5 = RegisterMaterial("menu_mp_lobby_token_64")
	for f12_local13, f12_local14 in ipairs(f12_local2) do
		if f12_local14 ~= f12_arg3 and Engine.GetLoadoutSlotForItem(f12_local14) == f12_local0 then
			local f12_local9 = UIExpression.TableLookup(nil, "mp/statsTable.csv", 0, f12_local14, 15)
			local f12_local10 = true
			local f12_local11 = true
			if CoD.isMultiplayer and f12_local9 ~= nil and f12_local9 ~= 0 and f12_local9 ~= "" then
				f12_local10 = Engine.HasDLCContent(f12_local9)
				f12_local11 = false
			end
			if f12_local11 == true or true == Dvar.tu_allowDLCWeapons:get() and (f12_local10 == true or Engine.HasSeasonPass(f12_arg1)) then
				local f12_local12 = f12_local1:addNewCard()
				f12_local12.weaponItemIndex = f12_local14
				f12_local12.iconMaterial = RegisterMaterial(UIExpression.GetItemImage(nil, f12_local14) .. "_big")
				f12_local12.icon = LUI.UIImage.new({
					leftAnchor = true,
					rightAnchor = true,
					left = 10,
					right = -10,
					topAnchor = true,
					bottomAnchor = true,
					top = 20,
					bottom = -30,
					red = 1,
					green = 1,
					blue = 1,
					material = f12_local12.iconMaterial
				})
				f12_local12:addElement(f12_local12.icon)
				f12_local12.title = LUI.UIText.new({
					leftAnchor = true,
					rightAnchor = true,
					left = 5,
					right = 0,
					topAnchor = false,
					bottomAnchor = true,
					top = -CoD.textSize.Default,
					bottom = 0,
					font = CoD.fonts.Default,
					red = CoD.offWhite.r,
					green = CoD.offWhite.g,
					blue = CoD.offWhite.b,
					alignment = LUI.Alignment.Left
				})
				f12_local12.titleText = Engine.Localize(UIExpression.GetItemName(nil, f12_local14))
				f12_local12.title:setText(f12_local12.titleText)
				f12_local12.title:setAlignment(LUI.Alignment.Left)
				f12_local12.title:registerAnimationState("button_over", {
					red = CoD.BOIIOrange.r,
					green = CoD.BOIIOrange.g,
					blue = CoD.BOIIOrange.b
				})
				LUI.UIButton.SetupElement(f12_local12.title)
				f12_local12:addElement(f12_local12.title)
				if UIExpression.IsItemLocked(f12_arg1, f12_local14) == 1 then
					f12_local12.lockedIcon = CoD.CAC.SetLockIcon(f12_local12, 64, f12_local4)
					f12_local12.isLocked = true
					f12_local12.icon:setAlpha(0)
					f12_local12:setAlpha(0.5)
					f12_local12.title:registerAnimationState("button_over", {
						red = 1,
						green = 1,
						blue = 1
					})
				elseif UIExpression.IsItemPurchased(f12_arg1, f12_local14) == 0 then
					f12_local12.tokenIcon = CoD.CAC.SetTokenIcon(f12_local12, f12_local5)
					f12_local12.icon:setAlpha(0.25)
				elseif Engine.IsItemIndexRestricted(f12_local14) then
					f12_local12.restrictedIcon = CoD.CAC.SetLockIcon(f12_local12, 32, f12_local3)
				end
				if Engine.IsItemNew(f12_arg1, f12_local14) then
					CoD.CAC.SetNewIcon(f12_local12, true)
				end
				if f12_local12.border then
					f12_local12.border:close()
				end
				if f12_local12.highlightedborder then
					f12_local12.highlightedborder:close()
				end
				CoD.ContentGridButton.SetupButtonImages(f12_local12, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
				f12_local12:setActionEventName("weapon_chosen")
				if f12_local14 == f12_arg4 then
					f12_arg0.initialCarousel = #f12_arg0.cardCarousels
					f12_arg0.initialCard = f12_local1:getNumCards()
				end
			end
		end
	end
	f12_local6 = f12_arg0.cardCarouselSize + 40
	f12_local1.title:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f12_local6,
		bottom = f12_local6 + CoD.CardCarousel.TitleSize,
		font = CoD.fonts.Big
	})
	f12_local1.title:animateToState("default")
end

CoD.CACPrimaryWeapons.PrestigeUnlock = function (f13_arg0, f13_arg1)
	if CoD.ConfirmPrestigeUnlock.OpenIfNecessary(f13_arg0, f13_arg1.controller, f13_arg0.weaponItemIndexHighlighted, f13_arg0.highlightedButton) ~= nil then
		CoD.perController[f13_arg1.controller].prestigeUnlockEquipEvent = {
			name = "weapon_chosen",
			controller = f13_arg1.controller,
			button = f13_arg0.highlightedButton
		}
		return 
	else

	end
end

CoD.CACPrimaryWeapons.WeaponPrestige = function (f14_arg0, f14_arg1)
	CoD.ConfirmWeaponPrestige.OpenIfNecessary(f14_arg0, f14_arg1.controller, f14_arg0.weaponItemIndexHighlighted)
end

CoD.CACPrimaryWeapons.WeaponChosen = function (f15_arg0, f15_arg1)
	CoD.CAC.SetNewIcon(f15_arg1.button, false)
	local f15_local0 = Engine.GetCustomClass(f15_arg1.controller, CoD.perController[f15_arg1.controller].classNum)
	local f15_local1 = f15_arg1.button.weaponItemIndex
	CoD.perController[f15_arg1.controller].chosenItem = f15_local1
	local f15_local2 = false
	if f15_local0.allocationSpent < Engine.GetMaxAllocation(f15_arg1.controller) or f15_local0[CoD.perController[f15_arg1.controller].weaponSlot] then
		f15_local2 = true
	end
	if CoD.ConfirmPurchase.OpenIfNecessary(f15_arg0, f15_arg1.controller, f15_local1, f15_arg1.button) ~= nil then
		CoD.perController[f15_arg1.controller].purchaseEquipEvent = {
			name = "weapon_chosen",
			controller = f15_arg1.controller,
			button = f15_arg1.button
		}
		return 
	elseif f15_arg1.button.isLocked == true then
		Engine.PlaySound(CoD.CACUtility.denySFX)
	elseif UIExpression.IsItemPurchased(f15_arg1.controller, f15_local1) == 0 then
		Engine.PlaySound(CoD.CACUtility.denySFX)
	elseif f15_local2 then
		f15_arg0:processEvent({
			name = "equip",
			controller = f15_arg1.controller
		})
	else
		f15_arg0:openPopup("CACRemoveItem", f15_arg1.controller)
	end
end

CoD.CACPrimaryWeapons.Purchased = function (f16_arg0, f16_arg1)
	if f16_arg1.button.tokenIcon ~= nil then
		f16_arg1.button.tokenIcon:close()
		f16_arg1.button.tokenIcon = nil
	elseif f16_arg1.button.lockedIcon ~= nil then
		f16_arg1.button.lockedIcon:close()
		f16_arg1.button.lockedIcon = nil
		f16_arg1.button.isLocked = nil
	end
	f16_arg1.button:setAlpha(1)
	if f16_arg1.button.icon then
		f16_arg1.button.icon:setAlpha(1)
	end
	if f16_arg1.button.title then
		f16_arg1.button.title:registerAnimationState("button_over", {
			red = CoD.BOIIOrange.r,
			green = CoD.BOIIOrange.g,
			blue = CoD.BOIIOrange.b
		})
		f16_arg1.button.title:animateToState("button_over")
	end
	if f16_arg1.button.highlight then
		f16_arg1.button.highlight:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	end
	if f16_arg0.weaponAttributesList then
		f16_arg0.weaponAttributesList:setAlpha(1)
	end
	if f16_arg0.weaponLevel then
		f16_arg0.weaponLevel:setAlpha(1)
		f16_arg0.weaponLevel:update(f16_arg1.controller, f16_arg1.button.weaponItemIndex)
	end
	CoD.CACPrimaryWeapons.AddSelectButton(f16_arg0)
	f16_arg0:processEvent({
		name = "remove_prestige_unlock_button"
	})
	f16_arg0:dispatchEventToChildren(f16_arg1)
end

CoD.CACPrimaryWeapons.Equip = function (f17_arg0, f17_arg1)
	local f17_local0 = f17_arg1.controller
	local f17_local1 = CoD.perController[f17_local0].classNum
	local f17_local2 = CoD.perController[f17_local0].weaponSlot
	local f17_local3 = CoD.perController[f17_local0].chosenItem
	CoD.perController[f17_local0].chosenItem = nil
	for f17_local4 = 0, 2, 1 do
		Engine.SetClassItem(f17_local0, f17_local1, f17_local2 .. "attachment" .. f17_local4 + 1, 0)
	end
	for f17_local4 = 1, CoD.CACUtility.maxBonusCards, 1 do
		if UIExpression.GetItemRef(nil, CoD.GetClassItem(f17_local0, f17_local1, "bonuscard" .. f17_local4)) == "bonuscard_" .. f17_local2 .. "_gunfighter" then
			Engine.SetClassItem(f17_local0, f17_local1, "bonuscard" .. f17_local4, 0)
		end
	end
	Engine.SetClassItem(f17_local0, f17_local1, f17_local2, f17_local3)
	CoD.EquipNotification.AddToNotificationQueue("item", "equipped", UIExpression.GetItemName(nil, f17_local3))
	f17_arg0:processEvent({
		name = "button_prompt_back",
		controller = f17_arg1.controller
	})
end

