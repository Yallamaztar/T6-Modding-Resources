CoD.TouchpadVerticalList = {}
CoD.TouchpadVerticalList.DefaultElementSpacing = -100
CoD.TouchpadVerticalList.DefaultWidth = 256
CoD.TouchpadVerticalList.DefaultHeight = 256
CoD.TouchpadVerticalList.TouchpadMoveEpsilon = 5
CoD.TouchpadVerticalList.ScrollFriction = 0.09
CoD.TouchpadVerticalList.ScrollMaxVelocity = 75
CoD.TouchpadVerticalList.SnapAnimationDuration = 100
CoD.TouchpadVerticalList.ThresholdStartedDragging = 5
CoD.TouchpadVerticalList.ThresholdInitial = DRAG_THRESHOLD_SQUARED
local f0_local0 = function (f1_arg0)
	f1_arg0.velocity = nil
	f1_arg0.velocityNumFrames = 0
	f1_arg0.velocityCurFrame = 0
end

local f0_local1 = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0, f2_local1, f2_local2, f2_local3 = f2_arg0:getRect()
	if f2_local0 <= f2_arg1 and f2_arg1 <= f2_local2 and f2_local3 <= f2_arg2 and f2_arg2 <= f2_local1 then
		return true
	else
		return false
	end
end

local f0_local2 = function (f3_arg0, f3_arg1)
	f0_local0(f3_arg0)
	f3_arg0.velocity = 0
end

local f0_local3 = function (f4_arg0, f4_arg1)
	if not f4_arg0.startedDragging and f4_arg0.downY and f4_arg0.lastY then
		local f4_local0 = f4_arg0.downX - f4_arg0.lastX
		local f4_local1 = f4_arg0.downY - f4_arg0.lastY
		if f4_local0 * f4_local0 + f4_local1 * f4_local1 < f4_arg0.threshold then
			f4_arg0.cannotDrag = f4_arg0.cannotDrag + 1
		end
	end
	if f4_arg0.disableScrollTimer then
		f4_arg0.disableScrollTimer:close()
		f4_arg0.disableScrollTimer = nil
	end
end

CoD.TouchpadVerticalList.TouchpadDown = function (f5_arg0, f5_arg1)
	f5_arg0:dispatchEventToChildren(f5_arg1)
	local f5_local0, f5_local1 = ProjectRootCoordinate(f5_arg1.rootName, f5_arg1.x, f5_arg1.y)
	f5_arg0.downX = f5_local0
	f5_arg0.downY = f5_local1
	f5_arg0.lastX = f5_local0
	f5_arg0.lastY = f5_local1
	f5_arg0.threshold = CoD.Wiiu.DRAG_THRESHOLD_SQUARED * 2
	f5_arg0.scrolling = false
	f5_arg0.mouseDown = true
	f0_local0(f5_arg0)
	f5_arg0.disableScrollTimer = LUI.UITimer.new(CoD.Wiiu.DRAG_DISABLED_AFTER, {
		name = "disable_drag"
	}, true, f5_arg0)
	f5_arg0:addElement(f5_arg0.disableScrollTimer)
	if f0_local1(f5_arg0, f5_local0, f5_local1) then
		f0_local2(f5_arg0)
	end
end

local f0_local4 = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	if f6_arg3 ~= nil and math.floor(-f6_arg0 / f6_arg2) ~= math.floor(-f6_arg1 / f6_arg2) then
		Engine.PlaySound(f6_arg3)
	end
end

CoD.TouchpadVerticalList.TouchpadMove = function (f7_arg0, f7_arg1)
	if f7_arg0.snapAnim or not f7_arg0.mouseDown then
		return 
	end
	local f7_local0, f7_local1 = ProjectRootCoordinate(f7_arg1.rootName, f7_arg1.x, f7_arg1.y)
	local f7_local2, f7_local3, f7_local4, f7_local5 = f7_arg0:getRect()
	if f7_local0 < f7_local2 or f7_local4 < f7_local0 or f7_local5 < f7_local1 or f7_local1 < f7_local3 then
		f7_arg0.lastX = f7_local0
		f7_arg0.lastY = f7_local1
		return 
	elseif f7_arg0.cannotDrag > 0 or not f7_arg0.mouseDown then
		f7_arg0:dispatchEventToChildren(f7_arg1)
		return 
	end
	local f7_local6 = f7_local0 - f7_arg0.lastX
	local f7_local7 = f7_local1 - f7_arg0.lastY
	if f7_arg0.threshold < f7_local6 * f7_local6 + f7_local7 * f7_local7 and math.abs(f7_local6) < math.abs(f7_local7) then
		local f7_local8 = f7_arg0.top
		f7_arg0.top = math.max(f7_arg0.minScrollPos, math.min(f7_arg0.maxScrollPos, f7_arg0.top + f7_local7 * CoD.Wiiu.VirtualCoordToDrcVerticalUnits))
		f7_arg0:beginAnimation("scroll")
		f7_arg0:setLeftRight(true, true, 0, 0)
		f7_arg0:setTopBottom(false, false, f7_arg0.top, f7_arg0.top + f7_arg0.length)
		f7_arg0.velocityCache[1 + f7_arg0.velocityCurFrame] = f7_arg0.top - f7_local8
		f7_arg0.velocityNumFrames = math.min(table.getn(f7_arg0.velocityCache), f7_arg0.velocityNumFrames + 1)
		f7_arg0.velocityCurFrame = (f7_arg0.velocityCurFrame + 1) % table.getn(f7_arg0.velocityCache)
		f7_arg0.threshold = CoD.TouchpadVerticalList.ThresholdStartedDragging
		f7_arg0.scrolling = true
		f7_arg0.lastX = f7_local0
		f7_arg0.lastY = f7_local1
		if f7_arg0.disableScrollTimer then
			f7_arg0.disableScrollTimer:close()
			f7_arg0.disableScrollTimer = nil
		end
		f0_local4(f7_local8, f7_arg0.top, f7_arg0.tickDistance, f7_arg0.tickSound)
	else
		f0_local0(f7_arg0)
		if not f7_arg0.scrolling then
			f7_arg0:dispatchEventToChildren(f7_arg1)
		end
	end
