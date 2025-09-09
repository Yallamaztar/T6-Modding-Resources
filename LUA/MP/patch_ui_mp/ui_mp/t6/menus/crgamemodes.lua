require("T6.Menus.CRMiniFriendsList")
CoD.CRGamemodes = {}
CoD.CRGamemodes.NumStats = 4
CoD.CRGamemodes.ChallengeIndexArray = {
	tdm = {
		779,
		770,
		940
	},
	dm = {
		779,
		770,
		941
	},
	dom = {
		779,
		770,
		942
	},
	sd = {
		779,
		770,
		943
	},
	ctf = {
		779,
		770,
		945
	},
	hq = {
		779,
		770,
		946
	},
	dem = {
		779,
		770,
		944
	},
	koth = {
		779,
		770,
		947
	},
	conf = {
		779,
		770,
		948
	},
	shrp = {
		779,
		770,
		949
	},
	sas = {
		779,
		770,
		950
	},
	oic = {
		779,
		770,
		951
	},
	gun = {
		779,
		770,
		952
	}
}
CoD.CRGamemodes.ListBoxButtonData = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = Engine.GetCombatRecordSortedItemInfo(f1_arg1 - 1)
	if not f1_local0 then
		return 
	end
	f1_arg2.sortedItemInfo = f1_local0
	f1_arg2.sortedItemIndex = f1_arg1 - 1
	f1_arg2.itemName:setText("")
	f1_arg2.itemValue:setText("")
	if f1_local0 and f1_local0.itemIndex then
		f1_arg2.itemNameText = Engine.Localize("MPUI_" .. Engine.GetGametypeName(f1_local0.itemIndex))
		f1_arg2.itemName:setText(f1_arg2.itemNameText)
	end
	if f1_local0 and f1_local0.itemValue then
		f1_arg2.itemValue:setText(f1_local0.itemValue)
	end
end

CoD.CRGamemodes.SetupElements = function (f2_arg0, f2_arg1)
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
	f2_arg0.statsInfoBox = CoD.CRCommon.GetGenericStatsInfoBox(CoD.CRGamemodes.NumStats, 150, 150)
	Widget:addElement(f2_arg0.statsInfoBox)
	f2_arg0:addElement(Widget)
	local f2_local4 = {}
	local f2_local5 = Engine.Localize("MENU_LB_WINS")
	local f2_local6 = Engine.Localize("MENU_WLRATIO")
	local f2_local7 = Engine.Localize("MENU_CURR_WIN_STREAK")
	local Widget = Engine.Localize("MENU_BEST_WIN_STREAK")
	f2_arg0.statsInfoBox:setLabels(f2_local5)
	f2_local1 = f2_local1 + f2_local2 + 30
	f2_local5 = 50
	f2_local6 = 350
	f2_local7 = "Default"
	Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 8, f2_local6 - 8)
	Widget:setTopBottom(true, false, f2_local1, CoD.textSize[f2_local7])
	local f2_local9 = CoD.CRCommon.GetTextElem(f2_local7, "Left", Engine.Localize("MENU_GAME_MODE_PRE"), CoD.gray)
	local f2_local10 = CoD.CRCommon.GetTextElem(f2_local7, "Right", Engine.Localize("MENU_LB_WINS"), CoD.gray)
	Widget:addElement(f2_local9)
	Widget:addElement(f2_local10)
	f2_local1 = f2_local1 + 30
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f2_local6)
	Widget:setTopBottom(true, true, f2_local1, -f2_local5)
	f2_arg0:addElement(Widget)
	f2_arg0:addElement(Widget)
	f2_arg0.listBox = CoD.CRCommon.GetGenericListBox(f2_arg1, f2_local6, CoD.CRGamemodes.ListBoxButtonData)
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

