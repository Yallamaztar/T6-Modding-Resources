require("T6.WiiUKeyBindSelector")
CoD.WiiURemoteCustomize = {}
CoD.WiiURemoteCustomize.CommandTextTop = CoD.Menu.TitleHeight + 8
CoD.WiiURemoteCustomize.CommandTextBottom = CoD.WiiURemoteCustomize.CommandTextTop + CoD.CoD9Button.TextHeight
CoD.WiiURemoteCustomize.ButtonListTop = CoD.WiiURemoteCustomize.CommandTextBottom + 16
CoD.WiiURemoteCustomize.ButtonLabelLeft = CoD.WiiUKeyBindSelector.ButtonTextLeft - 16
CoD.WiiURemoteCustomize.GestureLabelLeft = CoD.WiiUKeyBindSelector.GestureTextLeft - 16
CoD.WiiURemoteCustomize.Actions = {
	attack = {
		command = "+attack",
		label = Engine.Localize("MENU_ATTACK")
	},
	ads = {
		command = "+speed_throw",
		label = Engine.Localize("MENU_AIM_DOWN_THE_SIGHT")
	},
	melee_attack = {
		command = "+melee",
		label = Engine.Localize("MENU_MELEE_ATTACK")
	},
	switch_weapon = {
		command = "+weapnext_inventory",
		label = Engine.Localize("MENU_SWITCH_WEAPON")
	},
	reload_weapon = {
		command = "+reload",
		label = Engine.Localize("MENU_RELOAD_WEAPON")
	},
	use_sprint_lock_camera = {
		command = "+sprint_and_cameralock",
		label = Engine.Localize("MENU_SPRINT_USE_CAMERALOCK")
	},
	throw_lethals = {
		command = "+frag",
		label = Engine.Localize("MENU_THROW_FRAG_GRENADE")
	},
	throw_tacticals = {
		command = "+smoke",
		label = Engine.Localize("MENU_THROW_SPECIAL_GRENADE")
	},
	change_stance = {
		command = "+stance",
		label = Engine.Localize("MENU_CHANGE_STANCE")
	},
	jump = {
		command = "+gostand",
		label = Engine.Localize("MENU_JUMP")
	},
	inventory = {
		command = "+actionslot_carousel",
		label = Engine.Localize("MENU_INVENTORY")
	},
	scoreboard = {
		command = "togglescores",
		label = Engine.Localize("MENU_SCOREBOARD")
	}
}
local f0_local0 = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.WiiURemoteCustomize.Actions[f1_arg1]
	f1_arg0.buttons[f1_arg1] = f1_arg0.buttonList:addWiiUKeyBindSelector(f1_arg0.controller, f1_local0.label, f1_local0)
	f1_arg0.buttons[f1_arg1].owner = f1_arg0
end

local f0_local1 = function (f2_arg0)
	if f2_arg0.selectedButton ~= nil and Engine.CanUnbindButton(f2_arg0.controller, f2_arg0.selectedButton.action.command) then
		f2_arg0.removeButtonButton:enable()
	else
		f2_arg0.removeButtonButton:disable()
	end
	if f2_arg0.selectedButton ~= nil and Engine.CanUnbindGesture(f2_arg0.controller, f2_arg0.selectedButton.action.command) then
		f2_arg0.removeGestureButton:enable()
	else
		f2_arg0.removeGestureButton:disable()
	end
end

local f0_local2 = function (f3_arg0, f3_arg1)
	f3_arg0.buttonList.hintText:updateText(Engine.Localize("PLATFORM_BUTTON_CUSTOMIZER_INST_1"))
	f0_local1(f3_arg0)
	for f3_local3, f3_local4 in pairs(f3_arg0.buttons) do
		f3_local4:processEvent({
			name = "refresh",
			controller = f3_arg1.controller
		})
	end
end

local f0_local3 = function (f4_arg0, f4_arg1)
	Engine.RestoreDefaultKeyBindings(f4_arg0.controller)
	f0_local2(f4_arg0, f4_arg1)
end

local f0_local4 = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.selectedButton.action.command
	if Engine.IsGestureBindingAllowed(f5_local0) and not Engine.IsTwistBindingAllowed(f5_local0) then
		f5_arg0.buttonList.hintText:updateText(Engine.Localize("PLATFORM_BUTTON_CUSTOMIZER_INST_2_GEST"))
	elseif Engine.IsTwistBindingAllowed(f5_local0) then
		f5_arg0.buttonList.hintText:updateText(Engine.Localize("PLATFORM_BUTTON_CUSTOMIZER_INST_2_TWISTNOGEST"))
	else
		f5_arg0.buttonList.hintText:updateText(Engine.Localize("PLATFORM_BUTTON_CUSTOMIZER_INST_2_NOGEST"))
	end
end

local f0_local5 = function (f6_arg0, f6_arg1)
	f6_arg0.selectedButton = f6_arg1.button
	f0_local1(f6_arg0)
end

local f0_local6 = function (f7_arg0, f7_arg1)
	Engine.UnbindButton(f7_arg1.controller, f7_arg0.selectedButton.action.command)
	f0_local2(f7_arg0, f7_arg1)
end

local f0_local7 = function (f8_arg0, f8_arg1)
	Engine.UnbindGesture(f8_arg1.controller, f8_arg0.selectedButton.action.command)
	f0_local2(f8_arg0, f8_arg1)
