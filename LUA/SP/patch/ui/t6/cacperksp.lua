require("T6.AllocationBar")
require("T6.PerkGridButton")
CoD.CACPerksP = {}
CoD.CACPerksP.GridColumns = 3
CoD.CACPerksP.GridItemSpacing = 8
CoD.CACPerksP.GridItemWidth = (CoD.Menu.Width - CoD.CACPerksP.GridItemSpacing * (CoD.CACPerksP.GridColumns - 1)) / CoD.CACPerksP.GridColumns
CoD.CACPerksP.GridItemHeight = 96 + CoD.ContentGridButton.TitleHeight + 10
LUI.createMenu.CACPerksP = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CACPerksP")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("content_button_highlighted", CoD.CACPerksP.ContentButtonHighlighted)
	f1_local0:registerEventHandler("content_button_selected", CoD.CACPerksP.ContentButtonSelected)
	f1_local0:registerEventHandler("equip", CoD.CACPerksP.Equip)
	f1_local0:registerEventHandler("purchased", CoD.CACPerksP.Purchased)
	f1_local0:registerEventHandler("prestige_unlock", CoD.CACPerksP.PrestigeUnlock)
	f1_local0:registerEventHandler("remove_prestige_unlock_button", CoD.CACPerksP.RemovePrestigeUnlockButton)
	f1_local0:registerEventHandler("add_prestige_unlock_button", CoD.CACPerksP.AddPrestigeUnlockButton)
	local f1_local1 = CoD.perController[f1_arg0].classNum
	local f1_local2 = CoD.perController[f1_arg0].perkCategory
	local f1_local3 = CoD.perController[f1_arg0].slotIndex
	local f1_local4 = Engine.GetCustomClass(f1_arg0, f1_local1)
	local f1_local5 = f1_local4[CoD.CACPerksP.GetLoadoutSlot(f1_local2, f1_local3)]
	local f1_local6 = 0
	local f1_local7 = LUI.UIText.new()
	f1_local7:setLeftRight(true, false, 0, 1)
	f1_local7:setTopBottom(true, false, f1_local6, f1_local6 + CoD.textSize.Big)
	f1_local7:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local7:setFont(CoD.fonts.Big)
	f1_local7:setText(Engine.Localize("MPUI_PERK" .. f1_local2 .. "_CAPS"))
	f1_local0:addElement(f1_local7)
	f1_local6 = f1_local6 + CoD.textSize.Big
	local f1_local8 = CoD.Menu.Width
	local f1_local9 = f1_local8 - CoD.AllocationStatus.Width
	local f1_local10 = f1_local6 + 15
	f1_local0:addElement(CoD.AllocationStatus.new(f1_arg0, {
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local9,
		right = f1_local8,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local10 - CoD.AllocationStatus.Height,
		bottom = f1_local10
	}))
	local f1_local11 = 10
	local f1_local12 = f1_local10
	f1_local0.allocationBar = CoD.AllocationBar.New(f1_arg0, CoD.Menu.Width)
	f1_local0.allocationBar:setLeftRight(true, false, 0, CoD.Menu.Width)
	f1_local0.allocationBar:setTopBottom(true, false, f1_local12, f1_local12 + f1_local11)
	f1_local0:addElement(f1_local0.allocationBar)
	f1_local6 = f1_local6 + f1_local11 + 25
	f1_local0.contentGrid = CoD.ContentGrid.new(CoD.CACPerksP.GridColumns, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local6,
		bottom = 0
	}, CoD.CACPerksP.GridItemWidth, CoD.CACPerksP.GridItemHeight, CoD.CACPerksP.GridItemSpacing)
	f1_local0:addElement(f1_local0.contentGrid)
	local f1_local13 = math.ceil(#CoD.GetUnlockablesBySlotName("specialty" .. f1_local2) / CoD.CACPerksP.GridColumns)
	f1_local6 = f1_local6 + CoD.CACPerksP.GridItemHeight * f1_local13 + CoD.CACPerksP.GridItemSpacing * (f1_local13 - 1) + 3
	f1_local0.hintTextElement = CoD.HintText.new()
	f1_local0.hintTextElement:setLeftRight(true, true, 0, 0)
	f1_local0.hintTextElement:setTopBottom(true, false, f1_local6, f1_local6 + CoD.HintText.Height)
	f1_local0.hintTextElement:setColor(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b, 0.4)
	f1_local0:addElement(f1_local0.hintTextElement)
	f1_local6 = f1_local6 + CoD.HintText.Height + 1
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f1_local6, 0)
	f1_local0:addElement(Widget)
	local f1_local15 = 0
	f1_local0.perkTitle = LUI.UIText.new()
	f1_local0.perkTitle:setLeftRight(true, false, 0, 1)
	f1_local0.perkTitle:setTopBottom(true, false, f1_local15, f1_local15 + CoD.textSize.Big)
	f1_local0.perkTitle:setFont(CoD.fonts.Big)
	f1_local0.perkTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(f1_local0.perkTitle)
	f1_local15 = f1_local15 + CoD.textSize.Big
	f1_local0.perkDescription = LUI.UIText.new()
	f1_local0.perkDescription:setLeftRight(true, false, 0, CoD.CACPerksP.GridItemWidth * 2 + CoD.CACPerksP.GridItemSpacing * 2)
	f1_local0.perkDescription:setTopBottom(true, false, f1_local15, f1_local15 + CoD.textSize.Default)
	f1_local0.perkDescription:setAlignment(LUI.Alignment.Left)
	f1_local0.perkDescription:setFont(CoD.fonts.Default)
	f1_local0.perkDescription:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.perkDescription:setAlpha(0.4)
	Widget:addElement(f1_local0.perkDescription)
	if not Engine.AreAllItemsFree() then
		local f1_local16 = Engine.GetPlayerStats(f1_arg0)
		if f1_local16.PlayerStatsList.PLEVEL.StatValue:get() < tonumber(CoD.MAX_PRESTIGE) then
			local f1_local17 = CoD.CAC.CreateUnlockTokensFooter(f1_local0, f1_arg0)
			CoD.CAC.SetUnlockItemText(f1_local17, f1_arg0)
			f1_local0:addElement(f1_local17)
		end
	end
	CoD.CACPerksP.AddPerks(f1_local0, f1_local2, f1_local5, f1_arg0, f1_local1, f1_local4)
	return f1_local0
