require("T6.Menus.CRCommon")
CoD.CRMedals = {}
local f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg0.medalHitCount:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	CoD.ContentGridButton.ButtonOver(f1_arg0, f1_arg1)
end

local f0_local1 = function (f2_arg0, f2_arg1)
	f2_arg0.medalHitCount:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	CoD.ContentGridButton.LoseFocus(f2_arg0, f2_arg1)
end

local f0_local2 = function (f3_arg0)
	local f3_local0 = 80
	local f3_local1 = f3_local0
	local f3_local2 = 5
	f3_arg0.button.itemImage = LUI.UIStreamedImage.new()
	f3_arg0.button.itemImage:setTopBottom(true, false, f3_local2, f3_local2 + f3_local0)
	f3_arg0.button.itemImage:setLeftRight(false, false, -f3_local1 / 2, f3_local1 / 2)
	f3_arg0.button.itemImage:setPriority(-70)
	f3_arg0.button:addElement(f3_arg0.button.itemImage)
end

local f0_local3 = function (f4_arg0)
	local f4_local0 = "Default"
	local f4_local1 = 23
	local f4_local2 = 5
	local f4_local3 = LUI.UIText.new()
	f4_local3:setLeftRight(true, true, 0, -f4_local2)
	f4_local3:setTopBottom(false, true, -f4_local1 - CoD.textSize[f4_local0], -f4_local1)
	f4_local3:setAlignment(LUI.Alignment.Center)
	f4_local3:setFont(CoD.fonts[f4_local0])
	f4_local3:setText("")
	f4_arg0.button.medalHitCount = f4_local3
	f4_arg0.button:addElement(f4_local3)
end

