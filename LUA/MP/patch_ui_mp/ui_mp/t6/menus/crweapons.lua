require("T6.Menus.CRMiniFriendsList")
CoD.CRWeapons = {}
CoD.CRWeapons.NumStats = 4
CoD.CRWeapons.ChallengeIndexArray = {
	weapon_smg = {
		931,
		29,
		922
	},
	peacekeeper = {
		931,
		223,
		922
	},
	weapon_assault = {
		932,
		44,
		923
	},
	weapon_cqb = {
		933,
		74,
		924
	},
	weapon_lmg = {
		934,
		59,
		925
	},
	weapon_sniper = {
		935,
		89,
		926
	},
	weapon_pistol = {
		936,
		14,
		927
	},
	weapon_shotgun = {
		937,
		74,
		928
	},
	weapon_special = {
		938,
		145,
		929
	},
	weapon_launcher = {
		939,
		122,
		930
	}
}
CoD.CRWeapons.SpecialCaseWeapons = {
	smaw = {
		headshots = true,
		kdRatio = true,
		accuracy = true
	},
	fhj18 = {
		headshots = true,
		kdRatio = true,
		accuracy = true
	},
	usrpg = {
		headshots = true,
		kdRatio = true,
		accuracy = true
	},
	riotshield = {
		headshots = true,
		accuracy = true
	},
	crossbow = {
		headshots = true
	}
}
CoD.CRWeapons.ListBoxButtonData = function (f1_arg0, f1_arg1, f1_arg2)
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

CoD.CRWeapons.SetupElements = function (f2_arg0, f2_arg1)
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
	f2_arg0.statsInfoBox = CoD.CRCommon.GetGenericStatsInfoBox(CoD.CRWeapons.NumStats, 256, 128)
	Widget:addElement(f2_arg0.statsInfoBox)
	f2_arg0:addElement(Widget)
	local f2_local4 = {}
	local f2_local5 = Engine.Localize("MENU_KILLS")
	local f2_local6 = Engine.Localize("MENU_LB_HEADSHOTS")
	local f2_local7 = Engine.Localize("MENU_LB_ACCURACY")
	local Widget = Engine.Localize("MENU_KD_SHORT")
	f2_arg0.statsInfoBox:setLabels(f2_local5)
	f2_local1 = f2_local1 + f2_local2 + 30
	f2_local5 = 50
	f2_local6 = 350
	f2_local7 = "Default"
	Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 8, f2_local6 - 8)
	Widget:setTopBottom(true, false, f2_local1, CoD.textSize[f2_local7])
	local f2_local9 = CoD.CRCommon.GetTextElem(f2_local7, "Left", Engine.Localize("MPUI_WEAPON"), CoD.gray)
	local f2_local10 = CoD.CRCommon.GetTextElem(f2_local7, "Right", Engine.Localize("MENU_KILLS"), CoD.gray)
	Widget:addElement(f2_local9)
	Widget:addElement(f2_local10)
	f2_local1 = f2_local1 + 30
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f2_local6)
	Widget:setTopBottom(true, true, f2_local1, -f2_local5)
	f2_arg0:addElement(Widget)
	f2_arg0:addElement(Widget)
	f2_arg0.listBox = CoD.CRCommon.GetGenericListBox(f2_arg1, f2_local6, CoD.CRWeapons.ListBoxButtonData)
	Widget:addElement(f2_arg0.listBox)
	local f2_local12 = 256 / 4
	f2_local0 = CoD.Menu.Width / 2 + 50
	local f2_local13 = CoD.CRCommon.GetGenericBackingsContainer()
	f2_arg0.backingsContainer = f2_local13
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f2_local0, 0)
	Widget:setTopBottom(true, true, f2_local1, 0)
	Widget:addElement(f2_local13)
	f2_arg0:addElement(Widget)
	local f2_local15 = Engine.GetCombatRecordSortedItemInfo(0)
	if f2_local15 and f2_local15.numItems and f2_local15.numItems > 0 then
		f2_arg0.listBox:setTotalItems(f2_local15.numItems)
	end
end

CoD.CRWeapons.HideStatForWeapon = function (f3_arg0, f3_arg1)
	if CoD.CRWeapons.SpecialCaseWeapons[f3_arg0] and CoD.CRWeapons.SpecialCaseWeapons[f3_arg0][f3_arg1] then
		return true
	else

	end
end

