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
local f0_local0 = function (SpectatePlayercardWidget, LocalClientIndex)
	if not (not Engine.IsDemoShoutcaster() or not CoD.ExeProfileVarBool(LocalClientIndex, "demo_shoutcaster_nameplate")) or not Engine.IsDemoShoutcaster() and CoD.ExeProfileVarBool(LocalClientIndex, "shoutcaster_nameplate") then
		CoD.SpectatePlayercard.Show(SpectatePlayercardWidget)
	else
		CoD.SpectatePlayercard.Hide(SpectatePlayercardWidget)
	end
end

CoD.SpectatePlayercard.PlayerSelected = function (SpectatePlayercardWidget, ClientInstance)
	if ClientInstance.info ~= nil then
		if ClientInstance.info.teamID == CoD.TEAM_SPECTATOR then
			SpectatePlayercardWidget.m_teamID = CoD.TEAM_SPECTATOR
			SpectatePlayercardWidget:setAlpha(0)
			return 
		end
		local PlayerClanTag = ""
		if ClientInstance.info.clanTag ~= nil then
			PlayerClanTag = CoD.getClanTag(ClientInstance.info.clanTag)
		end
		if ClientInstance.info.name ~= nil then
			SpectatePlayercardWidget.playerName:setText(PlayerClanTag .. ClientInstance.info.name)
		else
			SpectatePlayercardWidget.playerName:setText("")
		end
		if ClientInstance.info.teamID ~= SpectatePlayercardWidget.m_teamID then
			if ClientInstance.info.teamID ~= CoD.TEAM_FREE then
				SpectatePlayercardWidget.teamName:setText(Engine.Localize("MPUI_SPECTATE_TEAM_VIEWING_CAPS") .. " " .. Engine.Localize("MPUI_" .. CoD.GetTeamName(ClientInstance.info.teamID) .. "_SHORT"))
			end
			SpectatePlayercardWidget.m_teamID = ClientInstance.info.teamID
		end
		if ClientInstance.info.teamID == CoD.TEAM_FREE then
			SpectatePlayercardWidget.playerEmblem:setAlpha(1)
			SpectatePlayercardWidget.playerEmblem:setupPlayerEmblemServer(ClientInstance.info.playerClientNum)
			SpectatePlayercardWidget.teamEmblem:setAlpha(0)
		else
			SpectatePlayercardWidget.playerEmblem:setAlpha(0)
			local TeamIcon = CoD.SpectateHUD.GetTeamIcon(ClientInstance.info.teamID)
			if TeamIcon then
				SpectatePlayercardWidget.teamEmblem:setImage(TeamIcon)
				SpectatePlayercardWidget.teamEmblem:setAlpha(1)
			else
				SpectatePlayercardWidget.teamEmblem:setAlpha(0)
			end
		end
		SpectatePlayercardWidget.bgPulse:completeAnimation()
		if SpectatePlayercardWidget.m_teamID == CoD.TEAM_FREE then
			SpectatePlayercardWidget.bgPulse:setRGB(0.6, 0.6, 0.6)
		else
			local Red, Green, Blue = CoD.SpectateHUD.GetTeamColor(SpectatePlayercardWidget.m_teamID)
			SpectatePlayercardWidget.bgPulse:setRGB(Red, Green, Blue)
		end
		SpectatePlayercardWidget.bgPulse:setAlpha(0.5)
		SpectatePlayercardWidget.bgPulse:beginAnimation("pulse_out", 1000)
		SpectatePlayercardWidget.bgPulse:setAlpha(0)
	end
	f0_local0(SpectatePlayercardWidget, ClientInstance.controller)
end

CoD.SpectatePlayercard.Hide = function (SpectatePlayercardWidget, ClientInstance)
	SpectatePlayercardWidget:setAlpha(0)
end

CoD.SpectatePlayercard.Show = function (SpectatePlayercardWidget, ClientInstance)
	if SpectatePlayercardWidget.m_teamID ~= CoD.TEAM_SPECTATOR then
		SpectatePlayercardWidget:setAlpha(1)
	end
end

CoD.SpectatePlayercard.Update = function (SpectatePlayercardWidget, ClientInstance)
	if SpectatePlayercardWidget.m_teamID ~= CoD.TEAM_SPECTATOR then
		f0_local0(SpectatePlayercardWidget, ClientInstance.controller)
	end
end

