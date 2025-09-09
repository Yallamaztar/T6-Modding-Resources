require("T6.Lobby")
require("T6.MFTabManager")
require("T6.TabManagerLite")
require("T6.Line")
require("T6.Menus.AARUnlockPopup")
require("T6.Menus.RateMatchPopup")
require("T6.LeaderboardPreviewList")
require("T6.ScrollableContentGrid")
require("T6.HUD.ScoreBoard")
CoD.AfterActionReport = {}
CoD.AfterActionReport.Stats = {}
CoD.AfterActionReport.NumScoreboardDataColumns = 5
CoD.AfterActionReport.General = {}
CoD.AfterActionReport.Leagues = {}
CoD.AfterActionReport.General.TabEvents = {}
CoD.AfterActionReport.Leagues.TabEvents = {}
CoD.AfterActionReport.Leagues.LadderResultsTab = 1
CoD.AfterActionReport.Leagues.ScoreboardTab = 2
CoD.AfterActionReport.General.MedalsTab = 1
CoD.AfterActionReport.General.StatsTab = 2
CoD.AfterActionReport.General.ScoreboardTab = 3
CoD.AfterActionReport.Leagues.TabEvents = {
	"setup_leagues_tab",
	"setup_scoreboard_tab"
}
CoD.AfterActionReport.General.TabEvents = {
	"setup_medals_tab",
	"setup_stats_tab",
	"setup_scoreboard_tab"
}
CoD.AfterActionReport.RankIdCol = 0
CoD.AfterActionReport.RankTableColMinXP = 2
CoD.AfterActionReport.RankTableColXPToNext = 3
CoD.AfterActionReport.RankDisplayStringCol = 5
CoD.AfterActionReport.RankTableColMaxXP = 7
CoD.AfterActionReport.RankDisplayLevelCol = 14
CoD.AfterActionReport.medalStringCol = 2
CoD.AfterActionReport.medalImageMaterialNameCol = 3
CoD.AfterActionReport.medalSortkeyCol = 10
CoD.AfterActionReport.TokenImageMaterialName64 = "menu_mp_lobby_token_64"
CoD.AfterActionReport.TokenImageMaterialName128 = "menu_mp_lobby_token_128"
CoD.AfterActionReport.XPBarWidgetContainerWidth = CoD.Menu.Width - 30
CoD.AfterActionReport.XPBarWidgetContainerBottomOffset = 40
CoD.AfterActionReport.XPBarWidgetContainerBottomOffsetLeagues = 50
CoD.AfterActionReport.XPBarAnimateDuration = 800
CoD.AfterActionReport.ScoreBoardWidgetContainerWidth = CoD.Menu.Width - 30
CoD.AfterActionReport.ScoreBoardWidgetContainerBottomOffset = 80
CoD.AfterActionReport.ScoreBoardWidgetContainerTopOffset = 50
CoD.AfterActionReport.NewContentItemWidth = 192
CoD.AfterActionReport.NewContentItemHeight = 146
CoD.AfterActionReport.NewContentHighlightedItemWidth = 345.6
CoD.AfterActionReport.NewContentHighligtedItemHeight = 217.8
CoD.AfterActionReport.RateMatchQoSLastMatchLogged = nil
CoD.AfterActionReport.RateMatchChanceEvaluated = false
CoD.AfterActionReport.RateMatchSelectedForSurvey = false
CoD.AfterActionReport.RateMatchSurveyComplete = false
local f0_local0 = function (f1_arg0)
	local f1_local0 = CoD.AfterActionReport.Stats
	if f1_local0.currentStats ~= nil then
		local f1_local1 = f1_local0.currentStats.AfterActionReportStats.demoFileID:get()
		if f1_local1 ~= nil and f1_local1 ~= "0" then
			f1_arg0.demoFileID = f1_local1
			local f1_local2 = CoD.ButtonPrompt.new
			local f1_local3 = "alt1"
			local f1_local4 = Engine.Localize("MENU_BOOKMARK_GAME")
			local f1_local5 = f1_arg0
			local f1_local6 = "button_prompt_bookmark"
			local f1_local7, f1_local8 = false
			local f1_local9, f1_local10 = false
			f1_arg0.bookmarkButton = f1_local2(f1_local3, f1_local4, f1_local5, f1_local6, f1_local7, f1_local8, f1_local9, f1_local10, "B")
			f1_arg0:registerEventHandler("button_prompt_bookmark", CoD.AfterActionReport.Bookmark)
			f1_arg0:addRightButtonPrompt(f1_arg0.bookmarkButton)
			f1_local2 = 0
			f1_arg0.bookmarkText = LUI.UIText.new()
			f1_arg0.bookmarkText:setLeftRight(true, true, 365, 0)
			f1_arg0.bookmarkText:setTopBottom(false, true, -CoD.textSize.ExtraSmall - f1_local2, -f1_local2)
			f1_arg0.bookmarkText:setFont(CoD.fonts.ExtraSmall)
			f1_arg0.bookmarkText:setAlignment(LUI.Alignment.Left)
			f1_arg0.bookmarkText:setText(Engine.Localize("MENU_GAME_BOOKMARKED"))
			f1_arg0.bookmarkText:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
			f1_arg0.bookmarkText:setAlpha(0)
			f1_arg0:addElement(f1_arg0.bookmarkText)
		end
	end
end

local f0_local1 = function (f2_arg0)
	f2_arg0.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	f2_arg0:addElement(f2_arg0.border)
	f2_arg0.border.bottomBorder:close()
	f2_arg0.border.bottomBorder = LUI.UIImage.new()
	f2_arg0.border.bottomBorder:setLeftRight(true, true, 0, 0)
	f2_arg0.border.bottomBorder:setTopBottom(false, true, -9, -1)
	f2_arg0.border.bottomBorder:setImage(RegisterMaterial("menu_sp_cac_single_dip"))
	f2_arg0.border:addElement(f2_arg0.border.bottomBorder)
end

local f0_local2 = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4)
	local f3_local0 = LUI.UIContainer.new()
	local f3_local1 = 320
	local f3_local2 = CoD.Menu.Width
	local f3_local3 = -50
	f3_local0:setLeftRight(false, false, -f3_local2 / 2, f3_local2 / 2)
	f3_local0:setTopBottom(false, false, -f3_local1 / 2 + f3_local3, f3_local1 / 2 + f3_local3)
	f3_arg0:addElement(f3_local0)
	local f3_local4 = 200
	local f3_local5 = LUI.UIContainer.new()
	f3_local5:setLeftRight(true, false, 0, f3_local4)
	f3_local5:addElement(CoD.GetInformationContainer())
	f3_local5:addElement(CoD.GetInformationContainer())
	f3_local0:addElement(f3_local5)
	local f3_local6 = "Big"
	local f3_local7 = CoD.GetTextElem(f3_local6, "Center", f3_arg3)
	f3_local7:setTopBottom(false, false, -CoD.textSize[f3_local6] / 2, CoD.textSize[f3_local6] / 2)
	f3_local5:addElement(f3_local7)
	local f3_local8 = LUI.UIContainer.new()
	f3_local8:setLeftRight(false, true, -f3_local4, 0)
	f3_local8:addElement(CoD.GetInformationContainer())
	f3_local8:addElement(CoD.GetInformationContainer())
	f3_local0:addElement(f3_local8)
	local f3_local9 = LUI.UIContainer.new()
	f3_local9:setLeftRight(true, true, f3_local4, -f3_local4)
	f3_local9:addElement(CoD.GetInformationContainer())
	f3_local9:addElement(CoD.GetInformationContainer())
	f3_local0:addElement(f3_local9)
	local f3_local10 = "Big"
	local f3_local11 = ""
	local f3_local12 = ""
	if f3_arg1.isPreSeason then
		f3_local11 = Engine.Localize("LEAGUE_PRESEASON")
		f3_local12 = Engine.Localize("LEAGUE_PRESEASON_MATCHES_DESC")
	elseif f3_arg4 > 0 then
		f3_local11 = Engine.Localize("LEAGUE_MATCHES_REMAINING", f3_arg4)
		if f3_arg1.random == false then
			f3_local12 = Engine.Localize("LEAGUE_SOLO_EARN_RANK")
		else
			f3_local12 = Engine.Localize("LEAGUE_TEAM_EARN_RANK")
		end
	else
		f3_local11 = Engine.Localize("LEAGUE_AWAITING_PLACEMENT")
	end
	local f3_local13 = CoD.GetTextElem(f3_local10, "Center", f3_local11)
	f3_local13:setTopBottom(false, false, -CoD.textSize[f3_local10] / 2, CoD.textSize[f3_local10] / 2)
	f3_local9:addElement(f3_local13)
	local f3_local14 = "Default"
	local f3_local15 = 40
	local f3_local16 = CoD.GetTextElem(f3_local14, "Center", f3_local12)
	f3_local16:setLeftRight(true, true, 10, -10)
	f3_local16:setTopBottom(false, false, -CoD.textSize[f3_local14] / 2 + f3_local15, CoD.textSize[f3_local14] / 2 + f3_local15)
	f3_local9:addElement(f3_local16)
end

