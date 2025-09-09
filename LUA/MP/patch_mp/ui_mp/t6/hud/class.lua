require("T6.HUD.InGameMenus")
require("T6.UnifiedFriends")
if CoD.isMultiplayer and not CoD.isZombie then
	require("T6.XPBar")
end
if CoD.isWIIU then
	require("T6.WiiUControllerSettings")
end
CoD.Class = {}
CoD.Class.DisableChooseTeam = function ()
	local f1_local0
	if not CoD.IsTeamChangeAllowed() then
		f1_local0 = not CoD.IsSpectatingAllowed()
	else
		f1_local0 = false
	end
	return f1_local0
end

CoD.Class.DisableChooseClass = function ()
	return Engine.GetGametypeSetting("disableClassSelection") == 1
end

CoD.Class.AddButton = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local f3_local0 = f3_arg0.buttonList:addButton(f3_arg1)
	f3_local0:setActionEventName(f3_arg2)
	if f3_arg3 == true then
		f3_local0:disable()
	end
	return f3_local0
end

CoD.Class.ChooseClassButtonPressed = function (f4_arg0, f4_arg1)
	f4_arg0:saveState()
	f4_arg0:openMenu("changeclass", f4_arg1.controller)
	f4_arg0:close()
end

CoD.Class.ControlsButtonPressed = function (f5_arg0, f5_arg1)
	f5_arg0:saveState()
	local f5_local0 = f5_arg0:openMenu("WiiUControllerSettings", f5_arg1.controller, true)
	f5_local0:setPreviousMenu("class")
	f5_arg0:close()
end

CoD.Class.OptionsButtonPressed = function (f6_arg0, f6_arg1)
	f6_arg0:saveState()
	f6_arg0:openMenu("OptionsMenu", f6_arg1.controller)
	f6_arg0:close()
end

CoD.Class.EndGameButtonPressed = function (f7_arg0, f7_arg1)
	f7_arg0:openPopup("EndGamePopup", f7_arg1.controller)
end

CoD.Class.ResumeGameButtonPressed = function (f8_arg0, f8_arg1)
	f8_arg0:processEvent({
		name = "button_prompt_back",
		controller = f8_arg1.controller
	})
end

CoD.Class.RestartGameButtonPressed = function (f9_arg0, f9_arg1)
	f9_arg0:openPopup("RestartGamePopup", f9_arg1.controller)
end

CoD.Class.ChooseTeamButtonPressed = function (f10_arg0, f10_arg1)
	f10_arg0:saveState()
	f10_arg0:openMenu("team_marinesopfor", f10_arg1.controller)
	f10_arg0:close()
end

CoD.Class.ButtonPromptFriendsMenu = function (f11_arg0, f11_arg1)
	f11_arg0:saveState()
	local f11_local0 = f11_arg0:openMenu("FriendsList", f11_arg1.controller)
	f11_local0:setPreviousMenu("class")
	f11_arg0:close()
end

