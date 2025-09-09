require("T6.Menus.AARUtility")
require("T6.Menus.ConfirmChangeHistory")
CoD.MissionSelect = {}
CoD.MissionSelect.CurrentSelectedMissionIndex = 1
CoD.MissionSelect.DisplayDevLevels = false
CoD.MissionSelect.CareerRecordActionSFX = "uin_career_view"
CoD.MissionSelect.Button_Map = function (f1_arg0, f1_arg1)
	f1_arg0:dispatchEventToParent({
		name = "map_selection",
		controller = f1_arg1.controller,
		button = f1_arg0
	})
end

CoD.MissionSelect.MapSelection = function (f2_arg0, f2_arg1)
	Dvar.ui_aarmapname:set(f2_arg1.button.loadName)
	Dvar.ui_mapname:set(f2_arg1.button.loadName)
	Dvar.ui_display_aar:set(false)
	CoD.MissionSelect.CurrentSelectedMissionIndex = f2_arg0.carousel:getCurrentItemIndex()
	CoD.MissionSelect.isRTSMapSelected = false
	if f2_arg1.button.isRTSMap or f2_arg1.button.isTutMap then
		CoD.MissionSelect.isRTSMapSelected = true
	end
	f2_arg0:openMenu("DifficultyMenu", f2_arg1.controller)
	f2_arg0:close()
end

CoD.MissionSelect.ToggleDevLevels = function (f3_arg0, f3_arg1)
	f3_arg0.displayDevLevels = not f3_arg0.displayDevLevels
	CoD.MissionSelect.DisplayDevLevels = f3_arg0.displayDevLevels
	local f3_local0 = f3_arg0.carousel:getCurrentItemIndex()
	f3_arg0.carousel:clearAllItems()
	CoD.MissionSelect.AddMapsToCarousel(f3_arg0)
	local f3_local1 = f3_arg0.carousel:getNumItems()
	if f3_local0 == nil or f3_local1 < f3_local0 then
		f3_arg0.carousel:scrollToItem(f3_local1, 0)
	else
		f3_arg0.carousel:scrollToItem(f3_local0, 0)
	end
end

CoD.MissionSelect.OpenCombatRecord = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.carousel
	if f4_local0:getCurrentItemIndex() == nil then
		return 
	else
		local f4_local1 = f4_local0:getCurrentItem()
		CoD.MissionSelect.CurrentSelectedMissionIndex = f4_local0:getCurrentItemIndex()
		Engine.PlaySound(CoD.MissionSelect.CareerRecordActionSFX)
		f4_arg0:openMenu("CareerOverviewMenu", f4_arg1.controller, {
			previousMenu = "MissionSelectMenu"
		})
		f4_arg0:close()
	end
end

CoD.MissionSelect.AddMapToList = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5, f5_arg6)
	local f5_local0 = f5_arg2
	if f5_arg3 == false then
		f5_local0 = Engine.Localize(f5_arg2 .. "_CAPS")
	end
	if UIExpression.DvarBool(nil, "cg_development") == 1 or f5_arg3 == false then
		local f5_local1 = CoD.MissionButton.new(nil, f5_arg1, f5_local0, f5_arg3, "map_selection")
		f5_local1.id = "MapButton." .. f5_arg2
		f5_local1.isDevLevel = f5_arg3
		f5_local1.isRTSMap = f5_arg4
		f5_local1.isTutMap = f5_arg5
		f5_local1:registerEventHandler("carousel_scroll_complete", CoD.MissionSelect.CarouselScrollComplete)
		local f5_local2 = false
		local f5_local3 = UIExpression.TableLookup(f5_arg6, CoD.AARUtility.LevelTable, 1, f5_arg1, 0)
		local f5_local4 = UIExpression.TableLookup(f5_arg6, CoD.AARUtility.LevelTable, 1, f5_arg1, 13)
		local f5_local5 = UIExpression.GetDStat(f5_arg6, "PlayerStatsList", "HIGHESTLEVELCOMPLETED", "personalBest")
		if f5_local3 and tonumber(f5_local3) and (tonumber(f5_local3) <= f5_local5 or (f5_arg4 or f5_arg5) and tonumber(f5_local4) <= f5_local5) then
			f5_local2 = true
		end
		f5_local1.levelIndex = tonumber(f5_local3)
		table.insert(f5_arg0.devMapList, f5_local1)
		if f5_arg3 == false and f5_local2 then
			table.insert(f5_arg0.mapList, f5_local1)
		end
	end
end

CoD.MissionSelect.AddMapsToCarousel = function (f6_arg0)
	if f6_arg0.displayDevLevels == true then
		for f6_local0 = 1, #f6_arg0.devMapList, 1 do
			f6_arg0.carousel:addItem(f6_arg0.devMapList[f6_local0])
		end
	else
		for f6_local0 = 1, #f6_arg0.mapList, 1 do
			f6_arg0.carousel:addItem(f6_arg0.mapList[f6_local0])
		end
	end
end

CoD.MissionSelect.OpenDevSPStory = function (f7_arg0, f7_arg1)
	f7_arg0:openMenu("DevSPStoryMenu", f7_arg1.controller)
	f7_arg0:close()
end

