require("T6.OptionElement")
CoD.WiiUKeyBindSelector = {}
CoD.WiiUKeyBindSelector.ButtonTextLeft = 300
CoD.WiiUKeyBindSelector.GestureTextLeft = 550
local f0_local0 = function (f1_arg0, f1_arg1)
	CoD.CoD9Button.GainFocus(f1_arg0, f1_arg1)
	f1_arg0.owner:processEvent({
		name = "button_selected",
		button = f1_arg0
	})
end

local f0_local1 = function (f2_arg0, f2_arg1)
	f2_arg0.owner:processEvent({
		name = "key_bind_started",
		controller = f2_arg1.controller
	})
	f2_arg0.gestureBindText:setText("")
	Engine.BindCommand(f2_arg0.controller, f2_arg0.action.command, CoD.BIND_PLAYER)
end

local f0_local2 = function (f3_arg0, f3_arg1)
	if f3_arg0:isInFocus() then
		if f3_arg1.twist_active and Engine.IsTwistBindingAllowed(f3_arg0.action.command) then
			f3_arg0.buttonBindText:setText(Engine.Localize("MENU_TWIST_BIND_KEY_PENDING"))
		elseif Engine.IsGestureBindingAllowed(f3_arg0.action.command) then
			f3_arg0.buttonBindText:setText(Engine.Localize("MENU_GESTURE_BIND_KEY_PENDING"))
		else
			f3_arg0.buttonBindText:setText(Engine.Localize("MENU_BIND_KEY_PENDING"))
		end
	end
end

local f0_local3 = function (f4_arg0, f4_arg1)
	f4_arg0.buttonBindText:setText("")
	f4_arg0.gestureBindText:setText("")
	local f4_local0 = Engine.GetKeyBindingLocalizedString(f4_arg0.controller, f4_arg0.action.command, CoD.BIND_PLAYER, false, false, false, false, false)
	local f4_local1 = Engine.GetGestureBindingLocalizedString(f4_arg0.controller, f4_arg0.action.command)
	if f4_local1 ~= "" then
		f4_arg0.gestureBindText:setText(f4_local1)
	end
	if Engine.IsCommandBound(f4_arg0.controller, f4_arg0.action.command, CoD.BIND_PLAYER) or Engine.IsCommandBound(f4_arg0.controller, f4_arg0.action.command, CoD.BIND_TWIST) then
		f4_arg0.buttonBindText:setText(f4_local0)
	else
		f4_arg0.buttonBindText:setText(Engine.Localize("MENU_NONE"))
	end
end

CoD.WiiUKeyBindSelector.new = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	local f5_local0 = CoD.OptionElement.new(f5_arg1, f5_arg3, f5_arg4)
	f5_local0.id = "WiiUKeyBindSelector." .. f5_arg1
	f5_local0.controller = f5_arg0
	f5_local0.bindLabel = f5_arg1
	f5_local0.action = f5_arg2
	f5_local0.buttonBindText = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.WiiUKeyBindSelector.ButtonTextLeft,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.CoD9Button.TextHeight / 2,
		bottom = CoD.CoD9Button.TextHeight / 2,
		red = CoD.ButtonTextColor.r,
		green = CoD.ButtonTextColor.g,
		blue = CoD.ButtonTextColor.b,
		alpha = 1,
		font = CoD.fonts.Condensed
	})
	f5_local0:addElement(f5_local0.buttonBindText)
	CoD.CoD9Button.SetupTextElement(f5_local0.buttonBindText)
	f5_local0.gestureBindText = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.WiiUKeyBindSelector.GestureTextLeft,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.CoD9Button.TextHeight / 2,
		bottom = CoD.CoD9Button.TextHeight / 2,
		red = CoD.ButtonTextColor.r,
		green = CoD.ButtonTextColor.g,
		blue = CoD.ButtonTextColor.b,
		alpha = 1,
		font = CoD.fonts.Condensed
	})
	f5_local0:addElement(f5_local0.gestureBindText)
	CoD.CoD9Button.SetupTextElement(f5_local0.gestureBindText)
	f5_local0:registerEventHandler("gain_focus", f0_local0)
	f5_local0:registerEventHandler("button_action", f0_local1)
	f5_local0:registerEventHandler("waiting_for_bind", f0_local2)
	f5_local0:registerEventHandler("refresh", f0_local3)
	return f5_local0
end

