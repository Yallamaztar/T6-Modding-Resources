CoD.LeagueStats = {}
CoD.LeagueStats.width = 400
CoD.LeagueStats.height = 120
CoD.LeagueStats.textMargin = 70
CoD.LeagueStats.divisionImageSize = 128
local f0_local0 = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = f1_arg2
	local f1_local1 = not f1_local0
	local f1_local2 = 0
	local f1_local3 = 0
	local f1_local4 = CoD.textSize[f1_arg1]
	if f1_arg3 then
		f1_local2 = f1_arg0
		f1_local3 = f1_arg0 + f1_local4
	else
		f1_local2 = f1_arg0 - f1_local4
		f1_local3 = f1_arg0
	end
	return LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = CoD.LeagueStats.textMargin,
		right = 0,
		topAnchor = f1_local0,
		bottomAnchor = f1_local1,
		top = f1_local2,
		bottom = f1_local3,
		alignment = LUI.Alignment.Left,
		font = CoD.fonts[f1_arg1],
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b
	})
end

CoD.LeagueStats.InvalidTeamForLeague = function (f2_arg0, f2_arg1, f2_arg2)
	if f2_arg1 == nil then
		return "MENU_LEAGUE_FIND_MATCH_INVALID_DESC"
	elseif f2_arg2 == nil then
		return "MENU_LEAGUE_FIND_MATCH_INVALID_DESC"
	elseif not f2_arg2.valid then
		return "MENU_LEAGUE_FIND_MATCH_INVALID_DESC"
	elseif f2_arg2.random == true and f2_arg1.randomsAllowed ~= true then
		return "MENU_LEAGUE_FIND_MATCH_INVALID_SOLO_DESC"
	elseif f2_arg2.random == false and f2_arg1.teamsAllowed == false then
		return "MENU_LEAGUE_FIND_MATCH_INVALID_TEAM_DESC"
	elseif f2_arg2.random == false and f2_arg1.teamsAllowed == true and f2_arg2.memberCount ~= f2_arg1.teamSize then
		return "MENU_LEAGUE_FIND_MATCH_INVALID_TEAMSIZE_DESC"
	elseif Engine.IsPlaylistLocked(f2_arg0, Engine.GetPlaylistID()) then
		return Engine.GetLeagueLockedDescription(f2_arg0, Engine.GetPlaylistID())
	else
		return false
	end
end

CoD.LeagueStats.SeasonDateTick = function (f3_arg0, f3_arg1)
	if f3_arg0.seasonDate == nil then
		return 
	elseif f3_arg0.info == nil then
		f3_arg0.seasonDate:setText("")
	else
		f3_arg0.seasonDate:setText(Engine.GetLeagueSeasonDate(f3_arg0.info.id))
	end
end

CoD.LeagueStats.Update = function (f4_arg0, f4_arg1)
	f4_arg0.info = Engine.GetLeague()
	f4_arg0.stats = Engine.GetLeagueStats(f4_arg1.controller)
	if f4_arg0.info == nil or f4_arg0.stats == nil or f4_arg0.stats.valid == false then
		f4_arg0.teamName:setText("")
		f4_arg0.divisionImage:setImage(RegisterMaterial("menu_div_no_place"))
		f4_arg0.divisionImage:setAlpha(1)
		f4_arg0.spinner:setAlpha(1)
		f4_arg0.placementCount:setText("")
		f4_arg0.name:setText(Engine.Localize("LEAGUE_WORKING"))
		f4_arg0.rank:setText("")
		f4_arg0.seasonDate:setText("")
		f4_arg0.bonusPool:setText("")
		f4_arg0:animateToState("valid")
		if CoD.LeagueStats.InvalidTeamForLeague(f4_arg1.controller, f4_arg0.info, f4_arg0.stats) then
			return 
		end
	end
	if CoD.LeagueStats.InvalidTeamForLeague(f4_arg1.controller, f4_arg0.info, f4_arg0.stats) then
		f4_arg0:animateToState("invalid")
		return 
	end
	local f4_local0 = f4_arg0.info.placementGames
	local f4_local1 = f4_arg0.stats.rank
	local f4_local2 = f4_arg0.stats.played
	local f4_local3 = math.max(f4_arg0.info.bonusPool - f4_arg0.stats.bonusUsed, 0)
	local f4_local4 = f4_arg0.info.bonusDays
	local f4_local5 = f4_arg0.info.bonusCumulative
	if f4_local4 == nil then
		f4_local4 = 1
	end
	if f4_arg0.stats.random then
		f4_arg0.teamName:setText(Engine.Localize("LEAGUE_RANDOM_WITH_NAME", CoD.GMLOC_OFF .. f4_arg0.stats.teamName))
	elseif f4_arg0.stats.teamName ~= "" then
		f4_arg0.teamName:setText(Engine.Localize("LEAGUE_ARRANGED_WITH_NAME", CoD.GMLOC_OFF .. f4_arg0.stats.teamName))
	else
		f4_arg0.teamName:setText(Engine.Localize("LEAGUE_ARRANGED_UNNAMED"))
	end
	f4_arg0.divisionImage:setImage(f4_arg0.stats.divisionIcon)
	f4_arg0.divisionImage:setAlpha(1)
	f4_arg0.spinner:setAlpha(0)
	if f4_arg0.stats.isPreSeason then
		f4_arg0.placementCount:setText("")
		f4_arg0.name:setText(Engine.Localize("LEAGUE_PRACTICE"))
		f4_arg0.rank:setText(Engine.Localize("LEAGUE_PRESEASON"))
		f4_arg0.seasonDate:setText(f4_arg0.stats.seasonDate)
		f4_arg0.bonusPool:setText("")
		f4_arg0.seasonDate:setAlpha(1)
	else
		f4_arg0.seasonDate:setAlpha(0)
		if f4_arg0.stats.inPlacement then
			if f4_local2 < f4_local0 then
				f4_arg0.placementCount:setText(f4_local0 - f4_local2)
				f4_arg0.name:setText(Engine.Localize("LEAGUE_PLACEMENT_GAMES", f4_local0 - f4_local2))
				f4_arg0.rank:setText(Engine.Localize("LEAGUE_REQUIRED"))
			else
				f4_arg0.placementCount:setText("")
				f4_arg0.name:setText(Engine.Localize("LEAGUE_AWAITING_PLACEMENT"))
				f4_arg0.rank:setText("")
				f4_arg0.divisionImage:setAlpha(0)
			end
			f4_arg0.bonusPool:setText("")
		else
			f4_arg0.placementCount:setText("")
			f4_arg0.name:setText(UIExpression.ToUpper(nil, f4_arg0.stats.divisionName))
			f4_arg0.rank:setText(Engine.Localize("LEAGUE_RANK", f4_local1))
			local f4_local6 = "LEAGUE_BONUS_"
			if not f4_local5 then
				if f4_local4 == 7 then
					f4_local6 = "LEAGUE_WEEKLY_BONUS_"
				elseif f4_local4 == 1 then
					f4_local6 = "LEAGUE_DAILY_BONUS_"
				end
			end
			if f4_local3 > 0 or f4_local5 then
				f4_arg0.bonusPool:setText(Engine.Localize(f4_local6 .. "REMAINING", f4_local3))
				f4_arg0.bonusPool:setRGB(0.2, 0.6, 0.2)
			else
				f4_arg0.bonusPool:setText(Engine.Localize(f4_local6 .. "COMPLETE"))
				f4_arg0.bonusPool:setRGB(0.4, 0.4, 0.4)
			end
		end
	end
	f4_arg0:animateToState("valid")
