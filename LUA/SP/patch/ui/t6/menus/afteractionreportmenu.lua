require("T6.CoDBase")
require("T6.LeaderboardViewList")
require("T6.LeaderboardList")
require("T6.Menus.AARUtility")
require("T6.MFTabManager")
require("T6.Menus.MissionLeaderboard")
CoD.AfterActionReport = {}
CoD.AfterActionReport.TabWdith = 840
CoD.AfterActionReport.TabHeight = 600 - 2 * CoD.ButtonPrompt.Height
CoD.AfterActionReport.TopBorder = 60
CoD.AfterActionReport.SideBorder = 50
CoD.AfterActionReport.ChallengesTabSideBorder = 25
CoD.AfterActionReport.LightAlpha = 0.3
CoD.AfterActionReport.LeaderboardTab = {}
local f0_local0 = nil
CoD.AfterActionReport.FadeIn = function (f1_arg0)
	if f1_arg0 ~= nil then
		f1_arg0:beginAnimation("fade_in", 200)
		f1_arg0:setAlpha(0.3)
	end
end

CoD.AfterActionReport.AddLevelImageBackground = function (f2_arg0)
	local f2_local0 = 500
	local f2_local1 = 2
	local f2_local2 = RegisterMaterial("menu_visor_ms_" .. CoD.AfterActionReport.CurrentMap)
	local f2_local3 = LUI.UIStreamedImage.new()
	f2_local3:setLeftRight(false, false, -(f2_local0 * f2_local1) / 2, f2_local0 * f2_local1 / 2)
	f2_local3:setTopBottom(false, false, -f2_local0 / 2, f2_local0 / 2)
	f2_local3:setImage(f2_local2)
	f2_local3:setAlpha(0)
	f2_local3:registerEventHandler("streamed_image_ready", CoD.AfterActionReport.FadeIn)
	f2_arg0:addElement(f2_local3)
end

local f0_local1 = function (f3_arg0, f3_arg1)
	local f3_local0 = LUI.UIImage.new()
	f3_local0:setLeftRight(true, true, 0, 0)
	f3_local0:setTopBottom(true, true, 0, 0)
	if f3_arg1 then
		f3_local0:setRGB(f3_arg1.r, f3_arg1.g, f3_arg1.b)
		f3_local0:setAlpha(f3_arg1.a)
	else
		f3_local0:setRGB(1, 0, 0)
		f3_local0:setAlpha(0.2)
	end
	f3_arg0:addElement(f3_local0)
end

local f0_local2 = function (f4_arg0, f4_arg1)
	local f4_local0 = LUI.UIImage.new()
	f4_local0:setLeftRight(true, true, 0, 0)
	f4_local0:setTopBottom(true, true, 0, 0)
	if f4_arg1 then
		f4_local0:setRGB(f4_arg1.r, f4_arg1.g, f4_arg1.b)
		f4_local0:setAlpha(f4_arg1.a)
	else
		f4_local0:setRGB(1, 0, 0)
		f4_local0:setAlpha(0.2)
	end
	f4_arg0:addElement(f4_local0)
end

