require("T6.LeftRightSelector")
CoD.HardwareProfileLeftRightSelector = {}
CoD.HardwareProfileLeftRightSelector.ChangeSFX = "cac_grid_nav"
CoD.HardwareProfileLeftRightSelector.SelectionChanged = function (f1_arg0)
	Engine.SetHardwareProfileValue(f1_arg0.parentSelectorButton.m_profileVarName, f1_arg0.value)
end

CoD.HardwareProfileLeftRightSelector.AddChoice = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4)
	local f2_local0 = nil
	if f2_arg4 ~= nil then
		f2_local0 = f2_arg4
	else
		f2_local0 = CoD.HardwareProfileLeftRightSelector.SelectionChanged
	end
	CoD.LeftRightSelector.AddChoice(f2_arg0, f2_arg1, f2_local0, {
		parentSelectorButton = f2_arg0,
		value = f2_arg2,
		extraParams = f2_arg3
	})
end

CoD.HardwareProfileLeftRightSelector.GetCurrentValue = function (f3_arg0)
	return Engine.GetHardwareProfileValueAsString(f3_arg0.m_profileVarName)
end

CoD.HardwareProfileLeftRightSelector.EnableSelector = function (f4_arg0, f4_arg1)
	f4_arg0:enableCycling()
	if f4_arg0.leftArrow ~= nil then
		f4_arg0.leftArrow:animateToState("default", 0)
	end
	if f4_arg0.rightArrow ~= nil then
		f4_arg0.rightArrow:animateToState("default", 0)
	end
	f4_arg0:enable()
end

CoD.HardwareProfileLeftRightSelector.DisableSelector = function (f5_arg0, f5_arg1)
	f5_arg0:disableCycling()
	if f5_arg0.leftArrow ~= nil then
		f5_arg0.leftArrow:animateToState("disabled", 0)
	end
	if f5_arg0.rightArrow ~= nil then
		f5_arg0.rightArrow:animateToState("disabled", 0)
	end
	f5_arg0:disable()
end

CoD.HardwareProfileLeftRightSelector.new = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	if not f6_arg4 then
		f6_arg4 = CoD.HardwareProfileLeftRightSelector.ChangeSFX
	end
	local f6_local0 = CoD.LeftRightSelector.new(f6_arg0, Engine.GetHardwareProfileValueAsString(f6_arg1), f6_arg2, f6_arg3, f6_arg4)
	f6_local0.m_profileVarName = f6_arg1
	f6_local0.addChoice = CoD.HardwareProfileLeftRightSelector.AddChoice
	f6_local0.getCurrentValue = CoD.HardwareProfileLeftRightSelector.GetCurrentValue
	f6_local0.enableSelector = CoD.HardwareProfileLeftRightSelector.EnableSelector
	f6_local0.disableSelector = CoD.HardwareProfileLeftRightSelector.DisableSelector
	f6_local0:registerEventHandler("refresh_choice", CoD.LeftRightSelector.RefreshChoice)
	return f6_local0
end

