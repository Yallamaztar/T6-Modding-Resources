require("T6.DualButtonPrompt")
require("T6.GameLobby")
require("T6.MapInfoImage")
require("T6.MapVoter")
require("T6.Menus.CustomClassGameOptions")
require("T6.Menus.EditDefaultClasses")
require("T6.Menus.EditGameOptionsPopup")
require("T6.Menus.EditGeneralOptionsMenu")
require("T6.Menus.EditModeSpecificOptionsMenu")
require("T6.Menus.ViewGameOptionsPopup")
CoD.PrivateGameLobby = {}
CoD.PrivateGameLobby.DefaultSetupGameFlyoutLeft = 140
require("T6.Menus.PrivateGameLobby_Project")
CoD.PrivateGameLobby.UpdateButtonPaneButtonVisibility = function (f1_arg0)
	if f1_arg0 == nil or f1_arg0.body == nil then
		return 
	elseif f1_arg0.body.mapInfoImage ~= nil then
		f1_arg0.body.mapInfoImage:update(Dvar.ui_mapname:get(), Dvar.ui_gametype:get())
	end
end

CoD.PrivateGameLobby.UpdateHostButtons = function (f2_arg0)
	f2_arg0:processEvent({
		name = "button_update"
	})
end

CoD.PrivateGameLobby.Button_UpdateHostButton = function (f3_arg0)
	if Engine.PartyHostIsReadyToStart() == true then
		f3_arg0:disable()
	else
		f3_arg0:enable()
	end
end

CoD.PrivateGameLobby.ShouldDisableStartButton_Zombie = function (f4_arg0, f4_arg1)
	local f4_local0 = false
	local f4_local1 = UIExpression.DvarString(nil, "ui_gametype")
	local f4_local2 = Engine.PartyGetPlayerCount()
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == true and f4_local2 > 2 then
		if true == Dvar.r_dualPlayEnable:get() then
			f4_local0 = true
			f4_arg0.hintText = Engine.Localize("ZMUI_START_MATCH_DUALVIEW_DISABLED_DESC", CoD.Zombie.GameTypeGroups[f4_local1].maxPlayers)
		elseif true == Dvar.r_stereo3DOn:get() then
			f4_local0 = true
			f4_arg0.hintText = Engine.Localize("ZMUI_START_MATCH_STEREOSCOPIC3D_DISABLED_DESC", CoD.Zombie.GameTypeGroups[f4_local1].maxPlayers)
		else
			f4_arg0.hintText = Engine.Localize("MPUI_START_MATCH_DESC")
		end
		if f4_local0 == true then
			return f4_local0
		end
	end
	if f4_local1 == CoD.Zombie.GAMETYPE_ZGRIEF then
		local f4_local3 = Engine.PartyGetTeamMemberCount(CoD.TEAM_ALLIES)
		local f4_local4 = Engine.PartyGetTeamMemberCount(CoD.TEAM_AXIS)
		if CoD.Zombie.GameTypeGroups[f4_local1].maxTeamPlayers < f4_local3 or CoD.Zombie.GameTypeGroups[f4_local1].maxTeamPlayers < f4_local4 then
			f4_local0 = true
			f4_arg0.hintText = Engine.Localize("ZMUI_START_MATCH_MAX_TEAM_PLAYERS_DESC", CoD.Zombie.GameTypeGroups[f4_local1].maxTeamPlayers)
		elseif f4_local3 < CoD.Zombie.GameTypeGroups[f4_local1].minTeamPlayers or f4_local4 < CoD.Zombie.GameTypeGroups[f4_local1].minTeamPlayers then
			f4_local0 = true
			f4_arg0.hintText = Engine.Localize("ZMUI_START_MATCH_MIN_TEAM_PLAYERS_DESC")
		else
			f4_arg0.hintText = Engine.Localize("MPUI_START_MATCH_DESC")
		end
	elseif CoD.Zombie.GameTypeGroups[f4_local1].maxPlayers < f4_local2 then
		f4_local0 = true
		f4_arg0.hintText = Engine.Localize("ZMUI_START_MATCH_MAX_TOTAL_PLAYERS_DESC", CoD.Zombie.GameTypeGroups[f4_local1].maxPlayers)
	elseif f4_local2 < CoD.Zombie.GameTypeGroups[f4_local1].minPlayers then
		f4_local0 = true
		f4_arg0.hintText = Engine.Localize("ZMUI_START_MATCH_MIN_TOTAL_PLAYERS_DESC", CoD.Zombie.GameTypeGroups[f4_local1].minPlayers)
	else
		f4_arg0.hintText = Engine.Localize("MPUI_START_MATCH_DESC")
	end
	return f4_local0
