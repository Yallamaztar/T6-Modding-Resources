require("T6.CoD9Button")
CoD.LeagueLeaderboard = {}
CoD.LeagueLeaderboard.BackgroundInset = 2
CoD.LeagueLeaderboard.ItemWidth = 280
CoD.LeagueLeaderboard.ItemHeight = 200
CoD.LeagueLeaderboard.HighlightedItemWidth = CoD.LeagueLeaderboard.ItemWidth * 1.2
CoD.LeagueLeaderboard.HighligtedItemHeight = CoD.LeagueLeaderboard.ItemHeight * 1.2
CoD.LeagueLeaderboard.MaxResults = 100
CoD.LeagueLeaderboard.LBRANK_XLEFT = 0
CoD.LeagueLeaderboard.LBRANK_XRIGHT = 50
CoD.LeagueLeaderboard.PADDING = 5
CoD.LeagueLeaderboard.NAME_XLEFT = CoD.LeagueLeaderboard.LBRANK_XRIGHT + 10
CoD.LeagueLeaderboard.NAME_XRIGHT = CoD.LeagueLeaderboard.NAME_XLEFT + 175
CoD.LeagueLeaderboard.DATACOLS_XLEFT = CoD.LeagueLeaderboard.NAME_XRIGHT
CoD.LeagueLeaderboard.TeamMemberInfoCacheSize = 30
CoD.LeagueLeaderboard.TeamMemberInfoFetchDelay = 750
CoD.LeagueLeaderboard.MaxTeamMembers = 6
CoD.LeagueLeaderboard.DataFetched = function (f1_arg0, f1_arg1)
	f1_arg0.listBox:addScrollBar()
	if f1_arg1 ~= nil and f1_arg1.success == false then
		f1_arg0.listBox:showError(Engine.Localize("MPUI_LB_ERROR"))
		return 
	elseif f1_arg0.m_initialLoad == false then
		f1_arg0.pivotIndex = f1_arg1.pivot
		f1_arg0.listBox:setTotalItems(f1_arg1.totalResults, f1_arg1.pivot)
		f1_arg0.m_initialLoad = true
	else
		f1_arg0.listBox:refresh()
	end
end

CoD.LeagueLeaderboard.LoadNew = function (f2_arg0, f2_arg1)
	if not CoD.LeaguesData.CurrentTeamSubdivisionInfo or not CoD.LeaguesData.CurrentTeamSubdivisionInfo.subdivisionID or not CoD.LeaguesData.CurrentTeamSubdivisionInfo.teamID then
		return 
	elseif f2_arg0 ~= nil and f2_arg1 ~= nil then
		f2_arg0.m_initialLoad = false
		Engine.Exec(f2_arg1.controller, "leagueFetchLbData " .. CoD.LeaguesData.CurrentTeamSubdivisionInfo.subdivisionID .. " " .. CoD.LeagueLeaderboard.MaxResults .. " " .. CoD.LeaguesData.CurrentTeamSubdivisionInfo.teamID)
		if f2_arg0.pivotRow ~= nil then
			f2_arg0:removeElement(f2_arg0.pivotRow)
			f2_arg0.pivotRow = nil
		end
		if f2_arg0.headerRow ~= nil then
			f2_arg0:removeElement(f2_arg0.headerRow)
			f2_arg0.headerRow = nil
		end
		f2_arg0.listBox:showMessage(Engine.Localize("MENU_LB_LOADING"))
	end
end

CoD.LeagueLeaderboard.JumpToTop = function (f3_arg0, f3_arg1)
	if f3_arg0 ~= nil and f3_arg0.listBox ~= nil then
		f3_arg0.listBox:jumpToTop()
	end
end

CoD.LeagueLeaderboard.UpdateTeamMemberNames = function (f4_arg0, f4_arg1)
	for f4_local0 = 1, CoD.LeagueLeaderboard.MaxTeamMembers, 1 do
		f4_arg0.teamMemberNames[f4_local0]:setText("")
	end
	if f4_arg1 then
		for f4_local0 = 1, f4_arg0.numTeamMembersToShow, 1 do
			f4_arg0.teamMemberNames[f4_local0]:setText(f4_arg1.members[f4_local0].userName)
		end
	end
