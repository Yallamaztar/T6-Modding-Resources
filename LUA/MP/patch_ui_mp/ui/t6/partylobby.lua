require("T6.Lobby")
require("T6.EdgeShadow")
require("T6.Menus.Playercard")
require("T6.Error")
require("T6.Menus.PlaylistSelectionPopup")
if CoD.isZombie == false then
	require("T6.CaCCopyClassNavOverlay")
	require("T6.CacNavOverlay")
	require("T6.Menus.CACImportPopup")
	require("T6.CACImportValidate")
end
CoD.PartyLobby = {}
CoD.PartyLobby.FindMatchEnabled = false
CoD.PartyLobby.Back = function (f1_arg0, f1_arg1)
	if Engine.IsLivestreamEnabled() then
		f1_arg0:registerEventHandler("livestream_update_state", CoD.PartyLobby.Back)
		f1_arg0:openPopup("LiveStream_Disable", f1_arg1.controller)
		return 
	elseif CoD.isPartyHost() then
		CoD.SwitchToMainLobby(f1_arg1.controller)
	else
		Engine.ExecNow(f1_arg1.controller, "leaveAllParties")
		Engine.PartyHostClearUIState()
		CoD.StartMainLobby(f1_arg1.controller)
	end
	f1_arg0:setPreviousMenu("MainLobby")
	f1_arg0:goBack(f1_arg1)
end

CoD.PartyLobby.BackAlone = function (f2_arg0, f2_arg1)
	if Engine.IsLivestreamEnabled() then
		f2_arg0:registerEventHandler("livestream_update_state", CoD.PartyLobby.BackAlone)
		f2_arg0:openPopup("LiveStream_Disable", f2_arg1.controller)
		return 
	elseif CoD.isPartyHost() then
		Engine.Exec(f2_arg1.controller, "xstopprivateparty")
		CoD.StartMainLobby(f2_arg1.controller)
	else
		Engine.ExecNow(f2_arg1.controller, "leaveAllParties")
		Engine.PartyHostClearUIState()
		CoD.StartMainLobby(f2_arg1.controller)
	end
	f2_arg0:setPreviousMenu("MainLobby")
	f2_arg0:goBack(f2_arg1)
end

CoD.PartyLobby.Button_Back = function (f3_arg0, f3_arg1)
	if CoD.Lobby.OpenSignOutPopup(f3_arg0, f3_arg1) == true then
		return 
	elseif UIExpression.AloneInPartyIgnoreSplitscreen(f3_arg1.controller, 1) == 0 then
		local f3_local0 = {
			params = {}
		}
		if CoD.isPartyHost() then
			f3_local0.titleText = Engine.Localize("MENU_LEAVE_LOBBY_TITLE")
			f3_local0.messageText = Engine.Localize("MENU_LEAVE_LOBBY_HOST_WARNING")
			table.insert(f3_local0.params, {
				leaveHandler = CoD.PartyLobby.BackAlone,
				leaveEvent = "confirm_leave_alone",
				leaveText = Engine.Localize("MPUI_LEAVE_WITHOUT_PARTY"),
				debugHelper = "You're the leader of a private party, choosing this will disband your party"
			})
			table.insert(f3_local0.params, {
				leaveHandler = CoD.PartyLobby.Back,
				leaveEvent = "confirm_leave_with",
				leaveText = Engine.Localize("MENU_BRING_PARTY"),
				debugHelper = "You're the leader of a private party, choosing this bring your party along"
			})
		else
			f3_local0.titleText = Engine.Localize("MENU_LEAVE_LOBBY_TITLE")
			f3_local0.messageText = Engine.Localize("MENU_LEAVE_LOBBY_CLIENT_WARNING")
			table.insert(f3_local0.params, {
				leaveHandler = CoD.PartyLobby.Back,
				leaveEvent = "confirm_leave",
				leaveText = Engine.Localize("MENU_LEAVE_LOBBY_AND_PARTY"),
				debugHelper = "You're a client of a private party, remove you from the party"
			})
		end
		CoD.Lobby.ConfirmLeave(f3_arg0, f3_arg1.controller, "confirm_leave", CoD.PartyLobby.Back, f3_local0)
	elseif Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) == true and CoD.isPartyHost() then
		local f3_local0 = {
			params = {},
			titleText = Engine.Localize("MENU_LEAVE_LOBBY_TITLE"),
			messageText = Engine.Localize("MENU_LEAVE_LOBBY_HOST_WARNING")
		}
		table.insert(f3_local0.params, {
			leaveHandler = CoD.PartyLobby.BackAlone,
			leaveEvent = "confirm_leave_alone",
			leaveText = Engine.Localize("MPUI_LEAVE_WITHOUT_PARTY"),
			debugHelper = "You're the leader of a private party, choosing this will disband your party"
		})
		table.insert(f3_local0.params, {
			leaveHandler = CoD.PartyLobby.Back,
			leaveEvent = "confirm_leave_with",
			leaveText = Engine.Localize("MENU_BRING_PARTY"),
			debugHelper = "You're the leader of a private party, choosing this bring your party along"
		})
		CoD.Lobby.ConfirmLeave(f3_arg0, f3_arg1.controller, "confirm_leave", CoD.PartyLobby.Back, f3_local0)
	else
		CoD.PartyLobby.Back(f3_arg0, f3_arg1)
	end
