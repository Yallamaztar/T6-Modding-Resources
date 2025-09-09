require("T6.HUD.RTSFailedMenu")
require("T6.HUD.RTSTutorialMenu")
require("T6.HUD.RTSResultPopup")
CoD.RTS = {}
CoD.RTS.Blue = {
	0.7,
	0.85,
	1
}
CoD.RTS.DataTableIndexColumn = 0
CoD.RTS.DataTableImageColumn = 10
CoD.RTS.DataTableOrderButtonColumn = 15
CoD.RTS.TopBorderWidth = 512
CoD.RTS.TopBorderHeight = 64
CoD.RTS.TopBorderMaterialName = "hud_rts_border_top"
CoD.RTS.SquadMarkerWidth = 32
CoD.RTS.SquadMarkerHeight = 64
CoD.RTS.ReticleMaterialName = "hud_rts_reticle"
CoD.RTS.DistanceFontName = "ExtraSmall"
CoD.RTS.MinimumTimerSize = 170
CoD.RTS.TimerBracketWidth = 25
CoD.RTS.TimerBackingAlpha = 1
CoD.RTS.DistanceBlueColor = {}
CoD.RTS.DistanceBlueColor.r = 0.23
CoD.RTS.DistanceBlueColor.g = 0.55
CoD.RTS.DistanceBlueColor.b = 0.44
CoD.RTS.SquadMarkerDistanceTextVisible = 1
require("T6.HUD.RTSDockedSquad")
require("T6.HUD.RTSFriendlyAI")
require("T6.HUD.RTSPOI")
require("T6.HUD.InGamePopupMenu")
require("T6.Menus.AARUtility")
CoD.RTS.DockedSquadOrder = {
	DPAD_LEFT = 1,
	DPAD_UP = 2,
	DPAD_RIGHT = 3,
	DPAD_DOWN = 4,
	COUNT = 4
}
CoD.RTS.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setAlpha(0)
	Widget:beginAnimation("show", 1000)
	Widget:setAlpha(1)
	Widget.shakeableArea = CoD.HUDShaker.new()
	Widget:addElement(Widget.shakeableArea)
	Widget.hudOnly = CoD.HUDShaker.new()
	Widget:addElement(Widget.hudOnly)
	Widget.hudOnly:setAlpha(0)
	Widget.rtsOnly = LUI.UIElement.new()
	Widget.rtsOnly:setLeftRight(true, true, 0, 0)
	Widget.rtsOnly:setTopBottom(true, true, 0, 0)
	Widget.rtsOnly:setAlpha(0)
	Widget.rtsOnly:setPriority(100)
	Widget:addElement(Widget.rtsOnly)
	local f1_local1, f1_local2 = Engine.GetUserSafeArea()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f1_local1 / 2, f1_local1 / 2)
	Widget:setTopBottom(false, false, -f1_local2 / 2, f1_local2 / 2)
	Widget.rtsOnly:addElement(Widget)
	Widget:addElement(CoD.VisorTypewriter.new())
	local f1_local4, f1_local5 = Engine.GetUserSafeArea()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f1_local4 / 2, f1_local4 / 2)
	Widget:setTopBottom(false, false, -f1_local5 / 2, f1_local5 / 2)
	Widget.shakeableArea:addElement(Widget)
	Widget.buttonFollowPrompts = CoD.RTS.AddButtonPrompts()
	Widget:addElement(Widget.buttonFollowPrompts)
	local f1_local7 = LUI.UIImage.new()
	f1_local7:setLeftRight(true, false, CoD.RTS.TopBorderWidth, 0)
	f1_local7:setTopBottom(true, false, 0, CoD.RTS.TopBorderHeight)
	f1_local7:setImage(RegisterMaterial(CoD.RTS.TopBorderMaterialName))
	Widget.rtsOnly:addElement(f1_local7)
	local f1_local8 = LUI.UIImage.new()
	f1_local8:setLeftRight(false, true, -CoD.RTS.TopBorderWidth, 0)
	f1_local8:setTopBottom(true, false, 0, CoD.RTS.TopBorderHeight)
	f1_local8:setImage(RegisterMaterial(CoD.RTS.TopBorderMaterialName))
	Widget.rtsOnly:addElement(f1_local8)
	local f1_local9 = LUI.UIImage.new()
	f1_local9:setLeftRight(true, false, CoD.RTS.TopBorderWidth, 0)
	f1_local9:setTopBottom(false, true, 0, -CoD.RTS.TopBorderHeight)
	f1_local9:setImage(RegisterMaterial(CoD.RTS.TopBorderMaterialName))
	Widget.rtsOnly:addElement(f1_local9)
	local f1_local10 = LUI.UIImage.new()
	f1_local10:setLeftRight(false, true, -CoD.RTS.TopBorderWidth, 0)
	f1_local10:setTopBottom(false, true, 0, -CoD.RTS.TopBorderHeight)
	f1_local10:setImage(RegisterMaterial(CoD.RTS.TopBorderMaterialName))
	Widget.rtsOnly:addElement(f1_local10)
	local f1_local11 = 39
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f1_local11, f1_local11 + CoD.textSize.Default)
	Widget:setAlpha(0)
	Widget.gameTimerContainer = Widget
	Widget:addElement(Widget)
	local f1_local13 = CoD.textSize.Default + CoD.textSize.Condensed
	
	local timerBackground = LUI.UIElement.new()
	timerBackground:setLeftRight(false, false, -CoD.RTS.MinimumTimerSize / 2, CoD.RTS.MinimumTimerSize / 2)
	timerBackground:setTopBottom(true, false, -1, f1_local13 + 30)
	timerBackground:setAlpha(0.4)
	Widget:addElement(timerBackground)
	Widget.timerBackground = timerBackground
	
	local f1_local15 = LUI.UIImage.new()
	f1_local15:setLeftRight(true, false, 0, CoD.RTS.TimerBracketWidth)
	f1_local15:setTopBottom(true, true, 0, 0)
	f1_local15:setImage(RegisterMaterial("hud_rts_timer_back_black"))
	f1_local15:setAlpha(CoD.RTS.TimerBackingAlpha)
	Widget.timerBackground:addElement(f1_local15)
	local f1_local16 = LUI.UIImage.new()
	f1_local16:setLeftRight(false, true, 0, -CoD.RTS.TimerBracketWidth)
	f1_local16:setTopBottom(true, true, 0, 0)
	f1_local16:setImage(RegisterMaterial("hud_rts_timer_back_black"))
	f1_local16:setAlpha(CoD.RTS.TimerBackingAlpha)
	Widget.timerBackground:addElement(f1_local16)
	local f1_local17 = LUI.UIImage.new()
	f1_local17:setLeftRight(true, true, CoD.RTS.TimerBracketWidth, -CoD.RTS.TimerBracketWidth)
	f1_local17:setTopBottom(true, true, 0, 0)
	f1_local17:setImage(RegisterMaterial("hud_rts_timer_back_stretch_black"))
	f1_local17:setAlpha(CoD.RTS.TimerBackingAlpha)
	Widget.timerBackground:addElement(f1_local17)
	local f1_local18 = LUI.UIImage.new()
	f1_local18:setLeftRight(true, false, 0, CoD.RTS.TimerBracketWidth)
	f1_local18:setTopBottom(true, true, 0, 0)
	f1_local18:setImage(RegisterMaterial("hud_rts_timer_back"))
	Widget.timerBackground:addElement(f1_local18)
	local f1_local19 = LUI.UIImage.new()
	f1_local19:setLeftRight(false, true, 0, -CoD.RTS.TimerBracketWidth)
	f1_local19:setTopBottom(true, true, 0, 0)
	f1_local19:setImage(RegisterMaterial("hud_rts_timer_back"))
	Widget.timerBackground:addElement(f1_local19)
	local f1_local20 = LUI.UIImage.new()
	f1_local20:setLeftRight(true, true, CoD.RTS.TimerBracketWidth, -CoD.RTS.TimerBracketWidth)
	f1_local20:setTopBottom(true, true, 0, 0)
	f1_local20:setImage(RegisterMaterial("hud_rts_timer_back_stretch"))
	Widget.timerBackground:addElement(f1_local20)
	
	local timerHeader = LUI.UIText.new()
	timerHeader:setLeftRight(true, true, 0, 0)
	timerHeader:setTopBottom(true, false, 0, CoD.textSize.Default)
	timerHeader:setFont(CoD.fonts.Default)
	timerHeader:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	timerHeader:setAlpha(0.8)
	Widget:addElement(timerHeader)
	Widget.timerHeader = timerHeader
	
	local timeLeft = LUI.UIText.new()
	timeLeft:setLeftRight(true, true, 0, 0)
	timeLeft:setTopBottom(true, false, CoD.textSize.Default, f1_local13)
	timeLeft:setFont(CoD.fonts.Condensed)
	timeLeft:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	CoD.CountdownTimer.Setup(timeLeft)
	Widget:addElement(timeLeft)
	Widget.timeLeft = timeLeft
	
	local f1_local23 = CoD.textSize.Default
	local f1_local24 = CoD.fonts.Default
	local f1_local25 = f1_local23
	local f1_local26 = f1_local11 + f1_local13 + 10
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f1_local26, f1_local25 + f1_local26)
	Widget:addElement(Widget)
	
	local rtsHintText = LUI.UIText.new()
	rtsHintText:setLeftRight(true, true, 0, 0)
	rtsHintText:setTopBottom(true, false, 0, f1_local23)
	rtsHintText:setFont(f1_local24)
	rtsHintText:setAlignment(LUI.Alignment.Center)
	rtsHintText:registerEventHandler("rts_hint_text_duration", CoD.RTS.HintTextDuration)
	Widget:addElement(rtsHintText)
	Widget.rtsHintText = rtsHintText
	
	local f1_local29 = 230
	local f1_local30 = -120
	local f1_local31 = LUI.UIText.new()
	f1_local31:setLeftRight(true, true, f1_local29, f1_local29)
	f1_local31:setTopBottom(false, true, f1_local30 - CoD.textSize.Condensed - CoD.textSize.Default, f1_local30 - CoD.textSize.Condensed)
	f1_local31:setFont(CoD.fonts.Default)
	f1_local31:setAlpha(0)
	Widget:addElement(f1_local31)
	f1_local31:setText(Engine.Localize("SO_RTS_AIRSTRIKE_AVAILABLE_IN"))
	Widget.airstrikeTimerHeader = f1_local31
	
	local airstrikeTimeLeft = LUI.UIText.new()
	airstrikeTimeLeft:setLeftRight(true, true, f1_local29, f1_local29)
	airstrikeTimeLeft:setTopBottom(false, true, f1_local30 - CoD.textSize.Condensed, f1_local30)
	airstrikeTimeLeft:setFont(CoD.fonts.Condensed)
	CoD.CountdownTimer.Setup(airstrikeTimeLeft)
	Widget:addElement(airstrikeTimeLeft)
	Widget.airstrikeTimeLeft = airstrikeTimeLeft
	
	local f1_local33 = (720 - f1_local5) / 2
	local f1_local34 = LUI.UIHorizontalList.new()
	f1_local34:setLeftRight(true, true, 0, 0)
	f1_local34:setTopBottom(false, true, -f1_local33 - CoD.RTSDockedSquad.Height - CoD.textSize.Default, 0)
	f1_local34:setAlignment(LUI.Alignment.Center)
	f1_local34:setPriority(100)
	if CoD.isPC then
		f1_local34:setSpacing(30)
	end
	Widget.shakeableArea:addElement(f1_local34)
	Widget.squadDock = f1_local34
	Widget.squads = {}
	Widget.squadsByPkgIdx = {}
	Widget.squadsByOrder = {}
	Widget.numSquads = 0
	local f1_local35 = LUI.UIText.new()
	f1_local35:setLeftRight(true, true, 0, 0)
	f1_local35:setTopBottom(false, true, -f1_local33 - CoD.RTSDockedSquad.Height - CoD.textSize.Default - CoD.textSize.Default - 30, -f1_local33 - CoD.RTSDockedSquad.Height - CoD.textSize.Default - 30)
	f1_local35:setRGB(CoD.visorBlue.r, CoD.visorBlue.g, CoD.visorBlue.b)
	f1_local35:setFont(CoD.fonts.Default)
	f1_local35:setAlignment(LUI.Alignment.Center)
	f1_local35:setText("")
	f1_local35:registerEventHandler("rts_toggle_tact_instruction", CoD.RTS.ToggleTacticalInstruction)
	Widget.rtsOnly:addElement(f1_local35)
	Widget.rtsOnly.tacticalInstructions = f1_local35
	
	local timeWarning = LUI.UIText.new()
	timeWarning:setLeftRight(true, true, 0, 0)
	timeWarning:setTopBottom(false, true, -f1_local33 - CoD.RTSDockedSquad.Height - CoD.textSize.Default * 2 - CoD.textSize.Big - 20, -f1_local33 - CoD.RTSDockedSquad.Height - CoD.textSize.Default * 2 - 20)
	timeWarning:setRGB(CoD.visorBlue.r, CoD.visorBlue.g, CoD.visorBlue.b)
	timeWarning:setFont(CoD.fonts.Big)
	timeWarning:setAlignment(LUI.Alignment.Center)
	timeWarning:setAlpha(0)
	Widget:addElement(timeWarning)
	Widget.timeWarning = timeWarning
	
	local f1_local37 = LUI.UIImage.new()
	f1_local37:setLeftRight(false, false, -64, 64)
	f1_local37:setTopBottom(false, false, -64, 64)
	f1_local37:setImage(RegisterMaterial(CoD.RTS.ReticleMaterialName))
	f1_local37:setPriority(100)
	Widget.reticle = f1_local37
	Widget.rtsOnly:addElement(f1_local37)
	Widget:registerEventHandler("rts_add_friendly_ai", CoD.RTS.AddFriendlyAI)
	Widget:registerEventHandler("rts_add_friendly_human", CoD.RTS.AddFriendlyHuman)
	Widget:registerEventHandler("rts_add_poi", CoD.RTS.AddPOI)
	Widget:registerEventHandler("rts_add_squad", CoD.RTS.AddSquad)
	Widget:registerEventHandler("rts_remove_squad", CoD.RTS.RemoveSquad)
	Widget:registerEventHandler("rts_airstrike_avail_in", CoD.RTS.AirstrikeAvailIn)
	Widget:registerEventHandler("rts_highlight_squad", CoD.RTS.HighlightSquad)
	Widget:registerEventHandler("rts_hud_visibility", CoD.RTS.HUDVisibility)
	Widget:registerEventHandler("rts_move_squad_marker", CoD.RTS.MoveSquadMarker)
	Widget:registerEventHandler("rts_squad_start_attack", CoD.RTS.SquadStartAttack)
	Widget:registerEventHandler("rts_squad_start_attack_poi", CoD.RTS.SquadStartAttack)
	Widget:registerEventHandler("rts_squad_stop_attack", CoD.RTS.SquadStopAttack)
	Widget:registerEventHandler("rts_target_enemy", CoD.RTS.TargetEnemy)
	Widget:registerEventHandler("rts_target_poi", CoD.RTS.TargetEnemy)
	Widget:registerEventHandler("rts_time_left", CoD.RTS.TimeLeft)
	Widget:registerEventHandler("rts_predator_hud", CoD.RTS.PredatorHUD)
	Widget:registerEventHandler("rts_update_hint_text", CoD.RTS.UpdateHintText)
	Widget:registerEventHandler("rts_hint_text_duration", CoD.RTS.HintTextDuration)
	Widget:registerEventHandler("rts_toggle_button_prompts", CoD.RTS.ToggleButtonPrompts)
	Widget:registerEventHandler("controller_changed", CoD.RTS.ControllerChanged)
	Widget:registerEventHandler("hud_update_refresh", CoD.RTS.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_HUD_VISIBLE, CoD.RTS.UpdateVisibility)
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_UI_ACTIVE, CoD.RTS.UpdateVisibility)
	Widget:registerEventHandler("hide_time_remaining", CoD.RTS.HideTimeRemainingWarning)
	Widget:registerEventHandler("time_remaining_2_min", CoD.RTS.TwoMinutesRemaining)
	Widget:registerEventHandler("time_remaining_1_min", CoD.RTS.OneMinuteRemaining)
	Widget:registerEventHandler("rts_menu_mission_failed", CoD.RTS.MissionFailedMenu)
	Widget:registerEventHandler("rts_restart_mission", CoD.InGamePopups.RestartLevelEvent)
	Widget:registerEventHandler("rts_tutorial_complete", CoD.RTS.TutorialCompleteMenu)
	Widget:registerEventHandler("rts_success", CoD.RTS.MissionSuccess)
	Widget:registerEventHandler("rts_failed", CoD.RTS.MissionFailed)
	Widget:registerEventHandler("rts_hide_result", CoD.RTS.HideMissionResult)
	Widget:registerEventHandler("rts_update_overlord_help", CoD.RTS.SetOverlordHelpText)
	CoD.RTS.DataTable = ""
	if HudRef == "so_rts_mp_dockside" then
		CoD.RTS.DataTable = "sp/so_rts/mp_dockside_rts.csv"
	end
	if HudRef == "so_rts_mp_socotra" then
		CoD.RTS.DataTable = "sp/so_rts/mp_socotra_rts.csv"
	end
	if HudRef == "so_rts_afghanistan" then
		CoD.RTS.DataTable = "sp/so_rts/afghanistan_rts.csv"
	end
	if HudRef == "so_rts_mp_overflow" then
		CoD.RTS.DataTable = "sp/so_rts/mp_overflow_rts.csv"
	end
	if HudRef == "so_rts_mp_drone" then
		CoD.RTS.DataTable = "sp/so_rts/mp_drone_rts.csv"
	end
	if HudRef == "so_tut_mp_drone" then
		CoD.RTS.DataTable = "sp/so_rts/mp_drone_tut.csv"
	end
	Widget:processEvent({
		name = "controller_changed",
		controller = InstanceRef
	})
	return Widget
