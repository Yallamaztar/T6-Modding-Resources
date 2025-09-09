CoD.BonusCardTitle = {}
CoD.BonusCardTitle.New = function (f1_arg0)
	local Widget = LUI.UIElement.new(f1_arg0)
	Widget.id = "BonusCardTitle"
	Widget.update = CoD.BonusCardTitle.Update
	return Widget
end

CoD.BonusCardTitle.Update = function (f2_arg0, f2_arg1, f2_arg2)
	if f2_arg0.titleLabel ~= nil then
		f2_arg0.titleLabel:close()
		f2_arg0.titleLable = nil
	end
	if f2_arg0.cardNameLabel ~= nil then
		f2_arg0.cardNameLabel:close()
		f2_arg0.cardNameLabel = nil
	end
	f2_arg0.titleLabel = LUI.UITightText.new()
	f2_arg0.titleLabel:setLeftRight(true, false, 0, 10)
	f2_arg0.titleLabel:setTopBottom(true, true, 0, 0)
	f2_arg0.titleLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f2_arg0.titleLabel:setAlpha(0.5)
	f2_arg0.titleLabel:setFont(CoD.fonts.ExtraSmall)
	f2_arg0.titleLabel:setText(f2_arg1)
	f2_arg0:addElement(f2_arg0.titleLabel)
	if f2_arg2 then
		local f2_local0 = {}
		f2_local0 = GetTextDimensions(f2_arg1, CoD.fonts.Default, CoD.textSize.Default)
		local f2_local1 = f2_local0[3] + 4
		f2_arg0.cardNameLabel = LUI.UITightText.new()
		f2_arg0.cardNameLabel:setLeftRight(true, false, f2_local1, f2_local1 + 10)
		f2_arg0.cardNameLabel:setTopBottom(true, true, 0, 0)
		f2_arg0.cardNameLabel:setFont(CoD.fonts.Default)
		f2_arg0.cardNameLabel:setText(f2_arg2)
		f2_arg0.cardNameLabel:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f2_arg0:addElement(f2_arg0.cardNameLabel)
	end
end

