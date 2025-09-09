CoD.RejoinSessionPopup = {}
LUI.createMenu.RejoinSessionPopup = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("RejoinSessionPopup")
	f1_local0:addBackButton()
	f1_local0:addSelectButton()
	f1_local0:registerEventHandler("button_yes", CoD.RejoinSessionPopup.Button_Yes)
	f1_local0:registerEventHandler("button_no", CoD.RejoinSessionPopup.Button_No)
	local f1_local1 = 5
	local f1_local2 = LUI.UIText.new()
	f1_local2:setLeftRight(true, true, 0, 0)
	f1_local2:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize.Condensed)
	f1_local2:setFont(CoD.fonts.Condensed)
	f1_local2:setAlignment(LUI.Alignment.Left)
	f1_local2:setText(Engine.Localize("MENU_REJOIN_SESSION"))
	f1_local0:addElement(f1_local2)
	local f1_local3 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	f1_local0:addElement(f1_local3)
	f1_local0.yesButton = f1_local3:addButton(Engine.Localize("MENU_YES"))
	f1_local0.yesButton:setActionEventName("button_yes")
	f1_local0.noButton = f1_local3:addButton(Engine.Localize("MENU_NO"))
	f1_local0.noButton:setActionEventName("button_no")
	f1_local0.noButton:processEvent({
		name = "gain_focus"
	})
	return f1_local0
end

CoD.RejoinSessionPopup.Button_Yes = function (f2_arg0, f2_arg1)
	Engine.Exec(f2_arg1.controller, "session_rejoinsession " .. CoD.SESSION_REJOIN_JOIN_SESSION)
	f2_arg0:goBack()
end

CoD.RejoinSessionPopup.Button_No = function (f3_arg0, f3_arg1)
	Engine.Exec(f3_arg1.controller, "session_rejoinsession " .. CoD.SESSION_REJOIN_CANCEL_JOIN_SESSION)
	f3_arg0:goBack()
end

