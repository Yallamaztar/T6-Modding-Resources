require("T6.CACClassLoadout")
require("T6.SideBrackets")
require("T6.Menus.Bracket")
require("T6.BorderLite")
require("T6.BorderDipLarge")
require("T6.Menus.ConfirmSFNotification")
require("T6.Menus.ConfirmSFAvailable")
require("T6.Menus.ConfirmNewStory")
require("T6.Menus.OutOfSFUnits")
require("T6.Menus.StoryOverviewMenu")
require("T6.Unlockables")
CoD.CampaignMissionBriefing = {}
CoD.CampaignMissionBriefing.MenuHeight = 512
CoD.CampaignMissionBriefing.LoadDefault = true
CoD.CampaignMissionBriefing.BriefingWidth = 450
CoD.CampaignMissionBriefing.ImageWidth = 800
CoD.CampaignMissionBriefing.lastMapName = ""
local f0_local0, f0_local1, f0_local2, f0_local3, f0_local4, f0_local5, f0_local6, f0_local7 = nil
CoD.CampaignMissionBriefing.RTSNotificationPrompt = function (f1_arg0, f1_arg1)
	f1_arg0:openPopup("ConfirmSFNotification", UIExpression.GetPrimaryController(), f1_arg1)
end

CoD.CampaignMissionBriefing.SFAvailablePrompt = function (f2_arg0, f2_arg1)
	f2_arg0:openPopup("ConfirmSFAvailable", UIExpression.GetPrimaryController(), f2_arg1)
end

CoD.CampaignMissionBriefing.ConfirmNewStory = function (f3_arg0, f3_arg1)
	f3_arg0:openPopup("ConfirmNewStory", UIExpression.GetPrimaryController())
end

CoD.CampaignMissionBriefing.CustomizeLoadout = function (f4_arg0, f4_arg1)
	Engine.PlaySound("uin_main_enter")
	CoD.CampaignMissionBriefing.LoadDefault = false
	CoD.CACClassLoadout.PreviousSelection = ""
	CoD.CACLoadOutMenu.AnimateLoadout = true
	f4_arg0:swapMenu("CACLoadOutMenu", f4_arg1.controller, {
		previousMenu = "MissionBriefingMenu"
	})
	f4_arg0:close()
end

CoD.CampaignMissionBriefing.LaunchLevel = function (f5_arg0, f5_arg1)
	CoD.CampaignMissionBriefing.LoadDefault = true
	local f5_local0 = f5_arg1.controller
	local f5_local1 = CoD.perController[f5_local0].classNumInternal
	local f5_local2 = f5_arg0.carousel.list.containers[f5_arg0.carousel.m_currentItem].content
	if Dvar.ui_isSaving:get() or Engine.GetNumPendingSaves() > 0 then
		return 
	end
	local f5_local3 = CoD.GetClassItem(f5_arg1.controller, f5_local1, CoD.CACUtility.loadoutSlotNames.primaryWeapon)
	if f5_local3 == nil or f5_local3 == 0 then
		return 
	end
	Dvar.ui_aarmapname:set(f5_local2.mapname)
	local f5_local4 = UIExpression.GetDStat(f5_local0, "PlayerCareerStats", "unitsAvailable")
	Dvar.ui_isrtstutorial:set(0)
	local f5_local5 = UIExpression.GetDStat(f5_local0, "PlayerCareerStats", "storypoints", "SO_WAR_TUTORIAL_COMPLETE")
	if not f5_local2.isRtsMap then
		Engine.Exec(f5_arg1.controller, "launchlevel " .. f5_local2.mapname)
	elseif f5_local4 <= 0 then
		local f5_local6 = f5_arg0:openPopup("OutOfSFUnits", f5_local0)
		f5_local6.close = CoD.CampaignMissionBriefing.CloseBackground
	elseif f5_local5 == 0 then
		local f5_local7 = UIExpression.TableLookup(f5_local0, CoD.AARUtility.LevelTable, 0, tonumber(UIExpression.TableLookup(f5_local0, CoD.AARUtility.LevelTable, 0, "rts_tutorial_index", 1)), 1)
		Dvar.ui_isrtstutorial:set(1)
		Engine.SendMenuResponse(f5_arg1.controller, "launchlevel", f5_local7)
	else
		Engine.SendMenuResponse(f5_arg1.controller, "launchlevel", f5_local2.mapname)
	end
end

CoD.CampaignMissionBriefing.OpenCombatRecord = function (f6_arg0, f6_arg1)
	CoD.CampaignMissionBriefing.LoadDefault = false
	CoD.CareerOverviewMenu.MapHighlight = Dvar.ui_mapname:get()
	CoD.StoryOverviewMenu.MapHighlight = CoD.CareerOverviewMenu.MapHighlight
	Engine.PlaySound(CoD.MissionSelect.CareerRecordActionSFX)
	f6_arg0:swapMenu("CareerOverviewMenu", f6_arg1.controller, {
		previousMenu = "CampaignMissionBriefingMenu"
	})
	f6_arg0:close()
end

function FadeArrows(f7_arg0, f7_arg1)
	local f7_local0 = f7_arg0.m_currentItem
	local f7_local1 = f7_arg0.list:getNumChildren()
	if f7_arg0.leftArrow then
		if f7_local0 == 1 then
			f7_arg0.leftArrow.disable = true
		else
			f7_arg0.leftArrow.disable = false
		end
		f7_arg0.leftBracket:animateBracket()
		f7_arg0.leftArrow:animateToState("offset", 250)
		f7_arg0.leftArrow:animateToState("default", 350)
	end
	if f7_arg0.rightArrow then
		if f7_local0 == f7_local1 then
			f7_arg0.rightArrow.disable = true
		else
			f7_arg0.rightArrow.disable = false
		end
		f7_arg0.rightBracket:animateBracket()
		f7_arg0.rightArrow:animateToState("offset", 250)
		f7_arg0.rightArrow:animateToState("default", 350)
	end
end

f0_local0 = function (f8_arg0, f8_arg1)
	local f8_local0 = CoD.Bracket.CreateLeftBracket({
		red = CoD.trueOrange.r,
		green = CoD.trueOrange.g,
		blue = CoD.trueOrange.b,
		left = -f8_arg1 / 2 + CoD.Bracket.Width / 2
	})
	local f8_local1 = LUI.UIImage.new()
	f8_local1:setLeftRight(true, false, 0, 32)
	f8_local1:setTopBottom(true, true, 8, -8)
	f8_local1:setImage(RegisterMaterial("menu_mp_cac_second_wc"))
	f8_local1:setAlpha(1)
	f8_local0:addElement(f8_local1)
	f8_arg0.leftBracket = f8_local0
	f8_arg0:addElement(f8_local0)
	local f8_local2 = CoD.Bracket.CreateRightBracket({
		red = CoD.trueOrange.r,
		green = CoD.trueOrange.g,
		blue = CoD.trueOrange.b,
		right = f8_arg1 / 2 - CoD.Bracket.Width / 2
	})
	local f8_local3 = LUI.UIImage.new()
	f8_local3:setLeftRight(false, true, -32, 0)
	f8_local3:setTopBottom(true, true, 8, -8)
	f8_local3:setImage(RegisterMaterial("menu_mp_cac_second_wc"))
	f8_local3:setAlpha(1)
	f8_local3:setZRot(180)
	f8_local2:addElement(f8_local3)
	f8_arg0.rightBracket = f8_local2
	f8_arg0:addElement(f8_local2)
end

