require("T6.MFSlide")
require("T6.MFSlidePanel")
require("T6.CoD9Button")
local f0_local0, f0_local1, f0_local2, f0_local3, f0_local4, f0_local5, f0_local6, f0_local7 = nil
CoD.CACClassSelection = {}
CoD.CACClassSelection.PerkCyclePeriod = 1000
CoD.CACClassSelection.PerkFadeInTime = 500
CoD.CACClassSelection.PerkFadeOutTime = 250
CoD.CACClassSelection.PaneSelectionXOffset = 40
CoD.CACClassSelection.PaneSelectedAlpha = 1
CoD.CACClassSelection.PaneNotSelectedAlpha = 0.2
CoD.CAC.createPanel.ClassSelection = function (f1_arg0)
	local f1_local0 = f1_arg0.m_ownerController
	local f1_local1 = 30
	local f1_local2 = 30
	local f1_local3 = 350
	local f1_local4 = {
		left = -f1_local3,
		top = f1_local2,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	}
	local f1_local5 = {
		left = f1_local1,
		top = f1_local2,
		right = f1_local3,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	}
	local f1_local6 = CoD.MFSlidePanel.new(f1_local4)
	f1_local6:registerAnimationState("primary", f1_local5)
	f1_local6.classButtonList = CoD.ButtonList.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	f1_local6.classButtonList.hintText:close()
	f1_local6:addElement(f1_local6.classButtonList)
	f1_local6.classButtons = {}
	for f1_local7 = 1, CoD.CACUtility.maxCustomClass, 1 do
		local f1_local10 = f1_local7 - 1
		local f1_local11 = f1_local6.classButtonList
		local f1_local12 = f1_local11
		f1_local11 = f1_local11.addButton
		local f1_local13 = CoD.CACUtility.GetLoadoutNameFromIndex(f1_local0, f1_local10)
		f1_local11 = f1_local11(f1_local12, f1_local13:get(), nil, f1_local10)
		f1_local11.CAC = f1_arg0
		f1_local11.classNumInternal = f1_local10
		f1_local11:registerEventHandler("button_action", f0_local2)
		f1_local11:registerEventHandler("button_over", f0_local3)
		f1_local11:registerEventHandler("button_prompt_options", CACClassOptions_ButtonPromptOptions)
		f1_local11:registerEventHandler("button_prompt_loadout_overview", CACLoadoutOverview_ButtonPromptLoadoutOverview)
		f1_local6.classButtons[f1_local7] = f1_local11
	end
	local f1_local7 = CoD.ButtonPrompt.new
	local f1_local8 = "alt1"
	local f1_local9 = Engine.Localize("MENU_LOADOUT_OPTIONS_CAPS")
	local f1_local14 = f1_arg0
	local f1_local10 = "button_prompt_options"
	local f1_local11, f1_local12 = false
	local f1_local13, f1_local15 = false
	f1_local6.optionsButtonPrompt = f1_local7(f1_local8, f1_local9, f1_local14, f1_local10, f1_local11, f1_local12, f1_local13, f1_local15, "O")
	f1_local6.optionsButtonPrompt:setPriority(100)
	f1_local6.classButtonList:addElement(f1_local6.optionsButtonPrompt)
	f1_local6.loadoutOverviewPrompt = CoD.ButtonPrompt.new("select", Engine.Localize("MENU_LOADOUT_OVERVIEW_CAPS"), f1_local6, "button_prompt_loadout_overview")
	f1_local6.loadoutOverviewPrompt:setPriority(200)
	f1_local6.classButtonList:addElement(f1_local6.loadoutOverviewPrompt)
	f1_local6:registerEventHandler("refresh_class_names", f0_local7)
	f1_local6:registerEventHandler("on_activate", CACClassSelection_ClassButtonsOnActivate)
	f1_local6:registerEventHandler("on_deactivate", CACClassSelection_ClassButtonsOnDeactivate)
	f1_local6.CAC = f1_arg0
	CoD.perController[f1_local0].classNumInternal = 0
	return f1_local6
end

