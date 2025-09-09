CoD.oneflag = {}
CoD.oneflag.FlagLeft = 15
CoD.oneflag.FlagWidth = 32
CoD.oneflag.FlagHeight = 32
CoD.oneflag.FlagStatusFontName = "ExtraSmall"
CoD.oneflag.FlagStatusHeight = CoD.textSize[CoD.oneflag.FlagStatusFontName]
CoD.oneflag.FlagStatusLeft = 35
CoD.oneflag.FlagTop = 180
CoD.oneflag.baseWaypointZOffset = 100
CoD.oneflag.OBJECTIVE_FLAG_NOT_TARGET = 0
CoD.oneflag.OBJECTIVE_FLAG_TARGET = 1
CoD.oneflagObjectiveFlag = InheritFrom(CoD.ObjectiveWaypoint)
CoD.oneflagObjectiveNeutralFlag = InheritFrom(CoD.ObjectiveWaypoint)
LUI.createMenu.gametype_oneflag = function (f1_arg0)
	local f1_local0 = CoD.GametypeBase.new("gametype_oneflag", f1_arg0)
	local f1_local1 = CoD.SplitscreenScaler.new(nil, CoD.SplitscreenMultiplier)
	f1_local1:setLeftRight(true, false, 0, 0)
	f1_local1:setTopBottom(true, false, 0, 0)
	f1_local0:addElement(f1_local1)
	if Engine.IsSplitscreen() then
		CoD.oneflag.FlagLeft = 10
		CoD.oneflag.FlagTop = 135
	end
	f1_local0.objectiveTypes.allies_base = CoD.oneflagObjectiveFlag
	f1_local0.objectiveTypes.axis_base = CoD.oneflagObjectiveFlag
	f1_local0.objectiveTypes.neutral_flag = CoD.oneflagObjectiveNeutralFlag
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, CoD.oneflag.FlagLeft, CoD.oneflag.FlagLeft + CoD.oneflag.FlagWidth)
	Widget:setTopBottom(true, false, CoD.oneflag.FlagTop, CoD.oneflag.FlagTop + CoD.oneflag.FlagHeight)
	f1_local1:addElement(Widget)
	
	local friendlyFlagIcon = LUI.UIImage.new()
	friendlyFlagIcon:setLeftRight(true, true, 0, 0)
	friendlyFlagIcon:setTopBottom(true, true, 0, 0)
	friendlyFlagIcon:setImage(RegisterMaterial("hud_ctf_flag_icon_white"))
	Widget:addElement(friendlyFlagIcon)
	f1_local0.friendlyFlagIcon = friendlyFlagIcon
	
	local friendlyFlagText = LUI.UIText.new()
	friendlyFlagText:setLeftRight(true, false, CoD.oneflag.FlagStatusLeft, CoD.oneflag.FlagStatusLeft + 1)
	friendlyFlagText:setTopBottom(false, false, -CoD.oneflag.FlagStatusHeight / 2, CoD.oneflag.FlagStatusHeight / 2)
	friendlyFlagText:setFont(CoD.fonts[CoD.oneflag.FlagStatusFontName])
	friendlyFlagText:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(friendlyFlagText)
	f1_local0.friendlyFlagText = friendlyFlagText
	
	f1_local0:registerEventHandler("oneflag_flag_status_changed", CoD.oneflag.UpdateoneflagCarriers)
	return f1_local0
end

CoD.oneflag.UpdateoneflagCarriers = function (f2_arg0, f2_arg1)
	if f2_arg1.flagMaterial then
		f2_arg0.friendlyFlagIcon:setImage(RegisterMaterial(f2_arg1.flagMaterial))
		f2_arg0.friendlyFlagIcon:setAlpha(1)
	else
		f2_arg0.friendlyFlagIcon:setAlpha(0)
	end
	if f2_arg1.flagString then
		f2_arg0.friendlyFlagText:setText(f2_arg1.flagString)
		f2_arg0.friendlyFlagText:setAlpha(1)
	else
		f2_arg0.friendlyFlagText:setAlpha(0)
	end
end

CoD.oneflagObjectiveFlag.new = function (f3_arg0, f3_arg1)
	local f3_local0 = CoD.ObjectiveWaypoint.new(f3_arg0, f3_arg1, CoD.oneflag.baseWaypointZOffset)
	f3_local0:setClass(CoD.oneflagObjectiveFlag)
	f3_local0:registerEventHandler("objective_update_" .. Engine.GetObjectiveName(f3_arg0, f3_arg1), f3_local0.update)
	return f3_local0
end

CoD.oneflagObjectiveNeutralFlag.new = function (f4_arg0, f4_arg1)
	local f4_local0 = CoD.ObjectiveWaypoint.new(f4_arg0, f4_arg1, CoD.oneflag.baseWaypointZOffset)
	f4_local0:setClass(CoD.oneflagObjectiveNeutralFlag)
	f4_local0:registerEventHandler("objective_update_" .. Engine.GetObjectiveName(f4_arg0, f4_arg1), f4_local0.update)
	return f4_local0
end

CoD.oneflagObjectiveFlag.shouldShow = function (f5_arg0, f5_arg1)
	if not CoD.oneflagObjectiveFlag.super.shouldShow(f5_arg0, f5_arg1) then
		return false
	elseif Engine.GetObjectiveGamemodeFlags(f5_arg1.controller, f5_arg0.index) == CoD.oneflag.OBJECTIVE_FLAG_NOT_TARGET then
		return false
	else
		return true
	end
