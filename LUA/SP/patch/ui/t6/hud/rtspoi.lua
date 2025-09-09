CoD.RTSPOI = {}
CoD.RTSPOI.FontName = "Default"
CoD.RTSPOI.SecureMaterialName = "hud_rts_secure"
CoD.RTSPOI.CircleSize = 40
CoD.RTSPOI.ArrowMaterialNameGreen = "waypoint_circle_arrow_green"
CoD.RTSPOI.ArrowMaterialNameYellow = "waypoint_circle_arrow_yellow"
CoD.RTSPOI.new = function (f1_arg0, f1_arg1, f1_arg2)
	local Widget = nil
	if f1_arg2 then
		Widget = LUI.UIElement.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -CoD.RTSPOI.CircleSize / 2,
			right = CoD.RTSPOI.CircleSize / 2,
			topAnchor = false,
			bottomAnchor = false,
			top = -20 - CoD.textSize[CoD.RTSPOI.FontName],
			bottom = CoD.RTSPOI.CircleSize / 2
		})
		Widget:setupEntityContainer(f1_arg0, 0, 0, 30)
		Widget:setEntityContainerClamp(true)
		Widget:setEntityContainerFadeWhenTargeted(true)
		Widget.attachedToEntity = true
		Widget.alphaContainer = LUI.UIElement.new()
		Widget.alphaContainer:setLeftRight(true, true, 0, 0)
		Widget.alphaContainer:setTopBottom(true, true, 0, 0)
		Widget:addElement(Widget.alphaContainer)
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget.alphaContainer:addElement(Widget)
		Widget.edgePointerContainer = Widget
		local arrowImage = LUI.UIImage.new()
		arrowImage:setLeftRight(false, false, -CoD.RTSPOI.CircleSize / 3, CoD.RTSPOI.CircleSize / 3)
		arrowImage:setTopBottom(false, true, -CoD.RTSPOI.CircleSize / 2 + 3, -CoD.RTSPOI.CircleSize / 2 + CoD.RTSPOI.CircleSize * 2 / 3 + 3)
		arrowImage:setAlpha(0)
		Widget:addElement(arrowImage)
		Widget.arrowImage = arrowImage
		
		Widget:registerEventHandler("entity_container_clamped", CoD.RTSPOI.Clamped)
		Widget:registerEventHandler("entity_container_unclamped", CoD.RTSPOI.Unclamped)
	else
		local Widget, arrowImage = Engine.GetUserSafeArea()
		local f1_local3 = 50
		local f1_local4 = -110
		local f1_local5 = f1_local3 + (CoD.RTSPOI.CircleSize + 25) * (f1_arg1 - 1)
		Widget = LUI.UIElement.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -Widget / 2 + f1_local5,
			right = -Widget / 2 + f1_local5 + CoD.RTSPOI.CircleSize,
			topAnchor = false,
			bottomAnchor = false,
			top = f1_local4,
			bottom = f1_local4 + CoD.RTSPOI.CircleSize
		})
	end
	Widget.entityNum = f1_arg0
	Widget.poiNumber = f1_arg1
	Widget.changePulse = CoD.RTSPOI.ChangePulse
	Widget:registerEventHandler("rts_captured_poi", CoD.RTSPOI.Captured)
	Widget:registerEventHandler("rts_protect_poi", CoD.RTSPOI.Defend)
	Widget:registerEventHandler("rts_rescue_poi", CoD.RTSPOI.Rescue)
	Widget:registerEventHandler("rts_destroy_poi", CoD.RTSPOI.Destroy)
	Widget:registerEventHandler("rts_secure_poi", CoD.RTSPOI.Secure)
	Widget:registerEventHandler("rts_defend_poi", CoD.RTSPOI.Defend)
	Widget:registerEventHandler("rts_guard_poi", CoD.RTSPOI.Guard)
	Widget:registerEventHandler("rts_search_poi", CoD.RTSPOI.Search)
	Widget:registerEventHandler("rts_del_poi", CoD.RTSPOI.Remove)
	Widget:registerEventHandler("rts_update_pos_poi", CoD.RTSPOI.UpdatePosition)
	Widget:registerEventHandler("rts_hide_poi", CoD.RTSPOI.Hide)
	Widget:registerEventHandler("rts_unhide_poi", CoD.RTSPOI.Unhide)
	Widget:registerEventHandler("rts_pulse_poi", CoD.RTSPOI.Pulse)
	return Widget
