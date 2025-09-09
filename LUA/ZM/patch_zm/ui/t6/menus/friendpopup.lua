if CoD.isMultiplayer and not CoD.isZombie then
	require("T6.PlayerIdentity")
	require("T6.Menus.MiniIdentity")
end
CoD.FriendPopup = {}
CoD.FriendPopup.SelectedPlayerXuid = nil
CoD.FriendPopup.SelectedPlayerName = nil
CoD.FriendPopup.SelectedPlayerRank = nil
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
		f4_arg0.openCombatRecord = true
		Engine.Exec(f4_arg1.controller, "getServiceRecord " .. f4_arg0.selectedPlayerXuid)
	end
end

CoD.FriendPopup.Button_LeagueTeams = function (f5_arg0, f5_arg1)
	if f5_arg0.selectedPlayerXuid ~= nil then
		CoD.Barracks.CurrentLeaguePlayerXuid = f5_arg0.selectedPlayerXuid
		CoD.Barracks.ShowLeagueTeamsOnly = true
		CoD.Barracks.LeagueTeamsDataFetched = false
		f5_arg0:openPopup("Barracks", f5_arg1.controller)
	end
end

CoD.FriendPopup.StatsDownloaded = function (f6_arg0, f6_arg1)
	if f6_arg0.selectedPlayerXuid ~= nil and f6_arg0.openCombatRecord == true then
		f6_arg0.openCombatRecord = nil
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

CoD.FriendPopup.LikeEmblem = function (f13_arg0, f13_arg1)
	if f13_arg0.m_emblemFileID ~= nil and f13_arg0.m_emblemFileID ~= "0" then
		CoD.perController[f13_arg1.controller].voteData = {
			fileID = f13_arg0.m_emblemFileID,
			category = "emblem",
			selectedPlayerXuid = f13_arg0.selectedPlayerXuid,
			fromLobby = true
		}
		CoD.perController[f13_arg1.controller].voteUpdateTarget = f13_arg0
		local f13_local0 = f13_arg0:openPopup("FileshareVote", f13_arg1.controller)
	end
end

