CoD.HUDShaker = {}
CoD.HUDShaker.new = function ()
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		zoom = 0
	})
	Widget:setupHUDShaker()
	Widget:registerEventHandler("view_damage", CoD.HUDShaker.ViewDamage)
	return Widget
end

CoD.HUDShaker.ViewDamage = function (f2_arg0, f2_arg1)
	local f2_local0 = CoD.VisorHud.Margin
	local f2_local1 = -f2_arg1.x * f2_local0
	local f2_local2 = -f2_arg1.y * f2_local0
	f2_arg0:registerAnimationState("damage", {
		leftAnchor = true,
		rightAnchor = true,
		left = f2_local1,
		right = f2_local1,
		topAnchor = true,
		bottomAnchor = true,
		top = f2_local2,
		bottom = f2_local2
	})
	f2_arg0:animateToState("damage")
	f2_arg0:animateToState("default", 500, false, true)
end

