CoD.PlayerListRow = {}
CoD.PlayerListRow.Height = CoD.CoD9Button.Height
CoD.PlayerListRow.RankFadeInTime = 500
CoD.PlayerListRow.Font = "Default"
CoD.PlayerListRow.LeagueRankAreaWidth = 92
CoD.PlayerListRow.SetStatusText = function (f1_arg0, f1_arg1)
	if f1_arg1 ~= nil then
		f1_arg0.status:setText(f1_arg1)
	end
end

CoD.PlayerListRow.CreateStatusRow = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.textSize[CoD.PlayerListRow.Font]
	})
	Widget:makeNotFocusable()
	Widget:setPriority(0)
	Widget.status = LUI.UIText.new()
	Widget.status:setLeftRight(true, true, 0, 0)
	Widget.status:setTopBottom(true, true, 0, 0)
	Widget.status:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget.status:setAlpha(0.75)
	Widget.status:setFont(CoD.fonts[CoD.PlayerListRow.Font])
	Widget.status:setAlignment(LUI.Alignment.Left)
	Widget:addElement(Widget.status)
	if false == CoD.isZombie and f2_arg2 then
		Widget:addElement(CoD.LiveStream.GetStatusWidget(f2_arg3, LUI.Alignment.Right, true, true))
	end
	Widget.playerList = f2_arg0
	Widget.setText = CoD.PlayerListRow.SetStatusText
	if f2_arg1 ~= nil then
		Widget.status:setText(f2_arg1)
	end
	return Widget
end

CoD.PlayerListRow.CreateSplitscreenRow = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.PlayerListRow.Height
	})
	Widget:makeNotFocusable()
	Widget:setPriority(10)
	Widget.allowJoin = InstanceRef
	Widget.textLabel = LUI.UIText.new()
	Widget.textLabel:setLeftRight(true, true, 0, 0)
	Widget.textLabel:setTopBottom(false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2 - 3, CoD.textSize[CoD.PlayerListRow.Font] / 2 - 3)
	Widget.textLabel:setFont(CoD.fonts[CoD.PlayerListRow.Font])
	Widget.textLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget.textLabel:setAlignment(LUI.Alignment.Left)
	Widget:addElement(Widget.textLabel)
	Widget.textLabel:setText(HudRef)
	return Widget
end

CoD.PlayerListRow.CreateMissingTeamMemberRow = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = -CoD.PlayerListRow.LeagueRankAreaWidth,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.PlayerListRow.Height
	})
	Widget:makeNotFocusable()
	local f4_local1 = 0
	local f4_local2 = 0.5
	local f4_local3 = CoD.GetTeamColor(CoD.TEAM_FREE)
	local f4_local4 = LUI.UIImage.new()
	f4_local4:setLeftRight(true, true, 0, 0)
	f4_local4:setTopBottom(true, true, 0, 0)
	f4_local4:setRGB(f4_local3.r, f4_local3.g, f4_local3.b)
	f4_local4:setAlpha(CoD.PlayerListRow.GetRowAlpha(HudRef))
	f4_local4:setImage(RegisterMaterial("menu_mp_lobby_bar_name"))
	Widget:addElement(f4_local4)
	local f4_local5 = LUI.UIText.new()
	f4_local5:setLeftRight(true, false, 5, 5)
	f4_local5:setTopBottom(false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2, CoD.textSize[CoD.PlayerListRow.Font] / 2)
	f4_local5:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f4_local5:setAlpha(f4_local2)
	f4_local5:setFont(CoD.fonts[CoD.PlayerListRow.Font])
	local f4_local6 = Engine.Localize("MENU_ADD_PLAYER_FOR_TEAM_PLAY", InstanceRef)
	if InstanceRef > 1 then
		f4_local6 = Engine.Localize("MENU_ADD_PLAYERS_FOR_TEAM_PLAY", InstanceRef)
	end
	f4_local5:setText(f4_local6)
	Widget:addElement(f4_local5)
	return Widget
end

CoD.PlayerListRow.SetTextEllipses = function (f5_arg0, f5_arg1)
	local f5_local0 = ""
	for f5_local1 = 1, f5_arg1, 1 do
		local f5_local4 = f5_local1
		f5_local0 = f5_local0 .. "."
	end
	f5_arg0:setText(f5_arg0.text .. f5_local0)
end

