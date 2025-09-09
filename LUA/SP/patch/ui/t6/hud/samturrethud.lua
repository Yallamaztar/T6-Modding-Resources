CoD.SamHud = {}
CoD.SamHud.BaseColorOrange = CoD.orange
CoD.SamHud.BaseColor = {}
CoD.SamHud.BaseColor.r = 1
CoD.SamHud.BaseColor.g = 1
CoD.SamHud.BaseColor.b = 1
CoD.SamHud.AlphaEmpty = 1
CoD.SamHud.DefaultAlpha = 1
CoD.SamHud.BracketContainerHeight = 500
CoD.SamHud.BracketContainerWidth = 750
CoD.SamHud.BracketContainerZoom = 75
CoD.SamHud.BracketWidth = 40
CoD.SamHud.TopBarHeight = 64
CoD.SamHud.ArrowHeight = 16
CoD.SamHud.ArrowWidth = CoD.SamHud.ArrowHeight * 2
LUI.createMenu.SamTurretHud = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("SamTurretHud", f1_arg0)
	CoD.SamHud.BracketMaterial = RegisterMaterial("hud_sam_right")
	CoD.SamHud.MissileKeyLineMaterial = RegisterMaterial("hud_sam_rocketfill")
	CoD.SamHud.MissileFillMaterial = RegisterMaterial("hud_sam_rocketlines")
	CoD.SamHud.GPSMaterial = RegisterMaterial("hud_sam_plane")
	CoD.SamHud.GPSBackgroundMaterial = RegisterMaterial("hud_sam_grid_glow")
	CoD.SamHud.ArrowMaterial = RegisterMaterial("ui_arrow_right")
	CoD.SamHud.GlowMaterial = RegisterMaterial("hud_sam_glow")
	CoD.SamHud.SliderArrow = RegisterMaterial("hud_sam_slider_arrow")
	local f1_local1 = LUI.UIImage.new()
	f1_local1:setLeftRight(false, false, -640, 640)
	f1_local1:setTopBottom(false, false, -360, 360)
	f1_local1:setRGB(CoD.SamHud.BaseColor.r, CoD.SamHud.BaseColor.g, CoD.SamHud.BaseColor.b)
	f1_local1:setImage(CoD.SamHud.GlowMaterial)
	f1_local0:addElement(f1_local1)
	
	local bracketContainer = CoD.SamHud.CreateBracket(f1_local0)
	f1_local0:addElement(bracketContainer)
	f1_local0.bracketContainer = bracketContainer
	
	f1_local0:registerEventHandler("hud_missile_fire", CoD.SamHud.UpdateMissiles)
	f1_local0:registerEventHandler("hud_turret_zoom", CoD.SamHud.UpdateZoom)
	f1_local0:registerEventHandler("hud_update_vehicledata", CoD.SamHud.UpdateVehicleData)
	f1_local0:registerEventHandler("hud_update_refresh", CoD.SamHud.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.SamHud.UpdateVisibility)
	return f1_local0
end

