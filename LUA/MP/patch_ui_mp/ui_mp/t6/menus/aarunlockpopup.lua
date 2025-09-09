CoD.AARPopup = {}
CoD.AARPopup.OpenPromotionPopup = function ()
	local f1_local0 = CoD.AfterActionReport.Stats
	return f1_local0.displayLevelForRankBeforeMatch < f1_local0.displayLevelForCurrRank
end

CoD.AARPopup.OpenMasterPopup = function ()
	local f2_local0 = CoD.AfterActionReport.Stats
	local f2_local1
	if f2_local0.currPrestige ~= tonumber(CoD.MAX_PRESTIGE) - 1 or CoD.MAX_RANKXP > f2_local0.currRankXP then
		f2_local1 = false
	else
		f2_local1 = true
	end
	return f2_local1
end

CoD.AARPopup.OpenFeaturesPopup = function ()
	return CoD.AfterActionReport.Stats.numFeaturesUnlocked > 0
end

CoD.AARPopup.OpenContentPopup = function ()
	local f4_local0 = CoD.AfterActionReport.Stats
	local f4_local1 = 0
	local f4_local2 = 0
	if f4_local0 then
		if f4_local0.numItemUnlocks then
			f4_local2 = f4_local0.numItemUnlocks
		end
		if f4_local0.recentChallenges then
			f4_local1 = #f4_local0.recentChallenges
		end
	end
	local f4_local3
	if f4_local2 <= 0 and f4_local1 <= 0 then
		f4_local3 = false
	else
		f4_local3 = true
	end
	return f4_local3
end

CoD.AARPopup.OpenAttachmentsPopup = function ()
	return CoD.AfterActionReport.Stats.anyAttachmentsUnlocked
end

CoD.AARPopup.PopupInfo = {
	{
		name = "AfterActionReport",
		checkFunction = nil
	},
	{
		name = "AARPromotion",
		checkFunction = CoD.AARPopup.OpenPromotionPopup
	},
	{
		name = "AARMaster",
		checkFunction = CoD.AARPopup.OpenMasterPopup
	},
	{
		name = "AARNewFeatures",
		checkFunction = CoD.AARPopup.OpenFeaturesPopup
	},
	{
		name = "AARNewContent",
		checkFunction = CoD.AARPopup.OpenContentPopup
	},
	{
		name = "AARNewAttachments",
		checkFunction = CoD.AARPopup.OpenAttachmentsPopup
	}
}
CoD.AARPopup.GetNextPopupToOpen = function (f6_arg0)
	local f6_local0 = CoD.AARPopup.PopupInfo
	local f6_local1 = nil
	for f6_local9, f6_local10 in ipairs(f6_local0) do
		if f6_local10.name == f6_arg0 then
			f6_local1 = f6_local9
		end
		if f6_local1 and f6_local1 < #f6_local0 then
			for f6_local5 = f6_local1 + 1, #f6_local0, 1 do
				local f6_local8 = f6_local0[f6_local5]
				if f6_local8.checkFunction and f6_local8.checkFunction() then
					return f6_local8.name
				end
			end
		end
	end
end

CoD.AARPopup.OpenLeaguePromotionPopup = function (f7_arg0)
	CoD.LeaguePromotionStatus = Engine.CheckLeagueDivisionChange(f7_arg0)
	if CoD.LeaguePromotionStatus ~= "unknown" and CoD.LeaguePromotionStatus ~= "unchanged" then
		return true
	else
		return false
	end
end

CoD.AARPopup.AARPopupContinueToNext = function (f8_arg0, f8_arg1)
	local f8_local0 = nil
	local f8_local1 = CoD.AARPopup.GetNextPopupToOpen(f8_arg0.menuName)
	if f8_local1 then
		f8_local0 = f8_arg0:openMenu(f8_local1, f8_arg1.controller)
	end
	if f8_local0 then
		f8_local0:setPreviousMenu(nil)
		f8_arg0:close()
		Engine.PlaySound("cac_grid_equip_item")
	else
		f8_arg0:processEvent({
			name = "button_prompt_back",
			controller = f8_arg1.controller
		})
	end
end

local f0_local0 = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	local f9_local0 = LUI.UIText.new()
	f9_local0:setLeftRight(true, true, 0, 0)
	f9_local0:setTopBottom(true, false, f9_arg0, f9_arg0 + CoD.textSize[f9_arg1])
	f9_local0:setFont(CoD.fonts[f9_arg1])
	f9_local0:setAlignment(LUI.Alignment.Center)
	f9_local0:setText(f9_arg2)
	if f9_arg3 then
		f9_local0:setRGB(f9_arg3.r, f9_arg3.g, f9_arg3.b)
	end
	return f9_local0
end

local f0_local1 = function (f10_arg0)
	f10_arg0.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	f10_arg0:addElement(f10_arg0.border)
	f10_arg0.border.bottomBorder:close()
	f10_arg0.border.bottomBorder = LUI.UIImage.new()
	f10_arg0.border.bottomBorder:setLeftRight(true, true, 0, 0)
	f10_arg0.border.bottomBorder:setTopBottom(false, true, -16, 0)
	f10_arg0.border.bottomBorder:setImage(RegisterMaterial("menu_sp_cac_single_dip"))
	f10_arg0.border:addElement(f10_arg0.border.bottomBorder)
end

