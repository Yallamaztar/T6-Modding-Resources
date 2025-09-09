require("T6.Menus.CommonChallengeType")
CoD.ChallengesAssignments = {}
LUI.createMenu.ChallengesAssignments = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.Menu.New("ChallengesAssignments")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:setPreviousMenu("Barracks")
	f1_local0.goBack = CoD.ChallengesAssignments.GoBack
	f1_local0:registerEventHandler("open_challenge_type", CoD.ChallengesAssignments.OpenChallengesType)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_CHALLENGES_ASSIGNMENTS")))
	local f1_local1 = CoD.CardCarouselList.new(nil, f1_arg0, CoD.Barracks.ItemWidth, CoD.Barracks.ItemHeight, CoD.Barracks.HighlightedItemWidth, CoD.Barracks.HighligtedItemHeight, CoD.Barracks.HintTextParams)
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, true, CoD.textSize.Big + 10, 0)
	f1_local0:addElement(f1_local1)
	CoD.ChallengesAssignments.AddCarousel(f1_local1)
	if CoD.ChallengesAssignments.CurrentCarouselInfo then
		f1_local1:setInitialCarousel(CoD.ChallengesAssignments.CurrentCarouselInfo.carouselIndex, CoD.ChallengesAssignments.CurrentCarouselInfo.cardIndex)
	end
	f1_local1:focusCurrentCardCarousel(f1_arg0)
	return f1_local0
end

CoD.ChallengesAssignments.OpenChallengesType = function (f2_arg0, f2_arg1)
	CoD.ChallengesAssignments.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo(f2_arg1.button)
	CoD.perController[f2_arg1.controller].CommonChallengeTypeData = {
		category = f2_arg1.button.category
	}
	f2_arg0:openMenu("CommonChallengeType", f2_arg1.controller)
	f2_arg0:close()
end

CoD.ChallengesAssignments.GoBack = function (f3_arg0, f3_arg1)
	CoD.ChallengesAssignments.CurrentCarouselInfo = nil
	CoD.Menu.goBack(f3_arg0, f3_arg1)
end

CoD.ChallengesAssignments.AddCard = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
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

CoD.ChallengesAssignments.AddCarousel = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = f5_arg0:addCardCarousel(Engine.Localize(""))
	CoD.ChallengesAssignments.AddCard(f5_local0, Engine.Localize("MENU_CHALLENGE_CATEGORY_BOOTCAMP"), "bootcamp", "barrack_ass_bootcamp", Engine.Localize("MENU_CHALLENGE_CATEGORY_BOOTCAMP_HINT"))
	CoD.ChallengesAssignments.AddCard(f5_local0, Engine.Localize("MENU_CHALLENGE_CATEGORY_KILLER"), "killer", "barrack_ass_killer", Engine.Localize("MENU_CHALLENGE_CATEGORY_KILLER_HINT"))
	CoD.ChallengesAssignments.AddCard(f5_local0, Engine.Localize("MENU_CHALLENGE_CATEGORY_HUMILIATION"), "humiliation", "barrack_ass_humiliation", Engine.Localize("MENU_CHALLENGE_CATEGORY_HUMILIATION_HINT"))
	CoD.ChallengesAssignments.AddCard(f5_local0, Engine.Localize("MENU_CHALLENGE_CATEGORY_FIELDSPECIALIST"), "fieldspecialist", "barrack_ass_fieldspecial", Engine.Localize("MENU_CHALLENGE_CATEGORY_FIELDSPECIALIST_HINT"))
	CoD.ChallengesAssignments.AddCard(f5_local0, Engine.Localize("MENU_CHALLENGE_CATEGORY_PRECISION"), "precision", "barrack_ass_precision", Engine.Localize("MENU_CHALLENGE_CATEGORY_PRECISION_HINT"))
end

