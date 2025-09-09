CoD.XPBar = {}
CoD.XPBar.RankIdCol = 0
CoD.XPBar.RankTableColMinXP = 2
CoD.XPBar.RankTableColXPToNext = 3
CoD.XPBar.RankTableColMaxXP = 7
CoD.XPBar.RankDisplayLevelCol = 14
CoD.XPBar.AnimateDuration = 800
CoD.XPBar.New = function (f1_arg0, f1_arg1, f1_arg2)
	local Widget = LUI.UIElement.new(f1_arg0)
	if CoD.CanRankUp(f1_arg1) == true then
		Widget:registerEventHandler("animate_xp_bar", CoD.XPBar.Animate)
		local f1_local1 = CoD.XPBar.GetStats(f1_arg1)
		local f1_local2 = f1_local1.currentRank
		local f1_local3 = f1_local1.displayLevelForCurrRank
		local f1_local4 = 0
		local f1_local5 = "Default"
		local f1_local6, f1_local7, f1_local8, f1_local9 = GetTextDimensions(f1_local3, CoD.fonts[f1_local5], CoD.textSize[f1_local5])
		local f1_local10 = f1_local8 - f1_local6
		local f1_local11 = LUI.UIText.new()
		f1_local11:setLeftRight(true, false, f1_local4, f1_local4 + f1_local10)
		f1_local11:setTopBottom(false, false, -(CoD.textSize[f1_local5] / 2), CoD.textSize[f1_local5] / 2)
		f1_local11:setAlignment(LUI.Alignment.Right)
		f1_local11:setText(f1_local3)
		f1_local11:setFont(CoD.fonts[f1_local5])
		Widget:addElement(f1_local11)
		f1_local4 = f1_local4 + f1_local10 + 2
		local f1_local12 = 32
		local f1_local13 = LUI.UIImage.new()
		f1_local13:setLeftRight(true, false, f1_local4, f1_local4 + f1_local12)
		f1_local13:setTopBottom(false, false, -(f1_local12 / 2), f1_local12 / 2)
		f1_local13:setImage(RegisterMaterial(f1_local1.currRankIconMaterialName))
		Widget:addElement(f1_local13)
		f1_local4 = f1_local4 + f1_local12 + 2
		local f1_local14 = 0
		local f1_local15 = f1_local12
		local f1_local16 = LUI.UIImage.new()
		f1_local16:setLeftRight(false, true, -f1_local14 - f1_local15, -f1_local14)
		f1_local16:setTopBottom(false, false, -(f1_local15 / 2), f1_local15 / 2)
		f1_local16:setImage(RegisterMaterial(f1_local1.nextRankIconMaterialName))
		Widget:addElement(f1_local16)
		f1_local14 = f1_local14 + f1_local15 + 2
		local f1_local17 = LUI.UIText.new()
		f1_local17:setLeftRight(true, true, 0, -f1_local14)
		f1_local17:setTopBottom(false, false, -(CoD.textSize[f1_local5] / 2), CoD.textSize[f1_local5] / 2)
		f1_local17:setAlignment(LUI.Alignment.Right)
		f1_local17:setFont(CoD.fonts[f1_local5])
		f1_local17:setText(f1_local1.displayLevelForNextRank)
		Widget:addElement(f1_local17)
		local f1_local18, f1_local19, f1_local20, f1_local21 = GetTextDimensions(f1_local1.displayLevelForNextRank, CoD.fonts[f1_local5], CoD.textSize[f1_local5])
		f1_local9 = f1_local21
		f1_local8 = f1_local20
		f1_local7 = f1_local19
		f1_local14 = f1_local14 + f1_local8 - f1_local18 + 10
		f1_local19 = f1_local10 + f1_local12 + 4
		f1_local20 = f1_arg2 - f1_local19 - f1_local14
		f1_local21 = 24
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, f1_local19, f1_local19 + f1_local20)
		Widget:setTopBottom(false, false, -(f1_local21 / 2), f1_local21 / 2)
		Widget:addElement(Widget)
		Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.05))
		local f1_local23 = 2
		local f1_local24 = LUI.UIImage.new()
		f1_local24:setLeftRight(true, true, 1, -1)
		f1_local24:setTopBottom(true, true, 1, -1)
		f1_local24:setRGB(0, 0, 0)
		f1_local24:setAlpha(0.4)
		Widget:addElement(f1_local24)
		local f1_local25 = LUI.UIImage.new()
		f1_local25:setLeftRight(true, true, 2, -2)
		f1_local25:setTopBottom(true, true, 2, -2)
		f1_local25:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
		f1_local25:setAlpha(0.1)
		Widget:addElement(f1_local25)
		local Widget = LUI.UIElement.new()
		local f1_local27 = 0
		f1_local27 = f1_local20 * (f1_local1.currRankXP - f1_local1.minXPForCurrRank) / f1_local1.xpToNextRank
		Widget:setLeftRight(true, false, f1_local23, f1_local27)
		Widget:setTopBottom(true, true, f1_local23, -f1_local23)
		Widget:addElement(Widget)
		local f1_local28 = LUI.UIImage.new()
		f1_local28:setLeftRight(true, true, 0, 0)
		f1_local28:setTopBottom(true, true, 0, 0)
		f1_local28:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		f1_local28:setAlpha(0.7)
		Widget:addElement(f1_local28)
		local f1_local29 = LUI.UIImage.new()
		f1_local29:setLeftRight(true, true, 0, 0)
		f1_local29:setTopBottom(true, true, 0, 0)
		f1_local29:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
		f1_local29:setAlpha(0.4)
		Widget:addElement(f1_local29)
		local Widget = LUI.UIElement.new()
		local f1_local31 = f1_local20 * (f1_local1.currRankXP - f1_local1.minXPForCurrRank) / f1_local1.xpToNextRank - f1_local27
		Widget.xpBeforeMatchWidth = f1_local27
		Widget.xpEarnedDuringMatchWidth = f1_local31
		Widget:setLeftRight(true, false, f1_local27, f1_local27)
		Widget:setTopBottom(true, true, f1_local23, -f1_local23)
		Widget:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		Widget.xpEarnedDuringMatch = Widget
		local f1_local32 = LUI.UIImage.new()
		f1_local32:setLeftRight(true, true, 0, 0)
		f1_local32:setTopBottom(true, true, 0, 0)
		f1_local32:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		Widget:addElement(f1_local32)
		local f1_local33 = LUI.UIImage.new()
		f1_local33:setLeftRight(true, true, 0, 0)
		f1_local33:setTopBottom(true, true, 0, 0)
		f1_local33:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
		f1_local33:setAlpha(0.4)
		Widget:addElement(f1_local33)
		if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == false and 1 == UIExpression.IsSuperUser() then
			local f1_local34 = LUI.UIText.new()
			local f1_local35 = "Default"
			local f1_local36 = 5 + f1_local21
			f1_local34:setLeftRight(true, true, 0, 0)
			f1_local34:setTopBottom(false, true, -f1_local36 - CoD.textSize[f1_local35], -f1_local36)
			f1_local34:setFont(CoD.fonts[f1_local35])
			f1_local34:setText(Engine.Localize("MENU_CURRENT_XP_ARG", f1_local1.currRankXP))
			f1_local34:setAlignment(LUI.Alignment.Left)
			Widget:addElement(f1_local34)
			local f1_local37 = LUI.UIText.new()
			local f1_local38 = "Default"
			f1_local36 = 5 + f1_local21
			f1_local37:setLeftRight(true, true, 0, 0)
			f1_local37:setTopBottom(false, true, -f1_local36 - CoD.textSize[f1_local38], -f1_local36)
			f1_local37:setFont(CoD.fonts[f1_local38])
			f1_local37:setText(Engine.Localize("MENU_NEXT_LEVEL_XP_ARG", f1_local1.maxXPForCurrRank))
			f1_local37:setAlignment(LUI.Alignment.Right)
			Widget:addElement(f1_local37)
		end
	end
	return Widget
