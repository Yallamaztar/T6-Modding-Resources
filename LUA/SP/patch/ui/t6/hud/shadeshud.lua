require("T6.main")
require("T6.DataGloveMenu")
require("T6.MusicTrackInfo")
require("T6.LoadBlocks")
require("T6.PipContainer")
require("T6.ObjectiveText")
require("T6.VisorHud")
require("T6.HUD.OffhandIcons")
require("T6.FreeRoamMenu")
require("T6.StrikeForceMenu")
CoD.ShadesHud = {}
CoD.ShadesHud.DefaultAlpha = 1
CoD.ShadesHud.CompassAlpha = 0.5
CoD.ShadesHud.BlackoutAlpha = 0.5
CoD.ShadesHud.SwitchTimeDefault = 250
CoD.ShadesHud.SwitchTimeOn = 600
CoD.ShadesHud.SwitchTimeOff = 200
CoD.ShadesHud.GrenadesBarWidth = 300
CoD.ShadesHud.new = function (f1_arg0)
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 0
	})
	Widget.id = Widget.id .. ".ShadesHudMain"
	Widget.controller = f1_arg0
	Widget.background = LUI.UIImage.new()
	Widget.background:setLeftRight(true, true, 0, 0)
	Widget.background:setTopBottom(true, true, 0, 0)
	Widget.background:setRGB(0, 0, 0)
	Widget.background:setAlpha(0)
	Widget:addElement(Widget.background)
	Widget.shakeableArea = CoD.HUDShaker.new()
	Widget:addElement(Widget.shakeableArea)
	local f1_local1 = CoD.Menu.NewSafeAreaFromState("ShadesHud", f1_arg0)
	f1_local1.id = f1_local1.id .. ".ShadesHudSafeArea"
	Widget.shakeableArea:addElement(f1_local1)
	Widget.safeArea = f1_local1
	Widget:registerAnimationState("hide", {
		alpha = 0
	})
	Widget:registerAnimationState("show", {
		alpha = CoD.ShadesHud.DefaultAlpha
	})
	Widget:registerEventHandler("setup_hud", CoD.ShadesHud.SetupHud)
	Widget:registerEventHandler("setup_frontend", CoD.ShadesHud.SetupFrontend)
	Widget:registerEventHandler("hud_shades_bootup", CoD.ShadesHud.Bootup)
	Widget:registerEventHandler("bootup_switch_to_hud", CoD.ShadesHud.BootupSwitchToHUD)
	Widget:registerEventHandler("toggle_glasses", CoD.ShadesHud.ToggleGlasses)
	Widget:registerEventHandler("toggle_secret", CoD.ShadesHud.ToggleSecret)
	Widget:registerEventHandler("toggle_strikeforce", CoD.ShadesHud.ToggleStrikeforce)
	Widget:registerEventHandler("hide_freeroammenu", CoD.ShadesHud.HideFreeRoamMenu)
	Widget:registerEventHandler("start_credits", CoD.ShadesHud.StartCredits)
	Widget:registerEventHandler("stop_credits", CoD.ShadesHud.StopCredits)
	Widget:registerEventHandler("hide_objective_text", CoD.ShadesHud.HideObjectiveText)
	Widget:registerEventHandler("show_objective_text", CoD.ShadesHud.ShowObjectiveText)
	Widget:registerEventHandler("hud_hide_shadesHud", CoD.ShadesHud.HideShadesHud)
	Widget:registerEventHandler("hud_show_shadesHud", CoD.ShadesHud.ShowShadesHud)
	Widget:registerEventHandler("hud_perform_wipe", CoD.ShadesHud.ScriptPerformWipe)
	Widget:registerEventHandler("hud_f35_end", CoD.ShadesHud.HUDF35End)
	Widget:registerEventHandler("hud_shrink_ammo", CoD.ShadesHud.ShrinkAmmo)
	Widget:registerEventHandler("hud_expand_ammo", CoD.ShadesHud.ExpandAmmo)
	Widget:registerEventHandler("hud_fade_shadesHud", CoD.ShadesHud.FadeShadesHudAnim)
	Widget:registerEventHandler("hud_toggle_compass_vis", CoD.ShadesHud.ToggleCompassVisibility)
	Widget:registerEventHandler("require_hud_unhide", CoD.ShadesHud.RequireHUDUnhide)
	Widget:registerEventHandler("hud_pak_claw_controller", CoD.ShadesHud.AddClawHudControllerSystem)
	Widget:registerEventHandler("hud_pak_surveillance", CoD.ShadesHud.PakistanSurveillance)
	Widget:registerEventHandler("hud_update_refresh", CoD.ShadesHud.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.ShadesHud.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.ShadesHud.UpdateVisibility)
	Widget:registerEventHandler("hud_flicker", CoD.ShadesHud.Flicker)
	CoD.ShadesHud.InScriptedAnimation = false
	CoD.ShadesHud.IsFrontendLevel = Engine.IsMenuLevel()
	Widget.musicTrackInfo = CoD.MusicTrackInfo.new()
	Widget:addElement(Widget.musicTrackInfo)
	return Widget
