CoD.Popup = {}
CoD.Popup.CONNECTINGDW_MAX_WAIT_TIME = 30000
if CoD.isPS3 then
	CoD.Popup.CONNECTINGDW_MAX_WAIT_TIME = 40000
end
if CoD.isPC then
	CoD.Popup.CONNECTINGDW_MAX_WAIT_TIME = 65000
end
CoD.Popup.Type = {}
CoD.Popup.Type.REGULAR = 1
CoD.Popup.Type.WIDE = 2
CoD.Popup.Type.STRETCHED = 3
CoD.Popup.StretchedWidth = CoD.Menu.SmallPopupWidth
CoD.Popup.StretchedHeight = CoD.Menu.SmallPopupHeight
if CoD.isZombie == true then
	CoD.Popup.StretchedWidth = CoD.Menu.SmallPopupWidth
	CoD.Popup.StretchedHeight = 300
end
LUI.createMenu.popup_busy = function (f1_arg0)
	return CoD.Popup.SetupPopupBusy("popup_busy", f1_arg0)
end

LUI.createMenu.popup_joinsession = function (f2_arg0)
	local f2_local0 = CoD.Popup.SetupPopupBusy("popup_joinsession", f2_arg0)
	f2_local0.title:setText(Engine.Localize("MENU_JOINING_SESSION_IN_PROGRESS"))
	return f2_local0
end

LUI.createMenu.popup_reconnectingtoparty = function (f3_arg0)
	local f3_local0 = CoD.Popup.SetupPopupBusy("popup_reconnectingtoparty", f3_arg0)
	f3_local0:registerEventHandler("menu_changed", CoD.Menu.MenuChanged)
	f3_local0.title:setText(Engine.Localize("MENU_RECONNECTING_TO_PARTY_CAPS"))
	return f3_local0
end

LUI.createMenu.popup_gettingdata = function (f4_arg0)
	local f4_local0 = CoD.Popup.SetupPopupBusy("popup_gettingdata", f4_arg0)
	f4_local0.title:setText(Engine.Localize("MENU_DOWNLOADING_GAME_SETTINGS_CAPS"))
	return f4_local0
end

LUI.createMenu.popup_gettingUCDdata = function (f5_arg0)
	local f5_local0 = CoD.Popup.SetupPopupBusy("popup_gettingUCDdata", f5_arg0)
	f5_local0.title:setText(Engine.Localize("MPUI_GETTING_UCD_DATA"))
	return f5_local0
end

LUI.createMenu.popup_profilelookup = function (f6_arg0)
	local f6_local0 = CoD.Popup.SetupPopupBusy("popup_profilelookup", f6_arg0)
	f6_local0.title:setText(Engine.Localize("PLATFORM_PROFILE_LOOKUP"))
	return f6_local0
end

LUI.createMenu.popup_contentrestricted = function (f7_arg0)
	local f7_local0 = CoD.Popup.SetupPopup("popup_contentrestricted", f7_arg0)
	f7_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f7_local0.msg:setText(Engine.Localize("PLATFORM_FILESHARE_ACCESSERROR_MSG"))
	f7_local0:addBackButton()
	return f7_local0
end

LUI.createMenu.popup_guest_contentrestricted = function (f8_arg0)
	local f8_local0 = CoD.Popup.SetupPopup("popup_contentrestricted", f8_arg0)
	f8_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f8_local0.msg:setText(Engine.Localize("MENU_GUEST_CONTENT_RESTRICTED"))
	f8_local0:addBackButton()
	return f8_local0
end

LUI.createMenu.popup_chatrestricted = function (f9_arg0)
	local f9_local0 = CoD.Popup.SetupPopup("popup_chatrestricted", f9_arg0)
	f9_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f9_local0.msg:setText(Engine.Localize("PLATFORM_CHAT_DISABLED"))
	f9_local0.anyControllerAllowed = true
	f9_local0.primaryButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_OK"), f9_local0, "restriction_accepted")
	f9_local0:addLeftButtonPrompt(f9_local0.primaryButton)
	f9_local0:addBackButton()
	f9_local0:registerEventHandler("restriction_accepted", CoD.Popup.ChatRestrictionAccepted)
	return f9_local0
end

CoD.Popup.ChatRestrictionAccepted = function (f10_arg0, f10_arg1)
	f10_arg0:goBack(f10_arg1.controller)
	if f10_arg0.callingMenu ~= nil then
		CoD.MainMenu.OpenMainLobby(f10_arg0.callingMenu, f10_arg1)
	end
end