end

CoD.LeagueLeaderboard.UpdateEmblemsAndNames = function (f5_arg0, f5_arg1)
	if f5_arg0.numTeamMembersToShow == 1 then
		if f5_arg1.members and f5_arg1.members[1] and f5_arg1.members[1].xuid then
			f5_arg0.teamEmblemImage:setupPlayerEmblemByXUID(f5_arg1.members[1].xuid)
			f5_arg0.teamEmblemImage:show()
			if f5_arg0.selectButton then
				f5_arg0.selectButton:close()
			end
			f5_arg0:addSelectButton()
			f5_arg0.selectedPlayerXuid = f5_arg1.members[1].xuid
		end
	else
		CoD.LeagueLeaderboard.UpdateTeamMemberNames(f5_arg0, f5_arg1)
	end
	f5_arg0.teamEmblemSpinner:hide()
	f5_arg0.spinner:hide()
end

CoD.LeagueLeaderboard.TeamMemberInfoFetched = function (f6_arg0, f6_arg1)
	if f6_arg1.success == false then
		return 
	elseif CoD.LeagueLeaderboard.TeamMemberInfoCacheSize <= #CoD.LeaguesData.LbTeamMemberInfos then
		CoD.LeaguesData.LbTeamMemberInfos = {}
	end
	table.insert(CoD.LeaguesData.LbTeamMemberInfos, f6_arg1.teamMemberInfo)
	if f6_arg1.teamMemberInfo.teamID == CoD.LeagueLeaderboard.HighlightedTeamID then
		CoD.LeagueLeaderboard.UpdateEmblemsAndNames(f6_arg0, f6_arg1.teamMemberInfo)
	end
end

CoD.LeagueLeaderboard.ButtonAction = function (f7_arg0, f7_arg1)
	if not f7_arg0.selectedPlayerXuid then
		return 
	else
		CoD.FriendPopup.SelectedPlayerXuid = f7_arg0.selectedPlayerXuid
		CoD.FriendPopup.SelectedPlayerName = CoD.LeagueLeaderboard.HighlightedTeamName
		CoD.FriendPopup.LeagueLeaderboardMemberSelected = true
		Dvar.selectedPlayerXuid:set(f7_arg0.selectedPlayerXuid)
		f7_arg0:openPopup("FriendPopup", f7_arg1.controller)
	end
end

CoD.LeagueLeaderboard.GetTeamMemberInfoFromCache = function (f8_arg0)
	if not CoD.LeaguesData.LbTeamMemberInfos or #CoD.LeaguesData.LbTeamMemberInfos == 0 then
		return 
	end
	for f8_local3, f8_local4 in ipairs(CoD.LeaguesData.LbTeamMemberInfos) do
		if f8_local4.teamID == f8_arg0 then
			return f8_local4
		end
	end
end

CoD.LeagueLeaderboard.FetchTeamMemberInfo = function (f9_arg0, f9_arg1)
	if CoD.LeagueLeaderboard.HighlightedTeamID then
		Engine.FetchLeagueLbTeamMemberInfo(f9_arg0.m_ownerController, CoD.LeagueLeaderboard.HighlightedTeamID)
	end
end

CoD.LeagueLeaderboard.JumpToTop = function (f10_arg0, f10_arg1)
	if f10_arg0.listBox then
		f10_arg0.listBox:jumpToTop()
	end
end

CoD.LeagueLeaderboard.GoBack = function (f11_arg0, f11_arg1)
	CoD.FriendPopup.LeagueLeaderboardMemberSelected = false
	CoD.Menu.goBack(f11_arg0, f11_arg1)
end

