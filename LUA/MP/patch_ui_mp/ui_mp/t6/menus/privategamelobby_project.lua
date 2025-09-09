CoD.PrivateGameLobby.ButtonPrompt_TeamPrev = function (f1_arg0, f1_arg1)
	if Engine.PartyHostIsReadyToStart() == true then
		return 
	else
		Engine.LocalPlayerPartyPrevTeam(f1_arg1.controller)
		Engine.PlaySound("cac_loadout_edit_submenu")
	end
end

CoD.PrivateGameLobby.ButtonPrompt_TeamNext = function (f2_arg0, f2_arg1)
	if Engine.PartyHostIsReadyToStart() == true then
		return 
	else
		Engine.LocalPlayerPartyNextTeam(f2_arg1.controller)
		Engine.PlaySound("cac_loadout_edit_submenu")
	end
end

CoD.PrivateGameLobby.ShouldEnableTeamCycling = function (f3_arg0)
	if f3_arg0.panelManager == nil then
		return false
	elseif not f3_arg0.panelManager:isPanelOnscreen("lobbyPane") then
		return false
	elseif Engine.PartyIsReadyToStart() == true then
		return false
	elseif Engine.PartyHostIsReadyToStart() == true then
		return false
	elseif Engine.GetGametypeSetting("autoTeamBalance") == 1 and Engine.GetGametypeSetting("allowspectating") ~= 1 then
		return false
	else
		return true
	end
end

CoD.PrivateGameLobby.SetupTeamCycling = function (f4_arg0)
	if CoD.PrivateGameLobby.ShouldEnableTeamCycling(f4_arg0) then
		f4_arg0.cycleTeamButtonPrompt:enable()
	else
		f4_arg0.cycleTeamButtonPrompt:disable()
	end
end

CoD.PrivateGameLobby.CurrentPanelChanged = function (f5_arg0, f5_arg1)
	CoD.Lobby.CurrentPanelChanged(f5_arg0, f5_arg1)
	CoD.PrivateGameLobby.SetupTeamCycling(f5_arg0)
end

CoD.PrivateGameLobby.ButtonPrompt_PartyUpdateStatus = function (f6_arg0, f6_arg1)
	CoD.GameLobby.UpdateStatusText(f6_arg0, f6_arg1)
	CoD.PrivateGameLobby.SetupTeamCycling(f6_arg0)
	f6_arg0:dispatchEventToChildren(f6_arg1)
end

CoD.PrivateGameLobby.DoesGametypeSupportBots = function (f7_arg0)
	local f7_local0 = {
		"dm",
		"tdm",
		"ctf",
		"dem",
		"dom",
		"koth",
		"hq",
		"conf"
	}
	for f7_local1 = 1, #f7_local0, 1 do
		if f7_arg0 == f7_local0[f7_local1] then
			return true
		end
	end
	return false
end

CoD.PrivateGameLobby.BotButton_Update = function (f8_arg0)
	local f8_local0 = UIExpression.DvarString(nil, "ui_gameType")
	local f8_local1 = UIExpression.DvarInt(nil, "bot_friends")
	local f8_local2 = UIExpression.DvarInt(nil, "bot_enemies")
	local f8_local3 = UIExpression.DvarInt(nil, "bot_difficulty")
	f8_arg0.starImage:setAlpha(0)
	if not CoD.IsGametypeTeamBased() then
		Engine.SetDvar("bot_friends", 0)
	end
	if CoD.IsGametypeTeamBased() and f8_local2 > 9 then
		Engine.SetDvar("bot_enemies", 9)
	end
	if CoD.PrivateGameLobby.DoesGametypeSupportBots(f8_local0) then
		f8_arg0.hintText = Engine.Localize("MENU_BOTS_HINT")
		f8_arg0:enable()
		if f8_local1 ~= 0 or f8_local2 ~= 0 then
			f8_arg0.starImage:setAlpha(1)
		end
	else
		f8_arg0.hintText = Engine.Localize("MENU_BOTS_NOT_SUPPORTED_" .. f8_local0)
		f8_arg0:disable()
	end
end

