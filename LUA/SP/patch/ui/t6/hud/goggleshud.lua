CoD.GogglesHud = {}
CoD.GogglesHud.DefaultAlpha = 1
CoD.GogglesHud.BlueColor = CoD.greenBlue
CoD.GogglesHud.LineAlpha = 0.25
CoD.GogglesHud.MidLineWidth = 550
CoD.GogglesHud.MidLineHeight = CoD.GogglesHud.MidLineWidth / 2
CoD.GogglesHud.CircleSize = 150
LUI.createMenu.GogglesHud = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("GogglesHud", f1_arg0)
	local f1_local1, f1_local2 = Engine.GetUserSafeArea()
	CoD.GogglesHud.VerticalLineHeight = f1_local2 * 0.75
	CoD.GogglesHud.HorizontalLineWidth = f1_local1 * 0.75
	f1_local0.hudContainer = LUI.UIElement.new()
	f1_local0.hudContainer:setLeftRight(true, true, 0, 0)
	f1_local0.hudContainer:setTopBottom(true, true, 0, 0)
	f1_local0.hudContainer:setAlpha(0)
	f1_local0.hudContainer:registerEventHandler("hud_goggles_add_poi", CoD.GogglesHud.AddPOI)
	f1_local0.hudContainer:registerEventHandler("hud_goggles_clear_all_poi", CoD.GogglesHud.ClearAllPOI)
	f1_local0.hudContainer:registerEventHandler("hud_goggles_update_zoom", CoD.GogglesHud.UpdateZoom)
	f1_local0:addElement(f1_local0.hudContainer)
	f1_local0.hudContainer.poiList = {}
	f1_local0.hudContainer:beginAnimation("fade_in", 1000)
	f1_local0.hudContainer:setAlpha(1)
	CoD.GogglesHud.TargetCircleMaterial = RegisterMaterial("hud_pak_target_circle")
	CoD.GogglesHud.DotMaterial = RegisterMaterial("hud_haiti_fly_hzn")
	CoD.GogglesHud.SetupCenterGrid(f1_local0.hudContainer)
	CoD.GogglesHud.AddVerticalLineElements(f1_local0.hudContainer)
	CoD.GogglesHud.HorizontalLineElements(f1_local0.hudContainer)
	f1_local0:registerEventHandler("hud_goggles_off", CoD.GogglesHud.TurnOff)
	f1_local0:registerEventHandler("hud_update_refresh", CoD.GogglesHud.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.GogglesHud.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.GogglesHud.UpdateVisibility)
	return f1_local0
end

CoD.GogglesHud.SetupCenterGrid = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = RegisterMaterial("hud_monsoon_surveli_grid")
	local f2_local1 = RegisterMaterial("hud_pak_crosshair")
	local f2_local2 = 256
	local f2_local3 = LUI.UIImage.new()
	f2_local3:setLeftRight(false, false, -f2_local2 / 2, f2_local2 / 2)
	f2_local3:setTopBottom(false, false, -f2_local2 / 2, f2_local2 / 2)
	f2_local3:setImage(f2_local0)
	f2_arg0:addElement(f2_local3)
	local f2_local4 = LUI.UIImage.new()
	f2_local4:setLeftRight(false, false, -1, 1)
	f2_local4:setTopBottom(false, false, -CoD.GogglesHud.VerticalLineHeight / 2, CoD.GogglesHud.VerticalLineHeight / 2)
	f2_local4:setImage(CoD.GogglesHud.DotMaterial)
	f2_local4:setAlpha(CoD.GogglesHud.LineAlpha)
	f2_arg0:addElement(f2_local4)
	local f2_local5 = LUI.UIImage.new()
	f2_local5:setLeftRight(false, false, -CoD.GogglesHud.HorizontalLineWidth / 2, CoD.GogglesHud.HorizontalLineWidth / 2)
	f2_local5:setTopBottom(false, false, -1, 1)
	f2_local5:setAlpha(CoD.GogglesHud.LineAlpha)
	f2_local5:setImage(CoD.GogglesHud.DotMaterial)
	f2_arg0:addElement(f2_local5)
	local f2_local6 = 50
	local f2_local7 = LUI.UIImage.new()
	f2_local7:setLeftRight(false, false, -f2_local6 / 2, f2_local6 / 2)
	f2_local7:setTopBottom(false, false, -f2_local6 / 2, f2_local6 / 2)
	f2_local7:setImage(f2_local1)
	f2_local7:setAlpha(0.5)
	f2_arg0:addElement(f2_local7)
end

