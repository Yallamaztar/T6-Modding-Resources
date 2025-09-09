CoD.SpectateGameModeStatus.hq.FlagSize = 16
CoD.SpectateGameModeStatus.hq.DockHeight = 10
CoD.SpectateGameModeStatus.hq.TeamAreaListSpacing = 10
CoD.SpectateGameModeStatus.hq.Font = CoD.fonts.Default
CoD.SpectateGameModeStatus.hq.FontSize = CoD.textSize.Default
CoD.SpectateGameModeStatus.hq.GetObjectiveText = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = Engine.GetNumberOfPlayersAlive(f1_arg1, f1_arg2.team)
	if f1_local0 == nil then
		f1_local0 = 0
	end
	return Engine.Localize("MPUI_SHOUTCASTER_NUMBER_PLAYERS", f1_local0)
end

CoD.SpectateGameModeStatus.hq.UpdateObjectiveText = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0:getObjectiveText(f2_arg1.controller, f2_arg0.objective)
	local f2_local1 = {}
	f2_local1 = GetTextDimensions(f2_local0, CoD.SpectateGameModeStatus.hq.Font, CoD.SpectateGameModeStatus.hq.FontSize)
	f2_arg0.objectiveText:setLeftRight(true, false, 0, f2_local1[3])
	f2_arg0.objectiveText:setText(f2_local0)
end

CoD.SpectateGameModeStatus.hq.SetupObjectiveText = function (f3_arg0, f3_arg1, f3_arg2)
	CoD.SpectateGameModeStatus.hq.UpdateObjectiveText(f3_arg0, {
		controller = f3_arg1
	})
	f3_arg0.objectiveText:setAlpha(1)
end

CoD.SpectateGameModeStatus.hq.TwoTeamUpdate = function (f4_arg0, f4_arg1, f4_arg2)
	f4_arg1.leftTeamArea:removeAllChildren()
	f4_arg1.centerTeamArea:removeAllChildren()
	f4_arg1.rightTeamArea:removeAllChildren()
	if f4_arg2.team == CoD.TEAM_ALLIES then
		f4_arg1.leftTeamArea:addElement(f4_arg2)
		CoD.SpectateGameModeStatus.hq.SetupObjectiveText(f4_arg1, f4_arg0, f4_arg2)
		f4_arg1.leftTeamArea:addElement(f4_arg1.objectiveText)
	elseif f4_arg2.team == CoD.TEAM_AXIS then
		f4_arg1.rightTeamArea:addElement(f4_arg2)
		CoD.SpectateGameModeStatus.hq.SetupObjectiveText(f4_arg1, f4_arg0, f4_arg2)
		f4_arg1.rightTeamArea:addElement(f4_arg1.objectiveText)
	else
		f4_arg1.centerTeamArea:addElement(f4_arg2)
	end
end

