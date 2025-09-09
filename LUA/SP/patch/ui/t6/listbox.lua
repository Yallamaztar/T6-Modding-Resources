require("T6.ListBoxButton")
CoD.ListBox = {}
CoD.ListBox.POSITION_TEXT_DEFAULT = "MENU_LISTBOX_POSITION_TEXT"
local f0_local0 = function (f1_arg0)
	if f1_arg0.m_pageStartIndex and f1_arg0.m_pageStartIndex < 1 then
		error("LUI Error: Listbox page start index (" .. f1_arg0.m_pageStartIndex .. ") underflow. Clamping to 1")
		f1_arg0.m_pageStartIndex = 1
	elseif f1_arg0.m_pageStartIndex and f1_arg0.m_totalItems > 0 and f1_arg0.m_totalItems < f1_arg0.m_pageStartIndex then
		error("LUI Error: Listbox page start index (" .. f1_arg0.m_pageStartIndex .. ") overflow. Clamping to " .. f1_arg0.m_totalItems)
		f1_arg0.m_pageStartIndex = f1_arg0.m_totalItems
	end
end

local f0_local1 = function (f2_arg0)
	if f2_arg0.m_pageArrowsOn == false or f2_arg0.m_totalItems == 0 then
		f2_arg0.m_positionText.upArrow:hide()
		f2_arg0.m_positionText.downArrow:hide()
		return 
	end
	f2_arg0.m_positionText.upArrow:show()
	f2_arg0.m_positionText.downArrow:show()
	if f2_arg0.m_pageStartIndex > 1 then
		f2_arg0.m_positionText.upArrow:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	else
		f2_arg0.m_positionText.upArrow:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	end
	if f2_arg0.m_pageStartIndex < math.max(1, f2_arg0.m_totalItems - f2_arg0.m_numButtons) then
		f2_arg0.m_positionText.downArrow:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	else
		f2_arg0.m_positionText.downArrow:setRGB(CoD.offGray.r, CoD.offGray.g, CoD.offGray.b)
	end
end

local f0_local2 = function (f3_arg0, f3_arg1)
	if f3_arg0.m_scrollBarContainer == nil then
		return 
	elseif f3_arg0.m_totalItems <= f3_arg0.m_numButtons and f3_arg0.m_scrollBarContainer then
		f3_arg0.m_scrollBarContainer:hide()
		return 
	end
	f3_arg0.m_scrollBarContainer:show()
	local Widget, f3_local1, f3_local2 = nil
	if f3_arg0.m_scrollBarContainer and f3_arg0.m_scrollBarContainer.scrollBar then
		Widget = f3_arg0.m_scrollBarContainer.scrollBar
		Widget:beginAnimation("scroll", 100)
	else
		Widget = LUI.UIElement.new()
		Widget.barBG = LUI.UIImage.new()
		Widget.barBgGrad = LUI.UIImage.new()
	end
	local f3_local3 = 2
	local f3_local4 = f3_arg0.m_totalHeight
	local f3_local5 = f3_arg0.m_totalItems
	local f3_local6 = f3_arg0.m_numButtons / f3_local5 * f3_local4 - f3_local3 * 2
	local f3_local7 = (f3_arg0.m_pageStartIndex - 1) / f3_local5 * f3_local4 + f3_local3
	Widget:setLeftRight(true, true, f3_local3, -f3_local3)
	Widget:setTopBottom(true, false, f3_local7, f3_local7 + f3_local6)
	f3_local1 = Widget.barBG
	f3_local1:setLeftRight(true, true, 0, 0)
	f3_local1:setTopBottom(true, true, 0, 0)
	f3_local1:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	Widget:addElement(f3_local1)
	f3_local2 = Widget.barBgGrad
	f3_local2:setLeftRight(true, true, 0, 0)
	f3_local2:setTopBottom(true, true, 0, 0)
	f3_local2:setImage(RegisterMaterial(CoD.MPZM("menu_mp_cac_grad_stretch", "menu_zm_cac_grad_stretch")))
	f3_local2:setAlpha(0.4)
	Widget:addElement(f3_local2)
	f3_arg0.m_scrollBarContainer.scrollBar = Widget
	f3_arg0.m_scrollBarContainer:addElement(Widget)
end

