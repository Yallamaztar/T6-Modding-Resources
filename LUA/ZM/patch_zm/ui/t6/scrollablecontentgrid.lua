require("T6.ContentgridButton")
CoD.ScrollableContentGrid = {}
CoD.ScrollableContentGrid.Spacing = 5
CoD.ScrollableContentGrid.ItemSize = 100
CoD.ScrollableContentGrid.ItemWidth = 110
CoD.ScrollableContentGrid.ItemHeight = 90
CoD.ScrollableContentGrid.PositionTextFont = "ExtraSmall"
local f0_local0 = function (f1_arg0, f1_arg1)
	if f1_arg0.m_numTotalItems <= f1_arg0.m_numItems and f1_arg0.m_scrollBarContainer then
		f1_arg0.m_scrollBarContainer:close()
		return 
	end
	local Widget, f1_local1, f1_local2 = nil
	if not f1_arg0.m_scrollBarContainer:getParent() then
		f1_arg0:addElement(f1_arg0.m_scrollBarContainer)
	end
	if f1_arg0.m_scrollBarContainer and f1_arg0.m_scrollBarContainer.scrollBar then
		Widget = f1_arg0.m_scrollBarContainer.scrollBar
		Widget:beginAnimation("scroll", 100)
	else
		Widget = LUI.UIElement.new()
		Widget.barBG = LUI.UIImage.new()
		Widget.barBgGrad = LUI.UIImage.new()
	end
	local f1_local3 = 2
	local f1_local4 = f1_arg0.m_totalHeight
	local f1_local5 = math.ceil(f1_arg0.m_numTotalItems / f1_arg0.m_numItemsWide)
	local f1_local6 = f1_arg0.m_numItemsTall / f1_local5 * f1_local4 - f1_local3 * 2
	local f1_local7 = math.ceil((f1_arg0.m_pageStartIndex - 1) / f1_arg0.m_numItemsWide) / f1_local5 * f1_local4 + f1_local3
	Widget:setLeftRight(true, true, f1_local3, -f1_local3)
	Widget:setTopBottom(true, false, f1_local7, f1_local7 + f1_local6)
	f1_local1 = Widget.barBG
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, true, 0, 0)
	f1_local1:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	Widget:addElement(f1_local1)
	f1_local2 = Widget.barBgGrad
	f1_local2:setLeftRight(true, true, 0, 0)
	f1_local2:setTopBottom(true, true, 0, 0)
	f1_local2:setImage(RegisterMaterial(CoD.MPZM("menu_mp_cac_grad_stretch", "menu_zm_cac_grad_stretch")))
	f1_local2:setAlpha(0.4)
	Widget:addElement(f1_local2)
	f1_arg0.m_scrollBarContainer.scrollBar = Widget
	f1_arg0.m_scrollBarContainer:addElement(Widget)
end

