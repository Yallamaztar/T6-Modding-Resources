CoD.WeaponLabel = {}
CoD.WeaponLabel.FontName = "ExtraSmall"
CoD.WeaponLabel.SquareSize = CoD.textSize[CoD.WeaponLabel.FontName]
CoD.WeaponLabel.HalfSquareSize = CoD.WeaponLabel.SquareSize / 2
CoD.WeaponLabel.CloseSquaresElapsedTime = 2000
CoD.WeaponLabel.CloseSquaresTimerInterval = 500
CoD.WeaponLabel.CloseSquaresCountLimit = CoD.WeaponLabel.CloseSquaresElapsedTime / CoD.WeaponLabel.CloseSquaresTimerInterval
CoD.WeaponLabel.DefaultAlpha = 1
CoD.WeaponLabel.ColorValue = {}
CoD.WeaponLabel.ColorValue.r = 0.75
CoD.WeaponLabel.ColorValue.b = 0.75
CoD.WeaponLabel.ColorValue.g = 0.75
CoD.WeaponLabel.ColorValue.alpha = 0.75
CoD.WeaponLabel.Blue = CoD.visorBlue3
CoD.WeaponLabel.DefaultStyle = "twenties"
CoD.WeaponLabel.new = function (f1_arg0)
	local f1_local0 = CoD.textSize[CoD.WeaponLabel.FontName]
	local f1_local1 = -55
	local f1_local2 = -CoD.OffhandIcons.Size - CoD.AmmoCounter.BracketHeight - 10
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, f1_local1 - 100, f1_local1)
	Widget:setTopBottom(false, true, f1_local2 - f1_local0, f1_local2)
	Widget:setAlpha(0)
	Widget.id = Widget.id .. ".WeaponLabel"
	Widget:registerEventHandler("update_style", CoD.WeaponLabel.UpdateStyle)
	Widget:registerEventHandler("hud_update_weapon_select", CoD.WeaponLabel.UpdateWeapon)
	Widget:registerEventHandler("close_squares_timer", CoD.WeaponLabel.CloseSquaresTimer)
	Widget:registerEventHandler("bootup_fade_in", CoD.WeaponLabel.BootupFadeIn)
	Widget:registerEventHandler("bootup_switch_to_hud", CoD.WeaponLabel.BootupSwitchToHUD)
	local f1_local4 = LUI.UIHorizontalList.new()
	f1_local4:setLeftRight(true, true, 0, 0)
	f1_local4:setTopBottom(true, true, 0, 0)
	f1_local4:setAlignment(LUI.Alignment.Right)
	f1_local4.id = f1_local4.id .. ".WeaponLabelHorizontalList"
	Widget:addElement(f1_local4)
	CoD.WeaponLabel.HalfSquareMaterial = RegisterMaterial("menu_vis_half_square")
	local f1_local5 = CoD.WeaponLabel.HalfSquare(CoD.WeaponLabel.HalfSquareSize, 0, -90)
	f1_local5.id = f1_local5.id .. ".LeftHalfSquare"
	f1_local4:addElement(f1_local5)
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	Widget.id = Widget.id .. ".WeaponLabelTextHolder"
	Widget:setUseStencil(true)
	f1_local4:addElement(Widget)
	Widget:registerAnimationState("close_squares", {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0
	})
	Widget:registerEventHandler("transition_complete_default", CoD.WeaponLabel.NewTextLength)
	local f1_local7 = CoD.textSize[CoD.WeaponLabel.FontName]
	
	local textElement = LUI.UIText.new()
	textElement:setLeftRight(true, true, 0, 0)
	textElement:setTopBottom(false, false, -f1_local7 / 2, f1_local7 / 2)
	textElement:setFont(CoD.fonts[CoD.WeaponLabel.FontName])
	textElement:setRGB(CoD.WeaponLabel.Blue.r, CoD.WeaponLabel.Blue.g, CoD.WeaponLabel.Blue.b)
	textElement:setAlpha(CoD.WeaponLabel.DefaultAlpha)
	textElement.id = textElement.id .. ".WeaponLabelTextElement"
	Widget:addElement(textElement)
	Widget.textElement = textElement
	
	Widget:registerEventHandler("transition_complete_slow_show_text", CoD.WeaponLabel.TextShownComplete)
	Widget:registerEventHandler("text_wait_complete", CoD.WeaponLabel.TextWaitComplete)
	local f1_local9 = CoD.WeaponLabel.HalfSquare(CoD.WeaponLabel.HalfSquareSize, 90, 180)
	f1_local9.id = f1_local9.id .. ".RightHalfSquare"
	f1_local4:addElement(f1_local9)
	Widget.setNewWeaponLabel = CoD.WeaponLabel.SetNewWeaponLabel
	Widget.horizontalList = f1_local4
	Widget.leftHalfSquare = f1_local5
	Widget.textHolder = Widget
	Widget.rightHalfSquare = f1_local9
	return Widget
