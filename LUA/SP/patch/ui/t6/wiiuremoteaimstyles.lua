CoD.WiiURemoteAimStyles = {}
local f0_local0 = function (f1_arg0)
	if UIExpression.ProfileInt(f1_arg0, "wiiu_scope_mouse_aim") == 0 and UIExpression.ProfileInt(f1_arg0, "wiiu_nunchuk_aiming_scope_enabled") == 0 and UIExpression.ProfileInt(f1_arg0, "wiiu_cod5styleScopeAiming") == 1 then
		return 1
	elseif UIExpression.ProfileInt(f1_arg0, "wiiu_scope_mouse_aim") == 0 and UIExpression.ProfileInt(f1_arg0, "wiiu_nunchuk_aiming_scope_enabled") == 0 and UIExpression.ProfileInt(f1_arg0, "wiiu_cod5styleScopeAiming") == 0 then
		return 2
	elseif UIExpression.ProfileInt(f1_arg0, "wiiu_scope_mouse_aim") == 0 and UIExpression.ProfileInt(f1_arg0, "wiiu_nunchuk_aiming_scope_enabled") == 1 then
		return 3
	elseif UIExpression.ProfileInt(f1_arg0, "wiiu_scope_mouse_aim") == 1 and UIExpression.ProfileInt(f1_arg0, "wiiu_nunchuk_aiming_scope_enabled") == 0 then
		return 4
	else
		return 1
	end
end

local f0_local1 = function (f2_arg0)
	if f2_arg0.value == 1 then
		Engine.SetProfileVar(f2_arg0.controller, "wiiu_scope_mouse_aim", 0)
		Engine.SetProfileVar(f2_arg0.controller, "wiiu_cod5styleScopeAiming", 1)
		Engine.SetProfileVar(f2_arg0.controller, "wiiu_nunchuk_aiming_scope_enabled", 0)
	elseif f2_arg0.value == 2 then
		Engine.SetProfileVar(f2_arg0.controller, "wiiu_scope_mouse_aim", 0)
		Engine.SetProfileVar(f2_arg0.controller, "wiiu_cod5styleScopeAiming", 0)
		Engine.SetProfileVar(f2_arg0.controller, "wiiu_nunchuk_aiming_scope_enabled", 0)
	elseif f2_arg0.value == 3 then
		Engine.SetProfileVar(f2_arg0.controller, "wiiu_scope_mouse_aim", 0)
		Engine.SetProfileVar(f2_arg0.controller, "wiiu_nunchuk_aiming_scope_enabled", 1)
	elseif f2_arg0.value == 4 then
		Engine.SetProfileVar(f2_arg0.controller, "wiiu_scope_mouse_aim", 1)
		Engine.SetProfileVar(f2_arg0.controller, "wiiu_nunchuk_aiming_scope_enabled", 0)
	end
	f2_arg0.parentButton.hintText = f2_arg0.hintText
	local f2_local0 = f2_arg0.parentButton:getParent()
	f2_local0.hintText:updateText(f2_arg0.parentButton.hintText)
end

local f0_local2 = function (f3_arg0)
	if UIExpression.ProfileInt(f3_arg0, "wiiu_turret_mouse_aim") == 1 and UIExpression.ProfileInt(f3_arg0, "wiiu_nunchuk_aiming_turret_enabled") == 0 then
		return 1
	elseif UIExpression.ProfileInt(f3_arg0, "wiiu_turret_mouse_aim") == 0 and UIExpression.ProfileInt(f3_arg0, "wiiu_nunchuk_aiming_turret_enabled") == 1 then
		return 2
	else
		return 1
	end
end

local f0_local3 = function (f4_arg0)
	if f4_arg0.value == 1 then
		Engine.SetProfileVar(f4_arg0.controller, "wiiu_turret_mouse_aim", 1)
		Engine.SetProfileVar(f4_arg0.controller, "wiiu_nunchuk_aiming_turret_enabled", 0)
	elseif f4_arg0.value == 2 then
		Engine.SetProfileVar(f4_arg0.controller, "wiiu_turret_mouse_aim", 0)
		Engine.SetProfileVar(f4_arg0.controller, "wiiu_nunchuk_aiming_turret_enabled", 1)
	end
	f4_arg0.parentButton.hintText = f4_arg0.hintText
	local f4_local0 = f4_arg0.parentButton:getParent()
	f4_local0.hintText:updateText(f4_arg0.parentButton.hintText)
end

