require("T6.CamoGridButton")
CoD.CACCamo = {}
CoD.CACCamo.camoPreviewLineMaterialName = "menu_mp_cac_attach_line"
CoD.CACCamo.GridTop = 60
CoD.CACCamo.GridItemSpacing = 8
CoD.CACCamo.CamoGridColumns = 6
CoD.CACCamo.CamoGridItemWidth = (CoD.Menu.Width - CoD.CACCamo.GridItemSpacing * (CoD.CACCamo.CamoGridColumns - 1)) / CoD.CACCamo.CamoGridColumns
CoD.CACCamo.CamoGridItemHeight = 50 + CoD.ContentGridButton.TitleHeight + 20
CoD.CACCamo.TagAndEmblemGridColumns = 3
CoD.CACCamo.TagAndEmblemGridItemWidth = (CoD.Menu.Width - CoD.CACCamo.GridItemSpacing * (CoD.CACCamo.TagAndEmblemGridColumns - 1)) / CoD.CACCamo.TagAndEmblemGridColumns
CoD.CACCamo.TagAndEmblemGridItemHeight = 96 + CoD.ContentGridButton.TitleHeight + 10
CoD.CACCamo.TabEvents = {
	camo_tab = "setup_camo_tab",
	tag_and_emblem_tab = "setup_tag_and_emblem_tab",
	dlc_tab = "setup_dlc_tab",
	dlc2_tab = "setup_dlc2_tab"
}
CoD.CACCamo.Tabs = {}
CoD.CACCamo.Tabs.CamoTab = 1
CoD.CACCamo.Tabs.TagAndEmblemTab = 2
CoD.CACCamo.Tabs.DlcTab = 3
CoD.CACCamo.Tabs.Dlc2Tab = 4
CoD.CACCamo.TabChangeHandler = function (f1_arg0, f1_arg1)
	if f1_arg1.currentTabName and CoD.CACCamo.TabEvents[f1_arg1.currentTabName] then
		f1_arg0:processEvent({
			name = CoD.CACCamo.TabEvents[f1_arg1.currentTabName],
			controller = f1_arg1.controller
		})
	end
end

CoD.CACCamo.CloseAllTabs = function (f2_arg0)
	CoD.CACCamo.WeaponOptionToGainFocus = nil
	f2_arg0:closeSelectButton()
	f2_arg0:removeBackButton()
	if f2_arg0.camoTabContainer then
		f2_arg0.camoTabContainer:close()
		f2_arg0.camoTabContainer = nil
	end
	if f2_arg0.tagAndEmblemTabContainer then
		f2_arg0.tagAndEmblemTabContainer:close()
		f2_arg0.tagAndEmblemTabContainer = nil
	end
	if f2_arg0.dlcCamoTabContainer then
		f2_arg0.dlcCamoTabContainer:close()
		f2_arg0.dlcCamoTabContainer = nil
	end
	if f2_arg0.dlc2CamoTabContainer then
		f2_arg0.dlc2CamoTabContainer:close()
		f2_arg0.dlc2CamoTabContainer = nil
	end
end

CoD.CACCamo.RemoveSelectButton = function (f3_arg0, f3_arg1)
	f3_arg0:closeSelectButton()
end

CoD.CACCamo.OpenEliteMenu = function (f4_arg0, f4_arg1)
	if CoD.isXBOX or CoD.isPS3 then
		f4_arg0:openPopup("EliteRegistrationEmailPopup", f4_arg1.controller)
	end
end

LUI.createMenu.CACCamo = function (f5_arg0)
	local f5_local0 = CoD.Menu.New("CACCamo")
	f5_local0:addLargePopupBackground()
	f5_local0:setOwner(f5_arg0)
	local f5_local1 = CoD.perController[f5_arg0].knifePersonalization
	local f5_local2 = CoD.perController[f5_arg0].weaponSlot
	local f5_local3 = Engine.GetCustomClass(f5_arg0, CoD.perController[f5_arg0].classNum)
	local f5_local4 = Engine.Localize(UIExpression.GetItemName(nil, f5_local3[f5_local2]))
	if f5_local1 then
		f5_local4 = UIExpression.TableLookup(f5_arg0, "mp/statsTable.csv", 4, "knife_held", 3)
	end
	local f5_local5 = Engine.Localize("MPUI_PERSONALIZE_N", f5_local4)
	local f5_local6 = nil
	if CoD.LANGUAGE_ENGLISH ~= Dvar.loc_language:get() then
		f5_local0:addTitle(UIExpression.ToUpper(nil, f5_local5), nil, 30, "Big")
	else
		f5_local0:addTitle(UIExpression.ToUpper(nil, f5_local5))
	end
	f5_local0:registerEventHandler("tab_changed", CoD.CACCamo.TabChangeHandler)
	f5_local0:registerEventHandler("setup_camo_tab", CoD.CACCamo.SetupCamoTab)
	f5_local0:registerEventHandler("setup_tag_and_emblem_tab", CoD.CACCamo.SetupTagAndEmblemTab)
	f5_local0:registerEventHandler("setup_dlc_tab", CoD.CACCamo.SetupDlcTab)
	f5_local0:registerEventHandler("setup_dlc2_tab", CoD.CACCamo.SetupDlc2Tab)
	f5_local0:registerEventHandler("remove_select_button", CoD.CACCamo.RemoveSelectButton)
	f5_local0:registerEventHandler("locked_elite_camo_selected", CoD.CACCamo.OpenEliteMenu)
	f5_local0:registerEventHandler("mtx_changed", CoD.CACCamo.HandleMTXChanged)
	f5_local0:registerEventHandler("open_mtx_purchase", CoD.CACCamo.OpenMTXPurchase)
	f5_local0:registerEventHandler("open_no_guest_mtx", CoD.CACCamo.OpenNoGuestMTX)
	local f5_local7 = CoD.Menu.TitleHeight
	local f5_local8 = CoD.ButtonPrompt.Height
	f5_local0.tabManager = CoD.TabManager.new(nil, nil, LUI.Alignment.Right)
	f5_local0.tabManager:setLeftRight(true, true, 0, 0)
	f5_local0.tabManager:setTopBottom(true, false, f5_local7 - f5_local8, f5_local7)
	f5_local0:addElement(f5_local0.tabManager)
	f5_local0.tabManager:addTab(Engine.Localize("MPUI_CAMO_CAPS"), "camo_tab")
	if not f5_local1 then
		f5_local0.tabManager:addTab(Engine.Localize("MPUI_EMBLEM_AND_TAG_CAPS"), "tag_and_emblem_tab")
	end
	f5_local0.tabManager:addTab(Engine.Localize("MPUI_MAP_CATEGORY_DLC_CAPS"), "dlc_tab")
	if CoD.CACCamo.ShouldDisplayDlc2Tab(f5_arg0) then
		f5_local0.tabManager:addTab(Engine.Localize("MPUI_DLC2_CAPS"), "dlc2_tab")
	end
	f5_local0.tabManager:setCurrentTab()
	return f5_local0
