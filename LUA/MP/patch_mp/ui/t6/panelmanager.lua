CoD.PanelManager = {}
CoD.PanelManager.FadeInTime = 250
CoD.PanelManager.FadeOutTime = 150
CoD.PanelManager.PanelSound = "uin_navigation_select_main"
CoD.PanelManager.SlideTime = 300
CoD.PanelManager.FetchingDone = function (f1_arg0, f1_arg1)
	if not f1_arg0.slidingEnabledTimer then
		f1_arg0.slidingEnabled = true
	end
	f1_arg0:dispatchEventToChildren(f1_arg1)
end

CoD.PanelManager.EnableSliding = function (f2_arg0, f2_arg1)
	f2_arg0.slidingEnabled = true
	if f2_arg0.slidingEnabledTimer then
		f2_arg0.slidingEnabledTimer = nil
	end
end

CoD.PanelManager.SetSlidingAllowed = function (f3_arg0, f3_arg1)
	f3_arg0.slidingAllowed = f3_arg1
end

CoD.PanelManager.New = function (f4_arg0, f4_arg1, f4_arg2)
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget.id = "PanelManager"
	Widget.width = f4_arg1
	Widget.height = f4_arg2
	Widget.m_ownerController = f4_arg0
	Widget.panels = {}
	Widget.orderedPanels = {}
	Widget.createPanel = CoD.PanelManager.CreatePanel
	Widget.openPanel = CoD.PanelManager.OpenPanel
	Widget.closePanel = CoD.PanelManager.ClosePanel
	Widget.getPanel = CoD.PanelManager.GetPanel
	Widget.isPanelOnscreen = CoD.PanelManager.IsPanelOnscreen
	Widget.setSlidingAllowed = CoD.PanelManager.SetSlidingAllowed
	Widget:registerEventHandler("destroy_panel", CoD.PanelManager.DestroyPanel)
	Widget:registerEventHandler("gamepad_button", CoD.PanelManager.GamepadButton)
	Widget:registerEventHandler("fetching_done", CoD.PanelManager.FetchingDone)
	Widget:registerEventHandler("enable_sliding", CoD.PanelManager.EnableSliding)
	return Widget
end

