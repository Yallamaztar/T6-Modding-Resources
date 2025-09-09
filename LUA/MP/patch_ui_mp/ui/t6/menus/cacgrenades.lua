require("T6.AllocationBar")
require("T6.GrenadeGridButton")
CoD.CACGrenades = {}
CoD.CACGrenades.GridColumns = 3
CoD.CACGrenades.GridItemSpacing = 8
CoD.CACGrenades.GridItemWidth = (CoD.Menu.Width - CoD.CACGrenades.GridItemSpacing * (CoD.CACGrenades.GridColumns - 1)) / CoD.CACGrenades.GridColumns
CoD.CACGrenades.GridItemHeight = 96 + CoD.ContentGridButton.TitleHeight + 10
LUI.createMenu.CACGrenades = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CACGrenades")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("content_button_highlighted", CoD.CACGrenades.ContentButtonHighlighted)
	f1_local0:registerEventHandler("content_button_selected", CoD.CACGrenades.ContentButtonSelected)
	f1_local0:registerEventHandler("equip", CoD.CACGrenades.Equip)
	f1_local0:registerEventHandler("purchased", CoD.CACGrenades.Purchased)
	f1_local0:registerEventHandler("prestige_unlock", CoD.CACGrenades.PrestigeUnlock)
	f1_local0:registerEventHandler("remove_prestige_unlock_button", CoD.CACGrenades.RemovePrestigeUnlockButton)
	f1_local0:registerEventHandler("add_prestige_unlock_button", CoD.CACGrenades.AddPrestigeUnlockButton)
	local f1_local1 = CoD.perController[f1_arg0].classNum
	local f1_local2 = CoD.perController[f1_arg0].grenadeSlot
	local f1_local3 = Engine.GetCustomClass(f1_arg0, f1_local1)
	local f1_local4 = f1_local3[f1_local2]
	local f1_local5 = Engine.Localize("MPUI_" .. f1_local2 .. "_CAPS")
	if f1_local2 == CoD.CACUtility.loadoutSlotNames.primaryGrenade and CoD.CACUtility.IsBonusCardEquippedByName(f1_local3, "bonuscard_two_tacticals") then
		f1_local5 = Engine.Localize("MPUI_SECOND_SPECIAL_GRENADE_CAPS")
	end
	f1_local0:addTitle(f1_local5)
	local f1_local6 = CoD.textSize.Big
	local f1_local7 = CoD.Menu.Width
	local f1_local8 = f1_local7 - CoD.AllocationStatus.Width
	local f1_local9 = f1_local6 + 15
	f1_local0:addElement(CoD.AllocationStatus.new(f1_arg0, {
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local8,
		right = f1_local7,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local9 - CoD.AllocationStatus.Height,
		bottom = f1_local9
	}))
	local f1_local10 = 10
	local f1_local11 = f1_local9
	f1_local0.allocationBar = CoD.AllocationBar.New(f1_arg0, CoD.Menu.Width)
	f1_local0.allocationBar:setLeftRight(true, false, 0, CoD.Menu.Width)
	f1_local0.allocationBar:setTopBottom(true, false, f1_local11, f1_local11 + f1_local10)
	f1_local0:addElement(f1_local0.allocationBar)
	f1_local6 = f1_local6 + f1_local10 + 25
	f1_local0.contentGrid = CoD.ContentGrid.new(CoD.CACGrenades.GridColumns, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local6,
		bottom = 0
	}, CoD.CACGrenades.GridItemWidth, CoD.CACGrenades.GridItemHeight, CoD.CACGrenades.GridItemSpacing)
	f1_local0:addElement(f1_local0.contentGrid)
	local f1_local12, f1_local13 = nil
	if f1_local2 == CoD.CACUtility.loadoutSlotNames.primaryGrenade and CoD.CACUtility.IsBonusCardEquippedByName(f1_local3, "bonuscard_two_tacticals") then
		f1_local13 = CoD.CACUtility.loadoutSlotNames.specialGrenade
	else
		f1_local13 = f1_local2
	end
	local f1_local14 = math.ceil(#CoD.GetUnlockablesBySlotName(f1_local13) / CoD.CACGrenades.GridColumns)
	f1_local6 = f1_local6 + CoD.CACGrenades.GridItemHeight * f1_local14 + CoD.CACGrenades.GridItemSpacing * (f1_local14 - 1) + 3
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
	local f1_local16 = 0
	f1_local0.grenadeTitle = LUI.UIText.new()
	f1_local0.grenadeTitle:setLeftRight(true, false, 0, 1)
	f1_local0.grenadeTitle:setTopBottom(true, false, f1_local16, f1_local16 + CoD.textSize.Big)
	f1_local0.grenadeTitle:setFont(CoD.fonts.Big)
	f1_local0.grenadeTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(f1_local0.grenadeTitle)
	f1_local16 = f1_local16 + CoD.textSize.Big
	f1_local0.grenadeDescription = LUI.UIText.new()
	f1_local0.grenadeDescription:setLeftRight(true, false, 0, CoD.CACGrenades.GridItemWidth * 2 + CoD.CACGrenades.GridItemSpacing * 2)
	f1_local0.grenadeDescription:setTopBottom(true, false, f1_local16, f1_local16 + CoD.textSize.Default)
	f1_local0.grenadeDescription:setAlignment(LUI.Alignment.Left)
	f1_local0.grenadeDescription:setFont(CoD.fonts.Default)
	f1_local0.grenadeDescription:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.grenadeDescription:setAlpha(0.4)
	Widget:addElement(f1_local0.grenadeDescription)
	if not Engine.AreAllItemsFree() then
		local f1_local17 = Engine.GetPlayerStats(f1_arg0)
		if f1_local17.PlayerStatsList.PLEVEL.StatValue:get() < tonumber(CoD.MAX_PRESTIGE) then
			local f1_local18 = CoD.CAC.CreateUnlockTokensFooter(f1_local0, f1_arg0)
			CoD.CAC.SetUnlockItemText(f1_local18, f1_arg0)
			f1_local0:addElement(f1_local18)
		end
	end
	CoD.CACGrenades.AddGrenades(f1_local0, f1_local13, f1_local4, f1_arg0, f1_local1, f1_local3)
	if f1_local2 == CoD.CACUtility.loadoutSlotNames.primaryGrenade and not CoD.CACUtility.IsBonusCardEquippedByName(f1_local3, "bonuscard_danger_close") then
		f1_local0.maxGrenades = 2
	else
		f1_local0.maxGrenades = 3
	end
	return f1_local0
end

CoD.CACGrenades.RemovePrestigeUnlockButton = function (f2_arg0, f2_arg1)
	if f2_arg0.prestigeUnlockButton then
		f2_arg0.prestigeUnlockButton:close()
		f2_arg0.prestigeUnlockButton = nil
	end
end

CoD.CACGrenades.AddPrestigeUnlockButton = function (f3_arg0, f3_arg1)
	if f3_arg0.prestigeUnlockButton == nil then
		f3_arg0:addPrestigeUnlockButton()
	end
end

CoD.CACGrenades.AddGrenades = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5)
	local f4_local0 = CoD.GetUnlockablesBySlotName(f4_arg1)
	local f4_local1 = nil
	for f4_local5, f4_local6 in ipairs(f4_local0) do
		local f4_local7 = CoD.GrenadeGridButton.new(f4_local6)
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