CoD.GogglesHud.AddVerticalLineElements = function (f3_arg0)
	local f3_local0 = CoD.fonts.Default
	local f3_local1 = CoD.textSize.Default
	local f3_local2 = 100
	local f3_local3 = LUI.UIText.new()
	f3_local3:setLeftRight(false, false, -50, 50)
	f3_local3:setTopBottom(false, false, -f3_local1 / 2 + f3_local2, f3_local1 / 2 + f3_local2)
	f3_local3:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f3_local3:setFont(f3_local0)
	f3_arg0:addElement(f3_local3)
	f3_local3:setText("DTT")
	local f3_local4 = f3_local2 + f3_local1 + 10
	local f3_local5 = LUI.UIText.new()
	f3_local5:setLeftRight(false, false, -50, 50)
	f3_local5:setTopBottom(false, false, -f3_local1 / 2 + f3_local4, f3_local1 / 2 + f3_local4)
	f3_local5:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f3_local5:setFont(f3_local0)
	f3_arg0:addElement(f3_local5)
	f3_local5:setText(2408 .. " M")
end

CoD.GogglesHud.AddScanBars = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	local f4_local0 = 6
	local f4_local1 = LUI.UIImage.new()
	f4_local1:setLeftRight(true, false, 0, 0)
	f4_local1:setTopBottom(true, false, f4_arg3, f4_local0 + f4_arg3)
	f4_local1:setImage(CoD.GogglesHud.DotMaterial)
	f4_local1:registerEventHandler("random_bar_length", CoD.GogglesHud.RandomBarLength)
	f4_arg0:addElement(f4_local1)
	return f4_local1
end

CoD.GogglesHud.RandomBarLength = function (f5_arg0, f5_arg1)
	local f5_local0 = math.random(200)
	f5_arg0:beginAnimation("randomize_meter", f5_arg1.timer.interval)
	f5_arg0:setLeftRight(true, false, 0, f5_local0)
	f5_arg1.timer.interval = math.random(750, 1000)
end

CoD.GogglesHud.HorizontalLineElements = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = CoD.fonts.Default
	local f6_local1 = CoD.textSize.Default
	local f6_local2 = f6_local1 + 5
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.GogglesHud.HorizontalLineWidth / 2, 0)
	Widget:setTopBottom(false, false, -f6_local2, 0)
	f6_arg0:addElement(Widget)
	local f6_local4 = LUI.UIText.new()
	f6_local4:setLeftRight(true, true, 0, 0)
	f6_local4:setTopBottom(true, false, 0, f6_local1)
	f6_local4:setFont(f6_local0)
	f6_local4:setAlignment(LUI.Alignment.Left)
	f6_local4:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f6_local4:setAlpha(1)
	Widget:addElement(f6_local4)
	f6_local4:setText("E/DTC")
	local f6_local5 = 55
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f6_local5, f6_local5 + 20)
	Widget:setTopBottom(true, false, 0, f6_local1)
	Widget:addElement(Widget)
	local f6_local7 = LUI.UIImage.new()
	f6_local7:setLeftRight(true, true, 0, 0)
	f6_local7:setTopBottom(true, true, 0, 0)
	f6_local7:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f6_local7:setAlpha(0.5)
	Widget:addElement(f6_local7)
	local f6_local8 = LUI.UIText.new()
	f6_local8:setLeftRight(true, true, 0, 0)
	f6_local8:setTopBottom(true, false, 0, f6_local1)
	f6_local8:setFont(f6_local0)
	f6_local8:setAlignment(LUI.Alignment.Center)
	f6_local8:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f6_local8:setAlpha(1)
	Widget:addElement(f6_local8)
	f6_local8:setText("4")
	local f6_local9 = f6_local5 + f6_local5 + 20
	local f6_local10 = 55
	local f6_local11 = 200
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f6_local9, f6_local11 + f6_local9)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local f6_local13 = 7
	local f6_local14 = CoD.GogglesHud.AddScanBars(Widget, 1, f6_local9, f6_local13)
	local f6_local15 = CoD.GogglesHud.AddScanBars(Widget, 1, f6_local9, f6_local13 + 10)
	Widget:addElement(LUI.UITimer.new(500, "random_bar_length", false, f6_local14))
	Widget:addElement(LUI.UITimer.new(500, "random_bar_length", false, f6_local15))
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.GogglesHud.HorizontalLineWidth / 2, 0)
	Widget:setTopBottom(false, false, 0, f6_local2)
	f6_arg0:addElement(Widget)
	local f6_local17 = LUI.UIText.new()
	f6_local17:setLeftRight(true, true, 0, 0)
	f6_local17:setTopBottom(false, true, -f6_local1, 0)
	f6_local17:setFont(f6_local0)
	f6_local17:setAlignment(LUI.Alignment.Left)
	f6_local17:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f6_local17:setAlpha(1)
	Widget:addElement(f6_local17)
	f6_local17:setText("GPS 21.11010293")
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, 0, CoD.GogglesHud.HorizontalLineWidth / 2)
	Widget:setTopBottom(false, false, 0, f6_local2)
	f6_arg0:addElement(Widget)
	local f6_local19 = 55
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -60, 0)
	Widget:setTopBottom(true, false, 0, f6_local1)
	Widget:addElement(Widget)
	local f6_local21 = LUI.UIImage.new()
	f6_local21:setLeftRight(true, true, 0, 0)
	f6_local21:setTopBottom(true, true, 0, 0)
	f6_local21:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f6_local21:setAlpha(0.3)
	Widget:addElement(f6_local21)
	local f6_local22 = LUI.UIText.new()
	f6_local22:setLeftRight(true, true, 0, 0)
	f6_local22:setTopBottom(true, false, 0, f6_local1)
	f6_local22:setFont(f6_local0)
	f6_local22:setAlignment(LUI.Alignment.Center)
	f6_local22:setRGB(CoD.WingsuitHud.BlueColor.r, CoD.WingsuitHud.BlueColor.g, CoD.WingsuitHud.BlueColor.b)
	f6_local22:setAlpha(1)
	Widget:addElement(f6_local22)
	f6_local22:setText("X 1000")
	f6_arg0.zoomText = f6_local22
