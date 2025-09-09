require("T6.Drc.DrcToggle")
CoD.DrcProfileToggle = {}
local f0_local0 = function (f1_arg0, f1_arg1)
	if 0 < f1_arg1 then
		Engine.SetProfileVar(f1_arg0.m_currentController, f1_arg0.m_profileVarName, "1")
	else
		Engine.SetProfileVar(f1_arg0.m_currentController, f1_arg0.m_profileVarName, "0")
	end
end

CoD.DrcProfileToggle.RefreshValue = function (f2_arg0)
	f2_arg0.m_currentValue = UIExpression.ProfileBool(f2_arg0.m_currentController, f2_arg0.m_profileVarName)
	CoD.DrcToggle.UpdateToggle(f2_arg0)
end

CoD.DrcProfileToggle.new = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4)
	local f3_local0 = CoD.DrcToggle.new(f3_arg1, f3_arg3, UIExpression.ProfileBool(f3_arg0, f3_arg2), f3_arg4)
	f3_local0.m_profileVarName = f3_arg2
	f3_local0.m_currentController = f3_arg0
	f3_local0:setToggleCallback(f0_local0)
	f3_local0:registerEventHandler("refresh", CoD.DrcProfileToggle.RefreshValue)
	return f3_local0
end