function AddDipBorder(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	local f5_local0 = RegisterMaterial("menu_sp_cac_single_dip")
	local f5_local1 = 1
	local f5_local2 = f5_arg3.r
	local f5_local3 = f5_arg3.g
	local f5_local4 = f5_arg3.b
	local f5_local5 = f5_arg3.a
	local f5_local6 = LUI.UIImage.new()
	f5_local6:setLeftRight(true, true, 0, 0)
	f5_local6:setTopBottom(true, false, 0, f5_local1)
	f5_local6:setRGB(f5_local2, f5_local3, f5_local4)
	f5_local6:setAlpha(f5_local5)
	f5_arg0:addElement(f5_local6)
	local f5_local7 = LUI.UIImage.new()
	f5_local7:setLeftRight(true, false, 0, f5_local1)
	f5_local7:setTopBottom(true, true, f5_local1, -f5_local1)
	f5_local7:setRGB(f5_local2, f5_local3, f5_local4)
	f5_local7:setAlpha(f5_local5)
	f5_arg0:addElement(f5_local7)
	local f5_local8 = LUI.UIImage.new()
	f5_local8:setLeftRight(false, true, -f5_local1, 0)
	f5_local8:setTopBottom(true, true, f5_local1, -f5_local1)
	f5_local8:setRGB(f5_local2, f5_local3, f5_local4)
	f5_local8:setAlpha(f5_local5)
	f5_arg0:addElement(f5_local8)
	local f5_local9 = f5_arg1 / f5_arg2
	local f5_local10 = 128
	if f5_local9 < f5_local10 then
		f5_local10 = f5_local9
	end
	local f5_local11 = f5_local10 * 0.5
	local f5_local12 = 8
	local f5_local13 = f5_local9 / 2 - f5_local11
	if f5_local13 < 0 then
		f5_local13 = 0
	end
	local f5_local14 = 0
	local f5_local15 = 0
	for f5_local16 = 1, f5_arg2, 1 do
		local f5_local19 = f5_local16
		local f5_local20 = f5_local15 + f5_local13
		local f5_local21 = f5_local20 + f5_local10
		local f5_local22 = f5_local15 + f5_local9
		if f5_local13 > 0 then
			local f5_local23 = LUI.UIImage.new()
			f5_local23:setLeftRight(true, false, f5_local15, f5_local20)
			f5_local23:setTopBottom(false, true, -f5_local1, 0)
			f5_local23:setRGB(f5_local2, f5_local3, f5_local4)
			f5_local23:setAlpha(f5_local5)
			f5_arg0:addElement(f5_local23)
			local f5_local24 = LUI.UIImage.new()
			f5_local24:setLeftRight(true, false, f5_local21, f5_local22)
			f5_local24:setTopBottom(false, true, -f5_local1, 0)
			f5_local24:setRGB(f5_local2, f5_local3, f5_local4)
			f5_local24:setAlpha(f5_local5)
			f5_arg0:addElement(f5_local24)
		end
		local f5_local23 = LUI.UIImage.new()
		f5_local23:setLeftRight(true, false, f5_local20, f5_local21)
		f5_local23:setTopBottom(false, true, -f5_local12, 0)
		f5_local23:setRGB(f5_local2, f5_local3, f5_local4)
		f5_local23:setAlpha(f5_local5)
		f5_local23:setImage(f5_local0)
		f5_arg0:addElement(f5_local23)
		f5_local15 = f5_local22
	end
end

CoD.AfterActionReport.AddGeneralStats = function (f6_arg0, f6_arg1)
	local f6_local0 = LUI.UIVerticalList.new()
	f6_local0:setLeftRight(true, true, 0, 0)
	f6_local0:setTopBottom(true, true, 0, 0)
	if f6_arg1.label then
		local f6_local1 = "Default"
		local f6_local2 = 1
		if string.find(f6_arg1.label, "\n") ~= nil then
			f6_local2 = 2
		end
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, false, 0, CoD.textSize[f6_local1] * f6_local2)
		f6_local0:addElement(Widget)
		local f6_local4 = LUI.UIText.new()
		f6_local4:setLeftRight(true, true, 0, 0)
		f6_local4:setTopBottom(true, false, 0, CoD.textSize[f6_local1])
		f6_local4:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
		f6_local4:setFont(CoD.fonts[f6_local1])
		f6_local4:setText(f6_arg1.label)
		f6_local4:setAlignment(LUI.Alignment.Center)
		Widget:addElement(f6_local4)
	end
	if f6_arg1.count then
		local f6_local1 = "Condensed"
		local f6_local2 = LUI.UIText.new()
		f6_local2:setLeftRight(true, true, 0, 0)
		f6_local2:setTopBottom(true, false, 0, CoD.textSize[f6_local1])
		if f6_arg1.countTextColor then
			f6_local2:setRGB(f6_arg1.countTextColor.r, f6_arg1.countTextColor.g, f6_arg1.countTextColor.b)
			f6_local2:setAlpha(1)
		else
			f6_local2:setRGB(1, 1, 1)
			f6_local2:setAlpha(1)
		end
		f6_local2:setFont(CoD.fonts[f6_local1])
		f6_local2:setText(f6_arg1.count)
		f6_local2:setAlignment(LUI.Alignment.Center)
		f6_local0:addElement(f6_local2)
	end
	if f6_arg1.otherCount then
		local f6_local1 = "Default"
		local f6_local2 = LUI.UIText.new()
		f6_local2:setLeftRight(true, true, 0, 0)
		f6_local2:setTopBottom(true, false, 0, CoD.textSize[f6_local1])
		if f6_arg1.otherCountTextColor then
			f6_local2:setRGB(f6_arg1.otherCountTextColor.r, f6_arg1.otherCountTextColor.g, f6_arg1.otherCountTextColor.b)
			f6_local2:setAlpha(1)
		else
			f6_local2:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
			f6_local2:setAlpha(1)
		end
		f6_local2:setFont(CoD.fonts[f6_local1])
		f6_local2:setText(f6_arg1.otherCount)
		f6_local2:setAlignment(LUI.Alignment.Center)
		f6_local0:addElement(f6_local2)
	end
	if f6_arg1.multiplier then
		local f6_local1 = "Default"
		local f6_local2 = LUI.UIText.new()
		f6_local2:setLeftRight(true, true, 0, 0)
		f6_local2:setTopBottom(true, false, 0, CoD.textSize[f6_local1])
		f6_local2:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
		f6_local2:setFont(CoD.fonts[f6_local1])
		f6_local2:setText("x" .. f6_arg1.multiplier)
		f6_local2:setAlignment(LUI.Alignment.Center)
		f6_local0:addElement(f6_local2)
	elseif f6_arg1.score then
		local f6_local1 = "Default"
		local f6_local2 = LUI.UIText.new()
		f6_local2:setLeftRight(true, true, 0, 0)
		f6_local2:setTopBottom(true, false, 0, CoD.textSize[f6_local1])
		f6_local2:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
		f6_local2:setFont(CoD.fonts[f6_local1])
		f6_local2:setText(f6_arg1.score)
		f6_local2:setAlignment(LUI.Alignment.Center)
		f6_local0:addElement(f6_local2)
	end
	f6_arg0:addElement(f6_local0)
end

function BuildKillBonusPane(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f7_arg1 / 2)
	Widget:setTopBottom(true, false, 0, f7_arg2 / 2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f7_arg1 / 2, 0)
	Widget:setTopBottom(true, false, 0, f7_arg2 / 2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f7_arg1 / 2)
	Widget:setTopBottom(true, true, f7_arg2 / 2 + f7_arg2 * 0.07, 0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f7_arg1 / 2, 0)
	Widget:setTopBottom(true, true, f7_arg2 / 2 + f7_arg2 * 0.07, 0)
	f7_arg0:addElement(Widget)
	f7_arg0:addElement(Widget)
	f7_arg0:addElement(Widget)
	f7_arg0:addElement(Widget)
	CoD.AfterActionReport.AddGeneralStats(Widget, f7_arg3.headshots)
	CoD.AfterActionReport.AddGeneralStats(Widget, f7_arg3.explosivekills)
	CoD.AfterActionReport.AddGeneralStats(Widget, f7_arg3.stunkills)
	CoD.AfterActionReport.AddGeneralStats(Widget, f7_arg3.meleekills)
end

function BuildBonusPane(f8_arg0, f8_arg1, f8_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f8_arg1 / 2)
	Widget:setTopBottom(true, true, 0, 0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f8_arg1 / 2, 0)
	Widget:setTopBottom(true, true, 0, 0)
	f8_arg0:addElement(Widget)
	f8_arg0:addElement(Widget)
	if f8_arg2.levelScore.count == "--" then
		f8_arg2.difficulty.count = "--"
	end
	if f8_arg2.levelScore.otherCount == "--" then
		f8_arg2.difficulty.otherCount = "--"
	end
	CoD.AfterActionReport.AddGeneralStats(Widget, f8_arg2.difficulty)
	CoD.AfterActionReport.AddGeneralStats(Widget, f8_arg2.challenges)
end