CoD.SpectateGameModeStatus.hq.MultiTeamUpdate = function (f5_arg0, f5_arg1, f5_arg2)
	if not f5_arg2.isAnyOtherTeamUsing and f5_arg1.m_gameStatus ~= nil then
		if f5_arg2.team == f5_arg1.m_gameStatus.m_teamCards[1].m_team then
			f5_arg1.leftTeamArea:removeAllChildren()
			f5_arg1.centerTeamArea:removeAllChildren()
			f5_arg1.rightTeamArea:removeAllChildren()
			f5_arg1.leftTeamArea:addElement(f5_arg2)
			f5_arg2:setAlpha(1)
			CoD.SpectateGameModeStatus.hq.SetupObjectiveText(f5_arg1, f5_arg0, f5_arg2)
			f5_arg1.leftTeamArea:addElement(f5_arg1.objectiveText)
		elseif f5_arg2.team == f5_arg1.m_gameStatus.m_teamCards[2].m_team then
			f5_arg1.leftTeamArea:removeAllChildren()
			f5_arg1.centerTeamArea:removeAllChildren()
			f5_arg1.rightTeamArea:removeAllChildren()
			f5_arg1.centerTeamArea:addElement(f5_arg2)
			f5_arg2:setAlpha(1)
			CoD.SpectateGameModeStatus.hq.SetupObjectiveText(f5_arg1, f5_arg0, f5_arg2)
			f5_arg1.centerTeamArea:addElement(f5_arg1.objectiveText)
		elseif f5_arg2.team == f5_arg1.m_gameStatus.m_teamCards[3].m_team then
			f5_arg1.leftTeamArea:removeAllChildren()
			f5_arg1.centerTeamArea:removeAllChildren()
			f5_arg1.rightTeamArea:removeAllChildren()
			f5_arg1.rightTeamArea:addElement(f5_arg2)
			f5_arg2:setAlpha(1)
			CoD.SpectateGameModeStatus.hq.SetupObjectiveText(f5_arg1, f5_arg0, f5_arg2)
			f5_arg1.rightTeamArea:addElement(f5_arg1.objectiveText)
		else
			f5_arg2:setAlpha(0)
			f5_arg1.objectiveText:setAlpha(0)
		end
	else
		f5_arg2:setAlpha(0)
		f5_arg1.objectiveText:setAlpha(0)
	end
end

CoD.SpectateGameModeStatus.hq.Update = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0.objective
	if f6_local0.state ~= CoD.OBJECTIVESTATE_ACTIVE then
		f6_local0:setAlpha(0)
		return 
	elseif not f6_arg0.isMultiTeam then
		CoD.SpectateGameModeStatus.hq.TwoTeamUpdate(f6_arg1.controller, f6_arg0, f6_local0)
	else
		CoD.SpectateGameModeStatus.hq.MultiTeamUpdate(f6_arg1.controller, f6_arg0, f6_local0)
	end
end

CoD.SpectateGameModeStatus.hq.UpdateObjective = function (f7_arg0, f7_arg1)
	local f7_local0 = "objective"
	local f7_local1 = f7_arg1.controller
	if f7_arg0.objectiveIndex == nil and f7_arg1.objId == nil then
		for f7_local2 = 0, CoD.GametypeBase.maxObjectives - 1, 1 do
			local f7_local5 = Engine.GetObjectiveName(f7_local1, f7_local2)
			if f7_local5 ~= nil and f7_local5 == f7_local0 and Engine.GetObjectiveState(f7_arg1.controller, f7_local2) == CoD.OBJECTIVESTATE_ACTIVE then
				f7_arg0.objectiveIndex = f7_local2
				f7_arg0.forceRefresh = true
			end
		end
	elseif f7_arg0.objectiveIndex ~= f7_arg1.objId and f7_arg1.objId ~= nil then
		f7_arg0.forceRefresh = true
		f7_arg0.objectiveIndex = f7_arg1.objId
	end
	if f7_arg0.objectiveIndex == nil then
		return 
	end
	local f7_local2 = Engine.GetObjectiveTeam(f7_local1, f7_arg0.objectiveIndex)
	local f7_local3 = Engine.ObjectiveIsAnyOtherTeamUsing(f7_local1, f7_arg0.objectiveIndex, f7_local2)
	local f7_local4 = Engine.GetObjectiveState(f7_arg1.controller, f7_arg0.objectiveIndex)
	f7_arg0.progress = Engine.GetObjectiveProgress(f7_local1, f7_arg0.objectiveIndex)
	if f7_arg0.isAnyOtherTeamUsing ~= f7_local3 then
		if f7_arg0.pulseWhenContested then
			if f7_local3 ~= true then
				f7_arg0:animateToState("original")
			else
				f7_arg0:animateToState("pulse")
			end
		else
			f7_arg0.forceRefresh = true
		end
		f7_arg0.isAnyOtherTeamUsing = f7_local3
	end
	if f7_arg0.team ~= f7_local2 or f7_arg0.state ~= f7_local4 or f7_arg0.forceRefresh then
		f7_arg0.team = f7_local2
		f7_arg0.state = f7_local4
		f7_arg0.forceRefresh = false
		f7_arg0.gameModeStatus:processEvent({
			name = "update_game_mode_status",
			controller = f7_local1
		})
	end
	f7_arg0.gameModeStatus:dispatchEventToParent({
		name = "update_player_objective",
		controller = f7_local1,
		materialName = f7_arg0.materialName,
		objectiveIndex = f7_arg0.objectiveIndex
	})
