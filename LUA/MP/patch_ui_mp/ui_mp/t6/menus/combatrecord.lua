require("T6.MFTabManager")
require("T6.Line")
CoD.CombatRecord = {}
CoD.CombatRecord.MaximumNumGameType = UIExpression.TableLookup(0, CoD.gametypesTable, 0, "maxnum_lbtype", 1)
CoD.CombatRecord.GameTypeTable = {}
for f0_local0 = 0, CoD.CombatRecord.MaximumNumGameType - 1, 1 do
	CoD.CombatRecord.GameTypeTable[f0_local0 + 1] = {}
	CoD.CombatRecord.GameTypeTable[f0_local0 + 1].localizedString = UIExpression.TableLookup(0, CoD.gametypesTable, 0, "2", 1, f0_local0, 4)
	CoD.CombatRecord.GameTypeTable[f0_local0 + 1].type = UIExpression.TableLookup(0, CoD.gametypesTable, 0, "2", 1, f0_local0, 2)
end
CoD.CombatRecord.AddContainer = function (f1_arg0, f1_arg1, f1_arg2)
	local Widget = LUI.UIElement.new(f1_arg0)
	if setstencil ~= nil and setstencil == true then
		Widget:setUseStencil(true)
	end
	f1_arg1:addElement(Widget)
	return Widget
end

CoD.CombatRecord.SetText = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = LUI.UIText.new(f2_arg0)
	f2_arg1:addElement(f2_local0)
	f2_local0:setText(f2_arg2)
	return f2_local0
end

