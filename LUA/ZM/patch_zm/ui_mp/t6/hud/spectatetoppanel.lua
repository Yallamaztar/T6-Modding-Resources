require("T6.HUD.SpectateGameStatusMultiTeam")
require("T6.HUD.SpectateGameStatusTwoTeam")
require("T6.HUD.SpectateGameModeStatus")
require("T6.HUD.SpectateGameModeStatus_ctf")
require("T6.HUD.SpectateGameModeStatus_dem")
require("T6.HUD.SpectateGameModeStatus_dom")
require("T6.HUD.SpectateGameModeStatus_hq")
require("T6.HUD.SpectateGameModeStatus_koth")
require("T6.HUD.SpectateGameModeStatus_oneflag")
require("T6.HUD.SpectateGameModeStatus_sd")
CoD.SpectateTopPanel = InheritFrom(LUI.UIElement)
CoD.SpectateTopPanel.GameModeWidth = 480
CoD.SpectateTopPanel.GameModeHeight = 30
CoD.SpectateTopPanel.GameModeTop = 75
CoD.SpectateTopPanel.Update = function (f1_arg0, f1_arg1)
	if not CoD.IsShoutcaster(f1_arg1.controller) or CoD.ExeProfileVarBool(f1_arg1.controller, "shoutcaster_scorepanel") then
		CoD.SpectateTopPanel.Show(f1_arg0)
	else
		CoD.SpectateTopPanel.Hide(f1_arg0)
	end
end

CoD.SpectateTopPanel.Hide = function (f2_arg0, f2_arg1)
	f2_arg0:setAlpha(0)
end

CoD.SpectateTopPanel.Show = function (f3_arg0, f3_arg1)
	f3_arg0:setAlpha(1)
end

CoD.SpectateTopPanel.new = function (f4_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setClass(CoD.SpectateTopPanel)
	local f4_local1 = Engine.GetGametypeSetting("teamCount")
	if f4_local1 == 2 then
		Widget.gameStatus = CoD.SpectateGameStatusTwoTeam.new(f4_arg0, f4_local1)
	else
		Widget.gameStatus = CoD.SpectateGameStatusMultiTeam.new(f4_arg0, f4_local1)
	end
	if Widget.gameStatus ~= nil then
		Widget:addElement(Widget.gameStatus)
	end
	Widget:processEvent({
		name = "update_spectate_hud",
		controller = f4_arg0
	})
	return Widget
end

CoD.SpectateTopPanel:registerEventHandler("update_spectate_hud", CoD.SpectateTopPanel.Update)
CoD.SpectateTopPanel:registerEventHandler("hide_spectate_hud", CoD.SpectateTopPanel.Hide)
CoD.SpectateTopPanel:registerEventHandler("show_spectate_hud", CoD.SpectateTopPanel.Show)
