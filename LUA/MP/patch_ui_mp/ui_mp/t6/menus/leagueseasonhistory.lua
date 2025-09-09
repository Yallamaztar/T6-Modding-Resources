CoD.LeagueSeasonHistory = {}
CoD.LeagueSeasonHistory.LbData = {}
CoD.LeagueSeasonHistory.HighlightedSeasonSubdivisionID = nil
CoD.LeagueSeasonHistory.ToggleDataSpinners = function (f1_arg0, f1_arg1)
	if f1_arg1 then
		f1_arg0.winsValueContainer.spinner:hide()
		f1_arg0.rankTextContainer.spinner:hide()
		f1_arg0.winstreakValueContainer.spinner:hide()
	else
		f1_arg0.winsValueContainer.spinner:show()
		f1_arg0.rankTextContainer.spinner:show()
		f1_arg0.winstreakValueContainer.spinner:show()
	end
end

CoD.LeagueSeasonHistory.PopulateTeamRankData = function (f2_arg0, f2_arg1)
	CoD.LeagueSeasonHistory.ToggleDataSpinners(f2_arg0, true)
	f2_arg0.winsValueContainer.winsValue:setText(f2_arg1.ints[CoD.LeaguesData.LEAGUE_STAT_INT_WINS])
	f2_arg0.rankTextContainer.rankText:setText(Engine.Localize("LEAGUE_RANK", f2_arg1.rank))
	f2_arg0.winstreakValueContainer.winstreakValue:setText(f2_arg1.ints[CoD.LeaguesData.LEAGUE_STAT_INT_STREAK])
end

CoD.LeagueSeasonHistory.LbDataFetched = function (f3_arg0, f3_arg1)
	local f3_local0 = Engine.GetLeagueLbData(f3_arg1.controller)
	if f3_arg1.success and f3_local0 ~= nil and f3_local0[1] then
		CoD.LeagueSeasonHistory.LbData[f3_local0.subdivisionID] = f3_local0[1]
		CoD.LeagueSeasonHistory.PopulateTeamRankData(f3_arg0, f3_local0[1])
	end
end

CoD.LeagueSeasonHistory.ListBoxButtonGainFocus = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg1.mutables.info
	f4_arg0.divisionImage:setImage(f4_local0.divisionIcon)
	f4_arg0.divisionName:setText(f4_local0.divisionName)
	f4_arg0.subdivisionName:setText(Engine.Localize("MENU_SUBDIVISION_X", f4_local0.subdivisionName))
	f4_arg0.highlightedSeasonName:setText(f4_local0.seasonName)
	f4_arg0.leagueImage:setImage(RegisterMaterial(f4_local0.leagueIconName .. "_64"))
	f4_arg0.leagueName:setText(f4_local0.leagueName)
	f4_arg0.leagueDate:setText(f4_local0.seasonEndDate)
	CoD.LeagueSeasonHistory.HighlightedSeasonSubdivisionID = f4_local0.subdivisionID
	if not CoD.LeagueSeasonHistory.LbData[f4_local0.subdivisionID] then
		CoD.LeagueSeasonHistory.ToggleDataSpinners(f4_arg0, false)
		Engine.Exec(f4_arg1.controller, "leagueFetchLbData " .. f4_local0.subdivisionID .. " " .. 1 .. " " .. CoD.LeaguesData.CurrentTeamInfo.teamID)
	else
		CoD.LeagueSeasonHistory.PopulateTeamRankData(f4_arg0, CoD.LeagueSeasonHistory.LbData[f4_local0.subdivisionID])
	end
end

CoD.LeagueSeasonHistory.ListBoxButtonData = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = CoD.LeagueSeasonHistory.historyInfo
	f5_arg2.info = f5_local0[f5_arg1]
	f5_arg2.itemName:setText(f5_local0[f5_arg1].seasonName)
	f5_arg2.itemImage:setImage(f5_local0[f5_arg1].divisionIcon)
