CoD.ctf = {}
CoD.ctf.FlagLeft = 15
CoD.ctf.FlagWidth = 32
CoD.ctf.FlagHeight = 32
CoD.ctf.FlagStatusFontName = "ExtraSmall"
CoD.ctf.FlagStatusHeight = CoD.textSize[CoD.ctf.FlagStatusFontName]
CoD.ctf.FlagStatusLeft = 35
CoD.ctf.FlagTop = 180
CoD.ctf.baseWaypointZOffset = 100
CoD.ctf.OBJECTIVE_AT_BASE = 0
CoD.ctf.OBJECTIVE_FLAG_AWAY = 1
CoD.CTFObjectiveBase = InheritFrom(CoD.ObjectiveWaypoint)
CoD.CTFObjectiveFlag = InheritFrom(CoD.ObjectiveWaypoint)
LUI.createMenu.gametype_ctf = function (f1_arg0)
	local f1_local0 = CoD.GametypeBase.new("gametype_ctf", f1_arg0)
	local f1_local1 = CoD.SplitscreenScaler.new(nil, CoD.SplitscreenMultiplier)
	f1_local1:setLeftRight(true, false, 0, 0)
	f1_local1:setTopBottom(true, false, 0, 0)
	f1_local0:addElement(f1_local1)
	if Engine.IsSplitscreen() then
		CoD.ctf.FlagLeft = 10
		CoD.ctf.FlagTop = 135
	end
	f1_local0.objectiveTypes.allies_base = CoD.CTFObjectiveBase
	f1_local0.objectiveTypes.axis_base = CoD.CTFObjectiveBase
	f1_local0.objectiveTypes.allies_flag = CoD.CTFObjectiveFlag
	f1_local0.objectiveTypes.axis_flag = CoD.CTFObjectiveFlag
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, CoD.ctf.FlagLeft, CoD.ctf.FlagLeft + CoD.ctf.FlagWidth)
	Widget:setTopBottom(true, false, CoD.ctf.FlagTop, CoD.ctf.FlagTop + CoD.ctf.FlagHeight)
	f1_local1:addElement(Widget)
	local f1_local3 = LUI.UIImage.new()
	f1_local3:setLeftRight(true, true, 0, 0)
	f1_local3:setTopBottom(true, true, 0, 0)
	f1_local3:setImage(RegisterMaterial("hud_ctf_flag_icon_green"))
	Widget:addElement(f1_local3)
	
	local friendlyFlagText = LUI.UIText.new()
	friendlyFlagText:setLeftRight(true, false, CoD.ctf.FlagStatusLeft, CoD.ctf.FlagStatusLeft + 1)
	friendlyFlagText:setTopBottom(false, false, -CoD.ctf.FlagStatusHeight / 2, CoD.ctf.FlagStatusHeight / 2)
	friendlyFlagText:setFont(CoD.fonts[CoD.ctf.FlagStatusFontName])
	friendlyFlagText:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(friendlyFlagText)
	f1_local0.friendlyFlagText = friendlyFlagText
	
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, CoD.ctf.FlagLeft, CoD.ctf.FlagLeft + CoD.ctf.FlagWidth)
	Widget:setTopBottom(true, false, CoD.ctf.FlagTop + CoD.ctf.FlagHeight, CoD.ctf.FlagTop + 2 * CoD.ctf.FlagHeight)
	f1_local1:addElement(Widget)
	local f1_local6 = LUI.UIImage.new()
	f1_local6:setLeftRight(true, true, 0, 0)
	f1_local6:setTopBottom(true, true, 0, 0)
	f1_local6:setImage(RegisterMaterial("hud_ctf_flag_icon_red"))
	Widget:addElement(f1_local6)
	
	local enemyFlagText = LUI.UIText.new()
	enemyFlagText:setLeftRight(true, false, CoD.ctf.FlagStatusLeft, CoD.ctf.FlagStatusLeft + 1)
	enemyFlagText:setTopBottom(false, false, -CoD.ctf.FlagStatusHeight / 2, CoD.ctf.FlagStatusHeight / 2)
	enemyFlagText:setFont(CoD.fonts[CoD.ctf.FlagStatusFontName])
	enemyFlagText:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(enemyFlagText)
	f1_local0.enemyFlagText = enemyFlagText
	
	f1_local0:registerEventHandler("hud_update_ctf_carriers", CoD.ctf.UpdateCTFCarriers)
	return f1_local0
