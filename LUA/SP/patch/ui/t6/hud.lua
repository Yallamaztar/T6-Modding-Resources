require("T6.CoDBase")
require("T6.Briefing")
require("T6.HUD.AfghanistanOverlay")
require("T6.HUD.AirVehicleHUD")
require("T6.HUD.AmmoCounter")
require("T6.HUD.ASDDroneHud")
require("T6.HUD.AR")
require("T6.HUD.CCTVHud")
require("T6.HUD.ChopperGunnerHUD")
require("T6.HUD.CICTurretHud")
require("T6.HUD.ClawHud")
require("T6.HUD.ClawHudController")
require("T6.HUD.Compass")
require("T6.HUD.EyeScanner")
require("T6.HUD.F35Hud")
require("T6.HUD.GogglesHud")
require("T6.HUD.HUDDigit")
require("T6.HUD.JetwingHud")
require("T6.HUD.SamTurretHud")
require("T6.HUD.SpiderbotHud")
require("T6.HUD.SurveillanceOverlay")
require("T6.HUD.QRDroneHud")
require("T6.HUD.RTS")
require("T6.HUD.RTSMiniMap")
require("T6.HUD.RTSVehicleHud")
require("T6.HUD.ShadesHud")
require("T6.HUD.TitleCard")
require("T6.HUD.WeaponLabel")
require("T6.HUD.WingsuitHud")
require("T6.HUD.ObjectiveInfoMenu")
require("T6.Menus.CACLoadOutMenu")
if CoD.isWIIU then
	require("T6.WiiUSystemServices")
	require("T6.LiveNotification")
