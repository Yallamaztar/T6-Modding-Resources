require("T6.Menus.PrivateGameLobby")
require("T6.MapInfoImage")
require("T6.Menus.CODTv")
CoD.TheaterLobby = {}
CoD.TheaterLobby.m_fileInfo = {}
LUI.createMenu.TheaterLobby = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.PrivateGameLobby.New("TheaterLobby", f1_arg0)
	f1_local0:setPreviousMenu("MainLobby")
	f1_local0.controller = f1_arg0
	Engine.Exec(f1_arg0, "vote_getHistory")
	f1_local0.addButtonPaneElements = CoD.TheaterLobby.AddButtonPaneElements
	f1_local0.populateButtonPaneElements = CoD.TheaterLobby.PopulateButtonPaneElements
	f1_local0.addLobbyPaneElements = CoD.TheaterLobby.AddLobbyPaneElements
	f1_local0.updateLobbyButtons = CoD.TheaterLobby.UpdateLobbyButtons
	f1_local0.populateButtons = CoD.TheaterLobby.PopulateButtons
	f1_local0:updatePanelFunctions()
	f1_local0:registerEventHandler("theaterlobby_update", CoD.TheaterLobby.TheaterLobbyUpdate)
	f1_local0:registerEventHandler("button_prompt_back", CoD.TheaterLobby.ButtonBack)
	f1_local0:registerEventHandler("gamelobby_update", CoD.TheaterLobby.GameLobbyUpdate)
	f1_local0:registerEventHandler("button_prompt_team_prev", nil)
	f1_local0:registerEventHandler("button_prompt_team_next", nil)
	f1_local0:registerEventHandler("start_film", CoD.TheaterLobby.StartFilm)
	f1_local0:registerEventHandler("create_highlight_reel", CoD.TheaterLobby.CreateHighlightReel)
	f1_local0:registerEventHandler("shoutcast_film", CoD.TheaterLobby.ShoutcastFilm)
	f1_local0:registerEventHandler("open_select_film", CoD.TheaterLobby.OpenSelectFilm)
	f1_local0:registerEventHandler("open_codtv", CoD.TheaterLobby.OpenCodtv)
	f1_local0:registerEventHandler("render_clip", CoD.TheaterLobby.RenderClip)
	f1_local0:registerEventHandler("film_options_flyout", CoD.TheaterLobby.OpenFilmOptionsFlyout)
	f1_local0:registerEventHandler("film_options_save", CoD.TheaterLobby.FileOptions_Save)
	f1_local0:registerEventHandler("film_options_likedislike", CoD.TheaterLobby.FileOptions_LikeDislike)
	f1_local0:registerEventHandler("theater_render_complete", CoD.TheaterLobby.RenderComplete)
	f1_local0:addTitle(Engine.Localize("MPUI_THEATER_LOBBY_CAPS"))
	f1_local0.panelManager.panels.buttonPane.titleText = f1_local0.titleText
	f1_local0.panelManager.panels.buttonPane.isHost = CoD.PrivateGameLobby.IsHost(f1_local0, f1_arg0)
	f1_local0.buttonPane.body.buttonList:removeAllChildren()
	f1_local0.buttonPane.body.statusText:close()
	f1_local0.buttonPane.body.statusText = nil
	f1_local0.buttonPane.body.mapInfoImage:close()
	f1_local0.buttonPane.body.mapInfoImage = nil
	CoD.TheaterLobby.PopulateButtons(f1_local0.buttonPane)
	CoD.TheaterLobby.UpdateButtonPaneButtons(f1_local0.buttonPane, {
		controller = f1_arg0
	})
	f1_local0.buttonPane.populatePanelElements = f1_local0.populateButtonPaneElements
	f1_local0.lobbyPane:setSplitscreenSignInAllowed(false)
	if CoD.isZombie then
		if not f1_arg1 or not f1_arg1.parent or f1_arg1.parent ~= "MainLobby" then
			CoD.GameGlobeZombie.MoveToCornerJoinLobby()
		end
		if f1_local0.panelManager.panels.buttonPane.isHost == true then
			f1_local0.buttonPane.body.buttonList:selectElementIndex(2)
		else
			f1_local0.buttonPane.body.buttonList:selectElementIndex(1)
		end
		f1_local0.buttonPane:saveState()
	end
	return f1_local0
