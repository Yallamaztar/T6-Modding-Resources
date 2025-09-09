require("T6.Menus.CRCommon")
CoD.CRCareer = {}
CoD.CRCareer.MAX_CUSTOM_BACKGROUNDS = 3
CoD.CRCareer.SetupLevelBoxContainer = function (f1_arg0, f1_arg1)
	local f1_local0 = 10
	local f1_local1 = 20
	local f1_local2 = 128
	local f1_local3 = 128
	local f1_local4 = f1_arg1.PlayerStatsList.RANK.StatValue:get()
	local f1_local5 = f1_arg1.PlayerStatsList.PLEVEL.StatValue:get()
	local f1_local6 = f1_arg1.PlayerStatsList.TIME_PLAYED_TOTAL.StatValue:get()
	local f1_local7 = nil
	if f1_local6 then
		f1_local7 = UIExpression.SecondsAsTime(nil, f1_local6)
	end
	local f1_local8 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f1_local4, f1_local5 + 1)
	if f1_local8 then
		local f1_local9 = CoD.CRCommon.GetCenteredImage(f1_local2, f1_local3, f1_local8 .. "_128", true)
		f1_local9:setLeftRight(true, false, f1_local0, f1_local0 + f1_local2)
		f1_arg0:addElement(f1_local9)
	end
	f1_local0 = f1_local0 + f1_local2 + 15
	local f1_local9 = LUI.UIVerticalList.new()
	f1_local9:setLeftRight(true, true, f1_local0, 0)
	f1_local9:setTopBottom(true, true, f1_local1, 0)
	local f1_local10 = Engine.Localize(Engine.GetRankName(f1_local4))
	local f1_local11 = Engine.Localize("MENU_LEVEL_BRACKETS", f1_local4 + 1)
	if f1_local5 > 0 then
		f1_local10 = Engine.Localize("MPUI_PRESTIGE_N", f1_local5)
		if f1_local5 == tonumber(CoD.MAX_PRESTIGE) then
			f1_local10 = Engine.Localize("MENU_MASTER")
			f1_local11 = Engine.Localize("MENU_MAXIMUM_LEVEL")
		end
	end
	if f1_local4 and f1_local10 then
		f1_local9:addElement(CoD.CRCommon.GetTextElem("Condensed", "Left", f1_local10))
		f1_local9:addElement(CoD.CRCommon.GetTextElem("Default", "Left", f1_local11))
		f1_local9:addSpacer(20)
	end
	if f1_local7 then
		f1_local9:addElement(CoD.CRCommon.GetTextElem("Default", "Left", Engine.Localize("MENU_PLAYED_COLON")))
		f1_local9:addElement(CoD.CRCommon.GetTextElem("Default", "Left", f1_local7))
	end
	f1_arg0:addElement(f1_local9)
end

CoD.CRCareer.SetupStatBoxContainer = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4)
	local f2_local0 = 20
	local f2_local1 = CoD.CRCommon.GetStatContainer()
	f2_local1:setLeftRight(true, false, 0, f2_arg0)
	f2_local1:setTopBottom(true, true, 0, 0)
	local f2_local2 = LUI.UIVerticalList.new()
	f2_local2:setLeftRight(true, true, 0, 0)
	f2_local2:setTopBottom(true, true, f2_local0, 0)
	f2_local2:addElement(CoD.CRCommon.GetTextElem("ExtraSmall", "Center", f2_arg1, CoD.gray))
	f2_local2:addSpacer(5)
	f2_local2:addElement(CoD.CRCommon.GetTextElem("Big", "Center", f2_arg2))
	f2_local2:addSpacer(20)
	f2_local2:addElement(CoD.CRCommon.GetTextElem("ExtraSmall", "Center", f2_arg3, CoD.gray))
	f2_local2:addSpacer(5)
	f2_local2:addElement(CoD.CRCommon.GetTextElem("Condensed", "Center", f2_arg4))
	f2_local1:addElement(f2_local2)
	return f2_local1
end