CoD.AfterActionReport.LeaderboardTab_ComparePaneTotalScoreRow = function (f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = 90
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, f9_local0)
	AddDipBorder(Widget, f9_arg1, 1, f9_arg2)
	local f9_local2 = f9_arg0.levelScore
	f9_local2.score = nil
	CoD.AfterActionReport.AddGeneralStats(Widget, f9_local2)
	return Widget
end

CoD.AfterActionReport.StatsPaneTotalScore = function (f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = 90
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, f10_local0)
	local f10_local2 = "Default"
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, CoD.textSize[f10_local2], 0)
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f10_arg1 / 2)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f10_arg1 / 2, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local f10_local6 = {
		label = Engine.Localize("MENU_LATEST_SCORE_CAPS"),
		count = f10_arg0.levelScore.count
	}
	local f10_local7 = {
		label = Engine.Localize("MENU_HIGH_SCORE_CAPS"),
		count = f10_arg0.levelScore.otherCount,
		countTextColor = CoD.AARUtility.LocalPlayerBestStatColor
	}
	CoD.AfterActionReport.AddGeneralStats(Widget, f10_local6)
	CoD.AfterActionReport.AddGeneralStats(Widget, f10_local7)
	AddDipBorder(Widget, f10_arg1, 2, f10_arg2)
	return Widget
end

CoD.AfterActionReport.CreateStatsPane = function (f11_arg0)
	local f11_local0 = {
		r = 1,
		g = 1,
		b = 1,
		a = 0.1
	}
	local f11_local1 = 12
	local f11_local2 = 12
	local Widget = LUI.UIElement.new()
	local f11_local4 = 390
	Widget:setLeftRight(false, false, -f11_local4 / 2, f11_local4 / 2)
	Widget:setTopBottom(true, true, 0, 0)
	local f11_local5 = LUI.UIVerticalList.new()
	f11_local5:setLeftRight(true, true, 0, 0)
	f11_local5:setTopBottom(true, true, 0, 0)
	f11_local5:setSpacing(0)
	Widget:addElement(f11_local5)
	if f11_arg0.scoreRowUIFunction then
		f11_local5:addElement(f11_arg0:scoreRowUIFunction(f11_local4, f11_local0))
	end
	f11_local5:addSpacer(f11_local1)
	local f11_local6 = 125
	local f11_local7 = 115
	local f11_local8 = 265
	local f11_local9 = LUI.UIHorizontalList.new()
	f11_local9:setLeftRight(true, true, 0, 0)
	f11_local9:setTopBottom(true, false, 0, f11_local8)
	f11_local9:setSpacing(0)
	f11_local5:addElement(f11_local9)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f11_local6)
	Widget:setTopBottom(true, true, 0, 0)
	f11_local9:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f11_local6)
	Widget:setTopBottom(true, false, 0, f11_local7)
	AddDipBorder(Widget, f11_local6, 1, f11_local0)
	CoD.AfterActionReport.AddGeneralStats(Widget, f11_arg0.kills)
	Widget:addElement(Widget)
	local f11_local12 = f11_local6
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f11_local7 + f11_local2, 0)
	AddDipBorder(Widget, f11_local12, 1, f11_local0)
	CoD.AfterActionReport.AddGeneralStats(Widget, f11_arg0.mechanicalkills)
	Widget:addElement(Widget)
	f11_local9:addSpacer(f11_local2)
	local f11_local14 = f11_local4 - f11_local6 - f11_local2
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f11_local14)
	Widget:setTopBottom(true, true, 0, 0)
	AddDipBorder(Widget, f11_local14, 2, f11_local0)
	f11_local9:addElement(Widget)
	BuildKillBonusPane(Widget, f11_local14, f11_local8, f11_arg0)
	f11_local5:addSpacer(f11_local1)
	local f11_local16 = 115
	local f11_local17 = LUI.UIHorizontalList.new()
	f11_local17:setLeftRight(true, true, 0, 0)
	f11_local17:setTopBottom(true, false, 0, f11_local16)
	f11_local17:setSpacing(0)
	f11_local5:addElement(f11_local17)
	local f11_local18 = f11_local4
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	AddDipBorder(Widget, f11_local18, 2, f11_local0)
	f11_local17:addElement(Widget)
	BuildBonusPane(Widget, f11_local18, f11_arg0)
	return Widget
end

local f0_local3 = function (f12_arg0)
	local f12_local0 = " (" .. f12_arg0 + 1 .. ")"
	if f12_arg0 == 0 then
		return Engine.Localize("MENU_RECRUIT_CAPS") .. f12_local0
	elseif f12_arg0 == 1 then
		return Engine.Localize("MENU_REGULAR_CAPS") .. f12_local0
	elseif f12_arg0 == 2 then
		return Engine.Localize("MENU_HARDENED_CAPS") .. f12_local0
	elseif f12_arg0 == 3 then
		return Engine.Localize("MENU_VETERAN_CAPS") .. " (" .. f12_arg0 + 2 .. ")"
	else
		return Engine.Localize("MPUI_NONE_CAPS")
	end
end

local f0_local4 = function (f13_arg0)
	return f0_local3(f13_arg0)
end

