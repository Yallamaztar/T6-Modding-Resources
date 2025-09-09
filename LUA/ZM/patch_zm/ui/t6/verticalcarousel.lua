require("T6.CarouselCommon")
CoD.VerticalCarousel = {}
CoD.VerticalCarousel.ExpansionScale = 1.5
CoD.VerticalCarousel.ItemWidth = 100
CoD.VerticalCarousel.ItemHeight = 100
CoD.VerticalCarousel.Spacing = 10
CoD.VerticalCarousel.ScrollTime = 100
CoD.VerticalCarousel.EdgeBounceOffset = 10
CoD.VerticalCarousel.MiniCarouselSize = 10
if CoD.isSinglePlayer then
	CoD.VerticalCarousel.ScrollUpSFX = "uin_main_nav"
	CoD.VerticalCarousel.ScrollDownSFX = "uin_main_nav"
else
	CoD.VerticalCarousel.ScrollUpSFX = "uin_slide_nav_up"
	CoD.VerticalCarousel.ScrollDownSFX = "uin_slide_nav_down"
end
CoD.VerticalCarousel.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6)
	local Widget = LUI.UIElement.new(f1_arg0)
	Widget.id = "VerticalCarousel"
	Widget:setUseStencil(true)
	if CoD.VerticalCarousel.PipMaterial == nil then
		CoD.VerticalCarousel.PipMaterial = RegisterMaterial("menu_vis_carousel_pip")
	end
	if CoD.VerticalCarousel.PipFillMaterial == nil then
		CoD.VerticalCarousel.PipFillMaterial = RegisterMaterial("menu_vis_carousel_pip_fill")
	end
	Widget.m_itemWidth = CoD.VerticalCarousel.ItemWidth
	if f1_arg1 ~= nil then
		Widget.m_itemWidth = f1_arg1
	end
	Widget.m_itemHeight = CoD.VerticalCarousel.ItemHeight
	if f1_arg2 ~= nil then
		Widget.m_itemHeight = f1_arg2
	end
	Widget.m_spacing = CoD.VerticalCarousel.Spacing
	if f1_arg3 ~= nil then
		Widget.m_spacing = f1_arg3
	end
	Widget.m_expansionScale = CoD.VerticalCarousel.ExpansionScale
	if f1_arg4 ~= nil then
		Widget.m_expansionScale = f1_arg4
	end
	Widget.m_scrollTime = CoD.VerticalCarousel.ScrollTime
	if f1_arg5 ~= nil then
		Widget.m_scrollTime = f1_arg5
	end
	if CoD.useMouse then
		local f1_local1 = Widget.m_itemWidth * Widget.m_expansionScale / 2
		Widget.mouseDragListener = CoD.MouseDragListener.new(CoD.CarouselCommon.MouseDragDistance)
		Widget.mouseDragListener:setLeftRight(false, false, -f1_local1, f1_local1)
		Widget.mouseDragListener:setTopBottom(true, true, 0, 0)
		Widget:addElement(Widget.mouseDragListener)
	end
	Widget.list = LUI.UIVerticalList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = 0,
		bottom = 0,
		spacing = Widget.m_spacing,
		alignment = LUI.Alignment.Center
	})
	Widget.list.containers = {}
	Widget:addElement(Widget.list)
	Widget.miniList = LUI.UIVerticalList.new({
		leftAnchor = false,
		rightAnchor = true,
		left = -CoD.VerticalCarousel.MiniCarouselSize,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		spacing = 2,
		alignment = LUI.Alignment.Middle
	})
	Widget.miniList.miniContainers = {}
	if f1_arg6 == true then
		Widget:addElement(Widget.miniList)
	end
	Widget.m_itemWidth = f1_arg1
	Widget.m_itemHeight = f1_arg2
	Widget.m_scrollSFX = CoD.VerticalCarousel.ScrollDownSFX
	CoD.CarouselCommon.SetupCarousel(Widget)
	Widget.handleGamepadButton = CoD.VerticalCarousel.HandleGamepadButton
	Widget.addItem = CoD.VerticalCarousel.AddItem
	Widget.scrollToItem = CoD.VerticalCarousel.ScrollToItem
	if CoD.useMouse then
		Widget:registerEventHandler("listener_mouse_drag", CoD.VerticalCarousel.MouseDrag)
	end
	Widget.upButtonRepeater = LUI.UIButtonRepeater.new("up", {
		name = "gamepad_button",
		button = "up",
		down = true
	})
	Widget:addElement(Widget.upButtonRepeater)
	Widget.downButtonRepeater = LUI.UIButtonRepeater.new("down", {
		name = "gamepad_button",
		button = "down",
		down = true
	})
	Widget:addElement(Widget.downButtonRepeater)
	return Widget
