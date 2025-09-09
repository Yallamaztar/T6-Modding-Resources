CoD.TabbedSlotButton = {}
CoD.TabbedSlotButton.SlotTabRightSpacing = 45
CoD.TabbedSlotButton.SlotTabItemSpacing = 85
CoD.TabbedSlotButton.SlotTabBottomSpacing = 5
CoD.TabbedSlotButton.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5)
	local f1_local0 = CoD.GrowingGridButton.new(f1_arg0)
	if f1_arg1 == nil then
		f1_arg1 = CoD.SlotList.SlotHeight
	end
	if f1_arg2 == nil then
		f1_arg2 = CoD.SlotList.SlotWidth
	end
	if f1_arg3 == nil then
		f1_arg3 = CoD.TabbedSlotButton.SlotTabBottomSpacing
	end
	if f1_arg4 == nil then
		f1_arg4 = CoD.TabbedSlotButton.SlotTabItemSpacing
	end
	if f1_arg5 == nil then
		f1_arg5 = CoD.TabbedSlotButton.SlotTabRightSpacing
	end
	if f1_local0.grid then
		f1_local0.grid:close()
		f1_local0.grid = nil
	end
	if f1_local0.border then
		f1_local0.border:close()
		f1_local0.border = nil
	end
	f1_local0.itemHeight = f1_arg1
	f1_local0.itemWidth = f1_arg2
	f1_local0.itemBottom = f1_arg3
	f1_local0.spacing = f1_arg4
	f1_local0.rightSpacing = f1_arg5
	f1_local0.setSlotImage = CoD.TabbedSlotButton.SetSlotImage
	f1_local0.clearSlotImages = CoD.TabbedSlotButton.ClearSlotImages
	f1_local0.addBackgroundImage = CoD.TabbedSlotButton.AddBackgroundImage
	f1_local0.addBackgroundHighlightImage = CoD.TabbedSlotButton.AddBackgroundHighlightImage
	return f1_local0
end

CoD.TabbedSlotButton.AddBackgroundImage = function (f2_arg0, f2_arg1, f2_arg2)
	if f2_arg1 == nil then
		f2_arg1 = {
			left = 0,
			right = 0,
			top = 0,
			bottom = 0,
			leftAnchor = true,
			rightAnchor = true,
			topAnchor = true,
			bottomAnchor = true
		}
	end
	f2_arg1.alpha = 1
	f2_arg1.material = RegisterMaterial(f2_arg2)
	f2_arg0.outline = LUI.UIImage.new(f2_arg1)
	f2_arg0:addElement(f2_arg0.outline)
end

CoD.TabbedSlotButton.AddBackgroundHighlightImage = function (f3_arg0, f3_arg1, f3_arg2)
	if f3_arg1 == nil then
		f3_arg1 = {
			left = 0,
			right = 0,
			top = 0,
			bottom = 0,
			leftAnchor = true,
			rightAnchor = true,
			topAnchor = true,
			bottomAnchor = true
		}
	end
	f3_arg1.alpha = 0
	f3_arg1.material = RegisterMaterial(f3_arg2)
	f3_arg0.border = LUI.UIImage.new(f3_arg1)
	f3_arg0:addElement(f3_arg0.border)
end

CoD.TabbedSlotButton.SetSlotImage = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5)
	if not f4_arg0.slotImages then
		f4_arg0.slotImages = {}
	end
	if f4_arg0.slotImages[f4_arg2] then
		if f4_arg1 then
			f4_arg0.slotImages[f4_arg2]:beginAnimation("change_material")
			f4_arg0.slotImages[f4_arg2]:setImage(RegisterMaterial(f4_arg1))
		else
			f4_arg0.slotImages[f4_arg2]:close()
			f4_arg0.slotImages[f4_arg2] = nil
		end
		return 
	else
		local f4_local0 = (f4_arg3 - f4_arg2) * f4_arg0.spacing + f4_arg0.rightSpacing
		local f4_local1 = LUI.UIImage.new()
		f4_local1:setLeftRight(false, true, -f4_local0 - f4_arg0.itemWidth / 2, -f4_local0 + f4_arg0.itemWidth / 2)
		f4_local1:setTopBottom(false, false, -f4_arg0.itemHeight / 2 - f4_arg0.itemBottom, f4_arg0.itemHeight / 2 - f4_arg0.itemBottom)
		f4_local1:setImage(RegisterMaterial(f4_arg1))
		f4_arg0.slotImages[f4_arg2] = f4_local1
		f4_arg0:addElement(f4_local1)
	end
end

CoD.TabbedSlotButton.ClearSlotImages = function (f5_arg0)
	if f5_arg0.slotImages then
		for f5_local3, f5_local4 in pairs(f5_arg0.slotImages) do
			f5_local4:close()
			f5_local4 = nil
			f5_arg0.slotImages[f5_local3] = nil
		end
	end
end