end

CoD.PrivateGameLobby.Button_GameLobbyUpdate = function (f5_arg0, f5_arg1)
	local f5_local0 = Engine.PartyHostIsReadyToStart()
	local f5_local1 = Engine.DoesPartyHaveDLCForMap(Dvar.ui_mapname:get())
	if CoD.isZombie == true then
		if not f5_local0 then
			if f5_local1 then
				f5_local0 = CoD.PrivateGameLobby.ShouldDisableStartButton_Zombie(f5_arg0, f5_arg1)
			else
				f5_local0 = true
			end
		end
	elseif not f5_local0 then
		f5_local0 = not f5_local1
	end
	if f5_local0 == true then
		f5_arg0:disable()
	else
		f5_arg0:enable()
	end
	if UIExpression.PrivatePartyHost() == 1 and (Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) or Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH)) then
		Engine.Exec(f5_arg1.controller, "getLatestWAD")
	end
	f5_arg0:dispatchEventToChildren(f5_arg1)
end

CoD.PrivateGameLobby.IsHost = function (f6_arg0, f6_arg1)
	if UIExpression.InLobby(f6_arg1) ~= 1 then
		return true
	elseif UIExpression.GameHost(f6_arg1) == 1 then
		return true
	else
		return false
	end
end

CoD.PrivateGameLobby.Button_StartMatchCanceled = function (f7_arg0, f7_arg1)
	f7_arg0:enable()
	if f7_arg0.checkGameTimer then
		f7_arg0.checkGameTimer:close()
		f7_arg0.checkGameTimer = nil
	end
end

CoD.PrivateGameLobby.IsGameValid = function (f8_arg0, f8_arg1)
	local f8_local0 = false
	if CoD.isZombie then
		f8_local0 = CoD.PrivateGameLobby.ShouldDisableStartButton_Zombie({})
	end
	if f8_local0 then
		f8_arg0:dispatchEventToParent({
			name = "cancel_start_game"
		})
	end
end

CoD.PrivateGameLobby.PopulateButtons = function (f9_arg0)
	if f9_arg0.body == nil then
		return 
	end
	f9_arg0.body.buttonList:removeAllButtons()
	f9_arg0.body.widestButtonTextWidth = CoD.PrivateGameLobby.DefaultSetupGameFlyoutLeft
	local f9_local0 = CoD.PrivateGameLobby.IsHost(f9_arg0, f9_arg0.panelManager.m_ownerController)
	if f9_local0 == true then
		f9_arg0.body.startMatchButton = f9_arg0.body.buttonList:addButton(Engine.Localize("MPUI_START_MATCH_CAPS"))
		f9_arg0.body.startMatchButton.hintText = Engine.Localize("MPUI_START_MATCH_DESC")
		f9_arg0.body.startMatchButton:registerEventHandler("button_action", CoD.PrivateGameLobby.Button_StartMatch)
		f9_arg0.body.startMatchButton:registerEventHandler("start_game", f9_arg0.body.startMatchButton.disable)
		f9_arg0.body.startMatchButton:registerEventHandler("cancel_start_game", CoD.PrivateGameLobby.Button_StartMatchCanceled)
		f9_arg0.body.startMatchButton:registerEventHandler("gamelobby_update", CoD.PrivateGameLobby.Button_GameLobbyUpdate)
		f9_arg0.body.startMatchButton:registerEventHandler("check_game_is_valid", CoD.PrivateGameLobby.IsGameValid)
		f9_arg0.body.gameModeInfo = CoD.Lobby.CreateInfoPane()
		f9_arg0.defaultFocusButton = f9_arg0.body.startMatchButton
		if true == Engine.PartyHostIsReadyToStart() or true ~= Engine.DoesPartyHaveDLCForMap(Dvar.ui_mapname:get()) then
			f9_arg0.body.startMatchButton:disable()
		else
			f9_arg0.body.startMatchButton:enable()
		end
	end
	CoD.PrivateGameLobby.PopulateButtons_Project(f9_arg0, f9_local0)
	if f9_local0 == false then
		f9_arg0.defaultFocusButton = f9_arg0.body.createAClassButton
	end
	CoD.PrivateGameLobby.UpdateHostButtons(f9_arg0)
	if f9_arg0.body.mapInfoImage ~= nil then
		f9_arg0.body.mapInfoImage:close()
	end
	local f9_local1 = 350 - CoD.CoD9Button.Height - 0
	local f9_local2 = f9_local1 / CoD.MapInfoImage.AspectRatio
	f9_arg0.body.mapInfoImage = CoD.MapInfoImage.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f9_local1,
		topAnchor = false,
		bottomAnchor = true,
		top = -f9_local2 - CoD.ButtonPrompt.Height - 15,
		bottom = -CoD.ButtonPrompt.Height - 15
	})
	f9_arg0.body.mapInfoImage:setPriority(200)
	f9_arg0.body.mapInfoImage.controller = f9_arg0.controller
	f9_arg0.body:addElement(f9_arg0.body.mapInfoImage)
	CoD.PrivateGameLobby.AddDLCWarning(f9_arg0, f9_local0)
	CoD.GameLobby.PopulateButtons(f9_arg0, f9_local2)
	if not CoD.isZombie and not f9_arg0:restoreState() and CoD.useController == true and f9_arg0.defaultFocusButton ~= nil then
		f9_arg0.defaultFocusButton:processEvent({
			name = "gain_focus"
		})
	end
	CoD.PrivateGameLobby.UpdateButtonPaneButtonVisibility(f9_arg0)