CoD.PlayerListRow.UpdateEllipses = function (f6_arg0)
	f6_arg0.ellipsesCount = f6_arg0.ellipsesCount + f6_arg0.ellipsesIncrement
	local f6_local0 = 4
	if Engine.PartyConnectingToDedicated() then
		f6_local0 = 5
	end
	if f6_local0 <= f6_arg0.ellipsesCount then
		f6_arg0.ellipsesIncrement = -1
	elseif f6_arg0.ellipsesCount <= 0 then
		f6_arg0.ellipsesIncrement = 1
	end
	CoD.PlayerListRow.SetTextEllipses(f6_arg0, f6_arg0.ellipsesCount)
end

CoD.PlayerListRow.CreateSearchingRow = function (f7_arg0)
	local f7_local0 = 0
	local f7_local1 = Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH)
	if f7_local1 then
		f7_local0 = -CoD.PlayerListRow.LeagueRankAreaWidth
	end
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = f7_local0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.PlayerListRow.Height
	})
	Widget:makeNotFocusable()
	local f7_local3 = 0
	local f7_local4 = 0.5
	local f7_local5 = 0
	if f7_arg0 % 2 == 0 then
		f7_local5 = 0.05
	end
	local f7_local6 = CoD.GetTeamColor(CoD.TEAM_FREE)
	Widget.backgroundImage = LUI.UIImage.new()
	Widget.backgroundImage:setLeftRight(true, true, 0, 0)
	Widget.backgroundImage:setTopBottom(true, true, 0, 0)
	Widget.backgroundImage:setRGB(f7_local6.r, f7_local6.g, f7_local6.b)
	Widget.backgroundImage:setAlpha(f7_local3 + f7_local5)
	Widget.backgroundImage:setImage(RegisterMaterial("menu_mp_lobby_bar_name"))
	Widget:addElement(Widget.backgroundImage)
	Widget.textLabel = LUI.UIText.new()
	Widget.textLabel:setLeftRight(true, false, 5, 5)
	Widget.textLabel:setTopBottom(false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2, CoD.textSize[CoD.PlayerListRow.Font] / 2)
	Widget.textLabel:setFont(CoD.fonts[CoD.PlayerListRow.Font])
	Widget.textLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget.textLabel:setAlpha(f7_local4)
	Widget.textLabel.text = Engine.Localize("MENU_SEARCHING_FOR_PLAYER")
	Widget.textLabel:setText(Widget.textLabel.text)
	Widget:addElement(Widget.textLabel)
	Widget.textLabel.ellipsesCount = math.random(0, 3)
	Widget.textLabel.ellipsesIncrement = 1
	Widget.textLabel:registerEventHandler("update_ellipses", CoD.PlayerListRow.UpdateEllipses)
	Widget.ellipsesTimer = LUI.UITimer.new(250 + math.random(0, 100) - 50, "update_ellipses", false, Widget)
	Widget:addElement(Widget.ellipsesTimer)
	local f7_local7 = f7_arg0 / 10
	local f7_local8 = -5
	if f7_local1 then
		f7_local8 = CoD.PlayerListRow.Height
	end
	Widget.spinner = LUI.UIImage.new()
	Widget.spinner:setLeftRight(false, true, -CoD.PlayerListRow.Height + f7_local8, f7_local8)
	Widget.spinner:setTopBottom(true, true, 0, 0)
	Widget.spinner:setImage(RegisterMaterial("lui_loader_32"))
	Widget.spinner:setShaderVector(0, f7_local7, 0, 0, 0)
	Widget:addElement(Widget.spinner)
	return Widget
end

CoD.PlayerListRow.GainFocus = function (f8_arg0, f8_arg1)
	LUI.UIButton.gainFocus(f8_arg0, f8_arg1)
	f8_arg0:dispatchEventToParent({
		name = "playerlist_row_selected",
		playerName = f8_arg0.name,
		playerXuid = f8_arg0.playerXuid,
		leagueTeamID = f8_arg0.leagueTeamID,
		leagueTeamMemberCount = f8_arg0.leagueTeamMemberCount,
		listId = f8_arg0.playerList.id,
		listIndex = f8_arg0.rowIndex,
		controller = f8_arg1.controller
	})
end

