require("T6.MFSlide")
require("T6.MFSlidePanel")
require("T6.CoD9Button")
local f0_local0, f0_local1, f0_local2, f0_local3, f0_local4, f0_local5, f0_local6, f0_local7, f0_local8, f0_local9, f0_local10, f0_local11, f0_local12, f0_local13, f0_local14, f0_local15, f0_local16, f0_local17, f0_local18, f0_local19, f0_local20 = nil
CoD.CACSelectClass = {}
CoD.CACSelectClass.PerkCyclePeriod = 1000
CoD.CACSelectClass.PerkFadeInTime = 500
CoD.CACSelectClass.PerkFadeOutTime = 250
LUI.createMenu.CACSelectClass = function ()
	local f1_local0 = CoD.MFSlide.new()
	f1_local0.title = Engine.Localize("MENU_CREATE_A_CLASS_CAPS")
	f1_local0:registerEventHandler("slide_activated", f0_local0)
	f1_local0:registerEventHandler("slide_deactivated", f0_local1)
	f1_local0:registerEventHandler("add_slide_elements", f0_local2)
	f1_local0:registerEventHandler("cycle_perks", f0_local4)
	f1_local0:registerEventHandler("refresh_class_names", f0_local20)
	return f1_local0
end

f0_local0 = function (f2_arg0, f2_arg1)
	CoD.MFSlide.activated(f2_arg0, f2_arg1)
	f2_arg0.body.classButtonPane:animateToState("slide_out", f2_arg0.fadeInTime, true, true)
	f2_arg0.body.gunPane:animateToState("slide_out", f2_arg0.fadeInTime, true, true)
	f2_arg0.body.grenadePane:animateToState("slide_out", f2_arg0.fadeInTime, true, true)
	f2_arg0.body.perkPane:animateToState("slide_out", f2_arg0.fadeInTime, true, true)
	f0_local5(f2_arg0.body.perkPane, f2_arg0.body.currentPerkCount)
end

f0_local1 = function (f3_arg0, f3_arg1)
	CoD.MFSlide.deactivated(f3_arg0, f3_arg1)
	f3_arg0.body.classButtonPane:animateToState("default", f3_arg0.fadeOutTime, true, true)
	f3_arg0.body.gunPane:animateToState("default", f3_arg0.fadeOutTime, true, true)
	f3_arg0.body.grenadePane:animateToState("default", f3_arg0.fadeOutTime, true, true)
	f3_arg0.body.perkPane:animateToState("default", f3_arg0.fadeOutTime, true, true)
end