end

CoD.ShadesHud.SetupFrontend = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.controller
	f2_arg0.main = LUI.createMenu.main(f2_local0)
	f2_arg0:addElement(f2_arg0.main)
	f2_arg0.main.visible = true
	f2_arg0.secret_visible = false
	if CoD.Menu.targetLandingMenu ~= "LockOutMenu" then
		f2_arg0:processEvent({
			name = "bootup_switch_to_hud",
			isFrontEnd = true,
			isAAR = true
		})
	end
	if true ~= CoD.Menu.freeRoam then
		Engine.LockInput(f2_local0, true)
	end
	Engine.SetUIActive(f2_local0, true)
end

CoD.ShadesHud.ToggleGlasses = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1.controller
	if CoD.Menu.CanHideHud ~= true then
		return 
	end
	Engine.Exec(f3_local0, "clearKeyStates")
	if f3_arg0.main.visible ~= true then
		if UIExpression.IsInGame() == 0 and f3_arg0.background then
			local f3_local1 = CoD.ShadesHud.SwitchTimeOn
			if f3_arg1.instant == true then
				f3_local1 = 0
			end
			f3_arg0.background:beginAnimation("show", f3_local1)
			f3_arg0.background:setAlpha(CoD.ShadesHud.BlackoutAlpha)
			CoD.ShadesHud.PerformWipe(f3_arg0, 0, f3_local1, true, f3_local0)
		else
			local f3_local1 = CoD.ShadesHud.SwitchTimeDefault
			if f3_arg1.instant == true then
				f3_local1 = 0
			end
			f3_arg0.main:animateToState("show", f3_local1)
			f3_arg0:dispatchEventToParent({
				name = "animate",
				animationStateName = "show_tempBg",
				duration = f3_local1
			})
			f3_arg0.main.visible = true
			Engine.LockInput(f3_local0, true)
			f3_arg0:dispatchEventToParent({
				name = "change_input_enabled",
				isEnabled = true
			})
			Engine.SetUIActive(f3_local0, true)
		end
	elseif f3_arg0.main.visible == true then
		local f3_local1 = CoD.ShadesHud.SwitchTimeDefault
		if f3_arg1.instant == true then
			f3_local1 = 0
		elseif UIExpression.IsInGame() == 0 then
			f3_local1 = CoD.ShadesHud.SwitchTimeOff
		end
		f3_arg0.main:animateToState("hide", f3_local1)
		f3_arg0:dispatchEventToParent({
			name = "animate",
			animationStateName = "hide_tempBg",
			duration = f3_local1
		})
		f3_arg0.main.visible = nil
		Engine.LockInput(f3_local0, false)
		f3_arg0:dispatchEventToParent({
			name = "change_input_enabled",
			isEnabled = false
		})
		Engine.SetUIActive(f3_local0, false)
		Engine.BlurWorld(f3_local0, 0)
		if UIExpression.IsInGame() == 0 and f3_arg0.background then
			f3_arg0.background:beginAnimation("hide", f3_local1)
			f3_arg0.background:setAlpha(0)
		end
	end
end

CoD.ShadesHud.HideShadesHud = function (f4_arg0, f4_arg1)
	local f4_local0 = 0
	if f4_arg1.data then
		f4_local0 = f4_arg1.data[1]
	end
	f4_arg0:beginAnimation("hide", f4_local0)
	f4_arg0:setAlpha(0)
end

CoD.ShadesHud.ShowShadesHud = function (f5_arg0, f5_arg1)
	local f5_local0 = 0
	if f5_arg1.data then
		f5_local0 = f5_arg1.data[1]
	end
	f5_arg0:beginAnimation("show", f5_local0)
	f5_arg0:setAlpha(CoD.ShadesHud.DefaultAlpha)
end

CoD.ShadesHud.ScriptPerformWipe = function (f6_arg0, f6_arg1)
	CoD.ShadesHud.PerformWipe(f6_arg0, 0, f6_arg1.data[1])
end

