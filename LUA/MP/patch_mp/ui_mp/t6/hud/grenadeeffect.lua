CoD.GrenadeEffect = {}
CoD.GrenadeEffect.new = function ()
	local Widget = LUI.UIElement.new()
	Widget:setAlpha(0)
	local f1_local1, f1_local2 = Engine.GetUserSafeArea()
	
	local safeArea = LUI.UIElement.new()
	safeArea:setLeftRight(false, false, -f1_local1 / 2, f1_local1 / 2)
	safeArea:setTopBottom(false, false, -f1_local2 / 2, f1_local2 / 2)
	Widget:addElement(safeArea)
	Widget.safeArea = safeArea
	
	Widget:registerEventHandler("hud_update_refresh", CoD.GrenadeEffect.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_FINAL_KILLCAM, CoD.GrenadeEffect.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_ROUND_END_KILLCAM, CoD.GrenadeEffect.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.GrenadeEffect.UpdateVisibility)
	Widget:registerEventHandler("prox_grenade_notify", CoD.GrenadeEffect.GrenadeExplode)
	return Widget
end

CoD.GrenadeEffect.UpdateVisibility = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_FINAL_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_ROUND_END_KILLCAM) == 0 then
		if f2_arg0.visible ~= true then
			f2_arg0:setAlpha(1)
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible == true then
		f2_arg0:setAlpha(0)
		f2_arg0.visible = nil
	end
	f2_arg0:dispatchEventToChildren(f2_arg1)
end

CoD.GrenadeEffect.GrenadeExplode = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1.data[1]
	local f3_local1 = f3_arg1.data[2]
	local f3_local2 = f3_arg1.data[3]
	local f3_local3 = 30
	local f3_local4, f3_local5, f3_local6, f3_local7, f3_local8, f3_local9, f3_local10, f3_local11 = nil
	local f3_local12 = 80
	local f3_local13 = 200
	local f3_local14 = 512
	local f3_local15 = 256
	local f3_local16, f3_local17, f3_local18, f3_local19 = nil
	local f3_local20 = 1
	local f3_local21 = 0
	if f3_local0 <= f3_local3 then
		f3_local4 = 0
		f3_local5 = 30
		f3_local6 = 0
		f3_local7 = 0
		f3_local8 = 0
		f3_local9 = 256
		f3_local10 = 1
		f3_local11 = 1
		f3_local16 = math.random(f3_local4, f3_local5)
		f3_local17 = f3_local6 + f3_local2 / f3_local13 * (f3_local7 - f3_local6)
		f3_local18 = math.random(f3_local8, f3_local9)
		f3_local19 = f3_local10 + f3_local2 / f3_local13 * (f3_local11 - f3_local10)
		f3_local14 = f3_local14 * f3_local19
		f3_local15 = f3_local15 * f3_local19
		f3_local21 = 90
	else
		f3_local4 = 0
		f3_local5 = 30
		f3_local6 = 0
		f3_local7 = 0
		f3_local8 = 0
		f3_local9 = 256
		f3_local10 = 1
		f3_local11 = 1
		f3_local16 = 90 + math.random(f3_local4, f3_local5)
		f3_local17 = f3_local6 + f3_local2 / f3_local13 * (f3_local7 - f3_local6)
		f3_local18 = f3_local0 / f3_local12 * 320
		f3_local19 = f3_local10 + f3_local2 / f3_local13 * (f3_local11 - f3_local10)
		f3_local14 = f3_local14 * f3_local19
		f3_local15 = f3_local15 * f3_local19
		if f3_local1 > 90 then
			f3_local20 = -1
		end
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setAlpha(0)
	f3_arg0.safeArea:addElement(Widget)
	local f3_local23, f3_local24, f3_local25 = nil
	local f3_local26 = 0
	local f3_local27 = 30
	local f3_local28 = 512
	local f3_local29 = 256
	local f3_local30 = 0
	local f3_local31 = 0
	local f3_local32 = 0
	local f3_local33 = 256
	f3_local23 = f3_local21 + math.random(f3_local26, f3_local27)
	f3_local24 = math.random(f3_local30, f3_local31)
	f3_local25 = math.random(f3_local32, f3_local33)
	Widget:registerEventHandler("transition_complete_state_full_alpha", CoD.GrenadeEffect.SwitchToAlphaMed)
	Widget:registerEventHandler("transition_complete_state_alpha_med", CoD.GrenadeEffect.SwitchToZeroAlpha)
	Widget:registerEventHandler("transition_complete_state_alpha_zero", CoD.GrenadeEffect.CloseOut)
	Widget:beginAnimation("state_full_alpha", 100)
	Widget:setAlpha(1)
	Widget.image = dropletsImage
end

CoD.GrenadeEffect.SwitchToAlphaMed = function (f4_arg0, f4_arg1)
	if f4_arg1.interrupted ~= true then
		f4_arg0:beginAnimation("state_alpha_med", 1000, true, false)
		f4_arg0:setAlpha(0.7)
	end
end

CoD.GrenadeEffect.SwitchToZeroAlpha = function (f5_arg0, f5_arg1)
	if f5_arg1.interrupted ~= true then
		f5_arg0:beginAnimation("state_alpha_zero", 5000, false, true)
		f5_arg0:setAlpha(0)
	end
end

CoD.GrenadeEffect.CloseOut = function (f6_arg0, f6_arg1)
	if f6_arg1.interrupted ~= true then
		f6_arg0:close()
	end
end

