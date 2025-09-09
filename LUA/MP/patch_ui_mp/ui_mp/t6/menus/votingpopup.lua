require("T6.Menus.VotingConfirmation")
CoD.VotingPopup = {}
CoD.VotingPopup.MessageTop = 0
CoD.VotingPopup.MessageHeight = 100
CoD.VotingPopup.SelectElementContainerWidth = 100
CoD.VotingPopup.SelectElementContainerHeight = 80
CoD.VotingPopup.ArrowWidth = 32
CoD.VotingPopup.ArrowHeight = 16
CoD.VotingPopup.CenterElementContainerWidth = 160
CoD.VotingPopup.CenterElementContainerHeight = 145
CoD.VotingPopup.CenterElementOffset = 30
CoD.VotingPopup.VotingItemHeight = 180
CoD.VotingPopup.VotingItemWidth = CoD.VotingPopup.VotingItemHeight * 2
CoD.VotingPopup.SelectedItemHeightIncrement = 50
CoD.VotingPopup.SelectedItemWidthIncrement = CoD.VotingPopup.SelectedItemHeightIncrement * 2
CoD.VotingPopup.SelectedCenterElementContainerWidth = CoD.VotingPopup.CenterElementContainerWidth - CoD.VotingPopup.SelectedItemWidthIncrement
CoD.VotingPopup.SelectedCenterElementContainerHeight = CoD.VotingPopup.CenterElementContainerHeight - CoD.VotingPopup.SelectedItemHeightIncrement
CoD.VotingPopup.VotingSelectedItemWidth = CoD.VotingPopup.VotingItemWidth + CoD.VotingPopup.SelectedItemWidthIncrement
CoD.VotingPopup.VotingSelectedItemHeight = CoD.VotingPopup.VotingItemHeight + CoD.VotingPopup.SelectedItemHeightIncrement
CoD.VotingPopup.FadeAlpha = 0.4
CoD.VotingPopup.ResultsXPosition = 70
CoD.VotingPopup.AddTitle = function (f1_arg0, f1_arg1, f1_arg2)
	if f1_arg1 ~= nil then
		local f1_local0 = LUI.UIText.new()
		f1_local0:setLeftRight(true, true, 0, 0)
		f1_local0:setTopBottom(true, false, f1_arg2, f1_arg2 + CoD.textSize.Big)
		f1_local0:setFont(CoD.fonts.Big)
		f1_local0:setAlignment(LUI.Alignment.Center)
		f1_local0:setText(f1_arg1)
		f1_arg0:addElement(f1_local0)
		f1_arg0.title = f1_local0
	end
end

CoD.VotingPopup.AddSubtitle = function (f2_arg0, f2_arg1, f2_arg2)
	if f2_arg1 ~= nil then
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, false, f2_arg2, f2_arg2 + CoD.VotingPopup.MessageHeight)
		f2_arg0:addElement(Widget)
		local f2_local1 = LUI.UIText.new(nil, true)
		f2_local1:setLeftRight(true, true, 0, 0)
		f2_local1:setTopBottom(true, false, 0, CoD.textSize.ExtraSmall)
		f2_local1:setFont(CoD.fonts.ExtraSmall)
		f2_local1:setText(f2_arg1)
		f2_local1:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f2_local1:setAlignment(LUI.Alignment.Center)
		Widget:addElement(f2_local1)
	end
end

CoD.VotingPopup.GetVotingItemsDetails = function (f3_arg0, f3_arg1)
	for f3_local0 = 1, f3_arg1.votingItemsCount, 1 do
		if f3_arg1[f3_local0].votingitemposition == "left" then
			f3_arg0.LeftVotingItem = {}
			f3_arg0.LeftVotingItem.ImageName = f3_arg1[f3_local0].imageName
			f3_arg0.LeftVotingItem.IsLocalImage = f3_arg1[f3_local0].isLocalImage
			f3_arg0.LeftVotingItem.CounterName = f3_arg1[f3_local0].counterName
			f3_arg0.LeftVotingItem.VotingItemString = f3_arg1[f3_local0].votingitemstring
		end
		if f3_arg1[f3_local0].votingitemposition == "right" then
			f3_arg0.RightVotingItem = {}
			f3_arg0.RightVotingItem.ImageName = f3_arg1[f3_local0].imageName
			f3_arg0.RightVotingItem.IsLocalImage = f3_arg1[f3_local0].isLocalImage
			f3_arg0.RightVotingItem.CounterName = f3_arg1[f3_local0].counterName
			f3_arg0.RightVotingItem.VotingItemString = f3_arg1[f3_local0].votingitemstring
		end
		if f3_arg1[f3_local0].votingitemposition == "top" then
			f3_arg0.TopVotingItem = {}
			f3_arg0.TopVotingItem.ImageName = f3_arg1[f3_local0].imageName
			f3_arg0.TopVotingItem.IsLocalImage = f3_arg1[f3_local0].isLocalImage
			f3_arg0.TopVotingItem.CounterName = f3_arg1[f3_local0].counterName
			f3_arg0.TopVotingItem.VotingItemString = f3_arg1[f3_local0].votingitemstring
		end
		if f3_arg1[f3_local0].votingitemposition == "bottom" then
			f3_arg0.BottomVotingItem = {}
			f3_arg0.BottomVotingItem.ImageName = f3_arg1[f3_local0].imageName
			f3_arg0.BottomVotingItem.IsLocalImage = f3_arg1[f3_local0].isLocalImage
			f3_arg0.BottomVotingItem.CounterName = f3_arg1[f3_local0].counterName
			f3_arg0.BottomVotingItem.VotingItemString = f3_arg1[f3_local0].votingitemstring
		end
	end
