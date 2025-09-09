CoD.SpectateGameModeStatus.dem.BombSize = 16
CoD.SpectateGameModeStatus.dem.DockHeight = 10
CoD.SpectateGameModeStatus.dem.TeamAreaListSpacing = 10
CoD.SpectateGameModeStatus.dem.Font = CoD.fonts.Default
CoD.SpectateGameModeStatus.dem.FontSize = CoD.textSize.Default
CoD.SpectateGameModeStatus.dem.Update = function (f1_arg0, f1_arg1)
	f1_arg0.leftTeamArea:removeAllChildren()
	f1_arg0.centerTeamArea:removeAllChildren()
	f1_arg0.rightTeamArea:removeAllChildren()
	for f1_local0 = 1, #f1_arg0.bomb, 1 do
		local f1_local3 = f1_arg0.bomb[f1_local0]
		if not f1_local3.isPlanted then
			f1_local3:setAlpha(0)
		else
			f1_local3:setAlpha(1)
		end
	end
	for f1_local0 = 1, #f1_arg0.bomb, 1 do
		local f1_local3 = f1_arg0.bomb[f1_local0]
		if f1_local3.team == CoD.TEAM_ALLIES then
			f1_arg0.leftTeamArea:addElement(f1_local3)
		end
	end
	for f1_local0 = 1, #f1_arg0.bomb, 1 do
		local f1_local3 = f1_arg0.bomb[f1_local0]
		if f1_local3.team ~= CoD.TEAM_ALLIES and f1_local3.team ~= CoD.TEAM_AXIS then
			f1_arg0.centerTeamArea:addElement(f1_local3)
		end
	end
	for f1_local0 = #f1_arg0.bomb, 1, -1 do
		local f1_local3 = f1_arg0.bomb[f1_local0]
		if f1_local3.team == CoD.TEAM_AXIS then
			f1_arg0.rightTeamArea:addElement(f1_local3)
		end
	end
end

CoD.SpectateGameModeStatus.dem.UpdateBomb = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	local f2_local1 = Engine.GetObjectiveTeam(f2_local0, f2_arg0.objectiveIndex)
	local f2_local2 = Engine.GetObjectiveGamemodeFlags(f2_local0, f2_arg0.objectiveIndex) == CoD.ObjectiveBombSite.OBJECTIVE_FLAG_PLANTED
	local f2_local3 = Engine.ObjectiveIsTeamUsing(f2_local0, f2_arg0.objectiveIndex, f2_local1)
	if f2_arg0.isDefusing ~= f2_local3 then
		if f2_local3 ~= true then
			f2_arg0:animateToState("original")
		else
			f2_arg0:animateToState("pulse")
		end
		f2_arg0.isDefusing = f2_local3
	end
	if f2_arg0.team ~= f2_local1 or f2_arg0.isPlanted ~= f2_local2 then
		f2_arg0.team = f2_local1
		f2_arg0.isPlanted = f2_local2
		f2_arg0.gameModeStatus:processEvent({
			name = "update_game_mode_status",
			controller = f2_local0
		})
	end
	f2_arg0.gameModeStatus:dispatchEventToParent({
		name = "update_player_objective",
		controller = f2_local0,
		materialName = f2_arg0.materialName,
		objectiveIndex = f2_arg0.objectiveIndex
	})
end

CoD.SpectateGameModeStatus.dem.CreateBomb = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = CoD.SpectateGameModeStatus.dem.BombSize
	local f3_local1 = f3_arg2.objective[f3_arg1].objName
	local f3_local2 = Engine.GetObjectiveIndexFromName(f3_arg0, f3_local1)
	if f3_local2 == nil then
		return nil
	else
		local f3_local3 = "hud_shoutcasting_notify" .. f3_local1
		local f3_local4 = "hud_shoutcasting_notify_bomb"
		local f3_local5 = CoD.SpectateGameModeStatus.dem.BombSize + CoD.SpectateGameModeStatus.dem.FontSize
		local f3_local6 = CoD.BombTimer.new({
			left = -CoD.BombTimer.Width / 2,
			right = CoD.BombTimer.Width / 2,
			leftAnchor = false,
			rightAnchor = false,
			top = -CoD.SpectateGameModeStatus.dem.BombSize / 2,
			bottom = CoD.SpectateGameModeStatus.dem.BombSize / 2,
			topAnchor = false,
			bottomAnchor = false
		}, f3_arg2.objective[f3_arg1].name)
		f3_local6.letterForeground:setLeftRight(true, false, 0, CoD.SpectateGameModeStatus.dem.BombSize)
		f3_local6.letterForeground:setImage(RegisterMaterial(f3_local3))
		f3_local6.timerLabel:setLeftRight(true, false, CoD.SpectateGameModeStatus.dem.BombSize + 4, CoD.SpectateGameModeStatus.dem.BombSize + CoD.SpectateGameModeStatus.dem.FontSize)
		f3_local6.timerLabel:setTopBottom(false, false, -(CoD.BombTimer.LabelSize / 2), CoD.BombTimer.LabelSize / 2)
		f3_local6.timerLabel:setFont(CoD.SpectateGameModeStatus.dem.Font)
		f3_local6.enableGlow = false
		f3_local6:setAlpha(1)
		f3_local6.team = CoD.TEAM_FREE
		f3_local6.index = f3_arg1
		f3_local6.objectiveIndex = f3_local2
		f3_local6.materialName = f3_local4
		f3_local6.gameModeStatus = f3_arg2
		f3_local6:registerAnimationState("original", {
			alpha = 1
		})
		f3_local6:registerAnimationState("pulse", {
			alpha = 0.3
		})
		f3_local6:registerAnimationState("pulse2", {
			alpha = 1
		})
		f3_local6:registerEventHandler("transition_complete_pulse", CoD.SpectateGameModeStatus.Pulse)
		f3_local6:registerEventHandler("transition_complete_pulse2", CoD.SpectateGameModeStatus.Pulse2)
		f3_local6:registerEventHandler("objective_update_" .. f3_local1, CoD.SpectateGameModeStatus.dem.UpdateBomb)
		f3_local6:registerEventHandler("hud_update_refresh", CoD.SpectateGameModeStatus.dem.UpdateBomb)
		return f3_local6
	end