f0_local1 = function (f9_arg0, f9_arg1)
	local f9_local0 = 32
	local f9_local1 = 16
	local f9_local2 = f9_local1 / 2
	local f9_local3 = LUI.UIImage.new()
	f9_local3:setImage(RegisterMaterial("menu_strikeforce_arrow"))
	f9_local3:setTopBottom(false, false, -f9_local0 / 2, f9_local0 / 2)
	f9_local3:setLeftRight(false, false, -f9_arg1 / 2 - f9_local1 - f9_local2, -f9_arg1 / 2 - f9_local2)
	f9_local3:registerAnimationState("offset", {
		leftAnchor = false,
		rightAnchor = false,
		left = -f9_arg1 / 2 - f9_local1 - f9_local2 - 15,
		right = -f9_arg1 / 2 - f9_local2 - 15
	})
	f9_local3:registerAnimationState("default", {
		leftAnchor = false,
		rightAnchor = false,
		left = -f9_arg1 / 2 - f9_local1 - f9_local2,
		right = -f9_arg1 / 2 - f9_local2
	})
	f9_local3:setZRot(180)
	f9_local3:setAlpha(0.75)
	f9_local3.alpha = 0.75
	f9_local3.maxAlpha = 1
	f9_local3.minAlpha = 0.4
	f9_local3.glowRate = 0.02
	f9_local3:registerEventHandler("glow_background", f0_local3)
	f9_arg0.leftArrow = f9_local3
	f9_arg0:addElement(LUI.UITimer.new(0.1, "glow_background", false, f9_local3))
	f9_arg0:addElement(f9_local3)
	local f9_local4 = LUI.UIImage.new()
	f9_local4:setImage(RegisterMaterial("menu_strikeforce_arrow"))
	f9_local4:setTopBottom(false, false, -f9_local0 / 2, f9_local0 / 2)
	f9_local4:setLeftRight(false, false, f9_arg1 / 2 + f9_local2, f9_arg1 / 2 + f9_local1 + f9_local2)
	f9_local4:registerAnimationState("offset", {
		leftAnchor = false,
		rightAnchor = false,
		left = f9_arg1 / 2 + f9_local2 + 15,
		right = f9_arg1 / 2 + f9_local1 + f9_local2 + 15
	})
	f9_local4:registerAnimationState("default", {
		leftAnchor = false,
		rightAnchor = false,
		left = f9_arg1 / 2 + f9_local2,
		right = f9_arg1 / 2 + f9_local1 + f9_local2
	})
	f9_local4:setAlpha(0.75)
	f9_local4.alpha = 0.75
	f9_local4.maxAlpha = 1
	f9_local4.minAlpha = 0.4
	f9_local4.glowRate = 0.02
	f9_local4:registerEventHandler("glow_background", f0_local3)
	f9_arg0.rightArrow = f9_local4
	f9_arg0:addElement(LUI.UITimer.new(0.1, "glow_background", false, f9_local4))
	f9_arg0:addElement(f9_local4)
end

f0_local6 = function (f10_arg0, f10_arg1)
	f10_arg0:dispatchEventToParent({
		name = "gamepad_button",
		controller = f10_arg1.controller,
		button = "left",
		down = true,
		immediate = true,
		dummy = true,
		buttonRepeat = true
	})
end

f0_local7 = function (f11_arg0, f11_arg1)
	f11_arg0:dispatchEventToParent({
		name = "gamepad_button",
		controller = f11_arg1.controller,
		button = "right",
		down = true,
		immediate = true,
		dummy = true,
		buttonRepeat = true
	})
end

f0_local5 = function (f12_arg0, f12_arg1)
	local f12_local0 = 30
	
	local leftMouseListener = LUI.UIElement.new()
	leftMouseListener:setLeftRight(false, false, -f12_arg1 / 2 - f12_local0, -f12_arg1 / 2)
	leftMouseListener:setTopBottom(true, true, 0, 0)
	f12_arg0:addElement(leftMouseListener)
	f12_arg0.leftMouseListener = leftMouseListener
	
	leftMouseListener:setHandleMouse(true)
	leftMouseListener:registerEventHandler("leftmousedown", CoD.NullFunction)
	leftMouseListener:registerEventHandler("leftmouseup", f0_local6)
	
	local rightMouseListener = LUI.UIElement.new()
	rightMouseListener:setLeftRight(false, false, f12_arg1 / 2, f12_arg1 / 2 + f12_local0)
	rightMouseListener:setTopBottom(true, true, 0, 0)
	f12_arg0:addElement(rightMouseListener)
	f12_arg0.rightMouseListener = rightMouseListener
	
	rightMouseListener:setHandleMouse(true)
	rightMouseListener:registerEventHandler("leftmousedown", CoD.NullFunction)
	rightMouseListener:registerEventHandler("leftmouseup", f0_local7)
end

CoD.CampaignMissionBriefing.ButtonPromptBack = function (f13_arg0, f13_arg1)
	Dvar.ui_campaignstate:set(0)
	Engine.SendMenuResponse(f13_arg1.controller, "campaign_state", "stop")
	Engine.SendMenuResponse(f13_arg1.controller, "luisystem", "modal_stop")
	CoD.Menu.newStrikeForceAvailable = false
	f13_arg0:returnToPreviousMenu(f13_arg1.controller)
end

CoD.CampaignMissionBriefing.ButtonPromptFriendsMenu = function (f14_arg0, f14_arg1)
	if not CoD.isPS3 or UIExpression.IsSubUser(f14_arg1.controller) ~= 1 then
		f14_arg0:openMenu("FriendsList", f14_arg1.controller, {
			previousMenu = "CampaignMissionBriefingMenu"
		})
		f14_arg0:close()
	end
end

