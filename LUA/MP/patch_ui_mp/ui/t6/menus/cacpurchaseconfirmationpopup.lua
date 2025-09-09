CoD.PurchaseConfirmation = {}
CoD.PurchaseConfirmation.Close = function (f1_arg0)
	if f1_arg0.CAC ~= nil then
		f1_arg0.CAC:setBlur(true)
		f1_arg0.CAC:processEvent({
			name = "item_purchased",
			itemGridButton = f1_arg0.itemGridButton
		})
	end
	CoD.Menu.close(f1_arg0)
end

CoD.PurchaseConfirmation.Button_DoNotPurchaseCurrentItem = function (f2_arg0, f2_arg1)
	f2_arg0:dispatchEventToParent({
		name = "button_prompt_back",
		controller = f2_arg1.controller
	})
end

CoD.PurchaseConfirmation.Button_PurchaseCurrentItem = function (f3_arg0, f3_arg1)
	f3_arg0:dispatchEventToParent({
		name = "purchase_current_item",
		controller = f3_arg1.controller
	})
end

CoD.PurchaseConfirmation.PurchaseCurrentItem = function (f4_arg0, f4_arg1)
	Engine.PurchaseItem(f4_arg1.controller, f4_arg0.itemGridButton.itemIndex)
	f4_arg0:goBack(f4_arg1.controller)
end

LUI.createMenu.PurchaseConfirmation = function (f5_arg0)
	local f5_local0 = CoD.Menu.NewSmallPopup("PurchaseConfirmation")
	f5_local0.close = CoD.PurchaseConfirmation.Close
	f5_local0:registerEventHandler("purchase_current_item", CoD.PurchaseConfirmation.PurchaseCurrentItem)
	f5_local0:addSelectButton()
	f5_local0:addBackButton(Engine.Localize("MPUI_CANCEL"))
	local f5_local1 = 0
	f5_local0.messageText = LUI.UIText.new()
	f5_local0.messageText:setLeftRight(true, true, 0, 0)
	f5_local0.messageText:setTopBottom(true, false, f5_local1, f5_local1 + CoD.textSize.Condensed)
	f5_local0.messageText:setFont(CoD.fonts.Big)
	f5_local0.messageText:setAlignment(LUI.Alignment.Left)
	f5_local0.messageText:setText(Engine.Localize("MPUI_CONFIRM_PURCHASE_CAPS"))
	f5_local0:addElement(f5_local0.messageText)
	f5_local0.topRightTitle = LUI.UIText.new()
	f5_local0.topRightTitle:setLeftRight(true, true, 0, 0)
	f5_local0.topRightTitle:setTopBottom(true, false, 0, CoD.textSize.Big)
	f5_local0.topRightTitle:setFont(CoD.fonts.Big)
	f5_local0.topRightTitle:setAlignment(LUI.Alignment.Right)
	f5_local0:addElement(f5_local0.topRightTitle)
	f5_local0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	f5_local0:addElement(f5_local0.buttonList)
	f5_local0.purchaseButton = f5_local0.buttonList:addButton(Engine.Localize("MPUI_YES"), nil, 1)
	f5_local0.purchaseButton:registerEventHandler("button_action", CoD.PurchaseConfirmation.Button_PurchaseCurrentItem)
	f5_local0.doNotPurchaseButton = f5_local0.buttonList:addButton(Engine.Localize("MPUI_NO"), nil, 1)
	f5_local0.doNotPurchaseButton:registerEventHandler("button_action", CoD.PurchaseConfirmation.Button_DoNotPurchaseCurrentItem)
	f5_local0.purchaseButton:processEvent({
		name = "gain_focus"
	})
	return f5_local0
end

