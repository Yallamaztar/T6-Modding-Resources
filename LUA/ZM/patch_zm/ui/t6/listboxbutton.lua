CoD.ListBoxButton = {}
CoD.ListBoxButton.click = function (f1_arg0, f1_arg1)
	f1_arg0:dispatchEventToParent({
		name = f1_arg1.name,
		controller = f1_arg1.controller,
		mutables = f1_arg0.body.m_mutables
	})
	f1_arg0.body:processEvent(f1_arg1)
end

CoD.ListBoxButton.unclick = function (f2_arg0, f2_arg1)
	f2_arg0:animateToState("button_highlighted", 5)
	f2_arg0.body:processEvent(f2_arg1)
end

CoD.ListBoxButton.gainFocus = function (f3_arg0, f3_arg1)
	LUI.UIElement.gainFocus(f3_arg0, f3_arg1)
	f3_arg0.body.buttonBorder:animateToState("bg_highlighted", 0)
	f3_arg0:animateToState("button_highlighted", 0)
	f3_arg0:dispatchEventToParent({
		name = "listbox_button_gain_focus",
		controller = f3_arg1.controller,
		mutables = f3_arg0.body.m_mutables
	})
end

CoD.ListBoxButton.loseFocus = function (f4_arg0, f4_arg1)
	LUI.UIElement.loseFocus(f4_arg0, f4_arg1)
	f4_arg0.body.buttonBorder:animateToState("bg_not_highlighted", 0)
	f4_arg0:animateToState("button_not_highlighted", 0)
	f4_arg0:dispatchEventToParent({
		name = "listbox_button_lose_focus",
		controller = f4_arg1.controller,
		mutables = f4_arg0.body.m_mutables
	})
end

CoD.ListBoxButton.setVisible = function (f5_arg0, f5_arg1)
	if f5_arg1 == true then
		if f5_arg0.m_visible == false then
			f5_arg0:addElement(f5_arg0.body)
			f5_arg0.m_visible = true
		end
		f5_arg0:makeFocusable()
	else
		if f5_arg0.body ~= nil and f5_arg0.m_visible == true then
			f5_arg0:removeElement(f5_arg0.body)
			f5_arg0.m_visible = false
		end
		f5_arg0:makeNotFocusable()
	end
end

CoD.ListBoxButton.GetBodyUIElement = function (f6_arg0)
	if f6_arg0 ~= nil then
		return f6_arg0.body
	else
		return nil
	end
end

CoD.ListBoxButton.GetBackgroundUIImage = function (f7_arg0)
	if f7_arg0 ~= nil and f7_arg0.body ~= nil then
		return f7_arg0.body.buttonBg
	else
		return nil
	end
end

CoD.ListBoxButton.DisableHighlighting = function (f8_arg0)
	if f8_arg0:getBackgroundUIImage() ~= nil then
		local f8_local0 = f8_arg0:getBackgroundUIImage()
		f8_local0:registerAnimationState("bg_highlighted", {})
		f8_local0 = f8_arg0:getBackgroundUIImage()
		f8_local0:registerAnimationState("bg_not_highlighted", {})
	end
end

CoD.ListBoxButton.DisableZooming = function (f9_arg0)
	f9_arg0:registerAnimationState("button_clicked", {})
end

CoD.ListBoxButton.MouseEnter = function (f10_arg0, f10_arg1)
	f10_arg0:dispatchEventToParent({
		name = "listbox_button_mouseenter",
		controller = f10_arg1.controller,
		button = f10_arg0
	})
end

CoD.ListBoxButton.LeftMouseUp = function (f11_arg0, f11_arg1)
	if f11_arg0.m_visible then
		f11_arg0:dispatchEventToParent({
			name = "listbox_button_clicked",
			controller = f11_arg1.controller,
			button = f11_arg0
		})
	end
end

CoD.ListBoxButton.new = function (f12_arg0, f12_arg1, f12_arg2)
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
	Widget.body = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget.id = "ListBoxButton"
	Widget.m_visible = false
	Widget.backgroundHighlightAlpha = 0.5
	Widget.backgroundNonHighlightAlpha = 0.2
	Widget.getBodyUIElement = CoD.ListBoxButton.GetBodyUIElement
	Widget.getBackgroundUIImage = CoD.ListBoxButton.GetBackgroundUIImage
	Widget.disableHighlighting = CoD.ListBoxButton.DisableHighlighting
	Widget.disableZooming = CoD.ListBoxButton.DisableZooming
	Widget:makeNotFocusable()
	Widget.getData = f12_arg2
	Widget.setVisible = CoD.ListBoxButton.setVisible
	local f12_local1 = LUI.UIImage.new()
	f12_local1:setLeftRight(true, true, 0, 0)
	f12_local1:setTopBottom(true, true, 0, 0)
	f12_local1:setAlpha(0.1)
	f12_local1:setRGB(0, 0, 0)
	local f12_local2 = LUI.UIImage.new()
	f12_local2:setLeftRight(true, true, 0, 0)
	f12_local2:setTopBottom(true, true, 0, 0)
	f12_local2:setAlpha(0.1)
	f12_local2:setImage(RegisterMaterial(CoD.MPZM("menu_mp_cac_grad_stretch", "menu_zm_cac_grad_stretch")))
	local f12_local3 = CoD.Border.new(1, CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b, 0)
	f12_local3:registerAnimationState("bg_highlighted", {
		alpha = 1
	})
	f12_local3:registerAnimationState("bg_not_highlighted", {
		alpha = 0
	})
	Widget:registerAnimationState("button_highlighted", {
		zoom = f12_arg1
	})
	Widget:registerAnimationState("button_not_highlighted", {
		zoom = 0
	})
	Widget:registerAnimationState("button_clicked", {
		zoom = -5
	})
	Widget.body.buttonBorder = f12_local3
	Widget.body.buttonBg = f12_local1
	Widget.body:addElement(f12_local1)
	Widget.body:addElement(f12_local2)
	Widget.body:addElement(f12_local3)
	Widget:registerEventHandler("gain_focus", CoD.ListBoxButton.gainFocus)
	Widget:registerEventHandler("lose_focus", CoD.ListBoxButton.loseFocus)
	Widget:registerEventHandler("click", CoD.ListBoxButton.click)
	Widget:registerEventHandler("unclick", CoD.ListBoxButton.unclick)
	if CoD.useMouse then
		Widget:setHandleMouse(true)
		Widget:registerEventHandler("mouseenter", CoD.ListBoxButton.MouseEnter)
		Widget:registerEventHandler("leftmouseup", CoD.ListBoxButton.LeftMouseUp)
		Widget:registerEventHandler("leftmousedown", CoD.NullFunction)
	end
	return Widget
end

