require("T6.Menus.PublicGameLobby")
require("T6.LeagueStats")
require("T6.Menus.LeaguePostGameLobbyInfo")
local f0_local0 = nil
CoD.LeagueGameLobby = {}
CoD.LeagueGameLobby.PopulateButtons = function (f1_arg0, f1_arg1)
	f1_arg0.body.createAClassButton = f1_arg0.body.buttonList:addButton(Engine.Localize("MENU_CREATE_A_CLASS_CAPS"))
	CoD.CACUtility.SetupCACLock(f1_arg0.body.createAClassButton)
	f1_arg0.body.createAClassButton:registerEventHandler("button_action", CoD.GameLobby.Button_CAC)
	f1_arg0.body.rewardsButton = f1_arg0.body.buttonList:addButton(Engine.Localize("MENU_SCORE_STREAKS_CAPS"))
	CoD.SetupButtonLock(f1_arg0.body.rewardsButton, nil, "FEATURE_KILLSTREAKS", "FEATURE_KILLSTREAKS_DESC")
	f1_arg0.body.rewardsButton:registerEventHandler("button_action", CoD.GameLobby.Button_Rewards)
	f1_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2)
	f1_arg0.body.leagueLeaderboardButton = f1_arg0.body.buttonList:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_LEAGUE_LEADERBOARD")), Engine.Localize("MENU_LEAGUE_LEADERBOARD_DESC"), 8)
	f1_arg0.body.leagueLeaderboardButton:setActionEventName("open_league_leaderboard")
	f1_arg0.body.leagueLeaderboardButton:disable()
	local f1_local0 = Engine.GetLeagueStats(f1_arg1)
	if f1_local0.valid then
		if f1_local0.inPlacement == true then
			f1_arg0.body.leagueLeaderboardButton:disable()
			f1_arg0.body.leagueLeaderboardButton.hintText = Engine.Localize("MENU_LEAGUE_LEADERBOARD_LOCKED_DESC")
		else
			f1_arg0.body.leagueLeaderboardButton:enable()
			f1_arg0.body.leagueLeaderboardButton.hintText = Engine.Localize("MENU_LEAGUE_LEADERBOARD_DESC")
		end
	end
	if not Engine.IsBetaBuild() then
		f1_arg0.body.barracksButton = f1_arg0.body.buttonList:addButton(Engine.Localize("MENU_BARRACKS_CAPS"))
		CoD.SetupBarracksLock(f1_arg0.body.barracksButton)
		f1_arg0.body.barracksButton:setActionEventName("open_barracks")
	end
	local f1_local1 = 350 - CoD.CoD9Button.Height - 0
	local f1_local2 = f1_local1 / CoD.MapInfoImage.AspectRatio
	f1_arg0.body.mapInfoImage = CoD.MapInfoImage.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f1_local1,
		topAnchor = false,
		bottomAnchor = true,
		top = -f1_local2 - CoD.ButtonPrompt.Height - 15,
		bottom = -CoD.ButtonPrompt.Height - 15
	})
	f1_arg0.body.mapInfoImage:setPriority(200)
	f1_arg0.body:addElement(f1_arg0.body.mapInfoImage)
	f1_arg0.body.mapInfoImage:registerEventHandler("gamelobby_update", f0_local0)
	f1_arg0.body.mapInfoImage:registerEventHandler("game_options_update", CoD.NullFunction)
	f1_arg0.body.mapInfoImage:processEvent({
		name = "gamelobby_update"
	})
	f1_arg0.body.postGameLobbyInfo = CoD.LeaguePostGameLobbyInfo.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f1_local1,
		topAnchor = false,
		bottomAnchor = true,
		top = -f1_local2 - CoD.ButtonPrompt.Height - 15,
		bottom = -CoD.ButtonPrompt.Height - 15
	})
	f1_arg0.body:addElement(f1_arg0.body.postGameLobbyInfo)
	f1_arg0.body.postGameLobbyInfo:hide()
	CoD.GameLobby.PopulateButtons(f1_arg0, f1_local2)
	CoD.PublicGameLobby.AddDetailedStatusText(f1_arg0, f1_local2)
end

CoD.LeagueGameLobby.UpdateButtonPaneButtonVisibility = function (f2_arg0)
	if f2_arg0 == nil or f2_arg0.body == nil then
		return 
	else

	end
