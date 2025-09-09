CoD.QRDroneHud = {}
CoD.QRDroneHud.DefaultAlpha = 1
LUI.createMenu.QRDroneHud = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("QRDroneHud", f1_arg0)
	f1_local0.id = f1_local0.id .. ".QRDroneHud"
	f1_local0:registerEventHandler("hud_update_refresh", CoD.QRDroneHud.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.QRDroneHud.UpdateVisibility)
	local f1_local1 = RegisterMaterial("mp_hud_wasp_bracket")
	local f1_local2 = 64
	local f1_local3 = 512
	local f1_local4 = 400
	local f1_local5 = LUI.UIImage.new()
	f1_local5:setLeftRight(false, false, -f1_local4, -f1_local4 + f1_local2)
	f1_local5:setTopBottom(false, false, -f1_local3 / 2, f1_local3 / 2)
	f1_local5:setImage(f1_local1)
	f1_local0:addElement(f1_local5)
	local f1_local6 = LUI.UIImage.new()
	f1_local6:setLeftRight(false, false, f1_local4, f1_local4 - f1_local2)
	f1_local6:setTopBottom(false, false, -f1_local3 / 2, f1_local3 / 2)
	f1_local6:setImage(f1_local1)
	f1_local0:addElement(f1_local6)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -234, 234)
	Widget:setTopBottom(true, false, 0, 64)
	Widget:setImage(RegisterMaterial("hud_horizontal_compass"))
	Widget:setShaderVector(0, 1, -0.5, 0, 0)
	Widget:setupHorizontalCompass()
	f1_local0:addElement(Widget)
	local f1_local8 = LUI.UIImage.new()
	f1_local8:setupRollLevel(1)
	f1_local8:setLeftRight(false, false, -256, 256)
	f1_local8:setTopBottom(false, false, -128, 128)
	f1_local8:setImage(RegisterMaterial("mp_hud_wasp_inner"))
	f1_local0:addElement(f1_local8)
	local f1_local9 = LUI.UIImage.new()
	f1_local9:setupRollLevel(-1)
	f1_local9:setLeftRight(false, false, -256, 256)
	f1_local9:setTopBottom(false, false, -256, 256)
	f1_local9:setImage(RegisterMaterial("mp_hud_wasp_outer"))
	f1_local0:addElement(f1_local9)
	local f1_local10 = LUI.UIImage.new()
	f1_local10:setLeftRight(false, false, -32, 32)
	f1_local10:setTopBottom(false, false, -32, 32)
	f1_local10:setImage(RegisterMaterial("mp_hud_wasp_crosshair"))
	f1_local0:addElement(f1_local10)
	return f1_local0
end

CoD.QRDroneHud.UpdateVisibility = function (f2_arg0, f2_arg1)
	if UIExpression.IsVisibilityBitSet(f2_arg1.controller, CoD.BIT_UI_ACTIVE) == 0 then
		if f2_arg0.visible ~= true then
			f2_arg0:setAlpha(CoD.QRDroneHud.DefaultAlpha)
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible == true then
		f2_arg0:setAlpha(0)
		f2_arg0.visible = nil
	end
	f2_arg0:dispatchEventToChildren(f2_arg1)
end