local f0_local3 = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	local f4_local0 = LUI.UIContainer.new()
	local f4_local1 = 320
	local f4_local2 = CoD.Menu.Width
	local f4_local3 = -50
	f4_local0:setLeftRight(false, false, -f4_local2 / 2, f4_local2 / 2)
	f4_local0:setTopBottom(false, false, -f4_local1 / 2 + f4_local3, f4_local1 / 2 + f4_local3)
	f4_arg0:addElement(f4_local0)
	local f4_local4 = 200
	local f4_local5 = LUI.UIContainer.new()
	f4_local5:setLeftRight(true, false, 0, f4_local4)
	f4_local5:addElement(CoD.GetInformationContainer())
	f4_local5:addElement(CoD.GetInformationContainer())
	f4_local0:addElement(f4_local5)
	local f4_local6 = LUI.UIVerticalList.new()
	f4_local6:setLeftRight(true, true, 0, 0)
	f4_local6:setTopBottom(true, true, 10, 0)
	f4_local5:addElement(f4_local6)
	local f4_local7 = f4_arg2.matchDelta
	local f4_local8 = f4_arg2.matchOutcome
	local f4_local9 = CoD.brightRed
	local f4_local10 = Engine.Localize("MENU_FILESHARE_DEFEAT")
	local f4_local11 = Engine.Localize("LEAGUE_LADDER_POINTS")
	if f4_local8 == CoD.LeaguesData.LEAGUE_OUTCOME_WINNER then
		f4_local10 = Engine.Localize("MENU_FILESHARE_VICTORY")
		f4_local9 = CoD.brightGreen
		local f4_local12 = f4_arg2.matchDelta
		if f4_arg2.bonusDelta > 0 then
			f4_local12 = f4_arg2.matchDelta - f4_arg2.bonusDelta
		end
		f4_local7 = "+" .. f4_local12
	end
	if f4_local8 == CoD.LeaguesData.LEAGUE_OUTCOME_DRAW then
		f4_local10 = Engine.Localize("MENU_FILESHARE_DRAW")
		f4_local7 = f4_arg2.matchDelta
	end
	if f4_arg2.matchDelta == 0 then
		f4_local7 = ""
		f4_local11 = ""
	end
	f4_local6:addElement(CoD.GetTextElem("Big", "Center", f4_local10, victoryTextColor))
	f4_local6:addSpacer(15)
	f4_local6:addElement(CoD.GetTextElem("Big", "Center", f4_local7, f4_local9))
	f4_local6:addElement(CoD.GetTextElem("Default", "Center", f4_local11, f4_local9))
	f4_local6:addSpacer(20)
	local f4_local13, f4_local14 = nil
	if f4_arg2.bonusDelta > 0 then
		f4_local13 = "+" .. f4_arg2.bonusDelta
		local f4_local15 = f4_arg3.bonusDays
		f4_local14 = Engine.Localize("MENU_LEAGUE_DAILY_BONUS")
		if not f4_local15 then
			f4_local15 = 1
		end
		if f4_local15 == 7 then
			f4_local14 = Engine.Localize("LEAGUE_WEEKLY_BONUS")
		end
	end
	if f4_local13 and f4_local14 then
		local f4_local15 = CoD.brightGreen
		f4_local6:addElement(CoD.GetTextElem("Big", "Center", f4_local13, f4_local15))
		f4_local6:addElement(CoD.GetTextElem("Default", "Center", f4_local14, f4_local15))
		f4_local6:addElement(CoD.GetTextElem("Default", "Center", Engine.Localize("LEAGUE_LADDER_POINTS"), f4_local15))
	end
	local f4_local15 = LUI.UIContainer.new()
	f4_local15:setLeftRight(true, true, f4_local4, -f4_local4)
	f4_local0:addElement(f4_local15)
	f4_local15:addElement(CoD.GetInformationContainer())
	local f4_local16 = 64
	f4_local15.spinner = CoD.GetCenteredImage(f4_local16, f4_local16)
	f4_local15.spinner:setImage(RegisterMaterial("lui_loader"))
	f4_local15:addElement(f4_local15.spinner)
	local f4_local17 = function (f49_arg0, f49_arg1)
		f49_arg0.spinner:close()
		f49_arg0:dispatchEventToChildren(f49_arg1)
	end

	f4_local15:registerEventHandler("leaderboardlist_update", f4_local17)
	f4_local15:registerEventHandler("league_lb_data_fetched", f4_local17)
	local f4_local18 = 5
	f4_local15:addElement(CoD.LeaderboardPreviewList.new(f4_arg1, {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}, f4_local18, f4_local1 / f4_local18))
	local f4_local19 = "Default"
	local f4_local20 = -CoD.textSize[f4_local19] - 3
	local f4_local21 = CoD.GetTextElem(f4_local19, "Left", Engine.Localize("MENU_RANK"), CoD.gray, f4_local20)
	f4_local21:setLeftRight(true, true, 10, 0)
	f4_local15:addElement(f4_local21)
	local f4_local22 = Engine.Localize("MENU_TEAM")
	if f4_arg2.random then
		f4_local22 = Engine.Localize("LEAGUE_SOLO_COMPETITOR")
	end
	local f4_local23 = CoD.GetTextElem(f4_local19, "Left", f4_local22, CoD.gray, f4_local20)
	f4_local23:setLeftRight(true, true, 75, 0)
	f4_local15:addElement(f4_local23)
	local f4_local24 = CoD.GetTextElem(f4_local19, "Right", Engine.Localize("LEAGUE_LADDER_POINTS"), CoD.gray, f4_local20)
	f4_local24:setLeftRight(true, true, 0, -10)
	f4_local15:addElement(f4_local24)
	local f4_local25 = LUI.UIContainer.new()
	f4_local25:setLeftRight(false, true, -f4_local4, 0)
	f4_local25:addElement(CoD.GetInformationContainer())
	f4_local25:addElement(CoD.GetInformationContainer())
	f4_local0:addElement(f4_local25)
	local f4_local26 = LUI.UIVerticalList.new()
	f4_local26:setLeftRight(true, true, 0, 0)
	f4_local26:setTopBottom(true, true, 10, 0)
	f4_local25:addElement(f4_local26)
	local f4_local27 = "Big"
	if f4_arg2 and f4_arg2.subdivisionName then
		f4_local26:addElement(CoD.GetTextElem(f4_local27, "Center", UIExpression.ToUpper(nil, f4_arg2.divisionName)))
		f4_local26:addSpacer(60)
	end
	local f4_local28 = 110
	local f4_local29 = CoD.GetCenteredImage(f4_local28, f4_local28)
	f4_local29:setTopBottom(true, false, 0, f4_local28)
	if f4_arg2 and f4_arg2.divisionID and f4_arg2.rank then
		local f4_local30 = Engine.GetLeagueDivisionIcon(f4_arg2.divisionID, false, f4_arg2.rank)
		if f4_local30 and f4_local30.divisionIcon then
			f4_local29:setImage(f4_local30.divisionIcon)
			f4_local26:addElement(f4_local29)
			f4_local26:addSpacer(10)
		end
	end
	f4_local26:addElement(CoD.GetTextElem("Default", "Center", Engine.Localize("MENU_SUBDIVISION"), CoD.gray))
	local f4_local31 = "Default"
	if f4_arg2 and f4_arg2.subdivisionName then
		f4_local26:addElement(CoD.GetTextElem(f4_local31, "Center", f4_arg2.subdivisionName))
	end
	if f4_arg2.streak > 0 and not CoD.isPC then
		local f4_local32 = f4_local4
		local f4_local33 = 30
		local f4_local34 = 10
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, 0, f4_local32)
		Widget:setTopBottom(false, true, f4_local34, f4_local34 + f4_local33)
		Widget:addElement(CoD.GetInformationContainer())
		f4_local0:addElement(Widget)
		local f4_local36 = "Default"
		local f4_local37 = CoD.textSize[f4_local36]
		local f4_local38 = CoD.GetTextElem(f4_local36, "Center", UIExpression.ToUpper(nil, Engine.Localize("MENU_N_WINSTREAK", f4_arg2.streak)))
		f4_local38:setTopBottom(false, false, -f4_local37 / 2, f4_local37 / 2)
		Widget:addElement(f4_local38)
	end
end

CoD.AfterActionReport.SetupSummaryPageForLeagues = function (f5_arg0, f5_arg1)
	local f5_local0 = Engine.GetLeagueStats(f5_arg0)
	local f5_local1 = Engine.GetLeague()
	if f5_local0.inPlacement then
		local f5_local2 = f5_local1.placementGames
		local f5_local3 = f5_local0.played
		local f5_local4 = Engine.Localize("MENU_FILESHARE_DEFEAT")
		if f5_local0.matchOutcome == CoD.LeaguesData.LEAGUE_OUTCOME_WINNER then
			f5_local4 = Engine.Localize("MENU_FILESHARE_VICTORY")
		end
		if f5_local0.matchOutcome == CoD.LeaguesData.LEAGUE_OUTCOME_DRAW then
			f5_local4 = Engine.Localize("MENU_FILESHARE_DRAW")
		end
		f0_local2(f5_arg1, f5_local0, f5_local1, f5_local4, f5_local2 - f5_local3)
	else
		CoD.AfterActionReport.CheckForAchievements(f5_arg0, f5_local0)
		f0_local3(f5_arg1, f5_arg0, f5_local0, f5_local1)
	end
end

CoD.AfterActionReport.Bookmark = function (f6_arg0, f6_arg1)
	if f6_arg0.demoFileID ~= nil and f6_arg0.demoFileID ~= "0" then
		Engine.BookmarkRecentGame(f6_arg1.controller, f6_arg0.demoFileID)
		f6_arg0:openPopup("popup_bookmarked", f6_arg1.controller)
	end
end

CoD.AfterActionReport.FindNextMatch = function (f7_arg0, f7_arg1)
	if Engine.PartyHostFullyAwake() then
		f7_arg0:goBack()
		f7_arg0.occludedMenu:processEvent({
			name = "go_to_finding_games",
			controller = f7_arg1.controller
		})
	end
end

local f0_local4 = function (f8_arg0)
	if CoD.isPartyHost() and Engine.PartyHostFullyAwake() and not CoD.LeagueStats.InvalidTeamForLeague(f8_arg0, Engine.GetLeague(), Engine.GetLeagueStats(f8_arg0)) then
		return true
	else
		return false
	end
end

CoD.AfterActionReport.ValidForLeagueTeam = function (f9_arg0)
	local f9_local0 = Engine.GetPlayerStats(f9_arg0)
	f9_local0 = f9_local0.AfterActionReportStats.leagueTeamID:get()
	local f9_local1 = Engine.GetLeagueStats(f9_arg0)
	if not f9_local1.valid then
		return false
	elseif f9_local1.teamID ~= f9_local0 then
		return false
	else
		return true
	end
end

CoD.AfterActionReport.LeagueChanged = function (f10_arg0, f10_arg1)
	if f0_local4(f10_arg1.controller) and f10_arg0.isPartyLobby then
		f10_arg0.continueButton:close()
		f10_arg0.invisibleBackButton:close()
		if f10_arg0.findNextMatchButton:getParent() == nil then
			f10_arg0:addLeftButtonPrompt(f10_arg0.findNextMatchButton)
			f10_arg0:addLeftButtonPrompt(f10_arg0.closeButton)
		end
	else
		f10_arg0.findNextMatchButton:close()
		f10_arg0.closeButton:close()
		if f10_arg0.continueButton:getParent() == nil then
			f10_arg0:addLeftButtonPrompt(f10_arg0.continueButton)
			f10_arg0:addLeftButtonPrompt(f10_arg0.invisibleBackButton)
		end
	end