LUI.createMenu.AARLeaguePromotion = function (f11_arg0)
	local f11_local0 = CoD.Menu.NewMediumPopup("AARLeaguePromotion")
	local f11_local1 = "uin_rank_promotion"
	local f11_local2 = "uin_rank_demotion"
	f11_local0.continueButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_CONTINUE_CAPS"), f11_local0, "button_prompt_back")
	f11_local0.invisibleBackButton = CoD.ButtonPrompt.new("secondary", "", f11_local0, "button_prompt_back", true)
	f11_local0:addLeftButtonPrompt(f11_local0.continueButton)
	f11_local0:addLeftButtonPrompt(f11_local0.invisibleBackButton)
	local f11_local3 = Engine.GetLeagueStats(f11_arg0)
	local f11_local4 = "MENU_DIVISION_TRANSFER"
	if CoD.LeaguePromotionStatus == "placed" then
		f11_local4 = "MENU_DIVISION_PLACEMENT"
		Engine.PlaySound(f11_local1)
	elseif CoD.LeaguePromotionStatus == "promoted" then
		f11_local4 = "MENU_DIVISION_PROMOTION"
		Engine.PlaySound(f11_local1)
	else
		Engine.PlaySound(f11_local2)
	end
	f11_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize(f11_local4)))
	local f11_local5 = 70
	local f11_local6 = 135
	local f11_local7 = 320
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f11_local7 / 2, f11_local7 / 2)
	Widget:setTopBottom(true, true, f11_local5, -f11_local5)
	local f11_local9 = 0
	Widget:addElement(f0_local0(f11_local9, "ExtraSmall", Engine.Localize(f11_local4 .. "_DESC"), CoD.gray))
	f11_local9 = f11_local9 + CoD.textSize.ExtraSmall + 10
	local Widget = LUI.UIElement.new()
	local f11_local11 = f11_local6 + 30
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f11_local9, f11_local9 + f11_local11)
	f0_local1(Widget)
	Widget:addElement(Widget)
	local f11_local12 = LUI.UIImage.new()
	f11_local12:setLeftRight(false, false, -f11_local6 / 2, f11_local6 / 2)
	f11_local12:setTopBottom(true, false, 10, 10 + f11_local6)
	f11_local12:setImage(f11_local3.divisionIcon)
	Widget:addElement(f11_local12)
	f11_local9 = f11_local9 + f11_local11 - 5
	Widget:addElement(f0_local0(f11_local9, "Condensed", f11_local3.divisionName))
	f11_local9 = f11_local9 + CoD.textSize.Condensed
	Widget:addElement(f0_local0(f11_local9, "ExtraSmall", Engine.Localize("MENU_SUBDIVISION") .. ": " .. f11_local3.subdivisionName))
	Widget:addElement(f0_local0(f11_local9 + CoD.textSize.ExtraSmall + 10, "Condensed", Engine.Localize("LEAGUE_RANK", f11_local3.rank)))
	f11_local0:addElement(Widget)
	return f11_local0
end

CoD.AARPopup.GetBoxText = function (f12_arg0, f12_arg1, f12_arg2, f12_arg3)
	local f12_local0 = LUI.UIText.new()
	if f12_arg3 then
		f12_local0:setLeftRight(true, true, -f12_arg3, f12_arg3)
	else
		f12_local0:setLeftRight(true, true, 0, 0)
	end
	f12_local0:setTopBottom(true, false, f12_arg2, f12_arg2 + CoD.textSize[f12_arg0])
	f12_local0:setText(f12_arg1)
	f12_local0:setFont(CoD.fonts[f12_arg0])
	f12_local0:setAlignment(LUI.Alignment.Center)
	return f12_local0
end

CoD.AARPopup.GetBox = function (f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4, f13_arg5, f13_arg6, f13_arg7, f13_arg8, f13_arg9)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f13_arg0)
	Widget:setTopBottom(true, false, 0, f13_arg1)
	Widget:addElement(CoD.GetInformationContainer())
	if f13_arg2 then
		local f13_local1 = nil
		if f13_arg8 then
			f13_local1 = LUI.UIStreamedImage.new(nil, nil, true)
		else
			f13_local1 = LUI.UIImage.new()
		end
		f13_local1:setLeftRight(false, false, -f13_arg4 / 2, f13_arg4 / 2)
		f13_local1:setTopBottom(false, false, -f13_arg3 / 2, f13_arg3 / 2)
		if f13_arg2 then
			f13_local1:setImage(RegisterMaterial(f13_arg2))
		end
		Widget:addElement(f13_local1)
	end
	if f13_arg5 then
		Widget:addElement(CoD.AARPopup.GetBoxText("Big", f13_arg5, f13_arg1 / 2 - CoD.textSize.Big / 2))
	end
	if f13_arg6 then
		Widget:addElement(CoD.AARPopup.GetBoxText("Condensed", f13_arg6, f13_arg1))
	end
	local f13_local1 = 0
	if f13_arg9 then
		f13_local1 = f13_arg9
	end
	if f13_arg7 then
		Widget:addElement(CoD.AARPopup.GetBoxText("ExtraSmall", f13_arg7, f13_arg1 + CoD.textSize.Condensed + f13_local1, 10))
	end
	return Widget
end

local f0_local2 = function (f14_arg0, f14_arg1)
	local f14_local0 = 180
	local f14_local1 = 90
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f14_local1, f14_local1 + f14_local0)
	local f14_local3 = LUI.UIHorizontalList.new()
	f14_local3:setLeftRight(true, true, 0, 0)
	f14_local3:setTopBottom(true, true, 0, 0)
	f14_local3:setSpacing(30)
	f14_local3:setAlignment(LUI.Alignment.Center)
	local f14_local4 = 120
	local f14_local5 = 120
	local f14_local6 = CoD.AfterActionReport.Stats
	local f14_local7 = f14_local6.statsBeforeMatch
	local f14_local8 = f14_local6.currentStats
	local f14_local9 = f14_local6.rankBeforematch
	local f14_local10 = f14_local6.currentRank
	local f14_local11 = f14_local6.displayLevelForRankBeforeMatch
	local f14_local12 = f14_local6.displayLevelForCurrRank
	local f14_local13 = f14_local6.currPrestige
	local f14_local14 = f14_local6.currRankIconMaterialName
	local f14_local15 = f14_local6.currRankName
	if f14_local11 < f14_local12 then
		f14_local3:addElement(CoD.AARPopup.GetBox(f14_local0, f14_local0, f14_local14 .. "_128", f14_local4, f14_local5, nil, Engine.Localize("MENU_LEVEL") .. " " .. f14_local12, Engine.Localize(f14_local15), true))
	end
	local f14_local16 = UIExpression.GetRecentUnlocks(f14_arg1)
	if f14_local16 > 0 then
		local f14_local17 = "MENU_UNLOCK_TOKEN_EARNED"
		if f14_local16 > 1 then
			f14_local17 = "MENU_UNLOCK_TOKENS_EARNED"
		end
		f14_local3:addElement(CoD.AARPopup.GetBox(f14_local0, f14_local0, CoD.AfterActionReport.TokenImageMaterialName128, f14_local4, f14_local5, nil, f14_local16, Engine.Localize(f14_local17)))
	end
	Widget:addElement(f14_local3)
	f14_arg0:addElement(Widget)
	f14_arg0.xpBarWidget = CoD.AfterActionReport.GetXPBarWidget(f14_arg1)
	f14_arg0:addElement(f14_arg0.xpBarWidget)
	f14_arg0:registerEventHandler("animate_xp_bar", CoD.AfterActionReport.AnimateXPBarWidget)
	f14_arg0:processEvent({
		name = "animate_xp_bar"
	})
end