end

CoD.PartyLobby.GoToFindingGames = function (f4_arg0, f4_arg1)
	Engine.ProbationCheckForDashboardWarning(CoD.GAMEMODE_PUBLIC_MATCH)
	local f4_local0, f4_local1 = Engine.ProbationCheckInProbation(CoD.GAMEMODE_PUBLIC_MATCH)
	if f4_local0 == true then
		f4_arg0:openPopup("popup_public_inprobation", f4_local1)
		return 
	else
		local f4_local2, f4_local3 = Engine.ProbationCheckForProbation(CoD.GAMEMODE_PUBLIC_MATCH)
		f4_local1 = f4_local3
		if f4_local2 == true then
			f4_arg0:openPopup("popup_public_givenprobation", f4_local1)
			return 
		elseif Engine.ProbationCheckParty(CoD.GAMEMODE_PUBLIC_MATCH, f4_arg1.controller) == true then
			f4_arg0:openPopup("popup_public_partyprobation", f4_arg1.controller)
			return 
		else
			Engine.Exec(f4_arg1.controller, "xstartparty")
			Engine.Exec(f4_arg1.controller, "updategamerprofile")
			f4_arg0:openMenu("PublicGameLobby", f4_arg1.controller)
			f4_arg0:close()
		end
	end
end

CoD.PartyLobby.OpenPlaylistSelection = function (f5_arg0, f5_arg1)
	if UIExpression.IsGuest(f5_arg1.controller) == 1 then
		local f5_local0 = f5_arg0:openPopup("Error", controller)
		f5_local0:setMessage(Engine.Localize("XBOXLIVE_NOGUESTACCOUNTS"))
		f5_local0.anyControllerAllowed = true
		return 
	else
		Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_SELECTING_PLAYLIST)
		local f5_local0 = f5_arg0:openPopup("PlaylistSelection", f5_arg1.controller)
		f5_local0:addCategoryButtons(f5_arg1.controller)
		Engine.PlaySound("cac_screen_fade")
	end
end

CoD.PartyLobby.SetPlaylistFilter = function (f6_arg0, f6_arg1)
	CoD.PlaylistCategoryFilter = f6_arg1
end

CoD.PartyLobby.Button_CAC = function (f7_arg0, f7_arg1)
	f7_arg0:dispatchEventToParent({
		name = "open_cac",
		controller = f7_arg1.controller,
		isLocked = CoD.CheckButtonLock(f7_arg0, f7_arg1.controller)
	})
end

CoD.PartyLobby.OpenCAC = function (f8_arg0, f8_arg1)
	if f8_arg1.isLocked == true then
		Engine.PlaySound(CoD.CACUtility.denySFX)
		local f8_local0 = f8_arg0:openPopup("Error", f8_arg1.controller)
		f8_local0:setMessage(Engine.Localize(CoD.GetUnlockLevelString(f8_arg1.controller, "FEATURE_CREATE_A_CLASS")))
	elseif Engine.ECACImport_ShouldShow(f8_arg1.controller) == 1 then
		f8_arg0:openPopup("CACImportPopup", f8_arg1.controller)
	else
		Engine.PlaySound("cac_enter_cac")
		Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_MODIFYING_CAC)
		f8_arg0:openPopup("CACChooseClass", f8_arg1.controller)
	end
