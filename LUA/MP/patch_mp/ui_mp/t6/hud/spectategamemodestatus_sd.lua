CoD.SpectateGameModeStatus.sd.BombSize = 16
CoD.SpectateGameModeStatus.sd.DockHeight = 10
CoD.SpectateGameModeStatus.sd.TeamAreaListSpacing = 10
CoD.SpectateGameModeStatus.sd.Font = CoD.fonts.Default
CoD.SpectateGameModeStatus.sd.FontSize = CoD.textSize.Default
CoD.SpectateGameModeStatus.sd.UpdateObjectiveText = function (f1_arg0, f1_arg1)
	for f1_local0 = 1, #f1_arg0.objectiveText, 1 do
		local f1_local3 = f1_arg0.objectiveText[f1_local0]
		local f1_local4 = Engine.GetNumberOfPlayersAlive(controller, f1_local3.team)
		if f1_local4 == nil then
			f1_local4 = 0
		end
		local f1_local5 = Engine.Localize("MPUI_SHOUTCASTER_NUMBER_ALIVE", f1_local4)
		local f1_local6 = {}
		f1_local6 = GetTextDimensions(f1_local5, CoD.SpectateGameModeStatus.sd.Font, CoD.SpectateGameModeStatus.sd.FontSize)
		f1_local3:setLeftRight(true, false, 0, f1_local6[3])
		f1_local3:setText(f1_local5)
		f1_local3:setAlpha(1)
	end
end

CoD.SpectateGameModeStatus.sd.Update = function (f2_arg0, f2_arg1)
	f2_arg0.leftTeamArea:removeAllChildren()
	f2_arg0.centerTeamArea:removeAllChildren()
	f2_arg0.rightTeamArea:removeAllChildren()
	f2_arg0.leftTeamArea:addElement(f2_arg0.objectiveText[1])
	f2_arg0.rightTeamArea:addElement(f2_arg0.objectiveText[2])
	for f2_local0 = 1, #f2_arg0.bomb, 1 do
		local f2_local3 = f2_arg0.bomb[f2_local0]
		if not f2_local3.isPlanted then
			f2_local3:setAlpha(0)
			f2_arg0.centerTeamArea:addElement(f2_local3)
		end
		f2_local3:setAlpha(1)
		if f2_local3.team == CoD.TEAM_ALLIES then
			f2_arg0.leftTeamArea:addElement(f2_local3)
		end
		if f2_local3.team == CoD.TEAM_AXIS then
			f2_arg0.rightTeamArea:addElement(f2_local3)
		else
			f2_arg0.centerTeamArea:addElement(f2_local3)
		end
	end
end

CoD.SpectateGameModeStatus.sd.UpdateBombSite = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1.controller
	local f3_local1 = Engine.GetObjectiveTeam(f3_local0, f3_arg0.siteIndex)
	local f3_local2 = Engine.GetObjectiveGamemodeFlags(f3_local0, f3_arg0.siteIndex) == CoD.ObjectiveBombSite.OBJECTIVE_FLAG_PLANTED
	if f3_arg0.team ~= f3_local1 or f3_arg0.isPlanted ~= f3_local2 then
		f3_arg0.team = f3_local1
		f3_arg0.isPlanted = f3_local2
		f3_arg0.gameModeStatus:processEvent({
			name = "update_game_mode_status",
			controller = f3_local0
		})
	end
end

CoD.SpectateGameModeStatus.sd.UpdateBomb = function (f4_arg0, f4_arg1)
	f4_arg0.gameModeStatus:dispatchEventToParent({
		name = "update_player_objective",
		controller = f4_arg1.controller,
		materialName = f4_arg0.materialName,
		objectiveIndex = f4_arg0.objectiveIndex,
		objectiveEntity = Engine.GetObjectiveEntity(f4_arg1.controller, f4_arg0.objectiveIndex)
	})
end

CoD.SpectateGameModeStatus.sd.UpdateBombDefuse = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1.controller
	if f5_arg0.defuseObjectiveIndex == nil then
		f5_arg0.defuseObjectiveIndex = Engine.GetObjectiveIndexFromName(f5_local0, f5_arg0.gameModeStatus.objective[f5_arg0.index].defuseObjName)
	end
	local f5_local1 = Engine.ObjectiveIsTeamUsing(f5_local0, f5_arg0.defuseObjectiveIndex, Engine.GetObjectiveTeam(f5_local0, f5_arg0.defuseObjectiveIndex))
	if f5_arg0.isDefusing ~= f5_local1 then
		if f5_local1 ~= true then
			f5_arg0:animateToState("original")
		else
			f5_arg0:animateToState("pulse")
		end
		f5_arg0.isDefusing = f5_local1
		f5_arg0.gameModeStatus:processEvent({
			name = "update_game_mode_status",
			controller = f5_local0
		})
	end
end

