require("T6.HUD.SpectateTeamCardTwoTeam")
require("T6.CountdownTimer")
CoD.SpectateGameStatusTwoTeam = InheritFrom(LUI.UIElement)
CoD.SpectateGameStatusTwoTeam.GameTimerWidth = 128
CoD.SpectateGameStatusTwoTeam.GameTimerRealWidth = 84
CoD.SpectateGameStatusTwoTeam.GameTimerHeight = 128
CoD.SpectateGameStatusTwoTeam.Padding = 0
CoD.SpectateGameStatusTwoTeam.DockPadding = 40
CoD.SpectateGameStatusTwoTeam.Width = CoD.SpectateGameStatusTwoTeam.GameTimerRealWidth + CoD.SpectateTeamCardTwoTeam.RealWidth * 2
CoD.SpectateGameStatusTwoTeam.Font = CoD.fonts.ExtraSmall
CoD.SpectateGameStatusTwoTeam.FontSize = CoD.textSize.ExtraSmall
CoD.SpectateGameStatusTwoTeam.GameTimerFont = CoD.fonts.Condensed
CoD.SpectateGameStatusTwoTeam.GameTimerFontSize = CoD.textSize.Condensed
CoD.SpectateGameStatusTwoTeam.UnlimitedGameTimerFontSize = CoD.textSize.Condensed * 0.7
CoD.SpectateGameStatusTwoTeam.Height = CoD.SpectateGameStatusTwoTeam.FontSize + CoD.SpectateTeamCardTwoTeam.Height
CoD.SpectateGameStatusTwoTeam.SetupGameTimer = function (f1_arg0)
	if Engine.GetGametypeSetting("timeLimit") == 0 then
		local f1_local0 = LUI.UIText.new()
		f1_local0:setLeftRight(false, false, -30, 30)
		f1_local0:setTopBottom(true, false, 5, CoD.SpectateGameStatusTwoTeam.UnlimitedGameTimerFontSize + 5)
		f1_local0:setFont(CoD.SpectateGameStatusTwoTeam.GameTimerFont)
		f1_local0:setAlignment(LUI.Alignment.Center)
		f1_local0:setRGB(0.8, 0.8, 0.8)
		f1_local0:setAlpha(1)
		f1_local0:setText(Engine.Localize("MPUI_UNLIMITED_TIME_CAPS"))
		return f1_local0
	else
		local f1_local0 = CoD.GameTimer.new()
		f1_local0:setLeftRight(true, true, 0, 0)
		f1_local0:setTopBottom(true, false, 10, CoD.SpectateGameStatusTwoTeam.GameTimerFontSize + 10)
		f1_local0:setRGB(0.7, 0.7, 0.7)
		f1_local0:setAlpha(1)
		f1_local0.VSTitle = nil
		return f1_local0
	end
end

CoD.SpectateGameStatusTwoTeam.UpdateScore = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	local f2_local0 = nil
	if f2_arg1 == CoD.TEAM_ALLIES then
		f2_arg0.m_alliesTeamCard:populate(CoD.TEAM_ALLIES, f2_arg2)
		f2_local0 = f2_arg0.m_alliesTeamCard
	else
		f2_arg0.m_axisTeamCard:populate(CoD.TEAM_AXIS, f2_arg2)
		f2_local0 = f2_arg0.m_axisTeamCard
	end
	if f2_arg3 == true and f2_local0 ~= nil then
		f2_local0:processEvent({
			name = "spectate_teamstatuscard_pulse"
		})
	end
end

CoD.SpectateGameStatusTwoTeam.UpdateScores = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg1.teams
	for f3_local1 = 1, 2, 1 do
		local f3_local4 = false
		if f3_arg1.shouldPulse == true and f3_local0[f3_local1].team == f3_arg0.m_selectedTeam then
			f3_local4 = true
		end
		CoD.SpectateGameStatusTwoTeam.UpdateScore(f3_arg0, f3_local0[f3_local1].team, f3_local0[f3_local1].score, f3_local4)
	end
end

CoD.SpectateGameStatusTwoTeam.PlayerSelected = function (f4_arg0, f4_arg1)
	f4_arg0.m_selectedTeam = f4_arg1.info.teamID
	f4_arg1.shouldPulse = true
	CoD.SpectateGameStatusTwoTeam.UpdateScores(f4_arg0, f4_arg1)
end

CoD.SpectateGameStatusTwoTeam.Dock = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1.safeX + f5_arg1.viewportWidth / 2 - CoD.SpectateGameStatusTwoTeam.Width / 2
	local f5_local1 = f5_arg1.safeY - CoD.SpectateGameStatusTwoTeam.Height - CoD.SpectateGameStatusTwoTeam.DockPadding
	f5_arg0:beginAnimation("move", 200)
	f5_arg0:setLeftRight(true, false, f5_local0, f5_local0 + CoD.SpectateGameStatusTwoTeam.Width)
	f5_arg0:setTopBottom(true, false, f5_local1, f5_local1 + CoD.SpectateGameStatusTwoTeam.Height)
end

CoD.SpectateGameStatusTwoTeam.Undock = function (f6_arg0, f6_arg1)
	f6_arg0:beginAnimation("move", 200)
	f6_arg0:setLeftRight(false, false, -(CoD.SpectateGameStatusTwoTeam.Width / 2), CoD.SpectateGameStatusTwoTeam.Width / 2)
	f6_arg0:setTopBottom(true, false, 0, CoD.SpectateGameStatusTwoTeam.Height)
end

