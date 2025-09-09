require("T6.Menus.PrivateGameLobby")
require("T6.MapInfoImage")
require("T6.Menus.CODTv")
CoD.TheaterLobby = {}
CoD.TheaterLobby.m_fileInfo = {}

LUI.createMenu.TheaterLobby = function (LocalClientIndex, f1_arg1)
	local TheaterLobbyWidget = CoD.PrivateGameLobby.New("TheaterLobby", LocalClientIndex)
	TheaterLobbyWidget:setPreviousMenu("MainLobby")
	TheaterLobbyWidget.controller = LocalClientIndex
	Engine.Exec(LocalClientIndex, "vote_getHistory")
	TheaterLobbyWidget.addButtonPaneElements = CoD.TheaterLobby.AddButtonPaneElements
	TheaterLobbyWidget.populateButtonPaneElements = CoD.TheaterLobby.PopulateButtonPaneElements
	TheaterLobbyWidget.addLobbyPaneElements = CoD.TheaterLobby.AddLobbyPaneElements
	TheaterLobbyWidget.updateLobbyButtons = CoD.TheaterLobby.UpdateLobbyButtons
	TheaterLobbyWidget.populateButtons = CoD.TheaterLobby.PopulateButtons
	TheaterLobbyWidget:updatePanelFunctions()
	TheaterLobbyWidget:registerEventHandler("theaterlobby_update", CoD.TheaterLobby.TheaterLobbyUpdate)
	TheaterLobbyWidget:registerEventHandler("button_prompt_back", CoD.TheaterLobby.ButtonBack)
	TheaterLobbyWidget:registerEventHandler("gamelobby_update", CoD.TheaterLobby.GameLobbyUpdate)
	TheaterLobbyWidget:registerEventHandler("button_prompt_team_prev", nil)
	TheaterLobbyWidget:registerEventHandler("button_prompt_team_next", nil)
	TheaterLobbyWidget:registerEventHandler("start_film", CoD.TheaterLobby.StartFilm)
	TheaterLobbyWidget:registerEventHandler("create_highlight_reel", CoD.TheaterLobby.CreateHighlightReel)
	TheaterLobbyWidget:registerEventHandler("shoutcast_film", CoD.TheaterLobby.ShoutcastFilm)
	TheaterLobbyWidget:registerEventHandler("open_select_film", CoD.TheaterLobby.OpenSelectFilm)
	TheaterLobbyWidget:registerEventHandler("open_codtv", CoD.TheaterLobby.OpenCodtv)
	TheaterLobbyWidget:registerEventHandler("render_clip", CoD.TheaterLobby.RenderClip)
	TheaterLobbyWidget:registerEventHandler("film_options_flyout", CoD.TheaterLobby.OpenFilmOptionsFlyout)
	TheaterLobbyWidget:registerEventHandler("film_options_save", CoD.TheaterLobby.FileOptions_Save)
	TheaterLobbyWidget:registerEventHandler("film_options_likedislike", CoD.TheaterLobby.FileOptions_LikeDislike)
	TheaterLobbyWidget:registerEventHandler("theater_render_complete", CoD.TheaterLobby.RenderComplete)
	TheaterLobbyWidget:addTitle(Engine.Localize("MPUI_THEATER_LOBBY_CAPS"))
	TheaterLobbyWidget.panelManager.panels.buttonPane.titleText = TheaterLobbyWidget.titleText
	TheaterLobbyWidget.panelManager.panels.buttonPane.isHost = CoD.PrivateGameLobby.IsHost(TheaterLobbyWidget, LocalClientIndex)
	TheaterLobbyWidget.buttonPane.body.buttonList:removeAllChildren()
	TheaterLobbyWidget.buttonPane.body.statusText:close()
	TheaterLobbyWidget.buttonPane.body.statusText = nil
	TheaterLobbyWidget.buttonPane.body.mapInfoImage:close()
	TheaterLobbyWidget.buttonPane.body.mapInfoImage = nil
	CoD.TheaterLobby.PopulateButtons(TheaterLobbyWidget.buttonPane)
	CoD.TheaterLobby.UpdateButtonPaneButtons(TheaterLobbyWidget.buttonPane, {
		controller = LocalClientIndex
	})
	TheaterLobbyWidget.buttonPane.populatePanelElements = TheaterLobbyWidget.populateButtonPaneElements
	TheaterLobbyWidget.lobbyPane:setSplitscreenSignInAllowed(false)
	if CoD.isZombie then
		if not f1_arg1 or not f1_arg1.parent or f1_arg1.parent ~= "MainLobby" then
			CoD.GameGlobeZombie.MoveToCornerJoinLobby()
		end
		if TheaterLobbyWidget.panelManager.panels.buttonPane.isHost == true then
			TheaterLobbyWidget.buttonPane.body.buttonList:selectElementIndex(2)
		else
			TheaterLobbyWidget.buttonPane.body.buttonList:selectElementIndex(1)
		end
		TheaterLobbyWidget.buttonPane:saveState()
	end
	return TheaterLobbyWidget