CoD.SamHud.CreateBracket = function (f2_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.SamHud.BracketContainerWidth / 2, CoD.SamHud.BracketContainerWidth / 2)
	Widget:setTopBottom(false, false, -CoD.SamHud.BracketContainerHeight / 2, CoD.SamHud.BracketContainerHeight / 2)
	CoD.SamHud.AddCompass(Widget)
	local f2_local1 = 1
	local f2_local2 = -13
	local f2_local3 = -87
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -CoD.SamHud.BracketWidth + f2_local3, f2_local3)
	Widget:setTopBottom(true, true, -f2_local2, f2_local2)
	Widget:addElement(Widget)
	local f2_local5 = LUI.UIImage.new()
	f2_local5:setLeftRight(true, true, 0, 0)
	f2_local5:setTopBottom(true, true, 0, 0)
	f2_local5:setRGB(CoD.SamHud.BaseColor.r, CoD.SamHud.BaseColor.g, CoD.SamHud.BaseColor.b)
	f2_local5:setAlpha(f2_local1)
	f2_local5:setImage(CoD.SamHud.BracketMaterial)
	f2_local5:setYRot(180)
	f2_local5:setZRot(180)
	Widget:addElement(f2_local5)
	local f2_local6 = CoD.SamHud.BracketWidth / 2 - 2
	
	local rightBarArrow = LUI.UIImage.new()
	rightBarArrow:setLeftRight(false, true, -CoD.SamHud.ArrowWidth - f2_local6, -f2_local6)
	rightBarArrow:setTopBottom(false, false, -CoD.SamHud.ArrowHeight / 2, CoD.SamHud.ArrowHeight / 2)
	rightBarArrow:setRGB(1, 1, 1)
	rightBarArrow:setImage(CoD.SamHud.SliderArrow)
	Widget:addElement(rightBarArrow)
	Widget.rightBarArrow = rightBarArrow
	
	local f2_local8 = 25
	local f2_local9 = 90
	local f2_local10 = -80
	local f2_local11 = -13
	f2_arg0.missileStencilRight = {}
	f2_arg0.missileContainerRight = {}
	for f2_local12 = 1, 3, 1 do
		f2_arg0.missileContainerRight[f2_local12] = LUI.UIElement.new()
		f2_arg0.missileContainerRight[f2_local12]:setLeftRight(false, true, f2_local10 + f2_local8 * (f2_local12 - 1) - 5 * (f2_local12 - 1), f2_local10 + f2_local8 * f2_local12 - 5 * (f2_local12 - 1))
		f2_arg0.missileContainerRight[f2_local12]:setTopBottom(false, true, -f2_local11 - f2_local9, -f2_local11)
		f2_arg0.missileContainerRight[f2_local12]:registerEventHandler("reload_done", CoD.SamHud.MissileReloadDone)
		local Widget = LUI.UIImage.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:setRGB(CoD.SamHud.BaseColor.r, CoD.SamHud.BaseColor.g, CoD.SamHud.BaseColor.b)
		Widget:setAlpha(CoD.HUDAlphaFull)
		Widget:setImage(CoD.SamHud.MissileFillMaterial)
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:setUseStencil(true)
		f2_arg0.missileStencilRight[f2_local12] = Widget
		local leftBarArrow = LUI.UIImage.new()
		leftBarArrow:setLeftRight(true, true, 0, 0)
		leftBarArrow:setTopBottom(false, true, -f2_local9, 0)
		leftBarArrow:setRGB(CoD.SamHud.BaseColor.r, CoD.SamHud.BaseColor.g, CoD.SamHud.BaseColor.b)
		leftBarArrow:setImage(CoD.SamHud.MissileKeyLineMaterial)
		Widget:addElement(leftBarArrow)
		f2_arg0.missileContainerRight[f2_local12]:addElement(Widget)
		f2_arg0.missileContainerRight[f2_local12]:addElement(Widget)
		Widget:addElement(f2_arg0.missileContainerRight[f2_local12])
	end
	local f2_local12 = 80
	local f2_local13 = 70
	
	local missileStatusRightText = LUI.UIText.new()
	missileStatusRightText:setLeftRight(false, true, -f2_local12, -f2_local12)
	missileStatusRightText:setTopBottom(false, true, -f2_local13 - 20, -f2_local13)
	missileStatusRightText:setRGB(CoD.SamHud.BaseColorOrange.r, CoD.SamHud.BaseColorOrange.g, CoD.SamHud.BaseColorOrange.b)
	missileStatusRightText:setAlpha(0.5)
	missileStatusRightText:setAlignment(LUI.Alignment.Left)
	missileStatusRightText:setText("RDY")
	missileStatusRightText:registerEventHandler("reload_done", CoD.SamHud.ReloadDone)
	missileStatusRightText:registerEventHandler("on", CoD.SamHud.BlinkOn)
	missileStatusRightText:registerEventHandler("off", CoD.SamHud.BlinkOff)
	Widget:addElement(missileStatusRightText)
	f2_arg0.missileStatusRightText = missileStatusRightText
	
	local f2_local18 = -92
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, -f2_local18, CoD.SamHud.BracketWidth - f2_local18)
	Widget:setTopBottom(true, true, -f2_local2, f2_local2)
	Widget:addElement(Widget)
	local Widget = LUI.UIImage.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setRGB(CoD.SamHud.BaseColor.r, CoD.SamHud.BaseColor.g, CoD.SamHud.BaseColor.b)
	Widget:setAlpha(f2_local1)
	Widget:setImage(CoD.SamHud.BracketMaterial)
	Widget:setZRot(180)
	Widget:addElement(Widget)
	
	local leftBarArrow = LUI.UIImage.new()
	leftBarArrow:setLeftRight(true, false, f2_local6, CoD.SamHud.ArrowWidth + f2_local6)
	leftBarArrow:setTopBottom(false, false, -CoD.SamHud.ArrowHeight / 2, CoD.SamHud.ArrowHeight / 2)
	leftBarArrow:setRGB(1, 1, 1)
	leftBarArrow:setImage(CoD.SamHud.SliderArrow)
	leftBarArrow:setZRot(180)
	Widget:addElement(leftBarArrow)
	Widget.leftBarArrow = leftBarArrow
	
	f2_arg0.missileStencilLeft = {}
	f2_arg0.missileContainerLeft = {}
	local f2_local19 = 85
	for missileStatusLeftText = 1, 3, 1 do
		f2_arg0.missileContainerLeft[missileStatusLeftText] = LUI.UIElement.new()
		f2_arg0.missileContainerLeft[missileStatusLeftText]:setLeftRight(true, false, f2_local19 - f2_local8 * missileStatusLeftText + 5 * (missileStatusLeftText - 1), f2_local19 - f2_local8 * (missileStatusLeftText - 1) + 5 * (missileStatusLeftText - 1))
		f2_arg0.missileContainerLeft[missileStatusLeftText]:setTopBottom(false, true, -f2_local11 - f2_local9, -f2_local11)
		f2_arg0.missileContainerLeft[missileStatusLeftText]:registerEventHandler("reload_done", CoD.SamHud.MissileReloadDone)
		local f2_local23 = LUI.UIImage.new()
		f2_local23:setLeftRight(true, true, 0, 0)
		f2_local23:setTopBottom(true, true, 0, 0)
		f2_local23:setRGB(CoD.SamHud.BaseColor.r, CoD.SamHud.BaseColor.g, CoD.SamHud.BaseColor.b)
		f2_local23:setAlpha(CoD.HUDAlphaFull)
		f2_local23:setImage(CoD.SamHud.MissileFillMaterial)
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:setUseStencil(true)
		f2_arg0.missileStencilLeft[missileStatusLeftText] = Widget
		local f2_local25 = LUI.UIImage.new()
		f2_local25:setLeftRight(true, true, 0, 0)
		f2_local25:setTopBottom(false, true, -f2_local9, 0)
		f2_local25:setRGB(CoD.SamHud.BaseColor.r, CoD.SamHud.BaseColor.g, CoD.SamHud.BaseColor.b)
		f2_local25:setImage(CoD.SamHud.MissileKeyLineMaterial)
		Widget:addElement(f2_local25)
		f2_arg0.missileContainerLeft[missileStatusLeftText]:addElement(Widget)
		f2_arg0.missileContainerLeft[missileStatusLeftText]:addElement(f2_local23)
		Widget:addElement(f2_arg0.missileContainerLeft[missileStatusLeftText])
	end
	local missileStatusLeftText = LUI.UIText.new()
	missileStatusLeftText:setLeftRight(true, false, f2_local12, f2_local12)
	missileStatusLeftText:setTopBottom(false, true, -f2_local13 - 20, -f2_local13)
	missileStatusLeftText:setRGB(CoD.SamHud.BaseColorOrange.r, CoD.SamHud.BaseColorOrange.g, CoD.SamHud.BaseColorOrange.b)
	missileStatusLeftText:setAlpha(0.5)
	missileStatusLeftText:setAlignment(LUI.Alignment.Right)
	missileStatusLeftText:setText("RDY")
	missileStatusLeftText:registerEventHandler("reload_done", CoD.SamHud.ReloadDone)
	missileStatusLeftText:registerEventHandler("on", CoD.SamHud.BlinkOn)
	missileStatusLeftText:registerEventHandler("off", CoD.SamHud.BlinkOff)
	Widget:addElement(missileStatusLeftText)
	f2_arg0.missileStatusLeftText = missileStatusLeftText
	
	local f2_local21 = 60
	local f2_local22 = LUI.UIImage.new()
	f2_local22:setLeftRight(true, true, CoD.SamHud.BracketWidth, -CoD.SamHud.BracketWidth)
	f2_local22:setTopBottom(false, true, -f2_local21 - 14, 14)
	f2_local22:setRGB(1, 1, 1)
	f2_local22:setImage(CoD.SamHud.GPSMaterial)
	f2_local22:setShaderVector(0, 40, 2.75, 0, 0)
	f2_local22:setShaderVector(1, 0, 0, 0, 0)
	f2_local22:setShaderVector(2, 0.5, 0.22, 0, 0)
	Widget:addElement(f2_local22)
	
	local zoomText = LUI.UIText.new()
	zoomText:setLeftRight(false, false, 0, 1)
	zoomText:setTopBottom(false, true, -f2_local13 - CoD.textSize.Condensed + 5, -f2_local13)
	zoomText:setRGB(CoD.SamHud.BaseColor.r, CoD.SamHud.BaseColor.g, CoD.SamHud.BaseColor.b)
	zoomText:setAlpha(0)
	zoomText:setText("ZOOM X10")
	Widget:addElement(zoomText)
	Widget.zoomText = zoomText
	
	return Widget
