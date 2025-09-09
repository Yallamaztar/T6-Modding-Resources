require("T6.ReticlesGridButton")
CoD.CACReticles = {}
CoD.CACReticles.reticlePreviewLineMaterialName = "menu_mp_cac_attach_line"
CoD.CACReticles.GridTop = 60
CoD.CACReticles.GridItemSpacing = 8
CoD.CACReticles.GridColumns = 5
CoD.CACReticles.GridItemWidth = (CoD.Menu.Width - CoD.CACReticles.GridItemSpacing * (CoD.CACReticles.GridColumns - 1)) / CoD.CACReticles.GridColumns
CoD.CACReticles.GridItemHeight = 50 + CoD.ContentGridButton.TitleHeight + 20
CoD.CACReticles.TabEvents = {
	reticle_tab = "setup_reticle_tab",
	dlc_tab = "setup_dlc_tab",
	dlc2_tab = "setup_dlc2_tab"
}
CoD.CACReticles.Tabs = {}
CoD.CACReticles.Tabs.ReticleTab = 1
CoD.CACReticles.Tabs.DlcTab = 2
CoD.CACReticles.TabChangeHandler = function (f1_arg0, f1_arg1)
	if f1_arg1.currentTabName and CoD.CACReticles.TabEvents[f1_arg1.currentTabName] then
		f1_arg0:processEvent({
			name = CoD.CACReticles.TabEvents[f1_arg1.currentTabName],
			controller = f1_arg1.controller
		})
	end
end

CoD.CACReticles.CloseAllTabs = function (f2_arg0)
	CoD.CACReticles.WeaponOptionToGainFocus = nil
	f2_arg0:closeSelectButton()
	f2_arg0:removeBackButton()
	if f2_arg0.reticleTabContainer then
		f2_arg0.reticleTabContainer:close()
		f2_arg0.reticleTabContainer = nil
	end
	if f2_arg0.dlcReticleTabContainer then
		f2_arg0.dlcReticleTabContainer:close()
		f2_arg0.dlcReticleTabContainer = nil
	end
	if f2_arg0.dlc2ReticleTabContainer then
		f2_arg0.dlc2ReticleTabContainer:close()
		f2_arg0.dlc2ReticleTabContainer = nil
	end
end

CoD.CACReticles.RemoveSelectButton = function (f3_arg0, f3_arg1)
	f3_arg0:closeSelectButton()
end

LUI.createMenu.CACReticles = function (f4_arg0)
	local f4_local0 = CoD.Menu.New("CACReticles")
	f4_local0:addLargePopupBackground()
	f4_local0:setOwner(f4_arg0)
	f4_local0:registerEventHandler("tab_changed", CoD.CACReticles.TabChangeHandler)
	f4_local0:registerEventHandler("setup_reticle_tab", CoD.CACReticles.SetupReticleTab)
	f4_local0:registerEventHandler("setup_dlc_tab", CoD.CACReticles.SetupDlcTab)
	f4_local0:registerEventHandler("setup_dlc2_tab", CoD.CACReticles.SetupDlc2Tab)
	f4_local0:registerEventHandler("remove_select_button", CoD.CACReticles.RemoveSelectButton)
	f4_local0:registerEventHandler("mtx_changed", CoD.CACReticles.HandleMTXChanged)
	f4_local0:registerEventHandler("open_mtx_purchase", CoD.CACReticles.OpenMTXPurchase)
	f4_local0:registerEventHandler("open_no_guest_mtx", CoD.CACReticles.OpenNoGuestMTX)
	local f4_local1 = CoD.perController[f4_arg0].weaponSlot
	local f4_local2 = Engine.GetCustomClass(f4_arg0, CoD.perController[f4_arg0].classNum)
	local f4_local3 = f4_local2[f4_local1]
	local f4_local4 = CoD.perController[f4_arg0].attachmentIndex
	local f4_local5 = Engine.Localize("MENU_X_OPTICS", Engine.GetAttachmentName(f4_local3, f4_local4))
	f4_local0.attachmentRef = Engine.GetAttachmentRef(f4_local3, f4_local4)
	f4_local0.dualOpticReticle = f4_local0.attachmentRef == "dualoptic"
	f4_local0.weaponItemIndex = f4_local3
	local f4_local6 = CoD.perController[f4_arg0].attachmentIndex
	f4_local0:addTitle(f4_local5)
	local f4_local7 = CoD.Menu.TitleHeight
	local f4_local8 = CoD.ButtonPrompt.Height
	f4_local0.tabManager = CoD.TabManager.new(nil, nil, LUI.Alignment.Right)
	f4_local0.tabManager:setLeftRight(true, true, 0, 0)
	f4_local0.tabManager:setTopBottom(true, false, f4_local7 - f4_local8, f4_local7)
	f4_local0:addElement(f4_local0.tabManager)
	f4_local0.tabManager:addTab(Engine.Localize("MPUI_RETICLES_CAPS"), "reticle_tab")
	if CoD.CACUtility.IsAnyWeaponMTXAvailable() or CoD.CACUtility.HasAnyWeaponMTX(f4_arg0) then
		f4_local0.tabManager:addTab(Engine.Localize("MPUI_MAP_CATEGORY_DLC_CAPS"), "dlc_tab")
		if CoD.CACReticles.ShouldDisplayDlc2Tab(f4_arg0) then
			f4_local0.tabManager:addTab(Engine.Localize("MPUI_DLC2_CAPS"), "dlc2_tab")
		end
	end
	f4_local0.tabManager:setCurrentTab()
	return f4_local0
