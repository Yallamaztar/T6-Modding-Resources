CoD.Compass = {}
CoD.COMPASS_TYPE_PARTIAL = 0
CoD.COMPASS_TYPE_FULL = 1
CoD.Compass.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new(HudRef)
	local f1_local1 = LUI.UIContainer.new()
	f1_local1:setUseStencil(true)
	Widget:addElement(f1_local1)
	local f1_local2 = LUI.UIContainer.new()
	f1_local2:setupCompassUnderlay(InstanceRef)
	f1_local1:addElement(f1_local2)
	local f1_local3 = LUI.UIContainer.new()
	f1_local3:setupCompassItems(InstanceRef)
	Widget:addElement(f1_local3)
	local f1_local4 = LUI.UIContainer.new()
	f1_local4:setUseStencil(true)
	Widget:addElement(f1_local4)
	local f1_local5 = LUI.UIContainer.new()
	f1_local5:setupCompassOverlay(InstanceRef)
	f1_local4:addElement(f1_local5)
	return Widget
end

CoD.Compass.AddMinimap = function (f2_arg0)
	f2_arg0.compassScaleContainer = CoD.SplitscreenScaler.new(nil, 1.5)
	f2_arg0.compassScaleContainer:setLeftRight(true, false, 0, 0)
	f2_arg0.compassScaleContainer:setTopBottom(true, false, 0, 0)
	f2_arg0.safeArea:addElement(f2_arg0.compassScaleContainer)
	f2_arg0.miniMapContainer = LUI.UIContainer.new()
	f2_arg0.miniMapContainer:setLeftRight(true, false, 13, 163)
	f2_arg0.miniMapContainer:setTopBottom(true, false, 7, 187)
	f2_arg0.compassScaleContainer:addElement(f2_arg0.miniMapContainer)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(false, true, -32, -6)
	f2_arg0.miniMapContainer:addElement(Widget)
	local f2_local1 = LUI.UIImage.new()
	f2_local1:setLeftRight(true, true, 0, 0)
	f2_local1:setTopBottom(true, true, 0, 0)
	f2_local1:setRGB(0, 0, 0)
	f2_local1:setAlpha(0.25)
	Widget:addElement(f2_local1)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.25))
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -32,
		bottom = -6,
		red = 1,
		green = 1,
		blue = 1,
		material = RegisterMaterial("hud_horizontal_compass_minimap"),
		shaderVector0 = {
			0.67,
			0,
			0,
			0
		}
	})
	Widget:setupHorizontalCompass()
	f2_arg0.miniMapContainer:addElement(Widget)
	f2_arg0.miniMapContainer:addElement(CoD.Compass.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = -30
	}, CoD.COMPASS_TYPE_PARTIAL))
	f2_arg0.miniMapContainer:setAlpha(0)
	f2_arg0.miniMapContainer.visible = false
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_refresh", CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_COMPASS_VISIBLE, CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_THIRDPERSON, CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_SELECTING_LOCATION, CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_KILLCAM, CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_FLASH_BANGED, CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_SCOPED, CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_EXTRACAM_ON, CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.Compass.UpdateMinimapVisibility)
	f2_arg0.miniMapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_GAME_ENDED, CoD.Compass.UpdateMinimapVisibility)
end

CoD.Compass.UpdateMinimapVisibility = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1.controller
	if UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_EMP_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_COMPASS_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_DEMO_CAMERA_MODE_THIRDPERSON) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_SELECTING_LOCATION) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_IN_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_IS_FLASH_BANGED) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_IS_SCOPED) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_EXTRACAM_ON) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_SCOREBOARD_OPEN) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_GAME_ENDED) == 0 and (not CoD.IsShoutcaster(f3_arg1.controller) or CoD.ExeProfileVarBool(f3_arg1.controller, "shoutcaster_minimap") and Engine.IsSpectatingActiveClient(f3_local0)) then
		if not f3_arg0.visible then
			f3_arg0:setAlpha(1)
			f3_arg0.visible = true
		end
	elseif f3_arg0.visible then
		f3_arg0:setAlpha(0)
		f3_arg0.visible = nil
	end
end

CoD.Compass.AddInGameMap = function (f4_arg0, f4_arg1, f4_arg2)
	f4_arg0.mapContainer = LUI.UIElement.new(f4_arg2)
	f4_arg0:addElement(f4_arg0.mapContainer)
	local f4_local0 = CoD.Compass.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}, CoD.COMPASS_TYPE_FULL)
	f4_local0:setPriority(100)
	f4_arg0.mapContainer:addElement(f4_local0)
	f4_arg0.mapContainer:setAlpha(0)
	f4_arg0.mapContainer.visible = false
	f4_arg0.mapContainer:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.Compass.UpdateInGameMapVisibility)
	CoD.Compass.UpdateInGameMapVisibility(f4_arg0.mapContainer, {
		controller = f4_arg1
	})
end

CoD.Compass.UpdateInGameMapVisibility = function (f5_arg0, f5_arg1)
	if UIExpression.IsVisibilityBitSet(f5_arg1.controller, CoD.BIT_EMP_ACTIVE) == 0 then
		if not f5_arg0.visible then
			f5_arg0:setAlpha(1)
			f5_arg0.visible = true
		end
	elseif f5_arg0.visible then
		f5_arg0:setAlpha(0)
		f5_arg0.visible = nil
	end
end