end

CoD.LeagueSeasonHistory.ListBoxButtonCreator = function (f6_arg0, f6_arg1)
	local f6_local0 = "Default"
	local f6_local1 = CoD.fonts[f6_local0]
	local f6_local2 = CoD.textSize[f6_local0]
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 8, -8)
	Widget:setTopBottom(false, false, -f6_local2 / 2, f6_local2 / 2)
	local f6_local4 = CoD.CRCommon.GetTextElem("Default", "Left")
	Widget:addElement(f6_local4)
	local f6_local5 = 32
	local f6_local6 = CoD.GetCenteredImage(f6_local5, f6_local5)
	f6_local6:setLeftRight(false, true, -5 - f6_local5, -5)
	f6_arg1.itemName = f6_local4
	f6_arg1.itemImage = f6_local6
	f6_arg1:addElement(Widget)
	f6_arg1:addElement(f6_local6)
end

CoD.LeagueSeasonHistory.GetListBox = function (f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = CoD.ListBox.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}, f7_arg0, 5, 40, f7_arg1, CoD.LeagueSeasonHistory.ListBoxButtonCreator, f7_arg2, 0)
	f7_local0:addScrollBar()
	f7_local0.m_pageArrowsOn = true
	return f7_local0
end

CoD.LeagueSeasonHistory.SetupInfoContainer = function (f8_arg0, f8_arg1)
	local f8_local0 = 80
	local f8_local1 = 200
	local f8_local2 = LUI.UIHorizontalList.new()
	f8_local2:setLeftRight(true, true, 0, 0)
	f8_local2:setTopBottom(true, false, f8_local0, f8_local0 + f8_local1)
	local f8_local3 = 600
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f8_local3)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(CoD.GetInformationContainer())
	local f8_local5 = 20
	local f8_local6 = 128
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f8_local5, f8_local5 + f8_local6)
	Widget:setTopBottom(false, false, -f8_local6 / 2, f8_local6 / 2)
	f8_arg0.divisionImage = CoD.GetStretchedImage()
	Widget:addElement(f8_arg0.divisionImage)
	Widget:addElement(Widget)
	local f8_local8 = LUI.UIVerticalList.new()
	f8_local8:setLeftRight(true, true, f8_local5 + f8_local6 + 30, 0)
	f8_local8:setTopBottom(true, true, 50, 0)
	Widget:addElement(f8_local8)
	local f8_local9 = CoD.GetTextElem("Default", "Left", "")
	f8_arg0.divisionName = f8_local9
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, CoD.textSize.Big)
	f8_arg0.rankTextContainer = Widget
	
	local rankText = CoD.GetTextElem("Big", "Left", "")
	Widget:addElement(rankText)
	Widget.rankText = rankText
	
	Widget.spinner = CoD.Barracks.GetSpinner(0, nil, 32)
	Widget:addElement(Widget.spinner)
	f8_arg0.rankTextContainer.spinner:hide()
	local f8_local12 = CoD.GetTextElem("ExtraSmall", "Left", "")
	f8_arg0.subdivisionName = f8_local12
	f8_local8:addElement(f8_local9)
	f8_local8:addElement(Widget)
	f8_local8:addElement(f8_local12)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, 260)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(CoD.GetInformationContainer())
	Widget:addElement(CoD.GetTextElem("Default", "Center", "Wins", CoD.gray, 50))
	
	local winsValueContainer = LUI.UIElement.new()
	winsValueContainer:setLeftRight(true, true, 0, 0)
	winsValueContainer:setTopBottom(true, false, 90, 90 + CoD.textSize.Big)
	winsValueContainer.spinner = CoD.Barracks.GetSpinner(nil, nil, 32)
	winsValueContainer:addElement(winsValueContainer.spinner)
	f8_arg0.winsValueContainer = winsValueContainer
	
	f8_arg0.winsValueContainer.spinner:hide()
	
	local winsValue = CoD.GetTextElem("Big", "Center", "")
	winsValueContainer:addElement(winsValue)
	winsValueContainer.winsValue = winsValue
	
	Widget:addElement(winsValueContainer)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, 180)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(CoD.GetInformationContainer())
	Widget:addElement(CoD.GetTextElem("Default", "Center", "Best Win Streak", CoD.gray, 50))
	
	local winstreakValueContainer = LUI.UIElement.new()
	winstreakValueContainer:setLeftRight(true, true, 0, 0)
	winstreakValueContainer:setTopBottom(true, false, 90, 90 + CoD.textSize.Big)
	winstreakValueContainer.spinner = CoD.Barracks.GetSpinner(nil, nil, 32)
	winstreakValueContainer:addElement(winstreakValueContainer.spinner)
	f8_arg0.winstreakValueContainer = winstreakValueContainer
	
	f8_arg0.winstreakValueContainer.spinner:hide()
	local f8_local18 = CoD.GetTextElem("Big", "Center", "")
	winstreakValueContainer:addElement(f8_local18)
	Widget:addElement(winstreakValueContainer)
	winstreakValueContainer.winstreakValue = f8_local18
	f8_local2:addElement(Widget)
	f8_local2:addElement(Widget)
	f8_arg0:addElement(f8_local2)
