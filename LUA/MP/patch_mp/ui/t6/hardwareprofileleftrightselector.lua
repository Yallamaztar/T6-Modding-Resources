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

CoD.HardwareProfileLeftRightSelector.new = function (ButtonList, HardwareVar, Description, f6_arg3, ButtonSFX)
	if not ButtonSFX then
		ButtonSFX = CoD.HardwareProfileLeftRightSelector.ChangeSFX
	end
	local GenericSelector = CoD.LeftRightSelector.new(ButtonList, Engine.GetHardwareProfileValueAsString(HardwareVar), Description, f6_arg3, ButtonSFX)
	GenericSelector.m_profileVarName = HardwareVar
	GenericSelector.addChoice = CoD.HardwareProfileLeftRightSelector.AddChoice
	GenericSelector.getCurrentValue = CoD.HardwareProfileLeftRightSelector.GetCurrentValue
	GenericSelector.enableSelector = CoD.HardwareProfileLeftRightSelector.EnableSelector
	GenericSelector.disableSelector = CoD.HardwareProfileLeftRightSelector.DisableSelector
	GenericSelector:registerEventHandler("refresh_choice", CoD.LeftRightSelector.RefreshChoice)
	return GenericSelector
end

