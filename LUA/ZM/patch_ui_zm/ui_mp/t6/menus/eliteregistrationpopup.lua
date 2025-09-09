require("T6.Menus.EliteRegistrationEmailPopup")
CoD.EliteRegistrationPopup = {}
CoD.EliteRegistrationPopup.Width = 700
CoD.EliteRegistrationPopup.Height = 440
CoD.EliteRegistrationAutoFillPopup = {}
CoD.EliteRegistrationAutoFillPopup.NO_DATA_REF = ""
CoD.EliteRegistrationAutoFillPopup.processing_type = 0
CoD.EliteRegistrationAutoFillPopup.account_name_button = {}
CoD.EliteRegistrationAutoFillPopup.account_name_text = ""
CoD.EliteRegistrationAutoFillPopup.password_button = {}
CoD.EliteRegistrationAutoFillPopup.password_text = ""
CoD.EliteRegistrationAutoFillPopup.submit_button = {}
CoD.EliteRegistrationPopup.AddButton = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = f1_arg0.buttonList:addButton(f1_arg1)
	f1_local0:setActionEventName(f1_arg2)
	return f1_local0
end

CoD.EliteRegistrationPopup.YesButtonPressed = function (f2_arg0, f2_arg1)
	f2_arg0:goBack(f2_arg1.controller)
	f2_arg0.occludedMenu:processEvent({
		name = "elite_registration_email_popup_requested",
		controller = f2_arg1.controller
	})
end

CoD.EliteRegistrationPopup.NoButtonPressed = function (f3_arg0, f3_arg1)
	f3_arg0:goBack(f3_arg1.controller)
	f3_arg0.occludedMenu:processEvent({
		name = "elite_registration_ended",
		controller = f3_arg1.controller
	})
	Engine.EReg_PlayerRefusedOrError(f3_arg1.controller)
end

CoD.EliteRegistrationPopup.GoBack = function (f4_arg0, f4_arg1)
	Engine.Exec(f4_arg1, "resetThumbnailViewer")
	CoD.Menu.goBack(f4_arg0, f4_arg1)
end

CoD.EliteRegistrationPopup.GetLogoContainer = function (f5_arg0, f5_arg1)
	local f5_local0 = 230
	local f5_local1 = 90
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f5_local0, 0)
	Widget:setTopBottom(false, false, -(f5_local0 / 2) - f5_local1, f5_local0 / 2 - f5_local1)
	local f5_local3 = LUI.UIImage.new()
	f5_local3:setLeftRight(true, true, 0, 0)
	f5_local3:setTopBottom(true, true, 0, 0)
	f5_local3:setImage(RegisterMaterial("motd_elite_logo"))
	Widget:addElement(f5_local3)
	local f5_local4 = nil
	if f5_arg1 == true then
		f5_local4 = f5_arg0.founderImage
	else
		f5_local4 = f5_arg0.eliteImage
	end
	if f5_arg0 ~= nil and f5_arg0.isValid == true and f5_local4 ~= nil and f5_local4 ~= "" then
		local f5_local5 = f5_local0 * 1.5
		local f5_local6 = 120
		local f5_local7 = -60
		local f5_local8 = LUI.UIImage.new()
		f5_local8:setLeftRight(true, false, f5_local7, f5_local7 + f5_local5)
		f5_local8:setTopBottom(true, false, f5_local6, f5_local6 + f5_local5)
		f5_local8:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_MOTD, CoD.MOTD.GetImageFileID(f5_local4))
		Widget:addElement(f5_local8)
		Engine.Exec(controller, "addThumbnail " .. CoD.UI_SCREENSHOT_TYPE_MOTD .. " " .. CoD.MOTD.GetImageFileID(f5_local4) .. " 1")
	end
	return Widget
end

