require("T6.CoD9Button")
require("T6.LeaderboardPreviewList")
CoD.LeaderboardCarouselZombie = {}
CoD.LeaderboardCarouselZombie.NumLeagueTeamsToFetch = 19
CoD.LeaderboardCarouselZombie.ItemWidth = 192
CoD.LeaderboardCarouselZombie.ItemHeight = 146
CoD.LeaderboardCarouselZombie.HighlightedItemWidth = 345.6
CoD.LeaderboardCarouselZombie.HighlightedItemHeight = 217.8
CoD.LeaderboardCarouselZombie.BackgroundCardIconHeightWidthRatio = 0.46
CoD.LeaderboardCarouselZombie.BackgroundCardIconScale = 1.6
CoD.LeaderboardCarouselZombie.SubdivisionInfoFetchTimer = 1000
CoD.LeaderboardCarouselZombie.glowBackColor = {}
CoD.LeaderboardCarouselZombie.glowBackColor.r = 1
CoD.LeaderboardCarouselZombie.glowBackColor.g = 1
CoD.LeaderboardCarouselZombie.glowBackColor.b = 1
CoD.LeaderboardCarouselZombie.glowFrontColor = {}
CoD.LeaderboardCarouselZombie.glowFrontColor.r = 1
CoD.LeaderboardCarouselZombie.glowFrontColor.g = 1
CoD.LeaderboardCarouselZombie.glowFrontColor.b = 1
CoD.LeaderboardCarouselZombie.HintTextParams = {}
CoD.LeaderboardCarouselZombie.HintTextParams.hintTextLeft = 353
CoD.LeaderboardCarouselZombie.HintTextParams.hintTextWidth = 510
CoD.LeaderboardCarouselZombie.HintTextParams.hintTextTop = -32
CoD.LeaderboardCarouselZombie.MiniLeaderboardSideOffset = 4
CoD.LeaderboardCarouselZombie.EmblemEditorIconOffset = 10
CoD.LeaderboardCarouselZombie.BackgroundCardIconOffset = 20
LUI.createMenu.LeaderboardCarouselZM = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("LeaderboardCarouselZM")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0.goBack = CoD.LeaderboardCarouselZombie.GoBack
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("open_leaderboard", CoD.LeaderboardCarouselZombie.OpenLeaderboard)
	f1_local0:registerEventHandler("remove_select_button", CoD.LeaderboardCarouselZombie.RemoveSelectButton)
	f1_local0:registerEventHandler("add_select_button", CoD.LeaderboardCarouselZombie.AddSelectButton)
	f1_local0:registerEventHandler("multi_read_update", CoD.LeaderboardCarouselZombie.MiniLeaderboardUpdate)
	f1_local0:addTitle(Engine.Localize("MENU_LEADERBOARDS_CAPS"))
	local f1_local1 = CoD.textSize.Big + 10
	local f1_local2 = CoD.CardCarouselList.new(nil, f1_arg0, CoD.LeaderboardCarouselZombie.ItemWidth, CoD.LeaderboardCarouselZombie.ItemHeight, CoD.LeaderboardCarouselZombie.HighlightedItemWidth, CoD.LeaderboardCarouselZombie.HighligtedItemHeight, CoD.LeaderboardCarouselZombie.HintTextParams)
	f1_local2:setLeftRight(true, true, 0, 0)
	f1_local2:setTopBottom(true, true, f1_local1, -CoD.ButtonPrompt.Height)
	f1_local2.popup = f1_local0
	f1_local0:addElement(f1_local2)
	f1_local2.titleListContainer.spacing = 0
	f1_local2.titleListContainer:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = -CoD.CoD9Button.Height,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local2.cardCarouselSize + 60,
		bottom = 0
	})
	f1_local2.titleListContainer:animateToState("default")
	f1_local1 = f1_local1 + f1_local2.cardCarouselSize - 7
	local f1_local3 = true
	if not Engine.IsBetaBuild() then
		f1_local3 = false
	end
	CoD.LeaderboardCarouselZombie.AddCarousels(f1_local2, f1_arg0, f1_local3)
	if CoD.LeaderboardCarouselZombie.CurrentCarouselInfo then
		f1_local2:setInitialCarousel(CoD.LeaderboardCarouselZombie.CurrentCarouselInfo.carouselIndex, CoD.LeaderboardCarouselZombie.CurrentCarouselInfo.cardIndex)
	end
	if CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_A == false then
		CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE = 1
		CoD.LeaderboardCarouselZombie.MiniRead(f1_arg0, 1)
	elseif CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_B == false then
		CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE = 2
		CoD.LeaderboardCarouselZombie.MiniRead(f1_arg0, 6)
	end
	local f1_local4 = f1_local1 + 87
	local f1_local5 = LUI.UIImage.new()
	f1_local5:setLeftRight(true, false, 0, CoD.Menu.Width / 2 - 85)
	f1_local5:setTopBottom(true, false, f1_local4, f1_local4 + 1)
	f1_local5:setAlpha(0.05)
	f1_local0:addElement(f1_local5)
	f1_local2:focusCurrentCardCarousel(f1_arg0)
	return f1_local0
