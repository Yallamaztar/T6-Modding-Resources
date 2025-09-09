require("T6.Overlay")
require("T6.AccordionGroups")
CoD.CACCopyClassNavOverlay = {}
LUI.createMenu.CACCopyClassNavOverlay = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.AccordionGroups.new()
	local f1_local1 = f1_local0:addGroup(Engine.Localize(UIExpression.GetCopyClassDialogTitle(f1_arg1, UIExpression.DvarInt(f1_arg1, "ui_custom_class_highlighted"))))
	local f1_local2 = CoD.NavOverlay.new(f1_arg0, f1_local0)
	f1_local2.m_ownerController = f1_arg1
	f1_local2.leftButtonBar.m_ownerController = f1_arg1
	f1_local2.rightButtonBar.m_ownerController = f1_arg1
	f1_local2.title = Engine.Localize("")
	f1_local2:registerEventHandler("button_prompt_back", CoD.CACCopyClassNavOverlay.buttonPromptBack)
	local f1_local3 = 2
	local f1_local4 = 2
	local f1_local5 = 2
	local f1_local6 = 12
	local f1_local7 = 5
	local f1_local8 = 22
	local f1_local9 = 250
	local f1_local10 = 400
	f1_local2.classBackground = LUI.UIImage.new({
		left = -f1_local10 / 2,
		top = -f1_local10 / 2 - 25,
		right = f1_local10 / 2,
		bottom = f1_local10 / 2 - 25,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		alpha = 0
	})
	f1_local2.infoPane:addElement(f1_local2.classBackground)
	CoD.CACUtility.SetupElementForClassData(f1_local2)
	local f1_local11 = 2
	local f1_local12 = (f1_local9 - f1_local7 * (f1_local3 - 1)) / f1_local3
	local f1_local13 = f1_local12 * f1_local11
	local f1_local14 = 60
	local f1_local15 = 10
	local f1_local16 = f1_local12 * 0.2
	for f1_local17 = 1, f1_local3, 1 do
		local f1_local20 = nil
		if f1_local17 == 1 then
			f1_local20 = LUI.UIImage.new({
				left = f1_local14,
				top = f1_local15,
				right = f1_local14 + f1_local13,
				bottom = f1_local15 + f1_local12,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = false,
				bottomAnchor = false,
				red = 0,
				green = 0,
				blue = 0,
				alpha = 0
			})
		else
			f1_local20 = LUI.UIImage.new({
				left = f1_local14 + f1_local16 * f1_local11,
				top = f1_local15,
				right = f1_local14 + f1_local13,
				bottom = f1_local15 + f1_local12 - f1_local16,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = false,
				bottomAnchor = false,
				red = 0,
				green = 0,
				blue = 0,
				alpha = 0
			})
		end
		f1_local2.infoPane:addElement(f1_local20)
		if f1_local17 == 1 then
			f1_local2.primaryWeaponImage = f1_local20
		else
			f1_local2.secondaryWeaponImage = f1_local20
		end
		f1_local15 = f1_local15 + f1_local12 + f1_local7
	end
	f1_local14 = f1_local14 + f1_local13 + f1_local7
	local f1_local17 = 1
	local f1_local18 = (f1_local9 - f1_local7 * (f1_local4 + f1_local5 - 1)) / (f1_local4 + f1_local5)
	local f1_local19 = f1_local18 * f1_local17
	f1_local15 = 0
	for f1_local21 = 1, f1_local4, 1 do
		local Widget = LUI.UIElement.new({
			left = f1_local14,
			top = f1_local15,
			right = f1_local14 + f1_local19,
			bottom = f1_local15 + f1_local18,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false
		})
		f1_local2.infoPane:addElement(Widget)
		local f1_local24 = LUI.UIImage.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true,
			red = 0,
			green = 0,
			blue = 0,
			alpha = 0
		})
		Widget:addElement(f1_local24)
		f1_local2.grenadeImages[f1_local21] = f1_local24
		local f1_local25 = LUI.UIText.new({
			left = 0,
			top = -CoD.textSize.Default,
			right = 0,
			bottom = 0,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true,
			red = 0,
			green = 0,
			blue = 0,
			alpha = CoD.textAlphaBlackDark,
			font = CoD.fonts.Default
		})
		Widget:addElement(f1_local25)
		f1_local2.grenadeCountLabels[f1_local21] = f1_local25
		f1_local15 = f1_local15 + f1_local18 + f1_local7
	end
	local f1_local21 = 1
	local f1_local20 = f1_local18
	local f1_local22 = f1_local20 * f1_local21
	for f1_local26 = 1, f1_local5, 1 do
		local Widget = LUI.UIElement.new({
			left = f1_local14,
			top = f1_local15,
			right = f1_local14 + f1_local22,
			bottom = f1_local15 + f1_local20,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false
		})
		f1_local2.infoPane:addElement(Widget)
		local f1_local28 = LUI.UIImage.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true,
			red = 0,
			green = 0,
			blue = 0,
			alpha = 0
		})
		Widget:addElement(f1_local28)
		f1_local2.equipmentImages[f1_local26] = f1_local28
		local f1_local29 = LUI.UIText.new({
			left = 0,
			top = -CoD.textSize.Default,
			right = 0,
			bottom = 0,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true,
			red = 0,
			green = 0,
			blue = 0,
			alpha = CoD.textAlphaBlackDark,
			font = CoD.fonts.Default
		})
		Widget:addElement(f1_local29)
		f1_local2.equipmentCountLabels[f1_local26] = f1_local29
		f1_local15 = f1_local15 + f1_local20 + f1_local7
	end
	f1_local14 = f1_local14 + f1_local22 + 35
	f1_local15 = 0
	local f1_local26 = 1
	local Widget = f1_local18
	local f1_local24 = Widget * f1_local26
	local f1_local25 = Widget * 0.8
	local Widget = f1_local25 * f1_local26
	local f1_local28 = f1_local14
	for f1_local29 = 1, f1_local6, 1 do
		local f1_local32 = CoD.CACCopyClassNavOverlay.createSlotContainer({
			left = f1_local28,
			top = f1_local15,
			right = f1_local28 + f1_local24,
			bottom = f1_local15 + Widget,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false
		})
		f1_local2.infoPane:addElement(f1_local32)
		local f1_local33 = LUI.UIImage.new({
			left = -Widget / 2,
			top = -f1_local25 / 2,
			right = Widget / 2,
			bottom = f1_local25 / 2,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false,
			red = 0,
			green = 0,
			blue = 0,
			alpha = 0
		})
		f1_local32:addElement(f1_local33)
		f1_local2.perkImages[f1_local29] = f1_local33
		if f1_local29 % 6 == 0 then
			f1_local15 = f1_local15 + Widget + f1_local7
			f1_local28 = f1_local14
		else
			f1_local28 = f1_local28 + f1_local24 + f1_local7
		end
	end
	CoD.CACCopyClassNavOverlay.addButtons(f1_local2, f1_local1)
	f1_local1.classButtons[1]:processEvent({
		name = "gain_focus"
	})
	return f1_local2
