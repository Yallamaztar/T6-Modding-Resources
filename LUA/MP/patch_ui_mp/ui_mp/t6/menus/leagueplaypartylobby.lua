require("T6.PartyLobby")
require("T6.LeagueStats")
require("T6.Menus.LeagueTeamNamePopup")
require("T6.Menus.LeagueSelectionPopup")
CoD.LeaguePlayPartyLobby = {}
CoD.LeaguePlayPartyLobby.OpenLeagueSelection = function (f1_arg0, f1_arg1)
	if UIExpression.IsGuest(f1_arg1.controller) == 1 then
		local f1_local0 = f1_arg0:openPopup("Error", controller)
		f1_local0:setMessage(Engine.Localize("XBOXLIVE_NOGUESTACCOUNTS"))
		f1_local0.anyControllerAllowed = true
		return 
	else
		Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_SELECTING_PLAYLIST)
		CoD.PlaylistCategoryFilter = "leaguematch"
		local f1_local0 = f1_arg0:openPopup("PlaylistSelection", f1_arg1.controller)
		f1_local0:addCategoryButtons(f1_arg1.controller)
		Engine.PlaySound("cac_screen_fade")
	end
end

CoD.LeaguePlayPartyLobby.UpdateLeagueInfo = function (f2_arg0, f2_arg1)
	local f2_local0 = Engine.GetLeague()
	local f2_local1 = nil
	if f2_arg0.body then
		f2_local1 = f2_arg0.body.findMatchButton
	end
	if f2_local0 == nil and f2_local1 then
		f2_local1:disable()
	else
		local f2_local2 = Engine.GetLeagueStats(f2_arg1)
		if f2_arg0.body then
			local f2_local3 = CoD.LeagueStats.InvalidTeamForLeague(f2_arg1, f2_local0, f2_local2)
			if CoD.isPartyHost() and not f2_local3 then
				f2_local1:enable()
				f2_local1.hintText = Engine.Localize("MENU_LEAGUE_FIND_MATCH_DESC")
				if f2_local1:isInFocus() then
					f2_local1:dispatchEventToParent({
						name = "update_hint_text",
						button = f2_arg0.body.findMatchButton
					})
				end
			else
				f2_local1:disable()
				if f2_local3 then
					f2_local1.hintText = Engine.Localize(f2_local3)
					if f2_local1:isInFocus() then
						f2_local1:dispatchEventToParent({
							name = "update_hint_text",
							button = f2_arg0.body.findMatchButton
						})
					end
				end
			end
			f2_arg0.body.lobbyLeagueInfo:show()
			CoD.MapInfoImage.ShowLeagueInfo(f2_arg0.body.lobbyLeagueInfo, f2_local0)
			if not f2_local2.valid then
				return 
			elseif f2_local2.inPlacement == true then
				f2_arg0.body.leagueLeaderboardButton:disable()
				f2_arg0.body.leagueLeaderboardButton.hintText = Engine.Localize("MENU_LEAGUE_LEADERBOARD_LOCKED_DESC")
			else
				f2_arg0.body.leagueLeaderboardButton:enable()
				f2_arg0.body.leagueLeaderboardButton.hintText = Engine.Localize("MENU_LEAGUE_LEADERBOARD_DESC")
			end
		end
	end
	return f2_local0
end

CoD.LeaguePlayPartyLobby.LeagueChanged = function (f3_arg0, f3_arg1)
	f3_arg0.leagueInfo = CoD.LeaguePlayPartyLobby.UpdateLeagueInfo(f3_arg0.buttonPane, f3_arg1.controller)
	f3_arg0:dispatchEventToChildren(f3_arg1)
	if f3_arg0.aarPrompt then
		if CoD.AfterActionReport.ValidForLeagueTeam(f3_arg1.controller) then
			f3_arg0.aarPrompt:show()
		else
			f3_arg0.aarPrompt:hide()
		end
	end
