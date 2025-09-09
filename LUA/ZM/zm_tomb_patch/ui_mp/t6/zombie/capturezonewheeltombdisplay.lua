CoD.CaptureZoneWheelTombDisplay = {}
CoD.CaptureZoneWheelTombDisplay.ContainerHeight = CoD.QuestItemTombDisplay.IconSize + CoD.textSize[CoD.QuestItemTombDisplay.FontName] + 10
CoD.CaptureZoneWheelTombDisplay.ONSCREEN_DURATION = 3000
CoD.CaptureZoneWheelTombDisplay.WHEEL_ONSCREEN_DURATION = 5000
CoD.CaptureZoneWheelTombDisplay.FADE_IN_DURATION = 500
CoD.CaptureZoneWheelTombDisplay.FADE_OUT_DURATION = 500
CoD.CaptureZoneWheelTombDisplay.NEED_ALL_ZONES = 0
CoD.CaptureZoneWheelTombDisplay.ALL_ZONES_CAPTURED = 1
CoD.CaptureZoneWheelTombDisplay.ZONE_CAPTURED = 1
CoD.CaptureZoneWheelTombDisplay.ZONE_LOST = 2
CoD.CaptureZoneWheelTombDisplay.TotalZoneCount = 6
CoD.CaptureZoneWheelTombDisplay.ZoneWheelBlueColor = CoD.Zombie.SingleTeamColor
CoD.CaptureZoneWheelTombDisplay.ZoneWheelLightBlueColor = {
	r = 0.36,
	g = 0.85,
	b = 0.96
}
CoD.CaptureZoneWheelTombDisplay.ZoneWheelRedColor = CoD.red
CoD.CaptureZoneWheelTombDisplay.new = function (f1_arg0)
	f1_arg0.id = f1_arg0.id .. ".CaptureZoneWheelTombDisplay"
	if not CoD.CaptureZoneWheelTombDisplay.MeterBackMaterial then
		CoD.CaptureZoneWheelTombDisplay.MeterBackMaterial = RegisterMaterial("zm_capture_meter_back")
	end
	if not CoD.CaptureZoneWheelTombDisplay.MeterWedgeMaterial then
		CoD.CaptureZoneWheelTombDisplay.MeterWedgeMaterial = RegisterMaterial("zm_capture_meter_wedge")
	end
	if not CoD.CaptureZoneWheelTombDisplay.MeterDialMaterial then
		CoD.CaptureZoneWheelTombDisplay.MeterDialMaterial = RegisterMaterial("zm_capture_meter_dial")
	end
	if not CoD.CaptureZoneWheelTombDisplay.MeterEyesMaterial then
		CoD.CaptureZoneWheelTombDisplay.MeterEyesMaterial = RegisterMaterial("zm_capture_meter_eyes")
	end
	CoD.CaptureZoneWheelTombDisplay.CaptureZoneStatus = {
		0,
		0,
		0,
		0,
		0,
		0
	}
	CoD.CaptureZoneWheelTombDisplay.AreAllZonesCaptured = false
	for f1_local0 = 1, CoD.CaptureZoneWheelTombDisplay.TotalZoneCount, 1 do
		f1_arg0:registerEventHandler("zone_capture_hud_generator_" .. f1_local0, CoD.CaptureZoneWheelTombDisplay.UpdateCaptureZoneWheel)
	end
	f1_arg0:registerEventHandler("hud_update_capture_zone_piece", CoD.CaptureZoneWheelTombDisplay.UpdateCaptureZonePiece)
	f1_arg0:registerEventHandler("capture_wheel_fade_out", CoD.CaptureZoneWheelTombDisplay.FadeoutCaptureWheel)
	f1_arg0:registerEventHandler("update_recapture_zone_color", CoD.CaptureZoneWheelTombDisplay.UpdateRecaptureZoneColor)
	f1_arg0:registerEventHandler("zone_capture_hud_all_generators_captured", CoD.CaptureZoneWheelTombDisplay.AllZonesCaptured)
	return f1_arg0
