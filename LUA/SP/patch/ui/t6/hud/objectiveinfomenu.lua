require("T6.HUD.InGameMenus")
require("T6.HUD.InGamePopups")
CoD.ObjectiveInfoMenu = {}
CoD.ObjectiveInfoMenu.PauseSFX = "uin_main_pause"
CoD.ObjectiveInfoMenu.Pause_ButtonsTopAnchor = CoD.Menu.TitleHeight + 50
CoD.ObjectiveInfoMenu.ElementWidth = 325
CoD.ObjectiveInfoMenu.ObjectivesWidth = 400
CoD.ObjectiveInfoMenu.ElementSpacing = 40
CoD.ObjectiveInfoMenu.LeftRightAlignment = {
	leftAnchor = false,
	rightAnchor = false,
	left = CoD.ObjectiveInfoMenu.ElementSpacing / 2,
	right = CoD.ObjectiveInfoMenu.ElementSpacing / 2 + CoD.ObjectiveInfoMenu.ObjectivesWidth
}
CoD.ObjectiveInfoMenu.TitleHeight = CoD.Menu.TitleHeight
CoD.ObjectiveInfoMenu.TitleColor = CoD.visorBlue2
CoD.ObjectiveInfoMenu.ElementHeight = CoD.textSize.Default
CoD.ObjectiveInfoMenu.ObjectivesTop = CoD.ObjectiveInfoMenu.Pause_ButtonsTopAnchor + 8 * CoD.CoD9Button.Height + 50
CoD.ObjectiveInfoMenu.Objectives_LeftAnchor = 470
CoD.ObjectiveInfoMenu.Objectives_TitleTopAnchor = 80
CoD.ObjectiveInfoMenu.Objectives_ListTopAnchor = 140
CoD.ObjectiveInfoMenu.Objectives_ListRightAnchor = -10
CoD.ObjectiveInfoMenu.Objectives_ListBottomAnchor = -10
CoD.ObjectiveInfoMenu.Objectives_ListTextWidth = 300
CoD.ObjectiveInfoMenu.Objectives_ListMaterialSize = CoD.textSize.Default + 10
CoD.ObjectiveInfoMenu.Objectives_ListCheckboxWidth = 2
CoD.ObjectiveInfoMenu.Objectives_ListCheckboxGap = 10
CoD.ObjectiveInfoMenu.Objectives_Colors = {
	invisible = {
		red = 0,
		green = 0,
		blue = 0,
		alpha = 0
	},
	active = {
		red = CoD.visorBlue3.r,
		green = CoD.visorBlue3.g,
		blue = CoD.visorBlue3.b,
		alpha = 1
	},
	done = {
		red = CoD.visorBlue2.r,
		green = CoD.visorBlue2.g,
		blue = CoD.visorBlue2.b,
		alpha = 1
	},
	current = {
		red = CoD.visorBlue4.r,
		green = CoD.visorBlue4.g,
		blue = CoD.visorBlue4.b,
		alpha = 1
	},
	failed = {
		red = CoD.visorBlue1.r + 0.3,
		green = CoD.visorBlue1.g,
		blue = CoD.visorBlue1.b,
		alpha = 1
	}
}
LUI.createMenu.MissionObjectives = function (f1_arg0)
	local f1_local0 = CoD.InGameMenu.New("MissionObjectives", f1_arg0)
	f1_local0:setOwner(f1_arg0)
	CoD.ObjectiveInfoMenu.CreateObjectivesList(f1_local0)
	return f1_local0
end

LUI.createMenu.ObjectiveInfoMenu = function (f2_arg0)
	local f2_local0 = CoD.InGameMenu.New("ObjectiveInfoMenu", f2_arg0, Engine.Localize("MENU_PAUSED_CAPS"))
	CoD.InGameMenu.addButtonPrompts(f2_local0)
	Engine.PlaySound(CoD.ObjectiveInfoMenu.PauseSFX)
	f2_local0:setOwner(f2_arg0)
	if CoD.isWIIU then
		LUI.roots.UIRootDrc:processEvent({
			name = "collapse_drc_dead_zones_button"
		})
	end
	CoD.ObjectiveInfoMenu.RegisterButtonEvents(f2_local0)
	CoD.ObjectiveInfoMenu.CreateActionsList(f2_local0, f2_arg0)
	CoD.ObjectiveInfoMenu.CreateObjectivesList(f2_local0)
	return f2_local0