end

CoD.TheaterLobby.CanRenderVideo = function (LocalClientIndex)
	if not CoD.isWIIU then
		if CoD.isPS3 and UIExpression.DvarBool(nil, "tu2_luiHacksDisabled") == 0 then
			local UploadBandWidth = tonumber(UIExpression.GetDStat(LocalClientIndex, "uploadBandWidth"))
			if UploadBandWidth then
				UploadBandWidth = UploadBandWidth / 1000
			end
			if UploadBandWidth > 2000 then
				return true
			end
		else
			return true
		end
	end
	return false
end

CoD.TheaterLobby.AddFilmOptionsFlyout = function (TheaterLobbyButtonPane)
	local HorizontalOffset = CoD.PrivateGameLobby.DefaultSetupGameFlyoutLeft + 10
	local VerticalOffset = CoD.Menu.TitleHeight + CoD.MPZM(CoD.CoD9Button.Height * 6 + 2, CoD.CoD9Button.Height * 5 - 4)
	TheaterLobbyButtonPane.body.setupGameFlyoutBG = LUI.UIImage.new()
	TheaterLobbyButtonPane.body.setupGameFlyoutBG:setLeftRight(true, false, -4, HorizontalOffset)
	TheaterLobbyButtonPane.body.setupGameFlyoutBG:setTopBottom(true, false, VerticalOffset, VerticalOffset + CoD.CoD9Button.Height)
	TheaterLobbyButtonPane.body.setupGameFlyoutBG:setRGB(0, 0, 0)
	TheaterLobbyButtonPane.body.setupGameFlyoutBG:setAlpha(0.8)
	TheaterLobbyButtonPane.body.setupGameFlyoutBG:setPriority(-100)
	TheaterLobbyButtonPane.body:addElement(TheaterLobbyButtonPane.body.setupGameFlyoutBG)
	TheaterLobbyButtonPane.body.setupGameFlyoutContainer = LUI.UIElement.new()
	TheaterLobbyButtonPane.body.setupGameFlyoutContainer:setLeftRight(true, false, HorizontalOffset, HorizontalOffset + CoD.ButtonList.DefaultWidth - 20)
	TheaterLobbyButtonPane.body.setupGameFlyoutContainer:setTopBottom(true, false, VerticalOffset, VerticalOffset + CoD.CoD9Button.Height * 5)
	TheaterLobbyButtonPane.body.setupGameFlyoutContainer:setPriority(1000)
	TheaterLobbyButtonPane.body:addElement(TheaterLobbyButtonPane.body.setupGameFlyoutContainer)
	local FlyoutContainerBackground = LUI.UIImage.new()
	FlyoutContainerBackground:setLeftRight(true, true, 0, 0)
	FlyoutContainerBackground:setTopBottom(true, true, 0, 0)
	FlyoutContainerBackground:setRGB(0, 0, 0)
	FlyoutContainerBackground:setAlpha(0.8)
	TheaterLobbyButtonPane.body.setupGameFlyoutContainer:addElement(FlyoutContainerBackground)
	TheaterLobbyButtonPane.body.setupGameFlyoutContainer.buttonList = CoD.ButtonList.new()
	TheaterLobbyButtonPane.body.setupGameFlyoutContainer.buttonList:setLeftRight(true, true, 4, 0)
	TheaterLobbyButtonPane.body.setupGameFlyoutContainer.buttonList:setTopBottom(true, true, 0, 0)
	TheaterLobbyButtonPane.body.setupGameFlyoutContainer:addElement(TheaterLobbyButtonPane.body.setupGameFlyoutContainer.buttonList)
	TheaterLobbyButtonPane.body.setupGameFlyoutContainer.likeDislikeButton = TheaterLobbyButtonPane.body.setupGameFlyoutContainer.buttonList:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_FILESHARE_LIKEDISLIKE")), Engine.Localize("MENU_FILESHARE_LIKEDISLIKE_HINT"))
	TheaterLobbyButtonPane.body.setupGameFlyoutContainer.likeDislikeButton:setActionEventName("film_options_likedislike")
	if CoD.TheaterLobby.m_fileInfo.isPooled == true then
		TheaterLobbyButtonPane.body.setupGameFlyoutContainer.likeDislikeButton.hintText = Engine.Localize("MENU_FILESHARE_LIKEDISLIKE_ERROR")
		TheaterLobbyButtonPane.body.setupGameFlyoutContainer.likeDislikeButton:disable()
	end
	TheaterLobbyButtonPane.body.setupGameFlyoutContainer.saveButton = TheaterLobbyButtonPane.body.setupGameFlyoutContainer.buttonList:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_FILESHARE_SAVE")), Engine.Localize("MENU_FILESHARE_SAVE_FILM_HINT"))
	TheaterLobbyButtonPane.body.setupGameFlyoutContainer.saveButton:setActionEventName("film_options_save")