LUI.createMenu.AARPromotion = function (f15_arg0)
	local f15_local0 = CoD.Menu.NewMediumPopup("AARPromotion")
	f15_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_PROMOTION")))
	CoD.AfterActionReport.AddButtonPrompts(f15_local0, "continue_to_next")
	f15_local0:registerEventHandler("continue_to_next", CoD.AARPopup.AARPopupContinueToNext)
	f15_local0.animateIn = CoD.NullFunction
	f0_local2(f15_local0, f15_arg0)
	return f15_local0
end

local f0_local3 = function (f16_arg0, f16_arg1)
	local f16_local0 = 200
	local f16_local1 = 70
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f16_local1, f16_local1 + f16_local0)
	local f16_local3 = LUI.UIHorizontalList.new()
	f16_local3:setLeftRight(true, true, 0, 0)
	f16_local3:setTopBottom(true, true, 0, 0)
	f16_local3:setSpacing(30)
	f16_local3:setAlignment(LUI.Alignment.Center)
	local f16_local4 = 128
	local f16_local5 = 128
	local f16_local6 = UIExpression.TableLookup(f16_arg1, CoD.rankIconTable, CoD.AfterActionReport.RankIdCol, CoD.AfterActionReport.Stats.currentRank, tonumber(CoD.MAX_PRESTIGE) + 1)
	local f16_local7 = Engine.GetPlayerStats(f16_arg1)
	f16_local7.playerStatsList.PLEVEL.statValue:set(tonumber(CoD.MAX_PRESTIGE))
	f16_local3:addElement(CoD.AARPopup.GetBox(f16_local0 + 32, f16_local0, f16_local6 .. "_128", f16_local4, f16_local5, nil, Engine.Localize("MENU_MASTER"), Engine.Localize("MENU_MASTER_DESC"), true))
	Widget:addElement(f16_local3)
	f16_arg0:addElement(Widget)
end

LUI.createMenu.AARMaster = function (f17_arg0)
	local f17_local0 = CoD.Menu.NewMediumPopup("AARMaster")
	f17_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_MAXIMUM_LEVEL")))
	CoD.AfterActionReport.AddButtonPrompts(f17_local0, "continue_to_next")
	f17_local0:registerEventHandler("continue_to_next", CoD.AARPopup.AARPopupContinueToNext)
	f17_local0.animateIn = CoD.NullFunction
	f0_local3(f17_local0, f17_arg0)
	return f17_local0
end

local f0_local4 = function (f18_arg0, f18_arg1)
	local f18_local0 = 260
	local f18_local1 = 250
	local f18_local2 = 90
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f18_local2, f18_local2 + f18_local1)
	local f18_local4 = LUI.UIHorizontalList.new()
	f18_local4:setLeftRight(true, true, 0, 0)
	f18_local4:setTopBottom(true, true, 0, 0)
	f18_local4:setSpacing(10)
	f18_local4:setAlignment(LUI.Alignment.Center)
	local f18_local5 = UIExpression.GetNumFeatureUnlocks(f18_arg1)
	local f18_local6, f18_local7 = nil
	if f18_local5 > 3 then
		f18_local5 = 3
	end
	for f18_local8 = 0, f18_local5 - 1, 1 do
		f18_local6 = UIExpression.ToUpper(f18_arg1, Engine.Localize(UIExpression.GetItemName(f18_arg1, UIExpression.GetUnlockedFeatureItemIndex(f18_arg1, f18_local8))))
		f18_local7 = Engine.Localize(UIExpression.GetItemDesc(f18_arg1, UIExpression.GetUnlockedFeatureItemIndex(f18_arg1, f18_local8)))
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, 0, f18_local0)
		Widget:setTopBottom(true, false, 0, f18_local1)
		Widget:addElement(CoD.GetInformationContainer())
		local f18_local12 = CoD.GetTextElem("Big", "Center", f18_local6, nil, 20)
		f18_local12:setLeftRight(true, true, 10, -10)
		Widget:addElement(f18_local12)
		local f18_local13 = CoD.GetTextElem("Default", "Center", f18_local7)
		f18_local13:setTopBottom(false, true, -60 - CoD.textSize.Default, -60)
		f18_local13:setLeftRight(true, true, 10, -10)
		Widget:addElement(f18_local13)
		f18_local4:addElement(Widget)
		f18_local4:addSpacer(10)
	end
	Widget:addElement(f18_local4)
	f18_arg0:addElement(Widget)
end

LUI.createMenu.AARNewFeatures = function (f19_arg0)
	local f19_local0 = CoD.Menu.NewMediumPopup("AARNewFeatures")
	f19_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_NEW_FEATURES")))
	CoD.AfterActionReport.AddButtonPrompts(f19_local0, "continue_to_next")
	f19_local0:registerEventHandler("continue_to_next", CoD.AARPopup.AARPopupContinueToNext)
	f19_local0.animateIn = CoD.NullFunction
	f0_local4(f19_local0, f19_arg0)
	return f19_local0
end

local f0_local5 = function (f20_arg0, f20_arg1)
	local f20_local0 = f20_arg0.itemIndex
	if f20_arg0.camoName ~= nil and f20_arg0.itemName ~= nil then
		f20_arg0.title:setText(Engine.Localize("MENU_X_COLON_Y", f20_arg0.itemName, f20_arg0.camoName))
	end
	if f20_local0 and UIExpression.IsItemLocked(f20_arg1.controller, f20_local0) == 0 and UIExpression.IsItemPurchased(f20_arg1.controller, f20_local0) == 0 and UIExpression.GetItemCost(f20_arg1.controller, f20_local0) > 0 then
		f20_arg0:dispatchEventToParent({
			name = "add_purchase_button_prompt",
			controller = f20_arg1.controller,
			itemIndex = f20_local0,
			card = f20_arg0
		})
	else
		f20_arg0:dispatchEventToParent({
			name = "remove_purchase_button_prompt",
			controller = f20_arg1.controller
		})
	end
	f20_arg0:dispatchEventToParent({
		name = "set_desc_and_xp_reward",
		desc = f20_arg0.desc,
		xpRewardText = f20_arg0.xpRewardText,
		menuHeader = f20_arg0.menuHeader
	})
	CoD.CardCarousel.Card_GainFocus(f20_arg0, f20_arg1)
end

local f0_local6 = function (f21_arg0, f21_arg1)
	if f21_arg0.camoName ~= nil and f21_arg0.itemName ~= nil then
		f21_arg0.title:setText(Engine.Localize(f21_arg0.camoName))
	end
	CoD.CardCarousel.Card_LoseFocus(f21_arg0, f21_arg1)
end

