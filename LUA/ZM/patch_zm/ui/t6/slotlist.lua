CoD.SlotList = {}
CoD.SlotList.Spacing = 15
CoD.SlotList.SlotHeight = 64
CoD.SlotList.SlotWidth = CoD.SlotList.SlotHeight * 1.4
CoD.SlotList.PulseSpeed = 1000
CoD.SlotList.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local Widget = LUI.UIElement.new(f1_arg0)
	Widget.id = "SlotList"
	if f1_arg1 == nil then
		f1_arg1 = CoD.SlotList.SlotWidth
	end
	if f1_arg2 == nil then
		f1_arg2 = CoD.SlotList.SlotHeight
	end
	Widget.slotWidth = f1_arg1
	Widget.slotHeight = f1_arg2
	if f1_arg3 then
		Widget.spacing = f1_arg3
	else
		Widget.spacing = CoD.SlotList.Spacing
	end
	Widget.slots = {}
	Widget.canEdit = CoD.SlotList.CanEdit
	Widget.edit = CoD.SlotList.Edit
	Widget.highlightSlot = CoD.SlotList.HighlightSlot
	Widget.update = CoD.SlotList.Update
	Widget.setGainFocusSFX = CoD.SlotList.SetGainFocusSFX
	Widget:registerEventHandler("slot_gain_focus", CoD.SlotList.SlotGainFocus)
	Widget:registerEventHandler("gain_focus", CoD.NullFunction)
	Widget:registerEventHandler("button_over", CoD.NullFunction)
	return Widget
end

CoD.SlotList.CanEdit = function (f2_arg0)
	if f2_arg0.editable == false then
		return false
	elseif f2_arg0.numSlots < 1 then
		return false
	else
		return true
	end
end

CoD.SlotList.Edit = function (f3_arg0, f3_arg1, f3_arg2)
	if not f3_arg0:canEdit() then
		if f3_arg0.numSlots >= 1 then
			f3_arg0.slots[1]:processEvent({
				name = "button_over",
				controller = f3_arg1
			})
			f3_arg0.slots[1]:processEvent({
				name = "button_action",
				controller = f3_arg1
			})
		end
		return false
	elseif f3_arg0.lastSlotInFocus == nil or f3_arg0.numSlots < f3_arg0.lastSlotInFocus then
		f3_arg0.lastSlotInFocus = 1
	end
	if f3_arg2 and f3_arg0.slots[f3_arg2] then
		f3_arg0.lastSlotInFocus = f3_arg2
	end
	f3_arg0.slots[f3_arg0.lastSlotInFocus]:processEvent({
		name = "gain_focus",
		controller = f3_arg1
	})
	f3_arg0:dispatchEventToParent({
		name = "slotlist_editing_start"
	})
	return true
end

CoD.SlotList.HighlightSlot = function (f4_arg0, f4_arg1)
	f4_arg0.slots[f4_arg1]:processEvent({
		name = "button_over"
	})
end

CoD.SlotList.Update = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5, f5_arg6)
	local f5_local0 = f5_arg1 + f5_arg2
	if f5_arg0.numSlots ~= f5_local0 then
		f5_arg0.numSlots = f5_local0
		CoD.SlotList.PopulateSlots(f5_arg0, f5_arg1, f5_arg2, f5_arg4)
	end
	CoD.SlotList.UpdateSlotImages(f5_arg0, f5_arg3, f5_arg5, f5_arg6)
end

CoD.SlotList.SetGainFocusSFX = function (f6_arg0, f6_arg1)
	f6_arg0.gainFocusSFX = f6_arg1
end

