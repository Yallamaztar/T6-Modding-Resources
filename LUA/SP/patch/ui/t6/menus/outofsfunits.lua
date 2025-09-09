CoD.OutOfSFUnits = {}
LUI.createMenu.OutOfSFUnits = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("OutOfSFUnits", true)
	local f1_local1 = "Default"
	local f1_local2 = 0
	f1_local0:addBackButton("")
	f1_local0.backButton:setAlpha(0)
	f1_local0:registerEventHandler("confirm_ok", CoD.OutOfSFUnits.ConfirmOkay)
	f1_local0:registerAnimationState("hide", {
		alpha = 0
	})
	f1_local0.title = LUI.UIText.new()
	f1_local0.title:setLeftRight(true, true, 0, 0)
	f1_local0.title:setTopBottom(true, false, f1_local2, f1_local2 + CoD.textSize[f1_local1])
	f1_local0.title:setAlignment(LUI.Alignment.Left)
	f1_local0.title:setFont(CoD.fonts[f1_local1])
	f1_local0.title:setText(Engine.Localize("MENU_OUTOFSFUNITS_CAPS"))
	f1_local0:addElement(f1_local0.title)
	f1_local0:addSelectButton()
	local f1_local3 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height - 21,
		bottom = -15
	})
	f1_local0:addElement(f1_local3)
	local f1_local4 = f1_local3:addButton(Engine.Localize("MENU_OK_CAPS"))
	f1_local4:setActionEventName("confirm_ok")
	f1_local3:processEvent({
		name = "gain_focus"
	})
	return f1_local0
end

CoD.OutOfSFUnits.ConfirmOkay = function (f2_arg0, f2_arg1)
	f2_arg0:goBack(f2_arg1.controller)
end

