require("T6.Menus.CRMiniFriendsList")
CoD.CRScorestreaks = {}
CoD.CRScorestreaks.NumStats = 2
CoD.CRScorestreaks.ChallengeIndexArray = {
	killstreak_rcbomb = {
		126,
		-1,
		-1
	},
	killstreak_spyplane = {
		819,
		-1,
		-1
	},
	killstreak_missile_drone = {
		130,
		-1,
		-1
	},
	killstreak_counteruav = {
		827,
		-1,
		-1
	},
	killstreak_supply_drop = {
		-1,
		-1,
		-1
	},
	killstreak_microwave_turret = {
		823,
		-1,
		-1
	},
	killstreak_remote_missile = {
		130,
		-1,
		-1
	},
	killstreak_planemortar = {
		130,
		-1,
		-1
	},
	killstreak_auto_turret = {
		126,
		-1,
		-1
	},
	killstreak_minigun = {
		126,
		-1,
		-1
	},
	killstreak_m32 = {
		126,
		-1,
		-1
	},
	killstreak_qrdrone = {
		130,
		-1,
		-1
	},
	killstreak_ai_tank_drop = {
		126,
		-1,
		-1
	},
	killstreak_helicopter_comlink = {
		130,
		-1,
		-1
	},
	killstreak_spyplane_direction = {
		835,
		-1,
		-1
	},
	killstreak_helicopter_guard = {
		130,
		-1,
		-1
	},
	killstreak_straferun = {
		130,
		-1,
		-1
	},
	killstreak_emp = {
		831,
		-1,
		-1
	},
	killstreak_remote_mortar = {
		130,
		-1,
		-1
	},
	killstreak_helicopter_player_gunner = {
		130,
		-1,
		-1
	},
	killstreak_dogs = {
		126,
		-1,
		-1
	},
	killstreak_missile_swarm = {
		130,
		-1,
		-1
	}
}
CoD.CRScorestreaks.ListBoxButtonData = function (f1_arg0, f1_arg1, f1_arg2)
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

CoD.CRScorestreaks.SetupElements = function (f2_arg0, f2_arg1)
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
	f2_arg0.statsInfoBox = CoD.CRCommon.GetGenericStatsInfoBox(CoD.CRScorestreaks.NumStats, 150, 150, 200)
	Widget:addElement(f2_arg0.statsInfoBox)
	f2_arg0:addElement(Widget)
	f2_local1 = f2_local1 + f2_local2 + 30
	local f2_local4 = 50
	local f2_local5 = 350
	local f2_local6 = "Default"
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 8, f2_local5 - 8)
	Widget:setTopBottom(true, false, f2_local1, CoD.textSize[f2_local6])
	local f2_local8 = CoD.CRCommon.GetTextElem(f2_local6, "Left", Engine.Localize("MPUI_KILLSTREAK"), CoD.gray)
	local f2_local9 = CoD.CRCommon.GetTextElem(f2_local6, "Right", Engine.Localize("MENU_USED"), CoD.gray)
	Widget:addElement(f2_local8)
	Widget:addElement(f2_local9)
	f2_local1 = f2_local1 + 30
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f2_local5)
	Widget:setTopBottom(true, true, f2_local1, -f2_local4)
	f2_arg0:addElement(Widget)
	f2_arg0:addElement(Widget)
	f2_arg0.listBox = CoD.CRCommon.GetGenericListBox(f2_arg1, f2_local5, CoD.CRScorestreaks.ListBoxButtonData)
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

CoD.CRScorestreaks.ListBoxButtonGainFocus = function (f3_arg0, f3_arg1)
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
			f3_local5 = f3_local1.assists.StatValue:get()
			f3_local9 = UIExpression.GetItemImage(nil, f3_local0) .. "_menu"
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
				f3_local8 = f3_local10.assists.StatValue:get()
			end
		end
		table.insert(f3_local2, {
			baseValue = f3_local3,
			comparisonValue = f3_local6
		})
		local f3_local10 = nil
		if UIExpression.TableLookup(controller, "mp/statsTable.csv", 0, tostring(f3_local0), 1) ~= "passive" then
			local f3_local12 = {}
			local f3_local13 = Engine.Localize("MENU_USED")
			local f3_local14 = Engine.Localize("MENU_KILLS")
			f3_local10 = f3_local13
			table.insert(f3_local2, {
				baseValue = f3_local4,
				comparisonValue = f3_local7
			})
		else
			local f3_local12 = {}
			local f3_local13 = Engine.Localize("MENU_USED")
			local f3_local14 = Engine.Localize("MENU_ASSISTS")
			f3_local10 = f3_local13
			table.insert(f3_local2, {
				baseValue = f3_local5,
				comparisonValue = f3_local8
			})
		end
		f3_arg0.statsInfoBox:setLabels(f3_local10)
		f3_arg0.statsInfoBox:update(f3_local2, f3_local9)
		local f3_local12 = UIExpression.GetItemRef(nil, f3_local0)
		if f3_local12 and CoD.CREquipment.ChallengeIndexArray[f3_local12] then
			local f3_local13 = CoD.CRScorestreaks.ChallengeIndexArray[itemGroup]
			f3_arg0.backingsContainer:updateBackings(f3_arg1.controller, Engine.GetCombatRecordChallengeBackings(f3_arg1.controller, f3_arg1.mutables.sortedItemIndex, CoD.CRCommon.OtherPlayerCRMode == true, f3_local13[1], f3_local13[2], f3_local13[3]))
		end
	end
end

CoD.CRScorestreaks.CompareStats = function (f4_arg0, f4_arg1)
	if not CoD.CRCommon.OtherPlayerCRMode then
		f4_arg0:openPopup("CRMiniFriendsList", f4_arg1.controller)
	else
		f4_arg0:processEvent({
			name = "service_record_fetched"
		})
	end
end

CoD.CRScorestreaks.FriendsStatsFetched = function (f5_arg0, f5_arg1)
	CoD.CRCommon.ComparisonModeOn = true
	f5_arg0.comparisonContainer:update(f5_arg0.m_ownerController)
	f5_arg0.listBox:refresh(true)
end

LUI.createMenu.CRScorestreaks = function (f6_arg0)
	local f6_local0 = CoD.Menu.New("CRScorestreaks")
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
	f6_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_SCORE_STREAKS_CAPS")))
	Engine.SortItemsForCombatRecord(f6_arg0, CoD.CRCommon.SortTypes.SCORESTREAKS, CoD.CRCommon.OtherPlayerCRMode == true)
	f6_local0:registerEventHandler("listbox_button_gain_focus", CoD.CRScorestreaks.ListBoxButtonGainFocus)
	f6_local0:registerEventHandler("service_record_fetched", CoD.CRScorestreaks.FriendsStatsFetched)
	f6_local0:registerEventHandler("compare_stats", CoD.CRScorestreaks.CompareStats)
	CoD.CRScorestreaks.SetupElements(f6_local0, f6_arg0)
	return f6_local0
end

