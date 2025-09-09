CoD.RTSDockedSquad = {}
CoD.RTSDockedSquad.BottomDockWidth = 64
CoD.RTSDockedSquad.BottomDockHeight = 32
CoD.RTSDockedSquad.BottomDockMaterialName = "hud_rts_unit_dock02"
CoD.RTSDockedSquad.BracketWidth = 32
CoD.RTSDockedSquad.BracketMaterialName = "hud_rts_bracket"
CoD.RTSDockedSquad.ButtonImageHeight = 16
CoD.RTSDockedSquad.HorizontalSpacing = 12
CoD.RTSDockedSquad.InDuration = 1000
CoD.RTSDockedSquad.OutDuration = 1000
CoD.RTSDockedSquad.SquadImageWidth = 48
CoD.RTSDockedSquad.SquadImageHeight = 48
CoD.RTSDockedSquad.Height = CoD.RTSDockedSquad.SquadImageHeight + CoD.textSize.Condensed + CoD.RTSDockedSquad.ButtonImageHeight + CoD.textSize.Condensed
CoD.RTSDockedSquad.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, 0, 0)
	Widget:setTopBottom(false, true, 0, CoD.RTSDockedSquad.Height)
	Widget.squadIDs = {}
	Widget.squadIDs[f1_arg0] = true
	Widget.selectedSquads = {}
	Widget.numSelectedSquads = 0
	Widget.updateLimitedUnitCount = CoD.RTSDockedSquad.UpdateLimitedUnitCount
	Widget.orderButton = UIExpression.TableLookup(nil, CoD.RTS.DataTable, CoD.RTS.DataTableIndexColumn, f1_arg1, CoD.RTS.DataTableOrderButtonColumn)
	local f1_local1 = 0
	if Widget.orderButton == "DPAD_RIGHT" then
		f1_local1 = 90
	elseif Widget.orderButton == "DPAD_LEFT" then
		f1_local1 = -90
	elseif Widget.orderButton == "DPAD_UP" then
		f1_local1 = 180
	end
	Widget.orderButtonImage = LUI.UIElement.new()
	Widget.orderButtonImage:setLeftRight(false, false, -CoD.RTSDockedSquad.BottomDockWidth / 2 - CoD.RTSDockedSquad.HorizontalSpacing / 2, CoD.RTSDockedSquad.BottomDockWidth / 2 + CoD.RTSDockedSquad.HorizontalSpacing / 2)
	Widget.orderButtonImage:setTopBottom(true, false, 0, CoD.RTSDockedSquad.Height)
	Widget.orderButtonImage.gamepadImage = LUI.UIImage.new()
	Widget.orderButtonImage.gamepadImage.defaultImage = RegisterMaterial("hud_rts_dpad_arrow")
	Widget.orderButtonImage.gamepadImage.highlightImage = RegisterMaterial("hud_rts_dpad_arrow_lit")
	Widget.orderButtonImage.gamepadImage:setLeftRight(false, false, -CoD.RTSDockedSquad.ButtonImageHeight / 2, CoD.RTSDockedSquad.ButtonImageHeight / 2)
	Widget.orderButtonImage.gamepadImage:setTopBottom(true, false, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight + CoD.RTSDockedSquad.ButtonImageHeight)
	Widget.orderButtonImage.gamepadImage:setImage(Widget.orderButtonImage.gamepadImage.defaultImage)
	Widget.orderButtonImage.gamepadImage:setZRot(f1_local1)
	Widget.orderButtonImage:addElement(Widget.orderButtonImage.gamepadImage)
	if CoD.isPC then
		Widget.orderButtonImage.keyboardPrompt = LUI.UIText.new()
		Widget.orderButtonImage.keyboardPrompt:setLeftRight(true, true, 0, 0)
		Widget.orderButtonImage.keyboardPrompt:setTopBottom(true, false, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight + CoD.RTSDockedSquad.ButtonImageHeight)
		Widget.orderButtonImage.keyboardPrompt:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
		Widget.orderButtonImage.keyboardPrompt:setFont(CoD.fonts.Condensed)
		Widget.orderButtonImage:addElement(Widget.orderButtonImage.keyboardPrompt)
	end
	Widget.orderButtonImage:registerAnimationState("enabled", {
		alpha = 1
	})
	Widget.orderButtonImage:registerAnimationState("dimmed", {
		alpha = 0.1
	})
	Widget:addElement(Widget.orderButtonImage)
	Widget:updateLimitedUnitCount(f1_arg3)
	local f1_local2 = UIExpression.TableLookup(nil, CoD.RTS.DataTable, CoD.RTS.DataTableIndexColumn, f1_arg1, CoD.RTS.DataTableImageColumn)
	local f1_local3 = LUI.UIImage.new()
	f1_local3.defaultImage = RegisterMaterial(f1_local2)
	f1_local3.highlightImage = RegisterMaterial(f1_local2 .. "_lit")
	f1_local3:setLeftRight(false, false, -CoD.RTSDockedSquad.SquadImageWidth / 2, CoD.RTSDockedSquad.SquadImageWidth / 2)
	f1_local3:setTopBottom(true, false, CoD.textSize.Condensed, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight)
	f1_local3:setImage(f1_local3.defaultImage)
	Widget.squadImage = f1_local3
	Widget:addElement(f1_local3)
	
	local squadSize = LUI.UIText.new()
	squadSize:setLeftRight(true, true, 0, 0)
	squadSize:setTopBottom(true, false, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight / 2 - CoD.textSize.Condensed / 2, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight / 2 + CoD.textSize.Condensed / 2)
	squadSize:setFont(CoD.fonts.Condensed)
	Widget:addElement(squadSize)
	Widget.squadSize = squadSize
	
	local reinforcementTime = LUI.UIText.new()
	reinforcementTime:setLeftRight(true, true, 0, 0)
	reinforcementTime:setTopBottom(true, false, 0, CoD.textSize.Condensed)
	reinforcementTime:setFont(CoD.fonts.Condensed)
	reinforcementTime:setRGB(CoD.visorBlue.r, CoD.visorBlue.g, CoD.visorBlue.b)
	CoD.CountdownTimer.Setup(reinforcementTime, 0, true)
	Widget:addElement(reinforcementTime)
	Widget.reinforcementTime = reinforcementTime
	
	if f1_local2 == "hud_rts_karma" then
		local squadNameText = LUI.UIText.new()
		squadNameText:setLeftRight(true, true, 0, 0)
		squadNameText:setTopBottom(true, false, 0, CoD.textSize.Default)
		squadNameText:setFont(CoD.fonts.Default)
		squadNameText:setRGB(CoD.visorBlue.r, CoD.visorBlue.g, CoD.visorBlue.b)
		Widget:addElement(squadNameText)
		Widget.squadNameText = squadNameText
		
		Widget.squadNameText:setText(Engine.Localize("SO_RTS_MP_SOCOTRA_KARMA"))
	end
	Widget:registerEventHandler("rts_add_friendly_ai", CoD.RTSDockedSquad.AddFriendly)
	Widget:registerEventHandler("rts_add_friendly_human", CoD.RTSDockedSquad.AddFriendly)
	Widget:registerEventHandler("rts_add_squad", CoD.RTSDockedSquad.AddSquad)
	Widget:registerEventHandler("rts_update_remaining_count", CoD.RTSDockedSquad.UpdateRemainingCount)
	Widget:registerEventHandler("rts_deselect_squad", CoD.RTSDockedSquad.DeselectSquad)
	Widget:registerEventHandler("rts_remove_squad", CoD.RTSDockedSquad.RemoveSquad)
	Widget:registerEventHandler("rts_remove_ai", CoD.RTSDockedSquad.RemoveFriendly)
	Widget:registerEventHandler("rts_select_squad", CoD.RTSDockedSquad.SelectSquad)
	Widget:registerEventHandler("rts_highlight_squad", CoD.RTSDockedSquad.HighlightSquad)
	Widget:registerEventHandler("squad_appear", CoD.RTSDockedSquad.SquadAppear)
	Widget:registerEventHandler("transition_complete_out", Widget.close)
	if CoD.isPC then
		Widget:registerEventHandler("input_source_changed", CoD.RTSDockedSquad.InputSourceChanged)
	end
	local squadNameText = f1_arg2 - 30000
	if squadNameText <= 0 then
		Widget:processEvent({
			name = "squad_appear"
		})
	else
		Widget:addElement(LUI.UITimer.new(squadNameText, "squad_appear", true, Widget))
	end
	CoD.RTSDockedSquad.AddSquad(Widget, {
		data = {
			f1_arg0,
			f1_arg1,
			f1_arg2
		}
	})
	return Widget
