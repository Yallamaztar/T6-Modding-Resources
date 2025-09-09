require("T6.HUD.SurveillanceOverlayPOI")
CoD.SurveillanceOverlay = {}
CoD.SurveillanceOverlay.MaxHeadshots = 9
CoD.SurveillanceOverlay.Headshots = {}
CoD.SurveillanceOverlay.SmallWindowWidth = 236
CoD.SurveillanceOverlay.SmallWindowHeight = 120
CoD.SurveillanceOverlay.BigWindowWidth = 410
CoD.SurveillanceOverlay.BigWindowHeight = 210
CoD.SurveillanceOverlay.ZoomTextType = "ExtraSmall"
CoD.SurveillanceOverlay.new = function ()
	CoD.SurveillanceOverlay.ExclamtionMaterial = RegisterMaterial("hud_pak_exclamation")
	CoD.SurveillanceOverlay.MenendezHeadMaterial = RegisterMaterial("hud_pak_menendez")
	CoD.SurveillanceOverlay.DefalcoHeadMaterial = RegisterMaterial("hud_pak_defalco")
	CoD.SurveillanceOverlay.BracketMaterial = RegisterMaterial("hud_pak_photo")
	CoD.SurveillanceOverlay.ScanCircleOutlineMaterial = RegisterMaterial("hud_pak_scan_circle")
	CoD.SurveillanceOverlay.ScanCircleMeterMaterial = RegisterMaterial("hud_pak_scan_circle_meter")
	CoD.SurveillanceOverlay.ScanComplete = RegisterMaterial("hud_pak_scan_complete")
	CoD.SurveillanceOverlay.TargetCircleMaterial = RegisterMaterial("hud_pak_target_circle")
	CoD.SurveillanceOverlay.DotMaterial = RegisterMaterial("hud_haiti_fly_hzn")
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget.id = Widget.id .. ".SurveillanceOverlay"
	for f1_local1 = 1, CoD.SurveillanceOverlay.MaxHeadshots, 1 do
		CoD.SurveillanceOverlay.Headshots[f1_local1] = RegisterMaterial("hud_pak_head0" .. f1_local1)
	end
	Widget.poiList = {}
	local f1_local1 = CoD.fonts[CoD.SurveillanceOverlay.ZoomTextType]
	local f1_local2 = CoD.textSize[CoD.SurveillanceOverlay.ZoomTextType]
	local f1_local3 = CoD.SurveillanceOverlay.SmallWindowWidth
	local f1_local4 = CoD.SurveillanceOverlay.SmallWindowHeight
	Widget.zoomValueText = LUI.UIText.new()
	Widget.zoomValueText:setLeftRight(false, false, -f1_local3 / 2, f1_local3 / 2)
	Widget.zoomValueText:setTopBottom(false, false, f1_local4 / 2, f1_local2 + f1_local4 / 2)
	Widget.zoomValueText:setAlignment(LUI.Alignment.Left)
	Widget.zoomValueText:setRGB(CoD.SurveillanceOverlayPOI.ScanColor.r, CoD.SurveillanceOverlayPOI.ScanColor.g, CoD.SurveillanceOverlayPOI.ScanColor.b)
	Widget.zoomValueText:setAlpha(0)
	Widget.zoomValueText:setText(Engine.Localize("MENU_ZOOM_CAPS") .. " 10X")
	Widget:addElement(Widget.zoomValueText)
	Widget:registerEventHandler("hud_pak_add_poi", CoD.SurveillanceOverlay.AddPOI)
	Widget:registerEventHandler("close_enemy_pois", CoD.SurveillanceOverlay.CloseEnemyPOIs)
	Widget:registerEventHandler("close_all_pois", CoD.SurveillanceOverlay.CloseAllPOIs)
	Widget:registerEventHandler("hud_pak_end_surveillance", CoD.SurveillanceOverlay.EndSurveillance)
	Widget:registerEventHandler("hud_pak_rec_visibility", CoD.SurveillanceOverlay.RecordingVisibility)
	Widget:registerEventHandler("hud_pak_toggle_zoom", CoD.SurveillanceOverlay.UpdateZoomValue)
	return Widget