CoD.CRCareer.SetupStatContainer = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local f3_local0 = LUI.UIHorizontalList.new()
	f3_local0:setLeftRight(true, true, 0, 0)
	f3_local0:setTopBottom(true, false, f3_arg1, f3_arg1 + f3_arg2)
	local f3_local1 = 400
	local f3_local2 = CoD.CRCommon.GetStatContainer()
	f3_local2:setLeftRight(true, false, 0, f3_local1)
	CoD.CRCareer.SetupLevelBoxContainer(f3_local2, f3_arg3)
	f3_local0:addElement(f3_local2)
	f3_local1 = 150
	local f3_local3 = f3_arg3.PlayerStatsList.KILLS.StatValue:get()
	local f3_local4 = math.max(1, f3_arg3.PlayerStatsList.DEATHS.StatValue:get())
	local f3_local5 = nil
	if f3_local3 and f3_local4 then
		f3_local5 = f3_local3 / f3_local4
	end
	local f3_local6 = nil
	local f3_local7 = f3_arg3.PlayerStatsList.WINS.StatValue:get()
	local f3_local8 = math.max(1, CoD.CombatRecord.GetLossesStat(f3_arg3.PlayerStatsList.LOSSES.StatValue))
	if f3_local7 and f3_local8 then
		f3_local6 = f3_local7 / f3_local8
	end
	local f3_local9 = f3_arg3.PlayerStatsList.SCORE.StatValue:get()
	local f3_local10 = f3_arg3.PlayerStatsList.TIME_PLAYED_TOTAL.StatValue:get()
	local f3_local11 = nil
	if f3_local10 then
		f3_local11 = math.max(1, math.ceil(f3_local10 / 60))
	end
	if f3_local3 and f3_local5 then
		f3_local0:addElement(CoD.CRCareer.SetupStatBoxContainer(f3_local1, Engine.Localize("MENU_KILLS"), f3_local3, Engine.Localize("MENU_KDRATIO_ABBR"), string.format("%.2f", f3_local5)))
	end
	if f3_local7 and f3_local6 then
		f3_local0:addElement(CoD.CRCareer.SetupStatBoxContainer(f3_local1, Engine.Localize("MENU_WINS"), f3_local7, Engine.Localize("MENU_WLRATIO"), string.format("%.2f", f3_local6)))
	end
	if f3_local9 and f3_local11 then
		f3_local0:addElement(CoD.CRCareer.SetupStatBoxContainer(f3_local1, Engine.Localize("MENU_LB_SCORE"), f3_local9, Engine.Localize("MENU_LB_SCORE_PER_MINUTE"), math.ceil(f3_local9 / f3_local11)))
	end
	f3_arg0:addElement(f3_local0)
end

CoD.CRCareer.BackgroundButtonGainFocus = function (f4_arg0, f4_arg1)
	f4_arg0:dispatchEventToParent({
		name = "remove_clear_button_prompt"
	})
	f4_arg0:dispatchEventToParent({
		name = "remove_select_button_prompt"
	})
	f4_arg0:dispatchEventToParent({
		name = "update_background_challenge_desc"
	})
	if not f4_arg0.defaultBackground then
		if f4_arg0.bgChallengeInfo then
			f4_arg0:dispatchEventToParent({
				name = "update_background_challenge_desc",
				text = f4_arg0.bgChallengeInfo.challengeDesc
			})
		end
		if not CoD.CRCommon.OtherPlayerCRMode then
			f4_arg0:dispatchEventToParent({
				name = "add_clear_button_prompt",
				buttonPromptEventName = "clear_showcase_shot",
				buttonPromptText = Engine.Localize("MENU_CLEAR_SHOWCASE_SHOT")
			})
		end
	elseif not CoD.CRCommon.OtherPlayerCRMode then
		f4_arg0:dispatchEventToParent({
			name = "add_select_button_prompt",
			buttonPromptText = Engine.Localize("MENU_PERSONALIZE_SHOWCASE_SHOT")
		})
		f4_arg0:setActionEventName("showcase_button_action")
	end
	LUI.UIButton.gainFocus(f4_arg0, f4_arg1)
end