local f0_local7 = function (f22_arg0, f22_arg1, f22_arg2, f22_arg3, f22_arg4)
	CoD.ContentGridButton.SetupButtonImages(f22_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
	local f22_local0 = CoD.AfterActionReport.NewContentItemWidth
	local f22_local1 = CoD.AfterActionReport.NewContentItemHeight
	local f22_local2 = f22_arg2.itemIndex
	f22_arg0.itemIndex = f22_arg2.itemIndex
	f22_arg0.isReward = f22_arg2.isReward
	local f22_local3 = 170
	local f22_local4 = 90
	local f22_local5 = 1.5
	if f22_arg4 then
		if f22_arg4.width then
			f22_local3 = f22_arg4.width
		end
		if f22_arg4.height then
			f22_local4 = f22_arg4.height
		end
	end
	local f22_local6 = LUI.UIImage.new()
	f22_arg0:setupCenterImage(f22_arg3, f22_local3, f22_local4, f22_local5)
	local Widget = LUI.UIElement.new()
	local f22_local8 = CoD.textSize.Default
	Widget:setLeftRight(true, true, 5, 0)
	Widget:setTopBottom(false, true, -f22_local8 - 2, -2)
	f22_arg0:addElement(Widget)
	local f22_local9 = LUI.UIText.new()
	f22_local9:setLeftRight(true, true, 5, 0)
	f22_local9:setTopBottom(true, true, 0, 0)
	f22_local9:setFont(CoD.fonts.Default)
	f22_local9:setAlignment(LUI.Alignment.Left)
	f22_local9:setText(Engine.Localize(f22_arg2.itemName))
	f22_arg0.title = f22_local9
	Widget:addElement(f22_local9)
	f22_arg0.title:registerAnimationState("button_over", {
		red = CoD.BOIIOrange.r,
		green = CoD.BOIIOrange.g,
		blue = CoD.BOIIOrange.b
	})
	LUI.UIButton.SetupElement(f22_arg0.title)
	f22_arg0.desc = Engine.Localize(f22_arg2.itemDesc)
	local f22_local10 = LUI.UIImage.new()
	local f22_local11 = 32
	local f22_local12 = 8
	local f22_local13 = f22_local8 + 8
	f22_local10:setLeftRight(true, false, f22_local12, f22_local12 + f22_local11)
	f22_local10:setTopBottom(false, true, -f22_local13 - f22_local11, -f22_local13)
	f22_local10:setImage(RegisterMaterial(CoD.AfterActionReport.TokenImageMaterialName64))
	f22_arg0.tokenIcon = f22_local10
	if not f22_arg2.isReward and UIExpression.IsItemLocked(f22_arg1, f22_local2) == 0 and UIExpression.IsItemPurchased(f22_arg1, f22_local2) == 0 and UIExpression.GetItemCost(nil, f22_local2) > 0 then
		f22_arg0:addElement(f22_arg0.tokenIcon)
	end
	if f22_arg0.grid then
		f22_arg0.grid:close()
		f22_arg0.grid = nil
	end
	if f22_arg0.border then
		f22_arg0.border:close()
		f22_arg0.border = nil
	end
	f22_arg0:registerEventHandler("gain_focus", f0_local5)
	f22_arg0:registerEventHandler("lose_focus", f0_local6)
end

local f0_local8 = function (f23_arg0, f23_arg1)
	for f23_local4, f23_local5 in pairs(CoD.AfterActionReport.Stats.recentlyUnlockedItems) do
		if CoD.IsWeapon(f23_local5.itemIndex) then
			local f23_local3 = f23_arg0:addNewCard()
			f0_local7(f23_local3, f23_arg1, f23_local5, f23_local5.itemImage .. "_big")
			f23_local3.menuHeader = Engine.Localize("MENU_NEW_PRIMARY")
			if CoD.IsSecondaryWeapon(f23_local5.itemIndex) then
				f23_local3.menuHeader = Engine.Localize("MENU_NEW_SECONDARY")
			end
		end
	end
end

local f0_local9 = function (f24_arg0, f24_arg1)
	for f24_local4, f24_local5 in pairs(CoD.AfterActionReport.Stats.recentlyUnlockedItems) do
		if CoD.IsPerk(f24_local5.itemIndex) then
			local f24_local3 = f24_arg0:addNewCard()
			f0_local7(f24_local3, f24_arg1, f24_local5, f24_local5.itemImage .. "_256", {
				width = 90,
				height = 90
			})
			f24_local3.menuHeader = Engine.Localize("MENU_NEW_PERK")
		end
	end
end

local f0_local10 = function (f25_arg0, f25_arg1)
	for f25_local4, f25_local5 in pairs(CoD.AfterActionReport.Stats.recentlyUnlockedItems) do
		if CoD.IsReward(f25_local5.itemIndex) then
			local f25_local3 = f25_arg0:addNewCard()
			f0_local7(f25_local3, f25_arg1, f25_local5, f25_local5.itemImage .. "_menu", {
				width = 120,
				height = 120
			})
			f25_local3.menuHeader = Engine.Localize("MENU_NEW_SCORESTREAK")
		end
	end
end

local f0_local11 = function (f26_arg0, f26_arg1)
	for f26_local9, f26_local10 in pairs(CoD.AfterActionReport.Stats.recentlyUnlockedItems) do
		if CoD.IsBonusCard(f26_local10.itemIndex) then
			local f26_local3 = f26_arg0:addNewCard()
			f0_local7(f26_local3, f26_arg1, f26_local10, f26_local10.itemImage)
			f26_local3.menuHeader = Engine.Localize("MENU_NEW_WILDCARD")
			local f26_local4 = CoD.ContentGridButton.TitleHeight + 4
			local f26_local5 = CoD.AfterActionReport.NewContentItemHeight - f26_local4
			local f26_local6 = f26_local5 * 2
			local f26_local7 = CoD.AfterActionReport.NewContentHighligtedItemHeight - f26_local4
			local f26_local8 = f26_local7 * 2
			f26_local3.centerImageContainer:registerAnimationState("default", {
				leftAnchor = false,
				rightAnchor = false,
				left = -f26_local6 / 2,
				right = f26_local6 / 2,
				topAnchor = false,
				bottomAnchor = true,
				top = -f26_local4 - f26_local5,
				bottom = -f26_local4
			})
			f26_local3.centerImageContainer:registerAnimationState("big", {
				leftAnchor = false,
				rightAnchor = false,
				left = -f26_local8 / 2,
				right = f26_local8 / 2,
				topAnchor = false,
				bottomAnchor = true,
				top = -f26_local4 - f26_local7,
				bottom = -f26_local4
			})
			f26_local3.centerImageContainer:animateToState("default")
		end
	end
end

local f0_local12 = function (f27_arg0, f27_arg1)
	for f27_local4, f27_local5 in pairs(CoD.AfterActionReport.Stats.recentlyUnlockedItems) do
		if CoD.IsGrenade(f27_local5.itemIndex) then
			local f27_local3 = f27_arg0:addNewCard()
			f0_local7(f27_local3, f27_arg1, f27_local5, f27_local5.itemImage .. "_256", {
				width = 90,
				height = 90
			})
			f27_local3.menuHeader = Engine.Localize("MENU_NEW_LETHAL_GRENADE")
			if CoD.IsTacticalGrenade(f27_local5.itemIndex) then
				f27_local3.menuHeader = Engine.Localize("MENU_NEW_TACTICAL_GRENADE")
			end
		end
	end
end

local f0_local13 = function (f28_arg0, f28_arg1, f28_arg2)
	local f28_local0 = 80
	local f28_local1 = 80
	if not f28_arg2 then
		f28_local1 = 40
		f28_local0 = f28_local1 * 4
	end
	f28_arg0:setupCenterImage(nil, f28_local0, f28_local1, 1.8)
	f28_arg0.centerImageContainer.centerImage:close()
	local f28_local2 = LUI.UIImage.new()
	f28_local2:setLeftRight(true, true, 0, 0)
	f28_local2:setTopBottom(true, true, 0, 0)
	if f28_arg2 then
		f28_local2:setupDrawEmblemById(f28_arg1)
	else
		f28_local2:setupDrawBackgroundById(f28_arg1)
	end
	f28_arg0.centerImageContainer:addElement(f28_local2)
end

local f0_local14 = function (f29_arg0, f29_arg1, f29_arg2, f29_arg3, f29_arg4, f29_arg5)
	local f29_local0 = f29_arg3
	local f29_local1 = f29_arg2
	if f29_arg4 then
		local f29_local2 = 30
		f29_arg0:setupCenterImage(f29_arg1, f29_local1 * 2 + f29_local2, f29_local0, sizeMultiplier)
		f29_arg0.centerImageContainer.centerImage:close()
		local f29_local3 = LUI.UIImage.new()
		f29_local3:setLeftRight(false, false, -f29_local1 - f29_local2 / 2, -f29_local2 / 2)
		f29_local3:setTopBottom(false, false, -f29_local0 / 2, f29_local0 / 2)
		f29_local3:setImage(RegisterMaterial(f29_arg4))
		f29_arg0.centerImageContainer:addElement(f29_local3)
		local f29_local4 = LUI.UIImage.new()
		f29_local4:setLeftRight(false, false, f29_local2 / 2, f29_local1 + f29_local2 / 2)
		f29_local4:setTopBottom(false, false, -f29_local0 / 2, f29_local0 / 2)
		f29_local4:setImage(RegisterMaterial(f29_arg5))
		f29_arg0.centerImageContainer:addElement(f29_local4)
	else
		f29_arg0:setupCenterImage(f29_arg1, f29_local1, f29_local0, 1.8)
	end
end

local f0_local15 = function (f30_arg0, f30_arg1)
	if f30_arg0 == CoD.MILESTONE_WEAPON then
		return Engine.Localize(UIExpression.GetItemName(nil, f30_arg1))
	elseif f30_arg0 == CoD.MILESTONE_GROUP then
		return Engine.Localize("MPUI_" .. UIExpression.GetItemGroupByIndex(nil, f30_arg1))
	elseif f30_arg0 == CoD.MILESTONE_ATTACHMENTS then
		return Engine.Localize(UIExpression.GetAttachmentName(nil, f30_arg1))
	elseif f30_arg0 == CoD.MILESTONE_GAMEMODE then
		return Engine.Localize("MPUI_" .. Engine.GetGametypeName(f30_arg1))
	else
		return ""
	end
end

local f0_local16 = function (f31_arg0, f31_arg1, f31_arg2, f31_arg3)
	CoD.ContentGridButton.SetupButtonImages(f31_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
	local Widget = LUI.UIElement.new()
	local f31_local1 = CoD.textSize.ExtraSmall
	Widget:setLeftRight(true, true, 5, 0)
	Widget:setTopBottom(false, true, -f31_local1 - 2, -2)
	f31_arg0:addElement(Widget)
	if f31_arg2.row then
		local f31_local2 = f31_arg2.row
		local f31_local3 = "mp/statsmilestones" .. f31_arg2.tableNumber + 1 .. ".csv"
		local f31_local4 = UIExpression.TableLookupGetColumnValueForRow(f31_arg1, f31_local3, f31_local2, 5)
		local f31_local5 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f31_arg1, f31_local3, f31_local2, 2))
		local f31_local6 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f31_arg1, f31_local3, f31_local2, 6))
		local f31_local7 = UIExpression.TableLookupGetColumnValueForRow(f31_arg1, f31_local3, f31_local2, 9)
		local f31_local8 = f31_arg2.itemIndex
		local f31_local9 = f31_arg2.type
		local f31_local10 = false
		local f31_local11 = ""
		local f31_local12 = ""
		local f31_local13 = ""
		local f31_local14 = ""
		local f31_local15 = ""
		local f31_local16 = Engine.Localize("MENU_NEW_CONTENT")
		if f31_local6 and f31_local6 > 0 then
			f31_local15 = Engine.Localize("RANK_XP", f31_local6)
		end
		f31_local13 = f0_local15(f31_local9, f31_local8)
		f31_local10 = CoD.IsTieredChallenge(f31_arg1, f31_local3, f31_local2)
		f31_local12 = Engine.Localize(f31_local4, "", f31_local13, CoD.GetLocalizedTierText(f31_arg1, f31_local3, f31_local2))
		f31_local11 = Engine.Localize(f31_local4 .. "_DESC", f31_local5, f31_local13)
		if f31_arg3 and f31_arg2.unlockedImageID and f31_arg2.unlockedImageID > 0 then
			f0_local13(f31_arg0, f31_arg2.unlockedImageID, f31_arg2.unlockedImageIsEmblem)
			f31_local16 = Engine.Localize("MENU_NEW_BACKGROUND")
			if f31_arg2.unlockedImageIsEmblem then
				f31_local16 = Engine.Localize("MENU_NEW_EMBLEM")
			end
		elseif f31_local7 and string.find(f31_local7, "camo_") ~= nil then
			local f31_local17 = UIExpression.TableLookup(nil, CoD.attachmentTable, 4, f31_local7, 6)
			local f31_local18 = UIExpression.TableLookup(nil, CoD.attachmentTable, 4, f31_local7, 3)
			local f31_local19 = 40
			f0_local14(f31_arg0, f31_local17, f31_local19 * 4, f31_local19)
			f31_local12 = Engine.Localize(f31_local18)
			f31_local11 = Engine.Localize(f31_local4 .. "_DESC", f31_local5, f31_local13)
			f31_local16 = Engine.Localize("MENU_NEW_CAMOUFLAGE")
			f31_arg0.camoName = f31_local18
			f31_arg0.itemName = f31_local13
		elseif f31_local7 and string.find(f31_local7, "reticle_") ~= nil then
			local f31_local17 = string.gsub(f31_local7, "reticle_", "")
			local f31_local18 = CoD.CACUtility.attachmentReferences[f31_local8 + 1]
			local f31_local19 = f31_local18 .. "_" .. f31_local17
			local f31_local20 = Engine.Localize("MPUI_RETICLE_" .. f31_local18 .. "_" .. f31_local17)
			if f31_local18 == "dualoptic" then
				local f31_local21 = "reflex_" .. f31_local17
				local f31_local22 = "acog_" .. f31_local17
				if f31_local17 == "0" then
					f31_local21 = "dualoptic_up_0"
					f31_local22 = "dualoptic_down_0"
				elseif f31_local17 == "9" then
					f31_local21 = "dualoptic_up_9"
					f31_local22 = "dualoptic_down_9"
				end
				f0_local14(f31_arg0, nil, 60, 60, f31_local21, f31_local22)
			else
				f0_local14(f31_arg0, f31_local19, 60, 60)
			end
			f31_local12 = f31_local20
			f31_local11 = Engine.Localize(f31_local4 .. "_DESC", f31_local5, f31_local13)
			f31_local16 = Engine.Localize("MENU_NEW_RETICLE")
		end
		local f31_local17 = CoD.GetTextElem("ExtraSmall", "Left", f31_local12)
		f31_local17:setLeftRight(true, true, 4, 0)
		f31_arg0.title = f31_local17
		Widget:addElement(f31_local17)
		f31_arg0.title:registerAnimationState("button_over", {
			red = CoD.BOIIOrange.r,
			green = CoD.BOIIOrange.g,
			blue = CoD.BOIIOrange.b
		})
		LUI.UIButton.SetupElement(f31_arg0.title)
		f31_arg0.desc = f31_local11
		f31_arg0.xpRewardText = f31_local15
		f31_arg0.menuHeader = f31_local16
	end
	f31_arg0:registerEventHandler("gain_focus", f0_local5)
	f31_arg0:registerEventHandler("lose_focus", f0_local6)
