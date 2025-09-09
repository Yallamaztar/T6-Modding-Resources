require("T6.OptionElement")
CoD.KeyBindSelector = {}
CoD.KeyBindSelector.ArrowSize = CoD.CoD9Button.TextHeight
CoD.KeyBindSelector.LeftArrowMaterialName = "ui_arrow_left"
CoD.KeyBindSelector.RightArrowMaterialName = "ui_arrow_right"
CoD.KeyBindSelector.HorizontalGap = 300
CoD.KeyBindSelector.ButtonAction = function (menu, event)
	if not Engine.LastInput_Gamepad() then
		menu.bindText:setText(Engine.Localize("MENU_BIND_KEY_PENDING"))
		Engine.ExecNow(controller, "clearKeyStates")
		Engine.BindCommand(menu.controller, menu.m_command, menu.m_bindIndex)
	end
end

CoD.KeyBindSelector.KeyBound = function (menu, event)
	menu.bindText:setText(Engine.GetKeyBindingLocalizedString(event.controller, menu.m_command, menu.m_bindIndex, false, false, false, false, false, false))
end

CoD.KeyBindSelector.new = function (controller, bindLabel, bindCommand, bindIndex, f3_arg4, f3_arg5)
	local keyBindSelector = CoD.OptionElement.new(bindLabel, f3_arg4, f3_arg5)
	keyBindSelector.label.overDuration = nil
	keyBindSelector.label.upDuration = nil
	keyBindSelector.id = "KeyBindSelector." .. bindLabel
	keyBindSelector.m_bindLabel = bindLabel
	keyBindSelector.m_command = bindCommand
	keyBindSelector.m_bindIndex = bindIndex
	keyBindSelector.controller = controller
	keyBindSelector.horizontalList:addSpacer(CoD.KeyBindSelector.ArrowSize)
	keyBindSelector.bindText = LUI.UITightText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.CoD9Button.TextHeight / 2,
		bottom = CoD.CoD9Button.TextHeight / 2,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.5,
		font = CoD.fonts.Condensed
	})
	keyBindSelector.bindText:registerAnimationState("default", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.5
	})
	keyBindSelector.bindText:registerAnimationState("button_over", {
		red = CoD.BOIIOrange.r,
		green = CoD.BOIIOrange.g,
		blue = CoD.BOIIOrange.b,
		alpha = 1
	})
	keyBindSelector.bindText:setText(Engine.GetKeyBindingLocalizedString(controller, bindCommand, bindIndex, false, false, false, false, false, false))
	keyBindSelector.horizontalList:addElement(keyBindSelector.bindText)
	CoD.CoD9Button.SetupTextElement(keyBindSelector.bindText)
	keyBindSelector.bindText.overDuration = nil
	keyBindSelector.bindText.upDuration = nil
	keyBindSelector:registerEventHandler("button_action", CoD.KeyBindSelector.ButtonAction)
	keyBindSelector:registerEventHandler("key_bound", CoD.KeyBindSelector.KeyBound)
	keyBindSelector:registerEventHandler("input_source_changed", CoD.KeyBindSelector.KeyBound)
	return keyBindSelector
end