CoD.EliteRegistrationPopup.DescriptorsDone = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.controller
	f6_arg0.spinner:hide()
	local f6_local1 = Engine.GetMOTD()
	local f6_local2 = 0
	if CoD.perController[f6_local0].openedEliteFromLiveStream ~= true then
		f6_arg0:addTitle(Engine.Localize("MENU_MESSAGE_OF_THE_DAY"))
		f6_local2 = f6_local2 + CoD.textSize.Big + 30
		f6_arg0.codEliteLabel = LUI.UIText.new()
		f6_arg0.codEliteLabel:setLeftRight(true, true, 0, 0)
		f6_arg0.codEliteLabel:setTopBottom(true, false, f6_local2, f6_local2 + CoD.textSize.Big)
		f6_arg0.codEliteLabel:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		f6_arg0.codEliteLabel:setAlignment(LUI.Alignment.Left)
		f6_arg0.codEliteLabel:setFont(CoD.fonts.Big)
		f6_arg0.codEliteLabel:setText(Engine.Localize("MPUI_COD_ELITE_CAPS"))
		f6_arg0:addElement(f6_arg0.codEliteLabel)
		f6_local2 = f6_local2 + CoD.textSize.Big + 15
	else
		f6_arg0:addTitle(Engine.Localize("MPUI_COD_ELITE_CAPS"))
		f6_local2 = f6_local2 + CoD.textSize.Big + 15
		local f6_local3 = LUI.UIText.new()
		f6_local3:setLeftRight(true, true, 0, 0)
		f6_local3:setTopBottom(true, false, f6_local2, f6_local2 + CoD.textSize.Default)
		f6_local3:setAlignment(LUI.Alignment.Left)
		f6_local3:setFont(CoD.fonts.Default)
		f6_local3:setText(Engine.Localize("MPUI_LIVESTREAM_ELITE_MSG"))
		f6_local3:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		f6_local3:setAlpha(1)
		f6_arg0:addElement(f6_local3)
		f6_local2 = f6_local2 + CoD.textSize.Default * 2
	end
	if Engine.IsPlayerEliteRegistered(f6_local0) then
		f6_local2 = f6_local2 + CoD.textSize.Default * 1
		f6_arg0.benefit1Label = LUI.UIText.new()
		f6_arg0.benefit1Label:setLeftRight(true, false, 0, 530)
		f6_arg0.benefit1Label:setTopBottom(true, false, f6_local2, f6_local2 + CoD.textSize.Condensed)
		f6_arg0.benefit1Label:setAlignment(LUI.Alignment.Left)
		f6_arg0.benefit1Label:setFont(CoD.fonts.Condensed)
		f6_arg0.benefit1Label:setText(Engine.Localize("MPUI_ELITE_VERIFY_MSG2"))
		f6_arg0:addElement(f6_arg0.benefit1Label)
	else
		f6_arg0.signupLabel = LUI.UIText.new()
		f6_arg0.signupLabel:setLeftRight(true, false, 0, 415)
		f6_arg0.signupLabel:setTopBottom(true, false, f6_local2, f6_local2 + CoD.textSize.Default)
		f6_arg0.signupLabel:setAlignment(LUI.Alignment.Left)
		f6_arg0.signupLabel:setFont(CoD.fonts.Default)
		f6_arg0.signupLabel:setAlpha(0.4)
		f6_arg0.signupLabel:setText(Engine.Localize("MPUI_ELITE_ACTIVATE_MSG"))
		f6_arg0:addElement(f6_arg0.signupLabel)
		f6_local2 = f6_local2 + CoD.textSize.Default * 3
		local f6_local4 = 30
		f6_arg0.benefit1Label = LUI.UIText.new()
		f6_arg0.benefit1Label:setLeftRight(true, false, f6_local4, 530)
		f6_arg0.benefit1Label:setTopBottom(true, false, f6_local2, f6_local2 + CoD.textSize.Default)
		f6_arg0.benefit1Label:setAlignment(LUI.Alignment.Left)
		f6_arg0.benefit1Label:setFont(CoD.fonts.Default)
		f6_arg0.benefit1Label:setText(Engine.Localize("MPUI_ELITE_BENEFITS_1"))
		f6_arg0:addElement(f6_arg0.benefit1Label)
	end
	f6_arg0:addElement(CoD.EliteRegistrationPopup.GetLogoContainer(f6_local1, false))
	local f6_local5 = "Default"
	local f6_local6 = CoD.fonts[f6_local5]
	local f6_local7 = CoD.textSize[f6_local5] * 2 + 2
	local f6_local8 = 10
	local f6_local9 = CoD.Menu.Width - f6_local8 * 2
	local f6_local10 = CoD.ButtonPrompt.Height + 20
	local f6_local11 = 4
	local f6_local12 = "Default"
	local f6_local13 = CoD.fonts[f6_local12]
	local f6_local14 = CoD.textSize[f6_local12]
	local f6_local15 = 350
	local f6_local16 = f6_local14 + 8
	local f6_local17 = f6_local10 + f6_local7 + 15
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f6_local8, f6_local8 + f6_local15)
	Widget:setTopBottom(false, true, -f6_local17 - f6_local16, -f6_local17)
	f6_arg0:addElement(Widget)
	local f6_local19 = LUI.UIImage.new()
	f6_local19:setLeftRight(true, true, 1, -1)
	f6_local19:setTopBottom(true, true, 1, -1)
	f6_local19:setRGB(0, 0, 0)
	f6_local19:setAlpha(0.6)
	Widget:addElement(f6_local19)
	local f6_local20 = LUI.UIImage.new()
	f6_local20:setLeftRight(true, true, f6_local11, -f6_local11)
	f6_local20:setTopBottom(true, false, f6_local11, f6_local7 * 0.6)
	f6_local20:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f6_local20:setAlpha(0.1)
	Widget:addElement(f6_local20)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 8, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	Widget:addElement(f6_arg0.activateButton)
	Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget:addElement(Widget.border)