CoD.CRGamemodes.ListBoxButtonGainFocus = function (f3_arg0, f3_arg1)
	if f3_arg1.mutables and f3_arg1.mutables.sortedItemInfo then
		local f3_local0 = Engine.GetGametypeName(f3_arg1.mutables.sortedItemInfo.itemIndex)
		local f3_local1 = CoD.CRCommon.GetStats(f3_arg1.controller, CoD.CRCommon.OtherPlayerCRMode)
		f3_local1 = f3_local1.PlayerStatsByGameType[f3_local0]
		local f3_local2 = {}
		local f3_local3 = ""
		local f3_local4 = nil
		local f3_local5 = ""
		local f3_local6 = ""
		local f3_local7 = ""
		local f3_local8 = ""
		local f3_local9 = nil
		local f3_local10 = ""
		local f3_local11 = ""
		local f3_local12 = ""
		local f3_local13 = nil
		if f3_local0 then
			f3_arg0.currGameTypeLabel:setText(Engine.Localize("MPUI_" .. f3_local0))
		end
		if f3_local1 then
			f3_local3 = f3_local1.WINS.StatValue:get()
			f3_local4 = math.max(1, CoD.CombatRecord.GetLossesStat(f3_local1.LOSSES.StatValue))
			if f3_local4 then
				f3_local5 = string.format("%.2f", f3_local3 / f3_local4)
			end
			f3_local6 = f3_local1.CUR_WIN_STREAK.StatValue:get()
			f3_local7 = f3_local1.WIN_STREAK.StatValue:get()
			f3_local13 = CoD.CRCommon.GameTypeImageNames[f3_local0]
		end
		if CoD.CRCommon.ComparisonModeOn then
			local f3_local14 = nil
			if CoD.CRCommon.OtherPlayerCRMode then
				local f3_local15 = CoD.CRCommon.GetStats(f3_arg1.controller)
				f3_local14 = f3_local15.PlayerStatsByGameType[f3_local0]
			else
				local f3_local15 = CoD.CRCommon.GetStats(f3_arg1.controller, true)
				f3_local14 = f3_local15.PlayerStatsByGameType[f3_local0]
			end
			if f3_local14 then
				f3_local8 = f3_local14.WINS.StatValue:get()
				f3_local9 = math.max(1, CoD.CombatRecord.GetLossesStat(f3_local14.LOSSES.StatValue))
				if f3_local4 then
					f3_local10 = string.format("%.2f", f3_local8 / f3_local9)
				end
				f3_local11 = f3_local14.CUR_WIN_STREAK.StatValue:get()
				f3_local12 = f3_local14.WIN_STREAK.StatValue:get()
			end
		end
		table.insert(f3_local2, {
			baseValue = f3_local3,
			comparisonValue = f3_local8
		})
		table.insert(f3_local2, {
			baseValue = f3_local5,
			comparisonValue = f3_local10
		})
		table.insert(f3_local2, {
			baseValue = f3_local6,
			comparisonValue = f3_local11
		})
		table.insert(f3_local2, {
			baseValue = f3_local7,
			comparisonValue = f3_local12
		})
		f3_arg0.statsInfoBox:update(f3_local2, f3_local13)
		if f3_local0 and CoD.CRGamemodes.ChallengeIndexArray[f3_local0] then
			local f3_local14 = CoD.CRGamemodes.ChallengeIndexArray[f3_local0]
			f3_arg0.backingsContainer:updateBackings(f3_arg1.controller, Engine.GetCombatRecordChallengeBackings(f3_arg1.controller, f3_arg1.mutables.sortedItemIndex, CoD.CRCommon.OtherPlayerCRMode == true, f3_local14[1], f3_local14[2], f3_local14[3]))
		end
	end
end

CoD.CRGamemodes.CompareStats = function (f4_arg0, f4_arg1)
	if not CoD.CRCommon.OtherPlayerCRMode then
		f4_arg0:openPopup("CRMiniFriendsList", f4_arg1.controller)
	else
		f4_arg0:processEvent({
			name = "service_record_fetched"
		})
	end
end

CoD.CRGamemodes.FriendsStatsFetched = function (f5_arg0, f5_arg1)
	if CoD.CRCommon.ComparisonModeOn == false then
		Engine.PlaySound("cac_grid_equip_item")
	end
	CoD.CRCommon.ComparisonModeOn = true
	f5_arg0.comparisonContainer:update(f5_arg0.m_ownerController)
	f5_arg0.listBox:refresh(true)
end

LUI.createMenu.CRGamemodes = function (f6_arg0)
	local f6_local0 = CoD.Menu.New("CRGamemodes")
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
	f6_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_CHALLENGES_GAMEMODES")))
	Engine.SortItemsForCombatRecord(f6_arg0, CoD.CRCommon.SortTypes.GAMEMODES, CoD.CRCommon.OtherPlayerCRMode == true)
	f6_local0:registerEventHandler("listbox_button_gain_focus", CoD.CRGamemodes.ListBoxButtonGainFocus)
	f6_local0:registerEventHandler("service_record_fetched", CoD.CRGamemodes.FriendsStatsFetched)
	f6_local0:registerEventHandler("compare_stats", CoD.CRGamemodes.CompareStats)
	CoD.CRGamemodes.SetupElements(f6_local0, f6_arg0)
	return f6_local0
end

