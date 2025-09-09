CoD.ScorePopup = {}
CoD.ScorePopup.ScoreFontName = "Condensed"
CoD.ScorePopup.ScoreTextHeight = CoD.textSize[CoD.ScorePopup.ScoreFontName]
CoD.ScorePopup.ScoreTextTop = -75
CoD.ScorePopup.DisplayTime = 1000
CoD.ScorePopup.StreakPauseTime = 500
CoD.ScorePopup.StreakMoveTime = 250
CoD.ScorePopup.StreakFadeTime = 200
CoD.ScorePopup.new = function (f1_arg0)
	local f1_local0 = CoD.SplitscreenScaler.new(f1_arg0, CoD.SplitscreenMultiplier)
	f1_local0:registerAnimationState("hide", {
		alphaMultiplier = 0
	})
	f1_local0:registerAnimationState("show", {
		alphaMultiplier = 1
	})
	f1_local0:animateToState("hide")
	f1_local0:setUseGameTime(true)
	local f1_local1, f1_local2 = Engine.GetUserSafeArea()
	
	local safeArea = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f1_local1 / 2,
		right = f1_local1 / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = -f1_local2 / 2,
		bottom = f1_local2 / 2
	})
	f1_local0:addElement(safeArea)
	f1_local0.safeArea = safeArea
	
	local f1_local4 = 220
	local f1_local5 = 200
	local f1_local6 = CoD.ScorePopup.ScoreTextTop + 30
	
	local scoreFeed = CoD.ScoreFeed.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f1_local5 + f1_local4,
		right = f1_local4,
		topAnchor = false,
		bottomAnchor = false,
		top = f1_local6,
		bottom = f1_local6 - CoD.ScoreFeed.Height
	})
	safeArea:addElement(scoreFeed)
	f1_local0.scoreFeed = scoreFeed
	
	scoreFeed.ScoreCount = 0
	f1_local0:registerEventHandler("hud_update_refresh", CoD.ScorePopup.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_FINAL_KILLCAM, CoD.ScorePopup.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_ROUND_END_KILLCAM, CoD.ScorePopup.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.ScorePopup.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.ScorePopup.UpdateVisibility)
	f1_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.ScorePopup.UpdateVisibility)
	f1_local0:registerEventHandler("score_event", CoD.ScorePopup.Score)
	f1_local0:registerEventHandler("streak_to_dpad", CoD.ScorePopup.StreakToDPad)
	f1_local0:registerEventHandler("demo_jump", CoD.ScorePopup.Clear)
	return f1_local0
end

CoD.ScorePopup.UpdateVisibility = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_FINAL_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_ROUND_END_KILLCAM) == 0 then
		if f2_arg0.visible ~= true then
			f2_arg0:animateToState("show")
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible == true then
		f2_arg0:animateToState("hide")
		f2_arg0.visible = nil
	end
	f2_arg0:dispatchEventToChildren(f2_arg1)
end

CoD.ScorePopup.Score = function (f3_arg0, f3_arg1)
	local f3_local0 = Engine.GetIString(f3_arg1.data[1], "CS_LOCALIZED_STRINGS")
	local f3_local1 = f3_arg1.data[2]
	local f3_local2 = f3_arg1.data[3]
	if f3_local0 ~= nil then
		local f3_local3 = nil
		f3_local3 = Engine.Localize(f3_local0)
		if f3_local2 ~= 0 then
			local f3_local4 = f3_local1 + f3_local2
			if f3_local4 > 0 then
				CoD.ScorePopup.SetCenterScore(f3_arg0, Engine.Localize("MP_PLUS") .. f3_local4, true)
			else
				CoD.ScorePopup.SetCenterScore(f3_arg0, f3_local4, true)
			end
			if f3_arg0.streakLabel == nil then
				local f3_local5 = -10
				local f3_local6 = CoD.DPadArea.CircleSize / 2
				local f3_local7 = -CoD.DPadArea.CircleSize / 2
				local f3_local8 = 45
				local f3_local9 = 140
				local f3_local10 = 60
				local f3_local11 = "ExtraSmall"
				local f3_local12 = CoD.textSize[f3_local11]
				local f3_local13 = CoD.AdditiveTextOverlay.newWithText(Engine.Localize("MP_STREAK_CAPS"), CoD.ScorePopup.ScoreFontName, CoD.ScoreFeed.ScoreStreakColor1, CoD.ScoreFeed.ScoreStreakColor2, CoD.ScoreFeed.ScoreStreakColor3, {
					leftAnchor = false,
					rightAnchor = false,
					left = -100,
					right = 100,
					topAnchor = true,
					bottomAnchor = false,
					top = f3_local9,
					bottom = f3_local9 + f3_local10,
					alpha = 1
				})
				f3_local13:registerAnimationState("on_dpad", {
					leftAnchor = true,
					rightAnchor = false,
					left = f3_local7,
					right = f3_local7 + f3_local6,
					topAnchor = false,
					bottomAnchor = true,
					top = f3_local5 - f3_local12 / 2,
					bottom = f3_local5 + f3_local12 / 2
				})
				f3_local13:addAnimationStateForFont(f3_local11, "on_dpad")
				f3_local13:addElement(LUI.UITimer.new(CoD.ScorePopup.StreakPauseTime, "streak_to_dpad", true, f3_arg0))
				f3_arg0.safeArea:addElement(f3_local13)
				f3_arg0.streakLabel = f3_local13
			end
			f3_arg0.scoreFeed:addRow(f3_local3, f3_local4, true)
		else
			f3_arg0.scoreFeed.ScoreCount = f3_arg0.scoreFeed.ScoreCount + f3_local1
			local f3_local4 = false
			if f3_arg0.scoreFeed.ScoreCount > 0 then
				CoD.ScorePopup.SetCenterScore(f3_arg0, Engine.Localize("MP_PLUS") .. f3_arg0.scoreFeed.ScoreCount)
				f3_local4 = true
			elseif f3_arg0.scoreFeed.ScoreCount < 0 then
				CoD.ScorePopup.SetCenterScore(f3_arg0, f3_arg0.scoreFeed.ScoreCount)
				f3_local4 = true
			end
			if f3_local0 ~= "SCORE_KILL" and f3_local4 == true then
				f3_arg0.scoreFeed:addRow(f3_local3, f3_local1, false)
			end
		end
	elseif f3_arg0.streakLabel ~= nil then
		f3_arg0.streakLabel:out()
		f3_arg0.streakLabel = nil
	end
