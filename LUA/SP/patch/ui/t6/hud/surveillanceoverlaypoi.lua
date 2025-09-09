CoD.SurveillanceOverlayPOI = {}
CoD.SurveillanceOverlayPOI.FontName = "Default"
CoD.SurveillanceOverlayPOI.CircleSize = 175
CoD.SurveillanceOverlayPOI.ScanCircleActiveAlpha = 1
CoD.SurveillanceOverlayPOI.ScanCircleIdleAlpha = 0.8
CoD.SurveillanceOverlayPOI.ScanColor = CoD.greenBlue
CoD.SurveillanceOverlayPOI.new = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = CoD.SurveillanceOverlayPOI.CircleSize * 0.6
	local f1_local1 = CoD.textSize[CoD.SurveillanceOverlayPOI.FontName]
	if f1_arg2 then
		f1_local0 = CoD.SurveillanceOverlayPOI.CircleSize * 0.5
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f1_local0 / 2, f1_local0 / 2)
	Widget:setTopBottom(false, false, -f1_local0 / 2, f1_local0 / 2)
	Widget.id = Widget.id .. ".SOPOI"
	Widget:setupEntityContainer(f1_arg0, 0, 0, 30)
	Widget:setEntityContainerScale(false)
	Widget:setEntityContainerScaleClamp(false)
	Widget:registerEventHandler("scan_begin", CoD.SurveillanceOverlayPOI.ScanBegin)
	Widget:registerEventHandler("scan_complete", CoD.SurveillanceOverlayPOI.ScanComplete)
	Widget:registerEventHandler("scan_reset", CoD.SurveillanceOverlayPOI.ScanReset)
	Widget:registerEventHandler("close_all", CoD.SurveillanceOverlayPOI.CloseAll)
	Widget:registerEventHandler("setup_rec", CoD.SurveillanceOverlayPOI.SetupRecording)
	if f1_arg1 == true or f1_arg2 == true then
		Widget:registerEventHandler("hud_pak_start_scan", CoD.SurveillanceOverlayPOI.PakStartScan)
		Widget:registerEventHandler("hud_pak_stop_scan", CoD.SurveillanceOverlayPOI.PakStopScan)
		Widget:registerEventHandler("hud_pak_scan_complete", CoD.SurveillanceOverlayPOI.PakScanComplete)
	end
	if f1_arg2 then
		Widget:setupEntityContainer(f1_arg0, 0, 0, 50)
		Widget:setEntityContainerScale(false)
		Widget:setEntityContainerScaleClamp(false)
	end
	Widget.parentContainer = LUI.UIElement.new()
	Widget.parentContainer:setLeftRight(true, true, 0, 0)
	Widget.parentContainer:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget.parentContainer)
	local f1_local3 = LUI.UIImage.new()
	f1_local3:setLeftRight(true, true, 0, 0)
	f1_local3:setTopBottom(true, true, 0, 0)
	f1_local3:setAlpha(0)
	f1_local3:setImage(CoD.SurveillanceOverlay.TargetCircleMaterial)
	f1_local3.id = f1_local3.id .. ".TargetCircle"
	Widget.parentContainer:addElement(f1_local3)
	Widget.targetCircle = f1_local3
	local f1_local4 = LUI.UIImage.new()
	f1_local4:setLeftRight(true, true, 0, 0)
	f1_local4:setTopBottom(true, true, 0, 0)
	f1_local4:setImage(CoD.SurveillanceOverlay.ScanCircleOutlineMaterial)
	f1_local4:setAlpha(0)
	f1_local4.id = f1_local4.id .. ".ScanCircleOutline"
	Widget.parentContainer:addElement(f1_local4)
	Widget.scanCircleOutline = f1_local4
	local Widget = nil
	if f1_arg1 == true or f1_arg2 == true then
		Widget = LUI.UIImage.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:setImage(CoD.SurveillanceOverlay.ScanCircleMeterMaterial)
		Widget:setZRot(150)
		Widget:setRGB(CoD.SurveillanceOverlayPOI.ScanColor.r, CoD.SurveillanceOverlayPOI.ScanColor.g, CoD.SurveillanceOverlayPOI.ScanColor.b)
		Widget:setAlpha(0)
		Widget:setShaderVector(0, 0, 0, 0, 0)
		Widget:registerEventHandler("pak_scan_update", CoD.SurveillanceOverlayPOI.PakScanUpdate)
	else
		Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:setImage(CoD.SurveillanceOverlay.ScanCircleMeterMaterial)
		Widget:setZRot(150)
		Widget:setRGB(CoD.SurveillanceOverlayPOI.ScanColor.r, CoD.SurveillanceOverlayPOI.ScanColor.g, CoD.SurveillanceOverlayPOI.ScanColor.b)
		Widget:setAlpha(0)
		Widget:setupEntityScanning(f1_arg0)
	end
	Widget.id = Widget.id .. ".ScanCircleFill"
	Widget:registerEventHandler("scan_begin", CoD.SurveillanceOverlayPOI.ScanCircleBegin)
	Widget:registerEventHandler("scan_complete", CoD.SurveillanceOverlayPOI.ScanCircleComplete)
	Widget:registerEventHandler("scan_reset", CoD.SurveillanceOverlayPOI.ScanCircleReset)
	Widget.parentContainer:addElement(Widget)
	Widget.scanCircleFill = Widget
	local f1_local6 = LUI.UIImage.new()
	f1_local6:setLeftRight(true, true, 0, 0)
	f1_local6:setTopBottom(true, true, 0, 0)
	f1_local6:setImage(CoD.SurveillanceOverlay.Headshots[1])
	f1_local6:setAlpha(0)
	f1_local6.id = f1_local6.id .. ".CenterImage"
	f1_local6:registerEventHandler("random_headshots", CoD.SurveillanceOverlayPOI.RandomHeadshots)
	Widget.parentContainer:addElement(f1_local6)
	Widget.centerImage = f1_local6
	local f1_local7 = CoD.SurveillanceOverlayPOI.CircleSize / 4 + 10
	if f1_arg2 then
		f1_local7 = CoD.SurveillanceOverlayPOI.CircleSize / 4
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(false, false, -f1_local1 / 2 + f1_local7, f1_local1 / 2 + f1_local7)
	Widget.id = Widget.id .. ".ScanTextContainer"
	Widget:setupEntityContainer(f1_arg0, 0, 0, 30)
	Widget:setEntityContainerScale(false)
	Widget:setEntityContainerScaleClamp(false)
	Widget.parentContainer:addElement(Widget)
	Widget.scanTextContainer = Widget
	if f1_arg2 then
		Widget:setupEntityContainer(f1_arg0, 0, 0, 50)
		Widget:setEntityContainerScale(false)
		Widget:setEntityContainerScaleClamp(false)
	end
	local scanningText = LUI.UIText.new()
	scanningText:setLeftRight(true, true, 0, 0)
	scanningText:setTopBottom(true, true, 0, 0)
	scanningText:setFont(CoD.fonts[CoD.SurveillanceOverlayPOI.FontName])
	scanningText:setRGB(CoD.SurveillanceOverlayPOI.ScanColor.r, CoD.SurveillanceOverlayPOI.ScanColor.g, CoD.SurveillanceOverlayPOI.ScanColor.b)
	scanningText:setAlpha(0)
	scanningText.id = scanningText.id .. ".ScanningText"
	scanningText.blink = true
	scanningText:registerEventHandler("transition_complete_blink_on", CoD.SurveillanceOverlayPOI.ScanTextBlinkOff)
	scanningText:registerEventHandler("transition_complete_blink_off", CoD.SurveillanceOverlayPOI.ScanTextBlinkOn)
	scanningText.setScanningText = CoD.SurveillanceOverlayPOI.SetScanningText
	Widget:addElement(scanningText)
	Widget.scanningText = scanningText
	
	Widget.entityNum = f1_arg0
	Widget.isMenendez = f1_arg1
	Widget.isDefalco = f1_arg2
	return Widget
