CoD.WiiURemoteControlPresets = {}
CoD.WiiURemoteControlPresets.PresetInfo = {
	greenhorn = {
		command = "exec wiiu_remote_preset_greenhorn.cfg",
		label = Engine.Localize("PLATFORM_CONTROL_PRESET_GREENHORN_CAPS"),
		hint = Engine.Localize("PLATFORM_CONTROL_PRESET_GREENHORN_DESC"),
		restored = Engine.Localize("PLATFORM_CONTROL_PRESET_GREENHORN_RESTORED")
	},
	intermediate = {
		command = "exec wiiu_remote_preset_intermediate.cfg",
		label = Engine.Localize("PLATFORM_CONTROL_PRESET_INTERMEDIATE_CAPS"),
		hint = Engine.Localize("PLATFORM_CONTROL_PRESET_INTERMEDIATE_DESC"),
		restored = Engine.Localize("PLATFORM_CONTROL_PRESET_INTERMEDIATE_RESTORED")
	},
	advanced = {
		command = "exec wiiu_remote_preset_advanced.cfg",
		label = Engine.Localize("PLATFORM_CONTROL_PRESET_ADVANCED_CAPS"),
		hint = Engine.Localize("PLATFORM_CONTROL_PRESET_ADVANCED_DESC"),
		restored = Engine.Localize("PLATFORM_CONTROL_PRESET_ADVANCED_RESTORED")
	},
	professional = {
		command = "exec wiiu_remote_preset_professional.cfg",
		label = Engine.Localize("PLATFORM_CONTROL_PRESET_PROFESSIONAL_CAPS"),
		hint = Engine.Localize("PLATFORM_CONTROL_PRESET_PROFESSIONAL_DESC"),
		restored = Engine.Localize("PLATFORM_CONTROL_PRESET_PROFESSIONAL_RESTORED")
	},
	insane = {
		command = "exec wiiu_remote_preset_insane.cfg",
		label = Engine.Localize("PLATFORM_CONTROL_PRESET_INSANE_CAPS"),
		hint = Engine.Localize("PLATFORM_CONTROL_PRESET_INSANE_DESC"),
		restored = Engine.Localize("PLATFORM_CONTROL_PRESET_INSANE_RESTORED")
	}
}
CoD.WiiURemoteControlPresets.Button_ApplyPreset = function (f1_arg0, f1_arg1)
	f1_arg0:dispatchEventToParent({
		name = "apply_preset",
		controller = f1_arg1.controller,
		presetInfo = f1_arg0.presetInfo
	})
end

local f0_local0 = function (f2_arg0, f2_arg1)
	local f2_local0 = CoD.WiiURemoteControlPresets.PresetInfo[f2_arg1]
	local f2_local1 = f2_arg0.buttonList:addButton(f2_local0.label, f2_local0.hint)
	f2_local1.presetInfo = f2_local0
	f2_local1:registerEventHandler("button_action", CoD.WiiURemoteControlPresets.Button_ApplyPreset)
	f2_arg0.buttons[f2_arg1] = f2_local1
end

CoD.WiiURemoteControlPresets.ApplyPreset = function (f3_arg0, f3_arg1)
	Engine.ExecNow(f3_arg1.controller, f3_arg1.presetInfo.command)
	f3_arg0:saveState()
	f3_arg0:goBack(f3_arg1.controller)
end

local f0_local1 = function (f4_arg0, f4_arg1)
	presetInfo = CoD.WiiURemoteControlPresets.PresetInfo[f4_arg1]
	button = f4_arg0.buttonList:addButton(presetInfo.label, presetInfo.hing)
	button.presetInfo = presetInfo
	button:registerEventHandler("button_action", CoD.WiiURemoteControlPresets.Button_ApplyPreset)
	return button
end

LUI.createMenu.WiiURemoteControlPresets = function (f5_arg0)
	local f5_local0 = CoD.Wiiu.CreateOptionMenu(f5_arg0, "WiiURemoteControlPresets", "PLATFORM_CONTROL_PRESETS_CAPS")
	f5_local0:addSelectButton()
	f5_local0:addBackButton()
	f5_local0.close = CoD.Options.Close
	f5_local0:registerEventHandler("apply_preset", CoD.WiiURemoteControlPresets.ApplyPreset)
	CoD.WiiUControllerSettings.SetAsRemoteOnlyMenu(f5_local0)
	f5_local0.buttons = {}
	f0_local0(f5_local0, "greenhorn")
	f0_local0(f5_local0, "intermediate")
	f0_local0(f5_local0, "advanced")
	f0_local0(f5_local0, "professional")
	f0_local0(f5_local0, "insane")
	f5_local0.buttons[UIExpression.ProfileString(f5_arg0, "lastControlPreset")]:processEvent({
		name = "gain_focus"
	})
	return f5_local0
end