LUI.createMenu.LeagueLeaderboard = function (f12_arg0, f12_arg1)
	local f12_local0 = CoD.Menu.New("LeagueLeaderboard")
	f12_local0:addLargePopupBackground()
	f12_local0:setOwner(f12_arg0)
	f12_local0:addBackButton()
	f12_local0.goBack = CoD.LeagueLeaderboard.GoBack
	CoD.LeaguesData.LbTeamMemberInfos = {}
	if f12_arg1 ~= true then
		f12_local0:setPreviousMenu("LeagueTeams")
	end
	if CoD.LeagueLeaderboard.previousMenuName then
		f12_local0:setPreviousMenu(CoD.LeagueLeaderboard.previousMenuName)
		CoD.LeagueLeaderboard.previousMenuName = nil
	end
	CoD.LeagueLeaderboard.SetupElements(f12_local0, f12_arg0)
	f12_local0:registerEventHandler("league_lb_data_fetched", CoD.LeagueLeaderboard.DataFetched)
	f12_local0:registerEventHandler("league_lb_loadnew", CoD.LeagueLeaderboard.LoadNew)
	f12_local0:registerEventHandler("league_lb_jumpToTop", CoD.LeagueLeaderboard.JumpToTop)
	f12_local0:registerEventHandler("listbox_button_gain_focus", CoD.LeagueLeaderboard.ButtonGainFocus)
	f12_local0:registerEventHandler("league_lb_team_member_info_fetched", CoD.LeagueLeaderboard.TeamMemberInfoFetched)
	f12_local0:registerEventHandler("fetch_league_lb_team_member_info", CoD.LeagueLeaderboard.FetchTeamMemberInfo)
	f12_local0:registerEventHandler("click", CoD.LeagueLeaderboard.ButtonAction)
	f12_local0:registerEventHandler("lb_jumpToTop", CoD.LeagueLeaderboard.JumpToTop)
	f12_local0:processEvent({
		name = "league_lb_loadnew",
		controller = f12_arg0
	})
	return f12_local0
end