end

CoD.SurveillanceOverlayPOI.SetScanningText = function (f2_arg0, f2_arg1)
	if f2_arg1 == "" then
		return 
	else
		f2_arg0:setText("[ " .. f2_arg1 .. " ] ")
	end
end

CoD.SurveillanceOverlayPOI.AddScanningPhotos = function ()
	return LUI.UIElement.new()
end

CoD.SurveillanceOverlayPOI.ScanCircleBegin = function (f4_arg0, f4_arg1)
	f4_arg0:setAlpha(1)
	f4_arg0:dispatchEventToParent(f4_arg1)
end

CoD.SurveillanceOverlayPOI.ScanCircleComplete = function (f5_arg0, f5_arg1)
	f5_arg0:dispatchEventToParent(f5_arg1)
	f5_arg0:close()
end

CoD.SurveillanceOverlayPOI.ScanCircleReset = function (f6_arg0, f6_arg1)
	f6_arg0:setAlpha(0)
	f6_arg0:dispatchEventToParent(f6_arg1)
end

CoD.SurveillanceOverlayPOI.PakScanUpdate = function (f7_arg0, f7_arg1)
	f7_arg0.fillAmount = f7_arg0.fillAmount + 0.2
	f7_arg0:beginAnimation("fill_scan", f7_arg1.duration)
	f7_arg0:setShaderVector(0, f7_arg0.fillAmount, 0, 0, 0)
