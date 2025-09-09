require("T6.WiiURemoteButtonLayout")
require("T6.WiiURemoteAimStyles")
require("T6.WiiURemoteCameraSpeed")
require("T6.WiiURemoteSensitivity")
require("T6.WiiURemoteDeadZones")
require("T6.WiiURemoteGesture")
require("T6.WiiURemoteControlPresets")
CoD.WiiUControllerSettings = {}
CoD.WiiUControllerSettings.WIIUMOTE_ALPHA = 0
CoD.WiiUControllerSettings.WIIUMOTE_BRAVO = 1
CoD.WiiUControllerSettings.WIIUMOTE_CHARLIE = 2
CoD.WiiUControllerSettings.WIIUMOTE_DELTA = 3
CoD.WiiUControllerSettings.WIIUMOTE_ECHO = 4
CoD.WiiUControllerSettings.WIIUMOTE_FOXTROT = 5
CoD.WiiUControllerSettings.WIIUMOTE_CUSTOM = 6
CoD.WiiUControllerSettings.CLASSIC_ROMEO = 7
CoD.WiiUControllerSettings.CLASSIC_SIERRA = 8
CoD.WiiUControllerSettings.CLASSIC_TANGO = 9
CoD.WiiUControllerSettings.CLASSIC_UNIFORM = 10
CoD.WiiUControllerSettings.CLASSIC_VICTOR = 11
CoD.WiiUControllerSettings.CLASSIC_WHISKEY = 12
CoD.WiiUControllerSettings.CLASSIC_ZERO = 13
CoD.WiiUControllerSettings.GAMEPAD_DEFAULT = 14
CoD.WiiUControllerSettings.GAMEPAD_EXPERIMENTAL = 15
CoD.WiiUControllerSettings.GAMEPAD_LEFTY = 16
CoD.WiiUControllerSettings.GAMEPAD_NOMAD = 17
CoD.WiiUControllerSettings.GAMEPAD_CHARLIE = 18
CoD.WiiUControllerSettings.GAMEPAD_DELTA = 19
CoD.WiiUControllerSettings.GAMEPAD_DEFAULT_XENON = 20
local f0_local0 = CoD.WiiUControllerSettings
local f0_local1 = {}
local f0_local2 = {}
local f0_local3 = {}
local f0_local4 = Engine.Localize("MENU_DEFAULT_CAPS")
local f0_local5 = Engine.Localize("MENU_TACTICAL_CAPS")
local f0_local6 = Engine.Localize("MENU_LEFTY_CAPS")
local f0_local7 = Engine.Localize("MENU_NOMAD")
local f0_local8 = Engine.Localize("MENU_CHARLIE_CAPS")
local f0_local9 = Engine.Localize("MENU_DELTA_CAPS")
local f0_local10 = Engine.Localize("MENU_DEFAULT_XENON_CAPS")
f0_local2.strings = f0_local4
f0_local2.values = {
	CoD.WiiUControllerSettings.GAMEPAD_DEFAULT,
	CoD.WiiUControllerSettings.GAMEPAD_EXPERIMENTAL,
	CoD.WiiUControllerSettings.GAMEPAD_LEFTY,
	CoD.WiiUControllerSettings.GAMEPAD_NOMAD,
	CoD.WiiUControllerSettings.GAMEPAD_CHARLIE,
	CoD.WiiUControllerSettings.GAMEPAD_DELTA,
	CoD.WiiUControllerSettings.GAMEPAD_DEFAULT_XENON
}
f0_local1.gamepad = f0_local2
f0_local2 = {}
f0_local3 = {}
f0_local4 = Engine.Localize("MENU_ALPHA_CAPS")
f0_local5 = Engine.Localize("MENU_BRAVO_CAPS")
f0_local6 = Engine.Localize("MENU_CHARLIE_CAPS")
f0_local7 = Engine.Localize("MENU_DELTA_CAPS")
f0_local8 = Engine.Localize("MENU_ECHO_CAPS")
f0_local9 = Engine.Localize("MENU_FOXTROT_CAPS")
f0_local10 = Engine.Localize("MENU_CUSTOMIZE_CAPS")
f0_local2.strings = f0_local4
f0_local2.values = {
	CoD.WiiUControllerSettings.WIIUMOTE_ALPHA,
	CoD.WiiUControllerSettings.WIIUMOTE_BRAVO,
	CoD.WiiUControllerSettings.WIIUMOTE_CHARLIE,
	CoD.WiiUControllerSettings.WIIUMOTE_DELTA,
	CoD.WiiUControllerSettings.WIIUMOTE_ECHO,
	CoD.WiiUControllerSettings.WIIUMOTE_FOXTROT,
	CoD.WiiUControllerSettings.WIIUMOTE_CUSTOM
}
f0_local1.remote = f0_local2
f0_local2 = {}
f0_local3 = {}
f0_local4 = Engine.Localize("MENU_ROMEO_CAPS")
f0_local5 = Engine.Localize("MENU_SIERRA_CAPS")
f0_local6 = Engine.Localize("MENU_TANGO_CAPS")
f0_local7 = Engine.Localize("MENU_UNIFORM_CAPS")
f0_local8 = Engine.Localize("MENU_VICTOR_CAPS")
f0_local9 = Engine.Localize("MENU_WHISKEY_CAPS")
f0_local10 = Engine.Localize("MENU_ZERO_CAPS")
f0_local2.strings = f0_local4
f0_local2.values = {
	CoD.WiiUControllerSettings.CLASSIC_ROMEO,
	CoD.WiiUControllerSettings.CLASSIC_SIERRA,
	CoD.WiiUControllerSettings.CLASSIC_TANGO,
	CoD.WiiUControllerSettings.CLASSIC_UNIFORM,
	CoD.WiiUControllerSettings.CLASSIC_VICTOR,
	CoD.WiiUControllerSettings.CLASSIC_WHISKEY,
	CoD.WiiUControllerSettings.CLASSIC_ZERO
}
f0_local1.classic = f0_local2
f0_local0.ButtonLayouts = f0_local1
CoD.WiiUControllerSettings.SavedPrevMenuName = {}
CoD.WiiUControllerSettings.ProfileVarInfo = {
	adsReach = {
		name = "wiiu_viewmodelTrackFactor_ADS",
		default = 0.75,
		min = 0,
		max = 1,
		label = Engine.Localize("PLATFORM_ADS_REACH_CAPS"),
		hint = Engine.Localize("PLATFORM_ADS_REACH_DESC")
	},
	viewSensitivity = {
		name = "input_viewSensitivity",
		default = 1,
		min = CoD.SENSITIVITY_1,
		max = CoD.SENSITIVITY_14,
		label = Engine.Localize("MENU_LOOK_SENSITIVITY_CAPS"),
		hint = Engine.Localize("PLATFORM_LOOK_SENSITIVITY_DESC")
	}
}
f0_local0 = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.WiiUControllerSettings.ProfileVarInfo[f1_arg1]
	return f1_arg0.buttonList:addProfileDiscreteLeftRightSlider(f1_arg0.controller, f1_local0.label, f1_local0.name, f1_local0.min, f1_local0.max, f1_local0.hint)
