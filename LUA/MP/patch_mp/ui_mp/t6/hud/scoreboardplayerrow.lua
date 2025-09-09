CoD.ScoreBoardPlayerRow = {}
CoD.ScoreBoardPlayerRow.PlayerListColumnWidth = 75
CoD.ScoreBoardPlayerRow.PlayerListHeaderHeight = 20
CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight = CoD.textSize.ExtraSmall
CoD.ScoreBoardPlayerRow.PlayerListColumnTextWidth = 55
CoD.ScoreBoardPlayerRow.PlayerListRowHeight = CoD.textSize.Default
CoD.ScoreBoardPlayerRow.PlayerListScoreColumnLeftOffset = 300
CoD.ScoreBoardPlayerRow.PlayerListPlayerNameColumnLeftOffset = 55
CoD.ScoreBoardPlayerRow.PlayerListAlpha = 0.7
CoD.ScoreBoardPlayerRow.LeaderBoardColumnCount = 5
CoD.ScoreBoardPlayerRow.ClientPingWidth = 60
CoD.ScoreBoardPlayerRow.RankImageContainerOffset = 20
CoD.ScoreBoardPlayerRow.StausImageContainerOffset = 45
CoD.ScoreBoardPlayerRow.PingBarCount = 4
CoD.ScoreBoardPlayerRow.RedPingColor = {}
CoD.ScoreBoardPlayerRow.RedPingColor.r = 0.7
CoD.ScoreBoardPlayerRow.RedPingColor.g = 0.1
CoD.ScoreBoardPlayerRow.RedPingColor.b = 0.1
CoD.ScoreBoardPlayerRow.YellowPingColor = {}
CoD.ScoreBoardPlayerRow.YellowPingColor.r = 0.7
CoD.ScoreBoardPlayerRow.YellowPingColor.g = 0.7
CoD.ScoreBoardPlayerRow.YellowPingColor.b = 0.1
CoD.ScoreBoardPlayerRow.GreenPingColor = {}
CoD.ScoreBoardPlayerRow.GreenPingColor.r = 0.1
CoD.ScoreBoardPlayerRow.GreenPingColor.g = 0.7
CoD.ScoreBoardPlayerRow.GreenPingColor.b = 0.1
CoD.ScoreBoardPlayerRow.TextSelfColor = {}
CoD.ScoreBoardPlayerRow.TextSelfColor.r = 1
CoD.ScoreBoardPlayerRow.TextSelfColor.g = 1
CoD.ScoreBoardPlayerRow.TextSelfColor.b = 0.2
CoD.ScoreBoardPlayerRow.TextColor = {}
CoD.ScoreBoardPlayerRow.TextColor.r = 1
CoD.ScoreBoardPlayerRow.TextColor.g = 1
CoD.ScoreBoardPlayerRow.TextColor.b = 1
CoD.ScoreBoardPlayerArrayRow = {}
local f0_local0 = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new(HudRef)
	InstanceRef:addElement(Widget)
	return Widget
end

local f0_local1 = function (f2_arg0, f2_arg1)
	local f2_local0 = f0_local0({
		leftAnchor = false,
		rightAnchor = true,
		left = -(CoD.ScoreBoardPlayerRow.PlayerListColumnWidth * (CoD.ScoreBoardPlayerRow.LeaderBoardColumnCount - f2_arg1) + CoD.ScoreBoardPlayerRow.ClientPingWidth),
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}, f2_arg0)
	f2_arg0:addElement(f2_local0)
	return f2_local0
end

local f0_local2 = function (f3_arg0, f3_arg1, f3_arg2)
	local textElement = LUI.UIText.new(f3_arg0)
	f3_arg1:addElement(textElement)
	f3_arg1.textElement = textElement
	
	f3_arg1.textElementText = f3_arg2
	textElement:setText(f3_arg2)
end

local f0_local3 = function (f4_arg0)
	return f4_arg0.textElement ~= nil
end

