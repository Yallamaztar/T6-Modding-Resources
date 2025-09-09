require("T6.CoDBase")
require("T6.Lobby")
require("T6.EdgeShadow")
require("T6.Menus.Playercard")
require("T6.JoinableList")
require("T6.Error")
require("T6.Menus.CODTv")
require("T6.Menus.SignOutPopup")
require("T6.Menus.RejoinSessionPopup")
if CoD.isWIIU then
	require("T6.WiiUControllerSettings")
end
if CoD.isZombie == false and (CoD.isXBOX or CoD.isPS3) then
	require("T6.Menus.EliteAppPopup")
end
CoD.MainLobby = {}
CoD.MainLobby.ShouldPreventCreateLobby = function ()
	if UIExpression.AcceptingInvite() == 1 or 1 == Engine.IsJoiningAnotherParty() or UIExpression.PrivatePartyHost() == 0 or Engine.IsGameLobbyRunning() then
		return true
	else
		return false
	end
end

CoD.MainLobby.OnlinePlayAvailable = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = f2_arg1.controller
	if f2_arg2 == nil then
		f2_arg2 = false
	end
	if CoD.isPC and Engine.IsVacBanned() then
		local f2_local1 = f2_arg0:openPopup("Error", f2_local0)
		f2_local1:setMessage(Engine.Localize("PLATFORM_VACBANNED"))
		f2_local1.anyControllerAllowed = true
		f2_local1.callingMenu = f2_arg0
		return 0
	elseif CoD.isWIIU and Engine.IsSignedInToDemonware(contoller) == false then
		if UIExpression.IsPrimaryLocalClient(f2_local0) == 1 then
			Engine.Exec(f2_local0, "xsigninlive")
		end
		return 0
	elseif UIExpression.IsGuest(f2_local0) == 1 then
		local f2_local1 = f2_arg0:openPopup("Error", f2_local0)
		f2_local1:setMessage(Engine.Localize("XBOXLIVE_NOGUESTACCOUNTS"))
		f2_local1.anyControllerAllowed = true
	elseif UIExpression.DvarBool(f2_local0, "live_betaexpired") == 1 then
		local f2_local1 = f2_arg0:openPopup("Error", f2_local0)
		f2_local1:setMessage(Engine.Localize("MP_BETACLOSED"))
	elseif UIExpression.IsSignedInToLive(f2_local0) == 0 then
		if CoD.isPS3 or CoD.isWIIU then
			if UIExpression.IsPrimaryLocalClient(f2_local0) == 1 then
				Engine.Exec(f2_local0, "xsigninlive")
			else
				Engine.Exec(f2_local0, "signclientin")
			end
		elseif CoD.isPC then
			if 0 == UIExpression.GetUsedControllerCount() then
				Engine.Exec(f2_local0, "xsigninlivenoguests")
			else
				Engine.Exec(f2_local0, "xsigninlive")
			end
		elseif 0 == UIExpression.GetUsedControllerCount() then
			Engine.Exec(f2_local0, "xsigninlivenoguests")
		elseif UIExpression.IsSignedIn(f2_local0) == 1 then
			f2_arg0:openPopup("popup_signintolive", f2_local0)
		else
			Engine.Exec(f2_local0, "xsigninlive")
		end
	elseif (UIExpression.IsContentRatingAllowed(f2_local0) == 0 or UIExpression.IsAnyControllerMPRestricted() == 1) and not f2_arg2 then
		local f2_local1 = f2_arg0:openPopup("Error", f2_local0)
		f2_local1:setMessage(Engine.Localize("XBOXLIVE_MPNOTALLOWED"))
		f2_local1.anyControllerAllowed = true
	elseif UIExpression.IsDemonwareFetchingDone(f2_local0) == 1 then
		local f2_local1 = Engine.GetPlayerStats(f2_local0)
		f2_local1 = f2_local1.cacLoadouts.resetWarningDisplayed
		local f2_local2 = Engine.GetPlayerStats(f2_local0)
		f2_local2 = f2_local2.cacLoadouts.classWarningDisplayed
		if f2_local1:get() == 0 then
			f2_local1:set(1)
			if f2_local2 ~= nil then
				f2_local2:set(1)
			end
			local f2_local3 = f2_arg0:openPopup("Error", f2_local0)
			f2_local3:setMessage(Engine.Localize("MENU_STATS_RESET"))
			f2_local3.anyControllerAllowed = true
		elseif CoD.isZombie == false and f2_local2:get() == 0 then
			f2_local2:set(1)
			local f2_local3 = f2_arg0:openPopup("Error", f2_local0)
			f2_local3:setMessage(Engine.Localize("MENU_RESETCUSTOMCLASSES"))
			f2_local3.anyControllerAllowed = true
		else
			return 1
		end
	else
		Engine.ExecNow(nil, "initiatedemonwareconnect")
		local f2_local1 = f2_arg0:openPopup("popup_connectingdw", f2_local0)
		f2_local1.openingStore = f2_arg2
		f2_local1.callingMenu = f2_arg0
	end
	return 0
end

CoD.MainLobby.IsControllerCountValid = function (f3_arg0, f3_arg1, f3_arg2)
	if f3_arg2 < UIExpression.GetUsedControllerCount() then
		local f3_local0 = f3_arg0:openPopup("Error", f3_arg1)
		f3_local0:setMessage(Engine.Localize("XBOXLIVE_TOOMANYCONTROLLERS"))
		f3_local0.anyControllerAllowed = true
		return 0
	else
		return 1
	end
end