end

CoD.VotingPopup.CreateVotingItemElement = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	local votingItemEl = LUI.UIImage.new()
	votingItemEl:setLeftRight(true, true, 0, 0)
	votingItemEl:setTopBottom(true, true, 0, 0)
	votingItemEl:setImage(RegisterMaterial(f4_arg1))
	f4_arg0:addElement(votingItemEl)
	f4_arg0.votingItemEl = votingItemEl
	
	local votingItemGlowEl = LUI.UIImage.new()
	votingItemGlowEl:setLeftRight(true, true, 0, 0)
	votingItemGlowEl:setTopBottom(true, true, 0, 0)
	votingItemGlowEl:setAlpha(0)
	votingItemGlowEl:setImage(RegisterMaterial("menu_motd_voteglow"))
	f4_arg0:addElement(votingItemGlowEl)
	f4_arg0.votingItemGlowEl = votingItemGlowEl
	
	if f4_arg2 ~= nil then
		local f4_local2 = 10
		local f4_local3 = LUI.UIText.new()
		f4_local3:setLeftRight(true, true, CoD.VotingPopup.ResultsXPosition, 0)
		f4_local3:setTopBottom(false, true, -CoD.textSize.Condensed - f4_local2, -f4_local2)
		f4_local3:setFont(CoD.fonts.Condensed)
		f4_local3:setAlignment(LUI.Alignment.Left)
		f4_local3:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f4_local3:setText(f4_arg2)
		f4_arg0:addElement(f4_local3)
	end
	if f4_arg3 ~= nil then
		local f4_local2 = -30
		local f4_local3 = LUI.UIText.new()
		f4_local3:setLeftRight(true, true, 0, 0)
		f4_local3:setTopBottom(false, true, -CoD.textSize.Condensed - f4_local2, -f4_local2)
		f4_local3:setFont(CoD.fonts.Condensed)
		f4_local3:setAlignment(LUI.Alignment.Center)
		f4_local3:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f4_local3:setText(f4_arg3)
		f4_arg0:addElement(f4_local3)
	end
end

CoD.VotingPopup.CreateVotingMouseListener = function (f5_arg0, f5_arg1)
	if CoD.useMouse then
		local f5_local0 = CoD.VotingPopup.VotingItemWidth / 5
		local f5_local1 = CoD.VotingPopup.VotingItemHeight / 5
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, f5_local0, -f5_local0)
		Widget:setTopBottom(true, true, f5_local1, -f5_local1)
		Widget.m_position = f5_arg1
		f5_arg0:addElement(Widget)
		Widget:setHandleMouse(true)
		Widget:registerEventHandler("mouseenter", function (f34_arg0, f34_arg1)
			f34_arg0:dispatchEventToParent({
				name = "mouse_vote_item",
				position = f34_arg0.m_position,
				controller = f34_arg1.controller
			})
		end)
		Widget:registerEventHandler("mouseleave", function (f35_arg0, f35_arg1)
			f35_arg0:dispatchEventToParent({
				name = "mouse_vote_item",
				position = "default",
				controller = f35_arg1.controller
			})
		end)
		Widget:registerEventHandler("leftmouseup", function (f36_arg0, f36_arg1)
			if f36_arg1.inside then
				f36_arg0:dispatchEventToParent({
					name = "vote_submit",
					controller = f36_arg1.controller
				})
			end
		end)
		Widget:registerEventHandler("leftmousedown", CoD.NullFunction)
	end
end

CoD.VotingPopup.CreateLeftVotingElement = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	local leftVotingItemContainer = LUI.UIElement.new()
	leftVotingItemContainer:registerAnimationState("expand", {
		leftAnchor = false,
		rightAnchor = true,
		topAnchor = false,
		bottomAnchor = false,
		left = -CoD.VotingPopup.SelectedCenterElementContainerWidth - CoD.VotingPopup.VotingSelectedItemWidth,
		right = -CoD.VotingPopup.SelectedCenterElementContainerWidth,
		top = -CoD.VotingPopup.VotingSelectedItemHeight / 2,
		bottom = CoD.VotingPopup.VotingSelectedItemHeight / 2
	})
	leftVotingItemContainer:registerAnimationState("default", {
		leftAnchor = false,
		rightAnchor = true,
		topAnchor = false,
		bottomAnchor = false,
		left = -CoD.VotingPopup.CenterElementContainerWidth - CoD.VotingPopup.VotingItemWidth,
		right = -CoD.VotingPopup.CenterElementContainerWidth,
		top = -CoD.VotingPopup.VotingItemHeight / 2,
		bottom = CoD.VotingPopup.VotingItemHeight / 2
	})
	leftVotingItemContainer:registerAnimationState("fade_out", {
		alpha = CoD.VotingPopup.FadeAlpha
	})
	leftVotingItemContainer:registerAnimationState("fade_in", {
		alpha = 1
	})
	leftVotingItemContainer:animateToState("default")
	f6_arg0:addElement(leftVotingItemContainer)
	f6_arg0.leftVotingItemContainer = leftVotingItemContainer
	
	CoD.VotingPopup.CreateVotingItemElement(leftVotingItemContainer, f6_arg1.ImageName, f6_arg2, f6_arg3)
	CoD.VotingPopup.CreateVotingMouseListener(leftVotingItemContainer, "left")