end

CoD.RTS.AddButtonPrompts = function ()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	local f2_local1 = 50
	local f2_local2 = 155
	local f2_local3 = CoD.fonts.ExtraSmall
	local f2_local4 = CoD.textSize.ExtraSmall
	local f2_local5 = LUI.UIText.new()
	f2_local5:setLeftRight(true, false, f2_local1, f2_local1 + 1)
	f2_local5:setTopBottom(false, false, f2_local2, f2_local2 + f2_local4)
	f2_local5:setFont(f2_local3)
	f2_local5:setText(Engine.Localize("SO_RTS_SQUAD_FOLLOW"))
	Widget:addElement(f2_local5)
	local f2_local6 = f2_local1 + 5
	local f2_local7 = LUI.UIText.new()
	f2_local7:setLeftRight(true, false, f2_local6, f2_local6 + 1)
	f2_local7:setTopBottom(false, false, f2_local2 + f2_local4, f2_local2 + f2_local4 * 2)
	f2_local7:setFont(f2_local3)
	f2_local7:setText(Engine.Localize("SO_RTS_ALL_FOLLOW"))
	Widget:addElement(f2_local7)
	local f2_local8 = f2_local6 + 5
	local f2_local9 = LUI.UIText.new()
	f2_local9:setLeftRight(true, false, f2_local8, f2_local8 + 1)
	f2_local9:setTopBottom(false, false, f2_local2 + f2_local4 * 2, f2_local2 + f2_local4 * 3)
	f2_local9:setFont(f2_local3)
	f2_local9:setText(Engine.Localize("SO_RTS_TACT_MAP"))
	Widget:addElement(f2_local9)
	local f2_local10 = f2_local8 + 5
	local f2_local11 = LUI.UIText.new()
	f2_local11:setLeftRight(true, false, f2_local10, f2_local10 + 1)
	f2_local11:setTopBottom(false, false, f2_local2 + f2_local4 * 3, f2_local2 + f2_local4 * 4)
	f2_local11:setFont(f2_local3)
	f2_local11:setText(Engine.Localize("SO_RTS_SWITCH_UNITS"))
	CoD.RTS.SetupDpadOrCarouselText(f2_local11, "SO_RTS_SWITCH_UNITS", "SO_RTS_SWITCH_UNITS_WIIU_CAROUSEL")
	Widget:addElement(f2_local11)
	return Widget
