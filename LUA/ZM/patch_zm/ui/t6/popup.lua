CoD.Popup = {}
CoD.Popup.CONNECTINGDW_MAX_WAIT_TIME = 30000
if CoD.isPS3 then
	CoD.Popup.CONNECTINGDW_MAX_WAIT_TIME = 40000
end
if CoD.isXbox then
	CoD.Popup.CONNECTINGDW_MAX_WAIT_TIME = 60000
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

LUI.createMenu.popup_signintolive = function (f8_arg0)
	local f8_local0 = CoD.Popup.SetupPopup("popup_signintolive", f8_arg0)
	f8_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f8_local0.msg:setText(Engine.Localize("XBOXLIVE_SIGNEDOUTOFLIVE"))
	f8_local0:addBackButton()
	return f8_local0
end

CoD.Popup.DirectToStoreBackButtonPressed = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0.occludedMenu
	f9_arg0:goBack(f9_arg1.controller)
	CoD.ButtonList.EnableInput(f9_local0.categoryButtonList)
	f9_local0.categoryContainer:animateToState("default")
	f9_local0.categoryButtonList:restoreState()
end

CoD.Popup.GoToStore = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg0.occludedMenu
	f10_arg0:goBack(f10_arg1.controller)
	f10_local0:goBack(f10_arg1.controller)
	CoD.MainLobby.OpenStore(f10_local0.occludedMenu, f10_arg1)
end

LUI.createMenu.popup_directtostore = function (f11_arg0)
	local f11_local0 = CoD.Popup.SetupPopupChoice("popup_directtostore", f11_arg0)
	f11_local0:setWidthHeight(620, 380)
	if CoD.perController[f11_arg0].dlcRequiredPopupTitle ~= nil and CoD.perController[f11_arg0].dlcRequiredPopupDesc ~= nil then
		f11_local0.title:setText(Engine.Localize(CoD.perController[f11_arg0].dlcRequiredPopupTitle))
		f11_local0.msg:setText(Engine.Localize(CoD.perController[f11_arg0].dlcRequiredPopupDesc))
	end
	f11_local0:addBackButton()
	f11_local0:registerEventHandler("button_prompt_back", CoD.Popup.DirectToStoreBackButtonPressed)
	f11_local0:registerEventHandler("gotostore", CoD.Popup.GoToStore)
	f11_local0.choiceA:setLabel(Engine.Localize("MENU_GO_TO_STORE"))
	f11_local0.choiceA:setActionEventName("gotostore")
	f11_local0.choiceA:processEvent({
		name = "gain_focus"
	})
	if f11_local0.choiceB then
		f11_local0.choiceB:close()
	end
	return f11_local0
end

LUI.createMenu.popup_partymissingmappack = function (f12_arg0)
	local f12_local0 = CoD.Popup.SetupPopupChoice("popup_partymissingmappack", f12_arg0)
	f12_local0:setWidthHeight(620, 300)
	f12_local0.title:setText(Engine.Localize("MENU_DLC3_REQUIRED"))
	f12_local0.msg:setText(Engine.Localize("MPUI_DLC_WARNING_PARTY_MISSING_MAP_PACK"))
	f12_local0:addBackButton()
	f12_local0:registerEventHandler("button_prompt_back", CoD.Popup.DirectToStoreBackButtonPressed)
	if f12_local0.selectButton then
		f12_local0.selectButton:close()
	end
	return f12_local0
end

LUI.createMenu.popup_guest_contentrestricted = function (f13_arg0)
	local f13_local0 = CoD.Popup.SetupPopup("popup_contentrestricted", f13_arg0)
	f13_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f13_local0.msg:setText(Engine.Localize("MENU_GUEST_CONTENT_RESTRICTED"))
	f13_local0:addBackButton()
	return f13_local0
end

LUI.createMenu.popup_chatrestricted = function (f14_arg0)
	local f14_local0 = CoD.Popup.SetupPopup("popup_chatrestricted", f14_arg0)
	f14_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f14_local0.msg:setText(Engine.Localize("PLATFORM_CHAT_DISABLED"))
	f14_local0.anyControllerAllowed = true
	f14_local0.primaryButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_OK"), f14_local0, "restriction_accepted")
	f14_local0:addLeftButtonPrompt(f14_local0.primaryButton)
	f14_local0:addBackButton()
	f14_local0:registerEventHandler("restriction_accepted", CoD.Popup.ChatRestrictionAccepted)
	return f14_local0
end

CoD.Popup.ChatRestrictionAccepted = function (f15_arg0, f15_arg1)
	f15_arg0:goBack(f15_arg1.controller)
	if f15_arg0.callingMenu ~= nil then
		CoD.MainMenu.OpenMainLobby(f15_arg0.callingMenu, f15_arg1)
	end
