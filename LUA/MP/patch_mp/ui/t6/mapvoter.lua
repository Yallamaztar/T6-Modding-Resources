if CoD == nil then
	CoD = {}
end
CoD.MapVoter = {}
CoD.MapVoter.AspectRatio = 1.5
CoD.MapVoter.FooterHeight = 46
CoD.MapVoter.PreviousButton = function (menu, event)
	Engine.Exec(event.controller, "xpartyveto 2")
	Engine.PlaySound("uin_navigation_vote")
end

CoD.MapVoter.NextButton = function (menu, event)
	Engine.Exec(event.controller, "xpartyveto 1")
	Engine.PlaySound("uin_navigation_vote")
end

CoD.MapVoter.RandomButton = function (menu, event)
	Engine.Exec(event.controller, "xpartyveto 3")
	Engine.PlaySound("uin_navigation_vote")
end

CoD.MapVoter.SetButtonMapImage = function (mapButton, mapname, gametype, state)
	if mapname ~= nil then
		local mapImage = "menu_" .. mapname .. "_map_select_final"
		local gametypeLabel = nil
		if CoD.isZombie == true and mapname ~= "RANDOM" then
			local location = UIExpression.DvarString(nil, "ui_zm_mapstartlocation")
			local gamemodeGroup = UIExpression.DvarString(nil, "ui_zm_gamemodegroup")
			mapImage = "menu_" .. CoD.Zombie.GetMapName(mapname) .. "_" .. gamemodeGroup .. "_" .. location
			if gamemodeGroup ~= CoD.Zombie.GAMETYPEGROUP_ZCLASSIC then
				gametypeLabel = Engine.Localize(UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 5, 3, location, 4))
			end
		end
		mapButton.image:setImage(RegisterMaterial(mapImage))
		mapButton.image:setAlpha(1)
		mapButton.label:setText(UIExpression.ToUpper(nil, Engine.Localize(UIExpression.TableLookup(nil, UIExpression.GetCurrentMapTableName(), 0, mapname, 3))))
		if gametype then
			if gametypeLabel then
				mapButton.gametypeLabel:setText(gametypeLabel .. " / " .. gametype)
			else
				mapButton.gametypeLabel:setText(gametype)
			end
		elseif gametypeLabel then
			mapButton.gametypeLabel:setText(gametypeLabel)
		end
		if state == "NEXT" then
			mapButton.mapTypeLabel:setText(Engine.Localize("MPUI_NEXT_CAPS"))
		elseif state == "PREV" then
			if true == Dvar.party_isPreviousMapVoted:get() then
				mapButton.mapTypeLabel:setText("")
				mapButton.gametypeLabel:setText("")
				mapButton.label:setText(Engine.Localize("MPUI_PREV_DISABLED_CAPS"))
				mapButton.label:setTopBottom(false, true, -CoD.textSize.Default - 5, -5)
				mapButton.label:setRGB(0.5, 0.5, 0.5)
				mapButton.label:setAlpha(0.6)
				mapButton.countContainer:setAlpha(0)
			else
				mapButton.mapTypeLabel:setText(Engine.Localize("MPUI_PREV_CAPS"))
			end
		elseif state == "RANDOM" then
			mapButton.mapTypeLabel:setText(Engine.Localize("MPUI_RANDOM_CAPS"))
			mapButton.gametypeLabel:setText(Engine.Localize("MENU_MODE_CLASSIFIED_CAPS"))
			mapButton.label:setText(Engine.Localize("MENU_MAP_CLASSIFIED_CAPS"))
		end
	end
end

CoD.MapVoter.DisableButton = function (mapButton)
	if mapButton:isInFocus() then
		mapButton:processEvent({
			name = "lose_focus"
		})
		if CoD.useController and mapButton.mapVoter.focusResetElement ~= nil then
			mapButton.mapVoter.focusResetElement:processEvent({
				name = "gain_focus"
			})
		end
	end
	mapButton.m_focusable = nil
	if mapButton.navigation.up then
		mapButton.navigation.up:setLayoutCached(false)
	end
	if mapButton.navigation.down then
		mapButton.navigation.down:setLayoutCached(false)
	end
end

CoD.MapVoter.FadeOut = function (element, fadeTimeMs)
	element:beginAnimation("fade_out", fadeTimeMs)
	element:setAlpha(0)