end

CoD.CACCopyClassNavOverlay.createSlotContainer = function (f2_arg0)
	local Widget = LUI.UIElement.new(f2_arg0)
	Widget:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = 0,
		green = 0,
		blue = 0,
		alpha = CoD.slotContainerAlpha
	}))
	return Widget
end

CoD.CACCopyClassNavOverlay.addButtons = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = f3_arg0.accordionGroups
	local f3_local1 = 80
	local f3_local2 = 5
	local f3_local3 = f3_local2 * f3_local0.sectionHeight + (f3_local2 - 1) * f3_local1
	f3_arg2 = 0
	f3_arg1.classButtonList = LUI.UIHorizontalList.new({
		left = -f3_local3 / 2,
		top = 0,
		right = f3_local3 / 2,
		bottom = f3_local0.sectionHeight,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		spacing = f3_local1
	})
	f3_arg1:addElement(f3_arg1.classButtonList)
	f3_arg1.classButtons = {}
	for f3_local4 = 1, 5, 1 do
		local f3_local7 = CoD.ClassButton.new(f3_arg0.m_ownerController, RegisterMaterial("playlist_generic_0" .. f3_local4), f3_local4 - 1, {
			left = 0,
			top = 0,
			right = f3_local0.sectionHeight,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		}, f3_local0.sectionHeight)
		f3_local7.navOverlay = f3_arg0
		f3_local7:registerEventHandler("button_action", CoD.CACCopyClassNavOverlay.classButtonAction)
		f3_arg1.classButtonList:addElement(f3_local7)
		f3_arg1.classButtons[f3_local4] = f3_local7
	end
	f3_arg1.classButtons[1]:processEvent({
		name = "gain_focus"
	})
end

CoD.CACCopyClassNavOverlay.classButtonAction = function (f4_arg0, f4_arg1)
	Engine.Exec(f4_arg1.controller, "copyClass " .. UIExpression.DvarInt(f4_arg1.controller, "ui_custom_class_highlighted") .. " " .. f4_arg0.classNumInternal)
	Engine.Exec(f4_arg1.controller, "updategamerprofile")
	f4_arg0.navOverlay.frame:replaceOverlay(f4_arg1.controller, f4_arg0.navOverlay, "CACNavOverlay")
end

CoD.CACCopyClassNavOverlay.buttonPromptBack = function (f5_arg0, f5_arg1)
	f5_arg0:registerEventHandler("button_prompt_back", CoD.NavOverlay.Close)
	f5_arg0.frame:replaceOverlay(f5_arg1.controller, f5_arg0, "CACNavOverlay")
end