function CACClassSelection_ClassButtonsOnActivate(f2_arg0, f2_arg1)
	local f2_local0 = CoD.perController[f2_arg1.controller].classNumInternal
	if f2_local0 == nil then
		f2_local0 = 0
	end
	f2_arg0.classButtons[f2_local0 + 1]:processEvent({
		name = "gain_focus"
	})
	if f2_arg0.optionsButtonPrompt ~= nil then
		f2_arg0.classButtonList:addElement(f2_arg0.optionsButtonPrompt)
	end
	if f2_arg0.loadoutOverviewPrompt ~= nil then
		f2_arg0.classButtonList:addElement(f2_arg0.loadoutOverviewPrompt)
	end
	if f2_arg0.clearClassButtonPrompt ~= nil then
		f2_arg0.CAC.body.leftBottomButtonBar:addElement(f2_arg0.clearClassButtonPrompt)
	end
end

function CACClassSelection_ClassButtonsOnDeactivate(f3_arg0, f3_arg1)
	if f3_arg0.optionsButtonPrompt ~= nil then
		f3_arg0.optionsButtonPrompt:close()
	end
	if f3_arg0.loadoutOverviewPrompt ~= nil then
		f3_arg0.loadoutOverviewPrompt:close()
	end
	if f3_arg0.clearClassButtonPrompt ~= nil then
		f3_arg0.clearClassButtonPrompt:close()
	end
end

local f0_local8 = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5)
	local f4_local0 = {
		left = 0,
		top = f4_arg1,
		right = f4_arg4,
		bottom = f4_arg3,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}
	local f4_local1 = {
		left = f4_arg0,
		top = f4_arg1,
		right = f4_arg2,
		bottom = f4_arg3,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = 1
	}
	local f4_local2 = {
		left = f4_arg0 - CoD.CACClassSelection.PaneSelectionXOffset,
		top = f4_arg1,
		right = f4_arg2 - CoD.CACClassSelection.PaneSelectionXOffset,
		bottom = f4_arg3,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = CoD.CACClassSelection.PaneSelectedAlpha
	}
	local f4_local3 = {
		left = f4_arg0,
		top = f4_arg1,
		right = f4_arg2,
		bottom = f4_arg3,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = CoD.CACClassSelection.PaneNotSelectedAlpha
	}
	local f4_local4 = CoD.MFSlidePanel.new(f4_local0)
	f4_local4:registerAnimationState("primary", f4_local1)
	if f4_arg5 ~= nil then
		f4_local4:registerAnimationState("secondary", f4_arg5)
	end
	f4_local4:registerAnimationState("selected", f4_local2)
	f4_local4:registerAnimationState("not_selected", f4_local3)
	return f4_local4
end

local f0_local9 = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5, f5_arg6, f5_arg7)
	local f5_local0 = 0.05
	local f5_local1 = f5_arg4
	local f5_local2 = 2
	local f5_local3 = 0
	local f5_local4 = 15
	f5_arg1.verticalLines[f5_arg2] = LUI.UIImage.new({
		left = -f5_local2,
		top = f5_local1,
		right = 0,
		bottom = f5_arg3,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = f5_local0
	})
	f5_arg1.horizontalLines[f5_arg2] = LUI.UIImage.new({
		left = f5_local3,
		top = f5_arg3 - f5_local2,
		right = -f5_local2,
		bottom = f5_arg3,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = f5_local0
	})
	f5_arg1.camoImageContainers[f5_arg2] = LUI.UIElement.new({
		left = f5_local3 + f5_arg6 * CoD.CACUtility.maxAttachments + f5_local4 + f5_arg7,
		top = f5_arg3 - f5_arg6 + f5_arg7 * 2,
		right = f5_local3 + f5_arg6 * CoD.CACUtility.maxAttachments + f5_local4 + f5_arg6 - f5_arg7,
		bottom = f5_arg3,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	})
	f5_arg1.camoImages[f5_arg2] = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = f5_local0
	})
	for f5_local5 = 0, CoD.CACUtility.maxAttachments, 1 do
		f5_arg1.verticalLines[f5_arg2]:registerAnimationState("attachment_state_" .. f5_local5, {
			left = -f5_local2,
			top = f5_local1 + f5_arg5 * f5_local5,
			right = 0,
			bottom = f5_arg3,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true
		})
		local f5_local8 = f5_local4
		if f5_local5 == 0 then
			f5_local8 = 0
		end
		f5_arg1.horizontalLines[f5_arg2]:registerAnimationState("attachment_state_" .. f5_local5, {
			left = f5_local3 + f5_arg6 * f5_local5 + f5_local8 + f5_arg6 - f5_arg7,
			top = f5_arg3 - f5_local2,
			right = -f5_local2,
			bottom = f5_arg3,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true
		})
		f5_arg1.camoImageContainers[f5_arg2]:registerAnimationState("attachment_state_" .. f5_local5, {
			left = f5_local3 + f5_arg6 * f5_local5 + f5_local8 + f5_arg7,
			top = f5_arg3 - f5_arg6 + f5_arg7 * 2,
			right = f5_local3 + f5_arg6 * f5_local5 + f5_local8 + f5_arg6 - f5_arg7,
			bottom = f5_arg3,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = true
		})
	end
	f5_arg0:addElement(f5_arg1.verticalLines[f5_arg2])
	f5_arg0:addElement(f5_arg1.horizontalLines[f5_arg2])
	f5_arg0:addElement(f5_arg1.camoImageContainers[f5_arg2])
	f5_arg1.camoImageContainers[f5_arg2]:addElement(f5_arg1.camoImages[f5_arg2])
	f5_arg1.customizePrompts[f5_arg2] = LUI.UIElement.new({
		left = 0,
		top = f5_arg7,
		bottom = f5_arg7 + 25,
		right = 100,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	})
	f5_arg1.camoImageContainers[f5_arg2]:addElement(f5_arg1.customizePrompts[f5_arg2])
