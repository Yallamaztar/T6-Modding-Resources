CoD.ClawHudController = {}
CoD.ClawHudController.BottomDockWidth = 64
CoD.ClawHudController.BottomDockHeight = 32
CoD.ClawHudController.BottomDockMaterialName = "hud_rts_unit_dock02"
CoD.ClawHudController.BracketWidth = 32
CoD.ClawHudController.BracketMaterialName = "hud_rts_bracket"
CoD.ClawHudController.ButtonImageHeight = 16
if CoD.isPC then
	CoD.ClawHudController.HorizontalSpacing = 30
else
	CoD.ClawHudController.HorizontalSpacing = 12
end
CoD.ClawHudController.InDuration = 1000
CoD.ClawHudController.OutDuration = 1000
CoD.ClawHudController.SquadImageWidth = 48
CoD.ClawHudController.SquadImageHeight = 48
CoD.ClawHudController.Height = CoD.ClawHudController.SquadImageHeight + CoD.textSize.Condensed + CoD.ClawHudController.ButtonImageHeight
CoD.ClawHudController.LEFT = 1
CoD.ClawHudController.RIGHT = 2
CoD.ClawHudController.DOWN = 3
CoD.ClawHudController.new = function ()
	CoD.ClawHudController.DpadArrow = "hud_rts_dpad_arrow"
	local f1_local0 = "hud_rts_claw"
	local f1_local1 = "hud_rts_troops"
	local f1_local2, f1_local3 = Engine.GetUserSafeArea()
	local f1_local4 = LUI.UIHorizontalList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -((720 - f1_local3) / 2) - CoD.ClawHudController.Height - CoD.textSize.Default,
		bottom = 0,
		alignment = LUI.Alignment.Center
	})
	f1_local4.id = f1_local4.id .. ".ClawHudController"
	f1_local4:setPriority(100)
	f1_local4:registerEventHandler("hud_pak_claw_controller_close", CoD.ClawHudController.CloseController)
	f1_local4:registerEventHandler("hud_pak_remove_claw_controller", CoD.ClawHudController.RemoveClawController)
	f1_local4.dockedClaws = {}
	CoD.ClawHudController.AddDockedItem(f1_local4, "DPAD_LEFT", f1_local0, CoD.ClawHudController.LEFT)
	CoD.ClawHudController.AddDockedItem(f1_local4, "DPAD_RIGHT", f1_local0, CoD.ClawHudController.RIGHT)
	CoD.ClawHudController.AddDockedItem(f1_local4, "DPAD_DOWN", f1_local1, CoD.ClawHudController.DOWN)
	return f1_local4
end

CoD.ClawHudController.CloseController = function (f2_arg0, f2_arg1)
	if f2_arg0 then
		f2_arg0:dispatchEventToChildren({
			name = "animate_out"
		})
	end
	f2_arg0:dispatchEventToParent({
		name = "hud_toggle_compass_vis",
		shouldShow = 1
	})
end

