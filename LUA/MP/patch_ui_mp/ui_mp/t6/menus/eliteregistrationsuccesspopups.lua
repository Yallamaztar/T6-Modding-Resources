playerData = {}
UCDAccountUpdate = false
CoD.EliteRegistrationSuccessEmailConfirmationPopup = {}
CoD.EliteRegistrationSuccessTOSPopup = {}
CoD.EliteRegistrationSuccessTOSPopup.Paragraph1 = {}
CoD.EliteRegistrationSuccessTOSPopup.Paragraph2 = {}
CoD.EliteRegistrationSuccessTOSPopup.PageIndicator = {}
CoD.EliteRegistrationSuccessTOSPopup.NextButton = {}
CoD.EliteRegistrationSuccessTOSPopup.PrevButton = {}
CoD.EliteRegistrationSuccessTOSPopup.Page = 1
CoD.EliteRegistrationSuccessTOSPopup.MaxPage = 2
CoD.EliteRegistrationScrollingTOS = {}
CoD.EliteRegistrationSuccessPopup = {}
local f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg0:close(f1_arg1.controller)
end

CoD.EliteRegistrationSuccessEmailConfirmationPopup.AddButton = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = f2_arg0.buttonList:addButton(f2_arg1)
	f2_local0:setActionEventName(f2_arg2)
	return f2_local0
end

CoD.EliteRegistrationSuccessEmailConfirmationPopup.AcceptButtonPressed = function (f3_arg0, f3_arg1)
	f3_arg0:goBack(f3_arg1.controller)
	f3_arg0.occludedMenu:processEvent({
		name = "check_email_address_popup_closed",
		controller = f3_arg1.controller
	})
end

CoD.EliteRegistrationSuccessEmailConfirmationPopup.CancelButtonPressed = function (f4_arg0, f4_arg1)
	f4_arg0:goBack(f4_arg1.controller)
end

LUI.createMenu.EliteRegistrationSuccessEmailConfirmationPopup = function (f5_arg0, f5_arg1)
	playerData = f5_arg1.playerData
	UCDAccountUpdate = f5_arg1.UCDAccountUpdate
	local f5_local0 = CoD.Menu.NewMediumPopup("EliteRegistrationSuccessEmailConfirmationPopup")
	f5_local0:setOwner(f5_arg0)
	f5_local0:registerEventHandler("EliteRegistrationSuccessEmailConfirmationPopup_AcceptButtonPressed", CoD.EliteRegistrationSuccessEmailConfirmationPopup.AcceptButtonPressed)
	f5_local0:registerEventHandler("EliteRegistrationSuccessEmailConfirmationPopup_CancelButtonPressed", CoD.EliteRegistrationSuccessEmailConfirmationPopup.CancelButtonPressed)
	f5_local0:registerEventHandler("signed_out", f0_local0)
	f5_local0.buttonList = CoD.ButtonList.new({
		left = 0,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	})
	local f5_local1 = CoD.EliteRegistrationSuccessEmailConfirmationPopup.AddButton(f5_local0, Engine.Localize("MENU_ACCEPT_CAPS"), "EliteRegistrationSuccessEmailConfirmationPopup_AcceptButtonPressed")
	local f5_local2 = CoD.EliteRegistrationSuccessEmailConfirmationPopup.AddButton(f5_local0, Engine.Localize("MENU_CANCEL_CAPS"), "EliteRegistrationSuccessEmailConfirmationPopup_CancelButtonPressed")
	f5_local2:processEvent({
		name = "gain_focus"
	})
	f5_local0:addElement(f5_local0.buttonList)
	f5_local0.msgTitle = LUI.UIText.new()
	f5_local0.msgTitle:setLeftRight(true, true, 0, 0)
	f5_local0.msgTitle:setTopBottom(true, false, 0, CoD.textSize.Condensed)
	f5_local0.msgTitle:setRGB(CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b)
	f5_local0.msgTitle:setAlignment(LUI.Alignment.Left)
	f5_local0.msgTitle:setFont(CoD.fonts.Condensed)
	f5_local0.msgTitle:setText(Engine.Localize("MPUI_CHECK_EMAIL_CAPS"))
	f5_local0:addElement(f5_local0.msgTitle)
	local f5_local3 = CoD.textSize.Condensed * 2
	f5_local0.verifyLabel = LUI.UIText.new()
	f5_local0.verifyLabel:setLeftRight(true, true, 0, 0)
	f5_local0.verifyLabel:setTopBottom(true, false, f5_local3, f5_local3 + CoD.textSize.Default)
	f5_local0.verifyLabel:setAlignment(LUI.Alignment.Left)
	f5_local0.verifyLabel:setFont(CoD.fonts.Default)
	f5_local0.verifyLabel:setText(Engine.Localize("MPUI_ASK_EMAIL_VERIFY"))
	f5_local0:addElement(f5_local0.verifyLabel)
	f5_local3 = f5_local3 + CoD.textSize.Default * 2
	f5_local0.emailLabel = LUI.UIText.new()
	f5_local0.emailLabel:setLeftRight(true, true, 0, 0)
	f5_local0.emailLabel:setTopBottom(true, false, f5_local3, f5_local3 + CoD.textSize.Default)
	f5_local0.emailLabel:setRGB(CoD.yellow.r, CoD.yellow.g, CoD.yellow.b)
	f5_local0.emailLabel:setAlignment(LUI.Alignment.Left)
	f5_local0.emailLabel:setFont(CoD.fonts.Default)
	f5_local0.emailLabel:setText(playerData.email)
	f5_local0:addElement(f5_local0.emailLabel)
	f5_local3 = f5_local3 + CoD.textSize.Default * 2
	f5_local0.additionalTextLabel = LUI.UIText.new()
	f5_local0.additionalTextLabel:setLeftRight(true, true, 0, 0)
	f5_local0.additionalTextLabel:setTopBottom(true, false, f5_local3, f5_local3 + CoD.textSize.Default)
	f5_local0.additionalTextLabel:setAlignment(LUI.Alignment.Left)
	f5_local0.additionalTextLabel:setFont(CoD.fonts.Default)
	f5_local0.additionalTextLabel:setText(Engine.Localize("MPUI_ASK_EMAIL_VERIFY2"))
	f5_local0:addElement(f5_local0.additionalTextLabel)
	f5_local0:addSelectButton()
	f5_local0:addBackButton()
	return f5_local0
