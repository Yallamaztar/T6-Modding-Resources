CoD.EmblemEditorIconSelector = {}
CoD.EmblemEditorIconSelector.GridWidth = 537
CoD.EmblemEditorIconSelector.GridHeight = 545
CoD.EmblemEditorIconSelector.ContentPaneY = CoD.textSize.Big + 15
CoD.EmblemEditorIconSelector.EmblemPaneWidth = 240
CoD.EmblemEditorIconSelector.IconRowsPerPage = 5
CoD.EmblemEditorIconSelector.IconColumnsPerPage = 5
CoD.EmblemEditorIconSelector.EmblemTitleY = 420
CoD.EmblemEditorIconSelector.EmblemDescY = CoD.EmblemEditorIconSelector.EmblemTitleY + CoD.textSize.Condensed
CoD.EmblemEditorIconSelector.EmblemDescWidth = CoD.EmblemEditorIconSelector.EmblemPaneWidth
CoD.EmblemEditorIconSelector.ProgressBarTop = 545
CoD.EmblemEditorIconSelector.EmblemFilterId = 5
CoD.EmblemEditorIconSelector.GearFilterId = 2
CoD.EmblemEditorIconSelector.RanksFilterId = 10
CoD.EmblemEditorIconSelector.ToolsFilterId = 7
CoD.EmblemEditorIconSelector.TypeFilterId = 1
CoD.EmblemEditorIconSelector.EmblemTab = 1
CoD.EmblemEditorIconSelector.GearTab = 2
CoD.EmblemEditorIconSelector.RanksTab = 3
CoD.EmblemEditorIconSelector.ToolsTab = 4
CoD.EmblemEditorIconSelector.TypeTab = 5
CoD.EmblemEditorIconSelector.EMBLEMS_INVALID_ICON_ID = -1
CoD.EmblemEditorIconSelector.EMBLEMS_INVALID_ICON_INDEX = -1
LUI.createMenu.EmblemEditorIconSelector = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("EmblemEditorIconSelector")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:addTitle(Engine.Localize("MENU_EMBLEM_EDIT_EMBLEM_TITLE"), LUI.Alignment.Left)
	f1_local0:registerEventHandler("select_button_pressed", CoD.EmblemEditorIconSelector.IconSelected)
	f1_local0:registerEventHandler("button_prompt_back", CoD.EmblemEditorIconSelector.IconSelectorBackButtonPressed)
	f1_local0:registerEventHandler("hide_select_button", CoD.EmblemEditorIconSelector.HideSelectButton)
	f1_local0:registerEventHandler("show_select_button", CoD.EmblemEditorIconSelector.ShowSelectButton)
	f1_local0:registerEventHandler("set_emblem_information", CoD.EmblemEditorIconSelector.SetEmblemInformation)
	f1_local0:registerEventHandler("set_default_emblem_information", CoD.EmblemEditorIconSelector.SetDefaultIconInformation)
	f1_local0:registerEventHandler("clear_description", CoD.EmblemEditorIconSelector.ClearDescription)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	
	local grid = LUI.UIElement.new()
	grid:setLeftRight(false, true, -CoD.EmblemEditorIconSelector.GridWidth - 5, -5)
	grid:setTopBottom(true, false, CoD.EmblemEditorIconSelector.ContentPaneY, CoD.EmblemEditorIconSelector.ContentPaneY + CoD.EmblemEditorIconSelector.GridHeight)
	f1_local0:addElement(grid)
	f1_local0.grid = grid
	
	CoD.EmblemEditorIconSelector.GetTabSelected(f1_arg0, f1_local0)
	CoD.EmblemEditorIconSelector.CreateEmblemPane(f1_local0)
	CoD.EmblemEditorIconSelector.CreateTabs(f1_local0, f1_arg0)
	local f1_local2 = LUI.UIText.new()
	f1_local2:setLeftRight(true, false, 0, 0)
	f1_local2:setTopBottom(true, false, CoD.EmblemEditorIconSelector.EmblemTitleY, CoD.EmblemEditorIconSelector.EmblemTitleY + CoD.textSize.Condensed)
	f1_local2:setFont(CoD.fonts.Default)
	f1_local2:setText("")
	f1_local0.challengeName = f1_local2
	f1_local0:addElement(f1_local2)
	local f1_local3 = LUI.UIText.new()
	f1_local3:setLeftRight(true, false, 0, CoD.EmblemEditorIconSelector.EmblemDescWidth)
	f1_local3:setTopBottom(true, false, CoD.EmblemEditorIconSelector.EmblemDescY, CoD.EmblemEditorIconSelector.EmblemDescY + CoD.textSize.ExtraSmall)
	f1_local3:setFont(CoD.fonts.Default)
	f1_local3:setAlignment(LUI.Alignment.Left)
	f1_local3:setText("")
	f1_local0.challengeDesc = f1_local3
	f1_local0:addElement(f1_local3)
	local f1_local4 = 240
	f1_local0.progressBar = CoD.ChallengeProgressBar.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f1_local4,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.EmblemEditorIconSelector.ProgressBarTop,
		bottom = 0
	}, f1_local4)
	f1_local0:addElement(f1_local0.progressBar)
	f1_local0.progressBar:hide()
	return f1_local0
