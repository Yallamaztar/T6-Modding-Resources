CoD.RTSFriendlyAI = {}
CoD.RTSFriendlyAI.ReticleTargetSpeed = 500
CoD.RTSFriendlyAI.MinFrequency = 1.5
CoD.RTSFriendlyAI.MaxFrequency = 5.5
CoD.RTSFriendlyAI.MinHumanFrequency = 1.5
CoD.RTSFriendlyAI.MaxHumanFrequency = 5.5
CoD.RTSFriendlyAI.buttonLeftOffset = 4
CoD.RTSFriendlyAI.buttonTopOffset = 2
CoD.RTSFriendlyAI.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setAlpha(1)
	Widget:registerEventHandler("transition_complete_die", Widget.close)
	Widget.entityNum = f1_arg0
	Widget.squadID = f1_arg2
	if f1_arg1 then
		Widget.minFrequency = CoD.RTSFriendlyAI.MinHumanFrequency
		Widget.maxFrequency = CoD.RTSFriendlyAI.MaxHumanFrequency
	else
		Widget.minFrequency = CoD.RTSFriendlyAI.MinFrequency
		Widget.maxFrequency = CoD.RTSFriendlyAI.MaxFrequency
	end
	if not f1_arg3 then
		f1_arg3 = 0
	end
	Widget.centerContainer = LUI.UIElement.new()
	Widget.centerContainer:setLeftRight(false, false, -1, 1)
	Widget.centerContainer:setTopBottom(false, false, -1, 1)
	Widget.centerContainer:setupEntityContainer(f1_arg0, 0, 0, f1_arg3)
	Widget:addElement(Widget.centerContainer)
	Widget.topContainer = LUI.UIElement.new()
	Widget.topContainer:setLeftRight(false, false, -1, 1)
	Widget.topContainer:setTopBottom(false, false, -1, 1)
	Widget.topContainer:setupEntityContainer(f1_arg0, 0, 0, f1_arg3 * 2)
	Widget:addElement(Widget.topContainer)
	local f1_local1 = 32
	local f1_local2 = 20
	local f1_local3 = -32
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f1_local1 / 2, f1_local1 / 2)
	Widget:setTopBottom(false, false, f1_local3 - f1_local2 / 2, f1_local3 + f1_local2 / 2)
	Widget.topContainer:addElement(Widget)
	local f1_local5 = LUI.UIImage.new()
	f1_local5:setLeftRight(true, true, 0, 0)
	f1_local5:setTopBottom(true, true, 0, 0)
	f1_local5:setRGB(0, 0, 0)
	f1_local5:setAlpha(0.3)
	Widget:addElement(f1_local5)
	local f1_local6 = 5
	local f1_local7 = 5
	for f1_local8 = 0, f1_local6 - 1, 1 do
		local f1_local11 = f1_local2 / (f1_local6 - 1) * f1_local8
		local f1_local12 = LUI.UIImage.new()
		f1_local12:setLeftRight(true, true, 0, 0)
		f1_local12:setTopBottom(true, false, f1_local11, f1_local11 + 1)
		f1_local12:setAlpha(0.05)
		Widget:addElement(f1_local12)
	end
	for f1_local8 = 0, f1_local7 - 1, 1 do
		local f1_local11 = f1_local1 / (f1_local7 - 1) * f1_local8
		local f1_local12 = LUI.UIImage.new()
		f1_local12:setLeftRight(true, false, f1_local11, f1_local11 + 1)
		f1_local12:setTopBottom(true, true, 0, 0)
		f1_local12:setAlpha(0.05)
		Widget:addElement(f1_local12)
	end
	local f1_local8 = math.random()
	local f1_local9 = math.random()
	local f1_local10 = nil
	if f1_arg1 then
		f1_local10 = "hud_ekg"
	else
		f1_local10 = "hud_sin_wave"
	end
	Widget.healthBarImage = LUI.UIImage.new()
	Widget.healthBarImage:setLeftRight(true, true, 0, 0)
	Widget.healthBarImage:setTopBottom(true, true, 2, -2)
	Widget.healthBarImage:setImage(RegisterMaterial(f1_local10))
	Widget.healthBarImage:setRGB(0, 1, 0)
	Widget.healthBarImage:setShaderVector(0, f1_local8, f1_local9, Widget.minFrequency, 1)
	Widget:addElement(Widget.healthBarImage)
	Widget.timeOffset = f1_local8
	Widget.waveOffset = f1_local9
	Widget.tacOrderButton = UIExpression.TableLookup(nil, CoD.RTS.DataTable, CoD.RTS.DataTableIndexColumn, f1_arg4, CoD.RTS.DataTableOrderButtonColumn)
	local f1_local13 = 0
	if Widget.tacOrderButton == "DPAD_RIGHT" then
		f1_local13 = 90
	elseif Widget.tacOrderButton == "DPAD_LEFT" then
		f1_local13 = -90
	elseif Widget.tacOrderButton == "DPAD_UP" then
		f1_local13 = 180
	end
	Widget.tacOrderButtonImage = LUI.UIElement.new()
	Widget.tacOrderButtonImage:setLeftRight(false, false, -CoD.RTSDockedSquad.BottomDockWidth / 2 - CoD.RTSDockedSquad.HorizontalSpacing / 2, CoD.RTSDockedSquad.BottomDockWidth / 2 + CoD.RTSDockedSquad.HorizontalSpacing / 2)
	Widget.tacOrderButtonImage:setTopBottom(true, false, 0, CoD.RTSDockedSquad.Height)
	Widget.tacOrderButtonImage.gamepadImage = LUI.UIImage.new()
	Widget.tacOrderButtonImage.gamepadImage.defaultImage = RegisterMaterial("hud_rts_dpad_arrow")
	Widget.tacOrderButtonImage.gamepadImage.highlightImage = RegisterMaterial("hud_rts_dpad_arrow_lit")
	Widget.tacOrderButtonImage.gamepadImage:setLeftRight(true, false, 0, CoD.RTSDockedSquad.ButtonImageHeight)
	Widget.tacOrderButtonImage.gamepadImage:setTopBottom(true, false, CoD.RTSFriendlyAI.buttonTopOffset, CoD.RTSDockedSquad.ButtonImageHeight + CoD.RTSFriendlyAI.buttonTopOffset)
	Widget.tacOrderButtonImage.gamepadImage:setImage(Widget.tacOrderButtonImage.gamepadImage.defaultImage)
	Widget.tacOrderButtonImage.gamepadImage:setZRot(f1_local13)
	Widget.tacOrderButtonImage:addElement(Widget.tacOrderButtonImage.gamepadImage)
	if CoD.isPC then
		Widget.tacOrderButtonImage.keyboardPrompt = LUI.UIText.new()
		Widget.tacOrderButtonImage.keyboardPrompt:setLeftRight(true, false, 0, CoD.RTSDockedSquad.ButtonImageHeight)
		Widget.tacOrderButtonImage.keyboardPrompt:setTopBottom(true, false, CoD.RTSFriendlyAI.buttonTopOffset, CoD.RTSDockedSquad.ButtonImageHeight + CoD.RTSFriendlyAI.buttonTopOffset)
		Widget.tacOrderButtonImage.keyboardPrompt:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
		Widget.tacOrderButtonImage.keyboardPrompt:setFont(CoD.fonts.Condensed)
		Widget.tacOrderButtonImage:addElement(Widget.tacOrderButtonImage.keyboardPrompt)
	end
	Widget:addElement(Widget.tacOrderButtonImage)
	Widget:registerEventHandler("rts_deselect", CoD.RTSFriendlyAI.Deselect)
	Widget:registerEventHandler("rts_highlight", CoD.RTSFriendlyAI.Highlight)
	Widget:registerEventHandler("rts_highlight_squad", CoD.RTSFriendlyAI.HighlightSquad)
	Widget:registerEventHandler("rts_remove_ai", CoD.RTSFriendlyAI.Remove)
	Widget:registerEventHandler("rts_target", CoD.RTSFriendlyAI.Target)
	Widget:registerEventHandler("rts_update_health", CoD.RTSFriendlyAI.UpdateHealth)
	if CoD.isPC then
		Widget:registerEventHandler("input_source_changed", CoD.RTSFriendlyAI.InputSourceChanged)
		if CoD.useController and Engine.LastInput_Gamepad() then
			CoD.RTSFriendlyAI.InputSourceChanged(Widget, {
				source = 0
			})
		else
			CoD.RTSFriendlyAI.InputSourceChanged(Widget, {
				source = 1
			})
		end
	end
	return Widget
