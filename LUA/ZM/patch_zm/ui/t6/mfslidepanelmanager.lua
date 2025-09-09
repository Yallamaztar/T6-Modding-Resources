local f0_local0, f0_local1, f0_local2, f0_local3, f0_local4, f0_local5 = nil
CoD.MFSlidePanelManager = {}
CoD.MFSlidePanelManager.FadeInTime = 250
CoD.MFSlidePanelManager.FadeOutTime = 150
CoD.MFSlidePanelManager.PanelSound = "uin_navigation_select_main"
CoD.MFSlidePanelManager.SlideTime = 300
local f0_local6 = function (f1_arg0, f1_arg1)
	f1_arg0.slidingAllowed = true
	f1_arg0:dispatchEventToChildren(f1_arg1)
end

local f0_local7 = function (f2_arg0, f2_arg1)
	f2_arg0.slidingAllowed = true
end

local f0_local8 = function (f3_arg0, f3_arg1)
	f3_arg0.slide = f3_arg1
end

CoD.MFSlidePanelManager.new = function ()
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
	Widget.id = "MFSlidePanelManager"
	Widget.panels = {}
	Widget.orderedPanels = {}
	Widget.createPanel = f0_local0
	Widget.openPanel = f0_local1
	Widget.closePanel = f0_local2
	Widget.getPanel = f0_local4
	Widget.setSlide = f0_local8
	Widget.isPanelOnscreen = MFSlidePanelManager_IsPanelOnscreen
	Widget:registerEventHandler("destroy_panel", f0_local3)
	Widget:registerEventHandler("gamepad_button", f0_local5)
	Widget:registerEventHandler("fetching_done", f0_local6)
	Widget:registerEventHandler("allow_sliding", f0_local7)
	return Widget
end