end

CoD.RTSDockedSquad.SetGamepadPrompt = function (f2_arg0, f2_arg1)
	if f2_arg0.orderButtonImage ~= nil then
		f2_arg0.orderButtonImage.gamepadImage:setTopBottom(true, false, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight + CoD.RTSDockedSquad.ButtonImageHeight)
		f2_arg0.orderButtonImage.gamepadImage:setLeftRight(false, false, -CoD.RTSDockedSquad.ButtonImageHeight / 2, CoD.RTSDockedSquad.ButtonImageHeight / 2)
		f2_arg0.orderButtonImage.keyboardPrompt:setTopBottom(true, false, 0, 0)
		f2_arg0.orderButtonImage.keyboardPrompt:setLeftRight(true, false, 0, 0)
	end
end

CoD.RTSDockedSquad.SetKeyboardPrompt = function (f3_arg0, f3_arg1)
	if f3_arg0.orderButtonImage ~= nil then
		f3_arg0.orderButtonImage.gamepadImage:setTopBottom(true, false, 0, 0)
		f3_arg0.orderButtonImage.gamepadImage:setLeftRight(true, false, 0, 0)
		f3_arg0.orderButtonImage.keyboardPrompt:setTopBottom(true, false, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight + CoD.RTSDockedSquad.ButtonImageHeight)
		f3_arg0.orderButtonImage.keyboardPrompt:setLeftRight(true, true, 0, 0)
	end