local f0_local5 = function (f14_arg0, f14_arg1, f14_arg2)
	if f14_arg2 == nil then
		f14_arg2 = false
	end
	local f14_local0 = {}
	local f14_local1 = f14_arg1.countLookupFunction
	local f14_local2 = f14_arg1.otherCountLookupFunction
	local f14_local3 = f14_arg1.scoreLookupFunction
	local f14_local4 = f14_arg1.multiplierLookupFunction
	for f14_local11, f14_local12 in ipairs(f14_arg1) do
		local f14_local13 = {}
		if f14_local12.labelUnlocalized then
			f14_local13.label = Engine.Localize(f14_local12.labelUnlocalized)
		end
		local f14_local8 = f14_local1(f14_arg0, f14_local12.countLookup)
		local f14_local9 = f14_local2(f14_arg0, f14_local12.countLookup)
		if f14_local12.countParser then
			f14_local13.count = f14_local12.countParser(f14_local8)
			if f14_local12.otherCountParser and (f14_arg2 == nil or not f14_arg2) then
				f14_local13.otherCount = f14_local12.otherCountParser(f14_local9)
			elseif not f14_arg2 then
				f14_local13.otherCount = f14_local12.countParser(f14_local9)
			else
				f14_local13.otherCount = "--"
			end
		else
			f14_local13.count = f14_local8
			if not f14_arg2 then
				f14_local13.otherCount = f14_local9
			else
				f14_local13.otherCount = "--"
			end
		end
		local f14_local10 = nil
		if f14_local12.scoreLookup then
			f14_local10 = f14_local12.scoreLookup
		else
			f14_local10 = f14_local12.countLookup .. "Score"
		end
		f14_local13.score = f14_local3(f14_arg0, f14_local10)
		if f14_local12.multiplier then
			f14_local13.multiplier = f14_local4(f14_arg0, f14_local12.key)
		end
		if f14_arg1.otherCountTextColor then
			f14_local13.otherCountTextColor = f14_arg1.otherCountTextColor
		end
		if f14_arg1.countTextColor then
			f14_local13.countTextColor = f14_arg1.countTextColor
		end
		f14_local0[f14_local12.key] = f14_local13
	end
	if f14_local0.levelScore ~= nil and f14_local0.levelScore.count == "0" then
		for f14_local11, f14_local12 in pairs(f14_local0) do
			if tonumber(f14_local12.count) ~= nil then
				f14_local12.count = "--"
			end
		end
	end
	if f14_local0.levelScore ~= nil and f14_local0.levelScore.otherCount == "0" then
		for f14_local11, f14_local12 in pairs(f14_local0) do
			if tonumber(f14_local12.otherCount) ~= nil then
				f14_local12.otherCount = "--"
			end
		end
	end
	f14_local0.scoreRowUIFunction = f14_arg1.scoreRowUIFunction
	return f14_local0
end

local f0_local6 = function (f15_arg0)
	local f15_local0 = {
		scoreRowUIFunction = CoD.AfterActionReport.StatsPaneTotalScore,
		countLookupFunction = UIExpression.GetLastSessionStat,
		otherCountLookupFunction = UIExpression.GetLevelBestStat,
		scoreLookupFunction = UIExpression.GetLastSessionStat,
		multiplierLookupFunction = UIExpression.GetStatScoreMultiplier,
		countTextColor = {
			r = 1,
			g = 1,
			b = 1
		},
		otherCountTextColor = CoD.AARUtility.LocalPlayerBestStatColor
	}
	local f15_local1 = {
		key = "headshots",
		countLookup = "headshots",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MPUI_HEADSHOTS_CAPS",
		countParser = CoD.separateNumberWithCommas
	}
	local f15_local2 = {
		key = "explosivekills",
		countLookup = "explosivekills",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MENU_EXPLOSIVE_CAPS",
		countParser = CoD.separateNumberWithCommas
	}
	local f15_local3 = {
		key = "stunkills",
		countLookup = "stunkills",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MENU_STUN_CAPS",
		countParser = CoD.separateNumberWithCommas
	}
	local f15_local4 = {
		key = "meleekills",
		countLookup = "meleekills",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MENU_MELEE_CAPS",
		countParser = CoD.separateNumberWithCommas
	}
	local f15_local5 = {
		key = "kills",
		countLookup = "kills",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MPUI_KILLS_CAPS",
		countParser = CoD.separateNumberWithCommas
	}
	local f15_local6 = {
		key = "mechanicalkills",
		countLookup = "mechanicalkills",
		scoreLookup = "mechanicalkillsscore",
		multiplier = true,
		labelUnlocalized = "MENU_ROBOT_KILLS_CAPS",
		countParser = CoD.separateNumberWithCommas
	}
	local f15_local7 = {
		key = "explosivekills",
		countLookup = "explosivekills",
		scoreLookup = "explosiveKillsScore",
		multiplier = true,
		labelUnlocalized = "MENU_EXPLOSIVE_CAPS",
		countParser = CoD.separateNumberWithCommas
	}
	local f15_local8 = {
		key = "headshots",
		countLookup = "headshots",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MPUI_HEADSHOTS_CAPS",
		countParser = CoD.separateNumberWithCommas
	}
	local f15_local9 = {
		key = "challenges",
		countLookup = "challengesComplete",
		scoreLookup = "challengesScore",
		multiplier = true,
		labelUnlocalized = "MENU_CHALLENGES_CAPS",
		countParser = CoD.separateNumberWithCommas
	}
	local f15_local10 = {
		key = "difficulty",
		countLookup = "difficulty",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MENU_DIFFICULTY_CAPS",
		countParser = f0_local4
	}
	local f15_local11 = {
		key = "levelScore",
		countLookup = "levelScore",
		scoreLookup = "levelScore",
		multiplier = nil,
		labelUnlocalized = nil,
		countParser = CoD.separateNumberWithCommas
	}
	f15_local0[1] = f15_local1
	f15_local0[2] = f15_local2
	f15_local0[3] = f15_local3
	f15_local0[4] = f15_local4
	f15_local0[5] = f15_local5
	f15_local0[6] = f15_local6
	f15_local0[7] = f15_local7
	f15_local0[8] = f15_local8
	f15_local0[9] = f15_local9
	f15_local0[10] = f15_local10
	f15_local0[11] = f15_local11
	return f0_local5(f15_arg0, f15_local0)
end

CoD.AfterActionReport.StatsTab = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, CoD.AfterActionReport.TopBorder, 0)
	Widget:addElement(Widget)
	Widget:addElement(CoD.AfterActionReport.CreateStatsPane(f0_local6(InstanceRef)))
	CoD.AfterActionReport.AddLevelImageBackground(Widget)
	return Widget
end

