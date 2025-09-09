CoD.DisplayStatBox = {}
CoD.DisplayStatBox.StatsPaneWidth = 440
CoD.DisplayStatBox.StatBoxX = -CoD.DisplayStatBox.StatsPaneWidth / 2
CoD.DisplayStatBox.StatBoxWidth = CoD.MPZM(100, 80)
CoD.DisplayStatBox.StatBoxY = 60
CoD.DisplayStatBox.StatBoxHeight = CoD.DisplayStatBox.StatBoxWidth
CoD.DisplayStatBox.StatBoxXIncr = CoD.DisplayStatBox.StatBoxWidth + 5
CoD.DisplayStatBox.StatBoxYIncr = CoD.DisplayStatBox.StatBoxHeight + CoD.textSize.Default + 15
CoD.DisplayStatBox.New = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5)
	local f1_local0 = CoD.MPZM(0.2, 0.5)
	local f1_local1 = CoD.MPZM(false, true)
	local f1_local2 = CoD.DisplayStatBox.StatBoxX + CoD.DisplayStatBox.StatBoxXIncr * f1_arg4
	local f1_local3 = CoD.DisplayStatBox.StatBoxY + CoD.DisplayStatBox.StatBoxYIncr * f1_arg5
	local Widget = LUI.UIElement.new({
		left = f1_local2,
		top = f1_local3,
		right = f1_local2 + CoD.DisplayStatBox.StatBoxWidth,
		bottom = f1_local3 + CoD.DisplayStatBox.StatBoxHeight,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	Widget:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = f1_local0,
		material = RegisterMaterial(f1_arg0)
	}))
	local f1_local5 = LUI.UIText.new({
		left = -1,
		top = 0,
		right = 1,
		bottom = CoD.textSize.Default,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = f1_local1,
		font = CoD.fonts.Default
	})
	Widget:addElement(f1_local5)
	f1_local5:setText(f1_arg2)
	if CoD.isZombie == false then
		local f1_local6 = LUI.UIText.new({
			left = -1,
			top = -CoD.textSize.Condensed,
			right = 1,
			bottom = 0,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false,
			font = CoD.fonts.Default
		})
		Widget:addElement(f1_local6)
		f1_local6:setText(f1_arg1)
		local f1_local7 = LUI.UIText.new({
			left = -1,
			top = 0,
			right = 1,
			bottom = CoD.textSize.Default,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = true,
			font = CoD.fonts.Default,
			red = 1,
			green = 1,
			blue = 1
		})
		Widget:addElement(f1_local7)
		f1_local7:setText(Engine.Localize(f1_arg3))
	end
	return Widget
end