CoD.SlotList.PopulateSlots = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	local f7_local0, f7_local1 = nil
	if #f7_arg0.slots > 0 then
		for f7_local5, f7_local6 in ipairs(f7_arg0.slots) do
			if f7_local6:isInFocus() then
				f7_local0 = f7_local6
				f7_local1 = f7_local5
			end
		end
	end
	if f7_arg0.slotContainer ~= nil then
		f7_arg0.slotContainer:close()
		f7_arg0.slotContainer = nil
		f7_arg0.slots = {}
	end
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	for f7_local3 = 1, f7_arg1, 1 do
		local f7_local7 = CoD.SlotList.GetNewSlotButton(f7_arg0, f7_local3, nil, f7_arg3)
		if f7_arg0.gainFocusSFX ~= nil then
			f7_local7:setGainFocusSFX(f7_arg0.gainFocusSFX)
		end
		Widget:addElement(f7_local7)
	end
	for f7_local3 = f7_arg1 + 1, f7_arg1 + f7_arg2, 1 do
		local f7_local7 = CoD.SlotList.GetNewSlotButton(f7_arg0, f7_local3, true, f7_arg3)
		if f7_arg0.gainFocusSFX ~= nil then
			f7_local7:setGainFocusSFX(f7_arg0.gainFocusSFX)
		end
		Widget:addElement(f7_local7)
	end
	f7_arg0.slotContainer = Widget
	f7_arg0:addElement(Widget)
	if f7_local0 ~= nil and f7_arg0.slots[f7_local1] ~= nil then
		local f7_local3 = f7_arg0.slots[f7_local1]
		f7_local3.navigation.up = f7_local0.navigation.up
		f7_local3.navigation.down = f7_local0.navigation.down
		f7_local3.navigation.left = f7_local0.navigation.left
		if f7_arg0.slots[f7_local1 + 1] ~= nil then
			f7_local3.navigation.right = f7_arg0.slots[f7_local1 + 1]
		else
			f7_local3.navigation.right = f7_local3.navigation.left
		end
		f7_local3:processEvent({
			name = "gain_focus"
		})
	end
end

CoD.SlotList.UpdateSlotImages = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	for f8_local4, f8_local5 in ipairs(f8_arg0.slots) do
		local f8_local3 = nil
		if f8_arg1 then
			f8_local3 = f8_arg1[f8_local4]
		end
		if f8_local5.icon.materialName ~= f8_local3 then
			if f8_local3 and f8_local3 ~= "" then
				if f8_local5.background then
					f8_local5.background:setAlpha(1)
				end
				if f8_local5.glowGradBack then
					f8_local5.glowGradBack:animateToState("equipped")
				end
				if f8_local5.glowGradFront then
					f8_local5.glowGradFront:animateToState("equipped")
				end
				f8_local5.icon:registerAnimationState("change_material", {
					material = RegisterMaterial(f8_local3),
					alpha = 1
				})
				f8_local5.canBeRemoved = true
			else
				if f8_local5.background then
					f8_local5.background:setAlpha(0.25)
				end
				if f8_local5.glowGradBack then
					f8_local5.glowGradBack:animateToState("unequipped")
				end
				if f8_local5.glowGradFront then
					f8_local5.glowGradFront:animateToState("unequipped")
				end
				f8_local5.icon:registerAnimationState("change_material", {
					alpha = 0
				})
				f8_local5.canBeRemoved = nil
			end
			f8_local5.icon:animateToState("change_material")
			f8_local5.icon.materialName = f8_local3
		elseif f8_local3 == nil and f8_local5.background then
			f8_local5.background:setAlpha(0.25)
		end
		if f8_local5.bonusCardPreviewBackground ~= nil then
			if f8_arg3 == true then
				f8_local5.bonusCardPreviewBackground:animateToState("show")
			else
				f8_local5.bonusCardPreviewBackground:animateToState("default")
			end
		end
		if f8_local5.bonusCardPreviewBackgroundPulse ~= nil then
			if f8_arg2 == true and f8_arg3 == false then
				f8_local5.bonusCardPreviewBackgroundPulse:animateToState("show")
			else
				f8_local5.bonusCardPreviewBackgroundPulse:animateToState("default")
			end
			f8_local5.showBonuscardPreview = f8_arg2
		end
	end
end