end

CoD.GogglesHud.TurnOff = function (f7_arg0, f7_arg1)
	if f7_arg0 then
		f7_arg0:close()
	end
end

CoD.GogglesHud.AddPOI = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg1.data[1]
	if not f8_local0 then
		return 
	end
	local f8_local1 = f8_arg1.data[2] or 30
	local f8_local2 = f8_arg1.data[3]
	local f8_local3 = f8_arg1.data[4]
	local f8_local4 = f8_arg1.data[5]
	if not f8_local2 then
		f8_local2 = 0
	end
	if not f8_local3 then
		f8_local3 = 0
	end
	if not f8_local4 then
		f8_local4 = 0
	end
	local f8_local5 = CoD.GogglesHud.AddPOITarget(f8_local0, f8_local2, f8_local3, f8_local4, f8_local1)
	f8_local5:setPriority(50)
	f8_arg0:addElement(f8_local5)
	table.insert(f8_arg0.poiList, f8_local5)
end

CoD.GogglesHud.AddPOITarget = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4)
	local f9_local0 = CoD.GogglesHud.CircleSize
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f9_local0 / 2, f9_local0 / 2)
	Widget:setTopBottom(false, false, -f9_local0 / 2, f9_local0 / 2)
	Widget.id = Widget.id .. ".GogglesPOI"
	Widget:setupEntityContainer(f9_arg0, f9_arg1, f9_arg2, f9_arg3 + f9_arg4)
	local f9_local2 = LUI.UIImage.new()
	f9_local2:setLeftRight(true, true, 0, 0)
	f9_local2:setTopBottom(true, true, 0, 0)
	f9_local2:setImage(CoD.GogglesHud.TargetCircleMaterial)
	f9_local2.id = f9_local2.id .. ".TargetCircle"
	Widget:addElement(f9_local2)
	Widget.entityNum = f9_arg0
	return Widget
end

CoD.GogglesHud.ClearAllPOI = function (f10_arg0, f10_arg1)
	if f10_arg0.poiList then
		for f10_local0 = 1, #f10_arg0.poiList, 1 do
			f10_arg0.poiList[f10_local0]:close()
		end
	end
end

CoD.GogglesHud.UpdateZoom = function (f11_arg0, f11_arg1)
	local f11_local0 = f11_arg1.data[1]
	if not f11_local0 then
		return 
	elseif f11_arg0.zoomText then
		f11_arg0.zoomText:setText("X " .. f11_local0)
	end
end

CoD.GogglesHud.UpdateVisibility = function (f12_arg0, f12_arg1)
	local f12_local0 = f12_arg1.controller
	if UIExpression.IsVisibilityBitSet(f12_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f12_local0, CoD.BIT_UI_ACTIVE) == 0 then
		if f12_arg0.visible ~= true then
			f12_arg0:setAlpha(CoD.GogglesHud.DefaultAlpha)
			f12_arg0.visible = true
		end
	elseif f12_arg0.visible == true then
		f12_arg0:setAlpha(0)
		f12_arg0.visible = nil
	end
	f12_arg0:dispatchEventToChildren(f12_arg1)
end