end

CoD.VotingPopup.CreateRightVotingElement = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	local rightVotingItemContainer = LUI.UIElement.new()
	rightVotingItemContainer:registerAnimationState("expand", {
		leftAnchor = true,
		rightAnchor = false,
		topAnchor = false,
		bottomAnchor = false,
		left = CoD.VotingPopup.SelectedCenterElementContainerWidth,
		right = CoD.VotingPopup.VotingSelectedItemWidth + CoD.VotingPopup.SelectedCenterElementContainerWidth,
		top = -CoD.VotingPopup.VotingSelectedItemHeight / 2,
		bottom = CoD.VotingPopup.VotingSelectedItemHeight / 2
	})
	rightVotingItemContainer:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = false,
		topAnchor = false,
		bottomAnchor = false,
		left = CoD.VotingPopup.CenterElementContainerWidth,
		right = CoD.VotingPopup.VotingItemWidth + CoD.VotingPopup.CenterElementContainerWidth,
		top = -CoD.VotingPopup.VotingItemHeight / 2,
		bottom = CoD.VotingPopup.VotingItemHeight / 2
	})
	rightVotingItemContainer:registerAnimationState("fade_out", {
		alpha = CoD.VotingPopup.FadeAlpha
	})
	rightVotingItemContainer:registerAnimationState("fade_in", {
		alpha = 1
	})
	rightVotingItemContainer:animateToState("default")
	f7_arg0:addElement(rightVotingItemContainer)
	f7_arg0.rightVotingItemContainer = rightVotingItemContainer
	
	CoD.VotingPopup.CreateVotingItemElement(rightVotingItemContainer, f7_arg1.ImageName, f7_arg2, f7_arg3)
	CoD.VotingPopup.CreateVotingMouseListener(rightVotingItemContainer, "right")
end

CoD.VotingPopup.CreateTopVotingElement = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	local topVotingItemContainer = LUI.UIElement.new()
	topVotingItemContainer:registerAnimationState("expand", {
		leftAnchor = false,
		rightAnchor = false,
		topAnchor = false,
		bottomAnchor = true,
		left = -CoD.VotingPopup.VotingSelectedItemWidth / 2,
		right = CoD.VotingPopup.VotingSelectedItemWidth / 2,
		top = -CoD.VotingPopup.SelectedCenterElementContainerHeight - CoD.VotingPopup.VotingSelectedItemHeight,
		bottom = -CoD.VotingPopup.SelectedCenterElementContainerHeight
	})
	topVotingItemContainer:registerAnimationState("default", {
		leftAnchor = false,
		rightAnchor = false,
		topAnchor = false,
		bottomAnchor = true,
		left = -CoD.VotingPopup.VotingItemWidth / 2,
		right = CoD.VotingPopup.VotingItemWidth / 2,
		top = -CoD.VotingPopup.CenterElementContainerHeight - CoD.VotingPopup.VotingItemHeight,
		bottom = -CoD.VotingPopup.CenterElementContainerHeight
	})
	topVotingItemContainer:registerAnimationState("fade_out", {
		alpha = CoD.VotingPopup.FadeAlpha
	})
	topVotingItemContainer:registerAnimationState("fade_in", {
		alpha = 1
	})
	topVotingItemContainer:animateToState("default")
	f8_arg0:addElement(topVotingItemContainer)
	f8_arg0.topVotingItemContainer = topVotingItemContainer
	
	CoD.VotingPopup.CreateVotingItemElement(topVotingItemContainer, f8_arg1.ImageName, f8_arg2, f8_arg3)
	CoD.VotingPopup.CreateVotingMouseListener(topVotingItemContainer, "up")
end

CoD.VotingPopup.CreateBottomVotingElement = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	local bottomVotingItemContainer = LUI.UIElement.new()
	bottomVotingItemContainer:registerAnimationState("expand", {
		leftAnchor = false,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = false,
		left = -CoD.VotingPopup.VotingSelectedItemWidth / 2,
		right = CoD.VotingPopup.VotingSelectedItemWidth / 2,
		top = CoD.VotingPopup.SelectedCenterElementContainerHeight,
		bottom = CoD.VotingPopup.SelectedCenterElementContainerHeight + CoD.VotingPopup.VotingSelectedItemHeight
	})
	bottomVotingItemContainer:registerAnimationState("default", {
		leftAnchor = false,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = false,
		left = -CoD.VotingPopup.VotingItemWidth / 2,
		right = CoD.VotingPopup.VotingItemWidth / 2,
		top = CoD.VotingPopup.CenterElementContainerHeight,
		bottom = CoD.VotingPopup.CenterElementContainerHeight + CoD.VotingPopup.VotingItemHeight
	})
	bottomVotingItemContainer:registerAnimationState("fade_out", {
		alpha = CoD.VotingPopup.FadeAlpha
	})
	bottomVotingItemContainer:registerAnimationState("fade_in", {
		alpha = 1
	})
	bottomVotingItemContainer:animateToState("default")
	f9_arg0:addElement(bottomVotingItemContainer)
	f9_arg0.bottomVotingItemContainer = bottomVotingItemContainer
	
	CoD.VotingPopup.CreateVotingItemElement(bottomVotingItemContainer, f9_arg1.ImageName, f9_arg2, f9_arg3)
	CoD.VotingPopup.CreateVotingMouseListener(bottomVotingItemContainer, "down")