local f0_local3 = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.m_positionText.textField
	if f4_arg0.m_focussedButton == nil or f4_arg1 == nil or f4_arg0.m_totalItems == 0 then
		f4_local0:setText("")
	else
		local f4_local1 = ""
		if f4_arg0.m_positionTextString ~= nil then
			f4_local1 = Engine.Localize(f4_arg0.m_positionTextString, f4_arg1, f4_arg0.m_totalItems)
		end
		f4_local0:setText(f4_local1)
		local f4_local2, f4_local3, f4_local4, f4_local5 = GetTextDimensions(f4_local1 .. " ", f4_local0.font, f4_local0.fontHeight)
		f4_local0:setLeftRight(false, false, 0, math.abs(f4_local4))
		f0_local1(f4_arg0)
		f0_local2(f4_arg0, f4_arg1)
	end
end

local f0_local4 = function (f5_arg0, f5_arg1)
	local f5_local0, f5_local1, f5_local2, f5_local3 = f5_arg0:getRect()
	f5_arg0:dispatchEventToParent({
		name = "listbox_scrollbar_repositioned",
		scrollBarPos = (f5_arg1.y - f5_local1) / (f5_local3 - f5_local1)
	})
end

CoD.ListBox.AddScrollBar = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = 14
	local f6_local1 = f6_arg0.m_buttonLength + 15
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f6_local1, f6_local1 + f6_local0)
	Widget:setTopBottom(true, false, 0, f6_arg0.m_totalHeight)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.05))
	local f6_local3 = LUI.UIImage.new()
	f6_local3:setLeftRight(true, true, 1, -1)
	f6_local3:setTopBottom(true, true, 1, -1)
	f6_local3:setRGB(0, 0, 0)
	f6_local3:setAlpha(0.4)
	Widget:addElement(f6_local3)
	local f6_local4 = LUI.UIImage.new()
	f6_local4:setLeftRight(true, true, 2, -2)
	f6_local4:setTopBottom(true, true, 2, -2)
	f6_local4:setImage(RegisterMaterial(CoD.MPZM("menu_mp_cac_grad_stretch", "menu_zm_cac_grad_stretch")))
	f6_local4:setAlpha(0.1)
	Widget:addElement(f6_local4)
	if CoD.useMouse then
		Widget:setHandleMouse(true)
		Widget:registerEventHandler("leftmousedown", CoD.NullFunction)
		Widget:registerEventHandler("leftmouseup", f0_local4)
		Widget:registerEventHandler("mousedrag", f0_local4)
	end
	Widget.scrollBarHeight = f6_arg1
	Widget.scrollBarWidth = f6_arg2
	f6_arg0.m_scrollBarContainer = Widget
	f6_arg0:addElement(f6_arg0.m_scrollBarContainer)
end

local f0_local5 = function (f7_arg0, f7_arg1, f7_arg2)
	if f7_arg0.m_clickedButton == nil then
		f7_arg0.m_clickedButton = f7_arg1
	end
	if f7_arg0.m_focussedButton == f7_arg1 and not f7_arg2 then
		f0_local3(f7_arg0, f7_arg0.m_focussedButton.m_index)
		return 
	elseif CoD.useMouse and f7_arg0.m_currentMouseFocus and f7_arg0.m_currentMouseFocs ~= f7_arg1 then
		f7_arg0.m_currentMouseFocus:processEvent({
			name = "lose_focus",
			button = f7_arg0.m_focussedButton,
			controller = f7_arg0.m_controller
		})
	end
	if f7_arg0.m_focussedButton ~= nil then
		f7_arg0.m_focussedButton:processEvent({
			name = "lose_focus",
			button = f7_arg0.m_focussedButton,
			controller = f7_arg0.m_controller
		})
	end
	f7_arg0.m_focussedButton = f7_arg1
	f7_arg0.m_focussedButton:processEvent({
		name = "gain_focus",
		button = f7_arg0.m_focussedButton,
		controller = f7_arg0.m_controller
	})
	f0_local3(f7_arg0, f7_arg0.m_focussedButton.m_index)
	f7_arg0:dispatchEventToParent({
		name = "listbox_focus_changed",
		index = f7_arg0.m_focussedButton.m_index,
		controller = f7_arg0.m_controller
	})
end

local f0_local6 = function (f8_arg0)
	local f8_local0 = f8_arg0.m_firstButton
	while f8_local0 ~= nil do
		f8_local0:setVisible(false)
		f8_local0 = f8_local0.nextButton
	end
