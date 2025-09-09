CoD.KOTH = {}
CoD.KOTH.GAMEMODEFLAG_TARGET = 1
CoD.KOTH.flagWaypointZOffset = 32
CoD.KOTHWaypoint = InheritFrom(CoD.ObjectiveWaypoint)
LUI.createMenu.gametype_koth = function (f1_arg0)
	local f1_local0 = CoD.GametypeBase.new("gametype_koth", f1_arg0)
	f1_local0.objectiveTypes.objective = CoD.KOTHWaypoint
	return f1_local0
end

CoD.KOTHWaypoint.update = function (f2_arg0, f2_arg1)
	CoD.KOTHWaypoint.super.update(f2_arg0, f2_arg1)
	if Engine.GetObjectiveState(f2_arg1.controller, f2_arg0.index) ~= CoD.OBJECTIVESTATE_ACTIVE then
		return 
	end
	local f2_local0 = Engine.GetObjectiveTeam(f2_arg1.controller, f2_arg0.index)
	local f2_local1 = Engine.GetObjectiveGamemodeFlags(f2_arg1.controller, f2_arg0.index)
	local f2_local2 = Engine.ObjectiveGetTeamUsingCount(f2_arg1.controller, f2_arg0.index)
	local f2_local3, f2_local4 = nil
	if f2_local1 == CoD.KOTH.GAMEMODEFLAG_TARGET then
		f2_local3 = "waypoint_targetneutral"
		f2_local4 = "waypoint_target"
		f2_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameWhite))
	elseif f2_local2 > 1 then
		f2_local3 = "waypoint_contested"
		f2_local4 = "waypoint_contested"
		f2_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameWhite))
	elseif f2_local0 ~= CoD.TEAM_FREE then
		if f2_arg0:isOwnedByMyTeam(f2_arg1.controller) then
			f2_local3 = "waypoint_defend"
			f2_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameGreen))
		else
			f2_local3 = "waypoint_capture"
			f2_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameRed))
		end
		f2_local4 = f2_local3
	else
		f2_local3 = "waypoint_captureneutral"
		f2_local4 = "waypoint_capture"
		f2_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameWhite))
	end
	f2_arg0.mainImage:setImage(RegisterMaterial(f2_local3))
	CoD.GametypeBase.SetCompassObjectiveIcon(f2_arg1.controller, f2_arg0.index, f2_local3, "white_" .. f2_local4)
end

CoD.KOTHWaypoint.new = function (f3_arg0, f3_arg1)
	local f3_local0 = CoD.ObjectiveWaypoint.new(f3_arg0, f3_arg1, CoD.KOTH.flagWaypointZOffset)
	f3_local0:setClass(CoD.KOTHWaypoint)
	f3_local0:registerEventHandler("objective_update_" .. Engine.GetObjectiveName(f3_arg0, f3_arg1), f3_local0.update)
	return f3_local0
end

