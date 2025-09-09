CoD.PlayerIdentity = {}
CoD.PlayerIdentity.Default = 1
CoD.PlayerIdentity.League = 2
CoD.PlayerIdentity.PrestigeLabelFontName = "Default"
CoD.PlayerIdentity.RankFontName = "Default"
CoD.PlayerIdentity.LeagueFontName = "ExtraSmall"
CoD.PlayerIdentity.JoinableFontName = "Default"
CoD.PlayerIdentity.ShowMPRank = function (f1_arg0)
	local f1_local0
	if f1_arg0 == nil or f1_arg0.rank == nil or tonumber(f1_arg0.rank) <= 0 then
		f1_local0 = false
	else
		f1_local0 = true
	end
	return f1_local0
end

CoD.PlayerIdentity.ShowLeagueInfo = function (f2_arg0)
	local f2_local0
	if f2_arg0 == nil or f2_arg0.teamID == nil or f2_arg0.teamID == "0" or f2_arg0.teamID == 0 or Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) ~= true then
		f2_local0 = false
	else
		f2_local0 = true
	end
	return f2_local0
end

CoD.PlayerIdentity.New = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local Widget = LUI.UIElement.new(f3_arg0)
	Widget.width = f3_arg1
	Widget.displayMode = f3_arg2
	Widget.update = CoD.PlayerIdentity.Update
	Widget:registerEventHandler("league_team_all_info_fetched", CoD.PlayerIdentity.LeagueLbDataFetched)
	Widget:registerEventHandler("league_lb_data_fetched", CoD.PlayerIdentity.LeagueLbDataFetched)
	local f3_local1 = 0
	local f3_local2 = 4
	local f3_local3 = f3_arg1 * 0.66
	local f3_local4 = 0
	local f3_local5 = f3_local3 / 4 * 5 - 1
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f3_local4, f3_local4 + f3_local3)
	Widget:setTopBottom(true, false, f3_local1, f3_local1 + f3_local5)
	Widget:addElement(Widget)
	local f3_local7 = LUI.UIImage.new()
	f3_local7:setLeftRight(true, true, 1, -1)
	f3_local7:setTopBottom(true, true, 1, -1)
	f3_local7:setRGB(0, 0, 0)
	f3_local7:setAlpha(0.6)
	Widget:addElement(f3_local7)
	local f3_local8 = LUI.UIImage.new()
	f3_local8:setLeftRight(true, true, f3_local2, -f3_local2)
	f3_local8:setTopBottom(true, false, f3_local2, 80)
	f3_local8:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f3_local8:setAlpha(0.1)
	Widget:addElement(f3_local8)
	local f3_local9 = 2
	local f3_local10 = f3_local3 - f3_local9 * 2
	Widget.emblem = LUI.UIImage.new()
	Widget.emblem:setLeftRight(false, false, -(f3_local10 / 2), f3_local10 / 2)
	Widget.emblem:setTopBottom(true, false, f3_local9, f3_local9 + f3_local10)
	Widget.emblem:hide()
	Widget:addElement(Widget.emblem)
	local f3_local11 = f3_local9 + f3_local10
	local f3_local12 = f3_local10
	Widget.backingContainer = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f3_local12 / 2,
		right = f3_local12 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f3_local11,
		bottom = f3_local11 + f3_local12 / 4
	})
	Widget.backingContainer:setFont(CoD.fonts.Default)
	Widget.backingContainer:hide()
	Widget:addElement(Widget.backingContainer)
	Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget:addElement(Widget.border)
	local f3_local13 = f3_local4 + f3_local3
	local f3_local14 = f3_arg1 - f3_local3
	local f3_local15 = f3_local5 / 2
	local f3_local16 = CoD.fonts[CoD.PlayerIdentity.PrestigeLabelFontName]
	local f3_local17 = CoD.textSize[CoD.PlayerIdentity.PrestigeLabelFontName]
	local f3_local18 = CoD.fonts[CoD.PlayerIdentity.RankFontName]
	local f3_local19 = CoD.textSize[CoD.PlayerIdentity.RankFontName]
	local f3_local20 = CoD.fonts[CoD.PlayerIdentity.LeagueFontName]
	local f3_local21 = CoD.textSize[CoD.PlayerIdentity.LeagueFontName]
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f3_local13, f3_local13 + f3_local14)
	Widget:setTopBottom(true, false, f3_local1, f3_local1 + f3_local15)
	Widget:addElement(Widget)
	local f3_local23 = LUI.UIImage.new()
	f3_local23:setLeftRight(true, true, 1, -1)
	f3_local23:setTopBottom(true, true, 1, -1)
	f3_local23:setRGB(0, 0, 0)
	f3_local23:setAlpha(0.6)
	Widget:addElement(f3_local23)
	local f3_local24 = LUI.UIImage.new()
	f3_local24:setLeftRight(true, true, f3_local2 - 2, -f3_local2)
	f3_local24:setTopBottom(true, false, f3_local2, 80)
	f3_local24:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f3_local24:setAlpha(0.1)
	Widget:addElement(f3_local24)
	if f3_arg2 == CoD.PlayerIdentity.Default then
		local Widget = 5
		local f3_local26 = f3_local15 - f3_local19 * 2 - 10
		Widget.rankIconContainer = LUI.UIElement.new()
		Widget.rankIconContainer:setLeftRight(false, false, -f3_local26 / 2, f3_local26 / 2)
		Widget.rankIconContainer:setTopBottom(true, false, Widget, Widget + f3_local26)
		Widget:addElement(Widget.rankIconContainer)
		local f3_local27 = f3_local19 / 2
		Widget.rank = LUI.UIText.new()
		Widget.rank:setLeftRight(true, true, 0, 0)
		Widget.rank:setTopBottom(false, true, -5 - f3_local27 - f3_local19, -5 - f3_local27)
		Widget.rank:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		Widget.rank:setFont(f3_local18)
		Widget.rank:setAlignment(LUI.Alignment.Center)
		Widget:addElement(Widget.rank)
		Widget.prestigeLabel = LUI.UIText.new()
		Widget.prestigeLabel:setLeftRight(true, true, 0, 0)
		Widget.prestigeLabel:setTopBottom(false, true, -5 - f3_local19, -5)
		Widget.prestigeLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		Widget.prestigeLabel:setFont(f3_local18)
		Widget.prestigeLabel:setAlignment(LUI.Alignment.Center)
		Widget:addElement(Widget.prestigeLabel)
	elseif f3_arg2 == CoD.PlayerIdentity.League then
		local Widget = 0
		Widget.currentRankLabel = LUI.UIText.new()
		Widget.currentRankLabel:setLeftRight(true, true, 0, 0)
		Widget.currentRankLabel:setTopBottom(true, false, Widget, Widget + f3_local21)
		Widget.currentRankLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		Widget.currentRankLabel:setFont(f3_local18)
		Widget.currentRankLabel:setAlignment(LUI.Alignment.Center)
		Widget:addElement(Widget.currentRankLabel)
		Widget = Widget + f3_local21
		local f3_local26 = f3_local15 - f3_local21 * 3
		Widget.divisionIconContainer = LUI.UIElement.new()
		Widget.divisionIconContainer:setLeftRight(false, false, -f3_local26 / 2, f3_local26 / 2)
		Widget.divisionIconContainer:setTopBottom(true, false, Widget, Widget + f3_local26)
		Widget:addElement(Widget.divisionIconContainer)
		Widget = Widget + f3_local26 - 2
		Widget.leagueDivisionLabel = LUI.UIText.new()
		Widget.leagueDivisionLabel:setLeftRight(true, true, 0, 0)
		Widget.leagueDivisionLabel:setTopBottom(true, false, Widget, Widget + f3_local21)
		Widget.leagueDivisionLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		Widget.leagueDivisionLabel:setFont(f3_local18)
		Widget.leagueDivisionLabel:setAlignment(LUI.Alignment.Center)
		Widget:addElement(Widget.leagueDivisionLabel)
		Widget = Widget + f3_local21
		Widget.leagueRankLabel = LUI.UIText.new()
		Widget.leagueRankLabel:setLeftRight(true, true, 0, 0)
		Widget.leagueRankLabel:setTopBottom(true, false, Widget, Widget + f3_local21)
		Widget.leagueRankLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		Widget.leagueRankLabel:setFont(f3_local18)
		Widget.leagueRankLabel:setAlignment(LUI.Alignment.Center)
		Widget:addElement(Widget.leagueRankLabel)
	end
	Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget.border.leftBorder:close()
	Widget:addElement(Widget.border)
	f3_local1 = f3_local1 + f3_local15 - 2
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f3_local13, f3_local13 + f3_local14)
	Widget:setTopBottom(true, false, f3_local1, f3_local1 + f3_local15 + 2)
	Widget:addElement(Widget)
	local f3_local26 = LUI.UIImage.new()
	f3_local26:setLeftRight(true, true, 1, -1)
	f3_local26:setTopBottom(true, true, 1, -1)
	f3_local26:setRGB(0, 0, 0)
	f3_local26:setAlpha(0.6)
	Widget:addElement(f3_local26)
	local f3_local27 = LUI.UIImage.new()
	f3_local27:setLeftRight(true, true, f3_local2 - 2, -f3_local2)
	f3_local27:setTopBottom(true, false, f3_local2, 80)
	f3_local27:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f3_local27:setAlpha(0.1)
	Widget:addElement(f3_local27)
	if f3_arg2 == CoD.PlayerIdentity.Default then
		local f3_local28 = 5
		local f3_local29 = f3_local15 - f3_local19 * 2 - 10
		Widget.bestDivisionIconContainer = LUI.UIElement.new()
		Widget.bestDivisionIconContainer:setLeftRight(false, false, -f3_local29 / 2, f3_local29 / 2)
		Widget.bestDivisionIconContainer:setTopBottom(true, false, f3_local28, f3_local28 + f3_local29)
		Widget:addElement(Widget.bestDivisionIconContainer)
		f3_local28 = f3_local28 + f3_local29 - 2
		Widget.bestLeagueRankLabel = LUI.UIText.new()
		Widget.bestLeagueRankLabel:setLeftRight(true, true, 0, 0)
		Widget.bestLeagueRankLabel:setTopBottom(true, false, f3_local28, f3_local28 + f3_local19)
		Widget.bestLeagueRankLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		Widget.bestLeagueRankLabel:setFont(f3_local18)
		Widget.bestLeagueRankLabel:setAlignment(LUI.Alignment.Center)
		Widget:addElement(Widget.bestLeagueRankLabel)
		f3_local28 = f3_local28 + f3_local19
		Widget.leagueBestLabel = LUI.UIText.new()
		Widget.leagueBestLabel:setLeftRight(true, true, 0, 0)
		Widget.leagueBestLabel:setTopBottom(true, false, f3_local28, f3_local28 + f3_local19)
		Widget.leagueBestLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		Widget.leagueBestLabel:setFont(f3_local18)
		Widget.leagueBestLabel:setAlignment(LUI.Alignment.Center)
		Widget:addElement(Widget.leagueBestLabel)
	elseif f3_arg2 == CoD.PlayerIdentity.League then
		local f3_local28 = f3_local21 / 2
		local f3_local29 = f3_local15 - f3_local21 * 2.5
		Widget.currentLeagueIconContainer = LUI.UIElement.new()
		Widget.currentLeagueIconContainer:setLeftRight(false, false, -f3_local29 / 2, f3_local29 / 2)
		Widget.currentLeagueIconContainer:setTopBottom(true, false, f3_local28, f3_local28 + f3_local29)
		Widget:addElement(Widget.currentLeagueIconContainer)
		f3_local28 = f3_local28 + f3_local29 - 2
		Widget.currentLeagueNameLabel = LUI.UIText.new()
		Widget.currentLeagueNameLabel:setLeftRight(true, true, 0, 0)
		Widget.currentLeagueNameLabel:setTopBottom(true, false, f3_local28, f3_local28 + f3_local21)
		Widget.currentLeagueNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		Widget.currentLeagueNameLabel:setFont(f3_local18)
		Widget.currentLeagueNameLabel:setAlignment(LUI.Alignment.Center)
		Widget:addElement(Widget.currentLeagueNameLabel)
	end
	Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget.border.leftBorder:close()
	Widget.border.topBorder:close()
	Widget:addElement(Widget.border)
	f3_local1 = f3_local1 + f3_local15
	if f3_arg3 == true then
		f3_local1 = f3_local1 + 20
		local f3_local28 = CoD.fonts[CoD.PlayerIdentity.JoinableFontName]
		local f3_local29 = CoD.textSize[CoD.PlayerIdentity.JoinableFontName]
		local f3_local30 = 2
		local f3_local31 = f3_arg1
		local f3_local32 = f3_local29 * 2 + f3_local30
		Widget.joinableContainer = LUI.UIElement.new()
		Widget.joinableContainer:setLeftRight(false, false, -f3_local31 / 2, f3_local31 / 2)
		Widget.joinableContainer:setTopBottom(true, false, f3_local1, f3_local1 + f3_local32)
		Widget:addElement(Widget.joinableContainer)
		local f3_local33 = LUI.UIImage.new()
		f3_local33:setLeftRight(true, true, 1, -1)
		f3_local33:setTopBottom(true, true, 1, -1)
		f3_local33:setRGB(0, 0, 0)
		f3_local33:setAlpha(0.6)
		Widget.joinableContainer:addElement(f3_local33)
		local f3_local34 = LUI.UIImage.new()
		f3_local34:setLeftRight(true, true, f3_local2, -f3_local2)
		f3_local34:setTopBottom(true, false, f3_local2, f3_local32 * 0.6)
		f3_local34:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
		f3_local34:setAlpha(0.1)
		Widget.joinableContainer:addElement(f3_local34)
		Widget.joinableContainer.border = CoD.Border.new(1, 1, 1, 1, 0.1)
		Widget.joinableContainer:addElement(Widget.joinableContainer.border)
		local f3_local35 = 0
		Widget.statusLabel = LUI.UIText.new()
		Widget.statusLabel:setLeftRight(false, false, -f3_arg1 / 2, f3_arg1 / 2)
		Widget.statusLabel:setTopBottom(false, false, -(f3_local29 / 2) - 3, f3_local29 / 2 - 3)
		Widget.statusLabel:setFont(f3_local28)
		Widget.statusLabel:setAlignment(LUI.Alignment.Center)
		Widget.joinableContainer:addElement(Widget.statusLabel)
		f3_local35 = f3_local35 + f3_local29
		Widget.joinableTextLabel = LUI.UIText.new()
		Widget.joinableTextLabel:setLeftRight(false, false, -f3_arg1 / 2, f3_arg1 / 2)
		Widget.joinableTextLabel:setTopBottom(true, false, f3_local35, f3_local35 + f3_local29)
		Widget.joinableTextLabel:setFont(f3_local28)
		Widget.joinableTextLabel:setAlignment(LUI.Alignment.Center)
		Widget.joinableContainer:addElement(Widget.joinableTextLabel)
		local f3_local36, f3_local37, f3_local38, f3_local39 = GetTextDimensions(Engine.Localize("MENU_JOINABLE"), f3_local28, f3_local29)
		local f3_local40 = f3_local29
		Widget.joinableIcon = LUI.UIImage.new()
		Widget.joinableIcon:setLeftRight(false, false, -(f3_local38 / 2) - f3_local30 - f3_local40, -(f3_local38 / 2) - f3_local30)
		Widget.joinableIcon:setTopBottom(true, false, f3_local35, f3_local35 + f3_local40)
		Widget.joinableIcon:setAlpha(0)
		Widget.joinableIcon:setImage(RegisterMaterial("menu_mp_party_ease_icon"))
		Widget.joinableIcon:setAlignment(LUI.Alignment.Left)
		Widget.joinableContainer:addElement(Widget.joinableIcon)
		f3_local1 = f3_local1 + f3_local32
	end
	return Widget, f3_local1
