CoD.MTXPurchase = {}
LUI.createMenu.MTXPurchase = function (f1_arg0, f1_arg1)
	local f1_local0 = 480
	local f1_local1 = Engine.Localize(CoD.CACUtility.GetMTXPurchaseMsg(f1_arg1.mtxName))
	local f1_local2 = CoD.textSize.Default * math.max(5, Engine.GetNumTextLines(f1_local1, CoD.fonts.Default, CoD.textSize.Default, f1_local0)) + 160
	local f1_local3 = CoD.Popup.SetupPopup("MTXPurchase", f1_arg0, CoD.Popup.Type.STRETCHED)
	f1_local3:setWidthHeight(f1_local0, f1_local2)
	f1_local3:setOwner(f1_arg0)
	f1_local3.userData = f1_arg1
	f1_local3:registerEventHandler("open_warning", CoD.MTXPurchase.OpenWarning)
	f1_local3:registerEventHandler("cancel_action", CoD.Menu.ButtonPromptBack)
	f1_local3:addSelectButton()
	f1_local3:addBackButton()
	f1_local3.title:setText(Engine.Localize("MPUI_" .. f1_arg1.mtxName))
	f1_local3.msg:setText(f1_local1)
	local f1_local4 = CoD.ButtonList.new()
	local f1_local5 = -1 * (CoD.CoD9Button.Height * 3 + CoD.ButtonList.ButtonSpacing * 3)
	f1_local4:setLeftRight(true, true, 0, 0)
	f1_local4:setTopBottom(false, true, f1_local5, 0)
	f1_local3:addElement(f1_local4)
	local f1_local6 = f1_local4:addButton(Engine.Localize("MENU_GO_TO_STORE"))
	f1_local6:setActionEventName("open_warning")
	local f1_local7 = f1_local4:addButton(Engine.Localize("MPUI_CANCEL"))
	f1_local7:setActionEventName("cancel_action")
	f1_local7:processEvent({
		name = "gain_focus"
	})
	return f1_local3
end

CoD.MTXPurchase.OpenWarning = function (f2_arg0, f2_arg1)
	local f2_local0 = Engine.IsGameLobbyRunning()
	local f2_local1 = Engine.IsPartyLobbyRunning()
	if f2_local0 then
		local f2_local2 = f2_arg0:openMenu("MTXStoreWarning", f2_arg1.controller, f2_arg0.userData)
		if UIExpression.AloneInPartyIgnoreSplitscreen(f2_arg1.controller, 1) == 1 then
			f2_local2.msg:setText(Engine.Localize("MPUI_MTX_LEAVE_LOBBY_WARNING"))
		else
			f2_local2.msg:setText(Engine.Localize("MPUI_MTX_LEAVE_PARTY_WARNING"))
		end
		f2_local2:setPreviousMenu(nil)
		f2_arg0:close()
	elseif f2_local1 and UIExpression.AloneInPartyIgnoreSplitscreen(f2_arg1.controller, 1) == 0 then
		local f2_local2 = f2_arg0:openMenu("MTXStoreWarning", f2_arg1.controller, f2_arg0.userData)
		f2_local2.msg:setText(Engine.Localize("MPUI_MTX_LEAVE_PARTY_WARNING"))
		f2_local2:setPreviousMenu(nil)
		f2_arg0:close()
	else
		CoD.MTXPurchase.GoToStore(f2_arg0, f2_arg1)
	end
end

LUI.createMenu.MTXStoreWarning = function (f3_arg0, f3_arg1)
	local f3_local0 = 480
	local f3_local1 = CoD.textSize.Default * 5 + 160
	local f3_local2 = CoD.Popup.SetupPopup("MTXPurchase", f3_arg0, CoD.Popup.Type.STRETCHED)
	f3_local2:setWidthHeight(f3_local0, f3_local1)
	f3_local2:setOwner(f3_arg0)
	f3_local2.userData = f3_arg1
	f3_local2:registerEventHandler("go_to_store", CoD.MTXPurchase.GoToStore)
	f3_local2:registerEventHandler("cancel_action", CoD.Menu.ButtonPromptBack)
	f3_local2:addSelectButton()
	f3_local2:addBackButton()
	f3_local2.title:setText(Engine.Localize("MENU_WARNING"))
	local f3_local3 = CoD.ButtonList.new()
	local f3_local4 = -1 * (CoD.CoD9Button.Height * 3 + CoD.ButtonList.ButtonSpacing * 3)
	f3_local3:setLeftRight(true, true, 0, 0)
	f3_local3:setTopBottom(false, true, f3_local4, 0)
	f3_local2:addElement(f3_local3)
	local f3_local5 = f3_local3:addButton(Engine.Localize("MENU_CONTINUE"))
	f3_local5:setActionEventName("go_to_store")
	local f3_local6 = f3_local3:addButton(Engine.Localize("MPUI_CANCEL"))
	f3_local6:setActionEventName("cancel_action")
	f3_local6:processEvent({
		name = "gain_focus"
	})
	return f3_local2
end

CoD.MTXPurchase.GoToStore = function (f4_arg0, f4_arg1)
	Engine.PurchaseMTX(f4_arg1.controller, f4_arg0.userData.mtxName, f4_arg0.userData.openingMenuName)
end

