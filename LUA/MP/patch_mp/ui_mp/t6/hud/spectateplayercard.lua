require("T6.DualButtonPrompt")
CoD.SpectatePlayercard = InheritFrom(LUI.UIElement)
CoD.SpectatePlayercard.HorizontalPadding = 50
CoD.SpectatePlayercard.VerticalPadding = 65
CoD.SpectatePlayercard.SwitchPlayerBarHeight = 22
CoD.SpectatePlayercard.BodyStart = CoD.SpectatePlayercard.SwitchPlayerBarHeight
CoD.SpectatePlayercard.TextSize = CoD.textSize.Default
CoD.SpectatePlayercard.EmblemSideLength = 38
CoD.SpectatePlayercard.Width = 353
CoD.SpectatePlayercard.Height = CoD.SpectatePlayercard.SwitchPlayerBarHeight + CoD.SpectatePlayercard.EmblemSideLength
local f0_local0 = function (f1_arg0, f1_arg1)
	if not (not Engine.IsDemoShoutcaster() or not CoD.ExeProfileVarBool(f1_arg1, "demo_shoutcaster_nameplate")) or not Engine.IsDemoShoutcaster() and CoD.ExeProfileVarBool(f1_arg1, "shoutcaster_nameplate") then
		CoD.SpectatePlayercard.Show(f1_arg0)
	else
		CoD.SpectatePlayercard.Hide(f1_arg0)
	end
end

CoD.SpectatePlayercard.PlayerSelected = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.info
	local f2_local1 = nil
	if f2_local0 ~= nil then
		if f2_local0.teamID == CoD.TEAM_SPECTATOR then
			f2_arg0.m_teamID = TEAM_SPECTATOR
			f2_arg0:setAlpha(0)
			return 
		end
		local f2_local2 = ""
		if f2_local0.clanTag ~= nil then
			f2_local2 = CoD.getClanTag(f2_local0.clanTag)
		end
		if f2_local0.name ~= nil then
			f2_arg0.playerName:setText(f2_local2 .. f2_local0.name)
		else
			f2_arg0.playerName:setText("")
		end
		if f2_local0.teamID ~= f2_arg0.m_teamID then
			if f2_local0.teamID ~= CoD.TEAM_FREE then
				f2_arg0.teamName:setText(Engine.Localize("MPUI_SPECTATE_TEAM_VIEWING_CAPS") .. " " .. Engine.Localize("MPUI_" .. CoD.GetTeamName(f2_local0.teamID) .. "_SHORT"))
			end
			f2_arg0.m_teamID = f2_local0.teamID
		end
		if f2_local0.teamID == CoD.TEAM_FREE then
			f2_arg0.playerEmblem:setAlpha(1)
			f2_arg0.playerEmblem:setupPlayerEmblemServer(f2_local0.playerClientNum)
			f2_arg0.teamEmblem:setAlpha(0)
		else
			f2_arg0.playerEmblem:setAlpha(0)
			f2_local1 = CoD.SpectateHUD.GetTeamIcon(f2_local0.teamID)
			if f2_local1 then
				f2_arg0.teamEmblem:setImage(f2_local1)
				f2_arg0.teamEmblem:setAlpha(1)
			else
				f2_arg0.teamEmblem:setAlpha(0)
			end
		end
		f2_arg0.bgPulse:completeAnimation()
		if f2_arg0.m_teamID == CoD.TEAM_FREE then
			f2_arg0.bgPulse:setRGB(0.6, 0.6, 0.6)
		else
			local f2_local3, f2_local4, f2_local5 = CoD.SpectateHUD.GetTeamColor(f2_arg0.m_teamID)
			f2_arg0.bgPulse:setRGB(f2_local3, f2_local4, f2_local5)
		end
		f2_arg0.bgPulse:setAlpha(0.5)
		f2_arg0.bgPulse:beginAnimation("pulse_out", 1000)
		f2_arg0.bgPulse:setAlpha(0)
	end
	f0_local0(f2_arg0, f2_arg1.controller)
end

