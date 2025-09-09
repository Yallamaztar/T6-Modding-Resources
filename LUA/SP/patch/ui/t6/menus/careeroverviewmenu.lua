require("T6.BorderLite")
require("T6.ListBox")
require("T6.Menus.AARUtility")
require("T6.Menus.CareerLeaderboard")
require("T6.ScrollingVerticalList")
require("T6.Menus.StoryOverviewMenu")
require("T6.Menus.VerticalScrollbar")
require("T6.Menus.LeaderboardOverviewMenu")
require("T6.Menus.CACLoadOutMenu")
CoD.CareerOverviewMenu = {}
CoD.CareerOverviewMenu.Leaderboard = {}
CoD.CareerOverviewMenu.Compareboard = {}
CoD.CareerOverviewMenu.LeaderboardsTab = {}
CoD.CareerOverviewMenu.LeaderboardsTab.LeftHalfWidth = 430
CoD.CareerOverviewMenu.LeaderboardsTab.LeftRightSpacing = 40
CoD.CareerOverviewMenu.MapHighlight = ""
CoD.CareerOverviewMenu.FullListColumnWidth = {}
CoD.CareerOverviewMenu.FullListColumnWidth[1] = 220
CoD.CareerOverviewMenu.FullListColumnWidth[2] = 120
CoD.CareerOverviewMenu.FullListColumnWidth[3] = 120
CoD.CareerOverviewMenu.FullListColumnWidth[4] = 200
CoD.CareerOverviewMenu.FullListColumnWidth[5] = 170
CoD.CareerOverviewMenu.FullListColumnAlignment = {}
CoD.CareerOverviewMenu.FullListColumnAlignment[1] = LUI.Alignment.Left
CoD.CareerOverviewMenu.FullListColumnAlignment[2] = LUI.Alignment.Center
CoD.CareerOverviewMenu.FullListColumnAlignment[3] = LUI.Alignment.Center
CoD.CareerOverviewMenu.FullListColumnAlignment[4] = LUI.Alignment.Center
CoD.CareerOverviewMenu.FullListColumnAlignment[5] = LUI.Alignment.Center
CoD.CareerOverviewMenu.Teal = {
	r = 0.4,
	g = 0.92,
	b = 0.86
}
CoD.CareerOverviewMenu.TopBorder = 60
CoD.CareerOverviewMenu.EnterSFX = "cac_enter_cac"
local f0_local0 = nil
CoD.CareerOverviewMenu.CreateOverviewTab = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget.contentPane = LUI.UIElement.new()
	Widget.contentPane:setLeftRight(true, true, 0, 0)
	Widget.contentPane:setTopBottom(true, true, CoD.CareerOverviewMenu.TopBorder, 0)
	Widget:addElement(Widget.contentPane)
	CoD.CareerOverviewMenu.multiLeaderboard = CoD.CareerOverviewMenu.CreateLeaderboardLookupTable(Widget, InstanceRef)
	CoD.CareerOverviewMenu.rankRows = CoD.CareerOverviewMenu.CreateList(Widget.contentPane, InstanceRef)
	Widget:registerEventHandler("multi_read_update", CoD.CareerOverviewMenu.MultiReadUpdate)
	local f1_local1 = false
	local f1_local2 = Engine.IsSignedInToDemonware(InstanceRef) == true
	local f1_local3 = UIExpression.IsSignedInToLive(InstanceRef) ~= 0
	if f1_local3 then
		local f1_local4 = CoD.isPS3
		if f1_local4 == 0 then
			f1_local1 = f1_local4
		else
			f1_local1 = UIExpression.IsContentRatingAllowed(InstanceRef) == 0
		end
	end
	if f1_local2 and f1_local3 and not f1_local1 then
		CoD.CareerOverviewMenu.LoadLeaderboard(HudRef, InstanceRef, CoD.CareerOverviewMenu.multiLeaderboard)
	end
	Widget.signedInToLive = f1_local3
	if CoD.isPS3 then
		Widget.timer = LUI.UITimer.new(1000, "check_login", false, Widget)
		Widget:addElement(Widget.timer)
		Widget:registerEventHandler("check_login", CoD.CareerOverviewMenu.CheckLogin)
	end
	return Widget
end

CoD.CareerOverviewMenu.CheckLogin = function (f2_arg0, f2_arg1)
	if UIExpression.IsSignedInToLive(f2_arg1.controller) ~= 0 ~= f2_arg0.signedInToLive then
		f2_arg0:dispatchEventToParent({
			name = "button_prompt_back",
			controller = f2_arg1.controller
		})
	end