end

CoD.LeaguePlayPartyLobby.TeamNameNotSet = function (f4_arg0)
	local f4_local0 = Engine.GetLeagueStats(f4_arg0)
	if f4_local0.teamName == "" and CoD.isPartyHost() and f4_local0.random == false then
		return true
	else
		return false
	end
end

CoD.LeaguePlayPartyLobby.TeamNameEntered = function (f5_arg0, f5_arg1)
	Engine.SetLeagueTeamName(f5_arg1.controller, f5_arg1.teamName)
end

CoD.LeaguePlayPartyLobby.PopulateButtons = function (f6_arg0)
	f6_arg0.body.findMatchButton.hintText = Engine.Localize("MENU_LEAGUE_FIND_MATCH_DESC")
	f6_arg0.body.findMatchButton:setActionEventName("go_to_finding_games")
	f6_arg0.body.findMatchButton:disable()
	f6_arg0.body.viewLeagueRulesButton = f6_arg0.body.buttonList:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_VIEW_LEAGUE_RULES")), Engine.Localize("MENU_VIEW_LEAGUE_RULES_DESC"), 1)
	f6_arg0.body.viewLeagueRulesButton:setActionEventName("open_view_league_rules_popup")
	f6_arg0.body.chooseLeagueButton = f6_arg0.body.buttonList:addButton(Engine.Localize("MENU_CHANGE_LEAGUE_CAPS"), Engine.Localize("MPUI_LEAGUES_DESC"), 2)
	f6_arg0.body.chooseLeagueButton:setActionEventName("open_playlist_selection")
	f6_arg0.body.leagueLeaderboardButton = f6_arg0.body.buttonList:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_LEAGUE_LEADERBOARD")), Engine.Localize("MENU_LEAGUE_LEADERBOARD_DESC"), 8)
	f6_arg0.body.leagueLeaderboardButton:setActionEventName("open_league_leaderboard")
	f6_arg0.body.leagueLeaderboardButton:disable()
	f6_arg0.body.buttonList:removeAllButtons()
	f6_arg0.body.findMatchButton:setPriority(1)
	f6_arg0.body.viewLeagueRulesButton:setPriority(1)
	f6_arg0.body.chooseLeagueButton:setPriority(2)
	f6_arg0.body.createAClassButton:setPriority(4)
	f6_arg0.body.rewardsButton:setPriority(5)
	f6_arg0.body.leagueLeaderboardButton:setPriority(7)
	if not Engine.IsBetaBuild() then
		f6_arg0.body.barracksButton:setPriority(8)
	end
	if CoD.isPartyHost() then
		f6_arg0.body.buttonList:addElement(f6_arg0.body.findMatchButton)
		f6_arg0.body.buttonList:addElement(f6_arg0.body.chooseLeagueButton)
	else
		f6_arg0.body.buttonList:addElement(f6_arg0.body.viewLeagueRulesButton)
	end
	f6_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2, 3)
	f6_arg0.body.buttonList:addElement(f6_arg0.body.createAClassButton)
	f6_arg0.body.buttonList:addElement(f6_arg0.body.rewardsButton)
	f6_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2, 6)
	f6_arg0.body.buttonList:addElement(f6_arg0.body.leagueLeaderboardButton)
	if not Engine.IsBetaBuild() then
		f6_arg0.body.buttonList:addElement(f6_arg0.body.barracksButton)
		f6_arg0.body.barracksButton.hintText = Engine.Localize("MENU_LEAGUE_BARRACKS_DESC")
	end
	CoD.Lobby.AddLivestreamButton(f6_arg0, 10)
	CoD.LeaguePlayPartyLobby.AddLobbyLeagueInfo(f6_arg0.body)
end