end

CoD.RTSFriendlyAI.SetGamepadPrompt = function (f2_arg0, f2_arg1)
	if f2_arg0.tacOrderButtonImage ~= nil then
		f2_arg0.tacOrderButtonImage.gamepadImage:setLeftRight(true, false, 0, CoD.RTSDockedSquad.ButtonImageHeight)
		f2_arg0.tacOrderButtonImage.gamepadImage:setTopBottom(true, false, CoD.RTSFriendlyAI.buttonTopOffset, CoD.RTSDockedSquad.ButtonImageHeight + CoD.RTSFriendlyAI.buttonTopOffset)
		f2_arg0.tacOrderButtonImage.keyboardPrompt:setTopBottom(true, false, 0, 0)
		f2_arg0.tacOrderButtonImage.keyboardPrompt:setLeftRight(true, false, 0, 0)
	end
end

CoD.RTSFriendlyAI.SetKeyboardPrompt = function (f3_arg0, f3_arg1)
	if f3_arg0.tacOrderButtonImage ~= nil then
		f3_arg0.tacOrderButtonImage.gamepadImage:setTopBottom(true, false, 0, 0)
		f3_arg0.tacOrderButtonImage.gamepadImage:setLeftRight(true, false, 0, 0)
		f3_arg0.tacOrderButtonImage.keyboardPrompt:setTopBottom(true, false, CoD.RTSFriendlyAI.buttonTopOffset, CoD.RTSDockedSquad.ButtonImageHeight + CoD.RTSFriendlyAI.buttonTopOffset)
		f3_arg0.tacOrderButtonImage.keyboardPrompt:setLeftRight(true, false, 0, CoD.RTSDockedSquad.ButtonImageHeight)
	end
