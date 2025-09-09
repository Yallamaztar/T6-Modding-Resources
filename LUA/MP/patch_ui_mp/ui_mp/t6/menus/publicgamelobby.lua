require("T6.GameLobby")
require("T6.MapVoter")
require("T6.Menus.MutePopup")
if CoD.isZombie == false then
	require("T6.Menus.AfterActionReportMenu")
	require("T6.Menus.LeaderboardMP")
end
CoD.PublicGameLobby = {}
CoD.PublicGameLobby.PopulateButtons = function (f1_arg0, f1_arg1)
	if CoD.isZombie == true then
		CoD.PublicGameLobby.PopulateButtons_Zombies(f1_arg0)
	else
		CoD.PublicGameLobby.PopulateButtons_Multiplayer(f1_arg0)
	end
	f1_arg0.body.buttonList:addSpacer(5)
	local f1_local0 = 350 - CoD.CoD9Button.Height
	local f1_local1 = f1_local0 / CoD.MapVoter.AspectRatio
	f1_arg0.body.mapVoter = CoD.MapVoter.new({
		left = 0,
		top = -f1_local1 - CoD.ButtonPrompt.Height - 15,
		right = f1_local0,
		bottom = -CoD.ButtonPrompt.Height - 15,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	}, f1_arg1)
	f1_arg0.body:addElement(f1_arg0.body.mapVoter)
	f1_arg0.body.mapVoter.focusResetElement = f1_arg0.body.lobbyLeaderboardButton
	f1_arg0.body.mapVoter.buttonList = f1_arg0.body.buttonList
	f1_arg0.body.mapVoter:addElements()
	CoD.GameLobby.PopulateButtons(f1_arg0, f1_local1)
	CoD.PublicGameLobby.AddDetailedStatusText(f1_arg0, f1_local1)
end

CoD.PublicGameLobby.AddButtonPrompts = function (f2_arg0, f2_arg1)
	local f2_local0 = Engine.GetPlayerStats(f2_arg1)
	local f2_local1 = f2_local0.AfterActionReportStats.lobbyPopup:get()
	if CoD.isZombie ~= true and UIExpression.IsStableStatsBufferInitialized() == 1 and (f2_local1 == "public" or f2_local1 == "summary" or f2_local1 == "promotion" or f2_local1 == "none" and Engine.IsSplitscreen() == true) and CoD.AfterActionReport.ShouldShowAAR(f2_arg1) then
		local f2_local2 = f2_arg0
		local f2_local3 = f2_arg0.addRightButtonPrompt
		local f2_local4 = CoD.ButtonPrompt.new
		local f2_local5 = "select"
		local f2_local6 = Engine.Localize("MPUI_AFTER_ACTION_REPORT")
		local f2_local7 = f2_arg0
		local f2_local8 = "open_aar"
		local f2_local9, f2_local10 = false
		local f2_local11, f2_local12 = false
		f2_local3(f2_local2, f2_local4(f2_local5, f2_local6, f2_local7, f2_local8, f2_local9, f2_local10, f2_local11, f2_local12, "TAB"))
	end
end

CoD.PublicGameLobby.Button_LobbyLeaderboard = function (f3_arg0, f3_arg1)
	if UIExpression.IsGuest(f3_arg1.controller) == 1 then
		f3_arg0:openPopup("popup_guest_contentrestricted", f3_arg1.controller)
		return 
	end
	local f3_local0 = nil
	if CoD.isZombie == false then
		f3_local0 = f3_arg0:openPopup("LeaderboardMP", f3_arg1.controller)
	else
		f3_local0 = f3_arg0:openPopup("LeaderboardZM", f3_arg1.controller)
	end
	local f3_local1 = Dvar.ui_gameType:get()
	if f3_local1 ~= nil then
		f3_local0:processEvent({
			name = "leaderboard_loadnew",
			controller = f3_arg1.controller,
			lbGameMode = f3_local1,
			lobbyFilters = true
		})
	end
end