end

CoD.PartyLobby.CacImportAdditionalValidation = function (f9_arg0, f9_arg1)
	Engine.ECACImport_ValidateDecision(f9_arg1.controller, CoD.CACImportValidate.validate(f9_arg0, f9_arg1))
end

CoD.PartyLobby.CacImportPopupClosed = function (f10_arg0, f10_arg1)
	f10_arg0:processEvent({
		name = "open_cac",
		controller = f10_arg1.controller,
		isLocked = false
	})
end

CoD.PartyLobby.Button_Rewards = function (f11_arg0, f11_arg1)
	f11_arg0:dispatchEventToParent({
		name = "open_rewards",
		controller = f11_arg1.controller,
		isLocked = CoD.CheckButtonLock(f11_arg0, f11_arg1.controller)
	})
end

CoD.PartyLobby.OpenRewards = function (f12_arg0, f12_arg1)
	if f12_arg1.isLocked == true then
		Engine.PlaySound(CoD.CACUtility.denySFX)
		local f12_local0 = f12_arg0:openPopup("Error", f12_arg1.controller)
		f12_local0:setMessage(Engine.Localize(CoD.GetUnlockLevelString(f12_arg1.controller, "FEATURE_KILLSTREAKS")))
	else
		Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_MODIFYING_REWARDS)
		f12_arg0:openPopup("Rewards", f12_arg1.controller)
		Engine.PlaySound("cac_screen_fade")
	end
end

CoD.PartyLobby.OpenBarracks = function (f13_arg0, f13_arg1)
	if UIExpression.IsGuest(f13_arg1.controller) == 1 then
		f13_arg0:openPopup("popup_guest_contentrestricted", f13_arg1.controller)
		return 
	else
		Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_VIEWING_PLAYERCARD)
		f13_arg0:openPopup("Barracks", f13_arg1.controller)
	end
end

CoD.PartyLobby.OpenCoDTV = function (f14_arg0, f14_arg1)
	if Engine.CanViewContent() == false then
		f14_arg0:openPopup("popup_contentrestricted", f14_arg1.controller)
		return 
	elseif Engine.IsLivestreamEnabled() then
		f14_arg0:openPopup("CODTv_Error", f14_arg1.controller)
		return 
	elseif CoD.MainLobby.OnlinePlayAvailable(f14_arg0, f14_arg1) == 1 and Engine.IsCodtvContentLoaded() == true then
		Engine.PartyHostSetUIState(CoD.PARTYHOST_STATE_VIEWING_COD_TV)
		CoD.perController[f14_arg1.controller].codtvRoot = "community"
		f14_arg0:openPopup("CODTv", f14_arg1.controller, "community")
	end
end

CoD.PartyLobby.UpdateButtonPaneButtonVisibility = function (f15_arg0)
	if f15_arg0 == nil or f15_arg0.body == nil then
		return 
	elseif CoD.isPartyHost() then
		f15_arg0.body.buttonList:addElement(f15_arg0.body.findMatchButton)
	else
		f15_arg0.body.findMatchButton:close()
		if f15_arg0.body.findMatchButton:isInFocus() == true then
			f15_arg0.body.buttonList:processEvent({
				name = "gain_focus"
			})
		end
	end
	if f15_arg0.body.findMatchButton ~= nil and CoD.PartyLobby.FindMatchEnabled == true then
		f15_arg0.body.findMatchButton:enable()
	end
	if f15_arg0.body.createAClassButton ~= nil then
		CoD.SetupButtonLock(f15_arg0.body.createAClassButton, nil, "FEATURE_CREATE_A_CLASS", "FEATURE_CREATE_A_CLASS_DESC", CoD.PartyLobby.Button_CAC)
	end
	if f15_arg0.body.rewardsButton ~= nil then
		CoD.SetupButtonLock(f15_arg0.body.rewardsButton, nil, "FEATURE_KILLSTREAKS", "FEATURE_KILLSTREAKS_DESC", CoD.PartyLobby.Button_Rewards)
	end
	CoD.PartyLobby.UpdateDLCWarning(f15_arg0)
end

CoD.PartyLobby.UpdateButtonPromptVisibility = function (f16_arg0)
	if f16_arg0 == nil then
		return 
	elseif f16_arg0.partyPrivacyButton ~= nil and CoD.isPartyHost() == false then
		f16_arg0.partyPrivacyButton:close()
	end
	if f16_arg0.partyPrivacyButton ~= nil then
		f16_arg0:updatePartyPrivacyButton()
	end