CoD.LeaguePlayPartyLobby.PopulateButtonPaneElements = function (f7_arg0)
	CoD.PartyLobby.PopulateButtonPaneElements(f7_arg0)
	CoD.LeaguePlayPartyLobby.PopulateButtons(f7_arg0)
	CoD.LeaguePlayPartyLobby.UpdateLeagueInfo(f7_arg0, f7_arg0.controller)
end

CoD.LeaguePlayPartyLobby.AddLobbyLeagueInfo = function (f8_arg0)
	if f8_arg0.lobbyLeagueInfo ~= nil then
		f8_arg0.lobbyLeagueInfo:close()
		f8_arg0.lobbyLeagueInfo = nil
	end
	local f8_local0 = 350 - CoD.CoD9Button.Height - 0
	f8_arg0.lobbyLeagueInfo = CoD.MapInfoImage.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f8_local0,
		topAnchor = false,
		bottomAnchor = true,
		top = -(f8_local0 / CoD.MapInfoImage.AspectRatio) - CoD.ButtonPrompt.Height - 15,
		bottom = -CoD.ButtonPrompt.Height - 15
	})
	f8_arg0.lobbyLeagueInfo:registerEventHandler("gamelobby_update", CoD.NullFunction)
	f8_arg0.lobbyLeagueInfo:registerEventHandler("game_options_update", CoD.NullFunction)
	f8_arg0.lobbyLeagueInfo:hide()
	f8_arg0:addElement(f8_arg0.lobbyLeagueInfo)
end

CoD.LeaguePlayPartyLobby.AddLobbyPaneElements = function (f9_arg0)
	CoD.PartyLobby.AddLobbyPaneElements(f9_arg0)
	CoD.LeaguePlayPartyLobby.AddPlayerLeagueInfo(f9_arg0)
end

CoD.LeaguePlayPartyLobby.AddPlayerLeagueInfo = function (f10_arg0)
	if f10_arg0.playerLeagueInfo ~= nil then
		f10_arg0.playerLeagueInfo:close()
		f10_arg0.playerLeagueInfo = nil
	end
	local f10_local0 = -CoD.LeagueStats.height - CoD.ButtonPrompt.Height * 2
	local f10_local1 = CoD.LobbyPanes.VoipOffset
	f10_arg0.body.playerLeagueInfo = CoD.LeagueStats.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f10_local1,
		right = f10_local1 + CoD.LeagueStats.width,
		topAnchor = false,
		bottomAnchor = true,
		top = f10_local0,
		bottom = f10_local0 + CoD.LeagueStats.height
	})
	f10_arg0.body:addElement(f10_arg0.body.playerLeagueInfo)
end

CoD.LeaguePlayPartyLobby.PopulateLobbyPaneElements = function (f11_arg0)
	CoD.LobbyPanes.populateLobbyPaneElements(f11_arg0)
	f11_arg0.body.playerLeagueInfo:update({
		controller = f11_arg0.controller
	})
end

CoD.LeaguePlayPartyLobby.SetCurrentLeague = function (f12_arg0, f12_arg1)
	f12_arg0:processEvent({
		name = "league_changed",
		controller = f12_arg1
	})
end

CoD.LeaguePlayPartyLobby.GoToFindingGames = function (f13_arg0, f13_arg1)
	if not CoD.isPartyHost() or CoD.LeagueStats.InvalidTeamForLeague(f13_arg1.controller, Engine.GetLeague(), Engine.GetLeagueStats(f13_arg1.controller)) then
		return 
	else
		local f13_local0, f13_local1 = Engine.ProbationCheckInProbation(CoD.GAMEMODE_LEAGUE_MATCH)
		if f13_local0 == true then
			f13_arg0:openPopup("popup_league_inprobation", f13_local1)
			return 
		else
			local f13_local2, f13_local3 = Engine.ProbationCheckForProbation(CoD.GAMEMODE_LEAGUE_MATCH)
			f13_local1 = f13_local3
			if f13_local2 == true then
				f13_arg0:openPopup("popup_league_givenprobation", f13_local1)
				return 
			elseif Engine.ProbationCheckParty(CoD.GAMEMODE_LEAGUE_MATCH, f13_arg1.controller) == true then
				f13_arg0:openPopup("popup_league_partyprobation", f13_arg1.controller)
				return 
			elseif CoD.LeaguePlayPartyLobby.TeamNameNotSet(f13_arg1.controller) then
				f13_arg0:openPopup("EnterTeamNamePopup", f13_arg1.controller)
				return 
			else
				Engine.Exec(f13_arg1.controller, "xstartparty")
				Engine.Exec(f13_arg1.controller, "updategamerprofile")
				f13_arg0:openMenu("LeagueGameLobby", f13_arg1.controller)
				f13_arg0:close()
			end
		end
	end