local f0_local1 = function (f2_arg0, f2_arg1)
	local f2_local0 = 20
	local f2_local1 = math.min(math.ceil(f2_arg0.m_numTotalItems / f2_arg0.m_numItemsWide), f2_arg0.m_numItemsTall)
	local f2_local2 = f2_local1 * f2_arg0.m_itemHeight + f2_arg0.m_spacing * (f2_local1 - 1) + f2_local0
	local f2_local3 = CoD.textSize[CoD.ScrollableContentGrid.PositionTextFont]
	local f2_local4 = CoD.fonts[CoD.ScrollableContentGrid.PositionTextFont]
	local f2_local5 = Engine.Localize("MENU_SHOWING_X_OF_Y", f2_arg1, f2_arg0.m_numTotalItems)
	local f2_local6, f2_local7, f2_local8, f2_local9 = GetTextDimensions(f2_local5, f2_local4, f2_local3)
	local f2_local10 = f2_local8 - f2_local6
	local m_positionTextContainer = nil
	if not f2_arg0.m_positionTextContainer then
		local f2_local12 = 0
		local f2_local13 = 15
		local f2_local14 = 15
		local f2_local15 = 20
		local f2_local16 = f2_local10 + f2_local15 * 2 + f2_local13 + f2_local14
		m_positionTextContainer = LUI.UIElement.new()
		f2_local12 = f2_arg0.m_totalWidth / 2 - f2_local16 / 2 + 10
		m_positionTextContainer:setLeftRight(true, false, f2_local12, f2_local12 + f2_local16)
		m_positionTextContainer:setTopBottom(true, false, f2_local2, f2_local2 + f2_local3)
		f2_arg0:addElement(m_positionTextContainer)
		f2_arg0.m_positionTextContainer = m_positionTextContainer
		
		f2_local12 = 0
		
		local textElem = LUI.UIText.new()
		textElem:setLeftRight(true, false, f2_local12, f2_local12 + f2_local10)
		textElem:setTopBottom(true, true, 0, 0)
		textElem:setFont(f2_local4)
		m_positionTextContainer.textElem = textElem
		m_positionTextContainer:addElement(textElem)
		m_positionTextContainer.textElem = textElem
		
		f2_local12 = f2_local12 + f2_local10 + f2_local13
		
		local upArrow = LUI.UIImage.new()
		upArrow:setLeftRight(true, false, f2_local12, f2_local12 + f2_local15)
		upArrow:setTopBottom(false, false, -f2_local15 / 2, f2_local15 / 2)
		upArrow:setZRot(90)
		upArrow:setImage(RegisterMaterial("ui_arrow_right"))
		m_positionTextContainer:addElement(upArrow)
		m_positionTextContainer.upArrow = upArrow
		
		f2_local12 = f2_local12 + f2_local14
		local f2_local19 = LUI.UIImage.new()
		f2_local19:setLeftRight(true, false, f2_local12, f2_local12 + f2_local15)
		f2_local19:setTopBottom(false, false, -f2_local15 / 2, f2_local15 / 2)
		f2_local19:setZRot(-90)
		f2_local19:setImage(RegisterMaterial("ui_arrow_right"))
		m_positionTextContainer:addElement(f2_local19)
		m_positionTextContainer.downArrow = f2_local19
	end
	m_positionTextContainer = f2_arg0.m_positionTextContainer
	m_positionTextContainer.textElem:setText(f2_local5)
	if f2_arg0.m_numTotalItems <= f2_arg0.m_numItems then
		m_positionTextContainer.upArrow:hide()
		m_positionTextContainer.downArrow:hide()
		local f2_local12 = f2_local10
		local f2_local13 = f2_arg0.m_totalWidth / 2 - f2_local12 / 2
		m_positionTextContainer:setLeftRight(true, false, f2_local13, f2_local13 + f2_local12)
		m_positionTextContainer.textElem:setLeftRight(true, false, 0, f2_local10)
	else
		if math.ceil((f2_arg0.m_pageStartIndex - 1) / f2_arg0.m_numItemsWide) > 0 then
			m_positionTextContainer.upArrow:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		else
			m_positionTextContainer.upArrow:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
		end
		if f2_arg0.m_pageStartIndex - 1 + f2_arg0.m_numItems < f2_arg0.m_numTotalItems then
			m_positionTextContainer.downArrow:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		else
			m_positionTextContainer.downArrow:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
		end
	end
	f0_local0(f2_arg0, f2_arg1)
end

local f0_local2 = function (f3_arg0, f3_arg1)
	if f3_arg0 and f3_arg0.m_focussedItem and f3_arg0.m_focussedItem == f3_arg1 then
		f3_arg0:dispatchEventToParent({
			name = "grid_focus_changed",
			index = f3_arg0.m_focussedItem.m_index
		})
		f0_local1(f3_arg0, f3_arg0.m_focussedItem.m_index)
		return 
	elseif f3_arg0.m_focussedItem ~= nil then
		f3_arg0.m_focussedItem.button:processEvent({
			name = "lose_focus",
			controller = f3_arg0.m_controller
		})
	end
	f3_arg0.m_focussedItem = f3_arg1
	f3_arg0.m_focussedItem.button:processEvent({
		name = "gain_focus",
		controller = f3_arg0.m_controller
	})
	f0_local1(f3_arg0, f3_arg0.m_focussedItem.m_index)
	f3_arg0:dispatchEventToParent({
		name = "grid_focus_changed",
		index = f3_arg0.m_focussedItem.m_index
	})
	Engine.PlaySound("cac_grid_nav")
end

CoD.ScrollableContentGrid.SetTotalItems = function (f4_arg0, f4_arg1)
	if f4_arg1 <= 0 and f4_arg0.m_scrollBarContainer then
		f4_arg0.m_scrollBarContainer:close()
	end
	if f4_arg0.m_numTotalItems == nil or f4_arg0.m_numTotalItems ~= f4_arg1 then
		f4_arg0.m_numTotalItems = f4_arg1
	end
	f4_arg0:generate()