LUI.createMenu.FriendPopup = function (f14_arg0, f14_arg1)
	local f14_local0 = CoD.Menu.NewMediumPopup("FriendPopup")
	f14_local0:registerEventHandler("closeallpopups", CoD.FriendPopup.Close)
	f14_local0.m_ownerController = f14_arg0
	f14_local0.selectedPlayerXuid = CoD.FriendPopup.SelectedPlayerXuid
	f14_local0.selectedPlayerName = CoD.FriendPopup.SelectedPlayerName
	f14_local0.LeagueMemberSelected = CoD.FriendPopup.LeagueMemberSelected
	CoD.FriendPopup.LeagueMemberSelected = false
	f14_local0.LeagueLeaderboardMemberSelected = CoD.FriendPopup.LeagueLeaderboardMemberSelected
	f14_local0.selectedPlayerRank = nil
	if CoD.FriendPopup.SelectedPlayerRank ~= "" and CoD.FriendPopup.SelectedPlayerRank ~= nil then
		f14_local0.selectedPlayerRank = tonumber(CoD.FriendPopup.SelectedPlayerRank)
	end
	CoD.FriendPopup.SelectedPlayerRank = nil
	local f14_local1
	if UIExpression.IsInGame() == 1 then
		f14_local1 = CoD.isPC
		if not f14_local1 then
			f14_local1 = CoD.isWIIU
		end
	else
		f14_local1 = false
	end
	local f14_local2 = CoD.FriendPopup.SelectedPlayerXuid
	local f14_local3 = nil
	local f14_local4 = Engine.IsGuestByXuid(f14_local2)
	f14_local0:addSelectButton()
	f14_local0:addBackButton()
	f14_local0:addTitle("")
	if CoD.isZombie == true then
		CoD.FriendPopup.AddOverviewInfo_Zombie(f14_local0)
	else
		CoD.FriendPopup.AddOverviewInfo_Multiplayer(f14_local0)
	end
	local f14_local5 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = CoD.ButtonList.DefaultWidth,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.textSize.Big + 10,
		bottom = 0
	})
	local f14_local6 = UIExpression.IsFriendFromXUID(f14_arg0, f14_local2) == 1
	local f14_local7 = UIExpression.IsFriendFromXUID(f14_arg0, f14_local2) == 1
	local f14_local8 = UIExpression.GetXUID(f14_arg0) == f14_local0.selectedPlayerXuid
	if CoD.FriendsListPopup.Mode ~= CoD.playerListType.leaderboard then
		if CoD.canSendFriendRequest(f14_arg0, f14_local0.selectedPlayerXuid) then
			f14_local0.sendFriendRequestButton = f14_local5:addButton(Engine.Localize("MENU_SEND_FRIEND_REQUEST_CAPS"))
			f14_local0.sendFriendRequestButton:setActionEventName("send_friend_request")
			f14_local0:registerEventHandler("send_friend_request", CoD.FriendPopup.sendFriendRequestButtonAction)
		end
		if f14_local0.selectedPlayerXuid ~= nil and CoD.canInviteToGame(f14_arg0, f14_local0.selectedPlayerXuid) then
			local f14_local9 = Engine.PartyGetPlayerCount() >= Dvar.party_maxplayers:get()
			local f14_local10
			if CoD.isZombie then
				if not Engine.IsInGame() then
					f14_local10 = not f14_local9
				else
					f14_local10 = false
				end
			else
				f14_local10 = true
			end
			if f14_local10 == true then
				f14_local0.inviteButton = f14_local5:addButton(Engine.Localize("MENU_INVITE_TO_GAME_CAPS"))
				f14_local0.inviteButton:setActionEventName("friend_invite")
				f14_local0:registerEventHandler("friend_invite", CoD.FriendPopup.Button_Invite)
			end
		end
		if f14_local0.selectedPlayerXuid ~= nil and CoD.canJoinSession(f14_arg0, f14_local0.selectedPlayerXuid) then
			local f14_local11
			if CoD.isZombie then
				f14_local11 = not Engine.IsInGame()
			else
				f14_local11 = true
			end
			if f14_local11 == true then
				f14_local0.joinButton = f14_local5:addButton(Engine.Localize("MENU_JOIN_IN_PROGRESS_CAPS"))
				f14_local0.joinButton:setActionEventName("friend_join")
				f14_local0:registerEventHandler("friend_join", CoD.FriendPopup.Button_Join)
			end
		end
	end
	if not CoD.isWIIU and not f14_local4 then
		f14_local0.gamercardButton = f14_local5:addButton(Engine.Localize("XBOXLIVE_VIEW_PROFILE_CAPS"))
		f14_local0.gamercardButton:setActionEventName("friend_viewgamercard")
		f14_local0:registerEventHandler("friend_viewgamercard", CoD.FriendPopup.Button_Gamercard)
	end
	if not f14_local4 and not Engine.IsInGame() and not CoD.isZombie and not f14_local0.LeagueMemberSelected then
		local f14_local11 = UIExpression.GetRankByXUID(f14_arg0, f14_local0.selectedPlayerXuid)
		local f14_local12 = UIExpression.GetPrestigeByXUID(f14_arg0, f14_local0.selectedPlayerXuid)
		local f14_local9 = UIExpression.GetItemUnlockLevel(f14_arg0, UIExpression.GetItemIndex(f14_arg0, "FEATURE_COMBAT_RECORD"))
		if f14_local0.selectedPlayerRank and f14_local11 < f14_local0.selectedPlayerRank then
			f14_local11 = f14_local0.selectedPlayerRank
		end
		f14_local0.combatRecordButton = f14_local5:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_VIEW_COMBAT_RECORD")))
		f14_local0.combatRecordButton:setActionEventName("friend_viewcombatrecord")
		f14_local0:registerEventHandler("friend_viewcombatrecord", CoD.FriendPopup.Button_CombatRecord)
		f14_local0:registerEventHandler("service_record_fetched", CoD.FriendPopup.StatsDownloaded)
		if f14_local12 == 0 and f14_local11 < f14_local9 then
			f14_local0.combatRecordButton:disable()
		end
	end
	if not f14_local4 and not Engine.IsInGame() and not CoD.isZombie and not f14_local0.LeagueMemberSelected and not f14_local0.LeagueLeaderboardMemberSelected then
		f14_local0.viewLeagueTeamsButton = f14_local5:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_VIEW_LEAGUE_TEAMS")))
		f14_local0.viewLeagueTeamsButton:setActionEventName("friend_viewleagueteams")
		f14_local0:registerEventHandler("friend_viewleagueteams", CoD.FriendPopup.Button_LeagueTeams)
	end
	if not Engine.IsInGame() and not f14_local1 and not f14_local4 and not CoD.isSinglePlayer and not f14_local0.LeagueMemberSelected then
		f14_local0.showRecentGamesButton = f14_local5:addButton(Engine.Localize("MENU_PLAYER_CHANNEL"))
		f14_local0.showRecentGamesButton:setActionEventName("friend_viewrecentgames")
		f14_local0:registerEventHandler("friend_viewrecentgames", CoD.FriendPopup.Button_RecentGames)
	end
	if CoD.FriendsListPopup.Mode ~= CoD.playerListType.leaderboard then
		if CoD.canMutePlayer(f14_arg0, f14_local0.selectedPlayerXuid) and not f14_local0.LeagueMemberSelected then
			if CoD.isPlayerMuted(f14_arg0, f14_local0.selectedPlayerXuid) then
				f14_local0.muteButton = f14_local5:addButton(Engine.Localize("MENU_UNMUTE_CAPS"))
			else
				f14_local0.muteButton = f14_local5:addButton(Engine.Localize("MENU_MUTE_CAPS"))
			end
			f14_local0.muteButton:setActionEventName("friend_muteButtonAction")
			f14_local0:registerEventHandler("friend_muteButtonAction", CoD.FriendPopup.MuteButtonAction)
		end
		if not f14_local1 and CoD.canKickPlayer(f14_arg0, f14_local0.selectedPlayerXuid) and not f14_local0.LeagueMemberSelected then
			f14_local0.kickPlayerButton = f14_local5:addButton(Engine.Localize("MENU_KICK_PLAYER_CAPS"))
			f14_local0.kickPlayerButton:setActionEventName("player_kick")
			f14_local0:registerEventHandler("player_kick", CoD.FriendPopup.Button_KickPlayer)
		end
	end
	if UIExpression.GetXUID(f14_arg0) ~= f14_local2 then
		f14_local0.reportPlayerButton = f14_local5:addButton(Engine.Localize("MENU_REPORT_USER_CAPS"))
		f14_local0.reportPlayerButton:setActionEventName("player_report")
		f14_local0:registerEventHandler("player_report", CoD.FriendPopup.Button_ReportPlayer)
	end
	f14_local0:registerEventHandler("emblem_like", CoD.FriendPopup.LikeEmblem)
	f14_local0:addElement(f14_local5)
	f14_local5:processEvent({
		name = "gain_focus"
	})
	Engine.PlaySound("cac_loadout_edit_sel")
	return f14_local0