LUI.createMenu.CampaignMissionBriefingMenu = function (f15_arg0)
	if f15_arg0 == nil then
		f15_arg0 = UIExpression.GetPrimaryController()
	end
	local f15_local0 = CoD.Menu.New("CampaignMissionBriefingMenu")
	f15_local0:setPreviousMenu("CampaignMenu")
	f15_local0:addTitle(Engine.Localize("SPUI_MISSION_BRIEFING_CAPS"), LUI.Alignment.Center)
	f15_local0:registerEventHandler("button_prompt_launch_game", CoD.CampaignMissionBriefing.LaunchLevel)
	f15_local0:registerEventHandler("button_customize_loadout", CoD.CampaignMissionBriefing.CustomizeLoadout)
	f15_local0:registerEventHandler("button_combat_record", CoD.CampaignMissionBriefing.OpenCombatRecord)
	f15_local0:registerEventHandler("scroll_changed", CoD.CampaignMissionBriefing.CarouselScroll)
	f15_local0:registerEventHandler("open_sf_available_popup", CoD.CampaignMissionBriefing.SFAvailablePrompt)
	f15_local0:registerEventHandler("sf_available", CoD.CampaignMissionBriefing.SFAvailablePrompt)
	f15_local0:registerEventHandler("button_prompt_back", CoD.CampaignMissionBriefing.ButtonPromptBack)
	f15_local0.startMission = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_START_LEVEL"), f15_local0, "button_prompt_launch_game")
	f15_local0:addLeftButtonPrompt(f15_local0.startMission)
	f15_local0:addBackButton()
	local f15_local1 = CoD.ButtonPrompt.new
	local f15_local2 = "alt1"
	local f15_local3 = Engine.Localize("SPUI_CAREER_RECORD")
	local f15_local4 = f15_local0
	local f15_local5 = "button_combat_record"
	local f15_local6, f15_local7 = false
	local f15_local8, f15_local9 = false
	f15_local0.openCombatRecordPrompt = f15_local1(f15_local2, f15_local3, f15_local4, f15_local5, f15_local6, f15_local7, f15_local8, f15_local9, "R")
	f15_local0:addLeftButtonPrompt(f15_local0.openCombatRecordPrompt)
	if CoD.isWIIU then
		f15_local0:registerEventHandler("button_prompt_friends", CoD.CampaignMissionBriefing.ButtonPromptFriendsMenu)
		f15_local0:addFriendsButtonSPMainMenu()
	end
	f15_local1 = 475
	f15_local2 = 900
	f15_local3 = 373.33
	f15_local4 = 180.56
	f15_local5 = -275
	f15_local6 = 1.8
	f15_local7 = 250
	f15_local8 = 30
	f15_local9 = 50
	local f15_local10 = -(f15_local2 - f15_local1) / 2
	local f15_local11 = CoD.HorizontalCarousel.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f15_local10,
		right = f15_local10 + f15_local2,
		topAnchor = true,
		bottomAnchor = false,
		top = f15_local9 + CoD.CACUtility.TopAnchor,
		bottom = f15_local9 + CoD.CACUtility.TopAnchor + f15_local4 * f15_local6 - f15_local8
	}, f15_local3, f15_local4, f15_local5, f15_local6, f15_local7, true)
	f15_local0.carousel = f15_local11
	f15_local0.carousel:setMouseRange(1)
	f15_local0:addElement(f15_local11)
	if CoD.useMouse and f15_local11.mouseDragListener then
		local f15_local12 = f15_local3 / 2
		f15_local11.mouseDragListener:setLeftRight(false, false, -f15_local12, f15_local12)
		f15_local11.mouseDragListener:setTopBottom(true, true, 0, -CoD.HorizontalCarousel.MiniCarouselSize)
	end
	f15_local11.leftButtonRepeater.minDelay = 420
	f15_local11.rightButtonRepeater.minDelay = 420
	f15_local11.leftButtonRepeater.delay = 420
	f15_local11.rightButtonRepeater.delay = 420
	f15_local11.leftButtonRepeater.delayReduction = 0
	f15_local11.rightButtonRepeater.delayReduction = 0
	f15_local11.list:setMouseDisabled(true)
	f15_local11:registerEventHandler("carousel_scroll", FadeArrows)
	local f15_local12, f15_local13, f15_local14, f15_local15 = CoD.CampaignMissionBriefing.AddMapsToCarousel(f15_local0, f15_arg0)
	local f15_local16 = UIExpression.GetDStat(f15_arg0, "PlayerStatsList", "HIGHESTLEVELCOMPLETED", "StatValue")
	if f15_local0.carousel.list:getNumChildren() == 1 then
		f15_local0.carousel.miniList:close()
		f15_local0.carousel.miniList = nil
		if f15_local16 == 0 and UIExpression.GetDStat(f15_arg0, "PlayerCareerStats", "storypoints", "MENU_MISSION_BRIEFING") == 0 then
			f15_local0:registerEventHandler("new_story", CoD.CampaignMissionBriefing.ConfirmNewStory)
			f15_local0:addElement(LUI.UITimer.new(3, "new_story", true))
			Engine.SetStoryPointStat("MENU_MISSION_BRIEFING", 1)
			CoD.Unlockables.ClearLevelUnlockables()
		end
	else
		if f15_local16 == 4 and UIExpression.GetDStat(f15_arg0, "PlayerCareerStats", "storypoints", "MENU_SO_INSTRUCTIONS") == 0 then
			f15_local0:registerEventHandler("rts_notification", CoD.CampaignMissionBriefing.RTSNotificationPrompt)
			f15_local0:addElement(LUI.UITimer.new(3, {
				name = "rts_notification",
				mapAlias = f15_local12,
				curMapIndex = f15_local13
			}, true))
			Engine.SetStoryPointStat("MENU_SO_INSTRUCTIONS", 1)
			Engine.SetStoryPointStat("MENU_SO_WAR_DRONE", 1)
			Engine.SetStoryPointStat("MENU_SO_WAR_SINGAPORE", 1)
		elseif f15_local16 == 8 and UIExpression.GetDStat(f15_arg0, "PlayerCareerStats", "storypoints", "MENU_SO_WAR_AFGHANISTAN") == 0 then
			f15_local0:addElement(LUI.UITimer.new(3, {
				name = "sf_available",
				mapAlias = "war_afghanistan",
				curMapIndex = 9
			}, true))
			Engine.SetStoryPointStat("MENU_SO_WAR_AFGHANISTAN", 1)
		elseif f15_local14 == true and UIExpression.GetDStat(f15_arg0, "PlayerCareerStats", "storypoints", "MENU_SO_WAR_SOCOTRA") == 0 then
			f15_local0:addElement(LUI.UITimer.new(3, {
				name = "sf_available",
				mapAlias = "war_socotra",
				curMapIndex = 11
			}, true))
			Engine.SetStoryPointStat("MENU_SO_WAR_SOCOTRA", 1)
		elseif f15_local15 == true and UIExpression.GetDStat(f15_arg0, "PlayerCareerStats", "storypoints", "MENU_SO_WAR_PAKISTAN") == 0 then
			f15_local0:addElement(LUI.UITimer.new(3, {
				name = "sf_available",
				mapAlias = "war_pakistan",
				curMapIndex = 14
			}, true))
			Engine.SetStoryPointStat("MENU_SO_WAR_PAKISTAN", 1)
		end
		f0_local0(f15_local11, f15_local3)
		f0_local1(f15_local11, f15_local3)
		if CoD.useMouse then
			f0_local5(f15_local11, f15_local3)
		end
	end
	f15_local11:setStartItem(1)
	if nil == CoD.Campaign.MissionBriefingInfo then
		CoD.Campaign.UpdateMissionBriefingInfo(f15_arg0)
	end
	if nil == CoD.Campaign.Characters then
		CoD.Campaign.UpdateCharacters(f15_arg0)
	end
	CoD.CampaignMissionBriefing.CreateCharacterInfo(f15_local0, f15_arg0)
	CoD.CampaignMissionBriefing.CreateLoadoutInfo(f15_local0, f15_arg0)
	CoD.MissionBriefing.SetToDefaultClass(f15_local0, f15_arg0)
	return f15_local0
end

CoD.CampaignMissionBriefing.CharacterOffscreenComplete = function (f16_arg0, f16_arg1)
	local f16_local0 = f16_arg0:getParent()
	local f16_local1 = f16_local0.carousel.list.containers[f16_local0.carousel.m_currentItem].content
	local f16_local2 = f16_local1.characterRefName
	if f16_local1.isRtsMap then
		local f16_local3 = UIExpression.GetDStat(f16_arg1, "PlayerCareerStats", "unitsAvailable")
		f16_local0.objectiveInfo.objectivePrimary:setText(Engine.Localize("SPUI_" .. f16_local1.mapAlias .. "_OBJECTIVE"))
		f16_local0.objectiveInfo.missionRetries:setText(f16_local3)
		f16_local0.objectiveInfo:animateToState("onscreen", 150)
	else
		f16_local0.characterInfo.characterFrontImage:setImage(CoD.Campaign.Characters[f16_local2].characterImage)
		f16_local0.characterInfo.characterSideImage:setImage(CoD.Campaign.Characters[f16_local2].characterImageSide)
		f16_local0.characterInfo.characterName:setText(Engine.Localize("SPUI_CHARACTER_NAME") .. ": " .. Engine.Localize("SPUI_" .. f16_local2 .. "_NAME"))
		f16_local0.characterInfo.characterID:setText(Engine.Localize("SPUI_ID_NUMBER") .. ": " .. CoD.Campaign.Characters[f16_local2].characterID)
		f16_local0.characterInfo.characterHeight:setText(Engine.Localize("SPUI_HEIGHT_CAPS") .. ": " .. Engine.Localize("SPUI_" .. f16_local2 .. "_HEIGHT"))
		f16_local0.characterInfo.characterWeight:setText(Engine.Localize("SPUI_WEIGHT_CAPS") .. ": " .. Engine.Localize("SPUI_" .. f16_local2 .. "_WEIGHT"))
		f16_local0.characterInfo:animateToState("onscreen", 150)
	end
end

