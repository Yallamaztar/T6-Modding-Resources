if CoD.isWIIU then
	require("T6.Drc.DrcOutput")
end
CoD.SplitscreenScaler = InheritFrom(LUI.UIElement)
CoD.SplitscreenScaler.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new(HudRef)
	Widget:setClass(CoD.SplitscreenScaler)
	Widget.scale = 1
	if 1 == UIExpression.IsInGame() and 1 < UIExpression.SplitscreenNum() then
		Widget.scale = InstanceRef
		if CoD.isWIIU then
			if Engine.WiiUGetDisplayConfiguration(CoD.DrcOutput.DisplayDrc) ~= CoD.DrcOutput.ShowSecondScreen then
				Widget:setScale(InstanceRef)
			end
		else
			Widget:setScale(InstanceRef)
		end
	end
	if Dvar.r_dualPlayEnable:get() == true then
		Widget:setScale(1)
	end
	Widget:registerEventHandler("fullscreen_viewport_start", CoD.SplitscreenScaler.FullscreenViewportStart)
	Widget:registerEventHandler("fullscreen_viewport_stop", CoD.SplitscreenScaler.FullscreenViewportStop)
	return Widget
end

CoD.SplitscreenScaler.FullscreenViewportStart = function (f2_arg0, f2_arg1)
	f2_arg0:setScale(1)
end

CoD.SplitscreenScaler.FullscreenViewportStop = function (f3_arg0, f3_arg1)
	if f3_arg0.scale ~= nil then
		f3_arg0:setScale(f3_arg0.scale)
	else
		f3_arg0:setScale(1)
	end
	if Dvar.r_dualPlayEnable:get() == true then
		f3_arg0:setScale(1)
	end
end

CoD.SplitscreenScaler.id = "LUIImage"