end

CoD.CareerOverviewMenu.CreateLeaderboardLookupTable = function (f3_arg0, f3_arg1)
	local f3_local0 = {}
	local f3_local1 = UIExpression.GetDStat(f3_arg1, "PlayerStatsList", "HIGHESTLEVELCOMPLETED", "personalBest") + 1
	f3_local0.LB_SP_CAMPAIGN = {
		lbDef = "LB_SP_CAMPAIGN",
		lbFilter = "TRK_ALLTIME",
		map = "CAMPAIGN"
	}
	for f3_local9, f3_local10 in ipairs(CoD.AARUtility.MapList) do
		if not f3_local10.isDevLevel then
			local f3_local5 = "LB_SP_" .. UIExpression.ToUpper(nil, f3_local10.alias)
			local f3_local6 = UIExpression.TableLookup(f3_arg1, CoD.AARUtility.LevelTable, 1, f3_local10.name, 0)
			local f3_local7
			if f3_local6 == 0 then
				f3_local7 = f3_local6
			else
				f3_local7 = tonumber(f3_local6)
				if f3_local7 then
					f3_local7 = tonumber(f3_local6) <= f3_local1
				end
			end
			local f3_local8 = f3_local10.isRTSMap
			if f3_local8 then
				f3_local8 = f3_local10.rtsStart
				if f3_local8 then
					f3_local8 = tonumber(f3_local10.rtsStart)
					if f3_local8 then
						f3_local8 = tonumber(f3_local10.rtsStart) < f3_local1
					end
				end
			end
			if f3_local7 or f3_local8 then
				f3_local0[f3_local5] = {
					lbDef = f3_local5,
					lbFilter = "TRK_ALLTIME"
				}
			end
		end
	end
	return f3_local0
end

CoD.CareerOverviewMenu.LoadLeaderboard = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = 5
	local f4_local1 = {}
	for f4_local5, f4_local6 in pairs(f4_arg2) do
		if f4_local0 <= table.getn(f4_local1) then
			break
		end
		f4_arg2[f4_local5] = nil
		table.insert(f4_local1, f4_local6)
	end
	if table.getn(f4_local1) > 0 then
		Engine.RequestMultiLeaderboardData(f4_arg1, CoD.REQUEST_MULTI_LB_READ_COMBAT_RECORD_DATA, CoD.LB_FILTER_FRIENDS, f4_local1)
	else
		CoD.CareerLeaderboard.UpdateBlankRanks(f4_arg0, f4_arg1)
	end
end

CoD.CareerOverviewMenu.Leaderboard.Text_SetActivelyComparedPlayerColor = function (f5_arg0, f5_arg1)
	f5_arg0:setRGB(CoD.AARUtility.OtherPlayerStatColor.r, CoD.AARUtility.OtherPlayerStatColor.g, CoD.AARUtility.OtherPlayerStatColor.b)
end

CoD.CareerOverviewMenu.Leaderboard.Text_SetRegularPlayerColor = function (f6_arg0, f6_arg1)
	f6_arg0:setRGB(1, 1, 1)
end

local f0_local1 = function (f7_arg0, f7_arg1)
	if f7_arg0 ~= nil then
		local f7_local0 = false
		local f7_local1 = UIExpression.IsSignedInToLive(controller) ~= 0
		local f7_local2 = Engine.IsSignedInToDemonware(controller) == true
		if f7_local1 then
			local f7_local3 = CoD.isPS3
			if f7_local3 == 0 then
				f7_local0 = f7_local3
			else
				f7_local0 = UIExpression.IsContentRatingAllowed(controller) == 0
			end
		end
		if not f7_local0 and f7_local1 and f7_local2 then
			local f7_local3 = CoD.ButtonPrompt.new
			local f7_local4 = "alt1"
			local f7_local5 = Engine.Localize("PLATFORM_SHOW_GAMERCARD")
			local f7_local6 = f7_arg0
			local f7_local7 = "view_gamer_card"
			local f7_local8, f7_local9 = false
			local f7_local10, f7_local11 = false
			f7_arg0.gamercardButton = f7_local3(f7_local4, f7_local5, f7_local6, f7_local7, f7_local8, f7_local9, f7_local10, f7_local11, "P")
			f7_arg0:addLeftButtonPrompt(f7_arg0.gamercardButton)
		end
	end
end

