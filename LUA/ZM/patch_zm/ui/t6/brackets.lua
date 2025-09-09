CoD.Brackets = {}
CoD.Brackets.Fade = function (f1_arg0, f1_arg1)
	f1_arg0:beginAnimation("fade", f1_arg1.duration)
	f1_arg0:setRGB(f1_arg1.red, f1_arg1.green, f1_arg1.blue)
	f1_arg0:setAlpha(f1_arg1.alpha)
end

CoD.Brackets.new = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setAlpha(f2_arg4)
	local f2_local1 = nil
	if f2_arg5 then
		f2_local1 = f2_arg5
	else
		f2_local1 = RegisterMaterial("lui_bracket")
	end
	if not f2_arg1 then
		f2_arg1 = 1
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
	Widget.topLeft = LUI.UIImage.new()
	Widget.topLeft:setLeftRight(true, false, 0, f2_arg0)
	Widget.topLeft:setTopBottom(true, false, 0, f2_arg0)
	Widget.topLeft:setImage(f2_local1)
	Widget.topLeft:setRGB(f2_arg1, f2_arg2, f2_arg3)
	Widget.topLeft:setZRot(180)
	Widget:addElement(Widget.topLeft)
	Widget.topLeft:registerEventHandler("fade", CoD.Brackets.Fade)
	Widget.topRight = LUI.UIImage.new()
	Widget.topRight:setLeftRight(false, true, -f2_arg0, 0)
	Widget.topRight:setTopBottom(true, false, 0, f2_arg0)
	Widget.topRight:setImage(f2_local1)
	Widget.topRight:setRGB(f2_arg1, f2_arg2, f2_arg3)
	Widget.topRight:setZRot(90)
	Widget:addElement(Widget.topRight)
	Widget.topRight:registerEventHandler("fade", CoD.Brackets.Fade)
	Widget.bottomLeft = LUI.UIImage.new()
	Widget.bottomLeft:setLeftRight(true, false, 0, f2_arg0)
	Widget.bottomLeft:setTopBottom(false, true, -f2_arg0, 0)
	Widget.bottomLeft:setImage(f2_local1)
	Widget.bottomLeft:setRGB(f2_arg1, f2_arg2, f2_arg3)
	Widget.bottomLeft:setZRot(-90)
	Widget:addElement(Widget.bottomLeft)
	Widget.bottomLeft:registerEventHandler("fade", CoD.Brackets.Fade)
	Widget.bottomRight = LUI.UIImage.new()
	Widget.bottomRight:setLeftRight(false, true, -f2_arg0, 0)
	Widget.bottomRight:setTopBottom(false, true, -f2_arg0, 0)
	Widget.bottomRight:setImage(f2_local1)
	Widget.bottomRight:setRGB(f2_arg1, f2_arg2, f2_arg3)
	Widget:addElement(Widget.bottomRight)
	Widget.bottomRight:registerEventHandler("fade", CoD.Brackets.Fade)
	return Widget
end