end

CoD.MapVoter.FadeOutButton = function (mapButton, fadeTimeMs)
	CoD.MapVoter.DisableButton(mapButton)
	CoD.MapVoter.FadeOut(mapButton.image, fadeTimeMs)
	CoD.MapVoter.FadeOut(mapButton.imageHighlight, fadeTimeMs)
	CoD.MapVoter.FadeOut(mapButton.disabledImageHighlight, fadeTimeMs)
	CoD.MapVoter.FadeOut(mapButton.label, fadeTimeMs)
	CoD.MapVoter.FadeOut(mapButton.gametypeLabel, fadeTimeMs)
	CoD.MapVoter.FadeOut(mapButton.countBg, fadeTimeMs)
	CoD.MapVoter.FadeOut(mapButton.count, fadeTimeMs)
	CoD.MapVoter.FadeOut(mapButton.mapTypeLabel, fadeTimeMs)
end

CoD.MapVoter.ExpandButton = function (menu, event)
	local animationTime = nil
	if event ~= nil then
		animationTime = event.duration
	end
	local mapImageRatio = CoD.MapInfoImage.MapImageWidth / CoD.MapInfoImage.MapImageHeight
	local menuMapVoterWidth = menu.mapVoter.width
	local topBottomOffset = menuMapVoterWidth / mapImageRatio
	menu.image:beginAnimation("expand", animationTime, true, true)
	menu.image:setLeftRight(false, false, -menuMapVoterWidth / 2, menuMapVoterWidth / 2)
	menu.image:setTopBottom(true, false, 0, topBottomOffset)
	menu:beginAnimation("expand", animationTime, true, true)
	menu:setTopBottom(true, false, 0, topBottomOffset + CoD.MapVoter.FooterHeight)
	menu:setLeftRight(true, true, 0, 0)
end

CoD.MapVoter.FadeAndExpandButton = function (mapButton, fadeTimeMs)
	CoD.MapVoter.DisableButton(mapButton)
	mapButton.image:beginAnimation("default", fadeTimeMs)
	mapButton.image:setAlpha(1)
	CoD.MapVoter.FadeOut(mapButton.countBg, fadeTimeMs)
	CoD.MapVoter.FadeOut(mapButton.count, fadeTimeMs)
	CoD.MapVoter.FadeOut(mapButton.mapTypeLabel, fadeTimeMs)
	CoD.MapVoter.FadeOut(mapButton.imageHighlight, fadeTimeMs)
	CoD.MapVoter.FadeOut(mapButton.disabledImageHighlight, fadeTimeMs)
	if fadeTimeMs and fadeTimeMs > 0 then
		mapButton:addElement(LUI.UITimer.new(fadeTimeMs, {
			name = "expand",
			duration = fadeTimeMs
		}, true))
	else
		CoD.MapVoter.ExpandButton(mapButton)
	end
end

CoD.MapVoter.ButtonOver = function (menu, event)
	menu.imageHighlight:setAlpha(0.15)
	menu.mapVoteButtonBorder:setAlpha(1)
	if menu.mapVoter and menu.mapVoter.buttonList then
		menu.mapVoter.buttonList:processEvent({
			name = "update_hint_text",
			button = menu
		})
	end
end

CoD.MapVoter.ButtonUp = function (menu, event)
	menu.imageHighlight:setAlpha(0)
	menu.mapVoteButtonBorder:setAlpha(0)
end