CoD.CRCareer.SetupShowcase = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = CoD.Menu.Width / 2
	local f5_local1 = 70
	local f5_local2 = f5_local1 * 4
	local f5_local3 = LUI.UIVerticalList.new()
	f5_local3:setLeftRight(true, false, f5_local0, f5_local0 + f5_local2)
	f5_local3:setTopBottom(true, true, f5_arg2, 0)
	local f5_local4 = CoD.CRCareer.MAX_CUSTOM_BACKGROUNDS
	f5_arg0.showcaseButtons = {}
	for f5_local5 = 1, f5_local4, 1 do
		local f5_local8 = LUI.UIButton.new({
			leftAnchor = true,
			rightAnchor = true,
			topAnchor = true,
			bottomAnchor = false,
			left = 0,
			right = 0,
			top = 0,
			bottom = f5_local1
		})
		local f5_local9 = CoD.CRCommon.GetStatContainer()
		f5_local9.statContainerBackgroundGrad:close()
		f5_local8.bgIndex = f5_local5 - 1
		f5_local8.defaultBackground = true
		local f5_local10 = nil
		if CoD.CRCommon.CurrentXuid and CoD.CRCommon.CurrentXuid ~= "" and CoD.CRCommon.CurrentXuid ~= "0" then
			f5_local10 = Engine.GetCombatRecordBackgroundId(f5_arg1, CoD.CRCommon.CurrentXuid, f5_local8.bgIndex)
		end
		local f5_local11 = Engine.Localize("MENU_SLOT_N", f5_local5)
		local f5_local12 = CoD.CRCommon.GetTextElem("Default", "Left", f5_local11)
		f5_local12:setLeftRight(true, true, 3, 0)
		f5_local12:setTopBottom(false, true, -CoD.textSize.Default, 0)
		local f5_local13 = CoD.CRCommon.GetStretchedImage()
		if f5_local10 and f5_local10 ~= 0 then
			f5_local13:setupDrawBackgroundById(f5_local10)
			f5_local9.imageContainer:addElement(f5_local13)
			local f5_local14 = CoD.EmblemBackgroundSelector.GetChallengeInformation(f5_arg1, f5_local10)
			if f5_local14 and f5_local14.challengeName then
				f5_local12:setText(f5_local14.challengeName)
				f5_local8.bgChallengeInfo = f5_local14
			else
				f5_local12:setText(Engine.Localize(CoD.EmblemBackgroundSelector.GetDefaultBackgroundName(f5_arg1, f5_local10)))
			end
			f5_local8.backgroundId = f5_local10
			f5_local8.defaultBackground = false
		end
		f5_local8.defaultName = f5_local11
		f5_local8.backgroundImage = f5_local13
		f5_local8.backingChallengeName = f5_local12
		f5_local9.imageContainer:addElement(f5_local12)
		f5_local8:addElement(f5_local9)
		CoD.ContentGridButton.SetupButtonImages(f5_local8, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
		f5_local8:registerEventHandler("clear_showcase_shot", CoD.CRCareer.ButtonClearShowcaseShot)
		f5_local8:registerEventHandler("gain_focus", CoD.CRCareer.BackgroundButtonGainFocus)
		f5_local8.navigation.left = f5_arg0.profileShotButton
		table.insert(f5_arg0.showcaseButtons, f5_local8)
		f5_local3:addElement(f5_local8)
		f5_local3:addSpacer(4)
	end
	f5_arg0:addElement(f5_local3)
end

CoD.CRCareer.SetBackgroundID = function (f6_arg0, f6_arg1, f6_arg2)
	for f6_local0 = 0, CoD.CRCommon.MAX_BACKINGS - 1, 1 do
		if Engine.GetCombatRecordBackgroundId(f6_arg0, UIExpression.GetXUID(f6_arg0), f6_local0) == f6_arg1 then
			Engine.SetCombatRecordBackgroundId(f6_arg0, 0, f6_local0)
		end
	end
	Engine.SetCombatRecordBackgroundId(f6_arg0, f6_arg1, f6_arg2)
end

CoD.CRCareer.ProfileShotButtonGainFocus = function (f7_arg0, f7_arg1)
	f7_arg0:dispatchEventToParent({
		name = "remove_clear_button_prompt"
	})
	f7_arg0:dispatchEventToParent({
		name = "remove_select_button_prompt"
	})
	f7_arg0:dispatchEventToParent({
		name = "update_background_challenge_desc"
	})
	if not f7_arg0.defaultProfileShot then
		f7_arg0:dispatchEventToParent({
			name = "add_select_button_prompt",
			buttonPromptText = Engine.Localize("MENU_VIEW_FULL_SCREEN")
		})
		f7_arg0:setActionEventName("profile_shot_button_action_view_fullscreen")
		if not CoD.CRCommon.OtherPlayerCRMode then
			f7_arg0:dispatchEventToParent({
				name = "add_clear_button_prompt",
				buttonPromptEventName = "clear_profile_shot",
				buttonPromptText = Engine.Localize("MENU_CLEAR_PROFILE_SHOT")
			})
		end
	elseif not CoD.CRCommon.OtherPlayerCRMode then
		f7_arg0:dispatchEventToParent({
			name = "add_select_button_prompt",
			buttonPromptText = Engine.Localize("MENU_PERSONALIZE_PROFILE_SHOT")
		})
		f7_arg0:setActionEventName("profile_shot_button_action_default")
	end
	LUI.UIButton.gainFocus(f7_arg0, f7_arg1)
end

CoD.CRCareer.SetupProfileShotButton = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	local profileShotButton = LUI.UIButton.new({
		leftAnchor = true,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = false,
		left = f8_arg2,
		right = f8_arg2 + CoD.CACPrimaryWeapons.HighlightedItemWidth,
		top = f8_arg3,
		bottom = f8_arg3 + CoD.CACPrimaryWeapons.HighlightedItemHeight
	})
	CoD.ContentGridButton.SetupButtonImages(profileShotButton, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
	f8_arg0:addElement(profileShotButton)
	f8_arg0.profileShotButton = profileShotButton
	
	profileShotButton.defaultProfileShot = true
	local f8_local1 = 2
	local f8_local2 = 23
	
	local profileShotImageContainer = LUI.UIElement.new()
	profileShotImageContainer:setLeftRight(true, true, f8_local1, -f8_local1)
	profileShotImageContainer:setTopBottom(true, true, f8_local1, -f8_local1 - f8_local2)
	profileShotImageContainer:setUseStencil(true)
	profileShotButton:addElement(profileShotImageContainer)
	profileShotButton.profileShotImageContainer = profileShotImageContainer
	
	local f8_local4 = ""
	if not CoD.CRCommon.OtherPlayerCRMode then
		f8_local4 = Engine.Localize("MENU_PROFILE_SHOT_HINT")
		profileShotButton:setActionEventName("profile_shot_button_action_default")
	end
	local profileShotTextElem = CoD.CRCommon.GetTextElem("Default", "Left", f8_local4)
	profileShotTextElem:setLeftRight(true, true, 5, 0)
	profileShotTextElem:setTopBottom(false, true, -f8_local1 - CoD.textSize.Default, -f8_local1)
	profileShotButton:addElement(profileShotTextElem)
	profileShotButton.profileShotTextElem = profileShotTextElem
	
	local f8_local6 = CoD.CRCommon.GetStretchedImage()
	local f8_local7 = 467
	local f8_local8 = 60
	f8_local6:setLeftRight(false, false, -640 - f8_local7, 640 - f8_local7)
	f8_local6:setTopBottom(false, false, -360 + f8_local8, 360 + f8_local8)
	f8_local6:setImage(RegisterMaterial("menu_mp_soldiers"))
	f8_local6:setAlpha(0.6)
	profileShotButton.defaultProfileShotImage = f8_local6
	local f8_local9, f8_local10, f8_local11 = nil
	if CoD.CRCommon.CurrentXuid and CoD.CRCommon.CurrentXuid ~= "" and CoD.CRCommon.CurrentXuid ~= "0" then
		local f8_local12, f8_local13, f8_local14 = Engine.GetCombatRecordScreenshotInfo(f8_arg1, CoD.CRCommon.CurrentXuid)
		f8_local11 = f8_local14
		f8_local10 = f8_local13
		f8_local9 = f8_local12
	end
	if f8_local9 and f8_local9 ~= "0" and true == Engine.CanViewContent() then
		local f8_local12 = CoD.CRCommon.GetStretchedImage()
		f8_local12:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_THUMBNAIL, f8_local9)
		Engine.Exec(f8_arg1, "addThumbnail " .. CoD.UI_SCREENSHOT_TYPE_THUMBNAIL .. " " .. f8_local9 .. " " .. f8_local10)
		profileShotButton.profileShotImage = f8_local12
		profileShotImageContainer:addElement(f8_local12)
		profileShotButton:addElement(profileShotImageContainer)
		profileShotTextElem:setText(f8_local11)
		profileShotButton.fileName = f8_local11
		profileShotButton.fileId = f8_local9
		profileShotButton.defaultProfileShot = false
		profileShotButton:setActionEventName("profile_shot_button_action_view_fullscreen")
	else
		profileShotImageContainer:addElement(f8_local6)
	end
	profileShotButton:registerEventHandler("clear_profile_shot", CoD.CRCareer.ButtonClearProfileShot)
	profileShotButton:registerEventHandler("gain_focus", CoD.CRCareer.ProfileShotButtonGainFocus)
end

CoD.CRCareer.SetupElements = function (f9_arg0, f9_arg1)
	if CoD.CRCommon.CurrentXuid and CoD.CRCommon.CurrentXuid ~= "" and CoD.CRCommon.CurrentXuid ~= "0" then
		f9_arg0:addElement(CoD.MiniIdentity.GetMiniIdentity(f9_arg1, CoD.CRCommon.CurrentXuid))
	end
	local f9_local0 = CoD.CRCommon.GetStats(f9_arg1, CoD.CRCommon.OtherPlayerCRMode)
	local f9_local1 = 0
	local f9_local2 = CoD.Menu.TitleHeight + 20
	f9_arg0:addElement(CoD.CRCommon.GetTextElem("Default", "Left", Engine.Localize("MENU_PROFILE_SUMMARY"), CoD.gray, f9_local2))
	f9_local2 = f9_local2 + CoD.textSize.Default + 8
	local f9_local3 = 185
	CoD.CRCareer.SetupStatContainer(f9_arg0, f9_local2, f9_local3, f9_local0)
	f9_local2 = f9_local2 + f9_local3 + 20
	f9_arg0:addElement(CoD.CRCommon.GetTextElem("Default", "Left", Engine.Localize("MENU_PROFILE_SHOT"), CoD.gray, f9_local2))
	f9_local1 = CoD.Menu.Width / 2
	local f9_local4 = CoD.CRCommon.GetTextElem("Default", "Left", Engine.Localize("MENU_SHOWCASE"), CoD.gray, f9_local2)
	f9_local4:setLeftRight(true, true, f9_local1, 0)
	f9_arg0:addElement(f9_local4)
	f9_local2 = f9_local2 + CoD.textSize.Default + 8
	CoD.CRCareer.SetupProfileShotButton(f9_arg0, f9_arg1, 0, f9_local2)
	CoD.CRCareer.SetupShowcase(f9_arg0, f9_arg1, f9_local2)
	local f9_local5 = 55
	local f9_local6 = CoD.CRCommon.GetTextElem("ExtraSmall", "Left", "")
	f9_local6:setLeftRight(true, true, CoD.Menu.Width / 2, 0)
	f9_local6:setTopBottom(false, true, -f9_local5 - CoD.textSize.ExtraSmall, -f9_local5)
	f9_arg0.bgChallengeDesc = f9_local6
	f9_arg0:addElement(f9_local6)
	f9_arg0.profileShotButton.navigation.right = f9_arg0.showcaseButtons[1]
	if not CoD.CRCommon.OtherPlayerCRMode and CoD.perController[f9_arg1].CRFocusCurrentBg and CoD.perController[f9_arg1].CRCurrentBgIndex then
		CoD.perController[f9_arg1].CRFocusCurrentBg = false
		f9_arg0.showcaseButtons[CoD.perController[f9_arg1].CRCurrentBgIndex + 1]:processEvent({
			name = "gain_focus",
			controller = f9_arg1
		})
	else
		f9_arg0.profileShotButton:processEvent({
			name = "gain_focus",
			controller = f9_arg1
		})
	end
end

CoD.CRCareer.ProfileShotButtonActionDefault = function (f10_arg0, f10_arg1)
	if Engine.CanViewContent() == false then
		f10_arg0:openPopup("popup_contentrestricted", f10_arg1.controller)
		return 
	elseif Engine.IsCodtvContentLoaded() == true then
		CoD.perController[f10_arg1.controller].codtvRoot = "combatrecord"
		Engine.Exec(f10_arg1.controller, "fileshareAbortSummary")
		Engine.Exec(f10_arg1.controller, "resetThumbnailViewer")
		f10_arg0:openMenu("CODTv", f10_arg1.controller)
		f10_arg0:close()
	end
end

CoD.CRCareer.ProfileShotButtonActionViewFullscreen = function (f11_arg0, f11_arg1)
	local f11_local0 = f11_arg1.button
	if f11_local0 and f11_local0.fileId and not f11_local0.defaultBackground then
		Engine.DownloadFileDescriptor(f11_arg1.controller, f11_local0.fileId)
	end
end

CoD.CRCareer.ShowcaseButtonAction = function (f12_arg0, f12_arg1)
	if Engine.IsCodtvContentLoaded() == true then
		CoD.perController[f12_arg1.controller].CRCurrentBgIndex = f12_arg1.button.bgIndex
		CoD.CRCommon.CRMode = true
		f12_arg0:openMenu("EmblemBackgroundSelector", f12_arg1.controller)
		f12_arg0:close()
	end
end

CoD.CRCareer.GoBack = function (f13_arg0, f13_arg1)
	Engine.Exec(f13_arg0.m_ownerController, "fileshareAbortSummary")
	Engine.Exec(f13_arg0.m_ownerController, "resetThumbnailViewer")
	Engine.Exec(f13_arg0.m_ownerController, "uploadprofile")
	CoD.Menu.goBack(f13_arg0, f13_arg1)
end

CoD.CRCareer.ButtonClearShowcaseShot = function (f14_arg0, f14_arg1)
	if not f14_arg0:isInFocus() then
		return 
	end
	f14_arg0:dispatchEventToParent({
		name = "remove_select_button_prompt"
	})
	f14_arg0:dispatchEventToParent({
		name = "update_background_challenge_desc"
	})
	f14_arg0.defaultBackground = true
	Engine.SetCombatRecordBackgroundId(f14_arg1.controller, 0, f14_arg0.bgIndex)
	if f14_arg0.backingChallengeName then
		f14_arg0.backingChallengeName:setText(f14_arg0.defaultName)
	end
	if f14_arg0.backgroundImage then
		f14_arg0.backgroundImage:close()
	end
	f14_arg0:dispatchEventToParent({
		name = "add_select_button_prompt",
		buttonPromptText = Engine.Localize("MENU_PERSONALIZE_SHOWCASE_SHOT")
	})
	f14_arg0:setActionEventName("showcase_button_action")
end

CoD.CRCareer.ClearShowcaseShot = function (f15_arg0, f15_arg1)
	if f15_arg0.clearButtonPrompt then
		f15_arg0.clearButtonPrompt:close()
	end
	f15_arg0:dispatchEventToChildren(f15_arg1)
end

CoD.CRCareer.ButtonClearProfileShot = function (f16_arg0, f16_arg1)
	f16_arg0:dispatchEventToParent({
		name = "remove_select_button_prompt"
	})
	f16_arg0.defaultProfileShot = true
	if f16_arg0.profileShotTextElem then
		f16_arg0.profileShotTextElem:setText(Engine.Localize("MENU_PROFILE_SHOT_HINT"))
	end
	if f16_arg0.profileShotImage then
		f16_arg0.profileShotImage:close()
		if f16_arg0.defaultProfileShotImage then
			f16_arg0.profileShotImageContainer:addElement(f16_arg0.defaultProfileShotImage)
		end
	end
	f16_arg0:dispatchEventToParent({
		name = "add_select_button_prompt",
		buttonPromptText = Engine.Localize("MENU_PERSONALIZE_PROFILE_SHOT")
	})
	f16_arg0:setActionEventName("profile_shot_button_action_default")
end

CoD.CRCareer.ClearProfileShot = function (f17_arg0, f17_arg1)
	Engine.SetCombatRecordScreenshotInfo(f17_arg1.controller, "0", 0, "")
	f17_arg0:processEvent({
		name = "remove_clear_button_prompt"
	})
	f17_arg0:dispatchEventToChildren(f17_arg1)
end

CoD.CRCareer.RemoveClearButtonPrompt = function (f18_arg0, f18_arg1)
	if f18_arg0.clearButtonPrompt then
		f18_arg0.clearButtonPrompt:close()
	end
end

CoD.CRCareer.AddClearButtonPrompt = function (f19_arg0, f19_arg1)
	if (f19_arg0.clearButtonPrompt == nil or f19_arg0.clearButtonPrompt and f19_arg0.clearButtonPrompt:getParent() == nil) and f19_arg1.buttonPromptText and f19_arg1.buttonPromptEventName then
		local f19_local0 = CoD.ButtonPrompt.new
		local f19_local1 = "alt1"
		local f19_local2 = f19_arg1.buttonPromptText
		local f19_local3 = f19_arg0
		local f19_local4 = f19_arg1.buttonPromptEventName
		local f19_local5, f19_local6 = false
		local f19_local7, f19_local8 = false
		f19_arg0.clearButtonPrompt = f19_local0(f19_local1, f19_local2, f19_local3, f19_local4, f19_local5, f19_local6, f19_local7, f19_local8, "S")
		f19_arg0.clearButtonPrompt:setPriority(10)
		f19_arg0:addLeftButtonPrompt(f19_arg0.clearButtonPrompt)
	end
end

CoD.CRCareer.RemoveSelectButtonPrompt = function (f20_arg0, f20_arg1)
	if f20_arg0.selectButton then
		f20_arg0.selectButton:close()
	end
end

CoD.CRCareer.AddSelectButtonPrompt = function (f21_arg0, f21_arg1)
	if (f21_arg0.selectButtonPrompt == nil or f21_arg0.selectButtonPrompt and f21_arg0.selectButtonPrompt:getParent() == nil) and f21_arg1.buttonPromptText then
		f21_arg0:addSelectButton(f21_arg1.buttonPromptText)
	end
end

CoD.CRCareer.UpdateBackgroundChallengeDesc = function (f22_arg0, f22_arg1)
	if f22_arg0.bgChallengeDesc then
		f22_arg0.bgChallengeDesc:setText("")
		if f22_arg1.text then
			f22_arg0.bgChallengeDesc:setText(Engine.Localize("MENU_CHALLENGE_COMPLETED", f22_arg1.text))
		end
	end
end

CoD.CRCareer.ScreenshotInfoDownloaded = function (f23_arg0, f23_arg1)
	if not f23_arg1.success then
		f23_arg0:openPopup("popup_downloading_failed", f23_arg1.controller)
		return 
	else
		CoD.perController[f23_arg1.controller].fileActionInfo = {
			name = f23_arg0.profileShotButton.fileName,
			description = f23_arg1.description,
			author = f23_arg1.author,
			fileID = f23_arg1.fileID,
			fileSize = f23_arg1.fileSize,
			CRMode = true
		}
		f23_arg0:openPopup("Screenshot_Viewer", f23_arg1.controller)
	end
end

LUI.createMenu.CRCareer = function (f24_arg0)
	local f24_local0 = CoD.Menu.New("CRCareer")
	f24_local0:addLargePopupBackground()
	f24_local0:setOwner(f24_arg0)
	f24_local0:setPreviousMenu("Barracks")
	f24_local0:addBackButton()
	f24_local0.goBack = CoD.CRCareer.GoBack
	f24_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_CHALLENGES_CAREER")))
	f24_local0:registerEventHandler("profile_shot_button_action_default", CoD.CRCareer.ProfileShotButtonActionDefault)
	f24_local0:registerEventHandler("profile_shot_button_action_view_fullscreen", CoD.CRCareer.ProfileShotButtonActionViewFullscreen)
	f24_local0:registerEventHandler("showcase_button_action", CoD.CRCareer.ShowcaseButtonAction)
	f24_local0:registerEventHandler("clear_profile_shot", CoD.CRCareer.ClearProfileShot)
	f24_local0:registerEventHandler("clear_showcase_shot", CoD.CRCareer.ClearShowcaseShot)
	f24_local0:registerEventHandler("add_clear_button_prompt", CoD.CRCareer.AddClearButtonPrompt)
	f24_local0:registerEventHandler("remove_clear_button_prompt", CoD.CRCareer.RemoveClearButtonPrompt)
	f24_local0:registerEventHandler("add_select_button_prompt", CoD.CRCareer.AddSelectButtonPrompt)
	f24_local0:registerEventHandler("remove_select_button_prompt", CoD.CRCareer.RemoveSelectButtonPrompt)
	f24_local0:registerEventHandler("update_background_challenge_desc", CoD.CRCareer.UpdateBackgroundChallengeDesc)
	f24_local0:registerEventHandler("fileshare_descriptor_downloaded", CoD.CRCareer.ScreenshotInfoDownloaded)
	CoD.CRCareer.SetupElements(f24_local0, f24_arg0)
	return f24_local0
end

