require("T6.Menus.EmblemEditorColorsSwatch")
CoD.EmblemEditorColorsRGB = {}
CoD.EmblemEditorColorsRGB.RGBStep = 0
CoD.EmblemEditorColorsRGB.RGBBarTextWidth = 70
CoD.EmblemEditorColorsRGB.RGBBarTextX = 100
CoD.EmblemEditorColorsRGB.RGBColorBarWidth = 360
CoD.EmblemEditorColorsRGB.RGBColorBarHeight = 20
CoD.EmblemEditorColorsRGB.RGBColorBarX = CoD.EmblemEditorColorsRGB.RGBBarTextWidth
CoD.EmblemEditorColorsRGB.RGBColorValueX = 460
CoD.EmblemEditorColorsRGB.ConvertColorValues = function (f1_arg0)
	return math.floor(f1_arg0 * 255)
end

CoD.EmblemEditorColorsRGB.UpdateRGBWindow = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.color
	f2_arg1.previewColor:setRGB(f2_local0.red, f2_local0.green, f2_local0.blue)
	f2_arg1.previewColor:setAlpha(f2_local0.alpha)
	local f2_local1 = CoD.EmblemEditorColorsRGB.RGBColorBarX + f2_local0.red * CoD.EmblemEditorColorsRGB.RGBColorBarWidth
	local f2_local2 = CoD.EmblemEditorColorsRGB.RGBColorBarX + f2_local0.green * CoD.EmblemEditorColorsRGB.RGBColorBarWidth
	local f2_local3 = CoD.EmblemEditorColorsRGB.RGBColorBarX + f2_local0.blue * CoD.EmblemEditorColorsRGB.RGBColorBarWidth
	local f2_local4 = f2_arg1.colorBarList:getFirstChild()
	while f2_local4 do
		if f2_local4.id == "RedColorRow" then
			f2_local4.barElement.bar:setShaderVector(0, 0, f2_local0.green, f2_local0.blue, 1)
			f2_local4.barElement.bar:setShaderVector(1, 1, f2_local0.green, f2_local0.blue, 1)
			f2_local4.valuePointer:setLeftRight(true, false, f2_local1, f2_local1 + 1)
			f2_local4.valuePointerArrow:setLeftRight(true, false, f2_local1 - 6, f2_local1 + 7)
			f2_local4.colorComponentValueElement:setText(CoD.EmblemEditorColorsRGB.ConvertColorValues(f2_local0.red))
		elseif f2_local4.id == "GreenColorRow" then
			f2_local4.barElement.bar:setShaderVector(0, f2_local0.red, 0, f2_local0.blue, 1)
			f2_local4.barElement.bar:setShaderVector(1, f2_local0.red, 1, f2_local0.blue, 1)
			f2_local4.valuePointer:setLeftRight(true, false, f2_local2, f2_local2 + 1)
			f2_local4.valuePointerArrow:setLeftRight(true, false, f2_local2 - 6, f2_local2 + 7)
			f2_local4.colorComponentValueElement:setText(CoD.EmblemEditorColorsRGB.ConvertColorValues(f2_local0.green))
		elseif f2_local4.id == "BlueColorRow" then
			f2_local4.barElement.bar:setShaderVector(0, f2_local0.red, f2_local0.green, 0, 1)
			f2_local4.barElement.bar:setShaderVector(1, f2_local0.red, f2_local0.green, 1, 1)
			f2_local4.valuePointer:setLeftRight(true, false, f2_local3, f2_local3 + 1)
			f2_local4.valuePointerArrow:setLeftRight(true, false, f2_local3 - 6, f2_local3 + 7)
			f2_local4.colorComponentValueElement:setText(CoD.EmblemEditorColorsRGB.ConvertColorValues(f2_local0.blue))
		end
		f2_local4 = f2_local4:getNextSibling()
	end
end

CoD.EmblemEditorColorsRGB.LerpColor = function (f3_arg0, f3_arg1, f3_arg2)
	if f3_arg2 < f3_arg0 then
		f3_arg0 = f3_arg2
	elseif f3_arg0 < f3_arg1 then
		f3_arg0 = f3_arg1
	end
	return f3_arg0