end

CoD.VerticalCarousel.MouseDrag = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.list:getNumChildren()
	if f2_local0 <= 0 then
		return 
	end
	local f2_local1 = nil
	if f2_arg1.direction == "down" and f2_arg0.m_currentItem > 1 then
		f2_local1 = -1
	elseif f2_arg1.direction == "up" and f2_arg0.m_currentItem < f2_local0 then
		f2_local1 = 1
	end
	if f2_arg0.m_currentItem and f2_local1 then
		f2_arg0:scrollToItem(f2_arg0.m_currentItem + f2_local1, f2_arg0.m_scrollTime)
	end
	f2_arg0.m_mouseDrag = true
end

CoD.VerticalCarousel.HandleGamepadButton = function (f3_arg0, f3_arg1)
	if LUI.UIElement.handleGamepadButton(f3_arg0, f3_arg1) == true then
		return true
	elseif f3_arg0.list:getNumChildren() > 1 then
		local f3_local0 = nil
		if f3_arg1.down == true then
			if f3_arg1.button == "down" then
				f3_local0 = 1
				f3_arg0.m_scrollSFX = CoD.VerticalCarousel.ScrollDownSFX
			elseif f3_arg1.button == "up" then
				f3_local0 = -1
				f3_arg0.m_scrollSFX = CoD.VerticalCarousel.ScrollUpSFX
			end
		end
		if f3_local0 ~= nil and f3_arg0.m_currentItem ~= nil then
			f3_arg0:scrollToItem(f3_arg0.m_currentItem + f3_local0, f3_arg0.m_scrollTime)
		end
	end
end

CoD.VerticalCarousel.ScrollToItem = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = f4_arg0.list:getNumChildren()
	if f4_local0 == 0 or f4_arg0.list.m_scrolling == true then
		return 
	end
	local f4_local1 = f4_arg2 ~= 0
	if f4_arg2 == nil then
		f4_arg2 = f4_arg0.m_scrollTime
		f4_local1 = false
	end
	local f4_local2 = nil
	if f4_arg1 < 1 then
		f4_arg0.list:beginAnimation("edge_bounce", f4_arg2 / 4, false, false)
		f4_arg0.list:setTopBottom(false, false, -(f4_arg0.m_itemHeight * f4_arg0.m_expansionScale) / 2 + CoD.VerticalCarousel.EdgeBounceOffset, 0)
		f4_arg0.upButtonRepeater:cancelRepetition()
	elseif f4_local0 < f4_arg1 then
		local f4_local3 = (f4_arg0.m_itemHeight + f4_arg0.m_spacing) * (f4_local0 - 1) + f4_arg0.m_itemHeight * f4_arg0.m_expansionScale / 2
		f4_arg0.list:beginAnimation("edge_bounce", f4_arg2 / 4, false, false)
		f4_arg0.list:setTopBottom(false, false, -f4_local3 - CoD.VerticalCarousel.EdgeBounceOffset, 0)
		f4_arg0.downButtonRepeater:cancelRepetition()
	else
		f4_local2 = f4_arg0.list.containers[f4_arg0.m_currentItem]
		if f4_arg1 ~= f4_arg0.m_currentItem and f4_local2 ~= nil then
			CoD.VerticalCarousel.ElemContainer_DefaultAnim(f4_local2, f4_arg0, f4_arg2)
			f4_local2:processEvent({
				name = "lose_focus"
			})
			f4_local2.miniContainer.background:beginAnimation("default", f4_arg2)
			f4_local2.miniContainer.background:setImage(CoD.VerticalCarousel.PipMaterial)
		end
		f4_arg0.m_currentItem = f4_arg1
		f4_local2 = f4_arg0.list.containers[f4_arg0.m_currentItem]
		f4_local2:processEvent({
			name = "gain_focus"
		})
		CoD.VerticalCarousel.ElemContainer_ExpandAnim(f4_local2, f4_arg0, f4_arg2)
		f4_local2.miniContainer.background:beginAnimation("selected", f4_arg2)
		f4_local2.miniContainer.background:setImage(CoD.VerticalCarousel.PipFillMaterial)
		local f4_local3 = (f4_arg0.m_itemHeight + f4_arg0.m_spacing) * (f4_arg0.m_currentItem - 1)
		f4_arg0.list:beginAnimation("carousel_scroll", f4_arg2, false, false)
		f4_arg0.list:setTopBottom(false, false, -(f4_arg0.m_itemHeight * f4_arg0.m_expansionScale) / 2 - f4_local3, 0)
		if f4_local1 == true then
			Engine.PlaySound(f4_arg0.m_scrollSFX)
		end
		f4_arg0.list.m_scrolling = true
	end
	return f4_local2