end

CoD.EmblemEditorIconSelector.ClearDescription = function (f2_arg0, f2_arg1)
	f2_arg0.challengeName:setText("")
	f2_arg0.challengeDesc:setText("")
	f2_arg0.progressBar:hide()
end

CoD.EmblemEditorIconSelector.SetDefaultIconInformation = function (f3_arg0, f3_arg1)
	local f3_local0 = "mp/emblemsOrBackings.csv"
	local f3_local1 = UIExpression.EmblemFilterIconID(f3_arg1.controller, 0, f3_arg1.tab.filterId, f3_arg1.tab.selectedIconIndex)
	local f3_local2 = UIExpression.TableLookup(controller, f3_local0, 0, "icon", 1, f3_local1, 4)
	local f3_local3 = tonumber(UIExpression.TableLookup(controller, f3_local0, 0, "icon", 1, f3_local1, 6))
	f3_arg0.challengeName:setText(Engine.Localize(f3_local2))
	if f3_local3 ~= 0 then
		f3_arg0.challengeDesc:setText(Engine.Localize("MENU_UNLOCKED_AT", Engine.GetRankName(f3_local3), f3_local3 + 1))
	else
		f3_arg0.challengeDesc:setText(Engine.Localize("EM_DEFAULT_EMBLEM_DESC"))
	end
	f3_arg0.progressBar:hide()
end

CoD.EmblemEditorIconSelector.SetEmblemInformation = function (f4_arg0, f4_arg1)
	if f4_arg1.challengeInfo then
		local f4_local0 = f4_arg1.challengeInfo.currVal
		local f4_local1 = tonumber(f4_arg1.challengeInfo.maxVal)
		f4_arg0.progressBar:hide()
		if f4_arg1.challengeInfo.challengeUnlocked and f4_local1 > 1 and f4_local0 < f4_local1 then
			f4_arg0.progressBar:show()
			f4_arg0.progressBar:update(f4_local0, f4_local1)
		end
		f4_arg0.challengeName:setText(f4_arg1.challengeInfo.challengeName)
		f4_arg0.challengeDesc:setText(f4_arg1.challengeInfo.challengeDesc)
	else
		f4_arg0.challengeName:setText("")
		f4_arg0.challengeDesc:setText("")
		f4_arg0.progressBar:hide()
	end
end

CoD.EmblemEditorIconSelector.ShowSelectButton = function (f5_arg0, f5_arg1)
	if f5_arg0.selectButton == nil then
		f5_arg0:addSelectButton(nil, -100)
	end
	f5_arg0.isCurrentChoiceAvailable = true
end

CoD.EmblemEditorIconSelector.HideSelectButton = function (f6_arg0, f6_arg1)
	f6_arg0:removeSelectButton()
	f6_arg0.isCurrentChoiceAvailable = false
end

CoD.EmblemEditorIconSelector.IconSelected = function (f7_arg0, f7_arg1)
	if f7_arg0.isCurrentChoiceAvailable then
		if f7_arg1.selectedIconId then
			Engine.SetEmblemIconAsOld(f7_arg1.controller, f7_arg1.selectedIconId)
		end
		f7_arg0:setPreviousMenu("EmblemEditor", {
			openEditLayerEvent = "editLayerIcon"
		})
		f7_arg0:goBack(f7_arg1.controller)
	end
end

CoD.EmblemEditorIconSelector.IconSelectorBackButtonPressed = function (f8_arg0, f8_arg1)
	if f8_arg0.selectedLayerIconID == CoD.EmblemEditorIconSelector.EMBLEMS_INVALID_ICON_ID then
		Engine.ExecNow(f8_arg1.controller, "emblemClear")
	else
		Engine.ExecNow(controller, "emblemSetSelectedLayerIconId " .. f8_arg0.selectedLayerIconID)
	end
	f8_arg0:setPreviousMenu("EmblemEditor")
	f8_arg0:goBack(f8_arg1.controller)
end

CoD.EmblemEditorIconSelector.IsValidEmblemIconForCategory = function (f9_arg0, f9_arg1, f9_arg2)
	if Engine.GetEmblemIconIndexInCategory(f9_arg0, f9_arg1, f9_arg2) ~= CoD.EmblemEditorIconSelector.EMBLEMS_INVALID_ICON_INDEX then
		return true
	else
		return false
	end
