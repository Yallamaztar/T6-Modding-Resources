require("T6.HUD.HUDDigit")
CoD.ScoreBottomLeft = {}
local f0_local0 = 110
local f0_local1 = CoD.HUDDigit.BigBottomNumbersY
local f0_local2 = 107
local f0_local3 = -48
local f0_local4 = 28
LUI.createMenu.ScoreBottomLeft = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("ScoreBottomLeft", f1_arg0)
	f1_local0.scaleContainer = CoD.SplitscreenScaler.new(nil, CoD.SplitscreenMultiplier)
	f1_local0.scaleContainer:setLeftRight(true, false, 0, 0)
	f1_local0.scaleContainer:setTopBottom(false, true, 0, 0)
	f1_local0:addElement(f1_local0.scaleContainer)
	f1_local0.backgroundBlend = LUI.UIImage.new()
	f1_local0.backgroundBlend:setLeftRight(true, false, f0_local4, f0_local4 + 300)
	f1_local0.backgroundBlend:setTopBottom(false, true, -150, 0)
	f1_local0.backgroundBlend:setImage(RegisterMaterial("hud_mp_vis_left_lower_back"))
	f1_local0.scaleContainer:addElement(f1_local0.backgroundBlend)
	local f1_local1 = f0_local4 - 25
	local f1_local2 = -128
	local f1_local3 = LUI.UIImage.new()
	f1_local3:setLeftRight(true, false, f1_local1, f1_local1 + 300)
	f1_local3:setTopBottom(false, true, f1_local2, f1_local2 + 150)
	f1_local3:setImage(RegisterMaterial("hud_mp_vis_left_lower"))
	f1_local0.scaleContainer:addElement(f1_local3)
	local f1_local4 = 8
	local f1_local5 = -87
	local f1_local6 = "Italic"
	local f1_local7 = CoD.GameTimer.new()
	f1_local7:setLeftRight(true, false, f0_local4 + f1_local4, f0_local4 + f1_local4)
	f1_local7:setTopBottom(false, true, f1_local5 - CoD.textSize[f1_local6] / 2, f1_local5 + CoD.textSize[f1_local6] / 2)
	f1_local7:setFont(CoD.fonts[f1_local6])
	f1_local0.scaleContainer:addElement(f1_local7)
	local f1_local8 = Engine.GetGametypeSetting("scoreLimit")
	local f1_local9 = 52
	if f1_local8 > 10 then
		f1_local9 = 57
	end
	local f1_local10 = -96
	local f1_local11 = "SmallItalic"
	f1_local0.winningStatusText = LUI.UIText.new()
	f1_local0.winningStatusText:setLeftRight(true, false, f0_local4 + f1_local9, f0_local4 + f1_local9)
	f1_local0.winningStatusText:setTopBottom(false, true, f1_local10, f1_local10 + CoD.textSize[f1_local11])
	f1_local0.winningStatusText:setFont(CoD.fonts[f1_local11])
	f1_local0.winningStatusText:setAlpha(0.65)
	if f1_local8 > 0 then
		f1_local0.winningStatusText.winConditionString = Engine.Localize("MPUI_X_POINTS_TO_WIN_CAPS", f1_local8)
		if f1_local8 == 1 then
			f1_local0.winningStatusText.winConditionString = Engine.Localize("MPUI_1_POINT_TO_WIN_CAPS")
		end
		f1_local0.winningStatusText:setText(f1_local0.winningStatusText.winConditionString)
	else
		f1_local0.winningStatusText.showWinStatus = true
	end
	f1_local0.winningStatusText:registerEventHandler("transition_complete_toggle", CoD.ScoreBottomLeft.WinningStatusText_ToWinStatus)
	f1_local0.scaleContainer:addElement(f1_local0.winningStatusText)
	f1_local0.scaleContainer:addElement(LUI.UITimer.new(9000, "toggle_winning_status", false, f1_local0))
	local f1_local12 = 6
	local f1_local13 = -118
	local f1_local14 = "SmallItalic"
	f1_local0.roundStatusText = LUI.UIText.new()
	f1_local0.roundStatusText:setLeftRight(true, false, f0_local4 + f1_local12, f0_local4 + f1_local12)
	f1_local0.roundStatusText:setTopBottom(false, true, f1_local13, f1_local13 + CoD.textSize[f1_local14])
	f1_local0.roundStatusText:setFont(CoD.fonts[f1_local14])
	f1_local0.roundStatusText:setAlpha(0)
	f1_local0.scaleContainer:addElement(f1_local0.roundStatusText)
	local f1_local15 = 20
	local f1_local16 = -44
	local f1_local17 = 96
	f1_local0.factionIconBackground = LUI.UIImage.new()
	f1_local0.factionIconBackground:setLeftRight(true, false, f0_local4 + f1_local15, f0_local4 + f1_local15 + f1_local17)
	f1_local0.factionIconBackground:setTopBottom(false, true, f1_local16 - f1_local17 / 2, f1_local16 + f1_local17 / 2)
	f1_local0.factionIconBackground:setAlpha(0)
	f1_local0.scaleContainer:addElement(f1_local0.factionIconBackground)
	f1_local0.factionIcon = LUI.UIImage.new()
	f1_local0.factionIcon:setLeftRight(true, false, f0_local4 + f1_local15, f0_local4 + f1_local15 + f1_local17)
	f1_local0.factionIcon:setTopBottom(false, true, f1_local16 - f1_local17 / 2, f1_local16 + f1_local17 / 2)
	f1_local0.factionIcon:setAlpha(0)
	f1_local0.scaleContainer:addElement(f1_local0.factionIcon)
	local f1_local18 = 28
	local f1_local19 = -28
	local f1_local20 = LUI.UIImage.new()
	f1_local20:setLeftRight(true, false, f0_local4 + f1_local18, f0_local4 + f1_local18 + 128)
	f1_local20:setTopBottom(false, true, f1_local19 - 64, f1_local19)
	f1_local20:setImage(RegisterMaterial("hud_mp_vis_score_highlight"))
	local f1_local21 = 5
	f1_local0.yourScoreDigits = {}
	local f1_local22 = f0_local4 + f0_local0
	for f1_local23 = 1, f1_local21, 1 do
		local f1_local26 = CoD.HUDDigit.new()
		f1_local26:setLeftRight(true, false, f1_local22, f1_local22 + CoD.HUDDigit.Width)
		f1_local26:setTopBottom(false, true, f0_local1, f0_local1 + CoD.HUDDigit.BigNumbersHeight)
		f1_local26:setAlpha(0)
		f1_local0.scaleContainer:addElement(f1_local26)
		f1_local0.yourScoreDigits[f1_local23] = f1_local26
		f1_local22 = f1_local22 + CoD.HUDDigit.Spacing
	end
	f1_local0.enemyScoreDigits = {}
	f1_local22 = f0_local2
	for f1_local23 = 1, f1_local21, 1 do
		local f1_local26 = CoD.HUDDigit.new()
		f1_local26:setLeftRight(true, false, f1_local22, f1_local22 + CoD.HUDDigit.Width)
		f1_local26:setTopBottom(false, true, f0_local3, f0_local3 + CoD.HUDDigit.BigNumbersHeight)
		f1_local26:setAlpha(0)
		f1_local0.scaleContainer:addElement(f1_local26)
		f1_local0.enemyScoreDigits[f1_local23] = f1_local26
		f1_local22 = f1_local22 + CoD.HUDDigit.Spacing
	end
	f1_local0:registerEventHandler("hud_update_refresh", CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_GAME_ENDED, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_FLASH_BANGED, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_HARDCORE, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_SELECTING_LOCATION, CoD.ScoreBottomLeft.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_rounds_played", CoD.ScoreBottomLeft.UpdateRoundsPlayed)
	f1_local0:registerEventHandler("hud_update_scores", CoD.ScoreBottomLeft.UpdateScores)
	f1_local0:registerEventHandler("hud_update_team_change", CoD.ScoreBottomLeft.UpdateTeamChange)
	f1_local0:registerEventHandler("toggle_winning_status", CoD.ScoreBottomLeft.ToggleWinningStatus)
	f1_local0.visible = true
	return f1_local0
end

CoD.ScoreBottomLeft.UpdateVisibility = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_EMP_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_SCOREBOARD_OPEN) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_GAME_ENDED) == 0 and (not CoD.IsShoutcaster(f2_local0) or CoD.ExeProfileVarBool(f2_local0, "shoutcaster_teamscore")) and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_GUIDED_MISSILE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_VEHICLE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_HUD_HARDCORE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_FLASH_BANGED) == 0 and CoD.FSM_VISIBILITY(f2_local0) == 0 then
		if not f2_arg0.visible then
			f2_arg0:setAlpha(1)
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible then
		f2_arg0:setAlpha(0)
		f2_arg0.visible = nil
	end
