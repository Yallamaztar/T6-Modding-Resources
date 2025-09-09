require("T6.TextFieldButton")
CoD.Twitter = {}
function Twitter_Connect_UpdateKeyboard(f1_arg0, f1_arg1)
	if f1_arg1.type == CoD.KEYBOARD_TYPE_TWITTER_USER then
		f1_arg0.loginContainer.userNameButton:setText(f1_arg1.input)
		f1_arg0.loginContainer.userNameButton.text = f1_arg1.input
	elseif f1_arg1.type == CoD.KEYBOARD_TYPE_TWITTER_PASS then
		f1_arg0.loginContainer.passwordButton:setText(CoD.TextFieldButton.ConvertToStar(f1_arg1.input))
		f1_arg0.loginContainer.passwordButton.text = f1_arg1.input
	end
end

function Twitter_Connect_EditUserName(f2_arg0, f2_arg1)
	Engine.Exec(f2_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_TWITTER_USER)
end

function Twitter_Connect_EditPassword(f3_arg0, f3_arg1)
	Engine.Exec(f3_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_TWITTER_PASS)
end

function Twitter_Connect_Back(f4_arg0, f4_arg1)
	f4_arg0:goBack()
end

function Twitter_Connect_ProcessLogin(f5_arg0, f5_arg1)
	f5_arg0.loginContainer:setAlpha(0)
	f5_arg0.spinner:setAlpha(1)
	f5_arg0.title:setText(Engine.Localize("MENU_CONNECTING_TO_TWITTER"))
	f5_arg0:removeBackButton()
	f5_arg0:removeSelectButton()
	if f5_arg0.fromLiveStreamMenu == true then
		f5_arg0:setPreviousMenu(nil)
	end
	Engine.Exec(f5_arg1.controller, "twitterRegister " .. f5_arg0.loginContainer.userNameButton.text .. " " .. f5_arg0.loginContainer.passwordButton.text)
end

function Twitter_Connect_Success(f6_arg0, f6_arg1)
	if f6_arg0.fromLiveStreamMenu == true then
		f6_arg0:goBack(f6_arg1.controller)
		f6_arg0.occludedMenu:processEvent({
			name = "livestream_send_to_twitter",
			controller = f6_arg1.controller
		})
	else
		f6_arg0.title:setText(Engine.Localize("MENU_NOTICE"))
		f6_arg0.msg:setText(Engine.Localize("MENU_TWITTER_REGISTERATION_SUCCESS"))
		f6_arg0.spinner:setAlpha(0)
		f6_arg0.occludedMenu:processEvent({
			name = "twitter_connect_complete",
			controller = f6_arg1.controller
		})
		f6_arg0:addSelectButton(Engine.Localize("MPUI_OK"), 100, "button_prompt_back")
	end
end

function Twitter_Connect_Error(f7_arg0, f7_arg1)
	f7_arg0.title:setText(Engine.Localize("MENU_ERROR"))
	f7_arg0.msg:setText(f7_arg1.errorMessage)
	f7_arg0.spinner:setAlpha(0)
	f7_arg0:addSelectButton(Engine.Localize("MPUI_OK"), 100, "button_prompt_back")
end