end

CoD.FriendPopup.AddOverviewInfo_Multiplayer = function (f15_arg0)
	if f15_arg0.selectedPlayerXuid == nil then
		return 
	end
	local f15_local0 = Engine.GetPlayerInfoByXuid(f15_arg0.m_ownerController, f15_arg0.selectedPlayerXuid)
	local f15_local1 = f15_arg0.selectedPlayerName
	if f15_local0.name == nil then
		f15_local1 = f15_local0.name
	end
	f15_arg0.titleElement:setText(Engine.Localize("MENU_N_PLAYERCARD_CAPS", f15_local1))
	if not CoD.isSinglePlayer then
		local f15_local2 = 320
		local f15_local3 = 10
		local f15_local4, f15_local5 = CoD.PlayerIdentity.New({
			leftAnchor = false,
			rightAnchor = true,
			left = -f15_local3 - f15_local2,
			right = -f15_local3,
			topAnchor = true,
			bottomAnchor = true,
			top = CoD.textSize.Big,
			bottom = 0
		}, f15_local2, CoD.PlayerIdentity.Default, true)
		f15_local4:update(f15_arg0.m_ownerController, true, f15_arg0.selectedPlayerXuid, f15_local0, nil)
		f15_arg0:addElement(f15_local4)
		CoD.perController[f15_arg0.m_ownerController].emblemFileID = nil
		if f15_local0.emblemFileID ~= nil and f15_local0.emblemFileID ~= "0" then
			CoD.perController[f15_arg0.m_ownerController].emblemFileID = f15_local0.emblemFileID
		end
		Engine.Exec(f15_arg0.m_ownerController, "vote_getHistory")
	end
