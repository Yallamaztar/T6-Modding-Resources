require("T6.Drc.DrcExpandableButton")
require("T6.Drc.DrcDiscreteLeftRightSlider")
require("T6.Drc.DrcRadioButtonList")
require("T6.TouchpadVerticalList")
require("T6.WiiURemoteCameraSpeed")
require("T6.WiiURemoteSensitivity")
require("T6.WiiURemoteDeadZones")
require("T6.WiiURemoteControlPresets")
CoD.DrcControlsPanel = {}
CoD.DrcControlsPanel.CollapsedWidth = 275
CoD.DrcControlsPanel.ExpandedWidth = 1030
CoD.DrcControlsPanel.GamepadProfileVarInfo = {
	viewSensitivity = {
		name = "input_viewSensitivity",
		default = 1,
		min = CoD.SENSITIVITY_1,
		max = CoD.SENSITIVITY_14,
		label = Engine.Localize("MENU_LOOK_SENSITIVITY_CAPS"),
		hint = Engine.Localize("PLATFORM_LOOK_SENSITIVITY_DESC")
	},
	invertPitch = {
		name = "input_invertpitch",
		default = false,
		label = Engine.Localize("MENU_LOOK_INVERSION_CAPS"),
		hint = Engine.Localize("MENU_LOOK_INVERSION_DESC")
	},
	precisionTurning = {
		name = "wiiu_aim_accel_turnrate_enabled",
		default = true,
		label = Engine.Localize("PLATFORM_PRECISION_TURNING_CAPS"),
		hint = Engine.Localize("PLATFORM_PRECISION_TURNING_DESC")
	}
}
local f0_local0 = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = f1_arg2[f1_arg3]
	return f1_arg0:addProfileDiscreteLeftRightSlider(f1_arg0.controller, f1_local0.label, f1_local0.name, f1_local0.min, f1_local0.max, f1_local0.hint)
end

local f0_local1 = function (f2_arg0, f2_arg1)
	CoD.DrcProfileDiscreteLeftRightSlider.SliderCallback(f2_arg0, f2_arg1)
	LUI.roots["UIRoot" .. f2_arg0.m_currentController]:processEvent({
		name = "refresh_dead_zone_from_drc"
	})
end

