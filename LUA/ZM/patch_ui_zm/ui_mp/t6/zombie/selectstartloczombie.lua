CoD.SelectStartLocZombie = {}
CoD.SelectStartLocZombie.StartLocInfoWidth = 400
CoD.SelectStartLocZombie.StartLocInfoHeight = 200
CoD.SelectStartLocZombie.StartLocInfoNewWidth = 64
CoD.SelectStartLocZombie.StartLocInfoNewHeight = 32
CoD.SelectStartLocZombie.StartLocInfoNewMaterial = "menu_mp_lobby_new_small"
CoD.SelectStartLocZombie.StartLocIconPulseDurationMax = 800
CoD.SelectStartLocZombie.StartLocIconPulseDurationMin = 400
CoD.SelectStartLocZombie.StartLocIconPulseAlphaHighMin = 0.7
CoD.SelectStartLocZombie.StartLocIconPulseAlphaLowMax = 0.3
CoD.SelectStartLocZombie.StartLocOptionInfoWidth = 225
CoD.SelectStartLocZombie.StartLocOptionInfoHeight = 200
if CoD.Zombie.miniGameDisabled == false then
	CoD.SelectStartLocZombie.ZombieDotCount = 60
	CoD.SelectStartLocZombie.ZombieDotLeftMax = 600
	CoD.SelectStartLocZombie.ZombieDotTopMax = 300
	CoD.SelectStartLocZombie.ZombieDotWidth = 6
	CoD.SelectStartLocZombie.ZombieDotHeight = 6
	CoD.SelectStartLocZombie.ZombieDotMovingSpeed = 0
	CoD.SelectStartLocZombie.ZombieDotMovingDirMax = 180
	CoD.SelectStartLocZombie.ZombieDotPathNodeCount = 10
	CoD.SelectStartLocZombie.ZombieDotPathNodes = {}
	CoD.SelectStartLocZombie.ZombieDotPathNodes[1] = {
		left = -350,
		top = -100,
		radius = 30
	}
	CoD.SelectStartLocZombie.ZombieDotPathNodes[2] = {
		left = -350,
		top = 100,
		radius = 30
	}
	CoD.SelectStartLocZombie.ZombieDotPathNodes[3] = {
		left = -100,
		top = 188,
		radius = 30
	}
	CoD.SelectStartLocZombie.ZombieDotPathNodes[4] = {
		left = 100,
		top = 188,
		radius = 30
	}
	CoD.SelectStartLocZombie.ZombieDotPathNodes[5] = {
		left = 350,
		top = 100,
		radius = 30
	}
	CoD.SelectStartLocZombie.ZombieDotPathNodes[6] = {
		left = 350,
		top = -100,
		radius = 30
	}
	CoD.SelectStartLocZombie.ZombieDotPathNodes[7] = {
		left = 150,
		top = -200,
		radius = 30
	}
	CoD.SelectStartLocZombie.ZombieDotPathNodes[8] = {
		left = -150,
		top = -200,
		radius = 30
	}
	CoD.SelectStartLocZombie.ZombieDotPathNodes[9] = {
		left = 150,
		top = 0,
		radius = 30
	}
	CoD.SelectStartLocZombie.ZombieDotPathNodes[10] = {
		left = -150,
		top = 0,
		radius = 30
	}
end
LUI.createMenu.SelectStartLocZM = function (f1_arg0)
	CoD.Fog.SetGameMap(f1_arg0, Dvar.ui_mapname:get())
	local f1_local0 = CoD.Zombie.GetUIMapName()
	if f1_local0 == CoD.Zombie.MAP_ZM_HIGHRISE then
		CoD.SelectStartLocZombie.StartLocInfoWidth = 1280
		CoD.SelectStartLocZombie.StartLocInfoHeight = 720
	elseif f1_local0 == CoD.Zombie.MAP_ZM_PRISON then
		CoD.SelectStartLocZombie.StartLocInfoWidth = 640
		CoD.SelectStartLocZombie.StartLocInfoHeight = 360
	elseif f1_local0 == CoD.Zombie.MAP_ZM_BURIED then
		CoD.SelectStartLocZombie.StartLocInfoWidth = 426
		CoD.SelectStartLocZombie.StartLocInfoHeight = 426
	else
		CoD.SelectStartLocZombie.StartLocInfoWidth = 400
		CoD.SelectStartLocZombie.StartLocInfoHeight = 200
	end
	local f1_local1 = CoD.Menu.New("SelectStartLocZM")
	f1_local1.m_ownerController = f1_arg0
	f1_local1:setPreviousMenu("SelectMapZM")
	f1_local1:registerEventHandler("open_menu", CoD.SelectStartLocZombie.OpenMenu)
	f1_local1:registerEventHandler("startloc_option_selected", CoD.SelectStartLocZombie.StartLocOptionSelected)
	f1_local1.isPublicMatch = Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH)
	if f1_local1.isPublicMatch then
		f1_local1:registerEventHandler("partylobby_update", CoD.SelectStartLocZombie.PartyLobbyUpdate)
	end
	if CoD.useMouse then
		f1_local1:registerEventHandler("startloc_mouseover", CoD.SelectStartLocZombie.StartLocMouseOver)
		f1_local1:registerEventHandler("startloc_mouseclick", CoD.SelectStartLocZombie.StartLocMouseClick)
	end
	f1_local1:registerEventHandler("button_prompt_search_preferences", CoD.SelectStartLocZombie.ButtonPromptSearchPreferences)
	f1_local1.addSearchPreferencesButton = CoD.SelectStartLocZombie.AddSearchPreferencesButtonPrompt
	f1_local1:addSelectButton()
	f1_local1:addBackButton()
	if f1_local1.isPublicMatch and CoD.PlaylistCategoryFilter ~= CoD.Zombie.PLAYLIST_CATEGORY_FILTER_SOLOMATCH then
		f1_local1:addSearchPreferencesButton()
	end
	f1_local1:registerEventHandler("button_prompt_back", CoD.SelectStartLocZombie.BackButton)
	if not f1_local1.isPublicMatch or Engine.PartyGetMemberCount() > 0 then
		CoD.SelectStartLocZombie.PopulateStartLocs(f1_local1, f1_arg0)
	end
	CoD.GameGlobeZombie.gameGlobe.currentMenu = f1_local1
	CoD.GameMapZombie.gameMap.currentMenu = f1_local1
	if CoD.Zombie.miniGameDisabled == false then
		f1_local1.zombieDots = {}
		f1_local1.zombieDotContainer = LUI.UIElement.new()
		f1_local1.zombieDotContainer:setAlpha(0)
		f1_local1.zombieDotContainer:setLeftRight(true, true, 0, 0)
		f1_local1.zombieDotContainer:setTopBottom(true, true, 0, 0)
		f1_local1:addElement(f1_local1.zombieDotContainer)
		local f1_local2 = RegisterMaterial("menu_zm_map_zombie_dot")
		for f1_local3 = 1, CoD.SelectStartLocZombie.ZombieDotCount, 1 do
			local f1_local6 = math.random(-CoD.SelectStartLocZombie.ZombieDotLeftMax, CoD.SelectStartLocZombie.ZombieDotLeftMax)
			local f1_local7 = math.random(-CoD.SelectStartLocZombie.ZombieDotTopMax, CoD.SelectStartLocZombie.ZombieDotTopMax)
			local f1_local8 = LUI.UIImage.new()
			f1_local8:setLeftRight(false, false, f1_local6, f1_local6 + CoD.SelectStartLocZombie.ZombieDotWidth)
			f1_local8:setTopBottom(false, false, f1_local7, f1_local7 + CoD.SelectStartLocZombie.ZombieDotHeight)
			f1_local8:setImage(f1_local2)
			f1_local8.currentPathNodeIndex = CoD.SelectStartLocZombie.ZombieMoveFindClosestNodeIndex(f1_local6, f1_local7)
			f1_local8:registerEventHandler("transition_complete_zombie_move", CoD.SelectStartLocZombie.ZombieMoveFinish)
			f1_local1.zombieDotContainer:addElement(f1_local8)
			f1_local1.zombieDots[f1_local3] = f1_local8
		end
	end
	return f1_local1
