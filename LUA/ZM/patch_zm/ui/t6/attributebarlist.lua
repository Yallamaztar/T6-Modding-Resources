require("T6.AttributeBar")
CoD.AttributeBarList = {}
CoD.AttributeBarList.Spacing = 0
CoD.AttributeBarList.BarHeight = CoD.textSize.ExtraSmall
CoD.AttributeBarList.BarColor = {
	r = 1,
	g = 1,
	b = 1,
	a = 0.75
}
CoD.AttributeBarList.NegativeBarColor = {
	r = 0.7,
	g = 0.25,
	b = 0.25,
	a = 1
}
CoD.AttributeBarList.PositiveBarColor = {
	r = 0.25,
	g = 0.65,
	b = 0.25,
	a = 1
}
CoD.AttributeBarList.new = function (f1_arg0, f1_arg1, f1_arg2)
	if f1_arg2 == nil then
		f1_arg2 = CoD.AttributeBarList.Spacing
	end
	local f1_local0 = CoD.AttributeBarList.BarHeight
	f1_arg1.spacing = f1_arg2
	local f1_local1 = LUI.UIVerticalList.new(f1_arg1)
	f1_local1.barWidth = f1_arg0
	f1_local1.barHeight = f1_local0
	f1_local1.maxTextWidth = f1_arg1.right - f1_arg1.left - f1_arg0
	f1_local1.addAttributeBar = CoD.AttributeBarList.AddAttributeBar
	f1_local1.changeBarValue = CoD.AttributeBarList.ChangeBarValue
	f1_local1.showModifiedValue = CoD.AttributeBarList.ShowModifiedValue
	f1_local1.setLabel = CoD.AttributeBarList.SetLabel
	f1_local1.attributes = {}
	return f1_local1
end

CoD.AttributeBarList.SetLabel = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = f2_arg0.attributes[f2_arg1]
	if f2_local0 == nil then
		error("LUI ERROR: " .. f2_arg1 .. " bar does not exit")
		return 
	elseif f2_arg2 == nil then
		f2_arg2 = ""
	end
	f2_local0.labelText:setText(f2_arg2)
end

CoD.AttributeBarList.ShowModifiedValue = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = f3_arg0.attributes[f3_arg1]
	local f3_local1 = f3_local0.attributeBar
	if f3_local0 == nil then
		error("LUI ERROR: " .. f3_arg1 .. " bar does not exist")
		return 
	elseif f3_arg2 == nil then
		f3_arg2 = 0
	end
	f3_local1:showModifiedValue(f3_arg2)
end

CoD.AttributeBarList.ChangeBarValue = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = f4_arg0.attributes[f4_arg1]
	local f4_local1 = f4_local0.attributeBar
	if f4_arg2 == nil then
		f4_arg2 = 0
	end
	if f4_local0 == nil or f4_local1 == nil then
		error("LUI ERROR: " .. f4_arg1 .. " bar does not exist")
		return 
	elseif f4_local1.m_maxValue < f4_arg2 then
		error("LUI ERROR: setting AttributeBar to a value higher than max value")
		return 
	else
		f4_local1:setValue(f4_arg2)
	end
end

CoD.AttributeBarList.AddAttributeBar = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	if f5_arg1 == nil then
		error("LUI ERROR: name required for CoD.AttributeBarList.AddAttributeBar")
	end
	local f5_local0 = CoD.AttributeBarList.CreateAttribute(f5_arg0, f5_arg2, f5_arg3, f5_arg4)
	f5_arg0:addElement(f5_local0)
	f5_arg0.attributes[f5_arg1] = f5_local0
end

CoD.AttributeBarList.CreateAttribute = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	local f6_local0 = f6_arg0.barWidth
	local f6_local1 = f6_arg0.barHeight
	if f6_arg2 == nil then
		f6_arg2 = 0
	end
	if f6_arg3 == nil then
		f6_arg3 = 100
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, f6_local1)
	local f6_local3 = "ExtraSmall"
	local f6_local4 = {}
	f6_local4 = GetTextDimensions(f6_arg1, CoD.fonts[f6_local3], CoD.textSize[f6_local3])
	
	local labelText = LUI.UIText.new()
	labelText:setLeftRight(true, false, 0, f6_local4[3])
	labelText:setTopBottom(true, false, 0, CoD.textSize[f6_local3])
	labelText:setAlpha(0.4)
	labelText:setFont(CoD.fonts[f6_local3])
	labelText:setText(f6_arg1)
	Widget:addElement(labelText)
	Widget.labelText = labelText
	
	local f6_local6 = 32
	local f6_local7 = 32
	
	local attributeBar = LUI.UIElement.new()
	attributeBar.id = "AttributeBar"
	attributeBar:setLeftRight(true, false, f6_arg0.maxTextWidth, f6_arg0.maxTextWidth + f6_local6)
	attributeBar:setTopBottom(false, false, -f6_local7 / 2, f6_local7 / 2)
	attributeBar:setupDashes(20, 0, 0, 18)
	Widget:addElement(attributeBar)
	Widget.attributeBar = attributeBar
	
	return Widget
end

