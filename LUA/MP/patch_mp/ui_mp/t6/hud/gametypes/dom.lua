CoD.DOM = {}
CoD.DOMObjectiveFlag = {}
CoD.DOM.flagWaypointZOffset = 100
CoD.DOMFlagWaypoint = InheritFrom(CoD.ObjectiveWaypoint)
LUI.createMenu.gametype_dom = function (f1_arg0)
	local f1_local0 = CoD.GametypeBase.new("gametype_dom", f1_arg0)
	f1_local0.objectiveTypes._a = CoD.DOMObjectiveFlag
	f1_local0.objectiveTypes._b = CoD.DOMObjectiveFlag
	f1_local0.objectiveTypes._c = CoD.DOMObjectiveFlag
	return f1_local0
end

CoD.DOMFlagWaypoint.mayShowProgress = function (f2_arg0, f2_arg1)
	return not f2_arg0:isOwnedByMyTeam(f2_arg1)
end

CoD.DOMFlagWaypoint.update = function (f3_arg0, f3_arg1)
	CoD.DOMFlagWaypoint.super.update(f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1.controller
	local f3_local1 = f3_arg0.index
	local f3_local2 = Engine.GetObjectiveName(f3_local0, f3_local1)
	if not f3_local2 then
		return 
	end
	local f3_local3, f3_local4 = nil
	if Engine.GetObjectiveTeam(f3_local0, f3_local1) ~= CoD.TEAM_FREE then
		if f3_arg0:isOwnedByMyTeam(f3_local0) then
			f3_local3 = "waypoint_defend"
			f3_local4 = f3_local3
			f3_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameGreen))
		else
			f3_local3 = "waypoint_capture"
			f3_local4 = f3_local3
			f3_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameRed))
		end
	else
		f3_local3 = "waypoint_captureneutral"
		f3_local4 = "waypoint_capture"
		f3_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameWhite))
	end
	f3_arg0.mainImage:setImage(RegisterMaterial(f3_local3 .. f3_local2))
	CoD.GametypeBase.SetCompassObjectiveIcon(f3_local0, f3_local1, f3_local3 .. f3_local2, "white_" .. f3_local4 .. f3_local2)
end

CoD.DOMObjectiveFlag.new = function (f4_arg0, f4_arg1)
	local f4_local0 = CoD.ObjectiveWaypoint.new(f4_arg0, f4_arg1, CoD.DOM.flagWaypointZOffset)
	f4_local0:setClass(CoD.DOMFlagWaypoint)
	f4_local0.snapToCenterForObjectiveTeam = false
	f4_local0:registerEventHandler("objective_update_" .. Engine.GetObjectiveName(f4_arg0, f4_arg1), f4_local0.update)
	return f4_local0
end