local f0_local2 = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4)
	local f3_local0 = f0_local0(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	if f3_arg4 then
		f3_local0:registerEventHandler("gain_focus", CoD.DrcControlsPanel.DeadZoneADSSliderGainFocus)
	else
		f3_local0:registerEventHandler("gain_focus", CoD.DrcControlsPanel.DeadZoneHipSliderGainFocus)
	end
	f3_local0:registerEventHandler("lose_focus", CoD.DrcControlsPanel.DeadZoneSliderLoseFocus)
	f3_local0:setSliderCallback(f0_local1)
end

local f0_local3 = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	local f4_local0 = f4_arg2[f4_arg3]
	return f4_arg0:addProfileToggle(f4_arg0.controller, f4_local0.label, f4_local0.name, f4_local0.hint)
end

local f0_local4 = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = f5_arg1[f5_arg2]
	f5_arg0:addButton(f5_arg2, f5_local0.label, f5_local0.hint)
end

CoD.DrcControlsPanel.AnimatedClose = function (f6_arg0, f6_arg1)
	if not f6_arg0.closing then
		f6_arg0.closing = true
		f6_arg0:beginAnimation("animated_close", CoD.DrcView.PanelCollapseExpandSpeed)
		f6_arg0:setLeftRight(true, false, 0, 0)
		f6_arg0:setTopBottom(true, true, 0, 0)
	end
end

CoD.DrcControlsPanel.Close = function (f7_arg0)
	LUI.roots["UIRoot" .. f7_arg0.controller]:processEvent({
		name = "drc_controls_menu_closed",
		controller = f7_arg0.controller
	})
end

CoD.DrcControlsPanel.TouchpadDown = function (f8_arg0, f8_arg1)
	local f8_local0, f8_local1 = ProjectRootCoordinate(f8_arg1.rootName, f8_arg1.x, f8_arg1.y)
	local f8_local2 = f8_arg0.buttonList.list:getFirstChild()
	while f8_local2 ~= nil do
		if f8_local2.expanded then
			local f8_local3 = f8_local2.verticalList:getFirstChild()
			while f8_local3 ~= nil do
				local f8_local4, f8_local5, f8_local6, f8_local7 = f8_local3:getRect()
				if f8_local4 <= f8_local0 and f8_local0 <= f8_local6 and f8_local1 <= f8_local7 and f8_local5 <= f8_local1 and f8_local3.m_focusable and not f8_local3:isInFocus() then
					if f8_arg0.currentSelection ~= nil then
						f8_arg0.currentSelection:processEvent({
							name = "lose_focus",
							controller = f8_arg1.controller
						})
					end
					f8_local3:processEvent({
						name = "gain_focus",
						controller = f8_arg1.controller
					})
					f8_arg0.currentSelection = f8_local3
				end
				f8_local3 = f8_local3:getNextSibling()
			end
		end
		f8_local2 = f8_local2:getNextSibling()
	end
	LUI.UIElement.MouseButtonEvent(f8_arg0, f8_arg1)
end

CoD.DrcControlsPanel.ButtonCollapsed = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg1.button.verticalList:getFirstChild()
	while f9_local0 ~= nil do
		if f9_arg0.currentSelection == f9_local0 then
			f9_arg0.currentSelection:processEvent({
				name = "lose_focus",
				controller = f9_arg1.controller
			})
			f9_arg0.currentSelection = nil
		end
		f9_local0 = f9_local0:getNextSibling()
	end
end

CoD.DrcControlsPanel.PresetRadioButtonAction = function (f10_arg0, f10_arg1)
	if f10_arg0.controlsPanel.currentSelection ~= nil then
		f10_arg0.controlsPanel.currentSelection:processEvent({
			name = "lose_focus",
			controller = f10_arg0.controlsPanel.controller
		})
		f10_arg0.controlsPanel.currentSelection = nil
	end
	CoD.DrcRadioButtonList.RadioButtonActionEventHandler(f10_arg0, f10_arg1)
end

CoD.DrcControlsPanel.PresetRadioButtonItemSelected = function (f11_arg0, f11_arg1)
	Engine.ExecNow(f11_arg1.controller, CoD.WiiURemoteControlPresets.PresetInfo[f11_arg1.id].command)
	f11_arg0.controlsPanel:processEvent({
		name = "refresh",
		controller = f11_arg1.controller
	})
end

CoD.DrcControlsPanel.DeadZoneHipSliderGainFocus = function (f12_arg0, f12_arg1)
	CoD.DrcDiscreteLeftRightSlider.GainFocus(f12_arg0, f12_arg1)
	LUI.roots["UIRoot" .. f12_arg0.m_currentController]:processEvent({
		name = "configure_dead_zone_menu_for_hip"
	})
end

CoD.DrcControlsPanel.DeadZoneADSSliderGainFocus = function (f13_arg0, f13_arg1)
	CoD.DrcDiscreteLeftRightSlider.GainFocus(f13_arg0, f13_arg1)
	LUI.roots["UIRoot" .. f13_arg0.m_currentController]:processEvent({
		name = "configure_dead_zone_menu_for_ads",
		immediate = true
	})
end

CoD.DrcControlsPanel.DeadZoneSliderLoseFocus = function (f14_arg0, f14_arg1)
	CoD.DrcDiscreteLeftRightSlider.LoseFocus(f14_arg0, f14_arg1)
	LUI.roots["UIRoot" .. f14_arg0.m_currentController]:processEvent({
		name = "hide_dead_zone_from_drc",
		immediate = true
	})
end

CoD.DrcControlsPanel.DeadZonesExpand = function (f15_arg0, f15_arg1)
	CoD.DrcExpandableButton.Expand(f15_arg0, f15_arg1)
	LUI.roots["UIRoot" .. f15_arg0.controller]:processEvent({
		name = "open_dead_zone_from_drc"
	})
end

CoD.DrcControlsPanel.DeadZonesCollapse = function (f16_arg0, f16_arg1)
	CoD.DrcExpandableButton.Collapse(f16_arg0, f16_arg1)
	LUI.roots["UIRoot" .. f16_arg0.controller]:processEvent({
		name = "close_dead_zone_from_drc"
	})
end

CoD.DrcControlsPanel.InitForRemote = function (f17_arg0)
	local f17_local0 = LUI.UIText.new()
	f17_local0:setLeftRight(true, false, 0, 0)
	f17_local0:setTopBottom(true, false, 0, 2.5 * CoD.textSize.Condensed)
	f17_local0:setText(Engine.Localize("MENU_CONTROLLER_SETTINGS_CAPS"))
	f17_arg0.buttonList:addElement(f17_local0)
	local f17_local1 = CoD.DrcExpandableButton.new(f17_arg0, f17_arg0.controller, Engine.Localize("PLATFORM_CONTROL_PRESETS_CAPS"))
	local f17_local2 = CoD.WiiURemoteControlPresets.PresetInfo
	local f17_local3 = f17_local1:addRadioButtonList(f17_arg0.controller)
	f17_local3.controlsPanel = f17_arg0
	local f17_local4 = {
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		left = 0,
		right = 0,
		top = 0,
		bottom = 0
	}
	f0_local4(f17_local3, f17_local2, "greenhorn")
	f0_local4(f17_local3, f17_local2, "intermediate")
	f0_local4(f17_local3, f17_local2, "advanced")
	f0_local4(f17_local3, f17_local2, "professional")
	f0_local4(f17_local3, f17_local2, "insane")
	f17_local3:registerEventHandler("radio_button_item_selected", CoD.DrcControlsPanel.PresetRadioButtonItemSelected)
	f17_local3:registerEventHandler(CoD.DrcRadioButtonList.RadioButtonActionEvent, CoD.DrcControlsPanel.PresetRadioButtonAction)
	f17_arg0.buttonList:addElement(f17_local1)
	local f17_local5 = UIExpression.ProfileString(f17_arg0.controller, "lastControlPreset")
	if f17_local5:len() == 0 then
		f17_local5 = "greenhorn"
	end
	f17_local3:selectButton(f17_local5)
	local f17_local6 = CoD.DrcExpandableButton.new(f17_arg0, f17_arg0.controller, Engine.Localize("PLATFORM_CAMERA_SPEED_CAPS"))
	local f17_local7 = CoD.WiiURemoteCameraSpeed.ProfileVarInfo
	f17_local6.horizontalSpeedSlider = f0_local0(f17_local6, f17_arg0.parentView, f17_local7, "horizontalSpeed")
	f17_local6.verticalSpeedSlider = f0_local0(f17_local6, f17_arg0.parentView, f17_local7, "verticalSpeed")
	f17_local6.horizontalSpeedAdsSlider = f0_local0(f17_local6, f17_arg0.parentView, f17_local7, "horizontalSpeedAds")
	f17_local6.verticalSpeedAdsSlider = f0_local0(f17_local6, f17_arg0.parentView, f17_local7, "verticalSpeedAds")
	f17_arg0.buttonList:addElement(f17_local6)
	local f17_local8 = CoD.DrcExpandableButton.new(f17_arg0, f17_arg0.controller, Engine.Localize("PLATFORM_SENSITIVITY_CAPS"))
	local f17_local9 = CoD.WiiURemoteSensitivity.ProfileVarInfo
	f17_local8.cameraSensitivitySlider = f0_local0(f17_local8, f17_arg0.parentView, f17_local9, "cameraSensitivity")
	f17_local8.scopeSensitivitySlider = f0_local0(f17_local8, f17_arg0.parentView, f17_local9, "scopeSensitivity")
	f17_local8.turretSensitivitySlider = f0_local0(f17_local8, f17_arg0.parentView, f17_local9, "turretSensitivity")
	f17_arg0.buttonList:addElement(f17_local8)
	local f17_local10 = CoD.DrcExpandableButton.new(f17_arg0, f17_arg0.controller, Engine.Localize("PLATFORM_DEAD_ZONES_CAPS"))
	local f17_local11 = CoD.WiiURemoteDeadZones.ProfileVarInfo
	f17_local10.hipWidthSlider = f0_local2(f17_local10, f17_arg0.parentView, f17_local11, "hipWidth", false)
	f17_local10.hipHeightSlider = f0_local2(f17_local10, f17_arg0.parentView, f17_local11, "hipHeight", false)
	f17_local10.adsWidthSlider = f0_local2(f17_local10, f17_arg0.parentView, f17_local11, "adsWidth", true)
	f17_local10.adsHeightSlider = f0_local2(f17_local10, f17_arg0.parentView, f17_local11, "adsHeight", true)
	f17_arg0.buttonList:addElement(f17_local10)
	f17_local10:registerEventHandler("expand", CoD.DrcControlsPanel.DeadZonesExpand)
	f17_local10:registerEventHandler("collapse", CoD.DrcControlsPanel.DeadZonesCollapse)
	f17_local10:registerEventHandler("collapse_drc_dead_zones_button", CoD.DrcControlsPanel.DeadZonesCollapse)
	f17_local1:processEvent({
		name = "expand",
		controller = f17_arg0.controller
	})
end

CoD.DrcControlsPanel.InitForGamepad = function (f18_arg0)
	local f18_local0 = LUI.UIText.new()
	f18_local0:setLeftRight(true, false, 0, 0)
	f18_local0:setTopBottom(true, false, 0, 2.5 * CoD.textSize.Condensed)
	f18_local0:setText(Engine.Localize("MENU_CONTROLLER_SETTINGS_CAPS"))
	f18_arg0.buttonList:addElement(f18_local0)
	local f18_local1 = CoD.DrcExpandableButton.new(f18_arg0, f18_arg0.controller, Engine.Localize("MENU_OPTIONS_CAPS"))
	local f18_local2 = CoD.DrcControlsPanel.GamepadProfileVarInfo
	f18_local1.viewSensitivitySlider = f0_local0(f18_local1, f18_arg0.parentView, f18_local2, "viewSensitivity")
	f18_local1.lookInversionToggle = f0_local3(f18_local1, f18_arg0.parentView, f18_local2, "invertPitch")
	f18_local1.precisionTurningToggle = f0_local3(f18_local1, f18_arg0.parentView, f18_local2, "precisionTurning")
	f18_arg0.buttonList:addElement(f18_local1)
	f18_local1:processEvent({
		name = "expand",
		controller = f18_arg0.controller
	})
end

CoD.DrcControlsPanel.ControllerChanged = function (f19_arg0, f19_arg1)
	LUI.roots["UIRoot" .. f19_arg0.controller]:processEvent({
		name = "close_dead_zone_from_drc"
	})
	f19_arg0.buttonList.list:removeAllChildren()
	if UIExpression.GetControllerType(f19_arg1.controller) == "remote" then
		CoD.DrcControlsPanel.InitForRemote(f19_arg0)
	else
		CoD.DrcControlsPanel.InitForGamepad(f19_arg0)
	end
end

CoD.DrcControlsPanel.OnscreenControlsMenuOpened = function (f20_arg0, f20_arg1)
	f20_arg0.parentView:processEvent({
		name = "press_view_panel_button",
		buttonName = "controls"
	})
end

CoD.DrcControlsPanel.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.DrcControlsPanel.CollapsedWidth)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setUseStencil(true)
	Widget.controller = InstanceRef
	Widget.parentView = HudRef
	Widget.width = CoD.DrcControlsPanel.ExpandedWidth
	Widget.currentSelection = nil
	Widget.close = CoD.DrcControlsPanel.Close
	Widget:addElement(CoD.Border.new(3, 0.2, 0.23, 0.29, 1, 2))
	
	local buttonList = CoD.TouchpadVerticalList.new(nil, 0)
	buttonList:setLeftRight(false, true, -(CoD.DrcControlsPanel.ExpandedWidth - 6), -6)
	buttonList:setTopBottom(true, true, 5, -5)
	Widget:addElement(buttonList)
	Widget.buttonList = buttonList
	
	Widget:registerEventHandler("controller_changed", CoD.DrcControlsPanel.ControllerChanged)
	Widget:processEvent({
		name = "controller_changed",
		controller = InstanceRef
	})
	Widget:registerEventHandler("animated_close", CoD.DrcControlsPanel.AnimatedClose)
	Widget:registerEventHandler("transition_complete_animated_close", function (f22_arg0, f22_arg1)
		f22_arg0:dispatchEventToRoot({
			name = "close_controls",
			controller = 0
		})
	end)
	Widget:registerEventHandler("touchpad_down", CoD.DrcControlsPanel.TouchpadDown)
	Widget:registerEventHandler("button_collapsed", CoD.DrcControlsPanel.ButtonCollapsed)
	Widget:registerEventHandler("onscreen_controls_menu_opened", CoD.DrcControlsPanel.OnscreenControlsMenuOpened)
	buttonList:finishAddingElements()
	Widget:beginAnimation("expand", CoD.DrcView.PanelCollapseExpandSpeed)
	Widget:setLeftRight(true, false, 0, CoD.DrcControlsPanel.ExpandedWidth)
	LUI.roots["UIRoot" .. InstanceRef]:processEvent({
		name = "drc_controls_menu_opened",
		controller = InstanceRef
	})
	return Widget
end