LUI.createMenu.popup_chatrestrictedinvite = function (f11_arg0)
	local f11_local0 = CoD.Popup.SetupPopup("popup_chatrestrictedinvite", f11_arg0)
	f11_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f11_local0.msg:setText(Engine.Localize("PLATFORM_CHAT_DISABLED"))
	f11_local0.anyControllerAllowed = true
	f11_local0:addBackButton()
	return f11_local0
end

LUI.createMenu.popup_render_complete = function (f12_arg0, f12_arg1)
	local f12_local0 = CoD.Popup.SetupPopup("popup_render_complete", f12_arg0)
	f12_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	if f12_arg1.success == true then
		f12_local0.msg:setText(Engine.Localize("MENU_RENDER_SUCCESS", Dvar.fshRenderSuccessURL:get()))
	else
		f12_local0.msg:setText(Engine.Localize("MENU_RENDER_FAILED"))
	end
	f12_local0.anyControllerAllowed = true
	f12_local0.primaryButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_OK"), f12_local0, "render_complete_accepted")
	f12_local0:addLeftButtonPrompt(f12_local0.primaryButton)
	f12_local0:registerEventHandler("render_complete_accepted", CoD.Popup.RenderCompleteAccepted)
	return f12_local0
end

CoD.Popup.RenderCompleteAccepted = function (f13_arg0, f13_arg1)
	f13_arg0:goBack(f13_arg1.controller)
end

LUI.createMenu.popup_bookmarked = function (f14_arg0)
	local f14_local0 = CoD.Popup.SetupPopup("popup_bookmarked", f14_arg0)
	f14_local0.title:setText(Engine.Localize("MENU_BOOKMARKED_HEADER"))
	f14_local0.msg:setText(Engine.Localize("MENU_BOOKMARKED_MESSAGE"))
	f14_local0.anyControllerAllowed = true
	f14_local0.primaryButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_OK"), f14_local0, "bookmark_accepted")
	f14_local0:addLeftButtonPrompt(f14_local0.primaryButton)
	f14_local0:registerEventHandler("bookmark_accepted", CoD.Popup.BookmarkAccepted)
	return f14_local0
end

CoD.Popup.BookmarkAccepted = function (f15_arg0, f15_arg1)
	f15_arg0:goBack(f15_arg1.controller)
end

LUI.createMenu.popup_xboxlive_lobbyended = function (f16_arg0)
	local f16_local0 = CoD.Popup.SetupPopup("popup_xboxlive_lobbyended", f16_arg0)
	f16_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f16_local0.msg:setText(Engine.Localize("XBOXLIVE_LOBBYENDED"))
	f16_local0:addBackButton()
	return f16_local0
end

LUI.createMenu.popup_xboxlive_partyended = function (f17_arg0)
	local f17_local0 = CoD.Popup.SetupPopup("popup_xboxlive_partyended", f17_arg0)
	f17_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f17_local0.msg:setText(Engine.Localize(UIExpression.DvarString(nil, "partyend_reason")))
	f17_local0:addBackButton()
	return f17_local0
end

LUI.createMenu.popup_net_connection = function (f18_arg0)
	local f18_local0 = CoD.Popup.SetupPopup("popup_net_connection", f18_arg0)
	f18_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f18_local0.msg:setText(Engine.Localize("XBOXLIVE_NETCONNECTION"))
	f18_local0:addBackButton()
	f18_local0.anyControllerAllowed = true
	return f18_local0
end

LUI.createMenu.popup_fetchstats = function (f19_arg0)
	local f19_local0 = CoD.Popup.SetupPopupBusy("popup_fetchstats", f19_arg0)
	f19_local0.title:setText(Engine.Localize("MENU_FETCH_STATS"))
	f19_local0.anyControllerAllowed = true
	return f19_local0
end

LUI.createMenu.popup_fetchstats_failed = function (f20_arg0)
	local f20_local0 = CoD.Popup.SetupPopup("popup_fetchstats_failed", f20_arg0)
	f20_local0.title:setText(Engine.Localize("MENU_FETCH_STATS_FAILED_TITLE"))
	f20_local0.msg:setText(Engine.Localize("MENU_FETCH_STATS_FAILED"))
	f20_local0:addBackButton()
	f20_local0.anyControllerAllowed = true
	return f20_local0
end

LUI.createMenu.popup_downloading = function (f21_arg0)
	local f21_local0 = CoD.Popup.SetupPopupBusy("popup_downloading", f21_arg0)
	f21_local0.title:setText(Engine.Localize("MENU_DOWNLOADING"))
	f21_local0.anyControllerAllowed = true
	return f21_local0
