CoD.GameTimer = InheritFrom(LUI.UIText)
local f0_local0, f0_local1, f0_local2 = nil
CoD.GameTimer.new = function ()
	local f1_local0 = LUI.UIText.new()
	f1_local0:setClass(CoD.GameTimer)
	f1_local0:setupGameTimer()
	f1_local0.visible = true
	return f1_local0
end

f0_local0 = function (f2_arg0, f2_arg1)
	if f2_arg1.low == true then
		f2_arg0:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	else
		f2_arg0:setRGB(1, 1, 1)
	end
end

f0_local2 = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1.controller
	if UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_BOMB_TIMER) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_BOMB_TIMER_A) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_BOMB_TIMER_B) == 0 then
		if f3_arg0.visible ~= true then
			f3_arg0:setAlpha(1)
			f3_arg0.visible = true
		end
	elseif f3_arg0.visible == true then
		f3_arg0:setAlpha(0)
		f3_arg0.visible = nil
	end
	f3_arg0:dispatchEventToChildren(f3_arg1)
end

CoD.GameTimer:registerEventHandler("hud_update_refresh", f0_local2)
CoD.GameTimer:registerEventHandler("hud_update_bit_" .. CoD.BIT_BOMB_TIMER, f0_local2)
CoD.GameTimer:registerEventHandler("hud_update_bit_" .. CoD.BIT_BOMB_TIMER_A, f0_local2)
CoD.GameTimer:registerEventHandler("hud_update_bit_" .. CoD.BIT_BOMB_TIMER_B, f0_local2)
CoD.GameTimer:registerEventHandler("countdown_low", f0_local0)
