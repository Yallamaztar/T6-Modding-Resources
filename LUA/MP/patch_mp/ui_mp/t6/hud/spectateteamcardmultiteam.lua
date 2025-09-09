CoD.SpectateTeamCardMultiTeam = InheritFrom(LUI.UIElement)
CoD.SpectateTeamCardMultiTeam.Height = 64
CoD.SpectateTeamCardMultiTeam.Width = 256
CoD.SpectateTeamCardMultiTeam.RealWidth = 179
CoD.SpectateTeamCardMultiTeam.ScoreFont = CoD.fonts.Big
CoD.SpectateTeamCardMultiTeam.ScoreFontSize = CoD.textSize.Big * 0.9
CoD.SpectateTeamCardMultiTeam.ScoreWidth = 115
CoD.SpectateTeamCardMultiTeam.PositionFont = CoD.fonts.Default
CoD.SpectateTeamCardMultiTeam.PositionFontSize = CoD.textSize.Default
CoD.SpectateTeamCardMultiTeam.PositionWidth = 40
CoD.SpectateTeamCardMultiTeam.IconWidth = 40
CoD.SpectateTeamCardMultiTeam.IconAreaWidth = CoD.SpectateTeamCardMultiTeam.PositionWidth + CoD.SpectateTeamCardMultiTeam.IconWidth
CoD.SpectateTeamCardMultiTeam.Padding = -12
CoD.SpectateTeamCardMultiTeam.IconDimension = 50
CoD.SpectateTeamCardMultiTeam.Hide = function (f1_arg0, f1_arg1)
	f1_arg0:setAlpha(0)
end

CoD.SpectateTeamCardMultiTeam.Show = function (f2_arg0, f2_arg1)
	f2_arg0:setAlpha(1)
end

CoD.SpectateTeamCardMultiTeam.Pulse = function (f3_arg0)
	local f3_local0, f3_local1, f3_local2 = nil
	if f3_arg0.m_isClient == true then
		f3_local0 = 0.6
		f3_local1 = 0.6
		f3_local2 = 0.6
	else
		local f3_local3, f3_local4, f3_local5 = CoD.SpectateHUD.GetTeamColor(f3_arg0.m_team)
		f3_local2 = f3_local5
		f3_local1 = f3_local4
		f3_local0 = f3_local3
	end
	f3_arg0.bgPulse:completeAnimation()
	f3_arg0.bgPulse:setRGB(f3_local0, f3_local1, f3_local2)
	f3_arg0.bgPulse:setAlpha(0.5)
	f3_arg0.bgPulse:beginAnimation("pulse_out", 750)
	f3_arg0.bgPulse:setAlpha(0)
end

function SpectateTeamCardMultiTeam_TeamPosToText(f4_arg0)
	local f4_local0 = tonumber(f4_arg0)
	if f4_local0 ~= nil and f4_local0 >= 1 and f4_local0 <= 12 then
		return Engine.Localize("MPUI_POSITION_" .. f4_local0)
	else
		return ""
	end
end

CoD.SpectateTeamCardMultiTeam.Clear = function (f5_arg0)
	f5_arg0.teamIcon:setAlpha(0)
	f5_arg0.playerIcon:setAlpha(0)
	f5_arg0.position:setText("")
	f5_arg0.positionSup:setText("")
	f5_arg0.score:setText("")
end

CoD.SpectateTeamCardMultiTeam.Populate = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	local f6_local0 = nil
	if f6_arg4 == true then
		local f6_local1 = Engine.GetCalloutPlayerData(f6_arg0.m_ownerController, f6_arg1)
		if f6_local1 ~= nil then
			f6_arg0.playerIcon:setAlpha(1)
			f6_arg0.playerIcon:setupPlayerEmblemServer(f6_local1.playerClientNum)
			f6_arg0.teamIcon:setAlpha(0)
		end
	else
		f6_arg0.playerIcon:setAlpha(0)
		f6_local0 = CoD.SpectateHUD.GetTeamIcon(f6_arg1)
		if f6_local0 ~= nil then
			f6_arg0.teamIcon:setImage(f6_local0)
			f6_arg0.teamIcon:setAlpha(1)
		else
			f6_arg0.teamIcon:setAlpha(0)
		end
	end
	f6_arg0.m_team = f6_arg1
	f6_arg0.position:setText(SpectatePlayerInfo_TeamPosToText(f6_arg2))
	f6_arg0.positionSup:setText(SpectatePlayerInfo_TeamPosToSuperscript(f6_arg2))
	f6_arg0.score:setText(f6_arg3)
end