end

CoD.SamHud.AddCompass = function (f3_arg0)
	local f3_local0 = -CoD.SamHud.TopBarHeight / 4
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -234, 234)
	Widget:setTopBottom(true, false, f3_local0, f3_local0 + CoD.SamHud.TopBarHeight)
	Widget:setAlpha(0.5)
	Widget:setImage(RegisterMaterial("hud_sam_compass"))
	Widget:setShaderVector(0, 1, -0.5, 0, 0)
	Widget:setupHorizontalCompass()
	f3_arg0:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -234, 234)
	Widget:setTopBottom(true, false, f3_local0 + 7, CoD.SamHud.TopBarHeight + f3_local0 + 1)
	f3_arg0:addElement(Widget)
	local f3_local3 = LUI.UIImage.new()
	f3_local3:setLeftRight(false, false, -CoD.SamHud.ArrowWidth / 2, CoD.SamHud.ArrowWidth / 2)
	f3_local3:setTopBottom(false, true, -CoD.SamHud.ArrowHeight + 20, 20)
	f3_local3:setRGB(CoD.SamHud.BaseColorOrange.r, CoD.SamHud.BaseColorOrange.g, CoD.SamHud.BaseColorOrange.b)
	f3_local3:setImage(CoD.SamHud.SliderArrow)
	f3_local3:setZRot(90)
	Widget:addElement(f3_local3)
