require("T6.SlotListGridButton")
CoD.CACAttachmentsButton = {}
CoD.CACAttachmentsButton.new = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = CoD.SlotListGridButton.new(f1_arg0, f1_arg2, math.min(f1_arg1, CoD.SlotList.SlotHeight))
	f1_local0.weaponStatName = f1_arg0
	f1_local0.id = f1_local0.id .. "Attachment"
	f1_local0.setSubtitle = CoD.CACAttachmentsButton.SetAttachmentSubTitle
	f1_local0.setSubtitle2 = CoD.CACAttachmentsButton.SetAttachmentSubTitle2
	f1_local0.setSubtitle3 = CoD.CACAttachmentsButton.SetAttachmentSubTitle3
	f1_local0.slotList.setupElementsFunction = CoD.CACAttachmentsButton.AttachmentSetup
	f1_local0.slotList.addPreviewElementsFunction = CoD.CustomClass.AddBonusCardPreviewElements
	f1_local0.border = CoD.Border.new(1, CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b, 0.5)
	f1_local0.border:hide()
	f1_local0:addElement(f1_local0.border)
	f1_local0:registerEventHandler("button_over", CoD.CACAttachmentsButton.ButtonOver)
	f1_local0:registerEventHandler("button_up", CoD.CACAttachmentsButton.ButtonUp)
	f1_local0:registerEventHandler("slotlist_button_action", CoD.CACAttachmentsButton.SlotListButtonAction)
	f1_local0:registerEventHandler("slotlist_unequip", CoD.CACAttachmentsButton.SlotListUnequip)
	f1_local0:registerEventHandler("slot_gain_focus", CoD.CACAttachmentsButton.SlotGainFocus)
	f1_local0:registerEventHandler("slot_lose_focus", CoD.CACAttachmentsButton.SlotLoseFocus)
	f1_local0:registerEventHandler("update_class", CoD.CACAttachmentsButton.UpdateClassData)
	return f1_local0
end

local f0_local0 = function (f2_arg0)
	for f2_local3, f2_local4 in ipairs(CoD.CACUtility.attachmentsWithCustReticle) do
		if f2_arg0 == f2_local4 then
			return true
		end
	end
	return false
end

CoD.CACAttachmentsButton.SlotGainFocus = function (f3_arg0, f3_arg1)
	if Engine.IsBetaBuild() then
		return 
	end
	CoD.perController[f3_arg1.controller].weaponSlot = f3_arg0.weaponStatName
	local f3_local0 = Engine.GetCustomClass(f3_arg1.controller, f3_arg0.classNum)
	local f3_local1 = f3_local0[f3_arg0.weaponStatName]
	local f3_local2 = f3_local0[f3_arg0.weaponStatName .. "attachment" .. f3_arg1.slotIndex]
	if f3_local2 ~= nil and f3_local2 ~= 0 and f0_local0(Engine.GetAttachmentRef(f3_local1, f3_local2)) then
		f3_arg0:dispatchEventToParent({
			name = "add_reticle_button",
			controller = f3_arg1.controller,
			attachmentIndex = f3_local2,
			eAttachment = Engine.GetItemAttachment(f3_local1, f3_local2)
		})
	end
end

CoD.CACAttachmentsButton.SlotLoseFocus = function (f4_arg0, f4_arg1)
	CoD.perController[f4_arg1.controller].weaponSlot = nil
	f4_arg0:dispatchEventToParent({
		name = "remove_reticle_button",
		controller = f4_arg1.controller
	})
end

CoD.CACAttachmentsButton.SetAttachmentSubTitle = function (f5_arg0, f5_arg1)
	if f5_arg1 then
		if not f5_arg0.subtitle then
			f5_arg0.subtitle = LUI.UIText.new()
			f5_arg0.subtitle:setLeftRight(true, false, CoD.GrowingGridButton.InnerBorder, CoD.GrowingGridButton.InnerBorder)
			f5_arg0.subtitle:setTopBottom(true, false, CoD.GrowingGridButton.InnerBorder, CoD.GrowingGridButton.InnerBorder + CoD.GrowingGridButton.SubtitleFontHeight)
			f5_arg0.subtitle:setFont(CoD.GrowingGridButton.SubtitleFont)
			f5_arg0.subtitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
			f5_arg0:addElement(f5_arg0.subtitle)
		end
		f5_arg0.subtitle:setText(f5_arg1)
	elseif f5_arg0.subtitle then
		f5_arg0.subtitle:close()
		f5_arg0.subtitle = nil
	end
	f5_arg0.subtitleText = f5_arg1
	CoD.GrowingGridButton.UpdateLayout(f5_arg0)
