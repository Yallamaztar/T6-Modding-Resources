CoD.DSPPromotionPopup = {}
CoD.DSPPromotionPopup.MessageTop = 80
CoD.DSPPromotionPopup.MessageWidth = 550
CoD.DSPPromotionPopup.MessageHeight = 160
CoD.DSPPromotionPopup.ImagePadding = 30
CoD.DSPPromotionPopup.MissingDLCTextHeight = 200
CoD.DSPPromotionPopup.GetAvailableDLCList = function (f1_arg0)
	local f1_local0 = Dvar.ui_totalDLCReleased:get()
	for f1_local1 = 2, f1_local0, 1 do
		table.insert(f1_arg0, "dlc" .. f1_local1)
	end
	table.insert(f1_arg0, "dlczm0")
end

CoD.DSPPromotionPopup.ShowAvailableDLC = function (f2_arg0, f2_arg1)
	local f2_local0 = CoD.fonts.ExtraSmall
	local f2_local1 = CoD.textSize.ExtraSmall
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.DSPPromotionPopup.MessageWidth)
	Widget:setTopBottom(true, false, f2_arg1, f2_arg1 + CoD.DSPPromotionPopup.MissingDLCTextHeight)
	f2_arg0:addElement(Widget)
	local f2_local3 = {}
	CoD.DSPPromotionPopup.GetAvailableDLCList(f2_local3)
	for f2_local4 = 1, #f2_local3, 1 do
		local f2_local7 = (f2_local4 - 1) * f2_local1
		local f2_local8 = LUI.UIText.new(nil, true)
		f2_local8:setLeftRight(true, true, 0, 0)
		f2_local8:setTopBottom(true, false, f2_local7, f2_local7 + f2_local1)
		f2_local8:setFont(f2_local0)
		f2_local8:setText(Engine.Localize("MENU_" .. f2_local3[f2_local4] .. "_MAP_PACK_NAME"))
		f2_local8:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f2_local8:setAlignment(LUI.Alignment.Left)
		Widget:addElement(f2_local8)
	end
	return #f2_local3 * f2_local1
end

CoD.DSPPromotionPopup.AddBodyText = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = CoD.fonts.ExtraSmall
	local f3_local1 = CoD.textSize.ExtraSmall
	local f3_local2 = Engine.GetNumTextLines(f3_arg2, f3_local0, f3_local1, CoD.DSPPromotionPopup.MessageWidth) * f3_local1
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.DSPPromotionPopup.MessageWidth)
	Widget:setTopBottom(true, false, f3_arg1, f3_arg1 + f3_local2)
	f3_arg0:addElement(Widget)
	local f3_local4 = LUI.UIText.new(nil, true)
	f3_local4:setLeftRight(true, true, 0, 0)
	f3_local4:setTopBottom(true, false, 0, f3_local1)
	f3_local4:setFont(f3_local0)
	f3_local4:setText(f3_arg2)
	f3_local4:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f3_local4:setAlignment(LUI.Alignment.Left)
	Widget:addElement(f3_local4)
	return f3_local2
end

