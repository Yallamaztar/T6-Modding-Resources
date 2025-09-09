require("T6.WiiUControllerSettings")
CoD.WiiURemoteDeadZones = {}
CoD.WiiURemoteDeadZones.ArrowMaterial = RegisterMaterial("menu_safearea_arrow")
CoD.WiiURemoteDeadZones.AdjustMin = 0
CoD.WiiURemoteDeadZones.AdjustMax = 40
CoD.WiiURemoteDeadZones.AdjustStep = 1
CoD.WiiURemoteDeadZones.ProfileVarInfo = {
	hipWidth = {
		name = "wiiu_aim_deadzone_width",
		default = 0.4,
		min = 0,
		max = 0.9,
		label = Engine.Localize("PLATFORM_DEAD_ZONE_WIDTH_CAPS"),
		hint = Engine.Localize("PLATFORM_DEAD_ZONE_WIDTH_DESC")
	},
	hipHeight = {
		name = "wiiu_aim_deadzone_height",
		default = 0.38,
		min = 0,
		max = 0.9,
		label = Engine.Localize("PLATFORM_DEAD_ZONE_HEIGHT_CAPS"),
		hint = Engine.Localize("PLATFORM_DEAD_ZONE_HEIGHT_DESC")
	},
	adsWidth = {
		name = "wiiu_aim_deadzone_width_ads",
		default = 0.4,
		min = 0,
		max = 0.9,
		label = Engine.Localize("PLATFORM_DEAD_ZONE_WIDTH_ADS_CAPS"),
		hint = Engine.Localize("PLATFORM_DEAD_ZONE_WIDTH_ADS_DESC")
	},
	adsHeight = {
		name = "wiiu_aim_deadzone_height_ads",
		default = 0.4,
		min = 0,
		max = 0.9,
		label = Engine.Localize("PLATFORM_DEAD_ZONE_HEIGHT_ADS_CAPS"),
		hint = Engine.Localize("PLATFORM_DEAD_ZONE_HEIGHT_ADS_DESC")
	}
}
CoD.WiiURemoteDeadZones.Button_HipDeadZone = function (f1_arg0, f1_arg1)
	f1_arg0:dispatchEventToParent({
		name = "open_hip_dead_zone",
		controller = f1_arg1.controller
	})
end

CoD.WiiURemoteDeadZones.OpenHipDeadZone = function (f2_arg0, f2_arg1)
	f2_arg0:saveState()
	CoD.WiiUControllerSettings.SetAsControllerMenu(f2_arg0:openMenu("WiiURemoteHipDeadZone", f2_arg1.controller), f2_arg0.rootControlsMenu)
	f2_arg0:close()
end

CoD.WiiURemoteDeadZones.Button_ADSDeadZone = function (f3_arg0, f3_arg1)
	f3_arg0:dispatchEventToParent({
		name = "open_ads_dead_zone",
		controller = f3_arg1.controller
	})
end

CoD.WiiURemoteDeadZones.OpenADSDeadZone = function (f4_arg0, f4_arg1)
	f4_arg0:saveState()
	CoD.WiiUControllerSettings.SetAsControllerMenu(f4_arg0:openMenu("WiiURemoteADSDeadZone", f4_arg1.controller), f4_arg0.rootControlsMenu)
	f4_arg0:close()
end

CoD.WiiURemoteDeadZones.HandleGamepadButton = function (f5_arg0, f5_arg1)
	if LUI.UIElement.handleGamepadButton(f5_arg0, f5_arg1) == true then
		return true
	elseif f5_arg1.down == true and f5_arg1.button == "secondary" then
		f5_arg0:dispatchEventToParent({
			name = "button_prompt_back",
			controller = f5_arg1.controller
		})
		return true
	else

	end
end

