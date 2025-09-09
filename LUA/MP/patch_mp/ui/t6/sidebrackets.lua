CoD.SideBrackets = {}
CoD.SideBrackets.Fade = function (f1_arg0, f1_arg1)
	f1_arg0:beginAnimation("fade", f1_arg1.duration)
	f1_arg0:setRGB(f1_arg1.red, f1_arg1.green, f1_arg1.blue)
	f1_arg0:setAlpha(f1_arg1.alpha)
end

CoD.SideBrackets.new = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setAlpha(f2_arg5)
	local f2_local1 = 2
	local f2_local2 = 10
	if f2_arg0 ~= nil then
		f2_local1 = f2_arg0
	end
	if f2_arg1 ~= nil then
		f2_local2 = f2_arg1
	end
	if not f2_arg2 then
		f2_arg2 = 1
	end
	if not f2_arg3 then
		f2_arg3 = 1
	end
	if not f2_arg4 then
		f2_arg4 = 1
	end
	if not f2_arg5 then
		f2_arg5 = 1
	end
	Widget.leftTopHook = LUI.UIImage.new()
	Widget.leftTopHook:setLeftRight(true, false, 0, f2_local2)
	Widget.leftTopHook:setTopBottom(true, false, 0, f2_local1)
	Widget.leftTopHook:setRGB(f2_arg2, f2_arg3, f2_arg4)
	Widget:addElement(Widget.leftTopHook)
	Widget.leftTopHook:registerEventHandler("fade", CoD.SideBrackets.Fade)
	Widget.leftLine = LUI.UIImage.new()
	Widget.leftLine:setLeftRight(true, false, 0, f2_local1)
	Widget.leftLine:setTopBottom(true, true, f2_local1, -f2_local1)
	Widget.leftLine:setRGB(f2_arg2, f2_arg3, f2_arg4)
	Widget:addElement(Widget.leftLine)
	Widget.leftLine:registerEventHandler("fade", CoD.SideBrackets.Fade)
	Widget.leftBottomHook = LUI.UIImage.new()
	Widget.leftBottomHook:setLeftRight(true, false, 0, f2_local2)
	Widget.leftBottomHook:setTopBottom(false, true, -f2_local1, 0)
	Widget.leftBottomHook:setRGB(f2_arg2, f2_arg3, f2_arg4)
	Widget:addElement(Widget.leftBottomHook)
	Widget.leftBottomHook:registerEventHandler("fade", CoD.SideBrackets.Fade)
	Widget.rightTopHook = LUI.UIImage.new()
	Widget.rightTopHook:setLeftRight(false, true, -f2_local2, 0)
	Widget.rightTopHook:setTopBottom(true, false, 0, f2_local1)
	Widget.rightTopHook:setRGB(f2_arg2, f2_arg3, f2_arg4)
	Widget:addElement(Widget.rightTopHook)
	Widget.rightTopHook:registerEventHandler("fade", CoD.SideBrackets.Fade)
	Widget.rightLine = LUI.UIImage.new()
	Widget.rightLine:setLeftRight(false, true, -f2_local1, 0)
	Widget.rightLine:setTopBottom(true, true, f2_local1, -f2_local1)
	Widget.rightLine:setRGB(f2_arg2, f2_arg3, f2_arg4)
	Widget:addElement(Widget.rightLine)
	Widget.rightLine:registerEventHandler("fade", CoD.SideBrackets.Fade)
	Widget.rightBottomHook = LUI.UIImage.new()
	Widget.rightBottomHook:setLeftRight(false, true, -f2_local2, 0)
	Widget.rightBottomHook:setTopBottom(false, true, -f2_local1, 0)
	Widget.rightBottomHook:setRGB(f2_arg2, f2_arg3, f2_arg4)
	Widget:addElement(Widget.rightBottomHook)
	Widget.rightBottomHook:registerEventHandler("fade", CoD.SideBrackets.Fade)
	return Widget
end