end

CoD.ScoreBottomLeft.UpdateRoundsPlayed = function (f3_arg0, f3_arg1)
	if not f3_arg0.overtime then
		local f3_local0 = Engine.GetGametypeSetting("roundLimit")
		if f3_local0 == 1 then
			f3_arg0.roundStatusText:setAlpha(0)
		elseif f3_local0 == 0 then
			f3_arg0.roundStatusText:setText(Engine.Localize("MPUI_ROUND_X_CAPS", f3_arg1.roundsPlayed + 1))
			f3_arg0.roundStatusText:setAlpha(1)
		else
			f3_arg0.roundStatusText:setText(Engine.Localize("MPUI_ROUND_X_OF_Y_CAPS", f3_arg1.roundsPlayed + 1, f3_local0))
			f3_arg0.roundStatusText:setAlpha(1)
		end
	end
end

CoD.ScoreBottomLeft.UpdateScores = function (f4_arg0, f4_arg1)
	CoD.ScoreBottomLeft.UpdateTeamChange(f4_arg0, f4_arg1)
	local f4_local0 = nil
	local f4_local1 = true
	if f4_arg1.enemyScore < f4_arg1.yourScore then
		f4_local0 = Engine.Localize("MENU_WINNING_CAPS")
	elseif f4_arg1.yourScore < f4_arg1.enemyScore then
		f4_local0 = Engine.Localize("MENU_LOSING_CAPS")
	else
		f4_local0 = Engine.Localize("MENU_TIED_CAPS")
	end
	f4_arg0.winningStatusText.winStatusString = f4_local0
	if f4_arg0.winningStatusText.showWinStatus then
		f4_arg0.winningStatusText:setText(f4_local0)
	end
	if yourScoreSmall then
		CoD.ScoreBottomLeft.UpdateScoreDigits(f4_arg0.yourScoreDigits, f4_arg1.yourScore, f0_local4 + f0_local0, f0_local1 + CoD.HUDDigit.SmallDigitHeightDifference, CoD.HUDDigit.SmallDigitScale)
	else
		CoD.ScoreBottomLeft.UpdateScoreDigits(f4_arg0.yourScoreDigits, f4_arg1.yourScore, f0_local4 + f0_local0, f0_local1, 1)
	end
	if f4_local1 then
		CoD.ScoreBottomLeft.UpdateScoreDigits(f4_arg0.enemyScoreDigits, f4_arg1.enemyScore, f0_local4 + f0_local2, f0_local3 + CoD.HUDDigit.SmallDigitHeightOffset, CoD.HUDDigit.SmallDigitScale)
	else
		CoD.ScoreBottomLeft.UpdateScoreDigits(f4_arg0.enemyScoreDigits, f4_arg1.enemyScore, f0_local4 + f0_local2, f0_local3, 1)
	end
	if CoD.IsInOvertime(f4_arg1.controller) then
		f4_arg0.overtime = true
		f4_arg0.roundStatusText:setText(Engine.Localize("MP_OVERTIME_CAPS"))
		f4_arg0.roundStatusText:setAlpha(1)
		f4_arg0.winningStatusText:setText(f4_local0)
		f4_arg0.winningStatusText.doNotCycle = true
	else
		f4_arg0.winningStatusText.doNotCycle = nil
	end