CoD.PrivateGameLobby.PopulateButtons_Project_Multiplayer = function (f9_arg0, f9_arg1)
	if f9_arg1 == true then
		local f9_local0 = Engine.Localize("MPUI_SETUP_GAME_CAPS")
		local f9_local1 = {}
		f9_local1 = GetTextDimensions(f9_local0, CoD.CoD9Button.Font, CoD.CoD9Button.TextHeight)
		f9_arg0.body.setupGameButton = f9_arg0.body.buttonList:addButton(f9_local0)
		f9_arg0.body.setupGameButton.hintText = Engine.Localize("MPUI_SETUP_GAME_DESC")
		f9_arg0.body.setupGameButton:setActionEventName("open_setup_game_flyout")
		f9_arg0.body.setupGameButton:registerEventHandler("button_update", CoD.PrivateGameLobby.Button_UpdateHostButton)
		if f9_arg0.body.widestButtonTextWidth < f9_local1[3] then
			f9_arg0.body.widestButtonTextWidth = f9_local1[3]
		end
		local f9_local2 = Engine.Localize("MENU_SETUP_BOTS_CAPS")
		local f9_local3 = {}
		f9_local3 = GetTextDimensions(f9_local2, CoD.CoD9Button.Font, CoD.CoD9Button.TextHeight)
		local f9_local4 = f9_local3[3]
		f9_arg0.body.botsButton = f9_arg0.body.buttonList:addButton(f9_local2)
		f9_arg0.body.botsButton:setActionEventName("open_bots_menu")
		f9_arg0.body.botsButton:registerEventHandler("gamelobby_update", CoD.PrivateGameLobby.BotButton_Update)
		if f9_arg0.body.widestButtonTextWidth < f9_local4 then
			f9_arg0.body.widestButtonTextWidth = f9_local4
		end
		local recImage = LUI.UIImage.new()
		recImage:setLeftRight(true, false, f9_local4 + 5, f9_local4 + 5 + 30)
		recImage:setTopBottom(false, false, -15, 15)
		recImage:setAlpha(0)
		recImage:setImage(RegisterMaterial(CoD.MPZM("ui_host", "ui_host_zm")))
		f9_arg0.body.botsButton:addElement(recImage)
		f9_arg0.body.botsButton.starImage = recImage
		CoD.PrivateGameLobby.BotButton_Update(f9_arg0.body.botsButton)
		f9_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2)
	end
	local f9_local0 = Engine.Localize("MENU_CREATE_A_CLASS_CAPS")
	local f9_local1 = {}
	f9_local1 = GetTextDimensions(f9_local0, CoD.CoD9Button.Font, CoD.CoD9Button.TextHeight)
	f9_arg0.body.createAClassButton = f9_arg0.body.buttonList:addButton(f9_local0)
	f9_arg0.body.createAClassButton.id = "CoD9Button." .. "PrivateGameLobby." .. Engine.Localize("MENU_CREATE_A_CLASS_CAPS")
	CoD.CACUtility.SetupCACLock(f9_arg0.body.createAClassButton)
	f9_arg0.body.createAClassButton:registerEventHandler("button_action", CoD.GameLobby.Button_CAC)
	if f9_arg0.body.widestButtonTextWidth < f9_local1[3] then
		f9_arg0.body.widestButtonTextWidth = f9_local1[3]
	end
	local f9_local2 = Engine.Localize("MENU_SCORE_STREAKS_CAPS")
	local f9_local3 = {}
	f9_local3 = GetTextDimensions(f9_local2, CoD.CoD9Button.Font, CoD.CoD9Button.TextHeight)
	f9_arg0.body.rewardsButton = f9_arg0.body.buttonList:addButton(f9_local2)
	f9_arg0.body.rewardsButton.id = "CoD9Button." .. "PrivateGameLobby." .. Engine.Localize("MENU_SCORE_STREAKS_CAPS")
	f9_arg0.body.rewardsButton.hintText = Engine.Localize("FEATURE_KILLSTREAKS_DESC")
	CoD.SetupButtonLock(f9_arg0.body.rewardsButton, nil, "FEATURE_KILLSTREAKS", "FEATURE_KILLSTREAKS_DESC")
	f9_arg0.body.rewardsButton:registerEventHandler("button_action", CoD.GameLobby.Button_Rewards)
	if f9_arg0.body.widestButtonTextWidth < f9_local3[3] then
		f9_arg0.body.widestButtonTextWidth = f9_local3[3]
	end
	f9_arg0.body.barracksButtonSpacer = f9_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2)
	f9_arg0.body.barracksButton = f9_arg0.body.buttonList:addButton(Engine.Localize("MENU_BARRACKS_CAPS"))
	f9_arg0.body.barracksButton.id = "CoD9Button." .. "PrivateGameLobby." .. Engine.Localize("MENU_BARRACKS_CAPS")
	CoD.SetupBarracksLock(f9_arg0.body.barracksButton)
	f9_arg0.body.barracksButton:setActionEventName("open_barracks")
	f9_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 4, 200)
	if f9_arg1 and UIExpression.SessionMode_IsOnlineGame() == 1 then
		local f9_local4 = f9_arg0.body.buttonList:addButton(Engine.Localize("CUSTOM_GAME_RECORDING_CAPS"))
		f9_local4.hintText = Engine.Localize("CUSTOM_GAME_RECORDING_DESC")
		f9_local4:registerEventHandler("button_action", CoD.PrivateGameLobby.DemoRecordingButton_ToggleDemoRecording)
		
		local recImage = LUI.UIImage.new()
		recImage:setLeftRight(false, true, -130, -100)
		recImage:setTopBottom(false, false, -15, 15)
		recImage:setAlpha(1)
		recImage:setImage(RegisterMaterial("codtv_recording"))
		
		local recText = LUI.UIText.new({
			leftAnchor = false,
			rightAnchor = true,
			left = -100,
			right = -40,
			topAnchor = false,
			bottomAnchor = false,
			top = -CoD.textSize.Condensed / 2,
			bottom = CoD.textSize.Condensed / 2,
			font = CoD.fonts.Condensed,
			alignment = LUI.Alignment.Left
		})
		f9_local4:addElement(recImage)
		f9_local4.recImage = recImage
		
		f9_local4:addElement(recText)
		f9_local4.recText = recText
		
		CoD.PrivateGameLobby.UpdateDemoRecordingButton(f9_local4)
	end
	if Engine.SessionModeIsMode(CoD.SESSIONMODE_SYSTEMLINK) == false and UIExpression.DvarBool(nil, "webm_encUiEnabledCustom") == 1 then
		CoD.Lobby.AddLivestreamButton(f9_arg0, 10, f9_arg1)
	end
