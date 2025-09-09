CoD.ObjectiveWaypoint = InheritFrom(LUI.UIElement)
CoD.ObjectiveWaypoint.PlayerZOffset = 75
CoD.ObjectiveWaypoint.iconWidth = 56
CoD.ObjectiveWaypoint.iconHeight = 56
CoD.ObjectiveWaypoint.iconAlpha = 0.5
CoD.ObjectiveWaypoint.largeIconWidth = 64
CoD.ObjectiveWaypoint.largeIconHeight = 64
CoD.ObjectiveWaypoint.progressWidth = CoD.ObjectiveWaypoint.largeIconWidth + 4
CoD.ObjectiveWaypoint.progressHeight = CoD.ObjectiveWaypoint.largeIconHeight + 4
CoD.ObjectiveWaypoint.progressHeightNudge = 0
CoD.ObjectiveWaypoint.snapToHeight = 112
CoD.ObjectiveWaypoint.snapToTime = 250
CoD.ObjectiveWaypoint.pulseAlphaLow = CoD.ObjectiveWaypoint.iconAlpha * 0.35
CoD.ObjectiveWaypoint.pulseAlphaHigh = CoD.ObjectiveWaypoint.iconAlpha
CoD.ObjectiveWaypoint.pulseTime = 700
CoD.ObjectiveWaypoint.pulseStopTime = 200
CoD.ObjectiveWaypoint.ArrowMaterialNameWhite = "waypoint_circle_arrow"
CoD.ObjectiveWaypoint.ArrowMaterialNameRed = "waypoint_circle_arrow_red"
CoD.ObjectiveWaypoint.ArrowMaterialNameGreen = "waypoint_circle_arrow_green"
CoD.ObjectiveWaypoint.ArrowMaterialNameYellow = "waypoint_circle_arrow_yellow"
CoD.ObjectiveWaypoint.contestedProgressColor = CoD.BOIIOrange
CoD.ObjectiveWaypoint.progressColor = CoD.white
local f0_local0 = {
	name = "set_carry_icon"
}
CoD.ObjectiveWaypoint.new = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = Engine.GetObjectiveName(f1_arg0, f1_arg1)
	local Widget = LUI.UIElement.new()
	Widget:setClass(CoD.ObjectiveWaypoint)
	Widget:setupEntityContainer(-1)
	Widget:setEntityContainerClamp(true)
	Widget:setEntityContainerFadeWhenTargeted(true)
	Widget.index = f1_arg1
	Widget.zOffset = f1_arg2
	Widget.snapToTime = CoD.ObjectiveWaypoint.snapToTime
	Widget.snapToCenterForObjectiveTeam = true
	
	local progressController = LUI.UIElement.new()
	progressController:setLeftRight(false, false, 0, 0)
	progressController:setTopBottom(false, false, 0, 0)
	progressController:setAlpha(0)
	Widget:addElement(progressController)
	Widget.progressController = progressController
	
	local progressBackground = LUI.UIImage.new()
	progressBackground:setLeftRight(true, true, 0, 0)
	progressBackground:setTopBottom(true, true, 0, 0)
	progressBackground:setImage(RegisterMaterial("hud_objective_full_circle_meter"))
	progressBackground:setRGB(0, 0, 0)
	progressBackground:setAlpha(0.5)
	progressBackground:setShaderVector(0, 1, 0, 0, 0)
	progressController:addElement(progressBackground)
	Widget.progressBackground = progressBackground
	
	local progressBar = LUI.UIImage.new()
	progressBar:setupObjectiveProgress(f1_arg1)
	progressBar:setLeftRight(true, true, 0, 0)
	progressBar:setTopBottom(true, true, 0, 0)
	progressBar:setImage(RegisterMaterial("hud_objective_circle_meter"))
	progressController:addElement(progressBar)
	Widget.progressBar = progressBar
	
	local alphaController = LUI.UIElement.new()
	alphaController:setLeftRight(true, true, 0, 0)
	alphaController:setTopBottom(true, true, 0, 0)
	alphaController:setAlpha(Widget.iconAlpha)
	alphaController:registerEventHandler("transition_complete_pulse_low", function (f13_arg0, f13_arg1)
		if f13_arg1.interrupted ~= true then
			f13_arg0:beginAnimation("pulse_high", Widget.pulseTime, false, false)
			f13_arg0:setAlpha(Widget.pulseAlphaHigh)
		end
	end)
	alphaController:registerEventHandler("transition_complete_pulse_high", function (f14_arg0, f14_arg1)
		if f14_arg1.interrupted ~= true then
			f14_arg0:beginAnimation("pulse_low", Widget.pulseTime, false, false)
			f14_arg0:setAlpha(Widget.pulseAlphaLow)
		end
	end)
	Widget:addElement(alphaController)
	Widget.alphaController = alphaController
	
	local mainImage = LUI.UIImage.new()
	mainImage:setLeftRight(true, true, 0, 0)
	mainImage:setTopBottom(true, true, 0, 0)
	alphaController:addElement(mainImage)
	Widget.mainImage = mainImage
	
	local edgePointerContainer = LUI.UIElement.new()
	edgePointerContainer:setLeftRight(true, true, 0, 0)
	edgePointerContainer:setTopBottom(true, true, 0, 0)
	alphaController:addElement(edgePointerContainer)
	Widget.edgePointerContainer = edgePointerContainer
	
	local arrowImage = LUI.UIImage.new()
	arrowImage:setLeftRight(false, false, -16, 16)
	arrowImage:setTopBottom(false, true, -10, 22)
	arrowImage:setImage(RegisterMaterial(CoD.ObjectiveWaypoint.ArrowMaterialNameWhite))
	edgePointerContainer:addElement(arrowImage)
	Widget.arrowImage = arrowImage
	
	Widget.showingProgress = false
	Widget.updateProgress = CoD.ObjectiveWaypoint.updateProgress
	Widget.updatePlayerUsing = CoD.ObjectiveWaypoint.updatePlayerUsing
	return Widget
