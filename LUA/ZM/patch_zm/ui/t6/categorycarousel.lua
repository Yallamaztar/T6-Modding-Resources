require("T6.CarouselCategoryListener")
CoD.CategoryCarousel = {}
CoD.CategoryCarousel.BumperControls = true
CoD.CategoryCarousel.BumperAspectRatio = 1
CoD.CategoryCarousel.BumperHeight = 30
CoD.CategoryCarousel.BumperWidth = CoD.CategoryCarousel.BumperHeight * CoD.CategoryCarousel.BumperAspectRatio
CoD.CategoryCarousel.BumperOffset = 15
CoD.CategoryCarousel.BumperFontName = "ExtraSmall"
CoD.CategoryCarousel.IndicatorSize = 30
CoD.CategoryCarousel.IndicatorAlpha = 0.5
CoD.CategoryCarousel.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	local f1_local0 = CoD.HorizontalCarousel.new(f1_arg0, f1_arg1, f1_arg2, f1_arg3, 1, f1_arg4)
	f1_local0.id = "CategoryCarousel"
	f1_local0:registerEventHandler("carousel_category_changed", CoD.CategoryCarousel.CarouselCategoryChanged)
	f1_local0:registerEventHandler("input_source_changed", CoD.CategoryCarousel.InputSourceChanged)
	f1_local0:registerEventHandler("indicator_scroll", CoD.CategoryCarousel.IndicatorScroll)
	f1_local0:registerEventHandler("reset_controls", function (f12_arg0, f12_arg1)
		f12_arg0.resetControls = nil
	end)
	f1_local0.addCategory = CoD.CategoryCarousel.AddCategory
	f1_local0.addLeftIndicator = CoD.CategoryCarousel.AddLeftIndicator
	f1_local0.addRightIndicator = CoD.CategoryCarousel.AddRightIndicator
	if CoD.CategoryCarousel.BumperControls then
		f1_local0.handleGamepadButton = CoD.CategoryCarousel.BumperControlsOverride
		
		local leftBumper = LUI.UIText.new()
		leftBumper:setLeftRight(true, false, 0, CoD.CategoryCarousel.BumperWidth)
		leftBumper:setTopBottom(true, false, 0, CoD.CategoryCarousel.BumperHeight)
		leftBumper:setFont(CoD.fonts[CoD.CategoryCarousel.BumperFontName])
		leftBumper:setAlpha(0)
		leftBumper:setText(CoD.buttonStrings.shoulderl)
		f1_local0:addElement(leftBumper)
		f1_local0.leftBumper = leftBumper
		
		local rightBumper = LUI.UIText.new()
		rightBumper:setLeftRight(false, true, -CoD.CategoryCarousel.BumperWidth, 0)
		rightBumper:setTopBottom(true, false, 0, CoD.CategoryCarousel.BumperHeight)
		rightBumper:setFont(CoD.fonts[CoD.CategoryCarousel.BumperFontName])
		rightBumper:setAlpha(0)
		rightBumper:setText(CoD.buttonStrings.shoulderr)
		f1_local0:addElement(rightBumper)
		f1_local0.rightBumper = rightBumper
		
		f1_local0.gamepadInput = Engine.LastInput_Gamepad()
	end
	return f1_local0
end

CoD.CategoryCarousel.CarouselCategoryChanged = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.leftBumper
	local f2_local1 = f2_arg0.rightBumper
	if f2_local0 and f2_local1 then
		local f2_local2 = -f2_arg1.textLength / 2 - CoD.CategoryCarousel.BumperOffset
		f2_local0:beginAnimation("adjust_position")
		f2_local0:setLeftRight(false, false, f2_local2 - CoD.CategoryCarousel.BumperWidth, f2_local2)
		local f2_local3 = f2_arg1.textLength / 2 + CoD.CategoryCarousel.BumperOffset
		f2_local1:beginAnimation("adjust_position")
		f2_local1:setLeftRight(false, false, f2_local3, f2_local3 + CoD.CategoryCarousel.BumperWidth)
		if f2_arg0.gamepadInput then
			f2_local0:setAlpha(1)
			f2_local1:setAlpha(1)
		else
			f2_local0:setAlpha(0)
			f2_local1:setAlpha(0)
		end
	end
	if f2_arg0.m_mouseRange then
		local f2_local2 = f2_arg0:getCurrentItemIndex()
		if f2_arg0.m_mouseRange < f2_arg0:getNumItems() - f2_local2 then
			f2_arg0:addRightIndicator()
		elseif f2_arg0.rightIndicator then
			f2_arg0.rightIndicator:close()
		end
		if f2_arg0.m_mouseRange < f2_local2 - 1 then
			f2_arg0:addLeftIndicator()
		elseif f2_arg0.leftIndicator then
			f2_arg0.leftIndicator:close()
		end
	end
	f2_arg0:dispatchEventToParent(f2_arg1)
end

CoD.CategoryCarousel.InputSourceChanged = function (f3_arg0, f3_arg1)
	if f3_arg1.source == 0 then
		f3_arg0.leftBumper:setAlpha(1)
		f3_arg0.rightBumper:setAlpha(1)
		f3_arg0.gamepadInput = true
	else
		f3_arg0.leftBumper:setAlpha(0)
		f3_arg0.rightBumper:setAlpha(0)
		f3_arg0.gamepadInput = false
	end