end

CoD.CACAttachmentsButton.SetAttachmentSubTitle2 = function (f6_arg0, f6_arg1)
	if f6_arg1 then
		if not f6_arg0.subtitle2 then
			f6_arg0.subtitle2 = LUI.UIText.new()
			f6_arg0.subtitle2:setLeftRight(true, false, CoD.GrowingGridButton.InnerBorder, CoD.GrowingGridButton.InnerBorder)
			f6_arg0.subtitle2:setTopBottom(true, false, CoD.GrowingGridButton.InnerBorder + CoD.GrowingGridButton.SubtitleTop, CoD.GrowingGridButton.InnerBorder + CoD.GrowingGridButton.SubtitleTop + CoD.GrowingGridButton.SubtitleFontHeight)
			f6_arg0.subtitle2:setFont(CoD.GrowingGridButton.SubtitleFont)
			f6_arg0.subtitle2:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
			f6_arg0:addElement(f6_arg0.subtitle2)
		end
		f6_arg0.subtitle2:setText(f6_arg1)
	elseif f6_arg0.subtitle2 then
		f6_arg0.subtitle2:close()
		f6_arg0.subtitle2 = nil
	end
	CoD.GrowingGridButton.UpdateLayout(f6_arg0)
end

CoD.CACAttachmentsButton.SetAttachmentSubTitle3 = function (f7_arg0, f7_arg1)
	if f7_arg1 then
		if not f7_arg0.subtitle3 then
			f7_arg0.subtitle3 = LUI.UIText.new()
			f7_arg0.subtitle3:setLeftRight(true, false, CoD.GrowingGridButton.InnerBorder, CoD.GrowingGridButton.InnerBorder)
			f7_arg0.subtitle3:setTopBottom(true, false, CoD.GrowingGridButton.InnerBorder + CoD.GrowingGridButton.SubtitleTop * 2, CoD.GrowingGridButton.InnerBorder + CoD.GrowingGridButton.SubtitleTop * 2 + CoD.GrowingGridButton.SubtitleFontHeight)
			f7_arg0.subtitle3:setFont(CoD.GrowingGridButton.SubtitleFont)
			f7_arg0.subtitle3:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
			f7_arg0:addElement(f7_arg0.subtitle3)
		end
		f7_arg0.subtitle3:setText(f7_arg1)
	elseif f7_arg0.subtitle3 then
		f7_arg0.subtitle3:close()
		f7_arg0.subtitle3 = nil
	end
	CoD.GrowingGridButton.UpdateLayout(f7_arg0)
end

CoD.CACAttachmentsButton.SetAttachmentNames = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4)
	local f8_local0 = Engine.GetCustomClass(f8_arg1, f8_arg2)
	local f8_local1 = f8_local0[f8_arg3]
	local f8_local2 = CoD.CACUtility.attachmentPointNames
	local f8_local3 = 1
	if f8_arg0.titleText then
		f8_local3 = 2
	end
	for f8_local4 = 0, 2, 1 do
		local f8_local7 = f8_local0[f8_arg3 .. "attachment" .. f8_local4 + 1]
		if f8_local7 ~= nil and f8_local7 ~= 0 then
			local f8_local8 = Engine.GetAttachmentName(f8_local1, f8_local7)
			if f8_local3 == 1 then
				f8_arg0:setSubtitle(Engine.Localize(f8_local8))
			elseif f8_local3 == 2 then
				f8_arg0:setSubtitle2(Engine.Localize(f8_local8))
			elseif f8_local3 == 3 then
				f8_arg0:setSubtitle3(Engine.Localize(f8_local8))
			end
			f8_local3 = f8_local3 + 1
		end
	end
	for f8_local4 = f8_local3, f8_arg4, 1 do
		if f8_local4 == 1 then
			f8_arg0:setSubtitle("")
		end
		if f8_local4 == 2 then
			f8_arg0:setSubtitle2("")
		end
		if f8_local4 == 3 then
			f8_arg0:setSubtitle3("")
		end
	end
