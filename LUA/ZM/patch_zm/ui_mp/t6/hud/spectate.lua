require("T6.HUD.LowerOptionsBar")
require("LUI.LUIHorizontalList")
require("LUI.LUITimer")
require("T6.HUD.SpectateButtonBar")
require("T6.HUD.SpectatePlayercard")
require("T6.HUD.SpectateSidePanel")
require("T6.HUD.SpectateTopPanel")
CoD.SpectateHUD = InheritFrom(LUI.UIElement)
CoD.SpectateHUD.HUDToggleEverthing = 1
CoD.SpectateHUD.HUDToggleNoButtonBar = 2
CoD.SpectateHUD.HUDToggle = 0
CoD.SpectateHUD.TeamIcons = {}
CoD.SpectateHUD.TeamColors = {}
CoD.SpectateHUD.TeamColorAlpha = 0.8
CoD.SpectateHUD.ViewportScale = 0.58
CoD.SpectateHUD.ScreenWidth = 1280
CoD.SpectateHUD.ScreenHeight = 720
CoD.SpectateHUD.BgAlpha = 0.8
CoD.SpectateHUD.MaterialBg = nil
CoD.SpectateHUD.MaterialEdge = nil
CoD.SpectateHUD.EdgeSize = 8
CoD.SpectateHUD.MapDimension = 700
CoD.SpectateHUD.LoDefDimension = 450
CoD.SpectateHUD.ControlsOpen = function (f1_arg0, f1_arg1)
	if Engine.IsDemoShoutcaster() and CoD.DemoHUD.LastActivatedInformationScreen == CoD.DEMO_INFORMATION_SCREEN_FILM_START_SCREEN_FADE_IN then
		return 
	end
	Engine.LockInput(f1_arg0.m_ownerController, true)
	f1_arg0.buttonBar:processEvent({
		name = "spectate_disable_input"
	})
	f1_arg0.playercard:processEvent({
		name = "hide_switch_player_bar"
	})
	f1_arg0.buttonBar:setFullscreen(false, f1_arg0.sidePanel.tabManager.tabSelected)
	f1_arg0.sidePanel.tabManager:enable()
	local f1_local0 = f1_arg0.playerCount
	CoD.SpectateHUD.UpdatePlayerCount(f1_arg0)
	if f1_arg0.playerCount ~= f1_local0 then
		CoD.SpectateHUD.UpdateMapInPlayerColumn(f1_arg0)
	end
	if f1_arg0.overheadMap.fullScreenMap then
		f1_arg0.overheadMap:animateToState("move_left", 200)
	elseif f1_arg0.overheadMap.mapInPlayerColumn then
		f1_arg0.overheadMap:animateToState("minimize", 0)
		f1_arg0.overheadMap:setAlpha(1)
		f1_arg0.overheadMapBackground:animateToState("minimize", 0)
	end
	f1_arg0.sidePanel:processEvent({
		name = "slide_in",
		controller = f1_arg0.m_ownerController
	})
	if f1_arg0.buttonBarTimer ~= nil then
		f1_arg0.buttonBarTimer:close()
		f1_arg0.buttonBarTimer = nil
	end
	f1_arg0.buttonBarTimer = LUI.UITimer.new(350, "spectate_enable_input", true, f1_arg0.buttonBar)
	f1_arg0:addElement(f1_arg0.buttonBarTimer)
	LUI.UIElement.animateViewport(f1_arg0, f1_arg0.m_ownerController, 1, CoD.SpectateHUD.ViewportScale, 200)
	f1_arg0.m_controlsOpen = true
	if f1_arg0.m_scoreboardOpened == true then
		CoD.SpectateHUD.ScoreboardClosedAction(f1_arg0)
	end
	local f1_local1 = 1 + CoD.SpectateHUD.ViewportScale - 1
	local f1_local2 = CoD.SpectateHUD.ScreenWidth * (0.1 - f1_local1 / 10)
	local f1_local3 = CoD.SpectateHUD.ScreenHeight * (0.5 - f1_local1 / 2)
	local f1_local4 = CoD.SpectateHUD.ScreenWidth * CoD.SpectateHUD.ViewportScale
	local f1_local5 = CoD.SpectateHUD.ScreenHeight * CoD.SpectateHUD.ViewportScale
	local f1_local6 = (CoD.SpectateHUD.ScreenWidth - f1_arg0.m_safeAreaWidth) / 2
	local f1_local7 = (CoD.SpectateHUD.ScreenHeight - f1_arg0.m_safeAreaHeight) / 2
	local f1_local8 = -(f1_local6 - f1_local2)
	local f1_local9 = -(f1_local7 - f1_local3)
	f1_arg0.buttonBar:slideLeft(f1_local8, f1_local4)
	f1_arg0.playercard:dock(f1_local8, f1_local9, f1_local5)
	if CoD.isPC then
		Engine.SetForceMouseRootFull(true)
	end
	f1_arg0:dispatchEventToChildren({
		name = "spectate_dock",
		safeX = f1_local8,
		safeY = f1_local9,
		viewportWidth = f1_local4,
		viewportHeight = f1_local5,
		controller = f1_arg0.m_ownerController
	})