CoD.MapVoter.CreateMapVoteButton = function (menu, menuInstance, clientInstance)
	local mapVoteButton = LUI.UIButton.new(menuInstance, clientInstance)
	mapVoteButton:registerEventHandler("button_over", CoD.MapVoter.ButtonOver)
	mapVoteButton:registerEventHandler("button_up", CoD.MapVoter.ButtonUp)
	mapVoteButton:setUseStencil(true)
	mapVoteButton:registerEventHandler("expand", CoD.MapVoter.ExpandButton)
	mapVoteButton.mapVoter = menu
	local f12_local1 = CoD.MapInfoImage.MapImageWidth / CoD.MapInfoImage.MapImageHeight
	local f12_local2 = menu.width + 20
	local f12_local3 = f12_local2 / f12_local1
	mapVoteButton.image = LUI.UIImage.new()
	mapVoteButton.image:setLeftRight(false, false, -f12_local2 / 2, f12_local2 / 2)
	mapVoteButton.image:setTopBottom(false, false, -f12_local3 / 2, f12_local3 / 2)
	mapVoteButton.image:setAlpha(0)
	mapVoteButton:addElement(mapVoteButton.image)
	mapVoteButton.imageHighlight = LUI.UIImage.new()
	mapVoteButton.imageHighlight:setTopBottom(false, false, -menu.height / 2, menu.height / 2)
	mapVoteButton.imageHighlight:setLeftRight(false, false, -menu.width / 2, menu.width / 2)
	mapVoteButton.imageHighlight:setAlpha(0)
	mapVoteButton:addElement(mapVoteButton.imageHighlight)
	mapVoteButton.disabledImageHighlight = LUI.UIImage.new()
	mapVoteButton.disabledImageHighlight:setTopBottom(false, false, -menu.height / 2, menu.height / 2)
	mapVoteButton.disabledImageHighlight:setLeftRight(false, false, -menu.width / 2, menu.width / 2)
	mapVoteButton.disabledImageHighlight:setAlpha(0)
	mapVoteButton.disabledImageHighlight:setRGB(0, 0, 0)
	mapVoteButton:addElement(mapVoteButton.disabledImageHighlight)
	local f12_local4 = menu.width / f12_local1
	local mapVoteButtonFrame = LUI.UIImage.new()
	mapVoteButtonFrame:setLeftRight(true, true, 0, 0)
	mapVoteButtonFrame:setTopBottom(true, false, CoD.MPZM(f12_local4, 0), f12_local4 + CoD.MapVoter.FooterHeight)
	mapVoteButtonFrame:setImage(RegisterMaterial(CoD.MPZM("menu_mp_map_frame", "menu_zm_map_frame")))
	mapVoteButton:addElement(mapVoteButtonFrame)
	mapVoteButton.mapVoteButtonBorder = CoD.Border.new(2, CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b, 0)
	mapVoteButton:addElement(mapVoteButton.mapVoteButtonBorder)
	local f12_local6 = CoD.MPZM(-10, -20)
	local f12_local7 = CoD.MPZM(-2, -14)
	mapVoteButton.label = LUI.UIText.new()
	mapVoteButton.label:setLeftRight(false, true, -menu.width, f12_local6)
	mapVoteButton.label:setTopBottom(false, true, -CoD.textSize.Default - 17 + f12_local7, -17 + f12_local7)
	mapVoteButton:addElement(mapVoteButton.label)
	mapVoteButton.gametypeLabel = LUI.UIText.new()
	mapVoteButton.gametypeLabel:setLeftRight(false, true, -menu.width, f12_local6)
	mapVoteButton.gametypeLabel:setTopBottom(false, true, -CoD.textSize.ExtraSmall + f12_local7, f12_local7)
	mapVoteButton.gametypeLabel:setFont(CoD.fonts.ExtraSmall)
	mapVoteButton:addElement(mapVoteButton.gametypeLabel)
	mapVoteButton.countContainer = LUI.UIElement.new()
	mapVoteButton.countContainer:setLeftRight(true, false, 5, 5 + CoD.textSize.ExtraSmall)
	mapVoteButton.countContainer:setTopBottom(false, true, -CoD.textSize.ExtraSmall - 3, -3)
	mapVoteButton:addElement(mapVoteButton.countContainer)
	mapVoteButton.countBg = LUI.UIImage.new()
	mapVoteButton.countBg:setLeftRight(true, true, 0, 0)
	mapVoteButton.countBg:setTopBottom(true, true, 0, 0)
	mapVoteButton.countBg:setRGB(0, 0, 0)
	mapVoteButton.countBg:setAlpha(1)
	mapVoteButton.countContainer:addElement(mapVoteButton.countBg)
	mapVoteButton.count = LUI.UIText.new()
	mapVoteButton.count:setLeftRight(false, false, -1, 1)
	mapVoteButton.count:setTopBottom(false, true, -CoD.textSize.ExtraSmall, 0)
	mapVoteButton.count:setFont(CoD.fonts.ExtraSmall)
	mapVoteButton.countContainer:addElement(mapVoteButton.count)
	mapVoteButton.count:setText(0)
	mapVoteButton.mapTypeLabel = LUI.UIText.new()
	mapVoteButton.mapTypeLabel:setLeftRight(true, false, 30, menu.width)
	mapVoteButton.mapTypeLabel:setTopBottom(false, true, -CoD.textSize.Default - 1, -1)
	mapVoteButton:addElement(mapVoteButton.mapTypeLabel)
	return mapVoteButton