LUI.createMenu.WiiURemoteAimStyles = function (f5_arg0)
	local f5_local0 = CoD.Wiiu.CreateOptionMenu(f5_arg0, "WiiURemoteAimStyles", "PLATFORM_AIM_STYLES_CAPS")
	f5_local0:addSelectButton()
	f5_local0:addBackButton()
	f5_local0.close = CoD.Options.Close
	f5_local0.scopeAimingButton = f5_local0.buttonList:addLeftRightSelector(Engine.Localize("PLATFORM_SCOPE_AIMING_CAPS"), f0_local0(f5_arg0))
	local f5_local1 = {}
	local f5_local2 = Engine.Localize("PLATFORM_POINTER_WAW_STYLE_CAPS")
	local f5_local3 = Engine.Localize("PLATFORM_POINTER_MWR_STYLE_CAPS")
	local f5_local4 = Engine.Localize("PLATFORM_CONTROL_STICK_CAPS")
	local f5_local5 = Engine.Localize("PLATFORM_PRECISION_CAPS")
	f5_local1 = f5_local2
	f5_local2 = {}
	f5_local3 = Engine.Localize("PLATFORM_POINTER_WAW_STYLE_DESC")
	f5_local4 = Engine.Localize("PLATFORM_POINTER_MWR_STYLE_DESC")
	f5_local5 = Engine.Localize("PLATFORM_CONTROL_STICK_DESC")
	local f5_local6 = Engine.Localize("PLATFORM_PRECISION_DESC")
	f5_local2 = f5_local3
	for f5_local3 = 1, #f5_local1, 1 do
		f5_local0.scopeAimingButton:addChoice(f5_local1[f5_local3], f0_local1, {
			value = f5_local3,
			controller = f5_arg0,
			parentButton = f5_local0.scopeAimingButton,
			hintText = f5_local2[f5_local3]
		})
	end
	f5_local0.floatingScopeOverlayButton = f5_local0.buttonList:addProfileLeftRightSelector(f5_arg0, Engine.Localize("PLATFORM_SCOPE_RETICLE_CAPS"), "wiiu_floating_scope_overlay", Engine.Localize("PLATFORM_SCOPE_RETICLE_DESC"))
	f5_local3 = f5_local0.floatingScopeOverlayButton
	f5_local4 = {}
	f5_local5 = Engine.Localize("PLATFORM_CENTERED_CAPS")
	f5_local6 = Engine.Localize("PLATFORM_FLOATING_CAPS")
	f5_local3.strings = f5_local5
	f5_local0.floatingScopeOverlayButton.values = {
		0,
		1
	}
	CoD.Options.Button_AddChoices(f5_local0.floatingScopeOverlayButton)
	f5_local0.lookspringButton = f5_local0.buttonList:addProfileLeftRightSelector(f5_arg0, Engine.Localize("PLATFORM_LOOKSPRING_CAPS"), "wiiu_aim_lookspring_enabled", Engine.Localize("PLATFORM_LOOKSPRING_DESC"))
	CoD.Options.Button_AddChoices_EnabledOrDisabled(f5_local0.lookspringButton)
	f5_local0.turretAimingButton = f5_local0.buttonList:addLeftRightSelector(Engine.Localize("PLATFORM_TURRET_AIMING_CAPS"), f0_local2(f5_arg0))
	f5_local3 = {}
	f5_local4 = Engine.Localize("PLATFORM_TURRET_AIM_STYLE_PRECISION_CAPS")
	f5_local5 = Engine.Localize("PLATFORM_TURRET_AIM_STYLE_CONTROL_STICK_CAPS")
	f5_local3 = f5_local4
	f5_local4 = {}
	f5_local5 = Engine.Localize("PLATFORM_TURRET_AIM_STYLE_PRECISION_DESC")
	f5_local6 = Engine.Localize("PLATFORM_TURRET_AIM_STYLE_CONTROL_STICK_DESC")
	f5_local4 = f5_local5
	for f5_local5 = 1, #f5_local3, 1 do
		f5_local0.turretAimingButton:addChoice(f5_local3[f5_local5], f0_local3, {
			value = f5_local5,
			controller = f5_arg0,
			parentButton = f5_local0.turretAimingButton,
			hintText = f5_local4[f5_local5]
		})
	end
	CoD.WiiUControllerSettings.SetAsRemoteOnlyMenu(f5_local0)
	f5_local0.scopeAimingButton:processEvent({
		name = "gain_focus"
	})
	return f5_local0
end