end

local f0_local7 = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	if f9_arg0.m_totalItems == 0 then
		f0_local6(f9_arg0)
		f0_local3(f9_arg0, nil)
		return 
	end
	f9_arg0.m_pageStartIndex = f9_arg1
	f0_local0(f9_arg0)
	local f9_local0 = f9_arg0.m_firstButton
	local f9_local1 = 0
	while f9_local0 ~= nil do
		f9_local0.m_index = f9_arg0.m_pageStartIndex + f9_local1
		if f9_local0.m_index <= f9_arg0.m_totalItems then
			f9_local0.dataCallback(f9_arg0.m_controller, f9_local0.m_index, f9_local0.body.m_mutables, f9_arg0)
			f9_local0:setVisible(true)
		else
			f9_local0:setVisible(false)
		end
		f9_local0 = f9_local0.nextButton
		f9_local1 = f9_local1 + 1
	end
	f0_local5(f9_arg0, f9_arg2, f9_arg3)
end

local f0_local8 = function (f10_arg0)
	local f10_local0 = f10_arg0.m_totalItems - f10_arg0.m_numButtons + 1
	local f10_local1 = 0
	if f10_local0 < 1 then
		f10_local1 = 1 - f10_local0
		f10_local0 = 1
	end
	local f10_local2 = f10_arg0.m_lastButton
	if f10_local1 > 0 and f10_local1 < f10_arg0.m_numButtons then
		for f10_local3 = 1, f10_local1, 1 do
			local f10_local6 = f10_local3
			f10_local2 = f10_local2.prevButton
		end
	end
	Engine.PlaySound(f10_arg0.focusSFX)
	f0_local7(f10_arg0, f10_local0, f10_local2)
end

CoD.ListBox.JumpToTop = function (f11_arg0)
	if f11_arg0 == nil or f11_arg0.m_totalItems == 0 or f11_arg0.m_errorState == true then
		return 
	else
		Engine.PlaySound(f11_arg0.focusSFX)
		f0_local7(f11_arg0, 1, f11_arg0.m_firstButton)
	end
end

local f0_local9 = function (f12_arg0)
	local f12_local0 = f12_arg0.m_firstButton.m_index - f12_arg0.m_numButtons
	local f12_local1 = 0
	if f12_local0 < 1 then
		f12_local1 = 1 - f12_local0
		f12_local0 = 1
	end
	local f12_local2 = f12_arg0.m_lastButton
	if f12_local1 > 0 and f12_local1 < f12_arg0.m_numButtons then
		for f12_local3 = 1, f12_local1, 1 do
			local f12_local6 = f12_local3
			f12_local2 = f12_local2.prevButton
		end
	end
	f0_local7(f12_arg0, f12_local0, f12_local2)
end

local f0_local10 = function (f13_arg0)
	f0_local7(f13_arg0, f13_arg0.m_lastButton.m_index + 1, f13_arg0.m_firstButton)
end

CoD.ListBox.PageUp = function (f14_arg0)
	if f14_arg0 == nil or f14_arg0.m_totalItems == 0 or f14_arg0.m_errorState == true then
		return 
	else
		Engine.PlaySound(f14_arg0.focusSFX)
		f14_arg0:generate(f14_arg0.m_focussedButton.m_index - f14_arg0.m_numButtons)
	end
end

local f0_local11 = CoD.ListBox
local f0_local12 = function (f15_arg0)
	if f15_arg0 == nil or f15_arg0.m_totalItems == 0 or f15_arg0.m_errorState == true then
		return 
	else
		Engine.PlaySound(f15_arg0.focusSFX)
		f15_arg0:generate(math.min(f15_arg0.m_focussedButton.m_index + f15_arg0.m_numButtons, f15_arg0.m_totalItems))
	end
end