end

CoD.VotingPopup.HideGlow = function (f10_arg0)
	if f10_arg0 ~= nil and f10_arg0.votingItemGlowEl ~= nil then
		f10_arg0.votingItemGlowEl:setAlpha(0)
		f10_arg0:animateToState("default", 100, true, true)
		f10_arg0:animateToState("fade_in")
	end
end

CoD.VotingPopup.SetDefaultCenterElementState = function (f11_arg0, f11_arg1)
	CoD.VotingPopup.SetVotingArrowsOrange(f11_arg0)
	f11_arg0.selectElementContainer.textElement:setAlpha(1)
	f11_arg0:dispatchEventToParent({
		name = "change_to_default_controls",
		controller = f11_arg1.controller
	})
	f11_arg0:dispatchEventToParent({
		name = "change_title",
		controller = f11_arg1.controller
	})
	CoD.VotingPopup.PulseElement(f11_arg0.selectElementContainer)
end

CoD.VotingPopup.ResetSelectedVoteGlow = function (f12_arg0, f12_arg1)
	CoD.VotingPopup.HideGlow(f12_arg0.leftVotingItemContainer)
	CoD.VotingPopup.HideGlow(f12_arg0.rightVotingItemContainer)
	CoD.VotingPopup.HideGlow(f12_arg0.topVotingItemContainer)
	CoD.VotingPopup.HideGlow(f12_arg0.bottomVotingItemContainer)
end

CoD.VotingPopup.TriggerVoteSelectedEvent = function (f13_arg0, f13_arg1)
	local f13_local0 = f13_arg0.directionx
	local f13_local1 = f13_arg0.directiony
	if f13_arg1.button == "right" and f13_arg0.rightVotingItemContainer and f13_local0 ~= 1 then
		f13_local0 = f13_local0 + 1
		f13_local1 = 0
		f13_arg0:processEvent({
			name = "resetSelectedVoteGlow",
			controller = f13_arg1.controller
		})
		f13_arg0:processEvent({
			name = "voteSelected",
			controller = f13_arg1.controller,
			button = f13_arg1.button
		})
	elseif f13_arg1.button == "left" and f13_arg0.leftVotingItemContainer and f13_local0 ~= -1 then
		f13_local0 = f13_local0 - 1
		f13_local1 = 0
		f13_arg0:processEvent({
			name = "resetSelectedVoteGlow",
			controller = f13_arg1.controller
		})
		f13_arg0:processEvent({
			name = "voteSelected",
			controller = f13_arg1.controller,
			button = f13_arg1.button
		})
	elseif f13_arg1.button == "up" and f13_arg0.topVotingItemContainer and f13_local1 ~= -1 then
		f13_local1 = f13_local1 - 1
		f13_local0 = 0
		f13_arg0:processEvent({
			name = "resetSelectedVoteGlow",
			controller = f13_arg1.controller
		})
		f13_arg0:processEvent({
			name = "voteSelected",
			controller = f13_arg1.controller,
			button = f13_arg1.button
		})
	elseif f13_arg1.button == "down" and f13_arg0.bottomVotingItemContainer and f13_local1 ~= 1 then
		f13_local1 = f13_local1 + 1
		f13_local0 = 0
		f13_arg0:processEvent({
			name = "resetSelectedVoteGlow",
			controller = f13_arg1.controller
		})
		f13_arg0:processEvent({
			name = "voteSelected",
			controller = f13_arg1.controller,
			button = f13_arg1.button
		})
	elseif f13_arg1.button == "default" then
		f13_local0 = 0
		f13_local1 = 0
	end
	if f13_local0 == 0 and f13_local1 == 0 then
		f13_arg0:processEvent({
			name = "resetSelectedVoteGlow",
			controller = f13_arg1.controller
		})
		f13_arg0:processEvent({
			name = "change_to_default_state",
			controller = f13_arg1.controller
		})
	end
	f13_arg0.directionx = f13_local0
	f13_arg0.directiony = f13_local1
end

CoD.VotingPopup.HandleGamepadButton = function (f14_arg0, f14_arg1)
	if LUI.UIElement.handleGamepadButton(f14_arg0, f14_arg1) == true then
		return true
	elseif f14_arg1.down == true then
		CoD.VotingPopup.TriggerVoteSelectedEvent(f14_arg0, f14_arg1)
	end
end