end

LUI.createMenu.popup_chatrestrictedinvite = function (f16_arg0)
	local f16_local0 = CoD.Popup.SetupPopup("popup_chatrestrictedinvite", f16_arg0)
	f16_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f16_local0.msg:setText(Engine.Localize("PLATFORM_CHAT_DISABLED"))
	f16_local0.anyControllerAllowed = true
	f16_local0:addBackButton()
	return f16_local0
end

LUI.createMenu.popup_render_complete = function (f17_arg0, f17_arg1)
	local f17_local0 = CoD.Popup.SetupPopup("popup_render_complete", f17_arg0)
	f17_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f17_local0.msg:setText(f17_arg1.message)
	f17_local0.anyControllerAllowed = true
	f17_local0.primaryButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_OK"), f17_local0, "render_complete_accepted")
	f17_local0:addLeftButtonPrompt(f17_local0.primaryButton)
	f17_local0:registerEventHandler("render_complete_accepted", CoD.Popup.RenderCompleteAccepted)
	return f17_local0
end

CoD.Popup.RenderCompleteAccepted = function (f18_arg0, f18_arg1)
	f18_arg0:goBack(f18_arg1.controller)
end

LUI.createMenu.popup_bookmarked = function (f19_arg0)
	local f19_local0 = CoD.Popup.SetupPopup("popup_bookmarked", f19_arg0)
	f19_local0.title:setText(Engine.Localize("MENU_BOOKMARKED_HEADER"))
	f19_local0.msg:setText(Engine.Localize("MENU_BOOKMARKED_MESSAGE"))
	f19_local0.anyControllerAllowed = true
	f19_local0.primaryButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_OK"), f19_local0, "bookmark_accepted")
	f19_local0:addLeftButtonPrompt(f19_local0.primaryButton)
	f19_local0:registerEventHandler("bookmark_accepted", CoD.Popup.BookmarkAccepted)
	Engine.PlaySound("cac_loadout_edit_sel")
	return f19_local0
end

CoD.Popup.BookmarkAccepted = function (f20_arg0, f20_arg1)
	f20_arg0:goBack(f20_arg1.controller)
end

LUI.createMenu.popup_xboxlive_lobbyended = function (f21_arg0)
	local f21_local0 = CoD.Popup.SetupPopup("popup_xboxlive_lobbyended", f21_arg0)
	f21_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f21_local0.msg:setText(Engine.Localize("XBOXLIVE_LOBBYENDED"))
	f21_local0:addBackButton()
	return f21_local0
end

LUI.createMenu.popup_xboxlive_partyended = function (f22_arg0)
	local f22_local0 = CoD.Popup.SetupPopup("popup_xboxlive_partyended", f22_arg0)
	f22_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f22_local0.msg:setText(Engine.Localize(UIExpression.DvarString(nil, "partyend_reason")))
	f22_local0:addBackButton()
	return f22_local0
end

LUI.createMenu.popup_net_connection = function (f23_arg0)
	local f23_local0 = CoD.Popup.SetupPopup("popup_net_connection", f23_arg0)
	f23_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f23_local0.msg:setText(Engine.Localize("XBOXLIVE_NETCONNECTION"))
	f23_local0:addBackButton()
	f23_local0.anyControllerAllowed = true
	return f23_local0
end

LUI.createMenu.popup_net_connection_store = function (f24_arg0)
	local f24_local0 = CoD.Popup.SetupPopup("popup_net_connection_store", f24_arg0)
	f24_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f24_local0.msg:setText(Engine.Localize("XBOXLIVE_NETCONNECTION_STORE"))
	f24_local0:addBackButton()
	f24_local0.anyControllerAllowed = true
	return f24_local0
end

LUI.createMenu.popup_fetchstats = function (f25_arg0)
	local f25_local0 = CoD.Popup.SetupPopupBusy("popup_fetchstats", f25_arg0)
	f25_local0.title:setText(Engine.Localize("MENU_FETCH_STATS"))
	f25_local0.anyControllerAllowed = true
	return f25_local0
end

LUI.createMenu.popup_fetchstats_failed = function (f26_arg0)
	local f26_local0 = CoD.Popup.SetupPopup("popup_fetchstats_failed", f26_arg0)
	f26_local0.title:setText(Engine.Localize("MENU_FETCH_STATS_FAILED_TITLE"))
	f26_local0.msg:setText(Engine.Localize("MENU_FETCH_STATS_FAILED"))
	f26_local0:addBackButton()
	f26_local0.anyControllerAllowed = true
	return f26_local0
end