end

LUI.createMenu.popup_downloading_failed = function (f22_arg0)
	local f22_local0 = CoD.Popup.SetupPopup("popup_downloading_failed", f22_arg0)
	f22_local0:addBackButton()
	f22_local0.title:setText(Engine.Localize("MENU_DOWNLOADING_FAILED"))
	f22_local0.anyControllerAllowed = true
	return f22_local0
end

LUI.createMenu.popup_cacimportfailed = function (f23_arg0)
	local f23_local0 = CoD.Popup.SetupPopup("popup_cacimportfailed", f23_arg0)
	f23_local0.title:setText(Engine.Localize("MENU_CAC_IMPORT"))
	f23_local0.msg:setText(Engine.Localize("MENU_CAC_IMPORT_FAILURE"))
	f23_local0:addBackButton()
	return f23_local0
end

LUI.createMenu.popup_acceptinvite_warning = function (f24_arg0)
	local f24_local0 = CoD.Popup.SetupPopupChoice("popup_acceptinvite_warning", f24_arg0)
	f24_local0.title:setText(Engine.Localize("MENU_ACCEPTINVITETITLE"))
	local f24_local1 = UIExpression.PrivatePartyHost()
	local f24_local2 = UIExpression.AloneInPartyIgnoreSplitscreen(f24_arg0, 1)
	local f24_local3 = UIExpression.InLobby()
	if UIExpression.PrivatePartyHost() == 1 and UIExpression.AloneInPartyIgnoreSplitscreen(f24_arg0, 1) == 0 then
		f24_local0.msg:setText(Engine.Localize("MENU_LEAVEMPGAMEWARNINGSQUADHOST"))
	elseif UIExpression.PrivatePartyHost() == 0 and UIExpression.InLobby() == 0 then
		f24_local0.msg:setText(Engine.Localize("MENU_LEAVESQUADWARNING"))
	elseif UIExpression.PrivatePartyHost() == 0 and UIExpression.InLobby() == 1 then
		f24_local0.msg:setText(Engine.Localize("MENU_LEAVEMPGAMEWARNING"))
	end
	f24_local0.choiceA:setLabel(Engine.Localize("MENU_RESUMEGAME"))
	f24_local0.choiceB:setLabel(Engine.Localize("MENU_ACCEPTINVITE"))
	f24_local0.choiceB:setActionEventName("acceptinvite")
	f24_local0.choiceB:processEvent({
		name = "gain_focus"
	})
	f24_local0:registerEventHandler("acceptinvite", CoD.Popup.AcceptInvite)
	return f24_local0
end

CoD.Popup.AcceptInvite = function (f25_arg0, f25_arg1)
	Engine.Exec(f25_arg1.controller, "acceptinvite")
	f25_arg0:goBack(f25_arg1.controller)
end

LUI.createMenu.popup_connectingdw_ps3 = function (f26_arg0)
	local f26_local0 = CoD.Popup.SetupPopupBusy("popup_connectingdw_ps3", f26_arg0)
	f26_local0.anyControllerAllowed = true
	f26_local0.title:setText(Engine.Localize("MENU_CONNECTING_DW"))
	return f26_local0
end

LUI.createMenu.popup_connectingdw = function (f27_arg0)
	local f27_local0 = CoD.Popup.SetupPopupBusy("popup_connectingdw", f27_arg0)
	f27_local0.anyControllerAllowed = true
	f27_local0.title:setText(Engine.Localize("MENU_CONNECTING_DW"))
	f27_local0:registerEventHandler("is_demonware_fetching_done", CoD.Popup.IsDemonwareFetchingDone)
	f27_local0:addBackButton()
	if CoD.isPC then
		f27_local0.msg:setText(Engine.Localize("PLATFORM_GETTING_STEAM_TICKET"))
		f27_local0.msg:hide()
	end
	local f27_local1 = LUI.UITimer.new(400, "is_demonware_fetching_done", false)
	f27_local1.controller = f27_arg0
	f27_local1.timeElapsedSinceStart = 0
	f27_local0:addElement(f27_local1)
	return f27_local0
end