end

CoD.CACCamo.SetupCamoTab = function (f6_arg0, f6_arg1)
	CoD.CACCamo.CloseAllTabs(f6_arg0)
	f6_arg0:addBackButton()
	f6_arg0.camoTabContainer = LUI.UIElement.new()
	f6_arg0.camoTabContainer:setLeftRight(true, true, 0, 0)
	f6_arg0.camoTabContainer:setTopBottom(true, true, 0, 0)
	f6_arg0:addElement(f6_arg0.camoTabContainer)
	f6_arg0.camoTabContainer.m_ownerController = f6_arg0.m_ownerController
	f6_arg0.camoTabContainer:registerEventHandler("content_button_highlighted", CoD.CACCamo.CamoButtonHighlighted)
	f6_arg0.camoTabContainer:registerEventHandler("content_button_selected", CoD.CACCamo.CamoButtonSelected)
	f6_arg0.camoTabContainer:registerEventHandler("equip", CoD.CACCamo.CamoEquip)
	CoD.CACCamo.SetupCamoTabContainer(f6_arg0.camoTabContainer, f6_arg0.m_ownerController)
end

CoD.CACCamo.SetupDlcTab = function (f7_arg0, f7_arg1)
	CoD.CACCamo.CloseAllTabs(f7_arg0)
	f7_arg0:addBackButton()
	f7_arg0.dlcCamoTabContainer = LUI.UIElement.new()
	f7_arg0.dlcCamoTabContainer:setLeftRight(true, true, 0, 0)
	f7_arg0.dlcCamoTabContainer:setTopBottom(true, true, 0, 0)
	f7_arg0:addElement(f7_arg0.dlcCamoTabContainer)
	f7_arg0.dlcCamoTabContainer.m_ownerController = f7_arg0.m_ownerController
	f7_arg0.dlcCamoTabContainer:registerEventHandler("content_button_highlighted", CoD.CACCamo.CamoButtonHighlighted)
	f7_arg0.dlcCamoTabContainer:registerEventHandler("content_button_selected", CoD.CACCamo.CamoButtonSelected)
	f7_arg0.dlcCamoTabContainer:registerEventHandler("equip", CoD.CACCamo.CamoEquip)
	CoD.CACCamo.SetupCamoTabContainer(f7_arg0.dlcCamoTabContainer, f7_arg0.m_ownerController, "dlc")
	Engine.SetStartCheckoutTimestampUTC()
	Engine.SendDLCMenusViewedRecordEvent(f7_arg1.controller, CoD.DLC_CAMO_MENU_VIEWED, "camo")
end

