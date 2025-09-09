require("T6.DisplayStatBox")
if CoD.isMultiplayer and not CoD.isZombie then
	require("T6.PlayerIdentity")
	require("T6.Menus.LeagueLeaderboard")
	require("T6.Menus.MiniIdentity")
end
CoD.LobbyPanes = {}
CoD.LobbyPanes.VoipOffset = 32
CoD.LobbyPanes.addButtonPaneElements = function (f1_arg0)
	CoD.PanelManager.AddPanelElements(f1_arg0)
	f1_arg0.body.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = CoD.ButtonList.DefaultWidth,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.Menu.TitleHeight,
		bottom = 0,
		alpha = 1
	})
	f1_arg0.body.buttonList:registerAnimationState("disabled", {
		alpha = 0.5
	})
	f1_arg0.body.buttonList:setPriority(10)
	f1_arg0.body.buttonList.id = f1_arg0.id .. ".LobbyButtons"
	f1_arg0.body.buttonList.pane = f1_arg0
	f1_arg0.body.buttonList.addButton = CoD.Lobby.ButtonListAddButton
	f1_arg0.body.buttonList:registerEventHandler("gain_focus", CoD.Lobby.ButtonListGainFocus)
	f1_arg0.body.buttonList:registerEventHandler("lose_focus", CoD.Lobby.ButtonListLoseFocus)
	f1_arg0.body:addElement(f1_arg0.body.buttonList)
	f1_arg0:dispatchEventToParent({
		name = "add_select_button"
	})
end

CoD.LobbyPanes.addLobbyPaneElements = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4)
	CoD.PanelManager.AddPanelElements(f2_arg0)
	if f2_arg1 ~= nil then
		f2_arg0.headerText = f2_arg1
	end
	if f2_arg2 ~= nil then
		f2_arg0.maxLocalPlayers = f2_arg2
	end
	if f2_arg3 ~= nil then
		f2_arg0.enableSearchingRows = f2_arg3
	end
	if f2_arg4 ~= nil then
		f2_arg0.showMissingDLC = f2_arg4
	end
	f2_arg0.body.lobbyList = CoD.LobbyPlayerLists.New({
		leftAnchor = true,
		rightAnchor = true,
		left = CoD.LobbyPanes.VoipOffset,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = CoD.Menu.TitleHeight,
		bottom = CoD.Menu.TitleHeight + 1000
	}, f2_arg0.m_ownerController, f2_arg0.headerText, f2_arg0.id, f2_arg0.maxLocalPlayers, f2_arg0.enableSearchingRows, f2_arg0.showMissingDLC)
	f2_arg0.body.lobbyList.pane = f2_arg0
	f2_arg0.body:addElement(f2_arg0.body.lobbyList)
	if f2_arg0.splitscreenSignInAllowed == false then
		f2_arg0.body.lobbyList:setSplitscreenSignInAllowed(false)
	end
	f2_arg0:dispatchEventToParent({
		name = "add_select_button"
	})
end

CoD.LobbyPanes.addOverviewPaneElements = function (f3_arg0)
	CoD.PanelManager.AddPanelElements(f3_arg0)
	f3_arg0:dispatchEventToParent({
		name = "add_select_button"
	})
end

CoD.LobbyPanes.addStatsPaneElements = function (f4_arg0)
	CoD.PanelManager.AddPanelElements(f4_arg0)
	f4_arg0:dispatchEventToParent({
		name = "remove_select_button"
	})
end

CoD.LobbyPanes.ButtonPaneSetFocus = function (f5_arg0)
	f5_arg0.body.buttonList:processEvent({
		name = "gain_focus"
	})
end

CoD.LobbyPanes.LobbyPaneSetFocus = function (f6_arg0)
	CoD.LobbyPlayerLists.SetFocus(f6_arg0.body.lobbyList)
end

CoD.LobbyPanes.OverviewPaneSetFocus = function (f7_arg0)

end

CoD.LobbyPanes.StatsPaneSetFocus = function (f8_arg0)

end

CoD.LobbyPanes.populateButtonPaneElements = function (f9_arg0)

end

CoD.LobbyPanes.populateLobbyPaneElements = function (f10_arg0)
	CoD.Lobby.LobbyListUpdate(f10_arg0, Engine.GetPlayersInLobby())
end

CoD.LobbyPanes.populateOverviewPaneElements = function (f11_arg0)
	if f11_arg0.body.overviewContainer ~= nil then
		f11_arg0.body.overviewContainer:removeAllChildren()
	end
	if f11_arg0.selectedPlayerXuid == nil then
		return 
	end
	local f11_local0 = Engine.GetPlayerInfoByXuid(f11_arg0.controller, f11_arg0.selectedPlayerXuid)
	local f11_local1 = Engine.GetLeagueTeamInfo(f11_arg0.controller, f11_arg0.selectedLeagueTeamID)
	f11_local1.leagueTeamMemberCount = f11_arg0.leagueTeamMemberCount
	f11_arg0.body.overviewContainer = LUI.UIElement.new()
	f11_arg0.body.overviewContainer:setLeftRight(true, true, 0, 0)
	f11_arg0.body.overviewContainer:setTopBottom(true, true, CoD.Menu.TitleHeight, 0)
	f11_arg0.body:addElement(f11_arg0.body.overviewContainer)
	if CoD.isZombie == false then
		CoD.LobbyPanes.populateOverviewPaneElements_Multiplayer(f11_arg0, f11_local0, f11_local1)
	else
		CoD.LobbyPanes.populateOverviewPaneElements_Zombies(f11_arg0, f11_local0)
	end
end

