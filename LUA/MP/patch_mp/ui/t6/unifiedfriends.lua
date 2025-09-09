require("T6.MFTabManager")
require("T6.ListBox")
require("T6.Menus.FriendPopup")
require("T6.Menus.KickPlayerPopup")
if not CoD.isSinglePlayer then
	require("T6.FriendDetails")
end
if CoD.isWIIU or CoD.isPC then
	require("T6.Menus.GameInvitePopup")
end
if CoD.isWIIU or LUI.roots.UIRootDrc ~= nil then
	require("T6.Menus.TextMessage")
end
CoD.FriendsList = {}
CoD.FriendsListPopup = {}
CoD.FriendsListPopup.Mode = CoD.playerListType.friend
CoD.FriendsListPopup.EmblemHeight = CoD.CoD9Button.Height - 5
CoD.FriendsList.CloseMenu = function (f1_arg0, f1_arg1)
	local f1_local0 = LUI.roots.UIRootDrc
	if not f1_arg1.fromDrc and f1_local0 and f1_local0.friendsButton and f1_local0.friendsButton.down then
		f1_local0:processEvent({
			name = "press_view_panel_button",
			buttonName = "friends"
		})
	else
		Dvar.ui_friendsListOpen:set(false)
		Dvar.ui_playerListOpen:set(false)
		if CoD.isXBOX then
			Dvar.ui_xboxLivePartyListOpen:set(false)
		end
		if UIExpression.IsInGame() == 1 then
			f1_arg0:goBack(f1_arg1.controller)
		else
			f1_arg0:animateOutAndGoBack(f1_arg1.controller)
		end
		if CoD.isWIIU then
			local f1_local1 = LUI.roots["UIRoot" .. f1_arg1.controller]
			if f1_local1 then
				f1_local1.friendsMenu = nil
			end
		end
	end
end

CoD.FriendsListPopup.FriendSelected = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.listBox:getFocussedMutables()
	if f2_local0 ~= nil then
		CoD.FriendPopup.SelectedPlayerXuid = f2_local0.playerXuid
		CoD.FriendPopup.SelectedPlayerName = f2_local0.playerName
		Dvar.selectedPlayerXuid:set(f2_local0.playerXuid)
		if CoD.FriendsListPopup.Mode == CoD.playerListType.gameInvites then
			CoD.GameInvitePopup.SelectedPlayerXuid = f2_local0.playerXuid
			CoD.GameInvitePopup.SelectedPlayerName = f2_local0.playerName
			f2_arg0:openPopup("GameInvitePopup", f2_arg1.controller)
		elseif CoD.FriendsListPopup.Mode == CoD.playerListType.friendRequest then
			CoD.FriendRequestPopup.SelectedPlayerXuid = f2_local0.playerXuid
			CoD.FriendRequestPopup.SelectedPlayerName = f2_local0.playerName
			f2_arg0:openPopup("FriendRequestPopup", f2_arg1.controller)
		else
			f2_arg0:openPopup("FriendPopup", f2_arg1.controller)
		end
	end
end

CoD.FriendsListPopup.XboxLIVEParty = function (f3_arg0, f3_arg1)
	Engine.Exec(f3_arg1.controller, "showParty")
end

CoD.FriendsListPopup.PS3Invitations = function (f4_arg0, f4_arg1)
	Engine.Exec(f4_arg1.controller, "gameInvitesReceived")
end

CoD.FriendsListPopup.InviteToSession = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.listBox:getFocussedMutables()
	if f5_local0 ~= nil then
		CoD.invitePlayer(f5_arg1.controller, f5_local0.playerXuid, CoD.FriendsListPopup.Mode)
	end
end

CoD.FriendsListPopup.JoinSession = function (f6_arg0, f6_arg1)
	if UIExpression.IsInGame() == 1 and CoD.isZombie == false then
		if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) and Engine.ProbationCheckForQuitWarning(CoD.GAMEMODE_LEAGUE_MATCH) then
			f6_arg0:openPopup("popup_probation_join_quit_warning", f6_arg1.controller)
			return 
		elseif Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH) and Engine.ProbationCheckForQuitWarning(CoD.GAMEMODE_PUBLIC_MATCH) then
			f6_arg0:openPopup("popup_probation_join_quit_warning", f6_arg1.controller)
			return 
		end
	end
	CoD.FriendsListPopup.FinishJoinSession(f6_arg0, f6_arg1)
end

CoD.FriendsListPopup.FinishJoinSession = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg0.listBox:getFocussedMutables()
	if f7_local0 ~= nil then
		Engine.UpdateStatsForQuit(f7_arg1.controller, true)
		CoD.joinPlayer(f7_arg1.controller, f7_local0.playerXuid)
		CoD.FriendsList.CloseMenu(f7_arg0, f7_arg1)
	end
end

CoD.FriendsListPopup.NoJoinButtonPressed = function (f8_arg0, f8_arg1)
	f8_arg0:goBack(f8_arg1.controller)
end

