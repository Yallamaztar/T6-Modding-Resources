CoD.LeagueMemberList = {}
CoD.LeagueMemberList.LeagueMemberListWidth = 430
CoD.LeagueMemberList.LeagueMemberListHeight = 550
CoD.LeagueMemberList.LeagueMemberListButtonCreator = function (f1_arg0, f1_arg1)
	local f1_local0 = 8
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f1_local0, -f1_local0)
	Widget:setTopBottom(true, true, f1_local0, -f1_local0)
	local f1_local2 = 0
	local f1_local3 = 40
	local f1_local4 = LUI.UIImage.new()
	f1_local4:setLeftRight(true, false, f1_local2, f1_local2 + f1_local3)
	f1_local4:setTopBottom(false, false, -f1_local3 / 2, f1_local3 / 2)
	f1_arg1.emblem = f1_local4
	Widget:addElement(f1_local4)
	f1_local2 = f1_local2 + f1_local3 + 5
	local f1_local5 = "Default"
	local f1_local6 = CoD.textSize[f1_local5]
	local f1_local7 = CoD.CRCommon.GetTextElem(f1_local5, "Left")
	f1_local7:setLeftRight(true, true, f1_local2, 0)
	f1_local7:setTopBottom(false, false, -f1_local6 / 2, f1_local6 / 2)
	f1_arg1.playerNameTextElem = f1_local7
	Widget:addElement(f1_local7)
	f1_arg1:addElement(Widget)
end

CoD.LeagueMemberList.LeagueMemberListButtonData = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = CoD.LeaguesData.CurrentTeamInfo.teamMemberInfo.members[f2_arg1]
	if f2_local0 ~= nil then
		f2_arg2.playerXuid = f2_local0.xuid
		f2_arg2.playerName = f2_local0.userName
		f2_arg2.playerNameTextElem:setText(f2_arg2.playerName)
		f2_arg2.emblem:setupPlayerEmblemByXUID(f2_arg2.playerXuid)
	end
end

CoD.LeagueMemberList.SetupLeagueMemberList = function (f3_arg0, f3_arg1)
	local f3_local0 = CoD.LeaguesData.CurrentTeamInfo.teamMemberInfo
	f3_arg0.m_ownerController = f3_arg1
	local f3_local1 = 20
	local f3_local2 = CoD.CRCommon.GetTextElem("Big", "Left", Engine.Localize("MENU_VIEW_TEAMMATE_PLAYERCARD"), nil, f3_local1)
	f3_local2:setLeftRight(true, true, 20, 0)
	f3_arg0:addElement(f3_local2)
	local f3_local3 = CoD.CoD9Button.Height * 2
	local f3_local4 = 400
	f3_local1 = f3_local1 + CoD.textSize.Big + 20
	local f3_local5 = 20
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f3_local4 / 2, f3_local4 / 2)
	Widget:setTopBottom(true, true, f3_local1, 0)
	local f3_local7 = CoD.ListBox.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}, f3_arg1, 6, f3_local3, f3_local4, CoD.LeagueMemberList.LeagueMemberListButtonCreator, CoD.LeagueMemberList.LeagueMemberListButtonData, 0)
	f3_local7.noDataText = Engine.Localize("MPUI_NO_FRIENDS")
	f3_local7:setTotalItems(f3_local0.numMembers)
	f3_arg0.listBox = f3_local7
	Widget:addElement(f3_local7)
	f3_arg0:addElement(Widget)
end

CoD.LeagueMemberList.RefreshList = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.listBox:getFocussedMutables()
	local f4_local1 = {
		index = 1
	}
	local f4_local2 = {}
	f4_local2 = CoD.LeagueMemberList.LeagueMemberListMode
	if f4_arg0.listBox then
		if f4_local0 ~= nil and f4_local0.playerXuid ~= nil and f4_local0.playerXuid ~= 0 then
			f4_local1 = Engine.GetPlayerIndexByXuid(f4_arg0, f4_local0.playerXuid, f4_local2)
			f4_local1.index = f4_local1.index + 1
		end
		f4_arg0.listBox:setTotalItems(Engine.GetPlayerCount(f4_arg0.m_ownerController, f4_local2), f4_local1.index)
		f4_arg0.listBox:refresh()
	end
end

CoD.LeagueMemberList.ButtonAction = function (f5_arg0, f5_arg1)
	if f5_arg1 and f5_arg1.mutables then
		CoD.FriendPopup.SelectedPlayerXuid = f5_arg1.mutables.playerXuid
		CoD.FriendPopup.SelectedPlayerName = f5_arg1.mutables.playerName
		CoD.FriendPopup.LeagueMemberSelected = true
		f5_arg0:openPopup("FriendPopup", f5_arg1.controller)
	end
end

CoD.LeagueMemberList.FriendsStatsFetched = function (f6_arg0, f6_arg1)
	f6_arg0:processEvent({
		name = "button_prompt_back"
	})
end

LUI.createMenu.LeagueMemberList = function (f7_arg0)
	local f7_local0 = CoD.Menu.NewSmallPopup("LeagueMemberList", nil, nil, CoD.LeagueMemberList.LeagueMemberListWidth, CoD.LeagueMemberList.LeagueMemberListHeight)
	f7_local0:setOwner(f7_arg0)
	f7_local0:addBackButton()
	f7_local0:addSelectButton()
	CoD.LeagueMemberList.SetupLeagueMemberList(f7_local0, f7_arg0)
	f7_local0:registerEventHandler("click", CoD.LeagueMemberList.ButtonAction)
	return f7_local0
end

