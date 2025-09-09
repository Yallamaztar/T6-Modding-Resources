require("T6.SlotList")
CoD.SlotListGridButton = {}
CoD.SlotListGridButton.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = CoD.GrowingGridButton.new(f1_arg1)
	f1_local0.id = f1_local0.id .. "." .. f1_arg0
	f1_local0:setGainFocusSFX(CoD.CACUtility.GainFocusSFX)
	f1_local0.canEdit = CoD.SlotListGridButton.CanEdit
	f1_local0.edit = CoD.SlotListGridButton.Edit
	f1_local0.setFocusToSlot = CoD.SlotListGridButton.SetFocusToSlot
	f1_local0.setSlotListButtonGainFocusSFX = CoD.SlotListGridButton.SetSlotListButtonGainFocusSFX
	if f1_arg2 == nil then
		f1_arg2 = CoD.SlotList.SlotHeight
	end
	if f1_arg3 == nil then
		f1_arg3 = CoD.SlotList.SlotWidth
	end
	local f1_local1 = 2
	if f1_arg0 == "primary" or f1_arg0 == "secondary" then
		f1_local1 = 3
	end
	f1_local0.slotList = CoD.SlotList.new({
		leftAnchor = false,
		rightAnchor = true,
		left = -(f1_arg3 * f1_local1) - CoD.SlotList.Spacing * (f1_local1 - 1),
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = -1,
		bottom = 0
	}, f1_arg3, f1_arg2)
	f1_local0:addToBody(f1_local0.slotList)
	f1_local0.slotList.id = f1_local0.slotList.id .. "." .. f1_arg0
	f1_local0.handleUnequipPrompt = CoD.SlotListGridButton.ButtonPromptUnequip
	f1_local0:registerEventHandler("button_action", CoD.SlotListGridButton.ButtonAction)
	f1_local0:registerEventHandler("button_over", CoD.SlotListGridButton.ButtonOver)
	f1_local0:registerEventHandler("slotlist_editing_stop", CoD.SlotListGridButton.SlotListEditingStop)
	f1_local0:registerEventHandler("mousemove", CoD.SlotListGridButton.MouseEvent)
	f1_local0:registerEventHandler("mousedown", CoD.SlotListGridButton.MouseEvent)
	return f1_local0
end

CoD.SlotListGridButton.CanEdit = function (f2_arg0)
	return f2_arg0.slotList:canEdit()
end

CoD.SlotListGridButton.Edit = function (f3_arg0, f3_arg1, f3_arg2)
	if f3_arg0:canEdit() then
		local f3_local0 = f3_arg0.m_eventHandlers.button_up
		f3_arg0:registerEventHandler("button_up", CoD.NullFunction)
		f3_arg0:processEvent({
			name = "lose_focus",
			controller = f3_arg1
		})
		f3_arg0:registerEventHandler("button_up", f3_local0)
	end
	f3_arg0.slotList:edit(f3_arg1, f3_arg2)
end

CoD.SlotListGridButton.SetFocusToSlot = function (f4_arg0, f4_arg1, f4_arg2)
	if f4_arg0:canEdit() then
		f4_arg0:edit(f4_arg1, f4_arg2)
	end
end

CoD.SlotListGridButton.SetSlotListButtonGainFocusSFX = function (f5_arg0, f5_arg1)
	f5_arg0.slotList:setGainFocusSFX(f5_arg1)
end

CoD.SlotListGridButton.ButtonAction = function (f6_arg0, f6_arg1)
	f6_arg0:edit(f6_arg1.controller)
end

CoD.SlotListGridButton.ButtonOver = function (f7_arg0, f7_arg1)
	if f7_arg0:canEdit() then
		local f7_local0 = f7_arg0:getParent()
		if f7_local0 then
			f7_arg0:close()
			f7_arg0:setPriority(0)
			f7_local0:addElement(f7_arg0)
		end
		for f7_local4, f7_local5 in ipairs(f7_arg0.slotList.slots) do
			f7_local5.navigation.down = f7_arg0.navigation.down
			f7_local5.navigation.up = f7_arg0.navigation.up
			if f7_local4 == 1 and CoD.CACUtility.highLightedGridButtonColumn ~= "left" then
				f7_arg0.slotList.slots[f7_local4].navigation.left = f7_arg0.navigation.left
			end
			if f7_local4 == #f7_arg0.slotList.slots and CoD.CACUtility.highLightedGridButtonColumn ~= "right" then
				f7_arg0.slotList.slots[f7_local4].navigation.right = f7_arg0.navigation.right
			end
		end
		if CoD.CACUtility.highLightedGridButtonColumn ~= CoD.CACUtility.lastHighLightedGridButtonColumn then
			if CoD.CACUtility.highLightedGridButtonColumn == "left" then
				CoD.SlotListGridButton.SetFocusToSlot(f7_arg0, f7_arg1.controller, #f7_arg0.slotList.slots)
			end
			CoD.SlotListGridButton.SetFocusToSlot(f7_arg0, f7_arg1.controller, 1)
		elseif CoD.CACUtility.highLightedGridButtonSlotIndex ~= nil then
			CoD.SlotListGridButton.SetFocusToSlot(f7_arg0, f7_arg1.controller, CoD.CACUtility.highLightedGridButtonSlotIndex)
		end
		CoD.SlotListGridButton.SetFocusToSlot(f7_arg0, f7_arg1.controller, 1)
	else
		CoD.GrowingGridButton.Over(f7_arg0, f7_arg1)
	end
end

CoD.SlotListGridButton.ButtonPromptUnequip = function (f8_arg0, f8_arg1)
	f8_arg0.slotList.slots[1]:processEvent(f8_arg1)
	CoD.GrowingGridButton.ButtonPromptUnequip(f8_arg0, f8_arg1)
end

CoD.SlotListGridButton.SlotListEditingStop = function (f9_arg0, f9_arg1)
	f9_arg0.brackets:animateToState("hide")
	f9_arg0:registerEventHandler("button_up", CoD.GrowingGridButton.Up)
	f9_arg0:processEvent({
		name = "gain_focus"
	})
	f9_arg0:dispatchEventToParent(f9_arg1)
end

CoD.SlotListGridButton.Slot_LoseFocus = function (f10_arg0, f10_arg1)
	f10_arg0:highlightSubtitle(0, true)
end

CoD.SlotListGridButton.Slot_GainFocus = function (f11_arg0, f11_arg1)
	f11_arg0:highlightSubtitle(f11_arg1.slotIndex)
end

CoD.SlotListGridButton.MouseEvent = function (f12_arg0, f12_arg1)
	f12_arg0:dispatchEventToChildren(f12_arg1)
end