end

CoD.CACReticles.ShouldDisplayDlc2Tab = function (f5_arg0)
	local f5_local0 = Engine.GetNumWeaponOptions(CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
	local f5_local1 = false
	for f5_local2 = 0, f5_local0 - 1, 1 do
		local f5_local5 = false
		local f5_local6 = UIExpression.GetWeaponOptionGroupIndex(nil, f5_local2, CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
		local f5_local7 = CoD.CACUtility.IsWeaponOptionMTX(f5_local6)
		local f5_local8 = tonumber(UIExpression.TableLookup(nil, "mp/attachmenttable.csv", 0, f5_local6, 5))
		local f5_local9 = CoD.CACUtility.ShouldDisplayWeaponOptionMTX(f5_arg0, f5_local6)
		if not f5_local8 then
			f5_local8 = 0
		end
		if not f5_local1 and f5_local8 > 0 and f5_local9 then
			f5_local1 = true
			break
		end
	end
	return f5_local1
end

CoD.CACReticles.SetupReticleTab = function (f6_arg0, f6_arg1)
	CoD.CACReticles.CloseAllTabs(f6_arg0)
	f6_arg0:addBackButton()
	f6_arg0.reticleTabContainer = LUI.UIElement.new()
	f6_arg0.reticleTabContainer:setLeftRight(true, true, 0, 0)
	f6_arg0.reticleTabContainer:setTopBottom(true, true, 0, 0)
	f6_arg0:addElement(f6_arg0.reticleTabContainer)
	f6_arg0.reticleTabContainer.m_ownerController = f6_arg0.m_ownerController
	f6_arg0.reticleTabContainer:registerEventHandler("content_button_highlighted", CoD.CACReticles.ContentButtonHighlighted)
	f6_arg0.reticleTabContainer:registerEventHandler("content_button_selected", CoD.CACReticles.ContentButtonSelected)
	f6_arg0.reticleTabContainer:registerEventHandler("equip", CoD.CACReticles.Equip)
	CoD.CACReticles.SetupReticleTabContainer(f6_arg0.reticleTabContainer, f6_arg0.m_ownerController)
end

CoD.CACReticles.SetupDlcTab = function (f7_arg0, f7_arg1)
	CoD.CACReticles.CloseAllTabs(f7_arg0)
	f7_arg0:addBackButton()
	f7_arg0.dlcReticleTabContainer = LUI.UIElement.new()
	f7_arg0.dlcReticleTabContainer:setLeftRight(true, true, 0, 0)
	f7_arg0.dlcReticleTabContainer:setTopBottom(true, true, 0, 0)
	f7_arg0:addElement(f7_arg0.dlcReticleTabContainer)
	f7_arg0.dlcReticleTabContainer.m_ownerController = f7_arg0.m_ownerController
	f7_arg0.dlcReticleTabContainer:registerEventHandler("content_button_highlighted", CoD.CACReticles.ContentButtonHighlighted)
	f7_arg0.dlcReticleTabContainer:registerEventHandler("content_button_selected", CoD.CACReticles.ContentButtonSelected)
	f7_arg0.dlcReticleTabContainer:registerEventHandler("equip", CoD.CACReticles.Equip)
	CoD.CACReticles.SetupReticleTabContainer(f7_arg0.dlcReticleTabContainer, f7_arg0.m_ownerController, "dlc")
	Engine.SetStartCheckoutTimestampUTC()
	Engine.SendDLCMenusViewedRecordEvent(f7_arg1.controller, CoD.DLC_RETICLES_MENU_VIEWED, "reticle")
end

CoD.CACReticles.SetupDlc2Tab = function (f8_arg0, f8_arg1)
	CoD.CACReticles.CloseAllTabs(f8_arg0)
	f8_arg0:addBackButton()
	f8_arg0.dlc2ReticleTabContainer = LUI.UIElement.new()
	f8_arg0.dlc2ReticleTabContainer:setLeftRight(true, true, 0, 0)
	f8_arg0.dlc2ReticleTabContainer:setTopBottom(true, true, 0, 0)
	f8_arg0:addElement(f8_arg0.dlc2ReticleTabContainer)
	f8_arg0.dlc2ReticleTabContainer.m_ownerController = f8_arg0.m_ownerController
	f8_arg0.dlc2ReticleTabContainer:registerEventHandler("content_button_highlighted", CoD.CACReticles.ContentButtonHighlighted)
	f8_arg0.dlc2ReticleTabContainer:registerEventHandler("content_button_selected", CoD.CACReticles.ContentButtonSelected)
	f8_arg0.dlc2ReticleTabContainer:registerEventHandler("equip", CoD.CACReticles.Equip)
	CoD.CACReticles.SetupReticleTabContainer(f8_arg0.dlc2ReticleTabContainer, f8_arg0.m_ownerController, "dlc2")
	Engine.SetStartCheckoutTimestampUTC()
	Engine.SendDLCMenusViewedRecordEvent(f8_arg1.controller, CoD.DLC_RETICLES_MENU_VIEWED, "reticle")
end

CoD.CACReticles.SetupReticleTabContainer = function (f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = CoD.perController[f9_arg1].weaponSlot
	local f9_local1 = Engine.GetCustomClass(f9_arg1, CoD.perController[f9_arg1].classNum)
	local f9_local2 = f9_local1[f9_local0]
	local f9_local3 = Engine.Localize("MENU_X_OPTICS", Engine.GetAttachmentName(f9_local2, CoD.perController[f9_arg1].attachmentIndex))
	f9_arg0.attachmentRef = Engine.GetAttachmentRef(f9_local2, CoD.perController[f9_arg1].attachmentIndex)
	f9_arg0.dualOpticReticle = f9_arg0.attachmentRef == "dualoptic"
	f9_arg0.weaponItemIndex = f9_local2
	local f9_local4 = CoD.Menu.TitleHeight + 10
	f9_arg0.contentGrid = CoD.ContentGrid.new(CoD.CACReticles.GridColumns, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f9_local4,
		bottom = 0
	}, CoD.CACReticles.GridItemWidth, CoD.CACReticles.GridItemHeight, CoD.CACReticles.GridItemSpacing)
	f9_arg0:addElement(f9_arg0.contentGrid)
	local f9_local5 = 4
	local f9_local6 = 0
	if CoD.LANGUAGE_JAPANESE == Dvar.loc_language:get() or CoD.LANGUAGE_FULLJAPANESE == Dvar.loc_language:get() then
		f9_local6 = 30
	end
	f9_local4 = -30 + f9_local4 + CoD.CACReticles.GridItemHeight * f9_local5 + CoD.CACReticles.GridItemSpacing * (f9_local5 - 1) + 3 + CoD.HintText.Height + 5 + f9_local6
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f9_local4, 0)
	f9_arg0:addElement(Widget)
	local f9_local8 = 0
	local f9_local9 = CoD.Menu.Width * 0.33
	f9_arg0.progressBar = CoD.ChallengeProgressBar.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f9_local9,
		topAnchor = true,
		bottomAnchor = true,
		top = f9_local8 + 105,
		bottom = 0
	}, f9_local9)
	Widget:addElement(f9_arg0.progressBar)
	f9_arg0.reticleTitle = LUI.UIText.new()
	f9_arg0.reticleTitle:setLeftRight(true, false, 0, 1)
	f9_arg0.reticleTitle:setTopBottom(true, false, f9_local8, f9_local8 + CoD.textSize.Big)
	f9_arg0.reticleTitle:setFont(CoD.fonts.Big)
	f9_arg0.reticleTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(f9_arg0.reticleTitle)
	f9_local8 = f9_local8 + CoD.textSize.Big
	f9_arg0.reticleDescription = LUI.UIText.new()
	f9_arg0.reticleDescription:setLeftRight(true, false, 0, CoD.Menu.Width / 2 - 100)
	f9_arg0.reticleDescription:setTopBottom(true, false, f9_local8, f9_local8 + CoD.textSize.Default)
	f9_arg0.reticleDescription:setAlignment(LUI.Alignment.Left)
	f9_arg0.reticleDescription:setFont(CoD.fonts.Default)
	f9_arg0.reticleDescription:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f9_arg0.reticleDescription:setAlpha(0.4)
	Widget:addElement(f9_arg0.reticleDescription)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -(CoD.Menu.Width / 2) + 10, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local f9_local11 = 128
	local f9_local12 = f9_local11
	local f9_local13 = -40
	f9_arg0.weaponImage = LUI.UIImage.new()
	f9_arg0.weaponImage:setLeftRight(false, true, -f9_local11 + 10, 10)
	f9_arg0.weaponImage:setTopBottom(true, false, f9_local13, f9_local13 + f9_local12)
	Widget:addElement(f9_arg0.weaponImage)
	local f9_local14 = 1
	if f9_arg0.dualOpticReticle then
		f9_local14 = 2
	end
	local f9_local15 = 90
	local f9_local16 = 0
	local f9_local17 = -CoD.ButtonPrompt.Height - 50
	local f9_local18 = f9_local15 + 10
	local f9_local19 = f9_local15 * f9_local14 + 45
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f9_local16, f9_local16 + f9_local19)
	Widget:setTopBottom(false, true, f9_local17 - f9_local18, f9_local17)
	Widget:addElement(Widget)
	local f9_local21 = "Default"
	local f9_local22 = CoD.fonts[f9_local21]
	local f9_local23 = CoD.textSize[f9_local21]
	f9_arg0.reticlePreviewTitle = LUI.UIText.new()
	f9_arg0.reticlePreviewTitle:setLeftRight(true, false, 0, 300)
	f9_arg0.reticlePreviewTitle:setTopBottom(true, false, -f9_local23, 0)
	f9_arg0.reticlePreviewTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f9_arg0.reticlePreviewTitle:setFont(reticleTitleFont)
	f9_arg0.reticlePreviewTitle:setAlignment(LUI.Alignment.Left)
	f9_arg0.reticlePreviewTitle:setText("")
	Widget:addElement(f9_arg0.reticlePreviewTitle)
	local f9_local24 = 48
	local f9_local25 = 22
	local f9_local26 = 10
	f9_arg0.reticleImage = LUI.UIImage.new()
	f9_arg0.reticleImage:setLeftRight(false, false, -f9_local24 / 2, f9_local24 / 2)
	f9_arg0.reticleImage:setTopBottom(true, false, f9_local26, f9_local26 + f9_local24)
	f9_arg0.reticleImage:hide()
	Widget:addElement(f9_arg0.reticleImage)
	f9_local24 = 48
	local f9_local27 = 40
	f9_arg0.reticleImage1 = LUI.UIImage.new()
	f9_arg0.reticleImage1:setLeftRight(false, false, -f9_local27 / 2 - f9_local24, -f9_local27 / 2)
	f9_arg0.reticleImage1:setTopBottom(true, false, f9_local26, f9_local26 + f9_local24)
	f9_arg0.reticleImage1:hide()
	Widget:addElement(f9_arg0.reticleImage1)
	f9_arg0.reticleImage2 = LUI.UIImage.new()
	f9_arg0.reticleImage2:setLeftRight(false, false, f9_local27 / 2, f9_local27 / 2 + f9_local24)
	f9_arg0.reticleImage2:setTopBottom(true, false, f9_local26, f9_local26 + f9_local24)
	f9_arg0.reticleImage2:hide()
	Widget:addElement(f9_arg0.reticleImage2)
	local f9_local28 = "Default"
	local f9_local29 = CoD.textSize[f9_local28]
	local f9_local30 = CoD.fonts[f9_local28]
	f9_arg0.reticleXPReward = LUI.UIText.new()
	f9_arg0.reticleXPReward:setFont(f9_local30)
	f9_arg0.reticleXPReward:setLeftRight(true, true, 0, 0)
	f9_arg0.reticleXPReward:setTopBottom(false, true, -f9_local29 - 10, -10)
	f9_arg0.reticleXPReward:setAlignment(LUI.Alignment.Center)
	f9_arg0.reticleXPReward:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
	Widget:addElement(f9_arg0.reticleXPReward)
	local f9_local31 = 24
	f9_arg0.lockImage = LUI.UIImage.new()
	f9_arg0.lockImage:setLeftRight(true, false, 5, 5 + f9_local31)
	f9_arg0.lockImage:setTopBottom(false, true, -15 - f9_local31, -15)
	f9_arg0.lockImage:setImage(RegisterMaterial(CoD.CACUtility.LockImageMaterial))
	f9_arg0.lockImage:hide()
	Widget:addElement(f9_arg0.lockImage)
	Widget:addElement(CoD.BorderDip.new(1, 1, 1, 1, 0.05, nil, f9_local19, f9_local14))
	CoD.CACReticles.AddReticles(f9_arg0, f9_arg1, CoD.perController[f9_arg1].classNum, f9_local0, f9_arg2)
	return self