f0_local11.PageDown = f0_local12
f0_local11 = function (f16_arg0, f16_arg1, f16_arg2)
	if f16_arg0.m_totalItems <= 1 or f16_arg0.disabled or f16_arg0.m_focussedButton == nil or f16_arg0.m_errorState == true then
		return true
	elseif f16_arg0.m_focussedButton.prevButton ~= nil then
		f16_arg0:generate(f16_arg0.m_focussedButton.m_index - 1)
	elseif f16_arg0.m_focussedButton == f16_arg0.m_firstButton then
		if f16_arg0.m_firstButton.m_index ~= 1 then
			f0_local9(f16_arg0)
		else
			f0_local8(f16_arg0)
		end
	end
	if f16_arg2 == nil and f16_arg0.m_focussedButton ~= nil and f16_arg0.m_focussedButton.body ~= nil and f16_arg0.m_focussedButton.body.clickable ~= nil and not f16_arg0.m_focussedButton.body.clickable then
		f0_local11(f16_arg0, f16_arg1, false)
	end
	Engine.PlaySound(f16_arg0.focusSFX)
	return true
end

f0_local12 = function (f17_arg0, f17_arg1, f17_arg2)
	if f17_arg0.m_totalItems <= 1 or f17_arg0.disabled or f17_arg0.m_focussedButton == nil or f17_arg0.m_errorState == true then
		return true
	elseif f17_arg0.m_totalItems <= f17_arg0.m_focussedButton.m_index then
		f17_arg0:jumpToTop()
		if f17_arg2 == nil and f17_arg0.m_focussedButton ~= nil and f17_arg0.m_focussedButton.body ~= nil and f17_arg0.m_focussedButton.body.clickable ~= nil and not f17_arg0.m_focussedButton.body.clickable then
			f0_local12(f17_arg0, f17_arg1, false)
		end
		return true
	elseif f17_arg0.m_focussedButton.nextButton ~= nil then
		f17_arg0:generate(f17_arg0.m_focussedButton.m_index + 1)
	elseif f17_arg0.m_focussedButton == f17_arg0.m_lastButton then
		f0_local10(f17_arg0)
	end
	if f17_arg2 == nil and f17_arg0.m_focussedButton ~= nil and f17_arg0.m_focussedButton.body ~= nil and f17_arg0.m_focussedButton.body.clickable ~= nil and not f17_arg0.m_focussedButton.body.clickable then
		f0_local12(f17_arg0, f17_arg1, false)
	end
	Engine.PlaySound(f17_arg0.focusSFX)
end

local f0_local13 = function (f18_arg0, f18_arg1)
	if f18_arg0.m_focussedButton ~= nil and f18_arg0.m_focussedButton.body ~= nil and f18_arg0.m_focussedButton.body.clickable ~= nil and not f18_arg0.m_focussedButton.body.clickable then
		return 
	elseif f18_arg0 ~= nil and f18_arg0.m_focussedButton ~= nil then
		f18_arg0.m_focussedButton:processEvent({
			name = "click",
			controller = f18_arg1.controller
		})
		if f18_arg0.m_clickedButton ~= f18_arg0.m_focussedButton then
			if f18_arg0.m_clickedButton ~= nil then
				f18_arg0.m_clickedButton:processEvent({
					name = "unclick"
				})
			end
			f18_arg0.m_clickedButton = f18_arg0.m_focussedButton
		end
	end
end

local f0_local14 = function (f19_arg0, f19_arg1)
	if f19_arg0 ~= nil and f19_arg0.m_focussedButton ~= nil then
		f19_arg0.m_focussedButton:processEvent({
			name = "unclick"
		})
	end
end

local f0_local15 = function (f20_arg0, f20_arg1)
	if f20_arg1.button.m_focusable then
		f0_local5(f20_arg0, f20_arg1.button)
		f20_arg0.m_currentMouseFocus = f20_arg1.button
		Engine.PlaySound(f20_arg0.focusSFX)
	end
end

local f0_local16 = function (f21_arg0, f21_arg1)
	f0_local5(f21_arg0, f21_arg1.button)
	f21_arg0.m_currentMouseFocus = f21_arg1.button
	f0_local13(f21_arg0, {
		name = "listbox_focussed_button_click",
		controller = f21_arg1.controller
	})
	f21_arg0:dispatchEventToParent({
		name = "listbox_clicked",
		controller = f21_arg1.controller
	})
end

local f0_local17 = function (f22_arg0, f22_arg1)
	f22_arg0:generate(LUI.clamp(math.floor(f22_arg0.m_totalItems * f22_arg1.scrollBarPos), 1, f22_arg0.m_totalItems))
end