local f0_local0 = function (f6_arg0, f6_arg1)
	return math.ceil(CoD.WiiURemoteDeadZones.AdjustMin + (LUI.clamp(UIExpression.ProfileFloat(f6_arg0, f6_arg1.name), f6_arg1.min, f6_arg1.max) - f6_arg1.min) / (f6_arg1.max - f6_arg1.min) * (CoD.WiiURemoteDeadZones.AdjustMax - CoD.WiiURemoteDeadZones.AdjustMin) - 0.5)
end

local f0_local1 = function (f7_arg0, f7_arg1, f7_arg2)
	Engine.SetProfileVar(f7_arg0, f7_arg2.name, LUI.clamp(f7_arg2.min + (LUI.clamp(f7_arg1, CoD.WiiURemoteDeadZones.AdjustMin, CoD.WiiURemoteDeadZones.AdjustMax) - CoD.WiiURemoteDeadZones.AdjustMin) / (CoD.WiiURemoteDeadZones.AdjustMax - CoD.WiiURemoteDeadZones.AdjustMin) * (f7_arg2.max - f7_arg2.min), f7_arg2.min, f7_arg2.max))
end

CoD.WiiURemoteDeadZones.DeadZone_Move = function (f8_arg0, f8_arg1)
	if f8_arg1.name == "deadzone_move_up" then
		f8_arg0.heightValue = LUI.clamp(f8_arg0.heightValue + CoD.WiiURemoteDeadZones.AdjustStep, CoD.WiiURemoteDeadZones.AdjustMin, CoD.WiiURemoteDeadZones.AdjustMax)
	elseif f8_arg1.name == "deadzone_move_down" then
		f8_arg0.heightValue = LUI.clamp(f8_arg0.heightValue - CoD.WiiURemoteDeadZones.AdjustStep, CoD.WiiURemoteDeadZones.AdjustMin, CoD.WiiURemoteDeadZones.AdjustMax)
	elseif f8_arg1.name == "deadzone_move_left" then
		f8_arg0.widthValue = LUI.clamp(f8_arg0.widthValue - CoD.WiiURemoteDeadZones.AdjustStep, CoD.WiiURemoteDeadZones.AdjustMin, CoD.WiiURemoteDeadZones.AdjustMax)
	elseif f8_arg1.name == "deadzone_move_right" then
		f8_arg0.widthValue = LUI.clamp(f8_arg0.widthValue + CoD.WiiURemoteDeadZones.AdjustStep, CoD.WiiURemoteDeadZones.AdjustMin, CoD.WiiURemoteDeadZones.AdjustMax)
	end
	f8_arg0:dispatchEventToRoot({
		name = "update_dead_zone",
		controller = f8_arg1.controller
	})
end

local f0_local2 = function (f9_arg0)
	return math.ceil(LUI.clamp(UIExpression.ProfileFloat(f9_arg0.controller, f9_arg0.widthVar.name), f9_arg0.widthVar.min, f9_arg0.widthVar.max) * 1280 - 0.5), math.ceil(LUI.clamp(UIExpression.ProfileFloat(f9_arg0.controller, f9_arg0.heightVar.name), f9_arg0.heightVar.min, f9_arg0.heightVar.max) * 720 - 0.5)
end

local f0_local3 = function (f10_arg0)
	local f10_local0, f10_local1 = f0_local2(f10_arg0)
	f10_arg0.backgroundContainer:setLeftRight(false, false, -f10_local0 / 2, f10_local0 / 2)
	f10_arg0.backgroundContainer:setTopBottom(false, false, -f10_local1 / 2, f10_local1 / 2)
end

CoD.WiiURemoteDeadZones.DeadZone_ConfigureForHip = function (f11_arg0, f11_arg1)
	f11_arg0.widthVar = CoD.WiiURemoteDeadZones.ProfileVarInfo.hipWidth
	f11_arg0.heightVar = CoD.WiiURemoteDeadZones.ProfileVarInfo.hipHeight
	f11_arg0.widthValue = f0_local0(f11_arg0.controller, f11_arg0.widthVar)
	f11_arg0.heightValue = f0_local0(f11_arg0.controller, f11_arg0.heightVar)
	f11_arg0.helpTextLabel:setText(Engine.Localize("PLATFORM_HIP_DEAD_ZONE_HELP"))
	f0_local3(f11_arg0)
	f11_arg0:animateToState("show")