end

CoD.LeaderboardCarouselZombie.GoBack = function (f2_arg0, f2_arg1)
	CoD.LeaderboardCarouselZombie.CurrentCarouselInfo = nil
	Engine.PartyHostClearUIState()
	CoD.Menu.goBack(f2_arg0, f2_arg1)
end

CoD.LeaderboardCarouselZombie.RemoveSelectButton = function (f3_arg0, f3_arg1)
	if f3_arg0.selectButton then
		f3_arg0.selectButton:close()
	end
end

CoD.LeaderboardCarouselZombie.AddSelectButton = function (f4_arg0, f4_arg1)
	f4_arg0.backButton:close()
	if f4_arg0.selectButton then
		f4_arg0.selectButton:close()
	end
	f4_arg0:addBackButton()
	f4_arg0:addSelectButton()
end

CoD.LeaderboardCarouselZombie.SetupCardCarouselTitleTextPosition = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1.cardCarouselSize + 30
	f5_arg0.title:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f5_local0,
		bottom = f5_local0 + CoD.CardCarousel.TitleSize,
		font = CoD.fonts.Big
	})
	f5_arg0.title:animateToState("default")
end

CoD.LeaderboardCarouselZombie.SetupCarouselCard = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5, f6_arg6, f6_arg7)
	if f6_arg7 == nil then
		f6_arg7 = 0
	end
	if f6_arg2 then
		f6_arg0.iconMaterial = RegisterMaterial(f6_arg2)
		f6_arg0.icon = LUI.UIImage.new()
		f6_arg0.icon:setLeftRight(false, false, -f6_arg5 / 2, f6_arg5 / 2)
		f6_arg0.icon:setTopBottom(false, false, -f6_arg6 / 2 + f6_arg7, f6_arg6 / 2 + f6_arg7)
		f6_arg0.icon:setImage(f6_arg0.iconMaterial)
		f6_arg0:addElement(f6_arg0.icon)
	end
	if f6_arg3 then
		f6_arg0.chalkIconLeftMaterial = RegisterMaterial(f6_arg3)
		f6_arg0.chalkIconLeft = LUI.UIImage.new()
		f6_arg0.chalkIconLeft:setLeftRight(true, false, 0, f6_arg5 / 4)
		f6_arg0.chalkIconLeft:setTopBottom(false, true, -(f6_arg6 / CoD.LeaderboardCarouselZombie.BackgroundCardIconHeightWidthRatio) / 4 + f6_arg7 * 2, f6_arg7 * 2)
		f6_arg0.chalkIconLeft:setImage(f6_arg0.chalkIconLeftMaterial)
		f6_arg0:addElement(f6_arg0.chalkIconLeft)
		f6_arg0.chalkTextCenter = LUI.UIText.new()
		f6_arg0.chalkTextCenter:setLeftRight(false, false, -f6_arg5 / 8, f6_arg5 / 8)
		f6_arg0.chalkTextCenter:setTopBottom(false, true, -(f6_arg6 / CoD.LeaderboardCarouselZombie.BackgroundCardIconHeightWidthRatio) / 8 + f6_arg7 * 2, f6_arg7 * 2)
		f6_arg0.chalkTextCenter:setText("Z")
		f6_arg0.chalkTextCenter:setFont(CoD.Menu.TitleFont)
		f6_arg0:addElement(f6_arg0.chalkTextCenter)
	end
	if f6_arg4 then
		f6_arg0.chalkIconRightMaterial = RegisterMaterial(f6_arg4)
		f6_arg0.chalkIconRight = LUI.UIImage.new()
		f6_arg0.chalkIconRight:setLeftRight(false, true, -f6_arg5 / 4, 0)
		f6_arg0.chalkIconRight:setTopBottom(false, true, -(f6_arg6 / CoD.LeaderboardCarouselZombie.BackgroundCardIconHeightWidthRatio) / 4 + f6_arg7 * 2, f6_arg7 * 2)
		f6_arg0.chalkIconRight:setImage(f6_arg0.chalkIconRightMaterial)
		f6_arg0:addElement(f6_arg0.chalkIconRight)
	end
	f6_arg0.title = LUI.UIText.new()
	f6_arg0.title:setLeftRight(true, true, 5, 0)
	f6_arg0.title:setTopBottom(false, true, -CoD.textSize.Default, 0)
	f6_arg0.title:setFont(CoD.fonts.Default)
	f6_arg0.title:setRGB(CoD.offWhite.r, CoD.offWhite.b, CoD.offWhite.g)
	f6_arg0.title:setAlignment(LUI.Alignment.Left)
	f6_arg0.titleText = f6_arg1
	f6_arg0.title:setText(f6_arg0.titleText)
	f6_arg0.title:registerAnimationState("button_over", {
		red = CoD.BOIIOrange.r,
		green = CoD.BOIIOrange.g,
		blue = CoD.BOIIOrange.b
	})
	LUI.UIButton.SetupElement(f6_arg0.title)
	f6_arg0:addElement(f6_arg0.title)
	if f6_arg0.border then
		f6_arg0.border:close()
	end
	if f6_arg0.highlightedborder then
		f6_arg0.highlightedborder:close()
	end
	CoD.ContentGridButton.SetupButtonImages(f6_arg0, CoD.LeaderboardCarouselZombie.glowBackColor, CoD.LeaderboardCarouselZombie.glowFrontColor)