CoD.VotingPopup.SetVotingArrowsWhite = function (f15_arg0)
	f15_arg0.selectElementContainer.leftArrow:setImage(RegisterMaterial("menu_motd_votearrow"))
	f15_arg0.selectElementContainer.rightArrow:setImage(RegisterMaterial("menu_motd_votearrow"))
	f15_arg0.selectElementContainer.topArrow:setImage(RegisterMaterial("menu_motd_votearrow"))
	f15_arg0.selectElementContainer.bottomArrow:setImage(RegisterMaterial("menu_motd_votearrow"))
end

CoD.VotingPopup.SetVotingArrowsOrange = function (f16_arg0)
	f16_arg0.selectElementContainer.leftArrow:setImage(RegisterMaterial("menu_motd_votearrow_glow"))
	f16_arg0.selectElementContainer.rightArrow:setImage(RegisterMaterial("menu_motd_votearrow_glow"))
	f16_arg0.selectElementContainer.topArrow:setImage(RegisterMaterial("menu_motd_votearrow_glow"))
	f16_arg0.selectElementContainer.bottomArrow:setImage(RegisterMaterial("menu_motd_votearrow_glow"))
end

CoD.VotingPopup.SetupSelectedItem = function (f17_arg0, f17_arg1, f17_arg2, f17_arg3)
	f17_arg0.selectElementContainer.textElement:setAlpha(0)
	f17_arg0.selectElementContainer:beginAnimation("stop_pulsing", 1)
	f17_arg0.selectElementContainer:setAlpha(1)
	f17_arg1:animateToState("expand", 100, true, true)
	f17_arg1.votingItemGlowEl:setAlpha(1)
	f17_arg0.selectedCounterName = f17_arg2.CounterName
	f17_arg0.selectedItemName = f17_arg2.VotingItemString
	f17_arg0:dispatchEventToParent({
		name = "change_title",
		itemName = f17_arg2.VotingItemString
	})
	if f17_arg3 ~= "left" and f17_arg0.leftVotingItemContainer ~= nil then
		f17_arg0.leftVotingItemContainer:animateToState("fade_out")
	end
	if f17_arg3 ~= "right" and f17_arg0.rightVotingItemContainer ~= nil then
		f17_arg0.rightVotingItemContainer:animateToState("fade_out")
	end
	if f17_arg3 ~= "up" and f17_arg0.topVotingItemContainer ~= nil then
		f17_arg0.topVotingItemContainer:animateToState("fade_out")
	end
	if f17_arg3 ~= "down" and f17_arg0.bottomVotingItemContainer ~= nil then
		f17_arg0.bottomVotingItemContainer:animateToState("fade_out")
	end
	CoD.VotingPopup.SetVotingArrowsWhite(f17_arg0)
	Engine.PlaySound("cac_grid_nav")
end

CoD.VotingPopup.VoteSelected = function (f18_arg0, f18_arg1)
	f18_arg0:dispatchEventToParent({
		name = "change_to_submission_controls",
		controller = f18_arg1.controller
	})
	if f18_arg1.button == "left" and f18_arg0.leftVotingItemContainer ~= nil then
		f18_arg0.leftVotingItemContainer:close()
		CoD.VotingPopup.CreateLeftVotingElement(f18_arg0, f18_arg0.LeftVotingItem)
		CoD.VotingPopup.SetupSelectedItem(f18_arg0, f18_arg0.leftVotingItemContainer, f18_arg0.LeftVotingItem, f18_arg1.button)
	elseif f18_arg1.button == "right" and f18_arg0.rightVotingItemContainer ~= nil then
		f18_arg0.rightVotingItemContainer:close()
		CoD.VotingPopup.CreateRightVotingElement(f18_arg0, f18_arg0.RightVotingItem)
		CoD.VotingPopup.SetupSelectedItem(f18_arg0, f18_arg0.rightVotingItemContainer, f18_arg0.RightVotingItem, f18_arg1.button)
	elseif f18_arg1.button == "up" and f18_arg0.topVotingItemContainer ~= nil then
		f18_arg0.topVotingItemContainer:close()
		CoD.VotingPopup.CreateTopVotingElement(f18_arg0, f18_arg0.TopVotingItem)
		CoD.VotingPopup.SetupSelectedItem(f18_arg0, f18_arg0.topVotingItemContainer, f18_arg0.TopVotingItem, f18_arg1.button)
	elseif f18_arg1.button == "down" and f18_arg0.bottomVotingItemContainer ~= nil then
		f18_arg0.bottomVotingItemContainer:close()
		CoD.VotingPopup.CreateBottomVotingElement(f18_arg0, f18_arg0.BottomVotingItem)
		CoD.VotingPopup.SetupSelectedItem(f18_arg0, f18_arg0.bottomVotingItemContainer, f18_arg0.BottomVotingItem, f18_arg1.button)
	end
end