CoD.SpectateGameModeStatus.sd.CreateBomb = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = CoD.SpectateGameModeStatus.sd.BombSize
	local f6_local1 = f6_arg2.objective[f6_arg1].bombObjName
	local f6_local2 = Engine.GetObjectiveIndexFromName(f6_arg0, f6_local1)
	if f6_local2 == nil then
		return nil
	else
		local f6_local3 = "hud_shoutcasting_notify" .. f6_arg2.objective[f6_arg1].bombSiteName
		local f6_local4 = "hud_shoutcasting_notify_bomb"
		local f6_local5 = CoD.SpectateGameModeStatus.sd.BombSize + CoD.SpectateGameModeStatus.sd.FontSize
		local f6_local6 = CoD.BombTimer.new({
			left = -CoD.BombTimer.Width / 2,
			right = CoD.BombTimer.Width / 2,
			leftAnchor = false,
			rightAnchor = false,
			top = -CoD.SpectateGameModeStatus.sd.BombSize / 2,
			bottom = CoD.SpectateGameModeStatus.sd.BombSize / 2,
			topAnchor = false,
			bottomAnchor = false
		}, f6_arg2.objective[f6_arg1].name)
		f6_local6.letterForeground:setLeftRight(true, false, 0, CoD.SpectateGameModeStatus.sd.BombSize)
		f6_local6.letterForeground:setImage(RegisterMaterial(f6_local3))
		f6_local6.timerLabel:setLeftRight(true, false, CoD.SpectateGameModeStatus.sd.BombSize + 4, CoD.SpectateGameModeStatus.sd.BombSize + CoD.SpectateGameModeStatus.sd.FontSize)
		f6_local6.timerLabel:setTopBottom(false, false, -(CoD.BombTimer.LabelSize / 2), CoD.BombTimer.LabelSize / 2)
		f6_local6.timerLabel:setFont(CoD.SpectateGameModeStatus.sd.Font)
		f6_local6.enableGlow = false
		f6_local6:setAlpha(1)
		f6_local6.team = CoD.TEAM_FREE
		f6_local6.index = f6_arg1
		f6_local6.objectiveIndex = f6_local2
		f6_local6.siteIndex = Engine.GetObjectiveIndexFromName(f6_arg0, f6_arg2.objective[f6_arg1].bombSiteName)
		f6_local6.materialName = f6_local4
		f6_local6.gameModeStatus = f6_arg2
		f6_local6.defuseObjectiveIndex = Engine.GetObjectiveIndexFromName(f6_arg0, f6_arg2.objective[f6_arg1].defuseObjName)
		f6_local6:registerAnimationState("original", {
			alpha = 1
		})
		f6_local6:registerAnimationState("pulse", {
			alpha = 0.3
		})
		f6_local6:registerAnimationState("pulse2", {
			alpha = 1
		})
		f6_local6:registerEventHandler("transition_complete_pulse", CoD.SpectateGameModeStatus.Pulse)
		f6_local6:registerEventHandler("transition_complete_pulse2", CoD.SpectateGameModeStatus.Pulse2)
		f6_local6:registerEventHandler("objective_update_" .. f6_local1, CoD.SpectateGameModeStatus.sd.UpdateBomb)
		f6_local6:registerEventHandler("objective_update_" .. f6_arg2.objective[f6_arg1].bombSiteName, CoD.SpectateGameModeStatus.sd.UpdateBombSite)
		f6_local6:registerEventHandler("objective_update_" .. f6_arg2.objective[f6_arg1].defuseObjName, CoD.SpectateGameModeStatus.sd.UpdateBombDefuse)
		f6_local6:registerEventHandler("hud_update_refresh", CoD.SpectateGameModeStatus.sd.UpdateBomb)
		return f6_local6
	end
end

CoD.SpectateGameModeStatus.sd.CreateObjectiveText = function (f7_arg0, f7_arg1)
	local f7_local0 = LUI.UIText.new()
	f7_local0:setLeftRight(true, true, 0, 0)
	f7_local0:setTopBottom(false, false, -CoD.SpectateGameModeStatus.sd.FontSize / 2, CoD.SpectateGameModeStatus.sd.FontSize / 2)
	f7_local0:setFont(CoD.SpectateGameModeStatus.sd.Font)
	f7_local0:setRGB(1, 1, 1)
	f7_local0:setAlpha(1)
	f7_local0.team = f7_arg1
	return f7_local0
end

