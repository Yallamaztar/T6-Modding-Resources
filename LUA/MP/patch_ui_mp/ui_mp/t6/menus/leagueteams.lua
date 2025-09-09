require("T6.CoD9Button")
if CoD.isZombie == false then
	require("T6.Menus.LeagueLeaderboard")
	require("T6.Menus.LeagueMemberList")
	require("T6.Menus.LeagueSeasonHistory")
end
CoD.LeagueTeams = {}
CoD.LeagueTeams.HintTextParams = {}
CoD.LeagueTeams.HintTextParams.hintTextLeft = 0
CoD.LeagueTeams.HintTextParams.hintTextWidth = 600
CoD.LeagueTeams.HintTextParams.hintTextTop = -5
CoD.LeagueTeams.OpenLeagueLeaderboard = function (f1_arg0, f1_arg1)
	CoD.LeaguesData.CurrentLeagueID = CoD.LeaguesData.CurrentTeamSubdivisionInfo.leagueID
	CoD.LeaguesData.numTeamMembersToShow = CoD.LeaguesData.CurrentTeamInfo.teamMemberInfo.numMembers
	f1_arg0:openMenu("LeagueLeaderboard", f1_arg1.controller)
	f1_arg0:close()
end

CoD.LeagueTeams.RemoveLeagueMembersButton = function (f2_arg0)
	if f2_arg0.leagueMembersButtonPrompt ~= nil then
		f2_arg0.leagueMembersButtonPrompt:close()
		f2_arg0.leagueMembersButtonPrompt = nil
	end
end

CoD.LeagueTeams.AddLeagueMembersButton = function (f3_arg0)
	if CoD.LeaguesData.CurrentTeamInfo.teamMemberInfo and CoD.LeaguesData.CurrentTeamInfo.teamMemberInfo.numMembers > 1 then
		local f3_local0 = CoD.ButtonPrompt.new
		local f3_local1 = "alt1"
		local f3_local2 = Engine.Localize("MENU_TEAMMATE_PLAYERCARD")
		local f3_local3 = f3_arg0
		local f3_local4 = "button_prompt_league_members"
		local f3_local5, f3_local6 = false
		local f3_local7, f3_local8 = false
		f3_arg0.leagueMembersButtonPrompt = f3_local0(f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6, f3_local7, f3_local8, "T")
		f3_arg0:addLeftButtonPrompt(f3_arg0.leagueMembersButtonPrompt)
	end
end

CoD.LeagueTeams.addSelectButtonWithLeagueMembers = function (f4_arg0)
	local f4_local0 = false
	if f4_arg0.leagueMembersButtonPrompt ~= nil then
		f4_local0 = true
		CoD.LeagueTeams.RemoveLeagueMembersButton(f4_arg0)
	end
	f4_arg0:addSelectButtonWithPrestigeUnlock()
	if f4_local0 == true then
		CoD.LeagueTeams.AddLeagueMembersButton(f4_arg0)
	end
end

LUI.createMenu.LeagueTeams = function (f5_arg0)
	local f5_local0 = CoD.Menu.New("LeagueTeams")
	f5_local0:addLargePopupBackground()
	f5_local0:setOwner(f5_arg0)
	f5_local0:setPreviousMenu("Barracks")
	f5_local0:addBackButton()
	CoD.LeagueTeams.AddLeagueMembersButton(f5_local0)
	f5_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_SOLO_HOMEPAGE")))
	if CoD.LeaguesData.CurrentTeamInfo.teamMemberInfo and CoD.LeaguesData.CurrentTeamInfo.teamMemberInfo.numMembers > 1 then
		f5_local0:setTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_TEAM_HOMEPAGE")))
	end
	f5_local0:registerEventHandler("open_league_leaderboard", CoD.LeagueTeams.OpenLeagueLeaderboard)
	f5_local0:registerEventHandler("button_prompt_league_members", CoD.LeagueTeams.OpenLeagueMemberList)
	f5_local0:registerEventHandler("open_team_identity", CoD.LeagueTeams.OpenTeamIdentity)
	f5_local0:registerEventHandler("open_season_history", CoD.LeagueTeams.OpenSeasonHistory)
	f5_local0:registerEventHandler("card_gain_focus", CoD.LeagueTeams.Menu_CardGainFocus)
	local f5_local1 = CoD.CardCarouselList.new(defaultAnimState, f5_arg0, CoD.Barracks.ItemWidth, CoD.Barracks.ItemHeight, CoD.Barracks.HighlightedItemWidth, CoD.Barracks.HighligtedItemHeight, CoD.LeagueTeams.HintTextParams)
	f5_local1:setLeftRight(true, true, 0, 0)
	f5_local1:setTopBottom(true, true, CoD.textSize.Big + 10, 0)
	f5_local0:addElement(f5_local1)
	f5_local1.popup = f5_local0
	if CoD.LeagueTeams.AddCarousels(f5_local1, f5_arg0) == "fetched" and CoD.LeagueTeams.CurrentCarouselInfo and CoD.LeagueTeams.CurrentCarouselInfo.carouselIndex then
		f5_local1:setInitialCarousel(CoD.LeagueTeams.CurrentCarouselInfo.carouselIndex, CoD.LeagueTeams.CurrentCarouselInfo.cardIndex)
	end
	f5_local1:focusCurrentCardCarousel(f5_arg0)
	CoD.LeagueTeams.SetupInfoArea(f5_local0, f5_arg0)
	return f5_local0