end

CoD.SpectateGameModeStatus.hq.CreateObjective = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg1.objectiveName
	local f8_local1 = f8_arg1.isMultiTeam
	local f8_local2 = CoD.SpectateGameModeStatus.hq.FlagSize
	local f8_local3 = "hud_shoutcasting_notify_hq"
	local f8_local4 = LUI.UIImage.new()
	f8_local4:setLeftRight(false, false, -f8_local2 / 2, f8_local2 / 2)
	f8_local4:setTopBottom(false, false, -f8_local2 / 2, f8_local2 / 2)
	f8_local4:setRGB(1, 1, 1)
	f8_local4:setAlpha(0)
	f8_local4:setImage(RegisterMaterial(f8_local3))
	f8_local4.state = CoD.OBJECTIVESTATE_EMPTY
	f8_local4.team = CoD.TEAM_FREE
	f8_local4.progress = 0
	f8_local4.objectiveIndex = nil
	f8_local4.materialName = f8_local3
	f8_local4.pulseWhenContested = f8_local1
	f8_local4.gameModeStatus = f8_arg1
	f8_local4:registerAnimationState("original", {
		alpha = 1
	})
	f8_local4:registerAnimationState("pulse", {
		alpha = 0.4
	})
	f8_local4:registerAnimationState("pulse2", {
		alpha = 1
	})
	f8_local4:registerEventHandler("transition_complete_pulse", CoD.SpectateGameModeStatus.Pulse)
	f8_local4:registerEventHandler("transition_complete_pulse2", CoD.SpectateGameModeStatus.Pulse2)
	f8_local4:registerEventHandler("objective_update_" .. f8_local0, CoD.SpectateGameModeStatus.hq.UpdateObjective)
	f8_local4:registerEventHandler("hud_update_refresh", CoD.SpectateGameModeStatus.hq.UpdateObjective)
	return f8_local4
end

