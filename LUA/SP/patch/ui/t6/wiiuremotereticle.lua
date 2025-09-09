require("T6.ProfileDiscreteLeftRightSlider")
CoD.WiiURemoteReticle = {}
CoD.WiiURemoteReticle.PreviewPositionX = 638
CoD.WiiURemoteReticle.PreviewPositionY = 468
local f0_local0 = CoD.WiiURemoteReticle
local f0_local1 = {
	style = {
		name = "wiiu_reticleStyle",
		default = 0,
		min = 0,
		max = 6,
		label = Engine.Localize("PLATFORM_RETICLE_STYLE_CAPS"),
		hint = Engine.Localize("PLATFORM_RETICLE_STYLE_DESC")
	},
	sizeInner = {
		name = "wiiu_reticleCenterScale",
		default = 1.6,
		min = 0.4,
		max = 2.4,
		label = Engine.Localize("PLATFORM_RETICLE_SIZE_INNER_CAPS"),
		hint = Engine.Localize("PLATFORM_RETICLE_SIZE_INNER_DESC")
	},
	sizeOuter = {
		name = "wiiu_reticleOuterScale",
		default = 1.2,
		min = 0.4,
		max = 2.4,
		label = Engine.Localize("PLATFORM_RETICLE_SIZE_OUTER_CAPS"),
		hint = Engine.Localize("PLATFORM_RETICLE_SIZE_OUTER_DESC")
	}
}
local f0_local2 = {
	name = "wiiu_reticleInnerColorSelect",
	default = 1,
	min = 0,
	max = 9,
	label = Engine.Localize("PLATFORM_RETICLE_INNER_COLOR_CAPS"),
	hint = Engine.Localize("PLATFORM_RETICLE_INNER_COLOR_DESC")
}
local f0_local3 = {}
local f0_local4 = Engine.Localize("PLATFORM_CYAN_CAPS")
local f0_local5 = Engine.Localize("PLATFORM_ORANGE_CAPS")
local f0_local6 = Engine.Localize("PLATFORM_WHITE_CAPS")
local f0_local7 = Engine.Localize("PLATFORM_AMBER_CAPS")
local f0_local8 = Engine.Localize("PLATFORM_VIOLET_CAPS")
local f0_local9 = Engine.Localize("PLATFORM_BLUE_CAPS")
local f0_local10 = Engine.Localize("PLATFORM_MAGENTA_CAPS")
local f0_local11 = Engine.Localize("PLATFORM_LIME_CAPS")
local f0_local12 = Engine.Localize("PLATFORM_GRAY_CAPS")
local f0_local13 = Engine.Localize("PLATFORM_RED_CAPS")
f0_local2.choices = f0_local4
f0_local1.innerColor = f0_local2
f0_local2 = {
	name = "wiiu_reticleOuterColorSelect",
	default = 0,
	min = 0,
	max = 9,
	label = Engine.Localize("PLATFORM_RETICLE_OUTER_COLOR_CAPS"),
	hint = Engine.Localize("PLATFORM_RETICLE_OUTER_COLOR_DESC")
}
f0_local3 = {}
f0_local4 = Engine.Localize("PLATFORM_WHITE_CAPS")
f0_local5 = Engine.Localize("PLATFORM_AMBER_CAPS")
f0_local6 = Engine.Localize("PLATFORM_ORANGE_CAPS")
f0_local7 = Engine.Localize("PLATFORM_CYAN_CAPS")
f0_local8 = Engine.Localize("PLATFORM_VIOLET_CAPS")
f0_local9 = Engine.Localize("PLATFORM_BLUE_CAPS")
f0_local10 = Engine.Localize("PLATFORM_RED_CAPS")
f0_local11 = Engine.Localize("PLATFORM_GREEN_CAPS")
f0_local12 = Engine.Localize("PLATFORM_GRAY_CAPS")
f0_local13 = Engine.Localize("PLATFORM_BLACK_CAPS")
f0_local2.choices = f0_local4
f0_local1.outerColor = f0_local2
f0_local1.bold = {
	name = "wiiu_reticleBold",
	default = 1,
	label = Engine.Localize("PLATFORM_RETICLE_BOLD_CAPS"),
	hint = Engine.Localize("PLATFORM_RETICLE_BOLD_DESC")
}
f0_local0.ProfileVarInfo = f0_local1
f0_local0 = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.WiiURemoteReticle.ProfileVarInfo[f1_arg1]
	local f1_local1 = f1_arg0.buttonList:addProfileLeftRightSelector(f1_arg0.controller, f1_local0.label, f1_local0.name, f1_local0.hint)
	for f1_local2 = f1_local0.min, f1_local0.max, 1 do
		local f1_local5 = tostring(f1_local2 + 1)
		if f1_local0.choices ~= nil then
			f1_local5 = f1_local0.choices[f1_local2 + 1]
		end
		f1_local1:addChoice(f1_local5, f1_local2)
	end
	return f1_local1
end

f0_local1 = function (f2_arg0, f2_arg1)
	local f2_local0 = CoD.WiiURemoteReticle.ProfileVarInfo[f2_arg1]
	return f2_arg0.buttonList:addProfileDiscreteLeftRightSlider(f2_arg0.controller, f2_local0.label, f2_local0.name, f2_local0.min, f2_local0.max, f2_local0.hint)
end

f0_local2 = function (f3_arg0, f3_arg1)
	local f3_local0 = CoD.WiiURemoteReticle.ProfileVarInfo[f3_arg1]
	local f3_local1 = f3_arg0.buttonList:addProfileLeftRightSelector(f3_arg0.controller, f3_local0.label, f3_local0.name, f3_local0.hint)
	CoD.Options.Button_AddChoices_EnabledOrDisabled(f3_local1)
	return f3_local1