end

CoD.ScoreBottomLeft.GetFiveDigits = function (f5_arg0)
	local f5_local0 = math.floor(f5_arg0 / 10000)
	f5_arg0 = f5_arg0 - f5_local0 * 10000
	local f5_local1 = math.floor(f5_arg0 / 1000)
	f5_arg0 = f5_arg0 - f5_local1 * 1000
	local f5_local2 = math.floor(f5_arg0 / 100)
	f5_arg0 = f5_arg0 - f5_local2 * 100
	local f5_local3 = math.floor(f5_arg0 / 10)
	return f5_local0, f5_local1, f5_local2, f5_local3, f5_arg0 - f5_local3 * 10
end

CoD.ScoreBottomLeft.UpdateScoreDigits = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	local f6_local0 = #f6_arg0
	local f6_local1 = CoD.HUDDigit.Width * f6_arg4
	local f6_local2 = CoD.HUDDigit.BigNumbersHeight * f6_arg4
	local f6_local3 = CoD.HUDDigit.Spacing * f6_arg4
	local f6_local4, f6_local5, f6_local6, f6_local7, f6_local8 = CoD.ScoreBottomLeft.GetFiveDigits(f6_arg1)
	local f6_local9 = 1
	if f6_local4 > 0 or f6_local9 > 1 then
		f6_arg0[f6_local9]:setDigit(f6_local4)
		f6_local9 = f6_local9 + 1
	end
	if f6_local5 > 0 or f6_local9 > 1 then
		f6_arg0[f6_local9]:setDigit(f6_local5)
		f6_local9 = f6_local9 + 1
	end
	if f6_local6 > 0 or f6_local9 > 1 then
		f6_arg0[f6_local9]:setDigit(f6_local6)
		f6_local9 = f6_local9 + 1
	end
	if f6_local7 > 0 or f6_local9 > 1 then
		f6_arg0[f6_local9]:setDigit(f6_local7)
		f6_local9 = f6_local9 + 1
	end
	f6_arg0[f6_local9]:setDigit(f6_local8)
	f6_local9 = f6_local9 + 1
	for f6_local10 = 1, f6_local0, 1 do
		local f6_local13 = f6_arg0[f6_local10]
		if f6_local10 < f6_local9 then
			f6_local13:setLeftRight(true, false, f6_arg2, f6_arg2 + f6_local1)
			f6_local13:setTopBottom(false, true, f6_arg3, f6_arg3 + f6_local2)
			f6_local13:setAlpha(1)
		else
			f6_local13:setAlpha(0)
		end
		f6_arg2 = f6_arg2 + f6_local3
	end