end

CoD.PrivateGameLobby.UpdateDemoRecordingButton = function (f10_arg0)
	if Dvar.demo_recordPrivateMatch:get() then
		f10_arg0.recImage:setRGB(1, 0, 0)
		f10_arg0.recText:setText(Engine.Localize("MENU_ON_CAPS"))
	else
		f10_arg0.recImage:setRGB(0.3, 0.3, 0.3)
		f10_arg0.recText:setText(Engine.Localize("MENU_OFF_CAPS"))
	end
end

CoD.PrivateGameLobby.DemoRecordingButton_ToggleDemoRecording = function (f11_arg0, f11_arg1)
	local f11_local0 = Dvar.demo_recordPrivateMatch
	f11_local0:set(not f11_local0:get())
	CoD.PrivateGameLobby.UpdateDemoRecordingButton(f11_arg0)
end

CoD.PrivateGameLobby.PopulateFlyoutButtons_Project_Multiplayer = function (f12_arg0)
	f12_arg0.body.setupGameFlyoutContainer.changeMapButton = f12_arg0.body.setupGameFlyoutContainer.buttonList:addButton(Engine.Localize("MPUI_CHANGE_MAP_CAPS"))
	f12_arg0.body.setupGameFlyoutContainer.changeMapButton.hintText = Engine.Localize("MPUI_CHANGE_MAP_DESC")
	f12_arg0.body.setupGameFlyoutContainer.changeMapButton:setActionEventName("open_change_map")
	f12_arg0.body.setupGameFlyoutContainer.changeMapButton:registerEventHandler("button_update", CoD.PrivateGameLobby.Button_UpdateHostButton)
	f12_arg0.body.setupGameFlyoutContainer.changeGameModeButton = f12_arg0.body.setupGameFlyoutContainer.buttonList:addButton(Engine.Localize("MPUI_CHANGE_GAME_MODE_CAPS"))
	f12_arg0.body.setupGameFlyoutContainer.changeGameModeButton.hintText = Engine.Localize("MPUI_CHANGE_GAME_MODE_DESC")
	f12_arg0.body.setupGameFlyoutContainer.changeGameModeButton:setActionEventName("open_change_game_mode")
	f12_arg0.body.setupGameFlyoutContainer.changeGameModeButton:registerEventHandler("button_update", CoD.PrivateGameLobby.Button_UpdateHostButton)
	f12_arg0.body.setupGameFlyoutContainer.editGameOptionsButton = f12_arg0.body.setupGameFlyoutContainer.buttonList:addButton(Engine.Localize("MPUI_EDIT_GAME_RULES_CAPS"))
	f12_arg0.body.setupGameFlyoutContainer.editGameOptionsButton.hintText = Engine.Localize("MPUI_EDIT_GAME_RULES_DESC")
	f12_arg0.body.setupGameFlyoutContainer.editGameOptionsButton:setActionEventName("open_editGameOptions_menu")
	f12_arg0.body.setupGameFlyoutContainer.editGameOptionsButton:registerEventHandler("button_update", CoD.PrivateGameLobby.Button_UpdateHostButton)
