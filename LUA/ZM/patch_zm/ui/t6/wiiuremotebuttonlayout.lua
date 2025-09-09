require("T6.WiiURemoteCustomize")
CoD.WiiURemoteButtonLayout = {}
CoD.WiiURemoteButtonLayout.CustomControlBindsInputLeft = 180
CoD.WiiURemoteButtonLayout.CustomControlBinds = {
	fire_weapon = {
		label = Engine.Localize("PLATFORM_FIRE"),
		input = "PLATFORM_CURBIND_ATTACK"
	},
	lock_camera = {
		label = Engine.Localize("PLATFORM_LOCKCAMERA"),
		input = "PLATFORM_CURBIND_LOCKCAMERA"
	},
	aim_down_sight = {
		label = Engine.Localize("PLATFORM_ADS"),
		input = "PLATFORM_CURBIND_ADS"
	},
	change_stance = {
		label = Engine.Localize("PLATFORM_STANCE"),
		input = "PLATFORM_CURBIND_STANCE"
	},
	sprint = {
		label = Engine.Localize("PLATFORM_SPRINT"),
		input = "PLATFORM_CURBIND_SPRINT"
	},
	throw_lethals = {
		label = Engine.Localize("PLATFORM_FRAG_GRENADE"),
		input = "PLATFORM_CURBIND_FRAG"
	},
	throw_tacticals = {
		label = Engine.Localize("PLATFORM_SPECIAL_GRENADE"),
		input = "PLATFORM_CURBIND_SMOKE"
	},
	reload = {
		label = Engine.Localize("PLATFORM_RELOAD_LABEL"),
		input = "PLATFORM_CURBIND_RELOAD"
	},
	use_interact = {
		label = Engine.Localize("PLATFORM_USE"),
		input = "PLATFORM_CURBIND_USE"
	},
	jump = {
		label = Engine.Localize("PLATFORM_JUMP"),
		input = "PLATFORM_CURBIND_JUMP"
	},
	melee_attack = {
		label = Engine.Localize("PLATFORM_MELEE"),
		input = "PLATFORM_CURBIND_MELEE"
	},
	switch_weapon = {
		label = Engine.Localize("PLATFORM_NEXTWEAPON"),
		input = "PLATFORM_CURBIND_WEAPNEXT"
	},
	pause_unpause = {
		label = Engine.Localize("PLATFORM_PAUSE_LABEL"),
		input = "PLATFORM_BUTTON_1"
	},
	inventory = {
		label = Engine.Localize("PLATFORM_SPECIALWEAPON"),
		input = "PLATFORM_CURBIND_INVENTORY"
	},
	scoreboard = {
		label = Engine.Localize("PLATFORM_SCOREBOARD_LABEL"),
		input = "PLATFORM_CURBIND_TOGGLESCORES"
	}
}
CoD.WiiURemoteButtonLayout.Button_LayoutSelected = function (f1_arg0, f1_arg1)
	Engine.SetProfileVar(f1_arg1.controller, "gpad_remoteButtonsConfig", f1_arg0.layoutValue)
	Engine.SetProfileVar(f1_arg1.controller, "wiiu_lastRemoteButtonLayout", f1_arg0.layoutValue)
	f1_arg0.owner:goBack(f1_arg1.controller)
end

CoD.WiiURemoteButtonLayout.Button_TheaterLayoutSelected = function (f2_arg0, f2_arg1)
	Engine.SetProfileVar(f2_arg1.controller, "demo_controllerConfig", f2_arg0.layoutValue)
	f2_arg0.owner:goBack(f2_arg1.controller)
end

CoD.WiiURemoteButtonLayout.Event_LayoutGainFocus = function (f3_arg0, f3_arg1)
	CoD.CoD9Button.GainFocus(f3_arg0, f3_arg1)
	CoD.WiiUButtonLayout.UpdateButtonLinesAndLabels(f3_arg0.owner.buttonLayoutImageContainer, f3_arg0.layoutValue)
end

CoD.WiiURemoteButtonLayout.Event_CustomizeGainFocus = function (f4_arg0, f4_arg1)
	CoD.CoD9Button.GainFocus(f4_arg0, f4_arg1)
	CoD.WiiUButtonLayout.HideButtonLinesAndLabels(f4_arg0.owner.buttonLayoutImageContainer, f4_arg0.owner.controller)
	f4_arg0.owner.buttonLayoutImageContainer.controllerImage:animateToState("fade_out", f4_arg0.owner.fadeInTime, false, false)
	f4_arg0.owner.customControlBinds:setAlpha(1)
