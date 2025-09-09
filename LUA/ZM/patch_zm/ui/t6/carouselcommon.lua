CoD.CarouselCommon = {}
CoD.CarouselCommon.MouseDragDistance = 25
CoD.CarouselCommon.SetupCarousel = function (f1_arg0)
	f1_arg0.clearAllItems = CoD.CarouselCommon.ClearAllItems
	f1_arg0.getNumItems = CoD.CarouselCommon.GetNumItems
	f1_arg0.getCurrentItemIndex = CoD.CarouselCommon.GetCurrentItemIndex
	f1_arg0.getCurrentItem = CoD.CarouselCommon.GetCurrentItem
	f1_arg0.setStartItem = CoD.CarouselCommon.SetStartItem
	f1_arg0.setPipPosition = CoD.CarouselCommon.SetPipPosition
	f1_arg0.getMouseRange = CoD.CarouselCommon.GetMouseRange
	f1_arg0.setMouseRange = CoD.CarouselCommon.SetMouseRange
	f1_arg0.setMouseDragDistance = CoD.CarouselCommon.SetMouseDragDistance
	f1_arg0:registerEventHandler("mouseup", CoD.CarouselCommon.MouseUp)
	f1_arg0:registerEventHandler("container_mouse_click", CoD.CarouselCommon.ContainerMouseClick)
	f1_arg0:registerEventHandler("container_mouse_enter", CoD.CarouselCommon.ContainerMouseEnter)
	f1_arg0:registerEventHandler("container_mouse_leave", CoD.CarouselCommon.ContainerMouseLeave)
	f1_arg0:registerEventHandler("minicontainer_mouse_click", CoD.CarouselCommon.MiniContainerMouseClick)
	f1_arg0:registerEventHandler("minicontainer_mouse_enter", CoD.CarouselCommon.MiniContainerMouseEnter)
	f1_arg0:registerEventHandler("minicontainer_mouse_leave", CoD.CarouselCommon.MiniContainerMouseLeave)
	f1_arg0.list:registerEventHandler("transition_complete_edge_bounce", CoD.CarouselCommon.List_EdgeBounce)
	f1_arg0.list:registerEventHandler("transition_complete_carousel_scroll", CoD.CarouselCommon.List_CarouselScrollComplete)
end

CoD.CarouselCommon.List_EdgeBounce = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0:getParent()
	f2_local0:scrollToItem(f2_local0.m_currentItem, f2_local0.m_scrollTime)
end

CoD.CarouselCommon.List_CarouselScrollComplete = function (f3_arg0, f3_arg1)
	f3_arg0.m_scrolling = nil
	local f3_local0 = f3_arg0:getParent()
	local f3_local1 = f3_arg0.containers[f3_local0.m_currentItem]
	if f3_local1 ~= nil then
		f3_local1:dispatchEventToChildren({
			name = "carousel_scroll_complete"
		})
	end
end

CoD.CarouselCommon.SetStartItem = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.list:getNumChildren()
	if f4_local0 == 0 then
		return 
	elseif f4_local0 < f4_arg1 then
		f4_arg1 = f4_arg0:getNumItems()
	end
	f4_arg0.list.containers[f4_arg1]:dispatchEventToChildren({
		name = "animate",
		animationStateName = "carousel_set_start"
	})
	f4_arg0:scrollToItem(f4_arg1, 0)
end

CoD.CarouselCommon.GetNumItems = function (f5_arg0)
	return f5_arg0.list:getNumChildren()
end

CoD.CarouselCommon.GetCurrentItemIndex = function (f6_arg0)
	return f6_arg0.m_currentItem
end

CoD.CarouselCommon.GetCurrentItem = function (f7_arg0)
	local f7_local0 = f7_arg0
	return f7_arg0.list.containers[f7_arg0:getCurrentItemIndex()].content
end

CoD.CarouselCommon.ClearAllItems = function (f8_arg0)
	if f8_arg0:getNumItems() == 0 then
		return 
	end
	local f8_local0 = nil
	for f8_local1 = 1, #f8_arg0.list.containers, 1 do
		f8_local0 = f8_arg0.list.containers[f8_local1]
		f8_local0:processEvent({
			name = "lose_focus"
		})
		f8_local0:removeAllChildren()
		f8_arg0.miniList.miniContainers[f8_local1]:removeAllChildren()
	end
	f8_arg0.list:removeAllChildren()
	f8_arg0.list.containers = {}
	f8_arg0.miniList:removeAllChildren()
	f8_arg0.miniList.miniContainers = {}
	f8_arg0.m_currentItem = nil
end

CoD.CarouselCommon.SetPipPosition = function (f9_arg0, f9_arg1)
	f9_arg0.miniList:registerAnimationState("default", f9_arg1)
	f9_arg0.miniList:animateToState("default")
end

CoD.CarouselCommon.GetMouseRange = function (f10_arg0)
	return f10_arg0.m_mouseRange
end

CoD.CarouselCommon.SetMouseRange = function (f11_arg0, f11_arg1)
	f11_arg0.m_mouseRange = f11_arg1
