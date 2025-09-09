require("T6.TextFieldButton")
CoD.Twitch = {}
function Twitch_Connect_UpdateKeyboard(f1_arg0, f1_arg1)
	if f1_arg1.type == CoD.KEYBOARD_TYPE_TWITCH_USER then
		Dvar.webm_httpAuthLogin:set(f1_arg1.input)
		f1_arg0.loginContainer.userNameButton:setText(f1_arg1.input)
		f1_arg0.loginContainer.userNameButton.text = f1_arg1.input
	elseif f1_arg1.type == CoD.KEYBOARD_TYPE_TWITCH_PASS then
		Dvar.webm_httpAuthPass:set(f1_arg1.input)
		f1_arg0.loginContainer.passwordButton:setText(CoD.TextFieldButton.ConvertToStar(f1_arg1.input))
		f1_arg0.loginContainer.passwordButton.text = f1_arg1.input
	end
end

function Twitch_Connect_EditUserName(f2_arg0, f2_arg1)
	if f2_arg0.disableLoginInputs then
		return 
	else
		Engine.Exec(f2_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_TWITCH_USER)
	end
end

function Twitch_Connect_EditPassword(f3_arg0, f3_arg1)
	if f3_arg0.disableLoginInputs then
		return 
	else
		Engine.Exec(f3_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_TWITCH_PASS)
	end
end

function Twitch_Connect_GoBack(f4_arg0, f4_arg1)
	Engine.SetDvar("webm_encUiSigningIn", 0)
	f4_arg0:goBack()
end

