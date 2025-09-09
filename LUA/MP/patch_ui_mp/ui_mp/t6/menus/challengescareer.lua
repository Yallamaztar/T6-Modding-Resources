require("T6.Menus.CommonChallengeType")
CoD.ChallengesCareer = {}
LUI.createMenu.ChallengesCareer = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.Menu.New("ChallengesCareer")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:setPreviousMenu("Barracks")
	f1_local0.goBack = CoD.ChallengesCareer.GoBack
	f1_local0:registerEventHandler("open_challenge_type", CoD.ChallengesCareer.OpenChallengesType)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:addTitle(Engine.Localize("MENU_CHALLENGES_CAREER"))
	local f1_local1 = CoD.CardCarouselList.new(nil, f1_arg0, CoD.Barracks.ItemWidth, CoD.Barracks.ItemHeight, CoD.Barracks.HighlightedItemWidth, CoD.Barracks.HighligtedItemHeight, CoD.Barracks.HintTextParams)
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, true, CoD.textSize.Big + 10, 0)
	f1_local0:addElement(f1_local1)
	CoD.ChallengesCareer.AddCarousel(f1_local1)
	if CoD.ChallengesCareer.CurrentCarouselInfo then
		f1_local1:setInitialCarousel(CoD.ChallengesCareer.CurrentCarouselInfo.carouselIndex, CoD.ChallengesCareer.CurrentCarouselInfo.cardIndex)
	end
	f1_local1:focusCurrentCardCarousel(f1_arg0)
	return f1_local0
end

CoD.ChallengesCareer.OpenChallengesType = function (f2_arg0, f2_arg1)
	CoD.ChallengesCareer.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo(f2_arg1.button)
	CoD.perController[f2_arg1.controller].CommonChallengeTypeData = {
		category = f2_arg1.button.category
	}
	f2_arg0:openMenu("CommonChallengeType", f2_arg1.controller)
	f2_arg0:close()
end

CoD.ChallengesCareer.GoBack = function (f3_arg0, f3_arg1)
	CoD.ChallengesCareer.CurrentCarouselInfo = nil
	CoD.Menu.goBack(f3_arg0, f3_arg1)
end

CoD.ChallengesCareer.AddCard = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	local f4_local0 = f4_arg0:addNewCard()
	f4_local0.category = f4_arg2
	f4_local0.hintText = f4_arg4
	local f4_local1 = CoD.Barracks.ItemHeight - CoD.textSize.Default
	local f4_local2 = f4_local1
	local f4_local3 = 1.5
	CoD.Barracks.SetupCarouselCard(f4_local0, f4_arg1)
	f4_local0:setupCenterImage(f4_arg3, f4_local1, f4_local2, f4_local3)
	f4_local0:setActionEventName("open_challenge_type")
end

CoD.ChallengesCareer.AddCarousel = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = f5_arg0:addCardCarousel(Engine.Localize(""))
	CoD.ChallengesCareer.AddCard(f5_local0, Engine.Localize("MENU_CHALLENGE_CATEGORY_TOTALMASTERY"), "totalmastery", "barrack_career_mastery", Engine.Localize("MENU_CHALLENGE_CATEGORY_TOTALMASTERY_HINT"))
	CoD.ChallengesCareer.AddCard(f5_local0, Engine.Localize("MENU_CHALLENGE_CATEGORY_OPERATIONS"), "operations", "barrack_career_operations", Engine.Localize("MENU_CHALLENGE_CATEGORY_OPERATIONS_HINT"))
	CoD.ChallengesCareer.AddCard(f5_local0, Engine.Localize("MENU_CHALLENGE_CATEGORY_COMBAT"), "combat", "barrack_career_precision", Engine.Localize("MENU_CHALLENGE_CATEGORY_COMBAT_HINT"))
end