CoD.MainLobby.OpenPlayerMatchPartyLobby = function (f4_arg0, f4_arg1)
	if CoD.MainLobby.ShouldPreventCreateLobby() then
		return 
	elseif CoD.MainLobby.OnlinePlayAvailable(f4_arg0, f4_arg1) == 1 then
		Engine.ProbationCheckForDashboardWarning(CoD.GAMEMODE_PUBLIC_MATCH)
		local f4_local0, f4_local1 = Engine.ProbationCheckInProbation(CoD.GAMEMODE_PUBLIC_MATCH)
		if f4_local0 == true then
			f4_arg0:openPopup("popup_public_inprobation", f4_local1)
			return 
		end
		local f4_local2, f4_local3 = Engine.ProbationCheckForProbation(CoD.GAMEMODE_PUBLIC_MATCH)
		f4_local1 = f4_local3
		if f4_local2 == true then
			f4_arg0:openPopup("popup_public_givenprobation", f4_local1)
			return 
		elseif Engine.ProbationCheckParty(CoD.GAMEMODE_PUBLIC_MATCH, f4_arg1.controller) == true then
			f4_arg0:openPopup("popup_public_partyprobation", f4_arg1.controller)
			return 
		end
		f4_local2 = UIExpression.DvarInt(f4_local1, "party_maxlocalplayers_playermatch")
		if CoD.MainLobby.IsControllerCountValid(f4_arg0, f4_arg1.controller, f4_local2) == 1 then
			f4_arg0.lobbyPane.body.lobbyList.maxLocalPlayers = f4_local2
			CoD.SwitchToPlayerMatchLobby(f4_arg1.controller)
			if CoD.isZombie == true then
				Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_SELECTING_PLAYLIST)
				CoD.PlaylistCategoryFilter = "playermatch"
				f4_arg0:openMenu("SelectMapZM", f4_arg1.controller)
				CoD.GameGlobeZombie.MoveToCenter(f4_arg1.controller)
			else
				f4_arg0:openMenu("PlayerMatchPartyLobby", f4_arg1.controller)
			end
			f4_arg0:close()
		end
	end
end

CoD.MainLobby.OpenLeagueSelectionPopup = function (f5_arg0, f5_arg1)
	if CoD.MainLobby.ShouldPreventCreateLobby() then
		return 
	elseif CoD.MainLobby.OnlinePlayAvailable(f5_arg0, f5_arg1) == 1 then
		Engine.ProbationCheckForDashboardWarning(CoD.GAMEMODE_PUBLIC_MATCH)
		local f5_local0, f5_local1 = Engine.ProbationCheckInProbation(CoD.GAMEMODE_LEAGUE_MATCH)
		if f5_local0 == true then
			f5_arg0:openPopup("popup_league_inprobation", f5_local1)
			return 
		end
		local f5_local2, f5_local3 = Engine.ProbationCheckForProbation(CoD.GAMEMODE_LEAGUE_MATCH)
		f5_local1 = f5_local3
		if f5_local2 == true then
			f5_arg0:openPopup("popup_league_givenprobation", f5_local1)
			return 
		elseif Engine.ProbationCheckParty(CoD.GAMEMODE_LEAGUE_MATCH, f5_arg1.controller) == true then
			f5_arg0:openPopup("popup_league_partyprobation", f5_arg1.controller)
			return 
		end
		Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_SELECTING_PLAYLIST)
		CoD.PlaylistCategoryFilter = "leaguematch"
		f5_local2 = f5_arg0:openPopup("PlaylistSelection", f5_arg1.controller)
		f5_local2:addCategoryButtons(f5_arg1.controller)
		Engine.PlaySound("cac_screen_fade")
	end
end

CoD.MainLobby.OpenLeaguePlayPartyLobby = function (f6_arg0, f6_arg1)
	if CoD.MainLobby.ShouldPreventCreateLobby() then
		return 
	elseif CoD.MainLobby.OnlinePlayAvailable(f6_arg0, f6_arg1) == 1 then
		local f6_local0 = UIExpression.DvarInt(controller, "party_maxlocalplayers_playermatch")
		if CoD.MainLobby.IsControllerCountValid(f6_arg0, f6_arg1.controller, f6_local0) == 1 then
			f6_arg0.lobbyPane.body.lobbyList.maxLocalPlayers = f6_local0
			CoD.SwitchToLeagueMatchLobby(f6_arg1.controller)
			f6_arg0:openMenu("LeaguePlayPartyLobby", f6_arg1.controller)
			f6_arg0:close()
		end
	end
end

CoD.MainLobby.OpenCustomGamesLobby = function (f7_arg0, f7_arg1)
	if CoD.MainLobby.ShouldPreventCreateLobby() then
		return 
	elseif CoD.MainLobby.OnlinePlayAvailable(f7_arg0, f7_arg1) == 1 and CoD.MainLobby.IsControllerCountValid(f7_arg0, f7_arg1.controller, UIExpression.DvarInt(controller, "party_maxlocalplayers_privatematch")) == 1 then
		CoD.SwitchToPrivateLobby(f7_arg1.controller)
		if CoD.isZombie == true then
			Engine.SetDvar("ui_zm_mapstartlocation", "")
			f7_arg0:openMenu("SelectMapZM", f7_arg1.controller)
			CoD.GameGlobeZombie.MoveToCenter(f7_arg1.controller)
		else
			local f7_local0 = f7_arg0:openMenu("PrivateOnlineGameLobby", f7_arg1.controller)
		end
		f7_arg0:close()
	end
end

CoD.MainLobby.OpenSoloLobby_Zombie = function (f8_arg0, f8_arg1)
	if CoD.MainLobby.ShouldPreventCreateLobby() then
		return 
	elseif CoD.MainLobby.OnlinePlayAvailable(f8_arg0, f8_arg1) == 1 then
		local f8_local0 = 1
		if CoD.MainLobby.IsControllerCountValid(f8_arg0, f8_arg1.controller, f8_local0) == 1 then
			f8_arg0.lobbyPane.body.lobbyList.maxLocalPlayers = f8_local0
			CoD.SwitchToPlayerMatchLobby(f8_arg1.controller)
			Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_SELECTING_PLAYLIST)
			Dvar.party_maxplayers:set(1)
			CoD.PlaylistCategoryFilter = CoD.Zombie.PLAYLIST_CATEGORY_FILTER_SOLOMATCH
			f8_arg0:openMenu("SelectMapZM", f8_arg1.controller)
			CoD.GameGlobeZombie.MoveToCenter(f8_arg1.controller)
			f8_arg0:close()
		end
	end
end

