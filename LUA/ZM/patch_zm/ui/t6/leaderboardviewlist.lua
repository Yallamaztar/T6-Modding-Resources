require("T6.Menus.AARUtility")
CoD.LeaderboardViewList = {}
CoD.LeaderboardViewList.TopThreeColumnWidth = {}
CoD.LeaderboardViewList.TopThreeColumnWidth[1] = 50
CoD.LeaderboardViewList.TopThreeColumnWidth[2] = 270
CoD.LeaderboardViewList.TopThreeColumnWidth[3] = 70
CoD.LeaderboardViewList.FullListColumnWidth = {}
CoD.LeaderboardViewList.FullListColumnWidth[1] = 50
CoD.LeaderboardViewList.FullListColumnWidth[2] = 250
CoD.LeaderboardViewList.FullListColumnWidth[3] = 100
CoD.LeaderboardViewList.ColumnAlignment = {}
CoD.LeaderboardViewList.ColumnAlignment[1] = LUI.Alignment.Left
CoD.LeaderboardViewList.ColumnAlignment[2] = LUI.Alignment.Left
CoD.LeaderboardViewList.ColumnAlignment[3] = LUI.Alignment.Right
CoD.LeaderboardViewList.Height = CoD.CoD9Button.Height
CoD.LeaderboardViewList.TextLeft = 10
CoD.LeaderboardViewList.TextHeight = CoD.textSize.Condensed
CoD.LeaderboardViewList.Font = CoD.fonts.Condensed
CoD.LeaderboardViewList.BackgroundColor = {
	r = 1,
	g = 1,
	b = 1,
	a = 0.2
}
CoD.LeaderboardViewList.ButtonDisabledColor = {
	red = 1,
	green = 1,
	blue = 1,
	alpha = 0.5
}
CoD.LeaderboardViewList.ButtonOverColor = {
	red = 1,
	green = 1,
	blue = 1,
	alpha = 1
}
CoD.LeaderboardViewList.ButtonOverDisabledColor = {
	red = 1,
	green = 1,
	blue = 1,
	alpha = 0.5
}
CoD.LeaderboardViewList.ColumnSpacing = 5
CoD.LeaderboardViewList.TextOffset = 5
local f0_local0, f0_local1, f0_local2, f0_local3, f0_local4, f0_local5 = nil
f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg0.id = "lbDataItem." .. f1_arg1
	f1_arg0.label:setText(f1_arg1)
end

f0_local1 = function (f2_arg0, f2_arg1, f2_arg2)
	local Widget = LUI.UIElement.new(f2_arg2)
	Widget.id = "lbDataRow"
	Widget.setLabel = f0_local0
	local f2_local1 = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.LeaderboardViewList.BackgroundColor.r,
		green = CoD.LeaderboardViewList.BackgroundColor.g,
		blue = CoD.LeaderboardViewList.BackgroundColor.b,
		alpha = CoD.LeaderboardViewList.BackgroundColor.a,
		material = RegisterMaterial("menu_mp_lobby_bar_name")
	})
	Widget.background = f2_local1
	Widget:addElement(f2_local1)
	local f2_local2 = LUI.UIHorizontalList.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = CoD.LeaderboardViewList.ColumnSpacing
	})
	f2_local2:addSpacer(CoD.LeaderboardViewList.TextOffset)
	for f2_local6, f2_local7 in ipairs(f2_arg1) do
		local f2_local8 = nil
		f2_local8 = LUI.UIText.new({
			left = 0,
			top = -CoD.LeaderboardViewList.TextHeight / 2,
			right = CoD.LeaderboardViewList.TopThreeColumnWidth[f2_local6],
			bottom = CoD.LeaderboardViewList.TextHeight / 2,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false,
			red = 1,
			green = 1,
			blue = 1,
			alpha = 1,
			font = CoD.LeaderboardViewList.Font,
			alignment = CoD.LeaderboardViewList.ColumnAlignment[f2_local6]
		})
		f2_local8:setText(f2_local7.col)
		if f2_local6 == 1 then
			f2_local8:setText(f2_arg0 .. "")
		end
		f2_local2:addElement(f2_local8)
	end
	Widget:addElement(f2_local2)
	return Widget
end

f0_local3 = function (f3_arg0, f3_arg1)
	f3_arg0:removeAllChildren()
	local f3_local0 = Engine.GetLeaderboardData(f3_arg1.controller)
	if f3_local0 == nil or #f3_local0 == 0 then
		DebugPrint("lui: leaderboardviewlist.lua, no leaderboard data")
		return 
	end
	for f3_local4, f3_local5 in ipairs(f3_local0) do
		f3_arg0:addElement(f0_local1(f3_local4, f3_local5, {
			left = 0,
			top = 0,
			right = 0,
			bottom = CoD.LeaderboardViewList.Height,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			alignment = LUI.Alignment.Left,
			spacing = CoD.LeaderboardViewList.ColumnSpacing
		}))
		if f3_local4 >= 3 then
			break
		end
		f3_arg0:addSpacer(CoD.LeaderboardViewList.ColumnSpacing)
	end