end

CoD.WiiUControllerSettings.OpenMenu = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	CoD.WiiUControllerSettings.SavedPrevMenuName[f2_arg2] = f2_arg0.previousMenuName
	local f2_local0 = CoD.Menu.openMenu(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	CoD.WiiUControllerSettings.SetAsControllerMenu(f2_local0, f2_arg0)
	return f2_local0
end

CoD.WiiUControllerSettings.Button_ButtonLayout = function (f3_arg0, f3_arg1)
	f3_arg0:dispatchEventToParent({
		name = "open_gamepad_button_layout",
		controller = f3_arg1.controller
	})
end

CoD.WiiUControllerSettings.OpenGamepadButtonLayout = function (f4_arg0, f4_arg1)
	f4_arg0:saveState()
	f4_arg0:openMenu("ButtonLayout", f4_arg1.controller)
	f4_arg0:close()
end

CoD.WiiUControllerSettings.Button_StickLayout = function (f5_arg0, f5_arg1)
	f5_arg0:dispatchEventToParent({
		name = "open_gamepad_stick_layout",
		controller = f5_arg1.controller
	})
end

CoD.WiiUControllerSettings.OpenGamepadStickLayout = function (f6_arg0, f6_arg1)
	f6_arg0:saveState()
	f6_arg0:openMenu("StickLayout", f6_arg1.controller)
	f6_arg0:close()
end

CoD.WiiUControllerSettings.Button_RemoteButtonLayout = function (f7_arg0, f7_arg1)
	f7_arg0:dispatchEventToParent({
		name = "open_remote_button_layout",
		controller = f7_arg1.controller
	})
end

CoD.WiiUControllerSettings.OpenRemoteButtonLayout = function (f8_arg0, f8_arg1)
	f8_arg0:saveState()
	f8_arg0:openMenu("WiiURemoteButtonLayout", f8_arg1.controller)
	f8_arg0:close()
end

CoD.WiiUControllerSettings.Button_AimStyles = function (f9_arg0, f9_arg1)
	f9_arg0:dispatchEventToParent({
		name = "open_aim_styles",
		controller = f9_arg1.controller
	})
end

CoD.WiiUControllerSettings.OpenAimStyles = function (f10_arg0, f10_arg1)
	f10_arg0:saveState()
	f10_arg0:openMenu("WiiURemoteAimStyles", f10_arg1.controller)
	f10_arg0:close()
end

CoD.WiiUControllerSettings.Button_SwitchControllers = function (f11_arg0, f11_arg1)
	f11_arg0:dispatchEventToParent({
		name = "open_switch_controllers_menu",
		controller = f11_arg1.controller
	})
end

CoD.WiiUControllerSettings.OpenSwitchControllersMenu = function (f12_arg0, f12_arg1)
	f12_arg0:openPopup("SwitchControllersMenu", f12_arg1.controller)
end

CoD.WiiUControllerSettings.Button_CameraSpeed = function (f13_arg0, f13_arg1)
	f13_arg0:dispatchEventToParent({
		name = "open_camera_speed",
		controller = f13_arg1.controller
	})
end

CoD.WiiUControllerSettings.OpenCameraSpeed = function (f14_arg0, f14_arg1)
	f14_arg0:saveState()
	f14_arg0:openMenu("WiiURemoteCameraSpeed", f14_arg1.controller)
	f14_arg0:close()
end

CoD.WiiUControllerSettings.Button_Sensitivity = function (f15_arg0, f15_arg1)
	f15_arg0:dispatchEventToParent({
		name = "open_sensitivity",
		controller = f15_arg1.controller
	})
end

CoD.WiiUControllerSettings.OpenSensitivity = function (f16_arg0, f16_arg1)
	f16_arg0:saveState()
	f16_arg0:openMenu("WiiURemoteSensitivity", f16_arg1.controller)
	f16_arg0:close()
end

CoD.WiiUControllerSettings.Button_DeadZones = function (f17_arg0, f17_arg1)
	f17_arg0:dispatchEventToParent({
		name = "open_dead_zones",
		controller = f17_arg1.controller
	})
end

CoD.WiiUControllerSettings.OpenDeadZones = function (f18_arg0, f18_arg1)
	f18_arg0:saveState()
	f18_arg0:openMenu("WiiURemoteDeadZones", f18_arg1.controller)
	f18_arg0:close()
end

CoD.WiiUControllerSettings.Button_Gesture = function (f19_arg0, f19_arg1)
	f19_arg0:dispatchEventToParent({
		name = "open_gesture",
		controller = f19_arg1.controller
	})
end

CoD.WiiUControllerSettings.OpenGesture = function (f20_arg0, f20_arg1)
	f20_arg0:saveState()
	f20_arg0:openMenu("WiiURemoteGesture", f20_arg1.controller)
	f20_arg0:close()
end

CoD.WiiUControllerSettings.Button_LoadControlPreset = function (f21_arg0, f21_arg1)
	f21_arg0:dispatchEventToParent({
		name = "open_control_presets",
		controller = f21_arg1.controller
	})
end

CoD.WiiUControllerSettings.OpenControlPresets = function (f22_arg0, f22_arg1)
	f22_arg0:saveState()
	f22_arg0:openMenu("WiiURemoteControlPresets", f22_arg1.controller)
	f22_arg0:close()
end

CoD.WiiUControllerSettings.Button_RestoreDefaultSettings = function (f23_arg0, f23_arg1)
	f23_arg0:dispatchEventToParent({
		name = "restore_last_control_preset",
		controller = f23_arg1.controller
	})
end

CoD.WiiUControllerSettings.RestoreLastControlPreset = function (f24_arg0, f24_arg1)
	local f24_local0 = CoD.WiiURemoteControlPresets.PresetInfo[UIExpression.ProfileString(controller, "lastControlPreset")]
	Engine.ExecNow(f24_arg1.controller, f24_local0.command)
	Engine.SetProfileVar(f24_arg1.controller, "wiiu_altWeaponPickup", 0)
	Engine.SetProfileVar(f24_arg1.controller, "wiiu_nunchuk_aiming_invert_pitch", 0)
	f24_arg0.adsReachSlider:refreshValue()
	f24_arg0.controlStickAimButton:refreshChoice()
	f24_arg0.weaponPickupButton:refreshChoice()
	f24_arg0.buttonList.hintText:updateText(f24_local0.restored)
	f24_arg0:saveState()
end

CoD.WiiUControllerSettings.RemoteOnlyMenu_ControllerChanged = function (f25_arg0, f25_arg1)
	if f25_arg0.controller == f25_arg1.controller and UIExpression.GetControllerType(f25_arg1.controller) ~= "remote" then
		f25_arg0:setPreviousMenu("WiiUControllerSettings")
		f25_arg0:goBack(f25_arg1.controller)
	end
end

CoD.WiiUControllerSettings.CloseOnControllerChanged = function (f26_arg0, f26_arg1)
	if f26_arg0.controller == f26_arg1.controller then
		f26_arg0:setPreviousMenu("WiiUControllerSettings")
		f26_arg0:goBack(f26_arg1.controller)
	end
end

CoD.WiiUControllerSettings.DrcControlsMenuOpened = function (f27_arg0, f27_arg1)
	f27_arg0:setPreviousMenu(f27_arg0.rootControlsMenu.previousMenuName)
	f27_arg0:goBack(f27_arg1.controller)
end

CoD.WiiUControllerSettings.SetAsRemoteOnlyMenu = function (f28_arg0)
	f28_arg0:registerEventHandler("controller_changed", CoD.WiiUControllerSettings.RemoteOnlyMenu_ControllerChanged)
end

CoD.WiiUControllerSettings.SetCloseIfControllerChanges = function (f29_arg0)
	f29_arg0:registerEventHandler("controller_changed", CoD.WiiUControllerSettings.CloseOnControllerChanged)
end

CoD.WiiUControllerSettings.SetAsControllerMenu = function (f30_arg0, f30_arg1)
	f30_arg0:registerEventHandler("drc_controls_menu_opened", CoD.WiiUControllerSettings.DrcControlsMenuOpened)
	f30_arg0.rootControlsMenu = f30_arg1
end

CoD.WiiUControllerSettings.InitForRemote = function (f31_arg0)
	local f31_local0 = UIExpression.IsDemoPlaying(f31_arg0.controller) ~= 0
	local f31_local1 = CoD.ButtonLayout.GetProfileVar(f31_arg0.controller)
	if not f31_local0 then
		f31_arg0.buttonLayoutButton = f31_arg0.buttonList:addProfileLeftRightSelector(f31_arg0.controller, Engine.Localize("MENU_BUTTON_LAYOUT_CAPS"), f31_local1, Engine.Localize("MENU_BUTTON_LAYOUT_DESC"))
		CoD.ButtonLayout.AddChoices(f31_arg0.buttonLayoutButton, f31_arg0.controller)
		f31_arg0.buttonLayoutButton:disableCycling()
		f31_arg0.buttonLayoutButton:registerEventHandler("button_action", CoD.WiiUControllerSettings.Button_RemoteButtonLayout)
	else
		f31_arg0.theaterButtonLayoutButton = f31_arg0.buttonList:addProfileLeftRightSelector(f31_arg0.controller, Engine.Localize("MENU_THEATER_BUTTON_LAYOUT_CAPS"), "demo_controllerconfig", Engine.Localize("MENU_THEATER_BUTTON_LAYOUT_DESC"))
		CoD.ButtonLayout.AddChoices(f31_arg0.theaterButtonLayoutButton, controller)
		f31_arg0.theaterButtonLayoutButton:disableCycling()
		f31_arg0.theaterButtonLayoutButton:registerEventHandler("button_action", CoD.WiiUControllerSettings.Button_RemoteButtonLayout)
	end
	f31_arg0.aimStylesButton = f31_arg0.buttonList:addButton(Engine.Localize("PLATFORM_AIM_STYLES_CAPS"), Engine.Localize("PLATFORM_AIM_STYLES_DESC"))
	f31_arg0.aimStylesButton:registerEventHandler("button_action", CoD.WiiUControllerSettings.Button_AimStyles)
	f31_arg0.cameraSpeedButton = f31_arg0.buttonList:addButton(Engine.Localize("PLATFORM_CAMERA_SPEED_CAPS"), Engine.Localize("PLATFORM_CAMERA_SPEED_DESC"))
	f31_arg0.cameraSpeedButton:registerEventHandler("button_action", CoD.WiiUControllerSettings.Button_CameraSpeed)
	f31_arg0.sensitivityButton = f31_arg0.buttonList:addButton(Engine.Localize("PLATFORM_SENSITIVITY_CAPS"), Engine.Localize("PLATFORM_SENSITIVITY_DESC"))
	f31_arg0.sensitivityButton:registerEventHandler("button_action", CoD.WiiUControllerSettings.Button_Sensitivity)
	f31_arg0.deadZonesButton = f31_arg0.buttonList:addButton(Engine.Localize("PLATFORM_DEAD_ZONES_CAPS"), Engine.Localize("PLATFORM_DEAD_ZONES_DESC"))
	f31_arg0.deadZonesButton:registerEventHandler("button_action", CoD.WiiUControllerSettings.Button_DeadZones)
	f31_arg0.gestureButton = f31_arg0.buttonList:addButton(Engine.Localize("PLATFORM_GESTURE_CAPS"), Engine.Localize("PLATFORM_GESTURE_DESC"))
	f31_arg0.gestureButton:registerEventHandler("button_action", CoD.WiiUControllerSettings.Button_Gesture)
	f31_arg0.adsReachSlider = f0_local0(f31_arg0, "adsReach")
	f31_arg0.controlStickAimButton = f31_arg0.buttonList:addProfileLeftRightSelector(f31_arg0.controller, Engine.Localize("PLATFORM_INVERT_CONTROL_STICK_AIM_CAPS"), "wiiu_nunchuk_aiming_invert_pitch", Engine.Localize("PLATFORM_INVERT_CONTROL_STICK_AIM_DESC"))
	CoD.Options.Button_AddChoices_EnabledOrDisabled(f31_arg0.controlStickAimButton)
	f31_arg0.weaponPickupButton = f31_arg0.buttonList:addProfileLeftRightSelector(f31_arg0.controller, Engine.Localize("PLATFORM_WEAPON_PICKUP_CAPS"), "wiiu_altWeaponPickup", Engine.Localize("PLATFORM_WEAPON_PICKUP_DESC"))
	local f31_local2 = f31_arg0.weaponPickupButton
	local f31_local3 = {}
	local f31_local4 = Engine.Localize("PLATFORM_SPRINT_BUTTON_CAPS")
	local f31_local5 = Engine.Localize("PLATFORM_INVENTORY_BUTTON_CAPS")
	f31_local2.strings = f31_local4
	f31_arg0.weaponPickupButton.values = {
		0,
		1
	}
	CoD.Options.Button_AddChoices(f31_arg0.weaponPickupButton)
	f31_arg0.loadControlPresetButton = f31_arg0.buttonList:addButton(Engine.Localize("PLATFORM_LOAD_CONTROL_PRESET_CAPS"), Engine.Localize("PLATFORM_LOAD_CONTROL_PRESET_DESC"))
	f31_arg0.loadControlPresetButton:registerEventHandler("button_action", CoD.WiiUControllerSettings.Button_LoadControlPreset)
	f31_arg0.restoreDefaultSettingsButton = f31_arg0.buttonList:addButton(Engine.Localize("PLATFORM_RESTORE_DEFAULT_SETTINGS_CAPS"), Engine.Localize("PLATFORM_RESTORE_LAST_CONTROL_PRESET_DESC"))
	f31_arg0.restoreDefaultSettingsButton:registerEventHandler("button_action", CoD.WiiUControllerSettings.Button_RestoreDefaultSettings)
	f31_arg0:registerEventHandler("open_remote_button_layout", CoD.WiiUControllerSettings.OpenRemoteButtonLayout)
	f31_arg0:registerEventHandler("open_aim_styles", CoD.WiiUControllerSettings.OpenAimStyles)
	f31_arg0:registerEventHandler("open_camera_speed", CoD.WiiUControllerSettings.OpenCameraSpeed)
	f31_arg0:registerEventHandler("open_sensitivity", CoD.WiiUControllerSettings.OpenSensitivity)
	f31_arg0:registerEventHandler("open_dead_zones", CoD.WiiUControllerSettings.OpenDeadZones)
	f31_arg0:registerEventHandler("open_gesture", CoD.WiiUControllerSettings.OpenGesture)
	f31_arg0:registerEventHandler("open_control_presets", CoD.WiiUControllerSettings.OpenControlPresets)
	f31_arg0:registerEventHandler("restore_last_control_preset", CoD.WiiUControllerSettings.RestoreLastControlPreset)
	if not f31_local0 then
		f31_arg0.buttonLayoutButton:processEvent({
			name = "gain_focus"
		})
	else
		f31_arg0.theaterButtonLayoutButton:processEvent({
			name = "gain_focus"
		})
	end
end

CoD.WiiUControllerSettings.InitForGamepad = function (f32_arg0)
	local f32_local0 = UIExpression.IsDemoPlaying(f32_arg0.controller) ~= 0
	f32_arg0.lookInversionButton = f32_arg0.buttonList:addProfileLeftRightSelector(f32_arg0.controller, Engine.Localize("MENU_LOOK_INVERSION_CAPS"), "input_invertpitch", Engine.Localize("MENU_LOOK_INVERSION_DESC"))
	CoD.Options.Button_AddChoices_EnabledOrDisabled(f32_arg0.lookInversionButton)
	local f32_local1 = CoD.ButtonLayout.GetProfileVar(f32_arg0.controller)
	if not f32_local0 then
		f32_arg0.stickLayoutButton = f32_arg0.buttonList:addProfileLeftRightSelector(f32_arg0.controller, Engine.Localize("PLATFORM_THUMBSTICK_LAYOUT_CAPS"), "gpad_sticksConfig", Engine.Localize("PLATFORM_THUMBSTICK_LAYOUT_DESC"))
		CoD.StickLayout.AddChoices(f32_arg0.stickLayoutButton)
		f32_arg0.stickLayoutButton:disableCycling()
		f32_arg0.stickLayoutButton:registerEventHandler("button_action", CoD.WiiUControllerSettings.Button_StickLayout)
		f32_arg0.buttonLayoutButton = f32_arg0.buttonList:addProfileLeftRightSelector(f32_arg0.controller, Engine.Localize("MENU_BUTTON_LAYOUT_CAPS"), f32_local1, Engine.Localize("MENU_BUTTON_LAYOUT_DESC"))
		CoD.ButtonLayout.AddChoices(f32_arg0.buttonLayoutButton, f32_arg0.controller)
		f32_arg0.buttonLayoutButton:disableCycling()
		f32_arg0.buttonLayoutButton:registerEventHandler("button_action", CoD.WiiUControllerSettings.Button_ButtonLayout)
	else
		f32_arg0.theaterButtonLayoutButton = f32_arg0.buttonList:addProfileLeftRightSelector(f32_arg0.controller, Engine.Localize("MENU_THEATER_BUTTON_LAYOUT_CAPS"), "demo_controllerconfig", Engine.Localize("MENU_THEATER_BUTTON_LAYOUT_DESC"))
		CoD.ButtonLayout.AddChoices(f32_arg0.theaterButtonLayoutButton, f32_arg0.controller)
		f32_arg0.theaterButtonLayoutButton:disableCycling()
		f32_arg0.theaterButtonLayoutButton:registerEventHandler("button_action", CoD.WiiUControllerSettings.Button_ButtonLayout)
	end
	f32_arg0.lookSensitivityButton = f0_local0(f32_arg0, "viewSensitivity")
	f32_arg0.precisionTurningButton = f32_arg0.buttonList:addProfileLeftRightSelector(f32_arg0.controller, Engine.Localize("PLATFORM_PRECISION_TURNING_CAPS"), "wiiu_aim_accel_turnrate_enabled", Engine.Localize("PLATFORM_PRECISION_TURNING_DESC"))
	CoD.Options.Button_AddChoices_EnabledOrDisabled(f32_arg0.precisionTurningButton)
	f32_arg0:registerEventHandler("open_gamepad_button_layout", CoD.WiiUControllerSettings.OpenGamepadButtonLayout)
	f32_arg0:registerEventHandler("open_gamepad_stick_layout", CoD.WiiUControllerSettings.OpenGamepadStickLayout)
	f32_arg0.lookInversionButton:processEvent({
		name = "gain_focus"
	})
end

CoD.WiiUControllerSettings.ControllerChanged = function (f33_arg0, f33_arg1)
	if f33_arg0.m_ownerController ~= f33_arg1.controller then
		return 
	end
	f33_arg0.buttonList:removeAllButtons()
	if UIExpression.GetControllerType(f33_arg1.controller) == "remote" then
		CoD.WiiUControllerSettings.InitForRemote(f33_arg0)
	else
		CoD.WiiUControllerSettings.InitForGamepad(f33_arg0)
	end
end

LUI.createMenu.WiiUControllerSettings = function (f34_arg0, f34_arg1)
	local f34_local0 = CoD.Wiiu.CreateOptionMenu(f34_arg0, "WiiUControllerSettings", "MENU_CONTROLLER_SETTINGS_CAPS", true)
	if f34_arg1 then
		CoD.WiiUControllerSettings.SavedPrevMenuName[f34_arg0] = nil
	end
	if CoD.WiiUControllerSettings.SavedPrevMenuName[f34_arg0] ~= nil then
		f34_local0:setPreviousMenu(CoD.WiiUControllerSettings.SavedPrevMenuName[f34_arg0])
	end
	CoD.WiiUControllerSettings.SetAsControllerMenu(f34_local0, f34_local0)
	f34_local0.openMenu = CoD.WiiUControllerSettings.OpenMenu
	f34_local0:addSelectButton()
	f34_local0:addBackButton()
	f34_local0.close = CoD.Options.Close
	f34_local0:registerEventHandler("open_stick_layout", CoD.Options.OpenStickLayout)
	f34_local0:registerEventHandler("open_button_layout", CoD.Options.OpenButtonLayout)
	f34_local0:registerEventHandler("controller_changed", CoD.WiiUControllerSettings.ControllerChanged)
	f34_local0:processEvent({
		name = "controller_changed",
		controller = f34_arg0
	})
	LUI.roots.UIRootDrc:processEvent({
		name = "onscreen_controls_menu_opened",
		controller = f34_arg0
	})
	return f34_local0
end