local f0_local4 = function (f5_arg0, f5_arg1, f5_arg2)
	if f5_arg1.textElementText == f5_arg2 then
		return 
	elseif f0_local3(f5_arg1) then
		f5_arg1.textElement:setText(f5_arg2)
		f5_arg1.textElementText = f5_arg2
		return 
	else
		f0_local2(f5_arg0, f5_arg1, f5_arg2)
	end
end

local f0_local5 = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = nil
	if not f0_local3(f6_arg0) then
		f6_local0 = {
			leftAnchor = true,
			rightAnchor = false,
			left = -CoD.ScoreBoardPlayerRow.PlayerListColumnTextWidth / 2,
			right = CoD.ScoreBoardPlayerRow.PlayerListColumnTextWidth / 2,
			topAnchor = false,
			bottomAnchor = false,
			top = -CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2,
			bottom = CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2,
			red = f6_arg2.r,
			green = f6_arg2.g,
			blue = f6_arg2.b,
			font = CoD.fonts.ExtraSmall,
			alignment = LUI.Alignment.Right
		}
		f6_arg0.color = f6_arg2
	elseif f6_arg0.color ~= f6_arg2 then
		f6_arg0.textElement:setRGB(f6_arg2.r, f6_arg2.g, f6_arg2.b)
		f6_arg0.color = f6_arg2
	end
	f0_local4(f6_local0, f6_arg0, f6_arg1)
end

function ScoreBoard_CreateScoreBoardTeamTitle(HudRef, InstanceRef)
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = -(CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2),
		bottom = CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2
	})
	local f7_local1 = f0_local0({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 280,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}, Widget)
	local f7_local2, f7_local3, f7_local4 = nil
	for f7_local5 = 1, CoD.ScoreBoardPlayerRow.LeaderBoardColumnCount, 1 do
		f0_local5(f0_local1(Widget, f7_local5), Engine.Localize(Engine.GetScoreBoardColumnName(HudRef, f7_local5 - 1)), CoD.ScoreBoardPlayerRow.TextColor)
	end
	return Widget
end

function ScoreBoard_UpdateScoreBoardTeamTitle(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	local f8_local0 = Engine.Localize(f8_arg1) .. " ( " .. f8_arg2 .. " ) "
	if f0_local3(f8_arg3) then
		f0_local4(nil, f8_arg3, f8_local0)
	else
		f0_local4({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = false,
			bottomAnchor = false,
			top = -CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2,
			bottom = CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2,
			font = CoD.fonts.ExtraSmall,
			alignment = LUI.Alignment.Left
		}, f8_arg3, f8_local0)
	end
end

function ScoreBoard_CreateVerticalPlayerList(f9_arg0, f9_arg1)
	local f9_local0 = CoD.ScoreBoardPlayerRow.PlayerListRowHeight
	f9_arg0.verticalPlayerList = LUI.UIVerticalList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		spacing = 0
	})
	f9_arg0:addElement(f9_arg0.verticalPlayerList)
end

