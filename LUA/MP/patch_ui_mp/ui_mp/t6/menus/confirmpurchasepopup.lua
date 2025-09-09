CoD.ConfirmPurchase = {}
CoD.ConfirmPurchase.PreviewHeight = 100
local f0_local0 = function (f1_arg0, f1_arg1)
	CoD.perController[f1_arg1.controller].purchaseEvent = nil
	CoD.perController[f1_arg1.controller].purchaseEquipEvent = nil
	CoD.perController[f1_arg1.controller].purchaseItemIndex = nil
	f1_arg0:goBack()
end

local f0_local1 = function (f2_arg0, f2_arg1)
	Engine.PurchaseItem(f2_arg1.controller, CoD.perController[f2_arg1.controller].purchaseItemIndex)
	f2_arg0.occludedMenu:processEvent(CoD.perController[f2_arg1.controller].purchaseEvent)
	f0_local0(f2_arg0, f2_arg1)
end

local f0_local2 = function (f3_arg0, f3_arg1)
	local f3_local0 = CoD.perController[f3_arg1.controller].purchaseEquipEvent
	local f3_local1 = f3_arg0.occludedMenu
	f0_local1(f3_arg0, f3_arg1)
	f3_arg0:close()
	if f3_local0 ~= nil then
		f3_local1:processEvent(f3_local0)
	end
end

local f0_local3 = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	local f4_local0 = LUI.UIText.new()
	f4_local0:setLeftRight(true, true, 0, 0)
	f4_local0:setTopBottom(true, false, f4_arg1, f4_arg1 + f4_arg2)
	f4_local0:setFont(f4_arg3)
	f4_local0:setAlignment(LUI.Alignment.Left)
	f4_local0:setText(f4_arg4)
	f4_arg0:addElement(f4_local0)
	return f4_local0
end

LUI.createMenu.ConfirmPurchase = function (f5_arg0, f5_arg1)
	local f5_local0 = CoD.Menu.NewSmallPopup("ConfirmPurchase")
	f5_local0.updatePreview = CoD.ConfirmPurchase.UpdatePreview
	f5_local0:addSelectButton()
	f5_local0:addBackButton()
	f5_local0:registerEventHandler("buy_equip_action", f0_local2)
	f5_local0:registerEventHandler("buy_action", f0_local1)
	f5_local0:registerEventHandler("cancel_action", f0_local0)
	f5_local0:registerEventHandler("button_prompt_back", f0_local0)
	local f5_local1 = 0
	f5_local0.messageText = f0_local3(f5_local0, f5_local1, CoD.textSize.Big, CoD.fonts.Big, Engine.Localize("MPUI_CONFIRM_PURCHASE_CAPS"))
	f5_local1 = f5_local1 + CoD.textSize.Big
	f5_local0.itemText = f0_local3(f5_local0, f5_local1, CoD.textSize.Default, CoD.fonts.Default, Engine.Localize("MPUI_UNLOCK_ITEM", UIExpression.GetItemName(f5_arg0, CoD.perController[f5_arg0].purchaseItemIndex)))
	f5_local1 = f5_local1 + CoD.textSize.Default
	local f5_local2 = CoD.CAC.GetUnlockCountForGroup(f5_arg0, UIExpression.GetItemGroup(f5_arg0, CoD.perController[f5_arg0].purchaseItemIndex))
	local f5_local3 = Engine.Localize("MENU_UNLOCK_TOKEN_AVAILABLE", f5_local2)
	if f5_local2 > 1 then
		f5_local3 = Engine.Localize("MPUI_UNLOCK_TOKENS_AVAILABLE", f5_local2)
	end
	f5_local0.tokenText = f0_local3(f5_local0, f5_local1, CoD.textSize.Default, CoD.fonts.Default, f5_local3)
	f5_local1 = f5_local1 + CoD.textSize.Default
	local f5_local4 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 4 + 10,
		bottom = 0
	})
	f5_local0:addElement(f5_local4)
	local f5_local5 = CoD.ConfirmPurchase.PreviewHeight
	local f5_local6 = f5_local5 * 2
	local f5_local7 = CoD.ConfirmPurchase.PreviewHeight + 2
	local f5_local8 = 40
	f5_local0.previewImage = LUI.UIImage.new()
	f5_local0.previewImage:setLeftRight(false, true, -f5_local7 - f5_local6 / 2, -f5_local7 - f5_local6 / 2)
	f5_local0.previewImage:setTopBottom(false, true, -f5_local8 - f5_local5, -f5_local8)
	f5_local0.previewImage:setAlpha(0)
	f5_local0:addElement(f5_local0.previewImage)
	if not f5_arg1 then
		local f5_local9 = f5_local4:addButton(Engine.Localize("MENU_UNLOCK_AND_EQUIP"))
		f5_local9:setActionEventName("buy_equip_action")
	end
	local f5_local9 = f5_local4:addButton(Engine.Localize("MENU_UNLOCK"))
	f5_local9:setActionEventName("buy_action")
	local f5_local10 = f5_local4:addButton(Engine.Localize("MENU_CANCEL_UNLOCK"))
	f5_local10:setActionEventName("cancel_action")
	f5_local10:processEvent({
		name = "gain_focus"
	})
	return f5_local0
end

CoD.ConfirmPurchase.UpdatePreview = function (f6_arg0, f6_arg1)
	local f6_local0, f6_local1, f6_local2 = CoD.GetItemMaterialNameWidthAndHeight(f6_arg1, true)
	local f6_local3 = CoD.ConfirmPurchase.PreviewHeight * f6_local1 / f6_local2
	local f6_local4 = CoD.ConfirmPurchase.PreviewHeight + 2
	f6_arg0.previewImage:beginAnimation("change_material")
	f6_arg0.previewImage:setLeftRight(false, true, -f6_local4 - f6_local3 / 2, -f6_local4 + f6_local3 / 2)
	f6_arg0.previewImage:setImage(RegisterMaterial(f6_local0))
	f6_arg0.previewImage:setAlpha(1)
end

CoD.ConfirmPurchase.OpenIfNecessary = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)
	if UIExpression.IsItemLocked(f7_arg1, f7_arg2) == 0 and UIExpression.IsItemPurchased(f7_arg1, f7_arg2) == 0 and UIExpression.GetItemCost(nil, f7_arg2) > 0 then
		if CoD.CAC.CanAffordUnlocksForItemIndex(f7_arg1, f7_arg2) then
			CoD.perController[f7_arg1].purchaseItemIndex = f7_arg2
			CoD.perController[f7_arg1].purchaseEvent = {
				name = "purchased",
				controller = f7_arg1,
				button = f7_arg3
			}
			CoD.perController[f7_arg1].purchaseEquipEvent = {
				name = "content_button_selected",
				controller = f7_arg1,
				contentIndex = f7_arg2,
				button = f7_arg3
			}
			local f7_local0 = f7_arg0:openPopup("ConfirmPurchase", f7_arg1, f7_arg4)
			f7_local0:updatePreview(f7_arg2)
			return f7_local0
		end
		Engine.PlaySound(CoD.CACUtility.denySFX)
	end
	return nil
end

