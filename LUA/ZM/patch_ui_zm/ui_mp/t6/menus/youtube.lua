CoD.YT_ACCOUNT_NOT_CHECKED = 0
CoD.YT_ACCOUNT_CHECKING = 1
CoD.YT_ACCOUNT_CHECKED = 2
CoD.YT_ACCOUNT_GETTING_TOKEN = 3
CoD.YT_ACCOUNT_TOKEN_RECEIVED = 4
CoD.YT_WAITING_FOR_AUTH = 5
CoD.YT_ACCOUNT_NOT_READY = 6
CoD.YT_ACCOUNT_READY = 7
local f0_local0 = function (f1_arg0, f1_arg1)
	if f1_arg0.state ~= CoD.YT_ACCOUNT_READY then
		Engine.ExecNow(f1_arg1.controller, "youTubeCancel")
		f1_arg0:goBack()
	else
		f1_arg0:goBack()
		if f1_arg0.mode ~= "render" then
			f1_arg0.occludedMenu:processEvent({
				name = "youtube_connect_complete",
				controller = f1_arg1.controller
			})
		end
	end
end

local f0_local1 = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0:getOwner()
	if not f2_arg0.accountChecked and Engine.IsYouTubeAccountChecked(f2_local0) then
		if Engine.IsYouTubeAccountRegistered(f2_local0) then
			f2_arg0.state = CoD.YT_ACCOUNT_READY
			f0_local0(f2_arg0, f2_arg1)
			return 
		else
			Engine.Exec(f2_local0, "youTubeRegister")
			f2_arg0.state = CoD.YT_ACCOUNT_NOT_READY
			f2_arg0.accountChecked = true
			return 
		end
	end
	local f2_local1 = Engine.YouTube_Get(f2_local0)
	if f2_local1 == nil then
		return 
	end
	local f2_local2 = f2_local1.state
	if f2_local2 == f2_arg0.state then
		return 
	end
	f2_arg0.state = f2_local2
	if f2_local2 == CoD.YT_WAITING_FOR_AUTH then
		if f2_arg0.activatingLiveStream == true then
			f2_arg0.title:setText(Engine.Localize("MENU_LIVESTREAMING_ACTIVATE"))
			f2_arg0.msg:setText(Engine.Localize("MENU_LIVESTREAMING_ACTIVATE_DESC", f2_local1.verification_url))
		elseif f2_arg0.mode == "render" then
			f2_arg0.title:setText(Engine.Localize("MENU_LINK_YOUTUBE_ACCOUNT"))
			f2_arg0.msg:setText(Engine.Localize("MENU_RENDER_VIDEO_ACTIVATE_DESC", f2_local1.verification_url))
		else
			f2_arg0.title:setText(Engine.Localize("MENU_YOUTUBE_ACTIVATE"))
			f2_arg0.msg:setText(Engine.Localize("MENU_YOUTUBE_ACTIVATE_DESC", f2_local1.verification_url))
		end
		f2_arg0.codeText:setText(Engine.Localize("MENU_LIVESTREAMING_CODE", f2_local1.user_code))
		f2_arg0.spinner:setAlpha(0)
	elseif f2_local2 == CoD.YT_ACCOUNT_CHECKED then
		f2_arg0.title:setText(Engine.Localize("MENU_AWAITING_AUTHENTICATION"))
		f2_arg0.msg:setText("")
		f2_arg0.codeText:setText("")
		f2_arg0.spinner:setAlpha(1)
	elseif f2_local2 == CoD.YT_ACCOUNT_READY then
		f0_local0(f2_arg0, f2_arg1)
	else
		f2_arg0.title:setText(Engine.Localize("MENU_YOUTUBE_CONNECT"))
		f2_arg0.msg:setText("")
		f2_arg0.codeText:setText("")
		f2_arg0.spinner:setAlpha(1)
	end
end

local f0_local2 = function (f3_arg0, f3_arg1)
	f3_arg0.title:setText(Engine.Localize("MENU_ERROR"))
	f3_arg0.msg:setText(f3_arg1.errorMessage)
	f3_arg0.spinner:setAlpha(0)
	f3_arg0.codeText:setText("")
	if f3_arg0.pollTimer ~= nil then
		f3_arg0.pollTimer:close()
		f3_arg0.pollTimer = nil
	end
end

