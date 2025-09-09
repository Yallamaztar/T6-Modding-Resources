require("T6.AllocationBar")
require("T6.BonusCardGridButton")
CoD.CACBonusCards = {}
CoD.CACBonusCards.GridColumns = 3
CoD.CACBonusCards.GridItemSpacing = 8
CoD.CACBonusCards.GridItemWidth = (CoD.Menu.Width - CoD.CACBonusCards.GridItemSpacing * (CoD.CACBonusCards.GridColumns - 1)) / CoD.CACBonusCards.GridColumns
CoD.CACBonusCards.GridItemHeight = 96 + CoD.ContentGridButton.TitleHeight + 10
LUI.createMenu.CACBonusCards = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CACBonusCards")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("content_button_highlighted", CoD.CACBonusCards.ContentButtonHighlighted)
	f1_local0:registerEventHandler("content_button_selected", CoD.CACBonusCards.ContentButtonSelected)
	f1_local0:registerEventHandler("equip", CoD.CACBonusCards.Equip)
	f1_local0:registerEventHandler("purchased", CoD.CACBonusCards.Purchased)
	f1_local0:registerEventHandler("prestige_unlock", CoD.CACBonusCards.PrestigeUnlock)
	f1_local0:registerEventHandler("remove_prestige_unlock_button", CoD.CACBonusCards.RemovePrestigeUnlockButton)
	f1_local0:registerEventHandler("add_prestige_unlock_button", CoD.CACBonusCards.AddPrestigeUnlockButton)
	local f1_local1 = 0
	f1_local0.header = LUI.UIText.new()
	f1_local0.header:setLeftRight(true, false, 0, 1)
	f1_local0.header:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize.Big)
	f1_local0.header:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.header:setFont(CoD.fonts.Big)
	f1_local0.header:setText(Engine.Localize("MENU_WILDCARDS_CAPS"))
	f1_local0:addElement(f1_local0.header)
	f1_local1 = f1_local1 + CoD.textSize.Big
	local f1_local2 = CoD.Menu.Width
	local f1_local3 = f1_local2 - CoD.AllocationStatus.Width
	local f1_local4 = f1_local1 + 15
	f1_local0:addElement(CoD.AllocationStatus.new(f1_arg0, {
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local3,
		right = f1_local2,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local4 - CoD.AllocationStatus.Height,
		bottom = f1_local4
	}))
	local f1_local5 = 10
	local f1_local6 = f1_local4
	f1_local0.allocationBar = CoD.AllocationBar.New(f1_arg0, CoD.Menu.Width)
	f1_local0.allocationBar:setLeftRight(true, false, 0, CoD.Menu.Width)
	f1_local0.allocationBar:setTopBottom(true, false, f1_local6, f1_local6 + f1_local5)
	f1_local0:addElement(f1_local0.allocationBar)
	f1_local1 = f1_local1 + f1_local5 + 25
	f1_local0.contentGrid = CoD.ContentGrid.new(CoD.CACBonusCards.GridColumns, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local1,
		bottom = 0
	}, CoD.CACBonusCards.GridItemWidth, CoD.CACBonusCards.GridItemHeight, CoD.CACBonusCards.GridItemSpacing)
	f1_local0:addElement(f1_local0.contentGrid)
	local f1_local7 = math.ceil(#CoD.GetUnlockablesByGroupName("bonuscard") / CoD.CACBonusCards.GridColumns)
	local f1_local8 = f1_local1 + CoD.CACBonusCards.GridItemHeight * f1_local7 + CoD.CACBonusCards.GridItemSpacing * (f1_local7 - 1) + 3
	f1_local0.hintTextElement = CoD.HintText.new()
	f1_local0.hintTextElement:setLeftRight(true, true, 0, 0)
	f1_local0.hintTextElement:setTopBottom(true, false, f1_local8, f1_local8 + CoD.HintText.Height)
	f1_local0.hintTextElement:setColor(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b, 0.4)
	f1_local0:addElement(f1_local0.hintTextElement)
	f1_local1 = f1_local1 + CoD.CACBonusCards.GridItemHeight * 3 + CoD.CACBonusCards.GridItemSpacing * 2 + 3 + CoD.HintText.Height + 5
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f1_local1, 0)
	f1_local0:addElement(Widget)
	local f1_local10 = 0
	f1_local0.bonusCardName = LUI.UIText.new()
	f1_local0.bonusCardName:setLeftRight(true, false, 0, 1)
	f1_local0.bonusCardName:setTopBottom(true, false, f1_local10, f1_local10 + CoD.textSize.Big)
	f1_local0.bonusCardName:setFont(CoD.fonts.Big)
	f1_local0.bonusCardName:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(f1_local0.bonusCardName)
	f1_local10 = f1_local10 + CoD.textSize.Big
	f1_local0.bonusCardDescription = LUI.UIText.new()
	f1_local0.bonusCardDescription:setLeftRight(true, false, 0, CoD.CACBonusCards.GridItemWidth * 2 + CoD.CACBonusCards.GridItemSpacing * 2)
	f1_local0.bonusCardDescription:setTopBottom(true, false, f1_local10, f1_local10 + CoD.textSize.Default)
	f1_local0.bonusCardDescription:setAlignment(LUI.Alignment.Left)
	f1_local0.bonusCardDescription:setFont(CoD.fonts.Default)
	f1_local0.bonusCardDescription:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.bonusCardDescription:setAlpha(0.4)
	Widget:addElement(f1_local0.bonusCardDescription)
	local f1_local11 = CoD.perController[f1_arg0].classNum
	local f1_local12 = Engine.GetCustomClass(f1_arg0, f1_local11)
	local f1_local13 = f1_local12["bonuscard" .. CoD.perController[f1_arg0].bonusCardSlot]
	if not Engine.AreAllItemsFree() then
		local f1_local14 = Engine.GetPlayerStats(f1_arg0)
		if f1_local14.PlayerStatsList.PLEVEL.StatValue:get() < tonumber(CoD.MAX_PRESTIGE) then
			local f1_local15 = CoD.CAC.CreateUnlockTokensFooter(f1_local0, f1_arg0)
			CoD.CAC.SetUnlockItemText(f1_local15, f1_arg0)
			f1_local0:addElement(f1_local15)
		end
	end
	CoD.CACBonusCards.AddBonusCards(f1_local0, "bonuscard", f1_local13, f1_arg0, f1_local11, f1_local12)
	return f1_local0