CoD.AfterActionReport.ChallengesTab = function (f17_arg0, f17_arg1)
	local f17_local0 = LUI.UIContainer.new()
	f17_local0:setLeftRight(true, true, 0, 0)
	f17_local0:setTopBottom(true, true, 0, 0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, CoD.AfterActionReport.TopBorder, 0)
	f17_local0:addElement(Widget)
	CoD.AfterActionReport.AddLevelImageBackground(f17_local0)
	local f17_local2 = CoD.AfterActionReport.ChallengesTabSideBorder
	local f17_local3 = "Condensed"
	local f17_local4 = LUI.UIText.new()
	f17_local4:setLeftRight(true, true, 0, 0)
	f17_local4:setTopBottom(true, false, 6, 6 + CoD.textSize[f17_local3])
	f17_local4:setFont(CoD.fonts.Condensed)
	f17_local4:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	f17_local4:setAlignment(LUI.Alignment.Center)
	Widget:addElement(f17_local4)
	local f17_local5 = #CoD.AfterActionReport.ChallengeTableResults
	local f17_local6 = CoD.AfterActionReport.ChallengesCompletedCount
	f17_local4:setText(f17_local6 .. " " .. Engine.Localize("MENU_OF_CAPS") .. " " .. f17_local5 .. " " .. Engine.Localize("MENU_COMPLETED_CAPS"))
	local f17_local7 = UIExpression.GetNextUnlockable(f17_arg1, f17_local6)
	local f17_local8 = CoD.fonts.Default
	local f17_local9 = CoD.textSize.Condensed
	local f17_local10 = nil
	local f17_local11 = 0
	local f17_local12 = nil
	local f17_local13 = false
	local f17_local14 = "MENU_CHALLENGES_TO_UNLOCK_THE"
	for f17_local18 in string.gmatch(f17_local7, "[^_]+") do
		if f17_local18 == "PERKS" then
			f17_local13 = true
			f17_local14 = "MENU_CHALLENGES_TO_UNLOCK"
			break
		end
	end
	if f17_local7 ~= nil or f17_local7 ~= "" then
		f17_local12 = UIExpression.GetNumberOfChallengesForUnlock(f17_arg1, f17_local7)
		if f17_local12 ~= nil and f17_local12 ~= 0 then
			f17_local10 = f17_local12
			f17_local11 = f17_local9 * 1.05
		end
	end
	f17_local15 = CoD.textSize[f17_local3] + 12 + f17_local11
	Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f17_local2, -f17_local2)
	Widget:setTopBottom(true, false, f17_local15, 300)
	Widget:addElement(Widget)
	for f17_local17 = 1, #CoD.AfterActionReport.ChallengeTableResults, 1 do
		Widget:addElement(CoD.AfterActionReport.CreateChallengeRow(f17_local17, CoD.AfterActionReport.ChallengeTableResults[f17_local17]))
	end
	if f17_local10 ~= nil and f17_local10 ~= 0 then
		f17_local17 = f17_local15 - f17_local9 * 1.05
		f17_local18 = {
			text = Engine.Localize("MENU_COMPLETE") .. " " .. f17_local10 .. " " .. Engine.Localize(f17_local14) .. " ",
			metrics = {}
		}
		local f17_local19 = f17_local18.metrics
		local f17_local20 = f17_local18.metrics
		local f17_local21 = f17_local18.metrics
		local f17_local22 = f17_local18.metrics
		local f17_local23, f17_local24, f17_local25, f17_local26 = GetTextDimensions(f17_local18.text, f17_local8, f17_local9)
		f17_local22.textBottom = f17_local26
		f17_local21.textRight = f17_local25
		f17_local20.textTop = f17_local24
		f17_local19.textLeft = f17_local23
		f17_local19 = {
			text = Engine.Localize(f17_local7),
			metrics = {}
		}
		f17_local20 = f17_local19.metrics
		f17_local21 = f17_local19.metrics
		f17_local22 = f17_local19.metrics
		f17_local23 = f17_local19.metrics
		local f17_local24, f17_local25, f17_local26, f17_local27 = GetTextDimensions(f17_local19.text, f17_local8, f17_local9)
		f17_local23.textBottom = f17_local27
		f17_local22.textRight = f17_local26
		f17_local21.textTop = f17_local25
		f17_local20.textLeft = f17_local24
		f17_local21 = (f17_local18.metrics.textRight + f17_local19.metrics.textRight) / 2
		f17_local22 = LUI.UIText.new()
		f17_local22:setLeftRight(false, false, -f17_local21, -f17_local21 + f17_local18.metrics.textRight)
		f17_local22:setTopBottom(true, false, f17_local17, f17_local17 + CoD.textSize.Default)
		f17_local22:setFont(f17_local8)
		f17_local22:setAlignment(LUI.Alignment.Right)
		f17_local22:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
		f17_local23 = LUI.UIText.new()
		f17_local23:setLeftRight(false, false, -f17_local21 + f17_local18.metrics.textRight, f17_local21)
		f17_local23:setTopBottom(true, false, f17_local17, f17_local17 + CoD.textSize.Default)
		f17_local23:setFont(f17_local8)
		f17_local23:setAlignment(LUI.Alignment.Left)
		f17_local23:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f17_local22:setText(f17_local18.text)
		f17_local23:setText(f17_local19.text)
		Widget:addElement(f17_local22)
		Widget:addElement(f17_local23)
	end
	return f17_local0
end