LUI.createMenu.popup_downloading = function (f27_arg0)
	local f27_local0 = CoD.Popup.SetupPopupBusy("popup_downloading", f27_arg0)
	f27_local0.title:setText(Engine.Localize("MENU_DOWNLOADING"))
	f27_local0.anyControllerAllowed = true
	return f27_local0
end

LUI.createMenu.popup_downloading_failed = function (f28_arg0)
	local f28_local0 = CoD.Popup.SetupPopup("popup_downloading_failed", f28_arg0)
	f28_local0:addBackButton()
	f28_local0.title:setText(Engine.Localize("MENU_DOWNLOADING_FAILED"))
	f28_local0.anyControllerAllowed = true
	return f28_local0
end

LUI.createMenu.popup_cacimportfailed = function (f29_arg0)
	local f29_local0 = CoD.Popup.SetupPopup("popup_cacimportfailed", f29_arg0)
	f29_local0.title:setText(Engine.Localize("MENU_CAC_IMPORT"))
	f29_local0.msg:setText(Engine.Localize("MENU_CAC_IMPORT_FAILURE"))
	f29_local0:addBackButton()
	return f29_local0
end

LUI.createMenu.popup_acceptinvite_warning = function (f30_arg0)
	local f30_local0 = CoD.Popup.SetupPopupChoice("popup_acceptinvite_warning", f30_arg0)
	f30_local0.title:setText(Engine.Localize("MENU_ACCEPTINVITETITLE"))
	local f30_local1 = UIExpression.PrivatePartyHost()
	local f30_local2 = UIExpression.AloneInPartyIgnoreSplitscreen(f30_arg0, 1)
	local f30_local3 = UIExpression.InLobby()
	if UIExpression.PrivatePartyHost() == 1 and UIExpression.AloneInPartyIgnoreSplitscreen(f30_arg0, 1) == 0 then
		f30_local0.msg:setText(Engine.Localize("MENU_LEAVEMPGAMEWARNINGSQUADHOST"))
	elseif UIExpression.PrivatePartyHost() == 0 and UIExpression.InLobby() == 0 then
		f30_local0.msg:setText(Engine.Localize("MENU_LEAVESQUADWARNING"))
	elseif UIExpression.PrivatePartyHost() == 0 and UIExpression.InLobby() == 1 then
		f30_local0.msg:setText(Engine.Localize("MENU_LEAVEMPGAMEWARNING"))
	end
	f30_local0.choiceA:setLabel(Engine.Localize("MENU_RESUMEGAME"))
	f30_local0.choiceB:setLabel(Engine.Localize("MENU_ACCEPTINVITE"))
	f30_local0.choiceB:setActionEventName("acceptinvite")
	f30_local0.choiceB:processEvent({
		name = "gain_focus"
	})
	f30_local0:registerEventHandler("acceptinvite", CoD.Popup.AcceptInvite)
	return f30_local0
end

CoD.Popup.AcceptInvite = function (f31_arg0, f31_arg1)
	Engine.Exec(f31_arg1.controller, "acceptinvite")
	f31_arg0:goBack(f31_arg1.controller)
end

LUI.createMenu.popup_connectingdw_ps3 = function (f32_arg0)
	local f32_local0 = CoD.Popup.SetupPopupBusy("popup_connectingdw_ps3", f32_arg0)
	f32_local0.anyControllerAllowed = true
	f32_local0.title:setText(Engine.Localize("MENU_CONNECTING_DW"))
	return f32_local0
end

LUI.createMenu.popup_connectingdw = function (f33_arg0)
	local f33_local0 = CoD.Popup.SetupPopupBusy("popup_connectingdw", f33_arg0)
	f33_local0.anyControllerAllowed = true
	f33_local0.title:setText(Engine.Localize("MENU_CONNECTING_DW"))
	f33_local0:registerEventHandler("is_demonware_fetching_done", CoD.Popup.IsDemonwareFetchingDone)
	f33_local0:addBackButton()
	if CoD.isPC then
		f33_local0.msg:setText(Engine.Localize("PLATFORM_GETTING_STEAM_TICKET"))
		f33_local0.msg:hide()
	end
	local f33_local1 = LUI.UITimer.new(400, "is_demonware_fetching_done", false)
	f33_local1.controller = f33_arg0
	f33_local1.timeElapsedSinceStart = 0
	f33_local0:addElement(f33_local1)
	return f33_local0
end

