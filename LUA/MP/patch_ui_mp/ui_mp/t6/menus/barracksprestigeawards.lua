CoD.BarracksPrestigeAwards = {}
LUI.createMenu.BarracksPrestigeAwards = function (f1_arg0)
	if Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE) then
		Engine.ExecNow(event.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE)
		return 
	elseif Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE_EXTRAS) then
		Engine.ExecNow(f1_arg0, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE_EXTRAS)
		return 
	else
		local f1_local0 = CoD.Menu.New("BarracksPrestigeAwards")
		f1_local0:addLargePopupBackground()
		f1_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_PRESTIGE_AWARDS")))
		f1_local0:addBackButton()
		f1_local0:addSelectButton()
		local f1_local1 = CoD.textSize.Big + 10
		local f1_local2 = CoD.CardCarouselList.new(nil, f1_arg0, CoD.Barracks.ItemWidth, CoD.Barracks.ItemHeight, CoD.Barracks.HighlightedItemWidth, CoD.Barracks.HighligtedItemHeight, CoD.Barracks.HintTextParams)
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
			top = f1_local2.cardCarouselSize + 70,
			bottom = 0
		})
		f1_local2.titleListContainer:animateToState("default")
		f1_local1 = f1_local1 + f1_local2.cardCarouselSize - 7
		CoD.BarracksPrestigeAwards.AddCarousels(f1_local2, f1_arg0)
		f1_local2:focusCurrentCardCarousel(f1_arg0)
		f1_local0:registerEventHandler("prestige_reset_stats", CoD.BarracksPrestigeAwards.PrestigeResetStats)
		f1_local0:registerEventHandler("prestige_respec", CoD.BarracksPrestigeAwards.PrestigeRespec)
		f1_local0:registerEventHandler("prestige_extra_cac", CoD.BarracksPrestigeAwards.PrestigeExtraCAC)
		f1_local0:registerEventHandler("prestige_action_complete", CoD.BarracksPrestigeAwards.PrestigeActionComplete)
		return f1_local0
	end
end

CoD.BarracksPrestigeAwards.PrestigeResetStats = function (f2_arg0, f2_arg1)
	if Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE) then
		Engine.ExecNow(f2_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE)
		return 
	elseif Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE_EXTRAS) then
		Engine.ExecNow(f2_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE_EXTRAS)
		return 
	else
		f2_arg0:openPopup("ConfirmPrestige", f2_arg1.controller, {
			action = "resetstats_confirm",
			title = "MENU_FRESH_START",
			message = "MENU_PRESTIGE_FRESH_START_DESC",
			choiceAText = Engine.Localize("MENU_USE_FRESH_START"),
			image = "menu_prestige_icon_freshstart"
		})
	end
end

CoD.BarracksPrestigeAwards.PrestigeRespec = function (f3_arg0, f3_arg1)
	if Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE) then
		Engine.ExecNow(f3_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE)
		return 
	elseif Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE_EXTRAS) then
		Engine.ExecNow(f3_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE_EXTRAS)
		return 
	else
		f3_arg0:openPopup("ConfirmPrestige", f3_arg1.controller, {
			action = "respec_confirm",
			title = "MENU_REFUND",
			message = "MENU_PRESTIGE_REFUND_DESC",
			choiceAText = Engine.Localize("MENU_USE_REFUND"),
			image = "menu_prestige_icon_refund"
		})
	end
end

CoD.BarracksPrestigeAwards.PrestigeExtraCAC = function (f4_arg0, f4_arg1)
	if Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE) then
		Engine.ExecNow(f4_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE)
		return 
	elseif Engine.IsFeatureBanned(CoD.FEATURE_BAN_PRESTIGE_EXTRAS) then
		Engine.ExecNow(f4_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_PRESTIGE_EXTRAS)
		return 
	else
		f4_arg0:openPopup("ConfirmPrestige", f4_arg1.controller, {
			action = "extraCAC_confirm",
			title = "MENU_EXTRA_CAC",
			message = "MENU_PRESTIGE_EXTRACAC_DESC",
			choiceAText = Engine.Localize("MENU_USE_EXTRACAC"),
			image = "menu_prestige_icon_cacslot"
		})
	end
end

CoD.BarracksPrestigeAwards.PrestigeActionComplete = function (f5_arg0, f5_arg1)
	f5_arg0:goBack(f5_arg1.controller)
end

CoD.BarracksPrestigeAwards.AddCarousels = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0:addCardCarousel("")
	CoD.Barracks.SetupCardCarouselTitleTextPosition(f6_local0, f6_arg0)
	local f6_local1 = 110
	local f6_local2 = f6_local1
	local f6_local3 = 1.8
	if not CoD.PrestigeFinish(f6_arg1) then
		local f6_local4 = f6_local0:addNewCard()
		CoD.Barracks.SetupCarouselCard(f6_local4, Engine.Localize("MPUI_RESPEC"))
		f6_local4.hintText = Engine.Localize("MENU_RESPEC_HINT")
		f6_local4:setActionEventName("prestige_respec")
		f6_local4:setupCenterImage("menu_prestige_icon_refund", f6_local2, f6_local1, f6_local3)
	end
	if not Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) and not Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) and Engine.GetCustomClassCount(f6_arg1) < 10 then
		local f6_local4 = f6_local0:addNewCard()
		CoD.Barracks.SetupCarouselCard(f6_local4, Engine.Localize("MPUI_EXTRA_CAC"))
		f6_local4.hintText = Engine.Localize("MENU_EXTRA_CAC_HINT")
		f6_local4:setActionEventName("prestige_extra_cac")
		f6_local4:setupCenterImage("menu_prestige_icon_cacslot", f6_local2, f6_local1, f6_local3)
	end
	local f6_local4 = f6_local0:addNewCard()
	CoD.Barracks.SetupCarouselCard(f6_local4, Engine.Localize("MENU_FRESH_START"))
	f6_local4.hintText = Engine.Localize("MENU_RESET_STATS_HINT")
	f6_local4:setActionEventName("prestige_reset_stats")
	f6_local4:setupCenterImage("menu_prestige_icon_freshstart", f6_local2, f6_local1, f6_local3)
end