end

CoD.EmblemEditorColorsRGB.SetColorComponent = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = f4_arg1.color
	CoD.EmblemEditorColorsRGB.LerpColor(f4_local0.red + f4_arg2, 0, 1)
	if f4_arg1.colorBarList.highlightedBarIndex == 0 then
		f4_arg1.color.red = CoD.EmblemEditorColorsRGB.LerpColor(f4_local0.red + f4_arg2, 0, 1)
	end
	if f4_arg1.colorBarList.highlightedBarIndex == 1 then
		f4_arg1.color.green = CoD.EmblemEditorColorsRGB.LerpColor(f4_local0.green + f4_arg2, 0, 1)
	end
	if f4_arg1.colorBarList.highlightedBarIndex == 2 then
		f4_arg1.color.blue = CoD.EmblemEditorColorsRGB.LerpColor(f4_local0.blue + f4_arg2, 0, 1)
	end
	Engine.ExecNow(f4_arg0, "emblemSetLayerColorRGB " .. f4_arg1.color.red .. " " .. f4_arg1.color.green .. " " .. f4_arg1.color.blue)
	CoD.EmblemEditorColorsRGB.UpdateRGBWindow(f4_arg0, f4_arg1)
end

CoD.EmblemEditorColorsRGB.HandleRGBGamepadButton = function (f5_arg0, f5_arg1)
	if LUI.UIElement.handleGamepadButton(f5_arg0, f5_arg1) == true then
		return true
	elseif f5_arg1.qualifier == "mwheel" then
		return true
	end
	local f5_local0 = 0
	if f5_arg1.down == true then
		if f5_arg1.button == "right" then
			f5_local0 = CoD.EmblemEditorColorsRGB.RGBStep
		elseif f5_arg1.button == "left" then
			f5_local0 = -CoD.EmblemEditorColorsRGB.RGBStep
		end
		Engine.PlaySound("cac_safearea")
	end
	CoD.EmblemEditorColorsRGB.SetColorComponent(f5_arg1.controller, f5_arg0, f5_local0)
end

CoD.EmblemEditorColorsRGB.SetupRGBWindowGamepadButton = function (f6_arg0)
	f6_arg0.leftRepeater = LUI.UIButtonRepeater.new("left", {
		name = "gamepad_button",
		button = "left",
		down = true,
		qualifier = "dpad"
	})
	f6_arg0.leftRepeater.delay = 100
	f6_arg0.leftRepeater.firstDelay = 200
	f6_arg0.rightRepeater = LUI.UIButtonRepeater.new("right", {
		name = "gamepad_button",
		button = "right",
		down = true,
		qualifier = "dpad"
	})
	f6_arg0.rightRepeater.delay = 100
	f6_arg0.rightRepeater.firstDelay = 200
	f6_arg0:addElement(f6_arg0.leftRepeater)
	f6_arg0:addElement(f6_arg0.rightRepeater)
	f6_arg0.handleGamepadButton = CoD.EmblemEditorColorsRGB.HandleRGBGamepadButton
end