end

CoD.CaptureZoneWheelTombDisplay.UpdateVisibility = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_EMP_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_VEHICLE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_GUIDED_MISSILE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_AMMO_COUNTER_HIDE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_FLASH_BANGED) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_SCOREBOARD_OPEN) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_SCOPED) == 0 and (not CoD.IsShoutcaster(f2_local0) or CoD.ExeProfileVarBool(f2_local0, "shoutcaster_scorestreaks") and Engine.IsSpectatingActiveClient(f2_local0)) and CoD.FSM_VISIBILITY(f2_local0) == 0 then
		if f2_arg0.visible ~= true then
			f2_arg0:setAlpha(1)
			f2_arg0.m_inputDisabled = nil
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible == true then
		f2_arg0:setAlpha(0)
		f2_arg0.m_inputDisabled = true
		f2_arg0.visible = nil
	end
	f2_arg0:dispatchEventToChildren(f2_arg1)
end

CoD.CaptureZoneWheelTombDisplay.AddCaptureZoneWheel = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	if not f3_arg2 then
		f3_arg0:setAlpha(0)
	end
	local f3_local0 = 0
	if f3_arg2 == true and f3_arg3 then
		local f3_local1 = LUI.UIImage.new()
		f3_local1:setLeftRight(true, true, -f3_arg3, f3_arg3)
		f3_local1:setTopBottom(true, true, -f3_arg3, f3_arg3)
		f3_local1:setRGB(0, 0, 0)
		f3_local1:setAlpha(0.7)
		f3_arg0:addElement(f3_local1)
		f3_local0 = f3_local0 + f3_arg3 * 2
	end
	local f3_local1 = LUI.UIImage.new()
	f3_local1:setLeftRight(true, true, 0, 0)
	f3_local1:setTopBottom(true, true, 0, 0)
	f3_local1:setImage(CoD.CaptureZoneWheelTombDisplay.MeterBackMaterial)
	f3_arg0:addElement(f3_local1)
	local f3_local2 = 180
	f3_arg0.captureZonePieSlices = {}
	for f3_local3 = 1, CoD.CaptureZoneWheelTombDisplay.TotalZoneCount, 1 do
		local f3_local6 = LUI.UIImage.new()
		f3_local6:setLeftRight(true, true, 0, 0)
		f3_local6:setTopBottom(true, true, 0, 0)
		f3_local6:setImage(CoD.CaptureZoneWheelTombDisplay.MeterWedgeMaterial)
		f3_local6:setRGB(0, 0, 0)
		f3_local6:setAlpha(0.25)
		f3_local6:setZRot(f3_local2 - f3_local3 * 60)
		f3_arg0:addElement(f3_local6)
		f3_arg0.captureZonePieSlices[f3_local3] = f3_local6
	end
	local f3_local3 = LUI.UIImage.new()
	f3_local3:setLeftRight(true, true, 0, 0)
	f3_local3:setTopBottom(true, true, 0, 0)
	f3_local3:setImage(CoD.CaptureZoneWheelTombDisplay.MeterDialMaterial)
	f3_arg0:addElement(f3_local3)
	local f3_local4 = f3_arg1 * 0.25
	
	local meterEyesImage = LUI.UIImage.new()
	meterEyesImage:setLeftRight(false, false, -f3_local4 / 2, f3_local4 / 2)
	meterEyesImage:setTopBottom(false, false, -f3_local4 / 2, f3_local4 / 2)
	meterEyesImage:setImage(CoD.CaptureZoneWheelTombDisplay.MeterEyesMaterial)
	meterEyesImage:setAlpha(0)
	f3_arg0:addElement(meterEyesImage)
	f3_arg0.meterEyesImage = meterEyesImage
	
	return f3_local0 + f3_arg1
end