end

local f0_local5 = function (f8_arg0)
	if f8_arg0.velocity and math.abs(f8_arg0.velocity) > 2 and f8_arg0.minScrollPos < f8_arg0.top and f8_arg0.top < f8_arg0.maxScrollPos then
		local f8_local0 = f8_arg0.velocity * (1 - CoD.TouchpadVerticalList.ScrollFriction)
		local f8_local1 = f8_arg0.top
		f8_arg0.top = math.max(f8_arg0.minScrollPos, math.min(f8_arg0.maxScrollPos, f8_arg0.top + f8_local0))
		f8_arg0:beginAnimation("taper", 0)
		f8_arg0:setLeftRight(true, true, 0, 0)
		f8_arg0:setTopBottom(false, false, f8_arg0.top, f8_arg0.top + f8_arg0.length)
		f0_local4(f8_local1, f8_arg0.top, f8_arg0.tickDistance, f8_arg0.tickSound)
		f8_arg0.velocity = f8_local0
	else
		f0_local0(f8_arg0)
		if f8_arg0.top < f8_arg0.snapScrollPosMin then
			f8_arg0.top = f8_arg0.snapScrollPosMin
			f8_arg0:beginAnimation("snap", CoD.TouchpadVerticalList.SnapAnimationDuration * 1.5)
			f8_arg0:setLeftRight(true, true, 0, 0)
			f8_arg0:setTopBottom(false, false, f8_arg0.top, f8_arg0.top + f8_arg0.length)
			f8_arg0.snapAnim = true
		elseif f8_arg0.snapScrollPosMax < f8_arg0.top then
			f8_arg0.top = f8_arg0.snapScrollPosMax
			f8_arg0:beginAnimation("snap", CoD.TouchpadVerticalList.SnapAnimationDuration * 1.5)
			f8_arg0:setLeftRight(true, true, 0, 0)
			f8_arg0:setTopBottom(false, false, f8_arg0.top, f8_arg0.top + f8_arg0.length)
			f8_arg0.snapAnim = true
		end
	end
end

local f0_local6 = function (f9_arg0, f9_arg1)
	f0_local5(f9_arg0)
end

CoD.TouchpadVerticalList.TouchpadUp = function (f10_arg0, f10_arg1)
	f10_arg0.mouseDown = false
	f10_arg0.cannotDrag = 0
	if f10_arg0.top < f10_arg0.snapScrollPosMin then
		f10_arg0.top = f10_arg0.snapScrollPosMin
		f10_arg0:beginAnimation("snap", CoD.TouchpadVerticalList.SnapAnimationDuration)
		f10_arg0:setLeftRight(true, true, 0, 0)
		f10_arg0:setTopBottom(false, false, f10_arg0.top, f10_arg0.top + f10_arg0.length)
		f10_arg0.snapAnim = true
	elseif f10_arg0.snapScrollPosMax < f10_arg0.top then
		f10_arg0.top = f10_arg0.snapScrollPosMax
		f10_arg0:beginAnimation("snap", CoD.TouchpadVerticalList.SnapAnimationDuration)
		f10_arg0:setLeftRight(true, true, 0, 0)
		f10_arg0:setTopBottom(false, false, f10_arg0.top, f10_arg0.top + f10_arg0.length)
		f10_arg0.snapAnim = true
	elseif f10_arg0.threshold == CoD.TouchpadVerticalList.ThresholdStartedDragging and f10_arg0.velocityNumFrames then
		local f10_local0 = 0
		for f10_local1 = 1, f10_arg0.velocityNumFrames, 1 do
			f10_local0 = f10_local0 + f10_arg0.velocityCache[f10_local1]
		end
		f10_local0 = f10_local0 / f10_arg0.velocityNumFrames
		f10_arg0.velocityNumFrames = 0
		f10_arg0.velocityCurFrame = 0
		if math.abs(f10_local0) > 3 then
			f10_arg0.velocity = f10_local0
			f0_local5(f10_arg0)
		end
	end
	if not f10_arg0.scrolling then
		LUI.UIElement.MouseButtonEvent(f10_arg0, f10_arg1)
	else
		f10_arg0.scrolling = false
	end
	if f10_arg0.disableScrollTimer then
		f10_arg0.disableScrollTimer:close()
		f10_arg0.disableScrollTimer = nil
	end
