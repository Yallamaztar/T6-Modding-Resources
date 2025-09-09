CoD.GhostUpsellPopup = {}
CoD.GhostUpsellPopup.MessageTop = 80
CoD.GhostUpsellPopup.MessageWidth = 550
CoD.GhostUpsellPopup.ImagePadding = 30
CoD.GhostUpsellPopup.Category = 6
CoD.GhostUpsellPopup.AddBodyText = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = CoD.fonts.ExtraSmall
	local f1_local1 = CoD.textSize.ExtraSmall
	local f1_local2 = Engine.GetNumTextLines(f1_arg2, f1_local0, f1_local1, CoD.GhostUpsellPopup.MessageWidth) * f1_local1
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.GhostUpsellPopup.MessageWidth)
	Widget:setTopBottom(true, false, f1_arg1, f1_arg1 + f1_local2)
	f1_arg0:addElement(Widget)
	local f1_local4 = LUI.UIText.new(nil, true)
	f1_local4:setLeftRight(true, true, 0, 0)
	f1_local4:setTopBottom(true, false, 0, f1_local1)
	f1_local4:setFont(f1_local0)
	f1_local4:setText(f1_arg2)
	f1_local4:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local4:setAlignment(LUI.Alignment.Left)
	Widget:addElement(f1_local4)
	return f1_local2
end

LUI.createMenu.GhostUpsellPopup = function (f2_arg0)
	local f2_local0 = CoD.Menu.New("GhostUpsellPopup")
	f2_local0:addLargePopupBackground()
	Engine.SetUpsellPopupOpenTimestamp()
	f2_local0:addTitle(Engine.Localize("MPUI_GHOST_UPSELL_TITLE"))
	local f2_local1 = CoD.GhostUpsellPopup.MessageTop
	local f2_local2 = LUI.UIText.new()
	f2_local2:setLeftRight(true, false, 0, CoD.MOTD.MessageWidth)
	f2_local2:setTopBottom(true, false, f2_local1, f2_local1 + CoD.textSize.Big)
	f2_local2:setFont(CoD.fonts.Big)
	f2_local2:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f2_local2:setText(Engine.Localize("MPUI_GHOST_UPSELL_SUBTITLE"))
	f2_local0:addElement(f2_local2)
	f2_local1 = f2_local1 + CoD.textSize.Big + 10
	f2_local1 = f2_local1 + CoD.GhostUpsellPopup.AddBodyText(f2_local0, f2_local1, Engine.Localize("MPUI_GHOST_UPSELL_BODY", UIExpression.GetSelfGamertag(f2_arg0))) + 10
	local f2_local3 = LUI.UIImage.new()
	f2_local3:setLeftRight(true, false, CoD.GhostUpsellPopup.ImagePadding + CoD.GhostUpsellPopup.MessageWidth, CoD.GhostUpsellPopup.MessageWidth + CoD.GhostUpsellPopup.ImagePadding + 256)
	f2_local3:setTopBottom(true, false, CoD.GhostUpsellPopup.MessageTop + 50, CoD.GhostUpsellPopup.MessageTop + 50 + 256)
	f2_local3:setImage(RegisterMaterial("menu_mp_ghost"))
	f2_local3:setAlpha(1)
	f2_local0:addElement(f2_local3)
	local f2_local4 = CoD.ButtonList.new()
	f2_local4:setLeftRight(true, true, 0, 0)
	f2_local4:setTopBottom(true, false, 500, 500 + CoD.CoD9Button.Height * 5)
	f2_local0:addElement(f2_local4)
	local f2_local5 = f2_local4:addButton(UIExpression.ToUpper(f2_arg0, Engine.Localize("MENU_VOTING_REMIND_LATER")))
	f2_local5:setActionEventName("ghostupsell_remindlater")
	f2_local4:addElement(f2_local5)
	f2_local5:processEvent({
		name = "gain_focus"
	})
	if CoD.isXBOX then
		local f2_local6 = f2_local4:addButton(UIExpression.ToUpper(f2_arg0, Engine.Localize("MENU_BUY_NOW")))
		f2_local6:setActionEventName("ghostupsell_buynow")
		f2_local4:addElement(f2_local6)
	else
		local f2_local6 = f2_local4:addButton(UIExpression.ToUpper(f2_arg0, Engine.Localize("MENU_GO_TO_STORE")))
		f2_local6:setActionEventName("ghostupsell_gotostore")
		f2_local4:addElement(f2_local6)
	end
	local f2_local6 = f2_local4:addButton(UIExpression.ToUpper(f2_arg0, Engine.Localize("MENU_VOTING_NEVER_REMIND_AGAIN")))
	f2_local6:setActionEventName("ghostupsell_neverremind")
	f2_local4:addElement(f2_local6)
	f2_local0:addSelectButton()
	f2_local0:addBackButton()
	f2_local0:registerEventHandler("ghostupsell_gotostore", CoD.GhostUpsellPopup.GoToStore)
	f2_local0:registerEventHandler("ghostupsell_buynow", CoD.GhostUpsellPopup.BuyNow)
	f2_local0:registerEventHandler("ghostupsell_remindlater", CoD.GhostUpsellPopup.RemindLater)
	f2_local0:registerEventHandler("ghostupsell_neverremind", CoD.GhostUpsellPopup.NeverRemindAgain)
	f2_local0:registerEventHandler("button_prompt_back", CoD.GhostUpsellPopup.ButtonPromptBack)
	f2_local0:registerEventHandler("signed_out", CoD.GhostUpsellPopup.SignedOut)
	return f2_local0