end

CoD.LeagueSeasonHistory.SetupLisBox = function (f9_arg0, f9_arg1, f9_arg2)
	local Widget = LUI.UIElement.new()
	local f9_local1 = 300
	Widget:setLeftRight(true, false, 0, f9_local1)
	Widget:setTopBottom(true, true, f9_arg2, -50)
	f9_arg0.listBox = CoD.LeagueSeasonHistory.GetListBox(f9_arg1, f9_local1, CoD.LeagueSeasonHistory.ListBoxButtonData)
	Widget:addElement(f9_arg0.listBox)
	f9_arg0:addElement(Widget)
	f9_arg0.listBox:setTotalItems(CoD.LeagueSeasonHistory.historyInfo.numItems)
end

CoD.LeagueSeasonHistory.SetupElements = function (f10_arg0, f10_arg1)
	local f10_local0 = 80
	local f10_local1 = 200
	CoD.LeagueSeasonHistory.SetupInfoContainer(f10_arg0, f10_arg1)
	local f10_local2 = f10_local0 + f10_local1 + 20
	local f10_local3 = CoD.GetTextElem("Big", "Left", "", nil, f10_local2)
	f10_arg0.highlightedSeasonName = f10_local3
	f10_arg0:addElement(f10_local3)
	f10_local2 = f10_local2 + 60
	f10_arg0:addElement(CoD.GetTextElem("ExtraSmall", "Left", Engine.Localize("LEAGUE_SEASON_RESULTS"), CoD.gray, f10_local2))
	f10_local2 = f10_local2 + 20
	local f10_local4 = 300
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f10_local4 + 40, 0)
	Widget:setTopBottom(true, true, f10_local2, -50)
	Widget:addElement(CoD.GetInformationContainer())
	local f10_local6 = 10
	local Widget = LUI.UIElement.new()
	local f10_local8 = 128
	Widget:setLeftRight(true, false, f10_local6, f10_local6 + f10_local8)
	Widget:setTopBottom(false, false, -f10_local8 / 2, f10_local8 / 2)
	f10_arg0.leagueImage = CoD.GetStretchedImage()
	Widget:addElement(f10_arg0.leagueImage)
	Widget:addElement(Widget)
	f10_local6 = f10_local6 + f10_local8 + 10
	local f10_local9 = nil
	local f10_local10 = Dvar.loc_language:get()
	if f10_local10 == CoD.LANGUAGE_FULLJAPANESE or f10_local10 == CoD.LANGUAGE_JAPANESE then
		f10_local9 = CoD.GetTextElem("Condensed", "Left", "", nil, 60)
	else
		f10_local9 = CoD.GetTextElem("Big", "Left", "", nil, 60)
	end
	f10_arg0.leagueName = f10_local9
	f10_local9:setLeftRight(true, true, f10_local6, 0)
	Widget:addElement(f10_local9)
	local f10_local11 = CoD.GetTextElem("Default", "Left", "", nil, 120)
	f10_arg0.leagueDateHeader = f10_local11
	f10_local11:setLeftRight(true, true, f10_local6, 0)
	f10_local11:setText(Engine.Localize("LEAGUE_SEASON_FINAL_DATE", " "))
	Widget:addElement(f10_local11)
	local f10_local12 = CoD.GetTextElem("Default", "Left", "", nil, 120 + CoD.textSize.Default)
	f10_arg0.leagueDate = f10_local12
	f10_local12:setLeftRight(true, true, f10_local6, 0)
	Widget:addElement(f10_local12)
	CoD.LeagueSeasonHistory.SetupLisBox(f10_arg0, f10_arg1, f10_local2)
	f10_arg0:addElement(Widget)