end

CoD.ObjectiveWaypoint.Clamped = function (f2_arg0, f2_arg1)
	if f2_arg0.edgePointerContainer.setupEdgePointer then
		f2_arg0.edgePointerContainer:setupEdgePointer(90)
	end
end

CoD.ObjectiveWaypoint.Unclamped = function (f3_arg0, f3_arg1)
	f3_arg0.edgePointerContainer:setupUIElement()
	f3_arg0.edgePointerContainer:setZRot(0)
end

CoD.ObjectiveWaypoint.isOwnedByMyTeam = function (f4_arg0, f4_arg1)
	if Engine.GetTeamID(f4_arg1, Engine.GetPredictedClientNum(f4_arg1)) ~= Engine.GetObjectiveTeam(f4_arg1, f4_arg0.index) then
		return false
	else
		return true
	end
end

CoD.ObjectiveWaypoint.setCarryIcon = function (f5_arg0, f5_arg1)
	if f5_arg1 ~= f5_arg0.carryIconMaterial then
		f5_arg0.carryIconMaterial = f5_arg1
		f0_local0.material = f5_arg1
		f5_arg0:dispatchEventToParent(f0_local0)
	end
end

CoD.ObjectiveWaypoint.shouldShow = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.controller
	local f6_local1 = f6_arg0.index
	if Engine.GetObjectiveState(f6_local0, f6_local1) ~= CoD.OBJECTIVESTATE_ACTIVE then
		return false
	elseif Engine.GetObjectiveEntity(f6_local0, f6_local1) == Engine.GetPredictedClientNum(f6_local0) then
		return false
	else
		return true
	end
end