end

CoD.RTSPOI.Clamped = function (f2_arg0, f2_arg1)
	if f2_arg0.edgePointerContainer then
		f2_arg0.edgePointerContainer:setupEdgePointer(90)
	end
end

CoD.RTSPOI.Unclamped = function (f3_arg0, f3_arg1)
	if f3_arg0.edgePointerContainer then
		f3_arg0.edgePointerContainer:setupUIElement()
		f3_arg0.edgePointerContainer:setZRot(0)
	end
end

CoD.RTSPOI.Captured = function (f4_arg0, f4_arg1)
	if f4_arg0.entityNum ~= f4_arg1.data[1] then
		return 
	elseif f4_arg0.image then
		f4_arg0.image:close()
		f4_arg0.image = nil
	end
	if f4_arg0.text then
		f4_arg0.text:close()
		f4_arg0.text = nil
	end
	if f4_arg0.distanceText then
		f4_arg0.distanceText:close()
		f4_arg0.distanceText = nil
	end
	if f4_arg0.progressBar then
		f4_arg0.progressBar:close()
		f4_arg0.progressBar = nil
	end
	if f4_arg0.edgePointerContainer then
		f4_arg0.edgePointerContainer:close()
		f4_arg0.edgePointerContainer = nil
	end
end

CoD.RTSPOI.Remove = function (f5_arg0, f5_arg1)
	if f5_arg0.entityNum ~= f5_arg1.data[1] then
		return 
	elseif f5_arg0.image then
		f5_arg0.image:close()
		f5_arg0.image = nil
	end
	if f5_arg0.text then
		f5_arg0.text:close()
		f5_arg0.text = nil
	end
	if f5_arg0.distanceText then
		f5_arg0.distanceText:close()
		f5_arg0.distanceText = nil
	end
	if f5_arg0.progressBar then
		f5_arg0.progressBar:close()
		f5_arg0.progressBar = nil
	end
	if f5_arg0.edgePointerContainer then
		f5_arg0.edgePointerContainer:close()
		f5_arg0.edgePointerContainer = nil
	end
end

CoD.RTSPOI.Destroy = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.data[1]
	if f6_arg0.entityNum ~= f6_local0 then
		return 
	elseif f6_arg0.poiNumber == 0 and f6_arg1.data[2] then
		f6_arg0.poiNumber = f6_arg1.data[2]
	end
	if f6_arg0.arrowImage then
		f6_arg0.arrowImage:setImage(RegisterMaterial(CoD.RTSPOI.ArrowMaterialNameYellow))
		f6_arg0.arrowImage:setAlpha(1)
	end
	CoD.RTSPOI.SetImage(f6_arg0, CoD.RTSPOI.GetMaterialName("waypoint_destroy_", f6_arg0.poiNumber))
	if not f6_arg0.progressBar then
		local f6_local1 = CoD.RTSPOI.CircleSize
		f6_arg0.progressBar = LUI.UIElement.new()
		f6_arg0.progressBar:setLeftRight(false, false, -f6_local1 / 2, f6_local1 / 2)
		f6_arg0.progressBar:setTopBottom(false, false, -f6_local1 / 2, f6_local1 / 2)
		f6_arg0.alphaContainer:addElement(f6_arg0.progressBar)
		local f6_local2 = LUI.UIImage.new()
		f6_local2:setLeftRight(true, true, 0, 0)
		f6_local2:setTopBottom(true, true, 0, 0)
		f6_local2:setImage(RegisterMaterial("hud_objective_circle_meter"))
		f6_local2:setRGB(0, 0, 0)
		f6_local2:setAlpha(0.25)
		f6_local2:setShaderVector(0, 1, 0, 0, 0)
		f6_arg0.progressBar:addElement(f6_local2)
		f6_arg0.progressBackground = f6_local2
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:setImage(RegisterMaterial("hud_objective_circle_meter"))
		Widget:setupRTSPOIBar(f6_local0)
		f6_arg0.progressBar:addElement(Widget)
		f6_arg0.progressMeter = Widget
	end
	local f6_local1 = f6_arg1.data[3]
	local f6_local2 = f6_arg1.data[4]
	local Widget = f6_arg1.data[5]
	if f6_local1 and f6_local2 and Widget then
		f6_arg0:setupEntityContainer(f6_local0, f6_local1, f6_local2, Widget)
	end
