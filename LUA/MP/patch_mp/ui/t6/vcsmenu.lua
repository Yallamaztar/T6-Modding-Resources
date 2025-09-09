local f0_local0 = {
	"vcs/pitfall2.bin",
	"vcs/hero.bin",
	"vcs/kaboom.bin",
	"vcs/riverraid.bin"
}
local f0_local1 = function (f1_arg0)
	f1_arg0.buttonPromptHolder:setAlpha(0)
	f1_arg0.buttonPromptHolder:beginAnimation("animate_popup_in", 1000, false, true)
	f1_arg0.buttonPromptHolder:setAlpha(1)
end

local f0_local2 = function (f2_arg0)
	Engine.Exec(f2_arg0:getOwner(), "vcs_stop")
	Engine.Exec(f2_arg0:getOwner(), "vcs_start " .. f0_local0[f2_arg0.currentGame] .. " 1")
end

local f0_local3 = function (f3_arg0)
	Engine.Exec(f3_arg0:getOwner(), "vcs_stop")
	Engine.SendMenuResponse(f3_arg0:getOwner(), "vcs", "vcs_stop")
	CoD.Menu.close(f3_arg0)
end

local f0_local4 = function (f4_arg0, f4_arg1)
	f4_arg0.updateBlur = CoD.Menu.updateBlur
	f4_arg0.updateIngamePopupBg = CoD.Menu.updateIngamePopupBg
	f4_arg0:goBack(f4_arg0:getOwner())
end

local f0_local5 = function (f5_arg0, f5_arg1)
	f5_arg0.currentGame = f5_arg0.currentGame - 1
	if f5_arg0.currentGame < 1 then
		f5_arg0.currentGame = #f0_local0
	end
	f0_local2(f5_arg0)
end

local f0_local6 = function (f6_arg0, f6_arg1)
	f6_arg0.currentGame = f6_arg0.currentGame + 1
	if #f0_local0 < f6_arg0.currentGame then
		f6_arg0.currentGame = 1
	end
	f0_local2(f6_arg0)
end

local f0_local7 = function (f7_arg0, f7_arg1)
	if f7_arg0.m_inputDisabled then
		return 
	elseif UIExpression.IsControllerBeingUsed(f7_arg1.controller) == 1 and f7_arg0.m_ownerController == f7_arg1.controller then
		if f7_arg1.down then
			if f7_arg1.button == "up" or f7_arg1.button == "left" or f7_arg1.button == "right" or f7_arg1.button == "down" then
				f7_arg0.joystickDirection = f7_arg1.button
				f7_arg0.joystickImage:setImage(RegisterMaterial("vcs_joystick_" .. f7_arg1.button))
			elseif f7_arg1.button == "primary" or f7_arg1.button == "start" or f7_arg1.button == "select" then
				f7_arg0.joystickButtonPressed = f7_arg1.button
				f7_arg0.joystickButtonImage:setImage(RegisterMaterial("vcs_joystick_button_down"))
			end
		elseif f7_arg1.button == f7_arg0.joystickDirection then
			f7_arg0.joystickDirection = nil
			f7_arg0.joystickImage:setImage(RegisterMaterial("vcs_joystick_center"))
		elseif f7_arg1.button == f7_arg0.joystickButtonPressed then
			f7_arg0.joystickButtonPressed = nil
			f7_arg0.joystickButtonImage:setImage(RegisterMaterial("vcs_joystick_button_up"))
		end
		return f7_arg0:dispatchEventToChildren(f7_arg1)
	else

	end
end

