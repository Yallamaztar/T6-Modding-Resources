require("T6.SideBracketsImage")
CoD.NavButton = {}
CoD.NavButton.BracketAnimDistance = 50
CoD.NavButton.ButtonOverAnimTime = 150
CoD.NavButton.ButtonActionSFX = "uin_main_enter"
CoD.NavButton.NormalTextFontName = "Condensed"
CoD.NavButton.SelectedTextFontName = "Big"
CoD.NavButton.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	if f1_arg0 == nil then
		f1_arg0 = CoD.GetDefaultAnimationState()
	end
	local f1_local0 = LUI.UIButton.new(f1_arg0, f1_arg2)
	f1_local0.id = "NavButton." .. f1_arg1
	f1_local0.m_animDist = CoD.NavButton.BracketAnimDistance
	if f1_arg3 ~= nil then
		f1_local0.m_animDist = f1_arg3
	end
	f1_local0.m_animTime = CoD.NavButton.ButtonOverAnimTime
	if f1_arg4 ~= nil then
		f1_local0.m_animTime = f1_arg4
	end
	local f1_local1 = CoD.NavButton.NormalTextFontName
	local f1_local2 = CoD.NavButton.SelectedTextFontName
	local f1_local3 = {}
	f1_local3 = GetTextDimensions(f1_arg1, CoD.fonts[f1_local2], CoD.textSize[f1_local2])
	f1_local0.m_textWidth = f1_local3[3] + 30
	local Widget = LUI.UIElement.new({
		left = -f1_local0.m_textWidth / 2,
		right = f1_local0.m_textWidth / 2,
		leftAnchor = false,
		rightAnchor = false,
		top = 0,
		bottom = 0,
		topAnchor = true,
		bottomAnchor = true
	})
	Widget:setUseStencil(true)
	f1_local0.container = Widget
	f1_local0:addElement(Widget)
	Widget:registerAnimationState("carousel_set_start", {
		left = -10,
		right = 10,
		leftAnchor = false,
		rightAnchor = false
	})
	Widget:registerAnimationState("closed", {
		left = -10,
		right = 10,
		leftAnchor = false,
		rightAnchor = false
	})
	Widget:registerAnimationState("not_selected", {
		left = -(f1_local0.m_textWidth / 2) - f1_local0.m_animDist,
		right = f1_local0.m_textWidth / 2 + f1_local0.m_animDist,
		leftAnchor = false,
		rightAnchor = false,
		top = 0,
		bottom = 0,
		topAnchor = true,
		bottomAnchor = true
	})
	Widget:registerAnimationState("selected", {
		left = -f1_local0.m_textWidth / 2,
		right = f1_local0.m_textWidth / 2,
		top = 0,
		bottom = 0,
		leftAnchor = false,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = true
	})
	Widget:animateToState("not_selected")
	local f1_local5 = CoD.SideBracketsImage.new()
	f1_local5:registerAnimationState("not_selected", {
		alpha = 0
	})
	f1_local5:registerAnimationState("selected", {
		alpha = 1
	})
	f1_local5:animateToState("not_selected")
	f1_local0.brackets = f1_local5
	Widget:addElement(f1_local5)
	local f1_local6 = LUI.UIText.new({
		left = 0,
		right = 0,
		top = -CoD.textSize[f1_local1] / 2,
		bottom = CoD.textSize[f1_local1] / 2,
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = false,
		bottomAnchor = false,
		red = CoD.DisabledTextColor.r,
		green = CoD.DisabledTextColor.g,
		blue = CoD.DisabledTextColor.b,
		font = CoD.fonts[f1_local1],
		alpha = CoD.DisabledAlpha
	})
	f1_local6:registerAnimationState("selected", {
		left = 0,
		right = 0,
		top = -CoD.textSize[f1_local2] / 2,
		bottom = CoD.textSize[f1_local2] / 2,
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts[f1_local2],
		red = CoD.trueOrange.r,
		green = CoD.trueOrange.g,
		blue = CoD.trueOrange.b,
		alpha = 1
	})
	f1_local6:registerAnimationState("fade_in", {
		alpha = 1
	})
	f1_local6:registerAnimationState("fade_out", {
		alpha = 0
	})
	f1_local6:setText(f1_arg1)
	f1_local0.labelText = f1_local6
	Widget:addElement(f1_local6)
	Widget:registerEventHandler("transition_complete_closed", CoD.NavButton.Container_ClosedComplete)
	f1_local0:registerEventHandler("button_action", CoD.NavButton.ButtonAction)
	f1_local0:registerEventHandler("dispatch_action_event", CoD.NavButton.DispatchActionEvent)
	f1_local0:registerEventHandler("gain_focus", CoD.NavButton.GainFocus)
	f1_local0:registerEventHandler("lose_focus", CoD.NavButton.LoseFocus)
	f1_local0.openButton = CoD.NavButton.OpenButton
	f1_local0.closeButton = CoD.NavButton.CloseButton
	f1_local0.setupCarouselMode = CoD.NavButton.SetupCarouselMode
	f1_local0.setSFX = CoD.NavButton.SetSFX
	return f1_local0
end