CoD.EmblemEditorColorsRGB.AddRedBar = function (f7_arg0)
	local f7_local0 = LUI.UIButton.new({
		left = CoD.EmblemEditorColorsRGB.RGBBarTextX,
		right = CoD.EmblemEditorColorsRGB.RGBColorValueX + 50,
		top = 0,
		bottom = CoD.EmblemEditorColorsRGB.RGBColorBarHeight,
		leftAnchor = true,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = false
	})
	f7_arg0.colorBarList:addElement(f7_local0)
	f7_local0:registerEventHandler("gain_focus", CoD.EmblemEditorColorsRGB.RGBBarGainFocus)
	f7_local0:registerEventHandler("lose_focus", CoD.EmblemEditorColorsRGB.RGBBarLoseFocus)
	f7_local0.rowNum = 0
	f7_local0.id = "RedColorRow"
	f7_local0.parentList = f7_arg0.colorBarList
	local f7_local1 = f7_arg0.color
	local f7_local2 = LUI.UIText.new()
	f7_local2:setLeftRight(true, false, 0, CoD.EmblemEditorColorsRGB.RGBBarTextWidth)
	f7_local2:setTopBottom(true, true, 0, 0)
	f7_local2:setFont(CoD.fonts.ExtraSmall)
	f7_local2:setAlignment(LUI.Alignment.Left)
	f7_local2:setText(Engine.Localize("MENU_EMBLEM_RGB_RED"))
	f7_local0:addElement(f7_local2)
	
	local barElement = LUI.UIElement.new()
	barElement:setLeftRight(true, false, CoD.EmblemEditorColorsRGB.RGBColorBarX, CoD.EmblemEditorColorsRGB.RGBColorBarX + CoD.EmblemEditorColorsRGB.RGBColorBarWidth)
	barElement:setTopBottom(true, true, 0, 0)
	f7_local0:addElement(barElement)
	f7_local0.barElement = barElement
	
	local leftArrow = LUI.UIImage.new()
	leftArrow:setLeftRight(true, false, -17, -7)
	leftArrow:setTopBottom(false, false, -11, 11)
	leftArrow:setImage(RegisterMaterial("ui_scrollbar_arrow_left"))
	leftArrow:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	barElement:addElement(leftArrow)
	barElement.leftArrow = leftArrow
	
	barElement.leftArrow:hide()
	
	local rightArrow = LUI.UIImage.new()
	rightArrow:setLeftRight(false, true, 7, 17)
	rightArrow:setTopBottom(false, false, -11, 11)
	rightArrow:setImage(RegisterMaterial("ui_scrollbar_arrow_right"))
	rightArrow:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	barElement:addElement(rightArrow)
	barElement.rightArrow = rightArrow
	
	barElement.rightArrow:hide()
	
	local bar = LUI.UIImage.new()
	bar:setLeftRight(true, true, 0, 0)
	bar:setTopBottom(true, true, 0, 0)
	bar:setImage(RegisterMaterial("dual_color_gradient"))
	bar:setShaderVector(0, 0, f7_local1.green, f7_local1.blue, 1)
	bar:setShaderVector(1, 1, f7_local1.green, f7_local1.blue, 1)
	barElement:addElement(bar)
	barElement.bar = bar
	
	barElement.border = CoD.Border.new(2, 1, 1, 1, 0.1, -2)
	f7_local0.barElement:addElement(barElement.border)
	local f7_local7 = CoD.EmblemEditorColorsRGB.RGBColorBarX + f7_local1.red * CoD.EmblemEditorColorsRGB.RGBColorBarWidth
	
	local valuePointer = LUI.UIImage.new()
	valuePointer:setLeftRight(true, false, f7_local7, f7_local7 + 1)
	valuePointer:setTopBottom(true, true, 0, 0)
	valuePointer:setRGB(1, 1, 1)
	f7_local0:addElement(valuePointer)
	f7_local0.valuePointer = valuePointer
	
	local valuePointerArrow = LUI.UIImage.new()
	valuePointerArrow:setLeftRight(true, false, f7_local7 - 6, f7_local7 + 7)
	valuePointerArrow:setTopBottom(true, false, -6, 1)
	valuePointerArrow:setImage(RegisterMaterial("ui_scrollbar_arrow_dwn_a"))
	valuePointerArrow:setRGB(1, 1, 1)
	f7_local0:addElement(valuePointerArrow)
	f7_local0.valuePointerArrow = valuePointerArrow
	
	local f7_local10 = CoD.EmblemEditorColorsRGB.ConvertColorValues(f7_local1.red)
	
	local colorComponentValueElement = LUI.UIText.new()
	colorComponentValueElement:setLeftRight(true, false, CoD.EmblemEditorColorsRGB.RGBColorValueX, CoD.EmblemEditorColorsRGB.RGBColorValueX + 50)
	colorComponentValueElement:setTopBottom(true, true, 0, 0)
	colorComponentValueElement:setFont(CoD.fonts.ExtraSmall)
	colorComponentValueElement:setAlignment(LUI.Alignment.Left)
	colorComponentValueElement:setText(f7_local10)
	f7_local0:addElement(colorComponentValueElement)
	f7_local0.colorComponentValueElement = colorComponentValueElement
	