end

local f0_local3 = function (f5_arg0)
	for f5_local3, f5_local4 in ipairs(f5_arg0.items) do
		f5_local4:hide()
	end
end

local f0_local4 = function (f6_arg0, f6_arg1)
	if f6_arg0.m_numTotalItems == 0 then
		f0_local3(f6_arg0)
		return 
	end
	for f6_local3, f6_local4 in ipairs(f6_arg0.items) do
		f6_local4.m_index = f6_arg0.m_pageStartIndex + f6_local3 - 1
		if f6_local4.m_index <= f6_arg0.m_numTotalItems then
			f6_local4.dataCallback(f6_arg0.m_controller, f6_local4, f6_arg0)
			f6_local4:show()
		else
			f6_local4:hide()
		end
	end
	f0_local2(f6_arg0, f6_arg1)
end

local f0_local5 = function (f7_arg0)
	if f7_arg0.m_focussedItem == nil then
		return 
	end
	local f7_local0 = f7_arg0.m_focussedItem.contentIndex
	local f7_local1 = f7_arg0.m_focussedItem.m_index
	local f7_local2 = f7_local0 - 1
	if f7_local0 == 1 and f7_local2 < 1 and f7_local1 - f7_arg0.m_numItemsWide >= 1 then
		f7_arg0.m_pageStartIndex = f7_arg0.m_pageStartIndex - f7_arg0.m_numItemsWide
		f0_local4(f7_arg0, f7_arg0.items[f7_arg0.m_numItemsWide])
		return 
	elseif f7_local2 >= 1 then
		f0_local2(f7_arg0, f7_arg0.items[f7_local2])
	end
end

local f0_local6 = function (f8_arg0)
	if f8_arg0.m_focussedItem == nil then
		return 
	end
	local f8_local0 = f8_arg0.m_focussedItem.contentIndex
	local f8_local1 = f8_arg0.m_focussedItem.m_index
	local f8_local2 = f8_local0 + 1
	local f8_local3 = f8_local1 + 1
	if f8_local0 == f8_arg0.m_numItems and f8_arg0.m_numItems < f8_local2 and f8_local3 <= f8_arg0.m_numTotalItems then
		f8_arg0.m_pageStartIndex = f8_arg0.m_pageStartIndex + f8_arg0.m_numItemsWide
		f0_local4(f8_arg0, f8_arg0.items[f8_arg0.m_numItemsWide * (f8_arg0.m_numItemsTall - 1) + 1])
		return 
	elseif f8_local2 <= f8_arg0.m_numItems and f8_local3 <= f8_arg0.m_numTotalItems then
		f0_local2(f8_arg0, f8_arg0.items[f8_local2])
	end
end

local f0_local7 = function (f9_arg0)
	local f9_local0 = f9_arg0.m_focussedItem
	if f9_local0 == nil then
		return 
	else
		local f9_local1 = f9_arg0.m_focussedItem.contentIndex
		local f9_local2 = f9_arg0.m_focussedItem.m_index
		local f9_local3 = f9_local1 - f9_arg0.m_numItemsWide
		if f9_local2 - f9_arg0.m_numItemsWide < 1 then
			return 
		elseif f9_local3 < 1 then
			f9_arg0.m_pageStartIndex = f9_arg0.m_pageStartIndex - f9_arg0.m_numItemsWide
			f0_local4(f9_arg0, f9_local0)
			return 
		else
			f0_local2(f9_arg0, f9_arg0.items[f9_local3])
		end
	end
end

local f0_local8 = function (f10_arg0)
	local f10_local0 = f10_arg0.m_focussedItem
	if f10_local0 == nil then
		return 
	end
	local f10_local1 = f10_arg0.m_focussedItem.contentIndex
	local f10_local2 = f10_arg0.m_focussedItem.m_index
	local f10_local3 = f10_local1 + f10_arg0.m_numItemsWide
	local f10_local4 = f10_local2 + f10_arg0.m_numItemsWide
	local f10_local5 = nil
	if f10_local2 % f10_arg0.m_numItemsWide == 0 then
		f10_local5 = f10_local2 + 1
	else
		f10_local5 = f10_local2 + f10_arg0.m_numItemsWide - f10_local2 % f10_arg0.m_numItemsWide + 1
	end
	if f10_arg0.m_numTotalItems < f10_local5 or f10_local3 <= f10_arg0.m_numItems and f10_arg0.m_numTotalItems < f10_local4 then
		return 
	elseif f10_local4 <= f10_arg0.m_numTotalItems and f10_local3 <= f10_arg0.m_numItems then
		f0_local2(f10_arg0, f10_arg0.items[f10_local3])
		return 
	elseif f10_arg0.m_numItems < f10_local3 and f10_local4 <= f10_arg0.m_numTotalItems then
		f10_arg0.m_pageStartIndex = f10_arg0.m_pageStartIndex + f10_arg0.m_numItemsWide
		f0_local4(f10_arg0, f10_local0)
		return 
	end
	local f10_local6 = f10_arg0.m_numItemsWide * (f10_arg0.m_numItemsTall - 1) + 1
	f10_arg0.m_pageStartIndex = f10_arg0.m_pageStartIndex + f10_arg0.m_numItemsWide
	f0_local4(f10_arg0, f10_arg0.items[f10_local6])
