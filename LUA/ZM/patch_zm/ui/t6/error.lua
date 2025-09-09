CoD.Error = {}
CoD.Error.Width = 400
CoD.Error.Height = 250
CoD.Error.SetMessage = function (ErrorPopup, ErrorMessage)
	ErrorPopup.messageLabel:setText(ErrorMessage)
end

LUI.createMenu.Error = function (LocalClientIndex)
	local ErrorPopup = CoD.Menu.NewSmallPopup("Error")
	ErrorPopup:addTitle(Engine.Localize("MENU_NOTICE_CAPS"))
	ErrorPopup.setMessage = CoD.Error.SetMessage
	ErrorPopup.okButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_OK_CAPS"), ErrorPopup, "button_prompt_back")
	ErrorPopup:addLeftButtonPrompt(ErrorPopup.okButton)
	ErrorPopup.messageLabel = LUI.UIText.new()
	ErrorPopup.messageLabel:setLeftRight(true, true, 0, 0)
	ErrorPopup.messageLabel:setTopBottom(true, false, CoD.Menu.TitleHeight + 10, CoD.Menu.TitleHeight + 10 + CoD.textSize.Condensed)
	ErrorPopup.messageLabel:setAlpha(CoD.textAlpha)
	ErrorPopup.messageLabel:setAlignment(LUI.Alignment.Left)
	ErrorPopup.messageLabel:setFont(CoD.fonts.Condensed)
	ErrorPopup:addElement(ErrorPopup.messageLabel)
	return ErrorPopup
end

