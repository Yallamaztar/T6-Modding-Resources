if CoD.isMultiplayer and not CoD.isZombie then
	require("T6.PlayerIdentity")
	require("T6.Menus.MiniIdentity")
end
CoD.FriendPopup = {}
CoD.FriendPopup.SelectedPlayerXuid = nil
CoD.FriendPopup.SelectedPlayerName = nil
CoD.ReportPlayer = {}
CoD.FriendPopup.Button_Invite = function (f1_arg0, f1_arg1)
	if f1_arg0.selectedPlayerXuid ~= nil then
		CoD.invitePlayer(f1_arg1.controller, f1_arg0.selectedPlayerXuid, CoD.FriendsListPopup.Mode)
	end
end

CoD.FriendPopup.Button_Join = function (f2_arg0, f2_arg1)
	if f2_arg0.selectedPlayerXuid ~= nil then
		CoD.joinPlayer(f2_arg1.controller, f2_arg0.selectedPlayerXuid)
		f2_arg0:processEvent({
			name = "closeallpopups",
			controller = f2_arg1.controller
		})
	end
end

CoD.FriendPopup.Button_Gamercard = function (f3_arg0, f3_arg1)
	if f3_arg0.selectedPlayerXuid ~= nil and f3_arg0.selectedPlayerName ~= nil then
		CoD.viewGamerCard(f3_arg1.controller, f3_arg0.selectedPlayerName, f3_arg0.selectedPlayerXuid, CoD.playerListType.party)
	end
end

CoD.FriendPopup.Button_CombatRecord = function (f4_arg0, f4_arg1)
	if f4_arg0.selectedPlayerXuid ~= nil then
		Engine.Exec(f4_arg1.controller, "getServiceRecord " .. f4_arg0.selectedPlayerXuid)
	end
end

CoD.FriendPopup.Button_LeagueTeams = function (f5_arg0, f5_arg1)
	if f5_arg0.selectedPlayerXuid ~= nil then
		CoD.Barracks.CurrentLeaguePlayerXuid = f5_arg0.selectedPlayerXuid
		CoD.Barracks.ShowLeagueTeamsOnly = true
		f5_arg0:openPopup("Barracks", f5_arg1.controller)
	end
end

CoD.FriendPopup.StatsDownloaded = function (f6_arg0, f6_arg1)
	if f6_arg0.selectedPlayerXuid ~= nil then
		CoD.CRCommon.OtherPlayerCRMode = true
		CoD.CRCommon.CurrentXuid = f6_arg0.selectedPlayerXuid
		f6_arg0:openPopup("Barracks", f6_arg1.controller)
	end
end

CoD.FriendPopup.Button_RecentGames = function (f7_arg0, f7_arg1)
	if Engine.CanViewContent() == false then
		f7_arg0:openPopup("popup_contentrestricted", f7_arg1.controller)
		return 
	elseif f7_arg0.selectedPlayerXuid ~= nil and f7_arg0.selectedPlayerName ~= nil then
		CoD.perController[f7_arg1.controller].codtvRoot = "playerchannel"
		CoD.perController[f7_arg1.controller].playerChannelXuid = f7_arg0.selectedPlayerXuid
		f7_arg0:openPopup("CODTv", f7_arg1.controller)
	end
end

CoD.FriendPopup.Close = function (f8_arg0, f8_arg1)
	if f8_arg0.m_inputDisabled == nil then
		f8_arg0:goBack(f8_arg1.controller)
		if f8_arg0.occludedMenu ~= nil then
			f8_arg0.occludedMenu:processEvent({
				name = "closeallpopups",
				controller = f8_arg1.controller
			})
		end
	end
end

CoD.FriendPopup.MuteButtonAction = function (f9_arg0, f9_arg1)
	if CoD.isPlayerMuted(controller, f9_arg0.selectedPlayerXuid) then
		f9_arg1.button:setLabel(Engine.Localize("MENU_MUTE_CAPS"))
	else
		f9_arg1.button:setLabel(Engine.Localize("MENU_UNMUTE_CAPS"))
	end
	CoD.CoD9Button.GainFocus(f9_arg1.button, {})
	Engine.Exec(f9_arg1.controller, "party_toggleMute " .. f9_arg0.selectedPlayerXuid)
end

CoD.FriendPopup.sendFriendRequestButtonAction = function (f10_arg0, f10_arg1)
	if CoD.isWIIU then
		f10_arg0:goBack(f10_arg1.controller)
	end
	CoD.sendFriendRequest(f10_arg1.controller, f10_arg0.selectedPlayerXuid)