CoD.AfterActionReport.CreateChallengeRow = function (f18_arg0, f18_arg1)
	local Widget = nil
	local f18_local1 = CoD.fonts.Condensed
	local f18_local2 = CoD.textSize.Condensed
	local f18_local3 = 0.5
	local f18_local4 = 1
	local f18_local5 = CoD.textSize.Condensed + f18_local4 * 2
	local f18_local6 = 1
	local f18_local7 = f18_local5
	local f18_local8 = math.floor((f18_local7 - math.floor(f18_local7 * 0.5)) / 2)
	for f18_local12, f18_local13 in pairs(f18_arg1) do
		Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, false, f18_local5 * (f18_arg0 - 1), f18_local5 * f18_arg0)
		local f18_local14 = LUI.UIImage.new()
		f18_local14:setLeftRight(true, true, 0, -f18_local7)
		f18_local14:setTopBottom(true, true, f18_local4, -f18_local4)
		f18_local14:setRGB(1, 1, 1)
		f18_local14:setAlpha(0.05)
		Widget:addElement(f18_local14)
		local f18_local15 = LUI.UIText.new()
		f18_local15:setLeftRight(true, true, 5, 0)
		f18_local15:setTopBottom(true, true, f18_local4, -f18_local4)
		f18_local15:setFont(f18_local1)
		f18_local15:setAlignment(LUI.Alignment.Left)
		f18_local15:setAlpha(f18_local6)
		f18_local15:setText(Engine.Localize(f18_local12))
		Widget:addElement(f18_local15)
		local f18_local16 = LUI.UIImage.new()
		f18_local16:setLeftRight(false, true, -f18_local7, 0)
		f18_local16:setTopBottom(true, true, f18_local4, -f18_local4)
		f18_local16:setRGB(1, 1, 1)
		f18_local16:setAlpha(0.09)
		Widget:addElement(f18_local16)
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(false, true, -(f18_local7 - f18_local8), -f18_local8)
		Widget:setTopBottom(true, true, f18_local8, -f18_local8)
		Widget:addElement(Widget)
		if not f18_local13 then
			Widget:addElement(CoD.Border.new(1, CoD.white.r, CoD.white.g, CoD.white.b, f18_local3, 0))
			f18_local15:setRGB(CoD.white.r, CoD.white.g, CoD.white.b)
		else
			f0_local2(Widget, CoD.trueOrange)
			f18_local15:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		end
	end
	return Widget
end

CoD.AfterActionReport.LeaderboardTab_ComparePaneBuildData = function (f19_arg0, f19_arg1)
	local f19_local0 = {
		scoreRowUIFunction = CoD.AfterActionReport.LeaderboardTab_ComparePaneTotalScoreRow,
		countLookupFunction = UIExpression.GetLevelBestStat,
		otherCountLookupFunction = UIExpression.GetOtherPlayerLevelBestStat,
		scoreLookupFunction = UIExpression.GetLevelBestStat,
		multiplierLookupFunction = UIExpression.GetStatScoreMultiplier,
		countTextColor = CoD.lightBlue,
		otherCountTextColor = CoD.AARUtility.OtherPlayerStatColor
	}
	local f19_local1 = {
		key = "headshots",
		countLookup = "headshots",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MPUI_HEADSHOTS_CAPS"
	}
	local f19_local2 = {
		key = "explosivekills",
		countLookup = "explosivekills",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MENU_EXPLOSIVE_CAPS"
	}
	local f19_local3 = {
		key = "stunkills",
		countLookup = "stunkills",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MENU_STUN_CAPS"
	}
	local f19_local4 = {
		key = "meleekills",
		countLookup = "meleekills",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MENU_MELEE_CAPS"
	}
	local f19_local5 = {
		key = "kills",
		countLookup = "kills",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MPUI_KILLS_CAPS"
	}
	local f19_local6 = {
		key = "mechanicalkills",
		countLookup = "mechanicalkills",
		scoreLookup = "mechanicalkillsscore",
		multiplier = true,
		labelUnlocalized = "MENU_ROBOT_KILLS_CAPS"
	}
	local f19_local7 = {
		key = "explosivekills",
		countLookup = "explosivekills",
		scoreLookup = "explosiveKillsScore",
		multiplier = true,
		labelUnlocalized = "MENU_EXPLOSIVE_CAPS"
	}
	local f19_local8 = {
		key = "headshots",
		countLookup = "headshots",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MPUI_HEADSHOTS_CAPS"
	}
	local f19_local9 = {
		key = "challenges",
		countLookup = "challengesComplete",
		scoreLookup = "challengesScore",
		multiplier = true,
		labelUnlocalized = "MENU_CHALLENGES_CAPS"
	}
	local f19_local10 = {
		key = "difficulty",
		countLookup = "difficulty",
		scoreLookup = nil,
		multiplier = true,
		labelUnlocalized = "MENU_DIFFICULTY_CAPS",
		countParser = f0_local4,
		otherCountParser = f0_local3
	}
	local f19_local11 = {
		key = "levelScore",
		countLookup = "levelScore",
		scoreLookup = "levelScore",
		multiplier = nil,
		labelUnlocalized = "MENU_HIGH_SCORE_CAPS",
		countParser = CoD.separateNumberWithCommas
	}
	f19_local0[1] = f19_local1
	f19_local0[2] = f19_local2
	f19_local0[3] = f19_local3
	f19_local0[4] = f19_local4
	f19_local0[5] = f19_local5
	f19_local0[6] = f19_local6
	f19_local0[7] = f19_local7
	f19_local0[8] = f19_local8
	f19_local0[9] = f19_local9
	f19_local0[10] = f19_local10
	f19_local0[11] = f19_local11
	return f0_local5(f19_arg0, f19_local0, f19_arg1)
end

local f0_local7 = function (f20_arg0, f20_arg1)
	DebugPrint("CoD.AfterActionReport.LeaderboardTab.OnPlayerDataFetchComplete "" .. f20_arg0.inProgressFetch.name .. "" xuid " .. f20_arg0.inProgressFetch.xuid)
	local f20_local0 = UIExpression.GetXUID(f20_arg1.controller) == f20_arg0.inProgressFetch.xuid
	local f20_local1 = f20_arg0.inProgressFetch
	f20_arg0.inProgressFetch = nil
	if f20_arg0.compareStatsPane then
		f20_arg0.compareStatsPane:close()
		f20_arg0.compareStatsPane = nil
	end
	f20_arg0.compareStatsPane = CoD.AfterActionReport.CreateStatsPane(CoD.AfterActionReport.LeaderboardTab_ComparePaneBuildData(f20_arg1.controller, f20_local0))
	f20_arg0.rightHalfContainer:addElement(f20_arg0.compareStatsPane)
	f20_arg0.previousCompletedFetch = f20_local1
end

CoD.AfterActionReport.LeaderboardTab.ButtonAction = function (f21_arg0, f21_arg1)
	DebugPrint("CoD.AfterActionReport.LeaderboardTab.ButtonAction "" .. f21_arg1.button.playerName .. """ .. f21_arg1.button.xuid)
	if not f21_arg0.inProgressFetch then
		f21_arg0.inProgressFetch = {
			name = f21_arg1.button.playerName,
			xuid = f21_arg1.button.xuid,
			button = f21_arg1.button
		}
		f21_arg0:registerEventHandler("service_record_fetched", f0_local7)
		Engine.Exec(f21_arg1.controller, "getServiceRecord " .. f21_arg1.button.xuid)
	end