CoD.CACCamo.ShouldDisplayDlc2Tab = function (f8_arg0)
	local f8_local0 = Engine.GetNumWeaponOptions(CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
	local f8_local1 = false
	for f8_local2 = 0, f8_local0 - 1, 1 do
		local f8_local5 = false
		local f8_local6 = UIExpression.GetWeaponOptionGroupIndex(nil, f8_local2, CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
		local f8_local7 = CoD.CACUtility.IsWeaponOptionMTX(f8_local6)
		if not f8_local1 and (tonumber(UIExpression.TableLookup(nil, "mp/attachmenttable.csv", 0, f8_local6, 5)) or 0) > 0 and CoD.CACUtility.ShouldDisplayWeaponOptionMTX(f8_arg0, f8_local6) then
			f8_local1 = true
			break
		end
	end
	return f8_local1
end

CoD.CACCamo.SetupDlc2Tab = function (f9_arg0, f9_arg1)
	CoD.CACCamo.CloseAllTabs(f9_arg0)
	f9_arg0:addBackButton()
	f9_arg0.dlc2CamoTabContainer = LUI.UIElement.new()
	f9_arg0.dlc2CamoTabContainer:setLeftRight(true, true, 0, 0)
	f9_arg0.dlc2CamoTabContainer:setTopBottom(true, true, 0, 0)
	f9_arg0:addElement(f9_arg0.dlc2CamoTabContainer)
	f9_arg0.dlc2CamoTabContainer.m_ownerController = f9_arg0.m_ownerController
	f9_arg0.dlc2CamoTabContainer:registerEventHandler("content_button_highlighted", CoD.CACCamo.CamoButtonHighlighted)
	f9_arg0.dlc2CamoTabContainer:registerEventHandler("content_button_selected", CoD.CACCamo.CamoButtonSelected)
	f9_arg0.dlc2CamoTabContainer:registerEventHandler("equip", CoD.CACCamo.CamoEquip)
	CoD.CACCamo.SetupCamoTabContainer(f9_arg0.dlc2CamoTabContainer, f9_arg0.m_ownerController, "dlc2")
	Engine.SetStartCheckoutTimestampUTC()
	Engine.SendDLCMenusViewedRecordEvent(f9_arg1.controller, CoD.DLC_CAMO_MENU_VIEWED, "camo")
end

CoD.CACCamo.SetupCamoTabContainer = function (f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = CoD.perController[f10_arg1].knifePersonalization
	local f10_local1 = CoD.Menu.TitleHeight + 10
	f10_arg0.contentGrid = CoD.ContentGrid.new(CoD.CACCamo.CamoGridColumns, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f10_local1,
		bottom = 0
	}, CoD.CACCamo.CamoGridItemWidth, CoD.CACCamo.CamoGridItemHeight, CoD.CACCamo.GridItemSpacing)
	f10_arg0:addElement(f10_arg0.contentGrid)
	local f10_local2 = 4
	local f10_local3 = 0
	if CoD.LANGUAGE_JAPANESE == Dvar.loc_language:get() or CoD.LANGUAGE_FULLJAPANESE == Dvar.loc_language:get() then
		f10_local3 = 30
	end
	f10_local1 = -30 + f10_local1 + CoD.CACCamo.CamoGridItemHeight * f10_local2 + CoD.CACCamo.GridItemSpacing * (f10_local2 - 1) + 3 + CoD.HintText.Height + 5 + f10_local3
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f10_local1, 0)
	f10_arg0:addElement(Widget)
	local f10_local5 = 0
	f10_arg0.camoTitle = LUI.UIText.new()
	f10_arg0.camoTitle:setLeftRight(true, false, 0, 1)
	f10_arg0.camoTitle:setTopBottom(true, false, f10_local5, f10_local5 + CoD.textSize.Big)
	f10_arg0.camoTitle:setFont(CoD.fonts.Big)
	f10_arg0.camoTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(f10_arg0.camoTitle)
	f10_local5 = f10_local5 + CoD.textSize.Big
	f10_arg0.camoDescription = LUI.UIText.new()
	f10_arg0.camoDescription:setLeftRight(true, false, 0, CoD.Menu.Width / 2 - 100)
	f10_arg0.camoDescription:setTopBottom(true, false, f10_local5, f10_local5 + CoD.textSize.Default)
	f10_arg0.camoDescription:setAlignment(LUI.Alignment.Left)
	f10_arg0.camoDescription:setFont(CoD.fonts.Default)
	f10_arg0.camoDescription:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f10_arg0.camoDescription:setAlpha(0.4)
	Widget:addElement(f10_arg0.camoDescription)
	f10_local5 = f10_local5 + CoD.textSize.Default + 25
	local f10_local6 = CoD.Menu.Width * 0.33
	f10_arg0.progressBar = CoD.ChallengeProgressBar.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f10_local6,
		topAnchor = true,
		bottomAnchor = true,
		top = f10_local5,
		bottom = 0
	}, f10_local6)
	Widget:addElement(f10_arg0.progressBar)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -(CoD.Menu.Width / 2) + 10, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local f10_local8 = 280
	local f10_local9 = f10_local8 / 2
	local f10_local10 = -70
	f10_arg0.weaponImage = LUI.UIImage.new()
	f10_arg0.weaponImage:setLeftRight(false, true, -f10_local8 + 10, 10)
	f10_arg0.weaponImage:setTopBottom(true, false, f10_local10, f10_local10 + f10_local9)
	Widget:addElement(f10_arg0.weaponImage)
	local f10_local11 = 100
	local f10_local12 = -80
	local f10_local13 = -CoD.ButtonPrompt.Height - 22
	local f10_local14 = f10_local11 + 30
	local f10_local15 = f10_local11 * 2 + 20
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f10_local12, f10_local12 + f10_local15)
	Widget:setTopBottom(false, true, f10_local13 - f10_local14, f10_local13)
	Widget:addElement(Widget)
	local f10_local17 = "Default"
	local f10_local18 = CoD.fonts[f10_local17]
	local f10_local19 = CoD.textSize[f10_local17]
	f10_arg0.camoPreviewTitle = LUI.UIText.new()
	f10_arg0.camoPreviewTitle:setLeftRight(true, false, 0, 300)
	f10_arg0.camoPreviewTitle:setTopBottom(true, false, -f10_local19, 0)
	f10_arg0.camoPreviewTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f10_arg0.camoPreviewTitle:setFont(camoTitleFont)
	f10_arg0.camoPreviewTitle:setAlignment(LUI.Alignment.Left)
	f10_arg0.camoPreviewTitle:setText("")
	Widget:addElement(f10_arg0.camoPreviewTitle)
	local f10_local20 = 20
	local f10_local21 = 70
	f10_arg0.camoImage = LUI.UIImage.new()
	f10_arg0.camoImage:setLeftRight(true, true, f10_local20, -f10_local20)
	f10_arg0.camoImage:setTopBottom(true, false, 12, 12 + f10_local21)
	f10_arg0.camoImage:setAlpha(0)
	Widget:addElement(f10_arg0.camoImage)
	local f10_local22 = "Default"
	local f10_local23 = CoD.textSize[f10_local22]
	local f10_local24 = CoD.fonts[f10_local22]
	f10_arg0.xpRewardText = LUI.UIText.new()
	f10_arg0.xpRewardText:setLeftRight(true, true, 0, 0)
	f10_arg0.xpRewardText:setTopBottom(false, true, -10 - f10_local23, -10)
	f10_arg0.xpRewardText:setAlignment(LUI.Alignment.Center)
	f10_arg0.xpRewardText:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
	Widget:addElement(f10_arg0.xpRewardText)
	local f10_local25 = 32
	f10_arg0.lockImage = LUI.UIImage.new()
	f10_arg0.lockImage:setLeftRight(true, false, 5, 5 + f10_local25)
	f10_arg0.lockImage:setTopBottom(false, true, -10 - f10_local25, -10)
	f10_arg0.lockImage:setImage(RegisterMaterial(CoD.CACUtility.LockImageMaterial))
	f10_arg0.lockImage:hide()
	Widget:addElement(f10_arg0.lockImage)
	Widget:addElement(CoD.BorderDip.new(1, 1, 1, 1, 0.05, nil, f10_local15, 1))
	CoD.CACCamo.AddCamos(f10_arg0, f10_arg1, CoD.perController[f10_arg1].classNum, CoD.perController[f10_arg1].weaponSlot, f10_arg2)