CoD.LobbyPanes.UpdateDirectionalAssistance = function (f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = 5
	local f12_local1 = CoD.textSize.Default
	local f12_local2, f12_local3, f12_local4, f12_local5 = GetTextDimensions(f12_arg1, CoD.fonts.Default, CoD.textSize.Default)
	f12_arg0.directionalAssistanceLabel:setText(f12_arg1)
	f12_arg0.leftArrow:setAlpha(0)
	f12_arg0.rightArrow:setAlpha(0)
	if f12_arg2 == LUI.Alignment.Left then
		f12_arg0.leftArrow:setLeftRight(false, false, -(f12_local4 / 2) - f12_local0, -(f12_local4 / 2) - f12_local0 - f12_local1)
		f12_arg0.leftArrow:setAlpha(1)
	elseif f12_arg2 == LUI.Alignment.Right then
		f12_arg0.rightArrow:setLeftRight(false, false, f12_local4 / 2 + f12_local0, f12_local4 / 2 + f12_local0 + f12_local1)
		f12_arg0.rightArrow:setAlpha(1)
	end
end

CoD.LobbyPanes.OverviewSlideLeft = function (f13_arg0, f13_arg1)
	if f13_arg1.isCurrentPanel ~= nil and f13_arg1.isCurrentPanel == false then
		CoD.LobbyPanes.UpdateDirectionalAssistance(f13_arg0, Engine.Localize("MENU_CAREER_OVERVIEW"), LUI.Alignment.Right)
	end
end

CoD.LobbyPanes.OverviewSlideRight = function (f14_arg0, f14_arg1)
	if f14_arg1.isCurrentPanel ~= nil and f14_arg1.isCurrentPanel == true then
		CoD.LobbyPanes.UpdateDirectionalAssistance(f14_arg0, Engine.Localize("MENU_LOBBY_LIST"), LUI.Alignment.Left)
	end
end

CoD.LobbyPanes.populateOverviewPaneElements_Multiplayer = function (f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = 0
	local f15_local1 = 20
	local f15_local2 = CoD.Menu.Width / 2 - f15_local1 * 2
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == true then
		f15_arg0.titleText = Engine.Localize("MENU_X_LEAGUE_OVERVIEW", f15_arg0.selectedPlayerName)
	else
		f15_arg0.titleText = Engine.Localize("MENU_N_CAREER_OVERVIEW", f15_arg0.selectedPlayerName)
	end
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == false then
		local f15_local3 = LUI.UIText.new()
		f15_local3:setLeftRight(true, false, f15_local1, f15_local1 + f15_local2)
		f15_local3:setTopBottom(true, false, f15_local0, f15_local0 + CoD.textSize.Default)
		f15_local3:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f15_local3:setAlpha(0.4)
		f15_local3:setFont(CoD.fonts.Default)
		f15_local3:setAlignment(LUI.Alignment.Left)
		f15_local3:setText(Engine.Localize("MENU_PLAYER_IDENTITY"))
		f15_arg0.body.overviewContainer:addElement(f15_local3)
	elseif f15_arg0.selectedPlayerShowTruePlayerInfo ~= false and f15_arg2.teamName then
		local f15_local3 = Engine.Localize("MENU_TEAM")
		local f15_local4 = LUI.UIText.new()
		f15_local4:setLeftRight(true, false, f15_local1, f15_local1 + f15_local2)
		f15_local4:setTopBottom(true, false, f15_local0, f15_local0 + CoD.textSize.Default)
		f15_local4:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f15_local4:setAlpha(0.4)
		f15_local4:setFont(CoD.fonts.Default)
		f15_local4:setAlignment(LUI.Alignment.Left)
		f15_local4:setText(f15_local3)
		f15_arg0.body.overviewContainer:addElement(f15_local4)
		local f15_local5, f15_local6, f15_local7, f15_local8 = GetTextDimensions(f15_local3, CoD.fonts.Default, CoD.textSize.Default)
		local f15_local9 = f15_local1 + f15_local7 + 5
		local f15_local10 = LUI.UIText.new()
		f15_local10:setLeftRight(true, false, f15_local9, f15_local9 + f15_local2)
		f15_local10:setTopBottom(true, false, f15_local0, f15_local0 + CoD.textSize.Default)
		f15_local10:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f15_local10:setFont(CoD.fonts.Default)
		f15_local10:setAlignment(LUI.Alignment.Left)
		f15_local10:setText(f15_arg2.teamName)
		f15_arg0.body.overviewContainer:addElement(f15_local10)
	end
	f15_local0 = f15_local0 + CoD.textSize.Default
	local f15_local3 = CoD.PlayerIdentity.Default
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == true then
		f15_local3 = CoD.PlayerIdentity.League
	end
	local f15_local4
	if Engine.IsGameLobbyRunning() or f15_local3 == CoD.PlayerIdentity.League or f15_arg0.selectedPlayerXuid == UIExpression.GetXUID(controller) or f15_arg1.status == nil or f15_arg1.status == "" then
		f15_local4 = false
	else
		f15_local4 = true
	end
	local f15_local6, f15_local7 = CoD.PlayerIdentity.New({
		leftAnchor = true,
		rightAnchor = false,
		left = f15_local1,
		right = f15_local1 + f15_local2,
		topAnchor = true,
		bottomAnchor = true,
		top = f15_local0,
		bottom = 0
	}, f15_local2, f15_local3, f15_local4)
	f15_arg0.body.overviewContainer:addElement(f15_local6)
	f15_local6:update(f15_arg0.controller, f15_arg0.selectedPlayerShowTruePlayerInfo, f15_arg0.selectedPlayerXuid, f15_arg1, f15_arg2)
	f15_local0 = f15_local0 + f15_local7 + 15
	f15_arg0.body.overviewContainer.directionalAssistanceLabel = LUI.UIText.new()
	f15_arg0.body.overviewContainer.directionalAssistanceLabel:setLeftRight(true, true, 0, 0)
	f15_arg0.body.overviewContainer.directionalAssistanceLabel:setTopBottom(true, false, f15_local0, f15_local0 + CoD.textSize.Default)
	f15_arg0.body.overviewContainer.directionalAssistanceLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f15_arg0.body.overviewContainer.directionalAssistanceLabel:setFont(CoD.fonts.Default)
	f15_arg0.body.overviewContainer.directionalAssistanceLabel:setAlignment(LUI.Alignment.Center)
	f15_arg0.body.overviewContainer:addElement(f15_arg0.body.overviewContainer.directionalAssistanceLabel)
	local f15_local8 = CoD.textSize.Default
	f15_arg0.body.overviewContainer.leftArrow = LUI.UIImage.new()
	f15_arg0.body.overviewContainer.leftArrow:setLeftRight(false, false, 0, 0)
	f15_arg0.body.overviewContainer.leftArrow:setTopBottom(true, false, f15_local0, f15_local0 + f15_local8)
	f15_arg0.body.overviewContainer.leftArrow:setImage(RegisterMaterial("ui_arrow_right"))
	f15_arg0.body.overviewContainer.leftArrow:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f15_arg0.body.overviewContainer.leftArrow:setAlpha(0)
	f15_arg0.body.overviewContainer:addElement(f15_arg0.body.overviewContainer.leftArrow)
	f15_arg0.body.overviewContainer.rightArrow = LUI.UIImage.new()
	f15_arg0.body.overviewContainer.rightArrow:setLeftRight(false, false, 0, 0)
	f15_arg0.body.overviewContainer.rightArrow:setTopBottom(true, false, f15_local0, f15_local0 + f15_local8)
	f15_arg0.body.overviewContainer.rightArrow:setImage(RegisterMaterial("ui_arrow_right"))
	f15_arg0.body.overviewContainer.rightArrow:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f15_arg0.body.overviewContainer.rightArrow:setAlpha(0)
	f15_arg0.body.overviewContainer:addElement(f15_arg0.body.overviewContainer.rightArrow)
	CoD.LobbyPanes.UpdateDirectionalAssistance(f15_arg0.body.overviewContainer, Engine.Localize("MENU_CAREER_OVERVIEW"), LUI.Alignment.Right)
	local f15_local9 = Engine.IsGameLobbyRunning()
	local f15_local10
	if f15_local9 == 0 then
		f15_local10 = f15_local9
	else
		f15_local10 = Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH)
	end
	local f15_local11
	if f15_local9 == 0 then
		f15_local11 = f15_local9
	else
		f15_local11 = Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH)
	end
	if CoD.isZombie == false and Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false and not f15_local10 and not f15_local11 then
		CoD.LobbyPanes.AddMissingDLCNames(f15_arg0, f15_arg1, f15_local1)
	end
	f15_arg0.body.overviewContainer:registerEventHandler("slide_left", CoD.LobbyPanes.OverviewSlideLeft)
	f15_arg0.body.overviewContainer:registerEventHandler("slide_right", CoD.LobbyPanes.OverviewSlideRight)
end

CoD.LobbyPanes.populateOverviewPaneElements_Zombies = function (f16_arg0, f16_arg1)
	local f16_local0 = 200
	local f16_local1 = 200
	local f16_local2 = 25
	f16_arg0.body.emblemContainer = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f16_local0 / 2,
		right = f16_local0 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f16_local2,
		bottom = f16_local2 + f16_local1
	})
	f16_arg0.body.overviewContainer:addElement(f16_arg0.body.emblemContainer)
	f16_arg0.body.emblem = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	local f16_local3 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f16_arg1.rank - 1, 3)
	if f16_arg1.daysPlayedInLast5Days == 5 then
		f16_local3 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f16_arg1.rank - 1, 4)
	end
	if f16_local3 == "" then
		f16_local3 = "menu_zm_rank_1"
	end
	f16_arg0.body.emblem:setImage(RegisterMaterial(f16_local3))
	f16_arg0.body.emblemContainer:addElement(f16_arg0.body.emblem)
	local f16_local4 = 0.25
	local f16_local5 = f16_local0 + 50
	local f16_local6 = f16_local5 * f16_local4
	f16_arg0.body.backingContainer = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f16_local5 / 2,
		right = f16_local5 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f16_local2 + f16_local1,
		bottom = f16_local2 + f16_local1 + f16_local6
	})
	f16_arg0.body.overviewContainer:addElement(f16_arg0.body.backingContainer)
	f16_arg0.body.backing = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		material = RegisterMaterial("menu_zm_gamertag"),
		alpha = 1
	})
	f16_arg0.body.backingContainer:addElement(f16_arg0.body.backing)
	local f16_local7 = CoD.textSize.Default
	local f16_local8 = ""
	if f16_arg1.clanTag ~= nil then
		f16_local8 = f16_arg1.clanTag
	end
	local f16_local9 = f16_arg0.selectedPlayerName
	if f16_arg1.name == nil then
		f16_local9 = f16_arg1.name
	end
	f16_arg0.body.gamerTag = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -1,
		right = 1,
		topAnchor = false,
		bottomAnchor = false,
		top = -f16_local7 / 2,
		bottom = f16_local7 / 2,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	f16_arg0.body.gamerTag:setText(CoD.getClanTag(f16_local8) .. f16_local9)
	f16_arg0.body.backingContainer:addElement(f16_arg0.body.gamerTag)
	local f16_local10 = 20
	f16_arg0.body.status = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f16_local5 / 2,
		right = f16_local5 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f16_local2 + f16_local1 + f16_local6 + f16_local10,
		bottom = f16_local2 + f16_local1 + f16_local6 + f16_local10 + f16_local7,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	local f16_local11 = ""
	if f16_arg1.status ~= nil then
		f16_local11 = f16_arg1.status
	end
	f16_arg0.body.status:setText(f16_local11)
	f16_arg0.body.overviewContainer:addElement(f16_arg0.body.status)
	local Widget = LUI.UIElement.new()
	local f16_local13 = 150
	local f16_local14 = f16_local13 * 0.25
	Widget:setLeftRight(false, false, -f16_local13 / 2, f16_local13 / 2)
	Widget:setTopBottom(true, false, f16_local2 + f16_local1 + f16_local6 + f16_local10 + f16_local7, f16_local2 + f16_local1 + f16_local6 + f16_local10 + f16_local7 + f16_local14 + 10)
	f16_arg0.body.overviewContainer:addElement(Widget)
	local f16_local15 = "Condensed"
	local f16_local16 = CoD.fonts[f16_local15]
	local f16_local17 = CoD.textSize[f16_local15]
	local f16_local18 = 5
	local f16_local19 = f16_local17 + f16_local18 * 2
	local f16_local20 = LUI.UIText.new()
	f16_local20:setLeftRight(false, false, 0, 0)
	f16_local20:setTopBottom(true, false, 0, f16_local17)
	f16_local20:setFont(f16_local16)
	f16_local20:setAlignment(LUI.Alignment.Center)
	local f16_local21 = f16_local19 - f16_local18 * 2
	local f16_local22 = LUI.UIImage.new()
	f16_local22:setLeftRight(true, false, 0, f16_local21)
	f16_local22:setTopBottom(true, false, 0, f16_local21)
	f16_local22:setImage(RegisterMaterial("menu_mp_party_ease_icon"))
	f16_local22:setAlignment(LUI.Alignment.Left)
	Widget:addElement(f16_local22)
	Widget:addElement(f16_local20)
	local f16_local23 = Engine.IsPlayerJoinable(f16_arg0.controller, f16_arg1.xuid)
	if f16_local23.isJoinable then
		f16_local20:setText(Engine.Localize("MENU_JOINABLE"))
		f16_local22:setAlpha(1)
	else
		f16_local20:setText("")
		f16_local22:setAlpha(0)
	end
	if f16_arg1.rank ~= nil then
		if f16_arg1.rank == "0" then
			f16_arg1.rank = "1"
		end
		local f16_local24 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f16_arg1.rank - 1, f16_arg1.daysPlayedInLast5Days + 5)
		local f16_local25 = f16_local0 / 4
		f16_arg0.body.rankIconContainer = LUI.UIElement.new({
			leftAnchor = true,
			rightAnchor = false,
			left = 0,
			right = f16_local25,
			topAnchor = true,
			bottomAnchor = false,
			top = 0,
			bottom = f16_local25
		})
		f16_arg0.body.emblemContainer:addElement(f16_arg0.body.rankIconContainer)
		f16_arg0.body.rankIcon = LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0,
			alpha = 1,
			material = RegisterMaterial(f16_local24)
		})
		f16_arg0.body.rankIconContainer:addElement(f16_arg0.body.rankIcon)
	end
