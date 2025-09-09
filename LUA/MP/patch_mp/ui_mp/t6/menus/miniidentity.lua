CoD.MiniIdentity = {}
CoD.MiniIdentity.New = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local Widget = LUI.UIElement.new(f1_arg1)
	Widget:setFont(CoD.fonts.Default)
	Widget:setupMiniIdentity(f1_arg2, f1_arg3)
	Widget:setFont(CoD.fonts.ExtraSmall)
	return Widget
end

CoD.MiniIdentity.GetMiniIdentity = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	if CoD.isMultiplayer and not CoD.isZombie then
		local f2_local1 = 0.25
		local f2_local2 = 250
		local f2_local3 = f2_local2 * f2_local1
		Widget:setLeftRight(false, true, -f2_local2, 0)
		Widget:setTopBottom(true, false, 0, 0 + f2_local3)
		Widget:setAlignment(LUI.Alignment.Left)
		local f2_local4 = nil
		if InstanceRef then
			f2_local4 = InstanceRef
		else
			f2_local4 = UIExpression.GetXUID(HudRef)
		end
		if f2_local4 ~= nil and f2_local4 ~= "0" then
			Widget:setupMiniIdentity(f2_local4, false)
			Widget:setFont(CoD.fonts.ExtraSmall)
		end
	end
	return Widget
end