end

CoD.PartyLobby.PopulateButtons = function (f17_arg0)
	f17_arg0.body.findMatchButton = f17_arg0.body.buttonList:addButton(Engine.Localize("MPUI_FIND_MATCH_CAPS"), nil, 1)
	f17_arg0.body.findMatchButton.hintText = Engine.Localize("MPUI_FIND_MATCH_DESC")
	f17_arg0.body.findMatchButton:setActionEventName("open_playlist_selection")
	if CoD.PartyLobby.FindMatchEnabled == false then
		f17_arg0.body.findMatchButton:disable()
	end
	if CoD.isZombie == true then
		CoD.PartyLobby.PopulateButtons_Zombies(f17_arg0)
	else
		CoD.PartyLobby.PopulateButtons_Multiplayer(f17_arg0)
	end
	CoD.PartyLobby.AddDLCWarning(f17_arg0)
end

CoD.PartyLobby.AddDLCWarning = function (f18_arg0)
	f18_arg0.body.dlcWarningContainer = LUI.UIElement.new()
	f18_arg0.body.dlcWarningContainer:setLeftRight(true, true, 0, 0)
	f18_arg0.body.dlcWarningContainer:setTopBottom(true, true, CoD.CoD9Button.Height * 12, 0)
	f18_arg0.body.dlcWarningContainer:setAlpha(0)
	f18_arg0.body:addElement(f18_arg0.body.dlcWarningContainer)
	local f18_local0 = 24
	local f18_local1 = 5
	f18_arg0.body.dlcWarningContainer.warningIcon = LUI.UIImage.new()
	f18_arg0.body.dlcWarningContainer.warningIcon:setLeftRight(true, false, 0, f18_local0)
	f18_arg0.body.dlcWarningContainer.warningIcon:setTopBottom(true, false, 0, f18_local0)
	f18_arg0.body.dlcWarningContainer.warningIcon:setImage(RegisterMaterial("cac_restricted"))
	f18_arg0.body.dlcWarningContainer:addElement(f18_arg0.body.dlcWarningContainer.warningIcon)
	local f18_local2 = "Default"
	local f18_local3 = CoD.fonts[f18_local2]
	local f18_local4 = CoD.textSize[f18_local2]
	local f18_local5 = 30
	f18_arg0.body.dlcWarningContainer.warningLabel = LUI.UIText.new()
	f18_arg0.body.dlcWarningContainer.warningLabel:setLeftRight(true, true, f18_local0 + f18_local1, -f18_local5)
	f18_arg0.body.dlcWarningContainer.warningLabel:setTopBottom(true, false, 0, f18_local4)
	f18_arg0.body.dlcWarningContainer.warningLabel:setFont(f18_local3)
	f18_arg0.body.dlcWarningContainer.warningLabel:setRGB(CoD.red.r, CoD.red.g, CoD.red.b)
	f18_arg0.body.dlcWarningContainer.warningLabel:setAlignment(LUI.Alignment.Left)
	f18_arg0.body.dlcWarningContainer:addElement(f18_arg0.body.dlcWarningContainer.warningLabel)
	CoD.PartyLobby.UpdateDLCWarning(f18_arg0)
end

CoD.PartyLobby.UpdateDLCWarning = function (f19_arg0)
	if f19_arg0.body.dlcWarningContainer ~= nil then
		local f19_local0 = Engine.WhoIsMissingMapPacks()
		local f19_local1 = Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH)
		local f19_local2 = ""
		if f19_local0 and Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false then
			f19_arg0.body.dlcWarningContainer:setAlpha(1)
			if f19_local0 == "me" then
				if f19_local1 then
					f19_local2 = Engine.Localize("MPUI_DLC_WARNING_YOU_SHORT")
				else
					f19_local2 = Engine.Localize("MPUI_DLC_WARNING_YOU")
				end
			elseif f19_local0 == "partymember" then
				if f19_local1 then
					f19_local2 = Engine.Localize("MPUI_DLC_WARNING_OTHER_PLAYERS_SHORT")
				else
					f19_local2 = Engine.Localize("MPUI_DLC_WARNING_OTHER_PLAYERS")
				end
			end
		else
			f19_arg0.body.dlcWarningContainer:setAlpha(0)
		end
		f19_arg0.body.dlcWarningContainer.warningLabel:setText(f19_local2)
	end