end

CoD.LobbyPanes.AddMissingDLCNames = function (f17_arg0, f17_arg1, f17_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f17_arg2, -f17_arg2)
	Widget:setTopBottom(false, true, -(CoD.CoD9Button.Height * 3) - CoD.ButtonPrompt.Height, -CoD.ButtonPrompt.Height)
	Widget:setAlpha(0)
	f17_arg0.body.overviewContainer:addElement(Widget)
	local f17_local1 = 24
	local f17_local2 = 5
	Widget.warningIcon = LUI.UIImage.new()
	Widget.warningIcon:setLeftRight(true, false, 0, f17_local1)
	Widget.warningIcon:setTopBottom(true, false, 0, f17_local1)
	Widget.warningIcon:setImage(RegisterMaterial("cac_restricted"))
	Widget:addElement(Widget.warningIcon)
	local f17_local3 = "Default"
	local f17_local4 = CoD.fonts[f17_local3]
	local f17_local5 = CoD.textSize[f17_local3]
	Widget.warningLabel = LUI.UIText.new()
	Widget.warningLabel:setLeftRight(true, true, f17_local1 + f17_local2, 0)
	Widget.warningLabel:setTopBottom(true, false, 0, f17_local5)
	Widget.warningLabel:setFont(f17_local4)
	Widget.warningLabel:setRGB(CoD.red.r, CoD.red.g, CoD.red.b)
	Widget.warningLabel:setAlignment(LUI.Alignment.Left)
	Widget:addElement(Widget.warningLabel)
	local f17_local6 = 0
	local f17_local7 = ""
	local f17_local8 = Engine.PartyGetMissingMapPacks(f17_arg1.xuid)
	local f17_local9
	if f17_local8 == nil or #f17_local8 <= 0 then
		f17_local9 = false
	else
		f17_local9 = true
	end
	if f17_local9 then
		Widget:setAlpha(1)
		for f17_local13, f17_local14 in ipairs(f17_local8) do
			if f17_local6 >= 1 then
				f17_local7 = f17_local7 .. ", "
			end
			f17_local7 = f17_local7 .. Engine.Localize("MENU_" .. f17_local14 .. "_MAP_PACK_NAME")
			f17_local6 = f17_local6 + 1
		end
	else
		Widget:setAlpha(0)
	end
	if f17_local6 == 1 then
		Widget.warningLabel:setText(Engine.Localize("MPUI_MISSING_MAP_PACK") .. " " .. f17_local7)
	elseif f17_local6 > 1 then
		Widget.warningLabel:setText(Engine.Localize("MPUI_MISSING_MAP_PACKS") .. " " .. f17_local7)
	else
		Widget.warningLabel:setText("")
	end
end

CoD.LobbyPanes.populateStatsPaneElements = function (f18_arg0, f18_arg1)
	if f18_arg0.body.statsContainer ~= nil then
		f18_arg0.body.statsContainer:removeAllChildren()
	end
	if f18_arg0.selectedPlayerXuid == nil then
		return 
	end
	f18_arg0.body.statsContainer = LUI.UIElement.new()
	f18_arg0.body.statsContainer:setLeftRight(true, true, 0, 0)
	f18_arg0.body.statsContainer:setTopBottom(true, true, CoD.Menu.TitleHeight, 0)
	f18_arg0.body:addElement(f18_arg0.body.statsContainer)
	if CoD.isZombie == false then
		if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == false then
			CoD.LobbyPanes.populateStatsPaneElements_Multiplayer(f18_arg0, Engine.GetPlayerInfoByXuid(f18_arg0.controller, f18_arg0.selectedPlayerXuid))
		else
			CoD.LobbyPanes.populateStatsPaneElements_MultiplayerLeague(f18_arg0, Engine.GetLeagueTeamInfo(f18_arg0.controller, f18_arg0.selectedLeagueTeamID))
		end
	else
		CoD.LobbyPanes.populateStatsPaneElements_Zombies(f18_arg0)
	end
end

