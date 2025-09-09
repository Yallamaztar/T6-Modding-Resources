CoD.LeagueTeamNamePopup = {}
CoD.LeagueTeamNamePopup.ItemWidth = 192
CoD.LeagueTeamNamePopup.ItemHeight = 146
CoD.LeagueTeamNamePopup.HighlightedItemWidth = 345.6
CoD.LeagueTeamNamePopup.HighlightedItemHeight = 217.8
CoD.LeagueTeamNamePopup.HintTextParams = {
	hintTextLeft = 0,
	hintTextWidth = 300
}
LUI.createMenu.LeagueTeamNamePopup = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("LeagueTeamNamePopup")
	f1_local0:setPreviousMenu("LeagueTeams")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("open_keyboard", CoD.LeagueTeamNamePopup.OpenKeyboard)
	f1_local0:registerEventHandler("open_emblem_select", CoD.LeagueTeamNamePopup.OpenEmblemSelect)
	f1_local0:addTitle(Engine.Localize("MENU_TEAM_BARRACKS_CAPS"))
	CoD.LeagueTeamNamePopup.AddCarouselList(f1_local0, f1_arg0)
	return f1_local0
end

CoD.LeagueTeamNamePopup.AddCarouselList = function (f2_arg0, f2_arg1)
	local f2_local0 = CoD.CardCarouselList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.textSize.Big + 10,
		bottom = 0
	}, f2_arg1, CoD.LeagueTeamNamePopup.ItemWidth, CoD.LeagueTeamNamePopup.ItemHeight, CoD.LeagueTeamNamePopup.HighlightedItemWidth, CoD.LeagueTeamNamePopup.HighligtedItemHeight, CoD.LeagueTeamNamePopup.HintTextParams)
	f2_arg0:addElement(f2_local0)
	CoD.LeagueTeamNamePopup.AddCarousel(f2_local0, f2_arg1)
	f2_local0:focusCurrentCardCarousel(f2_arg1)
end

CoD.LeagueTeamNamePopup.SetupTeamEmblemCard = function (f3_arg0)
	local f3_local0 = f3_arg0:addNewCard()
	CoD.Barracks.SetupCarouselCard(f3_local0, Engine.Localize("MENU_TEAM_EMBLEM"))
	f3_local0.hintText = Engine.Localize("MENU_CHOOSE_TEAM_EMBLEM")
	local f3_local1 = 100
	f3_local0:setupCenterImage(nil, f3_local1, f3_local1, 1.8)
	f3_local0.centerImageContainer.centerImage:setupLeagueEmblem(CoD.LeaguesData.CurrentTeamInfo.teamID)
	f3_local0:setActionEventName("open_emblem_select")
end

CoD.LeagueTeamNamePopup.TeamNameButtonGainFocus = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.teamNameTextElem
	local f4_local1 = "Condensed"
	local f4_local2 = CoD.textSize[f4_local1]
	local f4_local3 = CoD.fonts[f4_local1]
	f4_local0:setTopBottom(false, false, -f4_local2 / 2, f4_local2 / 2)
	f4_local0:setFont(f4_local3)
	CoD.CardCarousel.Card_GainFocus(f4_arg0, f4_arg1)
end

CoD.LeagueTeamNamePopup.TeamNameButtonLoseFocus = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.teamNameTextElem
	local f5_local1 = "ExtraSmall"
	local f5_local2 = CoD.fonts[f5_local1]
	local f5_local3 = CoD.textSize[f5_local1]
	f5_local0:setTopBottom(false, false, -f5_local3 / 2, f5_local3 / 2)
	f5_local0:setFont(f5_local2)
	CoD.CardCarousel.Card_LoseFocus(f5_arg0, f5_arg1)
end