end

CoD.AfterActionReport.GetXPEarnedDuringMatch = function (f11_arg0)
	local f11_local0 = f11_arg0.currRankXP - f11_arg0.rankXPBeforematch
	if f11_local0 < 0 then
		f11_local0 = 0
	end
	return f11_local0
end

CoD.AfterActionReport.GetStats = function (f12_arg0)
	local f12_local0 = CoD.AfterActionReport.Stats
	f12_local0.currentController = f12_arg0
	f12_local0.statsBeforeMatch = Engine.GetPlayerStats(f12_arg0, CoD.STATS_LOCATION_STABLE)
	f12_local0.currentStats = Engine.GetPlayerStats(f12_arg0)
	f12_local0.rankBeforematch = f12_local0.statsBeforeMatch.PlayerStatsList.RANK.StatValue:get()
	f12_local0.rankXPBeforematch = f12_local0.statsBeforeMatch.PlayerStatsList.RANKXP.StatValue:get()
	f12_local0.currentRank = f12_local0.currentStats.PlayerStatsList.RANK.StatValue:get()
	f12_local0.displayLevelForRankBeforeMatch = UIExpression.TableLookup(f12_arg0, CoD.rankTable, CoD.AfterActionReport.RankIdCol, f12_local0.rankBeforematch, CoD.AfterActionReport.RankDisplayLevelCol)
	f12_local0.displayLevelForCurrRank = UIExpression.TableLookup(f12_arg0, CoD.rankTable, CoD.AfterActionReport.RankIdCol, f12_local0.currentRank, CoD.AfterActionReport.RankDisplayLevelCol)
	f12_local0.currPrestige = f12_local0.currentStats.PlayerStatsList.PLEVEL.StatValue:get()
	f12_local0.currRankIconMaterialName = UIExpression.TableLookup(f12_arg0, CoD.rankIconTable, CoD.AfterActionReport.RankIdCol, f12_local0.currentRank, f12_local0.currPrestige + 1)
	f12_local0.currRankName = UIExpression.TableLookup(f12_arg0, CoD.rankTable, CoD.AfterActionReport.RankIdCol, f12_local0.currentRank, CoD.AfterActionReport.RankDisplayStringCol)
	f12_local0.currRankXP = f12_local0.currentStats.PlayerStatsList.RANKXP.StatValue:get()
	f12_local0.minXPForCurrRank = tonumber(UIExpression.TableLookup(f12_arg0, CoD.rankTable, CoD.AfterActionReport.RankIdCol, f12_local0.currentRank, CoD.AfterActionReport.RankTableColMinXP))
	f12_local0.maxXPForCurrRank = tonumber(UIExpression.TableLookup(f12_arg0, CoD.rankTable, CoD.AfterActionReport.RankIdCol, f12_local0.currentRank, CoD.AfterActionReport.RankTableColMaxXP))
	f12_local0.xpToNextRank = tonumber(UIExpression.TableLookup(f12_arg0, CoD.rankTable, CoD.AfterActionReport.RankIdCol, f12_local0.currentRank, CoD.AfterActionReport.RankTableColXPToNext))
	f12_local0.xpNeededToLevelUp = f12_local0.maxXPForCurrRank - f12_local0.currRankXP
	f12_local0.prestigeNext = CoD.PrestigeNext(f12_arg0)
	f12_local0.xpEarnedDuringMatch = CoD.AfterActionReport.GetXPEarnedDuringMatch(f12_local0)
	f12_local0.scoreboardData = Engine.GetAARScoreboard(f12_arg0)
	f12_local0.gameHistoryByMode = f12_local0.currentStats.gameHistory.publicmatch
	if f12_local0.prestigeNext then
		f12_local0.displayLevelForNextRank = CoD.PrestigeNextLevelText(f12_arg0)
		f12_local0.nextRankIconMaterialName = UIExpression.TableLookup(f12_arg0, CoD.rankIconTable, 0, 0, f12_local0.currPrestige + 2)
	else
		f12_local0.displayLevelForNextRank = UIExpression.TableLookup(f12_arg0, CoD.rankTable, CoD.AfterActionReport.RankIdCol, f12_local0.currentRank + 1, CoD.AfterActionReport.RankDisplayLevelCol)
		f12_local0.nextRankIconMaterialName = UIExpression.TableLookup(f12_arg0, CoD.rankIconTable, 0, f12_local0.currentRank + 1, f12_local0.currPrestige + 1)
	end
	f12_local0.numFeaturesUnlocked = UIExpression.GetNumFeatureUnlocks(f12_arg0)
	f12_local0.recentlyUnlockedItems = Engine.GetRecentlyUnlockedItems(f12_arg0)
	f12_local0.numItemUnlocks = #f12_local0.recentlyUnlockedItems - f12_local0.numFeaturesUnlocked
	local f12_local1 = Engine.GetPlayerStats(f12_arg0)
	f12_local0.aarStats = f12_local1.AfterActionReportStats
	f12_local0.nemesisRank = f12_local0.aarStats.nemesisRank:get()
	f12_local0.nemesisPrestige = f12_local0.aarStats.nemesisRankIcon:get()
	f12_local0.nemesisName = f12_local0.aarStats.nemesisName:get()
	f12_local0.nemesisXuid = f12_local0.aarStats.nemesisXuid:get()
	f12_local0.nemesisDisplayLevel = UIExpression.TableLookup(f12_arg0, CoD.rankTable, CoD.AfterActionReport.RankIdCol, f12_local0.nemesisRank, CoD.AfterActionReport.RankDisplayLevelCol)
	f12_local0.nemesisRankIcon = UIExpression.TableLookup(f12_arg0, CoD.rankIconTable, CoD.AfterActionReport.RankIdCol, f12_local0.nemesisRank, f12_local0.nemesisPrestige + 1)
	f12_local0.unlockedAttachmentInfo = {}
	f12_local1 = UIExpression.GetNumBulletWeapons()
	if f12_local1 ~= nil then
		for f12_local2 = 0, f12_local1 - 1, 1 do
			if UIExpression.HasRecentItemAttachmentsUnlocked(f12_arg0, f12_local2) ~= 0 then
				local f12_local5 = {}
				local f12_local6 = UIExpression.GetNumItemAttachmentsWithAttachPoint(f12_arg0, f12_local2, 0)
				for f12_local7 = 1, f12_local6 - 1, 1 do
					if UIExpression.IsItemAttachmentRecentlyUnlocked(f12_arg0, f12_local2, f12_local7) ~= 0 then
						table.insert(f12_local5, {
							attachmentNum = f12_local7,
							attachmentIndex = UIExpression.GetItemAttachment(f12_arg0, f12_local2, f12_local7)
						})
					end
				end
				table.insert(f12_local0.unlockedAttachmentInfo, {
					itemIndex = f12_local2,
					unlockedAttachments = f12_local5
				})
			end
		end
	end
	f12_local0.anyAttachmentsUnlocked = #f12_local0.unlockedAttachmentInfo > 0
	f12_local0.recentChallenges = Engine.GetRecentChallenges(f12_arg0, true)
end

CoD.AfterActionReport.OpenAfterActionReport = function (f13_arg0, f13_arg1, f13_arg2)
	CoD.AfterActionReport.GetStats(f13_arg1)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
		local f13_local0 = f13_arg0:openPopup("AfterActionReport", f13_arg1, {
			animateXPbar = animateXPbar,
			isPartyLobby = f13_arg2
		})
		if CoD.AARPopup.OpenLeaguePromotionPopup(f13_arg1) then
			f13_local0:openPopup("AARLeaguePromotion", f13_arg1)
		end
	else
		local f13_local0 = CoD.AARPopup.GetNextPopupToOpen("AfterActionReport")
		local f13_local1 = f13_arg0:openPopup("AfterActionReport", f13_arg1, {
			animateXPbar = f13_local0 == nil,
			isPartyLobby = f13_arg2
		})
		if f13_local0 then
			f13_local1:openPopup(f13_local0, f13_arg1)
		end
	end
	Engine.PlaySound("cac_loadout_edit_sel")
end

CoD.AfterActionReport.AddButtonPrompts = function (f14_arg0, f14_arg1, f14_arg2)
	f14_arg0.continueButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_CONTINUE"), f14_arg0, f14_arg1)
	f14_arg0.invisibleBackButton = CoD.ButtonPrompt.new("secondary", "", f14_arg0, "show_rate_match", true)
	f14_arg0.findNextMatchButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_FIND_NEXT_MATCH_PROMPT"), f14_arg0, "button_prompt_find_next_match")
	f14_arg0.closeButton = CoD.ButtonPrompt.new("secondary", Engine.Localize("MENU_CLOSE"), f14_arg0, "show_rate_match")
	f14_arg0:registerEventHandler("button_prompt_find_next_match", CoD.AfterActionReport.FindNextMatch)
	f14_arg0:addLeftButtonPrompt(f14_arg0.continueButton)
	f14_arg0:addLeftButtonPrompt(f14_arg0.invisibleBackButton)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == true then
		f14_arg0:registerEventHandler("league_changed", CoD.AfterActionReport.LeagueChanged)
		f14_arg0:registerEventHandler("partylobby_update", CoD.AfterActionReport.LeagueChanged)
		f14_arg0:processEvent({
			name = "league_changed",
			controller = f14_arg2
		})
	end
end

CoD.AfterActionReport.GetXPBarWidget = function (f15_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.AfterActionReport.XPBarWidgetContainerWidth / 2, CoD.AfterActionReport.XPBarWidgetContainerWidth / 2)
	local f15_local1 = CoD.AfterActionReport.XPBarWidgetContainerBottomOffset
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
		f15_local1 = CoD.AfterActionReport.XPBarWidgetContainerBottomOffsetLeagues
	end
	Widget:setTopBottom(false, true, 0, -f15_local1)
	CoD.AfterActionReport.SetupXPbar(f15_arg0, Widget, CoD.AfterActionReport.XPBarWidgetContainerWidth)
	return Widget
