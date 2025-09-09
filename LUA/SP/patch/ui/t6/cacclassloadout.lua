require("T6.WeaponButton")
require("T6.TabbedSlotButton")
require("T6.CACMultiAttachmentsButton")
require("T6.CACMultiGrenadesButton")
require("T6.CACMultiPerksButton")
CoD.CACClassLoadout = {}
CoD.CACClassLoadout.classItems = {}
CoD.CACClassLoadout.ListWidth = 500
CoD.CACClassLoadout.PreviewListWidth = 380
CoD.CACClassLoadout.PreviewSideBuffer = 0
CoD.CACClassLoadout.MajorGridSpacing = 6
CoD.CACClassLoadout.MinorGridSpacing = 4
CoD.CACClassLoadout.AttachmentButtonSpacing = 9
CoD.CACClassLoadout.ButtonHeight = 70
CoD.CACClassLoadout.PrimaryWeaponButtonHeight = CoD.CACClassLoadout.ButtonHeight * 2 - 2 + CoD.CACClassLoadout.MinorGridSpacing
CoD.CACClassLoadout.SecondaryWeaponButtonHeight = CoD.CACClassLoadout.ButtonHeight * 1.75
CoD.CACClassLoadout.LeftSideButtonWidth = 500
CoD.CACClassLoadout.RightSideButtonWidth = 864 - CoD.CACClassLoadout.LeftSideButtonWidth + CoD.CACClassLoadout.MajorGridSpacing
CoD.CACClassLoadout.Width = CoD.CACClassLoadout.LeftSideButtonWidth + CoD.CACClassLoadout.MajorGridSpacing + CoD.CACClassLoadout.RightSideButtonWidth
CoD.CACClassLoadout.DefaultButtonAlpha = 0.4
CoD.CACClassLoadout.DefaultButtonBorderColor = {
	r = 0.18,
	g = 0.35,
	b = 0.35
}
CoD.CACClassLoadout.DefaultBackgroundAlpha = 0.4
CoD.CACClassLoadout.DefaultBackgroundColor = {
	r = 0.04,
	g = 0.08,
	b = 0.08
}
CoD.CACClassLoadout.PreviousSelection = ""
CoD.CACClassLoadout.new = function (f1_arg0, f1_arg1)
	CoD.CACUtility.SetupElementForClassData1(CoD.CACClassLoadout.classItems)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, CoD.CACClassLoadout.PreviewSideBuffer - CoD.CACClassLoadout.PreviewListWidth, CoD.CACClassLoadout.PreviewSideBuffer)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:registerAnimationState("move_to_default", {
		leftAnchor = false,
		rightAnchor = true,
		left = CoD.CACClassLoadout.PreviewSideBuffer - CoD.CACClassLoadout.PreviewListWidth,
		right = CoD.CACClassLoadout.PreviewSideBuffer,
		alpha = 1
	})
	Widget:registerAnimationState("move_offscreen_right", {
		leftAnchor = false,
		rightAnchor = false,
		left = 200,
		right = 200 + CoD.CACClassLoadout.PreviewListWidth,
		alpha = 0
	})
	Widget:registerAnimationState("move_to_center", {
		leftAnchor = false,
		rightAnchor = false,
		left = -CoD.CACClassLoadout.PreviewListWidth / 2,
		right = CoD.CACClassLoadout.PreviewListWidth / 2,
		alpha = 1
	})
	Widget.update = CoD.CACClassLoadout.Update
	Widget.addWeaponSelectOptions = CoD.CACClassLoadout.AddWeaponSelectOptions
	Widget.setNewWeaponsAvailable = CoD.CACClassLoadout.SetNewWeaponsAvailable
	Widget.setNewEquipmentAvailable = CoD.CACClassLoadout.SetNewEquipmentAvailable
	Widget.setNewPerksAvailable = CoD.CACClassLoadout.SetNewPerksAvailable
	Widget.selectElement = CoD.CACClassLoadout.SelectElement
	Widget.moveToCenter = CoD.CACClassLoadout.MoveToCenter
	Widget.moveToDefault = CoD.CACClassLoadout.MoveToDefault
	Widget.moveOffscreenRight = CoD.CACClassLoadout.MoveOffscreenRight
	Widget:registerEventHandler("weapon_button_action", CoD.CACClassLoadout.WeaponButtonAction)
	Widget:registerEventHandler("weapon_button_back", CoD.CACClassLoadout.WeaponButtonBack)
	Widget:registerEventHandler("button_prompt_unequip", CoD.CACClassLoadout.RemoveCurrentItem)
	CoD.CACClassLoadout.AddWidgets(Widget, f1_arg1)
	Widget:update(f1_arg0)
	if f1_arg1 == false then
		if CoD.CACClassLoadout.PreviousSelection == "secondary" then
			Widget.secondaryWeaponButton:processEvent({
				name = "gain_focus"
			})
		elseif CoD.CACClassLoadout.PreviousSelection == "primaryAttachments" then
			Widget.primaryWeaponAttachmentsButton:processEvent({
				name = "gain_focus"
			})
		elseif CoD.CACClassLoadout.PreviousSelection == "secondaryAttachments" then
			Widget.secondaryWeaponAttachmentsButton:processEvent({
				name = "gain_focus"
			})
		elseif CoD.CACClassLoadout.PreviousSelection == "grenades" then
			Widget.grenadesButton:processEvent({
				name = "gain_focus"
			})
		elseif CoD.CACClassLoadout.PreviousSelection == "perks" then
			Widget.perksButton:processEvent({
				name = "gain_focus"
			})
		else
			Widget.primaryWeaponButton:processEvent({
				name = "gain_focus"
			})
		end
	end
	Widget.isPreview = f1_arg1
	return Widget