end

CoD.RTS.ToggleButtonPrompts = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1.data[1]
	if f3_arg0.buttonFollowPrompts then
		if f3_local0 == 0 then
			f3_arg0.buttonFollowPrompts:setAlpha(0)
		else
			f3_arg0.buttonFollowPrompts:setAlpha(1)
		end
	end
	if f3_arg0.shadesButtonFollowPrompts then
		if f3_local0 == 0 then
			f3_arg0.shadesButtonFollowPrompts:setAlpha(0)
		else
			f3_arg0.shadesButtonFollowPrompts:setAlpha(1)
		end
	end
	if f3_arg0.rtsOnly.tacticalInstructions then
		if f3_local0 == 0 then
			f3_arg0.rtsOnly.tacticalInstructions:setAlpha(0)
		else
			f3_arg0.rtsOnly.tacticalInstructions:setAlpha(1)
		end
	end
end

CoD.RTS.AddFriendlyAI = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg1.data[1]
	local f4_local1 = f4_arg1.data[2]
	local f4_local2 = CoD.RTSFriendlyAI.new(f4_local0, false, f4_local1, f4_arg1.data[3], f4_arg1.data[4])
	f4_arg0:addElement(f4_local2)
	if f4_arg0.lastHighligtedSquad == f4_local1 then
		CoD.RTSFriendlyAI.ForceHighlightSquad(f4_local2)
	end
	f4_arg0:dispatchEventToChildren(f4_arg1)