end

CoD.SpectateHUD.ControlsClose = function (f2_arg0, f2_arg1)
	Engine.LockInput(f2_arg0.m_ownerController, true)
	f2_arg0.buttonBar:processEvent({
		name = "spectate_disable_input"
	})
	if CoD.SpectateHUD.HUDToggle == CoD.SpectateHUD.HUDToggleEverthing then
		f2_arg0.playercard:processEvent({
			name = "show_switch_player_bar"
		})
	end
	f2_arg0.buttonBar:setFullscreen(true, nil)
	f2_arg0.sidePanel.tabManager:disable()
	if f2_arg0.overheadMap.fullScreenMap then
		f2_arg0.overheadMap:animateToState("default", 200)
	elseif f2_arg0.overheadMap.mapInPlayerColumn then
		f2_arg0.overheadMap:animateToState("default", 0)
		f2_arg0.overheadMapBackground:animateToState("default", 0)
		f2_arg0.overheadMap:setAlpha(0)
		f2_arg0.overheadMapBackground:setAlpha(0)
	end
	f2_arg0.sidePanel:processEvent({
		name = "slide_out",
		controller = f2_arg0.m_ownerController
	})
	if f2_arg0.buttonBarTimer ~= nil then
		f2_arg0.buttonBarTimer:close()
		f2_arg0.buttonBarTimer = nil
	end
	if f2_arg0.controlsTimer ~= nil then
		f2_arg0.controlsTimer:close()
		f2_arg0.controlsTimer = nil
	end
	f2_arg0.controlsTimer = LUI.UITimer.new(350, "spectate_unlock_controls", true, f2_arg0)
	f2_arg0:addElement(f2_arg0.controlsTimer)
	f2_arg0.buttonBarTimer = LUI.UITimer.new(350, "spectate_enable_input", true, f2_arg0)
	f2_arg0:addElement(f2_arg0.buttonBarTimer)
	LUI.UIElement.animateViewport(f2_arg0, f2_arg0.m_ownerController, CoD.SpectateHUD.ViewportScale, 1, 200)
	f2_arg0.m_controlsOpen = false
	if f2_arg0.m_scoreboardOpened == true then
		CoD.SpectateHUD.ScoreboardOpenedAction(f2_arg0)
	end
	f2_arg0.buttonBar:slideRight()
	f2_arg0.playercard:undock()
	if CoD.isPC then
		Engine.SetForceMouseRootFull(false)
	end
	f2_arg0:dispatchEventToChildren({
		name = "spectate_undock",
		controller = f2_arg0.m_ownerController
	})
end

CoD.SpectateHUD.EnableInput = function (f3_arg0, f3_arg1)
	if f3_arg0.m_hasShutdown == false then
		f3_arg0.buttonBar:processEvent(f3_arg1)
	end
end

CoD.SpectateHUD.UnlockControls = function (f4_arg0, f4_arg1)
	Engine.LockInput(f4_arg0.m_ownerController, false)
end

CoD.SpectateHUD.PlayerSelected = function (f5_arg0, f5_arg1)
	f5_arg0:processEvent({
		name = "update_spectate_hud",
		controller = f5_arg1.controller
	})
end

CoD.SpectateHUD.HideSpectateHud = function (f6_arg0, f6_arg1)
	f6_arg0:dispatchEventToChildren(f6_arg1)
end

CoD.SpectateHUD.ShowSpectateHud = function (f7_arg0, f7_arg1)
	f7_arg0:dispatchEventToChildren(f7_arg1)
end

