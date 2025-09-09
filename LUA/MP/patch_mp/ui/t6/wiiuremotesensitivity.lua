require("T6.ProfileDiscreteLeftRightSlider")
CoD.WiiURemoteSensitivity = {}
CoD.WiiURemoteSensitivity.ProfileVarInfo = {
	cursorSensitivity = {
		name = "wiiu_filter_global_sens",
		default = 0.5,
		min = 0,
		max = 1,
		label = Engine.Localize("PLATFORM_CURSOR_SENSITIVITY_CAPS"),
		hint = Engine.Localize("PLATFORM_CURSOR_SENSITIVITY_DESC")
	},
	cameraSensitivity = {
		name = "aim_turnrate_ramp_factor",
		default = 5,
		min = 0.1,
		max = 10,
		label = Engine.Localize("PLATFORM_CAMERA_SENSITIVITY_CAPS"),
		hint = Engine.Localize("PLATFORM_CAMERA_SENSITIVITY_DESC")
	},
	scopeSensitivity = {
		name = "wiiu_scope_sensitivity",
		default = 0.7,
		min = 0.2,
		max = 1.5,
		label = Engine.Localize("PLATFORM_SCOPE_SENSITIVITY_CAPS"),
		hint = Engine.Localize("PLATFORM_SCOPE_SENSITIVITY_DESC")
	},
	turretSensitivity = {
		name = "wiiu_turret_sensitivity",
		default = 1,
		min = 0.3,
		max = 2.4,
		label = Engine.Localize("PLATFORM_TURRET_SENSITIVITY_CAPS"),
		hint = Engine.Localize("PLATFORM_TURRET_SENSITIVITY_DESC")
	}
}
local f0_local0 = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.WiiURemoteSensitivity.ProfileVarInfo[f1_arg1]
	return f1_arg0.buttonList:addProfileDiscreteLeftRightSlider(f1_arg0.controller, f1_local0.label, f1_local0.name, f1_local0.min, f1_local0.max, f1_local0.hint)
end

LUI.createMenu.WiiURemoteSensitivity = function (f2_arg0)
	local f2_local0 = CoD.Wiiu.CreateOptionMenu(f2_arg0, "WiiURemoteSensitivity", "PLATFORM_SENSITIVITY_CAPS")
	f2_local0:addSelectButton()
	f2_local0:addBackButton()
	f2_local0.close = CoD.Options.Close
	f2_local0.cameraSensitivitySlider = f0_local0(f2_local0, "cameraSensitivity")
	f2_local0.scopeSensitivitySlider = f0_local0(f2_local0, "scopeSensitivity")
	f2_local0.turretSensitivitySlider = f0_local0(f2_local0, "turretSensitivity")
	CoD.WiiUControllerSettings.SetAsRemoteOnlyMenu(f2_local0)
	f2_local0.cameraSensitivitySlider:processEvent({
		name = "gain_focus"
	})
	return f2_local0
end

