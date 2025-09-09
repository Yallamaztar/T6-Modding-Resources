require("T6.HUD.InGameMenus")
CoD.ChooseTeam = {}
CoD.ChooseTeam.PlayerListRowHeight = CoD.textSize.Default
CoD.ChooseTeam.PlayerListHeaderHeight = 20
CoD.ChooseTeam.PlayerListRowFont = CoD.fonts.ExtraSmall
CoD.ChooseTeam.PlayerListRowTextHeight = CoD.textSize.ExtraSmall
CoD.ChooseTeam.AddContainer = function (f1_arg0, f1_arg1, f1_arg2)
	local Widget = LUI.UIElement.new(f1_arg0)
	if setstencil ~= nil and setstencil == true then
		Widget:setUseStencil(true)
	end
	f1_arg1:addElement(Widget)
	return Widget
end

CoD.ChooseTeam.SetText = function (f2_arg0, f2_arg1, Text)
	local f2_local0 = LUI.UIText.new(f2_arg0)
	f2_arg1:addElement(f2_local0)
	f2_local0:setText(Text)
end

CoD.ChooseTeam.AddButton = function (f3_arg0, ButtonName, ButtonEvent)
	local f3_local0 = f3_arg0.buttonList:addButton(ButtonName)
	f3_local0:setActionEventName(ButtonEvent)
end

CoD.ChooseTeam.SendMenuResponseAxis = function (team_marinesopforWidget, ClientInstance)
	if not CoD.isXBOX and not CoD.isPS3 then
		Engine.Exec(ClientInstance.controller, "clearAllInvites")
	end
	HUD_IngameMenuClosed()
	Engine.SendMenuResponse(ClientInstance.controller, "team_marinesopfor", "axis")
end

CoD.ChooseTeam.SendMenuResponseAllies = function (team_marinesopforWidget, ClientInstance)
	if not CoD.isXBOX and not CoD.isPS3 then
		Engine.Exec(ClientInstance.controller, "clearAllInvites")
	end
	HUD_IngameMenuClosed()
	Engine.SendMenuResponse(ClientInstance.controller, "team_marinesopfor", "allies")
end

CoD.ChooseTeam.SendMenuResponseTeam = function (team_marinesopforWidget, ClientInstance, TeamIndex)
	if not CoD.isXBOX and not CoD.isPS3 then
		Engine.Exec(ClientInstance.controller, "clearAllInvites")
	end
	HUD_IngameMenuClosed()
	Engine.SendMenuResponse(ClientInstance.controller, "team_marinesopfor", "team" .. TeamIndex)
end

CoD.ChooseTeam.SendMenuResponseTeam3 = function (team_marinesopforWidget, ClientInstance)
	CoD.ChooseTeam.SendMenuResponseTeam(team_marinesopforWidget, ClientInstance, CoD.TEAM_THREE)
end

CoD.ChooseTeam.SendMenuResponseTeam4 = function (team_marinesopforWidget, ClientInstance)
	CoD.ChooseTeam.SendMenuResponseTeam(team_marinesopforWidget, ClientInstance, CoD.TEAM_FOUR)
end

CoD.ChooseTeam.SendMenuResponseTeam5 = function (team_marinesopforWidget, ClientInstance)
	CoD.ChooseTeam.SendMenuResponseTeam(team_marinesopforWidget, ClientInstance, CoD.TEAM_FIVE)
end

CoD.ChooseTeam.SendMenuResponseTeam6 = function (team_marinesopforWidget, ClientInstance)
	CoD.ChooseTeam.SendMenuResponseTeam(team_marinesopforWidget, ClientInstance, CoD.TEAM_SIX)
end

CoD.ChooseTeam.SendMenuResponseTeam7 = function (team_marinesopforWidget, ClientInstance)
	CoD.ChooseTeam.SendMenuResponseTeam(team_marinesopforWidget, ClientInstance, CoD.TEAM_SEVEN)
end

CoD.ChooseTeam.SendMenuResponseTeam8 = function (team_marinesopforWidget, ClientInstance)
	CoD.ChooseTeam.SendMenuResponseTeam(team_marinesopforWidget, ClientInstance, CoD.TEAM_EIGHT)
