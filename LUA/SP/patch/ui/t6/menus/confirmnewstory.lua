CoD.ConfirmNewStory = {}
CoD.ConfirmNewStory.PopupOpen = false
LUI.createMenu.ConfirmNewStory = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSmallPopup("ConfirmNewStory", true)
	local f1_local1 = "Default"
	local f1_local2 = 0
	f1_local0:registerEventHandler("confirm_request", CoD.ConfirmNewStory.ConfirmRequest)
	f1_local0:registerEventHandler("input_source_changed", CoD.ConfirmNewStory.InputSourceChanged)
	f1_local0:registerAnimationState("hide", {
		alpha = 0
	})
	f1_local0.title = LUI.UIText.new()
	f1_local0.title:setLeftRight(true, true, 0, 0)
	f1_local0.title:setTopBottom(true, false, f1_local2, f1_local2 + CoD.textSize[f1_local1] * 1.05)
	f1_local0.title:setAlignment(LUI.Alignment.Center)
	f1_local0.title:setFont(CoD.fonts[f1_local1])
	f1_local0.title:setText(Engine.Localize("MENU_NEW_STORY_TITLE"))
	f1_local0:addElement(f1_local0.title)
	f1_local0.text = LUI.UIText.new()
	f1_local0.text:setLeftRight(true, true, 0, 0)
	f1_local0.text:setTopBottom(true, false, f1_local2 + CoD.textSize[f1_local1] * 1.25, f1_local2 + CoD.textSize[f1_local1] * 1.25 + CoD.textSize[f1_local1] * 1.05)
	f1_local0.text:setAlignment(LUI.Alignment.Center)
	f1_local0.text:setFont(CoD.fonts[f1_local1])
	if CoD.useController and Engine.LastInput_Gamepad() then
		f1_local0.text:setText(Engine.Localize("MENU_NEW_STORY"))
	else
		f1_local0.text:setText(Engine.Localize("MENU_NEW_STORY_KEYBOARD"))
	end
	f1_local0:addElement(f1_local0.text)
	f1_local0:addSelectButton()
	local f1_local3 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height - 21,
		bottom = -15
	})
	f1_local0:addElement(f1_local3)
	local f1_local4 = f1_local3:addButton(Engine.Localize("MENU_CONFIRM_CAPS"))
	f1_local4:setActionEventName("confirm_request")
	f1_local3:processEvent({
		name = "gain_focus"
	})
	CoD.ConfirmNewStory.PopupOpen = true
	return f1_local0
end

CoD.ConfirmNewStory.ConfirmRequest = function (f2_arg0, f2_arg1)
	f2_arg0:goBack(f2_arg1.controller)
	if CoD.FrontendSaveGameErrorPopup.SaveGameErrorPopup then
		CoD.ConfirmNewStory.PopupOpen = false
		f2_arg0.occludedMenu:dispatchEventToRoot({
			name = "open_popup",
			popupName = "FrontendSaveGameErrorPopup"
		})
	end
end

CoD.ConfirmNewStory.InputSourceChanged = function (f3_arg0, f3_arg1)
	if CoD.useMouse then
		if CoD.useController and f3_arg1.source == 0 then
			f3_arg0.text:setText(Engine.Localize("MENU_NEW_STORY"))
		else
			f3_arg0.text:setText(Engine.Localize("MENU_NEW_STORY_KEYBOARD"))
		end
	end
end

