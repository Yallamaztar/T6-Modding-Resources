CoD.EmblemBackgroundSelector = {}
CoD.EmblemBackgroundSelector.GridWidth = 562
CoD.EmblemBackgroundSelector.GridHeight = 550
CoD.EmblemBackgroundSelector.ContentPaneY = CoD.textSize.Big + 15
CoD.EmblemBackgroundSelector.EmblemPaneWidth = 240
CoD.EmblemBackgroundSelector.BackgroundTitleY = 180
CoD.EmblemBackgroundSelector.BackgroundDescY = CoD.EmblemBackgroundSelector.BackgroundTitleY + CoD.textSize.Condensed
CoD.EmblemBackgroundSelector.BackgroundDescWidth = CoD.EmblemBackgroundSelector.EmblemPaneWidth
CoD.EmblemBackgroundSelector.ProgressBarTop = 320
CoD.EmblemBackgroundSelector.EmblemBackgroundAspectRatio = 4
CoD.EmblemBackgroundSelector.EmblemBackgroundPreviewHeight = CoD.EmblemBackgroundSelector.EmblemPaneWidth / CoD.EmblemBackgroundSelector.EmblemBackgroundAspectRatio
CoD.EmblemBackgroundSelector.EmblemBackgroundPreviewWidth = CoD.EmblemBackgroundSelector.EmblemPaneWidth
CoD.EmblemBackgroundSelector.EmblemCroppedEmblemSize = CoD.EmblemBackgroundSelector.EmblemBackgroundPreviewHeight
CoD.EmblemBackgroundSelector.BackgroundRowsPerPage = 7
CoD.EmblemBackgroundSelector.BackgroundColumnsPerPage = 3
CoD.EmblemBackgroundSelector.GeneralFilterId = 1
CoD.EmblemBackgroundSelector.WeaponsFilterId = 2
CoD.EmblemBackgroundSelector.GameModesFilterId = 3
CoD.EmblemBackgroundSelector.PrestigeFilterId = 4
CoD.EmblemBackgroundSelector.DLCFilterId = 5
CoD.EmblemBackgroundSelector.GeneralBGTab = 1
CoD.EmblemBackgroundSelector.WeaponsBGTab = 2
CoD.EmblemBackgroundSelector.GameModesBGTab = 3
CoD.EmblemBackgroundSelector.PrestigeBGTab = 4
CoD.EmblemBackgroundSelector.DLCBGTab = 5
CoD.EmblemBackgroundSelector.EMBLEMS_INVALID_BACKGROUND_ID = -1
CoD.EmblemBackgroundSelector.EMBLEMS_INVALID_BACKGROUND_INDEX = -1
LUI.createMenu.EmblemBackgroundSelector = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("EmblemBackgroundSelector")
	Engine.ExecNow(f1_arg0, "emblemBackgroundFlushResults")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:setPreviousMenu("Barracks")
	f1_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_PLAYERID_BACKGROUNDS_CAPS")))
	if CoD.CRCommon.CRMode == true then
		f1_local0:setPreviousMenu("CRCareer")
		CoD.CRCommon.CRMode = false
		CoD.perController[f1_arg0].CRFocusCurrentBg = true
		f1_local0.CRMode = true
		f1_local0.CRCurrentBgIndex = CoD.perController[f1_arg0].CRCurrentBgIndex
	end
	f1_local0:registerEventHandler("select_button_pressed", CoD.EmblemBackgroundSelector.BackgroundSelected)
	f1_local0:registerEventHandler("hide_select_button", CoD.EmblemBackgroundSelector.HideSelectButton)
	f1_local0:registerEventHandler("show_select_button", CoD.EmblemBackgroundSelector.ShowSelectButton)
	f1_local0:registerEventHandler("set_background_information", CoD.EmblemBackgroundSelector.SetBackgroundInformation)
	f1_local0:registerEventHandler("set_default_background_information", CoD.EmblemBackgroundSelector.SetDefaultBackgroundInformation)
	f1_local0:registerEventHandler("clear_description", CoD.EmblemBackgroundSelector.ClearDescription)
	f1_local0:registerEventHandler("locked_elite_camo_selected", CoD.EmblemBackgroundSelector.LockedEliteCamoSelected)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	
	local grid = LUI.UIElement.new()
	grid:setLeftRight(false, true, -5 - CoD.EmblemBackgroundSelector.GridWidth, -5)
	grid:setTopBottom(true, false, CoD.EmblemBackgroundSelector.ContentPaneY, CoD.EmblemBackgroundSelector.ContentPaneY + CoD.EmblemBackgroundSelector.GridHeight)
	f1_local0:addElement(grid)
	f1_local0.grid = grid
	
	CoD.EmblemBackgroundSelector.GetTabSelected(f1_arg0, f1_local0)
	CoD.EmblemBackgroundSelector.CreateTabs(f1_local0, f1_arg0)
	local f1_local2 = LUI.UIText.new()
	f1_local2:setLeftRight(true, false, 0, 0)
	f1_local2:setTopBottom(true, false, CoD.EmblemBackgroundSelector.BackgroundTitleY, CoD.EmblemBackgroundSelector.BackgroundTitleY + CoD.textSize.Condensed)
	f1_local2:setFont(CoD.fonts.Condensed)
	f1_local2:setText("")
	f1_local0.challengeName = f1_local2
	f1_local0:addElement(f1_local2)
	local f1_local3 = LUI.UIText.new()
	f1_local3:setLeftRight(true, false, 0, CoD.EmblemBackgroundSelector.BackgroundDescWidth)
	f1_local3:setTopBottom(true, false, CoD.EmblemBackgroundSelector.BackgroundDescY, CoD.EmblemBackgroundSelector.BackgroundDescY + CoD.textSize.ExtraSmall)
	f1_local3:setFont(CoD.fonts.ExtraSmall)
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
		top = CoD.EmblemBackgroundSelector.ProgressBarTop,
		bottom = 0
	}, f1_local4)
	f1_local0:addElement(f1_local0.progressBar)
	f1_local0.progressBar:hide()
	local f1_local5 = CoD.EmblemBackgroundSelector.ProgressBarTop + 60
	local f1_local6 = LUI.UIText.new()
	f1_local6:setLeftRight(true, false, 0, f1_local4)
	f1_local6:setTopBottom(true, false, f1_local5, f1_local5 + CoD.textSize.ExtraSmall)
	f1_local6:setFont(CoD.fonts.ExtraSmall)
	f1_local6:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	f1_local6:setAlignment(LUI.Alignment.Left)
	f1_local0.tierDescText = f1_local6
	f1_local0:addElement(f1_local0.tierDescText)
	return f1_local0