end

local f0_local17 = function (f32_arg0, f32_arg1)
	local f32_local0 = CoD.AfterActionReport.Stats.recentChallenges
	if not f32_local0 then
		return 
	elseif #f32_local0 == 0 then
		return 
	end
	for f32_local4, f32_local5 in ipairs(f32_local0) do
		if f32_local5.row then
			if UIExpression.TableLookupGetColumnValueForRow(f32_arg1, "mp/statsmilestones" .. f32_local5.tableNumber + 1 .. ".csv", f32_local5.row, 9) ~= "" then
				f0_local16(f32_arg0:addNewCard(), f32_arg1, f32_local5)
			end
			if f32_local5.unlockedImageID and f32_local5.unlockedImageID > 0 then
				f0_local16(f32_arg0:addNewCard(), f32_arg1, f32_local5, true)
			end
		end
	end
end

local f0_local18 = function (f33_arg0, f33_arg1)
	f0_local11(f33_arg1, f33_arg0)
	f0_local8(f33_arg1, f33_arg0)
	f0_local9(f33_arg1, f33_arg0)
	f0_local12(f33_arg1, f33_arg0)
	f0_local10(f33_arg1, f33_arg0)
	f0_local17(f33_arg1, f33_arg0)
end

local f0_local19 = function (f34_arg0, f34_arg1)
	if f34_arg0.list then
		f34_arg0.list:close()
	end
	local f34_local0 = CoD.AfterActionReport.Stats.currentStats.unlocks[0]:get()
	if f34_local0 > 0 then
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(false, true, -CoD.textSize.Default, 0)
		local f34_local2 = Engine.Localize("MENU_UNLOCK_TOKEN_AVAILABLE", f34_local0)
		if f34_local0 > 1 then
			f34_local2 = Engine.Localize("MPUI_UNLOCK_TOKENS_AVAILABLE", f34_local0)
		end
		local f34_local3, f34_local4, f34_local5, f34_local6 = GetTextDimensions(f34_local2, CoD.fonts.Default, CoD.textSize.Default)
		local f34_local7 = f34_local5 + f34_local3
		local f34_local8 = LUI.UIText.new()
		f34_local8:setLeftRight(false, true, -f34_local7, 0)
		f34_local8:setTopBottom(true, true, 0, 0)
		f34_local8:setFont(CoD.fonts.Default)
		f34_local8:setText(f34_local2)
		f34_local8:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		local f34_local9 = 28
		local f34_local10 = LUI.UIImage.new()
		f34_local10:setLeftRight(false, true, -f34_local7 - f34_local9 - 3, -f34_local7 - 3)
		f34_local10:setTopBottom(false, true, -f34_local9 + 3, 3)
		f34_local10:setImage(RegisterMaterial(CoD.AfterActionReport.TokenImageMaterialName64))
		Widget:addElement(f34_local8)
		Widget:addElement(f34_local10)
		f34_arg0.list = Widget
		f34_arg0:addElement(Widget)
	end