end

CoD.SelectStartLocZombie.ButtonPromptSearchPreferences = function (f2_arg0, f2_arg1)
	f2_arg0:openPopup("SearchPreferences", f2_arg1.controller)
end

CoD.SelectStartLocZombie.AddSearchPreferencesButtonPrompt = function (f3_arg0)
	local f3_local0 = CoD.ButtonPrompt.new
	local f3_local1 = "alt1"
	local f3_local2 = Engine.Localize("MPUI_SEARCH_PREFERENCES")
	local f3_local3 = f3_arg0
	local f3_local4 = "button_prompt_search_preferences"
	local f3_local5, f3_local6 = false
	local f3_local7, f3_local8 = false
	f3_arg0.searchPreferencesButton = f3_local0(f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6, f3_local7, f3_local8, "S")
	f3_arg0:addRightButtonPrompt(f3_arg0.searchPreferencesButton)
end

CoD.SelectStartLocZombie.OpenMenu = function (f4_arg0, f4_arg1)
	if f4_arg1.menuName ~= nil and CoD.Zombie.OpenMenuEventMenuNames[f4_arg1.menuName] == 1 then
		if f4_arg0.skipOpenMenuEvent == true then
			if f4_arg1.menuName == "MainLobby" and f4_arg0.isPublicMatch == true then
				CoD.SwitchToPlayerMatchLobby(f4_arg1.controller)
			end
		else
			CoD.GameGlobeZombie.MoveToCornerFromUp(f4_arg1.controller)
			CoD.Lobby.OpenMenu(f4_arg0, f4_arg1)
		end
	end
	f4_arg0.skipOpenMenuEvent = nil
end

CoD.SelectStartLocZombie.PartyLobbyUpdate = function (f5_arg0, f5_arg1)
	if f5_arg0 == nil then
		return 
	elseif f5_arg1 ~= nil and f5_arg1.actualPartyMemberCount ~= nil and f5_arg1.actualPartyMemberCount > 0 and not f5_arg0.startLocsPopulated then
		CoD.SwitchToPlayerMatchLobby(f5_arg1.controller)
		CoD.SelectStartLocZombie.PopulateStartLocs(f5_arg0, f5_arg1.controller)
		CoD.SelectStartLocZombie.GoToPreChoices(f5_arg0, f5_arg1)
	end
	f5_arg0:dispatchEventToChildren(f5_arg1)
end

