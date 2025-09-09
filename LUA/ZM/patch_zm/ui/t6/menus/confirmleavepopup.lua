CoD.ConfirmLeave = {}
local f0_local0 = function (f1_arg0, f1_arg1)
	if f1_arg0.confirmEvent == nil then
		return 
	else
		f1_arg0:goBack(f1_arg1.controller)
		f1_arg0.occludedMenu:processEvent({
			name = f1_arg0.confirmEvent,
			controller = f1_arg1.controller
		})
	end
end

local f0_local1 = function (f2_arg0, f2_arg1)
	if f2_arg0.cancelEvent == nil then
		return 
	else
		f2_arg0.occludedMenu:processEvent({
			name = f2_arg0.cancelEvent,
			controller = f2_arg1.controller
		})
		f2_arg0:goBack(f2_arg1.controller)
	end
end

CoD.ConfirmLeave.SetConfirmEvent = function (f3_arg0, f3_arg1)
	f3_arg0.confirmEvent = f3_arg1
end

CoD.ConfirmLeave.SetCancelEvent = function (f4_arg0, f4_arg1)
	f4_arg0.cancelEvent = f4_arg1
end

CoD.ConfirmLeave.CustomAction = function (f5_arg0, f5_arg1)
	if f5_arg1.button.leaveEvent == nil then
		return 
	elseif CoD.isZombie and (Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) == true or Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == true) and UIExpression.IsPrimaryLocalClient(f5_arg1.controller) == 0 then
		f5_arg0:openPopup("NoLeave")
		return 
	else
		f5_arg0:goBack(f5_arg1.controller)
		f5_arg0.occludedMenu:processEvent({
			name = f5_arg1.button.leaveEvent,
			controller = f5_arg1.controller
		})
	end
end

LUI.createMenu.ConfirmLeave = function (f6_arg0, f6_arg1)
	local f6_local0 = CoD.Menu.NewSmallPopup("ConfirmLeave")
	f6_local0:addSelectButton()
	f6_local0:addBackButton()
	f6_local0:registerEventHandler("confirm_action", f0_local0)
	f6_local0:registerEventHandler("cancel_action", CoD.Menu.ButtonPromptBack)
	f6_local0:registerEventHandler("custom_action", CoD.ConfirmLeave.CustomAction)
	f6_local0.setMessageText = CoD.ConfirmLeave.SetMessageText
	f6_local0.setConfirmEvent = CoD.ConfirmLeave.SetConfirmEvent
	f6_local0.setCancelEvent = CoD.ConfirmLeave.SetCancelEvent
	local f6_local1 = 0
	local f6_local2 = LUI.UIText.new()
	f6_local2:setLeftRight(true, false, 0, CoD.Menu.SmallPopupWidth)
	f6_local2:setTopBottom(true, false, f6_local1, f6_local1 + CoD.textSize.Big)
	f6_local2:setFont(CoD.fonts.Big)
	f6_local2:setAlignment(LUI.Alignment.Left)
	f6_local2:setText(f6_arg1.titleText)
	f6_local0:addElement(f6_local2)
	f6_local1 = f6_local1 + CoD.textSize.Big
	local f6_local3 = LUI.UIText.new()
	f6_local3:setLeftRight(true, true, 0, 0)
	f6_local3:setTopBottom(true, false, f6_local1, f6_local1 + CoD.textSize.Default)
	f6_local3:setFont(CoD.fonts.Default)
	f6_local3:setAlignment(LUI.Alignment.Left)
	f6_local0:addElement(f6_local3)
	if f6_arg1 ~= nil and f6_arg1.messageText ~= nil then
		f6_local3:setText(f6_arg1.messageText)
	end
	local f6_local4 = 1
	local f6_local5 = 10
	if f6_arg1 and f6_arg1.params and #f6_arg1.params > 0 then
		f6_local4 = #f6_arg1.params
		if f6_local4 == 2 and CoD.isZombie == true then
			f6_local5 = 0
		end
	end
	f6_local0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height * f6_local4 - CoD.CoD9Button.Height * 3 + f6_local5,
		bottom = 0
	})
	f6_local0:addElement(f6_local0.buttonList)
	if f6_arg1 ~= nil then
		for f6_local9, f6_local10 in pairs(f6_arg1.params) do
			local f6_local11 = f6_local0.buttonList:addButton(f6_local10.leaveText)
			f6_local11:setActionEventName("custom_action")
			f6_local11.leaveEvent = f6_local10.leaveEvent
		end
	else
		local f6_local6 = f6_local0.buttonList:addButton(Engine.Localize("MPUI_YES"))
		f6_local6:setActionEventName("confirm_action")
	end
	local f6_local6 = f6_local0.buttonList:addButton(Engine.Localize("MPUI_CANCEL"))
	f6_local6:setActionEventName("cancel_action")
	f6_local6:processEvent({
		name = "gain_focus"
	})
	Engine.PlaySound("caC_main_exit_cac")
	return f6_local0
end

