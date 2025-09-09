CoD.ComErrorPopup = {}
CoD.ComErrorPopup.Width = 480
CoD.ComErrorPopup.Height = 330
CoD.ComErrorPopup.MenuChanged = function (f1_arg0, f1_arg1)
	if f1_arg0.occludedMenu == f1_arg1.prevMenu then
		f1_arg0:setOccludedMenu(f1_arg1.nextMenu)
	end
end

CoD.ComErrorPopup.GoBack = function (f2_arg0, LocalClientIndex)
	CoD.Menu.goBack(f2_arg0, LocalClientIndex)
	Engine.ClearError()
	if UIExpression.IsInGame() == 1 and CoD.isSinglePlayer then
		Engine.LockInput(LocalClientIndex, false)
		Engine.SetUIActive(LocalClientIndex, false)
		CoD.ErrorPopupOpen = 0
	end
end

LUI.createMenu.ErrorPopup = function (LocalClientIndex)
	local ErrorMessage = ""
	if UIExpression.DvarString(nil, "ui_errorMessage") ~= "" then
		ErrorMessage = Engine.Localize(Dvar.ui_errorMessage:get())
	end
	local f3_local1 = CoD.textSize.Default * math.max(4, Engine.GetNumTextLines(ErrorMessage, CoD.fonts.Default, CoD.textSize.Default, CoD.Menu.SmallPopupWidth)) + 160
	local ErrorPopup = CoD.Menu.NewSmallPopup("ErrorPopup", nil, nil, CoD.Menu.SmallPopupWidth, f3_local1)
	ErrorPopup.anyControllerAllowed = true
	if UIExpression.IsInGame(LocalClientIndex) == 1 then
		ErrorPopup:setOwner(LocalClientIndex)
	end
	ErrorPopup:addSelectButton()
	ErrorPopup:addBackButton()
	ErrorPopup:registerEventHandler("menu_changed", CoD.ComErrorPopup.MenuChanged)
	ErrorPopup.goBack = CoD.ComErrorPopup.GoBack
	local TitleText = LUI.UIText.new()
	TitleText:setLeftRight(true, false, 0, 1)
	TitleText:setTopBottom(true, false, 0, CoD.textSize.Big)
	TitleText:setFont(CoD.fonts.Big)
	TitleText:setAlignment(LUI.Alignment.Left)
	ErrorPopup:addElement(TitleText)
	local ErrorTitle = UIExpression.DvarString(nil, "ui_errorTitle")
	if string.sub(ErrorTitle, 1, 1) == "@" then
		ErrorTitle = Engine.Localize(ErrorTitle)
	end
	TitleText:setText(ErrorTitle)
	local MessageText = LUI.UIText.new()
	MessageText:setLeftRight(true, true, 0, 0)
	MessageText:setTopBottom(true, false, CoD.textSize.Big, CoD.textSize.Big + CoD.textSize.Default)
	MessageText:setFont(CoD.fonts.Default)
	MessageText:setAlignment(LUI.Alignment.Left)
	ErrorPopup:addElement(MessageText)
	MessageText:setText(ErrorMessage)
	CoD.Popup.SetWidthHeight(ErrorPopup, CoD.Menu.SmallPopupWidth, f3_local1)
	local f3_local3 = CoD.textSize.Big + CoD.textSize.Default * 3
	local DebugMessageText = LUI.UIText.new()
	DebugMessageText:setLeftRight(true, true, 0, 0)
	DebugMessageText:setTopBottom(true, false, f3_local3, f3_local3 + CoD.textSize.Default)
	DebugMessageText:setFont(CoD.fonts.Default)
	DebugMessageText:setAlignment(LUI.Alignment.Left)
	ErrorPopup:addElement(DebugMessageText)
	DebugMessageText:setText(UIExpression.DvarString(nil, "ui_errorMessageDebug"))
	local f3_local9 = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 2 + 10
	if f3_local1 >= 300 then
		f3_local9 = f3_local9 - 20
	end
	ErrorPopup.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = f3_local9,
		bottom = 0
	})
	ErrorPopup:addElement(ErrorPopup.buttonList)
	local f3_local10 = ErrorPopup.buttonList:addButton(Engine.Localize("MENU_OK"))
	f3_local10:setActionEventName("button_prompt_back")
	f3_local10:processEvent({
		name = "gain_focus"
	})
	if CoD.isMultiplayer then
		Engine.ClearError()
	end
	return ErrorPopup
end