end
CoD.HUD = {}
CoD.HUD.DPadOrder = {
	up = 1,
	down = 2,
	left = 3,
	right = 4
}
LUI.createMenu.HUD = function ()
	local f1_local0 = CoD.Menu.NewFromState("HUD", {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	if f1_local0.setUseGameTime then
		f1_local0:setUseGameTime(true)
	end
	if not LUI.roots.UIRootFull.safeAreaOverlay then
		LUI.roots.UIRootFull.safeAreaOverlay = CoD.SetupSafeAreaOverlay()
		LUI.roots.UIRootFull:addElement(LUI.roots.UIRootFull.safeAreaOverlay)
	end
	CoD.HUD.SetupEventHandlers(f1_local0)
	f1_local0:registerEventHandler("debug_reload", CoD.HUD.DebugReload)
	f1_local0.updateShadesFromVehicle = CoD.HUD.UpdateShadesFromVehicle
	return f1_local0
end

CoD.HUD.SetupEventHandlers = function (f2_arg0)
	f2_arg0:registerEventHandler("change_input_enabled", CoD.HUD.ChangeInputEnabled)
	f2_arg0:registerEventHandler("first_snapshot", CoD.HUD.FirstSnapshot)
	f2_arg0:registerEventHandler("frontend_player_connected", CoD.HUD.FrontendPlayerConnected)
	f2_arg0:registerEventHandler("hud_f35", CoD.HUD.HUDF35)
	f2_arg0:registerEventHandler("hud_update_vehicle", CoD.HUD.UpdateVehicle)
	f2_arg0:registerEventHandler("hud_update_vehicle_custom", CoD.HUD.UpdateVehicleCustom)
	f2_arg0:registerEventHandler("gamepad_button", CoD.HUD.GamepadButton)
	f2_arg0:registerEventHandler("open_ingame_menu", CoD.HUD.OpenInGameMenu)
	f2_arg0:registerEventHandler("open_ingame_modeless_menu", CoD.HUD.OpenInGameModelessMenu)
	f2_arg0:registerEventHandler("intro_complete", CoD.HUD.IntroCompleted)
	f2_arg0:registerEventHandler("show_skip_prompt", CoD.HUD.ShowSkipPrompt)
	f2_arg0:registerEventHandler("open_mission_objectives", CoD.HUD.OpenMissionObjectives)
	f2_arg0:registerEventHandler("close_mission_objectives", CoD.HUD.CloseMissionObjectives)
	f2_arg0:registerEventHandler("open_readingsavedevice", CoD.HUD.OpenReadingSaveDevcice)
	f2_arg0:registerEventHandler("flush_dynamic_hud", CoD.HUD.FlushDynamicHud)
	if CoD.isWIIU then
		f2_arg0:registerEventHandler("live_notification", CoD.LiveNotifications.NotifyMessage)
	end
end

CoD.HUD.ShowSkipPrompt = function (f3_arg0, f3_arg1)
	local f3_local0, f3_local1 = Engine.GetUserSafeArea()
	local f3_local2 = {}
	f3_local2 = GetTextDimensions(Engine.Localize("PLATFORM_SKIP"), CoD.fonts.Condensed, CoD.textSize.Condensed)
	local f3_local3 = 15
	local f3_local4 = 15
	f3_arg0.continueButton = LUI.UIButton.new()
	f3_arg0.continueButton:setLeftRight(false, false, -f3_local0, f3_local0 / 2 - f3_local3)
	f3_arg0.continueButton:setTopBottom(false, false, f3_local1 / 2 - CoD.textSize.Condensed - f3_local4, f3_local1 / 2 - f3_local4)
	f3_arg0.continueButton:setAlignment(LUI.Alignment.Right)
	f3_arg0.continueButton:setAlpha(0)
	f3_arg0:addElement(f3_arg0.continueButton)
	local f3_local5 = LUI.UIText.new()
	f3_local5:setLeftRight(true, true, 0, 0)
	f3_local5:setTopBottom(true, true, 0, 0)
	f3_local5:setFont(CoD.fonts.Condensed)
	f3_local5:setAlignment(LUI.Alignment.Right)
	f3_arg0.continueButton:addElement(f3_local5)
	f3_local5:setText(Engine.Localize("PLATFORM_SKIP"))
	f3_arg0.continueButton:registerEventHandler("hide_continue_button", CoD.Briefing.HideContinueButton)
	f3_arg0.continueButton:addElement(LUI.UITimer.new(5000, "hide_continue_button", true, f3_arg0.continueButton))
	f3_arg0.continueButton:beginAnimation("show", 1000)
	f3_arg0.continueButton:setAlpha(1)
end

CoD.HUD.IntroCompleted = function (f4_arg0, f4_arg1)
	local f4_local0 = Dvar.ui_mapname:get()
	local f4_local1 = UIExpression.GetPrimaryController()
	if f4_arg0.continueButton then
		f4_arg0.continueButton:close()
		f4_arg0.continueButton = nil
	end
	CoD.MissionBriefing.LoadDefault = true
	CoD.CACLoadOutMenu.RestoreDefaults()
	f4_arg0.shadesHud.main:addElement(LUI.createMenu.CampaignMissionBriefingMenu(f4_local1))
end

CoD.HUD.ChangeInputEnabled = function (f5_arg0, f5_arg1)
	if f5_arg1.isEnabled ~= nil then
		f5_arg0.m_inputDisabled = not f5_arg1.isEnabled
	end
end

CoD.HUD.FrontendPlayerConnected = function (f6_arg0, f6_arg1)
	f6_arg0.shadesHud:processEvent({
		name = "setup_frontend",
		controller = f6_arg0.controller,
		mapname = f6_arg1.mapname
	})
end

CoD.HUD.FirstSnapshot = function (f7_arg0, f7_arg1)
	f7_arg0:removeAllChildren()
	f7_arg0:setOwner(nil)
	f7_arg0.controller = f7_arg1.controller
	f7_arg0.shadesHud = CoD.ShadesHud.new(f7_arg0.controller)
	f7_arg0:addElement(f7_arg0.shadesHud)
	f7_arg0.shadesHud:processEvent({
		name = "setup_hud",
		controller = f7_arg0.controller,
		mapname = f7_arg1.mapname
	})
	if Engine.GameModeIsMode(CoD.GAMEMODE_RTS) then
		local f7_local0 = CoD.RTS.new(f7_arg1.mapname, f7_arg1.controller)
		f7_local0.shadesButtonFollowPrompts = f7_arg0.shadesHud.rtsButtonPrompts
		f7_arg0:addElement(f7_local0)
		CoD.TitleCard.SetupUI3DWindowsForInGame()
		local f7_local1 = 0
		local f7_local2, f7_local3 = Engine.LUICoordsFromUI3DCoords(f7_local1, 60, 60)
		local f7_local4, f7_local5 = Engine.LUICoordsFromUI3DCoords(f7_local1, 250, 250)
		local f7_local6 = CoD.Compass.new(nil, CoD.COMPASS_TYPE_PARTIAL)
		f7_local6:setLeftRight(true, false, f7_local2, f7_local4 + f7_local2)
		f7_local6:setTopBottom(true, false, f7_local3, f7_local5 + f7_local3)
		f7_local6:setUI3DWindow(f7_local1)
		f7_arg0:addElement(f7_local6)
	end
	f7_arg0.shadesHud:dispatchEventToChildren({
		name = "update_style",
		style = "twenties"
	})
	f7_arg0.vehicleHudRoot = LUI.UIElement.new()
	f7_arg0.vehicleHudRoot:setLeftRight(true, true, 0, 0)
	f7_arg0.vehicleHudRoot:setTopBottom(true, true, 0, 0)
	f7_arg0:addElement(f7_arg0.vehicleHudRoot)
	f7_arg0.scriptHudElems = LUI.UIElement.new()
	f7_arg0.scriptHudElems:setLeftRight(true, true, 0, 0)
	f7_arg0.scriptHudElems:setTopBottom(true, true, 0, 0)
	f7_arg0:addElement(f7_arg0.scriptHudElems)
	f7_arg0.scriptHudElems:setupHudElems()
	f7_arg0.cinematicSubtitles = LUI.UIElement.new()
	f7_arg0.cinematicSubtitles:setLeftRight(true, true, 0, 0)
	f7_arg0.cinematicSubtitles:setTopBottom(true, true, 0, 0)
	f7_arg0:addElement(f7_arg0.cinematicSubtitles)
	f7_arg0.cinematicSubtitles:setupCinematicSubtitles()
	f7_arg0.titleCard = LUI.createMenu.TitleCard(f7_arg1.controller)
	f7_arg0:addElement(f7_arg0.titleCard)
end

CoD.HUD.DebugReload = function (f8_arg0, f8_arg1)
	if f8_arg0.m_eventHandlers.debug_reload ~= CoD.HUD.DebugReload then
		f8_arg0:registerEventHandler("debug_reload", CoD.HUD.DebugReload)
		f8_arg0:processEvent({
			name = "debug_reload",
			mapname = f8_arg1.mapname
		})
		return 
	else
		CoD.HUD.SetupEventHandlers(f8_arg0)
		f8_arg0:removeAllChildren()
		CoD.HUD.FirstSnapshot(f8_arg0, {
			controller = f8_arg0.controller,
			mapname = f8_arg1.mapname
		})
		Engine.ForceHUDRefresh()
	end
end

CoD.HUD.HUDF35 = function (f9_arg0, f9_arg1)
	local f9_local0, f9_local1 = Engine.GetUserSafeArea()
	local f9_local2 = CoD.F35Hud.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f9_local0 / 2,
		right = f9_local0 / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = -f9_local1 / 2,
		bottom = f9_local1 / 2
	}, true)
	f9_local2:setPriority(-10)
	f9_arg0.vehicleHudRoot:addElement(f9_local2)
	f9_arg0.vehicleHud = f9_local2
	f9_arg0:dispatchEventToChildren(f9_arg1)