CoD.MainLobby.OpenTheaterLobby = function (f9_arg0, f9_arg1)
	if CoD.MainLobby.ShouldPreventCreateLobby() then
		return 
	elseif UIExpression.CanSwitchToLobby(f9_arg1.controller, Dvar.party_maxplayers_theater:get(), Dvar.party_maxlocalplayers_theater:get()) == 0 then
		Dvar.ui_errorTitle:set(Engine.Localize("MENU_NOTICE_CAPS"))
		Dvar.ui_errorMessage:set(Engine.Localize("MENU_FILESHARE_MAX_LOCAL_PLAYERS"))
		CoD.Menu.OpenErrorPopup(f9_arg0, {
			controller = f9_arg1.controller
		})
		return 
	elseif Engine.CanViewContent() == false then
		f9_arg0:openPopup("popup_contentrestricted", f9_arg1.controller)
		return 
	elseif CoD.MainLobby.OnlinePlayAvailable(f9_arg0, f9_arg1) == 1 and CoD.MainLobby.IsControllerCountValid(f9_arg0, f9_arg1.controller, UIExpression.DvarInt(controller, "party_maxlocalplayers_theater")) == 1 then
		CoD.SwitchToTheaterLobby(f9_arg1.controller)
		local f9_local0 = f9_arg0:openMenu("TheaterLobby", f9_arg1.controller, {
			parent = "MainLobby"
		})
		f9_arg0:close()
	end
end

CoD.MainLobby.OpenCODTV = function (f10_arg0, f10_arg1)
	if Engine.CanViewContent() == false then
		f10_arg0:openPopup("popup_contentrestricted", f10_arg1.controller)
		return 
	elseif Engine.IsLivestreamEnabled() then
		f10_arg0:openPopup("CODTv_Error", f10_arg1.controller)
		return 
	elseif CoD.MainLobby.OnlinePlayAvailable(f10_arg0, f10_arg1) == 1 and Engine.IsCodtvContentLoaded() == true then
		CoD.perController[f10_arg1.controller].codtvRoot = "community"
		f10_arg0:openPopup("CODTv", f10_arg1.controller)
	end
end

CoD.MainLobby.OpenBarracks = function (f11_arg0, f11_arg1)
	if UIExpression.IsGuest(f11_arg1.controller) == 1 then
		f11_arg0:openPopup("popup_guest_contentrestricted", f11_arg1.controller)
		return 
	elseif CoD.MainLobby.OnlinePlayAvailable(f11_arg0, f11_arg1) == 1 then
		if CoD.isZombie == true then
			Engine.Exec(f11_arg1.controller, "party_setHostUIString ZMUI_VIEWING_LEADERBOARD")
			f11_arg0:openPopup("LeaderboardCarouselZM", f11_arg1.controller)
		else
			Engine.Exec(f11_arg1.controller, "party_setHostUIString MENU_VIEWING_PLAYERCARD")
			f11_arg0:openPopup("Barracks", f11_arg1.controller)
		end
	end
end

CoD.MainLobby.OpenStore = function (f12_arg0, f12_arg1)
	if f12_arg0.occludedBy then
		return 
	end
	Engine.SetDvar("ui_openStoreForMTX", 0)
	if Engine.CheckNetConnection() == false then
		local f12_local0 = f12_arg0:openPopup("popup_net_connection_store", f12_arg1.controller)
		f12_local0.callingMenu = f12_arg0
		return 
	elseif f12_arg0.id == "Menu.MainMenu" then
		Engine.Exec(f12_arg1.controller, "setclientbeingusedandprimary")
	end
	if CoD.MainLobby.OnlinePlayAvailable(f12_arg0, f12_arg1, true) == 1 then
		if not CoD.isPS3 or UIExpression.IsSubUser(f12_arg1.controller) ~= 1 then
			Dvar.ui_storeButtonPressed:set(true)
			CoD.perController[f12_arg1.controller].codtvRoot = "ingamestore"
			if CoD.isPC then
				Engine.ShowMarketplaceUI(f12_arg1.controller)
			else
				f12_arg0:openPopup("CODTv", f12_arg1.controller)
			end
		else
			local f12_local0 = f12_arg0:openPopup("Error", f12_arg1.controller)
			f12_local0:setMessage(Engine.Localize("MENU_SUBUSERS_NOTALLOWED"))
			f12_local0.anyControllerAllowed = true
		end
	end
end

CoD.MainLobby.OpenControlsMenu = function (f13_arg0, f13_arg1)
	f13_arg0:openPopup("WiiUControllerSettings", f13_arg1.controller, true)
end

CoD.MainLobby.OpenOptionsMenu = function (f14_arg0, f14_arg1)
	f14_arg0:openPopup("OptionsMenu", f14_arg1.controller)
end

CoD.MainLobby.UpdateButtonPaneButtonVisibilty_Multiplayer = function (f15_arg0)
	if CoD.isPartyHost() then
		f15_arg0.body.buttonList:addElement(f15_arg0.body.matchmakingButton)
		f15_arg0.body.buttonList:addElement(f15_arg0.body.leaguePlayButton)
		if not Engine.IsBetaBuild() then
			f15_arg0.body.buttonList:addElement(f15_arg0.body.customGamesButton)
		end
		f15_arg0.body.buttonList:addElement(f15_arg0.body.theaterButton)
		f15_arg0.body.buttonList:addElement(f15_arg0.body.postTheaterSpacer)
	else
		f15_arg0.body.matchmakingButton:closeAndRefocus(f15_arg0.body.codtvButton)
		f15_arg0.body.leaguePlayButton:closeAndRefocus(f15_arg0.body.codtvButton)
		if not Engine.IsBetaBuild() then
			f15_arg0.body.customGamesButton:closeAndRefocus(f15_arg0.body.codtvButton)
		end
		f15_arg0.body.theaterButton:closeAndRefocus(f15_arg0.body.codtvButton)
		f15_arg0.body.postTheaterSpacer:closeAndRefocus(f15_arg0.body.codtvButton)
	end
end

