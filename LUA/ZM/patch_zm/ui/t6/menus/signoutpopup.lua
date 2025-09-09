CoD.SignOutPopup = {}
CoD.SignOutPopup.Back = function (f1_arg0, f1_arg1)
	f1_arg0:goBack(f1_arg1.controller)
end

CoD.SignOutPopup.YesButton = function (f2_arg0, f2_arg1)
	Engine.Exec(f2_arg1.controller, "xsignout")
	CoD.SignOutPopup.Back(f2_arg0, f2_arg1)
end

CoD.SignOutPopup.SetWarning = function (f3_arg0, f3_arg1)
	f3_arg0.warningLabel:setText(f3_arg1)
end

CoD.SignOutPopup.AddButtons = function (f4_arg0)
	local f4_local0 = f4_arg0.buttonList:addButton(Engine.Localize("MENU_YES"))
	f4_local0:setActionEventName("button_action_yes")
	local f4_local1 = f4_arg0.buttonList:addButton(Engine.Localize("MENU_NO"))
	f4_local1:setActionEventName("button_action_no")
	if CoD.useController then
		f4_local1:processEvent({
			name = "gain_focus"
		})
	end
end

LUI.createMenu.SignOut = function (f5_arg0)
	local f5_local0 = CoD.Menu.NewSmallPopup("SignOut")
	f5_local0:setOwner(f5_arg0)
	f5_local0:addSelectButton()
	f5_local0:addBackButton()
	f5_local0:registerEventHandler("button_prompt_back", CoD.SignOutPopup.Back)
	f5_local0:registerEventHandler("button_action_yes", CoD.SignOutPopup.YesButton)
	f5_local0:registerEventHandler("button_action_no", CoD.SignOutPopup.Back)
	f5_local0.addButtons = CoD.SignOutPopup.AddButtons
	f5_local0.setWarning = CoD.SignOutPopup.SetWarning
	local f5_local1 = CoD.Menu.TitleHeight + 5
	f5_local0.warningLabel = LUI.UIText.new()
	f5_local0.warningLabel:setLeftRight(true, true, 0, 0)
	f5_local0.warningLabel:setTopBottom(true, false, f5_local1, f5_local1 + CoD.textSize.Default)
	f5_local0.warningLabel:setFont(CoD.fonts.Default)
	f5_local0.warningLabel:setAlignment(LUI.Alignment.Left)
	f5_local0:addElement(f5_local0.warningLabel)
	f5_local0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	f5_local0:addElement(f5_local0.buttonList)
	return f5_local0
end