CoD.SpectateHUD.ToggleHUDVisibility = function (f8_arg0, f8_arg1)
	if Engine.IsDemoShoutcaster() then
		return 
	elseif CoD.SpectateHUD.HUDToggle == CoD.SpectateHUD.HUDToggleEverthing then
		f8_arg0.buttonBar:processEvent({
			name = "hide_spectate_hud",
			controller = f8_arg1.controller
		})
		f8_arg0.playercard:processEvent({
			name = "hide_switch_player_bar",
			controller = f8_arg1.controller
		})
		CoD.SpectateHUD.HUDToggle = CoD.SpectateHUD.HUDToggleNoButtonBar
	elseif CoD.SpectateHUD.HUDToggle == CoD.SpectateHUD.HUDToggleNoButtonBar then
		if f8_arg0.m_controlsOpen == false then
			f8_arg0.playercard:processEvent({
				name = "show_switch_player_bar",
				controller = f8_arg1.controller
			})
		end
		f8_arg0.buttonBar:processEvent({
			name = "show_spectate_hud",
			controller = f8_arg1.controller
		})
		CoD.SpectateHUD.HUDToggle = CoD.SpectateHUD.HUDToggleEverthing
	end
end

CoD.SpectateHUD.ScoreboardOpenedAction = function (f9_arg0)
	f9_arg0:setAlpha(0)
	Engine.LockInput(f9_arg0.m_ownerController, true)
end

CoD.SpectateHUD.ScoreboardClosedAction = function (f10_arg0)
	f10_arg0:setAlpha(1)
	Engine.LockInput(f10_arg0.m_ownerController, false)
end

CoD.SpectateHUD.ScoreboardOpened = function (f11_arg0, f11_arg1)
	f11_arg0.buttonBar:setMode(CoD.SpectateButtonBar.MODE_SCOREBOARD)
	if f11_arg0.m_scoreboardOpened == false then
		f11_arg0.m_scoreboardOpened = true
		if f11_arg0.m_controlsOpen == false then
			CoD.SpectateHUD.ScoreboardOpenedAction(f11_arg0)
		end
	end
end

CoD.SpectateHUD.ScoreboardClosed = function (f12_arg0, f12_arg1)
	f12_arg0.buttonBar:setMode(CoD.SpectateButtonBar.MODE_DEFAULT)
	if f12_arg0.m_scoreboardOpened == true then
		f12_arg0.m_scoreboardOpened = false
		CoD.SpectateHUD.ScoreboardClosedAction(f12_arg0)
	end
end

CoD.SpectateHUD.ScoreboardToggle = function (f13_arg0, f13_arg1)
	Engine.Exec(f13_arg0.m_ownerController, "cg_toggleScores")
end

CoD.SpectateHUD.Off = function (f14_arg0, f14_arg1)
	f14_arg0:setAlpha(0)
	f14_arg0.buttonBar:processEvent({
		name = "spectate_disable_input"
	})
end

CoD.SpectateHUD.On = function (f15_arg0, f15_arg1)
	f15_arg0:setAlpha(1)
	f15_arg0.buttonBar:processEvent({
		name = "spectate_enable_input"
	})
end

CoD.SpectateHUD.UpdateVisibility = function (f16_arg0, f16_arg1)
	if Engine.IsDemoShoutcaster() then
		return 
	elseif UIExpression.IsVisibilityBitSet(f16_arg1.controller, CoD.BIT_FINAL_KILLCAM) == 1 or UIExpression.IsVisibilityBitSet(f16_arg1.controller, CoD.BIT_IN_KILLCAM) == 1 then
		if f16_arg0.m_controlsOpen then
			f16_arg0:processEvent({
				name = "spectate_controls_close",
				controller = f16_arg1.controller
			})
		end
		CoD.SpectateHUD.Off(f16_arg0, nil)
	else
		CoD.SpectateHUD.On(f16_arg0, nil)
	end
end

CoD.SpectateHUD.PlayerListenIn = function (f17_arg0, f17_arg1)
	Engine.Exec(f17_arg0, "shoutcastAddListenIn " .. f17_arg1)
end

CoD.SpectateHUD.TeamListenIn = function (f18_arg0, f18_arg1)
	local f18_local0 = Engine.GetInGamePlayerList(f18_arg0, f18_arg1, false)
	if f18_local0 ~= nil then
		for f18_local1 = 1, #f18_local0, 1 do
			CoD.SpectateHUD.PlayerListenIn(f18_arg0, f18_local0[f18_local1].clientNum)
		end
	end
end

CoD.SpectateHUD.AllListenIn = function (f19_arg0)
	Engine.Exec(f19_arg0, "shoutcastSetListenIn")
end