end

CoD.EliteRegistrationScrollingTOS.AddButton = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = f6_arg0.buttonList:addButton(f6_arg1)
	f6_local0:setActionEventName(f6_arg2)
	return f6_local0
end

local f0_local1 = function (f7_arg0)
	if f7_arg0.tosContainer == nil then
		f7_arg0.tosContainer = LUI.UIElement.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 75,
			bottom = -80
		})
		f7_arg0:addElement(f7_arg0.tosContainer)
		f7_arg0.tosContainer.border = CoD.Border.new(1, 1, 1, 1, 0.1)
		f7_arg0.tosContainer:addElement(f7_arg0.tosContainer.border)
		f7_arg0.tosContainer.tosCustomElement = LUI.UIElement.new({
			left = 0,
			top = 35,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true
		})
		f7_arg0.tosContainer:addElement(f7_arg0.tosContainer.tosCustomElement)
	end
	Engine.SetDvar("ui_scrollSpeed", 0)
	f7_arg0.tosContainer.tosCustomElement:setupEliteLegal()
end

local f0_local2 = function (f8_arg0)
	if f8_arg0.tosContainer ~= nil then
		f8_arg0.tosContainer:close()
		f8_arg0.tosContainer = nil
	end
	Engine.SetDvar("ui_scrollSpeed", 0)
end

CoD.EliteRegistrationScrollingTOS.Select = function (f9_arg0, f9_arg1)
	f9_arg0:goBack(f9_arg1.controller)
	Engine.ERegPopup_SubmitRegistration(f9_arg1.controller, UCDAccountUpdate, playerData)
end

CoD.EliteRegistrationScrollingTOS.Back = function (f10_arg0, f10_arg1)
	f0_local2(f10_arg0)
	CoD.Menu.ButtonPromptBack(f10_arg0, f10_arg1)
end

