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
CoD.PrivateGameLobby.UpdateButtonPaneButtonVisibility = function (PrivateGameLobbyButtonPane)
	if PrivateGameLobbyButtonPane == nil or PrivateGameLobbyButtonPane.body == nil then
		return 
	elseif PrivateGameLobbyButtonPane.body.mapInfoImage ~= nil then
		PrivateGameLobbyButtonPane.body.mapInfoImage:update(Dvar.ui_mapname:get(), Dvar.ui_gametype:get())
	end
end

CoD.PrivateGameLobby.UpdateHostButtons = function (PrivateGameLobbyButtonPane)
	PrivateGameLobbyButtonPane:processEvent({
		name = "button_update"
	})
end

CoD.PrivateGameLobby.Button_UpdateHostButton = function (SetupGameButton)
	if Engine.PartyHostIsReadyToStart() == true then
		SetupGameButton:disable()
	else
		SetupGameButton:enable()
	end
end

CoD.PrivateGameLobby.ShouldDisableStartButton_Zombie = function (StartMatchButton, ClientInstance)
	local DisableStartButton = false
	local Gametype = UIExpression.DvarString(nil, "ui_gametype")
	local PartyPlayerCount = Engine.PartyGetPlayerCount()
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == true and PartyPlayerCount > 2 then
		if true == Dvar.r_dualPlayEnable:get() then
			DisableStartButton = true
			StartMatchButton.hintText = Engine.Localize("ZMUI_START_MATCH_DUALVIEW_DISABLED_DESC", CoD.Zombie.GameTypeGroups[Gametype].maxPlayers)
		elseif true == Dvar.r_stereo3DOn:get() then
			DisableStartButton = true
			StartMatchButton.hintText = Engine.Localize("ZMUI_START_MATCH_STEREOSCOPIC3D_DISABLED_DESC", CoD.Zombie.GameTypeGroups[Gametype].maxPlayers)
		else
			StartMatchButton.hintText = Engine.Localize("MPUI_START_MATCH_DESC")
		end
		if DisableStartButton == true then
			return DisableStartButton
		end
	end
	if Gametype == CoD.Zombie.GAMETYPE_ZGRIEF then
		local PartyTeamAlliesCount = Engine.PartyGetTeamMemberCount(CoD.TEAM_ALLIES)
		local PartyTeamAxisCount = Engine.PartyGetTeamMemberCount(CoD.TEAM_AXIS)
		if PartyTeamAlliesCount > CoD.Zombie.GameTypeGroups[Gametype].maxTeamPlayers or PartyTeamAxisCount > CoD.Zombie.GameTypeGroups[Gametype].maxTeamPlayers then
			DisableStartButton = true
			StartMatchButton.hintText = Engine.Localize("ZMUI_START_MATCH_MAX_TEAM_PLAYERS_DESC", CoD.Zombie.GameTypeGroups[Gametype].maxTeamPlayers)
		elseif PartyTeamAlliesCount < CoD.Zombie.GameTypeGroups[Gametype].minTeamPlayers or PartyTeamAxisCount < CoD.Zombie.GameTypeGroups[Gametype].minTeamPlayers then
			DisableStartButton = true
			StartMatchButton.hintText = Engine.Localize("ZMUI_START_MATCH_MIN_TEAM_PLAYERS_DESC")
		else
			StartMatchButton.hintText = Engine.Localize("MPUI_START_MATCH_DESC")
		end
	elseif PartyPlayerCount > CoD.Zombie.GameTypeGroups[Gametype].maxPlayers then
		DisableStartButton = true
		StartMatchButton.hintText = Engine.Localize("ZMUI_START_MATCH_MAX_TOTAL_PLAYERS_DESC", CoD.Zombie.GameTypeGroups[Gametype].maxPlayers)
	elseif PartyPlayerCount < CoD.Zombie.GameTypeGroups[Gametype].minPlayers then
		DisableStartButton = true
		StartMatchButton.hintText = Engine.Localize("ZMUI_START_MATCH_MIN_TOTAL_PLAYERS_DESC", CoD.Zombie.GameTypeGroups[Gametype].minPlayers)
	else
		StartMatchButton.hintText = Engine.Localize("MPUI_START_MATCH_DESC")
	end
	return DisableStartButton