end

CoD.TheaterLobby.RemoveFilmOptionsFlyout = function (TheaterLobbyButtonPane)
	if TheaterLobbyButtonPane.body.setupGameFlyoutBG ~= nil then
		TheaterLobbyButtonPane.body.setupGameFlyoutBG:close()
		TheaterLobbyButtonPane.body.setupGameFlyoutBG = nil
	end
	if TheaterLobbyButtonPane.body.setupGameFlyoutContainer ~= nil then
		TheaterLobbyButtonPane.body.setupGameFlyoutContainer:close()
		TheaterLobbyButtonPane.body.setupGameFlyoutContainer = nil
	end
end

CoD.TheaterLobby.OpenFilmOptionsFlyout = function (TheaterLobbyWidget, f5_arg1)
	if TheaterLobbyWidget.buttonPane ~= nil and TheaterLobbyWidget.buttonPane.body ~= nil then
		CoD.TheaterLobby.RemoveFilmOptionsFlyout(TheaterLobbyWidget.buttonPane)
		CoD.TheaterLobby.AddFilmOptionsFlyout(TheaterLobbyWidget.buttonPane)
		TheaterLobbyWidget.panelManager.slidingEnabled = false
		CoD.ButtonList.DisableInput(TheaterLobbyWidget.buttonPane.body.buttonList)
		TheaterLobbyWidget.buttonPane.body.buttonList:animateToState("disabled")
		TheaterLobbyWidget.buttonPane.body.setupGameFlyoutContainer:processEvent({
			name = "gain_focus"
		})
		TheaterLobbyWidget:registerEventHandler("button_prompt_back", CoD.TheaterLobby.CloseFilmOptionsFlyout)
	end
end

CoD.TheaterLobby.CloseFilmOptionsFlyout = function (TheaterLobbyWidget, f6_arg1)
	if TheaterLobbyWidget.buttonPane ~= nil and TheaterLobbyWidget.buttonPane.body ~= nil and TheaterLobbyWidget.buttonPane.body.setupGameFlyoutContainer ~= nil then
		CoD.TheaterLobby.RemoveFilmOptionsFlyout(TheaterLobbyWidget.buttonPane)
		CoD.ButtonList.EnableInput(TheaterLobbyWidget.buttonPane.body.buttonList)
		TheaterLobbyWidget.buttonPane.body.buttonList:animateToState("default")
		TheaterLobbyWidget:registerEventHandler("button_prompt_back", CoD.TheaterLobby.ButtonBack)
		TheaterLobbyWidget.panelManager.slidingEnabled = true
		Engine.PlaySound("cac_cmn_backout")
	end
end