end

CoD.CACCamo.IsCamoHidden = function (f11_arg0)
	if string.find(UIExpression.TableLookup(nil, CoD.attachmentTable, 1, "camo", 0, f11_arg0, 4), "elite") and not Engine.IsEliteAvailable() then
		return true
	else
		local f11_local0 = tonumber(UIExpression.TableLookup(nil, CoD.attachmentTable, 1, "camo", 0, f11_arg0, 9))
		if not f11_local0 then
			return false
		elseif not Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH) then
			return f11_local0 > 0
		else
			return f11_local0 == 2
		end
	end
end

CoD.CACCamo.AddCamos = function (f12_arg0, f12_arg1, f12_arg2, f12_arg3, f12_arg4)
	local f12_local0 = CoD.perController[f12_arg1].knifePersonalization
	local f12_local1 = Engine.GetCustomClass(f12_arg1, f12_arg2)
	local f12_local2, f12_local3, f12_local4 = nil
	if f12_local0 then
		f12_local2 = UIExpression.TableLookup(f12_arg1, "mp/statsTable.csv", 4, "knife_held", 0)
		f12_local3 = UIExpression.TableLookup(f12_arg1, "mp/statsTable.csv", 4, "knife_held", 6)
		f12_local4 = f12_local1.knifecamo
	else
		f12_local2 = f12_local1[f12_arg3]
		f12_local3 = UIExpression.GetItemImage(nil, f12_local2) .. "_big"
		f12_local4 = f12_local1[CoD.perController[f12_arg1].weaponSlot .. "camo"]
	end
	f12_arg0.weaponImage:registerAnimationState("weapon_image", {
		material = RegisterMaterial(f12_local3)
	})
	f12_arg0.weaponImage:animateToState("weapon_image")
	local f12_local5 = Engine.GetNumWeaponOptions(CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
	local f12_local6 = nil
	local f12_local7 = {}
	if f12_arg4 == "dlc2" then
		local f12_local8 = {}
		for f12_local9 = 0, f12_local5 - 1, 1 do
			local f12_local12 = tonumber(UIExpression.TableLookup(nil, "mp/attachmenttable.csv", 0, UIExpression.GetWeaponOptionGroupIndex(nil, f12_local9, CoD.CACUtility.WEAPONOPTION_GROUP_CAMO), 5))
			if f12_local12 then
				table.insert(f12_local8, {
					index = f12_local9,
					sortKey = f12_local12
				})
			end
		end
		table.sort(f12_local8, function (f27_arg0, f27_arg1)
			return f27_arg0.sortKey < f27_arg1.sortKey
		end)
		for f12_local13, f12_local14 in ipairs(f12_local8) do
			table.insert(f12_local7, f12_local14.index)
		end
		table.insert(f12_local7, 1, 0)
	else
		for f12_local8 = 0, f12_local5 - 1, 1 do
			table.insert(f12_local7, f12_local8)
		end
	end
	for f12_local11, f12_local13 in ipairs(f12_local7) do
		local f12_local14 = false
		local f12_local12 = UIExpression.GetWeaponOptionGroupIndex(nil, f12_local13, CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
		local f12_local21 = CoD.CACUtility.IsWeaponOptionMTX(f12_local12)
		local f12_local22, f12_local23 = Engine.GetChallengeForItemOption(f12_local2, f12_local12)
		if not f12_local21 and f12_local22 ~= nil then
			local f12_local15 = CoD.CACCamo.IsCamoHidden(f12_local12)
			local f12_local16 = "mp/statsmilestones" .. f12_local23 + 1 .. ".csv"
			local f12_local17 = UIExpression.GetItemName(nil, f12_local2)
			local f12_local18 = Engine.GetItemOptionChallengeValue(f12_arg1, f12_local2, f12_local12)
			local f12_local19 = UIExpression.TableLookupGetColumnValueForRow(f12_arg1, f12_local16, f12_local22, 2)
			local f12_local20 = UIExpression.TableLookupGetColumnValueForRow(f12_arg1, f12_local16, f12_local22, 4)
			f12_local14 = true
			if f12_local15 and Engine.GetItemOptionLocked(f12_arg1, f12_local2, f12_local12) then
				f12_local14 = false
			end
			if f12_local20 == "digital_unlock" and UIExpression.IsSignedInToLive(f12_arg1) == 0 then
				f12_local14 = false
			end
			if f12_arg4 == "dlc" and f12_local20 ~= "digital_unlock" then
				f12_local14 = false
			end
			if not f12_arg4 and f12_local20 == "digital_unlock" then
				f12_local14 = false
			end
			if f12_arg4 == "dlc2" then
				f12_local14 = false
			end
		elseif f12_local21 then
			f12_local14 = true
			if not f12_arg4 then
				f12_local14 = false
			else
				local f12_local15 = tonumber(UIExpression.TableLookup(nil, "mp/attachmenttable.csv", 0, f12_local12, 5)) or 0
				f12_local14 = CoD.CACUtility.ShouldDisplayWeaponOptionMTX(f12_arg1, f12_local12)
				if not (f12_arg4 ~= "dlc" or f12_local15 <= 0) or f12_arg4 == "dlc2" and f12_local15 == 0 then
					f12_local14 = false
				end
			end
		end
		if f12_local14 or f12_local13 == 0 then
			local f12_local15 = CoD.CamoGridButton.new(f12_local2, f12_local13)
			local f12_local16 = UIExpression.GetWeaponOptionGroupIndex(nil, f12_local13, CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
			f12_arg0.contentGrid:addButton(f12_local15)
			if f12_local16 == f12_local4 or not f12_local6 then
				f12_local6 = f12_local15
			end
			if f12_local21 then
				f12_local15:setActionPromptString(Engine.Localize("MENU_PURCHASE"))
			else
				f12_local15:setActionPromptString(Engine.Localize("MENU_SELECT"))
			end
		end
	end
	CoD.perController[f12_arg1].currentlyEquippedCamoImageName = UIExpression.GetWeaponOptionImage(nil, f12_local4)
	f12_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f12_arg1,
		contentIndex = f12_local4
	})
	f12_local6:processEvent({
		name = "gain_focus",
		controller = f12_arg1
	})
end

CoD.CACCamo.UpdateCamoPreview = function (f13_arg0, f13_arg1, f13_arg2)
	f13_arg0.lockImage:hide()
	f13_arg0.camoImage:hide()
	f13_arg0.camoPreviewTitle:setText("")
	f13_arg0.xpRewardText:setText("")
	local f13_local0 = 20
	f13_arg0.camoImage:setLeftRight(true, true, f13_local0, -f13_local0)
	if f13_arg1.lockImage then
		f13_arg0.camoPreviewTitle:setText(Engine.Localize("MPUI_REWARDS"))
		f13_arg0.camoImage:show()
		f13_arg0.camoImage:setImage(RegisterMaterial(f13_arg1.camoImageName))
		f13_arg0.lockImage:show()
		if f13_arg1.rewardXP then
			f13_arg0.xpRewardText:setText(Engine.Localize("RANK_XP", f13_arg1.rewardXP))
		end
	elseif f13_arg1.mtxImage then
		f13_arg0.camoPreviewTitle:setText(Engine.Localize("MPUI_PREVIEW"))
		f13_arg0.camoImage:show()
		f13_arg0.camoImage:setImage(RegisterMaterial(f13_arg1.camoImageName))
	else
		f13_arg0.camoPreviewTitle:setText(Engine.Localize("MPUI_EQUIPPED"))
		local f13_local1 = CoD.perController[f13_arg2].currentlyEquippedCamoImageName
		if f13_local1 then
			if f13_local1 == "menu_theater_nodata" then
				local f13_local2 = 70
				f13_arg0.camoImage:setLeftRight(false, false, -f13_local2 / 2, f13_local2 / 2)
			end
			f13_arg0.camoImage:show()
			f13_arg0.camoImage:setImage(RegisterMaterial(f13_local1))
		end
	end
end

CoD.CACCamo.CamoButtonHighlighted = function (f14_arg0, f14_arg1)
	if f14_arg1.contentIndex then
		f14_arg0.camoTitle:setText(f14_arg1.button.nameText)
		if f14_arg1.hintText ~= nil then
			f14_arg0.camoDescription:setText(f14_arg1.hintText)
		else
			f14_arg0.camoDescription:setText("")
		end
		f14_arg0.progressBar:hide()
		if f14_arg1.button.showProgressBar and f14_arg1.button.challengeValue and f14_arg1.button.maxVal then
			f14_arg0.progressBar:show()
			f14_arg0.progressBar:update(f14_arg1.button.challengeValue, f14_arg1.button.maxVal)
		end
		CoD.CACCamo.UpdateCamoPreview(f14_arg0, f14_arg1.button, f14_arg1.controller)
		if f14_arg1.button.lockImage and not f14_arg1.button.overrideLock then
			f14_arg0:dispatchEventToParent({
				name = "remove_select_button"
			})
		end
	else
		f14_arg0.camoTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f14_arg0.camoDescription:setText("")
	end
end

CoD.CACCamo.CamoButtonSelected = function (f15_arg0, f15_arg1)
	local f15_local0 = f15_arg1.button
	if f15_local0.lockImage and f15_local0.overrideLock and f15_local0.customEvent then
		f15_arg0:dispatchEventToParent({
			name = f15_local0.customEvent,
			controller = f15_arg1.controller
		})
	elseif f15_local0.mtxImage then
		local f15_local1 = CoD.CACUtility.GetWeaponOptionMTXName(f15_local0.weaponOption)
		if not Engine.HasMTX(f15_arg1.controller, f15_local1) then
			CoD.CACCamo.WeaponOptionToGainFocus = f15_local0.weaponOption
			if UIExpression.IsGuest(f15_arg1.controller) == 1 then
				f15_arg0:dispatchEventToParent({
					name = "open_no_guest_mtx",
					controller = f15_arg1.controller
				})
			elseif CoD.isPS3 then
				f15_arg0:dispatchEventToParent({
					name = "open_mtx_purchase",
					controller = f15_arg1.controller,
					userData = {
						mtxName = f15_local1,
						openingMenuName = "camo"
					}
				})
			else
				Engine.PurchaseMTX(f15_arg1.controller, f15_local1, "camo")
			end
		end
	else
		local f15_local1 = f15_arg0.m_ownerController
		CoD.perController[f15_arg0.m_ownerController].chosenItem = UIExpression.GetWeaponOptionGroupIndex(nil, f15_arg1.contentIndex, CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
		f15_arg0:processEvent({
			name = "equip",
			controller = f15_arg0.m_ownerController,
			button = f15_arg1.button
		})
	end
end

CoD.CACCamo.CamoEquip = function (f16_arg0, f16_arg1)
	local f16_local0 = CoD.perController[f16_arg1.controller].knifePersonalization
	local f16_local1 = f16_arg1.controller
	local f16_local2 = CoD.perController[f16_local1].classNum
	local f16_local3 = CoD.perController[f16_local1].weaponSlot
	local f16_local4 = CoD.perController[f16_local1].chosenItem
	CoD.perController[f16_local1].chosenItem = nil
	if f16_local4 then
		if f16_local0 then
			Engine.SetClassItem(f16_local1, f16_local2, "knifecamo", f16_local4)
		else
			Engine.SetClassItem(f16_local1, f16_local2, f16_local3 .. "camo", f16_local4)
		end
		f16_arg0:dispatchEventToChildren({
			name = "update_class",
			controller = f16_local1,
			contentIndex = f16_local4
		})
		CoD.CACCamo.UpdateCamoPreview(f16_arg0, f16_arg1.button, f16_arg1.controller)
	end
	f16_arg0:dispatchEventToParent({
		name = "button_prompt_back",
		controller = f16_local1
	})
end

CoD.CACCamo.SetupTagAndEmblemTab = function (f17_arg0, f17_arg1)
	CoD.CACCamo.CloseAllTabs(f17_arg0)
	f17_arg0:addBackButton()
	local f17_local0 = f17_arg0.m_ownerController
	local f17_local1 = CoD.perController[f17_local0].weaponSlot
	local f17_local2 = Engine.GetCustomClass(f17_local0, CoD.perController[f17_local0].classNum)
	f17_arg0.tagAndEmblemTabContainer = LUI.UIElement.new()
	f17_arg0.tagAndEmblemTabContainer:setLeftRight(true, true, 0, 0)
	f17_arg0.tagAndEmblemTabContainer:setTopBottom(true, true, 0, 0)
	f17_arg0:addElement(f17_arg0.tagAndEmblemTabContainer)
	f17_arg0.tagAndEmblemTabContainer.m_ownerController = f17_arg0.m_ownerController
	f17_arg0.tagAndEmblemTabContainer:registerEventHandler("content_button_highlighted", CoD.CACCamo.TagAndEmblemButtonHighlighted)
	f17_arg0.tagAndEmblemTabContainer:registerEventHandler("content_button_selected", CoD.CACCamo.TagAndEmblemButtonSelected)
	f17_arg0.tagAndEmblemTabContainer:registerEventHandler("equip", CoD.CACCamo.TagAndEmblemEquip)
	local f17_local3 = CoD.Menu.TitleHeight + 10
	f17_arg0.tagAndEmblemTabContainer.contentGrid = CoD.ContentGrid.new(CoD.CACCamo.TagAndEmblemGridColumns, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f17_local3,
		bottom = 0
	}, CoD.CACCamo.TagAndEmblemGridItemWidth, CoD.CACCamo.TagAndEmblemGridItemHeight, CoD.CACCamo.GridItemSpacing)
	f17_arg0.tagAndEmblemTabContainer:addElement(f17_arg0.tagAndEmblemTabContainer.contentGrid)
	local f17_local4 = 4
	f17_local3 = -30 + f17_local3 + CoD.CACCamo.CamoGridItemHeight * f17_local4 + CoD.CACCamo.GridItemSpacing * (f17_local4 - 1) + 3 + CoD.HintText.Height + 5
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f17_local3, 0)
	f17_arg0.tagAndEmblemTabContainer:addElement(Widget)
	local f17_local6 = 0
	f17_arg0.tagAndEmblemTabContainer.infoTitle = LUI.UIText.new()
	f17_arg0.tagAndEmblemTabContainer.infoTitle:setLeftRight(true, false, 0, 1)
	f17_arg0.tagAndEmblemTabContainer.infoTitle:setTopBottom(true, false, f17_local6, f17_local6 + CoD.textSize.Big)
	f17_arg0.tagAndEmblemTabContainer.infoTitle:setFont(CoD.fonts.Big)
	f17_arg0.tagAndEmblemTabContainer.infoTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(f17_arg0.tagAndEmblemTabContainer.infoTitle)
	f17_local6 = f17_local6 + CoD.textSize.Big
	f17_arg0.tagAndEmblemTabContainer.infoDescription = LUI.UIText.new()
	f17_arg0.tagAndEmblemTabContainer.infoDescription:setLeftRight(true, false, 0, CoD.Menu.Width / 2)
	f17_arg0.tagAndEmblemTabContainer.infoDescription:setTopBottom(true, false, f17_local6, f17_local6 + CoD.textSize.Default)
	f17_arg0.tagAndEmblemTabContainer.infoDescription:setAlignment(LUI.Alignment.Left)
	f17_arg0.tagAndEmblemTabContainer.infoDescription:setFont(CoD.fonts.Default)
	f17_arg0.tagAndEmblemTabContainer.infoDescription:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f17_arg0.tagAndEmblemTabContainer.infoDescription:setAlpha(0.4)
	Widget:addElement(f17_arg0.tagAndEmblemTabContainer.infoDescription)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -(CoD.Menu.Width / 2) + 10, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local f17_local8 = 280
	local f17_local9 = -70
	local f17_local10 = f17_local8 / 2
	f17_arg0.tagAndEmblemTabContainer.weaponImage = LUI.UIImage.new()
	f17_arg0.tagAndEmblemTabContainer.weaponImage:setLeftRight(false, true, -f17_local8 + 10, 10)
	f17_arg0.tagAndEmblemTabContainer.weaponImage:setTopBottom(true, false, f17_local9, f17_local9 + f17_local10)
	Widget:addElement(f17_arg0.tagAndEmblemTabContainer.weaponImage)
	CoD.CACCamo.AddTagAndEmblemButtons(f17_arg0.tagAndEmblemTabContainer, f17_arg0.m_ownerController, CoD.perController[f17_arg0.m_ownerController].classNum, CoD.perController[f17_arg0.m_ownerController].weaponSlot)