CoD.Popup.IsDemonwareFetchingDone = function (f34_arg0, f34_arg1)
	if UIExpression.IsDemonwareFetchingDone(f34_arg1.timer.controller) == 1 then
		if CoD.isWIIU then
			if Engine.IsSignedInToDemonware(f34_arg1.timer.controller) == true then
				f34_arg0:goBack(f34_arg1.timer.controller)
				f34_arg0.occludedMenu:processEvent({
					name = "open_main_lobby_requested",
					controller = f34_arg1.timer.controller
				})
			end
			Engine.Exec(f34_arg1.timer.controller, "loginpopupclosed")
		else
			Engine.Exec(f34_arg1.timer.controller, "checkForPS3Invites")
			f34_arg0:goBack(f34_arg1.timer.controller)
			if f34_arg0.callingMenu ~= nil then
				f34_arg1.controller = f34_arg1.timer.controller
				if f34_arg0.inviteAccepted == nil then
					if f34_arg0.openingStore == nil or f34_arg0.openingStore == false then
						CoD.MainMenu.OpenMainLobbyRequested(f34_arg0.callingMenu, f34_arg1)
					else
						CoD.MainLobby.OpenStore(f34_arg0.callingMenu, f34_arg1)
					end
				end
			elseif f34_arg0.occludedMenu ~= nil then
				f34_arg1.controller = f34_arg1.timer.controller
				if f34_arg0.inviteAccepted == nil then
					CoD.MainMenu.OpenMainLobbyRequested(f34_arg0.occludedMenu, f34_arg1)
				end
			end
		end
	end
	local f34_local0 = true
	if CoD.isPS3 then
		f34_local0 = Engine.CheckNetConnection()
	end
	if f34_arg1.timer.timeElapsedSinceStart > CoD.Popup.CONNECTINGDW_MAX_WAIT_TIME or f34_local0 == false then
		f34_arg0:goBack(f34_arg1.timer.controller)
		Dvar.ui_errorTitle:set("@MENU_NOTICE_CAPS")
		if f34_local0 == false then
			Dvar.ui_errorMessage:set("@XBOXLIVE_NETCONNECTION")
		else
			Dvar.ui_errorMessage:set("@PLATFORM_DEMONWARE_DISCONNECT")
		end
		f34_arg0.occludedMenu:processEvent({
			name = "open_error_popup",
			controller = f34_arg1.timer.controller
		})
		if CoD.isWIIU then
			Engine.Exec(f34_arg1.timer.controller, "loginpopupclosed")
		end
	end
	if CoD.isPC then
		if Engine.WaitingForSteamTicket() then
			f34_arg0.msg:beginAnimation("fade_in", 250)
			f34_arg0.msg:show()
		else
			f34_arg0.msg:beginAnimation("fade_out", 250)
			f34_arg0.msg:hide()
		end
	end
	f34_arg1.timer.timeElapsedSinceStart = f34_arg1.timer.timeElapsedSinceStart + f34_arg1.timeElapsed
end

LUI.createMenu.popup_controllerremoved = function (f35_arg0)
	local f35_local0 = CoD.Popup.SetupPopup("popup_controllerremoved", f35_arg0)
	f35_local0.title:setText(Engine.Localize("MENU_NOTICE"))
	f35_local0.msg:setText(Engine.Localize("PLATFORM_CONTROLLER_DISCONNECTED") .. UIExpression.DvarString(nil, "disconnected_ctrls"))
	f35_local0:addBackButton()
	f35_local0.anyControllerAllowed = true
	f35_local0.m_ownerController = nil
	return f35_local0
end

LUI.createMenu.popup_public_inprobation = function (f36_arg0)
	local f36_local0 = CoD.Popup.SetupProbationPopup("popup_public_inprobation", f36_arg0, CoD.GAMEMODE_PUBLIC_MATCH)
	f36_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f36_local0.msg:setText(Engine.Localize("MENU_PROBATION_IN_PUBLIC_MATCH"))
	f36_local0:addBackButton()
	return f36_local0
end

LUI.createMenu.popup_public_givenprobation = function (f37_arg0)
	local f37_local0 = CoD.Popup.SetupProbationPopup("popup_public_partyprobation", f37_arg0, CoD.GAMEMODE_PUBLIC_MATCH)
	f37_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f37_local0.msg:setText(Engine.Localize("MENU_PROBATION_GIVEN_PUBLIC_MATCH"))
	f37_local0:addBackButton()
	return f37_local0
end

LUI.createMenu.popup_public_partyprobation = function (f38_arg0)
	local f38_local0 = CoD.Popup.SetupPartyProbationPopup("popup_public_givenprobation", f38_arg0, CoD.GAMEMODE_PUBLIC_MATCH)
	f38_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f38_local0.msg:setText(Engine.Localize("MENU_PROBATION_PARTY_PUBLIC_MATCH"))
	f38_local0:addBackButton()
	return f38_local0
end