end

CoD.AfterActionReport.LeaderboardTab.UpdateRow = function (f22_arg0, f22_arg1)
	if f22_arg1.totalresults == nil then
		return 
	elseif f22_arg0.aarMapName ~= nil then
		Dvar.ui_mapname:set(f22_arg0.aarMapName)
		local f22_local0 = UIExpression.HasCurrentLevelBeenBeaten()
		local f22_local1 = UIExpression.GetDStat(controller, "PlayerLevelStats", f22_arg0.aarMapName, "bestPlaythrough", "levelScore")
		if f22_local0 == 1 or f22_local1 ~= nil and f22_local1 > 0 then
			f22_arg0.fakeEntry = false
			f22_arg0:setTotalItems(f22_arg1.totalresults)
		else
			f22_arg0.fakeEntry = true
			f22_arg0:setTotalItems(f22_arg1.totalresults + 1)
		end
	else
		f22_arg0:setTotalItems(f22_arg1.totalresults)
	end
	if f22_arg0.loadedXuid == UIExpression.GetXUID(controller) then
		f22_arg0:processEvent({
			name = "listbox_move_down"
		})
		f22_arg0:processEvent({
			name = "listbox_focussed_button_click"
		})
	end
end

f0_local0 = function (f23_arg0, f23_arg1)
	local f23_local0 = UIExpression.GetPrimaryController()
	local f23_local1 = CoD.AfterActionReport.CurrentMap
	local f23_local2 = false
	local f23_local3 = Engine.IsSignedInToDemonware(f23_local0) == true
	local f23_local4 = UIExpression.IsSignedInToLive(f23_local0) ~= 0
	local f23_local5 = UIExpression.IsSignedIn(f23_local0) ~= 0
	if f23_local4 then
		local f23_local6 = CoD.isPS3
		if f23_local6 == 0 then
			f23_local2 = f23_local6
		else
			f23_local2 = UIExpression.IsContentRatingAllowed(f23_local0) == 0
		end
	end
	if not f23_local2 and f23_local3 and f23_local4 then
		if f23_arg0.signInText then
			f23_arg0.signInText:close()
		end
		if f23_arg0.timer then
			f23_arg0.timer:close()
		end
		Engine.LoadLeaderboard("LB_SP_" .. UIExpression.ToUpper(nil, f23_local1), "TRK_ALLTIME")
		local f23_local7 = CoD.MissionLeaderboard.new({
			leftAnchor = true,
			rightAnchor = false,
			left = 0,
			right = f23_arg0.leftHalfWidth,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = -20
		}, f23_local0)
		f23_arg0.leftHalfContainer:addElement(f23_local7)
		local f23_local8 = f23_local7:getListBox()
		f23_local8.aarMapName = f23_local1
		f23_local8 = f23_local7:getListBox()
		f23_local8:registerEventHandler("leaderboardlist_update", CoD.AfterActionReport.LeaderboardTab.UpdateRow)
		Engine.RequestLeaderboardData(f23_local0, CoD.LB_FILTER_FRIENDS)
		f23_arg0:dispatchEventToParent({
			name = "tab_changed",
			tabIndex = 3
		})
		return true
	elseif f23_arg0.signInText == nil then
		local f23_local6 = LUI.UIText.new()
		f23_local6:setLeftRight(true, true, 0, 0)
		f23_local6:setTopBottom(false, false, -CoD.textSize.Condensed / 2, CoD.textSize.Condensed / 2)
		f23_local6:setFont(CoD.fonts.Condensed)
		f23_local6:setAlignment(LUI.Alignment.Center)
		f23_arg0:addElement(f23_local6)
		f23_arg0.signInText = f23_local6
	end
	if f23_local2 then
		f23_arg0.signInText:setText(Engine.Localize("XBOXLIVE_MPNOTALLOWED"))
		if f23_arg0.timer then
			f23_arg0.timer:close()
		end
	elseif not f23_local4 then
		f23_arg0.signInText:setText(Engine.Localize("XBOXLIVE_LIVE_LEADERBOARD"))
		if not f23_arg0.checkSignIn and CoD.isPS3 then
			Engine.Exec(f23_local0, "xsigninlive")
		end
	else
		f23_arg0.signInText:setText(Engine.Localize("MENU_SERVER_NOT_AVAILABLE_TRY_LATER"))
	end
	f23_arg0.checkSignIn = true
	return false
end

