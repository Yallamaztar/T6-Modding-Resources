CoD.SelectedReward = {}
CoD.SelectedReward.New = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new(HudRef)
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 1
	})
	Widget.backgroundContainer = Widget
	Widget:addElement(Widget)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.1))
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 1, -1)
	Widget:setTopBottom(true, true, 1, -1)
	Widget:setUseStencil(true)
	Widget:addElement(Widget)
	local f1_local3 = 7
	Widget.itemImage = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -InstanceRef / 2,
		right = InstanceRef / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = f1_local3 + -InstanceRef / 2,
		bottom = f1_local3 + InstanceRef / 2,
		alpha = 0
	})
	Widget:addElement(Widget.itemImage)
	local f1_local4 = 0
	Widget.cost = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = f1_local4,
		bottom = f1_local4 + CoD.textSize.Default,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		font = CoD.fonts.Default
	})
	Widget:addElement(Widget.cost)
	return Widget
end

CoD.SelectedReward.Update = function (f2_arg0, f2_arg1)
	if f2_arg1 == nil then
		f2_arg0.cost:setText("")
		f2_arg0.itemImage:animateToState("default")
	else
		f2_arg0.cost:setText(f2_arg1.momentumCost)
		f2_arg0.itemImage:registerAnimationState("change_material", {
			material = RegisterMaterial(UIExpression.GetItemImage(nil, f2_arg1.itemIndex) .. "_menu"),
			alpha = 1
		})
		f2_arg0.itemImage:animateToState("change_material")
	end
end