f0_local2 = function (f4_arg0, f4_arg1)
	CoD.MFSlide.addSlideElements(f4_arg0, f4_arg1)
	CoD.CACUtility.SetupElementForClassData(f4_arg0.body)
	f4_arg0:addSelectButton()
	f4_arg0:addBackButton()
	f4_arg0:registerEventHandler("button_prompt_back", f0_local18)
	local f4_local0 = f4_arg0.m_ownerController
	local f4_local1 = 30
	local f4_local2 = 30
	local f4_local3 = 350
	local f4_local4 = 200
	f0_local12(f4_arg0, f4_local0, {
		left = -f4_local3,
		top = f4_local2,
		right = 0,
		bottom = f4_local4,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}, {
		left = f4_local1,
		top = f4_local2,
		right = f4_local3,
		bottom = f4_local4,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	local f4_local5 = 1
	if CoD.perController[f4_local0].classNumInternal ~= nil then
		f4_local5 = CoD.perController[f4_local0].classNumInternal + 1
	end
	local f4_local6 = CoD.CACUtility.GetClassData(f4_local0, f4_arg0.body.classButtons[f4_local5].classNumInternal)
	f4_arg0.body.classData = f4_local6
	local f4_local7 = -f4_local1
	local f4_local8 = f4_local2
	local f4_local9 = 500
	local f4_local10 = 300
	f0_local13(f4_arg0, f4_local9, f4_local10, {
		left = 0,
		top = f4_local8,
		right = f4_local9,
		bottom = f4_local10,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, {
		left = f4_local7 - f4_local9,
		top = f4_local8,
		right = f4_local7,
		bottom = f4_local10,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	local f4_local11 = f4_local7
	local f4_local12 = -220
	local f4_local13 = f4_local9
	local f4_local14 = 100
	local f4_local15 = f4_local11 - f4_local13
	local f4_local16 = f4_local12 + f4_local14
	f0_local14(f4_arg0, f4_local13, f4_local14, {
		left = 0,
		top = f4_local12,
		right = f4_local13,
		bottom = f4_local16,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	}, {
		left = f4_local15,
		top = f4_local12,
		right = f4_local11,
		bottom = f4_local16,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	})
	local f4_local17 = f4_local11
	local f4_local18 = -120
	local f4_local19 = f4_local13
	local f4_local20 = 50
	local f4_local21 = f4_local17 - f4_local19
	local f4_local22 = f4_local18 + f4_local20
	f4_arg0.body.currentPerkCount = #f4_local6.perks
	f4_arg0.body.currentPerkInFocus = 1
	f0_local15(f4_arg0, {
		left = 0,
		top = f4_local18,
		right = f4_local19,
		bottom = f4_local22,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	}, {
		left = f4_local21,
		top = f4_local18,
		right = f4_local17,
		bottom = f4_local22,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	})
	f4_arg0.body:addElement(LUI.UITimer.new(CoD.CACSelectClass.PerkCyclePeriod, "cycle_perks", false, f4_arg0))
	f4_arg0.body.blur = LUI.UIImage.new({
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
	f4_arg0.body.blur:registerAnimationState("fade_in", {
		alpha = 0.8
	})
	f4_arg0.body:addElement(f4_arg0.body.blur)
	local f4_local23 = 400
	local f4_local24 = 250
	local f4_local25 = 200
	local f4_local26 = 100
	local f4_local27 = f4_local25 + f4_local23
	local f4_local28 = f4_local26 + f4_local24
	local f4_local29 = {
		left = f4_local25,
		top = 0,
		right = f4_local27,
		bottom = f4_local24,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		alpha = 1
	}
	local f4_local30 = {
		left = f4_local25,
		top = f4_local26,
		right = f4_local27,
		bottom = f4_local28,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		alpha = 1
	}
	f0_local16(f4_arg0, f4_local29, f4_local30)
	f0_local17(f4_arg0, f4_local29, f4_local30)
	f4_arg0.body.classButtons[f4_local5]:processEvent({
		name = "gain_focus"
	})
end

f0_local12 = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	local f5_local0 = f5_arg0.body
	f5_local0.classButtonPane = CoD.MFSlidePanel.new(f5_arg2)
	f5_local0.classButtonPane:registerAnimationState("slide_out", f5_arg3)
	f5_local0:addElement(f5_local0.classButtonPane)
	f5_local0.classButtonList = CoD.ButtonList.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	f5_local0.classButtonPane:addElement(f5_local0.classButtonList)
	f5_local0.classButtons = {}
	for f5_local1 = 1, CoD.CACUtility.maxCustomClass, 1 do
		local f5_local4 = f5_local1 - 1
		local f5_local5 = f5_local0.classButtonList
		local f5_local6 = f5_local5
		f5_local5 = f5_local5.addButton
		local f5_local7 = CoD.CACUtility.GetLoadoutNameFromIndex(f5_arg1, f5_local4)
		f5_local5 = f5_local5(f5_local6, f5_local7:get(), nil, f5_local4)
		f5_local5.CACSelectClass = f5_arg0
		f5_local5.classNumInternal = f5_local4
		f5_local5:registerEventHandler("button_action", f0_local6)
		f5_local5:registerEventHandler("button_over", f0_local7)
		f5_local5:registerEventHandler("button_prompt_options", f0_local19)
		f5_local0.classButtons[f5_local1] = f5_local5
	end
	local f5_local1 = CoD.ButtonPrompt.new
	local f5_local2 = "alt1"
	local f5_local3 = Engine.Localize("CLASS OPTIONS")
	local f5_local8 = f5_arg0
	local f5_local4 = "button_prompt_options"
	local f5_local5, f5_local6 = false
	local f5_local7, f5_local9 = false
	f5_local0.optionsButtonPrompt = f5_local1(f5_local2, f5_local3, f5_local8, f5_local4, f5_local5, f5_local6, f5_local7, f5_local9, "O")
	f5_local0.optionsButtonPrompt:setPriority(100)
	f5_local0.classButtonList:addElement(f5_local0.optionsButtonPrompt)
end

f0_local13 = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	local f6_local0 = f6_arg0.body
	f6_local0.gunPane = CoD.MFSlidePanel.new(f6_arg3)
	f6_local0.gunPane:registerAnimationState("slide_out", f6_arg4)
	f6_local0:addElement(f6_local0.gunPane)
	local f6_local1 = CoD.fonts.Big
	local f6_local2 = CoD.textSize.Big
	local f6_local3 = CoD.fonts.Default
	local f6_local4 = CoD.textSize.Default
	local f6_local5 = 5
	local f6_local6 = 2
	local f6_local7 = -80
	local f6_local8 = 0
	local f6_local9 = f6_local8 - f6_arg1
	local f6_local10 = f6_local2
	local f6_local11 = f6_local10 + f6_local4
	local f6_local12 = f6_arg2 / 2 - f6_local5
	f6_local0.primaryWeaponImage = LUI.UIImage.new({
		left = f6_local7 - f6_local12 * f6_local6,
		top = 0,
		right = f6_local7,
		bottom = f6_local12,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = 0
	})
	f6_local0.gunPane:addElement(f6_local0.primaryWeaponImage)
	if f6_local0.attachmentLabels.primary == nil then
		f6_local0.attachmentLabels.primary = {}
	end
	for f6_local13 = 1, CoD.CACUtility.maxAttachments, 1 do
		local f6_local16 = LUI.UIText.new({
			left = f6_local9,
			top = f6_local10,
			right = f6_local8,
			bottom = f6_local11,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			alpha = CoD.textAlpha,
			font = f6_local3
		})
		f6_local0.gunPane:addElement(f6_local16)
		f6_local0.attachmentLabels.primary[f6_local13] = f6_local16
		f6_local10 = f6_local10 + f6_local4
		f6_local11 = f6_local10 + f6_local4
	end
	f6_local0.primaryWeaponLabel = LUI.UIText.new({
		left = f6_local9,
		top = 0,
		right = f6_local8,
		bottom = f6_local2,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = CoD.textAlpha,
		font = f6_local1
	})
	f6_local0.gunPane:addElement(f6_local0.primaryWeaponLabel)
	local f6_local14 = f6_local12 * 0.8
	local f6_local15 = f6_local14 * f6_local6
	local f6_local17 = f6_local12 + f6_local5
	local f6_local16 = f6_local17 + f6_local14
	f6_local10 = f6_local17 + f6_local2
	f6_local11 = f6_local10 + f6_local4
	f6_local0.secondaryWeaponImage = LUI.UIImage.new({
		left = f6_local7 - f6_local15,
		top = f6_local17,
		right = f6_local7,
		bottom = f6_local16,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = 0
	})
	f6_local0.gunPane:addElement(f6_local0.secondaryWeaponImage)
	if f6_local0.attachmentLabels.secondary == nil then
		f6_local0.attachmentLabels.secondary = {}
	end
	for f6_local18 = 1, CoD.CACUtility.maxAttachments, 1 do
		local f6_local21 = LUI.UIText.new({
			left = f6_local9,
			top = f6_local10,
			right = f6_local8,
			bottom = f6_local11,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			alpha = CoD.textAlpha,
			font = f6_local3
		})
		f6_local0.gunPane:addElement(f6_local21)
		f6_local0.attachmentLabels.secondary[f6_local18] = f6_local21
		f6_local10 = f6_local10 + f6_local4
		f6_local11 = f6_local10 + f6_local4
	end
	f6_local0.secondaryWeaponLabel = LUI.UIText.new({
		left = f6_local9,
		top = f6_local17,
		right = f6_local8,
		bottom = f6_local17 + f6_local2,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = CoD.textAlpha,
		font = f6_local1
	})
	f6_local0.gunPane:addElement(f6_local0.secondaryWeaponLabel)
end

f0_local14 = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)
	local f7_local0 = f7_arg0.body
	f7_local0.grenadePane = CoD.MFSlidePanel.new(f7_arg3)
	f7_local0.grenadePane:registerAnimationState("slide_out", f7_arg4)
	f7_local0:addElement(f7_local0.grenadePane)
	local f7_local1 = CoD.fonts.Default
	local f7_local2 = CoD.textSize.Default
	local f7_local3 = 0
	local f7_local4 = f7_local2
	local f7_local5 = 0
	local f7_local6 = f7_local5 - f7_arg1
	local f7_local7 = 1
	local f7_local8 = 60
	local f7_local9 = f7_local8 * f7_local7
	local f7_local10 = f7_local2 * 1.5
	local f7_local11 = f7_local10 + f7_local8
	local f7_local12 = -(f7_local9 * CoD.CACUtility.maxGrenades)
	local f7_local13 = f7_local12 + f7_local9
	for f7_local14 = 1, CoD.CACUtility.maxGrenades, 1 do
		local Widget = LUI.UIElement.new({
			left = f7_local12,
			top = f7_local10,
			right = f7_local13,
			bottom = f7_local11,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false
		})
		f7_arg0.body.grenadePane:addElement(Widget)
		local f7_local18 = LUI.UIImage.new({
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
		Widget:addElement(f7_local18)
		f7_arg0.body.grenadeImages[f7_local14] = f7_local18
		local f7_local19 = LUI.UIText.new({
			left = 0,
			top = -(f7_local2 / 2),
			right = 0,
			bottom = f7_local2 / 2,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false,
			font = f7_local1
		})
		Widget:addElement(f7_local19)
		f7_arg0.body.grenadeCountLabels[f7_local14] = f7_local19
		local f7_local20 = LUI.UIText.new({
			left = f7_local6,
			top = f7_local3,
			right = f7_local5,
			bottom = f7_local4,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			alpha = CoD.textAlpha,
			font = f7_local1
		})
		f7_arg0.body.grenadePane:addElement(f7_local20)
		f7_arg0.body.grenadeLabels[f7_local14] = f7_local20
		f7_local3 = f7_local3 + f7_local2
		f7_local4 = f7_local3 + f7_local2
		f7_local12 = f7_local12 + f7_local9
		f7_local13 = f7_local12 + f7_local9
	end
end

f0_local15 = function (f8_arg0, f8_arg1, f8_arg2)
	local f8_local0 = f8_arg0.body
	f8_local0.perkPane = CoD.MFSlidePanel.new(f8_arg1)
	f8_local0.perkPane:registerAnimationState("slide_out", f8_arg2)
	f8_local0:addElement(f8_local0.perkPane)
	local f8_local1 = CoD.fonts.Default
	local f8_local2 = CoD.textSize.Default
	local f8_local3 = 0
	local f8_local4 = f8_local2
	local f8_local5 = 1
	local f8_local6 = 40
	local f8_local7 = f8_local6 * f8_local5
	local f8_local8 = -f8_local6
	local f8_local9 = 0
	local f8_local10 = 0
	local f8_local11 = f8_local7
	for f8_local12 = 1, CoD.CACUtility.maxPerks, 1 do
		local Widget = LUI.UIElement.new({
			left = f8_local10,
			top = f8_local3,
			right = f8_local11,
			bottom = f8_local3 + f8_local2 + f8_local6,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false
		})
		f8_arg0.body.perkPane:addElement(Widget)
		local f8_local16 = LUI.UIText.new({
			left = -f8_local7,
			top = f8_local3,
			right = 0,
			bottom = f8_local4,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			font = f8_local1,
			alpha = 0
		})
		f8_local16:registerAnimationState("fade_in", {
			alpha = 1
		})
		Widget:addElement(f8_local16)
		f8_arg0.body.perkLabels[f8_local12] = f8_local16
		local f8_local17 = LUI.UIImage.new({
			left = -f8_local7,
			top = f8_local8,
			right = 0,
			bottom = f8_local9,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true,
			red = 0,
			green = 0,
			blue = 0,
			alpha = 0
		})
		Widget:addElement(f8_local17)
		f8_arg0.body.perkImages[f8_local12] = f8_local17
		local f8_local18 = CoD.Brackets.new(5)
		f8_local18:processEvent({
			name = "fade",
			alpha = 0
		})
		f8_local18:setPriority(100)
		f8_local17:addElement(f8_local18)
		f8_arg0.body.perkBrackets[f8_local12] = f8_local18
		f8_local10 = f8_local10 + f8_local7
		f8_local11 = f8_local11 + f8_local7
	end
	f8_local0.perkLabels[1]:animateToState("fade_in")
	f8_local0.perkBrackets[1]:processEvent({
		name = "fade",
		alpha = 1
	})
end

f0_local16 = function (f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = f9_arg0.body
	f9_local0.optionsPane = CoD.MFSlidePanel.new(f9_arg1)
	f9_local0.optionsPane:registerAnimationState("slide_out", f9_arg2)
	f9_local0:addElement(f9_local0.optionsPane)
	f9_local0.optionsPane:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = 0.25,
		green = 0.25,
		blue = 0.25,
		alpha = 1
	}))
	local f9_local1 = CoD.fonts.Condensed
	local f9_local2 = CoD.textSize.Condensed
	local f9_local3 = 30
	local f9_local4 = 20
	f9_local0.optionsPane.title = LUI.UIText.new({
		left = f9_local3,
		top = f9_local4,
		right = 0,
		bottom = f9_local4 + f9_local2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = f9_local1
	})
	f9_local0.optionsPane:addElement(f9_local0.optionsPane.title)
	local f9_local5 = 30
	f9_local0.optionsPane.buttonList = CoD.ButtonList.new({
		left = f9_local5,
		top = 0,
		right = -f9_local5,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	f9_local0.optionsPane:addElement(f9_local0.optionsPane.buttonList)
	f9_local0.optionsPane.buttonList:addSpacer(f9_local4 + CoD.CoD9Button.Height)
	f9_local0.optionsPane.renameButton = f9_local0.optionsPane.buttonList:addButton("RENAME", "Rename this class")
	f9_local0.optionsPane.renameButton.CACSelectClass = f9_arg0
	f9_local0.optionsPane.renameButton:registerEventHandler("button_action", f0_local8)
	f9_local0.optionsPane.copyButton = f9_local0.optionsPane.buttonList:addButton("COPY", "Copy this class")
	f9_local0.optionsPane.copyButton.CACSelectClass = f9_arg0
	f9_local0.optionsPane.copyButton:registerEventHandler("button_action", f0_local9)
	f9_local0.optionsPane.saveButton = f9_local0.optionsPane.buttonList:addButton("SAVE TO FILESHARE", "Save this class")
	f9_local0.optionsPane.saveButton:disable()
	f9_local0.optionsPane.buttonList:addSpacer(CoD.CoD9Button.Height)
	f9_local0.optionsPane.resetButton = f9_local0.optionsPane.buttonList:addButton("RESET TO DEFAULT", "Reset this class")
	f9_local0.optionsPane.resetButton:disable()
end

f0_local17 = function (f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = f10_arg0.body
	f10_local0.classCopyPane = CoD.MFSlidePanel.new(f10_arg1)
	f10_local0.classCopyPane:registerAnimationState("slide_out", f10_arg2)
	f10_local0:addElement(f10_local0.classCopyPane)
	f10_local0.classCopyPane:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = 0.25,
		green = 0.25,
		blue = 0.25,
		alpha = 1
	}))
	local f10_local1 = CoD.fonts.Condensed
	local f10_local2 = CoD.textSize.Condensed
	local f10_local3 = 30
	local f10_local4 = 25
	f10_local0.classCopyPane.title = LUI.UIText.new({
		left = f10_local3,
		top = f10_local4,
		right = 0,
		bottom = f10_local4 + f10_local2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = f10_local1
	})
	f10_local0.classCopyPane:addElement(f10_local0.classCopyPane.title)
	local f10_local5 = 30
	f10_local0.classCopyPane.buttonList = CoD.ButtonList.new({
		left = f10_local5,
		top = 0,
		right = -f10_local5,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	f10_local0.classCopyPane:addElement(f10_local0.classCopyPane.buttonList)
	f10_local0.classCopyPane.buttonList:addSpacer(2 * CoD.CoD9Button.Height)
	f10_local0.classCopyPane.buttons = {}
	for f10_local6 = 1, CoD.CACUtility.maxCustomClass, 1 do
		local f10_local9 = f10_local6 - 1
		local f10_local10 = CoD.CACUtility.GetLoadoutNameFromIndex(controller, f10_local9)
		local f10_local11 = f10_local0.classCopyPane.buttonList:addButton(f10_local10:get(), nil, f10_local9)
		f10_local11.CACSelectClass = f10_arg0
		f10_local11.classNumInternal = f10_local9
		f10_local11:registerEventHandler("button_action", f0_local10)
		f10_local0.classCopyPane.buttons[f10_local6] = f10_local11
	end
end

f0_local18 = function (f11_arg0, f11_arg1)
	CoD.MFSlide.buttonPromptBack(f11_arg0, f11_arg1)
	Engine.Exec(f11_arg1.controller, "uploadstats")
	Engine.CommitProfileChanges(f11_arg1.controller)
	Engine.PartyHostClearUIState()
end

function CACSelectClass_ButtonPromptOptionsBack(f12_arg0, f12_arg1)
	local f12_local0 = f12_arg0.body
	local f12_local1 = CoD.perController[f12_arg1.controller].classNumInternal
	f12_local0.optionsPane:animateToState("default", f12_arg0.fadeInTime, true, true)
	f12_local0.optionsPane:processEvent({
		name = "lose_focus"
	})
	f12_local0.classCopyPane:animateToState("default", f12_arg0.fadeInTime, true, true)
	f12_local0.classCopyPane:processEvent({
		name = "lose_focus"
	})
	f12_local0.classButtons[f12_local1 + 1]:processEvent({
		name = "gain_focus"
	})
	f12_local0.blur:animateToState("default", f12_arg0.fadeInTime, true, true)
	f12_arg0:registerEventHandler("button_prompt_back", f0_local18)
	f12_arg0:addElement(LUI.UITimer.new(f12_arg0.fadeInTime, "refresh_class_names", true, f12_arg0))
end

f0_local19 = function (f13_arg0, f13_arg1)
	if f13_arg0:isInFocus() then
		local f13_local0 = f13_arg0.CACSelectClass
		CoD.perController[f13_arg1.controller].classNumInternal = f13_arg0.classNumInternal
		local f13_local1 = CoD.CACUtility.GetLoadoutNameFromIndex(controller, f13_arg0.classNumInternal)
		f13_local0.body.optionsPane.title:setText("[" .. f13_local1:get() .. "]")
		f13_local0.body.optionsPane:animateToState("slide_out", f13_local0.fadeInTime, true, true)
		f13_local0.body.classButtonPane:processEvent({
			name = "lose_focus"
		})
		f13_local0.body.optionsPane.renameButton:processEvent({
			name = "gain_focus"
		})
		f13_local0.body.blur:animateToState("fade_in", f13_local0.fadeInTime, true, true)
		f13_local0:registerEventHandler("button_prompt_back", CACSelectClass_ButtonPromptOptionsBack)
	end
end

f0_local6 = function (f14_arg0, f14_arg1)
	local f14_local0 = f14_arg0.CACSelectClass
	if f14_local0 == nil then
		return 
	else
		local f14_local1 = f14_local0.frame
		if f14_local1 == nil then
			return 
		else
			local f14_local2 = f14_local1.slideContainer
			if f14_local2 == nil then
				return 
			else
				CoD.perController[f14_arg1.controller].classNumInternal = f14_arg0.classNumInternal
				local f14_local3 = f14_local2:scrollToNamedSlide("CAC", f14_arg1.controller, true)
			end
		end
	end
end

f0_local8 = function (f15_arg0, f15_arg1)
	local f15_local0 = f15_arg0.CACSelectClass
	f15_local0:registerEventHandler("ui_keyboard_input", f0_local11)
	local f15_local1 = CoD.CACUtility.GetLoadoutNameFromIndex(f15_arg1.controller, f15_arg0.classNumInternal)
	f15_local1 = f15_local1:get()
	f15_local0.controller = f15_arg1.controller
	Engine.SetDvar("ui_custom_name", f15_local1)
	Engine.Exec(f15_arg1.controller, "ui_keyboard MENU_CUSTOMCLASS_KEYBOARD ui_custom_name")
end

f0_local11 = function (f16_arg0, f16_arg1)
	f16_arg0:registerEventHandler("ui_keyboard_input", nil)
	local f16_local0 = f16_arg1.input
	local f16_local1 = CoD.perController[f16_arg0.controller].classNumInternal
	if f16_local0 ~= nil then
		local f16_local2 = CoD.CACUtility.GetLoadoutNameFromIndex(f16_arg0.controller, f16_local1)
		f16_local2:set(f16_local0)
		f16_arg0.body.classButtons[f16_local1 + 1].label:setText(f16_local0)
	end
	f16_arg0:processEvent({
		name = "button_prompt_back",
		controller = f16_arg0.controller
	})
	f16_arg0.controller = nil
end

f0_local9 = function (f17_arg0, f17_arg1)
	local f17_local0 = f17_arg0.CACSelectClass
	f0_local20(f17_local0, f17_arg1.controller)
	local f17_local1 = CoD.CACUtility.GetLoadoutNameFromIndex(f17_arg1.controller, CoD.perController[f17_arg1.controller].classNumInternal)
	f17_local0.body.classCopyPane.title:setText("Select a slot to copy [" .. f17_local1:get() .. "] to.")
	f17_local0.body.optionsPane:animateToState("default", f17_local0.fadeInTime, true, true)
	f17_local0.body.optionsPane:processEvent({
		name = "lose_focus"
	})
	f17_local0.body.classCopyPane:animateToState("slide_out", f17_local0.fadeInTime, true, true)
	f17_local0.body.classCopyPane.buttons[1]:processEvent({
		name = "gain_focus"
	})
end

f0_local10 = function (f18_arg0, f18_arg1)
	local f18_local0 = f18_arg0.CACSelectClass
	Engine.Exec(f18_arg1.controller, "copyClass " .. CoD.perController[f18_arg1.controller].classNumInternal .. " " .. f18_arg0.classNumInternal)
	Engine.Exec(f18_arg1.controller, "updategamerprofile")
	f18_local0:processEvent({
		name = "button_prompt_back",
		controller = f18_arg1.controller
	})
end

f0_local3 = function (f19_arg0)
	local f19_local0 = f19_arg0.CACSelectClass.body
	local f19_local1 = f19_arg0.CACSelectClass.m_ownerController
	local f19_local2 = CoD.CACUtility.GetClassData(f19_local1, f19_arg0.classNumInternal)
	f19_local0.classData = f19_local2
	f19_local0.currentPerkCount = #f19_local2.perks
	f0_local5(f19_local0.perkPane, f19_local0.currentPerkCount)
	CoD.CACUtility.UpdateUIFromClassData(f19_local2, f19_local0, f19_local1)
end

f0_local7 = function (f20_arg0, f20_arg1)
	LUI.UIButton.Over(f20_arg0, f20_arg1)
	f0_local3(f20_arg0)
end

f0_local4 = function (f21_arg0, f21_arg1)
	local f21_local0 = f21_arg0.body.currentPerkInFocus
	local f21_local1 = f21_arg0.body.perkLabels
	f21_arg0.body.perkLabels[f21_local0]:animateToState("default", CoD.CACSelectClass.PerkFadeOutTime)
	f21_arg0.body.perkBrackets[f21_local0]:processEvent({
		name = "fade",
		alpha = 0,
		duration = CoD.CACSelectClass.PerkFadeOutTime
	})
	f21_local0 = f21_local0 + 1
	if f21_arg0.body.currentPerkCount < f21_local0 then
		f21_local0 = 1
	end
	f21_arg0.body.perkLabels[f21_local0]:animateToState("fade_in", CoD.CACSelectClass.PerkFadeInTime)
	f21_arg0.body.perkBrackets[f21_local0]:processEvent({
		name = "fade",
		alpha = 1,
		duration = CoD.CACSelectClass.PerkFadeInTime
	})
	f21_arg0.body.currentPerkInFocus = f21_local0
end

f0_local5 = function (f22_arg0, f22_arg1)
	f22_arg0:registerAnimationState("align_pane", {
		left = -(40 * f22_arg1) - 30,
		top = -120,
		right = -30,
		bottom = -70,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	})
	f22_arg0:animateToState("align_pane", 250)
end

f0_local20 = function (f23_arg0, f23_arg1)
	local f23_local0 = f23_arg0.body
	for f23_local1 = 1, CoD.CACUtility.maxCustomClass, 1 do
		local f23_local4 = CoD.CACUtility.GetLoadoutNameFromIndex(f23_arg1, f23_local1 - 1)
		f23_local4 = f23_local4:get()
		f23_local0.classButtons[f23_local1].label:setText(f23_local4)
		f23_local0.classCopyPane.buttons[f23_local1].label:setText(f23_local4)
	end
end