end

CoD.TheaterLobby.CanRenderVideo = function (f2_arg0)
	if not CoD.isWIIU then
		if CoD.isPS3 and UIExpression.DvarBool(nil, "tu2_luiHacksDisabled") == 0 then
			local f2_local0 = tonumber(UIExpression.GetDStat(f2_arg0, "uploadBandWidth"))
			if f2_local0 then
				f2_local0 = f2_local0 / 1000
			end
			if f2_local0 > 2000 then
				return true
			end
		else
			return true
		end
	end
	return false
end

CoD.TheaterLobby.AddFilmOptionsFlyout = function (f3_arg0)
	local f3_local0 = CoD.PrivateGameLobby.DefaultSetupGameFlyoutLeft + 10
	local f3_local1 = CoD.Menu.TitleHeight + CoD.MPZM(CoD.CoD9Button.Height * 6 + 2, CoD.CoD9Button.Height * 5 - 4)
	local f3_local2 = CoD.CoD9Button.Height * 5
	local f3_local3 = CoD.ButtonList.DefaultWidth - 20
	f3_arg0.body.setupGameFlyoutBG = LUI.UIImage.new()
	f3_arg0.body.setupGameFlyoutBG:setLeftRight(true, false, -4, f3_local0)
	f3_arg0.body.setupGameFlyoutBG:setTopBottom(true, false, f3_local1, f3_local1 + CoD.CoD9Button.Height)
	f3_arg0.body.setupGameFlyoutBG:setRGB(0, 0, 0)
	f3_arg0.body.setupGameFlyoutBG:setAlpha(0.8)
	f3_arg0.body.setupGameFlyoutBG:setPriority(-100)
	f3_arg0.body:addElement(f3_arg0.body.setupGameFlyoutBG)
	f3_arg0.body.setupGameFlyoutContainer = LUI.UIElement.new()
	f3_arg0.body.setupGameFlyoutContainer:setLeftRight(true, false, f3_local0, f3_local0 + f3_local3)
	f3_arg0.body.setupGameFlyoutContainer:setTopBottom(true, false, f3_local1, f3_local1 + f3_local2)
	f3_arg0.body.setupGameFlyoutContainer:setPriority(1000)
	f3_arg0.body:addElement(f3_arg0.body.setupGameFlyoutContainer)
	local f3_local4 = LUI.UIImage.new()
	f3_local4:setLeftRight(true, true, 0, 0)
	f3_local4:setTopBottom(true, true, 0, 0)
	f3_local4:setRGB(0, 0, 0)
	f3_local4:setAlpha(0.8)
	f3_arg0.body.setupGameFlyoutContainer:addElement(f3_local4)
	f3_arg0.body.setupGameFlyoutContainer.buttonList = CoD.ButtonList.new()
	f3_arg0.body.setupGameFlyoutContainer.buttonList:setLeftRight(true, true, 4, 0)
	f3_arg0.body.setupGameFlyoutContainer.buttonList:setTopBottom(true, true, 0, 0)
	f3_arg0.body.setupGameFlyoutContainer:addElement(f3_arg0.body.setupGameFlyoutContainer.buttonList)
	f3_arg0.body.setupGameFlyoutContainer.likeDislikeButton = f3_arg0.body.setupGameFlyoutContainer.buttonList:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_FILESHARE_LIKEDISLIKE")), Engine.Localize("MENU_FILESHARE_LIKEDISLIKE_HINT"))
	f3_arg0.body.setupGameFlyoutContainer.likeDislikeButton:setActionEventName("film_options_likedislike")
	if CoD.TheaterLobby.m_fileInfo.isPooled == true then
		f3_arg0.body.setupGameFlyoutContainer.likeDislikeButton.hintText = Engine.Localize("MENU_FILESHARE_LIKEDISLIKE_ERROR")
		f3_arg0.body.setupGameFlyoutContainer.likeDislikeButton:disable()
	end
	f3_arg0.body.setupGameFlyoutContainer.saveButton = f3_arg0.body.setupGameFlyoutContainer.buttonList:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_FILESHARE_SAVE")), Engine.Localize("MENU_FILESHARE_SAVE_FILM_HINT"))
	f3_arg0.body.setupGameFlyoutContainer.saveButton:setActionEventName("film_options_save")
