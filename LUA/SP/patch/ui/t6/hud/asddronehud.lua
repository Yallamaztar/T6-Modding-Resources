CoD.ASDDroneHud = {}
CoD.ASDDroneHud.DefaultAlpha = 1
LUI.createMenu.ASDDroneHud = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("ASDDroneHud", f1_arg0)
	f1_local0.id = f1_local0.id .. ".ASDDroneHud"
	f1_local0:registerEventHandler("hud_update_refresh", CoD.ASDDroneHud.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.ASDDroneHud.UpdateVisibility)
	local f1_local1 = RegisterMaterial("mp_hud_wasp_bracket")
	local f1_local2 = RegisterMaterial("hud_rts_mech_arrow")
	local f1_local3 = 64
	local f1_local4 = 512
	local f1_local5 = 400
	local f1_local6 = 128
	local f1_local7 = 32
	local f1_local8 = 390
	local f1_local9 = 4
	local f1_local10 = LUI.UIImage.new()
	f1_local10:setLeftRight(false, false, -f1_local5, -f1_local5 + f1_local3)
	f1_local10:setTopBottom(false, false, -f1_local4 / 2, f1_local4 / 2)
	f1_local10:setImage(f1_local1)
	f1_local0:addElement(f1_local10)
	local f1_local11 = LUI.UIImage.new()
	f1_local11:setLeftRight(false, false, f1_local5, f1_local5 - f1_local3)
	f1_local11:setTopBottom(false, false, -f1_local4 / 2, f1_local4 / 2)
	f1_local11:setImage(f1_local1)
	f1_local0:addElement(f1_local11)
	local f1_local12 = LUI.UIImage.new()
	f1_local12:setLeftRight(false, false, -f1_local8, -f1_local8 + f1_local6)
	f1_local12:setTopBottom(false, false, -f1_local7 / 2 - f1_local9, f1_local7 / 2 - f1_local9)
	f1_local12:setImage(f1_local2)
	f1_local0:addElement(f1_local12)
	local f1_local13 = LUI.UIImage.new()
	f1_local13:setLeftRight(false, false, f1_local8, f1_local8 - f1_local6)
	f1_local13:setTopBottom(false, false, -f1_local7 / 2 - f1_local9, f1_local7 / 2 - f1_local9)
	f1_local13:setImage(f1_local2)
	f1_local0:addElement(f1_local13)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -234, 234)
	Widget:setTopBottom(true, false, 0, 64)
	Widget:setImage(RegisterMaterial("hud_horizontal_compass"))
	Widget:setShaderVector(0, 1, -0.5, 0, 0)
	Widget:setupHorizontalCompass()
	f1_local0:addElement(Widget)
	local f1_local15 = LUI.UIImage.new()
	f1_local15:setLeftRight(false, false, -64, 64)
	f1_local15:setTopBottom(false, false, -32, 32)
	f1_local15:setImage(RegisterMaterial("mp_hud_agr_reticle"))
	f1_local0:addElement(f1_local15)
	return f1_local0
end

CoD.ASDDroneHud.UpdateVisibility = function (f2_arg0, f2_arg1)
	if UIExpression.IsVisibilityBitSet(f2_arg1.controller, CoD.BIT_UI_ACTIVE) == 0 then
		if f2_arg0.visible ~= true then
			f2_arg0:setAlpha(CoD.ASDDroneHud.DefaultAlpha)
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible == true then
		f2_arg0:setAlpha(0)
		f2_arg0.visible = nil
	end
	f2_arg0:dispatchEventToChildren(f2_arg1)
end