end

CoD.ChooseTeam.SendMenuResponseSpectator = function (team_marinesopforWidget, ClientInstance)
	HUD_IngameMenuClosed()
	Engine.SendMenuResponse(ClientInstance.controller, "team_marinesopfor", "spectator")
	team_marinesopforWidget:goBack(ClientInstance.controller)
	Engine.LockInput(ClientInstance.controller, false)
	Engine.SetUIActive(ClientInstance.controller, false)
end

CoD.ChooseTeam.SendMenuResponseAutoAssign = function (team_marinesopforWidget, ClientInstance)
	if not CoD.isXBOX and not CoD.isPS3 then
		Engine.Exec(ClientInstance.controller, "clearAllInvites")
	end
	HUD_IngameMenuClosed()
	Engine.SendMenuResponse(ClientInstance.controller, "team_marinesopfor", "autoassign")
end

CoD.ChooseTeam.PrepareButtonList = function (LocalClientIndex, team_marinesopforWidget)
	local f15_local0 = CoD.SplitscreenScaler.new(nil, 1.5)
	f15_local0:setLeftRight(true, false, 0, 0)
	f15_local0:setTopBottom(true, false, 0, 0)
	team_marinesopforWidget:addElement(f15_local0)
	local SplitscreenOffset = 0
	if UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
		SplitscreenOffset = CoD.Menu.SplitscreenSideOffset
	end
	team_marinesopforWidget.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = SplitscreenOffset,
		right = SplitscreenOffset + CoD.ButtonList.DefaultWidth,
		topAnchor = true,
		bottomAnchor = false,
		top = CoD.Menu.TitleHeight,
		bottom = CoD.Menu.TitleHeight + 720
	})
	f15_local0:addElement(team_marinesopforWidget.buttonList)
	local ClientTeamIndex = UIExpression.Team(LocalClientIndex, "index")
	local PlayerCanPickShoutcaster
	if Engine.GetGametypeSetting("spectatetype") < 1 or Engine.GetGametypeSetting("allowspectating") ~= 1 or UIExpression.SplitscreenNum() > 1 then
		PlayerCanPickShoutcaster = false
	else
		PlayerCanPickShoutcaster = true
	end
	local TeamCount = Engine.GetGametypeSetting("teamCount")
	if CoD.IsTeamChangeAllowed() then
		if ClientTeamIndex ~= CoD.TEAM_ALLIES then
			CoD.ChooseTeam.AddButton(team_marinesopforWidget, CoD.GetTeamNameCaps(CoD.TEAM_ALLIES), "alliesTeamSelected")
		end
		if ClientTeamIndex ~= CoD.TEAM_AXIS then
			CoD.ChooseTeam.AddButton(team_marinesopforWidget, CoD.GetTeamNameCaps(CoD.TEAM_AXIS), "axisTeamSelected")
		end
		for TeamIndex = CoD.TEAM_THREE, TeamCount, 1 do
			if ClientTeamIndex ~= TeamIndex then
				CoD.ChooseTeam.AddButton(team_marinesopforWidget, CoD.GetTeamNameCaps(TeamIndex), "team" .. TeamIndex .. "TeamSelected")
			end
		end
	end
	CoD.ChooseTeam.AddButton(team_marinesopforWidget, Engine.Localize("MPUI_AUTOASSIGN_CAPS"), "autoAssignSelected")
	if ClientTeamIndex ~= CoD.TEAM_SPECTATOR and PlayerCanPickShoutcaster == true then
		CoD.ChooseTeam.AddButton(team_marinesopforWidget, CoD.GetTeamNameCaps(CoD.TEAM_SPECTATOR), "spectatorSelected")
	end
	if ClientTeamIndex == CoD.TEAM_SPECTATOR then
		if UIExpression.DvarBool(nil, "onlineunrankedgameandhost") == 1 then
			CoD.ChooseTeam.AddButton(team_marinesopforWidget, Engine.Localize("MPUI_END_GAME_CAPS"), "open_endGamePopup")
		else
			CoD.ChooseTeam.AddButton(team_marinesopforWidget, Engine.Localize("MPUI_LEAVE_GAME_CAPS"), "open_endGamePopup")
		end
	end
	team_marinesopforWidget.buttonList:processEvent({
		name = "gain_focus"
	})