end

CoD.CarouselCommon.SetMouseDragDistance = function (f12_arg0, f12_arg1)
	f12_arg0.m_mouseDragDistance = f12_arg1
end

CoD.CarouselCommon.MouseUp = function (f13_arg0, f13_arg1)
	if f13_arg0.m_mouseDrag then
		f13_arg0.m_mouseDrag = nil
		f13_arg0.mouseDragListener:processEvent(f13_arg1)
	else
		f13_arg0:dispatchEventToChildren(f13_arg1)
	end
end

CoD.CarouselCommon.Container_LeftMouseUp = function (f14_arg0, f14_arg1)
	if f14_arg1.inside then
		f14_arg0:dispatchEventToParent({
			name = "container_mouse_click",
			controller = f14_arg1.controller,
			index = f14_arg0.index
		})
	end
end

CoD.CarouselCommon.Container_MouseEnter = function (f15_arg0, f15_arg1)
	f15_arg0:dispatchEventToParent({
		name = "container_mouse_enter",
		controller = f15_arg1.controller,
		index = f15_arg0.index,
		container = f15_arg0
	})
end

CoD.CarouselCommon.Container_MouseLeave = function (f16_arg0, f16_arg1)
	f16_arg0:dispatchEventToParent({
		name = "container_mouse_leave",
		controller = f16_arg1.controller,
		index = f16_arg0.index,
		container = f16_arg0
	})
end

CoD.CarouselCommon.MiniContainer_LeftMouseUp = function (f17_arg0, f17_arg1)
	if f17_arg1.inside then
		f17_arg0:dispatchEventToParent({
			name = "minicontainer_mouse_click",
			controller = f17_arg1.controller,
			index = f17_arg0.index
		})
	end
end

CoD.CarouselCommon.MiniContainer_MouseEnter = function (f18_arg0, f18_arg1)
	f18_arg0:dispatchEventToParent({
		name = "minicontainer_mouse_enter",
		controller = f18_arg1.controller,
		index = f18_arg0.index,
		miniContainer = f18_arg0
	})
end

CoD.CarouselCommon.MiniContainer_MouseLeave = function (f19_arg0, f19_arg1)
	f19_arg0:dispatchEventToParent({
		name = "minicontainer_mouse_leave",
		controller = f19_arg1.controller,
		index = f19_arg0.index,
		miniContainer = f19_arg0
	})
end

CoD.CarouselCommon.ContainerMouseClick = function (f20_arg0, f20_arg1)
	local f20_local0 = f20_arg0:getMouseRange()
	local f20_local1 = f20_arg0:getCurrentItemIndex()
	local f20_local2 = f20_arg1.index
	if not (f20_local0 == nil or f20_local0 >= math.abs(f20_local2 - f20_local1)) or f20_arg0.m_mouseDrag then
		return 
	elseif f20_local2 ~= f20_local1 then
		f20_arg0:scrollToItem(f20_local2, f20_arg0.m_scrollTime)
	else
		local f20_local3 = f20_arg0:getCurrentItem()
		f20_local3:processEvent({
			name = "button_action",
			controller = f20_arg1.controller
		})
	end
end

CoD.CarouselCommon.ContainerMouseEnter = function (f21_arg0, f21_arg1)
	f21_arg1.container:dispatchEventToChildren({
		name = "carousel_mouse_enter",
		controller = f21_arg1.controller,
		isSelected = f21_arg1.index == f21_arg0:getCurrentItemIndex()
	})
end

CoD.CarouselCommon.ContainerMouseLeave = function (f22_arg0, f22_arg1)
	f22_arg1.container:dispatchEventToChildren({
		name = "carousel_mouse_leave",
		controller = f22_arg1.controller,
		isSelected = f22_arg1.index == f22_arg0:getCurrentItemIndex()
	})
end

CoD.CarouselCommon.MiniContainerMouseClick = function (f23_arg0, f23_arg1)
	local f23_local0 = f23_arg0:getCurrentItemIndex()
	local f23_local1 = f23_arg1.index
	if f23_local1 ~= f23_local0 then
		f23_arg0:scrollToItem(f23_local1, f23_arg0.m_scrollTime)
	end
end

CoD.CarouselCommon.MiniContainerMouseEnter = function (f24_arg0, f24_arg1)
	if f24_arg1.index ~= f24_arg0:getCurrentItemIndex() then
		f24_arg1.miniContainer.background:beginAnimation("selected", 100)
		f24_arg1.miniContainer.background:setImage(CoD.HorizontalCarousel.PipFillMaterial)
	end
end

CoD.CarouselCommon.MiniContainerMouseLeave = function (f25_arg0, f25_arg1)
	if f25_arg1.index ~= f25_arg0:getCurrentItemIndex() then
		f25_arg1.miniContainer.background:beginAnimation("default", 100)
		f25_arg1.miniContainer.background:setImage(CoD.HorizontalCarousel.PipMaterial)
	end
end