end

CoD.PrivateGameLobby.PopulateButtons_Project_Zombie = function (f13_arg0, f13_arg1)
	if f13_arg1 == true then
		f13_arg0.body.changeMapButton = f13_arg0.body.buttonList:addButton(Engine.Localize("ZMUI_MAP_CAPS"))
		f13_arg0.body.changeMapButton.hintText = Engine.Localize("ZMUI_MAP_SELECTION_DESC")
		f13_arg0.body.changeMapButton:setActionEventName("open_change_startLoc")
		f13_arg0.body.changeMapButton:registerEventHandler("button_update", CoD.PrivateGameLobby.Button_UpdateHostButton)
		f13_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height * 1)
		local f13_local0 = UIExpression.DvarString(nil, "ui_gameType")
		local f13_local1 = 220
		if f13_local0 == "zcleansed" then
			f13_local1 = 170
		end
		local f13_local2 = UIExpression.DvarString(nil, "ui_mapname")
		local f13_local3 = false
		local f13_local4, f13_local5, f13_local6, f13_local7 = false
		for f13_local16, f13_local17 in pairs(CoD.Zombie.GameOptions) do
			f13_local3 = false
			if f13_local17.gameTypes ~= nil then
				for f13_local14, f13_local15 in pairs(f13_local17.gameTypes) do
					if f13_local15 == f13_local0 then
						f13_local3 = true
					end
				end
			else
				f13_local3 = true
			end
			if f13_local3 and f13_local17.maps ~= nil then
				for f13_local14, f13_local15 in pairs(f13_local17.maps) do
					if f13_local15 == f13_local2 then
						f13_local4 = true
						break
					end
				end
				if not f13_local4 then
					f13_local3 = false
				end
			end
			if f13_local3 then
				f13_local7 = f13_arg0.body.buttonList:addGametypeSettingLeftRightSelector(f13_arg0.panelManager.m_ownerController, Engine.Localize(f13_local17.name), f13_local17.id, Engine.Localize(f13_local17.hintText), f13_local1)
				for f13_local11 = 1, #f13_local17.labels, 1 do
					f13_local7:addChoice(f13_arg0.panelManager.m_ownerController, Engine.Localize(f13_local17.labels[f13_local11]), f13_local17.values[f13_local11])
				end
				f13_local7:registerEventHandler("gain_focus", CoD.PrivateGameLobby.ButtonGainFocusZombie)
				f13_local7:registerEventHandler("lose_focus", CoD.PrivateGameLobby.ButtonLoseFocusZombie)
				f13_local7:registerEventHandler("start_game", f13_local7.disable)
				f13_local7:registerEventHandler("cancel_start_game", f13_local7.enable)
				f13_local7:registerEventHandler("gamelobby_update", CoD.PrivateGameLobby.ButtonGameLobbyUpdate_Zombie)
			end
		end
		f13_arg0:registerEventHandler("enable_sliding_zm", CoD.PrivateGameLobby.EnableSlidingZombie)
		f13_arg0.defaultFocusButton = f13_arg0.body.startMatchButton
		f13_arg0.body.buttonList.hintText:setAlpha(1)
		if true == CoD.useController and not f13_arg0:restoreState() then
			f13_arg0.body.buttonList:selectElementIndex(1)
		end
	else
		f13_arg0.defaultFocusButton = nil
		f13_arg0.body.buttonList.hintText:setAlpha(0)
	end
	if f13_arg0.menuName ~= "TheaterLobby" then
		CoD.GameGlobeZombie.MoveToUpDirectly()
	end
