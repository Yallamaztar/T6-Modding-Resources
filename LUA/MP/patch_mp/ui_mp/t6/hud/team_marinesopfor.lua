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

CoD.ChooseTeam.SetText = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = LUI.UIText.new(f2_arg0)
	f2_arg1:addElement(f2_local0)
	f2_local0:setText(f2_arg2)
end

CoD.ChooseTeam.AddButton = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = f3_arg0.buttonList:addButton(f3_arg1)
	f3_local0:setActionEventName(f3_arg2)
end

CoD.ChooseTeam.SendMenuResponseAxis = function (f4_arg0, f4_arg1)
	if not CoD.isXBOX and not CoD.isPS3 then
		Engine.Exec(f4_arg1.controller, "clearAllInvites")
	end
	HUD_IngameMenuClosed()
	Engine.SendMenuResponse(f4_arg1.controller, "team_marinesopfor", "axis")
end

CoD.ChooseTeam.SendMenuResponseAllies = function (f5_arg0, f5_arg1)
	if not CoD.isXBOX and not CoD.isPS3 then
		Engine.Exec(f5_arg1.controller, "clearAllInvites")
	end
	HUD_IngameMenuClosed()
	Engine.SendMenuResponse(f5_arg1.controller, "team_marinesopfor", "allies")
end

CoD.ChooseTeam.SendMenuResponseTeam = function (f6_arg0, f6_arg1, f6_arg2)
	if not CoD.isXBOX and not CoD.isPS3 then
		Engine.Exec(f6_arg1.controller, "clearAllInvites")
	end
	HUD_IngameMenuClosed()
	Engine.SendMenuResponse(f6_arg1.controller, "team_marinesopfor", "team" .. f6_arg2)
end

CoD.ChooseTeam.SendMenuResponseTeam3 = function (f7_arg0, f7_arg1)
	CoD.ChooseTeam.SendMenuResponseTeam(f7_arg0, f7_arg1, CoD.TEAM_THREE)
end

CoD.ChooseTeam.SendMenuResponseTeam4 = function (f8_arg0, f8_arg1)
	CoD.ChooseTeam.SendMenuResponseTeam(f8_arg0, f8_arg1, CoD.TEAM_FOUR)
end

CoD.ChooseTeam.SendMenuResponseTeam5 = function (f9_arg0, f9_arg1)
	CoD.ChooseTeam.SendMenuResponseTeam(f9_arg0, f9_arg1, CoD.TEAM_FIVE)
end

CoD.ChooseTeam.SendMenuResponseTeam6 = function (f10_arg0, f10_arg1)
	CoD.ChooseTeam.SendMenuResponseTeam(f10_arg0, f10_arg1, CoD.TEAM_SIX)
end

CoD.ChooseTeam.SendMenuResponseTeam7 = function (f11_arg0, f11_arg1)
	CoD.ChooseTeam.SendMenuResponseTeam(f11_arg0, f11_arg1, CoD.TEAM_SEVEN)
end

CoD.ChooseTeam.SendMenuResponseTeam8 = function (f12_arg0, f12_arg1)
	CoD.ChooseTeam.SendMenuResponseTeam(f12_arg0, f12_arg1, CoD.TEAM_EIGHT)
end

CoD.ChooseTeam.SendMenuResponseSpectator = function (f13_arg0, f13_arg1)
	HUD_IngameMenuClosed()
	Engine.SendMenuResponse(f13_arg1.controller, "team_marinesopfor", "spectator")
	f13_arg0:goBack(f13_arg1.controller)
	Engine.LockInput(f13_arg1.controller, false)
	Engine.SetUIActive(f13_arg1.controller, false)
end

CoD.ChooseTeam.SendMenuResponseAutoAssign = function (f14_arg0, f14_arg1)
	if not CoD.isXBOX and not CoD.isPS3 then
		Engine.Exec(f14_arg1.controller, "clearAllInvites")
	end
	HUD_IngameMenuClosed()
	Engine.SendMenuResponse(f14_arg1.controller, "team_marinesopfor", "autoassign")
end