CoD.CampaignMissionBriefing.LoadoutOffscreenComplete = function (f17_arg0, f17_arg1)
	local f17_local0 = f17_arg0:getParent()
	local f17_local1 = f17_local0.carousel.list.containers[f17_local0.carousel.m_currentItem].content
	if f17_local1.isRtsMap then
		f17_local0.rtsMapUI.mapFrame:setImage(RegisterMaterial("menu_sfmap_" .. f17_local1.mapAlias))
		f17_local0.rtsMapUI.mapFrameOverlay:setImage(RegisterMaterial("menu_sfmap_" .. f17_local1.mapAlias .. "_hl"))
		local f17_local2 = 0
		local f17_local3 = 0
		local f17_local4 = 0
		local f17_local5 = 0
		local f17_local6 = 25
		local f17_local7 = 25
		local f17_local8 = 0
		local f17_local9 = 0
		local f17_local10, f17_local11, f17_local12, f17_local13 = nil
		if f17_local1.mapname == "so_rts_mp_dockside" then
			f17_local5 = -119
			f17_local4 = -35
			f17_local2 = 85
			f17_local3 = 103
			f17_local8 = 90
			f17_local9 = 120
			f17_local10 = {
				material = "hud_rts_troops",
				name = "SEALS",
				width = 2
			}
			f17_local11 = {
				material = "hud_rts_troops2",
				name = "SEALS",
				width = 2
			}
			f17_local12 = {
				material = "hud_rts_talon",
				name = "ASD"
			}
			f17_local13 = {
				material = "hud_rts_claw",
				name = "CLAW"
			}
		elseif f17_local1.mapname == "so_rts_afghanistan" then
			f17_local5 = 4
			f17_local4 = 4
			f17_local2 = 82
			f17_local3 = 98
			f17_local10 = {
				material = "hud_rts_qrdrone",
				name = "QR_DRONES",
				width = 2
			}
			f17_local11 = {
				material = "hud_rts_qrdrone",
				name = "QR_DRONES",
				width = 2
			}
			f17_local12 = {
				material = "hud_rts_talon",
				name = "ASD"
			}
			f17_local13 = {
				material = "hud_rts_godrod",
				name = "HAMP"
			}
		elseif f17_local1.mapname == "so_rts_mp_drone" then
			f17_local5 = -8
			f17_local4 = 11
			f17_local2 = 187
			f17_local3 = 222
			f17_local8 = -55
			f17_local9 = -22
			f17_local10 = {
				material = "hud_rts_troops",
				name = "SEALS",
				width = 2
			}
			f17_local11 = {
				material = "hud_rts_troops2",
				name = "SEALS",
				width = 2
			}
			f17_local12 = {
				material = "hud_rts_sentry_gun",
				name = "SENTRY"
			}
			f17_local13 = {
				material = "hud_rts_claw",
				name = "CLAW"
			}
		elseif f17_local1.mapname == "so_rts_mp_socotra" then
			f17_local10 = {
				material = "hud_rts_troops",
				name = "SEALS",
				width = 2
			}
			f17_local11 = {
				material = "hud_rts_troops2",
				name = "SEALS",
				width = 2
			}
			f17_local12 = {
				material = "hud_rts_osprey",
				name = "VTOL"
			}
			f17_local13 = nil
		elseif f17_local1.mapname == "so_rts_mp_overflow" then
			f17_local5 = 3
			f17_local4 = -60
			f17_local2 = 114
			f17_local3 = 138
			f17_local8 = -40
			f17_local9 = 0
			f17_local10 = {
				material = "hud_rts_troops",
				name = "SEALS",
				width = 4
			}
			f17_local11 = {
				material = "hud_rts_troops2",
				name = "SEALS",
				width = 4
			}
			f17_local12 = {
				material = "hud_rts_troops3",
				name = "SEALS",
				width = 4
			}
			f17_local13 = {
				material = "hud_rts_troops4",
				name = "SEALS",
				width = 4
			}
		end
		f17_local0.rtsMapUI.mapFrameOverlay:setLeftRight(false, false, f17_local5 - f17_local3 / 2, f17_local5 + f17_local3 / 2)
		f17_local0.rtsMapUI.mapFrameOverlay:setTopBottom(false, false, f17_local4 - f17_local2 / 2, f17_local4 + f17_local2 / 2)
		f17_local0.rtsMapUI.mapHL:setLeftRight(false, false, f17_local9 - f17_local7 / 2, f17_local9 + f17_local7 / 2)
		f17_local0.rtsMapUI.mapHL:setTopBottom(false, false, f17_local8 - f17_local6 / 2, f17_local8 + f17_local6 / 2)
		if f17_local0.rtsMapUI.objFrame.assetList ~= nil then
			f17_local0.rtsMapUI.objFrame.assetList:close()
		end
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, -3, 5)
		Widget:setTopBottom(true, true, 100, 0)
		f17_local0.rtsMapUI.objFrame:addElement(Widget)
		f17_local0.rtsMapUI.objFrame.assetList = Widget
		f17_local0.rtsMapUI.objFrame.assetList1 = CoD.CampaignMissionBriefing.AssetListIcon(Widget, 1, f17_local10)
		f17_local0.rtsMapUI.objFrame.assetList2 = CoD.CampaignMissionBriefing.AssetListIcon(Widget, 2, f17_local11)
		f17_local0.rtsMapUI.objFrame.assetList3 = CoD.CampaignMissionBriefing.AssetListIcon(Widget, 3, f17_local12)
		if f17_local13 ~= nil then
			f17_local0.rtsMapUI.objFrame.assetList4 = CoD.CampaignMissionBriefing.AssetListIcon(Widget, 4, f17_local13)
		else
			local f17_local15 = 96
			Widget:setLeftRight(true, true, -3 + f17_local15 / 2, 5 - f17_local15 / 2)
		end
		f17_local0.rtsMapUI:animateToState("onscreen", 150)
	else
		f17_arg0:moveToDefault(150)
	end
end

