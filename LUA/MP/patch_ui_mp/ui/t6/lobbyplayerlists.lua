require("T6.Playerlist")
require("T6.LobbyList")
CoD.LobbyPlayerLists = {}
CoD.LobbyPlayerLists.AddList = function (f1_arg0, f1_arg1)
	table.insert(f1_arg0.playerLists, f1_arg1)
	f1_arg0:addElement(f1_arg1)
end

CoD.LobbyPlayerLists.GetAllLists = function (f2_arg0)
	local f2_local0 = {}
	for f2_local4, f2_local5 in ipairs(f2_arg0.playerLists) do
		table.insert(f2_local0, f2_local5)
	end
	if f2_arg0.joinableList then
		table.insert(f2_local0, f2_arg0.joinableList)
	end
	return f2_local0
end

CoD.LobbyPlayerLists.UpdateNavigationLinks = function (f3_arg0)
	local f3_local0, f3_local1, f3_local2 = nil
	local f3_local3 = CoD.LobbyPlayerLists.GetAllLists(f3_arg0)
	for f3_local7, f3_local8 in ipairs(f3_local3) do
		if f3_local8:getPlayerCount() > 0 then
			if f3_local0 == nil then
				f3_local0 = f3_local8.verticalList
			end
			f3_local1 = f3_local8.verticalList
			f3_local8.verticalList.navigation.up = f3_local2
			if f3_local2 ~= nil then
				f3_local2.navigation.down = f3_local8.verticalList
			end
			f3_local2 = f3_local8.verticalList
		end
	end
	if f3_local0 ~= nil then
		f3_local0.navigation.up = f3_local1
		f3_local1.navigation.down = f3_local0
	end
	for f3_local7, f3_local8 in ipairs(f3_local3) do
		LUI.UIVerticalList.UpdateNavigation(f3_local8.verticalList)
	end
end

CoD.LobbyPlayerLists.ListContainsLobbyMembers = function (f4_arg0)
	return f4_arg0.showVoipIcons == true
end

CoD.LobbyPlayerLists.Refresh = function (f5_arg0, f5_arg1)
	local f5_local0 = 0
	local f5_local1 = 0
	local f5_local2 = 0
	f5_arg0.availableTeamCount = 0
	if f5_arg0.showCommonStatusRow == true then
		f5_local0 = f5_local0 + 1
	end
	for f5_local6, f5_local7 in ipairs(f5_arg0.playerLists) do
		if f5_local7.update ~= nil then
			f5_local7:update(f5_arg0.members, f5_local0, f5_arg1, f5_arg0.showCommonStatusRow)
			f5_local0 = f5_local0 + f5_local7:getRowCount()
			if 0 < f5_local7:getPlayerCount() and CoD.LobbyPlayerLists.ListContainsLobbyMembers(f5_local7) == true then
				f5_arg0.availableTeamCount = f5_arg0.availableTeamCount + 1
			end
		end
	end
	if f5_arg0.members ~= nil then
		f5_local1 = #f5_arg0.members
	end
	if f5_arg0.showCommonStatusRow and 0 < f5_local1 then
		f5_local3 = ""
		f5_local4 = UIExpression.DvarInt(nil, "party_maxplayers")
		if Engine.IsGameLobbyRunning() and Engine.PartyConnectingToDedicated() and (1 == UIExpression.GetIsSuperUser() or UIExpression.GetUserTier() == 3) then
			f5_local3 = UIExpression.DvarString(nil, "party_hostname")
		end
		f5_local5 = nil
		if f5_local1 == 1 then
			f5_local5 = Engine.Localize("MENU_PLAYERLIST_PLAYER_COUNT_SINGULAR", f5_local1, f5_local4)
		else
			f5_local5 = Engine.Localize("MENU_PLAYERLIST_PLAYER_COUNT_PLURAL", f5_local1, f5_local4)
		end
		f5_arg0.statusRow:setText(f5_local5 .. " " .. f5_local3)
	end
	f5_local3 = UIExpression.DvarInt(nil, "party_maxplayers")
	for f5_local7, f5_local10 in ipairs(f5_arg0.playerLists) do
		local f5_local11 = f5_local10:getPlayerCount()
		if f5_local10.statusRow ~= nil and CoD.LobbyPlayerLists.ListContainsLobbyMembers(f5_local10) then
			local f5_local8 = 0
			if 0 < f5_arg0.availableTeamCount then
				f5_local8 = math.floor(f5_local3 / f5_arg0.availableTeamCount)
			end
			local f5_local9 = nil
			if f5_local11 == 1 then
				f5_local9 = Engine.Localize("MENU_PLAYERLIST_PLAYER_COUNT_SINGULAR", f5_local11, f5_local8)
			else
				f5_local9 = Engine.Localize("MENU_PLAYERLIST_PLAYER_COUNT_PLURAL", f5_local11, f5_local8)
			end
			f5_local10.statusRow:setText(f5_local9)
		end
	end
	f5_arg0.additionalRowList:clearList()
	if 0 < f5_local1 and f5_arg0.availableTeamCount == 1 then
		if Engine.IsPartyLobbyRunning() and not Engine.IsGameLobbyRunning() then
			f5_local4 = Engine.GetLeague()
			if f5_local4 and f5_local4.teamsAllowed then
				f5_local5 = f5_local4.teamSize - f5_local1
				if 0 < f5_local5 then
					f5_arg0.additionalRowList:addMissingTeamMemberRow(f5_local5)
				end
			end
		end
		if not Engine.PartyIsReadyToStart() and f5_arg0.enableSearchingRows == true then
			f5_local4 = nil
			if Engine.PartyConnectingToDedicated() then
				f5_local4 = 1
			else
				f5_local4 = 1
			end
			for f5_local5 = f5_local1, f5_local3 - f5_local4, 1 do
				f5_arg0.additionalRowList:addSearchingRow(f5_local5)
			end
		end
		f5_local4 = CoD.PlayerListRow.Height * f5_local0
		f5_arg0.additionalRowList:registerAnimationState("default", {
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = false,
			top = f5_local4,
			bottom = f5_local4 + CoD.PlayerListRow.Height * f5_arg0.additionalRowList:getRowCount()
		})
		f5_arg0.additionalRowList:animateToState("default")
	end
	if f5_arg0.joinableList ~= nil then
		f5_arg0.joinableList:update(nil, f5_local0, f5_local1, f5_arg1, false)
		f5_local0 = f5_local0 + f5_arg0.joinableList:getRowCount()
	end
	CoD.LobbyPlayerLists.UpdateNavigationLinks(f5_arg0)
