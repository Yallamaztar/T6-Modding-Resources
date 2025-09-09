CoD.Overlay = {}
CoD.Overlay.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new(InstanceRef)
	Widget.frame = HudRef
	Widget.leftButtonBar = LUI.UIHorizontalList.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = CoD.ButtonPrompt.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		spacing = 10
	})
	Widget.rightButtonBar = LUI.UIHorizontalList.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = CoD.ButtonPrompt.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		spacing = 10,
		alignment = LUI.Alignment.Right
	})
	Widget.frame.buttonPrompts:addElement(Widget.leftButtonBar)
	Widget.frame.buttonPrompts:addElement(Widget.rightButtonBar)
	Widget.close = CoD.Overlay.Close
	Widget.addBackButton = CoD.Overlay.AddBackButton
	Widget:registerEventHandler("overlay_opening", CoD.Overlay.Opening)
	Widget:registerEventHandler("overlay_closed", CoD.Overlay.Closed)
	Widget:registerEventHandler("button_prompt_back", CoD.Overlay.Close)
	Widget:addBackButton()
	return Widget
end

CoD.Overlay.Opening = function (f2_arg0, f2_arg1)
	f2_arg0:addElement(LUI.UITimer.new(f2_arg1.time, "overlay_opened", true))
	if f2_arg0.title ~= nil then
		f2_arg0.frame:fadeInTitle(f2_arg0.title, f2_arg1.time)
	end
end

CoD.Overlay.Closed = function (f3_arg0, f3_arg1)
	f3_arg0.leftButtonBar:close()
	f3_arg0.rightButtonBar:close()
end

CoD.Overlay.Close = function (f4_arg0)
	f4_arg0.frame:closeOverlay(f4_arg0)
end

CoD.Overlay.AddBackButton = function (f5_arg0)
	f5_arg0.backButton = CoD.ButtonPrompt.new("secondary", "Back", f5_arg0, "button_prompt_back")
	f5_arg0.leftButtonBar:addElement(f5_arg0.backButton)
end