end

CoD.EmblemEditorColorsRGB.AddGreenBar = function (f8_arg0)
	local f8_local0 = LUI.UIButton.new({
		left = CoD.EmblemEditorColorsRGB.RGBBarTextX,
		right = CoD.EmblemEditorColorsRGB.RGBColorValueX + 50,
		top = 0,
		bottom = CoD.EmblemEditorColorsRGB.RGBColorBarHeight,
		leftAnchor = true,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = false
	})
	f8_arg0.colorBarList:addElement(f8_local0)
	f8_local0:registerEventHandler("gain_focus", CoD.EmblemEditorColorsRGB.RGBBarGainFocus)
	f8_local0:registerEventHandler("lose_focus", CoD.EmblemEditorColorsRGB.RGBBarLoseFocus)
	f8_local0.rowNum = 1
	f8_local0.id = "GreenColorRow"
	f8_local0.parentList = f8_arg0.colorBarList
	local f8_local1 = f8_arg0.color
	local f8_local2 = LUI.UIText.new()
	f8_local2:setLeftRight(true, false, 0, CoD.EmblemEditorColorsRGB.RGBBarTextWidth)
	f8_local2:setTopBottom(true, true, 0, 0)
	f8_local2:setFont(CoD.fonts.ExtraSmall)
	f8_local2:setAlignment(LUI.Alignment.Left)
	f8_local2:setText(Engine.Localize("MENU_EMBLEM_RGB_GREEN"))
	f8_local0:addElement(f8_local2)
	
	local barElement = LUI.UIElement.new()
	barElement:setLeftRight(true, false, CoD.EmblemEditorColorsRGB.RGBColorBarX, CoD.EmblemEditorColorsRGB.RGBColorBarX + CoD.EmblemEditorColorsRGB.RGBColorBarWidth)
	barElement:setTopBottom(true, true, 0, 0)
	f8_local0:addElement(barElement)
	f8_local0.barElement = barElement
	
	local leftArrow = LUI.UIImage.new()
	leftArrow:setLeftRight(true, false, -17, -7)
	leftArrow:setTopBottom(false, false, -11, 11)
	leftArrow:setImage(RegisterMaterial("ui_scrollbar_arrow_left"))
	leftArrow:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	barElement:addElement(leftArrow)
	barElement.leftArrow = leftArrow
	
	barElement.leftArrow:hide()
	
	local rightArrow = LUI.UIImage.new()
	rightArrow:setLeftRight(false, true, 7, 17)
	rightArrow:setTopBottom(false, false, -11, 11)
	rightArrow:setImage(RegisterMaterial("ui_scrollbar_arrow_right"))
	rightArrow:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	barElement:addElement(rightArrow)
	barElement.rightArrow = rightArrow
	
	barElement.rightArrow:hide()
	
	local bar = LUI.UIImage.new()
	bar:setLeftRight(true, true, 0, 0)
	bar:setTopBottom(true, true, 0, 0)
	bar:setImage(RegisterMaterial("dual_color_gradient"))
	bar:setShaderVector(0, f8_local1.red, 0, f8_local1.blue, 1)
	bar:setShaderVector(1, f8_local1.red, 1, f8_local1.blue, 1)
	barElement:addElement(bar)
	barElement.bar = bar
	
	barElement.border = CoD.Border.new(2, 1, 1, 1, 0.1, -2)
	f8_local0.barElement:addElement(barElement.border)
	local f8_local7 = CoD.EmblemEditorColorsRGB.RGBColorBarX + f8_local1.green * CoD.EmblemEditorColorsRGB.RGBColorBarWidth
	
	local valuePointer = LUI.UIImage.new()
	valuePointer:setLeftRight(true, false, f8_local7, f8_local7 + 1)
	valuePointer:setTopBottom(true, true, 0, 0)
	valuePointer:setRGB(1, 1, 1)
	f8_local0:addElement(valuePointer)
	f8_local0.valuePointer = valuePointer
	
	local valuePointerArrow = LUI.UIImage.new()
	valuePointerArrow:setLeftRight(true, false, f8_local7 - 6, f8_local7 + 7)
	valuePointerArrow:setTopBottom(true, false, -6, 1)
	valuePointerArrow:setImage(RegisterMaterial("ui_scrollbar_arrow_dwn_a"))
	valuePointerArrow:setRGB(1, 1, 1)
	f8_local0:addElement(valuePointerArrow)
	f8_local0.valuePointerArrow = valuePointerArrow
	
	local f8_local10 = CoD.EmblemEditorColorsRGB.ConvertColorValues(f8_local1.green)
	
	local colorComponentValueElement = LUI.UIText.new()
	colorComponentValueElement:setLeftRight(true, false, CoD.EmblemEditorColorsRGB.RGBColorValueX, CoD.EmblemEditorColorsRGB.RGBColorValueX + 50)
	colorComponentValueElement:setTopBottom(true, true, 0, 0)
	colorComponentValueElement:setFont(CoD.fonts.ExtraSmall)
	colorComponentValueElement:setAlignment(LUI.Alignment.Left)
	colorComponentValueElement:setText(f8_local10)
	f8_local0:addElement(colorComponentValueElement)
	f8_local0.colorComponentValueElement = colorComponentValueElement
	