end

CoD.TheaterLobby.RemoveFilmOptionsFlyout = function (f4_arg0)
	if f4_arg0.body.setupGameFlyoutBG ~= nil then
		f4_arg0.body.setupGameFlyoutBG:close()
		f4_arg0.body.setupGameFlyoutBG = nil
	end
	if f4_arg0.body.setupGameFlyoutContainer ~= nil then
		f4_arg0.body.setupGameFlyoutContainer:close()
		f4_arg0.body.setupGameFlyoutContainer = nil
	end
end

CoD.TheaterLobby.OpenFilmOptionsFlyout = function (f5_arg0, f5_arg1)
	if f5_arg0.buttonPane ~= nil and f5_arg0.buttonPane.body ~= nil then
		CoD.TheaterLobby.RemoveFilmOptionsFlyout(f5_arg0.buttonPane)
		CoD.TheaterLobby.AddFilmOptionsFlyout(f5_arg0.buttonPane)
		f5_arg0.panelManager.slidingEnabled = false
		CoD.ButtonList.DisableInput(f5_arg0.buttonPane.body.buttonList)
		f5_arg0.buttonPane.body.buttonList:animateToState("disabled")
		f5_arg0.buttonPane.body.setupGameFlyoutContainer:processEvent({
			name = "gain_focus"
		})
		f5_arg0:registerEventHandler("button_prompt_back", CoD.TheaterLobby.CloseFilmOptionsFlyout)
	end
end

CoD.TheaterLobby.CloseFilmOptionsFlyout = function (f6_arg0, f6_arg1)
	if f6_arg0.buttonPane ~= nil and f6_arg0.buttonPane.body ~= nil and f6_arg0.buttonPane.body.setupGameFlyoutContainer ~= nil then
		CoD.TheaterLobby.RemoveFilmOptionsFlyout(f6_arg0.buttonPane)
		CoD.ButtonList.EnableInput(f6_arg0.buttonPane.body.buttonList)
		f6_arg0.buttonPane.body.buttonList:animateToState("default")
		f6_arg0:registerEventHandler("button_prompt_back", CoD.TheaterLobby.ButtonBack)
		f6_arg0.panelManager.slidingEnabled = true
		Engine.PlaySound("cac_cmn_backout")
	end
end