CoD.Popup.IsDemonwareFetchingDone = function (f28_arg0, f28_arg1)
	if UIExpression.IsDemonwareFetchingDone(f28_arg1.timer.controller) == 1 then
		if CoD.isWIIU then
			if Engine.IsSignedInToDemonware(f28_arg1.timer.controller) == true then
				f28_arg0:goBack(f28_arg1.timer.controller)
				f28_arg0.occludedMenu:processEvent({
					name = "open_main_lobby_requested",
					controller = f28_arg1.timer.controller
				})
			end
			Engine.Exec(f28_arg1.timer.controller, "loginpopupclosed")
		else
			Engine.Exec(f28_arg1.timer.controller, "checkForPS3Invites")
			f28_arg0:goBack(f28_arg1.timer.controller)
			if f28_arg0.callingMenu ~= nil then
				f28_arg1.controller = f28_arg1.timer.controller
				if f28_arg0.inviteAccepted == nil then
					CoD.MainMenu.OpenMainLobbyRequested(f28_arg0.callingMenu, f28_arg1)
				end
			elseif f28_arg0.occludedMenu ~= nil then
				f28_arg1.controller = f28_arg1.timer.controller
				if f28_arg0.inviteAccepted == nil then
					CoD.MainMenu.OpenMainLobbyRequested(f28_arg0.occludedMenu, f28_arg1)
				end
			end
		end
	end
	local f28_local0 = true
	if CoD.isPS3 then
		f28_local0 = Engine.CheckNetConnection()
	end
	if f28_arg1.timer.timeElapsedSinceStart > CoD.Popup.CONNECTINGDW_MAX_WAIT_TIME or f28_local0 == false then
		f28_arg0:goBack(f28_arg1.timer.controller)
		Dvar.ui_errorTitle:set("@MENU_NOTICE_CAPS")
		if f28_local0 == false then
			Dvar.ui_errorMessage:set("@XBOXLIVE_NETCONNECTION")
		else
			Dvar.ui_errorMessage:set("@PLATFORM_DEMONWARE_DISCONNECT")
		end
		f28_arg0.occludedMenu:processEvent({
			name = "open_error_popup",
			controller = f28_arg1.timer.controller
		})
		if CoD.isWIIU then
			Engine.Exec(f28_arg1.timer.controller, "loginpopupclosed")
		end
	end
	if CoD.isPC then
		if Engine.WaitingForSteamTicket() then
			f28_arg0.msg:beginAnimation("fade_in", 250)
			f28_arg0.msg:show()
		else
			f28_arg0.msg:beginAnimation("fade_out", 250)
			f28_arg0.msg:hide()
		end
	end
	f28_arg1.timer.timeElapsedSinceStart = f28_arg1.timer.timeElapsedSinceStart + f28_arg1.timeElapsed
end

LUI.createMenu.popup_controllerremoved = function (f29_arg0)
	local f29_local0 = CoD.Popup.SetupPopup("popup_controllerremoved", f29_arg0)
	f29_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f29_local0.msg:setText(Engine.Localize("PLATFORM_CONTROLLER_DISCONNECTED") .. UIExpression.DvarString(nil, "disconnected_ctrls"))
	f29_local0:addBackButton()
	f29_local0.anyControllerAllowed = true
	f29_local0.m_ownerController = nil
	return f29_local0
end

LUI.createMenu.popup_public_inprobation = function (f30_arg0)
	local f30_local0 = CoD.Popup.SetupProbationPopup("popup_public_inprobation", f30_arg0, CoD.GAMEMODE_PUBLIC_MATCH)
	f30_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f30_local0.msg:setText(Engine.Localize("MENU_PROBATION_IN_PUBLIC_MATCH"))
	f30_local0:addBackButton()
	return f30_local0
end

LUI.createMenu.popup_public_givenprobation = function (f31_arg0)
	local f31_local0 = CoD.Popup.SetupProbationPopup("popup_public_partyprobation", f31_arg0, CoD.GAMEMODE_PUBLIC_MATCH)
	f31_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f31_local0.msg:setText(Engine.Localize("MENU_PROBATION_GIVEN_PUBLIC_MATCH"))
	f31_local0:addBackButton()
	return f31_local0
end

LUI.createMenu.popup_public_partyprobation = function (f32_arg0)
	local f32_local0 = CoD.Popup.SetupPartyProbationPopup("popup_public_givenprobation", f32_arg0, CoD.GAMEMODE_PUBLIC_MATCH)
	f32_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f32_local0.msg:setText(Engine.Localize("MENU_PROBATION_PARTY_PUBLIC_MATCH"))
	f32_local0:addBackButton()
	return f32_local0
end

