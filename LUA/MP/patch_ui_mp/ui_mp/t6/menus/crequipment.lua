require("T6.Menus.CRMiniFriendsList")
CoD.CREquipment = {}
CoD.CREquipment.NumStats = 2
CoD.CREquipment.ChallengeIndexArray = {
	frag_grenade = {
		324,
		-1,
		-1
	},
	hatchet = {
		324,
		-1,
		-1
	},
	sticky_grenade = {
		324,
		-1,
		-1
	},
	satchel_charge = {
		324,
		-1,
		-1
	},
	bouncingbetty = {
		324,
		-1,
		-1
	},
	claymore = {
		324,
		-1,
		-1
	},
	willy_pete = {
		369,
		-1,
		-1
	},
	concussion_grenade = {
		359,
		-1,
		-1
	},
	emp_grenade = {
		354,
		-1,
		-1
	},
	sensor_grenade = {
		379,
		-1,
		-1
	},
	flash_grenade = {
		364,
		-1,
		-1
	},
	proximity_grenade = {
		349,
		-1,
		-1
	},
	pda_hack = {
		389,
		-1,
		-1
	},
	tactical_insertion = {
		374,
		-1,
		-1
	},
	trophy_system = {
		384,
		-1,
		-1
	}
}
CoD.CREquipment.SpecialStatStrings = {
	willy_pete = "MENU_CAPTURES_UNDER_COVER",
	concussion_grenade = "MENU_STUNNED_AND_KILLED",
	emp_grenade = "MENU_EQUIPMENT_DESTROYED",
	sensor_grenade = "MENU_DETECTED_AND_KILLED",
	flash_grenade = "MENU_BLINDED_AND_KILLED",
	proximity_grenade = "MENU_STUNNED_AND_KILLED",
	pda_hack = "MPUI_HACKS",
	tactical_insertion = "MENU_QUICK_KILLS_FROM_SPAWN",
	trophy_system = "MENU_PROJECTILES_DESTROYED"
}
CoD.CREquipment.ListBoxButtonData = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = Engine.GetCombatRecordSortedItemInfo(f1_arg1 - 1)
	if not f1_local0 then
		return 
	end
	f1_arg2.sortedItemInfo = f1_local0
	f1_arg2.sortedItemIndex = f1_arg1 - 1
	f1_arg2.itemName:setText("")
	f1_arg2.itemValue:setText("")
	if f1_local0 and f1_local0.itemIndex then
		f1_arg2.itemNameText = Engine.Localize(UIExpression.GetItemName(nil, f1_local0.itemIndex))
		f1_arg2.itemName:setText(f1_arg2.itemNameText)
	end
	if f1_local0 and f1_local0.itemValue then
		f1_arg2.itemValue:setText(f1_local0.itemValue)
	end
end