function ScoreBoard_AddPlayerList(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
	local f10_local0 = 0
	if CoD.ScoreBoardPlayerArrayRow[f10_arg3] == nil then
		CoD.ScoreBoardPlayerArrayRow[f10_arg3] = {}
	end
	local f10_local1 = ""
	if f10_arg3 ~= CoD.TEAM_FREE then
		f10_local1 = CoD.GetTeamName(f10_arg3)
	end
	if f10_arg2.teamTitleRow == nil then
		f10_arg2.teamTitleRow = {}
	end
	f10_arg2.teamTitleRow[f10_arg3] = ScoreBoard_CreateScoreBoardTeamTitle(f10_arg0, #f10_arg1)
	f10_arg2:addElement(f10_arg2.teamTitleRow[f10_arg3])
	f10_arg2.teamTitleRow[f10_arg3]:makeNotFocusable()
	if f10_arg1 ~= nil and 0 < #f10_arg1 then
		for f10_local5, f10_local6 in pairs(f10_arg1) do
			local f10_local7 = ScoreBoard_CreateScoreBoardPlayerListRow(f10_arg0, f10_local5, f10_arg3)
			f10_local7.teamID = f10_arg3
			f10_local7:makeFocusable()
			f10_arg2:addElement(f10_local7)
			CoD.ScoreBoardPlayerArrayRow[f10_arg3][f10_local5] = f10_local7
		end
	end
end

function ScoreBoard_UpdatePlayerList(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	local f11_local0 = #f11_arg1 * CoD.ScoreBoardPlayerRow.PlayerListRowHeight
	local f11_local1 = ""
	if f11_arg3 ~= CoD.TEAM_FREE then
		f11_local1 = CoD.GetTeamName(f11_arg3)
	end
	ScoreBoard_UpdateScoreBoardTeamTitle(f11_arg0, f11_local1, #f11_arg1, f11_arg2.verticalPlayerList.teamTitleRow[f11_arg3])
	if #CoD.ScoreBoardPlayerArrayRow[f11_arg3] < #f11_arg1 then
		for f11_local2 = #CoD.ScoreBoardPlayerArrayRow[f11_arg3] + 1, #f11_arg1, 1 do
			local f11_local5 = ScoreBoard_CreateScoreBoardPlayerListRow(f11_arg0, f11_local2, f11_arg3)
			f11_local5.teamID = f11_arg3
			local f11_local6 = CoD.ScoreBoardPlayerArrayRow[f11_arg3][f11_local2 - 1]
			if f11_local6 == nil then
				f11_local6 = f11_arg2.verticalPlayerList.teamTitleRow[f11_arg3]
			end
			f11_local5:addElementAfter(f11_local6)
			f11_local5:makeFocusable()
			CoD.ScoreBoardPlayerArrayRow[f11_arg3][f11_local2] = f11_local5
		end
	elseif #f11_arg1 < #CoD.ScoreBoardPlayerArrayRow[f11_arg3] then
		local f11_local7 = false
		local f11_local2 = #CoD.ScoreBoardPlayerArrayRow[f11_arg3]
		for f11_local3 = #f11_arg1 + 1, f11_local2, 1 do
			if CoD.ScoreBoardPlayerArrayRow[f11_arg3][f11_local3].highlighted == true then
				f11_local7 = true
			end
			CoD.ScoreBoardPlayerArrayRow[f11_arg3][f11_local3]:close()
		end
		for f11_local3 = #f11_arg1 + 1, f11_local2, 1 do
			CoD.ScoreBoardPlayerArrayRow[f11_arg3][f11_local3] = nil
		end
		if f11_local7 == true then
			f11_arg2.verticalPlayerList:processEvent({
				name = "gain_focus"
			})
		end
	end
	for f11_local4, f11_local8 in pairs(f11_arg1) do
		if f11_arg3 == CoD.ScoreBoardPlayerArrayRow[f11_arg3][f11_local4].teamID then
			ScoreBoard_UpdateScoreBoardPlayerListRow(f11_arg0, CoD.ScoreBoardPlayerArrayRow[f11_arg3][f11_local4], f11_arg1[f11_local4], f11_local4)
		end
	end
end

local f0_local6 = function (f12_arg0, f12_arg1, f12_arg2, f12_arg3)
	local f12_local0 = CoD.GetFactionColor(CoD.GetFaction(), f12_arg1)
	local f12_local1 = {}
	local f12_local2 = 0.75
	if f12_arg0 % 2 == 1 then
		f12_local1.r = f12_local0.r * f12_local2
		f12_local1.g = f12_local0.g * f12_local2
		f12_local1.b = f12_local0.b * f12_local2
	else
		f12_local1.r = f12_local0.r
		f12_local1.g = f12_local0.g
		f12_local1.b = f12_local0.b
	end
	f12_local1.a = CoD.ScoreBoardPlayerRow.PlayerListAlpha
	f12_arg2:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = CoD.ChooseTeam.PlayerListRowHeight,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		red = f12_local1.r,
		green = f12_local1.g,
		blue = f12_local1.b,
		alpha = f12_local1.a,
		material = f12_arg3
	}))
end

local f0_local7 = function (f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	local f13_local0, f13_local1 = nil
	if CoD.isZombie == true then
		f13_local1 = RegisterMaterial("scorebar_zom_long_1")
	end
	f0_local6(f13_arg2, f13_arg3, f13_arg1, f13_local1)
	f13_arg1:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 50,
		bottom = CoD.ChooseTeam.PlayerListRowHeight,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		red = 0,
		green = 0,
		blue = 0,
		alpha = 0.1
	}))
