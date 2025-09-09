require("T6.VisorTypewriter")
CoD.VisorDataBoxes = {}
CoD.VisorDataBoxes.DefaultAlpha = 1
CoD.VisorDataBoxes.BoxDefaultAlpha = 0.5
CoD.VisorDataBoxes.FrontendColorValue = 0.2
CoD.VisorDataBoxes.NumBoxesWide = 3
CoD.VisorDataBoxes.NumBoxesHigh = 2
CoD.VisorDataBoxes.BoxWidth = 50
CoD.VisorDataBoxes.BoxHeight = 50
CoD.VisorDataBoxes.BoxSpacingHorizontal = -25
CoD.VisorDataBoxes.BoxSpacingVertical = -32
CoD.VisorDataBoxes.Width = CoD.VisorDataBoxes.NumBoxesWide * CoD.VisorDataBoxes.BoxWidth + (CoD.VisorDataBoxes.NumBoxesWide - 1) * CoD.VisorDataBoxes.BoxSpacingHorizontal
CoD.VisorDataBoxes.Height = CoD.VisorDataBoxes.NumBoxesHigh * CoD.VisorDataBoxes.BoxHeight + (CoD.VisorDataBoxes.NumBoxesHigh - 1) * CoD.VisorDataBoxes.BoxSpacingVertical
CoD.VisorDataBoxes.BootupAppearDuration = 1000
CoD.VisorDataBoxes.BootupUpperRightDuration = 1000
CoD.VisorDataBoxes.MinHumanFrequency = 1.5
CoD.VisorDataBoxes.MaxHumanFrequency = 5.5
CoD.VisorDataBoxes.new = function (f1_arg0)
	local f1_local0 = CoD.Menu.NewSafeAreaFromState("VisorDataBoxes", f1_arg0)
	f1_local0:registerAnimationState("hide", {
		alpha = 0
	})
	f1_local0:registerAnimationState("show", {
		alpha = CoD.VisorDataBoxes.DefaultAlpha
	})
	f1_local0.boxes = {}
	for f1_local1 = 1, CoD.VisorDataBoxes.NumBoxesWide, 1 do
		f1_local0.boxes[f1_local1] = {}
		for f1_local4 = 1, CoD.VisorDataBoxes.NumBoxesHigh, 1 do
			f1_local0.boxes[f1_local1][f1_local4] = CoD.VisorDataBoxes.CreateDataBox(f1_local0, f1_local1, f1_local4)
			f1_local0:addElement(f1_local0.boxes[f1_local1][f1_local4])
		end
	end
	CoD.VisorDataBoxes.AddHealthSine(f1_local0)
	f1_local0:registerEventHandler("bootup_appear", CoD.VisorDataBoxes.BootupAppear)
	f1_local0:registerEventHandler("bootup_upper_right", CoD.VisorDataBoxes.BootupUpperRight)
	f1_local0:registerEventHandler("bootup_switch_to_hud", CoD.VisorDataBoxes.SwitchToHUD)
	return f1_local0
end

CoD.VisorDataBoxes.AddHealthSine = function (f2_arg0)
	local f2_local0 = 48
	local f2_local1 = 30
	local f2_local2 = CoD.VisorRightBracket.BracketHeight / 2
	local f2_local3 = CoD.VisorRightBracket.BracketWidth + 5
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f2_local0 - f2_local3, -f2_local3)
	Widget:setTopBottom(false, false, -f2_local1 / 2 - f2_local2, f2_local1 / 2 - f2_local2)
	f2_arg0:addElement(Widget)
	local f2_local5 = math.random()
	local f2_local6 = math.random()
	local f2_local7 = "hud_ekg"
	f2_arg0.healthBarImage = LUI.UIImage.new()
	f2_arg0.healthBarImage:setLeftRight(true, true, 0, 0)
	f2_arg0.healthBarImage:setTopBottom(true, true, 2, -2)
	f2_arg0.healthBarImage:setImage(RegisterMaterial(f2_local7))
	f2_arg0.healthBarImage:setRGB(0, 1, 0)
	f2_arg0.healthBarImage:setAlpha(0.3)
	f2_arg0.healthBarImage:setShaderVector(0, f2_local5, f2_local6, CoD.VisorDataBoxes.MinHumanFrequency, 1)
	f2_arg0.healthBarImage:setupPlayerHealthEKG(f2_local5, f2_local6)
	Widget:addElement(f2_arg0.healthBarImage)