end

CoD.TouchpadVerticalList.FinishAddingElements = function (f11_arg0)
	local f11_local0 = f11_arg0.list
	local f11_local1 = 0
	local f11_local2 = f11_local0:getFirstChild()
	while f11_local2 do
		f11_local1 = f11_local1 + f11_local2:getHeight()
		f11_local2 = f11_local2:getNextSibling()
	end
	local f11_local3 = 720
	local f11_local4 = -f11_local3 / 2
	local f11_local5 = math.min(f11_local4, -f11_local1 + f11_local3 / 4)
	f11_local0.length = f11_local1
	f11_local0.maxScrollPos = f11_local4 + 64
	f11_local0.minScrollPos = f11_local5 - 64
	f11_local0.snapScrollPosMax = f11_local4
	f11_local0.snapScrollPosMin = f11_local5
	f11_local0.top = f11_local4
	f11_local0.translate = 0
	f11_local0.velocityNumFrames = 0
	f11_local0.velocityCurFrame = 0
	f11_local0.velocityCache = {
		0,
		0,
		0,
		0
	}
	f11_local0:beginAnimation("default", 0)
	f11_local0:setLeftRight(true, true, 0, 0)
	f11_local0:setTopBottom(false, false, f11_local4, f11_local4 + f11_local1)
	local f11_local6 = f11_local0:getFirstChild()
	f11_local6:setFocus(true)
end

local f0_local7 = function (f12_arg0)
	local f12_local0, f12_local1, f12_local2, f12_local3 = child:getLocalRect()
	return f12_local3 - f12_local1
end

CoD.TouchpadVerticalList.AddElement = function (f13_arg0, f13_arg1)
	if not f13_arg1.getHeight then
		f13_arg1.getHeight = f0_local7
	end
	f13_arg0.list:addElement(f13_arg1)
end

local f0_local8 = function (f14_arg0)
	f0_local0(f14_arg0)
	f14_arg0.cannotDrag = f14_arg0.cannotDrag + 1
end

CoD.TouchpadVerticalList.new = function (f15_arg0, f15_arg1)
	if not f15_arg1 then
		f15_arg1 = CoD.TouchpadVerticalList.DefaultElementSpacing
	end
	local list = LUI.UIVerticalList.new(f15_arg0)
	if not f15_arg0 then
		list:setLeftRight(true, true, 0, 0)
		list:setTopBottom(true, true, 0, 0)
	end
	list:setSpacing(f15_arg1)
	list.spacing = f15_arg1
	list.length = 0
	list.cannotDrag = 0
	list.cannotDragSource = 0
	list:makeFocusable()
	list.tickDistance = 100
	list.tickSound = nil
	list.debugName = "TouchpadVerticalList.verticalList"
	if CoD.isWIIU then
		list:registerEventHandler("touchpad_move", CoD.TouchpadVerticalList.TouchpadMove)
		list:registerEventHandler("touchpad_up", CoD.TouchpadVerticalList.TouchpadUp)
		list:registerEventHandler("touchpad_down", CoD.TouchpadVerticalList.TouchpadDown)
	else
		list:registerEventHandler("mousemove", function (f16_arg0, f16_arg1)
			if f16_arg0.buttonDown then
				CoD.TouchpadVerticalList.TouchpadMove(f16_arg0, f16_arg1)
			end
		end)
		list:registerEventHandler("mousedown", function (f17_arg0, f17_arg1)
			f17_arg0.buttonDown = true
			CoD.TouchpadVerticalList.TouchpadDown(f17_arg0, f17_arg1)
		end)
		list:registerEventHandler("mouseup", function (f18_arg0, f18_arg1)
			f18_arg0.buttonDown = false
			CoD.TouchpadVerticalList.TouchpadUp(f18_arg0, f18_arg1)
		end)
	end
	list:registerEventHandler("transition_complete_taper", function (f19_arg0, f19_arg1)
		f0_local5(f19_arg0)
	end)
	list:registerEventHandler("transition_complete_snap", function (f20_arg0, f20_arg1)
		f20_arg0.snapAnim = false
	end)
	list:registerEventHandler("disable_drag", f0_local8)
	local Widget = LUI.UIElement.new(f15_arg0)
	Widget:addElement(list)
	Widget.list = list
	
	Widget:setUseStencil(true)
	Widget.addButton = CoD.TouchpadVerticalList.AddButton
	Widget.addText = CoD.TouchpadVerticalList.AddText
	Widget.showRect = CoD.TouchpadVerticalList.ShowRect
	Widget.addElement = CoD.TouchpadVerticalList.AddElement
	Widget.finishAddingElements = CoD.TouchpadVerticalList.FinishAddingElements
	Widget.debugName = "TouchpadVerticalList"
	return Widget
end

