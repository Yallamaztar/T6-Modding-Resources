require("T6.ProfileDiscreteLeftRightSlider")
CoD.WiiURemoteCameraSpeed = {}
CoD.WiiURemoteCameraSpeed.ProfileVarInfo = {
	horizontalSpeed = {
		name = "wiiu_aim_turnrate_yaw",
		default = 120,
		min = 50,
		max = 450,
		label = Engine.Localize("PLATFORM_HORIZONTAL_SPEED_CAPS"),
		hint = Engine.Localize("PLATFORM_HORIZONTAL_SPEED_DESC")
	},
	verticalSpeed = {
		name = "wiiu_aim_turnrate_pitch",
		default = 29.5,
		min = 8,
		max = 180,
		label = Engine.Localize("PLATFORM_VERTICAL_SPEED_CAPS"),
		hint = Engine.Localize("PLATFORM_VERTICAL_SPEED_DESC")
	},
	horizontalSpeedAds = {
		name = "wiiu_aim_turnrate_yaw_ads",
		default = 63.25,
		min = 20,
		max = 250,
		label = Engine.Localize("PLATFORM_HORIZONTAL_SPEED_ADS_CAPS"),
		hint = Engine.Localize("PLATFORM_HORIZONTAL_SPEED_ADS_DESC")
	},
	verticalSpeedAds = {
		name = "wiiu_aim_turnrate_pitch_ads",
		default = 29.15,
		min = 8,
		max = 125,
		label = Engine.Localize("PLATFORM_VERTICAL_SPEED_ADS_CAPS"),
		hint = Engine.Localize("PLATFORM_VERTICAL_SPEED_ADS_DESC")
	}
}
local f0_local0 = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.WiiURemoteCameraSpeed.ProfileVarInfo[f1_arg1]
	return f1_arg0.buttonList:addProfileDiscreteLeftRightSlider(f1_arg0.controller, f1_local0.label, f1_local0.name, f1_local0.min, f1_local0.max, f1_local0.hint)
end

LUI.createMenu.WiiURemoteCameraSpeed = function (f2_arg0)
	local f2_local0 = CoD.Wiiu.CreateOptionMenu(f2_arg0, "WiiURemoteCameraSpeed", "PLATFORM_CAMERA_SPEED_CAPS")
	f2_local0:addSelectButton()
	f2_local0:addBackButton()
	f2_local0.close = CoD.Options.Close
	f2_local0.horizontalSpeedSlider = f0_local0(f2_local0, "horizontalSpeed")
	f2_local0.verticalSpeedSlider = f0_local0(f2_local0, "verticalSpeed")
	f2_local0.horizontalSpeedAdsSlider = f0_local0(f2_local0, "horizontalSpeedAds")
	f2_local0.verticalSpeedAdsSlider = f0_local0(f2_local0, "verticalSpeedAds")
	CoD.WiiUControllerSettings.SetAsRemoteOnlyMenu(f2_local0)
	f2_local0.horizontalSpeedSlider:processEvent({
		name = "gain_focus"
	})
	return f2_local0
end