end

CoD.ChooseTeam.CreatePlayerTeamBg = function (PlayerListKey, TeamIndex, f16_arg2, RowBackground)
	local ColorTable = {}
	local ColorModifier = 0.75
	local TeamColorTable = CoD.GetTeamColor(TeamIndex)
	if PlayerListKey % 2 == 1 then
		ColorTable.r = TeamColorTable.r * ColorModifier
		ColorTable.g = TeamColorTable.g * ColorModifier
		ColorTable.b = TeamColorTable.b * ColorModifier
	else
		ColorTable.r = TeamColorTable.r
		ColorTable.g = TeamColorTable.g
		ColorTable.b = TeamColorTable.b
	end
	ColorTable.a = 0.2
	local TeamBackground = LUI.UIImage.new()
	TeamBackground:setLeftRight(true, true, 0, 0)
	TeamBackground:setTopBottom(true, false, 0, CoD.ChooseTeam.PlayerListRowHeight)
	TeamBackground:setRGB(ColorTable.r, ColorTable.g, ColorTable.b)
	TeamBackground:setAlpha(ColorTable.a)
	TeamBackground:setImage(RowBackground)
	f16_arg2:addElement(TeamBackground)
end

CoD.ChooseTeam.CreatePlayerListRowBg = function (LocalClientIndex, f17_arg1, PlayerListKey, TeamIndex)
	local f17_local0, RowBackground = nil
	if CoD.isZombie == true then
		if TeamIndex == CoD.TEAM_ALLIES then
			RowBackground = RegisterMaterial("scorebar_zom_long_1")
		else
			RowBackground = RegisterMaterial("scorebar_zom_long_2")
		end
	end
	CoD.ChooseTeam.CreatePlayerTeamBg(PlayerListKey, TeamIndex, f17_arg1, RowBackground)
	local LeftRightOffset = 50
	local PlayerListRowBackground = LUI.UIImage.new()
	PlayerListRowBackground:setLeftRight(true, false, 0, LeftRightOffset)
	PlayerListRowBackground:setTopBottom(true, false, 0, CoD.ChooseTeam.PlayerListRowHeight)
	PlayerListRowBackground:setRGB(0, 0, 0)
	PlayerListRowBackground:setAlpha(0.1)
	f17_arg1:addElement(PlayerListRowBackground)
end