end

CoD.PrivateGameLobby.AddDLCWarning = function (f10_arg0, f10_arg1)
	if f10_arg0.body.mapInfoImage.dlcWarningContainer ~= nil then
		f10_arg0.body.mapInfoImage.dlcWarningContainer:close()
		f10_arg0.body.mapInfoImage.dlcWarningContainer = nil
	end
	local f10_local0 = 40
	local Widget = LUI.UIElement.new()
	if CoD.isZombie == true then
		Widget:setLeftRight(true, false, CoD.MapInfoImage.MapImageLeft * 2, CoD.MapInfoImage.MapImageWidth - 2)
		Widget:setTopBottom(false, true, CoD.MapInfoImage.MapImageBottom - CoD.MapInfoImage.MapImageHeight + 6, CoD.MapInfoImage.MapImageBottom + f10_local0)
	else
		Widget:setLeftRight(true, false, CoD.MapInfoImage.MapImageLeft, CoD.MapInfoImage.MapImageLeft + CoD.MapInfoImage.MapImageWidth)
		Widget:setTopBottom(false, true, CoD.MapInfoImage.MapImageBottom - CoD.MapInfoImage.MapImageHeight, CoD.MapInfoImage.MapImageBottom)
	end
	Widget:setAlpha(0)
	f10_arg0.body.mapInfoImage:addElement(Widget)
	f10_arg0.body.mapInfoImage.dlcWarningContainer = Widget
	Widget.warningBG = LUI.UIImage.new()
	Widget.warningBG:setLeftRight(true, true, 0, 0)
	Widget.warningBG:setTopBottom(true, true, 0, 0)
	Widget.warningBG:setRGB(0, 0, 0)
	Widget.warningBG:setAlpha(0.8)
	Widget:addElement(Widget.warningBG)
	local f10_local2 = 32
	local f10_local3 = 5
	local f10_local4 = 30
	local f10_local5 = 5
	Widget.warningIcon = LUI.UIImage.new()
	Widget.warningIcon:setLeftRight(false, false, -f10_local2 / 2, f10_local2 / 2)
	Widget.warningIcon:setTopBottom(true, false, f10_local4, f10_local4 + f10_local2)
	Widget.warningIcon:setImage(RegisterMaterial("cac_restricted"))
	Widget:addElement(Widget.warningIcon)
	f10_local4 = f10_local4 + f10_local2
	local f10_local6 = "Default"
	local f10_local7 = CoD.fonts[f10_local6]
	local f10_local8 = CoD.textSize[f10_local6]
	Widget.warningLabel = LUI.UIText.new()
	Widget.warningLabel:setLeftRight(true, true, f10_local5, -f10_local5)
	Widget.warningLabel:setTopBottom(true, false, f10_local4, f10_local4 + f10_local8)
	Widget.warningLabel:setFont(f10_local7)
	Widget.warningLabel:setRGB(CoD.red.r, CoD.red.g, CoD.red.b)
	Widget.warningLabel:setAlignment(LUI.Alignment.Center)
	Widget:addElement(Widget.warningLabel)
	local f10_local9 = Engine.DoesPartyHaveDLCForMap(Dvar.ui_mapname:get())
	local f10_local10 = ""
	if f10_local9 == false and Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false then
		Widget:setAlpha(1)
		if Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) then
			f10_local10 = Engine.Localize("MPUI_DLC_WARNING_PARTY_MISSING_MAP_PACK_THEATER")
		else
			f10_local10 = Engine.Localize("MPUI_DLC_WARNING_PARTY_MISSING_MAP_PACK")
		end
	else
		Widget:setAlpha(0)
	end
	Widget.warningLabel:setText(f10_local10)