local f0_local18 = function ()
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false
	})
	Widget.textField = LUI.UIText.new({
		left = 0,
		top = -(CoD.textSize.Default / 2),
		right = 0,
		bottom = CoD.textSize.Default / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false
	})
	Widget.textField:setAlignment(LUI.Alignment.Center)
	Widget.textField:setText(Engine.Localize("MENU_LISTBOX_LOADING"))
	Widget:addElement(Widget.textField)
	return Widget
end

local f0_local19 = function (f24_arg0)
	local f24_local0 = 0
	if f24_arg0.m_buttonPadding ~= nil then
		f24_local0 = f24_arg0.m_buttonPadding
	end
	local f24_local1 = f24_arg0.m_buttonHeight * f24_arg0.m_numButtons + f24_local0 * f24_arg0.m_numButtons + f24_arg0.m_numButtons
	local f24_local2 = LUI.UIHorizontalList.new()
	f24_local2:setLeftRight(true, true, 0, 0)
	f24_local2:setTopBottom(true, false, f24_local1, f24_local1 + CoD.CoD9Button.Height)
	f24_local2:setAlignment(LUI.Alignment.Center)
	f24_local2.textField = LUI.UIText.new({
		left = 0,
		top = -CoD.textSize.ExtraSmall / 2,
		right = 0,
		bottom = CoD.textSize.ExtraSmall / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.ExtraSmall,
		alignment = LUI.Alignment.Left
	})
	f24_local2.textField.font = CoD.fonts.ExtraSmall
	f24_local2.textField.fontHeight = -CoD.textSize.ExtraSmall / 2 - CoD.textSize.ExtraSmall / 2
	f24_local2:addElement(f24_local2.textField)
	local f24_local3 = 0
	local f24_local4 = 15
	local f24_local5 = 15
	local f24_local6 = 20
	
	local upArrow = LUI.UIImage.new()
	upArrow:setLeftRight(false, false, -f24_local6 / 2, f24_local6 / 2)
	upArrow:setTopBottom(false, false, -f24_local6 / 2, f24_local6 / 2)
	upArrow:setZRot(90)
	upArrow:setImage(RegisterMaterial("ui_arrow_right"))
	upArrow:hide()
	f24_local2:addElement(upArrow)
	f24_local2.upArrow = upArrow
	
	f24_local3 = f24_local3 + f24_local5
	
	local downArrow = LUI.UIImage.new()
	downArrow:setLeftRight(false, false, -f24_local6 / 2, f24_local6 / 2)
	downArrow:setTopBottom(false, false, -f24_local6 / 2, f24_local6 / 2)
	downArrow:setZRot(-90)
	downArrow:setImage(RegisterMaterial("ui_arrow_right"))
	downArrow:hide()
	f24_local2:addElement(downArrow)
	f24_local2.downArrow = downArrow
	
	return f24_local2
end