end

local f0_local8 = function (f14_arg0, f14_arg1)
	local f14_local0 = 5
	local f14_local1 = CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight
	local f14_local2 = 2
	local f14_local3 = -2
	local f14_local4 = f14_local1 / 4
	local f14_local5 = 0.75
	local f14_local6 = (f14_local0 + f14_local2) * -f14_arg1
	local f14_local7 = LUI.UIImage.new({
		left = f14_local6 - f14_local0 / 2,
		top = f14_local4 * f14_arg1 + f14_local3,
		right = f14_local6 + f14_local0 / 2,
		bottom = 0,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = 0,
		green = 0,
		blue = 0,
		alpha = 0,
		material = CoD.GameStatus.GameStatusBackgroundBottomMaterial
	})
	f14_arg0:addElement(f14_local7)
	local f14_local8 = {
		alpha = 0
	}
	f14_local7:registerAnimationState("bar_4", {
		red = CoD.ScoreBoardPlayerRow.GreenPingColor.r,
		green = CoD.ScoreBoardPlayerRow.GreenPingColor.g,
		blue = CoD.ScoreBoardPlayerRow.GreenPingColor.b,
		alpha = f14_local5
	})
	if f14_arg1 < 2 then
		f14_local7:registerAnimationState("bar_1", {
			red = CoD.ScoreBoardPlayerRow.RedPingColor.r,
			green = CoD.ScoreBoardPlayerRow.RedPingColor.g,
			blue = CoD.ScoreBoardPlayerRow.RedPingColor.b,
			alpha = f14_local5
		})
	else
		f14_local7:registerAnimationState("bar_1", f14_local8)
	end
	if f14_arg1 < 3 then
		f14_local7:registerAnimationState("bar_2", {
			red = CoD.ScoreBoardPlayerRow.YellowPingColor.r,
			green = CoD.ScoreBoardPlayerRow.YellowPingColor.g,
			blue = CoD.ScoreBoardPlayerRow.YellowPingColor.b,
			alpha = f14_local5
		})
	else
		f14_local7:registerAnimationState("bar_2", f14_local8)
	end
	if f14_arg1 < 4 then
		f14_local7:registerAnimationState("bar_3", {
			red = CoD.ScoreBoardPlayerRow.GreenPingColor.r,
			green = CoD.ScoreBoardPlayerRow.GreenPingColor.g,
			blue = CoD.ScoreBoardPlayerRow.GreenPingColor.b,
			alpha = f14_local5
		})
	else
		f14_local7:registerAnimationState("bar_3", f14_local8)
	end
	f14_arg0.clientPingBar = f14_local7
	return f14_local7
end

local f0_local9 = function (f15_arg0)
	local f15_local0 = CoD.ScoreBoardPlayerRow.GreenPingColor
	if f15_arg0 > 200 then
		f15_local0 = CoD.ScoreBoardPlayerRow.RedPingColor
	elseif f15_arg0 > 100 then
		f15_local0 = CoD.ScoreBoardPlayerRow.YellowPingColor
	end
	return f15_local0
end

local f0_local10 = function (f16_arg0)
	local f16_local0 = {}
	local f16_local1 = CoD.ScoreBoardPlayerRow.PingBarCount
	for f16_local2 = 1, f16_local1, 1 do
		f16_local0[f16_local2] = f0_local8(f16_arg0, f16_local2)
	end
	f16_arg0.clientPingInfo = f16_local0
end