CoD.LobbyPanes.populateStatsPaneElements_Multiplayer = function (f19_arg0, f19_arg1)
	local f19_local0 = 0
	local f19_local1 = 20
	local f19_local2 = 4
	local f19_local3 = CoD.Menu.Width / 2 - f19_local1 * 2
	local f19_local4 = f19_local3 * 0.66 + 4
	local f19_local5 = f19_local4 / 4
	local f19_local6 = f19_local5 * 5 - 1
	local f19_local7 = "Default"
	local f19_local8 = CoD.fonts[f19_local7]
	local f19_local9 = CoD.textSize[f19_local7]
	local f19_local10 = LUI.UIText.new()
	f19_local10:setLeftRight(true, false, f19_local1, f19_local1 + f19_local3)
	f19_local10:setTopBottom(true, false, f19_local0, f19_local0 + f19_local9)
	f19_local10:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f19_local10:setAlpha(0.4)
	f19_local10:setFont(f19_local8)
	f19_local10:setAlignment(LUI.Alignment.Left)
	f19_local10:setText(Engine.Localize("MENU_PUBLIC_MATCH_CAREER"))
	f19_arg0.body.statsContainer:addElement(f19_local10)
	f19_local0 = f19_local0 + f19_local9
	local f19_local11 = f19_local4 / 2
	local f19_local12 = f19_local6 / 2
	local f19_local13 = f19_local1
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f19_local13, f19_local13 + f19_local11)
	Widget:setTopBottom(true, false, f19_local0, f19_local0 + f19_local12)
	f19_arg0.body.statsContainer:addElement(Widget)
	local f19_local15 = LUI.UIImage.new()
	f19_local15:setLeftRight(true, true, 1, -1)
	f19_local15:setTopBottom(true, true, 1, -1)
	f19_local15:setRGB(0, 0, 0)
	f19_local15:setAlpha(0.4)
	Widget:addElement(f19_local15)
	local f19_local16 = LUI.UIImage.new()
	f19_local16:setLeftRight(true, true, f19_local2, -f19_local2)
	f19_local16:setTopBottom(true, false, f19_local2, 80)
	f19_local16:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f19_local16:setAlpha(0.1)
	Widget:addElement(f19_local16)
	if f19_arg1.kills then
		local Widget = 10
		local f19_local18 = LUI.UIText.new()
		f19_local18:setLeftRight(true, true, 0, 0)
		f19_local18:setTopBottom(false, false, -Widget - f19_local9, -Widget)
		f19_local18:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f19_local18:setAlpha(0.5)
		f19_local18:setAlignment(LUI.Alignment.Center)
		f19_local18:setText(Engine.Localize("MPUI_KILLS"))
		Widget:addElement(f19_local18)
		local f19_local19 = "Big"
		local f19_local20 = CoD.fonts[f19_local19]
		local f19_local21 = CoD.textSize[f19_local19]
		local f19_local22 = -10
		local f19_local23 = LUI.UIText.new()
		f19_local23:setLeftRight(true, true, 0, 0)
		f19_local23:setTopBottom(false, false, f19_local22, f19_local22 + f19_local21)
		f19_local23:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f19_local23:setFont(f19_local20)
		f19_local23:setAlignment(LUI.Alignment.Center)
		f19_local23:setText(f19_arg1.kills)
		Widget:addElement(f19_local23)
	end
	Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget:addElement(Widget.border)
	f19_local13 = f19_local13 + f19_local11
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f19_local13, f19_local13 + f19_local11)
	Widget:setTopBottom(true, false, f19_local0, f19_local0 + f19_local12)
	f19_arg0.body.statsContainer:addElement(Widget)
	local f19_local18 = LUI.UIImage.new()
	f19_local18:setLeftRight(true, true, 1, -1)
	f19_local18:setTopBottom(true, true, 1, -1)
	f19_local18:setRGB(0, 0, 0)
	f19_local18:setAlpha(0.4)
	Widget:addElement(f19_local18)
	local f19_local19 = LUI.UIImage.new()
	f19_local19:setLeftRight(true, true, f19_local2 - 1, -f19_local2)
	f19_local19:setTopBottom(true, false, f19_local2, 80)
	f19_local19:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f19_local19:setAlpha(0.1)
	Widget:addElement(f19_local19)
	if f19_arg1.wins then
		local f19_local20 = 10
		local f19_local21 = LUI.UIText.new()
		f19_local21:setLeftRight(true, true, 0, 0)
		f19_local21:setTopBottom(false, false, -f19_local20 - f19_local9, -f19_local20)
		f19_local21:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f19_local21:setAlpha(0.5)
		f19_local21:setAlignment(LUI.Alignment.Center)
		f19_local21:setText(Engine.Localize("MPUI_WINS"))
		Widget:addElement(f19_local21)
		local f19_local22 = "Big"
		local f19_local23 = CoD.fonts[f19_local22]
		local f19_local24 = CoD.textSize[f19_local22]
		local f19_local25 = -10
		local f19_local26 = LUI.UIText.new()
		f19_local26:setLeftRight(true, true, 0, 0)
		f19_local26:setTopBottom(false, false, f19_local25, f19_local25 + f19_local24)
		f19_local26:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f19_local26:setFont(f19_local23)
		f19_local26:setAlignment(LUI.Alignment.Center)
		f19_local26:setText(f19_arg1.wins)
		Widget:addElement(f19_local26)
	end
	Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget.border.leftBorder:close()
	Widget:addElement(Widget.border)
	f19_local0 = f19_local0 + f19_local12 + 20
	local f19_local20 = LUI.UIText.new()
	f19_local20:setLeftRight(true, false, f19_local1, f19_local1 + f19_local3)
	f19_local20:setTopBottom(true, false, f19_local0, f19_local0 + f19_local9)
	f19_local20:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f19_local20:setAlpha(0.4)
	f19_local20:setAlignment(LUI.Alignment.Left)
	f19_local20:setText(Engine.Localize("MENU_SHOWCASE"))
	f19_arg0.body.statsContainer:addElement(f19_local20)
	f19_local0 = f19_local0 + f19_local9
	local f19_local21 = 3
	local f19_local22 = 10
	for f19_local23 = 1, f19_local21, 1 do
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, f19_local1, f19_local1 + f19_local4)
		Widget:setTopBottom(true, false, f19_local0, f19_local0 + f19_local5)
		f19_arg0.body.statsContainer:addElement(Widget)
		local f19_local28 = LUI.UIImage.new()
		f19_local28:setLeftRight(true, true, 1, -1)
		f19_local28:setTopBottom(true, true, 1, -1)
		f19_local28:setRGB(0, 0, 0)
		f19_local28:setAlpha(0.4)
		Widget:addElement(f19_local28)
		local f19_local29 = LUI.UIImage.new()
		f19_local29:setLeftRight(true, true, f19_local2 - 1, -f19_local2)
		f19_local29:setTopBottom(true, false, f19_local2, f19_local5 * 0.4)
		f19_local29:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
		f19_local29:setAlpha(0.1)
		Widget:addElement(f19_local29)
		local f19_local30 = LUI.UIImage.new()
		f19_local30:setLeftRight(true, true, 2, -2)
		f19_local30:setTopBottom(true, true, 2, -2)
		f19_local30:setAlpha(0)
		Widget:addElement(f19_local30)
		local f19_local31 = 2
		local f19_local32 = LUI.UIText.new()
		f19_local32:setLeftRight(true, true, f19_local31 + 2, 0)
		f19_local32:setTopBottom(false, true, -f19_local31 - f19_local9, -f19_local31)
		f19_local32:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f19_local32:setAlignment(LUI.Alignment.Left)
		f19_local32:setText("")
		Widget:addElement(f19_local32)
		Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
		Widget:addElement(Widget.border)
		local f19_local33 = nil
		if f19_arg0.selectedPlayerXuid and f19_arg0.selectedPlayerXuid ~= "" and f19_arg0.selectedPlayerXuid ~= "0" then
			f19_local33 = Engine.GetCombatRecordBackgroundId(f19_arg0.controller, f19_arg0.selectedPlayerXuid, f19_local23 - 1)
		end
		if f19_local33 and f19_local33 ~= 0 then
			f19_local30:setupDrawBackgroundById(f19_local33)
			f19_local30:setAlpha(1)
			local f19_local34 = CoD.EmblemBackgroundSelector.GetChallengeInformation(f19_arg0.controller, f19_local33)
			if f19_local34 and f19_local34.challengeName then
				f19_local32:setText(f19_local34.challengeName)
			else
				f19_local32:setText(Engine.Localize(CoD.EmblemBackgroundSelector.GetDefaultBackgroundName(f19_arg0.controller, f19_local33)))
			end
		end
		f19_local0 = f19_local0 + f19_local5 + f19_local22
	end
end

CoD.LobbyPanes.LeagueLB_ButtonCreator = function (f20_arg0, f20_arg1)
	f20_arg1.loading = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.textSize.Default / 2,
		bottom = CoD.textSize.Default / 2,
		font = CoD.fonts.Default,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		alignment = LUI.Alignment.Center
	})
	f20_arg1:addElement(f20_arg1.loading)
	f20_arg1.lbrank = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.LeagueLeaderboard.LBRANK_XLEFT + CoD.LeagueLeaderboard.PADDING,
		right = CoD.LeagueLeaderboard.LBRANK_XRIGHT - CoD.LeagueLeaderboard.PADDING,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.textSize.Default / 2,
		bottom = CoD.textSize.Default / 2,
		font = CoD.fonts.Default,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		alignment = LUI.Alignment.Right
	})
	f20_arg1:addElement(f20_arg1.lbrank)
	f20_arg1.name = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.LeagueLeaderboard.NAME_XLEFT + CoD.LeagueLeaderboard.PADDING,
		right = CoD.LeagueLeaderboard.NAME_XLEFT - CoD.LeagueLeaderboard.PADDING,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.textSize.Default / 2,
		bottom = CoD.textSize.Default / 2,
		font = CoD.fonts.Default,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		alignment = LUI.Alignment.Left
	})
	f20_arg1:addElement(f20_arg1.name)
	f20_arg1.dataCol = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = CoD.LeagueLeaderboard.NAME_XRIGHT + CoD.LeagueLeaderboard.PADDING,
		right = -20,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.textSize.Default / 2,
		bottom = CoD.textSize.Default / 2,
		font = CoD.fonts.Default,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		alignment = LUI.Alignment.Right
	})
	f20_arg1:addElement(f20_arg1.dataCol)
end

local f0_local0 = function (f21_arg0, f21_arg1)
	if f21_arg1.success and f21_arg0.leagueInfo and f21_arg0.leagueInfo.teamID and f21_arg1.teamID == f21_arg0.leagueInfo.teamID then
		CoD.LobbyPanes.populateStatsPaneElements_MultiplayerLeague(f21_arg0, f21_arg0.leagueInfo)
	end
end