end

CoD.AfterActionReport.AnimateXPBarWidget = function (f16_arg0, f16_arg1)
	local f16_local0 = f16_arg0.xpBarWidget
	if not f16_local0 or not f16_local0.xpEarnedDuringMatch then
		return 
	end
	local f16_local1 = f16_arg1.duration
	local f16_local2 = CoD.AfterActionReport.XPBarAnimateDuration
	if f16_local1 then
		f16_local2 = f16_local1
	end
	local f16_local3 = f16_local0.xpEarnedDuringMatch
	local f16_local4 = f16_local3.xpBeforeMatchWidth
	local f16_local5 = f16_local3.xpEarnedDuringMatchWidth
	local f16_local6 = 2
	f16_local3:beginAnimation("grow", f16_local2)
	f16_local3:setLeftRight(true, false, f16_local4, f16_local4 + f16_local5 - f16_local6)
end

CoD.AfterActionReport.SetupXPbar = function (f17_arg0, f17_arg1, f17_arg2)
	if CoD.CanRankUp(f17_arg0) == true then
		local f17_local0 = CoD.AfterActionReport.Stats
		if not f17_local0 or not f17_local0.currentRank then
			f17_local0 = CoD.AfterActionReport.GetStats(f17_arg0)
		end
		local f17_local1 = f17_local0.currentRank
		local f17_local2 = f17_local0.displayLevelForCurrRank
		local f17_local3 = 0
		local f17_local4 = 5
		local f17_local5 = "Default"
		local f17_local6, f17_local7, f17_local8, f17_local9 = GetTextDimensions(f17_local2, CoD.fonts[f17_local5], CoD.textSize[f17_local5])
		local f17_local10 = f17_local8 - f17_local6
		local f17_local11 = LUI.UIText.new()
		f17_local11:setLeftRight(true, true, f17_local3, 0)
		f17_local11:setTopBottom(false, true, -f17_local4 - CoD.textSize[f17_local5], -f17_local4)
		f17_local11:setAlignment(LUI.Alignment.Left)
		f17_local11:setText(f17_local2)
		f17_local11:setFont(CoD.fonts[f17_local5])
		f17_arg1:addElement(f17_local11)
		f17_local3 = f17_local3 + f17_local10 + 5
		local f17_local12 = LUI.UIImage.new()
		local f17_local13 = 40
		local f17_local14 = 40
		f17_local4 = 0
		f17_local12:setLeftRight(true, false, f17_local3, f17_local3 + f17_local13)
		f17_local12:setTopBottom(false, true, -f17_local4 - f17_local14, -f17_local4)
		f17_local12:setImage(RegisterMaterial(f17_local0.currRankIconMaterialName))
		f17_arg1:addElement(f17_local12)
		f17_local3 = f17_local3 + f17_local13 + 5
		local f17_local15 = 0
		f17_local4 = 0
		local f17_local16 = LUI.UIImage.new()
		local f17_local17 = 40
		local f17_local18 = 40
		f17_local16:setLeftRight(false, true, -f17_local15 - f17_local17, -f17_local15)
		f17_local16:setTopBottom(false, true, -f17_local4 - f17_local18, -f17_local4)
		f17_local16:setImage(RegisterMaterial(f17_local0.nextRankIconMaterialName))
		f17_arg1:addElement(f17_local16)
		f17_local15 = f17_local15 + f17_local17
		f17_local4 = 5
		local f17_local19 = LUI.UIText.new()
		f17_local19:setLeftRight(true, true, 0, -f17_local15)
		f17_local19:setTopBottom(false, true, -f17_local4 - CoD.textSize[f17_local5], -f17_local4)
		f17_local19:setAlignment(LUI.Alignment.Right)
		f17_local19:setFont(CoD.fonts[f17_local5])
		f17_local19:setText(f17_local0.displayLevelForNextRank)
		f17_arg1:addElement(f17_local19)
		local f17_local20, f17_local21, f17_local22, Widget = GetTextDimensions(f17_local0.displayLevelForNextRank, CoD.fonts[f17_local5], CoD.textSize[f17_local5])
		f17_local9 = Widget
		f17_local8 = f17_local22
		f17_local7 = f17_local21
		f17_local15 = f17_local15 + f17_local8 - f17_local20 + 10
		f17_local21 = f17_local10 + f17_local13 + 10
		f17_local22 = f17_arg2 - f17_local21 - f17_local15
		Widget = LUI.UIElement.new()
		local f17_local24 = 25
		f17_local4 = 0
		Widget:setLeftRight(true, false, f17_local21, f17_local21 + f17_local22)
		Widget:setTopBottom(false, true, -f17_local4 - f17_local24, -f17_local4)
		Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.05))
		f17_arg1:addElement(Widget)
		local f17_local25 = Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH)
		if f17_local25 then
			if f17_local0.rankXPBeforematch < 0 or f17_local0.xpEarnedDuringMatch <= 0 then
				f17_local25 = false
			else
				f17_local25 = true
			end
		end
		if f17_local25 then
			local f17_local26 = LUI.UIText.new()
			local f17_local27 = "ExtraSmall"
			f17_local26:setLeftRight(true, true, 0, 0)
			local f17_local28 = 20
			f17_local26:setTopBottom(false, true, f17_local28 - CoD.textSize[f17_local27], f17_local28)
			f17_local26:setFont(CoD.fonts[f17_local27])
			f17_local26:setText(Engine.Localize("MENU_BONUS_XP_TEXT_DESC"))
			f17_local26:setAlignment(LUI.Alignment.Left)
			Widget:addElement(f17_local26)
		end
		local f17_local26 = 2
		local f17_local27 = LUI.UIImage.new()
		f17_local27:setLeftRight(true, true, 1, -1)
		f17_local27:setTopBottom(true, true, 1, -1)
		f17_local27:setRGB(0, 0, 0)
		f17_local27:setAlpha(0.4)
		Widget:addElement(f17_local27)
		local f17_local28 = LUI.UIImage.new()
		f17_local28:setLeftRight(true, true, 2, -2)
		f17_local28:setTopBottom(true, true, 2, -2)
		f17_local28:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
		f17_local28:setAlpha(0.1)
		Widget:addElement(f17_local28)
		if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
			if f17_local25 then
				local Widget = LUI.UIText.new()
				local f17_local30 = "ExtraSmall"
				f17_local4 = f17_local24
				Widget:setLeftRight(true, true, 0, 0)
				Widget:setTopBottom(false, true, -f17_local4 - CoD.textSize[f17_local30], -f17_local4)
				Widget:setFont(CoD.fonts[f17_local30])
				Widget:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
				Widget:setText(Engine.Localize("MENU_LEAGUE_N_XP_MATCH_BONUS", f17_local0.xpEarnedDuringMatch))
				Widget:setAlignment(LUI.Alignment.Left)
				Widget:addElement(Widget)
			end
		else
			local Widget = LUI.UIText.new()
			local f17_local30 = "Default"
			f17_local4 = 5 + f17_local24
			Widget:setLeftRight(true, true, 0, 0)
			Widget:setTopBottom(false, true, -f17_local4 - CoD.textSize[f17_local30], -f17_local4)
			Widget:setFont(CoD.fonts[f17_local30])
			Widget:setAlignment(LUI.Alignment.Left)
			Widget:setText(Engine.Localize("MENU_EARNED_XP", f17_local0.xpEarnedDuringMatch))
			Widget:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
			Widget:addElement(Widget)
			local f17_local31 = LUI.UIText.new()
			local f17_local32 = "Default"
			f17_local4 = 5 + f17_local24
			f17_local31:setLeftRight(true, true, 0, 0)
			f17_local31:setTopBottom(false, true, -f17_local4 - CoD.textSize[f17_local32], -f17_local4)
			f17_local31:setFont(CoD.fonts[f17_local32])
			f17_local31:setText(Engine.Localize("MENU_NEXT_LEVEL_XP_ARG", f17_local0.maxXPForCurrRank - f17_local0.currRankXP))
			f17_local31:setAlignment(LUI.Alignment.Right)
			Widget:addElement(f17_local31)
		end
		local Widget = LUI.UIElement.new()
		local f17_local30 = 0
		if f17_local0.minXPForCurrRank <= f17_local0.rankXPBeforematch and f17_local0.rankXPBeforematch <= f17_local0.maxXPForCurrRank then
			f17_local30 = f17_local22 * (f17_local0.rankXPBeforematch - f17_local0.minXPForCurrRank) / f17_local0.xpToNextRank
		end
		Widget:setLeftRight(true, false, f17_local26, f17_local30)
		Widget:setTopBottom(true, true, f17_local26, -f17_local26)
		Widget:addElement(Widget)
		local f17_local31 = LUI.UIImage.new()
		f17_local31:setLeftRight(true, true, 0, 0)
		f17_local31:setTopBottom(true, true, 0, 0)
		f17_local31:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		f17_local31:setAlpha(0.7)
		Widget:addElement(f17_local31)
		local f17_local32 = LUI.UIImage.new()
		f17_local32:setLeftRight(true, true, 0, 0)
		f17_local32:setTopBottom(true, true, 0, 0)
		f17_local32:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
		f17_local32:setAlpha(0.4)
		Widget:addElement(f17_local32)
		
		local xpEarnedDuringMatch = LUI.UIElement.new()
		local f17_local34 = f17_local22 * (f17_local0.currRankXP - f17_local0.minXPForCurrRank) / f17_local0.xpToNextRank - f17_local30
		xpEarnedDuringMatch.xpBeforeMatchWidth = f17_local30
		xpEarnedDuringMatch.xpEarnedDuringMatchWidth = f17_local34
		xpEarnedDuringMatch:setLeftRight(true, false, f17_local30, f17_local30)
		xpEarnedDuringMatch:setTopBottom(true, true, f17_local26, -f17_local26)
		xpEarnedDuringMatch:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		Widget:addElement(xpEarnedDuringMatch)
		f17_arg1.xpEarnedDuringMatch = xpEarnedDuringMatch
		
		local f17_local35 = LUI.UIImage.new()
		f17_local35:setLeftRight(true, true, 0, 0)
		f17_local35:setTopBottom(true, true, 0, 0)
		f17_local35:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		xpEarnedDuringMatch:addElement(f17_local35)
		local f17_local36 = LUI.UIImage.new()
		f17_local36:setLeftRight(true, true, 0, 0)
		f17_local36:setTopBottom(true, true, 0, 0)
		f17_local36:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
		f17_local36:setAlpha(0.4)
		xpEarnedDuringMatch:addElement(f17_local36)
	end
