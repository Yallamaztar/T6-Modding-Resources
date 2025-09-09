require("T6.LeftRightSelector")
CoD.DvarLeftRightSelector = {}
local f0_local0 = function (f1_arg0)
	Engine.SetDvar(f1_arg0.parentSelectorButton.m_dvarName, f1_arg0.value)
end

CoD.DvarLeftRightSelector.AddChoice = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5)
	local f2_local0 = nil
	if f2_arg5 ~= nil then
		f2_local0 = f2_arg5
	else
		f2_local0 = f0_local0
	end
	CoD.LeftRightSelector.AddChoice(f2_arg0, f2_arg2, f2_local0, {
		parentSelectorButton = f2_arg0,
		value = f2_arg3,
		extraParams = f2_arg4
	})
end

CoD.DvarLeftRightSelector.getCurrentValue = function (f3_arg0)
	return UIExpression.DvarString(nil, f3_arg0.m_dvarName)
end

CoD.DvarLeftRightSelector.new = function (LocalClientIndex, ButtonName, DvarName, Description, f4_arg4)
	local GenericSelector = CoD.LeftRightSelector.new(ButtonName, UIExpression.DvarString(nil, DvarName), Description, f4_arg4, "cac_grid_nav")
	GenericSelector.m_dvarName = DvarName
	GenericSelector.m_currentController = LocalClientIndex
	GenericSelector.addChoice = CoD.DvarLeftRightSelector.AddChoice
	GenericSelector.getCurrentValue = CoD.DvarLeftRightSelector.getCurrentValue
	return GenericSelector
end