CoD.SpectateTeamCardMultiTeam.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -(CoD.SpectateTeamCardMultiTeam.Width / 2), CoD.SpectateTeamCardMultiTeam.Width / 2)
	Widget:setTopBottom(true, false, 0, CoD.SpectateTeamCardMultiTeam.Height)
	Widget:setClass(CoD.SpectateTeamCardMultiTeam)
	Widget.m_ownerController = HudRef
	Widget.m_isClient = InstanceRef
	local f7_local1 = Dvar.loc_language:get()
	if f7_local1 == CoD.LANGUAGE_FULLJAPANESE or f7_local1 == CoD.LANGUAGE_JAPANESE then
		CoD.SpectateTeamCardMultiTeam.ScoreFontSize = CoD.textSize.Big * 0.7
	end
	local f7_local2 = LUI.UIImage.new()
	f7_local2:setTopBottom(true, true, 0, 0)
	f7_local2:setLeftRight(true, true, 0, 0)
	f7_local2:setImage(RegisterMaterial("hud_shoutcasting_boxes"))
	f7_local2:setAlpha(1)
	Widget.bgPulse = LUI.UIImage.new()
	Widget.bgPulse:setTopBottom(true, true, 0, 0)
	Widget.bgPulse:setLeftRight(true, true, 0, 0)
	Widget.bgPulse:setImage(RegisterMaterial("hud_shoutcasting_boxes_glow"))
	Widget.bgPulse:setAlpha(0)
	Widget.score = LUI.UIText.new()
	Widget.score:setLeftRight(true, true, 0, 0)
	Widget.score:setTopBottom(false, false, -(CoD.SpectateTeamCardMultiTeam.ScoreFontSize / 2), CoD.SpectateTeamCardMultiTeam.ScoreFontSize / 2)
	Widget.score:setFont(CoD.SpectateTeamCardTwoTeam.ScoreFont)
	Widget.score:setAlignment(LUI.Alignment.Center)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -75, -4)
	Widget:setTopBottom(true, false, 2, 55)
	Widget:addElement(Widget.score)
	Widget.position = LUI.UIText.new()
	Widget.position:setLeftRight(true, false, 0, CoD.SpectateTeamCardMultiTeam.PositionWidth / 2)
	Widget.position:setTopBottom(false, false, -(CoD.SpectateTeamCardMultiTeam.PositionFontSize / 2), CoD.SpectateTeamCardMultiTeam.PositionFontSize / 2)
	Widget.position:setFont(CoD.SpectateTeamCardMultiTeam.PositionFont)
	Widget.position:setAlignment(LUI.Alignment.Right)
	Widget.positionSup = LUI.UIText.new()
	Widget.positionSup:setLeftRight(true, true, CoD.SpectateTeamCardMultiTeam.PositionWidth / 2, 0)
	Widget.positionSup:setTopBottom(true, false, 10, 28)
	Widget.positionSup:setFont(CoD.SpectateTeamCardMultiTeam.PositionFont)
	Widget.positionSup:setAlignment(LUI.Alignment.Left)
	local f7_local4 = nil
	if InstanceRef == true then
		f7_local4 = CoD.SpectateTeamCardMultiTeam.IconDimension - 5
	else
		f7_local4 = CoD.SpectateTeamCardMultiTeam.IconDimension
	end
	local f7_local5 = CoD.SpectateTeamCardMultiTeam.PositionWidth + CoD.SpectateTeamCardMultiTeam.IconWidth / 2 - f7_local4 / 2
	Widget.teamIcon = LUI.UIImage.new()
	Widget.teamIcon:setLeftRight(true, false, f7_local5, f7_local5 + f7_local4)
	Widget.teamIcon:setTopBottom(false, false, -(f7_local4 / 2), f7_local4 / 2)
	Widget.teamIcon:setAlpha(0)
	Widget.playerIcon = LUI.UIElement.new()
	Widget.playerIcon:setLeftRight(true, false, f7_local5, f7_local5 + f7_local4)
	Widget.playerIcon:setTopBottom(false, false, -(f7_local4 / 2), f7_local4 / 2)
	Widget.playerIcon:setAlpha(0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -174, -88)
	Widget:setTopBottom(true, false, 2, 55)
	Widget:addElement(Widget.playerIcon)
	Widget:addElement(Widget.teamIcon)
	Widget:addElement(Widget.position)
	Widget:addElement(Widget.positionSup)
	Widget:addElement(f7_local2)
	Widget:addElement(Widget.bgPulse)
	Widget:addElement(Widget)
	Widget:addElement(Widget)
	Widget.m_team = nil
	Widget.populate = CoD.SpectateTeamCardMultiTeam.Populate
	Widget.clear = CoD.SpectateTeamCardMultiTeam.Clear
	return Widget
end

CoD.SpectateTeamCardMultiTeam:registerEventHandler("spectate_teamstatuscard_pulse", CoD.SpectateTeamCardMultiTeam.Pulse)