CoD.TheaterLobby.PopulateButtons = function (f7_arg0)
	if f7_arg0.body == nil then
		return 
	end
	f7_arg0.body.buttonList:removeAllButtons()
	local f7_local0 = f7_arg0.panelManager.ownerController
	local f7_local1 = CoD.PrivateGameLobby.IsHost(f7_arg0, f7_local0)
	if f7_local1 == true then
		f7_arg0.body.startFilmButton = f7_arg0.body.buttonList:addButton(Engine.Localize("MPUI_START_FILM_CAPS"))
		f7_arg0.body.startFilmButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
		f7_arg0.body.startFilmButton:setActionEventName("start_film")
		f7_arg0.body.startFilmButton:disable()
		f7_arg0.body.selectFilmButton = f7_arg0.body.buttonList:addButton(Engine.Localize("MENU_FILESHARE_SELECT_FILM_CAPS"))
		f7_arg0.body.selectFilmButton.hintText = Engine.Localize("MENU_FILESHARE_SELECT_FILM_DESC")
		f7_arg0.body.selectFilmButton:setActionEventName("open_select_film")
		f7_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2)
		f7_arg0.body.createHighlightReelButton = f7_arg0.body.buttonList:addButton(Engine.Localize("MPUI_CREATE_HIGHLIGHT_CAPS"))
		f7_arg0.body.createHighlightReelButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
		f7_arg0.body.createHighlightReelButton:setActionEventName("create_highlight_reel")
		f7_arg0.body.createHighlightReelButton:disable()
		if CoD.isZombie == false then
			f7_arg0.body.shoutcastFilmButton = f7_arg0.body.buttonList:addButton(Engine.Localize("MPUI_SHOUTCAST_FILM_CAPS"))
			f7_arg0.body.shoutcastFilmButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
			f7_arg0.body.shoutcastFilmButton:setActionEventName("shoutcast_film")
			f7_arg0.body.shoutcastFilmButton:disable()
		end
		if CoD.TheaterLobby.CanRenderVideo(f7_local0) then
			f7_arg0.body.renderClipButton = f7_arg0.body.buttonList:addButton(Engine.Localize("MENU_DEMO_RENDER_CLIP_CAPS"))
			f7_arg0.body.renderClipButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
			f7_arg0.body.renderClipButton:setActionEventName("render_clip")
			f7_arg0.body.renderClipButton:disable()
		end
		f7_arg0.body.fileOptionsButton = f7_arg0.body.buttonList:addButton(Engine.Localize("MENU_FILM_OPTIONS"))
		f7_arg0.body.fileOptionsButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
		f7_arg0.body.fileOptionsButton:setActionEventName("film_options_flyout")
		f7_arg0.body.fileOptionsButton:disable()
		f7_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2)
	end
	if Engine.IsBetaBuild() then
		f7_arg0.body.codtvButton = f7_arg0.body.buttonList:addButton(Engine.Localize("MENU_FILESHARE_COMMUNITY_CAPS"))
		f7_arg0.body.codtvButton:setActionEventName("open_codtv")
		f7_arg0.body.codtvButton.hintText = Engine.Localize("MPUI_COD_TV_DESC")
	else
		f7_arg0.body.codtvButton = f7_arg0.body.buttonList:addButton(Engine.Localize("MENU_COD_TV_CAPS"))
		f7_arg0.body.codtvButton.hintText = Engine.Localize("MPUI_COD_TV_DESC")
		f7_arg0.body.codtvButton:setActionEventName("open_codtv")
	end
	if not Engine.IsBetaBuild() then
		f7_arg0.body.barracksButton = f7_arg0.body.buttonList:addButton(Engine.Localize(CoD.MPZM("MENU_BARRACKS_CAPS", "MPUI_LEADERBOARDS_CAPS")))
		CoD.SetupBarracksLock(f7_arg0.body.barracksButton)
		f7_arg0.body.barracksButton:setActionEventName("open_barracks")
	end
	if f7_local1 == true then
		if CoD.isZombie then
			f7_arg0:restoreState()
		elseif not f7_arg0:restoreState() then
			f7_arg0.body.startFilmButton:processEvent({
				name = "gain_focus"
			})
		end
	elseif not f7_arg0:restoreState() then
		if Engine.IsBetaBuild() then
			f7_arg0.body.codtvButton:processEvent({
				name = "gain_focus"
			})
		else
			f7_arg0.body.barracksButton:processEvent({
				name = "gain_focus"
			})
		end
	end
	if f7_arg0.body.mapInfoImage ~= nil then
		f7_arg0.body.mapInfoImage:close()
		f7_arg0.body.mapInfoImage = nil
	end
	local f7_local2 = 350 - CoD.CoD9Button.Height - 0
	f7_arg0.body.mapInfoImage = CoD.MapInfoImage.new({
		left = 0,
		top = -(f7_local2 / CoD.MapInfoImage.AspectRatio) - CoD.ButtonPrompt.Height - 15,
		right = f7_local2,
		bottom = -CoD.ButtonPrompt.Height - 15,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	})
	f7_arg0.body.mapInfoImage:setPriority(200)
	f7_arg0.body.mapInfoImage.id = "TheaterInfo"
	f7_arg0.body.mapInfoImage.theaterUpdate = CoD.MapInfoImage.TheaterUpdate
	f7_arg0.body.mapInfoImage:registerEventHandler("gamelobby_update", nil)
	f7_arg0.body.mapInfoImage:registerEventHandler("gametype_update", nil)
	f7_arg0.body.mapInfoImage:registerEventHandler("game_options_update", nil)
	f7_arg0.body.mapInfoImage:registerEventHandler("map_update", nil)
	f7_arg0.body.mapInfoImage:theaterUpdate(f7_local1, UIExpression.DvarString(f7_arg0.controller, "ui_mapname"), UIExpression.DvarString(f7_arg0.controller, "ui_gametype"))
	f7_arg0.body:addElement(f7_arg0.body.mapInfoImage)
	CoD.PrivateGameLobby.AddDLCWarning(f7_arg0, f7_local1)