end

CoD.SurveillanceOverlayPOI.PakStartScan = function (f8_arg0, f8_arg1)
	if f8_arg0.entityNum == f8_arg1.data[1] then
		CoD.SurveillanceOverlayPOI.ScanBegin(f8_arg0, f8_arg1)
		f8_arg0.scanCircleFill:setAlpha(1)
		f8_arg0.scanCircleFill.fillAmount = 0
		f8_arg0.pakScanTimer = LUI.UITimer.new(500, {
			name = "pak_scan_update",
			duration = 500
		}, false, f8_arg0.scanCircleFill)
		f8_arg0:addElement(f8_arg0.pakScanTimer)
	end
end

CoD.SurveillanceOverlayPOI.PakStopScan = function (f9_arg0, f9_arg1)
	if f9_arg0.entityNum == f9_arg1.data[1] then
		if f9_arg0.pakScanTimer then
			f9_arg0.pakScanTimer:close()
		end
		CoD.SurveillanceOverlayPOI.ScanReset(f9_arg0, f9_arg1)
		f9_arg0.scanCircleFill:setAlpha(0)
		f9_arg0.scanCircleFill.fillAmount = 0
		f9_arg0.scanCircleFill:setShaderVector(0, 0, 0, 0, 0)
	end
end

CoD.SurveillanceOverlayPOI.PakScanComplete = function (f10_arg0, f10_arg1)
	if f10_arg0.entityNum == f10_arg1.data[1] then
		CoD.SurveillanceOverlayPOI.ScanComplete(f10_arg0, f10_arg1)
	end
end

CoD.SurveillanceOverlayPOI.ScanBegin = function (f11_arg0, f11_arg1)
	f11_arg0.targetCircle:setAlpha(1)
	f11_arg0.centerImage:beginAnimation("fadein", 1000)
	f11_arg0.centerImage:setAlpha(1)
	f11_arg0.scanningText:setAlpha(1)
	f11_arg0.scanningText:setScanningText(Engine.Localize("MENU_SCANNING_CAPS"))
	f11_arg0.scanningText:beginAnimation("blink_off", 500)
	f11_arg0.scanningText:setAlpha(0.3)
	f11_arg0.centerImage.headshotCount = 2
	f11_arg0.centerImage.headshotTimer = LUI.UITimer.new(100, "random_headshots", false, f11_arg0.centerImage)
	f11_arg0.centerImage:addElement(f11_arg0.centerImage.headshotTimer)
