require("T6.ListBox")
require("T6.CoDBase")
CoD.Leaderboard = {}
CoD.Leaderboard.PADDING = 5
local f0_local0 = nil
CoD.Leaderboard.CareerButtonData = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = f1_arg1 == f1_arg3:getTotalItems()
	local f1_local1 = nil
	if not f1_local0 or not f1_arg3.fakeEntry then
		f1_local1 = Engine.GetLeaderboardRow(f1_arg0, f1_arg1)
	end
	local f1_local2, f1_local3, f1_local4 = nil
	local f1_local5 = UIExpression.GetXUID(f1_arg0)
	if f1_local1 ~= nil then
		f1_local2 = f1_local1.lbrow[1]
		f1_local3 = f1_local1.lbrow[2]
		f1_local4 = f1_local1.lbrow[3]
	else
		f1_local2 = f1_arg1
		if f1_local0 then
			f1_local3 = UIExpression.GetSelfGamertag()
		else
			f1_local3 = "--"
		end
		f1_local4 = "--"
	end
	if not (f1_local1 ~= nil or not f1_local0) or f1_local1 ~= nil and f1_local5 == f1_local1.lbrow.xuid and f1_local5 ~= f1_arg2.xuid then
		f1_arg2.name:setRGB(CoD.CareerOverviewMenu.Teal.r, CoD.CareerOverviewMenu.Teal.g, CoD.CareerOverviewMenu.Teal.b)
		f1_arg2.score:setRGB(CoD.CareerOverviewMenu.Teal.r, CoD.CareerOverviewMenu.Teal.g, CoD.CareerOverviewMenu.Teal.b)
		if f1_arg2.lbrank ~= nil then
			f1_arg2.lbrank:setRGB(CoD.CareerOverviewMenu.Teal.r, CoD.CareerOverviewMenu.Teal.g, CoD.CareerOverviewMenu.Teal.b)
		end
	end
	if f1_arg2.lbrank ~= nil then
		f1_arg2.lbrank:setText(f1_arg1)
	end
	if f1_arg2.name ~= nil then
		f1_arg2.name:setText(f1_local3)
	end
	if f1_arg2.score ~= nil then
		f1_arg2.score:setText(f1_local4)
	end
	f1_arg2.playerName = f1_local3
	if f1_local1 ~= nil then
		f1_arg2.xuid = f1_local1.lbrow.xuid
	else
		f1_arg2.xuid = f1_local5
	end
	if f1_arg2.xuid == f1_local5 then
		local f1_local6 = f1_arg2:getParent()
		f1_local6.clickable = false
	else
		local f1_local6 = f1_arg2:getParent()
		f1_local6.clickable = true
	end
	if f1_arg3.loaded == nil then
		f1_arg3.loaded = true
		f1_arg3.loadedXuid = f1_arg2.xuid
		if f1_arg3:getTotalItems() == 1 or f1_local5 ~= f1_arg2.xuid then
			f1_arg2:processEvent({
				name = "click"
			})
		end
	end
end

local f0_local1 = function (f2_arg0, f2_arg1)
	CoD.viewGamerCard(f2_arg1.controller, f2_arg0.playerName, f2_arg0.xuid, CoD.playerListType.platform)
end

CoD.Leaderboard.ButtonGainFocus = function (f3_arg0, f3_arg1)
	f3_arg0.border:processEvent({
		name = "gain_focus"
	})
	if CoD.isXBOX or CoD.isPS3 or CoD.isPC then
		f3_arg0:registerEventHandler("view_gamer_card", f0_local1)
	end
end

CoD.Leaderboard.ButtonLoseFocus = function (f4_arg0, f4_arg1)
	f4_arg0.border:processEvent({
		name = "lose_focus"
	})
	if CoD.isXBOX or CoD.isPS3 or CoD.isPC then
		f4_arg0:registerEventHandler("view_gamer_card", nil)
	end
end

CoD.Leaderboard.ButtonClick = function (f5_arg0, f5_arg1)
	local f5_local0 = {
		name = "leaderboard_button_action",
		button = {},
		button = f5_arg0.xuid,
		button = f5_arg0.playerName
	}
	local f5_local1 = UIExpression.GetXUID(controller)
	local f5_local2 = CoD.AARUtility.OtherPlayerStatColor
	if f5_local1 ~= f5_arg0.xuid then
		if f5_arg0.lbrank ~= nil then
			f5_arg0.lbrank:setRGB(f5_local2.r, f5_local2.g, f5_local2.b)
		end
		if f5_arg0.name ~= nil then
			f5_arg0.name:setRGB(f5_local2.r, f5_local2.g, f5_local2.b)
		end
		if f5_arg0.score ~= nil then
			f5_arg0.score:setRGB(f5_local2.r, f5_local2.g, f5_local2.b)
		end
	end
	if f5_arg0.listBoxButton ~= nil then
		f5_arg0.listBoxButton:dispatchEventToParent(f5_local0)
	else
		f5_arg0:dispatchEventToParent(f5_local0)
	end
end

CoD.Leaderboard.ButtonUnclick = function (f6_arg0, f6_arg1)
	local f6_local0 = CoD.white
	if f6_arg0.xuid == UIExpression.GetXUID(controller) then
		f6_local0 = CoD.CareerOverviewMenu.Teal
	end
	if f6_arg0.lbrank ~= nil then
		f6_arg0.lbrank:setRGB(f6_local0.r, f6_local0.g, f6_local0.b)
	end
	if f6_arg0.name ~= nil then
		f6_arg0.name:setRGB(f6_local0.r, f6_local0.g, f6_local0.b)
	end
	if f6_arg0.score ~= nil then
		f6_arg0.score:setRGB(f6_local0.r, f6_local0.g, f6_local0.b)
	end
end

CoD.Leaderboard.GetListBox = function (f7_arg0)
	if f7_arg0 ~= nil then
		return f7_arg0.listBox
	else

	end
end

f0_local0 = function (f8_arg0)
	if f8_arg0 ~= nil then
		f8_arg0.minDelay = 110
	end
end

CoD.Leaderboard.RepeaterSetup = function (f9_arg0)
	if f9_arg0.listBox ~= nil then
		f0_local0(f9_arg0.listBox.buttonRepeaterUp)
		f0_local0(f9_arg0.listBox.buttonRepeaterDown)
	end
end