end

CoD.EmblemBackgroundSelector.ClearDescription = function (f2_arg0, f2_arg1)
	f2_arg0.challengeName:setText("")
	f2_arg0.challengeDesc:setText("")
	f2_arg0.tierDescText:setText("")
	f2_arg0.progressBar:hide()
end

CoD.EmblemBackgroundSelector.LockedEliteCamoSelected = function (f3_arg0, f3_arg1)
	if CoD.isXBOX or CoD.isPS3 then
		f3_arg0:openPopup("EliteRegistrationEmailPopup", f3_arg1.controller)
	end
end

CoD.EmblemBackgroundSelector.GetDefaultBackgroundName = function (f4_arg0, f4_arg1)
	return UIExpression.TableLookup(f4_arg0, "mp/emblemsOrBackings.csv", 0, "background", 1, f4_arg1, 4)
end

CoD.EmblemBackgroundSelector.GetBackgroundPLevel = function (f5_arg0, f5_arg1)
	return tonumber(UIExpression.TableLookup(f5_arg0, "mp/emblemsOrBackings.csv", 0, "background", 1, f5_arg1, 7))
end

CoD.EmblemBackgroundSelector.SetDefaultBackgroundInformation = function (f6_arg0, f6_arg1)
	local f6_local0 = Engine.GetEmblemFilterBGId(f6_arg1.controller, f6_arg1.tab.filterId, f6_arg1.tab.selectedBackgroundIndex)
	local f6_local1 = CoD.EmblemBackgroundSelector.GetDefaultBackgroundName(f6_arg1.controller, f6_local0)
	local f6_local2 = CoD.EmblemBackgroundSelector.GetBackgroundPLevel(f6_arg1.controller, f6_local0)
	f6_arg0.challengeName:setText(Engine.Localize(f6_local1))
	if CoD.CACUtility.IsBackingMTX(f6_local0) then
		f6_arg0.challengeDesc:setText(Engine.Localize("MPUI_MTX_PURCHASE_HINT", Engine.Localize("MPUI_" .. CoD.CACUtility.GetBackingMTXName(f6_local0))))
	elseif f6_local2 > 0 then
		local f6_local3 = Engine.Localize("CLASS_PRESTIGE_UNLOCK_DESC", f6_local2)
		if f6_local2 == tonumber(CoD.MAX_PRESTIGE) then
			f6_local3 = Engine.Localize("EM_BACK_PRESIGE_MASTER_UNLOCK")
		end
		f6_arg0.challengeDesc:setText(f6_local3)
	else
		f6_arg0.challengeDesc:setText(Engine.Localize("EM_DEFAULT_BACKGROUND_DESC"))
	end
	f6_arg0.tierDescText:hide()
	f6_arg0.progressBar:hide()
end

CoD.EmblemBackgroundSelector.SetBackgroundInformation = function (f7_arg0, f7_arg1)
	if f7_arg1.challengeInfo then
		local f7_local0 = f7_arg1.challengeInfo.currVal
		local f7_local1 = tonumber(f7_arg1.challengeInfo.maxVal)
		f7_arg0.tierDescText:hide()
		f7_arg0.progressBar:hide()
		if f7_arg1.challengeInfo.challengeUnlocked and f7_local1 > 1 and f7_local0 < f7_local1 then
			f7_arg0.progressBar:show()
			f7_arg0.progressBar:update(f7_local0, f7_local1)
		end
		f7_arg0.challengeName:setText(f7_arg1.challengeInfo.challengeName)
		f7_arg0.challengeDesc:setText(f7_arg1.challengeInfo.challengeDesc)
		local f7_local2 = f7_arg1.challengeInfo.isTieredChallenge
		local f7_local3 = f7_arg1.challengeInfo.currentChallengeTier
		local f7_local4 = f7_arg1.challengeInfo.maxChallengeTier
		if f7_local2 and f7_local3 and f7_local4 and f7_local3 ~= -1 and f7_local4 > 0 then
			f7_arg0.tierDescText:show()
			f7_arg0.tierDescText:setText(Engine.Localize("MENU_CHALLENGE_TIER_DESC", f7_local3 + 1, f7_local4 + 1, f7_local4 + 1))
		end
	else
		f7_arg0.challengeName:setText("")
		f7_arg0.challengeDesc:setText("")
		f7_arg0.progressBar:hide()
	end
end

