CoD.SpectateGameModeStatus.ctf.FlagSize = 16
CoD.SpectateGameModeStatus.ctf.DockHeight = 10
CoD.SpectateGameModeStatus.ctf.TeamAreaListSpacing = 10
CoD.SpectateGameModeStatus.ctf.Font = CoD.fonts.Default
CoD.SpectateGameModeStatus.ctf.FontSize = CoD.textSize.Default
CoD.SpectateGameModeStatus.ctf.UpdateObjectiveText = function (f1_arg0, f1_arg1)
	local f1_local0 = {}
	f1_local0 = GetTextDimensions(f1_arg1, CoD.SpectateGameModeStatus.sd.Font, CoD.SpectateGameModeStatus.sd.FontSize)
	f1_arg0:setLeftRight(true, false, 0, f1_local0[3])
	f1_arg0:setText(f1_arg1)
	f1_arg0:setAlpha(1)
end

CoD.SpectateGameModeStatus.ctf.UpdateFlag = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	local f2_local1 = Engine.GetObjectiveTeam(f2_local0, f2_arg0.objectiveIndex)
	local f2_local2 = Engine.ObjectiveIsTeamUsing(f2_local0, f2_arg0.objectiveIndex, f2_local1)
	local f2_local3 = Engine.ObjectiveIsAnyOtherTeamUsing(f2_local0, f2_arg0.objectiveIndex, f2_local1)
	local f2_local4 = Engine.GetObjectiveEntity(f2_local0, f2_arg0.objectiveIndex)
	f2_arg0.progress = Engine.GetObjectiveProgress(f2_local0, f2_arg0.objectiveIndex)
	if f2_arg0.isAnyOtherTeamUsing ~= f2_local3 or f2_arg0.isPlayerTeamUsing ~= f2_local2 then
		if (f2_local3 ~= true or f2_local2 ~= true) and Engine.GetObjectiveGamemodeFlags(f2_local0, f2_arg0.objectiveIndex) ~= CoD.ctf.OBJECTIVE_FLAG_AWAY then
			CoD.SpectateGameModeStatus.ctf.UpdateObjectiveText(f2_arg0.objectiveText, Engine.Localize("OBJECTIVES_FLAG_HOME_CAPS"))
		else
			CoD.SpectateGameModeStatus.ctf.UpdateObjectiveText(f2_arg0.objectiveText, Engine.Localize("OBJECTIVES_FLAG_AWAY_CAPS"))
		end
		f2_arg0.isAnyOtherTeamUsing = f2_local3
	end
	f2_arg0.gameModeStatus:dispatchEventToParent({
		name = "update_player_objective",
		controller = f2_local0,
		materialName = f2_arg0.materialName,
		objectiveIndex = f2_arg0.objectiveIndex,
		objectiveEntity = f2_local4
	})
end

CoD.SpectateGameModeStatus.ctf.CreateFlag = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = CoD.SpectateGameModeStatus.ctf.FlagSize
	local f3_local1 = f3_arg2.objectiveNames[f3_arg1].flagName
	local f3_local2 = Engine.GetObjectiveIndexFromName(f3_arg0, f3_local1)
	if f3_local2 == nil then
		return nil
	else
		local f3_local3 = "hud_shoutcasting_notify_flag"
		local f3_local4 = LUI.UIImage.new()
		f3_local4:setLeftRight(false, false, -f3_local0 / 2, f3_local0 / 2)
		f3_local4:setTopBottom(false, false, -f3_local0 / 2, f3_local0 / 2)
		f3_local4:setRGB(1, 1, 1)
		f3_local4:setAlpha(1)
		f3_local4:setImage(RegisterMaterial(f3_local3))
		f3_local4.team = f3_arg2.objectiveNames[f3_arg1].team
		f3_local4.progress = 0
		f3_local4.index = f3_arg1
		f3_local4.objectiveIndex = f3_local2
		f3_local4.materialName = f3_local3
		f3_local4.gameModeStatus = f3_arg2
		f3_local4:registerAnimationState("original", {
			alpha = 1
		})
		f3_local4:registerAnimationState("pulse", {
			alpha = 0.4
		})
		f3_local4:registerAnimationState("pulse2", {
			alpha = 1
		})
		f3_local4:registerEventHandler("transition_complete_pulse", CoD.SpectateGameModeStatus.Pulse)
		f3_local4:registerEventHandler("transition_complete_pulse2", CoD.SpectateGameModeStatus.Pulse2)
		f3_local4:registerEventHandler("objective_update_" .. f3_local1, CoD.SpectateGameModeStatus.ctf.UpdateFlag)
		f3_local4:registerEventHandler("hud_update_refresh", CoD.SpectateGameModeStatus.ctf.UpdateFlag)
		return f3_local4
	end
end