local f0_local0 = function (f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = LUI.UITightText.new()
	f13_local0:setLeftRight(true, false, 0, 1)
	f13_local0:setTopBottom(true, false, 0, CoD.textSize[f13_arg0])
	f13_local0:setFont(CoD.fonts[f13_arg0])
	f13_local0:setText(f13_arg1)
	if f13_arg2 then
		f13_local0:setRGB(f13_arg2.r, f13_arg2.g, f13_arg2.b)
	end
	return f13_local0
end

local f0_local1 = function (f14_arg0)
	local f14_local0 = "Default"
	local f14_local1 = LUI.UIText.new()
	f14_local1:setLeftRight(true, true, 0, 0)
	f14_local1:setTopBottom(true, false, 0, CoD.textSize[f14_local0])
	f14_local1:setFont(CoD.fonts[f14_local0])
	f14_local1:setText(f14_arg0)
	return f14_local1
end

CoD.LeagueLeaderboard.LB_SetMutablesColor = function (f15_arg0, f15_arg1)
	f15_arg0.lbrank:setRGB(f15_arg1.r, f15_arg1.g, f15_arg1.b)
	f15_arg0.name:setRGB(f15_arg1.r, f15_arg1.g, f15_arg1.b)
	f15_arg0.dataCol:setRGB(f15_arg1.r, f15_arg1.g, f15_arg1.b)
end

CoD.LeagueLeaderboard.LB_ButtonData = function (f16_arg0, f16_arg1, f16_arg2)
	local f16_local0 = Engine.GetLeagueLbRow(f16_arg0, f16_arg1)
	if f16_local0 == nil then
		f16_arg2.loading:setText(Engine.Localize("MENU_LB_LOADING"))
		f16_arg2.lbrank:setText("")
		f16_arg2.name:setText("")
		f16_arg2.dataCol:setText("")
		f16_arg2.tierLine:hide()
	else
		f16_arg2.loading:setText("")
		f16_arg2.lbrank:setText(f16_local0.rank)
		f16_arg2.name:setText(f16_local0.teamName)
		f16_arg2.dataCol:setText(f16_local0.rating)
		f16_arg2.teamName = f16_local0.teamName
		f16_arg2.wins = f16_local0.ints[CoD.LeaguesData.LEAGUE_STAT_INT_WINS]
		f16_arg2.streak = f16_local0.ints[CoD.LeaguesData.LEAGUE_STAT_INT_STREAK]
		f16_arg2.teamID = f16_local0.teamID
		f16_arg2.rank = f16_local0.rank
		f16_arg2.tierLine:hide()
		if CoD.LeaguesData.CurrentTeamSubdivisionInfo.divisionID then
			local f16_local1 = Engine.GetLeagueDivisionIcon(CoD.LeaguesData.CurrentTeamSubdivisionInfo.divisionID, false, f16_local0.rank)
			if f16_local1 and tonumber(f16_local0.rank) == f16_local1.bracketRankPosition then
				f16_arg2.tierLine:show()
			end
		end
		if f16_local0.teamName == CoD.LeaguesData.CurrentTeamInfo.teamName then
			CoD.LeagueLeaderboard.LB_SetMutablesColor(f16_arg2, CoD.yellowGlow)
		else
			CoD.LeagueLeaderboard.LB_SetMutablesColor(f16_arg2, CoD.offWhite)
		end
	end
end

CoD.LeagueLeaderboard.LB_ButtonCreator = function (f17_arg0, f17_arg1)
	f17_arg1.loading = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.textSize.Default / 2,
		bottom = CoD.textSize.Default / 2,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Center
	})
	f17_arg1:addElement(f17_arg1.loading)
	f17_arg1.lbrank = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.LeagueLeaderboard.LBRANK_XLEFT + CoD.LeagueLeaderboard.PADDING,
		right = CoD.LeagueLeaderboard.LBRANK_XRIGHT - CoD.LeagueLeaderboard.PADDING,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.textSize.Default / 2,
		bottom = CoD.textSize.Default / 2,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Right
	})
	f17_arg1:addElement(f17_arg1.lbrank)
	f17_arg1.name = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.LeagueLeaderboard.NAME_XLEFT + CoD.LeagueLeaderboard.PADDING,
		right = CoD.LeagueLeaderboard.NAME_XLEFT - CoD.LeagueLeaderboard.PADDING,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.textSize.Default / 2,
		bottom = CoD.textSize.Default / 2,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Left
	})
	f17_arg1:addElement(f17_arg1.name)
	f17_arg1.dataCol = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = CoD.LeagueLeaderboard.NAME_XRIGHT + CoD.LeagueLeaderboard.PADDING,
		right = -20,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.textSize.Default / 2,
		bottom = CoD.textSize.Default / 2,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Right
	})
	f17_arg1.tierLine = CoD.GetStretchedImage()
	f17_arg1.tierLine:setTopBottom(false, true, -1, 0)
	f17_arg1.tierLine:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
	f17_arg1.tierLine:hide()
	f17_arg1:addElement(f17_arg1.tierLine)
	f17_arg1:addElement(f17_arg1.dataCol)
end

CoD.LeagueLeaderboard.GetListBoxHeaderText = function (f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4)
	local f18_local0 = LUI.UIText.new()
	local f18_local1 = false
	if f18_arg4 then
		f18_local1 = f18_arg4
	end
	f18_local0:setLeftRight(true, f18_local1, f18_arg0, f18_arg1)
	f18_local0:setTopBottom(true, true, 0, 0)
	if f18_arg3 then
		f18_local0:setAlignment(LUI.Alignment[f18_arg3])
	end
	f18_local0:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	f18_local0:setText(f18_arg2)
	f18_local0:setFont(CoD.fonts.Default)
	return f18_local0
end