end

CoD.LeagueSeasonHistory.OpenLeagueLeaderboard = function (f11_arg0, f11_arg1)
	local f11_local0 = f11_arg1.mutables.info
	if CoD.LeaguesData.CurrentTeamInfo.teamMemberInfo then
		local f11_local1 = CoD.LeaguesData.CurrentTeamSubdivisionInfo
		f11_local1.subdivisionID = f11_local0.subdivisionID
		f11_local1.teamID = CoD.LeaguesData.CurrentTeamInfo.teamID
		f11_local1.leagueIconName = f11_local0.leagueIconName
		f11_local1.leagueDesc = f11_local0.leagueName
		f11_local1.divisionName = f11_local0.divisionName
		f11_local1.divisionIcon = f11_local0.divisionIcon
		f11_local1.subdivisionName = f11_local0.subdivisionName
		f11_local1.bracketRankPosition = 0
		f11_local1.divisionID = f11_local0.divisionID
		CoD.LeaguesData.CurrentTeamInfo.teamName = CoD.LeaguesData.CurrentTeamInfo.teamName
		CoD.LeaguesData.CurrentLeagueID = f11_local0.leagueID
		CoD.LeaguesData.numTeamMembersToShow = CoD.LeaguesData.CurrentTeamInfo.teamMemberInfo.numMembers
		CoD.LeaguesData.seasonName = f11_local0.seasonName
		CoD.LeagueLeaderboard.previousMenuName = "LeagueSeasonHistory"
		f11_arg0:openMenu("LeagueLeaderboard", f11_arg1.controller)
		f11_arg0:close()
	end
end

LUI.createMenu.LeagueSeasonHistory = function (f12_arg0)
	local f12_local0 = CoD.Menu.New("LeagueSeasonHistory")
	f12_local0:addLargePopupBackground()
	f12_local0:setOwner(f12_arg0)
	f12_local0:setPreviousMenu("LeagueTeams")
	f12_local0:addSelectButton(Engine.Localize("LEAGUE_VIEW_LADDER"))
	f12_local0:addBackButton()
	f12_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("LEAGUE_SEASON_FINALS_CAPS")))
	f12_local0:registerEventHandler("listbox_button_gain_focus", CoD.LeagueSeasonHistory.ListBoxButtonGainFocus)
	f12_local0:registerEventHandler("league_lb_data_fetched", CoD.LeagueSeasonHistory.LbDataFetched)
	f12_local0:registerEventHandler("click", CoD.LeagueSeasonHistory.OpenLeagueLeaderboard)
	CoD.LeagueSeasonHistory.historyInfo = Engine.GetLeagueSeasonHistory(f12_arg0, CoD.LeaguesData.CurrentTeamInfo.teamID)
	CoD.LeagueSeasonHistory.SetupElements(f12_local0, f12_arg0)
	return f12_local0
end