end

CoD.LeagueGameLobby.UpdateButtonPromptVisibility = function (f3_arg0)
	if f3_arg0 == nil then
		return 
	end
	f3_arg0:removeBackButton()
	if not Engine.PartyLockedIn() then
		f3_arg0:addBackButton()
	end
	if f3_arg0.partyPrivacyButton then
		f3_arg0.partyPrivacyButton:close()
	end
end

CoD.LeagueGameLobby.PopulateButtonPaneElements = function (f4_arg0)
	CoD.LeagueGameLobby.PopulateButtons(f4_arg0)
	CoD.LeagueGameLobby.UpdateButtonPaneButtonVisibility(f4_arg0)
end

CoD.LeagueGameLobby.AddLobbyPaneElements = function (f5_arg0)
	CoD.PartyLobby.AddLobbyPaneElements(f5_arg0)
	CoD.LeaguePlayPartyLobby.AddPlayerLeagueInfo(f5_arg0)
end

CoD.LeagueGameLobby.AddPlayerLeagueInfo = function (f6_arg0)
	if f6_arg0.playerLeagueInfo ~= nil then
		f6_arg0.playerLeagueInfo:close()
		f6_arg0.playerLeagueInfo = nil
	end
	local f6_local0 = -CoD.LeagueStats.height - CoD.ButtonPrompt.Height * 2
	local f6_local1 = CoD.LobbyPanes.VoipOffset
	f6_arg0.body.playerLeagueInfo = CoD.LeagueStats.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f6_local1,
		right = f6_local1 + CoD.LeagueStats.width,
		topAnchor = false,
		bottomAnchor = true,
		top = f6_local0,
		bottom = f6_local0 + CoD.LeagueStats.height
	})
	f6_arg0.body:addElement(f6_arg0.body.playerLeagueInfo)
end

CoD.LeagueGameLobby.PopulateLobbyPaneElements = function (f7_arg0)
	CoD.LobbyPanes.populateLobbyPaneElements(f7_arg0)
	f7_arg0.body.playerLeagueInfo:update({
		controller = f7_arg0.controller
	})
end

CoD.LeagueGameLobby.GoBack = function (f8_arg0, f8_arg1)
	f8_arg0:setPreviousMenu("LeaguePlayPartyLobby")
	CoD.Lobby.GoBack(f8_arg0, f8_arg1)
end

CoD.LeagueGameLobby.AddButtonPrompts = function (f9_arg0, f9_arg1)
	local f9_local0 = Engine.GetPlayerStats(f9_arg1)
	local f9_local1 = f9_local0.AfterActionReportStats.lobbyPopup:get()
	if UIExpression.IsStableStatsBufferInitialized() == 1 and (f9_local1 == "league" or f9_local1 == "leaguesummary") and CoD.AfterActionReport.ShouldShowAAR(f9_arg1) then
		local f9_local2 = f9_arg0
		local f9_local3 = f9_arg0.addRightButtonPrompt
		local f9_local4 = CoD.ButtonPrompt.new
		local f9_local5 = "select"
		local f9_local6 = Engine.Localize("MPUI_AFTER_ACTION_REPORT")
		local f9_local7 = f9_arg0
		local f9_local8 = "open_aar"
		local f9_local9, f9_local10 = false
		local f9_local11, f9_local12 = false
		f9_local3(f9_local2, f9_local4(f9_local5, f9_local6, f9_local7, f9_local8, f9_local9, f9_local10, f9_local11, f9_local12, "TAB"))
	end
end

CoD.LeagueGameLobby.UpdateStatus = function (f10_arg0, f10_arg1)
	if Engine.PartyIsPostGame() == true and f10_arg0.buttonPane.body and f10_arg0.buttonPane.body.mapInfoImage and f10_arg0.buttonPane.body.postGameLobbyInfo then
		f10_arg0.buttonPane.body.mapInfoImage:hide(0)
		f10_arg0.buttonPane.body.statusText:hide()
		f10_arg0.buttonPane.body.postGameLobbyInfo:show()
		f10_arg0.buttonPane.body.postGameLobbyInfo:update(f10_arg1.controller)
		f10_arg0:dispatchEventToChildren({
			name = "set_new_title",
			titleText = UIExpression.ToUpper(nil, Engine.Localize("MENU_POST_GAME_LOBBY"))
		})
	elseif f10_arg0.buttonPane.body and f10_arg0.buttonPane.body.mapInfoImage and f10_arg0.buttonPane.body.postGameLobbyInfo then
		f10_arg0.buttonPane.body.mapInfoImage:show(0)
		f10_arg0.buttonPane.body.statusText:show()
		f10_arg0.buttonPane.body.postGameLobbyInfo:hide()
		CoD.GameLobby.UpdateStatusText(f10_arg0, f10_arg1)
		f10_arg0:dispatchEventToChildren({
			name = "set_new_title",
			titleText = f10_arg0.titleText
		})
	end