LUI.createMenu.popup_league_inprobation = function (f33_arg0)
	local f33_local0 = CoD.Popup.SetupProbationPopup("popup_league_inprobation", f33_arg0, CoD.GAMEMODE_LEAGUE_MATCH)
	f33_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f33_local0.msg:setText(Engine.Localize("MENU_PROBATION_IN_LEAGUE_MATCH"))
	f33_local0:addBackButton()
	return f33_local0
end

LUI.createMenu.popup_league_givenprobation = function (f34_arg0)
	local f34_local0 = CoD.Popup.SetupProbationPopup("popup_league_givenprobation", f34_arg0, CoD.GAMEMODE_LEAGUE_MATCH)
	f34_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f34_local0.msg:setText(Engine.Localize("MENU_PROBATION_GIVEN_LEAGUE_MATCH"))
	f34_local0:addBackButton()
	return f34_local0
end

LUI.createMenu.popup_league_partyprobation = function (f35_arg0)
	local f35_local0 = CoD.Popup.SetupPartyProbationPopup("popup_league_partyprobation", f35_arg0, CoD.GAMEMODE_LEAGUE_MATCH)
	f35_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f35_local0.msg:setText(Engine.Localize("MENU_PROBATION_PARTY_LEAGUE_MATCH"))
	f35_local0:addBackButton()
	return f35_local0
end

local f0_local0 = function (f36_arg0, f36_arg1)
	Engine.DevOnlyClearProbation(f36_arg1.controller)
	f36_arg0:goBack(f36_arg1.controller)
end

local f0_local1 = function (f37_arg0, f37_arg1)
	f37_arg0:goBack(f37_arg1.controller)
end

LUI.createMenu.popup_dev_clearprobation = function (f38_arg0)
	local f38_local0 = CoD.Popup.SetupPopup("popup_league_givenprobation", f38_arg0)
	f38_local0.anyControllerAllowed = true
	f38_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f38_local0.msg:setText("DEV ONLY:  You have just been given probation.  Would you like to clear it?")
	f38_local0:addSelectButton()
	f38_local0:addBackButton()
	f38_local0.backButtonPrompt = CoD.ButtonPrompt.new("select", "", f38_local0, "button_prompt_back", true)
	f38_local0.startButtonPrompt = CoD.ButtonPrompt.new("start", "", f38_local0, "button_prompt_back", true)
	f38_local0:addRightButtonPrompt(f38_local0.backButtonPrompt)
	f38_local0:addRightButtonPrompt(f38_local0.startButtonPrompt)
	f38_local0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	local f38_local1 = f38_local0.buttonList:addButton(Engine.Localize("MENU_YES"))
	f38_local1:setActionEventName("probation_dev_clearprobation")
	local f38_local2 = f38_local0.buttonList:addButton(Engine.Localize("MENU_NO"))
	f38_local2:setActionEventName("probation_dev_acceptprobation")
	f38_local2:processEvent({
		name = "gain_focus"
	})
	f38_local0:addElement(f38_local0.buttonList)
	f38_local0:registerEventHandler("probation_dev_clearprobation", f0_local0)
	f38_local0:registerEventHandler("probation_dev_acceptprobation", f0_local1)
	return f38_local0
end

CoD.Popup.SetupProbationQuitPopup = function (f39_arg0, f39_arg1)
	local f39_local0 = CoD.Popup.SetupPopup("popup_probation_quit_warning", f39_arg1)
	CoD.Popup.AddProbationWarningIcon(f39_local0)
	f39_local0.title:setText(Engine.Localize("MENU_PROBATION_WARNING"))
	f39_local0.msg:setText(Engine.Localize("MENU_PROBATION_QUIT_WARNING"))
	f39_local0:addSelectButton()
	f39_local0:addBackButton()
	f39_local0.backButtonPrompt = CoD.ButtonPrompt.new("select", "", f39_local0, "button_prompt_back", true)
	f39_local0.startButtonPrompt = CoD.ButtonPrompt.new("start", "", f39_local0, "button_prompt_back", true)
	f39_local0:addRightButtonPrompt(f39_local0.backButtonPrompt)
	f39_local0:addRightButtonPrompt(f39_local0.startButtonPrompt)
	f39_local0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	local f39_local1 = f39_local0.buttonList:addButton(Engine.Localize("MENU_YES"))
	f39_local1:setActionEventName("probation_YesButtonPressed")
	local f39_local2 = f39_local0.buttonList:addButton(Engine.Localize("MENU_NO"))
	f39_local2:setActionEventName("probation_NoButtonPressed")
	f39_local2:processEvent({
		name = "gain_focus"
	})
	f39_local0:addElement(f39_local0.buttonList)
	return f39_local0