CoD.SpectateHUD.ListenIn = function (f20_arg0, f20_arg1)
	Engine.Exec(f20_arg0.m_ownerController, "shoutcastResetListenIn")
	if Engine.GetGametypeSetting("teamCount") == 1 then
		if f20_arg0.m_listenInTeam == nil then
			CoD.SpectateHUD.AllListenIn(f20_arg0.m_ownerController)
			f20_arg0.m_listenInTeam = CoD.TEAM_FREE
		else
			f20_arg0.m_listenInTeam = nil
		end
	else
		local f20_local0 = Dvar.shoutcastHighlightedClient:get()
		if f20_local0 ~= -1 then
			local f20_local1 = Engine.GetTeamID(f20_arg0.m_ownerController, f20_local0)
			if f20_local1 ~= -1 then
				if f20_arg0.m_listenInTeam ~= f20_local1 then
					CoD.SpectateHUD.TeamListenIn(f20_arg0.m_ownerController, f20_local1)
					f20_arg0.m_listenInTeam = f20_local1
				else
					f20_arg0.m_listenInTeam = nil
				end
			end
		end
	end
	f20_arg0.sidePanel:listenIn(f20_arg0.m_listenInTeam)
end

CoD.SpectateHUD.ToggleOverheadMap = function (f21_arg0, f21_arg1)
	if f21_arg0.overheadMap.fullScreenMap then
		if f21_arg0.m_controlsOpen and f21_arg0.overheadMap.mapInPlayerColumn then
			if f21_arg0.sidePanel.tabManager.tabSelected == CoD.SpectateSidePanel.PlayersTabIndex then
				f21_arg0.overheadMap:animateToState("minimize", 200)
				f21_arg0.overheadMap:setAlpha(1)
				f21_arg0.overheadMapBackground:animateToState("minimize", 200)
			else
				f21_arg0.overheadMap:animateToState("minimize", 200)
				f21_arg0.overheadMap:setAlpha(0)
				f21_arg0.overheadMapBackground:animateToState("minimize", 200)
				f21_arg0.overheadMapBackground:setAlpha(0)
			end
		else
			f21_arg0.overheadMap:animateToState("default", 0)
			f21_arg0.overheadMap:setAlpha(0)
			f21_arg0.overheadMapBackground:animateToState("default", 0)
			f21_arg0.overheadMapBackground:setAlpha(0)
		end
		f21_arg0.overheadMap.fullScreenMap = false
		f21_arg0.buttonBar:setMode(CoD.SpectateButtonBar.MODE_DEFAULT)
	else
		if f21_arg0.m_controlsOpen then
			if not f21_arg0.overheadMap.mapInPlayerColumn then
				f21_arg0.overheadMap:animateToState("move_left", 0)
				f21_arg0.overheadMap:setAlpha(1)
				f21_arg0.overheadMapBackground:animateToState("default", 0)
				f21_arg0.overheadMapBackground:setAlpha(1)
			else
				f21_arg0.overheadMap:animateToState("move_left", 200)
				f21_arg0.overheadMap:setAlpha(1)
				f21_arg0.overheadMapBackground:animateToState("default", 200)
				f21_arg0.overheadMapBackground:setAlpha(1)
			end
		else
			f21_arg0.overheadMap:animateToState("default", 0)
			f21_arg0.overheadMap:setAlpha(1)
			f21_arg0.overheadMapBackground:animateToState("default", 0)
			f21_arg0.overheadMapBackground:setAlpha(1)
		end
		f21_arg0.overheadMap.fullScreenMap = true
		f21_arg0.buttonBar:setMode(CoD.SpectateButtonBar.MODE_MAP)
	end
end

CoD.SpectateHUD.UpdateScores = function (f22_arg0, f22_arg1)
	if f22_arg0.m_hasShutdown == true then
		return 
	else
		f22_arg1.teams = Engine.GetTeamPositions(f22_arg0.m_ownerController)
		f22_arg0:dispatchEventToChildren(f22_arg1)
	end
end

CoD.SpectateHUD.GetTeamColor = function (f23_arg0)
	if f23_arg0 == CoD.TEAM_FREE then
		return 0.1, 0.1, 0.1, 1
	elseif f23_arg0 < CoD.TEAM_FREE or CoD.TEAM_SIX < f23_arg0 then
		return 0, 0, 0, 1
	else
		local f23_local0 = CoD.SpectateHUD.TeamColors[f23_arg0]
		return f23_local0.r, f23_local0.g, f23_local0.b, CoD.SpectateHUD.TeamColorAlpha
	end
end