end

CoD.SurveillanceOverlayPOI.ScanTextBlinkOn = function (f12_arg0, f12_arg1)
	if f12_arg1.interrupted ~= true then
		f12_arg0:beginAnimation("blink_on", 500)
		f12_arg0:setAlpha(1)
		f12_arg0.blink = true
	end
end

CoD.SurveillanceOverlayPOI.ScanTextBlinkOff = function (f13_arg0, f13_arg1)
	if f13_arg1.interrupted ~= true then
		f13_arg0:beginAnimation("blink_off", 500)
		f13_arg0:setAlpha(0.3)
		f13_arg0.blink = false
	end
end

CoD.SurveillanceOverlayPOI.SetupRecording = function (f14_arg0, f14_arg1)
	if f14_arg0.isMenendez == true then
		local f14_local0 = 100
		f14_arg0:setupEntityContainer(f14_arg0.entityNum, 0, 0, 50)
		f14_arg0:setLeftRight(false, false, -f14_local0 / 2, f14_local0 / 2)
		f14_arg0:setTopBottom(false, false, -f14_local0 / 2, f14_local0 / 2)
		f14_arg0:setEntityContainerScale(false)
		f14_arg0:setEntityContainerScaleClamp(false)
		f14_arg0:registerEventHandler("rec_init", CoD.SurveillanceOverlayPOI.RecordingInit)
		f14_arg0:registerEventHandler("hud_surveilance_end", CoD.SurveillanceOverlayPOI.SurveillanceEnd)
		f14_arg0:registerEventHandler("hud_pak_poi_visibility", CoD.SurveillanceOverlayPOI.POIVisibility)
		f14_arg0:registerEventHandler("hud_pak_interference", CoD.SurveillanceOverlayPOI.Interference)
		f14_arg0:registerEventHandler("hud_pak_start_scan", nil)
		local f14_local1 = CoD.textSize[CoD.SurveillanceOverlayPOI.FontName]
		local f14_local2 = CoD.SurveillanceOverlayPOI.CircleSize / 4 + 15
		f14_arg0.scanTextContainer:setTopBottom(false, false, -f14_local1 / 2 + f14_local2, f14_local1 / 2 + f14_local2)
		f14_arg0.scanTextContainer:setupEntityContainer(f14_arg0.entityNum, 0, 0, 50)
		f14_arg0.scanTextContainer:setEntityContainerScale(false)
		f14_arg0.scanTextContainer:setEntityContainerScaleClamp(false)
		f14_arg0.scanCircleOutline:setAlpha(1)
		f14_arg0.scanningText:setAlpha(1)
		f14_arg0.targetCircle:close()
		f14_arg0.scanCircleFill:close()
		f14_arg0.scanningText:setScanningText(Engine.Localize("MENU_REC_CAPS"))
		f14_arg0.scanCircleFillIdle = LUI.UIImage.new()
		f14_arg0.scanCircleFillIdle:setLeftRight(true, true, 0, 0)
		f14_arg0.scanCircleFillIdle:setTopBottom(true, true, 0, 0)
		f14_arg0.scanCircleFillIdle:setImage(CoD.SurveillanceOverlay.ScanComplete)
		f14_arg0.scanCircleFillIdle:setAlpha(0.5)
		f14_arg0.parentContainer:addElement(f14_arg0.scanCircleFillIdle)
		f14_arg0.centerImage:setImage(CoD.SurveillanceOverlay.MenendezHeadMaterial)
		f14_arg0:dispatchEventToParent({
			name = "close_enemy_pois"
		})
		f14_arg0.parentContainer:addElement(LUI.UITimer.new(f14_arg1.delay, "rec_init", true, f14_arg0))
	end
end