end

CoD.CACCamo.AddTagAndEmblemButtons = function (f18_arg0, f18_arg1, f18_arg2, f18_arg3)
	local f18_local0 = Engine.GetCustomClass(f18_arg1, f18_arg2)
	local f18_local1 = f18_local0[f18_arg3]
	f18_arg0.weaponItemIndex = f18_local1
	f18_arg0.weaponImage:registerAnimationState("weapon_image", {
		material = RegisterMaterial(UIExpression.GetItemImage(nil, f18_local1) .. "_big")
	})
	f18_arg0.weaponImage:animateToState("weapon_image")
	local f18_local2 = tonumber(UIExpression.TableLookup(nil, CoD.attachmentTable, 1, "tag", 0))
	local f18_local3 = UIExpression.GetWeaponOptionGroupIndex(nil, 0, CoD.CACUtility.WEAPONOPTION_GROUP_TAG)
	local f18_local4 = CoD.ContentGridButton.new(f18_local2)
	f18_local4.weaponItemIndex = f18_local1
	f18_local4.weaponOption = f18_local3
	f18_local4.gainFocusSFX = "cac_grid_nav"
	f18_local4.actionSFX = "cac_grid_equip_item"
	f18_local4.hintText = Engine.Localize("FEATURE_GUN_TAG_DESC")
	f18_local4:registerEventHandler("update_class", CoD.CACCamo.TagAndEmblemUpdateClass)
	CoD.ContentGridButton.SetupButtonText(f18_local4, Engine.Localize(UIExpression.GetWeaponOptionName(nil, f18_local3)))
	CoD.ContentGridButton.SetupButtonImages(f18_local4, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
	if Engine.IsWeaponOptionNew(f18_arg1, f18_local1, f18_local3) then
		f18_local4:setNew(true, f18_arg1)
	else
		f18_local4:setNew(false, f18_arg1)
	end
	local f18_local5 = 10
	local f18_local6 = "Big"
	local f18_local7 = CoD.fonts[f18_local6]
	local f18_local8 = CoD.textSize[f18_local6]
	local f18_local9 = Engine.Localize("FEATURE_CLAN_TAG_CAPS")
	local f18_local10 = CoD.ClanTag.GetClanName(f18_arg1)
	if f18_local10 ~= "" then
		f18_local9 = f18_local10
		f18_local4:setInactive(false)
	else
		f18_local4:setInactive(true)
	end
	f18_local4.itemImage = LUI.UIText.new()
	f18_local4.itemImage:setLeftRight(true, true, 0, 0)
	f18_local4.itemImage:setTopBottom(false, false, -f18_local5 - f18_local8 / 2, -f18_local5 + f18_local8 / 2)
	f18_local4.itemImage:setPriority(-70)
	f18_local4.itemImage:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f18_local4.itemImage:setFont(f18_local7)
	f18_local4.itemImage:setAlignment(LUI.Alignment.Center)
	f18_local4.itemImage:setText("[" .. f18_local9 .. "]")
	f18_local4:addElement(f18_local4.itemImage)
	f18_arg0.contentGrid:addButton(f18_local4)
	local f18_local11 = tonumber(UIExpression.TableLookup(nil, CoD.attachmentTable, 1, "emblem", 0))
	local f18_local12 = UIExpression.GetWeaponOptionGroupIndex(nil, 0, CoD.CACUtility.WEAPONOPTION_GROUP_EMBLEM)
	local f18_local13 = CoD.ContentGridButton.new(f18_local11)
	f18_local13.weaponItemIndex = f18_local1
	f18_local13.weaponOption = f18_local12
	f18_local13.gainFocusSFX = "cac_grid_nav"
	f18_local13.actionSFX = "cac_grid_equip_item"
	f18_local13.hintText = Engine.Localize("FEATURE_GUN_EMBLEM_DESC")
	f18_local13:registerEventHandler("update_class", CoD.CACCamo.TagAndEmblemUpdateClass)
	CoD.ContentGridButton.SetupButtonText(f18_local13, Engine.Localize(UIExpression.GetWeaponOptionName(nil, f18_local12)))
	CoD.ContentGridButton.SetupButtonImages(f18_local13, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
	if Engine.IsWeaponOptionNew(f18_arg1, f18_local1, f18_local12) then
		f18_local13:setNew(true, f18_arg1)
	else
		f18_local13:setNew(false, f18_arg1)
	end
	local f18_local14 = 2
	local f18_local15 = CoD.CACCamo.TagAndEmblemGridItemHeight - CoD.ContentGridButton.TitleHeight + 4 - f18_local14 - 1
	local f18_local16 = f18_local15
	local f18_local17 = UIExpression.GetXUID(f18_arg1)
	f18_local13:setImage("", f18_local16, f18_local15)
	f18_local13.itemImage:setTopBottom(true, false, f18_local14, f18_local14 + f18_local15)
	f18_local13.itemImage:setPriority(-70)
	f18_local13.itemImage:setupPlayerEmblemByXUID(f18_local17)
	f18_arg0.contentGrid:addButton(f18_local13)
	f18_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f18_arg1
	})
	f18_local4:processEvent({
		name = "gain_focus",
		controller = f18_arg1
	})
