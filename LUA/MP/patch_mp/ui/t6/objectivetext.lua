CoD.ObjectiveText = {}
CoD.ObjectiveText.DefaultWidth = 30
CoD.ObjectiveText.DefaultHeight = CoD.ObjectiveText.DefaultWidth
CoD.ObjectiveText.HalfSquareSize = 15
CoD.ObjectiveText.DefaultAlpha = 1
CoD.ObjectiveText.ObjectiveTextAlpha = 1
CoD.ObjectiveText.ColorValue = {}
CoD.ObjectiveText.ColorValue.r = 0.75
CoD.ObjectiveText.ColorValue.b = 0.75
CoD.ObjectiveText.ColorValue.g = 0.75
CoD.ObjectiveText.ColorValue.alpha = 0.75
CoD.ObjectiveText.Blue = CoD.visorBlue3
CoD.ObjectiveText.FadeInDuration = 1000
CoD.ObjectiveText.MoveToLowerLeftDuration = 500
CoD.ObjectiveText.SpinRotataionTime = 350
CoD.ObjectiveText.FontName = "Default"
CoD.ObjectiveText.MaxLines = 1
CoD.ObjectiveText.ScrollDuration = 200
CoD.ObjectiveText.CollapseDuration = 200
CoD.ObjectiveText.ObjectiveLifetime = 10000
CoD.ObjectiveText.DefaultStyle = "twenties"
CoD.ObjectiveText.new = function ()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.ObjectiveText.DefaultWidth / 2, CoD.ObjectiveText.DefaultWidth / 2)
	Widget:setTopBottom(false, false, -CoD.ObjectiveText.DefaultHeight / 2 + 130, CoD.ObjectiveText.DefaultHeight / 2 + 130)
	Widget:setAlpha(0)
	Widget.id = Widget.id .. ".ObjectiveText"
	Widget:registerEventHandler("transition_complete_new_location", CoD.ObjectiveText.CloseSpinner)
	Widget:registerEventHandler("remove_objective_text", CoD.ObjectiveText.RemoveObjectiveText)
	Widget:registerEventHandler("bootup_start", CoD.ObjectiveText.BootupStart)
	Widget:registerEventHandler("bootup_lower_left", CoD.ObjectiveText.BootupLowerLeft)
	Widget:registerEventHandler("bootup_welcome", CoD.ObjectiveText.BootupWelcome)
	Widget:registerEventHandler("bootup_switch_to_hud", CoD.ObjectiveText.BootupSwitchToHUD)
	Widget:registerEventHandler("clear_objective", CoD.ObjectiveText.ClearObjective)
	Widget:registerEventHandler("setup_war_message", CoD.ObjectiveText.SetupWarMessage)
	Widget:registerEventHandler("display_war_message", CoD.ObjectiveText.DisplayWarMessage)
	Widget:registerEventHandler("remove_war_message", CoD.ObjectiveText.RemoveWarMessage)
	Widget.textElements = {}
	local f1_local1 = LUI.UIHorizontalList.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alignment = LUI.Alignment.Center
	})
	f1_local1.id = f1_local1.id .. ".ObjHorizontalList"
	Widget:addElement(f1_local1)
	f1_local1:registerEventHandler("transition_complete_spin_0", CoD.ObjectiveText.Spin0)
	f1_local1:registerEventHandler("transition_complete_spin_360", CoD.ObjectiveText.Spin360)
	CoD.ObjectiveText.HalfSquareMaterial = RegisterMaterial("menu_vis_half_square")
	local f1_local2 = CoD.ObjectiveText.HalfSquare(CoD.ObjectiveText.HalfSquareSize, 90, 180)
	f1_local2.id = f1_local2.id .. ".ObjLeftHalfSquare"
	f1_local1:addElement(f1_local2)
	local Widget = LUI.UIElement.new({
		left = 0,
		top = -CoD.textSize[CoD.ObjectiveText.FontName],
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	})
	Widget.id = Widget.id .. ".ObjTextHolder"
	Widget:setUseStencil(true)
	f1_local1:addElement(Widget)
	Widget:registerEventHandler("transition_complete_default", CoD.ObjectiveText.NewTextLength)
	local f1_local4 = CoD.textSize[CoD.ObjectiveText.FontName]
	local f1_local5 = CoD.fonts[CoD.ObjectiveText.FontName]
	
	local objTextElement = LUI.UIText.new()
	objTextElement:setLeftRight(true, true, 0, 0)
	objTextElement:setTopBottom(false, true, -f1_local4 - 3, -3)
	objTextElement:setFont(f1_local5)
	objTextElement:setRGB(CoD.ObjectiveText.Blue.r, CoD.ObjectiveText.Blue.g, CoD.ObjectiveText.Blue.b)
	objTextElement.id = objTextElement.id .. "ObjTextElement"
	objTextElement.textFont = f1_local5
	objTextElement.textHeight = f1_local4
	Widget:addElement(objTextElement)
	Widget.objTextElement = objTextElement
	
	local f1_local7 = CoD.ObjectiveText.HalfSquare(CoD.ObjectiveText.HalfSquareSize, 0, -90)
	f1_local7.id = f1_local7.id .. ".ObjRightHalfSquare"
	f1_local1:addElement(f1_local7)
	Widget.setNewTextObj = CoD.ObjectiveText.SetNewTextObjective
	Widget.spinSquare = CoD.ObjectiveText.SpinSquare
	Widget.objHorizontalList = f1_local1
	Widget.objLeftHalfSquare = f1_local2
	Widget.objTextHolder = Widget
	Widget.objTextElement = objTextElement
	Widget.objRightHalfSquare = f1_local7
	Widget:registerEventHandler("update_style", CoD.ObjectiveText.UpdateStyle)
	return Widget