CoD.SpectateGameModeStatus.sd.new = function (f8_arg0, f8_arg1, f8_arg2)
	local f8_local0 = CoD.Menu.NewFromState("SpectateGameModeStatus_sd", {
		left = 0,
		top = f8_arg1,
		right = 0,
		bottom = f8_arg1 + CoD.SpectateTopPanel.GameModeHeight,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f8_local0:setClass(CoD.SpectateGameModeStatus.sd)
	f8_local0:setOwner(f8_arg0)
	f8_local0.leftTeamArea = LUI.UIHorizontalList.new()
	f8_local0.leftTeamArea:setLeftRight(true, false, 0, CoD.SpectateTeamCardTwoTeam.RealWidth)
	f8_local0.leftTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.sd.DockHeight, CoD.SpectateGameModeStatus.sd.DockHeight + CoD.SpectateGameModeStatus.sd.BombSize)
	f8_local0.leftTeamArea:setSpacing(CoD.SpectateGameModeStatus.sd.TeamAreaListSpacing)
	f8_local0.leftTeamArea:setAlignment(LUI.Alignment.Left)
	f8_local0.centerTeamArea = LUI.UIHorizontalList.new()
	f8_local0.centerTeamArea:setLeftRight(true, true, 0, 0)
	f8_local0.centerTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.sd.DockHeight, CoD.SpectateGameModeStatus.sd.DockHeight + CoD.SpectateGameModeStatus.sd.BombSize)
	f8_local0.centerTeamArea:setSpacing(2)
	f8_local0.centerTeamArea:setAlignment(LUI.Alignment.Center)
	f8_local0.rightTeamArea = LUI.UIHorizontalList.new()
	f8_local0.rightTeamArea:setLeftRight(false, true, -CoD.SpectateTeamCardTwoTeam.RealWidth, 0)
	f8_local0.rightTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.sd.DockHeight, CoD.SpectateGameModeStatus.sd.DockHeight + CoD.SpectateGameModeStatus.sd.BombSize)
	f8_local0.rightTeamArea:setSpacing(CoD.SpectateGameModeStatus.sd.TeamAreaListSpacing)
	f8_local0.rightTeamArea:setAlignment(LUI.Alignment.Right)
	f8_local0.objective = {}
	f8_local0.objective[1] = {}
	f8_local0.objective[1].bombObjName = "bomb"
	f8_local0.objective[1].bombSiteName = "_a"
	f8_local0.objective[1].defuseObjName = "defuse_a"
	f8_local0.objective[1].name = "A"
	f8_local0.objective[2] = {}
	f8_local0.objective[2].bombObjName = "bomb"
	f8_local0.objective[2].bombSiteName = "_b"
	f8_local0.objective[2].defuseObjName = "defuse_b"
	f8_local0.objective[2].name = "B"
	f8_local0.bomb = {}
	for f8_local1 = 1, #f8_local0.objective, 1 do
		f8_local0.bomb[f8_local1] = CoD.SpectateGameModeStatus.sd.CreateBomb(f8_arg0, f8_local1, f8_local0)
		if f8_local0.bomb[f8_local1] ~= nil then
			f8_local0.centerTeamArea:addElement(f8_local0.bomb[f8_local1])
		end
	end
	f8_local0.objectiveText = {}
	f8_local0.objectiveText[1] = CoD.SpectateGameModeStatus.sd.CreateObjectiveText(f8_arg0, CoD.TEAM_ALLIES)
	f8_local0.leftTeamArea:addElement(f8_local0.objectiveText[1])
	f8_local0.objectiveText[2] = CoD.SpectateGameModeStatus.sd.CreateObjectiveText(f8_arg0, CoD.TEAM_AXIS)
	f8_local0.rightTeamArea:addElement(f8_local0.objectiveText[2])
	f8_local0.objectiveTextTimer = LUI.UITimer.new(500, {
		name = "update_game_mode_objective_text",
		controller = f8_arg0
	}, false)
	f8_local0:addElement(f8_local0.objectiveTextTimer)
	f8_local0:addElement(f8_local0.leftTeamArea)
	f8_local0:addElement(f8_local0.centerTeamArea)
	f8_local0:addElement(f8_local0.rightTeamArea)
	return f8_local0
end

CoD.SpectateGameModeStatus.sd.Initialize = function (f9_arg0, f9_arg1)
	for f9_local0 = 1, #f9_arg0.objective, 1 do
		if f9_arg0.bomb[f9_local0] ~= nil then
			f9_arg0.bomb[f9_local0]:processEvent({
				name = "objective_update_" .. f9_arg0.objective[f9_local0].bombObjName,
				controller = f9_arg1.controller
			})
			f9_arg0.bomb[f9_local0]:processEvent({
				name = "objective_update_" .. f9_arg0.objective[f9_local0].bombSiteName,
				controller = f9_arg1.controller
			})
		end
	end
end

CoD.SpectateGameModeStatus.sd:registerEventHandler("initialize_game_mode_status", CoD.SpectateGameModeStatus.sd.Initialize)
CoD.SpectateGameModeStatus.sd:registerEventHandler("update_game_mode_status", CoD.SpectateGameModeStatus.sd.Update)
CoD.SpectateGameModeStatus.sd:registerEventHandler("update_game_mode_objective_text", CoD.SpectateGameModeStatus.sd.UpdateObjectiveText)