CoD.ShadesHud.PerformWipe = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)
	if f7_arg1 == nil then
		f7_arg1 = 0
	end
	local f7_local0 = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -640,
		right = 640,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		material = RegisterMaterial("visor_hexagon"),
		red = 0.04,
		green = 0.12,
		blue = 0.12,
		shaderVector0 = {
			-0.5,
			-0.5,
			0,
			0
		}
	})
	f7_arg0.shakeableArea:addElement(f7_local0)
	f7_local0:registerAnimationState("down", {
		shaderVector0 = {
			1.5,
			1.5,
			0,
			0
		}
	})
	f7_local0:registerAnimationState("down_reset", {
		shaderVector0 = {
			1.5,
			1.5,
			-1,
			0
		}
	})
	f7_local0:registerAnimationState("up", {
		shaderVector0 = {
			-0.5,
			-0.5,
			-0.5,
			0
		}
	})
	f7_local0:registerEventHandler("transition_complete_up", f7_local0.close)
	local f7_local1 = CoD.VisorImage.new("visor_retina_scan_laser", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = -512,
		bottom = 0
	})
	f7_local1:registerAnimationState("scan", {
		topAnchor = false,
		bottomAnchor = true,
		top = 0,
		bottom = 512
	})
	f7_local1:registerEventHandler("transition_complete_scan", f7_local1.close)
	f7_arg0.shakeableArea:addElement(f7_local1)
	f7_arg0:addElement(LUI.UITimer.new(f7_arg1, {
		name = "animate",
		animationStateName = "scan",
		duration = f7_arg2 * 3 / 4
	}, true, f7_local1))
	f7_arg0:addElement(LUI.UITimer.new(f7_arg1, {
		name = "animate",
		animationStateName = "down",
		duration = f7_arg2,
		easeIn = true,
		easeOut = true
	}, true, f7_local0))
	f7_arg0:addElement(LUI.UITimer.new(f7_arg1 + f7_arg2, {
		name = "animate",
		animationStateName = "down_reset",
		duration = 0,
		easeIn = true,
		easeOut = true
	}, true, f7_local0))
	f7_arg0:addElement(LUI.UITimer.new(f7_arg1 + f7_arg2, {
		name = "animate",
		animationStateName = "up",
		duration = f7_arg2,
		easeIn = true,
		easeOut = true
	}, true, f7_local0))
	if f7_arg3 then
		f7_arg0:addElement(LUI.UITimer.new(f7_arg1 + f7_arg2 / 2, {
			name = "require_hud_unhide",
			controller = f7_arg4
		}, true, f7_arg0))
	end
end

CoD.ShadesHud.RequireHUDUnhide = function (f8_arg0, f8_arg1)
	f8_arg0.main:animateToState("show", CoD.ShadesHud.SwitchTime)
	f8_arg0:dispatchEventToParent({
		name = "animate",
		animationStateName = "show_tempBg",
		duration = CoD.ShadesHud.SwitchTime
	})
	f8_arg0.main.visible = true
	Engine.LockInput(f8_arg1.controller, true)
	f8_arg0:dispatchEventToParent({
		name = "change_input_enabled",
		isEnabled = true
	})
	Engine.SetUIActive(f8_arg1.controller, true)
end

CoD.ShadesHud.HideFreeRoamMenu = function (f9_arg0, f9_arg1)

end

CoD.ShadesHud.ToggleStrikeforce = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg1.controller
	if f10_arg0.strikeforce_visible ~= true then
		f10_arg0.strikeforce_visible = true
		f10_arg0.strikeForce_menu = LUI.createMenu.StrikeForceMenu(f10_local0, f10_arg1.data[1])
		f10_arg0:addElement(f10_arg0.strikeForce_menu)
		f10_arg0.main.m_inputDisabled = true
		Engine.LockInput(f10_local0, true)
		f10_arg0:dispatchEventToParent({
			name = "change_input_enabled",
			isEnabled = true
		})
		Engine.SetUIActive(f10_local0, true)
	else
		f10_arg0.strikeforce_visible = nil
		f10_arg0.strikeForce_menu:close()
		f10_arg0.strikeForce_menu = nil
		f10_arg0.main.m_inputDisabled = false
		Engine.LockInput(f10_local0, false)
		f10_arg0:dispatchEventToParent({
			name = "change_input_enabled",
			isEnabled = false
		})
		Engine.SetUIActive(f10_local0, false)
	end
end

CoD.ShadesHud.ToggleSecret = function (f11_arg0, f11_arg1)
	local f11_local0 = f11_arg1.controller
	if CoD.Menu.CanHideHud ~= true then
		return 
	elseif f11_arg0.secret_visible ~= true then
		f11_arg0.secret = LUI.createMenu.DataGloveMenu(f11_local0)
		f11_arg0:addElement(f11_arg0.secret)
		f11_arg0.secret_visible = true
		f11_arg0.main.m_inputDisabled = true
		f11_arg0.main.visible = false
		Engine.LockInput(f11_local0, true)
		f11_arg0:dispatchEventToParent({
			name = "change_input_enabled",
			isEnabled = true
		})
		Engine.SetUIActive(f11_local0, true)
	else
		f11_arg0.secret = nil
		f11_arg0.secret_visible = nil
		f11_arg0.main.m_inputDisabled = false
		Engine.LockInput(f11_local0, false)
		f11_arg0:dispatchEventToParent({
			name = "change_input_enabled",
			isEnabled = false
		})
		Engine.SetUIActive(f11_local0, false)
		Engine.BlurWorld(f11_local0, 0)
	end
end

