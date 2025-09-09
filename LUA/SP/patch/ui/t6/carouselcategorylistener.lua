CoD.CarouselCategoryListener = {}
CoD.CarouselCategoryListener.CategoryFontName = "Condensed"
CoD.CarouselCategoryListener.NewImageMaterial = "menu_mp_lobby_new"
CoD.CarouselCategoryListener.NewImageWidth = 40
CoD.CarouselCategoryListener.NewImageHeight = 20
CoD.CarouselCategoryListener.MouseHighlightAnimTime = 100
CoD.CarouselCategoryListener.new = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.fonts[CoD.CarouselCategoryListener.CategoryFontName]
	local f1_local1 = CoD.textSize[CoD.CarouselCategoryListener.CategoryFontName]
	local f1_local2 = f1_local1 + CoD.CarouselCategoryListener.NewImageHeight
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(false, false, -f1_local2 / 2, f1_local2 / 2)
	Widget.category = f1_arg0
	local f1_local4 = LUI.UIText.new()
	f1_local4:setLeftRight(true, true, 0, 0)
	f1_local4:setTopBottom(true, false, 0, f1_local1)
	f1_local4:setFont(f1_local0)
	f1_local4:setAlignment(LUI.Alignment.Center)
	f1_local4:setAlpha(CoD.DisabledAlpha)
	f1_local4:setText(f1_arg1)
	Widget.labelText = f1_local4
	Widget:addElement(f1_local4)
	local f1_local5, f1_local6, f1_local7, f1_local8 = GetTextDimensions(f1_arg1, f1_local0, f1_local1)
	Widget.textLength = f1_local7 - f1_local5
	Widget:registerEventHandler("carousel_scroll_complete", CoD.CarouselCategoryListener.CarouselScrollComplete)
	Widget:registerEventHandler("carousel_mouse_enter", CoD.CarouselCategoryListener.CarouselMouseEnter)
	Widget:registerEventHandler("carousel_mouse_leave", CoD.CarouselCategoryListener.CarouselMouseLeave)
	Widget:registerEventHandler("gain_focus", CoD.CarouselCategoryListener.GainFocus)
	Widget:registerEventHandler("lose_focus", CoD.CarouselCategoryListener.LoseFocus)
	Widget.addNewImage = CoD.CarouselCategoryListener.AddNewImage
	Widget.removeNewImage = CoD.CarouselCategoryListener.RemoveNewImage
	return Widget
end

CoD.CarouselCategoryListener.CarouselScrollComplete = function (f2_arg0, f2_arg1)
	f2_arg0:dispatchEventToParent({
		name = "carousel_category_changed",
		category = f2_arg0.category,
		textLength = f2_arg0.textLength
	})
end

CoD.CarouselCategoryListener.CarouselMouseEnter = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg0.labelText
	if not f3_arg0.m_inFocus then
		f3_local0:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
	end
end

CoD.CarouselCategoryListener.CarouselMouseLeave = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.labelText
	if not f4_arg0.m_inFocus then
		f4_local0:setRGB(CoD.ButtonTextColor.r, CoD.ButtonTextColor.g, CoD.ButtonTextColor.b)
	end
end

CoD.CarouselCategoryListener.GainFocus = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.labelText
	f5_local0:beginAnimation("gain_focus")
	f5_local0:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f5_local0:setAlpha(1)
	f5_arg0.m_inFocus = true
end

CoD.CarouselCategoryListener.LoseFocus = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0.labelText
	f6_local0:beginAnimation("lose_focus")
	f6_local0:setRGB(CoD.ButtonTextColor.r, CoD.ButtonTextColor.g, CoD.ButtonTextColor.b)
	f6_local0:setAlpha(CoD.DisabledAlpha)
	f6_arg0.m_inFocus = nil
end

CoD.CarouselCategoryListener.AddNewImage = function (f7_arg0)
	local f7_local0 = CoD.textSize[CoD.CarouselCategoryListener.CategoryFontName]
	local f7_local1 = LUI.UIImage.new()
	f7_local1:setLeftRight(false, false, -CoD.CarouselCategoryListener.NewImageWidth / 2, CoD.CarouselCategoryListener.NewImageWidth / 2)
	f7_local1:setTopBottom(true, false, f7_local0, f7_local0 + CoD.CarouselCategoryListener.NewImageHeight)
	f7_local1:setImage(RegisterMaterial(CoD.CarouselCategoryListener.NewImageMaterial))
	f7_arg0.newImage = f7_local1
	f7_arg0:addElement(f7_local1)
end

CoD.CarouselCategoryListener.RemoveNewImage = function (f8_arg0)
	if f8_arg0.newImage ~= nil then
		f8_arg0.newImage:close()
		f8_arg0.newImage = nil
	end
end

