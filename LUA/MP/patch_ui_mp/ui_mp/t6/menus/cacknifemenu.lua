require("T6.CamoGridButton")
CoD.CACKnife = {}
CoD.CACKnife.GridTop = 60
CoD.CACKnife.GridItemSpacing = 8
CoD.CACKnife.GridColumns = 6
CoD.CACKnife.GridItemWidth = (CoD.Menu.Width - CoD.CACKnife.GridItemSpacing * (CoD.CACKnife.GridColumns - 1)) / CoD.CACKnife.GridColumns
CoD.CACKnife.GridItemHeight = 50 + CoD.ContentGridButton.TitleHeight + 20
CoD.CACKnife.TabEvents = {
	"setup_camo_tab"
}
CoD.CACKnife.Tabs = {}
CoD.CACKnife.Tabs.CamoTab = 1
CoD.CACKnife.TabChangeHandler = function (f1_arg0, f1_arg1)
	f1_arg0:processEvent({
		name = CoD.CACKnife.TabEvents[f1_arg1.tabIndex],
		controller = f1_arg1.controller
	})
end

CoD.CACKnife.HideAllTabs = function (f2_arg0)
	if f2_arg0.camoTabContainer then
		f2_arg0.camoTabContainer:hide()
	end
end

LUI.createMenu.CACKnife = function (f3_arg0)
	local f3_local0 = CoD.Menu.New("CACKnife")
	f3_local0:addLargePopupBackground()
	f3_local0:setOwner(f3_arg0)
	local f3_local1 = Engine.GetCustomClass(f3_arg0, CoD.perController[f3_arg0].classNum)
	f3_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MPUI_PERSONALIZE_N", UIExpression.TableLookup(f3_arg0, "mp/statsTable.csv", 4, "knife_held", 3))))
	f3_local0:registerEventHandler("tab_changed", CoD.CACKnife.TabChangeHandler)
	f3_local0:registerEventHandler("setup_camo_tab", CoD.CACKnife.SetupCamoTab)
	local f3_local2 = CoD.Menu.TitleHeight
	local f3_local3 = CoD.ButtonPrompt.Height
	f3_local0.tabManager = CoD.TabManager.new(nil, nil, LUI.Alignment.Right)
	f3_local0.tabManager:setLeftRight(true, true, 0, 0)
	f3_local0.tabManager:setTopBottom(true, false, f3_local2 - f3_local3, f3_local2)
	f3_local0:addElement(f3_local0.tabManager)
	f3_local0.tabManager:addTab(Engine.Localize("MPUI_CAMO_CAPS"))
	f3_local0.tabManager:setCurrentTab()
	return f3_local0
end

