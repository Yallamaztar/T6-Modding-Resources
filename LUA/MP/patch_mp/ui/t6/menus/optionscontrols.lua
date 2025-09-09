require("T6.KeyBindSelector")
require("T6.ButtonLayoutOptions")
require("T6.StickLayoutOptions")
CoD.OptionsControls = {}
CoD.OptionsControls.CurrentTabIndex = nil
CoD.OptionsControls.Button_AddChoices_LookSensitivity = function (f1_arg0)
	local f1_local0 = {}
	local f1_local1 = Engine.Localize("MENU_SENSITIVITY_VERY_LOW_CAPS")
	local f1_local2 = Engine.Localize("MENU_SENSITIVITY_LOW_CAPS")
	local f1_local3 = "3"
	local f1_local4 = Engine.Localize("MENU_SENSITIVITY_MEDIUM_CAPS")
	local f1_local5 = "5"
	local f1_local6 = "6"
	local f1_local7 = "7"
	local f1_local8 = Engine.Localize("MENU_SENSITIVITY_HIGH_CAPS")
	local f1_local9 = "9"
	local f1_local10 = "10"
	local f1_local11 = Engine.Localize("MENU_SENSITIVITY_VERY_HIGH_CAPS")
	local f1_local12 = "12"
	local f1_local13 = "13"
	local f1_local14 = Engine.Localize("MENU_SENSITIVITY_INSANE_CAPS")
	f1_arg0.strings = f1_local1
	f1_arg0.values = {
		CoD.SENSITIVITY_1,
		CoD.SENSITIVITY_2,
		CoD.SENSITIVITY_3,
		CoD.SENSITIVITY_4,
		CoD.SENSITIVITY_5,
		CoD.SENSITIVITY_6,
		CoD.SENSITIVITY_7,
		CoD.SENSITIVITY_8,
		CoD.SENSITIVITY_9,
		CoD.SENSITIVITY_10,
		CoD.SENSITIVITY_11,
		CoD.SENSITIVITY_12,
		CoD.SENSITIVITY_13,
		CoD.SENSITIVITY_14
	}
	CoD.Options.Button_AddChoices(f1_arg0)
end

CoD.OptionsControls.Button_AddChoices_InvertMouse = function (f2_arg0)
	f2_arg0:addChoice(Engine.Localize("MENU_YES_CAPS"), -0.02)
	f2_arg0:addChoice(Engine.Localize("MENU_NO_CAPS"), 0.02)
end

CoD.OptionsControls.Callback_GamepadSelector = function (f3_arg0, f3_arg1)
	if f3_arg1 then
		Engine.SetHardwareProfileValue(f3_arg0.parentSelectorButton.m_profileVarName, f3_arg0.value)
		if f3_arg0.value == 1 then
			Dvar.gpad_enabled:set(true)
			Engine.Exec(controller, "execcontrollerbindings")
		else
			Dvar.gpad_enabled:set(false)
		end
	end
end

CoD.OptionsControls.Button_AddChoices_Gamepad = function (f4_arg0)
	f4_arg0:addChoice(Engine.Localize("MENU_DISABLED_CAPS"), 0, nil, CoD.OptionsControls.Callback_GamepadSelector)
	f4_arg0:addChoice(Engine.Localize("MENU_ENABLED_CAPS"), 1, nil, CoD.OptionsControls.Callback_GamepadSelector)
end

CoD.OptionsControls.AddKeyBindingElements = function (controller, menu, bindingsData)
	for key, value in ipairs(bindingsData) do
		if value.command == "break" then
			menu:addSpacer(CoD.CoD9Button.Height / 2)
		else
			menu:addKeyBindSelector(controller, Engine.Localize(value.label), value.command, CoD.BIND_PLAYER)
		end
	end
end