CoD.TheaterLobby.PopulateButtons = function (TheaterLobbyButtonPane)
	if TheaterLobbyButtonPane.body == nil then
		return 
	end
	TheaterLobbyButtonPane.body.buttonList:removeAllButtons()
	local IsHost = CoD.PrivateGameLobby.IsHost(TheaterLobbyButtonPane, TheaterLobbyButtonPane.panelManager.ownerController)
	if IsHost == true then
		TheaterLobbyButtonPane.body.startFilmButton = TheaterLobbyButtonPane.body.buttonList:addButton(Engine.Localize("MPUI_START_FILM_CAPS"))
		TheaterLobbyButtonPane.body.startFilmButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
		TheaterLobbyButtonPane.body.startFilmButton:setActionEventName("start_film")
		TheaterLobbyButtonPane.body.startFilmButton:disable()
		TheaterLobbyButtonPane.body.selectFilmButton = TheaterLobbyButtonPane.body.buttonList:addButton(Engine.Localize("MENU_FILESHARE_SELECT_FILM_CAPS"))
		TheaterLobbyButtonPane.body.selectFilmButton.hintText = Engine.Localize("MENU_FILESHARE_SELECT_FILM_DESC")
		TheaterLobbyButtonPane.body.selectFilmButton:setActionEventName("open_select_film")
		TheaterLobbyButtonPane.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2)
		TheaterLobbyButtonPane.body.createHighlightReelButton = TheaterLobbyButtonPane.body.buttonList:addButton(Engine.Localize("MPUI_CREATE_HIGHLIGHT_CAPS"))
		TheaterLobbyButtonPane.body.createHighlightReelButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
		TheaterLobbyButtonPane.body.createHighlightReelButton:setActionEventName("create_highlight_reel")
		TheaterLobbyButtonPane.body.createHighlightReelButton:disable()
		if CoD.isZombie == false then
			TheaterLobbyButtonPane.body.shoutcastFilmButton = TheaterLobbyButtonPane.body.buttonList:addButton(Engine.Localize("MPUI_SHOUTCAST_FILM_CAPS"))
			TheaterLobbyButtonPane.body.shoutcastFilmButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
			TheaterLobbyButtonPane.body.shoutcastFilmButton:setActionEventName("shoutcast_film")
			TheaterLobbyButtonPane.body.shoutcastFilmButton:disable()
		end
		if CoD.TheaterLobby.CanRenderVideo(TheaterLobbyButtonPane.panelManager.ownerController) then
			TheaterLobbyButtonPane.body.renderClipButton = TheaterLobbyButtonPane.body.buttonList:addButton(Engine.Localize("MENU_DEMO_RENDER_CLIP_CAPS"))
			TheaterLobbyButtonPane.body.renderClipButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
			TheaterLobbyButtonPane.body.renderClipButton:setActionEventName("render_clip")
			TheaterLobbyButtonPane.body.renderClipButton:disable()
		end
		TheaterLobbyButtonPane.body.fileOptionsButton = TheaterLobbyButtonPane.body.buttonList:addButton(Engine.Localize("MENU_FILM_OPTIONS"))
		TheaterLobbyButtonPane.body.fileOptionsButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
		TheaterLobbyButtonPane.body.fileOptionsButton:setActionEventName("film_options_flyout")
		TheaterLobbyButtonPane.body.fileOptionsButton:disable()
		TheaterLobbyButtonPane.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2)
	end
	if Engine.IsBetaBuild() then
		TheaterLobbyButtonPane.body.codtvButton = TheaterLobbyButtonPane.body.buttonList:addButton(Engine.Localize("MENU_FILESHARE_COMMUNITY_CAPS"))
		TheaterLobbyButtonPane.body.codtvButton:setActionEventName("open_codtv")
		TheaterLobbyButtonPane.body.codtvButton.hintText = Engine.Localize("MPUI_COD_TV_DESC")
	else
		TheaterLobbyButtonPane.body.codtvButton = TheaterLobbyButtonPane.body.buttonList:addButton(Engine.Localize("MENU_COD_TV_CAPS"))
		TheaterLobbyButtonPane.body.codtvButton.hintText = Engine.Localize("MPUI_COD_TV_DESC")
		TheaterLobbyButtonPane.body.codtvButton:setActionEventName("open_codtv")
	end
	if not Engine.IsBetaBuild() then
		TheaterLobbyButtonPane.body.barracksButton = TheaterLobbyButtonPane.body.buttonList:addButton(Engine.Localize(CoD.MPZM("MENU_BARRACKS_CAPS", "MPUI_LEADERBOARDS_CAPS")))
		CoD.SetupBarracksLock(TheaterLobbyButtonPane.body.barracksButton)
		TheaterLobbyButtonPane.body.barracksButton:setActionEventName("open_barracks")
	end
	if IsHost == true then
		if CoD.isZombie then
			TheaterLobbyButtonPane:restoreState()
		elseif not TheaterLobbyButtonPane:restoreState() then
			TheaterLobbyButtonPane.body.startFilmButton:processEvent({
				name = "gain_focus"
			})
		end
	elseif not TheaterLobbyButtonPane:restoreState() then
		if Engine.IsBetaBuild() then
			TheaterLobbyButtonPane.body.codtvButton:processEvent({
				name = "gain_focus"
			})
		else
			TheaterLobbyButtonPane.body.barracksButton:processEvent({
				name = "gain_focus"
			})
		end
	end
	if TheaterLobbyButtonPane.body.mapInfoImage ~= nil then
		TheaterLobbyButtonPane.body.mapInfoImage:close()
		TheaterLobbyButtonPane.body.mapInfoImage = nil
	end
	local f7_local2 = 350 - CoD.CoD9Button.Height - 0
	TheaterLobbyButtonPane.body.mapInfoImage = CoD.MapInfoImage.new({
		left = 0,
		top = -(f7_local2 / CoD.MapInfoImage.AspectRatio) - CoD.ButtonPrompt.Height - 15,
		right = f7_local2,
		bottom = -CoD.ButtonPrompt.Height - 15,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	})
	TheaterLobbyButtonPane.body.mapInfoImage:setPriority(200)
	TheaterLobbyButtonPane.body.mapInfoImage.id = "TheaterInfo"
	TheaterLobbyButtonPane.body.mapInfoImage.theaterUpdate = CoD.MapInfoImage.TheaterUpdate
	TheaterLobbyButtonPane.body.mapInfoImage:registerEventHandler("gamelobby_update", nil)
	TheaterLobbyButtonPane.body.mapInfoImage:registerEventHandler("gametype_update", nil)
	TheaterLobbyButtonPane.body.mapInfoImage:registerEventHandler("game_options_update", nil)
	TheaterLobbyButtonPane.body.mapInfoImage:registerEventHandler("map_update", nil)
	TheaterLobbyButtonPane.body.mapInfoImage:theaterUpdate(IsHost, UIExpression.DvarString(TheaterLobbyButtonPane.controller, "ui_mapname"), UIExpression.DvarString(TheaterLobbyButtonPane.controller, "ui_gametype"))
	TheaterLobbyButtonPane.body:addElement(TheaterLobbyButtonPane.body.mapInfoImage)
	CoD.PrivateGameLobby.AddDLCWarning(TheaterLobbyButtonPane, IsHost)
