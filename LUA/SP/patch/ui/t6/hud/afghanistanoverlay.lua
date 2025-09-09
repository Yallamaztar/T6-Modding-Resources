CoD.AfghanistanOverlay = {}
CoD.AfghanistanOverlay.TargetTextFont = "Default"
CoD.AfghanistanOverlay.TextColor = CoD.visorBlue3
CoD.AfghanistanOverlay.DistanceTextAlpha = 1
CoD.AfghanistanOverlay.new = function ()
	CoD.AfghanistanOverlay.HindMaterial = RegisterMaterial("hud_afghan_hind")
	CoD.AfghanistanOverlay.TankMaterial = RegisterMaterial("hud_afghan_tank_t62")
	CoD.AfghanistanOverlay.AmmoMaterial = RegisterMaterial("hud_afghan_drop_ammo")
	CoD.AfghanistanOverlay.RPGMaterial = RegisterMaterial("hud_afghan_rpg")
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget.vehicleIconList = {}
	Widget:registerEventHandler("hud_afghan_update_ammo", CoD.AfghanistanOverlay.UpdateAmmoDrop)
	Widget:registerEventHandler("hud_afghan_update_rpg", CoD.AfghanistanOverlay.UpdateRPG)
	Widget:registerEventHandler("hud_afghan_add_vehicle_icon", CoD.AfghanistanOverlay.AddVehicleIcon)
	Widget:registerEventHandler("hud_afghan_remove_vehicle_icon", CoD.AfghanistanOverlay.RemoveVehicleIcon)
	return Widget
end

CoD.AfghanistanOverlay.AddIconContainer = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f2_arg0 / 2, f2_arg0 / 2)
	Widget:setTopBottom(false, false, -f2_arg1, 0)
	local f2_local1 = LUI.UIImage.new()
	f2_local1:setLeftRight(true, true, 0, 0)
	f2_local1:setTopBottom(true, true, 0, 0)
	f2_local1:setImage(f2_arg3)
	Widget:addElement(f2_local1)
	local f2_local2 = CoD.fonts[CoD.AfghanistanOverlay.TargetTextFont]
	local f2_local3 = CoD.textSize[CoD.AfghanistanOverlay.TargetTextFont]
	Widget.distanceText = LUI.UIText.new()
	Widget.distanceText:setLeftRight(true, true, 0, 0)
	Widget.distanceText:setTopBottom(true, false, f2_arg2, f2_local3 + f2_arg2)
	Widget.distanceText:setRGB(CoD.AfghanistanOverlay.TextColor.r, CoD.AfghanistanOverlay.TextColor.g, CoD.AfghanistanOverlay.TextColor.b)
	Widget.distanceText:setAlpha(CoD.AfghanistanOverlay.DistanceTextAlpha)
	Widget:addElement(Widget.distanceText)
	Widget.edgePointerContainer = LUI.UIElement.new()
	Widget.edgePointerContainer:setLeftRight(true, true, 0, 0)
	Widget.edgePointerContainer:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget.edgePointerContainer)
	local f2_local4 = 20
	local f2_local5 = f2_local4 * 2
	local f2_local6 = 30
	local f2_local7 = LUI.UIImage.new()
	f2_local7:setLeftRight(false, false, -f2_local4 / 2, f2_local4 / 2)
	f2_local7:setTopBottom(false, true, f2_local6, f2_local5 + f2_local6)
	f2_local7:setImage(RegisterMaterial("hud_monsoon_arrow"))
	f2_local7:setAlpha(0.3)
	Widget.edgePointerContainer:addElement(f2_local7)
	return Widget
end

CoD.AfghanistanOverlay.UpdateAmmoDrop = function (f3_arg0, f3_arg1)
	if not f3_arg1.data then
		if f3_arg0.ammoDropIconContainer then
			f3_arg0.ammoDropIconContainer:close()
			f3_arg0.ammoDropIconContainer = nil
		end
		return 
	end
	local f3_local0 = f3_arg1.data[1]
	local f3_local1 = f3_arg1.data[2]
	local f3_local2 = f3_arg1.data[3]
	local f3_local3 = f3_arg1.data[4] or 0
	if not f3_arg0.ammoDropIconContainer then
		local f3_local4 = 50
		f3_arg0.ammoDropIconContainer = CoD.AfghanistanOverlay.AddIconContainer(f3_local4, f3_local4 * 2, -15, CoD.AfghanistanOverlay.AmmoMaterial)
		f3_arg0:addElement(f3_arg0.ammoDropIconContainer)
		f3_arg0.ammoDropIconContainer:registerEventHandler("entity_container_clamped", CoD.AfghanistanOverlay.Clamped)
		f3_arg0.ammoDropIconContainer:registerEventHandler("entity_container_unclamped", CoD.AfghanistanOverlay.Unclamped)
	end
	f3_arg0.ammoDropIconContainer:setupEntityContainer(-1, f3_local0, f3_local1, f3_local2 + f3_local3)
	f3_arg0.ammoDropIconContainer:setEntityContainerClamp(true)
	f3_arg0.ammoDropIconContainer:setEntityContainerScaleClamp(true)
	f3_arg0.ammoDropIconContainer.distanceText:setupDistanceIndicator()
end