end

CoD.ctf.UpdateCTFCarriers = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.friendlyCarrier
	if f2_local0 then
		f2_arg0.friendlyFlagText:setText(f2_local0)
	elseif f2_arg1.friendlyFlagAway then
		f2_arg0.friendlyFlagText:setText(Engine.Localize("OBJECTIVES_FLAG_AWAY_CAPS"))
	else
		f2_arg0.friendlyFlagText:setText(Engine.Localize("OBJECTIVES_FLAG_HOME_CAPS"))
	end
	local f2_local1 = f2_arg1.enemyCarrier
	if f2_local1 then
		f2_arg0.enemyFlagText:setText(f2_local1)
	elseif f2_arg1.enemyFlagAway then
		f2_arg0.enemyFlagText:setText(Engine.Localize("OBJECTIVES_FLAG_AWAY_CAPS"))
	else
		f2_arg0.enemyFlagText:setText(Engine.Localize("OBJECTIVES_FLAG_HOME_CAPS"))
	end
end

CoD.CTFObjectiveBase.new = function (f3_arg0, f3_arg1)
	local f3_local0 = CoD.ObjectiveWaypoint.new(f3_arg0, f3_arg1, CoD.ctf.baseWaypointZOffset)
	f3_local0:setClass(CoD.CTFObjectiveBase)
	local f3_local1 = Engine.GetObjectiveName(f3_arg0, f3_arg1)
	f3_local0:registerEventHandler("objective_update_" .. f3_local1, f3_local0.update)
	local f3_local2 = string.sub(f3_local1, 1, -5) .. "flag"
	f3_local0:registerEventHandler("objective_update_" .. f3_local2, f3_local0.update)
	f3_local0.flagObjectiveIndex = Engine.GetObjectiveIndexFromName(f3_arg0, f3_local2)
	return f3_local0
end

CoD.CTFObjectiveBase.shouldShow = function (f4_arg0, f4_arg1)
	if not CoD.CTFObjectiveBase.super.shouldShow(f4_arg0, f4_arg1) then
		return false
	end
	local f4_local0 = f4_arg1.controller
	if not f4_arg0:isOwnedByMyTeam(f4_local0) then
		return false
	elseif Engine.GetObjectiveGamemodeFlags(f4_local0, f4_arg0.index) ~= CoD.ctf.OBJECTIVE_FLAG_AWAY then
		return false
	end
	local f4_local1 = f4_arg0.flagObjectiveIndex
	if f4_local1 then
		if Engine.GetObjectiveGamemodeFlags(f4_local0, f4_local1) ~= CoD.ctf.OBJECTIVE_FLAG_AWAY then
			return false
		elseif not Engine.IsPlayerUsing(f4_local0, f4_local1, Engine.GetPredictedClientNum(f4_local0)) then
			return false
		end
	end
	return true
end

CoD.CTFObjectiveBase.update = function (f5_arg0, f5_arg1)
	local f5_local0 = "waypoint_waitfor_flag"
	local f5_local1 = f5_arg1.controller
	local f5_local2 = f5_arg0.index
	CoD.CTFObjectiveBase.super.update(f5_arg0, f5_arg1)
	f5_arg0.mainImage:setImage(RegisterMaterial(f5_local0))
	if f5_arg0.alphaController:getParent() then
		CoD.GametypeBase.SetCompassObjectiveIcon(f5_local1, f5_local2, f5_local0, "white_" .. f5_local0)
	else
		CoD.GametypeBase.ClearCompassObjectiveIcon(f5_local1, f5_local2)
	end