CoD.EliteRegistrationScrollingTOS.HandleGamepadButton = function (f11_arg0, f11_arg1)
	if LUI.UIElement.handleGamepadButton(f11_arg0, f11_arg1) == true then
		return true
	elseif f11_arg1.down == true then
		if f11_arg1.qualifier == nil then
			local f11_local0 = Engine.GetCustomElementScrollSpeed()
			if f11_arg1.button == "up" then
				if f11_local0 < 0 then
					Engine.SetCustomElementScrollSpeed(0)
				else
					Engine.SetCustomElementScrollSpeed(f11_local0 + 1)
				end
			elseif f11_arg1.button == "down" then
				if f11_local0 > 0 then
					Engine.SetCustomElementScrollSpeed(0)
				else
					Engine.SetCustomElementScrollSpeed(f11_local0 - 1)
				end
			end
			return 
		end
	else
		Engine.SetCustomElementScrollSpeed(0)
	end
end

CoD.EliteRegistrationScrollingTOS.addButtonPrompt = function (f12_arg0, f12_arg1)
	f12_arg0.buttonPromptList:addElement(f12_arg1)
end

LUI.createMenu.EliteRegistrationScrollingTOS = function (f13_arg0)
	local f13_local0 = CoD.Menu.New("EliteRegistrationScrollingTOS")
	f13_local0:setOwner(f13_arg0)
	f13_local0:registerEventHandler("button_select_prompt", CoD.EliteRegistrationScrollingTOS.Select)
	f13_local0:registerEventHandler("button_prompt_back", CoD.EliteRegistrationScrollingTOS.Back)
	f13_local0:registerEventHandler("signed_out", f0_local0)
	f13_local0.button = LUI.UIButton.new({
		leftAnchor = false,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = 0,
		bottom = 0,
		alpha = 0
	})
	f13_local0.button.handleGamepadButton = CoD.EliteRegistrationScrollingTOS.HandleGamepadButton
	f13_local0:addElement(f13_local0.button)
	f13_local0.button:processEvent({
		name = "gain_focus"
	})
	f13_local0.buttonRepeaterUp = LUI.UIButtonRepeater.new("up", "moveup")
	f13_local0:addElement(f13_local0.buttonRepeaterUp)
	f13_local0.buttonRepeaterDown = LUI.UIButtonRepeater.new("down", "movedown")
	f13_local0:addElement(f13_local0.buttonRepeaterDown)
	f13_local0:addLargePopupBackground()
	f13_local0.msgTitle = LUI.UIText.new()
	f13_local0.msgTitle:setLeftRight(true, true, 0, 0)
	f13_local0.msgTitle:setTopBottom(true, false, 0, 0 + CoD.textSize.Condensed)
	f13_local0.msgTitle:setAlignment(LUI.Alignment.Left)
	f13_local0.msgTitle:setFont(CoD.fonts.Condensed)
	f13_local0.msgTitle:setText(Engine.Localize("MPUI_TOS_TITLE"))
	f13_local0:addElement(f13_local0.msgTitle)
	f13_local0.subTitle = LUI.UIText.new()
	f13_local0.subTitle:setLeftRight(true, true, 0, 0)
	f13_local0.subTitle:setTopBottom(true, false, 30, 30 + CoD.textSize.ExtraSmall)
	f13_local0.subTitle:setAlignment(LUI.Alignment.Left)
	f13_local0.subTitle:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f13_local0.subTitle:setFont(CoD.fonts.ExtraSmall)
	f13_local0.subTitle:setText(Engine.Localize("MPUI_TOS_SUBTITLE"))
	f13_local0:addElement(f13_local0.subTitle)
	f13_local0:addSelectButton(Engine.Localize("MPUI_TOS_AGREE"), nil, "button_select_prompt")
	f13_local0:addBackButton(Engine.Localize("MPUI_TOS_REFUSE"))
	f0_local1(f13_local0)
	f13_local0.upRepeater = LUI.UIButtonRepeater.new("up", {
		name = "gamepad_button",
		button = "up",
		down = true
	})
	f13_local0.downRepeater = LUI.UIButtonRepeater.new("down", {
		name = "gamepad_button",
		button = "down",
		down = true
	})
	f13_local0:addElement(f13_local0.upRepeater)
	f13_local0:addElement(f13_local0.downRepeater)
	f13_local0.buttonPromptList = LUI.UIVerticalList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -65,
		bottom = 0,
		spacing = 5,
		alignment = LUI.Alignment.Left
	})
	f13_local0:addElement(f13_local0.buttonPromptList)
	f13_local0.addButtonPrompt = CoD.EliteRegistrationScrollingTOS.addButtonPrompt
	f13_local0.moveImage = CoD.ButtonPrompt.new("emblem_move", Engine.Localize("MENU_LB_SCROLL_UP_SCROLL_DOWN"))
	f13_local0:addButtonPrompt(f13_local0.moveImage)
	return f13_local0
