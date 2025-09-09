require("T6.PlayerList")
require("T6.Menus.SignInPopup")
CoD.LobbyList = {}
CoD.LobbyList.AddSplitscreenRow = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = CoD.PlayerListRow.CreateSplitscreenRow(f1_arg1, f1_arg2)
	f1_arg0.verticalList:addElement(f1_local0)
	f1_arg0.rowCount = f1_arg0.rowCount + 1
	return f1_local0
end

CoD.LobbyList.IsPrimaryControllerInList = function (f2_arg0)
	return CoD.PlayerList.IsXuidInList(f2_arg0, UIExpression.GetXUID(UIExpression.GetPrimaryController()))
end

CoD.LobbyList.ResetListAnimation = function (f3_arg0)
	f3_arg0:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = 0
	})
	f3_arg0:animateToState("default")
end

CoD.LobbyList.Update = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	if f4_arg0.splitscreenSignInRow ~= nil then
		f4_arg0.splitscreenSignInRow:close()
		f4_arg0.splitscreenSignInRow = nil
	end
	f4_arg0:clearList()
	f4_arg0.localPlayerCount = 0
	f4_arg0.playerCount = 0
	f4_arg0.rowCount = 0
	f4_arg0:resetListAnimation()
	if f4_arg0.splitscreenSignInAllowed == false then
		return 
	elseif Engine.PartyHostIsReadyToStart() == true then
		return 
	end
	if f4_arg1 ~= nil and #f4_arg1 >= UIExpression.DvarInt(nil, "party_maxplayers") then
		return 
	end
	local f4_local0 = UIExpression.GetUsedControllerCount()
	if f4_arg0.maxLocalPlayers ~= nil and f4_arg0.maxLocalPlayers <= f4_local0 then
		return 
	end
	local f4_local1, f4_local2 = nil
	if 0 < UIExpression.GetNonUsedControllerCount() then
		if f4_local0 == 0 then
			f4_local1 = Engine.Localize("PLATFORM_FEEDER_PRIMARY_CONTROLLER_PLAY")
		elseif true == Dvar.r_dualPlayEnable:get() and f4_local0 >= 2 then
			f4_local1 = Engine.Localize("MPUI_SPLITSCREEN_DUALVIEW_RESTRICTION")
		elseif true == CoD.isZombie and Dvar.r_stereo3DOn:get() and f4_local0 >= 2 then
			f4_local1 = Engine.Localize("MPUI_SPLITSCREEN_3D_RESTRICTION")
		else
			f4_local1 = Engine.Localize("PLATFORM_FEEDER_SECONDARY_CONTROLLER_PLAY")
		end
		f4_local2 = true
	else
		local f4_local3 = UIExpression.GetMaxControllerCount()
		if f4_local0 ~= nil and f4_local3 ~= nil and f4_local3 - f4_local0 > 0 then
			f4_local1 = Engine.Localize("PLATFORM_FEEDER_SECONDARY_CONTROLLER_PLUGIN")
		end
	end
	if f4_local1 ~= nil then
		f4_arg0.splitscreenSignInRow = f4_arg0:addSplitscreenRow(f4_local1, f4_local2)
		local f4_local3 = CoD.PlayerListRow.Height * f4_arg2
		f4_arg0:registerAnimationState("default", {
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = false,
			top = f4_local3,
			bottom = f4_local3 + CoD.PlayerListRow.Height * f4_arg0:getRowCount()
		})
		f4_arg0:animateToState("default")
	end
end

CoD.LobbyList.SignClientIn = function (f5_arg0, f5_arg1, f5_arg2)
	if Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH) then
		if Engine.ProbationCheckInProbation(CoD.GAMEMODE_PUBLIC_MATCH, f5_arg1) then
			f5_arg0:dispatchEventToParent({
				name = "sign_in_failed_probation",
				controller = f5_arg1,
				popup = "popup_public_inprobation"
			})
			return 
		elseif Engine.ProbationCheckForProbation(CoD.GAMEMODE_PUBLIC_MATCH, f5_arg1) then
			f5_arg0:dispatchEventToParent({
				name = "sign_in_failed_probation",
				controller = f5_arg1,
				popup = "popup_public_givenprobation"
			})
			return 
		end
	elseif Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
		if Engine.ProbationCheckInProbation(CoD.GAMEMODE_LEAGUE_MATCH, f5_arg1) then
			f5_arg0:dispatchEventToParent({
				name = "sign_in_failed_probation",
				controller = f5_arg1,
				popup = "popup_league_inprobation"
			})
			return 
		elseif Engine.ProbationCheckForProbation(CoD.GAMEMODE_LEAGUE_MATCH, f5_arg1) then
			f5_arg0:dispatchEventToParent({
				name = "sign_in_failed_probation",
				controller = f5_arg1,
				popup = "popup_league_givenprobation"
			})
			return 
		end
	end
	if f5_arg2 == true or f5_arg2 == 1 then
		Engine.Exec(f5_arg1, "signclientin 1")
	else
		Engine.Exec(f5_arg1, "signclientin")
	end