end

CoD.HUD.SpawnVehicleHUD = function (f10_arg0, f10_arg1, f10_arg2)
	if not f10_arg0.vehicleHudRoot then
		return 
	end
	local Widget = nil
	local f10_local1 = false
	local f10_local2, f10_local3 = Engine.GetUserSafeArea()
	local f10_local4 = {
		left = -f10_local2 / 2,
		top = -f10_local3 / 2,
		right = f10_local2 / 2,
		bottom = f10_local3 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	}
	if f10_arg1 == "plane_f35_player_vtol" or f10_arg1 == "plane_f35_player" or f10_arg1 == "plane_f35_player_vtol_fast" then
		if f10_arg0.vehicleHud == nil then
			Widget = CoD.F35Hud.new(f10_local4)
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
			f10_local1 = false
		end
	elseif f10_arg1 == "spiderbot_large" or f10_arg1 == "spiderbot" then
		if f10_arg0.vehicleHud == nil then
			Widget = CoD.SpiderbotHud.new(f10_local4, entityNum)
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "apc_cougar_sam_turret" or f10_arg1 == "apc_cougar_sam_turret_nophysics" or f10_arg1 == "wpn_sam_launcher" then
		if f10_arg0.vehicleHud == nil then
			Widget = LUI.createMenu.SamTurretHud(f10_arg0.controller)
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "drone_firescout" or f10_arg1 == "drone_firescout_allies" then
		if f10_arg0.vehicleHud == nil then
			Widget = LUI.createMenu.ChopperGunnerHud(f10_arg0.controller)
			Widget:addMainTurret()
			Widget:disableOverheatTurret()
			Widget:addMissiles()
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "heli_future_ground" then
		if f10_arg0.vehicleHud == nil then
			Widget = LUI.createMenu.ChopperGunnerHud(f10_arg0.controller)
			Widget:addMainTurret()
			Widget:addMissiles()
			Widget:missilesOffline()
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "drone_claw" then
		if f10_arg0.vehicleHud == nil then
			Widget = CoD.ClawHud.new()
			Widget:addMainTurret()
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "drone_claw_rts" then
		if f10_arg0.vehicleHud == nil then
			Widget = CoD.ClawHud.new()
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "drone_claw_wflamethrower" then
		if f10_arg0.vehicleHud == nil then
			Widget = CoD.ClawHud.new()
			Widget:addMainTurret()
			Widget:addFlamethrower()
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "turret_cic" or f10_arg1 == "turret_sentry" or f10_arg1 == "turret_sentry_rts" or f10_arg1 == "plane_jetwing" then
		if f10_arg0.vehicleHud == nil then
			Widget = LUI.createMenu.CICTurretHud(f10_arg0.controller)
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "drone_metalstorm_rts" or f10_arg1 == "drone_metalstorm_afghan_rts" then
		if f10_arg0.vehicleHud == nil then
			Widget = LUI.createMenu.ASDDroneHud(f10_arg0.controller)
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "heli_quadrotor_rts" or f10_arg1 == "heli_quadrotor_rts_player" then
		if f10_arg0.vehicleHud == nil then
			Widget = LUI.createMenu.QRDroneHud(f10_arg0.controller)
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "cctv_hud" then
		if f10_arg0.vehicleHud == nil then
			Widget = LUI.createMenu.CCTVHud(f10_arg0.controller)
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "plane_jetwing_haiti" then
		if f10_arg0.vehicleHud == nil then
			Widget = LUI.createMenu.JetwingHud(f10_arg0.controller)
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "plane_wingsuit" then
		if f10_arg0.vehicleHud == nil then
			Widget = LUI.createMenu.WingsuitHud(f10_arg0.controller)
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "goggles_hud" then
		if f10_arg0.vehicleHud == nil then
			Widget = LUI.createMenu.GogglesHud(f10_arg0.controller)
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "menendez_no_hud" then
		if f10_arg0.vehicleHud == nil then
			Widget = LUI.UIElement.new()
			f10_arg0.vehicleHudRoot:addElement(Widget)
			f10_arg0.vehicleHud = Widget
		end
	elseif f10_arg1 == "retina_scanner" and f10_arg0.vehicleHud == nil then
		Widget = LUI.createMenu.EyeScanner(f10_arg0.controller)
		f10_arg0.vehicleHudRoot:addElement(Widget)
		f10_arg0.vehicleHud = Widget
		local f10_local5 = f10_arg2
		if f10_local5 == nil then
			f10_local5 = 4000
		end
		f10_arg0.shadesHud:processEvent({
			name = "hud_perform_wipe",
			data = {
				f10_local5 / 4
			}
		})
		Widget:addElement(LUI.UITimer.new(f10_local5 * 3 / 16, {
			name = "load_retina_scan",
			totalTime = f10_local5 * 13 / 16
		}, true, Widget))
	end
	return f10_local1