CoD.MainLobby.UpdateButtonPaneButtonVisibilty_Zombie = function (f16_arg0)
	if CoD.isPartyHost() then
		f16_arg0.body.buttonList:addElement(f16_arg0.body.matchmakingButton)
		f16_arg0.body.buttonList:addElement(f16_arg0.body.customSpacer)
		f16_arg0.body.buttonList:addElement(f16_arg0.body.customGamesButton)
		f16_arg0.body.buttonList:addElement(f16_arg0.body.theaterSpacer)
		f16_arg0.body.buttonList:addElement(f16_arg0.body.theaterButton)
		if UIExpression.DvarInt(nil, "party_playerCount") <= 1 then
			f16_arg0.body.buttonList:addElement(f16_arg0.body.soloPlayButton)
		else
			f16_arg0.body.soloPlayButton:closeAndRefocus(f16_arg0.body.theaterButton)
		end
		f16_arg0.body.buttonList:addElement(f16_arg0.body.optionSpacer)
	else
		f16_arg0.body.matchmakingButton:closeAndRefocus(f16_arg0.body.codtvButton)
		f16_arg0.body.soloPlayButton:closeAndRefocus(f16_arg0.body.codtvButton)
		f16_arg0.body.customSpacer:closeAndRefocus(f16_arg0.body.codtvButton)
		f16_arg0.body.customGamesButton:closeAndRefocus(f16_arg0.body.codtvButton)
		f16_arg0.body.theaterButton:closeAndRefocus(f16_arg0.body.codtvButton)
		f16_arg0.body.theaterSpacer:closeAndRefocus(f16_arg0.body.codtvButton)
		f16_arg0.body.optionSpacer:closeAndRefocus(f16_arg0.body.codtvButton)
	end
end

CoD.MainLobby.UpdateButtonPaneButtonVisibilty = function (f17_arg0)
	if f17_arg0 == nil or f17_arg0.body == nil then
		return 
	elseif CoD.isZombie == true then
		CoD.MainLobby.UpdateButtonPaneButtonVisibilty_Zombie(f17_arg0)
	else
		CoD.MainLobby.UpdateButtonPaneButtonVisibilty_Multiplayer(f17_arg0)
	end
	f17_arg0:setLayoutCached(false)
end

CoD.MainLobby.UpdateButtonPromptVisibility = function (f18_arg0)
	if f18_arg0 == nil then
		return 
	end
	f18_arg0:removeBackButton()
	local f18_local0 = false
	if f18_arg0.joinButton ~= nil then
		f18_arg0.joinButton:close()
		f18_local0 = true
	end
	f18_arg0.friendsButton:close()
	if f18_arg0.partyPrivacyButton ~= nil then
		f18_arg0.partyPrivacyButton:close()
	end
	f18_arg0:addBackButton()
	f18_arg0:addFriendsButton()
	if f18_local0 then
		f18_arg0:addJoinButton()
	end
	if f18_arg0.panelManager.slidingEnabled ~= true then
		f18_arg0.friendsButton:disable()
	end
	if f18_arg0.panelManager:isPanelOnscreen("buttonPane") then
		f18_arg0:addPartyPrivacyButton()
	end
	f18_arg0:addNATType()
end

CoD.MainLobby.PopulateButtons_Multiplayer = function (f19_arg0)
	if Engine.IsBetaBuild() then
		f19_arg0.body.matchmakingButton = f19_arg0.body.buttonList:addButton(Engine.Localize("MENU_MATCHMAKING_CAPS"), nil, 2)
		f19_arg0.body.leaguePlayButton = f19_arg0.body.buttonList:addButton(Engine.Localize("MENU_LEAGUE_PLAY_CAPS"), nil, 1)
	else
		f19_arg0.body.matchmakingButton = f19_arg0.body.buttonList:addButton(Engine.Localize("MENU_MATCHMAKING_CAPS"), nil, 1)
		f19_arg0.body.leaguePlayButton = f19_arg0.body.buttonList:addButton(Engine.Localize("MENU_LEAGUE_PLAY_CAPS"), nil, 2)
	end
	f19_arg0.body.matchmakingButton.hintText = Engine.Localize(CoD.MPZM("MPUI_PLAYER_MATCH_DESC", "ZMUI_PLAYER_MATCH_DESC"))
	f19_arg0.body.matchmakingButton:setActionEventName("open_player_match_party_lobby")
	CoD.SetupMatchmakingLock(f19_arg0.body.matchmakingButton)
	f19_arg0.body.leaguePlayButton.hintText = Engine.Localize("MPUI_LEAGUE_PLAY_DESC")
	f19_arg0.body.leaguePlayButton:setActionEventName("open_league_play_party_lobby")
	if not Engine.IsBetaBuild() then
		f19_arg0.body.customGamesButton = f19_arg0.body.buttonList:addButton(Engine.Localize("MENU_CUSTOMGAMES_CAPS"), nil, 3)
		f19_arg0.body.customGamesButton.hintText = Engine.Localize(CoD.MPZM("MPUI_CUSTOM_MATCH_DESC", "ZMUI_CUSTOM_MATCH_DESC"))
		f19_arg0.body.customGamesButton:setActionEventName("open_custom_games_lobby")
		CoD.SetupCustomGamesLock(f19_arg0.body.customGamesButton)
	end
	f19_arg0.body.theaterButton = f19_arg0.body.buttonList:addButton(Engine.Localize("MENU_THEATER_CAPS"), nil, 4)
	f19_arg0.body.theaterButton:setActionEventName("open_theater_lobby")
	f19_arg0.body.theaterButton.hintText = Engine.Localize(CoD.MPZM("MPUI_THEATER_DESC", "ZMUI_THEATER_DESC"))
	f19_arg0.body.postTheaterSpacer = f19_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2, 5)
	if Engine.IsBetaBuild() then
		f19_arg0.body.codtvButton = f19_arg0.body.buttonList:addButton(Engine.Localize("MENU_FILESHARE_COMMUNITY_CAPS"), nil, 6)
	else
		f19_arg0.body.codtvButton = f19_arg0.body.buttonList:addButton(Engine.Localize("MENU_COD_TV_CAPS"), nil, 6)
	end
	f19_arg0.body.codtvButton.hintText = Engine.Localize("MPUI_COD_TV_DESC")
	f19_arg0.body.codtvButton:setActionEventName("open_cod_tv")
	if not Engine.IsBetaBuild() then
		f19_arg0.body.barracksButton = f19_arg0.body.buttonList:addButton(Engine.Localize("MENU_BARRACKS_CAPS"), nil, 7)
		f19_arg0.body.barracksButton.id = "CoD9Button" .. "." .. "MainLobby" .. "." .. Engine.Localize("MENU_BARRACKS_CAPS")
		CoD.SetupBarracksLock(f19_arg0.body.barracksButton)
		CoD.SetupBarracksNew(f19_arg0.body.barracksButton)
		f19_arg0.body.barracksButton:setActionEventName("open_barracks")
	end
	if CoD.isZombie == false and not Engine.IsBetaBuild() and (CoD.isXBOX or CoD.isPS3) and Engine.IsEliteAvailable() and Engine.IsEliteButtonAvailable() then
		f19_arg0.body.eliteAppButton = f19_arg0.body.buttonList:addButton(Engine.Localize("MENU_ELITE_CAPS"), nil, 8)
		f19_arg0.body.eliteAppButton.hintText = Engine.Localize("MENU_ELITE_DESC")
		f19_arg0.body.eliteAppButton:setActionEventName("open_eliteapp_popup")
	end
	f19_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2, 8)
	f19_arg0.body.optionsButton = f19_arg0.body.buttonList:addButton(Engine.Localize("MENU_OPTIONS_CAPS"), nil, 11)
	f19_arg0.body.optionsButton.hintText = Engine.Localize("MPUI_OPTIONS_DESC")
	f19_arg0.body.optionsButton:setActionEventName("open_options_menu")
	if not CoD.isWIIU and Dvar.ui_inGameStoreVisible:get() == true and (CoD.isPS3 ~= true or CoD.isZombie ~= true) then
		f19_arg0.body.ingameStoreButton = f19_arg0.body.buttonList:addButton(Engine.Localize("MENU_INGAMESTORE"), nil, 12)
		if CoD.isPC then
			f19_arg0.body.ingameStoreButton.hintText = Engine.Localize("PLATFORM_STORE_DESC")
		else
			f19_arg0.body.ingameStoreButton.hintText = Engine.Localize("MENU_STORE_DESC")
		end
		f19_arg0.body.ingameStoreButton:setActionEventName("open_store")
	end
