local f0_local0, f0_local1, f0_local2 = nil
LUI.createMenu.CACNavOverlay = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.AccordionGroups.new()
	local f1_local1 = f1_local0:addGroup("CUSTOM GROUP ALPHA")
	local f1_local2 = CoD.NavOverlay.new(f1_arg0, f1_local0)
	f1_local2.m_ownerController = f1_arg1
	f1_local2.leftButtonBar.m_ownerController = f1_arg1
	f1_local2.rightButtonBar.m_ownerController = f1_arg1
	f1_local2.title = Engine.Localize("MPUI_CREATE_A_CLASS_CAPS")
	f1_local2.editButton = CoD.ButtonPrompt.new("primary", "Edit", f1_local2, "button_prompt_edit")
	f1_local2.leftButtonBar:addElement(f1_local2.editButton)
	local f1_local3 = CoD.ButtonPrompt.new
	local f1_local4 = "alt2"
	local f1_local5 = "Copy"
	local f1_local6 = f1_local2
	local f1_local7 = "button_prompt_copy"
	local f1_local8, f1_local9 = false
	local f1_local10, f1_local11 = false
	f1_local2.copyButton = f1_local3(f1_local4, f1_local5, f1_local6, f1_local7, f1_local8, f1_local9, f1_local10, f1_local11, "C")
	f1_local2.rightButtonBar:addElement(f1_local2.copyButton)
	f1_local3 = CoD.ButtonPrompt.new
	f1_local4 = "alt1"
	f1_local5 = Engine.Localize("MENU_RENAME")
	f1_local6 = f1_local2
	f1_local7 = "button_prompt_rename"
	f1_local8, f1_local9 = false
	f1_local10, f1_local11 = false
	f1_local2.renameButton = f1_local3(f1_local4, f1_local5, f1_local6, f1_local7, f1_local8, f1_local9, f1_local10, f1_local11, "R")
	f1_local2.rightButtonBar:addElement(f1_local2.renameButton)
	f1_local3 = 2
	f1_local4 = 2
	f1_local5 = 2
	f1_local6 = 12
	f1_local7 = 5
	f1_local8 = 22
	f1_local9 = 250
	f1_local10 = 400
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
	f1_local11 = 2
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
		local f1_local32 = f0_local1({
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
	f0_local0(f1_local2, f1_local1)
	f1_local1.classButtons[1]:processEvent({
		name = "gain_focus"
	})
	f1_local2:registerEventHandler("button_prompt_back", CACNavOverlay_Close)
	return f1_local2
end

function CACNavOverlay_Close(f2_arg0, f2_arg1)
	Engine.PartyHostClearUIState()
	CoD.NavOverlay.Close(f2_arg0, f2_arg1)
end

f0_local0 = function (f3_arg0, f3_arg1, f3_arg2)
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
		f3_local7:registerEventHandler("button_action", f0_local2)
		f3_arg1.classButtonList:addElement(f3_local7)
		f3_arg1.classButtons[f3_local4] = f3_local7
	end
	f3_arg1.classButtons[1]:processEvent({
		name = "gain_focus"
	})
end

f0_local1 = function (f4_arg0)
	local Widget = LUI.UIElement.new(f4_arg0)
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

f0_local2 = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.navOverlay
	if f5_local0 == nil then
		return 
	else
		local f5_local1 = f5_local0.frame
		if f5_local1 == nil then
			return 
		else
			local f5_local2 = f5_local1.slideContainer
			if f5_local2 == nil then
				return 
			else
				local f5_local3 = f5_local2:scrollToNamedSlide("CAC", f5_arg1.controller, true)
				CoD.perController[f5_arg1.controller].classNumInternal = f5_arg0.classNumInternal
				f5_local0:close()
			end
		end
	end
end

