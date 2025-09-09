TextMessageFriendsPopup = {
	Selected = {}
}
local f0_local0 = function (f1_arg0)
	if f1_arg0 == true then
		return RegisterMaterial("textmessagefriends_checked")
	else
		return RegisterMaterial("textmessagefriends_unchecked")
	end
end

local f0_local1 = function (f2_arg0, f2_arg1)
	if not CoD.isSinglePlayer then
		f2_arg1.rank = LUI.UIText.new({
			left = 10,
			top = 0,
			right = 0,
			bottom = CoD.textSize.Default,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false,
			font = CoD.fonts.Default
		})
		f2_arg1:addElement(f2_arg1.rank)
		f2_arg1.rankIcon = LUI.UIImage.new({
			left = 35,
			top = 0,
			right = 60,
			bottom = 25,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false
		})
		f2_arg1:addElement(f2_arg1.rankIcon)
	end
	f2_arg1.name = LUI.UIText.new({
		left = 65,
		top = 0,
		right = 0,
		bottom = CoD.textSize.Default,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Default
	})
	f2_arg1:addElement(f2_arg1.name)
	f2_arg1.presence = LUI.UIText.new({
		left = 10,
		top = CoD.textSize.Default + 5,
		right = 0,
		bottom = CoD.textSize.Default * 2 + 5,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Default
	})
	f2_arg1:addElement(f2_arg1.presence)
	f2_arg1.checkbox = LUI.UIImage.new({
		left = -50,
		top = -20,
		right = -10,
		bottom = 20,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false
	})
	f2_arg1:addElement(f2_arg1.checkbox)
end

local f0_local2 = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = Engine.GetPlayerInfoByIndex(f3_arg0, f3_arg1 - 1, CoD.playerListType.friend)
	if f3_local0 ~= nil then
		f3_arg2.playerXuid = f3_local0.xuid
		f3_arg2.playerName = f3_local0.name
		f3_arg2.name:setText(f3_local0.name)
		f3_arg2.presence:setText(Engine.Localize(f3_local0.status))
		if not CoD.isSinglePlayer then
			if f3_local0.rank == "0" then
				f3_arg2.rank:setText("1")
			else
				f3_arg2.rank:setText(f3_local0.rank)
			end
			f3_arg2.rankIcon:setImage(RegisterMaterial(f3_local0.rankIcon))
		end
		f3_arg2.checkbox:setImage(f0_local0(TextMessageFriendsPopup.Selected[f3_arg0][f3_local0.name] ~= nil))
	end
end

local f0_local3 = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.listBox:getFocussedMutables()
	if f4_local0 ~= nil then
		if TextMessageFriendsPopup.Selected[f4_arg1.controller][f4_local0.playerName] ~= nil then
			TextMessageFriendsPopup.Selected[f4_arg1.controller][f4_local0.playerName] = nil
		else
			TextMessageFriendsPopup.Selected[f4_arg1.controller][f4_local0.playerName] = f4_local0.playerXuid
		end
		f4_local0.checkbox:setImage(f0_local0(TextMessageFriendsPopup.Selected[f4_arg1.controller][f4_local0.playerName] ~= nil))
	end
end

local f0_local4 = function (f5_arg0, f5_arg1)
	if f5_arg0.finishedCallback ~= nil then
		f5_arg0.finishedCallback(f5_arg0.finishedCallbackData)
	end
	CoD.Menu.ButtonPromptBack(f5_arg0, f5_arg1)
end

local f0_local5 = function (f6_arg0)
	f6_arg0.leftButtonPromptBar:removeAllChildren()
	f6_arg0.rightButtonPromptBar:removeAllChildren()
	f6_arg0:addLeftButtonPrompt(f6_arg0.checkButton)
	f6_arg0:addLeftButtonPrompt(f6_arg0.backButton)
end

local f0_local6 = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	TextMessageFriendsPopup.Selected[f7_arg0:getOwner()] = f7_arg1
	f7_arg0.finishedCallback = f7_arg2
	f7_arg0.finishedCallbackData = f7_arg3
	f7_arg0.listBox:refresh()
end

LUI.createMenu.TextMessageFriendsPopup = function (f8_arg0)
	local f8_local0 = CoD.Menu.New("TextMessageFriendsPopup")
	f8_local0:addLargePopupBackground()
	f8_local0:setOwner(f8_arg0)
	TextMessageFriendsPopup.Selected[f8_arg0] = {}
	f8_local0:addSelectButton()
	f8_local0:addBackButton()
	f8_local0.listBox = CoD.ListBox.new({
		left = 0,
		top = 30,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}, f8_arg0, 9, CoD.CoD9Button.Height * 2, 400, f0_local1, f0_local2, 5)
	f8_local0:addElement(f8_local0.listBox)
	f8_local0.backButton = CoD.ButtonPrompt.new("secondary", Engine.Localize("MPUI_DONE"), f8_local0, "button_prompt_back")
	f8_local0.checkButton = CoD.ButtonPrompt.new("primary", Engine.Localize("PLATFORM_UI_TM_ADD_REMOVE"), f8_local0, "button_prompt_check")
	f8_local0.listBox:setTotalItems(Engine.GetPlayerCount(f8_arg0, CoD.playerListType.friend))
	f0_local5(f8_local0)
	f8_local0:registerEventHandler("button_prompt_check", f0_local3)
	f8_local0:registerEventHandler("button_prompt_back", f0_local4)
	f8_local0.init = f0_local6
	return f8_local0
end