CoD.SlotList.GetNewSlotButton = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	local f9_local0 = (f9_arg0.slotWidth + f9_arg0.spacing) * (f9_arg1 - 1)
	local f9_local1 = CoD.GrowingGridButton.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f9_local0,
		right = f9_local0 + f9_arg0.slotWidth,
		topAnchor = false,
		bottomAnchor = false,
		top = -f9_arg0.slotHeight / 2,
		bottom = f9_arg0.slotHeight / 2
	}, f9_arg0.setupElementsFunction)
	f9_local1.index = f9_arg1
	f9_local1.id = f9_local1.id .. "." .. f9_arg0.id .. ".Index" .. f9_arg1
	table.insert(f9_arg0.slots, f9_local1)
	if f9_local1.grid ~= nil then
		f9_local1.grid:close()
		f9_local1.grid = nil
	end
	if f9_arg2 then
		if f9_arg0.addPreviewElementsFunction then
			f9_arg0.addPreviewElementsFunction(f9_local1, f9_arg0, f9_arg1)
		else
			CoD.SlotList.AddBonusCardPreviewElements(f9_local1)
		end
	end
	if not f9_local1.icon then
		f9_local1.icon = LUI.UIImage.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -f9_arg0.slotHeight / 2,
			right = f9_arg0.slotHeight / 2,
			topAnchor = false,
			bottomAnchor = false,
			top = -f9_arg0.slotHeight / 2,
			bottom = f9_arg0.slotHeight / 2,
			alpha = 0
		})
		f9_local1.icon:setPriority(0)
		f9_local1.icon.id = "UIImage.Icon"
		f9_local1:addElement(f9_local1.icon)
	end
	if f9_arg0.slots[f9_arg1 - 1] ~= nil then
		f9_arg0.slots[f9_arg1 - 1].navigation.right = f9_local1
		f9_local1.navigation.left = f9_arg0.slots[f9_arg1 - 1]
	end
	f9_local1.handleUnequipPrompt = CoD.SlotList.SlotButton_Unequip
	f9_local1:registerEventHandler("button_action", CoD.SlotList.ButtonAction)
	f9_local1:registerEventHandler("button_over", CoD.SlotList.SlotButton_ButtonOver)
	f9_local1:registerEventHandler("button_up", CoD.SlotList.SlotButton_ButtonUp)
	return f9_local1
end

CoD.SlotList.AddBonusCardPreviewElements = function (f10_arg0)
	f10_arg0.bonusCardPreviewBackground = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 2,
		right = -2,
		topAnchor = true,
		bottomAnchor = true,
		top = 2,
		bottom = -2,
		red = CoD.trueOrange.r,
		green = CoD.trueOrange.g,
		blue = CoD.trueOrange.b,
		alpha = 0
	})
	f10_arg0.bonusCardPreviewBackground:registerAnimationState("show", {
		alpha = 1
	})
	f10_arg0:addElement(f10_arg0.bonusCardPreviewBackground)
	f10_arg0.bonusCardPreviewBackgroundPulse = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 2,
		right = -2,
		topAnchor = true,
		bottomAnchor = true,
		top = 2,
		bottom = -2,
		red = CoD.trueOrange.r,
		green = CoD.trueOrange.g,
		blue = CoD.trueOrange.b,
		alpha = 0
	})
	f10_arg0.bonusCardPreviewBackgroundPulse:registerAnimationState("hide", {
		alpha = 0.05
	})
	f10_arg0.bonusCardPreviewBackgroundPulse:registerAnimationState("show", {
		alpha = 0.2
	})
	f10_arg0.bonusCardPreviewBackgroundPulse:registerEventHandler("transition_complete_show", f10_arg0.bonusCardPreviewBackgroundPulse:animateToNextState("hide", CoD.SlotList.PulseSpeed))
	f10_arg0.bonusCardPreviewBackgroundPulse:registerEventHandler("transition_complete_hide", f10_arg0.bonusCardPreviewBackgroundPulse:animateToNextState("show", CoD.SlotList.PulseSpeed))
	f10_arg0:addElement(f10_arg0.bonusCardPreviewBackgroundPulse)
