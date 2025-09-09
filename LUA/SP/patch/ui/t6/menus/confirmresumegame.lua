require("T6.Menus.ConfirmLeaveCampaign")
CoD.ConfirmResumeGame = {}
LUI.createMenu.ConfirmResumeGame = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("ConfirmResumeGame")
	local f1_local1 = "Big"
	local f1_local2 = 0
	f1_local0:registerEventHandler("frontend_restore", CoD.ConfirmResumeGame.FrontendResumeGame)
	f1_local0:registerEventHandler("frontend_restore2", CoD.ConfirmResumeGame.FrontendResumeGame2)
	f1_local0:registerEventHandler("resume_game", CoD.ConfirmResumeGame.ResumeGame)
	f1_local0:registerEventHandler("cancel_request", CoD.ConfirmResumeGame.CancelRequest)
	f1_local0:registerAnimationState("hide", {
		alpha = 0
	})
	f1_local0.title = LUI.UIText.new()
	f1_local0.title:setLeftRight(true, true, 0, 0)
	f1_local0.title:setTopBottom(true, false, f1_local2, f1_local2 + CoD.textSize[f1_local1] * 0.75)
	f1_local0.title:setAlignment(LUI.Alignment.Left)
	f1_local0.title:setFont(CoD.fonts[f1_local1])
	f1_local0.title:setText(Engine.Localize("MENU_RESUMESTORY_Q_CAPS"))
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
	local f1_local4 = f1_local3:addButton(Engine.Localize("MENU_YES_CAPS"))
	f1_local4:setActionEventName("resume_game")
	local f1_local5 = f1_local3:addButton(Engine.Localize("MENU_NO_CAPS"))
	f1_local5:setActionEventName("cancel_request")
	f1_local4:processEvent({
		name = "gain_focus"
	})
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	return f1_local0
end

CoD.ConfirmResumeGame.ResumeGame = function (f2_arg0, f2_arg1)
	Engine.Exec(f2_arg1.controller, "loadgame_continue")
	f2_arg0.m_inputDisabled = true
end

CoD.ConfirmResumeGame.FrontendResumeGame = function (f3_arg0, f3_arg1)
	Engine.ExecNow(f3_arg1.controller, "update_mapname_from_stats")
	Dvar.ui_campaignstate:set(1)
	Engine.SendMenuResponse(f3_arg1.controller, "campaign_state", "start")
end

CoD.ConfirmResumeGame.FrontendResumeGame2 = function (f4_arg0, f4_arg1)
	CoD.Menu.newStrikeForceAvailable = f4_arg1.data[1]
	CoD.CACLoadOutMenu.RestoreDefaults()
	local f4_local0 = f4_arg0:openMenu("CampaignMissionBriefingMenu", f4_arg1.controller)
	f4_arg0:close()
end

CoD.ConfirmResumeGame.CancelRequest = function (f5_arg0, f5_arg1)
	f5_arg0:goBack(f5_arg1.controller)
end

