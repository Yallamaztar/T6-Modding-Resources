require("T6.LeftRightSlider")
CoD.ProfileLeftRightSlider = {}
CoD.ProfileLeftRightSlider.SetValue = function (f1_arg0, f1_arg1)
	Engine.SetProfileVar(f1_arg0.m_currentController, f1_arg0.m_profileVarName, f1_arg1)
end

CoD.ProfileLeftRightSlider.AudioSpeakerSetValue = function (f2_arg0, f2_arg1)
	Engine.SetProfileVar(f2_arg0.m_currentController, f2_arg0.m_profileVarName, f2_arg1)
	Engine.AudioSpeakerSliderUpdated(f2_arg0.m_profileVarName)
end

CoD.ProfileLeftRightSlider.new = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7)
	local f3_local0 = CoD.LeftRightSlider.new(f3_arg1, f3_arg5, nil, tonumber(UIExpression.ProfileValueAsString(f3_arg0, f3_arg2)), f3_arg3, f3_arg4, f3_arg6, f3_arg7)
	f3_local0.m_profileVarName = f3_arg2
	f3_local0.m_currentController = f3_arg0
	f3_local0:setSliderCallback(CoD.ProfileLeftRightSlider.SetValue)
	return f3_local0
end