end

CoD.TheaterLobby.UpdateLobbyButtons = function (TheaterLobbyButtonPane, ClientInstance)
	if CoD.PrivateGameLobby.IsHost(TheaterLobbyButtonPane, TheaterLobbyButtonPane.panelManager.ownerController) == true and TheaterLobbyButtonPane.body ~= nil then
		if TheaterLobbyButtonPane.body.startFilmButton == nil then
			CoD.TheaterLobby.PopulateButtons(TheaterLobbyButtonPane)
			TheaterLobbyButtonPane.body.barracksButton:processEvent({
				name = "lose_focus"
			})
		end
		local IsDemoNameBlank = UIExpression.DvarString(TheaterLobbyButtonPane.controller, "ui_demoname") ~= ""
		local SignedIntoDemonware, IsCategoryFilm = nil
		local PartyPlayerCount = Engine.PartyGetPlayerCount()
		local f8_local8 = nil
		local CanRenderClip = UIExpression.CanRenderClip() == 1
		if ClientInstance ~= nil then
			if ClientInstance.areAllPlayersReadyToLoadDemo == 0 then
				SignedIntoDemonware = ClientInstance.areAllPlayersReadyToLoadDemo
			else
				SignedIntoDemonware = Engine.IsSignedInToDemonware(TheaterLobbyButtonPane.contoller)
			end
			IsCategoryFilm = ClientInstance.category == "film"
			if ClientInstance.duration ~= nil then
				f8_local8 = ClientInstance.duration <= Dvar.demoRenderDuration:get() * 1000
			else
				f8_local8 = false
			end
			CoD.TheaterLobby.m_fileInfo.name = ClientInstance.fileName
			CoD.TheaterLobby.m_fileInfo.description = ClientInstance.fileDescription
			CoD.TheaterLobby.m_fileInfo.matchID = ClientInstance.matchID
			CoD.TheaterLobby.m_fileInfo.fileID = ClientInstance.fileID
			CoD.TheaterLobby.m_fileInfo.category = ClientInstance.category
			CoD.TheaterLobby.m_fileInfo.isPooled = ClientInstance.isPooled
		else
			SignedIntoDemonware = false
			IsCategoryFilm = false
			f8_local8 = false
		end
		if IsDemoNameBlank then
			TheaterLobbyButtonPane.body.startFilmButton.hintText = Engine.Localize("MPUI_START_FILM_DESC")
			TheaterLobbyButtonPane.body.createHighlightReelButton.hintText = Engine.Localize("MPUI_CREATE_HIGHLIGHTREEL_DESC")
			TheaterLobbyButtonPane.body.fileOptionsButton.hintText = Engine.Localize("MENU_FILM_OPTIONS_HINT")
			if CoD.isZombie == false then
				TheaterLobbyButtonPane.body.shoutcastFilmButton.hintText = Engine.Localize("MPUI_SHOUTCAST_FILM_DESC")
			end
			if not CoD.isWIIU and TheaterLobbyButtonPane.body.renderClipButton then
				TheaterLobbyButtonPane.body.renderClipButton.hintText = UIExpression.GetRenderTooltip()
			end
		else
			TheaterLobbyButtonPane.body.startFilmButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
			TheaterLobbyButtonPane.body.createHighlightReelButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
			if CoD.isZombie == false then
				TheaterLobbyButtonPane.body.shoutcastFilmButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
			end
			if not CoD.isWIIU and TheaterLobbyButtonPane.body.renderClipButton then
				TheaterLobbyButtonPane.body.renderClipButton.hintText = Engine.Localize("MENU_THEATER_LOAD_HINT")
			end
		end
		if IsDemoNameBlank and SignedIntoDemonware then
			if TheaterLobbyButtonPane.body.startFilmButton.disabled and Engine.DoesPartyHaveDLCForMap(Dvar.ui_mapname:get()) then
				TheaterLobbyButtonPane.body.startFilmButton:enable()
			end
		elseif TheaterLobbyButtonPane.body.startFilmButton.disabled == nil then
			TheaterLobbyButtonPane.body.startFilmButton:disable()
		end
		if IsDemoNameBlank then
			if TheaterLobbyButtonPane.body.fileOptionsButton.disabled then
				TheaterLobbyButtonPane.body.fileOptionsButton:enable()
			end
		elseif TheaterLobbyButtonPane.body.fileOptionsButton.disabled == nil then
			TheaterLobbyButtonPane.body.fileOptionsButton:disable()
		end
		if IsDemoNameBlank and IsCategoryFilm and SignedIntoDemonware and PartyPlayerCount <= 1 then
			if TheaterLobbyButtonPane.body.createHighlightReelButton.disabled then
				TheaterLobbyButtonPane.body.createHighlightReelButton:enable()
			end
		elseif TheaterLobbyButtonPane.body.createHighlightReelButton.disabled == nil then
			TheaterLobbyButtonPane.body.createHighlightReelButton:disable()
		end
		if CoD.isZombie == false then
			if IsDemoNameBlank and IsCategoryFilm and SignedIntoDemonware and PartyPlayerCount <= 1 then
				if TheaterLobbyButtonPane.body.shoutcastFilmButton.disabled then
					TheaterLobbyButtonPane.body.shoutcastFilmButton:enable()
				end
			elseif TheaterLobbyButtonPane.body.shoutcastFilmButton.disabled == nil then
				TheaterLobbyButtonPane.body.shoutcastFilmButton:disable()
			end
		end
		if not CoD.isWIIU and TheaterLobbyButtonPane.body.renderClipButton then
			if IsDemoNameBlank and CanRenderClip and f8_local8 and SignedIntoDemonware and PartyPlayerCount <= 1 then
				if TheaterLobbyButtonPane.body.renderClipButton.disabled then
					TheaterLobbyButtonPane.body.renderClipButton:enable()
				end
			elseif TheaterLobbyButtonPane.body.renderClipButton.disabled == nil then
				TheaterLobbyButtonPane.body.renderClipButton:disable()
			end
		end
	end