end

CoD.MapVoter.AnimateVotes = function (mapButton1, mapButton2, mapButton3)
	mapButton1.countBg:beginAnimation("buttonPressed")
	mapButton1.countBg:setRGB(CoD.green.r, CoD.green.g, CoD.green.b)
	mapButton1.mapTypeLabel:beginAnimation("buttonPressed")
	mapButton1.mapTypeLabel:setRGB(CoD.green.r, CoD.green.g, CoD.green.b)
	mapButton1.count:beginAnimation("buttonPressed")
	mapButton1.count:setRGB(0, 0, 0)
	mapButton2.countBg:beginAnimation("default")
	mapButton2.countBg:setRGB(0, 0, 0)
	mapButton2.mapTypeLabel:beginAnimation("default")
	mapButton2.mapTypeLabel:setRGB(1, 1, 1)
	mapButton2.count:beginAnimation("default")
	mapButton2.count:setRGB(1, 1, 1)
	mapButton3.countBg:beginAnimation("default")
	mapButton3.countBg:setRGB(0, 0, 0)
	mapButton3.mapTypeLabel:beginAnimation("default")
	mapButton3.mapTypeLabel:setRGB(1, 1, 1)
	mapButton3.count:beginAnimation("default")
	mapButton3.count:setRGB(1, 1, 1)
end

CoD.MapVoter.DisplayVoteCount = function (menu, previousMapCount, nextMapCount, randomMapCount)
	if menu.body ~= nil then
		menu.body.previousMapButton.count:setText(previousMapCount)
		menu.body.nextMapButton.count:setText(nextMapCount)
		menu.body.randomMapButton.count:setText(randomMapCount)
		if menu.vote == 1 then
			CoD.MapVoter.AnimateVotes(menu.body.nextMapButton, menu.body.previousMapButton, menu.body.randomMapButton)
		elseif menu.vote == 2 then
			CoD.MapVoter.AnimateVotes(menu.body.previousMapButton, menu.body.nextMapButton, menu.body.randomMapButton)
		elseif menu.vote == 3 then
			CoD.MapVoter.AnimateVotes(menu.body.randomMapButton, menu.body.previousMapButton, menu.body.nextMapButton)
		end
	end
end

CoD.MapVoter.AnimateMapChosen = function (menu, fadeTimeMs, immediate)
	if menu.mapChosen ~= nil and menu.body ~= nil then
		menu.m_inputDisabled = true
		if menu.mapChosen == menu.previousMap and menu.selectedMapGameMode == menu.previousGametype then
			CoD.MapVoter.FadeAndExpandButton(menu.body.previousMapButton, fadeTimeMs)
			CoD.MapVoter.FadeOutButton(menu.body.nextMapButton, fadeTimeMs)
			CoD.MapVoter.FadeOutButton(menu.body.randomMapButton, fadeTimeMs)
		elseif menu.mapChosen == menu.nextMap and menu.selectedMapGameMode == menu.nextGametype then
			CoD.MapVoter.FadeOutButton(menu.body.previousMapButton, fadeTimeMs)
			CoD.MapVoter.FadeAndExpandButton(menu.body.nextMapButton, fadeTimeMs)
			CoD.MapVoter.FadeOutButton(menu.body.randomMapButton, fadeTimeMs)
		else
			if immediate then
				fadeTimeMs = 0
			end
			local f15_local0 = UIExpression.DvarString(nil, "ui_gametype")
			local f15_local1 = nil
			if not CoD.isZombie then
				f15_local1 = UIExpression.TableLookup(controller, CoD.gametypesTable, 0, 0, 1, f15_local0, 2)
			else
				f15_local1 = CoD.GetZombieGameTypeDescription(f15_local0, menu.mapChosen)
			end
			menu.randomGameType = Engine.Localize(f15_local1)
			CoD.MapVoter.FadeOutButton(menu.body.previousMapButton, fadeTimeMs)
			CoD.MapVoter.FadeOutButton(menu.body.nextMapButton, fadeTimeMs)
			CoD.MapVoter.SetButtonMapImage(menu.body.randomMapButton, menu.mapChosen, menu.randomGameType)
			CoD.MapVoter.FadeAndExpandButton(menu.body.randomMapButton, fadeTimeMs)
		end
	end