function Twitch_Connect_Back(f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1.controller
	if f5_arg0.error then
		f5_arg0:openPopup("LiveStream_Disable", f5_local0)
		f5_arg0:registerEventHandler("livestream_update_state", Twitch_Connect_GoBack)
		return 
	elseif f5_arg0.success then
		Twitch_Connect_GoBack(f5_arg0, {
			controller = f5_arg1.controller
		})
		f5_arg0.occludedMenu:processEvent({
			name = "twitch_connect_complete",
			controller = f5_arg1.controller
		})
	else
		Twitch_Connect_GoBack(f5_arg0, {
			controller = f5_arg1.controller
		})
	end
end

function Twitch_Connect_ProcessLogin(f6_arg0, f6_arg1)
	if f6_arg0.loginProcessStarted then
		return 
	elseif Dvar.r_stereo3DOn:get() or Dvar.r_dualPlayEnable:get() then
		f6_arg0.title:setText(Engine.Localize("MENU_ERROR"))
		if Dvar.r_dualPlayEnable:get() then
			f6_arg0.msg:setText(Engine.Localize("MENU_TWITCH_REGISTERATION_DISABLED_FOR_DUAL_PLAY"))
		else
			f6_arg0.msg:setText(Engine.Localize("MENU_TWITCH_REGISTERATION_DISABLED_FOR_3D"))
		end
		f6_arg0:removeBackButton()
		f6_arg0:removeSelectButton()
		f6_arg0.loginContainer:setAlpha(0)
		f6_arg0.disableLoginInputs = true
		f6_arg0.error = true
		if not f6_arg0.selectButton or f6_arg0.selectButton and not f6_arg0.selectButton:getParent() then
			f6_arg0:addSelectButton(Engine.Localize("MPUI_OK"), 100, "button_prompt_back")
		end
		return 
	else
		Engine.LivestreamEnable(f6_arg1.controller)
		Dvar.webm_httpAuthToken:set("")
		Dvar.webm_encStreamEnabled:set(true)
		Engine.SetDvar("webm_encUiSigningIn", 1)
		f6_arg0.loginContainer:hide(0)
		f6_arg0.spinner:setAlpha(1)
		f6_arg0.title:setText(Engine.Localize("MENU_CONNECTING_TO_TWITCH"))
		f6_arg0:removeBackButton()
		f6_arg0:removeSelectButton()
		f6_arg0.loginProcessStarted = true
		f6_arg0.disableLoginInputs = true
	end
end

function Twitch_Connect_DWRegister_Success(f7_arg0, f7_arg1)
	f7_arg0.title:setText(Engine.Localize("MENU_NOTICE"))
	f7_arg0.msg:setText(Engine.Localize("MENU_TWITCH_REGISTERATION_SUCCESS"))
	if not f7_arg0.selectButton or f7_arg0.selectButton and not f7_arg0.selectButton:getParent() then
		f7_arg0:addSelectButton(Engine.Localize("MPUI_OK"), 100, "button_prompt_back")
	end
	f7_arg0.success = true
	f7_arg0.spinner:setAlpha(0)
end

function Twitch_Connect_DWRegister_Failure(f8_arg0, f8_arg1)
	f8_arg0.title:setText(Engine.Localize("MENU_ERROR"))
	f8_arg0.msg:setText(f8_arg1.errorMessage)
	if not f8_arg0.selectButton or f8_arg0.selectButton and not f8_arg0.selectButton:getParent() then
		f8_arg0:addSelectButton(Engine.Localize("MPUI_OK"), 100, "button_prompt_back")
	end
	f8_arg0.error = true
	f8_arg0.spinner:setAlpha(0)
end

function Twitch_Connect_Update(f9_arg0, f9_arg1)
	if f9_arg0.disableStream and Engine.LivestreamDisableAsync() then
		if not f9_arg0.selectButton or f9_arg0.selectButton and not f9_arg0.selectButton:getParent() then
			f9_arg0:addSelectButton(Engine.Localize("MPUI_OK"), 100, "button_prompt_back")
		end
		f9_arg0.disableStream = false
	end
	if not f9_arg0.loginProcessStarted then
		return 
	elseif Dvar.webm_encStatus:get() ~= "streaming" and Dvar.webm_encStreamEnabled:get() == true then
		return 
	end
	local f9_local0 = f9_arg1.controller
	if Dvar.webm_encStatus:get() ~= "streaming" or Dvar.webm_httpAuthToken:get() == "" or f9_arg0.loginContainer.userNameButton.text == "" then
		Dvar.webm_httpAuthToken:set("")
		f9_arg0.title:setText(Engine.Localize("MENU_ERROR"))
		f9_arg0.msg:setText(Engine.Localize("MENU_TWITCH_REGISTERATION_ERROR"))
		if not f9_arg0.selectButton or f9_arg0.selectButton and not f9_arg0.selectButton:getParent() then
			f9_arg0:addSelectButton(Engine.Localize("MPUI_OK"), 100, "button_prompt_back")
		end
		f9_arg0.error = true
		f9_arg0.spinner:setAlpha(0)
	else
		Engine.Exec(f9_local0, "twitchRegister " .. f9_arg0.loginContainer.userNameButton.text .. " " .. Dvar.webm_httpAuthToken:get())
	end
	f9_arg0.disableStream = true
	f9_arg0.loginProcessStarted = false
end

LUI.createMenu.Twitch_Connect = function (f10_arg0)
	local f10_local0 = 480
	local f10_local1 = 290
	local f10_local2 = CoD.Popup.SetupPopup("Twitch_Connect", f10_arg0, CoD.Popup.Type.STRETCHED)
	f10_local2:setWidthHeight(f10_local0, f10_local1)
	f10_local2:setOwner(f10_arg0)
	Dvar.webm_httpAuthMode:set("twitch")
	Dvar.webm_httpUploadUrl:set(Dvar.webm_httpUploadUrlTwitch:get())
	Dvar.webm_httpAuthToken:set("")
	f10_local2:registerEventHandler("edit_username", Twitch_Connect_EditUserName)
	f10_local2:registerEventHandler("edit_password", Twitch_Connect_EditPassword)
	f10_local2:registerEventHandler("button_prompt_back", Twitch_Connect_Back)
	f10_local2:registerEventHandler("ui_keyboard_input", Twitch_Connect_UpdateKeyboard)
	f10_local2:registerEventHandler("twitch_login", Twitch_Connect_ProcessLogin)
	f10_local2:registerEventHandler("update_login_process", Twitch_Connect_Update)
	f10_local2:registerEventHandler("live_dw_twitch_success", Twitch_Connect_DWRegister_Success)
	f10_local2:registerEventHandler("live_dw_twitch_error", Twitch_Connect_DWRegister_Failure)
	local f10_local3 = 64
	local f10_local4 = 64
	f10_local2.spinner = LUI.UIImage.new({
		shaderVector0 = {
			0,
			0,
			0,
			0
		}
	})
	f10_local2.spinner:setLeftRight(true, true, CoD.Menu.SmallPopupWidth / 2 - f10_local4 / 2, -(CoD.Menu.SmallPopupWidth / 2 - f10_local4 / 2))
	f10_local2.spinner:setTopBottom(true, true, CoD.Menu.SmallPopupHeight / 2 - f10_local3 / 2, -(CoD.Menu.SmallPopupHeight / 2 - f10_local3 / 2))
	f10_local2.spinner:setImage(RegisterMaterial("lui_loader"))
	f10_local2.spinner:setAlpha(0)
	f10_local2:addElement(f10_local2.spinner)
	f10_local2.title:setText(Engine.Localize("MENU_TWITCH_LOGIN"))
	f10_local2:addSelectButton(Engine.Localize("MPUI_OK"))
	f10_local2:addBackButton()
	f10_local2.loginContainer = LUI.UIContainer.new()
	f10_local2.loginContainer:setLeftRight(true, true, 0, 0)
	f10_local2.loginContainer:setTopBottom(true, true, 0, 0)
	f10_local2.loginContainer.visible = true
	f10_local2.loginContainer:setAlpha(1)
	f10_local2:addElement(f10_local2.loginContainer)
	local f10_local5 = LUI.UIVerticalList.new()
	f10_local5:setLeftRight(true, true, 10, -10)
	f10_local5:setTopBottom(true, true, 55, 0)
	f10_local5:setSpacing(5)
	f10_local2.loginContainer:addElement(f10_local5)
	local f10_local6 = LUI.UIText.new()
	f10_local6:setLeftRight(true, true, 0, 0)
	f10_local6:setTopBottom(true, false, 0, CoD.textSize.Default)
	f10_local6:setFont(CoD.fonts.Default)
	f10_local6:setAlignment(LUI.Alignment.Left)
	f10_local6:setText(Engine.Localize("MENU_USERNAME") .. ":")
	f10_local5:addElement(f10_local6)
	local f10_local7 = Engine.GetTwitchAccountInfo(f10_arg0)
	local f10_local8 = ""
	if f10_local7 ~= nil then
		local f10_local9 = f10_local7.userName
	end
	if f10_local8 == "" then
		f10_local8 = Dvar.webm_httpAuthLogin:get()
	else
		Dvar.webm_httpAuthLogin:set(f10_local8)
	end
	local f10_local9 = CoD.TextFieldButton.new("", "edit_username")
	f10_local5:addElement(f10_local9)
	if f10_local8 ~= "" then
		f10_local9:setText(f10_local8)
		f10_local9.text = f10_local8
	else
		f10_local9.text = "None"
	end
	f10_local2.loginContainer.userNameButton = f10_local9
	local f10_local10 = LUI.UIText.new()
	f10_local10:setLeftRight(true, true, 0, 0)
	f10_local10:setTopBottom(true, false, 0, CoD.textSize.Default)
	f10_local10:setFont(CoD.fonts.Default)
	f10_local10:setAlignment(LUI.Alignment.Left)
	f10_local10:setText(Engine.Localize("MENU_PASSWORD") .. ":")
	f10_local5:addElement(f10_local10)
	local f10_local11 = CoD.TextFieldButton.new("", "edit_password")
	f10_local5:addElement(f10_local11)
	f10_local11.text = "None"
	f10_local2.loginContainer.passwordButton = f10_local11
	f10_local5:addSpacer(20)
	local f10_local12 = CoD.TextFieldButton.new(Engine.Localize("MENU_LOGIN_CAPS"), "twitch_login", LUI.Alignment.Center)
	f10_local5:addElement(f10_local12)
	f10_local2.loginContainer.loginButton = f10_local12
	f10_local2.loginContainer.loginButton:processEvent({
		name = "gain_focus",
		controller = f10_arg0
	})
	f10_local2.loginTimer = LUI.UITimer.new(500, {
		name = "update_login_process",
		controller = f10_arg0
	}, false)
	f10_local2:addElement(f10_local2.loginTimer)
	return f10_local2
end

local f0_local0 = function (f11_arg0, f11_arg1)
	if f11_arg1.error then
		f11_arg0.title:setText(Engine.Localize("MENU_ERROR"))
		f11_arg0.msg:setText(Engine.Localize("MENU_TWITCH_UNLINK_FAILED"))
	else
		f11_arg0.title:setText(Engine.Localize("MENU_NOTICE"))
		f11_arg0.msg:setText(Engine.Localize("MENU_TWITCH_UNLINK_SUCCESS"))
	end
	f11_arg0.spinner:setAlpha(0)
	f11_arg0:addSelectButton(Engine.Localize("MPUI_OK"), 100, "button_prompt_back")
	f11_arg0.occludedMenu:processEvent({
		name = "twitch_connect_complete",
		controller = f11_arg1.controller
	})
end

LUI.createMenu.Twitch_UnRegister = function (f12_arg0)
	local f12_local0 = CoD.Popup.SetupPopupBusy("Twitch_UnRegister", f12_arg0)
	f12_local0:registerEventHandler("live_dw_twitch_unlink_complete", f0_local0)
	f12_local0.title:setText(Engine.Localize("MENU_UNLINKING_ACCOUNT"))
	Engine.Exec(f12_arg0, "twitchUnregister")
	return f12_local0
end