CoD.LobbyPanes.populateStatsPaneElements_MultiplayerLeague = function (f22_arg0, f22_arg1)
	if not f22_arg0 or not f22_arg0.body or not f22_arg0.body.statsContainer then
		return 
	end
	local f22_local0 = CoD.textSize.Default - 8
	local f22_local1 = 20
	local f22_local2 = 4
	local f22_local3 = CoD.Menu.Width / 2 - f22_local1
	local f22_local4 = "Default"
	local f22_local5 = CoD.fonts[f22_local4]
	local f22_local6 = CoD.textSize[f22_local4]
	local f22_local7 = "Big"
	local f22_local8 = CoD.fonts[f22_local7]
	local f22_local9 = CoD.textSize[f22_local7]
	local f22_local10 = "ExtraSmall"
	local f22_local11 = CoD.fonts[f22_local10]
	local f22_local12 = CoD.textSize[f22_local10]
	local f22_local13 = Engine.GetLeague()
	local f22_local14 = f22_arg1.teamID
	local f22_local15 = f22_arg0.controller
	local f22_local16 = false
	local f22_local17, f22_local18, f22_local19, f22_local20, f22_local21, f22_local22, f22_local23 = false
	if not f22_local13 or not CoD.PlayerIdentity.ShowLeagueInfo(f22_arg1) then
		return 
	end
	f22_arg0.leagueInfo = f22_arg1
	local f22_local24 = f22_local13.id
	f22_local17 = Engine.LeagueIsPreSeason(f22_local24)
	f22_arg0:registerEventHandler("league_team_all_info_fetched", f0_local0)
	f22_arg0:registerEventHandler("league_lb_data_fetched", f0_local0)
	local f22_local25 = Engine.FetchAllInfoForTeamInLeague(f22_local15, f22_local14, f22_local24, 5)
	local f22_local26 = 128
	if not f22_arg0.spinner then
		f22_arg0.spinner = CoD.GetCenteredImage(f22_local26, f22_local26, "lui_loader")
		f22_arg0.body.statsContainer:addElement(f22_arg0.spinner)
	end
	if not f22_local25 then
		return 
	end
	local f22_local27, f22_local28 = Engine.GetLeagueTeamSubdivisionInfos(f22_local15, f22_local14)
	if f22_local27 ~= "fetched" then
		return 
	elseif f22_local28 then
		f22_local23 = CoD.PlayerIdentity.FindTeamSubdivisionInfo(f22_local28, f22_local24)
		if not f22_local23 then
			f22_local16 = true
		end
	end
	f22_local19 = Engine.GetLeagueLbData(f22_local15)
	if f22_local19 then
		f22_local18 = CoD.PlayerIdentity.FindLeagueLbData(f22_local19, f22_local14)
	end
	local f22_local29 = ""
	if not f22_local17 and not f22_local16 and f22_local23 and f22_local23.subdivisionName then
		f22_local29 = Engine.Localize("MENU_SUBDIVISION_X", f22_local23.subdivisionName)
	end
	local f22_local30 = ""
	if f22_local17 then
		f22_local30 = Engine.Localize("LEAGUE_PRESEASON")
	elseif f22_local16 then
		f22_local30 = Engine.Localize("LEAGUE_AWAITING_PLACEMENT")
	elseif f22_local23 and f22_local23.divisionName then
		f22_local30 = UIExpression.ToUpper(nil, f22_local23.divisionName)
	end
	f22_arg0.spinner = nil
	f22_arg0.body.statsContainer:removeAllChildren()
	local f22_local31 = LUI.UIText.new()
	f22_local31:setLeftRight(true, false, f22_local1, f22_local1 + f22_local3)
	f22_local31:setTopBottom(true, false, f22_local0, f22_local0 + f22_local9)
	f22_local31:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f22_local31:setFont(f22_local8)
	f22_local31:setAlignment(LUI.Alignment.Left)
	f22_local31:setText(f22_local30)
	f22_arg0.body.statsContainer:addElement(f22_local31)
	f22_local0 = f22_local0 + f22_local9
	local f22_local32 = LUI.UIText.new()
	f22_local32:setLeftRight(true, false, f22_local1, f22_local1 + f22_local3)
	f22_local32:setTopBottom(true, false, f22_local0, f22_local0 + f22_local12)
	f22_local32:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f22_local32:setFont(f22_local11)
	f22_local32:setAlignment(LUI.Alignment.Left)
	f22_local32:setText(f22_local29)
	f22_arg0.body.statsContainer:addElement(f22_local32)
	f22_local0 = f22_local0 + 10 + CoD.textSize.Default
	local f22_local33 = 250
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f22_local1, f22_local1 + f22_local3)
	Widget:setTopBottom(true, false, f22_local0, f22_local0 + f22_local33)
	f22_arg0.body.statsContainer:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, CoD.textSize.Default)
	local f22_local36 = Engine.Localize("MENU_TEAM")
	if f22_local28 and f22_local28.valid and f22_local28.isSolo then
		f22_local36 = Engine.Localize("LEAGUE_SOLO_COMPETITOR")
	end
	local f22_local37 = 8
	local f22_local38 = 70
	local f22_local39 = CoD.LeagueLeaderboard.GetListBoxHeaderText(f22_local37, f22_local37, Engine.Localize("MENU_RANK"), "Left")
	local f22_local40 = CoD.LeagueLeaderboard.GetListBoxHeaderText(f22_local38, 0, f22_local36, "Left")
	local f22_local41 = CoD.LeagueLeaderboard.GetListBoxHeaderText(0, -8, Engine.Localize("MENU_RANK_POINTS"), "Right", true)
	f22_local39:setAlpha(0.4)
	f22_local40:setAlpha(0.4)
	f22_local41:setAlpha(0.4)
	Widget:addElement(f22_local39)
	Widget:addElement(f22_local40)
	Widget:addElement(f22_local41)
	Widget:addElement(Widget)
	local f22_local42 = LUI.UIImage.new()
	f22_local42:setLeftRight(true, true, 0, 0)
	f22_local42:setTopBottom(true, true, CoD.textSize.Default, 0)
	f22_local42:setRGB(0, 0, 0)
	f22_local42:setAlpha(0.25)
	Widget:addElement(f22_local42)
	local f22_local43 = 5
	local f22_local44 = f22_local33 / f22_local43
	local f22_local45 = {
		left = 0,
		top = CoD.textSize.Default,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}
	if not f22_local16 and not f22_local17 then
		local f22_local46 = CoD.LeaderboardPreviewList.new(f22_local15, f22_local45, f22_local43, f22_local44, nil, nil, true)
		f22_local46:registerEventHandler("league_changed", CoD.NullFunction)
		f22_local46:processEvent({
			name = "league_lb_data_fetched",
			controller = f22_arg0.controller
		})
		Widget:addElement(f22_local46)
	elseif f22_local17 then
		Widget:addElement(CoD.GetTextElem("Default", Center, Engine.Localize("LEAGUE_PRESEASON_DESC"), CoD.gray, 50))
	elseif f22_local16 then
		Widget:addElement(CoD.GetTextElem("Default", Center, Engine.Localize("LEAGUE_IN_PLACEMENT_MATCHES"), CoD.gray, 50))
	end
	f22_local0 = f22_local0 + f22_local33 + 15 + f22_local6
	local f22_local46 = f22_local3 / 4
	local f22_local47 = 140
	local f22_local48 = f22_local1
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f22_local48, f22_local48 + f22_local46)
	Widget:setTopBottom(true, false, f22_local0, f22_local0 + f22_local47)
	f22_arg0.body.statsContainer:addElement(Widget)
	local f22_local50 = LUI.UIImage.new()
	f22_local50:setLeftRight(true, true, 1, -1)
	f22_local50:setTopBottom(true, true, 1, -1)
	f22_local50:setRGB(0, 0, 0)
	f22_local50:setAlpha(0.4)
	Widget:addElement(f22_local50)
	local f22_local51 = LUI.UIImage.new()
	f22_local51:setLeftRight(true, true, f22_local2, -f22_local2)
	f22_local51:setTopBottom(true, false, f22_local2, 80)
	f22_local51:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f22_local51:setAlpha(0.1)
	Widget:addElement(f22_local51)
	if f22_local18 and not f22_local16 and not f22_local17 then
		f22_local22 = Engine.GetLeagueDivisionIcon(f22_local23.divisionID, false, f22_local18.rank)
	end
	local f22_local52 = 10
	local f22_local53 = LUI.UIText.new()
	f22_local53:setLeftRight(true, true, 0, 0)
	f22_local53:setTopBottom(true, false, f22_local52, f22_local52 + CoD.textSize.ExtraSmall)
	f22_local53:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f22_local53:setFont(CoD.fonts.ExtraSmall)
	f22_local53:setAlignment(LUI.Alignment.Center)
	if f22_local22 and f22_local22.bracketRankPosition > 0 then
		Widget:addElement(f22_local53)
		f22_local53:setText(Engine.Localize("MENU_LEAGUE_TOP_N", f22_local22.bracketRankPosition))
	end
	f22_local52 = f22_local52 + f22_local6
	local f22_local54 = f22_local46 - 8
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f22_local54 / 2, f22_local54 / 2)
	Widget:setTopBottom(true, false, f22_local52, f22_local52 + f22_local54)
	Widget:addElement(Widget)
	if f22_local22 then
		Widget:addElement(LUI.UIStreamedImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0,
			material = f22_local22.divisionIcon,
			alpha = 1
		}))
	end
	Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget:addElement(Widget.border)
	f22_local48 = f22_local48 + f22_local46
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f22_local48, f22_local48 + f22_local46)
	Widget:setTopBottom(true, false, f22_local0, f22_local0 + f22_local47)
	f22_arg0.body.statsContainer:addElement(Widget)
	local f22_local57 = LUI.UIImage.new()
	f22_local57:setLeftRight(true, true, 1, -1)
	f22_local57:setTopBottom(true, true, 1, -1)
	f22_local57:setRGB(0, 0, 0)
	f22_local57:setAlpha(0.4)
	Widget:addElement(f22_local57)
	local f22_local58 = LUI.UIImage.new()
	f22_local58:setLeftRight(true, true, f22_local2 - 1, -f22_local2)
	f22_local58:setTopBottom(true, false, f22_local2, 80)
	f22_local58:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f22_local58:setAlpha(0.1)
	Widget:addElement(f22_local58)
	local f22_local59 = 10
	local f22_local60 = LUI.UIText.new()
	f22_local60:setLeftRight(true, true, 0, 0)
	f22_local60:setTopBottom(false, false, -f22_local59 - f22_local6, -f22_local59)
	f22_local60:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f22_local60:setAlpha(0.5)
	f22_local60:setAlignment(LUI.Alignment.Center)
	f22_local60:setText(Engine.Localize("MENU_WIN_STREAK"))
	if not CoD.isPC then
		Widget:addElement(f22_local60)
	end
	local f22_local61 = "--"
	if not f22_local16 and not f22_local17 and f22_local18 then
		f22_local61 = math.max(0, tonumber(f22_local18.ints[CoD.LeaguesData.LEAGUE_STAT_INT_STREAK]))
	end
	local f22_local62 = "Big"
	local f22_local63 = CoD.fonts[f22_local62]
	local f22_local64 = CoD.textSize[f22_local62]
	local f22_local65 = -10
	local f22_local66 = LUI.UIText.new()
	f22_local66:setLeftRight(true, true, 0, 0)
	f22_local66:setTopBottom(false, false, f22_local65, f22_local65 + f22_local64)
	f22_local66:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f22_local66:setFont(f22_local63)
	f22_local66:setAlignment(LUI.Alignment.Center)
	f22_local66:setText(f22_local61)
	if not CoD.isPC then
		Widget:addElement(f22_local66)
	end
	Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget.border.leftBorder:close()
	Widget:addElement(Widget.border)
	f22_local48 = f22_local48 + f22_local46
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f22_local48, f22_local48 + f22_local46)
	Widget:setTopBottom(true, false, f22_local0, f22_local0 + f22_local47)
	f22_arg0.body.statsContainer:addElement(Widget)
	local f22_local68 = LUI.UIImage.new()
	f22_local68:setLeftRight(true, true, 1, -1)
	f22_local68:setTopBottom(true, true, 1, -1)
	f22_local68:setRGB(0, 0, 0)
	f22_local68:setAlpha(0.4)
	Widget:addElement(f22_local68)
	local f22_local69 = LUI.UIImage.new()
	f22_local69:setLeftRight(true, true, f22_local2 - 1, -f22_local2)
	f22_local69:setTopBottom(true, false, f22_local2, 80)
	f22_local69:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f22_local69:setAlpha(0.1)
	Widget:addElement(f22_local69)
	local f22_local70 = 10
	local f22_local71 = LUI.UIText.new()
	f22_local71:setLeftRight(true, true, 0, 0)
	f22_local71:setTopBottom(false, false, -f22_local70 - f22_local6, -f22_local70)
	f22_local71:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f22_local71:setAlpha(0.5)
	f22_local71:setAlignment(LUI.Alignment.Center)
	f22_local71:setText(Engine.Localize("MENU_SEASON_WINS"))
	Widget:addElement(f22_local71)
	local f22_local72 = "--"
	if f22_local18 and not f22_local16 and not f22_local17 then
		f22_local72 = f22_local18.ints[CoD.LeaguesData.LEAGUE_STAT_INT_WINS]
	end
	local f22_local73 = "Big"
	local f22_local74 = CoD.fonts[f22_local73]
	local f22_local75 = CoD.textSize[f22_local73]
	local f22_local76 = -10
	local f22_local77 = LUI.UIText.new()
	f22_local77:setLeftRight(true, true, 0, 0)
	f22_local77:setTopBottom(false, false, f22_local76, f22_local76 + f22_local75)
	f22_local77:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f22_local77:setFont(f22_local74)
	f22_local77:setAlignment(LUI.Alignment.Center)
	f22_local77:setText(f22_local72)
	Widget:addElement(f22_local77)
	Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget.border.leftBorder:close()
	Widget:addElement(Widget.border)
	f22_local48 = f22_local48 + f22_local46
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f22_local48, f22_local48 + f22_local46)
	Widget:setTopBottom(true, false, f22_local0, f22_local0 + f22_local47)
	f22_arg0.body.statsContainer:addElement(Widget)
	local f22_local79 = LUI.UIImage.new()
	f22_local79:setLeftRight(true, true, 1, -1)
	f22_local79:setTopBottom(true, true, 1, -1)
	f22_local79:setRGB(0, 0, 0)
	f22_local79:setAlpha(0.4)
	Widget:addElement(f22_local79)
	local f22_local80 = LUI.UIImage.new()
	f22_local80:setLeftRight(true, true, f22_local2 - 1, -f22_local2)
	f22_local80:setTopBottom(true, false, f22_local2, 80)
	f22_local80:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f22_local80:setAlpha(0.1)
	Widget:addElement(f22_local80)
	local f22_local81 = 10
	local f22_local82 = LUI.UIText.new()
	f22_local82:setLeftRight(true, true, 0, 0)
	f22_local82:setTopBottom(false, false, -f22_local81 - f22_local6, -f22_local81)
	f22_local82:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f22_local82:setAlpha(0.5)
	f22_local82:setAlignment(LUI.Alignment.Center)
	f22_local82:setText(Engine.Localize("CH_LIFETIME_WINS"))
	Widget:addElement(f22_local82)
	local f22_local83 = "--"
	if f22_local18 then
		f22_local83 = f22_local18.ints[CoD.LeaguesData.LEAGUE_STAT_INT_CAREER_WINS]
	end
	local f22_local84 = "Big"
	local f22_local85 = CoD.fonts[f22_local84]
	local f22_local86 = CoD.textSize[f22_local84]
	local f22_local87 = -10
	local f22_local88 = LUI.UIText.new()
	f22_local88:setLeftRight(true, true, 0, 0)
	f22_local88:setTopBottom(false, false, f22_local87, f22_local87 + f22_local86)
	f22_local88:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f22_local88:setFont(f22_local85)
	f22_local88:setAlignment(LUI.Alignment.Center)
	f22_local88:setText(f22_local83)
	Widget:addElement(f22_local88)
	Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget.border.leftBorder:close()
	Widget:addElement(Widget.border)
