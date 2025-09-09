CoD.DLCPopup = {}
CoD.DLCPopup.MessageTop = 80
CoD.DLCPopup.MessageWidth = 450
CoD.DLCPopup.MessageHeight = 310
CoD.DLCPopup.ImagePadding = -50
CoD.DLCPopup.DOWNLOADNOTSTARTED = 0
CoD.DLCPopup.DOWNLOADINPROGRESS = 1
CoD.DLCPopup.DOWNLOADFINISHED = 2
LUI.createMenu.DLCPopup = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("DLCPopup")
	CoD.perController[f1_arg0].IsDLCPopupViewed = "true"
	f1_local0:addLargePopupBackground()
	local f1_local1 = CoD.DLCPopup.MessageTop
	local f1_local2 = LUI.UIText.new()
	f1_local2:setLeftRight(true, false, 0, CoD.MOTD.MessageWidth)
	f1_local2:setTopBottom(true, false, f1_local1, f1_local1 + CoD.textSize.Big)
	f1_local2:setFont(CoD.fonts.Big)
	f1_local2:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f1_local2:setText(Engine.Localize("MENU_DLC_POPUP_TITLE"))
	f1_local0:addElement(f1_local2)
	f1_local1 = f1_local1 + CoD.textSize.Big + 10
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.DLCPopup.MessageWidth)
	Widget:setTopBottom(true, false, f1_local1, f1_local1 + CoD.DLCPopup.MessageHeight)
	f1_local0:addElement(Widget)
	local f1_local4 = LUI.UIText.new(nil, true)
	f1_local4:setLeftRight(true, true, 0, 0)
	f1_local4:setTopBottom(true, false, 0, CoD.textSize.ExtraSmall)
	f1_local4:setFont(CoD.fonts.ExtraSmall)
	f1_local4:setText(Engine.Localize("MENU_DLC_POPUP_DESCRIPTION"))
	f1_local4:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local4:setAlignment(LUI.Alignment.Left)
	Widget:addElement(f1_local4)
	local f1_local5 = LUI.UIImage.new()
	f1_local5:setLeftRight(true, false, CoD.DLCPopup.ImagePadding + CoD.DLCPopup.MessageWidth, CoD.DLCPopup.MessageWidth + CoD.DLCPopup.ImagePadding + 512)
	f1_local5:setTopBottom(true, false, CoD.DLCPopup.MessageTop + 50, CoD.DLCPopup.MessageTop + 50 + 256)
	f1_local5:setImage(RegisterMaterial("menu_mp_nt_motd_big"))
	f1_local5:setAlpha(1)
	f1_local0:addElement(f1_local5)
	
	local choiceList = CoD.ButtonList.new()
	choiceList:setLeftRight(true, true, 0, 0)
	choiceList:setTopBottom(true, false, 500, 500 + CoD.CoD9Button.Height * 3)
	f1_local0:addElement(choiceList)
	f1_local0.choiceList = choiceList
	
	f1_local0.downloadChoice = f1_local0.choiceList:addButton(Engine.Localize("MENU_DLC_DOWNLOAD"))
	f1_local0.downloadChoice:setActionEventName("download_now")
	f1_local0.choiceList:addElement(f1_local0.downloadChoice)
	f1_local0.downloadChoice:processEvent({
		name = "gain_focus"
	})
	local f1_local7 = {
		controller = f1_arg0
	}
	CoD.DLCPopup.CheckDownloadStatus(f1_local0, f1_local7)
	f1_local0.timer = LUI.UITimer.new(10000, {
		name = "check_download_status",
		controller = f1_local7.controller
	}, false)
	f1_local0:addElement(f1_local0.timer)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("download_now", CoD.DLCPopup.DownloadNow)
	f1_local0:registerEventHandler("skip_download", CoD.DLCPopup.SkipDownload)
	f1_local0:registerEventHandler("button_prompt_back", CoD.DLCPopup.ButtonPromptBack)
	f1_local0:registerEventHandler("check_download_status", CoD.DLCPopup.CheckDownloadStatus)
	f1_local0:registerEventHandler("continue", CoD.DLCPopup.SkipDownload)
	f1_local0:registerEventHandler("signed_out", CoD.DLCPopup.SignedOut)
	return f1_local0
end

CoD.DLCPopup.SkipDownload = function (f2_arg0, f2_arg1)
	f2_arg0:goBack(f2_arg1.controller)
	f2_arg0.occludedMenu:processEvent({
		name = "dlcpopup_closed",
		controller = f2_arg1.controller
	})
end

CoD.DLCPopup.ButtonPromptBack = function (f3_arg0, f3_arg1)
	f3_arg0:goBack(f3_arg1.controller)
	CoD.perController[f3_arg1.controller].IsDLCPopupViewed = nil
end

CoD.DLCPopup.DownloadNow = function (f4_arg0, f4_arg1)
	Engine.ExecNow(f4_arg1.controller, "buyOfferFromMOTD " .. CoD.perController[f4_arg1.controller].ContentPublisherOfferID .. " " .. CoD.perController[f4_arg1.controller].ContentType)
end

CoD.DLCPopup.CheckDownloadStatus = function (f5_arg0, f5_arg1)
	if CoD.isXBOX == true then
		local f5_local0 = Engine.CheckDownloadStatusByOfferID(f5_arg1.controller, CoD.perController[f5_arg1.controller].ContentPublisherOfferID)
		if f5_local0 == CoD.DLCPopup.DOWNLOADINPROGRESS then
			f5_arg0.downloadChoice:setLabel(Engine.Localize("MENU_DLC_DOWNLOAD_AGAIN"))
		elseif f5_local0 == CoD.DLCPopup.DOWNLOADFINISHED and true == Engine.IsContentAvailableByPakName("dlc0") then
			CoD.ButtonList.RemoveAllButtons(f5_arg0.choiceList)
			local f5_local1 = f5_arg0.choiceList:addButton(Engine.Localize("MENU_CONTINUE_CAPS"))
			f5_local1:setActionEventName("continue")
			f5_arg0.choiceList:addElement(f5_local1)
			f5_local1:processEvent({
				name = "gain_focus"
			})
		else
			f5_arg0.downloadChoice:setLabel(Engine.Localize("MENU_DLC_DOWNLOAD"))
		end
	end
end

CoD.DLCPopup.SignedOut = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0:getRoot()
	CoD.DLCPopup.ButtonPromptBack(f6_arg0, f6_arg1)
	f6_local0:processEvent({
		name = "open_popup",
		popupName = "signed_out",
		controller = f6_arg1.controller
	})
end