end

CoD.FriendPopup.Button_KickPlayer = function (f11_arg0, f11_arg1)
	f11_arg0:openPopup("KickPlayerPopup", f11_arg1.controller)
end

CoD.FriendPopup.Button_ReportPlayer = function (f12_arg0, f12_arg1)
	f12_arg0:openPopup("popup_reportuser", f12_arg1.controller)
end

LUI.createMenu.FriendPopup = function (f13_arg0, f13_arg1)
	local f13_local0 = CoD.Menu.NewMediumPopup("FriendPopup")
	f13_local0:registerEventHandler("closeallpopups", CoD.FriendPopup.Close)
	f13_local0.m_ownerController = f13_arg0
	f13_local0.selectedPlayerXuid = CoD.FriendPopup.SelectedPlayerXuid
	f13_local0.selectedPlayerName = CoD.FriendPopup.SelectedPlayerName
	f13_local0.LeagueMemberSelected = CoD.FriendPopup.LeagueMemberSelected
	CoD.FriendPopup.LeagueMemberSelected = false
	local f13_local1
	if UIExpression.IsInGame() == 1 then
		f13_local1 = CoD.isPC
		if not f13_local1 then
			f13_local1 = CoD.isWIIU
		end
	else
		f13_local1 = false
	end
	local f13_local2 = CoD.FriendPopup.SelectedPlayerXuid
	local f13_local3 = nil
	local f13_local4 = Engine.IsGuestByXuid(f13_local2)
	f13_local0:addSelectButton()
	f13_local0:addBackButton()
	f13_local0:addTitle("")
	if CoD.isZombie == true then
		CoD.FriendPopup.AddOverviewInfo_Zombie(f13_local0)
	else
		CoD.FriendPopup.AddOverviewInfo_Multiplayer(f13_local0)
	end
	local f13_local5 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = CoD.ButtonList.DefaultWidth,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.textSize.Big + 10,
		bottom = 0
	})
	local f13_local6 = UIExpression.IsFriendFromXUID(f13_arg0, f13_local2) == 1
	local f13_local7 = UIExpression.IsFriendFromXUID(f13_arg0, f13_local2) == 1
	local f13_local8 = UIExpression.GetXUID(f13_arg0) == f13_local0.selectedPlayerXuid
	if CoD.FriendsListPopup.Mode ~= CoD.playerListType.leaderboard then
		if CoD.canSendFriendRequest(f13_arg0, f13_local0.selectedPlayerXuid) then
			f13_local0.sendFriendRequestButton = f13_local5:addButton(Engine.Localize("MENU_SEND_FRIEND_REQUEST_CAPS"))
			f13_local0.sendFriendRequestButton:setActionEventName("send_friend_request")
			f13_local0:registerEventHandler("send_friend_request", CoD.FriendPopup.sendFriendRequestButtonAction)
		end
		if f13_local0.selectedPlayerXuid ~= nil and CoD.canInviteToGame(f13_arg0, f13_local0.selectedPlayerXuid) then
			local f13_local9
			if CoD.isZombie then
				f13_local9 = not Engine.IsInGame()
			else
				f13_local9 = true
			end
			if f13_local9 == true then
				f13_local0.inviteButton = f13_local5:addButton(Engine.Localize("MENU_INVITE_TO_GAME_CAPS"))
				f13_local0.inviteButton:setActionEventName("friend_invite")
				f13_local0:registerEventHandler("friend_invite", CoD.FriendPopup.Button_Invite)
			end
		end
		if f13_local0.selectedPlayerXuid ~= nil and CoD.canJoinSession(f13_arg0, f13_local0.selectedPlayerXuid) then
			local f13_local9
			if CoD.isZombie then
				f13_local9 = not Engine.IsInGame()
			else
				f13_local9 = true
			end
			if f13_local9 == true then
				f13_local0.joinButton = f13_local5:addButton(Engine.Localize("MENU_JOIN_IN_PROGRESS_CAPS"))
				f13_local0.joinButton:setActionEventName("friend_join")
				f13_local0:registerEventHandler("friend_join", CoD.FriendPopup.Button_Join)
			end
		end
	end
	if not CoD.isWIIU and not f13_local4 then
		f13_local0.gamercardButton = f13_local5:addButton(Engine.Localize("XBOXLIVE_VIEW_PROFILE_CAPS"))
		f13_local0.gamercardButton:setActionEventName("friend_viewgamercard")
		f13_local0:registerEventHandler("friend_viewgamercard", CoD.FriendPopup.Button_Gamercard)
	end
	if not f13_local4 and not Engine.IsInGame() and not CoD.isZombie and not f13_local0.LeagueMemberSelected then
		local f13_local9 = UIExpression.GetRankByXUID(f13_arg0, f13_local0.selectedPlayerXuid)
		local f13_local10 = UIExpression.GetPrestigeByXUID(f13_arg0, f13_local0.selectedPlayerXuid)
		local f13_local11 = UIExpression.GetItemUnlockLevel(f13_arg0, UIExpression.GetItemIndex(f13_arg0, "FEATURE_COMBAT_RECORD"))
		f13_local0.combatRecordButton = f13_local5:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_VIEW_COMBAT_RECORD")))
		f13_local0.combatRecordButton:setActionEventName("friend_viewcombatrecord")
		f13_local0:registerEventHandler("friend_viewcombatrecord", CoD.FriendPopup.Button_CombatRecord)
		f13_local0:registerEventHandler("service_record_fetched", CoD.FriendPopup.StatsDownloaded)
		if f13_local10 == 0 and f13_local9 < f13_local11 then
			f13_local0.combatRecordButton:disable()
		end
	end
	if not f13_local4 and not Engine.IsInGame() and not CoD.isZombie and not f13_local0.LeagueMemberSelected then
		f13_local0.viewLeagueTeamsButton = f13_local5:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_VIEW_LEAGUE_TEAMS")))
		f13_local0.viewLeagueTeamsButton:setActionEventName("friend_viewleagueteams")
		f13_local0:registerEventHandler("friend_viewleagueteams", CoD.FriendPopup.Button_LeagueTeams)
	end
	if not Engine.IsInGame() and not f13_local1 and not f13_local4 and not CoD.isSinglePlayer and not f13_local0.LeagueMemberSelected then
		f13_local0.showRecentGamesButton = f13_local5:addButton(Engine.Localize("MENU_PLAYER_CHANNEL"))
		f13_local0.showRecentGamesButton:setActionEventName("friend_viewrecentgames")
		f13_local0:registerEventHandler("friend_viewrecentgames", CoD.FriendPopup.Button_RecentGames)
	end
	if CoD.FriendsListPopup.Mode ~= CoD.playerListType.leaderboard then
		if CoD.canMutePlayer(f13_arg0, f13_local0.selectedPlayerXuid) and not f13_local0.LeagueMemberSelected then
			if CoD.isPlayerMuted(f13_arg0, f13_local0.selectedPlayerXuid) then
				f13_local0.muteButton = f13_local5:addButton(Engine.Localize("MENU_UNMUTE_CAPS"))
			else
				f13_local0.muteButton = f13_local5:addButton(Engine.Localize("MENU_MUTE_CAPS"))
			end
			f13_local0.muteButton:setActionEventName("friend_muteButtonAction")
			f13_local0:registerEventHandler("friend_muteButtonAction", CoD.FriendPopup.MuteButtonAction)
		end
		if not f13_local1 and CoD.canKickPlayer(f13_arg0, f13_local0.selectedPlayerXuid) and not f13_local0.LeagueMemberSelected then
			f13_local0.kickPlayerButton = f13_local5:addButton(Engine.Localize("MENU_KICK_PLAYER_CAPS"))
			f13_local0.kickPlayerButton:setActionEventName("player_kick")
			f13_local0:registerEventHandler("player_kick", CoD.FriendPopup.Button_KickPlayer)
		end
	end
	if UIExpression.GetXUID(f13_arg0) ~= f13_local2 then
		f13_local0.reportPlayerButton = f13_local5:addButton(Engine.Localize("MENU_REPORT_USER_CAPS"))
		f13_local0.reportPlayerButton:setActionEventName("player_report")
		f13_local0:registerEventHandler("player_report", CoD.FriendPopup.Button_ReportPlayer)
	end
	f13_local0:addElement(f13_local5)
	f13_local5:processEvent({
		name = "gain_focus"
	})
	Engine.PlaySound("cac_loadout_edit_sel")
	return f13_local0