end

CoD.MapVoter.SetVotesAndMaps = function (menu, event)
	if menu.mapChosen ~= nil then
		CoD.MapVoter.Reset(menu)
		if menu.body ~= nil then
			menu:removeElements()
			menu:addElements()
		end
	end
	if event.selfVote ~= nil then
		menu.vote = event.selfVote
	end
	if event.previousMapName ~= nil then
		menu.previousMap = event.previousMapName
	end
	if event.previousGametype ~= nil then
		menu.previousGametype = event.previousGametype
	end
	if event.nextMapName ~= nil then
		menu.nextMap = event.nextMapName
	end
	if event.nextGametype ~= nil then
		menu.nextGametype = event.nextGametype
	end
	menu.m_inputDisabled = false
	if menu.body ~= nil then
		CoD.MapVoter.SetButtonMapImage(menu.body.nextMapButton, menu.nextMap, menu.nextGametype, "NEXT")
		CoD.MapVoter.SetButtonMapImage(menu.body.previousMapButton, menu.previousMap, menu.previousGametype, "PREV")
		CoD.MapVoter.SetButtonMapImage(menu.body.randomMapButton, "RANDOM", nil, "RANDOM")
	end
	CoD.MapVoter.DisplayVoteCount(menu, event.previousMapVoteCount, event.nextMapVoteCount, event.randomMapVoteCount)
	CoD.MapVoter.Show(menu, false)
end

CoD.MapVoter.MapChosen = function (menu, event)
	local mapname = Dvar.ui_mapname:get()
	local gametype = Dvar.ui_gametype:get()
	if menu.mapChosen == nil then
		menu.mapChosen = mapname
		menu.selectedMapGameMode = gametype
		CoD.MapVoter.AnimateMapChosen(menu, 500, menu.isSlidingFromPanel)
		Engine.PlaySound("uin_map_chosen")
	elseif menu.mapChosen ~= mapname then
		menu.mapChosen = mapname
		menu.selectedMapGameMode = gametype
		CoD.MapVoter.AnimateMapChosen(menu)
		Engine.PlaySound("uin_map_chosen")
	end
	CoD.MapVoter.Show(menu, true)
end

CoD.MapVoter.MapChosen_Zombie = function (menu, event)
	local mapname = UIExpression.DvarString(nil, "ui_mapname")
	local gametype = Dvar.ui_gametype:get()
	local location = Dvar.ui_zm_mapstartlocation:get()
	if menu.mapChosen == nil then
		menu.mapChosen = mapname
		menu.selectedMapGameMode = gametype
		menu.startLoc = location
		CoD.MapVoter.AnimateMapChosen(menu, 0, true)
		Engine.PlaySound("uin_map_chosen")
	elseif menu.mapChosen ~= mapname or menu.selectedMapGameMode ~= gametype or menu.startLoc ~= location then
		menu.mapChosen = mapname
		menu.selectedMapGameMode = gametype
		menu.startLoc = location
		CoD.MapVoter.AnimateMapChosen(menu)
		Engine.PlaySound("uin_map_chosen")
	end
	CoD.MapVoter.Show(menu, true)
	menu:dispatchEventToChildren(event)
end