end

CoD.CACAttachmentsButton.UpdateClassData = function (f9_arg0, f9_arg1)
	f9_arg0.classNum = f9_arg1.classNum
	local f9_local0 = CoD.SlotList.PopulateWithAttachments(f9_arg0.slotList, f9_arg1.controller, f9_arg1.classNum, f9_arg0.weaponStatName, f9_arg1.preview)
	if f9_local0 == 0 then
		f9_arg0:setTitle(nil)
		f9_arg0:setSubtitle2("")
		f9_arg0:setSubtitle(Engine.Localize("MPUI_ATTACHMENTS_NOT_AVAILABLE"))
		f9_arg0:setSubtitle3("")
	else
		f9_arg0:setSubtitle("")
		f9_arg0:setSubtitle2("")
		f9_arg0:setSubtitle3("")
		if f9_local0 == 3 then
			f9_arg0:setTitle(nil)
		else
			f9_arg0:setTitle(Engine.Localize("MPUI_ATTACHMENTS_CAPS"))
		end
		CoD.CACAttachmentsButton.SetAttachmentNames(f9_arg0, f9_arg1.controller, f9_arg1.classNum, f9_arg0.weaponStatName, f9_local0)
	end
	if not CoD.isSinglePlayer then
		if f9_local0 == 3 then
			f9_arg0:setNew(false)
		else
			local f9_local1 = false
			if f9_arg0.weaponStatName and f9_arg1.class and f9_arg1.class[f9_arg0.weaponStatName] then
				f9_local1 = Engine.AreAnyAttachmentsNew(f9_arg1.controller, f9_arg1.class[f9_arg0.weaponStatName])
			end
			f9_arg0:setNew(f9_local1)
		end
	end
end

CoD.CACAttachmentsButton.SlotListButtonAction = function (f10_arg0, f10_arg1)
	f10_arg0:dispatchEventToParent({
		name = "attachment_slot_chosen",
		controller = f10_arg1.controller,
		weaponSlot = f10_arg0.weaponStatName,
		slotIndex = f10_arg1.slotIndex
	})
end

CoD.CACAttachmentsButton.SlotListUnequip = function (f11_arg0, f11_arg1)
	f11_arg0:dispatchEventToParent({
		name = "remove_reticle_button",
		controller = f11_arg1.controller
	})
	CoD.CACRemoveItem.RemoveAttachment(f11_arg1.controller, CoD.perController[f11_arg1.controller].classNum, f11_arg0.weaponStatName, f11_arg1.slotIndex)
end

CoD.CACAttachmentsButton.AttachmentSetup = function (f12_arg0)
	CoD.CustomClass.SetupButtonImages(f12_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
	CoD.GrowingGridButton.SetupUnequipButton(f12_arg0, 5, 5, 20)
end

CoD.CACAttachmentsButton.ButtonOver = function (f13_arg0, f13_arg1)
	if CoD.CACUtility.highLightedGridButtonColumn ~= nil then
		CoD.CACUtility.lastHighLightedGridButtonColumn = CoD.CACUtility.highLightedGridButtonColumn
	end
	if f13_arg0.weaponStatName ~= nil and f13_arg1.controller ~= nil then
		CoD.perController[f13_arg1.controller].weaponSlot = f13_arg0.weaponStatName
	end
	CoD.CACUtility.highLightedGridButtonColumn = "left"
	CoD.SlotListGridButton.ButtonOver(f13_arg0, f13_arg1)
	if f13_arg0.slotList.numSlots < 1 then
		f13_arg0:dispatchEventToParent({
			name = "remove_select_button"
		})
		f13_arg0.border:show()
	end
end

CoD.CACAttachmentsButton.ButtonUp = function (f14_arg0, f14_arg1)
	if f14_arg0.slotList.numSlots < 1 then
		f14_arg0:dispatchEventToParent({
			name = "add_select_button"
		})
	end
	f14_arg0.border:hide()
	CoD.perController[f14_arg1.controller].weaponSlot = nil
	CoD.GrowingGridButton.Up(f14_arg0, f14_arg1)
end

