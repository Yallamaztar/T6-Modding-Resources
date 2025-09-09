require("T6.SideBracketsImage")
CoD.ImageNavButton = {}
CoD.ImageNavButton.BracketAnimDistance = 50
CoD.ImageNavButton.ButtonOverAnimTime = 150
CoD.ImageNavButton.ButtonActionSFX = "uin_main_enter"
CoD.ImageNavButton.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	if f1_arg0 == nil then
		f1_arg0 = CoD.GetDefaultAnimationState()
	end
	local f1_local0 = LUI.UIButton.new(f1_arg0, f1_arg2)
	f1_local0.id = "ImageNavButton." .. f1_arg1
	f1_local0.m_animDist = CoD.ImageNavButton.BracketAnimDistance
	if f1_arg3 ~= nil then
		f1_local0.m_animDist = f1_arg3
	end
	f1_local0.m_animTime = CoD.ImageNavButton.ButtonOverAnimTime
	if f1_arg4 ~= nil then
		f1_local0.m_animTime = f1_arg4
	end
	local Widget = LUI.UIElement.new(f1_arg0)
	f1_local0.container = Widget
	f1_local0:addElement(Widget)
	Widget:registerAnimationState("carousel_set_start", f1_arg0)
	Widget:registerAnimationState("closed", f1_arg0)
	Widget:registerAnimationState("not_selected", {
		left = -f1_local0.m_animDist,
		right = f1_local0.m_animDist,
		leftAnchor = true,
		rightAnchor = true,
		top = 0,
		bottom = 0,
		topAnchor = true,
		bottomAnchor = true
	})
	Widget:registerAnimationState("selected", f1_arg0)
	Widget:animateToState("not_selected")
	local f1_local2 = CoD.SideBracketsImage.new()
	f1_local2:registerAnimationState("not_selected", {
		alpha = 0
	})
	f1_local2:registerAnimationState("selected", {
		alpha = 1
	})
	f1_local2:animateToState("not_selected")
	f1_local0.brackets = f1_local2
	Widget:addElement(f1_local2)
	local f1_local3 = LUI.UIStreamedImage.new({
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		alpha = 0.8,
		material = RegisterMaterial(f1_arg1)
	})
	f1_local3:registerAnimationState("selected", {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		alpha = 1,
		material = RegisterMaterial(f1_arg1)
	})
	f1_local3:registerAnimationState("fade_in", {
		alpha = 1
	})
	f1_local3:registerAnimationState("fade_out", {
		alpha = 0
	})
	f1_local0.labelImage = f1_local3
	Widget:addElement(f1_local3)
	Widget:registerEventHandler("transition_complete_closed", CoD.ImageNavButton.Container_ClosedComplete)
	f1_local0:registerEventHandler("button_action", CoD.ImageNavButton.ButtonAction)
	f1_local0:registerEventHandler("dispatch_action_event", CoD.ImageNavButton.DispatchActionEvent)
	f1_local0:registerEventHandler("gain_focus", CoD.ImageNavButton.GainFocus)
	f1_local0:registerEventHandler("lose_focus", CoD.ImageNavButton.LoseFocus)
	f1_local0.openButton = CoD.ImageNavButton.OpenButton
	f1_local0.closeButton = CoD.ImageNavButton.CloseButton
	f1_local0.setupCarouselMode = CoD.ImageNavButton.SetupCarouselMode
	f1_local0.setSFX = CoD.ImageNavButton.SetSFX
	return f1_local0
end

CoD.ImageNavButton.ButtonAction = function (f2_arg0, f2_arg1)
	if f2_arg0.m_sfxName ~= nil then
		Engine.PlaySound(f2_arg0.m_sfxName)
	else
		Engine.PlaySound(CoD.ImageNavButton.ButtonActionSFX)
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

CoD.ImageNavButton.DispatchActionEvent = function (f3_arg0)
	if f3_arg0.actionEventName ~= nil then
		f3_arg0:dispatchEventToParent({
			name = f3_arg0.actionEventName,
			controller = f3_arg0.m_ownerController,
			button = f3_arg0
		})
	end
end

CoD.ImageNavButton.Container_ClosedComplete = function (f4_arg0, f4_arg1)
	f4_arg0:dispatchEventToParent({
		name = "dispatch_action_event"
	})
end

CoD.ImageNavButton.OpenButton = function (f5_arg0, f5_arg1)
	if f5_arg1 == nil then
		f5_arg1 = f5_arg0.m_animTime
	end
	f5_arg0.labelImage:animateToState("selected", f5_arg1)
	f5_arg0.brackets:animateToState("selected", f5_arg1)
	f5_arg0.container:animateToState("selected", f5_arg1)
end

CoD.ImageNavButton.CloseButton = function (f6_arg0, f6_arg1)
	if f6_arg1 == nil then
		f6_arg1 = f6_arg0.m_animTime
	end
	f6_arg0.container:animateToState("closed", f6_arg1)
	f6_arg0.labelImage:animateToState("fade_out", f6_arg1)
end

CoD.ImageNavButton.SetupCarouselMode = function (f7_arg0)
	f7_arg0:registerEventHandler("gain_focus", CoD.ImageNavButton.CarouselMode_GainFocus)
	f7_arg0:registerEventHandler("lose_focus", CoD.ImageNavButton.CarouselMode_LoseFocus)
	f7_arg0:registerEventHandler("carousel_scroll_complete", CoD.ImageNavButton.CarouselScrollComplete)
end

CoD.ImageNavButton.SetSFX = function (f8_arg0, f8_arg1)
	f8_arg0.m_sfxName = f8_arg1
end

CoD.ImageNavButton.CarouselMode_GainFocus = function (f9_arg0, f9_arg1)
	LUI.UIElement.gainFocus(f9_arg0, f9_arg1)
	f9_arg0.labelImage:animateToState("selected", f9_arg0.m_animTime)
end

CoD.ImageNavButton.GainFocus = function (f10_arg0, f10_arg1)
	LUI.UIElement.gainFocus(f10_arg0, f10_arg1)
	f10_arg0.labelImage:animateToState("selected", f10_arg0.m_animTime)
	f10_arg0.brackets:animateToState("selected", f10_arg0.m_animTime)
	f10_arg0.container:animateToState("selected", f10_arg0.m_animTime)
end

CoD.ImageNavButton.CarouselMode_LoseFocus = function (f11_arg0, f11_arg1)
	LUI.UIElement.loseFocus(f11_arg0, f11_arg1)
	f11_arg0.labelImage:animateToState("default", f11_arg0.m_animTime)
	f11_arg0.brackets:animateToState("not_selected")
	f11_arg0.container:animateToState("not_selected")
end

CoD.ImageNavButton.LoseFocus = function (f12_arg0, f12_arg1)
	LUI.UIElement.loseFocus(f12_arg0, f12_arg1)
	f12_arg0.labelImage:animateToState("default", f12_arg0.m_animTime)
	f12_arg0.brackets:animateToState("not_selected")
	f12_arg0.container:animateToState("not_selected")
end

CoD.ImageNavButton.CarouselScrollComplete = function (f13_arg0, f13_arg1)
	f13_arg0.brackets:animateToState("selected", f13_arg0.m_animTime)
	f13_arg0.container:animateToState("selected", f13_arg0.m_animTime)
end

