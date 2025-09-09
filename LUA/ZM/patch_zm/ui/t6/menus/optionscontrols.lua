require("T6.KeyBindSelector")
require("T6.ButtonLayoutOptions")
require("T6.StickLayoutOptions")
CoD.OptionsControls = {}
CoD.OptionsControls.CurrentTabIndex = nil
CoD.OptionsControls.Button_AddChoices_LookSensitivity = function (LookSensitivityButtonList)
	LookSensitivityButtonList.strings = {
		Engine.Localize("MENU_SENSITIVITY_VERY_LOW_CAPS"),
		Engine.Localize("MENU_SENSITIVITY_LOW_CAPS"),
		"3",
		Engine.Localize("MENU_SENSITIVITY_MEDIUM_CAPS"),
		"5",
		"6",
		"7",
		Engine.Localize("MENU_SENSITIVITY_HIGH_CAPS"),
		"9",
		"10",
		Engine.Localize("MENU_SENSITIVITY_VERY_HIGH_CAPS"),
		"12",
		"13",
		Engine.Localize("MENU_SENSITIVITY_INSANE_CAPS")
	}
	LookSensitivityButtonList.values = {
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
	CoD.Options.Button_AddChoices(LookSensitivityButtonList)
end

CoD.OptionsControls.Button_AddChoices_InvertMouse = function (LookTabButtonList)
	LookTabButtonList:addChoice(Engine.Localize("MENU_YES_CAPS"), -0.02)
	LookTabButtonList:addChoice(Engine.Localize("MENU_NO_CAPS"), 0.02)
end

CoD.OptionsControls.Callback_GamepadSelector = function (GamepadEnabled, ClientInstance)
	if ClientInstance then
		Engine.SetHardwareProfileValue(GamepadEnabled.parentSelectorButton.m_profileVarName, GamepadEnabled.value)
		if GamepadEnabled.value == 1 then
			Dvar.gpad_enabled:set(true)
			Engine.Exec(ClientInstance.controller, "execcontrollerbindings")
		else
			Dvar.gpad_enabled:set(false)
		end
	end
end

CoD.OptionsControls.Button_AddChoices_Gamepad = function (GamepadButtonList)
	GamepadButtonList:addChoice(Engine.Localize("MENU_DISABLED_CAPS"), 0, nil, CoD.OptionsControls.Callback_GamepadSelector)
	GamepadButtonList:addChoice(Engine.Localize("MENU_ENABLED_CAPS"), 1, nil, CoD.OptionsControls.Callback_GamepadSelector)
end

CoD.OptionsControls.AddKeyBindingElements = function (LocalClientIndex, ButtonList, KeyCommandsAndLabels)
	for Key, KeyCommandAndLabel in ipairs(KeyCommandsAndLabels) do
		if KeyCommandAndLabel.command == "break" then
			ButtonList:addSpacer(CoD.CoD9Button.Height / 2)
		else
			ButtonList:addKeyBindSelector(LocalClientIndex, Engine.Localize(KeyCommandAndLabel.label), KeyCommandAndLabel.command, CoD.BIND_PLAYER)
		end
	end
end

CoD.OptionsControls.CreateLookTab = function (LookTab, LocalClientIndex)
	local LookTabContainer = LUI.UIContainer.new()
	local LookTabButtonList = CoD.Options.CreateButtonList()
	LookTab.buttonList = LookTabButtonList
	LookTabContainer:addElement(LookTabButtonList)
	CoD.OptionsControls.AddKeyBindingElements(LocalClientIndex, LookTabButtonList, {
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
	LookTabButtonList:addSpacer(CoD.CoD9Button.Height / 2)
	CoD.OptionsControls.Button_AddChoices_InvertMouse(LookTabButtonList:addHardwareProfileLeftRightSelector(Engine.Localize("MENU_INVERT_MOUSE_CAPS"), "m_pitch"))
	CoD.Options.Button_AddChoices_YesOrNo(LookTabButtonList:addHardwareProfileLeftRightSelector(Engine.Localize("MENU_FREE_LOOK_CAPS"), "cl_freelook"))
	local MouseSensitivityOptions = LookTabButtonList:addProfileLeftRightSlider(LocalClientIndex, Engine.Localize("MENU_MOUSE_SENSITIVITY_CAPS"), "mouseSensitivity", 0.01, 30, nil, nil, nil, CoD.Options.AdjustSFX)
	MouseSensitivityOptions:setNumericDisplayFormatString("%.2f")
	MouseSensitivityOptions:setRoundToFraction(0.5)
	MouseSensitivityOptions:setBarSpeed(0.01)
	return LookTabContainer
end

CoD.OptionsControls.CreateMoveTab = function (MoveTab, LocalClientIndex)
	local MoveTabContainer = LUI.UIContainer.new()
	local MoveTabButtonList = CoD.Options.CreateButtonList()
	MoveTab.buttonList = MoveTabButtonList
	MoveTabContainer:addElement(MoveTabButtonList)
	CoD.OptionsControls.AddKeyBindingElements(LocalClientIndex, MoveTabButtonList, {
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
	return MoveTabContainer
end

CoD.OptionsControls.CreateCombatTab = function (CombatTab, LocalClientIndex)
	local CombatTabContainer = LUI.UIContainer.new()
	local CombatTabButtonList = CoD.Options.CreateButtonList()
	CombatTab.buttonList = CombatTabButtonList
	CombatTabContainer:addElement(CombatTabButtonList)
	CoD.OptionsControls.AddKeyBindingElements(LocalClientIndex, CombatTabButtonList, {
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
	return CombatTabContainer
end

CoD.OptionsControls.CreateInteractTab = function (InteractTab, LocalClientIndex)
	local InteractTabContainer = LUI.UIContainer.new()
	local InteractTabButtonList = CoD.Options.CreateButtonList()
	InteractTab.buttonList = InteractTabButtonList
	InteractTabContainer:addElement(InteractTabButtonList)
	local ActionSlot1Label, ActionSlot2Label, ActionSlot3Label, ActionSlot4Label = nil
	if CoD.isSinglePlayer then
		ActionSlot1Label = "PLATFORM_AIR_SUPPORT_CAPS"
		ActionSlot2Label = "PLATFORM_USE_GEAR_CAPS"
		ActionSlot3Label = "PLATFORM_GROUND_SUPPORT_CAPS"
		ActionSlot4Label = "PLATFORM_USE_EQUIPMENT_CAPS"
	else
		ActionSlot1Label = "PLATFORM_NEXT_SCORE_STREAK_CAPS"
		ActionSlot2Label = "PLATFORM_PREVIOUS_SCORE_STREAK_CAPS"
		ActionSlot3Label = "PLATFORM_ACTIONSLOT_3"
		ActionSlot4Label = "PLATFORM_ACTIVATE_SCORE_STREAK_CAPS"
	end
	local InteractTabContents = {
		{
			command = "+activate",
			label = "MENU_USE_CAPS"
		},
		{
			command = "break"
		},
		{
			command = "+actionslot 3",
			label = ActionSlot3Label
		},
		{
			command = "+actionslot 1",
			label = ActionSlot1Label
		},
		{
			command = "+actionslot 2",
			label = ActionSlot2Label
		},
		{
			command = "+actionslot 4",
			label = ActionSlot4Label
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
		table.insert(InteractTabContents, {
			command = "chooseclass_hotkey",
			label = "MPUI_CHOOSE_CLASS_CAPS"
		})
		table.insert(InteractTabContents, {
			command = "+scores",
			label = "PLATFORM_SCOREBOARD_CAPS"
		})
		table.insert(InteractTabContents, {
			command = "togglescores",
			label = "PLATFORM_SCOREBOARD_TOGGLE_CAPS"
		})
		table.insert(InteractTabContents, {
			command = "break"
		})
		table.insert(InteractTabContents, {
			command = "+talk",
			label = "MENU_VOICE_CHAT_BUTTON_CAPS"
		})
		table.insert(InteractTabContents, {
			command = "chatmodepublic",
			label = "MENU_CHAT_CAPS"
		})
		table.insert(InteractTabContents, {
			command = "chatmodeteam",
			label = "MENU_TEAM_CHAT_CAPS"
		})
	end
	CoD.OptionsControls.AddKeyBindingElements(LocalClientIndex, InteractTabButtonList, InteractTabContents)
	return InteractTabContainer
end

CoD.OptionsControls.CreateGamepadTab = function (GamepadTab, LocalClientIndex)
	local GamepadButtonListContainer = LUI.UIContainer.new()
	local GamepadButtonList = CoD.Options.CreateButtonList()
	GamepadTab.buttonList = GamepadButtonList
	GamepadButtonListContainer:addElement(GamepadButtonList)
	CoD.OptionsControls.Button_AddChoices_Gamepad(GamepadButtonList:addHardwareProfileLeftRightSelector(Engine.Localize("PLATFORM_ENABLE_GAMEPAD_CAPS"), "gpad_enabled"))
	CoD.Options.Button_AddChoices_EnabledOrDisabled(GamepadButtonList:addProfileLeftRightSelector(LocalClientIndex, Engine.Localize("MENU_LOOK_INVERSION_CAPS"), "input_invertpitch", Engine.Localize("MENU_LOOK_INVERSION_DESC")))
	CoD.Options.Button_AddChoices_EnabledOrDisabled(GamepadButtonList:addProfileLeftRightSelector(LocalClientIndex, Engine.Localize("PLATFORM_CONTROLLER_VIBRATION_CAPS"), "gpad_rumble", Engine.Localize("PLATFORM_CONTROLLER_VIBRATION_DESC")))
	if UIExpression.IsDemoPlaying(LocalClientIndex) ~= 0 then
		local TheaterButtonLayout = GamepadButtonList:addProfileLeftRightSelector(LocalClientIndex, Engine.Localize("MENU_THEATER_BUTTON_LAYOUT_CAPS"), "demo_controllerconfig", Engine.Localize("MENU_THEATER_BUTTON_LAYOUT_DESC"))
		CoD.ButtonLayout.AddChoices(TheaterButtonLayout, LocalClientIndex)
		TheaterButtonLayout:disableCycling()
		TheaterButtonLayout:registerEventHandler("button_action", CoD.OptionsControls.Button_ButtonLayout)
	else
		local GamepadThumbSticksOptions = GamepadButtonList:addProfileLeftRightSelector(LocalClientIndex, Engine.Localize("MENU_THUMBSTICK_LAYOUT_CAPS"), "gpad_sticksConfig", Engine.Localize("MENU_THUMBSTICK_LAYOUT_DESC"))
		CoD.StickLayout.AddChoices(GamepadThumbSticksOptions)
		GamepadThumbSticksOptions:disableCycling()
		GamepadThumbSticksOptions:registerEventHandler("button_action", CoD.OptionsControls.Button_StickLayout)
		local GamepadButtonsOptions = GamepadButtonList:addProfileLeftRightSelector(LocalClientIndex, Engine.Localize("MENU_BUTTON_LAYOUT_CAPS"), "gpad_buttonsConfig", Engine.Localize("MENU_BUTTON_LAYOUT_DESC"))
		CoD.ButtonLayout.AddChoices(GamepadButtonsOptions, LocalClientIndex)
		GamepadButtonsOptions:disableCycling()
		GamepadButtonsOptions:registerEventHandler("button_action", CoD.OptionsControls.Button_ButtonLayout)
	end
	CoD.OptionsControls.Button_AddChoices_LookSensitivity(GamepadButtonList:addProfileLeftRightSelector(LocalClientIndex, Engine.Localize("MENU_LOOK_SENSITIVITY_CAPS"), "input_viewSensitivity", Engine.Localize("PLATFORM_LOOK_SENSITIVITY_DESC")))
	return GamepadButtonListContainer
end

CoD.OptionsControls.TabChanged = function (ControlsSettingsWidget, ControlsTab)
	ControlsSettingsWidget.buttonList = ControlsSettingsWidget.tabManager.buttonList
	local NextFocusableTab = ControlsSettingsWidget.buttonList:getFirstChild()
	while not NextFocusableTab.m_focusable do
		NextFocusableTab = NextFocusableTab:getNextSibling()
	end
	if NextFocusableTab ~= nil then
		NextFocusableTab:processEvent({
			name = "gain_focus"
		})
	end
	CoD.OptionsControls.CurrentTabIndex = ControlsTab.tabIndex
end

CoD.OptionsControls.DefaultPopup_RestoreDefaultControls = function (f12_arg0, ClientInstance)
	Engine.SetProfileVar(ClientInstance.controller, "input_invertpitch", 0)
	Engine.SetProfileVar(ClientInstance.controller, "gpad_rumble", 1)
	Engine.SetProfileVar(ClientInstance.controller, "gpad_sticksConfig", CoD.THUMBSTICK_DEFAULT)
	Engine.SetProfileVar(ClientInstance.controller, "gpad_buttonsConfig", CoD.BUTTONS_DEFAULT)
	Engine.SetProfileVar(ClientInstance.controller, "input_viewSensitivity", CoD.SENSITIVITY_4)
	Engine.SetProfileVar(ClientInstance.controller, "mouseSensitivity", 5)
	local DefaultControlsConfig = "default_controls"
	if CoD.isMultiplayer then
		DefaultControlsConfig = "default_mp_controls"
	end
	local Language = Engine.GetLanguage()
	if Language then
		DefaultControlsConfig = DefaultControlsConfig .. "_" .. Language
	end
	Engine.ExecNow(ClientInstance.controller, "exec " .. DefaultControlsConfig)
	Engine.Exec(ClientInstance.controller, "execcontrollerbindings")
	Engine.SyncHardwareProfileWithDvars()
	f12_arg0:goBack(ClientInstance.controller)
end

CoD.OptionsControls.OnFinishControls = function (f13_arg0, ClientInstance)
	Engine.Exec(ClientInstance.controller, "updateMustHaveBindings")
	if UIExpression.IsInGame() == 1 then
		Engine.Exec(ClientInstance.controller, "updateVehicleBindings")
	end
	if CoD.useController and Engine.LastInput_Gamepad() then
		f13_arg0:dispatchEventToRoot({
			name = "input_source_changed",
			controller = ClientInstance.controller,
			source = 0
		})
	else
		f13_arg0:dispatchEventToRoot({
			name = "input_source_changed",
			controller = ClientInstance.controller,
			source = 1
		})
	end
end

CoD.OptionsControls.Back = function (f14_arg0, ClientInstance)
	CoD.OptionsControls.OnFinishControls(f14_arg0, ClientInstance)
	CoD.Options.Back(f14_arg0, ClientInstance)
end

CoD.OptionsControls.CloseMenu = function (f15_arg0, ClientInstance)
	CoD.OptionsControls.OnFinishControls(f15_arg0, ClientInstance)
	CoD.Options.CloseMenu(f15_arg0, ClientInstance)
end

CoD.OptionsControls.OpenDefaultPopup = function (f16_arg0, ClientInstance)
	local f16_local0 = f16_arg0:openMenu("SetDefaultControlsPopup", ClientInstance.controller)
	f16_local0:registerEventHandler("confirm_action", CoD.OptionsControls.DefaultPopup_RestoreDefaultControls)
	f16_arg0:close()
end

CoD.OptionsControls.OpenButtonLayout = function (f17_arg0, ClientInstance)
	f17_arg0:saveState()
	f17_arg0:openMenu("ButtonLayout", ClientInstance.controller)
	f17_arg0:close()
end

CoD.OptionsControls.OpenStickLayout = function (f18_arg0, ClientInstance)
	f18_arg0:saveState()
	f18_arg0:openMenu("StickLayout", ClientInstance.controller)
	f18_arg0:close()
end

CoD.OptionsControls.Button_StickLayout = function (GamepadThumbSticksOptions, ClientInstance)
	GamepadThumbSticksOptions:dispatchEventToParent({
		name = "open_stick_layout",
		controller = ClientInstance.controller
	})
end

CoD.OptionsControls.Button_ButtonLayout = function (GamepadButtonsOptions, ClientInstance)
	GamepadButtonsOptions:dispatchEventToParent({
		name = "open_button_layout",
		controller = ClientInstance.controller
	})
end

LUI.createMenu.OptionsControlsMenu = function (LocalClientIndex)
	local ControlsSettingsWidget = nil
	if UIExpression.IsInGame() == 1 then
		ControlsSettingsWidget = CoD.InGameMenu.New("OptionsControlsMenu", LocalClientIndex, Engine.Localize("MENU_CONTROLS_CAPS"))
	else
		ControlsSettingsWidget = CoD.Menu.New("OptionsControlsMenu")
		ControlsSettingsWidget:addTitle(Engine.Localize("MENU_CONTROLS_CAPS"), LUI.Alignment.Center)
		if CoD.isSinglePlayer == false then
			ControlsSettingsWidget:addLargePopupBackground()
		end
	end
	if CoD.isSinglePlayer == true then
		Engine.SendMenuResponse(LocalClientIndex, "luisystem", "modal_start")
	end
	ControlsSettingsWidget:setPreviousMenu("OptionsMenu")
	ControlsSettingsWidget:setOwner(LocalClientIndex)
	ControlsSettingsWidget:registerEventHandler("button_prompt_back", CoD.OptionsControls.Back)
	ControlsSettingsWidget:registerEventHandler("restore_default_controls", CoD.OptionsControls.RestoreDefaultControls)
	ControlsSettingsWidget:registerEventHandler("tab_changed", CoD.OptionsControls.TabChanged)
	ControlsSettingsWidget:registerEventHandler("open_button_layout", CoD.OptionsControls.OpenButtonLayout)
	ControlsSettingsWidget:registerEventHandler("open_stick_layout", CoD.OptionsControls.OpenStickLayout)
	ControlsSettingsWidget:registerEventHandler("open_default_popup", CoD.OptionsControls.OpenDefaultPopup)
	ControlsSettingsWidget:addSelectButton()
	ControlsSettingsWidget:addBackButton()
	CoD.Options.AddResetPrompt(ControlsSettingsWidget)
	local ControlsTabs = CoD.Options.SetupTabManager(ControlsSettingsWidget, 800)
	ControlsTabs:addTab(LocalClientIndex, "MENU_LOOK_CAPS", CoD.OptionsControls.CreateLookTab)
	ControlsTabs:addTab(LocalClientIndex, "MENU_MOVE_CAPS", CoD.OptionsControls.CreateMoveTab)
	ControlsTabs:addTab(LocalClientIndex, "MENU_COMBAT_CAPS", CoD.OptionsControls.CreateCombatTab)
	ControlsTabs:addTab(LocalClientIndex, "MENU_INTERACT_CAPS", CoD.OptionsControls.CreateInteractTab)
	ControlsTabs:addTab(LocalClientIndex, "PLATFORM_GAMEPAD_CAPS", CoD.OptionsControls.CreateGamepadTab)
	if CoD.OptionsControls.CurrentTabIndex then
		ControlsTabs:loadTab(LocalClientIndex, CoD.OptionsControls.CurrentTabIndex)
	else
		ControlsTabs:refreshTab(LocalClientIndex)
	end
	return ControlsSettingsWidget
end