CoD.ShadesHud.StartCredits = function (f12_arg0, f12_arg1)
	local f12_local0 = f12_arg1.controller
	if f12_arg0.credits == nil then
		f12_arg0.credits = LUI.UIElement.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true
		})
		f12_arg0:addElement(f12_arg0.credits)
	end
	f12_arg0.credits:setupCredit()
end

CoD.ShadesHud.StopCredits = function (f13_arg0, f13_arg1)
	local f13_local0 = f13_arg1.controller
	if f13_arg0.credits ~= nil then
		f13_arg0.credits:close()
		f13_arg0.credits = nil
	end
end

CoD.ShadesHud.HideObjectiveText = function (f14_arg0, f14_arg1)
	if f14_arg0.objText then
		f14_arg0.objText:beginAnimation("fade_out")
		f14_arg0.objText:setAlpha(0)
	end
end

CoD.ShadesHud.ShowObjectiveText = function (f15_arg0, f15_arg1)
	if f15_arg0.objText then
		f15_arg0.objText:beginAnimation("fade_in", f15_arg1.duration)
		f15_arg0.objText:setAlpha(CoD.ObjectiveText.DefaultAlpha)
	end
end

CoD.ShadesHud.SetupHud = function (f16_arg0, f16_arg1)
	local f16_local0 = f16_arg1.controller
	local f16_local1 = f16_arg1.mapname
	if f16_local1 == nil then
		f16_local1 = ""
	end
	local f16_local2 = UIExpression.TableLookup(nil, "sp/levelLookup.csv", 1, f16_local1, 3)
	f16_arg0.futureHud = false
	if f16_local2 ~= "nineteeneighties" then
		f16_arg0.futureHud = true
		f16_arg0.visorHud = CoD.VisorHud.new()
		f16_arg0.shakeableArea:addElement(f16_arg0.visorHud)
		f16_arg0.leftBracket = CoD.VisorLeftBracket.new()
		f16_arg0.safeArea:addElement(f16_arg0.leftBracket)
		f16_arg0.rightBracket = CoD.VisorRightBracket.new()
		f16_arg0.safeArea:addElement(f16_arg0.rightBracket)
		f16_arg0.visorTimer = CoD.VisorTimer.new()
		f16_arg0.safeArea:addElement(f16_arg0.visorTimer)
		f16_arg0.visorText = CoD.VisorTypewriter.new()
		f16_arg0.safeArea:addElement(f16_arg0.visorText)
		if not Engine.GameModeIsMode(CoD.GAMEMODE_RTS) then
			if f16_arg0.rtsHud then
				f16_arg0.rtsHud:close()
				f16_arg0.rtsHud = nil
			end
			f16_arg0.diamonds = CoD.LoadBlocks.new(f16_local0)
			f16_arg0.safeArea:addElement(f16_arg0.diamonds)
			local f16_local3 = 0.65
			local f16_local4 = -10
			local Widget = LUI.UIElement.new({
				left = -234 * f16_local3,
				top = f16_local4 - 64,
				right = 234 * f16_local3,
				bottom = f16_local4,
				leftAnchor = false,
				topAnchor = false,
				rightAnchor = false,
				bottomAnchor = true,
				red = 1,
				green = 1,
				blue = 1,
				alpha = CoD.ShadesHud.CompassAlpha,
				material = RegisterMaterial("hud_horizontal_compass"),
				shaderVector0 = {
					f16_local3,
					-0.5,
					0,
					0
				}
			})
			Widget:setupHorizontalCompass()
			f16_arg0.shakeableArea:addElement(Widget)
			Widget:registerAnimationState("hide", {
				alpha = 0
			})
			Widget:registerAnimationState("show", {
				alpha = CoD.ShadesHud.CompassAlpha
			})
			f16_arg0.compass = Widget
		else
			f16_arg0.rtsButtonPrompts = CoD.RTS.AddButtonPrompts()
			f16_arg0.safeArea:addElement(f16_arg0.rtsButtonPrompts)
			f16_arg0.rtsMiniMap = CoD.RTSMiniMap.new()
			f16_arg0.safeArea:addElement(f16_arg0.rtsMiniMap)
		end
		f16_arg0.objText = CoD.ObjectiveText.new()
		f16_arg0.safeArea:addElement(f16_arg0.objText)
		f16_arg0.weaponLabel = CoD.WeaponLabel.new(f16_local0)
		f16_arg0.safeArea:addElement(f16_arg0.weaponLabel)
		f16_arg0.ammoCounter = CoD.AmmoCounter.new(f16_local0)
		f16_arg0.safeArea:addElement(f16_arg0.ammoCounter)
		local f16_local3 = 0
		local f16_local4 = 20
		f16_arg0.grenadesBar = LUI.UIHorizontalList.new()
		f16_arg0.grenadesBar.futureRight = -74
		f16_arg0.grenadesBar.eightiesRight = -62
		f16_arg0.grenadesBar:setAlignment(LUI.Alignment.Right)
		f16_arg0.grenadesBar:setTopBottom(false, true, f16_local3 - CoD.OffhandIcons.BracketHeight, f16_local3)
		f16_arg0.grenadesBar:setLeftRight(false, true, -CoD.ShadesHud.GrenadesBarWidth, f16_arg0.grenadesBar.futureRight)
		f16_arg0.safeArea:addElement(f16_arg0.grenadesBar)
		f16_arg0.grenadesBar:registerEventHandler("update_style", CoD.ShadesHud.GrenadesBarStyleUpdate)
		f16_arg0.lethals = CoD.OffhandIcons.new("lethal")
		f16_arg0.grenadesBar:addElement(f16_arg0.lethals)
		f16_arg0.grenadesBar:addSpacer(f16_local4)
		f16_arg0.tacticals = CoD.OffhandIcons.new("tactical")
		f16_arg0.grenadesBar:addElement(f16_arg0.tacticals)
		f16_arg0.grenadesBar:addSpacer(f16_local4)
		f16_arg0.altfire = CoD.OffhandIcons.new("altfire")
		f16_arg0.grenadesBar:addElement(f16_arg0.altfire)
	end
	if f16_local1 ~= "frontend" then
		f16_arg0:addElement(LUI.UITimer.new(100, {
			name = "bootup_switch_to_hud",
			isFrontEnd = false,
			isAAR = false
		}, true, f16_arg0))
	end
	if f16_local1 == "so_cmp_afghanistan" then
		f16_arg0.afghanOverlay = CoD.AfghanistanOverlay.new()
		f16_arg0.safeArea:addElement(f16_arg0.afghanOverlay)
	end