CoD.ObjectiveWaypoint.update = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg1.controller
	local f7_local1 = f7_arg0.index
	local f7_local2 = f7_arg0.ping
	local f7_local3 = Engine.GetObjectiveEntity(f7_local0, f7_local1)
	if f7_local3 and not f7_local2 then
		f7_arg0:setupEntityContainer(f7_local3, 0, 0, f7_arg0.zOffset)
	else
		local f7_local4, f7_local5, f7_local6 = Engine.GetObjectivePosition(f7_local0, f7_local1)
		f7_arg0:setupEntityContainer(-1, f7_local4, f7_local5, f7_local6 + f7_arg0.zOffset)
		if f7_local2 then
			f7_arg0.alphaController:setAlpha(f7_arg0.iconAlpha)
			f7_arg0.alphaController:beginAnimation("ping", Engine.GetGametypeSetting("objectivePingTime") * 1000 + 1000)
			f7_arg0.alphaController:setAlpha(0.1)
		end
	end
	if not f7_arg0:shouldShow(f7_arg1) then
		f7_arg0.progressController:close()
		f7_arg0.alphaController:close()
		return 
	else
		f7_arg0:addElement(f7_arg0.progressController)
		f7_arg0:addElement(f7_arg0.alphaController)
		local f7_local5 = Engine.GetTeamID(f7_local0, Engine.GetPredictedClientNum(f7_local0))
		local f7_local6 = Engine.ObjectiveIsTeamUsing(f7_local0, f7_arg0.index, f7_local5)
		local f7_local7 = Engine.ObjectiveIsAnyOtherTeamUsing(f7_local0, f7_arg0.index, f7_local5)
		f7_arg0:updatePlayerUsing(f7_local0, f7_local6, f7_local7)
		f7_arg0:updateProgress(f7_local0, f7_local6, f7_local7)
	end
end

CoD.ObjectiveWaypoint.isPlayerUsing = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	if Engine.IsPlayerInVehicle(f8_arg1) == true then
		return false
	elseif Engine.IsPlayerRemoteControlling(f8_arg1) == true then
		return false
	elseif Engine.IsPlayerWeaponViewOnlyLinked(f8_arg1) == true then
		return false
	end
	local f8_local0 = Engine.GetPredictedClientNum(f8_arg1)
	local f8_local1
	if f8_arg2 == 0 then
		f8_local1 = f8_arg2
	else
		f8_local1 = f8_arg3
	end
	if f8_arg0.snapToCenterForObjectiveTeam == false and not f8_local1 and Engine.GetTeamID(f8_arg1, f8_local0) == Engine.GetObjectiveTeam(f8_arg1, f8_arg0.index) then
		return false
	end
	return Engine.ObjectiveIsPlayerUsing(f8_arg1, f8_arg0.index, f8_local0)
end