end

CoD.EmblemEditorIconSelector.GetTabSelected = function (f10_arg0, f10_arg1)
	local f10_local0 = Engine.GetSelectedLayerIconID(f10_arg0, CoD.EmblemEditor.CurrentCarouselInfo.cardIndex - 1)
	f10_arg1.selectedLayerIconID = f10_local0
	if CoD.EmblemEditorIconSelector.IsValidEmblemIconForCategory(f10_arg0, CoD.EmblemEditorIconSelector.EmblemFilterId, f10_local0) then
		f10_arg1.tabSelected = CoD.EmblemEditorIconSelector.EmblemTab
		f10_arg1.selectedIconIndex = Engine.GetEmblemIconIndexInCategory(f10_arg0, CoD.EmblemEditorIconSelector.EmblemFilterId, f10_local0)
	elseif CoD.EmblemEditorIconSelector.IsValidEmblemIconForCategory(f10_arg0, CoD.EmblemEditorIconSelector.GearFilterId, f10_local0) then
		f10_arg1.tabSelected = CoD.EmblemEditorIconSelector.GearTab
		f10_arg1.selectedIconIndex = Engine.GetEmblemIconIndexInCategory(f10_arg0, CoD.EmblemEditorIconSelector.GearFilterId, f10_local0)
	elseif CoD.EmblemEditorIconSelector.IsValidEmblemIconForCategory(f10_arg0, CoD.EmblemEditorIconSelector.RanksFilterId, f10_local0) then
		f10_arg1.tabSelected = CoD.EmblemEditorIconSelector.RanksTab
		f10_arg1.selectedIconIndex = Engine.GetEmblemIconIndexInCategory(f10_arg0, CoD.EmblemEditorIconSelector.RanksFilterId, f10_local0)
	elseif CoD.EmblemEditorIconSelector.IsValidEmblemIconForCategory(f10_arg0, CoD.EmblemEditorIconSelector.ToolsFilterId, f10_local0) then
		f10_arg1.tabSelected = CoD.EmblemEditorIconSelector.ToolsTab
		f10_arg1.selectedIconIndex = Engine.GetEmblemIconIndexInCategory(f10_arg0, CoD.EmblemEditorIconSelector.ToolsFilterId, f10_local0)
	elseif CoD.EmblemEditorIconSelector.IsValidEmblemIconForCategory(f10_arg0, CoD.EmblemEditorIconSelector.TypeFilterId, f10_local0) then
		f10_arg1.tabSelected = CoD.EmblemEditorIconSelector.TypeTab
		f10_arg1.selectedIconIndex = Engine.GetEmblemIconIndexInCategory(f10_arg0, CoD.EmblemEditorIconSelector.TypeFilterId, f10_local0)
	else
		f10_arg1.tabSelected = 1
		f10_arg1.selectedIconIndex = 0
	end
end

CoD.EmblemEditorIconSelector.CreateEmblemPane = function (f11_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.EmblemEditorIconSelector.EmblemPaneWidth)
	Widget:setTopBottom(true, false, CoD.EmblemEditorIconSelector.ContentPaneY, CoD.EmblemEditorIconSelector.ContentPaneY + CoD.EmblemEditorIconSelector.EmblemPaneWidth)
	f11_arg0:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	Widget:setupEmblem()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.1))
	Widget:addElement(Widget)
end

