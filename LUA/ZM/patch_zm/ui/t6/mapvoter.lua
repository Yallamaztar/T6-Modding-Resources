if CoD == nil then
	CoD = {}
end
CoD.MapVoter = {}
CoD.MapVoter.AspectRatio = 1.5
CoD.MapVoter.FooterHeight = 46
CoD.MapVoter.PreviousButton = function (f1_arg0, f1_arg1)
	Engine.Exec(f1_arg1.controller, "xpartyveto 2")
	Engine.PlaySound("uin_navigation_vote")
end

CoD.MapVoter.NextButton = function (f2_arg0, f2_arg1)
	Engine.Exec(f2_arg1.controller, "xpartyveto 1")
	Engine.PlaySound("uin_navigation_vote")
end

CoD.MapVoter.RandomButton = function (f3_arg0, f3_arg1)
	Engine.Exec(f3_arg1.controller, "xpartyveto 3")
	Engine.PlaySound("uin_navigation_vote")
end

CoD.MapVoter.SetButtonMapImage = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	if f4_arg1 ~= nil then
		local f4_local0 = "menu_" .. f4_arg1 .. "_map_select_final"
		local f4_local1 = nil
		if CoD.isZombie == true and f4_arg1 ~= "RANDOM" then
			local f4_local2 = UIExpression.DvarString(nil, "ui_zm_mapstartlocation")
			local f4_local3 = UIExpression.DvarString(nil, "ui_zm_gamemodegroup")
			f4_local0 = "menu_" .. CoD.Zombie.GetMapName(f4_arg1) .. "_" .. f4_local3 .. "_" .. f4_local2
			if f4_local3 ~= CoD.Zombie.GAMETYPEGROUP_ZCLASSIC then
				f4_local1 = Engine.Localize(UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 5, 3, f4_local2, 4))
			end
		end
		f4_arg0.image:setImage(RegisterMaterial(f4_local0))
		f4_arg0.image:setAlpha(1)
		f4_arg0.label:setText(UIExpression.ToUpper(nil, Engine.Localize(UIExpression.TableLookup(nil, UIExpression.GetCurrentMapTableName(), 0, f4_arg1, 3))))
		if f4_arg2 then
			if f4_local1 then
				f4_arg0.gametypeLabel:setText(f4_local1 .. " / " .. f4_arg2)
			else
				f4_arg0.gametypeLabel:setText(f4_arg2)
			end
		elseif f4_local1 then
			f4_arg0.gametypeLabel:setText(f4_local1)
		end
		if f4_arg3 == "NEXT" then
			f4_arg0.mapTypeLabel:setText(Engine.Localize("MPUI_NEXT_CAPS"))
		elseif f4_arg3 == "PREV" then
			if true == Dvar.party_isPreviousMapVoted:get() then
				f4_arg0.mapTypeLabel:setText("")
				f4_arg0.gametypeLabel:setText("")
				f4_arg0.label:setText(Engine.Localize("MPUI_PREV_DISABLED_CAPS"))
				f4_arg0.label:setTopBottom(false, true, -CoD.textSize.Default - 5, -5)
				f4_arg0.label:setRGB(0.5, 0.5, 0.5)
				f4_arg0.label:setAlpha(0.6)
				f4_arg0.countContainer:setAlpha(0)
			else
				f4_arg0.mapTypeLabel:setText(Engine.Localize("MPUI_PREV_CAPS"))
			end
		elseif f4_arg3 == "RANDOM" then
			f4_arg0.mapTypeLabel:setText(Engine.Localize("MPUI_RANDOM_CAPS"))
			f4_arg0.gametypeLabel:setText(Engine.Localize("MENU_MODE_CLASSIFIED_CAPS"))
			f4_arg0.label:setText(Engine.Localize("MENU_MAP_CLASSIFIED_CAPS"))
		end
	end
end

CoD.MapVoter.DisableButton = function (f5_arg0)
	if f5_arg0:isInFocus() then
		f5_arg0:processEvent({
			name = "lose_focus"
		})
		if CoD.useController and f5_arg0.mapVoter.focusResetElement ~= nil then
			f5_arg0.mapVoter.focusResetElement:processEvent({
				name = "gain_focus"
			})
		end
	end
	f5_arg0.m_focusable = nil
	if f5_arg0.navigation.up then
		f5_arg0.navigation.up:setLayoutCached(false)
	end
	if f5_arg0.navigation.down then
		f5_arg0.navigation.down:setLayoutCached(false)
	end