end

CoD.ObjectiveText.UpdateStyle = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.style
	if f2_local0 == nil then
		f2_local0 = CoD.ObjectiveText.DefaultStyle
	end
	if f2_local0 == "eighties" then
		f2_arg0.objLeftHalfSquare:setAlpha(0)
		f2_arg0.objRightHalfSquare:setAlpha(0)
	else
		f2_arg0.objLeftHalfSquare:setAlpha(CoD.ObjectiveText.DefaultAlpha)
		f2_arg0.objRightHalfSquare:setAlpha(CoD.ObjectiveText.DefaultAlpha)
	end
end

CoD.ObjectiveText.BootupStart = function (f3_arg0, f3_arg1)
	f3_arg0:beginAnimation("show", CoD.ObjectiveText.FadeInDuration)
	f3_arg0:setAlpha(CoD.ObjectiveText.ObjectiveTextAlpha)
end

CoD.ObjectiveText.BootupLowerLeft = function (f4_arg0, f4_arg1)
	f4_arg0:setNewTextObj("", LUI.Alignment.Center)
	local f4_local0 = -10
	local f4_local1 = -3
	local f4_local2 = nil
	if not Engine.GameModeIsMode(CoD.GAMEMODE_RTS) then
		f4_local2 = {
			leftAnchor = true,
			rightAnchor = false,
			left = CoD.VisorLeftBracket.BracketWidth + CoD.ObjectiveText.DefaultWidth + f4_local0 - 22,
			right = CoD.VisorLeftBracket.BracketWidth + CoD.ObjectiveText.DefaultWidth * 2 + f4_local0 - 22,
			topAnchor = false,
			bottomAnchor = false,
			top = -CoD.VisorLeftBracket.BracketHeight / 2,
			bottom = -CoD.VisorLeftBracket.BracketHeight / 2 + CoD.ObjectiveText.DefaultHeight
		}
	else
		local f4_local3 = -18
		local f4_local4 = 160
		f4_local2 = {
			leftAnchor = true,
			rightAnchor = false,
			left = CoD.VisorLeftBracket.BracketWidth + CoD.ObjectiveText.DefaultWidth + f4_local0 - 22 + f4_local3,
			right = CoD.VisorLeftBracket.BracketWidth + CoD.ObjectiveText.DefaultWidth * 2 + f4_local0 - 22 + f4_local3,
			topAnchor = false,
			bottomAnchor = false,
			top = -CoD.VisorLeftBracket.BracketHeight / 2 + f4_local4,
			bottom = -CoD.VisorLeftBracket.BracketHeight / 2 + CoD.ObjectiveText.DefaultHeight + f4_local4
		}
	end
	local f4_local3 = nil
	if f4_arg1.name == "bootup_switch_to_hud" then
		f4_local3 = 0
	else
		f4_local3 = CoD.ObjectiveText.MoveToLowerLeftDuration
	end
	f4_arg0:spinSquare(f4_local2, f4_local3)
	if f4_local3 == 0 then
		f4_arg0:beginAnimation("show")
		f4_arg0:setAlpha(CoD.ObjectiveText.ObjectiveTextAlpha)
	end
end