local f0_local2 = function (f8_arg0, f8_arg1)
	if f8_arg0 ~= nil and f8_arg0.gamercardButton ~= nil then
		f8_arg0.gamercardButton:close()
		f8_arg0.gamercardButton = nil
	end
end

local f0_local3 = function (f9_arg0, f9_arg1)
	if f9_arg0 ~= nil then
		f9_arg0:addBackButton()
	end
end

local f0_local4 = function (f10_arg0, f10_arg1)
	if f10_arg0 ~= nil then
		f10_arg0:removeBackButton()
	end
end

local f0_local5 = function (f11_arg0, f11_arg1)
	if f11_arg0 ~= nil then
		f11_arg0:addSelectButton()
	end
end

local f0_local6 = function (f12_arg0, f12_arg1)
	if f12_arg0 ~= nil then
		f12_arg0:removeSelectButton()
	end
end

local f0_local7 = function (f13_arg0, f13_arg1)
	if f13_arg1.tabIndex == 2 then
		f0_local6(f13_arg0, f13_arg1)
	else
		f0_local6(f13_arg0, f13_arg1)
		f0_local4(f13_arg0, f13_arg1)
		f0_local5(f13_arg0, f13_arg1)
		f0_local3(f13_arg0, f13_arg1)
	end
	if f13_arg1.tabIndex == 3 then
		if CoD.isPS3 then
			f0_local2(f13_arg0, f13_arg1)
		end
		if CoD.isXBOX or CoD.isPS3 or CoD.isPC then
			f0_local1(f13_arg0, f13_arg1)
		end
	elseif CoD.isXBOX or CoD.isPS3 or CoD.isPC then
		f0_local2(f13_arg0, f13_arg1)
	end
end

CoD.CareerLeaderboard.UpdateBlankRanks = function (f14_arg0, f14_arg1)
	for f14_local3, f14_local4 in pairs(CoD.CareerOverviewMenu.rankRows) do
		if f14_local4.assigned == nil or not f14_local4.assigned then
			f14_local4:setText("1/1")
		end
	end
end

CoD.CareerOverviewMenu.MultiReadUpdate = function (f15_arg0, f15_arg1)
	local f15_local0 = -1
	local f15_local1 = -1
	if f15_arg1.leaderboards == nil then
		return 
	end
	for f15_local5, f15_local6 in pairs(f15_arg1.leaderboards) do
		f15_local0 = f15_local6.userrank
		f15_local1 = f15_local6.numranks
		if f15_local0 == 0 then
			f15_local1 = f15_local1 + 1
			f15_local0 = f15_local1
		end
		CoD.CareerOverviewMenu.rankRows[f15_local6.def]:setText(f15_local0 .. "/" .. f15_local1)
		CoD.CareerOverviewMenu.rankRows[f15_local6.def].assigned = true
	end
	CoD.CareerOverviewMenu.LoadLeaderboard(f15_arg0, f15_arg1.controller, CoD.CareerOverviewMenu.multiLeaderboard)
end

LUI.createMenu.CareerOverviewMenu = function (f16_arg0, f16_arg1)
	local f16_local0 = CoD.Menu.New("CareerOverviewMenu")
	if f16_arg1 ~= nil and f16_arg1.previousMenu ~= nil then
		f16_local0:setPreviousMenu(f16_arg1.previousMenu)
		f16_local0.previousMenu = f16_arg1.previousMenu
		if f16_arg1.previousMap ~= nil then
			Dvar.ui_mapname:set(f16_arg1.previousMap)
		end
	else
		f16_local0:setPreviousMenu("MissionSelectMenu")
		f16_local0.previousMenu = "MissionSelectMenu"
	end
	local f16_local1 = UIExpression.GetPrimaryController()
	CoD.AfterActionReport.CurrentMap = UIExpression.GetAARLevelAlias(f16_local1)
	f16_local0:addTitle(Engine.Localize("MENU_CAREER_RECORD_CAPS"), LUI.Alignment.Center)
	f0_local5(f16_local0)
	f16_local0:addBackButton()
	f16_local0:registerEventHandler("map_selected", CoD.CareerOverviewMenu.MapSelected)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, CoD.Menu.TitleHeight, -CoD.ButtonPrompt.Height)
	f16_local0:addElement(Widget)
	local f16_local3 = CoD.Menu.TitleHeight + 15
	local f16_local4 = CoD.MFTabManager.new(Widget, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f16_local3,
		bottom = f16_local3 + CoD.MFTabManager.TabHeight
	}, nil, CoD.trueOrange)
	f16_local4:setTabAlignment(LUI.Alignment.Center)
	f16_local4:setTabSpacing(80)
	f16_local0:addElement(f16_local4)
	f16_local4:addTab(f16_local1, Engine.Localize("MENU_OVERVIEW_CAPS"), CoD.CareerOverviewMenu.CreateOverviewTab)
	f16_local4:addTab(f16_local1, Engine.Localize("MENU_STORY_CAPS"), CoD.StoryOverviewMenu.new)
	f16_local4:addTab(f16_local1, Engine.Localize("MENU_LEADERBOARDS_CAPS"), CoD.LeaderboardOverviewMenu.new)
	f16_local4:refreshTab(f16_local1)
	f16_local0:registerEventHandler("tab_changed", f0_local7)
	f16_local0.tabManager = f16_local4
	f16_local0.selectStoryTab = CoD.CareerOverviewMenu.SelectStoryTab
	f16_local0.addProceedButton = CoD.CareerOverviewMenu.AddProceedButton
	return f16_local0