CoD.CombatRecord.ShowXPBar = function (f3_arg0, f3_arg1)
	if CoD.CanRankUp(f3_arg0) == true then
		local f3_local0 = 2
		local f3_local1 = 7
		local f3_local2 = 3
		local f3_local3 = UIExpression.GetDStat(f3_arg0, "PlayerStatsList", "RANK", "StatValue")
		local f3_local4 = UIExpression.GetDStat(f3_arg0, "PlayerStatsList", "PLEVEL", "StatValue")
		local f3_local5 = UIExpression.GetDStat(f3_arg0, "PlayerStatsList", "RANKXP", "StatValue")
		local f3_local6 = UIExpression.TableLookup(f3_arg0, CoD.rankTable, 0, f3_local3, f3_local0)
		local f3_local7 = UIExpression.TableLookup(f3_arg0, CoD.rankTable, 0, f3_local3, f3_local1)
		local f3_local8 = UIExpression.TableLookup(f3_arg0, CoD.rankTable, 0, f3_local3, f3_local2)
		local f3_local9 = UIExpression.LocString(f3_arg0, "MPUI_AAR_XP_NEEDED_CAPS", f3_local7 - f3_local5)
		local f3_local10 = UIExpression.TableLookup(f3_arg0, CoD.rankTable, 0, f3_local3 + 1, 14)
		local f3_local11 = {
			r = 0.42,
			g = 0.9,
			b = 0.46,
			a = 0.5
		}
		local f3_local12 = 660
		local f3_local13 = 25
		local f3_local14 = (f3_local5 - f3_local6) / f3_local8 * f3_local12
		local f3_local15 = 20
		f3_arg1.XPBarContainer = CoD.CombatRecord.AddContainer({
			left = 0,
			top = -CoD.CoD9Button.Height * 4,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = false,
			bottomAnchor = true,
			rightAnchor = true
		}, f3_arg1)
		f3_arg1.XPBarContainer:addElement(LUI.UIImage.new({
			left = -f3_local12 / 2 + f3_local15,
			top = -f3_local13 / 2,
			bottom = f3_local13 / 2,
			right = f3_local12 / 2 + f3_local15,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false,
			material = RegisterMaterial("white"),
			alpha = 0.1,
			red = 0,
			green = 0,
			blue = 0
		}))
		f3_arg1.XPBarContainer:addElement(LUI.UIImage.new({
			left = -f3_local12 / 2 + f3_local15,
			top = -f3_local13 / 2,
			bottom = f3_local13 / 2,
			right = f3_local12 / 2 + f3_local15,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false,
			material = RegisterMaterial("menu_mp_bar_shadow"),
			alpha = 0.1,
			red = 1,
			green = 1,
			blue = 1
		}))
		f3_arg1.xpBar = LUI.UIImage.new({
			left = -f3_local12 / 2 + f3_local15,
			top = -f3_local13 / 2,
			bottom = f3_local13 / 2,
			right = -f3_local12 / 2 + f3_local15,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false,
			material = RegisterMaterial("white"),
			alpha = 0.2,
			red = 0,
			green = 0,
			blue = 0
		})
		f3_arg1.xpBar:registerAnimationState("animate_xp_bar", {
			left = -f3_local12 / 2 + f3_local15,
			top = -f3_local13 / 2,
			bottom = f3_local13 / 2,
			right = -f3_local12 / 2 + f3_local14 + f3_local15,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false,
			material = RegisterMaterial("white"),
			alpha = 0.2,
			red = 0,
			green = 0,
			blue = 0
		})
		f3_arg1.XPBarContainer:addElement(f3_arg1.xpBar)
		CoD.CombatRecord.SetText({
			left = -f3_local12 / 2 + f3_local15 - 100,
			top = -f3_local13 / 2,
			bottom = f3_local13 / 2,
			right = -f3_local12 / 2 + 15 + f3_local15,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false,
			red = 1,
			green = 1,
			blue = 1,
			alpha = 1
		}, f3_arg1.XPBarContainer, UIExpression.ToUpper(f3_arg0, Engine.Localize("MENU_NEXT_LEVEL")))
		CoD.CombatRecord.SetText({
			left = -f3_local12 / 2 + f3_local15 + 5,
			top = -f3_local13 / 2,
			bottom = f3_local13 / 2,
			right = 0,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false,
			red = 1,
			green = 1,
			blue = 1,
			alpha = 1,
			alignment = LUI.Alignment.Left
		}, f3_arg1.XPBarContainer, f3_local9)
		local f3_local16 = ""
		if CoD.PrestigeNext(f3_arg0) == true then
			f3_local16 = CoD.PrestigeNextLevelText(f3_arg0)
		else
			f3_local16 = f3_local10
		end
		CoD.CombatRecord.SetText({
			left = f3_local12 / 2 + 20 + f3_local15,
			top = -f3_local13 / 2,
			bottom = f3_local13 / 2,
			right = f3_local12 / 2 + f3_local15,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false,
			red = 0,
			green = 0,
			blue = 0,
			alpha = 1
		}, f3_arg1.XPBarContainer, f3_local16)
		local f3_local17 = 20
		local f3_local18 = 20
		local f3_local19 = nil
		if CoD.PrestigeNext(f3_arg0) == true then
			f3_local19 = UIExpression.TableLookup(f3_arg0, CoD.rankIconTable, 0, 0, f3_local4 + 2)
		else
			f3_local19 = UIExpression.TableLookup(f3_arg0, CoD.rankIconTable, 0, f3_local3 + 1, f3_local4 + 1)
		end
		f3_arg1.XPBarContainer:addElement(LUI.UIImage.new({
			left = f3_local12 / 2 + f3_local15 + 20,
			top = -f3_local18 / 2,
			bottom = f3_local18 / 2,
			right = f3_local12 / 2 + f3_local15 + 20 + f3_local17,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false,
			material = RegisterMaterial(f3_local19),
			alpha = 1
		}))
	end
end

CoD.CombatRecord.DisplayStatsRow = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	if f4_arg2 % 2 == 1 then
		f4_arg0.alpha = 0.1
		f4_arg0.red = 0
		f4_arg0.green = 0
		f4_arg0.blue = 0
		f4_arg1:addElement(LUI.UIImage.new(f4_arg0))
	end
	f4_arg0.alpha = 1
	f4_arg0.red = 1
	f4_arg0.green = 1
	f4_arg0.blue = 1
	f4_arg0.left = f4_arg0.left + 10
	f4_arg0.top = f4_arg0.top + 2
	f4_arg0.bottom = f4_arg0.bottom - 2
	f4_arg0.alignment = LUI.Alignment.Left
	CoD.CombatRecord.SetText(f4_arg0, f4_arg1, f4_arg3)
	f4_arg0.right = f4_arg0.right - 10
	f4_arg0.left = f4_arg0.left - 10
	f4_arg0.alignment = LUI.Alignment.Right
	CoD.CombatRecord.SetText(f4_arg0, f4_arg1, f4_arg4)