CoD.CampaignMissionBriefing.CreateCharacterInfo = function (f18_arg0, f18_arg1)
	local f18_local0 = f18_arg0.carousel.list.containers[f18_arg0.carousel.m_currentItem].content
	local f18_local1 = f18_local0.characterRefName
	local f18_local2 = CoD.MissionBriefing.BriefingWidth
	local f18_local3 = 460
	if f18_arg0.characterInfo ~= nil then
		if f18_local0.isRtsMap then
			f18_arg0.characterInfo:animateToState("offscreen", 150)
		else
			f18_arg0.characterInfo:animateToState("onscreen", 150)
		end
		f18_arg0.objectiveInfo:animateToState("offscreen", 150)
	else
		f18_arg0.characterInfo = LUI.UIElement.new()
		f18_arg0.characterInfo:setLeftRight(true, false, 0, f18_local2)
		f18_arg0.characterInfo:setTopBottom(true, false, 100 + CoD.CACUtility.TopAnchor, 100 + CoD.CACUtility.TopAnchor + f18_local3)
		f18_arg0.characterInfo:setAlpha(0)
		f18_arg0.characterInfo:registerAnimationState("offscreen", {
			leftAnchor = true,
			rightAnchor = false,
			topAnchor = true,
			bottomAnchor = false,
			left = 0,
			right = f18_local2,
			top = 100 + CoD.CACUtility.TopAnchor,
			bottom = 100 + CoD.CACUtility.TopAnchor + f18_local3,
			alpha = 0
		})
		f18_arg0.characterInfo:registerAnimationState("onscreen", {
			leftAnchor = true,
			rightAnchor = false,
			topAnchor = true,
			bottomAnchor = false,
			left = 0,
			right = f18_local2,
			top = CoD.CACUtility.TopAnchor,
			bottom = CoD.CACUtility.TopAnchor + f18_local3,
			alpha = 1
		})
		f18_arg0.characterInfo:registerEventHandler("transition_complete_offscreen", CoD.CampaignMissionBriefing.CharacterOffscreenComplete)
		f18_arg0:addElement(f18_arg0.characterInfo)
		local f18_local4 = -116
		local f18_local5 = 175
		local f18_local6 = 400
		local f18_local7 = 180
		local f18_local8 = -f18_local6 * 0.8
		local f18_local9 = f18_local6 * 0.8
		local f18_local10 = -f18_local5 - f18_local4 - 60
		local f18_local11 = 50 - f18_local4
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(false, false, -f18_local6 / 2 - 30, f18_local6 / 2 + 36)
		Widget:setTopBottom(false, true, -f18_local4 - f18_local5 - 5, -f18_local4 - 5)
		f18_arg0.characterInfo:addElement(Widget)
		Widget:addElement(CoD.BorderDipLarge.new(2, 2, CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b, CoD.CACClassLoadout.DefaultButtonAlpha, -2, 0))
		local f18_local13 = 1
		local f18_local14 = f18_local5 - 20
		local f18_local15 = f18_local14 * f18_local13
		local f18_local16 = 10
		f18_arg0.characterInfo.characterFrontImage = LUI.UIImage.new()
		f18_arg0.characterInfo.characterFrontImage:setLeftRight(true, false, f18_local16, f18_local16 + f18_local15)
		f18_arg0.characterInfo.characterFrontImage:setTopBottom(false, false, -f18_local14 / 2, f18_local14 / 2)
		f18_arg0.characterInfo.characterFrontImage:setImage(CoD.Campaign.Characters[f18_local1].characterImage)
		Widget:addElement(f18_arg0.characterInfo.characterFrontImage)
		local f18_local17 = 10
		f18_arg0.characterInfo.characterSideImage = LUI.UIImage.new()
		f18_arg0.characterInfo.characterSideImage:setLeftRight(true, false, f18_local17 + f18_local15, f18_local17 + f18_local15 + f18_local15)
		f18_arg0.characterInfo.characterSideImage:setTopBottom(false, false, -f18_local14 / 2, f18_local14 / 2)
		f18_arg0.characterInfo.characterSideImage:setImage(CoD.Campaign.Characters[f18_local1].characterImageSide)
		Widget:addElement(f18_arg0.characterInfo.characterSideImage)
		local f18_local18 = 100
		local f18_local19 = 20
		local f18_local20 = 0
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(false, true, -f18_local7 + f18_local19, f18_local19)
		Widget:setTopBottom(false, false, -(f18_local18 / 2) + f18_local20, f18_local18 / 2 + f18_local20)
		Widget:addElement(Widget)
		local f18_local22 = RegisterMaterial("menu_vis_thumbprint")
		local f18_local23 = 1
		local f18_local24 = 100
		local f18_local25 = f18_local24 * f18_local23
		local f18_local26 = LUI.UIImage.new()
		f18_local26:setLeftRight(false, true, -f18_local25 - 10, -10)
		f18_local26:setTopBottom(false, false, -f18_local24 / 2, f18_local24 / 2)
		f18_local26:setImage(f18_local22)
		f18_local26:setAlpha(0.35)
		Widget:addElement(f18_local26)
		local f18_local27 = LUI.UIVerticalList.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 0,
			bottom = 0
		})
		Widget:addElement(f18_local27)
		f18_arg0.characterInfo.characterName = CoD.MissionBriefingCharacterPanel.CharacterInfoText(Engine.Localize("SPUI_CHARACTER_NAME") .. ": " .. Engine.Localize("SPUI_" .. f18_local1 .. "_NAME"))
		f18_arg0.characterInfo.characterID = CoD.MissionBriefingCharacterPanel.CharacterInfoText(Engine.Localize("SPUI_ID_NUMBER") .. ": " .. CoD.Campaign.Characters[f18_local1].characterID)
		f18_arg0.characterInfo.characterHeight = CoD.MissionBriefingCharacterPanel.CharacterInfoText(Engine.Localize("SPUI_HEIGHT_CAPS") .. ": " .. Engine.Localize("SPUI_" .. f18_local1 .. "_HEIGHT"))
		f18_arg0.characterInfo.characterWeight = CoD.MissionBriefingCharacterPanel.CharacterInfoText(Engine.Localize("SPUI_WEIGHT_CAPS") .. ": " .. Engine.Localize("SPUI_" .. f18_local1 .. "_WEIGHT"))
		f18_local27:addElement(f18_arg0.characterInfo.characterName)
		f18_local27:addElement(f18_arg0.characterInfo.characterID)
		f18_local27:addElement(f18_arg0.characterInfo.characterHeight)
		f18_local27:addElement(f18_arg0.characterInfo.characterWeight)
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(false, true, -f18_local7, 0)
		Widget:setTopBottom(false, false, -(f18_local18 / 2) + f18_local20, f18_local18 / 2 + f18_local20)
		Widget:addElement(Widget)
		f18_local8 = f18_local8 - 207
		f18_local9 = f18_local9 - 207
		f18_local10 = f18_local10 - 143 - 25
		f18_local11 = f18_local11 - 143 - 25
		f18_arg0.objectiveInfo = LUI.UIElement.new()
		f18_arg0.objectiveInfo:setLeftRight(false, false, f18_local8, f18_local9)
		f18_arg0.objectiveInfo:setTopBottom(false, true, 100 + f18_local10, 100 + f18_local11)
		f18_arg0.objectiveInfo:setAlpha(0)
		f18_arg0.objectiveInfo:registerAnimationState("offscreen", {
			leftAnchor = false,
			rightAnchor = false,
			topAnchor = false,
			bottomAnchor = true,
			left = f18_local8,
			right = f18_local9,
			top = 100 + f18_local10,
			bottom = 100 + f18_local11,
			alpha = 0
		})
		f18_arg0.objectiveInfo:registerAnimationState("onscreen", {
			leftAnchor = false,
			rightAnchor = false,
			topAnchor = false,
			bottomAnchor = true,
			left = f18_local8,
			right = f18_local9,
			top = f18_local10,
			bottom = f18_local11,
			alpha = 1
		})
		f18_arg0:addElement(f18_arg0.objectiveInfo)
		local f18_local29 = LUI.UIVerticalList.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = true,
			top = 50 + 20,
			bottom = 0
		})
		f18_arg0.objectiveInfo:addElement(f18_local29)
		f18_arg0.objectiveInfo.objectivePrimaryTitle = CoD.MissionBriefing.ObjectiveTitleText(f18_local29)
		f18_arg0.objectiveInfo.objectivePrimaryTitle:setText(Engine.Localize("SPUI_SF_OBJECTIVE_CAPS"))
		CoD.MissionBriefing.Spacer(f18_local29, 5)
		f18_arg0.objectiveInfo.objectivePrimary = CoD.MissionBriefing.ObjectiveInfoText(f18_local29)
		CoD.MissionBriefing.Spacer(f18_local29, 15)
		f18_arg0.objectiveInfo.missionRetriesTitle = CoD.MissionBriefing.ObjectiveTitleText(f18_local29)
		f18_arg0.objectiveInfo.missionRetriesTitle:setText(Engine.Localize("SPUI_SF_TEAMS_CAPS"))
		CoD.MissionBriefing.Spacer(f18_local29, 5)
		f18_arg0.objectiveInfo.missionRetries = CoD.MissionBriefing.ObjectiveInfoText(f18_local29)
		f18_arg0.characterInfo:animateToState("offscreen", 0)
	end
end

CoD.MissionBriefing.Spacer = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, InstanceRef)
	HudRef:addElement(Widget)
end

CoD.MissionBriefing.ObjectiveTitleText = function (f20_arg0)
	local f20_local0 = "Condensed"
	local f20_local1 = LUI.UIText.new()
	f20_local1:setLeftRight(true, true, 0, 0)
	f20_local1:setTopBottom(true, false, 0, CoD.textSize[f20_local0])
	f20_local1:setFont(CoD.fonts[f20_local0])
	f20_local1:setAlignment(LUI.Alignment.Center)
	f20_local1:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
	f20_arg0:addElement(f20_local1)
	return f20_local1
end

