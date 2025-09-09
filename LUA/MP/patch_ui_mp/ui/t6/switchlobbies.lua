if CoD == nil then
	CoD = {}
end
CoD.GetDefaultMap = function (f1_arg0)
	local f1_local0 = CoD.LEVEL_COOP_FIRST
	if CoD.isZombie then
		f1_local0 = CoD.Zombie.MAP_ZM_TRANSIT
	elseif CoD.isMultiplayer then
		f1_local0 = UIExpression.TableLookup(f1_arg0, UIExpression.GetCurrentMapTableName(f1_arg0), 5, 0, 0)
	end
	return f1_local0
end

CoD.GetDefaultMapStartLocationGameType_Zombie = function (f2_arg0)
	return CoD.Zombie.START_LOCATION_TRANSIT, CoD.Zombie.GAMETYPE_ZCLASSIC
end

local f0_local0 = function (f3_arg0)
	if f3_arg0 == "" then
		return false
	elseif not Engine.IsMapValid(f3_arg0) then
		return false
	else
		return true
	end
end

local f0_local1 = function (f4_arg0)
	local f4_local0 = UIExpression.ProfileValueAsString(f4_arg0, CoD.profileKey_map)
	if not f0_local0(f4_local0) then
		f4_local0 = CoD.GetDefaultMap(f4_arg0)
	end
	return f4_local0
end

local f0_local2 = function (f5_arg0)
	local f5_local0 = f0_local1(f5_arg0)
	if UIExpression.TableLookup(f5_arg0, UIExpression.GetCurrentMapTableName(f5_arg0), 0, f5_local0, 10) == "NO" then
		f5_local0 = CoD.GetDefaultMap(f5_arg0)
	end
	return f5_local0
end

local f0_local3 = function (f6_arg0)
	local f6_local0 = ""
	if CoD.isZombie then
		f6_local0 = CoD.Zombie.GAMETYPE_ZCLASSIC
	elseif CoD.isMultiplayer then
		f6_local0 = "tdm"
	end
	return f6_local0
end

local f0_local4 = function (f7_arg0)
	if f7_arg0 == "" then
		return false
	else
		return true
	end
end

local f0_local5 = function (f8_arg0)
	local f8_local0 = UIExpression.ProfileValueAsString(f8_arg0, CoD.profileKey_gametype)
	if not f0_local4(f8_local0) then
		f8_local0 = f0_local3(f8_arg0)
	end
	return f8_local0
end

local f0_local6 = function (f9_arg0)
	local f9_local0 = f0_local5(f9_arg0)
	if UIExpression.TableLookup(f9_arg0, CoD.gametypesTable, 0, 0, 1, f9_local0, 6) == "NO" then
		f9_local0 = f0_local3(f9_arg0)
	end
	return f9_local0
end

local f0_local7 = function (f10_arg0, f10_arg1, f10_arg2, f10_arg3)
	CoD.resetGameModes()
	if f10_arg3 == nil or f10_arg3 == true then
		f10_arg1 = Engine.GetMaxUserPlayerCount(f10_arg0)
	end
	Engine.PartySetMaxPlayerCount(f10_arg1)
	Engine.SetDvar("party_maxlocalplayers", f10_arg2)
end

local f0_local8 = function (f11_arg0)
	Engine.Exec(f11_arg0, "xstartprivateparty")
	Engine.Exec(f11_arg0, "xstartpartyhost")
	Engine.Exec(f11_arg0, "party_statechanged")
end

CoD.SwitchToPlayerMatchLobby = function (f12_arg0)
	Engine.ExecNow(f12_arg0, "xstopparty")
	f0_local7(f12_arg0, UIExpression.DvarInt(f12_arg0, "party_maxplayers_playermatch"), UIExpression.DvarInt(f12_arg0, "party_maxlocalplayers_playermatch"))
	Engine.SessionModeSetPrivate(false)
	Engine.SessionModeSetOnlineGame(true)
	Engine.SetGametype(f0_local5(f12_arg0))
	Engine.GameModeSetMode(CoD.GAMEMODE_PUBLIC_MATCH, true)
	Engine.Exec(f12_arg0, "party_statechanged")
end

local f0_local9 = function (f13_arg0)
	if CoD.isMultiplayer then
		f0_local7(f13_arg0, UIExpression.DvarInt(f13_arg0, "party_maxplayers_privatematch"), UIExpression.DvarInt(f13_arg0, "party_maxlocalplayers_privatematch"))
	else
		f0_local7(f13_arg0, 4, 2)
	end
end

local f0_local10 = function (f14_arg0)
	if CoD.isMultiplayer then
		Engine.ExecNow(f14_arg0, "exec default_private.cfg")
		Engine.SetGametype(f0_local5(f14_arg0))
		Engine.ExecNow(f14_arg0, "ui_mapname " .. f0_local1(f14_arg0))
	else
		Engine.SetDvar("ui_mapname", CoD.LEVEL_COOP_FIRST)
	end
end

CoD.SwitchToPrivateLobby = function (f15_arg0)
	f0_local9(f15_arg0)
	Engine.SessionModeSetPrivate(true)
	Engine.SessionModeSetOnlineGame(true)
	Engine.GameModeSetMode(CoD.GAMEMODE_PRIVATE_MATCH, true)
	f0_local10(f15_arg0)
	f0_local8(f15_arg0)
end