end

CoD.PartyLobby.PopulateButtons_Multiplayer = function (f20_arg0)
	f20_arg0.body.createAClassButton = f20_arg0.body.buttonList:addButton(Engine.Localize("MENU_CREATE_A_CLASS_CAPS"), nil, 2)
	CoD.CACUtility.SetupCACLock(f20_arg0.body.createAClassButton)
	CoD.CACUtility.SetupCACNew(f20_arg0.body.createAClassButton)
	f20_arg0.body.createAClassButton:registerEventHandler("button_action", CoD.PartyLobby.Button_CAC)
	f20_arg0.body.rewardsButton = f20_arg0.body.buttonList:addButton(Engine.Localize("MENU_SCORE_STREAKS_CAPS"), nil, 3)
	CoD.SetupButtonLock(f20_arg0.body.rewardsButton, nil, "FEATURE_KILLSTREAKS", "FEATURE_KILLSTREAKS_DESC")
	CoD.CACUtility.SetupScorestreaksNew(f20_arg0.body.rewardsButton)
	f20_arg0.body.rewardsButton:registerEventHandler("button_action", CoD.PartyLobby.Button_Rewards)
	f20_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2, 4)
	if not Engine.IsBetaBuild() then
		f20_arg0.body.barracksButton = f20_arg0.body.buttonList:addButton(Engine.Localize("MENU_BARRACKS_CAPS"), nil, 5)
		f20_arg0.body.barracksButton:setActionEventName("open_barracks")
		CoD.SetupBarracksLock(f20_arg0.body.barracksButton)
		CoD.SetupBarracksNew(f20_arg0.body.barracksButton)
		f20_arg0.body.codtvButton = f20_arg0.body.buttonList:addButton(Engine.Localize("MENU_COD_TV_CAPS"), nil, 6)
		f20_arg0.body.codtvButton:setActionEventName("open_cod_tv_party")
		f20_arg0.body.codtvButton.hintText = Engine.Localize("MPUI_COD_TV_DESC")
	end
	if UIExpression.DvarBool(nil, "webm_encUiEnabledPublic") == 1 then
		CoD.Lobby.AddLivestreamButton(f20_arg0, 10)
	end
end

CoD.PartyLobby.PopulateButtons_Zombies = function (f21_arg0)
	f21_arg0.body.barracksButton = f21_arg0.body.buttonList:addButton(Engine.Localize(CoD.MPZM("MENU_BARRACKS_CAPS", "MPUI_LEADERBOARDS_CAPS")), nil, 2)
	f21_arg0.body.barracksButton:setActionEventName("open_barracks")
	CoD.SetupBarracksLock(f21_arg0.body.barracksButton)
	Engine.SetDvar("party_readyPercentRequired", 0)
end

CoD.PartyLobby.Update = function (f22_arg0, f22_arg1)
	if f22_arg0 == nil then
		return 
	elseif UIExpression.PrivatePartyHost() == 1 and not Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) and not Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH) then
		Engine.Exec(f22_arg1.controller, "getLatestWAD")
	end
	if f22_arg1 ~= nil and f22_arg1.actualPartyMemberCount ~= nil then
		if f22_arg1.actualPartyMemberCount > 0 then
			CoD.PartyLobby.FindMatchEnabled = true
		else
			CoD.PartyLobby.FindMatchEnabled = false
		end
	end
	CoD.PartyLobby.UpdateButtonPaneButtonVisibility(f22_arg0.buttonPane)
	CoD.PartyLobby.UpdateButtonPromptVisibility(f22_arg0)
	f22_arg0:dispatchEventToChildren(f22_arg1)
end

CoD.PartyLobby.UpdateButtonPane = function (f23_arg0, f23_arg1)
	CoD.PartyLobby.UpdateButtonPaneButtonVisibility(f23_arg0.buttonPane)
	CoD.PartyLobby.UpdateButtonPromptVisibility(f23_arg0)
end

CoD.PartyLobby.AddLobbyPaneElements = function (f24_arg0)
	CoD.LobbyPanes.addLobbyPaneElements(f24_arg0, nil, UIExpression.DvarInt(controller, "party_maxlocalplayers_playermatch"))