CoD.ObjectiveText.BootupSwitchToHUD = function (f5_arg0, f5_arg1)
	CoD.ObjectiveText.BootupLowerLeft(f5_arg0, f5_arg1)
	f5_arg0:registerEventHandler("objective_text", CoD.ObjectiveText.ObjectiveText)
end

CoD.ObjectiveText.BootupWelcome = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.text
	if not f6_local0 then
		f6_local0 = Engine.Localize("MENU_VISOR_WELCOME_CAPS")
	end
	f6_arg0:setNewTextObj(f6_local0, LUI.Alignment.Center)
end

CoD.ObjectiveText.ClearObjective = function (f7_arg0, f7_arg1)
	f7_arg0:setNewTextObj("", LUI.Alignment.Center)
end

CoD.ObjectiveText.HalfSquare = function (f8_arg0, f8_arg1, f8_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f8_arg0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setAlpha(CoD.ObjectiveText.DefaultAlpha)
	local f8_local1 = CoD.ObjectiveText.HalfSquareMaterial
	local f8_local2 = LUI.UIImage.new()
	f8_local2:setLeftRight(false, false, -f8_arg0 / 2, f8_arg0 / 2)
	f8_local2:setTopBottom(true, false, 0, f8_arg0)
	f8_local2:setImage(f8_local1)
	f8_local2:setRGB(CoD.VisorImage.ColorValue.r, CoD.VisorImage.ColorValue.g, CoD.VisorImage.ColorValue.b)
	f8_local2:setAlpha(CoD.ObjectiveText.DefaultAlpha)
	f8_local2:setZRot(f8_arg1)
	Widget:addElement(f8_local2)
	local f8_local3 = LUI.UIImage.new()
	f8_local3:setLeftRight(false, false, -f8_arg0 / 2, f8_arg0 / 2)
	f8_local3:setTopBottom(false, true, -f8_arg0, 0)
	f8_local3:setImage(f8_local1)
	f8_local3:setRGB(CoD.VisorImage.ColorValue.r, CoD.VisorImage.ColorValue.g, CoD.VisorImage.ColorValue.b)
	f8_local3:setAlpha(CoD.ObjectiveText.DefaultAlpha)
	f8_local3:setZRot(f8_arg2)
	Widget:addElement(f8_local3)
	Widget:registerEventHandler("active_squares", CoD.ObjectiveText.ActiveSquares)
	Widget:registerEventHandler("inactive_squares", CoD.ObjectiveText.InActiveSquares)
	Widget.topHalf = f8_local2
	Widget.bottomHalf = f8_local3
	return Widget
end

CoD.ObjectiveText.SetNewTextObjective = function (f9_arg0, f9_arg1, f9_arg2)
	if f9_arg0.objTextHolder.objTextElement.text == f9_arg1 then
		return 
	end
	f9_arg0.objTextHolder.objTextElement.text = f9_arg1
	local f9_local0, f9_local1, f9_local2, f9_local3 = GetTextDimensions(f9_arg1, f9_arg0.objTextElement.textFont, f9_arg0.objTextElement.textHeight)
	local f9_local4 = f9_local2 + f9_local0
	local f9_local5 = 20
	if f9_arg1 == "" then
		f9_local5 = 0
	end
	f9_arg0.objTextHolder:registerAnimationState("next_state_length", {
		left = 0,
		top = 0,
		right = f9_local4 + f9_local5,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	})
	if f9_arg2 == LUI.Alignment.Center then
		f9_arg0.objHorizontalList:setAlignment(LUI.Alignment.Center)
	else
		f9_arg0.objHorizontalList:setAlignment(LUI.Alignment.Left)
	end
	f9_arg0.objTextHolder:animateToState("default", CoD.ObjectiveText.CollapseDuration)
end

CoD.ObjectiveText.ActiveSquares = function (f10_arg0, f10_arg1)
	f10_arg0.topHalf:beginAnimation("active")
	f10_arg0.topHalf:setRGB(CoD.ObjectiveText.ColorValue.r, CoD.ObjectiveText.ColorValue.g, CoD.ObjectiveText.ColorValue.b)
	f10_arg0.bottomHalf:beginAnimation("active")
	f10_arg0.bottomHalf:setRGB(CoD.ObjectiveText.ColorValue.r, CoD.ObjectiveText.ColorValue.g, CoD.ObjectiveText.ColorValue.b)
end

CoD.ObjectiveText.InActiveSquares = function (f11_arg0, f11_arg1)
	f11_arg0.topHalf:beginAnimation("inactive")
	f11_arg0.topHalf:setRGB(CoD.VisorImage.ColorValue.r, CoD.VisorImage.ColorValue.g, CoD.VisorImage.ColorValue.b)
	f11_arg0.bottomHalf:beginAnimation("inactive")
	f11_arg0.bottomHalf:setRGB(CoD.VisorImage.ColorValue.r, CoD.VisorImage.ColorValue.g, CoD.VisorImage.ColorValue.b)
end

CoD.ObjectiveText.NewTextLength = function (f12_arg0, f12_arg1)
	if f12_arg0.objTextElement.text ~= nil then
		f12_arg0:animateToState("next_state_length", 500)
		f12_arg0.objTextElement:setText(f12_arg0.objTextElement.text)
	end
end

CoD.ObjectiveText.SpinSquare = function (f13_arg0, f13_arg1, f13_arg2)
	f13_arg0:registerAnimationState("new_location", f13_arg1)
	if f13_arg2 == nil then
		f13_arg2 = 2000
	end
	f13_arg0:animateToState("new_location", f13_arg2)
	f13_arg0.objHorizontalList:beginAnimation("spin_0")
	f13_arg0.objHorizontalList:setZRot(0)
end

CoD.ObjectiveText.Spin0 = function (f14_arg0, f14_arg1)
	if f14_arg1.interrupted ~= true then
		f14_arg0:beginAnimation("spin_360", CoD.ObjectiveText.SpinRotataionTime)
		f14_arg0:setZRot(360)
	end
end

CoD.ObjectiveText.Spin360 = function (f15_arg0, f15_arg1)
	if f15_arg1.interrupted ~= true then
		f15_arg0:beginAnimation("spin_0")
		f15_arg0:setZRot(0)
	end
end

CoD.ObjectiveText.CloseSpinner = function (f16_arg0, f16_arg1)
	f16_arg0.objHorizontalList:animateToState("default")
end

CoD.ObjectiveText.ObjectiveText = function (f17_arg0, f17_arg1)
	if f17_arg1.string == "" then
		return 
	end
	local f17_local0 = Engine.Localize(f17_arg1.string)
	local f17_local1 = CoD.textSize[CoD.ObjectiveText.FontName]
	local f17_local2 = CoD.fonts[CoD.ObjectiveText.FontName]
	local f17_local3 = LUI.UIText.new()
	f17_local3:setLeftRight(true, false, 2, 0)
	f17_local3:setTopBottom(false, true, -f17_local1 - 3, -3)
	f17_local3:setFont(f17_local2)
	f17_local3:setRGB(CoD.ObjectiveText.Blue.r, CoD.ObjectiveText.Blue.g, CoD.ObjectiveText.Blue.b)
	f17_local3:setAlpha(0)
	f17_arg0.objTextHolder:addElement(f17_local3)
	f17_local3.lifeTimer = LUI.UITimer.new(CoD.ObjectiveText.ObjectiveLifetime, {
		name = "animate",
		animationStateName = "remove",
		duration = CoD.ObjectiveText.ScrollDuration
	}, true, f17_local3)
	f17_arg0:addElement(f17_local3.lifeTimer)
	f17_local3.currentPosition = 0
	f17_local3:registerAnimationState("position_1", {
		alpha = 1
	})
	for f17_local4 = 2, CoD.ObjectiveText.MaxLines + 1, 1 do
		local f17_local7 = nil
		if f17_local4 == CoD.ObjectiveText.MaxLines + 1 then
			f17_local7 = 0
		end
		f17_local3:registerAnimationState("position_" .. f17_local4, {
			topAnchor = false,
			bottomAnchor = true,
			top = -f17_local1 * f17_local4 - 3,
			bottom = -f17_local1 * (f17_local4 - 1) - 3,
			alpha = f17_local7
		})
	end
	f17_local3:registerAnimationState("remove", {
		alpha = 0
	})
	f17_local3:registerEventHandler("objective_text", CoD.ObjectiveText.TextElement_ObjectiveText)
	f17_local3:registerEventHandler("transition_complete_position_" .. CoD.ObjectiveText.MaxLines + 1, CoD.ObjectiveText.TextElement_Remove)
	f17_local3:registerEventHandler("transition_complete_remove", CoD.ObjectiveText.TextElement_Remove)
	f17_local3:registerEventHandler("time_up", CoD.ObjectiveText.TextElement_Remove)
	table.insert(f17_arg0.textElements, f17_local3)
	f17_local3:setText(f17_local0)
	local f17_local4, f17_local5, f17_local6, f17_local8 = GetTextDimensions(f17_local0, f17_local2, f17_local1)
	f17_local3.textWidth = f17_local6 + f17_local4
	CoD.ObjectiveText.UpdateSize(f17_arg0)
	f17_arg0:dispatchEventToChildren(f17_arg1)
end

CoD.ObjectiveText.UpdateSize = function (f18_arg0)
	local f18_local0 = 0
	for f18_local4, f18_local5 in ipairs(f18_arg0.textElements) do
		f18_local0 = math.max(f18_local0, f18_local5.textWidth)
	end
	if 0 < f18_local0 then
		f18_local0 = f18_local0 + 4
		f18_arg0:dispatchEventToChildren({
			name = "active_squares"
		})
	else
		f18_arg0:addElement(LUI.UITimer.new(CoD.ObjectiveText.ScrollDuration, "inactive_squares", true, f18_arg0))
	end
	f18_arg0.objTextHolder:registerAnimationState("next_state_length", {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f18_local0
	})
	f18_arg0.objTextHolder:animateToState("next_state_length", CoD.ObjectiveText.ScrollDuration, true, true)
	f18_local1 = (math.min(#f18_arg0.textElements, CoD.ObjectiveText.MaxLines) - 1) * CoD.textSize[CoD.ObjectiveText.FontName]
	if f18_local1 < 0 then
		f18_local1 = 0
	end
	f18_arg0.objHorizontalList:registerAnimationState("resize", {
		topAnchor = true,
		bottomAnchor = true,
		top = -f18_local1,
		bottom = 0,
		alignment = LUI.Alignment.Left
	})
	f18_arg0.objHorizontalList:animateToState("resize", CoD.ObjectiveText.ScrollDuration, true, true)
end

CoD.ObjectiveText.RemoveObjectiveText = function (f19_arg0, f19_arg1)
	f19_arg0.textElements[1]:close()
	table.remove(f19_arg0.textElements, 1)
	CoD.ObjectiveText.UpdateSize(f19_arg0)
end

CoD.ObjectiveText.TextElement_ObjectiveText = function (f20_arg0, f20_arg1)
	f20_arg0.currentPosition = f20_arg0.currentPosition + 1
	if f20_arg0.currentPosition > CoD.ObjectiveText.MaxLines then
		f20_arg0.lifeTimer:close()
	end
	if f20_arg0.currentPosition == 1 then
		f20_arg0:animateToState("position_" .. f20_arg0.currentPosition, CoD.ObjectiveText.ScrollDuration * 2, true, false)
	else
		f20_arg0:animateToState("position_" .. f20_arg0.currentPosition, CoD.ObjectiveText.ScrollDuration)
	end
end

CoD.ObjectiveText.TextElement_Remove = function (f21_arg0, f21_arg1)
	f21_arg0:dispatchEventToParent({
		name = "remove_objective_text"
	})
end

CoD.ObjectiveText.SetupWarMessage = function (f22_arg0, f22_arg1)
	local f22_local0 = f22_arg1.data[1]
	if not f22_local0 then
		return 
	else
		local f22_local1 = Engine.GetIString(f22_local0, "CS_LOCALIZED_STRINGS")
		local f22_local2 = 500
		local f22_local3 = 100
		f22_arg0:spinSquare({
			leftAnchor = false,
			rightAnchor = false,
			left = -CoD.ObjectiveText.DefaultWidth / 2,
			right = CoD.ObjectiveText.DefaultWidth / 2,
			topAnchor = false,
			bottomAnchor = false,
			top = -CoD.ObjectiveText.DefaultHeight / 2 - f22_local3,
			bottom = CoD.ObjectiveText.DefaultHeight / 2 - f22_local3
		}, f22_local2)
		f22_arg0:addElement(LUI.UITimer.new(f22_local2, {
			name = "display_war_message",
			text = f22_local1
		}, true, f22_arg0))
	end
end

CoD.ObjectiveText.DisplayWarMessage = function (f23_arg0, f23_arg1)
	f23_arg0:setNewTextObj(Engine.Localize(f23_arg1.text), LUI.Alignment.Center)
	f23_arg0.objTextElement:flicker(0, nil, 0.5, 1, 750, 750)
end

CoD.ObjectiveText.RemoveWarMessage = function (f24_arg0, f24_arg1)
	local f24_local0 = 250
	f24_arg0:processEvent({
		name = "clear_objective"
	})
	f24_arg0:addElement(LUI.UITimer.new(f24_local0, "bootup_lower_left", true, f24_arg0))
end