end

CoD.SamHud.UpdateMissiles = function (f4_arg0, f4_arg1)
	if f4_arg1 ~= nil and f4_arg1.data ~= nil then
		local f4_local0 = f4_arg1.data[1]
		if f4_local0 % 2 ~= 0 then
			f4_local0 = math.floor(f4_local0 / 2) + 1
			if f4_arg0.missileStencilRight[f4_local0] ~= nil then
				f4_arg0.missileStencilRight[f4_local0]:beginAnimation("fired")
				f4_arg0.missileStencilRight[f4_local0]:setTopBottom(false, true, 0, 0)
				f4_arg0.missileStencilRight[f4_local0]:beginAnimation("reload", f4_arg1.data[2], true, true)
				f4_arg0.missileStencilRight[f4_local0]:setTopBottom(true, true, 0, 0)
			end
			if f4_arg0.missileContainerRight[f4_local0] ~= nil then
				f4_arg0.missileContainerRight[f4_local0]:beginAnimation("fired")
				f4_arg0.missileContainerRight[f4_local0]:setAlpha(0.4)
				f4_arg0.missileContainerRight[f4_local0]:addElement(LUI.UITimer.new(f4_arg1.data[2], "reload_done", true))
			end
			if f4_arg0.missileStatusRightText ~= nil and f4_arg0.missileStatusRightText.reloading == nil then
				f4_arg0.missileStatusRightText.reloading = true
				f4_arg0.missileStatusRightText:setText("WAIT")
				f4_arg0.missileStatusRightText:processEvent({
					name = "on"
				})
				f4_arg0.missileStatusRightText:addElement(LUI.UITimer.new(f4_arg1.data[2], "reload_done", true))
			end
		else
			f4_local0 = f4_local0 / 2
			if f4_arg0.missileStencilLeft[f4_local0] ~= nil then
				f4_arg0.missileStencilLeft[f4_local0]:beginAnimation("fired")
				f4_arg0.missileStencilLeft[f4_local0]:setTopBottom(false, true, 0, 0)
				f4_arg0.missileStencilLeft[f4_local0]:beginAnimation("reload", f4_arg1.data[2], true, true)
				f4_arg0.missileStencilLeft[f4_local0]:setTopBottom(true, true, 0, 0)
			end
			if f4_arg0.missileContainerLeft[f4_local0] ~= nil then
				f4_arg0.missileContainerLeft[f4_local0]:beginAnimation("fired")
				f4_arg0.missileContainerLeft[f4_local0]:setAlpha(0.4)
				f4_arg0.missileContainerLeft[f4_local0]:addElement(LUI.UITimer.new(f4_arg1.data[2], "reload_done", true))
			end
			if f4_arg0.missileStatusLeftText ~= nil and f4_arg0.missileStatusLeftText.reloading == nil then
				f4_arg0.missileStatusLeftText.reloading = true
				f4_arg0.missileStatusLeftText:setText("WAIT")
				f4_arg0.missileStatusLeftText:processEvent({
					name = "on"
				})
				f4_arg0.missileStatusLeftText:addElement(LUI.UITimer.new(f4_arg1.data[2], "reload_done", true))
			end
		end
	end
