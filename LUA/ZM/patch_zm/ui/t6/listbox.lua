require("T6.ListBoxButton")
CoD.ListBox = {}
CoD.ListBox.POSITION_TEXT_DEFAULT = "MENU_LISTBOX_POSITION_TEXT"
local f0_local0 = function (self)
	if self.m_pageStartIndex and self.m_pageStartIndex < 1 then
		error("LUI Error: Listbox page start index (" .. self.m_pageStartIndex .. ") underflow. Clamping to 1")
		self.m_pageStartIndex = 1
	elseif self.m_pageStartIndex and self.m_totalItems > 0 and self.m_totalItems < self.m_pageStartIndex then
		error("LUI Error: Listbox page start index (" .. self.m_pageStartIndex .. ") overflow. Clamping to " .. self.m_totalItems)
		self.m_pageStartIndex = self.m_totalItems
	end
end

local f0_local1 = function (self)
	if self.m_pageArrowsOn == false or self.m_totalItems == 0 then
		self.m_positionText.upArrow:hide()
		self.m_positionText.downArrow:hide()
		return 
	end
	self.m_positionText.upArrow:show()
	self.m_positionText.downArrow:show()
	if self.m_pageStartIndex > 1 then
		self.m_positionText.upArrow:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	else
		self.m_positionText.upArrow:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	end
	if self.m_pageStartIndex < math.max(1, self.m_totalItems - self.m_numButtons) then
		self.m_positionText.downArrow:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
	else
		self.m_positionText.downArrow:setRGB(CoD.offGray.r, CoD.offGray.g, CoD.offGray.b)
	end
end

local f0_local2 = function (self, f3_arg1)
	if self.m_scrollBarContainer == nil then
		return 
	elseif self.m_totalItems <= self.m_numButtons and self.m_scrollBarContainer then
		self.m_scrollBarContainer:hide()
		return 
	end
	self.m_scrollBarContainer:show()
	local Widget, f3_local1, f3_local2 = nil, nil, nil
	if self.m_scrollBarContainer and self.m_scrollBarContainer.scrollBar then
		Widget = self.m_scrollBarContainer.scrollBar
		Widget:beginAnimation("scroll", 100)
	else
		Widget = LUI.UIElement.new()
		Widget.barBG = LUI.UIImage.new()
		Widget.barBgGrad = LUI.UIImage.new()
	end
	local f3_local3 = 2
	local f3_local4 = self.m_totalHeight
	local f3_local5 = self.m_totalItems
	local f3_local6 = self.m_numButtons / f3_local5 * f3_local4 - f3_local3 * 2
	local f3_local7 = (self.m_pageStartIndex - 1) / f3_local5 * f3_local4 + f3_local3
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
	self.m_scrollBarContainer.scrollBar = Widget
	self.m_scrollBarContainer:addElement(Widget)
end

local f0_local3 = function (self, f4_arg1)
	local f4_local0 = self.m_positionText.textField
	if self.m_focussedButton == nil or f4_arg1 == nil or self.m_totalItems == 0 then
		f4_local0:setText("")
	else
		local f4_local1 = ""
		if self.m_positionTextString ~= nil then
			f4_local1 = Engine.Localize(self.m_positionTextString, f4_arg1, self.m_totalItems)
		end
		f4_local0:setText(f4_local1)
		local f4_local2, f4_local3, f4_local4, f4_local5 = GetTextDimensions(f4_local1 .. " ", f4_local0.font, f4_local0.fontHeight)
		f4_local0:setLeftRight(false, false, 0, math.abs(f4_local4))
		f0_local1(self)
		f0_local2(self, f4_arg1)
	end
end

local f0_local4 = function (self, f5_arg1)
	local f5_local0, f5_local1, f5_local2, f5_local3 = self:getRect()
	self:dispatchEventToParent({
		name = "listbox_scrollbar_repositioned",
		scrollBarPos = (f5_arg1.y - f5_local1) / (f5_local3 - f5_local1)
	})
end

CoD.ListBox.AddScrollBar = function (self, iHeight, iWidth)
	local f6_local0 = 14
	local f6_local1 = self.m_buttonLength + 15
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f6_local1, f6_local1 + f6_local0)
	Widget:setTopBottom(true, false, 0, self.m_totalHeight)
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
	Widget.scrollBarHeight = iHeight
	Widget.scrollBarWidth = iWidth
	self.m_scrollBarContainer = Widget
	self:addElement(self.m_scrollBarContainer)
end