CoD.EmblemBackgroundSelector.ShowSelectButton = function (f8_arg0, f8_arg1)
	if f8_arg0.selectButton == nil then
		f8_arg0:addSelectButton(f8_arg1.promptString, -100)
	elseif f8_arg0.selectButton.labelText ~= f8_arg1.promptString then
		f8_arg0.selectButton:close()
		f8_arg0.selectButton = nil
		f8_arg0:addSelectButton(f8_arg1.promptString, -100)
	end
	f8_arg0.isCurrentChoiceAvailable = true
	f8_arg0.customEvent = f8_arg1.customEvent
end

CoD.EmblemBackgroundSelector.HideSelectButton = function (f9_arg0, f9_arg1)
	f9_arg0:removeSelectButton()
	f9_arg0.isCurrentChoiceAvailable = false
end

CoD.EmblemBackgroundSelector.BackgroundSelected = function (f10_arg0, f10_arg1)
	if f10_arg0.isCurrentChoiceAvailable then
		if f10_arg1.selectedBackgroundId then
			Engine.SetEmblemBackgroundAsOld(f10_arg1.controller, f10_arg1.selectedBackgroundId)
		end
		if f10_arg0.customEvent then
			f10_arg0:processEvent({
				name = f10_arg0.customEvent,
				controller = f10_arg1.controller
			})
			return 
		elseif CoD.CACUtility.IsBackingMTX(f10_arg1.selectedBackgroundId) then
			local f10_local0 = CoD.CACUtility.GetBackingMTXName(f10_arg1.selectedBackgroundId)
			if not Engine.HasMTX(f10_arg1.controller, f10_local0) then
				if UIExpression.IsGuest(f10_arg1.controller) == 1 then
					local f10_local1 = f10_arg0:openPopup("Error", controller)
					f10_local1:setMessage(Engine.Localize("XBOXLIVE_NOGUESTACCOUNTS"))
				elseif CoD.isPS3 then
					f10_arg0:openPopup("MTXPurchase", f10_arg1.controller, {
						mtxName = f10_local0,
						openingMenuName = "emblem"
					})
				else
					Engine.PurchaseMTX(f10_arg1.controller, f10_local0, "emblem")
				end
				return 
			end
		end
		if f10_arg0.CRMode then
			CoD.CRCareer.SetBackgroundID(f10_arg1.controller, f10_arg1.selectedBackgroundId, f10_arg0.CRCurrentBgIndex)
		else
			Engine.Exec(f10_arg1.controller, "uploadstats")
			Engine.ExecNow(f10_arg1.controller, "emblemsetprofile")
		end
		f10_arg0:goBack(f10_arg1.controller)
	end
end

CoD.EmblemBackgroundSelector.IsValidEmblemBackgroundForCategory = function (f11_arg0, f11_arg1, f11_arg2)
	if Engine.GetEmblemBackgroundIndexInCategory(f11_arg0, f11_arg1, f11_arg2) ~= CoD.EmblemBackgroundSelector.EMBLEMS_INVALID_BACKGROUND_INDEX then
		return true
	else
		return false
	end
end

CoD.EmblemBackgroundSelector.GetTabSelected = function (f12_arg0, f12_arg1)
	f12_arg1.tabSelected = 1
	f12_arg1.selectedBackgroundIndex = 0
	local f12_local0 = Engine.GetEmblemBackgroundId()
	f12_arg1.backgroundId = f12_local0
	if CoD.EmblemBackgroundSelector.IsValidEmblemBackgroundForCategory(f12_arg0, CoD.EmblemBackgroundSelector.GeneralFilterId, f12_local0) then
		f12_arg1.tabSelected = CoD.EmblemBackgroundSelector.GeneralBGTab
		f12_arg1.selectedBackgroundIndex = Engine.GetEmblemBackgroundIndexInCategory(f12_arg0, CoD.EmblemBackgroundSelector.GeneralFilterId, f12_local0)
	elseif CoD.EmblemBackgroundSelector.IsValidEmblemBackgroundForCategory(f12_arg0, CoD.EmblemBackgroundSelector.WeaponsFilterId, f12_local0) then
		f12_arg1.tabSelected = CoD.EmblemBackgroundSelector.WeaponsBGTab
		f12_arg1.selectedBackgroundIndex = Engine.GetEmblemBackgroundIndexInCategory(f12_arg0, CoD.EmblemBackgroundSelector.WeaponsFilterId, f12_local0)
	elseif CoD.EmblemBackgroundSelector.IsValidEmblemBackgroundForCategory(f12_arg0, CoD.EmblemBackgroundSelector.GameModesFilterId, f12_local0) then
		f12_arg1.tabSelected = CoD.EmblemBackgroundSelector.GameModesBGTab
		f12_arg1.selectedBackgroundIndex = Engine.GetEmblemBackgroundIndexInCategory(f12_arg0, CoD.EmblemBackgroundSelector.GameModesFilterId, f12_local0)
	elseif CoD.EmblemBackgroundSelector.IsValidEmblemBackgroundForCategory(f12_arg0, CoD.EmblemBackgroundSelector.PrestigeFilterId, f12_local0) then
		f12_arg1.tabSelected = CoD.EmblemBackgroundSelector.PrestigeBGTab
		f12_arg1.selectedBackgroundIndex = Engine.GetEmblemBackgroundIndexInCategory(f12_arg0, CoD.EmblemBackgroundSelector.PrestigeFilterId, f12_local0)
	elseif CoD.EmblemBackgroundSelector.IsValidEmblemBackgroundForCategory(f12_arg0, CoD.EmblemBackgroundSelector.DLCFilterId, f12_local0) then
		f12_arg1.tabSelected = CoD.EmblemBackgroundSelector.DLCBGTab
		f12_arg1.selectedBackgroundIndex = Engine.GetEmblemBackgroundIndexInCategory(f12_arg0, CoD.EmblemBackgroundSelector.DLCFilterId, f12_local0)
	else
		f12_arg1.tabSelected = 1
		f12_arg1.selectedBackgroundIndex = 0
	end