CoD.OptionsControls.CreateLookTab = function (f6_arg0, controller)
	local f6_local0 = LUI.UIContainer.new()
	local buttonList = CoD.Options.CreateButtonList()
	f6_arg0.buttonList = buttonList
	f6_local0:addElement(buttonList)
	CoD.OptionsControls.AddKeyBindingElements(controller, buttonList, {
		{
			command = "+leanleft",
			label = "MENU_LEAN_LEFT_CAPS"
		},
		{
			command = "+leanright",
			label = "MENU_LEAN_RIGHT_CAPS"
		},
		{
			command = "+lookup",
			label = "MENU_LOOK_UP_CAPS"
		},
		{
			command = "+lookdown",
			label = "MENU_LOOK_DOWN_CAPS"
		},
		{
			command = "+left",
			label = "MENU_TURN_LEFT_CAPS"
		},
		{
			command = "+right",
			label = "MENU_TURN_RIGHT_CAPS"
		},
		{
			command = "+mlook",
			label = "MENU_MOUSE_LOOK_CAPS"
		},
		{
			command = "centerview",
			label = "MENU_CENTER_VIEW_CAPS"
		}
	})
	buttonList:addSpacer(CoD.CoD9Button.Height / 2)
	CoD.OptionsControls.Button_AddChoices_InvertMouse(buttonList:addHardwareProfileLeftRightSelector(Engine.Localize("MENU_INVERT_MOUSE_CAPS"), "m_pitch"))
	CoD.Options.Button_AddChoices_YesOrNo(buttonList:addHardwareProfileLeftRightSelector(Engine.Localize("MENU_FREE_LOOK_CAPS"), "cl_freelook"))
	local f6_local2 = buttonList:addProfileLeftRightSlider(controller, Engine.Localize("MENU_MOUSE_SENSITIVITY_CAPS"), "mouseSensitivity", 0.01, 30, nil, nil, nil, CoD.Options.AdjustSFX)
	f6_local2:setNumericDisplayFormatString("%.2f")
	f6_local2:setRoundToFraction(0.5)
	f6_local2:setBarSpeed(0.01)
	return f6_local0
end

CoD.OptionsControls.CreateMoveTab = function (f7_arg0, f7_arg1)
	local f7_local0 = LUI.UIContainer.new()
	local f7_local1 = CoD.Options.CreateButtonList()
	f7_arg0.buttonList = f7_local1
	f7_local0:addElement(f7_local1)
	CoD.OptionsControls.AddKeyBindingElements(f7_arg1, f7_local1, {
		{
			command = "+forward",
			label = "MENU_FORWARD_CAPS"
		},
		{
			command = "+back",
			label = "MENU_BACKPEDAL_CAPS"
		},
		{
			command = "+moveleft",
			label = "MENU_MOVE_LEFT_CAPS"
		},
		{
			command = "+moveright",
			label = "MENU_MOVE_RIGHT_CAPS"
		},
		{
			command = "break"
		},
		{
			command = "+gostand",
			label = "MENU_STANDJUMP_CAPS"
		},
		{
			command = "gocrouch",
			label = "MENU_GO_TO_CROUCH_CAPS"
		},
		{
			command = "goprone",
			label = "MENU_GO_TO_PRONE_CAPS"
		},
		{
			command = "togglecrouch",
			label = "MENU_TOGGLE_CROUCH_CAPS"
		},
		{
			command = "toggleprone",
			label = "MENU_TOGGLE_PRONE_CAPS"
		},
		{
			command = "+movedown",
			label = "MENU_CROUCH_CAPS"
		},
		{
			command = "+prone",
			label = "MENU_PRONE_CAPS"
		},
		{
			command = "break"
		},
		{
			command = "+stance",
			label = "PLATFORM_CHANGE_STANCE_CAPS"
		},
		{
			command = "+strafe",
			label = "MENU_STRAFE_CAPS"
		}
	})
	return f7_local0
end

CoD.OptionsControls.CreateCombatTab = function (f8_arg0, f8_arg1)
	local f8_local0 = LUI.UIContainer.new()
	local f8_local1 = CoD.Options.CreateButtonList()
	f8_arg0.buttonList = f8_local1
	f8_local0:addElement(f8_local1)
	CoD.OptionsControls.AddKeyBindingElements(f8_arg1, f8_local1, {
		{
			command = "+attack",
			label = "MENU_ATTACK_CAPS"
		},
		{
			command = "+speed_throw",
			label = "MENU_AIM_DOWN_THE_SIGHT_CAPS"
		},
		{
			command = "+toggleads_throw",
			label = "MENU_TOGGLE_AIM_DOWN_THE_SIGHT_CAPS"
		},
		{
			command = "+melee",
			label = "MENU_MELEE_ATTACK_CAPS"
		},
		{
			command = "+weapnext_inventory",
			label = "PLATFORM_SWITCH_WEAPON_CAPS"
		},
		{
			command = "weapprev",
			label = "PLATFORM_NEXT_WEAPON_CAPS"
		},
		{
			command = "+reload",
			label = "MENU_RELOAD_WEAPON_CAPS"
		},
		{
			command = "+sprint",
			label = "MENU_SPRINT_CAPS"
		},
		{
			command = "+breath_sprint",
			label = "MENU_SPRINT_HOLD_BREATH_CAPS"
		},
		{
			command = "+holdbreath",
			label = "MENU_STEADY_SNIPER_RIFLE_CAPS"
		},
		{
			command = "+frag",
			label = "PLATFORM_THROW_PRIMARY_CAPS"
		},
		{
			command = "+smoke",
			label = "PLATFORM_THROW_SECONDARY_CAPS"
		}
	})
	return f8_local0
