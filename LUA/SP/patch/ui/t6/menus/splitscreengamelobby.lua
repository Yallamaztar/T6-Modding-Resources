require("T6.Menus.PrivateGameLobby")
CoD.SplitscreenGameLobby = {}
CoD.SplitscreenGameLobby.PopulateButtons = function (f1_arg0)
	CoD.PrivateGameLobby.PopulateButtons(f1_arg0)
	if f1_arg0.body ~= nil then
		if f1_arg0.body.switchLobbiesButton ~= nil then
			f1_arg0.body.switchLobbiesButton:close()
		end
		if f1_arg0.body.barracksButton ~= nil then
			f1_arg0.body.barracksButton:close()
		end
		if f1_arg0.body.liveStreamingButton ~= nil then
			f1_arg0.body.liveStreamingButton:close()
		end
		if f1_arg0.body.startMatchButton ~= nil and CoD.isZombie == true then
			if CoD.SplitscreenGameLobby.ShouldDisableStartMatchButton_Zombie(#CoD.SplitscreenGameLobby.GetLocalMembers()) == true then
				f1_arg0.body.startMatchButton:disable()
			else
				f1_arg0.body.startMatchButton:enable()
			end
		end
		if not f1_arg0:restoreState() and CoD.useController == true then
			f1_arg0.body.startMatchButton:processEvent({
				name = "gain_focus"
			})
		end
	end
end

CoD.SplitscreenGameLobby.PopulateButtonPaneElements = function (f2_arg0)
	CoD.PrivateLocalGameLobby.PopulateButtons(f2_arg0)
end

CoD.SplitscreenGameLobby.ShouldDisableStartMatchButton_Zombie = function (f3_arg0)
	local f3_local0 = UIExpression.DvarString(nil, "ui_zm_gamemodegroup")
	if CoD.Zombie.GameTypeGroups[f3_local0].maxPlayers < f3_arg0 or f3_arg0 < CoD.Zombie.GameTypeGroups[f3_local0].minPlayers then
		return true
	else
		return false
	end
end

CoD.SplitscreenGameLobby.UpdateStartMatchButton_Zombie = function (f4_arg0, f4_arg1)
	local f4_local0 = 0
	if f4_arg1.members ~= nil then
		f4_local0 = #f4_arg1.members
	end
	if CoD.SplitscreenGameLobby.ShouldDisableStartMatchButton_Zombie(f4_local0) == true then
		f4_arg0.buttonPane.body.startMatchButton:disable()
	else
		f4_arg0.buttonPane.body.startMatchButton:enable()
	end
end

LUI.createMenu.SplitscreenGameLobby = function (f5_arg0)
	local f5_local0 = CoD.PrivateGameLobby.New("SplitscreenGameLobby", f5_arg0)
	if CoD.isMultiplayer then
		f5_local0:setPreviousMenu("MainMenu")
	end
	f5_local0:addTitle(Engine.Localize("MENU_LOCAL_CAPS"))
	f5_local0.populateButtonPaneElements = CoD.SplitscreenGameLobby.PopulateButtonPaneElements
	f5_local0.populateButtons = CoD.SplitscreenGameLobby.PopulateButtons
	f5_local0:updatePanelFunctions()
	local f5_local1 = f5_local0.lobbyPane.body.lobbyList
	f5_local1:registerEventHandler("stats_downloaded", CoD.SplitscreenGameLobby.DoNothing)
	if CoD.isZombie == true then
		f5_local0:registerEventHandler("update_start_match_button", CoD.SplitscreenGameLobby.UpdateStartMatchButton_Zombie)
		f5_local1.menu = f5_local0
	end
	CoD.SplitscreenGameLobby.PopulateButtons(f5_local0.buttonPane)
	CoD.Lobby.RemovePartyPrivacyButton(f5_local0)
	f5_local0.panelManager:setSlidingAllowed(false)
	return f5_local0
end

CoD.SplitscreenGameLobby.StartMatch = function (f6_arg0, f6_arg1)
	Engine.StartServer(f6_arg1.controller)
end

CoD.SplitscreenGameLobby.GetLocalMembers = function ()
	local f7_local0 = UIExpression.GetUsedControllerCount()
	local f7_local1 = UIExpression.GetNonUsedControllerCount()
	local f7_local2 = UIExpression.GetMaxControllerCount()
	local f7_local3 = {}
	local f7_local4 = 0
	for f7_local5 = 0, f7_local2 - 1, 1 do
		if Engine.IsControllerUsed(f7_local5) == true then
			table.insert(f7_local3, {
				background = RegisterMaterial("menu_mp_lobby_bar_name"),
				xuid = Engine.GetXUIDStringForController(f7_local5),
				gamertag = Engine.GetGamertagForController(f7_local5),
				team = 0,
				clientNum = Engine.GetLocalClientNum(f7_local5)
			})
			f7_local4 = f7_local4 + 1
		end
		if f7_local4 == f7_local0 then
			break
		end
	end
	table.sort(f7_local3, CoD.SplitscreenGameLobby.MemberComparisonFunction)
	return f7_local3
end

CoD.SplitscreenGameLobby.MemberComparisonFunction = function (f8_arg0, f8_arg1)
	if f8_arg0.clientNum ~= f8_arg1.clientNum then
		return f8_arg0.clientNum < f8_arg1.clientNum
	else
		return f8_arg0.gamertag:lower() < f8_arg1.gamertag:lower()
	end
end

CoD.SplitscreenGameLobby.DoNothing = function (f9_arg0, f9_arg1)

end

