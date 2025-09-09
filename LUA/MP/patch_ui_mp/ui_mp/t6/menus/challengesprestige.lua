require("T6.Menus.CommonChallengeType")
CoD.ChallengesPrestige = {}
LUI.createMenu.ChallengesPrestige = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.Menu.New("ChallengesPrestige")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:setPreviousMenu("Barracks")
	f1_local0.goBack = CoD.ChallengesPrestige.GoBack
	f1_local0:registerEventHandler("open_challenge_type", CoD.ChallengesPrestige.OpenChallengesType)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MPUI_PRESTIGE")))
	local f1_local1 = CoD.CardCarouselList.new(nil, f1_arg0, CoD.Barracks.ItemWidth, CoD.Barracks.ItemHeight, CoD.Barracks.HighlightedItemWidth, CoD.Barracks.HighligtedItemHeight, CoD.Barracks.HintTextParams)
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, true, CoD.textSize.Big + 10, 0)
	f1_local0:addElement(f1_local1)
	CoD.ChallengesPrestige.AddCarousel(f1_local1)
	if CoD.ChallengesPrestige.CurrentCarouselInfo then
		f1_local1:setInitialCarousel(CoD.ChallengesPrestige.CurrentCarouselInfo.carouselIndex, CoD.ChallengesPrestige.CurrentCarouselInfo.cardIndex)
	end
	f1_local1:focusCurrentCardCarousel(f1_arg0)
	return f1_local0
end

CoD.ChallengesPrestige.OpenChallengesType = function (f2_arg0, f2_arg1)
	CoD.ChallengesPrestige.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo(f2_arg1.button)
	CoD.perController[f2_arg1.controller].CommonChallengeTypeData = {
		category = f2_arg1.button.category
	}
	f2_arg0:openMenu("CommonChallengeType", f2_arg1.controller)
	f2_arg0:close()
end

CoD.ChallengesPrestige.GoBack = function (f3_arg0, f3_arg1)
	CoD.ChallengesPrestige.CurrentCarouselInfo = nil
	CoD.Menu.goBack(f3_arg0, f3_arg1)
end

CoD.ChallengesPrestige.AddCard = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	local f4_local0 = f4_arg0:addNewCard()
	f4_local0.hintText = f4_arg4
	f4_local0.category = f4_arg2
	local f4_local1 = CoD.Barracks.ItemHeight - CoD.textSize.Default
	local f4_local2 = f4_local1
	local f4_local3 = 1.5
	CoD.Barracks.SetupCarouselCard(f4_local0, f4_arg1)
	f4_local0:setupCenterImage(f4_arg3, f4_local1, f4_local2, f4_local3)
	f4_local0:setActionEventName("open_challenge_type")
end

CoD.ChallengesPrestige.AddCarousel = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = f5_arg0:addCardCarousel(Engine.Localize(""))
	CoD.ChallengesPrestige.AddCard(f5_local0, Engine.Localize("MENU_CHALLENGE_CATEGORY_SPECIALOPTICS"), "specialoptics", "barrack_prestige_specialoptics", Engine.Localize("MENU_CHALLENGE_CATEGORY_SPECIALOPTICS_HINT"))
	CoD.ChallengesPrestige.AddCard(f5_local0, Engine.Localize("MENU_CHALLENGE_CATEGORY_COMBATEFFICIENCY"), "combatefficiency", "barrack_prestige_combat_eff", Engine.Localize("MENU_CHALLENGE_CATEGORY_COMBATEFFICIENCY_HINT"))
	CoD.ChallengesPrestige.AddCard(f5_local0, Engine.Localize("MENU_CHALLENGE_CATEGORY_EQUIPMENT"), "equipment", "barrack_prestige_equip", Engine.Localize("MENU_CHALLENGE_CATEGORY_EQUIPMENT_HINT"))
	CoD.ChallengesPrestige.AddCard(f5_local0, Engine.Localize("MENU_CHALLENGE_CATEGORY_PERKS"), "perks", "barrack_prestige_perks", Engine.Localize("MENU_CHALLENGE_CATEGORY_PERKS_HINT"))
	CoD.ChallengesPrestige.AddCard(f5_local0, Engine.Localize("MENU_CHALLENGE_CATEGORY_WILDCARDS"), "wildcards", "barrack_prestige_wc", Engine.Localize("MENU_CHALLENGE_CATEGORY_WILDCARDS_HINT"))
end

