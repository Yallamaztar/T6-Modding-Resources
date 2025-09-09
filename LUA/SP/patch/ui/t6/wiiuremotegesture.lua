CoD.WiiURemoteGesture = {}
CoD.WiiURemoteGesture.ProfileVarInfo = {
	wiiuRemoteSensitivity = {
		name = "acc_wiiumoteThreshold",
		default = 0.16,
		min = 0,
		max = 0.5,
		label = Engine.Localize("PLATFORM_WIIU_REMOTE_SENSITIVITY_CAPS"),
		hint = Engine.Localize("PLATFORM_WIIU_REMOTE_SENSITIVITY_DESC")
	},
	nunchukSensitivity = {
		name = "acc_nunchukThreshold",
		default = 0.24,
		min = 0,
		max = 0.5,
		label = Engine.Localize("PLATFORM_NUNCHUK_SENSITIVITY_CAPS"),
		hint = Engine.Localize("PLATFORM_NUNCHUK_SENSITIVITY_DESC")
	}
}
local f0_local0 = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.WiiURemoteGesture.ProfileVarInfo[f1_arg1]
	return f1_arg0.buttonList:addProfileDiscreteLeftRightSlider(f1_arg0.controller, f1_local0.label, f1_local0.name, f1_local0.min, f1_local0.max, f1_local0.hint)
end

LUI.createMenu.WiiURemoteGesture = function (f2_arg0)
	local f2_local0 = CoD.Wiiu.CreateOptionMenu(f2_arg0, "WiiURemoteDeadZones", "PLATFORM_GESTURE_CAPS")
	f2_local0:addSelectButton()
	f2_local0:addBackButton()
	f2_local0.close = CoD.Options.Close
	f2_local0.gestureButton = f2_local0.buttonList:addProfileLeftRightSelector(f2_arg0, Engine.Localize("PLATFORM_GESTURE_CAPS"), "wiiu_gesturesEnabled", Engine.Localize("PLATFORM_GESTURES_ALLOWED_DESC"))
	if UIExpression.ProfileBool(f2_arg0, "wiiu_mustUseGestures") > 0 then
		local f2_local1 = f2_local0.gestureButton
		local f2_local2 = {}
		f2_local1.strings = Engine.Localize("MENU_ENABLED_CAPS")
		f2_local0.gestureButton.values = {
			1
		}
		CoD.Options.Button_AddChoices(f2_local0.gestureButton)
		f2_local0.gestureButton.hintText = Engine.Localize("PLATFORM_GESTURES_FORCED_DESC")
		f2_local0.gestureButton:processEvent({
			name = "button_readonly"
		})
	else
		CoD.Options.Button_AddChoices_EnabledOrDisabled(f2_local0.gestureButton)
	end
	f2_local0.wiiuRemoteSensitivitySlider = f0_local0(f2_local0, "wiiuRemoteSensitivity")
	f2_local0.nunchukSensitivitySlider = f0_local0(f2_local0, "nunchukSensitivity")
	CoD.WiiUControllerSettings.SetAsRemoteOnlyMenu(f2_local0)
	f2_local0.gestureButton:processEvent({
		name = "gain_focus"
	})
	return f2_local0
end

