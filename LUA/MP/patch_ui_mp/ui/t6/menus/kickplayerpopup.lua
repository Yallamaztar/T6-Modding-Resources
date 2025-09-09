CoD.KickPlayerPopup = {}
CoD.KickPlayerPopup.Button_Yes = function (f1_arg0, f1_arg1)
	if UIExpression.IsInGame() == 1 then
		Engine.Exec(f1_arg1.controller, "kickplayer_ingame " .. f1_arg0.selectedPlayerXuid)
	else
		Engine.Exec(f1_arg1.controller, "kickplayer " .. f1_arg0.selectedPlayerXuid)
	end
	f1_arg0:processEvent({
		name = "closeallpopups",
		controller = f1_arg1.controller
	})
end

LUI.createMenu.KickPlayerPopup = function (f2_arg0)
	local f2_local0 = CoD.Menu.NewSmallPopup("KickPlayerPopup")
	f2_local0:addTitle(Engine.Localize("MPUI_KICK_PLAYER"))
	f2_local0:addSelectButton()
	f2_local0:addBackButton()
	f2_local0:registerEventHandler("closeallpopups", CoD.FriendPopup.Close)
	f2_local0.selectedPlayerXuid = CoD.FriendPopup.SelectedPlayerXuid
	f2_local0.selectedPlayerName = CoD.FriendPopup.SelectedPlayerName
	local f2_local1 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	f2_local0:addElement(f2_local1)
	f2_local0.yesButton = f2_local1:addButton(Engine.Localize("MENU_YES"))
	f2_local0.yesButton:setActionEventName("kickplayer_yes")
	f2_local0:registerEventHandler("kickplayer_yes", CoD.KickPlayerPopup.Button_Yes)
	f2_local0.noButton = f2_local1:addButton(Engine.Localize("MENU_NO"))
	f2_local0.noButton:setActionEventName("kickplayer_no")
	f2_local0:registerEventHandler("kickplayer_no", f2_local0.goBack)
	f2_local0.noButton:processEvent({
		name = "gain_focus"
	})
	return f2_local0
end