end

CoD.CategoryCarousel.BumperControlsOverride = function (f4_arg0, f4_arg1)
	if LUI.UIElement.handleGamepadButton(f4_arg0, f4_arg1) == true then
		return 
	elseif f4_arg0.resetControls ~= nil then
		return 
	end
	f4_arg0.resetControls = true
	f4_arg0:addElement(LUI.UITimer.new(100, "reset_controls", true, f4_arg0))
	local f4_local0 = nil
	if f4_arg1.down == true then
		if f4_arg1.button == "shoulderr" then
			f4_local0 = 1
		elseif f4_arg1.button == "shoulderl" then
			f4_local0 = -1
		end
	end
	if f4_local0 ~= nil and f4_arg0.m_currentItem ~= nil and f4_arg0:scrollToItem(f4_arg0.m_currentItem + f4_local0, f4_arg0.m_scrollTime) then
		f4_arg0:dispatchEventToParent({
			name = "fade_out_carousel",
			duration = f4_arg0.m_scrollTime
		})
		if f4_arg0.leftBumper and f4_arg0.rightBumper then
			f4_arg0.leftBumper:beginAnimation("hide")
			f4_arg0.leftBumper:setAlpha(0)
			f4_arg0.rightBumper:beginAnimation("hide")
			f4_arg0.rightBumper:setAlpha(0)
		end
	end
end

CoD.CategoryCarousel.IndicatorScroll = function (f5_arg0, f5_arg1)
	f5_arg0:scrollToItem(f5_arg0.m_currentItem + f5_arg1.scrollDirection, f5_arg0.m_scrollTime)
end

CoD.CategoryCarousel.Indicator_MouseEnter = function (f6_arg0, f6_arg1)
	f6_arg0:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f6_arg0:setAlpha(1)
end

CoD.CategoryCarousel.Indicator_MouseLeave = function (f7_arg0, f7_arg1)
	f7_arg0:setRGB(1, 1, 1)
	f7_arg0:setAlpha(CoD.CategoryCarousel.IndicatorAlpha)
end

CoD.CategoryCarousel.Indicator_LeftMouseDown = function (f8_arg0, f8_arg1)
	local f8_local0 = 0
	if f8_arg0.id == "LeftIndicator" then
		f8_local0 = -1
	elseif f8_arg0.id == "RightIndicator" then
		f8_local0 = 1
	end
	f8_arg0:dispatchEventToParent({
		name = "indicator_scroll",
		scrollDirection = f8_local0
	})
end

CoD.CategoryCarousel.AddCategory = function (f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = CoD.CarouselCategoryListener.new(f9_arg1, f9_arg2)
	f9_arg0:addItem(f9_local0)
	return f9_local0
end

CoD.CategoryCarousel.AddLeftIndicator = function (f10_arg0)
	if f10_arg0.leftIndicator == nil then
		local f10_local0 = LUI.UIImage.new()
		f10_local0.id = "LeftIndicator"
		f10_local0:setLeftRight(true, false, 0, CoD.CategoryCarousel.IndicatorSize)
		f10_local0:setTopBottom(true, false, 0, CoD.CategoryCarousel.IndicatorSize)
		f10_local0:setImage(RegisterMaterial("ui_arrow_left"))
		f10_local0:setRGB(1, 1, 1)
		f10_local0:setAlpha(CoD.CategoryCarousel.IndicatorAlpha)
		f10_local0:setHandleMouse(true)
		f10_local0:registerEventHandler("mouseenter", CoD.CategoryCarousel.Indicator_MouseEnter)
		f10_local0:registerEventHandler("mouseleave", CoD.CategoryCarousel.Indicator_MouseLeave)
		f10_local0:registerEventHandler("leftmousedown", CoD.CategoryCarousel.Indicator_LeftMouseDown)
		f10_arg0.leftIndicator = f10_local0
	end
	f10_arg0:addElement(f10_arg0.leftIndicator)
end

CoD.CategoryCarousel.AddRightIndicator = function (f11_arg0)
	if f11_arg0.rightIndicator == nil then
		local f11_local0 = LUI.UIImage.new()
		f11_local0.id = "RightIndicator"
		f11_local0:setLeftRight(false, true, -CoD.CategoryCarousel.IndicatorSize, 0)
		f11_local0:setTopBottom(true, false, 0, CoD.CategoryCarousel.IndicatorSize)
		f11_local0:setImage(RegisterMaterial("ui_arrow_right"))
		f11_local0:setRGB(1, 1, 1)
		f11_local0:setAlpha(CoD.CategoryCarousel.IndicatorAlpha)
		f11_local0:setHandleMouse(true)
		f11_local0:registerEventHandler("mouseenter", CoD.CategoryCarousel.Indicator_MouseEnter)
		f11_local0:registerEventHandler("mouseleave", CoD.CategoryCarousel.Indicator_MouseLeave)
		f11_local0:registerEventHandler("leftmousedown", CoD.CategoryCarousel.Indicator_LeftMouseDown)
		f11_arg0.rightIndicator = f11_local0
	end
	f11_arg0:addElement(f11_arg0.rightIndicator)
end