CoD.AfterActionReport.LeaderboardTab.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, CoD.AfterActionReport.TopBorder, 0)
	Widget:addElement(Widget)
	Widget.leftHalfWidth = 415
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, Widget.leftHalfWidth)
	Widget:setTopBottom(true, true, 0, 0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, Widget.leftHalfWidth, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	Widget:addElement(Widget)
	Widget.leftHalfContainer = Widget
	Widget.rightHalfContainer = Widget
	CoD.AfterActionReport.AddLevelImageBackground(Widget)
	Widget.checkSignIn = false
	if not f0_local0(Widget) then
		Widget.timer = LUI.UITimer.new(1000, "check_login", false, Widget)
		Widget:addElement(Widget.timer)
		Widget:registerEventHandler("check_login", f0_local0)
	end
	Widget.rightHalfContainer = Widget
	Widget.compareStatsPane = nil
	Widget:registerEventHandler("leaderboard_button_action", CoD.AfterActionReport.LeaderboardTab.ButtonAction)
	return Widget
end

CoD.AfterActionReport.CreateChallengesTable = function (f25_arg0, f25_arg1)
	local f25_local0 = CoD.AfterActionReport.CurrentMap
	CoD.AfterActionReport.ChallengeTableResults = {}
	local f25_local1 = 0
	local f25_local2 = 1
	local f25_local3 = UIExpression.TableLookup(f25_arg1, CoD.AARUtility.ChallengeTable, 1, f25_local0, 0, f25_local2, 3)
	while f25_local3 ~= "" do
		local f25_local4 = {
			[f25_local3] = UIExpression.GetChallengeComplete(f25_arg1, tostring(f25_local2)) == 1
		}
		if f25_local4[f25_local3] == true then
			f25_local1 = f25_local1 + 1
		end
		CoD.AfterActionReport.ChallengeTableResults[f25_local2] = f25_local4
		f25_local2 = f25_local2 + 1
		if f25_local3 == "" else goto basicblock_2:
		f25_local3 = UIExpression.TableLookup(f25_arg1, CoD.AARUtility.ChallengeTable, 1, f25_local0, 0, f25_local2, 3)
	end
	CoD.AfterActionReport.ChallengesCompletedCount = f25_local1
end

CoD.AfterActionReport.Close = function (f26_arg0, f26_arg1)
	CoD.Menu.close(f26_arg0)
end

local f0_local8 = function (f27_arg0, f27_arg1)
	if f27_arg0 ~= nil then
		local f27_local0 = false
		local f27_local1 = UIExpression.IsSignedInToLive(controller) ~= 0
		local f27_local2 = Engine.IsSignedInToDemonware(controller) == true
		if f27_local1 then
			local f27_local3 = CoD.isPS3
			if f27_local3 == 0 then
				f27_local0 = f27_local3
			else
				f27_local0 = UIExpression.IsContentRatingAllowed(controller) == 0
			end
		end
		if not f27_local0 and f27_local1 and f27_local2 then
			local f27_local3 = CoD.ButtonPrompt.new
			local f27_local4 = "alt1"
			local f27_local5 = Engine.Localize("PLATFORM_SHOW_GAMERCARD")
			local f27_local6 = f27_arg0
			local f27_local7 = "view_gamer_card"
			local f27_local8, f27_local9 = false
			local f27_local10, f27_local11 = false
			f27_arg0.gamercardButton = f27_local3(f27_local4, f27_local5, f27_local6, f27_local7, f27_local8, f27_local9, f27_local10, f27_local11, "P")
			f27_arg0:addLeftButtonPrompt(f27_arg0.gamercardButton)
		end
	end
end

local f0_local9 = function (f28_arg0, f28_arg1)
	if f28_arg0 ~= nil and f28_arg0.gamercardButton ~= nil then
		f28_arg0.gamercardButton:close()
		f28_arg0.gamercardButton = nil
	end
end

local f0_local10 = function (f29_arg0, f29_arg1)
	if f29_arg0 ~= nil then
		f29_arg0:addBackButton()
	end
end

local f0_local11 = function (f30_arg0, f30_arg1)
	if f30_arg0 ~= nil then
		f30_arg0:removeBackButton()
	end
end

local f0_local12 = function (f31_arg0, f31_arg1)
	if f31_arg0 ~= nil then
		f31_arg0:addSelectButton()
	end
end

local f0_local13 = function (f32_arg0, f32_arg1)
	if f32_arg0 ~= nil then
		f32_arg0:removeSelectButton()
	end
end

local f0_local14 = function (f33_arg0, f33_arg1)
	if f33_arg1.tabIndex == 3 then
		f0_local13(f33_arg0, f33_arg1)
		f0_local11(f33_arg0, f33_arg1)
		f0_local12(f33_arg0, f33_arg1)
		f0_local10(f33_arg0, f33_arg1)
		if CoD.isXBOX or CoD.isPS3 or CoD.isPC then
			f0_local8(f33_arg0, f33_arg1)
		end
	else
		f0_local13(f33_arg0, f33_arg1)
		if CoD.isXBOX or CoD.isPS3 or CoD.isPC then
			f0_local9(f33_arg0, f33_arg1)
		end
	end
end

LUI.createMenu.AfterActionReportMenu = function (f34_arg0, f34_arg1)
	local f34_local0 = CoD.Menu.New("AfterActionReportMenu")
	if f34_arg1 ~= nil and f34_arg1.previousMenu ~= nil then
		f34_local0:setPreviousMenu("CareerOverviewMenu", f34_arg1)
	end
	CoD.AfterActionReport.CurrentMap = UIExpression.GetAARLevelAlias(f34_arg0)
	f34_local0:addTitle(Engine.Localize("SPUI_" .. UIExpression.GetAARLevelAlias(f34_arg0) .. "_MISSION_NAME"), LUI.Alignment.Center)
	f34_local0.createChallengesTable = CoD.AfterActionReport.CreateChallengesTable
	f34_local0.close = CoD.AfterActionReport.Close
	f34_local0:addBackButton()
	f34_local0.tabContentPane = LUI.UIElement.new()
	f34_local0.tabContentPane:setLeftRight(true, true, 0, 0)
	f34_local0.tabContentPane:setTopBottom(true, true, CoD.Menu.TitleHeight, -CoD.ButtonPrompt.Height)
	f34_local0:addElement(f34_local0.tabContentPane)
	local f34_local1 = CoD.Menu.TitleHeight + 15
	f34_local0.tabManager = CoD.MFTabManager.new(f34_local0.tabContentPane, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f34_local1,
		bottom = f34_local1 + CoD.MFTabManager.TabHeight
	}, nil, CoD.trueOrange)
	f34_local0.tabManager:setTabAlignment(LUI.Alignment.Center)
	f34_local0.tabManager:setTabSpacing(80)
	f34_local0:addElement(f34_local0.tabManager)
	f34_local0:createChallengesTable(f34_arg0)
	f34_local0.tabManager:addTab(f34_arg0, Engine.Localize("MPUI_SCORE_CAPS"), CoD.AfterActionReport.StatsTab)
	f34_local0.tabManager:addTab(f34_arg0, Engine.Localize("MENU_CHALLENGES_CAPS"), CoD.AfterActionReport.ChallengesTab)
	f34_local0.tabManager:addTab(f34_arg0, Engine.Localize("MENU_LEADERBOARDS_CAPS"), CoD.AfterActionReport.LeaderboardTab.new)
	f34_local0.tabManager:refreshTab(f34_arg0)
	f34_local0:registerEventHandler("tab_changed", f0_local14)
	return f34_local0
end