end

CoD.CACReticles.IsReticleHidden = function (f10_arg0)
	local f10_local0 = tonumber(UIExpression.TableLookup(nil, CoD.attachmentTable, 1, "reticle", 0, f10_arg0, 9))
	if not f10_local0 then
		return false
	elseif not Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH) then
		return f10_local0 > 0
	else
		return f10_local0 == 2
	end
end

CoD.CACReticles.ShowHiddenReticle = function (f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	local f11_local0 = not f11_arg3
	local f11_local1, f11_local2 = Engine.GetChallengeForItemOption(f11_arg1, f11_arg2)
	if f11_local1 then
		local f11_local3 = CoD.CACReticles.IsReticleHidden(f11_arg2)
		local f11_local4 = UIExpression.TableLookupGetColumnValueForRow(f11_arg0, "mp/statsmilestones" .. f11_local2 + 1 .. ".csv", f11_local1, 4)
		f11_local0 = true
		if f11_local3 and Engine.GetItemOptionLocked(f11_arg0, f11_arg1, f11_arg2) then
			f11_local0 = false
		end
		if f11_local4 == "digital_unlock" and UIExpression.IsSignedInToLive(f11_arg0) == 0 then
			f11_local0 = false
		end
		if not (f11_arg3 or f11_local4 ~= "digital_unlock") or f11_arg3 == "dlc" and f11_local4 ~= "digital_unlock" then
			f11_local0 = false
		end
		if f11_arg3 == "dlc2" then
			f11_local0 = false
		end
	end
	return f11_local0
end

CoD.CACReticles.AddReticles = function (f12_arg0, f12_arg1, f12_arg2, f12_arg3, f12_arg4)
	local f12_local0 = Engine.GetCustomClass(f12_arg1, f12_arg2)
	local f12_local1 = f12_local0[f12_arg3]
	local f12_local2 = CoD.perController[f12_arg1].attachmentIndex
	f12_arg0.weaponItemIndex = f12_local1
	f12_arg0.attachmentIndex = f12_local2
	f12_arg0.attachmentRef = Engine.GetAttachmentRef(f12_arg0.weaponItemIndex, f12_arg0.attachmentIndex)
	f12_arg0.weaponImage:registerAnimationState("weapon_image", {
		material = RegisterMaterial(Engine.GetAttachmentImage(f12_local1, f12_local2))
	})
	f12_arg0.weaponImage:animateToState("weapon_image")
	local f12_local3 = Engine.GetNumWeaponOptions(CoD.CACUtility.WEAPONOPTION_GROUP_RETICLE)
	local f12_local4 = f12_local0[f12_arg3 .. "reticle"]
	local f12_local5, f12_local6 = nil
	if f12_local4 == nil then
		f12_local4 = tonumber(UIExpression.TableLookup(f12_arg1, CoD.attachmentTable, 1, "reticle", 4, "reticle_0", 0))
	end
	local f12_local7 = {}
	for f12_local8 = 0, f12_local3 - 1, 1 do
		if UIExpression.GetWeaponOptionGroupIndex(nil, f12_local8, CoD.CACUtility.WEAPONOPTION_GROUP_RETICLE) == f12_local4 then
			f12_local5 = f12_local8
		end
	end
	if f12_arg4 == "dlc2" then
		local f12_local8 = {}
		for f12_local9 = 0, f12_local3 - 1, 1 do
			local f12_local12 = tonumber(UIExpression.TableLookup(nil, "mp/attachmenttable.csv", 0, UIExpression.GetWeaponOptionGroupIndex(nil, f12_local9, CoD.CACUtility.WEAPONOPTION_GROUP_RETICLE), 5))
			if f12_local12 then
				table.insert(f12_local8, {
					index = f12_local9,
					sortKey = f12_local12
				})
			end
		end
		table.sort(f12_local8, function (f20_arg0, f20_arg1)
			return f20_arg0.sortKey < f20_arg1.sortKey
		end)
		for f12_local13, f12_local14 in ipairs(f12_local8) do
			table.insert(f12_local7, f12_local14.index)
		end
		table.insert(f12_local7, 1, 0)
	else
		for f12_local8 = 0, f12_local3 - 1, 1 do
			table.insert(f12_local7, f12_local8)
		end
	end
	for f12_local11, f12_local13 in ipairs(f12_local7) do
		local f12_local14 = true
		local f12_local12 = UIExpression.GetWeaponOptionGroupIndex(nil, f12_local13, CoD.CACUtility.WEAPONOPTION_GROUP_RETICLE)
		local f12_local16 = CoD.CACUtility.IsWeaponOptionMTX(f12_local12)
		if f12_local16 then
			if f12_arg4 then
				local f12_local15 = tonumber(UIExpression.TableLookup(nil, "mp/attachmenttable.csv", 0, f12_local12, 5)) or 0
				f12_local14 = CoD.CACUtility.ShouldDisplayWeaponOptionMTX(f12_arg1, f12_local12)
				if not (f12_arg4 ~= "dlc" or f12_local15 <= 0) or f12_arg4 == "dlc2" and f12_local15 == 0 then
					f12_local14 = false
				end
			else
				f12_local14 = false
			end
		else
			f12_local14 = CoD.CACReticles.ShowHiddenReticle(f12_arg1, f12_local1, f12_local12, f12_arg4)
			if f12_arg4 == "dlc2" then
				f12_local14 = false
			end
		end
		if f12_local14 then
			local f12_local15 = CoD.ReticlesGridButton.new(f12_local13, f12_arg0.attachmentRef, Engine.GetItemAttachment(f12_local1, f12_local2))
			f12_local15.weaponItemIndex = f12_local1
			f12_local15.attachmentIndex = f12_local2
			f12_arg0.contentGrid:addButton(f12_local15)
			if f12_local12 == f12_local4 or not f12_local6 then
				f12_local6 = f12_local15
			end
			if f12_local16 then
				f12_local15:setActionPromptString(Engine.Localize("MENU_PURCHASE"))
			else
				f12_local15:setActionPromptString(Engine.Localize("MENU_SELECT"))
			end
		end
	end
	if f12_arg0.attachmentRef == "dualoptic" then
		f12_local8 = "reflex_" .. f12_local5
		f12_local9 = "acog_" .. f12_local5
		if f12_local5 == 0 then
			f12_local8 = "dualoptic_up_0"
			f12_local9 = "dualoptic_down_0"
		elseif f12_local5 == 9 then
			f12_local8 = "dualoptic_up_9"
			f12_local9 = "dualoptic_down_9"
		end
		CoD.perController[f12_arg1].currentlyEquippedReticleImage1 = f12_local8
		CoD.perController[f12_arg1].currentlyEquippedReticleImage2 = f12_local9
	else
		CoD.perController[f12_arg1].currentlyEquippedReticleImage = f12_arg0.attachmentRef .. "_" .. f12_local5
	end
	f12_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f12_arg1,
		equippedWeaponOption = f12_local4
	})
	f12_local6:processEvent({
		name = "gain_focus",
		controller = f12_arg1
	})