end

CoD.EmblemBackgroundSelector.CreateTabs = function (f13_arg0, f13_arg1)
	local f13_local0 = f13_arg0.grid
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, CoD.textSize.Default + 10, 0)
	f13_local0:addElement(Widget)
	local f13_local2 = CoD.MFTabManager.new(Widget, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.ButtonPrompt.Height
	})
	f13_local2:keepRightBumperAlignedToHeader(true)
	f13_local0.tabManager = f13_local2
	f13_local0:addElement(f13_local2)
	f13_local2.tabSelected = f13_arg0.tabSelected
	f13_local2.selectedBackgroundIndex = f13_arg0.selectedBackgroundIndex
	f13_local2:addTab(f13_arg1, "MENU_EMBLEM_BACKGROUND_GENERALTAB", CoD.EmblemBackgroundSelector.PrepareGeneralBGTab)
	f13_local2:addTab(f13_arg1, "MENU_EMBLEM_BACKGROUND_WEAPONSTAB", CoD.EmblemBackgroundSelector.PrepareWeaponsBGTab)
	f13_local2:addTab(f13_arg1, "MENU_EMBLEM_BACKGROUND_GAMEMODESTAB", CoD.EmblemBackgroundSelector.PrepareGameModesBGTab)
	f13_local2:addTab(f13_arg1, "MENU_EMBLEM_BACKGROUND_PRESTIGETAB", CoD.EmblemBackgroundSelector.PreparePrestigeBGTab)
	f13_local2:addTab(f13_arg1, "MPUI_MAP_CATEGORY_DLC_CAPS", CoD.EmblemBackgroundSelector.PrepareDLCBGTab)
	f13_local2:refreshTab(f13_arg1)
	f13_local2:registerEventHandler("mtx_changed", CoD.EmblemBackgroundSelector.HandleMTXChanged)
end

CoD.EmblemBackgroundSelector.SetupGamepadButton = function (f14_arg0)
	f14_arg0.leftRepeater = LUI.UIButtonRepeater.new("left", {
		name = "gamepad_button",
		button = "left",
		down = true
	})
	f14_arg0.rightRepeater = LUI.UIButtonRepeater.new("right", {
		name = "gamepad_button",
		button = "right",
		down = true
	})
	f14_arg0:addElement(f14_arg0.leftRepeater)
	f14_arg0:addElement(f14_arg0.rightRepeater)
	f14_arg0.upRepeater = LUI.UIButtonRepeater.new("up", {
		name = "gamepad_button",
		button = "up",
		down = true
	})
	f14_arg0.downRepeater = LUI.UIButtonRepeater.new("down", {
		name = "gamepad_button",
		button = "down",
		down = true
	})
	f14_arg0:addElement(f14_arg0.upRepeater)
	f14_arg0:addElement(f14_arg0.downRepeater)
	f14_arg0.handleGamepadButton = CoD.EmblemBackgroundSelector.HandleGamepadButton
	if CoD.useMouse then
		f14_arg0:registerEventHandler("selection_changed", CoD.EmblemBackgroundSelector.SelectionChanged)
		f14_arg0:registerEventHandler("selection_clicked", CoD.EmblemBackgroundSelector.SelectionClicked)
		f14_arg0:registerEventHandler("scrollbar_update", CoD.EmblemBackgroundSelector.ScrollBarUpdate)
	end
end

CoD.EmblemBackgroundSelector.SelectionClicked = function (f15_arg0, f15_arg1)
	CoD.EmblemBackgroundSelector.SelectionChanged(f15_arg0, f15_arg1)
	local f15_local0 = nil
	if f15_arg0.selectedBackgroundIndex <= f15_arg0.actualTotalBackgrounds - 1 then
		f15_local0 = Engine.GetEmblemFilterBGId(f15_arg1.controller, f15_arg0.filterId, f15_arg0.selectedBackgroundIndex)
	end
	f15_arg0:dispatchEventToParent({
		name = "select_button_pressed",
		controller = f15_arg1.controller,
		selectedBackgroundId = f15_local0
	})
end

CoD.EmblemBackgroundSelector.ScrollBarUpdate = function (f16_arg0, f16_arg1)
	local f16_local0 = f16_arg1.pivotRow
	local f16_local1 = CoD.EmblemBackgroundSelector.BackgroundRowsPerPage
	local f16_local2 = CoD.EmblemBackgroundSelector.BackgroundColumnsPerPage
	local f16_local3 = math.floor(f16_local1 / 2)
	if f16_arg0.totalBackgrounds <= f16_local1 * f16_local2 then
		return 
	end
	local f16_local4, f16_local5 = nil
	f16_local4 = f16_local0 - f16_local3
	if f16_local4 < 0 then
		f16_local4 = 0
	end
	f16_local5 = f16_local4 + f16_local1
	if math.floor(f16_arg0.totalBackgrounds / f16_local2) < f16_local5 then
		f16_local5 = math.floor(f16_arg0.totalBackgrounds / f16_local2)
		f16_local4 = f16_local5 - f16_local1
	end
	f16_arg0.selectedBackgroundIndex = f16_local0 * f16_local2
	CoD.EmblemBackgroundSelector.StartingRowNumber = f16_local4
	CoD.EmblemBackgroundSelector.EndingRowNumber = f16_local5
	f16_arg0:setupEmblemBackgrounds(f16_arg1.controller, f16_arg0.selectedBackgroundIndex, f16_arg0.filterId, f16_local4, f16_local5)