end

CoD.PrivateGameLobby.Button_GameLobbyUpdate = function (StartMatchButton, ClientInstance)
	local IsPartyHostReadyToStart = Engine.PartyHostIsReadyToStart()
	local GameCanStart = true
	local DoesPartyHaveDLC = Engine.DoesPartyHaveDLCForMap(Dvar.ui_mapname:get())
	if CoD.isZombie == true then
		if not IsPartyHostReadyToStart then
			if DoesPartyHaveDLC then
				GameCanStart = CoD.PrivateGameLobby.ShouldDisableStartButton_Zombie(StartMatchButton, ClientInstance)
			else
				GameCanStart = true
			end
		end
	end
	if GameCanStart == true and IsPartyHostReadyToStart == true then
		StartMatchButton:disable()
	else
		StartMatchButton:enable()
	end
	if UIExpression.PrivatePartyHost() == 1 and (Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) or Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH)) then
		Engine.Exec(ClientInstance.controller, "getLatestWAD")
	end
	StartMatchButton:dispatchEventToChildren(ClientInstance)
end

CoD.PrivateGameLobby.IsHost = function (f6_arg0, LocalClientIndex)
	if UIExpression.InLobby(LocalClientIndex) ~= 1 then
		return true
	elseif UIExpression.GameHost(LocalClientIndex) == 1 then
		return true
	else
		return false
	end
end

CoD.PrivateGameLobby.Button_StartMatchCanceled = function (StartMatchButton, f7_arg1)
	StartMatchButton:enable()
	if StartMatchButton.checkGameTimer then
		StartMatchButton.checkGameTimer:close()
		StartMatchButton.checkGameTimer = nil
	end
end

CoD.PrivateGameLobby.IsGameValid = function (StartMatchButton, f8_arg1)
	local ShouldDisableStartButton = false
	if CoD.isZombie then
		ShouldDisableStartButton = CoD.PrivateGameLobby.ShouldDisableStartButton_Zombie(StartMatchButton)
	end
	if ShouldDisableStartButton then
		StartMatchButton:dispatchEventToParent({
			name = "cancel_start_game"
		})
	end
end