CoD.Class.PrepareClassButtonList = function (f12_arg0, f12_arg1)
	local f12_local0 = CoD.SplitscreenScaler.new(nil, 1.5)
	f12_local0:setLeftRight(true, false, 0, 0)
	f12_local0:setTopBottom(true, false, 0, 0)
	f12_arg1:addElement(f12_local0)
	local f12_local1 = 0
	if UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
		f12_local1 = CoD.Menu.SplitscreenSideOffset
	end
	f12_arg1.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f12_local1,
		right = f12_local1 + CoD.ButtonList.DefaultWidth,
		topAnchor = true,
		bottomAnchor = false,
		top = CoD.Menu.TitleHeight,
		bottom = CoD.Menu.TitleHeight + 720
	})
	f12_local0:addElement(f12_arg1.buttonList)
	if CoD.isZombie == true then
		if CoD.isWIIU then
			CoD.Class.AddButton(f12_arg1, Engine.Localize("MENU_CONTROLLER_SETTINGS_CAPS"), "open_controls")
		end
		if Engine.CanPauseZombiesGame() and CoD.canLeaveGame(f12_arg0) then
			CoD.Class.AddButton(f12_arg1, Engine.Localize("MENU_RESUMEGAME_CAPS"), "soloResumeGame")
			if (Engine.SessionModeIsMode(CoD.SESSIONMODE_SYSTEMLINK) == true) or Engine.SessionModeIsMode(CoD.SESSIONMODE_OFFLINE) == true then
				CoD.Class.AddButton(f12_arg1, Engine.Localize("MENU_RESTART_LEVEL_CAPS"), "openRestartGamePopup")
			end
		end
		CoD.Class.AddButton(f12_arg1, Engine.Localize("MENU_OPTIONS_CAPS"), "open_options")
	else
		if UIExpression.Team(f12_arg0, "name") ~= "TEAM_SPECTATOR" and CoD.IsWagerMode() == false then
			CoD.Class.AddButton(f12_arg1, Engine.Localize("MPUI_CHOOSE_CLASS_BUTTON_CAPS"), "open_chooseClass", CoD.Class.DisableChooseClass())
		end
		if Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH) == false and Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == false and UIExpression.IsVisibilityBitSet(f12_arg0, CoD.BIT_ROUND_END_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f12_arg0, CoD.BIT_FINAL_KILLCAM) == 0 and CoD.IsGametypeTeamBased() == true then
			CoD.Class.AddButton(f12_arg1, Engine.Localize("MPUI_CHANGE_TEAM_BUTTON_CAPS"), "open_chooseTeam", CoD.Class.DisableChooseTeam())
		end
		if CoD.isWIIU then
			CoD.Class.AddButton(f12_arg1, Engine.Localize("MENU_CONTROLLER_SETTINGS_CAPS"), "open_controls")
		end
		CoD.Class.AddButton(f12_arg1, Engine.Localize("MENU_OPTIONS_CAPS"), "open_options")
	end
	if CoD.canLeaveGame(f12_arg0) then
		if not CoD.isRankedGame() and CoD.isHost() then
			CoD.Class.AddButton(f12_arg1, Engine.Localize("MENU_END_GAME_CAPS"), "open_endGamePopup")
		else
			CoD.Class.AddButton(f12_arg1, Engine.Localize("MENU_LEAVE_GAME_CAPS"), "open_endGamePopup")
		end
	end
	if not f12_arg1:restoreState() then
		f12_arg1.buttonList:processEvent({
			name = "gain_focus_skip_disabled"
		})
	end
end