end

CoD.WiiURemoteButtonLayout.Event_CustomizeLoseFocus = function (f5_arg0, f5_arg1)
	CoD.CoD9Button.LoseFocus(f5_arg0, f5_arg1)
	f5_arg0.owner.buttonLayoutImageContainer.controllerImage:animateToState("fade_in", f5_arg0.owner.fadeInTime, false, false)
	f5_arg0.owner.customControlBinds:setAlpha(0)
end

CoD.WiiURemoteButtonLayout.Button_CustomizeSelected = function (f6_arg0, f6_arg1)
	Engine.SetProfileVar(f6_arg1.controller, "gpad_remoteButtonsConfig", f6_arg0.layoutValue)
	f6_arg0:dispatchEventToParent({
		name = "open_remote_customize",
		controller = f6_arg1.controller
	})
end

CoD.WiiURemoteButtonLayout.OpenRemoteCustomize = function (f7_arg0, f7_arg1)
	f7_arg0:saveState()
	f7_arg0:openMenu("WiiURemoteCustomize", f7_arg1.controller)
	f7_arg0:close()
end

local f0_local0 = function (f8_arg0, f8_arg1)
	local f8_local0 = CoD.WiiURemoteButtonLayout.CustomControlBinds[f8_arg1]
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.CoD9Button.Height
	})
	local f8_local2 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.CoD9Button.TextHeight / 2,
		bottom = CoD.CoD9Button.TextHeight / 2,
		red = CoD.BOIIOrange.r,
		green = CoD.BOIIOrange.g,
		blue = CoD.BOIIOrange.b,
		alpha = 1,
		font = CoD.fonts.Condensed
	})
	f8_local2:setText(f8_local0.label)
	Widget:addElement(f8_local2)
	local f8_local3 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.WiiURemoteButtonLayout.CustomControlBindsInputLeft,
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
	f8_local3:setText(Engine.Localize(f8_local0.input))
	Widget:addElement(f8_local3)
	f8_arg0:addElement(Widget)
end

local f0_local1 = function ()
	local f9_local0 = LUI.UIVerticalList.new()
	f9_local0:setLeftRight(true, true, CoD.OptionElement.HorizontalGap, 0)
	f9_local0:setTopBottom(true, true, CoD.Menu.TitleHeight, 0)
	f9_local0:setSpacing(CoD.ButtonList.ButtonSpacing)
	f0_local0(f9_local0, "fire_weapon")
	f0_local0(f9_local0, "lock_camera")
	f0_local0(f9_local0, "aim_down_sight")
	f0_local0(f9_local0, "change_stance")
	f0_local0(f9_local0, "sprint")
	f0_local0(f9_local0, "throw_lethals")
	f0_local0(f9_local0, "throw_tacticals")
	f0_local0(f9_local0, "reload")
	f0_local0(f9_local0, "use_interact")
	f0_local0(f9_local0, "jump")
	f0_local0(f9_local0, "melee_attack")
	f0_local0(f9_local0, "switch_weapon")
	f0_local0(f9_local0, "pause_unpause")
	f0_local0(f9_local0, "inventory")
	if CoD.isMultiplayer then
		f0_local0(f9_local0, "scoreboard")
	end
	f9_local0:setAlpha(0)
	return f9_local0
end