CoD.SurveillanceOverlayPOI.ScanComplete = function (f15_arg0, f15_arg1)
	if f15_arg0.centerImage.headshotTimer then
		f15_arg0.centerImage.headshotTimer:close()
	end
	if f15_arg0.isMenendez == true then
		f15_arg0.scanningText:setScanningText(Engine.Localize("MENU_MATCH_FOUND_CAPS"))
		f15_arg0:processEvent({
			name = "setup_rec",
			delay = 500,
			recPercent = 0
		})
	elseif f15_arg0.isDefalco == true then
		f15_arg0.scanCircleOutline:setAlpha(1)
		f15_arg0.scanningText:setScanningText(Engine.Localize("MENU_MATCH_FOUND_CAPS"))
		CoD.SurveillanceOverlayPOI.RecordingInit(f15_arg0)
		f15_arg0.scanningText:setText("")
		f15_arg0.nameText:setText(Engine.Localize("MENU_DEFALCO_NAME"))
		f15_arg0.headshotImage:setImage(CoD.SurveillanceOverlay.DefalcoHeadMaterial)
		f15_arg0.targetCircle:close()
		f15_arg0.scanCircleFill:close()
		f15_arg0:registerEventHandler("hud_pak_defalco_off", CoD.SurveillanceOverlayPOI.SetupDefalco)
		f15_arg0:dispatchEventToParent({
			name = "close_enemy_pois"
		})
		f15_arg0.parentContainer:addElement(LUI.UITimer.new(15000, "hud_pak_defalco_off", true, f15_arg0))
	else
		f15_arg0.scanCircleOutline:setAlpha(1)
		f15_arg0.scanningText:setScanningText(Engine.Localize("MENU_MATCH_NOT_FOUND_CAPS"))
		f15_arg0.centerImage:setImage(CoD.SurveillanceOverlay.ExclamtionMaterial)
		f15_arg0.parentContainer:addElement(LUI.UITimer.new(500, "close_all", true, f15_arg0))
	end
end

CoD.SurveillanceOverlayPOI.ScanReset = function (f16_arg0, f16_arg1)
	if f16_arg0.scanCircleOutline then
		f16_arg0.scanCircleOutline:setAlpha(0)
	end
	if f16_arg0.targetCircle then
		f16_arg0.targetCircle:setAlpha(0)
	end
	if f16_arg0.centerImage then
		f16_arg0.centerImage:setAlpha(0)
	end
	if f16_arg0.scanningText then
		f16_arg0.scanningText:beginAnimation("off")
		f16_arg0.scanningText:setAlpha(0)
	end
	if f16_arg0.centerImage.headshotTimer then
		f16_arg0.centerImage.headshotTimer:close()
	end
end

CoD.SurveillanceOverlayPOI.RandomHeadshots = function (f17_arg0, f17_arg1)
	if f17_arg0.headshotCount > CoD.SurveillanceOverlay.MaxHeadshots then
		f17_arg0.headshotCount = 1
	end
	f17_arg0:setImage(CoD.SurveillanceOverlay.Headshots[f17_arg0.headshotCount])
	f17_arg0.headshotCount = f17_arg0.headshotCount + 1
end

CoD.SurveillanceOverlayPOI.CloseAll = function (f18_arg0, f18_arg1)
	f18_arg0:close()
end