end

local f0_local5 = function (f18_arg0)
	if f18_arg0.medalsTabContainer then
		f18_arg0.medalsTabContainer:hide()
	end
	if f18_arg0.statsTabContainer then
		f18_arg0.statsTabContainer:hide()
	end
	if f18_arg0.scoreboardTabContainer then
		f18_arg0.scoreboardTabContainer:hide()
	end
	if f18_arg0.leaguesTabContainer then
		f18_arg0.leaguesTabContainer:hide()
	end
end

local f0_local6 = function (f19_arg0, f19_arg1)
	local f19_local0 = f19_arg1.controller
	local f19_local1 = CoD.AfterActionReport.Stats
	local f19_local2 = Engine.TableLookupColumnNumForValue(CoD.scoreInfoTable, 0, f19_local1.scoreboardData.gametype .. " XP")
	local f19_local3 = f19_arg1.medalsData
	if not f19_local3 then
		return 
	end
	local f19_local4 = f19_local3[f19_arg1.index].row
	local f19_local5 = f19_local3[f19_arg1.index].value
	local f19_local6 = UIExpression.TableLookupGetColumnValueForRow(f19_local0, CoD.scoreInfoTable, f19_local4, CoD.AfterActionReport.medalStringCol)
	f19_arg0.medalPreviewImage:setImage(RegisterMaterial(UIExpression.TableLookupGetColumnValueForRow(f19_local0, CoD.scoreInfoTable, f19_local4, CoD.AfterActionReport.medalImageMaterialNameCol)))
	f19_arg0.medalPreviewImage:show()
	f19_arg0.medalNameText:setText(Engine.Localize(f19_local6))
	f19_arg0.medalDescText:setText(Engine.Localize(f19_local6 .. "_DESC"))
	local f19_local7 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f19_local0, CoD.scoreInfoTable, f19_local4, f19_local2))
	if not f19_local7 or not f19_local1.scoreboardData.xpScale then
		return 
	end
	f19_local7 = f19_local7 * tonumber(f19_local1.scoreboardData.xpScale)
	if f19_local5 > 1 then
		f19_arg0.medalHitCountText:setText("x" .. f19_local5)
		f19_arg0.xpText:setText("+" .. Engine.Localize("MPUI_N_XP", f19_local7 * tonumber(f19_local5)))
	else
		f19_arg0.medalHitCountText:setText("")
		f19_arg0.xpText:setText("+" .. Engine.Localize("MPUI_N_XP", f19_local7))
	end
end

local f0_local7 = function (f20_arg0)
	local f20_local0 = LUI.UIVerticalList.new()
	f20_local0:setLeftRight(true, true, 0, 0)
	f20_local0:setTopBottom(true, true, 0, 0)
	f20_arg0:addElement(f20_local0)
	local f20_local1 = 128
	local f20_local2 = 128
	local f20_local3 = LUI.UIImage.new()
	f20_local3:setLeftRight(false, false, -f20_local1 / 2, f20_local1 / 2)
	f20_local3:setTopBottom(true, false, 0, f20_local2)
	f20_arg0.medalPreviewImage = f20_local3
	f20_local3:hide()
	f20_local0:addSpacer(20)
	f20_local0:addElement(f20_local3)
	f20_local0:addSpacer(20)
	local f20_local4 = CoD.AARPopup.GetBoxText("Condensed", "", 0)
	f20_arg0.medalHitCountText = f20_local4
	f20_local0:addElement(f20_local4)
	f20_local0:addSpacer(20)
	local f20_local5 = CoD.AARPopup.GetBoxText("Condensed", "", 0)
	f20_arg0.medalNameText = f20_local5
	f20_local0:addElement(f20_local5)
	f20_local0:addSpacer(20)
	local f20_local6 = CoD.AARPopup.GetBoxText("ExtraSmall", "", 0)
	f20_arg0.medalDescText = f20_local6
	f20_local0:addElement(f20_local6)
	f20_local0:addSpacer(40)
	local f20_local7 = CoD.AARPopup.GetBoxText("Condensed", "", 0)
	f20_local7:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f20_arg0.xpText = f20_local7
	f20_local0:addElement(f20_local7)
	f20_arg0:registerEventHandler("grid_focus_changed", f0_local6)
end

local f0_local8 = function (f21_arg0, f21_arg1)
	f21_arg0.medalHitCount:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	CoD.ContentGridButton.ButtonOver(f21_arg0, f21_arg1)
end

local f0_local9 = function (f22_arg0, f22_arg1)
	f22_arg0.medalHitCount:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	CoD.ContentGridButton.LoseFocus(f22_arg0, f22_arg1)
end

local f0_local10 = function (f23_arg0)
	local f23_local0 = 90
	local f23_local1 = f23_local0
	local f23_local2 = 5
	f23_arg0.button.itemImage = LUI.UIStreamedImage.new()
	f23_arg0.button.itemImage:setTopBottom(true, false, f23_local2, f23_local2 + f23_local0)
	f23_arg0.button.itemImage:setLeftRight(false, false, -f23_local1 / 2, f23_local1 / 2)
	f23_arg0.button.itemImage:setPriority(-70)
	f23_arg0.button:addElement(f23_arg0.button.itemImage)
end

local f0_local11 = function (f24_arg0)
	local f24_local0 = "Condensed"
	local f24_local1 = 23
	local f24_local2 = 5
	local f24_local3 = LUI.UIText.new()
	f24_local3:setLeftRight(true, true, 0, -f24_local2)
	f24_local3:setTopBottom(false, true, -f24_local1 - CoD.textSize[f24_local0], -f24_local1)
	f24_local3:setAlignment(LUI.Alignment.Right)
	f24_local3:setFont(CoD.fonts[f24_local0])
	f24_local3:setText("")
	f24_arg0.button.medalHitCount = f24_local3
	f24_arg0.button:addElement(f24_local3)
end

local f0_local12 = function (f25_arg0, f25_arg1)
	f0_local11(f25_arg1)
	f0_local10(f25_arg1)
	CoD.ContentGridButton.SetupButtonText(f25_arg1.button, "")
	CoD.ContentGridButton.SetupButtonImages(f25_arg1.button, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
	f25_arg1.button:registerEventHandler("button_over", f0_local8)
	f25_arg1.button:registerEventHandler("button_up", f0_local9)
end

local f0_local13 = function (f26_arg0, f26_arg1, f26_arg2)
	local f26_local0 = f26_arg2.medalsData
	local f26_local1 = f26_local0[f26_arg1.m_index].row
	local f26_local2 = f26_local0[f26_arg1.m_index].value
	local f26_local3 = UIExpression.TableLookupGetColumnValueForRow(f26_arg0, CoD.scoreInfoTable, f26_local1, CoD.AfterActionReport.medalStringCol)
	local f26_local4 = UIExpression.TableLookupGetColumnValueForRow(f26_arg0, CoD.scoreInfoTable, f26_local1, CoD.AfterActionReport.medalImageMaterialNameCol)
	if f26_local2 > 1 then
		f26_arg1.button.medalHitCount:setText("x" .. f26_local2)
	else
		f26_arg1.button.medalHitCount:setText("")
	end
	f26_arg1.button.itemImage:addElement(CoD.GetSpinnerWaitingOnEvent("streamed_image_ready", 64))
	f26_arg1.button.itemImage:setImage(RegisterMaterial(f26_local4))
	f26_arg1.button.itemImage:setupUIStreamedImage(0)
	f26_arg1.button.itemNameText:setText(Engine.Localize(f26_local3))
end

local f0_local14 = function (f27_arg0, f27_arg1)
	f27_arg0:dispatchEventToChildren({
		name = f27_arg1.name,
		index = f27_arg1.index,
		controller = f27_arg0.m_ownerController,
		medalsData = f27_arg0.medalsData
	})
end

CoD.AfterActionReport.SortMedals = function (f28_arg0, f28_arg1)
	if f28_arg0.row and f28_arg1.row then
		local f28_local0 = UIExpression.TableLookupGetColumnValueForRow(nil, CoD.scoreInfoTable, f28_arg0.row, CoD.AfterActionReport.medalSortkeyCol)
		local f28_local1 = UIExpression.TableLookupGetColumnValueForRow(nil, CoD.scoreInfoTable, f28_arg1.row, CoD.AfterActionReport.medalSortkeyCol)
		if f28_local0 and f28_local1 then
			local f28_local2 = tonumber(f28_local0)
			local f28_local3 = tonumber(f28_local1)
			if f28_local2 == f28_local3 then
				return f28_arg0.value < f28_arg1.value
			else
				return f28_local2 < f28_local3
			end
		end
	end
	return true
end

local f0_local15 = function (f29_arg0, f29_arg1)
	f0_local5(f29_arg0)
	local f29_local0 = f29_arg0.m_ownerController
	if f29_arg0.medalsTabContainer then
		f29_arg0.medalsTabContainer:show()
		return 
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	f29_arg0.medalsTabContainer = Widget
	f29_arg0:addElement(Widget)
	f29_arg0:registerEventHandler("grid_focus_changed", f0_local14)
	local f29_local2 = 0
	local f29_local3 = 80
	local f29_local4 = 100
	local f29_local5 = 240
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f29_local5)
	Widget:setTopBottom(true, true, f29_local3, -f29_local4)
	Widget:addElement(Widget)
	f0_local7(Widget)
	f29_local2 = f29_local2 + f29_local5 + 20
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f29_local2, 0)
	Widget:setTopBottom(true, true, f29_local3, -f29_local4)
	f29_arg0.medalGridBox = Widget
	Widget:addElement(Widget)
	local f29_local8 = 3
	local f29_local9 = 3
	local f29_local10 = 175
	local f29_local11 = 120
	local f29_local12 = 18
	local f29_local13 = CoD.ScrollableContentGrid.new(f29_arg0.m_ownerController, {
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = false,
		left = 0,
		right = 0,
		top = 0,
		bottom = f29_local11 * f29_local8 + f29_local12 * (f29_local8 - 1) + 10
	}, f29_local8, f29_local9, f0_local12, f0_local13, f29_local10, f29_local11, f29_local12)
	f29_local13.medalsData = Engine.GetRecentMedals(f29_local0, Engine.TableLookupColumnNumForValue(CoD.scoreInfoTable, 0, CoD.AfterActionReport.Stats.scoreboardData.gametype .. " XP"))
	Widget:addElement(f29_local13)
	local f29_local14 = 0
	if f29_local13.medalsData then
		f29_local14 = #f29_local13.medalsData
		table.sort(f29_local13.medalsData, CoD.AfterActionReport.SortMedals)
	end
	f29_arg0.medalsData = f29_local13.medalsData
	f29_local13:setTotalItems(f29_local14)
	f29_arg0.medalsTabContainer.xpBarWidget = CoD.AfterActionReport.GetXPBarWidget(f29_local0)
	f29_arg0.medalsTabContainer:addElement(f29_arg0.medalsTabContainer.xpBarWidget)
	f29_arg0.medalsTabContainer:registerEventHandler("animate_xp_bar", CoD.AfterActionReport.AnimateXPBarWidget)