CoD.FriendsListPopup.FriendFocusChanged = function (f9_arg0)
	CoD.FriendsListPopup.UpdatePromptButtonVis(f9_arg0)
	local f9_local0 = f9_arg0.listBox:getFocussedMutables()
	if f9_local0 ~= nil and f9_local0.playerXuid ~= nil and CoD.FriendDetails ~= nil then
		local f9_local1 = CoD.FriendsListPopup.Mode
		if f9_local1 ~= CoD.playerListType.friendRequest then
			CoD.FriendDetails.refresh(f9_arg0.details, f9_arg0.m_ownerController, f9_local0.playerXuid, f9_local0.playerIndex, f9_local1)
		end
	end
end

CoD.FriendsListPopup.UpdatePromptButtonVis = function (f10_arg0)
	if f10_arg0 == nil then
		return 
	elseif CoD.isWIIU and f10_arg0.tabManager.tabSelected == f10_arg0.textMessageTabIndex then
		f10_arg0.rootTextMessageElement:updatePromptButtonVis()
		return 
	end
	local f10_local0 = f10_arg0.m_ownerController
	f10_arg0.leftButtonPromptBar:removeAllChildren()
	f10_arg0.rightButtonPromptBar:removeAllChildren()
	if f10_arg0.listBox:getTotalItems() > 0 then
		if f10_arg0.selectButton ~= nil then
			f10_arg0:addLeftButtonPrompt(f10_arg0.selectButton)
		end
		local f10_local1 = f10_arg0.listBox:getFocussedMutables()
		if f10_local1 ~= nil and f10_local1.playerXuid ~= nil then
			if CoD.canInviteToGame(f10_local0, f10_local1.playerXuid) and f10_arg0.inviteButton ~= nil then
				f10_arg0:addLeftButtonPrompt(f10_arg0.inviteButton)
			end
			if CoD.canJoinSession(f10_local0, f10_local1.playerXuid) and f10_arg0.joinButton ~= nil then
				f10_arg0:addLeftButtonPrompt(f10_arg0.joinButton)
			end
		end
	end
	if CoD.FriendsListPopup.Mode == CoD.playerListType.facebook and nil ~= Engine.IsFacebookLinked and Engine.IsFacebookLinked(f10_local0) == false and Engine.IsPlayerUnderage(f10_local0) == false and 0 == UIExpression.IsInGame() then
		f10_arg0:addLeftButtonPrompt(f10_arg0.linkFBButton)
	end
	if CoD.isPS3 then
		f10_arg0:addLeftButtonPrompt(f10_arg0.invitationsButton)
	end
	f10_arg0:addRightButtonPrompt(f10_arg0.backButton)
	if f10_arg0.friendsOptions ~= nil then
		f10_arg0:addRightButtonPrompt(f10_arg0.friendsOptions)
	end
	if CoD.isWIIU and f10_arg0.friendsAddFriend ~= nil then
		f10_arg0:addRightButtonPrompt(f10_arg0.friendsAddFriend)
	end
	if CoD.FriendsListPopup.Mode == CoD.playerListType.party then
		f10_arg0:addLeftButtonPrompt(f10_arg0.partyButton)
	end
end

local f0_local0 = function (f11_arg0, f11_arg1)
	if not CoD.isSinglePlayer and not CoD.isZombie then
		local f11_local0 = 32
		f11_arg1.rankIcon = LUI.UIImage.new()
		f11_arg1.rankIcon:setLeftRight(false, true, -5 - f11_local0, -5)
		f11_arg1.rankIcon:setTopBottom(true, false, 0, f11_local0)
		f11_arg1.rankIcon:setAlpha(0)
		f11_arg1:addElement(f11_arg1.rankIcon)
		f11_arg1.rank = LUI.UIText.new()
		f11_arg1.rank:setLeftRight(true, true, 0, -f11_local0 - 10)
		f11_arg1.rank:setTopBottom(true, false, 0, CoD.textSize.Default)
		f11_arg1.rank:setFont(CoD.fonts.Default)
		f11_arg1.rank:setAlignment(LUI.Alignment.Right)
		f11_arg1:addElement(f11_arg1.rank)
	end
	f11_arg1.joinableIcon = LUI.UIImage.new()
	f11_arg1.joinableIcon:setLeftRight(false, true, -97, -65)
	f11_arg1.joinableIcon:setTopBottom(true, false, 0, 32)
	f11_arg1.joinableIcon:setImage(RegisterMaterial("menu_mp_party_ease_icon"))
	f11_arg1.joinableIcon:setAlpha(0)
	f11_arg1:addElement(f11_arg1.joinableIcon)
	f11_arg1.name = LUI.UIText.new({
		left = 10 + CoD.FriendsListPopup.EmblemHeight * 2,
		top = 0,
		right = 0,
		bottom = CoD.textSize.Default,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Default
	})
	f11_arg1:addElement(f11_arg1.name)
	f11_arg1.presence = LUI.UIText.new({
		left = 10 + CoD.FriendsListPopup.EmblemHeight * 2,
		top = CoD.textSize.Default + 5,
		right = 0,
		bottom = CoD.textSize.Default * 2 + 5,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Default
	})
	f11_arg1.presence:setAlignment(LUI.Alignment.Center)
	f11_arg1:setUseStencil(true)
	f11_arg1:addElement(f11_arg1.presence)
	if not CoD.isSinglePlayer and CoD.FriendsListPopup.Mode ~= CoD.playerListType.friendRequest then
		f11_arg1.emblem = LUI.UIImage.new({
			shaderVector0 = {
				0,
				0,
				0,
				0
			},
			left = 5,
			top = -CoD.FriendsListPopup.EmblemHeight,
			right = 5 + CoD.FriendsListPopup.EmblemHeight * 2,
			bottom = CoD.FriendsListPopup.EmblemHeight,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false
		})
		f11_arg1:addElement(f11_arg1.emblem)
	end
