LUI.createMenu.LiveStream_Login = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("LiveStream_Login")
	f1_local0:setOwner(f1_arg0)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("edit_username", LiveStream_Login_EditUserName)
	f1_local0:registerEventHandler("edit_password", LiveStream_Login_EditPassword)
	f1_local0:registerEventHandler("livestream_login", LiveStream_Login_ProcessLogin)
	f1_local0:registerEventHandler("button_prompt_back", LiveStream_Login_Back)
	f1_local0:registerEventHandler("update_login_process", LiveStream_Login_Update)
	f1_local0:registerEventHandler("ui_keyboard_input", LiveStream_Login_UpdateKeyboard)
	local f1_local1 = Engine.GetPlayerStats(f1_arg0)
	f1_local0.authToken = f1_local1.liveStreamingAuthToken:get()
	f1_local0.loginContainer = LUI.UIContainer.new()
	f1_local0.loginContainer:setLeftRight(true, true, 0, 0)
	f1_local0.loginContainer:setTopBottom(true, true, 0, 0)
	f1_local0.loginContainer.visible = true
	f1_local0.loginContainer:setAlpha(1)
	f1_local0:addElement(f1_local0.loginContainer)
	local f1_local2 = 5
	local f1_local3 = LUI.UIText.new()
	f1_local3:setLeftRight(true, true, 0, 0)
	f1_local3:setTopBottom(true, false, f1_local2, f1_local2 + CoD.textSize.Condensed)
	f1_local3:setFont(CoD.fonts.Condensed)
	f1_local3:setAlignment(LUI.Alignment.Left)
	f1_local3:setText(Engine.Localize("MENU_TWITCH_LOGIN"))
	f1_local0.loginContainer:addElement(f1_local3)
	f1_local2 = f1_local2 + 30
	local f1_local4 = LUI.UIText.new()
	f1_local4:setLeftRight(true, true, 0, 0)
	f1_local4:setTopBottom(true, false, f1_local2, f1_local2 + CoD.textSize.Default)
	f1_local4:setFont(CoD.fonts.Default)
	f1_local4:setAlignment(LUI.Alignment.Left)
	f1_local4:setText(Engine.Localize("MENU_USERNAME") .. ":")
	f1_local0.loginContainer:addElement(f1_local4)
	f1_local2 = f1_local2 + CoD.textSize.Default
	local f1_local5 = CoD.ButtonList.new({})
	f1_local5:setLeftRight(true, true, 0, 0)
	f1_local5:setTopBottom(true, true, f1_local2, 10)
	f1_local5:setFont(CoD.fonts.Default)
	f1_local5:setSpacing(CoD.textSize.Default + 5)
	f1_local0.loginContainer:addElement(f1_local5)
	local f1_local6 = Engine.GetPlayerStats(f1_arg0)
	f1_local6 = f1_local6.liveStreamingAuthUsername
	local f1_local7 = f1_local6:get()
	if f1_local7 == "" then
		f1_local7 = Dvar.webm_httpAuthLogin:get()
		if f1_local7 == "" then
			f1_local7 = Engine.Localize("MENU_EMPTY")
		end
	else
		Dvar.webm_httpAuthLogin:set(f1_local6)
	end
	local f1_local8 = f1_local5:addButton(f1_local7)
	f1_local8:setActionEventName("edit_username")
	f1_local0.loginContainer.userNameButton = f1_local8
	f1_local2 = f1_local2 + CoD.CoD9Button.Height + 5
	local f1_local9 = LUI.UIText.new()
	f1_local9:setLeftRight(true, true, 0, 0)
	f1_local9:setTopBottom(true, false, f1_local2, f1_local2 + CoD.textSize.Default)
	f1_local9:setFont(CoD.fonts.Default)
	f1_local9:setAlignment(LUI.Alignment.Left)
	f1_local9:setText(Engine.Localize("MENU_PASSWORD") .. ":")
	f1_local0.loginContainer:addElement(f1_local9)
	local f1_local10 = f1_local5:addButton(LiveStream_Login_ConvertPasswordToStar(Dvar.webm_httpAuthPass:get()))
	f1_local10:setActionEventName("edit_password")
	f1_local0.loginContainer.passwordButton = f1_local10
	local f1_local11 = f1_local5:addButton(Engine.Localize("MENU_LOGIN_CAPS"))
	f1_local11:setActionEventName("livestream_login")
	f1_local11:processEvent({
		name = "gain_focus"
	})
	f1_local0.loginProcessingContainer = LUI.UIContainer.new()
	f1_local0.loginProcessingContainer:setLeftRight(true, true, 0, 0)
	f1_local0.loginProcessingContainer:setTopBottom(true, true, 0, 0)
	f1_local0.loginProcessingContainer.visible = false
	f1_local0.loginProcessingContainer:setAlpha(0)
	f1_local0:addElement(f1_local0.loginProcessingContainer)
	local f1_local12 = 64
	local f1_local13 = 64
	f1_local0.spinner = LUI.UIImage.new({
		shaderVector0 = {
			0,
			0,
			0,
			0
		}
	})
	f1_local0.spinner:setLeftRight(false, false, -(f1_local13 / 2), f1_local13 / 2)
	f1_local0.spinner:setTopBottom(false, false, -(f1_local12 / 2), f1_local12 / 2)
	f1_local0.spinner:setImage(RegisterMaterial("lui_loader"))
	f1_local0.loginProcessingContainer:addElement(f1_local0.spinner)
	f1_local2 = 35
	local f1_local14 = LUI.UIText.new()
	f1_local14:setLeftRight(true, true, 0, 0)
	f1_local14:setTopBottom(true, false, f1_local2, f1_local2 + CoD.textSize.Default)
	f1_local14:setFont(CoD.fonts.Default)
	f1_local14:setAlignment(LUI.Alignment.Center)
	f1_local14:setText(Engine.Localize("MENU_CONNECTING_TO_TWITCH"))
	f1_local0.loginProcessingContainer:addElement(f1_local14)
	f1_local0.loginTimer = LUI.UITimer.new(500, {
		name = "update_login_process",
		controller = f1_arg0
	}, false)
	f1_local0:addElement(f1_local0.loginTimer)
	if f1_local0.authToken ~= "" then
		f1_local0:processEvent({
			name = "livestream_login",
			controller = f1_arg0
		})
	end
	return f1_local0