end

CoD.RTSPOI.Secure = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg1.data[1]
	if f7_arg0.entityNum ~= f7_local0 then
		return 
	elseif f7_arg0.arrowImage then
		f7_arg0.arrowImage:setImage(RegisterMaterial(CoD.RTSPOI.ArrowMaterialNameYellow))
		f7_arg0.arrowImage:setAlpha(1)
	end
	CoD.RTSPOI.SetImage(f7_arg0, CoD.RTSPOI.GetMaterialName("waypoint_capture_", f7_arg0.poiNumber))
	if not f7_arg0.progressBar then
		local f7_local1 = CoD.RTSPOI.CircleSize
		f7_arg0.progressBar = LUI.UIElement.new()
		f7_arg0.progressBar:setLeftRight(false, false, -f7_local1 / 2, f7_local1 / 2)
		f7_arg0.progressBar:setTopBottom(false, false, -f7_local1 / 2, f7_local1 / 2)
		f7_arg0.alphaContainer:addElement(f7_arg0.progressBar)
		local f7_local2 = LUI.UIImage.new()
		f7_local2:setLeftRight(true, true, 0, 0)
		f7_local2:setTopBottom(true, true, 0, 0)
		f7_local2:setImage(RegisterMaterial("hud_objective_circle_meter"))
		f7_local2:setRGB(0, 0, 0)
		f7_local2:setAlpha(0.25)
		f7_local2:setShaderVector(0, 1, 0, 0, 0)
		f7_arg0.progressBar:addElement(f7_local2)
		f7_arg0.progressBackground = f7_local2
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:setImage(RegisterMaterial("hud_objective_circle_meter"))
		Widget:setupRTSPOIBar(f7_local0)
		f7_arg0.progressBar:addElement(Widget)
		f7_arg0.progressMeter = Widget
	end
end

CoD.RTSPOI.Search = function (f8_arg0, f8_arg1)
	if f8_arg0.entityNum ~= f8_arg1.data[1] then
		return 
	elseif f8_arg0.arrowImage then
		f8_arg0.arrowImage:setImage(RegisterMaterial(CoD.RTSPOI.ArrowMaterialNameYellow))
		f8_arg0.arrowImage:setAlpha(1)
	end
	CoD.RTSPOI.SetImage(f8_arg0, "waypoint_search")
end

CoD.RTSPOI.Defend = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg1.data[1]
	if f9_arg0.entityNum ~= f9_local0 then
		return 
	elseif f9_arg0.arrowImage then
		f9_arg0.arrowImage:setImage(RegisterMaterial(CoD.RTSPOI.ArrowMaterialNameGreen))
		f9_arg0.arrowImage:setAlpha(1)
	end
	if f9_arg0.poiNumber == 0 and f9_arg1.data[2] then
		f9_arg0.poiNumber = f9_arg1.data[2]
	end
	CoD.RTSPOI.SetImage(f9_arg0, CoD.RTSPOI.GetMaterialName("waypoint_defend_", f9_arg0.poiNumber))
	if not f9_arg0.progressBar then
		local f9_local1 = CoD.RTSPOI.CircleSize
		f9_arg0.progressBar = LUI.UIElement.new()
		f9_arg0.progressBar:setLeftRight(false, false, -f9_local1 / 2, f9_local1 / 2)
		f9_arg0.progressBar:setTopBottom(false, false, -f9_local1 / 2, f9_local1 / 2)
		f9_arg0.alphaContainer:addElement(f9_arg0.progressBar)
		local f9_local2 = LUI.UIImage.new()
		f9_local2:setLeftRight(true, true, 0, 0)
		f9_local2:setTopBottom(true, true, 0, 0)
		f9_local2:setImage(RegisterMaterial("hud_objective_circle_meter"))
		f9_local2:setRGB(0, 0, 0)
		f9_local2:setAlpha(0.25)
		f9_local2:setShaderVector(0, 1, 0, 0, 0)
		f9_arg0.progressBar:addElement(f9_local2)
		f9_arg0.progressBackground = f9_local2
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:setImage(RegisterMaterial("hud_objective_circle_meter"))
		Widget:setupRTSPOIBar(f9_local0)
		f9_arg0.progressBar:addElement(Widget)
		f9_arg0.progressMeter = Widget
	end