end

CoD.Popup.ProbationNoButtonPressed = function (f40_arg0, f40_arg1)
	f40_arg0:setPreviousMenu(nil)
	f40_arg0:goBack(f40_arg1.controller)
end

LUI.createMenu.popup_probation_quit_warning = function (f41_arg0)
	local f41_local0 = CoD.Popup.SetupProbationQuitPopup("popup_probation_quit_warning", f41_arg0)
	f41_local0:registerEventHandler("probation_quit_accepted", CoD.EndGamePopup.FinishEndGame)
	f41_local0:registerEventHandler("probation_YesButtonPressed", CoD.EndGamePopup.FinishEndGame)
	f41_local0:registerEventHandler("probation_NoButtonPressed", CoD.Popup.ProbationNoButtonPressed)
	return f41_local0
end

LUI.createMenu.popup_probation_join_quit_warning = function (f42_arg0)
	local f42_local0 = CoD.Popup.SetupProbationQuitPopup("popup_probation_join_quit_warning", f42_arg0)
	f42_local0:registerEventHandler("probation_quit_accepted", function (f56_arg0, f56_arg1)
		f56_arg0.occludedMenu:processEvent({
			name = "probation_confirmation",
			controller = f56_arg1.controller
		})
	end)
	f42_local0:registerEventHandler("probation_YesButtonPressed", function (f57_arg0, f57_arg1)
		f57_arg0.occludedMenu:processEvent({
			name = "probation_confirmation",
			controller = f57_arg1.controller
		})
	end)
	f42_local0:registerEventHandler("probation_NoButtonPressed", CoD.FriendsListPopup.NoJoinButtonPressed)
	return f42_local0
end

LUI.createMenu.popup_probation_dashboard_warning = function (f43_arg0)
	local f43_local0 = CoD.Popup.SetupPopup("popup_probation_dashboard_warning", f43_arg0)
	CoD.Popup.AddProbationWarningIcon(f43_local0)
	f43_local0.title:setText(Engine.Localize("MENU_PROBATION_WARNING"))
	f43_local0.msg:setText(Engine.Localize("MENU_PROBATION_DASHBOARD_WARNING"))
	f43_local0:addBackButton()
	return f43_local0
end

LUI.createMenu.popup_dev_probation_dashboard_warning = function (f44_arg0)
	local f44_local0 = CoD.Popup.SetupPopup("popup_dev_probation_dashboard_warning", f44_arg0)
	f44_local0.anyControllerAllowed = true
	CoD.Popup.AddProbationWarningIcon(f44_local0)
	f44_local0.title:setText(Engine.Localize("MENU_PROBATION_WARNING") .. "DEV ONLY")
	f44_local0.msg:setText(Engine.Localize("Probation code thinks you did not finish your last game."))
	f44_local0:addBackButton()
	return f44_local0
end

CoD.Popup.AddProbationWarningIcon = function (f45_arg0)
	local f45_local0 = 32
	local f45_local1 = 9
	local f45_local2 = 3
	f45_arg0.warningIcon = LUI.UIImage.new()
	f45_arg0.warningIcon:setLeftRight(true, false, 0, f45_local0)
	f45_arg0.warningIcon:setTopBottom(true, false, f45_local1, f45_local1 + f45_local0)
	f45_arg0.warningIcon:setImage(RegisterMaterial("cac_restricted"))
	f45_arg0.warningIcon:setAlpha(0.5)
	f45_arg0:addElement(f45_arg0.warningIcon)
	local f45_local3 = -150
	f45_arg0.title:setLeftRight(true, false, f45_local2 + f45_local0, f45_local2 + f45_local0 + CoD.Menu.SmallPopupWidth)
end

CoD.Popup.CloseProbationPopup = function (f46_arg0, f46_arg1)
	f46_arg0:goBack()
end

CoD.Popup.SetupPartyProbationPopup = function (f47_arg0, f47_arg1, f47_arg2)
	local f47_local0 = CoD.Popup.SetupPopup(f47_arg0, f47_arg1)
	local f47_local1 = -80 - CoD.textSize.Default
	local f47_local2 = ""
	local f47_local3 = true
	for f47_local7, f47_local8 in pairs(Engine.GetPartyMembersInProbation(f47_arg1, f47_arg2)) do
		if f47_local3 == true then
			f47_local2 = f47_local8.name
		else
			f47_local2 = f47_local2 .. ", " .. f47_local8.name
		end
	end
	f47_local4 = LUI.UIText.new()
	f47_local4:setLeftRight(true, true, 0, 0)
	f47_local4:setTopBottom(false, true, f47_local1 - CoD.textSize.Default / 2, f47_local1 + CoD.textSize.Default / 2)
	f47_local4:setFont(CoD.fonts.Default)
	f47_local4:setText(f47_local2)
	f47_local4:setAlignment(LUI.Alignment.Left)
	f47_local0:addElement(f47_local4)
	return f47_local0