end

CoD.PlayerIdentity.FindLeagueLbData = function (f4_arg0, f4_arg1)
	for f4_local3, f4_local4 in ipairs(f4_arg0) do
		if f4_local4.teamID == f4_arg1 then
			return f4_local4
		end
	end
end

CoD.PlayerIdentity.LeagueLbDataFetched = function (f5_arg0, f5_arg1)
	if f5_arg0.spinner then
		f5_arg0.spinner:close()
	end
	if f5_arg1.success and f5_arg1.teamID == f5_arg0.teamID and f5_arg1.fetchAllInfoForTeamInLeague then
		f5_arg0:update(f5_arg1.controller, f5_arg0.selectedPlayerShowTruePlayerInfo, f5_arg0.selectedPlayerXuid, f5_arg0.playerInfo, f5_arg0.leagueInfo)
	end
end

CoD.PlayerIdentity.FindTeamSubdivisionInfo = function (f6_arg0, f6_arg1)
	for f6_local3, f6_local4 in ipairs(f6_arg0) do
		if f6_arg1 and f6_arg1 == f6_local4.leagueID then
			return f6_local4
		end
	end
end

CoD.PlayerIdentity.UpdateDefault = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4, f7_arg5)
	f7_arg0.emblem:show()
	f7_arg0.emblem:setupPlayerEmblemByXUID(f7_arg3)
	if f7_arg0.rankIcon ~= nil then
		f7_arg0.rankIcon:close()
		f7_arg0.rankIcon = nil
	end
	if CoD.PlayerIdentity.ShowMPRank(f7_arg4) == true then
		local f7_local0 = f7_arg4.rankImage
		if f7_local0 == nil then
			f7_local0 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f7_arg4.rank - 1, f7_arg4.prestige + 1) .. "_128"
		end
		f7_arg0.rankIcon = LUI.UIStreamedImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0,
			material = RegisterMaterial(f7_local0),
			alpha = 1
		})
		f7_arg0.rankIconContainer:addElement(f7_arg0.rankIcon)
		local f7_local1 = f7_arg4.prestige == tonumber(CoD.MAX_PRESTIGE)
		local f7_local2 = CoD.textSize[CoD.PlayerIdentity.RankFontName]
		local f7_local3 = f7_local2 / 2
		if f7_arg4.prestige > 0 then
			f7_local3 = f7_local2
		end
		f7_arg0.rank:setTopBottom(false, true, -5 - f7_local3 - f7_local2, -5 - f7_local3)
		if f7_local1 then
			f7_arg0.rank:setLeftRight(true, true, 10, -10)
			f7_arg0.rank:setText(Engine.Localize("MENU_MASTER"))
		else
			f7_arg0.rank:setLeftRight(true, true, 0, 0)
			f7_arg0.rank:setText(Engine.Localize("MPUI_LEVEL_N", f7_arg4.rank))
		end
		if f7_arg4.prestige > 0 and not f7_local1 then
			f7_arg0.prestigeLabel:setText(Engine.Localize("MPUI_PRESTIGE_N", f7_arg4.prestige))
		else
			f7_arg0.prestigeLabel:setText("")
		end
		if f7_arg4.bestDivisionRank ~= nil and f7_arg4.bestDivisionIcon ~= nil and not Engine.IsInGame() then
			if f7_arg0.bestLeagueDivisionIcon ~= nil then
				f7_arg0.bestLeagueDivisionIcon:close()
				f7_arg0.bestLeagueDivisionIcon = nil
			end
			f7_arg0.bestLeagueDivisionIcon = LUI.UIStreamedImage.new({
				leftAnchor = true,
				rightAnchor = true,
				left = 0,
				right = 0,
				topAnchor = true,
				bottomAnchor = true,
				top = 0,
				bottom = 0,
				material = f7_arg4.bestDivisionIcon,
				alpha = 1
			})
			f7_arg0.bestDivisionIconContainer:addElement(f7_arg0.bestLeagueDivisionIcon)
			f7_arg0.bestLeagueRankLabel:setText(Engine.Localize("MENU_RANK_N", f7_arg4.bestDivisionRank))
			f7_arg0.leagueBestLabel:setText(Engine.Localize("MENU_LEAGUE_BEST"))
		else
			f7_arg0.bestLeagueRankLabel:setText("")
			f7_arg0.leagueBestLabel:setText("")
			if f7_arg0.bestLeagueDivisionIcon ~= nil then
				f7_arg0.bestLeagueDivisionIcon:close()
				f7_arg0.bestLeagueDivisionIcon = nil
			end
		end
	else
		f7_arg0.rank:setText("")
		f7_arg0.prestigeLabel:setText("")
	end