end

CoD.WiiURemoteDeadZones.DeadZone_ConfigureForADS = function (f12_arg0, f12_arg1)
	f12_arg0.widthVar = CoD.WiiURemoteDeadZones.ProfileVarInfo.adsWidth
	f12_arg0.heightVar = CoD.WiiURemoteDeadZones.ProfileVarInfo.adsHeight
	f12_arg0.widthValue = f0_local0(f12_arg0.controller, f12_arg0.widthVar)
	f12_arg0.heightValue = f0_local0(f12_arg0.controller, f12_arg0.heightVar)
	f12_arg0.helpTextLabel:setText(Engine.Localize("PLATFORM_ADS_DEAD_ZONE_HELP"))
	f0_local3(f12_arg0)
	f12_arg0:animateToState("show")
end

CoD.WiiURemoteDeadZones.DeadZone_CloseFromDrc = function (f13_arg0, f13_arg1)
	f13_arg0:close()
end

CoD.WiiURemoteDeadZones.DeadZone_HideFromDrc = function (f14_arg0, f14_arg1)
	f14_arg0:animateToState("hide")
end

CoD.WiiURemoteDeadZones.DeadZone_RefreshFromDrc = function (f15_arg0, f15_arg1)
	if f15_arg0.widthVar ~= nil and f15_arg0.heightVar ~= nil then
		f0_local3(f15_arg0)
	end
end

CoD.WiiURemoteDeadZones.UpdateDeadZone = function (f16_arg0, f16_arg1)
	f0_local1(f16_arg0.controller, f16_arg0.widthValue, f16_arg0.widthVar)
	f0_local1(f16_arg0.controller, f16_arg0.heightValue, f16_arg0.heightVar)
	f0_local3(f16_arg0)
end