CoD.ListBox.Generate = function (f25_arg0, f25_arg1)
	if f25_arg0.m_totalItems == 0 then
		f0_local6(f25_arg0)
		if f25_arg0.noDataText == nil then
			f25_arg0.noDataText = Engine.Localize("MPUI_NO_DATA")
		end
		f25_arg0.m_messageElement.textField:setText(f25_arg0.noDataText)
		f25_arg0.m_messageElement.textField:setAlpha(1)
		f0_local3(f25_arg0, nil)
		f0_local1(f25_arg0)
		f0_local2(f25_arg0, index)
		return 
	end
	f25_arg0.m_messageElement.textField:setText("")
	if f25_arg0.m_focussedButton ~= nil then
		f25_arg0.m_focussedButton:processEvent({
			name = "lose_focus",
			button = f25_arg0.m_focussedButton
		})
		f25_arg0.m_focussedButton = nil
	end
	local f25_local0 = nil
	if f25_arg0.createButtonMutables ~= nil then
		for f25_local1 = 1, f25_arg0.m_numButtons, 1 do
			local f25_local4 = CoD.ListBoxButton.new({
				left = 0,
				top = 0,
				right = 0,
				bottom = CoD.CoD9Button.Height,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = false,
				bottomAnchor = false
			}, f25_arg0.m_highlightedZ)
			f25_local4.dataCallback = f25_arg0.getButtonData
			f25_local4.body.m_mutables = LUI.UIElement.new({
				left = 0,
				top = 0,
				right = 0,
				bottom = 0,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = true,
				bottomAnchor = true
			})
			f25_arg0.createButtonMutables(f25_arg0.m_controller, f25_local4.body.m_mutables, f25_local4)
			f25_local4.body:addElement(f25_local4.body.m_mutables)
			local f25_local5 = 0
			if f25_arg0.m_buttonPadding ~= nil then
				f25_local5 = f25_arg0.m_buttonPadding
			end
			local f25_local6 = 1 + (f25_local1 - 1) * f25_arg0.m_buttonHeight + (f25_local1 - 1) * f25_local5
			local Widget = LUI.UIElement.new({
				left = 0,
				top = f25_local6,
				right = f25_arg0.m_buttonLength,
				bottom = f25_local6 + f25_arg0.m_buttonHeight,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = false,
				bottomAnchor = false
			})
			Widget:addElement(f25_local4)
			f25_arg0:addElement(Widget)
			if f25_local0 ~= nil then
				f25_local0.nextButton = f25_local4
				f25_local4.prevButton = f25_local0
			end
			f25_local0 = f25_local4
			if f25_local1 == f25_arg0.m_numButtons then
				f25_arg0.m_lastButton = f25_local4
			end
			if f25_local1 == 1 then
				f25_arg0.m_firstButton = f25_local4
			end
		end
	end
	f25_arg0.createButtonMutables = nil
	local f25_local1 = f25_arg0.m_firstButton
	local f25_local2 = 1
	if f25_arg1 ~= nil and f25_arg0.m_totalItems > 0 then
		f25_local2 = f25_arg1 - f25_arg0.m_numButtons / 2
		if f25_local2 < 1 then
			f25_local2 = 1
		end
		f25_local2 = math.floor(f25_local2 + 0.5)
		if f25_arg0.m_totalItems - f25_arg0.m_numButtons / 2 <= f25_arg1 then
			f25_local2 = f25_arg0.m_totalItems - f25_arg0.m_numButtons + 1
		end
		if f25_local2 < 1 then
			f25_local2 = 1
		end
		local f25_local3 = f25_arg1 - f25_local2
		if f25_local3 > 0 and f25_local3 <= f25_arg0.m_numButtons then
			for f25_local8 = 1, f25_local3, 1 do
				local f25_local6 = f25_local8
				f25_local1 = f25_local1.nextButton
			end
		end
	end
	f0_local7(f25_arg0, f25_local2, f25_local1)
end

CoD.ListBox.SetTotalItems = function (f26_arg0, f26_arg1, f26_arg2)
	f26_arg0.m_totalItems = f26_arg1
	f26_arg0:generate(f26_arg2)
end

CoD.ListBox.GetTotalItems = function (f27_arg0)
	if f27_arg0 ~= nil then
		return f27_arg0.m_totalItems
	else
		return 0
	end
end

CoD.ListBox.GetFocussedIndex = function (f28_arg0)
	if f28_arg0 ~= nil and f28_arg0.m_focussedButton ~= nil then
		return f28_arg0.m_focussedButton.m_index
	else
		return nil
	end
end

CoD.ListBox.GetFocussedMutables = function (f29_arg0)
	if f29_arg0 ~= nil and f29_arg0.m_focussedButton ~= nil and f29_arg0.m_focussedButton.body ~= nil then
		return f29_arg0.m_focussedButton.body.m_mutables
	else
		return nil
	end
end

CoD.ListBox.GetFocusedButton = function (f30_arg0)
	if f30_arg0 ~= nil and f30_arg0.m_focussedButton ~= nil then
		return f30_arg0.m_focussedButton
	else
		return nil
	end
end

CoD.ListBox.Refresh = function (f31_arg0, f31_arg1)
	if f31_arg0 ~= nil then
		f0_local7(f31_arg0, f31_arg0.m_pageStartIndex, f31_arg0.m_focussedButton, f31_arg1)
	end
end

CoD.ListBox.ShowError = function (f32_arg0, f32_arg1)
	if f32_arg0 ~= nil then
		f32_arg0:showMessage(f32_arg1)
		f32_arg0.m_errorState = true
	end
end

CoD.ListBox.ClearError = function (f33_arg0)
	if f33_arg0 ~= nil then
		f33_arg0.m_messageElement.textField:setText("")
		f33_arg0.m_errorState = nil
	end
end

CoD.ListBox.ShowMessage = function (f34_arg0, f34_arg1)
	if f34_arg0 ~= nil then
		f0_local6(f34_arg0)
		f34_arg0.m_messageElement.textField:setText(f34_arg1)
	end
