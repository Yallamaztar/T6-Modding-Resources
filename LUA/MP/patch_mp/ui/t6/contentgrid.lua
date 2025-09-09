require("T6.ContentGridButton")
CoD.ContentGrid = {}
CoD.ContentGrid.Spacing = 5
CoD.ContentGrid.ItemSize = 100
CoD.ContentGrid.ItemWidth = 110
CoD.ContentGrid.ItemHeight = 90
CoD.ContentGrid.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	if CoD.ContentGrid.HighlightMaterial == nil then
		CoD.ContentGrid.HighlightMaterial = RegisterMaterial("menu_select_highlight")
	end
	local Widget = LUI.UIElement.new(f1_arg1)
	if f1_arg4 == nil then
		f1_arg4 = CoD.ContentGrid.Spacing
	end
	if f1_arg2 == nil then
		f1_arg2 = CoD.ContentGrid.ItemWidth
	end
	if f1_arg3 == nil then
		f1_arg3 = CoD.ContentGrid.ItemHeight
	end
	Widget.numItemsWide = f1_arg0
	Widget.spacing = f1_arg4
	Widget.itemWidth = f1_arg2
	Widget.itemHeight = f1_arg3
	Widget.buttons = {}
	Widget.addButton = CoD.ContentGrid.AddButton
	return Widget
end

CoD.ContentGrid.AddButton = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.numItemsWide
	local f2_local1 = #f2_arg0.buttons
	local f2_local2 = f2_local1 % f2_local0
	local f2_local3 = (f2_local1 - f2_local2) / f2_local0
	local f2_local4 = f2_arg0.itemWidth
	local f2_local5 = f2_arg0.itemHeight
	local f2_local6 = f2_arg0.spacing
	local f2_local7 = f2_local2 * (f2_local4 + f2_local6)
	local f2_local8 = f2_local3 * (f2_local5 + f2_local6)
	f2_arg1:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = false,
		left = f2_local7,
		right = f2_local7 + f2_local4,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local8,
		bottom = f2_local8 + f2_local5,
		xRot = 0,
		yRot = 0,
		zRot = 0,
		zoom = 0
	})
	f2_arg1:animateToState("default")
	f2_arg1.itemHeight = f2_local5
	f2_arg1.itemWidth = f2_local4
	if f2_local2 > 0 then
		CoD.ContentGrid.SetNavigation(f2_arg0, f2_arg1, f2_local1, "left", "right")
	end
	CoD.ContentGrid.SetNavigation(f2_arg0, f2_arg1, f2_local1 - f2_local2 + 1, "right", "left")
	CoD.ContentGrid.SetNavigation(f2_arg0, f2_arg1, f2_local1 - f2_local0 + 1, "up", "down")
	CoD.ContentGrid.SetNavigation(f2_arg0, f2_arg1, f2_local2 + 1, "down", "up")
	table.insert(f2_arg0.buttons, f2_arg1)
	f2_arg0:addElement(f2_arg1)
	return f2_arg1
end

CoD.ContentGrid.SetNavigation = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4)
	local f3_local0 = f3_arg0.buttons[f3_arg2]
	if f3_local0 ~= nil and f3_local0 ~= f3_arg1 then
		f3_arg1.navigation[f3_arg3] = f3_local0
		f3_local0.navigation[f3_arg4] = f3_arg1
	end
end