end

local f0_local0 = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, CoD.textSize[HudRef])
	local f7_local1 = LUI.UIText.new()
	f7_local1:setLeftRight(true, true, 0, 0)
	f7_local1:setTopBottom(true, true, 0, 0)
	f7_local1:setAlignment(LUI.UIElement.Left)
	f7_local1:setFont(CoD.fonts[HudRef])
	f7_local1:setText(InstanceRef)
	Widget.textElem = f7_local1
	Widget:addElement(f7_local1)
	return Widget
end

CoD.LeaderboardCarouselZombie.AddCarousels = function (f8_arg0, f8_arg1, f8_arg2)
	if f8_arg2 then
		CoD.LeaderboardCarouselZombie.AddCarousel(Engine.Localize("MENU_LEADERBOARDS_CAPS"), f8_arg0, f8_arg1, true)
	else
		CoD.LeaderboardCarouselZombie.AddLeaderboardCarousel("MENU_LB_GROUP_GLOBAL", CoD.LeaderboardZombie.LEADERBOARD_GROUP_GLOBAL, f8_arg0, f8_arg1)
		CoD.LeaderboardCarouselZombie.AddLeaderboardCarousel("ZMUI_TRANSIT_CAPS", CoD.LeaderboardZombie.LEADERBOARD_GROUP_GREENRUN, f8_arg0, f8_arg1)
		CoD.LeaderboardCarouselZombie.AddLeaderboardCarousel("MPUI_NUKED_CAPS", CoD.LeaderboardZombie.LEADERBOARD_GROUP_NUKETOWN, f8_arg0, f8_arg1)
		CoD.LeaderboardCarouselZombie.AddLeaderboardCarousel("ZMUI_HIGHRISE_CAPS", CoD.LeaderboardZombie.LEADERBOARD_GROUP_HIGHRISE, f8_arg0, f8_arg1)
		CoD.LeaderboardCarouselZombie.AddLeaderboardCarousel("ZMUI_PRISON_CAPS", CoD.LeaderboardZombie.LEADERBOARD_GROUP_PRISON, f8_arg0, f8_arg1)
		CoD.LeaderboardCarouselZombie.AddLeaderboardCarousel("ZMUI_BURIED_CAPS", CoD.LeaderboardZombie.LEADERBOARD_GROUP_BURIED, f8_arg0, f8_arg1)
		if Dvar.ui_showNewestLeaderboards:get() == true then
			CoD.LeaderboardCarouselZombie.AddLeaderboardCarousel("ZMUI_TOMB_CAPS", CoD.LeaderboardZombie.LEADERBOARD_GROUP_TOMB, f8_arg0, f8_arg1)
		end
	end
end