end

CoD.HUD.FlushDynamicHud = function (f11_arg0, f11_arg1)
	if f11_arg0.vehicleHud then
		f11_arg0.vehicleHud:close()
		f11_arg0.vehicleHud = nil
	end
end

CoD.HUD.UpdateVehicle = function (f12_arg0, f12_arg1)
	local f12_local0 = nil
	local f12_local1 = f12_arg1.entityNum
	local f12_local2 = false
	if f12_arg0.vehicleHud then
		f12_arg0.vehicleHud:close()
		f12_arg0.vehicleHud = nil
	end
	if f12_arg1 ~= nil and f12_arg1.vehicleType ~= nil then
		f12_local2 = CoD.HUD.SpawnVehicleHUD(f12_arg0, f12_arg1.vehicleType)
	end
	if f12_arg0.shadesHud then
		if f12_arg1 and f12_arg1.vehicleType and f12_arg1.vehicleType ~= "horse_player" and f12_arg1.vehicleType ~= "boat_soct_player" and f12_arg1.vehicleType ~= "retina_scanner" then
			if f12_arg0.shadesHud.futureHud == true then
				f12_arg0.shadesHud.visorHud:setAlpha(0)
				f12_arg0.shadesHud.leftBracket:setAlpha(0)
				f12_arg0.shadesHud.rightBracket:setAlpha(0)
				if f12_arg0.shadesHud.compass then
					f12_arg0.shadesHud.compass:setAlpha(0)
				end
				if not f12_local2 then
					f12_arg0.shadesHud.weaponLabel:setAlpha(0)
					f12_arg0.shadesHud.ammoCounter:setAlpha(0)
					f12_arg0.shadesHud.lethals:setAlpha(0)
					f12_arg0.shadesHud.tacticals:setAlpha(0)
				end
			end
		elseif f12_arg0.shadesHud.futureHud == true then
			f12_arg0.shadesHud.visorHud:setAlpha(CoD.VisorHud.VisorDefaultAlpha)
			f12_arg0.shadesHud.leftBracket:setAlpha(CoD.VisorLeftBracket.DefaultAlpha)
			f12_arg0.shadesHud.rightBracket:setAlpha(CoD.VisorRightBracket.DefaultAlpha)
			if f12_arg0.shadesHud.compass then
				f12_arg0.shadesHud.compass:setAlpha(CoD.ShadesHud.CompassAlpha)
			end
			if not f12_local2 then
				f12_arg0.shadesHud.weaponLabel:setAlpha(CoD.WeaponLabel.DefaultAlpha)
				f12_arg0.shadesHud.ammoCounter:setAlpha(CoD.AmmoCounter.DefaultAlpha)
				f12_arg0.shadesHud.lethals:setAlpha(CoD.OffhandIcons.DefaultAlpha)
				f12_arg0.shadesHud.tacticals:setAlpha(CoD.OffhandIcons.DefaultAlpha)
			end
		end
	end
	local f12_local3 = nil
	if f12_arg1 then
		f12_local3 = f12_arg1.vehicleType
	end
	f12_arg0:updateShadesFromVehicle(f12_local3, usingOverheadWeapon)
	f12_arg0:dispatchEventToChildren({
		name = "hud_update_refresh"
	})
	f12_arg0:dispatchEventToChildren(f12_arg1)