end

CoD.SamHud.ReloadDone = function (f5_arg0, f5_arg1)
	f5_arg0:setText("RDY")
	f5_arg0:beginAnimation("on")
	f5_arg0:setAlpha(1)
	f5_arg0.reloading = nil
end

CoD.SamHud.MissileReloadDone = function (f6_arg0, f6_arg1)
	f6_arg0:beginAnimation("reload_done")
	f6_arg0:setAlpha(1)
end

CoD.SamHud.UpdateZoom = function (f7_arg0, f7_arg1)
	if f7_arg1 ~= nil then
		local f7_local0 = f7_arg0.bracketContainer
		local f7_local1 = f7_local0.zoomText
		if f7_arg1.data[1] == 1 then
			f7_local0:beginAnimation("zoom", 50, true, true)
			f7_local0:setLeftRight(false, false, -CoD.SamHud.BracketContainerWidth / 2 - CoD.SamHud.BracketContainerZoom, CoD.SamHud.BracketContainerWidth / 2 + CoD.SamHud.BracketContainerZoom)
			f7_local1:setAlpha(1)
		elseif f7_arg1.data[1] == 0 then
			f7_local0:beginAnimation("default", 50, true, true)
			f7_local0:setLeftRight(false, false, -CoD.SamHud.BracketContainerWidth / 2, CoD.SamHud.BracketContainerWidth / 2)
			f7_local1:setAlpha(0)
		end
	end