LUI.createMenu.Twitter_Connect = function (f8_arg0)
	local f8_local0 = 480
	local f8_local1 = 290
	local f8_local2 = CoD.Popup.SetupPopup("Twitter_Connect", f8_arg0, CoD.Popup.Type.STRETCHED)
	f8_local2:setWidthHeight(f8_local0, f8_local1)
	f8_local2:setOwner(f8_arg0)
	f8_local2.fromLiveStreamMenu = CoD.perController[f8_arg0].fromLiveStreamMenu
	f8_local2:registerEventHandler("edit_username", Twitter_Connect_EditUserName)
	f8_local2:registerEventHandler("edit_password", Twitter_Connect_EditPassword)
	f8_local2:registerEventHandler("button_prompt_back", Twitter_Connect_Back)
	f8_local2:registerEventHandler("ui_keyboard_input", Twitter_Connect_UpdateKeyboard)
	f8_local2:registerEventHandler("twitter_login", Twitter_Connect_ProcessLogin)
	f8_local2:registerEventHandler("live_dw_twitter_success", Twitter_Connect_Success)
	f8_local2:registerEventHandler("live_dw_twitter_error", Twitter_Connect_Error)
	local f8_local3 = 64
	local f8_local4 = 64
	f8_local2.spinner = LUI.UIImage.new({
		shaderVector0 = {
			0,
			0,
			0,
			0
		}
	})
	f8_local2.spinner:setLeftRight(true, true, CoD.Menu.SmallPopupWidth / 2 - f8_local4 / 2, -(CoD.Menu.SmallPopupWidth / 2 - f8_local4 / 2))
	f8_local2.spinner:setTopBottom(true, true, CoD.Menu.SmallPopupHeight / 2 - f8_local3 / 2, -(CoD.Menu.SmallPopupHeight / 2 - f8_local3 / 2))
	f8_local2.spinner:setImage(RegisterMaterial("lui_loader"))
	f8_local2.spinner:setAlpha(0)
	f8_local2:addElement(f8_local2.spinner)
	f8_local2.title:setText(Engine.Localize("MENU_TWITTER_LOGIN"))
	f8_local2:addSelectButton(Engine.Localize("MPUI_OK"))
	f8_local2:addBackButton()
	f8_local2.loginContainer = LUI.UIContainer.new()
	f8_local2.loginContainer:setLeftRight(true, true, 0, 0)
	f8_local2.loginContainer:setTopBottom(true, true, 0, 0)
	f8_local2.loginContainer.visible = true
	f8_local2.loginContainer:setAlpha(1)
	f8_local2:addElement(f8_local2.loginContainer)
	local f8_local5 = LUI.UIVerticalList.new()
	f8_local5:setLeftRight(true, true, 10, -10)
	f8_local5:setTopBottom(true, true, 55, 0)
	f8_local5:setSpacing(5)
	f8_local2.loginContainer:addElement(f8_local5)
	local f8_local6 = LUI.UIText.new()
	f8_local6:setLeftRight(true, true, 0, 0)
	f8_local6:setTopBottom(true, false, 0, CoD.textSize.Default)
	f8_local6:setFont(CoD.fonts.Default)
	f8_local6:setAlignment(LUI.Alignment.Left)
	f8_local6:setText(Engine.Localize("MENU_USERNAME") .. ":")
	f8_local5:addElement(f8_local6)
	local f8_local7 = CoD.TextFieldButton.new("", "edit_username")
	f8_local5:addElement(f8_local7)
	f8_local7.text = "None"
	f8_local2.loginContainer.userNameButton = f8_local7
	local f8_local8 = LUI.UIText.new()
	f8_local8:setLeftRight(true, true, 0, 0)
	f8_local8:setTopBottom(true, false, 0, CoD.textSize.Default)
	f8_local8:setFont(CoD.fonts.Default)
	f8_local8:setAlignment(LUI.Alignment.Left)
	f8_local8:setText(Engine.Localize("MENU_PASSWORD") .. ":")
	f8_local5:addElement(f8_local8)
	local f8_local9 = CoD.TextFieldButton.new("", "edit_password")
	f8_local5:addElement(f8_local9)
	f8_local9.text = "None"
	f8_local2.loginContainer.passwordButton = f8_local9
	f8_local5:addSpacer(20)
	local f8_local10 = CoD.TextFieldButton.new(Engine.Localize("MENU_LOGIN_CAPS"), "twitter_login", LUI.Alignment.Center)
	f8_local5:addElement(f8_local10)
	f8_local2.loginContainer.loginButton = f8_local10
	f8_local2.loginContainer.loginButton:processEvent({
		name = "gain_focus",
		controller = f8_arg0
	})
	return f8_local2
end

local f0_local0 = function (f9_arg0, f9_arg1)
	if f9_arg1.error then
		f9_arg0.title:setText(Engine.Localize("MENU_ERROR"))
		f9_arg0.msg:setText(Engine.Localize("MENU_TWITTER_UNLINK_FAILED"))
	else
		f9_arg0.title:setText(Engine.Localize("MENU_NOTICE"))
		f9_arg0.msg:setText(Engine.Localize("MENU_TWITTER_UNLINK_SUCCESS"))
	end
	f9_arg0.spinner:setAlpha(0)
	f9_arg0:addSelectButton(Engine.Localize("MPUI_OK"), 100, "button_prompt_back")
	f9_arg0.occludedMenu:processEvent({
		name = "twitter_connect_complete",
		controller = f9_arg1.controller
	})
end

LUI.createMenu.Twitter_UnRegister = function (f10_arg0)
	local f10_local0 = CoD.Popup.SetupPopupBusy("Twitter_UnRegister", f10_arg0)
	f10_local0:registerEventHandler("live_dw_twitter_unlink_complete", f0_local0)
	f10_local0.title:setText(Engine.Localize("MENU_UNLINKING_ACCOUNT"))
	Engine.Exec(f10_arg0, "twitterUnregister")
	return f10_local0
end