end

CoD.PrivateGameLobby.ButtonGameLobbyUpdate_Zombie = function (f14_arg0, f14_arg1)
	f14_arg0:refreshChoice()
	f14_arg0:dispatchEventToChildren(f14_arg1)
end

CoD.PrivateGameLobby.ButtonGainFocusZombie = function (f15_arg0, f15_arg1)
	CoD.CoD9Button.GainFocus(f15_arg0, f15_arg1)
	f15_arg0:dispatchEventToParent({
		name = "enable_sliding_zm",
		enableSliding = false,
		controller = f15_arg1.controller
	})
end

CoD.PrivateGameLobby.ButtonLoseFocusZombie = function (f16_arg0, f16_arg1)
	CoD.CoD9Button.LoseFocus(f16_arg0, f16_arg1)
	f16_arg0:dispatchEventToParent({
		name = "enable_sliding_zm",
		enableSliding = true,
		controller = f16_arg1.controller
	})
end

CoD.PrivateGameLobby.EnableSlidingZombie = function (f17_arg0, f17_arg1)
	f17_arg0.panelManager.slidingEnabled = f17_arg1.enableSliding
end

CoD.PrivateGameLobby.PopulateButtonPrompts_Project_Multiplayer = function (f18_arg0)

end

CoD.PrivateGameLobby.PopulateButtonPrompts_Project_Zombie = function (f19_arg0)

end

CoD.PrivateGameLobby.PopulateButtons_Project = function (f20_arg0, f20_arg1)
	if CoD.isZombie == true then
		CoD.PrivateGameLobby.PopulateButtons_Project_Zombie(f20_arg0, f20_arg1)
	else
		CoD.PrivateGameLobby.PopulateButtons_Project_Multiplayer(f20_arg0, f20_arg1)
	end
end

local f0_local0 = function (f21_arg0, f21_arg1)
	if Engine.GetGametypeSetting("allowSpectating") == 1 then
		return true
	elseif Engine.GetGametypeSetting("autoTeamBalance") == 1 then
		return false
	elseif CoD.IsGametypeTeamBased() == true then
		if CoD.isZombie == true and Engine.GetGametypeSetting("teamCount") == 1 then
			return false
		else
			return true
		end
	else
		return false
	end
end

CoD.PrivateGameLobby.PopulateButtonPrompts_Project = function (f22_arg0)
	if CoD.isZombie == true then
		CoD.PrivateGameLobby.PopulateButtonPrompts_Project_Zombie(f22_arg0, isHost)
	else
		CoD.PrivateGameLobby.PopulateButtonPrompts_Project_Multiplayer(f22_arg0, isHost)
	end
	if f22_arg0.cycleTeamButtonPrompt ~= nil then
		f22_arg0.cycleTeamButtonPrompt:close()
	end
	if f0_local0() then
		local f22_local0 = CoD.DualButtonPrompt.new
		local f22_local1 = "shoulderl"
		local f22_local2 = Engine.Localize("MPUI_CHANGE_ROLE")
		local f22_local3 = "shoulderr"
		local f22_local4 = f22_arg0
		local f22_local5 = "button_prompt_team_prev"
		local f22_local6 = "button_prompt_team_next"
		local f22_local7, f22_local8, f22_local9, f22_local10, f22_local11 = false
		f22_arg0.cycleTeamButtonPrompt = f22_local0(f22_local1, f22_local2, f22_local3, f22_local4, f22_local5, f22_local6, f22_local7, f22_local8, f22_local9, f22_local10, f22_local11, "A", "D")
		CoD.PrivateGameLobby.SetupTeamCycling(f22_arg0)
		f22_arg0:addRightButtonPrompt(f22_arg0.cycleTeamButtonPrompt)
		f22_arg0:registerEventHandler("button_prompt_team_prev", CoD.PrivateGameLobby.ButtonPrompt_TeamPrev)
		f22_arg0:registerEventHandler("button_prompt_team_next", CoD.PrivateGameLobby.ButtonPrompt_TeamNext)
		f22_arg0:registerEventHandler("current_panel_changed", CoD.PrivateGameLobby.CurrentPanelChanged)
		f22_arg0:registerEventHandler("party_update_status", CoD.PrivateGameLobby.ButtonPrompt_PartyUpdateStatus)
	else
		f22_arg0:registerEventHandler("party_update_status", CoD.GameLobby.UpdateStatusText)
	end