CoD.LeaderboardCarouselZombie.LeaderboardCard_GrowCard = function (f9_arg0, f9_arg1)
	local f9_local0 = CoD.LeaderboardCarouselZombie.HighlightedItemHeight - CoD.textSize.Default
	local f9_local1 = f9_local0
	CoD.LeaderboardZombie.CURR_LB_GROUP_INDEX = f9_arg0.lbGroupIndex
	if CoD.LeaderboardZombie.CURR_LB_GROUP_INDEX ~= CoD.LeaderboardZombie.LEADERBOARD_GROUP_GLOBAL then
		f9_local1 = f9_local1 * CoD.LeaderboardCarouselZombie.BackgroundCardIconScale
		f9_local0 = f9_local1 * CoD.LeaderboardCarouselZombie.BackgroundCardIconHeightWidthRatio
	end
	local f9_local2 = -10
	if f9_arg0.icon then
		f9_arg0.icon:beginAnimation("big", f9_arg1)
		f9_arg0.icon:setLeftRight(false, false, -f9_local1 / 2, f9_local1 / 2)
		f9_arg0.icon:setTopBottom(false, false, -f9_local0 / 2 + f9_local2, f9_local0 / 2 + f9_local2)
	end
	if f9_arg0.chalkIconLeft then
		f9_arg0.chalkIconLeft:beginAnimation("big", f9_arg1)
		f9_arg0.chalkIconLeft:setLeftRight(true, false, 0, f9_local1 / 4)
		f9_arg0.chalkIconLeft:setTopBottom(false, true, -(f9_local0 / CoD.LeaderboardCarouselZombie.BackgroundCardIconHeightWidthRatio) / 4 + f9_local2 * 2, f9_local2 * 2)
	end
	if f9_arg0.chalkTextCenter then
		f9_arg0.chalkTextCenter:beginAnimation("big", f9_arg1)
		f9_arg0.chalkTextCenter:setLeftRight(false, false, -f9_local1 / 8, f9_local1 / 8)
		f9_arg0.chalkTextCenter:setTopBottom(false, true, -(f9_local0 / CoD.LeaderboardCarouselZombie.BackgroundCardIconHeightWidthRatio) / 8 + f9_local2 * 2, f9_local2 * 2)
	end
	if f9_arg0.chalkIconRight then
		f9_arg0.chalkIconRight:beginAnimation("big", f9_arg1)
		f9_arg0.chalkIconRight:setLeftRight(false, true, -f9_local1 / 4, 0)
		f9_arg0.chalkIconRight:setTopBottom(false, true, -(f9_local0 / CoD.LeaderboardCarouselZombie.BackgroundCardIconHeightWidthRatio) / 4 + f9_local2 * 2, f9_local2 * 2)
	end
end

CoD.LeaderboardCarouselZombie.LeaderboardCard_ShrinkCard = function (f10_arg0, f10_arg1)
	local f10_local0 = CoD.LeaderboardCarouselZombie.ItemHeight - CoD.textSize.Default
	local f10_local1 = f10_local0
	if CoD.LeaderboardZombie.CURR_LB_GROUP_INDEX ~= CoD.LeaderboardZombie.LEADERBOARD_GROUP_GLOBAL then
		f10_local1 = f10_local1 * CoD.LeaderboardCarouselZombie.BackgroundCardIconScale
		f10_local0 = f10_local1 * CoD.LeaderboardCarouselZombie.BackgroundCardIconHeightWidthRatio
	end
	local f10_local2 = -10
	if f10_arg0.icon then
		f10_arg0.icon:beginAnimation("small", f10_arg1)
		f10_arg0.icon:setLeftRight(false, false, -f10_local1 / 2, f10_local1 / 2)
		f10_arg0.icon:setTopBottom(false, false, -f10_local0 / 2 + f10_local2, f10_local0 / 2 + f10_local2)
	end
	if f10_arg0.chalkIconLeft then
		f10_arg0.chalkIconLeft:beginAnimation("small", f10_arg1)
		f10_arg0.chalkIconLeft:setLeftRight(true, false, 0, f10_local1 / 4)
		f10_arg0.chalkIconLeft:setTopBottom(false, true, -(f10_local0 / CoD.LeaderboardCarouselZombie.BackgroundCardIconHeightWidthRatio) / 4 + f10_local2 * 2, f10_local2 * 2)
		f10_arg0.chalkTextCenter:beginAnimation("small", f10_arg1)
		f10_arg0.chalkTextCenter:setLeftRight(false, false, -f10_local1 / 8, f10_local1 / 8)
		f10_arg0.chalkTextCenter:setTopBottom(false, true, -(f10_local0 / CoD.LeaderboardCarouselZombie.BackgroundCardIconHeightWidthRatio) / 8 + f10_local2 * 2, f10_local2 * 2)
	end
	if f10_arg0.chalkIconRight then
		f10_arg0.chalkIconRight:beginAnimation("small", f10_arg1)
		f10_arg0.chalkIconRight:setLeftRight(false, true, -f10_local1 / 4, 0)
		f10_arg0.chalkIconRight:setTopBottom(false, true, -(f10_local0 / CoD.LeaderboardCarouselZombie.BackgroundCardIconHeightWidthRatio) / 4 + f10_local2 * 2, f10_local2 * 2)
	end