end

CoD.FriendPopup.UpdateOverviewInfo_Zombie = function (f16_arg0)
	local f16_local0 = Engine.GetPlayerInfoByXuid(f16_arg0.m_ownerController, f16_arg0.selectedPlayerXuid)
	if f16_local0.status ~= nil then
		f16_arg0.status:setText(f16_local0.status)
	end
	local f16_local1 = f16_arg0.selectedPlayerName
	if f16_local0.name == nil then
		f16_local1 = f16_local0.name
	end
	local f16_local2 = ""
	if f16_local0.clanTag ~= nil then
		f16_local2 = CoD.getClanTag(f16_local0.clanTag)
	end
	f16_arg0.backingGamerTag:setText(f16_local2 .. f16_local1)
	local f16_local3 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f16_local0.rank - 1, 3)
	if f16_local0.daysPlayedInLast5Days == 5 then
		f16_local3 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f16_local0.rank - 1, 4)
	end
	local f16_local4 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f16_local0.rank - 1, f16_local0.daysPlayedInLast5Days + 5)
	f16_arg0.updateBackOff = f16_arg0.updateBackOff * 3
	f16_arg0:addElement(LUI.UITimer.new(f16_arg0.updateBackOff, "update_friendpopup", true, f16_arg0))
	if f16_local3 == f16_arg0.emblemImage and f16_local4 == f16_arg0.rankImage then
		return 
	elseif f16_local3 ~= "" and f16_local3 ~= f16_arg0.emblemImage then
		if f16_arg0.emblemOverLay == nil then
			f16_arg0.emblemOverLay = LUI.UIImage.new({
				leftAnchor = true,
				rightAnchor = true,
				left = 0,
				right = 0,
				topAnchor = true,
				bottomAnchor = true,
				top = 0,
				bottom = 0,
				alpha = 0,
				material = RegisterMaterial(f16_local3)
			})
			f16_arg0.emblemOverLay:registerAnimationState("fade_emblem", {
				alpha = 1
			})
			f16_arg0.emblemContainer:addElement(f16_arg0.emblemOverLay)
			f16_arg0.emblemContainer:removeElement(f16_arg0.rankIconContainer)
			f16_arg0.emblemContainer:addElement(f16_arg0.rankIconContainer)
			f16_arg0.emblemOverLay:animateToState("fade_emblem", 500)
			f16_arg0.emblem:animateToState("fade_out", 500)
		elseif f16_local3 ~= "" then
			f16_arg0.emblemOverLay:setImage(RegisterMaterial(f16_local3))
		end
	end
	if f16_local4 ~= "" then
		f16_arg0.rankIcon:setImage(RegisterMaterial(f16_local4))
		f16_arg0.rankIcon:animateToState("fade_in", 1000)
	end
	f16_arg0.emblemImage = f16_local3
	f16_arg0.rankImage = f16_local4
end

