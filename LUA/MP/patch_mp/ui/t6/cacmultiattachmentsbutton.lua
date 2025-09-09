require("T6.SlotListGridButton")
require("T6.BorderDipSmall")
CoD.CACMultiAttachmentsButton = {}
CoD.CACMultiAttachmentsButton.LineMaterialName = "menu_mp_cac_attach_fill"
CoD.CACMultiAttachmentsButton.HighlightMaterialName = "menu_mp_cac_attach_hl"
CoD.CACMultiAttachmentsButton.PreviewMaterialName = "menu_mp_cac_attach_wc"
CoD.CACMultiAttachmentsButton.BackgroundMaterial = "menu_sp_cac_perks"
CoD.CACMultiAttachmentsButton.BackgroundHLMaterial = "menu_sp_cac_perks_hl"
CoD.CACMultiAttachmentsButton.BorderAlpha = 0.1
CoD.CACMultiAttachmentsButton.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	local f1_local0 = CoD.TabbedSlotButton.new(f1_arg2, f1_arg1, f1_arg3)
	f1_local0.weaponStatName = f1_arg0
	f1_local0.id = f1_local0.id .. "Attachment"
	f1_local0.background = CoD.BorderDipSmall.new(3, 2, CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b, CoD.CACClassLoadout.DefaultButtonAlpha, -2, 0)
	f1_local0:addElement(f1_local0.background)
	f1_local0.setSubtitle = CoD.CACMultiAttachmentsButton.SetAttachmentSubTitle
	f1_local0.setSubtitle2 = CoD.CACMultiAttachmentsButton.SetAttachmentSubTitle2
	f1_local0.setSubtitle3 = CoD.CACMultiAttachmentsButton.SetAttachmentSubTitle3
	f1_local0:registerEventHandler("button_action", CoD.CACMultiAttachmentsButton.ButtonAction)
	f1_local0:registerEventHandler("update_class", CoD.CACMultiAttachmentsButton.UpdateClassData)
	f1_local0:registerEventHandler("button_up", CoD.CACMultiAttachmentsButton.ButtonUp)
	f1_local0:registerEventHandler("button_over", CoD.CACMultiAttachmentsButton.ButtonOver)
	return f1_local0
end

CoD.CACMultiAttachmentsButton.ButtonUp = function (f2_arg0, f2_arg1)
	f2_arg0:highlightSubtitle(1, true)
	f2_arg0:highlightSubtitle(2, true)
	f2_arg0:highlightSubtitle(3, true)
	CoD.GrowingGridButton.Up(f2_arg0, f2_arg1)
	if f2_arg0.background ~= nil then
		f2_arg0.background:setRGB(CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b)
		f2_arg0.background:setAlpha(CoD.CACClassLoadout.DefaultButtonAlpha)
		if f2_arg0.highlight ~= nil then
			f2_arg0.highlight:close()
		end
	end
end

CoD.CACMultiAttachmentsButton.ButtonOver = function (f3_arg0, f3_arg1)
	f3_arg0:highlightSubtitle(1)
	f3_arg0:highlightSubtitle(2)
	f3_arg0:highlightSubtitle(3)
	CoD.GrowingGridButton.Over(f3_arg0, f3_arg1)
	if f3_arg0.background ~= nil then
		f3_arg0.background:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f3_arg0.background:setAlpha(1)
		local f3_local0 = LUI.UIImage.new()
		f3_local0:setLeftRight(true, true, -64, 68)
		f3_local0:setTopBottom(true, true, -34, 30)
		f3_local0:setImage(RegisterMaterial("menu_mp_cac_second_hl"))
		f3_arg0:addElement(f3_local0)
		f3_arg0.highlight = f3_local0
	end
end