end

CoD.MapVoter.FadeOut = function (f6_arg0, f6_arg1)
	f6_arg0:beginAnimation("fade_out", f6_arg1)
	f6_arg0:setAlpha(0)
end

CoD.MapVoter.FadeOutButton = function (f7_arg0, f7_arg1)
	CoD.MapVoter.DisableButton(f7_arg0)
	CoD.MapVoter.FadeOut(f7_arg0.image, f7_arg1)
	CoD.MapVoter.FadeOut(f7_arg0.imageHighlight, f7_arg1)
	CoD.MapVoter.FadeOut(f7_arg0.disabledImageHighlight, f7_arg1)
	CoD.MapVoter.FadeOut(f7_arg0.label, f7_arg1)
	CoD.MapVoter.FadeOut(f7_arg0.gametypeLabel, f7_arg1)
	CoD.MapVoter.FadeOut(f7_arg0.countBg, f7_arg1)
	CoD.MapVoter.FadeOut(f7_arg0.count, f7_arg1)
	CoD.MapVoter.FadeOut(f7_arg0.mapTypeLabel, f7_arg1)
end

CoD.MapVoter.ExpandButton = function (f8_arg0, f8_arg1)
	local f8_local0 = nil
	if f8_arg1 ~= nil then
		f8_local0 = f8_arg1.duration
	end
	local f8_local1 = CoD.MapInfoImage.MapImageWidth / CoD.MapInfoImage.MapImageHeight
	local f8_local2 = f8_arg0.mapVoter.width
	local f8_local3 = f8_local2 / f8_local1
	f8_arg0.image:beginAnimation("expand", f8_local0, true, true)
	f8_arg0.image:setLeftRight(false, false, -f8_local2 / 2, f8_local2 / 2)
	f8_arg0.image:setTopBottom(true, false, 0, f8_local3)
	f8_arg0:beginAnimation("expand", f8_local0, true, true)
	f8_arg0:setTopBottom(true, false, 0, f8_local3 + CoD.MapVoter.FooterHeight)
	f8_arg0:setLeftRight(true, true, 0, 0)
end

CoD.MapVoter.FadeAndExpandButton = function (f9_arg0, f9_arg1)
	CoD.MapVoter.DisableButton(f9_arg0)
	f9_arg0.image:beginAnimation("default", f9_arg1)
	f9_arg0.image:setAlpha(1)
	CoD.MapVoter.FadeOut(f9_arg0.countBg, f9_arg1)
	CoD.MapVoter.FadeOut(f9_arg0.count, f9_arg1)
	CoD.MapVoter.FadeOut(f9_arg0.mapTypeLabel, f9_arg1)
	CoD.MapVoter.FadeOut(f9_arg0.imageHighlight, f9_arg1)
	CoD.MapVoter.FadeOut(f9_arg0.disabledImageHighlight, f9_arg1)
	if f9_arg1 and f9_arg1 > 0 then
		f9_arg0:addElement(LUI.UITimer.new(f9_arg1, {
			name = "expand",
			duration = f9_arg1
		}, true))
	else
		CoD.MapVoter.ExpandButton(f9_arg0)
	end
end

CoD.MapVoter.ButtonOver = function (f10_arg0, f10_arg1)
	f10_arg0.imageHighlight:setAlpha(0.15)
	f10_arg0.mapVoteButtonBorder:setAlpha(1)
	if f10_arg0.mapVoter and f10_arg0.mapVoter.buttonList then
		f10_arg0.mapVoter.buttonList:processEvent({
			name = "update_hint_text",
			button = f10_arg0
		})
	end
end

CoD.MapVoter.ButtonUp = function (f11_arg0, f11_arg1)
	f11_arg0.imageHighlight:setAlpha(0)
	f11_arg0.mapVoteButtonBorder:setAlpha(0)
end