CoD.MissionBriefing.ObjectiveInfoText = function (f21_arg0)
	local f21_local0 = "Default"
	local f21_local1 = CoD.textSize[f21_local0] * 2
	local f21_local2 = LUI.UIText.new()
	f21_local2:setLeftRight(true, true, 0, 0)
	f21_local2:setTopBottom(true, false, f21_local1, f21_local1 + CoD.textSize[f21_local0])
	f21_local2:setFont(CoD.fonts[f21_local0])
	f21_local2:setAlignment(LUI.Alignment.Center)
	f21_local2:setRGB(CoD.visorBlue4.r, CoD.visorBlue4.g, CoD.visorBlue4.b)
	f21_arg0:addElement(f21_local2)
	return f21_local2
end

CoD.CampaignMissionBriefing.CreateLoadoutInfo = function (f22_arg0, f22_arg1)
	local f22_local0 = f22_arg0.carousel.list.containers[f22_arg0.carousel.m_currentItem].content
	if f22_arg0.loadoutUI ~= nil then
		if f22_local0.isRtsMap then
			f22_arg0.loadoutUI:moveOffscreenRight(150)
		else
			f22_arg0.loadoutUI:moveToDefault(150)
		end
		f22_arg0.rtsMapUI:animateToState("offscreen", 150)
	else
		f22_arg0.loadoutUI = CoD.CACClassLoadout.new(f22_arg1, true)
		f22_arg0.loadoutUI.m_inputDisabled = true
		f22_arg0:addElement(f22_arg0.loadoutUI)
		f22_arg0.loadoutUI:dispatchEventToChildren({
			name = "animate",
			animationStateName = "hide_button_bracket"
		})
		f22_arg0.loadoutUI:registerEventHandler("transition_complete_move_offscreen_right", CoD.CampaignMissionBriefing.LoadoutOffscreenComplete)
		local f22_local1 = 0.95
		f22_arg0.rtsMapUI = LUI.UIElement.new()
		f22_arg0.rtsMapUI:setLeftRight(false, true, 200 + CoD.CACClassLoadout.PreviewSideBuffer - CoD.CACClassLoadout.PreviewListWidth * f22_local1, 200 + CoD.CACClassLoadout.PreviewSideBuffer)
		f22_arg0.rtsMapUI:setTopBottom(true, true, CoD.CACUtility.TopAnchor, 0)
		f22_arg0.rtsMapUI:setAlpha(0)
		f22_arg0.rtsMapUI:registerAnimationState("offscreen", {
			leftAnchor = false,
			rightAnchor = true,
			topAnchor = true,
			bottomAnchor = true,
			left = 200 + CoD.CACClassLoadout.PreviewSideBuffer - CoD.CACClassLoadout.PreviewListWidth * f22_local1,
			right = 200 + CoD.CACClassLoadout.PreviewSideBuffer,
			top = CoD.CACUtility.TopAnchor,
			bottom = 0,
			alpha = 0
		})
		f22_arg0.rtsMapUI:registerAnimationState("onscreen", {
			leftAnchor = false,
			rightAnchor = true,
			topAnchor = true,
			bottomAnchor = true,
			left = CoD.CACClassLoadout.PreviewSideBuffer - CoD.CACClassLoadout.PreviewListWidth * f22_local1,
			right = CoD.CACClassLoadout.PreviewSideBuffer,
			top = CoD.CACUtility.TopAnchor,
			bottom = 0,
			alpha = 1
		})
		f22_arg0:addElement(f22_arg0.rtsMapUI)
		local f22_local2 = CoD.textSize.Big
		local f22_local3 = 2
		local f22_local4 = 275 + CoD.textSize.Condensed
		local f22_local5 = f22_local4 * f22_local3
		local Widget = LUI.UIElement.new()
		Widget:setUseStencil(true)
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, false, f22_local2, f22_local2 + f22_local4)
		f22_arg0.rtsMapUI:addElement(Widget)
		CoD.BorderLite.new(Widget, 1, CoD.white.r, CoD.white.g, CoD.white.b, 0.8, 0)
		f22_arg0.rtsMapUI.mapFrame = LUI.UIImage.new()
		f22_arg0.rtsMapUI.mapFrame:setLeftRight(true, true, 0, 0)
		f22_arg0.rtsMapUI.mapFrame:setTopBottom(true, true, 0, 0)
		f22_arg0.rtsMapUI.mapFrame:setAlpha(0.7)
		Widget:addElement(f22_arg0.rtsMapUI.mapFrame)
		f22_arg0.rtsMapUI.mapFrameOverlay = LUI.UIImage.new()
		f22_arg0.rtsMapUI.mapFrameOverlay:setLeftRight(true, true, 0, 0)
		f22_arg0.rtsMapUI.mapFrameOverlay:setTopBottom(true, true, 0, 0)
		f22_arg0.rtsMapUI.mapFrameOverlay:setAlpha(1)
		Widget:addElement(f22_arg0.rtsMapUI.mapFrameOverlay)
		f22_arg0.rtsMapUI.mapFrameOverlay.alpha = 0.75
		f22_arg0.rtsMapUI.mapFrameOverlay.maxAlpha = 1
		f22_arg0.rtsMapUI.mapFrameOverlay.minAlpha = 0.5
		f22_arg0.rtsMapUI.mapFrameOverlay.glowRate = 0.03
		f22_arg0.rtsMapUI.mapFrameOverlay:registerEventHandler("glow_background", f0_local3)
		Widget:addElement(LUI.UITimer.new(2, "glow_background", false, f22_arg0.rtsMapUI.mapFrameOverlay))
		f22_arg0.rtsMapUI.mapHL = LUI.UIImage.new()
		f22_arg0.rtsMapUI.mapHL:setLeftRight(true, true, 0, 0)
		f22_arg0.rtsMapUI.mapHL:setTopBottom(true, true, 0, 0)
		f22_arg0.rtsMapUI.mapHL:setAlpha(0.85)
		f22_arg0.rtsMapUI.mapHL:setImage(RegisterMaterial("menu_sfmap_war_hl"))
		Widget:addElement(f22_arg0.rtsMapUI.mapHL)
		f22_arg0.rtsMapUI.mapHL.rotRate = 1
		f22_arg0.rtsMapUI.mapHL.alpha = 0.75
		f22_arg0.rtsMapUI.mapHL.maxAlpha = 1
		f22_arg0.rtsMapUI.mapHL.minAlpha = 0.5
		f22_arg0.rtsMapUI.mapHL.glowRate = 0.01
		f22_arg0.rtsMapUI.mapHL:registerEventHandler("glow_background", f0_local3)
		Widget:addElement(LUI.UITimer.new(2, "glow_background", false, f22_arg0.rtsMapUI.mapHL))
		f22_arg0.rtsMapUI.mapHL:registerEventHandler("rotate_background", f0_local4)
		Widget:addElement(LUI.UITimer.new(2, "rotate_background", false, f22_arg0.rtsMapUI.mapHL))
		local f22_local7 = f22_local2 + f22_local4 - 25
		local f22_local8 = 250
		f22_arg0.rtsMapUI.objFrame = LUI.UIElement.new()
		f22_arg0.rtsMapUI.objFrame:setLeftRight(true, true, 0, 0)
		f22_arg0.rtsMapUI.objFrame:setTopBottom(true, false, f22_local7, f22_local7 + f22_local8)
		f22_arg0.rtsMapUI:addElement(f22_arg0.rtsMapUI.objFrame)
		local f22_local9 = 45
		local f22_local10 = LUI.UIText.new()
		f22_local10:setLeftRight(true, true, 0, 0)
		f22_local10:setTopBottom(true, false, f22_local9, f22_local9 + CoD.textSize.Condensed)
		f22_local10:setAlignment(LUI.Alignment.Center)
		f22_local10:setFont(CoD.fonts.Condensed)
		f22_local10:setText(Engine.Localize("SPUI_SF_TOKENS"))
		f22_local10:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
		f22_arg0.rtsMapUI.objFrame:addElement(f22_local10)
		f22_arg0.loadoutUI:moveOffscreenRight(0)
		f22_arg0.rtsMapUI:animateToState("offscreen", 0)
	end