CoD.PanelManager.AddPanelElements = function (f5_arg0)
	if f5_arg0.body ~= nil then
		error("PanelManager: BODY ALREADY EXISTS ON PANEL!")
	end
	f5_arg0.body = LUI.UIElement.new({
		left = 0,
		top = 0,
		bottom = 0,
		right = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	f5_arg0:addElement(f5_arg0.body)
	f5_arg0.body:registerAnimationState("left_offscreen", f5_arg0.m_animationStates.left_offscreen)
	f5_arg0.body:registerAnimationState("left_onscreen", f5_arg0.m_animationStates.left_onscreen)
	f5_arg0.body:registerAnimationState("right_offscreen", f5_arg0.m_animationStates.right_offscreen)
	f5_arg0.body:registerAnimationState("right_onscreen", f5_arg0.m_animationStates.right_onscreen)
end

CoD.PanelManager.CreatePanel = function (f6_arg0, f6_arg1, f6_arg2)
	if f6_arg0.panels[f6_arg1] ~= nil then
		error("LUI Error: panel " .. f6_arg1 .. " already exist.")
		return 
	end
	local f6_local0 = f6_arg0.width / 2
	local f6_local1 = f6_arg0.height / 2
	if f6_arg2 == nil then
		f6_arg2 = "left"
	end
	local f6_local2 = {
		left_offscreen = {
			left = -640 - f6_local0,
			top = 0,
			right = -640,
			bottom = 0,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		},
		left_onscreen = {
			left = 0,
			top = 0,
			right = f6_local0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		},
		right_offscreen = {
			left = 640,
			top = 0,
			right = 640 + f6_local0,
			bottom = 0,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		},
		right_onscreen = {
			left = -f6_local0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true
		},
		top_offscreen = {
			left = 0,
			top = -f6_local1,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false
		},
		top_onscreen = {
			left = 0,
			top = 0,
			right = 0,
			bottom = f6_local1,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false
		},
		bottom_offscreen = {
			left = 0,
			top = 0,
			right = 0,
			bottom = f6_local1,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true
		},
		bottom_onscreen = {
			left = 0,
			top = -f6_local1,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true
		}
	}
	local Widget = LUI.UIElement.new(f6_local2[f6_arg2 .. "_offscreen"])
	Widget.id = "PanelManager." .. f6_arg1
	Widget:registerAnimationState("left_offscreen", f6_local2.left_offscreen)
	Widget:registerAnimationState("left_onscreen", f6_local2.left_onscreen)
	Widget:registerAnimationState("right_offscreen", f6_local2.right_offscreen)
	Widget:registerAnimationState("right_onscreen", f6_local2.right_onscreen)
	Widget:registerAnimationState("top_offscreen", f6_local2.top_offscreen)
	Widget:registerAnimationState("top_onscreen", f6_local2.top_onscreen)
	Widget:registerAnimationState("bottom_offscreen", f6_local2.bottom_offscreen)
	Widget:registerAnimationState("bottom_onscreen", f6_local2.bottom_onscreen)
	f6_arg0.panels[f6_arg1] = Widget
	f6_arg0:addElement(Widget)
	table.insert(f6_arg0.orderedPanels, Widget)
	Widget.defaultState = f6_arg2
	Widget.state = f6_arg2
	Widget.panelManager = f6_arg0
	return Widget
end

CoD.PanelManager.OpenPanel = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)
	local f7_local0 = f7_arg0.panels[f7_arg1]
	if f7_local0 == nil then
		error("LUI Error: panel " .. f7_arg1 .. " does not exist.")
		return 
	elseif f7_arg4 == nil then
		f7_arg4 = CoD.PanelManager.FadeInTime
	end
	if f7_arg2 == nil then
		if f7_local0.defaultState == nil then
			f7_arg2 = "left"
		else
			f7_arg2 = f7_local0.defaultState
		end
	end
	if f7_arg3 ~= nil and f7_local0.active ~= true then
		f7_local0:animateToState(f7_arg3 .. "_offscreen", 0)
	elseif f7_local0.active ~= true and f7_local0.state ~= nil and f7_local0.state ~= f7_arg2 then
		f7_local0:animateToState(f7_arg2 .. "_offscreen", 0)
	end
	f7_local0.state = f7_arg2
	f7_local0.active = true
	f7_local0:processEvent({
		name = "on_activate",
		controller = controller
	})
	f7_local0:animateToState(f7_arg2 .. "_onscreen", f7_arg4, true, true)
	Engine.PlaySound(CoD.PanelManager.PanelSound)
end

CoD.PanelManager.ClosePanel = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4)
	local f8_local0 = f8_arg0.panels[f8_arg1]
	if f8_local0 == nil then
		error("LUI Error: panel " .. f8_arg1 .. " does not exist.")
		return 
	elseif f8_arg4 == nil then
		f8_arg4 = CoD.PanelManager.FadeOutTime
	end
	if f8_arg2 == nil then
		if f8_local0.state ~= nil then
			f8_arg2 = f8_local0.state
		elseif f8_local0.defaultState == nil then
			f8_arg2 = "left"
		else
			f8_arg2 = f8_local0.defaultState
		end
	end
	f8_local0:animateToState(f8_arg2 .. "_offscreen", f8_arg4, true, true)
	if f8_arg3 == true then
		f8_local0:processEvent({
			name = "on_deactivate",
			controller = controller
		})
		f8_local0:addElement(LUI.UITimer.new(f8_arg4, {
			name = "destroy_panel",
			panelName = f8_arg1
		}, true, f8_arg0))
	else
		f8_local0:processEvent({
			name = "lose_focus"
		})
		f8_local0:processEvent({
			name = "on_deactivate"
		})
	end
	f8_local0.active = nil
	Engine.PlaySound(CoD.PanelManager.PanelSound)