CoD.CREquipment.SetupElements = function (f2_arg0, f2_arg1)
	if CoD.CRCommon.CurrentXuid and CoD.CRCommon.CurrentXuid ~= "" and CoD.CRCommon.CurrentXuid ~= "0" then
		f2_arg0:addElement(CoD.MiniIdentity.GetMiniIdentity(f2_arg1, CoD.CRCommon.CurrentXuid))
	end
	f2_arg0.comparisonContainer = CoD.CRCommon.GetComparisonContainer()
	f2_arg0:addElement(f2_arg0.comparisonContainer)
	local f2_local0 = 0
	local f2_local1 = CoD.Menu.TitleHeight + 20
	f2_arg0.currGameTypeLabel = CoD.CRCommon.GetTextElem("Default", "Left", "", CoD.gray, f2_local1)
	f2_arg0:addElement(f2_arg0.currGameTypeLabel)
	f2_local1 = f2_local1 + CoD.textSize.Default + 8
	local f2_local2 = 185
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f2_local1, f2_local1 + f2_local2)
	f2_arg0.statsInfoBox = CoD.CRCommon.GetGenericStatsInfoBox(CoD.CREquipment.NumStats, 150, 150, 200)
	Widget:addElement(f2_arg0.statsInfoBox)
	f2_arg0:addElement(Widget)
	f2_local1 = f2_local1 + f2_local2 + 30
	local f2_local4 = 50
	local f2_local5 = 350
	local f2_local6 = "Default"
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 8, f2_local5 - 8)
	Widget:setTopBottom(true, false, f2_local1, CoD.textSize[f2_local6])
	local f2_local8 = CoD.CRCommon.GetTextElem(f2_local6, "Left", Engine.Localize("MENU_EQUIPMENT"), CoD.gray)
	local f2_local9 = CoD.CRCommon.GetTextElem(f2_local6, "Right", Engine.Localize("MENU_USED"), CoD.gray)
	Widget:addElement(f2_local8)
	Widget:addElement(f2_local9)
	f2_local1 = f2_local1 + 30
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f2_local5)
	Widget:setTopBottom(true, true, f2_local1, -f2_local4)
	f2_arg0:addElement(Widget)
	f2_arg0:addElement(Widget)
	f2_arg0.listBox = CoD.CRCommon.GetGenericListBox(f2_arg1, f2_local5, CoD.CREquipment.ListBoxButtonData)
	Widget:addElement(f2_arg0.listBox)
	local f2_local11 = 256 / 4
	f2_local0 = CoD.Menu.Width / 2 + 50
	local f2_local12 = CoD.CRCommon.GetGenericBackingsContainer()
	f2_arg0.backingsContainer = f2_local12
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f2_local0, 0)
	Widget:setTopBottom(true, true, f2_local1, 0)
	Widget:addElement(f2_local12)
	f2_arg0:addElement(Widget)
	local f2_local14 = Engine.GetCombatRecordSortedItemInfo(0)
	if f2_local14 and f2_local14.numItems and f2_local14.numItems > 0 then
		f2_arg0.listBox:setTotalItems(f2_local14.numItems)
	end
end

CoD.CREquipment.ListBoxButtonGainFocus = function (f3_arg0, f3_arg1)
	if f3_arg1.mutables and f3_arg1.mutables.sortedItemInfo then
		local f3_local0 = f3_arg1.mutables.sortedItemInfo.itemIndex
		local f3_local1 = CoD.CRCommon.GetStats(f3_arg1.controller, CoD.CRCommon.OtherPlayerCRMode)
		f3_local1 = f3_local1.ItemStats[f3_local0].stats
		local f3_local2 = {}
		local f3_local3 = ""
		local f3_local4 = ""
		local f3_local5 = ""
		local f3_local6 = ""
		local f3_local7 = ""
		local f3_local8 = ""
		local f3_local9 = nil
		f3_arg0.currGameTypeLabel:setText(Engine.Localize(UIExpression.GetItemName(nil, f3_local0)))
		if f3_local1 then
			f3_local3 = f3_local1.used.StatValue:get()
			f3_local4 = f3_local1.kills.StatValue:get()
			f3_local5 = f3_local1.combatRecordStat.StatValue:get()
			f3_local9 = UIExpression.GetItemImage(nil, f3_local0) .. "_256"
		end
		if CoD.CRCommon.ComparisonModeOn then
			local f3_local10 = nil
			if CoD.CRCommon.OtherPlayerCRMode then
				local f3_local11 = CoD.CRCommon.GetStats(f3_arg1.controller)
				f3_local10 = f3_local11.ItemStats[f3_local0].stats
			else
				local f3_local11 = CoD.CRCommon.GetStats(f3_arg1.controller, true)
				f3_local10 = f3_local11.ItemStats[f3_local0].stats
			end
			if f3_local10 then
				f3_local6 = f3_local10.used.StatValue:get()
				f3_local7 = f3_local10.kills.StatValue:get()
				f3_local8 = f3_local10.combatRecordStat.StatValue:get()
			end
		end
		table.insert(f3_local2, {
			baseValue = f3_local3,
			comparisonValue = f3_local6
		})
		local f3_local10 = nil
		local f3_local11 = UIExpression.GetItemRef(nil, f3_local0)
		if CoD.IsLethalGrenade(f3_local0) then
			local f3_local12 = {}
			local f3_local13 = Engine.Localize("MENU_USED")
			local f3_local14 = Engine.Localize("MENU_KILLS")
			f3_local10 = f3_local13
			table.insert(f3_local2, {
				baseValue = f3_local4,
				comparisonValue = f3_local7
			})
		else
			local f3_local12 = Engine.Localize("MENU_ASSISTS")
			if f3_local11 and CoD.CREquipment.SpecialStatStrings[f3_local11] then
				f3_local12 = Engine.Localize(CoD.CREquipment.SpecialStatStrings[f3_local11])
			end
			f3_local10 = {
				Engine.Localize("MENU_USED"),
				f3_local12
			}
			table.insert(f3_local2, {
				baseValue = f3_local5,
				comparisonValue = f3_local8
			})
		end
		f3_arg0.statsInfoBox:setLabels(f3_local10)
		f3_arg0.statsInfoBox:update(f3_local2, f3_local9)
		if f3_local11 and CoD.CREquipment.ChallengeIndexArray[f3_local11] then
			local f3_local12 = CoD.CREquipment.ChallengeIndexArray[f3_local11]
			f3_arg0.backingsContainer:updateBackings(f3_arg1.controller, Engine.GetCombatRecordChallengeBackings(f3_arg1.controller, f3_arg1.mutables.sortedItemIndex, CoD.CRCommon.OtherPlayerCRMode == true, f3_local12[1], f3_local12[2], f3_local12[3]))
		end
	end