end

CoD.RTS.AddFriendlyHuman = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1.data[1]
	local f5_local1 = f5_arg1.data[2]
	local f5_local2 = f5_arg1.data[3]
	local f5_local3 = f5_arg1.data[4]
	local f5_local4 = f5_arg1.data[5]
	if f5_local3 ~= 1 then
		local f5_local5 = CoD.RTSFriendlyAI.new(f5_local0, true, f5_local1, f5_local2, f5_local4)
		f5_arg0:addElement(f5_local5)
		if f5_arg0.lastHighligtedSquad == f5_local1 then
			CoD.RTSFriendlyAI.ForceHighlightSquad(f5_local5)
		end
	end
	f5_arg0:dispatchEventToChildren(f5_arg1)
end

CoD.RTS.AddPOI = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.data[1]
	local f6_local1 = 0
	if f6_arg1.data[2] ~= nil then
		f6_local1 = f6_arg1.data[2]
	end
	local f6_local2 = CoD.RTSPOI.new(f6_local0, f6_local1, true)
	f6_local2:setPriority(50)
	f6_arg0:addElement(f6_local2)
end

CoD.RTS.AddSquad = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg1.data[1]
	local f7_local1 = f7_arg1.data[2]
	local f7_local2 = f7_arg1.data[3]
	local f7_local3 = f7_arg1.data[4]
	if f7_arg0.squadsByPkgIdx[f7_local1] then
		f7_arg0.squads[f7_local0] = f7_arg0.squadsByPkgIdx[f7_local1]
		f7_arg0.squadsByPkgIdx[f7_local1].dockedSquad:processEvent(f7_arg1)
	else
		local f7_local4 = {
			pkgIdx = f7_local1,
			dockedSquad = CoD.RTSDockedSquad.new(f7_local0, f7_local1, f7_local2, f7_local3),
			squadNumber = f7_arg0.numSquads
		}
		local f7_local5 = false
		for f7_local6 = CoD.RTS.DockedSquadOrder[f7_local4.dockedSquad.orderButton] + 1, CoD.RTS.DockedSquadOrder.COUNT, 1 do
			if f7_arg0.squadsByOrder[f7_local6] then
				f7_local4.dockedSquad:addElementBefore(f7_arg0.squadsByOrder[f7_local6].dockedSquad)
				f7_local5 = true
				break
			end
		end
		if not f7_local5 then
			f7_arg0.squadDock:addElement(f7_local4.dockedSquad)
		end
		f7_arg0.squads[f7_local0] = f7_local4
		f7_arg0.squadsByPkgIdx[f7_local1] = f7_local4
		f7_arg0.squadsByOrder[CoD.RTS.DockedSquadOrder[f7_local4.dockedSquad.orderButton]] = f7_local4
		f7_arg0.numSquads = f7_arg0.numSquads + 1
	end
end

CoD.RTS.RemoveSquad = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg1.data[1]
	if f8_local0 ~= nil and f8_arg0.squads[f8_local0] then
		local f8_local1 = f8_arg0.squads[f8_local0].pkgIdx
		if f8_arg0.squadsByPkgIdx[f8_local1] ~= nil then
			f8_arg0.squadsByPkgIdx[f8_local1].dockedSquad:processEvent(f8_arg1)
		end
		f8_arg0.squadsByPkgIdx[f8_local1] = nil
		f8_arg0.squadsByOrder[CoD.RTS.DockedSquadOrder[f8_arg0.squads[f8_local0].dockedSquad.orderButton]] = nil
		f8_arg0.squads[f8_local0] = nil
	end