end

CoD.LeaderboardCarouselZombie.LeaderboardCard_GainFocus = function (f11_arg0, f11_arg1)
	if f11_arg1.button == "left" or f11_arg1.button == "right" or f11_arg1.mouseDrag or f11_arg1.mouseClick then
		CoD.LeaderboardCarouselZombie.LeaderboardCard_GrowCard(f11_arg0, CoD.CardCarousel.CardGrowShrinkTime)
	else
		CoD.LeaderboardCarouselZombie.LeaderboardCard_GrowCard(f11_arg0, 0)
	end
	CoD.LeaderboardCarouselZombie.LeaderboardCardSetupHintTextArea(f11_arg0.lbIndex, f11_arg0.lbGroupIndex, f11_arg0.cardCarousel)
	CoD.CardCarousel.Card_GainFocus(f11_arg0, f11_arg1)
end

CoD.LeaderboardCarouselZombie.LeaderboardCard_LoseFocus = function (f12_arg0, f12_arg1)
	if f12_arg1.button == "left" or f12_arg1.button == "right" or f12_arg1.mouseDrag or f12_arg1.mouseClick then
		CoD.LeaderboardCarouselZombie.LeaderboardCard_ShrinkCard(f12_arg0, CoD.CardCarousel.CardGrowShrinkTime)
	end
	CoD.CardCarousel.Card_LoseFocus(f12_arg0, f12_arg1)
end

