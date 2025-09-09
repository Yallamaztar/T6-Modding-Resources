require("T6.GameOptions")
require("T6.MultiSelectionButtonList")
local f0_local0, f0_local1, f0_local2 = nil
LUI.createMenu.RestrictItems = function (f1_arg0)
	local f1_local0 = CoD.GameOptionsMenu.New(f1_arg0, "RestrictItems")
	local f1_local1 = CoD.perController[f1_arg0].groupName
	local f1_local2 = CoD.perController[f1_arg0].loadoutSlot
	f1_local0.buttonList:close()
	f1_local0.buttonList = CoD.MultiSelectionButtonList.New()
	f1_local0.buttonList:setLeftRight(true, false, 0, CoD.ButtonList.DefaultWidth)
	f1_local0.buttonList:setTopBottom(true, true, CoD.Menu.TitleHeight, -CoD.ButtonPrompt.Height - 1)
	f1_local0.buttonList.selectedMaterialName = "menu_mp_pip_outline_x"
	f1_local0:registerEventHandler("select_multi_selection_button_action", f0_local2)
	f1_local0:registerEventHandler("deselect_multi_selection_button_action", f0_local0)
	f1_local0:addElement(f1_local0.buttonList)
	local f1_local3 = nil
	if f1_local1 then
		f1_local3 = CoD.GetUnlockablesByGroupName(f1_local1)
		f1_local0:addTitle(Engine.Localize("MENU_RESTRICT_" .. f1_local1 .. "_CAPS"))
		f1_local0.buttonList.id = "ButtonList.Restrict" .. f1_local1
	elseif f1_local2 then
		f1_local3 = CoD.GetUnlockablesBySlotName(f1_local2)
		f1_local0:addTitle(Engine.Localize("MENU_RESTRICT_" .. f1_local2 .. "_CAPS"))
		f1_local0.buttonList.id = "ButtonList.Restrict" .. f1_local2
	else
		f1_local0:addTitle(Engine.Localize("MENU_RESTRICT_ATTACHMENTS_CAPS"))
		f1_local0.buttonList.id = "ButtonList.RestrictAttachments"
		local f1_local4 = 1
		while true do
			local f1_local5 = UIExpression.GetAttachmentName(f1_arg0, f1_local4)
			if f1_local5 == "" then

			elseif Engine.GetAttachmentAllocationCost(f1_local4) >= 0 then
				local f1_local6 = f1_local0.buttonList:addButton(Engine.Localize(f1_local5))
				f1_local6.attachmentIndex = f1_local4
				f1_local6.isSelected = f0_local1
			end
			f1_local4 = f1_local4 + 1
		end
	end
	if f1_local3 then
		for f1_local8, f1_local9 in ipairs(f1_local3) do
			if not f1_local2 or Engine.GetLoadoutSlotForItem(f1_local9) == f1_local2 then
				local f1_local7 = f1_local0.buttonList:addButton(Engine.Localize(UIExpression.GetItemName(f1_arg0, f1_local9)))
				f1_local7.itemIndex = f1_local9
				f1_local7.isSelected = f0_local1
			end
		end
	end
	f1_local0.buttonList:processEvent({
		name = "update_multi_selection_list"
	})
	if not f1_local0.buttonList:restoreState() then
		f1_local0.buttonList:processEvent(LUI.UIButton.GainFocusEvent)
	end
	return f1_local0
end

f0_local0 = function (f2_arg0, f2_arg1)
	if f2_arg1.button.itemIndex then
		Engine.SetItemIndexRestricted(f2_arg1.button.itemIndex, false)
	else
		Engine.SetAttachmentIndexRestricted(f2_arg1.button.attachmentIndex, false)
	end
	f2_arg0.buttonList:processEvent({
		name = "update_multi_selection_list"
	})
end

f0_local1 = function (f3_arg0)
	if f3_arg0.itemIndex then
		return Engine.IsItemIndexRestricted(f3_arg0.itemIndex)
	else
		return Engine.IsAttachmentIndexRestricted(f3_arg0.attachmentIndex)
	end
end

f0_local2 = function (f4_arg0, f4_arg1)
	if f4_arg1.button.itemIndex then
		Engine.SetItemIndexRestricted(f4_arg1.button.itemIndex, true)
	else
		Engine.SetAttachmentIndexRestricted(f4_arg1.button.attachmentIndex, true)
	end
	f4_arg0.buttonList:processEvent({
		name = "update_multi_selection_list"
	})
end