CoD.MissionSelect.ChangeHistory = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg0.carousel
	if f8_local0:getCurrentItemIndex() == nil then
		return 
	else
		local f8_local1 = f8_local0:getCurrentItem()
		f8_arg0:openMenu("ConfirmChangeHistory", f8_arg1.controller, f8_local1.loadName)
		f8_arg0:close()
	end
end

CoD.MissionSelect.ButtonPromptBack = function (f9_arg0, f9_arg1)
	Engine.SetDvar("ui_singlemission", 0)
	Dvar.ui_aarmapname:set("")
	CoD.Menu.ButtonPromptBack(f9_arg0, f9_arg1)
end

CoD.MissionSelect.CarouselScroll = function (f10_arg0, f10_arg1)
	if f10_arg0.lastCarouselItem ~= f10_arg0.carousel.m_currentItem then
		if f10_arg0.highestLevelComplete < f10_arg0.carousel.list.containers[f10_arg0.carousel.m_currentItem].content.levelIndex then
			if f10_arg0.changeHistory then
				f10_arg0.changeHistory:close()
				f10_arg0.changeHistory = nil
			end
		elseif not f10_arg0.changeHistory then
			local f10_local0 = CoD.ButtonPrompt.new
			local f10_local1 = "shoulderr"
			local f10_local2 = Engine.Localize("MENU_CHANGE_HISTORY")
			local f10_local3 = f10_arg0
			local f10_local4 = "button_prompt_changeHistory"
			local f10_local5, f10_local6 = false
			local f10_local7, f10_local8 = false
			f10_arg0.changeHistory = f10_local0(f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6, f10_local7, f10_local8, "D")
			f10_arg0:addRightButtonPrompt(f10_arg0.changeHistory)
		end
		f10_arg0.lastCarouselItem = f10_arg0.carousel.m_currentItem
	end
end

CoD.MissionSelect.CarouselScrollComplete = function (f11_arg0, f11_arg1)
	f11_arg0:dispatchEventToParent({
		name = "scroll_changed"
	})
end

LUI.createMenu.MissionSelectMenu = function (f12_arg0)
	local f12_local0 = CoD.Menu.New("MissionSelectMenu")
	f12_local0:addTitle(Engine.Localize("MENU_MISSION_SELECT_CAPS"), LUI.Alignment.Center)
	f12_local0:setPreviousMenu("CampaignMenu")
	f12_local0:registerEventHandler("button_prompt_back", CoD.MissionSelect.ButtonPromptBack)
	f12_local0:registerEventHandler("button_prompt_combat_record", CoD.MissionSelect.OpenCombatRecord)
	f12_local0:registerEventHandler("map_selection", CoD.MissionSelect.MapSelection)
	f12_local0:registerEventHandler("button_prompt_changeHistory", CoD.MissionSelect.ChangeHistory)
	f12_local0:registerEventHandler("scroll_changed", CoD.MissionSelect.CarouselScroll)
	f12_local0.highestLevelComplete = UIExpression.GetDStat(f12_arg0, "PlayerStatsList", "HIGHESTLEVELCOMPLETED", "StatValue")
	f12_local0:addSelectButton()
	f12_local0:addBackButton()
	local f12_local1 = CoD.ButtonPrompt.new
	local f12_local2 = "alt1"
	local f12_local3 = Engine.Localize("MENU_CAREER_RECORD")
	local f12_local4 = f12_local0
	local f12_local5 = "button_prompt_combat_record"
	local f12_local6, f12_local7 = false
	local f12_local8, f12_local9 = false
	f12_local0.combatRecordPrompt = f12_local1(f12_local2, f12_local3, f12_local4, f12_local5, f12_local6, f12_local7, f12_local8, f12_local9, "R")
	f12_local0:addLeftButtonPrompt(f12_local0.combatRecordPrompt)
	f12_local1 = 880
	f12_local2 = 200
	f12_local3 = 230
	f12_local4 = 0
	f12_local5 = 2
	f12_local7 = CoD.HorizontalCarousel.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f12_local1 / 2,
		right = f12_local1 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = CoD.Menu.TitleHeight + CoD.Menu.TitleHeight,
		bottom = f12_local3 * f12_local5 + 30 + 50 + CoD.Menu.TitleHeight
	}, f12_local2, f12_local3, f12_local4, f12_local5, 250, true)
	f12_local0.carousel = f12_local7
	f12_local0.carousel:setMouseRange(1)
	f12_local0.carousel:setHandleMouseAnim(true)
	f12_local0:addElement(f12_local7)
	f12_local0.displayDevLevels = CoD.MissionSelect.DisplayDevLevels
	f12_local0.mapList = {}
	f12_local0.devMapList = {}
	if CoD.Campaign.MissionBriefingInfo == nil then
		CoD.Campaign.UpdateMissionBriefingInfo(f12_arg0)
	end
	for f12_local11, f12_local12 in ipairs(CoD.AARUtility.MapList) do
		CoD.MissionSelect.AddMapToList(f12_local0, f12_local12.name, f12_local12.display, f12_local12.isDevLevel, f12_local12.isRTSMap, f12_local12.isTutMap, f12_arg0)
	end
	CoD.MissionSelect.AddMapsToCarousel(f12_local0)
	f12_local7:setStartItem(CoD.MissionSelect.CurrentSelectedMissionIndex)
	Engine.SetDvar("ui_singlemission", 1)
	Dvar.ui_aarmapname:set("")
	return f12_local0
end