end

CoD.EmblemBackgroundSelector.GetChallengeInformation = function (f17_arg0, f17_arg1)
	local f17_local0 = Engine.GetChallengeInfoByEmblemOrBackingId(f17_arg0, f17_arg1, CoD.BACKING)
	if not f17_local0 then
		return f17_local0
	end
	local f17_local1 = Engine.GetPlayerStats(f17_arg0)
	local f17_local2 = f17_local1.PlayerStatsList.RANK.StatValue:get()
	local f17_local3 = f17_local1.PlayerStatsList.PLEVEL.StatValue:get()
	local f17_local4 = f17_local0[1]
	f17_local4.challengeUnlocked = nil
	f17_local4.currVal = -1
	f17_local4.maxVal = -1
	f17_local4.challengeName = ""
	f17_local4.challengeDesc = ""
	if f17_local4 ~= nil then
		local f17_local5 = f17_local4.challengeRow
		local f17_local6 = f17_local4.tableNum
		local f17_local7 = ""
		local f17_local8 = ""
		local f17_local9 = -1
		local f17_local10 = 0
		local f17_local11 = 0
		local f17_local12 = nil
		local f17_local13 = -1
		local f17_local14 = f17_local4.challengeType
		local f17_local15 = ""
		local f17_local16 = ""
		local f17_local17, f17_local18 = nil
		local f17_local19 = f17_local4.isDefault
		local f17_local20 = nil
		local f17_local21 = -1
		local f17_local22 = nil
		if f17_local5 ~= nil then
			f17_local12 = "mp/statsmilestones" .. f17_local6 + 1 .. ".csv"
			f17_local13 = UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local5, 2)
			f17_local22 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local5, 1))
			f17_local7 = Engine.Localize(UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local5, 5))
			f17_local8 = Engine.Localize(UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local5, 5) .. "_DESC")
			f17_local9 = UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local5, 6)
			f17_local20 = UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local5, 22)
			local f17_local23 = UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local5, 11)
			local f17_local24 = UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local5, 14)
			if f17_local23 ~= "" then
				f17_local10 = tonumber(f17_local23)
			end
			if f17_local24 ~= "" then
				f17_local11 = tonumber(f17_local24)
			end
		end
		local f17_local23 = f17_local4.isLocked
		local f17_local24 = false
		if f17_local14 == CoD.MILESTONE_WEAPON then
			f17_local15 = Engine.Localize(UIExpression.GetItemName(nil, f17_local4.itemIndex))
		elseif f17_local14 == CoD.MILESTONE_GROUP then
			f17_local15 = Engine.Localize("MPUI_" .. UIExpression.GetItemGroupByIndex(nil, f17_local4.itemIndex))
		elseif f17_local14 == CoD.MILESTONE_ATTACHMENTS then
			f17_local15 = Engine.Localize(UIExpression.GetAttachmentName(nil, f17_local4.itemIndex))
		elseif f17_local14 == CoD.MILESTONE_GAMEMODE then
			f17_local15 = Engine.Localize("MPUI_" .. Engine.GetGametypeName(f17_local4.itemIndex))
		elseif gamemodeName then
			f17_local15 = gamemodeName
		end
		if not f17_local19 then
			if f17_local3 < f17_local11 then
				f17_local24 = true
				f17_local8 = Engine.Localize("CLASS_PRESTIGE_UNLOCK_DESC", f17_local11)
			elseif f17_local2 < f17_local10 then
				f17_local24 = true
				f17_local8 = Engine.Localize("PERKS_UNLOCKED_AT_LV", f17_local10 + 1)
			end
		end
		f17_local18 = CoD.IsTieredChallenge(f17_arg0, f17_local12, f17_local5)
		if f17_local18 and f17_local24 then
			f17_local16 = Engine.Localize("CHALLENGE_TIER_" .. 0)
			f17_local7 = Engine.Localize(UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local5, 5), "", f17_local15, f17_local16)
		else
			f17_local16 = CoD.GetLocalizedTierText(f17_arg0, f17_local12, f17_local5)
			f17_local7 = Engine.Localize(UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local5, 5), "", f17_local15, f17_local16)
		end
		if not f17_local24 then
			local f17_local25 = UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local5, 5)
			f17_local7 = Engine.Localize(f17_local25, "", f17_local15, f17_local16)
			f17_local8 = Engine.Localize(f17_local25 .. "_DESC", f17_local13, f17_local15)
		end
		local f17_local25 = f17_local4.currentChallengeRow
		if f17_local25 and f17_local12 then
			f17_local17 = true
			local f17_local26 = UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local25, 5)
			if f17_local18 then
				f17_local16 = CoD.GetLocalizedTierText(f17_arg0, f17_local12, f17_local25)
				f17_local21 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local25, 1))
				f17_local13 = UIExpression.TableLookupGetColumnValueForRow(f17_arg0, f17_local12, f17_local25, 2)
				f17_local7 = Engine.Localize(f17_local26, "", f17_local15, f17_local16)
				f17_local8 = Engine.Localize(f17_local26 .. "_DESC", f17_local13, f17_local15, f17_local16)
			else
				f17_local7 = Engine.Localize(f17_local26, "", f17_local15, f17_local16)
				f17_local8 = Engine.Localize(f17_local26 .. "_DESC", f17_local13, f17_local15, f17_local16)
			end
		end
		f17_local4.challengeUnlocked = f17_local17
		f17_local4.currVal = f17_local4.currChallengeStatValue
		f17_local4.maxVal = f17_local13
		f17_local4.challengeName = f17_local7
		f17_local4.challengeDesc = f17_local8
		f17_local4.doubleXpGroups = f17_local20
		f17_local4.maxChallengeTier = f17_local22
		f17_local4.isTieredChallenge = f17_local18
		f17_local4.currentChallengeTier = f17_local21
	end
	return f17_local4