end

CoD.CACPerksP.RemovePrestigeUnlockButton = function (f2_arg0, f2_arg1)
	if f2_arg0.prestigeUnlockButton then
		f2_arg0.prestigeUnlockButton:close()
		f2_arg0.prestigeUnlockButton = nil
	end
end

CoD.CACPerksP.AddPrestigeUnlockButton = function (f3_arg0, f3_arg1)
	if f3_arg0.prestigeUnlockButton == nil then
		f3_arg0:addPrestigeUnlockButton()
	end
end

CoD.CACPerksP.AddPerks = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5)
	local f4_local0 = CoD.GetUnlockablesBySlotName("specialty" .. f4_arg1)
	local f4_local1 = nil
	for f4_local5, f4_local6 in ipairs(f4_local0) do
		local f4_local7 = CoD.PerkGridButton.new(f4_local6, f4_arg1)
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

CoD.CACPerksP.GetLoadoutSlot = function (f5_arg0, f5_arg1)
	return "specialty" .. f5_arg0 + f5_arg1 - 1 * CoD.CACUtility.maxPerkCategories
end

CoD.CACPerksP.ContentButtonHighlighted = function (f6_arg0, f6_arg1)
	if f6_arg1.contentIndex then
		f6_arg0.perkTitle:setText(Engine.Localize(UIExpression.GetItemName(nil, f6_arg1.contentIndex)))
		if UIExpression.IsItemLocked(f6_arg1.controller, f6_arg1.contentIndex) == 1 then
			f6_arg0.perkDescription:setText(CoD.GetUnlockStringForItemIndex(f6_arg1.controller, f6_arg1.contentIndex))
		else
			f6_arg0.perkDescription:setText(Engine.Localize(UIExpression.GetItemDesc(nil, f6_arg1.contentIndex)))
		end
	else
		f6_arg0.perkTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f6_arg0.perkDescription:setText("")
	end
	f6_arg0:dispatchEventToChildren({
		name = "highlighted",
		controller = f6_arg1.controller,
		weaponItemIndex = f6_arg1.contentIndex
	})
	f6_arg0.weaponItemIndexHighlighted = f6_arg1.contentIndex
	f6_arg0.highlightedButton = f6_arg1.button
	f6_arg0.hintTextElement:updateText(f6_arg1.hintText)