end

CoD.FriendPopup.AddOverviewInfo_Multiplayer = function (f14_arg0)
	if f14_arg0.selectedPlayerXuid == nil then
		return 
	end
	local f14_local0 = Engine.GetPlayerInfoByXuid(f14_arg0.m_ownerController, f14_arg0.selectedPlayerXuid)
	local f14_local1 = f14_arg0.selectedPlayerName
	if f14_local0.name == nil then
		f14_local1 = f14_local0.name
	end
	f14_arg0.titleElement:setText(Engine.Localize("MENU_N_PLAYERCARD_CAPS", f14_local1))
	if not CoD.isSinglePlayer then
		local f14_local2 = 320
		local f14_local3 = 10
		local f14_local4, f14_local5 = CoD.PlayerIdentity.New({
			leftAnchor = false,
			rightAnchor = true,
			left = -f14_local3 - f14_local2,
			right = -f14_local3,
			topAnchor = true,
			bottomAnchor = true,
			top = CoD.textSize.Big,
			bottom = 0
		}, f14_local2, CoD.PlayerIdentity.Default, true)
		f14_local4:update(f14_arg0.m_ownerController, true, f14_arg0.selectedPlayerXuid, f14_local0, nil)
		f14_arg0:addElement(f14_local4)
	end
end