end

CoD.ObjectiveInfoMenu.AddButton = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = f3_arg0:addButton(f3_arg1)
	f3_local0:setActionEventName(f3_arg2)
	return f3_local0
end

CoD.ObjectiveInfoMenu.CreateActionsList = function (f4_arg0, f4_arg1)
	local f4_local0 = CoD.ButtonList.new()
	f4_local0:setLeftRight(false, false, -CoD.ObjectiveInfoMenu.ElementWidth - CoD.ObjectiveInfoMenu.ElementSpacing / 2, -CoD.ObjectiveInfoMenu.ElementSpacing / 2)
	f4_local0:setTopBottom(true, true, CoD.ObjectiveInfoMenu.Pause_ButtonsTopAnchor, 0)
	f4_arg0:addElement(f4_local0)
	f4_local0.upRepeater.minDelay = 100
	f4_local0.downRepeater.minDelay = 100
	f4_local0.upRepeater.delayReduction = 0
	f4_local0.downRepeater.delayReduction = 0
	f4_local0:setButtonBackingAnimationState({
		leftAnchor = true,
		rightAnchor = true,
		left = -5,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		material = RegisterMaterial("menu_mp_small_row")
	})
	local f4_local1 = Dvar.sv_running:get()
	local f4_local2 = Dvar.cg_development:get()
	local f4_local3 = Dvar.sv_cheats:get()
	local f4_local4 = Dvar.ui_singlemission:get()
	local f4_local5 = CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize("MENU_RESUMEGAME_CAPS"), "resume_game")
	if CoD.isWIIU then
		CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize("MENU_CONTROLLER_SETTINGS_CAPS"), "open_controls")
		CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize("MENU_FRIENDS_CAPS"), "open_friends")
	end
	CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize("MENU_OPTIONS_CAPS"), "open_options")
	if not Engine.GameModeIsMode(CoD.GAMEMODE_RTS) and 0 == Dvar.ui_singlemission:get() then
		local f4_local6 = CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize("MENU_LOWER_DIFFICULTY_CAPS"), "lower_difficulty")
		local f4_local7 = Engine.GetProfileVarInt(f4_arg1, "g_gameskill")
		if not f4_local7 or f4_local7 == 0 then
			f4_local6:disable()
		end
	elseif Engine.GameModeIsMode(CoD.GAMEMODE_RTS) then
		local f4_local6 = "MENU_VIEW_RTS_TUTORIAL"
		if Dvar.ui_isrtstutorial:get() == 1 then
			f4_local6 = "MENU_HELP_CAPS"
		end
		CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize(f4_local6), "rts_tutorial")
	end
	if f4_local1 and not Engine.GameModeIsMode(CoD.GAMEMODE_RTS) then
		CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize("MENU_RESTART_MISSION_CAPS"), "restart_mission")
	end
	if f4_local2 then
		CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize("MENU_RESTART_LEVEL_CAPS"), "restart_level")
	end
	local f4_local6 = UIExpression.GetDStat(f4_arg1, "PlayerCareerStats", "unitsAvailable")
	if Engine.GameModeIsMode(CoD.GAMEMODE_RTS) and f4_local4 == 0 then
		local f4_local7 = CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize("MENU_RETRY_MISSION_CAPS"), "retry_mission")
		if f4_local6 <= 0 then
			f4_local7:disable()
		end
	end
	if not (Engine.GameModeIsMode(CoD.GAMEMODE_RTS) or not f4_local3) or f4_local2 then
		CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize("MENU_RESTART_CHECKPOINT_CAPS"), "restart_from_check")
	end
	if Dvar.ui_isrtstutorial:get() == 1 and f4_local4 == 0 then
		CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize("MENU_SKIP_TUTORIAL_CAPS"), "skip_tutorial")
	end
	if 0 == Dvar.ui_isrtstutorial:get() or Dvar.ui_isrtstutorial:get() == 1 and f4_local4 == 1 and f4_local1 then
		if not Engine.GameModeIsMode(CoD.GAMEMODE_RTS) and UIExpression.IsProfileSignedIn(f4_arg0:getOwner()) == 1 and f4_local4 == 0 then
			CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize("PLATFORM_SAVE_AND_QUIT_CAPS"), "save_and_quit_game")
		else
			CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize("PLATFORM_QUIT_CAPS"), "quit_game")
		end
	end
	if f4_local3 then
		CoD.ObjectiveInfoMenu.AddButton(f4_local0, Engine.Localize("MENU_SKIP_CAPS"), "skip_level")
	end
	if CoD.useController and not f4_arg0:restoreState() then
		f4_local0:processEvent({
			name = "gain_focus"
		})
	end