CoD.NavButton.ButtonAction = function (f2_arg0, f2_arg1)
	if f2_arg0.m_sfxName ~= nil then
		Engine.PlaySound(f2_arg0.m_sfxName)
	else
		Engine.PlaySound(CoD.NavButton.ButtonActionSFX)
	end
	if f2_arg0.m_isClosed == true then
		f2_arg0:openButton()
		f2_arg0.m_isClosed = nil
	else
		f2_arg0:closeButton()
		f2_arg0.m_ownerController = f2_arg1.controller
		f2_arg0.m_isClosed = true
	end
end

CoD.NavButton.DispatchActionEvent = function (f3_arg0)
	if f3_arg0.actionEventName ~= nil then
		f3_arg0:dispatchEventToParent({
			name = f3_arg0.actionEventName,
			controller = f3_arg0.m_ownerController,
			button = f3_arg0
		})
	end
end

CoD.NavButton.Container_ClosedComplete = function (f4_arg0, f4_arg1)
	f4_arg0:dispatchEventToParent({
		name = "dispatch_action_event"
	})
end

CoD.NavButton.OpenButton = function (f5_arg0, f5_arg1)
	if f5_arg1 == nil then
		f5_arg1 = f5_arg0.m_animTime
	end
	f5_arg0.labelText:animateToState("selected", f5_arg1)
	f5_arg0.brackets:animateToState("selected", f5_arg1)
	f5_arg0.container:animateToState("selected", f5_arg1)
end

CoD.NavButton.CloseButton = function (f6_arg0, f6_arg1)
	if f6_arg1 == nil then
		f6_arg1 = f6_arg0.m_animTime
	end
	f6_arg0.container:animateToState("closed", f6_arg1)
	f6_arg0.labelText:animateToState("fade_out", f6_arg1)
end

CoD.NavButton.SetupCarouselMode = function (f7_arg0)
	f7_arg0:registerEventHandler("gain_focus", CoD.NavButton.CarouselMode_GainFocus)
	f7_arg0:registerEventHandler("lose_focus", CoD.NavButton.CarouselMode_LoseFocus)
	f7_arg0:registerEventHandler("carousel_scroll_complete", CoD.NavButton.CarouselScrollComplete)
	f7_arg0:registerEventHandler("carousel_mouse_enter", CoD.NavButton.CarouselMouseEnter)
	f7_arg0:registerEventHandler("carousel_mouse_leave", CoD.NavButton.CarouselMouseLeave)
end

CoD.NavButton.SetSFX = function (f8_arg0, f8_arg1)
	f8_arg0.m_sfxName = f8_arg1
end

CoD.NavButton.CarouselMode_GainFocus = function (f9_arg0, f9_arg1)
	LUI.UIElement.gainFocus(f9_arg0, f9_arg1)
	f9_arg0.labelText:animateToState("selected", f9_arg0.m_animTime)
end

CoD.NavButton.GainFocus = function (f10_arg0, f10_arg1)
	LUI.UIElement.gainFocus(f10_arg0, f10_arg1)
	f10_arg0.labelText:animateToState("selected", f10_arg0.m_animTime)
	f10_arg0.brackets:animateToState("selected", f10_arg0.m_animTime)
	f10_arg0.container:animateToState("selected", f10_arg0.m_animTime)
end

CoD.NavButton.CarouselMode_LoseFocus = function (f11_arg0, f11_arg1)
	LUI.UIElement.loseFocus(f11_arg0, f11_arg1)
	f11_arg0.labelText:animateToState("default", f11_arg0.m_animTime)
	f11_arg0.brackets:animateToState("not_selected")
	f11_arg0.container:animateToState("not_selected")
end

CoD.NavButton.LoseFocus = function (f12_arg0, f12_arg1)
	LUI.UIElement.loseFocus(f12_arg0, f12_arg1)
	f12_arg0.labelText:animateToState("default", f12_arg0.m_animTime)
	f12_arg0.brackets:animateToState("not_selected")
	f12_arg0.container:animateToState("not_selected")
end

CoD.NavButton.CarouselScrollComplete = function (f13_arg0, f13_arg1)
	f13_arg0.brackets:animateToState("selected", f13_arg0.m_animTime)
	f13_arg0.container:animateToState("selected", f13_arg0.m_animTime)
end

CoD.NavButton.CarouselMouseEnter = function (f14_arg0, f14_arg1)
	local f14_local0 = nil
	if f14_arg1.isSelected then
		f14_local0 = CoD.textSize[CoD.NavButton.SelectedTextFontName] * 1.1
	else
		f14_local0 = CoD.textSize[CoD.NavButton.NormalTextFontName] * 1.2
	end
	local f14_local1 = f14_arg0.labelText
	f14_local1:beginAnimation("mouse_highlight", f14_arg0.m_animTime)
	f14_local1:setTopBottom(false, false, -f14_local0 / 2, f14_local0 / 2)
end

CoD.NavButton.CarouselMouseLeave = function (f15_arg0, f15_arg1)
	if f15_arg1.isSelected then
		f15_arg0.labelText:animateToState("selected", f15_arg0.m_animTime)
	else
		f15_arg0.labelText:animateToState("default", f15_arg0.m_animTime)
	end
end