end

CoD.MainLobby.PopulateButtons_Zombie = function (f20_arg0)
	f20_arg0.body.matchmakingButton = f20_arg0.body.buttonList:addButton(Engine.Localize("MENU_MATCHMAKING_CAPS"), nil, 1)
	f20_arg0.body.matchmakingButton.hintText = Engine.Localize(CoD.MPZM("MPUI_PLAYER_MATCH_DESC", "ZMUI_PLAYER_MATCH_DESC"))
	f20_arg0.body.matchmakingButton:setActionEventName("open_player_match_party_lobby")
	CoD.SetupMatchmakingLock(f20_arg0.body.matchmakingButton)
	f20_arg0.body.soloPlayButton = f20_arg0.body.buttonList:addButton(Engine.Localize("ZMUI_SOLO_PLAY_CAPS"), nil, 2)
	f20_arg0.body.soloPlayButton.hintText = Engine.Localize("ZMUI_SOLO_PLAY_DESC")
	f20_arg0.body.soloPlayButton:setActionEventName("open_solo_lobby_zombie")
	f20_arg0.body.customSpacer = f20_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2, 3)
	f20_arg0.body.customGamesButton = f20_arg0.body.buttonList:addButton(Engine.Localize("MENU_CUSTOMGAMES_CAPS"), nil, 4)
	f20_arg0.body.customGamesButton.hintText = Engine.Localize(CoD.MPZM("MPUI_CUSTOM_MATCH_DESC", "ZMUI_CUSTOM_MATCH_DESC"))
	f20_arg0.body.customGamesButton:setActionEventName("open_custom_games_lobby")
	CoD.SetupCustomGamesLock(f20_arg0.body.customGamesButton)
	f20_arg0.body.theaterButton = f20_arg0.body.buttonList:addButton(Engine.Localize("MENU_THEATER_CAPS"), nil, 5)
	f20_arg0.body.theaterButton:setActionEventName("open_theater_lobby")
	f20_arg0.body.theaterButton.hintText = Engine.Localize(CoD.MPZM("MPUI_THEATER_DESC", "ZMUI_THEATER_DESC"))
	f20_arg0.body.theaterSpacer = f20_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2, 6)
	if Engine.IsBetaBuild() then
		f20_arg0.body.codtvButton = f20_arg0.body.buttonList:addButton(Engine.Localize("MENU_FILESHARE_COMMUNITY_CAPS"), nil, 7)
	else
		f20_arg0.body.codtvButton = f20_arg0.body.buttonList:addButton(Engine.Localize("MENU_COD_TV_CAPS"), nil, 7)
	end
	f20_arg0.body.codtvButton.hintText = Engine.Localize("MPUI_COD_TV_DESC")
	f20_arg0.body.codtvButton:setActionEventName("open_cod_tv")
	f20_arg0.body.barracksButton = f20_arg0.body.buttonList:addButton(Engine.Localize("MPUI_LEADERBOARDS_CAPS"), nil, 8)
	CoD.SetupBarracksLock(f20_arg0.body.barracksButton)
	f20_arg0.body.barracksButton:setActionEventName("open_barracks")
	f20_arg0.body.optionSpacer = f20_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2, 9)
	f20_arg0.body.optionsButton = f20_arg0.body.buttonList:addButton(Engine.Localize("MENU_OPTIONS_CAPS"), nil, 10)
	f20_arg0.body.optionsButton.hintText = Engine.Localize("MPUI_OPTIONS_DESC")
	f20_arg0.body.optionsButton:setActionEventName("open_options_menu")
	if Dvar.ui_inGameStoreVisible:get() == true and (CoD.isPS3 ~= true or CoD.isZombie ~= true) then
		f20_arg0.body.ingameStoreButton = f20_arg0.body.buttonList:addButton(Engine.Localize("MENU_INGAMESTORE"), nil, 11)
		if CoD.isPC then
			f20_arg0.body.ingameStoreButton.hintText = Engine.Localize("PLATFORM_STORE_DESC")
		else
			f20_arg0.body.ingameStoreButton.hintText = Engine.Localize("MENU_STORE_DESC")
		end
		f20_arg0.body.ingameStoreButton:setActionEventName("open_store")
	end
end