end

CoD.RTS.AirstrikeAvailIn = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg1.data[1]
	f9_arg0.airstrikeTimeLeft:setTimeLeft(f9_local0 * 1000)
	if f9_local0 > 0 then
		f9_arg0.airstrikeTimerHeader:setAlpha(0.4)
	else
		f9_arg0.airstrikeTimerHeader:setAlpha(0)
	end
end

CoD.RTS.HighlightSquad = function (f10_arg0, f10_arg1)
	f10_arg0.lastHighligtedSquad = f10_arg1.data[1]
	f10_arg0:dispatchEventToChildren(f10_arg1)
end

CoD.RTS.HUDVisibility = function (f11_arg0, f11_arg1)
	if f11_arg1.data[1] == 1 then
		CoD.RTS.SquadMarkerDistanceTextVisible = 0
		f11_arg0.rtsOnly:setAlpha(1)
		f11_arg0.hudOnly:setAlpha(0)
		f11_arg0:dispatchEventToChildren({
			name = "hide_dist_text"
		})
		f11_arg0.inTacView = true
	else
		CoD.RTS.SquadMarkerDistanceTextVisible = 1
		f11_arg0.rtsOnly:setAlpha(0)
		f11_arg0.hudOnly:setAlpha(1)
		f11_arg0:dispatchEventToChildren({
			name = "show_dist_text"
		})
		f11_arg0.inTacView = false
	end
end

CoD.RTS.MoveSquadMarker = function (f12_arg0, f12_arg1)
	CoD.RTS.SetSquadMarker(f12_arg0, f12_arg1.data[1], -1, f12_arg1.data[2], f12_arg1.data[3], f12_arg1.data[4])
end

CoD.RTS.NewReticle = function (f13_arg0)
	local f13_local0 = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -32,
		right = 32,
		topAnchor = false,
		bottomAnchor = false,
		top = -32,
		bottom = 32,
		material = RegisterMaterial(f13_arg0),
		zRot = 0
	})
	f13_local0:registerAnimationState("target", {
		leftAnchor = false,
		rightAnchor = false,
		left = -32,
		right = 32,
		topAnchor = false,
		bottomAnchor = false,
		top = -32,
		bottom = 32,
		zRot = 0
	})
	f13_local0:registerAnimationState("target2", {
		leftAnchor = false,
		rightAnchor = false,
		left = -48,
		right = 48,
		topAnchor = false,
		bottomAnchor = false,
		top = -48,
		bottom = 48,
		zRot = -180
	})
	f13_local0:registerAnimationState("target3", {
		leftAnchor = false,
		rightAnchor = false,
		left = -32,
		right = 32,
		topAnchor = false,
		bottomAnchor = false,
		top = -32,
		bottom = 32,
		zRot = -360
	})
	f13_local0:registerEventHandler("transition_complete_target", function (f43_arg0, f43_arg1)
		if not f43_arg1.interrupted then
			f43_arg0:animateToState("target2", CoD.RTSFriendlyAI.ReticleTargetSpeed)
		end
	end)
	f13_local0:registerEventHandler("transition_complete_target2", function (f44_arg0, f44_arg1)
		if not f44_arg1.interrupted then
			f44_arg0:animateToState("target3", CoD.RTSFriendlyAI.ReticleTargetSpeed)
		end
	end)
	f13_local0:registerEventHandler("transition_complete_target3", function (f45_arg0, f45_arg1)
		if not f45_arg1.interrupted then
			f45_arg0:animateToState("target")
		end
	end)
	return f13_local0
end

