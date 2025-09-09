require("T6.VoipImage")
require("T6.PlayerListRow")
CoD.PlayerList = {}
CoD.PlayerList.AddStatusRow = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.PlayerListRow.CreateStatusRow(f1_arg0, f1_arg1)
	f1_arg0.verticalList:addElement(f1_local0)
	f1_arg0.rowCount = f1_arg0.rowCount + 1
	return f1_local0
end

CoD.PlayerList.AddMissingTeamMemberRow = function (f2_arg0, f2_arg1)
	local f2_local0 = CoD.PlayerListRow.CreateMissingTeamMemberRow(f2_arg0, f2_arg1)
	f2_arg0.verticalList:addElement(f2_local0)
	f2_arg0.rowCount = f2_arg0.rowCount + 1
	return f2_local0
end

CoD.PlayerList.AddMemberRow = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local f3_local0 = CoD.PlayerListRow.CreateRow(f3_arg0, f3_arg1, true, f3_arg2, f3_arg3, f3_arg0.showMissingDLC)
	f3_arg0.verticalList:addElement(f3_local0)
	f3_arg0.rowCount = f3_arg0.rowCount + 1
	f3_arg0.playerCount = f3_arg0.playerCount + 1
	if f3_arg1.isLocal == 1 then
		f3_arg0.localPlayerCount = f3_arg0.localPlayerCount + 1
	end
	return f3_local0
end

CoD.PlayerList.AddSearchingRow = function (f4_arg0, f4_arg1)
	local f4_local0 = CoD.PlayerListRow.CreateSearchingRow(f4_arg1)
	f4_arg0.verticalList:addElement(f4_local0)
	f4_arg0.rowCount = f4_arg0.rowCount + 1
	return f4_local0
end

CoD.PlayerList.ClearList = function (f5_arg0)
	f5_arg0.verticalList:removeAllChildren()
end

CoD.PlayerList.SetHighlightedRow = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	if f6_arg0.highlightedPlayerXuid ~= nil and f6_arg0.highlightedPlayerIndex ~= nil then
		if f6_arg1 ~= nil then
			f6_arg1:processEvent({
				name = "gain_focus"
			})
		elseif f6_arg2 ~= nil then
			f6_arg2:processEvent({
				name = "gain_focus"
			})
		elseif f6_arg3 ~= nil then
			f6_arg3:processEvent({
				name = "gain_focus"
			})
		end
	elseif nil ~= firstForcusableRow then
		f6_arg3:processEvent({
			name = "gain_focus"
		})
	end
end

CoD.PlayerList.IsPartyMemberInThisList = function (f7_arg0, f7_arg1, f7_arg2)
	if f7_arg0.teamMask == nil then
		return true
	elseif (f7_arg2 == true or f7_arg0.teamMask == CoD.TEAM_SPECTATOR) and f7_arg1.team == f7_arg0.teamMask then
		return true
	elseif f7_arg2 == false and f7_arg0.teamMask == CoD.TEAM_FREE and f7_arg1.team ~= CoD.TEAM_SPECTATOR then
		return true
	else
		return false
	end
end

CoD.PlayerList.ShowTeams = function ()
	if CoD.isZombie and CoD.Zombie.GAMETYPE_ZCLEANSED == Dvar.ui_gametype:get() then
		return false
	elseif Engine.PartyIsPostGame() == true then
		return true
	elseif Engine.PartyShowTeams() == false then
		return false
	elseif Engine.GetGametypeSetting("autoTeamBalance") == 1 and Engine.PartyIsReadyToStart() ~= true and Engine.PartyHostIsReadyToStart() ~= true then
		return false
	elseif CoD.IsGametypeTeamBased() then
		if CoD.isZombie == true and Engine.GetGametypeSetting("teamCount") == 1 then
			return false
		else
			return true
		end
	else
		return false
	end
end