LUI.createMenu.popup_league_inprobation = function (f39_arg0)
	local f39_local0 = CoD.Popup.SetupProbationPopup("popup_league_inprobation", f39_arg0, CoD.GAMEMODE_LEAGUE_MATCH)
	f39_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f39_local0.msg:setText(Engine.Localize("MENU_PROBATION_IN_LEAGUE_MATCH"))
	f39_local0:addBackButton()
	return f39_local0
end

LUI.createMenu.popup_league_givenprobation = function (f40_arg0)
	local f40_local0 = CoD.Popup.SetupProbationPopup("popup_league_givenprobation", f40_arg0, CoD.GAMEMODE_LEAGUE_MATCH)
	f40_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f40_local0.msg:setText(Engine.Localize("MENU_PROBATION_GIVEN_LEAGUE_MATCH"))
	f40_local0:addBackButton()
	return f40_local0
end

LUI.createMenu.popup_league_partyprobation = function (f41_arg0)
	local f41_local0 = CoD.Popup.SetupPartyProbationPopup("popup_league_partyprobation", f41_arg0, CoD.GAMEMODE_LEAGUE_MATCH)
	f41_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f41_local0.msg:setText(Engine.Localize("MENU_PROBATION_PARTY_LEAGUE_MATCH"))
	f41_local0:addBackButton()
	return f41_local0
end

local f0_local0 = function (f42_arg0, f42_arg1)
	Engine.DevOnlyClearProbation(f42_arg1.controller)
	f42_arg0:goBack(f42_arg1.controller)
end

local f0_local1 = function (f43_arg0, f43_arg1)
	f43_arg0:goBack(f43_arg1.controller)
end

LUI.createMenu.popup_dev_clearprobation = function (f44_arg0)
	local f44_local0 = CoD.Popup.SetupPopup("popup_league_givenprobation", f44_arg0)
	f44_local0.anyControllerAllowed = true
	f44_local0.title:setText(Engine.Localize("MENU_PROBATION"))
	f44_local0.msg:setText("DEV ONLY:  You have just been given probation.  Would you like to clear it?")
	f44_local0:addSelectButton()
	f44_local0:addBackButton()
	f44_local0.backButtonPrompt = CoD.ButtonPrompt.new("select", "", f44_local0, "button_prompt_back", true)
	f44_local0.startButtonPrompt = CoD.ButtonPrompt.new("start", "", f44_local0, "button_prompt_back", true)
	f44_local0:addRightButtonPrompt(f44_local0.backButtonPrompt)
	f44_local0:addRightButtonPrompt(f44_local0.startButtonPrompt)
	f44_local0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	local f44_local1 = f44_local0.buttonList:addButton(Engine.Localize("MENU_YES"))
	f44_local1:setActionEventName("probation_dev_clearprobation")
	local f44_local2 = f44_local0.buttonList:addButton(Engine.Localize("MENU_NO"))
	f44_local2:setActionEventName("probation_dev_acceptprobation")
	f44_local2:processEvent({
		name = "gain_focus"
	})
	f44_local0:addElement(f44_local0.buttonList)
	f44_local0:registerEventHandler("probation_dev_clearprobation", f0_local0)
	f44_local0:registerEventHandler("probation_dev_acceptprobation", f0_local1)
	return f44_local0
end

CoD.Popup.SetupProbationQuitPopup = function (f45_arg0, f45_arg1)
	local f45_local0 = CoD.Popup.SetupPopup("popup_probation_quit_warning", f45_arg1)
	CoD.Popup.AddProbationWarningIcon(f45_local0)
	f45_local0.title:setText(Engine.Localize("MENU_PROBATION_WARNING"))
	f45_local0.msg:setText(Engine.Localize("MENU_PROBATION_QUIT_WARNING"))
	f45_local0:addSelectButton()
	f45_local0:addBackButton()
	f45_local0.backButtonPrompt = CoD.ButtonPrompt.new("select", "", f45_local0, "button_prompt_back", true)
	f45_local0.startButtonPrompt = CoD.ButtonPrompt.new("start", "", f45_local0, "button_prompt_back", true)
	f45_local0:addRightButtonPrompt(f45_local0.backButtonPrompt)
	f45_local0:addRightButtonPrompt(f45_local0.startButtonPrompt)
	f45_local0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	local f45_local1 = f45_local0.buttonList:addButton(Engine.Localize("MENU_YES"))
	f45_local1:setActionEventName("probation_YesButtonPressed")
	local f45_local2 = f45_local0.buttonList:addButton(Engine.Localize("MENU_NO"))
	f45_local2:setActionEventName("probation_NoButtonPressed")
	f45_local2:processEvent({
		name = "gain_focus"
	})
	f45_local0:addElement(f45_local0.buttonList)
	return f45_local0