CoD.ChooseTeam.PrepareButtonList = function (f15_arg0, f15_arg1)
	local f15_local0 = CoD.SplitscreenScaler.new(nil, 1.5)
	f15_local0:setLeftRight(true, false, 0, 0)
	f15_local0:setTopBottom(true, false, 0, 0)
	f15_arg1:addElement(f15_local0)
	local f15_local1 = 0
	if UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
		f15_local1 = CoD.Menu.SplitscreenSideOffset
	end
	f15_arg1.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f15_local1,
		right = f15_local1 + CoD.ButtonList.DefaultWidth,
		topAnchor = true,
		bottomAnchor = false,
		top = CoD.Menu.TitleHeight,
		bottom = CoD.Menu.TitleHeight + 720
	})
	f15_local0:addElement(f15_arg1.buttonList)
	local f15_local2 = UIExpression.Team(f15_arg0, "index")
	local f15_local3
	if 1 > Engine.GetGametypeSetting("spectatetype") or 1 ~= Engine.GetGametypeSetting("allowspectating") or UIExpression.SplitscreenNum() > 1 then
		f15_local3 = false
	else
		f15_local3 = true
	end
	local f15_local4 = Engine.GetGametypeSetting("teamCount")
	if CoD.IsTeamChangeAllowed() then
		if f15_local2 ~= CoD.TEAM_ALLIES then
			CoD.ChooseTeam.AddButton(f15_arg1, CoD.GetTeamNameCaps(CoD.TEAM_ALLIES), "alliesTeamSelected")
		end
		if f15_local2 ~= CoD.TEAM_AXIS then
			CoD.ChooseTeam.AddButton(f15_arg1, CoD.GetTeamNameCaps(CoD.TEAM_AXIS), "axisTeamSelected")
		end
		for f15_local5 = CoD.TEAM_THREE, f15_local4, 1 do
			if f15_local2 ~= f15_local5 then
				CoD.ChooseTeam.AddButton(f15_arg1, CoD.GetTeamNameCaps(f15_local5), "team" .. f15_local5 .. "TeamSelected")
			end
		end
	end
	CoD.ChooseTeam.AddButton(f15_arg1, Engine.Localize("MPUI_AUTOASSIGN_CAPS"), "autoAssignSelected")
	if f15_local2 ~= CoD.TEAM_SPECTATOR and f15_local3 == true then
		CoD.ChooseTeam.AddButton(f15_arg1, CoD.GetTeamNameCaps(CoD.TEAM_SPECTATOR), "spectatorSelected")
	end
	if f15_local2 == CoD.TEAM_SPECTATOR then
		if UIExpression.DvarBool(nil, "onlineunrankedgameandhost") == 1 then
			CoD.ChooseTeam.AddButton(f15_arg1, Engine.Localize("MPUI_END_GAME_CAPS"), "open_endGamePopup")
		else
			CoD.ChooseTeam.AddButton(f15_arg1, Engine.Localize("MPUI_LEAVE_GAME_CAPS"), "open_endGamePopup")
		end
	end
	f15_arg1.buttonList:processEvent({
		name = "gain_focus"
	})
end

CoD.ChooseTeam.CreatePlayerTeamBg = function (f16_arg0, f16_arg1, f16_arg2, f16_arg3)
	local f16_local0 = {}
	local f16_local1 = 0.75
	local f16_local2 = CoD.GetTeamColor(f16_arg1)
	if f16_arg0 % 2 == 1 then
		f16_local0.r = f16_local2.r * f16_local1
		f16_local0.g = f16_local2.g * f16_local1
		f16_local0.b = f16_local2.b * f16_local1
	else
		f16_local0.r = f16_local2.r
		f16_local0.g = f16_local2.g
		f16_local0.b = f16_local2.b
	end
	f16_local0.a = 0.2
	local f16_local3 = LUI.UIImage.new()
	f16_local3:setLeftRight(true, true, 0, 0)
	f16_local3:setTopBottom(true, false, 0, CoD.ChooseTeam.PlayerListRowHeight)
	f16_local3:setRGB(f16_local0.r, f16_local0.g, f16_local0.b)
	f16_local3:setAlpha(f16_local0.a)
	f16_local3:setImage(f16_arg3)
	f16_arg2:addElement(f16_local3)
end