end

CoD.WiiURemoteCustomize.Close = function (f9_arg0)
	Engine.SetDvar("wiiu_remoteCustomizeMenuOpen", 0)
	CoD.Options.Close(f9_arg0)
end

LUI.createMenu.WiiURemoteCustomize = function (f10_arg0)
	local f10_local0 = CoD.Wiiu.CreateOptionMenu(f10_arg0, "WiiURemoteCustomize", "MENU_CUSTOMIZE_CAPS")
	f10_local0.buttons = {}
	f10_local0.selectedButton = nil
	f10_local0:addSelectButton()
	f10_local0:addBackButton()
	f10_local0.close = CoD.WiiURemoteCustomize.Close
	local f10_local1 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = CoD.WiiURemoteCustomize.CommandTextTop,
		bottom = CoD.WiiURemoteCustomize.CommandTextBottom,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1,
		font = CoD.fonts.Condensed
	})
	f10_local1:setText(Engine.Localize("PLATFORM_COMMANDS_CAPS"))
	f10_local0:addElement(f10_local1)
	local f10_local2 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.WiiURemoteCustomize.ButtonLabelLeft,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = CoD.WiiURemoteCustomize.CommandTextTop,
		bottom = CoD.WiiURemoteCustomize.CommandTextBottom,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1,
		font = CoD.fonts.Condensed
	})
	f10_local2:setText(Engine.Localize("PLATFORM_BUTTON_CAPS"))
	f10_local0:addElement(f10_local2)
	local f10_local3 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.WiiURemoteCustomize.GestureLabelLeft,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = CoD.WiiURemoteCustomize.CommandTextTop,
		bottom = CoD.WiiURemoteCustomize.CommandTextBottom,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1,
		font = CoD.fonts.Condensed
	})
	f10_local3:setText(Engine.Localize("PLATFORM_GESTURE_CAPS"))
	f10_local0:addElement(f10_local3)
	f10_local0.buttonList:setLeftRight(true, false, 0, CoD.ButtonList.DefaultWidth - 20)
	f10_local0.buttonList:setTopBottom(true, true, CoD.WiiURemoteCustomize.ButtonListTop, 0)
	f0_local0(f10_local0, "attack")
	f0_local0(f10_local0, "ads")
	f0_local0(f10_local0, "melee_attack")
	f0_local0(f10_local0, "switch_weapon")
	f0_local0(f10_local0, "reload_weapon")
	f0_local0(f10_local0, "use_sprint_lock_camera")
	f0_local0(f10_local0, "throw_lethals")
	f0_local0(f10_local0, "throw_tacticals")
	f0_local0(f10_local0, "change_stance")
	f0_local0(f10_local0, "jump")
	f0_local0(f10_local0, "inventory")
	if CoD.isMultiplayer or CoD.isZombie then
		f0_local0(f10_local0, "scoreboard")
	end
	f10_local0.restoreDefaultsButton = CoD.ButtonPrompt.new("start", Engine.Localize("PLATFORM_RESTORE_DEFAULTS"), f10_local0, "restore_defaults")
	f10_local0:addRightButtonPrompt(f10_local0.restoreDefaultsButton)
	f10_local0.removeButtonButton = CoD.ButtonPrompt.new("left", Engine.Localize("PLATFORM_REMOVE_BUTTON"), f10_local0, "remove_button")
	f10_local0.removeButtonButton:setLeftRight(false, true, -136, 0)
	f10_local0.removeButtonButton:setTopBottom(false, true, -CoD.ButtonPrompt.Height * 2.5 * 3, 0)
	f10_local0.removeButtonButton:registerAnimationState("disabled", {
		alpha = 0
	})
	f10_local0.removeButtonButton:registerAnimationState("enabled", {
		alpha = 1
	})
	f10_local0:addElement(f10_local0.removeButtonButton)
	f10_local0.removeGestureButton = CoD.ButtonPrompt.new("alt2", Engine.Localize("PLATFORM_REMOVE_GESTURE"), f10_local0, "remove_gesture")
	f10_local0.removeGestureButton:setLeftRight(false, true, -136, 0)
	f10_local0.removeGestureButton:setTopBottom(false, true, -CoD.ButtonPrompt.Height * 2.5 * 2, 0)
	f10_local0.removeGestureButton:registerAnimationState("disabled", {
		alpha = 0
	})
	f10_local0.removeGestureButton:registerAnimationState("enabled", {
		alpha = 1
	})
	f10_local0:addElement(f10_local0.removeGestureButton)
	CoD.WiiUControllerSettings.SetAsRemoteOnlyMenu(f10_local0)
	f10_local0:registerEventHandler("restore_defaults", f0_local3)
	f10_local0:registerEventHandler("key_bind_started", f0_local4)
	f10_local0:registerEventHandler("refresh", f0_local2)
	f10_local0:registerEventHandler("key_bound", f0_local2)
	f10_local0:registerEventHandler("button_selected", f0_local5)
	f10_local0:registerEventHandler("remove_button", f0_local6)
	f10_local0:registerEventHandler("remove_gesture", f0_local7)
	f10_local0:processEvent({
		name = "refresh",
		controller = f10_arg0
	})
	f10_local0.buttons.attack:processEvent({
		name = "gain_focus"
	})
	Engine.SetDvar("wiiu_remoteCustomizeMenuOpen", 1)
	return f10_local0
end

