CoD.GameInvitePopup = {}
CoD.GameInvitePopup.SelectedPlayerXuid = nil
CoD.GameInvitePopup.SelectedPlayerName = nil
CoD.GameInvitePopup.Button_Accept = function (f1_arg0, f1_arg1)
	if f1_arg0.selectedPlayerXuid ~= nil then
		CoD.acceptGameInvite(f1_arg1.controller, f1_arg0.selectedPlayerXuid)
		if not CoD.isSinglePlayer then
			f1_arg0:processEvent({
				name = "closeallpopups",
				controller = f1_arg1.controller
			})
		end
	else
		f1_arg0:goBack(f1_arg1.controller)
	end
end

CoD.GameInvitePopup.Button_Cancel = function (f2_arg0, f2_arg1)
	f2_arg0:goBack(f2_arg1.controller)
end

CoD.GameInvitePopup.Close = function (f3_arg0, f3_arg1)
	if f3_arg0.m_inputDisabled == nil then
		f3_arg0:goBack(f3_arg1.controller)
		if f3_arg0.occludedMenu ~= nil then
			f3_arg0.occludedMenu:processEvent({
				name = "closeallpopups",
				controller = f3_arg1.controller
			})
		end
	end
end

LUI.createMenu.GameInvitePopup = function (f4_arg0)
	local f4_local0 = CoD.Menu.NewSmallPopup("GameInvitePopup")
	f4_local0:registerEventHandler("closeallpopups", CoD.GameInvitePopup.Close)
	f4_local0.m_ownerController = f4_arg0
	f4_local0.selectedPlayerXuid = CoD.GameInvitePopup.SelectedPlayerXuid
	f4_local0.selectedPlayerName = CoD.GameInvitePopup.SelectedPlayerName
	f4_local0:addSelectButton()
	local f4_local1 = 5
	local f4_local2 = LUI.UIText.new()
	f4_local2:setLeftRight(true, true, 0, 0)
	f4_local2:setTopBottom(true, false, f4_local1, f4_local1 + CoD.textSize.Default)
	f4_local2:setFont(CoD.fonts.Default)
	f4_local2:setAlignment(LUI.Alignment.Left)
	f4_local2:setText(Engine.Localize("MENU_GAMEINVITE") .. " " .. f4_local0.selectedPlayerName)
	f4_local0:addElement(f4_local2)
	local f4_local3 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 200,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	f4_local0:addElement(f4_local3)
	f4_local0.acceptButton = f4_local3:addButton(Engine.Localize("MENU_ACCEPT"))
	f4_local0.acceptButton:setActionEventName("accept_invite")
	f4_local0:registerEventHandler("accept_invite", CoD.GameInvitePopup.Button_Accept)
	f4_local0.acceptButton = f4_local3:addButton(Engine.Localize("MENU_CANCEL"))
	f4_local0.acceptButton:setActionEventName("cancel_invite")
	f4_local0:registerEventHandler("cancel_invite", CoD.GameInvitePopup.Button_Cancel)
	f4_local0.acceptButton:processEvent({
		name = "gain_focus"
	})
	Engine.PlaySound("cac_loadout_edit_sel")
	return f4_local0
end

CoD.FriendRequestPopup = {}
CoD.FriendRequestPopup.SelectedPlayerXuid = nil
CoD.FriendRequestPopup.SelectedPlayerName = nil
CoD.FriendRequestPopup.Button_Accept = function (f5_arg0, f5_arg1)
	if f5_arg0.selectedPlayerXuid ~= nil and f5_arg0.selectedPlayerName ~= nil then
		CoD.acceptFriendRequest(f5_arg1.controller, f5_arg0.selectedPlayerXuid, f5_arg0.selectedPlayerName)
	end
	f5_arg0:goBack(f5_arg1.controller)
end

CoD.FriendRequestPopup.Button_Cancel = function (f6_arg0, f6_arg1)
	f6_arg0:goBack(f6_arg1.controller)
end

CoD.FriendRequestPopup.Close = function (f7_arg0, f7_arg1)
	if f7_arg0.m_inputDisabled == nil then
		f7_arg0:goBack(f7_arg1.controller)
		if f7_arg0.occludedMenu ~= nil then
			f7_arg0.occludedMenu:processEvent({
				name = "closeallpopups",
				controller = f7_arg1.controller
			})
		end
	end
end

LUI.createMenu.FriendRequestPopup = function (f8_arg0)
	local f8_local0 = CoD.Menu.NewSmallPopup("FriendRequestPopup")
	f8_local0:registerEventHandler("closeallpopups", CoD.FriendRequestPopup.Close)
	f8_local0.m_ownerController = f8_arg0
	f8_local0.selectedPlayerXuid = CoD.FriendRequestPopup.SelectedPlayerXuid
	f8_local0.selectedPlayerName = CoD.FriendRequestPopup.SelectedPlayerName
	f8_local0:addSelectButton()
	local f8_local1 = 5
	local f8_local2 = LUI.UIText.new()
	f8_local2:setLeftRight(true, true, 0, 0)
	f8_local2:setTopBottom(true, false, f8_local1, f8_local1 + CoD.textSize.Default)
	f8_local2:setFont(CoD.fonts.Default)
	f8_local2:setAlignment(LUI.Alignment.Left)
	f8_local2:setText(Engine.Localize("PLATFORM_FRIEND_REQUEST") .. " " .. f8_local0.selectedPlayerName)
	f8_local0:addElement(f8_local2)
	local f8_local3 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 200,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	f8_local0:addElement(f8_local3)
	f8_local0.acceptButton = f8_local3:addButton(Engine.Localize("MENU_ACCEPT"))
	f8_local0.acceptButton:setActionEventName("accept_invite")
	f8_local0:registerEventHandler("accept_invite", CoD.FriendRequestPopup.Button_Accept)
	f8_local0.acceptButton = f8_local3:addButton(Engine.Localize("MENU_CANCEL"))
	f8_local0.acceptButton:setActionEventName("cancel_invite")
	f8_local0:registerEventHandler("cancel_invite", CoD.FriendRequestPopup.Button_Cancel)
	f8_local0.acceptButton:processEvent({
		name = "gain_focus"
	})
	Engine.PlaySound("cac_loadout_edit_sel")
	return f8_local0
end