end

CoD.WeaponLabel.HalfSquare = function (f2_arg0, f2_arg1, f2_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f2_arg0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setAlpha(CoD.WeaponLabel.DefaultAlpha)
	local f2_local1 = CoD.WeaponLabel.HalfSquareMaterial
	local f2_local2 = LUI.UIImage.new()
	f2_local2:setLeftRight(false, false, -f2_arg0 / 2, f2_arg0 / 2)
	f2_local2:setTopBottom(true, false, 0, f2_arg0)
	f2_local2:setImage(f2_local1)
	f2_local2:setRGB(CoD.VisorImage.ColorValue.r, CoD.VisorImage.ColorValue.g, CoD.VisorImage.ColorValue.b)
	f2_local2:setAlpha(CoD.WeaponLabel.DefaultAlpha)
	f2_local2:setZRot(f2_arg1)
	Widget:addElement(f2_local2)
	local f2_local3 = LUI.UIImage.new()
	f2_local3:setLeftRight(false, false, -f2_arg0 / 2, f2_arg0 / 2)
	f2_local3:setTopBottom(false, true, -f2_arg0, 0)
	f2_local3:setImage(f2_local1)
	f2_local3:setRGB(CoD.VisorImage.ColorValue.r, CoD.VisorImage.ColorValue.g, CoD.VisorImage.ColorValue.b)
	f2_local3:setAlpha(CoD.WeaponLabel.DefaultAlpha)
	f2_local3:setZRot(f2_arg2)
	Widget:addElement(f2_local3)
	Widget:registerEventHandler("active_squares", CoD.WeaponLabel.ActiveSquares)
	Widget:registerEventHandler("inactive_squares", CoD.WeaponLabel.InActiveSquares)
	Widget.topHalf = f2_local2
	Widget.bottomHalf = f2_local3
	return Widget
end

CoD.WeaponLabel.ActiveSquares = function (f3_arg0, f3_arg1)
	f3_arg0.topHalf:beginAnimation("active")
	f3_arg0.topHalf:setRGB(CoD.WeaponLabel.ColorValue.r, CoD.WeaponLabel.ColorValue.g, CoD.WeaponLabel.ColorValue.b)
	f3_arg0.bottomHalf:beginAnimation("active")
	f3_arg0.bottomHalf:setRGB(CoD.WeaponLabel.ColorValue.r, CoD.WeaponLabel.ColorValue.g, CoD.WeaponLabel.ColorValue.b)
end

CoD.WeaponLabel.InActiveSquares = function (f4_arg0, f4_arg1)
	f4_arg0.topHalf:beginAnimation("inactive")
	f4_arg0.topHalf:setRGB(CoD.VisorImage.ColorValue.r, CoD.VisorImage.ColorValue.g, CoD.VisorImage.ColorValue.b)
	f4_arg0.bottomHalf:beginAnimation("inactive")
	f4_arg0.bottomHalf:setRGB(CoD.VisorImage.ColorValue.r, CoD.VisorImage.ColorValue.g, CoD.VisorImage.ColorValue.b)
end

CoD.WeaponLabel.BootupFadeIn = function (f5_arg0, f5_arg1)
	f5_arg0:beginAnimation("show", 500)
	f5_arg0:setAlpha(CoD.WeaponLabel.DefaultAlpha)
end

CoD.WeaponLabel.CloseSquaresTimer = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0.textHolder.textElement
	local f6_local1 = 250
	if f6_arg0.closeSquaresCounter >= CoD.WeaponLabel.CloseSquaresCountLimit then
		f6_arg0.textTimer:close()
		f6_arg0.textTimer = nil
		f6_arg0.textHolder:animateToState("close_squares", f6_local1)
		f6_arg0:addElement(LUI.UITimer.new(f6_local1, "inactive_squares", true, f6_arg0))
		return 
	else
		f6_arg0.closeSquaresCounter = f6_arg0.closeSquaresCounter + 1
	end
end

CoD.WeaponLabel.UpdateStyle = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg1.style
	if f7_local0 == nil then
		f7_local0 = CoD.WeaponLabel.DefaultStyle
		f7_arg1.style = f7_local0
	end
	if f7_arg0.currentStyle == f7_local0 then
		return 
	elseif f7_local0 == "eighties" then
		f7_arg0.leftHalfSquare:setAlpha(0)
		f7_arg0.rightHalfSquare:setAlpha(0)
		f7_arg0:registerEventHandler("hud_update_weapon_select", CoD.WeaponLabel.UpdateWeapon80s)
		f7_arg0.setNewWeaponLabel = CoD.WeaponLabel.SetNewWeaponLabel80s
		f7_arg0.textHolder:setUseStencil(false)
	else
		f7_arg0.leftHalfSquare:setAlpha(1)
		f7_arg0.rightHalfSquare:setAlpha(1)
		f7_arg0:registerEventHandler("hud_update_weapon_select", CoD.WeaponLabel.UpdateWeapon)
		f7_arg0.setNewWeaponLabel = CoD.WeaponLabel.SetNewWeaponLabel
		f7_arg0.textHolder:setUseStencil(true)
	end
end

CoD.WeaponLabel.UpdateWeapon = function (f8_arg0, f8_arg1)
	if UIExpression.InVehicle() == 1 then
		return 
	end
	local f8_local0 = UIExpression.ToUpper(nil, Engine.Localize(f8_arg1.weaponDisplayName))
	local f8_local1 = ""
	local f8_local2 = ""
	local f8_local3 = ""
	if f8_arg1.attachment1DisplayName ~= nil then
		f8_local1 = UIExpression.ToUpper(nil, Engine.Localize(f8_arg1.attachment1DisplayName))
	end
	if f8_arg1.attachment2DisplayName ~= nil then
		f8_local2 = UIExpression.ToUpper(nil, Engine.Localize(f8_arg1.attachment2DisplayName))
	end
	if f8_arg1.attachment3DisplayName ~= nil then
		f8_local3 = UIExpression.ToUpper(nil, Engine.Localize(f8_arg1.attachment3DisplayName))
	end
	if f8_arg0.localizedWeaponName ~= f8_local0 or f8_arg0.localizedAttachment1Name ~= f8_local1 or f8_arg0.localizedAttachment2Name ~= f8_local2 or f8_arg0.localizedAttachment3Name ~= f8_local3 then
		f8_arg0.localizedWeaponName = f8_local0
		f8_arg0.localizedAttachment1Name = f8_local1
		f8_arg0.localizedAttachment2Name = f8_local2
		f8_arg0.localizedAttachment3Name = f8_local3
		if f8_local2 ~= "" then
			f8_local1 = Engine.Localize("MENU_CUSTOMIZED_CAPS")
			f8_local2 = ""
			f8_local3 = ""
		end
		if f8_local1 ~= "" then
			f8_local0 = f8_local0 .. " " .. f8_local1
		end
		if f8_local2 ~= "" then
			f8_local0 = f8_local0 .. " " .. f8_local2
		end
		if f8_local3 ~= "" then
			f8_local0 = f8_local0 .. " " .. f8_local3
		end
		if f8_arg0.textHolder.textElement.text ~= f8_local0 then
			f8_arg0:setNewWeaponLabel(f8_local0)
			f8_arg0.closeSquaresCounter = 0
			if f8_arg0.textTimer == nil then
				f8_arg0.textTimer = LUI.UITimer.new(CoD.WeaponLabel.CloseSquaresTimerInterval, "close_squares_timer", false)
				f8_arg0:addElement(f8_arg0.textTimer)
			end
		end
	end
end

CoD.WeaponLabel.UpdateWeapon80s = function (f9_arg0, f9_arg1)
	if UIExpression.InVehicle() == 1 then
		return 
	end
	local f9_local0 = UIExpression.ToUpper(nil, Engine.Localize(f9_arg1.weaponDisplayName))
	if f9_arg0.textHolder.textElement.text ~= f9_local0 then
		f9_arg0:setNewWeaponLabel(f9_local0)
	end
end

CoD.WeaponLabel.SetNewWeaponLabel = function (f10_arg0, f10_arg1)
	f10_arg0.textHolder.textElement.text = f10_arg1
	local f10_local0, f10_local1, f10_local2, f10_local3 = GetTextDimensions(f10_arg1, CoD.fonts[CoD.WeaponLabel.FontName], CoD.textSize[CoD.WeaponLabel.FontName])
	local f10_local4 = f10_local2 + f10_local0
	local f10_local5 = 10
	if f10_arg1 == "" then
		f10_local5 = 0
	end
	f10_arg0.textHolder:registerAnimationState("next_state_length", {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f10_local4 + f10_local5,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	f10_arg0.textHolder:animateToState("default", 250)
	f10_arg0:dispatchEventToChildren({
		name = "active_squares"
	})
end

CoD.WeaponLabel.SetNewWeaponLabel80s = function (f11_arg0, f11_arg1)
	local f11_local0 = f11_arg0.textHolder.textElement
	f11_local0.text = f11_arg1
	local f11_local1, f11_local2, f11_local3, f11_local4 = GetTextDimensions(f11_arg1, CoD.fonts[CoD.WeaponLabel.FontName], CoD.textSize[CoD.WeaponLabel.FontName])
	local f11_local5 = f11_local3 + f11_local1
	local f11_local6 = 10
	if f11_arg1 == "" then
		f11_local6 = 0
	end
	f11_arg0.textHolder:setLeftRight(true, false, 0, f11_local5 + f11_local6)
	f11_local0:setText(f11_local0.text)
	f11_arg0.textHolder:beginAnimation("instant_hide")
	f11_arg0.textHolder:setAlpha(0)
	f11_arg0.textHolder:beginAnimation("slow_show_text", 500)
	f11_arg0.textHolder:setAlpha(1)
end

CoD.WeaponLabel.NewTextLength = function (f12_arg0, f12_arg1)
	if f12_arg0.textElement.text ~= nil then
		f12_arg0:animateToState("next_state_length", 250)
		f12_arg0.textElement:setText(f12_arg0.textElement.text)
	end
end

CoD.WeaponLabel.BootupSwitchToHUD = function (f13_arg0, f13_arg1)
	f13_arg0:setAlpha(CoD.WeaponLabel.DefaultAlpha)
end

CoD.WeaponLabel.TextShownComplete = function (f14_arg0, f14_arg1)
	f14_arg0:addElement(LUI.UITimer.new(1000, "text_wait_complete", true, f14_arg0))
end

CoD.WeaponLabel.TextWaitComplete = function (f15_arg0, f15_arg1)
	f15_arg0:beginAnimation("slow_hide_text", 500)
	f15_arg0:setAlpha(0)
end