end

CoD.CACBonusCards.RemovePrestigeUnlockButton = function (f2_arg0, f2_arg1)
	if f2_arg0.prestigeUnlockButton then
		f2_arg0.prestigeUnlockButton:close()
		f2_arg0.prestigeUnlockButton = nil
	end
end

CoD.CACBonusCards.AddPrestigeUnlockButton = function (f3_arg0, f3_arg1)
	if f3_arg0.prestigeUnlockButton == nil then
		f3_arg0:addPrestigeUnlockButton()
	end
end

CoD.CACBonusCards.AddBonusCards = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5)
	local f4_local0 = CoD.GetUnlockablesByGroupName(f4_arg1)
	local f4_local1 = nil
	for f4_local5, f4_local6 in ipairs(f4_local0) do
		local f4_local7 = CoD.BonusCardGridButton.new(f4_local6)
		f4_arg0.contentGrid:addButton(f4_local7)
		if f4_arg2 == f4_local6 or not f4_local1 then
			f4_local1 = f4_local7
		end
	end
	f4_arg0:dispatchEventToChildren({
		name = "highlighted",
		controller = f4_arg3,
		weaponItemIndex = f4_arg2
	})
	f4_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f4_arg3,
		classNum = f4_arg4,
		class = f4_arg5
	})
	f4_local1:processEvent({
		name = "gain_focus",
		controller = f4_arg3
	})
end

CoD.CACBonusCards.ContentButtonHighlighted = function (f5_arg0, f5_arg1)
	if f5_arg1.contentIndex then
		f5_arg0.bonusCardName:setText(Engine.Localize(UIExpression.GetItemName(nil, f5_arg1.contentIndex)))
		if UIExpression.IsItemLocked(f5_arg1.controller, f5_arg1.contentIndex) == 1 then
			f5_arg0.bonusCardDescription:setText(CoD.GetUnlockStringForItemIndex(f5_arg1.controller, f5_arg1.contentIndex))
			f5_arg0:removeSelectButton()
		else
			f5_arg0.bonusCardDescription:setText(Engine.Localize(UIExpression.GetItemDesc(nil, f5_arg1.contentIndex)))
			f5_arg0:addSelectButtonWithPrestigeUnlock()
		end
	else
		f5_arg0.bonusCardName:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f5_arg0.bonusCardDescription:setText("")
	end
	f5_arg0:dispatchEventToChildren({
		name = "highlighted",
		controller = f5_arg1.controller,
		weaponItemIndex = f5_arg1.contentIndex
	})
	f5_arg0.weaponItemIndexHighlighted = f5_arg1.contentIndex
	f5_arg0.highlightedButton = f5_arg1.button
	f5_arg0.hintTextElement:updateText(f5_arg1.hintText)
end