CoD.CACKnife.SetupCamoTab = function (f4_arg0, f4_arg1)
	CoD.CACKnife.HideAllTabs(f4_arg0)
	f4_arg0:removeSelectButton()
	f4_arg0:removeBackButton()
	f4_arg0:addSelectButton()
	f4_arg0:addBackButton()
	if f4_arg0.camoTabContainer then
		f4_arg0.camoTabContainer:show()
		f4_arg0.camoTabContainer.m_inputDisabled = false
		return 
	else
		f4_arg0.camoTabContainer = LUI.UIElement.new()
		f4_arg0.camoTabContainer:setLeftRight(true, true, 0, 0)
		f4_arg0.camoTabContainer:setTopBottom(true, true, 0, 0)
		f4_arg0:addElement(f4_arg0.camoTabContainer)
		f4_arg0.camoTabContainer.m_ownerController = f4_arg0.m_ownerController
		f4_arg0.camoTabContainer:registerEventHandler("content_button_highlighted", CoD.CACKnife.CamoButtonHighlighted)
		f4_arg0.camoTabContainer:registerEventHandler("content_button_selected", CoD.CACKnife.CamoButtonSelected)
		f4_arg0.camoTabContainer:registerEventHandler("equip", CoD.CACKnife.CamoEquip)
		local f4_local0 = CoD.Menu.TitleHeight + 25
		f4_arg0.camoTabContainer.contentGrid = CoD.ContentGrid.new(CoD.CACKnife.GridColumns, {
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = f4_local0,
			bottom = 0
		}, CoD.CACKnife.GridItemWidth, CoD.CACKnife.GridItemHeight, CoD.CACKnife.GridItemSpacing)
		f4_arg0.camoTabContainer:addElement(f4_arg0.camoTabContainer.contentGrid)
		local f4_local1 = 4
		f4_local0 = -30 + f4_local0 + CoD.CACKnife.GridItemHeight * f4_local1 + CoD.CACKnife.GridItemSpacing * (f4_local1 - 1) + 3 + CoD.HintText.Height + 5
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, f4_local0, 0)
		f4_arg0.camoTabContainer:addElement(Widget)
		local f4_local3 = 0
		f4_arg0.camoTabContainer.camoTitle = LUI.UIText.new()
		f4_arg0.camoTabContainer.camoTitle:setLeftRight(true, false, 0, 1)
		f4_arg0.camoTabContainer.camoTitle:setTopBottom(true, false, f4_local3, f4_local3 + CoD.textSize.Big)
		f4_arg0.camoTabContainer.camoTitle:setFont(CoD.fonts.Big)
		f4_arg0.camoTabContainer.camoTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		Widget:addElement(f4_arg0.camoTabContainer.camoTitle)
		f4_local3 = f4_local3 + CoD.textSize.Big
		f4_arg0.camoTabContainer.camoDescription = LUI.UIText.new()
		f4_arg0.camoTabContainer.camoDescription:setLeftRight(true, false, 0, CoD.Menu.Width / 2 - 100)
		f4_arg0.camoTabContainer.camoDescription:setTopBottom(true, false, f4_local3, f4_local3 + CoD.textSize.Default)
		f4_arg0.camoTabContainer.camoDescription:setAlignment(LUI.Alignment.Left)
		f4_arg0.camoTabContainer.camoDescription:setFont(CoD.fonts.Default)
		f4_arg0.camoTabContainer.camoDescription:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f4_arg0.camoTabContainer.camoDescription:setAlpha(0.4)
		Widget:addElement(f4_arg0.camoTabContainer.camoDescription)
		f4_local3 = f4_local3 + CoD.textSize.Default + 25
		local f4_local4 = CoD.Menu.Width * 0.33
		f4_arg0.camoTabContainer.progressBar = CoD.ChallengeProgressBar.new({
			leftAnchor = true,
			rightAnchor = false,
			left = 0,
			right = f4_local4,
			topAnchor = true,
			bottomAnchor = true,
			top = f4_local3,
			bottom = 0
		}, f4_local4)
		Widget:addElement(f4_arg0.camoTabContainer.progressBar)
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(false, true, -(CoD.Menu.Width / 2) + 10, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget:addElement(Widget)
		local f4_local6 = 280
		local f4_local7 = f4_local6 / 2
		local f4_local8 = -70
		f4_arg0.camoTabContainer.weaponImage = LUI.UIImage.new()
		f4_arg0.camoTabContainer.weaponImage:setLeftRight(false, true, -f4_local6 + 10, 10)
		f4_arg0.camoTabContainer.weaponImage:setTopBottom(true, false, f4_local8, f4_local8 + f4_local7)
		Widget:addElement(f4_arg0.camoTabContainer.weaponImage)
		local f4_local9 = f4_local8 + f4_local7
		local f4_local10 = "Default"
		local f4_local11 = CoD.fonts[f4_local10]
		local f4_local12 = CoD.textSize[f4_local10]
		local f4_local13 = UIExpression.TableLookup(controller, "mp/statsTable.csv", 4, "knife_held", 7)
		f4_arg0.camoTabContainer.weaponDesc = LUI.UIText.new()
		f4_arg0.camoTabContainer.weaponDesc:setLeftRight(false, true, -f4_local6 + 10, 10)
		f4_arg0.camoTabContainer.weaponDesc:setTopBottom(true, false, f4_local9, f4_local9 + f4_local12)
		f4_arg0.camoTabContainer.weaponDesc:setFont(f4_local11)
		f4_arg0.camoTabContainer.weaponDesc:setAlignment(LUI.Alignment.Right)
		f4_arg0.camoTabContainer.weaponDesc:setRGB(CoD.offWhite.r, CoD.offWhite.b, CoD.offWhite.g)
		f4_arg0.camoTabContainer.weaponDesc:setText(Engine.Localize(f4_local13))
		Widget:addElement(f4_arg0.camoTabContainer.weaponDesc)
		local f4_local14 = 100
		local f4_local15 = -80
		local f4_local16 = -CoD.ButtonPrompt.Height - 22
		local f4_local17 = f4_local14 + 30
		local f4_local18 = f4_local14 * 2 + 20
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, f4_local15, f4_local15 + f4_local18)
		Widget:setTopBottom(false, true, f4_local16 - f4_local17, f4_local16)
		Widget:addElement(Widget)
		local f4_local20 = "Default"
		local f4_local21 = CoD.fonts[f4_local20]
		local f4_local22 = CoD.textSize[f4_local20]
		f4_arg0.camoTabContainer.camoPreviewTitle = LUI.UIText.new()
		f4_arg0.camoTabContainer.camoPreviewTitle:setLeftRight(true, false, 0, 300)
		f4_arg0.camoTabContainer.camoPreviewTitle:setTopBottom(true, false, -f4_local22, 0)
		f4_arg0.camoTabContainer.camoPreviewTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		f4_arg0.camoTabContainer.camoPreviewTitle:setFont(camoTitleFont)
		f4_arg0.camoTabContainer.camoPreviewTitle:setAlignment(LUI.Alignment.Left)
		f4_arg0.camoTabContainer.camoPreviewTitle:setText("")
		Widget:addElement(f4_arg0.camoTabContainer.camoPreviewTitle)
		local f4_local23 = 20
		local f4_local24 = 70
		f4_arg0.camoTabContainer.camoImage = LUI.UIImage.new()
		f4_arg0.camoTabContainer.camoImage:setLeftRight(true, true, f4_local23, -f4_local23)
		f4_arg0.camoTabContainer.camoImage:setTopBottom(true, false, 12, 12 + f4_local24)
		f4_arg0.camoTabContainer.camoImage:setAlpha(0)
		Widget:addElement(f4_arg0.camoTabContainer.camoImage)
		local f4_local25 = "Default"
		local f4_local26 = CoD.textSize[f4_local25]
		local f4_local27 = CoD.fonts[f4_local25]
		f4_arg0.camoTabContainer.xpRewardText = LUI.UIText.new()
		f4_arg0.camoTabContainer.xpRewardText:setLeftRight(true, true, 0, 0)
		f4_arg0.camoTabContainer.xpRewardText:setTopBottom(false, true, -10 - f4_local26, -10)
		f4_arg0.camoTabContainer.xpRewardText:setAlignment(LUI.Alignment.Center)
		f4_arg0.camoTabContainer.xpRewardText:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
		Widget:addElement(f4_arg0.camoTabContainer.xpRewardText)
		local f4_local28 = 32
		f4_arg0.camoTabContainer.lockImage = LUI.UIImage.new()
		f4_arg0.camoTabContainer.lockImage:setLeftRight(true, false, 5, 5 + f4_local28)
		f4_arg0.camoTabContainer.lockImage:setTopBottom(false, true, -10 - f4_local28, -10)
		f4_arg0.camoTabContainer.lockImage:setImage(RegisterMaterial(CoD.CACUtility.LockImageMaterial))
		f4_arg0.camoTabContainer.lockImage:hide()
		Widget:addElement(f4_arg0.camoTabContainer.lockImage)
		Widget:addElement(CoD.BorderDip.new(1, 1, 1, 1, 0.05, nil, f4_local18, 1))
		CoD.CACKnife.AddCamos(f4_arg0.camoTabContainer, f4_arg0.m_ownerController, CoD.perController[f4_arg0.m_ownerController].classNum)
	end