end

LUI.createMenu.EliteRegistrationPopup = function (f7_arg0)
	local f7_local0 = CoD.Menu.New("EliteRegistrationPopup")
	f7_local0:setOwner(f7_arg0)
	f7_local0:addLargePopupBackground()
	f7_local0.goBack = CoD.EliteRegistrationPopup.GoBack
	f7_local0:registerEventHandler("EliteRegistrationPopup_YesButtonPressed", CoD.EliteRegistrationPopup.YesButtonPressed)
	f7_local0:registerEventHandler("EliteRegistrationPopup_NoButtonPressed", CoD.EliteRegistrationPopup.NoButtonPressed)
	f7_local0:registerEventHandler("AutoFillPopup_Closed", CoD.EliteRegistrationPopup.AutoFillPopup_Closed)
	f7_local0:registerEventHandler("motd_image_descriptors_done", CoD.EliteRegistrationPopup.DescriptorsDone)
	f7_local0:registerEventHandler("signed_out", CoD.EliteRegistrationEmailPopup.SignedOut)
	if CoD.perController[f7_arg0].openedEliteFromLiveStream ~= true then
		f7_local0:addSelectButton(Engine.Localize("MENU_MOTD_ACCEPT"), nil, "EliteRegistrationPopup_NoButtonPressed")
	end
	f7_local0:addBackButton()
	local f7_local1 = "MPUI_ELITE_ENLIST_YES"
	if Engine.IsPlayerEliteRegistered(f7_arg0) then
		f7_local1 = "MPUI_ELITE_ENLIST2_YES"
	end
	f7_local0.activateButton = CoD.ButtonPrompt.new("alt1", Engine.Localize(f7_local1), f7_local0, "EliteRegistrationPopup_YesButtonPressed")
	f7_local0.spinner = LUI.UIImage.new()
	f7_local0.spinner:setLeftRight(false, false, -32, 32)
	f7_local0.spinner:setTopBottom(false, false, -32, 32)
	f7_local0.spinner:setImage(RegisterMaterial("lui_loader"))
	f7_local0:addElement(f7_local0.spinner)
	Engine.Exec(f7_arg0, "resetThumbnailViewer")
	Engine.Exec(f7_arg0, "motdGetImageDescriptors")
	return f7_local0
end