end

CoD.CampaignMissionBriefing.AssetListIcon = function (f23_arg0, f23_arg1, f23_arg2)
	if f23_arg1 == nil then
		f23_arg1 = 0
	else
		f23_arg1 = f23_arg1 - 1
	end
	local f23_local0 = nil
	if f23_arg2.width == nil then
		f23_local0 = 0
	else
		f23_local0 = f23_arg2.width - 1
	end
	local f23_local1 = 80
	local f23_local2 = f23_local1
	local f23_local3 = 6
	local f23_local4 = f23_local3 * 2 + f23_local2
	local f23_local5 = f23_arg1 * f23_local4
	local f23_local6 = LUI.UIImage.new()
	f23_local6:setLeftRight(true, false, f23_local5 + f23_local3, f23_local5 + f23_local3 + f23_local2)
	f23_local6:setTopBottom(false, false, -f23_local1, 0)
	if f23_arg2.material ~= nil then
		f23_local6:setImage(RegisterMaterial(f23_arg2.material))
	end
	f23_arg0:addElement(f23_local6)
	if f23_local0 == 0 or f23_arg1 == f23_local0 then
		local f23_local7 = CoD.Bracket.CreateRightBracket({
			red = CoD.RTSColors.blue.r / 2,
			green = CoD.RTSColors.blue.g / 2,
			blue = CoD.RTSColors.blue.b / 2
		})
		f23_local7:setTopBottom(false, false, -f23_local1 * 1.1, 0)
		f23_local7:setLeftRight(true, false, f23_local5 + f23_local3 + f23_local2 - CoD.Bracket.Width, f23_local5 + f23_local3 + f23_local2)
		f23_local7:setAlpha(1)
		f23_arg0:addElement(f23_local7)
	end
	if f23_local0 == 0 or f23_arg1 == 0 then
		local f23_local7 = CoD.Bracket.CreateLeftBracket({
			red = CoD.RTSColors.blue.r / 2,
			green = CoD.RTSColors.blue.g / 2,
			blue = CoD.RTSColors.blue.b / 2
		})
		f23_local7:setTopBottom(false, false, -f23_local1 * 1.1, 0)
		f23_local7:setLeftRight(true, false, f23_local5 + f23_local3, f23_local5 + f23_local3 + CoD.Bracket.Width)
		f23_local7:setAlpha(1)
		f23_arg0:addElement(f23_local7)
	end
	if f23_arg2.name ~= nil then
		if f23_local0 ~= 0 and f23_arg1 ~= 0 then
			return f23_local6
		end
		local f23_local7 = LUI.UIText.new()
		f23_local7:setLeftRight(true, false, f23_local5 + f23_local3, f23_local5 + f23_local3 + f23_local2 + f23_local4 * f23_local0)
		f23_local7:setTopBottom(false, false, 0, CoD.textSize.Condensed)
		f23_local7:setText(Engine.Localize("SPUI_RTS_" .. f23_arg2.name .. "_CAPS"))
		f23_local7:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
		f23_local7:setAlignment(LUI.Alignment.Center)
		f23_arg0:addElement(f23_local7)
	end
	return f23_local6, iconText
end

CoD.CampaignMissionBriefing.FadeHiddenCarouselButtons = function (f24_arg0)
	local f24_local0 = f24_arg0.m_currentItem
	local f24_local1 = f24_arg0.list.containers
	for f24_local2 = 1, f24_arg0.list:getNumChildren(), 1 do
		if math.abs(f24_local0 - f24_local2) > 1 then
			f24_local1[f24_local2].content:animateToState("fade_out", 25)
		elseif f24_local2 ~= f24_local0 then
			f24_local1[f24_local2].content:animateToState("fade_default", 75)
		else
			f24_local1[f24_local2].content:animateToState("fade_in", 100)
		end
		if f24_local2 ~= f24_local0 then
			f24_local1[f24_local2].content.background.disable = true
		else
			f24_local1[f24_local2].content.background.disable = false
		end
	end
end

CoD.CampaignMissionBriefing.CarouselScroll = function (f25_arg0, f25_arg1)
	if f25_arg0.lastCarouselItem ~= f25_arg0.carousel.m_currentItem then
		local f25_local0 = f25_arg0.carousel.list.containers[f25_arg0.carousel.m_currentItem].content
		if f25_local0.isRtsMap then
			if f25_arg0.customizeLoadout ~= nil then
				f25_arg0.customizeLoadout:close()
			end
		else
			local f25_local1 = CoD.ButtonPrompt.new
			local f25_local2 = "alt2"
			local f25_local3 = Engine.Localize("MENU_CUSTOMIZE_LOADOUT")
			local f25_local4 = f25_arg0
			local f25_local5 = "button_customize_loadout"
			local f25_local6, f25_local7 = false
			local f25_local8, f25_local9 = false
			f25_arg0.customizeLoadout = f25_local1(f25_local2, f25_local3, f25_local4, f25_local5, f25_local6, f25_local7, f25_local8, f25_local9, "C")
			f25_arg0:addRightButtonPrompt(f25_arg0.customizeLoadout)
		end
		CoD.CampaignMissionBriefing.CreateCharacterInfo(f25_arg0, f25_arg1.controller)
		CoD.CampaignMissionBriefing.CreateLoadoutInfo(f25_arg0, controller)
		CoD.CampaignMissionBriefing.MapNameAndDate(f25_arg0, f25_arg0, f25_local0.mapAlias, f25_local0.isRtsMap)
		f25_arg0.lastCarouselItem = f25_arg0.carousel.m_currentItem
		CoD.CampaignMissionBriefing.FadeHiddenCarouselButtons(f25_arg0.carousel)
	end
end

CoD.CampaignMissionBriefing.CarouselScrollComplete = function (f26_arg0, f26_arg1)
	f26_arg0:dispatchEventToParent({
		name = "scroll_changed"
	})
end

CoD.CampaignMissionBriefing.MapNameAndDate = function (f27_arg0, f27_arg1, f27_arg2, f27_arg3)
	local f27_local0 = CoD.CACUtility.TopAnchor - 5
	local f27_local1 = "Big"
	local f27_local2 = 12
	if f27_arg0.locationText == nil then
		local f27_local3 = LUI.UIText.new()
		f27_local3:setLeftRight(true, false, f27_local2, f27_local2 + CoD.MissionBriefing.BriefingWidth)
		f27_local3:setTopBottom(true, false, f27_local0, CoD.textSize[f27_local1] + f27_local0)
		f27_local3:setFont(CoD.fonts[f27_local1])
		f27_local3:setAlignment(LUI.Alignment.Center)
		if f27_arg0.carousel:getNumItems() == 1 then
			f27_local3:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
		else
			f27_local3:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		end
		f27_arg1:addElement(f27_local3)
		f27_arg0.locationText = f27_local3
	end
	f27_arg0.locationText:setText(Engine.Localize("SPUI_" .. f27_arg2 .. "_MISSION_NAME"))
	if f27_arg0.dateText == nil then
		local f27_local3 = f27_local0 + CoD.textSize[f27_local1]
		local f27_local4 = "Condensed"
		local f27_local5 = LUI.UIText.new()
		f27_local5:setLeftRight(true, false, f27_local2, f27_local2 + CoD.MissionBriefing.BriefingWidth)
		f27_local5:setTopBottom(true, false, f27_local3, CoD.textSize[f27_local4] + f27_local3)
		f27_local5:setFont(CoD.fonts[f27_local4])
		f27_local5:setAlignment(LUI.Alignment.Center)
		if f27_arg0.carousel:getNumItems() == 1 then
			f27_local5:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
		else
			f27_local5:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		end
		f27_arg1:addElement(f27_local5)
		f27_arg0.dateText = f27_local5
	end
	if CoD.Campaign.MissionBriefingInfo and CoD.Campaign.MissionBriefingInfo[f27_arg2] then
		f27_arg0.dateText:setText(Engine.Localize("SPUI_" .. f27_arg2 .. "_LOCATION") .. " " .. CoD.Campaign.MissionBriefingInfo[f27_arg2].missionDate)
	else
		DebugPrint("Mission Briefing Information was not loaded for this map which SHOULD NEVER HAPPEN")
		f27_arg0.dateText:setText("")
	end
	if f27_arg0.objectiveText == nil then
		local f27_local3 = "Condensed"
		local f27_local4 = 10
		local f27_local5 = LUI.UIText.new()
		f27_local5:setLeftRight(true, false, f27_local2, f27_local2 + CoD.MissionBriefing.BriefingWidth)
		f27_local5:setTopBottom(true, false, 390, 390 + CoD.textSize[f27_local3])
		f27_local5:setFont(CoD.fonts[f27_local3])
		f27_local5:setAlignment(LUI.Alignment.Center)
		f27_arg1:addElement(f27_local5)
		f27_arg0.objectiveText = f27_local5
	end
	if f27_arg3 then
		f27_arg0.objectiveText:setText("")
	else
		f27_arg0.objectiveText:setText(Engine.Localize("SPUI_LEVEL_OBJECTIVE") .. ": " .. Engine.Localize("SPUI_" .. f27_arg2 .. "_OBJECTIVE"))
	end