end

CoD.SlotList.ButtonAction = function (f11_arg0, f11_arg1)
	f11_arg0:dispatchEventToParent({
		name = "slotlist_button_action",
		slotIndex = f11_arg0.index,
		controller = f11_arg1.controller
	})
end

CoD.SlotList.ButtonPromptBack = function (f12_arg0, f12_arg1)
	f12_arg0:registerEventHandler("button_prompt_back", nil)
	f12_arg0:processEvent({
		name = "lose_focus"
	})
	f12_arg0:dispatchEventToParent({
		name = "slotlist_editing_stop"
	})
end

CoD.SlotList.SlotGainFocus = function (f13_arg0, f13_arg1)
	f13_arg0.lastSlotInFocus = f13_arg1.slotIndex
	f13_arg0:dispatchEventToParent(f13_arg1)
end

CoD.SlotList.SlotButton_ButtonOver = function (f14_arg0, f14_arg1)
	if CoD.CACUtility.highLightedGridButtonSlotIndex ~= nil then
		CoD.CACUtility.lastHighLightedGridButtonSlotIndex = CoD.CACUtility.highLightedGridButtonSlotIndex
	end
	CoD.CACUtility.highLightedGridButtonSlotIndex = f14_arg0.index
	f14_arg0:dispatchEventToParent({
		name = "slot_gain_focus",
		slotIndex = f14_arg0.index,
		controller = f14_arg1.controller
	})
	CoD.GrowingGridButton.Over(f14_arg0, f14_arg1)
end

CoD.SlotList.SlotButton_ButtonUp = function (f15_arg0, f15_arg1)
	f15_arg0:dispatchEventToParent({
		name = "slot_lose_focus",
		slotIndex = f15_arg0.index,
		controller = f15_arg1.controller
	})
	CoD.GrowingGridButton.Up(f15_arg0, f15_arg1)
end

CoD.SlotList.SlotButton_Unequip = function (f16_arg0, f16_arg1)
	f16_arg0:dispatchEventToParent({
		name = "slotlist_unequip",
		slotIndex = f16_arg0.index,
		controller = f16_arg1.controller
	})
	CoD.GrowingGridButton.ButtonPromptUnequip(f16_arg0, f16_arg1)
end