CoD.CACGrenades.ContentButtonHighlighted = function (f5_arg0, f5_arg1)
	if f5_arg1.contentIndex then
		f5_arg0.grenadeTitle:setText(Engine.Localize(UIExpression.GetItemName(nil, f5_arg1.contentIndex)))
		if UIExpression.IsItemLocked(f5_arg1.controller, f5_arg1.contentIndex) == 1 then
			f5_arg0.grenadeDescription:setText(CoD.GetUnlockStringForItemIndex(f5_arg1.controller, f5_arg1.contentIndex))
			f5_arg0:removeSelectButton()
		else
			f5_arg0.grenadeDescription:setText(Engine.Localize(UIExpression.GetItemDesc(nil, f5_arg1.contentIndex)))
			f5_arg0:addSelectButtonWithPrestigeUnlock()
		end
	else
		f5_arg0.grenadeTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f5_arg0.grenadeDescription:setText("")
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

CoD.CACGrenades.PrestigeUnlock = function (f6_arg0, f6_arg1)
	CoD.ConfirmPrestigeUnlock.OpenIfNecessary(f6_arg0, f6_arg1.controller, f6_arg0.weaponItemIndexHighlighted, f6_arg0.highlightedButton)
end

CoD.CACGrenades.ContentButtonSelected = function (f7_arg0, f7_arg1)
	CoD.perController[f7_arg1.controller].chosenItem = f7_arg1.contentIndex
	local f7_local0 = Engine.GetCustomClass(f7_arg1.controller, CoD.perController[f7_arg1.controller].classNum)
	local f7_local1 = CoD.perController[f7_arg1.controller].chosenItem
	local f7_local2 = false
	if CoD.ConfirmPurchase.OpenIfNecessary(f7_arg0, f7_arg1.controller, f7_arg1.contentIndex, f7_arg1.button) ~= nil then
		return 
	elseif f7_arg1.mutuallyExclusiveIndices then
		f7_local2 = true
		for f7_local6, f7_local7 in ipairs(f7_arg1.mutuallyExclusiveIndices) do
			CoD.CACGrenades.Unequip(f7_arg1.controller, f7_local0, f7_local7)
		end
	elseif f7_local0.allocationSpent < Engine.GetMaxAllocation(f7_arg1.controller) then
		f7_local2 = true
	elseif f7_local0[CoD.perController[f7_arg1.controller].grenadeSlot] then
		f7_local2 = true
	end
	if UIExpression.IsItemPurchased(f7_arg1.controller, f7_local1) == 0 then
		Engine.PlaySound(CoD.CACUtility.denySFX)
	elseif f7_local2 then
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

