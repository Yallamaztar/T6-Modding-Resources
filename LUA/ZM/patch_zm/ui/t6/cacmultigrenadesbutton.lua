require("T6.SlotListGridButton")
CoD.CACMultiGrenadesButton = {}
CoD.CACMultiGrenadesButton.LineMaterialName = "menu_mp_cac_gren_fill"
CoD.CACMultiGrenadesButton.HighlightMaterialName = "menu_mp_cac_gren_hl"
CoD.CACMultiGrenadesButton.BackgroundMaterial = "menu_sp_cac_grenequip"
CoD.CACMultiGrenadesButton.BackgroundHLMaterial = "menu_sp_cac_grenequip_hl"
CoD.CACMultiGrenadesButton.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = "CACMultiGrenadesButton." .. f1_arg0
	local f1_local1 = CoD.TabbedSlotButton.new(f1_arg1, f1_arg2, f1_arg3)
	f1_local1.weaponStatName = f1_arg0
	f1_local1.background = CoD.BorderDipSmall.new(2, 2, CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b, CoD.CACClassLoadout.DefaultButtonAlpha, -2, 0)
	f1_local1:addElement(f1_local1.background)
	f1_local1:registerEventHandler("button_action", CoD.CACMultiGrenadesButton.ButtonAction)
	f1_local1:registerEventHandler("update_class", CoD.CACMultiGrenadesButton.UpdateClassData)
	f1_local1:registerEventHandler("button_up", CoD.CACMultiGrenadesButton.ButtonUp)
	f1_local1:registerEventHandler("button_over", CoD.CACMultiGrenadesButton.ButtonOver)
	return f1_local1
end

CoD.CACMultiGrenadesButton.ButtonUp = function (f2_arg0, f2_arg1)
	f2_arg0:highlightSubtitle(1, true)
	f2_arg0:highlightSubtitle(2, true)
	CoD.GrowingGridButton.Up(f2_arg0, f2_arg1)
	if f2_arg0.background ~= nil then
		f2_arg0.background:setRGB(CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b)
		f2_arg0.background:setAlpha(CoD.CACClassLoadout.DefaultButtonAlpha)
		if f2_arg0.highlight ~= nil then
			f2_arg0.highlight:close()
		end
	end
end

CoD.CACMultiGrenadesButton.ButtonOver = function (f3_arg0, f3_arg1)
	f3_arg0:highlightSubtitle(1)
	f3_arg0:highlightSubtitle(2)
	CoD.GrowingGridButton.Over(f3_arg0, f3_arg1)
	if f3_arg0.background ~= nil then
		f3_arg0.background:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f3_arg0.background:setAlpha(1)
		local f3_local0 = LUI.UIImage.new()
		f3_local0:setLeftRight(true, true, -66, 68)
		f3_local0:setTopBottom(true, true, -36, 29)
		f3_local0:setImage(RegisterMaterial("menu_mp_cac_second_line"))
		f3_arg0:addElement(f3_local0)
		f3_arg0.highlight = f3_local0
	end
end

CoD.CACMultiGrenadesButton.ButtonAction = function (f4_arg0, f4_arg1)
	Engine.PlaySound("uin_main_enter")
	f4_arg0:dispatchEventToParent({
		name = "grenades_chosen",
		controller = f4_arg1.controller,
		class = f4_arg0.class
	})
end

CoD.CACMultiGrenadesButton.UpdateClassData = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1.class[f5_arg0.weaponStatName]
	local f5_local1 = CoD.CACUtility.maxGrenades
	local f5_local2 = 0
	f5_arg0:clearSlotImages()
	for f5_local6, f5_local7 in ipairs(f5_local0) do
		if f5_local7 ~= nil then
			f5_local2 = f5_local2 + 1
			f5_arg0:setSlotImage(UIExpression.GetItemImage(nil, f5_local7.itemIndex) .. "_256", f5_local2, f5_local1, f5_arg0.itemWidth, f5_arg0.itemHeight)
			if f5_local2 == 1 then
				f5_arg0:setSubtitle(Engine.Localize(f5_local7.name))
			end
			if f5_local2 == 2 then
				f5_arg0:setSubtitle2(Engine.Localize(f5_local7.name))
			end
		end
	end
end