end

CoD.LeaguePlayPartyLobby.UpdateButtonPaneButtonVisibility = function (f14_arg0)
	if f14_arg0 == nil or f14_arg0.body == nil then
		return 
	elseif CoD.isPartyHost() then
		f14_arg0.body.buttonList:addElement(f14_arg0.body.findMatchButton)
	else
		f14_arg0.body.findMatchButton:close()
	end
	CoD.PartyLobby.UpdateDLCWarning(f14_arg0)
end

CoD.LeaguePlayPartyLobby.Update = function (f15_arg0, f15_arg1)
	if f15_arg0 == nil then
		return 
	end
	CoD.LeaguePlayPartyLobby.LeagueChanged(f15_arg0, f15_arg1)
	CoD.LeaguePlayPartyLobby.UpdateButtonPaneButtonVisibility(f15_arg0.buttonPane)
	CoD.PartyLobby.UpdateButtonPromptVisibility(f15_arg0)
	if f15_arg0.buttonPane and f15_arg0.buttonPane.body then
		if CoD.isPartyHost() then
			f15_arg0.buttonPane.body.viewLeagueRulesButton:close()
			f15_arg0.buttonPane.body.buttonList:addElement(f15_arg0.buttonPane.body.chooseLeagueButton)
		else
			f15_arg0.buttonPane.body.chooseLeagueButton:close()
			f15_arg0.buttonPane.body.buttonList:addElement(f15_arg0.buttonPane.body.viewLeagueRulesButton)
			f15_arg0.buttonPane.body.buttonList:processEvent({
				name = "gain_focus"
			})
		end
		if Engine.GetGametypeSetting("loadoutKillstreaksEnabled") == 0 and f15_arg0.buttonPane and f15_arg0.buttonPane.body and f15_arg0.buttonPane.body.rewardsButton then
			f15_arg0.buttonPane.body.rewardsButton:disable()
			f15_arg0.buttonPane.body.rewardsButton.hintText = Engine.Localize("MENU_SCORE_STREAKS_DISABLED")
		else
			f15_arg0.buttonPane.body.rewardsButton:enable()
			f15_arg0.buttonPane.body.rewardsButton.hintText = Engine.Localize("FEATURE_KILLSTREAKS_DESC")
		end
	end
	f15_arg0:dispatchEventToChildren(f15_arg1)
end

CoD.LeaguePlayPartyLobby.OpenLeagueLeaderboard = function (f16_arg0, f16_arg1)
	local f16_local0 = Engine.GetLeagueStats(f16_arg1.controller)
	local f16_local1 = Engine.GetLeague(f16_arg1.controller)
	local f16_local2 = CoD.LeaguesData.CurrentTeamSubdivisionInfo
	f16_local2.subdivisionID = f16_local0.subdivisionID
	f16_local2.teamID = f16_local0.teamID
	f16_local2.leagueIconName = f16_local1.iconName
	f16_local2.leagueDesc = f16_local1.name
	f16_local2.divisionName = f16_local0.divisionName
	f16_local2.divisionIcon = f16_local0.divisionIcon
	f16_local2.subdivisionName = f16_local0.subdivisionName
	f16_local2.bracketRankPosition = f16_local0.bracketRankPosition
	f16_local2.divisionID = f16_local0.divisionID
	CoD.LeaguesData.CurrentTeamInfo.teamName = f16_local0.teamName
	CoD.LeaguesData.CurrentTeamInfo.teamID = f16_local0.teamID
	CoD.LeaguesData.CurrentLeagueID = f16_local1.id
	CoD.LeaguesData.numTeamMembersToShow = 1
	if f16_local0 and not f16_local0.random then
		CoD.LeaguesData.numTeamMembersToShow = f16_local0.memberCount
	end
	f16_arg0:openPopup("LeagueLeaderboard", f16_arg1.controller, true)
