CoD.TextMessageHome = {}
CoD.TextMessageHome.Messages = {}
CoD.TextMessageHome.RecentlyDeleted = {}
CoD.TextMessageHome.RecentlyDeletedInsertIndex = 1
CoD.TextMessageHome.HeaderHeight = 40
CoD.TextMessageHome.InboxHeight = 270
CoD.TextMessageHome.MessageHeight = 275
CoD.TextMessageHome.FromColumnWidth = 200
CoD.TextMessageHome.SentColumnWidth = 200
CoD.TextMessageHome.InboxButtonsPerPage = 10
CoD.TextMessageHome.InboxButtonWidth = 840
CoD.TextMessageHome.PreviewMaxCharacters = 50
local f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg1.senderText = LUI.UIText.new({
		font = CoD.fonts.Default
	})
	f1_arg1.senderText:setLeftRight(true, false, 10, 0)
	f1_arg1.senderText:setTopBottom(true, false, 0, CoD.textSize.Default)
	f1_arg1:addElement(f1_arg1.senderText)
	f1_arg1.timeText = LUI.UIText.new({
		font = CoD.fonts.Default
	})
	f1_arg1.timeText:setLeftRight(true, false, 10 + CoD.TextMessageHome.FromColumnWidth, 0)
	f1_arg1.timeText:setTopBottom(true, false, 0, CoD.textSize.Default)
	f1_arg1:addElement(f1_arg1.timeText)
	f1_arg1.prevText = LUI.UIText.new({
		font = CoD.fonts.Default
	})
	f1_arg1.prevText:setLeftRight(true, false, 10 + CoD.TextMessageHome.FromColumnWidth + CoD.TextMessageHome.SentColumnWidth, 0)
	f1_arg1.prevText:setTopBottom(true, false, 0, CoD.textSize.Default)
	f1_arg1:addElement(f1_arg1.prevText)
end

local f0_local1 = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = CoD.TextMessageHome.Messages[f2_arg0][f2_arg1]
	f2_arg2.senderText:setText(f2_local0.sender)
	f2_arg2.timeText:setText(f2_local0.time)
	local f2_local1 = f2_local0.body
	if CoD.TextMessageHome.PreviewMaxCharacters < string.len(f2_local1) then
		f2_local1 = string.sub(f2_local0.body, 0, CoD.TextMessageHome.PreviewMaxCharacters) .. "..."
	end
	f2_arg2.prevText:setText(f2_local1)
end

local f0_local2 = function (f3_arg0, f3_arg1)
	f3_arg0.messageElement.textElement:setText(CoD.TextMessageHome.Messages[f3_arg0.controllerIndex][f3_arg1.index].body)
end

local f0_local3 = function (f4_arg0)
	for f4_local0 = 1, #CoD.TextMessageHome.RecentlyDeleted, 1 do
		if f4_arg0 == CoD.TextMessageHome.RecentlyDeleted[f4_local0] then
			return true
		end
	end
	return false
end

local f0_local4 = function (f5_arg0)
	CoD.TextMessageHome.RecentlyDeleted[CoD.TextMessageHome.RecentlyDeletedInsertIndex] = f5_arg0
	CoD.TextMessageHome.RecentlyDeletedInsertIndex = (CoD.TextMessageHome.RecentlyDeletedInsertIndex + 1) % 10
end

local f0_local5 = function (f6_arg0)
	local f6_local0 = {}
	local f6_local1 = 1
	for f6_local2 = 1, #f6_arg0, 1 do
		if not f0_local3(f6_arg0[f6_local2].messageId) then
			f6_local0[f6_local1] = f6_arg0[f6_local2]
			f6_local1 = f6_local1 + 1
		end
	end
	return f6_local0
end