CoD.CACBonusCards.PrestigeUnlock = function (f6_arg0, f6_arg1)
	CoD.ConfirmPrestigeUnlock.OpenIfNecessary(f6_arg0, f6_arg1.controller, f6_arg0.weaponItemIndexHighlighted, f6_arg0.highlightedButton)
end

CoD.CACBonusCards.ContentButtonSelected = function (f7_arg0, f7_arg1)
	CoD.perController[f7_arg1.controller].chosenItem = f7_arg1.contentIndex
	local f7_local0 = Engine.GetCustomClass(f7_arg1.controller, CoD.perController[f7_arg1.controller].classNum)
	local f7_local1 = CoD.perController[f7_arg1.controller].chosenItem
	local f7_local2 = CoD.perController[f7_arg1.controller].bonusCardSlot
	local f7_local3 = false
	if CoD.ConfirmPurchase.OpenIfNecessary(f7_arg0, f7_arg1.controller, f7_arg1.contentIndex, f7_arg1.button) ~= nil then
		return 
	elseif f7_arg1.mutuallyExclusiveIndices then
		f7_local3 = true
		for f7_local7, f7_local8 in ipairs(f7_arg1.mutuallyExclusiveIndices) do
			local f7_local9 = CoD.CACUtility.GetBonusCardLoadoutSlot(f7_local0, f7_local8)
			if f7_local9 then
				CoD.CACBonusCards.Unequip(f7_arg0, f7_arg1.controller, f7_local9)
			end
		end
	elseif f7_local0.allocationSpent < Engine.GetMaxAllocation(f7_arg1.controller) then
		f7_local3 = true
	end
	if UIExpression.IsItemPurchased(f7_arg1.controller, f7_local1) == 0 or f7_arg1.button.inactive == true then
		Engine.PlaySound(CoD.CACUtility.denySFX)
	elseif f7_local3 then
		if f7_arg1.actionSFX ~= nil then
			Engine.PlaySound(f7_arg1.actionSFX)
		end
		f7_arg0:processEvent({
			name = "equip",
			controller = f7_arg1.controller
		})
	else
		f7_arg0:openPopup("CACRemoveItem", f7_arg1.controller)
	end
end

CoD.CACBonusCards.Purchased = function (f8_arg0, f8_arg1)
	local f8_local0 = CoD.perController[f8_arg1.controller].classNum
	f8_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f8_arg1.controller,
		classNum = f8_local0,
		class = Engine.GetCustomClass(f8_arg1.controller, f8_local0)
	})
	f8_arg0.hintTextElement:updateText(nil)
	f8_arg0:dispatchEventToChildren(f8_arg1)
end

CoD.CACBonusCards.Unequip = function (f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = CoD.perController[f9_arg1].classNum
	local f9_local1 = Engine.GetClassItem(f9_arg1, f9_local0, f9_arg2)
	if f9_local1 and f9_local1 ~= 0 then
		local f9_local2 = CoD.BonusCardButton.BonusCardUnequipped[UIExpression.GetItemRef(nil, f9_local1)]
		if f9_local2 then
			f9_local2(f9_arg1)
		end
	end
	Engine.SetClassItem(f9_arg1, f9_local0, f9_arg2, 0)
end

CoD.CACBonusCards.Equip = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg1.controller
	local f10_local1 = CoD.perController[f10_local0].classNum
	local f10_local2 = Engine.GetCustomClass(f10_local0, f10_local1)
	local f10_local3 = CoD.perController[f10_local0].bonusCardSlot
	local f10_local4 = "bonuscard" .. f10_local3
	local f10_local5 = CoD.perController[f10_local0].chosenItem
	CoD.perController[f10_local0].chosenItem = nil
	CoD.CACBonusCards.Unequip(f10_arg0, f10_local0, f10_local4)
	for f10_local6 = 1, CoD.CACUtility.maxBonusCards, 1 do
		local f10_local9 = "bonuscard" .. f10_local6
		if f10_local2[f10_local9] == f10_local5 and f10_local6 ~= f10_local3 then
			CoD.SetClassItem(f10_local0, f10_local1, f10_local9, 0)
		end
	end
	Engine.SetClassItem(f10_local0, f10_local1, f10_local4, f10_local5)
	local f10_local6 = UIExpression.GetItemRef(nil, f10_local5)
	local f10_local7 = CoD.BonusCardButton.BonusCardEquipped[f10_local6]
	if f10_local7 then
		f10_local7(f10_local0)
	end
	CoD.EquipNotification.AddToNotificationQueue("bonusCard", "equipped", f10_local6)
	f10_arg0:processEvent({
		name = "button_prompt_back",
		controller = f10_arg1.controller
	})
end

