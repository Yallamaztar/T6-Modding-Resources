CoD.SpectateGameModeStatus.dom.FlagSize = 16
CoD.SpectateGameModeStatus.dom.DockHeight = 10
CoD.SpectateGameModeStatus.dom.TeamAreaListSpacing = 2
CoD.SpectateGameModeStatus.dom.Update = function (f1_arg0, f1_arg1)
	f1_arg0.leftTeamArea:removeAllChildren()
	f1_arg0.centerTeamArea:removeAllChildren()
	f1_arg0.rightTeamArea:removeAllChildren()
	for f1_local0 = 1, #f1_arg0.flag, 1 do
		local f1_local3 = f1_arg0.flag[f1_local0]
		if f1_local3.team == CoD.TEAM_ALLIES then
			f1_arg0.leftTeamArea:addElement(f1_local3)
		end
	end
	for f1_local0 = 1, #f1_arg0.flag, 1 do
		local f1_local3 = f1_arg0.flag[f1_local0]
		if f1_local3.team ~= CoD.TEAM_ALLIES and f1_local3.team ~= CoD.TEAM_AXIS then
			f1_arg0.centerTeamArea:addElement(f1_local3)
		end
	end
	for f1_local0 = #f1_arg0.flag, 1, -1 do
		local f1_local3 = f1_arg0.flag[f1_local0]
		if f1_local3.team == CoD.TEAM_AXIS then
			f1_arg0.rightTeamArea:addElement(f1_local3)
		end
	end
end

CoD.SpectateGameModeStatus.dom.UpdateFlag = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	local f2_local1 = Engine.GetObjectiveTeam(f2_local0, f2_arg0.objectiveIndex)
	local f2_local2 = Engine.ObjectiveIsAnyOtherTeamUsing(f2_local0, f2_arg0.objectiveIndex, f2_local1)
	f2_arg0.progress = Engine.GetObjectiveProgress(f2_local0, f2_arg0.objectiveIndex)
	if f2_arg0.isAnyOtherTeamUsing ~= f2_local2 then
		if f2_local2 ~= true then
			f2_arg0:animateToState("original")
		else
			f2_arg0:animateToState("pulse")
		end
		f2_arg0.isAnyOtherTeamUsing = f2_local2
	end
	if f2_arg0.team ~= f2_local1 then
		f2_arg0:animateToState("original")
		f2_arg0.team = f2_local1
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

CoD.SpectateGameModeStatus.dom.CreateFlag = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = CoD.SpectateGameModeStatus.dom.FlagSize
	local f3_local1 = f3_arg2.objectiveNames[f3_arg1]
	local f3_local2 = Engine.GetObjectiveIndexFromName(f3_arg0, f3_local1)
	if f3_local2 == nil then
		return nil
	else
		local f3_local3 = "hud_shoutcasting_notify" .. f3_local1
		local f3_local4 = LUI.UIImage.new()
		f3_local4:setLeftRight(false, false, -f3_local0 / 2, f3_local0 / 2)
		f3_local4:setTopBottom(false, false, -f3_local0 / 2, f3_local0 / 2)
		f3_local4:setRGB(1, 1, 1)
		f3_local4:setAlpha(1)
		f3_local4:setImage(RegisterMaterial(f3_local3))
		f3_local4.team = CoD.TEAM_FREE
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
		f3_local4:registerEventHandler("objective_update_" .. f3_local1, CoD.SpectateGameModeStatus.dom.UpdateFlag)
		f3_local4:registerEventHandler("hud_update_refresh", CoD.SpectateGameModeStatus.dom.UpdateFlag)
		return f3_local4
	end
end

CoD.SpectateGameModeStatus.dom.new = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = CoD.Menu.NewFromState("SpectateGameModeStatus_dom", {
		left = 0,
		top = f4_arg1,
		right = 0,
		bottom = f4_arg1 + CoD.SpectateTopPanel.GameModeHeight,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f4_local0:setClass(CoD.SpectateGameModeStatus.dom)
	f4_local0:setOwner(f4_arg0)
	f4_local0.leftTeamArea = LUI.UIHorizontalList.new()
	f4_local0.leftTeamArea:setLeftRight(true, false, 0, CoD.SpectateTeamCardTwoTeam.RealWidth)
	f4_local0.leftTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.dom.DockHeight, CoD.SpectateGameModeStatus.dom.DockHeight + CoD.SpectateGameModeStatus.dom.FlagSize)
	f4_local0.leftTeamArea:setSpacing(CoD.SpectateGameModeStatus.dom.TeamAreaListSpacing)
	f4_local0.leftTeamArea:setAlignment(LUI.Alignment.Left)
	f4_local0.centerTeamArea = LUI.UIHorizontalList.new()
	f4_local0.centerTeamArea:setLeftRight(true, true, 0, 0)
	f4_local0.centerTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.dom.DockHeight, CoD.SpectateGameModeStatus.dom.DockHeight + CoD.SpectateGameModeStatus.dom.FlagSize)
	f4_local0.centerTeamArea:setSpacing(CoD.SpectateGameModeStatus.dom.TeamAreaListSpacing)
	f4_local0.centerTeamArea:setAlignment(LUI.Alignment.Center)
	f4_local0.rightTeamArea = LUI.UIHorizontalList.new()
	f4_local0.rightTeamArea:setLeftRight(false, true, -CoD.SpectateTeamCardTwoTeam.RealWidth, 0)
	f4_local0.rightTeamArea:setTopBottom(true, false, CoD.SpectateGameModeStatus.dom.DockHeight, CoD.SpectateGameModeStatus.dom.DockHeight + CoD.SpectateGameModeStatus.dom.FlagSize)
	f4_local0.rightTeamArea:setSpacing(CoD.SpectateGameModeStatus.dom.TeamAreaListSpacing)
	f4_local0.rightTeamArea:setAlignment(LUI.Alignment.Right)
	f4_local0.objectiveNames = {}
	f4_local0.objectiveNames[1] = "_a"
	f4_local0.objectiveNames[2] = "_b"
	f4_local0.objectiveNames[3] = "_c"
	f4_local0.flag = {}
	for f4_local1 = 1, #f4_local0.objectiveNames, 1 do
		f4_local0.flag[f4_local1] = CoD.SpectateGameModeStatus.dom.CreateFlag(f4_arg0, f4_local1, f4_local0)
		if f4_local0.flag[f4_local1] ~= nil then
			f4_local0.centerTeamArea:addElement(f4_local0.flag[f4_local1])
		end
	end
	f4_local0:addElement(f4_local0.leftTeamArea)
	f4_local0:addElement(f4_local0.centerTeamArea)
	f4_local0:addElement(f4_local0.rightTeamArea)
	return f4_local0
end

CoD.SpectateGameModeStatus.dom:registerEventHandler("update_game_mode_status", CoD.SpectateGameModeStatus.dom.Update)