CoD.EliteRegistrationAutoFillPopup.Accept = function (f8_arg0, f8_arg1)
	f8_arg0:goBack(f8_arg1.controller)
	Engine.PlayerRequestedAutoFill(f8_arg1.controller, true)
	f8_arg0.occludedMenu:processEvent({
		name = "AutoFillPopup_Closed",
		controller = f8_arg1.controller
	})
end

CoD.EliteRegistrationAutoFillPopup.Refuse = function (f9_arg0, f9_arg1)
	f9_arg0:goBack(f9_arg1.controller)
	Engine.PlayerRequestedAutoFill(f9_arg1.controller, false)
	f9_arg0.occludedMenu:processEvent({
		name = "AutoFillPopup_Closed",
		controller = f9_arg1.controller
	})
end

CoD.EliteRegistrationAutoFillPopup.retrieved_get_user_details_result = function (f10_arg0, f10_arg1)
	local f10_local0 = nil
	if f10_arg1.success ~= nil then
		f10_arg0:goBack(f10_arg1.controller)
		f10_arg0.occludedMenu:processEvent({
			name = "AutoFillPopup_Closed",
			controller = f10_arg1.controller,
			password = CoD.EliteRegistrationAutoFillPopup.password_text
		})
	elseif f10_arg1.login_fail then
		CoD.EliteRegistrationAutoFillPopup.account_name_button:showRestrictedIcon(true)
		CoD.EliteRegistrationAutoFillPopup.password_button:showRestrictedIcon(true)
		CoD.EliteRegistrationAutoFillPopup.account_name_button.hintText = Engine.Localize("MPUI_HINTTEXT_ERROR_UCD_PASSWORD")
		CoD.EliteRegistrationAutoFillPopup.password_button.hintText = Engine.Localize("MPUI_HINTTEXT_ERROR_UCD_PASSWORD")
		CoD.EliteRegistrationAutoFillPopup.account_name_button:processEvent({
			name = "gain_focus"
		})
		CoD.EliteRegistrationAutoFillPopup.submit_button:processEvent({
			name = "lose_focus"
		})
	else
		f10_arg0:goBack(f10_arg1.controller)
		f10_arg0.occludedMenu:processEvent({
			name = "AutoFillPopup_Closed",
			controller = f10_arg1.controller,
			fail = true
		})
	end
end

CoD.EliteRegistrationAutoFillPopup.Submit = function (f11_arg0, f11_arg1)
	Engine.UCDLoginAttempt(f11_arg1.controller, CoD.EliteRegistrationAutoFillPopup.account_name_text, CoD.EliteRegistrationAutoFillPopup.password_text)
end