end

f0_local0 = function (f17_arg0, f17_arg1)
	Engine.PlaySound(CoD.CareerOverviewMenu.EnterSFX)
	CoD.CACLoadOutMenu.RestoreDefaults()
	f17_arg0:swapMenu("CampaignMissionBriefingMenu")
end

CoD.CareerOverviewMenu.AddProceedButton = function (f18_arg0)
	local f18_local0 = {}
	f18_local0 = GetTextDimensions(Engine.Localize("PLATFORM_PROCEED"), CoD.fonts.Condensed, CoD.textSize.Condensed)
	local f18_local1, f18_local2 = Engine.GetUserSafeArea()
	local f18_local3 = LUI.UIButton.new()
	f18_local3:setLeftRight(true, true, 0, 0)
	f18_local3:setTopBottom(false, true, -CoD.textSize.Condensed, 0)
	f18_arg0:addElement(f18_local3)
	local f18_local4 = LUI.UIText.new()
	f18_local4:setLeftRight(true, true, 0, 0)
	f18_local4:setTopBottom(true, true, 0, 0)
	f18_local4:setFont(CoD.fonts.Condensed)
	f18_local4:setAlignment(LUI.Alignment.Right)
	f18_local3:addElement(f18_local4)
	f18_local4:setText(Engine.Localize("PLATFORM_PROCEED"))
	f18_local3:setFocus(true)
	if CoD.useMouse then
		f18_local3:setHandleMouse(false)
	end
end

CoD.CareerOverviewMenu.SelectStoryTab = function (f19_arg0)
	f19_arg0.tabManager:loadTab(controller, 2)
	f19_arg0.tabManager.leftTopButtonBar:close()
	f19_arg0.tabManager.leftTopButtonBar = nil
	f19_arg0.tabManager.rightTopButtonBar:close()
	f19_arg0.tabManager.rightTopButtonBar = nil
	f19_arg0.tabManager.m_inputDisabled = true
	f19_arg0:registerEventHandler("proceed_to_mision", f0_local0)
	f19_arg0:registerEventHandler("mouseup", f0_local0)
	f0_local4(f19_arg0)
	f19_arg0:addProceedButton()
end

local f0_local8 = function (f20_arg0)
	f20_arg0:setBorderAlpha(0)
	f20_arg0.glowBackground:setAlpha(0)
end

local f0_local9 = function (f21_arg0)
	CoD.CareerOverviewMenu.MapHighlight = f21_arg0.mapName
	f21_arg0:setBorderAlpha(1)
	f21_arg0.glowBackground:setAlpha(1)
end