end

CoD.GhostUpsellPopup.BuyNow = function (f3_arg0, f3_arg1)
	CoD.GhostUpsellPopup.SetGhostUpsellViewedTime(f3_arg1.controller, "GHOST_BUYNOW")
	Engine.SetDvar("ui_contextualMenuLocation", "ghostupsell")
	Engine.ExecNow(f3_arg1.controller, "buyProductByOfferID " .. Dvar.ui_productOfferID:get() .. " " .. 0)
	CoD.GhostUpsellPopup.Close(f3_arg0, f3_arg1)
end

CoD.GhostUpsellPopup.GoToStore = function (f4_arg0, f4_arg1)
	CoD.GhostUpsellPopup.SetGhostUpsellViewedTime(f4_arg1.controller, "GHOST_STORE")
	f4_arg0:goBack(f4_arg1.controller)
	Engine.SetDvar("ui_contextualMenuLocation", "ghostupsell")
	Engine.SetDvar("ui_storeCategory", CoD.GhostUpsellPopup.Category)
	CoD.MainLobby.OpenStore(f4_arg0.occludedMenu, f4_arg1)
end

CoD.GhostUpsellPopup.SetGhostUpsellViewedTime = function (f5_arg0, f5_arg1)
	Engine.ExecNow(f5_arg0, "setGhostUpsellViewed")
	Engine.ExecNow(f5_arg0, "uploadstats")
	Engine.SendGhostUpsellRecordEvent(f5_arg0, f5_arg1)
end

CoD.GhostUpsellPopup.RemindLater = function (f6_arg0, f6_arg1)
	CoD.GhostUpsellPopup.SetGhostUpsellViewedTime(f6_arg1.controller, "REMINDLATER")
	CoD.GhostUpsellPopup.Close(f6_arg0, f6_arg1)
end

CoD.GhostUpsellPopup.NeverRemindAgain = function (f7_arg0, f7_arg1)
	Engine.ExecNow(f7_arg1.controller, "setGhostUpsellOptOut")
	CoD.GhostUpsellPopup.SetGhostUpsellViewedTime(f7_arg1.controller, "NEVERREMINDAGAIN")
	CoD.GhostUpsellPopup.Close(f7_arg0, f7_arg1)
end

CoD.GhostUpsellPopup.Close = function (f8_arg0, f8_arg1)
	f8_arg0:goBack(f8_arg1.controller)
	f8_arg0.occludedMenu:processEvent({
		name = "ghostupsell_popup_closed",
		controller = f8_arg1.controller
	})
end

CoD.GhostUpsellPopup.ButtonPromptBack = function (f9_arg0, f9_arg1)
	CoD.GhostUpsellPopup.SetGhostUpsellViewedTime(f9_arg1.controller, "REMINDLATER")
	f9_arg0:goBack(f9_arg1.controller)
end

CoD.GhostUpsellPopup.SignedOut = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg0:getRoot()
	CoD.GhostUpsellPopup.Close(f10_arg0, f10_arg1)
	f10_local0:processEvent({
		name = "open_popup",
		popupName = "signed_out",
		controller = f10_arg1.controller
	})
end