CoD.PlayerList.Update = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4)
	f9_arg0:clearList()
	f9_arg0.localPlayerCount = 0
	f9_arg0.playerCount = 0
	f9_arg0.rowCount = 0
	if f9_arg0.showStatusRowWhenEmpty ~= true and (f9_arg1 == nil or f9_arg1 ~= nil and #f9_arg1 == 0) then
		f9_arg0:registerAnimationState("default", {
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = false,
			top = 0,
			bottom = 0
		})
		f9_arg0:animateToState("default")
		return 
	end
	local f9_local0 = 0
	if f9_arg2 ~= nil then
		f9_local0 = f9_arg2
	end
	local f9_local1 = 1
	if f9_arg4 ~= true and f9_arg0.showStatusRowWhenEmpty ~= true then
		f9_local1 = 2
	end
	if CoD.MaxPlayerListRows - f9_local1 < f9_local0 then
		f9_arg0:registerAnimationState("default", {
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = false,
			top = 0,
			bottom = 0
		})
		f9_arg0:animateToState("default")
		return 
	elseif f9_arg0.statusRow ~= nil then
		f9_arg0.statusRow:close()
		f9_arg0.statusRow = nil
	end
	if f9_arg4 ~= true then
		f9_arg0.statusRow = f9_arg0:addStatusRow(f9_arg0.statusText)
	end
	local f9_local2 = CoD.PlayerList.ShowTeams()
	local f9_local3 = {}
	local f9_local4, f9_local5 = false
	if f9_arg1 ~= nil then
		local f9_local6 = nil
		for f9_local10, f9_local11 in pairs(f9_arg1) do
			if CoD.PlayerList.IsPartyMemberInThisList(f9_arg0, f9_local11, f9_local2) then
				table.insert(f9_local3, f9_local11)
				if f9_local6 == nil then
					f9_local6 = f9_local11.leagueTeamID
				end
				if f9_local6 == f9_local11.leagueTeamID then
					f9_local4 = true
				else
					f9_local4 = false
				end
			end
		end
		if f9_local4 then
			f9_local5 = f9_local6
		end
	end
	local f9_local6 = f9_local4 == false
	local f9_local7, f9_local8, f9_local9 = nil
	if f9_local3 ~= nil then
		local f9_local10 = nil
		for f9_local14, f9_local15 in ipairs(f9_local3) do
			f9_local10 = f9_arg0:addMemberRow(f9_local15, f9_local2, f9_local6)
			f9_local10.rowIndex = f9_arg0.rowCount
			if f9_local15.xuid == f9_arg0.highlightedPlayerXuid then
				f9_local7 = f9_local10
			end
			if f9_arg0.highlightedPlayerIndex ~= nil and f9_local14 == f9_arg0.highlightedPlayerIndex - 1 then
				f9_local8 = f9_local10
			end
			if f9_local9 == nil and f9_local10.m_focusable then
				f9_local9 = f9_local10
			end
			if f9_local0 + f9_arg0.rowCount == CoD.MaxPlayerListRows then
				break
			end
		end
	end
	if f9_arg4 ~= true and f9_arg0.rowCount == 1 and f9_arg0.showStatusRowWhenEmpty ~= true then
		f9_arg0.statusRow:close()
		f9_arg0.statusRow = nil
		f9_arg0.rowCount = f9_arg0.rowCount - 1
	end
	local f9_local10 = false
	if f9_arg0.rowCount > 2 then
		if f9_local5 then
			f9_arg0.backgroundIcon:setupLeagueEmblem(f9_local5)
			f9_local10 = true
		elseif f9_local2 and f9_arg0.teamMask then
			local f9_local11 = Engine.GetFactionForTeam(f9_arg0.teamMask)
			if f9_local11 and f9_local11 ~= "free" and f9_local11 ~= "" then
				f9_arg0.backgroundIcon:setImage(RegisterMaterial("faction_" .. f9_local11))
				f9_local10 = true
			end
		end
	end
	if f9_local10 then
		f9_arg0.stencilContainer:addElement(f9_arg0.backgroundIcon)
	else
		f9_arg0.backgroundIcon:close()
	end
	local f9_local11 = CoD.PlayerListRow.Height * f9_local0
	f9_arg0:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f9_local11,
		bottom = f9_local11 + CoD.PlayerListRow.Height * f9_arg0.rowCount
	})
	f9_arg0:animateToState("default")
	if f9_local6 == false then
		local f9_local13 = nil
		if f9_local3[1].rankIcon ~= nil then
			f9_local13 = f9_local3[1].rankIcon
		end
		if f9_local13 ~= nil then
			local f9_local14 = CoD.PlayerListRow.LeagueRankAreaWidth
			local f9_local15 = CoD.PlayerListRow.Height * #f9_local3
			if f9_local15 < f9_local14 then
				if f9_local15 < 64 then
					f9_local14 = 32
				else
					f9_local14 = 64
				end
			end
			if f9_arg0.leagueTeamRankIcon == nil then
				f9_arg0.leagueTeamRankIcon = LUI.UIImage.new()
				f9_arg0:addElement(f9_arg0.leagueTeamRankIcon)
			end
			f9_arg0.leagueTeamRankIcon:beginAnimation("default")
			f9_arg0.leagueTeamRankIcon:setLeftRight(false, true, -CoD.PlayerListRow.LeagueRankAreaWidth / 2 - f9_local14 / 2, -CoD.PlayerListRow.LeagueRankAreaWidth / 2 + f9_local14 / 2)
			f9_arg0.leagueTeamRankIcon:setTopBottom(false, false, -f9_local14 / 2, f9_local14 / 2)
			f9_arg0.leagueTeamRankIcon:setImage(f9_local13)
		elseif f9_arg0.leagueTeamRankIcon ~= nil then
			f9_arg0.leagueTeamRankIcon:close()
			f9_arg0.leagueTeamRankIcon = nil
		end
	elseif f9_arg0.leagueTeamRankIcon ~= nil then
		f9_arg0.leagueTeamRankIcon:close()
		f9_arg0.leagueTeamRankIcon = nil
	end
	if f9_arg3 == true then
		f9_arg0:setHighlightedRow(f9_local7, f9_local8, f9_local9)
	end