CoD.SpectatePlayercard.Hide = function (f3_arg0, f3_arg1)
	f3_arg0:setAlpha(0)
end

CoD.SpectatePlayercard.Show = function (f4_arg0, f4_arg1)
	if f4_arg0.m_teamID ~= TEAM_SPECTATOR then
		f4_arg0:setAlpha(1)
	end
end

CoD.SpectatePlayercard.Update = function (f5_arg0, f5_arg1)
	if f5_arg0.m_teamID ~= CoD.TEAM_SPECTATOR then
		f0_local0(f5_arg0, f5_arg1.controller)
	end
end

CoD.SpectatePlayercard.HideSwitchPlayerBar = function (f6_arg0, f6_arg1)
	f6_arg0.switchPlayerBar:setAlpha(0)
end

CoD.SpectatePlayercard.ShowSwitchPlayerBar = function (f7_arg0, f7_arg1)
	if Engine.IsDemoShoutcaster() then
		return 
	else
		f7_arg0.switchPlayerBar:setAlpha(1)
	end
end

CoD.SpectatePlayercard.Dock = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	local f8_local0 = f8_arg2 + f8_arg3 - CoD.SpectatePlayercard.Height
	f8_arg0:beginAnimation("move", 200)
	f8_arg0:setLeftRight(true, false, f8_arg1, f8_arg1 + CoD.SpectatePlayercard.Width)
end

CoD.SpectatePlayercard.Undock = function (f9_arg0)
	f9_arg0:beginAnimation("move", 200)
	f9_arg0:setLeftRight(true, false, CoD.SpectatePlayercard.HorizontalPadding, CoD.SpectatePlayercard.HorizontalPadding + CoD.SpectatePlayercard.Width)
end