end

CoD.HUD.UpdateVehicleCustom = function (f13_arg0, f13_arg1)
	local f13_local0, f13_local1 = nil
	local f13_local2 = false
	if f13_arg1.data then
		local f13_local3 = f13_arg1.data[1]
		f13_local1 = f13_arg1.data[2]
		if type(f13_local1) == "number" then
			f13_local1 = Engine.GetIString(f13_local1, "CS_LOCALIZED_STRINGS")
		end
		if f13_local3 == 1 and f13_arg0.vehicleHud == nil then
			f13_local2 = CoD.HUD.SpawnVehicleHUD(f13_arg0, f13_local1, f13_arg1.data[3])
			f13_arg0:dispatchEventToChildren({
				name = "hud_update_refresh"
			})
			f13_arg0.usingFakeVehicleHud = true
		elseif f13_local3 == 0 and f13_arg0.vehicleHud then
			f13_arg0.vehicleHud:close()
			f13_arg0.vehicleHud = nil
			f13_arg0.usingFakeVehicleHud = nil
		end
	end
	f13_arg0:updateShadesFromVehicle(f13_local1, usingOverheadWeapon)
end

CoD.HUD.UpdateShadesFromVehicle = function (f14_arg0, f14_arg1, f14_arg2)
	if f14_arg0.shadesHud then
		if f14_arg1 and f14_arg1 ~= "horse_player" and f14_arg1 ~= "boat_soct_player" and f14_arg1 ~= "retina_scanner" then
			if f14_arg0.shadesHud.futureHud == true then
				f14_arg0.shadesHud.visorHud:setAlpha(0)
				f14_arg0.shadesHud.leftBracket:setAlpha(0)
				f14_arg0.shadesHud.rightBracket:setAlpha(0)
				if f14_arg0.shadesHud.compass then
					f14_arg0.shadesHud.compass:setAlpha(0)
				end
				if not usingOverheatWeapon then
					f14_arg0.shadesHud.weaponLabel:setAlpha(0)
					f14_arg0.shadesHud.ammoCounter:setAlpha(0)
					f14_arg0.shadesHud.lethals:setAlpha(0)
					f14_arg0.shadesHud.tacticals:setAlpha(0)
				end
			end
		elseif f14_arg0.shadesHud.futureHud == true then
			f14_arg0.shadesHud.visorHud:setAlpha(CoD.VisorHud.VisorDefaultAlpha)
			f14_arg0.shadesHud.leftBracket:setAlpha(CoD.VisorLeftBracket.DefaultAlpha)
			f14_arg0.shadesHud.rightBracket:setAlpha(CoD.VisorRightBracket.DefaultAlpha)
			if f14_arg0.shadesHud.compass then
				f14_arg0.shadesHud.compass:setAlpha(CoD.ShadesHud.CompassAlpha)
			end
			if not usingOverheatWeapon then
				f14_arg0.shadesHud.weaponLabel:setAlpha(CoD.WeaponLabel.DefaultAlpha)
				f14_arg0.shadesHud.ammoCounter:setAlpha(CoD.AmmoCounter.DefaultAlpha)
				f14_arg0.shadesHud.lethals:setAlpha(CoD.OffhandIcons.DefaultAlpha)
				f14_arg0.shadesHud.tacticals:setAlpha(CoD.OffhandIcons.DefaultAlpha)
			end
		end
	end