end

CoD.CACKnife.IsCamoHidden = function (f5_arg0)
	local f5_local0 = tonumber(UIExpression.TableLookup(nil, CoD.attachmentTable, 1, "camo", 0, f5_arg0, 9))
	if not f5_local0 then
		return false
	elseif not Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH) then
		return f5_local0 > 0
	else
		return f5_local0 == 2
	end
end

CoD.CACKnife.AddCamos = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = Engine.GetCustomClass(f6_arg1, f6_arg2)
	local f6_local1 = UIExpression.TableLookup(f6_arg1, "mp/statsTable.csv", 4, "knife_held", 0)
	f6_arg0.weaponItemIndex = f6_local1
	f6_arg0.weaponImage:registerAnimationState("weapon_image", {
		material = RegisterMaterial(UIExpression.TableLookup(f6_arg1, "mp/statsTable.csv", 4, "knife_held", 6))
	})
	f6_arg0.weaponImage:animateToState("weapon_image")
	local f6_local2 = Engine.GetNumWeaponOptions(CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
	local f6_local3 = f6_local0.knifecamo
	local f6_local4 = nil
	for f6_local5 = 0, f6_local2 - 1, 1 do
		local f6_local8 = false
		local f6_local9 = CoD.CACKnife.IsCamoHidden(weaponOption)
		local f6_local10 = UIExpression.GetWeaponOptionGroupIndex(nil, f6_local5, CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
		local f6_local11 = Engine.GetIsEliteLockedForItemOption(f6_local1, f6_local10)
		local f6_local12, f6_local13 = Engine.GetChallengeForItemOption(f6_local1, f6_local10)
		if f6_local12 ~= nil then
			local f6_local14 = "mp/statsmilestones" .. f6_local13 + 1 .. ".csv"
			local f6_local15 = UIExpression.GetItemName(nil, f6_local1)
			local f6_local16 = Engine.GetItemOptionChallengeValue(f6_arg1, f6_local1, f6_local10)
			local f6_local17 = UIExpression.TableLookupGetColumnValueForRow(f6_arg1, f6_local14, f6_local12, 2)
			f6_local8 = true
			if f6_local9 and f6_local16 ~= nil and f6_local16 < tonumber(f6_local17) then
				f6_local8 = false
			end
		end
		if f6_local11 then
			f6_local8 = false
		end
		if f6_local8 or f6_local5 == 0 then
			local f6_local14 = CoD.CamoGridButton.new(f6_local1, f6_local5)
			local f6_local15 = UIExpression.GetWeaponOptionGroupIndex(nil, f6_local5, CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
			f6_arg0.contentGrid:addButton(f6_local14)
			if f6_local15 == f6_local3 or not f6_local4 then
				f6_local4 = f6_local14
			end
		end
	end
	f6_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f6_arg1,
		contentIndex = f6_local3
	})
	f6_local4:processEvent({
		name = "gain_focus",
		controller = f6_arg1
	})
end

CoD.CACKnife.UpdateCamoPreview = function (f7_arg0, f7_arg1, f7_arg2)
	f7_arg0.lockImage:hide()
	f7_arg0.camoImage:hide()
	f7_arg0.camoPreviewTitle:setText("")
	f7_arg0.xpRewardText:setText("")
	local f7_local0 = 20
	f7_arg0.camoImage:setLeftRight(true, true, f7_local0, -f7_local0)
	if f7_arg1.lockImage then
		f7_arg0.camoPreviewTitle:setText(Engine.Localize("MPUI_REWARDS"))
		f7_arg0.camoImage:show()
		f7_arg0.camoImage:setImage(RegisterMaterial(f7_arg1.camoImageName))
		f7_arg0.lockImage:show()
		if f7_arg1.rewardXP then
			f7_arg0.xpRewardText:setText(Engine.Localize("RANK_XP", f7_arg1.rewardXP))
		end
	else
		f7_arg0.camoPreviewTitle:setText(Engine.Localize("MPUI_EQUIPPED"))
		local f7_local1 = CoD.perController[f7_arg2].currentlyEquippedCamoImageName
		if f7_local1 then
			if f7_local1 == "menu_theater_nodata" then
				local f7_local2 = 70
				f7_arg0.camoImage:setLeftRight(false, false, -f7_local2 / 2, f7_local2 / 2)
			end
			f7_arg0.camoImage:show()
			f7_arg0.camoImage:setImage(RegisterMaterial(f7_local1))
		end
	end
end

CoD.CACKnife.CamoButtonHighlighted = function (f8_arg0, f8_arg1)
	if f8_arg1.contentIndex then
		f8_arg0.camoTitle:setText(f8_arg1.button.nameText)
		if f8_arg1.hintText ~= nil then
			f8_arg0.camoDescription:setText(f8_arg1.hintText)
		else
			f8_arg0.camoDescription:setText("")
		end
		f8_arg0.progressBar:hide()
		if f8_arg1.button.showProgressBar and f8_arg1.button.challengeValue and f8_arg1.button.maxVal then
			f8_arg0.progressBar:show()
			f8_arg0.progressBar:update(f8_arg1.button.challengeValue, f8_arg1.button.maxVal)
		end
		CoD.CACKnife.UpdateCamoPreview(f8_arg0, f8_arg1.button, f8_arg1.controller)
	else
		f8_arg0.camoTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f8_arg0.camoDescription:setText("")
	end
end

CoD.CACKnife.CamoButtonSelected = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0.m_ownerController
	CoD.perController[f9_arg0.m_ownerController].chosenItem = UIExpression.GetWeaponOptionGroupIndex(nil, f9_arg1.contentIndex, CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
	f9_arg0:processEvent({
		name = "equip",
		controller = f9_arg0.m_ownerController,
		button = f9_arg1.button
	})
end

CoD.CACKnife.CamoEquip = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg1.controller
	local f10_local1 = CoD.perController[f10_local0].classNum
	local f10_local2 = CoD.perController[f10_local0].chosenItem
	CoD.perController[f10_local0].chosenItem = nil
	if f10_local2 then
		Engine.SetClassItem(f10_local0, f10_local1, "knifecamo", f10_local2)
		f10_arg0:dispatchEventToChildren({
			name = "update_class",
			controller = f10_local0,
			contentIndex = f10_local2
		})
		CoD.CACKnife.UpdateCamoPreview(f10_arg0, f10_arg1.button, f10_arg1.controller)
	end
	f10_arg0:dispatchEventToParent({
		name = "button_prompt_back",
		controller = f10_local0
	})
end