CoD.PrivateGameLobby.PopulateButtons = function (PrivateGameLobbyButtonPane)
	if PrivateGameLobbyButtonPane.body == nil then
		return 
	end
	PrivateGameLobbyButtonPane.body.buttonList:removeAllButtons()
	PrivateGameLobbyButtonPane.body.widestButtonTextWidth = CoD.PrivateGameLobby.DefaultSetupGameFlyoutLeft
	local IsHost = CoD.PrivateGameLobby.IsHost(PrivateGameLobbyButtonPane, PrivateGameLobbyButtonPane.panelManager.m_ownerController)
	if IsHost == true then
		PrivateGameLobbyButtonPane.body.startMatchButton = PrivateGameLobbyButtonPane.body.buttonList:addButton(Engine.Localize("MPUI_START_MATCH_CAPS"))
		PrivateGameLobbyButtonPane.body.startMatchButton.hintText = Engine.Localize("MPUI_START_MATCH_DESC")
		PrivateGameLobbyButtonPane.body.startMatchButton:registerEventHandler("button_action", CoD.PrivateGameLobby.Button_StartMatch)
		PrivateGameLobbyButtonPane.body.startMatchButton:registerEventHandler("start_game", PrivateGameLobbyButtonPane.body.startMatchButton.disable)
		PrivateGameLobbyButtonPane.body.startMatchButton:registerEventHandler("cancel_start_game", CoD.PrivateGameLobby.Button_StartMatchCanceled)
		PrivateGameLobbyButtonPane.body.startMatchButton:registerEventHandler("gamelobby_update", CoD.PrivateGameLobby.Button_GameLobbyUpdate)
		PrivateGameLobbyButtonPane.body.startMatchButton:registerEventHandler("check_game_is_valid", CoD.PrivateGameLobby.IsGameValid)
		PrivateGameLobbyButtonPane.body.gameModeInfo = CoD.Lobby.CreateInfoPane()
		PrivateGameLobbyButtonPane.defaultFocusButton = PrivateGameLobbyButtonPane.body.startMatchButton
		if true == Engine.PartyHostIsReadyToStart() or true ~= Engine.DoesPartyHaveDLCForMap(Dvar.ui_mapname:get()) then
			PrivateGameLobbyButtonPane.body.startMatchButton:disable()
		else
			PrivateGameLobbyButtonPane.body.startMatchButton:enable()
		end
	end
	CoD.PrivateGameLobby.PopulateButtons_Project(PrivateGameLobbyButtonPane, IsHost)
	if IsHost == false then
		PrivateGameLobbyButtonPane.defaultFocusButton = PrivateGameLobbyButtonPane.body.createAClassButton
	end
	CoD.PrivateGameLobby.UpdateHostButtons(PrivateGameLobbyButtonPane)
	if PrivateGameLobbyButtonPane.body.mapInfoImage ~= nil then
		PrivateGameLobbyButtonPane.body.mapInfoImage:close()
	end
	local HorizontalOffset = 350 - CoD.CoD9Button.Height - 0
	local VerticalOffset = HorizontalOffset / CoD.MapInfoImage.AspectRatio
	PrivateGameLobbyButtonPane.body.mapInfoImage = CoD.MapInfoImage.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = HorizontalOffset,
		topAnchor = false,
		bottomAnchor = true,
		top = -VerticalOffset - CoD.ButtonPrompt.Height - 15,
		bottom = -CoD.ButtonPrompt.Height - 15
	})
	PrivateGameLobbyButtonPane.body.mapInfoImage:setPriority(200)
	PrivateGameLobbyButtonPane.body.mapInfoImage.controller = PrivateGameLobbyButtonPane.controller
	PrivateGameLobbyButtonPane.body:addElement(PrivateGameLobbyButtonPane.body.mapInfoImage)
	CoD.PrivateGameLobby.AddDLCWarning(PrivateGameLobbyButtonPane, IsHost)
	CoD.GameLobby.PopulateButtons(PrivateGameLobbyButtonPane, VerticalOffset)
	if not CoD.isZombie and not PrivateGameLobbyButtonPane:restoreState() and CoD.useController == true and PrivateGameLobbyButtonPane.defaultFocusButton ~= nil then
		PrivateGameLobbyButtonPane.defaultFocusButton:processEvent({
			name = "gain_focus"
		})
	end
	CoD.PrivateGameLobby.UpdateButtonPaneButtonVisibility(PrivateGameLobbyButtonPane)
end