end

f0_local3 = function (f28_arg0, f28_arg1)
	if f28_arg0.disable ~= nil and f28_arg0.disable then
		f28_arg0:setAlpha(0)
		return 
	elseif f28_arg0.glowRate == nil then
		f28_arg0.glowRate = 0
	end
	local f28_local0 = f28_arg0.alpha + f28_arg0.glowRate
	if f28_arg0.maxAlpha <= f28_local0 or f28_local0 <= f28_arg0.minAlpha then
		f28_arg0.glowRate = f28_arg0.glowRate * -1
	end
	f28_arg0.alpha = f28_local0
	f28_arg0:setAlpha(f28_local0)
end

f0_local4 = function (f29_arg0, f29_arg1)
	if f29_arg0.zRot == nil then
		f29_arg0.zRot = 0
	end
	if f29_arg0.rotRate == nil then
		f29_arg0.rotRate = 1
	end
	f29_arg0.zRot = f29_arg0.zRot + f29_arg0.rotRate
	if f29_arg0.zRot > 360 then
		f29_arg0.zRot = f29_arg0.zRot - 360
	end
	f29_arg0:setZRot(f29_arg0.zRot)
end

f0_local2 = function (f30_arg0, f30_arg1, f30_arg2, f30_arg3)
	local f30_local0 = CoD.ImageNavButton.new(nil, "menu_visor_ms_" .. f30_arg0, "button_prompt_launch_game", 0)
	f30_local0.labelImage:registerAnimationState("selected", {})
	f30_local0:registerAnimationState("fade_out", {
		alpha = 0
	})
	f30_local0:registerAnimationState("fade_default", {
		alpha = 0.5
	})
	f30_local0:registerAnimationState("fade_in", {
		alpha = 1
	})
	f30_local0.mapname = f30_arg1
	f30_local0.mapAlias = f30_arg0
	f30_local0.characterRefName = f30_arg2
	f30_local0.isRtsMap = f30_arg3
	f30_local0:setupCarouselMode()
	f30_local0.carousel = self
	f30_local0:registerEventHandler("carousel_scroll_complete", CoD.CampaignMissionBriefing.CarouselScrollComplete)
	local f30_local1 = 80
	local f30_local2 = 35
	local f30_local3 = 115
	local f30_local4 = LUI.UIImage.new()
	f30_local4:setLeftRight(true, true, f30_local3, -f30_local3)
	f30_local4:setTopBottom(true, true, f30_local1, -f30_local2)
	f30_local4:setImage(RegisterMaterial("menu_strikeforce_select"))
	f30_local4:setAlpha(0.1)
	f30_local4.alpha = 0.1
	f30_local4.maxAlpha = 0.15
	f30_local4.minAlpha = 0.05
	f30_local4:registerEventHandler("glow_background", f0_local3)
	f30_local0.background = f30_local4
	f30_local0:addElement(LUI.UITimer.new(0.1, "glow_background", false, f30_local0.background))
	f30_local0:addElement(f30_local4)
	return f30_local0
end

CoD.CampaignMissionBriefing.AddMapsToCarousel = function (f31_arg0, f31_arg1)
	local f31_local0 = Dvar.ui_mapname:get()
	local f31_local1 = tonumber(UIExpression.TableLookup(f31_arg1, CoD.AARUtility.LevelTable, 1, f31_local0, 0))
	local f31_local2 = UIExpression.TableLookup(f31_arg1, CoD.AARUtility.LevelTable, 1, f31_local0, 4)
	local f31_local3 = UIExpression.TableLookup(f31_arg1, CoD.AARUtility.LevelTable, 1, f31_local0, 2)
	local f31_local4 = UIExpression.GetDStat(f31_arg1, "PlayerCareerStats", "storypoints", "SO_WAR_TUTORIAL_COMPLETE")
	local f31_local5 = tonumber(UIExpression.GetDStat(f31_arg1, "PlayerCareerStats", "unitsAvailable"))
	local f31_local6 = false
	local f31_local7, f31_local8 = false
	if f31_local0 == "nicaragua" and f31_local4 == 0 then
		f31_local3 = UIExpression.TableLookup(f31_arg1, CoD.AARUtility.LevelTable, 1, "so_rts_mp_drone", 2)
		f31_arg0.carousel:addItem(f0_local2(f31_local3, "so_rts_mp_drone", f31_local2, true))
	else
		f31_arg0.carousel:addItem(f0_local2(f31_local3, f31_local0, f31_local2, false))
		local f31_local9 = 0
		if tonumber(UIExpression.GetDStat(f31_arg1, "PlayerCareerStats", "storypoints", "SO_WAR_DRONE_SUCCESS")) > 0 then
			f31_local9 = f31_local9 + 1
		end
		if tonumber(UIExpression.GetDStat(f31_arg1, "PlayerCareerStats", "storypoints", "SO_WAR_AFGHANISTAN_SUCCESS")) > 0 then
			f31_local9 = f31_local9 + 1
		end
		if tonumber(UIExpression.GetDStat(f31_arg1, "PlayerCareerStats", "storypoints", "SO_WAR_SINGAPORE_SUCCESS")) > 0 then
			f31_local9 = f31_local9 + 1
		end
		local f31_local10 = tonumber(UIExpression.GetDStat(f31_arg1, "PlayerCareerStats", "storypoints", "KARMA_CAPTURED"))
		for f31_local16, f31_local17 in ipairs(CoD.AARUtility.MapList) do
			if f31_local17.isRTSMap then
				if f31_local17.rtsStart < f31_local1 and f31_local1 < f31_local17.rtsEnd and tonumber(UIExpression.GetDStat(f31_arg1, "PlayerCareerStats", "storypoints", f31_local17.rtsLookup)) == 0 then
					f31_local3 = UIExpression.TableLookup(f31_arg1, CoD.AARUtility.LevelTable, 1, f31_local17.name, 2)
					local f31_local14 = UIExpression.TableLookup(f31_arg1, CoD.AARUtility.LevelTable, 1, f31_local17.name, 4)
					local f31_local15 = false
					if f31_local17.name == "so_rts_mp_socotra" then
						if f31_local10 ~= 0 then
							f31_local15 = true
							f31_local6 = true
						end
					elseif f31_local17.name == "so_rts_mp_overflow" then
						if f31_local9 >= 3 then
							f31_local15 = true
							f31_local7 = true
						end
					else
						f31_local15 = true
					end
					if f31_local15 then
						f31_arg0.carousel:addItem(f0_local2(f31_local3, f31_local17.name, f31_local14, f31_local17.isRTSMap))
					end
				end
			end
		end
	end
	return f31_local3, f31_local1, f31_local6, f31_local7
end