CoD.CaptureZoneWheelTombDisplay.ScoreboardUpdate = function (f4_arg0, f4_arg1)
	for f4_local0 = 1, #CoD.CaptureZoneWheelTombDisplay.CaptureZoneStatus, 1 do
		local f4_local3 = f4_arg0.captureZonePieSlices[f4_local0]
		if CoD.CaptureZoneWheelTombDisplay.CaptureZoneStatus[f4_local0] == 1 then
			f4_local3:setRGB(CoD.CaptureZoneWheelTombDisplay.ZoneWheelBlueColor.r, CoD.CaptureZoneWheelTombDisplay.ZoneWheelBlueColor.g, CoD.CaptureZoneWheelTombDisplay.ZoneWheelBlueColor.b)
			f4_local3:setAlpha(0.3)
		else
			f4_local3:setRGB(0, 0, 0)
			f4_local3:setAlpha(0.25)
		end
	end
	if CoD.CaptureZoneWheelTombDisplay.AreAllZonesCaptured == true then
		f4_arg0.meterEyesImage:setAlpha(1)
	else
		f4_arg0.meterEyesImage:setAlpha(0)
	end
end

CoD.CaptureZoneWheelTombDisplay.UpdateCaptureZoneWheel = function (f5_arg0, f5_arg1)
	f5_arg0:beginAnimation("fade_in", CoD.CaptureZoneWheelTombDisplay.FADE_IN_DURATION)
	f5_arg0:setAlpha(1)
	if f5_arg0.shouldFadeOutQuestStatus then
		CoD.CaptureZoneWheelTombDisplay.AddFadeOutTimer(f5_arg0)
	end
	f5_arg0:processEvent({
		name = "hud_update_capture_zone_piece",
		zoneName = f5_arg1.name,
		newValue = f5_arg1.newValue
	})
end

CoD.CaptureZoneWheelTombDisplay.AddFadeOutTimer = function (f6_arg0)
	if f6_arg0.fadeOutTimer then
		f6_arg0.fadeOutTimer:close()
		f6_arg0.fadeOutTimer:reset()
	end
	f6_arg0.fadeOutTimer = LUI.UITimer.new(CoD.CaptureZoneWheelTombDisplay.WHEEL_ONSCREEN_DURATION, "capture_wheel_fade_out", true, f6_arg0)
	f6_arg0:addElement(f6_arg0.fadeOutTimer)
end

CoD.CaptureZoneWheelTombDisplay.FadeoutCaptureWheel = function (f7_arg0, f7_arg1)
	f7_arg0:beginAnimation("fade_out", CoD.CaptureZoneWheelTombDisplay.FADE_OUT_DURATION)
	f7_arg0:setAlpha(0)
end

CoD.CaptureZoneWheelTombDisplay.UpdateCaptureZonePiece = function (f8_arg0, f8_arg1)
	local f8_local0 = tonumber(string.sub(f8_arg1.zoneName, -1))
	local f8_local1 = f8_arg1.newValue
	CoD.CaptureZoneWheelTombDisplay.CaptureZoneStatus[f8_local0] = f8_local1
	if not f8_arg0.captureZonePieSlices then
		return 
	end
	local f8_local2 = f8_arg0.captureZonePieSlices[f8_local0]
	if f8_local2.alternatorTimer then
		f8_local2:closeStateAlternator()
	end
	if f8_local1 == CoD.CaptureZoneWheelTombDisplay.ZONE_CAPTURED then
		f8_local2:setRGB(CoD.CaptureZoneWheelTombDisplay.ZoneWheelBlueColor.r, CoD.CaptureZoneWheelTombDisplay.ZoneWheelBlueColor.g, CoD.CaptureZoneWheelTombDisplay.ZoneWheelBlueColor.b)
		f8_local2:alternateStates(CoD.CaptureZoneWheelTombDisplay.ONSCREEN_DURATION, CoD.CaptureZoneWheelTombDisplay.CapturePulseLow, CoD.CaptureZoneWheelTombDisplay.CapturePulseHigh, 500, 500, CoD.CaptureZoneWheelTombDisplay.CapturePulseHigh)
	elseif f8_local1 == CoD.CaptureZoneWheelTombDisplay.ZONE_LOST then
		f8_local2:setRGB(CoD.CaptureZoneWheelTombDisplay.ZoneWheelRedColor.r, CoD.CaptureZoneWheelTombDisplay.ZoneWheelRedColor.g, CoD.CaptureZoneWheelTombDisplay.ZoneWheelRedColor.b)
		f8_local2:alternateStates(CoD.CaptureZoneWheelTombDisplay.ONSCREEN_DURATION, CoD.CaptureZoneWheelTombDisplay.PulseLow, CoD.CaptureZoneWheelTombDisplay.PulseHigh, 500, 500, CoD.CaptureZoneWheelTombDisplay.PulseHigh)
	end
	if f8_local1 == CoD.CaptureZoneWheelTombDisplay.ZONE_LOST then
		if f8_arg0.clearPieceColorTimer then
			f8_arg0.clearPieceColorTimer:close()
			f8_arg0.clearPieceColorTimer:reset()
		end
		f8_arg0.clearPieceColorTimer = LUI.UITimer.new(CoD.CaptureZoneWheelTombDisplay.ONSCREEN_DURATION + 250, {
			name = "update_recapture_zone_color",
			zoneNumber = f8_local0
		}, true, f8_arg0)
		f8_arg0:addElement(f8_arg0.clearPieceColorTimer)
	end