end

local f0_local16 = function (f30_arg0, f30_arg1, f30_arg2, f30_arg3)
	local f30_local0 = "Default"
	local f30_local1 = "Condensed"
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f30_arg0)
	Widget:setTopBottom(true, false, 0, f30_arg1)
	local f30_local3 = LUI.UIText.new()
	f30_local3:setLeftRight(true, true, 0, 0)
	f30_local3:setTopBottom(true, false, 0, CoD.textSize[f30_local0])
	f30_local3:setFont(CoD.fonts[f30_local0])
	f30_local3:setText(f30_arg2)
	f30_local3:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	Widget:addElement(f30_local3)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, CoD.textSize[f30_local0] + 3, 0)
	f0_local1(Widget)
	Widget:addElement(Widget)
	local f30_local5 = LUI.UIText.new()
	f30_local5:setLeftRight(true, true, 0, 0)
	f30_local5:setTopBottom(false, false, -CoD.textSize[f30_local1] / 2, CoD.textSize[f30_local1] / 2)
	f30_local5:setFont(CoD.fonts[f30_local1])
	f30_local5:setText(f30_arg3)
	Widget:addElement(f30_local5)
	return Widget
end

local f0_local17 = function (f31_arg0, f31_arg1)
	local f31_local0 = 110
	local f31_local1 = 95
	local f31_local2 = LUI.UIVerticalList.new()
	f31_local2:setLeftRight(true, true, 0, 0)
	f31_local2:setTopBottom(true, true, 0, 0)
	f31_arg0:addElement(f31_local2)
	local f31_local3 = Engine.GetAARScoreboard(f31_arg1)
	local f31_local4 = nil
	for f31_local8, f31_local9 in ipairs(f31_local3.members) do
		if f31_local9.isSelf then
			f31_local4 = f31_local8
			break
		end
	end
	if not f31_local4 then
		return 
	end
	f31_local5 = f31_local3.members[f31_local4]
	f31_local6 = 3
	f31_local7 = LUI.UIHorizontalList.new()
	f31_local7:setLeftRight(true, true, 0, 0)
	f31_local7:setTopBottom(true, false, 0, f31_local1)
	f31_local2:addElement(f31_local7)
	f31_local8 = 25
	for f31_local9 = 1, f31_local6, 1 do
		f31_local7:addElement(f0_local16(f31_local0, f31_local1, Engine.Localize(UIExpression.GetScoreboardColumnHeader(f31_arg1, f31_local9 - 1) .. "_CAPS"), f31_local5["scoreBoardColumn" .. f31_local9]))
		f31_local7:addSpacer(f31_local8)
	end
	f31_local2:addSpacer(20)
	f31_local9 = LUI.UIHorizontalList.new()
	f31_local9:setLeftRight(true, true, 0, 0)
	f31_local9:setTopBottom(true, false, 0, f31_local1)
	f31_local2:addElement(f31_local9)
	for f31_local10 = f31_local6 + 1, CoD.AfterActionReport.NumScoreboardDataColumns, 1 do
		f31_local9:addElement(f0_local16(f31_local0, f31_local1, Engine.Localize(UIExpression.GetScoreboardColumnHeader(f31_arg1, f31_local10 - 1) .. "_CAPS"), f31_local5["scoreBoardColumn" .. f31_local10]))
		f31_local9:addSpacer(f31_local8)
	end
	f31_local9:addElement(f0_local16(f31_local0, f31_local1, Engine.Localize("MPUI_HEADSHOTS_CAPS"), CoD.AfterActionReport.Stats.aarStats.headShots:get()))
end

local f0_local18 = function (f32_arg0, f32_arg1)
	local f32_local0 = CoD.AfterActionReport.Stats
	local f32_local1 = f32_local0.nemesisRank
	local f32_local2 = f32_local0.nemesisPrestige
	local f32_local3 = f32_local0.nemesisName
	local f32_local4 = f32_local0.nemesisDisplayLevel
	local f32_local5 = f32_local0.nemesisRankIcon
	local f32_local6 = f32_local0.nemesisXuid
	local f32_local7 = 15
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f32_local7, 0)
	Widget:setTopBottom(true, true, 0, 0)
	f32_arg1:addElement(Widget)
	local f32_local9 = LUI.UIText.new()
	f32_local9:setLeftRight(true, false, 0, 1)
	f32_local9:setTopBottom(false, true, -CoD.textSize.Default, 0)
	f32_local9:setFont(CoD.fonts.Default)
	f32_local9:setText(f32_local4)
	Widget:addElement(f32_local9)
	local f32_local10, f32_local11, f32_local12, f32_local13 = GetTextDimensions(f32_local4, CoD.fonts.Default, CoD.textSize.Default)
	f32_local7 = f32_local12 + f32_local10 + 10
	local f32_local14 = 40
	local f32_local15 = 40
	local f32_local16 = LUI.UIStreamedImage.new()
	f32_local16:setLeftRight(true, false, f32_local7, f32_local7 + f32_local14)
	f32_local16:setTopBottom(false, true, -f32_local15, 0)
	if f32_local5 and f32_local5 ~= "" then
		f32_local16:setImage(RegisterMaterial(f32_local5 .. "_128"))
		Widget:addElement(f32_local16)
	end
	f32_local7 = f32_local7 + f32_local14 + 10
	local f32_local17 = 280
	local f32_local18 = 76
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f32_local7, f32_local7 + f32_local17)
	Widget:setTopBottom(false, true, -f32_local18 + 20, 20)
	local f32_local20 = LUI.UIStreamedImage.new()
	f32_local20:setLeftRight(true, true, 0, 0)
	f32_local20:setTopBottom(true, true, 0, 0)
	f32_local20:setImage(RegisterMaterial(UIExpression.EmblemPlayerBackgroundMaterial(f32_arg0, f32_local6, 0)))
	Widget:addElement(f32_local20)
	Widget:addElement(Widget)
	local f32_local21 = LUI.UIImage.new()
	local f32_local22 = 40
	f32_local21:setLeftRight(true, false, 10, 10 + f32_local22)
	f32_local21:setTopBottom(false, false, -f32_local22 / 2, f32_local22 / 2)
	f32_local21:setupPlayerEmblemByXUID(f32_local6)
	Widget:addElement(f32_local21)
	local f32_local23 = LUI.UIText.new()
	f32_local23:setLeftRight(true, true, f32_local22 + 15, 0)
	f32_local23:setTopBottom(false, false, -CoD.textSize.ExtraSmall / 2, CoD.textSize.ExtraSmall / 2)
	f32_local23:setFont(CoD.fonts.ExtraSmall)
	f32_local23:setAlignment(LUI.Alignment.Left)
	f32_local23:setText(f32_local3)
	Widget:addElement(f32_local23)
end

local f0_local19 = function (f33_arg0, f33_arg1, f33_arg2, f33_arg3)
	local f33_local0 = Engine.GetPlayerStats(f33_arg0)
	f33_local0 = f33_local0.AfterActionReportStats
	local f33_local1 = f33_local0.nemesisKills:get()
	local f33_local2 = f33_local0.nemesisKilledBy:get()
	local f33_local3 = LUI.UIHorizontalList.new()
	f33_local3:setLeftRight(true, true, 0, 0)
	f33_local3:setTopBottom(true, true, 0, 0)
	f33_arg1:addElement(f33_local3)
	f33_local3:setAlignment(LUI.Alignment.Center)
	f33_local3:addElement(f0_local16(f33_arg2, f33_arg3, UIExpression.ToUpper(nil, Engine.Localize("MENU_KILLED")), f33_local1))
	f33_local3:addSpacer(20)
	f33_local3:addElement(f0_local16(f33_arg2, f33_arg3, Engine.Localize("MPUI_KILLED_BY_PRE_CAPS"), f33_local2))
end

local f0_local20 = function (f34_arg0, f34_arg1)
	local f34_local0 = "Condensed"
	local f34_local1 = LUI.UIText.new()
	f34_local1:setLeftRight(true, true, 0, 0)
	f34_local1:setTopBottom(true, false, 0, CoD.textSize[f34_local0])
	f34_local1:setFont(CoD.fonts[f34_local0])
	f34_local1:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	f34_local1:setAlignment(LUI.Alignment.Left)
	f34_local1:setText(Engine.Localize("MPUI_NEMESIS_TITLE_CAPS"))
	f34_arg1:addElement(f34_local1)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, CoD.textSize[f34_local0], 0)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.1))
	f34_arg1:addElement(Widget)
	local f34_local3 = 60
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 8, 8 + f34_local3)
	Widget:addElement(Widget)
	f0_local18(f34_arg0, Widget)
	local f34_local5 = 90
	local f34_local6 = 76
	local f34_local7 = 10
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(false, true, -f34_local7 - f34_local6, -f34_local7)
	Widget:addElement(Widget)
	f0_local19(f34_arg0, Widget, f34_local5, f34_local6)
end