end

CoD.PrivateGameLobby.AddSetupGameFlyout = function (f11_arg0)
	local f11_local0 = f11_arg0.body.widestButtonTextWidth + 10
	local f11_local1 = CoD.Menu.TitleHeight + CoD.CoD9Button.Height * 1 + 2
	local f11_local2 = CoD.CoD9Button.Height * 5
	local f11_local3 = CoD.ButtonList.DefaultWidth - 20
	f11_arg0.body.setupGameFlyoutBG = LUI.UIImage.new()
	f11_arg0.body.setupGameFlyoutBG:setLeftRight(true, false, -4, f11_local0)
	f11_arg0.body.setupGameFlyoutBG:setTopBottom(true, false, f11_local1, f11_local1 + CoD.CoD9Button.Height)
	f11_arg0.body.setupGameFlyoutBG:setRGB(0, 0, 0)
	f11_arg0.body.setupGameFlyoutBG:setAlpha(0.8)
	f11_arg0.body.setupGameFlyoutBG:setPriority(-100)
	f11_arg0.body:addElement(f11_arg0.body.setupGameFlyoutBG)
	f11_arg0.body.setupGameFlyoutContainer = LUI.UIElement.new()
	f11_arg0.body.setupGameFlyoutContainer:setLeftRight(true, false, f11_local0, f11_local0 + f11_local3)
	f11_arg0.body.setupGameFlyoutContainer:setTopBottom(true, false, f11_local1, f11_local1 + f11_local2)
	f11_arg0.body.setupGameFlyoutContainer:setPriority(1000)
	f11_arg0.body:addElement(f11_arg0.body.setupGameFlyoutContainer)
	local f11_local4 = LUI.UIImage.new()
	f11_local4:setLeftRight(true, true, 0, 0)
	f11_local4:setTopBottom(true, true, 0, 0)
	f11_local4:setRGB(0, 0, 0)
	f11_local4:setAlpha(0.8)
	f11_arg0.body.setupGameFlyoutContainer:addElement(f11_local4)
	f11_arg0.body.setupGameFlyoutContainer.buttonList = CoD.ButtonList.new()
	f11_arg0.body.setupGameFlyoutContainer.buttonList:setLeftRight(true, true, 4, 0)
	f11_arg0.body.setupGameFlyoutContainer.buttonList:setTopBottom(true, true, 0, 0)
	f11_arg0.body.setupGameFlyoutContainer:addElement(f11_arg0.body.setupGameFlyoutContainer.buttonList)
	if CoD.useMouse then
		f11_arg0.body.setupGameFlyoutContainer.buttonList:setHandleMouseButton(true)
		f11_arg0.body.setupGameFlyoutContainer.buttonList:registerEventHandler("leftmouseup_outside", CoD.MainMenu.FlyoutBack)
	end
	CoD.PrivateGameLobby.PopulateFlyoutButtons_Project_Multiplayer(f11_arg0)
end

CoD.PrivateGameLobby.RemoveSetupGameFlyout = function (f12_arg0)
	if f12_arg0.body.setupGameFlyoutBG ~= nil then
		f12_arg0.body.setupGameFlyoutBG:close()
		f12_arg0.body.setupGameFlyoutBG = nil
	end
	if f12_arg0.body.setupGameFlyoutContainer ~= nil then
		f12_arg0.body.setupGameFlyoutContainer:close()
		f12_arg0.body.setupGameFlyoutContainer = nil
	end
end