end

CoD.RTSPOI.Guard = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg1.data[1]
	if f10_arg0.entityNum ~= f10_local0 then
		return 
	elseif f10_arg0.arrowImage then
		f10_arg0.arrowImage:setImage(RegisterMaterial(CoD.RTSPOI.ArrowMaterialNameGreen))
		f10_arg0.arrowImage:setAlpha(1)
	end
	CoD.RTSPOI.SetImage(f10_arg0, "waypoint_defend")
	if not f10_arg0.progressBar then
		local f10_local1 = CoD.RTSPOI.CircleSize
		f10_arg0.progressBar = LUI.UIElement.new()
		f10_arg0.progressBar:setLeftRight(false, false, -f10_local1 / 2, f10_local1 / 2)
		f10_arg0.progressBar:setTopBottom(false, false, -f10_local1 / 2, f10_local1 / 2)
		f10_arg0.alphaContainer:addElement(f10_arg0.progressBar)
		local f10_local2 = LUI.UIImage.new()
		f10_local2:setLeftRight(true, true, 0, 0)
		f10_local2:setTopBottom(true, true, 0, 0)
		f10_local2:setImage(RegisterMaterial("hud_objective_circle_meter"))
		f10_local2:setRGB(0, 0, 0)
		f10_local2:setAlpha(0.25)
		f10_local2:setShaderVector(0, 1, 0, 0, 0)
		f10_arg0.progressBar:addElement(f10_local2)
		f10_arg0.progressBackground = f10_local2
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:setImage(RegisterMaterial("hud_objective_circle_meter"))
		Widget:setupRTSPOIBar(f10_local0)
		f10_arg0.progressBar:addElement(Widget)
		f10_arg0.progressMeter = Widget
	end
end

CoD.RTSPOI.Rescue = function (f11_arg0, f11_arg1)
	local f11_local0 = f11_arg1.data[1]
	if f11_arg0.entityNum ~= f11_local0 then
		return 
	elseif f11_arg0.arrowImage then
		f11_arg0.arrowImage:setImage(RegisterMaterial(CoD.RTSPOI.ArrowMaterialNameGreen))
		f11_arg0.arrowImage:setAlpha(1)
	end
	CoD.RTSPOI.SetImage(f11_arg0, "waypoint_secure")
	if not f11_arg0.progressBar then
		local f11_local1 = CoD.RTSPOI.CircleSize
		f11_arg0.progressBar = LUI.UIElement.new()
		f11_arg0.progressBar:setLeftRight(false, false, -f11_local1 / 2, f11_local1 / 2)
		f11_arg0.progressBar:setTopBottom(false, false, -f11_local1 / 2, f11_local1 / 2)
		f11_arg0.alphaContainer:addElement(f11_arg0.progressBar)
		local f11_local2 = LUI.UIImage.new()
		f11_local2:setLeftRight(true, true, 0, 0)
		f11_local2:setTopBottom(true, true, 0, 0)
		f11_local2:setImage(RegisterMaterial("hud_objective_circle_meter"))
		f11_local2:setRGB(0, 0, 0)
		f11_local2:setAlpha(0.25)
		f11_local2:setShaderVector(0, 1, 0, 0, 0)
		f11_arg0.progressBar:addElement(f11_local2)
		f11_arg0.progressBackground = f11_local2
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:setImage(RegisterMaterial("hud_objective_circle_meter"))
		Widget:setupRTSPOIBar(f11_local0)
		f11_arg0.progressBar:addElement(Widget)
		f11_arg0.progressMeter = Widget
	end
end