CoD.FriendPopup.AddOverviewInfo_Zombie = function (f15_arg0)
	if f15_arg0.selectedPlayerXuid == nil then
		return 
	end
	local f15_local0 = Engine.GetPlayerInfoByXuid(f15_arg0.m_ownerController, f15_arg0.selectedPlayerXuid)
	local f15_local1 = 25
	f15_arg0.overviewContainer = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = true,
		left = -250 - f15_local1,
		right = -f15_local1,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	f15_arg0:addElement(f15_arg0.overviewContainer)
	local f15_local2 = 200
	local f15_local3 = 200
	local f15_local4 = 25
	local f15_local5 = 0.25
	local f15_local6 = f15_local2 + 50
	local f15_local7 = f15_local6 * f15_local5
	if not CoD.isSinglePlayer then
		f15_arg0.emblemContainer = LUI.UIElement.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -f15_local2 / 2,
			right = f15_local2 / 2,
			topAnchor = true,
			bottomAnchor = false,
			top = f15_local4,
			bottom = f15_local4 + f15_local3
		})
		f15_arg0.overviewContainer:addElement(f15_arg0.emblemContainer)
		f15_arg0.emblem = LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0
		})
		f15_arg0.emblem:setImage(RegisterMaterial("menu_zm_rank_1"))
		f15_arg0.emblemContainer:addElement(f15_arg0.emblem)
		local f15_local8 = RegisterMaterial("menu_zm_gamertag")
		f15_arg0.backingContainer = LUI.UIElement.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -f15_local6 / 2,
			right = f15_local6 / 2,
			topAnchor = true,
			bottomAnchor = false,
			top = f15_local4 + f15_local3,
			bottom = f15_local4 + f15_local3 + f15_local7
		})
		f15_arg0.overviewContainer:addElement(f15_arg0.backingContainer)
		f15_arg0.backing = LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0,
			material = f15_local8,
			alpha = 1
		})
		f15_arg0.backingContainer:addElement(f15_arg0.backing)
		f15_arg0.backingGamerTag = LUI.UIText.new()
		f15_arg0.backingGamerTag:setLeftRight(true, true, 0, 0)
		f15_arg0.backingGamerTag:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
		f15_arg0.backingGamerTag:setRGB(1, 1, 1)
		f15_arg0.backingContainer:addElement(f15_arg0.backingGamerTag)
	end
	local f15_local8 = CoD.textSize.Default
	local f15_local9 = f15_arg0.selectedPlayerName
	if f15_local0.name == nil then
		f15_local9 = f15_local0.name
	end
	f15_arg0.titleElement:setText(Engine.Localize("MENU_N_PLAYERCARD_CAPS", f15_local9))
	local f15_local10 = ""
	if f15_local0.clanTag ~= nil then
		f15_local10 = CoD.getClanTag(f15_local0.clanTag)
	end
	f15_arg0.backingGamerTag:setText(f15_local10 .. f15_local9)
	local f15_local11 = 20
	f15_arg0.status = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f15_local6 / 2,
		right = f15_local6 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f15_local4 + f15_local3 + f15_local7 + f15_local11,
		bottom = f15_local4 + f15_local3 + f15_local7 + f15_local11 + f15_local8,
		alignment = LUI.Alignment.Center
	})
	local f15_local12 = ""
	if f15_local0.status ~= nil then
		f15_local12 = f15_local0.status
	end
	f15_arg0.status:setText(f15_local12)
	f15_arg0.overviewContainer:addElement(f15_arg0.status)
	if CoD.FriendPopup.ShowMPRank(f15_local0) then
		local f15_local13 = f15_local0.rankImage
		if f15_local13 == nil then
			f15_local13 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f15_local0.rank - 1, 0) .. "_128"
		end
		local f15_local14 = f15_local2 / 4
		f15_arg0.rankIconContainer = LUI.UIElement.new({
			leftAnchor = true,
			rightAnchor = false,
			left = 0,
			right = f15_local14,
			topAnchor = true,
			bottomAnchor = false,
			top = 0,
			bottom = f15_local14
		})
		f15_arg0.emblemContainer:addElement(f15_arg0.rankIconContainer)
		f15_arg0.rankIcon = LUI.UIStreamedImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0,
			alpha = 1,
			material = RegisterMaterial(f15_local13)
		})
		f15_arg0.rankIconContainer:addElement(f15_arg0.rankIcon)
		local f15_local15 = f15_local8
		local f15_local16 = f15_local15
		f15_arg0.rankContainer = LUI.UIElement.new({
			leftAnchor = false,
			rightAnchor = true,
			left = -f15_local16,
			right = 0,
			topAnchor = false,
			bottomAnchor = true,
			top = -f15_local15,
			bottom = 0
		})
		f15_arg0.rankIconContainer:addElement(f15_arg0.rankContainer)
		f15_arg0.rank = LUI.UIText.new({
			leftAnchor = false,
			rightAnchor = true,
			left = -f15_local16,
			right = 0,
			topAnchor = false,
			bottomAnchor = true,
			top = -f15_local15,
			bottom = 0,
			red = 1,
			green = 1,
			blue = 1,
			alpha = 1
		})
		f15_arg0.rank:setText("")
		local f15_local17 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f15_local0.rank - 1, 3)
		if f15_local0.daysPlayedInLast5Days == 5 then
			f15_local17 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f15_local0.rank - 1, 4)
		end
		f15_arg0.emblem:setImage(RegisterMaterial(f15_local17))
		f15_arg0.rankIcon:setImage(RegisterMaterial(UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f15_local0.rank - 1, f15_local0.daysPlayedInLast5Days + 5)))
		f15_arg0.rankContainer:addElement(f15_arg0.rank)
	end