CoD.SpectateHUD.GetTeamIcon = function (f24_arg0)
	if f24_arg0 == CoD.TEAM_FREE then
		return nil
	elseif f24_arg0 < CoD.TEAM_FREE or CoD.TEAM_SIX < f24_arg0 then
		return 0, 0, 0
	else
		return CoD.SpectateHUD.TeamIcons[f24_arg0]
	end
end

CoD.SpectateHUD.Shutdown = function (f25_arg0, f25_arg1)
	if UIExpression.IsVisibilityBitSet(f25_arg0.m_ownerController, CoD.BIT_GAME_ENDED) == 0 then
		return 
	elseif Engine.IsDemoShoutcaster() == true then
		return 
	elseif f25_arg0.m_controlsOpen then
		Engine.SetViewport(f25_arg0.m_ownerController, 0, 0, 1)
	end
	Engine.Exec(controller, "shoutcastResetListenIn")
	f25_arg0.buttonBar:processEvent({
		name = "spectate_disable_input"
	})
	f25_arg0:setAlpha(0)
	f25_arg0.m_hasShutdown = true
end

CoD.SpectateHUD.new = function (f26_arg0)
	local f26_local0, f26_local1 = Engine.GetUserSafeArea()
	local f26_local2 = Dvar.hiDef:get()
	local f26_local3 = Dvar.wideScreen
	local f26_local4 = f26_local3
	f26_local3 = f26_local3.get
	local f26_local5 = f26_local3(f26_local4)
	local f26_local6 = CoD
	f26_local3.SpectateHUD.ViewportScale = 0.52
	f26_local6 = CoD
	f26_local6 = f26_local3.SpectateHUD
	f26_local6.ScreenWidth = 960
	f26_local3 = f26_local2 and f26_local5 or f26_local6
	f26_local6 = LUI
	f26_local3 = f26_local3.UIContainer.new()
	f26_local3:setClass(CoD.SpectateHUD)
	f26_local3:setPriority(-50)
	f26_local3.m_ownerController = f26_arg0.controller
	f26_local3.m_selectedClientNum = nil
	f26_local3.m_listenInTeam = nil
	f26_local3.m_scoreboardOpened = false
	f26_local3.m_hasShutdown = false
	f26_local3.m_safeAreaWidth = f26_local0
	f26_local3.m_safeAreaHeight = f26_local1
	f26_local3.m_controlsOpen = false
	f26_local3.playerCount = 0
	CoD.SpectateHUD.MaterialBg = RegisterMaterial("spectator_box_middle")
	CoD.SpectateHUD.MaterialEdge = RegisterMaterial("spectator_box_end")
	for f26_local4 = CoD.TEAM_FREE + 1, CoD.TEAM_SIX, 1 do
		local f26_local9 = Engine.GetFactionForTeam(f26_local4)
		local f26_local10, f26_local11, f26_local12 = Engine.GetFactionColor(f26_local9)
		CoD.SpectateHUD.TeamIcons[f26_local4] = RegisterMaterial("faction_" .. f26_local9)
		CoD.SpectateHUD.TeamColors[f26_local4] = {}
		CoD.SpectateHUD.TeamColors[f26_local4].r = f26_local10
		CoD.SpectateHUD.TeamColors[f26_local4].g = f26_local11
		CoD.SpectateHUD.TeamColors[f26_local4].b = f26_local12
	end
	f26_local3.playercard = CoD.SpectatePlayercard.new(f26_arg0.controller)
	f26_local3.topPanel = CoD.SpectateTopPanel.new(f26_arg0.controller)
	f26_local3.sidePanel = CoD.SpectateSidePanel.new(f26_arg0.controller, CoD.SpectateHUD.ScreenWidth)
	f26_local3.buttonBar = CoD.SpectateButtonBar.new(f26_arg0.controller, f26_local0, CoD.SpectateHUD.ScreenWidth)
	f26_local3.overheadMapContainer = LUI.UIContainer.new()
	f26_local3.overheadMapBackground = LUI.UIImage.new({
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		red = 0.08,
		green = 0.08,
		blue = 0.08
	})
	f26_local3.overheadMapBackground:registerAnimationState("minimize", {
		alpha = 0
	})
	f26_local3.overheadMapBackground:setPriority(-100)
	f26_local3.overheadMapBackground:setAlpha(0)
	f26_local3.overheadMapContainer:addElement(f26_local3.overheadMapBackground)
	f26_local3.overheadMap = CoD.Compass.new({
		left = -CoD.SpectateHUD.MapDimension / 2,
		top = -CoD.SpectateHUD.MapDimension / 2,
		right = CoD.SpectateHUD.MapDimension / 2,
		bottom = CoD.SpectateHUD.MapDimension / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	}, CoD.COMPASS_TYPE_FULL)
	if Dvar.hiDef:get() and not CoD.isPC then
		f26_local3.overheadMap:registerAnimationState("move_left", {
			left = -CoD.SpectateHUD.MapDimension / 2 - 225,
			top = -CoD.SpectateHUD.MapDimension / 2,
			right = CoD.SpectateHUD.MapDimension / 2 - 225,
			bottom = CoD.SpectateHUD.MapDimension / 2,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false
		})
	else
		f26_local3.overheadMap:registerAnimationState("move_left", {
			left = -CoD.SpectateHUD.LoDefDimension / 2 - 225,
			top = -CoD.SpectateHUD.LoDefDimension / 2,
			right = CoD.SpectateHUD.LoDefDimension / 2 - 225,
			bottom = CoD.SpectateHUD.LoDefDimension / 2,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false
		})
	end
	f26_local4 = (CoD.SpectateHUD.ScreenWidth - f26_local3.m_safeAreaWidth) / 2
	local f26_local7 = (CoD.SpectateHUD.ScreenHeight - f26_local3.m_safeAreaHeight) / 2
	local f26_local8 = 96 - f26_local4
	local f26_local13 = 54 - f26_local7
	f26_local3.overheadMap:registerAnimationState("minimize", {
		left = f26_local0 / 2 - 340 - f26_local8,
		top = f26_local1 / 2 - 300 - f26_local13,
		right = f26_local0 / 2 - f26_local8,
		bottom = f26_local1 / 2 - 20 - f26_local13,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	f26_local3.overheadMap:setPriority(100)
	f26_local3.overheadMap:setAlpha(0)
	f26_local3.overheadMapContainer:addElement(f26_local3.overheadMap)
	f26_local3.overheadMap.fullScreenMap = false
	CoD.SpectateHUD.UpdateMapInPlayerColumn(f26_local3)
	f26_local3.overlayContainer = LUI.UIContainer.new()
	f26_local3.overlayContainer:setLeftRight(false, false, -f26_local0 / 2, f26_local0 / 2)
	f26_local3.overlayContainer:setTopBottom(false, false, -f26_local1 / 2, f26_local1 / 2)
	f26_local3.overlayContainer:addElement(f26_local3.playercard)
	f26_local3.overlayContainer:addElement(f26_local3.topPanel)
	f26_local3.overlayContainer:addElement(f26_local3.buttonBar)
	f26_local3.overlayContainer:addElement(f26_local3.sidePanel)
	f26_local3:addElement(f26_local3.overheadMapContainer)
	f26_local3:addElement(f26_local3.overlayContainer)
	CoD.SpectateHUD.HUDToggle = CoD.SpectateHUD.HUDToggleEverthing
	if Engine.IsDemoShoutcaster() then
		CoD.SpectateButtonBar.Hide(f26_local3.buttonBar, f26_arg0)
		f26_local3.playercard.switchPlayerBar:setAlpha(0)
		CoD.SpectateHUD.HUDToggle = CoD.SpectateHUD.HUDToggleNoButtonBar
	end
	return f26_local3
end

CoD.SpectateHUD.FirstSnapshot = function (f27_arg0, f27_arg1)
	if f27_arg0.m_controlsOpen then
		if Engine.IsDemoShoutcaster() then
			Engine.SetViewport(f27_arg0.m_ownerController, 0, 0, 1)
			f27_arg0:dispatchEventToRoot({
				name = "update_safe_area",
				controller = f27_arg0.m_ownerController
			})
			f27_arg0.m_gameHUD:dispatchEventToRoot({
				name = "update_safe_area",
				controller = f27_arg0.m_ownerController
			})
		end
		LUI.UIElement.animateViewport(f27_arg0, f27_arg0.m_ownerController, 1, CoD.SpectateHUD.ViewportScale, 0)
	end
end

CoD.SpectateHUD.update = function (f28_arg0, f28_arg1)
	if f28_arg0.m_hasShutdown == true then
		return 
	end
	f28_arg0:processEvent({
		name = "update_spectate_hud",
		controller = f28_arg0.m_ownerController
	})
	local f28_local0 = Engine.GetSpectatingClientInfo(f28_arg0.m_ownerController)
	if f28_arg0.m_selectedClientNum ~= f28_local0.clientNum then
		f28_arg0.m_selectedClientNum = f28_local0.clientNum
		if f28_local0.teamID == CoD.TEAM_SPECTATOR and f28_arg0.m_controlsOpen == true then
			CoD.SpectateHUD.ControlsClose(f28_arg0, nil)
		end
		f28_arg0:processEvent({
			name = "spectate_player_selected",
			controller = f28_arg0.m_ownerController,
			info = f28_local0,
			teams = Engine.GetTeamPositions(f28_arg0.m_ownerController),
			factionName = Engine.GetFactionForTeam(f28_local0.teamID)
		})
	end
	local f28_local1 = f28_arg0.playerCount
	CoD.SpectateHUD.UpdatePlayerCount(f28_arg0)
	if f28_arg0.playerCount ~= f28_local1 then
		CoD.SpectateHUD.UpdateMapInPlayerColumn(f28_arg0)
	end
end

CoD.SpectateHUD.DisplayOptionsChanged = function (f29_arg0, f29_arg1)
	CoD.SpectateHUD.update(f29_arg0, f29_arg1)
	f29_arg0.m_gameHUD:processEvent({
		name = "hud_update_refresh",
		controller = f29_arg1.controller
	})
end

CoD.SpectateHUD.UpdatePlayerCount = function (f30_arg0)
	local f30_local0 = Engine.GetGametypeSetting("teamCount")
	local f30_local1 = 0
	if f30_local0 > 1 then
		for f30_local2 = 1, f30_local0, 1 do
			f30_local1 = f30_local1 + #Engine.GetInGamePlayerList(f30_arg0.m_ownerController, f30_local2, true)
		end
	else
		f30_local1 = #Engine.GetInGamePlayerList(f30_arg0.m_ownerController, CoD.TEAM_FREE, false)
	end
	f30_arg0.playerCount = f30_local1
end

CoD.SpectateHUD.UpdateMapInPlayerColumn = function (f31_arg0)
	local f31_local0 = f31_arg0.overheadMap
	local f31_local1 = CoD.ExeProfileVarBool(f31_arg0.m_ownerController, "shoutcaster_map_in_player_column")
	if f31_local1 then
		f31_local1 = f31_arg0.playerCount <= 10
	end
	f31_local0.mapInPlayerColumn = f31_local1
	if f31_arg0.m_controlsOpen and not f31_arg0.overheadMap.fullScreenMap then
		if f31_arg0.sidePanel.tabManager.tabSelected == CoD.SpectateSidePanel.PlayersTabIndex then
			if f31_arg0.overheadMap.mapInPlayerColumn then
				f31_arg0.overheadMap:animateToState("minimize", 0)
				f31_arg0.overheadMap:setAlpha(1)
				f31_arg0.overheadMapBackground:animateToState("minimize", 0)
			else
				f31_arg0.overheadMap:setAlpha(0)
				f31_arg0.overheadMapBackground:setAlpha(0)
			end
		else
			f31_arg0.overheadMap:setAlpha(0)
			f31_arg0.overheadMapBackground:setAlpha(0)
		end
	end
end

CoD.SpectateHUD.SidePanelTabsChanged = function (f32_arg0, f32_arg1)
	f32_arg0.buttonBar:setFullscreen(false, f32_arg0.sidePanel.tabManager.tabSelected)
	CoD.SpectateHUD.UpdateMapInPlayerColumn(f32_arg0)
end

CoD.SpectateHUD.UpdateSafeArea = function (f33_arg0, f33_arg1)
	local f33_local0, f33_local1 = Engine.GetUserSafeArea()
	f33_arg0.m_safeAreaWidth = f33_local0
	f33_arg0.m_safeAreaHeight = f33_local1
	f33_arg0.overlayContainer:completeAnimation()
	f33_arg0.overlayContainer:beginAnimation("resize", 0)
	f33_arg0.overlayContainer:setLeftRight(false, false, -f33_local0 / 2, f33_local0 / 2)
	f33_arg0.overlayContainer:setTopBottom(false, false, -f33_local1 / 2, f33_local1 / 2)
end

CoD.SpectateHUD.UpdateButtonPrompts = function (f34_arg0, f34_arg1)
	f34_arg0:dispatchEventToChildren(f34_arg1)
end

CoD.SpectateHUD.UpdatePlayerObjective = function (f35_arg0, f35_arg1)
	f35_arg0:dispatchEventToChildren(f35_arg1)
end

CoD.SpectateHUD.ResolutionChanged = function (f36_arg0, f36_arg1)
	if not Dvar.hiDef:get() or not Dvar.wideScreen:get() then
		CoD.SpectateHUD.ViewportScale = 0.52
		CoD.SpectateHUD.ScreenWidth = 960
	else
		CoD.SpectateHUD.ViewportScale = 0.58
		CoD.SpectateHUD.ScreenWidth = 1280
	end
	if f36_arg0.m_controlsOpen then
		CoD.SpectateHUD.ControlsClose(f36_arg0, nil)
	end
end

CoD.SpectateHUD:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_THIRD_PERSON, CoD.SpectateHUD.update)
CoD.SpectateHUD:registerEventHandler("hud_update_bit_" .. CoD.BIT_POF_SPEC_ALLOW_FREELOOK, CoD.SpectateHUD.update)
CoD.SpectateHUD:registerEventHandler("hud_update_bit_" .. CoD.BIT_POF_FOLLOW, CoD.SpectateHUD.update)
CoD.SpectateHUD:registerEventHandler("hud_update_bit_" .. CoD.BIT_GAME_ENDED, CoD.SpectateHUD.Shutdown)
CoD.SpectateHUD:registerEventHandler("spectate_row_selected", CoD.SpectateHUD.update)
CoD.SpectateHUD:registerEventHandler("spectate_display_options_changed", CoD.SpectateHUD.DisplayOptionsChanged)
CoD.SpectateHUD:registerEventHandler("spectate_sidepanel_tab_changed", CoD.SpectateHUD.SidePanelTabsChanged)
CoD.SpectateHUD:registerEventHandler("hud_update_scores", CoD.SpectateHUD.UpdateScores)
CoD.SpectateHUD:registerEventHandler("update_safe_area", CoD.SpectateHUD.UpdateSafeArea)
CoD.SpectateHUD:registerEventHandler("spectate_toggle_hud", CoD.SpectateHUD.ToggleHUDVisibility)
CoD.SpectateHUD:registerEventHandler("spectate_scoreboard_opened", CoD.SpectateHUD.ScoreboardOpened)
CoD.SpectateHUD:registerEventHandler("spectate_scoreboard_closed", CoD.SpectateHUD.ScoreboardClosed)
CoD.SpectateHUD:registerEventHandler("spectate_ingame_menu_opened", CoD.SpectateHUD.Off)
CoD.SpectateHUD:registerEventHandler("spectate_ingame_menu_closed", CoD.SpectateHUD.On)
CoD.SpectateHUD:registerEventHandler("hud_update_bit_" .. CoD.BIT_FINAL_KILLCAM, CoD.SpectateHUD.UpdateVisibility)
CoD.SpectateHUD:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_KILLCAM, CoD.SpectateHUD.UpdateVisibility)
CoD.SpectateHUD:registerEventHandler("spectate_scoreboard", CoD.SpectateHUD.ScoreboardToggle)
CoD.SpectateHUD:registerEventHandler("spectate_enable_input", CoD.SpectateHUD.EnableInput)
CoD.SpectateHUD:registerEventHandler("spectate_controls_open", CoD.SpectateHUD.ControlsOpen)
CoD.SpectateHUD:registerEventHandler("spectate_controls_close", CoD.SpectateHUD.ControlsClose)
CoD.SpectateHUD:registerEventHandler("spectate_playerinfo_player_selected", CoD.SpectateHUD.PlayerSelected)
CoD.SpectateHUD:registerEventHandler("spectate_overhead_map", CoD.SpectateHUD.ToggleOverheadMap)
CoD.SpectateHUD:registerEventHandler("spectate_unlock_controls", CoD.SpectateHUD.UnlockControls)
CoD.SpectateHUD:registerEventHandler("spectate_listen_in", CoD.SpectateHUD.ListenIn)
CoD.SpectateHUD:registerEventHandler("update_spectate_buttom_prompts", CoD.SpectateHUD.UpdateButtonPrompts)
CoD.SpectateHUD:registerEventHandler("hide_spectate_hud", CoD.SpectateHUD.HideSpectateHud)
CoD.SpectateHUD:registerEventHandler("show_spectate_hud", CoD.SpectateHUD.ShowSpectateHud)
CoD.SpectateHUD:registerEventHandler("first_snapshot", CoD.SpectateHUD.FirstSnapshot)
CoD.SpectateHUD:registerEventHandler("update_player_objective", CoD.SpectateHUD.UpdatePlayerObjective)
CoD.SpectateHUD:registerEventHandler("resolution_changed", CoD.SpectateHUD.ResolutionChanged)