end

CoD.LeagueTeams.Menu_CardGainFocus = function (f6_arg0, f6_arg1)
	if f6_arg1.card ~= nil then
		if f6_arg0.leagueMembersButtonPrompt == nil then
			CoD.LeagueTeams.AddLeagueMembersButton(f6_arg0)
		end
		if f6_arg1.card.hasNoData == true then
			f6_arg0:removeSelectButton()
		else
			CoD.LeagueTeams.addSelectButtonWithLeagueMembers(f6_arg0)
		end
	end
end

CoD.LeagueTeams.OpenTeamIdentity = function (f7_arg0, f7_arg1)
	f7_arg0:openMenu("LeagueTeamNamePopup", f7_arg1.controller)
	f7_arg0:close()
end

CoD.LeagueTeams.OpenSeasonHistory = function (f8_arg0, f8_arg1)
	f8_arg0:openMenu("LeagueSeasonHistory", f8_arg1.controller)
	f8_arg0:close()
end

CoD.LeagueTeams.OpenLeagueMemberList = function (f9_arg0, f9_arg1)
	f9_arg0:openPopup("LeagueMemberList", f9_arg1.controller)
end

CoD.LeagueTeams.AddCarousels = function (f10_arg0, f10_arg1)
	return CoD.LeagueTeams.AddCarousel("", f10_arg0, f10_arg1)
end

CoD.LeagueTeams.CardButtonAction = function (f11_arg0, f11_arg1)
	CoD.LeaguesData.CurrentTeamSubdivisionInfo = f11_arg0.subdivisionInfo
	f11_arg0:dispatchEventToParent({
		name = "open_league_leaderboard",
		controller = f11_arg1.controller
	})
end

CoD.LeagueTeams.Card_GainFocus = function (f12_arg0, f12_arg1)
	f12_arg0.leagueIcon:setLeftRight(true, true, 0, -f12_arg0.iconWidth * f12_arg0.sizeMultiplier - f12_arg0.spacing * f12_arg0.sizeMultiplier)
	f12_arg0.divisionIcon:setLeftRight(true, true, f12_arg0.iconWidth * f12_arg0.sizeMultiplier + f12_arg0.spacing * f12_arg0.sizeMultiplier, 0)
	CoD.LeagueTeams.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo(f12_arg0)
	CoD.CardCarousel.Card_GainFocus(f12_arg0, f12_arg1)
end

CoD.LeagueTeams.Card_LoseFocus = function (f13_arg0, f13_arg1)
	f13_arg0.leagueIcon:setLeftRight(true, true, 0, -f13_arg0.iconWidth - f13_arg0.spacing)
	f13_arg0.divisionIcon:setLeftRight(true, true, f13_arg0.iconWidth + f13_arg0.spacing, 0)
	CoD.CardCarousel.Card_LoseFocus(f13_arg0, f13_arg1)
end

