require("T6.Lobby")
require("T6.MapVoter")
if CoD.isZombie == false then
	require("T6.CACImportValidate")
end
CoD.GameLobby = {}
CoD.GameLobby.Update = function (f1_arg0, f1_arg1)
	f1_arg0:dispatchEventToChildren(f1_arg1)
	f1_arg0:processEvent({
		name = "party_update_status"
	})
end

CoD.GameLobby.Button_CAC = function (f2_arg0, f2_arg1)
	f2_arg0:dispatchEventToParent({
		name = "open_cac",
		controller = f2_arg1.controller,
		isLocked = CoD.CheckButtonLock(f2_arg0, f2_arg1.controller)
	})
end

CoD.GameLobby.CacImportAdditionalValidation = function (f3_arg0, f3_arg1)
	Engine.ECACImport_ValidateDecision(f3_arg1.controller, CoD.CACImportValidate.validate(f3_arg0, f3_arg1))
end

CoD.GameLobby.CacImportPopupClosed = function (f4_arg0, f4_arg1)
	f4_arg0:processEvent({
		name = "open_cac",
		controller = f4_arg1.controller,
		isLocked = false
	})
end

CoD.GameLobby.OpenCAC = function (f5_arg0, f5_arg1)
	if f5_arg1.isLocked == true then
		Engine.PlaySound(CoD.CACUtility.denySFX)
		local f5_local0 = f5_arg0:openPopup("Error", f5_arg1.controller)
		f5_local0:setMessage(Engine.Localize(CoD.GetUnlockLevelString(f5_arg1.controller, "FEATURE_CREATE_A_CLASS")))
	elseif Engine.ECACImport_ShouldShow(f5_arg1.controller) == 1 then
		f5_arg0:openPopup("CACImportPopup", f5_arg1.controller)
	else
		Engine.PlaySound("cac_enter_cac")
		Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_MODIFYING_CAC)
		f5_arg0:openPopup("CACChooseClass", f5_arg1.controller)
	end
end

CoD.GameLobby.Button_Rewards = function (f6_arg0, f6_arg1)
	f6_arg0:dispatchEventToParent({
		name = "open_rewards",
		controller = f6_arg1.controller,
		isLocked = CoD.CheckButtonLock(f6_arg0, f6_arg1.controller)
	})
end

CoD.GameLobby.OpenRewards = function (f7_arg0, f7_arg1)
	if f7_arg1.isLocked == true then
		Engine.PlaySound(CoD.CACUtility.denySFX)
		local f7_local0 = f7_arg0:openPopup("Error", f7_arg1.controller)
		f7_local0:setMessage(Engine.Localize(CoD.GetUnlockLevelString(f7_arg1.controller, "FEATURE_KILLSTREAKS")))
	else
		Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_MODIFYING_REWARDS)
		f7_arg0:openPopup("Rewards", f7_arg1.controller)
		Engine.PlaySound("cac_screen_fade")
	end
end

CoD.GameLobby.OpenBarracks = function (f8_arg0, f8_arg1)
	if UIExpression.IsGuest(f8_arg1.controller) == 1 then
		f8_arg0:openPopup("popup_guest_contentrestricted", f8_arg1.controller)
		return 
	elseif CoD.isZombie == true then
		f8_arg0:openPopup("LeaderboardCarouselZM", f8_arg1.controller)
	else
		Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_VIEWING_PLAYERCARD)
		f8_arg0:openPopup("Barracks", f8_arg1.controller)
	end
end

CoD.GameLobby.UpdateStatusTextInternal = function (f9_arg0)
	local f9_local0, f9_local1 = nil
	local f9_local2 = ""
	local f9_local3, f9_local4 = Engine.GetGameLobbyStatus()
	f9_local1 = f9_local4
	f9_local0 = f9_local3
	if f9_local0 == "" and UIExpression.GameHost() == 0 then
		f9_local2 = CoD.getPartyHostStateText(Engine.PartyGetHostUIState())
		if f9_local2 == "" then
			f9_local2 = Engine.Localize("MENU_READY")
		end
		f9_local0 = Engine.Localize("MENU_PARTY_LEADER") .. " " .. f9_local2
	end
	if f9_arg0.lastStatus ~= f9_local0 or f9_arg0.lastTimeRemaining ~= f9_local1 then
		f9_arg0.lastStatus = f9_local0
		f9_arg0.timeRemaining = f9_local1
		if f9_local1 ~= nil and f9_local1 > 0 then
			f9_arg0:setText(f9_local0 .. ":  " .. f9_local1)
		else
			f9_arg0:setText(f9_local0)
			f9_arg0.currentHostState = nil
		end
	end
end

CoD.GameLobby.UpdateStatusText = function (f10_arg0, f10_arg1)
	if f10_arg0.buttonPane.body == nil or f10_arg0.buttonPane.body.statusText == nil then
		return 
	else
		CoD.GameLobby.UpdateStatusTextInternal(f10_arg0.buttonPane.body.statusText)
	end
end

CoD.GameLobby.PopulateButtons = function (f11_arg0, f11_arg1)
	CoD.GameLobby.AddStatusText(f11_arg0, f11_arg1)
end

CoD.GameLobby.AddStatusText = function (f12_arg0, f12_arg1)
	if f12_arg0.body.statusText ~= nil then
		f12_arg0.body.statusText:close()
		f12_arg0.body.statusText = nil
	end
	local f12_local0 = "Condensed"
	local f12_local1 = CoD.fonts[f12_local0]
	local f12_local2 = CoD.textSize[f12_local0]
	local f12_local3 = -f12_arg1 - CoD.ButtonPrompt.Height - 15 - f12_local2 - 3
	f12_arg0.body.statusText = LUI.UIText.new({
		left = 0,
		top = f12_local3,
		right = 100,
		bottom = f12_local3 + f12_local2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		font = f12_local1
	})
	f12_arg0.body:addElement(f12_arg0.body.statusText)
	f12_arg0:dispatchEventToParent({
		name = "party_update_status"
	})
end

CoD.GameLobby.new = function (LobbyType, LocalClientIndex, f13_arg2, f13_arg3, f13_arg4)
	if f13_arg3 == nil then
		f13_arg3 = Engine.Localize("MENU_MULTIPLAYER_CAPS")
	end
	local f13_local0 = CoD.Lobby.New(LobbyType, LocalClientIndex, f13_arg2, f13_arg3, f13_arg4)
	f13_local0:registerEventHandler("gamelobby_update", CoD.GameLobby.Update)
	f13_local0:registerEventHandler("partylobby_update", CoD.GameLobby.Update)
	f13_local0:registerEventHandler("party_update_status", CoD.GameLobby.UpdateStatusText)
	f13_local0:registerEventHandler("open_cac", CoD.GameLobby.OpenCAC)
	f13_local0:registerEventHandler("open_rewards", CoD.GameLobby.OpenRewards)
	f13_local0:registerEventHandler("open_barracks", CoD.GameLobby.OpenBarracks)
	f13_local0:registerEventHandler("elite_cac_additional_validation", CoD.GameLobby.CacImportAdditionalValidation)
	f13_local0:registerEventHandler("elite_cac_import_popup_closed", CoD.GameLobby.CacImportPopupClosed)
	f13_local0.panelManager:processEvent({
		name = "fetching_done"
	})
	Engine.SystemNeedsUpdate(nil, "lobby")
	f13_local0:addElement(LUI.UITimer.new(250, "party_update_status", false))
	return f13_local0
end