CoD.PrivateGameLobby.ButtonListButtonGainFocus = function (f13_arg0, f13_arg1)
	f13_arg0:dispatchEventToParent({
		name = "add_party_privacy_button"
	})
	CoD.Lobby.ButtonListButtonGainFocus(f13_arg0, f13_arg1)
end

CoD.PrivateGameLobby.ButtonListAddButton = function (f14_arg0, f14_arg1, f14_arg2, f14_arg3)
	local f14_local0 = CoD.Lobby.ButtonListAddButton(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
	f14_local0:registerEventHandler("gain_focus", CoD.PrivateGameLobby.ButtonListButtonGainFocus)
	return f14_local0
end

CoD.PrivateGameLobby.AddButtonPaneElements = function (f15_arg0)
	CoD.LobbyPanes.addButtonPaneElements(f15_arg0)
	f15_arg0.body.buttonList.addButton = CoD.PrivateGameLobby.ButtonListAddButton
end

CoD.PrivateGameLobby.PopulateButtonPaneElements = function (f16_arg0)
	CoD.PrivateGameLobby.PopulateButtons(f16_arg0)
end

CoD.PrivateGameLobby.PopulateButtonPrompts = function (f17_arg0)
	if f17_arg0.friendsButton ~= nil then
		f17_arg0.friendsButton:close()
		f17_arg0.friendsButton = nil
	end
	if f17_arg0.partyPrivacyButton ~= nil then
		f17_arg0.partyPrivacyButton:close()
		f17_arg0.partyPrivacyButton = nil
	end
	if UIExpression.SessionMode_IsSystemlinkGame() == 0 and Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false then
		f17_arg0:addFriendsButton()
	end
	if Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) == false then
		CoD.PrivateGameLobby.PopulateButtonPrompts_Project(f17_arg0)
	end
	if UIExpression.SessionMode_IsSystemlinkGame() == 0 then
		f17_arg0:addPartyPrivacyButton()
		f17_arg0:addNATType()
	end
end

CoD.PrivateGameLobby.AddLobbyPaneElements = function (f18_arg0, f18_arg1, f18_arg2)
	if f18_arg2 == nil then
		f18_arg2 = UIExpression.DvarInt(controller, "party_maxlocalplayers_privatematch")
	end
	CoD.LobbyPanes.addLobbyPaneElements(f18_arg0, f18_arg1, f18_arg2)
end

CoD.PrivateGameLobby.GameLobbyUpdate = function (f19_arg0, f19_arg1)
	CoD.PrivateGameLobby.PopulateButtonPrompts(f19_arg0)
	f19_arg0:dispatchEventToChildren(f19_arg1)
end

local f0_local0 = function ()
	if Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) then
		return 
	end
	local f20_local0 = Dvar.ui_mapname:get()
	local f20_local1 = true
	if f20_local0 == "" then
		f20_local1 = false
	end
	if not Engine.IsMapValid(f20_local0) then
		f20_local1 = false
	end
	if not f20_local1 then
		Dvar.ui_mapname:set(CoD.GetDefaultMap(nil))
		if CoD.isZombie then
			local f20_local2, f20_local3 = CoD.GetDefaultMapStartLocationGameType_Zombie(nil)
			Dvar.ui_gametype:set(f20_local3)
			Dvar.ui_zm_mapstartlocation:set(f20_local2)
		end
	end
end

local f0_local1 = function ()
	if CoD.isZombie then
		return 
	end
	local f21_local0 = UIExpression.DvarString(nil, "ui_gametype")
	local f21_local1 = Engine.GetGametypesBase()
	local f21_local2 = false
	for f21_local6, f21_local7 in pairs(f21_local1) do
		if f21_local7.gametype == f21_local0 then
			f21_local2 = true
			break
		end
	end
	if f21_local2 == false then
		Dvar.ui_gametype:set("tdm")
	end
end

CoD.PrivateGameLobby.UpdateHost = function (f22_arg0, f22_arg1)
	local f22_local0 = f22_arg1.isHost
	if f22_local0 ~= f22_arg0.wasHost then
		f22_arg0.wasHost = f22_local0
		f22_arg0:saveState()
		f0_local0()
		f0_local1()
		f22_arg0.populateButtons(f22_arg0.buttonPane)
		f22_arg0:populateButtonPrompts()
	end
end

CoD.PrivateGameLobby.UpdateButtons = function (f23_arg0, f23_arg1)
	f23_arg0:saveState()
	f23_arg0.populateButtons(f23_arg0.buttonPane)
	f23_arg0:populateButtonPrompts()
	f23_arg0:dispatchEventToChildren(f23_arg1)
