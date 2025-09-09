require("T6.SPBinaryChoice")
CoD.ConfirmChangeHistory = {}
CoD.ConfirmChangeHistory.ButtonPromptBack = function (f1_arg0, f1_arg1)
	f1_arg0:returnToPreviousMenu(f1_arg1.controller)
	f1_arg0:close()
end

LUI.createMenu.ConfirmChangeHistory = function (f2_arg0, f2_arg1)
	local f2_local0 = CoD.Menu.NewSmallPopup("ConfirmChangeHistory")
	f2_local0:setPreviousMenu("MissionSelectMenu")
	local f2_local1 = "Default"
	local f2_local2 = 0
	f2_local0:registerEventHandler("change_history", CoD.ConfirmChangeHistory.ChangeHistory)
	f2_local0:registerEventHandler("cancel_request", CoD.ConfirmChangeHistory.CancelRequest)
	f2_local0:registerEventHandler("button_prompt_back", CoD.ConfirmChangeHistory.ButtonPromptBack)
	f2_local0.targetLevel = f2_arg1
	f2_local0.title = LUI.UIText.new()
	f2_local0.title:setLeftRight(true, true, 0, 0)
	f2_local0.title:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize[f2_local1])
	f2_local0.title:setAlignment(LUI.Alignment.Left)
	f2_local0.title:setFont(CoD.fonts[f2_local1])
	f2_local0.title:setText(Engine.Localize("MENU_CHANGEHISTORY_Q_CAPS"))
	f2_local0:addElement(f2_local0.title)
	local f2_local3 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 2 - 21,
		bottom = -15
	})
	f2_local0:addElement(f2_local3)
	local f2_local4 = f2_local3:addButton(Engine.Localize("MENU_NO_CAPS"))
	f2_local4:setActionEventName("cancel_request")
	local f2_local5 = f2_local3:addButton(Engine.Localize("MENU_YES_CAPS"))
	f2_local5:setActionEventName("change_history")
	f2_local4:processEvent({
		name = "gain_focus"
	})
	f2_local0:addSelectButton()
	f2_local0:addBackButton()
	return f2_local0
end

CoD.ConfirmChangeHistory.ChangeHistory = function (f3_arg0, f3_arg1)
	if f3_arg0.targetLevel ~= nil then
		CoD.Unlockables.RollbackToLevel(f3_arg0.targetLevel)
		Dvar.ui_singlemission:set(0)
		Engine.ChangeHistory(f3_arg1.controller, f3_arg0.targetLevel)
		Engine.Exec(f3_arg1.controller, "savegame")
		Dvar.ui_mapname:set(f3_arg0.targetLevel)
		Dvar.ui_campaignstate:set(1)
		Engine.SendMenuResponse(f3_arg1.controller, "campaign_state", "start")
		CoD.CACLoadOutMenu.RestoreDefaults()
		f3_arg0:openMenu("CampaignMissionBriefingMenu", f3_arg1.controller)
	end
	f3_arg0:close()
end

CoD.ConfirmChangeHistory.CancelRequest = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0:openMenu("MissionSelectMenu", f4_arg1.controller)
	f4_arg0:close()
end