end

CoD.PanelManager.DestroyPanel = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg1.panelName
	if f9_arg0.panels[f9_local0] ~= nil then
		f9_arg0.panels[f9_local0]:close()
		f9_arg0.panels[f9_local0] = nil
	end
end

CoD.PanelManager.GetPanel = function (f10_arg0, f10_arg1)
	return f10_arg0.panels[f10_arg1]
end

CoD.PanelManager.IsPanelOnscreen = function (f11_arg0, f11_arg1)
	local f11_local0 = f11_arg0.panels[f11_arg1]
	if f11_local0 == nil then
		return false
	elseif f11_arg0.orderedPanels[f11_arg0.currentPanelIndex] == f11_local0 then
		return true
	elseif f11_arg0.orderedPanels[f11_arg0.currentPanelIndex + 1] == f11_local0 then
		return true
	else
		return false
	end
end

CoD.PanelManager.ClosePanelBody = function (f12_arg0)
	if f12_arg0.body == nil then
		error("LUI Error: body of panel " .. f12_arg0.id .. " does not exist.")
		return 
	else
		f12_arg0.body:close()
		f12_arg0.body = nil
		f12_arg0:registerEventHandler("transition_complete_left_offscreen", nil)
		f12_arg0:registerEventHandler("transition_complete_right_offscreen", nil)
	end
end

CoD.PanelManager.BuildPanel = function (f13_arg0, f13_arg1)
	f13_arg1:addPanelElements()
	f13_arg1:populatePanelElements()
	if not f13_arg1:restoreState() then
		f13_arg1:setFocusPanelElements()
	end
end

CoD.PanelManager.RebuildPanel = function (f14_arg0, f14_arg1)
	local f14_local0 = f14_arg0.panels[f14_arg1]
	if f14_local0 == nil then
		error("LUI Error: panel " .. f14_arg1 .. " does not exist.")
		return 
	else
		CoD.PanelManager.ClosePanelBody(f14_local0)
		CoD.PanelManager.BuildPanel(f14_arg0, f14_local0)
	end
end

CoD.PanelManager.StartSlidingTimer = function (f15_arg0)
	f15_arg0.slidingEnabled = false
	f15_arg0.slidingEnabledTimer = LUI.UITimer.new(CoD.PanelManager.SlideTime + 5, "enable_sliding", true)
	f15_arg0:addElement(f15_arg0.slidingEnabledTimer)
end

CoD.PanelManager.SlidePanelOffscreen = function (f16_arg0, f16_arg1, f16_arg2)
	local f16_local0 = f16_arg2 .. "_offscreen"
	f16_arg1:registerEventHandler("transition_complete_" .. f16_local0, CoD.PanelManager.ClosePanelBody)
	f16_arg1:animateToState(f16_local0, CoD.PanelManager.SlideTime, true, true)
	f16_arg1:processEvent({
		name = "sliding_offscreen",
		position = f16_local0
	})
end