end

local f0_local10 = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5, f6_arg6, f6_arg7, f6_arg8)
	if f6_arg1.attachmentLabels[f6_arg2] == nil then
		f6_arg1.attachmentLabels[f6_arg2] = {}
	end
	if f6_arg1.attachmentContainers[f6_arg2] == nil then
		f6_arg1.attachmentContainers[f6_arg2] = {}
	end
	if f6_arg1.attachmentImageBGs[f6_arg2] == nil then
		f6_arg1.attachmentImageBGs[f6_arg2] = {}
	end
	if f6_arg1.attachmentImages[f6_arg2] == nil then
		f6_arg1.attachmentImages[f6_arg2] = {}
	end
	local f6_local0 = f6_arg4
	local f6_local1 = f6_local0 + f6_arg6
	local f6_local2 = 0
	for f6_local3 = 1, CoD.CACUtility.maxAttachments, 1 do
		local f6_local6 = LUI.UIText.new({
			left = -1,
			top = f6_local0,
			right = 0,
			bottom = f6_local1,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			alpha = CoD.textAlpha,
			font = f6_arg5
		})
		f6_arg0:addElement(f6_local6)
		f6_arg1.attachmentLabels[f6_arg2][f6_local3] = f6_local6
		f6_local0 = f6_local0 + f6_arg6
		f6_local1 = f6_local0 + f6_arg6
		local Widget = LUI.UIElement.new({
			left = f6_local2,
			top = f6_arg3 - f6_arg7 + f6_arg8,
			right = f6_local2 + f6_arg7,
			bottom = f6_arg3 + f6_arg8,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = true
		})
		f6_arg0:addElement(Widget)
		f6_arg1.attachmentContainers[f6_arg2][f6_local3] = Widget
		local f6_local8 = LUI.UIImage.new({
			left = f6_arg8,
			top = f6_arg8,
			right = -f6_arg8,
			bottom = -f6_arg8,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true,
			alpha = lineAlpha
		})
		Widget:addElement(f6_local8)
		f6_arg1.attachmentImageBGs[f6_arg2][f6_local3] = f6_local8
		local f6_local9 = LUI.UIImage.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true
		})
		Widget:addElement(f6_local9)
		f6_arg1.attachmentImages[f6_arg2][f6_local3] = f6_local9
		f6_local2 = f6_local2 + f6_arg7
	end
	f6_arg1.modsPrompts[f6_arg2] = LUI.UIElement.new({
		left = f6_arg8,
		top = 0,
		bottom = 25,
		right = 100,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	})
	f6_arg1.attachmentContainers[f6_arg2][1]:addElement(f6_arg1.modsPrompts[f6_arg2])
end