CoD.PublicGameLobby.PopulateButtons_Multiplayer = function (f4_arg0)
	f4_arg0.body.createAClassButton = f4_arg0.body.buttonList:addButton(Engine.Localize("MENU_CREATE_A_CLASS_CAPS"))
	f4_arg0.body.createAClassButton.id = "CoD9Button." .. "PublicGameLobby." .. Engine.Localize("MENU_CREATE_A_CLASS_CAPS")
	CoD.CACUtility.SetupCACLock(f4_arg0.body.createAClassButton)
	f4_arg0.body.createAClassButton:registerEventHandler("button_action", CoD.GameLobby.Button_CAC)
	f4_arg0.body.rewardsButton = f4_arg0.body.buttonList:addButton(Engine.Localize("MENU_SCORE_STREAKS_CAPS"))
	f4_arg0.body.rewardsButton.id = "CoD9Button." .. "PublicGameLobby." .. Engine.Localize("MENU_SCORE_STREAKS_CAPS")
	CoD.SetupButtonLock(f4_arg0.body.rewardsButton, nil, "FEATURE_KILLSTREAKS", "FEATURE_KILLSTREAKS_DESC")
	CoD.CACUtility.SetupScorestreaksNew(f4_arg0.body.rewardsButton)
	f4_arg0.body.rewardsButton:registerEventHandler("button_action", CoD.GameLobby.Button_Rewards)
	f4_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2)
	f4_arg0.body.barracksButton = f4_arg0.body.buttonList:addButton(Engine.Localize("MENU_BARRACKS_CAPS"))
	f4_arg0.body.barracksButton.id = "CoD9Button." .. "PublicGameLobby." .. Engine.Localize("MENU_BARRACKS_CAPS")
	CoD.SetupBarracksLock(f4_arg0.body.barracksButton)
	CoD.SetupBarracksNew(f4_arg0.body.barracksButton)
	f4_arg0.body.barracksButton:setActionEventName("open_barracks")
	if Dvar.ui_hideLeaderboards:get() == false then
		f4_arg0.body.lobbyLeaderboardButton = f4_arg0.body.buttonList:addButton(Engine.Localize("MPUI_LOBBY_LEADERBOARD_CAPS"))
		f4_arg0.body.lobbyLeaderboardButton.hintText = Engine.Localize("MPUI_LOBBY_LEADERBOARD_DESC")
		f4_arg0.body.lobbyLeaderboardButton:setActionEventName("open_lobbyleaderboard")
	end
end

CoD.PublicGameLobby.Button_ReadyUp = function (f5_arg0, f5_arg1)
	f5_arg0:dispatchEventToParent({
		name = "ready_up",
		controller = f5_arg1.controller
	})
end

CoD.PublicGameLobby.ReadyUp = function (f6_arg0, f6_arg1)
	Engine.ExecNow(f6_arg1.controller, "xpartyready 1")
	if UIExpression.DvarBool(nil, "party_readyButtonVisible") == 0 then
		f6_arg0.buttonPane.body.readyupButton:disable()
	end
end

CoD.PublicGameLobby.PopulateButtons_Zombies = function (f7_arg0)
	local f7_local0 = "MPUI_VOTE_TO_START_CAPS"
	local f7_local1 = "ZMUI_READYUP_DESC"
	if CoD.PlaylistCategoryFilter == nil then
		CoD.PlaylistCategoryFilter = Engine.GetPlaylistCategoryFilter(UIExpression.GetPrimaryController(), Engine.GetPlaylistID())
	end
	if CoD.PlaylistCategoryFilter == CoD.Zombie.PLAYLIST_CATEGORY_FILTER_SOLOMATCH then
		f7_local0 = "MPUI_START_MATCH_CAPS"
		f7_local1 = "MPUI_START_MATCH_DESC"
	end
	f7_arg0.body.readyupButton = f7_arg0.body.buttonList:addButton(Engine.Localize(f7_local0), nil, 1)
	f7_arg0.body.readyupButton.hintText = Engine.Localize(f7_local1)
	f7_arg0.body.readyupButton:registerEventHandler("button_action", CoD.PublicGameLobby.Button_ReadyUp)
	f7_arg0.body.readyupButton:disable()
	f7_arg0.body.barracksButton = f7_arg0.body.buttonList:addButton(Engine.Localize("MPUI_LEADERBOARDS_CAPS"), nil, 2)
	CoD.SetupBarracksLock(f7_arg0.body.barracksButton)
	f7_arg0.body.barracksButton:setActionEventName("open_barracks")
	f7_arg0.body.changePlaylistButton = f7_arg0.body.buttonList:addButton(Engine.Localize("ZMUI_MAP_CAPS"), nil, 3)
	f7_arg0.body.changePlaylistButton.hintText = Engine.Localize("ZMUI_MAP_SELECTION_DESC")
	f7_arg0.body.changePlaylistButton:setActionEventName("change_playlist")
	CoD.GameGlobeZombie.MoveToUpDirectly()