end

CoD.CACClassLoadout.MoveOffscreenRight = function (f2_arg0, f2_arg1)
	if 0 < f2_arg1 then
		f2_arg0:animateToState("move_offscreen_right", f2_arg1)
	end
end

CoD.CACClassLoadout.MoveToCenter = function (f3_arg0, f3_arg1)
	f3_arg0:animateToState("move_to_center", f3_arg1)
end

CoD.CACClassLoadout.MoveToDefault = function (f4_arg0, f4_arg1)
	f4_arg0:animateToState("move_to_default", f4_arg1)
end

CoD.CACClassLoadout.AddWidgets = function (f5_arg0, f5_arg1)
	local f5_local0 = CoD.CACClassLoadout.MajorGridSpacing
	local f5_local1 = CoD.CACClassLoadout.MinorGridSpacing
	local f5_local2 = CoD.CACClassLoadout.PrimaryWeaponButtonHeight
	local f5_local3 = CoD.CACClassLoadout.SecondaryWeaponButtonHeight
	local f5_local4 = CoD.CACClassLoadout.ButtonHeight * 0.97
	local f5_local5 = CoD.CACClassLoadout.ButtonHeight + 12
	local f5_local6 = CoD.CACClassLoadout.ButtonHeight * 0.91
	local f5_local7 = CoD.CACClassLoadout.ButtonHeight / 1.5
	local f5_local8 = f5_local7
	local f5_local9 = CoD.CACClassLoadout.ButtonHeight * 0.75
	local f5_local10 = f5_local9
	local f5_local11 = CoD.CACUtility.TopAnchor
	f5_arg0.primaryWeaponButton = CoD.CACWeaponGridButton.new("primary", f5_local2, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f5_local11,
		bottom = f5_local11 + f5_local2
	})
	CoD.GrowingGridButton.SetPrimaryWeaponSubtitle(f5_arg0.primaryWeaponButton, "")
	f5_arg0.primaryWeaponButton.unequipButtonSize = nil
	f5_arg0:addElement(f5_arg0.primaryWeaponButton)
	f5_local11 = f5_local11 + f5_local2 + f5_local1
	f5_arg0.primaryWeaponAttachmentsButton = CoD.CACMultiAttachmentsButton.new("primary", f5_local9, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f5_local11,
		bottom = f5_local11 + f5_local4
	}, f5_local10, -1)
	f5_arg0:addElement(f5_arg0.primaryWeaponAttachmentsButton)
	f5_local11 = f5_local11 + f5_local4 + f5_local0
	f5_arg0.secondaryWeaponButton = CoD.CACWeaponGridButton.new("secondary", f5_local3, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f5_local11,
		bottom = f5_local11 + f5_local3
	})
	CoD.GrowingGridButton.SetSecondaryWeaponSubtitle(f5_arg0.secondaryWeaponButton, "")
	f5_arg0.secondaryWeaponButton.unequipButtonSize = nil
	f5_arg0:addElement(f5_arg0.secondaryWeaponButton)
	f5_local11 = f5_local11 + f5_local3 + f5_local1
	f5_arg0.secondaryWeaponAttachmentsButton = CoD.CACMultiAttachmentsButton.new("secondary", f5_local9, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f5_local11,
		bottom = f5_local11 + f5_local4
	}, f5_local10, -1)
	f5_arg0:addElement(f5_arg0.secondaryWeaponAttachmentsButton)
	f5_local11 = f5_local11 + f5_local4 + f5_local0
	f5_arg0.grenadesButton = CoD.CACMultiGrenadesButton.new("grenades", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f5_local11,
		bottom = f5_local11 + f5_local6
	}, f5_local7, f5_local8)
	f5_arg0.grenadesButton:setTitle(Engine.Localize("MPUI_GRENADES_AND_EQUIPMENT_CAPS"))
	f5_arg0.grenadesButton:setSubtitle("")
	f5_arg0.grenadesButton:setSubtitle2("")
	f5_arg0:addElement(f5_arg0.grenadesButton)
	f5_local11 = f5_local11 + f5_local6 + f5_local0
	f5_arg0.perksButton = CoD.CACMultiPerksButton.new("perks", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f5_local11,
		bottom = f5_local11 + f5_local5
	}, f5_local7 * 1.25, f5_local8 * 1.25)
	f5_arg0.perksButton:setTitle(Engine.Localize("MPUI_PERKS_CAPS"))
	f5_arg0.perksButton:setSubtitle("")
	f5_arg0.perksButton:setSubtitle2("")
	f5_arg0.perksButton:setSubtitle3("")
	f5_arg0:addElement(f5_arg0.perksButton)
	f5_arg0.primaryWeaponButton.navigation.up = f5_arg0.perksButton
	f5_arg0.primaryWeaponButton.navigation.down = f5_arg0.primaryWeaponAttachmentsButton
	f5_arg0.primaryWeaponAttachmentsButton.navigation.up = f5_arg0.primaryWeaponButton
	f5_arg0.primaryWeaponAttachmentsButton.navigation.down = f5_arg0.secondaryWeaponButton
	f5_arg0.secondaryWeaponButton.navigation.up = f5_arg0.primaryWeaponAttachmentsButton
	f5_arg0.secondaryWeaponButton.navigation.down = f5_arg0.secondaryWeaponAttachmentsButton
	f5_arg0.secondaryWeaponAttachmentsButton.navigation.up = f5_arg0.secondaryWeaponButton
	f5_arg0.secondaryWeaponAttachmentsButton.navigation.down = f5_arg0.grenadesButton
	f5_arg0.grenadesButton.navigation.up = f5_arg0.secondaryWeaponAttachmentsButton
	f5_arg0.grenadesButton.navigation.down = f5_arg0.perksButton
	f5_arg0.perksButton.navigation.up = f5_arg0.grenadesButton
	f5_arg0.perksButton.navigation.down = f5_arg0.primaryWeaponButton
end

CoD.CACClassLoadout.Update = function (f6_arg0, f6_arg1)
	local f6_local0 = CoD.CACClassLoadout.classItems
	local f6_local1 = CoD.perController[f6_arg1].classNumInternal
	if f6_local1 == nil then
		f6_local1 = 0
	end
	f6_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f6_arg1,
		classNum = f6_local1,
		class = CoD.CACUtility.GetClassData1(f6_arg1, f6_local1),
		preview = f6_arg0.isPreview
	})
end

CoD.CACClassLoadout.SetNewWeaponsAvailable = function (f7_arg0, f7_arg1)

end

CoD.CACClassLoadout.SetNewEquipmentAvailable = function (f8_arg0, f8_arg1)

end

CoD.CACClassLoadout.SetNewPerksAvailable = function (f9_arg0, f9_arg1)

end