end

CoD.PlayerIdentity.UpdateLeague = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4, f8_arg5)
	if CoD.PlayerIdentity.ShowLeagueInfo(f8_arg5) ~= true then
		return 
	end
	f8_arg0.controller = f8_arg1
	f8_arg0.selectedPlayerShowTruePlayerInfo = f8_arg2
	f8_arg0.selectedPlayerXuid = f8_arg3
	f8_arg0.playerInfo = f8_arg4
	f8_arg0.leagueInfo = f8_arg5
	local f8_local0 = Engine.GetLeague()
	local f8_local1 = f8_arg5.teamID
	f8_arg0.currTeamID = f8_local1
	local f8_local2 = false
	local f8_local3, f8_local4, f8_local5, f8_local6, f8_local7, f8_local8 = false
	if not f8_local0 then
		return 
	elseif f8_arg0.currentLeagueIcon ~= nil then
		f8_arg0.currentLeagueIcon:close()
		f8_arg0.currentLeagueIcon = nil
	end
	f8_arg0.emblem:show()
	if f8_arg5 and f8_arg5.leagueTeamMemberCount and f8_arg5.leagueTeamMemberCount == 1 and f8_arg3 ~= "0" then
		f8_arg0.emblem:setupPlayerEmblemByXUID(f8_arg3)
	else
		f8_arg0.emblem:setupLeagueEmblem(f8_local1)
	end
	f8_arg0.currentLeagueIcon = LUI.UIStreamedImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = -5,
		bottom = -5,
		material = RegisterMaterial(f8_local0.iconName .. "_64"),
		alpha = 1
	})
	f8_arg0.currentLeagueIconContainer:addElement(f8_arg0.currentLeagueIcon)
	if not f8_arg0.divisionIconSpinner then
		f8_arg0.divisionIconSpinner = CoD.GetCenteredImage(64, 64, "lui_loader")
		f8_arg0.divisionIconContainer:addElement(f8_arg0.divisionIconSpinner)
	end
	f8_arg0.currentLeagueNameLabel:setText(f8_local0.description)
	local f8_local9 = f8_local0.id
	f8_arg0.currLeagueID = f8_local9
	if Engine.LeagueIsPreSeason(f8_local9) then
		return 
	end
	f8_arg0.teamID = f8_local1
	if not Engine.FetchAllInfoForTeamInLeague(f8_arg1, f8_local1, f8_local9, 5) then
		return 
	end
	local f8_local10, f8_local11 = Engine.GetLeagueTeamSubdivisionInfos(f8_arg1, f8_local1)
	if f8_local10 ~= "fetched" then
		return 
	elseif f8_local11 then
		f8_local4 = CoD.PlayerIdentity.FindTeamSubdivisionInfo(f8_local11, f8_local9)
		if not f8_local4 then
			f8_local2 = true
		end
	end
	f8_local6 = Engine.GetLeagueLbData(f8_arg1)
	if not f8_local6 and not f8_local2 then
		return 
	elseif not f8_local2 then
		f8_local5 = CoD.PlayerIdentity.FindLeagueLbData(f8_local6, f8_local1)
	end
	if not f8_local2 and (not f8_local5 or not f8_local4) then
		return 
	elseif f8_arg0.divisionIconSpinner then
		f8_arg0.divisionIconSpinner:close()
	end
	local f8_local12 = RegisterMaterial("menu_div_no_place")
	if not f8_local2 and f8_local4 then
		local f8_local13 = Engine.GetLeagueDivisionIcon(f8_local4.divisionID, false, f8_local5.rank)
		if f8_local13 then
			f8_local12 = f8_local13.divisionIcon
		end
	end
	if f8_arg0.leagueDivisionIcon ~= nil then
		f8_arg0.leagueDivisionIcon:close()
		f8_arg0.leagueDivisionIcon = nil
	end
	f8_arg0.leagueDivisionIcon = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		material = f8_local12,
		alpha = 1
	})
	f8_arg0.divisionIconContainer:addElement(f8_arg0.leagueDivisionIcon)
	if f8_local2 then
		return 
	elseif f8_local4.divisionName then
		f8_arg0.leagueDivisionLabel:setText(f8_local4.divisionName)
	end
	if f8_local5 and f8_local5.rank then
		f8_arg0.leagueRankLabel:setText(Engine.Localize("MENU_RANK_N", f8_local5.rank))
		f8_arg0.currentRankLabel:setText(Engine.Localize("MENU_CURRENT_RANK"))
	end