end

CoD.CREquipment.CompareStats = function (f4_arg0, f4_arg1)
	if not CoD.CRCommon.OtherPlayerCRMode then
		f4_arg0:openPopup("CRMiniFriendsList", f4_arg1.controller)
	else
		f4_arg0:processEvent({
			name = "service_record_fetched"
		})
	end
end

CoD.CREquipment.FriendsStatsFetched = function (f5_arg0, f5_arg1)
	CoD.CRCommon.ComparisonModeOn = true
	f5_arg0.comparisonContainer:update(f5_arg0.m_ownerController)
	f5_arg0.listBox:refresh(true)
end

LUI.createMenu.CREquipment = function (f6_arg0)
	local f6_local0 = CoD.Menu.New("CREquipment")
	f6_local0:addLargePopupBackground()
	f6_local0:setOwner(f6_arg0)
	f6_local0:setPreviousMenu("Barracks")
	f6_local0:addBackButton()
	local f6_local1 = CoD.ButtonPrompt.new
	local f6_local2 = "alt1"
	local f6_local3 = Engine.Localize("MENU_COMPARE")
	local f6_local4 = f6_local0
	local f6_local5 = "compare_stats"
	local f6_local6, f6_local7 = false
	local f6_local8, f6_local9 = false
	f6_local0.compareButtonPrompt = f6_local1(f6_local2, f6_local3, f6_local4, f6_local5, f6_local6, f6_local7, f6_local8, f6_local9, "C")
	f6_local0:addLeftButtonPrompt(f6_local0.compareButtonPrompt)
	f6_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MPUI_EQUIPMENT_CAPS")))
	Engine.SortItemsForCombatRecord(f6_arg0, CoD.CRCommon.SortTypes.EQUIPMENT, CoD.CRCommon.OtherPlayerCRMode == true)
	f6_local0:registerEventHandler("listbox_button_gain_focus", CoD.CREquipment.ListBoxButtonGainFocus)
	f6_local0:registerEventHandler("service_record_fetched", CoD.CREquipment.FriendsStatsFetched)
	f6_local0:registerEventHandler("compare_stats", CoD.CREquipment.CompareStats)
	CoD.CREquipment.SetupElements(f6_local0, f6_arg0)
	return f6_local0
end