end

CoD.OptionsControls.CreateInteractTab = function (f9_arg0, f9_arg1)
	local f9_local0 = LUI.UIContainer.new()
	local f9_local1 = CoD.Options.CreateButtonList()
	f9_arg0.buttonList = f9_local1
	f9_local0:addElement(f9_local1)
	local f9_local2, f9_local3, f9_local4, f9_local5 = nil
	if CoD.isSinglePlayer then
		f9_local2 = "PLATFORM_AIR_SUPPORT_CAPS"
		f9_local3 = "PLATFORM_USE_GEAR_CAPS"
		f9_local4 = "PLATFORM_GROUND_SUPPORT_CAPS"
		f9_local5 = "PLATFORM_USE_EQUIPMENT_CAPS"
	else
		f9_local2 = "PLATFORM_NEXT_SCORE_STREAK_CAPS"
		f9_local3 = "PLATFORM_PREVIOUS_SCORE_STREAK_CAPS"
		f9_local4 = "PLATFORM_ACTIONSLOT_3"
		f9_local5 = "PLATFORM_ACTIVATE_SCORE_STREAK_CAPS"
	end
	local f9_local6 = {
		{
			command = "+activate",
			label = "MENU_USE_CAPS"
		},
		{
			command = "break"
		},
		{
			command = "+actionslot 3",
			label = f9_local4
		},
		{
			command = "+actionslot 1",
			label = f9_local2
		},
		{
			command = "+actionslot 2",
			label = f9_local3
		},
		{
			command = "+actionslot 4",
			label = f9_local5
		},
		{
			command = "break"
		},
		{
			command = "screenshotjpeg",
			label = "MENU_SCREENSHOT_CAPS"
		}
	}
	if CoD.isMultiplayer then
		table.insert(f9_local6, {
			command = "chooseclass_hotkey",
			label = "MPUI_CHOOSE_CLASS_CAPS"
		})
		table.insert(f9_local6, {
			command = "+scores",
			label = "PLATFORM_SCOREBOARD_CAPS"
		})
		table.insert(f9_local6, {
			command = "togglescores",
			label = "PLATFORM_SCOREBOARD_TOGGLE_CAPS"
		})
		table.insert(f9_local6, {
			command = "break"
		})
		table.insert(f9_local6, {
			command = "+talk",
			label = "MENU_VOICE_CHAT_BUTTON_CAPS"
		})
		table.insert(f9_local6, {
			command = "chatmodepublic",
			label = "MENU_CHAT_CAPS"
		})
		table.insert(f9_local6, {
			command = "chatmodeteam",
			label = "MENU_TEAM_CHAT_CAPS"
		})
	end
	CoD.OptionsControls.AddKeyBindingElements(f9_arg1, f9_local1, f9_local6)
	return f9_local0
end