CoD.LeagueTeamNamePopup.SetupTeamNameCard = function (f6_arg0)
	local f6_local0 = f6_arg0:addNewCard()
	CoD.Barracks.SetupCarouselCard(f6_local0, Engine.Localize("MENU_TEAM_NAME"))
	local f6_local1 = Engine.Localize("MENU_CREATE_NAME")
	local f6_local2 = nil
	if CoD.LeaguesData.CurrentTeamInfo.teamName and CoD.LeaguesData.CurrentTeamInfo.teamName ~= "" then
		f6_local1 = CoD.LeaguesData.CurrentTeamInfo.teamName
		f6_local2 = CoD.yellowGlow
	end
	local f6_local3 = "ExtraSmall"
	local f6_local4 = CoD.textSize[f6_local3]
	local f6_local5 = CoD.fonts[f6_local3]
	local f6_local6 = LUI.UIText.new()
	f6_local6:setLeftRight(true, true, 0, 0)
	f6_local6:setTopBottom(false, false, -f6_local4 / 2, f6_local4 / 2)
	f6_local6:setFont(f6_local5)
	f6_local6:setAlignment(LUI.Alignment.Center)
	f6_local6:setText(f6_local1)
	if f6_local2 then
		f6_local6:setRGB(f6_local2.r, f6_local2.g, f6_local2.b)
	end
	f6_local0.teamNameTextElem = f6_local6
	f6_local0:setupCenterImage(nil, CoD.LeagueTeamNamePopup.ItemWidth - 20, 30, 1.8)
	f6_local0.centerImageContainer.centerImage:close()
	f6_local0.centerImageContainer:addElement(CoD.GetInformationContainer())
	f6_local0.centerImageContainer:addElement(f6_local6)
	f6_local0.hintText = Engine.Localize("MENU_CHOOSE_TEAM_NAME")
	f6_local0:setActionEventName("open_keyboard")
	f6_local0:registerEventHandler("league_teamname_entered", CoD.LeagueTeamNamePopup.UpdateTeamName)
	f6_local0:registerEventHandler("gain_focus", CoD.LeagueTeamNamePopup.TeamNameButtonGainFocus)
	f6_local0:registerEventHandler("lose_focus", CoD.LeagueTeamNamePopup.TeamNameButtonLoseFocus)
end

CoD.LeagueTeamNamePopup.AddCarousel = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg0:addCardCarousel("")
	CoD.LeagueTeamNamePopup.SetupTeamEmblemCard(f7_local0)
	CoD.LeagueTeamNamePopup.SetupTeamNameCard(f7_local0)
end

CoD.LeagueTeamNamePopup.UpdateTeamName = function (f8_arg0, f8_arg1)
	Engine.SetLeagueTeamName(f8_arg1.controller, f8_arg1.teamName, CoD.LeaguesData.CurrentTeamInfo.teamID)
	CoD.LeaguesData.CurrentTeamInfo.teamName = f8_arg1.teamName
	local f8_local0 = CoD.LeaguesData.teamsData
	if f8_local0 and #f8_local0 > 0 then
		for f8_local4, f8_local5 in ipairs(f8_local0) do
			if f8_local5.teamID == CoD.LeaguesData.CurrentTeamInfo.teamID then
				f8_local5.teamName = f8_arg1.teamName
			end
		end
	end
	f8_arg0.teamNameTextElem:setText(f8_arg1.teamName)
end

CoD.LeagueTeamNamePopup.OpenKeyboard = function (f9_arg0, f9_arg1)
	Engine.Exec(f9_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_LEAGUES)
end

CoD.LeagueTeamNamePopup.OpenEmblemSelect = function (f10_arg0, f10_arg1)
	CoD.perController[f10_arg1.controller].codtvRoot = "leagueidentity"
	f10_arg0:openMenu("CODTv", f10_arg1.controller)
	f10_arg0:close()
end

local f0_local0 = function (f11_arg0, f11_arg1)
	local f11_local0 = Engine.GetLeagueStats(controller)
	CoD.LeaguesData.CurrentTeamInfo.teamID = f11_local0.teamID
	CoD.LeaguesData.CurrentTeamInfo.teamName = f11_local0.teamName
	local f11_local1 = f11_arg0:openMenu("LeagueTeamNamePopup", f11_arg1.controller)
	f11_local1.previousMenuName = nil
	f11_arg0:close()
end

LUI.createMenu.EnterTeamNamePopup = function (f12_arg0)
	local f12_local0 = CoD.Popup.SetupPopupChoice("EnterTeamNamePopup", f12_arg0)
	f12_local0:addBackButton()
	f12_local0:registerEventHandler("open_teamname_menu", f0_local0)
	f12_local0.title:setText(Engine.Localize("MENU_NOTICE_CAPS"))
	f12_local0.msg:setText(Engine.Localize("MENU_ENTER_TEAMNAME_DESC"))
	f12_local0.choiceA:setLabel(Engine.Localize("MENU_CONTINUE"))
	f12_local0.choiceB:setLabel(Engine.Localize("MENU_CANCEL"))
	f12_local0.choiceA:setActionEventName("open_teamname_menu")
	f12_local0.choiceB:processEvent({
		name = "gain_focus"
	})
	return f12_local0
end