end

CoD.Popup.ProbationNoButtonPressed = function (f46_arg0, f46_arg1)
	f46_arg0:setPreviousMenu(nil)
	f46_arg0:goBack(f46_arg1.controller)
end

LUI.createMenu.popup_probation_quit_warning = function (f47_arg0)
	local f47_local0 = CoD.Popup.SetupProbationQuitPopup("popup_probation_quit_warning", f47_arg0)
	f47_local0:registerEventHandler("probation_quit_accepted", CoD.EndGamePopup.FinishEndGame)
	f47_local0:registerEventHandler("probation_YesButtonPressed", CoD.EndGamePopup.FinishEndGame)
	f47_local0:registerEventHandler("probation_NoButtonPressed", CoD.Popup.ProbationNoButtonPressed)
	return f47_local0
end

LUI.createMenu.popup_probation_join_quit_warning = function (f48_arg0)
	local f48_local0 = CoD.Popup.SetupProbationQuitPopup("popup_probation_join_quit_warning", f48_arg0)
	f48_local0:registerEventHandler("probation_quit_accepted", function (f63_arg0, f63_arg1)
		f63_arg0.occludedMenu:processEvent({
			name = "probation_confirmation",
			controller = f63_arg1.controller
		})
	end)
	f48_local0:registerEventHandler("probation_YesButtonPressed", function (f64_arg0, f64_arg1)
		f64_arg0.occludedMenu:processEvent({
			name = "probation_confirmation",
			controller = f64_arg1.controller
		})
	end)
	f48_local0:registerEventHandler("probation_NoButtonPressed", CoD.FriendsListPopup.NoJoinButtonPressed)
	return f48_local0
end

LUI.createMenu.popup_probation_dashboard_warning = function (f49_arg0)
	local f49_local0 = CoD.Popup.SetupPopup("popup_probation_dashboard_warning", f49_arg0)
	CoD.Popup.AddProbationWarningIcon(f49_local0)
	f49_local0.title:setText(Engine.Localize("MENU_PROBATION_WARNING"))
	f49_local0.msg:setText(Engine.Localize("MENU_PROBATION_DASHBOARD_WARNING"))
	f49_local0:addBackButton()
	return f49_local0
end

LUI.createMenu.popup_dev_probation_dashboard_warning = function (f50_arg0)
	local f50_local0 = CoD.Popup.SetupPopup("popup_dev_probation_dashboard_warning", f50_arg0)
	f50_local0.anyControllerAllowed = true
	CoD.Popup.AddProbationWarningIcon(f50_local0)
	f50_local0.title:setText(Engine.Localize("MENU_PROBATION_WARNING") .. "DEV ONLY")
	f50_local0.msg:setText(Engine.Localize("Probation code thinks you did not finish your last game."))
	f50_local0:addBackButton()
	return f50_local0
end

CoD.Popup.AddProbationWarningIcon = function (f51_arg0)
	local f51_local0 = 32
	local f51_local1 = 9
	local f51_local2 = 3
	f51_arg0.warningIcon = LUI.UIImage.new()
	f51_arg0.warningIcon:setLeftRight(true, false, 0, f51_local0)
	f51_arg0.warningIcon:setTopBottom(true, false, f51_local1, f51_local1 + f51_local0)
	f51_arg0.warningIcon:setImage(RegisterMaterial("cac_restricted"))
	f51_arg0.warningIcon:setAlpha(0.5)
	f51_arg0:addElement(f51_arg0.warningIcon)
	local f51_local3 = -150
	f51_arg0.title:setLeftRight(true, false, f51_local2 + f51_local0, f51_local2 + f51_local0 + CoD.Menu.SmallPopupWidth)
end

CoD.Popup.CloseProbationPopup = function (f52_arg0, f52_arg1)
	f52_arg0:goBack()
end

CoD.Popup.SetupPartyProbationPopup = function (f53_arg0, f53_arg1, f53_arg2)
	local f53_local0 = CoD.Popup.SetupPopup(f53_arg0, f53_arg1)
	local f53_local1 = -80 - CoD.textSize.Default
	local f53_local2 = ""
	local f53_local3 = true
	for f53_local7, f53_local8 in pairs(Engine.GetPartyMembersInProbation(f53_arg1, f53_arg2)) do
		if f53_local3 == true then
			f53_local2 = f53_local8.name
		else
			f53_local2 = f53_local2 .. ", " .. f53_local8.name
		end
	end
	f53_local4 = LUI.UIText.new()
	f53_local4:setLeftRight(true, true, 0, 0)
	f53_local4:setTopBottom(false, true, f53_local1 - CoD.textSize.Default / 2, f53_local1 + CoD.textSize.Default / 2)
	f53_local4:setFont(CoD.fonts.Default)
	f53_local4:setText(f53_local2)
	f53_local4:setAlignment(LUI.Alignment.Left)
	f53_local0:addElement(f53_local4)
	return f53_local0