end

CoD.RTSFriendlyAI.SetKeyBind = function (f4_arg0, f4_arg1)
	local f4_local0, f4_local1 = nil
	if f4_arg0.tacOrderButtonImage ~= nil and f4_arg0.tacOrderButton ~= nil then
		if f4_arg0.tacOrderButton == "DPAD_RIGHT" then
			f4_local1 = "+actionslot 4"
		elseif f4_arg0.tacOrderButton == "DPAD_LEFT" then
			f4_local1 = "+actionslot 3"
		elseif f4_arg0.tacOrderButton == "DPAD_UP" then
			f4_local1 = "+actionslot 1"
		else
			f4_local1 = "+actionslot 2"
		end
		f4_arg0.tacOrderButtonImage.keyboardPrompt:setText(Engine.GetKeyBindingLocalizedString(0, f4_local1, 0))
	end
end

CoD.RTSFriendlyAI.InputSourceChanged = function (f5_arg0, f5_arg1)
	if CoD.isPC and f5_arg0.tacOrderButtonImage ~= nil then
		if CoD.useController and f5_arg1.source == 0 then
			CoD.RTSFriendlyAI.SetGamepadPrompt(f5_arg0, f5_arg1)
		else
			CoD.RTSFriendlyAI.SetKeyBind(f5_arg0, f5_arg1)
			CoD.RTSFriendlyAI.SetKeyboardPrompt(f5_arg0, f5_arg1)
		end
	end
end

CoD.RTSFriendlyAI.AddReticle = function (f6_arg0)
	if f6_arg0.reticle then
		return 
	else
		f6_arg0:dispatchEventToParent({
			name = "rts_update_overlord_help",
			text = Engine.Localize("SO_RTS_TACTICAL_INSTRUCTION_FRIENDLY")
		})
		f6_arg0.reticle = CoD.RTS.NewReticle("hud_rts_target")
		f6_arg0.centerContainer:addElement(f6_arg0.reticle)
	end
end

CoD.RTSFriendlyAI.Deselect = function (f7_arg0, f7_arg1)
	if f7_arg0.entityNum ~= f7_arg1.data[1] then
		return 
	elseif f7_arg0.reticle then
		f7_arg0:dispatchEventToParent({
			name = "rts_update_overlord_help"
		})
		f7_arg0.reticle:close()
		f7_arg0.reticle = nil
	end
end