CoD.MainLobby.PopulateButtons = function (f21_arg0)
	if CoD.isZombie == true then
		CoD.MainLobby.PopulateButtons_Zombie(f21_arg0)
	else
		CoD.MainLobby.PopulateButtons_Multiplayer(f21_arg0)
	end
	if CoD.isWIIU then
		f21_arg0.body.controlsButton = f21_arg0.body.buttonList:addButton(Engine.Localize("MENU_CONTROLLER_SETTINGS_CAPS"), nil, 9)
		f21_arg0.body.controlsButton.hintText = Engine.Localize("MENU_CONTROLLER_SETTINGS_DESC")
		f21_arg0.body.controlsButton:setActionEventName("open_controls_menu")
	end
	if CoD.isOnlineGame() then
		if f21_arg0.playerCountLabel == nil then
			f21_arg0.playerCountLabel = LUI.UIText.new()
			f21_arg0:addElement(f21_arg0.playerCountLabel)
		end
		f21_arg0.playerCountLabel:setLeftRight(true, false, 0, 0)
		f21_arg0.playerCountLabel:setTopBottom(false, true, -30 - CoD.textSize.Big, -30)
		f21_arg0.playerCountLabel:setFont(CoD.fonts.Big)
		f21_arg0.playerCountLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		local f21_local0 = CoD.Menu.GetOnlinePlayerCountText()
		local f21_local1 = nil
		if f21_local0 ~= "" then
			f21_arg0.playerCountLabel:setText(f21_local0)
			f21_local1 = LUI.UITimer.new(60000, "update_online_player_count", false, f21_arg0.playerCountLabel)
		else
			f21_local1 = LUI.UITimer.new(1000, "update_online_player_count", false, f21_arg0.playerCountLabel)
		end
		f21_arg0.playerCountLabel:registerEventHandler("update_online_player_count", CoD.MainLobby.UpdateOnlinePlayerCount)
		f21_arg0.playerCountLabel.timer = f21_local1
		f21_arg0:addElement(f21_local1)
	end
end

CoD.MainLobby.UpdateOnlinePlayerCount = function (f22_arg0)
	if CoD.isOnlineGame() then
		local f22_local0 = CoD.Menu.GetOnlinePlayerCountText()
		if f22_local0 ~= "" then
			f22_arg0:setText(f22_local0)
			f22_arg0.timer.interval = 60000
			f22_arg0.timer:reset()
		end
	end
end

CoD.MainLobby.FirstSignedInToLive = function (f23_arg0)
	if f23_arg0 ~= nil then
		if CoD.isXBOX then
			f23_arg0.anyControllerAllowed = false
		end
		if f23_arg0.friendsButton == nil then
			f23_arg0:addFriendsButton()
		end
	end
end

CoD.MainLobby.LastSignedOutOfLive = function (f24_arg0)
	if f24_arg0 ~= nil and CoD.isXBOX then
		f24_arg0.anyControllerAllowed = true
	end
end

CoD.MainLobby.PlayerSelected = function (f25_arg0, f25_arg1)
	if f25_arg1.joinable ~= nil and CoD.canJoinSession(UIExpression.GetPrimaryController(), f25_arg1.playerXuid) then
		if f25_arg0.joinButton == nil and not f25_arg0.m_blockJoinButton then
			f25_arg0:addJoinButton()
			f25_arg0:addNATType()
		end
	elseif f25_arg0.joinButton ~= nil then
		f25_arg0.joinButton:close()
		f25_arg0.joinButton = nil
	end
	f25_arg0:dispatchEventToChildren(f25_arg1)
end

CoD.MainLobby.PlayerDeselected = function (f26_arg0, f26_arg1)
	if f26_arg0.joinButton ~= nil then
		f26_arg0.joinButton:close()
		f26_arg0.joinButton = nil
	end
	f26_arg0:dispatchEventToChildren(f26_arg1)
end

CoD.MainLobby.CurrentPanelChanged = function (f27_arg0, f27_arg1)
	if CoD.isPC then
		f27_arg0.m_blockJoinButton = f27_arg1.id ~= "PanelManager.lobbyPane"
	end
end

CoD.MainLobby.BusyList_Update = function (f28_arg0, f28_arg1, f28_arg2, f28_arg3, f28_arg4)
	CoD.PlayerList.Update(f28_arg0, Engine.GetBusyFriendsOfAllLocalPlayers(f28_arg0.maxRows - f28_arg2), f28_arg2, f28_arg3, f28_arg4)
end

CoD.MainLobby.Update = function (f29_arg0, f29_arg1)
	if f29_arg0 == nil then
		return 
	elseif UIExpression.IsDemonwareFetchingDone(f29_arg1.controller) == 1 == true then
		f29_arg0.panelManager:processEvent({
			name = "fetching_done"
		})
	end
	CoD.MainLobby.UpdateButtonPaneButtonVisibilty(f29_arg0.buttonPane)
	CoD.MainLobby.UpdateButtonPromptVisibility(f29_arg0)
	f29_arg0:dispatchEventToChildren(f29_arg1)
end

CoD.MainLobby.ClientLeave = function (f30_arg0, f30_arg1)
	Engine.ExecNow(f30_arg1.controller, "leaveAllParties")
	Engine.PartyHostClearUIState()
	CoD.StartMainLobby(f30_arg1.controller)
	CoD.MainLobby.UpdateButtonPaneButtonVisibilty(f30_arg0.buttonPane)
	CoD.MainLobby.UpdateButtonPromptVisibility()
end

CoD.MainLobby.GoBack = function (f31_arg0, f31_arg1)
	Engine.SessionModeResetModes()
	Engine.Exec(controller, "xstopprivateparty")
	if CoD.isPS3 then
		Engine.Exec(f31_arg1.controller, "signoutSubUsers")
	end
	f31_arg0:setPreviousMenu("MainMenu")
	CoD.Menu.goBack(f31_arg0, f31_arg1.controller)
end