CoD.LeagueLeaderboard.AddLeaderboardList = function (f19_arg0, f19_arg1, f19_arg2, f19_arg3, f19_arg4, f19_arg5)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f19_arg2, f19_arg2 + f19_arg5)
	Widget:setTopBottom(true, true, f19_arg3, f19_arg4)
	local f19_local1 = 0
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f19_local1, f19_local1 + CoD.textSize.Default)
	Widget:addElement(CoD.LeagueLeaderboard.GetListBoxHeaderText(CoD.LeagueLeaderboard.LBRANK_XLEFT, CoD.LeagueLeaderboard.LBRANK_XRIGHT, Engine.Localize("MENU_RANK"), "Left"))
	if f19_arg0.numTeamMembersToShow > 1 then
		Widget:addElement(CoD.LeagueLeaderboard.GetListBoxHeaderText(CoD.LeagueLeaderboard.NAME_XLEFT, CoD.LeagueLeaderboard.NAME_XRIGHT, Engine.Localize("MENU_TEAM_NAME"), "Left"))
	else
		Widget:addElement(CoD.LeagueLeaderboard.GetListBoxHeaderText(CoD.LeagueLeaderboard.NAME_XLEFT, CoD.LeagueLeaderboard.NAME_XRIGHT, Engine.Localize("LEAGUE_SOLO_COMPETITOR"), "Left"))
	end
	Widget:addElement(CoD.LeagueLeaderboard.GetListBoxHeaderText(CoD.LeagueLeaderboard.NAME_XRIGHT, -10, Engine.Localize("MENU_RANK_POINTS"), "Right", true))
	Widget:addElement(Widget)
	f19_arg0.listBox = CoD.ListBox.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f19_local1 + CoD.textSize.Default,
		bottom = 0
	}, f19_arg1, 8, 50, f19_arg5, CoD.LeagueLeaderboard.LB_ButtonCreator, CoD.LeagueLeaderboard.LB_ButtonData, 0, 2)
	Widget:addElement(f19_arg0.listBox)
	f19_arg0.listBox:enablePageArrows()
	f19_arg0:addElement(Widget)
end

local f0_local2 = function (f20_arg0)
	f20_arg0.teamEmblemImage:hide()
	f20_arg0.divisionIcon:hide()
	f20_arg0.rank:hide()
	f20_arg0.topTier:hide()
	f20_arg0.teamName:hide()
	f20_arg0.wins:hide()
	f20_arg0.spinner:hide()
	f20_arg0.teamEmblemImage:hide()
	f20_arg0.divisionIcon:hide()
	if f20_arg0.winstreak then
		f20_arg0.winstreak:hide()
	end
	CoD.LeagueLeaderboard.UpdateTeamMemberNames(f20_arg0)
end