end

CoD.LeagueGameLobby.SetNewTitle = function (f11_arg0, f11_arg1)
	f11_arg0:setText(f11_arg1.titleText)
end

CoD.LeagueGameLobby.Update = function (f12_arg0, f12_arg1)
	CoD.LeagueGameLobby.UpdateButtonPromptVisibility(f12_arg0)
	CoD.GameLobby.Update(f12_arg0, f12_arg1)
	if f12_arg0.buttonPane and f12_arg0.buttonPane.body and f12_arg0.buttonPane.body.rewardsButton then
		if Engine.GetGametypeSetting("loadoutKillstreaksEnabled") == 0 then
			f12_arg0.buttonPane.body.rewardsButton:disable()
			f12_arg0.buttonPane.body.rewardsButton.hintText = Engine.Localize("MENU_SCORE_STREAKS_DISABLED")
		else
			f12_arg0.buttonPane.body.rewardsButton:enable()
			f12_arg0.buttonPane.body.rewardsButton.hintText = nil
		end
	end
end

LUI.createMenu.LeagueGameLobby = function (f13_arg0)
	local f13_local0 = UIExpression.ToUpper(nil, UIExpression.GetPlaylistName())
	local f13_local1 = CoD.PublicGameLobby.New("LeagueGameLobby", f13_arg0, f13_local0)
	if CoD.isMultiplayer then
		f13_local1:setPreviousMenu("MainLobby")
	end
	f13_local1:addTitle(f13_local0)
	f13_local1.populateButtonPaneElements = CoD.LeagueGameLobby.PopulateButtonPaneElements
	f13_local1.addLobbyPaneElements = CoD.LeagueGameLobby.AddLobbyPaneElements
	f13_local1.populateLobbyPaneElements = CoD.LeagueGameLobby.PopulateLobbyPaneElements
	f13_local1.goBack = CoD.LeagueGameLobby.GoBack
	f13_local1:updatePanelFunctions()
	CoD.LeagueGameLobby.PopulateButtons(f13_local1.buttonPane, f13_arg0)
	CoD.LeagueGameLobby.UpdateButtonPromptVisibility(f13_local1)
	CoD.LeagueGameLobby.AddButtonPrompts(f13_local1, f13_arg0)
	CoD.LeaguePlayPartyLobby.AddPlayerLeagueInfo(f13_local1.lobbyPane)
	f13_local1:processEvent({
		name = "league_changed",
		controller = f13_arg0
	})
	if CoD.useController then
		f13_local1.buttonPane.body.createAClassButton:processEvent({
			name = "gain_focus"
		})
	end
	f13_local1.lobbyPane:setSplitscreenSignInAllowed(false)
	f13_local1:registerEventHandler("party_update_status", CoD.LeagueGameLobby.UpdateStatus)
	f13_local1:registerEventHandler("open_league_leaderboard", CoD.LeaguePlayPartyLobby.OpenLeagueLeaderboard)
	f13_local1:registerEventHandler("partylobby_update", CoD.LeagueGameLobby.Update)
	f13_local1:registerEventHandler("gamelobby_update", CoD.LeagueGameLobby.Update)
	f13_local1.titleElement:registerEventHandler("set_new_title", CoD.LeagueGameLobby.SetNewTitle)
	return f13_local1
end

f0_local0 = function (f14_arg0, f14_arg1)
	if Engine.PartyIsReadyToStart() and not Engine.IsPartyLobbyRunning() then
		CoD.MapInfoImage.RefreshEvent(f14_arg0, f14_arg1)
	else
		CoD.MapInfoImage.ShowLeagueInfo(f14_arg0, Engine.GetLeague())
	end
end