CoD.ChooseTeam.CreateInGamePlayerListRow = function (LocalClientIndex, PlayerListKey, PlayerListItem, TeamIndex)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, CoD.ChooseTeam.PlayerListRowHeight)
	CoD.ChooseTeam.CreatePlayerListRowBg(LocalClientIndex, Widget, PlayerListKey, TeamIndex)
	local ChooseTeamContainer = CoD.ChooseTeam.AddContainer({
		leftAnchor = true,
		rightAnchor = false,
		left = 5,
		right = 25,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}, Widget)
	ChooseTeamContainer.label = LUI.UIText.new()
	ChooseTeamContainer.label:setLeftRight(false, true, -5, -5)
	ChooseTeamContainer.label:setTopBottom(false, false, -CoD.ChooseTeam.PlayerListRowTextHeight / 2, CoD.ChooseTeam.PlayerListRowTextHeight / 2)
	ChooseTeamContainer.label:setFont(CoD.ChooseTeam.PlayerListRowFont)
	ChooseTeamContainer.label:setText(PlayerListItem.rank)
	ChooseTeamContainer:addElement(ChooseTeamContainer.label)
	local f18_local2 = CoD.ChooseTeam.AddContainer({
		left = 25,
		top = 0,
		right = 25 + CoD.ChooseTeam.PlayerListHeaderHeight,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	}, Widget)
	f18_local2:addElement(LUI.UIImage.new({
		left = 0,
		top = -CoD.ChooseTeam.PlayerListRowTextHeight / 2,
		right = 0,
		bottom = CoD.ChooseTeam.PlayerListRowTextHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		material = PlayerListItem.rankIcon
	}))
	local ChooseTeamContainer = CoD.ChooseTeam.AddContainer({
		left = 35 + CoD.ChooseTeam.PlayerListHeaderHeight,
		top = 0,
		right = 280,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	}, Widget)
	local TextRed = 1
	local TextGreen = 1
	local TextBlue = 1
	if UIExpression.GetSelfGamertag(LocalClientIndex) == PlayerListItem.playerName then
		TextRed = CoD.yellowGlow.r
		TextGreen = CoD.yellowGlow.g
		TextBlue = CoD.yellowGlow.b
	else
		TextRed = 1
		TextGreen = 1
		TextBlue = 1
	end
	CoD.ChooseTeam.SetText({
		left = 0,
		top = -CoD.ChooseTeam.PlayerListRowTextHeight / 2,
		right = 0,
		bottom = CoD.ChooseTeam.PlayerListRowTextHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		red = TextRed,
		green = TextGreen,
		blue = TextBlue,
		font = CoD.ChooseTeam.PlayerListRowFont,
		alignment = LUI.Alignment.Left
	}, ChooseTeamContainer, PlayerListItem.playerName)
	CoD.ChooseTeam.SetText({
		left = 0,
		top = -CoD.ChooseTeam.PlayerListRowTextHeight / 2,
		right = 0,
		bottom = CoD.ChooseTeam.PlayerListRowTextHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		font = CoD.ChooseTeam.PlayerListRowFont,
		alignment = LUI.Alignment.Right,
		alpha = 0
	}, CoD.ChooseTeam.AddContainer({
		left = -60,
		top = 0,
		right = -5,
		bottom = 0,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}, Widget), PlayerListItem.playerScore)
	return Widget
end

CoD.ChooseTeam.CreateInGamePlayerList = function (LocalClientIndex, TeamIndex, TeamNameCaps, f19_arg3, f19_arg4)
	local f19_local0 = 0
	local InGamePlayerList = Engine.GetInGamePlayerList(LocalClientIndex, TeamIndex)
	local f19_local2 = #InGamePlayerList * CoD.ChooseTeam.PlayerListRowHeight
	if InGamePlayerList ~= nil and 0 < #InGamePlayerList then
		f19_arg3.verticalPlayerList = LUI.UIVerticalList.new({
			left = 0,
			top = f19_arg4,
			right = 0,
			bottom = f19_arg4 + f19_local2,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			spacing = 0
		})
		f19_arg3:addElement(f19_arg3.verticalPlayerList)
		for PlayerListKey, PlayerListItem in pairs(InGamePlayerList) do
			f19_arg3.verticalPlayerList:addElement(CoD.ChooseTeam.CreateInGamePlayerListRow(LocalClientIndex, PlayerListKey, PlayerListItem, TeamIndex))
		end
		return f19_arg4 + f19_local2
	else
		return f19_arg4 + f19_local0
	end
end

CoD.ChooseTeam.AddPlayerList = function (team_marinesopforWidget, LocalClientIndex)
	local f20_local0 = CoD.SplitscreenScaler.new(nil, 1.5)
	f20_local0:setLeftRight(false, true, 0, 0)
	f20_local0:setTopBottom(true, false, 0, 0)
	team_marinesopforWidget:addElement(f20_local0)
	local SplitscreenOffset = 0
	if UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
		SplitscreenOffset = -CoD.Menu.SplitscreenSideOffset
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, SplitscreenOffset - CoD.ButtonList.DefaultWidth, SplitscreenOffset)
	Widget:setTopBottom(true, false, CoD.Menu.TitleHeight, CoD.Menu.TitleHeight + 720)
	f20_local0:addElement(Widget)
	if not HUD_IsFFA() then
		local TeamCount = Engine.GetGametypeSetting("teamCount")
		local f20_local4 = CoD.ChooseTeam.CreateInGamePlayerList(LocalClientIndex, CoD.TEAM_AXIS, CoD.GetTeamNameCaps(CoD.TEAM_AXIS), Widget, CoD.ChooseTeam.CreateInGamePlayerList(LocalClientIndex, CoD.TEAM_ALLIES, CoD.GetTeamNameCaps(CoD.TEAM_ALLIES), Widget, 0))
		for TeamIndex = 3, TeamCount, 1 do
			f20_local4 = CoD.ChooseTeam.CreateInGamePlayerList(LocalClientIndex, TeamIndex, CoD.GetTeamNameCaps(TeamIndex), Widget, f20_local4)
		end
	else
		local TeamCount = CoD.ChooseTeam.CreateInGamePlayerList(LocalClientIndex, CoD.TEAM_FREE, "", Widget, 0)
	end
