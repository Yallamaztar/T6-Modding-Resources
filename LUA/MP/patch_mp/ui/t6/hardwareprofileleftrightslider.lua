require("T6.LeftRightSlider")
CoD.HardwareProfileLeftRightSlider = {}
CoD.HardwareProfileLeftRightSlider.AdjustSFX = "cac_safearea"
local f0_local0 = function (f1_arg0, f1_arg1)
	Engine.SetHardwareProfileValue(f1_arg0.m_profileVarName, f1_arg1)
end

CoD.HardwareProfileLeftRightSlider.new = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5)
	local f2_local0 = CoD.LeftRightSlider.new(f2_arg0, f2_arg4, nil, tonumber(Engine.GetHardwareProfileValueAsString(f2_arg1)), f2_arg2, f2_arg3, f2_arg5, CoD.HardwareProfileLeftRightSlider.AdjustSFX)
	f2_local0.m_profileVarName = f2_arg1
	f2_local0:setSliderCallback(f0_local0)
	return f2_local0
end