CoD.CAC.createPanel.PrimaryWeapon = function (f7_arg0)
	local f7_local0 = -30
	local f7_local1 = 30
	local f7_local2 = 380
	local f7_local3 = 150
	local f7_local4 = f7_local1 + f7_local3
	local f7_local5 = f7_local0 - f7_local2
	local f7_local6 = 30
	local f7_local7 = 100
	local f7_local8 = f7_arg0.body.classItems
	local f7_local9 = f0_local8(f7_local5, f7_local1, f7_local0, f7_local4, f7_local2, {
		left = f7_local6,
		top = -f7_local3 - f7_local7,
		right = f7_local2 + f7_local6,
		bottom = -f7_local7,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	})
	local f7_local10 = CoD.fonts.Big
	local f7_local11 = CoD.textSize.Big
	local f7_local12 = CoD.fonts.Default
	local f7_local13 = CoD.textSize.Default
	local f7_local14 = 5
	local f7_local15 = 55
	local f7_local16 = -20
	local f7_local17 = 6
	f0_local9(f7_local9, f7_local8, "primary", f7_local16, f7_local11, f7_local13, f7_local15, f7_local17)
	local f7_local18 = 2
	local f7_local19 = f7_local3 - f7_local14
	local f7_local20 = f7_local19 * f7_local18
	local f7_local21 = 65
	f7_local8.primaryWeaponImage = LUI.UIImage.new({
		left = -f7_local20 - f7_local21,
		top = -(f7_local19 / 2),
		right = -f7_local21,
		bottom = f7_local19 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = 0
	})
	f7_local9:addElement(f7_local8.primaryWeaponImage)
	f0_local10(f7_local9, f7_local8, "primary", f7_local16, f7_local11, f7_local12, f7_local13, f7_local15, f7_local17)
	f7_local8.primaryWeaponLabel = LUI.UIText.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = f7_local11,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = CoD.textAlpha,
		font = f7_local10
	})
	f7_local9:addElement(f7_local8.primaryWeaponLabel)
	f7_local8.itemLabelTabs.primary = LUI.UIImage.new({
		left = 8,
		top = 9.5,
		right = 100,
		bottom = f7_local11 - 8,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = 0.2
	})
	f7_local9:addElement(f7_local8.itemLabelTabs.primary)
	f7_local9.CAC = f7_arg0
	f7_local9.testState = true
	return f7_local9
end

CoD.CAC.createPanel.SecondaryWeapon = function (f8_arg0)
	local f8_local0 = -30
	local f8_local1 = 170
	local f8_local2 = 350
	local f8_local3 = 150
	local f8_local4 = f8_local1 + f8_local3
	local f8_local5 = f8_local0 - f8_local2
	local f8_local6 = 30
	local f8_local7 = 100
	local f8_local8 = f8_arg0.body.classItems
	local f8_local9 = f0_local8(f8_local5, f8_local1, f8_local0, f8_local4, f8_local2, {
		left = f8_local6,
		top = -f8_local3 - f8_local7,
		right = f8_local2 + f8_local6,
		bottom = -f8_local7,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	})
	local f8_local10 = CoD.fonts.Big
	local f8_local11 = CoD.textSize.Big * 0.75
	local f8_local12 = CoD.fonts.Default
	local f8_local13 = CoD.textSize.Default * 0.75
	local f8_local14 = 5
	local f8_local15 = 45
	local f8_local16 = -20
	local f8_local17 = 5
	f0_local9(f8_local9, f8_local8, "secondary", f8_local16, f8_local11, f8_local13, f8_local15, f8_local17)
	local f8_local18 = 2
	local f8_local19 = (f8_local3 - f8_local14) * 0.8
	local f8_local20 = f8_local19 * f8_local18
	local f8_local21 = 65
	f8_local8.secondaryWeaponImage = LUI.UIImage.new({
		left = -f8_local20 - f8_local21,
		top = -(f8_local19 / 2),
		right = -f8_local21,
		bottom = f8_local19 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = 0
	})
	f8_local9:addElement(f8_local8.secondaryWeaponImage)
	f0_local10(f8_local9, f8_local8, "secondary", f8_local16, f8_local11, f8_local12, f8_local13, f8_local15, f8_local17)
	f8_local8.secondaryWeaponLabel = LUI.UIText.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = f8_local11,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = CoD.textAlpha,
		font = f8_local10
	})
	f8_local9:addElement(f8_local8.secondaryWeaponLabel)
	f8_local8.itemLabelTabs.secondary = LUI.UIImage.new({
		left = 8,
		top = 6,
		right = 100,
		bottom = f8_local11 - 6,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = 0.2
	})
	f8_local9:addElement(f8_local8.itemLabelTabs.secondary)
	f8_local9.CAC = f8_arg0
	return f8_local9
end