local f0_local21 = function (f35_arg0, f35_arg1)
	local f35_local0 = CoD.AfterActionReport.Stats
	local f35_local1 = f35_local0.aarStats.bestWeaponIndex:get()
	local f35_local2, f35_local3, f35_local4 = nil
	if f35_local1 > 0 then
		f35_local2 = UIExpression.ToUpper(f35_arg0, Engine.Localize(UIExpression.GetItemName(f35_arg0, f35_local1)))
		f35_local3 = UIExpression.GetItemImage(f35_arg0, f35_local1)
		f35_local4 = f35_local0.currentStats.ItemStats[f35_local1].stats.kills.statValue:get() - f35_local0.statsBeforeMatch.ItemStats[f35_local1].stats.kills.statValue:get()
		local f35_local5 = "Condensed"
		local f35_local6 = LUI.UIText.new()
		f35_local6:setLeftRight(true, true, 0, 0)
		f35_local6:setTopBottom(true, false, 0, CoD.textSize[f35_local5])
		f35_local6:setFont(CoD.fonts[f35_local5])
		f35_local6:setAlignment(LUI.Alignment.Left)
		f35_local6:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
		f35_local6:setText(UIExpression.ToUpper(nil, Engine.Localize("MENU_DEADLIEST_WEAPON")))
		f35_arg1:addElement(f35_local6)
		local f35_local7 = 10
		local f35_local8 = CoD.textSize[f35_local5]
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, f35_local8, 0)
		f35_arg1:addElement(Widget)
		Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.1))
		local f35_local10 = 256
		local f35_local11 = 128
		local f35_local12 = LUI.UIImage.new()
		f35_local12:setLeftRight(false, true, -f35_local7 - f35_local10, -f35_local7)
		f35_local12:setTopBottom(true, false, 10, 10 + f35_local11)
		if f35_local3 then
			f35_local12:setImage(RegisterMaterial(f35_local3))
			Widget:addElement(f35_local12)
		end
		local f35_local13 = 5
		local f35_local14 = LUI.UIText.new()
		f35_local14:setLeftRight(true, true, 0, -f35_local7)
		f35_local14:setTopBottom(false, true, -f35_local13 - CoD.textSize[f35_local5], -f35_local13)
		f35_local14:setFont(CoD.fonts[f35_local5])
		f35_local14:setAlignment(LUI.Alignment.Right)
		if f35_local2 then
			f35_local14:setText(f35_local2)
			Widget:addElement(f35_local14)
		end
		local f35_local15 = 10
		local f35_local16 = 100
		local f35_local17 = 80
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, f35_local15, f35_local15 + f35_local16)
		Widget:setTopBottom(false, true, -f35_local13 - f35_local17, -f35_local13)
		if f35_local4 then
			Widget:addElement(f0_local16(f35_local16, f35_local17, Engine.Localize("MPUI_KILLS_CAPS"), f35_local4))
			Widget:addElement(Widget)
		end
	else
		return 
	end
end

local f0_local22 = function (f36_arg0, f36_arg1, f36_arg2)
	local f36_local0 = nil
	if 1 <= f36_arg0 then
		f36_local0 = f36_arg2 - f36_arg2 * (f36_arg0 - 1) / math.max(f36_arg1 - 1, 1)
	else
		f36_local0 = f36_arg2 + f36_arg2 * (1 - f36_arg0)
	end
	return f36_local0
end

CoD.AfterActionReport.GetKDGraphWidget = function (f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4)
	local f37_local0 = 5
	local f37_local1 = {}
	local f37_local2 = f37_arg4
	if not f37_local2 then
		f37_local2 = CoD.AfterActionReport.Stats.gameHistoryByMode
	end
	local f37_local3 = f37_local2.matchHistory
	local f37_local4 = f37_local2.currentMatchHistoryIndex:get()
	local f37_local5 = #f37_local2.matchHistory
	for f37_local6 = 1, f37_local0, 1 do
		local f37_local9 = f37_local6
		if f37_local3[f37_local4].startingTime:get() == 0 then
			break
		end
		table.insert(f37_local1, f37_local3[f37_local4].KILLS:get() / math.max(f37_local3[f37_local4].DEATHS:get(), 1))
		f37_local4 = f37_local4 - 1
		if f37_local4 < 0 then
			f37_local4 = f37_local5 - 1
		end
	end
	local f37_local6 = 40
	local f37_local7 = 40
	local f37_local8 = 30
	local f37_local9 = 20
	local f37_local10 = 40
	local f37_local11 = f37_arg2 - f37_local6 - f37_local7
	local f37_local12 = f37_arg3 - f37_local9 - f37_local10
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f37_local6, -f37_local7)
	Widget:setTopBottom(true, false, f37_local9, f37_local9 + f37_local12)
	f37_arg1:addElement(Widget)
	local f37_local14 = LUI.UIImage.new()
	local f37_local15 = 20
	local f37_local16 = 1
	f37_local14:setLeftRight(true, true, -f37_local15, f37_local15)
	f37_local14:setTopBottom(false, false, -f37_local16 / 2, f37_local16 / 2)
	f37_local14:setAlpha(0.1)
	Widget:addElement(f37_local14)
	local f37_local17 = 20
	local f37_local18 = LUI.UIImage.new()
	f37_local18:setLeftRight(true, false, -f37_local15 - f37_local17 + 2, -f37_local15 + 2)
	f37_local18:setTopBottom(false, false, -f37_local17 / 2 - 1, f37_local17 / 2 - 1)
	f37_local18:setImage(RegisterMaterial("ui_arrow_right"))
	f37_local18:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	Widget:addElement(f37_local18)
	local f37_local19 = LUI.UIImage.new()
	f37_local19:setLeftRight(false, true, f37_local15, f37_local15 + f37_local17)
	f37_local19:setTopBottom(false, false, -f37_local17 / 2 - 1, f37_local17 / 2 - 1)
	f37_local19:setZRot(180)
	f37_local19:setImage(RegisterMaterial("ui_arrow_right"))
	f37_local19:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	Widget:addElement(f37_local19)
	local f37_local20 = LUI.UIHorizontalList.new()
	f37_local20:setLeftRight(true, true, 0, 0)
	f37_local20:setTopBottom(true, true, 0, 0)
	Widget:addElement(f37_local20)
	local f37_local21 = 0
	local f37_local22 = 0
	local f37_local23 = 0
	local f37_local24 = 8
	local f37_local25 = 8
	local f37_local26 = 1
	local f37_local27 = (f37_local11 - f37_local0 * f37_local26) / (f37_local0 - 1)
	local f37_local28 = f37_local12 / 2
	local f37_local29 = {}
	for f37_local33, f37_local34 in ipairs(f37_local1) do
		f37_local29[f37_local33] = f37_local34
	end
	table.sort(f37_local29)
	f37_local30 = f37_local29[#f37_local29]
	for f37_local31 = 1, f37_local0, 1 do
		local f37_local35 = LUI.UIImage.new()
		f37_local35:setLeftRight(true, false, 0, f37_local26)
		f37_local35:setTopBottom(true, true, 0, 0)
		f37_local35:setAlpha(0.1)
		f37_local20:addElement(f37_local35)
		if f37_local1[f37_local31] then
			local f37_local36 = "Default"
			local f37_local37 = string.format("%.2f", f37_local1[f37_local31])
			local f37_local38 = LUI.UIText.new()
			local f37_local39, f37_local40, f37_local41, f37_local42 = GetTextDimensions(f37_local37, CoD.fonts[f37_local36], CoD.textSize[f37_local36])
			local f37_local43 = f37_local41 - f37_local39
			f37_local21 = (f37_local31 - 1) * f37_local11 / (f37_local0 - 1) - f37_local43 / 2
			f37_local38:setLeftRight(true, false, f37_local21, f37_local21 + f37_local43 / 2)
			f37_local38:setTopBottom(false, true, 10, 10 + CoD.textSize[f37_local36])
			f37_local38:setText(f37_local37)
			f37_local38:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
			Widget:addElement(f37_local38)
			f37_local22 = (f37_local31 - 1) * f37_local11 / (f37_local0 - 1) - f37_local24 / 2
			local f37_local44 = LUI.UIImage.new()
			f37_local23 = f0_local22(f37_local1[f37_local31], f37_local30, f37_local28) - f37_local25 / 2
			if f37_local1[f37_local31 + 1] then
				local f37_local45 = nil
				Widget:addElement(CoD.Line.new({
					f37_local22 + f37_local24 / 2,
					f37_local23 + f37_local24 / 2
				}, {
					f37_local31 * f37_local11 / (f37_local0 - 1),
					f0_local22(f37_local1[f37_local31 + 1], f37_local30, f37_local28) - f37_local25 / 2 + f37_local24 / 2
				}, 1, {
					1,
					1,
					1,
					0.1
				}))
			end
			f37_local44:setLeftRight(true, false, f37_local22, f37_local22 + f37_local24)
			f37_local44:setTopBottom(true, false, f37_local23, f37_local23 + f37_local25)
			f37_local44:setRGB(CoD.brightGreen.r, CoD.brightGreen.g, CoD.brightGreen.b)
			if f37_local1[f37_local31] < 1 then
				f37_local44:setRGB(CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b)
			end
			Widget:addElement(f37_local44)
		end
		f37_local20:addSpacer(f37_local27)
	end
end

local f0_local23 = function (f38_arg0, f38_arg1, f38_arg2, f38_arg3)
	local f38_local0 = "Condensed"
	local f38_local1 = LUI.UIText.new()
	f38_local1:setLeftRight(true, true, 0, 0)
	f38_local1:setTopBottom(true, false, 0, CoD.textSize[f38_local0])
	f38_local1:setFont(CoD.fonts[f38_local0])
	f38_local1:setAlignment(LUI.Alignment.Left)
	f38_local1:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	f38_local1:setText(Engine.Localize("MENU_KD_LAST_5_CAPS"))
	f38_arg1:addElement(f38_local1)
	local f38_local2 = CoD.textSize[f38_local0]
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f38_local2, 0)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.1))
	f38_arg1:addElement(Widget)
	CoD.AfterActionReport.GetKDGraphWidget(f38_arg0, Widget, f38_arg2, f38_arg3 - f38_local2)
end