CoD.SwitchToLeagueMatchLobby = function (f16_arg0)
	Engine.ExecNow(f16_arg0, "xstopparty")
	f0_local7(f16_arg0, UIExpression.DvarInt(f16_arg0, "party_maxplayers_leaguematch"), UIExpression.DvarInt(f16_arg0, "party_maxlocalplayers_leaguematch"))
	Engine.SessionModeSetPrivate(false)
	Engine.SessionModeSetOnlineGame(true)
	Engine.GameModeSetMode(CoD.GAMEMODE_LEAGUE_MATCH, true)
	Engine.Exec(f16_arg0, "party_statechanged")
end

CoD.SwitchToSystemLinkLobby = function (f17_arg0)
	Engine.ExecNow(f17_arg0, "leaveAllParties")
	f0_local7(f17_arg0, UIExpression.DvarInt(f17_arg0, "party_maxplayers_systemlink"), UIExpression.DvarInt(f17_arg0, "party_maxlocalplayers_systemlink"), false)
	Engine.SessionModeSetOnlineGame(false)
	Engine.SessionModeSetSystemLink(true)
	Engine.GameModeSetMode(CoD.GAMEMODE_PRIVATE_MATCH, true)
	Engine.ExecNow(f17_arg0, "exec default_private.cfg")
	Engine.SetGametype(f0_local5(f17_arg0))
	Engine.ExecNow(f17_arg0, "ui_mapname " .. f0_local1(f17_arg0))
	Engine.ExecNow(f17_arg0, "xstartlocalprivateparty")
	Engine.ExecNow(f17_arg0, "xstartpartyhost")
	Dvar.party_maxplayers:set(Dvar.party_maxplayers_systemlink:get())
	Engine.Exec(f17_arg0, "party_statechanged")
end

CoD.SwitchToSystemLinkGame = function (f18_arg0)
	Engine.ExecNow(f18_arg0, "leaveAllParties")
	f0_local7(f18_arg0, UIExpression.DvarInt(f18_arg0, "party_maxplayers_systemlink"), UIExpression.DvarInt(f18_arg0, "party_maxlocalplayers_systemlink"), false)
	Engine.SessionModeSetOnlineGame(false)
	Engine.SessionModeSetSystemLink(true)
	Engine.GameModeSetMode(CoD.GAMEMODE_PRIVATE_MATCH, false)
end

CoD.SwitchToLocalLobby = function (f19_arg0)
	Engine.ExecNow(f19_arg0, "leaveAllParties")
	f0_local7(f19_arg0, UIExpression.DvarInt(f19_arg0, "party_maxplayers_local_splitscreen"), UIExpression.DvarInt(f19_arg0, "party_maxlocalplayers_local_splitscreen"), false)
	Engine.SessionModeSetOffline(true)
	Engine.GameModeSetMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN, true)
	Engine.ExecNow(f19_arg0, "exec default_splitscreen.cfg")
	Engine.SetGametype(f0_local6(f19_arg0))
	Engine.ExecNow(f19_arg0, "ui_mapname " .. f0_local2(f19_arg0))
	Engine.ExecNow(f19_arg0, "xstartlocalprivateparty")
	Engine.ExecNow(f19_arg0, "xstartpartyhost")
	Dvar.party_maxplayers:set(Dvar.party_maxplayers_local_splitscreen:get())
	if CoD.isWIIU and CoD.isZombie then
		Engine.SetDvar("party_maxplayers", 2)
		Engine.SetDvar("party_maxlocalplayers", 2)
	end
end

CoD.SwitchToTheaterLobby = function (f20_arg0)
	Engine.ExecNow(f20_arg0, "xstopparty")
	f0_local7(f20_arg0, UIExpression.DvarInt(f20_arg0, "party_maxplayers_theater"), UIExpression.DvarInt(f20_arg0, "party_maxlocalplayers_theater"), false)
	Engine.SessionModeSetPrivate(true)
	Engine.SessionModeSetOnlineGame(true)
	Engine.GameModeSetMode(CoD.GAMEMODE_THEATER, true)
	Engine.Exec(f20_arg0, "exec default_private.cfg")
	Engine.SetDvar("ui_demoname", "")
	Engine.SetTheaterFileInfo(false)
	f0_local8(f20_arg0)
end

CoD.SwitchToMainLobby = function (f21_arg0)
	f0_local7(f21_arg0, UIExpression.DvarInt(f21_arg0, "party_maxplayers_privatematch"), UIExpression.DvarInt(f21_arg0, "party_maxlocalplayers_privatematch"))
	Engine.SessionModeSetPrivate(false)
	Engine.SessionModeSetOnlineGame(true)
	Engine.Exec(f21_arg0, "party_statechanged")
end

local f0_local11 = function (f22_arg0)
	if CoD.isMultiplayer then
		f0_local7(f22_arg0, UIExpression.DvarInt(f22_arg0, "party_maxplayers_partylobby"), UIExpression.DvarInt(f22_arg0, "party_maxlocalplayers_playermatch"))
	else
		f0_local7(f22_arg0, 4, 2)
	end
end

CoD.StartMainLobby = function (f23_arg0)
	Engine.ExecNow(f23_arg0, "setclientbeingusedandprimary")
	f0_local11(f23_arg0)
	Engine.SessionModeSetOnlineGame(true)
	if Engine.IsSignedInToDemonware(f23_arg0) == true and Engine.HasMPPrivileges(f23_arg0) == true then
		Engine.Exec(f23_arg0, "xstartprivateparty")
		Engine.Exec(f23_arg0, "party_statechanged")
	end
end

CoD.EndLobby = function (f24_arg0)
	Engine.ExecNow(f24_arg0, "xstopallparties")
	CoD.resetGameModes()
end