end

CoD.ChooseTeam.Close = function (team_marinesopforWidget, ClientInstance)
	if ClientInstance.menuName == "changeclass" then
		team_marinesopforWidget:close()
	end
end

CoD.ChooseTeam.EndGameButtonPressed = function (team_marinesopforWidget, ClientInstance)
	team_marinesopforWidget:openPopup("EndGamePopup", ClientInstance.controller)
end

LUI.createMenu.team_marinesopfor = function (LocalClientIndex)
	local ClientTeam = UIExpression.Team(LocalClientIndex, "name")
	local ChooseTeamButtonName = ""
	if ClientTeam == "TEAM_SPECTATOR" or ClientTeam == "TEAM_FREE" then
		ChooseTeamButtonName = UIExpression.ToUpper(nil, Engine.Localize("MPUI_CHOOSE_TEAM_CAPS"))
	else
		ChooseTeamButtonName = UIExpression.ToUpper(nil, Engine.Localize("MPUI_CHANGE_TEAM_CAPS"))
	end
	local team_marinesopforWidget = CoD.InGameMenu.New("team_marinesopfor", LocalClientIndex, ChooseTeamButtonName)
	if UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
		team_marinesopforWidget:sizeToSafeArea(LocalClientIndex)
		team_marinesopforWidget:updateTitleForSplitscreen()
		team_marinesopforWidget:updateButtonPromptBarsForSplitscreen()
	end
	team_marinesopforWidget:addButtonPrompts()
	CoD.ChooseTeam.PrepareButtonList(LocalClientIndex, team_marinesopforWidget)
	team_marinesopforWidget:registerEventHandler("axisTeamSelected", CoD.ChooseTeam.SendMenuResponseAxis)
	team_marinesopforWidget:registerEventHandler("alliesTeamSelected", CoD.ChooseTeam.SendMenuResponseAllies)
	team_marinesopforWidget:registerEventHandler("team3TeamSelected", CoD.ChooseTeam.SendMenuResponseTeam3)
	team_marinesopforWidget:registerEventHandler("team4TeamSelected", CoD.ChooseTeam.SendMenuResponseTeam4)
	team_marinesopforWidget:registerEventHandler("team5TeamSelected", CoD.ChooseTeam.SendMenuResponseTeam5)
	team_marinesopforWidget:registerEventHandler("team6TeamSelected", CoD.ChooseTeam.SendMenuResponseTeam6)
	team_marinesopforWidget:registerEventHandler("team7TeamSelected", CoD.ChooseTeam.SendMenuResponseTeam7)
	team_marinesopforWidget:registerEventHandler("team8TeamSelected", CoD.ChooseTeam.SendMenuResponseTeam8)
	team_marinesopforWidget:registerEventHandler("spectatorSelected", CoD.ChooseTeam.SendMenuResponseSpectator)
	team_marinesopforWidget:registerEventHandler("autoAssignSelected", CoD.ChooseTeam.SendMenuResponseAutoAssign)
	team_marinesopforWidget:registerEventHandler("open_endGamePopup", CoD.ChooseTeam.EndGameButtonPressed)
	team_marinesopforWidget:registerEventHandler("open_ingame_menu", CoD.ChooseTeam.Close)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false then
		CoD.ChooseTeam.AddPlayerList(team_marinesopforWidget, LocalClientIndex)
	end
	return team_marinesopforWidget
end