local f0_local10 = function (f22_arg0, f22_arg1, f22_arg2, f22_arg3, f22_arg4)
	local f22_local0 = UIExpression.GetPrimaryController()
	local f22_local1 = {
		r = 1,
		g = 1,
		b = 1,
		a = 1
	}
	local f22_local2 = {
		CoD.visorBlue3,
		CoD.visorBlue3,
		CoD.CareerOverviewMenu.Teal,
		CoD.CareerOverviewMenu.Teal,
		CoD.CareerOverviewMenu.Teal
	}
	local f22_local3 = CoD.CoD9Button.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = f22_arg1
	})
	f22_local3.gainFocusSFX = "cac_grid_nav"
	
	local glowBackground = LUI.UIImage.new()
	glowBackground:setLeftRight(true, true, 0, 0)
	glowBackground:setTopBottom(true, true, 0, 0)
	glowBackground:setAlpha(0)
	glowBackground:setImage(RegisterMaterial("menu_mp_big_row"))
	f22_local3:addElement(glowBackground)
	f22_local3.glowBackground = glowBackground
	
	CoD.BorderLite.new(f22_local3, 1, CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b, 0)
	f22_local3:registerEventHandler("button_up", f0_local8)
	f22_local3:registerEventHandler("button_over", f0_local9)
	Dvar.ui_mapname:set(f22_arg2.name)
	local f22_local5 = nil
	if f22_arg2.isRTSMap then
		f22_local5 = Engine.Localize("MENU_LEVEL_" .. f22_arg2.alias .. "_CAPS")
	else
		f22_local5 = Engine.Localize("SPUI_" .. f22_arg2.alias .. "_MISSION_NAME")
	end
	local f22_local6 = UIExpression.GetLastSessionStat(f22_local0, "levelScore")
	if tonumber(f22_local6) == 0 then
		f22_local6 = "--"
	end
	local f22_local7 = UIExpression.GetLevelBestStat(f22_local0, "levelScore")
	if tonumber(f22_local7) == 0 then
		f22_local7 = "--"
	end
	local f22_local8 = "--"
	local f22_local9 = "--"
	local f22_local10, f22_local11 = nil
	local f22_local12, f22_local13 = CoD.CareerOverviewMenu.GetChallengesCounts(f22_local0)
	f22_local11 = f22_local13
	f22_local10 = f22_local12
	if tonumber(f22_local10) == 0 and f22_local7 == "--" then
		f22_local10 = "--"
	end
	CoD.CareerOverviewMenu.DecorateRow(f22_local3, {
		f22_local5,
		f22_local6,
		f22_local7,
		f22_local10 .. "/" .. f22_local11,
		f22_local8 .. "/" .. f22_local9
	}, f22_local2, nil, true, f22_arg0)
	f22_local3.mapName = f22_arg2.name
	f22_local3.mapAlias = f22_arg2.alias
	f22_local3.isRTSMap = f22_arg2.isRTSMap
	f22_local3:registerEventHandler("button_action", CoD.CareerOverviewMenu.ButtonSelected)
	return f22_local3, f22_local7, f22_local10, f22_local11
end