end

CoD.ShadesHud.GrenadesBarStyleUpdate = function (f17_arg0, f17_arg1)
	local f17_local0 = f17_arg1.style
	if f17_local0 == nil then
		f17_local0 = "twenties"
		f17_arg1.style = f17_local0
	end
	if f17_local0 == "eighties" then
		f17_arg0:setLeftRight(false, true, -CoD.ShadesHud.GrenadesBarWidth, f17_arg0.eightiesRight)
	else
		f17_arg0:setLeftRight(false, true, -CoD.ShadesHud.GrenadesBarWidth, f17_arg0.futureRight)
	end
	f17_arg0:dispatchEventToChildren(f17_arg1)
end

CoD.ShadesHud.BootupSwitchToHUD = function (f18_arg0, f18_arg1)
	f18_arg0.controller = UIExpression.GetPrimaryController()
	f18_arg0:dispatchEventToChildren({
		name = "bootup_switch_to_hud",
		isFrontEnd = f18_arg1.isFrontEnd,
		isAAR = f18_arg1.isAAR
	})
	Engine.ForceHUDRefresh()
	if f18_arg1.isFrontEnd and UIExpression.IsInGame() == 0 and f18_arg0.background then
		f18_arg0.background:beginAnimation("show", CoD.ShadesHud.SwitchTime)
		f18_arg0.background:setAlpha(CoD.ShadesHud.BlackoutAlpha)
	end
	if f18_arg1.isFrontEnd and not f18_arg1.isAAR then
		f18_arg0.main:processEvent({
			name = "open_main_menu",
			controller = f18_arg0.controller
		})
	end
	CoD.ShadesHud.bootupComplete = true
	CoD.Menu.CanHideHud = true
	if CoD.Menu.freeRoam then
		f18_arg0:processEvent({
			name = "toggle_glasses",
			instant = true
		})
	end
end