end

CoD.CACCamo.GetTagAndEmblemWeaponOptionGroup = function (f19_arg0)
	local f19_local0, f19_local1 = nil
	if f19_arg0 ~= nil then
		f19_local1 = UIExpression.TableLookup(nil, CoD.attachmentTable, 0, f19_arg0, 1)
	end
	if f19_local1 == "tag" then
		f19_local0 = CoD.CACUtility.WEAPONOPTION_GROUP_TAG
	elseif f19_local1 == "emblem" then
		f19_local0 = CoD.CACUtility.WEAPONOPTION_GROUP_EMBLEM
	end
	return f19_local0
end

CoD.CACCamo.TagAndEmblemButtonHighlighted = function (f20_arg0, f20_arg1)
	if f20_arg1.contentIndex then
		local f20_local0 = nil
		local f20_local1 = CoD.CACCamo.GetTagAndEmblemWeaponOptionGroup(f20_arg1.contentIndex)
		if f20_arg1.button.lockImage then
			f20_arg0:dispatchEventToParent({
				name = "remove_select_button"
			})
		end
		if f20_local1 ~= nil then
			f20_arg0.infoTitle:setText(Engine.Localize(UIExpression.GetWeaponOptionName(nil, UIExpression.GetWeaponOptionGroupIndex(nil, 0, f20_local1))))
			if f20_arg1.hintText ~= nil then
				f20_arg0.infoDescription:setText(f20_arg1.hintText)
			else
				f20_arg0.infoDescription:setText("")
			end
		end
	end