CoD.LeagueTeams.SetupLeagueCard = function (f14_arg0, f14_arg1)
	local f14_local0 = 64
	local f14_local1 = f14_local0
	local f14_local2 = 10
	local f14_local3 = 1.5
	local f14_local4 = ""
	if f14_arg1 and f14_arg1.leagueDesc then
		f14_local4 = f14_arg1.leagueDesc
	end
	CoD.Barracks.SetupCarouselCard(f14_arg0, f14_arg1.leagueDesc)
	f14_arg0:setupCenterImage(nil, f14_local1 * 2 + f14_local2, f14_local0, f14_local3)
	f14_arg0.spacing = f14_local2
	f14_arg0.iconWidth = f14_local1
	f14_arg0.iconHeight = f14_local0
	f14_arg0.sizeMultiplier = f14_local3
	f14_arg0.leagueIcon = LUI.UIImage.new()
	f14_arg0.leagueIcon:setLeftRight(true, true, 0, -f14_local1 - f14_local2)
	f14_arg0.leagueIcon:setTopBottom(true, true, 0, 0)
	f14_arg0.leagueIcon:setImage(RegisterMaterial(f14_arg1.leagueIconName .. "_64"))
	f14_arg0.divisionIcon = LUI.UIImage.new()
	f14_arg0.divisionIcon:setLeftRight(true, true, f14_local1 + f14_local2, 0)
	f14_arg0.divisionIcon:setTopBottom(true, true, 0, 0)
	f14_arg0.divisionIcon:setImage(f14_arg1.divisionIcon)
	f14_arg0.centerImageContainer.centerImage:close()
	f14_arg0.centerImageContainer:addElement(f14_arg0.leagueIcon)
	f14_arg0.centerImageContainer:addElement(f14_arg0.divisionIcon)
	local f14_local5 = 0
	local f14_local6 = 0
	f14_arg0.rankLabel = LUI.UIText.new()
	f14_arg0.rankLabel:setLeftRight(true, false, f14_local5, f14_local5 + 1)
	f14_arg0.rankLabel:setTopBottom(true, false, 10, 10 + CoD.textSize.Default)
	f14_arg0.rankLabel:setFont(CoD.fonts.Default)
	f14_arg0.rankLabel:setAlignment(LUI.Alignment.Left)
	f14_arg0.rankLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f14_arg0.rankLabel:setText("RANK")
	f14_local6 = f14_local6 + CoD.textSize.Default
	f14_arg0.rankText = LUI.UIText.new()
	f14_arg0.rankText:setLeftRight(true, false, f14_local5, f14_local5 + 1)
	f14_arg0.rankText:setTopBottom(true, false, f14_local6, f14_local6 + CoD.textSize.Big)
	f14_arg0.rankText:setFont(CoD.fonts.Big)
	f14_arg0.rankLabel:setAlignment(LUI.Alignment.Left)
	f14_arg0.rankText:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f14_arg0.rankText:setText("999")
end

CoD.LeagueTeams.SetupTeamIdentityCard = function (f15_arg0)
	if CoD.Barracks.ShowLeagueTeamsOnly then
		return 
	end
	local f15_local0 = CoD.LeaguesData.CurrentTeamInfo.teamID
	if CoD.LeaguesData.CurrentTeamInfo.teamMemberInfo and CoD.LeaguesData.CurrentTeamInfo.teamMemberInfo.numMembers > 1 then
		local f15_local1 = f15_arg0:addNewCard()
		CoD.Barracks.SetupCarouselCard(f15_local1, Engine.Localize("MENU_TEAMNAME_AND_EMBLEM"))
		f15_local1:setupCenterImage(nil, 100, 100, 1.5)
		f15_local1.centerImageContainer.centerImage:setupLeagueEmblem(f15_local0)
		f15_local1:setActionEventName("open_team_identity")
		f15_local1.hintText = Engine.Localize("MENU_CHOOSE_TEAM_NAME_TITLE")
	end
end

CoD.LeagueTeams.PopulateSeasonHistoryCard = function (f16_arg0, f16_arg1)
	local f16_local0 = Engine.GetLeagueSeasonHistory(f16_arg1.controller, CoD.LeaguesData.CurrentTeamInfo.teamID)
	if f16_arg0.spinner then
		f16_arg0.spinner:close()
	end
	if f16_arg0.centerImageContainer then
		f16_arg0.centerImageContainer:close()
		f16_arg0.centerImageContainer = nil
	end
	if not f16_local0 or f16_local0.numItems == 0 then
		f16_arg0:setupCenterImage("menu_theater_nodata", 100, 100, 1.5)
	else
		f16_arg0:setupCenterImage(nil, 100, 100, 1.5)
		f16_arg0.centerImageContainer.centerImage:setImage(f16_local0[1].divisionIcon)
		f16_arg0:setActionEventName("open_season_history")
		f16_arg0.hintText = Engine.Localize("LEAGUE_SEASON_HISTORY_HINT", f16_local0[1].divisionName)
	end
end