end

CoD.XPBar.GetStats = function (f2_arg0)
	local f2_local0 = {
		currentStats = Engine.GetPlayerStats(f2_arg0),
		currentRank = f2_local0.currentStats.PlayerStatsList.RANK.StatValue:get(),
		displayLevelForCurrRank = UIExpression.TableLookup(f2_arg0, CoD.rankTable, CoD.XPBar.RankIdCol, f2_local0.currentRank, CoD.XPBar.RankDisplayLevelCol),
		currPrestige = f2_local0.currentStats.PlayerStatsList.PLEVEL.StatValue:get(),
		currRankIconMaterialName = UIExpression.TableLookup(f2_arg0, CoD.rankIconTable, CoD.XPBar.RankIdCol, f2_local0.currentRank, f2_local0.currPrestige + 1),
		currRankXP = f2_local0.currentStats.PlayerStatsList.RANKXP.StatValue:get(),
		minXPForCurrRank = tonumber(UIExpression.TableLookup(f2_arg0, CoD.rankTable, CoD.XPBar.RankIdCol, f2_local0.currentRank, CoD.XPBar.RankTableColMinXP)),
		maxXPForCurrRank = tonumber(UIExpression.TableLookup(f2_arg0, CoD.rankTable, CoD.XPBar.RankIdCol, f2_local0.currentRank, CoD.XPBar.RankTableColMaxXP)),
		xpToNextRank = tonumber(UIExpression.TableLookup(f2_arg0, CoD.rankTable, CoD.XPBar.RankIdCol, f2_local0.currentRank, CoD.XPBar.RankTableColXPToNext)),
		prestigeNext = CoD.PrestigeNext(f2_arg0)
	}
	if f2_local0.prestigeNext then
		f2_local0.displayLevelForNextRank = CoD.PrestigeNextLevelText(f2_arg0)
		f2_local0.nextRankIconMaterialName = UIExpression.TableLookup(f2_arg0, CoD.rankIconTable, 0, 0, f2_local0.currPrestige + 2)
	else
		f2_local0.displayLevelForNextRank = UIExpression.TableLookup(f2_arg0, CoD.rankTable, CoD.XPBar.RankIdCol, f2_local0.currentRank + 1, CoD.XPBar.RankDisplayLevelCol)
		f2_local0.nextRankIconMaterialName = UIExpression.TableLookup(f2_arg0, CoD.rankIconTable, 0, f2_local0.currentRank + 1, f2_local0.currPrestige + 1)
	end
	return f2_local0
end

CoD.XPBar.Animate = function (f3_arg0, f3_arg1)
	if not f3_arg0.xpEarnedDuringMatch then
		return 
	end
	local f3_local0 = CoD.XPBar.AnimateDuration
	if f3_arg1.duration then
		f3_local0 = f3_arg1.duration
	end
	local f3_local1 = f3_arg0.xpEarnedDuringMatch
	local f3_local2 = f3_local1.xpBeforeMatchWidth
	local f3_local3 = f3_local1.xpEarnedDuringMatchWidth
	local f3_local4 = 2
	f3_local1:beginAnimation("grow", f3_local0)
	f3_local1:setLeftRight(true, false, f3_local2, f3_local2 + f3_local3 - f3_local4)
end