end

CoD.EmblemEditorColorsRGB.AddBlueBar = function (f9_arg0)
	local f9_local0 = LUI.UIButton.new({
		left = CoD.EmblemEditorColorsRGB.RGBBarTextX,
		right = CoD.EmblemEditorColorsRGB.RGBColorValueX + 50,
		top = 0,
		bottom = CoD.EmblemEditorColorsRGB.RGBColorBarHeight,
		leftAnchor = true,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = false
	})
	f9_arg0.colorBarList:addElement(f9_local0)
	f9_local0:registerEventHandler("gain_focus", CoD.EmblemEditorColorsRGB.RGBBarGainFocus)
	f9_local0:registerEventHandler("lose_focus", CoD.EmblemEditorColorsRGB.RGBBarLoseFocus)
	f9_local0.rowNum = 2
	f9_local0.id = "BlueColorRow"
	f9_local0.parentList = f9_arg0.colorBarList
	local f9_local1 = f9_arg0.color
	local f9_local2 = LUI.UIText.new()
	f9_local2:setLeftRight(true, false, 0, CoD.EmblemEditorColorsRGB.RGBBarTextWidth)
	f9_local2:setTopBottom(true, true, 0, 0)
	f9_local2:setFont(CoD.fonts.ExtraSmall)
	f9_local2:setAlignment(LUI.Alignment.Left)
	f9_local2:setText(Engine.Localize("MENU_EMBLEM_RGB_BLUE"))
	f9_local0:addElement(f9_local2)
	
	local barElement = LUI.UIElement.new()
	barElement:setLeftRight(true, false, CoD.EmblemEditorColorsRGB.RGBColorBarX, CoD.EmblemEditorColorsRGB.RGBColorBarX + CoD.EmblemEditorColorsRGB.RGBColorBarWidth)
	barElement:setTopBottom(true, true, 0, 0)
	f9_local0:addElement(barElement)
	f9_local0.barElement = barElement
	
	local leftArrow = LUI.UIImage.new()
	leftArrow:setLeftRight(true, false, -17, -7)
	leftArrow:setTopBottom(false, false, -11, 11)
	leftArrow:setImage(RegisterMaterial("ui_scrollbar_arrow_left"))
	leftArrow:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	barElement:addElement(leftArrow)
	barElement.leftArrow = leftArrow
	
	barElement.leftArrow:hide()
	
	local rightArrow = LUI.UIImage.new()
	rightArrow:setLeftRight(false, true, 7, 17)
	rightArrow:setTopBottom(false, false, -11, 11)
	rightArrow:setImage(RegisterMaterial("ui_scrollbar_arrow_right"))
	rightArrow:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	barElement:addElement(rightArrow)
	barElement.rightArrow = rightArrow
	
	barElement.rightArrow:hide()
	
	local bar = LUI.UIImage.new()
	bar:setLeftRight(true, true, 0, 0)
	bar:setTopBottom(true, true, 0, 0)
	bar:setImage(RegisterMaterial("dual_color_gradient"))
	bar:setShaderVector(0, f9_local1.red, f9_local1.green, 0, 1)
	bar:setShaderVector(1, f9_local1.red, f9_local1.green, 1, 1)
	barElement:addElement(bar)
	barElement.bar = bar
	
	barElement.border = CoD.Border.new(2, 1, 1, 1, 0.1, -2)
	barElement:addElement(barElement.border)
	local f9_local7 = CoD.EmblemEditorColorsRGB.RGBColorBarX + f9_local1.blue * CoD.EmblemEditorColorsRGB.RGBColorBarWidth
	
	local valuePointer = LUI.UIImage.new()
	valuePointer:setLeftRight(true, false, f9_local7, f9_local7 + 1)
	valuePointer:setTopBottom(true, true, 0, 0)
	valuePointer:setRGB(1, 1, 1)
	f9_local0:addElement(valuePointer)
	f9_local0.valuePointer = valuePointer
	
	local valuePointerArrow = LUI.UIImage.new()
	valuePointerArrow:setLeftRight(true, false, f9_local7 - 6, f9_local7 + 7)
	valuePointerArrow:setTopBottom(true, false, -6, 1)
	valuePointerArrow:setImage(RegisterMaterial("ui_scrollbar_arrow_dwn_a"))
	valuePointerArrow:setRGB(1, 1, 1)
	valuePointerArrow:setAlpha(1)
	f9_local0:addElement(valuePointerArrow)
	f9_local0.valuePointerArrow = valuePointerArrow
	
	local f9_local10 = CoD.EmblemEditorColorsRGB.ConvertColorValues(f9_local1.blue)
	
	local colorComponentValueElement = LUI.UIText.new()
	colorComponentValueElement:setLeftRight(true, false, CoD.EmblemEditorColorsRGB.RGBColorValueX, CoD.EmblemEditorColorsRGB.RGBColorValueX + 50)
	colorComponentValueElement:setTopBottom(true, true, 0, 0)
	colorComponentValueElement:setFont(CoD.fonts.ExtraSmall)
	colorComponentValueElement:setAlignment(LUI.Alignment.Left)
	colorComponentValueElement:setText(f9_local10)
	f9_local0:addElement(colorComponentValueElement)
	f9_local0.colorComponentValueElement = colorComponentValueElement
	