end

CoD.ScoreBottomLeft.ToggleWinningStatus = function (f7_arg0, f7_arg1)
	if f7_arg0.winningStatusText.doNotCycle then
		return 
	elseif f7_arg0.winningStatusText.showWinStatus then
		f7_arg0.winningStatusText.showWinStatus = nil
	else
		f7_arg0.winningStatusText.showWinStatus = true
	end
	f7_arg0.winningStatusText:beginAnimation("toggle", 500)
	f7_arg0.winningStatusText:setAlpha(0)
end

CoD.ScoreBottomLeft.UpdateTeamChange = function (f8_arg0, f8_arg1)
	if f8_arg1.team < CoD.TEAM_SPECTATOR then
		f8_arg0.team = f8_arg1.team
		local f8_local0 = Engine.GetPredictedClientNum(f8_arg1.controller)
		if CoD.IsGametypeTeamBased() == true then
			local f8_local1 = Engine.GetFactionForClient(f8_local0)
			if f8_arg0.team ~= CoD.TEAM_FREE and f8_local1 ~= "" and f8_local1 ~= "free" then
				local f8_local2 = Engine.GetLeagueTeamIDForClient(f8_arg1.controller, f8_local0)
				local f8_local3 = 20
				local f8_local4 = -44
				local f8_local5 = 96
				local f8_local6 = "faction_" .. f8_local1
				f8_arg0.factionIconBackground:setImage(RegisterMaterial(f8_local6 .. "_glow"))
				f8_arg0.factionIconBackground:setAlpha(1)
				f8_arg0.factionIcon:setupUIImage()
				f8_arg0.factionIcon:setImage(RegisterMaterial(f8_local6))
				f8_arg0.factionIcon:setAlpha(1)
				f8_arg0.backgroundBlend:setRGB(UIExpression.TableLookup(f8_arg1.controller, CoD.factionTable, 0, f8_local1, 2) / 255, UIExpression.TableLookup(f8_arg1.controller, CoD.factionTable, 0, f8_local1, 3) / 255, UIExpression.TableLookup(f8_arg1.controller, CoD.factionTable, 0, f8_local1, 4) / 255)
				f8_arg0.factionIcon:setLeftRight(true, false, f0_local4 + f8_local3, f0_local4 + f8_local3 + f8_local5)
				f8_arg0.factionIcon:setTopBottom(false, true, f8_local4 - f8_local5 / 2, f8_local4 + f8_local5 / 2)
			else
				f8_arg0.factionIcon:setAlpha(0)
			end
		else
			local f8_local1 = Engine.GetCalloutPlayerData(f8_arg1.controller, f8_local0)
			f8_arg0.factionIconBackground:setAlpha(0)
			f8_arg0.factionIcon:setupPlayerEmblemServer(f8_local1.playerClientNum)
			f8_arg0.factionIcon:setAlpha(1)
			local f8_local2 = 40
			local f8_local3 = -39
			local f8_local4 = 64
			f8_arg0.factionIcon:setLeftRight(true, false, f0_local4 + f8_local2, f0_local4 + f8_local2 + f8_local4)
			f8_arg0.factionIcon:setTopBottom(false, true, f8_local3 - f8_local4 / 2, f8_local3 + f8_local4 / 2)
		end
	end
end

CoD.ScoreBottomLeft.WinningStatusText_ToWinStatus = function (f9_arg0, f9_arg1)
	local f9_local0 = nil
	if f9_arg0.showWinStatus then
		f9_local0 = f9_arg0.winStatusString
	else
		f9_local0 = f9_arg0.winConditionString
	end
	if f9_local0 == nil then
		f9_local0 = ""
	end
	f9_arg0:setText(f9_local0)
	f9_arg0:beginAnimation("fade_in", 500)
	f9_arg0:setAlpha(0.65)
end

