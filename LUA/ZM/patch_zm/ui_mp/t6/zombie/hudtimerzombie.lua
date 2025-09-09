CoD.GameTimerZombie = {}
CoD.GameTimerZombie.LeftOffset = 24
CoD.GameTimerZombie.TopOffset = -25
CoD.GameTimerZombie.Size = 64
LUI.createMenu.TimerAreaZM = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("TimerAreaZM", f1_arg0)
	f1_local0.gameTypeGroup = Dvar.ui_zm_gamemodegroup:get()
	f1_local0.gameType = Dvar.ui_gametype:get()
	f1_local0.scaleContainer = CoD.SplitscreenScaler.new(nil, CoD.Zombie.SplitscreenMultiplier)
	f1_local0.scaleContainer:setLeftRight(true, false, 0, 0)
	f1_local0.scaleContainer:setTopBottom(false, true, 0, 0)
	f1_local0:addElement(f1_local0.scaleContainer)
	local f1_local1 = "Morris"
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, CoD.GameTimerZombie.LeftOffset, CoD.GameTimerZombie.LeftOffset + CoD.GameTimerZombie.Size)
	Widget:setTopBottom(false, true, -CoD.GameTimerZombie.Size + CoD.GameTimerZombie.TopOffset, CoD.GameTimerZombie.TopOffset)
	Widget:setFont(CoD.fonts[f1_local1])
	Widget:setRGB(1, 1, 1)
	Widget:setupGameTimerZombie()
	Widget:registerEventHandler("countdown_low", CoD.GameTimerZombie.UpdateCountDownLow)
	Widget:registerEventHandler("countdown_low_flash", CoD.GameTimerZombie.CountdownLowFlash)
	Widget:registerEventHandler("flash_normal", CoD.GameTimerZombie.CountdownLowFlashNormal)
	Widget:registerEventHandler("countdown_ten_sec_left", CoD.GameTimerZombie.CountdownTenSecondsLeft)
	f1_local0:addElement(Widget)
	f1_local0:registerEventHandler("hud_update_refresh", CoD.GameTimerZombie.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.GameTimerZombie.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.GameTimerZombie.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.GameTimerZombie.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.GameTimerZombie.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.GameTimerZombie.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.GameTimerZombie.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.GameTimerZombie.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC, CoD.GameTimerZombie.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_SCOPED, CoD.GameTimerZombie.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_FLASH_BANGED, CoD.GameTimerZombie.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.GameTimerZombie.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.GameTimerZombie.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_rounds_played", CoD.GameTimerZombie.UpdateRoundsPlayed)
	f1_local0:registerEventHandler("hud_update_team_change", CoD.GameTimerZombie.UpdateTeamChange)
	f1_local0.visible = true
	return f1_local0
end

CoD.GameTimerZombie.UpdateVisibility = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_EMP_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_SCOREBOARD_OPEN) == 0 and (not CoD.IsShoutcaster(f2_local0) or CoD.ExeProfileVarBool(f2_local0, "shoutcaster_teamscore")) and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_GUIDED_MISSILE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_SCOPED) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_VEHICLE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_FLASH_BANGED) == 0 then
		if not f2_arg0.visible then
			f2_arg0:setAlpha(1)
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible then
		f2_arg0:setAlpha(0)
		f2_arg0.visible = nil
	end
end

CoD.GameTimerZombie.UpdateCountDownLow = function (f3_arg0, f3_arg1)
	if f3_arg1.low == true and not f3_arg0.flashTimerStarted then
		f3_arg0.flashTimerStarted = true
		CoD.GameTimerZombie.CountdownLowFlash(f3_arg0)
		f3_arg0:addElement(LUI.UITimer.new(10000, "countdown_low_flash", true, f3_arg0))
		f3_arg0:addElement(LUI.UITimer.new(19000, "countdown_low_flash", true, f3_arg0))
		f3_arg0:addElement(LUI.UITimer.new(20000, "countdown_ten_sec_left", true, f3_arg0))
	end
end

CoD.GameTimerZombie.CountdownLowFlash = function (f4_arg0, f4_arg1)
	local f4_local0 = CoD.GameTimerZombie.LeftOffset
	local f4_local1 = CoD.GameTimerZombie.Size * 1.25
	local f4_local2 = CoD.GameTimerZombie.TopOffset
	f4_arg0:setLeftRight(true, false, f4_local0, f4_local0 + f4_local1)
	f4_arg0:setTopBottom(false, true, -f4_local1 + f4_local2, f4_local2)
	f4_arg0:addElement(LUI.UITimer.new(1000, "flash_normal", true, f4_arg0))
end

CoD.GameTimerZombie.CountdownLowFlashNormal = function (f5_arg0, f5_arg1)
	f5_arg0:setLeftRight(true, false, CoD.GameTimerZombie.LeftOffset, CoD.GameTimerZombie.LeftOffset + CoD.GameTimerZombie.Size)
	f5_arg0:setTopBottom(false, true, -CoD.GameTimerZombie.Size + CoD.GameTimerZombie.TopOffset, CoD.GameTimerZombie.TopOffset)
end

CoD.GameTimerZombie.CountdownTenSecondsLeft = function (f6_arg0, f6_arg1)
	if not f6_arg0.shouldChangeColor then
		f6_arg0.shouldChangeColor = true
		f6_arg0:beginAnimation("turn_red", 10000)
		f6_arg0:setRGB(0.21, 0, 0)
	end
end