end

CoD.LobbyPanes.GetFavoriteMapGameTypeLocation_Zombies = function (f23_arg0)
	local f23_local0 = Engine.GetPlayerStats(f23_arg0.controller)
	local f23_local1 = CoD.Zombie.MAP_ZM_TRANSIT
	local f23_local2 = CoD.Zombie.GAMETYPE_ZCLASSIC
	local f23_local3 = CoD.Zombie.START_LOCATION_TRANSIT
	local f23_local4 = 0
	local f23_local5 = 0
	local f23_local6, f23_local7, f23_local8 = nil
	for f23_local9 = 1, #CoD.Zombie.Maps, 1 do
		for f23_local20, f23_local21 in pairs(Engine.GetStartLocsZombie(CoD.Zombie.Maps[f23_local9])) do
			if f23_local0.PlayerStatsByStartLocation[f23_local21.ref] ~= nil then
				f23_local6 = f23_local0.PlayerStatsByStartLocation[f23_local21.ref].startLocationGameTypeStats
				for f23_local18, f23_local19 in pairs(Engine.GetGamemodesZombie(CoD.Zombie.Maps[f23_local9], f23_local21.ref)) do
					if f23_local6[f23_local19.ref] ~= nil then
						f23_local4 = f23_local6[f23_local19.ref].stats.TIME_PLAYED_TOTAL.statValue:get()
						if f23_local5 < f23_local4 then
							f23_local5 = f23_local4
							f23_local2 = f23_local19.ref
							f23_local3 = f23_local21.ref
							f23_local1 = CoD.Zombie.Maps[f23_local9]
						end
					end
				end
			end
		end
	end
	return f23_local1, f23_local2, f23_local3
end