CoD.CRWeapons.ListBoxButtonGainFocus = function (f4_arg0, f4_arg1)
	if f4_arg1.mutables and f4_arg1.mutables.sortedItemInfo then
		local f4_local0 = f4_arg1.mutables.sortedItemInfo.itemIndex
		local f4_local1 = CoD.CRCommon.GetStats(f4_arg1.controller, CoD.CRCommon.OtherPlayerCRMode)
		f4_local1 = f4_local1.ItemStats[f4_local0].stats
		local f4_local2 = {}
		local f4_local3 = ""
		local f4_local4, f4_local5, f4_local6 = nil
		local f4_local7 = ""
		local f4_local8 = ""
		local f4_local9 = ""
		local f4_local10 = ""
		local f4_local11, f4_local12, f4_local13 = nil
		local f4_local14 = ""
		local f4_local15 = ""
		local f4_local16 = ""
		local f4_local17 = nil
		local f4_local18 = UIExpression.GetItemRef(nil, f4_local0)
		f4_arg0.currGameTypeLabel:setText(Engine.Localize(UIExpression.GetItemName(nil, f4_local0)))
		if f4_local1 then
			f4_local3 = f4_local1.kills.StatValue:get()
			f4_local4 = math.max(1, f4_local1.deathsDuringUse.StatValue:get())
			f4_local5 = f4_local1.hits.StatValue:get()
			f4_local6 = math.max(1, f4_local1.shots.StatValue:get())
			f4_local8 = f4_local1.headshots.StatValue:get()
			if f4_local4 then
				f4_local7 = string.format("%.2f", f4_local3 / f4_local4)
			end
			if f4_local6 then
				f4_local9 = string.format("%.2f", f4_local5 / f4_local6 * 100) .. "%"
			end
			f4_local17 = UIExpression.GetItemImage(nil, f4_local0) .. "_big"
		end
		if CoD.CRCommon.ComparisonModeOn then
			local f4_local19 = nil
			if CoD.CRCommon.OtherPlayerCRMode then
				local f4_local20 = CoD.CRCommon.GetStats(f4_arg1.controller)
				f4_local19 = f4_local20.ItemStats[f4_local0].stats
			else
				local f4_local20 = CoD.CRCommon.GetStats(f4_arg1.controller, true)
				f4_local19 = f4_local20.ItemStats[f4_local0].stats
			end
			if f4_local19 then
				f4_local10 = f4_local19.kills.StatValue:get()
				f4_local11 = math.max(1, f4_local19.deathsDuringUse.StatValue:get())
				f4_local12 = f4_local19.hits.StatValue:get()
				f4_local13 = math.max(1, f4_local19.shots.StatValue:get())
				f4_local15 = f4_local19.headshots.StatValue:get()
				if f4_local4 then
					f4_local14 = string.format("%.2f", f4_local10 / f4_local11)
				end
				if f4_local6 then
					f4_local16 = string.format("%.2f", f4_local12 / f4_local13 * 100) .. "%"
				end
			end
		end
		if CoD.CRWeapons.HideStatForWeapon(f4_local18, "headshots") then
			f4_local8 = "--"
			if f4_local15 ~= "" then
				f4_local15 = "--"
			end
		end
		if CoD.CRWeapons.HideStatForWeapon(f4_local18, "accuracy") then
			f4_local9 = "--"
			if f4_local16 ~= "" then
				f4_local16 = "--"
			end
		end
		if CoD.CRWeapons.HideStatForWeapon(f4_local18, "kdRatio") then
			f4_local7 = "--"
			if f4_local14 ~= "" then
				f4_local14 = "--"
			end
		end
		table.insert(f4_local2, {
			baseValue = f4_local3,
			comparisonValue = f4_local10
		})
		table.insert(f4_local2, {
			baseValue = f4_local8,
			comparisonValue = f4_local15
		})
		table.insert(f4_local2, {
			baseValue = f4_local9,
			comparisonValue = f4_local16
		})
		table.insert(f4_local2, {
			baseValue = f4_local7,
			comparisonValue = f4_local14
		})
		f4_arg0.statsInfoBox:update(f4_local2, f4_local17)
		local f4_local19 = UIExpression.GetItemGroup(nil, f4_local0)
		if f4_local19 == "weapon_smg" then
			local f4_local20 = UIExpression.GetItemRef(nil, f4_local0)
			if f4_local20 == "peacekeeper" then
				f4_local19 = f4_local20
			end
		end
		if f4_local19 and CoD.CRWeapons.ChallengeIndexArray[f4_local19] then
			local f4_local20 = CoD.CRWeapons.ChallengeIndexArray[f4_local19]
			f4_arg0.backingsContainer:updateBackings(f4_arg1.controller, Engine.GetCombatRecordChallengeBackings(f4_arg1.controller, f4_arg1.mutables.sortedItemIndex, CoD.CRCommon.OtherPlayerCRMode == true, f4_local20[1], f4_local20[2], f4_local20[3]))
		end
	end
end

CoD.CRWeapons.CompareStats = function (f5_arg0, f5_arg1)
	if not CoD.CRCommon.OtherPlayerCRMode then
		f5_arg0:openPopup("CRMiniFriendsList", f5_arg1.controller)
	else
		f5_arg0:processEvent({
			name = "service_record_fetched"
		})
	end
end

CoD.CRWeapons.FriendsStatsFetched = function (f6_arg0, f6_arg1)
	CoD.CRCommon.ComparisonModeOn = true
	f6_arg0.comparisonContainer:update(f6_arg0.m_ownerController)
	f6_arg0.listBox:refresh(true)
end

LUI.createMenu.CRWeapons = function (f7_arg0)
	local f7_local0 = CoD.Menu.New("CRWeapons")
	f7_local0:addLargePopupBackground()
	f7_local0:setOwner(f7_arg0)
	f7_local0:setPreviousMenu("Barracks")
	f7_local0:addBackButton()
	local f7_local1 = CoD.ButtonPrompt.new
	local f7_local2 = "alt1"
	local f7_local3 = Engine.Localize("MENU_COMPARE")
	local f7_local4 = f7_local0
	local f7_local5 = "compare_stats"
	local f7_local6, f7_local7 = false
	local f7_local8, f7_local9 = false
	f7_local0.compareButtonPrompt = f7_local1(f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7, f7_local8, f7_local9, "C")
	f7_local0:addLeftButtonPrompt(f7_local0.compareButtonPrompt)
	f7_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MPUI_WEAPONS_CAPS")))
	Engine.SortItemsForCombatRecord(f7_arg0, CoD.CRCommon.SortTypes.WEAPONS, CoD.CRCommon.OtherPlayerCRMode == true)
	f7_local0:registerEventHandler("listbox_button_gain_focus", CoD.CRWeapons.ListBoxButtonGainFocus)
	f7_local0:registerEventHandler("service_record_fetched", CoD.CRWeapons.FriendsStatsFetched)
	f7_local0:registerEventHandler("compare_stats", CoD.CRWeapons.CompareStats)
	CoD.CRWeapons.SetupElements(f7_local0, f7_arg0)
	return f7_local0
end