end

CoD.EliteRegistrationSuccessTOSPopup.AddButton = function (f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = f14_arg0.buttonList:addButton(f14_arg1)
	f14_local0:setActionEventName(f14_arg2)
	return f14_local0
end

CoD.EliteRegistrationSuccessTOSPopup.UpdatePageIndicator = function (f15_arg0, f15_arg1)
	CoD.EliteRegistrationSuccessTOSPopup.PageIndicator:setText(CoD.EliteRegistrationSuccessTOSPopup.Page .. " / " .. CoD.EliteRegistrationSuccessTOSPopup.MaxPage)
end

CoD.EliteRegistrationSuccessTOSPopup.PrevButtonPressed = function (f16_arg0, f16_arg1)
	if CoD.EliteRegistrationSuccessTOSPopup.Page > 1 then
		CoD.EliteRegistrationSuccessTOSPopup.Page = CoD.EliteRegistrationSuccessTOSPopup.Page - 1
		CoD.EliteRegistrationSuccessTOSPopup:UpdatePageIndicator(f16_arg1)
		local f16_local0 = CoD.EliteRegistrationSuccessTOSPopup.Page - 1
		CoD.EliteRegistrationSuccessTOSPopup.Paragraph1:setText(Engine.Localize("MPUI_ELITE_LEGAL_" .. CoD.EliteRegistrationSuccessTOSPopup.Page + f16_local0))
		CoD.EliteRegistrationSuccessTOSPopup.Paragraph2:setText(Engine.Localize("MPUI_ELITE_LEGAL_" .. CoD.EliteRegistrationSuccessTOSPopup.Page + f16_local0 + 1))
		if CoD.EliteRegistrationSuccessTOSPopup.Page == 1 then
			CoD.EliteRegistrationSuccessTOSPopup.PrevButton:processEvent({
				name = "disable"
			})
			CoD.EliteRegistrationSuccessTOSPopup.NextButton:processEvent({
				name = "enable"
			})
		else
			CoD.EliteRegistrationSuccessTOSPopup.PrevButton:processEvent({
				name = "enable"
			})
		end
	end
end

CoD.EliteRegistrationSuccessTOSPopup.NextButtonPressed = function (f17_arg0, f17_arg1)
	if CoD.EliteRegistrationSuccessTOSPopup.Page < CoD.EliteRegistrationSuccessTOSPopup.MaxPage then
		CoD.EliteRegistrationSuccessTOSPopup.Page = CoD.EliteRegistrationSuccessTOSPopup.Page + 1
		CoD.EliteRegistrationSuccessTOSPopup:UpdatePageIndicator(f17_arg1)
		local f17_local0 = CoD.EliteRegistrationSuccessTOSPopup.Page - 1
		CoD.EliteRegistrationSuccessTOSPopup.Paragraph1:setText(Engine.Localize("MPUI_ELITE_LEGAL_" .. CoD.EliteRegistrationSuccessTOSPopup.Page + f17_local0))
		CoD.EliteRegistrationSuccessTOSPopup.Paragraph2:setText(Engine.Localize("MPUI_ELITE_LEGAL_" .. CoD.EliteRegistrationSuccessTOSPopup.Page + f17_local0 + 1))
		if CoD.EliteRegistrationSuccessTOSPopup.Page == CoD.EliteRegistrationSuccessTOSPopup.MaxPage then
			CoD.EliteRegistrationSuccessTOSPopup.NextButton:processEvent({
				name = "disable"
			})
			CoD.EliteRegistrationSuccessTOSPopup.PrevButton:processEvent({
				name = "enable"
			})
		else
			CoD.EliteRegistrationSuccessTOSPopup.NextButton:processEvent({
				name = "enable"
			})
		end
	end
end

CoD.EliteRegistrationSuccessTOSPopup.AcceptButtonPressed = function (f18_arg0, f18_arg1)
	f18_arg0:goBack(f18_arg1.controller)
	Engine.ERegPopup_SubmitRegistration(f18_arg1.controller, UCDAccountUpdate, playerData)
end

CoD.EliteRegistrationSuccessTOSPopup.CancelButtonPressed = function (f19_arg0, f19_arg1)
	f19_arg0:goBack(f19_arg1.controller)
end

LUI.createMenu.EliteRegistrationSuccessTOSPopup = function (f20_arg0)
	CoD.EliteRegistrationSuccessTOSPopup.Page = 1
	local f20_local0 = CoD.Menu.New("EliteRegistrationSuccessTOSPopup")
	f20_local0:setOwner(f20_arg0)
	f20_local0:registerEventHandler("EliteRegistrationSuccessTOSPopup_PrevButtonPressed", CoD.EliteRegistrationSuccessTOSPopup.PrevButtonPressed)
	f20_local0:registerEventHandler("EliteRegistrationSuccessTOSPopup_NextButtonPressed", CoD.EliteRegistrationSuccessTOSPopup.NextButtonPressed)
	f20_local0:registerEventHandler("EliteRegistrationSuccessTOSPopup_AcceptButtonPressed", CoD.EliteRegistrationSuccessTOSPopup.AcceptButtonPressed)
	f20_local0:registerEventHandler("EliteRegistrationSuccessTOSPopup_CancelButtonPressed", CoD.EliteRegistrationSuccessTOSPopup.CancelButtonPressed)
	f20_local0:registerEventHandler("signed_out", f0_local0)
	f20_local0.buttonList = CoD.ButtonList.new({
		left = 0,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 5,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	})
	CoD.EliteRegistrationSuccessTOSPopup.PrevButton = CoD.EliteRegistrationSuccessTOSPopup.AddButton(f20_local0, Engine.Localize("Previous page"), "EliteRegistrationSuccessTOSPopup_PrevButtonPressed")
	CoD.EliteRegistrationSuccessTOSPopup.NextButton = CoD.EliteRegistrationSuccessTOSPopup.AddButton(f20_local0, Engine.Localize("Next page"), "EliteRegistrationSuccessTOSPopup_NextButtonPressed")
	local f20_local1 = CoD.EliteRegistrationSuccessTOSPopup.AddButton(f20_local0, Engine.Localize("MENU_ACCEPT_CAPS"), "EliteRegistrationSuccessTOSPopup_AcceptButtonPressed")
	local f20_local2 = CoD.EliteRegistrationSuccessTOSPopup.AddButton(f20_local0, Engine.Localize("MENU_CANCEL_CAPS"), "EliteRegistrationSuccessTOSPopup_CancelButtonPressed")
	CoD.EliteRegistrationSuccessTOSPopup.PrevButton:processEvent({
		name = "disable"
	})
	f20_local2:processEvent({
		name = "gain_focus"
	})
	f20_local0:addElement(f20_local0.buttonList)
	f20_local0:addLargePopupBackground()
	f20_local0.msgTitle = LUI.UIText.new()
	f20_local0.msgTitle:setLeftRight(true, true, 0, 0)
	f20_local0.msgTitle:setTopBottom(true, false, 0, 0 + CoD.textSize.Condensed)
	f20_local0.msgTitle:setRGB(CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b)
	f20_local0.msgTitle:setAlignment(LUI.Alignment.Left)
	f20_local0.msgTitle:setFont(CoD.fonts.Condensed)
	f20_local0.msgTitle:setText(Engine.Localize("ACCEPT THE SERVICE AGREEMENT AND PRIVACY POLICY"))
	f20_local0:addElement(f20_local0.msgTitle)
	local f20_local3 = CoD.textSize.Condensed * 2
	local f20_local4 = Engine.Localize("MPUI_ELITE_LEGAL_1")
	CoD.EliteRegistrationSuccessTOSPopup.Paragraph1 = LUI.UIText.new(nil, true)
	CoD.EliteRegistrationSuccessTOSPopup.Paragraph1:setLeftRight(true, true, 0, 0)
	CoD.EliteRegistrationSuccessTOSPopup.Paragraph1:setTopBottom(true, false, f20_local3, f20_local3 + CoD.textSize.ExtraSmall)
	CoD.EliteRegistrationSuccessTOSPopup.Paragraph1:setAlignment(LUI.Alignment.Left)
	CoD.EliteRegistrationSuccessTOSPopup.Paragraph1:setFont(CoD.fonts.ExtraSmall)
	CoD.EliteRegistrationSuccessTOSPopup.Paragraph1:setText(f20_local4)
	f20_local0:addElement(CoD.EliteRegistrationSuccessTOSPopup.Paragraph1)
	f20_local3 = f20_local3 + Engine.GetNumTextLines(f20_local4, CoD.fonts.ExtraSmall, CoD.textSize.ExtraSmall, CoD.Menu.Width) * CoD.textSize.ExtraSmall
	CoD.EliteRegistrationSuccessTOSPopup.Paragraph2 = LUI.UIText.new(nil, true)
	CoD.EliteRegistrationSuccessTOSPopup.Paragraph2:setLeftRight(true, true, 0, 0)
	CoD.EliteRegistrationSuccessTOSPopup.Paragraph2:setTopBottom(true, false, f20_local3, f20_local3 + CoD.textSize.ExtraSmall)
	CoD.EliteRegistrationSuccessTOSPopup.Paragraph2:setAlignment(LUI.Alignment.Left)
	CoD.EliteRegistrationSuccessTOSPopup.Paragraph2:setFont(CoD.fonts.ExtraSmall)
	CoD.EliteRegistrationSuccessTOSPopup.Paragraph2:setText(Engine.Localize("MPUI_ELITE_LEGAL_2"))
	f20_local0:addElement(CoD.EliteRegistrationSuccessTOSPopup.Paragraph2)
	CoD.EliteRegistrationSuccessTOSPopup.PageIndicator = LUI.UIText.new(nil, true)
	CoD.EliteRegistrationSuccessTOSPopup.PageIndicator:setLeftRight(true, true, 0, 0)
	CoD.EliteRegistrationSuccessTOSPopup.PageIndicator:setTopBottom(false, true, -CoD.ButtonPrompt.Height * 7, -CoD.ButtonPrompt.Height * 6)
	CoD.EliteRegistrationSuccessTOSPopup.PageIndicator:setAlignment(LUI.Alignment.Right)
	CoD.EliteRegistrationSuccessTOSPopup.PageIndicator:setFont(CoD.fonts.ExtraSmall)
	CoD.EliteRegistrationSuccessTOSPopup.PageIndicator:setText(CoD.EliteRegistrationSuccessTOSPopup.Page .. " / " .. CoD.EliteRegistrationSuccessTOSPopup.MaxPage)
	f20_local0:addElement(CoD.EliteRegistrationSuccessTOSPopup.PageIndicator)
	f20_local0:addSelectButton()
	f20_local0:addBackButton()
	return f20_local0
end

CoD.EliteRegistrationSuccessPopup.AddButton = function (f21_arg0, f21_arg1, f21_arg2)
	local f21_local0 = f21_arg0.buttonList:addButton(f21_arg1)
	f21_local0:setActionEventName(f21_arg2)
	return f21_local0
end

CoD.EliteRegistrationSuccessPopup.ContinueButtonPressed = function (f22_arg0, f22_arg1)
	f22_arg0:goBack(f22_arg1.controller)
	f22_arg0.occludedMenu:processEvent({
		name = "registration_success_popup_closed",
		controller = f22_arg1.controller
	})
end

LUI.createMenu.EliteRegistrationSuccessPopup = function (f23_arg0, f23_arg1)
	local f23_local0 = CoD.Menu.NewMediumPopup("EliteRegistrationSuccessPopup")
	f23_local0:setOwner(f23_arg0)
	f23_local0:registerEventHandler("EliteRegistrationSuccessPopup_ContinueButtonPressed", CoD.EliteRegistrationSuccessPopup.ContinueButtonPressed)
	f23_local0:registerEventHandler("signed_out", f0_local0)
	f23_local0.buttonList = CoD.ButtonList.new({
		left = 0,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 2,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	})
	local f23_local1 = CoD.EliteRegistrationSuccessPopup.AddButton(f23_local0, Engine.Localize("MENU_CONTINUE_CAPS"), "EliteRegistrationSuccessPopup_ContinueButtonPressed")
	f23_local1:processEvent({
		name = "gain_focus"
	})
	f23_local0:addElement(f23_local0.buttonList)
	f23_local0:addMediumPopupBackground()
	if f23_arg1.fail ~= nil then
		f23_local0.msgTitle = LUI.UIText.new()
		f23_local0.msgTitle:setLeftRight(true, true, 0, 0)
		f23_local0.msgTitle:setTopBottom(true, false, 0, CoD.textSize.Condensed)
		f23_local0.msgTitle:setRGB(CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b)
		f23_local0.msgTitle:setAlignment(LUI.Alignment.Left)
		f23_local0.msgTitle:setFont(CoD.fonts.Condensed)
		f23_local0.msgTitle:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_FAIL"))
		f23_local0:addElement(f23_local0.msgTitle)
		local f23_local2 = CoD.textSize.Condensed * 2
		f23_local0.msgBody = LUI.UIText.new()
		f23_local0.msgBody:setLeftRight(true, true, 0, 0)
		f23_local0.msgBody:setTopBottom(true, false, f23_local2, f23_local2 + CoD.textSize.Default)
		f23_local0.msgBody:setAlignment(LUI.Alignment.Left)
		f23_local0.msgBody:setFont(CoD.fonts.Default)
		f23_local0.msgBody:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_FAIL_BODY"))
		f23_local0:addElement(f23_local0.msgBody)
		Engine.EReg_PlayerRefusedOrError(f23_arg0)
	elseif f23_arg1.alreadyRegistered ~= nil then
		f23_local0.msgTitle = LUI.UIText.new()
		f23_local0.msgTitle:setLeftRight(true, true, 0, 0)
		f23_local0.msgTitle:setTopBottom(true, false, 0, CoD.textSize.Condensed)
		f23_local0.msgTitle:setRGB(CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b)
		f23_local0.msgTitle:setAlignment(LUI.Alignment.Left)
		f23_local0.msgTitle:setFont(CoD.fonts.Condensed)
		f23_local0.msgTitle:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_FAIL"))
		f23_local0:addElement(f23_local0.msgTitle)
		local f23_local2 = CoD.textSize.Condensed * 2
		f23_local0.msgBody = LUI.UIText.new()
		f23_local0.msgBody:setLeftRight(true, true, 0, 0)
		f23_local0.msgBody:setTopBottom(true, false, f23_local2, f23_local2 + CoD.textSize.Default)
		f23_local0.msgBody:setAlignment(LUI.Alignment.Left)
		f23_local0.msgBody:setFont(CoD.fonts.Default)
		f23_local0.msgBody:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_ALREADYREGISTERED"))
		f23_local0:addElement(f23_local0.msgBody)
	else
		f23_local0.msgTitle = LUI.UIText.new()
		f23_local0.msgTitle:setLeftRight(true, true, 0, 0)
		f23_local0.msgTitle:setTopBottom(true, false, 0, CoD.textSize.Condensed)
		f23_local0.msgTitle:setRGB(CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b)
		f23_local0.msgTitle:setAlignment(LUI.Alignment.Left)
		f23_local0.msgTitle:setFont(CoD.fonts.Condensed)
		f23_local0.msgTitle:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_SUCCESS"))
		f23_local0:addElement(f23_local0.msgTitle)
		local f23_local2 = CoD.textSize.Condensed * 2
		f23_local0.msgBody = LUI.UIText.new()
		f23_local0.msgBody:setLeftRight(true, true, 0, 0)
		f23_local0.msgBody:setTopBottom(true, false, f23_local2, f23_local2 + CoD.textSize.Default)
		f23_local0.msgBody:setAlignment(LUI.Alignment.Left)
		f23_local0.msgBody:setFont(CoD.fonts.Default)
		f23_local0.msgBody:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_SUCCESS_BODY"))
		f23_local0:addElement(f23_local0.msgBody)
		f23_local2 = f23_local2 + Engine.GetNumTextLines(Engine.Localize("MPUI_EMAIL_REGISTRATION_SUCCESS_BODY"), CoD.fonts.Default, CoD.textSize.Default, CoD.Menu.Width) * CoD.textSize.Default + CoD.textSize.Default
		f23_local0.emailLabel = LUI.UIText.new()
		f23_local0.emailLabel:setLeftRight(true, true, 0, 0)
		f23_local0.emailLabel:setTopBottom(true, false, f23_local2, f23_local2 + CoD.textSize.Default)
		f23_local0.emailLabel:setAlignment(LUI.Alignment.Left)
		f23_local0.emailLabel:setRGB(CoD.yellow.r, CoD.yellow.g, CoD.yellow.b)
		f23_local0.emailLabel:setFont(CoD.fonts.Default)
		f23_local0.emailLabel:setText(playerData.email)
		f23_local0:addElement(f23_local0.emailLabel)
	end
	f23_local0:addSelectButton()
	return f23_local0
end