CoD.ClawHudController.AddDockedItem = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -CoD.ClawHudController.BottomDockWidth / 2 - CoD.ClawHudController.HorizontalSpacing / 2, CoD.ClawHudController.BottomDockWidth / 2 + CoD.ClawHudController.HorizontalSpacing / 2)
	Widget:setTopBottom(true, false, 0, CoD.ClawHudController.Height)
	Widget.dockedClawNumber = f3_arg3
	local f3_local1 = 0
	if f3_arg1 == "DPAD_RIGHT" then
		f3_local1 = 90
	elseif f3_arg1 == "DPAD_LEFT" then
		f3_local1 = -90
	elseif f3_arg1 == "DPAD_UP" then
		f3_local1 = 180
	end
	Widget.orderButton = f3_arg1
	Widget.orderButtonImage = LUI.UIElement.new()
	Widget.orderButtonImage:setLeftRight(false, false, -CoD.ClawHudController.BottomDockWidth / 2 - CoD.ClawHudController.HorizontalSpacing / 2, CoD.ClawHudController.BottomDockWidth / 2 + CoD.ClawHudController.HorizontalSpacing / 2)
	Widget.orderButtonImage:setTopBottom(true, false, 0, CoD.ClawHudController.Height)
	Widget.orderButtonImage.gamepadImage = LUI.UIImage.new()
	Widget.orderButtonImage.gamepadImage:setLeftRight(false, false, -CoD.ClawHudController.ButtonImageHeight / 2, CoD.ClawHudController.ButtonImageHeight / 2)
	Widget.orderButtonImage.gamepadImage:setTopBottom(true, false, CoD.textSize.Condensed + CoD.ClawHudController.SquadImageHeight, CoD.textSize.Condensed + CoD.ClawHudController.SquadImageHeight + CoD.ClawHudController.ButtonImageHeight)
	Widget.orderButtonImage.gamepadImage.defaultImage = RegisterMaterial(CoD.ClawHudController.DpadArrow)
	Widget.orderButtonImage.gamepadImage.litImage = RegisterMaterial(CoD.ClawHudController.DpadArrow .. "_lit")
	Widget.orderButtonImage.gamepadImage:setImage(Widget.orderButtonImage.gamepadImage.defaultImage)
	Widget.orderButtonImage.gamepadImage:setZRot(f3_local1)
	Widget.orderButtonImage:addElement(Widget.orderButtonImage.gamepadImage)
	if CoD.isPC then
		Widget.orderButtonImage.keyboardPrompt = LUI.UIText.new()
		Widget.orderButtonImage.keyboardPrompt:setLeftRight(true, true, 0, 0)
		Widget.orderButtonImage.keyboardPrompt:setTopBottom(true, false, CoD.textSize.Condensed + CoD.ClawHudController.SquadImageHeight, CoD.textSize.Condensed + CoD.ClawHudController.SquadImageHeight + CoD.ClawHudController.ButtonImageHeight)
		Widget.orderButtonImage.keyboardPrompt:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
		Widget.orderButtonImage.keyboardPrompt:setFont(CoD.fonts.Condensed)
		Widget.orderButtonImage:addElement(Widget.orderButtonImage.keyboardPrompt)
	end
	Widget:addElement(Widget.orderButtonImage)
	local f3_local2 = LUI.UIImage.new()
	f3_local2:setLeftRight(false, false, -CoD.ClawHudController.SquadImageWidth / 2, CoD.ClawHudController.SquadImageWidth / 2)
	f3_local2:setTopBottom(true, false, CoD.textSize.Condensed, CoD.textSize.Condensed + CoD.ClawHudController.SquadImageHeight)
	f3_local2.defaultImage = RegisterMaterial(f3_arg2)
	f3_local2.litImage = RegisterMaterial(f3_arg2 .. "_lit")
	f3_local2:setImage(f3_local2.defaultImage)
	Widget.clawImage = f3_local2
	Widget:addElement(f3_local2)
	Widget:registerEventHandler("animate_out", CoD.ClawHudController.AnimateOutClaw)
	Widget:registerEventHandler("transition_complete_out", Widget.close)
	Widget:registerEventHandler("hud_pak_highlight_claw", CoD.ClawHudController.HighlightSquad)
	if CoD.isPC then
		Widget:registerEventHandler("input_source_changed", CoD.ClawHudController.InputSourceChanged)
		if CoD.isPC then
			if CoD.useController and Engine.LastInput_Gamepad() then
				CoD.RTSDockedSquad.InputSourceChanged(Widget, {
					source = 0
				})
			else
				CoD.RTSDockedSquad.InputSourceChanged(Widget, {
					source = 1
				})
			end
		end
	end
	f3_arg0:addElement(Widget)
	f3_arg0.dockedClaws[f3_arg3] = Widget
end

CoD.ClawHudController.RemoveClawController = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg1.data[1]
	if not f4_arg0.dockedClaws[f4_local0] then
		return 
	else
		f4_arg0.dockedClaws[f4_local0]:processEvent({
			name = "animate_out"
		})
		f4_arg0.dockedClaws[f4_local0] = nil
	end
end

CoD.ClawHudController.AnimateOutClaw = function (f5_arg0)
	f5_arg0:beginAnimation("out", CoD.ClawHudController.OutDuration, true, true)
	f5_arg0:setLeftRight(false, false, 0, 0)
	f5_arg0:setTopBottom(false, true, 0, CoD.ClawHudController.Height)
end