end

CoD.CACReticles.UpdateReticlePreview = function (f13_arg0, f13_arg1, f13_arg2)
	f13_arg0.reticleImage:hide()
	f13_arg0.reticleImage1:hide()
	f13_arg0.reticleImage2:hide()
	f13_arg0.lockImage:hide()
	f13_arg0.reticleXPReward:setText("")
	f13_arg0.reticlePreviewTitle:setText("")
	local f13_local0 = ""
	local f13_local1 = ""
	local f13_local2, f13_local3, f13_local4 = nil
	if f13_arg1.lockImage or f13_arg1.mtxImage then
		if f13_arg1.dualOpticReticle then
			f13_local3 = f13_arg1.image1MaterialName
			f13_local4 = f13_arg1.image2MaterialName
		else
			f13_local2 = f13_arg1.reticleImageName
		end
		if f13_arg1.xpReward then
			f13_local1 = Engine.Localize("RANK_XP", f13_arg1.xpReward)
		end
		if f13_arg1.lockImage then
			f13_arg0.lockImage:show()
			f13_local0 = Engine.Localize("MPUI_REWARDS")
		elseif f13_arg1.mtxImage then
			f13_arg0.lockImage:hide()
			f13_local0 = Engine.Localize("MPUI_PREVIEW")
		end
	else
		if f13_arg1.dualOpticReticle then
			f13_local3 = CoD.perController[f13_arg2].currentlyEquippedReticleImage1
			f13_local4 = CoD.perController[f13_arg2].currentlyEquippedReticleImage2
			f13_arg0.reticleXPReward:setLeftRight(true, true, 0, -15)
		else
			f13_local2 = CoD.perController[f13_arg2].currentlyEquippedReticleImage
		end
		f13_local0 = Engine.Localize("MPUI_EQUIPPED")
	end
	if f13_arg1.dualOpticReticle and f13_local3 then
		f13_arg0.reticleImage1:show()
		f13_arg0.reticleImage1:setImage(RegisterMaterial(f13_local3))
		f13_arg0.reticleImage2:show()
		f13_arg0.reticleImage2:setImage(RegisterMaterial(f13_local4))
	elseif f13_local2 then
		f13_arg0.reticleImage:show()
		f13_arg0.reticleImage:setImage(RegisterMaterial(f13_local2))
	end
	f13_arg0.reticlePreviewTitle:setText(f13_local0)
	f13_arg0.reticleXPReward:setText(f13_local1)