end

local f0_local0 = function (f6_arg0, f6_arg1)
	if f6_arg0.score ~= nil and f6_arg1.score ~= nil and f6_arg0.score ~= f6_arg1.score then
		return tonumber(f6_arg1.score) < tonumber(f6_arg0.score)
	elseif f6_arg0.isInParty ~= f6_arg1.isInParty then
		return f6_arg0.isInParty
	elseif f6_arg0.subparty ~= f6_arg1.subparty then
		return f6_arg0.subparty < f6_arg1.subparty
	elseif f6_arg0.isLocal ~= f6_arg1.isLocal then
		return f6_arg1.isLocal < f6_arg0.isLocal
	elseif f6_arg0.isGuest ~= f6_arg1.isGuest then
		return f6_arg0.isGuest < f6_arg1.isGuest
	else
		return f6_arg0.gamertag:lower() < f6_arg1.gamertag:lower()
	end
end

local f0_local1 = function (f7_arg0, f7_arg1)
	if f7_arg0.isHost ~= f7_arg1.isHost then
		return f7_arg1.isHost < f7_arg0.isHost
	else
		return f0_local0(f7_arg0, f7_arg1)
	end
end

CoD.LobbyPlayerLists.Update = function (f8_arg0, f8_arg1)
	f8_arg0.members = f8_arg1
	if UIExpression.SessionMode_IsPublicOnlineGame() == 1 then
		table.sort(f8_arg0.members, f0_local0)
	else
		table.sort(f8_arg0.members, f0_local1)
	end
	CoD.LobbyPlayerLists.Refresh(f8_arg0, false)
	if f8_arg0.selectedPlayerXuid ~= nil then
		CoD.LobbyPlayerLists.SetFocus(f8_arg0)
	end
end

CoD.LobbyPlayerLists.UpdateEvent = function (f9_arg0, f9_arg1)
	if f9_arg1 ~= nil and f9_arg1.members ~= nil then
		CoD.LobbyPlayerLists.Update(f9_arg0, f9_arg1.members)
	end
end