end

CoD.CaptureZoneWheelTombDisplay.UpdateRecaptureZoneColor = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0.captureZonePieSlices[f9_arg1.zoneNumber]
	f9_local0:beginAnimation("fade_grey", 250)
	f9_local0:setRGB(0, 0, 0)
	f9_local0:setAlpha(0.25)
end

CoD.CaptureZoneWheelTombDisplay.AllZonesCaptured = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg1.newValue
	if f10_local0 == CoD.CaptureZoneWheelTombDisplay.NEED_ALL_ZONES then
		if f10_arg0.meterEyesImage then
			f10_arg0.meterEyesImage:setAlpha(0)
		end
		CoD.CaptureZoneWheelTombDisplay.AreAllZonesCaptured = false
	elseif f10_local0 == CoD.CaptureZoneWheelTombDisplay.ALL_ZONES_CAPTURED then
		if f10_arg0.meterEyesImage then
			f10_arg0.meterEyesImage:setAlpha(1)
		end
		CoD.CaptureZoneWheelTombDisplay.AreAllZonesCaptured = true
	end
end

CoD.CaptureZoneWheelTombDisplay.CapturePulseLow = function (f11_arg0, f11_arg1)
	f11_arg0:beginAnimation("turn_low", f11_arg1)
	f11_arg0:setRGB(CoD.CaptureZoneWheelTombDisplay.ZoneWheelLightBlueColor.r, CoD.CaptureZoneWheelTombDisplay.ZoneWheelLightBlueColor.g, CoD.CaptureZoneWheelTombDisplay.ZoneWheelLightBlueColor.b)
	f11_arg0:setAlpha(1)
end

CoD.CaptureZoneWheelTombDisplay.CapturePulseHigh = function (f12_arg0, f12_arg1)
	f12_arg0:beginAnimation("turn_high", f12_arg1)
	f12_arg0:setRGB(CoD.CaptureZoneWheelTombDisplay.ZoneWheelBlueColor.r, CoD.CaptureZoneWheelTombDisplay.ZoneWheelBlueColor.g, CoD.CaptureZoneWheelTombDisplay.ZoneWheelBlueColor.b)
	f12_arg0:setAlpha(0.3)
end

CoD.CaptureZoneWheelTombDisplay.PulseLow = function (f13_arg0, f13_arg1)
	f13_arg0:beginAnimation("turn_low", f13_arg1)
	f13_arg0:setAlpha(0.1)
end

CoD.CaptureZoneWheelTombDisplay.PulseHigh = function (f14_arg0, f14_arg1)
	f14_arg0:beginAnimation("turn_high", f14_arg1)
	f14_arg0:setAlpha(1)
end