CoD.OptionsControls.CreateGamepadTab = function (f10_arg0, f10_arg1)
	local f10_local0 = LUI.UIContainer.new()
	local f10_local1 = UIExpression.IsDemoPlaying(f10_arg1) ~= 0
	local f10_local2 = CoD.Options.CreateButtonList()
	f10_arg0.buttonList = f10_local2
	f10_local0:addElement(f10_local2)
	CoD.OptionsControls.Button_AddChoices_Gamepad(f10_local2:addHardwareProfileLeftRightSelector(Engine.Localize("PLATFORM_ENABLE_GAMEPAD_CAPS"), "gpad_enabled"))
	CoD.Options.Button_AddChoices_EnabledOrDisabled(f10_local2:addProfileLeftRightSelector(f10_arg1, Engine.Localize("MENU_LOOK_INVERSION_CAPS"), "input_invertpitch", Engine.Localize("MENU_LOOK_INVERSION_DESC")))
	CoD.Options.Button_AddChoices_EnabledOrDisabled(f10_local2:addProfileLeftRightSelector(f10_arg1, Engine.Localize("PLATFORM_CONTROLLER_VIBRATION_CAPS"), "gpad_rumble", Engine.Localize("PLATFORM_CONTROLLER_VIBRATION_DESC")))
	if f10_local1 then
		local f10_local3 = f10_local2:addProfileLeftRightSelector(f10_arg1, Engine.Localize("MENU_THEATER_BUTTON_LAYOUT_CAPS"), "demo_controllerconfig", Engine.Localize("MENU_THEATER_BUTTON_LAYOUT_DESC"))
		CoD.ButtonLayout.AddChoices(f10_local3, f10_arg1)
		f10_local3:disableCycling()
		f10_local3:registerEventHandler("button_action", CoD.OptionsControls.Button_ButtonLayout)
	else
		local f10_local3 = f10_local2:addProfileLeftRightSelector(f10_arg1, Engine.Localize("MENU_THUMBSTICK_LAYOUT_CAPS"), "gpad_sticksConfig", Engine.Localize("MENU_THUMBSTICK_LAYOUT_DESC"))
		CoD.StickLayout.AddChoices(f10_local3)
		f10_local3:disableCycling()
		f10_local3:registerEventHandler("button_action", CoD.OptionsControls.Button_StickLayout)
		local f10_local4 = f10_local2:addProfileLeftRightSelector(f10_arg1, Engine.Localize("MENU_BUTTON_LAYOUT_CAPS"), "gpad_buttonsConfig", Engine.Localize("MENU_BUTTON_LAYOUT_DESC"))
		CoD.ButtonLayout.AddChoices(f10_local4, f10_arg1)
		f10_local4:disableCycling()
		f10_local4:registerEventHandler("button_action", CoD.OptionsControls.Button_ButtonLayout)
	end
	CoD.OptionsControls.Button_AddChoices_LookSensitivity(f10_local2:addProfileLeftRightSelector(f10_arg1, Engine.Localize("MENU_LOOK_SENSITIVITY_CAPS"), "input_viewSensitivity", Engine.Localize("PLATFORM_LOOK_SENSITIVITY_DESC")))
	return f10_local0
end

CoD.OptionsControls.TabChanged = function (f11_arg0, f11_arg1)
	f11_arg0.buttonList = f11_arg0.tabManager.buttonList
	local f11_local0 = f11_arg0.buttonList:getFirstChild()
	while not f11_local0.m_focusable do
		f11_local0 = f11_local0:getNextSibling()
	end
	if f11_local0 ~= nil then
		f11_local0:processEvent({
			name = "gain_focus"
		})
	end
	CoD.OptionsControls.CurrentTabIndex = f11_arg1.tabIndex
end

CoD.OptionsControls.DefaultPopup_RestoreDefaultControls = function (f12_arg0, f12_arg1)
	Engine.SetProfileVar(f12_arg1.controller, "input_invertpitch", 0)
	Engine.SetProfileVar(f12_arg1.controller, "gpad_rumble", 1)
	Engine.SetProfileVar(f12_arg1.controller, "gpad_sticksConfig", CoD.THUMBSTICK_DEFAULT)
	Engine.SetProfileVar(f12_arg1.controller, "gpad_buttonsConfig", CoD.BUTTONS_DEFAULT)
	Engine.SetProfileVar(f12_arg1.controller, "input_viewSensitivity", CoD.SENSITIVITY_4)
	Engine.SetProfileVar(f12_arg1.controller, "mouseSensitivity", 5)
	local f12_local0 = "default_controls"
	if CoD.isMultiplayer then
		f12_local0 = "default_mp_controls"
	end
	local f12_local1 = Engine.GetLanguage()
	if f12_local1 then
		f12_local0 = f12_local0 .. "_" .. f12_local1
	end
	Engine.ExecNow(f12_arg1.controller, "exec " .. f12_local0)
	Engine.Exec(f12_arg1.controller, "execcontrollerbindings")
	Engine.SyncHardwareProfileWithDvars()
	f12_arg0:goBack(f12_arg1.controller)
end

CoD.OptionsControls.OnFinishControls = function (f13_arg0, f13_arg1)
	Engine.Exec(f13_arg1.controller, "updateMustHaveBindings")
	if UIExpression.IsInGame() == 1 then
		Engine.Exec(f13_arg1.controller, "updateVehicleBindings")
	end
	if CoD.useController and Engine.LastInput_Gamepad() then
		f13_arg0:dispatchEventToRoot({
			name = "input_source_changed",
			controller = f13_arg1.controller,
			source = 0
		})
	else
		f13_arg0:dispatchEventToRoot({
			name = "input_source_changed",
			controller = f13_arg1.controller,
			source = 1
		})
	end