end

local f0_local20 = function (f35_arg0, f35_arg1)
	CoD.ConfirmPurchase.OpenIfNecessary(f35_arg0, f35_arg1.controller, f35_arg0.currentItemIndex, nil, true)
	Engine.PlaySound("cac_grid_equip_item")
end

local f0_local21 = function (f36_arg0, f36_arg1)
	f36_arg0.currentItemIndex = f36_arg1.itemIndex
	f36_arg0.currentCard = f36_arg1.card
	if f36_arg0.purchaseButtonPrompt:getParent() == nil then
		f36_arg0:addLeftButtonPrompt(f36_arg0.purchaseButtonPrompt)
	end
end

local f0_local22 = function (f37_arg0, f37_arg1)
	f37_arg0.purchaseButtonPrompt:close()
end

local f0_local23 = function (f38_arg0, f38_arg1)
	f38_arg0.purchaseButtonPrompt:close()
	f38_arg0.currentCard.tokenIcon:close()
	f0_local19(f38_arg0, f38_arg1.controller)
end

local f0_local24 = function (f39_arg0)
	local f39_local0 = 80
	local f39_local1 = "Default"
	local f39_local2 = CoD.textSize[f39_local1]
	local f39_local3 = CoD.fonts[f39_local1]
	f39_arg0.descText = LUI.UIText.new()
	f39_arg0.descText:setLeftRight(true, true, 0, 0)
	f39_arg0.descText:setTopBottom(false, true, -f39_local0 - f39_local2, -f39_local0)
	f39_arg0.descText:setFont(f39_local3)
	f39_arg0.descText:setAlignment(LUI.Alignment.Left)
	f39_arg0:addElement(f39_arg0.descText)