CoD.RTS.SetSquadMarker = function (f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4, f14_arg5, f14_arg6)
	local f14_local0 = f14_arg0.squads[f14_arg1]
	if f14_local0 then
		if f14_arg3 or f14_arg2 and f14_arg2 >= 0 then
			if not f14_local0.squadMaterialName then
				f14_local0.squadMaterialName = UIExpression.TableLookup(nil, CoD.RTS.DataTable, CoD.RTS.DataTableIndexColumn, f14_local0.pkgIdx, CoD.RTS.DataTableImageColumn)
			end
			if not f14_local0.squadMarker then
				f14_local0.squadMarker = LUI.UIElement.new({
					leftAnchor = false,
					rightAnchor = false,
					left = -CoD.RTS.SquadMarkerWidth / 2,
					right = CoD.RTS.SquadMarkerWidth / 2,
					topAnchor = false,
					bottomAnchor = false,
					top = -CoD.RTS.SquadMarkerHeight,
					bottom = 0
				})
				f14_arg0:addElement(f14_local0.squadMarker)
				f14_local0.squadMarker:registerAnimationState("above_poi", {
					topAnchor = false,
					bottomAnchor = false,
					top = -CoD.RTS.SquadMarkerHeight - 50,
					bottom = -50
				})
				f14_local0.squadMarkerImage = LUI.UIImage.new({
					leftAnchor = false,
					rightAnchor = false,
					left = 0,
					right = 0,
					topAnchor = false,
					bottomAnchor = false,
					top = 0,
					bottom = 0
				})
				f14_local0.squadMarkerImage:registerAnimationState("grow", {
					leftAnchor = true,
					rightAnchor = true,
					left = 0,
					right = 0,
					topAnchor = true,
					bottomAnchor = true,
					top = 0,
					bottom = 0
				})
				f14_local0.squadMarker:addElement(f14_local0.squadMarkerImage)
				local f14_local1 = 15
				f14_local0.squadMarkerDistanceText = LUI.UIText.new()
				f14_local0.squadMarkerDistanceText:setLeftRight(true, true, 0, 0)
				f14_local0.squadMarkerDistanceText:setTopBottom(true, false, -f14_local1, CoD.textSize[CoD.RTS.DistanceFontName] - f14_local1)
				f14_local0.squadMarkerDistanceText:setFont(CoD.fonts[CoD.RTS.DistanceFontName])
				f14_local0.squadMarkerDistanceText:setRGB(CoD.RTS.DistanceBlueColor.r, CoD.RTS.DistanceBlueColor.g, CoD.RTS.DistanceBlueColor.b)
				f14_local0.squadMarkerDistanceText.id = f14_local0.squadMarkerDistanceText.id .. ".SquadMarkerDistanceText"
				f14_local0.squadMarkerDistanceText:registerEventHandler("hide_dist_text", function (Sender, Event)
					Sender:setAlpha(0)
				end)
				f14_local0.squadMarkerDistanceText:registerEventHandler("show_dist_text", function (Sender, Event)
					Sender:setAlpha(1)
				end)
				if CoD.RTS.SquadMarkerDistanceTextVisible == 1 then
					f14_local0.squadMarkerDistanceText:setAlpha(1)
				else
					f14_local0.squadMarkerDistanceText:setAlpha(0)
				end
				f14_local0.squadMarker:addElement(f14_local0.squadMarkerDistanceText)
			end
			f14_local0.squadMarker:setupEntityContainer(f14_arg2, f14_arg3, f14_arg4, f14_arg5)
			f14_local0.squadMarker:setEntityContainerScale(true)
			f14_local0.squadMarker:setEntityContainerScaleClamp(true)
			f14_local0.squadMarkerDistanceText:setupDistanceIndicator()
			if f14_arg6 then
				f14_local0.squadMarker:animateToState("above_poi")
			else
				f14_local0.squadMarker:animateToState("default")
			end
			if f14_arg2 >= 0 then
				local f14_local1 = f14_arg0
				f14_local0.squadMarker:registerEventHandler("rts_remove_ai", function (Sender, Event)
					if Event.data[1] == f14_arg2 then
						f14_local1:processEvent({
							name = "rts_squad_stop_attack",
							data = {
								f14_arg1
							}
						})
					end
				end)
				f14_local0.squadMarkerImage:setImage(RegisterMaterial(f14_local0.squadMaterialName .. "_world_move"))
			else
				f14_local0.squadMarker:registerEventHandler("rts_remove_ai", nil)
				f14_local0.squadMarkerImage:setImage(RegisterMaterial(f14_local0.squadMaterialName .. "_world"))
			end
			f14_local0.squadMarkerImage:animateToState("default")
			f14_local0.squadMarkerImage:animateToState("grow", 250, true, true)
			local f14_local1 = f14_local0.markerEntityNum
			f14_local0.markerEntityNum = f14_arg2
			f14_local0.markerPosX = f14_arg3
			f14_local0.markerPosY = f14_arg4
			f14_local0.markerPosZ = f14_arg5
			if f14_local1 then
				CoD.RTS.UpdateSquadMarkers(f14_arg0, f14_local1)
			end
			if f14_local1 ~= f14_arg2 then
				CoD.RTS.UpdateSquadMarkers(f14_arg0, f14_arg2)
			end
		elseif f14_local0.squadMarker then
			f14_local0.squadMarker:close()
			f14_local0.squadMarker = nil
			f14_local0.squadMarkerImage = nil
			f14_local0.squadMarkerDistanceText = nil
			local f14_local1 = f14_local0.markerEntityNum
			f14_local0.markerEntityNum = nil
			if f14_local1 >= 0 then
				CoD.RTS.UpdateSquadMarkers(f14_arg0, f14_local1)
			end
		end
	end
end

CoD.RTS.OffsetSquadMarkers = function (f15_arg0)
	table.sort(f15_arg0, function (f49_arg0, f49_arg1)
		return f49_arg0.squadNumber < f49_arg1.squadNumber
	end)
	local f15_local0 = #f15_arg0
	for f15_local4, f15_local5 in ipairs(f15_arg0) do
		local f15_local6 = CoD.RTS.SquadMarkerWidth * (f15_local4 - 1 - (f15_local0 - 1) / 2)
		f15_local5.squadMarker:registerAnimationState("offset", {
			leftAnchor = false,
			rightAnchor = false,
			left = f15_local6 - CoD.RTS.SquadMarkerWidth / 2,
			right = f15_local6 + CoD.RTS.SquadMarkerWidth / 2
		})
		f15_local5.squadMarker:animateToState("offset")
	end
end

CoD.RTS.UpdateSquadMarkers = function (f16_arg0, f16_arg1)
	if 0 <= f16_arg1 then
		local f16_local0 = {}
		for f16_local4, f16_local5 in pairs(f16_arg0.squads) do
			if f16_local5.markerEntityNum == f16_arg1 then
				table.insert(f16_local0, f16_local5)
			end
		end
		CoD.RTS.OffsetSquadMarkers(f16_local0)
	else
		local f16_local0 = {}
		for f16_local4, f16_local5 in pairs(f16_arg0.squads) do
			if not f16_local0[f16_local4] and f16_local5.markerEntityNum == f16_arg1 then
				local f16_local6 = {}
				f16_local0[f16_local4] = true
				table.insert(f16_local6, f16_local5)
				for f16_local10, f16_local11 in pairs(f16_arg0.squads) do
					if not f16_local0[f16_local10] and f16_local11.markerEntityNum == f16_arg1 and f16_local5.markerPosX == f16_local11.markerPosX and f16_local5.markerPosY == f16_local11.markerPosY and f16_local5.markerPosZ == f16_local11.markerPosZ then
						f16_local0[f16_local10] = true
						table.insert(f16_local6, f16_local11)
					end
				end
				CoD.RTS.OffsetSquadMarkers(f16_local6)
			end
		end
	end
end

CoD.RTS.SquadStartAttack = function (f17_arg0, f17_arg1)
	local f17_local0 = f17_arg1.data[1]
	local f17_local1 = f17_arg1.data[2]
	local f17_local2 = f17_arg1.data[3]
	if f17_local2 then
		CoD.RTS.SetSquadMarker(f17_arg0, f17_local0, f17_local1, 0, 0, f17_local2, f17_arg1.name == "rts_squad_start_attack_poi")
	else
		CoD.RTS.SetSquadMarker(f17_arg0, f17_local0, f17_local1, nil, nil, nil, f17_arg1.name == "rts_squad_start_attack_poi")
	end
end

CoD.RTS.SquadStopAttack = function (f18_arg0, f18_arg1)
	CoD.RTS.SetSquadMarker(f18_arg0, f18_arg1.data[1])
end

CoD.RTS.AI_Remove = function (f19_arg0, f19_arg1)
	if f19_arg0.entityNum ~= f19_arg1.data[1] then
		return 
	else
		f19_arg0:dispatchEventToParent({
			name = "rts_update_overlord_help"
		})
		f19_arg0:close()
	end