end

CoD.ObjectiveInfoMenu.CreateObjectivesList = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = CoD.ObjectiveInfoMenu.Pause_ButtonsTopAnchor
	if not f5_arg2 then
		f5_arg2 = CoD.ObjectiveInfoMenu
	end
	local f5_local1 = f5_arg2.LeftRightAlignment
	if Engine.GameModeIsMode(CoD.GAMEMODE_RTS) and Dvar.ui_singlemission:get() == 0 then
		local f5_local2 = UIExpression.GetDStat(f5_arg1, "PlayerCareerStats", "unitsAvailable")
		local f5_local3 = LUI.UIText.new()
		f5_local3:setLeftRight(f5_local1.leftAnchor, f5_local1.rightAnchor, f5_local1.left, f5_local1.right)
		f5_local3:setTopBottom(true, false, f5_local0, f5_local0 + f5_arg2.TitleHeight)
		f5_local3:setAlignment(LUI.Alignment.Left)
		f5_local3:setFont(CoD.Menu.TitleFont)
		f5_local3:setRGB(f5_arg2.TitleColor.r, f5_arg2.TitleColor.g, f5_arg2.TitleColor.b)
		if f5_local2 > 0 then
			f5_local3:setText(f5_local2 .. " " .. Engine.Localize("SO_RTS_SF_UNITS_REMAINING"))
		else
			f5_local3:setText(Engine.Localize("SO_RTS_SF_NO_UNITS_REMAINING"))
		end
		f5_arg0:addElement(f5_local3)
		f5_local0 = f5_local0 + f5_arg2.TitleHeight * 2
	end
	local f5_local2 = LUI.UIText.new()
	f5_local2:setLeftRight(f5_local1.leftAnchor, f5_local1.rightAnchor, f5_local1.left, f5_local1.right)
	f5_local2:setTopBottom(true, false, f5_local0, f5_local0 + f5_arg2.TitleHeight)
	f5_local2:setAlignment(LUI.Alignment.Left)
	f5_local2:setText(Engine.Localize("MENU_MISSIONOBJECTIVES_CAPS"))
	f5_local2:setFont(CoD.Menu.TitleFont)
	f5_local2:setRGB(f5_arg2.TitleColor.r, f5_arg2.TitleColor.g, f5_arg2.TitleColor.b)
	f5_arg0:addElement(f5_local2)
	f5_local0 = f5_local0 + f5_arg2.TitleHeight + math.floor(0.17 * f5_arg2.TitleHeight)
	local f5_local3 = Engine.GetPlayerObjectives()
	local f5_local4 = LUI.UIVerticalList.new()
	f5_local4:setLeftRight(f5_local1.leftAnchor, f5_local1.rightAnchor, f5_local1.left, f5_local1.right)
	f5_local4:setTopBottom(true, true, f5_local0, 0)
	for f5_local14, f5_local15 in CoD.pairsByKeys(f5_local3) do
		local f5_local8 = nil
		if f5_local15.status ~= "invisible" then
			f5_local8 = f5_local15.string
			local Widget = LUI.UIElement.new()
			Widget:setLeftRight(true, true, 0, 0)
			local f5_local10 = 0
			local f5_local11 = 0
			if f5_local15.material ~= nil then
				local f5_local12 = (f5_arg2.ElementHeight - CoD.ObjectiveInfoMenu.Objectives_ListMaterialSize) / 2
				local f5_local13 = LUI.UIImage.new()
				f5_local13:setLeftRight(true, false, 0, CoD.ObjectiveInfoMenu.Objectives_ListMaterialSize)
				f5_local13:setTopBottom(true, false, f5_local12, f5_local12 + CoD.ObjectiveInfoMenu.Objectives_ListMaterialSize)
				f5_local13:beginAnimation("material_change")
				f5_local13:setImage(f5_local15.material)
				Widget:addElement(f5_local13)
				f5_local10 = f5_local10 + CoD.ObjectiveInfoMenu.Objectives_ListMaterialSize + CoD.ObjectiveInfoMenu.Objectives_ListCheckboxGap
			end
			Widget:setTopBottom(true, false, 0, math.max(f5_local11, Engine.GetNumTextLines(f5_local8, CoD.fonts.Default, f5_arg2.ElementHeight, f5_arg2.ObjectivesWidth - f5_local10) * f5_arg2.ElementHeight))
			local f5_local13 = LUI.UITightText.new({
				alignment = LUI.Alignment.Left,
				font = CoD.fonts.Default
			})
			f5_local13:setLeftRight(true, true, f5_local10, 0)
			f5_local13:setTopBottom(true, false, 0, f5_arg2.ElementHeight)
			f5_local13:setAlignment(LUI.Alignment.Left)
			f5_local13:setText(f5_local8)
			Widget:addElement(f5_local13)
			if CoD.ObjectiveInfoMenu.Objectives_Colors[f5_local15.status] == nil then
				DebugPrint("LUA Warning: ObjectiveInfoMenu.lua received an unhandled objective status, setting color to default")
				f5_local13:setRGB(CoD.ObjectiveInfoMenu.Objectives_Colors.current.red, CoD.ObjectiveInfoMenu.Objectives_Colors.current.green, CoD.ObjectiveInfoMenu.Objectives_Colors.current.blue)
				f5_local13:setRGB(CoD.ObjectiveInfoMenu.Objectives_Colors.current.alpha)
			else
				f5_local13:setRGB(CoD.ObjectiveInfoMenu.Objectives_Colors[f5_local15.status].red, CoD.ObjectiveInfoMenu.Objectives_Colors[f5_local15.status].green, CoD.ObjectiveInfoMenu.Objectives_Colors[f5_local15.status].blue)
				f5_local13:setAlpha(CoD.ObjectiveInfoMenu.Objectives_Colors[f5_local15.status].alpha)
			end
			f5_local4:addElement(Widget)
		end
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, false, 0, f5_arg2.ElementHeight)
		f5_local4:addElement(Widget)
	end
	f5_arg0:addElement(f5_local4)
