require("T6.ScrollingVerticalList")
require("T6.LeaderboardListButton")
CoD.LeaderboardList = {}
CoD.LeaderboardList.ColumnWidth = {}
CoD.LeaderboardList.ColumnWidth[1] = 80
CoD.LeaderboardList.ColumnWidth[2] = 30
CoD.LeaderboardList.ColumnWidth[3] = 30
CoD.LeaderboardList.ColumnWidth[4] = 125
CoD.LeaderboardList.ColumnWidth[5] = 50
CoD.LeaderboardList.ColumnWidth[6] = 70
CoD.LeaderboardList.ColumnWidth[7] = 50
CoD.LeaderboardList.ColumnWidth[8] = 50
CoD.LeaderboardList.ColumnWidth[9] = 50
if CoD.isZombie == true then
	CoD.LeaderboardList.ColumnWidth[2] = 185
	CoD.LeaderboardList.ColumnWidth[3] = 94
	CoD.LeaderboardList.ColumnWidth[4] = 94
	CoD.LeaderboardList.ColumnWidth[5] = 94
	CoD.LeaderboardList.ColumnWidth[6] = 94
	CoD.LeaderboardList.ColumnWidth[7] = 94
	CoD.LeaderboardList.ColumnWidth[8] = 94
	CoD.LeaderboardList.ColumnWidth[9] = 94
end
CoD.LeaderboardList.RowHeight = CoD.CoD9Button.Height
CoD.LeaderboardList.ColumnSpacing = 5
local f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg0.verticalList:removeAllChildren()
	local f1_local0 = Engine.GetLeaderboardData(f1_arg1.controller)
	if f1_local0 == nil or #f1_local0 == 0 then
		DebugPrint("No leaderboard data.")
		return 
	end
	for f1_local4, f1_local5 in ipairs(f1_local0) do
		local f1_local6 = CoD.LeaderboardListButton.new(f1_local4, f1_local5, {
			left = 0,
			top = 0,
			right = 0,
			bottom = CoD.LeaderboardList.RowHeight,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			spacing = CoD.LeaderboardList.ColumnSpacing
		})
		f1_arg0:addElementToList(f1_local6)
		if f1_local4 == 1 and CoD.useController then
			f1_local6:processEvent({
				name = "gain_focus"
			})
		end
	end
end

CoD.LeaderboardList.new = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	if f2_arg3 == nil then
		f2_arg3 = CoD.LB_FILTER_NONE
	end
	local f2_local0 = CoD.ScrollingVerticalList.new(f2_arg1, f2_arg2)
	f2_local0.id = "LeaderboardList"
	f2_local0:registerEventHandler("leaderboardlist_update", f0_local0)
	Engine.RequestLeaderboardData(f2_arg0, f2_arg3)
	return f2_local0
end