end

CoD.TheaterLobby.UpdateButtonPaneButtons = function (TheaterLobbyButtonPane, ClientInstance)
	CoD.TheaterLobby.UpdateLobbyButtons(TheaterLobbyButtonPane, ClientInstance)
	TheaterLobbyButtonPane.body.mapInfoImage:theaterUpdate(CoD.PrivateGameLobby.IsHost(TheaterLobbyButtonPane, TheaterLobbyButtonPane.panelManager.ownerController), UIExpression.DvarString(TheaterLobbyButtonPane.controller, "ui_mapname"), UIExpression.DvarString(TheaterLobbyButtonPane.controller, "ui_gametype"))
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

CoD.TheaterLobby.AddButtonPaneElements = function (TheaterLobbyButtonPane)
	CoD.LobbyPanes.addButtonPaneElements(TheaterLobbyButtonPane)
	TheaterLobbyButtonPane.body.buttonList.addButton = CoD.TheaterLobby.ButtonListAddButton
end

CoD.TheaterLobby.PopulateButtonPaneElements = function (TheaterLobbyButtonPane)
	CoD.TheaterLobby.PopulateButtons(TheaterLobbyButtonPane)
	CoD.TheaterLobby.UpdateButtonPaneButtons(TheaterLobbyButtonPane, nil)
