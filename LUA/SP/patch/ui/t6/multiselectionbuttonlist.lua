require("T6.ButtonList")
require("T6.MultiSelectionButton")
CoD.MultiSelectionButtonList = {}
CoD.MultiSelectionButtonList.AddButton = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = {
		left = 0,
		top = 0,
		right = 0,
		bottom = CoD.textSize.Default,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}
	if f1_arg0.buttonCount == nil then
		f1_arg0.buttonCount = 0
	end
	f1_arg0.buttonCount = f1_arg0.buttonCount + 1
	local f1_local1 = CoD.MultiSelectionButton.New(f1_local0, nil, "Default", f1_arg0.buttonCount)
	f1_local1.hintText = f1_arg2
	f1_local1.isLocked = CoD.MultiSelectionButtonList.Button_IsLocked
	f1_local1.isPurchased = CoD.MultiSelectionButtonList.Button_IsPurchased
	f1_local1.canBeUnlocked = CoD.MultiSelectionButtonList.Button_CanBeUnlocked
	f1_local1.isSelected = CoD.MultiSelectionButtonList.Button_IsSelected
	f1_local1:setPriority(f1_arg3)
	f1_local1:setLabel(f1_arg1, "Default", CoD.MultiSelectionButton.TextLeft)
	if f1_arg0.selectedMaterialName then
		f1_local1.selectedMaterialName = f1_arg0.selectedMaterialName
	end
	f1_arg0:addElementToList(f1_local1)
	CoD.ButtonList.AssociateHintTextListenerToButton(f1_local1)
	return f1_local1
end

CoD.MultiSelectionButtonList.SetMaxSelections = function (f2_arg0, f2_arg1)
	f2_arg0.maxSelections = f2_arg1
end

CoD.MultiSelectionButtonList.IncrementSelectionCount = function (f3_arg0)
	if f3_arg0.maxSelections and f3_arg0.selectionCount == f3_arg0.maxSelections then
		error("LUI Error: MultiSelectionButtonList cannot select more than " .. f3_arg0.maxSelections .. " at once.")
	else
		f3_arg0.selectionCount = f3_arg0.selectionCount + 1
	end
end

CoD.MultiSelectionButtonList.DecrementSelectionCount = function (f4_arg0)
	if f4_arg0.selectionCount > 0 then
		f4_arg0.selectionCount = f4_arg0.selectionCount - 1
	else
		error("LUI Error: MultiSelectionButtonList cannot have a selection count of less than 0.")
	end
end

CoD.MultiSelectionButtonList.UpdateSelectionCount = function (f5_arg0)
	f5_arg0.selectionCount = 0
	f5_arg0:dispatchEventToChildren({
		name = "update_selection_count"
	})
end

CoD.MultiSelectionButtonList.ClearSelectionCount = function (f6_arg0)
	f6_arg0.selectionCount = 0
end

CoD.MultiSelectionButtonList.GetLockedCount = function (f7_arg0)
	local f7_local0 = 0
	local f7_local1 = f7_arg0:getFirstChild()
	while f7_local1 ~= nil do
		if f7_local1.isLocked ~= nil and f7_local1:isLocked() == true then
			f7_local0 = f7_local0 + 1
		end
		f7_local1 = f7_local1:getNextSibling()
	end
	return f7_local0
end

CoD.MultiSelectionButtonList.Button_IsLocked = function (f8_arg0)
	return false
end

CoD.MultiSelectionButtonList.Button_IsPurchased = function (f9_arg0)
	return true
end

CoD.MultiSelectionButtonList.Button_CanBeUnlocked = function (f10_arg0)
	return false
end

CoD.MultiSelectionButtonList.Button_IsSelected = function (f11_arg0)
	return false
end