CoD.ChooseTeam.CreatePlayerListRowBg = function (f17_arg0, f17_arg1, f17_arg2, f17_arg3)
	local f17_local0, f17_local1 = nil
	if CoD.isZombie == true then
		if f17_arg3 == CoD.TEAM_ALLIES then
			f17_local1 = RegisterMaterial("scorebar_zom_long_1")
		else
			f17_local1 = RegisterMaterial("scorebar_zom_long_2")
		end
	end
	CoD.ChooseTeam.CreatePlayerTeamBg(f17_arg2, f17_arg3, f17_arg1, f17_local1)
	local f17_local2 = 50
	local f17_local3 = LUI.UIImage.new()
	f17_local3:setLeftRight(true, false, 0, f17_local2)
	f17_local3:setTopBottom(true, false, 0, CoD.ChooseTeam.PlayerListRowHeight)
	f17_local3:setRGB(0, 0, 0)
	f17_local3:setAlpha(0.1)
	f17_arg1:addElement(f17_local3)
end

CoD.ChooseTeam.CreateInGamePlayerListRow = function (f18_arg0, f18_arg1, f18_arg2, f18_arg3)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, CoD.ChooseTeam.PlayerListRowHeight)
	CoD.ChooseTeam.CreatePlayerListRowBg(f18_arg0, Widget, f18_arg1, f18_arg3)
	local f18_local1 = CoD.ChooseTeam.AddContainer({
		leftAnchor = true,
		rightAnchor = false,
		left = 5,
		right = 25,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}, Widget)
	f18_local1.label = LUI.UIText.new()
	f18_local1.label:setLeftRight(false, true, -5, -5)
	f18_local1.label:setTopBottom(false, false, -CoD.ChooseTeam.PlayerListRowTextHeight / 2, CoD.ChooseTeam.PlayerListRowTextHeight / 2)
	f18_local1.label:setFont(CoD.ChooseTeam.PlayerListRowFont)
	f18_local1.label:setText(f18_arg2.rank)
	f18_local1:addElement(f18_local1.label)
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
		material = f18_arg2.rankIcon
	}))
	local f18_local3 = CoD.ChooseTeam.AddContainer({
		left = 35 + CoD.ChooseTeam.PlayerListHeaderHeight,
		top = 0,
		right = 280,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	}, Widget)
	local f18_local4 = 1
	local f18_local5 = 1
	local f18_local6 = 1
	if UIExpression.GetSelfGamertag(f18_arg0) == f18_arg2.playerName then
		f18_local4 = CoD.yellowGlow.r
		f18_local5 = CoD.yellowGlow.g
		f18_local6 = CoD.yellowGlow.b
	else
		f18_local4 = 1
		f18_local5 = 1
		f18_local6 = 1
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
		red = f18_local4,
		green = f18_local5,
		blue = f18_local6,
		font = CoD.ChooseTeam.PlayerListRowFont,
		alignment = LUI.Alignment.Left
	}, f18_local3, f18_arg2.playerName)
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
	}, Widget), f18_arg2.playerScore)
	return Widget
end

CoD.ChooseTeam.CreateInGamePlayerList = function (f19_arg0, f19_arg1, f19_arg2, f19_arg3, f19_arg4)
	local f19_local0 = 0
	local f19_local1 = Engine.GetInGamePlayerList(f19_arg0, f19_arg1)
	local f19_local2 = #f19_local1 * CoD.ChooseTeam.PlayerListRowHeight
	if f19_local1 ~= nil and 0 < #f19_local1 then
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
		for f19_local6, f19_local7 in pairs(f19_local1) do
			f19_arg3.verticalPlayerList:addElement(CoD.ChooseTeam.CreateInGamePlayerListRow(f19_arg0, f19_local6, f19_local7, f19_arg1))
		end
		return f19_arg4 + f19_local2
	else
		return f19_arg4 + f19_local0
	end
end