end

CoD.PlayerList.IsXuidInList = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg0.verticalList:getFirstChild()
	while f10_local0 ~= nil do
		if f10_local0.playerXuid == f10_arg1 then
			return true
		end
		f10_local0 = f10_local0:getNextSibling()
	end
	return false
end

CoD.PlayerList.SetFocusByXuid = function (f11_arg0, f11_arg1)
	local f11_local0 = f11_arg0.verticalList:getFirstChild()
	while f11_local0 ~= nil do
		if f11_local0.m_focusable and f11_local0.playerXuid == f11_arg1 then
			f11_local0:processEvent({
				name = "gain_focus"
			})
			return true
		end
		f11_local0 = f11_local0:getNextSibling()
	end
	return false
end

CoD.PlayerList.SetFocusByIndex = function (f12_arg0, f12_arg1)
	local f12_local0 = f12_arg0.verticalList:getFirstChild()
	local f12_local1 = 1
	while f12_local0 ~= nil do
		if f12_local0.m_focusable then
			if f12_local1 == f12_arg1 then
				f12_local0:processEvent({
					name = "gain_focus"
				})
				return true
			end
			f12_local1 = f12_local1 + 1
		end
		f12_local0 = f12_local0:getNextSibling()
	end
	return false
end

CoD.PlayerList.PlayerListRowSelected = function (f13_arg0, f13_arg1)
	f13_arg0:dispatchEventToParent(f13_arg1)
	f13_arg0.highlightedPlayerXuid = f13_arg1.playerXuid
	f13_arg0.highlightedPlayerIndex = f13_arg1.listIndex
	Dvar.selectedPlayerXuid:set(f13_arg1.playerXuid)