CoD.MainLobby.Back = function (f32_arg0, f32_arg1)
	local f32_local0, f32_local1 = nil
	if CoD.Lobby.OpenSignOutPopup(f32_arg0, f32_arg1) == true then
		return 
	elseif UIExpression.IsPrimaryLocalClient(f32_arg1.controller) == 0 then
		Engine.Exec(f32_arg1.controller, "signclientout")
		f32_arg0:processEvent({
			name = "controller_backed_out"
		})
		return 
	elseif UIExpression.AloneInPartyIgnoreSplitscreen(f32_arg1.controller, 1) == 0 then
		local f32_local2 = {
			params = {}
		}
		if not CoD.isPartyHost() then
			f32_local2.titleText = Engine.Localize("MENU_LEAVE_LOBBY_TITLE")
			f32_local2.messageText = Engine.Localize("MENU_LEAVE_LOBBY_CLIENT_WARNING")
			table.insert(f32_local2.params, {
				leaveHandler = CoD.MainLobby.ClientLeave,
				leaveEvent = "client_leave",
				leaveText = Engine.Localize("MENU_LEAVE_LOBBY_AND_PARTY"),
				debugHelper = "You're a client of a private party, remove you from the party"
			})
		else
			f32_local2.titleText = Engine.Localize("MENU_DISBAND_PARTY_TITLE")
			f32_local2.messageText = Engine.Localize("MENU_DISBAND_PARTY_HOST_WARNING")
			table.insert(f32_local2.params, {
				leaveHandler = CoD.MainLobby.GoBack,
				leaveEvent = "host_leave",
				leaveText = Engine.Localize("MENU_LEAVE_AND_DISBAND_PARTY"),
				debugHelper = "You're the leader of a private party, choosing this will disband your party"
			})
		end
		CoD.Lobby.ConfirmLeave(f32_arg0, f32_arg1.controller, f32_local0, f32_local1, f32_local2)
	else
		CoD.MainLobby.GoBack(f32_arg0, f32_arg1)
	end
end

CoD.MainLobby.AddLobbyPaneElements = function (f33_arg0, f33_arg1)
	CoD.LobbyPanes.addLobbyPaneElements(f33_arg0, f33_arg1, UIExpression.DvarInt(nil, "party_maxlocalplayers_mainlobby"))
	f33_arg0.body.lobbyList.joinableList = CoD.JoinableList.New({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = 0
	}, false, "", "joinableList", f33_arg0.id)
	f33_arg0.body.lobbyList.joinableList.pane = f33_arg0
	f33_arg0.body.lobbyList.joinableList.maxRows = CoD.MaxPlayerListRows - 2
	f33_arg0.body.lobbyList.joinableList.statusText = Engine.Localize("MENU_PLAYERLIST_FRIENDS_PLAYING")
	f33_arg0.body.lobbyList:addElement(f33_arg0.body.lobbyList.joinableList)
end

CoD.MainLobby.ButtonListButtonGainFocus = function (f34_arg0, f34_arg1)
	f34_arg0:dispatchEventToParent({
		name = "add_party_privacy_button"
	})
	CoD.Lobby.ButtonListButtonGainFocus(f34_arg0, f34_arg1)
end

CoD.MainLobby.ButtonListAddButton = function (f35_arg0, f35_arg1, f35_arg2, f35_arg3)
	local f35_local0 = CoD.Lobby.ButtonListAddButton(f35_arg0, f35_arg1, f35_arg2, f35_arg3)
	f35_local0:registerEventHandler("gain_focus", CoD.MainLobby.ButtonListButtonGainFocus)
	return f35_local0
end

CoD.MainLobby.AddButtonPaneElements = function (f36_arg0)
	CoD.LobbyPanes.addButtonPaneElements(f36_arg0)
	f36_arg0.body.buttonList.addButton = CoD.MainLobby.ButtonListAddButton
end

CoD.MainLobby.PopulateButtonPaneElements = function (f37_arg0)
	CoD.MainLobby.PopulateButtons(f37_arg0)
	CoD.MainLobby.UpdateButtonPaneButtonVisibilty(f37_arg0)
end

CoD.MainLobby.GoToFindingGames_Zombie = function (f38_arg0, f38_arg1)
	Engine.Exec(f38_arg1.controller, "xstartparty")
	Engine.Exec(f38_arg1.controller, "updategamerprofile")
	local f38_local0 = f38_arg0:openMenu("PublicGameLobby", f38_arg1.controller)
	f38_local0:setPreviousMenu("MainLobby")
	f38_local0:registerAnimationState("hide", {
		alpha = 0
	})
	f38_local0:animateToState("hide")
	f38_local0:registerAnimationState("show", {
		alpha = 1
	})
	f38_local0:animateToState("show", 500)
	f38_arg0:close()
end

CoD.MainLobby.ButtonPromptJoin = function (f39_arg0, f39_arg1)
	if UIExpression.IsGuest(f39_arg1.controller) == 1 then
		local f39_local0 = f39_arg0:openPopup("Error", controller)
		f39_local0:setMessage(Engine.Localize("XBOXLIVE_NOGUESTACCOUNTS"))
		f39_local0.anyControllerAllowed = true
		return 
	end
	local f39_local0 = f39_arg0.lobbyPane.body.lobbyList.selectedPlayerXuid
	if f39_local0 ~= nil then
		Engine.SetDvar("selectedPlayerXuid", f39_local0)
		CoD.joinPlayer(f39_arg1.controller, f39_local0)
	end
end