end

CoD.EmblemBackgroundSelector.ShowChallengeInformation = function (f18_arg0, f18_arg1, f18_arg2)
	local f18_local0 = CoD.EmblemBackgroundSelector.GetChallengeInformation(f18_arg0, f18_arg2)
	if f18_local0 then
		f18_arg1:dispatchEventToParent({
			name = "set_background_information",
			controller = f18_arg0,
			challengeInfo = f18_local0
		})
	else
		f18_arg1:dispatchEventToParent({
			name = "set_default_background_information",
			controller = f18_arg0,
			tab = f18_arg1
		})
	end
end

CoD.EmblemBackgroundSelector.SelectedBackgroundAction = function (f19_arg0, f19_arg1, f19_arg2)
	if f19_arg1.selectedBackgroundId then
		Engine.SetEmblemBackgroundAsOld(f19_arg0, f19_arg1.selectedBackgroundId)
	end
	f19_arg1.selectedBackgroundIndex = f19_arg2
	if f19_arg2 < f19_arg1.actualTotalBackgrounds then
		local f19_local0 = Engine.GetEmblemFilterBGId(f19_arg0, f19_arg1.filterId, f19_arg1.selectedBackgroundIndex)
		f19_arg1.selectedBackgroundId = f19_local0
		CoD.EmblemBackgroundSelector.SelectButtonVisibility(f19_arg1, f19_arg0, f19_local0)
		CoD.EmblemBackgroundSelector.ShowChallengeInformation(f19_arg0, f19_arg1, f19_local0)
	else
		f19_arg1.selectedBackgroundId = nil
		f19_arg1:dispatchEventToParent({
			name = "set_background_information",
			controller = f19_arg0,
			challengeInfo = nil
		})
	end
end

CoD.EmblemBackgroundSelector.SelectionChanged = function (f20_arg0, f20_arg1)
	CoD.EmblemBackgroundSelector.SelectedBackgroundAction(f20_arg1.controller, f20_arg0, f20_arg1.iconIndex)
	CoD.EmblemBackgroundSelector.GetStartingAndEndingRowNumber(f20_arg0)
	f20_arg0:setupEmblemBackgrounds(f20_arg1.controller, f20_arg0.selectedBackgroundIndex, f20_arg0.filterId, CoD.EmblemBackgroundSelector.StartingRowNumber, CoD.EmblemBackgroundSelector.EndingRowNumber)
end

CoD.EmblemBackgroundSelector.SetBackgroundIndex = function (f21_arg0, f21_arg1, f21_arg2, f21_arg3)
	local f21_local0 = nil
	if f21_arg2 == 0 and f21_arg3 == 0 then
		return 
	elseif f21_arg2 ~= 0 then
		f21_local0 = f21_arg1.selectedBackgroundIndex + f21_arg2
	elseif f21_arg3 ~= 0 then
		f21_local0 = f21_arg1.selectedBackgroundIndex + f21_arg3
	end
	if f21_arg1.actualTotalBackgrounds <= f21_local0 and f21_local0 <= f21_arg1.totalBackgrounds - 1 then
		f21_local0 = f21_arg1.actualTotalBackgrounds - 1
	end
	if f21_arg1.totalBackgrounds - 1 < f21_local0 or f21_local0 < 0 then
		return 
	end
	CoD.EmblemBackgroundSelector.SelectedBackgroundAction(f21_arg0, f21_arg1, f21_local0)
end

CoD.EmblemBackgroundSelector.HandleGamepadButton = function (f22_arg0, f22_arg1)
	if LUI.UIElement.handleGamepadButton(f22_arg0, f22_arg1) == true then
		return true
	end
	local f22_local0 = 0
	local f22_local1 = 0
	local f22_local2 = nil
	if f22_arg0.selectedBackgroundIndex <= f22_arg0.actualTotalBackgrounds - 1 then
		f22_local2 = Engine.GetEmblemFilterBGId(f22_arg1.controller, f22_arg0.filterId, f22_arg0.selectedBackgroundIndex)
		CoD.EmblemBackgroundSelector.ShowChallengeInformation(f22_arg1.controller, f22_arg0, f22_local2)
	end
	if f22_arg1.down == true then
		if f22_arg1.qualifier == "mwheel" then
			if f22_arg1.button == "up" then
				CoD.EmblemBackgroundSelector.ShiftPage(f22_arg1.controller, f22_arg0, true)
			elseif f22_arg1.button == "down" then
				CoD.EmblemBackgroundSelector.ShiftPage(f22_arg1.controller, f22_arg0, false)
			end
			return 
		elseif f22_arg1.button == "primary" and f22_arg0.selectedBackgroundIndex < f22_arg0.actualTotalBackgrounds then
			f22_arg0:dispatchEventToParent({
				name = "select_button_pressed",
				controller = f22_arg1.controller,
				selectedBackgroundId = f22_local2
			})
		elseif f22_arg1.button == "right" then
			f22_local0 = 1
		elseif f22_arg1.button == "left" then
			f22_local0 = -1
		elseif f22_arg1.button == "up" then
			f22_local1 = -CoD.EmblemBackgroundSelector.BackgroundColumnsPerPage
		elseif f22_arg1.button == "down" then
			f22_local1 = CoD.EmblemBackgroundSelector.BackgroundColumnsPerPage
		end
		Engine.PlaySound("cac_grid_nav")
	end
	CoD.EmblemBackgroundSelector.SetBackgroundIndex(f22_arg1.controller, f22_arg0, f22_local0, f22_local1)
	CoD.EmblemBackgroundSelector.GetStartingAndEndingRowNumber(f22_arg0)
	f22_arg0:setupEmblemBackgrounds(f22_arg1.controller, f22_arg0.selectedBackgroundIndex, f22_arg0.filterId, CoD.EmblemBackgroundSelector.StartingRowNumber, CoD.EmblemBackgroundSelector.EndingRowNumber)