CoD.LeaderboardCarouselZombie.AddLeaderboardCarousel = function (f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	if Dvar.ui_hideLeaderboards:get() == true then
		return 
	end
	local f13_local0 = f13_arg2:addCardCarousel(Engine.Localize(f13_arg0))
	CoD.LeaderboardCarouselZombie.SetupCardCarouselTitleTextPosition(f13_local0, f13_arg2)
	local f13_local1 = #CoD.LeaderboardZombie.Leaderboards[f13_arg1]
	for f13_local2 = 1, f13_local1, 1 do
		local f13_local5 = CoD.LeaderboardZombie.Leaderboards[f13_arg1][f13_local2]
		local f13_local6 = f13_local5[CoD.LeaderboardZombie.LB_ICON]
		local f13_local7 = f13_local5[CoD.LeaderboardZombie.LB_CHALK_ICON_LEFT]
		local f13_local8 = f13_local5[CoD.LeaderboardZombie.LB_CHALK_ICON_RIGHT]
		local f13_local9 = f13_local5[CoD.LeaderboardZombie.LB_NAME_CORE]
		local f13_local10 = f13_local0:addNewCard()
		f13_local10:registerEventHandler("gain_focus", CoD.LeaderboardCarouselZombie.LeaderboardCard_GainFocus)
		f13_local10:registerEventHandler("lose_focus", CoD.LeaderboardCarouselZombie.LeaderboardCard_LoseFocus)
		local f13_local11 = CoD.LeaderboardCarouselZombie.ItemHeight - CoD.textSize.Default
		local f13_local12 = f13_local11
		if f13_arg1 ~= CoD.LeaderboardZombie.LEADERBOARD_GROUP_GLOBAL then
			f13_local12 = f13_local12 * CoD.LeaderboardCarouselZombie.BackgroundCardIconScale
			f13_local11 = f13_local12 * CoD.LeaderboardCarouselZombie.BackgroundCardIconHeightWidthRatio
		end
		local f13_local13 = -10
		if f13_local7 == "" then
			f13_local7 = nil
		end
		if f13_local8 == "" then
			f13_local8 = nil
		end
		CoD.LeaderboardCarouselZombie.SetupCarouselCard(f13_local10, Engine.Localize(f13_local9), f13_local6, f13_local7, f13_local8, f13_local12, f13_local11, f13_local13)
		f13_local10.lbIndex = f13_local2
		f13_local10.lbGroupIndex = f13_arg1
		f13_local10:setActionEventName("open_leaderboard")
	end
end

CoD.LeaderboardCarouselZombie.OpenLeaderboard = function (f14_arg0, f14_arg1)
	if f14_arg1.button.lbIndex == nil then
		return 
	elseif UIExpression.IsGuest(f14_arg1.controller) == 1 then
		return 
	else
		local f14_local0 = f14_arg0:openMenu("LeaderboardZM", f14_arg1.controller)
		local f14_local1 = CoD.LeaderboardZombie.Leaderboards[f14_arg1.button.lbGroupIndex][f14_arg1.button.lbIndex][CoD.LeaderboardZombie.LB_NAME_CORE]
		f14_local0:processEvent({
			name = "leaderboard_loadnew",
			controller = f14_arg1.controller,
			lbIndex = f14_arg1.button.lbIndex,
			lbGroupIndex = f14_arg1.button.lbGroupIndex
		})
		f14_arg0:close()
		CoD.LeaderboardCarouselZombie.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo(f14_arg1.button)
	end
end

CoD.LeaderboardCarouselZombie.MiniRead = function (f15_arg0, f15_arg1)
	local f15_local0 = {}
	local f15_local1 = f15_arg1
	local f15_local2 = math.min(f15_local1 + 4, #CoD.LeaderboardZombie.Leaderboards[CoD.LeaderboardZombie.CURR_LB_GROUP_INDEX])
	for f15_local3 = f15_local1, f15_local2, 1 do
		table.insert(f15_local0, {
			lbDef = CoD.LeaderboardZombie.Leaderboards[CoD.LeaderboardZombie.CURR_LB_GROUP_INDEX][f15_local3][CoD.LeaderboardZombie.LB_LIST_CORE][CoD.LeaderboardZombie.FILTER_DURATION_ALLTIME],
			lbFilter = "TRK_ALLTIME"
		})
	end
	Engine.RequestMultiLeaderboardData(f15_arg0, CoD.REQUEST_MULTI_LB_READ_MINI_LBS, CoD.LB_FILTER_FRIENDS, f15_local0)
end

CoD.LeaderboardCarouselZombie.MiniLeaderboardUpdate = function (f16_arg0, f16_arg1)
	if CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE == 1 then
		if f16_arg1.error == false then
			CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_A = true
			CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_A_DATA = {}
			if f16_arg1.leaderboards ~= nil then
				CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_A_DATA = f16_arg1.leaderboards
			end
		end
		if CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_B == false then
			CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE = 2
			CoD.LeaderboardCarouselZombie.MiniRead(f16_arg1.controller, 6)
		end
	elseif CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE == 2 and f16_arg1.error == false then
		CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_B = true
		CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_B_DATA = {}
		if f16_arg1.leaderboards ~= nil then
			CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_B_DATA = f16_arg1.leaderboards
		end
	end
end

CoD.LeaderboardCarouselZombie.AddMiniLeaderboardRow = function (f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4)
	local f17_local0 = CoD.black
	local f17_local1 = 0.7
	local f17_local2 = CoD.offWhite
	if f17_arg1 % 2 == 1 then
		f17_local0 = CoD.black
		f17_local1 = 0.4
	end
	if f17_arg2 == true then
		f17_local2 = CoD.yellowGlow
	end
	local f17_local3 = CoD.LeaderboardZombie.AddUIImage(true, true, 0, 0, true, false, 25 * f17_arg1, 25 * f17_arg1 + 25, f17_local0.r, f17_local0.b, f17_local0.g, f17_local1)
	local f17_local4 = CoD.LeaderboardZombie.AddUIText(true, true, CoD.LeaderboardCarouselZombie.MiniLeaderboardSideOffset, -CoD.LeaderboardCarouselZombie.MiniLeaderboardSideOffset, true, false, 25 * f17_arg1, 25 * f17_arg1 + CoD.textSize.Default * 0.9, LUI.Alignment.Left)
	f17_local4:setRGB(f17_local2.r, f17_local2.g, f17_local2.b)
	f17_local4:setText(f17_arg3)
	local f17_local5 = CoD.LeaderboardZombie.AddUIText(true, true, CoD.LeaderboardCarouselZombie.MiniLeaderboardSideOffset, -CoD.LeaderboardCarouselZombie.MiniLeaderboardSideOffset, true, false, 25 * f17_arg1, 25 * f17_arg1 + CoD.textSize.Default * 0.9, LUI.Alignment.Right)
	f17_local5:setRGB(f17_local2.r, f17_local2.g, f17_local2.b)
	f17_local5:setText(f17_arg4)
	f17_arg0:addElement(f17_local3)
	f17_arg0:addElement(f17_local4)
	f17_arg0:addElement(f17_local5)
	return f17_arg0
end

CoD.LeaderboardCarouselZombie.AddMiniLeaderboard = function (f18_arg0, f18_arg1, f18_arg2)
	local f18_local0 = CoD.LeaderboardZombie.Leaderboards[f18_arg1][f18_arg0][CoD.LeaderboardZombie.LB_LIST_CORE][CoD.LeaderboardZombie.FILTER_DURATION_ALLTIME]
	local f18_local1 = nil
	if CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_A == true then
		for f18_local2 = 1, #CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_A_DATA, 1 do
			if f18_local0 == CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_A_DATA[f18_local2].def then
				f18_local1 = CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_A_DATA[f18_local2]
				break
			end
		end
	end
	if CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_B == true and f18_local1 == nil then
		for f18_local2 = 1, #CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_B_DATA, 1 do
			if f18_local0 == CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_B_DATA[f18_local2].def then
				f18_local1 = CoD.LeaderboardZombie.MINI_LEADERBOARD_CACHE_B_DATA[f18_local2]
				break
			end
		end
	end
	local f18_local2 = CoD.LeaderboardZombie.AddUIElement(true, false, 0, 350, true, false, 0, 80)
	local f18_local3 = CoD.LeaderboardZombie.AddUIText(true, true, CoD.LeaderboardCarouselZombie.MiniLeaderboardSideOffset, -CoD.LeaderboardCarouselZombie.MiniLeaderboardSideOffset, true, false, 0, CoD.textSize.Default * 0.9, LUI.Alignment.Left, nil, 0.6)
	f18_local3:setText(Engine.Localize("MENU_LB_MINI_GAMERTAG"))
	local f18_local4 = CoD.LeaderboardZombie.AddUIText(true, true, CoD.LeaderboardCarouselZombie.MiniLeaderboardSideOffset, -CoD.LeaderboardCarouselZombie.MiniLeaderboardSideOffset, true, false, 0, CoD.textSize.Default * 0.9, LUI.Alignment.Right, nil, 0.6)
	if f18_arg0 == 1 then
		f18_local4:setText(Engine.Localize("MENU_LB_SCORE"))
	else
		f18_local4:setText(Engine.Localize("MENU_LB_SCORE_PER_MINUTE"))
	end
	f18_local2:addElement(f18_local3)
	f18_local2:addElement(f18_local4)
	local f18_local5 = 1
	local f18_local6 = 1
	if f18_local1 ~= nil then
		for f18_local7 = 1, #f18_local1.lbrowheaders, 1 do
			if f18_local1.lbrowheaders[f18_local7] == "Gamertag" then
				f18_local5 = f18_local7
			end
			if f18_arg0 == 1 and f18_local1.lbrowheaders[f18_local7] == "Score" then
				f18_local6 = f18_local7
			end
			if f18_arg0 > 1 and f18_local1.lbrowheaders[f18_local7] == "Score Per Minute" then
				f18_local6 = f18_local7
			end
		end
	end
	local f18_local7 = UIExpression.GetXUID(controller)
	for f18_local8 = 1, 3, 1 do
		local f18_local11 = nil
		if f18_local1 ~= nil and f18_local8 <= #f18_local1.lbrows then
			f18_local11 = f18_local1.lbrows[f18_local8]
		end
		local f18_local12 = false
		local f18_local13 = "--"
		local f18_local14 = "--"
		if f18_local11 ~= nil then
			if f18_local11.xuid == f18_local7 then
				f18_local12 = true
			end
			f18_local13 = f18_local11[f18_local5]
			f18_local14 = f18_local11[f18_local6]
		end
		CoD.LeaderboardCarouselZombie.AddMiniLeaderboardRow(f18_local2, f18_local8, f18_local12, f18_local13, f18_local14)
	end
	return f18_local2
end

CoD.LeaderboardCarouselZombie.LeaderboardCardSetupHintTextArea = function (f19_arg0, f19_arg1, f19_arg2)
	f19_arg2.hintTextContainer.hintText:close()
	if f19_arg2.hintTextContainer.hintTextList then
		f19_arg2.hintTextContainer.hintTextList:close()
	end
	if f19_arg2.hintTextContainer.spinner then
		f19_arg2.hintTextContainer.spinner:close()
	end
	local f19_local0 = LUI.UIVerticalList.new()
	f19_local0:setLeftRight(true, false, 0, 510)
	f19_local0:setTopBottom(true, true, -19, 0)
	f19_local0:addSpacer(CoD.textSize.ExtraSmall)
	f19_local0.leaderboardDesc = f0_local0("ExtraSmall", Engine.Localize(CoD.LeaderboardZombie.Leaderboards[f19_arg1][f19_arg0][CoD.LeaderboardZombie.LB_CARD_TEXT]))
	f19_local0.leaderboardDesc.textElem:setLeftRight(true, true, 0, 0)
	f19_local0:addElement(f19_local0.leaderboardDesc)
	f19_local0:addSpacer(30)
	f19_arg2.hintTextContainer.hintTextList = f19_local0
	f19_arg2.hintTextContainer:addElement(f19_arg2.hintTextContainer.hintTextList)
	f19_arg2.hintTextContainer:setAlpha(0)
	f19_arg2.hintTextContainer:beginAnimation("fade_in", 1000)
	f19_arg2.hintTextContainer:setAlpha(1)
end

CoD.LeaderboardCarouselZombie.Card_GainFocus = function (f20_arg0, f20_arg1)
	if f20_arg0.lockedIcon then
		local f20_local0 = (CoD.LeaderboardCarouselZombie.HighlightedItemHeight - CoD.textSize.Default) / 2
		local f20_local1 = f20_local0
		local f20_local2 = -10
		f20_arg0.lockedIcon:beginAnimation("big", CoD.CardCarousel.CardGrowShrinkTime)
		f20_arg0.lockedIcon:setLeftRight(false, false, -f20_local1 / 2, f20_local1 / 2)
		f20_arg0.lockedIcon:setTopBottom(false, false, -f20_local0 / 2 + f20_local2, f20_local0 / 2 + f20_local2)
	end
	CoD.CardCarousel.Card_GainFocus(f20_arg0, f20_arg1)
end

CoD.LeaderboardCarouselZombie.Card_LoseFocus = function (f21_arg0, f21_arg1)
	if f21_arg0.lockedIcon then
		local f21_local0 = (CoD.LeaderboardCarouselZombie.ItemHeight - CoD.textSize.Default) / 2
		local f21_local1 = f21_local0
		local f21_local2 = -10
		f21_arg0.lockedIcon:beginAnimation("small", CoD.CardCarousel.CardGrowShrinkTime)
		f21_arg0.lockedIcon:setLeftRight(false, false, -f21_local1 / 2, f21_local1 / 2)
		f21_arg0.lockedIcon:setTopBottom(false, false, -f21_local0 / 2 + f21_local2, f21_local0 / 2 + f21_local2)
	end
	CoD.CardCarousel.Card_LoseFocus(f21_arg0, f21_arg1)
end

CoD.LeaderboardCarouselZombie.AddCarousel = function (f22_arg0, f22_arg1, f22_arg2, f22_arg3, f22_arg4)
	local f22_local0 = f22_arg1:addCardCarousel(f22_arg0)
	CoD.LeaderboardCarouselZombie.SetupCardCarouselTitleTextPosition(f22_local0, f22_arg1)
	local f22_local1 = f22_local0:addNewCard()
	CoD.LeaderboardCarouselZombie.SetupCarouselCard(f22_local1, "", nil, nil, nil, 0, 0, 0)
	f22_local1:registerEventHandler("gain_focus", CoD.LeaderboardCarouselZombie.Card_GainFocus)
	f22_local1:registerEventHandler("lose_focus", CoD.LeaderboardCarouselZombie.Card_LoseFocus)
	if f22_arg3 then
		local f22_local2 = (CoD.LeaderboardCarouselZombie.ItemHeight - CoD.textSize.Default) / 2
		local f22_local3 = f22_local2
		local f22_local4 = -10
		f22_local1.lockedIcon = LUI.UIImage.new()
		f22_local1.lockedIcon:setLeftRight(false, false, -f22_local3 / 2, f22_local3 / 2)
		f22_local1.lockedIcon:setTopBottom(false, false, -f22_local2 / 2 + f22_local4, f22_local2 / 2 + f22_local4)
		f22_local1.lockedIcon:setImage(RegisterMaterial("menu_mp_lobby_locked_big"))
		f22_local1:addElement(f22_local1.lockedIcon)
	end
	if f22_arg4 ~= nil then
		f22_local1.hintText = f22_arg4
	end
end

