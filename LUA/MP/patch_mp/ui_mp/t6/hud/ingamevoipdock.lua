CoD.IngameVoipDock = {}
CoD.IngameVoipDock.IconWidth = 24
CoD.IngameVoipDock.New = function (f1_arg0)
	local Widget = LUI.UIElement.new(f1_arg0)
	Widget:setupIngameTalkers()
	Widget:registerEventHandler("hud_update_refresh", CoD.IngameVoipDock.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.IngameVoipDock.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.IngameVoipDock.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.IngameVoipDock.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.IngameVoipDock.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.IngameVoipDock.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.IngameVoipDock.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC, CoD.IngameVoipDock.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.IngameVoipDock.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_SCOPED, CoD.IngameVoipDock.UpdateVisibility)
	Widget.visible = true
	return Widget
end

CoD.IngameVoipDock.UpdateVisibility = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_EMP_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_SCOREBOARD_OPEN) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_GUIDED_MISSILE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_SCOPED) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_VEHICLE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0 then
		if not f2_arg0.visible then
			f2_arg0:setAlpha(1)
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible then
		f2_arg0:setAlpha(0)
		f2_arg0.visible = nil
	end
end