LUI.createMenu.class = function (f13_arg0)
	local f13_local0 = "MPUI_PAUSE_MENU"
	if CoD.isZombie == true then
		f13_local0 = "MENU_ZOMBIES_CAPS"
	end
	if CoD.isWIIU then
		LUI.roots.UIRootDrc:processEvent({
			name = "collapse_drc_dead_zones_button"
		})
	end
	local f13_local1 = CoD.InGameMenu.New("class", f13_arg0, UIExpression.ToUpper(nil, Engine.Localize(f13_local0)))
	local f13_local2
	if not Engine.SessionModeIsMode(CoD.SESSIONMODE_OFFLINE) then
		f13_local2 = not Engine.SessionModeIsMode(CoD.SESSIONMODE_SYSTEMLINK)
	else
		f13_local2 = false
	end
	if UIExpression.IsInGame() == 1 and true == Engine.IsSplitscreen() then
		f13_local1:sizeToSafeArea(f13_arg0)
		f13_local1:updateTitleForSplitscreen()
		f13_local1:updateButtonPromptBarsForSplitscreen()
	end
	Engine.PlaySound("uin_main_pause")
	f13_local1:addButtonPrompts()
	CoD.Class.PrepareClassButtonList(f13_arg0, f13_local1)
	f13_local1:registerEventHandler("open_chooseClass", CoD.Class.ChooseClassButtonPressed)
	f13_local1:registerEventHandler("open_chooseTeam", CoD.Class.ChooseTeamButtonPressed)
	if CoD.isWIIU then
		local f13_local3 = LUI.roots
		local f13_local4 = "UIRoot"
		f13_local3["UIRoot" .. f13_arg0].ingameClassMenu = f13_local1
		f13_local1:registerEventHandler("button_prompt_back", function (f14_arg0, f14_arg1)
			local f14_local0 = LUI.roots
			local f14_local1 = "UIRoot"
			f14_local0["UIRoot" .. f14_arg1.controller].ingameClassMenu = nil
			CoD.InGameMenu.BackButtonPressed(f14_arg0, f14_arg1)
		end)
	end
	if CoD.isWIIU then
		if UIExpression.IsGuest(f13_arg0) == 0 and f13_local2 then
			f13_local1:addFriendsButton()
			f13_local1:registerEventHandler("open_friends_menu", CoD.Class.ButtonPromptFriendsMenu)
			f13_local1:registerEventHandler("button_prompt_friends", function (f15_arg0, f15_arg1)
				local f15_local0 = LUI.roots.UIRootDrc
				if f15_local0 and f15_local0.friendsButton and not f15_local0.friendsButton.m_down then
					f15_local0:processEvent({
						name = "press_view_panel_button",
						buttonName = "friends"
					})
				else
					CoD.Class.ButtonPromptFriendsMenu(f15_arg0, f15_arg1)
				end
			end)
		end
		f13_local1:registerEventHandler("open_controls", CoD.Class.ControlsButtonPressed)
	end
	if f13_local2 and (CoD.isXBOX or CoD.isPS3 or CoD.isPC) and UIExpression.IsGuest(f13_arg0) == 0 and (not CoD.isPS3 or UIExpression.IsSubUser(f13_arg0) ~= 1) and Engine.IsSplitscreen() == false then
		f13_local1:addFriendsButton()
		f13_local1:registerEventHandler("button_prompt_friends", CoD.Class.ButtonPromptFriendsMenu)
	end
	f13_local1:registerEventHandler("open_options", CoD.Class.OptionsButtonPressed)
	f13_local1:registerEventHandler("open_endGamePopup", CoD.Class.EndGameButtonPressed)
	if CoD.isZombie == true then
		f13_local1:registerEventHandler("soloResumeGame", CoD.Class.ResumeGameButtonPressed)
		f13_local1:registerEventHandler("openRestartGamePopup", CoD.Class.RestartGameButtonPressed)
	end
	local f13_local3 = UIExpression.TableLookup(f13_arg0, UIExpression.GetCurrentMapTableName(), 0, UIExpression.DvarString(nil, "mapname"), 3)
	local f13_local4 = 300
	local f13_local5 = f13_local4
	local f13_local6 = 0
	local f13_local7 = 4
	local f13_local8 = Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN)
	local f13_local9 = CoD.SplitscreenMultiplier
	if f13_local8 then
		f13_local9 = 1.8
		f13_local4 = 280
		f13_local5 = f13_local4
	end
	local f13_local10 = CoD.SplitscreenScaler.new(nil, f13_local9)
	f13_local10:setLeftRight(false, true, 0, 0)
	f13_local10:setTopBottom(true, true, CoD.Menu.TitleHeight, -CoD.Menu.TitleHeight)
	f13_local1:addElement(f13_local10)
	if CoD.isZombie == false and not Engine.IsShoutcaster(f13_arg0) then
		local f13_local11 = 0
		if Engine.IsSplitscreen() then
			f13_local11 = 130
		end
		local f13_local12 = LUI.UIText.new()
		f13_local12:setLeftRight(false, true, f13_local6 - f13_local4, f13_local6)
		f13_local12:setTopBottom(true, false, f13_local11, f13_local11 + CoD.textSize.Condensed)
		f13_local12:setFont(CoD.fonts.Condensed)
		f13_local12:setAlignment(LUI.Alignment.Left)
		f13_local12:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f13_local12:setText(Engine.Localize(f13_local3 .. "_CAPS"))
		f13_local10:addElement(f13_local12)
		local f13_local13 = f13_local11 + CoD.textSize.Condensed
		if not Engine.IsSplitscreen() then
			local f13_local14 = LUI.UIText.new()
			f13_local14:setLeftRight(false, true, f13_local6 - f13_local4, f13_local6)
			f13_local14:setTopBottom(true, false, f13_local13, f13_local13 + CoD.textSize.Default)
			f13_local14:setFont(CoD.fonts.Default)
			f13_local14:setAlignment(LUI.Alignment.Left)
			f13_local14:setText(Engine.Localize(f13_local3 .. "_LOC"))
			f13_local10:addElement(f13_local14)
		end
		local f13_local14 = f13_local13 + CoD.textSize.Default
		if Engine.IsSplitscreen() then
			f13_local14 = f13_local14 - 50
		end
		CoD.Compass.AddInGameMap(f13_local10, f13_arg0, {
			leftAnchor = false,
			rightAnchor = true,
			left = f13_local6 - f13_local4,
			right = f13_local6,
			topAnchor = true,
			bottomAnchor = false,
			top = f13_local14,
			bottom = f13_local14 + f13_local5
		})
		local f13_local15 = f13_local14 + f13_local5
		if f13_local8 then
			f13_local15 = f13_local15 - 25
		end
		local f13_local16 = LUI.UIText.new()
		f13_local16:setLeftRight(false, true, f13_local6 - f13_local4, f13_local6)
		f13_local16:setTopBottom(true, false, f13_local15, f13_local15 + CoD.textSize.Condensed)
		f13_local16:setFont(CoD.fonts.Condensed)
		f13_local16:setAlignment(LUI.Alignment.Left)
		f13_local16:setText(UIExpression.GametypeName())
		f13_local16:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f13_local10:addElement(f13_local16)
		if not Engine.IsSplitscreen() then
			local f13_local17 = f13_local15 + CoD.textSize.Condensed
			local f13_local18 = LUI.UIText.new()
			f13_local18:setLeftRight(false, true, f13_local6 - f13_local4, f13_local6)
			f13_local18:setTopBottom(true, false, f13_local17, f13_local17 + CoD.textSize.Default)
			f13_local18:setFont(CoD.fonts.Default)
			f13_local18:setAlignment(LUI.Alignment.Left)
			f13_local18:setText(UIExpression.GametypeDescription())
			f13_local10:addElement(f13_local18)
		end
	end
	if CoD.isZombie == false and not Engine.IsShoutcaster(f13_arg0) and UIExpression.IsGuest(f13_arg0) == 0 and Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH) == true and Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == false and not Engine.IsSplitscreen() and CoD.CanRankUp(f13_arg0) == true then
		local f13_local11 = 0
		local f13_local12 = CoD.Menu.Width - f13_local11
		local f13_local13 = 40
		local f13_local14 = -10 - CoD.ButtonPrompt.Height
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(false, false, f13_local11 + -(f13_local12 / 2), f13_local11 + f13_local12 / 2)
		Widget:setTopBottom(false, true, f13_local14 - f13_local13, f13_local14)
		f13_local1:addElement(Widget)
		local f13_local15 = LUI.UIImage.new()
		f13_local15:setLeftRight(true, true, 1, -1)
		f13_local15:setTopBottom(true, true, 1, -1)
		f13_local15:setRGB(0, 0, 0)
		f13_local15:setAlpha(0.6)
		Widget:addElement(f13_local15)
		Widget.border = CoD.Border.new(1, 1, 1, 1, 0.1)
		Widget:addElement(Widget.border)
		local f13_local16 = 10
		local f13_local17 = CoD.XPBar.New(nil, f13_arg0, f13_local12 - f13_local16 * 2)
		f13_local17:setLeftRight(true, true, f13_local16, -f13_local16)
		f13_local17:setTopBottom(true, true, 0, 0)
		Widget:addElement(f13_local17)
		f13_local17:processEvent({
			name = "animate_xp_bar",
			duration = 0
		})
	end
	return f13_local1
end