LUI.createMenu.DSPPromotionPopup = function (f4_arg0)
	local f4_local0 = CoD.Menu.New("DSPPromotionPopup")
	f4_local0:addLargePopupBackground()
	f4_local0:addTitle(Engine.Localize("MPUI_DSPPROMOTION_TITLE"))
	local f4_local1 = CoD.DSPPromotionPopup.MessageTop
	local f4_local2 = LUI.UIText.new()
	f4_local2:setLeftRight(true, false, 0, CoD.MOTD.MessageWidth)
	f4_local2:setTopBottom(true, false, f4_local1, f4_local1 + CoD.textSize.Big)
	f4_local2:setFont(CoD.fonts.Big)
	f4_local2:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f4_local2:setText(Engine.Localize("MPUI_DSPPROMOTION_SUBTITLE"))
	f4_local0:addElement(f4_local2)
	f4_local1 = f4_local1 + CoD.textSize.Big + 10
	f4_local1 = f4_local1 + CoD.DSPPromotionPopup.AddBodyText(f4_local0, f4_local1, Engine.Localize("MPUI_DSPPROMOTION_BODY", UIExpression.GetSelfGamertag(f4_arg0))) + 10
	f4_local1 = f4_local1 + CoD.DSPPromotionPopup.ShowAvailableDLC(f4_local0, f4_local1) + 20
	f4_local1 = f4_local1 + CoD.DSPPromotionPopup.AddBodyText(f4_local0, f4_local1, Engine.Localize("MPUI_TREYARCH_WITH_DASH")) + 10
	local f4_local3 = LUI.UIImage.new()
	f4_local3:setLeftRight(true, false, CoD.DSPPromotionPopup.ImagePadding + CoD.DSPPromotionPopup.MessageWidth, CoD.DSPPromotionPopup.MessageWidth + CoD.DSPPromotionPopup.ImagePadding + 256)
	f4_local3:setTopBottom(true, false, CoD.DSPPromotionPopup.MessageTop + 50, CoD.DSPPromotionPopup.MessageTop + 50 + 256)
	f4_local3:setImage(RegisterMaterial("menu_mp_missing_motd_spass"))
	f4_local3:setAlpha(1)
	f4_local0:addElement(f4_local3)
	local f4_local4 = CoD.ButtonList.new()
	f4_local4:setLeftRight(true, true, 0, 0)
	f4_local4:setTopBottom(true, false, 500, 500 + CoD.CoD9Button.Height * 5)
	f4_local0:addElement(f4_local4)
	local f4_local5 = f4_local4:addButton(UIExpression.ToUpper(f4_arg0, Engine.Localize("MENU_VOTING_REMIND_LATER")))
	f4_local5:setActionEventName("dsppromotion_remindlater")
	f4_local4:addElement(f4_local5)
	f4_local5:processEvent({
		name = "gain_focus"
	})
	local f4_local6 = f4_local4:addButton(UIExpression.ToUpper(f4_arg0, Engine.Localize("MENU_GO_TO_STORE")))
	f4_local6:setActionEventName("dsppromotion_gotostore")
	f4_local4:addElement(f4_local6)
	local f4_local7 = f4_local4:addButton(UIExpression.ToUpper(f4_arg0, Engine.Localize("MENU_VOTING_NEVER_REMIND_AGAIN")))
	f4_local7:setActionEventName("dsppromotion_neverremind")
	f4_local4:addElement(f4_local7)
	f4_local0:addSelectButton()
	f4_local0:addBackButton()
	f4_local0:registerEventHandler("dsppromotion_gotostore", CoD.DSPPromotionPopup.GoToStore)
	f4_local0:registerEventHandler("dsppromotion_remindlater", CoD.DSPPromotionPopup.RemindLater)
	f4_local0:registerEventHandler("dsppromotion_neverremind", CoD.DSPPromotionPopup.NeverRemindAgain)
	f4_local0:registerEventHandler("button_prompt_back", CoD.DSPPromotionPopup.ButtonPromptBack)
	f4_local0:registerEventHandler("signed_out", CoD.DSPPromotionPopup.SignedOut)
	return f4_local0
end

CoD.DSPPromotionPopup.GoToStore = function (f5_arg0, f5_arg1)
	CoD.DSPPromotionPopup.SetDSPPromotionViewedTime(f5_arg1.controller, "GOTOSTORE")
	f5_arg0:goBack(f5_arg1.controller)
	Engine.SetDvar("ui_contextualMenuLocation", "dsppromotion")
	CoD.MainLobby.OpenStore(f5_arg0.occludedMenu, f5_arg1)
end

CoD.DSPPromotionPopup.SetDSPPromotionViewedTime = function (f6_arg0, f6_arg1)
	Engine.ExecNow(f6_arg0, "setDSPPromotionViewed")
	Engine.ExecNow(f6_arg0, "uploadstats")
	Engine.SendDSPPromotionRecordEvent(f6_arg0, f6_arg1)
end

CoD.DSPPromotionPopup.RemindLater = function (f7_arg0, f7_arg1)
	CoD.DSPPromotionPopup.ButtonPromptBack(f7_arg0, f7_arg1)
	f7_arg0.occludedMenu:processEvent({
		name = "dsppromotion_popup_closed",
		controller = f7_arg1.controller
	})
end

CoD.DSPPromotionPopup.NeverRemindAgain = function (f8_arg0, f8_arg1)
	Engine.ExecNow(f8_arg1.controller, "setDSPPromotionOptOut")
	CoD.DSPPromotionPopup.SetDSPPromotionViewedTime(f8_arg1.controller, "NEVERREMINDAGAIN")
	f8_arg0:goBack(f8_arg1.controller)
	f8_arg0.occludedMenu:processEvent({
		name = "dsppromotion_popup_closed",
		controller = f8_arg1.controller
	})
end

CoD.DSPPromotionPopup.ButtonPromptBack = function (f9_arg0, f9_arg1)
	CoD.DSPPromotionPopup.SetDSPPromotionViewedTime(f9_arg1.controller, "REMINDLATER")
	f9_arg0:goBack(f9_arg1.controller)
end

CoD.DSPPromotionPopup.SignedOut = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg0:getRoot()
	CoD.DSPPromotionPopup.ButtonPromptBack(f10_arg0, f10_arg1)
	f10_local0:processEvent({
		name = "open_popup",
		popupName = "signed_out",
		controller = f10_arg1.controller
	})
end

