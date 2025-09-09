require("T6.Line")
if CoD.isWIIU then
	require("T6.WiiUButtonLayout")
end
CoD.ButtonLayout = {}
CoD.ButtonLayout.LineWidth = 2
CoD.ButtonLayout.LineColor = {
	CoD.offWhite.r,
	CoD.offWhite.g,
	CoD.offWhite.b,
	1
}
CoD.ButtonLayout.ButtonRefs = {
	"BUTTON_A",
	"BUTTON_B",
	"BUTTON_X",
	"BUTTON_Y",
	"BUTTON_LBUMP",
	"BUTTON_RBUMP",
	"BUTTON_UP",
	"BUTTON_DOWN",
	"BUTTON_LEFT",
	"BUTTON_RIGHT",
	"BUTTON_LTRIG",
	"BUTTON_RTRIG",
	"BUTTON_START",
	"BUTTON_BACK",
	"BUTTON_LSTICK",
	"BUTTON_RSTICK"
}
CoD.ButtonLayout.ButtonStrings = {}
CoD.ButtonLayout.FragGrenadeString = "MENU_THROW_FRAG_GRENADE"
if CoD.isSinglePlayer then
	CoD.ButtonLayout.FragGrenadeString = "MENU_THROW_PRIMARY"
end
CoD.ButtonLayout.SpecialGrenadeString = "MENU_THROW_SPECIAL_GRENADE"
if CoD.isSinglePlayer then
	CoD.ButtonLayout.SpecialGrenadeString = "MENU_THROW_SECONDARY"