CoD.VotingPopup.CreateCenterElement = function (f19_arg0)
	local selectElementContainer = LUI.UIElement.new()
	selectElementContainer:setLeftRight(false, false, -CoD.VotingPopup.SelectElementContainerWidth / 2, CoD.VotingPopup.SelectElementContainerWidth / 2)
	selectElementContainer:setTopBottom(false, false, -CoD.VotingPopup.SelectElementContainerHeight / 2, CoD.VotingPopup.SelectElementContainerHeight / 2)
	f19_arg0:addElement(selectElementContainer)
	f19_arg0.selectElementContainer = selectElementContainer
	
	local rightArrow = LUI.UIImage.new()
	rightArrow:setLeftRight(true, false, CoD.VotingPopup.SelectElementContainerWidth, CoD.VotingPopup.SelectElementContainerWidth + CoD.VotingPopup.ArrowWidth)
	rightArrow:setTopBottom(false, false, -CoD.VotingPopup.ArrowHeight / 2, CoD.VotingPopup.ArrowHeight / 2)
	rightArrow:setZRot(270)
	rightArrow:setImage(RegisterMaterial("menu_motd_votearrow_glow"))
	selectElementContainer:addElement(rightArrow)
	selectElementContainer.rightArrow = rightArrow
	
	local leftArrow = LUI.UIImage.new()
	leftArrow:setLeftRight(false, true, -CoD.VotingPopup.SelectElementContainerWidth - CoD.VotingPopup.ArrowWidth, -CoD.VotingPopup.SelectElementContainerWidth)
	leftArrow:setTopBottom(false, false, -CoD.VotingPopup.ArrowHeight / 2, CoD.VotingPopup.ArrowHeight / 2)
	leftArrow:setZRot(90)
	leftArrow:setImage(RegisterMaterial("menu_motd_votearrow_glow"))
	selectElementContainer:addElement(leftArrow)
	selectElementContainer.leftArrow = leftArrow
	
	local topArrow = LUI.UIImage.new()
	topArrow:setLeftRight(false, false, -CoD.VotingPopup.ArrowWidth / 2, CoD.VotingPopup.ArrowWidth / 2)
	topArrow:setTopBottom(false, true, -CoD.VotingPopup.SelectElementContainerHeight - CoD.VotingPopup.ArrowHeight, -CoD.VotingPopup.SelectElementContainerHeight)
	topArrow:setImage(RegisterMaterial("menu_motd_votearrow_glow"))
	selectElementContainer:addElement(topArrow)
	selectElementContainer.topArrow = topArrow
	
	local bottomArrow = LUI.UIImage.new()
	bottomArrow:setLeftRight(false, false, -CoD.VotingPopup.ArrowWidth / 2, CoD.VotingPopup.ArrowWidth / 2)
	bottomArrow:setTopBottom(true, false, CoD.VotingPopup.SelectElementContainerHeight, CoD.VotingPopup.ArrowHeight + CoD.VotingPopup.SelectElementContainerHeight)
	bottomArrow:setImage(RegisterMaterial("menu_motd_votearrow_glow"))
	bottomArrow:setZRot(180)
	selectElementContainer:addElement(bottomArrow)
	selectElementContainer.bottomArrow = bottomArrow
	
	CoD.VotingPopup.PulseElement(f19_arg0.selectElementContainer)
end

CoD.VotingPopup.PulseDuration = 700
CoD.VotingPopup.PulseOutAlpha = 0.3
CoD.VotingPopup.PulseElement = function (f20_arg0)
	f20_arg0:beginAnimation("pulse_out", CoD.VotingPopup.PulseDuration)
	f20_arg0:setAlpha(CoD.VotingPopup.PulseOutAlpha)
	f20_arg0:registerEventHandler("transition_complete_pulse_out", function (f37_arg0, f37_arg1)
		if not f37_arg1.interrupted then
			f37_arg0:beginAnimation("pulse_in", CoD.VotingPopup.PulseDuration)
			f37_arg0:setAlpha(1)
		end
	end)
	f20_arg0:registerEventHandler("transition_complete_pulse_in", function (f38_arg0, f38_arg1)
		if not f38_arg1.interrupted then
			f38_arg0:beginAnimation("pulse_out", CoD.VotingPopup.PulseDuration)
			f38_arg0:setAlpha(CoD.VotingPopup.PulseOutAlpha)
		end
	end)
end

CoD.VotingPopup.HandleMouseEvent = function (f21_arg0, f21_arg1)
	CoD.VotingPopup.TriggerVoteSelectedEvent(f21_arg0, {
		name = "gamepad_button",
		button = f21_arg1.position,
		controller = f21_arg1.controller
	})
end