LUI.createMenu.MainLobby = function (f40_arg0)
	local f40_local0 = Engine.Localize(CoD.MPZM("MENU_MULTIPLAYER_CAPS", "MENU_ZOMBIES_CAPS"))
	local f40_local1 = CoD.Lobby.New("MainLobby", f40_arg0, nil, f40_local0)
	f40_local1.controller = f40_arg0
	f40_local1.anyControllerAllowed = true
	f40_local1:setPreviousMenu("MainMenu")
	if CoD.isPC then
		f40_local1.m_blockJoinButton = true
	end
	if CoD.isZombie == true then
		Engine.Exec(f40_arg0, "xsessionupdate")
		f40_local1:registerEventHandler("open_solo_lobby_zombie", CoD.MainLobby.OpenSoloLobby_Zombie)
		f40_local1:registerEventHandler("restartMatchmaking", CoD.MainLobby.GoToFindingGames_Zombie)
		Engine.SetDvar("party_readyPercentRequired", 0)
	elseif (CoD.isXBOX or CoD.isPS3) and Engine.IsEliteAvailable() and Engine.IsEliteButtonAvailable() then
		f40_local1:registerEventHandler("open_eliteapp_popup", CoD.MainLobby.OpenEliteAppPopup)
		f40_local1:registerEventHandler("elite_registration_ended", CoD.MainLobby.elite_registration_ended)
	end
	f40_local1:addTitle(f40_local0)
	f40_local1.addButtonPaneElements = CoD.MainLobby.AddButtonPaneElements
	f40_local1.populateButtonPaneElements = CoD.MainLobby.PopulateButtonPaneElements
	f40_local1.addLobbyPaneElements = CoD.MainLobby.AddLobbyPaneElements
	f40_local1:updatePanelFunctions()
	f40_local1:registerEventHandler("partylobby_update", CoD.MainLobby.Update)
	f40_local1:registerEventHandler("button_prompt_back", CoD.MainLobby.Back)
	f40_local1:registerEventHandler("first_signed_in", CoD.MainLobby.FirstSignedInToLive)
	f40_local1:registerEventHandler("last_signed_out", CoD.MainLobby.LastSignedOutOfLive)
	f40_local1:registerEventHandler("player_selected", CoD.MainLobby.PlayerSelected)
	f40_local1:registerEventHandler("player_deselected", CoD.MainLobby.PlayerDeselected)
	f40_local1:registerEventHandler("current_panel_changed", CoD.MainLobby.CurrentPanelChanged)
	f40_local1:registerEventHandler("open_player_match_party_lobby", CoD.MainLobby.OpenPlayerMatchPartyLobby)
	f40_local1:registerEventHandler("open_league_play_party_lobby", CoD.MainLobby.OpenLeagueSelectionPopup)
	f40_local1:registerEventHandler("playlist_selected", CoD.MainLobby.OpenLeaguePlayPartyLobby)
	f40_local1:registerEventHandler("open_custom_games_lobby", CoD.MainLobby.OpenCustomGamesLobby)
	f40_local1:registerEventHandler("open_theater_lobby", CoD.MainLobby.OpenTheaterLobby)
	f40_local1:registerEventHandler("open_cod_tv", CoD.MainLobby.OpenCODTV)
	f40_local1:registerEventHandler("open_barracks", CoD.MainLobby.OpenBarracks)
	if CoD.isWIIU then
		f40_local1:registerEventHandler("open_controls_menu", CoD.MainLobby.OpenControlsMenu)
	end
	f40_local1:registerEventHandler("open_options_menu", CoD.MainLobby.OpenOptionsMenu)
	f40_local1:registerEventHandler("open_session_rejoin_popup", CoD.MainLobby.OpenSessionRejoinPopup)
	f40_local1:registerEventHandler("button_prompt_join", CoD.MainLobby.ButtonPromptJoin)
	f40_local1:registerEventHandler("open_store", CoD.MainLobby.OpenStore)
	f40_local1.lobbyPane.body.lobbyList:setSplitscreenSignInAllowed(true)
	CoD.MainLobby.PopulateButtons(f40_local1.buttonPane)
	CoD.MainLobby.UpdateButtonPaneButtonVisibilty(f40_local1.buttonPane)
	CoD.MainLobby.UpdateButtonPromptVisibility(f40_local1)
	if CoD.useController then
		if CoD.isZombie then
			f40_local1.buttonPane.body.buttonList:selectElementIndex(1)
		elseif not f40_local1.buttonPane.body.buttonList:restoreState() then
			if CoD.isPartyHost() then
				if Engine.IsBetaBuild() then
					f40_local1.buttonPane.body.leaguePlayButton:processEvent({
						name = "gain_focus"
					})
				else
					f40_local1.buttonPane.body.matchmakingButton:processEvent({
						name = "gain_focus"
					})
				end
			else
				f40_local1.buttonPane.body.theaterButton:processEvent({
					name = "gain_focus"
				})
			end
		end
	end
	f40_local1.categoryInfo = CoD.Lobby.CreateInfoPane()
	f40_local1.playlistInfo = CoD.Lobby.CreateInfoPane()
	f40_local1.lobbyPane.body:close()
	f40_local1.lobbyPane.body = nil
	CoD.MainLobby.AddLobbyPaneElements(f40_local1.lobbyPane, Engine.Localize("MENU_PARTY_CAPS"))
	if 1 == UIExpression.AnySignedInToLive() then
		CoD.MainLobby.FirstSignedInToLive(f40_local1)
	else
		CoD.MainLobby.LastSignedOutOfLive(f40_local1)
	end
	Engine.SystemNeedsUpdate(nil, "party")
	if CoD.isPS3 then
		f40_local1.anyControllerAllowed = false
	end
	if not CoD.isZombie then
		CoD.CheckClasses.CheckClasses()
	end
	Engine.SessionModeSetOnlineGame(true)
	return f40_local1
end

CoD.MainLobby.OpenSessionRejoinPopup = function (f41_arg0, f41_arg1)
	f41_arg0:openPopup("RejoinSessionPopup", f41_arg1.controller)
end

CoD.MainLobby.elite_registration_ended = function (f42_arg0, f42_arg1)
	if UIExpression.IsGuest(f42_arg1.controller) == 1 then
		f42_arg0:openPopup("popup_guest_contentrestricted", f42_arg1.controller)
		return 
	elseif Engine.IsPlayerEliteRegistered(f42_arg1.controller) then
		if Engine.ELaunchAppSearch(f42_arg1.controller) then
			local f42_local0 = f42_arg0:openPopup("EliteAppLaunchExecPopup", f42_arg1.controller)
		else
			local f42_local0 = f42_arg0:openPopup("EliteAppDownloadPopup", f42_arg1.controller)
		end
	end
end

CoD.MainLobby.OpenEliteAppPopup = function (f43_arg0, f43_arg1)
	if UIExpression.IsGuest(f43_arg1.controller) == 1 then
		f43_arg0:openPopup("popup_guest_contentrestricted", f43_arg1.controller)
		return 
	elseif Engine.IsPlayerEliteRegistered(f43_arg1.controller) then
		if Engine.ELaunchAppSearch(f43_arg1.controller) then
			local f43_local0 = f43_arg0:openPopup("EliteAppLaunchExecPopup", f43_arg1.controller)
		else
			local f43_local0 = f43_arg0:openPopup("EliteAppDownloadPopup", f43_arg1.controller)
		end
	else
		local f43_local0 = f43_arg0:openPopup("EliteRegistrationPopup", f43_arg1.controller)
	end
end

