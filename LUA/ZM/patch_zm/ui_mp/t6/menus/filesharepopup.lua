CoD.FilesharePopup = {}
CoD.FilesharePopup.Accept = function (f1_arg0, f1_arg1)
	local f1_local0 = f1_arg0.occludedMenu
	f1_arg0:goBack(f1_arg1.controller)
	f1_arg0.occludedMenu:processEvent({
		name = f1_arg0.m_completionNotification,
		controller = f1_arg1.controller,
		success = f1_arg0.m_wasSuccessful
	})
end

LUI.createMenu.FilesharePopup_Success = function (f2_arg0, f2_arg1)
	local f2_local0 = CoD.Popup.SetupPopup("FilesharePopup_Success", f2_arg0)
	f2_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f2_local0.msg:setText(f2_arg1)
	f2_local0.m_wasSuccessful = true
	local f2_local1 = CoD.ButtonPrompt.new
	local f2_local2 = "primary"
	local f2_local3 = Engine.Localize("MENU_OK")
	local f2_local4 = f2_local0
	local f2_local5 = "fileshare_popup_accept"
	local f2_local6, f2_local7 = false
	f2_local0:addLeftButtonPrompt(f2_local1(f2_local2, f2_local3, f2_local4, f2_local5, f2_local6, f2_local7, false))
	f2_local0:registerEventHandler("fileshare_popup_accept", CoD.FilesharePopup.Accept)
	return f2_local0
end

LUI.createMenu.FilesharePopup_Failure = function (f3_arg0, f3_arg1)
	local f3_local0 = CoD.Popup.SetupPopup("FilesharePopup_Failure", f3_arg0)
	f3_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f3_local0.msg:setText(f3_arg1)
	f3_local0.m_wasSuccessful = false
	local f3_local1 = CoD.ButtonPrompt.new
	local f3_local2 = "primary"
	local f3_local3 = Engine.Localize("MENU_OK")
	local f3_local4 = f3_local0
	local f3_local5 = "fileshare_popup_accept"
	local f3_local6, f3_local7 = false
	f3_local0:addLeftButtonPrompt(f3_local1(f3_local2, f3_local3, f3_local4, f3_local5, f3_local6, f3_local7, false))
	f3_local0:registerEventHandler("fileshare_popup_accept", CoD.FilesharePopup.Accept)
	return f3_local0
end

CoD.FilesharePopup.Done = function (f4_arg0, f4_arg1)
	if f4_arg1.success == true then
		local f4_local0 = f4_arg0.occludedMenu:openPopup("FilesharePopup_Success", f4_arg0.m_ownerController, f4_arg0.m_successNotice)
		f4_local0.m_completionNotification = f4_arg0.m_completionNotification
	else
		local f4_local0 = f4_arg0.occludedMenu:openPopup("FilesharePopup_Failure", f4_arg0.m_ownerController, f4_arg0.m_failureNotice)
		f4_local0.m_completionNotification = f4_arg0.m_completionNotification
	end
	f4_arg0:close()
end

CoD.FilesharePopup.InPlaceDone = function (f5_arg0, f5_arg1)
	f5_arg0.spinner:close()
	f5_arg0.title:setText(Engine.Localize("MENU_NOTICE"))
	local f5_local0 = CoD.ButtonPrompt.new
	local f5_local1 = "primary"
	local f5_local2 = Engine.Localize("MENU_OK")
	local f5_local3 = f5_arg0
	local f5_local4 = "fileshare_popup_accept"
	local f5_local5, f5_local6 = false
	f5_arg0:addLeftButtonPrompt(f5_local0(f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6, false))
	f5_arg0:registerEventHandler("fileshare_popup_accept", CoD.FilesharePopup.Accept)
	f5_arg0:registerEventHandler(f5_arg0.completionEvent, nil)
	if f5_arg1.success == true then
		f5_arg0.msg:setText(f5_arg0.m_successNotice)
		f5_arg0.m_wasSuccessful = true
	else
		f5_arg0.msg:setText(f5_arg0.m_failureNotice)
		f5_arg0.m_wasSuccessful = false
	end
end

LUI.createMenu.Fileshare_BusyPopup = function (f6_arg0, f6_arg1)
	local f6_local0 = CoD.Popup.SetupPopupBusy("Fileshare_BusyPopup", f6_arg0)
	f6_local0:setOwner(f6_arg0)
	f6_local0.m_successNotice = f6_arg1.successNotice
	f6_local0.m_failureNotice = f6_arg1.failureNotice
	f6_local0.m_completionNotification = f6_arg1.completionNotification
	f6_local0.title:setText(f6_arg1.title)
	f6_local0.msg:setText(f6_arg1.message)
	f6_local0.completionEvent = f6_arg1.completionEvent
	if f6_arg1.inPlace ~= nil then
		f6_local0:registerEventHandler(f6_arg1.completionEvent, CoD.FilesharePopup.InPlaceDone)
	else
		f6_local0:registerEventHandler(f6_arg1.completionEvent, CoD.FilesharePopup.Done)
	end
	Engine.Exec(f6_arg0, f6_arg1.actionCommand)
	return f6_local0
end

CoD.FilesharePopup.Confirmed = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg0:openMenu("Fileshare_BusyPopup", f7_arg1.controller, f7_arg0.m_userInfo)
	f7_arg0:close()
end

LUI.createMenu.Fileshare_ConfirmationPopup = function (f8_arg0, f8_arg1)
	local f8_local0 = CoD.Popup.SetupPopupChoice("Fileshare_ConfirmationPopup", f8_arg0)
	f8_local0.title:setText(f8_arg1.confirmationTitle)
	f8_local0.msg:setText(f8_arg1.confirmationMessage)
	f8_local0:addBackButton()
	f8_local0.m_userInfo = f8_arg1
	f8_local0.choiceA:setLabel(Engine.Localize("MENU_YES"))
	f8_local0.choiceB:setLabel(Engine.Localize("MENU_NO"))
	f8_local0.choiceA:setActionEventName("fileshare_confirmation_yes")
	f8_local0.choiceB:processEvent({
		name = "gain_focus"
	})
	f8_local0:registerEventHandler("fileshare_confirmation_yes", CoD.FilesharePopup.Confirmed)
	return f8_local0
end