CoD.SurveillanceOverlayPOI.RecordingInit = function (f19_arg0, f19_arg1)
	f19_arg0.centerImage:setImage(CoD.SurveillanceOverlay.ExclamtionMaterial)
	f19_arg0.centerImage:setAlpha(0)
	if f19_arg0.containerElement then
		return 
	end
	local f19_local0 = 55
	local f19_local1 = 200
	local f19_local2 = 50
	f19_arg0.containerElement = LUI.UIElement.new()
	f19_arg0.containerElement:setLeftRight(true, false, f19_local0, f19_local0 + f19_local1)
	f19_arg0.containerElement:setTopBottom(false, false, -f19_local2, f19_local2)
	f19_arg0.containerElement:setupEntityContainer(f19_arg0.entityNum, 0, 0, 50)
	f19_arg0.containerElement:setEntityContainerScaleClamp(false)
	f19_arg0.parentContainer:addElement(f19_arg0.containerElement)
	if f19_arg0.isDefalco == true then
		local f19_local3 = CoD.SurveillanceOverlayPOI.CircleSize / 3 - 10
		f19_arg0.containerElement:setLeftRight(false, true, -f19_local1 - f19_local3, -f19_local3)
		f19_arg0.containerElement:setTopBottom(false, false, -f19_local2, f19_local2)
	end
	local f19_local3 = 40
	f19_arg0.photoNameParentContainer = LUI.UIElement.new()
	f19_arg0.photoNameParentContainer:setLeftRight(true, false, 0, f19_local1)
	f19_arg0.photoNameParentContainer:setTopBottom(true, false, 0, f19_local3)
	f19_arg0.containerElement:addElement(f19_arg0.photoNameParentContainer)
	if f19_arg0.isDefalco == true then
		local f19_local4 = 25
		f19_arg0.photoNameParentContainer:setTopBottom(true, false, f19_local4, f19_local3 + f19_local4)
	end
	local f19_local4 = 80
	local f19_local5 = -15
	local f19_local6 = -23
	local f19_local7 = LUI.UIImage.new()
	f19_local7:setLeftRight(true, false, f19_local5, f19_local4 + f19_local5)
	f19_local7:setTopBottom(true, false, f19_local6, f19_local4 + f19_local6)
	f19_local7:setImage(CoD.SurveillanceOverlay.MenendezHeadMaterial)
	f19_arg0.headshotImage = f19_local7
	f19_arg0.photoNameParentContainer:addElement(f19_local7)
	if f19_arg0.isDefalco == true then
		f19_local7:setLeftRight(false, true, -f19_local4 - f19_local5, -f19_local5)
	end
	local f19_local8 = f19_local4 + 2 * f19_local5
	local f19_local9 = -5
	local f19_local10 = LUI.UIText.new()
	f19_local10:setLeftRight(true, true, f19_local8, 0)
	f19_local10:setTopBottom(true, false, f19_local9, CoD.textSize.Default + f19_local9)
	f19_local10:setAlignment(LUI.Alignment.Left)
	f19_local10:setRGB(CoD.SurveillanceOverlayPOI.ScanColor.r, CoD.SurveillanceOverlayPOI.ScanColor.g, CoD.SurveillanceOverlayPOI.ScanColor.b)
	f19_arg0.photoNameParentContainer:addElement(f19_local10)
	f19_arg0.nameText = f19_local10
	f19_local10:setText(Engine.Localize("MENU_MENENDEZ_COMMA_RAUL"))
	if f19_arg0.isDefalco == true then
		local f19_local11 = f19_local4 + 2 * f19_local5
		local f19_local12 = -5
		f19_local10:setLeftRight(true, true, 0, -f19_local11)
		f19_local10:setAlignment(LUI.Alignment.Right)
	end
	if f19_arg0.isMenendez == true then
		local f19_local11 = 20
		local f19_local12 = LUI.UIImage.new()
		f19_local12:setLeftRight(true, true, f19_local8, 0)
		f19_local12:setTopBottom(false, true, -f19_local11, 0)
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, f19_local3, 0)
		f19_arg0.containerElement:addElement(Widget)
		local f19_local14 = 200
		local f19_local15 = 0
		local f19_local16 = 7
		f19_arg0.bar1 = CoD.SurveillanceOverlayPOI.AddScanBars(Widget, 1, f19_local15, f19_local16)
		f19_arg0.bar2 = CoD.SurveillanceOverlayPOI.AddScanBars(Widget, 1, f19_local15, f19_local16 + 10)
		local f19_local17 = f19_local3 + f19_local16 + 22
		local f19_local18 = LUI.UIText.new()
		f19_local18:setLeftRight(true, true, 0, 0)
		f19_local18:setTopBottom(true, false, f19_local17, CoD.textSize.Default + f19_local17)
		f19_local18:setRGB(CoD.SurveillanceOverlayPOI.ScanColor.r, CoD.SurveillanceOverlayPOI.ScanColor.g, CoD.SurveillanceOverlayPOI.ScanColor.b)
		f19_local18:setAlignment(LUI.Alignment.Left)
		f19_arg0.containerElement:addElement(f19_local18)
		f19_local18:setText("-- TB")
		f19_arg0.recordingTB = f19_local18
		f19_arg0:registerEventHandler("hud_pak_update_recording", CoD.SurveillanceOverlayPOI.UpdateRecording)
	end
