CoD.MouseScroller = {}
CoD.MouseScroller.ArrowMaterialName = "ui_scrollbar_arrow_up_a"
CoD.MouseScroller.ArrowExpansionSize = 8
CoD.MouseScroller.new = function (f1_arg0, f1_arg1, f1_arg2)
	local Widget = LUI.UIElement.new(f1_arg0)
	Widget.id = "MouseScroller"
	Widget.width = f1_arg1
	Widget.height = f1_arg2
	Widget.addUpDownScroller = CoD.MouseScroller.AddUpDownScroller
	Widget.addLeftRightScroller = CoD.MouseScroller.AddLeftRightScroller
	return Widget
end

CoD.MouseScroller.AddUpDownScroller = function (f2_arg0)
	local f2_local0 = CoD.MouseScroller.CreateScrollArrowButton()
	f2_local0:setActionEventName("mouse_scroller_up")
	f2_local0:setLeftRight(true, true, 0, 0)
	f2_local0:setTopBottom(true, false, 0, f2_arg0.height / 2 - 5)
	f2_arg0:addElement(f2_local0)
	local f2_local1 = CoD.MouseScroller.CreateScrollArrowButton()
	f2_local1:setActionEventName("mouse_scroller_down")
	f2_local1:setLeftRight(true, true, 0, 0)
	f2_local1:setTopBottom(false, true, -f2_arg0.height / 2 + 5, 0)
	f2_local1.arrowImage:setZRot(180)
	f2_arg0:addElement(f2_local1)
end

CoD.MouseScroller.AddLeftRightScroller = function (f3_arg0)
	local f3_local0 = CoD.MouseScroller.CreateScrollArrowButton()
	f3_local0:setActionEventName("mouse_scroller_left")
	f3_local0:setLeftRight(true, false, 0, f3_arg0.width / 2 - 5)
	f3_local0:setTopBottom(true, true, 0, 0)
	f3_local0.arrowImage:setZRot(90)
	f3_arg0:addElement(f3_local0)
	local f3_local1 = CoD.MouseScroller.CreateScrollArrowButton()
	f3_local1:setActionEventName("mouse_scroller_right")
	f3_local1:setLeftRight(false, true, -f3_arg0.width / 2 + 5, 0)
	f3_local1:setTopBottom(true, true, 0, 0)
	f3_local1.arrowImage:setZRot(-90)
	f3_arg0:addElement(f3_local1)
end

CoD.MouseScroller.CreateScrollArrowButton = function ()
	local f4_local0 = LUI.UIButton.new(nil, actionEventName)
	f4_local0:registerEventHandler("button_up", CoD.NullFunction)
	f4_local0:setHandleMouseMove(false)
	local f4_local1 = CoD.MouseScroller.ArrowExpansionSize
	local f4_local2 = LUI.UIImage.new()
	f4_local2:setLeftRight(true, true, f4_local1 / 2, -f4_local1 / 2)
	f4_local2:setTopBottom(true, true, f4_local1 / 2, -f4_local1 / 2)
	f4_local2:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f4_local2:setImage(RegisterMaterial(CoD.MouseScroller.ArrowMaterialName))
	f4_local2:setHandleMouseMove(true)
	f4_local2:registerEventHandler("mouseenter", CoD.MouseScroller.MouseEnter)
	f4_local2:registerEventHandler("mouseleave", CoD.MouseScroller.MouseLeave)
	f4_local0.arrowImage = f4_local2
	f4_local0:addElement(f4_local2)
	return f4_local0
end

CoD.MouseScroller.MouseEnter = function (f5_arg0, f5_arg1)
	local f5_local0 = CoD.MouseScroller.ArrowExpansionSize
	f5_arg0:beginAnimation("pop", 50)
	f5_arg0:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f5_arg0:setLeftRight(true, true, 0, 0)
	f5_arg0:setTopBottom(true, true, 0, 0)
end

CoD.MouseScroller.MouseLeave = function (f6_arg0, f6_arg1)
	local f6_local0 = CoD.MouseScroller.ArrowExpansionSize
	f6_arg0:beginAnimation("default", 50)
	f6_arg0:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f6_arg0:setLeftRight(true, true, f6_local0 / 2, -f6_local0 / 2)
	f6_arg0:setTopBottom(true, true, f6_local0 / 2, -f6_local0 / 2)
end