end

CoD.CACCamo.TagAndEmblemButtonSelected = function (f21_arg0, f21_arg1)
	local f21_local0 = f21_arg0.m_ownerController
	CoD.perController[f21_arg0.m_ownerController].chosenItem = UIExpression.GetWeaponOptionGroupIndex(nil, 0, CoD.CACCamo.GetTagAndEmblemWeaponOptionGroup(f21_arg1.contentIndex))
	if f21_arg1.button.inactive ~= true then
		f21_arg0:processEvent({
			name = "equip",
			controller = f21_arg0.m_ownerController
		})
	end
end

CoD.CACCamo.TagAndEmblemEquip = function (f22_arg0, f22_arg1)
	local f22_local0 = f22_arg1.controller
	local f22_local1 = CoD.perController[f22_local0].classNum
	local f22_local2 = CoD.perController[f22_local0].weaponSlot
	local f22_local3 = CoD.perController[f22_local0].chosenItem
	CoD.perController[f22_local0].chosenItem = nil
	if f22_local3 ~= nil then
		local f22_local4 = UIExpression.TableLookup(nil, CoD.attachmentTable, 0, f22_local3, 1)
		if f22_local4 ~= nil then
			local f22_local5 = f22_local2 .. f22_local4
			local f22_local6 = Engine.GetCustomClass(f22_local0, f22_local1)
			if f22_local3 == f22_local6[f22_local5] then
				Engine.SetClassItem(f22_local0, f22_local1, f22_local5, 0)
			else
				Engine.SetClassItem(f22_local0, f22_local1, f22_local5, f22_local3)
			end
			f22_arg0:dispatchEventToChildren({
				name = "update_class",
				controller = f22_local0
			})
		end
	end