end

local f0_local1 = function (f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = Engine.GetPlayerInfoByIndex(f12_arg0, f12_arg1 - 1, CoD.FriendsListPopup.Mode)
	if f12_local0 ~= nil then
		f12_arg2.playerXuid = f12_local0.xuid
		f12_arg2.playerName = f12_local0.name
		f12_arg2.socialFacebook = f12_local0.socialFacebook
		f12_arg2.playerSocialName = f12_local0.socialName
		f12_arg2.playerRank = f12_local0.rank
		f12_arg2.playerIndex = f12_arg1 - 1
		f12_arg2.playerRankIcon = f12_local0.rankIcon
		f12_arg2.name:setText(f12_local0.name)
		f12_arg2.presence:setText(f12_local0.status)
		local f12_local1 = Engine.IsPlayerJoinable(f12_arg0, f12_arg2.playerXuid)
		if f12_local1.isJoinable then
			f12_arg2.joinableIcon:setAlpha(1)
		else
			f12_arg2.joinableIcon:setAlpha(0)
		end
		if not CoD.isSinglePlayer and CoD.FriendsListPopup.Mode ~= CoD.playerListType.friendRequest then
			if CoD.isZombie == true then
				f12_arg2.emblem:setImage(RegisterMaterial(f12_local0.rankIcon))
			else
				if f12_local0.rank ~= nil and f12_local0.rankIcon ~= nil and f12_local0.rank ~= "0" then
					f12_arg2.rankIcon:setImage(RegisterMaterial(f12_local0.rankIcon))
					f12_arg2.rankIcon:setAlpha(1)
					if f12_local0.prestige ~= tonumber(CoD.MAX_PRESTIGE) then
						f12_arg2.rank:setText(f12_local0.rank)
					else
						f12_arg2.rank:setText("")
					end
				else
					f12_arg2.rankIcon:setAlpha(0)
					f12_arg2.rank:setText("")
				end
				f12_arg2.emblem:setupPlayerEmblemByXUID(f12_arg2.playerXuid)
			end
		end
	end
end

CoD.FriendsListPopup.RefreshList = function (f13_arg0, f13_arg1)
	local f13_local0 = f13_arg0.listBox:getFocussedMutables()
	local f13_local1 = {
		index = 1
	}
	local f13_local2 = {}
	f13_local2 = CoD.FriendsListPopup.Mode
	if f13_arg0 ~= nil and f13_arg0.listBox ~= nil then
		if f13_local0 ~= nil and f13_local0.playerXuid ~= nil and f13_local0.playerXuid ~= 0 then
			f13_local1 = Engine.GetPlayerIndexByXuid(f13_arg0.m_ownerController, f13_local0.playerXuid, f13_local2)
			f13_local1.index = f13_local1.index + 1
		end
		if CoD.FriendsListPopup.Mode == CoD.playerListType.facebook then
			if nil ~= Engine.IsFacebookLinked and Engine.IsFacebookLinked(controller) then
				if nil ~= Engine.IsFacebookDuplicate and Engine.IsFacebookDuplicate(controller) then
					f13_arg0.listBox.noDataText = Engine.Localize("MENU_FB_ACCOUNT_IN_USE")
				else
					f13_arg0.listBox.noDataText = Engine.Localize("MENU_FRIENDS_FB_NONE")
				end
			else
				f13_arg0.listBox.noDataText = Engine.Localize("MENU_FRIENDS_FB_NOT_LINKED")
			end
		end
		f13_arg0.listBox:setTotalItems(Engine.GetPlayerCount(f13_arg0.m_ownerController, CoD.FriendsListPopup.Mode), f13_local1.index)
		CoD.FriendsListPopup.UpdatePromptButtonVis(f13_arg0)
		f13_arg0.listBox:refresh()
		if Engine.GetPlayerCount(f13_arg0.m_ownerController, CoD.FriendsListPopup.Mode) == 0 and CoD.FriendDetails ~= nil then
			CoD.FriendDetails.hide(f13_arg0.details)
		end
	end
end

local f0_local2 = function (f14_arg0, f14_arg1)
	Dvar.ui_friendsListOpen:set(true)
	Dvar.ui_playerListOpen:set(false)
	if CoD.isXBOX then
		Dvar.ui_xboxLivePartyListOpen:set(false)
	end
	Engine.Exec(f14_arg1, "updateInfoForInGameList")
	local f14_local0 = f14_arg0.popup
	f14_local0.joinText:setText("")
	f14_local0.listBox.noDataText = Engine.Localize("MPUI_NO_FRIENDS")
	if CoD.FriendDetails ~= nil then
		CoD.FriendDetails.hide(f14_local0.details)
	end
	f14_local0:addElement(f14_local0.listBox)
	f14_local0.header:setText(Engine.Localize("MENU_TAB_FRIENDS_CAPS"))
	CoD.FriendsListPopup.Mode = CoD.playerListType.friend
	f14_local0.listBox:setTotalItems(Engine.GetPlayerCount(f14_arg1, CoD.FriendsListPopup.Mode))
	CoD.FriendsListPopup.UpdatePromptButtonVis(f14_local0)
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

local f0_local3 = function (f15_arg0, f15_arg1)
	Dvar.ui_friendsListOpen:set(true)
	Dvar.ui_playerListOpen:set(false)
	if CoD.isXBOX then
		Dvar.ui_xboxLivePartyListOpen:set(false)
	end
	Engine.Exec(f15_arg1, "updateInfoForInGameList")
	local f15_local0 = f15_arg0.popup
	if CoD.FriendDetails ~= nil then
		CoD.FriendDetails.hide(f15_local0.details)
	end
	f15_local0:addElement(f15_local0.listBox)
	f15_local0.header:setText(Engine.Localize("MENU_TAB_LEAGUE_FRIENDS_CAPS"))
	f15_local0.listBox.noDataText = Engine.Localize("MENU_LEAGUE_FRIENDS_NONE")
	CoD.FriendsListPopup.Mode = CoD.playerListType.leagueFriend
	f15_local0.listBox:setTotalItems(Engine.GetPlayerCount(f15_arg1, CoD.FriendsListPopup.Mode))
	CoD.FriendsListPopup.UpdatePromptButtonVis(f15_local0)
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

local f0_local4 = function (f16_arg0, f16_arg1)
	Dvar.ui_friendsListOpen:set(true)
	Dvar.ui_playerListOpen:set(false)
	if CoD.isXBOX then
		Dvar.ui_xboxLivePartyListOpen:set(false)
	end
	Engine.Exec(f16_arg1, "updateInfoForInGameList")
	local f16_local0 = f16_arg0.popup
	if CoD.FriendDetails ~= nil then
		CoD.FriendDetails.hide(f16_local0.details)
	end
	f16_local0:addElement(f16_local0.listBox)
	f16_local0.header:setText(Engine.Localize("MENU_TAB_FACEBOOK_CAPS"))
	if Engine.IsFacebookLinked ~= nil and Engine.IsFacebookLinked(f16_arg1) then
		if Engine.IsFacebookDuplicate ~= nil and Engine.IsFacebookDuplicate(f16_arg1) then
			f16_local0.listBox.noDataText = Engine.Localize("MENU_FB_ACCOUNT_IN_USE")
		else
			f16_local0.listBox.noDataText = Engine.Localize("MENU_FRIENDS_FB_NONE")
		end
	elseif Engine.IsPlayerUnderage(f16_arg1) then
		f16_local0.listBox.noDataText = Engine.Localize("MENU_GENERIC_UNDERAGE_MESSAGE")
	else
		f16_local0.listBox.noDataText = Engine.Localize("MENU_FRIENDS_FB_NOT_LINKED")
	end
	CoD.FriendsListPopup.Mode = CoD.playerListType.facebook
	f16_local0.listBox:setTotalItems(Engine.GetPlayerCount(f16_arg1, CoD.FriendsListPopup.Mode))
	CoD.FriendsListPopup.UpdatePromptButtonVis(f16_local0)
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

local f0_local5 = function (f17_arg0, f17_arg1)
	Dvar.ui_friendsListOpen:set(false)
	Dvar.ui_playerListOpen:set(true)
	if CoD.isXBOX then
		Dvar.ui_xboxLivePartyListOpen:set(false)
	end
	Engine.Exec(f17_arg1, "updateInfoForInGameList")
	local f17_local0 = f17_arg0.popup
	f17_local0.joinText:setText("")
	f17_local0.listBox.noDataText = Engine.Localize("MPUI_NO_RECENT")
	if CoD.FriendDetails ~= nil then
		CoD.FriendDetails.hide(f17_local0.details)
	end
	f17_local0:addElement(f17_local0.listBox)
	f17_local0.header:setText(Engine.Localize("MENU_TAB_PLAYERS_CAPS"))
	CoD.FriendsListPopup.Mode = CoD.playerListType.recentPlayer
	f17_local0.listBox:setTotalItems(Engine.GetPlayerCount(f17_arg1, CoD.FriendsListPopup.Mode))
	CoD.FriendsListPopup.UpdatePromptButtonVis(f17_local0)
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

local f0_local6 = function (f18_arg0, f18_arg1)
	Dvar.ui_friendsListOpen:set(false)
	Dvar.ui_playerListOpen:set(true)
	if CoD.isXBOX then
		Dvar.ui_xboxLivePartyListOpen:set(false)
	end
	Engine.Exec(f18_arg1, "updateInfoForInGameList")
	local f18_local0 = f18_arg0.popup
	if CoD.FriendDetails ~= nil then
		CoD.FriendDetails.hide(f18_local0.details)
	end
	f18_local0:addElement(f18_local0.listBox)
	f18_local0.header:setText(Engine.Localize("MENU_TAB_ELITE_CLAN_CAPS"))
	local f18_local1 = Engine.GetPlayerCount(f18_arg1, CoD.playerListType.elite)
	if Engine.IsPlayerEliteRegistered(f18_arg1) ~= true then
		f18_local0.listBox.noDataText = Engine.Localize("MPUI_JOIN_ELITE_TEXT")
	elseif f18_local1 < 1 then
		f18_local0.listBox.noDataText = Engine.Localize("MPUI_JOIN_ELITE_CLAN")
	end
	CoD.FriendsListPopup.Mode = CoD.playerListType.elite
	f18_local0.listBox:setTotalItems(Engine.GetPlayerCount(f18_arg1, CoD.FriendsListPopup.Mode))
	CoD.FriendsListPopup.UpdatePromptButtonVis(f18_local0)
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

local f0_local7 = function (f19_arg0, f19_arg1)
	Dvar.ui_friendsListOpen:set(false)
	Dvar.ui_playerListOpen:set(false)
	if CoD.isXBOX then
		Dvar.ui_xboxLivePartyListOpen:set(true)
	end
	Engine.Exec(f19_arg1, "updateInfoForInGameList")
	local f19_local0 = f19_arg0.popup
	f19_local0.joinText:setText("")
	if CoD.FriendDetails ~= nil then
		CoD.FriendDetails.hide(f19_local0.details)
	end
	f19_local0:addElement(f19_local0.listBox)
	f19_local0.header:setText(Engine.Localize("MENU_TAB_XBOXLIVE_PARTY"))
	f19_local0.listBox.noDataText = Engine.Localize("MPUI_START_XBOX_PARTY")
	CoD.FriendsListPopup.Mode = CoD.playerListType.party
	f19_local0.listBox:setTotalItems(Engine.GetPlayerCount(f19_arg1, CoD.FriendsListPopup.Mode))
	CoD.FriendsListPopup.UpdatePromptButtonVis(f19_local0)
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

local f0_local8 = function (f20_arg0, f20_arg1)
	local f20_local0 = f20_arg0.popup
	f20_local0.joinText:setText("")
	if CoD.isSinglePlayer then
		CoD.FriendDetails = nil
	end
	f20_local0:addElement(f20_local0.listBox)
	f20_local0.header:setText(Engine.Localize("MENU_GAME_INVITES_CAPS"))
	f20_local0.listBox.noDataText = Engine.Localize("MENU_NO_INVITE")
	if CoD.FriendDetails ~= nil then
		CoD.FriendDetails.hide(f20_local0.details)
	end
	CoD.FriendsListPopup.Mode = CoD.playerListType.gameInvites
	f20_local0.listBox:setTotalItems(Engine.GetPlayerCount(f20_arg1, CoD.FriendsListPopup.Mode))
	CoD.FriendsListPopup.UpdatePromptButtonVis(f20_local0)
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

local f0_local9 = function (f21_arg0, f21_arg1)
	local f21_local0 = f21_arg0.popup
	f21_local0.joinText:setText("")
	if CoD.isSinglePlayer then
		CoD.FriendDetails = nil
	end
	f21_local0:addElement(f21_local0.listBox)
	f21_local0.header:setText(Engine.Localize("PLATFORM_FRIEND_REQUESTS_CAPS"))
	f21_local0.listBox.noDataText = Engine.Localize("PLATFORM_NO_REQUESTS")
	if CoD.FriendDetails ~= nil then
		CoD.FriendDetails.hide(f21_local0.details)
	end
	CoD.FriendsListPopup.Mode = CoD.playerListType.friendRequest
	f21_local0.listBox:setTotalItems(Engine.GetPlayerCount(f21_arg1, CoD.FriendsListPopup.Mode))
	CoD.FriendsListPopup.UpdatePromptButtonVis(f21_local0)
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

local f0_local10 = function (f22_arg0, f22_arg1)
	local f22_local0 = f22_arg0.popup
	f22_local0.joinText:setText("")
	if CoD.isSinglePlayer then
		CoD.FriendDetails = nil
	end
	if CoD.FriendDetails ~= nil then
		CoD.FriendDetails.hide(f22_local0.details)
	end
	f22_local0.listBox:close()
	f22_local0.header:setText(Engine.Localize("PLATFORM_UI_TM_TEXT_MESSAGES_CAPS"))
	f22_local0.rootTextMessageElement = CoD.TextMessage.CreateRootTextMessageElement(f22_local0, f22_arg1)
	f22_local0.rootTextMessageElement:updatePromptButtonVis()
	f22_local0.rootTextMessageElement:setTopBottom(true, true, 110, -CoD.ButtonPrompt.Height)
	return f22_local0.rootTextMessageElement
end

local f0_local11 = function (f23_arg0, f23_arg1)
	Engine.Exec(f23_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_ADD_FRIEND)
end

local f0_local12 = function (f24_arg0, f24_arg1)
	f24_arg0:registerEventHandler("ui_keyboard_input", nil)
	local f24_local0 = f24_arg1.input
	if f24_local0 ~= nil then
		Engine.Exec(f24_arg1.controller, "xaddfriendbyname " .. f24_local0)
	end
end

CoD.FriendsListPopup.Close = function (f25_arg0, f25_arg1)
	if f25_arg0.occludedMenu ~= nil then
		f25_arg0.occludedMenu:processEvent({
			name = "closeallpopups",
			controller = f25_arg1.controller
		})
	end
	CoD.FriendsList.CloseMenu(f25_arg0, f25_arg1)
end

CoD.FriendsListPopup.SaveAndQuit = function (f26_arg0, f26_arg1)
	f26_arg0:saveState()
	f26_arg0:openMenu("SaveAndQuitGamePopup", f26_arg1.controller)
	f26_arg0:close()
end

CoD.FriendsListPopup.FacebookLink = function (f27_arg0, f27_arg1)
	if Engine.IsFacebookLinked ~= nil and Engine.IsFacebookLinked(f27_arg1.controller) == false then
		Engine.Exec(f27_arg1.controller, "fbLinkFacebook")
	end
end

LUI.createMenu.FriendsList = function (f28_arg0, f28_arg1)
	Engine.Exec(f28_arg0, "updateInfoForInGameList")
	local f28_local0 = CoD.Menu.New("FriendsList")
	if not Engine.IsInGame() then
		f28_local0:addLargePopupBackground()
	end
	if f28_arg1 ~= nil and f28_arg1.previousMenu ~= nil then
		f28_local0:setPreviousMenu(f28_arg1.previousMenu)
		f28_local0.previousMenu = f28_arg1.previousMenu
	end
	f28_local0:setOwner(f28_arg0)
	f28_local0:registerEventHandler("close_friends_list", CoD.FriendsList.CloseMenu)
	f28_local0:registerEventHandler("friend_invitetosession", CoD.FriendsListPopup.InviteToSession)
	f28_local0:registerEventHandler("friend_joinsession", CoD.FriendsListPopup.JoinSession)
	f28_local0:registerEventHandler("probation_confirmation", CoD.FriendsListPopup.FinishJoinSession)
	f28_local0:registerEventHandler("listbox_focus_changed", CoD.FriendsListPopup.FriendFocusChanged)
	f28_local0:registerEventHandler("friend_selected", CoD.FriendsListPopup.FriendSelected)
	f28_local0:registerEventHandler("xboxlive_party", CoD.FriendsListPopup.XboxLIVEParty)
	f28_local0:registerEventHandler("ps3_invitations", CoD.FriendsListPopup.PS3Invitations)
	f28_local0:registerEventHandler("friends_updated", CoD.FriendsListPopup.RefreshList)
	f28_local0:registerEventHandler("closeallpopups", CoD.FriendPopup.Close)
	f28_local0:registerEventHandler("signed_out", CoD.Menu.SignedOut)
	f28_local0:registerEventHandler("fb_linkFacebook", CoD.FriendsListPopup.FacebookLink)
	if CoD.useMouse then
		f28_local0:registerEventHandler("listbox_clicked", CoD.FriendsListPopup.FriendSelected)
	end
	if CoD.isWIIU then
		f28_local0:registerEventHandler("open_saveandquitgamepopup", CoD.FriendsListPopup.SaveAndQuit)
		f28_local0:registerEventHandler("closeFriendsList", CoD.FriendsListPopup.Close)
		if not Engine.IsInGame() then
			LUI.roots.UIRootFull.friendsMenu = f28_local0
		else
			local f28_local1 = LUI.roots
			local f28_local2 = "UIRoot"
			f28_local1["UIRoot" .. f28_arg0].friendsMenu = f28_local0
		end
	end
	f28_local0.selectButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_SELECT"), f28_local0, "friend_selected")
	local f28_local1
	if CoD.isZombie then
		f28_local1 = not Engine.IsInGame()
	else
		f28_local1 = true
	end
	if f28_local1 == true then
		local f28_local2 = CoD.ButtonPrompt.new
		local f28_local3 = "select"
		local f28_local4 = Engine.Localize("MENU_INVITE_GAME")
		local f28_local5 = f28_local0
		local f28_local6 = "friend_invitetosession"
		local f28_local7, f28_local8 = false
		local f28_local9, f28_local10 = false
		f28_local0.inviteButton = f28_local2(f28_local3, f28_local4, f28_local5, f28_local6, f28_local7, f28_local8, f28_local9, f28_local10, "I")
		f28_local2 = CoD.ButtonPrompt.new
		f28_local3 = "alt1"
		f28_local4 = Engine.Localize("MENU_JOIN_IN_PROGRESS")
		f28_local5 = f28_local0
		f28_local6 = "friend_joinsession"
		f28_local7, f28_local8 = false
		f28_local9, f28_local10 = false
		f28_local0.joinButton = f28_local2(f28_local3, f28_local4, f28_local5, f28_local6, f28_local7, f28_local8, f28_local9, f28_local10, "J")
	end
	f28_local0.backButton = CoD.ButtonPrompt.new("secondary", Engine.Localize("MPUI_DONE"), f28_local0, "close_friends_list")
	f28_local0.partyButton = CoD.ButtonPrompt.new("start", Engine.Localize("MENU_XBOXLIVE_PARTY"), f28_local0, "xboxlive_party")
	f28_local0.linkFBButton = CoD.ButtonPrompt.new("alt1", Engine.Localize("MENU_FB_LINK"), f28_local0, "fb_linkFacebook")
	if CoD.isPS3 then
		f28_local0.invitationsButton = CoD.ButtonPrompt.new("start", Engine.Localize("PLATFORM_VIEW_GAME_INVITES"), f28_local0, "ps3_invitations")
	end
	if not CoD.isSinglePlayer then
		f28_local0.details = CoD.FriendDetails.new()
		f28_local0:addElement(f28_local0.details)
	end
	f28_local0.listBox = CoD.ListBox.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = CoD.SDSafeWidth,
		topAnchor = true,
		bottomAnchor = true,
		top = 110,
		bottom = -CoD.ButtonPrompt.Height - 5
	}, f28_arg0, 7, CoD.CoD9Button.Height * 2, 400, f0_local0, f0_local1, 5, 2)
	CoD.ListBox.HideMessage(f28_local0.listBox, true)
	local f28_local4 = {
		left = 0,
		top = 70,
		right = 0,
		bottom = CoD.ButtonPrompt.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}
	f28_local0.tabContentPane = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = -CoD.ButtonPrompt.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	local f28_local5 = CoD.MFTabManager.new(f28_local0.tabContentPane, f28_local4)
	f28_local5:keepRightBumperAlignedToHeader(true)
	f28_local5.popup = f28_local0
	f28_local0.tabManager = f28_local5
	local f28_local6 = "Big"
	local f28_local7 = CoD.fonts[f28_local6]
	local f28_local8 = CoD.textSize[f28_local6]
	f28_local0.header = LUI.UIText.new()
	f28_local0.header:setLeftRight(true, true, 0, 0)
	f28_local0.header:setTopBottom(true, false, 15, 15 + f28_local8)
	f28_local0.header:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f28_local0.header:setFont(f28_local7)
	f28_local0.header:setAlignment(LUI.Alignment.Left)
	if CoD.isMultiplayer and not CoD.isZombie then
		f28_local0:addElement(CoD.MiniIdentity.GetMiniIdentity(f28_arg0))
	end
	f28_local0.listBox.m_positionTextString = "MENU_LB_LISTBOX_POSITION_TEXT"
	f28_local0.listBox:addScrollBar(30, 2)
	f28_local0.listBox.m_pageArrowsOn = true
	f28_local0:addElement(f28_local0.header)
	f28_local0:addElement(f28_local5)
	f28_local0:addElement(f28_local0.tabContentPane)
	f28_local0.joinText = LUI.UIText.new()
	f28_local0:addElement(f28_local0.joinText)
	f28_local0.joinText:setText("")
	f28_local5:addTab(f28_arg0, "MENU_TAB_FRIENDS_CAPS", f0_local2)
	f28_local5:addTab(f28_arg0, "MENU_TAB_LEAGUE_FRIENDS_CAPS", f0_local3)
	if not CoD.isPC then
		f28_local5:addTab(f28_arg0, "MENU_TAB_FACEBOOK_CAPS", f0_local4)
	end
	if Engine.IsEliteAvailable() then
		f28_local5:addTab(f28_arg0, "MENU_TAB_ELITE_CLAN_CAPS", f0_local6)
	end
	f28_local5:addTab(f28_arg0, "MENU_TAB_PLAYERS_CAPS", f0_local5)
	if CoD.isXBOX then
		f28_local5:addTab(f28_arg0, "MENU_TAB_XBOXLIVE_PARTY", f0_local7)
	end
	if CoD.isWIIU or CoD.isPC then
		f28_local5:addTab(f28_arg0, "MENU_GAME_INVITES_CAPS", f0_local8)
	end
	if CoD.isWIIU then
		f28_local5:addTab(f28_arg0, "PLATFORM_FRIEND_REQUESTS_CAPS", f0_local9)
	end
	if CoD.isWIIU or nil ~= LUI.roots.UIRootDrc then
		f28_local0.textMessageTabIndex = f28_local5:addTab(f28_arg0, "PLATFORM_UI_TM_TEXT_MESSAGES_CAPS", f0_local10)
	end
	f28_local5:refreshTab(f28_arg0)
	f28_local0:addElement(f28_local0.listBox)
	f28_local0.listBox:setTotalItems(Engine.GetPlayerCount(f28_arg0, CoD.FriendsListPopup.Mode), 1)
	CoD.FriendsListPopup.UpdatePromptButtonVis(f28_local0)
	if not CoD.isZombie then
		Engine.PlaySound("cac_loadout_edit_sel")
	else
		Engine.PlaySound("cac_grid_equip_item")
	end
	return f28_local0