CoD.FriendPopup.AddOverviewInfo_Zombie = function (f17_arg0)
	if f17_arg0.selectedPlayerXuid == nil then
		return 
	end
	local f17_local0 = Engine.GetPlayerInfoByXuid(f17_arg0.m_ownerController, f17_arg0.selectedPlayerXuid)
	local f17_local1 = 25
	f17_arg0.overviewContainer = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = true,
		left = -250 - f17_local1,
		right = -f17_local1,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	f17_arg0:addElement(f17_arg0.overviewContainer)
	local f17_local2 = 200
	local f17_local3 = 200
	local f17_local4 = 25
	local f17_local5 = 0.25
	local f17_local6 = f17_local2 + 50
	local f17_local7 = f17_local6 * f17_local5
	if not CoD.isSinglePlayer then
		f17_arg0.emblemContainer = LUI.UIElement.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -f17_local2 / 2,
			right = f17_local2 / 2,
			topAnchor = true,
			bottomAnchor = false,
			top = f17_local4,
			bottom = f17_local4 + f17_local3
		})
		f17_arg0.overviewContainer:addElement(f17_arg0.emblemContainer)
		f17_arg0.emblemImage = "menu_zm_rank_1"
		f17_arg0.emblem = LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0
		})
		f17_arg0.emblem:setImage(RegisterMaterial(f17_arg0.emblemImage))
		f17_arg0.emblem:registerAnimationState("fade_out", {
			alpha = 0
		})
		f17_arg0.emblemContainer:addElement(f17_arg0.emblem)
		f17_arg0.rankImage = "hud_chalk_0"
		local f17_local8 = RegisterMaterial("menu_zm_gamertag")
		f17_arg0.backingContainer = LUI.UIElement.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -f17_local6 / 2,
			right = f17_local6 / 2,
			topAnchor = true,
			bottomAnchor = false,
			top = f17_local4 + f17_local3,
			bottom = f17_local4 + f17_local3 + f17_local7
		})
		f17_arg0.overviewContainer:addElement(f17_arg0.backingContainer)
		f17_arg0.backing = LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0,
			material = f17_local8,
			alpha = 1
		})
		f17_arg0.backingContainer:addElement(f17_arg0.backing)
		f17_arg0.backingGamerTag = LUI.UIText.new()
		f17_arg0.backingGamerTag:setLeftRight(true, true, 0, 0)
		f17_arg0.backingGamerTag:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
		f17_arg0.backingGamerTag:setRGB(1, 1, 1)
		f17_arg0.backingContainer:addElement(f17_arg0.backingGamerTag)
	end
	local f17_local8 = CoD.textSize.Default
	local f17_local9 = f17_arg0.selectedPlayerName
	if f17_local0.name == nil then
		f17_local9 = f17_local0.name
	end
	f17_arg0.titleElement:setText(Engine.Localize("MENU_N_PLAYERCARD_CAPS", f17_local9))
	local f17_local10 = ""
	if f17_local0.clanTag ~= nil then
		f17_local10 = CoD.getClanTag(f17_local0.clanTag)
	end
	f17_arg0.backingGamerTag:setText(f17_local10 .. f17_local9)
	local f17_local11 = 20
	f17_arg0.status = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f17_local6 / 2,
		right = f17_local6 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f17_local4 + f17_local3 + f17_local7 + f17_local11,
		bottom = f17_local4 + f17_local3 + f17_local7 + f17_local11 + f17_local8,
		alignment = LUI.Alignment.Center
	})
	local f17_local12 = ""
	if f17_local0.status ~= nil then
		f17_local12 = f17_local0.status
	end
	f17_arg0.status:setText(f17_local12)
	f17_arg0.overviewContainer:addElement(f17_arg0.status)
	local f17_local13 = f17_local2 / 4
	f17_arg0.rankIconContainer = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f17_local13,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = f17_local13
	})
	f17_arg0.emblemContainer:addElement(f17_arg0.rankIconContainer)
	f17_arg0.rankIcon = LUI.UIStreamedImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 0
	})
	f17_arg0.rankIcon:registerAnimationState("fade_in", {
		alpha = 1
	})
	f17_arg0.rankIconContainer:addElement(f17_arg0.rankIcon)
	if CoD.FriendPopup.ShowMPRank(f17_local0) then
		local f17_local14 = f17_local0.rankImage
		if f17_local14 == nil then
			f17_local14 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f17_local0.rank - 1, 0) .. "_128"
		end
		f17_arg0.rankImage = f17_local14
		f17_arg0.rankIcon:setImage(RegisterMaterial(f17_local14))
		f17_arg0.rankIcon:setAlpha(1)
		f17_arg0.rankIconContainer:addElement(f17_arg0.rankIcon)
		local f17_local15 = f17_local8
		local f17_local16 = f17_local15
		f17_arg0.rankContainer = LUI.UIElement.new({
			leftAnchor = false,
			rightAnchor = true,
			left = -f17_local16,
			right = 0,
			topAnchor = false,
			bottomAnchor = true,
			top = -f17_local15,
			bottom = 0
		})
		f17_arg0.rankIconContainer:addElement(f17_arg0.rankContainer)
		f17_arg0.rank = LUI.UIText.new({
			leftAnchor = false,
			rightAnchor = true,
			left = -f17_local16,
			right = 0,
			topAnchor = false,
			bottomAnchor = true,
			top = -f17_local15,
			bottom = 0,
			red = 1,
			green = 1,
			blue = 1,
			alpha = 1
		})
		f17_arg0.rank:setText("")
		local f17_local17 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f17_local0.rank - 1, 3)
		if f17_local0.daysPlayedInLast5Days == 5 then
			f17_local17 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f17_local0.rank - 1, 4)
		end
		f17_arg0.emblem:setImage(RegisterMaterial(f17_local17))
		f17_arg0.emblemImage = f17_local17
		local f17_local18 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f17_local0.rank - 1, f17_local0.daysPlayedInLast5Days + 5)
		f17_arg0.rankIcon:setImage(RegisterMaterial(f17_local18))
		f17_arg0.rankImage = f17_local18
		f17_arg0.rankContainer:addElement(f17_arg0.rank)
	end
	f17_arg0.updateBackOff = 500
	f17_arg0:addElement(LUI.UITimer.new(f17_arg0.updateBackOff, "update_friendpopup", true, f17_arg0))
	f17_arg0:registerEventHandler("update_friendpopup", CoD.FriendPopup.UpdateOverviewInfo_Zombie)