CoD.SpectateGameStatusTwoTeam.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -(CoD.SpectateGameStatusTwoTeam.Width / 2), CoD.SpectateGameStatusTwoTeam.Width / 2)
	Widget:setTopBottom(true, false, 0, CoD.SpectateGameStatusTwoTeam.Height)
	Widget:setClass(CoD.SpectateGameStatusTwoTeam)
	Widget.m_ownerController = HudRef
	Widget.m_teamCount = InstanceRef
	Widget.m_selectedTeam = nil
	Widget.m_alliesTeamCard = nil
	Widget.m_axisTeamCard = nil
	local f7_local1 = LUI.UIImage.new()
	f7_local1:setLeftRight(true, true, 32, -32)
	f7_local1:setTopBottom(true, false, 0, 32)
	f7_local1:setImage(RegisterMaterial("hud_shoutcasting_bar_stretch"))
	f7_local1:setAlpha(1)
	local f7_local2 = LUI.UIImage.new()
	f7_local2:setLeftRight(true, false, 32, 0)
	f7_local2:setTopBottom(true, false, 0, 32)
	f7_local2:setImage(RegisterMaterial("hud_shoutcasting_bar_end"))
	f7_local2:setAlpha(1)
	local f7_local3 = LUI.UIImage.new()
	f7_local3:setLeftRight(false, true, -32, 0)
	f7_local3:setTopBottom(true, false, 0, 32)
	f7_local3:setImage(RegisterMaterial("hud_shoutcasting_bar_end"))
	f7_local3:setAlpha(1)
	local f7_local4 = LUI.UIText.new()
	f7_local4:setLeftRight(true, true, 0, 0)
	f7_local4:setTopBottom(true, false, 5, CoD.SpectateGameStatusTwoTeam.FontSize + 5)
	f7_local4:setFont(CoD.SpectateGameStatusTwoTeam.Font)
	f7_local4:setAlignment(LUI.Alignment.Center)
	f7_local4:setRGB(0.6, 0.6, 0.6)
	f7_local4:setAlpha(1)
	local f7_local5 = {}
	local f7_local6 = Engine.Localize(UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, Dvar.ui_gametype:get(), 7))
	local f7_local7 = " - "
	local f7_local8 = Engine.Localize(UIExpression.TableLookup(nil, CoD.mapsTable, 0, Dvar.ui_mapname:get(), 3))
	f7_local5 = f7_local6
	f7_local6 = Engine.GetGametypeSetting("roundLimit")
	f7_local7 = Engine.GetRoundsPlayed(HudRef)
	if f7_local7 ~= nil and f7_local6 ~= 1 then
		table.insert(f7_local5, " - ")
		if f7_local6 == 0 then
			table.insert(f7_local5, Engine.Localize("MPUI_ROUND_X", f7_local7 + 1))
		else
			table.insert(f7_local5, Engine.Localize("MPUI_ROUND_X_OF_Y", f7_local7 + 1, f7_local6))
		end
	end
	f7_local4:setText(table.concat(f7_local5))
	f7_local8 = LUI.UIImage.new()
	f7_local8:setLeftRight(true, true, 0, 0)
	f7_local8:setTopBottom(true, true, 0, 0)
	f7_local8:setImage(RegisterMaterial("hud_shoutcasting_time_box"))
	f7_local8:setAlpha(1)
	local f7_local9 = CoD.SpectateGameStatusTwoTeam.SetupGameTimer(HudRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -(CoD.SpectateGameStatusTwoTeam.GameTimerWidth / 2), CoD.SpectateGameStatusTwoTeam.GameTimerWidth / 2)
	Widget:setTopBottom(true, false, 0, CoD.SpectateGameStatusTwoTeam.GameTimerHeight)
	Widget:addElement(f7_local8)
	Widget:addElement(f7_local9)
	Widget.statusList = LUI.UIHorizontalList.new()
	Widget.statusList:setLeftRight(true, true, 0, 0)
	Widget.statusList:setTopBottom(true, true, 32, 0)
	Widget.statusList:setSpacing(-20)
	Widget.statusList:setAlignment(LUI.Alignment.Center)
	Widget.m_alliesTeamCard = CoD.SpectateTeamCardTwoTeam.new(HudRef, false)
	Widget.m_alliesTeamCard:populate(CoD.TEAM_ALLIES, "0")
	Widget.m_axisTeamCard = CoD.SpectateTeamCardTwoTeam.new(HudRef, true)
	Widget.m_axisTeamCard:populate(CoD.TEAM_AXIS, "0")
	Widget.modeStatus = CoD.SpectateGameModeStatus.GetMenu(HudRef, CoD.SpectateGameStatusTwoTeam.Height, CoD.SpectateGameStatusTwoTeam.GameTimerWidth - 12)
	Widget.statusList:addElement(Widget.m_alliesTeamCard)
	Widget.statusList:addElement(Widget)
	Widget.statusList:addElement(Widget.m_axisTeamCard)
	Widget:addElement(f7_local2)
	Widget:addElement(f7_local1)
	Widget:addElement(f7_local3)
	Widget:addElement(f7_local4)
	Widget:addElement(Widget.statusList)
	if Widget.modeStatus ~= nil then
		Widget.modeStatus:processEvent({
			name = "initialize_game_mode_status",
			controller = HudRef
		})
		Widget:addElement(Widget.modeStatus)
	end
	return Widget
end

CoD.SpectateGameStatusTwoTeam:registerEventHandler("hud_update_scores", CoD.SpectateGameStatusTwoTeam.UpdateScores)
CoD.SpectateGameStatusTwoTeam:registerEventHandler("spectate_player_selected", CoD.SpectateGameStatusTwoTeam.PlayerSelected)
CoD.SpectateGameStatusTwoTeam:registerEventHandler("spectate_dock", CoD.SpectateGameStatusTwoTeam.Dock)
CoD.SpectateGameStatusTwoTeam:registerEventHandler("spectate_undock", CoD.SpectateGameStatusTwoTeam.Undock)