end

local f0_local9 = function (f11_arg0, f11_arg1)
	if f11_arg0.m_inputDisabled then
		return 
	elseif f11_arg1.down == true and f11_arg1.button == "left" then
		f0_local5(f11_arg0)
	elseif f11_arg1.down == true and f11_arg1.button == "right" then
		f0_local6(f11_arg0)
	elseif f11_arg1.down == true and f11_arg1.button == "up" then
		f0_local7(f11_arg0)
	elseif f11_arg1.down == true and f11_arg1.button == "down" then
		f0_local8(f11_arg0)
	end
	f11_arg0:dispatchEventToChildren(f11_arg1)
end

local f0_local10 = function (f12_arg0, f12_arg1)
	if f12_arg1.gridItem.m_index <= f12_arg0.m_numTotalItems then
		f0_local2(f12_arg0, f12_arg1.gridItem)
	end
end

local f0_local11 = function (f13_arg0, f13_arg1)
	if f13_arg1.dragDirection == "up" then
		f0_local7(f13_arg0)
	elseif f13_arg1.dragDirection == "down" then
		f0_local8(f13_arg0)
	end
end

local f0_local12 = function (f14_arg0, f14_arg1)
	f14_arg0:dispatchEventToParent({
		name = "griditem_mouseover",
		controller = f14_arg1.controller,
		gridItem = f14_arg0
	})
end

local f0_local13 = function (f15_arg0, f15_arg1)
	f15_arg0.m_curY = f15_arg1.y
end

local f0_local14 = function (f16_arg0, f16_arg1)
	local f16_local0, f16_local1, f16_local2, f16_local3 = f16_arg0:getRect()
	local f16_local4 = (f16_local3 - f16_local1) * 0.1
	local f16_local5 = nil
	if f16_local4 < math.abs(f16_arg0.m_curY - f16_arg1.y) then
		if f16_arg0.m_curY < f16_arg1.y then
			f16_local5 = "down"
		elseif f16_arg1.y < f16_arg0.m_curY then
			f16_local5 = "up"
		end
		f16_arg0.m_curY = f16_arg1.y
		f16_arg0:dispatchEventToParent({
			name = "grid_scrollbar_drag",
			dragDirection = f16_local5
		})
	end
end

CoD.ScrollableContentGrid.AddScrollBar = function (f17_arg0)
	local f17_local0 = 12
	local f17_local1 = f17_arg0.m_totalWidth + 15
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f17_local1, f17_local1 + f17_local0)
	Widget:setTopBottom(true, false, 0, f17_arg0.m_totalHeight)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.05))
	local f17_local3 = LUI.UIImage.new()
	f17_local3:setLeftRight(true, true, 1, -1)
	f17_local3:setTopBottom(true, true, 1, -1)
	f17_local3:setRGB(0, 0, 0)
	f17_local3:setAlpha(0.4)
	Widget:addElement(f17_local3)
	local f17_local4 = LUI.UIImage.new()
	f17_local4:setLeftRight(true, true, 2, -2)
	f17_local4:setTopBottom(true, true, 2, -2)
	f17_local4:setImage(RegisterMaterial(CoD.MPZM("menu_mp_cac_grad_stretch", "menu_zm_cac_grad_stretch")))
	f17_local4:setAlpha(0.1)
	Widget:addElement(f17_local4)
	if CoD.useMouse then
		Widget:setHandleMouse(true)
		Widget:registerEventHandler("leftmousedown", f0_local13)
		Widget:registerEventHandler("leftmouseup", CoD.NullFunction)
		Widget:registerEventHandler("mousedrag", f0_local14)
	end
	f17_arg0.m_scrollBarContainer = Widget
	f17_arg0:addElement(f17_arg0.m_scrollBarContainer)