end

CoD.VerticalCarousel.AddItem = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget.id = "VerticalCarouselContainer"
	CoD.VerticalCarousel.ElemContainer_DefaultAnim(Widget, HudRef, 0)
	HudRef.list:addElement(Widget)
	table.insert(HudRef.list.containers, Widget)
	Widget.index = #HudRef.list.containers
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, CoD.VerticalCarousel.MiniCarouselSize)
	Widget.background = LUI.UIImage.new()
	Widget.background:setLeftRight(true, true, 0, 0)
	Widget.background:setTopBottom(true, true, 0, 0)
	Widget.background:setImage(CoD.VerticalCarousel.PipMaterial)
	Widget:addElement(Widget.background)
	HudRef.miniList:addElement(Widget)
	table.insert(HudRef.miniList.miniContainers, Widget)
	Widget.index = #HudRef.miniList.miniContainers
	Widget.miniContainer = Widget
	InstanceRef:setHandleMouse(false)
	Widget.content = InstanceRef
	Widget:addElement(InstanceRef)
	if CoD.useMouse then
		Widget:setHandleMouse(true)
		Widget:registerEventHandler("leftmousedown", CoD.NullFunction)
		Widget:registerEventHandler("leftmouseup", CoD.CarouselCommon.Container_LeftMouseUp)
		Widget:registerEventHandler("mouseenter", CoD.CarouselCommon.Container_MouseEnter)
		Widget:registerEventHandler("mouseleave", CoD.CarouselCommon.Container_MouseLeave)
		Widget:setHandleMouse(true)
		Widget:registerEventHandler("leftmousedown", CoD.NullFunction)
		Widget:registerEventHandler("leftmouseup", CoD.CarouselCommon.MiniContainer_LeftMouseUp)
		Widget:registerEventHandler("mouseenter", CoD.CarouselCommon.MiniContainer_MouseEnter)
		Widget:registerEventHandler("mouseleave", CoD.CarouselCommon.MiniContainer_MouseLeave)
	end
	if HudRef.m_currentItem == nil then
		HudRef.m_currentItem = 1
	end
	return Widget
end

CoD.VerticalCarousel.ElemContainer_DefaultAnim = function (f6_arg0, f6_arg1, f6_arg2)
	f6_arg0:beginAnimation("default", f6_arg2)
	f6_arg0:setLeftRight(false, false, -f6_arg1.m_itemWidth / 2, f6_arg1.m_itemWidth / 2)
	f6_arg0:setTopBottom(true, false, 0, f6_arg1.m_itemHeight)
end

CoD.VerticalCarousel.ElemContainer_ExpandAnim = function (f7_arg0, f7_arg1, f7_arg2)
	f7_arg0:beginAnimation("expand", f7_arg2)
	f7_arg0:setLeftRight(false, false, -(f7_arg1.m_itemWidth / 2 * f7_arg1.m_expansionScale), f7_arg1.m_itemWidth / 2 * f7_arg1.m_expansionScale)
	f7_arg0:setTopBottom(true, false, 0, f7_arg1.m_itemHeight * f7_arg1.m_expansionScale)
end