end

CoD.ObjectiveInfoMenu.RegisterButtonEvents = function (f6_arg0)
	f6_arg0:registerEventHandler("resume_game", CoD.ObjectiveInfoMenu.ResumeGame)
	f6_arg0:registerEventHandler("open_controls", CoD.ObjectiveInfoMenu.OpenControls)
	f6_arg0:registerEventHandler("open_friends", CoD.ObjectiveInfoMenu.OpenFriends)
	f6_arg0:registerEventHandler("open_options", CoD.ObjectiveInfoMenu.OpenOptions)
	f6_arg0:registerEventHandler("lower_difficulty", CoD.ObjectiveInfoMenu.LowerDifficulty)
	f6_arg0:registerEventHandler("restart_mission", CoD.ObjectiveInfoMenu.RestartMission)
	f6_arg0:registerEventHandler("restart_level", CoD.ObjectiveInfoMenu.RestartLevel)
	f6_arg0:registerEventHandler("restart_from_check", CoD.ObjectiveInfoMenu.RestartFromCheckpoint)
	f6_arg0:registerEventHandler("retry_mission", CoD.ObjectiveInfoMenu.RetryMission)
	f6_arg0:registerEventHandler("save_and_quit_game", CoD.ObjectiveInfoMenu.SaveAndQuit)
	f6_arg0:registerEventHandler("quit_game", CoD.ObjectiveInfoMenu.Quit)
	f6_arg0:registerEventHandler("skip_level", CoD.ObjectiveInfoMenu.SkipLevel)
	f6_arg0:registerEventHandler("rts_tutorial", CoD.ObjectiveInfoMenu.OpenRTSTutorial)
	f6_arg0:registerEventHandler("skip_tutorial", CoD.ObjectiveInfoMenu.SkipTutorial)
	f6_arg0:registerEventHandler("open_saveandquitgamepopup", CoD.ObjectiveInfoMenu.SaveAndQuit)