end

CoD.SurveillanceOverlay.AddPOI = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.data[1]
	if not f2_local0 then
		return 
	end
	local f2_local1, f2_local2 = nil
	if f2_arg1.data[2] == 1 then
		f2_local1 = true
	elseif f2_arg1.data[2] == 2 then
		f2_local2 = true
	end
	local f2_local3 = CoD.SurveillanceOverlayPOI.new(f2_local0, f2_local1, f2_local2)
	f2_local3:setPriority(50)
	f2_arg0:addElement(f2_local3)
	table.insert(f2_arg0.poiList, f2_local3)
	if f2_arg1.data[3] and f2_arg1.data[3] == 1 then
		f2_arg0:processEvent({
			name = "setup_rec",
			delay = 0
		})
	end
end

CoD.SurveillanceOverlay.CloseEnemyPOIs = function (f3_arg0, f3_arg1)
	if f3_arg0.poiList then
		for f3_local0 = 1, #f3_arg0.poiList, 1 do
			if not f3_arg0.poiList[f3_local0].isMenendez and not f3_arg0.poiList[f3_local0].isDefalco then
				f3_arg0.poiList[f3_local0]:close()
				f3_arg0.poiList[f3_local0] = nil
			end
		end
	end
end

CoD.SurveillanceOverlay.CloseAllPOIs = function (f4_arg0, f4_arg1)
	if f4_arg0.poiList then
		for f4_local0 = 1, #f4_arg0.poiList, 1 do
			f4_arg0.poiList[f4_local0]:close()
			f4_arg0.poiList[f4_local0] = nil
		end
	end
end

CoD.SurveillanceOverlay.EndSurveillance = function (f5_arg0, f5_arg1)
	f5_arg0:close()
end

CoD.SurveillanceOverlay.RecordingVisibility = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.data[1]
	local f6_local1 = f6_arg1.data[2] or 100
	if f6_local0 == 0 then
		f6_arg0:beginAnimation("hide", f6_local1)
		f6_arg0:setAlpha(0)
		f6_arg0.zoomValueText:setAlpha(0)
	elseif f6_local0 == 1 then
		f6_arg0:beginAnimation("show", f6_local1)
		f6_arg0:setAlpha(1)
		f6_arg0.zoomValueText:setAlpha(1)
	end
end

CoD.SurveillanceOverlay.UpdateZoomValue = function (f7_arg0, f7_arg1)
	local f7_local0 = CoD.SurveillanceOverlay.SmallWindowWidth
	local f7_local1 = CoD.SurveillanceOverlay.SmallWindowHeight
	local f7_local2 = CoD.textSize[CoD.SurveillanceOverlay.ZoomTextType]
	local f7_local3
	if f7_arg1.data[1] ~= 0 then
		f7_local3 = true
	else
		f7_local3 = false
	end
	if f7_local3 == true then
		f7_local0 = CoD.SurveillanceOverlay.BigWindowWidth
		f7_local1 = CoD.SurveillanceOverlay.BigWindowHeight
	end
	if f7_arg0.zoomValueText then
		f7_arg0.zoomValueText:setLeftRight(false, false, -f7_local0 / 2, f7_local0 / 2)
		f7_arg0.zoomValueText:setTopBottom(false, false, f7_local1 / 2, f7_local2 + f7_local1 / 2)
		if f7_local3 == true then
			f7_arg0.zoomValueText:setText(Engine.Localize("MENU_ZOOM_CAPS") .. " 20X")
		else
			f7_arg0.zoomValueText:setText(Engine.Localize("MENU_ZOOM_CAPS") .. " 10X")
		end
	end
end