end

CoD.RTSDockedSquad.SetKeyBind = function (f4_arg0, f4_arg1)
	local f4_local0, f4_local1 = nil
	if f4_arg0.orderButtonImage ~= nil and f4_arg0.orderButton ~= nil then
		if f4_arg0.orderButton == "DPAD_RIGHT" then
			f4_local1 = "+actionslot 4"
		elseif f4_arg0.orderButton == "DPAD_LEFT" then
			f4_local1 = "+actionslot 3"
		elseif f4_arg0.orderButton == "DPAD_UP" then
			f4_local1 = "+actionslot 1"
		else
			f4_local1 = "+actionslot 2"
		end
		f4_arg0.orderButtonImage.keyboardPrompt:setText(Engine.GetKeyBindingLocalizedString(0, f4_local1, 0))
	end
end

CoD.RTSDockedSquad.InputSourceChanged = function (f5_arg0, f5_arg1)
	if CoD.isPC and f5_arg0.orderButtonImage ~= nil then
		if CoD.useController and f5_arg1.source == 0 then
			CoD.RTSDockedSquad.SetGamepadPrompt(f5_arg0, f5_arg1)
		else
			CoD.RTSDockedSquad.SetKeyBind(f5_arg0, f5_arg1)
			CoD.RTSDockedSquad.SetKeyboardPrompt(f5_arg0, f5_arg1)
		end
	end
end

CoD.RTSDockedSquad.AddFriendly = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.data[1]
	if not f6_arg0.squadIDs[f6_arg1.data[2]] then
		return 
	elseif not f6_arg0.squadMembers then
		f6_arg0.squadMembers = {}
		f6_arg0.numSquadMembers = 0
	end
	f6_arg0.squadMembers[f6_local0] = true
	f6_arg0.numSquadMembers = f6_arg0.numSquadMembers + 1
	f6_arg0.squadSize:setText(f6_arg0.numSquadMembers)
	if f6_arg0.numSquadMembers == 1 then
		f6_arg0.squadImage:beginAnimation("active", CoD.RTSDockedSquad.InDuration)
		f6_arg0.squadImage:setAlpha(1)
		f6_arg0.orderButtonImage:beginAnimation("active", CoD.RTSDockedSquad.InDuration)
		f6_arg0.orderButtonImage:animateToState("enabled")
		f6_arg0.orderButtonImage:beginAnimation("fade", CoD.RTSDockedSquad.InDuration)
		f6_arg0.squadSize:setAlpha(1)
	end
end

CoD.RTSDockedSquad.AddSquad = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg1.data[1]
	local f7_local1 = f7_arg1.data[2]
	local f7_local2 = f7_arg1.data[3]
	f7_arg0.squadIDs[f7_local0] = true
	if f7_local2 ~= 0 then
		f7_arg0.reinforcementTime:setTimeLeft(f7_local2)
	end
end

CoD.RTSDockedSquad.UpdateRemainingCount = function (f8_arg0, f8_arg1)
	if f8_arg1.data == nil then
		return 
	end
	local f8_local0 = f8_arg1.data[1]
	if f8_local0 and not f8_arg0.squadIDs[f8_local0] then
		return 
	end
	local f8_local1 = f8_arg1.data[2]
	if f8_local1 == nil then
		f8_local1 = -1
	end
	f8_arg0:updateLimitedUnitCount(f8_local1)
end