CoD.PrivateGameLobby.AddDLCWarning = function (PrivateGameLobbyButtonPane, f10_arg1)
	if PrivateGameLobbyButtonPane.body.mapInfoImage.dlcWarningContainer ~= nil then
		PrivateGameLobbyButtonPane.body.mapInfoImage.dlcWarningContainer:close()
		PrivateGameLobbyButtonPane.body.mapInfoImage.dlcWarningContainer = nil
	end
	local DLCWarningWidget = LUI.UIElement.new()
	if CoD.isZombie == true then
		DLCWarningWidget:setLeftRight(true, false, CoD.MapInfoImage.MapImageLeft * 2, CoD.MapInfoImage.MapImageWidth - 2)
		DLCWarningWidget:setTopBottom(false, true, CoD.MapInfoImage.MapImageBottom - CoD.MapInfoImage.MapImageHeight + 6, CoD.MapInfoImage.MapImageBottom + 40)
	else
		DLCWarningWidget:setLeftRight(true, false, CoD.MapInfoImage.MapImageLeft, CoD.MapInfoImage.MapImageLeft + CoD.MapInfoImage.MapImageWidth)
		DLCWarningWidget:setTopBottom(false, true, CoD.MapInfoImage.MapImageBottom - CoD.MapInfoImage.MapImageHeight, CoD.MapInfoImage.MapImageBottom)
	end
	DLCWarningWidget:setAlpha(0)
	PrivateGameLobbyButtonPane.body.mapInfoImage:addElement(DLCWarningWidget)
	PrivateGameLobbyButtonPane.body.mapInfoImage.dlcWarningContainer = DLCWarningWidget
	DLCWarningWidget.warningBG = LUI.UIImage.new()
	DLCWarningWidget.warningBG:setLeftRight(true, true, 0, 0)
	DLCWarningWidget.warningBG:setTopBottom(true, true, 0, 0)
	DLCWarningWidget.warningBG:setRGB(0, 0, 0)
	DLCWarningWidget.warningBG:setAlpha(0.8)
	DLCWarningWidget:addElement(DLCWarningWidget.warningBG)
	local HorizontalOffset = 32
	local VerticalOffset = 30
	DLCWarningWidget.warningIcon = LUI.UIImage.new()
	DLCWarningWidget.warningIcon:setLeftRight(false, false, -HorizontalOffset / 2, HorizontalOffset / 2)
	DLCWarningWidget.warningIcon:setTopBottom(true, false, VerticalOffset, VerticalOffset + HorizontalOffset)
	DLCWarningWidget.warningIcon:setImage(RegisterMaterial("cac_restricted"))
	DLCWarningWidget:addElement(DLCWarningWidget.warningIcon)
	VerticalOffset = VerticalOffset + HorizontalOffset
	local DefaultFont = "Default"
	DLCWarningWidget.warningLabel = LUI.UIText.new()
	DLCWarningWidget.warningLabel:setLeftRight(true, true, 5, -5)
	DLCWarningWidget.warningLabel:setTopBottom(true, false, VerticalOffset, VerticalOffset + CoD.textSize[DefaultFont])
	DLCWarningWidget.warningLabel:setFont(CoD.fonts[DefaultFont])
	DLCWarningWidget.warningLabel:setRGB(CoD.red.r, CoD.red.g, CoD.red.b)
	DLCWarningWidget.warningLabel:setAlignment(LUI.Alignment.Center)
	DLCWarningWidget:addElement(DLCWarningWidget.warningLabel)
	local DoesPartyHaveDLCForMap = Engine.DoesPartyHaveDLCForMap(Dvar.ui_mapname:get())
	local WarningMessage = ""
	if DoesPartyHaveDLCForMap == false and Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false then
		DLCWarningWidget:setAlpha(1)
		if Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) then
			WarningMessage = Engine.Localize("MPUI_DLC_WARNING_PARTY_MISSING_MAP_PACK_THEATER")
		else
			WarningMessage = Engine.Localize("MPUI_DLC_WARNING_PARTY_MISSING_MAP_PACK")
		end
	else
		DLCWarningWidget:setAlpha(0)
	end
	DLCWarningWidget.warningLabel:setText(WarningMessage)
end