end

CoD.PublicGameLobby.UpdateButtonPaneButtonVisibility = function (f8_arg0)
	if f8_arg0 == nil or f8_arg0.body == nil then
		return 
	elseif f8_arg0.body.mapVoter ~= nil then
		Engine.SystemNeedsUpdate(nil, "lobby")
	end
end

CoD.PublicGameLobby.UpdateButtonPromptVisibility = function (f9_arg0)
	if f9_arg0 == nil then
		return 
	elseif f9_arg0.partyPrivacyButton ~= nil then
		f9_arg0.partyPrivacyButton:close()
	end
end

CoD.PublicGameLobby.Update = function (f10_arg0, f10_arg1)
	local f10_local0 = UIExpression.GetPlaylistName()
	local f10_local1 = ""
	local f10_local2 = Dvar.ui_gameType:get()
	if CoD.isZombie == true and f10_local2 == CoD.Zombie.GAMETYPE_ZCLASSIC then
		f10_local1 = f10_local0
	else
		f10_local1 = UIExpression.ToUpper(nil, UIExpression.GetPlaylistCategoryName()) .. " / " .. UIExpression.ToUpper(nil, UIExpression.GetPlaylistName())
	end
	f10_arg0:setTitle(f10_local1)
	if CoD.isZombie == true and f10_arg0.buttonPane.body ~= nil and f10_arg0.buttonPane.body.readyupButton ~= nil then
		if UIExpression.DvarFloat(nil, "party_readyPercentRequired") > 0 and Engine.PartyIsWaiting() then
			f10_arg0.buttonPane.body.readyupButton:enable()
		else
			f10_arg0.buttonPane.body.readyupButton:disable()
		end
		if Engine.PartyIsWaiting() and f10_local2 ~= CoD.Zombie.GAMETYPE_ZCLASSIC and f10_local2 ~= CoD.Zombie.GAMETYPE_ZSTANDARD then
			f10_arg0.buttonPane.body.readyupButton:closeAndRefocus(f10_arg0.buttonPane.body.barracksButton)
		end
		local f10_local3 = Engine.GetPlaylistCategoryFilter(UIExpression.GetPrimaryController(), Engine.GetPlaylistID())
		if f10_local3 ~= CoD.PlaylistCategoryFilter then
			CoD.PlaylistCategoryFilter = f10_local3
			if CoD.PlaylistCategoryFilter ~= CoD.Zombie.PLAYLIST_CATEGORY_FILTER_SOLOMATCH then
				local f10_local4 = Engine.Localize("ZMUI_READYUP_DESC")
				local f10_local5 = Engine.Localize("MPUI_VOTE_TO_START_CAPS")
				f10_arg0.buttonPane.body.readyupButton.hintText = f10_local4
				f10_arg0.buttonPane.body.readyupButton:setLabel(f10_local5)
				f10_arg0.buttonPane.body.readyupButton.name = f10_local5
				CoD.PublicGameLobby.AddMuteButton(f10_arg0)
				f10_arg0:addNATType()
				CoD.PublicGameLobby.AddDetailedStatusText(f10_arg0.buttonPane, (350 - CoD.CoD9Button.Height) / CoD.MapVoter.AspectRatio)
				CoD.GameMapZombie.SwitchToMapDirect(2, true, 0)
			end
		end
	end
	f10_arg0:dispatchEventToChildren(f10_arg1)
end

CoD.PublicGameLobby.PopulateButtonPaneElements = function (f11_arg0, f11_arg1)
	CoD.PublicGameLobby.PopulateButtons(f11_arg0, f11_arg1)
	CoD.PublicGameLobby.UpdateButtonPaneButtonVisibility(f11_arg0)