end

CoD.oneflagObjectiveFlag.update = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.controller
	local f6_local1 = f6_arg0.index
	local f6_local2 = Engine.ObjectiveGetTeamUsingCount(f6_local0, f6_local1)
	if Engine.GetObjectiveEntity(f6_local0, f6_local1) then
		f6_arg0.zOffset = f6_arg0.PlayerZOffset
	else
		f6_arg0.zOffset = CoD.oneflag.baseWaypointZOffset
	end
	local f6_local3, f6_local4 = nil
	if f6_arg0:isOwnedByMyTeam(f6_local0) then
		f6_local3 = "waypoint_defend"
		f6_local4 = "waypoint_defend"
		f6_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameGreen))
	else
		f6_local3 = "waypoint_target"
		f6_local4 = "waypoint_target"
		f6_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameRed))
	end
	f6_arg0.mainImage:setImage(RegisterMaterial(f6_local3))
	CoD.oneflagObjectiveFlag.super.update(f6_arg0, f6_arg1)
	if f6_arg0.alphaController:getParent() then
		CoD.GametypeBase.SetCompassObjectiveIcon(f6_local0, f6_local1, f6_local3, "white_" .. f6_local4)
		Engine.SetObjectiveIgnoreEntity(f6_local0, f6_local1, CoD.GametypeBase.mapIconType, f6_arg0.ping == true)
	else
		CoD.GametypeBase.ClearCompassObjectiveIcon(f6_local0, f6_local1)
	end
end

CoD.oneflagObjectiveNeutralFlag.shouldShow = function (f7_arg0, f7_arg1)
	if not CoD.oneflagObjectiveFlag.super.shouldShow(f7_arg0, f7_arg1) then
		return false
	else
		local f7_local0 = f7_arg1.controller
		if not f7_arg0:isOwnedByMyTeam(f7_local0) and Engine.GetObjectiveEntity(f7_local0, f7_arg0.index) and Engine.GetGametypeSetting("enemyCarrierVisible") == 0 then
			return false
		else
			return true
		end
	end
end

CoD.oneflagObjectiveNeutralFlag.update = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg1.controller
	local f8_local1 = f8_arg0.index
	local f8_local2 = Engine.ObjectiveGetTeamUsingCount(f8_local0, f8_local1)
	local f8_local3 = Engine.GetObjectiveEntity(f8_local0, f8_local1)
	if f8_local3 then
		f8_arg0.zOffset = f8_arg0.PlayerZOffset
	else
		f8_arg0.zOffset = CoD.oneflag.baseWaypointZOffset
	end
	local f8_local4, f8_local5, f8_local6, f8_local7, f8_local8 = nil
	if f8_arg0:isOwnedByMyTeam(f8_local0) then
		f8_local5 = "waypoint_escort"
		f8_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameGreen))
		f8_local6 = f8_local5
		f8_local7 = "hud_ctf_flag_icon_green"
		if f8_local3 then
			f8_local8 = Engine.GetPlayerNameForClientNum(f8_local0, f8_local3)
		end
	elseif f8_local3 then
		f8_local5 = "waypoint_kill"
		f8_local6 = f8_local5
		if Engine.GetGametypeSetting("enemyCarrierVisible") == 2 then
			f8_local4 = true
		end
		f8_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameRed))
		f8_local7 = "hud_ctf_flag_icon_red"
		if f8_local3 then
			f8_local8 = Engine.GetPlayerNameForClientNum(f8_local0, f8_local3)
		end
	else
		f8_local5 = "white_waypoint_grab"
		f8_local6 = "waypoint_grab"
		f8_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameWhite))
		f8_local7 = "hud_ctf_flag_icon_white"
		f8_local8 = Engine.Localize("MENU_NEUTRAL")
	end
	f8_arg0.mainImage:setImage(RegisterMaterial(f8_local5))
	if f8_local3 == Engine.GetPredictedClientNum(f8_local0) then
		f8_arg0:setCarryIcon(RegisterMaterial("hudicon_ctf_flag_carry_" .. Engine.GetFactionForTeam(Engine.GetObjectiveTeam(f8_local0, f8_local1))))
	else
		f8_arg0:setCarryIcon(nil)
	end
	f8_arg0:setPing(f8_local4)
	CoD.oneflagObjectiveFlag.super.update(f8_arg0, f8_arg1)
	if f8_arg0.alphaController:getParent() then
		CoD.GametypeBase.SetCompassObjectiveIcon(f8_local0, f8_local1, f8_local5, "white_" .. f8_local6)
		Engine.SetObjectiveIgnoreEntity(f8_local0, f8_local1, CoD.GametypeBase.mapIconType, f8_arg0.ping == true)
	else
		CoD.GametypeBase.ClearCompassObjectiveIcon(f8_local0, f8_local1)
	end
	if Engine.GetObjectiveState(f8_local0, f8_local1) ~= CoD.OBJECTIVESTATE_ACTIVE then
		f8_local7, f8_local8 = nil
	end
	f8_arg0:dispatchEventToParent({
		name = "oneflag_flag_status_changed",
		flagMaterial = f8_local7,
		flagString = f8_local8
	})
end

