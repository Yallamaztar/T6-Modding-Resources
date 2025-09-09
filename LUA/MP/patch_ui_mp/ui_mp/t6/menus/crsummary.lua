require("T6.Menus.CRCommon")
CoD.CRSummary = {}
CoD.CRSummary.GetSingleMedalBox = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = 145
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f1_local0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(CoD.GetInformationContainer())
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.1))
	local f1_local2 = 115
	local f1_local3 = LUI.UIVerticalList.new()
	f1_local3:setLeftRight(false, false, -f1_local2 / 2, f1_local2 / 2)
	f1_local3:setTopBottom(true, true, 5, 0)
	f1_local3:setSpacing(5)
	Widget:addElement(f1_local3)
	local f1_local4 = CoD.GetStretchedImage(f1_arg0, true)
	f1_local4:setTopBottom(true, false, 0, f1_local2)
	f1_local3:addElement(f1_local4)
	f1_local3:addSpacer(15)
	f1_local3:addElement(CoD.GetTextElem("ExtraSmall", "Center", f1_arg1))
	f1_local3:addElement(CoD.GetTextElem("Big", "Center", f1_arg2))
	return Widget
end

CoD.CRSummary.SetupMedalsBox = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.summaryInfo
	local f2_local1 = Engine.GetPlayerStats(f2_arg1)
	if CoD.CRCommon.OtherPlayerCRMode == true then
		f2_local1 = Engine.GetPlayerStats(f2_arg1, CoD.STATS_LOCATION_OTHERPLAYER)
	end
	local f2_local2 = f2_local1.PlayerStatsList.HEADSHOTS.statValue:get()
	local f2_local3 = 70
	f2_arg0:addElement(CoD.GetTextElem("Default", "Left", Engine.Localize("MENU_CRITICAL_DAMAGE_CAPS"), CoD.gray, f2_local3))
	f2_local3 = f2_local3 + 30
	local Widget = LUI.UIElement.new()
	local f2_local5 = 220
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f2_local3, f2_local3 + f2_local5)
	f2_arg0:addElement(Widget)
	local f2_local6 = LUI.UIHorizontalList.new()
	f2_local6:setLeftRight(true, true, 0, 0)
	f2_local6:setTopBottom(true, true, 0, 0)
	f2_local6:setSpacing(10)
	Widget:addElement(f2_local6)
	f2_local6:addElement(CoD.CRSummary.GetSingleMedalBox("hud_medals_headshot", Engine.Localize("MENU_LB_HEADSHOTS"), f2_local2))
	f2_local6:addElement(CoD.CRSummary.GetSingleMedalBox(f2_local0.topKillstreakMedal.medalImage, Engine.Localize(f2_local0.topKillstreakMedal.medalName), f2_local0.topKillstreakMedal.timesEarned))
	f2_local6:addElement(CoD.CRSummary.GetSingleMedalBox(f2_local0.topMultikillMedal.medalImage, Engine.Localize(f2_local0.topMultikillMedal.medalName), f2_local0.topMultikillMedal.timesEarned))
end

CoD.CRSummary.GetSingleWeaponBox = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = 70
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, f3_local0)
	Widget:addElement(CoD.GetInformationContainer())
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.1))
	local f3_local2 = LUI.UIHorizontalList.new()
	f3_local2:setLeftRight(true, true, 50, 0)
	f3_local2:setTopBottom(true, true, 0, 0)
	Widget:addElement(f3_local2)
	local f3_local3 = CoD.GetTextElem("Default", "Left", f3_arg0)
	local f3_local4 = CoD.textSize.Default
	f3_local3:setLeftRight(true, true, 10, 0)
	f3_local3:setTopBottom(false, false, -f3_local4 / 2, f3_local4 / 2)
	Widget:addElement(f3_local3)
	local f3_local5 = f3_local0 * 0.8
	local f3_local6 = f3_local5 * 2
	local f3_local7 = CoD.GetStretchedImage(UIExpression.GetItemImage(nil, f3_arg1))
	f3_local7:setLeftRight(true, false, 0, f3_local6)
	f3_local7:setTopBottom(false, false, -f3_local5 / 2, f3_local5 / 2)
	f3_local2:addElement(f3_local7)
	f3_local2:addSpacer(5)
	local f3_local8 = 10
	local f3_local9 = CoD.GetTextElem("Default", "Left", Engine.Localize(UIExpression.GetItemName(nil, f3_arg1)), nil, f3_local8)
	f3_local9:setLeftRight(true, true, f3_local6 + 80, 0)
	local f3_local10 = CoD.GetTextElem("Default", "Left", Engine.Localize("MENU_X_KILLS", f3_arg2), nil, f3_local8 + CoD.textSize.Default)
	f3_local10:setLeftRight(true, true, f3_local6 + 80, 0)
	Widget:addElement(f3_local9)
	Widget:addElement(f3_local10)
	return Widget
end

CoD.CRSummary.SetupWeaponsBox = function (f4_arg0, f4_arg1)
	local f4_local0 = 70
	local f4_local1 = 220
	local f4_local2 = 370
	local f4_local3 = CoD.GetTextElem("Default", "Left", Engine.Localize("MENU_DEADLIEST_WEAPONS_CAPS"), CoD.gray, f4_local0)
	f4_local3:setLeftRight(false, true, -f4_local2, 0)
	f4_arg0:addElement(f4_local3)
	f4_local0 = f4_local0 + 30
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f4_local2, 0)
	Widget:setTopBottom(true, false, f4_local0, f4_local0 + f4_local1)
	f4_arg0:addElement(Widget)
	local f4_local5 = LUI.UIVerticalList.new()
	f4_local5:setLeftRight(true, true, 0, 0)
	f4_local5:setTopBottom(true, true, 0, 0)
	f4_local5:setSpacing(5)
	Widget:addElement(f4_local5)
	local f4_local6 = f4_arg0.summaryInfo
	for f4_local7 = 1, 3, 1 do
		f4_local5:addElement(CoD.CRSummary.GetSingleWeaponBox(f4_local7, f4_local6.topWeapons[f4_local7].itemIndex, f4_local6.topWeapons[f4_local7].itemValue))
	end