CoD.CAC.createPanel.Grenades = function (f9_arg0)
	local f9_local0 = -30
	local f9_local1 = -260
	local f9_local2 = 500
	local f9_local3 = 100
	local f9_local4 = f9_local0 - f9_local2
	local f9_local5 = f9_local1 + f9_local3
	local f9_local6 = 90
	local f9_local7 = f9_arg0.body.classItems
	local f9_local8 = {
		left = 0,
		top = f9_local1,
		right = f9_local2,
		bottom = f9_local5,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	}
	local f9_local9 = {
		left = f9_local4,
		top = f9_local1,
		right = f9_local0,
		bottom = f9_local5,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = 1
	}
	local f9_local10 = {
		left = f9_local4,
		top = f9_local1 + f9_local6,
		right = f9_local0,
		bottom = f9_local5 + f9_local6,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	}
	local f9_local11 = {
		left = f9_local4 - CoD.CACClassSelection.PaneSelectionXOffset,
		top = f9_local1,
		right = f9_local0 - CoD.CACClassSelection.PaneSelectionXOffset,
		bottom = f9_local5,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = CoD.CACClassSelection.PaneSelectedAlpha
	}
	local f9_local12 = {
		left = f9_local4,
		top = f9_local1,
		right = f9_local0,
		bottom = f9_local5,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = CoD.CACClassSelection.PaneNotSelectedAlpha
	}
	local f9_local13 = CoD.MFSlidePanel.new(f9_local8)
	f9_local13:registerAnimationState("primary", f9_local9)
	f9_local13:registerAnimationState("secondary", f9_local10)
	f9_local13:registerAnimationState("selected", f9_local11)
	f9_local13:registerAnimationState("not_selected", f9_local12)
	local f9_local14 = CoD.fonts.Default
	local f9_local15 = CoD.textSize.Default
	local f9_local16 = 0
	local f9_local17 = f9_local16 - f9_local2
	local f9_local18 = 1
	local f9_local19 = 50
	local f9_local20 = f9_local19 * f9_local18
	local f9_local21 = f9_local15 + 5
	local f9_local22 = f9_local21 + f9_local19
	local f9_local23 = 10
	local f9_local24 = f9_local16 - f9_local20 * CoD.CACUtility.maxGrenades - f9_local23
	local f9_local25 = f9_local24 + f9_local20
	local f9_local26 = 30
	local f9_local27 = 22
	local f9_local28 = 22
	
	local shoulderLeftImage = LUI.UIText.new({
		left = f9_local24,
		top = f9_local26,
		right = f9_local24 + f9_local27,
		bottom = f9_local26 + f9_local28,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = 0,
		font = CoD.fonts.ExtraSmall
	})
	shoulderLeftImage:setText(CoD.buttonStrings.shoulderl)
	shoulderLeftImage:registerAnimationState("show", {
		alpha = 1
	})
	f9_local13:addElement(shoulderLeftImage)
	f9_local13.shoulderLeftImage = shoulderLeftImage
	
	local shoulderRightImage = LUI.UIText.new({
		left = -f9_local27 - f9_local23,
		top = f9_local26,
		right = -f9_local23,
		bottom = f9_local26 + f9_local28,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = 0,
		font = CoD.fonts.ExtraSmall
	})
	shoulderRightImage:setText(CoD.buttonStrings.shoulderr)
	shoulderRightImage:registerAnimationState("show", {
		alpha = 1
	})
	f9_local13:addElement(shoulderRightImage)
	f9_local13.shoulderRightImage = shoulderRightImage
	
	local f9_local31 = 80
	local f9_local32 = 30
	local f9_local33 = f9_local24 - f9_local31 - 10
	local f9_local34 = f9_local24 - 10
	local f9_local35 = 30
	
	local buttonPromptContainer = LUI.UIElement.new({
		left = f9_local33,
		top = -(f9_local32 / 2) + f9_local35,
		right = f9_local34,
		bottom = f9_local32 / 2 + f9_local35,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false
	})
	f9_local13:addElement(buttonPromptContainer)
	f9_local13.buttonPromptContainer = buttonPromptContainer
	
	for grenadeLabel = 1, CoD.CACUtility.maxGrenades, 1 do
		local Widget = LUI.UIElement.new({
			left = f9_local24,
			top = f9_local21,
			right = f9_local25,
			bottom = f9_local22,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false
		})
		f9_local13:addElement(Widget)
		local f9_local41 = LUI.UIImage.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true,
			alpha = 0.05
		})
		f9_local41:registerAnimationState("hide", {
			alpha = 0
		})
		f9_local7.grenadeImageBGs[grenadeLabel] = f9_local41
		Widget:addElement(f9_local41)
		local f9_local42 = LUI.UIImage.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true,
			alpha = 0
		})
		Widget:addElement(f9_local42)
		f9_local7.grenadeImages[grenadeLabel] = f9_local42
		local f9_local43 = LUI.UIText.new({
			left = 0,
			top = -f9_local15,
			right = 0,
			bottom = 0,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true
		})
		Widget:addElement(f9_local43)
		f9_local7.grenadeCountLabels[grenadeLabel] = f9_local43
		f9_local24 = f9_local24 + f9_local20 + f9_local23
		f9_local25 = f9_local24 + f9_local20
	end
	f9_local13:registerEventHandler("button_prompt_swap", CACClassSelection_GrenadeSwap)
	f9_local13:registerEventHandler("on_activate", CACClassSelection_GrenadeOnActivate)
	
	local grenadeLabel = LUI.UIText.new({
		left = f9_local17,
		top = 0,
		right = f9_local16,
		bottom = f9_local15,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = CoD.textAlpha,
		font = f9_local14
	})
	grenadeLabel:registerAnimationState("hide", {
		alpha = 0
	})
	f9_local13:addElement(grenadeLabel)
	f9_local7.grenadeLabel = grenadeLabel
	
	f9_local7.itemLabelTabs.grenades = LUI.UIImage.new({
		left = 8,
		top = 5,
		right = 100,
		bottom = f9_local15 - 3,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = 0.2
	})
	f9_local7.itemLabelTabs.grenades:registerAnimationState("hide", {
		alpha = 0
	})
	f9_local13:addElement(f9_local7.itemLabelTabs.grenades)
	f9_local13.CAC = f9_arg0
	return f9_local13