end

CoD.PlayerIdentity.Update = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4, f9_arg5)
	if f9_arg2 == false then
		return 
	end
	f9_arg0.backingContainer:show()
	f9_arg0.backingContainer:setupMiniIdentity(f9_arg3, 0)
	f9_arg0.backingContainer:setFont(CoD.fonts.ExtraSmall)
	if f9_arg0.displayMode == CoD.PlayerIdentity.Default then
		CoD.PlayerIdentity.UpdateDefault(f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4, f9_arg5)
	elseif f9_arg0.displayMode == CoD.PlayerIdentity.League then
		CoD.PlayerIdentity.UpdateLeague(f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4, f9_arg5)
	end
	if f9_arg0.joinableContainer ~= nil then
		if f9_arg4.status == nil or f9_arg4.status == "" then
			f9_arg0.joinableContainer:setAlpha(0)
		else
			f9_arg0.joinableContainer:setAlpha(1)
		end
		local f9_local0 = Engine.IsPlayerJoinable(f9_arg1, f9_arg4.xuid)
		local f9_local1 = CoD.fonts[CoD.PlayerIdentity.JoinableFontName]
		local f9_local2 = CoD.textSize[CoD.PlayerIdentity.JoinableFontName]
		local f9_local3 = ""
		if f9_arg4.status ~= nil then
			f9_local3 = f9_arg4.status
		end
		local f9_local4, f9_local5, f9_local6, f9_local7 = GetTextDimensions(f9_local3, f9_local1, f9_local2)
		local f9_local8 = f9_arg0.width < f9_local6
		if f9_local8 == true or f9_local0.isJoinable then
			f9_arg0.statusLabel:setTopBottom(true, false, 0, f9_local2)
		else
			f9_arg0.statusLabel:setTopBottom(false, false, -(f9_local2 / 2) - 3, f9_local2 / 2 - 3)
		end
		f9_arg0.statusLabel:setText(f9_local3)
		if f9_local8 == false and f9_local0.isJoinable then
			f9_arg0.joinableTextLabel:setText(Engine.Localize("MENU_JOINABLE"))
			f9_arg0.joinableIcon:setAlpha(1)
		else
			f9_arg0.joinableTextLabel:setText("")
			f9_arg0.joinableIcon:setAlpha(0)
		end
	end
end

