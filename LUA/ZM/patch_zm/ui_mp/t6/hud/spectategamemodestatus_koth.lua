CoD.SpectateGameModeStatus.koth.GetObjectiveText = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = 0
	local f1_local1 = Engine.GetInGamePlayerList(f1_arg1, f1_arg2.team)
	for f1_local2 = 1, #f1_local1, 1 do
		if Engine.ObjectiveIsPlayerUsing(f1_arg1, f1_arg2.objectiveIndex, f1_local1[f1_local2].clientNum) then
			f1_local0 = f1_local0 + 1
		end
	end
	return Engine.Localize("MPUI_SHOUTCASTER_NUMBER_PLAYERS", f1_local0)
end

CoD.SpectateGameModeStatus.koth.new = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = CoD.SpectateGameModeStatus.hq.new(f2_arg0, f2_arg1, f2_arg2)
	f2_local0.objective.materialName = "hud_shoutcasting_notify_arrow"
	f2_local0.objective:setImage(RegisterMaterial(f2_local0.objective.materialName))
	f2_local0.getObjectiveText = CoD.SpectateGameModeStatus.koth.GetObjectiveText
	return f2_local0
end