CoD.PanelManager.SlidePanel = function (f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = f17_arg2 .. "_onscreen"
	f17_arg1:animateToState(f17_local0, CoD.PanelManager.SlideTime, true, true)
	f17_arg1:processEvent({
		name = "sliding_onscreen",
		position = f17_local0
	})
end

CoD.PanelManager.SlidePanelOnscreen = function (f18_arg0, f18_arg1, f18_arg2)
	f18_arg1:addPanelElements()
	f18_arg1:populatePanelElements(true)
	CoD.PanelManager.SlidePanel(f18_arg0, f18_arg1, f18_arg2)
end

CoD.PanelManager.SetPanelCurrent = function (f19_arg0, f19_arg1)
	local f19_local0 = f19_arg0.orderedPanels[f19_arg0.currentPanelIndex]
	f19_local0:saveState()
	f19_local0:processEvent({
		name = "lose_focus"
	})
	f19_arg0.currentPanelIndex = f19_arg1
	local f19_local1 = f19_arg0.orderedPanels[f19_arg1]
	if not f19_local1:restoreState() then
		f19_local1:setFocusPanelElements()
	end
	f19_arg0:dispatchEventToParent({
		name = "current_panel_changed",
		id = f19_local1.id,
		titleText = f19_local1.titleText
	})
	Engine.PlaySound("uin_navigation_wipe")
end

CoD.PanelManager.SlidePanelsLeft = function (f20_arg0, f20_arg1)
	if f20_arg0.orderedPanels[f20_arg0.currentPanelIndex - 1] ~= nil then
		CoD.PanelManager.StartSlidingTimer(f20_arg0)
		CoD.PanelManager.SlidePanelOffscreen(f20_arg0, f20_arg0.orderedPanels[f20_arg0.currentPanelIndex + 1], "right")
		CoD.PanelManager.SlidePanel(f20_arg0, f20_arg0.orderedPanels[f20_arg0.currentPanelIndex], "right")
		CoD.PanelManager.SlidePanelOnscreen(f20_arg0, f20_arg0.orderedPanels[f20_arg0.currentPanelIndex - 1], "left")
		f20_arg0.orderedPanels[f20_arg0.currentPanelIndex]:processEvent({
			name = "slide_left",
			isCurrentPanel = false
		})
		f20_arg0.orderedPanels[f20_arg0.currentPanelIndex - 1]:processEvent({
			name = "slide_left",
			isCurrentPanel = true
		})
		CoD.PanelManager.SetPanelCurrent(f20_arg0, f20_arg0.currentPanelIndex - 1)
		Engine.PlaySound("cac_screen_hpan")
	end
end

CoD.PanelManager.SlidePanelsRight = function (f21_arg0, f21_arg1)
	if f21_arg0.orderedPanels[f21_arg0.currentPanelIndex + 2] ~= nil then
		CoD.PanelManager.StartSlidingTimer(f21_arg0)
		CoD.PanelManager.SlidePanelOffscreen(f21_arg0, f21_arg0.orderedPanels[f21_arg0.currentPanelIndex], "left")
		CoD.PanelManager.SlidePanel(f21_arg0, f21_arg0.orderedPanels[f21_arg0.currentPanelIndex + 1], "left")
		CoD.PanelManager.SlidePanelOnscreen(f21_arg0, f21_arg0.orderedPanels[f21_arg0.currentPanelIndex + 2], "right")
		f21_arg0.orderedPanels[f21_arg0.currentPanelIndex + 1]:processEvent({
			name = "slide_right",
			isCurrentPanel = true
		})
		f21_arg0.orderedPanels[f21_arg0.currentPanelIndex + 2]:processEvent({
			name = "slide_right",
			isCurrentPanel = false
		})
		CoD.PanelManager.SetPanelCurrent(f21_arg0, f21_arg0.currentPanelIndex + 1)
		Engine.PlaySound("cac_screen_hpan")
	end
end

CoD.PanelManager.GamepadButton = function (f22_arg0, f22_arg1)
	if f22_arg0.slidingAllowed ~= false and f22_arg0.slidingEnabled == true and f22_arg0.orderedPanels ~= nil and f22_arg1.down == true then
		for f22_local3, f22_local4 in pairs(f22_arg0.orderedPanels) do
			f22_arg0.orderedPanels[f22_local3].controller = f22_arg1.controller
		end
		if f22_arg0.currentPanelIndex ~= nil then
			if f22_arg1.button == "left" then
				f22_arg0.slideToStatsPaneEnabled = true
				CoD.PanelManager.SlidePanelsLeft(f22_arg0)
			elseif f22_arg1.button == "right" and f22_arg0.slideToStatsPaneEnabled ~= false then
				CoD.PanelManager.SlidePanelsRight(f22_arg0)
			end
		end
	end
	return f22_arg0:dispatchEventToChildren(f22_arg1)
end