end

CoD.CombatRecord.PrepareSummaryStats = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new({
		left = -380,
		top = 100,
		right = -15,
		bottom = -290,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	})
	HudRef:addElement(Widget)
	Widget:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = 0.1,
		red = 0,
		green = 0,
		blue = 0
	}))
	CoD.CombatRecord.DisplayStatsRow({
		left = 0,
		top = 0,
		right = 0,
		bottom = 30,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, Widget, 1, Engine.Localize("MPUI_KILLS_CAPS"), UIExpression.GetDStat(InstanceRef, "PlayerStatsList", "KILLS", "StatValue"))
	CoD.CombatRecord.DisplayStatsRow({
		left = 0,
		top = 30,
		right = 0,
		bottom = 60,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, Widget, 2, Engine.Localize("MPUI_DEATHS_CAPS"), UIExpression.GetDStat(InstanceRef, "PlayerStatsList", "DEATHS", "StatValue"))
	CoD.CombatRecord.DisplayStatsRow({
		left = 0,
		top = 60,
		right = 0,
		bottom = 90,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, Widget, 3, Engine.Localize("MPUI_KILL_DEATH_RATIO_CAPS"), string.format("%.2f", UIExpression.GetDStat(InstanceRef, "PlayerStatsList", "KDRATIO", "StatValue") / 1000))
	CoD.CombatRecord.DisplayStatsRow({
		left = 0,
		top = 90,
		right = 0,
		bottom = 120,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, Widget, 4, Engine.Localize("MPUI_ASSISTS_CAPS"), UIExpression.GetDStat(InstanceRef, "PlayerStatsList", "ASSISTS", "StatValue"))
	CoD.CombatRecord.DisplayStatsRow({
		left = 0,
		top = 120,
		right = 0,
		bottom = 150,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, Widget, 5, Engine.Localize("MPUI_ACCURACY_CAPS"), string.format("%.2f", UIExpression.GetDStat(InstanceRef, "PlayerStatsList", "HITS", "StatValue") * 100 / UIExpression.GetDStat(InstanceRef, "PlayerStatsList", "TOTAL_SHOTS", "StatValue")) .. "%")
	CoD.CombatRecord.DisplayStatsRow({
		left = 0,
		top = 150,
		right = 0,
		bottom = 180,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, Widget, 6, Engine.Localize("MPUI_HEADSHOTS_CAPS"), UIExpression.GetDStat(InstanceRef, "PlayerStatsList", "HEADSHOTS", "StatValue"))
	CoD.CombatRecord.DisplayStatsRow({
		left = 0,
		top = 180,
		right = 0,
		bottom = 210,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, Widget, 7, Engine.Localize("MPUI_BEST_KILLSTREAK_CAPS"), UIExpression.GetDStat(InstanceRef, "HighestStats", "KILL_STREAK"))
end

CoD.CombatRecord.Weapons_PrepareTable = function (f6_arg0, f6_arg1)
	local f6_local0 = {}
	local f6_local1 = {}
	local f6_local2 = 0
	local f6_local3 = Engine.GetPlayerStats(f6_arg0)
	f6_local3 = f6_local3.gameHistory
	local f6_local4 = f6_local3.publicmatch
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == true then
		f6_local4 = f6_local3.leaguematch
	end
	local f6_local5 = f6_local4.currentMatchHistoryIndex:get()
	local f6_local6 = #f6_local4.matchHistory
	for f6_local7 = 1, 5, 1 do
		local f6_local10 = f6_local7
		if f6_local4.matchHistory[f6_local5].startingTime:get() == 0 then
			break
		end
		local f6_local11 = f6_local4.matchHistory[f6_local5].KILLS:get() / math.max(f6_local4.matchHistory[f6_local5].DEATHS:get(), 1)
		table.insert(kdRatioTable, f6_local11)
		if f6_local11 > maxKDRatio then
			maxKDRatio = f6_local11
		end
		f6_local5 = f6_local5 - 1
		if f6_local5 < 0 then
			f6_local5 = f6_local6 - 1
		end
	end
	return f6_local0, f6_local1, f6_local2
end

CoD.CombatRecord.SummaryDisplayKDBox = function (f7_arg0, f7_arg1)
	local f7_local0 = 390
	local f7_local1 = 730
	local f7_local2 = 160
	local f7_local3 = CoD.CombatRecord.AddContainer({
		left = 50,
		top = f7_local0,
		right = f7_local1,
		bottom = f7_local0 + f7_local2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, f7_arg0)
	local f7_local4 = CoD.CombatRecord.AddContainer({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}, f7_local3, true)
	f7_local4:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = f7_local1,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		alpha = 0.1,
		red = 0,
		green = 0,
		blue = 0
	}))
	CoD.CombatRecord.DisplayLineGraph(f7_arg1, f7_local4, f7_local1, f7_local2, CoD.CombatRecord.Weapons_PrepareTable, 5)
	CoD.CombatRecord.SetText({
		left = 0,
		top = -f7_local2 / 2 - CoD.textSize.Default,
		right = f7_local1,
		bottom = -f7_local2 / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Left
	}, f7_local3, Engine.Localize("MPUI_KD_PREVIOUSGAMES"))
end

CoD.CombatRecord.GetLossesStat = function (f8_arg0)
	local f8_local0 = tonumber(f8_arg0:get())
	local f8_local1 = UIExpression.DvarInt(nil, "maxLossesValue")
	if UIExpression.DvarBool(nil, "fixNegativeLosses") ~= 0 and f8_local1 > 0 and (f8_local0 < 0 or f8_local1 < f8_local0) then
		f8_local0 = 0
		f8_arg0:set(f8_local0)
	end
	return f8_local0
end

CoD.CombatRecord.PrepareSummaryFavouriteWeapon = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new({
		left = 15,
		top = 100,
		right = 380,
		bottom = -290,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	})
	HudRef:addElement(Widget)
	Widget:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = 0.1,
		red = 0,
		green = 0,
		blue = 0
	}))
	local f9_local1 = 0
	local f9_local2 = 0
	for f9_local3 = 0, 63, 1 do
		local f9_local6 = UIExpression.GetDStat(InstanceRef, "ItemStats", f9_local3, "stats", "timeUsed", "statValue")
		if f9_local1 < f9_local6 then
			f9_local1 = f9_local6
			f9_local2 = f9_local3
		end
	end
	if f9_local2 > 0 then
		local f9_local3 = UIExpression.ToUpper(InstanceRef, Engine.Localize(UIExpression.GetItemName(InstanceRef, f9_local2)))
		local f9_local5 = RegisterMaterial(UIExpression.GetItemImage(InstanceRef, f9_local2))
		CoD.CombatRecord.SetText({
			left = -1,
			top = 0,
			right = 1,
			bottom = 25,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false
		}, Widget, Engine.Localize("MPUI_FAVORITE_WEAPON_CAPS"))
		Widget:addElement(LUI.UIImage.new({
			left = -45,
			top = 30,
			right = 45,
			bottom = 120,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false,
			material = f9_local5
		}))
		CoD.CombatRecord.SetText({
			left = -1,
			top = 122,
			right = 1,
			bottom = 147,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false
		}, Widget, f9_local3)
		CoD.CombatRecord.DisplayStatsRow({
			left = 0,
			top = 150,
			right = 0,
			bottom = 180,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false
		}, Widget, 1, Engine.Localize("MPUI_KILLS_CAPS"), UIExpression.GetDStat(InstanceRef, "ItemStats", f9_local2, "stats", "kills", "statValue"))
		CoD.CombatRecord.DisplayStatsRow({
			left = 0,
			top = 180,
			right = 0,
			bottom = 210,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false
		}, Widget, 2, Engine.Localize("MPUI_ACCURACY_CAPS"), string.format("%.2f", UIExpression.GetDStat(InstanceRef, "ItemStats", f9_local2, "stats", "hits", "statValue") * 100 / UIExpression.GetDStat(InstanceRef, "ItemStats", f9_local2, "stats", "shots", "statValue")) .. "%")
	end
end

CoD.CombatRecord.PrepareCareerTab = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	CoD.CombatRecord.ShowXPBar(InstanceRef, Widget)
	CoD.CombatRecord.SetText({
		left = -1,
		top = 50,
		right = 1,
		bottom = 75,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}, Widget, Engine.Localize("MPUI_SUMMARY_CAPS"))
	local Widget = LUI.UIElement.new({
		left = 200,
		top = 100,
		right = -200,
		bottom = -110,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget:addElement(Widget)
	Widget:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = 0.1,
		red = 0,
		green = 0,
		blue = 0
	}))
	local f10_local2 = UIExpression.GetDStat(InstanceRef, "PlayerStatsList", "RANK", "StatValue")
	local f10_local3 = UIExpression.GetDStat(InstanceRef, "PlayerStatsList", "PLEVEL", "StatValue")
	local f10_local4 = nil
	if CoD.PrestigeNext(InstanceRef) == true then
		f10_local4 = UIExpression.TableLookup(InstanceRef, CoD.rankIconTable, 0, 0, f10_local3 + 2)
	else
		f10_local4 = UIExpression.TableLookup(InstanceRef, CoD.rankIconTable, 0, f10_local2 + 1, f10_local3 + 1)
	end
	Widget:addElement(LUI.UIImage.new({
		left = -100,
		top = 20,
		bottom = 220,
		right = 100,
		leftAnchor = false,
		topAnchor = true,
		bottomAnchor = false,
		rightAnchor = false,
		material = RegisterMaterial(f10_local4),
		alpha = 1
	}))
	CoD.CombatRecord.DisplayStatsRow({
		left = 0,
		top = 240,
		right = 0,
		bottom = 270,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, Widget, 1, Engine.Localize("MPUI_TIME_PLAYED_CAPS"), UIExpression.SecondsAsTime(InstanceRef, UIExpression.GetDStat(InstanceRef, "PlayerStatsList", "TIME_PLAYED_TOTAL", "StatValue")))
	CoD.CombatRecord.DisplayStatsRow({
		left = 0,
		top = 270,
		right = 0,
		bottom = 300,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, Widget, 2, Engine.Localize("MPUI_TOTAL_WINS_CAPS"), UIExpression.GetDStat(InstanceRef, "PlayerStatsList", "WINS", "StatValue"))
	local f10_local5 = Engine.GetPlayerStats(InstanceRef)
	CoD.CombatRecord.DisplayStatsRow({
		left = 0,
		top = 300,
		right = 0,
		bottom = 330,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, Widget, 3, Engine.Localize("MPUI_TOTAL_LOSSES_CAPS"), CoD.CombatRecord.GetLossesStat(f10_local5.PlayerStatsList.LOSSES.StatValue))
	CoD.CombatRecord.DisplayStatsRow({
		left = 0,
		top = 330,
		right = 0,
		bottom = 360,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, Widget, 4, Engine.Localize("MPUI_RATIO_CAPS"), string.format("%.2f", UIExpression.GetDStat(InstanceRef, "PlayerStatsList", "WLRATIO", "StatValue") / 1000))
	CoD.CombatRecord.DisplayStatsRow({
		left = 0,
		top = 360,
		right = 0,
		bottom = 390,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, Widget, 5, Engine.Localize("MPUI_BEST_STREAK_CAPS"), UIExpression.GetDStat(InstanceRef, "HighestStats", "WIN_STREAK"))
	Widget.xpBar:animateToState("animate_xp_bar", 1000, false, false)
	return Widget
end

CoD.CombatRecord.PrepareWeaponsTab = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	CoD.CombatRecord.SetText({
		left = -1,
		top = 50,
		right = 1,
		bottom = 75,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}, Widget, Engine.Localize("MPUI_COMBAT_SUMMARY_CAPS"))
	CoD.CombatRecord.PrepareSummaryStats(Widget, InstanceRef)
	CoD.CombatRecord.PrepareSummaryFavouriteWeapon(Widget, InstanceRef)
	CoD.CombatRecord.SummaryDisplayKDBox(Widget, InstanceRef)
	return Widget
end

CoD.CombatRecord.Matches_PrepareTable = function (f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = {}
	local f12_local1 = {}
	local f12_local2 = 0
	for f12_local3 = 1, f12_arg1, 1 do
		if UIExpression.GetDStat(f12_arg0, "PlayerStatsByGameType", CoD.CombatRecord.GameTypeTable[f12_arg2].type, "prevScores", f12_local3 - 1, "valid") == 0 then
			break
		end
		local f12_local6 = UIExpression.GetDStat(f12_arg0, "PlayerStatsByGameType", CoD.CombatRecord.GameTypeTable[f12_arg2].type, "prevScores", f12_local3 - 1, "score")
		table.insert(f12_local1, f12_local6)
		table.insert(f12_local0, f12_local6)
		if f12_local2 < f12_local6 then
			f12_local2 = f12_local6
		end
	end
	return f12_local0, f12_local1, f12_local2
end

CoD.CombatRecord.DisplayLineGraph = function (f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4, f13_arg5, f13_arg6)
	local f13_local0 = {}
	local f13_local1 = {}
	local f13_local2 = 0
	local f13_local3 = 22
	local f13_local4 = 15
	local f13_local5 = 32
	if f13_arg6 ~= nil then
		local f13_local6, f13_local7, f13_local8 = f13_arg4(f13_arg0, f13_arg5, f13_arg6)
		f13_local2 = f13_local8
		f13_local0 = f13_local7
		f13_local1 = f13_local6
	else
		local f13_local6, f13_local7, f13_local8 = f13_arg4(f13_arg0, f13_arg5)
		f13_local2 = f13_local8
		f13_local0 = f13_local7
		f13_local1 = f13_local6
	end
	local f13_local6 = #f13_local0
	local f13_local7 = {}
	local f13_local8 = {}
	for f13_local12, f13_local13 in ipairs(f13_local0) do
		f13_local7[f13_local6 - f13_local12 + 1] = f13_local13
	end
	for f13_local12, f13_local13 in ipairs(f13_local1) do
		f13_local8[f13_local6 - f13_local12 + 1] = f13_local13
	end
	f13_arg1:addElement(CoD.Line.new({
		0,
		f13_arg3 / 2
	}, {
		f13_arg2,
		f13_arg3 / 2
	}, 1, {
		1,
		1,
		1,
		0.2
	}))
	if #f13_local7 > 1 then
		f13_local11 = (f13_arg2 - f13_local4 - f13_local5) / f13_arg5
		f13_local12 = f13_arg3 / 2 - f13_local3
		f13_local13 = {}
		local f13_local14 = {}
		local f13_local15 = {
			0.09,
			0.67,
			0.84,
			1
		}
		local f13_local16 = 5
		local f13_local17 = {
			0,
			1,
			0,
			1
		}
		local f13_local18 = {
			1,
			0,
			0,
			1
		}
		f13_local13[1] = f13_local4
		if f13_local7[1] > 1 then
			f13_local13[2] = f13_local12 - f13_local7[1] / f13_local2 * f13_local12 + f13_local3
		else
			f13_local13[2] = f13_arg3 - f13_local3 - f13_local7[1] * f13_local12
		end
		for f13_local19 = 1, #f13_local7 - 1, 1 do
			f13_local14[1] = f13_local11 * f13_local19 + f13_local4
			if f13_local7[f13_local19 + 1] > 1 then
				f13_local14[2] = f13_local12 - f13_local7[f13_local19 + 1] / f13_local2 * f13_local12 + f13_local3
			else
				f13_local14[2] = f13_arg3 - f13_local3 - f13_local7[f13_local19 + 1] * f13_local12
			end
			f13_arg1:addElement(CoD.Line.new(f13_local13, f13_local14, 1, f13_local15))
			if f13_local13[2] < f13_arg3 / 2 then
				f13_arg1:addElement(LUI.UIImage.new({
					left = f13_local13[1] - f13_local16 / 2,
					top = f13_local13[2] - f13_local16 / 2,
					right = f13_local13[1] + f13_local16 / 2,
					bottom = f13_local13[2] + f13_local16 / 2,
					leftAnchor = true,
					topAnchor = true,
					rightAnchor = false,
					bottomAnchor = false,
					red = f13_local17[1],
					green = f13_local17[2],
					blue = f13_local17[3],
					alpha = f13_local17[4]
				}))
			else
				f13_arg1:addElement(LUI.UIImage.new({
					left = f13_local13[1] - f13_local16 / 2,
					top = f13_local13[2] - f13_local16 / 2,
					right = f13_local13[1] + f13_local16 / 2,
					bottom = f13_local13[2] + f13_local16 / 2,
					leftAnchor = true,
					topAnchor = true,
					rightAnchor = false,
					bottomAnchor = false,
					red = f13_local18[1],
					green = f13_local18[2],
					blue = f13_local18[3],
					alpha = f13_local18[4]
				}))
			end
			local f13_local22 = f13_local13[2] + f13_local16 / 2
			local f13_local23 = f13_local13[2] + f13_local3
			if f13_local13[2] < f13_local14[2] then
				f13_local22 = f13_local13[2] - f13_local3
				f13_local23 = f13_local13[2] - f13_local16 / 2
			end
			CoD.CombatRecord.SetText({
				left = f13_local13[1] - 10,
				top = f13_local22,
				right = f13_local13[1] + 10,
				bottom = f13_local23,
				leftAnchor = true,
				topAnchor = true,
				rightAnchor = false,
				bottomAnchor = false,
				font = CoD.fonts.Default,
				alignment = LUI.Alignment.Left
			}, f13_arg1, f13_local8[f13_local19])
			f13_local13[1] = f13_local14[1]
			f13_local13[2] = f13_local14[2]
		end
		local f13_local20 = CoD.CombatRecord.AddContainer({
			left = f13_local14[1],
			top = f13_local14[2] - f13_local3 / 2 + f13_local16 / 2,
			right = f13_local14[1] + f13_local5 - 4,
			bottom = f13_local14[2] + f13_local3 / 2 - f13_local16 / 2,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false
		}, f13_arg1)
		f13_local20:addElement(LUI.UIImage.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true,
			red = f13_local15[1],
			green = f13_local15[2],
			blue = f13_local15[3],
			alpha = f13_local15[4]
		}))
		CoD.CombatRecord.SetText({
			left = -1,
			top = 0,
			right = 1,
			bottom = 0,
			leftAnchor = false,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true,
			font = CoD.fonts.Condensed
		}, f13_local20, f13_local8[#f13_local8])
	else
		CoD.CombatRecord.SetText({
			left = 0,
			top = f13_arg3,
			right = f13_arg2,
			bottom = f13_arg3 + 20,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false,
			font = CoD.fonts.Default,
			alignment = LUI.Alignment.Center
		}, f13_arg1, Engine.Localize("MPUI_NOT_ENOUGH_DATA"))
	end
end

CoD.CombatRecord.DisplayGameTypePerformanceGraph = function (f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = 30
	local f14_local1 = 380
	local f14_local2 = 250
	f14_arg0.ScoreContainer = CoD.CombatRecord.AddContainer({
		left = 0,
		top = f14_local0,
		right = f14_local1,
		bottom = f14_local0 + f14_local2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}, f14_arg0)
	f14_arg0.ScoreLineGraphContainer = CoD.CombatRecord.AddContainer({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}, f14_arg0.ScoreContainer, true)
	f14_arg0.ScoreBoxBg = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = f14_local1,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		alpha = 0.1,
		red = 0,
		green = 0,
		blue = 0
	})
	f14_arg0.ScoreLineGraphContainer:addElement(f14_arg0.ScoreBoxBg)
	CoD.CombatRecord.DisplayLineGraph(f14_arg1, f14_arg0.ScoreLineGraphContainer, f14_local1, f14_local2, CoD.CombatRecord.Matches_PrepareTable, 10, f14_arg2)
end

CoD.CombatRecord.PerformanceRowGainFocus = function (f15_arg0, f15_arg1)
	f15_arg0.informationPane.header = CoD.CombatRecord.SetText({
		left = -1,
		top = 5,
		right = 1,
		bottom = 25,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	}, f15_arg0.informationPane, Engine.Localize("MPUI_CR_MATCH_PERFORMANCE_HISTOGRAM_TITLE", CoD.CombatRecord.GameTypeTable[f15_arg0.index].localizedString))
	CoD.CombatRecord.DisplayGameTypePerformanceGraph(f15_arg0.informationPane, f15_arg0.controller, f15_arg0.index)
	LUI.UIButton.gainFocus(f15_arg0, f15_arg1)
end

CoD.CombatRecord.PerformanceRowLoseFocus = function (f16_arg0, f16_arg1)
	f16_arg0.informationPane.header:close()
	f16_arg0.informationPane.ScoreContainer:close()
	LUI.UIButton.loseFocus(f16_arg0, f16_arg1)
end

CoD.CombatRecord.AddButton = function (f17_arg0, f17_arg1, f17_arg2, f17_arg3)
	local f17_local0 = f17_arg0.gameTypeButtonList:addButton(f17_arg1)
	f17_local0.informationPane = f17_arg0.informationPane
	f17_local0.index = f17_arg2
	f17_local0.controller = f17_arg3
	f17_local0:registerEventHandler("gain_focus", CoD.CombatRecord.PerformanceRowGainFocus)
	f17_local0:registerEventHandler("lose_focus", CoD.CombatRecord.PerformanceRowLoseFocus)
end

CoD.CombatRecord.PrepareMatchesTab = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	local f18_local1 = LUI.UIText.new({
		left = -1,
		top = 50,
		right = 1,
		bottom = 75,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	Widget:addElement(f18_local1)
	f18_local1:setText(Engine.Localize("MPUI_MATCH_PERFORMANCE_CAPS"))
	Widget.gameTypeButtonList = CoD.ButtonList.new({
		left = -380,
		top = 100,
		right = -60,
		bottom = 0,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	})
	Widget:addElement(Widget.gameTypeButtonList)
	Widget.informationPane = LUI.UIElement.new({
		left = 5,
		top = 100,
		right = 385,
		bottom = 380,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		alpha = 1
	})
	Widget:addElement(Widget.informationPane)
	for f18_local2 = 1, CoD.CombatRecord.MaximumNumGameType, 1 do
		CoD.CombatRecord.AddButton(Widget, Engine.Localize(CoD.CombatRecord.GameTypeTable[f18_local2].localizedString), f18_local2, InstanceRef)
	end
	Widget.gameTypeButtonList:processEvent({
		name = "gain_focus"
	})
	return Widget
end

LUI.createMenu.CombatRecord = function (f19_arg0)
	local f19_local0 = CoD.Menu.New("CombatRecord")
	f19_local0:addBackButton()
	f19_local0.tabContentPane = CoD.CombatRecord.AddContainer({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}, f19_local0)
	local f19_local1 = CoD.MFTabManager.new(f19_local0.tabContentPane, {
		left = 0,
		top = 0,
		right = 0,
		bottom = CoD.ButtonPrompt.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f19_local0:addElement(f19_local1)
	f19_local1:addTab(f19_arg0, "MPUI_CAREER_CAPS", CoD.CombatRecord.PrepareCareerTab)
	f19_local1:addTab(f19_arg0, "MPUI_WEAPONS_CAPS", CoD.CombatRecord.PrepareWeaponsTab)
	f19_local1:addTab(f19_arg0, "MPUI_MATCHES_CAPS", CoD.CombatRecord.PrepareMatchesTab)
	f19_local1:refreshTab(f19_arg0)
	return f19_local0
end