CoD.ChooseTeam.AddPlayerList = function (f20_arg0, f20_arg1)
	local f20_local0 = CoD.SplitscreenScaler.new(nil, 1.5)
	f20_local0:setLeftRight(false, true, 0, 0)
	f20_local0:setTopBottom(true, false, 0, 0)
	f20_arg0:addElement(f20_local0)
	local f20_local1 = 0
	if UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
		f20_local1 = -CoD.Menu.SplitscreenSideOffset
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, f20_local1 - CoD.ButtonList.DefaultWidth, f20_local1)
	Widget:setTopBottom(true, false, CoD.Menu.TitleHeight, CoD.Menu.TitleHeight + 720)
	f20_local0:addElement(Widget)
	if not HUD_IsFFA() then
		local f20_local3 = Engine.GetGametypeSetting("teamCount")
		local f20_local4 = CoD.ChooseTeam.CreateInGamePlayerList(f20_arg1, CoD.TEAM_AXIS, CoD.GetTeamNameCaps(CoD.TEAM_AXIS), Widget, CoD.ChooseTeam.CreateInGamePlayerList(f20_arg1, CoD.TEAM_ALLIES, CoD.GetTeamNameCaps(CoD.TEAM_ALLIES), Widget, 0))
		for f20_local5 = 3, f20_local3, 1 do
			f20_local4 = CoD.ChooseTeam.CreateInGamePlayerList(f20_arg1, f20_local5, CoD.GetTeamNameCaps(f20_local5), Widget, f20_local4)
		end
	else
		local f20_local3 = CoD.ChooseTeam.CreateInGamePlayerList(f20_arg1, CoD.TEAM_FREE, "", Widget, 0)
	end
end

CoD.ChooseTeam.Close = function (f21_arg0, f21_arg1)
	if f21_arg1.menuName == "changeclass" then
		f21_arg0:close()
	end
end

CoD.ChooseTeam.EndGameButtonPressed = function (f22_arg0, f22_arg1)
	f22_arg0:openPopup("EndGamePopup", f22_arg1.controller)
end

LUI.createMenu.team_marinesopfor = function (f23_arg0)
	local f23_local0 = UIExpression.Team(f23_arg0, "name")
	local f23_local1 = ""
	if f23_local0 == "TEAM_SPECTATOR" or f23_local0 == "TEAM_FREE" then
		f23_local1 = UIExpression.ToUpper(nil, Engine.Localize("MPUI_CHOOSE_TEAM_CAPS"))
	else
		f23_local1 = UIExpression.ToUpper(nil, Engine.Localize("MPUI_CHANGE_TEAM_CAPS"))
	end
	local f23_local2 = CoD.InGameMenu.New("team_marinesopfor", f23_arg0, f23_local1)
	if UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
		f23_local2:sizeToSafeArea(f23_arg0)
		f23_local2:updateTitleForSplitscreen()
		f23_local2:updateButtonPromptBarsForSplitscreen()
	end
	f23_local2:addButtonPrompts()
	CoD.ChooseTeam.PrepareButtonList(f23_arg0, f23_local2)
	f23_local2:registerEventHandler("axisTeamSelected", CoD.ChooseTeam.SendMenuResponseAxis)
	f23_local2:registerEventHandler("alliesTeamSelected", CoD.ChooseTeam.SendMenuResponseAllies)
	f23_local2:registerEventHandler("team3TeamSelected", CoD.ChooseTeam.SendMenuResponseTeam3)
	f23_local2:registerEventHandler("team4TeamSelected", CoD.ChooseTeam.SendMenuResponseTeam4)
	f23_local2:registerEventHandler("team5TeamSelected", CoD.ChooseTeam.SendMenuResponseTeam5)
	f23_local2:registerEventHandler("team6TeamSelected", CoD.ChooseTeam.SendMenuResponseTeam6)
	f23_local2:registerEventHandler("team7TeamSelected", CoD.ChooseTeam.SendMenuResponseTeam7)
	f23_local2:registerEventHandler("team8TeamSelected", CoD.ChooseTeam.SendMenuResponseTeam8)
	f23_local2:registerEventHandler("spectatorSelected", CoD.ChooseTeam.SendMenuResponseSpectator)
	f23_local2:registerEventHandler("autoAssignSelected", CoD.ChooseTeam.SendMenuResponseAutoAssign)
	f23_local2:registerEventHandler("open_endGamePopup", CoD.ChooseTeam.EndGameButtonPressed)
	f23_local2:registerEventHandler("open_ingame_menu", CoD.ChooseTeam.Close)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false then
		CoD.ChooseTeam.AddPlayerList(f23_local2, f23_arg0)
	end
	return f23_local2
end