local f0_local6 = function (f7_arg0)
	local f7_local0 = f0_local5(Engine.GetTextMessageInfo(f7_arg0.controllerIndex))
	CoD.TextMessageHome.Messages[f7_arg0.controllerIndex] = f7_local0
	f7_arg0.inboxElement.inboxList:setTotalItems(#f7_local0)
	if #f7_local0 == 0 then
		f7_arg0.inboxElement.inboxList.m_messageElement.textField:setText(Engine.Localize("PLATFORM_UI_TM_NO_MESSAGES"))
	else
		f7_arg0.inboxElement.inboxList.m_messageElement.textField:setText("")
	end
	f7_arg0:updatePromptButtonVis()
end

local f0_local7 = function (f8_arg0)
	local f8_local0 = f8_arg0.ownerElement.parentMenu
	f8_local0.leftButtonPromptBar:removeAllChildren()
	f8_local0.rightButtonPromptBar:removeAllChildren()
	f8_local0:addRightButtonPrompt(f8_arg0.backButton)
	f8_local0:addRightButtonPrompt(f8_arg0.composeButton)
	if #CoD.TextMessageHome.Messages[f8_arg0.controllerIndex] ~= 0 then
		f8_local0:addRightButtonPrompt(f8_arg0.replyButton)
		f8_local0:addRightButtonPrompt(f8_arg0.deleteButton)
	end
end

local f0_local8 = function (f9_arg0, f9_arg1, f9_arg2)
	f9_arg0.ownerElement:switchToEditElement()
	if f9_arg1 ~= nil and f9_arg2 ~= nil then
		f9_arg0.ownerElement.editElement:setReplyRecipient(f9_arg1, f9_arg2)
	end
end

local f0_local9 = function (f10_arg0)
	local f10_local0 = f10_arg0.inboxElement.inboxList:getFocussedIndex()
	if f10_local0 ~= nil then
		local f10_local1 = CoD.TextMessageHome.Messages
		local f10_local2 = f10_arg0.ownerElement.parentMenu
		f10_local1 = f10_local1[f10_arg0:getOwner()][f10_local0]
		f0_local8(f10_arg0, f10_local1.sender, f10_local1.senderXuid)
	else
		f0_local8(f10_arg0)
	end
end

local f0_local10 = function (f11_arg0)
	f0_local8(f11_arg0)
end

local f0_local11 = function (f12_arg0, f12_arg1)
	local f12_local0 = f12_arg0.inboxElement.inboxList:getFocussedIndex()
	if f12_local0 ~= nil then
		local f12_local1 = CoD.TextMessageHome.Messages[f12_arg0.controllerIndex][f12_local0]
		if f12_local1 ~= nil then
			local f12_local2 = f12_arg0.ownerElement.parentMenu:openPopup("ConfirmDeleteTextMessage", f12_arg1.controller)
			f12_local2.homeRoot = f12_arg0
			f12_local2.messageId = f12_local1.messageId
		end
	end
end

local f0_local12 = function (f13_arg0, f13_arg1)
	Engine.DeleteTextMessage(f13_arg0.controllerIndex, f13_arg1)
	f0_local4(f13_arg1)
	CoD.TextMessageHome.Messages[f13_arg0.controllerIndex] = f0_local5(CoD.TextMessageHome.Messages[f13_arg0.controllerIndex])
	local f13_local0 = #CoD.TextMessageHome.Messages[f13_arg0.controllerIndex]
	f13_arg0.inboxElement.inboxList:setTotalItems(f13_local0)
	if f13_local0 == 0 then
		f13_arg0.inboxElement.inboxList.m_messageElement.textField:setText(Engine.Localize("PLATFORM_UI_TM_NO_MESSAGES"))
		f13_arg0.messageElement.textElement:setText("")
	end
	f13_arg0:updatePromptButtonVis()
end

CoD.TextMessageHome.CreateHomeElement = function (f14_arg0)
	local Widget = LUI.UIElement.new()
	Widget.ownerElement = f14_arg0
	Widget.controllerIndex = f14_arg0.parentMenu:getOwner()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	local Widget = LUI.UIElement.new()
	Widget.background = LUI.UIImage.new({
		red = 0,
		green = 0,
		blue = 0,
		alpha = 0.2
	})
	Widget.background:setLeftRight(true, true, 0, 0)
	Widget.background:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget.background)
	Widget:setLeftRight(true, true, 0, 0)
	local f14_local2 = LUI.UIText.new({
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	f14_local2:setLeftRight(true, false, 20, 0)
	f14_local2:setTopBottom(false, true, -CoD.textSize.Default, 0)
	f14_local2:setText(Engine.Localize("PLATFORM_UI_TM_FROM"))
	Widget:addElement(f14_local2)
	local f14_local3 = LUI.UIText.new({
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	f14_local3:setLeftRight(true, false, 20 + CoD.TextMessageHome.FromColumnWidth, 0)
	f14_local3:setTopBottom(false, true, -CoD.textSize.Default, 0)
	f14_local3:setText(Engine.Localize("PLATFORM_UI_TM_SENT"))
	Widget:addElement(f14_local3)
	local f14_local4 = LUI.UIText.new({
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	f14_local4:setLeftRight(true, false, 20 + CoD.TextMessageHome.FromColumnWidth + CoD.TextMessageHome.SentColumnWidth, 0)
	f14_local4:setTopBottom(false, true, -CoD.textSize.Default, 0)
	f14_local4:setText(Engine.Localize("PLATFORM_UI_TM_PREVIEW"))
	Widget:addElement(f14_local4)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	
	local inboxList = CoD.ListBox.new({}, f14_arg0.parentMenu:getOwner(), 10, CoD.TextMessageHome.InboxHeight / CoD.TextMessageHome.InboxButtonsPerPage, CoD.TextMessageHome.InboxButtonWidth, f0_local0, f0_local1, 5)
	inboxList:setLeftRight(true, true, 10, -10)
	inboxList:setTopBottom(true, true, 0, 0)
	inboxList.homeRoot = Widget
	inboxList.m_positionText.setText = function (f17_arg0, f17_arg1)

	end

	Widget:addElement(inboxList)
	Widget.inboxList = inboxList
	
	inboxList:removeElement(inboxList.m_positionText)
	local Widget = LUI.UIElement.new()
	Widget.background = LUI.UIImage.new({
		red = 0,
		green = 0,
		blue = 0,
		alpha = 0.2
	})
	Widget.background:setLeftRight(true, true, 0, 0)
	Widget.background:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget.background)
	Widget:setLeftRight(true, true, 0, 0)
	Widget.textElement = LUI.UIText.new({
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	Widget.textElement:setLeftRight(true, true, 40, -40)
	Widget.textElement:setTopBottom(true, false, 10, 10 + CoD.textSize.Big)
	Widget.textElement:setAlignment(LUI.Alignment.Left)
	Widget.textElement:setFont(CoD.fonts.Big)
	Widget.textElement:setText("")
	Widget:addElement(Widget.textElement)
	Widget:registerEventHandler("listbox_focus_changed", f0_local2)
	Widget.messageElement = Widget
	Widget.inboxElement = Widget
	Widget:addElement(Widget)
	Widget:addElement(Widget)
	Widget:addElement(Widget)
	Widget.backButton = CoD.ButtonPrompt.new("secondary", Engine.Localize("MPUI_DONE"), f14_arg0.parentMenu, "button_prompt_back")
	Widget.replyButton = CoD.ButtonPrompt.new("primary", Engine.Localize("PLATFORM_UI_TM_REPLY"), f14_arg0.parentMenu, "button_prompt_reply")
	Widget.composeButton = CoD.ButtonPrompt.new("alt1", Engine.Localize("PLATFORM_UI_TM_COMPOSE"), f14_arg0.parentMenu, "button_prompt_compose")
	Widget.deleteButton = CoD.ButtonPrompt.new("alt2", Engine.Localize("PLATFORM_UI_TM_DELETE"), f14_arg0.parentMenu, "button_prompt_delete")
	Widget:registerEventHandler("button_prompt_reply", f0_local9)
	Widget:registerEventHandler("button_prompt_compose", f0_local10)
	Widget:registerEventHandler("button_prompt_delete", f0_local11)
	Widget.updateMessages = f0_local6
	Widget.updatePromptButtonVis = f0_local7
	local f14_local8 = 0
	Widget:setTopBottom(true, false, f14_local8, CoD.TextMessageHome.HeaderHeight)
	f14_local8 = f14_local8 + CoD.TextMessageHome.HeaderHeight
	Widget:setTopBottom(true, false, f14_local8, f14_local8 + CoD.TextMessageHome.InboxHeight)
	Widget:setTopBottom(true, true, f14_local8 + CoD.TextMessageHome.InboxHeight, 0)
	Widget:updateMessages()
	return Widget
end

local f0_local13 = function (f15_arg0, f15_arg1)
	f0_local12(f15_arg0.homeRoot, f15_arg0.messageId)
	CoD.Menu.ButtonPromptBack(f15_arg0, f15_arg1)
end

LUI.createMenu.ConfirmDeleteTextMessage = function (f16_arg0)
	local f16_local0 = CoD.Menu.NewSmallPopup("ConfirmDeleteTextMessage")
	f16_local0:addSelectButton()
	f16_local0:addBackButton()
	f16_local0:registerEventHandler("confirm_action", f0_local13)
	f16_local0:registerEventHandler("cancel_action", CoD.Menu.ButtonPromptBack)
	local f16_local1 = 0
	f16_local0.messageText = LUI.UIText.new()
	f16_local0.messageText:setLeftRight(true, true, 0, 0)
	f16_local0.messageText:setTopBottom(true, false, f16_local1, f16_local1 + CoD.textSize.Big)
	f16_local0.messageText:setFont(CoD.fonts.Big)
	f16_local0.messageText:setAlignment(LUI.Alignment.Left)
	f16_local0.messageText:setText(Engine.Localize("PLATFORM_UI_TM_COMFIRM_DELETE"))
	f16_local0:addElement(f16_local0.messageText)
	local f16_local2 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	f16_local0:addElement(f16_local2)
	local f16_local3 = f16_local2:addButton(Engine.Localize("MPUI_YES"))
	f16_local3:setActionEventName("confirm_action")
	local f16_local4 = f16_local2:addButton(Engine.Localize("MPUI_NO"))
	f16_local4:setActionEventName("cancel_action")
	f16_local4:processEvent({
		name = "gain_focus"
	})
	return f16_local0
end