CoD.LeagueTeams.SetupSeasonHistoryCard = function (f17_arg0, f17_arg1)
	local f17_local0 = Engine.FetchLeagueSeasonHistory(f17_arg1, CoD.LeaguesData.CurrentTeamInfo.teamID)
	local f17_local1 = f17_arg0:addNewCard()
	CoD.Barracks.SetupCarouselCard(f17_local1, Engine.Localize("LEAGUE_SEASON_FINALS"))
	if f17_local0 then
		CoD.Barracks.SetupCardSpinner(f17_local1)
		f17_local1:registerEventHandler("league_season_history_fetched", CoD.LeagueTeams.PopulateSeasonHistoryCard)
	else
		CoD.LeagueTeams.PopulateSeasonHistoryCard(f17_local1, {
			controller = f17_arg1
		})
	end
end

CoD.LeagueTeams.SetupLeagueInfoCards = function (f18_arg0, f18_arg1)
	local f18_local0 = CoD.LeaguesData.TeamSubdivisionInfo.data
	local f18_local1 = CoD.LeaguesData.TeamSubdivisionInfo.fetchStatus
	local f18_local2 = CoD.LeaguesData.CurrentTeamInfo.teamID
	if f18_local2 ~= f18_arg1.teamID then
		return 
	end
	local f18_local3, f18_local4 = Engine.GetLeagueTeamSubdivisionInfos(f18_arg1.controller, f18_local2)
	f18_local0[f18_local2] = f18_local4
	f18_local1[f18_local2] = f18_local3
	f18_local3 = f18_local0[f18_local2]
	if f18_local3 and #f18_local3 > 0 and f18_arg1.success then
		f18_arg0:clearAllItems()
		for f18_local7, f18_local8 in ipairs(f18_local3) do
			local f18_local9 = f18_arg0:addNewCard()
			CoD.LeagueTeams.SetupLeagueCard(f18_local9, f18_local8)
			f18_local9.hintText = Engine.Localize("MENU_VIEW_LADDER_FOR_LEAGUE")
			f18_local9.subdivisionInfo = f18_local8
			f18_local9:registerEventHandler("button_action", CoD.LeagueTeams.CardButtonAction)
			f18_local9:registerEventHandler("gain_focus", CoD.LeagueTeams.Card_GainFocus)
			f18_local9:registerEventHandler("lose_focus", CoD.LeagueTeams.Card_LoseFocus)
		end
		CoD.LeagueTeams.SetupTeamIdentityCard(f18_arg0)
		f18_arg0.cardCarouselList:focusCurrentCardCarousel(f18_arg1.controller)
	else
		f18_arg0:dispatchEventToChildren({
			name = "no_data_available",
			controller = controller
		})
	end
end

CoD.LeagueTeams.CardButtonNoData = function (f19_arg0, f19_arg1)
	if f19_arg0.spinner then
		f19_arg0.spinner:close()
	end
	local f19_local0 = 100
	if f19_arg0.centerImageContainer then
		f19_arg0.centerImageContainer:close()
	end
	f19_arg0:setupCenterImage("menu_div_no_place", f19_local0, f19_local0, 1.5)
	f19_arg0.title:setText(Engine.Localize("MENU_AWAITING_PLACEMENT"))
	f19_arg0.hintText = Engine.Localize("MENU_VIEW_LADDER_AFTER_PLACEMENT")
	f19_arg0.noDataText = f19_arg0.title
	f19_arg0.hasNoData = true
end

