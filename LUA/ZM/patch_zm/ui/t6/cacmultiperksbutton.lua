require("T6.SlotListGridButton")
CoD.CACMultiPerksButton = {}
CoD.CACMultiPerksButton.LineMaterialName = "menu_mp_cac_wcard_fill"
CoD.CACMultiPerksButton.HighlightMaterialName = "menu_mp_cac_wcard_hl"
CoD.CACMultiPerksButton.BackgroundMaterial = "menu_sp_cac_perks"
CoD.CACMultiPerksButton.BackgroundHLMaterial = "menu_sp_cac_perks_hl"
CoD.CACMultiPerksButton.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = "PerkCategory" .. f1_arg0
	local f1_local1 = CoD.TabbedSlotButton.new(f1_arg1, f1_arg2, f1_arg3, 0)
	f1_local1.perkCategory = f1_arg0
	f1_local1.background = CoD.BorderDipSmall.new(3, 2, CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b, CoD.CACClassLoadout.DefaultButtonAlpha, -2, 0)
	f1_local1:addElement(f1_local1.background)
	f1_local1:registerEventHandler("button_action", CoD.CACMultiPerksButton.ButtonAction)
	f1_local1:registerEventHandler("update_class", CoD.CACMultiPerksButton.UpdateClassData)
	f1_local1:registerEventHandler("button_up", CoD.CACMultiPerksButton.ButtonUp)
	f1_local1:registerEventHandler("button_over", CoD.CACMultiPerksButton.ButtonOver)
	return f1_local1
end

CoD.CACMultiPerksButton.ButtonUp = function (f2_arg0, f2_arg1)
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

CoD.CACMultiPerksButton.ButtonOver = function (f3_arg0, f3_arg1)
	f3_arg0:highlightSubtitle(1)
	f3_arg0:highlightSubtitle(2)
	f3_arg0:highlightSubtitle(3)
	CoD.GrowingGridButton.Over(f3_arg0, f3_arg1)
	if f3_arg0.background ~= nil then
		f3_arg0.background:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f3_arg0.background:setAlpha(1)
		local f3_local0 = LUI.UIImage.new()
		f3_local0:setLeftRight(true, true, -64, 68)
		f3_local0:setTopBottom(true, true, -40, 37)
		f3_local0:setImage(RegisterMaterial("menu_mp_cac_second_hl"))
		f3_arg0:addElement(f3_local0)
		f3_arg0.highlight = f3_local0
	end
end

CoD.CACMultiPerksButton.UpdateClassData = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg1.class[f4_arg0.perkCategory]
	local f4_local1 = CoD.CACUtility.maxPerksSlots
	local f4_local2 = 0
	f4_arg0:clearSlotImages()
	f4_arg0:setSubtitle("")
	f4_arg0:setSubtitle2("")
	f4_arg0:setSubtitle3("")
	for f4_local6, f4_local7 in ipairs(f4_local0) do
		if f4_local7 ~= nil then
			f4_local2 = f4_local2 + 1
			f4_arg0:setSlotImage(UIExpression.GetItemImage(nil, f4_local7.itemIndex), f4_local2 + f4_local1 - #f4_local0, f4_local1, f4_arg0.itemWidth, f4_arg0.itemHeight, 0)
			if f4_local2 == 1 then
				f4_arg0:setSubtitle(Engine.Localize(f4_local7.name))
			end
			if f4_local2 == 2 then
				f4_arg0:setSubtitle2(Engine.Localize(f4_local7.name))
			end
			if f4_local2 == 3 then
				f4_arg0:setSubtitle3(Engine.Localize(f4_local7.name))
			end
		end
	end
end

CoD.CACMultiPerksButton.ButtonAction = function (f5_arg0, f5_arg1)
	Engine.PlaySound("uin_main_enter")
	f5_arg0:dispatchEventToParent({
		name = "perk_slot_chosen",
		controller = f5_arg1.controller,
		class = f5_arg0.class
	})
end