end

CoD.SamHud.BlinkOn = function (f8_arg0, f8_arg1)
	if f8_arg0.reloading ~= nil then
		f8_arg0:beginAnimation("on")
		f8_arg0:setAlpha(1)
		f8_arg0:addElement(LUI.UITimer.new(250, "off", true))
	end
end

CoD.SamHud.BlinkOff = function (f9_arg0, f9_arg1)
	if f9_arg0.reloading ~= nil then
		f9_arg0:beginAnimation("off")
		f9_arg0:setAlpha(0)
		f9_arg0:addElement(LUI.UITimer.new(250, "on", true))
	end
end

CoD.SamHud.UpdateVehicleData = function (f10_arg0, f10_arg1)
	if f10_arg1 ~= nil and f10_arg1.pitch ~= nil then
		if f10_arg0.pitch == nil then
			f10_arg0.pitch = f10_arg1.pitch
		end
		local f10_local0 = (f10_arg1.pitch - f10_arg0.pitch) / 20
		if f10_local0 > 1 then
			f10_local0 = 1
		elseif f10_local0 < -1 then
			f10_local0 = -1
		end
		f10_arg0.pitch = CoD.SamHud.DiffTrack(f10_arg1.pitch, f10_arg0.pitch, 5, 0.1)
		local f10_local1 = CoD.SamHud.BracketContainerHeight / 2 - 60
		local f10_local2 = CoD.SamHud.ScalePitch(-46, 40, -f10_local1, f10_local1, f10_arg1.pitch)
		f10_arg0.bracketContainer.rightBarArrow:beginAnimation("pitch", 50, true, true)
		f10_arg0.bracketContainer.rightBarArrow:setTopBottom(false, false, -CoD.SamHud.ArrowHeight / 2 + f10_local2, CoD.SamHud.ArrowHeight / 2 + f10_local2)
		f10_arg0.bracketContainer.leftBarArrow:beginAnimation("pitch", 50, true, true)
		f10_arg0.bracketContainer.leftBarArrow:setTopBottom(false, false, -CoD.SamHud.ArrowHeight / 2 + f10_local2, CoD.SamHud.ArrowHeight / 2 + f10_local2)
	end
end

CoD.SamHud.ScalePitch = function (f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_arg4)
	if f11_arg4 < f11_arg0 then
		f11_arg4 = f11_arg0
	end
	if f11_arg1 < f11_arg4 then
		f11_arg4 = f11_arg1
	end
	return (f11_arg4 - f11_arg0) / (f11_arg1 - f11_arg0) * (f11_arg3 - f11_arg2) + f11_arg2
end

CoD.SamHud.DiffTrack = function (f12_arg0, f12_arg1, f12_arg2, f12_arg3)
	local f12_local0, f12_local1 = nil
	f12_local0 = f12_arg0 - f12_arg1
	f12_local1 = f12_arg2 * f12_local0 * f12_arg3
	if math.abs(f12_local0) > 0 then
		if math.abs(f12_local0) < math.abs(f12_local1) then
			return f12_arg0
		else
			return f12_arg1 + f12_local1
		end
	else
		return f12_arg0
	end
end

CoD.SamHud.UpdateVisibility = function (f13_arg0, f13_arg1)
	if UIExpression.IsVisibilityBitSet(f13_arg1.controller, CoD.BIT_UI_ACTIVE) == 0 then
		if f13_arg0.visible ~= true then
			f13_arg0:setAlpha(CoD.SamHud.DefaultAlpha)
			f13_arg0.visible = true
		end
	elseif f13_arg0.visible == true then
		f13_arg0:setAlpha(0)
		f13_arg0.visible = nil
	end
	f13_arg0:dispatchEventToChildren(f13_arg1)
end