end

CoD.HUD.OpenMissionObjectives = function (f15_arg0, f15_arg1)
	if f15_arg0.missionObjectives == nil then
		f15_arg0.missionObjectives = LUI.createMenu.MissionObjectives(f15_arg1.controller)
	end
	f15_arg0:addElement(f15_arg0.missionObjectives)
end

CoD.HUD.CloseMissionObjectives = function (f16_arg0, f16_arg1)
	if f16_arg0.missionObjectives then
		f16_arg0.missionObjectives:close()
		f16_arg0.missionObjectives = nil
		Engine.SetUIActive(f16_arg1.controller, false)
		Engine.ClearUIMenuState(f16_arg1.controller)
	end
end

CoD.HUD.OpenReadingSaveDevcice = function (f17_arg0, f17_arg1)
	if f17_arg0.readingSaveDevice == nil then
		f17_arg0.readingSaveDevice = LUI.createMenu.ReadingSaveDevice(f17_arg1.controller)
		f17_arg0.readingSaveDevice:setPriority(10000)
		f17_arg0:addElement(f17_arg0.readingSaveDevice)
	end
end

CoD.HUD.CloseTitleCard = function (f18_arg0, f18_arg1)
	if f18_arg0.titleCard then
		f18_arg0.titleCard:close()
		f18_arg0.titleCard = nil
	end