local f0_local11 = function (f17_arg0, f17_arg1)
	local f17_local0 = CoD.ScoreBoardPlayerRow.GreenPingColor
	local f17_local1 = "bar_4"
	if f17_arg1 > 199 then
		if f17_arg1 > 299 then
			f17_local1 = "bar_1"
		else
			f17_local1 = "bar_2"
		end
	elseif f17_arg1 > 99 then
		f17_local1 = "bar_3"
	end
	if f17_arg0.pingAnimationName ~= f17_local1 then
		f17_arg0.pingAnimationName = f17_local1
		for f17_local5, f17_local6 in ipairs(f17_arg0.clientPingInfo) do
			f17_local6:animateToState(f17_local1)
		end
	end
end

function ScoreBoard_PlayerListRowGainFocus(f18_arg0, f18_arg1)
	f18_arg0.opticalBorder:animateToState("enabled")
	f18_arg0.highlighted = true
	LUI.UIButton.gainFocus(f18_arg0, f18_arg1)
end

function ScoreBoard_PlayerListRowLoseFocus(f19_arg0, f19_arg1)
	f19_arg0.opticalBorder:animateToState("disabled")
	f19_arg0.highlighted = false
	LUI.UIButton.loseFocus(f19_arg0, f19_arg1)
end

function ScoreBoard_CreateScoreBoardPlayerListRow(f20_arg0, f20_arg1, f20_arg2)
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = CoD.ScoreBoardPlayerRow.PlayerListRowHeight,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	Widget:registerEventHandler("gain_focus", ScoreBoard_PlayerListRowGainFocus)
	Widget:registerEventHandler("lose_focus", ScoreBoard_PlayerListRowLoseFocus)
	f0_local7(f20_arg0, Widget, f20_arg1, f20_arg2)
	Widget.rankContainer = f0_local0({
		left = 0,
		top = 0,
		right = 20,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	}, Widget)
	Widget.rankImageContainer = f0_local0({
		left = CoD.ScoreBoardPlayerRow.RankImageContainerOffset,
		top = 0,
		right = CoD.ScoreBoardPlayerRow.RankImageContainerOffset + CoD.ScoreBoardPlayerRow.PlayerListHeaderHeight,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	}, Widget)
	Widget.statusImageContainer = f0_local0({
		left = CoD.ScoreBoardPlayerRow.StausImageContainerOffset,
		top = 0,
		right = CoD.ScoreBoardPlayerRow.StausImageContainerOffset + CoD.ScoreBoardPlayerRow.PlayerListHeaderHeight,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	}, Widget)
	Widget.playerNameContainer = f0_local0({
		left = CoD.ScoreBoardPlayerRow.PlayerListPlayerNameColumnLeftOffset + CoD.ScoreBoardPlayerRow.PlayerListHeaderHeight,
		top = 0,
		right = 280,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	}, Widget)
	Widget.scoreColumn1 = f0_local1(Widget, 1)
	Widget.scoreColumn2 = f0_local1(Widget, 2)
	Widget.scoreColumn3 = f0_local1(Widget, 3)
	Widget.scoreColumn4 = f0_local1(Widget, 4)
	Widget.scoreColumn5 = f0_local1(Widget, 5)
	f0_local10(Widget)
	
	local opticalBorder = CoD.Border.new(2, 1, 1, 1, 0)
	opticalBorder:registerAnimationState("disabled", {
		alpha = 0
	})
	opticalBorder:registerAnimationState("enabled", {
		alpha = 1
	})
	Widget:addElement(opticalBorder)
	Widget.opticalBorder = opticalBorder
	
	return Widget
end

