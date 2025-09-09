require("T6.Drc.DrcDiscreteLeftRightSlider")
CoD.DrcProfileDiscreteLeftRightSlider = {}
CoD.DrcProfileDiscreteLeftRightSlider.SliderCallback = function (f1_arg0, f1_arg1)
	Engine.SetProfileVar(f1_arg0.m_currentController, f1_arg0.m_profileVarName, f1_arg0.m_varMin + (LUI.clamp(f1_arg1, f1_arg0.m_barMin, f1_arg0.m_barMax) - f1_arg0.m_barMin) / (f1_arg0.m_barMax - f1_arg0.m_barMin) * (f1_arg0.m_varMax - f1_arg0.m_varMin))
end

CoD.DrcProfileDiscreteLeftRightSlider.RefreshValue = function (f2_arg0, f2_arg1)
	f2_arg0.m_currentValue = LUI.clamp(math.ceil(f2_arg0.m_barMin + (LUI.clamp(tonumber(UIExpression.ProfileValueAsString(f2_arg0.m_currentController, f2_arg0.m_profileVarName)), f2_arg0.m_varMin, f2_arg0.m_varMax) - f2_arg0.m_varMin) / (f2_arg0.m_varMax - f2_arg0.m_varMin) * (f2_arg0.m_barMax - f2_arg0.m_barMin) - 0.5), f2_arg0.m_barMin, f2_arg0.m_barMax)
	CoD.DrcDiscreteLeftRightSlider.UpdateBar(f2_arg0)
end

CoD.DrcProfileDiscreteLeftRightSlider.new = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8)
	if f3_arg3 == nil then
		f3_arg3 = 0
	end
	if f3_arg4 == nil then
		f3_arg4 = 1
	end
	if f3_arg5 == nil then
		f3_arg5 = 0
	end
	if f3_arg6 == nil then
		f3_arg6 = 40
	end
	local f3_local0 = CoD.DrcDiscreteLeftRightSlider.new(f3_arg1, f3_arg7, LUI.clamp(math.ceil(f3_arg5 + (LUI.clamp(tonumber(UIExpression.ProfileValueAsString(f3_arg0, f3_arg2)), f3_arg3, f3_arg4) - f3_arg3) / (f3_arg4 - f3_arg3) * (f3_arg6 - f3_arg5) - 0.5), f3_arg5, f3_arg6), f3_arg5, f3_arg6, f3_arg8)
	f3_local0.m_profileVarName = f3_arg2
	f3_local0.m_currentController = f3_arg0
	f3_local0.m_varMin = f3_arg3
	f3_local0.m_varMax = f3_arg4
	f3_local0:setSliderCallback(CoD.DrcProfileDiscreteLeftRightSlider.SliderCallback)
	f3_local0:registerEventHandler("refresh", CoD.DrcProfileDiscreteLeftRightSlider.RefreshValue)
	return f3_local0
end

