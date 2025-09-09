CoD.ConfirmNoProfilePopup = {}
LUI.createMenu.ConfirmNoProfilePopup = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.Menu.NewSmallPopup("ConfirmNoProfilePopup")
	f1_local0.nextMenuName = f1_arg1.nextMenuName
	f1_local0:registerEventHandler("noprofile_continue", CoD.ConfirmNoProfilePopup.NoProfileContinue)
	f1_local0:registerEventHandler("cancel_request", CoD.ConfirmNoProfilePopup.CancelRequest)
	local f1_local1 = 0
	local f1_local2 = "Default"
	local f1_local3 = LUI.UIText.new()
	f1_local3:setLeftRight(true, true, 0, 0)
	f1_local3:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize[f1_local2])
	f1_local3:setAlignment(LUI.Alignment.Left)
	f1_local3:setFont(CoD.fonts[f1_local2])
	f1_local3:setText(Engine.Localize(f1_arg1.messageText))
	f1_local0:addElement(f1_local3)
	local f1_local4 = CoD.ButtonList.new()
	f1_local4:setLeftRight(true, true, 0, 0)
	f1_local4:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 2 - 21, -15)
	f1_local0:addElement(f1_local4)
	local f1_local5 = f1_local4:addButton(Engine.Localize("MENU_YES_CAPS"))
	f1_local5:setActionEventName("noprofile_continue")
	local f1_local6 = f1_local4:addButton(Engine.Localize("MENU_NO_CAPS"))
	f1_local6:setActionEventName("cancel_request")
	f1_local6:processEvent({
		name = "gain_focus"
	})
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	return f1_local0
end

CoD.ConfirmNoProfilePopup.NoProfileContinue = function (f2_arg0, f2_arg1)
	if f2_arg0.nextMenuName == "DifficultyMenu" then
		f2_arg0:openMenu("DifficultyMenu", f2_arg1.controller)
		Dvar.ui_campaignstate:set(1)
		Engine.ExecNow(f2_arg1.controller, "new_campaign")
	elseif f2_arg0.nextMenuName == "OptionsMenu" then
		if LUI.savedMenuStates.Menu.OptionsMenu then
			LUI.savedMenuStates.Menu.OptionsMenu = nil
		end
		f2_arg0:openMenu("OptionsMenu", f2_arg1.controller)
	else
		f2_arg0:openMenu("CampaignMenu", f2_arg1.controller)
	end
	f2_arg0:close()
end

CoD.ConfirmNoProfilePopup.CancelRequest = function (f3_arg0, f3_arg1)
	Engine.Exec(f3_arg1.controller, "xsignin 0")
	f3_arg0:goBack(f3_arg1.controller)
end