end

CoD.RTS.TargetEnemy = function (f20_arg0, f20_arg1)
	local f20_local0 = f20_arg1.data[1]
	local Widget = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -1,
		right = 1,
		topAnchor = false,
		bottomAnchor = false,
		top = -1,
		bottom = 1
	})
	Widget:setupEntityContainer(f20_local0)
	Widget.entityNum = f20_local0
	Widget:registerEventHandler("rts_deselect_enemy", CoD.RTS.AI_Remove)
	Widget:registerEventHandler("rts_deselect_poi", CoD.RTS.AI_Remove)
	Widget:registerEventHandler("rts_remove_ai", CoD.RTS.AI_Remove)
	Widget:registerEventHandler("rts_target_enemy", function (f50_arg0, f50_arg1)
		if f50_arg0.entityNum == f50_arg1.data[1] then
			return 
		else
			f50_arg0:close()
		end
	end)
	Widget:registerEventHandler("rts_target_poi", Widget.m_eventHandlers.rts_target_enemy)
	f20_arg0:addElement(Widget)
	if f20_arg1.name == "rts_target_enemy" then
		Widget:dispatchEventToParent({
			name = "rts_update_overlord_help",
			text = Engine.Localize("SO_RTS_TACTICAL_INSTRUCTION_ENEMY")
		})
	elseif f20_arg1.name == "rts_target_poi" then
		Widget:dispatchEventToParent({
			name = "rts_update_overlord_help",
			text = Engine.Localize("SO_RTS_TACTICAL_INSTRUCTION_POI")
		})
	else
		Widget:dispatchEventToParent({
			name = "rts_update_overlord_help"
		})
	end
	local f20_local2 = CoD.RTS.NewReticle("hud_rts_target_enemy")
	Widget:addElement(f20_local2)
	f20_local2:animateToState("target")
	f20_arg0:dispatchEventToChildren(f20_arg1)
end

local f0_local0 = function (f21_arg0, f21_arg1)
	f21_arg0:beginAnimation("turn_red", f21_arg1)
	f21_arg0:setRGB(1, 0, 0)
end

local f0_local1 = function (f22_arg0, f22_arg1)
	f22_arg0:beginAnimation("turn_text_default", f22_arg1)
	f22_arg0:setRGB(CoD.DefaultTextColor.r, CoD.DefaultTextColor.g, CoD.DefaultTextColor.b)
end

CoD.RTS.TimeLeft = function (f23_arg0, f23_arg1)
	local f23_local0 = 0
	if f23_arg1.data then
		f23_local0 = f23_arg1.data[1]
		f23_arg0.timeLeft:setTimeLeft(f23_local0)
		local f23_local1 = "SO_RTS_MISSION_TIME_REMAINING_CAPS"
		if f23_arg1.data[2] ~= nil and f23_arg1.data[2] ~= -1 then
			f23_local1 = Engine.GetIString(f23_arg1.data[2], "CS_LOCALIZED_STRINGS")
		end
		if f23_arg1.data[3] ~= nil then
			f23_arg0.timeLeft:addTimedParentEvent(120000, "time_remaining_2_min")
			f23_arg0.timeLeft:addTimedParentEvent(60000, "time_remaining_1_min")
		end
		local f23_local2 = Engine.Localize(f23_local1)
		if f23_arg0.timerHeader then
			f23_arg0.timerHeader:setText(f23_local2)
			local f23_local3, f23_local4, f23_local5, f23_local6 = GetTextDimensions(f23_local2, CoD.fonts.Condensed, CoD.textSize.Condensed)
			local f23_local7 = math.max(f23_local5 - f23_local3 + CoD.RTS.TimerBracketWidth * 2 + 5, CoD.RTS.MinimumTimerSize)
			f23_arg0.timerBackground:setLeftRight(false, false, -f23_local7 / 2, f23_local7 / 2)
		else
			f23_arg0.timerBackground:setLeftRight(false, false, -CoD.RTS.MinimumTimerSize / 2, CoD.RTS.MinimumTimerSize / 2)
		end
		if 0 < f23_local0 then
			f23_arg0.gameTimerContainer:setAlpha(1)
			f23_arg0.timeLeft:alternateStates(5000, f0_local0, f0_local1, 500, 500)
		else
			f23_arg0.gameTimerContainer:setAlpha(0)
		end
	else
		f23_arg0.timerHeader:setAlpha(0)
		f23_arg0.timeLeft:setAlpha(0)
		f23_arg0.timerBackground:setAlpha(0)
	end
end

CoD.RTS.PredatorHUD = function (f24_arg0, f24_arg1)
	if f24_arg1.data[1] == 1 then
		f24_arg0:dispatchEventToParent({
			name = "hud_update_vehicle",
			vehicleType = "drone_claw_rts"
		})
	else
		f24_arg0:dispatchEventToParent({
			name = "hud_update_vehicle"
		})
	end
end

CoD.RTS.UpdateHintText = function (f25_arg0, f25_arg1)
	if not f25_arg1 then
		f25_arg0.rtsHintText:setText("")
		return 
	elseif f25_arg1.data == nil then
		f25_arg0.rtsHintText:setText("")
		return 
	end
	f25_arg0.rtsHintText:setText(Engine.Localize(Engine.GetIString(f25_arg1.data[1], "CS_LOCALIZED_STRINGS")))
	local f25_local0 = f25_arg1.data[2]
	if f25_local0 then
		f25_arg0:addElement(LUI.UITimer.new(f25_local0 * 1000, {
			name = "rts_hint_text_duration"
		}, true, f25_arg0.rtsHintText))
	end
end

CoD.RTS.HintTextDuration = function (f26_arg0, f26_arg1)
	f26_arg0:setText("")
end

CoD.RTS.ControllerChanged = function (f27_arg0, f27_arg1)
	if CoD.isWIIU then
		if UIExpression.GetControllerType(f27_arg1.controller) == "remote" then
			f27_arg0.reticle:setAlpha(0)
		else
			f27_arg0.reticle:setAlpha(1)
		end
	end
	f27_arg0:dispatchEventToChildren(f27_arg1)
end