CoD.RTSDockedSquad.DeselectSquad = function (f9_arg0, f9_arg1)
	local f9_local0 = nil
	if f9_arg1.data then
		f9_local0 = f9_arg1.data[1]
	end
	if f9_local0 and not f9_arg0.squadIDs[f9_local0] then
		return 
	elseif not f9_arg0.selectedSquads[f9_local0] then
		return 
	end
	f9_arg0.selectedSquads[f9_local0] = nil
	f9_arg0.numSelectedSquads = f9_arg0.numSelectedSquads - 1
	if f9_arg0.numSelectedSquads == 0 then
		if f9_arg0.leftBracket then
			f9_arg0.leftBracket:close()
			f9_arg0.leftBracket = nil
		end
		if f9_arg0.rightBracket then
			f9_arg0.rightBracket:close()
			f9_arg0.rightBracket = nil
		end
	end
end

CoD.RTSDockedSquad.RemoveSquad = function (f10_arg0, f10_arg1)
	local f10_local0 = nil
	if f10_arg1.data then
		f10_local0 = f10_arg1.data[1]
	end
	if f10_local0 and not f10_arg0.squadIDs[f10_local0] then
		return 
	end
	f10_arg0.selectedSquads[f10_local0] = nil
	f10_arg0.numSelectedSquads = f10_arg0.numSelectedSquads - 1
	if f10_arg0.numSelectedSquads < 0 then
		f10_arg0.numSelectedSquads = 0
	end
	if f10_arg0.numSelectedSquads == 0 then
		if f10_arg0.leftBracket then
			f10_arg0.leftBracket:close()
			f10_arg0.leftBracket = nil
		end
		if f10_arg0.rightBracket then
			f10_arg0.rightBracket:close()
			f10_arg0.rightBracket = nil
		end
	end
	f10_arg0:beginAnimation("out", CoD.RTSDockedSquad.OutDuration, true, true)
	f10_arg0:setLeftRight(false, false, 0, 0)
	f10_arg0:setTopBottom(false, true, 0, CoD.RTSDockedSquad.Height)
end

CoD.RTSDockedSquad.RemoveFriendly = function (f11_arg0, f11_arg1)
	local f11_local0 = f11_arg1.data[1]
	if f11_arg0.squadMembers and f11_arg0.squadMembers[f11_local0] then
		f11_arg0.squadMembers[f11_local0] = nil
		f11_arg0.numSquadMembers = f11_arg0.numSquadMembers - 1
		f11_arg0.squadSize:setText(f11_arg0.numSquadMembers)
	end
	if f11_arg0.numSquadMembers and f11_arg0.numSquadMembers <= 0 then
		f11_arg0.squadImage:beginAnimation("fade", CoD.RTSDockedSquad.InDuration)
		f11_arg0.squadImage:setAlpha(0.1)
		f11_arg0.orderButtonImage:beginAnimation("fade", CoD.RTSDockedSquad.InDuration)
		f11_arg0.orderButtonImage:animateToState("dimmed")
		f11_arg0.orderButtonImage:beginAnimation("fade", CoD.RTSDockedSquad.InDuration)
		f11_arg0.squadSize:setAlpha(0.1)
	end
end

CoD.RTSDockedSquad.SelectSquad = function (f12_arg0, f12_arg1)
	local f12_local0 = f12_arg1.data[1]
	if not f12_arg0.squadIDs[f12_local0] then
		return 
	elseif not f12_arg0.selectedSquads[f12_local0] then
		f12_arg0.selectedSquads[f12_local0] = true
		f12_arg0.numSelectedSquads = f12_arg0.numSelectedSquads + 1
	end
	if not f12_arg0.leftBracket then
		f12_arg0.leftBracket = LUI.UIImage.new()
		f12_arg0.leftBracket:setLeftRight(false, false, -CoD.RTSDockedSquad.SquadImageWidth / 2, -CoD.RTSDockedSquad.SquadImageWidth / 2 + CoD.RTSDockedSquad.BracketWidth)
		f12_arg0.leftBracket:setTopBottom(true, false, CoD.textSize.Condensed, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight)
		f12_arg0.leftBracket:setImage(RegisterMaterial(CoD.RTSDockedSquad.BracketMaterialName))
		f12_arg0:addElement(f12_arg0.leftBracket)
	end
	if not f12_arg0.rightBracket then
		f12_arg0.rightBracket = LUI.UIImage.new()
		f12_arg0.rightBracket:setLeftRight(false, false, CoD.RTSDockedSquad.SquadImageWidth / 2, CoD.RTSDockedSquad.SquadImageWidth / 2 - CoD.RTSDockedSquad.BracketWidth)
		f12_arg0.rightBracket:setTopBottom(true, false, CoD.textSize.Condensed, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight)
		f12_arg0.rightBracket:setImage(RegisterMaterial(CoD.RTSDockedSquad.BracketMaterialName))
		f12_arg0:addElement(f12_arg0.rightBracket)
	end
