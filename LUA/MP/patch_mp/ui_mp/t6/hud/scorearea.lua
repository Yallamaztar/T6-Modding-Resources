CoD.ScoreArea = {}
CoD.ScoreArea.FactionSize = 128
CoD.ScoreArea.YourScoreBarHeight = 21
CoD.ScoreArea.EnemyScoreBarHeight = 17
CoD.ScoreArea.TiedScoreBarHeight = (CoD.ScoreArea.YourScoreBarHeight + CoD.ScoreArea.EnemyScoreBarHeight) / 2
CoD.ScoreArea.ScoreBarHorizontalOffset = 25
CoD.ScoreArea.YourScoreBarVerticalOffset = -2
CoD.ScoreArea.EnemyScoreBarVerticalOffset = 23
CoD.ScoreArea.ScoreNumberHorizontalOffset = 40
CoD.ScoreArea.MinScoreBarWidth = 80
CoD.ScoreArea.MaxScoreBarWidth = 100
CoD.ScoreArea.GameTimerOffset = 32
CoD.ScoreArea.GameTimerSize = 26
CoD.ScoreArea.new = function (f1_arg0)
	if CoD.ScoreArea.ScoreBackgroundMaterial == nil then
		CoD.ScoreArea.ScoreBackgroundMaterial = RegisterMaterial("hud_lui_left_score")
	end
	local Widget = LUI.UIElement.new(f1_arg0)
	Widget:registerAnimationState("hide", {
		alphaMultiplier = 0
	})
	Widget:registerAnimationState("show", {
		alphaMultiplier = 1
	})
	Widget:animateToState("hide")
	local Widget = LUI.UIElement.new({
		left = 0,
		top = -CoD.ScoreArea.FactionSize,
		right = CoD.ScoreArea.FactionSize,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true
	})
	Widget:addElement(Widget)
	local f1_local2 = CoD.DistFieldText.new({
		left = -100,
		top = CoD.ScoreArea.GameTimerOffset - CoD.ScoreArea.GameTimerSize,
		right = 100,
		bottom = CoD.ScoreArea.GameTimerOffset,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}, nil, nil, -1, -1, 0.08)
	Widget:addElement(f1_local2)
	CoD.CountdownTimer.Setup(f1_local2)
	f1_local2:registerAnimationState("hide", {
		alphaMultiplier = 0
	})
	f1_local2:registerAnimationState("show", {
		alphaMultiplier = 1
	})
	f1_local2:animateToState("show")
	f1_local2.visible = true
	f1_local2:registerEventHandler("hud_update_bit_" .. CoD.BIT_BOMB_TIMER, CoD.ScoreArea.UpdateGameTimerVisibility)
	f1_local2:registerEventHandler("hud_update_bit_" .. CoD.BIT_BOMB_TIMER_A, CoD.ScoreArea.UpdateGameTimerVisibility)
	f1_local2:registerEventHandler("hud_update_bit_" .. CoD.BIT_BOMB_TIMER_B, CoD.ScoreArea.UpdateGameTimerVisibility)
	f1_local2:registerEventHandler("hud_update_game_timer", CoD.ScoreArea.UpdateGameTimer)
	f1_local2:registerEventHandler("countdown_low", CoD.ScoreArea.CountdownLow)
	f1_local2:setupForWarningPulse()
	local f1_local3 = LUI.UIText.new({
		left = 100,
		top = CoD.ScoreArea.GameTimerOffset - CoD.ScoreArea.GameTimerSize,
		right = 200,
		bottom = CoD.ScoreArea.GameTimerOffset,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		alignment = LUI.Alignment.Left,
		font = CoD.fonts.Big
	})
	Widget:addElement(f1_local3)
	f1_local3:registerAnimationState("winning", {
		red = CoD.blue.r,
		green = CoD.blue.g,
		blue = CoD.blue.b,
		alpha = 1
	})
	f1_local3:registerAnimationState("losing", {
		red = CoD.red.r,
		green = CoD.red.g,
		blue = CoD.red.b,
		alpha = 1
	})
	f1_local3:registerAnimationState("tied", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	Widget.statusText = f1_local3
	
	local yourScoreBar = LUI.UIElement.new({
		left = CoD.ScoreArea.ScoreBarHorizontalOffset,
		top = CoD.ScoreArea.YourScoreBarVerticalOffset - CoD.ScoreArea.YourScoreBarHeight / 2,
		right = CoD.ScoreArea.ScoreBarHorizontalOffset,
		bottom = CoD.ScoreArea.YourScoreBarVerticalOffset + CoD.ScoreArea.YourScoreBarHeight / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	yourScoreBar:registerAnimationState("winning", {
		left = CoD.ScoreArea.ScoreBarHorizontalOffset,
		top = CoD.ScoreArea.YourScoreBarVerticalOffset - CoD.ScoreArea.YourScoreBarHeight / 2,
		right = CoD.ScoreArea.ScoreBarHorizontalOffset,
		bottom = CoD.ScoreArea.YourScoreBarVerticalOffset + CoD.ScoreArea.YourScoreBarHeight / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	yourScoreBar:registerAnimationState("losing", {
		left = CoD.ScoreArea.ScoreBarHorizontalOffset,
		top = CoD.ScoreArea.YourScoreBarVerticalOffset - CoD.ScoreArea.EnemyScoreBarHeight / 2,
		right = CoD.ScoreArea.ScoreBarHorizontalOffset,
		bottom = CoD.ScoreArea.YourScoreBarVerticalOffset + CoD.ScoreArea.EnemyScoreBarHeight / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	yourScoreBar:registerAnimationState("tied", {
		left = CoD.ScoreArea.ScoreBarHorizontalOffset,
		top = CoD.ScoreArea.YourScoreBarVerticalOffset - CoD.ScoreArea.TiedScoreBarHeight / 2,
		right = CoD.ScoreArea.ScoreBarHorizontalOffset,
		bottom = CoD.ScoreArea.YourScoreBarVerticalOffset + CoD.ScoreArea.TiedScoreBarHeight / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	Widget:addElement(yourScoreBar)
	Widget.yourScoreBar = yourScoreBar
	
	local yourScoreBarImage = LUI.UIImage.new({
		left = 0,
		top = -7,
		right = 128,
		bottom = 7,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		alpha = 0,
		material = CoD.ScoreArea.ScoreBackgroundMaterial
	})
	yourScoreBarImage:registerAnimationState("tied", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	yourScoreBarImage:registerAnimationState("winning", {
		red = CoD.blue.r,
		green = CoD.blue.g,
		blue = CoD.blue.b,
		alpha = 1
	})
	yourScoreBarImage:registerAnimationState("losing", {
		red = CoD.red.r,
		green = CoD.red.g,
		blue = CoD.red.b,
		alpha = 1
	})
	yourScoreBar:addElement(yourScoreBarImage)
	Widget.yourScoreBarImage = yourScoreBarImage
	
	local yourScoreNumber = CoD.DistFieldText.new({
		left = CoD.ScoreArea.ScoreNumberHorizontalOffset,
		top = -4,
		right = 70,
		bottom = 4,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	}, nil, nil, -1, -1, 0.09)
	yourScoreBar:addElement(yourScoreNumber)
	Widget.yourScoreNumber = yourScoreNumber
	
	local f1_local7 = CoD.AdditiveTextOverlay.new(60, 8, CoD.ScoreFeed.Color1, CoD.ScoreFeed.Color2, CoD.ScoreFeed.Color3, {
		left = 70,
		top = 7,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		alpha = 0
	})
	yourScoreBar:addElement(f1_local7)
	f1_local7:registerAnimationState("show", {
		alpha = 1
	})
	Widget.yourScoreBarGlow = f1_local7
	
	local enemyScoreBar = LUI.UIElement.new({
		left = CoD.ScoreArea.ScoreBarHorizontalOffset,
		top = CoD.ScoreArea.EnemyScoreBarVerticalOffset - CoD.ScoreArea.EnemyScoreBarHeight / 2,
		right = CoD.ScoreArea.ScoreBarHorizontalOffset,
		bottom = CoD.ScoreArea.EnemyScoreBarVerticalOffset + CoD.ScoreArea.EnemyScoreBarHeight / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		alpha = 0
	})
	enemyScoreBar:registerAnimationState("winning", {
		left = CoD.ScoreArea.ScoreBarHorizontalOffset,
		top = CoD.ScoreArea.EnemyScoreBarVerticalOffset - CoD.ScoreArea.EnemyScoreBarHeight / 2,
		right = CoD.ScoreArea.ScoreBarHorizontalOffset,
		bottom = CoD.ScoreArea.EnemyScoreBarVerticalOffset + CoD.ScoreArea.EnemyScoreBarHeight / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	enemyScoreBar:registerAnimationState("losing", {
		left = CoD.ScoreArea.ScoreBarHorizontalOffset,
		top = CoD.ScoreArea.EnemyScoreBarVerticalOffset - CoD.ScoreArea.YourScoreBarHeight / 2,
		right = CoD.ScoreArea.ScoreBarHorizontalOffset,
		bottom = CoD.ScoreArea.EnemyScoreBarVerticalOffset + CoD.ScoreArea.YourScoreBarHeight / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	enemyScoreBar:registerAnimationState("tied", {
		left = CoD.ScoreArea.ScoreBarHorizontalOffset,
		top = CoD.ScoreArea.EnemyScoreBarVerticalOffset - CoD.ScoreArea.TiedScoreBarHeight / 2,
		right = CoD.ScoreArea.ScoreBarHorizontalOffset,
		bottom = CoD.ScoreArea.EnemyScoreBarVerticalOffset + CoD.ScoreArea.TiedScoreBarHeight / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	enemyScoreBar:registerAnimationState("show", {
		alpha = 1
	})
	Widget:addElement(enemyScoreBar)
	Widget.enemyScoreBar = enemyScoreBar
	
	enemyScoreBar:addElement(LUI.UIImage.new({
		left = 0,
		top = -7,
		right = 128,
		bottom = 7,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		red = 0,
		green = 0,
		blue = 0,
		material = CoD.ScoreArea.ScoreBackgroundMaterial
	}))
	
	local enemyScoreNumber = CoD.DistFieldText.new({
		left = CoD.ScoreArea.ScoreNumberHorizontalOffset + 1,
		top = -3,
		right = 71,
		bottom = 3,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	}, nil, nil, -1, -1, 0.13)
	enemyScoreBar:addElement(enemyScoreNumber)
	Widget.enemyScoreNumber = enemyScoreNumber
	
	local f1_local10 = LUI.UIImage.new({
		left = -5,
		top = 5,
		right = 5,
		bottom = 15,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0
	})
	Widget:addElement(f1_local10)
	f1_local10:registerAnimationState("losing", {
		red = CoD.red.r,
		green = CoD.red.g,
		blue = CoD.red.b
	})
	f1_local10:registerAnimationState("winning", {
		red = CoD.blue.r,
		green = CoD.blue.g,
		blue = CoD.blue.b
	})
	Widget.outline = f1_local10
	
	local innerOutline = LUI.UIImage.new({
		left = 0,
		top = 10,
		right = 0,
		bottom = 10,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.blue.r,
		green = CoD.blue.g,
		blue = CoD.blue.b,
		alpha = 0
	})
	Widget:addElement(innerOutline)
	Widget.innerOutline = innerOutline
	
	local factionImage = LUI.UIImage.new({
		left = 0,
		top = 10,
		right = 0,
		bottom = 10,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = 0
	})
	Widget:addElement(factionImage)
	Widget.factionImage = factionImage
	
	Widget:addElement(LUI.UIImage.new({
		left = 0,
		top = -256,
		right = 512,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		material = RegisterMaterial("hud_lui_bottomleft_rez")
	}))
	Widget.visible = true
	Widget:registerEventHandler("hud_update_refresh", CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_VEHICLE, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_GUIDED_MISSILE, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_AMMO_COUNTER_HIDE, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_IS_FLASH_BANGED, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_SPECTATING_CLIENT, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_GAME_ENDED, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_SCOREBOARD_OPEN, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_SELECTING_LOCATION, CoD.ScoreArea.UpdateVisibility)
	Widget:registerEventHandler("hud_update_scores", CoD.ScoreArea.UpdateScores)
	return Widget
end

CoD.ScoreArea.UpdateVisibility = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_EMP_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_CAMERA_MODE_MOVIECAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_VEHICLE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_GUIDED_MISSILE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IN_REMOTE_KILLSTREAK_STATIC) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_AMMO_COUNTER_HIDE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_IS_FLASH_BANGED) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_GAME_ENDED) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_SCOREBOARD_OPEN) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_SPECTATING_CLIENT) == 0 and CoD.FSM_VISIBILITY(f2_local0) == 0 then
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

CoD.ScoreArea.UpdateGameTimerVisibility = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1.controller
	if UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_BOMB_TIMER) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_BOMB_TIMER_A) == 0 and UIExpression.IsVisibilityBitSet(f3_local0, CoD.BIT_BOMB_TIMER_B) == 0 then
		if f3_arg0.visible ~= true then
			f3_arg0:animateToState("show")
			f3_arg0.visible = true
		end
	elseif f3_arg0.visible == true then
		f3_arg0:animateToState("hide")
		f3_arg0.visible = nil
	end
	f3_arg0:dispatchEventToChildren(f3_arg1)
end

CoD.ScoreArea.UpdateScores = function (f4_arg0, f4_arg1)
	local f4_local0 = UIExpression.DvarInt(f4_arg1.controller, "ui_scorelimit")
	local f4_local1 = f4_arg0.yourScoreBar
	local f4_local2 = f4_arg0.yourScoreBarImage
	local f4_local3 = f4_arg0.yourScoreNumber
	local f4_local4 = f4_arg0.enemyScoreNumber
	local f4_local5 = f4_arg0.enemyScoreBar
	local f4_local6 = f4_arg1.yourScore
	local f4_local7 = f4_arg1.enemyScore
	local f4_local8 = f4_arg0.outline
	local f4_local9 = f4_arg0.innerOutline
	local f4_local10 = f4_arg0.factionImage
	local f4_local11 = f4_arg0.statusText
	local f4_local12 = nil
	if type(f4_arg1.team) == "number" then
		f4_local12 = Engine.GetTeamName(f4_arg1.team)
	else
		f4_local12 = f4_arg1.team
	end
	f4_local3:setText(f4_local6)
	f4_local4:setText(f4_local7)
	local f4_local13 = UIExpression.DvarString(nil, "g_TeamIcon_Allies")
	local f4_local14 = UIExpression.DvarString(nil, "g_TeamIcon_Axis")
	if f4_local13 ~= f4_arg0.alliesMaterialName or f4_local14 ~= f4_arg0.axisMaterialName then
		f4_local10:registerAnimationState("TEAM_ALLIES", {
			material = RegisterMaterial(f4_local13),
			alpha = 1
		})
		f4_local10:registerAnimationState("TEAM_AXIS", {
			material = RegisterMaterial(f4_local14),
			alpha = 1
		})
		f4_local8:registerAnimationState("TEAM_ALLIES", {
			material = RegisterMaterial(f4_local13 .. "_outline"),
			alpha = 0.75
		})
		f4_local8:registerAnimationState("TEAM_AXIS", {
			material = RegisterMaterial(f4_local14 .. "_outline"),
			alpha = 0.75
		})
		f4_local9:registerAnimationState("TEAM_ALLIES", {
			material = RegisterMaterial(f4_local13 .. "_outline"),
			alpha = 0.5
		})
		f4_local9:registerAnimationState("TEAM_AXIS", {
			material = RegisterMaterial(f4_local14 .. "_outline"),
			alpha = 0.5
		})
		f4_arg0.alliesMaterialName = f4_local13
		f4_arg0.axisMaterialName = f4_local14
	end
	f4_local9:animateToState(f4_local12)
	f4_local8:animateToState(f4_local12)
	f4_local10:animateToState(f4_local12)
	if f4_local7 < f4_local6 then
		f4_local8:animateToState("winning")
		f4_local1:animateToState("winning")
		f4_local5:animateToState("winning")
		f4_local2:animateToState("winning")
		f4_local4:animateToState("pulse_in")
		f4_arg0.yourScoreBarGlow:animateToState("show")
		f4_local11:animateToState("winning")
		f4_local11:setText(Engine.Localize("MENU_WINNING_CAPS"))
	elseif f4_local6 < f4_local7 then
		f4_local8:animateToState("losing")
		f4_local2:animateToState("losing")
		f4_local1:animateToState("losing")
		f4_local5:animateToState("losing")
		f4_arg0.yourScoreBarGlow:animateToState("show")
		f4_local11:animateToState("losing")
		f4_local11:setText(Engine.Localize("MENU_LOSING_CAPS"))
	else
		f4_local8:animateToState("default")
		f4_local9:animateToState("default")
		f4_local1:animateToState("tied")
		f4_local5:animateToState("tied")
		f4_local2:animateToState("tied")
		f4_local3:animateToState("pulse_in")
		f4_local4:animateToState("pulse_in")
		f4_arg0.yourScoreBarGlow:animateToState("default")
		f4_local11:animateToState("tied")
		f4_local11:setText(Engine.Localize("MENU_TIED_CAPS"))
	end
	f4_local5:animateToState("show")
end

CoD.ScoreArea.UpdateGameTimer = function (f5_arg0, f5_arg1)
	f5_arg0:setTimeLeft(f5_arg1.timeLeft)
end

CoD.ScoreArea.CountdownLow = function (f6_arg0, f6_arg1)
	if f6_arg1.low == true then
		f6_arg0:startWarningPulse()
	else
		f6_arg0:animateToState("pulse_in")
	end
end