CoD.CACMultiAttachmentsButton.SetAttachmentSubTitle = function (f4_arg0, f4_arg1)
	if f4_arg1 then
		if not f4_arg0.subtitle then
			f4_arg0.subtitle = LUI.UIText.new()
			f4_arg0.subtitle:setLeftRight(true, false, CoD.GrowingGridButton.InnerBorder, CoD.GrowingGridButton.InnerBorder)
			f4_arg0.subtitle:setTopBottom(true, false, CoD.GrowingGridButton.InnerBorder, CoD.GrowingGridButton.InnerBorder + CoD.GrowingGridButton.SubtitleFontHeight)
			f4_arg0.subtitle:setFont(CoD.GrowingGridButton.SubtitleFont)
			f4_arg0:addElement(f4_arg0.subtitle)
		end
		f4_arg0.subtitle:setText(f4_arg1)
	elseif f4_arg0.subtitle then
		f4_arg0.subtitle:close()
		f4_arg0.subtitle = nil
	end
	CoD.GrowingGridButton.UpdateLayout(f4_arg0)
end

CoD.CACMultiAttachmentsButton.SetAttachmentSubTitle2 = function (f5_arg0, f5_arg1)
	if f5_arg1 then
		if not f5_arg0.subtitle2 then
			f5_arg0.subtitle2 = LUI.UIText.new()
			f5_arg0.subtitle2:setLeftRight(true, false, CoD.GrowingGridButton.InnerBorder, CoD.GrowingGridButton.InnerBorder)
			f5_arg0.subtitle2:setTopBottom(true, false, CoD.GrowingGridButton.InnerBorder + CoD.GrowingGridButton.SubtitleTop, CoD.GrowingGridButton.InnerBorder + CoD.GrowingGridButton.SubtitleTop + CoD.GrowingGridButton.SubtitleFontHeight)
			f5_arg0.subtitle2:setFont(CoD.GrowingGridButton.SubtitleFont)
			f5_arg0:addElement(f5_arg0.subtitle2)
		end
		f5_arg0.subtitle2:setText(f5_arg1)
	elseif f5_arg0.subtitle2 then
		f5_arg0.subtitle2:close()
		f5_arg0.subtitle2 = nil
	end
	CoD.GrowingGridButton.UpdateLayout(f5_arg0)
end

CoD.CACMultiAttachmentsButton.SetAttachmentSubTitle3 = function (f6_arg0, f6_arg1)
	if f6_arg1 then
		if not f6_arg0.subtitle3 then
			f6_arg0.subtitle3 = LUI.UIText.new()
			f6_arg0.subtitle3:setLeftRight(true, false, CoD.GrowingGridButton.InnerBorder, CoD.GrowingGridButton.InnerBorder)
			f6_arg0.subtitle3:setTopBottom(true, false, CoD.GrowingGridButton.InnerBorder + CoD.GrowingGridButton.SubtitleTop * 2, CoD.GrowingGridButton.InnerBorder + CoD.GrowingGridButton.SubtitleTop * 2 + CoD.GrowingGridButton.SubtitleFontHeight)
			f6_arg0.subtitle3:setFont(CoD.GrowingGridButton.SubtitleFont)
			f6_arg0:addElement(f6_arg0.subtitle3)
		end
		f6_arg0.subtitle3:setText(f6_arg1)
	elseif f6_arg0.subtitle3 then
		f6_arg0.subtitle3:close()
		f6_arg0.subtitle3 = nil
	end
	CoD.GrowingGridButton.UpdateLayout(f6_arg0)
end

