CoD.AttributeBar = {}
CoD.AttributeBar.PartMaterialName = "menu_attribute_bar_part"
CoD.AttributeBar.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	if f1_arg0 == nil then
		f1_arg0 = CoD.GetDefaultAnimationState()
	end
	local Widget = LUI.UIElement.new(f1_arg0)
	Widget.id = "AttributeBar"
	Widget.setValue = CoD.AttributeBar.SetValue
	Widget.showModifiedValue = CoD.AttributeBar.ShowModifiedValue
	Widget.m_value = 0
	Widget.m_maxValue = f1_arg3
	Widget.m_partCount = f1_arg4
	Widget.m_parts = {}
	local f1_local1 = CoD.AttributeBar.PartMaterial
	if f1_local1 == nil then
		f1_local1 = RegisterMaterial(CoD.AttributeBar.PartMaterialName)
		CoD.AttributeBar.PartMaterial = f1_local1
	end
	local f1_local2 = 0.5
	local f1_local3 = f1_arg1 / f1_arg4 * f1_local2
	local f1_local4 = 32
	local f1_local5 = f1_local3 * f1_local2
	local f1_local6 = -f1_local5 / 2
	for f1_local7 = 1, f1_arg4, 1 do
		local f1_local10 = f1_local7
		local f1_local11 = LUI.UIImage.new()
		f1_local11:setLeftRight(true, false, f1_local6, f1_local6 + f1_local3)
		f1_local11:setTopBottom(false, false, -f1_local4 / 2, f1_local4 / 2)
		f1_local11:setImage(f1_local1)
		f1_local11:setRGB(1, 1, 1)
		Widget:addElement(f1_local11)
		table.insert(Widget.m_parts, f1_local11)
		f1_local6 = f1_local6 + f1_local3 - f1_local5
	end
	return Widget
end

CoD.AttributeBar.SetValue = function (f2_arg0, f2_arg1)
	f2_arg0.m_value = f2_arg1
	local f2_local0 = f2_arg1 * f2_arg0.m_partCount / f2_arg0.m_maxValue
	for f2_local4, f2_local5 in ipairs(f2_arg0.m_parts) do
		if f2_local4 <= f2_local0 then
			f2_local5:setRGB(1, 1, 1)
			f2_local5:beginAnimation("show", 250)
			f2_local5:setAlpha(1)
		else
			f2_local5:beginAnimation("hide", 250)
			f2_local5:setAlpha(0)
		end
	end
end

CoD.AttributeBar.ShowModifiedValue = function (f3_arg0, f3_arg1)
	if f3_arg1 == nil or f3_arg1 == 0 then
		return 
	end
	local f3_local0 = f3_arg0.m_value * f3_arg0.m_partCount / f3_arg0.m_maxValue
	local f3_local1 = f3_arg1 * f3_arg0.m_partCount / f3_arg0.m_maxValue
	local f3_local2 = math.max(f3_local0, f3_local0 + f3_local1)
	for f3_local6, f3_local7 in ipairs(f3_arg0.m_parts) do
		if f3_local6 <= f3_local2 then
			f3_local7:setRGB(1, 1, 1)
			f3_local7:beginAnimation("show", 250)
			f3_local7:setAlpha(1)
		else
			f3_local7:beginAnimation("hide", 250)
			f3_local7:setAlpha(0)
		end
		if f3_local1 > 0 then
			if f3_local0 < f3_local6 then
				f3_local7:setRGB(0, 1, 0)
			end
		end
		if f3_local1 < 0 and f3_local0 + f3_local1 < f3_local6 then
			f3_local7:setRGB(1, 0, 0)
		end
	end
end

