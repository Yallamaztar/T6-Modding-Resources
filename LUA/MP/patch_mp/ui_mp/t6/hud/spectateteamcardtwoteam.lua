CoD.SpectateTeamCardTwoTeam = InheritFrom(LUI.UIElement)
CoD.SpectateTeamCardTwoTeam.Height = 64
CoD.SpectateTeamCardTwoTeam.Width = 256
CoD.SpectateTeamCardTwoTeam.RealWidth = 179
CoD.SpectateTeamCardTwoTeam.ScoreFont = CoD.fonts.Big
CoD.SpectateTeamCardTwoTeam.ScoreFontSize = CoD.textSize.Big * 0.9
CoD.SpectateTeamCardTwoTeam.IconDimension = CoD.SpectateTeamCardTwoTeam.Height
CoD.SpectateTeamCardTwoTeam.Hide = function (f1_arg0, f1_arg1)
	f1_arg0:setAlpha(0)
end

CoD.SpectateTeamCardTwoTeam.Pulse = function (f2_arg0)
	local f2_local0, f2_local1, f2_local2 = CoD.SpectateHUD.GetTeamColor(f2_arg0.m_team)
	f2_arg0.bgPulse:completeAnimation()
	f2_arg0.bgPulse:setRGB(f2_local0, f2_local1, f2_local2)
	f2_arg0.bgPulse:setAlpha(0.5)
	f2_arg0.bgPulse:beginAnimation("pulse_out", 750)
	f2_arg0.bgPulse:setAlpha(0)
end

CoD.SpectateTeamCardTwoTeam.Populate = function (f3_arg0, f3_arg1, f3_arg2)
	f3_arg0.m_team = f3_arg1
	local f3_local0 = CoD.SpectateHUD.GetTeamIcon(f3_arg1)
	if f3_local0 ~= nil then
		f3_arg0.icon:setImage(f3_local0)
		f3_arg0.icon:setAlpha(1)
	else
		f3_arg0.icon:setAlpha(0)
	end
	f3_arg0.score:setText(f3_arg2)
end

CoD.SpectateTeamCardTwoTeam.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -CoD.SpectateTeamCardTwoTeam.Width, 0)
	Widget:setTopBottom(true, false, 0, CoD.SpectateTeamCardTwoTeam.Height)
	Widget:setClass(CoD.SpectateTeamCardTwoTeam)
	Widget.m_ownerController = HudRef
	local f4_local1 = LUI.UIImage.new()
	f4_local1:setTopBottom(true, true, 0, 0)
	f4_local1:setLeftRight(true, true, 0, 0)
	f4_local1:setImage(RegisterMaterial("hud_shoutcasting_boxes"))
	f4_local1:setAlpha(1)
	Widget.bgPulse = LUI.UIImage.new()
	Widget.bgPulse:setTopBottom(true, true, 0, 0)
	Widget.bgPulse:setLeftRight(true, true, 0, 0)
	Widget.bgPulse:setImage(RegisterMaterial("hud_shoutcasting_boxes_glow"))
	Widget.bgPulse:setAlpha(0)
	Widget.score = LUI.UIText.new()
	Widget.score:setLeftRight(true, true, 0, 0)
	Widget.score:setTopBottom(false, false, -(CoD.SpectateTeamCardTwoTeam.ScoreFontSize / 2), CoD.SpectateTeamCardTwoTeam.ScoreFontSize / 2)
	Widget.score:setFont(CoD.SpectateTeamCardTwoTeam.ScoreFont)
	Widget.score:setAlignment(LUI.Alignment.Center)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -75, -4)
	Widget:setTopBottom(true, false, 2, 55)
	Widget:addElement(Widget.score)
	local f4_local3 = CoD.SpectateTeamCardTwoTeam.IconDimension
	Widget.icon = LUI.UIImage.new()
	Widget.icon:setLeftRight(false, false, -(f4_local3 / 2), f4_local3 / 2)
	Widget.icon:setTopBottom(false, false, -(f4_local3 / 2), f4_local3 / 2)
	Widget.icon:setAlpha(0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -174, -88)
	Widget:setTopBottom(true, false, 2, 55)
	Widget:addElement(Widget.icon)
	if InstanceRef == true then
		f4_local1:setLeftRight(true, true, CoD.SpectateTeamCardTwoTeam.Width, -CoD.SpectateTeamCardTwoTeam.Width)
		Widget.bgPulse:setLeftRight(true, true, CoD.SpectateTeamCardTwoTeam.Width, -CoD.SpectateTeamCardTwoTeam.Width)
		Widget:setLeftRight(true, false, 75, 4)
		Widget:setLeftRight(true, false, 174, 88)
	end
	Widget:addElement(f4_local1)
	Widget:addElement(Widget.bgPulse)
	Widget:addElement(Widget)
	Widget:addElement(Widget)
	Widget.m_team = nil
	Widget.populate = CoD.SpectateTeamCardTwoTeam.Populate
	return Widget
end

CoD.SpectateTeamCardTwoTeam:registerEventHandler("spectate_teamstatuscard_pulse", CoD.SpectateTeamCardTwoTeam.Pulse)