CoD.PlayerListRow.LoseFocus = function (f9_arg0, f9_arg1)
	if f9_arg0:isInFocus() then
		f9_arg0:dispatchEventToParent({
			name = "playerlist_row_deselected",
			playerName = f9_arg0.name,
			playerXuid = f9_arg0.playerXuid,
			listId = f9_arg0.playerList.id,
			listIndex = f9_arg0.rowIndex,
			controller = f9_arg1.controller
		})
	end
	LUI.UIButton.loseFocus(f9_arg0, f9_arg1)
end

CoD.PlayerListRow.FetchingDone = function (f10_arg0, f10_arg1)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false and UIExpression.SessionMode_IsSystemlinkGame() == 0 then
		if f10_arg0.rankNumber ~= nil then
			f10_arg0.rankNumber:beginAnimation("fade_in", CoD.PlayerListRow.RankFadeInTime, true)
			f10_arg0.rankNumber:setAlpha(1)
		end
		if f10_arg0.rankIcon ~= nil then
			f10_arg0.rankIcon:beginAnimation("fade_in", CoD.PlayerListRow.RankFadeInTime, true)
			f10_arg0.rankIcon:setAlpha(1)
		end
	end
end

CoD.PlayerListRow.TeamCycle = function (f11_arg0, f11_arg1)
	if f11_arg1.xuid ~= f11_arg0.playerXuid then
		return false
	else
		CoD.PlayerListRow.Button_AnimateToTeam(f11_arg0, f11_arg1, f11_arg1.cycleTeam, true)
		return false
	end
end

CoD.PlayerListRow.GetRowAlpha = function (f12_arg0)
	local f12_local0 = 0
	if f12_arg0.verticalList:getNumChildren() % 2 == 0 then
		f12_local0 = 0.05
	end
	return 0.2 + f12_local0
end