end

f0_local3 = function (f4_arg0, f4_arg1)
	local f4_local0 = CoD.WiiURemoteReticle.ProfileVarInfo[f4_arg1]
	Engine.SetProfileVar(f4_arg0.controller, f4_local0.name, math.random(f4_local0.min, f4_local0.max))
end

f0_local4 = function (f5_arg0, f5_arg1)
	local f5_local0 = CoD.WiiURemoteReticle.ProfileVarInfo[f5_arg1]
	Engine.SetProfileVar(f5_arg0.controller, f5_local0.name, LUI.clamp(f5_local0.min + math.random() * (f5_local0.max - f5_local0.min), f5_local0.min, f5_local0.max))
end

f0_local5 = function (f6_arg0, f6_arg1)
	Engine.SetProfileVar(f6_arg0.controller, CoD.WiiURemoteReticle.ProfileVarInfo[f6_arg1].name, math.random(0, 1))
end

f0_local6 = function (f7_arg0, f7_arg1)
	local f7_local0 = CoD.WiiURemoteReticle.ProfileVarInfo[f7_arg1]
	Engine.SetProfileVar(f7_arg0.controller, f7_local0.name, f7_local0.default)
end

f0_local7 = function (f8_arg0)
	f8_arg0.styleButton:refreshChoice()
	f8_arg0.sizeInnerButton:refreshValue()
	f8_arg0.sizeOuterButton:refreshValue()
	f8_arg0.innerColorButton:refreshChoice()
	f8_arg0.outerColorButton:refreshChoice()
	f8_arg0.boldButton:refreshChoice()
end

f0_local8 = function (f9_arg0, f9_arg1)
	if f9_arg0.controller == f9_arg1.controller and UIExpression.GetControllerType(f9_arg1.controller) ~= "remote" then
		f9_arg0:setPreviousMenu("OptionsMenu")
		f9_arg0:goBack(f9_arg1.controller)
	end
end

f0_local9 = function (f10_arg0, f10_arg1)
	f10_arg0:dispatchEventToParent({
		name = "randomize",
		controller = f10_arg1.controller
	})
end

f0_local10 = function (f11_arg0, f11_arg1)
	f0_local3(f11_arg0, "style")
	f0_local4(f11_arg0, "sizeInner")
	f0_local4(f11_arg0, "sizeOuter")
	f0_local3(f11_arg0, "innerColor")
	f0_local3(f11_arg0, "outerColor")
	f0_local5(f11_arg0, "bold")
	f0_local7(f11_arg0)
end

f0_local11 = function (f12_arg0, f12_arg1)
	f12_arg0:dispatchEventToParent({
		name = "restore_defaults",
		controller = f12_arg1.controller
	})
end

f0_local12 = function (f13_arg0, f13_arg1)
	f0_local6(f13_arg0, "style")
	f0_local6(f13_arg0, "sizeInner")
	f0_local6(f13_arg0, "sizeOuter")
	f0_local6(f13_arg0, "innerColor")
	f0_local6(f13_arg0, "outerColor")
	f0_local6(f13_arg0, "bold")
	f0_local7(f13_arg0)
end

LUI.createMenu.WiiURemoteReticle = function (f14_arg0)
	local f14_local0 = CoD.Wiiu.CreateOptionMenu(f14_arg0, "WiiURemoteReticle", "PLATFORM_RETICLE_OPTIONS_CAPS")
	f14_local0:addSelectButton()
	f14_local0:addBackButton()
	f14_local0.styleButton = f0_local0(f14_local0, "style")
	f14_local0.sizeInnerButton = f0_local1(f14_local0, "sizeInner")
	f14_local0.sizeOuterButton = f0_local1(f14_local0, "sizeOuter")
	f14_local0.innerColorButton = f0_local0(f14_local0, "innerColor")
	f14_local0.outerColorButton = f0_local0(f14_local0, "outerColor")
	f14_local0.boldButton = f0_local2(f14_local0, "bold")
	f14_local0.randomizeButton = f14_local0.buttonList:addButton(Engine.Localize("PLATFORM_RETICLE_RANDOMIZE_CAPS"), Engine.Localize("PLATFORM_RETICLE_RANDOMIZE_DESC"))
	f14_local0.randomizeButton:registerEventHandler("button_action", f0_local9)
	f14_local0.restoreDefaultsButton = f14_local0.buttonList:addButton(Engine.Localize("PLATFORM_RESTORE_DEFAULTS_CAPS"), Engine.Localize("PLATFORM_RETICLE_RESTORE_DEFAULTS_DESC"))
	f14_local0.restoreDefaultsButton:registerEventHandler("button_action", f0_local11)
	f14_local0.preview = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.WiiURemoteReticle.PreviewPositionX,
		right = CoD.WiiURemoteReticle.PreviewPositionX,
		topAnchor = true,
		bottomAnchor = false,
		top = CoD.WiiURemoteReticle.PreviewPositionY,
		bottom = CoD.WiiURemoteReticle.PreviewPositionY
	})
	f14_local0.preview:setupWiiUReticlePreview()
	f14_local0:addElement(f14_local0.preview)
	f14_local0:registerEventHandler("randomize", f0_local10)
	f14_local0:registerEventHandler("restore_defaults", f0_local12)
	f14_local0:registerEventHandler("controller_changed", f0_local8)
	f14_local0.styleButton:processEvent({
		name = "gain_focus"
	})
	return f14_local0
end