CoD.PrivateGameLobby.AddSetupGameFlyout = function (PrivateGameLobbyButtonPane)
	local HorizontalOffset = PrivateGameLobbyButtonPane.body.widestButtonTextWidth + 10
	local VerticalOffset = CoD.Menu.TitleHeight + CoD.CoD9Button.Height * 1 + 2
	PrivateGameLobbyButtonPane.body.setupGameFlyoutBG = LUI.UIImage.new()
	PrivateGameLobbyButtonPane.body.setupGameFlyoutBG:setLeftRight(true, false, -4, HorizontalOffset)
	PrivateGameLobbyButtonPane.body.setupGameFlyoutBG:setTopBottom(true, false, VerticalOffset, VerticalOffset + CoD.CoD9Button.Height)
	PrivateGameLobbyButtonPane.body.setupGameFlyoutBG:setRGB(0, 0, 0)
	PrivateGameLobbyButtonPane.body.setupGameFlyoutBG:setAlpha(0.8)
	PrivateGameLobbyButtonPane.body.setupGameFlyoutBG:setPriority(-100)
	PrivateGameLobbyButtonPane.body:addElement(PrivateGameLobbyButtonPane.body.setupGameFlyoutBG)
	PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer = LUI.UIElement.new()
	PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer:setLeftRight(true, false, HorizontalOffset, HorizontalOffset + CoD.ButtonList.DefaultWidth - 20)
	PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer:setTopBottom(true, false, VerticalOffset, VerticalOffset + CoD.CoD9Button.Height * 5)
	PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer:setPriority(1000)
	PrivateGameLobbyButtonPane.body:addElement(PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer)
	local f11_local4 = LUI.UIImage.new()
	f11_local4:setLeftRight(true, true, 0, 0)
	f11_local4:setTopBottom(true, true, 0, 0)
	f11_local4:setRGB(0, 0, 0)
	f11_local4:setAlpha(0.8)
	PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer:addElement(f11_local4)
	PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer.buttonList = CoD.ButtonList.new()
	PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer.buttonList:setLeftRight(true, true, 4, 0)
	PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer.buttonList:setTopBottom(true, true, 0, 0)
	PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer:addElement(PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer.buttonList)
	if CoD.useMouse then
		PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer.buttonList:setHandleMouseButton(true)
		PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer.buttonList:registerEventHandler("leftmouseup_outside", CoD.MainMenu.FlyoutBack)
	end
	CoD.PrivateGameLobby.PopulateFlyoutButtons_Project_Multiplayer(PrivateGameLobbyButtonPane)
end

CoD.PrivateGameLobby.RemoveSetupGameFlyout = function (PrivateGameLobbyButtonPane)
	if PrivateGameLobbyButtonPane.body.setupGameFlyoutBG ~= nil then
		PrivateGameLobbyButtonPane.body.setupGameFlyoutBG:close()
		PrivateGameLobbyButtonPane.body.setupGameFlyoutBG = nil
	end
	if PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer ~= nil then
		PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer:close()
		PrivateGameLobbyButtonPane.body.setupGameFlyoutContainer = nil
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

CoD.PrivateGameLobby.PopulateButtonPrompts = function (PrivateGameLobbyWidget)
	if PrivateGameLobbyWidget.friendsButton ~= nil then
		PrivateGameLobbyWidget.friendsButton:close()
		PrivateGameLobbyWidget.friendsButton = nil
	end
	if PrivateGameLobbyWidget.partyPrivacyButton ~= nil then
		PrivateGameLobbyWidget.partyPrivacyButton:close()
		PrivateGameLobbyWidget.partyPrivacyButton = nil
	end
	if UIExpression.SessionMode_IsSystemlinkGame() == 0 and Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false then
		PrivateGameLobbyWidget:addFriendsButton()
	end
	if Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) == false then
		CoD.PrivateGameLobby.PopulateButtonPrompts_Project(PrivateGameLobbyWidget)
	end
	if UIExpression.SessionMode_IsSystemlinkGame() == 0 then
		PrivateGameLobbyWidget:addPartyPrivacyButton()
		PrivateGameLobbyWidget:addNATType()
	end
end

CoD.PrivateGameLobby.AddLobbyPaneElements = function (LobbyPane, HeaderText, MaxLocalPlayers)
	if MaxLocalPlayers == nil then
		MaxLocalPlayers = UIExpression.DvarInt(0, "party_maxlocalplayers_privatematch")
	end
	CoD.LobbyPanes.addLobbyPaneElements(LobbyPane, HeaderText, MaxLocalPlayers)
end

CoD.PrivateGameLobby.GameLobbyUpdate = function (PrivateGameLobbyWidget, f19_arg1)
	CoD.PrivateGameLobby.PopulateButtonPrompts(PrivateGameLobbyWidget)
	PrivateGameLobbyWidget:dispatchEventToChildren(f19_arg1)