end

CoD.PublicGameLobby.AddMuteButton = function (f12_arg0)
	local f12_local0 = CoD.ButtonPrompt.new
	local f12_local1 = "alt1"
	local f12_local2 = Engine.Localize("MENU_MUTING")
	local f12_local3 = f12_arg0
	local f12_local4 = "button_prompt_mute"
	local f12_local5, f12_local6 = false
	local f12_local7, f12_local8 = false
	f12_arg0.muteButton = f12_local0(f12_local1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6, f12_local7, f12_local8, "M")
	f12_arg0:addRightButtonPrompt(f12_arg0.muteButton)
end

CoD.PublicGameLobby.AddSearchPreferencesButton = function (f13_arg0)
	local f13_local0 = CoD.ButtonPrompt.new
	local f13_local1 = "shoulderr"
	local f13_local2 = Engine.Localize("MPUI_SEARCH_PREFERENCES")
	local f13_local3 = f13_arg0
	local f13_local4 = "button_prompt_search_preferences"
	local f13_local5, f13_local6 = false
	local f13_local7, f13_local8 = false
	f13_arg0.searchPreferencesButton = f13_local0(f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6, f13_local7, f13_local8, "S")
	f13_arg0:addRightButtonPrompt(f13_arg0.searchPreferencesButton)
end

CoD.PublicGameLobby.GoBack = function (f14_arg0, f14_arg1)
	if CoD.isZombie == true then
		f14_arg0:setPreviousMenu("MainLobby")
	end
	CoD.Lobby.GoBack(f14_arg0, f14_arg1)
end

CoD.PublicGameLobby.ChangePlaylist_LeaveLobby_Zombie = function (f15_arg0, f15_arg1)
	CoD.PublicGameLobby.ShutdownLobby(f15_arg0, f15_arg1)
	Engine.SetDvar("party_readyPercentRequired", 0)
	CoD.SwitchToPlayerMatchLobby(f15_arg1.controller)
	local f15_local0 = f15_arg0:openMenu("SelectStartLocZM", f15_arg1.controller)
	f15_local0:setPreviousMenu("SelectMapZM")
	f15_local0.skipOpenMenuEvent = true
	if f15_local0.startLocsPopulated == true then
		CoD.SelectStartLocZombie.GoToPreChoices(f15_local0, f15_arg1)
	end
	f15_arg0:close()
end

CoD.PublicGameLobby.ChangePlaylist_Zombie = function (f16_arg0, f16_arg1)
	if UIExpression.IsGuest(f16_arg1.controller) == 1 then
		local f16_local0 = f16_arg0:openPopup("Error", controller)
		f16_local0:setMessage(Engine.Localize("XBOXLIVE_NOGUESTACCOUNTS"))
		f16_local0.anyControllerAllowed = true
		return 
	elseif CoD.Lobby.OpenSignOutPopup(f16_arg0, f16_arg1) == true then
		return 
	else
		CoD.Lobby.ConfirmLeaveGameLobby(f16_arg0, {
			controller = f16_arg1.controller,
			leaveLobbyHandler = CoD.PublicGameLobby.ChangePlaylist_LeaveLobby_Zombie
		})
	end
end