end

CoD.EmblemEditorColorsRGB.RGBBarGainFocus = function (f10_arg0, f10_arg1)
	if f10_arg0.barElement.border then
		f10_arg0.barElement.border:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f10_arg0.barElement.border:setAlpha(1)
		f10_arg0.barElement.leftArrow:show()
		f10_arg0.barElement.rightArrow:show()
	end
	f10_arg0.parentList.highlightedBarIndex = f10_arg0.rowNum
	LUI.UIButton.gainFocus(f10_arg0, f10_arg1)
end

CoD.EmblemEditorColorsRGB.RGBBarLoseFocus = function (f11_arg0, f11_arg1)
	if f11_arg0.barElement.border then
		f11_arg0.barElement.border:setRGB(1, 1, 1)
		f11_arg0.barElement.border:setAlpha(0.1)
		f11_arg0.barElement.leftArrow:hide()
		f11_arg0.barElement.rightArrow:hide()
	end
	LUI.UIButton.loseFocus(f11_arg0, f11_arg1)
end

CoD.EmblemEditorColorsRGB.AddPreviewColor = function (f12_arg0)
	local f12_local0 = f12_arg0.color
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, 85)
	Widget:setTopBottom(true, true, 0, 0)
	f12_arg0:addElement(Widget)
	local f12_local2 = LUI.UIImage.new()
	f12_local2:setLeftRight(false, true, 0, 2)
	f12_local2:setTopBottom(true, true, 0, 0)
	f12_local2:setRGB(1, 1, 1)
	f12_local2:setAlpha(0.1)
	Widget:addElement(f12_local2)
	local f12_local3 = LUI.UIText.new()
	f12_local3:setLeftRight(true, true, 0, 0)
	f12_local3:setTopBottom(true, false, 20, 20 + CoD.textSize.ExtraSmall)
	f12_local3:setAlignment(LUI.Alignment.Center)
	f12_local3:setText(Engine.Localize("MENU_EMBLEM_COLOR"))
	f12_local3:setFont(CoD.fonts.ExtraSmall)
	Widget:addElement(f12_local3)
	
	local previewColor = LUI.UIImage.new()
	previewColor:setLeftRight(false, false, -20, 20)
	previewColor:setTopBottom(true, false, 50, 120)
	previewColor:setRGB(f12_local0.red, f12_local0.green, f12_local0.blue)
	previewColor:setAlpha(1)
	Widget:addElement(previewColor)
	f12_arg0.previewColor = previewColor
	
