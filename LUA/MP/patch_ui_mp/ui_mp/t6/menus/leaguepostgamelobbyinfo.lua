CoD.LeaguePostGameLobbyInfo = {}
CoD.LeaguePostGameLobbyInfo.TitleTextSizeAndFont = "Default"
CoD.LeaguePostGameLobbyInfo.StatusTextSizeAndFont = "Default"
CoD.LeaguePostGameLobbyInfo.OutcomeTextSizeAndFont = "Condensed"
CoD.LeaguePostGameLobbyInfo.ProTipTextSizeAndFont = "Default"
CoD.LeaguePostGameLobbyInfo.new = function (f1_arg0)
	local Widget = LUI.UIElement.new(f1_arg0)
	CoD.LeaguePostGameLobbyInfo.SetupElements(Widget)
	Widget.update = CoD.LeaguePostGameLobbyInfo.Update
	local f1_local1 = LUI.UIImage.new()
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, true, 0, 0)
	return Widget
end

CoD.LeaguePostGameLobbyInfo.Update = function (f2_arg0, f2_arg1)
	if f2_arg0.statusText and f2_arg0.outcomeText and f2_arg0.leagueIcon then
		CoD.GameLobby.UpdateStatusTextInternal(f2_arg0.statusText)
		local f2_local0 = Engine.GetLeagueStats(f2_arg1)
		local f2_local1 = Engine.GetLeague()
		local f2_local2 = Engine.Localize("MENU_FILESHARE_DEFEAT")
		if f2_local0.matchOutcome == CoD.LeaguesData.LEAGUE_OUTCOME_WINNER then
			f2_local2 = Engine.Localize("MENU_FILESHARE_VICTORY")
		end
		f2_arg0.outcomeText:setText(f2_local2)
		f2_arg0.leagueIcon:setImage(f2_local1.icon)
		f2_arg0.leagueIcon:show()
	end
end

local f0_local0 = function (f3_arg0, f3_arg1, f3_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, CoD.textSize[f3_arg0])
	local textElem = LUI.UIText.new()
	textElem:setLeftRight(true, true, 0, 0)
	textElem:setTopBottom(true, true, 0, 0)
	textElem:setFont(CoD.fonts[f3_arg0])
	textElem:setText(f3_arg1)
	if f3_arg2 then
		textElem:setAlignment(LUI.Alignment[f3_arg2])
	end
	Widget:addElement(textElem)
	Widget.textElem = textElem
	
	return Widget
end

local f0_local1 = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	local f4_local0 = LUI.UIImage.new()
	f4_local0:setLeftRight(true, true, 0, 0)
	f4_local0:setTopBottom(true, true, 0, 0)
	f4_local0:setRGB(f4_arg0, f4_arg1, f4_arg2)
	f4_local0:setAlpha(f4_arg3)
	return f4_local0
end

CoD.LeaguePostGameLobbyInfo.SetupElements = function (f5_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.MapInfoImage.MapImageWidth)
	Widget:setTopBottom(true, true, 0, 0)
	local f5_local1 = 5
	local Widget = LUI.UIElement.new()
	local f5_local3 = -CoD.MapInfoImage.MapImageBottom
	Widget:setLeftRight(true, true, 10, 0)
	Widget:setTopBottom(false, true, -f5_local3, 0)
	local f5_local4 = LUI.UIImage.new()
	f5_local4:setLeftRight(true, true, 0, 0)
	f5_local4:setTopBottom(true, true, 0, 0)
	f5_local4:setImage(RegisterMaterial("menu_mp_map_frame"))
	local f5_local5 = LUI.UIVerticalList.new()
	f5_local5:setLeftRight(true, true, 0, 0)
	f5_local5:setTopBottom(true, true, 0, 0)
	f5_local5:addElement(f0_local0(CoD.LeaguePostGameLobbyInfo.TitleTextSizeAndFont, UIExpression.ToUpper(nil, Engine.Localize("MENU_LAST_GAME_RESULT")), "Left"))
	local f5_local6 = f0_local0(CoD.LeaguePostGameLobbyInfo.OutcomeTextSizeAndFont, "", "Left")
	f5_local5:addElement(f5_local6)
	local f5_local7 = 6
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f5_local7, f5_local7 + CoD.MapInfoImage.MapImageWidth)
	Widget:setTopBottom(true, true, 0, -f5_local3)
	local f5_local9 = LUI.UIImage.new()
	f5_local9:setLeftRight(true, true, 0, 0)
	f5_local9:setTopBottom(true, true, 0, 0)
	Widget:addElement(f5_local9)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f5_local1, 0)
	Widget:setTopBottom(true, false, -CoD.textSize[CoD.LeaguePostGameLobbyInfo.StatusTextSizeAndFont], 0)
	local f5_local11 = f0_local0(CoD.LeaguePostGameLobbyInfo.StatusTextSizeAndFont, "", "Left")
	Widget:addElement(f5_local11)
	Widget:addElement(f5_local5)
	Widget:addElement(Widget)
	Widget:addElement(f5_local4)
	Widget:addElement(Widget)
	Widget:addElement(Widget)
	f5_arg0.leagueIcon = f5_local9
	f5_arg0.statusText = f5_local11.textElem
	f5_arg0.outcomeText = f5_local6.textElem
	f5_arg0.leagueIcon:hide()
	f5_arg0:addElement(Widget)
end