CoD.PublicGameLobby.New = function (f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = CoD.GameLobby.new(f17_arg0, f17_arg1, true, f17_arg2, Engine.Localize("MENU_LOBBY_LIST_CAPS"))
	f17_local0:registerEventHandler("button_prompt_back", CoD.PublicGameLobby.Button_Back)
	f17_local0:registerEventHandler("button_prompt_mute", CoD.PublicGameLobby.ButtonPromptMute)
	f17_local0:registerEventHandler("open_aar", CoD.PublicGameLobby.OpenAAR)
	f17_local0:registerEventHandler("open_lobbyleaderboard", CoD.PublicGameLobby.Button_LobbyLeaderboard)
	f17_local0:registerEventHandler("gamelobby_update", CoD.PublicGameLobby.Update)
	if CoD.isZombie == true then
		f17_local0:registerEventHandler("ready_up", CoD.PublicGameLobby.ReadyUp)
		f17_local0:registerEventHandler("change_playlist", CoD.PublicGameLobby.ChangePlaylist_Zombie)
	end
	if not CoD.isZombie then
		CoD.PublicGameLobby.AddMuteButton(f17_local0)
		if CoD.usePCMatchmaking() then
			f17_local0:registerEventHandler("button_prompt_search_preferences", CoD.PublicGameLobby.ButtonPromptSearchPreferences)
			CoD.PublicGameLobby.AddSearchPreferencesButton(f17_local0)
		end
	elseif CoD.PlaylistCategoryFilter ~= CoD.Zombie.PLAYLIST_CATEGORY_FILTER_SOLOMATCH then
		CoD.PublicGameLobby.AddMuteButton(f17_local0)
	end
	f17_local0:addNATType()
	f17_local0.lobbyPane:setSplitscreenSignInAllowed(false)
	return f17_local0
end

LUI.createMenu.PublicGameLobby = function (f18_arg0)
	local f18_local0 = UIExpression.GetPlaylistName()
	local f18_local1 = ""
	if string.lower(f18_local0) ~= "tranzit" then
		f18_local1 = UIExpression.ToUpper(nil, UIExpression.GetPlaylistCategoryName()) .. " / " .. UIExpression.ToUpper(nil, UIExpression.GetPlaylistName())
	else
		f18_local1 = f18_local0
	end
	local f18_local2 = CoD.PublicGameLobby.New("PublicGameLobby", f18_arg0, f18_local1)
	if CoD.isMultiplayer then
		f18_local2:setPreviousMenu("PlayerMatchPartyLobby")
	end
	f18_local2:addTitle(f18_local1)
	f18_local2.populateButtonPaneElements = CoD.PublicGameLobby.PopulateButtonPaneElements
	f18_local2.goBack = CoD.PublicGameLobby.GoBack
	f18_local2:updatePanelFunctions()
	CoD.PublicGameLobby.PopulateButtons(f18_local2.buttonPane)
	CoD.PublicGameLobby.AddButtonPrompts(f18_local2, f18_arg0)
	CoD.PublicGameLobby.UpdateButtonPromptVisibility(f18_local2)
	if CoD.useController then
		if not CoD.isZombie then
			f18_local2.buttonPane.body.createAClassButton:processEvent({
				name = "gain_focus"
			})
		else
			f18_local2.buttonPane.body.buttonList:selectElementIndex(1)
		end
	end
	return f18_local2
end

CoD.PublicGameLobby.OpenAAR = function (f19_arg0, f19_arg1)
	CoD.AfterActionReport.OpenAfterActionReport(f19_arg0, f19_arg1.controller)
end

CoD.PublicGameLobby.Button_Back = function (f20_arg0, f20_arg1)
	if CoD.Lobby.OpenSignOutPopup(f20_arg0, f20_arg1) == true then
		return 
	else
		CoD.Lobby.ConfirmLeaveGameLobby(f20_arg0, {
			controller = f20_arg1.controller,
			leaveLobbyHandler = CoD.PublicGameLobby.LeaveLobby
		})
	end
end

CoD.PublicGameLobby.ShutdownLobby = function (f21_arg0, f21_arg1)
	if UIExpression.AloneInPartyIgnoreSplitscreen(f21_arg1.controller, 1) == 1 and UIExpression.InPrivateParty(f21_arg1.controller) == 1 then
		CoD.PublicGameLobby.LeaveLobby3(f21_arg1.controller)
		return 
	elseif UIExpression.InPrivateParty(f21_arg1.controller) == 1 then
		if UIExpression.PrivatePartyHost(f21_arg1.controller) == 1 then
			if f21_arg1.name ~= nil and f21_arg1.name == "confirm_leave_alone" then
				CoD.PublicGameLobby.LeaveLobby2(f21_arg1.controller)
			else
				CoD.PublicGameLobby.LeaveLobby3(f21_arg1.controller)
			end
		elseif UIExpression.PrivatePartyHostInLobby(f21_arg1.controller) == 1 then
			CoD.PublicGameLobby.LeaveLobby2(f21_arg1.controller)
		else
			CoD.PublicGameLobby.LeaveLobby1(f21_arg1.controller)
		end
	elseif UIExpression.AloneInPartyIgnoreSplitscreen(f21_arg1.controller, 1) == 1 then
		CoD.PublicGameLobby.LeaveLobby3(f21_arg1.controller)
	else
		CoD.PublicGameLobby.LeaveLobby1(f21_arg1.controller)
	end
end

CoD.PublicGameLobby.LeaveLobby_Project_Multiplayer = function (f22_arg0, f22_arg1)
	if Engine.PartyLockedIn() then
		return 
	else
		CoD.PublicGameLobby.ShutdownLobby(f22_arg0, f22_arg1)
		f22_arg0:goBack(f22_arg1)
	end
end

CoD.PublicGameLobby.LeaveLobby_Project_Zombie_After_Animation = function (f23_arg0, f23_arg1)
	CoD.PublicGameLobby.LeaveLobby_Project_Multiplayer(f23_arg0, {
		name = f23_arg0.leaveType,
		controller = f23_arg1.controller
	})
	f23_arg0.leaveType = nil
end

CoD.PublicGameLobby.LeaveLobby_Project_Zombie = function (f24_arg0, f24_arg1)
	f24_arg0.leaveType = f24_arg1.name
	if not CoD.isPC then
		f24_arg0:registerEventHandler("confirm_leave_animfinished", CoD.PublicGameLobby.LeaveLobby_Project_Zombie_After_Animation)
	end
	CoD.GameGlobeZombie.gameGlobe.currentMenu = f24_arg0
	CoD.GameGlobeZombie.MoveToCornerFromUp(f24_arg1.controller)
	if CoD.isPC then
		CoD.PublicGameLobby.LeaveLobby_Project_Zombie_After_Animation(f24_arg0, f24_arg1)
	end
	Engine.SetDvar("party_readyPercentRequired", 0)
end

CoD.PublicGameLobby.LeaveLobby_Project = function (f25_arg0, f25_arg1)
	if CoD.isZombie == true then
		CoD.PublicGameLobby.LeaveLobby_Project_Zombie(f25_arg0, f25_arg1)
	else
		CoD.PublicGameLobby.LeaveLobby_Project_Multiplayer(f25_arg0, f25_arg1)
	end
end

CoD.PublicGameLobby.LeaveLobby = function (f26_arg0, f26_arg1)
	CoD.PublicGameLobby.LeaveLobby_Project(f26_arg0, f26_arg1)
end

CoD.PublicGameLobby.LeaveLobby1 = function (f27_arg0)
	Engine.ExecNow(f27_arg0, "xstopparty")
	Engine.GameModeSetMode(CoD.GAMEMODE_PRIVATE_MATCH, false)
	Engine.SessionModeSetPrivate(false)
	Engine.SetDvar("invite_visible", 1)
	Engine.PartySetMaxPlayerCount(UIExpression.DvarInt(f27_arg0, "party_maxplayers_partylobby"))
end

CoD.PublicGameLobby.LeaveLobby2 = function (f28_arg0)
	Engine.ExecNow(f28_arg0, "xstopallparties")
	Engine.GameModeSetMode(CoD.GAMEMODE_PRIVATE_MATCH, false)
	Engine.SessionModeSetPrivate(false)
	Engine.ExecNow(f28_arg0, "xstartprivateparty")
	Engine.SetDvar("invite_visible", 1)
	Engine.PartySetMaxPlayerCount(UIExpression.DvarInt(f28_arg0, "party_maxplayers_partylobby"))
end

CoD.PublicGameLobby.LeaveLobby3 = function (f29_arg0)
	Engine.ExecNow(f29_arg0, "xstoppartykeeptogether")
	Engine.GameModeSetMode(CoD.GAMEMODE_PRIVATE_MATCH, false)
	Engine.SessionModeSetPrivate(false)
	Engine.SetDvar("invite_visible", 1)
	Engine.PartySetMaxPlayerCount(UIExpression.DvarInt(f29_arg0, "party_maxplayers_partylobby"))
end

CoD.PublicGameLobby.ButtonPromptMute = function (f30_arg0, f30_arg1)
	f30_arg0:openPopup("Mute", f30_arg1.controller)
end

CoD.PublicGameLobby.ButtonPromptSearchPreferences = function (f31_arg0, f31_arg1)
	f31_arg0:openPopup("SearchPreferences", f31_arg1.controller)
end

CoD.PublicGameLobby.AddDetailedStatusText = function (f32_arg0, f32_arg1)
	if CoD.isZombie then
		if CoD.PlaylistCategoryFilter == nil then
			CoD.PlaylistCategoryFilter = Engine.GetPlaylistCategoryFilter(UIExpression.GetPrimaryController(), Engine.GetPlaylistID())
		end
		if CoD.PlaylistCategoryFilter == CoD.Zombie.PLAYLIST_CATEGORY_FILTER_SOLOMATCH then
			return 
		end
	end
	if f32_arg0.body.detailedStatusText == nil then
		f32_arg0.body.detailedStatusText = {}
	end
	local f32_local0 = CoD.fonts.ExtraSmall
	local f32_local1 = 20
	local f32_local2 = -f32_arg1 - CoD.ButtonPrompt.Height - 15 - f32_local1 - 3 - f32_local1
	local f32_local3 = {}
	f32_local3 = Engine.GetMatchmakingProgress()
	for f32_local4 = 1, 3, 1 do
		if f32_arg0.body.detailedStatusText[f32_local4] ~= nil then
			f32_arg0.body.detailedStatusText[f32_local4]:close()
			f32_arg0.body.detailedStatusText[f32_local4] = nil
		end
		local f32_local7 = f32_local2 - f32_local1 * f32_local4
		local f32_local8 = LUI.UIText.new()
		f32_local8:setLeftRight(true, false, 0, 100)
		f32_local8:setTopBottom(false, true, f32_local7, f32_local7 + f32_local1)
		f32_local8:setFont(f32_local0)
		if UIExpression.DvarBool(nil, "ui_detailedMM") == 1 then
			f32_local8:setText(f32_local3[f32_local4])
		end
		f32_arg0.body.detailedStatusText[f32_local4] = f32_local8
		f32_arg0.body:addElement(f32_arg0.body.detailedStatusText[f32_local4])
	end
	f32_arg0:registerEventHandler("matchmaking_progress", CoD.PublicGameLobby.MatchmakingProgress)
	f32_arg0:registerEventHandler("matchmaking_hideprogress", CoD.PublicGameLobby.HideMatchmakingProgress)
	f32_arg0:registerEventHandler("matchmaking_clearprogress", CoD.PublicGameLobby.ClearMatchmakingProgress)
end

CoD.PublicGameLobby.MatchmakingProgress = function (f33_arg0, f33_arg1)
	if UIExpression.DvarBool(nil, "ui_detailedMM") == 1 and f33_arg0.body ~= nil and f33_arg0.body.detailedStatusText ~= nil then
		for f33_local0 = 1, 3, 1 do
			f33_arg0.body.detailedStatusText[f33_local0]:setText(f33_arg1[f33_local0])
			f33_arg0.body.detailedStatusText[f33_local0]:setAlpha(1)
		end
	end
end

CoD.PublicGameLobby.ClearMatchmakingProgress = function (f34_arg0, f34_arg1)
	if f34_arg0.body ~= nil and f34_arg0.body.detailedStatusText ~= nil then
		for f34_local0 = 1, 3, 1 do
			f34_arg0.body.detailedStatusText[f34_local0]:completeAnimation()
			f34_arg0.body.detailedStatusText[f34_local0]:beginAnimation("fade_out", 250)
			f34_arg0.body.detailedStatusText[f34_local0]:setAlpha(0)
		end
	end
	f34_arg0.body.hideMatchmakingTimer = nil
end

CoD.PublicGameLobby.HideMatchmakingProgress = function (f35_arg0, f35_arg1)
	if f35_arg0.body ~= nil and f35_arg0.body.hideMatchmakingTimer == nil then
		f35_arg0.body.hideMatchmakingTimer = LUI.UITimer.new(4000, "matchmaking_clearprogress", true, f35_arg0)
		f35_arg0.body:addElement(f35_arg0.body.hideMatchmakingTimer)
	end
end