CoD.ShadesHud.Bootup = function (f19_arg0, f19_arg1)
	Engine.PlaySound("uin_main_bootup")
	f19_arg1.isFrontEnd = CoD.ShadesHud.IsFrontendLevel
	local f19_local0 = CoD.TypewriterText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 100,
		right = 1280,
		topAnchor = false,
		bottomAnchor = false,
		top = -256,
		bottom = -256 + CoD.textSize.ExtraSmall * 0.75,
		alignment = LUI.Alignment.Left,
		red = 0.75,
		green = 1,
		blue = 0.75,
		alpha = 0.25,
		font = CoD.fonts.ExtraSmall
	})
	f19_arg0.safeArea:addElement(f19_local0)
	f19_local0:registerAnimationState("hide", {
		alpha = 0
	})
	f19_local0:registerEventHandler("transition_complete_hide", f19_local0.close)
	local f19_local1 = CoD.TypewriterText.new({
		leftAnchor = false,
		rightAnchor = true,
		left = -200,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -256,
		bottom = -256 + CoD.textSize.ExtraSmall * 0.75,
		alignment = LUI.Alignment.Left,
		red = 0.75,
		green = 1,
		blue = 0.75,
		alpha = 0.25,
		font = CoD.fonts.ExtraSmall
	})
	f19_arg0.safeArea:addElement(f19_local1)
	f19_local1:registerAnimationState("hide", {
		alpha = 0
	})
	f19_local1:registerEventHandler("transition_complete_hide", f19_local1.close)
	f19_arg0.objText:setNewTextObj(Engine.Localize("MENU_NEW_USER_DETECTED_CAPS"), LUI.Alignment.Center)
	f19_arg0.leftBracket:processEvent({
		name = "bootup_expand"
	})
	f19_arg0.rightBracket:processEvent({
		name = "bootup_expand"
	})
	local f19_local2 = CoD.VisorLeftBracket.ExpandDuration
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, "bootup_half_left", true, f19_arg0.leftBracket))
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, "bootup_half_right", true, f19_arg0.rightBracket))
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, "bootup_start", true, f19_arg0.objText))
	f19_local2 = f19_local2 + CoD.VisorLeftBracket.MoveDuration + 250
	CoD.ShadesHud.PerformWipe(f19_arg0, f19_local2, 2000)
	f19_local2 = f19_local2 + 500
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, {
		name = "typewrite",
		text = Engine.Localize("MENU_VISOR_UPPER_LEFT_TYPEWRITER"),
		duration = 1750
	}, true, f19_local0))
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, {
		name = "typewrite",
		text = Engine.Localize("MENU_VISOR_UPPER_RIGHT_TYPEWRITER"),
		duration = 1500
	}, true, f19_local1))
	local f19_local3 = f19_local2
	f19_local2 = f19_local2 + CoD.VisorDataBoxes.BootupAppearDuration / 2
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, "bootup_welcome", true, f19_arg0.objText))
	f19_local2 = f19_local2 + CoD.VisorDataBoxes.BootupAppearDuration / 2
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, {
		name = "animate",
		animationStateName = "hide",
		duration = 250
	}, true, f19_local1))
	f19_local2 = f19_local2 + CoD.AmmoCounter.BootupTestDuration
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, "bootup_left", true, f19_arg0.leftBracket))
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, "bootup_right", true, f19_arg0.rightBracket))
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, "clear_objective", true, f19_arg0.objText))
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, {
		name = "animate",
		animationStateName = "hide",
		duration = 250
	}, true, f19_local0))
	f19_local2 = f19_local2 + 250
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, "bootup_lower_left", true, f19_arg0.objText))
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, "bootup_end", true, f19_arg0.visorHud))
	if f19_arg1.isFrontEnd ~= true then
		f19_arg0:addElement(LUI.UITimer.new(f19_local2, "bootup_expand", true, f19_arg0.ammoCounter))
		f19_arg0:addElement(LUI.UITimer.new(f19_local2, "bootup_expand", true, f19_arg0.tacticals))
		f19_arg0:addElement(LUI.UITimer.new(f19_local2, "bootup_expand", true, f19_arg0.lethals))
	end
	f19_arg0:addElement(LUI.UITimer.new(f19_local2, "bootup_fade_in", true, f19_arg0.weaponLabel))
	f19_arg0:addElement(LUI.UITimer.new(f19_local2 + CoD.AmmoCounter.BootupExpandDuration, {
		name = "bootup_switch_to_hud",
		isFrontEnd = f19_arg1.isFrontEnd,
		isAAR = f19_arg1.isAAR
	}, true, f19_arg0))
	f19_arg0:addElement(LUI.UITimer.new(f19_local3, "bootup_appear", true, f19_arg0.ammoCounter))
	f19_arg0:addElement(LUI.UITimer.new(f19_local3, "bootup_appear", true, f19_arg0.lethals))
	f19_arg0:addElement(LUI.UITimer.new(f19_local3, "bootup_appear", true, f19_arg0.tacticals))
	f19_arg0:addElement(LUI.UITimer.new(f19_local3, "bootup_expand", true, f19_arg0.ammoCounter))
	f19_local3 = f19_local3 + CoD.AmmoCounter.BootupExpandDuration
	f19_arg0:addElement(LUI.UITimer.new(f19_local3, "bootup_test_up", true, f19_arg0.ammoCounter))
	f19_arg0:addElement(LUI.UITimer.new(f19_local3, "bootup_expand", true, f19_arg0.tacticals))
	f19_arg0:addElement(LUI.UITimer.new(f19_local3 + CoD.AmmoCounter.BootupTestDuration, "bootup_test_down", true, f19_arg0.ammoCounter))
	f19_local3 = f19_local3 + CoD.OffhandIcons.BootupExpandDuration / 2
	f19_arg0:addElement(LUI.UITimer.new(f19_local3, "bootup_expand", true, f19_arg0.lethals))
	f19_local3 = f19_local3 + CoD.AmmoCounter.BootupExpandDuration / 2
	f19_arg0:addElement(LUI.UITimer.new(f19_local3, "bootup_shrink", true, f19_arg0.tacticals))
	f19_local3 = f19_local3 + CoD.AmmoCounter.BootupShrinkDuration / 2
	f19_arg0:addElement(LUI.UITimer.new(f19_local3, "bootup_shrink", true, f19_arg0.lethals))
	f19_local3 = f19_local3 + CoD.OffhandIcons.BootupShrinkDuration / 2
	f19_arg0:addElement(LUI.UITimer.new(f19_local3, "bootup_shrink", true, f19_arg0.ammoCounter))
	f19_arg0:addElement(LUI.UITimer.new(f19_local3, "bootup_dock", true, f19_arg0.tacticals))