end

CoD.EmblemBackgroundSelector.ShiftPage = function (f23_arg0, f23_arg1, f23_arg2)
	local f23_local0 = CoD.EmblemBackgroundSelector.BackgroundRowsPerPage
	local f23_local1 = CoD.EmblemBackgroundSelector.BackgroundColumnsPerPage
	local f23_local2 = CoD.EmblemBackgroundSelector.StartingRowNumber
	local f23_local3 = CoD.EmblemBackgroundSelector.EndingRowNumber
	local f23_local4, f23_local5 = nil
	if f23_arg1.totalBackgrounds <= f23_local0 * f23_local1 then
		return 
	elseif f23_arg2 then
		f23_local4 = f23_local2 - f23_local0
		if f23_local4 < 0 then
			f23_local4 = 0
		end
		f23_local5 = f23_local4 + f23_local0
	else
		f23_local5 = f23_local3 + f23_local0
		if f23_arg1.totalBackgrounds / f23_local1 < f23_local5 then
			f23_local5 = math.floor(f23_arg1.totalBackgrounds / f23_local1)
		end
		f23_local4 = f23_local5 - f23_local0
	end
	f23_arg1.selectedBackgroundIndex = f23_local4 * f23_local1
	CoD.EmblemBackgroundSelector.StartingRowNumber = f23_local4
	CoD.EmblemBackgroundSelector.EndingRowNumber = f23_local5
	f23_arg1:setupEmblemBackgrounds(f23_arg0, f23_arg1.selectedBackgroundIndex, f23_arg1.filterId, f23_local4, f23_local5)
end

CoD.EmblemBackgroundSelector.PrepareGeneralBGTab = function (f24_arg0, f24_arg1)
	local f24_local0 = CoD.EmblemBackgroundSelector.SetupTabData(f24_arg1, f24_arg0, CoD.EmblemBackgroundSelector.GeneralFilterId)
	f24_local0.tabManager = f24_arg0
	f24_local0:registerEventHandler("close_tab", CoD.EmblemBackgroundSelector.CloseTab)
	return f24_local0
end

CoD.EmblemBackgroundSelector.PrepareWeaponsBGTab = function (f25_arg0, f25_arg1)
	local f25_local0 = CoD.EmblemBackgroundSelector.SetupTabData(f25_arg1, f25_arg0, CoD.EmblemBackgroundSelector.WeaponsFilterId)
	f25_local0.tabManager = f25_arg0
	f25_local0:registerEventHandler("close_tab", CoD.EmblemBackgroundSelector.CloseTab)
	return f25_local0
end

CoD.EmblemBackgroundSelector.PrepareGameModesBGTab = function (f26_arg0, f26_arg1)
	local f26_local0 = CoD.EmblemBackgroundSelector.SetupTabData(f26_arg1, f26_arg0, CoD.EmblemBackgroundSelector.GameModesFilterId)
	f26_local0.tabManager = f26_arg0
	f26_local0:registerEventHandler("close_tab", CoD.EmblemBackgroundSelector.CloseTab)
	return f26_local0
end

CoD.EmblemBackgroundSelector.PreparePrestigeBGTab = function (f27_arg0, f27_arg1)
	local f27_local0 = CoD.EmblemBackgroundSelector.SetupTabData(f27_arg1, f27_arg0, CoD.EmblemBackgroundSelector.PrestigeFilterId)
	f27_local0.tabManager = f27_arg0
	f27_local0:registerEventHandler("close_tab", CoD.EmblemBackgroundSelector.CloseTab)
	return f27_local0
end

CoD.EmblemBackgroundSelector.PrepareDLCBGTab = function (f28_arg0, f28_arg1)
	local f28_local0 = CoD.EmblemBackgroundSelector.SetupTabData(f28_arg1, f28_arg0, CoD.EmblemBackgroundSelector.DLCFilterId)
	f28_local0.tabManager = f28_arg0
	Engine.SetStartCheckoutTimestampUTC()
	Engine.SendDLCMenusViewedRecordEvent(f28_arg1, CoD.DLC_BACKINGS_MENU_VIEWED, "emblem")
	f28_local0:registerEventHandler("close_tab", CoD.EmblemBackgroundSelector.CloseTab)
	return f28_local0
end

CoD.EmblemBackgroundSelector.CloseTab = function (f29_arg0, f29_arg1)
	f29_arg0.tabManager.selectedBackgroundIndex = 0
	f29_arg0:dispatchEventToParent({
		name = "clear_description",
		controller = f29_arg1.controller
	})
end