CoD.LeagueLeaderboard.ButtonGainFocus = function (f21_arg0, f21_arg1)
	f0_local2(f21_arg0)
	if f21_arg0.selectButton then
		f21_arg0.selectButton:close()
	end
	f21_arg0.selectedPlayerXuid = nil
	local f21_local0 = f21_arg1.mutables
	if not f21_local0 then
		return 
	elseif f21_local0.teamID then
		local f21_local1 = f21_arg0.numTeamMembersToShow == 1
		if not f21_local1 then
			f21_arg0.teamEmblemImage:setupLeagueEmblem(f21_local0.teamID)
			f21_arg0.teamEmblemImage:show()
		end
		CoD.LeagueLeaderboard.HighlightedTeamID = f21_local0.teamID
		CoD.LeagueLeaderboard.HighlightedTeamName = f21_local0.teamName
		local f21_local2 = CoD.LeagueLeaderboard.GetTeamMemberInfoFromCache(f21_local0.teamID)
		if not f21_local2 then
			if f21_arg0.teamMemberInfoFetchTimer then
				f21_arg0.teamMemberInfoFetchTimer:close()
			end
			f21_arg0.teamMemberInfoFetchTimer = LUI.UITimer.new(CoD.LeagueLeaderboard.TeamMemberInfoFetchDelay, "fetch_league_lb_team_member_info", true)
			f21_arg0:addElement(f21_arg0.teamMemberInfoFetchTimer)
			if f21_local1 then
				f21_arg0.teamEmblemSpinner:show()
			else
				f21_arg0.spinner:show()
			end
		else
			CoD.LeagueLeaderboard.UpdateEmblemsAndNames(f21_arg0, f21_local2)
		end
	end
	if f21_local0.teamName then
		f21_arg0.teamName:setText(f21_local0.teamName)
		f21_arg0.teamName:show()
	end
	if f21_local0.rank then
		f21_arg0.rank:setText(Engine.Localize("LEAGUE_RANK", f21_local0.rank))
		f21_arg0.rank:show()
	end
	if f21_local0.wins then
		f21_arg0.wins:setText(f21_local0.wins)
		f21_arg0.wins:show()
	end
	if f21_arg0.winstreak then
		f21_arg0.winstreak:setText(0)
		f21_arg0.winstreak:show()
	end
	if f21_local0.streak and tonumber(f21_local0.streak) > 0 and f21_arg0.winstreak then
		f21_arg0.winstreak:setText(f21_local0.streak)
	end
	local f21_local1 = CoD.LeaguesData.CurrentTeamSubdivisionInfo
	if f21_local1.divisionID and f21_local0.rank then
		local f21_local2 = Engine.GetLeagueDivisionIcon(f21_local1.divisionID, false, f21_local0.rank)
		f21_arg0.divisionIcon:setImage(f21_local2.divisionIcon)
		f21_arg0.divisionIcon:show()
		if f21_local2.bracketRankPosition > 0 then
			f21_arg0.topTier:setText(Engine.Localize("MENU_LEAGUE_TOP_N", f21_local2.bracketRankPosition))
			f21_arg0.topTier:show()
		end
	end
end