CoD.WiiURemoteDeadZones.CreateDeadzoneMenu = function (f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = nil
	if UIExpression.IsInGame() == 1 then
		f17_local0 = CoD.InGameMenu.New(f17_arg0, f17_arg1, "", CoD.isSinglePlayer)
	else
		f17_local0 = CoD.Menu.New(f17_arg0)
	end
	f17_local0.controller = f17_arg1
	f17_local0.close = CoD.Options.Close
	f17_local0:registerEventHandler("update_dead_zone", CoD.WiiURemoteDeadZones.UpdateDeadZone)
	f17_local0.backgroundContainer = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = 0,
		bottom = 0
	})
	f17_local0:addElement(f17_local0.backgroundContainer)
	f17_local0.backgroundImage = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		red = 0.3,
		green = 0.3,
		blue = 0.3,
		alpha = 0.5
	})
	f17_local0.backgroundContainer:addElement(f17_local0.backgroundImage)
	local f17_local1 = 64
	f17_local0.backgroundContainer:addElement(LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f17_local1,
		topAnchor = false,
		bottomAnchor = false,
		top = -(f17_local1 / 2),
		bottom = f17_local1 / 2,
		material = CoD.WiiURemoteDeadZones.ArrowMaterial,
		zRot = 0
	}))
	f17_local0.backgroundContainer:addElement(LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -(f17_local1 / 2),
		right = f17_local1 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = f17_local1,
		material = CoD.WiiURemoteDeadZones.ArrowMaterial,
		zRot = 270
	}))
	f17_local0.backgroundContainer:addElement(LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = true,
		left = -f17_local1,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -(f17_local1 / 2),
		bottom = f17_local1 / 2,
		material = CoD.WiiURemoteDeadZones.ArrowMaterial,
		zRot = 180
	}))
	f17_local0.backgroundContainer:addElement(LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -(f17_local1 / 2),
		right = f17_local1 / 2,
		topAnchor = false,
		bottomAnchor = true,
		top = -f17_local1,
		bottom = 0,
		material = CoD.WiiURemoteDeadZones.ArrowMaterial,
		zRot = 90
	}))
	local f17_local2 = 800
	local f17_local3 = -CoD.textSize.Default
	local f17_local4 = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f17_local2 / 2,
		right = f17_local2 / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = f17_local3,
		bottom = f17_local3 + CoD.textSize.Default,
		font = CoD.fonts.Default
	})
	f17_local4:setAlignment(LUI.Alignment.Center)
	f17_local0.helpTextLabel = f17_local4
	f17_local0:addElement(f17_local4)
	f17_local3 = f17_local3 + CoD.textSize.Default * 3
	if f17_arg2 then
		local f17_local5 = LUI.UIText.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -f17_local2 / 2,
			right = f17_local2 / 2,
			topAnchor = false,
			bottomAnchor = false,
			top = f17_local3,
			bottom = f17_local3 + CoD.textSize.Default,
			font = CoD.fonts.Default
		})
		f17_local5:setText(Engine.Localize("PLATFORM_SAFE_AREA_ADJUST_HORIZONTAL"))
		f17_local0:addElement(f17_local5)
		f17_local3 = f17_local3 + CoD.textSize.Default
		local f17_local6 = LUI.UIText.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -f17_local2 / 2,
			right = f17_local2 / 2,
			topAnchor = false,
			bottomAnchor = false,
			top = f17_local3,
			bottom = f17_local3 + CoD.textSize.Default,
			font = CoD.fonts.Default
		})
		f17_local6:setText(Engine.Localize("PLATFORM_SAFE_AREA_ADJUST_VERTICAL"))
		f17_local0:addElement(f17_local6)
		f17_local0.button = LUI.UIButton.new({
			leftAnchor = false,
			rightAnchor = false,
			left = 0,
			right = 0,
			topAnchor = false,
			bottomAnchor = false,
			top = 0,
			bottom = 0,
			alpha = 0
		})
		f17_local0.button.handleGamepadButton = CoD.WiiURemoteDeadZones.HandleGamepadButton
		f17_local0:addElement(f17_local0.button)
		f17_local0.button:processEvent({
			name = "gain_focus"
		})
		f17_local0.buttonRepeaterUp = LUI.UIButtonRepeater.new("up", "deadzone_move_up")
		f17_local0:addElement(f17_local0.buttonRepeaterUp)
		f17_local0.buttonRepeaterDown = LUI.UIButtonRepeater.new("down", "deadzone_move_down")
		f17_local0:addElement(f17_local0.buttonRepeaterDown)
		f17_local0.buttonRepeaterLeft = LUI.UIButtonRepeater.new("left", "deadzone_move_left")
		f17_local0:addElement(f17_local0.buttonRepeaterLeft)
		f17_local0.buttonRepeaterRight = LUI.UIButtonRepeater.new("right", "deadzone_move_right")
		f17_local0:addElement(f17_local0.buttonRepeaterRight)
		f17_local0:registerEventHandler("deadzone_move_up", CoD.WiiURemoteDeadZones.DeadZone_Move)
		f17_local0:registerEventHandler("deadzone_move_down", CoD.WiiURemoteDeadZones.DeadZone_Move)
		f17_local0:registerEventHandler("deadzone_move_left", CoD.WiiURemoteDeadZones.DeadZone_Move)
		f17_local0:registerEventHandler("deadzone_move_right", CoD.WiiURemoteDeadZones.DeadZone_Move)
	end
	f17_local0:registerEventHandler("configure_dead_zone_menu_for_hip", CoD.WiiURemoteDeadZones.DeadZone_ConfigureForHip)
	f17_local0:registerEventHandler("configure_dead_zone_menu_for_ads", CoD.WiiURemoteDeadZones.DeadZone_ConfigureForADS)
	f17_local0:registerEventHandler("close_dead_zone_from_drc", CoD.WiiURemoteDeadZones.DeadZone_CloseFromDrc)
	f17_local0:registerEventHandler("hide_dead_zone_from_drc", CoD.WiiURemoteDeadZones.DeadZone_HideFromDrc)
	f17_local0:registerEventHandler("drc_controls_menu_closed", CoD.WiiURemoteDeadZones.DeadZone_CloseFromDrc)
	f17_local0:registerEventHandler("refresh_dead_zone_from_drc", CoD.WiiURemoteDeadZones.DeadZone_RefreshFromDrc)
	f17_local0:registerAnimationState("hide", {
		alphaMultiplier = 0
	})
	f17_local0:registerAnimationState("show", {
		alphaMultiplier = 1
	})
	f17_local0:animateToState("hide")
	CoD.WiiUControllerSettings.SetAsRemoteOnlyMenu(f17_local0)
	return f17_local0
