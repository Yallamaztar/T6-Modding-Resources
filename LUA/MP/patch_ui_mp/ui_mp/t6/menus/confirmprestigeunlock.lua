CoD.ConfirmPrestigeUnlock = {}
local f0_local0 = function (f1_arg0, f1_arg1)
	CoD.perController[f1_arg1.controller].prestigeUnlockEvent = nil
	CoD.perController[f1_arg1.controller].prestigeUnlockEquipEvent = nil
	CoD.perController[f1_arg1.controller].prestigeUnlockItemIndex = nil
	f1_arg0:goBack()
end

local f0_local1 = function (f2_arg0, f2_arg1)
	Engine.PermanentlyUnlockItem(f2_arg1.controller, CoD.perController[f2_arg1.controller].prestigeUnlockItemIndex)
	f2_arg0.occludedMenu:processEvent(CoD.perController[f2_arg1.controller].prestigeUnlockEvent)
	f0_local0(f2_arg0, f2_arg1)
end

local f0_local2 = function (f3_arg0, f3_arg1)
	local f3_local0 = CoD.perController[f3_arg1.controller].prestigeUnlockEquipEvent
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

LUI.createMenu.ConfirmPrestigeUnlock = function (f5_arg0, f5_arg1)
	if Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE) then
		Engine.ExecNow(event.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE)
		return 
	elseif Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE_EXTRAS) then
		Engine.ExecNow(event.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE_EXTRAS)
		return 
	end
	local f5_local0 = CoD.Menu.NewSmallPopup("ConfirmPrestigeUnlock")
	f5_local0:addSelectButton()
	f5_local0:addBackButton()
	f5_local0:registerEventHandler("buy_equip_action", f0_local2)
	f5_local0:registerEventHandler("buy_action", f0_local1)
	f5_local0:registerEventHandler("cancel_action", f0_local0)
	f5_local0:registerEventHandler("button_prompt_back", f0_local0)
	local f5_local1 = 0
	f5_local0.messageText = f0_local3(f5_local0, f5_local1, CoD.textSize.Big, CoD.fonts.Big, Engine.Localize("MPUI_CONFIRM_PERMANENTLY_UNLOCK"))
	f5_local1 = f5_local1 + CoD.textSize.Big
	f5_local0.itemText = f0_local3(f5_local0, f5_local1, CoD.textSize.Default, CoD.fonts.Default, Engine.Localize("MPUI_PERMANENT_UNLOCK_ITEM", UIExpression.GetItemName(f5_arg0, CoD.perController[f5_arg0].prestigeUnlockItemIndex)))
	f5_local1 = f5_local1 + CoD.textSize.Default
	local f5_local2 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 4 + 10,
		bottom = 0
	})
	f5_local0:addElement(f5_local2)
	if not f5_arg1 then
		local f5_local3 = f5_local2:addButton(Engine.Localize("MENU_UNLOCK_AND_EQUIP"))
		f5_local3:setActionEventName("buy_equip_action")
	end
	local f5_local3 = f5_local2:addButton(Engine.Localize("MENU_UNLOCK"))
	f5_local3:setActionEventName("buy_action")
	local f5_local4 = f5_local2:addButton(Engine.Localize("MENU_CANCEL_UNLOCK"))
	f5_local4:setActionEventName("cancel_action")
	f5_local4:processEvent({
		name = "gain_focus"
	})
	return f5_local0
end

CoD.ConfirmPrestigeUnlock.OpenIfNecessary = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	if Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE) then
		Engine.ExecNow(f6_arg1, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE)
		return 
	elseif Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE_EXTRAS) then
		Engine.ExecNow(f6_arg1, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE_EXTRAS)
		return 
	else
		CoD.perController[f6_arg1].prestigeUnlockItemIndex = f6_arg2
		CoD.perController[f6_arg1].prestigeUnlockEvent = {
			name = "purchased",
			controller = f6_arg1,
			button = f6_arg3
		}
		CoD.perController[f6_arg1].prestigeUnlockEquipEvent = {
			name = "content_button_selected",
			controller = f6_arg1,
			contentIndex = f6_arg2,
			button = f6_arg3
		}
		return f6_arg0:openPopup("ConfirmPrestigeUnlock", f6_arg1, f6_arg4)
	end
end