end

CoD.TheaterLobby.AddLobbyPaneElements = function (f14_arg0)
	CoD.PrivateGameLobby.AddLobbyPaneElements(f14_arg0, nil, 0)
end

CoD.TheaterLobby.GameLobbyUpdate = function (TheaterLobbyWidget, ClientInstance)
	if TheaterLobbyWidget.mapInfoImage ~= nil then
		TheaterLobbyWidget.mapInfoImage:theaterUpdate(CoD.PrivateGameLobby.IsHost(TheaterLobbyWidget, TheaterLobbyWidget.panelManager.ownerController), UIExpression.DvarString(ClientInstance.controller, "ui_mapname"), UIExpression.DvarString(ClientInstance.controller, "ui_gametype"))
	end
	CoD.PrivateGameLobby.PopulateButtonPrompts(TheaterLobbyWidget)
	TheaterLobbyWidget:dispatchEventToChildren(ClientInstance)
end

CoD.TheaterLobby.TheaterLobbyUpdate = function (TheaterLobbyWidget, ClientInstance)
	TheaterLobbyWidget.updateLobbyButtons(TheaterLobbyWidget.buttonPane, ClientInstance)
	if TheaterLobbyWidget.buttonPane.body ~= nil and TheaterLobbyWidget.buttonPane.body.mapInfoImage.theaterUpdate ~= nil then
		TheaterLobbyWidget.buttonPane.body.mapInfoImage:theaterUpdate(CoD.PrivateGameLobby.IsHost(TheaterLobbyWidget, TheaterLobbyWidget.panelManager.ownerController), UIExpression.DvarString(TheaterLobbyWidget.controller, "ui_mapname"), UIExpression.DvarString(TheaterLobbyWidget.controller, "ui_gametype"), ClientInstance.downloadPercent, ClientInstance.areAllPlayersReadyToLoadDemo)
	end
end

CoD.TheaterLobby.LeaveLobby = function (TheaterLobbyWidget, ClientInstance)
	Engine.ExecNow(ClientInstance.controller, "demo_abortfilesharedownload")
	Engine.SetTheaterFileInfo(false)
	CoD.PrivateGameLobby.LeaveLobby(TheaterLobbyWidget, ClientInstance)
end

CoD.TheaterLobby.ButtonBack = function (TheaterLobbyWidget, ClientInstance)
	CoD.Lobby.ConfirmLeaveGameLobby(TheaterLobbyWidget, {
		controller = ClientInstance.controller,
		leaveLobbyHandler = CoD.TheaterLobby.LeaveLobby
	})
end

CoD.TheaterLobby.OpenCodtv = function (TheaterLobbyWidget, ClientInstance)
	if Engine.IsLivestreamEnabled() then
		TheaterLobbyWidget:openPopup("CODTv_Error", ClientInstance.controller)
		return 
	elseif Engine.IsCodtvContentLoaded() == true then
		CoD.perController[ClientInstance.controller].codtvRoot = "community"
		TheaterLobbyWidget:openPopup("CODTv", ClientInstance.controller)
	end
end

CoD.TheaterLobby.OpenSelectFilm = function (TheaterLobbyWidget, ClientInstance)
	if Engine.IsCodtvContentLoaded() == true then
		CoD.perController[ClientInstance.controller].codtvRoot = "recents"
		TheaterLobbyWidget:openPopup("CODTv", ClientInstance.controller)
	end
end

CoD.TheaterLobby.StartFilm = function (f21_arg0, ClientInstance)
	Engine.Exec(ClientInstance.controller, "xpartyplaydemo")
end

CoD.TheaterLobby.CreateHighlightReel = function (f22_arg0, ClientInstance)
	Engine.Exec(ClientInstance.controller, "demo_play film.demo CreateHighlightReel")
end