end

CoD.PlayerList.PlayerListRowDeselected = function (f14_arg0, f14_arg1)
	f14_arg0:dispatchEventToParent(f14_arg1)
	if f14_arg1.playerXuid == f14_arg0.highlightedPlayerXuid then
		f14_arg0.highlightedPlayerXuid = nil
		f14_arg0.highlightedPlayerIndex = nil
	end
end

CoD.PlayerList.GetRowCount = function (f15_arg0)
	if f15_arg0.rowCount == nil then
		return 0
	else
		return f15_arg0.rowCount
	end
end

CoD.PlayerList.GetPlayerCount = function (f16_arg0)
	if f16_arg0.playerCount == nil then
		return 0
	else
		return f16_arg0.playerCount
	end
end

CoD.PlayerList.GetLocalPlayerCount = function (f17_arg0)
	if f17_arg0.localPlayerCount == nil then
		return 0
	else
		return f17_arg0.localPlayerCount
	end
end

CoD.PlayerList.New = function (f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4, f18_arg5, f18_arg6)
	local Widget = LUI.UIElement.new(f18_arg0)
	Widget:makeFocusable()
	Widget.stencilContainer = LUI.UIContainer.new()
	Widget.stencilContainer:setUseStencil(true)
	Widget.stencilContainer:setPriority(-10)
	Widget:addElement(Widget.stencilContainer)
	local f18_local1 = 128
	local f18_local2 = 0
	Widget.backgroundIcon = LUI.UIImage.new()
	Widget.backgroundIcon:setLeftRight(false, false, f18_local2 - f18_local1 / 2, f18_local2 + f18_local1 / 2)
	Widget.backgroundIcon:setTopBottom(false, false, -f18_local1 / 2, f18_local1 / 2)
	Widget.backgroundIcon:setAlpha(0.15)
	Widget.backgroundIcon:setPriority(-10)
	Widget.verticalList = LUI.UIVerticalList.new()
	Widget.verticalList:setLeftRight(true, true, 0, 0)
	Widget.verticalList:setTopBottom(true, true, 0, 0)
	Widget.verticalList:makeFocusable()
	Widget:addElement(Widget.verticalList)
	Widget.localPlayerCount = 0
	Widget.playerCount = 0
	Widget.rowCount = 0
	Widget.teamMask = f18_arg5
	Widget.showMissingDLC = f18_arg6
	Widget.showVoipIcons = Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) ~= true
	Widget.showStatusRowWhenEmpty = f18_arg1
	Widget.statusText = f18_arg2
	Widget.id = f18_arg4 .. "." .. f18_arg3
	if f18_arg5 ~= nil then
		Widget.id = Widget.id .. "." .. f18_arg5
	end
	Widget.addStatusRow = CoD.PlayerList.AddStatusRow
	Widget.addMissingTeamMemberRow = CoD.PlayerList.AddMissingTeamMemberRow
	Widget.addSearchingRow = CoD.PlayerList.AddSearchingRow
	Widget.addMemberRow = CoD.PlayerList.AddMemberRow
	Widget.clearList = CoD.PlayerList.ClearList
	Widget.update = CoD.PlayerList.Update
	Widget.setHighlightedRow = CoD.PlayerList.SetHighlightedRow
	Widget.getRowCount = CoD.PlayerList.GetRowCount
	Widget.getPlayerCount = CoD.PlayerList.GetPlayerCount
	Widget.getLocalPlayerCount = CoD.PlayerList.GetLocalPlayerCount
	Widget:registerEventHandler("playerlist_row_selected", CoD.PlayerList.PlayerListRowSelected)
	Widget:registerEventHandler("playerlist_row_deselected", CoD.PlayerList.PlayerListRowDeselected)
	return Widget
end