LUI.createMenu.WiiURemoteButtonLayout = function (f10_arg0)
	local f10_local0 = CoD.Wiiu.CreateOptionMenu(f10_arg0, "WiiURemoteButtonLayout", "MENU_BUTTON_LAYOUT_CAPS")
	f10_local0:setPreviousMenu("WiiUControllerSettings")
	f10_local0.buttonList:setLeftRight(true, false, 0, CoD.ButtonList.DefaultWidth - 20)
	f10_local0.buttonList:setTopBottom(true, true, CoD.Menu.TitleHeight, 0)
	f10_local0:addSelectButton()
	f10_local0:addBackButton()
	f10_local0.close = CoD.Options.Close
	if UIExpression.IsDemoPlaying(f10_arg0) ~= 0 then
		local f10_local1 = f10_local0.buttonList:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_DEMO_CONTROLS_DEFAULT")))
		f10_local1.owner = f10_local0
		f10_local1.layoutValue = CoD.DEMO_CONTROLLER_CONFIG_DIGITAL
		f10_local1:registerEventHandler("gain_focus", CoD.WiiURemoteButtonLayout.Event_LayoutGainFocus)
		f10_local1:registerEventHandler("button_action", CoD.WiiURemoteButtonLayout.Button_TheaterLayoutSelected)
		f10_local1 = f10_local0.buttonList:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_DEMO_CONTROLS_BADBOT")))
		f10_local1.owner = f10_local0
		f10_local1.layoutValue = CoD.DEMO_CONTROLLER_CONFIG_BADBOT
		f10_local1:registerEventHandler("gain_focus", CoD.WiiURemoteButtonLayout.Event_LayoutGainFocus)
		f10_local1:registerEventHandler("button_action", CoD.WiiURemoteButtonLayout.Button_TheaterLayoutSelected)
	else
		for f10_local1 = 1, #CoD.WiiUControllerSettings.ButtonLayouts.remote.strings, 1 do
			local f10_local4 = f10_local0.buttonList:addButton(CoD.WiiUControllerSettings.ButtonLayouts.remote.strings[f10_local1])
			f10_local4.owner = f10_local0
			f10_local4.layoutValue = CoD.WiiUControllerSettings.ButtonLayouts.remote.values[f10_local1]
			if f10_local4.layoutValue == CoD.WiiUControllerSettings.WIIUMOTE_CUSTOM then
				f10_local4:registerEventHandler("gain_focus", CoD.WiiURemoteButtonLayout.Event_CustomizeGainFocus)
				f10_local4:registerEventHandler("lose_focus", CoD.WiiURemoteButtonLayout.Event_CustomizeLoseFocus)
				f10_local4:registerEventHandler("button_action", CoD.WiiURemoteButtonLayout.Button_CustomizeSelected)
				f10_local4.owner = f10_local0
			else
				f10_local4:registerEventHandler("gain_focus", CoD.WiiURemoteButtonLayout.Event_LayoutGainFocus)
				f10_local4:registerEventHandler("button_action", CoD.WiiURemoteButtonLayout.Button_LayoutSelected)
			end
		end
	end
	local f10_local1 = "wiiu_remote_top"
	f10_local0.buttonLayoutImageContainer = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = 0,
		bottom = 0
	})
	f10_local0.buttonLayoutImageContainer.priority = -100
	f10_local0.buttonLayoutImageContainer.controllerImage = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -250,
		right = 250,
		topAnchor = false,
		bottomAnchor = false,
		top = -175,
		bottom = 325,
		material = RegisterMaterial(f10_local1),
		alpha = 0
	})
	f10_local0.buttonLayoutImageContainer.controllerImage:registerAnimationState("fade_in", {
		alpha = 1
	})
	f10_local0.buttonLayoutImageContainer.controllerImage:registerAnimationState("fade_out", {
		alpha = 0
	})
	f10_local0.buttonLayoutImageContainer:addElement(f10_local0.buttonLayoutImageContainer.controllerImage)
	f10_local0:addElement(f10_local0.buttonLayoutImageContainer)
	f10_local0.buttonLayoutImageContainer.controllerImage:animateToState("fade_in", f10_local0.fadeInTime, false, false)
	f10_local0.customControlBinds = f0_local1()
	f10_local0:addElement(f10_local0.customControlBinds)
	CoD.WiiUButtonLayout.AddLinesAndLabels(f10_local0.buttonLayoutImageContainer, f10_arg0)
	f10_local0:registerEventHandler("open_remote_customize", CoD.WiiURemoteButtonLayout.OpenRemoteCustomize)
	CoD.WiiUControllerSettings.SetAsRemoteOnlyMenu(f10_local0)
	local f10_local2 = nil
	if UIExpression.IsDemoPlaying(f10_arg0) ~= 0 then
		f10_local2 = UIExpression.ProfileInt(f10_local0.controller, "demo_controllerConfig")
	else
		f10_local2 = UIExpression.ProfileInt(f10_local0.controller, "gpad_remoteButtonsConfig")
	end
	local f10_local3 = f10_local0.buttonList:getFirstChild()
	while f10_local3 do
		if f10_local3.layoutValue == f10_local2 then
			f10_local3:processEvent({
				name = "gain_focus"
			})
		end
		f10_local3 = f10_local3:getNextSibling()
	end
	return f10_local0
end