CoD.ClawHudController.HighlightSquad = function (f6_arg0, f6_arg1)
	if not f6_arg0 then
		return 
	end
	f6_arg0.orderButtonImage.gamepadImage:setImage(f6_arg0.orderButtonImage.gamepadImage.defaultImage)
	f6_arg0.clawImage:setImage(f6_arg0.clawImage.defaultImage)
	if f6_arg0.orderButtonImage.keyboardPrompt then
		f6_arg0.orderButtonImage.keyboardPrompt:setRGB(CoD.visorBlue.r, CoD.visorBlue.g, CoD.visorBlue.b)
	end
	local f6_local0 = f6_arg1.data[1]
	if f6_local0 == f6_arg0.dockedClawNumber then
		f6_arg0.orderButtonImage.gamepadImage:setImage(f6_arg0.orderButtonImage.gamepadImage.litImage)
		f6_arg0.clawImage:setImage(f6_arg0.clawImage.litImage)
		if f6_arg0.orderButtonImage.keyboardPrompt then
			f6_arg0.orderButtonImage.keyboardPrompt:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		end
		if f6_local0 == CoD.ClawHudController.DOWN then
			f6_arg0:dispatchEventToParent({
				name = "hud_toggle_compass_vis",
				shouldShow = 0
			})
		end
	end
end

CoD.ClawHudController.SetGamepadPrompt = function (f7_arg0, f7_arg1)
	if f7_arg0.orderButtonImage ~= nil then
		f7_arg0.orderButtonImage.gamepadImage:setLeftRight(false, false, -CoD.ClawHudController.ButtonImageHeight / 2, CoD.ClawHudController.ButtonImageHeight / 2)
		f7_arg0.orderButtonImage.gamepadImage:setTopBottom(true, false, CoD.textSize.Condensed + CoD.ClawHudController.SquadImageHeight, CoD.textSize.Condensed + CoD.ClawHudController.SquadImageHeight + CoD.ClawHudController.ButtonImageHeight)
		f7_arg0.orderButtonImage.keyboardPrompt:setTopBottom(true, false, 0, 0)
		f7_arg0.orderButtonImage.keyboardPrompt:setLeftRight(true, false, 0, 0)
	end
end

CoD.ClawHudController.SetKeyboardPrompt = function (f8_arg0, f8_arg1)
	if f8_arg0.orderButtonImage ~= nil then
		f8_arg0.orderButtonImage.gamepadImage:setTopBottom(true, false, 0, 0)
		f8_arg0.orderButtonImage.gamepadImage:setLeftRight(true, false, 0, 0)
		f8_arg0.orderButtonImage.keyboardPrompt:setTopBottom(true, false, CoD.textSize.Condensed + CoD.ClawHudController.SquadImageHeight, CoD.textSize.Condensed + CoD.ClawHudController.SquadImageHeight + CoD.ClawHudController.ButtonImageHeight)
		f8_arg0.orderButtonImage.keyboardPrompt:setLeftRight(true, true, 0, 0)
	end
end

CoD.ClawHudController.SetKeyBind = function (f9_arg0, f9_arg1)
	local f9_local0, f9_local1 = nil
	if f9_arg0.orderButtonImage ~= nil and f9_arg0.orderButton ~= nil then
		if f9_arg0.orderButton == "DPAD_RIGHT" then
			f9_local1 = "+actionslot 4"
		elseif f9_arg0.orderButton == "DPAD_LEFT" then
			f9_local1 = "+actionslot 3"
		elseif f9_arg0.orderButton == "DPAD_UP" then
			f9_local1 = "+actionslot 1"
		else
			f9_local1 = "+actionslot 2"
		end
		f9_arg0.orderButtonImage.keyboardPrompt:setText(Engine.GetKeyBindingLocalizedString(0, f9_local1, 0))
	end
end

CoD.ClawHudController.InputSourceChanged = function (f10_arg0, f10_arg1)
	if CoD.isPC and f10_arg0.orderButtonImage ~= nil then
		if CoD.useController and f10_arg1.source == 0 then
			CoD.ClawHudController.SetGamepadPrompt(f10_arg0, f10_arg1)
		else
			CoD.ClawHudController.SetKeyBind(f10_arg0, f10_arg1)
			CoD.ClawHudController.SetKeyboardPrompt(f10_arg0, f10_arg1)
		end
	end
end