CoD.LeagueLeaderboard.SetupInfoPanel = function (f22_arg0, f22_arg1, f22_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f22_arg1, 0)
	Widget:setTopBottom(true, true, f22_arg2, 0)
	f22_arg0:addElement(Widget)
	f22_arg1 = 0
	f22_arg2 = 0
	local f22_local1 = 230
	local f22_local2 = 230
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f22_arg1, f22_arg1 + f22_local1)
	Widget:setTopBottom(true, false, f22_arg2, f22_arg2 + f22_local2)
	Widget:addElement(CoD.GetInformationContainer())
	Widget:addElement(Widget)
	f22_arg0.teamEmblemSpinner = CoD.GetCenteredImage(120, 120, "lui_loader")
	Widget:addElement(f22_arg0.teamEmblemSpinner)
	f22_arg0.teamEmblemSpinner:hide()
	local f22_local4 = 200
	local f22_local5 = CoD.GetCenteredImage(f22_local4, f22_local4)
	f22_arg0.teamEmblemImage = f22_local5
	f22_local5:hide()
	Widget:addElement(f22_local5)
	f22_arg1 = f22_local1
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f22_arg1, 0)
	Widget:setTopBottom(true, false, f22_arg2, f22_arg2 + f22_local2)
	Widget:addElement(CoD.GetInformationContainer())
	Widget:addElement(Widget)
	f22_arg2 = 20
	local f22_local7 = 96
	local f22_local8 = CoD.GetCenteredImage(f22_local7, f22_local7)
	f22_local8:setTopBottom(true, false, f22_arg2, f22_arg2 + f22_local7)
	f22_arg0.divisionIcon = f22_local8
	f22_local8:hide()
	Widget:addElement(f22_local8)
	f22_arg2 = f22_arg2 + f22_local7 + 20
	local f22_local9 = LUI.UIVerticalList.new()
	f22_local9:setLeftRight(true, true, 0, 0)
	f22_local9:setTopBottom(true, true, f22_arg2, 0)
	Widget:addElement(f22_local9)
	local f22_local10 = CoD.GetTextElem("Big", "Center")
	f22_arg0.rank = f22_local10
	local f22_local11 = CoD.GetTextElem("Condensed", "Center", nil, CoD.yellowGlow)
	f22_arg0.topTier = f22_local11
	f22_local9:addElement(f22_local10)
	f22_local9:addElement(f22_local11)
	f22_arg2 = f22_local2
	local f22_local12 = "Big"
	local f22_local13 = CoD.textSize[f22_local12] + 20
	if f22_arg0.numTeamMembersToShow > 1 then
		f22_local12 = "Condensed"
		f22_local13 = CoD.textSize[f22_local12] + f22_arg0.numTeamMembersToShow * CoD.textSize.Default + 30
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f22_arg2, f22_arg2 + f22_local13)
	Widget:addElement(CoD.GetInformationContainer())
	Widget:addElement(Widget)
	local f22_local15 = 32
	local f22_local16 = LUI.UIImage.new({
		shaderVector0 = {
			0,
			0,
			0,
			0
		}
	})
	f22_local16:setLeftRight(false, false, -f22_local15 / 2, f22_local15 / 2)
	f22_local16:setTopBottom(true, false, 50, 50 + f22_local15)
	f22_local16:setImage(RegisterMaterial("lui_loader"))
	Widget:addElement(f22_local16)
	f22_local16:hide()
	f22_arg0.spinner = f22_local16
	
	local teamInfoVert = LUI.UIVerticalList.new()
	teamInfoVert:setLeftRight(true, true, 0, 0)
	teamInfoVert:setTopBottom(true, true, 0, 0)
	Widget:addElement(teamInfoVert)
	f22_arg0.teamInfoVert = teamInfoVert
	
	teamInfoVert:addSpacer(10)
	local f22_local18 = CoD.GetTextElem(f22_local12, "Center")
	f22_arg0.teamName = f22_local18
	teamInfoVert:addElement(f22_local18)
	teamInfoVert:addSpacer(5)
	local f22_local19 = {}
	local f22_local20 = CoD.LeagueLeaderboard.MaxTeamMembers
	for f22_local21 = 1, f22_local20, 1 do
		local Widget = f22_local21
		local f22_local25 = CoD.GetTextElem("Default", "Center", "", CoD.gray)
		table.insert(f22_local19, f22_local25)
		teamInfoVert:addElement(f22_local25)
	end
	f22_arg0.teamMemberNames = f22_local19
	f22_arg2 = f22_arg2 + f22_local13
	local f22_local21 = 60
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f22_arg2, f22_arg2 + f22_local21)
	Widget:addElement(Widget)
	local f22_local23 = 198
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f22_local23)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(CoD.GetInformationContainer())
	Widget:addElement(Widget)
	local f22_local25 = LUI.UIVerticalList.new()
	f22_local25:setLeftRight(true, true, 0, 0)
	f22_local25:setTopBottom(true, true, 5, 0)
	Widget:addElement(f22_local25)
	f22_local25:addElement(CoD.GetTextElem("Default", "Center", Engine.Localize("MPUI_TOTAL_WINS")))
	local f22_local26 = CoD.GetTextElem("Default", "Center", "25")
	f22_arg0.wins = f22_local26
	f22_local25:addElement(f22_local26)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f22_local23, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(CoD.GetInformationContainer())
	Widget:addElement(Widget)
	local f22_local28 = LUI.UIVerticalList.new()
	f22_local28:setLeftRight(true, true, 0, 0)
	f22_local28:setTopBottom(true, true, 5, 0)
	Widget:addElement(f22_local28)
	if not CoD.isPC then
		f22_local28:addElement(CoD.GetTextElem("Default", "Center", Engine.Localize("MENU_LB_WIN_STREAK")))
		local f22_local29 = CoD.GetTextElem("Default", "Center", "3")
		f22_arg0.winstreak = f22_local29
		f22_local28:addElement(f22_local29)
	end
end