CoD.VotingPopup.AddVotingItems = function (f22_arg0, f22_arg1, f22_arg2)
	local centerElementContainer = LUI.UIElement.new()
	centerElementContainer:setLeftRight(false, false, -CoD.VotingPopup.CenterElementContainerWidth / 2, CoD.VotingPopup.CenterElementContainerWidth / 2)
	centerElementContainer:setTopBottom(false, false, CoD.VotingPopup.CenterElementOffset - CoD.VotingPopup.CenterElementContainerHeight / 2, CoD.VotingPopup.CenterElementOffset + CoD.VotingPopup.CenterElementContainerHeight / 2)
	centerElementContainer:registerEventHandler("voteSelected", CoD.VotingPopup.VoteSelected)
	centerElementContainer:registerEventHandler("resetSelectedVoteGlow", CoD.VotingPopup.ResetSelectedVoteGlow)
	centerElementContainer:registerEventHandler("pulse_select_container", CoD.VotingPopup.PulseSelectContainer)
	centerElementContainer:registerEventHandler("change_to_default_state", CoD.VotingPopup.SetDefaultCenterElementState)
	if CoD.useMouse then
		centerElementContainer:registerEventHandler("mouse_vote_item", CoD.VotingPopup.HandleMouseEvent)
	end
	f22_arg0:addElement(centerElementContainer)
	f22_arg0.centerElementContainer = centerElementContainer
	
	centerElementContainer.handleGamepadButton = CoD.VotingPopup.HandleGamepadButton
	centerElementContainer.votingPopup = f22_arg0
	CoD.VotingPopup.CreateCenterElement(centerElementContainer)
	CoD.VotingPopup.GetVotingItemsDetails(centerElementContainer, f22_arg2.voteItems)
	local f22_local1 = centerElementContainer.selectElementContainer
	
	local textElement = LUI.UIText.new()
	textElement:setLeftRight(true, true, 0, 0)
	textElement:setTopBottom(false, false, -CoD.textSize.ExtraSmall / 2, CoD.textSize.ExtraSmall / 2)
	textElement:setFont(CoD.fonts.ExtraSmall)
	textElement:setAlignment(LUI.Alignment.Center)
	textElement:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	textElement:setText(f22_arg2.voteforstring)
	f22_local1:addElement(textElement)
	f22_local1.textElement = textElement
	
	if centerElementContainer.LeftVotingItem ~= nil then
		CoD.VotingPopup.CreateLeftVotingElement(centerElementContainer, centerElementContainer.LeftVotingItem)
	end
	if centerElementContainer.RightVotingItem ~= nil then
		CoD.VotingPopup.CreateRightVotingElement(centerElementContainer, centerElementContainer.RightVotingItem)
	end
	if centerElementContainer.TopVotingItem ~= nil then
		CoD.VotingPopup.CreateTopVotingElement(centerElementContainer, centerElementContainer.TopVotingItem)
	end
	if centerElementContainer.BottomVotingItem ~= nil then
		CoD.VotingPopup.CreateBottomVotingElement(centerElementContainer, centerElementContainer.BottomVotingItem)
	end
end

CoD.VotingPopup.VoteSubmitted = function (f23_arg0, f23_arg1)
	local f23_local0 = f23_arg0.centerElementContainer.selectedCounterName
	f23_arg0.m_vote = f23_local0
	f23_arg0.m_itemName = f23_arg0.centerElementContainer.selectedItemName
	if f23_local0 ~= nil then
		Engine.ExecNow(f23_arg1.controller, "incrementCounter " .. f23_local0 .. " " .. "1")
		Engine.ExecNow(f23_arg1.controller, "forceFlushCounterQueue")
		Engine.ExecNow(f23_arg1.controller, "setVote")
	end
	CoD.VotingPopup.Close(f23_arg0, f23_arg1)
	if f23_local0 ~= nil then
		CoD.VotingPopup.SendVotingRecordEvent(f23_arg1.controller, "SUBMITTED", f23_local0)
	end
	Engine.PlaySound("cac_grid_equip_item")
end

CoD.VotingPopup.CreateControls = function (f24_arg0)
	f24_arg0.backButton = CoD.ButtonPrompt.new("secondary", Engine.Localize("MENU_BACK"), f24_arg0, "button_prompt_back")
	f24_arg0.remindLater = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_VOTING_REMIND_LATER"), f24_arg0, "voting_remind_later")
	f24_arg0:registerEventHandler("voting_remind_later", CoD.VotingPopup.RemindLater)
	f24_arg0.vote = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_VOTING_VOTE_STRING"), f24_arg0, "vote_submit")
	f24_arg0:registerEventHandler("vote_submit", CoD.VotingPopup.VoteSubmitted)
	if not CoD.isPC then
		f24_arg0.voteSelection = CoD.ButtonPrompt.new("dpad_all", Engine.Localize("MENU_SELECT"))
	end
	local f24_local0 = CoD.ButtonPrompt.new
	local f24_local1 = "alt1"
	local f24_local2 = Engine.Localize("MENU_VOTING_NEVER_REMIND_AGAIN")
	local f24_local3 = f24_arg0
	local f24_local4 = "voting_never_remind"
	local f24_local5, f24_local6 = false
	local f24_local7, f24_local8 = false
	f24_arg0.neverRemindAgain = f24_local0(f24_local1, f24_local2, f24_local3, f24_local4, f24_local5, f24_local6, f24_local7, f24_local8, "N")
	f24_arg0:registerEventHandler("voting_never_remind", CoD.VotingPopup.NeverRemind)
end

CoD.VotingPopup.AddDefaultControls = function (f25_arg0, f25_arg1)
	f25_arg0.leftButtonPromptBar:removeAllChildren()
	f25_arg0.rightButtonPromptBar:removeAllChildren()
	local f25_local0 = f25_arg0.viewCount
	if f25_local0 ~= nil and f25_local0 <= Engine.GetVotingMenuViewCount(f25_arg1.controller) then
		f25_arg0:addRightButtonPrompt(f25_arg0.neverRemindAgain)
	end
	f25_arg0:addLeftButtonPrompt(f25_arg0.remindLater)
	f25_arg0:addLeftButtonPrompt(f25_arg0.backButton)
	if f25_arg0.voteSelection then
		f25_arg0:addLeftButtonPrompt(f25_arg0.voteSelection)
	end
end