CoD.RTS.UpdateVisibility = function (f28_arg0, f28_arg1)
	local f28_local0 = f28_arg1.controller
	if UIExpression.IsVisibilityBitSet(f28_local0, CoD.BIT_HUD_VISIBLE) == 1 and UIExpression.IsVisibilityBitSet(f28_local0, CoD.BIT_UI_ACTIVE) == 0 then
		if f28_arg0.visible ~= true then
			f28_arg0:setAlpha(1)
			f28_arg0.visible = true
			if f28_arg0.inTacView then
				f28_arg0:dispatchEventToRoot({
					name = "hud_hide_shadesHud"
				})
			end
		end
	elseif f28_arg0.visible == true then
		f28_arg0:setAlpha(0)
		f28_arg0.visible = nil
	end
	f28_arg0:dispatchEventToChildren(f28_arg1)
end

local f0_local2 = function (f29_arg0, f29_arg1)
	Engine.SetUIActive(f29_arg1.controller, false)
	Engine.PauseGame(f29_arg1.controller, false)
	Engine.ClearUIMenuState(f29_arg1.controller)
	return true
end

local f0_local3 = function (f30_arg0)
	if f30_arg0 ~= nil then
		if f30_arg0.rts ~= nil then
			local f30_local0 = f30_arg0.rts:getParent()
			if f30_local0 ~= nil then
				f30_local0:registerEventHandler("open_ingame_menu", CoD.HUD.OpenInGameMenu)
			end
		end
		CoD.Menu.close(f30_arg0)
	end
end

CoD.RTS.MissionFailedMenu = function (f31_arg0, f31_arg1)
	f31_arg0.rtsOnly:setAlpha(0)
	f31_arg0.hudOnly:setAlpha(0)
	f31_arg0.shakeableArea:setAlpha(0)
	CoD.RTS.SquadMarkerDistanceTextVisible = 0
	local f31_local0 = false
	if f31_arg1.data ~= nil and f31_arg1.data[1] ~= nil then
		f31_local0 = f31_arg1.data[1] == 1
	end
	local f31_local1 = LUI.createMenu.RTSFailedMenu(f31_arg1.controller, f31_local0)
	f31_local1.rts = f31_arg0
	f31_arg0:addElement(f31_local1)
	local f31_local2 = f31_arg0:getParent()
	f31_local2:registerEventHandler("open_ingame_menu", f0_local2)
	f31_local1.close = f0_local3
	f31_arg0.visible = nil
end

CoD.RTS.TutorialCompleteMenu = function (f32_arg0, f32_arg1)
	f32_arg0.rtsOnly:setAlpha(0)
	f32_arg0.hudOnly:setAlpha(0)
	f32_arg0.shakeableArea:setAlpha(0)
	CoD.RTS.SquadMarkerDistanceTextVisible = 0
	local f32_local0 = LUI.createMenu.RTSTutorialMenu(f32_arg1.controller)
	f32_local0.rts = f32_arg0
	f32_arg0:addElement(f32_local0)
	local f32_local1 = f32_arg0:getParent()
	f32_local1:registerEventHandler("open_ingame_menu", f0_local2)
	f32_local0.close = f0_local3
	f32_arg0.visible = nil
end

CoD.RTS.HideMissionResult = function (f33_arg0, f33_arg1)
	local f33_local0 = f33_arg0:getParent()
	if f33_local0 ~= nil and f33_local0.missionResult ~= nil then
		f33_local0.missionResult:close()
	end
end

CoD.RTS.MissionSuccess = function (f34_arg0, f34_arg1)
	local f34_local0 = CoD.RTSResultPopup.new(true)
	local f34_local1 = f34_arg0:getParent()
	if f34_local1 ~= nil then
		CoD.RTS.HideMissionResult(f34_arg0)
		f34_local1.missionResult = f34_local0
		f34_local1:addElement(f34_local0)
	end
end

CoD.RTS.MissionFailed = function (f35_arg0, f35_arg1)
	local f35_local0 = CoD.RTSResultPopup.new(false)
	local f35_local1 = f35_arg0:getParent()
	if f35_local1 ~= nil then
		CoD.RTS.HideMissionResult(f35_arg0)
		f35_local1.missionResult = f35_local0
		f35_local1:addElement(f35_local0)
	end
end

CoD.RTS.TwoMinutesRemaining = function (f36_arg0, f36_arg1)

end

CoD.RTS.OneMinuteRemaining = function (f37_arg0, f37_arg1)

end

CoD.RTS.TimeRemainingWarning = function (f38_arg0, f38_arg1)
	if not f38_arg0.timeWarning then
		return 
	else
		f38_arg0.timeWarning:setText(f38_arg1)
		f38_arg0.timeWarning:beginAnimation("fade_in", 1000)
		f38_arg0.timeWarning:setAlpha(1)
		f38_arg0:addElement(LUI.UITimer.new(7500, "hide_time_remaining", true, f38_arg0))
	end
end

CoD.RTS.HideTimeRemainingWarning = function (f39_arg0, f39_arg1)
	if not f39_arg0.timeWarning then
		return 
	else
		f39_arg0.timeWarning:beginAnimation("fade_out", 1000)
		f39_arg0.timeWarning:setAlpha(0)
	end
end

CoD.RTS.SetOverlordHelpText = function (f40_arg0, f40_arg1)
	if not f40_arg0.rtsOnly or not f40_arg0.rtsOnly.tacticalInstructions then
		return 
	elseif f40_arg1.text then
		f40_arg0.rtsOnly.tacticalInstructions:setText(f40_arg1.text)
	else
		f40_arg0.rtsOnly.tacticalInstructions:setText("")
	end
end

local f0_local4 = function (f41_arg0, f41_arg1)
	local f41_local0 = UIExpression.GetControllerType(f41_arg1.controller)
	if f41_local0 == "remote" or f41_local0 == "classic" then
		f41_arg0:setText(f41_arg0.carouselText)
	else
		f41_arg0:setText(f41_arg0.dpadText)
	end
	f41_arg0:dispatchEventToChildren(f41_arg1)
end

CoD.RTS.SetupDpadOrCarouselText = function (f42_arg0, f42_arg1, f42_arg2)
	if CoD.isWIIU then
		f42_arg0.dpadText = Engine.Localize(f42_arg1)
		f42_arg0.carouselText = Engine.Localize(f42_arg2)
		f42_arg0:registerEventHandler("controller_changed", f0_local4)
		f42_arg0:processEvent({
			name = "controller_changed",
			controller = 0
		})
	end
end