end

local ValidateMap = function ()
	if Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) then
		return 
	end
	local Mapname = Dvar.ui_mapname:get()
	local MapIsValid = true
	if Mapname == "" then
		MapIsValid = false
	end
	if not Engine.IsMapValid(Mapname) then
		MapIsValid = false
	end
	if not MapIsValid then
		Dvar.ui_mapname:set(CoD.GetDefaultMap(nil))
		if CoD.isZombie then
			local DefaultStartLocation, DefaultGametype = CoD.GetDefaultMapStartLocationGameType_Zombie(nil)
			Dvar.ui_gametype:set(DefaultGametype)
			Dvar.ui_zm_mapstartlocation:set(DefaultStartLocation)
		end
	end
end

local ValidateGametype = function ()
	if CoD.isZombie then
		return 
	end
	local Gametype = UIExpression.DvarString(nil, "ui_gametype")
	local DefaultGametypes = Engine.GetGametypesBase()
	local GametypeIsValid = false
	for Key, DefaultGametype in pairs(DefaultGametypes) do
		if DefaultGametype.gametype == Gametype then
			GametypeIsValid = true
			break
		end
	end
	if GametypeIsValid == false then
		Dvar.ui_gametype:set("tdm")
	end
end

CoD.PrivateGameLobby.UpdateHost = function (PrivateGameLobbyWidget, ClientInstance)
	if ClientInstance.isHost ~= PrivateGameLobbyWidget.wasHost then
		PrivateGameLobbyWidget.wasHost = ClientInstance.isHost
		PrivateGameLobbyWidget:saveState()
		ValidateMap()
		ValidateGametype()
		PrivateGameLobbyWidget.populateButtons(PrivateGameLobbyWidget.buttonPane)
		PrivateGameLobbyWidget:populateButtonPrompts()
	end
end

CoD.PrivateGameLobby.UpdateButtons = function (PrivateGameLobbyWidget, f23_arg1)
	PrivateGameLobbyWidget:saveState()
	PrivateGameLobbyWidget.populateButtons(PrivateGameLobbyWidget.buttonPane)
	PrivateGameLobbyWidget:populateButtonPrompts()
	PrivateGameLobbyWidget:dispatchEventToChildren(f23_arg1)
end

CoD.PrivateGameLobby.GameTypeEvent = function (PrivateGameLobbyWidget, f24_arg1)
	PrivateGameLobbyWidget:populateButtonPrompts()
	if CoD.isZombie and not Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) then
		CoD.GameMapZombie.SwitchToMapDirect(2, true, 0)
	end
	if PrivateGameLobbyWidget.buttonPane.body ~= nil and f24_arg1.isModified ~= nil then
		PrivateGameLobbyWidget.buttonPane.body.mapInfoImage:setModifiedCustomGame(f24_arg1.isModified)
		Engine.SetDvar("bot_friends", 0)
		Engine.SetDvar("bot_enemies", 0)
		Engine.SetDvar("bot_difficulty", 1)
		Engine.SystemNeedsUpdate(nil, "game_options")
		Engine.SystemNeedsUpdate(nil, "lobby")
	end
	PrivateGameLobbyWidget:dispatchEventToChildren(f24_arg1)
end

CoD.PrivateGameLobby.ButtonBack = function (PrivateGameLobbyWidget, ClientInstance)
	if not CoD.isPS3 and UIExpression.IsPrimaryLocalClient(ClientInstance.controller) == 0 then
		Engine.Exec(ClientInstance.controller, "signclientout")
		PrivateGameLobbyWidget:processEvent({
			name = "controller_backed_out"
		})
		return 
	elseif CoD.Lobby.OpenSignOutPopup(PrivateGameLobbyWidget, ClientInstance) == true then
		return 
	elseif not PrivateGameLobbyWidget.m_inputDisabled then
		if Engine.PartyHostIsReadyToStart() then
			CoD.PrivateGameLobby.CancelStartGame(PrivateGameLobbyWidget, ClientInstance)
		else
			CoD.Lobby.ConfirmLeaveGameLobby(PrivateGameLobbyWidget, {
				controller = ClientInstance.controller,
				leaveLobbyHandler = CoD.PrivateGameLobby.LeaveLobby
			})
		end
	end
