CoD.SPReminderPopup = {}
CoD.SPReminderPopup.MessageTop = 80
CoD.SPReminderPopup.MessageWidth = 450
CoD.SPReminderPopup.MessageHeight = 160
CoD.SPReminderPopup.ImagePadding = 130
CoD.SPReminderPopup.MissingDLCTextHeight = 200
CoD.SPReminderPopup.GetMissingDLCList = function (f1_arg0)
	local f1_local0 = Dvar.ui_totalDLCReleased:get()
	for f1_local1 = 1, f1_local0, 1 do
		if Engine.IsContentAvailableByPakName("dlc" .. f1_local1) == false then
			table.insert(f1_arg0, "dlc" .. f1_local1)
		end
	end
end

CoD.SPReminderPopup.GetAvailableDLC = function ()
	local f2_local0 = Dvar.ui_totalDLCReleased:get()
	local f2_local1 = 0
	local f2_local2 = 10
	for f2_local3 = 1, f2_local0, 1 do
		if Engine.IsContentAvailableByPakName("dlc" .. f2_local3) == true then
			f2_local1 = f2_local1 * f2_local2 + f2_local3
		end
	end
	return f2_local1
end

CoD.SPReminderPopup.ShowMissingDLCString = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = CoD.fonts.Default
	local f3_local1 = CoD.textSize.Default
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.SPReminderPopup.MessageWidth)
	Widget:setTopBottom(true, false, f3_arg2, f3_arg2 + CoD.SPReminderPopup.MissingDLCTextHeight)
	f3_arg0:addElement(Widget)
	local f3_local3 = {}
	CoD.SPReminderPopup.GetMissingDLCList(f3_local3)
	for f3_local4 = 1, #f3_local3, 1 do
		local f3_local7 = (f3_local4 - 1) * f3_local1
		local f3_local8 = LUI.UIText.new(nil, true)
		f3_local8:setLeftRight(true, true, 0, 0)
		f3_local8:setTopBottom(true, false, f3_local7, f3_local7 + f3_local1)
		f3_local8:setFont(f3_local0)
		f3_local8:setText(Engine.Localize("MENU_" .. f3_local3[f3_local4] .. "_MAP_PACK_NAME_DASH"))
		f3_local8:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f3_local8:setAlignment(LUI.Alignment.Left)
		Widget:addElement(f3_local8)
	end
	return #f3_local3 * f3_local1
end

CoD.SPReminderPopup.AddBodyText = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = CoD.fonts.ExtraSmall
	local f4_local1 = CoD.textSize.ExtraSmall
	local f4_local2 = Engine.GetNumTextLines(f4_arg2, f4_local0, f4_local1, CoD.SPReminderPopup.MessageWidth) * f4_local1
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.SPReminderPopup.MessageWidth)
	Widget:setTopBottom(true, false, f4_arg1, f4_arg1 + f4_local2)
	f4_arg0:addElement(Widget)
	local f4_local4 = LUI.UIText.new(nil, true)
	f4_local4:setLeftRight(true, true, 0, 0)
	f4_local4:setTopBottom(true, false, 0, f4_local1)
	f4_local4:setFont(f4_local0)
	f4_local4:setText(f4_arg2)
	f4_local4:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f4_local4:setAlignment(LUI.Alignment.Left)
	Widget:addElement(f4_local4)
	return f4_local2
end