CoD.PlayerListRow.AddRightColumnIcon = function (f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = LUI.UIImage.new()
	local f13_local1 = CoD.textSize[CoD.PlayerListRow.Font] - 1 * 2
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
		local f13_local2 = -4
		f13_local0:setLeftRight(false, true, f13_local2 - f13_local1, f13_local2)
		f13_local0:setAlpha(0.6)
	else
		local f13_local2 = 1
		f13_local0:setLeftRight(false, true, f13_local2, f13_local2 + f13_local1)
	end
	f13_local0:setTopBottom(false, false, -f13_local1 / 2, f13_local1 / 2)
	f13_local0:setImage(RegisterMaterial(f13_arg2))
	f13_arg0:addElement(f13_local0)
	return f13_local0
end

CoD.PlayerListRow.CreateRow = function (f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4, f14_arg5)
	local f14_local0 = ""
	if f14_arg1.tagprefix ~= nil then
		f14_local0 = f14_local0 .. f14_arg1.tagprefix
	end
	if f14_arg1.clantag ~= nil then
		f14_local0 = f14_local0 .. CoD.getClanTag(f14_arg1.clantag)
	end
	if f14_arg1.gamertag ~= nil then
		f14_local0 = f14_local0 .. f14_arg1.gamertag
	end
	local f14_local1 = 0
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
		f14_local1 = -CoD.PlayerListRow.LeagueRankAreaWidth
	end
	local f14_local2 = LUI.UIButton.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = f14_local1,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.PlayerListRow.Height
	})
	if f14_arg2 == false then
		f14_local2:makeNotFocusable()
	end
	f14_local2:registerEventHandler("gain_focus", CoD.PlayerListRow.GainFocus)
	f14_local2:registerEventHandler("lose_focus", CoD.PlayerListRow.LoseFocus)
	f14_local2:registerEventHandler("fetching_done", CoD.PlayerListRow.FetchingDone)
	f14_local2:registerEventHandler("party_member_team_cycle", CoD.PlayerListRow.TeamCycle)
	f14_local2:setActionEventName("open_playeroptions_popup")
	f14_local2.playerList = f14_arg0
	f14_local2.playerClientNum = f14_arg1.clientNum
	f14_local2.playerXuid = f14_arg1.xuid
	f14_local2.gamerTag = f14_arg1.clean_gamertag
	if f14_arg1.leagueTeamID then
		f14_local2.leagueTeamID = f14_arg1.leagueTeamID
	else
		f14_local2.leagueTeamID = "0"
	end
	f14_local2.leagueTeamMemberCount = f14_arg1.leagueTeamMemberCount
	local f14_local3 = CoD.PlayerListRow.GetRowAlpha(f14_arg0)
	local f14_local4 = 1
	local f14_local5 = 0
	f14_local2.backgroundAlpha = f14_local3
	local f14_local6 = CoD.GetTeamColor(f14_arg1.team, CoD.GetFaction())
	f14_local2.backgroundColor = LUI.UIImage.new()
	f14_local2.backgroundColor:setLeftRight(true, true, 0, 0)
	f14_local2.backgroundColor:setTopBottom(true, true, 0, 0)
	f14_local2.backgroundColor:setRGB(f14_local6.r, f14_local6.g, f14_local6.b)
	f14_local2.backgroundColor:setAlpha(f14_local3)
	f14_local2.backgroundColor:setImage(RegisterMaterial("menu_mp_lobby_bar_name"))
	f14_local2:addElement(f14_local2.backgroundColor)
	local f14_local7 = LUI.UIImage.new()
	f14_local7:setLeftRight(true, true, 1, -1)
	f14_local7:setTopBottom(true, false, 1, 17)
	f14_local7:setImage(RegisterMaterial(CoD.MPZM("menu_mp_cac_grad_stretch", "menu_zm_cac_grad_stretch")))
	f14_local7:setAlpha(0.07)
	f14_local2:addElement(f14_local7)
	local f14_local8 = 30
	local f14_local9 = 32
	if f14_arg1.isLocal == 1 and not CoD.isPC and not CoD.isWIIU then
		local f14_local10 = f14_arg1.controller
		if f14_local10 == nil then
			f14_local10 = 0
		end
		f14_local10 = f14_local10 + 1
		f14_local2.controllerQuadrantIcon = LUI.UIImage.new()
		f14_local2.controllerQuadrantIcon:setImage(RegisterMaterial("controller_icon" .. f14_local10))
		f14_local2.controllerQuadrantIcon:setLeftRight(true, false, -f14_local8 - f14_local9, -f14_local9)
		f14_local2.controllerQuadrantIcon:setTopBottom(false, true, -f14_local8, 0)
		f14_local2:addElement(f14_local2.controllerQuadrantIcon)
	end
	local f14_local10 = 0
	if f14_arg0.showVoipIcons == true then
		f14_local2.voipIcon = CoD.VoipImage.new(nil, f14_arg1.clientNum)
		f14_local2.voipIcon:setLeftRight(true, false, -f14_local9, 0)
		f14_local2.voipIcon:setTopBottom(true, true, 0, 0)
		f14_local2:addElement(f14_local2.voipIcon)
	end
	local f14_local11 = Engine.PartyShowTruePlayerInfo(f14_arg1.clientNum)
	local f14_local12 = 60
	local f14_local13 = 0
	local f14_local14 = Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == true
	local f14_local15 = nil
	if f14_local14 == true then
		f14_local15 = Engine.GetLeagueStats(f14_arg1.controller)
	end
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false and 0 == UIExpression.SessionMode_IsSystemlinkGame() and 1 == UIExpression.IsDemonwareFetchingDone(nil) and (not (not f14_local15 or f14_local15.valid ~= true) or f14_local15 == nil) then
		f14_local13 = 1
	end
	if CoD.isZombie == true then
		local f14_local16 = ""
		if f14_arg1.isReady ~= nil and 0 < UIExpression.DvarFloat(nil, "party_readyPercentRequired") and CoD.PlaylistCategoryFilter == "playermatch" then
			if f14_arg1.isReady == true then
				f14_local16 = "menu_lobby_ready"
			else
				f14_local16 = "menu_lobby_not_ready"
			end
			local f14_local17 = RegisterMaterial(f14_local16)
			f14_local2.isReady = LUI.UIImage.new()
			f14_local2.isReady:setLeftRight(true, false, f14_local10 + 5, f14_local10 + f14_local12 * 0.45)
			f14_local2.isReady:setTopBottom(false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2, CoD.textSize[CoD.PlayerListRow.Font] / 2)
			f14_local2.isReady:setImage(f14_local17)
			f14_local2:addElement(f14_local2.isReady)
		else
			f14_local12 = 30
		end
	elseif f14_arg1.prestige ~= tonumber(CoD.MAX_PRESTIGE) then
		f14_local2.rankNumber = LUI.UIText.new()
		f14_local2.rankNumber:setLeftRight(true, false, f14_local10 + 5, f14_local10 + f14_local12)
		f14_local2.rankNumber:setTopBottom(false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2, CoD.textSize[CoD.PlayerListRow.Font] / 2)
		f14_local2.rankNumber:setFont(CoD.fonts[CoD.PlayerListRow.Font])
		f14_local2.rankNumber:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f14_local2.rankNumber:setAlpha(f14_local13)
		f14_local2:addElement(f14_local2.rankNumber)
		if f14_arg1.rank ~= nil and f14_local11 == true then
			f14_local2.rankNumber:setText(f14_arg1.rank)
		end
	end
	f14_local10 = f14_local10 + f14_local12
	if f14_arg1.rankIcon ~= nil and f14_local11 == true then
		if f14_local14 == true then
			if f14_arg1.rank ~= 0 and f14_arg1.rankIcon ~= nil and f14_arg4 == true then
				f14_local2.rankIcon = LUI.UIImage.new()
				f14_local2.rankIcon:setLeftRight(false, true, 0, CoD.PlayerListRow.Height)
				f14_local2.rankIcon:setTopBottom(true, true, 0, 0)
				f14_local2.rankIcon:setAlpha(f14_local13)
				f14_local2.rankIcon:setImage(f14_arg1.rankIcon)
				f14_local2:addElement(f14_local2.rankIcon)
			elseif f14_local2.rankIcon ~= nil then
				f14_local2.rankIcon:close()
				f14_local2.rankIcon = nil
			end
		else
			f14_local2.rankIcon = LUI.UIImage.new()
			f14_local2.rankIcon:setLeftRight(true, false, f14_local10 - CoD.PlayerListRow.Height - 2, f14_local10 - 2)
			f14_local2.rankIcon:setTopBottom(true, true, 0, 0)
			f14_local2.rankIcon:setAlpha(f14_local13)
			f14_local2.rankIcon:setImage(f14_arg1.rankIcon)
			f14_local2:addElement(f14_local2.rankIcon)
		end
	end
	local f14_local16 = 100
	local f14_local17 = f14_local10 + 5
	if f14_local14 == true then
		f14_local17 = 0
	end
	f14_local2.playerName = LUI.UIText.new()
	f14_local2.playerName:setLeftRight(true, false, f14_local17 + 5, f14_local17 + f14_local16)
	f14_local2.playerName:setTopBottom(false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2, CoD.textSize[CoD.PlayerListRow.Font] / 2)
	f14_local2.playerName:setFont(CoD.fonts[CoD.PlayerListRow.Font])
	f14_local2.playerName:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f14_local2.playerName:setAlpha(f14_local4)
	f14_local2:addElement(f14_local2.playerName)
	if f14_arg1.isLocal == 1 then
		f14_local2.playerName:setRGB(CoD.playerYellow.r, CoD.playerYellow.g, CoD.playerYellow.b)
	elseif f14_arg1.isInParty == true then
		f14_local2.playerName:setRGB(CoD.playerBlue.r, CoD.playerBlue.g, CoD.playerBlue.b)
	end
	if f14_local11 == false then
		f14_local2.playerName:setText(Engine.Localize("MP_MATCHEDPLAYER"))
		f14_local2.name = f14_local0
	elseif f14_local0 ~= nil then
		f14_local2.playerName:setText(f14_local0)
		f14_local2.name = f14_local0
	end
	f14_local2.border = CoD.Border.new(1, CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f14_local2.border:hide()
	f14_local2.border:registerEventHandler("button_up", f14_local2.border.hide)
	f14_local2.border:registerEventHandler("button_over", f14_local2.border.show)
	f14_local2:addElement(f14_local2.border)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false then
		local f14_local18 = true
		if UIExpression.AloneInPartyIgnoreSplitscreen(nil, 0) == 0 then
			f14_local18 = false
		end
		if f14_local11 ~= false then
			local f14_local19 = false
			local f14_local20 = false
			if f14_arg1.xuid and CoD.isXuidPrivatePartyHost(f14_arg1.xuid) then
				f14_local19 = true
			end
			if f14_arg5 == true and f14_arg1.missingMapPacks ~= nil and f14_arg1.missingMapPacks ~= 0 then
				f14_local20 = true
			end
			if f14_local18 == false and f14_local19 == true and f14_local20 == true and CoD.isZombie ~= true then
				CoD.PlayerListRow.AddRightColumnIcon(f14_local2, f14_arg1, "menu_host_warning")
			elseif f14_local18 == false and f14_local19 then
				CoD.PlayerListRow.AddRightColumnIcon(f14_local2, f14_arg1, CoD.MPZM("ui_host", "ui_host_zm"))
			elseif f14_local20 then
				CoD.PlayerListRow.AddRightColumnIcon(f14_local2, f14_arg1, "cac_restricted")
			end
		end
	end
	CoD.PlayerListRow.Button_AnimateToTeam(f14_local2, f14_arg1, nil, f14_arg3)
	return f14_local2
end

CoD.PlayerListRow.Button_CycleTeamFade = function (f15_arg0, f15_arg1)
	f15_arg0:animateToState("fade", UIExpression.DvarFloat(nil, "party_teamSwitchDelay") * 1000 * 0.33)
	f15_arg0.playerName:completeAnimation()
	f15_arg0.playerName:beginAnimation("restore", 200)
	f15_arg0.playerName:setAlpha(1)
end

CoD.PlayerListRow.Button_AnimateToTeam = function (f16_arg0, f16_arg1, f16_arg2, f16_arg3)
	local f16_local0 = 1
	if f16_arg1.background == nil then
		f16_local0 = 0.5
	end
	local f16_local1 = f16_arg2
	if f16_local1 == nil then
		f16_local1 = f16_arg1.team
	end
	if not f16_arg3 and f16_local1 ~= CoD.TEAM_SPECTATOR then
		f16_local1 = CoD.TEAM_FREE
	end
	local f16_local2 = CoD.GetTeamColor(f16_local1, CoD.GetFaction())
	f16_arg0.backgroundColor:setRGB(f16_local2.r, f16_local2.g, f16_local2.b)
	if f16_arg0.score ~= nil then
		f16_arg0.score:close()
		f16_arg0.score = nil
	end
	if f16_arg0.cycleButtonPrompt ~= nil then
		f16_arg0.cycleButtonPrompt:close()
		f16_arg0.cycleButtonPrompt = nil
	end
	if f16_arg2 ~= nil then
		local f16_local3 = CoD.GetTeamName(f16_arg2)
		local f16_local4 = "MPUI_" .. f16_local3
		if CoD.isZombie == true then
			f16_local4 = "ZMUI_" .. f16_local3 .. "_SHORT_CAPS"
		end
		local f16_local5 = Engine.Localize(f16_local4)
		if f16_arg2 == CoD.TEAM_SPECTATOR or f16_arg2 == CoD.TEAM_FREE then
			f16_local5 = f16_local3
		end
		f16_arg0.cycleButtonPrompt = CoD.DualButtonPrompt.new("shoulderl", f16_local5, "shoulderr", nil, nil, nil, nil, LUI.Alignment.Center, 130)
		f16_arg0.cycleButtonPrompt:registerAnimationState("static", {
			alpha = 1
		})
		f16_arg0.cycleButtonPrompt:registerAnimationState("fade", {
			alpha = 0
		})
		f16_arg0.cycleButtonPrompt.playerName = f16_arg0.playerName
		f16_arg0.cycleButtonPrompt.playerName:setAlpha(0.2)
		f16_arg0.cycleButtonPrompt:animateToState("static", UIExpression.DvarFloat(nil, "party_teamSwitchDelay") * 1000 * 0.33)
		f16_arg0.cycleButtonPrompt:registerEventHandler("transition_complete_static", CoD.PlayerListRow.Button_CycleTeamFade)
		f16_arg0:addElement(f16_arg0.cycleButtonPrompt)
	else
		local f16_local3 = Engine.PartyShowTruePlayerInfo(f16_arg1.clientNum)
		local f16_local4 = f16_arg1.score
		local f16_local5 = -8
		if Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) == false and Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == false and Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false and f16_local3 ~= false and f16_local4 ~= nil and f16_local4 ~= "" then
			local f16_local6 = 50
			f16_arg0.score = LUI.UIText.new()
			f16_arg0.score:setLeftRight(false, true, f16_local5 - f16_local6, f16_local5)
			f16_arg0.score:setTopBottom(false, false, -CoD.textSize[CoD.PlayerListRow.Font] / 2, CoD.textSize[CoD.PlayerListRow.Font] / 2)
			f16_arg0.score:setFont(CoD.fonts[CoD.PlayerListRow.Font])
			f16_arg0.score:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
			f16_arg0.score:setAlpha(f16_local0)
			f16_arg0:addElement(f16_arg0.score)
			f16_arg0.score:setText(f16_local4)
		end
	end
end