CoD.CareerOverviewMenu.CreateList = function (f23_arg0, f23_arg1, f23_arg2)
	local f23_local0 = {}
	local f23_local1 = 0
	for f23_local2 = 1, #CoD.CareerOverviewMenu.FullListColumnWidth, 1 do
		f23_local1 = f23_local1 + CoD.CareerOverviewMenu.FullListColumnWidth[f23_local2]
	end
	local f23_local3 = CoD.CoD9Button.Height + 1 * 2
	local f23_local4 = 15
	local f23_local5 = 3
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f23_local1 / 2, f23_local1 / 2)
	local f23_local7 = {}
	local f23_local8 = Engine.Localize("MENU_LEVEL_NAME_CAPS")
	local f23_local9 = Engine.Localize("MENU_LATEST_SCORE_CAPS")
	local f23_local10 = Engine.Localize("MENU_HIGH_SCORE_CAPS")
	local f23_local11 = Engine.Localize("MENU_CHALLENGES_COMPLETED_CAPS")
	local scrollbar = Engine.Localize("MENU_RANK_VS_FRIENDS_CAPS")
	f23_local7 = f23_local8
	f23_local8 = CoD.visorBlue1
	CoD.CareerOverviewMenu.DecorateRow(Widget, f23_local7, {
		f23_local8,
		f23_local8,
		f23_local8,
		f23_local8,
		f23_local8
	}, {
		font = CoD.fonts.Default,
		height = CoD.textSize.Default
	})
	f23_local10 = LUI.UIImage.new()
	f23_local10:setLeftRight(true, true, 0, 0)
	f23_local10:setTopBottom(true, false, 0, f23_local3)
	f23_local10:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f23_local10:setRGB(CoD.black.r, CoD.black.g, CoD.black.b)
	f23_local10:setAlpha(0.2)
	Widget:addElement(f23_local10)
	f23_local11 = CoD.ScrollingVerticalList.new()
	f23_local11:setLeftRight(false, false, -f23_local1 / 2, f23_local1 / 2)
	f23_local11:setTopBottom(true, true, f23_local3, -f23_local3 * 2)
	f23_local11.verticalList.disableWrapping = true
	f23_local11.scrollbar:close()
	
	scrollbar = CoD.VerticalScrollbar.new(f23_local11.verticalList, 0.2, 0.2, 0.2, 1)
	f23_local11:addElement(scrollbar)
	f23_local11.scrollbar = scrollbar
	
	f23_arg0.buttonList = f23_local11
	Widget:addElement(f23_local11)
	local f23_local13 = 0
	local f23_local14 = 0
	local f23_local15 = 0
	local f23_local16 = UIExpression.GetDStat(f23_arg1, "PlayerStatsList", "HIGHESTLEVELCOMPLETED", "personalBest") + 1
	local f23_local17 = Dvar.ui_mapname:get()
	local f23_local18 = false
	local f23_local19 = 0
	local f23_local20 = 1
	local f23_local21, f23_local22, f23_local23, f23_local24 = nil
	for Widget, f23_local33 in ipairs(CoD.AARUtility.MapList) do
		if not f23_local33.isDevLevel and not f23_local33.isRTSMap and f23_local33.doStats and not f23_local33.isTutMap then
			local f23_local28, f23_local29, f23_local30, f23_local31 = f0_local10(f23_local20, f23_local3, f23_local33)
			f23_local24 = f23_local31
			f23_local23 = f23_local30
			f23_local22 = f23_local29
			f23_local21 = f23_local28
			if f23_local33.levelNum and (tonumber(f23_local33.levelNum) <= f23_local16 or tonumber(f23_local22) and 0 < f23_local22) then
				f23_local19 = f23_local19 + 1
				f23_local11:addElementToList(f23_local21)
				if f23_local33.name == CoD.CareerOverviewMenu.MapHighlight or f23_local33.alias == CoD.CareerOverviewMenu.MapHighlight then
					f23_local18 = true
					f23_local11.verticalList:selectElementIndex(f23_local19)
				end
				f23_local20 = f23_local20 + 1
				if tonumber(f23_local22) ~= nil then
					f23_local13 = f23_local13 + f23_local22
				end
				if tonumber(f23_local23) ~= nil then
					f23_local14 = f23_local14 + f23_local23
				end
				if tonumber(f23_local24) ~= nil then
					f23_local15 = f23_local15 + f23_local24
				end
				f23_local5 = f23_local5 + 1
				f23_local0["LB_SP_" .. UIExpression.ToUpper(nil, f23_local33.alias)] = f23_local21.columns[5]
			end
			if f23_local21 ~= nil then
				f23_local21:close()
			end
		end
	end
	f23_local25 = {
		r = 1,
		g = 1,
		b = 1,
		a = 1
	}
	f23_local26 = {
		f23_local25,
		f23_local25,
		CoD.AARUtility.LocalPlayerBestStatColor,
		f23_local25,
		f23_local25
	}
	f23_local27 = false
	f23_local20 = 1
	for f23_local29, f23_local30 in ipairs(CoD.AARUtility.MapList) do
		if f23_local30.isRTSMap and f23_local30.doStats and not f23_local30.isTutMap then
			local f23_local31, f23_local34, f23_local35, f23_local36 = f0_local10(f23_local20, f23_local3, f23_local30)
			if f23_local30.rtsStart ~= nil and (tonumber(f23_local30.rtsStart) < f23_local16 or tonumber(f23_local34) and 0 < f23_local34) then
				if not f23_local27 then
					f23_local27 = true
					local Widget = LUI.UIElement.new()
					Widget:setLeftRight(true, true, 0, 0)
					Widget:setTopBottom(true, false, 0, f23_local3)
					f23_local11:addElementToList(Widget)
					local Widget = LUI.UIElement.new()
					Widget:setLeftRight(true, true, 0, 0)
					Widget:setTopBottom(true, false, 0, f23_local3)
					local f23_local39 = LUI.UIImage.new()
					f23_local39:setLeftRight(true, true, 0, 0)
					f23_local39:setTopBottom(true, false, 0, f23_local3)
					f23_local39:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
					f23_local39:setRGB(CoD.black.r, CoD.black.g, CoD.black.b)
					f23_local39:setAlpha(0.2)
					local f23_local40 = LUI.UIText.new()
					f23_local40:setLeftRight(true, true, 5, 0)
					f23_local40:setTopBottom(true, false, 0, CoD.textSize.Default)
					f23_local40:setFont(CoD.fonts.Default)
					f23_local40:setText(Engine.Localize("MENU_STRIKE_FORCE_CAPS"))
					f23_local40:setAlignment(LUI.Alignment.Left)
					f23_local40:setAlpha(0.2)
					Widget:addElement(f23_local40)
					Widget:addElement(f23_local39)
					f23_local11:addElementToList(Widget)
					f23_local5 = f23_local5 + 2
				end
				f23_local19 = f23_local19 + 1
				f23_local11:addElementToList(f23_local31)
				if f23_local30.name == CoD.CareerOverviewMenu.MapHighlight or f23_local30.alias == CoD.CareerOverviewMenu.MapHighlight then
					f23_local18 = true
					f23_local11.verticalList:selectElementIndex(f23_local19)
				end
				f23_local20 = f23_local20 + 1
				if tonumber(f23_local34) ~= nil then
					f23_local13 = f23_local13 + f23_local34
				end
				if tonumber(f23_local35) ~= nil then
					f23_local14 = f23_local14 + f23_local35
				end
				if tonumber(f23_local36) ~= nil then
					f23_local15 = f23_local15 + f23_local36
				end
				f23_local5 = f23_local5 + 1
				f23_local0["LB_SP_" .. UIExpression.ToUpper(nil, f23_local30.alias)] = f23_local31.columns[5]
			end
			if f23_local31 ~= nil then
				f23_local31:close()
			end
		end
	end
	Dvar.ui_mapname:set(f23_local17)
	Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(false, true, -f23_local3, 0)
	f23_local33 = LUI.UIImage.new()
	f23_local33:setLeftRight(true, true, 0, 0)
	f23_local33:setTopBottom(true, true, 0, 0)
	f23_local33:setRGB(1, 0.5, 0.25)
	f23_local33:setAlpha(0.2)
	Widget:addElement(f23_local33)
	f23_local28 = "--"
	f23_local29 = "--"
	if f23_local13 == 0 then
		f23_local13 = "--"
		f23_local14 = "--"
	end
	CoD.CareerOverviewMenu.DecorateRow(Widget, {
		Engine.Localize("MENU_CAREER_TOTAL_CAPS"),
		"",
		f23_local13,
		f23_local14 .. "/" .. f23_local15,
		f23_local28 .. "/" .. f23_local29
	}, {
		f23_local25,
		f23_local25,
		f23_local25,
		f23_local25,
		f23_local25
	})
	f23_local0.LB_SP_CAMPAIGN = Widget.columns[5]
	Widget:addElement(Widget)
	if not f23_local18 then
		f23_local11:processEvent({
			name = "gain_focus"
		})
	end
	if f23_local4 < f23_local5 then
		Widget:setTopBottom(true, false, 0, f23_local3 * f23_local4)
	else
		Widget:setTopBottom(true, false, 0, f23_local3 * f23_local5)
	end
	f23_arg0:addElement(Widget)
	local f23_local34 = false
	local f23_local35 = Engine.IsSignedInToDemonware(f23_arg1) == true
	local f23_local36 = UIExpression.IsSignedInToLive(f23_arg1) ~= 0
	if f23_local36 then
		local Widget = CoD.isPS3
		if Widget == 0 then
			f23_local34 = Widget
		else
			f23_local34 = UIExpression.IsContentRatingAllowed(f23_arg1) == 0
		end
	end
	if CoD.isPS3 and not f23_local36 and CoD.Menu.targetLandingMenu ~= "CareerOverviewMenu" then
		Engine.Exec(f23_arg1, "xsigninlive")
	end
	if f23_local34 or not f23_local35 or not f23_local36 then
		local Widget = LUI.UIText.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(false, true, 5, 5 + CoD.textSize.Default)
		Widget:setAlignment(LUI.Alignment.Right)
		Widget:setFont(CoD.fonts.Default)
		if f23_local34 then
			Widget:setText(Engine.Localize("XBOXLIVE_MPNOTALLOWED"))
		elseif not f23_local36 then
			if CoD.isPC then
				Widget:setText(Engine.Localize("PLATFORM_LIVE_LEADERBOARD"))
			else
				Widget:setText(Engine.Localize("XBOXLIVE_LIVE_LEADERBOARD"))
			end
		else
			Widget:setText(Engine.Localize("MENU_SERVER_NOT_AVAILABLE_TRY_LATER"))
		end
		Widget:addElement(Widget)
	end
	return f23_local0