CoD.EmblemEditorIconSelector.CreateTabs = function (f12_arg0, f12_arg1)
	local f12_local0 = f12_arg0.grid
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, CoD.textSize.Default + 10, 0)
	f12_local0:addElement(Widget)
	local f12_local2 = CoD.MFTabManager.new(Widget, {
		left = 0,
		top = 0,
		right = 0,
		bottom = CoD.ButtonPrompt.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f12_local2:keepRightBumperAlignedToHeader(true)
	f12_local0.tabManager = f12_local2
	f12_local0:addElement(f12_local2)
	f12_local2.tabSelected = f12_arg0.tabSelected
	f12_local2.selectedIconIndex = f12_arg0.selectedIconIndex
	f12_local2:addTab(f12_arg1, "MENU_EMBLEM_SELECTOR_EMBLEMS_TAB", CoD.EmblemEditorIconSelector.PrepareEmblemsTab)
	f12_local2:addTab(f12_arg1, "MENU_EMBLEM_SELECTOR_GEAR_TAB", CoD.EmblemEditorIconSelector.PrepareGearTab)
	f12_local2:addTab(f12_arg1, "MENU_EMBLEM_SELECTOR_RANKS_TAB", CoD.EmblemEditorIconSelector.PrepareRanksTab)
	f12_local2:addTab(f12_arg1, "MENU_EMBLEM_SELECTOR_TOOLS_TAB", CoD.EmblemEditorIconSelector.PrepareToolsTab)
	f12_local2:addTab(f12_arg1, "MENU_EMBLEM_SELECTOR_TYPE_TAB", CoD.EmblemEditorIconSelector.PrepareTypeTab)
	f12_local2:refreshTab(f12_arg1)
end

CoD.EmblemEditorIconSelector.SetupGamepadButton = function (f13_arg0)
	f13_arg0.leftRepeater = LUI.UIButtonRepeater.new("left", {
		name = "gamepad_button",
		button = "left",
		down = true
	})
	f13_arg0.rightRepeater = LUI.UIButtonRepeater.new("right", {
		name = "gamepad_button",
		button = "right",
		down = true
	})
	f13_arg0:addElement(f13_arg0.leftRepeater)
	f13_arg0:addElement(f13_arg0.rightRepeater)
	f13_arg0.upRepeater = LUI.UIButtonRepeater.new("up", {
		name = "gamepad_button",
		button = "up",
		down = true
	})
	f13_arg0.downRepeater = LUI.UIButtonRepeater.new("down", {
		name = "gamepad_button",
		button = "down",
		down = true
	})
	f13_arg0:addElement(f13_arg0.upRepeater)
	f13_arg0:addElement(f13_arg0.downRepeater)
	f13_arg0.handleGamepadButton = CoD.EmblemEditorIconSelector.HandleGamepadButton
	if CoD.useMouse then
		f13_arg0:registerEventHandler("selection_changed", CoD.EmblemEditorIconSelector.SelectionChanged)
		f13_arg0:registerEventHandler("selection_clicked", CoD.EmblemEditorIconSelector.SelectionClicked)
		f13_arg0:registerEventHandler("scrollbar_update", CoD.EmblemEditorIconSelector.ScrollBarUpdate)
	end
end

CoD.EmblemEditorIconSelector.SelectionClicked = function (f14_arg0, f14_arg1)
	CoD.EmblemEditorIconSelector.SelectionChanged(f14_arg0, f14_arg1)
	f14_arg0:dispatchEventToParent({
		name = "select_button_pressed",
		controller = f14_arg1.controller
	})
end

CoD.EmblemEditorIconSelector.ScrollBarUpdate = function (f15_arg0, f15_arg1)
	local f15_local0 = f15_arg1.pivotRow
	local f15_local1 = CoD.EmblemEditorIconSelector.IconRowsPerPage
	local f15_local2 = CoD.EmblemEditorIconSelector.IconColumnsPerPage
	local f15_local3 = math.floor(f15_local1 / 2)
	if f15_arg0.totalIcons <= f15_local1 * f15_local2 then
		return 
	end
	local f15_local4, f15_local5 = nil
	f15_local4 = f15_local0 - f15_local3
	if f15_local4 < 0 then
		f15_local4 = 0
	end
	f15_local5 = f15_local4 + f15_local1
	if math.floor(f15_arg0.totalIcons / f15_local2) < f15_local5 then
		f15_local5 = math.floor(f15_arg0.totalIcons / f15_local2)
		f15_local4 = f15_local5 - f15_local1
	end
	f15_arg0.selectedIconIndex = f15_local0 * f15_local2
	CoD.EmblemEditorIconSelector.StartingRowNumber = f15_local4
	CoD.EmblemEditorIconSelector.EndingRowNumber = f15_local5
	f15_arg0:setupEmblemIcons(f15_arg1.controller, f15_arg0.selectedIconIndex, f15_arg0.filterId, f15_local4, f15_local5)
end

CoD.EmblemEditorIconSelector.GetChallengeInformation = function (f16_arg0, f16_arg1)
	local f16_local0 = Engine.GetChallengeInfoByEmblemOrBackingId(f16_arg0, f16_arg1, CoD.EMBLEM)
	if not f16_local0 then
		return f16_local0
	end
	local f16_local1 = Engine.GetPlayerStats(f16_arg0)
	local f16_local2 = f16_local1.PlayerStatsList.RANK.StatValue:get()
	local f16_local3 = f16_local1.PlayerStatsList.PLEVEL.StatValue:get()
	local f16_local4 = f16_local0[1]
	f16_local4.challengeUnlocked = nil
	f16_local4.currVal = -1
	f16_local4.maxVal = -1
	f16_local4.challengeName = ""
	f16_local4.challengeDesc = ""
	if f16_local4 ~= nil then
		local f16_local5 = f16_local4.challengeRow
		local f16_local6 = f16_local4.tableNum
		local f16_local7 = ""
		local f16_local8 = ""
		local f16_local9 = -1
		local f16_local10 = 0
		local f16_local11 = 0
		local f16_local12 = nil
		local f16_local13 = -1
		local f16_local14 = f16_local4.challengeType
		local f16_local15 = ""
		local f16_local16 = ""
		local f16_local17, f16_local18 = nil
		local f16_local19 = f16_local4.isDefault
		if f16_local5 ~= nil then
			f16_local12 = "mp/statsmilestones" .. f16_local6 + 1 .. ".csv"
			f16_local13 = UIExpression.TableLookupGetColumnValueForRow(f16_arg0, f16_local12, f16_local5, 2)
			f16_local7 = Engine.Localize(UIExpression.TableLookupGetColumnValueForRow(f16_arg0, f16_local12, f16_local5, 5))
			f16_local8 = Engine.Localize(UIExpression.TableLookupGetColumnValueForRow(f16_arg0, f16_local12, f16_local5, 5) .. "_DESC")
			f16_local9 = UIExpression.TableLookupGetColumnValueForRow(f16_arg0, f16_local12, f16_local5, 6)
			local f16_local20 = UIExpression.TableLookupGetColumnValueForRow(f16_arg0, f16_local12, f16_local5, 11)
			local f16_local21 = UIExpression.TableLookupGetColumnValueForRow(f16_arg0, f16_local12, f16_local5, 14)
			if f16_local20 ~= "" then
				f16_local10 = tonumber(f16_local20)
			end
			if f16_local21 ~= "" then
				f16_local11 = tonumber(f16_local21)
			end
		end
		local f16_local20 = f16_local4.isLocked
		local f16_local21 = false
		if f16_local14 == CoD.MILESTONE_WEAPON then
			f16_local15 = Engine.Localize(UIExpression.GetItemName(nil, f16_local4.itemIndex))
		elseif f16_local14 == CoD.MILESTONE_GROUP then
			f16_local15 = Engine.Localize("MPUI_" .. UIExpression.GetItemGroupByIndex(nil, f16_local4.itemIndex))
		elseif f16_local14 == CoD.MILESTONE_ATTACHMENTS then
			f16_local15 = Engine.Localize(UIExpression.GetAttachmentName(nil, f16_local4.itemIndex))
		elseif f16_local14 == CoD.MILESTONE_GAMEMODE then
			f16_local15 = Engine.Localize("MPUI_" .. Engine.GetGametypeName(f16_local4.itemIndex))
		elseif gamemodeName then
			f16_local15 = gamemodeName
		end
		if not f16_local19 then
			if f16_local3 < f16_local11 then
				f16_local21 = true
				f16_local8 = Engine.Localize("CLASS_PRESTIGE_UNLOCK_DESC", f16_local11)
			elseif f16_local2 < f16_local10 then
				f16_local21 = true
				f16_local8 = Engine.Localize("PERKS_UNLOCKED_AT_LV", f16_local10 + 1)
			end
		end
		f16_local18 = CoD.IsTieredChallenge(f16_arg0, f16_local12, f16_local5)
		if f16_local18 and f16_local21 then
			f16_local16 = Engine.Localize("CHALLENGE_TIER_" .. 0)
			f16_local7 = Engine.Localize(UIExpression.TableLookupGetColumnValueForRow(f16_arg0, f16_local12, f16_local5, 5), "", f16_local15, f16_local16)
		else
			f16_local16 = CoD.GetLocalizedTierText(f16_arg0, f16_local12, f16_local5)
			f16_local7 = Engine.Localize(UIExpression.TableLookupGetColumnValueForRow(f16_arg0, f16_local12, f16_local5, 5), "", f16_local15, f16_local16)
		end
		if not f16_local21 then
			local f16_local22 = UIExpression.TableLookupGetColumnValueForRow(f16_arg0, f16_local12, f16_local5, 5)
			f16_local7 = Engine.Localize(f16_local22, "", f16_local15, f16_local16)
			f16_local8 = Engine.Localize(f16_local22 .. "_DESC", f16_local13, f16_local15)
		end
		local f16_local22 = f16_local4.currentChallengeRow
		if f16_local22 and f16_local12 then
			f16_local17 = true
			local f16_local23 = UIExpression.TableLookupGetColumnValueForRow(f16_arg0, f16_local12, f16_local22, 5)
			if f16_local18 then
				f16_local16 = CoD.GetLocalizedTierText(f16_arg0, f16_local12, f16_local22)
				f16_local13 = UIExpression.TableLookupGetColumnValueForRow(f16_arg0, f16_local12, f16_local22, 2)
				f16_local7 = Engine.Localize(f16_local23, "", f16_local15, f16_local16)
				f16_local8 = Engine.Localize(f16_local23 .. "_DESC", f16_local13, f16_local15, f16_local16)
			else
				f16_local7 = Engine.Localize(f16_local23, "", f16_local15, f16_local16)
				f16_local8 = Engine.Localize(f16_local23 .. "_DESC", f16_local13, f16_local15, f16_local16)
			end
		end
		f16_local4.challengeUnlocked = f16_local17
		f16_local4.currVal = f16_local4.currChallengeStatValue
		f16_local4.maxVal = f16_local13
		f16_local4.challengeName = f16_local7
		f16_local4.challengeDesc = f16_local8
	end
	return f16_local4
end

CoD.EmblemEditorIconSelector.ShowChallengeInformation = function (f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = CoD.EmblemEditorIconSelector.GetChallengeInformation(f17_arg0, f17_arg2)
	if f17_local0 then
		f17_arg1:dispatchEventToParent({
			name = "set_emblem_information",
			controller = f17_arg0,
			challengeInfo = f17_local0
		})
	else
		f17_arg1:dispatchEventToParent({
			name = "set_default_emblem_information",
			controller = f17_arg0,
			tab = f17_arg1
		})
	end
end

CoD.EmblemEditorIconSelector.SelectedIconAction = function (f18_arg0, f18_arg1, f18_arg2)
	if f18_arg1.selectedIconId then
		Engine.SetEmblemIconAsOld(f18_arg0, f18_arg1.selectedIconId)
	end
	f18_arg1.selectedIconIndex = f18_arg2
	if f18_arg2 < f18_arg1.actualTotalIcons then
		local f18_local0 = UIExpression.EmblemFilterIconID(f18_arg0, 0, f18_arg1.filterId, f18_arg1.selectedIconIndex)
		f18_arg1.selectedIconId = f18_local0
		CoD.EmblemEditorIconSelector.ShowChallengeInformation(f18_arg0, f18_arg1, f18_local0)
		CoD.EmblemEditorIconSelector.SelectButtonVisibility(f18_arg1, f18_arg0, f18_local0)
	else
		f18_arg1.selectedIconId = nil
		Engine.ExecNow(f18_arg0, "emblemSetEmptyBoxIconId")
		f18_arg1:dispatchEventToParent({
			name = "hide_select_button",
			controller = f18_arg0
		})
		f18_arg1:dispatchEventToParent({
			name = "set_emblem_information",
			controller = f18_arg0,
			challengeInfo = nil
		})
	end
end

CoD.EmblemEditorIconSelector.SelectionChanged = function (f19_arg0, f19_arg1)
	CoD.EmblemEditorIconSelector.SelectedIconAction(f19_arg1.controller, f19_arg0, f19_arg1.iconIndex)
	CoD.EmblemEditorIconSelector.GetStartingAndEndingRowNumber(f19_arg0)
	f19_arg0:setupEmblemIcons(f19_arg1.controller, f19_arg0.selectedIconIndex, f19_arg0.filterId, CoD.EmblemEditorIconSelector.StartingRowNumber, CoD.EmblemEditorIconSelector.EndingRowNumber)
end

CoD.EmblemEditorIconSelector.SetIconIndex = function (f20_arg0, f20_arg1, f20_arg2, f20_arg3)
	local f20_local0 = nil
	if f20_arg2 == 0 and f20_arg3 == 0 then
		return 
	elseif f20_arg2 ~= 0 then
		f20_local0 = f20_arg1.selectedIconIndex + f20_arg2
	elseif f20_arg3 ~= 0 then
		f20_local0 = f20_arg1.selectedIconIndex + f20_arg3
	end
	if f20_arg1.actualTotalIcons <= f20_local0 and f20_local0 <= f20_arg1.totalIcons - 1 then
		f20_local0 = f20_arg1.actualTotalIcons - 1
	end
	if f20_arg1.totalIcons - 1 < f20_local0 or f20_local0 < 0 then
		return 
	end
	CoD.EmblemEditorIconSelector.SelectedIconAction(f20_arg0, f20_arg1, f20_local0)
end

CoD.EmblemEditorIconSelector.HandleGamepadButton = function (f21_arg0, f21_arg1)
	if LUI.UIElement.handleGamepadButton(f21_arg0, f21_arg1) == true then
		return true
	end
	local f21_local0 = 0
	local f21_local1 = 0
	if f21_arg1.down == true then
		if f21_arg1.qualifier == "mwheel" then
			if f21_arg1.button == "up" then
				CoD.EmblemEditorIconSelector.ShiftPage(f21_arg1.controller, f21_arg0, true)
			elseif f21_arg1.button == "down" then
				CoD.EmblemEditorIconSelector.ShiftPage(f21_arg1.controller, f21_arg0, false)
			end
			return 
		elseif f21_arg1.button == "primary" and f21_arg0.selectedIconIndex < f21_arg0.actualTotalIcons then
			f21_arg0:dispatchEventToParent({
				name = "select_button_pressed",
				controller = f21_arg1.controller,
				selectedIconId = f21_arg0.selectedIconId
			})
		elseif f21_arg1.button == "right" then
			f21_local0 = 1
		elseif f21_arg1.button == "left" then
			f21_local0 = -1
		elseif f21_arg1.button == "up" then
			f21_local1 = -CoD.EmblemEditorIconSelector.IconColumnsPerPage
		elseif f21_arg1.button == "down" then
			f21_local1 = CoD.EmblemEditorIconSelector.IconColumnsPerPage
		end
		Engine.PlaySound("cac_grid_nav")
	end
	CoD.EmblemEditorIconSelector.SetIconIndex(f21_arg1.controller, f21_arg0, f21_local0, f21_local1)
	CoD.EmblemEditorIconSelector.GetStartingAndEndingRowNumber(f21_arg0)
	f21_arg0:setupEmblemIcons(f21_arg1.controller, f21_arg0.selectedIconIndex, f21_arg0.filterId, CoD.EmblemEditorIconSelector.StartingRowNumber, CoD.EmblemEditorIconSelector.EndingRowNumber)
	if f21_arg0.selectedIconIndex <= f21_arg0.actualTotalIcons - 1 then
		CoD.EmblemEditorIconSelector.ShowChallengeInformation(f21_arg1.controller, f21_arg0, UIExpression.EmblemFilterIconID(f21_arg1.controller, 0, f21_arg0.filterId, f21_arg0.selectedIconIndex))
	end
end

CoD.EmblemEditorIconSelector.ShiftPage = function (f22_arg0, f22_arg1, f22_arg2)
	local f22_local0 = CoD.EmblemEditorIconSelector.IconRowsPerPage
	local f22_local1 = CoD.EmblemEditorIconSelector.IconColumnsPerPage
	local f22_local2 = CoD.EmblemEditorIconSelector.StartingRowNumber
	local f22_local3 = CoD.EmblemEditorIconSelector.EndingRowNumber
	local f22_local4, f22_local5 = nil
	if f22_arg1.totalIcons <= f22_local0 * f22_local1 then
		return 
	elseif f22_arg2 then
		f22_local4 = f22_local2 - f22_local0
		if f22_local4 < 0 then
			f22_local4 = 0
		end
		f22_local5 = f22_local4 + f22_local0
	else
		f22_local5 = f22_local3 + f22_local0
		if f22_arg1.totalIcons / f22_local1 < f22_local5 then
			f22_local5 = math.floor(f22_arg1.totalIcons / f22_local1)
		end
		f22_local4 = f22_local5 - f22_local0
	end
	f22_arg1.selectedIconIndex = f22_local4 * f22_local1
	CoD.EmblemEditorIconSelector.StartingRowNumber = f22_local4
	CoD.EmblemEditorIconSelector.EndingRowNumber = f22_local5
	f22_arg1:setupEmblemIcons(f22_arg0, f22_arg1.selectedIconIndex, f22_arg1.filterId, f22_local4, f22_local5)
end

CoD.EmblemEditorIconSelector.PrepareEmblemsTab = function (f23_arg0, f23_arg1)
	local f23_local0 = CoD.EmblemEditorIconSelector.SetupTabData(f23_arg1, f23_arg0, CoD.EmblemEditorIconSelector.EmblemFilterId)
	f23_local0.tabManager = f23_arg0
	f23_local0:registerEventHandler("close_tab", CoD.EmblemEditorIconSelector.CloseTab)
	return f23_local0
end

CoD.EmblemEditorIconSelector.PrepareGearTab = function (f24_arg0, f24_arg1)
	local f24_local0 = CoD.EmblemEditorIconSelector.SetupTabData(f24_arg1, f24_arg0, CoD.EmblemEditorIconSelector.GearFilterId)
	f24_local0.tabManager = f24_arg0
	f24_local0:registerEventHandler("close_tab", CoD.EmblemEditorIconSelector.CloseTab)
	return f24_local0
end

CoD.EmblemEditorIconSelector.PrepareToolsTab = function (f25_arg0, f25_arg1)
	local f25_local0 = CoD.EmblemEditorIconSelector.SetupTabData(f25_arg1, f25_arg0, CoD.EmblemEditorIconSelector.ToolsFilterId)
	f25_local0.tabManager = f25_arg0
	f25_local0:registerEventHandler("close_tab", CoD.EmblemEditorIconSelector.CloseTab)
	return f25_local0
end

CoD.EmblemEditorIconSelector.PrepareTypeTab = function (f26_arg0, f26_arg1)
	local f26_local0 = CoD.EmblemEditorIconSelector.SetupTabData(f26_arg1, f26_arg0, CoD.EmblemEditorIconSelector.TypeFilterId)
	f26_local0.tabManager = f26_arg0
	f26_local0:registerEventHandler("close_tab", CoD.EmblemEditorIconSelector.CloseTab)
	return f26_local0
end

CoD.EmblemEditorIconSelector.PrepareRanksTab = function (f27_arg0, f27_arg1)
	local f27_local0 = CoD.EmblemEditorIconSelector.SetupTabData(f27_arg1, f27_arg0, CoD.EmblemEditorIconSelector.RanksFilterId)
	f27_local0.tabManager = f27_arg0
	f27_local0:registerEventHandler("close_tab", CoD.EmblemEditorIconSelector.CloseTab)
	return f27_local0
end

CoD.EmblemEditorIconSelector.CloseTab = function (f28_arg0, f28_arg1)
	f28_arg0.tabManager.selectedIconIndex = 0
	f28_arg0:dispatchEventToParent({
		name = "clear_description",
		controller = f28_arg1.controller
	})
end

CoD.EmblemEditorIconSelector.GetStartingAndEndingRowNumber = function (f29_arg0)
	local f29_local0 = 5
	local f29_local1 = 5
	local f29_local2 = f29_arg0.totalIcons / f29_local0
	if CoD.EmblemEditorIconSelector.EndingRowNumber * f29_local1 <= f29_arg0.selectedIconIndex then
		CoD.EmblemEditorIconSelector.EndingRowNumber = math.max(math.floor(f29_arg0.selectedIconIndex / f29_local0 + 1), f29_local0)
		CoD.EmblemEditorIconSelector.StartingRowNumber = CoD.EmblemEditorIconSelector.EndingRowNumber - f29_local0
	elseif f29_arg0.selectedIconIndex < CoD.EmblemEditorIconSelector.StartingRowNumber * f29_local1 then
		CoD.EmblemEditorIconSelector.StartingRowNumber = CoD.EmblemEditorIconSelector.StartingRowNumber - 1
		CoD.EmblemEditorIconSelector.EndingRowNumber = CoD.EmblemEditorIconSelector.StartingRowNumber + f29_local0
	end
end

CoD.EmblemEditorIconSelector.SelectButtonVisibility = function (f30_arg0, f30_arg1, f30_arg2)
	local f30_local0 = Engine.EmblemIconIsLocked(f30_arg1, f30_arg2)
	Engine.ExecNow(f30_arg1, "emblemSetSelectedLayerIconId " .. f30_arg2)
	if f30_local0 == true then
		f30_arg0:dispatchEventToParent({
			name = "hide_select_button",
			controller = f30_arg1
		})
	else
		f30_arg0:dispatchEventToParent({
			name = "show_select_button",
			controller = f30_arg1
		})
	end
end

CoD.EmblemEditorIconSelector.SetupTabData = function (f31_arg0, f31_arg1, f31_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setFont(CoD.fonts.ExtraSmall)
	Widget.selectedIconIndex = f31_arg1.selectedIconIndex
	Widget.filterId = f31_arg2
	Widget.actualTotalIcons = UIExpression.EmblemFilterCount(f31_arg0, 0, f31_arg2)
	Widget.totalIcons = Widget.actualTotalIcons
	if Widget.actualTotalIcons % 5 ~= 0 then
		Widget.totalIcons = Widget.actualTotalIcons + 5 - Widget.actualTotalIcons % 5
	end
	local f31_local1 = 5
	CoD.EmblemEditorIconSelector.EndingRowNumber = math.min(Widget.totalIcons / f31_local1, f31_local1)
	CoD.EmblemEditorIconSelector.StartingRowNumber = math.max(CoD.EmblemEditorIconSelector.EndingRowNumber - f31_local1, 0)
	CoD.EmblemEditorIconSelector.SelectedIconAction(f31_arg0, Widget, Widget.selectedIconIndex)
	CoD.EmblemEditorIconSelector.GetStartingAndEndingRowNumber(Widget)
	Widget:setupEmblemIcons(f31_arg0, Widget.selectedIconIndex, f31_arg2, CoD.EmblemEditorIconSelector.StartingRowNumber, CoD.EmblemEditorIconSelector.EndingRowNumber)
	CoD.EmblemEditorIconSelector.SelectButtonVisibility(f31_arg1, f31_arg0, UIExpression.EmblemFilterIconID(f31_arg0, 0, f31_arg2, Widget.selectedIconIndex))
	CoD.EmblemEditorIconSelector.SetupGamepadButton(Widget)
	return Widget
end