end

local f0_local0 = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	local f5_local0 = "Default"
	local f5_local1 = LUI.UIText.new()
	f5_local1:setLeftRight(true, true, 0, 0)
	f5_local1:setTopBottom(true, false, 0, CoD.textSize[f5_local0])
	f5_local1:setFont(CoD.fonts[f5_local0])
	f5_local1:setAlignment(LUI.Alignment.Left)
	f5_local1:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	f5_local1:setText(Engine.Localize("MENU_KD_LAST_5_CAPS"))
	f5_arg1:addElement(f5_local1)
	local f5_local2 = CoD.textSize[f5_local0]
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f5_local2, 0)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.1))
	f5_arg1:addElement(Widget)
	local f5_local4 = Engine.GetPlayerStats(f5_arg0)
	if CoD.CRCommon.OtherPlayerCRMode == true then
		f5_local4 = Engine.GetPlayerStats(f5_arg0, CoD.STATS_LOCATION_OTHERPLAYER)
	end
	CoD.AfterActionReport.GetKDGraphWidget(f5_arg0, Widget, f5_arg2, f5_arg3 - f5_local2, f5_local4.gameHistory.publicmatch)
end

CoD.CRSummary.SetupKDGraphBox = function (f6_arg0, f6_arg1)
	local f6_local0 = 50
	local f6_local1 = 250
	local f6_local2 = 455
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f6_local2)
	Widget:setTopBottom(false, true, -f6_local0 - f6_local1, -f6_local0)
	f6_arg0:addElement(Widget)
	f0_local0(f6_arg0.m_ownerController, Widget, f6_local2, f6_local1)
end

CoD.CRSummary.SetupScorestreakBox = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg0.summaryInfo
	local f7_local1 = 50
	local f7_local2 = 250
	local f7_local3 = 370
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f7_local3, 0)
	Widget:setTopBottom(false, true, -f7_local1 - f7_local2, -f7_local1)
	f7_arg0:addElement(Widget)
	Widget:addElement(CoD.GetTextElem("Default", "Left", Engine.Localize("MENU_DEADLIEST_SCORESTREAK_CAPS"), CoD.gray))
	local f7_local5 = LUI.UIContainer.new()
	f7_local5:setTopBottom(true, true, CoD.textSize.Default, 0)
	Widget:addElement(f7_local5)
	f7_local5:addElement(CoD.GetInformationContainer())
	local f7_local6 = 200
	local f7_local7 = f7_local6
	local f7_local8 = CoD.GetCenteredImage(f7_local7, f7_local6, UIExpression.GetItemImage(nil, f7_local0.topScorestreak.itemIndex) .. "_menu")
	f7_local8:setLeftRight(true, false, 10, 10 + f7_local7)
	local f7_local9 = 80
	local f7_local10 = CoD.GetTextElem("Default", "Left", Engine.Localize(UIExpression.GetItemName(nil, f7_local0.topScorestreak.itemIndex)), nil, f7_local9)
	f7_local10:setLeftRight(true, true, f7_local7 + 40, 0)
	local f7_local11 = CoD.GetTextElem("Default", "Left", Engine.Localize("MENU_X_KILLS", f7_local0.topScorestreak.itemValue), nil, f7_local9 + CoD.textSize.Default)
	f7_local11:setLeftRight(true, true, f7_local7 + 40, 0)
	f7_local5:addElement(f7_local10)
	f7_local5:addElement(f7_local11)
	f7_local5:addElement(f7_local8)
end

CoD.CRSummary.SetupElements = function (f8_arg0, f8_arg1)
	if CoD.CRCommon.CurrentXuid and CoD.CRCommon.CurrentXuid ~= "" and CoD.CRCommon.CurrentXuid ~= "0" then
		f8_arg0:addElement(CoD.MiniIdentity.GetMiniIdentity(f8_arg1, CoD.CRCommon.CurrentXuid))
	end
	f8_arg0.summaryInfo = Engine.GetCombatRecordSummaryInfo(f8_arg1, CoD.CRCommon.OtherPlayerCRMode == true)
	CoD.CRSummary.SetupMedalsBox(f8_arg0, f8_arg1)
	CoD.CRSummary.SetupWeaponsBox(f8_arg0, f8_arg1)
	CoD.CRSummary.SetupKDGraphBox(f8_arg0, f8_arg1)
	CoD.CRSummary.SetupScorestreakBox(f8_arg0, f8_arg1)
end

LUI.createMenu.CRSummary = function (f9_arg0)
	local f9_local0 = CoD.Menu.New("CRSummary")
	f9_local0:addLargePopupBackground()
	f9_local0:setOwner(f9_arg0)
	f9_local0:setPreviousMenu("Barracks")
	f9_local0:addBackButton()
	f9_local0:addTitle(Engine.Localize("MPUI_COMBAT_SUMMARY_CAPS"))
	CoD.CRSummary.SetupElements(f9_local0, f9_arg0)
	return f9_local0
end