end

CoD.ShadesHud.HUDF35End = function (f20_arg0, f20_arg1)
	local f20_local0 = LUI.UITightText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -200,
		bottom = -200 + CoD.textSize.Condensed,
		red = CoD.F35Hud.Red.r,
		green = CoD.F35Hud.Red.g,
		blue = CoD.F35Hud.Red.b,
		alpha = CoD.F35Hud.Red.a,
		font = CoD.fonts.Condensed
	})
	f20_arg0:addElement(f20_local0)
	f20_local0:setText(Engine.Localize("LA_2_LINK_LOST"))
	f20_local0:registerAnimationState("flash1", {
		alpha = 0
	})
	f20_local0:registerAnimationState("flash2", {
		alpha = CoD.F35Hud.Red.a
	})
	f20_local0:registerEventHandler("transition_complete_flash1", function (f29_arg0, f29_arg1)
		if not f29_arg1.interrupted then
			f29_arg0:animateToState("flash2", 500)
		end
	end)
	f20_local0:registerEventHandler("transition_complete_flash2", function (f30_arg0, f30_arg1)
		if not f30_arg1.interrupted then
			f30_arg0:animateToState("flash1", 500)
		end
	end)
	f20_local0:animateToState("flash1")
	f20_arg0:addElement(LUI.UITimer.new(5000, "close", true, f20_local0))
	f20_arg0:dispatchEventToChildren(f20_arg1)
end

CoD.ShadesHud.ShrinkAmmo = function (f21_arg0, f21_arg1)
	if f21_arg0.futureHud == false then
		return 
	end
	CoD.ShadesHud.InScriptedAnimation = true
	local f21_local0 = 250
	local f21_local1 = f21_arg0.ammoCounter
	CoD.AmmoCounter.AmmoText_HideAnim(f21_local1, f21_local0, true, true)
	f21_local1:addElement(LUI.UITimer.new(f21_local0, {
		name = "animate",
		animationStateName = "default",
		duration = f21_local0
	}, true, f21_local1))
	f21_local1:addElement(LUI.UITimer.new(f21_local0, {
		name = "animate",
		animationStateName = "default",
		duration = f21_local0
	}, true, f21_local1.hexBg))
	local f21_local2 = f21_arg0.tacticals
	local f21_local3 = f21_arg0.lethals
	if f21_local2.icons ~= nil then
		for f21_local4 = 1, #f21_local2.icons, 1 do
			f21_local2.icons[f21_local4]:animateToState("hide", f21_local0, true, true)
		end
	end
	if f21_local3.icons ~= nil then
		for f21_local4 = 1, #f21_local3.icons, 1 do
			f21_local3.icons[f21_local4]:animateToState("hide", f21_local0, true, true)
		end
	end
	f21_local2:addElement(LUI.UITimer.new(f21_local0, {
		name = "animate",
		animationStateName = "dock",
		duration = f21_local0
	}, true, f21_local2))
	f21_local3:addElement(LUI.UITimer.new(f21_local0, {
		name = "animate",
		animationStateName = "default",
		duration = f21_local0
	}, true, f21_local3))
	f21_arg0.altfire:addElement(LUI.UITimer.new(f21_local0, {
		name = "animate",
		animationStateName = "dock",
		duration = f21_local0
	}, true, f21_arg0.altfire))
end

CoD.ShadesHud.ExpandAmmo = function (f22_arg0, f22_arg1)
	if f22_arg0.futureHud == false then
		return 
	elseif not Engine.PlayerHasAnyWeapons(f22_arg1.controller) then
		return 
	elseif CoD.ShadesHud.IsFrontendLevel == true then
		return 
	end
	CoD.ShadesHud.InScriptedAnimation = false
	local f22_local0 = 250
	local f22_local1 = f22_arg0.ammoCounter
	f22_local1:processEvent({
		name = "showAmmo",
		controller = f22_arg1.controller,
		duration = f22_local0,
		easeIn = true,
		easeOut = true
	})
	f22_local1:animateToState("expand", f22_local0, true, true)
	local f22_local2 = f22_arg0.tacticals
	local f22_local3 = f22_arg0.lethals
	if f22_local2.icons ~= nil then
		for f22_local4 = 1, #f22_local2.icons, 1 do
			f22_local2:addElement(LUI.UITimer.new(f22_local0, {
				name = "animate",
				animationStateName = "show",
				duration = f22_local0
			}, true, f22_local2.icons[f22_local4]))
		end
	end
	if f22_local3.icons ~= nil then
		for f22_local4 = 1, #f22_local3.icons, 1 do
			f22_local3:addElement(LUI.UITimer.new(f22_local0, {
				name = "animate",
				animationStateName = "show",
				duration = f22_local0
			}, true, f22_local3.icons[f22_local4]))
		end
	end
	f22_local2:animateToState("expand", f22_local0, true, true)
	f22_local3:animateToState("expand", f22_local0, true, true)
	f22_arg0.altfire:animateToState("expand", f22_local0, true, true)