CoD.EmblemBackgroundSelector.DoubleXpGroupCustomAction = function (f30_arg0, f30_arg1, f30_arg2)
	local f30_local0 = CoD.EmblemBackgroundSelector.GetChallengeInformation(f30_arg1, f30_arg2)
	if f30_local0 and f30_local0.doubleXpGroups and f30_local0.doubleXpGroups ~= "" and string.find(f30_local0.doubleXpGroups, "elite1") and Engine.IsEliteAvailable() then
		return "locked_elite_camo_selected"
	else

	end
end

CoD.EmblemBackgroundSelector.SelectButtonVisibility = function (f31_arg0, f31_arg1, f31_arg2)
	local f31_local0 = UIExpression.EmblemBackgroundIsLocked(f31_arg1, f31_arg2) == 1
	local f31_local1 = CoD.EmblemBackgroundSelector.DoubleXpGroupCustomAction(f31_arg0, f31_arg1, f31_arg2)
	if f31_local0 and f31_local1 then
		f31_arg0:dispatchEventToParent({
			name = "show_select_button",
			controller = f31_arg1,
			customEvent = f31_local1
		})
	elseif f31_local0 then
		f31_arg0:dispatchEventToParent({
			name = "hide_select_button",
			controller = f31_arg1
		})
	else
		local f31_local2 = Engine.Localize("MENU_SELECT")
		if CoD.CACUtility.IsBackingMTX(f31_arg2) and not Engine.HasMTX(f31_arg1, CoD.CACUtility.GetBackingMTXName(f31_arg2)) then
			f31_local2 = Engine.Localize("MENU_PURCHASE")
		end
		f31_arg0:dispatchEventToParent({
			name = "show_select_button",
			controller = f31_arg1,
			promptString = f31_local2
		})
		Engine.ExecNow(f31_arg1, "emblemSelectBackground " .. f31_arg2)
	end
end

CoD.EmblemBackgroundSelector.GetStartingAndEndingRowNumber = function (f32_arg0)
	local f32_local0 = CoD.EmblemBackgroundSelector.BackgroundRowsPerPage
	local f32_local1 = CoD.EmblemBackgroundSelector.BackgroundColumnsPerPage
	local f32_local2 = f32_arg0.totalBackgrounds / f32_local0
	if CoD.EmblemBackgroundSelector.EndingRowNumber * f32_local1 <= f32_arg0.selectedBackgroundIndex then
		CoD.EmblemBackgroundSelector.EndingRowNumber = math.max(math.floor(f32_arg0.selectedBackgroundIndex / f32_local1 + 1), f32_local0)
		CoD.EmblemBackgroundSelector.StartingRowNumber = CoD.EmblemBackgroundSelector.EndingRowNumber - f32_local0
	elseif f32_arg0.selectedBackgroundIndex < CoD.EmblemBackgroundSelector.StartingRowNumber * f32_local1 then
		CoD.EmblemBackgroundSelector.StartingRowNumber = CoD.EmblemBackgroundSelector.StartingRowNumber - 1
		CoD.EmblemBackgroundSelector.EndingRowNumber = CoD.EmblemBackgroundSelector.StartingRowNumber + f32_local0
	end
end

CoD.EmblemBackgroundSelector.SetupTabData = function (f33_arg0, f33_arg1, f33_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setFont(CoD.fonts.ExtraSmall)
	Widget.selectedBackgroundIndex = f33_arg1.selectedBackgroundIndex
	Widget.filterId = f33_arg2
	Widget.actualTotalBackgrounds = Engine.GetEmblemFilterBGCount(f33_arg0, f33_arg2)
	Widget.totalBackgrounds = Widget.actualTotalBackgrounds
	local f33_local1 = CoD.EmblemBackgroundSelector.BackgroundRowsPerPage
	local f33_local2 = CoD.EmblemBackgroundSelector.BackgroundColumnsPerPage
	if Widget.actualTotalBackgrounds % f33_local2 ~= 0 then
		Widget.totalBackgrounds = Widget.actualTotalBackgrounds + f33_local2 - Widget.actualTotalBackgrounds % f33_local2
	end
	CoD.EmblemBackgroundSelector.EndingRowNumber = math.min(Widget.totalBackgrounds / f33_local2, f33_local1)
	CoD.EmblemBackgroundSelector.StartingRowNumber = math.max(CoD.EmblemBackgroundSelector.EndingRowNumber - f33_local1, 0)
	CoD.EmblemBackgroundSelector.SelectedBackgroundAction(f33_arg0, Widget, Widget.selectedBackgroundIndex)
	CoD.EmblemBackgroundSelector.GetStartingAndEndingRowNumber(Widget)
	Widget:setupEmblemBackgrounds(f33_arg0, Widget.selectedBackgroundIndex, f33_arg2, CoD.EmblemBackgroundSelector.StartingRowNumber, CoD.EmblemBackgroundSelector.EndingRowNumber)
	CoD.EmblemBackgroundSelector.SelectButtonVisibility(f33_arg1, f33_arg0, Engine.GetEmblemFilterBGId(f33_arg0, f33_arg2, Widget.selectedBackgroundIndex))
	CoD.EmblemBackgroundSelector.SetupGamepadButton(Widget)
	return Widget
end

CoD.EmblemBackgroundSelector.HandleMTXChanged = function (f34_arg0, f34_arg1)
	if f34_arg1.controller ~= f34_arg0.m_ownerController then
		return 
	else
		CoD.EmblemBackgroundSelector.PrepareDLCBGTab(f34_arg0, f34_arg1.controller)
	end
end