CoD.RTSFriendlyAI.ForceHighlightSquad = function (f8_arg0)
	f8_arg0.tacOrderButtonImage.gamepadImage:setImage(f8_arg0.tacOrderButtonImage.gamepadImage.highlightImage)
end

CoD.RTSFriendlyAI.Highlight = function (f9_arg0, f9_arg1)
	if f9_arg0.entityNum ~= f9_arg1.data[1] then
		return 
	else
		CoD.RTSFriendlyAI.AddReticle(f9_arg0)
		f9_arg0.reticle:animateToState("default", CoD.RTSFriendlyAI.ReticleTargetSpeed)
	end
end

CoD.RTSFriendlyAI.HighlightSquad = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg1.data[1]
	if f10_local0 == -1 then
		f10_arg0.tacOrderButtonImage.gamepadImage:setImage(f10_arg0.tacOrderButtonImage.gamepadImage.defaultImage)
		if f10_arg0.tacOrderButtonImage.keyboardPrompt then
			f10_arg0.tacOrderButtonImage.keyboardPrompt:setRGB(CoD.visorBlue.r, CoD.visorBlue.g, CoD.visorBlue.b)
		end
	elseif f10_local0 == 99 then
		f10_arg0.tacOrderButtonImage.gamepadImage:setImage(f10_arg0.tacOrderButtonImage.gamepadImage.highlightImage)
		if f10_arg0.tacOrderButtonImage.keyboardPrompt then
			f10_arg0.tacOrderButtonImage.keyboardPrompt:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		end
	elseif f10_arg0.squadID == f10_local0 then
		f10_arg0.tacOrderButtonImage.gamepadImage:setImage(f10_arg0.tacOrderButtonImage.gamepadImage.highlightImage)
		if f10_arg0.tacOrderButtonImage.keyboardPrompt then
			f10_arg0.tacOrderButtonImage.keyboardPrompt:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		end
	else
		f10_arg0.tacOrderButtonImage.gamepadImage:setImage(f10_arg0.tacOrderButtonImage.gamepadImage.defaultImage)
		if f10_arg0.tacOrderButtonImage.keyboardPrompt then
			f10_arg0.tacOrderButtonImage.keyboardPrompt:setRGB(CoD.visorBlue.r, CoD.visorBlue.g, CoD.visorBlue.b)
		end
	end
end

CoD.RTSFriendlyAI.Remove = function (f11_arg0, f11_arg1)
	if f11_arg0.entityNum ~= f11_arg1.data[1] then
		return 
	else
		CoD.RTSFriendlyAI.SetHealth(f11_arg0, 0, 100)
		f11_arg0:beginAnimation("die", 2000)
		f11_arg0:setAlpha(0)
	end
end

CoD.RTSFriendlyAI.Target = function (f12_arg0, f12_arg1)
	if f12_arg0.entityNum ~= f12_arg1.data[1] then
		return 
	else
		CoD.RTSFriendlyAI.AddReticle(f12_arg0)
		f12_arg0.reticle:animateToState("target")
	end
end

CoD.RTSFriendlyAI.UpdateHealth = function (f13_arg0, f13_arg1)
	if f13_arg0.entityNum ~= f13_arg1.data[1] then
		return 
	else
		CoD.RTSFriendlyAI.SetHealth(f13_arg0, f13_arg1.data[2], f13_arg1.data[3])
	end
end

CoD.RTSFriendlyAI.SetHealth = function (f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = f14_arg1 / f14_arg2
	local f14_local1 = f14_local0
	local f14_local2 = f14_arg0.minFrequency + (f14_arg0.maxFrequency - f14_arg0.minFrequency) * (1 - f14_local0)
	local f14_local3 = 1
	local f14_local4 = 1
	if f14_local0 > 0.5 then
		f14_local3 = 1 - (f14_local0 - 0.5) / 0.5
	else
		f14_local3 = 1
		f14_local4 = f14_local0 / 0.5
	end
	f14_arg0.healthBarImage:beginAnimation("color_change", 250)
	f14_arg0.healthBarImage:setRGB(f14_local3, f14_local4, 0)
	f14_arg0.healthBarImage:setShaderVector(0, f14_arg0.timeOffset, f14_arg0.waveOffset, f14_local2, f14_local1)
end