local f0_local5 = function (self, Button, f7_arg2)
	if self.m_clickedButton == nil then
		self.m_clickedButton = Button
	end
	if self.m_focussedButton == Button and not f7_arg2 then
		f0_local3(self, self.m_focussedButton.m_index)
		return 
	elseif CoD.useMouse and self.m_currentMouseFocus and self.m_currentMouseFocs ~= Button then
		self.m_currentMouseFocus:processEvent({
			name = "lose_focus",
			button = self.m_focussedButton,
			controller = self.m_controller
		})
	end
	if self.m_focussedButton ~= nil then
		self.m_focussedButton:processEvent({
			name = "lose_focus",
			button = self.m_focussedButton,
			controller = self.m_controller
		})
	end
	self.m_focussedButton = Button
	self.m_focussedButton:processEvent({
		name = "gain_focus",
		button = self.m_focussedButton,
		controller = self.m_controller
	})
	f0_local3(self, self.m_focussedButton.m_index)
	self:dispatchEventToParent({
		name = "listbox_focus_changed",
		index = self.m_focussedButton.m_index,
		controller = self.m_controller
	})
end

local f0_local6 = function (self)
	local f8_local0 = self.m_firstButton
	while f8_local0 ~= nil do
		f8_local0:setVisible(false)
		f8_local0 = f8_local0.nextButton
	end
end

local f0_local7 = function (self, iPageStartIndex, Button, f9_arg3)
	if self.m_totalItems == 0 then
		f0_local6(self)
		f0_local3(self, nil)
		return 
	end
	self.m_pageStartIndex = iPageStartIndex
	f0_local0(self)
	local FirstButton = self.m_firstButton
	local NextIndex = 0
	while FirstButton ~= nil do
		FirstButton.m_index = self.m_pageStartIndex + NextIndex
		if FirstButton.m_index <= self.m_totalItems then
			FirstButton.dataCallback(self.m_controller, FirstButton.m_index, FirstButton.body.m_mutables, self)
			FirstButton:setVisible(true)
		else
			FirstButton:setVisible(false)
		end
		FirstButton = FirstButton.nextButton
		NextIndex = NextIndex + 1
	end
	f0_local5(self, Button, f9_arg3)
end

local f0_local8 = function (self)
	local iPageIndex = self.m_totalItems - self.m_numButtons + 1
	local f10_local1 = 0
	if iPageIndex < 1 then
		f10_local1 = 1 - iPageIndex
		iPageIndex = 1
	end
	local Button = self.m_lastButton
	if f10_local1 > 0 and f10_local1 < self.m_numButtons then
		for f10_local3 = 1, f10_local1, 1 do
			local f10_local6 = f10_local3
			Button = Button.prevButton
		end
	end
	Engine.PlaySound(self.focusSFX)
	f0_local7(self, iPageIndex, Button)
end

CoD.ListBox.JumpToTop = function (self)
	if self == nil or self.m_totalItems == 0 or self.m_errorState == true then
		return 
	else
		Engine.PlaySound(self.focusSFX)
		f0_local7(self, 1, self.m_firstButton)
	end
end

local f0_local9 = function (self)
	local f12_local0 = self.m_firstButton.m_index - self.m_numButtons
	local f12_local1 = 0
	if f12_local0 < 1 then
		f12_local1 = 1 - f12_local0
		f12_local0 = 1
	end
	local f12_local2 = self.m_lastButton
	if f12_local1 > 0 and f12_local1 < self.m_numButtons then
		for f12_local3 = 1, f12_local1, 1 do
			local f12_local6 = f12_local3
			f12_local2 = f12_local2.prevButton
		end
	end
	f0_local7(self, f12_local0, f12_local2)
end

local f0_local10 = function (self)
	f0_local7(self, self.m_lastButton.m_index + 1, self.m_firstButton)
end

CoD.ListBox.PageUp = function (self)
	if self == nil or self.m_totalItems == 0 or self.m_errorState == true then
		return 
	else
		Engine.PlaySound(self.focusSFX)
		self:generate(self.m_focussedButton.m_index - self.m_numButtons)
	end
end

CoD.ListBox.PageDown = function (self)
	if self == nil or self.m_totalItems == 0 or self.m_errorState == true then
		return 
	else
		Engine.PlaySound(self.focusSFX)
		self:generate(math.min(self.m_focussedButton.m_index + self.m_numButtons, self.m_totalItems))
	end
end