CoD.MapVoter.CreateMapVoteButton = function (f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = LUI.UIButton.new(f12_arg1, f12_arg2)
	f12_local0:registerEventHandler("button_over", CoD.MapVoter.ButtonOver)
	f12_local0:registerEventHandler("button_up", CoD.MapVoter.ButtonUp)
	f12_local0:setUseStencil(true)
	f12_local0:registerEventHandler("expand", CoD.MapVoter.ExpandButton)
	f12_local0.mapVoter = f12_arg0
	local f12_local1 = CoD.MapInfoImage.MapImageWidth / CoD.MapInfoImage.MapImageHeight
	local f12_local2 = f12_arg0.width + 20
	local f12_local3 = f12_local2 / f12_local1
	f12_local0.image = LUI.UIImage.new()
	f12_local0.image:setLeftRight(false, false, -f12_local2 / 2, f12_local2 / 2)
	f12_local0.image:setTopBottom(false, false, -f12_local3 / 2, f12_local3 / 2)
	f12_local0.image:setAlpha(0)
	f12_local0:addElement(f12_local0.image)
	f12_local0.imageHighlight = LUI.UIImage.new()
	f12_local0.imageHighlight:setTopBottom(false, false, -f12_arg0.height / 2, f12_arg0.height / 2)
	f12_local0.imageHighlight:setLeftRight(false, false, -f12_arg0.width / 2, f12_arg0.width / 2)
	f12_local0.imageHighlight:setAlpha(0)
	f12_local0:addElement(f12_local0.imageHighlight)
	f12_local0.disabledImageHighlight = LUI.UIImage.new()
	f12_local0.disabledImageHighlight:setTopBottom(false, false, -f12_arg0.height / 2, f12_arg0.height / 2)
	f12_local0.disabledImageHighlight:setLeftRight(false, false, -f12_arg0.width / 2, f12_arg0.width / 2)
	f12_local0.disabledImageHighlight:setAlpha(0)
	f12_local0.disabledImageHighlight:setRGB(0, 0, 0)
	f12_local0:addElement(f12_local0.disabledImageHighlight)
	local f12_local4 = f12_arg0.width / f12_local1
	local f12_local5 = LUI.UIImage.new()
	f12_local5:setLeftRight(true, true, 0, 0)
	f12_local5:setTopBottom(true, false, CoD.MPZM(f12_local4, 0), f12_local4 + CoD.MapVoter.FooterHeight)
	f12_local5:setImage(RegisterMaterial(CoD.MPZM("menu_mp_map_frame", "menu_zm_map_frame")))
	f12_local0:addElement(f12_local5)
	f12_local0.mapVoteButtonBorder = CoD.Border.new(2, CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b, 0)
	f12_local0:addElement(f12_local0.mapVoteButtonBorder)
	local f12_local6 = CoD.MPZM(-10, -20)
	local f12_local7 = CoD.MPZM(-2, -14)
	f12_local0.label = LUI.UIText.new()
	f12_local0.label:setLeftRight(false, true, -f12_arg0.width, f12_local6)
	f12_local0.label:setTopBottom(false, true, -CoD.textSize.Default - 17 + f12_local7, -17 + f12_local7)
	f12_local0:addElement(f12_local0.label)
	f12_local0.gametypeLabel = LUI.UIText.new()
	f12_local0.gametypeLabel:setLeftRight(false, true, -f12_arg0.width, f12_local6)
	f12_local0.gametypeLabel:setTopBottom(false, true, -CoD.textSize.ExtraSmall + f12_local7, f12_local7)
	f12_local0.gametypeLabel:setFont(CoD.fonts.ExtraSmall)
	f12_local0:addElement(f12_local0.gametypeLabel)
	f12_local0.countContainer = LUI.UIElement.new()
	f12_local0.countContainer:setLeftRight(true, false, 5, 5 + CoD.textSize.ExtraSmall)
	f12_local0.countContainer:setTopBottom(false, true, -CoD.textSize.ExtraSmall - 3, -3)
	f12_local0:addElement(f12_local0.countContainer)
	f12_local0.countBg = LUI.UIImage.new()
	f12_local0.countBg:setLeftRight(true, true, 0, 0)
	f12_local0.countBg:setTopBottom(true, true, 0, 0)
	f12_local0.countBg:setRGB(0, 0, 0)
	f12_local0.countBg:setAlpha(1)
	f12_local0.countContainer:addElement(f12_local0.countBg)
	f12_local0.count = LUI.UIText.new()
	f12_local0.count:setLeftRight(false, false, -1, 1)
	f12_local0.count:setTopBottom(false, true, -CoD.textSize.ExtraSmall, 0)
	f12_local0.count:setFont(CoD.fonts.ExtraSmall)
	f12_local0.countContainer:addElement(f12_local0.count)
	f12_local0.count:setText(0)
	f12_local0.mapTypeLabel = LUI.UIText.new()
	f12_local0.mapTypeLabel:setLeftRight(true, false, 30, f12_arg0.width)
	f12_local0.mapTypeLabel:setTopBottom(false, true, -CoD.textSize.Default - 1, -1)
	f12_local0:addElement(f12_local0.mapTypeLabel)
	return f12_local0
end

CoD.MapVoter.AnimateVotes = function (f13_arg0, f13_arg1, f13_arg2)
	f13_arg0.countBg:beginAnimation("buttonPressed")
	f13_arg0.countBg:setRGB(CoD.green.r, CoD.green.g, CoD.green.b)
	f13_arg0.mapTypeLabel:beginAnimation("buttonPressed")
	f13_arg0.mapTypeLabel:setRGB(CoD.green.r, CoD.green.g, CoD.green.b)
	f13_arg0.count:beginAnimation("buttonPressed")
	f13_arg0.count:setRGB(0, 0, 0)
	f13_arg1.countBg:beginAnimation("default")
	f13_arg1.countBg:setRGB(0, 0, 0)
	f13_arg1.mapTypeLabel:beginAnimation("default")
	f13_arg1.mapTypeLabel:setRGB(1, 1, 1)
	f13_arg1.count:beginAnimation("default")
	f13_arg1.count:setRGB(1, 1, 1)
	f13_arg2.countBg:beginAnimation("default")
	f13_arg2.countBg:setRGB(0, 0, 0)
	f13_arg2.mapTypeLabel:beginAnimation("default")
	f13_arg2.mapTypeLabel:setRGB(1, 1, 1)
	f13_arg2.count:beginAnimation("default")
	f13_arg2.count:setRGB(1, 1, 1)
end

CoD.MapVoter.DisplayVoteCount = function (f14_arg0, f14_arg1, f14_arg2, f14_arg3)
	if f14_arg0.body ~= nil then
		f14_arg0.body.previousMapButton.count:setText(f14_arg1)
		f14_arg0.body.nextMapButton.count:setText(f14_arg2)
		f14_arg0.body.randomMapButton.count:setText(f14_arg3)
		if f14_arg0.vote == 1 then
			CoD.MapVoter.AnimateVotes(f14_arg0.body.nextMapButton, f14_arg0.body.previousMapButton, f14_arg0.body.randomMapButton)
		elseif f14_arg0.vote == 2 then
			CoD.MapVoter.AnimateVotes(f14_arg0.body.previousMapButton, f14_arg0.body.nextMapButton, f14_arg0.body.randomMapButton)
		elseif f14_arg0.vote == 3 then
			CoD.MapVoter.AnimateVotes(f14_arg0.body.randomMapButton, f14_arg0.body.previousMapButton, f14_arg0.body.nextMapButton)
		end
	end
end

CoD.MapVoter.AnimateMapChosen = function (f15_arg0, f15_arg1, f15_arg2)
	if f15_arg0.mapChosen ~= nil and f15_arg0.body ~= nil then
		f15_arg0.m_inputDisabled = true
		if f15_arg0.mapChosen == f15_arg0.previousMap and f15_arg0.selectedMapGameMode == f15_arg0.previousGametype then
			CoD.MapVoter.FadeAndExpandButton(f15_arg0.body.previousMapButton, f15_arg1)
			CoD.MapVoter.FadeOutButton(f15_arg0.body.nextMapButton, f15_arg1)
			CoD.MapVoter.FadeOutButton(f15_arg0.body.randomMapButton, f15_arg1)
		elseif f15_arg0.mapChosen == f15_arg0.nextMap and f15_arg0.selectedMapGameMode == f15_arg0.nextGametype then
			CoD.MapVoter.FadeOutButton(f15_arg0.body.previousMapButton, f15_arg1)
			CoD.MapVoter.FadeAndExpandButton(f15_arg0.body.nextMapButton, f15_arg1)
			CoD.MapVoter.FadeOutButton(f15_arg0.body.randomMapButton, f15_arg1)
		else
			if f15_arg2 then
				f15_arg1 = 0
			end
			local f15_local0 = UIExpression.DvarString(nil, "ui_gametype")
			local f15_local1 = nil
			if not CoD.isZombie then
				f15_local1 = UIExpression.TableLookup(controller, CoD.gametypesTable, 0, 0, 1, f15_local0, 2)
			else
				f15_local1 = CoD.GetZombieGameTypeDescription(f15_local0, f15_arg0.mapChosen)
			end
			f15_arg0.randomGameType = Engine.Localize(f15_local1)
			CoD.MapVoter.FadeOutButton(f15_arg0.body.previousMapButton, f15_arg1)
			CoD.MapVoter.FadeOutButton(f15_arg0.body.nextMapButton, f15_arg1)
			CoD.MapVoter.SetButtonMapImage(f15_arg0.body.randomMapButton, f15_arg0.mapChosen, f15_arg0.randomGameType)
			CoD.MapVoter.FadeAndExpandButton(f15_arg0.body.randomMapButton, f15_arg1)
		end
	end
end

CoD.MapVoter.SetVotesAndMaps = function (f16_arg0, f16_arg1)
	if f16_arg0.mapChosen ~= nil then
		CoD.MapVoter.Reset(f16_arg0)
		if f16_arg0.body ~= nil then
			f16_arg0:removeElements()
			f16_arg0:addElements()
		end
	end
	if f16_arg1.selfVote ~= nil then
		f16_arg0.vote = f16_arg1.selfVote
	end
	if f16_arg1.previousMapName ~= nil then
		f16_arg0.previousMap = f16_arg1.previousMapName
	end
	if f16_arg1.previousGametype ~= nil then
		f16_arg0.previousGametype = f16_arg1.previousGametype
	end
	if f16_arg1.nextMapName ~= nil then
		f16_arg0.nextMap = f16_arg1.nextMapName
	end
	if f16_arg1.nextGametype ~= nil then
		f16_arg0.nextGametype = f16_arg1.nextGametype
	end
	f16_arg0.m_inputDisabled = false
	if f16_arg0.body ~= nil then
		CoD.MapVoter.SetButtonMapImage(f16_arg0.body.nextMapButton, f16_arg0.nextMap, f16_arg0.nextGametype, "NEXT")
		CoD.MapVoter.SetButtonMapImage(f16_arg0.body.previousMapButton, f16_arg0.previousMap, f16_arg0.previousGametype, "PREV")
		CoD.MapVoter.SetButtonMapImage(f16_arg0.body.randomMapButton, "RANDOM", nil, "RANDOM")
	end
	CoD.MapVoter.DisplayVoteCount(f16_arg0, f16_arg1.previousMapVoteCount, f16_arg1.nextMapVoteCount, f16_arg1.randomMapVoteCount)
	CoD.MapVoter.Show(f16_arg0, false)
end

CoD.MapVoter.MapChosen = function (f17_arg0, f17_arg1)
	local f17_local0 = Dvar.ui_mapname:get()
	local f17_local1 = Dvar.ui_gametype:get()
	if f17_arg0.mapChosen == nil then
		f17_arg0.mapChosen = f17_local0
		f17_arg0.selectedMapGameMode = f17_local1
		CoD.MapVoter.AnimateMapChosen(f17_arg0, 500, f17_arg0.isSlidingFromPanel)
		Engine.PlaySound("uin_map_chosen")
	elseif f17_arg0.mapChosen ~= f17_local0 then
		f17_arg0.mapChosen = f17_local0
		f17_arg0.selectedMapGameMode = f17_local1
		CoD.MapVoter.AnimateMapChosen(f17_arg0)
		Engine.PlaySound("uin_map_chosen")
	end
	CoD.MapVoter.Show(f17_arg0, true)
end

CoD.MapVoter.MapChosen_Zombie = function (f18_arg0, f18_arg1)
	local f18_local0 = UIExpression.DvarString(nil, "ui_mapname")
	local f18_local1 = Dvar.ui_gametype:get()
	local f18_local2 = Dvar.ui_zm_mapstartlocation:get()
	if f18_arg0.mapChosen == nil then
		f18_arg0.mapChosen = f18_local0
		f18_arg0.selectedMapGameMode = f18_local1
		f18_arg0.startLoc = f18_local2
		CoD.MapVoter.AnimateMapChosen(f18_arg0, 0, true)
		Engine.PlaySound("uin_map_chosen")
	elseif f18_arg0.mapChosen ~= f18_local0 or f18_arg0.selectedMapGameMode ~= f18_local1 or f18_arg0.startLoc ~= f18_local2 then
		f18_arg0.mapChosen = f18_local0
		f18_arg0.selectedMapGameMode = f18_local1
		f18_arg0.startLoc = f18_local2
		CoD.MapVoter.AnimateMapChosen(f18_arg0)
		Engine.PlaySound("uin_map_chosen")
	end
	CoD.MapVoter.Show(f18_arg0, true)
	f18_arg0:dispatchEventToChildren(f18_arg1)
end

CoD.MapVoter.AddElements = function (f19_arg0)
	f19_arg0.body = LUI.UIElement.new()
	f19_arg0.body:registerEventHandler("next_button_pressed", CoD.MapVoter.NextButton)
	f19_arg0.body:registerEventHandler("previous_button_pressed", CoD.MapVoter.PreviousButton)
	f19_arg0.body:registerEventHandler("random_button_pressed", CoD.MapVoter.RandomButton)
	f19_arg0.body:setLeftRight(true, true, 0, 0)
	f19_arg0.body:setTopBottom(true, true, 0, 0)
	f19_arg0:addElement(f19_arg0.body)
	local f19_local0 = 4
	local f19_local1 = (f19_arg0.height - f19_local0 * 2) * 0.4
	local f19_local2 = f19_local1 / 2
	f19_arg0.body.nextMapButton = CoD.MapVoter.CreateMapVoteButton(f19_arg0, {
		left = 0,
		top = 0,
		right = f19_arg0.width,
		bottom = f19_local1,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}, "next_button_pressed")
	f19_arg0.body.nextMapButton.id = "LUIButton.Next"
	f19_arg0.body.nextMapButton.hintText = Engine.Localize("MPUI_NEXT_VOTE")
	f19_arg0.body:addElement(f19_arg0.body.nextMapButton)
	f19_arg0.body.previousMapButton = CoD.MapVoter.CreateMapVoteButton(f19_arg0, {
		left = 0,
		top = f19_local1 + f19_local0,
		right = f19_arg0.width,
		bottom = f19_local1 * 2 + f19_local0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}, "previous_button_pressed")
	f19_arg0.body.previousMapButton.id = "LUIButton.Previous"
	f19_arg0.body.previousMapButton.hintText = Engine.Localize("MPUI_PREVIOUS_VOTE")
	f19_arg0.body:addElement(f19_arg0.body.previousMapButton)
	f19_arg0.body.randomMapButton = CoD.MapVoter.CreateMapVoteButton(f19_arg0, {
		left = 0,
		top = f19_local1 * 2 + f19_local0 * 2,
		right = f19_arg0.width,
		bottom = f19_local1 * 2 + f19_local0 * 2 + f19_local2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}, "random_button_pressed")
	f19_arg0.body.randomMapButton.id = "LUIButton.Random"
	f19_arg0.body.randomMapButton.hintText = Engine.Localize("MPUI_RANDOM_VOTE")
	f19_arg0.body:addElement(f19_arg0.body.randomMapButton)
	f19_arg0.body.nextMapButton.navigation.down = f19_arg0.body.previousMapButton
	f19_arg0.body.previousMapButton.navigation.up = f19_arg0.body.nextMapButton
	f19_arg0.body.previousMapButton.navigation.down = f19_arg0.body.randomMapButton
	f19_arg0.body.randomMapButton.navigation.up = f19_arg0.body.previousMapButton
	if f19_arg0.buttonList ~= nil and CoD.isZombie == false then
		f19_arg0.buttonList.navigation = {}
		f19_arg0.buttonList.navigation.down = f19_arg0.body.nextMapButton
		f19_arg0.buttonList.navigation.up = f19_arg0.body.randomMapButton
		LUI.UIVerticalList.UpdateNavigation(f19_arg0.buttonList)
	end
end

CoD.MapVoter.RemoveElements = function (f20_arg0)
	f20_arg0.body:close()
	f20_arg0.body = nil
end

CoD.MapVoter.Show = function (f21_arg0, f21_arg1)
	if Dvar.party_isPreviousMapVoted:get() == true and not f21_arg0.body.previousMapButton.disabled and not f21_arg1 then
		f21_arg0.body.previousMapButton:disable()
		f21_arg0.body.previousMapButton:makeNotFocusable()
		f21_arg0.body.previousMapButton.disabledImageHighlight:setAlpha(0.5)
		f21_arg0.body.nextMapButton.navigation.down = f21_arg0.body.randomMapButton
		f21_arg0.body.randomMapButton.navigation.up = f21_arg0.body.nextMapButton
	end
	if CoD.useMouse and not f21_arg1 then
		f21_arg0:setMouseDisabled(false)
	end
	f21_arg0:beginAnimation("show")
	f21_arg0:setAlpha(1)
end

CoD.MapVoter.Reset = function (f22_arg0)
	f22_arg0.previousVotes = 0
	f22_arg0.nextVotes = 0
	f22_arg0.randomVotes = 0
	f22_arg0.mapChosen = nil
	f22_arg0.vote = nil
	f22_arg0.selectedMapGameMode = nil
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