end

CoD.PrivateGameLobby.GameTypeEvent = function (f24_arg0, f24_arg1)
	f24_arg0:populateButtonPrompts()
	if CoD.isZombie and not Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) then
		CoD.GameMapZombie.SwitchToMapDirect(2, true, 0)
	end
	if f24_arg0.buttonPane.body ~= nil and f24_arg1.isModified ~= nil then
		f24_arg0.buttonPane.body.mapInfoImage:setModifiedCustomGame(f24_arg1.isModified)
		Engine.SetDvar("bot_friends", 0)
		Engine.SetDvar("bot_enemies", 0)
		Engine.SetDvar("bot_difficulty", 1)
		Engine.SystemNeedsUpdate(nil, "game_options")
		Engine.SystemNeedsUpdate(nil, "lobby")
	end
	f24_arg0:dispatchEventToChildren(f24_arg1)
end

CoD.PrivateGameLobby.ButtonBack = function (f25_arg0, f25_arg1)
	if not CoD.isPS3 and UIExpression.IsPrimaryLocalClient(f25_arg1.controller) == 0 then
		Engine.Exec(f25_arg1.controller, "signclientout")
		f25_arg0:processEvent({
			name = "controller_backed_out"
		})
		return 
	elseif CoD.Lobby.OpenSignOutPopup(f25_arg0, f25_arg1) == true then
		return 
	elseif not f25_arg0.m_inputDisabled then
		if Engine.PartyHostIsReadyToStart() then
			CoD.PrivateGameLobby.CancelStartGame(f25_arg0, f25_arg1)
		else
			CoD.Lobby.ConfirmLeaveGameLobby(f25_arg0, {
				controller = f25_arg1.controller,
				leaveLobbyHandler = CoD.PrivateGameLobby.LeaveLobby
			})
		end
	end
end

CoD.PrivateGameLobby.LeaveLobby = function (f26_arg0, f26_arg1)
	if Engine.IsLivestreamEnabled() then
		Engine.LivestreamDisable(f26_arg1.controller)
	end
	CoD.PrivateGameLobby.LeaveLobby_Project(f26_arg0, f26_arg1)
	if CoD.isMultiplayer then
		Engine.Exec(f26_arg1.controller, "party_updateActiveMenu")
	end
end

CoD.PrivateGameLobby.Button_StartMatch = function (f27_arg0, f27_arg1)
	f27_arg0:dispatchEventToParent({
		name = "start_game",
		controller = f27_arg1.controller
	})
	if f27_arg0.checkGameTimer then
		f27_arg0.checkGameTimer:close()
		f27_arg0.checkGameTimer = nil
	end
	f27_arg0.checkGameTimer = LUI.UITimer.new(100, "check_game_is_valid", false)
	f27_arg0:addElement(f27_arg0.checkGameTimer)
end

CoD.PrivateGameLobby.OpenChangeMap = function (f28_arg0, f28_arg1)
	Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_SELECTING_MAP)
	f28_arg0:openPopup("ChangeMap", f28_arg1.controller)
	Engine.PlaySound("cac_screen_fade")
end

CoD.PrivateGameLobby.OpenChangeGameMode = function (f29_arg0, f29_arg1)
	Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_SELECTING_GAMETYPE)
	f29_arg0:openPopup("ChangeGameMode", f29_arg1.controller)
	Engine.PlaySound("cac_screen_fade")
end

CoD.PrivateGameLobby.StartGame = function (f30_arg0, f30_arg1)
	if CoD.PrivateGameLobby.IsHost(f30_arg0, f30_arg1.controller) then
		if Engine.GetGametypeSetting("autoTeamBalance") == 1 then
			Engine.PartyHostReassignTeams()
		end
		Engine.PartyHostToggleStart()
	end
	CoD.PrivateGameLobby.UpdateHostButtons(f30_arg0)
	f30_arg0:registerEventHandler("button_prompt_back", CoD.PrivateGameLobby.CancelStartGame)
	f30_arg0:dispatchEventToChildren(f30_arg1)
end

CoD.PrivateGameLobby.CancelStartGameClear = function (f31_arg0, f31_arg1)
	if Engine.PartyGetHostUIState() == CoD.PARTYHOST_STATE_COUNTDOWN_CANCELLED then
		Engine.PartyHostClearUIState()
	end