CoD.EliteRegistrationAutoFillPopup.AddButton = function (f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = f12_arg0.buttonList:addButton(f12_arg1)
	f12_local0:setActionEventName(f12_arg2)
	return f12_local0
end

CoD.EliteRegistrationAutoFillPopup.AddNonRegistrationButton = function (f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = CoD.ButtonList.AddButton(f13_arg0.buttonList, f13_arg1)
	f13_local0:setActionEventName(f13_arg2)
	return f13_local0
end

CoD.EliteRegistrationAutoFillPopup.account_name_button_pressed = function (f14_arg0, f14_arg1)
	CoD.EliteRegistrationAutoFillPopup.processing_type = 0
	KeyboardExec(f14_arg1.controller, "MPUI_ENTER_UCD_ACCOUNT_NAME", CoD.EliteRegistrationAutoFillPopup.account_name_text, 21, CoD.KEYBOARD_TYPE_REGISTRATION_INPUT_ACCOUNTNAME, 0)
end

CoD.EliteRegistrationAutoFillPopup.password_button_pressed = function (f15_arg0, f15_arg1)
	CoD.EliteRegistrationAutoFillPopup.processing_type = 1
	KeyboardExec(f15_arg1.controller, "MPUI_ENTER_PASSWORD", CoD.EliteRegistrationAutoFillPopup.password_text, 21, CoD.KEYBOARD_TYPE_REGISTRATION_INPUT_PASSWORD, 1)
end

local f0_local0 = function (f16_arg0, f16_arg1, f16_arg2, f16_arg3, f16_arg4)
	local f16_local0 = false
	if f16_arg1 == "" or f16_arg1 == 0 then
		f16_local0 = true
	end
	if f16_local0 then
		f16_arg2:showRestrictedIcon(true)
	else
		f16_arg2:showRestrictedIcon(false)
	end
	return f16_local0
end

CoD.EliteRegistrationAutoFillPopup.ObtainedKeyboardInput = function (f17_arg0, f17_arg1)
	local f17_local0 = f17_arg0.m_ownerController
	local f17_local1 = ""
	if f17_arg1.input ~= nil then
		if CoD.EliteRegistrationAutoFillPopup.processing_type == 0 then
			CoD.EliteRegistrationAutoFillPopup.account_name_text = f17_arg1.input
			CoD.EliteRegistrationAutoFillPopup.account_name_button:setLabel(GetDisplayedText(CoD.EliteRegistrationAutoFillPopup.account_name_text))
			if f0_local0(f17_arg0, f17_arg1.input, CoD.EliteRegistrationAutoFillPopup.account_name_button) then
				CoD.EliteRegistrationAutoFillPopup.account_name_button:showRestrictedIcon(true)
				CoD.EliteRegistrationAutoFillPopup.account_name_button.hintText = Engine.Localize("MPUI_HINTTEXT_NODATA_ERROR")
			else
				CoD.EliteRegistrationAutoFillPopup.account_name_button:showRestrictedIcon(false)
				CoD.EliteRegistrationAutoFillPopup.account_name_button.hintText = Engine.Localize("MPUI_HINTTEXT_UCD_ACCOUNT_NAME")
			end
			CoD.EliteRegistrationAutoFillPopup.account_name_button:processEvent({
				name = "gain_focus"
			})
		elseif CoD.EliteRegistrationAutoFillPopup.processing_type == 1 then
			CoD.EliteRegistrationAutoFillPopup.password_text = f17_arg1.input
			CoD.EliteRegistrationAutoFillPopup.password_button:setLabel(GetDisplayedPassword(CoD.EliteRegistrationAutoFillPopup.password_text))
			if f0_local0(f17_arg0, f17_arg1.input, CoD.EliteRegistrationAutoFillPopup.password_button) then
				CoD.EliteRegistrationAutoFillPopup.password_button:showRestrictedIcon(true)
				CoD.EliteRegistrationAutoFillPopup.password_button.hintText = Engine.Localize("MPUI_HINTTEXT_NODATA_ERROR")
			else
				CoD.EliteRegistrationAutoFillPopup.password_button:showRestrictedIcon(false)
				CoD.EliteRegistrationAutoFillPopup.password_button.hintText = Engine.Localize("MPUI_HINTTEXT_UCD_PASSWORD")
			end
			CoD.EliteRegistrationAutoFillPopup.password_button:processEvent({
				name = "gain_focus"
			})
		end
	end
end

LUI.createMenu.EliteRegistrationAutoFillPopup = function (f18_arg0, f18_arg1)
	local f18_local0 = CoD.Menu.NewMediumPopup("EliteRegistrationAutoFillPopup")
	f18_local0:addTitle(Engine.Localize("MPUI_TITLE_AUTOFILL"))
	f18_local0.goBack = CoD.EliteRegistrationPopup.GoBack
	Engine.Exec(f18_arg0, "resetThumbnailViewer")
	local f18_local1 = Engine.GetMOTD()
	CoD.EliteRegistrationAutoFillPopup.account_name_text = ""
	CoD.EliteRegistrationAutoFillPopup.password_text = ""
	f18_local0:addSelectButton()
	f18_local0:addBackButton()
	local f18_local2 = CoD.textSize.Big + 20
	f18_local0:registerEventHandler("signed_out", CoD.EliteRegistrationEmailPopup.SignedOut)
	if f18_arg1 ~= nil and f18_arg1.hasUCDAccount then
		f18_local0:registerEventHandler("EliteRegistrationAutoFillPopup_Submit", CoD.EliteRegistrationAutoFillPopup.Submit)
		f18_local0:registerEventHandler("account_name_button_pressed", CoD.EliteRegistrationAutoFillPopup.account_name_button_pressed)
		f18_local0:registerEventHandler("password_button_pressed", CoD.EliteRegistrationAutoFillPopup.password_button_pressed)
		f18_local0:registerEventHandler("ui_keyboard_input", CoD.EliteRegistrationAutoFillPopup.ObtainedKeyboardInput)
		f18_local0:registerEventHandler("retrieved_get_user_details_result", CoD.EliteRegistrationAutoFillPopup.retrieved_get_user_details_result)
		f18_local0.message = LUI.UIText.new()
		f18_local0.message:setLeftRight(true, true, 0, 0)
		f18_local0.message:setTopBottom(true, false, f18_local2, f18_local2 + CoD.textSize.Default)
		f18_local0.message:setFont(CoD.fonts.Default)
		f18_local0.message:setAlignment(LUI.Alignment.Left)
		f18_local0.message:setText(UIExpression.GetSelfGamertag(f18_arg0) .. ", " .. Engine.Localize("MPUI_AUTOFILL_UCDACCOUNT_DETECTED"))
		f18_local0:addElement(f18_local0.message)
		f18_local2 = f18_local2 + CoD.textSize.Default * 2
		f18_local0.message2 = LUI.UIText.new()
		f18_local0.message2:setLeftRight(true, true, 0, 0)
		f18_local0.message2:setTopBottom(true, false, f18_local2, f18_local2 + CoD.textSize.Default)
		f18_local0.message2:setFont(CoD.fonts.Default)
		f18_local0.message2:setAlignment(LUI.Alignment.Left)
		f18_local0.message2:setText(Engine.Localize("MPUI_AUTOFILL_UCDACCOUNT_DETECTED_2"))
		f18_local0:addElement(f18_local0.message2)
		f18_local2 = f18_local2 + CoD.textSize.Default * 2.5
		local f18_local3 = 0
		f18_local0.hintText = CoD.HintText.new({
			leftAnchor = true,
			rightAnchor = false,
			left = 0,
			right = CoD.Menu.Width,
			topAnchor = true,
			bottomAnchor = false,
			top = 350,
			bottom = CoD.HintText.Height
		})
		f18_local0.hintText.hintArrow:setTopBottom(true, false, 0, CoD.HintText.Height)
		f18_local0.hintText.hint:setLeftRight(true, true, CoD.HintText.Height - 13, 0)
		f18_local0:addElement(f18_local0.hintText)
		local f18_local4 = -650
		local f18_local5 = 10
		local f18_local6 = 40
		f18_local0.buttonList = CoD.ButtonList.new({
			leftAnchor = true,
			rightAnchor = false,
			left = 250,
			right = 250 + CoD.ButtonList.DefaultWidth - 20,
			topAnchor = true,
			bottomAnchor = true,
			top = f18_local2,
			bottom = 0
		}, 10, nil, f18_local0.hintText)
		f18_local0.buttonList.addButton = CoD.ButtonList.AddRegistrationButton
		f18_local0:addElement(f18_local0.buttonList)
		CoD.EliteRegistrationAutoFillPopup.account_name_button = CoD.EliteRegistrationAutoFillPopup.AddButton(f18_local0, GetDisplayedText(CoD.EliteRegistrationAutoFillPopup.account_name_text), "account_name_button_pressed")
		CoD.EliteRegistrationAutoFillPopup.account_name_button.hintText = Engine.Localize("MPUI_HINTTEXT_UCD_ACCOUNT_NAME")
		CoD.EliteRegistrationAutoFillPopup.account_name_button:processEvent({
			name = "gain_focus"
		})
		CoD.EliteRegistrationAutoFillPopup.password_button = CoD.EliteRegistrationAutoFillPopup.AddButton(f18_local0, GetDisplayedPassword(CoD.EliteRegistrationAutoFillPopup.password_text), "password_button_pressed")
		CoD.EliteRegistrationAutoFillPopup.password_button.hintText = Engine.Localize("MPUI_HINTTEXT_UCD_PASSWORD")
		CoD.EliteRegistrationAutoFillPopup.submit_button = CoD.EliteRegistrationAutoFillPopup.AddNonRegistrationButton(f18_local0, Engine.Localize("MPUI_CONFIRM_INFO"), "EliteRegistrationAutoFillPopup_Submit")
		f18_local5 = f18_local5 + f18_local6
		f18_local0.li_account = LUI.UIText.new()
		f18_local0.li_account:setLeftRight(true, true, f18_local3, f18_local4)
		f18_local0.li_account:setTopBottom(true, false, f18_local2, f18_local2 + CoD.textSize.Default)
		f18_local0.li_account:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
		f18_local0.li_account:setAlignment(LUI.Alignment.Right)
		f18_local0.li_account:setFont(CoD.fonts.Default)
		f18_local0.li_account:setText(Engine.Localize("MPUI_REGISTRATION_UCD_ACCOUNT_NAME"))
		f18_local0:addElement(f18_local0.li_account)
		f18_local2 = f18_local2 + f18_local6
		f18_local5 = f18_local5 + f18_local6
		f18_local0.li_password = LUI.UIText.new()
		f18_local0.li_password:setLeftRight(true, true, f18_local3, f18_local4)
		f18_local0.li_password:setTopBottom(true, false, f18_local2, f18_local2 + CoD.textSize.Default)
		f18_local0.li_password:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
		f18_local0.li_password:setAlignment(LUI.Alignment.Right)
		f18_local0.li_password:setFont(CoD.fonts.Default)
		f18_local0.li_password:setText(Engine.Localize("MPUI_EMAIL_REGISTRATION_POPUP_PASSWORD"))
		f18_local0:addElement(f18_local0.li_password)
	else
		f18_local0:registerEventHandler("EliteRegistrationAutoFillPopup_Accept", CoD.EliteRegistrationAutoFillPopup.Accept)
		f18_local0:registerEventHandler("EliteRegistrationAutoFillPopup_Refuse", CoD.EliteRegistrationAutoFillPopup.Refuse)
		f18_local0.message = LUI.UIText.new()
		f18_local0.message:setLeftRight(true, false, 0, 520)
		f18_local0.message:setTopBottom(true, false, f18_local2, f18_local2 + CoD.textSize.Default)
		f18_local0.message:setFont(CoD.fonts.Default)
		f18_local0.message:setAlignment(LUI.Alignment.Left)
		f18_local0.message:setText(Engine.Localize("MPUI_AUTOFILL_MSG1"))
		f18_local0:addElement(f18_local0.message)
		f18_local2 = f18_local2 + CoD.textSize.Default * 3
		f18_local0.message2 = LUI.UIText.new()
		f18_local0.message2:setLeftRight(true, false, 0, 520)
		f18_local0.message2:setTopBottom(true, false, f18_local2, f18_local2 + CoD.textSize.Default)
		f18_local0.message2:setFont(CoD.fonts.Default)
		f18_local0.message2:setAlignment(LUI.Alignment.Left)
		f18_local0.message2:setText(Engine.Localize("MPUI_AUTOFILL_MSG2"))
		f18_local0:addElement(f18_local0.message2)
		local f18_local3 = CoD.ButtonList.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = false,
			bottomAnchor = true,
			top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
			bottom = 0
		})
		f18_local0:addElement(f18_local3)
		local f18_local7 = f18_local3:addButton(Engine.Localize("MENU_ACCEPT"))
		f18_local7:setActionEventName("EliteRegistrationAutoFillPopup_Accept")
		local f18_local8 = f18_local3:addButton(Engine.Localize("MENU_REFUSE"))
		f18_local8:setActionEventName("EliteRegistrationAutoFillPopup_Refuse")
		f18_local8:processEvent({
			name = "gain_focus"
		})
	end
	f18_local0:addElement(CoD.EliteRegistrationPopup.GetLogoContainer(f18_local1, false))
	return f18_local0
end