CoD.RTSPOI.SetImage = function (f12_arg0, f12_arg1)
	if not f12_arg0.image then
		local f12_local0 = CoD.RTSPOI.CircleSize - 4
		f12_arg0.image = LUI.UIImage.new()
		f12_arg0.image:setLeftRight(false, false, -f12_local0 / 2, f12_local0 / 2)
		f12_arg0.image:setTopBottom(false, false, -f12_local0 / 2, f12_local0 / 2)
		f12_arg0.image.id = f12_arg0.image.id .. ".RTSPOI.Image"
		f12_arg0.alphaContainer:addElement(f12_arg0.image)
	end
	f12_arg0.image:setImage(RegisterMaterial(f12_arg1))
end

CoD.RTSPOI.UpdatePosition = function (f13_arg0, f13_arg1)
	local f13_local0 = f13_arg1.data[1]
	local f13_local1 = f13_arg1.data[2]
	local f13_local2 = f13_arg1.data[3]
	local f13_local3 = f13_arg1.data[4]
	if f13_arg0.entityNum ~= f13_local0 then
		return 
	elseif f13_local1 and f13_local2 and f13_local3 then
		f13_arg0:setupEntityContainer(f13_local0, f13_local1, f13_local2, f13_local3)
	end
end

CoD.RTSPOI.Hide = function (f14_arg0, f14_arg1)
	if f14_arg0.alphaContainer == nil or f14_arg0.entityNum ~= f14_arg1.data[1] then
		return 
	elseif f14_arg0.isPulsing then
		f14_arg0:changePulse(false)
	end
	f14_arg0.hidden = true
	f14_arg0.alphaContainer:setAlpha(0)
end

CoD.RTSPOI.Unhide = function (f15_arg0, f15_arg1)
	if f15_arg0.alphaContainer == nil or f15_arg0.entityNum ~= f15_arg1.data[1] then
		return 
	elseif f15_arg0.isPulsing then
		f15_arg0:changePulse(true)
	end
	f15_arg0.hidden = false
	f15_arg0.alphaContainer:setAlpha(1)
end

CoD.RTSPOI.Pulse = function (f16_arg0, f16_arg1)
	if f16_arg0.entityNum ~= f16_arg1.data[1] then
		return 
	end
	local f16_local0 = f16_arg1.data[2] == 1
	if not f16_arg0.isPulsing and f16_local0 then
		if not f16_arg0.hidden then
			f16_arg0:changePulse(true)
		end
		f16_arg0.isPulsing = true
	elseif f16_arg0.isPulsing and not f16_local0 then
		if not f16_arg0.hidden then
			f16_arg0:changePulse(false)
		end
		f16_arg0.isPulsing = false
	end
end

local f0_local0 = function (f17_arg0, f17_arg1)
	f17_arg0:beginAnimation("turn_red", f17_arg1)
	f17_arg0:setRGB(1, 0, 0)
end

local f0_local1 = function (f18_arg0, f18_arg1)
	f18_arg0:beginAnimation("turn_black", f18_arg1)
	f18_arg0:setRGB(0, 0, 0)
end

local f0_local2 = function (f19_arg0, f19_arg1)
	f19_arg0:beginAnimation("turn_white", f19_arg1)
	f19_arg0:setRGB(1, 1, 1)
end

CoD.RTSPOI.ChangePulse = function (f20_arg0, f20_arg1)
	if not f20_arg0.isPulsing and f20_arg1 then
		local f20_local0 = 400
		f20_arg0.progressBackground:alternateStates(0, f0_local0, f0_local1, f20_local0, f20_local0)
		f20_arg0.progressMeter:alternateStates(0, f0_local0, f0_local2, f20_local0, f20_local0)
	elseif f20_arg0.isPulsing and not f20_arg1 then
		f20_arg0.progressBackground:closeStateAlternator()
		f20_arg0.progressMeter:closeStateAlternator()
	end
end

CoD.RTSPOI.GetMaterialName = function (f21_arg0, f21_arg1)
	if f21_arg0 == nil then
		return ""
	end
	local f21_local0 = ""
	if f21_arg1 == 1 then
		f21_local0 = "a"
	elseif f21_arg1 == 2 then
		f21_local0 = "b"
	elseif f21_arg1 == 3 then
		f21_local0 = "c"
	elseif f21_arg1 == 4 then
		f21_local0 = "d"
	else
		DebugPrint("LUA Warning: received unknown poiNumber in CoD.RTSPOI.GetMaterialName")
	end
	return f21_arg0 .. f21_local0
end