CoD.SlotList.GetAttachmentImages = function (f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = {}
	local f17_local1 = Engine.GetCustomClass(f17_arg0, f17_arg1)
	local f17_local2 = f17_local1[f17_arg2]
	for f17_local3 = 0, 2, 1 do
		local f17_local6 = f17_local1[f17_arg2 .. "attachment" .. f17_local3 + 1]
		if f17_local6 ~= nil and f17_local6 ~= 0 then
			f17_local0[f17_local3 + 1] = Engine.GetAttachmentImage(f17_local2, f17_local6)
		end
	end
	return f17_local0
end

CoD.SlotList.GetAttachmentCountByStatName = function (f18_arg0, f18_arg1, f18_arg2)
	local f18_local0 = Engine.GetCustomClass(f18_arg0, f18_arg1)
	local f18_local1 = f18_local0[f18_arg2]
	local f18_local2 = 0
	if f18_local1 ~= nil then
		f18_local2 = UIExpression.GetNumItemAttachmentsWithAttachPoint(f18_arg0, f18_local1, 0) - 1
	end
	if f18_local2 < 0 then
		f18_local2 = 0
	end
	return f18_local2
end

CoD.SlotList.PopulateWithAttachments = function (f19_arg0, f19_arg1, f19_arg2, f19_arg3, f19_arg4)
	local f19_local0 = Engine.GetCustomClass(f19_arg1, f19_arg2)
	local f19_local1 = f19_local0[f19_arg3]
	local f19_local2 = 0
	local f19_local3 = {}
	if f19_local1 ~= nil then
		f19_local3 = CoD.SlotList.GetAttachmentImages(f19_arg1, f19_arg2, f19_arg3)
		f19_local2 = CoD.SlotList.GetAttachmentCountByStatName(f19_arg1, f19_arg2, f19_arg3)
	end
	local f19_local4 = nil
	if f19_arg3 == "primary" then
		f19_local4 = 2
	else
		f19_local4 = 1
	end
	local f19_local5 = 0
	local f19_local6 = CoD.CACUtility.IsBonusCardEquippedByName(f19_local0, "bonuscard_" .. f19_arg3 .. "_gunfighter")
	if f19_local6 or f19_arg0.showBonuscardPreview then
		f19_local4 = f19_local4 + 1
		f19_local5 = 1
	end
	local f19_local7 = math.min(f19_local4, f19_local2)
	if f19_local7 ~= f19_local4 then
		f19_local5 = 0
	end
	f19_arg0:update(f19_local7 - f19_local5, f19_local5, f19_local3, f19_arg4, nil, f19_local6)
	for f19_local8 = 0, 2, 1 do
		local f19_local11 = nil
		local f19_local12 = f19_local0[f19_arg3 .. "attachment" .. f19_local8 + 1]
		if f19_local12 ~= nil and f19_local12 ~= 0 then
			local f19_local13 = Engine.GetItemAttachment(f19_local1, f19_local12)
			if f19_local13 then
				f19_local11 = Engine.IsAttachmentIndexRestricted(f19_local13)
			end
		end
		local f19_local13 = f19_arg0.slots[f19_local8 + 1]
		if f19_local13 then
			f19_local13:setRestrictedImage(f19_local11)
		end
	end
	return f19_local7
end

CoD.SlotList.GetPerkImages = function (f20_arg0, f20_arg1, f20_arg2)
	local f20_local0 = {}
	for f20_local1 = 1, f20_arg1, 1 do
		local f20_local4 = f20_arg2["specialty" .. f20_arg0 + f20_local1 - 1 * CoD.CACUtility.maxPerkCategories]
		local f20_local5 = ""
		if f20_local4 ~= nil then
			f20_local5 = UIExpression.GetItemImage(nil, f20_local4) .. "_256"
		end
		table.insert(f20_local0, f20_local5)
	end
	return f20_local0
end

CoD.SlotList.PopulateWithPerks = function (f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4, f21_arg5)
	local f21_local0 = Engine.GetCustomClass(f21_arg1, f21_arg2)
	local f21_local1 = CoD.CACUtility.IsBonusCardEquippedByName(f21_local0, "bonuscard_perk_" .. f21_arg3 .. "_greed")
	local f21_local2 = 1
	local f21_local3 = 0
	if f21_local1 or f21_arg0.showBonuscardPreview then
		f21_local2 = 2
		f21_local3 = 1
	end
	f21_arg0:update(f21_local2 - f21_local3, f21_local3, CoD.SlotList.GetPerkImages(f21_arg3, f21_local2, f21_local0), f21_arg5, nil, f21_local1)
	for f21_local4 = 1, f21_local2, 1 do
		local f21_local7 = f21_local0["specialty" .. f21_arg3 + f21_local4 - 1 * CoD.CACUtility.maxPerkCategories]
		local f21_local8 = nil
		if f21_local7 then
			f21_local8 = Engine.IsItemIndexRestricted(f21_local7)
		end
		f21_arg0.slots[f21_local4]:setRestrictedImage(f21_local8)
	end
	return f21_local2
end

CoD.SlotList.GetGrenadeImages = function (f22_arg0, f22_arg1, f22_arg2, f22_arg3)
	local f22_local0 = {}
	local f22_local1 = Engine.GetCustomClass(f22_arg0, f22_arg1)
	local f22_local2 = f22_local1[f22_arg2]
	if f22_local2 ~= nil then
		for f22_local3 = 1, f22_arg3, 1 do
			if Engine.GetClassItem(f22_arg0, f22_arg1, f22_arg2 .. "status" .. f22_local3) == 1 then
				f22_local0[f22_local3] = UIExpression.GetItemImage(nil, f22_local2) .. "_256"
			end
		end
	end
	return f22_local0
end

