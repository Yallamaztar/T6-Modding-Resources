CoD.ConfirmOverwritePopup = {}
LUI.createMenu.ConfirmOverwritePopup = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("ConfirmOverwritePopup")
	f1_local0:registerEventHandler("overwrite_campaign", CoD.ConfirmOverwritePopup.OverwriteCampaign)
	f1_local0:registerEventHandler("cancel_request", CoD.ConfirmOverwritePopup.CancelRequest)
	local f1_local1 = "Default"
	local f1_local2 = 0
	f1_local0.title = LUI.UIText.new()
	f1_local0.title:setLeftRight(true, true, 0, 0)
	f1_local0.title:setTopBottom(true, false, f1_local2, f1_local2 + CoD.textSize[f1_local1])
	f1_local0.title:setAlignment(LUI.Alignment.Left)
	f1_local0.title:setFont(CoD.fonts[f1_local1])
	f1_local0.title:setText(Engine.Localize("MENU_CONFIRMOVERWRITE_Q_CAPS"))
	f1_local0:addElement(f1_local0.title)
	local f1_local3 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 2 - 21,
		bottom = -15
	})
	f1_local0:addElement(f1_local3)
	local f1_local4 = f1_local3:addButton(Engine.Localize("MENU_NO_CAPS"))
	f1_local4:setActionEventName("cancel_request")
	local f1_local5 = f1_local3:addButton(Engine.Localize("MENU_YES_CAPS"))
	f1_local5:setActionEventName("overwrite_campaign")
	f1_local4:processEvent({
		name = "gain_focus"
	})
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	return f1_local0
end

CoD.ConfirmOverwritePopup.OverwriteCampaign = function (f2_arg0, f2_arg1)
	f2_arg0:openMenu("DifficultyMenu", f2_arg1.controller)
	Dvar.ui_campaignstate:set(1)
	Engine.ExecNow(f2_arg1.controller, "new_campaign")
	f2_arg0:close()
end

CoD.ConfirmOverwritePopup.CancelRequest = function (f3_arg0, f3_arg1)
	f3_arg0:openMenu("CampaignMenu", f3_arg1.controller)
	f3_arg0:close()
end