end

CoD.CACCamo.TagAndEmblemUpdateClass = function (f23_arg0, f23_arg1)
	f23_arg0.selectedFill:setAlpha(0)
	f23_arg0.glowGradFront:setRGB(CoD.GrenadeGridButton.glowFrontColor.r, CoD.GrenadeGridButton.glowFrontColor.g, CoD.RewardGridButton.glowFrontColor.b)
	f23_arg0.glowGradFront:setAlpha(0.05)
	local f23_local0 = f23_arg1.controller
	local f23_local1 = Engine.GetCustomClass(f23_local0, CoD.perController[f23_local0].classNum)
	local f23_local2 = f23_local1[CoD.perController[f23_local0].weaponSlot .. UIExpression.TableLookup(nil, CoD.attachmentTable, 0, f23_arg0.contentIndex, 1)]
	local f23_local3 = f23_arg0.contentIndex
	if f23_local3 == f23_local2 then
		f23_arg0.selectedFill:setAlpha(0.2)
		f23_arg0.glowGradFront:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		f23_arg0.glowGradFront:setAlpha(0.2)
	end
	local f23_local4 = Engine.GetItemOptionLocked(f23_arg1.controller, f23_arg0.weaponItemIndex, f23_local3)
	f23_arg0:setLocked(f23_local4)
	if f23_local4 then
		f23_arg0.hintText = Engine.Localize("MPUI_WEAPON_PLEVELN_REQ", UIExpression.GetWeaponOptionUnlockPLevel(nil, f23_local3))
	else
		f23_arg0:setActionPromptString(Engine.Localize("MENU_SELECT"))
	end
end

CoD.CACCamo.HandleMTXChanged = function (f24_arg0, f24_arg1)
	if f24_arg1.controller ~= f24_arg0.m_ownerController then
		return 
	end
	local f24_local0 = CoD.CACCamo.WeaponOptionToGainFocus
	if f24_local0 then
		local f24_local1 = tonumber(UIExpression.TableLookup(nil, "mp/attachmenttable.csv", 0, f24_local0, 5)) or 0
		local f24_local2 = nil
		if f24_local1 > 0 then
			CoD.CACCamo.SetupDlc2Tab(f24_arg0, f24_arg1)
			f24_local2 = f24_arg0.dlc2CamoTabContainer
		else
			CoD.CACCamo.SetupDlcTab(f24_arg0, f24_arg1)
			f24_local2 = f24_arg0.dlcCamoTabContainer
		end
		local f24_local3 = nil
		if f24_local2 and f24_local2.contentGrid then
			for f24_local7, f24_local8 in ipairs(f24_local2.contentGrid.buttons) do
				if f24_local3 == nil then
					f24_local3 = f24_local8
				end
				if f24_local8.weaponOption == f24_local0 then
					f24_local3 = f24_local8
				else
					f24_local8:processEvent({
						name = "lose_focus",
						controller = f24_arg1.controller
					})
				end
			end
		end
		if f24_local3 then
			f24_local3:processEvent({
				name = "gain_focus",
				controller = f24_arg1.controller
			})
		end
	end
end

CoD.CACCamo.OpenMTXPurchase = function (f25_arg0, f25_arg1)
	f25_arg0:openPopup("MTXPurchase", f25_arg1.controller, f25_arg1.userData)
end

CoD.CACCamo.OpenNoGuestMTX = function (f26_arg0, f26_arg1)
	local f26_local0 = f26_arg0:openPopup("Error", controller)
	f26_local0:setMessage(Engine.Localize("XBOXLIVE_NOGUESTACCOUNTS"))
end