CoD.MFSlidePanelManager.AddPanelElements = function (f5_arg0)
	if f5_arg0.body ~= nil then
		error("MFSlidePanelManager: BODY ALREADY EXISTS ON PANEL!")
	end
	f5_arg0.body = CoD.MFSlidePanel.new({
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

f0_local0 = function (f6_arg0, f6_arg1, f6_arg2)
	if f6_arg0.panels[f6_arg1] ~= nil then
		error("LUI Error: panel " .. f6_arg1 .. " already exist.")
		return 
	end
	local f6_local0 = 0
	local f6_local1 = 0
	if UIExpression.IsInGame() == 1 then
		f6_local0 = f6_arg0.slide.width / 2
		f6_local1 = f6_arg0.slide.height / 2
	else
		f6_local0 = f6_arg0.slide.slideContainer.slideWidth / 2
		f6_local1 = f6_arg0.slide.slideContainer.slideHeight / 2
	end
	if f6_arg2 == nil then
		f6_arg2 = "left"
	end
	local f6_local2 = {
		left_offscreen = {
			left = -f6_local0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
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
			left = 0,
			top = 0,
			right = f6_local0,
			bottom = 0,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = true,
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
	Widget.id = "MFSlidePanelManager." .. f6_arg1
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
	Widget.slide = f6_arg0.slide
	return Widget
end

f0_local1 = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4, f7_arg5)
	local f7_local0 = f7_arg0.panels[f7_arg1]
	if f7_local0 == nil then
		error("LUI Error: panel " .. f7_arg1 .. " does not exist.")
		return 
	elseif f7_arg5 == nil then
		f7_arg5 = CoD.MFSlidePanelManager.FadeInTime
	end
	if f7_arg2 == nil then
		if f7_local0.defaultState == nil then
			f7_arg2 = "left"
		else
			f7_arg2 = f7_local0.defaultState
		end
	end
	if f7_arg4 ~= nil and f7_local0.active ~= true then
		f7_local0:animateToState(f7_arg4 .. "_offscreen", 0)
	elseif f7_local0.active ~= true and f7_local0.state ~= nil and f7_local0.state ~= f7_arg2 then
		f7_local0:animateToState(f7_arg2 .. "_offscreen", 0)
	end
	f7_local0.state = f7_arg2
	f7_local0.active = true
	if f7_arg3 ~= true then
		f7_local0:processEvent({
			name = "on_activate",
			controller = controller
		})
	end
	f7_local0:animateToState(f7_arg2 .. "_onscreen", f7_arg5, true, true)
	Engine.PlaySound(CoD.MFSlidePanelManager.PanelSound)
end

f0_local2 = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4)
	local f8_local0 = f8_arg0.slide.m_ownerController
	local f8_local1 = f8_arg0.panels[f8_arg1]
	if f8_local1 == nil then
		error("LUI Error: panel " .. f8_arg1 .. " does not exist.")
		return 
	elseif f8_arg4 == nil then
		f8_arg4 = CoD.MFSlidePanelManager.FadeOutTime
	end
	if f8_arg2 == nil then
		if f8_local1.state ~= nil then
			f8_arg2 = f8_local1.state
		elseif f8_local1.defaultState == nil then
			f8_arg2 = "left"
		else
			f8_arg2 = f8_local1.defaultState
		end
	end
	f8_local1:animateToState(f8_arg2 .. "_offscreen", f8_arg4, true, true)
	if f8_arg3 == true then
		f8_local1:processEvent({
			name = "on_destroy",
			controller = f8_local0
		})
		f8_local1:addElement(LUI.UITimer.new(f8_arg4, {
			name = "destroy_panel",
			panelName = f8_arg1
		}, true, f8_arg0))
	else
		f8_local1:processEvent({
			name = "lose_focus"
		})
		f8_local1:processEvent({
			name = "on_deactivate",
			controller = f8_local0
		})
	end
	f8_local1.active = nil
	Engine.PlaySound(CoD.MFSlidePanelManager.PanelSound)
end

f0_local3 = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg1.panelName
	if f9_arg0.panels[f9_local0] ~= nil then
		f9_arg0.panels[f9_local0]:close()
		f9_arg0.panels[f9_local0] = nil
	end
end

f0_local4 = function (f10_arg0, f10_arg1)
	return f10_arg0.panels[f10_arg1]
end

function MFSlidePanelManager_IsPanelOnscreen(f11_arg0, f11_arg1)
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

function MFSlidePanelManager_ClosePanelBody(f12_arg0)
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

function MFSlidePanelManager_BuildPanel(f13_arg0, f13_arg1)
	f13_arg1:addPanelElements()
	f13_arg1:populatePanelElements()
	if not f13_arg1:restoreState() then
		f13_arg1:setFocusPanelElements()
	end
end

CoD.MFSlidePanelManager.RebuildPanel = function (f14_arg0, f14_arg1)
	local f14_local0 = f14_arg0.panels[f14_arg1]
	if f14_local0 == nil then
		error("LUI Error: panel " .. f14_arg1 .. " does not exist.")
		return 
	else
		MFSlidePanelManager_ClosePanelBody(f14_local0)
		MFSlidePanelManager_BuildPanel(f14_arg0, f14_local0)
	end
end

CoD.MFSlidePanelManager.StartSlidingTimer = function (f15_arg0)
	f15_arg0.slidingAllowed = false
	f15_arg0.allowSlidingTimer = LUI.UITimer.new(CoD.MFSlidePanelManager.SlideTime + 5, "allow_sliding", true)
	f15_arg0:addElement(f15_arg0.allowSlidingTimer)
end

CoD.MFSlidePanelManager.SlidePanelOffscreen = function (f16_arg0, f16_arg1, f16_arg2)
	local f16_local0 = f16_arg2 .. "_offscreen"
	f16_arg1:registerEventHandler("transition_complete_" .. f16_local0, MFSlidePanelManager_ClosePanelBody)
	f16_arg1:animateToState(f16_local0, CoD.MFSlidePanelManager.SlideTime, true, true)
	f16_arg1:processEvent({
		name = "sliding_offscreen",
		position = f16_local0
	})
end

CoD.MFSlidePanelManager.SlidePanel = function (f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = f17_arg2 .. "_onscreen"
	f17_arg1:animateToState(f17_local0, CoD.MFSlidePanelManager.SlideTime, true, true)
	f17_arg1:processEvent({
		name = "sliding_onscreen",
		position = f17_local0
	})
end

CoD.MFSlidePanelManager.SlidePanelOnscreen = function (f18_arg0, f18_arg1, f18_arg2)
	f18_arg1:addPanelElements()
	f18_arg1:populatePanelElements()
	CoD.MFSlidePanelManager.SlidePanel(f18_arg0, f18_arg1, f18_arg2)
end

CoD.MFSlidePanelManager.SetPanelCurrent = function (f19_arg0, f19_arg1)
	local f19_local0 = f19_arg0.orderedPanels[f19_arg0.currentPanelIndex]
	f19_local0:saveState()
	f19_local0:processEvent({
		name = "lose_focus"
	})
	f19_arg0.currentPanelIndex = f19_arg1
	local f19_local1 = f19_arg0.orderedPanels[f19_arg1]
	f19_arg0.slide.frame.title:setText(f19_local1.frameTitleText)
	if not f19_local1:restoreState() then
		f19_local1:setFocusPanelElements()
	end
	f19_arg0:dispatchEventToParent({
		name = "current_panel_changed",
		id = f19_local1.id
	})
	Engine.PlaySound("uin_navigation_wipe")
end

CoD.MFSlidePanelManager.SlidePanelsLeft = function (f20_arg0, f20_arg1)
	if f20_arg0.orderedPanels[f20_arg0.currentPanelIndex - 1] ~= nil then
		CoD.MFSlidePanelManager.StartSlidingTimer(f20_arg0)
		CoD.MFSlidePanelManager.SlidePanelOffscreen(f20_arg0, f20_arg0.orderedPanels[f20_arg0.currentPanelIndex + 1], "right")
		CoD.MFSlidePanelManager.SlidePanel(f20_arg0, f20_arg0.orderedPanels[f20_arg0.currentPanelIndex], "right")
		CoD.MFSlidePanelManager.SlidePanelOnscreen(f20_arg0, f20_arg0.orderedPanels[f20_arg0.currentPanelIndex - 1], "left")
		CoD.MFSlidePanelManager.SetPanelCurrent(f20_arg0, f20_arg0.currentPanelIndex - 1)
	end
end

CoD.MFSlidePanelManager.SlidePanelsRight = function (f21_arg0, f21_arg1)
	if f21_arg0.orderedPanels[f21_arg0.currentPanelIndex + 2] ~= nil then
		CoD.MFSlidePanelManager.StartSlidingTimer(f21_arg0)
		CoD.MFSlidePanelManager.SlidePanelOffscreen(f21_arg0, f21_arg0.orderedPanels[f21_arg0.currentPanelIndex], "left")
		CoD.MFSlidePanelManager.SlidePanel(f21_arg0, f21_arg0.orderedPanels[f21_arg0.currentPanelIndex + 1], "left")
		CoD.MFSlidePanelManager.SlidePanelOnscreen(f21_arg0, f21_arg0.orderedPanels[f21_arg0.currentPanelIndex + 2], "right")
		CoD.MFSlidePanelManager.SetPanelCurrent(f21_arg0, f21_arg0.currentPanelIndex + 1)
	end
end

f0_local5 = function (f22_arg0, f22_arg1)
	if f22_arg0.slidingAllowed == true and f22_arg0.orderedPanels ~= nil and f22_arg1.down == true then
		for f22_local3, f22_local4 in pairs(f22_arg0.orderedPanels) do
			f22_arg0.orderedPanels[f22_local3].controller = f22_arg1.controller
		end
		if f22_arg0.currentPanelIndex ~= nil then
			if f22_arg1.button == "left" then
				CoD.MFSlidePanelManager.SlidePanelsLeft(f22_arg0)
			elseif f22_arg1.button == "right" then
				CoD.MFSlidePanelManager.SlidePanelsRight(f22_arg0)
			end
		end
	end
	return f22_arg0:dispatchEventToChildren(f22_arg1)
end

