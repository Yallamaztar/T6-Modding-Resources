CoD.CRMiniFriendsList = {}
CoD.CRMiniFriendsList.MiniFriendsListWidth = 430
CoD.CRMiniFriendsList.MiniFriendsListHeight = 550
CoD.CRMiniFriendsList.MiniFriendsListMode = CoD.playerListType.friend
CoD.CRMiniFriendsList.FriendsListButtonCreator = function (f1_arg0, f1_arg1)
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
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f1_local3, 0)
	Widget:setTopBottom(false, false, -f1_local3 / 2, f1_local3 / 2)
	local f1_local9 = CoD.CRCommon.GetStretchedImage()
	f1_arg1.rankIcon = f1_local9
	Widget:addElement(f1_local9)
	local f1_local10 = CoD.CRCommon.GetTextElem("ExtraSmall", "Left")
	f1_local10:setTopBottom(false, true, -CoD.textSize.ExtraSmall, 0)
	f1_arg1.rankTextElem = f1_local10
	Widget:addElement(f1_local10)
	Widget:addElement(Widget)
	f1_arg1:addElement(Widget)
end

CoD.CRMiniFriendsList.FriendsListButtonData = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = Engine.GetPlayerInfoByIndex(f2_arg0, f2_arg1 - 1, CoD.CRMiniFriendsList.MiniFriendsListMode)
	if f2_local0 ~= nil then
		f2_arg2.playerXuid = f2_local0.xuid
		f2_arg2.playerName = f2_local0.name
		f2_arg2.playerNameTextElem:setText(f2_arg2.playerName)
		f2_arg2.playerRank = f2_local0.rank
		f2_arg2.rankTextElem:setText(f2_arg2.playerRank)
		f2_arg2.playerRankIcon = f2_local0.rankIcon
		f2_arg2.rankIcon:setImage(RegisterMaterial(f2_arg2.playerRankIcon))
		if f2_arg2.playerRank == "0" then
			f2_arg2.rankTextElem:hide()
			f2_arg2.rankIcon:hide()
		end
		f2_arg2.emblem:setupPlayerEmblemByXUID(f2_arg2.playerXuid)
	end
end

CoD.CRMiniFriendsList.SetupMiniFriendsList = function (f3_arg0, f3_arg1)
	f3_arg0.m_ownerController = f3_arg1
	local f3_local0 = 20
	local f3_local1 = CoD.CRCommon.GetTextElem("Big", "Left", Engine.Localize("MENU_CHOOSE_FRIEND"), nil, f3_local0)
	f3_local1:setLeftRight(true, true, 20, 0)
	f3_arg0:addElement(f3_local1)
	local f3_local2 = CoD.CoD9Button.Height * 2
	local f3_local3 = 400
	f3_local0 = f3_local0 + CoD.textSize.Big + 20
	local f3_local4 = 20
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f3_local3 / 2, f3_local3 / 2)
	Widget:setTopBottom(true, true, f3_local0, 0)
	local f3_local6 = CoD.ListBox.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}, f3_arg1, 6, f3_local2, f3_local3, CoD.CRMiniFriendsList.FriendsListButtonCreator, CoD.CRMiniFriendsList.FriendsListButtonData, 0)
	f3_local6.noDataText = Engine.Localize("MPUI_NO_FRIENDS")
	f3_local6:setTotalItems(Engine.GetPlayerCount(f3_arg0.m_ownerController, CoD.CRMiniFriendsList.MiniFriendsListMode))
	f3_arg0.listBox = f3_local6
	Widget:addElement(f3_local6)
	f3_arg0:addElement(Widget)
end

CoD.CRMiniFriendsList.RefreshList = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.listBox:getFocussedMutables()
	local f4_local1 = {
		index = 1
	}
	local f4_local2 = {}
	f4_local2 = CoD.CRMiniFriendsList.MiniFriendsListMode
	if f4_arg0.listBox then
		if f4_local0 ~= nil and f4_local0.playerXuid ~= nil and f4_local0.playerXuid ~= 0 then
			f4_local1 = Engine.GetPlayerIndexByXuid(f4_arg0, f4_local0.playerXuid, f4_local2)
			f4_local1.index = f4_local1.index + 1
		end
		f4_arg0.listBox:setTotalItems(Engine.GetPlayerCount(f4_arg0.m_ownerController, f4_local2), f4_local1.index)
		f4_arg0.listBox:refresh()
	end
end

CoD.CRMiniFriendsList.MiniFriendsButtonAction = function (f5_arg0, f5_arg1)
	if f5_arg1 and f5_arg1.mutables then
		local f5_local0 = f5_arg1.mutables.playerXuid
		if f5_local0 then
			if UIExpression.GetPrestigeByXUID(f5_arg1.controller, f5_local0) == 0 and UIExpression.GetRankByXUID(f5_arg1.controller, f5_local0) < UIExpression.GetItemUnlockLevel(f5_arg1.controller, UIExpression.GetItemIndex(f5_arg1.controller, "FEATURE_COMBAT_RECORD")) then
				f5_arg0:openPopup("CombatRecordLockedForFriend", f5_arg1.controller, f5_arg1.mutables.playerName)
			else
				Engine.Exec(f5_arg1.controller, "getServiceRecord " .. f5_local0)
				CoD.CRCommon.ComparedXuid = f5_local0
				CoD.CRCommon.ComparedPlayerName = f5_arg1.mutables.playerName
			end
		end
	end
end

CoD.CRMiniFriendsList.FriendsStatsFetched = function (f6_arg0, f6_arg1)
	f6_arg0:processEvent({
		name = "button_prompt_back"
	})
end

LUI.createMenu.CRMiniFriendsList = function (f7_arg0)
	local f7_local0 = CoD.Menu.NewSmallPopup("CRMiniFriendsList", nil, nil, CoD.CRMiniFriendsList.MiniFriendsListWidth, CoD.CRMiniFriendsList.MiniFriendsListHeight)
	f7_local0:setOwner(f7_arg0)
	if Engine.GetPlayerCount(f7_local0.m_ownerController, CoD.CRMiniFriendsList.MiniFriendsListMode) > 0 then
		f7_local0:addSelectButton()
	end
	f7_local0:addBackButton()
	CoD.CRMiniFriendsList.SetupMiniFriendsList(f7_local0, f7_arg0)
	f7_local0:registerEventHandler("friends_updated", CoD.CRMiniFriendsList.RefreshList)
	f7_local0:registerEventHandler("click", CoD.CRMiniFriendsList.MiniFriendsButtonAction)
	f7_local0:registerEventHandler("service_record_fetched", CoD.CRMiniFriendsList.FriendsStatsFetched)
	Engine.PlaySound("cac_loadout_edit_sel")
	return f7_local0
end

LUI.createMenu.CombatRecordLockedForFriend = function (f8_arg0, f8_arg1)
	local f8_local0 = CoD.Popup.SetupPopup("CombatRecordLockedForFriend", f8_arg0)
	f8_local0:addBackButton()
	f8_local0.title:setText(Engine.Localize("MENU_NOTICE_CAPS"))
	if f8_arg1 then
		f8_local0.msg:setText(Engine.Localize("MPUI_COMBAT_RECORD_LOCKED_FOR_FRIEND", f8_arg1))
	end
	return f8_local0
end