end

CoD.PrivateGameLobby.LeaveLobby_Project_Multiplayer = function (f23_arg0, f23_arg1)
	Engine.SetDvar("invite_visible", 1)
	Engine.SetGametype(Dvar.ui_gametype:get())
	local f23_local0 = UIExpression.PrivatePartyHost(f23_arg1.controller)
	if Engine.SessionModeIsMode(CoD.SESSIONMODE_OFFLINE) == true or Engine.SessionModeIsMode(CoD.SESSIONMODE_SYSTEMLINK) == true then
		Engine.ExecNow(f23_arg1.controller, "xstopallparties")
		CoD.resetGameModes()
		if CoD.isPS3 then
			Engine.ExecNow(f23_arg1.controller, "signoutSubUsers")
		end
	elseif Engine.SessionModeIsMode(CoD.SESSIONMODE_PRIVATE) == true then
		if f23_local0 == 0 or f23_arg1.name ~= nil and f23_arg1.name == "confirm_leave_alone" then
			Engine.ExecNow(f23_arg1.controller, "xstopallparties")
		else
			Engine.ExecNow(f23_arg1.controller, "xstoppartykeeptogether")
		end
		CoD.resetGameModes()
		CoD.StartMainLobby(f23_arg1.controller)
	elseif Engine.IsSignedInToDemonware(f23_arg1.controller) == true and Engine.HasMPPrivileges(f23_arg1.controller) == true then
		Engine.ExecNow(f23_arg1.controller, "xstoppartykeeptogether")
		CoD.resetGameModes()
		CoD.StartMainLobby(f23_arg1.controller)
	else
		Engine.ExecNow(f23_arg1.controller, "xstopprivateparty")
		CoD.resetGameModes()
	end
	Engine.SessionModeSetPrivate(false)
	f23_arg0:processEvent({
		name = "lose_host"
	})
	f23_arg0:goBack(f23_arg1)
end

CoD.PrivateGameLobby.LeaveLobby_Project_Zombie_After_Animation = function (f24_arg0, f24_arg1)
	CoD.PrivateGameLobby.LeaveLobby_Project_Multiplayer(f24_arg0, {
		name = f24_arg0.leaveType,
		controller = f24_arg1.controller
	})
	f24_arg0.leaveType = nil
end

CoD.PrivateGameLobby.LeaveLobby_Project_Zombie = function (f25_arg0, f25_arg1)
	f25_arg0.leaveType = f25_arg1.name
	if not CoD.isPC then
		f25_arg0:registerEventHandler("confirm_leave_animfinished", CoD.PrivateGameLobby.LeaveLobby_Project_Zombie_After_Animation)
	end
	CoD.GameGlobeZombie.gameGlobe.currentMenu = f25_arg0
	if f25_arg0.menuName == "TheaterLobby" then
		CoD.GameGlobeZombie.MoveToCornerFromUp(f25_arg1.controller, false)
	else
		CoD.GameGlobeZombie.MoveToCornerFromUp(f25_arg1.controller)
	end
	if CoD.isPC then
		CoD.PrivateGameLobby.LeaveLobby_Project_Zombie_After_Animation(f25_arg0, f25_arg1)
	end
end

CoD.PrivateGameLobby.LeaveLobby_Project = function (f26_arg0, f26_arg1)
	if CoD.isZombie == true then
		CoD.PrivateGameLobby.LeaveLobby_Project_Zombie(f26_arg0, f26_arg1)
	else
		CoD.PrivateGameLobby.LeaveLobby_Project_Multiplayer(f26_arg0, f26_arg1)
	end
end

CoD.PrivateGameLobby.OpenChangeStartLoc = function (f27_arg0, f27_arg1)
	Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_SELECTING_GAMETYPE)
	local f27_local0 = f27_arg0:openMenu("SelectStartLocZM", f27_arg1.controller)
	f27_local0:setPreviousMenu("SelectMapZM")
	CoD.SelectStartLocZombie.GoToPreChoices(f27_local0, f27_arg1)
	f27_arg0:close()
end