LUI.createMenu.SPReminderPopup = function (f5_arg0)
	local f5_local0 = CoD.Menu.New("SPReminderPopup")
	f5_local0:addLargePopupBackground()
	f5_local0:addTitle(Engine.Localize("MPUI_SPREMINDER_TITLE"))
	local f5_local1 = CoD.SPReminderPopup.MessageTop
	local f5_local2 = LUI.UIText.new()
	f5_local2:setLeftRight(true, false, 0, CoD.MOTD.MessageWidth)
	f5_local2:setTopBottom(true, false, f5_local1, f5_local1 + CoD.textSize.Big)
	f5_local2:setFont(CoD.fonts.Big)
	f5_local2:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f5_local2:setText(Engine.Localize("MPUI_SPREMINDER_SUBTITLE"))
	f5_local0:addElement(f5_local2)
	f5_local1 = f5_local1 + CoD.textSize.Big + 10
	f5_local1 = f5_local1 + CoD.SPReminderPopup.AddBodyText(f5_local0, f5_local1, Engine.Localize("MPUI_SPREMINDER_TOP_BODY")) + 10
	f5_local1 = f5_local1 + CoD.SPReminderPopup.ShowMissingDLCString(f5_local0, missingDLCTextEl, f5_local1) + 10
	f5_local1 = f5_local1 + CoD.SPReminderPopup.AddBodyText(f5_local0, f5_local1, Engine.Localize("MPUI_SPREMINDER_BOTTOM_BODY")) + 10
	local f5_local3 = LUI.UIImage.new()
	f5_local3:setLeftRight(true, false, CoD.SPReminderPopup.ImagePadding + CoD.SPReminderPopup.MessageWidth, CoD.SPReminderPopup.MessageWidth + CoD.SPReminderPopup.ImagePadding + 256)
	f5_local3:setTopBottom(true, false, CoD.SPReminderPopup.MessageTop + 50, CoD.SPReminderPopup.MessageTop + 50 + 256)
	f5_local3:setImage(RegisterMaterial("menu_mp_missing_motd_big"))
	f5_local3:setAlpha(1)
	f5_local0:addElement(f5_local3)
	local f5_local4 = CoD.ButtonList.new()
	f5_local4:setLeftRight(true, true, 0, 0)
	f5_local4:setTopBottom(true, false, 500, 500 + CoD.CoD9Button.Height * 3)
	f5_local0:addElement(f5_local4)
	local f5_local5 = f5_local4:addButton(Engine.Localize("MENU_DLC_DOWNLOAD_NOW"))
	f5_local5:setActionEventName("spreminder_downloadnow")
	f5_local4:addElement(f5_local5)
	f5_local5:processEvent({
		name = "gain_focus"
	})
	local f5_local6 = f5_local4:addButton(Engine.Localize("MENU_DLC_DOWNLOAD_NOT_NOW"))
	f5_local6:setActionEventName("spreminder_skipDownload")
	f5_local4:addElement(f5_local6)
	f5_local0:addSelectButton()
	f5_local0:addBackButton()
	f5_local0:registerEventHandler("spreminder_downloadnow", CoD.SPReminderPopup.DownloadNow)
	f5_local0:registerEventHandler("spreminder_skipDownload", CoD.SPReminderPopup.SkipDownload)
	f5_local0:registerEventHandler("button_prompt_back", CoD.SPReminderPopup.ButtonPromptBack)
	f5_local0:registerEventHandler("signed_out", CoD.SPReminderPopup.SignedOut)
	return f5_local0
end

CoD.SPReminderPopup.DownloadNow = function (f6_arg0, f6_arg1)
	CoD.SPReminderPopup.SetSPReminderViewedTime(f6_arg1.controller, "DOWNLOAD")
	f6_arg0:goBack(f6_arg1.controller)
	Engine.SetDvar("ui_contextualMenuLocation", "spreminder")
	CoD.MainLobby.OpenStore(f6_arg0.occludedMenu, f6_arg1)
end

CoD.SPReminderPopup.SetSPReminderViewedTime = function (f7_arg0, f7_arg1)
	Engine.ExecNow(f7_arg0, "setSPReminderViewed")
	Engine.ExecNow(f7_arg0, "uploadstats")
	Engine.SendSPReminderRecordEvent(f7_arg0, f7_arg1, CoD.SPReminderPopup.GetAvailableDLC())
end

CoD.SPReminderPopup.SkipDownload = function (f8_arg0, f8_arg1)
	CoD.SPReminderPopup.ButtonPromptBack(f8_arg0, f8_arg1)
	f8_arg0.occludedMenu:processEvent({
		name = "spreminder_popup_closed",
		controller = f8_arg1.controller
	})
end

CoD.SPReminderPopup.ButtonPromptBack = function (f9_arg0, f9_arg1)
	CoD.SPReminderPopup.SetSPReminderViewedTime(f9_arg1.controller, "SKIPDOWNLOAD")
	f9_arg0:goBack(f9_arg1.controller)
end

CoD.SPReminderPopup.SignedOut = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg0:getRoot()
	CoD.SPReminderPopup.ButtonPromptBack(f10_arg0, f10_arg1)
	f10_local0:processEvent({
		name = "open_popup",
		popupName = "signed_out",
		controller = f10_arg1.controller
	})
end