CoD.AfghanistanOverlay.UpdateRPG = function (f4_arg0, f4_arg1)
	if not f4_arg1.data then
		if f4_arg0.rpgIconContainer then
			f4_arg0.rpgIconContainer:close()
			f4_arg0.rpgIconContainer = nil
		end
		return 
	end
	local f4_local0 = f4_arg1.data[1]
	local f4_local1 = f4_arg1.data[2]
	local f4_local2 = f4_arg1.data[3]
	local f4_local3 = f4_arg1.data[4] or 0
	if not f4_arg0.rpgIconContainer then
		local f4_local4 = 100
		f4_arg0.rpgIconContainer = CoD.AfghanistanOverlay.AddIconContainer(f4_local4, f4_local4 / 4, 25, CoD.AfghanistanOverlay.RPGMaterial)
		f4_arg0:addElement(f4_arg0.rpgIconContainer)
		f4_arg0.rpgIconContainer:registerEventHandler("entity_container_clamped", CoD.AfghanistanOverlay.Clamped)
		f4_arg0.rpgIconContainer:registerEventHandler("entity_container_unclamped", CoD.AfghanistanOverlay.Unclamped)
	end
	f4_arg0.rpgIconContainer:setupEntityContainer(-1, f4_local0, f4_local1, f4_local2 + f4_local3)
	f4_arg0.rpgIconContainer:setEntityContainerClamp(true)
	f4_arg0.rpgIconContainer:setEntityContainerScaleClamp(true)
	f4_arg0.rpgIconContainer.distanceText:setupDistanceIndicator()
end

CoD.AfghanistanOverlay.Clamped = function (f5_arg0, f5_arg1)
	if f5_arg0.edgePointerContainer then
		f5_arg0.edgePointerContainer:setupEdgePointer(90)
		f5_arg0.distanceText:setAlpha(0)
	end
end

CoD.AfghanistanOverlay.Unclamped = function (f6_arg0, f6_arg1)
	if f6_arg0.edgePointerContainer then
		f6_arg0.edgePointerContainer:setupUIElement()
		f6_arg0.edgePointerContainer:setZRot(0)
		f6_arg0.distanceText:setAlpha(CoD.AfghanistanOverlay.DistanceTextAlpha)
	end
end

CoD.AfghanistanOverlay.AddNewVehiclePOI = function (f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = 85
	local f7_local1 = f7_local0 / 2
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f7_local0 / 2, f7_local0 / 2)
	Widget:setTopBottom(false, false, -f7_local1, 0)
	local f7_local3 = LUI.UIImage.new()
	f7_local3:setLeftRight(true, true, 0, 0)
	f7_local3:setTopBottom(true, true, 0, 0)
	f7_local3:setImage(f7_arg1)
	Widget:addElement(f7_local3)
	local f7_local4 = CoD.fonts[CoD.AfghanistanOverlay.TargetTextFont]
	local f7_local5 = CoD.textSize[CoD.AfghanistanOverlay.TargetTextFont]
	Widget.distanceText = LUI.UIText.new()
	Widget.distanceText:setLeftRight(true, true, 0, 0)
	Widget.distanceText:setTopBottom(true, false, f7_arg2, f7_local5 + f7_arg2)
	Widget.distanceText:setRGB(CoD.AfghanistanOverlay.TextColor.r, CoD.AfghanistanOverlay.TextColor.g, CoD.AfghanistanOverlay.TextColor.b)
	Widget.distanceText:setAlpha(CoD.AfghanistanOverlay.DistanceTextAlpha)
	Widget:addElement(Widget.distanceText)
	Widget.edgePointerContainer = LUI.UIElement.new()
	Widget.edgePointerContainer:setLeftRight(true, true, 0, 0)
	Widget.edgePointerContainer:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget.edgePointerContainer)
	local f7_local6 = 20
	local f7_local7 = f7_local6 * 2
	local f7_local8 = 0
	local f7_local9 = LUI.UIImage.new()
	f7_local9:setLeftRight(false, false, -f7_local6 / 2, f7_local6 / 2)
	f7_local9:setTopBottom(false, true, f7_local8, f7_local7 + f7_local8)
	f7_local9:setImage(RegisterMaterial("hud_monsoon_arrow"))
	f7_local9:setAlpha(0.3)
	Widget.edgePointerContainer:addElement(f7_local9)
	Widget:setupEntityContainer(f7_arg0, 0, 0, 100)
	Widget:setEntityContainerClamp(true)
	Widget:setEntityContainerScaleClamp(true)
	Widget.distanceText:setupDistanceIndicator()
	return Widget
end

local f0_local0 = 1
local f0_local1 = 2
CoD.AfghanistanOverlay.AddVehicleIcon = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg1.data[1]
	local f8_local1 = f8_arg1.data[2]
	local f8_local2, f8_local3 = nil
	if f8_local1 == f0_local0 then
		f8_local2 = CoD.AfghanistanOverlay.HindMaterial
		f8_local3 = -10
	elseif f8_local1 == f0_local1 then
		f8_local2 = CoD.AfghanistanOverlay.TankMaterial
		f8_local3 = -20
	end
	local f8_local4 = CoD.AfghanistanOverlay.AddNewVehiclePOI(f8_local0, f8_local2, f8_local3)
	f8_arg0:addElement(f8_local4)
	f8_local4:registerEventHandler("entity_container_clamped", CoD.AfghanistanOverlay.Clamped)
	f8_local4:registerEventHandler("entity_container_unclamped", CoD.AfghanistanOverlay.Unclamped)
	f8_local4.entityNum = f8_local0
	table.insert(f8_arg0.vehicleIconList, f8_local4)
end

CoD.AfghanistanOverlay.RemoveVehicleIcon = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg1.data[1]
	for f9_local1 = 1, #f9_arg0.vehicleIconList, 1 do
		if f9_arg0.vehicleIconList[f9_local1].entityNum == f9_local0 then
			f9_arg0.vehicleIconList[f9_local1]:close()
			table.remove(f9_arg0.vehicleIconList, f9_local1)
			return 
		end
	end
end