end

CoD.FriendPopup.ShowMPRank = function (f18_arg0)
	local f18_local0
	if CoD.isSinglePlayer or f18_arg0 == nil or f18_arg0.rank == nil or tonumber(f18_arg0.rank) <= 0 or Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) ~= false then
		f18_local0 = false
	else
		f18_local0 = true
	end
	return f18_local0
end

LUI.createMenu.popup_reportuser = function (f19_arg0)
	local f19_local0 = CoD.ReportPlayer.SetupPopupChoice("popup_reportuser", f19_arg0)
	f19_local0.title:setText(Engine.Localize("MENU_REPORT_USER_CAPS"))
	f19_local0.msg:setText(CoD.FriendPopup.SelectedPlayerName)
	if CoD.isZombie == false then
		f19_local0.choiceA:setLabel(Engine.Localize("MENU_REPORT_USER_OFFENSIVE_CAPS"))
		f19_local0.choiceA.hintText = Engine.Localize("MENU_REPORT_USER_OFFENSIVE_MSG")
		f19_local0.choiceB:setLabel(Engine.Localize("MENU_REPORT_USER_OFFENSIVE_EMBLEM_CAPS"))
		f19_local0.choiceB.hintText = Engine.Localize("MENU_REPORT_USER_OFFENSIVE_EMBLEM_MSG")
		f19_local0.choiceC:setLabel(Engine.Localize("MENU_REPORT_USER_CHEATER_CAPS"))
		f19_local0.choiceC.hintText = Engine.Localize("MENU_REPORT_USER_CHEATER_MSG")
		f19_local0.choiceD:setLabel(Engine.Localize("MENU_REPORT_USER_BOOSTER_CAPS"))
		f19_local0.choiceD.hintText = Engine.Localize("MENU_REPORT_USER_BOOSTER_MSG")
		f19_local0.choiceA:setActionEventName("report_user_offensive")
		f19_local0.choiceB:setActionEventName("report_user_offensive_emblem")
		f19_local0.choiceC:setActionEventName("report_user_cheater")
		f19_local0.choiceD:setActionEventName("report_user_booster")
	else
		f19_local0.choiceA:setLabel(Engine.Localize("MENU_REPORT_USER_OFFENSIVE_CAPS"))
		f19_local0.choiceA.hintText = Engine.Localize("MENU_REPORT_USER_OFFENSIVE_MSG")
		f19_local0.choiceB:setLabel(Engine.Localize("MENU_REPORT_USER_CHEATER_CAPS"))
		f19_local0.choiceB.hintText = Engine.Localize("MENU_REPORT_USER_CHEATER_MSG")
		f19_local0.choiceA:setActionEventName("report_user_offensive")
		f19_local0.choiceB:setActionEventName("report_user_cheater")
	end
	f19_local0.choiceA:processEvent({
		name = "gain_focus"
	})
	f19_local0:registerEventHandler("report_user_offensive", CoD.ReportPlayer.ReportUserOffensive)
	f19_local0:registerEventHandler("report_user_offensive_emblem", CoD.ReportPlayer.ReportUserOffensiveEmblem)
	f19_local0:registerEventHandler("report_user_cheater", CoD.ReportPlayer.ReportUserCheater)
	f19_local0:registerEventHandler("report_user_booster", CoD.ReportPlayer.ReportUserBooster)
	f19_local0:addBackButton()
	return f19_local0