CoD.MultiSelectionButtonList.New = function (f12_arg0, f12_arg1)
	if f12_arg1 == nil then
		f12_arg1 = CoD.ButtonList.ButtonSpacing
	end
	local f12_local0 = CoD.ScrollingVerticalList.new(f12_arg0)
	f12_local0:setSpacing(f12_arg1)
	f12_local0.id = "MultiSelectionButtonList"
	f12_local0.selectionCount = 0
	f12_local0:makeFocusable()
	f12_local0:addElement(LUI.UIButtonRepeater.new("up", {
		name = "gamepad_button",
		button = "up",
		down = true
	}))
	f12_local0:addElement(LUI.UIButtonRepeater.new("down", {
		name = "gamepad_button",
		button = "down",
		down = true
	}))
	f12_local0.addButton = CoD.MultiSelectionButtonList.AddButton
	f12_local0.setMaxSelections = CoD.MultiSelectionButtonList.SetMaxSelections
	f12_local0.incrementSelectionCount = CoD.MultiSelectionButtonList.IncrementSelectionCount
	f12_local0.decrementSelectionCount = CoD.MultiSelectionButtonList.DecrementSelectionCount
	f12_local0.updateSelectionCount = CoD.MultiSelectionButtonList.UpdateSelectionCount
	f12_local0.clearSelectionCount = CoD.MultiSelectionButtonList.ClearSelectionCount
	f12_local0.getLockedCount = CoD.MultiSelectionButtonList.GetLockedCount
	f12_local0:registerEventHandler("increment_selection_count", CoD.MultiSelectionButtonList.IncrementSelectionCount)
	f12_local0:registerEventHandler("increment_locked_count", CoD.MultiSelectionButtonList.IncrementLockedCount)
	f12_local0:registerEventHandler("update_multi_selection_list", CoD.MultiSelectionButtonList.Update)
	f12_local0:registerEventHandler("can_unlock_multi_selection_button_action", CoD.MultiSelectionButtonList.CanUnlockButtonAction)
	f12_local0:registerEventHandler("cannot_unlock_multi_selection_button_action", CoD.MultiSelectionButtonList.CannotUnlockButtonAction)
	f12_local0:registerEventHandler("deselect_multi_selection_button_action", CoD.MultiSelectionButtonList.DeselectButtonAction)
	f12_local0:registerEventHandler("select_multi_selection_button_action", CoD.MultiSelectionButtonList.SelectButtonAction)
	f12_local0:registerEventHandler("can_unlock_multi_selection_button_over", CoD.MultiSelectionButtonList.CanUnlockButtonOver)
	f12_local0:registerEventHandler("cannot_unlock_multi_selection_button_over", CoD.MultiSelectionButtonList.CannotUnlockButtonOver)
	f12_local0:registerEventHandler("selected_multi_selection_button_over", CoD.MultiSelectionButtonList.SelectedButtonOver)
	f12_local0:registerEventHandler("unselected_multi_selection_button_over", CoD.MultiSelectionButtonList.UnselectedButtonOver)
	return f12_local0
end

CoD.MultiSelectionButtonList.Update = function (f13_arg0, f13_arg1)
	f13_arg0.lockedCount = 0
	f13_arg0:dispatchEventToChildren({
		name = "update_multi_selection_list_buttons",
		selectionCountAtMax = f13_arg0.selectionCount == f13_arg0.maxSelections
	})
end

CoD.MultiSelectionButtonList.CanUnlockButtonAction = function (f14_arg0, f14_arg1)
	f14_arg0:dispatchEventToParent({
		name = "can_unlock_multi_selection_button_action",
		controller = f14_arg1.controller,
		button = f14_arg1.button
	})
end

CoD.MultiSelectionButtonList.CannotUnlockButtonAction = function (f15_arg0, f15_arg1)
	f15_arg0:dispatchEventToParent({
		name = "cannot_unlock_multi_selection_button_action",
		controller = f15_arg1.controller,
		button = f15_arg1.button
	})
	Engine.PlaySound(CoD.CACUtility.denySFX)
end

CoD.MultiSelectionButtonList.DeselectButtonAction = function (f16_arg0, f16_arg1)
	if not f16_arg0.maxSelections or f16_arg0.selectionCount > 0 then
		f16_arg0:dispatchEventToParent({
			name = "deselect_multi_selection_button_action",
			controller = f16_arg1.controller,
			button = f16_arg1.button
		})
	end
end

CoD.MultiSelectionButtonList.SelectButtonAction = function (f17_arg0, f17_arg1)
	if not f17_arg0.maxSelections or f17_arg0.selectionCount < f17_arg0.maxSelections then
		f17_arg0:dispatchEventToParent({
			name = "select_multi_selection_button_action",
			controller = f17_arg1.controller,
			button = f17_arg1.button
		})
	end
end

CoD.MultiSelectionButtonList.CanUnlockButtonOver = function (f18_arg0, f18_arg1)
	f18_arg0:dispatchEventToParent({
		name = "can_unlock_multi_selection_button_over"
	})
end

CoD.MultiSelectionButtonList.CannotUnlockButtonOver = function (f19_arg0, f19_arg1)
	f19_arg0:dispatchEventToParent({
		name = "cannot_unlock_multi_selection_button_over"
	})
end

CoD.MultiSelectionButtonList.SelectedButtonOver = function (f20_arg0, f20_arg1)
	f20_arg0:dispatchEventToParent({
		name = "selected_multi_selection_button_over"
	})
end

CoD.MultiSelectionButtonList.UnselectedButtonOver = function (f21_arg0, f21_arg1)
	f21_arg0:dispatchEventToParent({
		name = "unselected_multi_selection_button_over"
	})
end

