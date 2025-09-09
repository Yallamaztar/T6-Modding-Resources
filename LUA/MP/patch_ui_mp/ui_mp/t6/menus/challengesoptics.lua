require("T6.Menus.OpticChallengeType")
CoD.ChallengesOptics = {}
CoD.ChallengesOptics.IconOffset = 20
LUI.createMenu.ChallengesOptics = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.Menu.New("ChallengesOptics")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:setPreviousMenu("Barracks")
	f1_local0.goBack = CoD.ChallengesOptics.GoBack
	f1_local0:registerEventHandler("open_challenge_type", CoD.ChallengesOptics.OpenChallengesType)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_CHALLENGES_OPTICS")))
	local f1_local1 = CoD.CardCarouselList.new(nil, f1_arg0, CoD.Barracks.ItemWidth, CoD.Barracks.ItemHeight, CoD.Barracks.HighlightedItemWidth, CoD.Barracks.HighligtedItemHeight, CoD.Barracks.HintTextParams)
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, true, CoD.textSize.Big + 10, 0)
	f1_local0:addElement(f1_local1)
	CoD.ChallengesOptics.AddCarousel(f1_local1)
	if CoD.ChallengesOptics.CurrentCarouselInfo then
		f1_local1:setInitialCarousel(CoD.ChallengesOptics.CurrentCarouselInfo.carouselIndex, CoD.ChallengesOptics.CurrentCarouselInfo.cardIndex)
	end
	f1_local1:focusCurrentCardCarousel(f1_arg0)
	return f1_local0
end

CoD.ChallengesOptics.OpenChallengesType = function (f2_arg0, f2_arg1)
	CoD.ChallengesOptics.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo(f2_arg1.button)
	CoD.perController[f2_arg1.controller].OpticChallengeTypeData = {
		attachmentIndex = f2_arg1.button.attachmentIndex,
		attachmentRef = f2_arg1.button.attachmentRef
	}
	f2_arg0:openMenu("OpticChallengeType", f2_arg1.controller)
	f2_arg0:close()
end

CoD.ChallengesOptics.GoBack = function (f3_arg0, f3_arg1)
	CoD.ChallengesOptics.CurrentCarouselInfo = nil
	CoD.Menu.goBack(f3_arg0, f3_arg1)
end

CoD.ChallengesOptics.AddCards = function (f4_arg0)
	for f4_local10, f4_local11 in ipairs(CoD.CACUtility.attachmentReferences) do
		for f4_local7, f4_local8 in ipairs(CoD.CACUtility.attachmentsWithCustReticle) do
			if f4_local11 == f4_local8 then
				local f4_local3 = f4_arg0:addNewCard()
				f4_local3.category = category
				f4_local3.attachmentIndex = f4_local10 - 1
				f4_local3.attachmentRef = f4_local11
				f4_local3.hintText = Engine.Localize("MENU_CHALLENGES_OPTICS_TYPES_HINT", UIExpression.GetAttachmentName(nil, f4_local3.attachmentIndex))
				local f4_local4 = CoD.Barracks.ItemHeight - CoD.textSize.Default - CoD.ChallengesOptics.IconOffset
				local f4_local5 = f4_local4
				local f4_local6 = 1.5
				CoD.Barracks.SetupCarouselCard(f4_local3, Engine.Localize(UIExpression.GetAttachmentName(nil, f4_local3.attachmentIndex)))
				f4_local3:setupCenterImage(UIExpression.GetAttachmentImage(nil, f4_local3.attachmentIndex), f4_local5, f4_local4, f4_local6)
				f4_local3:setActionEventName("open_challenge_type")
			end
		end
	end
end

CoD.ChallengesOptics.AddCarousel = function (f5_arg0, f5_arg1)
	CoD.ChallengesOptics.AddCards(f5_arg0:addCardCarousel(Engine.Localize("")))
end