end

CoD.ReportPlayer.ReportUserOffensive = function (f20_arg0, f20_arg1)
	if CoD.isZombie == false then
		Engine.ExecNow(f20_arg1.controller, "reportUser " .. CoD.FriendPopup.SelectedPlayerXuid .. " offensive 1 1")
	else
		Engine.ExecNow(f20_arg1.controller, "reportUser " .. CoD.FriendPopup.SelectedPlayerXuid .. " zombie_offensive 1 1")
	end
	f20_arg0:goBack(f20_arg1.controller)
end

CoD.ReportPlayer.ReportUserOffensiveEmblem = function (f21_arg0, f21_arg1)
	Engine.ExecNow(f21_arg1.controller, "reportUser " .. CoD.FriendPopup.SelectedPlayerXuid .. " offensive_emblem 1 1")
	if CoD.perController[f21_arg1.controller].emblemFileID ~= nil then
		Engine.RecordOffensiveEmblem(f21_arg1.controller, CoD.FriendPopup.SelectedPlayerXuid, CoD.perController[f21_arg1.controller].emblemFileID)
	end
	f21_arg0:goBack(f21_arg1.controller)
end

CoD.ReportPlayer.ReportUserCheater = function (f22_arg0, f22_arg1)
	if CoD.isZombie == false then
		Engine.ExecNow(f22_arg1.controller, "reportUser " .. CoD.FriendPopup.SelectedPlayerXuid .. " cheater 1 1")
	else
		Engine.ExecNow(f22_arg1.controller, "reportUser " .. CoD.FriendPopup.SelectedPlayerXuid .. " zombie_cheater 1 1")
	end
	f22_arg0:goBack(f22_arg1.controller)
end

CoD.ReportPlayer.ReportUserBooster = function (f23_arg0, f23_arg1)
	Engine.ExecNow(f23_arg1.controller, "reportUser " .. CoD.FriendPopup.SelectedPlayerXuid .. " booster 1 1")
	f23_arg0:goBack(f23_arg1.controller)
end

CoD.ReportPlayer.SetupPopupChoice = function (f24_arg0, f24_arg1)
	local f24_local0 = CoD.Popup.SetupPopup(f24_arg0, f24_arg1, CoD.Popup.Type.STRETCHED)
	f24_local0:setWidthHeight(nil, CoD.Popup.StretchedHeight + CoD.MPZM(60, 0))
	f24_local0.choiceList = CoD.ButtonList.new()
	f24_local0.choiceList:setLeftRight(true, true, 0, 0)
	f24_local0.choiceList:setTopBottom(false, true, CoD.MPZM(-200, -140), 0)
	f24_local0:addElement(f24_local0.choiceList)
	for f24_local1 = 1, CoD.MPZM(4, 2), 1 do
		local f24_local4 = f24_local0.choiceList:addButton("")
		f24_local4:setActionEventName("button_prompt_back")
		f24_local4:setFont(CoD.fonts.Default)
		f24_local0.choiceList:addElement(f24_local4)
		if f24_local1 == 1 then
			f24_local0.choiceA = f24_local4
		end
		if f24_local1 == 2 then
			f24_local0.choiceB = f24_local4
		end
		if f24_local1 == 3 then
			f24_local0.choiceC = f24_local4
		end
		if f24_local1 == 4 then
			f24_local0.choiceD = f24_local4
		end
	end
	f24_local0:addSelectButton()
	return f24_local0
end