end

CoD.PrivateGameLobby.LeaveLobby = function (PrivateGameLobbyWidget, ClientInstance)
	if Engine.IsLivestreamEnabled() then
		Engine.LivestreamDisable(ClientInstance.controller)
	end
	CoD.PrivateGameLobby.LeaveLobby_Project(PrivateGameLobbyWidget, ClientInstance)
	if CoD.isMultiplayer then
		Engine.Exec(ClientInstance.controller, "party_updateActiveMenu")
	end
end

CoD.PrivateGameLobby.Button_StartMatch = function (StartMatchButton, ClientInstance)
	StartMatchButton:dispatchEventToParent({
		name = "start_game",
		controller = ClientInstance.controller
	})
	if StartMatchButton.checkGameTimer then
		StartMatchButton.checkGameTimer:close()
		StartMatchButton.checkGameTimer = nil
	end
	StartMatchButton.checkGameTimer = LUI.UITimer.new(100, "check_game_is_valid", false)
	StartMatchButton:addElement(StartMatchButton.checkGameTimer)
end

CoD.PrivateGameLobby.OpenChangeMap = function (PrivateGameLobbyWidget, ClientInstance)
	Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_SELECTING_MAP)
	PrivateGameLobbyWidget:openPopup("ChangeMap", ClientInstance.controller)
	Engine.PlaySound("cac_screen_fade")
end

CoD.PrivateGameLobby.OpenChangeGameMode = function (PrivateGameLobbyWidget, ClientInstance)
	Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_SELECTING_GAMETYPE)
	PrivateGameLobbyWidget:openPopup("ChangeGameMode", ClientInstance.controller)
	Engine.PlaySound("cac_screen_fade")
end

CoD.PrivateGameLobby.StartGame = function (PrivateGameLobbyWidget, ClientInstance)
	if CoD.PrivateGameLobby.IsHost(PrivateGameLobbyWidget, ClientInstance.controller) then
		if Engine.GetGametypeSetting("autoTeamBalance") == 1 then
			Engine.PartyHostReassignTeams()
		end
		Engine.PartyHostToggleStart()
	end
	CoD.PrivateGameLobby.UpdateHostButtons(PrivateGameLobbyWidget)
	PrivateGameLobbyWidget:registerEventHandler("button_prompt_back", CoD.PrivateGameLobby.CancelStartGame)
	PrivateGameLobbyWidget:dispatchEventToChildren(ClientInstance)
end

CoD.PrivateGameLobby.CancelStartGameClear = function (f31_arg0, f31_arg1)
	if Engine.PartyGetHostUIState() == CoD.PARTYHOST_STATE_COUNTDOWN_CANCELLED then
		Engine.PartyHostClearUIState()
	end
end

CoD.PrivateGameLobby.CancelStartGame = function (PrivateGameLobbyWidget, ClientInstance)
	if PrivateGameLobbyWidget.checkGameTimer then
		PrivateGameLobbyWidget.checkGameTimer:close()
		PrivateGameLobbyWidget.checkGameTimer = nil
	end
	Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_COUNTDOWN_CANCELLED)
	if Engine.PartyHostCancelStartMatch() == true then
		CoD.PrivateGameLobby.UpdateHostButtons(PrivateGameLobbyWidget)
		PrivateGameLobbyWidget:addElement(LUI.UITimer.new(1500, "cancel_start_game_clear", true))
		PrivateGameLobbyWidget:registerEventHandler("button_prompt_back", CoD.PrivateGameLobby.ButtonBack)
		PrivateGameLobbyWidget:dispatchEventToChildren({
			name = "cancel_start_game"
		})
	end