end

local f0_local25 = function (f40_arg0)
	local f40_local0 = 50
	local f40_local1 = "Condensed"
	local f40_local2 = CoD.textSize[f40_local1]
	local f40_local3 = CoD.fonts[f40_local1]
	f40_arg0.xpRewardText = LUI.UIText.new()
	f40_arg0.xpRewardText:setLeftRight(true, true, 0, 0)
	f40_arg0.xpRewardText:setTopBottom(false, true, -f40_local0 - f40_local2, -f40_local0)
	f40_arg0.xpRewardText:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f40_arg0.xpRewardText:setAlignment(LUI.Alignment.Left)
	f40_arg0.xpRewardText:setFont(f40_local3)
	f40_arg0:addElement(f40_arg0.xpRewardText)
end

local f0_local26 = function (f41_arg0, f41_arg1)
	f41_arg0.descText:setText("")
	f41_arg0.xpRewardText:setText("")
	if f41_arg1.desc then
		f41_arg0.descText:setText(f41_arg1.desc)
	end
	if f41_arg1.xpRewardText then
		f41_arg0.xpRewardText:setText(f41_arg1.xpRewardText)
	end
	if f41_arg1.menuHeader then
		f41_arg0:setTitle(UIExpression.ToUpper(nil, f41_arg1.menuHeader))
	end
end

local f0_local27 = function (f42_arg0, f42_arg1)
	if f42_arg0.purchaseButtonPrompt then
		f42_arg0.purchaseButtonPrompt:processEvent(f42_arg1)
	end
	f42_arg0:dispatchEventToChildren(f42_arg1)
end

local f0_local28 = function (f43_arg0, f43_arg1, f43_arg2)
	local f43_local0 = CoD.AfterActionReport.NewContentItemWidth
	local f43_local1 = CoD.AfterActionReport.NewContentItemHeight
	local f43_local2 = CoD.AfterActionReport.NewContentHighlightedItemWidth
	local f43_local3 = CoD.CardCarouselList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.Menu.TitleHeight + 10,
		bottom = 0
	}, f43_arg1, f43_local0, f43_local1, f43_local2, CoD.AfterActionReport.NewContentHighligtedItemHeight, {
		hintTextLeft = f43_local2 + 10,
		hintTextWidth = 500,
		hintTextTop = -30,
		hintTextHeight = 100
	})
	local f43_local4 = f43_local3:addCardCarousel("")
	if not f43_arg2 then
		f0_local18(f43_arg1, f43_local4)
		f0_local19(f43_arg0)
	else
		AddNewRewardsCards(f43_arg1, f43_local4)
	end
	f0_local24(f43_arg0)
	f0_local25(f43_arg0)
	local f43_local5 = CoD.ButtonPrompt.new
	local f43_local6 = "alt2"
	local f43_local7 = Engine.Localize("MENU_UNLOCK_NOW")
	local f43_local8 = f43_arg0
	local f43_local9 = "purchase_current_item"
	local f43_local10, f43_local11 = false
	local f43_local12, f43_local13 = false
	f43_arg0.purchaseButtonPrompt = f43_local5(f43_local6, f43_local7, f43_local8, f43_local9, f43_local10, f43_local11, f43_local12, f43_local13, "U")
	f43_arg0:registerEventHandler("add_purchase_button_prompt", f0_local21)
	f43_arg0:registerEventHandler("remove_purchase_button_prompt", f0_local22)
	f43_arg0:registerEventHandler("purchase_current_item", f0_local20)
	f43_arg0:registerEventHandler("purchased", f0_local23)
	f43_arg0:registerEventHandler("set_desc_and_xp_reward", f0_local26)
	if CoD.isPC then
		f43_arg0:registerEventHandler("input_source_changed", f0_local27)
	end
	f43_arg0:addElement(f43_local3)
	f43_local3:focusCurrentCardCarousel(f43_arg1)
end

LUI.createMenu.AARNewContent = function (f44_arg0)
	local f44_local0 = CoD.Menu.NewMediumPopup("AARNewContent")
	f44_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_NEW_CONTENT")))
	CoD.AfterActionReport.AddButtonPrompts(f44_local0, "continue_to_next")
	f44_local0:registerEventHandler("continue_to_next", CoD.AARPopup.AARPopupContinueToNext)
	f44_local0.animateIn = CoD.NullFunction
	f0_local28(f44_local0, f44_arg0)
	return f44_local0
end

local f0_local29 = function (f45_arg0, f45_arg1, f45_arg2)
	local f45_local0 = CoD.ContentGridButton.new(f45_arg0)
	f45_local0.attachmentName = Engine.Localize(Engine.GetAttachmentName(f45_arg1, f45_arg2))
	f45_local0.attachmentDesc = Engine.Localize(Engine.GetAttachmentDesc(f45_arg1, f45_arg2))
	f45_local0.attachmentReward = Engine.Localize(Engine.Localize("RANK_XP", Engine.GetItemAttachmentReward(f45_arg1, f45_arg2)))
	CoD.ContentGridButton.SetupButtonText(f45_local0, f45_local0.attachmentName)
	CoD.AttachmentGridButton.SetupButtonImages(f45_local0, Engine.GetAttachmentImage(f45_arg1, f45_arg2))
	return f45_local0
end