CoD.PrivateGameLobby.OpenSetupGameFlyout = function (f28_arg0, f28_arg1)
	if f28_arg0.buttonPane ~= nil and f28_arg0.buttonPane.body ~= nil then
		CoD.PrivateGameLobby.RemoveSetupGameFlyout(f28_arg0.buttonPane)
		CoD.PrivateGameLobby.AddSetupGameFlyout(f28_arg0.buttonPane)
		f28_arg0.panelManager.slidingEnabled = false
		CoD.ButtonList.DisableInput(f28_arg0.buttonPane.body.buttonList)
		f28_arg0.buttonPane.body.buttonList:animateToState("disabled")
		f28_arg0.buttonPane.body.setupGameFlyoutContainer:processEvent({
			name = "gain_focus"
		})
		f28_arg0:registerEventHandler("button_prompt_back", CoD.PrivateGameLobby.CloseSetupGameFlyout)
	end
end

CoD.PrivateGameLobby.CloseSetupGameFlyout = function (f29_arg0, f29_arg1)
	if f29_arg0.buttonPane ~= nil and f29_arg0.buttonPane.body ~= nil and f29_arg0.buttonPane.body.setupGameFlyoutContainer ~= nil then
		CoD.PrivateGameLobby.RemoveSetupGameFlyout(f29_arg0.buttonPane)
		CoD.ButtonList.EnableInput(f29_arg0.buttonPane.body.buttonList)
		f29_arg0.buttonPane.body.buttonList:animateToState("default")
		f29_arg0:registerEventHandler("button_prompt_back", CoD.PrivateGameLobby.ButtonBack)
		f29_arg0.panelManager.slidingEnabled = true
		Engine.PlaySound("cac_cmn_backout")
	end
end

CoD.PrivateGameLobby.OpenBotsMenu = function (f30_arg0, f30_arg1)
	Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_EDITING_GAME_OPTIONS)
	f30_arg0:openPopup("EditBotOptions", f30_arg1.controller)
	Engine.PlaySound("cac_screen_fade")
end

CoD.PrivateGameLobby.OpenChangeMap = function (f31_arg0, f31_arg1)
	Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_SELECTING_MAP)
	f31_arg0:openPopup("ChangeMap", f31_arg1.controller)
	Engine.PlaySound("cac_screen_fade")
end

CoD.PrivateGameLobby.OpenChangeGameMode = function (f32_arg0, f32_arg1)
	Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_SELECTING_GAMETYPE)
	f32_arg0:openPopup("ChangeGameMode", f32_arg1.controller)
	Engine.PlaySound("cac_screen_fade")
end

CoD.PrivateGameLobby.OpenEditGameOptionsMenu = function (f33_arg0, f33_arg1)
	Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_EDITING_GAME_OPTIONS)
	f33_arg0:openPopup("EditGameOptions", f33_arg1.controller)
	Engine.PlaySound("cac_screen_fade")
end

CoD.PrivateGameLobby.OpenViewGameOptionsMenu = function (f34_arg0, f34_arg1)
	Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_EDITING_GAME_OPTIONS)
	f34_arg0:openPopup("ViewGameOptions", f34_arg1.controller)
end

CoD.PrivateGameLobby.CloseAllPopups = function (f35_arg0, f35_arg1)
	CoD.PrivateGameLobby.CloseSetupGameFlyout(f35_arg0, f35_arg1)
	CoD.Menu.MenuChanged(f35_arg0, f35_arg1)
end

CoD.PrivateGameLobby.RegisterEventHandler_Project = function (f36_arg0)
	if CoD.isZombie == true then
		f36_arg0:registerEventHandler("open_change_startLoc", CoD.PrivateGameLobby.OpenChangeStartLoc)
	else
		f36_arg0:registerEventHandler("open_setup_game_flyout", CoD.PrivateGameLobby.OpenSetupGameFlyout)
		f36_arg0:registerEventHandler("open_bots_menu", CoD.PrivateGameLobby.OpenBotsMenu)
		f36_arg0:registerEventHandler("open_change_map", CoD.PrivateGameLobby.OpenChangeMap)
		f36_arg0:registerEventHandler("open_change_game_mode", CoD.PrivateGameLobby.OpenChangeGameMode)
		f36_arg0:registerEventHandler("open_editGameOptions_menu", CoD.PrivateGameLobby.OpenEditGameOptionsMenu)
		f36_arg0:registerEventHandler("open_viewGameOptions_menu", CoD.PrivateGameLobby.OpenViewGameOptionsMenu)
		f36_arg0:registerEventHandler("close_all_popups", CoD.PrivateGameLobby.CloseAllPopups)
	end
end