end

CoD.Popup.SetupProbationPopup = function (f54_arg0, f54_arg1, f54_arg2)
	local f54_local0 = CoD.Popup.SetupPopup(f54_arg0, f54_arg1)
	local f54_local1 = -48 - CoD.textSize.Default
	local f54_local2 = Engine.Localize("MENU_PROBATION_TIME_REMAINING")
	local f54_local3 = LUI.UIText.new()
	f54_local3:setLeftRight(true, true, 0, 0)
	f54_local3:setTopBottom(false, true, f54_local1 - CoD.textSize.Default / 2, f54_local1 + CoD.textSize.Default / 2)
	f54_local3:setFont(CoD.fonts.Default)
	f54_local3:setText(f54_local2)
	f54_local3:setAlignment(LUI.Alignment.Left)
	f54_local0:addElement(f54_local3)
	local f54_local4, f54_local5, f54_local6, f54_local7 = GetTextDimensions(f54_local2, CoD.fonts.Default, CoD.textSize.Default)
	local f54_local8 = f54_local6 - f54_local4 + 5
	local f54_local9 = LUI.UIText.new()
	f54_local9:setLeftRight(true, false, f54_local8, f54_local8 + 1280)
	f54_local9:setTopBottom(false, true, f54_local1 - CoD.textSize.Default / 2, f54_local1 + CoD.textSize.Default / 2)
	f54_local9:setFont(CoD.fonts.Default)
	f54_local9:setAlignment(LUI.Alignment.Left)
	CoD.CountdownTimer.Setup(f54_local9, 0, true)
	f54_local0:addElement(f54_local9)
	f54_local9:addTimedParentEvent(1, "time_close_popup")
	f54_local0:registerEventHandler("time_close_popup", CoD.Popup.CloseProbationPopup)
	f54_local9:setTimeLeft(Engine.GetProbationTime(f54_arg1, f54_arg2) * 1000)
	return f54_local0
end

CoD.Popup.SetupPopup = function (f55_arg0, f55_arg1, f55_arg2)
	local f55_local0 = CoD.Popup.CreatePopup(f55_arg0, f55_arg2)
	f55_local0:setOwner(f55_arg1)
	f55_local0:registerEventHandler("menu_changed", CoD.Popup.MenuChanged)
	f55_local0:registerEventHandler("close_popup", CoD.Popup.Close)
	local f55_local1 = 0
	local f55_local2 = LUI.UIText.new()
	local f55_local3 = CoD.Menu.SmallPopupWidth
	f55_local2:setLeftRight(true, true, 0, 0)
	f55_local2:setTopBottom(true, false, f55_local1, f55_local1 + CoD.textSize.Big)
	f55_local2:setFont(CoD.fonts.Big)
	f55_local2:setAlignment(LUI.Alignment.Left)
	f55_local0.title = f55_local2
	f55_local0:addElement(f55_local2)
	f55_local1 = f55_local1 + CoD.textSize.Big + 10
	local f55_local4 = LUI.UIText.new()
	f55_local4:setLeftRight(true, true, 0, 0)
	if f55_arg2 == CoD.Popup.Type.WIDE then
		f55_local3 = CoD.Menu.MediumPopupWidth
		f55_local4:setLeftRight(true, false, 0, f55_local3 / 2)
	end
	f55_local4:setTopBottom(true, false, f55_local1, f55_local1 + CoD.textSize.Default)
	f55_local4:setFont(CoD.fonts.Default)
	f55_local4:setAlignment(LUI.Alignment.Left)
	f55_local0.msg = f55_local4
	f55_local0:addElement(f55_local4)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f55_local3 / 2, 0)
	Widget:setTopBottom(true, true, 0, 0)
	f55_local0.rightInfoContainer = Widget
	f55_local0:addElement(Widget)
	return f55_local0
end