local f0_local24 = function (f39_arg0, f39_arg1)
	f0_local5(f39_arg0)
	if f39_arg0.statsTabContainer then
		f39_arg0.statsTabContainer:show()
		return 
	else
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		f39_arg0.statsTabContainer = Widget
		f39_arg0:addElement(Widget)
		local f39_local1 = 65
		local f39_local2 = 20
		local f39_local3 = 200
		local f39_local4 = 500
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, f39_local2, f39_local2 + f39_local4)
		Widget:setTopBottom(true, false, f39_local1, f39_local1 + f39_local3)
		Widget:addElement(Widget)
		f0_local17(Widget, controller)
		local f39_local6 = 210
		local f39_local7 = 390
		local f39_local8 = 20
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(false, true, -f39_local8 - f39_local7, -f39_local8)
		Widget:setTopBottom(true, false, f39_local1, f39_local1 + f39_local6)
		Widget:addElement(Widget)
		f0_local20(f39_arg0.m_ownerController, Widget)
		local f39_local10 = 110
		local f39_local11 = 250
		local f39_local12 = 380
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, f39_local2, f39_local2 + f39_local12)
		Widget:setTopBottom(false, true, -f39_local10 - f39_local11, -f39_local10)
		Widget:addElement(Widget)
		f0_local23(f39_arg0.m_ownerController, Widget, f39_local12, f39_local11)
		local f39_local14 = 110
		local f39_local15 = 250
		local f39_local16 = 390
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(false, true, -f39_local8 - f39_local16, -f39_local8)
		Widget:setTopBottom(false, true, -f39_local14 - f39_local15, -f39_local14)
		Widget:addElement(Widget)
		f0_local21(f39_arg0.m_ownerController, Widget)
		f39_arg0.statsTabContainer.xpBarWidget = CoD.AfterActionReport.GetXPBarWidget(controller)
		f39_arg0.statsTabContainer:addElement(f39_arg0.statsTabContainer.xpBarWidget)
		f39_arg0.statsTabContainer:registerEventHandler("animate_xp_bar", CoD.AfterActionReport.AnimateXPBarWidget)
		f39_arg0.statsTabContainer:processEvent({
			name = "animate_xp_bar",
			duration = 0
		})
	end
end

CoD.AfterActionReport.GetScoreboardWidget = function (f40_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.AfterActionReport.ScoreBoardWidgetContainerWidth / 2, CoD.AfterActionReport.ScoreBoardWidgetContainerWidth / 2)
	Widget:setTopBottom(true, true, CoD.AfterActionReport.ScoreBoardWidgetContainerTopOffset, -CoD.AfterActionReport.ScoreBoardWidgetContainerBottomOffset)
	CreateScoreBoardBody(Widget, f40_arg0, true)
	return Widget
end

local f0_local25 = function (f41_arg0, f41_arg1)
	f0_local5(f41_arg0)
	if f41_arg0.scoreboardTabContainer then
		f41_arg0.scoreboardTabContainer:show()
		return 
	else
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		f41_arg0.scoreboardTabContainer = Widget
		f41_arg0:addElement(Widget)
		f41_arg0.scoreboardTabContainer:addElement(CoD.AfterActionReport.GetScoreboardWidget(f41_arg0.m_ownerController))
	end
end

local f0_local26 = function (f42_arg0, f42_arg1)
	f0_local5(f42_arg0)
	if f42_arg0.leaguesTabContainer then
		f42_arg0.leaguesTabContainer:show()
		return 
	else
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		f42_arg0.leaguesTabContainer = Widget
		f42_arg0:addElement(Widget)
		CoD.AfterActionReport.SetupSummaryPageForLeagues(f42_arg0.m_ownerController, Widget)
		f42_arg0.leaguesTabContainer.xpBarWidget = CoD.AfterActionReport.GetXPBarWidget(f42_arg0.m_ownerController)
		f42_arg0.leaguesTabContainer:addElement(f42_arg0.leaguesTabContainer.xpBarWidget)
		f42_arg0.leaguesTabContainer:registerEventHandler("animate_xp_bar", CoD.AfterActionReport.AnimateXPBarWidget)
	end
end

local f0_local27 = function (f43_arg0, f43_arg1)
	local f43_local0 = CoD.Menu.TitleHeight
	f43_arg0.tabManager = CoD.TabManager.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f43_local0 - CoD.ButtonPrompt.Height,
		bottom = f43_local0
	}, nil, LUI.Alignment.Right)
	f43_arg0:addElement(f43_arg0.tabManager)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == true then
		f43_arg0.tabManager:addTab(UIExpression.ToUpper(nil, Engine.Localize("MENU_LADDER_RESULTS")))
	else
		f43_arg0.tabManager:addTab(Engine.Localize("MPUI_MEDALS_CAPS"))
		f43_arg0.tabManager:addTab(UIExpression.ToUpper(nil, Engine.Localize("MENU_STATS")))
	end
	f43_arg0.tabManager:addTab(UIExpression.ToUpper(nil, Engine.Localize("MPUI_SCOREBOARD")))
	f43_arg0.tabManager:setCurrentTab()
end

local f0_local28 = function (f44_arg0, f44_arg1)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == true then
		f44_arg0:processEvent({
			name = CoD.AfterActionReport.Leagues.TabEvents[f44_arg1.tabIndex],
			controller = controller
		})
	else
		f44_arg0:processEvent({
			name = CoD.AfterActionReport.General.TabEvents[f44_arg1.tabIndex],
			controller = controller
		})
	end
end

CoD.AfterActionReport.CheckForAchievements = function (f45_arg0, f45_arg1)
	if f45_arg1 ~= nil then
		local f45_local0 = f45_arg1.wins
		if f45_local0 ~= nil and f45_local0 >= 5 then
			Engine.Exec(f45_arg0, "awardAchievement MP_MISC_3")
		end
	else
		if UIExpression.DvarInt(nil, "bot_enemies") == 1 and UIExpression.GetDStat(f45_arg0, "combatTrainingWins") >= 10 then
			Engine.Exec(f45_arg0, "awardAchievement MP_MISC_4")
		end
		local f45_local1 = Engine.TableFindRows(CoD.gametypesTable, 0, "0", 9, "party")
		if f45_local1 ~= nil then
			local f45_local2 = 0
			for f45_local3 = 1, #f45_local1, 1 do
				f45_local2 = f45_local2 + UIExpression.GetDStat(f45_arg0, "PlayerStatsByGameType", Engine.TableGetColumnValueForRow(CoD.gametypesTable, f45_local1[f45_local3], 1), "WINS", "statValue")
			end
			if f45_local2 >= 10 then
				Engine.Exec(f45_arg0, "awardAchievement MP_MISC_5")
			end
		end
	end
end

local f0_local29 = function (f46_arg0, f46_arg1, f46_arg2)
	f46_arg0:processEvent({
		name = "button_prompt_back"
	})
	if CoD.AfterActionReport.RateMatchQoSLastMatchLogged == nil then
		CoD.AfterActionReport.RateMatchQoSLastMatchLogged = UIExpression.DvarString(nil, "dw_logging_last_match_logged")
	end
	if CoD.AfterActionReport.RateMatchQoSLastMatchLogged ~= "nil" and CoD.AfterActionReport.RateMatchQoSLastMatchLogged ~= "0" then
		local f46_local0 = UIExpression.DvarFloat(nil, "tu_10_matchRatingSampleChance") * 1000
		if CoD.AfterActionReport.RateMatchChanceEvaluated == false then
			math.randomseed(os.time())
			if f46_local0 > math.random(0, 1000) then
				CoD.AfterActionReport.RateMatchSelectedForSurvey = true
			end
			CoD.AfterActionReport.RateMatchChanceEvaluated = true
		end
		if CoD.AfterActionReport.RateMatchSelectedForSurvey == true and CoD.AfterActionReport.RateMatchSurveyComplete == false then
			local f46_local1 = CoD.AfterActionReport.Stats
			local f46_local2 = nil
			if f46_local1.currentStats ~= nil then
				f46_local2 = f46_local1.currentStats.AfterActionReportStats.demoFileID:get()
			end
			if f46_local2 == CoD.AfterActionReport.RateMatchQoSLastMatchLogged then
				f46_arg0:openPopup("RateMatchPopup", f46_arg1.controller)
			end
		end
	end
end

CoD.AfterActionReport.ShouldShowAAR = function (f47_arg0)
	local f47_local0
	if Engine.GetPlayerStats(f47_arg0) == nil or Engine.GetPlayerStats(f47_arg0, CoD.STATS_LOCATION_STABLE) == nil then
		f47_local0 = false
	else
		f47_local0 = true
	end
	return f47_local0
end

LUI.createMenu.AfterActionReport = function (f48_arg0, f48_arg1)
	local f48_local0 = CoD.Menu.New("AfterActionReport")
	f48_local0:addLargePopupBackground()
	CoD.Menu.addTitle(f48_local0, UIExpression.ToUpper(nil, Engine.Localize("MPUI_AFTER_ACTION_REPORT")), LUI.Alignment.Left)
	f48_local0:setOwner(f48_arg0)
	f48_local0.isPartyLobby = nil
	if f48_arg1 then
		f48_local0.isPartyLobby = f48_arg1.isPartyLobby
	end
	CoD.AfterActionReport.AddButtonPrompts(f48_local0, "show_rate_match", f48_arg0)
	f0_local0(f48_local0)
	f48_local0:registerEventHandler("tab_changed", f0_local28)
	f48_local0:registerEventHandler("setup_leagues_tab", f0_local26)
	f48_local0:registerEventHandler("setup_medals_tab", f0_local15)
	f48_local0:registerEventHandler("setup_stats_tab", f0_local24)
	f48_local0:registerEventHandler("setup_scoreboard_tab", f0_local25)
	f48_local0:registerEventHandler("show_rate_match", f0_local29)
	f48_local0.animateIn = CoD.NullFunction
	f0_local27(f48_local0, f48_arg0)
	local f48_local1 = nil
	if f48_arg1 == nil or f48_arg1.animateXPbar ~= true then
		f48_local1 = 0
	end
	f48_local0:dispatchEventToChildren({
		name = "animate_xp_bar",
		duration = f48_local1
	})
	CoD.AfterActionReport.CheckForAchievements(f48_arg0, nil)
	return f48_local0
end

