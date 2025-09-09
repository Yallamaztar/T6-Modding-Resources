require("T6.Menus.CommonChallengeType")
CoD.ChallengesGamemodes = {}
LUI.createMenu.ChallengesGamemodes = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.Menu.New("ChallengesGamemodes")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:setPreviousMenu("Barracks")
	f1_local0.goBack = CoD.ChallengesGamemodes.GoBack
	f1_local0:registerEventHandler("open_challenge_type", CoD.ChallengesGamemodes.OpenChallengesType)
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	f1_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_CHALLENGES_GAME_MODES")))
	local f1_local1 = CoD.CardCarouselList.new(nil, f1_arg0, CoD.Barracks.ItemWidth, CoD.Barracks.ItemHeight, CoD.Barracks.HighlightedItemWidth, CoD.Barracks.HighligtedItemHeight, CoD.Barracks.HintTextParams)
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, true, CoD.textSize.Big + 10, 0)
	f1_local0:addElement(f1_local1)
	CoD.ChallengesGamemodes.AddCarousel(f1_local1)
	if CoD.ChallengesGamemodes.CurrentCarouselInfo then
		f1_local1:setInitialCarousel(CoD.ChallengesGamemodes.CurrentCarouselInfo.carouselIndex, CoD.ChallengesGamemodes.CurrentCarouselInfo.cardIndex)
	end
	f1_local1:focusCurrentCardCarousel(f1_arg0)
	return f1_local0
end

CoD.ChallengesGamemodes.OpenChallengesType = function (f2_arg0, f2_arg1)
	CoD.ChallengesGamemodes.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo(f2_arg1.button)
	CoD.perController[f2_arg1.controller].CommonChallengeTypeData = {
		category = f2_arg1.button.category,
		titleText = f2_arg1.button.titleText,
		gamemodeName = f2_arg1.button.titleText
	}
	f2_arg0:openMenu("CommonChallengeType", f2_arg1.controller)
	f2_arg0:close()
end

CoD.ChallengesGamemodes.GoBack = function (f3_arg0, f3_arg1)
	CoD.ChallengesGamemodes.CurrentCarouselInfo = nil
	CoD.Menu.goBack(f3_arg0, f3_arg1)
end

CoD.ChallengesGamemodes.AddCard = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	local f4_local0 = f4_arg0:addNewCard()
	f4_local0.category = f4_arg2
	f4_local0.hintText = Engine.Localize("MENU_CHALLENGES_TYPE_GAMEMODE_HINT", f4_arg1)
	local f4_local1 = CoD.Barracks.ItemHeight - CoD.textSize.Default
	local f4_local2 = f4_local1
	local f4_local3 = 1.5
	CoD.Barracks.SetupCarouselCard(f4_local0, f4_arg1)
	f4_local0:setupCenterImage(f4_arg3, f4_local1, f4_local2, f4_local3)
	f4_local0:setActionEventName("open_challenge_type")
end

CoD.ChallengesGamemodes.AddCarousel = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = f5_arg0:addCardCarousel(Engine.Localize(""))
	CoD.ChallengesGamemodes.AddCard(f5_local0, Engine.Localize("CHALLENGE_TYPE_TDM"), "tdm", "playlist_tdm")
	CoD.ChallengesGamemodes.AddCard(f5_local0, Engine.Localize("CHALLENGE_TYPE_DM"), "dm", "playlist_ffa")
	CoD.ChallengesGamemodes.AddCard(f5_local0, Engine.Localize("CHALLENGE_TYPE_DOM"), "dom", "playlist_domination")
	CoD.ChallengesGamemodes.AddCard(f5_local0, Engine.Localize("CHALLENGE_TYPE_SD"), "sd", "playlist_search_destroy")
	CoD.ChallengesGamemodes.AddCard(f5_local0, Engine.Localize("CHALLENGE_TYPE_CTF"), "ctf", "playlist_ctf")
	CoD.ChallengesGamemodes.AddCard(f5_local0, Engine.Localize("CHALLENGE_TYPE_HQ"), "hq", "playlist_headquarters")
	CoD.ChallengesGamemodes.AddCard(f5_local0, Engine.Localize("CHALLENGE_TYPE_DEM"), "dem", "playlist_demolition")
	CoD.ChallengesGamemodes.AddCard(f5_local0, Engine.Localize("CHALLENGE_TYPE_KOTH"), "koth", "playlist_koth")
	CoD.ChallengesGamemodes.AddCard(f5_local0, Engine.Localize("MPUI_CONF"), "conf", "playlist_kill_confirm")
	CoD.ChallengesGamemodes.AddCard(f5_local0, Engine.Localize("CHALLENGE_TYPE_SHRP"), "shrp", "playlist_sharpshooter")
	CoD.ChallengesGamemodes.AddCard(f5_local0, Engine.Localize("CHALLENGE_TYPE_SAS"), "sas", "playlist_sticks_and_stones")
	CoD.ChallengesGamemodes.AddCard(f5_local0, Engine.Localize("CHALLENGE_TYPE_OIC"), "oic", "playlist_one_chamber")
	CoD.ChallengesGamemodes.AddCard(f5_local0, Engine.Localize("CHALLENGE_TYPE_GUN"), "gun", "playlist_gungame")
end

