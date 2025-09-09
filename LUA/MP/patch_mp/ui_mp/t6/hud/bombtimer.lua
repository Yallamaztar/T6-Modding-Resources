CoD.BombTimer = {}
CoD.BombTimer.Width = 48
CoD.BombTimer.Height = 48
CoD.BombTimer.LabelLeft = 0
CoD.BombTimer.LabelTop = -8
CoD.BombTimer.LabelSize = CoD.textSize.ExtraSmall
CoD.BombTimer.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new(HudRef)
	
	local body = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget:addElement(body)
	Widget.body = body
	
	body:registerAnimationState("show", {
		alpha = 1
	})
	body:registerAnimationState("hide", {
		alpha = 0
	})
	body:animateToState("hide")
	local f1_local2 = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		material = RegisterMaterial("hud_icon_bomb_" .. InstanceRef)
	})
	Widget.letterForeground = f1_local2
	Widget.body:addElement(f1_local2)
	local timerLabel = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = CoD.BombTimer.LabelLeft,
		right = CoD.BombTimer.LabelLeft,
		topAnchor = false,
		bottomAnchor = false,
		top = CoD.BombTimer.LabelTop - CoD.BombTimer.LabelSize / 2,
		bottom = CoD.BombTimer.LabelTop + CoD.BombTimer.LabelSize / 2,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		font = CoD.fonts.ExtraSmall
	})
	if timerLabel.setupBombTimer then
		if InstanceRef == "B" then
			timerLabel:setupBombTimer(1)
		else
			timerLabel:setupBombTimer(0)
		end
	else
		CoD.CountdownTimer.Setup(timerLabel, 0, false)
	end
	body:addElement(timerLabel)
	Widget.timerLabel = timerLabel
	
	Widget.letter = InstanceRef
	local f1_local4 = "BIT_BOMB_TIMER"
	if InstanceRef ~= nil then
		f1_local4 = f1_local4 .. "_" .. InstanceRef
	end
	local f1_local5 = CoD[f1_local4]
	Widget.visibilityBit = f1_local5
	local f1_local6 = function (f2_arg0, f2_arg1)
		if UIExpression.IsVisibilityBitSet(f2_arg1.controller, f2_arg0.visibilityBit) == 1 then
			if f2_arg0.visible ~= true then
				f2_arg0.body:animateToState("show")
				f2_arg0.visible = true
			end
		elseif f2_arg0.visible == true then
			f2_arg0.body:animateToState("hide")
			f2_arg0.visible = nil
		end
		f2_arg0:dispatchEventToChildren(f2_arg1)
	end

	Widget:registerEventHandler("pulse_icon", CoD.BombTimer.PulseIcon)
	Widget:registerEventHandler("hud_update_refresh", f1_local6)
	Widget:registerEventHandler("hud_update_bit_" .. f1_local5, f1_local6)
	return Widget
end