end

CoD.OptionsControls.Back = function (f14_arg0, f14_arg1)
	CoD.OptionsControls.OnFinishControls(f14_arg0, f14_arg1)
	CoD.Options.Back(f14_arg0, f14_arg1)
end

CoD.OptionsControls.CloseMenu = function (f15_arg0, f15_arg1)
	CoD.OptionsControls.OnFinishControls(f15_arg0, f15_arg1)
	CoD.Options.CloseMenu(f15_arg0, f15_arg1)
end

CoD.OptionsControls.OpenDefaultPopup = function (f16_arg0, f16_arg1)
	local f16_local0 = f16_arg0:openMenu("SetDefaultControlsPopup", f16_arg1.controller)
	f16_local0:registerEventHandler("confirm_action", CoD.OptionsControls.DefaultPopup_RestoreDefaultControls)
	f16_arg0:close()
end

CoD.OptionsControls.OpenButtonLayout = function (f17_arg0, f17_arg1)
	f17_arg0:saveState()
	f17_arg0:openMenu("ButtonLayout", f17_arg1.controller)
	f17_arg0:close()
end

CoD.OptionsControls.OpenStickLayout = function (f18_arg0, f18_arg1)
	f18_arg0:saveState()
	f18_arg0:openMenu("StickLayout", f18_arg1.controller)
	f18_arg0:close()
end

CoD.OptionsControls.Button_StickLayout = function (f19_arg0, f19_arg1)
	f19_arg0:dispatchEventToParent({
		name = "open_stick_layout",
		controller = f19_arg1.controller
	})
end

CoD.OptionsControls.Button_ButtonLayout = function (f20_arg0, f20_arg1)
	f20_arg0:dispatchEventToParent({
		name = "open_button_layout",
		controller = f20_arg1.controller
	})
end

LUI.createMenu.OptionsControlsMenu = function (f21_arg0)
	local f21_local0 = nil
	if UIExpression.IsInGame() == 1 then
		f21_local0 = CoD.InGameMenu.New("OptionsControlsMenu", f21_arg0, Engine.Localize("MENU_CONTROLS_CAPS"))
	else
		f21_local0 = CoD.Menu.New("OptionsControlsMenu")
		f21_local0:addTitle(Engine.Localize("MENU_CONTROLS_CAPS"), LUI.Alignment.Center)
		if CoD.isSinglePlayer == false then
			f21_local0:addLargePopupBackground()
		end
	end
	if CoD.isSinglePlayer == true then
		Engine.SendMenuResponse(f21_arg0, "luisystem", "modal_start")
	end
	f21_local0:setPreviousMenu("OptionsMenu")
	f21_local0:setOwner(f21_arg0)
	f21_local0:registerEventHandler("button_prompt_back", CoD.OptionsControls.Back)
	f21_local0:registerEventHandler("restore_default_controls", CoD.OptionsControls.RestoreDefaultControls)
	f21_local0:registerEventHandler("tab_changed", CoD.OptionsControls.TabChanged)
	f21_local0:registerEventHandler("open_button_layout", CoD.OptionsControls.OpenButtonLayout)
	f21_local0:registerEventHandler("open_stick_layout", CoD.OptionsControls.OpenStickLayout)
	f21_local0:registerEventHandler("open_default_popup", CoD.OptionsControls.OpenDefaultPopup)
	f21_local0:addSelectButton()
	f21_local0:addBackButton()
	CoD.Options.AddResetPrompt(f21_local0)
	local f21_local1 = CoD.Options.SetupTabManager(f21_local0, 800)
	f21_local1:addTab(f21_arg0, "MENU_LOOK_CAPS", CoD.OptionsControls.CreateLookTab)
	f21_local1:addTab(f21_arg0, "MENU_MOVE_CAPS", CoD.OptionsControls.CreateMoveTab)
	f21_local1:addTab(f21_arg0, "MENU_COMBAT_CAPS", CoD.OptionsControls.CreateCombatTab)
	f21_local1:addTab(f21_arg0, "MENU_INTERACT_CAPS", CoD.OptionsControls.CreateInteractTab)
	f21_local1:addTab(f21_arg0, "PLATFORM_GAMEPAD_CAPS", CoD.OptionsControls.CreateGamepadTab)
	if CoD.OptionsControls.CurrentTabIndex then
		f21_local1:loadTab(f21_arg0, CoD.OptionsControls.CurrentTabIndex)
	else
		f21_local1:refreshTab(f21_arg0)
	end
	return f21_local0
end