end

CoD.PartyLobby.ButtonListButtonGainFocus = function (f25_arg0, f25_arg1)
	f25_arg0:dispatchEventToParent({
		name = "add_party_privacy_button"
	})
	CoD.Lobby.ButtonListButtonGainFocus(f25_arg0, f25_arg1)
end

CoD.PartyLobby.ButtonListAddButton = function (f26_arg0, f26_arg1, f26_arg2, f26_arg3)
	local f26_local0 = CoD.Lobby.ButtonListAddButton(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
	f26_local0:registerEventHandler("gain_focus", CoD.PartyLobby.ButtonListButtonGainFocus)
	return f26_local0
end

CoD.PartyLobby.AddButtonPaneElements = function (f27_arg0)
	CoD.LobbyPanes.addButtonPaneElements(f27_arg0)
	f27_arg0.body.buttonList.addButton = CoD.PartyLobby.ButtonListAddButton
end

CoD.PartyLobby.PopulateButtonPaneElements = function (f28_arg0)
	CoD.PartyLobby.PopulateButtons(f28_arg0)
	CoD.PartyLobby.UpdateButtonPaneButtonVisibility(f28_arg0)
end

CoD.PartyLobby.new = function (f29_arg0, f29_arg1, f29_arg2)
	local f29_local0 = CoD.Lobby.New(f29_arg1, f29_arg0, nil, f29_arg2, Engine.Localize("MENU_PARTY_CAPS"), true)
	f29_local0.addButtonPaneElements = CoD.PartyLobby.AddButtonPaneElements
	f29_local0.populateButtonPaneElements = CoD.PartyLobby.PopulateButtonPaneElements
	f29_local0.addLobbyPaneElements = CoD.PartyLobby.AddLobbyPaneElements
	f29_local0.setPlaylistFilter = CoD.PartyLobby.SetPlaylistFilter
	f29_local0:setPlaylistFilter("")
	f29_local0:updatePanelFunctions()
	f29_local0:registerEventHandler("partylobby_update", CoD.PartyLobby.Update)
	f29_local0:registerEventHandler("playlist_selected", CoD.PartyLobby.GoToFindingGames)
	f29_local0:registerEventHandler("button_prompt_back", CoD.PartyLobby.Button_Back)
	f29_local0:registerEventHandler("open_playlist_selection", CoD.PartyLobby.OpenPlaylistSelection)
	f29_local0:registerEventHandler("open_cac", CoD.PartyLobby.OpenCAC)
	f29_local0:registerEventHandler("open_rewards", CoD.PartyLobby.OpenRewards)
	f29_local0:registerEventHandler("open_barracks", CoD.PartyLobby.OpenBarracks)
	f29_local0:registerEventHandler("open_cod_tv_party", CoD.PartyLobby.OpenCoDTV)
	f29_local0:registerEventHandler("restartMatchmaking", CoD.PartyLobby.GoToFindingGames)
	f29_local0:registerEventHandler("update_button_pane", CoD.PartyLobby.UpdateButtonPane)
	f29_local0:registerEventHandler("elite_cac_additional_validation", CoD.PartyLobby.CacImportAdditionalValidation)
	f29_local0:registerEventHandler("elite_cac_import_popup_closed", CoD.PartyLobby.CacImportPopupClosed)
	CoD.PartyLobby.PopulateButtons(f29_local0.buttonPane)
	CoD.PartyLobby.UpdateButtonPaneButtonVisibility(f29_local0.buttonPane)
	CoD.PartyLobby.UpdateButtonPromptVisibility(f29_local0)
	if CoD.useController then
		if CoD.isPartyHost() then
			f29_local0.buttonPane.body.findMatchButton:processEvent({
				name = "gain_focus"
			})
		elseif CoD.isZombie == true then
			f29_local0.buttonPane.body.barracksButton:processEvent({
				name = "gain_focus"
			})
		else
			f29_local0.buttonPane.body.createAClassButton:processEvent({
				name = "gain_focus"
			})
		end
	end
	Engine.PartyHostClearUIState()
	f29_local0.panelManager:processEvent({
		name = "fetching_done"
	})
	Engine.SystemNeedsUpdate(nil, "party")
	Engine.SystemNeedsUpdate(nil, "game_options")
	return f29_local0
end