end

CoD.ScrollableContentGrid.new = function (f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4, f18_arg5, f18_arg6, f18_arg7, f18_arg8)
	local Widget = LUI.UIElement.new(f18_arg1)
	Widget.id = "scrollableContentGrid"
	Widget.m_controller = f18_arg0
	Widget.m_numItemsTall = f18_arg2
	Widget.m_numItemsWide = f18_arg3
	Widget.m_numItems = Widget.m_numItemsTall * Widget.m_numItemsWide
	Widget.m_numTotalItems = nil
	Widget.m_spacing = CoD.ScrollableContentGrid.Spacing
	Widget.m_itemWidth = CoD.ScrollableContentGrid.ItemWidth
	Widget.m_itemHeight = CoD.ScrollableContentGrid.ItemHeight
	Widget.generate = CoD.ScrollableContentGrid.Generate
	Widget.setTotalItems = CoD.ScrollableContentGrid.SetTotalItems
	Widget.createItemMutables = f18_arg4
	Widget.populateItemMutables = f18_arg5
	Widget.refresh = CoD.ScrollableContentGrid.Refresh
	Widget.items = {}
	if f18_arg8 then
		Widget.m_spacing = f18_arg8
	end
	if f18_arg6 then
		Widget.m_itemWidth = f18_arg6
	end
	if f18_arg7 then
		Widget.m_itemHeight = f18_arg7
	end
	Widget.m_totalWidth = Widget.m_itemWidth * Widget.m_numItemsWide + Widget.m_spacing * (Widget.m_numItemsWide - 1)
	Widget.m_totalHeight = Widget.m_itemHeight * Widget.m_numItemsTall + Widget.m_spacing * (Widget.m_numItemsTall - 1)
	CoD.ScrollableContentGrid.AddScrollBar(Widget)
	Widget:registerEventHandler("gamepad_button", f0_local9)
	if CoD.useMouse then
		Widget:registerEventHandler("griditem_mouseover", f0_local10)
		Widget:registerEventHandler("grid_scrollbar_drag", f0_local11)
	end
	return Widget
end

CoD.ScrollableContentGrid.Generate = function (f19_arg0)
	if f19_arg0.m_numTotalItems == 0 then
		f0_local3(f19_arg0)
		return 
	elseif f19_arg0.createItemMutables ~= nil then
		for f19_local0 = 1, f19_arg0.m_numItems, 1 do
			local Widget = LUI.UIElement.new({
				left = 0,
				top = 0,
				right = 0,
				bottom = 0,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = true,
				bottomAnchor = true
			})
			Widget.button = CoD.ContentGridButton.new(f19_local0)
			Widget.dataCallback = f19_arg0.populateItemMutables
			f19_arg0.createItemMutables(f19_arg0.m_controller, Widget)
			Widget:addElement(Widget.button)
			local f19_local4 = f19_arg0.m_numItemsWide
			local f19_local5 = f19_local0 - 1
			local f19_local6 = f19_local5 % f19_local4
			local f19_local7 = (f19_local5 - f19_local6) / f19_local4
			local f19_local8 = f19_arg0.m_itemWidth
			local f19_local9 = f19_arg0.m_itemHeight
			local f19_local10 = f19_arg0.m_spacing
			local f19_local11 = f19_local6 * (f19_local8 + f19_local10)
			local f19_local12 = f19_local7 * (f19_local9 + f19_local10)
			Widget.itemHolder = LUI.UIElement.new({
				leftAnchor = true,
				rightAnchor = false,
				left = f19_local11,
				right = f19_local11 + f19_local8,
				topAnchor = true,
				bottomAnchor = false,
				top = f19_local12,
				bottom = f19_local12 + f19_local9
			})
			Widget.itemHolder:addElement(Widget)
			f19_arg0:addElement(Widget.itemHolder)
			Widget.contentIndex = f19_local0
			table.insert(f19_arg0.items, Widget)
			if CoD.useMouse then
				Widget:setHandleMouse(true)
				Widget:registerEventHandler("mouseover", f0_local12)
			end
		end
	end
	f19_arg0.createItemMutables = nil
	f19_arg0.m_pageStartIndex = 1
	f0_local4(f19_arg0, f19_arg0.items[1])
end