CoD.SelectStartLocZombie.PopulateStartLocs = function (f6_arg0, f6_arg1)
	f6_arg0.startLocsPopulated = true
	if f6_arg0.isPublicMatch then
		f6_arg0.totalStartLocationPlayerCount = 0
		f6_arg0.totalStartLocationOptionPlayerCount = 0
		if CoD.PlaylistCategoryFilter == nil then
			CoD.PlaylistCategoryFilter = Engine.GetPlaylistCategoryFilter(f6_arg1, Engine.GetPlaylistID())
		end
	end
	f6_arg0.startLocInfos = {}
	local f6_local0 = CoD.SelectStartLocZombie.GetStartLocs(f6_arg0, f6_arg1)
	f6_arg0.startLocCount = 0
	local f6_local1 = {
		leftAnchor = false,
		rightAnchor = false,
		left = -CoD.Menu.Width * 0.5,
		right = CoD.Menu.Width * 0.5,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.Menu.Height * 0.5,
		bottom = CoD.Menu.Height * 0.5
	}
	local Widget = LUI.UIElement.new(f6_local1)
	f6_arg0:addElement(Widget)
	Widget.handleGamepadButton = CoD.SelectStartLocZombie.StartLocGamepadButton
	f6_arg0.startLocContainer = Widget
	f6_arg0.startLocContainer.currentMenu = f6_arg0
	
	local startLocNewOverlayContainer = LUI.UIElement.new(f6_local1)
	startLocNewOverlayContainer:setAlpha(0)
	f6_arg0:addElement(startLocNewOverlayContainer)
	f6_arg0.startLocNewOverlayContainer = startLocNewOverlayContainer
	
	startLocNewOverlayContainer:registerAnimationState("show", {
		alpha = 1
	})
	startLocNewOverlayContainer:registerAnimationState("hide", {
		alpha = 0
	})
	local f6_local4 = nil
	for f6_local18, f6_local19 in pairs(f6_local0) do
		if not f6_arg0.isPublicMatch or f6_local19.filter == CoD.PlaylistCategoryFilter then
			local f6_local8, f6_local9 = string.gsub(f6_local19.ref, "_solo", "", 1)
			f6_local4 = f6_local9
			f6_local19.ref = f6_local8
			f6_local8 = tonumber(UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 8))
			f6_local9 = tonumber(UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 9))
			local f6_local10 = tonumber(UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 17))
			local f6_local11 = tonumber(UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 18))
			local Widget = LUI.UIElement.new({
				leftAnchor = false,
				rightAnchor = false,
				left = -CoD.SelectStartLocZombie.StartLocInfoWidth * 0.5 + f6_local8,
				right = CoD.SelectStartLocZombie.StartLocInfoWidth * 0.5 + f6_local8,
				topAnchor = false,
				bottomAnchor = false,
				top = -CoD.SelectStartLocZombie.StartLocInfoHeight * 0.5 + f6_local9,
				bottom = CoD.SelectStartLocZombie.StartLocInfoHeight * 0.5 + f6_local9,
				alpha = 0
			})
			Widget:addElement(Widget)
			Widget.startLocIcon = LUI.UIStreamedImage.new({
				leftAnchor = true,
				rightAnchor = true,
				left = 0,
				right = 0,
				topAnchor = true,
				bottomAnchor = true,
				top = 0,
				bottom = 0,
				alpha = 0
			})
			Widget:addElement(Widget.startLocIcon)
			Widget.newImage = LUI.UIImage.new()
			Widget.newImage:setLeftRight(false, false, -CoD.SelectStartLocZombie.StartLocInfoNewWidth * 0.5 + f6_local10, CoD.SelectStartLocZombie.StartLocInfoNewWidth * 0.5 + f6_local10)
			Widget.newImage:setTopBottom(false, false, -CoD.SelectStartLocZombie.StartLocInfoNewHeight * 0.5 + f6_local11, CoD.SelectStartLocZombie.StartLocInfoNewHeight * 0.5 + f6_local11)
			Widget.newImage:setAlpha(1)
			Widget.newImage:setRGB(1, 1, 1)
			Widget.newImage:setImage(RegisterMaterial(CoD.SelectStartLocZombie.StartLocInfoNewMaterial))
			startLocNewOverlayContainer:addElement(Widget.newImage)
			if CoD.SelectStartLocZombie.SeenStartLocation(f6_arg1, CoD.Zombie.GetUIMapName(), f6_local19.ref) then
				Widget.newImage:setAlpha(0)
			end
			Widget:registerAnimationState("hide", {
				alpha = 0
			})
			Widget:registerAnimationState("show", {
				alpha = 1
			})
			Widget:registerAnimationState("disabled", {
				alpha = 0.1
			})
			Widget.startLocIcon:setImage(RegisterMaterial(UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 6)))
			Widget.startLocIcon:setAlpha(0)
			Widget.startLocIcon:setupUIStreamedImage(0)
			Widget.startLocIcon:registerAnimationState("show_default", {
				alpha = 0
			})
			Widget.startLocIcon:registerAnimationState("show_selected", {
				alpha = 1
			})
			Widget.startLocIcon:registerEventHandler("transition_complete_selected_pulse_high", CoD.SelectStartLocZombie.StartLocIconPulseHighFinish)
			Widget.startLocIcon:registerEventHandler("transition_complete_selected_pulse_low", CoD.SelectStartLocZombie.StartLocIconPulseLowFinish)
			Widget.name = f6_local19.name
			Widget.ref = f6_local19.ref
			Widget.description = UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 5)
			Widget.image = RegisterMaterial(UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 6))
			Widget.startLocX = f6_local8
			Widget.startLocY = f6_local9
			Widget.startLocOptionX = UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 10)
			Widget.startLocOptionY = UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 11)
			Widget.leftStartLoc = UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 12)
			Widget.rightStartLoc = UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 13)
			Widget.upStartLoc = UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 14)
			Widget.downStartLoc = UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 15)
			if f6_arg0.isPublicMatch then
				Widget.playlists = f6_local19.playlists
				if CoD.PlaylistCategoryFilter == "playermatch" then
					Widget.playerCount = f6_local19.playerCount
					f6_arg0.totalStartLocationPlayerCount = f6_arg0.totalStartLocationPlayerCount + f6_local19.playerCount
				end
			end
			Widget.currentMenu = f6_arg0
			f6_arg0.startLocCount = f6_arg0.startLocCount + 1
			Widget.index = f6_arg0.startLocCount
			f6_arg0.startLocInfos[f6_arg0.startLocCount] = Widget
			if CoD.Zombie.miniGameDisabled == false then
				CoD.SelectStartLocZombie.ZombieDotPathNodeCount = CoD.SelectStartLocZombie.ZombieDotPathNodeCount + 1
				CoD.SelectStartLocZombie.ZombieDotPathNodes[CoD.SelectStartLocZombie.ZombieDotPathNodeCount] = {
					left = f6_local8,
					top = f6_local9,
					radius = 50
				}
			end
			if CoD.useMouse then
				local f6_local13 = UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 19)
				local f6_local14 = UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 20)
				local f6_local15 = UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 21)
				local f6_local16 = UIExpression.TableLookup(f6_arg1, CoD.gametypesTable, 0, 5, 3, f6_local19.ref, 22)
				local Widget = LUI.UIElement.new()
				if f6_local13 ~= "" and f6_local14 ~= "" and f6_local15 ~= "" and f6_local16 ~= "" then
					Widget:setLeftRight(false, false, -f6_local15 * 0.5 + f6_local13, f6_local15 * 0.5 + f6_local13)
					Widget:setTopBottom(false, false, -f6_local16 * 0.5 + f6_local14, f6_local16 * 0.5 + f6_local14)
				else
					Widget:setLeftRight(true, true, 0, 0)
					Widget:setTopBottom(true, true, 0, 0)
				end
				Widget.startLocInfo = Widget
				Widget:setHandleMouse(true)
				Widget:registerEventHandler("mouseenter", CoD.SelectStartLocZombie.StartLocInfoMouseListener_MouseEnter)
				Widget:registerEventHandler("leftmouseup", CoD.SelectStartLocZombie.StartLocInfoMouseListener_LeftMouseUp)
				Widget:registerEventHandler("leftmousedown", CoD.NullFunction)
				Widget:addElement(Widget)
			end
		end
	end
	f6_arg0.startLocOptionInfo = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -CoD.SelectStartLocZombie.StartLocOptionInfoWidth * 0.5,
		right = CoD.SelectStartLocZombie.StartLocOptionInfoWidth * 0.5,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.SelectStartLocZombie.StartLocOptionInfoHeight * 0.5,
		bottom = CoD.SelectStartLocZombie.StartLocOptionInfoHeight * 0.5,
		alpha = 0
	})
	f6_arg0.startLocOptionInfo:registerAnimationState("hide", {
		alpha = 0
	})
	f6_arg0.startLocOptionInfo.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = CoD.SelectStartLocZombie.StartLocOptionInfoWidth,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.SelectStartLocZombie.StartLocOptionInfoHeight
	})
	f6_arg0.startLocOptionInfo:addElement(f6_arg0.startLocOptionInfo.buttonList)
	f6_arg0:addElement(f6_arg0.startLocOptionInfo)
	if f6_arg0.isPublicMatch and CoD.PlaylistCategoryFilter == "playermatch" then
		Widget.playerCount = LUI.UIText.new()
		Widget.playerCount:setLeftRight(true, false, 0, 0)
		Widget.playerCount:setTopBottom(false, true, -30 - CoD.textSize.Big, -30)
		Widget.playerCount:setFont(CoD.fonts.Big)
		Widget.playerCount:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		Widget:addElement(Widget.playerCount)
	end
	CoD.SelectStartLocZombie.SetCurrentStartLocInfoIndex(f6_arg0)
	f6_arg0.isGameTypeListOpenned = false
	f6_arg0.isBackToStartLoc = false
	f6_arg0.m_inputDisabled = true
end