end

CoD.CTFObjectiveFlag.new = function (f6_arg0, f6_arg1)
	local f6_local0 = CoD.ObjectiveWaypoint.new(f6_arg0, f6_arg1, CoD.ctf.baseWaypointZOffset)
	f6_local0:setClass(CoD.CTFObjectiveFlag)
	f6_local0:registerEventHandler("objective_update_" .. Engine.GetObjectiveName(f6_arg0, f6_arg1), f6_local0.update)
	return f6_local0
end

CoD.CTFObjectiveFlag.shouldShow = function (f7_arg0, f7_arg1)
	if not CoD.CTFObjectiveFlag.super.shouldShow(f7_arg0, f7_arg1) then
		return false
	else
		local f7_local0 = f7_arg1.controller
		local f7_local1 = f7_arg0.index
		if f7_arg0:isOwnedByMyTeam(f7_local0) and Engine.GetObjectiveGamemodeFlags(f7_local0, f7_local1) ~= CoD.ctf.OBJECTIVE_AT_BASE and Engine.GetObjectiveEntity(f7_local0, f7_local1) and Engine.GetGametypeSetting("enemyCarrierVisible") == 0 then
			return false
		else
			return true
		end
	end
end

CoD.CTFObjectiveFlag.update = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg1.controller
	local f8_local1 = f8_arg0.index
	local f8_local2 = Engine.ObjectiveGetTeamUsingCount(f8_local0, f8_local1)
	local f8_local3 = Engine.GetObjectiveEntity(f8_local0, f8_local1)
	if f8_local3 then
		f8_arg0.zOffset = f8_arg0.PlayerZOffset
	else
		f8_arg0.zOffset = CoD.ctf.baseWaypointZOffset
	end
	local f8_local4, f8_local5, f8_local6 = nil
	if f8_arg0:isOwnedByMyTeam(f8_local0) then
		if Engine.GetObjectiveGamemodeFlags(f8_local0, f8_local1) == CoD.ctf.OBJECTIVE_AT_BASE then
			f8_local5 = "waypoint_defend_flag"
			f8_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameGreen))
		elseif f8_local3 then
			f8_local5 = "waypoint_kill"
			f8_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameRed))
			if Engine.GetGametypeSetting("enemyCarrierVisible") == 2 then
				f8_local4 = true
			end
		else
			f8_local5 = "waypoint_return_flag"
			f8_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameGreen))
		end
		f8_local6 = f8_local5
	elseif f8_local3 then
		f8_local5 = "waypoint_escort"
		f8_local6 = f8_local5
		f8_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameGreen))
	else
		f8_local5 = "waypoint_grab_red"
		f8_local6 = "waypoint_grab"
		f8_arg0.arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameRed))
	end
	f8_arg0.mainImage:setImage(RegisterMaterial(f8_local5))
	if f8_local3 == Engine.GetPredictedClientNum(f8_local0) then
		f8_arg0:setCarryIcon(RegisterMaterial("hudicon_ctf_flag_carry_" .. Engine.GetFactionForTeam(Engine.GetObjectiveTeam(f8_local0, f8_local1))))
	else
		f8_arg0:setCarryIcon(nil)
	end
	f8_arg0:setPing(f8_local4)
	CoD.CTFObjectiveFlag.super.update(f8_arg0, f8_arg1)
	if f8_arg0.alphaController:getParent() then
		CoD.GametypeBase.SetCompassObjectiveIcon(f8_local0, f8_local1, f8_local5, "white_" .. f8_local6)
		Engine.SetObjectiveIgnoreEntity(f8_local0, f8_local1, CoD.GametypeBase.mapIconType, f8_arg0.ping == true)
	else
		CoD.GametypeBase.ClearCompassObjectiveIcon(f8_local0, f8_local1)
	end
end

