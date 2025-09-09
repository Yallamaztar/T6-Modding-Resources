CoD.Error = {}
CoD.Error.Width = 400
CoD.Error.Height = 250
CoD.Error.SetMessage = function (f1_arg0, f1_arg1)
	f1_arg0.messageLabel:setText(f1_arg1)
end

LUI.createMenu.Error = function (f2_arg0)
	local f2_local0 = CoD.Menu.NewSmallPopup("Error")
	f2_local0:addTitle(Engine.Localize("MENU_NOTICE_CAPS"))
	f2_local0.setMessage = CoD.Error.SetMessage
	f2_local0.okButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_OK_CAPS"), f2_local0, "button_prompt_back")
	f2_local0:addLeftButtonPrompt(f2_local0.okButton)
	f2_local0.messageLabel = LUI.UIText.new()
	f2_local0.messageLabel:setLeftRight(true, true, 0, 0)
	f2_local0.messageLabel:setTopBottom(true, false, CoD.Menu.TitleHeight + 10, CoD.Menu.TitleHeight + 10 + CoD.textSize.Condensed)
	f2_local0.messageLabel:setAlpha(CoD.textAlpha)
	f2_local0.messageLabel:setAlignment(LUI.Alignment.Left)
	f2_local0.messageLabel:setFont(CoD.fonts.Condensed)
	f2_local0:addElement(f2_local0.messageLabel)
	return f2_local0
end