CoD.SpectatePlayercard.HideSwitchPlayerBar = function (SpectatePlayercardWidget, ClientInstance)
	SpectatePlayercardWidget.switchPlayerBar:setAlpha(0)
end

CoD.SpectatePlayercard.ShowSwitchPlayerBar = function (SpectatePlayercardWidget, ClientInstance)
	if Engine.IsDemoShoutcaster() then
		return 
	else
		SpectatePlayercardWidget.switchPlayerBar:setAlpha(1)
	end
end

CoD.SpectatePlayercard.Dock = function (SpectatePlayercardWidget, f8_arg1, f8_arg2, f8_arg3)
	SpectatePlayercardWidget:beginAnimation("move", 200)
	SpectatePlayercardWidget:setLeftRight(true, false, f8_arg1, f8_arg1 + CoD.SpectatePlayercard.Width)
end

CoD.SpectatePlayercard.Undock = function (SpectatePlayercardWidget)
	SpectatePlayercardWidget:beginAnimation("move", 200)
	SpectatePlayercardWidget:setLeftRight(true, false, CoD.SpectatePlayercard.HorizontalPadding, CoD.SpectatePlayercard.HorizontalPadding + CoD.SpectatePlayercard.Width)
end

CoD.SpectatePlayercard.new = function (LocalClientIndex)
	local SpectatePlayercardWidget = LUI.UIElement.new()
	SpectatePlayercardWidget:setLeftRight(true, false, CoD.SpectatePlayercard.HorizontalPadding, CoD.SpectatePlayercard.HorizontalPadding + CoD.SpectatePlayercard.Width)
	SpectatePlayercardWidget:setTopBottom(false, true, -CoD.SpectatePlayercard.Height - CoD.SpectatePlayercard.VerticalPadding, -CoD.SpectatePlayercard.VerticalPadding)
	SpectatePlayercardWidget:setClass(CoD.SpectatePlayercard)
	SpectatePlayercardWidget.m_ownerController = LocalClientIndex
	SpectatePlayercardWidget.m_teamID = CoD.TEAM_SPECTATOR
	local ShoutcastingViewBox = LUI.UIImage.new()
	ShoutcastingViewBox:setLeftRight(true, false, 0, 512)
	ShoutcastingViewBox:setTopBottom(true, false, CoD.SpectatePlayercard.BodyStart, 128)
	ShoutcastingViewBox:setImage(RegisterMaterial("hud_shoutcasting_viewing_box"))
	ShoutcastingViewBox:setAlpha(1)
	SpectatePlayercardWidget.bgPulse = LUI.UIImage.new()
	SpectatePlayercardWidget.bgPulse:setLeftRight(true, false, 0, 512)
	SpectatePlayercardWidget.bgPulse:setTopBottom(true, false, CoD.SpectatePlayercard.BodyStart, 128)
	SpectatePlayercardWidget.bgPulse:setImage(RegisterMaterial("hud_shoutcasting_viewing_glow"))
	SpectatePlayercardWidget.bgPulse:setAlpha(0)
	SpectatePlayercardWidget.teamEmblem = LUI.UIImage.new()
	SpectatePlayercardWidget.teamEmblem:setLeftRight(true, false, 10, 10 + CoD.SpectatePlayercard.EmblemSideLength)
	SpectatePlayercardWidget.teamEmblem:setTopBottom(true, false, CoD.SpectatePlayercard.BodyStart, CoD.SpectatePlayercard.BodyStart + CoD.SpectatePlayercard.EmblemSideLength)
	SpectatePlayercardWidget.teamEmblem:setAlpha(0)
	SpectatePlayercardWidget.playerEmblem = LUI.UIElement.new()
	SpectatePlayercardWidget.playerEmblem:setLeftRight(true, false, 10, 10 + CoD.SpectatePlayercard.EmblemSideLength)
	SpectatePlayercardWidget.playerEmblem:setTopBottom(true, false, CoD.SpectatePlayercard.BodyStart, CoD.SpectatePlayercard.BodyStart + CoD.SpectatePlayercard.EmblemSideLength)
	SpectatePlayercardWidget.playerEmblem:setAlpha(0)
	local f10_local2 = CoD.SpectatePlayercard.BodyStart + (CoD.SpectatePlayercard.Height - CoD.SpectatePlayercard.BodyStart) / 2 - CoD.SpectatePlayercard.TextSize / 2 + 5
	SpectatePlayercardWidget.playerName = LUI.UITightText.new()
	SpectatePlayercardWidget.playerName:setLeftRight(true, true, 0, 0)
	SpectatePlayercardWidget.playerName:setTopBottom(true, false, f10_local2, f10_local2 + CoD.SpectatePlayercard.TextSize)
	SpectatePlayercardWidget.playerName:setAlignment(LUI.Alignment.Center)
	local f10_local3 = f10_local2 + CoD.SpectatePlayercard.TextSize + 8
	SpectatePlayercardWidget.teamName = LUI.UITightText.new()
	SpectatePlayercardWidget.teamName:setLeftRight(true, true, 0, 0)
	SpectatePlayercardWidget.teamName:setTopBottom(true, false, f10_local3, f10_local3 + CoD.SpectatePlayercard.TextSize * 0.75)
	SpectatePlayercardWidget.teamName:setAlignment(LUI.Alignment.Center)
	local ShoutcastingChangeTab = LUI.UIImage.new()
	ShoutcastingChangeTab:setLeftRight(true, false, 0, 256)
	ShoutcastingChangeTab:setTopBottom(true, false, 0, 64)
	ShoutcastingChangeTab:setImage(RegisterMaterial("hud_shoutcasting_change_tab"))
	SpectatePlayercardWidget.switchPlayerBar = LUI.UIElement.new()
	SpectatePlayercardWidget.switchPlayerBar:setLeftRight(true, false, 92, 259)
	SpectatePlayercardWidget.switchPlayerBar:setTopBottom(true, false, -3, 29)
	local f10_local7_1, f10_local7_2, f10_local7_3, f10_local7_4 = GetTextDimensions(Engine.Localize("MPUI_SWITCH_PLAYER_CAPS"), CoD.fonts.ExtraSmall, CoD.textSize.Default)
	local SpectateSwitchPlayerPrompt = CoD.DualButtonPrompt.new("shoulderl", Engine.Localize("MPUI_SWITCH_PLAYER_CAPS"), "shoulderr", nil, nil, nil, false, false, 0, "mouse1", "mouse2")
	SpectateSwitchPlayerPrompt:setLeftRight(false, false, -f10_local7_3 / 2 - 17, -f10_local7_3 / 2 - 5)
	SpectateSwitchPlayerPrompt:setTopBottom(false, false, -10, 10)
	SpectatePlayercardWidget.switchPlayerBar:addElement(ShoutcastingChangeTab)
	SpectatePlayercardWidget.switchPlayerBar:addElement(SpectateSwitchPlayerPrompt)
	SpectatePlayercardWidget:addElement(ShoutcastingViewBox)
	SpectatePlayercardWidget:addElement(SpectatePlayercardWidget.bgPulse)
	SpectatePlayercardWidget:addElement(SpectatePlayercardWidget.switchPlayerBar)
	SpectatePlayercardWidget:addElement(SpectatePlayercardWidget.playerEmblem)
	SpectatePlayercardWidget:addElement(SpectatePlayercardWidget.teamEmblem)
	SpectatePlayercardWidget:addElement(SpectatePlayercardWidget.playerName)
	SpectatePlayercardWidget:addElement(SpectatePlayercardWidget.teamName)
	SpectatePlayercardWidget.dock = CoD.SpectatePlayercard.Dock
	SpectatePlayercardWidget.undock = CoD.SpectatePlayercard.Undock
	SpectatePlayercardWidget.playerName:setText("")
	SpectatePlayercardWidget:setAlpha(0)
	return SpectatePlayercardWidget
end

CoD.SpectatePlayercard:registerEventHandler("spectate_player_selected", CoD.SpectatePlayercard.PlayerSelected)
CoD.SpectatePlayercard:registerEventHandler("hide_spectate_hud", CoD.SpectatePlayercard.Hide)
CoD.SpectatePlayercard:registerEventHandler("show_spectate_hud", CoD.SpectatePlayercard.Show)
CoD.SpectatePlayercard:registerEventHandler("update_spectate_hud", CoD.SpectatePlayercard.Update)
CoD.SpectatePlayercard:registerEventHandler("hide_switch_player_bar", CoD.SpectatePlayercard.HideSwitchPlayerBar)
CoD.SpectatePlayercard:registerEventHandler("show_switch_player_bar", CoD.SpectatePlayercard.ShowSwitchPlayerBar)