CoD.Popup.SetupPopupBusy = function (f56_arg0, f56_arg1, f56_arg2)
	local f56_local0 = CoD.Popup.SetupPopup(f56_arg0, f56_arg1, f56_arg2)
	local f56_local1 = 64
	local f56_local2 = 64
	f56_local0.spinner = LUI.UIImage.new({
		shaderVector0 = {
			0,
			0,
			0,
			0
		}
	})
	f56_local0.spinner:setLeftRight(true, true, CoD.Menu.SmallPopupWidth / 2 - f56_local2 / 2, -(CoD.Menu.SmallPopupWidth / 2 - f56_local2 / 2))
	f56_local0.spinner:setTopBottom(true, true, CoD.Menu.SmallPopupHeight / 2 - f56_local1 / 2, -(CoD.Menu.SmallPopupHeight / 2 - f56_local1 / 2))
	f56_local0.spinner:setImage(RegisterMaterial("lui_loader"))
	f56_local0:addElement(f56_local0.spinner)
	return f56_local0
end

CoD.Popup.SetupPopupChoice = function (f57_arg0, f57_arg1, f57_arg2, f57_arg3)
	local f57_local0 = CoD.Popup.SetupPopup(f57_arg0, f57_arg1, f57_arg3)
	
	local choiceList = CoD.ButtonList.new()
	choiceList:setLeftRight(true, true, 0, 0)
	choiceList:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10, 0)
	f57_local0:addElement(choiceList)
	f57_local0.choiceList = choiceList
	
	if f57_arg2 == nil then
		f57_arg2 = 2
	elseif f57_arg2 > 5 then
		f57_arg2 = 5
	end
	for f57_local2 = 1, f57_arg2, 1 do
		local f57_local5 = choiceList:addButton("")
		f57_local5:setActionEventName("button_prompt_back")
		choiceList:addElement(f57_local5)
		if f57_local2 == 1 then
			f57_local0.choiceA = f57_local5
		end
		if f57_local2 == 2 then
			f57_local0.choiceB = f57_local5
		end
		if f57_local2 == 3 then
			f57_local0.choiceC = f57_local5
		end
		if f57_local2 == 4 then
			f57_local0.choiceD = f57_local5
		end
	end
	f57_local0:addSelectButton()
	return f57_local0
end

CoD.Popup.SetWidthHeight = function (f58_arg0, f58_arg1, f58_arg2)
	local f58_local0 = CoD.Popup.StretchedWidth
	if f58_arg1 then
		f58_local0 = f58_arg1
	end
	if Engine.IsInGame() then
		local f58_local1 = f58_local0 / 2 + 25
		local f58_local2 = f58_arg2 / 2 + 10
		local f58_local3 = 20
		f58_arg0.smallPopupBackground:setLeftRight(false, false, -f58_local1, f58_local1)
		f58_arg0.smallPopupBackground:setTopBottom(false, false, -f58_local2 - f58_local3, f58_local2 - f58_local3)
		f58_arg0:setLeftRight(false, false, -f58_local0 / 2, f58_local0 / 2)
		f58_arg0:setTopBottom(false, false, -f58_arg2 / 2, f58_arg2 / 2)
	elseif f58_arg0.popupBG then
		f58_arg0.popupBG:close()
		f58_arg0:addSmallPopupBackground(nil, f58_local0, f58_arg2)
	end
end

CoD.Popup.CreatePopup = function (f59_arg0, f59_arg1)
	local f59_local0 = nil
	if f59_arg1 == nil then
		f59_arg1 = CoD.Popup.Type.REGULAR
	elseif f59_arg1 < CoD.Popup.Type.REGULAR or f59_arg1 > CoD.Popup.Type.STRETCHED then
		f59_arg1 = CoD.Popup.Type.REGULAR
	end
	if f59_arg1 == CoD.Popup.Type.WIDE then
		f59_local0 = CoD.Menu.NewMediumPopup(f59_arg0)
	elseif f59_arg1 == CoD.Popup.Type.STRETCHED then
		f59_local0 = CoD.Menu.NewSmallPopup(f59_arg0, nil, nil, CoD.Popup.StretchedWidth, CoD.Popup.StretchedHeight)
	else
		f59_local0 = CoD.Menu.NewSmallPopup(f59_arg0)
	end
	f59_local0.setWidthHeight = CoD.Popup.SetWidthHeight
	return f59_local0
end

CoD.Popup.MenuChanged = function (f60_arg0, f60_arg1)
	if f60_arg0.occludedMenu == f60_arg1.prevMenu then
		f60_arg0:setOccludedMenu(f60_arg1.nextMenu)
	end
end

CoD.Popup.Close = function (f61_arg0, f61_arg1)
	if f61_arg0.menuName == f61_arg1.popupName then
		f61_arg0:goBack()
		return true
	else

	end
end

LUI.createMenu.signed_out = function (f62_arg0)
	local f62_local0 = LUI.createMenu.Error(f62_arg0)
	f62_local0.anyControllerAllowed = true
	f62_local0:setMessage(Engine.Localize("XBOXLIVE_SIGNINCHANGED"))
	return f62_local0
end