end

CoD.EmblemEditorColorsRGB.PrepareRGBWindow = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.1))
	HudRef.RGBWindow = Widget
	Widget.color = Engine.GetSelectedLayerColor(InstanceRef)
	Widget.color.alpha = 1
	CoD.EmblemEditorColorsRGB.AddPreviewColor(Widget)
	CoD.EmblemEditorColorsRGB.SetupRGBWindowGamepadButton(Widget)
	Widget.colorBarList = LUI.UIVerticalList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 25,
		bottom = 0,
		spacing = 20
	})
	Widget:addElement(Widget.colorBarList)
	CoD.EmblemEditorColorsRGB.AddRedBar(Widget)
	CoD.EmblemEditorColorsRGB.AddGreenBar(Widget)
	CoD.EmblemEditorColorsRGB.AddBlueBar(Widget)
	if CoD.useMouse then
		CoD.EmblemEditorColorsRGB.SetupMouseHandlers(Widget)
		Widget:registerEventHandler("colorbar_clicked", CoD.EmblemEditorColorsRGB.ColorBarClicked)
	end
	Widget.colorBarList:processEvent({
		name = "gain_focus"
	})
	Widget.colorBarList.highlightedBarIndex = 0
	CoD.EmblemEditorColorsRGB.AddButtonPrompts(HudRef.emblemEditor)
	return Widget
end

CoD.EmblemEditorColorsRGB.SwitchToColorSwatches = function (f14_arg0, f14_arg1)
	f14_arg0.colorWindow.colormixer:close()
	Engine.ExecNow(f14_arg1.controller, "emblemSetRGBTweakedColor")
	if f14_arg0.colorWindow.swatch then
		f14_arg0.colorWindow.swatch:close()
	end
	f14_arg0.colorWindow.swatch = CoD.EmblemEditorColorsSwatch.PrepareColorSwatches(f14_arg0.colorWindow, f14_arg1.controller)
	f14_arg0.colorWindow:addElement(f14_arg0.colorWindow.swatch)
end

CoD.EmblemEditorColorsRGB.CreateButtonPrompts = function (f15_arg0)
	f15_arg0.chooseRGBColor = CoD.ButtonPrompt.new("emblem_move", Engine.Localize("MENU_EMBLEM_CHANGE_COLOR"))
	local f15_local0 = CoD.ButtonPrompt.new
	local f15_local1 = "start"
	local f15_local2 = Engine.Localize("MENU_EMBLEM_TOGGLE_TO_COLOR_PICKER")
	local f15_local3 = f15_arg0
	local f15_local4 = "button_prompt_colorswatches"
	local f15_local5, f15_local6 = false
	local f15_local7, f15_local8 = false
	f15_arg0.colorswatches = f15_local0(f15_local1, f15_local2, f15_local3, f15_local4, f15_local5, f15_local6, f15_local7, f15_local8, "E")
	f15_arg0:registerEventHandler("button_prompt_colorswatches", CoD.EmblemEditorColorsRGB.SwitchToColorSwatches)
