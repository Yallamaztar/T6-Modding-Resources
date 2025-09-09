LUI.UISafeAreaOverlay = {}
LUI.UISafeAreaOverlay.new = function ()
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		topAnchor = true,
		leftAnchor = true,
		bottomAnchor = true,
		rightAnchor = true
	})
	local f1_local1 = Engine.GetAspectRatio() * 720 * 0.1 / 2
	local f1_local2 = 36
	Widget.leftBorder = LUI.UIImage.new({
		left = 0,
		top = f1_local2,
		right = f1_local1,
		bottom = -f1_local2,
		topAnchor = true,
		leftAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		red = 0,
		green = 0,
		blue = 1,
		alpha = 0.5
	})
	Widget:addElement(Widget.leftBorder)
	Widget.rightBorder = LUI.UIImage.new({
		left = -f1_local1,
		top = f1_local2,
		right = 0,
		bottom = -f1_local2,
		topAnchor = true,
		leftAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		red = 0,
		green = 0,
		blue = 1,
		alpha = 0.5
	})
	Widget:addElement(Widget.rightBorder)
	Widget.topBorder = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = f1_local2,
		topAnchor = true,
		leftAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		red = 0,
		green = 0,
		blue = 1,
		alpha = 0.5
	})
	Widget:addElement(Widget.topBorder)
	Widget.bottomBorder = LUI.UIImage.new({
		left = 0,
		top = -f1_local2,
		right = 0,
		bottom = 0,
		topAnchor = false,
		leftAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = 0,
		green = 0,
		blue = 1,
		alpha = 0.5
	})
	Widget:addElement(Widget.bottomBorder)
	return Widget
end