local ListboxMoveUpFunc = function (self, f16_arg1, f16_arg2)
	if self.m_totalItems <= 1 or self.disabled or self.m_focussedButton == nil or self.m_errorState == true then
		return true
	elseif self.m_focussedButton.prevButton ~= nil then
		self:generate(self.m_focussedButton.m_index - 1)
	elseif self.m_focussedButton == self.m_firstButton then
		if self.m_firstButton.m_index ~= 1 then
			f0_local9(self)
		else
			f0_local8(self)
		end
	end
	if f16_arg2 == nil and self.m_focussedButton ~= nil and self.m_focussedButton.body ~= nil and self.m_focussedButton.body.clickable ~= nil and not self.m_focussedButton.body.clickable then
		ListboxMoveUpFunc(self, f16_arg1, false)
	end
	Engine.PlaySound(self.focusSFX)
	return true
end

local ListboxMoveDownFunc = function (self, f17_arg1, f17_arg2)
	if self.m_totalItems <= 1 or self.disabled or self.m_focussedButton == nil or self.m_errorState == true then
		return true
	elseif self.m_totalItems <= self.m_focussedButton.m_index then
		self:jumpToTop()
		if f17_arg2 == nil and self.m_focussedButton ~= nil and self.m_focussedButton.body ~= nil and self.m_focussedButton.body.clickable ~= nil and not self.m_focussedButton.body.clickable then
			ListboxMoveDownFunc(self, f17_arg1, false)
		end
		return true
	elseif self.m_focussedButton.nextButton ~= nil then
		self:generate(self.m_focussedButton.m_index + 1)
	elseif self.m_focussedButton == self.m_lastButton then
		f0_local10(self)
	end
	if f17_arg2 == nil and self.m_focussedButton ~= nil and self.m_focussedButton.body ~= nil and self.m_focussedButton.body.clickable ~= nil and not self.m_focussedButton.body.clickable then
		ListboxMoveDownFunc(self, f17_arg1, false)
	end
	Engine.PlaySound(self.focusSFX)
end

local ListboxFocussedButtonClickFunc = function (self, ClientInstance)
	if self.m_focussedButton ~= nil and self.m_focussedButton.body ~= nil and self.m_focussedButton.body.clickable ~= nil and not self.m_focussedButton.body.clickable then
		return 
	elseif self ~= nil and self.m_focussedButton ~= nil then
		self.m_focussedButton:processEvent({
			name = "click",
			controller = ClientInstance.controller
		})
		if self.m_clickedButton ~= self.m_focussedButton then
			if self.m_clickedButton ~= nil then
				self.m_clickedButton:processEvent({
					name = "unclick"
				})
			end
			self.m_clickedButton = self.m_focussedButton
		end
	end
end

local ListboxFocussedButtonUnclickFunc = function (self, ClientInstance)
	if self ~= nil and self.m_focussedButton ~= nil then
		self.m_focussedButton:processEvent({
			name = "unclick"
		})
	end
end

local ListboxButtonMouseEnterFunc = function (self, ClientInstance)
	if ClientInstance.button.m_focusable then
		f0_local5(self, ClientInstance.button)
		self.m_currentMouseFocus = ClientInstance.button
		Engine.PlaySound(self.focusSFX)
	end
end

local ListboxButtonClickedFunc = function (self, ClientInstance)
	f0_local5(self, ClientInstance.button)
	self.m_currentMouseFocus = ClientInstance.button
	ListboxFocussedButtonClickFunc(self, {
		name = "listbox_focussed_button_click",
		controller = ClientInstance.controller
	})
	self:dispatchEventToParent({
		name = "listbox_clicked",
		controller = ClientInstance.controller
	})
end

local ListboxScrollBarRepositionedFunc = function (self, ClientInstance)
	self:generate(LUI.clamp(math.floor(self.m_totalItems * ClientInstance.scrollBarPos), 1, self.m_totalItems))
end

local CreateMessageElement = function ()
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