CoD.SelectStartLocZombie.GetStartLocs = function (f7_arg0, f7_arg1, f7_arg2)
	if f7_arg0 and f7_arg0.isPublicMatch == true then
		if CoD.Zombie.PlayListCurrentSuperCategoryIndex == nil then
			CoD.Zombie.PlayListCurrentSuperCategoryIndex = Engine.GetPlaylistSuperCategoryID(Engine.GetPlaylistID())
		end
		return Engine.GetPlaylistCategories(CoD.Zombie.PlayListCurrentSuperCategoryIndex)
	end
	local f7_local0 = CoD.Zombie.GetUIMapName()
	if f7_arg2 then
		f7_local0 = f7_arg2
	end
	local f7_local1 = Engine.GetStartLocsZombie(f7_local0)
	for f7_local9, f7_local10 in pairs(f7_local1) do
		local f7_local11 = Engine.GetGamemodesZombie(f7_local0, f7_local10.ref)
		local f7_local5 = false
		for f7_local6, f7_local7 in pairs(f7_local11) do
			if Engine.HasDLCContent(UIExpression.TableLookup(nil, CoD.gametypesTable, 2, f7_local0, 3, f7_local10.ref, 4, f7_local7.ref, 5)) then
				f7_local5 = true
				break
			end
		end
		if not f7_local5 then
			f7_local1[f7_local9] = nil
		end
	end
	return f7_local1
end

CoD.SelectStartLocZombie.StartLocInfoSelectedFromMap = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg0.startLocInfos[f8_arg0.currentStartLocIndex]
	f8_arg0.selectedMapStartLocation = f8_local0.ref
	Engine.Exec(f8_arg1.controller, "xupdatepartystate")
	f8_local0.startLocIcon:completeAnimation()
	f8_local0.startLocIcon:setAlpha(1)
	CoD.SelectStartLocZombie.ShowStartLocOptionList(f8_arg0, f8_arg0.currentStartLocIndex, f8_arg1)
	CoD.GameMapZombie.SwitchToMapDirect(2, true, 500)
	CoD.SelectStartLocZombie.DisableNonSelectedStartLoc(f8_arg0)
	CoD.Fog.Hide(500)
end

CoD.SelectStartLocZombie.StartLocGamepadButton = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0.currentMenu
	if f9_local0.m_inputDisabled or f9_local0.m_ownerController ~= f9_arg1.controller then
		return 
	end
	local f9_local1 = true
	if f9_arg1.down == true then
		local f9_local2 = f9_local0.currentStartLocIndex
		local f9_local3 = nil
		if f9_arg1.button == "primary" then
			Engine.PlaySound("zmb_ui_map_level_select")
			CoD.SelectStartLocZombie.StartLocInfoSelectedFromMap(f9_local0, f9_arg1)
			if f9_local0.startLocNewOverlayContainer then
				f9_local0.startLocNewOverlayContainer:animateToState("hide")
			end
		else
			f9_local3 = CoD.SelectStartLocZombie.GetNextStartLoc(f9_local0, f9_arg1)
		end
		if f9_local3 ~= nil and f9_local2 ~= f9_local0.currentStartLocIndex then
			CoD.SelectStartLocZombie.GoToStartLoc(f9_local0, f9_local2, f9_local0.currentStartLocIndex)
		end
	end
	if CoD.isPC and f9_arg1.button == "key_shortcut" and f9_arg1.key == "F9" then
		return f9_arg0:dispatchEventToChildren(f9_arg1)
	end
	return true
end

CoD.SelectStartLocZombie.DisableNonSelectedStartLoc = function (f10_arg0)
	for f10_local0 = 1, f10_arg0.startLocCount, 1 do
		if f10_local0 ~= f10_arg0.currentStartLocIndex then
			f10_arg0.startLocInfos[f10_local0]:animateToState("disabled", 300)
		end
	end
	if CoD.Zombie.miniGameDisabled == false then
		f10_arg0.zombieDotContainer:setAlpha(0)
	end
end

CoD.SelectStartLocZombie.SetCurrentStartLocInfoIndex = function (f11_arg0)
	local f11_local0 = Dvar.ui_zm_mapstartlocation:get()
	local f11_local1 = nil
	if f11_local0 == "" then
		f11_local0 = CoD.Zombie.START_LOCATION_TRANSIT
	end
	f11_arg0.selectedMapStartLocation = f11_local0
	for f11_local2 = 1, f11_arg0.startLocCount, 1 do
		if f11_local0 == f11_arg0.startLocInfos[f11_local2].ref then
			f11_arg0.currentStartLocIndex = f11_local2
			break
		end
	end
	if f11_arg0.currentStartLocIndex == nil then
		f11_arg0.currentStartLocIndex = 1
	end
end

CoD.SelectStartLocZombie.GetNextStartLoc = function (f12_arg0, f12_arg1)
	local f12_local0 = f12_arg0.startLocInfos[f12_arg0.currentStartLocIndex]
	local f12_local1, f12_local2 = nil
	local f12_local3 = 0
	if f12_arg1.button == "left" then
		f12_local1 = f12_local0.leftStartLoc
	elseif f12_arg1.button == "right" then
		f12_local1 = f12_local0.rightStartLoc
	elseif f12_arg1.button == "up" then
		f12_local1 = f12_local0.upStartLoc
	elseif f12_arg1.button == "down" then
		f12_local1 = f12_local0.downStartLoc
	end
	if f12_local1 ~= "none" then
		for f12_local4 = 1, f12_arg0.startLocCount, 1 do
			if f12_arg0.startLocInfos[f12_local4].ref == f12_local1 then
				f12_local3 = f12_local4
			end
		end
		if f12_local3 > 0 then
			f12_arg0.currentStartLocIndex = f12_local3
		end
	end
	return f12_arg0.startLocInfos[f12_arg0.currentStartLocIndex]
end

CoD.SelectStartLocZombie.BackButton = function (f13_arg0, f13_arg1)
	if f13_arg0.m_ownerController ~= f13_arg1.controller then
		return true
	elseif not f13_arg0.m_inputDisabled then
		if f13_arg0.isBackToStartLoc == true then
			f13_arg0.startLocOptionInfo:animateToState("hide")
			f13_arg0.startLocContainer.m_inputDisabled = false
			f13_arg0.startLocOptionInfo.m_inputDisabled = true
			f13_arg0.isBackToStartLoc = false
			CoD.GameMapZombie.SwitchToMapDirect(2, false, 500)
			CoD.SelectStartLocZombie.ShowStartLoc(f13_arg0)
			CoD.Fog.Show(500)
			if f13_arg0.startLocNewOverlayContainer ~= nil then
				f13_arg0.startLocNewOverlayContainer:animateToState("show")
			end
			if CoD.useMouse then
				f13_arg0.startLocOptionInfo.buttonList:registerEventHandler("leftmouseup_outside", nil)
			end
		else
			CoD.GameGlobeZombie.MoveDownShow(f13_arg1.controller)
			CoD.SelectStartLocZombie.HideStartLoc(f13_arg0)
			if f13_arg0.startLocNewOverlayContainer ~= nil then
				f13_arg0.startLocNewOverlayContainer:animateToState("hide")
			end
		end
	end
end

CoD.SelectStartLocZombie.GetStartLocOptions = function (f14_arg0, f14_arg1)
	if f14_arg0.isPublicMatch == true then
		return f14_arg0.startLocInfos[f14_arg1].playlists
	else
		return Engine.GetGamemodesZombie(CoD.Zombie.GetUIMapName(), f14_arg0.selectedMapStartLocation)
	end