end

CoD.PrivateGameLobby.CancelStartGame = function (f32_arg0, f32_arg1)
	if f32_arg0.checkGameTimer then
		f32_arg0.checkGameTimer:close()
		f32_arg0.checkGameTimer = nil
	end
	Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_COUNTDOWN_CANCELLED)
	if Engine.PartyHostCancelStartMatch() == true then
		CoD.PrivateGameLobby.UpdateHostButtons(f32_arg0)
		f32_arg0:addElement(LUI.UITimer.new(1500, "cancel_start_game_clear", true))
		f32_arg0:registerEventHandler("button_prompt_back", CoD.PrivateGameLobby.ButtonBack)
		f32_arg0:dispatchEventToChildren({
			name = "cancel_start_game"
		})
	end
end

CoD.PrivateGameLobby.New = function (f33_arg0, f33_arg1)
	local f33_local0 = CoD.GameLobby.new
	local f33_local1 = f33_arg0
	local f33_local2 = f33_arg1
	local f33_local3, f33_local4, f33_local5 = false
	f33_local0 = f33_local0(f33_local1, f33_local2, f33_local3, f33_local4, f33_local5, true)
	f33_local0.buttonPane.menuName = f33_arg0
	f33_local0.buttonPane.controller = f33_arg1
	f33_local0.addButtonPaneElements = CoD.PrivateGameLobby.AddButtonPaneElements
	f33_local0.populateButtonPaneElements = CoD.PrivateGameLobby.PopulateButtonPaneElements
	f33_local0.addLobbyPaneElements = CoD.PrivateGameLobby.AddLobbyPaneElements
	f33_local0.populateButtons = CoD.PrivateGameLobby.PopulateButtons
	f33_local0.populateButtonPrompts = CoD.PrivateGameLobby.PopulateButtonPrompts
	f33_local0:updatePanelFunctions()
	f33_local0:registerEventHandler("button_prompt_back", CoD.PrivateGameLobby.ButtonBack)
	f33_local0:registerEventHandler("party_update_host", CoD.PrivateGameLobby.UpdateHost)
	f33_local0:registerEventHandler("party_joined", CoD.PrivateGameLobby.UpdateButtons)
	f33_local0:registerEventHandler("start_game", CoD.PrivateGameLobby.StartGame)
	f33_local0:registerEventHandler("cancel_start_game", CoD.PrivateGameLobby.CancelStartGame)
	f33_local0:registerEventHandler("cancel_start_game_clear", CoD.PrivateGameLobby.CancelStartGameClear)
	f33_local0:registerEventHandler("game_options_update", CoD.PrivateGameLobby.GameTypeEvent)
	f33_local0:registerEventHandler("gametype_update", CoD.PrivateGameLobby.GameTypeEvent)
	f33_local0:registerEventHandler("gamelobby_update", CoD.PrivateGameLobby.GameLobbyUpdate)
	f33_local0:registerEventHandler("button_prompt_team_prev", CoD.PrivateGameLobby.ButtonPrompt_TeamPrev)
	f33_local0:registerEventHandler("button_prompt_team_next", CoD.PrivateGameLobby.ButtonPrompt_TeamNext)
	f33_local0:registerEventHandler("zombie_settings_update", CoD.PrivateGameLobby.ZombieGameSettingsUpdate)
	CoD.PrivateGameLobby.RegisterEventHandler_Project(f33_local0)
	f33_local0.lobbyPane.body.lobbyList:setSplitscreenSignInAllowed(true)
	if CoD.isZombie == true then
		f33_local1 = Dvar.ui_gametype:get()
		Engine.SetGametype(f33_local1)
		Engine.PartySetMaxPlayerCount(CoD.Zombie.GameTypeGroups[f33_local1].maxPlayers)
	end
	f33_local0.populateButtons(f33_local0.buttonPane)
	f33_local0:populateButtonPrompts()
	f0_local0()
	f0_local1()
	f33_local0.buttonPane.body.mapInfoImage:update(Dvar.ui_mapname:get(), Dvar.ui_gametype:get())
	if CoD.isZombie and not CoD.PrivateGameLobby.IsHost(f33_local0, f33_arg1) and Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) == false then
		Engine.SetDvar("party_readyPercentRequired", 0)
	end
	return f33_local0
end