end

CoD.CACReticles.ContentButtonHighlighted = function (f14_arg0, f14_arg1)
	if f14_arg1.contentIndex then
		f14_arg0.reticleTitle:setText(f14_arg1.button.nameText)
		if f14_arg1.hintText ~= nil then
			f14_arg0.reticleDescription:setText(f14_arg1.hintText)
		else
			f14_arg0.reticleDescription:setText("")
		end
		f14_arg0.progressBar:hide()
		if f14_arg1.button.showProgressBar then
			f14_arg0.progressBar:show()
			f14_arg0.progressBar:update(f14_arg1.button.challengeValue, f14_arg1.button.maxVal)
		end
		CoD.CACReticles.UpdateReticlePreview(f14_arg0, f14_arg1.button, f14_arg1.controller)
		if f14_arg1.button.lockImage and not f14_arg1.button.overrideLock then
			f14_arg0:dispatchEventToParent({
				name = "remove_select_button"
			})
		end
	else
		f14_arg0.reticleTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f14_arg0.reticleDescription:setText("")
	end
end

CoD.CACReticles.ContentButtonSelected = function (f15_arg0, f15_arg1)
	if f15_arg1.button.lockImage and f15_arg1.button.customEvent then
		f15_arg0:dispatchEventToParent({
			name = f15_arg1.button.customEvent,
			controller = f15_arg1.controller
		})
	elseif f15_arg1.button.mtxImage then
		local f15_local0 = CoD.CACUtility.GetWeaponOptionMTXName(f15_arg1.button.weaponOption)
		if not Engine.HasMTX(f15_arg1.controller, f15_local0) then
			CoD.CACReticles.WeaponOptionToGainFocus = f15_arg1.button.weaponOption
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
						mtxName = f15_local0,
						openingMenuName = "reticle"
					}
				})
			else
				Engine.PurchaseMTX(f15_arg1.controller, f15_local0, "reticle")
			end
		end
	else
		local f15_local0 = f15_arg0.m_ownerController
		local f15_local1 = f15_arg1.button.weaponOption
		local f15_local2 = f15_arg1.button.reticleIndex
		CoD.perController[f15_local0].chosenItem = f15_local1
		CoD.perController[f15_local0].reticleIndex = f15_local2
		f15_arg0:processEvent({
			name = "equip",
			controller = f15_arg0.m_ownerController,
			button = f15_arg1.button
		})
	end