end

function resetAndCloseAfterTime(f4_arg0, f4_arg1)
	f4_arg0.centerScoreNumber:addElement(LUI.UITimer.new(f4_arg1, "out", true, f4_arg0.glow))
	f4_arg0.centerScoreNumber:addElement(LUI.UITimer.new(f4_arg1, "reset", true, f4_arg0))
	f4_arg0.scoreFeed:addElement(LUI.UITimer.new(f4_arg1, "reset", true, f4_arg0))
	f4_arg0.centerScoreNumber:addElement(LUI.UITimer.new(f4_arg1, "close", true, f4_arg0.label))
end

CoD.ScorePopup.Clear = function (f5_arg0, f5_arg1)
	if f5_arg0.centerScoreNumber ~= nil then
		f5_arg0.centerScoreNumber:close()
		f5_arg0.centerScoreNumber = nil
	end
	CoD.ScorePopup.Reset(f5_arg0, f5_arg1)
	f5_arg0:dispatchEventToChildren(f5_arg1)
end

CoD.ScorePopup.Reset = function (f6_arg0, f6_arg1)
	f6_arg0.ScoreCount = 0
end

CoD.ScorePopup.SetCenterScore = function (f7_arg0, f7_arg1, f7_arg2)
	local f7_local0, f7_local1, f7_local2 = nil
	if f7_arg2 == true then
		f7_local0 = CoD.ScoreFeed.ScoreStreakColor1
		f7_local1 = CoD.ScoreFeed.ScoreStreakColor2
		f7_local2 = CoD.ScoreFeed.ScoreStreakColor3
	else
		f7_local0 = CoD.ScoreFeed.Color1
		f7_local1 = CoD.ScoreFeed.Color2
		f7_local2 = CoD.ScoreFeed.Color3
	end
	if f7_arg0.centerScoreNumber ~= nil then
		f7_arg0.centerScoreNumber:close()
		f7_arg0.centerScoreNumber = nil
	end
	local centerScoreNumber = CoD.AdditiveTextOverlay.newWithText(f7_arg1, CoD.ScorePopup.ScoreFontName, f7_local0, f7_local1, f7_local2, {
		leftAnchor = true,
		rightAnchor = true,
		left = 40,
		right = 40,
		topAnchor = false,
		bottomAnchor = false,
		top = CoD.ScorePopup.ScoreTextTop,
		bottom = CoD.ScorePopup.ScoreTextTop + CoD.ScorePopup.ScoreTextHeight
	})
	f7_arg0:addElement(centerScoreNumber)
	f7_arg0.centerScoreNumber = centerScoreNumber
	
	centerScoreNumber:registerEventHandler("reset", CoD.ScorePopup.Reset)
	f7_arg0.scoreFeed:registerEventHandler("reset", CoD.ScorePopup.Reset)
	resetAndCloseAfterTime(f7_arg0, CoD.ScorePopup.DisplayTime)
end

CoD.ScorePopup.StreakToDPad = function (f8_arg0, f8_arg1)
	f8_arg0.streakLabel:animateToState("on_dpad", CoD.ScorePopup.StreakMoveTime)
	f8_arg0.streakLabel.label:animateToState("on_dpad", CoD.ScorePopup.StreakMoveTime)
	f8_arg0.streakLabel.glow.glow:animateToState("on_dpad", CoD.ScorePopup.StreakMoveTime)
	f8_arg0.streakLabel.glow.innerGlow:animateToState("on_dpad", CoD.ScorePopup.StreakMoveTime)
end