end

CoD.ListBox.HideMessage = function (f35_arg0, f35_arg1)
	if f35_arg0 ~= nil and f35_arg0.m_messageElement ~= nil then
		if f35_arg1 == true then
			f35_arg0.m_messageElement.textField:setAlpha(0)
		else
			f35_arg0.m_messageElement.textField:setAlpha(1)
		end
	end
end

CoD.ListBox.EnablePageArrows = function (f36_arg0)
	f36_arg0.m_pageArrowsOn = true
end

CoD.ListBox.new = function (f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4, f37_arg5, f37_arg6, f37_arg7, f37_arg8)
	local Widget = LUI.UIElement.new(f37_arg0)
	Widget.id = "ListBox"
	Widget.m_controller = f37_arg1
	Widget.m_numButtons = f37_arg2
	Widget.m_buttonHeight = f37_arg3
	Widget.m_buttonLength = f37_arg4
	Widget.m_totalHeight = Widget.m_numButtons * Widget.m_buttonHeight
	Widget.m_totalItems = 0
	Widget.m_pageStartIndex = 1
	local f37_local1
	if f37_arg7 ~= 0 then
		f37_local1 = f37_arg7
	else
		f37_local1 = 0
	end
	Widget.m_highlightedZ = f37_local1
	Widget.m_buttonPadding = f37_arg8
	Widget.m_messageElement = f0_local18()
	Widget.m_positionText = f0_local19(Widget)
	Widget.m_positionTextString = CoD.ListBox.POSITION_TEXT_DEFAULT
	Widget.m_errorState = false
	Widget.m_clickedButton = nil
	Widget.m_pageArrowsOn = false
	Widget.generate = CoD.ListBox.Generate
	Widget.setTotalItems = CoD.ListBox.SetTotalItems
	Widget.getTotalItems = CoD.ListBox.GetTotalItems
	Widget.createButtonMutables = f37_arg5
	Widget.getButtonData = f37_arg6
	Widget.getFocussedIndex = CoD.ListBox.GetFocussedIndex
	Widget.getFocussedMutables = CoD.ListBox.GetFocussedMutables
	Widget.getFocusedButton = CoD.ListBox.GetFocusedButton
	Widget.refresh = CoD.ListBox.Refresh
	Widget.showError = CoD.ListBox.ShowError
	Widget.clearError = CoD.ListBox.ClearError
	Widget.jumpToTop = CoD.ListBox.JumpToTop
	Widget.pageUp = CoD.ListBox.PageUp
	Widget.pageDown = CoD.ListBox.PageDown
	Widget.showMessage = CoD.ListBox.ShowMessage
	Widget.addScrollBar = CoD.ListBox.AddScrollBar
	Widget.enablePageArrows = CoD.ListBox.EnablePageArrows
	Widget:addElement(Widget.m_messageElement)
	Widget:addElement(Widget.m_positionText)
	Widget.buttonRepeaterUp = LUI.UIButtonRepeater.new("up", "listbox_move_up")
	Widget:addElement(Widget.buttonRepeaterUp)
	Widget.buttonRepeaterDown = LUI.UIButtonRepeater.new("down", "listbox_move_down")
	Widget:addElement(Widget.buttonRepeaterDown)
	Widget.buttonRepeaterClick = LUI.UIButtonRepeater.new("primary", "listbox_focussed_button_click")
	Widget.buttonRepeaterClick.delay = 500
	Widget.buttonRepeaterClick.MinDelay = 500
	Widget:addElement(Widget.buttonRepeaterClick)
	Widget.focusSFX = "cac_grid_nav"
	Widget.actionSFX = "cac_grid_equip_item"
	Widget:registerEventHandler("listbox_move_up", f0_local11)
	Widget:registerEventHandler("listbox_move_down", f0_local12)
	Widget:registerEventHandler("listbox_focussed_button_click", f0_local13)
	Widget:registerEventHandler("listbox_focussed_button_unclick", f0_local14)
	if CoD.isPC then
		Widget:setHandleMouseButton(true)
		Widget:registerEventHandler("listbox_button_mouseenter", f0_local15)
		Widget:registerEventHandler("listbox_button_clicked", f0_local16)
		Widget:registerEventHandler("listbox_scrollbar_repositioned", f0_local17)
	end
	return Widget
end