function ScoreBoard_UpdateScoreBoardPlayerListRow(f21_arg0, f21_arg1, f21_arg2, f21_arg3)
	local f21_local0 = nil
	if CoD.isZombie == true then
		f21_local0 = CoD.Zombie.PlayerColors[(f21_arg3 - 1) % 4 + 1]
	else
		f21_local0 = CoD.ScoreBoardPlayerRow.TextColor
		if f21_arg2.isSelf then
			f21_local0 = CoD.ScoreBoardPlayerRow.TextSelfColor
		end
		if f0_local3(f21_arg1.rankContainer) then
			f0_local4(nil, f21_arg1.rankContainer, f21_arg2.rank)
		else
			f0_local4({
				left = 5,
				top = -CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2,
				right = 0,
				bottom = CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2,
				leftAnchor = true,
				topAnchor = false,
				rightAnchor = true,
				bottomAnchor = false,
				font = CoD.fonts.ExtraSmall,
				alignment = LUI.Alignment.Left
			}, f21_arg1.rankContainer, f21_arg2.rank)
		end
	end
	if f21_arg1.rankIconMaterial ~= f21_arg2.rankIcon then
		f21_arg1.rankIconMaterial = f21_arg2.rankIcon
		if f21_arg1.rankIconImage then
			f21_arg1.rankIconImage:setImage(f21_arg1.rankIconMaterial)
		else
			local f21_local1 = LUI.UIImage.new({
				left = 0,
				top = -CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2,
				right = 0,
				bottom = CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2,
				leftAnchor = true,
				topAnchor = false,
				rightAnchor = true,
				bottomAnchor = false,
				material = f21_arg2.rankIcon
			})
			f21_arg1.rankImageContainer:addElement(f21_local1)
			f21_arg1.rankIconImage = f21_local1
		end
	end
	if f21_arg1.statusIconMaterial ~= f21_arg2.statusIcon then
		if f21_arg1.statusIconImage then
			if not f21_arg1.statusIconMaterial then
				f21_arg1.statusIconImage:animateToState("show")
			elseif not f21_arg2.statusIcon then
				f21_arg1.statusIconImage:animateToState("hide")
			end
			f21_arg1.statusIconImage:setImage(f21_arg2.statusIcon)
		else
			local f21_local1 = LUI.UIImage.new({
				left = 0,
				top = -CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2,
				right = 0,
				bottom = CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2,
				leftAnchor = true,
				topAnchor = false,
				rightAnchor = true,
				bottomAnchor = false,
				material = f21_arg2.statusIcon,
				alpha = 1
			})
			f21_local1:registerAnimationState("hide", {
				alpha = 0
			})
			f21_local1:registerAnimationState("show", {
				alpha = 1
			})
			f21_arg1.statusImageContainer:addElement(f21_local1)
			f21_arg1.statusIconImage = f21_local1
		end
		f21_arg1.statusIconMaterial = f21_arg2.statusIcon
	end
	local f21_local1 = f21_arg1.playerNameContainer
	if f0_local3(f21_local1) then
		f0_local4(nil, f21_local1, f21_arg2.playerName)
		if f21_local1.color ~= f21_local0 then
			f21_local1.textElement:setRGB(f21_local0.r, f21_local0.g, f21_local0.b)
			f21_local1.color = f21_local0
		end
	else
		f0_local4({
			left = 0,
			top = -CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2,
			right = 0,
			bottom = CoD.ScoreBoardPlayerRow.PlayerListRowTextHeight / 2,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = false,
			font = CoD.fonts.ExtraSmall,
			alignment = LUI.Alignment.Left,
			red = f21_local0.r,
			green = f21_local0.g,
			blue = f21_local0.b
		}, f21_local1, f21_arg2.playerName)
		f21_local1.color = f21_local0
	end
	f0_local5(f21_arg1.scoreColumn1, f21_arg2.scoreBoardColumn1, f21_local0)
	f0_local5(f21_arg1.scoreColumn2, f21_arg2.scoreBoardColumn2, f21_local0)
	f0_local5(f21_arg1.scoreColumn3, f21_arg2.scoreBoardColumn3, f21_local0)
	f0_local5(f21_arg1.scoreColumn4, f21_arg2.scoreBoardColumn4, f21_local0)
	f0_local5(f21_arg1.scoreColumn5, f21_arg2.scoreBoardColumn5, f21_local0)
	f0_local11(f21_arg1, f21_arg2.ping)
end

