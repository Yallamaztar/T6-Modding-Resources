CoD.RTSMiniMap = {}
CoD.RTSMiniMap.DefaultAlpha = 1
CoD.RTSMiniMap.new = function ()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:registerEventHandler("rts_toggle_minimap", CoD.RTSMiniMap.ToggleVisibility)
	local f1_local1 = 0
	local f1_local2 = -300
	local f1_local3 = 250
	local f1_local4 = 200
	local f1_local5 = f1_local3 * 0.7
	local f1_local6 = f1_local4 * 0.8
	local f1_local7 = f1_local1 + (f1_local3 - f1_local5) / 2
	local f1_local8 = f1_local2 + (f1_local4 - f1_local6) / 2
	Widget:addElement(CoD.VisorImage.new("menu_vis_diamond_group", {
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local7,
		right = f1_local7 + f1_local5,
		topAnchor = false,
		bottomAnchor = false,
		top = f1_local8,
		bottom = f1_local8 + f1_local6
	}, {
		r = 0.05,
		g = 0.05,
		b = 0.05
	}))
	Widget:addElement(CoD.VisorImage.new("compass_map_warp", {
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local1,
		right = f1_local1 + f1_local3,
		topAnchor = false,
		bottomAnchor = false,
		top = f1_local2,
		bottom = f1_local2 + f1_local4
	}, {
		r = 1,
		g = 1,
		b = 1
	}))
	Widget:addElement(CoD.VisorImage.new("visor_bracket_minimap", {
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local1 + 25,
		right = f1_local1 + f1_local3 - 19,
		topAnchor = false,
		bottomAnchor = false,
		top = f1_local2 + 7,
		bottom = f1_local2 + f1_local4 - 3
	}, {
		r = 1,
		g = 1,
		b = 1
	}))
	return Widget
end

CoD.RTSMiniMap.ToggleVisibility = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.data[1]
	local f2_local1 = f2_arg1.data[2] or 500
	if f2_local0 == 0 then
		f2_arg0:beginAnimation("hide", f2_local1)
		f2_arg0:setAlpha(0)
	else
		f2_arg0:beginAnimation("show", f2_local1)
		f2_arg0:setAlpha(CoD.RTSMiniMap.DefaultAlpha)
	end
end