end

CoD.ShadesHud.AddClawHudControllerSystem = function (f23_arg0, f23_arg1)
	if f23_arg0 and not f23_arg0.clawController then
		f23_arg0.clawController = CoD.ClawHudController.new()
		f23_arg0:addElement(f23_arg0.clawController)
	end
end

CoD.ShadesHud.PakistanSurveillance = function (f24_arg0, f24_arg1)
	if f24_arg0 and not f24_arg0.surveillanceOverlay then
		f24_arg0.surveillanceOverlay = CoD.SurveillanceOverlay.new()
		f24_arg0:addElement(f24_arg0.surveillanceOverlay)
	end
end

CoD.ShadesHud.FadeShadesHudAnim = function (f25_arg0, f25_arg1)
	if f25_arg0.futureHud == false then
		return 
	end
	local f25_local0 = f25_arg1.duration or 0
	local f25_local1 = 0
	local f25_local2 = 0
	local f25_local3 = 0
	local f25_local4 = 0
	local f25_local5 = 0
	local f25_local6 = 0
	local f25_local7 = 0
	local f25_local8 = 0
	if f25_arg1.fadeAmount == 1 then
		f25_local1 = CoD.VisorLeftBracket.DefaultAlpha
		f25_local2 = CoD.VisorRightBracket.DefaultAlpha
		f25_local3 = CoD.ShadesHud.CompassAlpha
		f25_local4 = CoD.WeaponLabel.DefaultAlpha
		f25_local5 = CoD.AmmoCounter.DefaultAlpha
		f25_local6 = CoD.OffhandIcons.DefaultAlpha
		f25_local7 = CoD.OffhandIcons.DefaultAlpha
		f25_local8 = CoD.LoadBlocks.DefaultAlpha
	end
	f25_arg0.leftBracket:beginAnimation("fade", f25_local0)
	f25_arg0.leftBracket:setAlpha(f25_local1)
	f25_arg0.rightBracket:beginAnimation("fade", f25_local0)
	f25_arg0.rightBracket:setAlpha(f25_local2)
	if f25_arg0.compass then
		f25_arg0.compass:beginAnimation("fade", f25_local0)
		f25_arg0.compass:setAlpha(f25_local3)
	end
	f25_arg0.weaponLabel:beginAnimation("fade", f25_local0)
	f25_arg0.weaponLabel:setAlpha(f25_local4)
	f25_arg0.ammoCounter:beginAnimation("fade", f25_local0)
	f25_arg0.ammoCounter:setAlpha(f25_local5)
	f25_arg0.lethals:beginAnimation("fade", f25_local0)
	f25_arg0.lethals:setAlpha(f25_local6)
	f25_arg0.tacticals:beginAnimation("fade", f25_local0)
	f25_arg0.tacticals:setAlpha(f25_local7)
	f25_arg0.altfire:beginAnimation("fade", f25_local0)
	f25_arg0.altfire:setAlpha(f25_local7)
end

CoD.ShadesHud.ToggleCompassVisibility = function (f26_arg0, f26_arg1)
	local f26_local0 = f26_arg1.duration or 0
	local f26_local1 = 0
	if f26_arg1.shouldShow == 1 then
		f26_local1 = CoD.ShadesHud.CompassAlpha
	end
	if f26_arg0.futureHud == true and f26_arg0.compass then
		f26_arg0.compass:beginAnimation("fade", f26_local0)
		f26_arg0.compass:setAlpha(f26_local1)
	end
end

CoD.ShadesHud.UpdateVisibility = function (f27_arg0, f27_arg1)
	local f27_local0 = f27_arg1.controller
	if UIExpression.IsVisibilityBitSet(f27_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f27_local0, CoD.BIT_UI_ACTIVE) == 0 then
		if f27_arg0.visible ~= true then
			f27_arg0:setAlpha(CoD.ShadesHud.DefaultAlpha)
			f27_arg0.visible = true
		end
	elseif f27_arg0.visible == true then
		f27_arg0:setAlpha(0)
		f27_arg0.visible = nil
	end
	f27_arg0:dispatchEventToChildren(f27_arg1)
end

CoD.ShadesHud.Flicker = function (f28_arg0, f28_arg1)
	local f28_local0 = f28_arg1.data[1]
	if f28_local0 > 0 then
		f28_arg0:flicker(f28_local0, 1, 0, 1, 0, 400)
	else
		f28_arg0:processEvent({
			name = "close_flicker_timer"
		})
	end
end