CoD.CACGrenades.Purchased = function (f8_arg0, f8_arg1)
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

CoD.CACGrenades.Equip = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg1.controller
	local f9_local1 = CoD.perController[f9_local0].classNum
	local f9_local2 = Engine.GetCustomClass(f9_local0, f9_local1)
	local f9_local3 = CoD.perController[f9_local0].grenadeSlot
	local f9_local4 = CoD.perController[f9_local0].chosenItem
	CoD.perController[f9_local0].chosenItem = nil
	if f9_arg0.equipSFX ~= nil then
		Engine.PlaySound(f9_arg0.equipSFX)
	end
	if f9_local2[f9_local3] ~= f9_local4 then
		CoD.perController[f9_local0].itemIndex = f9_local4
		Engine.SetClassItem(f9_local0, f9_local1, f9_local3, f9_local4)
		Engine.SetClassItem(f9_local0, f9_local1, f9_local3 .. "count", 1)
		Engine.SetClassItem(f9_local0, f9_local1, f9_local3 .. "status1", 1)
		Engine.SetClassItem(f9_local0, f9_local1, f9_local3 .. "status2", 0)
		Engine.SetClassItem(f9_local0, f9_local1, f9_local3 .. "status3", 0)
	end
	CoD.EquipNotification.AddToNotificationQueue("item", "equipped", UIExpression.GetItemName(nil, f9_local4))
	f9_arg0:processEvent({
		name = "button_prompt_back",
		controller = f9_arg1.controller
	})
end

CoD.CACGrenades.Unequip = function (f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = CoD.perController[f10_arg0].classNum
	local f10_local1 = nil
	if f10_arg1[CoD.CACUtility.loadoutSlotNames.primaryGrenade] == f10_arg2 then
		f10_local1 = CoD.CACUtility.loadoutSlotNames.primaryGrenade
	elseif f10_arg1[CoD.CACUtility.loadoutSlotNames.specialGrenade] == f10_arg2 then
		f10_local1 = CoD.CACUtility.loadoutSlotNames.specialGrenade
	else
		return 
	end
	Engine.SetClassItem(f10_arg0, f10_local0, f10_local1, 0)
	Engine.SetClassItem(f10_arg0, f10_local0, f10_local1 .. "count", 0)
	Engine.SetClassItem(f10_arg0, f10_local0, f10_local1 .. "status1", 0)
	Engine.SetClassItem(f10_arg0, f10_local0, f10_local1 .. "status2", 0)
	Engine.SetClassItem(f10_arg0, f10_local0, f10_local1 .. "status3", 0)
end