CoD.LeagueTeams.AddCarousel = function (f20_arg0, f20_arg1, f20_arg2)
	local f20_local0 = f20_arg1:addCardCarousel(Engine.Localize(f20_arg0))
	local f20_local1 = CoD.LeaguesData.TeamSubdivisionInfo.data
	local f20_local2 = CoD.LeaguesData.TeamSubdivisionInfo.fetchStatus
	local f20_local3 = CoD.LeaguesData.CurrentTeamInfo.teamID
	local f20_local4 = f20_local2[f20_local3]
	local f20_local5 = f20_local4 == "fetched"
	local f20_local6 = f20_local4 == "fetching"
	local f20_local7 = f20_local4 == "fetching_failed"
	if f20_local5 then
		local f20_local8 = f20_local1[f20_local3]
		if f20_local8 and #f20_local8 > 0 then
			for f20_local12, f20_local13 in ipairs(f20_local8) do
				local f20_local14 = f20_local0:addNewCard()
				CoD.LeagueTeams.SetupLeagueCard(f20_local14, f20_local13)
				f20_local14.subdivisionInfo = f20_local13
				f20_local14.hintText = Engine.Localize("MENU_VIEW_LADDER_FOR_LEAGUE")
				f20_local14:registerEventHandler("button_action", CoD.LeagueTeams.CardButtonAction)
				f20_local14:registerEventHandler("gain_focus", CoD.LeagueTeams.Card_GainFocus)
				f20_local14:registerEventHandler("lose_focus", CoD.LeagueTeams.Card_LoseFocus)
				f20_local14.hasNoData = nil
			end
		else
			local f20_local9 = f20_local0:addNewCard()
			CoD.Barracks.SetupCarouselCard(f20_local9)
			f20_local9.hasNoData = true
			f20_local9:registerEventHandler("no_data_available", CoD.LeagueTeams.CardButtonNoData)
			f20_local9:processEvent({
				name = "no_data_available",
				controller = f20_arg2
			})
		end
	elseif f20_local6 then
		local f20_local8 = f20_local0:addNewCard()
		CoD.Barracks.SetupCarouselCard(f20_local8)
		f20_local8.hasNoData = true
		f20_local8:registerEventHandler("no_data_available", CoD.LeagueTeams.CardButtonNoData)
		CoD.Barracks.SetupCardSpinner(f20_local8)
	elseif f20_local7 then
		local f20_local8 = f20_local0:addNewCard()
		CoD.Barracks.SetupCarouselCard(f20_local8)
		f20_local8.hasNoData = true
		f20_local8:processEvent({
			name = "no_data_available",
			controller = f20_arg2
		})
	end
	CoD.LeagueTeams.SetupSeasonHistoryCard(f20_local0, f20_arg2)
	CoD.LeagueTeams.SetupTeamIdentityCard(f20_local0)
	f20_local0:registerEventHandler("league_team_subdivision_info_fetched", CoD.LeagueTeams.SetupLeagueInfoCards)
	return f20_local4
end

local f0_local0 = function (f21_arg0, f21_arg1, f21_arg2, f21_arg3)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, CoD.textSize[f21_arg0])
	Widget.text = LUI.UIText.new()
	Widget.text:setLeftRight(true, true, 0, 0)
	Widget.text:setTopBottom(true, true, 0, 0)
	Widget.text:setFont(CoD.fonts[f21_arg0])
	Widget.text:setText(f21_arg1)
	Widget.text:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	if f21_arg2 then
		Widget.text:setAlignment(LUI.Alignment[f21_arg2])
	end
	if f21_arg3 then
		Widget.text:setRGB(f21_arg3.r, f21_arg3.g, f21_arg3.b)
	end
	Widget:addElement(Widget.text)
	return Widget
end

local f0_local1 = function (f22_arg0)
	local f22_local0 = 64
	local f22_local1 = LUI.UIImage.new()
	f22_local1:setLeftRight(true, false, 0, f22_local0)
	f22_local1:setTopBottom(true, false, 0, f22_local0)
	f22_arg0:addElement(f22_local1)
	local f22_local2 = LUI.UIText.new()
	f22_local2:setLeftRight(true, true, f22_local0 + 5, 0)
	f22_local2:setTopBottom(true, false, 10, 10 + CoD.textSize.Default)
	f22_local2:setFont(CoD.fonts.Default)
	f22_local2:setText("MLG PRO RULES")
	f22_arg0:addElement(f22_local2)
	local f22_local3 = LUI.UIText.new()
	f22_local3:setLeftRight(true, true, f22_local0 + 5, 0)
	f22_local3:setTopBottom(true, false, 10 + CoD.textSize.Default, 10 + CoD.textSize.Default + CoD.textSize.Default)
	f22_local3:setFont(CoD.fonts.Default)
	f22_local3:setText("Season 1")
	f22_arg0:addElement(f22_local3)
end

local f0_local2 = function (f23_arg0, f23_arg1)
	local f23_local0 = f23_arg1
	local f23_local1 = LUI.UIImage.new()
	f23_local1:setLeftRight(true, false, 0, f23_local0)
	f23_local1:setTopBottom(true, false, 0, f23_local0)
	f23_arg0:addElement(f23_local1)
	local f23_local2 = LUI.UIText.new()
	f23_local2:setLeftRight(true, true, f23_local0 + 5, 0)
	f23_local2:setTopBottom(true, false, 10, 10 + CoD.textSize.Default)
	f23_local2:setFont(CoD.fonts.Default)
	f23_local2:setText("RANK")
	f23_arg0:addElement(f23_local2)
	local f23_local3 = LUI.UIText.new()
	f23_local3:setLeftRight(true, true, f23_local0 + 5, 0)
	f23_local3:setTopBottom(true, false, 10 + CoD.textSize.Default, 10 + CoD.textSize.Default + CoD.textSize.Big)
	f23_local3:setFont(CoD.fonts.Big)
	f23_local3:setText("999")
	f23_arg0:addElement(f23_local3)