end

CoD.FriendPopup.ShowMPRank = function (f16_arg0)
	local f16_local0
	if CoD.isSinglePlayer or f16_arg0 == nil or f16_arg0.rank == nil or tonumber(f16_arg0.rank) <= 0 or Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) ~= false then
		f16_local0 = false
	else
		f16_local0 = true
	end
	return f16_local0
end

LUI.createMenu.popup_reportuser = function (f17_arg0)
	local f17_local0 = CoD.ReportPlayer.SetupPopupChoice("popup_reportuser", f17_arg0)
	f17_local0.title:setText(Engine.Localize("MENU_REPORT_USER_CAPS"))
	f17_local0.msg:setText(CoD.FriendPopup.SelectedPlayerName)
	if CoD.isZombie == false then
		f17_local0.choiceA:setLabel(Engine.Localize("MENU_REPORT_USER_OFFENSIVE_CAPS"))
		f17_local0.choiceA.hintText = Engine.Localize("MENU_REPORT_USER_OFFENSIVE_MSG")
		f17_local0.choiceB:setLabel(Engine.Localize("MENU_REPORT_USER_OFFENSIVE_EMBLEM_CAPS"))
		f17_local0.choiceB.hintText = Engine.Localize("MENU_REPORT_USER_OFFENSIVE_EMBLEM_MSG")
		f17_local0.choiceC:setLabel(Engine.Localize("MENU_REPORT_USER_CHEATER_CAPS"))
		f17_local0.choiceC.hintText = Engine.Localize("MENU_REPORT_USER_CHEATER_MSG")
		f17_local0.choiceD:setLabel(Engine.Localize("MENU_REPORT_USER_BOOSTER_CAPS"))
		f17_local0.choiceD.hintText = Engine.Localize("MENU_REPORT_USER_BOOSTER_MSG")
		f17_local0.choiceA:setActionEventName("report_user_offensive")
		f17_local0.choiceB:setActionEventName("report_user_offensive_emblem")
		f17_local0.choiceC:setActionEventName("report_user_cheater")
		f17_local0.choiceD:setActionEventName("report_user_booster")
	else
		f17_local0.choiceA:setLabel(Engine.Localize("MENU_REPORT_USER_OFFENSIVE_CAPS"))
		f17_local0.choiceA.hintText = Engine.Localize("MENU_REPORT_USER_OFFENSIVE_MSG")
		f17_local0.choiceB:setLabel(Engine.Localize("MENU_REPORT_USER_CHEATER_CAPS"))
		f17_local0.choiceB.hintText = Engine.Localize("MENU_REPORT_USER_CHEATER_MSG")
		f17_local0.choiceA:setActionEventName("report_user_offensive")
		f17_local0.choiceB:setActionEventName("report_user_cheater")
	end
	f17_local0.choiceA:processEvent({
		name = "gain_focus"
	})
	f17_local0:registerEventHandler("report_user_offensive", CoD.ReportPlayer.ReportUserOffensive)
	f17_local0:registerEventHandler("report_user_offensive_emblem", CoD.ReportPlayer.ReportUserOffensiveEmblem)
	f17_local0:registerEventHandler("report_user_cheater", CoD.ReportPlayer.ReportUserCheater)
	f17_local0:registerEventHandler("report_user_booster", CoD.ReportPlayer.ReportUserBooster)
	f17_local0:addBackButton()
	return f17_local0