end

CoD.CareerOverviewMenu.GetChallengesCounts = function (f24_arg0)
	local f24_local0 = 0
	local f24_local1 = 0
	local f24_local2 = UIExpression.GetAARLevelAlias(f24_arg0)
	local f24_local3 = 1
	local f24_local4 = UIExpression.TableLookup(f24_arg0, CoD.AARUtility.ChallengeTable, 1, f24_local2, 0, f24_local3, 3)
	while f24_local4 ~= nil and f24_local4 ~= "" do
		f24_local1 = f24_local1 + 1
		if UIExpression.GetChallengeComplete(f24_arg0, f24_local3 .. "") == 1 == true then
			f24_local0 = f24_local0 + 1
		end
		f24_local3 = f24_local3 + 1
		if f24_local4 == nil or f24_local4 == "" else goto basicblock_2:
		f24_local4 = UIExpression.TableLookup(f24_arg0, CoD.AARUtility.ChallengeTable, 1, f24_local2, 0, f24_local3, 3)
	end
	return f24_local0, f24_local1
end

CoD.CareerOverviewMenu.ButtonSelected = function (f25_arg0, f25_arg1)
	if f25_arg0.mapName then
		f25_arg0:dispatchEventToParent({
			name = "map_selected",
			controller = f25_arg1.controller,
			mapName = f25_arg0.mapName,
			mapAlias = f25_arg0.mapAlias,
			isRTSMap = f25_arg0.isRTSMap
		})
	end