CoD.LeagueLeaderboard.SetupElements = function (f23_arg0, f23_arg1)
	local f23_local0 = ""
	local f23_local1 = ""
	local f23_local2 = ""
	local f23_local3 = CoD.LeaguesData.CurrentTeamSubdivisionInfo
	local f23_local4 = CoD.LeaguesData.numTeamMembersToShow
	local f23_local5 = CoD.LeaguesData.CurrentLeagueID
	f23_arg0.numTeamMembersToShow = f23_local4
	if f23_local3 then
		if f23_local3.divisionName then
			f23_local1 = UIExpression.ToUpper(nil, CoD.LeaguesData.CurrentTeamSubdivisionInfo.divisionName)
		end
		if f23_local3.subdivisionName then
			f23_local0 = Engine.Localize("MENU_SUBDIVISION_X", CoD.LeaguesData.CurrentTeamSubdivisionInfo.subdivisionName)
		end
	end
	local f23_local6 = 0
	local f23_local7 = 0
	local f23_local8 = 100
	local f23_local9 = 100
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f23_local6, f23_local6 + f23_local8)
	Widget:setTopBottom(true, false, f23_local7, f23_local7 + f23_local9)
	local f23_local11 = CoD.GetStretchedImage()
	Widget:addElement(f23_local11)
	f23_local11:setImage(RegisterMaterial(f23_local3.leagueIconName .. "_64"))
	f23_arg0:addElement(Widget)
	f23_local6 = f23_local6 + f23_local8 + 10
	local f23_local12 = CoD.GetTextElem("Big", "Left", UIExpression.ToUpper(nil, Engine.Localize("MENU_MENU_X_LADDER", f23_local3.leagueDesc)))
	f23_local12:setLeftRight(true, true, f23_local6, 0)
	f23_arg0:addElement(f23_local12)
	f23_local7 = f23_local7 + CoD.textSize.Big + 5
	local f23_local13 = CoD.GetTextElem("Condensed", "Left", f23_local1, nil, f23_local7)
	f23_local13:setLeftRight(true, true, f23_local6, 0)
	f23_arg0:addElement(f23_local13)
	local f23_local14, f23_local15, f23_local16, f23_local17 = GetTextDimensions(f23_local1, CoD.fonts.Condensed, CoD.textSize.Condensed)
	f23_local6 = f23_local6 + f23_local16 - f23_local14 + 15
	local f23_local18 = CoD.GetTextElem("Condensed", "Left", f23_local0, CoD.gray, f23_local7)
	f23_local18:setLeftRight(true, true, f23_local6, 0)
	f23_arg0:addElement(f23_local18)
	if CoD.LeaguesData.seasonName then
		f23_local2 = CoD.LeaguesData.seasonName
		CoD.LeaguesData.seasonName = nil
	elseif f23_local5 then
		f23_local2 = Engine.GetLeagueSeasonName(f23_local5)
	end
	local f23_local19 = CoD.GetTextElem("Condensed", "Right", f23_local2, CoD.gray, f23_local7)
	f23_local19:setLeftRight(true, true, f23_local6, 0)
	f23_arg0:addElement(f23_local19)
	f23_local7 = f23_local7 + CoD.textSize.Condensed + 25
	local f23_local20 = 10
	local f23_local21 = -30
	local f23_local22 = 400
	CoD.LeagueLeaderboard.AddLeaderboardList(f23_arg0, f23_arg1, f23_local20, f23_local7, f23_local21, f23_local22)
	CoD.LeagueLeaderboard.SetupInfoPanel(f23_arg0, f23_local22 + 70, f23_local7)
	local f23_local23 = CoD.ButtonPrompt.new
	local f23_local24 = "alt1"
	local f23_local25 = Engine.Localize("MENU_LB_TOP_OF_LIST")
	local f23_local26 = f23_arg0
	local f23_local27 = "lb_jumpToTop"
	local f23_local28, f23_local29 = false
	local f23_local30, f23_local31 = false
	f23_arg0:addLeftButtonPrompt(f23_local23(f23_local24, f23_local25, f23_local26, f23_local27, f23_local28, f23_local29, f23_local30, f23_local31, "T"))
end