end

function CACClassSelection_GrenadeOnActivate(f10_arg0, f10_arg1)
	f10_arg0.CAC.body.classItems.grenadeLabel:animateToState("default")
end

function CACClassSelection_GrenadeSwap(f11_arg0, f11_arg1)
	local f11_local0 = f11_arg0.CAC
	local f11_local1 = f11_local0.m_ownerController
	local f11_local2 = CoD.perController[f11_local1].classNumInternal
	local f11_local3 = CoD.CACUtility.GetClassData(f11_local1, f11_local2)
	local f11_local4 = CoD.GetClassItem(f11_local1, f11_local2, CoD.CACUtility.loadoutSlotNames.primaryGrenade)
	local f11_local5 = CoD.CACUtility.HowManyInClassData(f11_local4, f11_local3)
	local f11_local6 = CoD.GetClassItem(f11_local1, f11_local2, CoD.CACUtility.loadoutSlotNames.specialGrenade)
	local f11_local7 = CoD.CACUtility.HowManyInClassData(f11_local6, f11_local3)
	if f11_local5 == 0 and f11_local7 == 0 then
		return 
	else
		CoD.SetClassItem(f11_local1, f11_local2, CoD.CACUtility.loadoutSlotNames.primaryGrenade, f11_local6, f11_local7)
		CoD.SetClassItem(f11_local1, f11_local2, CoD.CACUtility.loadoutSlotNames.specialGrenade, f11_local4, f11_local5)
		f11_local0:update()
		Engine.PlaySound(CoD.CAC.ButtonActionSound)
	end
end