CoD.TheaterLobby.ShoutcastFilm = function (f23_arg0, ClientInstance)
	Engine.Exec(ClientInstance.controller, "demo_play film.demo Shoutcast")
end

CoD.TheaterLobby.FileOptions_Save = function (TheaterLobbyWidget, ClientInstance)
	CoD.perController[ClientInstance.controller].fileshareSaveFileID = CoD.TheaterLobby.m_fileInfo.fileID
	CoD.perController[ClientInstance.controller].fileshareSaveCategory = CoD.TheaterLobby.m_fileInfo.category
	CoD.perController[ClientInstance.controller].fileshareGameType = Dvar.ui_gametype:get()
	CoD.perController[ClientInstance.controller].fileshareSaveMap = Dvar.ui_mapname:get()
	CoD.perController[ClientInstance.controller].fileshareSaveName = CoD.TheaterLobby.m_fileInfo.name
	CoD.perController[ClientInstance.controller].fileshareSaveDescription = CoD.TheaterLobby.m_fileInfo.description
	CoD.perController[ClientInstance.controller].fileshareSaveIsCopy = true
	CoD.perController[ClientInstance.controller].fileshareSaveIsPooled = CoD.TheaterLobby.m_fileInfo.isPooled
	CoD.perController[ClientInstance.controller].fileshareZmMapStartLocation = nil
	CoD.perController[ClientInstance.controller].fileshareZmMapStartLocationName = nil
	CoD.perController[ClientInstance.controller].fileshareSaveSkipThumbnail = true
	TheaterLobbyWidget:openPopup("FileshareSave", ClientInstance.controller)
end

CoD.TheaterLobby.FileOptions_LikeDislike = function (TheaterLobbyWidget, ClientInstance)
	CoD.perController[ClientInstance.controller].voteData = {
		fileID = CoD.TheaterLobby.m_fileInfo.fileID,
		category = CoD.TheaterLobby.m_fileInfo.category,
		map = Dvar.ui_mapname:get(),
		gameType = Dvar.ui_gametype:get(),
		fromLobby = true,
		description = CoD.TheaterLobby.m_fileInfo.description,
		name = CoD.TheaterLobby.m_fileInfo.name
	}
	CoD.perController[ClientInstance.controller].voteUpdateTarget = TheaterLobbyWidget
	local f25_local0 = TheaterLobbyWidget:openPopup("FileshareVote", ClientInstance.controller)
end

CoD.TheaterLobby.RenderClip = function (TheaterLobbyWidget, ClientInstance)
	if CoD.isPC and (not Engine.IsYouTubeAccountChecked(ClientInstance.controller) or not Engine.IsYouTubeAccountRegistered(ClientInstance.controller)) then
		TheaterLobbyWidget:openPopup("YouTube_Connect", ClientInstance.controller, {
			mode = "render"
		})
	else
		CoD.perController[ClientInstance.controller].fileshareSaveCategory = "render"
		CoD.perController[ClientInstance.controller].fileshareSaveIsCopy = false
		CoD.perController[ClientInstance.controller].fileshareSaveIsPooled = false
		CoD.perController[ClientInstance.controller].fileshareSaveMap = Dvar.ui_mapname:get()
		CoD.perController[ClientInstance.controller].fileshareSaveName = CoD.TheaterLobby.m_fileInfo.name
		CoD.perController[ClientInstance.controller].fileshareSaveDescription = CoD.TheaterLobby.m_fileInfo.description
		CoD.perController[ClientInstance.controller].fileshareSaveMatchID = CoD.TheaterLobby.m_fileInfo.matchID
		TheaterLobbyWidget:openPopup("FileshareSave", ClientInstance.controller)
	end
end

CoD.TheaterLobby.RenderComplete = function (TheaterLobbyWidget, ClientInstance)
	local RenderStatusMessage = {}
	if ClientInstance.cancelled ~= nil and ClientInstance.cancelled == true then
		RenderStatusMessage.message = Engine.Localize("MENU_RENDER_CANCELLED")
	elseif ClientInstance.success ~= nil and ClientInstance.success == true then
		RenderStatusMessage.message = Engine.Localize("MENU_RENDER_SUCCESS", Dvar.fshRenderSuccessURL:get())
	else
		RenderStatusMessage.message = Engine.Localize("MENU_RENDER_FAILED")
	end
	Engine.ExecNow(ClientInstance.controller, "demo_clearrenderflag")
	TheaterLobbyWidget:openPopup("popup_render_complete", ClientInstance.controller, RenderStatusMessage)
end