CoD.LobbyPlayerLists.RefreshEvent = function (f10_arg0, f10_arg1)
	local f10_local0 = {}
	CoD.LobbyPlayerLists.Update(f10_arg0, Engine.GetPlayersInLobby())
	f10_arg0:dispatchEventToChildren(f10_arg1)
end

CoD.LobbyPlayerLists.SetFocusByXuid = function (f11_arg0, f11_arg1, f11_arg2)
	for f11_local3, f11_local4 in ipairs(CoD.LobbyPlayerLists.GetAllLists(f11_arg0)) do
		if (f11_arg2 == nil or f11_arg2 == f11_local4.id) and CoD.PlayerList.SetFocusByXuid(f11_local4, f11_arg1) then
			return true
		end
	end
	return false
end

CoD.LobbyPlayerLists.SetFocusByIndex = function (f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = CoD.LobbyPlayerLists.GetAllLists(f12_arg0)
	for f12_local4, f12_local5 in ipairs(f12_local0) do
		if f12_local5.id == f12_arg1 and CoD.PlayerList.SetFocusByIndex(f12_local5, f12_local4) then
			return true
		end
	end
	for f12_local4, f12_local5 in ipairs(f12_local0) do
		local f12_local6 = f12_local5:getRowCount()
		if f12_local6 > 0 and f12_local5.id == f12_arg1 and f12_local4 == f12_local6 - 1 and CoD.PlayerList.SetFocusByIndex(f12_local5, f12_local6) then
			return true
		end
	end
	return false
end

CoD.LobbyPlayerLists.SetDefaultFocus = function (f13_arg0)
	for f13_local3, f13_local4 in ipairs(CoD.LobbyPlayerLists.GetAllLists(f13_arg0)) do
		if CoD.PlayerList.SetFocusByIndex(f13_local4, 1) then
			return true
		end
	end
	return false
end

CoD.LobbyPlayerLists.SetFocus = function (f14_arg0)
	if f14_arg0.selectedPlayerXuid ~= nil then
		if CoD.LobbyPlayerLists.SetFocusByXuid(f14_arg0, f14_arg0.selectedPlayerXuid, f14_arg0.selectedPlayerListId) then
			return 
		elseif CoD.LobbyPlayerLists.SetFocusByXuid(f14_arg0, f14_arg0.selectedPlayerXuid) then
			return 
		elseif f14_arg0.selectedPlayerListId ~= nil and f14_arg0.selectedPlayerListIndex ~= nil and CoD.LobbyPlayerLists.SetFocusByIndex(f14_arg0, f14_arg0.selectedPlayerListId, f14_arg0.selectedPlayerListIndex) then
			return 
		end
	end
	CoD.LobbyPlayerLists.SetDefaultFocus(f14_arg0)
end

CoD.LobbyPlayerLists.SaveState = function (f15_arg0, f15_arg1)
	if not f15_arg0:isIDNamed() then
		error("LUI Error: Tried to save menu state, but element has no name: " .. f15_arg0:getFullID())
		return 
	else
		LUI.savedMenuStates[f15_arg1] = {
			id = f15_arg0.id,
			data = {
				playerXuid = f15_arg0.selectedPlayerXuid,
				listId = f15_arg0.selectedPlayerListId,
				listIndex = f15_arg0.selectedPlayerListIndex
			}
		}
	end
end

CoD.LobbyPlayerLists.RestoreFocus = function (f16_arg0, f16_arg1)
	if f16_arg0.id == f16_arg1.id then
		local f16_local0 = f16_arg1.data
		if f16_local0 ~= nil then
			f16_arg0.selectedPlayerXuid = f16_local0.playerXuid
			f16_arg0.selectedPlayerListId = f16_local0.listId
			f16_arg0.selectedPlayerListIndex = f16_local0.listIndex
		end
		CoD.LobbyPlayerLists.SetFocus(f16_arg0)
		return true
	else
		return f16_arg0:dispatchEventToChildren(f16_arg1)
	end
end

CoD.LobbyPlayerLists.PlayerListRowSelected = function (f17_arg0, f17_arg1)
	f17_arg0.selectedPlayerXuid = f17_arg1.playerXuid
	f17_arg0.selectedLeagueTeamID = f17_arg1.leagueTeamID
	f17_arg0.leagueTeamMemberCount = f17_arg1.leagueTeamMemberCount
	f17_arg0.selectedPlayerListId = f17_arg1.listId
	f17_arg0.selectedPlayerListIndex = f17_arg1.listIndex
	f17_arg0:dispatchEventToParent(f17_arg1)
end

CoD.LobbyPlayerLists.PlayerListRowDeselected = function (f18_arg0, f18_arg1)
	f18_arg0.selectedPlayerXuid = nil
	f18_arg0.selectedPlayerListId = nil
	f18_arg0.selectedPlayerListIndex = nil
	f18_arg0:dispatchEventToParent(f18_arg1)
end

CoD.LobbyPlayerLists.SetSplitscreenSignInAllowed = function (f19_arg0, f19_arg1)
	for f19_local3, f19_local4 in ipairs(f19_arg0.playerLists) do
		if f19_local4.setSplitscreenSignInAllowed ~= nil then
			f19_local4:setSplitscreenSignInAllowed(f19_arg1)
		end
	end
end

CoD.LobbyPlayerLists.New = function (f20_arg0, f20_arg1, f20_arg2, f20_arg3, f20_arg4, f20_arg5, f20_arg6)
	local f20_local0 = LUI.UIVerticalList.new(f20_arg0)
	f20_local0.id = f20_arg3 .. ".PlayerLists"
	f20_local0.enableSearchingRows = f20_arg5
	f20_local0.playerLists = {}
	f20_local0.setSplitscreenSignInAllowed = CoD.LobbyPlayerLists.SetSplitscreenSignInAllowed
	f20_local0:registerEventHandler("partylobby_update", CoD.LobbyPlayerLists.UpdateEvent)
	f20_local0:registerEventHandler("gamelobby_update", CoD.LobbyPlayerLists.UpdateEvent)
	f20_local0:registerEventHandler("game_options_update", CoD.LobbyPlayerLists.RefreshEvent)
	f20_local0:registerEventHandler("gametype_update", CoD.LobbyPlayerLists.RefreshEvent)
	f20_local0:registerEventHandler("restore_focus", CoD.LobbyPlayerLists.RestoreFocus)
	f20_local0:registerEventHandler("playerlist_row_selected", CoD.LobbyPlayerLists.PlayerListRowSelected)
	f20_local0:registerEventHandler("playerlist_row_deselected", CoD.LobbyPlayerLists.PlayerListRowDeselected)
	f20_local0:registerEventHandler("start_game", CoD.LobbyPlayerLists.RefreshEvent)
	f20_local0:registerEventHandler("cancel_start_game", CoD.LobbyPlayerLists.RefreshEvent)
	f20_local0:registerEventHandler("controller_inserted", CoD.LobbyPlayerLists.RefreshEvent)
	f20_local0:registerEventHandler("controller_removed", CoD.LobbyPlayerLists.RefreshEvent)
	f20_local0:registerEventHandler("controller_used_start", CoD.LobbyPlayerLists.RefreshEvent)
	f20_local0:registerEventHandler("controller_used_stop", CoD.LobbyPlayerLists.RefreshEvent)
	f20_local0.showCommonStatusRow = true
	if f20_local0.showCommonStatusRow == true then
		f20_local0.statusRow = CoD.PlayerListRow.CreateStatusRow(f20_local0, "", true, f20_arg1)
		f20_local0:addElement(f20_local0.statusRow)
	end
	local f20_local1 = {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}
	local f20_local2 = nil
	for f20_local3 = 0, CoD.TEAM_NUM_TEAMS - 1, 1 do
		if f20_arg2 ~= nil then
			f20_local2 = f20_arg2
		else
			f20_local2 = CoD.GetTeamName(f20_local3)
		end
		local f20_local6 = CoD.PlayerList.New
		local f20_local7 = f20_local1
		local f20_local8, f20_local9 = false
		CoD.LobbyPlayerLists.AddList(f20_local0, f20_local6(f20_local7, f20_local8, f20_local9, "playerlist" .. f20_local2, f20_local0.id, f20_local3, f20_arg6))
	end
	CoD.LobbyPlayerLists.AddList(f20_local0, CoD.LobbyList.New(f20_local1, "", "SplitscreenSignIn", f20_local0.id, nil, f20_arg4))
	f20_local0.additionalRowList = CoD.PlayerList.New(f20_local1, false, "", "AdditionalRowList", f20_local0.id, nil)
	f20_local0.additionalRowList:makeNotFocusable()
	f20_local0:addElement(f20_local0.additionalRowList)
	return f20_local0
end