CoD.ObjectiveWaypoint.updatePlayerUsing = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	local f9_local0 = CoD.ObjectiveWaypoint.isPlayerUsing(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	if f9_arg0.playerUsing == f9_local0 then
		return 
	elseif f9_local0 == true then
		if f9_arg0.playerUsing ~= nil then
			f9_arg0:beginAnimation("snap_in", f9_arg0.snapToTime, true, true)
		end
		f9_arg0:setEntityContainerStopUpdating(true)
		f9_arg0:setLeftRight(false, false, -f9_arg0.largeIconWidth / 2, f9_arg0.largeIconWidth / 2)
		f9_arg0:setTopBottom(false, false, -f9_arg0.largeIconHeight - f9_arg0.snapToHeight, -f9_arg0.snapToHeight)
		f9_arg0.edgePointerContainer:setAlpha(0)
	else
		if f9_arg0.playerUsing ~= nil then
			f9_arg0:beginAnimation("snap_out", f9_arg0.snapToTime, true, true)
		end
		f9_arg0:setEntityContainerStopUpdating(false)
		f9_arg0:setLeftRight(false, false, -f9_arg0.iconWidth / 2, f9_arg0.iconWidth / 2)
		f9_arg0:setTopBottom(false, true, -f9_arg0.iconHeight, 0)
		f9_arg0.edgePointerContainer:setAlpha(1)
	end
	f9_arg0.playerUsing = f9_local0
end

CoD.ObjectiveWaypoint.updateProgress = function (f10_arg0, f10_arg1, f10_arg2, f10_arg3)
	local f10_local0 = Engine.GetObjectiveProgress(f10_arg1, f10_arg0.index)
	local f10_local1 = true
	if not f10_arg0.showProgressToEveryone and (f10_arg0.playerUsing == nil or f10_arg0.playerUsing == false) then
		f10_local1 = false
	end
	local f10_local2 = true
	if f10_local1 and f10_arg0.mayShowProgress then
		f10_local2 = f10_arg0:mayShowProgress(f10_arg1)
	end
	local f10_local3
	if f10_arg2 == 0 then
		f10_local3 = f10_arg2
	else
		f10_local3 = f10_arg3
	end
	if not f10_local3 and f10_local1 then
		f10_local1 = f10_local2
	end
	if f10_local1 and not f10_arg0.showProgressToEveryone then
		if f10_local3 then
			f10_arg0.progressBar:setRGB(f10_arg0.contestedProgressColor.r, f10_arg0.contestedProgressColor.g, f10_arg0.contestedProgressColor.b)
			f10_arg0.progressBar:setupUIImage()
			f10_arg0.progressBar:setShaderVector(0, 1, 0, 0, 0)
		else
			f10_arg0.progressBar:setRGB(f10_arg0.progressColor.r, f10_arg0.progressColor.g, f10_arg0.progressColor.b)
			f10_arg0.progressBar:setupObjectiveProgress(f10_arg0.index)
		end
	end
	if f10_arg0.showingProgress == false and f10_local1 == true and (f10_local0 > 0 or f10_local3) then
		if f10_arg0.showProgressToEveryone then
			if f10_arg2 and f10_arg3 then
				f10_arg0.progressBar:setRGB(f10_arg0.contestedProgressColor.r, f10_arg0.contestedProgressColor.g, f10_arg0.contestedProgressColor.b)
			elseif f10_arg2 then
				f10_arg0.progressBar:setRGB(CoD.teamColorFriendly.r, CoD.teamColorFriendly.g, CoD.teamColorFriendly.b)
			else
				f10_arg0.progressBar:setRGB(CoD.teamColorEnemy.r, CoD.teamColorEnemy.g, CoD.teamColorEnemy.b)
			end
		end
		local f10_local4 = CoD.ObjectiveWaypoint.progressHeight / 2
		f10_arg0.progressController:beginAnimation("progress", f10_arg0.snapToTime, true, true)
		f10_arg0.progressController:setLeftRight(false, false, -CoD.ObjectiveWaypoint.progressWidth / 2, CoD.ObjectiveWaypoint.progressWidth / 2)
		f10_arg0.progressController:setTopBottom(false, false, -f10_local4 - CoD.ObjectiveWaypoint.progressHeightNudge, f10_local4 - CoD.ObjectiveWaypoint.progressHeightNudge)
		f10_arg0.progressController:setAlpha(1)
		f10_arg0.showingProgress = true
	elseif f10_arg0.showingProgress == true and (not (f10_local0 ~= 0 or f10_local3) or f10_local1 == false) then
		f10_arg0.progressController:beginAnimation("progress", f10_arg0.snapToTime, true, true)
		f10_arg0.progressController:setLeftRight(false, false, 0, 0)
		f10_arg0.progressController:setTopBottom(false, false, 0, 0)
		f10_arg0.progressController:setAlpha(0)
		f10_arg0.showingProgress = false
	end
	if not f10_arg0.disablePulse then
		if not f10_arg0.pulsing and f10_local0 > 0 then
			f10_arg0.alphaController:beginAnimation("pulse_low", f10_arg0.pulseTime, false, false)
			f10_arg0.alphaController:setAlpha(f10_arg0.pulseAlphaLow)
			f10_arg0.pulsing = true
		elseif f10_arg0.pulsing and f10_local0 == 0 then
			f10_arg0.alphaController:beginAnimation("pulse_stop", f10_arg0.pulseStopTime, false, false)
			f10_arg0.alphaController:setAlpha(f10_arg0.iconAlpha)
			f10_arg0.pulsing = nil
		end
	end
end

CoD.ObjectiveWaypoint.setPing = function (f11_arg0, f11_arg1)
	if f11_arg0.ping and not f11_arg1 then
		f11_arg0.alphaController:setAlpha(f11_arg0.iconAlpha)
	end
	f11_arg0.ping = f11_arg1
end

CoD.ObjectiveWaypoint.SnapInFinished = function (f12_arg0, f12_arg1)
	if f12_arg1.interrupted ~= true then

	else

	end
end

CoD.ObjectiveWaypoint:registerEventHandler("transition_complete_snap_in", CoD.ObjectiveWaypoint.SnapInFinished)
CoD.ObjectiveWaypoint:registerEventHandler("entity_container_clamped", CoD.ObjectiveWaypoint.Clamped)
CoD.ObjectiveWaypoint:registerEventHandler("entity_container_unclamped", CoD.ObjectiveWaypoint.Unclamped)