end

CoD.LeagueTeams.SetupInfoArea = function (f24_arg0, f24_arg1)
	local f24_local0 = CoD.LeaguesData.CurrentTeamInfo.teamID
	local f24_local1 = CoD.LeaguesData.CurrentTeamInfo.teamName
	local f24_local2 = Engine.GetLeagueTeamMemberInfo(f24_arg1, f24_local0)
	local f24_local3 = Engine.GetCachedLeagueTeamInfo(f24_arg1, f24_local0)
	local f24_local4 = 250
	local f24_local5 = -50
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(false, true, -f24_local4 + f24_local5, f24_local5)
	local f24_local7 = 0
	local f24_local8 = f24_local4
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f24_local7, f24_local7 + f24_local8)
	Widget:setTopBottom(true, false, 0, f24_local8)
	local f24_local10 = CoD.GetCenteredImage(f24_local8 - 10, f24_local8 - 10)
	Widget:addElement(CoD.GetInformationContainer())
	Widget:addElement(f24_local10)
	f24_local10:setupLeagueEmblem(f24_local0)
	Widget:addElement(Widget)
	f24_local7 = f24_local7 + f24_local8 + 20
	local f24_local11 = 200
	local f24_local12 = LUI.UIVerticalList.new()
	f24_local12:setLeftRight(true, false, f24_local7, f24_local7 + f24_local11)
	f24_local12:setTopBottom(true, true, 0, 0)
	Widget:addElement(f24_local12)
	if f24_local1 then
		local f24_local13 = f0_local0("Big", f24_local1, "left")
		f24_local13:setLeftRight(true, false, 0, 300)
		f24_local12:addElement(f24_local13)
	end
	f24_local12:addSpacer(5)
	f24_local12:addElement(f0_local0("Default", UIExpression.ToUpper(nil, Engine.Localize("MENU_TEAM_MEMBERS")), "left", CoD.gray))
	f24_local12:addSpacer(5)
	if f24_local2 and f24_local2.members and #f24_local2.members > 0 then
		for f24_local16, f24_local17 in ipairs(f24_local2.members) do
			f24_local12:addElement(f0_local0("ExtraSmall", f24_local17.userName, "left"))
		end
	end
	f24_local12:addSpacer(5)
	if f24_local2 and f24_local2.members and #f24_local2.members > 1 and f24_local3 and f24_local3.timeEstablished then
		local f24_local13 = f0_local0("ExtraSmall", Engine.Localize("MENU_TEAM_EST_N", f24_local3.timeEstablished), "left")
		f24_local13:setLeftRight(true, false, f24_local7, f24_local7 + 500)
		f24_local13:setTopBottom(false, true, 20 - CoD.textSize.ExtraSmall, 20)
		Widget:addElement(f24_local13)
	end
	f24_local7 = f24_local7 + f24_local11 + 10
	local f24_local13 = LUI.UIVerticalList.new()
	local f24_local14 = 180
	local f24_local15 = 50
	f24_local13:setLeftRight(true, false, f24_local7, f24_local7 + f24_local14)
	f24_local13:setTopBottom(true, true, f24_local15, 0)
	f24_local13:addElement(f0_local0("Default", "CAREER VICTORIES"))
	f24_local13:addElement(f0_local0("Morris", "9999"))
	f24_local7 = f24_local7 + f24_local14 + 20
	local f24_local16 = LUI.UIVerticalList.new()
	local f24_local17 = 50
	f24_local16:setLeftRight(true, true, f24_local7, 0)
	f24_local16:setTopBottom(true, true, f24_local17, 0)
	f24_local16:addElement(f0_local0("Default", "BEST SEASON FINISH", "left"))
	local Widget = LUI.UIElement.new()
	local f24_local19 = 96
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, f24_local19)
	f0_local2(Widget, f24_local19)
	local Widget = LUI.UIElement.new()
	local f24_local21 = 96
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, f24_local21)
	f0_local1(Widget)
	f24_local16:addElement(Widget)
	f24_local16:addSpacer(10)
	f24_local16:addElement(Widget)
	f24_arg0:addElement(Widget)
end