end

CoD.TheaterLobby.UpdateLobbyButtons = function (f8_arg0, f8_arg1)
	if CoD.PrivateGameLobby.IsHost(f8_arg0, f8_arg0.panelManager.ownerController) == true and f8_arg0.body ~= nil then
		if f8_arg0.body.startFilmButton == nil then
			CoD.TheaterLobby.PopulateButtons(f8_arg0)
			f8_arg0.body.barracksButton:processEvent({
				name = "lose_focus"
			})
		end
		local f8_local0 = UIExpression.DvarString(f8_arg0.controller, "ui_demoname") ~= ""
		local f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6 = nil
		local f8_local7 = Engine.PartyGetPlayerCount()
		local f8_local8 = nil
		local f8_local9 = UIExpression.CanRenderClip() == 1
		if f8_arg1 ~= nil then
			f8_local2 = f8_arg1.task_readFileInProgress
			f8_local1 = f8_arg1.haveAllPlayersFinishedDownloading
			local f8_local10 = f8_arg1.areAllPlayersReadyToLoadDemo
			if f8_local10 == 0 then
				f8_local3 = f8_local10
			else
				f8_local3 = Engine.IsSignedInToDemonware(f8_arg0.contoller)
			end
			f8_local6 = f8_arg1.isPooled
			f8_local4 = f8_arg1.category == "clip"
			f8_local5 = f8_arg1.category == "film"
			if f8_arg1.duration ~= nil then
				f8_local8 = f8_arg1.duration <= Dvar.demoRenderDuration:get() * 1000
			else
				f8_local8 = false
			end
			CoD.TheaterLobby.m_fileInfo.name = f8_arg1.fileName
			CoD.TheaterLobby.m_fileInfo.description = f8_arg1.fileDescription
			CoD.TheaterLobby.m_fileInfo.matchID = f8_arg1.matchID
			CoD.TheaterLobby.m_fileInfo.fileID = f8_arg1.fileID
			CoD.TheaterLobby.m_fileInfo.category = f8_arg1.category
			CoD.TheaterLobby.m_fileInfo.isPooled = f8_arg1.isPooled
		else
			f8_local2 = false
			f8_local1 = false
			f8_local3 = false
			f8_local4 = false
			f8_local5 = false
			f8_local8 = false
		end
		if f8_local0 then
			f8_arg0.body.startFilmButton.hintText = Engine.Localize("MPUI_START_FILM_DESC")
			f8_arg0.body.createHighlightReelButton.hintText = Engine.Localize("MPUI_CREATE_HIGHLIGHTREEL_DESC")
			f8_arg0.body.fileOptionsButton.hintText = Engine.Localize("MENU_FILM_OPTIONS_HINT")
			if CoD.isZombie == false then
				f8_arg0.body.shoutcastFilmButton.hintText = Engine.Localize("MPUI_SHOUTCAST_FILM_DESC")
			end
			if not CoD.isWIIU and f8_arg0.body.renderClipButton then
				f8_arg0.body.renderClipButton.hintText = UIExpression.GetRenderTooltip()
			end
		else
			f8_arg0.body.startFilmButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
			f8_arg0.body.createHighlightReelButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
			if CoD.isZombie == false then
				f8_arg0.body.shoutcastFilmButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
			end
			if not CoD.isWIIU and f8_arg0.body.renderClipButton then
				f8_arg0.body.renderClipButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
			end
		end
		if f8_local0 and f8_local3 then
			if f8_arg0.body.startFilmButton.disabled and Engine.DoesPartyHaveDLCForMap(Dvar.ui_mapname:get()) then
				f8_arg0.body.startFilmButton:enable()
			end
		elseif f8_arg0.body.startFilmButton.disabled == nil then
			f8_arg0.body.startFilmButton:disable()
		end
		if f8_local0 then
			if f8_arg0.body.fileOptionsButton.disabled then
				f8_arg0.body.fileOptionsButton:enable()
			end
		elseif f8_arg0.body.fileOptionsButton.disabled == nil then
			f8_arg0.body.fileOptionsButton:disable()
		end
		if f8_local0 and f8_local5 and f8_local3 and f8_local7 <= 1 then
			if f8_arg0.body.createHighlightReelButton.disabled then
				f8_arg0.body.createHighlightReelButton:enable()
			end
		elseif f8_arg0.body.createHighlightReelButton.disabled == nil then
			f8_arg0.body.createHighlightReelButton:disable()
		end
		if CoD.isZombie == false then
			if f8_local0 and f8_local5 and f8_local3 and f8_local7 <= 1 then
				if f8_arg0.body.shoutcastFilmButton.disabled then
					f8_arg0.body.shoutcastFilmButton:enable()
				end
			elseif f8_arg0.body.shoutcastFilmButton.disabled == nil then
				f8_arg0.body.shoutcastFilmButton:disable()
			end
		end
		if not CoD.isWIIU and f8_arg0.body.renderClipButton then
			if f8_local0 and f8_local9 and f8_local8 and f8_local3 and f8_local7 <= 1 then
				if f8_arg0.body.renderClipButton.disabled then
					f8_arg0.body.renderClipButton:enable()
				end
			elseif f8_arg0.body.renderClipButton.disabled == nil then
				f8_arg0.body.renderClipButton:disable()
			end
		end
	end