local f0_local30 = function (f46_arg0, f46_arg1)
	if f46_arg0.infoContainer then
		f46_arg0.infoContainer:close()
	end
	local f46_local0 = 80
	local f46_local1 = 50
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f46_local0, -f46_local1)
	f46_arg0.infoContainer = Widget
	f46_arg0:addElement(Widget)
	local f46_local3 = f46_arg0.unlockedAttachmentInfo[f46_arg0.currInfoIndex].itemIndex
	local f46_local4 = f46_arg0.unlockedAttachmentInfo[f46_arg0.currInfoIndex].unlockedAttachments
	f46_arg0:setTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_NEW_ATTACHMENTS_ARG_CAPS", UIExpression.GetItemName(nil, f46_local3))))
	local f46_local5 = 400
	local f46_local6 = 200
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f46_local5, 0)
	Widget:setTopBottom(true, false, 0, f46_local6)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.1))
	Widget:addElement(Widget)
	local f46_local8 = LUI.UIImage.new()
	f46_local8:setLeftRight(true, true, 0, 0)
	f46_local8:setTopBottom(true, true, 0, 0)
	f46_local8:setImage(RegisterMaterial(UIExpression.GetItemImage(nil, f46_local3) .. "_big"))
	Widget:addElement(f46_local8)
	local f46_local9 = 50
	local f46_local10 = 50
	local f46_local11 = "Default"
	local f46_local12 = 9
	local f46_local13 = 5
	local f46_local14 = CoD.WeaponLevel.GetWeaponLevelIcon(f46_local9, f46_local10, f46_local11, 0, -1, 1)
	f46_local14:setLeftRight(false, true, -f46_local12 - f46_local9, -f46_local12)
	f46_local14:setTopBottom(false, true, -f46_local13 - f46_local10, -f46_local13)
	Widget:addElement(f46_local14)
	f46_local14:update(f46_arg1, f46_local3)
	local f46_local15 = 6
	local f46_local16 = 3
	local f46_local17 = 8
	local f46_local18 = 140
	local f46_local19 = 64 + CoD.ContentGridButton.TitleHeight + 10
	local f46_local20 = #f46_local4
	local f46_local21 = CoD.ContentGrid.new(f46_local16, {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = f46_local19
	}, f46_local18, f46_local19, f46_local17)
	local f46_local22 = nil
	for f46_local27, f46_local28 in ipairs(f46_local4) do
		if f46_local15 < f46_local27 then
			break
		end
		local attachmentDescTextElem = f0_local29(f46_local27, f46_local3, f46_local28.attachmentNum)
		f46_local21:addButton(attachmentDescTextElem)
		if not f46_local22 then
			f46_local22 = attachmentDescTextElem
		end
	end
	f46_local0 = f46_local19 * math.ceil(math.min(f46_local20, f46_local15) / f46_local16) + 22
	f46_local23 = "Big"
	f46_local24 = CoD.textSize[f46_local23]
	
	attachmentNameTextElem = LUI.UIText.new()
	attachmentNameTextElem:setLeftRight(true, false, 0, f46_local18)
	attachmentNameTextElem:setTopBottom(true, false, f46_local0, f46_local0 + f46_local24)
	attachmentNameTextElem:setFont(CoD.fonts[f46_local23])
	attachmentNameTextElem:setText(f46_local22.attachmentName)
	Widget:addElement(attachmentNameTextElem)
	f46_arg0.attachmentNameTextElem = attachmentNameTextElem
	
	f46_local0 = f46_local0 + f46_local24
	f46_local27 = "ExtraSmall"
	f46_local28 = CoD.textSize[f46_local27]
	
	local attachmentDescTextElem = LUI.UIText.new()
	attachmentDescTextElem:setLeftRight(true, false, 0, f46_local18 * f46_local16)
	attachmentDescTextElem:setTopBottom(true, false, f46_local0, f46_local0 + f46_local28)
	attachmentDescTextElem:setFont(CoD.fonts[f46_local27])
	attachmentDescTextElem:setText(f46_local22.attachmentDesc)
	attachmentDescTextElem:setAlignment(LUI.Alignment.Left)
	Widget:addElement(attachmentDescTextElem)
	f46_arg0.attachmentDescTextElem = attachmentDescTextElem
	
	f46_local0 = f46_local0 + f46_local28 + 20
	local f46_local29 = "ExtraSmall"
	local f46_local30 = CoD.textSize[f46_local29]
	
	local attachmentRewardTextElem = LUI.UIText.new()
	attachmentRewardTextElem:setLeftRight(true, false, 0, f46_local18 * f46_local16)
	attachmentRewardTextElem:setTopBottom(true, false, f46_local0, f46_local0 + f46_local30)
	attachmentRewardTextElem:setFont(CoD.fonts[f46_local29])
	attachmentRewardTextElem:setText(f46_local22.attachmentReward)
	attachmentRewardTextElem:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	attachmentRewardTextElem:setAlignment(LUI.Alignment.Left)
	Widget:addElement(attachmentRewardTextElem)
	f46_arg0.attachmentRewardTextElem = attachmentRewardTextElem
	
	Widget:addElement(f46_local21)
	f46_local22:processEvent({
		name = "gain_focus",
		controller = f46_arg1
	})
end

CoD.AARPopup.AARNewAttachmentsContinueToNext = function (f47_arg0, f47_arg1)
	f47_arg0.currInfoIndex = f47_arg0.currInfoIndex + 1
	if #f47_arg0.unlockedAttachmentInfo < f47_arg0.currInfoIndex then
		CoD.AARPopup.AARPopupContinueToNext(f47_arg0, f47_arg1)
		return 
	else
		f0_local30(f47_arg0, f47_arg1.controller)
	end
end

CoD.AARPopup.AARNewAttachmentsButtonHightlighted = function (f48_arg0, f48_arg1)
	if f48_arg0.attachmentNameTextElem and f48_arg1.button and f48_arg1.button.attachmentName then
		f48_arg0.attachmentNameTextElem:setText(f48_arg1.button.attachmentName)
	end
	if f48_arg0.attachmentDescTextElem and f48_arg1.button and f48_arg1.button.attachmentDesc then
		f48_arg0.attachmentDescTextElem:setText(f48_arg1.button.attachmentDesc)
	end
	if f48_arg0.attachmentRewardTextElem and f48_arg1.button and f48_arg1.button.attachmentReward then
		f48_arg0.attachmentRewardTextElem:setText(f48_arg1.button.attachmentReward)
	end
end

LUI.createMenu.AARNewAttachments = function (f49_arg0)
	local f49_local0 = CoD.Menu.NewMediumPopup("AARNewAttachments")
	local f49_local1 = CoD.AfterActionReport.Stats
	f49_local0:addTitle("")
	f49_local0.unlockedAttachmentInfo = f49_local1.unlockedAttachmentInfo
	f49_local0.currInfoIndex = 1
	CoD.AfterActionReport.AddButtonPrompts(f49_local0, "continue_to_next")
	f0_local30(f49_local0, f49_arg0)
	f49_local0:registerEventHandler("continue_to_next", CoD.AARPopup.AARNewAttachmentsContinueToNext)
	f49_local0:registerEventHandler("content_button_highlighted", CoD.AARPopup.AARNewAttachmentsButtonHightlighted)
	f49_local0.animateIn = CoD.NullFunction
	return f49_local0
end