end

CoD.LeaguePlayPartyLobby.OpenViewLeagueRulesPopup = function (f17_arg0, f17_arg1)
	f17_arg0:openPopup("ViewLeagueRulesPopup", f17_arg1.controller)
end

CoD.LeaguePlayPartyLobby.AddButtonPrompts = function (f18_arg0, f18_arg1)
	local f18_local0 = Engine.GetPlayerStats(f18_arg1)
	local f18_local1 = f18_local0.AfterActionReportStats.lobbyPopup:get()
	if UIExpression.IsStableStatsBufferInitialized() == 1 and (f18_local1 == "league" or f18_local1 == "leaguesummary") and CoD.AfterActionReport.ShouldShowAAR(f18_arg1) then
		local f18_local2 = CoD.ButtonPrompt.new
		local f18_local3 = "select"
		local f18_local4 = Engine.Localize("MPUI_AFTER_ACTION_REPORT")
		local f18_local5 = f18_arg0
		local f18_local6 = "open_aar"
		local f18_local7, f18_local8 = false
		local f18_local9, f18_local10 = false
		f18_arg0.aarPrompt = f18_local2(f18_local3, f18_local4, f18_local5, f18_local6, f18_local7, f18_local8, f18_local9, f18_local10, "TAB")
		f18_arg0:addRightButtonPrompt(f18_arg0.aarPrompt)
	end
end

CoD.LeaguePlayPartyLobby.OpenAAR = function (f19_arg0, f19_arg1)
	if CoD.AfterActionReport.ValidForLeagueTeam(f19_arg1.controller) then
		CoD.AfterActionReport.OpenAfterActionReport(f19_arg0, f19_arg1.controller, true)
	end
end

LUI.createMenu.LeaguePlayPartyLobby = function (f20_arg0)
	local f20_local0 = CoD.PartyLobby.new(f20_arg0, "LeaguePlayPartyLobby", Engine.Localize("MENU_LEAGUE_PLAY_CAPS"))
	f20_local0:addTitle(Engine.Localize("MENU_LEAGUE_PLAY_CAPS"))
	f20_local0.populateButtonPaneElements = CoD.LeaguePlayPartyLobby.PopulateButtonPaneElements
	f20_local0.addLobbyPaneElements = CoD.LeaguePlayPartyLobby.AddLobbyPaneElements
	f20_local0.populateLobbyPaneElements = CoD.LeaguePlayPartyLobby.PopulateLobbyPaneElements
	f20_local0:updatePanelFunctions()
	f20_local0:registerEventHandler("open_playlist_selection", CoD.LeaguePlayPartyLobby.OpenLeagueSelection)
	f20_local0:registerEventHandler("league_changed", CoD.LeaguePlayPartyLobby.LeagueChanged)
	f20_local0:registerEventHandler("playlist_selected", CoD.LeaguePlayPartyLobby.LeagueChanged)
	f20_local0:registerEventHandler("go_to_finding_games", CoD.LeaguePlayPartyLobby.GoToFindingGames)
	f20_local0:registerEventHandler("partylobby_update", CoD.LeaguePlayPartyLobby.Update)
	f20_local0:registerEventHandler("open_league_leaderboard", CoD.LeaguePlayPartyLobby.OpenLeagueLeaderboard)
	f20_local0:registerEventHandler("open_view_league_rules_popup", CoD.LeaguePlayPartyLobby.OpenViewLeagueRulesPopup)
	f20_local0:registerEventHandler("open_aar", CoD.LeaguePlayPartyLobby.OpenAAR)
	f20_local0:setOwner(f20_arg0)
	CoD.LeaguePlayPartyLobby.PopulateButtons(f20_local0.buttonPane)
	CoD.LeaguePlayPartyLobby.AddButtonPrompts(f20_local0, f20_arg0)
	CoD.LeaguePlayPartyLobby.AddPlayerLeagueInfo(f20_local0.lobbyPane)
	f20_local0.lobbyPane:setSplitscreenSignInAllowed(false)
	CoD.LeaguePlayPartyLobby.SetCurrentLeague(f20_local0, f20_arg0)
	return f20_local0