CoD.MapVoter.AddElements = function (menu)
	menu.body = LUI.UIElement.new()
	menu.body:registerEventHandler("next_button_pressed", CoD.MapVoter.NextButton)
	menu.body:registerEventHandler("previous_button_pressed", CoD.MapVoter.PreviousButton)
	menu.body:registerEventHandler("random_button_pressed", CoD.MapVoter.RandomButton)
	menu.body:setLeftRight(true, true, 0, 0)
	menu.body:setTopBottom(true, true, 0, 0)
	menu:addElement(menu.body)
	local f19_local0 = 4
	local f19_local1 = (menu.height - f19_local0 * 2) * 0.4
	local f19_local2 = f19_local1 / 2
	menu.body.nextMapButton = CoD.MapVoter.CreateMapVoteButton(menu, {
		left = 0,
		top = 0,
		right = menu.width,
		bottom = f19_local1,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}, "next_button_pressed")
	menu.body.nextMapButton.id = "LUIButton.Next"
	menu.body.nextMapButton.hintText = Engine.Localize("MPUI_NEXT_VOTE")
	menu.body:addElement(menu.body.nextMapButton)
	menu.body.previousMapButton = CoD.MapVoter.CreateMapVoteButton(menu, {
		left = 0,
		top = f19_local1 + f19_local0,
		right = menu.width,
		bottom = f19_local1 * 2 + f19_local0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}, "previous_button_pressed")
	menu.body.previousMapButton.id = "LUIButton.Previous"
	menu.body.previousMapButton.hintText = Engine.Localize("MPUI_PREVIOUS_VOTE")
	menu.body:addElement(menu.body.previousMapButton)
	menu.body.randomMapButton = CoD.MapVoter.CreateMapVoteButton(menu, {
		left = 0,
		top = f19_local1 * 2 + f19_local0 * 2,
		right = menu.width,
		bottom = f19_local1 * 2 + f19_local0 * 2 + f19_local2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}, "random_button_pressed")
	menu.body.randomMapButton.id = "LUIButton.Random"
	menu.body.randomMapButton.hintText = Engine.Localize("MPUI_RANDOM_VOTE")
	menu.body:addElement(menu.body.randomMapButton)
	menu.body.nextMapButton.navigation.down = menu.body.previousMapButton
	menu.body.previousMapButton.navigation.up = menu.body.nextMapButton
	menu.body.previousMapButton.navigation.down = menu.body.randomMapButton
	menu.body.randomMapButton.navigation.up = menu.body.previousMapButton
	if menu.buttonList ~= nil and CoD.isZombie == false then
		menu.buttonList.navigation = {}
		menu.buttonList.navigation.down = menu.body.nextMapButton
		menu.buttonList.navigation.up = menu.body.randomMapButton
		LUI.UIVerticalList.UpdateNavigation(menu.buttonList)
	end
end

CoD.MapVoter.RemoveElements = function (menu)
	menu.body:close()
	menu.body = nil
end

CoD.MapVoter.Show = function (menu, enableUsuability)
	if Dvar.party_isPreviousMapVoted:get() == true and not menu.body.previousMapButton.disabled and not enableUsuability then
		menu.body.previousMapButton:disable()
		menu.body.previousMapButton:makeNotFocusable()
		menu.body.previousMapButton.disabledImageHighlight:setAlpha(0.5)
		menu.body.nextMapButton.navigation.down = menu.body.randomMapButton
		menu.body.randomMapButton.navigation.up = menu.body.nextMapButton
	end
	if CoD.useMouse and not enableUsuability then
		menu:setMouseDisabled(false)
	end
	menu:beginAnimation("show")
	menu:setAlpha(1)
end

CoD.MapVoter.Reset = function (menu)
	menu.previousVotes = 0
	menu.nextVotes = 0
	menu.randomVotes = 0
	menu.mapChosen = nil
	menu.vote = nil
	menu.selectedMapGameMode = nil
end

CoD.MapVoter.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new(HudRef)
	Widget:beginAnimation("hide")
	Widget:setAlpha(0)
	Widget.id = "MapVoter"
	Widget.height = HudRef.bottom - HudRef.top
	Widget.width = HudRef.right - HudRef.left
	Widget.isSlidingFromPanel = InstanceRef
	if CoD.isZombie == true then
		Widget:registerEventHandler("map_vote_set_votes_and_maps", CoD.MapVoter.MapChosen_Zombie)
		Widget:registerEventHandler("map_vote_map_chosen", CoD.MapVoter.MapChosen_Zombie)
		Widget:registerEventHandler("gamelobby_update", CoD.MapVoter.MapChosen_Zombie)
	else
		Widget:registerEventHandler("map_vote_set_votes_and_maps", CoD.MapVoter.SetVotesAndMaps)
		Widget:registerEventHandler("map_vote_map_chosen", CoD.MapVoter.MapChosen)
	end
	Widget.addElements = CoD.MapVoter.AddElements
	Widget.removeElements = CoD.MapVoter.RemoveElements
	if CoD.useMouse then
		Widget:setMouseDisabled(true)
	end
	return Widget
end

