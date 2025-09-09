CoD.BorderFrame = {}
CoD.BorderFrame.MaterialSize = 24
CoD.BorderFrame.Images = {
	{
		material = RegisterMaterial("menu_borderframe_upper_left"),
		anchorLeft = true,
		anchorRight = false,
		anchorTop = true,
		anchorBottom = false,
		left = 0,
		right = CoD.BorderFrame.MaterialSize,
		top = 0,
		bottom = CoD.BorderFrame.MaterialSize
	},
	{
		material = RegisterMaterial("menu_borderframe_upper_middle"),
		anchorLeft = true,
		anchorRight = true,
		anchorTop = true,
		anchorBottom = false,
		left = CoD.BorderFrame.MaterialSize,
		right = -CoD.BorderFrame.MaterialSize,
		top = 0,
		bottom = CoD.BorderFrame.MaterialSize
	},
	{
		material = RegisterMaterial("menu_borderframe_upper_right"),
		anchorLeft = false,
		anchorRight = true,
		anchorTop = true,
		anchorBottom = false,
		left = -CoD.BorderFrame.MaterialSize,
		right = 0,
		top = 0,
		bottom = CoD.BorderFrame.MaterialSize
	},
	{
		material = RegisterMaterial("menu_borderframe_middle_left"),
		anchorLeft = true,
		anchorRight = false,
		anchorTop = true,
		anchorBottom = true,
		left = 0,
		right = CoD.BorderFrame.MaterialSize,
		top = CoD.BorderFrame.MaterialSize,
		bottom = -CoD.BorderFrame.MaterialSize
	},
	{
		material = RegisterMaterial("menu_borderframe_middle_middle"),
		anchorLeft = true,
		anchorRight = true,
		anchorTop = true,
		anchorBottom = true,
		left = CoD.BorderFrame.MaterialSize,
		right = -CoD.BorderFrame.MaterialSize,
		top = CoD.BorderFrame.MaterialSize,
		bottom = -CoD.BorderFrame.MaterialSize
	},
	{
		material = RegisterMaterial("menu_borderframe_middle_right"),
		anchorLeft = false,
		anchorRight = true,
		anchorTop = true,
		anchorBottom = true,
		left = -CoD.BorderFrame.MaterialSize,
		right = 0,
		top = CoD.BorderFrame.MaterialSize,
		bottom = -CoD.BorderFrame.MaterialSize
	},
	{
		material = RegisterMaterial("menu_borderframe_lower_left"),
		anchorLeft = true,
		anchorRight = false,
		anchorTop = false,
		anchorBottom = true,
		left = 0,
		right = CoD.BorderFrame.MaterialSize,
		top = -CoD.BorderFrame.MaterialSize,
		bottom = 0
	},
	{
		material = RegisterMaterial("menu_borderframe_lower_middle"),
		anchorLeft = true,
		anchorRight = true,
		anchorTop = false,
		anchorBottom = true,
		left = CoD.BorderFrame.MaterialSize,
		right = -CoD.BorderFrame.MaterialSize,
		top = -CoD.BorderFrame.MaterialSize,
		bottom = 0
	},
	{
		material = RegisterMaterial("menu_borderframe_lower_right"),
		anchorLeft = false,
		anchorRight = true,
		anchorTop = false,
		anchorBottom = true,
		left = -CoD.BorderFrame.MaterialSize,
		right = 0,
		top = -CoD.BorderFrame.MaterialSize,
		bottom = 0
	}
}
CoD.BorderFrame.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	if not f1_arg4 then
		f1_arg4 = 0
	end
	if not f1_arg0 then
		f1_arg0 = 1
	end
	if not f1_arg1 then
		f1_arg1 = 1
	end
	if not f1_arg2 then
		f1_arg2 = 1
	end
	if not f1_arg3 then
		f1_arg3 = 1
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f1_arg4, -f1_arg4)
	Widget:setTopBottom(true, true, f1_arg4, -f1_arg4)
	Widget:setAlpha(f1_arg3)
	for f1_local1 = 1, #CoD.BorderFrame.Images, 1 do
		local f1_local4 = CoD.BorderFrame.Images[f1_local1]
		local f1_local5 = LUI.UIImage.new()
		f1_local5:setLeftRight(f1_local4.anchorLeft, f1_local4.anchorRight, f1_local4.left, f1_local4.right)
		f1_local5:setTopBottom(f1_local4.anchorTop, f1_local4.anchorBottom, f1_local4.top, f1_local4.bottom)
		f1_local5:setImage(f1_local4.material)
		f1_local5:setRGB(f1_arg0, f1_arg1, f1_arg2)
		Widget:addElement(f1_local5)
	end
	return Widget
end