end

LUI.createMenu.IngameFriendsList = function (f29_arg0)
	local f29_local0 = nil
	f29_local0 = CoD.Menu.New("FriendsList")
	f29_local0:addLargePopupBackground()
	f29_local0:setOwner(f29_arg0)
	f29_local0:setPreviousMenu("class")
	f29_local0:registerEventHandler("friend_invitetosession", CoD.FriendsListPopup.InviteToSession)
	f29_local0:registerEventHandler("friend_joinsession", CoD.FriendsListPopup.JoinSession)
	f29_local0:registerEventHandler("listbox_focus_changed", CoD.FriendsListPopup.FriendFocusChanged)
	f29_local0:registerEventHandler("friend_selected", CoD.FriendsListPopup.FriendSelected)
	f29_local0:registerEventHandler("friends_updated", CoD.FriendsListPopup.RefreshList)
	f29_local0:registerEventHandler("closeallpopups", CoD.FriendPopup.Close)
	f29_local0:registerEventHandler("close_all_ingame_menus", CoD.FriendPopup.Close)
	if CoD.useMouse then
		f29_local0:registerEventHandler("listbox_clicked", CoD.FriendsListPopup.FriendSelected)
	end
	f29_local0.selectButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_SELECT"), f29_local0, "friend_selected")
	local f29_local1 = CoD.ButtonPrompt.new
	local f29_local2 = "alt2"
	local f29_local3 = Engine.Localize("MENU_INVITE_GAME")
	local f29_local4 = f29_local0
	local f29_local5 = "friend_invitetosession"
	local f29_local6, f29_local7 = false
	local f29_local8, f29_local9 = false
	f29_local0.inviteButton = f29_local1(f29_local2, f29_local3, f29_local4, f29_local5, f29_local6, f29_local7, f29_local8, f29_local9, "I")
	f29_local1 = CoD.ButtonPrompt.new
	f29_local2 = "alt1"
	f29_local3 = Engine.Localize("MENU_JOIN_IN_PROGRESS")
	f29_local4 = f29_local0
	f29_local5 = "friend_joinsession"
	f29_local6, f29_local7 = false
	f29_local8, f29_local9 = false
	f29_local0.joinButton = f29_local1(f29_local2, f29_local3, f29_local4, f29_local5, f29_local6, f29_local7, f29_local8, f29_local9, "J")
	f29_local0.backButton = CoD.ButtonPrompt.new("secondary", Engine.Localize("MPUI_DONE"), f29_local0, "button_prompt_back")
	if not CoD.isSinglePlayer then
		f29_local0.details = CoD.FriendDetails.new()
		f29_local0:addElement(f29_local0.details)
	end
	f29_local0.listBox = CoD.ListBox.new({
		left = 0,
		top = 30,
		right = 0,
		bottom = -CoD.ButtonPrompt.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}, f29_arg0, 8, CoD.CoD9Button.Height * 2, 400, f0_local0, f0_local1, 5, 2)
	Dvar.ui_friendsListOpen:set(true)
	f29_local2 = {
		left = 0,
		top = 0,
		right = 0,
		bottom = CoD.ButtonPrompt.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}
	f29_local0.tabContentPane = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = -CoD.ButtonPrompt.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	f29_local3 = CoD.MFTabManager.new(f29_local0.tabContentPane, f29_local2)
	f29_local3.popup = f29_local0
	f29_local0.tabManager = f29_local3
	f29_local0:addElement(f29_local3)
	f29_local0:addElement(f29_local0.tabContentPane)
	f29_local3:addTab(f29_arg0, "MENU_TAB_FRIENDS_CAPS", f0_local2)
	f29_local3:addTab(f29_arg0, "MENU_TAB_PLAYERS_CAPS", f0_local5)
	f29_local3:addTab(f29_arg0, "MENU_GAME_INVITES_CAPS", f0_local8)
	f29_local3:refreshTab(f29_arg0)
	f29_local0:addElement(f29_local0.listBox)
	f29_local0.listBox:setTotalItems(Engine.GetPlayerCount(f29_arg0, CoD.FriendsListPopup.Mode))
	CoD.FriendsListPopup.UpdatePromptButtonVis(f29_local0)
	Engine.PlaySound("cac_loadout_edit_sel")
	if CoD.isWIIU then
		f29_local4 = LUI.roots
		f29_local5 = "UIRoot"
		f29_local4["UIRoot" .. f29_arg0].friendsMenu = f29_local0
	end
	return f29_local0
end