LUI.createMenu.vcs = function (f8_arg0)
	local f8_local0 = CoD.Menu.NewFromState("vcs")
	f8_local0:setLeftRight(true, true, 0, 0)
	f8_local0:setTopBottom(true, true, 0, 0)
	f8_local0:setOwner(f8_arg0)
	f8_local0.animateIn = f0_local1
	f8_local0.close = f0_local3
	f8_local0.updateBlur = CoD.NullFunction
	f8_local0.updateIngamePopupBg = CoD.NullFunction
	f8_local0.currentGame = 1
	Engine.SetUIActive(f8_arg0, true)
	Engine.LockInput(f8_arg0, true)
	f0_local2(f8_local0)
	local Widget = LUI.UIElement.new()
	Widget:sizeToSafeArea(f8_arg0)
	f8_local0:addElement(Widget)
	local f8_local2 = 768
	local f8_local3 = 384
	local viewmodel = LUI.UIElement.new()
	viewmodel:setLeftRight(false, false, -f8_local2 / 2, f8_local2 / 2)
	viewmodel:setTopBottom(false, true, 0, f8_local3)
	if 1 == UIExpression.DvarBool(nil, "disable_vcs_viewmodel") then
		viewmodel:setAlpha(0)
	end
	f8_local0:addElement(viewmodel)
	f8_local0.viewmodel = viewmodel
	
	viewmodel:beginAnimation("viewmodel_raise", 500, true, true)
	viewmodel:setTopBottom(false, true, -f8_local3, 0)
	f8_local0:registerEventHandler("vcs_stop_playing", function (f9_arg0, f9_arg1)
		f9_arg0.viewmodel:beginAnimation("viewmodel_lower", 500, true, false)
		f9_arg0.viewmodel:setTopBottom(false, true, 0, f8_local3)
	end)
	f8_local0.viewmodel:registerEventHandler("transition_complete_viewmodel_lower", function (Sender, Event)
		Sender:dispatchEventToParent({
			name = "vcs_shutdown"
		})
	end)
	
	local joystickButtonImage = LUI.UIImage.new()
	joystickButtonImage:setLeftRight(true, true, 0, 0)
	joystickButtonImage:setTopBottom(true, true, 0, 0)
	joystickButtonImage:setImage(RegisterMaterial("vcs_joystick_button_up"))
	viewmodel:addElement(joystickButtonImage)
	f8_local0.joystickButtonImage = joystickButtonImage
	
	local joystickImage = LUI.UIImage.new()
	joystickImage:setLeftRight(true, true, 0, 0)
	joystickImage:setTopBottom(true, true, 0, 0)
	joystickImage:setImage(RegisterMaterial("vcs_joystick_center"))
	viewmodel:addElement(joystickImage)
	f8_local0.joystickImage = joystickImage
	
	local buttonPromptHolder = LUI.UIVerticalList.new()
	buttonPromptHolder:setLeftRight(true, true, 0, 0)
	buttonPromptHolder:setTopBottom(false, true, -CoD.ButtonPrompt.Height - 7200, -10)
	buttonPromptHolder:setAlignment(LUI.Alignment.Bottom)
	Widget:addElement(buttonPromptHolder)
	f8_local0.buttonPromptHolder = buttonPromptHolder
	
	local f8_local8 = CoD.ButtonPrompt.new
	local f8_local9 = "alt1"
	local f8_local10 = Engine.Localize("MPUI_VCS_STOP_PLAYING")
	local f8_local11 = f8_local0
	local f8_local12 = "vcs_stop_playing"
	local f8_local13, f8_local14 = false
	local f8_local15, f8_local16 = false
	buttonPromptHolder:addElement(f8_local8(f8_local9, f8_local10, f8_local11, f8_local12, f8_local13, f8_local14, f8_local15, f8_local16, "F", nil))
	f8_local9 = CoD.ButtonPrompt.new
	f8_local10 = "shoulderr"
	f8_local11 = Engine.Localize("MPUI_VCS_NEXT_GAME")
	f8_local12 = f8_local0
	f8_local13 = "vcs_next_game"
	f8_local14, f8_local15 = false
	local f8_local16, f8_local17 = false
	buttonPromptHolder:addElement(f8_local9(f8_local10, f8_local11, f8_local12, f8_local13, f8_local14, f8_local15, f8_local16, f8_local17, "N", nil))
	f8_local9 = CoD.ButtonPrompt.new
	f8_local10 = "shoulderl"
	f8_local11 = Engine.Localize("MPUI_VCS_PREV_GAME")
	f8_local12 = f8_local0
	f8_local13 = "vcs_prev_game"
	f8_local14, f8_local15 = false
	f8_local16, f8_local17 = false
	buttonPromptHolder:addElement(f8_local9(f8_local10, f8_local11, f8_local12, f8_local13, f8_local14, f8_local15, f8_local16, f8_local17, "P", nil))
	f8_local9 = CoD.ButtonPrompt.new
	f8_local10 = "primary"
	f8_local11 = Engine.Localize("MPUI_VCS_FIRE")
	f8_local12 = f8_local0
	f8_local13 = nil
	f8_local14, f8_local15 = false
	buttonPromptHolder:addElement(f8_local9(f8_local10, f8_local11, f8_local12, f8_local13, f8_local14, f8_local15, false, "space", nil, nil))
	f8_local9 = CoD.ButtonPrompt.new
	f8_local10 = "select"
	f8_local11 = Engine.Localize("MPUI_VCS_SELECT")
	f8_local12 = f8_local0
	f8_local13 = nil
	f8_local14, f8_local15 = false
	buttonPromptHolder:addElement(f8_local9(f8_local10, f8_local11, f8_local12, f8_local13, f8_local14, f8_local15, false, "backspace", nil, nil))
	f8_local9 = CoD.ButtonPrompt.new
	f8_local10 = "start"
	f8_local11 = Engine.Localize("MPUI_VCS_START_GAME")
	f8_local12 = f8_local0
	f8_local13 = nil
	f8_local14, f8_local15 = false
	buttonPromptHolder:addElement(f8_local9(f8_local10, f8_local11, f8_local12, f8_local13, f8_local14, f8_local15, false, "primary", nil, nil))
	f8_local0:registerEventHandler("gamepad_button", f0_local7)
	f8_local0:registerEventHandler("vcs_prev_game", f0_local5)
	f8_local0:registerEventHandler("vcs_next_game", f0_local6)
	f8_local0:registerEventHandler("vcs_shutdown", f0_local4)
	f8_local0:registerEventHandler("close_all_ingame_menus", f0_local4)
	f8_local0:registerEventHandler("first_snapshot", f0_local4)
	return f8_local0
end