end

CoD.TheaterLobby.UpdateButtonPaneButtons = function (f9_arg0, f9_arg1)
	CoD.TheaterLobby.UpdateLobbyButtons(f9_arg0, f9_arg1)
	f9_arg0.body.mapInfoImage:theaterUpdate(CoD.PrivateGameLobby.IsHost(f9_arg0, f9_arg0.panelManager.ownerController), UIExpression.DvarString(f9_arg0.controller, "ui_mapname"), UIExpression.DvarString(f9_arg0.controller, "ui_gametype"))
end

CoD.TheaterLobby.ButtonListButtonGainFocus = function (f10_arg0, f10_arg1)
	f10_arg0:dispatchEventToParent({
		name = "add_party_privacy_button"
	})
	CoD.Lobby.ButtonListButtonGainFocus(f10_arg0, f10_arg1)
end

CoD.TheaterLobby.ButtonListAddButton = function (f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	local f11_local0 = CoD.Lobby.ButtonListAddButton(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	f11_local0:registerEventHandler("gain_focus", CoD.TheaterLobby.ButtonListButtonGainFocus)
	return f11_local0
end

CoD.TheaterLobby.AddButtonPaneElements = function (f12_arg0)
	CoD.LobbyPanes.addButtonPaneElements(f12_arg0)
	f12_arg0.body.buttonList.addButton = CoD.TheaterLobby.ButtonListAddButton
end

CoD.TheaterLobby.PopulateButtonPaneElements = function (f13_arg0)
	CoD.TheaterLobby.PopulateButtons(f13_arg0)
	CoD.TheaterLobby.UpdateButtonPaneButtons(f13_arg0, nil)
end

CoD.TheaterLobby.AddLobbyPaneElements = function (f14_arg0)
	CoD.PrivateGameLobby.AddLobbyPaneElements(f14_arg0, nil, 0)
end

CoD.TheaterLobby.GameLobbyUpdate = function (f15_arg0, f15_arg1)
	if f15_arg0.mapInfoImage ~= nil then
		f15_arg0.mapInfoImage:theaterUpdate(CoD.PrivateGameLobby.IsHost(f15_arg0, f15_arg0.panelManager.ownerController), UIExpression.DvarString(f15_arg1.controller, "ui_mapname"), UIExpression.DvarString(f15_arg1.controller, "ui_gametype"))
	end
	CoD.PrivateGameLobby.PopulateButtonPrompts(f15_arg0)
	f15_arg0:dispatchEventToChildren(f15_arg1)
end

CoD.TheaterLobby.TheaterLobbyUpdate = function (f16_arg0, f16_arg1)
	f16_arg0.updateLobbyButtons(f16_arg0.buttonPane, f16_arg1)
	if f16_arg0.buttonPane.body ~= nil and f16_arg0.buttonPane.body.mapInfoImage.theaterUpdate ~= nil then
		f16_arg0.buttonPane.body.mapInfoImage:theaterUpdate(CoD.PrivateGameLobby.IsHost(f16_arg0, f16_arg0.panelManager.ownerController), UIExpression.DvarString(f16_arg0.controller, "ui_mapname"), UIExpression.DvarString(f16_arg0.controller, "ui_gametype"), f16_arg1.downloadPercent, f16_arg1.areAllPlayersReadyToLoadDemo)
	end
end

CoD.TheaterLobby.LeaveLobby = function (f17_arg0, f17_arg1)
	Engine.ExecNow(f17_arg1.controller, "demo_abortfilesharedownload")
	Engine.SetTheaterFileInfo(false)
	CoD.PrivateGameLobby.LeaveLobby(f17_arg0, f17_arg1)
end

CoD.TheaterLobby.ButtonBack = function (f18_arg0, f18_arg1)
	CoD.Lobby.ConfirmLeaveGameLobby(f18_arg0, {
		controller = f18_arg1.controller,
		leaveLobbyHandler = CoD.TheaterLobby.LeaveLobby
	})
end

CoD.TheaterLobby.OpenCodtv = function (f19_arg0, f19_arg1)
	if Engine.IsLivestreamEnabled() then
		f19_arg0:openPopup("CODTv_Error", f19_arg1.controller)
		return 
	elseif Engine.IsCodtvContentLoaded() == true then
		CoD.perController[f19_arg1.controller].codtvRoot = "community"
		f19_arg0:openPopup("CODTv", f19_arg1.controller)
	end
end

CoD.TheaterLobby.OpenSelectFilm = function (f20_arg0, f20_arg1)
	if Engine.IsCodtvContentLoaded() == true then
		CoD.perController[f20_arg1.controller].codtvRoot = "recents"
		f20_arg0:openPopup("CODTv", f20_arg1.controller)
	end
end

CoD.TheaterLobby.StartFilm = function (f21_arg0, f21_arg1)
	Engine.Exec(f21_arg1.controller, "xpartyplaydemo")
end

CoD.TheaterLobby.CreateHighlightReel = function (f22_arg0, f22_arg1)
	Engine.Exec(f22_arg1.controller, "demo_play film.demo CreateHighlightReel")
end

CoD.TheaterLobby.ShoutcastFilm = function (f23_arg0, f23_arg1)
	Engine.Exec(f23_arg1.controller, "demo_play film.demo Shoutcast")
end

CoD.TheaterLobby.FileOptions_Save = function (f24_arg0, f24_arg1)
	local f24_local0 = Engine.GetDemoStreamedDownloadProgress()
	CoD.perController[f24_arg1.controller].fileshareSaveFileID = CoD.TheaterLobby.m_fileInfo.fileID
	CoD.perController[f24_arg1.controller].fileshareSaveCategory = CoD.TheaterLobby.m_fileInfo.category
	CoD.perController[f24_arg1.controller].fileshareGameType = Dvar.ui_gametype:get()
	CoD.perController[f24_arg1.controller].fileshareSaveMap = Dvar.ui_mapname:get()
	CoD.perController[f24_arg1.controller].fileshareSaveName = CoD.TheaterLobby.m_fileInfo.name
	CoD.perController[f24_arg1.controller].fileshareSaveDescription = CoD.TheaterLobby.m_fileInfo.description
	CoD.perController[f24_arg1.controller].fileshareSaveIsCopy = true
	CoD.perController[f24_arg1.controller].fileshareSaveIsPooled = CoD.TheaterLobby.m_fileInfo.isPooled
	CoD.perController[f24_arg1.controller].fileshareZmMapStartLocation = nil
	CoD.perController[f24_arg1.controller].fileshareZmMapStartLocationName = nil
	CoD.perController[f24_arg1.controller].fileshareSaveSkipThumbnail = true
	f24_arg0:openPopup("FileshareSave", f24_arg1.controller)
end

CoD.TheaterLobby.FileOptions_LikeDislike = function (f25_arg0, f25_arg1)
	CoD.perController[f25_arg1.controller].voteData = {
		fileID = CoD.TheaterLobby.m_fileInfo.fileID,
		category = CoD.TheaterLobby.m_fileInfo.category,
		map = Dvar.ui_mapname:get(),
		gameType = Dvar.ui_gametype:get(),
		fromLobby = true,
		description = CoD.TheaterLobby.m_fileInfo.description,
		name = CoD.TheaterLobby.m_fileInfo.name
	}
	CoD.perController[f25_arg1.controller].voteUpdateTarget = f25_arg0
	local f25_local0 = f25_arg0:openPopup("FileshareVote", f25_arg1.controller)
end

CoD.TheaterLobby.RenderClip = function (f26_arg0, f26_arg1)
	if CoD.isPC and (not Engine.IsYouTubeAccountChecked(f26_arg1.controller) or not Engine.IsYouTubeAccountRegistered(f26_arg1.controller)) then
		f26_arg0:openPopup("YouTube_Connect", f26_arg1.controller, {
			mode = "render"
		})
	else
		CoD.perController[f26_arg1.controller].fileshareSaveCategory = "render"
		CoD.perController[f26_arg1.controller].fileshareSaveIsCopy = false
		CoD.perController[f26_arg1.controller].fileshareSaveIsPooled = false
		CoD.perController[f26_arg1.controller].fileshareSaveMap = Dvar.ui_mapname:get()
		CoD.perController[f26_arg1.controller].fileshareSaveName = CoD.TheaterLobby.m_fileInfo.name
		CoD.perController[f26_arg1.controller].fileshareSaveDescription = CoD.TheaterLobby.m_fileInfo.description
		CoD.perController[f26_arg1.controller].fileshareSaveMatchID = CoD.TheaterLobby.m_fileInfo.matchID
		f26_arg0:openPopup("FileshareSave", f26_arg1.controller)
	end
end

CoD.TheaterLobby.RenderComplete = function (f27_arg0, f27_arg1)
	local f27_local0 = {}
	if f27_arg1.cancelled ~= nil and f27_arg1.cancelled == true then
		f27_local0.message = Engine.Localize("MENU_RENDER_CANCELLED")
	elseif f27_arg1.success ~= nil and f27_arg1.success == true then
		f27_local0.message = Engine.Localize("MENU_RENDER_SUCCESS", Dvar.fshRenderSuccessURL:get())
	else
		f27_local0.message = Engine.Localize("MENU_RENDER_FAILED")
	end
	Engine.ExecNow(f27_arg1.controller, "demo_clearrenderflag")
	f27_arg0:openPopup("popup_render_complete", f27_arg1.controller, f27_local0)
end