CoD.LobbyPanes.populateStatsPaneElements_Zombies = function (f24_arg0)
	local f24_local0 = 22
	f24_arg0.body.titleContainer = LUI.UIHorizontalList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 100,
		topAnchor = true,
		bottomAnchor = false,
		top = f24_local0,
		bottom = f24_local0 + CoD.textSize.Default
	})
	f24_arg0.body.statsContainer:addElement(f24_arg0.body.titleContainer)
	local f24_local1 = LUI.UITightText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.textSize.Default
	})
	f24_local1:setText(Engine.Localize("ZMUI_CAREER_STATS_VS_CAPS"))
	f24_arg0.body.titleContainer:addElement(f24_local1)
	f24_arg0.body.statsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_kills", math.random(0, 100), UIExpression.GetDStat(f24_arg0.controller, "PlayerStatsList", "KILLS", "StatValue"), Engine.Localize("ZMUI_KILLS_CAPS"), 0, 0))
	local f24_local2 = math.random(0, 100)
	local f24_local3 = UIExpression.GetDStat(f24_arg0.controller, "PlayerStatsList", "TOTAL_SHOTS", "StatValue")
	f24_arg0.body.statsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_bulletsfired", f24_local2, f24_local3, Engine.Localize("ZMUI_TOTAL_SHOTS_CAPS"), 1, 0))
	f24_arg0.body.statsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_downs", math.random(0, 100), UIExpression.GetDStat(f24_arg0.controller, "PlayerStatsList", "DOWNS", "StatValue"), Engine.Localize("ZMUI_DOWNS_CAPS"), 2, 0))
	f24_arg0.body.statsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_revives", math.random(0, 100), UIExpression.GetDStat(f24_arg0.controller, "PlayerStatsList", "REVIVES", "StatValue"), Engine.Localize("ZMUI_REVIVES_CAPS"), 3, 0))
	f24_arg0.body.statsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_grenadekills", math.random(0, 100), UIExpression.GetDStat(f24_arg0.controller, "PlayerStatsList", "GRENADE_KILLS", "StatValue"), Engine.Localize("ZMUI_GRENADE_KILLS_CAPS"), 0, 1))
	f24_arg0.body.statsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_headshots", math.random(0, 100), UIExpression.GetDStat(f24_arg0.controller, "PlayerStatsList", "HEADSHOTS", "StatValue"), Engine.Localize("ZMUI_HEADSHOTS_CAPS"), 1, 1))
	f24_arg0.body.statsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_dealths", math.random(0, 100), UIExpression.GetDStat(f24_arg0.controller, "PlayerStatsList", "DEATHS", "StatValue"), Engine.Localize("ZMUI_DEATHS_CAPS"), 2, 1))
	f24_arg0.body.statsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_gibs", math.random(0, 100), UIExpression.GetDStat(f24_arg0.controller, "PlayerStatsList", "GIBS", "StatValue"), Engine.Localize("ZMUI_GIBS_CAPS"), 3, 1))
	f24_arg0.body.statsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_perksdrank", math.random(0, 100), UIExpression.GetDStat(f24_arg0.controller, "PlayerStatsList", "PERKS_DRANK", "StatValue"), Engine.Localize("ZMUI_PERKS_DRANK_CAPS"), 0, 2))
	f24_arg0.body.statsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_doorspurchased", math.random(0, 100), UIExpression.GetDStat(f24_arg0.controller, "PlayerStatsList", "DOORS_PURCHASED", "StatValue"), Engine.Localize("ZMUI_DOORS_OPENED_CAPS"), 1, 2))
	local f24_local4 = math.random(0, 100)
	local f24_local5 = UIExpression.GetDStat(f24_arg0.controller, "PlayerStatsList", "HITS", "StatValue")
	local f24_local6 = "0.00"
	if f24_local3 > 0 then
		f24_local6 = string.format("%.2f", f24_local5 / f24_local3)
	end
	f24_arg0.body.statsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_accuracy", f24_local4, f24_local6, Engine.Localize("ZMUI_ACCURACY_CAPS"), 2, 2))
	f24_arg0.body.statsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_distancetraveled", math.random(0, 100), UIExpression.GetDStat(f24_arg0.controller, "PlayerStatsList", "DISTANCE_TRAVELED", "StatValue"), Engine.Localize("ZMUI_DISTANCE_TRAVELED_CAPS"), 3, 2))
	local f24_local7, f24_local8, f24_local9 = CoD.LobbyPanes.GetFavoriteMapGameTypeLocation_Zombies(f24_arg0)
	local f24_local10 = UIExpression.TableLookup(f24_arg0.controller, CoD.gametypesTable, 0, 0, 1, f24_local8, 9)
	local f24_local11 = 5
	local f24_local12 = CoD.DisplayStatBox.StatsPaneWidth / 2 - f24_local11
	local f24_local13 = f24_local12 * 0.6
	local f24_local14 = 0
	local f24_local15 = 3
	local f24_local16 = 20
	local f24_local17 = CoD.DisplayStatBox.StatBoxY + CoD.DisplayStatBox.StatBoxYIncr * f24_local15 + CoD.textSize.Default + f24_local14
	local Widget = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f24_local12 - f24_local11 + f24_local16,
		right = -f24_local11 + f24_local16,
		topAnchor = true,
		bottomAnchor = false,
		top = f24_local17,
		bottom = f24_local17 + f24_local13
	})
	f24_arg0.body.statsContainer:addElement(Widget)
	Widget:addElement(LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 5,
		bottom = 5,
		material = RegisterMaterial("menu_zm_popup")
	}))
	Widget:addElement(LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 5,
		bottom = -20,
		material = RegisterMaterial("menu_" .. CoD.Zombie.GetMapName(f24_local7) .. "_" .. f24_local10 .. "_" .. f24_local9)
	}))
	local f24_local19 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 1,
		topAnchor = true,
		bottomAnchor = false,
		top = -CoD.textSize.Default,
		bottom = 0
	})
	f24_local19:setText(Engine.Localize("ZMUI_FAVORITE_CAPS"))
	Widget:addElement(f24_local19)
	local f24_local20 = 20
	local f24_local21 = 25
	local f24_local22 = Dvar.loc_language:get()
	if f24_local22 == CoD.LANGUAGE_FULLJAPANESE or f24_local22 == CoD.LANGUAGE_JAPANESE then
		f24_local20 = f24_local20 * 0.65
		f24_local21 = f24_local21 * 0.65
	end
	local f24_local23 = -10
	local f24_local24 = f24_local23 - f24_local20
	local f24_local25 = f24_local24
	local f24_local26 = f24_local25 - f24_local21
	local f24_local27 = LUI.UIText.new()
	f24_local27:setLeftRight(false, true, -11, -10)
	f24_local27:setTopBottom(false, true, f24_local26, f24_local25)
	f24_local27:setFont(CoD.fonts.Condensed)
	f24_local27:setText(UIExpression.ToUpper(nil, Engine.Localize(UIExpression.TableLookup(nil, UIExpression.GetCurrentMapTableName(), 0, f24_local7, 3))))
	Widget:addElement(f24_local27)
	local f24_local28 = LUI.UIText.new()
	f24_local28:setLeftRight(false, true, -11, -10)
	f24_local28:setTopBottom(false, true, f24_local24, f24_local23)
	f24_local28:setFont(CoD.fonts.Condensed)
	local f24_local29 = nil
	if not CoD.isZombie then
		f24_local29 = Engine.Localize(UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, f24_local8, 2))
	else
		f24_local29 = CoD.GetZombieGameTypeDescription(f24_local8, f24_local7)
	end
	local f24_local30 = Engine.Localize(UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 5, 3, f24_local9, 4))
	local f24_local31 = nil
	if f24_local8 == CoD.Zombie.GAMETYPE_ZCLASSIC then
		f24_local31 = f24_local29
	else
		f24_local31 = f24_local30 .. " / " .. f24_local29
	end
	f24_local28:setText(f24_local31)
	Widget:addElement(f24_local28)
end

CoD.LobbyPanes.populateSurvivalStatsPaneElements = function (f25_arg0)
	CoD.LobbyPanes.populateZombieStatsPaneElements(f25_arg0, CoD.Zombie.GAMETYPEGROUP_ZSURVIVAL)
end

CoD.LobbyPanes.populateEncountersStatsPaneElements = function (f26_arg0)
	CoD.LobbyPanes.populateZombieStatsPaneElements(f26_arg0, CoD.Zombie.GAMETYPEGROUP_ZENCOUNTER)
end

CoD.LobbyPanes.GetFavoriteWeaponByGameTypeGroup_Zombies = function (f27_arg0, f27_arg1)
	local f27_local0 = Engine.GetPlayerStats(f27_arg0.controller)
	f27_local0 = f27_local0.ItemStats
	local f27_local1 = 7
	local f27_local2 = 0
	local f27_local3 = 0
	local f27_local4 = nil
	for f27_local5 = 0, #f27_local0 - 1, 1 do
		f27_local2 = 0
		if f27_arg1 == CoD.Zombie.GAMETYPEGROUP_ZENCOUNTER then
			f27_local2 = f27_local0[f27_local5].itemStatsByGameTypeGroup[f27_arg1].stats.TIMEUSED.statValue:get()
		elseif f27_arg1 == CoD.Zombie.GAMETYPEGROUP_ZSURVIVAL then
			f27_local2 = f27_local0[f27_local5].itemStatsByGameTypeGroup[f27_arg1].stats.TIMEUSED.statValue:get() + f27_local0[f27_local5].itemStatsByGameTypeGroup[CoD.Zombie.GAMETYPEGROUP_ZCLASSIC].stats.TIMEUSED.statValue:get()
		end
		if f27_local3 < f27_local2 then
			f27_local3 = f27_local2
			f27_local1 = f27_local5
		end
	end
	return f27_local1
end

