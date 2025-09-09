CoD.SpectateGameModeStatus = {}
CoD.SpectateGameModeStatus.ctf = InheritFrom(CoD.Menu)
CoD.SpectateGameModeStatus.dem = InheritFrom(CoD.Menu)
CoD.SpectateGameModeStatus.dom = InheritFrom(CoD.Menu)
CoD.SpectateGameModeStatus.hq = InheritFrom(CoD.Menu)
CoD.SpectateGameModeStatus.koth = InheritFrom(CoD.Menu)
CoD.SpectateGameModeStatus.oneflag = InheritFrom(CoD.Menu)
CoD.SpectateGameModeStatus.sd = InheritFrom(CoD.Menu)
CoD.SpectateGameModeStatus.Pulse = function (f1_arg0, f1_arg1)
	if not f1_arg1.interrupted then
		f1_arg0:animateToState("pulse2", 500)
	end
end

CoD.SpectateGameModeStatus.Pulse2 = function (f2_arg0, f2_arg1)
	if not f2_arg1.interrupted then
		f2_arg0:animateToState("pulse", 500)
	end
end

CoD.SpectateGameModeStatus.GetMenu = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = Dvar.ui_gameType:get()
	if CoD.SpectateGameModeStatus[f3_local0] ~= nil then
		return CoD.SpectateGameModeStatus[f3_local0].new(f3_arg0, f3_arg1, f3_arg2)
	else
		return nil
	end
end