end

CoD.ReportPlayer.ReportUserOffensive = function (f18_arg0, f18_arg1)
	if CoD.isZombie == false then
		Engine.ExecNow(f18_arg1.controller, "reportUser " .. CoD.FriendPopup.SelectedPlayerXuid .. " offensive 1 1")
	else
		Engine.ExecNow(f18_arg1.controller, "reportUser " .. CoD.FriendPopup.SelectedPlayerXuid .. " zombie_offensive 1 1")
	end
	f18_arg0:goBack(f18_arg1.controller)
end

CoD.ReportPlayer.ReportUserOffensiveEmblem = function (f19_arg0, f19_arg1)
	Engine.ExecNow(f19_arg1.controller, "reportUser " .. CoD.FriendPopup.SelectedPlayerXuid .. " offensive_emblem 1 1")
	f19_arg0:goBack(f19_arg1.controller)
end

CoD.ReportPlayer.ReportUserCheater = function (f20_arg0, f20_arg1)
	if CoD.isZombie == false then
		Engine.ExecNow(f20_arg1.controller, "reportUser " .. CoD.FriendPopup.SelectedPlayerXuid .. " cheater 1 1")
	else
		Engine.ExecNow(f20_arg1.controller, "reportUser " .. CoD.FriendPopup.SelectedPlayerXuid .. " zombie_cheater 1 1")
	end
	f20_arg0:goBack(f20_arg1.controller)
end

CoD.ReportPlayer.ReportUserBooster = function (f21_arg0, f21_arg1)
	Engine.ExecNow(f21_arg1.controller, "reportUser " .. CoD.FriendPopup.SelectedPlayerXuid .. " booster 1 1")
	f21_arg0:goBack(f21_arg1.controller)
end

CoD.ReportPlayer.SetupPopupChoice = function (f22_arg0, f22_arg1)
	local f22_local0 = CoD.Popup.SetupPopup(f22_arg0, f22_arg1, CoD.Popup.Type.STRETCHED)
	f22_local0:setWidthHeight(nil, CoD.Popup.StretchedHeight + CoD.MPZM(60, 0))
	f22_local0.choiceList = CoD.ButtonList.new()
	f22_local0.choiceList:setLeftRight(true, true, 0, 0)
	f22_local0.choiceList:setTopBottom(false, true, CoD.MPZM(-200, -140), 0)
	f22_local0:addElement(f22_local0.choiceList)
	for f22_local1 = 1, CoD.MPZM(4, 2), 1 do
		local f22_local4 = f22_local0.choiceList:addButton("")
		f22_local4:setActionEventName("button_prompt_back")
		f22_local4:setFont(CoD.fonts.Default)
		f22_local0.choiceList:addElement(f22_local4)
		if f22_local1 == 1 then
			f22_local0.choiceA = f22_local4
		end
		if f22_local1 == 2 then
			f22_local0.choiceB = f22_local4
		end
		if f22_local1 == 3 then
			f22_local0.choiceC = f22_local4
		end
		if f22_local1 == 4 then
			f22_local0.choiceD = f22_local4
		end
	end
	f22_local0:addSelectButton()
	return f22_local0
end