end

CoD.CareerOverviewMenu.MapSelected = function (f26_arg0, f26_arg1)
	if f26_arg1.mapName then
		local f26_local0 = Dvar.ui_mapname:get()
		Dvar.ui_mapname:set(f26_arg1.mapName)
		CoD.CareerOverviewMenu.MapHighlight = f26_arg1.mapName
		Engine.PlaySound(CoD.CareerOverviewMenu.EnterSFX)
		f26_arg0:swapMenu("AfterActionReportMenu", f26_arg1.controller, {
			previousMenu = f26_arg0.previousMenu,
			previousMap = f26_local0,
			mapName = f26_arg1.mapName,
			mapAlias = f26_arg1.mapAlias,
			isRTSMap = f26_arg1.isRTSMap
		})
		f26_arg0:close()
	end
end

CoD.CareerOverviewMenu.DecorateRow = function (f27_arg0, f27_arg1, f27_arg2, f27_arg3, f27_arg4, f27_arg5)
	local f27_local0 = CoD.LeaderboardViewList.Font
	local f27_local1 = CoD.LeaderboardViewList.TextHeight
	f27_arg0.columns = {}
	if f27_arg3 then
		if f27_arg3.font then
			f27_local0 = f27_arg3.font
		end
		if f27_arg3.height then
			f27_local1 = f27_arg3.height
		end
	end
	if #f27_arg1 ~= #f27_arg2 then
		error("Number of text in row does not match number of colors")
	end
	local f27_local2 = {
		5,
		0,
		0,
		0,
		0
	}
	local f27_local3 = 0
	for f27_local4 = 1, #f27_arg1, 1 do
		local f27_local7 = f27_arg2[f27_local4]
		local f27_local8 = LUI.UIText.new()
		f27_local8:setLeftRight(true, false, f27_local2[f27_local4] + f27_local3, f27_local3 + CoD.CareerOverviewMenu.FullListColumnWidth[f27_local4])
		f27_local8:setTopBottom(true, false, 2, f27_local1 + 2)
		f27_local8:setFont(f27_local0)
		f27_local8:setAlignment(CoD.CareerOverviewMenu.FullListColumnAlignment[f27_local4])
		f27_local8:setRGB(f27_local7.r, f27_local7.g, f27_local7.b)
		f27_local8:setAlpha(f27_local7.a)
		f27_local8:setText(f27_arg1[f27_local4])
		f27_local3 = f27_local3 + CoD.CareerOverviewMenu.FullListColumnWidth[f27_local4]
		f27_arg0:addElement(f27_local8)
		f27_arg0.columns[f27_local4] = f27_local8
	end
	if f27_arg4 then
		local f27_local4 = LUI.UIImage.new()
		f27_local4:setLeftRight(true, true, 0, 0)
		f27_local4:setTopBottom(true, false, 1, f27_local1 + 1)
		f27_local4:setRGB(1, 1, 1)
		if f27_arg5 % 2 == 1 then
			f27_local4:setAlpha(0.05)
		else
			f27_local4:setAlpha(0.02)
		end
		f27_arg0:addElement(f27_local4)
	end
end