CoD.VotingPopup.AddVoteSubmissionControls = function (f26_arg0, f26_arg1)
	f26_arg0.leftButtonPromptBar:removeAllChildren()
	f26_arg0:addLeftButtonPrompt(f26_arg0.vote)
	f26_arg0:addLeftButtonPrompt(f26_arg0.backButton)
	if f26_arg0.voteSelection then
		f26_arg0:addLeftButtonPrompt(f26_arg0.voteSelection)
	end
end

CoD.VotingPopup.NeverRemind = function (f27_arg0, f27_arg1)
	Engine.ExecNow(f27_arg1.controller, "setVoteOptOut")
	CoD.VotingPopup.Close(f27_arg0, f27_arg1)
	CoD.VotingPopup.SendVotingRecordEvent(f27_arg1.controller, "OPT_OUT")
end

CoD.VotingPopup.SendVotingRecordEvent = function (f28_arg0, f28_arg1, f28_arg2)
	if f28_arg2 ~= nil then
		Engine.SendVotingRecordEvent(f28_arg0, CoD.RECORD_EVENT_VOTE_MTX, f28_arg1, f28_arg2)
	else
		Engine.SendVotingRecordEvent(f28_arg0, CoD.RECORD_EVENT_VOTE_MTX, f28_arg1)
	end
end

CoD.VotingPopup.RemindLater = function (f29_arg0, f29_arg1)
	CoD.VotingPopup.Close(f29_arg0, f29_arg1)
	CoD.VotingPopup.SendVotingRecordEvent(f29_arg1.controller, "POSTPONED")
end

CoD.VotingPopup.SetAndUploadVotingStats = function (f30_arg0, f30_arg1)
	if f30_arg0.version == nil then
		f30_arg0.version = 0
	end
	Engine.ExecNow(f30_arg1.controller, "setVotingMenuViewed " .. f30_arg0.version)
	Engine.Exec(f30_arg1.controller, "uploadstats")
end

CoD.VotingPopup.Close = function (f31_arg0, f31_arg1)
	CoD.VotingPopup.SetAndUploadVotingStats(f31_arg0, f31_arg1)
	if f31_arg0.m_vote == nil then
		f31_arg0:goBack()
		f31_arg0.occludedMenu:processEvent({
			name = "voting_popup_closed",
			controller = f31_arg1.controller
		})
	else
		local f31_local0 = f31_arg0.m_vote
		local f31_local1 = f31_arg0.m_itemName
		local f31_local2 = f31_arg0.centerElementContainer.TopVotingItem
		local f31_local3 = f31_arg0.centerElementContainer.LeftVotingItem
		local f31_local4 = f31_arg0.centerElementContainer.RightVotingItem
		local f31_local5 = f31_arg0.centerElementContainer.BottomVotingItem
		local f31_local6 = f31_arg0.occludedMenu
		f31_arg0:close()
		local f31_local7 = f31_local6:openPopup("VotingConfirmation", f31_arg1.controller)
		f31_local7.m_vote = f31_local0
		f31_local7.m_itemName = f31_local1
		f31_local7.TopVotingItem = f31_local2
		f31_local7.LeftVotingItem = f31_local3
		f31_local7.RightVotingItem = f31_local4
		f31_local7.BottomVotingItem = f31_local5
		f31_local7:setup()
	end
end

CoD.VotingPopup.ChangeTitle = function (f32_arg0, f32_arg1)
	if f32_arg1.itemName ~= nil then
		f32_arg0.title:setText(Engine.Localize("MENU_CONTEXTUAL_VOTING_TITLE", UIExpression.ToUpper(nil, f32_arg1.itemName)))
	else
		f32_arg0.title:setText(f32_arg0.titleText)
	end
end

LUI.createMenu.VotingPopup = function (f33_arg0)
	local f33_local0 = CoD.Menu.New("VotingPopup")
	f33_local0:addLargePopupBackground()
	f33_local0:registerEventHandler("change_to_submission_controls", CoD.VotingPopup.AddVoteSubmissionControls)
	f33_local0:registerEventHandler("change_to_default_controls", CoD.VotingPopup.AddDefaultControls)
	f33_local0:registerEventHandler("change_title", CoD.VotingPopup.ChangeTitle)
	local f33_local1 = Engine.GetVotingData()
	if f33_local1.isValid == true then
		local f33_local2 = CoD.VotingPopup.MessageTop
		f33_local0.titleText = f33_local1.title
		CoD.VotingPopup.AddTitle(f33_local0, f33_local1.title, f33_local2)
		CoD.VotingPopup.AddSubtitle(f33_local0, f33_local1.subtitle, f33_local2 + CoD.textSize.Big + 10)
		f33_local0.version = f33_local1.votingVersion
		CoD.VotingPopup.AddVotingItems(f33_local0, f33_arg0, f33_local1)
		f33_local0.centerElementContainer.directionx = 0
		f33_local0.centerElementContainer.directiony = 0
		f33_local0.viewCount = f33_local1.viewCount
		CoD.VotingPopup.CreateControls(f33_local0)
		CoD.VotingPopup.AddDefaultControls(f33_local0, {
			controller = f33_arg0
		})
	else
		f33_local0:addBackButton()
	end
	return f33_local0
end