end

CoD.SelectStartLocZombie.ShowStartLocOptionList = function (f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = f15_arg2.controller
	local f15_local1 = f15_arg0.startLocInfos[f15_arg1]
	local f15_local2 = f15_arg0.startLocOptionInfo
	f15_local2.buttonList:removeAllButtons()
	local f15_local3 = nil
	if f15_arg0.isPublicMatch == true then
		f15_local3 = UIExpression.ProfileInt(f15_local0, "playlist_" .. CoD.PlaylistCategoryFilter)
		f15_arg0.totalStartLocationOptionPlayerCount = 0
	else
		f15_local3 = UIExpression.DvarString(nil, "ui_gametype")
	end
	local f15_local4 = nil
	local f15_local5 = CoD.SelectStartLocZombie.GetStartLocOptions(f15_arg0, f15_arg1)
	local f15_local6 = 0
	for f15_local16, f15_local17 in ipairs(f15_local5) do
		local f15_local10 = f15_local17.name
		if f15_local17.ref == CoD.Zombie.GAMETYPE_ZCLASSIC then
			f15_local10 = "ZMUI_" .. f15_local17.ref .. "_" .. CoD.Zombie.GetUIMapName() .. "_CAPS"
		end
		local f15_local11 = f15_local2.buttonList:addButton(Engine.Localize(f15_local10))
		f15_local11.name = f15_local10
		if f15_arg0.isPublicMatch == true then
			f15_local11.ref = f15_local17.index
			f15_local11.hintText = Engine.Localize(f15_local17.description)
			f15_local11.image = f15_local17.icon
			if CoD.PlaylistCategoryFilter == "playermatch" then
				f15_local11.playerCount = f15_local17.playerCount
				f15_arg0.totalStartLocationOptionPlayerCount = f15_arg0.totalStartLocationOptionPlayerCount + f15_local17.playerCount
			end
		else
			f15_local11.ref = f15_local17.ref
			f15_local11.gameTypeGroup = UIExpression.TableLookup(f15_local0, CoD.gametypesTable, 0, 0, 1, f15_local17.ref, 9)
			f15_local11.hintText = Engine.Localize(UIExpression.TableLookup(f15_local0, CoD.gametypesTable, 0, 0, 1, f15_local17.ref, 3) .. "_" .. f15_local1.ref)
			f15_local11.image = RegisterMaterial(UIExpression.TableLookup(f15_local0, CoD.gametypesTable, 0, 0, 1, f15_local17.ref, 4))
		end
		f15_local11.startLocation = f15_local1.ref
		local f15_local12 = nil
		if f15_arg0.isPublicMatch then
			f15_local12 = Engine.GetPlaylistGameType(f15_local0, f15_local17.index)
		else
			f15_local12 = f15_local17.ref
		end
		f15_local11.gameType = f15_local12
		local f15_local13 = UIExpression.TableLookup(f15_local0, CoD.gametypesTable, 2, CoD.Zombie.GetUIMapName(), 3, f15_local1.ref, 4, f15_local12, 6)
		local f15_local14 = CoD.SelectStartLocZombie.SeenGameModeMap(f15_local0, CoD.Zombie.GetUIMapName(), f15_local1.ref, f15_local12)
		if f15_local13 == "left" then
			f15_local11:showZMNewIcon(not f15_local14, nil, true)
		elseif f15_local13 == "right" then
			f15_local11:showZMNewIcon(not f15_local14, nil, false)
		end
		f15_local11:registerEventHandler("button_action", CoD.SelectStartLocZombie.StartLocOptionButton)
		f15_local11:registerEventHandler("gain_focus", CoD.SelectStartLocZombie.StartLocOptionButtonGainFocus)
		f15_local11.currentMenu = f15_arg0
		if f15_local4 == nil then
			f15_local4 = f15_local11
		end
		if f15_local3 == f15_local11.ref then
			f15_local4 = f15_local11
		end
		f15_local6 = f15_local6 + 1
		if f15_arg0.isPublicMatch == false then
			if CoD.Zombie.GameTypeGroups[f15_local11.gameType].maxPlayers < Engine.PartyGetPlayerCount() then
				f15_local11:disable()
			end
		end
		local f15_local15 = CoD.Zombie.GameTypeGroups[f15_local11.gameType].maxTeamPlayers
		if f15_local15 and f15_local15 < Engine.PartyGetPlayerCount() then
			f15_local11:disable()
		end
	end
	if CoD.useController then
		f15_local4:processEvent({
			name = "gain_focus"
		})
	end
	f15_local7 = f15_local1.startLocOptionX
	f15_local8 = f15_local7 + CoD.SelectStartLocZombie.StartLocOptionInfoWidth
	f15_local9 = f15_local1.startLocOptionY
	f15_local2:registerAnimationState("show", {
		leftAnchor = false,
		rightAnchor = false,
		left = f15_local7,
		right = f15_local8,
		topAnchor = false,
		bottomAnchor = false,
		top = f15_local9,
		bottom = f15_local9 + (CoD.CoD9Button.Height + CoD.ButtonList.ButtonSpacing) * f15_local6,
		alpha = 1
	})
	f15_local2:animateToState("show")
	f15_arg0.startLocContainer.m_inputDisabled = true
	f15_local2.m_inputDisabled = false
	f15_arg0.isBackToStartLoc = true
	f15_arg0.isGameTypeListOpenned = true
	if CoD.useMouse then
		f15_local2.buttonList:setHandleMouseButton(true)
		f15_local2.buttonList:registerEventHandler("setup_flyout_back", CoD.SelectStartLocZombie.SetupFlyoutBack)
		f15_local2.buttonList:addElement(LUI.UITimer.new(25, {
			name = "setup_flyout_back",
			controller = f15_arg2.controller
		}, true))
	end
end

CoD.SelectStartLocZombie.SetupFlyoutBack = function (f16_arg0, f16_arg1)
	f16_arg0:registerEventHandler("leftmouseup_outside", CoD.SelectStartLocZombie.FlyoutBack)
end

CoD.SelectStartLocZombie.FlyoutBack = function (f17_arg0, f17_arg1)
	f17_arg0:registerEventHandler("leftmouseup_outside", nil)
	f17_arg0:dispatchEventToParent({
		name = "button_prompt_back",
		controller = f17_arg1.controller
	})
end

CoD.SelectStartLocZombie.StartLocOptionButtonGainFocus = function (f18_arg0, f18_arg1)
	CoD.CoD9Button.GainFocus(f18_arg0, f18_arg1)
	if f18_arg0.currentMenu.isPublicMatch and CoD.PlaylistCategoryFilter == "playermatch" then
		f18_arg0.currentMenu.startLocContainer.playerCount:setText(Engine.Localize("ZMUI_GAMETYPE_USER_COUNT", UIExpression.FormatNumberWithCommas(nil, f18_arg0.playerCount), UIExpression.FormatNumberWithCommas(nil, f18_arg0.currentMenu.totalStartLocationOptionPlayerCount), f18_arg0.name))
	end
end

CoD.SelectStartLocZombie.GoToStartLoc = function (f19_arg0, f19_arg1, f19_arg2)
	if 0 < f19_arg1 then
		local f19_local0 = f19_arg0.startLocInfos[f19_arg1]
		f19_local0.startLocIcon:animateToState("show_default")
		f19_local0.newImage:animateToState("show_default")
	end
	local f19_local0 = f19_arg0.startLocInfos[f19_arg2]
	f19_local0.startLocIcon:animateToState("show_selected")
	f19_local0.newImage:animateToState("show_selected")
	CoD.SelectStartLocZombie.StartLocIconStartPulse(f19_local0.startLocIcon)
	f19_arg0.startLocNewOverlayContainer:animateToState("show")
	if f19_arg0.isPublicMatch == true and CoD.PlaylistCategoryFilter == "playermatch" then
		f19_arg0.startLocContainer.playerCount:setText(Engine.Localize("ZMUI_START_LOCATION_USER_COUNT", UIExpression.FormatNumberWithCommas(nil, f19_local0.playerCount), UIExpression.FormatNumberWithCommas(nil, f19_arg0.totalStartLocationPlayerCount), f19_local0.name))
	end
	f19_arg0.startLocOptionInfo:animateToState("hide")
	f19_arg0.isGameTypeListOpenned = false
	f19_arg0.startLocOptionInfo.m_inputDisabled = true
	f19_arg0.startLocContainer.m_inputDisabled = false
	Engine.PlaySound("zmb_ui_map_level_switch")
end

CoD.SelectStartLocZombie.StartLocOptionButton = function (f20_arg0, f20_arg1)
	if f20_arg0.currentMenu.isGameTypeListOpenned == true then
		CoD.SelectStartLocZombie.SawGameModeMap(f20_arg1.controller, CoD.Zombie.GetUIMapName(), f20_arg0.startLocation, f20_arg0.gameType)
		f20_arg0:dispatchEventToParent({
			name = "startloc_option_selected",
			controller = f20_arg1.controller,
			ref = f20_arg0.ref,
			group = f20_arg0.gameTypeGroup
		})
	end
end

CoD.SelectStartLocZombie.SetUIMapName = function (f21_arg0, f21_arg1)
	local f21_local0 = Dvar.ui_mapname:get()
	local f21_local1 = Dvar.ui_zm_mapstartlocation:get()
	local f21_local2 = Dvar.ui_gametype:get()
	if f21_local0 ~= "" and string.find(f21_local0, CoD.Zombie.MAP_ZM_TRANSIT) ~= nil then
		if f21_local1 == CoD.Zombie.START_LOCATION_DINER and f21_local2 == CoD.Zombie.GAMETYPE_ZCLEANSED then
			Engine.SetDvar("ui_mapname", CoD.Zombie.MAP_ZM_TRANSIT_DR)
		elseif f21_local1 == CoD.Zombie.START_LOCATION_FARM and f21_local2 == CoD.Zombie.GAMETYPE_ZCLEANSED then
			Engine.SetDvar("ui_mapname", CoD.Zombie.MAP_ZM_TRANSIT_TM)
		elseif f21_local1 == CoD.Zombie.START_LOCATION_TOWN and f21_local2 == CoD.Zombie.GAMETYPE_ZMEAT then
			Engine.SetDvar("ui_mapname", CoD.Zombie.MAP_ZM_TRANSIT_TM)
		elseif f21_local1 == CoD.Zombie.START_LOCATION_TUNNEL and f21_local2 == CoD.Zombie.GAMETYPE_ZMEAT then
			Engine.SetDvar("ui_mapname", CoD.Zombie.MAP_ZM_TRANSIT_TM)
		else
			Engine.SetDvar("ui_mapname", CoD.Zombie.MAP_ZM_TRANSIT)
		end
	end
end

CoD.SelectStartLocZombie.GameTypeSelected = function (f22_arg0, f22_arg1)
	local f22_local0 = Dvar.ui_gametype:get()
	Engine.Exec(f22_arg1.controller, "resetCustomGametype")
	Engine.SetGametype(f22_arg1.ref)
	Engine.SetDvar("ui_gametype", f22_arg1.ref)
	Engine.SetDvar("ui_zm_gamemodegroup", f22_arg1.group)
	Engine.SetDvar("ui_zm_mapstartlocation", f22_arg0.selectedMapStartLocation)
	Engine.Exec(f22_arg1.controller, "xupdatepartystate")
	Engine.SetProfileVar(f22_arg1.controller, CoD.profileKey_gametype, f22_arg1.ref)
	Engine.PartyHostClearUIState()
	Engine.CommitProfileChanges(f22_arg0.m_ownerController)
	CoD.SelectStartLocZombie.SetUIMapName(f22_arg0, f22_arg1)
	if f22_local0 ~= f22_arg1.ref then
		Engine.PartyHostReassignTeams()
	end
	Engine.PartySetMaxPlayerCount(CoD.Zombie.GameTypeGroups[f22_arg1.ref].maxPlayers)
	local f22_local1 = nil
	if UIExpression.SessionMode_IsSystemlinkGame() == 1 then
		f22_local1 = f22_arg0:openMenu("PrivateLocalGameLobby", f22_arg1.controller)
		f22_local1:setPreviousMenu("MainMenu")
		Dvar.party_maxplayers_systemlink:set(CoD.Zombie.GameTypeGroups[f22_arg1.ref].maxPlayers)
		Dvar.party_maxlocalplayers_systemlink:set(CoD.Zombie.GameTypeGroups[f22_arg1.ref].maxLocalPlayers)
	elseif Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == true then
		if CoD.isWIIU then
			local f22_local2 = UIExpression.DvarInt(nil, "party_maxlocalplayers_privatematch")
			if f22_local2 < CoD.Zombie.GameTypeGroups[f22_arg1.ref].maxPlayers then
				Dvar.party_maxplayers:set(f22_local2)
			end
		end
		f22_local1 = f22_arg0:openMenu("SplitscreenGameLobby", f22_arg1.controller)
		f22_local1:setPreviousMenu("MainMenu")
		Dvar.party_maxplayers_local_splitscreen:set(CoD.Zombie.GameTypeGroups[f22_arg1.ref].maxLocalSplitScreenPlayers)
		Dvar.party_maxlocalplayers_local_splitscreen:set(CoD.Zombie.GameTypeGroups[f22_arg1.ref].maxLocalSplitScreenPlayers)
	else
		f22_local1 = f22_arg0:openMenu("PrivateOnlineGameLobby", f22_arg1.controller)
		f22_local1:setPreviousMenu("MainLobby")
		f22_local1:registerAnimationState("hide", {
			alpha = 0
		})
		f22_local1:animateToState("hide")
		f22_local1:registerAnimationState("show", {
			alpha = 1
		})
		f22_local1:animateToState("show", 500)
		Dvar.party_maxplayers_privatematch:set(CoD.Zombie.GameTypeGroups[f22_arg1.ref].maxPlayers)
		Dvar.party_maxlocalplayers_privatematch:set(CoD.Zombie.GameTypeGroups[f22_arg1.ref].maxLocalPlayers)
	end
	Engine.Exec(f22_arg0.partyHostcontroller, "xsessionupdate")
	f22_arg0:close()
	if f22_local1 ~= nil and UIExpression.ProfileInt(f22_arg1.controller, "com_first_time_privategame_host_zm") == 1 and f22_arg1.ref ~= "zcleansed" then
		f22_local1:openPopup("SelectDifficultyLevelZM", f22_arg1.controller)
	end
end

CoD.SelectStartLocZombie.PlaylistSelected = function (f23_arg0, f23_arg1)
	Engine.SetPlaylistID(f23_arg1.ref)
	Engine.SetProfileVar(f23_arg1.controller, "playlist_" .. CoD.PlaylistCategoryFilter, tostring(f23_arg1.ref))
	Engine.PartyHostClearUIState()
	if CoD.PlaylistCategoryFilter == CoD.Zombie.PLAYLIST_CATEGORY_FILTER_SOLOMATCH then
		Engine.ExecNow(f23_arg1.controller, "xstartpartyhost")
	else
		Engine.Exec(f23_arg1.controller, "xstartparty")
	end
	Engine.Exec(f23_arg1.controller, "updategamerprofile")
	local f23_local0 = f23_arg0:openMenu("PublicGameLobby", f23_arg1.controller)
	f23_local0:setPreviousMenu("MainLobby")
	f23_local0:setAlpha(0)
	f23_local0:beginAnimation("show", 500)
	f23_local0:setAlpha(1)
	f23_arg0:close()
end

CoD.SelectStartLocZombie.StartLocOptionSelected = function (f24_arg0, f24_arg1)
	Engine.PlaySound("zmb_ui_map_level_select")
	if f24_arg0.isPublicMatch == true then
		CoD.SelectStartLocZombie.PlaylistSelected(f24_arg0, f24_arg1)
	else
		CoD.SelectStartLocZombie.GameTypeSelected(f24_arg0, f24_arg1)
	end
end

CoD.SelectStartLocZombie.GoToPreChoices = function (f25_arg0, f25_arg1)
	CoD.SelectStartLocZombie.SetCurrentStartLocInfoIndex(f25_arg0)
	local f25_local0 = nil
	for f25_local1 = 1, f25_arg0.startLocCount, 1 do
		f25_local0 = f25_arg0.startLocInfos[f25_local1]
		if f25_arg0.currentStartLocIndex == f25_local1 then
			f25_local0.startLocIcon:animateToState("show_selected")
			CoD.SelectStartLocZombie.ShowStartLocOptionList(f25_arg0, f25_local1, f25_arg1)
			f25_local0:setAlpha(1)
		else
			f25_local0:animateToState("disabled", 300)
		end
	end
	f25_arg0.m_inputDisabled = false
end

CoD.SelectStartLocZombie.ShowStartLoc = function (f26_arg0)
	if f26_arg0.startLocCount == nil then
		return 
	end
	for f26_local0 = 1, f26_arg0.startLocCount, 1 do
		f26_arg0.startLocInfos[f26_local0]:animateToState("show", 300)
	end
	f26_arg0.m_inputDisabled = false
	CoD.SelectStartLocZombie.GoToStartLoc(f26_arg0, 0, f26_arg0.currentStartLocIndex)
	if false == CoD.Zombie.miniGameDisabled then
		CoD.SelectStartLocZombie.ZombieMoveStart(f26_arg0)
	end
end

CoD.SelectStartLocZombie.HideStartLoc = function (f27_arg0)
	if f27_arg0.startLocCount == nil then
		return 
	end
	for f27_local0 = 1, f27_arg0.startLocCount, 1 do
		f27_arg0.startLocInfos[f27_local0]:animateToState("hide")
	end
	f27_arg0.startLocOptionInfo:animateToState("hide")
	if CoD.Zombie.miniGameDisabled == false then
		f27_arg0.zombieDotContainer:setAlpha(0)
	end
end

CoD.SelectStartLocZombie.StartLocIconStartPulse = function (f28_arg0)
	f28_arg0:beginAnimation("selected_pulse_high", math.random(CoD.SelectStartLocZombie.StartLocIconPulseDurationMin, CoD.SelectStartLocZombie.StartLocIconPulseDurationMax))
	f28_arg0:setAlpha(math.max(math.random(), CoD.SelectStartLocZombie.StartLocIconPulseAlphaHighMin))
end

CoD.SelectStartLocZombie.StartLocIconPulseHighFinish = function (f29_arg0, f29_arg1)
	if f29_arg1.interrupted == nil then
		f29_arg0:beginAnimation("selected_pulse_low", math.random(CoD.SelectStartLocZombie.StartLocIconPulseDurationMin, CoD.SelectStartLocZombie.StartLocIconPulseDurationMax))
		f29_arg0:setAlpha(math.min(math.random(), CoD.SelectStartLocZombie.StartLocIconPulseAlphaLowMax))
	end
end

CoD.SelectStartLocZombie.StartLocIconPulseLowFinish = function (f30_arg0, f30_arg1)
	if f30_arg1.interrupted == nil then
		f30_arg0:beginAnimation("selected_pulse_high", math.random(CoD.SelectStartLocZombie.StartLocIconPulseDurationMin, CoD.SelectStartLocZombie.StartLocIconPulseDurationMax))
		f30_arg0:setAlpha(math.max(math.random(), CoD.SelectStartLocZombie.StartLocIconPulseAlphaHighMin))
	end
end

if CoD.Zombie.miniGameDisabled == false then
	CoD.SelectStartLocZombie.ZombieMoveFindClosestNodeIndex = function (f31_arg0, f31_arg1)
		local f31_local0 = 0
		local f31_local1 = 0
		local f31_local2 = 0
		local f31_local3 = 100000000
		local f31_local4 = 1
		for f31_local5 = 1, CoD.SelectStartLocZombie.ZombieDotPathNodeCount, 1 do
			f31_local0 = CoD.SelectStartLocZombie.ZombieDotPathNodes[f31_local5].left - f31_arg0
			f31_local1 = CoD.SelectStartLocZombie.ZombieDotPathNodes[f31_local5].top - f31_arg1
			f31_local2 = f31_local0 * f31_local0 + f31_local1 * f31_local1
			if f31_local2 < f31_local3 then
				f31_local3 = f31_local2
				f31_local4 = f31_local5
			end
		end
		return f31_local4
	end

	CoD.SelectStartLocZombie.ZombieMoveStart = function (f32_arg0)
		f32_arg0.zombieDotContainer:setAlpha(1)
		for f32_local0 = 1, CoD.SelectStartLocZombie.ZombieDotCount, 1 do
			CoD.SelectStartLocZombie.ZombieMoveToNext(f32_arg0.zombieDots[f32_local0])
		end
	end

	CoD.SelectStartLocZombie.ZombieMoveToNext = function (f33_arg0)
		local f33_local0 = CoD.SelectStartLocZombie.ZombieDotPathNodes[f33_arg0.currentPathNodeIndex]
		local f33_local1 = math.random(1, CoD.SelectStartLocZombie.ZombieDotPathNodeCount)
		while f33_local1 == f33_arg0.currentPathNodeIndex do
			f33_local1 = math.random(1, CoD.SelectStartLocZombie.ZombieDotPathNodeCount)
		end
		f33_arg0.currentPathNodeIndex = f33_local1
		local f33_local2 = CoD.SelectStartLocZombie.ZombieDotPathNodes[f33_local1]
		local f33_local3 = math.random(-CoD.SelectStartLocZombie.ZombieDotMovingDirMax, CoD.SelectStartLocZombie.ZombieDotMovingDirMax) * CoD.GameGlobeZombie.DegreesToRadiansScale
		local f33_local4 = f33_local2.radius * math.cos(f33_local3)
		local f33_local5 = f33_local2.radius * math.sin(f33_local3)
		local f33_local6 = f33_local2.left + f33_local4
		local f33_local7 = f33_local2.top + f33_local5
		local f33_local8 = f33_local6 - f33_local0.left
		local f33_local9 = f33_local7 - f33_local0.top
		f33_arg0:beginAnimation("zombie_move", math.sqrt(f33_local8 * f33_local8 + f33_local9 * f33_local9) / CoD.SelectStartLocZombie.ZombieDotMovingSpeed)
		f33_arg0:setLeftRight(false, false, f33_local6, f33_local6 + CoD.SelectStartLocZombie.ZombieDotWidth)
		f33_arg0:setTopBottom(false, false, f33_local7, f33_local7 + CoD.SelectStartLocZombie.ZombieDotHeight)
	end

	CoD.SelectStartLocZombie.ZombieMoveFinish = function (f34_arg0, f34_arg1)
		if f34_arg1.interrupted == nil then
			CoD.SelectStartLocZombie.ZombieMoveToNext(f34_arg0)
		end
	end

end
CoD.SelectStartLocZombie.StartLocMouseOver = function (f35_arg0, f35_arg1)
	CoD.SelectStartLocZombie.GoToStartLoc(f35_arg0, f35_arg0.currentStartLocIndex, f35_arg1.index)
	f35_arg0.currentStartLocIndex = f35_arg1.index
end

CoD.SelectStartLocZombie.StartLocMouseClick = function (f36_arg0, f36_arg1)
	if f36_arg0.currentStartLocIndex ~= f36_arg1.index then
		CoD.SelectStartLocZombie.GoToStartLoc(f36_arg0, f36_arg0.currentStartLocIndex, f36_arg1.index)
		f36_arg0.currentStartLocIndex = f36_arg1.index
	end
	CoD.SelectStartLocZombie.StartLocInfoSelectedFromMap(f36_arg0, f36_arg1)
end

CoD.SelectStartLocZombie.StartLocInfoMouseListener_MouseEnter = function (f37_arg0, f37_arg1)
	f37_arg0:dispatchEventToParent({
		name = "startloc_mouseover",
		controller = f37_arg1.controller,
		index = f37_arg0.startLocInfo.index
	})
end

CoD.SelectStartLocZombie.StartLocInfoMouseListener_LeftMouseUp = function (f38_arg0, f38_arg1)
	f38_arg0:dispatchEventToParent({
		name = "startloc_mouseclick",
		controller = f38_arg1.controller,
		index = f38_arg0.startLocInfo.index
	})
end

local f0_local0 = function (f39_arg0)
	return CoD.BaseN(tonumber(f39_arg0, 10), 2)
end

local f0_local1 = function (f40_arg0)
	return CoD.BaseN(tonumber(f40_arg0, 2), 10)
end

local f0_local2 = function (f41_arg0)
	local f41_local0 = {}
	for f41_local1 = 1, string.len(f41_arg0), 1 do
		f41_local0[f41_local1] = tonumber(string.sub(f41_arg0, -f41_local1, -f41_local1))
	end
	for f41_local1 = string.len(f41_arg0) + 1, 32, 1 do
		f41_local0[f41_local1] = 0
	end
	return f41_local0
end

local f0_local3 = function (f42_arg0)
	return string.reverse(table.concat(f42_arg0, ""))
end

CoD.SelectStartLocZombie.SeenStartMap = function (f43_arg0, f43_arg1)
	if f43_arg1 == nil then
		return nil
	end
	for f43_local3, f43_local4 in pairs(CoD.SelectStartLocZombie.GetStartLocs(nil, f43_arg0, f43_arg1)) do
		if not CoD.SelectStartLocZombie.SeenStartLocation(f43_arg0, f43_arg1, f43_local4.ref) then
			return false
		end
	end
	return true
end

CoD.SelectStartLocZombie.SeenStartLocation = function (f44_arg0, f44_arg1, f44_arg2)
	if f44_arg1 == nil or f44_arg2 == nil then
		return nil
	end
	for f44_local3, f44_local4 in pairs(Engine.GetGamemodesZombie(f44_arg1, f44_arg2)) do
		if not CoD.SelectStartLocZombie.SeenGameModeMap(f44_arg0, f44_arg1, f44_arg2, f44_local4.ref) and Engine.HasDLCContent(UIExpression.TableLookup(nil, CoD.gametypesTable, 2, f44_arg1, 3, f44_arg2, 4, f44_local4.ref, 5)) then
			return false
		end
	end
	return true
end

CoD.SelectStartLocZombie.SawGameModeMap = function (f45_arg0, f45_arg1, f45_arg2, f45_arg3)
	local f45_local0 = f0_local2(f0_local0(UIExpression.ProfileValueAsString(f45_arg0, "unlock_crumbs_zm")))
	local f45_local1 = tonumber(UIExpression.TableLookup(f45_arg0, CoD.gametypesTable, 2, f45_arg1, 3, f45_arg2, 4, f45_arg3, 1))
	if f45_local1 == nil then
		return nil
	else
		f45_local0[f45_local1 + 1] = 1
		Engine.SetProfileVar(f45_arg0, "unlock_crumbs_zm", f0_local1(f0_local3(f45_local0)))
	end
end

CoD.SelectStartLocZombie.SeenGameModeMap = function (f46_arg0, f46_arg1, f46_arg2, f46_arg3)
	local f46_local0 = f0_local2(f0_local0(UIExpression.ProfileValueAsString(f46_arg0, "unlock_crumbs_zm")))
	if CoD.Zombie.GameTypeGroups[f46_arg3] and CoD.Zombie.GameTypeGroups[f46_arg3].minPlayers > Dvar.party_maxplayers:get() then
		return true
	else
		local f46_local1 = tonumber(UIExpression.TableLookup(f46_arg0, CoD.gametypesTable, 2, f46_arg1, 3, f46_arg2, 4, f46_arg3, 1))
		if f46_local1 == nil then
			return nil
		elseif f46_local1 <= 11 then
			return true
		elseif f46_local0[f46_local1 + 1] == 1 then
			return true
		else
			return false
		end
	end
end