end

CoD.CACReticles.Equip = function (f16_arg0, f16_arg1)
	local f16_local0 = f16_arg1.controller
	local f16_local1 = CoD.perController[f16_local0].classNum
	local f16_local2 = CoD.perController[f16_local0].weaponSlot
	local f16_local3 = CoD.perController[f16_local0].chosenItem
	local f16_local4 = CoD.perController[f16_local0].reticleIndex
	CoD.perController[f16_local0].chosenItem = nil
	if f16_local3 then
		Engine.SetClassItem(f16_local0, f16_local1, f16_local2 .. "reticle", f16_local3)
		CoD.CACReticles.UpdateReticlePreview(f16_arg0, f16_arg1.button, f16_local0)
		f16_arg0:dispatchEventToChildren({
			name = "update_class",
			controller = f16_local0,
			equippedWeaponOption = f16_local3
		})
	end
	f16_arg0:dispatchEventToParent({
		name = "button_prompt_back",
		controller = f16_local0
	})
end

CoD.CACReticles.HandleMTXChanged = function (f17_arg0, f17_arg1)
	if f17_arg1.controller ~= f17_arg0.m_ownerController then
		return 
	end
	local f17_local0 = CoD.CACReticles.WeaponOptionToGainFocus
	if f17_local0 then
		local f17_local1 = tonumber(UIExpression.TableLookup(nil, "mp/attachmenttable.csv", 0, weaponOption, 5)) or 0
		local f17_local2 = nil
		if f17_local1 > 0 then
			CoD.CACReticles.SetupDlc2Tab(f17_arg0, f17_arg1)
			f17_local2 = f17_arg0.dlc2ReticleTabContainer
		else
			CoD.CACReticles.SetupDlcTab(f17_arg0, f17_arg1)
			f17_local2 = f17_arg0.dlcReticleTabContainer
		end
		local f17_local3 = nil
		if f17_local2 and f17_local2.contentGrid then
			for f17_local7, f17_local8 in ipairs(f17_local2.contentGrid.buttons) do
				if f17_local3 == nil then
					f17_local3 = f17_local8
				end
				if f17_local8.weaponOption == f17_local0 then
					f17_local3 = f17_local8
				else
					f17_local8:processEvent({
						name = "lose_focus",
						controller = f17_arg1.controller
					})
				end
			end
		end
		if f17_local3 then
			f17_local3:processEvent({
				name = "gain_focus",
				controller = f17_arg1.controller
			})
		end
	end
end

CoD.CACReticles.OpenMTXPurchase = function (f18_arg0, f18_arg1)
	f18_arg0:openPopup("MTXPurchase", f18_arg1.controller, f18_arg1.userData)
end

CoD.CACReticles.OpenNoGuestMTX = function (f19_arg0, f19_arg1)
	local f19_local0 = f19_arg0:openPopup("Error", controller)
	f19_local0:setMessage(Engine.Localize("XBOXLIVE_NOGUESTACCOUNTS"))
end