CoD.SpectateGameModeStatus.hq.new = function (f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = CoD.Menu.NewFromState("SpectateGameModeStatus_hq", {
		left = 0,
		top = f9_arg1,
		right = 0,
		bottom = f9_arg1 + CoD.SpectateTopPanel.GameModeHeight,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f9_local0:setClass(CoD.SpectateGameModeStatus.hq)
	f9_local0:setOwner(f9_arg0)
	if Engine.GetGametypeSetting("teamCount") > 2 then
		f9_local0.isMultiTeam = true
	else
		f9_local0.isMultiTeam = false
	end
	f9_local0.leftTeamArea = LUI.UIHorizontalList.new()
	f9_local0.leftTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.hq.DockHeight, CoD.SpectateGameModeStatus.hq.DockHeight + CoD.SpectateGameModeStatus.hq.FlagSize)
	f9_local0.leftTeamArea:setSpacing(CoD.SpectateGameModeStatus.hq.TeamAreaListSpacing)
	f9_local0.centerTeamArea = LUI.UIHorizontalList.new()
	f9_local0.centerTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.hq.DockHeight, CoD.SpectateGameModeStatus.hq.DockHeight + CoD.SpectateGameModeStatus.hq.FlagSize)
	f9_local0.centerTeamArea:setSpacing(CoD.SpectateGameModeStatus.hq.TeamAreaListSpacing)
	f9_local0.rightTeamArea = LUI.UIHorizontalList.new()
	f9_local0.rightTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.hq.DockHeight, CoD.SpectateGameModeStatus.hq.DockHeight + CoD.SpectateGameModeStatus.hq.FlagSize)
	f9_local0.rightTeamArea:setSpacing(CoD.SpectateGameModeStatus.hq.TeamAreaListSpacing)
	if not f9_local0.isMultiTeam then
		f9_local0.leftTeamArea:setLeftRight(true, false, 0, CoD.SpectateTeamCardTwoTeam.RealWidth)
		f9_local0.leftTeamArea:setAlignment(LUI.Alignment.Left)
		f9_local0.centerTeamArea:setLeftRight(true, true, 0, 0)
		f9_local0.centerTeamArea:setAlignment(LUI.Alignment.Center)
		f9_local0.rightTeamArea:setLeftRight(false, true, -CoD.SpectateTeamCardTwoTeam.RealWidth, 0)
		f9_local0.rightTeamArea:setAlignment(LUI.Alignment.Right)
	else
		f9_local0.leftTeamArea:setLeftRight(true, false, 0, CoD.SpectateTeamCardMultiTeam.RealWidth)
		f9_local0.leftTeamArea:setAlignment(LUI.Alignment.Left)
		f9_local0.centerTeamArea:setLeftRight(true, false, CoD.SpectateTeamCardMultiTeam.RealWidth, CoD.SpectateTeamCardMultiTeam.RealWidth * 2)
		f9_local0.centerTeamArea:setAlignment(LUI.Alignment.Left)
		f9_local0.rightTeamArea:setLeftRight(true, false, CoD.SpectateTeamCardMultiTeam.RealWidth * 2, CoD.SpectateTeamCardMultiTeam.RealWidth * 3)
		f9_local0.rightTeamArea:setAlignment(LUI.Alignment.Left)
	end
	f9_local0.objectiveName = "objective"
	f9_local0.objective = CoD.SpectateGameModeStatus.hq.CreateObjective(f9_arg0, f9_local0)
	if f9_local0.objective ~= nil then
		f9_local0.centerTeamArea:addElement(f9_local0.objective)
	end
	f9_local0.objectiveText = LUI.UIText.new()
	f9_local0.objectiveText:setLeftRight(true, true, 0, 0)
	f9_local0.objectiveText:setTopBottom(false, false, -CoD.SpectateGameModeStatus.hq.FontSize / 2, CoD.SpectateGameModeStatus.hq.FontSize / 2)
	f9_local0.objectiveText:setFont(CoD.SpectateGameModeStatus.hq.Font)
	f9_local0.objectiveText:setRGB(1, 1, 1)
	f9_local0.objectiveText:setAlpha(1)
	f9_local0.objectiveTextTimer = LUI.UITimer.new(500, {
		name = "update_game_mode_objective_text",
		controller = f9_arg0
	}, false)
	f9_local0:addElement(f9_local0.objectiveTextTimer)
	f9_local0.getObjectiveText = CoD.SpectateGameModeStatus.hq.GetObjectiveText
	f9_local0:addElement(f9_local0.leftTeamArea)
	f9_local0:addElement(f9_local0.centerTeamArea)
	f9_local0:addElement(f9_local0.rightTeamArea)
	return f9_local0
end

CoD.SpectateGameModeStatus.hq.Initialize = function (f10_arg0, f10_arg1)
	if f10_arg0.objective ~= nil then
		f10_arg0.objective:processEvent({
			name = "objective_update_" .. f10_arg0.objectiveName,
			controller = f10_arg1.controller
		})
	end
end

CoD.SpectateGameModeStatus.hq:registerEventHandler("initialize_game_mode_status", CoD.SpectateGameModeStatus.hq.Initialize)
CoD.SpectateGameModeStatus.hq:registerEventHandler("update_game_mode_status", CoD.SpectateGameModeStatus.hq.Update)
CoD.SpectateGameModeStatus.hq:registerEventHandler("update_game_mode_objective_text", CoD.SpectateGameModeStatus.hq.UpdateObjectiveText)