end

CoD.VisorDataBoxes.CreateDataBox = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = (f3_arg1 - 1) * (CoD.VisorDataBoxes.BoxWidth + CoD.VisorDataBoxes.BoxSpacingHorizontal) - 10
	local f3_local1 = (f3_arg2 - 1) * (CoD.VisorDataBoxes.BoxHeight + CoD.VisorDataBoxes.BoxSpacingVertical) - 18
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.VisorDataBoxes.Width / 2 + f3_local0, -CoD.VisorDataBoxes.Width / 2 + f3_local0 + CoD.VisorDataBoxes.BoxWidth)
	Widget:setTopBottom(false, false, -CoD.VisorDataBoxes.Height / 2 + f3_local1 + 90, -CoD.VisorDataBoxes.Height / 2 + f3_local1 + 90 + CoD.VisorDataBoxes.BoxHeight)
	Widget:setAlpha(0)
	Widget:registerAnimationState("appear", {
		alpha = CoD.VisorDataBoxes.BoxDefaultAlpha
	})
	local f3_local3, f3_local4 = Engine.GetUserSafeArea()
	local f3_local5 = -CoD.VisorRightBracket.BracketHeight / 2 + f3_local1
	Widget:registerAnimationState("upper_right", {
		leftAnchor = false,
		rightAnchor = true,
		left = -CoD.VisorDataBoxes.Width + f3_local0 - 10,
		right = -CoD.VisorDataBoxes.Width + f3_local0 + CoD.VisorDataBoxes.BoxWidth - 10,
		topAnchor = false,
		bottomAnchor = false,
		top = f3_local5 - CoD.VisorDataBoxes.BoxHeight / 2,
		bottom = f3_local5 + CoD.VisorDataBoxes.BoxHeight / 2
	})
	local f3_local6 = CoD.VisorImage.new("visor_square_outline", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	Widget:addElement(f3_local6)
	f3_local6.image:registerAnimationState("dim", {
		red = CoD.VisorDataBoxes.FrontendColorValue,
		green = CoD.VisorDataBoxes.FrontendColorValue,
		blue = CoD.VisorDataBoxes.FrontendColorValue
	})
	return Widget
end

CoD.VisorDataBoxes.BootupAppear = function (f4_arg0, f4_arg1)
	local f4_local0 = 250
	local f4_local1 = (CoD.VisorDataBoxes.BootupAppearDuration - f4_local0) / (CoD.VisorDataBoxes.NumBoxesWide * CoD.VisorDataBoxes.NumBoxesHigh - 1)
	local f4_local2 = 0
	local f4_local3 = {
		name = "animate",
		animationStateName = "appear",
		duration = f4_local0
	}
	for f4_local4 = 1, CoD.VisorDataBoxes.NumBoxesHigh, 1 do
		for f4_local7 = 1, CoD.VisorDataBoxes.NumBoxesWide, 1 do
			f4_arg0:addElement(LUI.UITimer.new(f4_local2, f4_local3, true, f4_arg0.boxes[f4_local7][f4_local4]))
			f4_local2 = f4_local2 + f4_local1
		end
	end
end

CoD.VisorDataBoxes.BootupUpperRight = function (f5_arg0, f5_arg1)
	local f5_local0 = 500
	local f5_local1 = CoD.VisorDataBoxes.BootupUpperRightDuration - f5_local0
	local f5_local2 = {
		name = "animate",
		animationStateName = "upper_right",
		duration = f5_local0,
		easeIn = true,
		easeOut = true
	}
	for f5_local3 = 1, CoD.VisorDataBoxes.NumBoxesHigh, 1 do
		for f5_local6 = 1, CoD.VisorDataBoxes.NumBoxesWide, 1 do
			f5_arg0:addElement(LUI.UITimer.new(math.random(0, f5_local1), f5_local2, true, f5_arg0.boxes[f5_local6][f5_local3]))
		end
	end
end

CoD.VisorDataBoxes.SwitchToHUD = function (f6_arg0, f6_arg1)
	if f6_arg1.isFrontEnd == true then
		f6_arg0:dispatchEventToChildren({
			name = "animate",
			animationStateName = "dim"
		})
	end
	f6_arg0:dispatchEventToChildren({
		name = "animate",
		animationStateName = "upper_right"
	})
	f6_arg0:dispatchEventToChildren({
		name = "animate",
		animationStateName = "appear"
	})
end

