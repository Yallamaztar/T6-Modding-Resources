CoD.Hud3DScoreBoardZombie = {}
CoD.Hud3DScoreBoardZombie.AlliesScore = 0
CoD.Hud3DScoreBoardZombie.AxisScore = 0
CoD.Hud3DScoreBoardZombie.AlliesHasMeat = 0
CoD.Hud3DScoreBoardZombie.AxisHasMeat = 0
CoD.Hud3DScoreBoardZombie.GAMETYPE_MEAT = "zmeat"
CoD.Hud3DScoreBoardZombie.GAMETYPE_RACE = "zrace"
CoD.Hud3DScoreBoardZombie.new = function (f1_arg0)
	local Widget = LUI.UIElement.new(f1_arg0)
	Widget:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		material = RegisterMaterial("scoreboard_encounters_background"),
		alpha = 1
	}))
	Widget.currentRound = LUI.UIText.new({
		left = -150,
		top = 100,
		right = -50,
		bottom = 240,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		red = 0.97,
		green = 0.95,
		blue = 0.27,
		alpha = 1
	})
	Widget.currentRound:setText("1")
	Widget:addElement(Widget.currentRound)
	Widget.totalRounds = LUI.UIText.new({
		left = 50,
		top = 100,
		right = 150,
		bottom = 240,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		red = 0.97,
		green = 0.95,
		blue = 0.27,
		alpha = 1
	})
	Widget.totalRounds:setText("5")
	Widget:addElement(Widget.totalRounds)
	Widget.cdcScore = LUI.UIText.new({
		left = 140,
		top = 190,
		right = 290,
		bottom = 390,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		red = 0.97,
		green = 0.95,
		blue = 0.27,
		alpha = 1
	})
	Widget.cdcScore:setText("0")
	Widget:addElement(Widget.cdcScore)
	Widget.cdcMeatOn = LUI.UIImage.new({
		left = 140,
		top = 40,
		right = 260,
		bottom = 160,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		material = RegisterMaterial("scoreboard_encounters_bulb_on"),
		alpha = 1
	})
	Widget.cdcMeatOn:registerAnimationState("hide", {
		alpha = 0
	})
	Widget.cdcMeatOn:registerAnimationState("show", {
		alpha = 1
	})
	Widget:addElement(Widget.cdcMeatOn)
	Widget.cdcMeatOff = LUI.UIImage.new({
		left = 140,
		top = 40,
		right = 260,
		bottom = 160,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		material = RegisterMaterial("scoreboard_encounters_bulb_off"),
		alpha = 1
	})
	Widget.cdcMeatOff:registerAnimationState("hide", {
		alpha = 0
	})
	Widget.cdcMeatOff:registerAnimationState("show", {
		alpha = 1
	})
	Widget:addElement(Widget.cdcMeatOff)
	Widget.ciaScore = LUI.UIText.new({
		left = -320,
		top = 190,
		right = -140,
		bottom = 390,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		red = 0.97,
		green = 0.95,
		blue = 0.27,
		alpha = 1
	})
	Widget.ciaScore:setText("0")
	Widget:addElement(Widget.ciaScore)
	Widget.ciaMeatOn = LUI.UIImage.new({
		left = -240,
		top = 40,
		right = -120,
		bottom = 160,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		material = RegisterMaterial("scoreboard_encounters_bulb_on"),
		alpha = 1
	})
	Widget.ciaMeatOn:registerAnimationState("hide", {
		alpha = 0
	})
	Widget.ciaMeatOn:registerAnimationState("show", {
		alpha = 1
	})
	Widget:addElement(Widget.ciaMeatOn)
	Widget.ciaMeatOff = LUI.UIImage.new({
		left = -240,
		top = 40,
		right = -120,
		bottom = 160,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		material = RegisterMaterial("scoreboard_encounters_bulb_off"),
		alpha = 1
	})
	Widget.ciaMeatOff:registerAnimationState("hide", {
		alpha = 0
	})
	Widget.ciaMeatOff:registerAnimationState("show", {
		alpha = 1
	})
	Widget:addElement(Widget.ciaMeatOff)
	Widget:registerEventHandler("hud_update_scoreboard_zombie", CoD.Hud3DScoreBoardZombie.Update)
	Widget:registerEventHandler("hud_update_refresh", CoD.Hud3DScoreBoardZombie.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_FINAL_KILLCAM, CoD.Hud3DScoreBoardZombie.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_ROUND_END_KILLCAM, CoD.Hud3DScoreBoardZombie.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.Hud3DScoreBoardZombie.UpdateVisibility)
	return Widget
end

CoD.Hud3DScoreBoardZombie.UpdateVisibility = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	if UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_FINAL_KILLCAM) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_UI_ACTIVE) == 0 and UIExpression.IsVisibilityBitSet(f2_local0, CoD.BIT_ROUND_END_KILLCAM) == 0 then
		if f2_arg0.visible ~= true then
			f2_arg0.visible = true
		end
	elseif f2_arg0.visible == true then
		f2_arg0.visible = nil
	end
	f2_arg0:dispatchEventToChildren(f2_arg1)
end

CoD.Hud3DScoreBoardZombie.Update = function (f3_arg0, f3_arg1)
	CoD.Hud3DScoreBoardZombie.AlliesScore = f3_arg1.alliesScore
	CoD.Hud3DScoreBoardZombie.AxisScore = f3_arg1.axisScore
	if f3_arg0.cdcScore ~= nil then
		f3_arg0.cdcScore:setText(f3_arg1.alliesScore)
	end
	if f3_arg0.ciaScore ~= nil then
		f3_arg0.ciaScore:setText(f3_arg1.axisScore)
	end
	if f3_arg0.currentRound ~= nil then
		if f3_arg1.axisScore > 2 or f3_arg1.alliesScore > 2 then
			f3_arg0.currentRound:setText("" .. f3_arg1.axisScore + f3_arg1.alliesScore)
		else
			f3_arg0.currentRound:setText("" .. f3_arg1.axisScore + f3_arg1.alliesScore + 1)
		end
	end
	if f3_arg0.cdcMeatOn ~= nil and f3_arg0.cdcMeatOn ~= nil then
		if f3_arg1.alliesHasMeat > 0 then
			f3_arg0.cdcMeatOn:animateToState("show")
			f3_arg0.cdcMeatOff:animateToState("hide")
		else
			f3_arg0.cdcMeatOn:animateToState("hide")
			f3_arg0.cdcMeatOff:animateToState("show")
		end
	end
	if f3_arg0.ciaMeatOn ~= nil and f3_arg0.ciaMeatOff ~= nil then
		if f3_arg1.axisHasMeat > 0 then
			f3_arg0.ciaMeatOn:animateToState("show")
			f3_arg0.ciaMeatOff:animateToState("hide")
		else
			f3_arg0.ciaMeatOn:animateToState("hide")
			f3_arg0.ciaMeatOff:animateToState("show")
		end
	end
	f3_arg0:dispatchEventToChildren(f3_arg1)
end

CoD.Hud3DScoreBoardZombie.CloseOut = function (f4_arg0, f4_arg1)
	if f4_arg1.interrupted ~= true then
		f4_arg0:close()
	end
end