end

local f0_local0 = function (f21_arg0, f21_arg1)
	f21_arg0.infoContainer.icon:setImage(RegisterMaterial(Engine.GetPlaylistIconName(f21_arg1.controller, Engine.GetPlaylistID())))
	f21_arg0.infoContainer.titleElement:setText(Engine.GetPlaylistName(f21_arg1.controller, Engine.GetPlaylistID()))
	f21_arg0.infoContainer.description:setText(Engine.GetPlaylistDesc(f21_arg1.controller, Engine.GetPlaylistID()))
end

LUI.createMenu.ViewLeagueRulesPopup = function (f22_arg0)
	local f22_local0 = CoD.Menu.New("EnterTeamNamePopup")
	f22_local0:addLargePopupBackground()
	f22_local0:addBackButton()
	f22_local0:registerEventHandler("league_changed", f0_local0)
	local f22_local1 = 388
	f22_local0.infoContainer = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f22_local1 / 2,
		right = f22_local1 / 2,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.Menu.TitleHeight,
		bottom = 0
	})
	f22_local0:addElement(f22_local0.infoContainer)
	local f22_local2 = 384
	local f22_local3 = f22_local2 / 2
	local f22_local4 = 0
	f22_local0.infoContainer.icon = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f22_local2 / 2,
		right = f22_local2 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f22_local4,
		bottom = f22_local4 + f22_local3,
		alpha = 1
	})
	f22_local0.infoContainer.icon:setImage(RegisterMaterial(Engine.GetPlaylistIconName(f22_arg0, Engine.GetPlaylistID())))
	f22_local0.infoContainer:addElement(f22_local0.infoContainer.icon)
	local f22_local5 = f22_local1
	f22_local0.infoContainer.infoWidth = f22_local5
	f22_local4 = f22_local4 + f22_local3 + 15
	f22_local0.infoContainer.titleElement = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f22_local5 / 2,
		right = f22_local5 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f22_local4,
		bottom = f22_local4 + CoD.textSize.Big,
		font = CoD.fonts.Big,
		alignment = LUI.Alignment.Center
	})
	f22_local0.infoContainer.titleElement:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f22_local0.infoContainer.titleElement:setText(Engine.GetPlaylistName(f22_arg0, Engine.GetPlaylistID()))
	f22_local0.infoContainer:addElement(f22_local0.infoContainer.titleElement)
	f22_local4 = f22_local4 + CoD.textSize.Big * 2 + 5
	f22_local0.infoContainer.description = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f22_local5 / 2,
		right = f22_local5 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f22_local4,
		bottom = f22_local4 + CoD.textSize.Default,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Left
	})
	f22_local0.infoContainer.description:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f22_local0.infoContainer.description:setText(Engine.GetPlaylistDesc(f22_arg0, Engine.GetPlaylistID()))
	f22_local0.infoContainer:addElement(f22_local0.infoContainer.description)
	return f22_local0
end