end

CoD.RTSDockedSquad.HighlightSquad = function (f13_arg0, f13_arg1)
	local f13_local0 = f13_arg1.data[1]
	if f13_local0 == -1 then
		f13_arg0.squadImage:setImage(f13_arg0.squadImage.defaultImage)
		f13_arg0.orderButtonImage.gamepadImage:setImage(f13_arg0.orderButtonImage.gamepadImage.defaultImage)
		if f13_arg0.orderButtonImage.keyboardPrompt then
			f13_arg0.orderButtonImage.keyboardPrompt:setRGB(CoD.visorBlue.r, CoD.visorBlue.g, CoD.visorBlue.b)
		end
		if f13_arg0.squadNameText then
			f13_arg0.squadNameText:setRGB(CoD.visorBlue.r, CoD.visorBlue.g, CoD.visorBlue.b)
		end
	elseif f13_local0 == 99 then
		f13_arg0.squadImage:setImage(f13_arg0.squadImage.highlightImage)
		f13_arg0.orderButtonImage.gamepadImage:setImage(f13_arg0.orderButtonImage.gamepadImage.highlightImage)
		if f13_arg0.orderButtonImage.keyboardPrompt then
			f13_arg0.orderButtonImage.keyboardPrompt:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		end
		if f13_arg0.squadNameText then
			f13_arg0.squadNameText:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		end
	elseif f13_arg0.squadIDs[f13_local0] == true then
		f13_arg0.squadImage:setImage(f13_arg0.squadImage.highlightImage)
		f13_arg0.orderButtonImage.gamepadImage:setImage(f13_arg0.orderButtonImage.gamepadImage.highlightImage)
		if f13_arg0.orderButtonImage.keyboardPrompt then
			f13_arg0.orderButtonImage.keyboardPrompt:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		end
		if f13_arg0.squadNameText then
			f13_arg0.squadNameText:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		end
	else
		f13_arg0.squadImage:setImage(f13_arg0.squadImage.defaultImage)
		f13_arg0.orderButtonImage.gamepadImage:setImage(f13_arg0.orderButtonImage.gamepadImage.defaultImage)
		if f13_arg0.orderButtonImage.keyboardPrompt then
			f13_arg0.orderButtonImage.keyboardPrompt:setRGB(CoD.visorBlue.r, CoD.visorBlue.g, CoD.visorBlue.b)
		end
		if f13_arg0.squadNameText then
			f13_arg0.squadNameText:setRGB(CoD.visorBlue.r, CoD.visorBlue.g, CoD.visorBlue.b)
		end
	end
end

CoD.RTSDockedSquad.SquadAppear = function (f14_arg0, f14_arg1)
	f14_arg0:beginAnimation("in", CoD.RTSDockedSquad.InDuration, true, true)
	f14_arg0:setLeftRight(false, false, -CoD.RTSDockedSquad.BottomDockWidth / 2 - CoD.RTSDockedSquad.HorizontalSpacing / 2, CoD.RTSDockedSquad.BottomDockWidth / 2 + CoD.RTSDockedSquad.HorizontalSpacing / 2)
	f14_arg0:setTopBottom(true, false, 0, CoD.RTSDockedSquad.Height)
	if CoD.isPC then
		if CoD.useController and Engine.LastInput_Gamepad() then
			CoD.RTSDockedSquad.InputSourceChanged(f14_arg0, {
				source = 0
			})
		else
			CoD.RTSDockedSquad.InputSourceChanged(f14_arg0, {
				source = 1
			})
		end
	end
end

CoD.RTSDockedSquad.UpdateLimitedUnitCount = function (f15_arg0, f15_arg1)
	if not f15_arg1 then
		return 
	elseif f15_arg0.limitedUnitCount then
		if f15_arg1 <= -1 then
			f15_arg0.limitedUnitCount:close()
			f15_arg0.limitedUnitCount = nil
		else
			f15_arg0.limitedUnitCount:setText(f15_arg1)
		end
	elseif f15_arg1 > -1 then
		local f15_local0 = LUI.UIText.new()
		f15_local0:setLeftRight(true, true, 0, 0)
		f15_local0:setTopBottom(true, false, CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight + CoD.RTSDockedSquad.ButtonImageHeight, 2 * CoD.textSize.Condensed + CoD.RTSDockedSquad.SquadImageHeight + CoD.RTSDockedSquad.ButtonImageHeight)
		f15_local0:setFont(CoD.fonts.Condensed)
		f15_local0:setText(f15_arg1)
		f15_arg0:addElement(f15_local0)
		f15_arg0.limitedUnitCount = f15_local0
	end
end