end

CoD.ObjectiveInfoMenu.ResumeGame = function (f7_arg0, f7_arg1)
	f7_arg0:processEvent({
		name = "close_all_ingame_menus",
		controller = f7_arg1.controller
	})
end

CoD.ObjectiveInfoMenu.OpenControls = function (f8_arg0, f8_arg1)
	f8_arg0:saveState()
	local f8_local0 = f8_arg0:openMenu("WiiUControllerSettings", f8_arg1.controller, true)
	f8_arg0:close()
end

CoD.ObjectiveInfoMenu.OpenFriends = function (f9_arg0, f9_arg1)
	f9_arg0:saveState()
	local f9_local0 = f9_arg0:openMenu("FriendsList", f9_arg1.controller)
	f9_arg0:close()
end

CoD.ObjectiveInfoMenu.OpenOptions = function (f10_arg0, f10_arg1)
	f10_arg0:saveState()
	if LUI.savedMenuStates.Menu.OptionsMenu then
		LUI.savedMenuStates.Menu.OptionsMenu = nil
	end
	local f10_local0 = f10_arg0:openMenu("OptionsMenu", f10_arg1.controller)
	f10_arg0:close()
end

CoD.ObjectiveInfoMenu.LowerDifficulty = function (f11_arg0, f11_arg1)
	f11_arg0:saveState()
	f11_arg0:openMenu("LowerDifficultyPopup", f11_arg1.controller)
	f11_arg0:close()
end

CoD.ObjectiveInfoMenu.RestartMission = function (f12_arg0, f12_arg1)
	f12_arg0:saveState()
	f12_arg0:openMenu("RestartMissionPopup", f12_arg1.controller)
	f12_arg0:close()
end

CoD.ObjectiveInfoMenu.RestartLevel = function (f13_arg0, f13_arg1)
	f13_arg0:saveState()
	f13_arg0:openMenu("RestartLevelPopup", f13_arg1.controller)
	f13_arg0:close()
end

CoD.ObjectiveInfoMenu.RetryMission = function (f14_arg0, f14_arg1)
	f14_arg0:saveState()
	f14_arg0:openMenu("RetryMissionPopup", f14_arg1.controller)
	f14_arg0:close()
end

CoD.ObjectiveInfoMenu.RestartFromCheckpoint = function (f15_arg0, f15_arg1)
	f15_arg0:saveState()
	f15_arg0:openMenu("RestartFromCheckpointPopup", f15_arg1.controller)
	f15_arg0:close()
end

CoD.ObjectiveInfoMenu.SaveAndQuit = function (f16_arg0, f16_arg1)
	f16_arg0:saveState()
	f16_arg0:openMenu("SaveAndQuitGamePopup", f16_arg1.controller)
	f16_arg0:close()
end

CoD.ObjectiveInfoMenu.Quit = function (f17_arg0, f17_arg1)
	f17_arg0:saveState()
	f17_arg0:openMenu("QuitGamePopup", f17_arg1.controller)
	f17_arg0:close()
end

CoD.ObjectiveInfoMenu.SkipLevel = function (f18_arg0, f18_arg1)
	f18_arg0:processEvent({
		name = "close_all_ingame_menus",
		controller = f18_arg1.controller
	})
	Engine.Exec(f18_arg1.controller, "skip_level")
	f18_arg0:close()
end

CoD.ObjectiveInfoMenu.OpenRTSTutorial = function (f19_arg0, f19_arg1)
	f19_arg0:saveState()
	f19_arg0:openMenu("RTSTutorialPopup", f19_arg1.controller)
	f19_arg0:close()
end

CoD.ObjectiveInfoMenu.SkipTutorial = function (f20_arg0, f20_arg1)
	f20_arg0:saveState()
	f20_arg0:openMenu("SkipTutorialPopup", f20_arg1.controller)
	f20_arg0:close()
end