end

CoD.SpectateGameModeStatus.dem.new = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = CoD.Menu.NewFromState("SpectateGameModeStatus_dem", {
		left = 0,
		top = f4_arg1,
		right = 0,
		bottom = f4_arg1 + CoD.SpectateTopPanel.GameModeHeight,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f4_local0:setClass(CoD.SpectateGameModeStatus.dem)
	f4_local0:setOwner(f4_arg0)
	f4_local0.leftTeamArea = LUI.UIHorizontalList.new()
	f4_local0.leftTeamArea:setLeftRight(true, false, 0, CoD.SpectateTeamCardTwoTeam.RealWidth)
	f4_local0.leftTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.dem.DockHeight, CoD.SpectateGameModeStatus.dem.DockHeight + CoD.SpectateGameModeStatus.dem.BombSize)
	f4_local0.leftTeamArea:setSpacing(CoD.SpectateGameModeStatus.dem.TeamAreaListSpacing)
	f4_local0.leftTeamArea:setAlignment(LUI.Alignment.Left)
	f4_local0.centerTeamArea = LUI.UIHorizontalList.new()
	f4_local0.centerTeamArea:setLeftRight(true, true, 0, 0)
	f4_local0.centerTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.dem.DockHeight, CoD.SpectateGameModeStatus.dem.DockHeight + CoD.SpectateGameModeStatus.dem.BombSize)
	f4_local0.centerTeamArea:setSpacing(2)
	f4_local0.centerTeamArea:setAlignment(LUI.Alignment.Center)
	f4_local0.rightTeamArea = LUI.UIHorizontalList.new()
	f4_local0.rightTeamArea:setLeftRight(false, true, -CoD.SpectateTeamCardTwoTeam.RealWidth, 0)
	f4_local0.rightTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.dem.DockHeight, CoD.SpectateGameModeStatus.dem.DockHeight + CoD.SpectateGameModeStatus.dem.BombSize)
	f4_local0.rightTeamArea:setSpacing(CoD.SpectateGameModeStatus.dem.TeamAreaListSpacing)
	f4_local0.rightTeamArea:setAlignment(LUI.Alignment.Right)
	f4_local0.objective = {}
	f4_local0.objective[1] = {}
	f4_local0.objective[1].objName = "_a"
	f4_local0.objective[1].name = "A"
	f4_local0.objective[2] = {}
	f4_local0.objective[2].objName = "_b"
	f4_local0.objective[2].name = "B"
	f4_local0.bomb = {}
	for f4_local1 = 1, #f4_local0.objective, 1 do
		f4_local0.bomb[f4_local1] = CoD.SpectateGameModeStatus.dem.CreateBomb(f4_arg0, f4_local1, f4_local0)
		if f4_local0.bomb[f4_local1] ~= nil then
			f4_local0.centerTeamArea:addElement(f4_local0.bomb[f4_local1])
		end
	end
	f4_local0:addElement(f4_local0.leftTeamArea)
	f4_local0:addElement(f4_local0.centerTeamArea)
	f4_local0:addElement(f4_local0.rightTeamArea)
	return f4_local0
end

CoD.SpectateGameModeStatus.dem.Initialize = function (f5_arg0, f5_arg1)
	for f5_local0 = 1, #f5_arg0.objective, 1 do
		if f5_arg0.bomb[f5_local0] ~= nil then
			f5_arg0.bomb[f5_local0]:processEvent({
				name = "objective_update_" .. f5_arg0.objective[f5_local0].objName,
				controller = f5_arg1.controller
			})
		end
	end
end

CoD.SpectateGameModeStatus.dem:registerEventHandler("initialize_game_mode_status", CoD.SpectateGameModeStatus.dem.Initialize)
CoD.SpectateGameModeStatus.dem:registerEventHandler("update_game_mode_status", CoD.SpectateGameModeStatus.dem.Update)
