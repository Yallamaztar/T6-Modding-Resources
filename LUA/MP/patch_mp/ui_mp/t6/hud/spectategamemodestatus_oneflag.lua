CoD.SpectateGameModeStatus.oneflag.FlagSize = 16
CoD.SpectateGameModeStatus.oneflag.DockHeight = 10
CoD.SpectateGameModeStatus.oneflag.TeamAreaListSpacing = 10
CoD.SpectateGameModeStatus.oneflag.Font = CoD.fonts.Default
CoD.SpectateGameModeStatus.oneflag.FontSize = CoD.textSize.Default
CoD.SpectateGameModeStatus.oneflag.update = function (f1_arg0, f1_arg1)
	local f1_local0 = f1_arg1.controller
	local f1_local1 = Engine.GetObjectiveIndexFromName(f1_local0, "neutral_flag")
	f1_arg0:dispatchEventToParent({
		name = "update_player_objective",
		controller = f1_local0,
		materialName = "hud_shoutcasting_notify_flag",
		objectiveIndex = f1_local1,
		objectiveEntity = Engine.GetObjectiveEntity(f1_local0, f1_local1)
	})
end

CoD.SpectateGameModeStatus.oneflag.new = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = CoD.Menu.NewFromState("SpectateGameModeStatus_oneflag", {
		left = 0,
		top = f2_arg1,
		right = 0,
		bottom = f2_arg1 + CoD.SpectateTopPanel.GameModeHeight,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f2_local0:setClass(CoD.SpectateGameModeStatus.oneflag)
	f2_local0:setOwner(f2_arg0)
	return f2_local0
end

CoD.SpectateGameModeStatus.oneflag:registerEventHandler("initialize_game_mode_status", CoD.SpectateGameModeStatus.oneflag.update)
CoD.SpectateGameModeStatus.oneflag:registerEventHandler("objective_update_neutral_flag", CoD.SpectateGameModeStatus.oneflag.update)
CoD.SpectateGameModeStatus.oneflag:registerEventHandler("hud_update_refresh", CoD.SpectateGameModeStatus.oneflag.update)