CoD.CACMultiAttachmentsButton.SetAttachmentNames = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4, f7_arg5)
	local f7_local0 = f7_arg3.primaryWeapon
	if f7_arg4 == "secondary" then
		f7_local0 = f7_arg3.secondaryWeapon
	end
	if f7_local0 == nil or f7_local0[1] == nil then
		return {}
	end
	local f7_local1 = f7_local0[1].itemIndex
	local f7_local2 = CoD.CACUtility.attachmentPointNames
	local f7_local3 = 1
	local f7_local4 = nil
	local f7_local5 = false
	for f7_local11, f7_local12 in ipairs(f7_local2) do
		local f7_local13 = CoD.GetClassItem(f7_arg1, f7_arg2, f7_arg4 .. "attachment" .. f7_local12)
		if f7_local13 ~= 0 then
			local f7_local9 = Engine.GetAttachmentName(f7_local1, f7_local13)
			if f7_local4 then
				table.insert(f7_local4, Engine.GetAttachmentImage(f7_local1, f7_local13))
			else
				local f7_local10 = {}
				f7_local4 = Engine.GetAttachmentImage(f7_local1, f7_local13)
			end
			if f7_local3 == 1 then
				f7_arg0:setSubtitle(Engine.Localize(f7_local9))
				f7_local5 = true
			elseif f7_local3 == 2 then
				f7_arg0:setSubtitle2(Engine.Localize(f7_local9))
				f7_local5 = true
			elseif f7_local3 == 3 then
				f7_arg0:setSubtitle3(Engine.Localize(f7_local9))
				f7_local5 = true
			end
			f7_local3 = f7_local3 + 1
		end
	end
	if f7_local4 then
		for f7_local11, f7_local12 in ipairs(f7_local4) do
			f7_arg0:setSlotImage(f7_local12, f7_local11 + CoD.CACUtility.maxAttachments - #f7_local4, CoD.CACUtility.maxAttachments, f7_arg0.itemWidth, f7_arg0.itemHeight)
		end
	end
	for f7_local6 = f7_local3, f7_arg5, 1 do
		if f7_local6 == 1 then
			f7_arg0:setSubtitle("")
		end
		if f7_local6 == 2 then
			f7_arg0:setSubtitle2("")
		end
		if f7_local6 == 3 then
			f7_arg0:setSubtitle3("")
		end
	end
	if f7_local5 then
		f7_arg0:setTitle(nil)
	elseif f7_arg4 == "primary" then
		f7_arg0:setTitle(Engine.Localize("MPUI_PRIMARY_ATTACHMENTS_CAPS"))
	else
		f7_arg0:setTitle(Engine.Localize("MPUI_SECONDARY_ATTACHMENTS_CAPS"))
	end
	return f7_local4
end

CoD.CACMultiAttachmentsButton.UpdateClassData = function (f8_arg0, f8_arg1)
	local f8_local0 = 0
	if f8_arg0.weaponStatName ~= "" then
		local f8_local1 = CoD.perController[f8_arg1.controller].classNumInternal
		if f8_local1 == nil then
			f8_local1 = 0
		end
		f8_local0 = Engine.GetNumAttachments(CoD.GetClassItem(f8_arg1.controller, f8_local1, f8_arg0.weaponStatName))
	end
	local f8_local1 = 0
	local f8_local2 = {}
	f8_arg0:clearSlotImages()
	if f8_local0 > 1 then
		f8_local1 = math.min(f8_local0 - 1, CoD.CACUtility.maxAttachments)
		f8_arg0:setSubtitle("")
		f8_arg0:setSubtitle2("")
		f8_arg0:setSubtitle3("")
		f8_arg0:setTitle(nil)
		f8_arg0:setHandleMouse(true)
		f8_local2 = CoD.CACMultiAttachmentsButton.SetAttachmentNames(f8_arg0, f8_arg1.controller, f8_arg1.classNum, f8_arg1.class, f8_arg0.weaponStatName, f8_local1)
	else
		f8_arg0:setTitle(nil)
		f8_arg0:setSubtitle(Engine.Localize("MPUI_ATTACHMENTS_NOT_AVAILABLE"))
		f8_arg0:setSubtitle2("")
		f8_arg0:setSubtitle3("")
		f8_arg0:setHandleMouse(false)
		if f8_arg0.navigation.up and f8_arg0.navigation.down then
			if f8_arg0:isInFocus() then
				f8_arg0:processEvent({
					name = "lose_focus"
				})
				f8_arg0.navigation.up:processEvent({
					name = "gain_focus"
				})
			end
			f8_arg0.navigation.up.navigation.down = f8_arg0.navigation.down
			f8_arg0.navigation.down.navigation.up = f8_arg0.navigation.up
			f8_arg0.navigation.up = nil
			f8_arg0.navigation.down = nil
		end
	end
end

CoD.CACMultiAttachmentsButton.ButtonAction = function (f9_arg0, f9_arg1)
	Engine.PlaySound("uin_main_enter")
	f9_arg0:dispatchEventToParent({
		name = "attachment_slot_chosen",
		controller = f9_arg1.controller,
		class = f9_arg0.class,
		weaponSlot = f9_arg0.weaponStatName
	})
end

