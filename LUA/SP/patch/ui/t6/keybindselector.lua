require("T6.OptionElement")
CoD.KeyBindSelector = {}
CoD.KeyBindSelector.ArrowSize = CoD.CoD9Button.TextHeight
CoD.KeyBindSelector.LeftArrowMaterialName = "ui_arrow_left"
CoD.KeyBindSelector.RightArrowMaterialName = "ui_arrow_right"
CoD.KeyBindSelector.HorizontalGap = 300
CoD.KeyBindSelector.ButtonAction = function (f1_arg0, f1_arg1)
	if not Engine.LastInput_Gamepad() then
		f1_arg0.bindText:setText(Engine.Localize("MENU_BIND_KEY_PENDING"))
		Engine.ExecNow(controller, "clearKeyStates")
		Engine.BindCommand(f1_arg0.controller, f1_arg0.m_command, f1_arg0.m_bindIndex)
	end
end

CoD.KeyBindSelector.KeyBound = function (f2_arg0, f2_arg1)
	f2_arg0.bindText:setText(Engine.GetKeyBindingLocalizedString(f2_arg1.controller, f2_arg0.m_command, f2_arg0.m_bindIndex, false, false, false, false, false, false))
end

CoD.KeyBindSelector.new = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5)
	local f3_local0 = CoD.OptionElement.new(f3_arg1, f3_arg4, f3_arg5)
	f3_local0.label.overDuration = nil
	f3_local0.label.upDuration = nil
	f3_local0.id = "KeyBindSelector." .. f3_arg1
	f3_local0.m_bindLabel = f3_arg1
	f3_local0.m_command = f3_arg2
	f3_local0.m_bindIndex = f3_arg3
	f3_local0.controller = f3_arg0
	f3_local0.horizontalList:addSpacer(CoD.KeyBindSelector.ArrowSize)
	f3_local0.bindText = LUI.UITightText.new({
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
	f3_local0.bindText:registerAnimationState("default", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0.5
	})
	f3_local0.bindText:registerAnimationState("button_over", {
		red = CoD.BOIIOrange.r,
		green = CoD.BOIIOrange.g,
		blue = CoD.BOIIOrange.b,
		alpha = 1
	})
	f3_local0.bindText:setText(Engine.GetKeyBindingLocalizedString(f3_arg0, f3_arg2, f3_arg3, false, false, false, false, false, false))
	f3_local0.horizontalList:addElement(f3_local0.bindText)
	CoD.CoD9Button.SetupTextElement(f3_local0.bindText)
	f3_local0.bindText.overDuration = nil
	f3_local0.bindText.upDuration = nil
	f3_local0:registerEventHandler("button_action", CoD.KeyBindSelector.ButtonAction)
	f3_local0:registerEventHandler("key_bound", CoD.KeyBindSelector.KeyBound)
	f3_local0:registerEventHandler("input_source_changed", CoD.KeyBindSelector.KeyBound)
	return f3_local0
end