CoD.SpectatePlayercard.new = function (f10_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, CoD.SpectatePlayercard.HorizontalPadding, CoD.SpectatePlayercard.HorizontalPadding + CoD.SpectatePlayercard.Width)
	Widget:setTopBottom(false, true, -CoD.SpectatePlayercard.Height - CoD.SpectatePlayercard.VerticalPadding, -CoD.SpectatePlayercard.VerticalPadding)
	Widget:setClass(CoD.SpectatePlayercard)
	Widget.m_ownerController = f10_arg0
	Widget.m_teamID = TEAM_SPECTATOR
	local f10_local1 = LUI.UIImage.new()
	f10_local1:setLeftRight(true, false, 0, 512)
	f10_local1:setTopBottom(true, false, CoD.SpectatePlayercard.BodyStart, 128)
	f10_local1:setImage(RegisterMaterial("hud_shoutcasting_viewing_box"))
	f10_local1:setAlpha(1)
	Widget.bgPulse = LUI.UIImage.new()
	Widget.bgPulse:setLeftRight(true, false, 0, 512)
	Widget.bgPulse:setTopBottom(true, false, CoD.SpectatePlayercard.BodyStart, 128)
	Widget.bgPulse:setImage(RegisterMaterial("hud_shoutcasting_viewing_glow"))
	Widget.bgPulse:setAlpha(0)
	Widget.teamEmblem = LUI.UIImage.new()
	Widget.teamEmblem:setLeftRight(true, false, 10, 10 + CoD.SpectatePlayercard.EmblemSideLength)
	Widget.teamEmblem:setTopBottom(true, false, CoD.SpectatePlayercard.BodyStart, CoD.SpectatePlayercard.BodyStart + CoD.SpectatePlayercard.EmblemSideLength)
	Widget.teamEmblem:setAlpha(0)
	Widget.playerEmblem = LUI.UIElement.new()
	Widget.playerEmblem:setLeftRight(true, false, 10, 10 + CoD.SpectatePlayercard.EmblemSideLength)
	Widget.playerEmblem:setTopBottom(true, false, CoD.SpectatePlayercard.BodyStart, CoD.SpectatePlayercard.BodyStart + CoD.SpectatePlayercard.EmblemSideLength)
	Widget.playerEmblem:setAlpha(0)
	local f10_local2 = CoD.SpectatePlayercard.BodyStart + (CoD.SpectatePlayercard.Height - CoD.SpectatePlayercard.BodyStart) / 2 - CoD.SpectatePlayercard.TextSize / 2 + 5
	Widget.playerName = LUI.UITightText.new()
	Widget.playerName:setLeftRight(true, true, 0, 0)
	Widget.playerName:setTopBottom(true, false, f10_local2, f10_local2 + CoD.SpectatePlayercard.TextSize)
	Widget.playerName:setAlignment(LUI.Alignment.Center)
	local f10_local3 = f10_local2 + CoD.SpectatePlayercard.TextSize + 8
	Widget.teamName = LUI.UITightText.new()
	Widget.teamName:setLeftRight(true, true, 0, 0)
	Widget.teamName:setTopBottom(true, false, f10_local3, f10_local3 + CoD.SpectatePlayercard.TextSize * 0.75)
	Widget.teamName:setAlignment(LUI.Alignment.Center)
	local f10_local4 = LUI.UIImage.new()
	f10_local4:setLeftRight(true, false, 0, 256)
	f10_local4:setTopBottom(true, false, 0, 64)
	f10_local4:setImage(RegisterMaterial("hud_shoutcasting_change_tab"))
	Widget.switchPlayerBar = LUI.UIElement.new()
	Widget.switchPlayerBar:setLeftRight(true, false, 92, 259)
	Widget.switchPlayerBar:setTopBottom(true, false, -3, 29)
	local f10_local5 = 5
	local f10_local6 = Engine.Localize("MPUI_SWITCH_PLAYER_CAPS")
	local f10_local7 = {}
	f10_local7 = GetTextDimensions(f10_local6, CoD.fonts.ExtraSmall, CoD.textSize.Default)
	local f10_local8 = f10_local7[3]
	local f10_local9 = CoD.DualButtonPrompt.new
	local f10_local10 = "shoulderl"
	local f10_local11 = f10_local6
	local f10_local12 = "shoulderr"
	local f10_local13, f10_local14, f10_local15 = nil
	local f10_local16, f10_local17 = false
	f10_local9 = f10_local9(f10_local10, f10_local11, f10_local12, f10_local13, f10_local14, f10_local15, f10_local16, f10_local17, 0, "mouse1", "mouse2")
	f10_local9:setLeftRight(false, false, -f10_local8 / 2 - f10_local5 - 12, -f10_local8 / 2 - f10_local5)
	f10_local9:setTopBottom(false, false, -10, 10)
	Widget.switchPlayerBar:addElement(f10_local4)
	Widget.switchPlayerBar:addElement(f10_local9)
	Widget:addElement(f10_local1)
	Widget:addElement(Widget.bgPulse)
	Widget:addElement(Widget.switchPlayerBar)
	Widget:addElement(Widget.playerEmblem)
	Widget:addElement(Widget.teamEmblem)
	Widget:addElement(Widget.playerName)
	Widget:addElement(Widget.teamName)
	Widget.dock = CoD.SpectatePlayercard.Dock
	Widget.undock = CoD.SpectatePlayercard.Undock
	Widget.playerName:setText("")
	Widget:setAlpha(0)
	return Widget
end

CoD.SpectatePlayercard:registerEventHandler("spectate_player_selected", CoD.SpectatePlayercard.PlayerSelected)
CoD.SpectatePlayercard:registerEventHandler("hide_spectate_hud", CoD.SpectatePlayercard.Hide)
CoD.SpectatePlayercard:registerEventHandler("show_spectate_hud", CoD.SpectatePlayercard.Show)
CoD.SpectatePlayercard:registerEventHandler("update_spectate_hud", CoD.SpectatePlayercard.Update)
CoD.SpectatePlayercard:registerEventHandler("hide_switch_player_bar", CoD.SpectatePlayercard.HideSwitchPlayerBar)
CoD.SpectatePlayercard:registerEventHandler("show_switch_player_bar", CoD.SpectatePlayercard.ShowSwitchPlayerBar)