CoD.CAC.createPanel.Perks = function (f12_arg0)
	local f12_local0 = CoD.fonts.Default
	local f12_local1 = CoD.textSize.Default
	local f12_local2 = 1
	local f12_local3 = 60
	local f12_local4 = f12_local3 * f12_local2
	local f12_local5 = -30
	local f12_local6 = -160
	local f12_local7 = f12_local4 * CoD.CACUtility.maxPerks
	local f12_local8 = f12_local1 + f12_local3
	local f12_local9 = f12_local5 - f12_local7
	local f12_local10 = f12_local6 + f12_local8
	local f12_local11 = f12_arg0.body.classItems
	local f12_local12 = f0_local8(f12_local9, f12_local6, f12_local5, f12_local10, f12_local7, nil)
	local f12_local13 = 0
	local f12_local14 = f12_local1
	local f12_local15 = f12_local1 + 5
	local f12_local16 = f12_local15 + f12_local3
	local f12_local17 = 0
	local f12_local18 = f12_local4
	for f12_local19 = 1, CoD.CACUtility.maxPerks, 1 do
		local Widget = LUI.UIElement.new({
			left = f12_local17,
			top = f12_local13,
			right = f12_local18,
			bottom = f12_local13 + f12_local1 + f12_local3,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false
		})
		f12_local12:addElement(Widget)
		local f12_local23 = LUI.UIText.new({
			left = -f12_local4,
			top = f12_local13,
			right = 0,
			bottom = f12_local14,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			font = f12_local0,
			alpha = 0
		})
		f12_local23:registerAnimationState("fade_in", {
			alpha = CoD.textAlpha
		})
		f12_local12:addElement(f12_local23)
		f12_local11.perkLabels[f12_local19] = f12_local23
		local f12_local24 = LUI.UIImage.new({
			left = -f12_local4,
			top = f12_local15,
			right = 0,
			bottom = f12_local16,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			alpha = 0
		})
		Widget:addElement(f12_local24)
		f12_local11.perkImages[f12_local19] = f12_local24
		local f12_local25 = CoD.Brackets.new(5)
		f12_local25:processEvent({
			name = "fade",
			red = 1,
			green = 1,
			blue = 1,
			alpha = 0
		})
		f12_local25:setPriority(100)
		f12_local24:addElement(f12_local25)
		f12_local11.perkBrackets[f12_local19] = f12_local25
		f12_local17 = f12_local17 + f12_local4
		f12_local18 = f12_local18 + f12_local4
	end
	f12_local12.currentPerkInFocus = 1
	local f12_local19 = LUI.UITimer.new(CoD.CACClassSelection.PerkCyclePeriod, "cycle_perks", false, f12_arg0)
	f12_arg0:registerEventHandler("cycle_perks", f0_local0)
	f12_local12:addElement(f12_local19)
	f12_local11.perkLabels[1]:animateToState("fade_in")
	f12_local11.perkBrackets[1]:processEvent({
		name = "fade",
		alpha = 1
	})
	f12_local12:registerEventHandler("on_activate", CACClassSelection_PerksOnActivate)
	f12_local12:registerEventHandler("on_deactivate", CACClassSelection_PerksOnDeactivate)
	f12_local12.align = f0_local1
	f12_local12.CAC = f12_arg0
	f12_local12.perkImageWidth = f12_local4
	f12_local12.perkPaneRight = f12_local5
	f12_local12.perkPaneTop = f12_local6
	f12_local12.perkPaneBottom = f12_local10
	f12_local11.itemLabelTabs.perks = LUI.UIImage.new({
		left = 8,
		top = 5,
		right = 100,
		bottom = f12_local1 - 3,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		alpha = 0.2
	})
	f12_local12:addElement(f12_local11.itemLabelTabs.perks)
	return f12_local12
end

function CACClassSelection_PerksOnActivate(f13_arg0, f13_arg1)
	f13_arg0.isActive = true
end

function CACClassSelection_PerksOnDeactivate(f14_arg0, f14_arg1)
	f14_arg0.CAC.body.classItems.perkLabels[f14_arg0.currentPerkInFocus]:animateToState("default", CoD.CACClassSelection.PerkFadeOutTime)
	f14_arg0.isActive = nil
end

f0_local2 = function (f15_arg0, f15_arg1)
	local f15_local0 = f15_arg0.CAC
	if f15_local0 == nil then
		return 
	end
	CoD.perController[f15_arg1.controller].classNumInternal = f15_arg0.classNumInternal
	local f15_local1 = f15_local0:getAllocationSubtitle()
	if f15_local1 ~= nil then
		f15_local1.xpBonusLabel:animateToState("hide")
		f15_local1.xpBonusText:animateToState("hide")
	end
	f15_local0:closePanel("ClassSelection")
	f15_local0:openPanel("LoadOutSelection")
	local f15_local2 = f15_local0
	local f15_local3 = f15_local0.fadeInTitle
	local f15_local4 = CoD.CACUtility.GetLoadoutNameFromIndex(f15_arg1.controller, f15_arg0.classNumInternal)
	f15_local3(f15_local2, f15_local4:get())
	f15_local0:registerEventHandler("button_prompt_back", CACLoadOut_LoadOutBack)