end

CoD.HUD.GamepadButton = function (f19_arg0, f19_arg1)
	if f19_arg0.m_inputDisabled and f19_arg1.button ~= "right_trigger" then
		return 
	elseif f19_arg0.anyControllerAllowed == true or UIExpression.IsControllerBeingUsed(f19_arg1.controller) == 1 then
		if f19_arg0.m_ownerController == nil or f19_arg0.m_ownerController == f19_arg1.controller then
			return f19_arg0:dispatchEventToChildren(f19_arg1)
		else

		end
	else
		local f19_local0 = f19_arg1.name
		f19_arg1.name = "unused_gamepad_button"
		local f19_local1 = f19_arg0:dispatchEventToChildren(f19_arg1)
		f19_arg1.name = f19_local0
		return f19_local1
	end
end

CoD.HUD.OpenInGameMenu = function (f20_arg0, f20_arg1)
	if f20_arg0.m_inputDisabled then
		return 
	elseif f20_arg1.data ~= nil then
		f20_arg1.menuName = Engine.GetIString(f20_arg1.data[1], "CS_SCRIPT_MENUS")
	end
	local f20_local0 = nil
	if f20_arg1.menuName == "SaveGameErrorPopup" then
		if Engine.IsMenuLevel() then
			if not CoD.ConfirmNewStory.PopupOpen then
				f20_arg0:processEvent({
					name = "open_popup",
					popupName = "FrontendSaveGameErrorPopup"
				})
			else
				CoD.FrontendSaveGameErrorPopup.SaveGameErrorPopup = true
			end
			return 
		end
		f20_local0 = true
	end
	local f20_local1 = LUI.createMenu[f20_arg1.menuName]
	f20_arg0:dispatchEventToChildren(f20_arg1)
	if f20_local1 ~= nil then
		Engine.PauseGame(f20_arg1.controller, true)
		local f20_local2 = f20_arg0:openPopup(f20_arg1.menuName, f20_arg1.controller, {
			saveGameErrorPopupFromCode = f20_local0
		})
	end
end

CoD.HUD.OpenInGameModelessMenu = function (f21_arg0, f21_arg1)
	if f21_arg0.m_inputDisabled then
		return 
	elseif f21_arg1.data ~= nil then
		f21_arg1.menuName = Engine.GetIString(f21_arg1.data[1], "CS_SCRIPT_MENUS")
	end
	local f21_local0 = LUI.createMenu[f21_arg1.menuName]
	f21_arg0:dispatchEventToChildren(f21_arg1)
	if f21_local0 ~= nil then
		local f21_local1 = f21_arg0:openModelessPopup(f21_arg1.menuName, f21_arg1.controller)
	end
end

