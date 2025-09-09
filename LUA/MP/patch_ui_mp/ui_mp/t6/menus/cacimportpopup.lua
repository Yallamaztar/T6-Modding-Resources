CoD.CACImportPopup = {}
CoD.CACImportPopup.Width = 400
CoD.CACImportPopup.Height = 310
CoD.CACImportPopup.AddButton = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = f1_arg0.buttonList:addButton(f1_arg1)
	f1_local0:setActionEventName(f1_arg2)
	return f1_local0
end

CoD.CACImportPopup.YesButtonPressed = function (f2_arg0, f2_arg1)
	Engine.ECACImport_PlayerDecision(f2_arg1.controller, true)
	f2_arg0:goBack(f2_arg1.controller)
end

CoD.CACImportPopup.NoButtonPressed = function (f3_arg0, f3_arg1)
	Engine.ECACImport_PlayerDecision(f3_arg1.controller, false)
	f3_arg0:goBack(f3_arg1.controller)
	f3_arg0.occludedMenu:processEvent({
		name = "elite_cac_import_popup_closed",
		controller = f3_arg1.controller
	})
end

LUI.createMenu.CACImportPopup = function (f4_arg0)
	local f4_local0 = CoD.Menu.NewSmallPopup("CACImportPopup")
	f4_local0:addTitle(Engine.Localize("MENU_CAC_IMPORT"))
	f4_local0:addSelectButton()
	f4_local0:addBackButton()
	f4_local0:registerEventHandler("CACImportPopup_YesButtonPressed", CoD.CACImportPopup.YesButtonPressed)
	f4_local0:registerEventHandler("CACImportPopup_NoButtonPressed", CoD.CACImportPopup.NoButtonPressed)
	local f4_local1 = CoD.Menu.TitleHeight + 10
	f4_local0.messageLabel = LUI.UIText.new()
	f4_local0.messageLabel:setLeftRight(true, true, 0, 0)
	f4_local0.messageLabel:setTopBottom(true, false, f4_local1, f4_local1 + CoD.textSize.Default)
	f4_local0.messageLabel:setFont(CoD.fonts.Default)
	f4_local0.messageLabel:setAlignment(LUI.Alignment.Left)
	f4_local0.messageLabel:setText(Engine.Localize("EXE_DEFAULT_PLAYER") .. " " .. UIExpression.GetSelfGamertag(f4_arg0) .. ", " .. Engine.Localize("MENU_CAC_IMPORT_TEXT"))
	f4_local0:addElement(f4_local0.messageLabel)
	f4_local0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	f4_local0:addElement(f4_local0.buttonList)
	local f4_local2 = CoD.CACImportPopup.AddButton(f4_local0, Engine.Localize("MENU_YES"), "CACImportPopup_YesButtonPressed")
	local f4_local3 = CoD.CACImportPopup.AddButton(f4_local0, Engine.Localize("MENU_NO"), "CACImportPopup_NoButtonPressed")
	f4_local3:processEvent({
		name = "gain_focus"
	})
	return f4_local0
end