end

CoD.Popup.SetupProbationPopup = function (f48_arg0, f48_arg1, f48_arg2)
	local f48_local0 = CoD.Popup.SetupPopup(f48_arg0, f48_arg1)
	local f48_local1 = -48 - CoD.textSize.Default
	local f48_local2 = Engine.Localize("MENU_PROBATION_TIME_REMAINING")
	local f48_local3 = LUI.UIText.new()
	f48_local3:setLeftRight(true, true, 0, 0)
	f48_local3:setTopBottom(false, true, f48_local1 - CoD.textSize.Default / 2, f48_local1 + CoD.textSize.Default / 2)
	f48_local3:setFont(CoD.fonts.Default)
	f48_local3:setText(f48_local2)
	f48_local3:setAlignment(LUI.Alignment.Left)
	f48_local0:addElement(f48_local3)
	local f48_local4, f48_local5, f48_local6, f48_local7 = GetTextDimensions(f48_local2, CoD.fonts.Default, CoD.textSize.Default)
	local f48_local8 = f48_local6 - f48_local4 + 5
	local f48_local9 = LUI.UIText.new()
	f48_local9:setLeftRight(true, false, f48_local8, f48_local8 + 1280)
	f48_local9:setTopBottom(false, true, f48_local1 - CoD.textSize.Default / 2, f48_local1 + CoD.textSize.Default / 2)
	f48_local9:setFont(CoD.fonts.Default)
	f48_local9:setAlignment(LUI.Alignment.Left)
	CoD.CountdownTimer.Setup(f48_local9, 0, true)
	f48_local0:addElement(f48_local9)
	f48_local9:addTimedParentEvent(1, "time_close_popup")
	f48_local0:registerEventHandler("time_close_popup", CoD.Popup.CloseProbationPopup)
	f48_local9:setTimeLeft(Engine.GetProbationTime(f48_arg1, f48_arg2) * 1000)
	return f48_local0
end

CoD.Popup.SetupPopup = function (f49_arg0, f49_arg1, f49_arg2)
	local f49_local0 = CoD.Popup.CreatePopup(f49_arg0, f49_arg2)
	f49_local0:setOwner(f49_arg1)
	f49_local0:registerEventHandler("menu_changed", CoD.Popup.MenuChanged)
	f49_local0:registerEventHandler("close_popup", CoD.Popup.Close)
	local f49_local1 = 0
	local f49_local2 = LUI.UIText.new()
	local f49_local3 = CoD.Menu.SmallPopupWidth
	f49_local2:setLeftRight(true, true, 0, 0)
	f49_local2:setTopBottom(true, false, f49_local1, f49_local1 + CoD.textSize.Big)
	f49_local2:setFont(CoD.fonts.Big)
	f49_local2:setAlignment(LUI.Alignment.Left)
	f49_local0.title = f49_local2
	f49_local0:addElement(f49_local2)
	f49_local1 = f49_local1 + CoD.textSize.Big + 10
	local f49_local4 = LUI.UIText.new()
	f49_local4:setLeftRight(true, true, 0, 0)
	if f49_arg2 == CoD.Popup.Type.WIDE then
		f49_local3 = CoD.Menu.MediumPopupWidth
		f49_local4:setLeftRight(true, false, 0, f49_local3 / 2)
	end
	f49_local4:setTopBottom(true, false, f49_local1, f49_local1 + CoD.textSize.Default)
	f49_local4:setFont(CoD.fonts.Default)
	f49_local4:setAlignment(LUI.Alignment.Left)
	f49_local0.msg = f49_local4
	f49_local0:addElement(f49_local4)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f49_local3 / 2, 0)
	Widget:setTopBottom(true, true, 0, 0)
	f49_local0.rightInfoContainer = Widget
	f49_local0:addElement(Widget)
	return f49_local0
end