end

CoD.LeagueStats.new = function (f5_arg0)
	local Widget = LUI.UIElement.new(f5_arg0)
	Widget:registerAnimationState("valid", {
		alpha = 1
	})
	Widget:registerAnimationState("invalid", {
		alpha = 0
	})
	local f5_local1 = CoD.textSize.Default * 5 + 100
	local f5_local2 = CoD.textSize.Default * 4
	local f5_local3 = CoD.LobbyPanes.VoipOffset
	Widget.backgroundContainer = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = CoD.LeagueStats.divisionImageSize / 2,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = CoD.textSize.Default + 2,
		bottom = CoD.LeagueStats.divisionImageSize - CoD.textSize.Default + 2
	})
	Widget:addElement(Widget.backgroundContainer)
	Widget.background = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		material = RegisterMaterial("menu_mp_map_frame")
	})
	Widget.backgroundContainer:addElement(Widget.background)
	Widget.divisionImageContainer = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = CoD.LeagueStats.divisionImageSize,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.LeagueStats.divisionImageSize
	})
	Widget:addElement(Widget.divisionImageContainer)
	Widget.divisionImage = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 1
	})
	Widget.divisionImageContainer:addElement(Widget.divisionImage)
	Widget.spinner = LUI.UIImage.new()
	Widget.spinner:setAlpha(0)
	Widget.spinner:setLeftRight(true, true, 24, -24)
	Widget.spinner:setTopBottom(true, true, 12, -36)
	Widget.spinner:setImage(RegisterMaterial("lui_loader"))
	Widget.divisionImageContainer:addElement(Widget.spinner)
	Widget.placementCount = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.textSize.Morris / 2 - 8,
		bottom = CoD.textSize.Morris / 2 - 8,
		alignment = LUI.Alignment.Center,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		font = CoD.fonts.Morris
	})
	Widget.divisionImageContainer:addElement(Widget.placementCount)
	Widget.teamName = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 50,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = -CoD.textSize.Default,
		bottom = 0,
		alignment = LUI.Alignment.Right,
		font = CoD.fonts.Default,
		red = CoD.gray.r,
		green = CoD.gray.g,
		blue = CoD.gray.b
	})
	Widget.backgroundContainer:addElement(Widget.teamName)
	Widget.name = f0_local0(0, "Condensed", true, true)
	Widget.backgroundContainer:addElement(Widget.name)
	Widget.rank = f0_local0(0, "Big", false, false)
	Widget.backgroundContainer:addElement(Widget.rank)
	Widget.bonusPool = f0_local0(0, "Default", false, true)
	Widget.backgroundContainer:addElement(Widget.bonusPool)
	Widget.bonusPool:setAlignment(LUI.Alignment.Right)
	Widget.seasonDate = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = 0,
		bottom = CoD.textSize.Default,
		alignment = LUI.Alignment.Right,
		font = CoD.fonts.Default,
		red = 0.4,
		green = 0.4,
		blue = 0.4
	})
	Widget.backgroundContainer:addElement(Widget.seasonDate)
	Widget.seasonDateTimer = LUI.UITimer.new(30000, "seasondate_tick", false)
	Widget:addElement(Widget.seasonDateTimer)
	Widget.update = CoD.LeagueStats.Update
	Widget:registerEventHandler("seasondate_tick", CoD.LeagueStats.SeasonDateTick)
	Widget:registerEventHandler("league_changed", CoD.LeagueStats.Update)
	return Widget
end