end

f0_local3 = function (f16_arg0, f16_arg1)
	LUI.UIButton.Over(f16_arg0, f16_arg1)
	local f16_local0 = f16_arg0.CAC
	local f16_local1 = f16_local0.m_ownerController
	local f16_local2 = f16_local0:getAllocationSubtitle()
	if f16_local2 ~= nil then
		f16_local2.xpBonusLabel:animateToState("show")
		f16_local2.xpBonusText:animateToState("show")
	end
	CoD.perController[f16_local1].classNumInternal = f16_arg0.classNumInternal
	f16_local0:update()
end

f0_local0 = function (f17_arg0, f17_arg1)
	local f17_local0 = f17_arg0:getPanel("Perks")
	if f17_local0 == nil or f17_local0.isActive ~= true then
		return 
	end
	local f17_local1 = f17_local0.currentPerkInFocus
	local f17_local2 = f17_local0.currentPerkCount
	local f17_local3 = f17_arg0.body.classItems
	if f17_local2 == 1 then
		f17_local3.perkLabels[1]:animateToState("fade_in", CoD.CACClassSelection.PerkFadeInTime)
		f17_local3.perkBrackets[1]:processEvent({
			name = "fade",
			alpha = 1,
			duration = CoD.CACClassSelection.PerkFadeInTime
		})
		f17_local0.currentPerkInFocus = 1
		return 
	end
	f17_local3.perkLabels[f17_local1]:animateToState("default", CoD.CACClassSelection.PerkFadeOutTime)
	f17_local3.perkBrackets[f17_local1]:processEvent({
		name = "fade",
		alpha = 0,
		duration = CoD.CACClassSelection.PerkFadeOutTime
	})
	f17_local1 = f17_local1 + 1
	if f17_local2 < f17_local1 then
		f17_local1 = 1
	end
	f17_local3.perkLabels[f17_local1]:animateToState("fade_in", CoD.CACClassSelection.PerkFadeInTime)
	f17_local3.perkBrackets[f17_local1]:processEvent({
		name = "fade",
		alpha = 1,
		duration = CoD.CACClassSelection.PerkFadeInTime
	})
	f17_local0.currentPerkInFocus = f17_local1
end

f0_local1 = function (f18_arg0)
	if f18_arg0.isActive == true then
		local f18_local0 = f18_arg0.perkImageWidth
		local f18_local1 = f18_arg0.perkPaneRight
		local f18_local2 = f18_arg0.perkPaneTop
		local f18_local3 = f18_arg0.perkPaneBottom
		local f18_local4 = f18_arg0.currentPerkCount
		local f18_local5 = {
			left = 0,
			top = f18_local2,
			right = f18_local0 * f18_local4,
			bottom = f18_local3,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true
		}
		local f18_local6 = {
			left = -(f18_local0 * f18_local4) + f18_local1,
			top = f18_local2,
			right = f18_local1,
			bottom = f18_local3,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true,
			alpha = 1
		}
		local f18_local7 = {
			left = -(f18_local0 * f18_local4) + f18_local1 - CoD.CACClassSelection.PaneSelectionXOffset,
			top = f18_local2,
			right = f18_local1 - CoD.CACClassSelection.PaneSelectionXOffset,
			bottom = f18_local3,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true,
			alpha = CoD.CACClassSelection.PaneSelectedAlpha
		}
		local f18_local8 = {
			left = -(f18_local0 * f18_local4) + f18_local1,
			top = f18_local2,
			right = f18_local1,
			bottom = f18_local3,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true,
			alpha = CoD.CACClassSelection.PaneNotSelectedAlpha
		}
		f18_arg0:registerAnimationState("default", f18_local5)
		f18_arg0:registerAnimationState("primary", f18_local6)
		f18_arg0:registerAnimationState("selected", f18_local7)
		f18_arg0:registerAnimationState("not_selected", f18_local8)
		f18_arg0:animateToState("primary", 250, true, true)
	end
end

f0_local7 = function (f19_arg0, f19_arg1)
	local f19_local0 = f19_arg1.controller
	for f19_local1 = 1, CoD.CACUtility.maxCustomClass, 1 do
		local f19_local4 = CoD.CACUtility.GetLoadoutNameFromIndex(f19_local0, f19_local1 - 1)
		f19_arg0.classButtons[f19_local1].label:setText(f19_local4:get())
	end
end