end

CoD.CACPerksP.PrestigeUnlock = function (f7_arg0, f7_arg1)
	CoD.ConfirmPrestigeUnlock.OpenIfNecessary(f7_arg0, f7_arg1.controller, f7_arg0.weaponItemIndexHighlighted, f7_arg0.highlightedButton)
end

CoD.CACPerksP.ContentButtonSelected = function (f8_arg0, f8_arg1)
	CoD.perController[f8_arg1.controller].chosenItem = f8_arg1.contentIndex
	local f8_local0 = Engine.GetCustomClass(f8_arg1.controller, CoD.perController[f8_arg1.controller].classNum)
	local f8_local1 = CoD.perController[f8_arg1.controller].perkCategory
	local f8_local2 = CoD.perController[f8_arg1.controller].chosenItem
	local f8_local3 = CoD.CACPerksP.GetLoadoutSlot(f8_local1, CoD.perController[f8_arg1.controller].slotIndex)
	local f8_local4 = false
	if CoD.ConfirmPurchase.OpenIfNecessary(f8_arg0, f8_arg1.controller, f8_arg1.contentIndex, f8_arg1.button) ~= nil then
		return 
	elseif f8_local0.allocationSpent < Engine.GetMaxAllocation(f8_arg1.controller) then
		f8_local4 = true
	elseif f8_local0[f8_local3] then
		f8_local4 = true
	else
		for f8_local5 = 1, CoD.CACUtility.maxPerksInEachCategory, 1 do
			if f8_local0[CoD.CACPerksP.GetLoadoutSlot(f8_local1, f8_local5)] == f8_local2 then
				f8_local4 = true
			end
		end
	end
	if UIExpression.IsItemPurchased(f8_arg1.controller, f8_local2) == 0 then
		Engine.PlaySound(CoD.CACUtility.denySFX)
	elseif f8_local4 then
		local f8_local5 = f8_arg1.button.actionSFX
		if f8_local5 ~= nil then
			Engine.PlaySound(f8_local5)
		end
		f8_arg0:processEvent({
			name = "equip",
			controller = f8_arg1.controller
		})
	else
		f8_arg0:openPopup("CACRemoveItem", f8_arg1.controller)
	end
end

CoD.CACPerksP.Purchased = function (f9_arg0, f9_arg1)
	local f9_local0 = CoD.perController[f9_arg1.controller].classNum
	f9_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f9_arg1.controller,
		classNum = f9_local0,
		class = Engine.GetCustomClass(f9_arg1.controller, f9_local0)
	})
	f9_arg0.hintTextElement:updateText(nil)
	f9_arg0:dispatchEventToChildren(f9_arg1)
end

CoD.CACPerksP.Equip = function (f10_arg0, f10_arg1)
	local f10_local0 = CoD.perController[f10_arg1.controller].slotIndex
	local f10_local1 = CoD.perController[f10_arg1.controller].perkCategory
	local f10_local2 = CoD.perController[f10_arg1.controller].classNum
	local f10_local3 = Engine.GetCustomClass(f10_arg1.controller, f10_local2)
	local f10_local4 = CoD.perController[f10_arg1.controller].chosenItem
	CoD.perController[f10_arg1.controller].chosenItem = nil
	for f10_local5 = 1, CoD.CACUtility.maxPerksInEachCategory, 1 do
		local f10_local8 = CoD.CACPerksP.GetLoadoutSlot(f10_local1, f10_local5)
		if f10_local3[f10_local8] == f10_local4 and f10_local5 ~= f10_local0 then
			CoD.SetClassItem(f10_arg1.controller, f10_local2, f10_local8, 0)
		end
	end
	CoD.SetClassItem(f10_arg1.controller, f10_local2, CoD.CACPerksP.GetLoadoutSlot(f10_local1, f10_local0), f10_local4)
	CoD.EquipNotification.AddToNotificationQueue("item", "equipped", UIExpression.GetItemName(nil, f10_local4))
	f10_arg0:processEvent({
		name = "button_prompt_back",
		controller = f10_arg1.controller
	})
end