end

CoD.SurveillanceOverlayPOI.AddScanBars = function (f20_arg0, f20_arg1, f20_arg2, f20_arg3)
	local f20_local0 = 6
	local f20_local1 = LUI.UIImage.new()
	f20_local1:setLeftRight(true, false, 0, 0)
	f20_local1:setTopBottom(true, false, f20_arg3, f20_local0 + f20_arg3)
	f20_local1:setRGB(CoD.SurveillanceOverlayPOI.ScanColor.r, CoD.SurveillanceOverlayPOI.ScanColor.g, CoD.SurveillanceOverlayPOI.ScanColor.b)
	f20_local1:setImage(CoD.SurveillanceOverlay.DotMaterial)
	f20_local1:setAlpha(1)
	f20_local1:registerEventHandler("random_bar_length", CoD.SurveillanceOverlayPOI.RandomBarLength)
	f20_arg0:addElement(f20_local1)
	return f20_local1
end

CoD.SurveillanceOverlayPOI.RandomBarLength = function (f21_arg0, f21_arg1)
	local f21_local0 = math.random(200)
	f21_arg0:beginAnimation("randomize_meter", 500)
	f21_arg0:setLeftRight(true, false, 0, f21_local0)
end

CoD.SurveillanceOverlayPOI.SetupDefalco = function (f22_arg0)
	f22_arg0:close()
end

CoD.SurveillanceOverlayPOI.UpdateRecording = function (f23_arg0, f23_arg1)
	local f23_local0 = f23_arg1.data[1]
	local f23_local1 = f23_local0 / 2
	f23_arg0.recordingTB:setText(f23_local0 .. " TB")
	f23_arg0.bar1:processEvent({
		name = "random_bar_length"
	})
	f23_arg0.bar2:processEvent({
		name = "random_bar_length"
	})
	if f23_arg0.scanningText.blink == true then
		f23_arg0.scanningText:beginAnimation("blink_off1", 500)
		f23_arg0.scanningText:setAlpha(0.3)
		f23_arg0.scanningText.blink = false
	elseif f23_arg0.scanningText.blink == false then
		f23_arg0.scanningText:beginAnimation("blink_on1", 500)
		f23_arg0.scanningText:setAlpha(1)
		f23_arg0.scanningText.blink = true
	end
end

CoD.SurveillanceOverlayPOI.Interference = function (f24_arg0, f24_arg1)
	local f24_local0 = f24_arg1.data[1]
	if f24_local0 == 1 then
		f24_arg0.photoNameParentContainer:setAlpha(0)
		f24_arg0.centerImage:setAlpha(1)
		f24_arg0.scanningText:setScanningText(Engine.Localize("MENU_INTERFERENCE_CAPS"))
	elseif f24_local0 == 0 then
		f24_arg0.photoNameParentContainer:setAlpha(1)
		f24_arg0.centerImage:setAlpha(0)
	end
end

CoD.SurveillanceOverlayPOI.POIVisibility = function (f25_arg0, f25_arg1)
	local f25_local0 = f25_arg1.data[1]
	local f25_local1 = f25_arg1.data[2]
	if not f25_local0 then
		return 
	elseif f25_local1 == 0 then
		if f25_local0 == f25_arg0.entityNum then
			f25_arg0.parentContainer:setAlpha(0)
		end
	elseif f25_local1 == 1 and f25_local0 == f25_arg0.entityNum then
		f25_arg0.parentContainer:beginAnimation("show", 1000)
		f25_arg0.parentContainer:setAlpha(1)
	end
end