CoD.SpectateGameModeStatus.ctf.CreateObjectiveText = function (f4_arg0, f4_arg1)
	local f4_local0 = LUI.UIText.new()
	f4_local0:setLeftRight(true, true, 0, 0)
	f4_local0:setTopBottom(false, false, -CoD.SpectateGameModeStatus.ctf.FontSize / 2, CoD.SpectateGameModeStatus.ctf.FontSize / 2)
	f4_local0:setFont(CoD.SpectateGameModeStatus.ctf.Font)
	f4_local0:setRGB(1, 1, 1)
	f4_local0:setAlpha(1)
	f4_local0.team = f4_arg1
	return f4_local0
end

CoD.SpectateGameModeStatus.ctf.new = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = CoD.Menu.NewFromState("SpectateGameModeStatus_ctf", {
		left = 0,
		top = f5_arg1,
		right = 0,
		bottom = f5_arg1 + CoD.SpectateTopPanel.GameModeHeight,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f5_local0:setClass(CoD.SpectateGameModeStatus.ctf)
	f5_local0:setOwner(f5_arg0)
	f5_local0.leftTeamArea = LUI.UIHorizontalList.new()
	f5_local0.leftTeamArea:setLeftRight(true, false, 0, CoD.SpectateTeamCardTwoTeam.RealWidth)
	f5_local0.leftTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.dem.DockHeight, CoD.SpectateGameModeStatus.dem.DockHeight + CoD.SpectateGameModeStatus.dem.BombSize)
	f5_local0.leftTeamArea:setSpacing(CoD.SpectateGameModeStatus.ctf.TeamAreaListSpacing)
	f5_local0.leftTeamArea:setAlignment(LUI.Alignment.Left)
	f5_local0.rightTeamArea = LUI.UIHorizontalList.new()
	f5_local0.rightTeamArea:setLeftRight(false, true, -CoD.SpectateTeamCardTwoTeam.RealWidth, 0)
	f5_local0.rightTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.dem.DockHeight, CoD.SpectateGameModeStatus.dem.DockHeight + CoD.SpectateGameModeStatus.dem.BombSize)
	f5_local0.rightTeamArea:setSpacing(CoD.SpectateGameModeStatus.ctf.TeamAreaListSpacing)
	f5_local0.rightTeamArea:setAlignment(LUI.Alignment.Right)
	f5_local0.objectiveNames = {}
	f5_local0.objectiveNames[1] = {}
	f5_local0.objectiveNames[1].flagName = "allies_flag"
	f5_local0.objectiveNames[1].team = CoD.TEAM_ALLIES
	f5_local0.objectiveNames[2] = {}
	f5_local0.objectiveNames[2].flagName = "axis_flag"
	f5_local0.objectiveNames[2].team = CoD.TEAM_AXIS
	f5_local0.objective = {}
	f5_local0.objective.flag = {}
	f5_local0.objective.objectiveText = {}
	for f5_local1 = 1, #f5_local0.objectiveNames, 1 do
		f5_local0.objective.flag[f5_local1] = CoD.SpectateGameModeStatus.ctf.CreateFlag(f5_arg0, f5_local1, f5_local0)
		f5_local0.objective.objectiveText[f5_local1] = CoD.SpectateGameModeStatus.ctf.CreateObjectiveText(f5_arg0, f5_local0.objectiveNames[f5_local1].team)
		if f5_local0.objective.flag[f5_local1] ~= nil then
			f5_local0.objective.flag[f5_local1].objectiveText = f5_local0.objective.objectiveText[f5_local1]
		end
	end
	if f5_local0.objective.flag[1] ~= nil and f5_local0.objective.objectiveText[1] ~= nil then
		f5_local0.leftTeamArea:addElement(f5_local0.objective.flag[1])
		f5_local0.leftTeamArea:addElement(f5_local0.objective.objectiveText[1])
	end
	if f5_local0.objective.flag[2] ~= nil and f5_local0.objective.objectiveText[2] ~= nil then
		f5_local0.rightTeamArea:addElement(f5_local0.objective.flag[2])
		f5_local0.rightTeamArea:addElement(f5_local0.objective.objectiveText[2])
	end
	f5_local0:addElement(f5_local0.leftTeamArea)
	f5_local0:addElement(f5_local0.rightTeamArea)
	return f5_local0
end

CoD.SpectateGameModeStatus.ctf.Initialize = function (f6_arg0, f6_arg1)
	for f6_local0 = 1, #f6_arg0.objectiveNames, 1 do
		if f6_arg0.objective.flag[f6_local0] ~= nil then
			f6_arg0.objective.flag[f6_local0]:processEvent({
				name = "objective_update_" .. f6_arg0.objectiveNames[f6_local0].flagName,
				controller = f6_arg1.controller
			})
		end
	end
end

CoD.SpectateGameModeStatus.ctf:registerEventHandler("initialize_game_mode_status", CoD.SpectateGameModeStatus.ctf.Initialize)