local f0_local4 = function (f5_arg0, f5_arg1)
	f0_local3(f5_arg1)
	f0_local2(f5_arg1)
	CoD.ContentGridButton.SetupButtonText(f5_arg1.button, "")
	CoD.ContentGridButton.SetupButtonImages(f5_arg1.button, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
	f5_arg1.button:registerEventHandler("button_over", f0_local0)
	f5_arg1.button:registerEventHandler("button_up", f0_local1)
end

local f0_local5 = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = Engine.GetCombatRecordSortedItemInfo(f6_arg1.m_index - 1)
	local f6_local1 = f6_local0.itemIndex
	local f6_local2 = f6_local0.itemValue
	local f6_local3 = UIExpression.TableLookupGetColumnValueForRow(f6_arg0, CoD.scoreInfoTable, f6_local1, CoD.AfterActionReport.medalStringCol)
	local f6_local4 = UIExpression.TableLookupGetColumnValueForRow(f6_arg0, CoD.scoreInfoTable, f6_local1, CoD.AfterActionReport.medalImageMaterialNameCol)
	f6_arg1.button.medalHitCount:setText("x" .. f6_local2)
	f6_arg1.button.itemImage:addElement(CoD.GetSpinnerWaitingOnEvent("streamed_image_ready", 64))
	f6_arg1.button.itemImage:setImage(RegisterMaterial(f6_local4))
	f6_arg1.button.itemImage:setupUIStreamedImage(0)
	f6_arg1.button.itemNameText:setText(Engine.Localize(f6_local3))
end

local f0_local6 = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg1.controller
	local f7_local1 = Engine.GetCombatRecordSortedItemInfo(f7_arg1.index - 1)
	local f7_local2 = f7_local1.itemIndex
	local f7_local3 = f7_local1.itemValue
	local f7_local4 = UIExpression.TableLookupGetColumnValueForRow(f7_local0, CoD.scoreInfoTable, f7_local2, CoD.AfterActionReport.medalStringCol)
	f7_arg0.medalPreviewImage:setImage(RegisterMaterial(UIExpression.TableLookupGetColumnValueForRow(f7_local0, CoD.scoreInfoTable, f7_local2, CoD.AfterActionReport.medalImageMaterialNameCol)))
	f7_arg0.medalPreviewImage:show()
	f7_arg0.medalNameText:setText(Engine.Localize(f7_local4))
	f7_arg0.medalDescText:setText(Engine.Localize(f7_local4 .. "_DESC"))
	f7_arg0.timesEarnedLabel:setText(Engine.Localize("MENU_TIMES_EARNED"))
	f7_arg0.timesEarnedText:setText(f7_local3)
end

local f0_local7 = function (f8_arg0)
	local f8_local0 = LUI.UIVerticalList.new()
	f8_local0:setLeftRight(true, true, 0, 0)
	f8_local0:setTopBottom(true, true, 0, 0)
	f8_arg0:addElement(f8_local0)
	local f8_local1 = 140
	local f8_local2 = 140
	local f8_local3 = LUI.UIImage.new()
	f8_local3:setLeftRight(false, false, -f8_local1 / 2, f8_local1 / 2)
	f8_local3:setTopBottom(true, false, 0, f8_local2)
	f8_arg0.medalPreviewImage = f8_local3
	f8_local3:hide()
	f8_local0:addSpacer(20)
	f8_local0:addElement(f8_local3)
	f8_local0:addSpacer(20)
	local f8_local4 = CoD.AARPopup.GetBoxText("Condensed", "", 0)
	f8_local4:setAlignment(LUI.Alignment.Left)
	f8_arg0.medalNameText = f8_local4
	f8_local0:addElement(f8_local4)
	local f8_local5 = CoD.AARPopup.GetBoxText("ExtraSmall", "", 0)
	f8_local5:setAlignment(LUI.Alignment.Left)
	f8_arg0.medalDescText = f8_local5
	f8_local0:addElement(f8_local5)
	f8_local0:addSpacer(50)
	local f8_local6 = CoD.AARPopup.GetBoxText("ExtraSmall", "", 0)
	f8_local6:setAlignment(LUI.Alignment.Left)
	f8_arg0.timesEarnedLabel = f8_local6
	f8_local0:addElement(f8_local6)
	local f8_local7 = CoD.AARPopup.GetBoxText("Big", "", 0)
	f8_local7:setAlignment(LUI.Alignment.Left)
	f8_arg0.timesEarnedText = f8_local7
	f8_local0:addElement(f8_local7)
	f8_local0:addSpacer(20)
	f8_arg0:registerEventHandler("grid_focus_changed", f0_local6)
end

local f0_local8 = function (f9_arg0, f9_arg1)
	f9_arg0:dispatchEventToChildren({
		name = f9_arg1.name,
		index = f9_arg1.index,
		controller = f9_arg0.m_ownerController
	})
end

CoD.CRMedals.SetupMedalsGrid = function (f10_arg0, f10_arg1)
	local f10_local0 = CoD.Menu.TitleHeight + 60
	f10_arg0.tabManager = CoD.TabManager.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f10_local0 - CoD.ButtonPrompt.Height,
		bottom = f10_local0
	}, nil, LUI.Alignment.Right)
	f10_arg0:addElement(f10_arg0.tabManager)
	f10_arg0:registerEventHandler("grid_focus_changed", f0_local8)
	local f10_local1 = 0
	local f10_local2 = 130
	local f10_local3 = 100
	local f10_local4 = 240
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f10_local4)
	Widget:setTopBottom(true, true, f10_local2, -f10_local3)
	f10_arg0:addElement(Widget)
	f0_local7(Widget)
	f10_local1 = f10_local1 + f10_local4 + 20
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f10_local1, 0)
	Widget:setTopBottom(true, true, f10_local2, -f10_local3)
	f10_arg0.medalGridBox = Widget
	f10_arg0:addElement(Widget)
	local f10_local7 = 3
	local f10_local8 = 3
	local f10_local9 = 175
	local f10_local10 = 130
	local f10_local11 = 18
	local f10_local12 = CoD.ScrollableContentGrid.new(f10_arg0.m_ownerController, {
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = false,
		left = 0,
		right = 0,
		top = 0,
		bottom = f10_local10 * f10_local7 + f10_local11 * (f10_local7 - 1) + 10
	}, f10_local7, f10_local8, f0_local4, f0_local5, f10_local9, f10_local10, f10_local11)
	Engine.SortItemsForCombatRecord(f10_arg0.m_ownerController, CoD.CRCommon.SortTypes.MEDALS, CoD.CRCommon.OtherPlayerCRMode == true, CoD.CRCommon.MedalCategories.CATEGORY_COMBAT)
	local f10_local13 = Engine.GetCombatRecordSortedItemInfo(0)
	Widget:addElement(f10_local12)
	f10_local12:setTotalItems(f10_local13.numItems)
	f10_arg0.scrollableGrid = f10_local12
	f10_arg0.tabManager:addTab(UIExpression.ToUpper(nil, Engine.Localize("MENU_COMBAT_CAPS")))
	f10_arg0.tabManager:addTab(UIExpression.ToUpper(nil, Engine.Localize("MENU_SCORESTREAKS")))
	f10_arg0.tabManager:addTab(UIExpression.ToUpper(nil, Engine.Localize("MENU_ANTISCORESTREAK")))
	f10_arg0.tabManager:addTab(UIExpression.ToUpper(nil, Engine.Localize("MENU_CHALLENGES_GAME_MODES")))
	f10_arg0.tabManager:setCurrentTab()
end

CoD.CRMedals.SetupElements = function (f11_arg0, f11_arg1)
	if CoD.CRCommon.CurrentXuid and CoD.CRCommon.CurrentXuid ~= "" and CoD.CRCommon.CurrentXuid ~= "0" then
		f11_arg0:addElement(CoD.MiniIdentity.GetMiniIdentity(f11_arg1, CoD.CRCommon.CurrentXuid))
	end
	CoD.CRMedals.SetupMedalsGrid(f11_arg0, f11_arg1)
end

CoD.CRMedals.TabChanged = function (f12_arg0, f12_arg1)
	Engine.SortItemsForCombatRecord(f12_arg0.m_ownerController, CoD.CRCommon.SortTypes.MEDALS, CoD.CRCommon.OtherPlayerCRMode == true, f12_arg1.tabIndex)
	local f12_local0 = Engine.GetCombatRecordSortedItemInfo(0)
	f12_arg0.scrollableGrid:setTotalItems(f12_local0.numItems)
end

LUI.createMenu.CRMedals = function (f13_arg0)
	local f13_local0 = CoD.Menu.New("CRMedals")
	f13_local0:addLargePopupBackground()
	f13_local0:setOwner(f13_arg0)
	f13_local0:setPreviousMenu("Barracks")
	f13_local0:addBackButton()
	f13_local0:addTitle(Engine.Localize("MPUI_MEDALS_CAPS"))
	f13_local0:registerEventHandler("tab_changed", CoD.CRMedals.TabChanged)
	CoD.CRMedals.SetupElements(f13_local0, f13_arg0)
	return f13_local0
end