CoD.Popup.SetupPopupBusy = function (f50_arg0, f50_arg1, f50_arg2)
	local f50_local0 = CoD.Popup.SetupPopup(f50_arg0, f50_arg1, f50_arg2)
	local f50_local1 = 64
	local f50_local2 = 64
	f50_local0.spinner = LUI.UIImage.new({
		shaderVector0 = {
			0,
			0,
			0,
			0
		}
	})
	f50_local0.spinner:setLeftRight(true, true, CoD.Menu.SmallPopupWidth / 2 - f50_local2 / 2, -(CoD.Menu.SmallPopupWidth / 2 - f50_local2 / 2))
	f50_local0.spinner:setTopBottom(true, true, CoD.Menu.SmallPopupHeight / 2 - f50_local1 / 2, -(CoD.Menu.SmallPopupHeight / 2 - f50_local1 / 2))
	f50_local0.spinner:setImage(RegisterMaterial("lui_loader"))
	f50_local0:addElement(f50_local0.spinner)
	return f50_local0
end

CoD.Popup.SetupPopupChoice = function (f51_arg0, f51_arg1, f51_arg2, f51_arg3)
	local f51_local0 = CoD.Popup.SetupPopup(f51_arg0, f51_arg1, f51_arg3)
	
	local choiceList = CoD.ButtonList.new()
	choiceList:setLeftRight(true, true, 0, 0)
	choiceList:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10, 0)
	f51_local0:addElement(choiceList)
	f51_local0.choiceList = choiceList
	
	if f51_arg2 == nil then
		f51_arg2 = 2
	elseif f51_arg2 > 5 then
		f51_arg2 = 5
	end
	for f51_local2 = 1, f51_arg2, 1 do
		local f51_local5 = choiceList:addButton("")
		f51_local5:setActionEventName("button_prompt_back")
		choiceList:addElement(f51_local5)
		if f51_local2 == 1 then
			f51_local0.choiceA = f51_local5
		end
		if f51_local2 == 2 then
			f51_local0.choiceB = f51_local5
		end
		if f51_local2 == 3 then
			f51_local0.choiceC = f51_local5
		end
		if f51_local2 == 4 then
			f51_local0.choiceD = f51_local5
		end
	end
	f51_local0:addSelectButton()
	return f51_local0
end

CoD.Popup.SetWidthHeight = function (f52_arg0, f52_arg1, f52_arg2)
	local f52_local0 = CoD.Popup.StretchedWidth
	if f52_arg1 then
		f52_local0 = f52_arg1
	end
	if Engine.IsInGame() then
		local f52_local1 = f52_local0 / 2 + 25
		local f52_local2 = f52_arg2 / 2 + 10
		local f52_local3 = 20
		f52_arg0.smallPopupBackground:setLeftRight(false, false, -f52_local1, f52_local1)
		f52_arg0.smallPopupBackground:setTopBottom(false, false, -f52_local2 - f52_local3, f52_local2 - f52_local3)
		f52_arg0:setLeftRight(false, false, -f52_local0 / 2, f52_local0 / 2)
		f52_arg0:setTopBottom(false, false, -f52_arg2 / 2, f52_arg2 / 2)
	elseif f52_arg0.popupBG then
		f52_arg0.popupBG:close()
		f52_arg0:addSmallPopupBackground(nil, f52_local0, f52_arg2)
	end
end

CoD.Popup.CreatePopup = function (f53_arg0, f53_arg1)
	local f53_local0 = nil
	if f53_arg1 == nil then
		f53_arg1 = CoD.Popup.Type.REGULAR
	elseif f53_arg1 < CoD.Popup.Type.REGULAR or f53_arg1 > CoD.Popup.Type.STRETCHED then
		f53_arg1 = CoD.Popup.Type.REGULAR
	end
	if f53_arg1 == CoD.Popup.Type.WIDE then
		f53_local0 = CoD.Menu.NewMediumPopup(f53_arg0)
	elseif f53_arg1 == CoD.Popup.Type.STRETCHED then
		f53_local0 = CoD.Menu.NewSmallPopup(f53_arg0, nil, nil, CoD.Popup.StretchedWidth, CoD.Popup.StretchedHeight)
	else
		f53_local0 = CoD.Menu.NewSmallPopup(f53_arg0)
	end
	f53_local0.setWidthHeight = CoD.Popup.SetWidthHeight
	return f53_local0
end

CoD.Popup.MenuChanged = function (f54_arg0, f54_arg1)
	if f54_arg0.occludedMenu == f54_arg1.prevMenu then
		f54_arg0:setOccludedMenu(f54_arg1.nextMenu)
	end
end

CoD.Popup.Close = function (f55_arg0, f55_arg1)
	if f55_arg0.menuName == f55_arg1.popupName then
		f55_arg0:goBack()
		return true
	else

	end
end