LUI.createMenu.YouTube_Connect = function (f4_arg0, f4_arg1)
	local f4_local0 = 480
	local f4_local1 = 340
	local f4_local2 = CoD.Popup.SetupPopup("YouTube_Connect", f4_arg0, CoD.Popup.Type.STRETCHED)
	f4_local2:setWidthHeight(f4_local0, f4_local1)
	f4_local2:setOwner(f4_arg0)
	f4_local2.title:setText(Engine.Localize("MENU_YOUTUBE_CONNECT"))
	f4_local2.activatingLiveStream = CoD.perController[f4_arg0].activatingLiveStream
	f4_local2:addBackButton()
	if f4_arg1 and f4_arg1.mode then
		f4_local2.mode = f4_arg1.mode
	end
	local f4_local3 = 96
	local f4_local4 = 96
	f4_local2.spinner = LUI.UIImage.new({
		shaderVector0 = {
			0,
			0,
			0,
			0
		}
	})
	f4_local2.spinner:setLeftRight(true, true, f4_local0 / 2 - f4_local4 / 2, -(f4_local0 / 2 - f4_local4 / 2))
	f4_local2.spinner:setTopBottom(true, true, f4_local1 / 2 - f4_local3 / 2, -(f4_local1 / 2 - f4_local3 / 2))
	f4_local2.spinner:setImage(RegisterMaterial("lui_loader"))
	f4_local2:addElement(f4_local2.spinner)
	f4_local2.codeText = LUI.UITightText.new()
	f4_local2.codeText:setLeftRight(true, true, 20, -20)
	f4_local2.codeText:setTopBottom(false, true, -40 - CoD.textSize.Big, -40)
	f4_local2.codeText:setFont(CoD.fonts.Big)
	f4_local2.codeText:setAlignment(LUI.Alignment.Center)
	f4_local2:addElement(f4_local2.codeText)
	f4_local2:registerEventHandler("check_login_state", f0_local1)
	f4_local2:registerEventHandler("button_prompt_back", f0_local0)
	f4_local2:registerEventHandler("button_prompt_ok", YouTube_Connect_Ok)
	f4_local2:registerEventHandler("live_dw_youtube_error", f0_local2)
	f4_local2.state = CoD.YT_ACCOUNT_NOT_READY
	f4_local2.pollTimer = LUI.UITimer.new(2000, {
		name = "check_login_state",
		controller = f4_arg0
	})
	f4_local2:addElement(f4_local2.pollTimer)
	f4_local2.accountChecked = false
	f4_local2.msg:setText("")
	if CoD.isPC and CoD.isZombie then
		local f4_local5 = 350
		f4_local2.smallPopupBackground:close()
		f4_local2:setTopBottom(false, false, -f4_local5 / 2, f4_local5 / 2)
		f4_local2:addSmallPopupBackground(nil, CoD.Popup.StretchedWidth, f4_local5)
		f4_local2.spinner:setLeftRight(false, false, -f4_local4 / 2, f4_local4 / 2)
		f4_local2.spinner:setTopBottom(false, false, -f4_local3 / 2, f4_local3 / 2)
		f4_local2.codeText:setTopBottom(false, true, -60 - CoD.textSize.Big, -60)
	end
	return f4_local2
end

local f0_local3 = function (f5_arg0, f5_arg1)
	if f5_arg1.error then
		f5_arg0.title:setText(Engine.Localize("MENU_ERROR"))
		f5_arg0.msg:setText(Engine.Localize("MENU_YOUTUBE_UNLINK_FAILED"))
	else
		f5_arg0.title:setText(Engine.Localize("MENU_NOTICE"))
		f5_arg0.msg:setText(Engine.Localize("MENU_YOUTUBE_UNLINK_SUCCESS"))
	end
	f5_arg0.spinner:setAlpha(0)
	if CoD.isPC then
		f5_arg0:addBackButton()
	else
		f5_arg0:addSelectButton(Engine.Localize("MPUI_OK"), 100, "button_prompt_back")
	end
	f5_arg0.occludedMenu:processEvent({
		name = "youtube_connect_complete",
		controller = f5_arg1.controller
	})
end

LUI.createMenu.YouTube_UnRegister = function (f6_arg0)
	local f6_local0 = CoD.Popup.SetupPopupBusy("YouTube_UnRegister", f6_arg0)
	f6_local0:registerEventHandler("live_dw_youtube_unlink_complete", f0_local3)
	f6_local0.title:setText(Engine.Localize("MENU_UNLINKING_ACCOUNT"))
	Engine.Exec(f6_arg0, "youTubeUnregister")
	return f6_local0
end

