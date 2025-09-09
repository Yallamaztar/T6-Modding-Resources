CoD.PerkGridButton = {}
CoD.PerkGridButton.LineMaterialName = "menu_mp_cac_gren_fill"
CoD.PerkGridButton.HighlightMaterialName = "menu_mp_cac_gren_hl"
CoD.PerkGridButton.new = function (f1_arg0)
	local f1_local0 = CoD.ContentGridButton.new(f1_arg0)
	f1_local0.statIndex = f1_arg0
	f1_local0:setBottomTitle(Engine.Localize(UIExpression.GetItemName(nil, f1_arg0)))
	CoD.PerkGridButton.SetupButtonImages(f1_local0, UIExpression.GetItemImage(nil, f1_arg0))
	f1_local0:registerEventHandler("update_class", CoD.PerkGridButton.UpdateClass)
	f1_local0.gainFocusSFX = "cac_grid_nav"
	f1_local0.actionSFX = "cac_grid_equip_item"
	return f1_local0
end

CoD.PerkGridButton.SetupButtonImages = function (f2_arg0, f2_arg1)
	local f2_local0 = 75
	local f2_local1 = 75
	f2_arg0:setImage(f2_arg1, f2_local0, f2_local1)
	f2_arg0.itemImage:setTopBottom(true, false, 15, 15 + f2_local1)
	f2_arg0.background = CoD.Border.new(1, CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b, CoD.CACClassLoadout.DefaultButtonAlpha * 2, 3, 8)
	f2_arg0:addElement(f2_arg0.background)
	
	local highlight = LUI.UIImage.new()
	highlight:setLeftRight(true, true, -4, 4)
	highlight:setTopBottom(true, true, -3, 6)
	highlight:setImage(RegisterMaterial("menu_mp_cac_caro_perk_line"))
	highlight:setAlpha(0)
	f2_arg0:addElement(highlight)
	f2_arg0.highlight = highlight
	
	if f2_arg0.backgroundGradient then
		f2_arg0.backgroundGradient:setTopBottom(true, true, 8, 0)
		f2_arg0.backgroundGradient:setLeftRight(true, true, 3, -3)
	end
	if f2_arg0.grid then
		f2_arg0.grid:close()
	end
end

CoD.PerkGridButton.UpdateClass = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1.controller
	local f3_local1 = 0
	local f3_local2 = {}
	for f3_local3 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
		f3_local2[f3_local3] = CoD.GetClassItem(f3_local0, f3_local1, CoD.CACUtility.loadoutSlotNames["specialty" .. f3_local3])
	end
	if Engine.IsItemNew(f3_local0, f3_arg0.statIndex) then
		f3_arg0:setNew(true)
	else
		f3_arg0:setNew(false)
	end
	f3_arg0:setInUse(false, CoD.ContentGridButton.InUseDefaultSize.left + 3)
	if f3_arg0.lockImage == nil then
		f3_arg0:setHintText(nil, nil)
	end
	for f3_local3 = 1, #f3_local2, 1 do
		if f3_arg0.statIndex == f3_local2[f3_local3] then
			f3_arg0:setInUse(true, CoD.ContentGridButton.InUseDefaultSize.left + 3)
			f3_arg0:setHintText(Engine.Localize("SPUI_ITEM_CURRENTLY_EQUIPPED"), nil)
			break
		end
	end
	if UIExpression.IsItemLocked(f3_local0, f3_arg0.statIndex) ~= 0 then
		f3_arg0:setLocked(true, UIExpression.GetPrimaryController(), true)
	else
		f3_arg0:setLocked(false)
	end
end