end

function LiveStream_Login_ConvertPasswordToStar(f2_arg0)
	if f2_arg0 == "" then
		f2_arg0 = Engine.Localize("MENU_EMPTY")
	end
	local f2_local0 = string.len(f2_arg0)
	local f2_local1 = ""
	for f2_local2 = 1, f2_local0, 1 do
		local f2_local5 = f2_local2
		f2_local1 = "*" .. f2_local1
	end
	return f2_local1
end

function LiveStream_Login_UpdateKeyboard(f3_arg0, f3_arg1)
	if f3_arg1.type == CoD.KEYBOARD_TYPE_LIVESTREAM_USER then
		Dvar.webm_httpAuthLogin:set(f3_arg1.input)
		f3_arg0.loginContainer.userNameButton:setLabel(f3_arg1.input)
	elseif f3_arg1.type == CoD.KEYBOARD_TYPE_LIVESTREAM_PASS then
		Dvar.webm_httpAuthPass:set(f3_arg1.input)
		f3_arg0.loginContainer.passwordButton:setLabel(LiveStream_Login_ConvertPasswordToStar(f3_arg1.input))
	end
end

function LiveStream_Login_EditUserName(f4_arg0, f4_arg1)
	Engine.Exec(f4_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_LIVESTREAM_USER)
end

function LiveStream_Login_EditPassword(f5_arg0, f5_arg1)
	Engine.Exec(f5_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_LIVESTREAM_PASS)
end

function LiveStream_Login_Back(f6_arg0, f6_arg1)
	f6_arg0:goBack()
end

function LiveStream_Login_ProcessLogin(f7_arg0, f7_arg1)
	if f7_arg0.loginProcessStarted then
		return 
	end
	local f7_local0 = f7_arg1.controller
	if f7_arg0.authToken ~= "" then
		Engine.LivestreamEnable(f7_local0)
		Dvar.webm_httpAuthToken:set(f7_arg0.authToken)
		Dvar.webm_encStreamEnabled:set(true)
	else
		Engine.LivestreamDisable(f7_local0)
		Engine.LivestreamEnable(f7_local0)
		local f7_local1 = Engine.GetPlayerStats(f7_local0)
		f7_local1.liveStreamingAuthUsername:set(Dvar.webm_httpAuthLogin:get())
		Dvar.webm_httpAuthToken:set("")
		Dvar.webm_encStreamEnabled:set(true)
	end
	f7_arg0.loginContainer:setAlpha(0)
	f7_arg0.loginContainer.visible = false
	f7_arg0.loginProcessingContainer:setAlpha(1)
	f7_arg0.loginProcessingContainer.visible = true
	f7_arg0.loginProcessStarted = true
end

function LiveStream_Login_Update(f8_arg0, f8_arg1)
	if not f8_arg0.loginProcessStarted then
		return 
	elseif Dvar.webm_encStatus:get() ~= "streaming" and Dvar.webm_encStreamEnabled:get() == true then
		return 
	end
	local f8_local0 = f8_arg1.controller
	if Dvar.webm_encStatus:get() ~= "streaming" then
		f8_arg0.loginContainer:setAlpha(1)
		f8_arg0.loginContainer.visible = true
		f8_arg0.loginProcessingContainer:setAlpha(0)
		f8_arg0.loginProcessingContainer.visible = false
		local f8_local1 = Engine.GetPlayerStats(f8_local0)
		f8_local1.liveStreamingAuthToken:set("")
		Engine.LivestreamDisable(f8_local0)
		f8_arg0.occludedMenu:processEvent({
			name = "update_livestream",
			controller = f8_local0
		})
		local f8_local2 = f8_arg0:openPopup("Error", f8_local0)
		f8_local2:setMessage(Engine.Localize("MENU_ERROR_WHILE_LOGGING_IN_TO_TWITCH"))
	else
		local f8_local1 = Engine.GetPlayerStats(f8_local0)
		f8_local1.liveStreamingAuthToken:set(Dvar.webm_httpAuthToken:get())
		Engine.Exec(f8_local0, "uploadstats")
		f8_arg0.occludedMenu:processEvent({
			name = "update_livestream",
			controller = f8_local0
		})
		f8_arg0:goBack()
	end
	f8_arg0.loginProcessStarted = false
end