end

f0_local5 = function (f4_arg0, f4_arg1)
	Engine.PlaySound("uin_navigation_click")
end

function LeaderboardViewList_Button(f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = LUI.UIButton.new(f5_arg2)
	f5_local0.id = "lbDataRow"
	f5_local0.setLabel = f0_local0
	local f5_local1 = CoD.Border.new(2, 1, 1, 1, 0, -1)
	f5_local1:setLeftRight(true, true, 0, 0)
	LUI.UIButton.SetupElement(f5_local1)
	f5_local0:addElement(f5_local1)
	f5_local1:registerAnimationState("default", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0
	})
	f5_local1:registerAnimationState("button_over", {
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	local f5_local3 = f5_arg1[1].col
	local f5_local4 = f5_arg1[2].col
	local f5_local5 = f5_arg1[3].col
	local f5_local6 = f5_arg1.xuid
	local f5_local7 = CoD.LeaderboardViewList.FullListColumnWidth[2]
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 4, f5_local7)
	Widget:setTopBottom(true, true, 0, 0)
	local f5_local9 = LUI.UIText.new()
	f5_local9:setLeftRight(true, true, 0, 0)
	f5_local9:setTopBottom(true, true, 0, 0)
	f5_local9:setRGB(1, 1, 1)
	f5_local9:setAlpha(1)
	f5_local9:setText(f5_local4)
	f5_local9:setFont(CoD.LeaderboardViewList.Font)
	f5_local9:setAlignment(LUI.Alignment.Left)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f5_local7, -4)
	Widget:setTopBottom(true, true, 0, 0)
	local f5_local11 = LUI.UIText.new()
	f5_local11:setLeftRight(true, true, 0, 0)
	f5_local11:setTopBottom(true, true, 0, 0)
	f5_local11:setRGB(1, 1, 1)
	f5_local11:setAlpha(1)
	f5_local11:setText(f5_local5)
	f5_local11:setFont(CoD.LeaderboardViewList.Font)
	f5_local11:setAlignment(LUI.Alignment.Center)
	Widget:addElement(f5_local9)
	Widget:addElement(f5_local11)
	Widget:addElement(Widget)
	Widget:addElement(Widget)
	local f5_local12 = LUI.UIImage.new()
	f5_local12:setLeftRight(true, true, 0, 0)
	f5_local12:setTopBottom(true, true, 0, 0)
	Widget:addElement(f5_local12)
	local f5_local13 = LUI.UIImage.new()
	f5_local13:setLeftRight(true, true, 0, 0)
	f5_local13:setTopBottom(true, true, 0, 0)
	Widget:addElement(f5_local13)
	CoD.AARUtility.DecorateButtonRow({
		f5_local12,
		f5_local13
	})
	f5_local0:addElement(Widget)
	local Widget = LUI.UIElement.new()
	f5_local0:addElement(Widget)
	Widget:registerEventHandler("gain_focus", f0_local5)
	f5_local0.playerName = f5_local4
	f5_local0.xuid = f5_local6
	f5_local0:setActionEventName("aar_leaderboard_button_action")
	return f5_local0
end

f0_local2 = function (f6_arg0, f6_arg1)
	f6_arg0.verticalList:removeAllChildren()
	local f6_local0 = Engine.GetLeaderboardData(f6_arg1.controller)
	if f6_local0 == nil or #f6_local0 == 0 then
		DebugPrint("No leaderboard data.")
		return 
	end
	for f6_local4, f6_local5 in ipairs(f6_local0) do
		local f6_local6 = LeaderboardViewList_Button(f6_local4, f6_local5, {
			left = 0,
			top = 0,
			right = 0,
			bottom = CoD.LeaderboardViewList.Height,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false,
			alignment = LUI.Alignment.Left,
			spacing = CoD.LeaderboardViewList.ColumnSpacing
		})
		f6_arg0:addElementToList(f6_local6)
		if f6_local4 == 1 and CoD.useController then
			f6_local6:processEvent({
				name = "gain_focus"
			})
		end
	end
end

f0_local4 = function (f7_arg0, f7_arg1)
	Engine.RequestLeaderboardData(f7_arg1, f7_arg0.filter)
end

CoD.LeaderboardViewList.new = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4)
	if f8_arg3 == nil then
		f8_arg3 = CoD.LB_FILTER_NONE
	end
	local f8_local0 = nil
	if f8_arg4 == true then
		f8_local0 = LUI.UIVerticalList.new(f8_arg1)
	else
		f8_local0 = CoD.ScrollingVerticalList.new(f8_arg1, f8_arg2)
	end
	f8_local0.id = "LeaderboardViewList"
	f8_local0.filter = f8_arg3
	f8_local0.requestLeaderboardData = f0_local4
	if f8_arg4 == true then
		f8_local0:registerEventHandler("leaderboardlist_update", f0_local3)
	else
		f8_local0:registerEventHandler("leaderboardlist_update", f0_local2)
	end
	return f8_local0
end

