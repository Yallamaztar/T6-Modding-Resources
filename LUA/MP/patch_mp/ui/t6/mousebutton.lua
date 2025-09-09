CoD.MouseButton = {}
CoD.MouseButton.DefaultImageSize = 20
CoD.MouseButton.MouseOverExpansionScale = 1.2
CoD.MouseButton.MouseOverAnimationTime = 50
CoD.MouseButton.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = LUI.UIButton.new(f1_arg0)
	f1_local0.id = "MouseButton"
	f1_local0.imageSize = CoD.MouseButton.DefaultImageSize
	f1_local0.imageXOffset = 0
	f1_local0.imageYOffset = 0
	if f1_arg3 ~= nil then
		f1_local0.imageSize = f1_arg3
	end
	local f1_local1 = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f1_local0.imageSize / 2,
		right = f1_local0.imageSize / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = -f1_local0.imageSize / 2,
		bottom = f1_local0.imageSize / 2
	})
	if f1_arg1 ~= nil then
		f1_local0.buttonString = f1_arg1
		f1_local1:setText(f1_arg1)
	end
	if f1_arg2 ~= nil then
		f1_local0.buttonStringMouseOver = f1_arg2
	end
	f1_local0:makeNotFocusable()
	f1_local0.buttonImage = f1_local1
	f1_local0:addElement(f1_local1)
	f1_local0:registerEventHandler("mouseenter", CoD.MouseButton.MouseEnter)
	f1_local0:registerEventHandler("mouseleave", CoD.MouseButton.MouseLeave)
	f1_local0:registerEventHandler("button_action", CoD.MouseButton.ButtonAction)
	f1_local0.setExpansionScale = CoD.MouseButton.SetExpansionScale
	f1_local0.setupButtonImage = CoD.MouseButton.SetupButtonImage
	return f1_local0
end

CoD.MouseButton.SetExpansionScale = function (f2_arg0, f2_arg1)
	if f2_arg1 then
		f2_arg0.expansionScale = f2_arg1
	else
		f2_arg0.expansionScale = CoD.MouseButton.MouseOverExpansionScale
	end
end

CoD.MouseButton.SetupButtonImage = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local f3_local0 = f3_arg0.buttonImage
	if f3_arg3 ~= nil then
		f3_arg0.imageSize = f3_arg3
	end
	f3_arg0.imageXOffset = f3_arg1
	f3_arg0.imageYOffset = f3_arg2
	f3_local0:beginAnimation("default", 0)
	f3_local0:setLeftRight(false, false, -f3_arg0.imageSize / 2 + f3_arg1, f3_arg0.imageSize / 2 + f3_arg1)
	f3_local0:setTopBottom(false, false, -f3_arg0.imageSize / 2 + f3_arg2, f3_arg0.imageSize / 2 + f3_arg2)
end

CoD.MouseButton.ButtonAction = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0:getParent()
	if not f4_local0.handleMouseButton then
		LUI.UIButton.buttonAction(f4_arg0, f4_arg1)
	end
end

CoD.MouseButton.MouseEnter = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0:getParent()
	local f5_local1 = f5_arg0.buttonImage
	local f5_local2 = f5_arg0.imageSize
	local f5_local3 = f5_arg0.expansionScale
	local f5_local4 = f5_arg0.imageXOffset
	local f5_local5 = f5_arg0.imageYOffset
	if f5_local3 then
		f5_local1:beginAnimation("pop", CoD.MouseButton.MouseOverAnimationTime)
		f5_local1:setLeftRight(false, false, -(f5_local2 / 2 * f5_local3) + f5_local4, f5_local2 / 2 * f5_local3 + f5_local4)
		f5_local1:setTopBottom(false, false, -(f5_local2 / 2 * f5_local3) + f5_local5, f5_local2 / 2 * f5_local3 + f5_local5)
	end
	if f5_arg0.buttonStringMouseOver then
		f5_local1:setText(f5_arg0.buttonStringMouseOver)
	end
	f5_local0:setHandleMouseButton(false)
end

CoD.MouseButton.MouseLeave = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0:getParent()
	local f6_local1 = f6_arg0.buttonImage
	local f6_local2 = f6_arg0.imageSize
	local f6_local3 = f6_arg0.expansionScale
	local f6_local4 = f6_arg0.imageXOffset
	local f6_local5 = f6_arg0.imageYOffset
	if f6_local3 then
		f6_local1:beginAnimation("default", CoD.MouseButton.MouseOverAnimationTime)
		f6_local1:setLeftRight(false, false, -(f6_local2 / 2) + f6_local4, f6_local2 / 2 + f6_local4)
		f6_local1:setTopBottom(false, false, -(f6_local2 / 2) + f6_local5, f6_local2 / 2 + f6_local5)
	end
	if f6_arg0.buttonString then
		f6_local1:setText(f6_arg0.buttonString)
	end
	f6_local0:setHandleMouseButton(true)
end