end

CoD.PrivateGameLobby.New = function (LobbyType, LocalClientIndex)
	local PrivateGameLobbyWidget = CoD.GameLobby.new(LobbyType, LocalClientIndex, false, false, false, true)
	PrivateGameLobbyWidget.buttonPane.menuName = LobbyType
	PrivateGameLobbyWidget.buttonPane.controller = LocalClientIndex
	PrivateGameLobbyWidget.addButtonPaneElements = CoD.PrivateGameLobby.AddButtonPaneElements
	PrivateGameLobbyWidget.populateButtonPaneElements = CoD.PrivateGameLobby.PopulateButtonPaneElements
	PrivateGameLobbyWidget.addLobbyPaneElements = CoD.PrivateGameLobby.AddLobbyPaneElements
	PrivateGameLobbyWidget.populateButtons = CoD.PrivateGameLobby.PopulateButtons
	PrivateGameLobbyWidget.populateButtonPrompts = CoD.PrivateGameLobby.PopulateButtonPrompts
	PrivateGameLobbyWidget:updatePanelFunctions()
	PrivateGameLobbyWidget:registerEventHandler("button_prompt_back", CoD.PrivateGameLobby.ButtonBack)
	PrivateGameLobbyWidget:registerEventHandler("party_update_host", CoD.PrivateGameLobby.UpdateHost)
	PrivateGameLobbyWidget:registerEventHandler("party_joined", CoD.PrivateGameLobby.UpdateButtons)
	PrivateGameLobbyWidget:registerEventHandler("start_game", CoD.PrivateGameLobby.StartGame)
	PrivateGameLobbyWidget:registerEventHandler("cancel_start_game", CoD.PrivateGameLobby.CancelStartGame)
	PrivateGameLobbyWidget:registerEventHandler("cancel_start_game_clear", CoD.PrivateGameLobby.CancelStartGameClear)
	PrivateGameLobbyWidget:registerEventHandler("game_options_update", CoD.PrivateGameLobby.GameTypeEvent)
	PrivateGameLobbyWidget:registerEventHandler("gametype_update", CoD.PrivateGameLobby.GameTypeEvent)
	PrivateGameLobbyWidget:registerEventHandler("gamelobby_update", CoD.PrivateGameLobby.GameLobbyUpdate)
	PrivateGameLobbyWidget:registerEventHandler("button_prompt_team_prev", CoD.PrivateGameLobby.ButtonPrompt_TeamPrev)
	PrivateGameLobbyWidget:registerEventHandler("button_prompt_team_next", CoD.PrivateGameLobby.ButtonPrompt_TeamNext)
	PrivateGameLobbyWidget:registerEventHandler("zombie_settings_update", CoD.PrivateGameLobby.ZombieGameSettingsUpdate)
	CoD.PrivateGameLobby.RegisterEventHandler_Project(PrivateGameLobbyWidget)
	PrivateGameLobbyWidget.lobbyPane.body.lobbyList:setSplitscreenSignInAllowed(true)
	if CoD.isZombie == true then
		local Gametype = Dvar.ui_gametype:get()
		Engine.SetGametype(Gametype)
		Engine.PartySetMaxPlayerCount(CoD.Zombie.GameTypeGroups[Gametype].maxPlayers)
	end
	PrivateGameLobbyWidget.populateButtons(PrivateGameLobbyWidget.buttonPane)
	PrivateGameLobbyWidget:populateButtonPrompts()
	ValidateMap()
	ValidateGametype()
	PrivateGameLobbyWidget.buttonPane.body.mapInfoImage:update(Dvar.ui_mapname:get(), Dvar.ui_gametype:get())
	if CoD.isZombie and not CoD.PrivateGameLobby.IsHost(PrivateGameLobbyWidget, LocalClientIndex) and Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) == false then
		Engine.SetDvar("party_readyPercentRequired", 0)
	end
	return PrivateGameLobbyWidget
end