end

LUI.createMenu.WiiURemoteHipDeadZone = function (f18_arg0)
	local f18_local0 = CoD.WiiURemoteDeadZones.CreateDeadzoneMenu("WiiURemoteHipDeadZone", f18_arg0, true)
	f18_local0:processEvent({
		name = "configure_dead_zone_menu_for_hip"
	})
	return f18_local0
end

LUI.createMenu.WiiURemoteADSDeadZone = function (f19_arg0)
	local f19_local0 = CoD.WiiURemoteDeadZones.CreateDeadzoneMenu("WiiURemoteADSDeadZone", f19_arg0, true)
	f19_local0:processEvent({
		name = "configure_dead_zone_menu_for_ads"
	})
	return f19_local0
end

LUI.createMenu.WiiURemoteDeadZoneFromDrc = function (f20_arg0)
	return CoD.WiiURemoteDeadZones.CreateDeadzoneMenu("WiiURemoteDeadZoneFromDrc", f20_arg0, false)
end

LUI.createMenu.WiiURemoteDeadZones = function (f21_arg0)
	local f21_local0 = CoD.Wiiu.CreateOptionMenu(f21_arg0, "WiiURemoteDeadZones", "PLATFORM_DEAD_ZONES_CAPS")
	f21_local0:setPreviousMenu("WiiUControllerSettings")
	f21_local0:addSelectButton()
	f21_local0:addBackButton()
	f21_local0.close = CoD.Options.Close
	f21_local0.hipDeadZoneButton = f21_local0.buttonList:addButton(Engine.Localize("PLATFORM_HIP_DEAD_ZONE_CAPS"), Engine.Localize("PLATFORM_HIP_DEAD_ZONE_DESC"))
	f21_local0.hipDeadZoneButton:registerEventHandler("button_action", CoD.WiiURemoteDeadZones.Button_HipDeadZone)
	f21_local0.adsDeadZoneButton = f21_local0.buttonList:addButton(Engine.Localize("PLATFORM_ADS_DEAD_ZONE_CAPS"), Engine.Localize("PLATFORM_ADS_DEAD_ZONE_DESC"))
	f21_local0.adsDeadZoneButton:registerEventHandler("button_action", CoD.WiiURemoteDeadZones.Button_ADSDeadZone)
	CoD.WiiUControllerSettings.SetAsRemoteOnlyMenu(f21_local0)
	f21_local0:registerEventHandler("open_hip_dead_zone", CoD.WiiURemoteDeadZones.OpenHipDeadZone)
	f21_local0:registerEventHandler("open_ads_dead_zone", CoD.WiiURemoteDeadZones.OpenADSDeadZone)
	CoD.WiiUControllerSettings.SetAsRemoteOnlyMenu(f21_local0)
	f21_local0.hipDeadZoneButton:processEvent({
		name = "gain_focus"
	})
	return f21_local0
end