end

CoD.EmblemEditorColorsRGB.AddButtonPrompts = function (f16_arg0)
	f16_arg0.buttonPromptList:removeAllChildren()
	if Engine.LastInput_Gamepad() then
		f16_arg0:addButtonPrompt(f16_arg0.chooseRGBColor)
		CoD.EmblemEditor.AddOpacityButtonPrompts(f16_arg0)
	end
	f16_arg0:addButtonPrompt(f16_arg0.colorswatches)
	if CoD.isPC then
		CoD.EmblemEditor.RefreshPromptInputSource(f16_arg0)
	end
end

CoD.EmblemEditorColorsRGB.ColorBarClicked = function (f17_arg0, f17_arg1)
	local f17_local0 = f17_arg0.color
	if f17_arg0.colorBarList.highlightedBarIndex == 0 then
		f17_arg0.color.red = CoD.EmblemEditorColorsRGB.LerpColor(f17_arg1.colorValue, 0, 1)
	end
	if f17_arg0.colorBarList.highlightedBarIndex == 1 then
		f17_arg0.color.green = CoD.EmblemEditorColorsRGB.LerpColor(f17_arg1.colorValue, 0, 1)
	end
	if f17_arg0.colorBarList.highlightedBarIndex == 2 then
		f17_arg0.color.blue = CoD.EmblemEditorColorsRGB.LerpColor(f17_arg1.colorValue, 0, 1)
	end
	Engine.ExecNow(controller, "emblemSetLayerColorRGB " .. f17_arg0.color.red .. " " .. f17_arg0.color.green .. " " .. f17_arg0.color.blue .. " " .. f17_arg0.color.alpha)
	CoD.EmblemEditorColorsRGB.UpdateRGBWindow(controller, f17_arg0)
end

CoD.EmblemEditorColorsRGB.SetupMouseHandlers = function (f18_arg0)
	local f18_local0 = f18_arg0.colorBarList:getFirstChild()
	while f18_local0 do
		if f18_local0.id == "RedColorRow" then
			f18_local0.barElement:setHandleMouse(true)
			f18_local0.barElement:registerEventHandler("leftmousedown", CoD.NullFunction)
			f18_local0.barElement:registerEventHandler("leftmouseup", CoD.EmblemEditorColorsRGB.Bar_MouseUpdate)
			f18_local0.barElement:registerEventHandler("mousedrag", CoD.EmblemEditorColorsRGB.Bar_MouseUpdate)
		elseif f18_local0.id == "GreenColorRow" then
			f18_local0.barElement:setHandleMouse(true)
			f18_local0.barElement:registerEventHandler("leftmousedown", CoD.NullFunction)
			f18_local0.barElement:registerEventHandler("leftmouseup", CoD.EmblemEditorColorsRGB.Bar_MouseUpdate)
			f18_local0.barElement:registerEventHandler("mousedrag", CoD.EmblemEditorColorsRGB.Bar_MouseUpdate)
		elseif f18_local0.id == "BlueColorRow" then
			f18_local0.barElement:setHandleMouse(true)
			f18_local0.barElement:registerEventHandler("leftmousedown", CoD.NullFunction)
			f18_local0.barElement:registerEventHandler("leftmouseup", CoD.EmblemEditorColorsRGB.Bar_MouseUpdate)
			f18_local0.barElement:registerEventHandler("mousedrag", CoD.EmblemEditorColorsRGB.Bar_MouseUpdate)
		end
		f18_local0 = f18_local0:getNextSibling()
	end
end

CoD.EmblemEditorColorsRGB.Bar_MouseUpdate = function (f19_arg0, f19_arg1)
	local f19_local0, f19_local1, f19_local2, f19_local3 = f19_arg0:getRect()
	f19_arg0:dispatchEventToParent({
		name = "colorbar_clicked",
		controller = f19_arg1.controller,
		colorValue = (f19_arg1.x - f19_local0) / (f19_local2 - f19_local0)
	})
end