end
CoD.ButtonLayout.ButtonStrings[CoD.BUTTONS_DEFAULT + 1] = {
	BUTTON_A = "MENU_JUMP",
	BUTTON_B = "MENU_CROUCH_PRONE",
	BUTTON_X = "MENU_USE_RELOAD",
	BUTTON_Y = "MENU_SWITCH_WEAPON",
	BUTTON_LBUMP = CoD.ButtonLayout.SpecialGrenadeString,
	BUTTON_RBUMP = CoD.ButtonLayout.FragGrenadeString,
	BUTTON_UP = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.MPZM("MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_LTRIG = "MENU_AIM_DOWN_SIGHT",
	BUTTON_RTRIG = "MENU_FIRE_WEAPON",
	BUTTON_START = "MENU_OBJECTIVES_MENU",
	BUTTON_BACK = "MENU_SCOREBOARD",
	BUTTON_LSTICK = "MENU_SPRINT_HOLD_BREATH",
	BUTTON_RSTICK = "MENU_MELEE_ATTACK"
}
CoD.ButtonLayout.ButtonStrings[CoD.BUTTONS_EXPERIMENTAL + 1] = {
	BUTTON_A = "MENU_JUMP",
	BUTTON_B = "MENU_MELEE_ATTACK",
	BUTTON_X = "MENU_USE_RELOAD",
	BUTTON_Y = "MENU_SWITCH_WEAPON",
	BUTTON_LBUMP = CoD.ButtonLayout.SpecialGrenadeString,
	BUTTON_RBUMP = CoD.ButtonLayout.FragGrenadeString,
	BUTTON_UP = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.MPZM("MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_LTRIG = "MENU_AIM_DOWN_SIGHT",
	BUTTON_RTRIG = "MENU_FIRE_WEAPON",
	BUTTON_START = "MENU_OBJECTIVES_MENU",
	BUTTON_BACK = "MENU_SCOREBOARD",
	BUTTON_LSTICK = "MENU_SPRINT_HOLD_BREATH",
	BUTTON_RSTICK = "MENU_CROUCH_PRONE"
}
CoD.ButtonLayout.ButtonStrings[CoD.BUTTONS_LEFTY + 1] = {
	BUTTON_A = "MENU_JUMP",
	BUTTON_B = "MENU_CROUCH_PRONE",
	BUTTON_X = "MENU_USE_RELOAD",
	BUTTON_Y = "MENU_SWITCH_WEAPON",
	BUTTON_LBUMP = CoD.ButtonLayout.FragGrenadeString,
	BUTTON_RBUMP = CoD.ButtonLayout.SpecialGrenadeString,
	BUTTON_UP = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.MPZM("MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_LTRIG = "MENU_FIRE_WEAPON",
	BUTTON_RTRIG = "MENU_AIM_DOWN_SIGHT",
	BUTTON_START = "MENU_OBJECTIVES_MENU",
	BUTTON_BACK = "MENU_SCOREBOARD",
	BUTTON_LSTICK = "MENU_MELEE_ATTACK",
	BUTTON_RSTICK = "MENU_SPRINT_HOLD_BREATH"
}
CoD.ButtonLayout.ButtonStrings[CoD.BUTTONS_NOMAD + 1] = {
	BUTTON_A = "MENU_JUMP",
	BUTTON_B = "MENU_MELEE_ATTACK",
	BUTTON_X = "MENU_USE_RELOAD",
	BUTTON_Y = "MENU_SWITCH_WEAPON",
	BUTTON_LBUMP = CoD.ButtonLayout.SpecialGrenadeString,
	BUTTON_RBUMP = CoD.ButtonLayout.FragGrenadeString,
	BUTTON_UP = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.MPZM("MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_LTRIG = "MENU_TOGGLE_AIM_DOWN_THE_SIGHT",
	BUTTON_RTRIG = "MENU_FIRE_WEAPON",
	BUTTON_START = "MENU_OBJECTIVES_MENU",
	BUTTON_BACK = "MENU_SCOREBOARD",
	BUTTON_LSTICK = "MENU_SPRINT_HOLD_BREATH",
	BUTTON_RSTICK = "MENU_CROUCH_PRONE"
}
CoD.ButtonLayout.ButtonStrings[CoD.BUTTONS_CHARLIE + 1] = {
	BUTTON_A = "MENU_JUMP",
	BUTTON_B = "MENU_CROUCH_PRONE",
	BUTTON_X = "MENU_USE_RELOAD",
	BUTTON_Y = "MENU_SWITCH_WEAPON",
	BUTTON_LBUMP = CoD.ButtonLayout.SpecialGrenadeString,
	BUTTON_RBUMP = "MENU_TOGGLE_AIM_DOWN_THE_SIGHT",
	BUTTON_UP = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.MPZM("MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_LTRIG = CoD.ButtonLayout.FragGrenadeString,
	BUTTON_RTRIG = "MENU_FIRE_WEAPON",
	BUTTON_START = "MENU_OBJECTIVES_MENU",
	BUTTON_BACK = "MENU_SCOREBOARD",
	BUTTON_LSTICK = "MENU_SPRINT_HOLD_BREATH",
	BUTTON_RSTICK = "MENU_MELEE_ATTACK"
}
CoD.ButtonLayout.ButtonStrings[CoD.BUTTONS_DEFAULT_ALT + 1] = {
	BUTTON_A = "",
	BUTTON_B = "",
	BUTTON_X = "",
	BUTTON_Y = "",
	BUTTON_LBUMP = "",
	BUTTON_RBUMP = "",
	BUTTON_UP = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.MPZM("MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_LTRIG = "",
	BUTTON_RTRIG = "",
	BUTTON_START = "MENU_OBJECTIVES_MENU",
	BUTTON_BACK = "MENU_SCOREBOARD",
	BUTTON_LSTICK = "",
	BUTTON_RSTICK = ""
}
CoD.ButtonLayout.ButtonStrings[CoD.BUTTONS_EXPERIMENTAL_ALT + 1] = {
	BUTTON_A = "",
	BUTTON_B = "",
	BUTTON_X = "",
	BUTTON_Y = "",
	BUTTON_LBUMP = "",
	BUTTON_RBUMP = "",
	BUTTON_UP = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.MPZM("MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_LTRIG = "",
	BUTTON_RTRIG = "",
	BUTTON_START = "MENU_OBJECTIVES_MENU",
	BUTTON_BACK = "MENU_SCOREBOARD",
	BUTTON_LSTICK = "",
	BUTTON_RSTICK = ""
}
CoD.ButtonLayout.ButtonStrings[CoD.BUTTONS_LEFTY_ALT + 1] = {
	BUTTON_A = "",
	BUTTON_B = "",
	BUTTON_X = "",
	BUTTON_Y = "",
	BUTTON_LBUMP = "",
	BUTTON_RBUMP = "",
	BUTTON_UP = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.MPZM("MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_LTRIG = "",
	BUTTON_RTRIG = "",
	BUTTON_START = "MENU_OBJECTIVES_MENU",
	BUTTON_BACK = "MENU_SCOREBOARD",
	BUTTON_LSTICK = "",
	BUTTON_RSTICK = ""
}
CoD.ButtonLayout.ButtonStrings[CoD.BUTTONS_NOMAD_ALT + 1] = {
	BUTTON_A = "",
	BUTTON_B = "",
	BUTTON_X = "",
	BUTTON_Y = "",
	BUTTON_LBUMP = "",
	BUTTON_RBUMP = "",
	BUTTON_UP = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_ACCESS_EQUIPMENT_INVENTORY"),
	BUTTON_DOWN = CoD.MPZM("MENU_SCORESTREAK_SELECTION", "MENU_NONE"),
	BUTTON_LEFT = "MENU_ATTACHMENTS",
	BUTTON_RIGHT = CoD.MPZM("MENU_USE_SCORESTREAK", "MENU_EQUIP_CLAYMORES"),
	BUTTON_LTRIG = "",
	BUTTON_RTRIG = "",
	BUTTON_START = "MENU_OBJECTIVES_MENU",
	BUTTON_BACK = "MENU_SCOREBOARD",
	BUTTON_LSTICK = "",
	BUTTON_RSTICK = ""
}
CoD.ButtonLayout.TheaterButtonStrings = {}
CoD.ButtonLayout.TheaterButtonStrings[CoD.DEMO_CONTROLLER_CONFIG_DEFAULT + 1] = {
	BUTTON_A = "MENU_DEMO_CONTROLS_PLAY_PAUSE",
	BUTTON_B = "MENU_DEMO_CONTROLS_TOGGLE_HUD",
	BUTTON_X = "MENU_DEMO_CONTROLS_RECORD",
	BUTTON_Y = "MENU_DEMO_CONTROLS_SWITCH_CAMERA",
	BUTTON_LBUMP = "MENU_DEMO_CONTROLS_PREV_PLAYER",
	BUTTON_RBUMP = "MENU_DEMO_CONTROLS_NEXT_PLAYER",
	BUTTON_UP = "",
	BUTTON_DOWN = "",
	BUTTON_LEFT = "",
	BUTTON_RIGHT = "MENU_DEMO_CONTROLS_JUMP_FORWARD",
	BUTTON_LTRIG = "MENU_DEMO_CONTROLS_JUMP_BACK",
	BUTTON_RTRIG = "MENU_DEMO_CONTROLS_PLAYBACK_SPEED",
	BUTTON_START = "MENU_DEMO_CONTROLS_PAUSE_MENU",
	BUTTON_BACK = "MENU_SCOREBOARD",
	BUTTON_LSTICK = "MENU_DEMO_CONTROLS_TOGGLE_CONTROLS",
	BUTTON_RSTICK = ""
}
CoD.ButtonLayout.TheaterButtonStrings[CoD.DEMO_CONTROLLER_CONFIG_DIGITAL + 1] = {
	BUTTON_A = "MENU_DEMO_CONTROLS_PLAY_PAUSE",
	BUTTON_B = "MENU_DEMO_CONTROLS_TOGGLE_HUD",
	BUTTON_X = "MENU_DEMO_CONTROLS_RECORD",
	BUTTON_Y = "MENU_DEMO_CONTROLS_SWITCH_CAMERA",
	BUTTON_LBUMP = "MENU_DEMO_CONTROLS_PREV_PLAYER",
	BUTTON_RBUMP = "MENU_DEMO_CONTROLS_NEXT_PLAYER",
	BUTTON_UP = "",
	BUTTON_DOWN = "",
	BUTTON_LEFT = "MENU_DEMO_CONTROLS_JUMP_BACK",
	BUTTON_RIGHT = "MENU_DEMO_CONTROLS_JUMP_FORWARD",
	BUTTON_LTRIG = "MENU_DEMO_CONTROLS_SLOW_MO",
	BUTTON_RTRIG = "MENU_DEMO_CONTROLS_FAST_MO",
	BUTTON_START = "MENU_DEMO_CONTROLS_PAUSE_MENU",
	BUTTON_BACK = "MENU_SCOREBOARD",
	BUTTON_LSTICK = "MENU_DEMO_CONTROLS_TOGGLE_CONTROLS",
	BUTTON_RSTICK = ""
}
CoD.ButtonLayout.TheaterButtonStrings[CoD.DEMO_CONTROLLER_CONFIG_BADBOT + 1] = {
	BUTTON_A = "MENU_DEMO_CONTROLS_PLAY_PAUSE",
	BUTTON_B = "MENU_DEMO_CONTROLS_TOGGLE_HUD",
	BUTTON_X = "MENU_DEMO_CONTROLS_RECORD",
	BUTTON_Y = "MENU_DEMO_CONTROLS_SWITCH_CAMERA",
	BUTTON_LBUMP = "MENU_DEMO_CONTROLS_PREV_PLAYER",
	BUTTON_RBUMP = "MENU_DEMO_CONTROLS_NEXT_PLAYER",
	BUTTON_UP = "MENU_DEMO_CONTROLS_INCREASE_PLAYBACK_SPEED_SMALL",
	BUTTON_DOWN = "MENU_DEMO_CONTROLS_DECREASE_PLAYBACK_SPEED_SMALL",
	BUTTON_LEFT = "MENU_DEMO_CONTROLS_DECREASE_PLAYBACK_SPEED_LARGE",
	BUTTON_RIGHT = "MENU_DEMO_CONTROLS_INCREASE_PLAYBACK_SPEED_LARGE",
	BUTTON_LTRIG = "MENU_DEMO_CONTROLS_JUMP_BACK",
	BUTTON_RTRIG = "MENU_DEMO_CONTROLS_JUMP_FORWARD",
	BUTTON_START = "MENU_DEMO_CONTROLS_PAUSE_MENU",
	BUTTON_BACK = "MENU_SCOREBOARD",
	BUTTON_LSTICK = "MENU_DEMO_CONTROLS_TOGGLE_CONTROLS",
	BUTTON_RSTICK = ""
}
CoD.ButtonLayout.GetProfileVar = function (f1_arg0)
	local f1_local0 = "gpad_buttonsConfig"
	if UIExpression.IsDemoPlaying(f1_arg0) ~= 0 then
		f1_local0 = "demo_controllerconfig"
	elseif CoD.isWIIU then
		local f1_local1 = UIExpression.GetControllerType(f1_arg0)
		if f1_local1 == "remote" then
			f1_local0 = "gpad_remoteButtonsConfig"
		elseif f1_local1 == "classic" then
			f1_local0 = "gpad_classicButtonsConfig"
		end
	end
	return f1_local0
end

CoD.ButtonLayout.SelectionChanged = function (f2_arg0)
	Engine.SetProfileVar(f2_arg0.parentSelectorButton.m_currentController, f2_arg0.parentSelectorButton.m_profileVarName, f2_arg0.value)
	f2_arg0.parentSelectorButton:dispatchEventToParent({
		name = "button_layout_selection_changed",
		choiceParams = f2_arg0
	})
end

CoD.ButtonLayout.TriggerSelectionChanged = function (f3_arg0)
	Engine.SetProfileVar(f3_arg0.parentSelectorButton.m_currentController, f3_arg0.parentSelectorButton.m_profileVarName, f3_arg0.value)
	f3_arg0.parentSelectorButton:dispatchEventToParent({
		name = "button_layout_selection_changed",
		controller = f3_arg0.controller
	})
end

CoD.ButtonLayout.Button_AddChoices = function (f4_arg0, f4_arg1)
	if f4_arg0.strings == nil or #f4_arg0.strings == 0 then
		return 
	end
	for f4_local0 = 1, #f4_arg0.strings, 1 do
		f4_arg0:addChoice(f4_arg0.strings[f4_local0], f4_arg0.values[f4_local0], nil, f4_arg1)
	end
end

CoD.ButtonLayout.AddChoices = function (f5_arg0, f5_arg1)
	if UIExpression.IsDemoPlaying(f5_arg1) ~= 0 then
		if CoD.isWIIU then
			local f5_local0 = {}
			local f5_local1 = UIExpression.ToUpper(nil, Engine.Localize("MENU_DEMO_CONTROLS_DEFAULT"))
			local f5_local2 = UIExpression.ToUpper(nil, Engine.Localize("MENU_DEMO_CONTROLS_BADBOT"))
			f5_arg0.strings = f5_local1
			f5_arg0.values = {
				CoD.DEMO_CONTROLLER_CONFIG_DIGITAL,
				CoD.DEMO_CONTROLLER_CONFIG_BADBOT
			}
		else
			local f5_local0 = {}
			local f5_local1 = UIExpression.ToUpper(nil, Engine.Localize("MENU_DEMO_CONTROLS_DEFAULT"))
			local f5_local2 = UIExpression.ToUpper(nil, Engine.Localize("MENU_DEMO_CONTROLS_DIGITAL"))
			local f5_local3 = UIExpression.ToUpper(nil, Engine.Localize("MENU_DEMO_CONTROLS_BADBOT"))
			f5_arg0.strings = f5_local1
			f5_arg0.values = {
				CoD.DEMO_CONTROLLER_CONFIG_DEFAULT,
				CoD.DEMO_CONTROLLER_CONFIG_DIGITAL,
				CoD.DEMO_CONTROLLER_CONFIG_BADBOT
			}
		end
	elseif CoD.isWIIU then
		local f5_local0 = UIExpression.GetControllerType(f5_arg1)
		if f5_local0 == "remote" then
			f5_arg0.strings = CoD.WiiUControllerSettings.ButtonLayouts.remote.strings
			f5_arg0.values = CoD.WiiUControllerSettings.ButtonLayouts.remote.values
		elseif f5_local0 == "classic" then
			f5_arg0.strings = CoD.WiiUControllerSettings.ButtonLayouts.classic.strings
			f5_arg0.values = CoD.WiiUControllerSettings.ButtonLayouts.classic.values
		else
			f5_arg0.strings = CoD.WiiUControllerSettings.ButtonLayouts.gamepad.strings
			f5_arg0.values = CoD.WiiUControllerSettings.ButtonLayouts.gamepad.values
		end
	else
		local f5_local0 = {}
		local f5_local1 = Engine.Localize("MENU_DEFAULT_CAPS")
		local f5_local2 = Engine.Localize("MENU_TACTICAL_CAPS")
		local f5_local3 = Engine.Localize("MENU_LEFTY_CAPS")
		local f5_local4 = Engine.Localize("MENU_NOMAD")
		local f5_local5 = Engine.Localize("MENU_CHARLIE_CAPS")
		f5_arg0.strings = f5_local1
		f5_arg0.values = {
			CoD.BUTTONS_DEFAULT,
			CoD.BUTTONS_EXPERIMENTAL,
			CoD.BUTTONS_LEFTY,
			CoD.BUTTONS_NOMAD,
			CoD.BUTTONS_CHARLIE
		}
	end
	CoD.ButtonLayout.Button_AddChoices(f5_arg0, CoD.ButtonLayout.SelectionChanged)
end

CoD.ButtonLayout.CloseMenu = function (f6_arg0)
	if UIExpression.IsInGame() == 1 then
		Engine.Exec(f6_arg0:getOwner(), "updateVehicleBindings")
	end
	CoD.Options.Close(f6_arg0)
end

CoD.ButtonLayout.StreamedImageReady = function (f7_arg0, f7_arg1)
	f7_arg0:beginAnimation("fade_in", 250)
	f7_arg0:setAlpha(1)
end

LUI.createMenu.ButtonLayout = function (f8_arg0, f8_arg1)
	local f8_local0, f8_local1 = nil
	local f8_local2 = UIExpression.IsDemoPlaying(f8_arg0) ~= 0
	if UIExpression.IsInGame() == 1 then
		if f8_local2 then
			f8_local1 = Engine.Localize("MENU_THEATER_BUTTON_LAYOUT_CAPS")
		else
			f8_local1 = Engine.Localize("MENU_BUTTON_LAYOUT_CAPS")
		end
		f8_local0 = CoD.InGameMenu.New("ButtonLayout", f8_arg0, f8_local1, CoD.isSinglePlayer)
		if CoD.isSinglePlayer == false and UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
			f8_local0:sizeToSafeArea(f8_arg0)
			f8_local0:updateTitleForSplitscreen()
			f8_local0:updateButtonPromptBarsForSplitscreen()
		end
	else
		f8_local0 = CoD.Menu.New("ButtonLayout")
		f8_local0:setOwner(f8_arg0)
		f8_local0:addTitle(Engine.Localize("MENU_BUTTON_LAYOUT_CAPS"))
		if CoD.isSinglePlayer == false then
			f8_local0:addLargePopupBackground()
			f8_local0:registerEventHandler("signed_out", CoD.Options.SignedOut_MPZM)
		end
	end
	f8_local0.close = CoD.ButtonLayout.CloseMenu
	f8_local0.controller = f8_arg0
	f8_local0:addBackButton()
	f8_local0:registerEventHandler("button_layout_selection_changed", CoD.ButtonLayout.ButtonLayoutSelectionChanged)
	local f8_local3 = 0
	if UIExpression.IsInGame() == 1 and CoD.isSinglePlayer == false and Engine.IsSplitscreen() == true then
		f8_local3 = CoD.Menu.SplitscreenSideOffset
	end
	f8_local0.buttonLayoutButtonList = CoD.ButtonList.new()
	f8_local0.buttonLayoutButtonList:setLeftRight(true, false, f8_local3, f8_local3 + CoD.ButtonList.DefaultWidth - 20)
	f8_local0.buttonLayoutButtonList:setTopBottom(true, false, CoD.Menu.TitleHeight, CoD.Menu.TitleHeight + 720)
	if CoD.isPC then
		f8_local0.buttonLayoutButtonList:setLeftRight(true, false, f8_local3, f8_local3 + 500)
	end
	if CoD.isSinglePlayer and not CoD.isPS3 then
		f8_local0:addElement(f8_local0.buttonLayoutButtonList)
		if f8_arg1 and f8_arg1.height ~= nil then
			f8_local0.buttonLayoutButtonList:setLeftRight(false, false, -CoD.Options.Width / 2, CoD.Options.Width / 2)
			f8_local0.buttonLayoutButtonList:setTopBottom(false, false, -f8_arg1.height / 2, f8_arg1.height / 2)
		end
	else
		local f8_local4 = CoD.SplitscreenScaler.new(nil, 1.5)
		f8_local4:setLeftRight(true, false, 0, 0)
		f8_local4:setTopBottom(true, false, 0, 0)
		f8_local0:addElement(f8_local4)
		f8_local4:addElement(f8_local0.buttonLayoutButtonList)
	end
	local f8_local4 = CoD.ButtonLayout.GetProfileVar(f8_arg0)
	f8_local0.buttonLayoutSelector = f8_local0.buttonLayoutButtonList:addProfileLeftRightSelector(f8_arg0, Engine.Localize("MENU_BUTTON_LAYOUT_CAPS"), f8_local4)
	CoD.ButtonLayout.AddChoices(f8_local0.buttonLayoutSelector, f8_arg0)
	if CoD.isPS3 and not f8_local2 then
		f8_local0.buttonFlippedSelector = f8_local0.buttonLayoutButtonList:addProfileLeftRightSelector(f8_arg0, Engine.Localize("MENU_TRIGGER_CONFIG_CAPS"), "flipped_control_config")
		local f8_local5 = f8_local0.buttonFlippedSelector
		local f8_local6 = {}
		local f8_local7 = Engine.Localize("MENU_DEFAULT_CAPS")
		local f8_local8 = Engine.Localize("MENU_FLIPPED_CAPS")
		f8_local5.strings = f8_local7
		f8_local0.buttonFlippedSelector.values = {
			CoD.TRIGGERS_DEFAULT,
			CoD.TRIGGERS_FLIPPED
		}
		CoD.ButtonLayout.Button_AddChoices(f8_local0.buttonFlippedSelector, CoD.ButtonLayout.TriggerSelectionChanged)
	end
	f8_local0.buttonLayoutImageContainer = LUI.UIElement.new()
	f8_local0.buttonLayoutImageContainer:setLeftRight(false, false, 0, 0)
	f8_local0.buttonLayoutImageContainer:setTopBottom(false, false, -50, -50)
	f8_local0.buttonLayoutImageContainer.priority = -100
	f8_local0.buttonLayoutImageContainer.isTheaterButtonlayout = f8_local2
	f8_local0:addElement(f8_local0.buttonLayoutImageContainer)
	local f8_local5 = nil
	if CoD.isPS3 then
		f8_local5 = "ps3_controller_top"
	elseif CoD.isWIIU then
		local f8_local6 = UIExpression.GetControllerType(f8_arg0)
		if f8_local6 == "classic" then
			f8_local5 = "wiiu_ccp_top"
		elseif f8_local6 == "uc" then
			f8_local5 = "wiiu_uc_top"
		else
			f8_local5 = "wiiu_drc_top"
		end
	else
		f8_local5 = "xenon_controller_top"
	end
	if CoD.isPS3 == true or CoD.isXBOX == true then
		f8_local0.controllerImage = LUI.UIStreamedImage.new()
		f8_local0.controllerImage:setAlpha(0)
		f8_local0.controllerImage:registerEventHandler("streamed_image_ready", CoD.ButtonLayout.StreamedImageReady)
	else
		f8_local0.controllerImage = LUI.UIImage.new()
	end
	f8_local0.controllerImage:setLeftRight(false, false, -250, 250)
	f8_local0.controllerImage:setTopBottom(false, false, -175, 325)
	f8_local0.controllerImage:setImage(RegisterMaterial(f8_local5))
	f8_local0.buttonLayoutImageContainer:addElement(f8_local0.controllerImage)
	CoD.ButtonLayout.AddLinesAndLabels(f8_local0.buttonLayoutImageContainer, f8_arg0)
	CoD.ButtonLayout.UpdateButtonLinesAndLabels(f8_local0.buttonLayoutImageContainer, UIExpression.ProfileValueAsString(f8_arg0, f8_local4), f8_arg0)
	f8_local0.buttonLayoutSelector:processEvent({
		name = "gain_focus"
	})
	if CoD.isWIIU then
		CoD.WiiUControllerSettings.SetCloseIfControllerChanges(f8_local0)
	end
	return f8_local0
end

CoD.ButtonLayout.AddLine = function (f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = CoD.Line.new(f9_arg1, f9_arg2, CoD.ButtonLayout.LineWidth, CoD.ButtonLayout.LineColor)
	f9_arg0:addElement(f9_local0)
	return f9_local0
end

CoD.ButtonLayout.AddLeftAlignLabel = function (f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = LUI.UIText.new()
	f10_local0:setLeftRight(true, false, f10_arg1, f10_arg1 + 1)
	f10_local0:setTopBottom(true, false, f10_arg2, f10_arg2 + CoD.textSize.Default)
	f10_local0:setRGB(CoD.ButtonLayout.LineColor[1], CoD.ButtonLayout.LineColor[2], CoD.ButtonLayout.LineColor[3])
	f10_local0:setFont(CoD.fonts.Default)
	f10_arg0:addElement(f10_local0)
	return f10_local0
end

CoD.ButtonLayout.AddRightAlignLabel = function (f11_arg0, f11_arg1, f11_arg2)
	local f11_local0 = LUI.UIText.new()
	f11_local0:setLeftRight(false, true, f11_arg1, f11_arg1 - 1)
	f11_local0:setTopBottom(true, false, f11_arg2, f11_arg2 + CoD.textSize.Default)
	f11_local0:setRGB(CoD.ButtonLayout.LineColor[1], CoD.ButtonLayout.LineColor[2], CoD.ButtonLayout.LineColor[3])
	f11_local0:setFont(CoD.fonts.Default)
	f11_arg0:addElement(f11_local0)
	return f11_local0
end

CoD.ButtonLayout.AddCenterAlignLabel = function (f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = LUI.UIText.new()
	f12_local0:setLeftRight(false, false, f12_arg1 - 1, f12_arg1 + 1)
	f12_local0:setTopBottom(true, false, f12_arg2, f12_arg2 + CoD.textSize.Default)
	f12_local0:setRGB(CoD.ButtonLayout.LineColor[1], CoD.ButtonLayout.LineColor[2], CoD.ButtonLayout.LineColor[3])
	f12_local0:setFont(CoD.fonts.Default)
	f12_arg0:addElement(f12_local0)
	return f12_local0
end

CoD.ButtonLayout.AddLinesAndLabels = function (f13_arg0, f13_arg1)
	if CoD.isPS3 then
		CoD.ButtonLayout.AddPS3LinesAndLabels(f13_arg0, f13_arg1)
	elseif CoD.isWIIU then
		CoD.ButtonLayout.AddWiiULinesAndLabels(f13_arg0, f13_arg1)
	else
		CoD.ButtonLayout.AddXenonLinesAndLabels(f13_arg0)
	end
end

CoD.ButtonLayout.UpdateButtonLinesAndLabels = function (f14_arg0, f14_arg1, f14_arg2)
	if f14_arg0 == nil then
		return 
	elseif CoD.isWIIU then
		CoD.WiiUButtonLayout.UpdateButtonLinesAndLabels(f14_arg0, f14_arg1)
		return 
	end
	local f14_local0 = nil
	if UIExpression.IsDemoPlaying(f14_arg2) ~= 0 then
		f14_local0 = true
	else
		f14_local0 = UIExpression.ProfileBool(f14_arg2, "flipped_control_config")
	end
	for f14_local6, f14_local7 in pairs(CoD.ButtonLayout.ButtonRefs) do
		local f14_local4 = f14_local7
		if CoD.isPS3 and f14_local0 == 0 then
			if f14_local7 == "BUTTON_LTRIG" then
				f14_local4 = "BUTTON_LBUMP"
			end
			if f14_local7 == "BUTTON_RTRIG" then
				f14_local4 = "BUTTON_RBUMP"
			end
			if f14_local7 == "BUTTON_LBUMP" then
				f14_local4 = "BUTTON_LTRIG"
			end
			if f14_local7 == "BUTTON_RBUMP" then
				f14_local4 = "BUTTON_RTRIG"
			end
		end
		if f14_arg0.buttonLabels ~= nil and f14_arg0.buttonLabels[f14_local4] ~= nil then
			local f14_local5 = nil
			if f14_arg0.isTheaterButtonlayout then
				f14_local5 = CoD.ButtonLayout.TheaterButtonStrings[f14_arg1 + 1][f14_local4]
			else
				f14_local5 = CoD.ButtonLayout.ButtonStrings[f14_arg1 + 1][f14_local4]
			end
			if f14_arg0.buttonLines[f14_local7] then
				if f14_local5 ~= "" then
					f14_arg0.buttonLines[f14_local7]:setAlpha(1)
				else
					f14_arg0.buttonLines[f14_local7]:setAlpha(0)
				end
			end
			f14_arg0.buttonLabels[f14_local7]:setText(Engine.Localize(f14_local5))
		end
	end
end

CoD.ButtonLayout.ButtonLayoutSelectionChanged = function (f15_arg0, f15_arg1)
	CoD.ButtonLayout.UpdateButtonLinesAndLabels(f15_arg0.buttonLayoutImageContainer, UIExpression.ProfileValueAsString(f15_arg0.m_ownerController, CoD.ButtonLayout.GetProfileVar(f15_arg0.m_ownerController)), f15_arg1.controller)
end

CoD.ButtonLayout.AddPS3LinesAndLabels = function (f16_arg0, f16_arg1)
	f16_arg0.buttonLabels = {}
	f16_arg0.buttonLines = {}
	local f16_local0 = -10
	local f16_local1 = function (f19_arg0)
		return f19_arg0 * 0.98 - 250
	end

	local f16_local2 = function (f20_arg0)
		return f20_arg0 * 0.98 - 175
	end

	local f16_local3 = f16_local1(460)
	local f16_local4 = f16_local2(345)
	local f16_local5 = f16_arg0.buttonLines
	local f16_local6 = CoD.ButtonLayout.AddLine
	local f16_local7 = f16_arg0
	local f16_local8 = {}
	local f16_local9 = f16_local1(395)
	local f16_local10 = f16_local2(300)
	f16_local5.BUTTON_A = f16_local6(f16_local7, f16_local9, {
		f16_local3,
		f16_local4
	})
	f16_arg0.buttonLabels.BUTTON_A = CoD.ButtonLayout.AddLeftAlignLabel(f16_arg0, f16_local3 + 5, f16_local4 + f16_local0)
	f16_local5 = f16_local1(460)
	f16_local6 = f16_local2(272)
	f16_local7 = f16_arg0.buttonLines
	f16_local8 = CoD.ButtonLayout.AddLine
	f16_local9 = f16_arg0
	f16_local10 = {}
	local f16_local11 = f16_local1(425)
	local f16_local12 = f16_local2(272)
	f16_local7.BUTTON_B = f16_local8(f16_local9, f16_local11, {
		f16_local5,
		f16_local6
	})
	f16_arg0.buttonLabels.BUTTON_B = CoD.ButtonLayout.AddLeftAlignLabel(f16_arg0, f16_local5 + 5, f16_local6 + f16_local0)
	f16_local7 = f16_local1(460)
	f16_local8 = f16_local2(310)
	f16_local9 = f16_arg0.buttonLines
	f16_local10 = CoD.ButtonLayout.AddLine
	f16_local11 = f16_arg0
	f16_local12 = {}
	local f16_local13 = f16_local1(360)
	local f16_local14 = f16_local2(272)
	f16_local9.BUTTON_X = f16_local10(f16_local11, f16_local13, {
		f16_local7,
		f16_local8
	})
	f16_arg0.buttonLabels.BUTTON_X = CoD.ButtonLayout.AddLeftAlignLabel(f16_arg0, f16_local7 + 5, f16_local8 + f16_local0)
	f16_local9 = f16_local1(460)
	f16_local10 = f16_local2(245)
	f16_local11 = f16_arg0.buttonLines
	f16_local12 = CoD.ButtonLayout.AddLine
	f16_local13 = f16_arg0
	f16_local14 = {}
	local f16_local15 = f16_local1(395)
	local f16_local16 = f16_local2(245)
	f16_local11.BUTTON_Y = f16_local12(f16_local13, f16_local15, {
		f16_local9,
		f16_local10
	})
	f16_arg0.buttonLabels.BUTTON_Y = CoD.ButtonLayout.AddLeftAlignLabel(f16_arg0, f16_local9 + 5, f16_local10 + f16_local0)
	f16_local11 = f16_local1(65)
	f16_local12 = f16_local2(175)
	f16_local13 = f16_arg0.buttonLines
	f16_local14 = CoD.ButtonLayout.AddLine
	f16_local15 = f16_arg0
	f16_local16 = {
		f16_local11,
		f16_local12
	}
	local f16_local17 = {}
	local f16_local18 = f16_local1(105)
	local f16_local19 = f16_local2(175)
	f16_local13.BUTTON_LBUMP = f16_local14(f16_local15, f16_local16, f16_local18)
	f16_arg0.buttonLabels.BUTTON_LBUMP = CoD.ButtonLayout.AddRightAlignLabel(f16_arg0, f16_local11 - 5, f16_local12 + f16_local0)
	f16_local13 = f16_local1(445)
	f16_local14 = f16_local2(175)
	f16_local15 = f16_arg0.buttonLines
	f16_local16 = CoD.ButtonLayout.AddLine
	f16_local17 = f16_arg0
	f16_local18 = {}
	f16_local19 = f16_local1(405)
	local f16_local20 = f16_local2(175)
	f16_local15.BUTTON_RBUMP = f16_local16(f16_local17, f16_local19, {
		f16_local13,
		f16_local14
	})
	f16_arg0.buttonLabels.BUTTON_RBUMP = CoD.ButtonLayout.AddLeftAlignLabel(f16_arg0, f16_local13 + 5, f16_local14 + f16_local0)
	if not CoD.isSinglePlayer then
		f16_local15 = f16_local1(50)
		f16_local16 = f16_local2(250)
		f16_local17 = f16_arg0.buttonLines
		f16_local18 = CoD.ButtonLayout.AddLine
		f16_local19 = f16_arg0
		f16_local20 = {
			f16_local15,
			f16_local16
		}
		local f16_local21 = {}
		local f16_local22 = f16_local1(115)
		local f16_local23 = f16_local2(250)
		f16_local17.BUTTON_UP = f16_local18(f16_local19, f16_local20, f16_local22)
		f16_arg0.buttonLabels.BUTTON_UP = CoD.ButtonLayout.AddRightAlignLabel(f16_arg0, f16_local15 - 5, f16_local16 + f16_local0)
	end
	if not CoD.isSinglePlayer then
		f16_local15 = f16_local1(50)
		f16_local16 = f16_local2(345)
		f16_local17 = f16_arg0.buttonLines
		f16_local18 = CoD.ButtonLayout.AddLine
		f16_local19 = f16_arg0
		f16_local20 = {
			f16_local15,
			f16_local16
		}
		local f16_local21 = {}
		local f16_local22 = f16_local1(115)
		local f16_local23 = f16_local2(300)
		f16_local17.BUTTON_DOWN = f16_local18(f16_local19, f16_local20, f16_local22)
		f16_arg0.buttonLabels.BUTTON_DOWN = CoD.ButtonLayout.AddRightAlignLabel(f16_arg0, f16_local15 - 5, f16_local16 + f16_local0)
	end
	f16_local15 = f16_local1(50)
	f16_local16 = f16_local2(274)
	f16_local17 = f16_arg0.buttonLines
	f16_local18 = CoD.ButtonLayout.AddLine
	f16_local19 = f16_arg0
	f16_local20 = {
		f16_local15,
		f16_local16
	}
	local f16_local21 = {}
	local f16_local22 = f16_local1(94)
	local f16_local23 = f16_local2(274)
	f16_local17.BUTTON_LEFT = f16_local18(f16_local19, f16_local20, f16_local22)
	f16_arg0.buttonLabels.BUTTON_LEFT = CoD.ButtonLayout.AddRightAlignLabel(f16_arg0, f16_local15 - 5, f16_local16 + f16_local0)
	if not CoD.isSinglePlayer then
		f16_local17 = f16_local1(50)
		f16_local18 = f16_local2(310)
		f16_local19 = f16_arg0.buttonLines
		f16_local20 = CoD.ButtonLayout.AddLine
		f16_local21 = f16_arg0
		f16_local22 = {}
		f16_local23 = f16_local1(140)
		local f16_local24 = f16_local2(274)
		f16_local19.BUTTON_RIGHT = f16_local20(f16_local21, f16_local23, {
			f16_local17,
			f16_local18
		})
		f16_arg0.buttonLabels.BUTTON_RIGHT = CoD.ButtonLayout.AddRightAlignLabel(f16_arg0, f16_local17 - 5, f16_local18 + f16_local0)
	end
	f16_local17 = -160
	f16_local18 = -70
	f16_local19 = f16_arg0.buttonLines
	f16_local20 = CoD.ButtonLayout.AddLine
	f16_local21 = f16_arg0
	f16_local22 = {
		f16_local17,
		f16_local18
	}
	f16_local23 = {}
	local f16_local24 = f16_local1(135)
	local f16_local25 = f16_local2(145)
	f16_local19.BUTTON_LTRIG = f16_local20(f16_local21, f16_local22, f16_local24)
	f16_arg0.buttonLabels.BUTTON_LTRIG = CoD.ButtonLayout.AddRightAlignLabel(f16_arg0, f16_local17 - 5, f16_local18 + f16_local0)
	f16_local19 = 160
	f16_local20 = -70
	f16_local21 = f16_arg0.buttonLines
	f16_local22 = CoD.ButtonLayout.AddLine
	f16_local23 = f16_arg0
	f16_local24 = {}
	f16_local25 = f16_local1(375)
	local f16_local26 = f16_local2(145)
	f16_local21.BUTTON_RTRIG = f16_local22(f16_local23, f16_local25, {
		f16_local19,
		f16_local20
	})
	f16_arg0.buttonLabels.BUTTON_RTRIG = CoD.ButtonLayout.AddLeftAlignLabel(f16_arg0, f16_local19 + 5, f16_local20 + f16_local0)
	if not CoD.isSinglePlayer then
		f16_local21 = f16_local1(220)
		f16_local22 = f16_local2(110)
		f16_local23 = f16_arg0.buttonLines
		f16_local24 = CoD.ButtonLayout.AddLine
		f16_local25 = f16_arg0
		f16_local26 = {}
		local f16_local27 = f16_local1(220)
		local f16_local28 = f16_local2(256)
		f16_local23.BUTTON_BACK = f16_local24(f16_local25, f16_local27, {
			f16_local21,
			f16_local22
		})
		f16_arg0.buttonLabels.BUTTON_BACK = CoD.ButtonLayout.AddCenterAlignLabel(f16_arg0, f16_local21, f16_local22 - CoD.textSize.Default)
	end
	f16_local21 = f16_local1(290)
	f16_local22 = f16_local2(140)
	f16_local23 = f16_arg0.buttonLines
	f16_local24 = CoD.ButtonLayout.AddLine
	f16_local25 = f16_arg0
	f16_local26 = {}
	local f16_local27 = f16_local1(290)
	local f16_local28 = f16_local2(256)
	f16_local23.BUTTON_START = f16_local24(f16_local25, f16_local27, {
		f16_local21,
		f16_local22
	})
	f16_arg0.buttonLabels.BUTTON_START = CoD.ButtonLayout.AddCenterAlignLabel(f16_arg0, f16_local21, f16_local22 - CoD.textSize.Default)
	f16_local23 = f16_local1(194)
	f16_local24 = f16_local2(405)
	f16_local25 = f16_arg0.buttonLines
	f16_local26 = CoD.ButtonLayout.AddLine
	f16_local27 = f16_arg0
	f16_local28 = {
		f16_local23,
		f16_local24
	}
	local f16_local29 = {}
	local f16_local30 = f16_local1(194)
	local f16_local31 = f16_local2(336)
	f16_local25.BUTTON_LSTICK = f16_local26(f16_local27, f16_local28, f16_local30)
	f16_arg0.buttonLabels.BUTTON_LSTICK = CoD.ButtonLayout.AddCenterAlignLabel(f16_arg0, f16_local23, f16_local24)
	f16_local25 = f16_local1(320)
	f16_local26 = f16_local2(375)
	f16_local27 = f16_arg0.buttonLines
	f16_local28 = CoD.ButtonLayout.AddLine
	f16_local29 = f16_arg0
	f16_local30 = {}
	f16_local31 = f16_local1(320)
	local f16_local32 = f16_local2(336)
	f16_local27.BUTTON_RSTICK = f16_local28(f16_local29, f16_local31, {
		f16_local25,
		f16_local26
	})
	f16_arg0.buttonLabels.BUTTON_RSTICK = CoD.ButtonLayout.AddCenterAlignLabel(f16_arg0, f16_local25, f16_local26)
end

CoD.ButtonLayout.AddWiiULinesAndLabels = function (f17_arg0, f17_arg1)
	CoD.WiiUButtonLayout.AddLinesAndLabels(f17_arg0, f17_arg1)
end

CoD.ButtonLayout.AddXenonLinesAndLabels = function (f18_arg0)
	f18_arg0.buttonLabels = {}
	f18_arg0.buttonLines = {}
	local f18_local0 = -10
	local f18_local1 = 200
	local f18_local2 = 130
	f18_arg0.buttonLines.BUTTON_A = CoD.ButtonLayout.AddLine(f18_arg0, {
		120,
		88
	}, {
		f18_local1,
		f18_local2
	})
	f18_arg0.buttonLabels.BUTTON_A = CoD.ButtonLayout.AddLeftAlignLabel(f18_arg0, f18_local1 + 5, f18_local2 + f18_local0)
	local f18_local3 = 200
	local f18_local4 = 60
	f18_arg0.buttonLines.BUTTON_B = CoD.ButtonLayout.AddLine(f18_arg0, {
		163,
		44
	}, {
		f18_local3,
		f18_local4
	})
	f18_arg0.buttonLabels.BUTTON_B = CoD.ButtonLayout.AddLeftAlignLabel(f18_arg0, f18_local3 + 5, f18_local4 + f18_local0)
	local f18_local5 = 205
	local f18_local6 = 95
	f18_arg0.buttonLines.BUTTON_X = CoD.ButtonLayout.AddLine(f18_arg0, {
		100,
		44
	}, {
		f18_local5,
		f18_local6
	})
	f18_arg0.buttonLabels.BUTTON_X = CoD.ButtonLayout.AddLeftAlignLabel(f18_arg0, f18_local5 + 5, f18_local6 + f18_local0)
	local f18_local7 = 195
	local f18_local8 = 25
	f18_arg0.buttonLines.BUTTON_Y = CoD.ButtonLayout.AddLine(f18_arg0, {
		132,
		10
	}, {
		f18_local7,
		f18_local8
	})
	f18_arg0.buttonLabels.BUTTON_Y = CoD.ButtonLayout.AddLeftAlignLabel(f18_arg0, f18_local7 + 5, f18_local8 + f18_local0)
	local f18_local9 = -170
	local f18_local10 = -23
	f18_arg0.buttonLines.BUTTON_LBUMP = CoD.ButtonLayout.AddLine(f18_arg0, {
		f18_local9,
		f18_local10
	}, {
		-130,
		-23
	})
	f18_arg0.buttonLabels.BUTTON_LBUMP = CoD.ButtonLayout.AddRightAlignLabel(f18_arg0, f18_local9 - 5, f18_local10 + f18_local0)
	local f18_local11 = 170
	local f18_local12 = -23
	f18_arg0.buttonLines.BUTTON_RBUMP = CoD.ButtonLayout.AddLine(f18_arg0, {
		130,
		-23
	}, {
		f18_local11,
		f18_local12
	})
	f18_arg0.buttonLabels.BUTTON_RBUMP = CoD.ButtonLayout.AddLeftAlignLabel(f18_arg0, f18_local11 + 5, f18_local12 + f18_local0)
	if not CoD.isSinglePlayer then
		local f18_local13 = -205
		local f18_local14 = 110
		f18_arg0.buttonLines.BUTTON_UP = CoD.ButtonLayout.AddLine(f18_arg0, {
			f18_local13,
			f18_local14
		}, {
			-62,
			95
		})
		f18_arg0.buttonLabels.BUTTON_UP = CoD.ButtonLayout.AddRightAlignLabel(f18_arg0, f18_local13 - 5, f18_local14 + f18_local0)
	end
	if not CoD.isSinglePlayer then
		local f18_local13 = -205
		local f18_local14 = 180
		f18_arg0.buttonLines.BUTTON_DOWN = CoD.ButtonLayout.AddLine(f18_arg0, {
			f18_local13,
			f18_local14
		}, {
			-62,
			140
		})
		f18_arg0.buttonLabels.BUTTON_DOWN = CoD.ButtonLayout.AddRightAlignLabel(f18_arg0, f18_local13 - 5, f18_local14 + f18_local0)
	end
	local f18_local13 = -210
	local f18_local14 = 145
	f18_arg0.buttonLines.BUTTON_LEFT = CoD.ButtonLayout.AddLine(f18_arg0, {
		f18_local13,
		f18_local14
	}, {
		-83,
		119
	})
	f18_arg0.buttonLabels.BUTTON_LEFT = CoD.ButtonLayout.AddRightAlignLabel(f18_arg0, f18_local13 - 5, f18_local14 + f18_local0)
	if not CoD.isSinglePlayer then
		local f18_local15 = -38
		local f18_local16 = 250
		f18_arg0.buttonLines.BUTTON_RIGHT = CoD.ButtonLayout.AddLine(f18_arg0, {
			-38,
			119
		}, {
			f18_local15,
			f18_local16
		})
		f18_arg0.buttonLabels.BUTTON_RIGHT = CoD.ButtonLayout.AddCenterAlignLabel(f18_arg0, f18_local15, f18_local16)
	end
	local f18_local15 = -160
	local f18_local16 = -70
	f18_arg0.buttonLines.BUTTON_LTRIG = CoD.ButtonLayout.AddLine(f18_arg0, {
		f18_local15,
		f18_local16
	}, {
		-108,
		-40
	})
	f18_arg0.buttonLabels.BUTTON_LTRIG = CoD.ButtonLayout.AddRightAlignLabel(f18_arg0, f18_local15 - 5, f18_local16 + f18_local0)
	local f18_local17 = 160
	local f18_local18 = -70
	f18_arg0.buttonLines.BUTTON_RTRIG = CoD.ButtonLayout.AddLine(f18_arg0, {
		108,
		-40
	}, {
		f18_local17,
		f18_local18
	})
	f18_arg0.buttonLabels.BUTTON_RTRIG = CoD.ButtonLayout.AddLeftAlignLabel(f18_arg0, f18_local17 + 5, f18_local18 + f18_local0)
	if not CoD.isSinglePlayer then
		local f18_local19 = -42
		local f18_local20 = -135
		f18_arg0.buttonLines.BUTTON_BACK = CoD.ButtonLayout.AddLine(f18_arg0, {
			-42,
			48
		}, {
			f18_local19,
			f18_local20
		})
		f18_arg0.buttonLabels.BUTTON_BACK = CoD.ButtonLayout.AddCenterAlignLabel(f18_arg0, f18_local19, f18_local20 - CoD.textSize.Default)
	end
	local f18_local19 = 42
	local f18_local20 = -100
	f18_arg0.buttonLines.BUTTON_START = CoD.ButtonLayout.AddLine(f18_arg0, {
		42,
		48
	}, {
		f18_local19,
		f18_local20
	})
	f18_arg0.buttonLabels.BUTTON_START = CoD.ButtonLayout.AddCenterAlignLabel(f18_arg0, f18_local19, f18_local20 - CoD.textSize.Default)
	local f18_local21 = -190
	local f18_local22 = 52
	f18_arg0.buttonLines.BUTTON_LSTICK = CoD.ButtonLayout.AddLine(f18_arg0, {
		f18_local21,
		f18_local22
	}, {
		-120,
		52
	})
	f18_arg0.buttonLabels.BUTTON_LSTICK = CoD.ButtonLayout.AddRightAlignLabel(f18_arg0, f18_local21 - 5, f18_local22 + f18_local0)
	local f18_local23 = 56
	local f18_local24 = 220
	f18_arg0.buttonLines.BUTTON_RSTICK = CoD.ButtonLayout.AddLine(f18_arg0, {
		56,
		123
	}, {
		f18_local23,
		f18_local24
	})
	f18_arg0.buttonLabels.BUTTON_RSTICK = CoD.ButtonLayout.AddCenterAlignLabel(f18_arg0, f18_local23, f18_local24)
end