CoD.LobbyPanes.populateZombieStatsPaneElements = function (f28_arg0, f28_arg1)
	if f28_arg0.body.zombieStatsContainer ~= nil then
		f28_arg0.body.zombieStatsContainer:removeAllChildren()
	end
	f28_arg0.body.zombieStatsContainer = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.Menu.TitleHeight,
		bottom = 0
	})
	f28_arg0.body:addElement(f28_arg0.body.zombieStatsContainer)
	local f28_local0 = 22
	f28_arg0.body.titleContainer = LUI.UIHorizontalList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 100,
		topAnchor = true,
		bottomAnchor = false,
		top = f28_local0,
		bottom = f28_local0 + CoD.textSize.Default
	})
	f28_arg0.body.zombieStatsContainer:addElement(f28_arg0.body.titleContainer)
	local f28_local1 = LUI.UITightText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.textSize.Default
	})
	if f28_arg1 == CoD.Zombie.GAMETYPEGROUP_ZSURVIVAL then
		f28_local1:setText(Engine.Localize("ZMUI_COOP_STATS_VS_CAPS"))
	else
		f28_local1:setText(Engine.Localize("ZMUI_VERSUS_STATS_VS_CAPS"))
	end
	f28_arg0.body.titleContainer:addElement(f28_local1)
	local f28_local2 = math.random(0, 100)
	local f28_local3 = UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", f28_arg1, "KILLS", "StatValue")
	local f28_local4 = math.random(0, 100)
	local f28_local5 = UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", f28_arg1, "GRENADE_KILLS", "StatValue")
	local f28_local6 = math.random(0, 100)
	local f28_local7 = UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", f28_arg1, "PERKS_DRANK", "StatValue")
	local f28_local8 = math.random(0, 100)
	local f28_local9 = UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", f28_arg1, "HEADSHOTS", "StatValue")
	local f28_local10 = math.random(0, 100)
	local f28_local11 = UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", f28_arg1, "DOWNS", "StatValue")
	local f28_local12 = math.random(0, 100)
	local f28_local13 = UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", f28_arg1, "DOORS_PURCHASED", "StatValue")
	local f28_local14 = math.random(0, 100)
	local f28_local15 = UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", f28_arg1, "TOTAL_SHOTS", "StatValue")
	local f28_local16 = math.random(0, 100)
	local f28_local17 = UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", f28_arg1, "HITS", "StatValue")
	local f28_local18 = math.random(0, 100)
	local f28_local19 = UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", f28_arg1, "GIBS", "StatValue")
	local f28_local20 = math.random(0, 100)
	local f28_local21 = UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", f28_arg1, "REVIVES", "StatValue")
	local f28_local22 = math.random(0, 100)
	local f28_local23 = UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", f28_arg1, "DEATHS", "StatValue")
	local f28_local24 = math.random(0, 100)
	local f28_local25 = UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", f28_arg1, "DISTANCE_TRAVELED", "StatValue")
	if f28_arg1 == CoD.Zombie.GAMETYPEGROUP_ZSURVIVAL then
		f28_local3 = f28_local3 + UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", CoD.Zombie.GAMETYPEGROUP_ZCLASSIC, "KILLS", "StatValue")
		f28_local5 = f28_local5 + f28_local5 + UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", CoD.Zombie.GAMETYPEGROUP_ZCLASSIC, "GRENADE_KILLS", "StatValue")
		f28_local7 = f28_local7 + UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", CoD.Zombie.GAMETYPEGROUP_ZCLASSIC, "PERKS_DRANK", "StatValue")
		f28_local9 = f28_local9 + UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", CoD.Zombie.GAMETYPEGROUP_ZCLASSIC, "HEADSHOTS", "StatValue")
		f28_local11 = f28_local11 + UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", CoD.Zombie.GAMETYPEGROUP_ZCLASSIC, "DOWNS", "StatValue")
		f28_local13 = f28_local13 + UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", CoD.Zombie.GAMETYPEGROUP_ZCLASSIC, "DOORS_PURCHASED", "StatValue")
		f28_local15 = f28_local15 + UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", CoD.Zombie.GAMETYPEGROUP_ZCLASSIC, "TOTAL_SHOTS", "StatValue")
		f28_local17 = f28_local17 + UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", CoD.Zombie.GAMETYPEGROUP_ZCLASSIC, "HITS", "StatValue")
		f28_local19 = f28_local19 + UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", CoD.Zombie.GAMETYPEGROUP_ZCLASSIC, "GIBS", "StatValue")
		f28_local21 = f28_local21 + UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", CoD.Zombie.GAMETYPEGROUP_ZCLASSIC, "REVIVES", "StatValue")
		f28_local23 = f28_local23 + UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", CoD.Zombie.GAMETYPEGROUP_ZCLASSIC, "DEATHS", "StatValue")
		f28_local25 = f28_local25 + UIExpression.GetDStat(f28_arg0.controller, "PlayerStatsByGameTypeGroup", CoD.Zombie.GAMETYPEGROUP_ZCLASSIC, "DISTANCE_TRAVELED", "StatValue")
	end
	local f28_local26 = "0.00"
	if f28_local15 > 0 then
		f28_local26 = string.format("%.2f", f28_local17 / f28_local15)
	end
	f28_arg0.body.zombieStatsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_kills", f28_local2, f28_local3, Engine.Localize("ZMUI_KILLS_CAPS"), 0, 0))
	f28_arg0.body.zombieStatsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_bulletsfired", f28_local14, f28_local15, Engine.Localize("ZMUI_TOTAL_SHOTS_CAPS"), 1, 0))
	f28_arg0.body.zombieStatsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_downs", f28_local10, f28_local11, Engine.Localize("ZMUI_DOWNS_CAPS"), 2, 0))
	f28_arg0.body.zombieStatsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_revives", f28_local20, f28_local21, Engine.Localize("ZMUI_REVIVES_CAPS"), 3, 0))
	f28_arg0.body.zombieStatsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_grenadekills", f28_local4, f28_local5, Engine.Localize("ZMUI_GRENADE_KILLS_CAPS"), 0, 1))
	f28_arg0.body.zombieStatsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_headshots", f28_local8, f28_local9, Engine.Localize("ZMUI_HEADSHOTS_CAPS"), 1, 1))
	f28_arg0.body.zombieStatsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_dealths", f28_local22, f28_local23, Engine.Localize("ZMUI_DEATHS_CAPS"), 2, 1))
	f28_arg0.body.zombieStatsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_gibs", f28_local18, f28_local19, Engine.Localize("ZMUI_GIBS_CAPS"), 3, 1))
	f28_arg0.body.zombieStatsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_perksdrank", f28_local6, f28_local7, Engine.Localize("ZMUI_PERKS_DRANK_CAPS"), 0, 2))
	f28_arg0.body.zombieStatsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_doorspurchased", f28_local12, f28_local13, Engine.Localize("ZMUI_DOORS_OPENED_CAPS"), 1, 2))
	f28_arg0.body.zombieStatsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_accuracy", f28_local16, f28_local26, Engine.Localize("ZMUI_ACCURACY_CAPS"), 2, 2))
	f28_arg0.body.zombieStatsContainer:addElement(CoD.DisplayStatBox.New("menu_zm_lobby_aar_icons_distancetraveled", f28_local24, f28_local25, Engine.Localize("ZMUI_DISTANCE_TRAVELED_CAPS"), 3, 2))
	local f28_local27 = 5
	local f28_local28 = CoD.DisplayStatBox.StatsPaneWidth / 2 - f28_local27
	local f28_local29 = f28_local28 * 0.6
	local f28_local30 = 0
	local f28_local31 = 3
	local f28_local32 = 20
	local f28_local33 = CoD.DisplayStatBox.StatBoxY + CoD.DisplayStatBox.StatBoxYIncr * f28_local31 + CoD.textSize.Default + f28_local30
	local Widget = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f28_local28 - f28_local27 + f28_local32,
		right = -f28_local27 + f28_local32,
		topAnchor = true,
		bottomAnchor = false,
		top = f28_local33,
		bottom = f28_local33 + f28_local29
	})
	f28_arg0.body.zombieStatsContainer:addElement(Widget)
	local f28_local35 = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 5,
		bottom = 5
	})
	f28_local35:setImage(RegisterMaterial("menu_zm_popup"))
	Widget:addElement(f28_local35)
	local f28_local36 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 1,
		topAnchor = true,
		bottomAnchor = false,
		top = -CoD.textSize.Default,
		bottom = 0
	})
	f28_local36:setText(Engine.Localize("ZMUI_FAVORITE_WEAPON_CAPS"))
	Widget:addElement(f28_local36)
	local f28_local37 = CoD.LobbyPanes.GetFavoriteWeaponByGameTypeGroup_Zombies(f28_arg0, f28_arg1)
	if f28_local37 > 0 then
		local f28_local38 = UIExpression.ToUpper(controller, Engine.Localize(UIExpression.GetItemName(f28_arg0.controller, f28_local37)))
		Widget:addElement(LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = false,
			left = 10,
			right = 10 + 5 * f28_local28 / 6,
			topAnchor = true,
			bottomAnchor = false,
			top = f28_local29 / 9,
			bottom = f28_local29 / 9 + 2 * f28_local29 / 3,
			material = RegisterMaterial(UIExpression.GetItemImage(f28_arg0.controller, f28_local37))
		}))
	end
end