end

CoD.LobbyList.SignIn = function (f6_arg0, f6_arg1)
	if f6_arg0.splitscreenSignInRow ~= nil and f6_arg0.splitscreenSignInRow.allowJoin == true then
		CoD.LobbyList.SignClientIn(f6_arg0, f6_arg1.controller, false)
	end
end

CoD.LobbyList.SignInLocal = function (f7_arg0, f7_arg1)
	if CoD.LobbyList.IsOfflineGame() and f7_arg0.splitscreenSignInRow ~= nil and f7_arg0.splitscreenSignInRow.allowJoin == true then
		CoD.LobbyList.SignClientIn(f7_arg0, f7_arg1.controller, false)
	end
end

CoD.LobbyList.GuestSignIn = function (f8_arg0, f8_arg1)
	if f8_arg0.splitscreenSignInRow ~= nil and f8_arg0.splitscreenSignInRow.allowJoin == true then
		CoD.LobbyList.SignClientIn(f8_arg0, f8_arg1.controller, true)
	end
end

CoD.LobbyList.IsOfflineGame = function ()
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == true or UIExpression.SessionMode_IsSystemlinkGame() ~= 0 then
		return true
	else
		return false
	end
end

CoD.LobbyList.UnusedGamepadButton = function (f10_arg0, f10_arg1)
	local f10_local0 = UIExpression.GetUsedControllerCount()
	if f10_arg1.button == "primary" and f10_arg1.down == true and UIExpression.IsControllerBeingUsed(f10_arg1.controller) == 0 and (f10_arg0.maxLocalPlayers == nil or f10_local0 < f10_arg0.maxLocalPlayers) and f10_arg0.splitscreenSignInRow ~= nil and f10_arg0.splitscreenSignInRow.allowJoin == true and (true ~= Dvar.r_dualPlayEnable:get() or f10_local0 < 2) and (true ~= CoD.isZombie or not Dvar.r_stereo3DOn:get() or f10_local0 < 2) then
		if true == CoD.LobbyList.IsOfflineGame() and UIExpression.IsSignedIn(f10_arg1.controller) ~= 0 then
			CoD.LobbyList.SignClientIn(f10_arg0, f10_arg1.controller, UIExpression.IsGuest(f10_arg1.controller))
		elseif UIExpression.IsSignedInToLive(f10_arg1.controller) ~= 0 then
			CoD.LobbyList.SignClientIn(f10_arg0, f10_arg1.controller, UIExpression.IsGuest(f10_arg1.controller))
		elseif not CoD.isWIIU then
			if CoD.isPS3 then
				if true == CoD.LobbyList.IsOfflineGame() then
					Engine.Exec(f10_arg1.controller, "xsigninguest")
				else
					f10_arg0:dispatchEventToParent({
						name = "open_sign_in",
						controller = f10_arg1.controller
					})
				end
			elseif Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false and UIExpression.SessionMode_IsSystemlinkGame() == 0 then
				Engine.Exec(f10_arg1.controller, "xsigninlive")
			else
				Engine.Exec(f10_arg1.controller, "xsignin")
			end
		end
		return true
	else

	end
end

CoD.LobbyList.SetSplitscreenSignInAllowed = function (f11_arg0, f11_arg1)
	f11_arg0.splitscreenSignInAllowed = f11_arg1
end

CoD.LobbyList.New = function (f12_arg0, f12_arg1, f12_arg2, f12_arg3, f12_arg4, f12_arg5)
	local f12_local0 = CoD.PlayerList.New(f12_arg0, false, f12_arg1, f12_arg2, f12_arg3, f12_arg4)
	f12_local0.addSplitscreenRow = CoD.LobbyList.AddSplitscreenRow
	f12_local0.setSplitscreenSignInAllowed = CoD.LobbyList.SetSplitscreenSignInAllowed
	f12_local0.update = CoD.LobbyList.Update
	f12_local0.resetListAnimation = CoD.LobbyList.ResetListAnimation
	f12_local0.maxLocalPlayers = 0
	if f12_arg5 ~= nil then
		f12_local0.maxLocalPlayers = f12_arg5
	end
	f12_local0:registerEventHandler("unused_gamepad_button", CoD.LobbyList.UnusedGamepadButton)
	f12_local0:registerEventHandler("signed_into_live", CoD.LobbyList.SignIn)
	f12_local0:registerEventHandler("signed_in_local", CoD.LobbyList.SignInLocal)
	f12_local0:registerEventHandler("stats_downloaded", CoD.LobbyList.SignIn)
	f12_local0:registerEventHandler("guest_signed_into_live", CoD.LobbyList.GuestSignIn)
	return f12_local0
end