local CreatePositionText = function (self)
	local ButtonPadding = 0
	if self.m_buttonPadding ~= nil then
		ButtonPadding = self.m_buttonPadding
	end
	local VerticalOffset = self.m_buttonHeight * self.m_numButtons + ButtonPadding * self.m_numButtons + self.m_numButtons
	local UiList = LUI.UIHorizontalList.new()
	UiList:setLeftRight(true, true, 0, 0)
	UiList:setTopBottom(true, false, VerticalOffset, VerticalOffset + CoD.CoD9Button.Height)
	UiList:setAlignment(LUI.Alignment.Center)
	UiList.textField = LUI.UIText.new({
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
	UiList.textField.font = CoD.fonts.ExtraSmall
	UiList.textField.fontHeight = -CoD.textSize.ExtraSmall / 2 - CoD.textSize.ExtraSmall / 2
	UiList:addElement(UiList.textField)
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
	UiList:addElement(upArrow)
	UiList.upArrow = upArrow
	
	f24_local3 = f24_local3 + f24_local5
	
	local downArrow = LUI.UIImage.new()
	downArrow:setLeftRight(false, false, -f24_local6 / 2, f24_local6 / 2)
	downArrow:setTopBottom(false, false, -f24_local6 / 2, f24_local6 / 2)
	downArrow:setZRot(-90)
	downArrow:setImage(RegisterMaterial("ui_arrow_right"))
	downArrow:hide()
	UiList:addElement(downArrow)
	UiList.downArrow = downArrow
	
	return UiList
end

CoD.ListBox.Generate = function (self, iPageStartIndex_arg)
	if self.m_totalItems == 0 then
		f0_local6(self)
		if self.noDataText == nil then
			self.noDataText = Engine.Localize("MPUI_NO_DATA")
		end
		self.m_messageElement.textField:setText(self.noDataText)
		self.m_messageElement.textField:setAlpha(1)
		f0_local3(self, nil)
		f0_local1(self)
		f0_local2(self, index)
		return 
	end
	self.m_messageElement.textField:setText("")
	if self.m_focussedButton ~= nil then
		self.m_focussedButton:processEvent({
			name = "lose_focus",
			button = self.m_focussedButton
		})
		self.m_focussedButton = nil
	end
	local PrevButton = nil
	if self.createButtonMutables ~= nil then
		for FirstButton = 1, self.m_numButtons, 1 do
			local Button = CoD.ListBoxButton.new({
				left = 0,
				top = 0,
				right = 0,
				bottom = CoD.CoD9Button.Height,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = false,
				bottomAnchor = false
			}, self.m_highlightedZ)
			Button.dataCallback = self.getButtonData
			Button.body.m_mutables = LUI.UIElement.new({
				left = 0,
				top = 0,
				right = 0,
				bottom = 0,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = true,
				bottomAnchor = true
			})
			self.createButtonMutables(self.m_controller, Button.body.m_mutables, Button)
			Button.body:addElement(Button.body.m_mutables)
			local ButtonPadding = 0
			if self.m_buttonPadding ~= nil then
				ButtonPadding = self.m_buttonPadding
			end
			local VerticalOffset = 1 + (FirstButton - 1) * self.m_buttonHeight + (FirstButton - 1) * ButtonPadding
			local Widget = LUI.UIElement.new({
				left = 0,
				top = VerticalOffset,
				right = self.m_buttonLength,
				bottom = VerticalOffset + self.m_buttonHeight,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = false,
				bottomAnchor = false
			})
			Widget:addElement(Button)
			self:addElement(Widget)
			if PrevButton ~= nil then
				PrevButton.nextButton = Button
				Button.prevButton = PrevButton
			end
			PrevButton = Button
			if FirstButton == self.m_numButtons then
				self.m_lastButton = Button
			end
			if FirstButton == 1 then
				self.m_firstButton = Button
			end
		end
	end
	self.createButtonMutables = nil
	local FirstButton = self.m_firstButton
	local iPageStartIndex = 1
	if iPageStartIndex_arg ~= nil and self.m_totalItems > 0 then
		iPageStartIndex = iPageStartIndex_arg - self.m_numButtons / 2
		if iPageStartIndex < 1 then
			iPageStartIndex = 1
		end
		iPageStartIndex = math.floor(iPageStartIndex + 0.5)
		if self.m_totalItems - self.m_numButtons / 2 <= iPageStartIndex_arg then
			iPageStartIndex = self.m_totalItems - self.m_numButtons + 1
		end
		if iPageStartIndex < 1 then
			iPageStartIndex = 1
		end
		local PageIndexDiff = iPageStartIndex_arg - iPageStartIndex
		if PageIndexDiff > 0 and PageIndexDiff <= self.m_numButtons then
			for Index = 1, PageIndexDiff, 1 do
				local VerticalOffset = Index
				FirstButton = FirstButton.nextButton
			end
		end
	end
	f0_local7(self, iPageStartIndex, FirstButton)
end

CoD.ListBox.SetTotalItems = function (self, iNewTotalItems, f26_arg2)
	self.m_totalItems = iNewTotalItems
	self:generate(f26_arg2)
end

CoD.ListBox.GetTotalItems = function (self)
	if self ~= nil then
		return self.m_totalItems
	else
		return 0
	end
end

CoD.ListBox.GetFocussedIndex = function (self)
	if self ~= nil and self.m_focussedButton ~= nil then
		return self.m_focussedButton.m_index
	else
		return nil
	end
end

CoD.ListBox.GetFocussedMutables = function (self)
	if self ~= nil and self.m_focussedButton ~= nil and self.m_focussedButton.body ~= nil then
		return self.m_focussedButton.body.m_mutables
	else
		return nil
	end
end

CoD.ListBox.GetFocusedButton = function (self)
	if self ~= nil and self.m_focussedButton ~= nil then
		return self.m_focussedButton
	else
		return nil
	end
end

CoD.ListBox.Refresh = function (self, f31_arg1)
	if self ~= nil then
		f0_local7(self, self.m_pageStartIndex, self.m_focussedButton, f31_arg1)
	end
end

CoD.ListBox.ShowError = function (self, f32_arg1)
	if self ~= nil then
		self:showMessage(f32_arg1)
		self.m_errorState = true
	end
end

CoD.ListBox.ClearError = function (self)
	if self ~= nil then
		self.m_messageElement.textField:setText("")
		self.m_errorState = nil
	end
end

CoD.ListBox.ShowMessage = function (self, f34_arg1)
	if self ~= nil then
		f0_local6(self)
		self.m_messageElement.textField:setText(f34_arg1)
	end
end

CoD.ListBox.HideMessage = function (self, bHide)
	if self ~= nil and self.m_messageElement ~= nil then
		if bHide == true then
			self.m_messageElement.textField:setAlpha(0)
		else
			self.m_messageElement.textField:setAlpha(1)
		end
	end
end

CoD.ListBox.EnablePageArrows = function (self)
	self.m_pageArrowsOn = true
end

CoD.ListBox.new = function (MenuRef, iController, iShownButtonCount, iButtonHeight, iButtonLength, CreateButtonMutablesFunc, GetButtonDataFunc, iHighlightedZ, iButtonPadding)
	local Widget = LUI.UIElement.new(MenuRef)
	Widget.id = "ListBox"
	Widget.m_controller = iController
	Widget.m_numButtons = iShownButtonCount
	Widget.m_buttonHeight = iButtonHeight
	Widget.m_buttonLength = iButtonLength
	Widget.m_totalHeight = Widget.m_numButtons * Widget.m_buttonHeight
	Widget.m_totalItems = 0
	Widget.m_pageStartIndex = 1
	local iHighlightedZ_local
	if iHighlightedZ ~= 0 then
		iHighlightedZ_local = iHighlightedZ
	else
		iHighlightedZ_local = 0
	end
	Widget.m_highlightedZ = iHighlightedZ_local
	Widget.m_buttonPadding = iButtonPadding
	Widget.m_messageElement = CreateMessageElement()
	Widget.m_positionText = CreatePositionText(Widget)
	Widget.m_positionTextString = CoD.ListBox.POSITION_TEXT_DEFAULT
	Widget.m_errorState = false
	Widget.m_clickedButton = nil
	Widget.m_pageArrowsOn = false
	Widget.generate = CoD.ListBox.Generate
	Widget.setTotalItems = CoD.ListBox.SetTotalItems
	Widget.getTotalItems = CoD.ListBox.GetTotalItems
	Widget.createButtonMutables = CreateButtonMutablesFunc
	Widget.getButtonData = GetButtonDataFunc
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
	Widget:registerEventHandler("listbox_move_up", ListboxMoveUpFunc)
	Widget:registerEventHandler("listbox_move_down", ListboxMoveDownFunc)
	Widget:registerEventHandler("listbox_focussed_button_click", ListboxFocussedButtonClickFunc)
	Widget:registerEventHandler("listbox_focussed_button_unclick", ListboxFocussedButtonUnclickFunc)
	if CoD.isPC then
		Widget:setHandleMouseButton(true)
		Widget:registerEventHandler("listbox_button_mouseenter", ListboxButtonMouseEnterFunc)
		Widget:registerEventHandler("listbox_button_clicked", ListboxButtonClickedFunc)
		Widget:registerEventHandler("listbox_scrollbar_repositioned", ListboxScrollBarRepositionedFunc)
	end
	return Widget
end

