require("T6.ChallengeGridButton")
CoD.CommonChallengeType = {}
CoD.CommonChallengeType.imagePreviewLineMaterialName = "menu_mp_cac_attach_line"
CoD.CommonChallengeType.GridTop = 60
CoD.CommonChallengeType.GridItemSpacing = 10
CoD.CommonChallengeType.GridColumns = 4
CoD.CommonChallengeType.GridItemWidth = (CoD.Menu.Width - CoD.CommonChallengeType.GridItemSpacing * (CoD.CommonChallengeType.GridColumns - 1)) / CoD.CommonChallengeType.GridColumns
CoD.CommonChallengeType.GridItemHeight = 50 + CoD.ContentGridButton.TitleHeight + 12
LUI.createMenu.CommonChallengeType = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CommonChallengeType")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:addBackButton()
	local f1_local1 = CoD.perController[f1_arg0].CommonChallengeTypeData
	f1_local0.category = f1_local1.category
	if f1_local1.gamemodeName then
		f1_local0.gamemodeName = f1_local1.gamemodeName
	end
	local f1_local2 = ""
	if f1_local1.titleText then
		f1_local2 = f1_local1.titleText
	else
		f1_local2 = Engine.Localize("MENU_CHALLENGE_CATEGORY_" .. f1_local1.category)
	end
	f1_local0:addTitle(UIExpression.ToUpper(nil, f1_local2))
	CoD.CommonChallengeType.SetupElements(f1_local0)
	return f1_local0
end

CoD.CommonChallengeType.SetupElements = function (f2_arg0)
	f2_arg0.menuContainer = LUI.UIElement.new()
	f2_arg0.menuContainer:setLeftRight(true, true, 0, 0)
	f2_arg0.menuContainer:setTopBottom(true, true, 0, 0)
	f2_arg0:addElement(f2_arg0.menuContainer)
	f2_arg0.menuContainer.m_ownerController = f2_arg0.m_ownerController
	f2_arg0.menuContainer:registerEventHandler("content_button_highlighted", CoD.CommonChallengeType.ButtonHighlighted)
	f2_arg0.menuContainer.contentGrid = CoD.ContentGrid.new(CoD.CommonChallengeType.GridColumns, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.Menu.TitleHeight + 25,
		bottom = 0
	}, CoD.CommonChallengeType.GridItemWidth, CoD.CommonChallengeType.GridItemHeight, CoD.CommonChallengeType.GridItemSpacing)
	f2_arg0.menuContainer:addElement(f2_arg0.menuContainer.contentGrid)
	local f2_local0 = 4
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(false, true, -200, 0)
	f2_arg0.menuContainer:addElement(Widget)
	local f2_local2 = 0
	f2_arg0.menuContainer.challengeTitle = LUI.UIText.new()
	f2_arg0.menuContainer.challengeTitle:setLeftRight(true, false, 0, 1)
	f2_arg0.menuContainer.challengeTitle:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.Big)
	f2_arg0.menuContainer.challengeTitle:setFont(CoD.fonts.Big)
	f2_arg0.menuContainer.challengeTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(f2_arg0.menuContainer.challengeTitle)
	f2_local2 = f2_local2 + CoD.textSize.Big
	f2_arg0.menuContainer.challengeDescription = LUI.UIText.new()
	f2_arg0.menuContainer.challengeDescription:setLeftRight(true, false, 0, CoD.Menu.Width / 2 - 50)
	f2_arg0.menuContainer.challengeDescription:setTopBottom(true, false, f2_local2, f2_local2 + CoD.textSize.ExtraSmall)
	f2_arg0.menuContainer.challengeDescription:setAlignment(LUI.Alignment.Left)
	f2_arg0.menuContainer.challengeDescription:setFont(CoD.fonts.ExtraSmall)
	f2_arg0.menuContainer.challengeDescription:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f2_arg0.menuContainer.challengeDescription:setAlpha(0.4)
	Widget:addElement(f2_arg0.menuContainer.challengeDescription)
	f2_local2 = f2_local2 + CoD.textSize.ExtraSmall + 22
	local f2_local3 = CoD.Menu.Width * 0.33
	f2_arg0.menuContainer.progressBar = CoD.ChallengeProgressBar.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f2_local3,
		topAnchor = true,
		bottomAnchor = true,
		top = f2_local2,
		bottom = 0
	}, f2_local3)
	Widget:addElement(f2_arg0.menuContainer.progressBar)
	local f2_local4 = "Condensed"
	local f2_local5 = CoD.fonts[f2_local4]
	local f2_local6 = CoD.textSize[f2_local4]
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f2_local3)
	Widget:setTopBottom(true, false, f2_local2, f2_local2 + f2_local6)
	f2_arg0.menuContainer.completeTextContainer = Widget
	Widget:addElement(f2_arg0.menuContainer.completeTextContainer)
	local f2_local8 = "ExtraSmall"
	local f2_local9 = CoD.fonts[f2_local8]
	local f2_local10 = CoD.textSize[f2_local8]
	local f2_local11 = LUI.UIText.new()
	local f2_local12 = 35
	f2_local11:setLeftRight(true, false, 0, f2_local3)
	f2_local11:setTopBottom(false, true, -f2_local12 - f2_local10, -f2_local12)
	f2_local11:setFont(f2_local9)
	f2_local11:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	f2_arg0.menuContainer.tierDescText = f2_local11
	Widget:addElement(f2_arg0.menuContainer.tierDescText)
	local f2_local13 = LUI.UIText.new()
	f2_local13:setLeftRight(true, true, 0, 0)
	f2_local13:setTopBottom(true, true, 0, 0)
	f2_local13:setText(Engine.Localize("MPUI_COMPLETE_CAPS"))
	f2_local13:setFont(f2_local5)
	f2_local13:setAlignment(LUI.Alignment.Left)
	f2_local13:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f2_arg0.menuContainer.completeText = f2_local13
	Widget:addElement(f2_local13)
	f2_local13:hide()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -(CoD.Menu.Width / 2) + 10, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local f2_local15 = 64
	local f2_local16 = 5
	local f2_local17 = -CoD.ButtonPrompt.Height - 22
	local f2_local18 = 120
	local f2_local19 = 300
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f2_local16, f2_local16 + f2_local19)
	Widget:setTopBottom(false, true, f2_local17 - f2_local18, f2_local17)
	Widget:addElement(Widget)
	local f2_local21 = "Default"
	local f2_local22 = CoD.fonts[f2_local21]
	local f2_local23 = CoD.textSize[f2_local21]
	f2_arg0.menuContainer.imagePreviewTitle = LUI.UIText.new()
	f2_arg0.menuContainer.imagePreviewTitle:setLeftRight(true, false, 0, 1)
	f2_arg0.menuContainer.imagePreviewTitle:setTopBottom(true, false, -f2_local23, 0)
	f2_arg0.menuContainer.imagePreviewTitle:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	f2_arg0.menuContainer.imagePreviewTitle:setFont(f2_local22)
	f2_arg0.menuContainer.imagePreviewTitle:setAlignment(LUI.Alignment.Left)
	f2_arg0.menuContainer.imagePreviewTitle:setText("")
	Widget:addElement(f2_arg0.menuContainer.imagePreviewTitle)
	local f2_local24 = "Default"
	local f2_local25 = CoD.fonts[f2_local21]
	local f2_local26 = CoD.textSize[f2_local21]
	f2_arg0.menuContainer.xpReward = LUI.UIText.new()
	f2_arg0.menuContainer.xpReward:setLeftRight(true, true, 0, 0)
	f2_arg0.menuContainer.xpReward:setTopBottom(false, true, -10 - f2_local26, -10)
	f2_arg0.menuContainer.xpReward:setAlignment(LUI.Alignment.Center)
	f2_arg0.menuContainer.xpReward:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
	f2_arg0.menuContainer.xpReward:setFont(f2_local25)
	f2_arg0.menuContainer.xpReward:setText("")
	Widget:addElement(f2_arg0.menuContainer.xpReward)
	f2_arg0.menuContainer.challengeImageContainer = LUI.UIElement.new()
	f2_arg0.menuContainer.challengeImageContainer:setLeftRight(true, true, 0, 0)
	f2_arg0.menuContainer.challengeImageContainer:setTopBottom(true, true, 0, 0)
	Widget:addElement(f2_arg0.menuContainer.challengeImageContainer)
	f2_arg0.menuContainer.challengeImage = LUI.UIImage.new()
	f2_arg0.menuContainer.challengeImage:setLeftRight(true, true, 0, 0)
	f2_arg0.menuContainer.challengeImage:setTopBottom(true, true, 0, 0)
	f2_arg0.menuContainer.challengeImage:setAlpha(0)
	f2_arg0.menuContainer.challengeImageContainer:addElement(f2_arg0.menuContainer.challengeImage)
	local f2_local27 = 32
	local f2_local28 = 5
	local f2_local29 = 5
	f2_arg0.menuContainer.lockImage = LUI.UIImage.new()
	f2_arg0.menuContainer.lockImage:setLeftRight(true, false, f2_local28, f2_local28 + f2_local27)
	f2_arg0.menuContainer.lockImage:setTopBottom(false, true, -f2_local29 - f2_local27, -f2_local29)
	f2_arg0.menuContainer.lockImage:setAlpha(0)
	f2_arg0.menuContainer.lockImage:setImage(RegisterMaterial(CoD.CACUtility.LockImageMaterial))
	Widget:addElement(f2_arg0.menuContainer.lockImage)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.1, nil, nil, true, "menu_sp_cac_single_big_dip"))
	CoD.CommonChallengeType.AddItems(f2_arg0.menuContainer, f2_arg0.m_ownerController, f2_arg0.category, f2_arg0.gamemodeName)
end

CoD.ChallengeInfoComparisonFunction = function (f3_arg0, f3_arg1)
	return tonumber(f3_arg0.challengeRow) < tonumber(f3_arg1.challengeRow)
end

CoD.CommonChallengeType.AddItems = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	local f4_local0 = Engine.GetChallengeInfoForImages(f4_arg1, f4_arg2)
	if not f4_local0 then
		return 
	end
	table.sort(f4_local0, CoD.ChallengeInfoComparisonFunction)
	local f4_local1 = Engine.GetPlayerStats(f4_arg1)
	local f4_local2 = f4_local1.PlayerStatsList.RANK.StatValue:get()
	local f4_local3 = f4_local1.PlayerStatsList.PLEVEL.StatValue:get()
	local f4_local4 = nil
	local f4_local5 = 1
	for f4_local35, f4_local36 in ipairs(f4_local0) do
		local f4_local37 = f4_local36.challengeRow
		local f4_local38 = f4_local36.tableNum
		local f4_local15 = -1
		local f4_local22 = 0
		local f4_local23 = 0
		local f4_local9 = nil
		local f4_local11 = -1
		local f4_local39 = f4_local36.challengeType
		local f4_local26 = ""
		local f4_local12 = ""
		local f4_local40, f4_local21, f4_local29, f4_local27, f4_local13, f4_local14, f4_local10 = nil
		if f4_local37 ~= nil then
			f4_local9 = "mp/statsmilestones" .. f4_local38 + 1 .. ".csv"
			f4_local10 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local9, f4_local37, 1))
			f4_local11 = UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local9, f4_local37, 2)
			f4_local12 = UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local9, f4_local37, 4)
			f4_local13 = UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local9, f4_local37, 5)
			f4_local14 = UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local9, f4_local37, 5) .. "_DESC"
			f4_local15 = UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local9, f4_local37, 6)
			local f4_local16 = UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local9, f4_local37, 11)
			local f4_local17 = UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local9, f4_local37, 14)
			local f4_local18 = -1
			local f4_local19, f4_local20 = nil
			f4_local21 = CoD.GetLocalizedTierText(f4_arg1, f4_local9, f4_local37)
			if f4_local16 ~= "" then
				f4_local22 = tonumber(f4_local16)
			end
			if f4_local17 ~= "" then
				f4_local23 = tonumber(f4_local17)
			end
			local f4_local24 = f4_local36.isLocked
			local f4_local25 = false
			if f4_local39 == CoD.MILESTONE_WEAPON then
				f4_local26 = Engine.Localize(UIExpression.GetItemName(nil, f4_local36.itemIndex))
			elseif f4_local39 == CoD.MILESTONE_GROUP then
				f4_local26 = Engine.Localize("MPUI_" .. UIExpression.GetItemGroupByIndex(nil, f4_local36.itemIndex))
			elseif f4_local39 == CoD.MILESTONE_ATTACHMENTS then
				f4_local26 = Engine.Localize(UIExpression.GetAttachmentName(nil, f4_local36.itemIndex))
			elseif f4_local39 == CoD.MILESTONE_GAMEMODE then
				if f4_arg3 then
					f4_local26 = f4_arg3
				else
					f4_local26 = Engine.Localize("MPUI_" .. Engine.GetGametypeName(f4_local36.itemIndex))
				end
			elseif f4_arg3 then
				f4_local26 = f4_arg3
			end
			if f4_local21 ~= "" then
				f4_local27 = true
			end
			if f4_local3 < f4_local23 then
				f4_local25 = true
				f4_local20 = Engine.Localize("CLASS_PRESTIGE_UNLOCK_DESC", f4_local23)
			elseif f4_local2 < f4_local22 and f4_local3 <= f4_local23 then
				f4_local25 = true
				f4_local20 = Engine.Localize("MENU_UNLOCKED_AT", Engine.GetRankName(f4_local22), f4_local22 + 1)
			end
			if f4_local27 and f4_local25 then
				f4_local21 = Engine.Localize("CHALLENGE_TIER_" .. 0)
			end
			local f4_local28 = f4_local36.currentChallengeRow
			if f4_local28 and f4_local9 then
				f4_local29 = true
				f4_local14 = UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local9, f4_local28, 5) .. "_DESC"
				if f4_local27 then
					f4_local18 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local9, f4_local28, 1))
					f4_local11 = UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local9, f4_local28, 2)
					f4_local21 = CoD.GetLocalizedTierText(f4_arg1, f4_local9, f4_local28)
				end
			end
			f4_local19 = Engine.Localize(f4_local13, "", f4_local26, f4_local21)
			if not f4_local20 then
				f4_local20 = Engine.Localize(f4_local14, f4_local11, f4_local26)
			end
			local f4_local30 = true
			local f4_local31 = "background"
			if f4_local36.isEmblem then
				f4_local31 = "icon"
			end
			local f4_local32 = tonumber(UIExpression.TableLookup(f4_arg1, "mp/emblemsOrBackings.csv", 0, f4_local31, 1, f4_local36.imageID, 8))
			if f4_local32 and f4_local32 == 1 and (f4_local24 or f4_local25) then
				f4_local30 = false
			end
			if f4_local30 then
				local f4_local33 = CoD.ChallengeGridButton.new(f4_arg1, f4_local5, f4_local19, f4_local36.imageID, f4_local36.isEmblem)
				f4_local33.challengeDesc = f4_local20
				f4_local33.challengeName = f4_local19
				f4_local33.xpReward = f4_local15
				f4_local33.maxVal = tonumber(f4_local11)
				f4_local33.currVal = f4_local36.currChallengeStatValue
				f4_local33.imageID = f4_local36.imageID
				f4_local33.isEmblem = f4_local36.isEmblem
				local f4_local34
				if f4_local24 ~= 0 then
					f4_local34 = f4_local24
				else
					f4_local34 = f4_local25
				end
				f4_local33.isLocked = f4_local34
				f4_local33.challengeUnlocked = f4_local29
				f4_local33.statName = f4_local12
				f4_local33.isTieredChallenge = f4_local27
				f4_local33.currentChallengeTier = f4_local18
				f4_local33.maxChallengeTier = f4_local10
				f4_local33.actionSFX = nil
				if f4_local33.isLocked then
					f4_local33:setLocked(true)
				end
				f4_arg0.contentGrid:addButton(f4_local33)
				if not f4_local4 then
					f4_local4 = f4_local33
				end
				f4_local5 = f4_local5 + 1
			end
		end
	end
	if f4_local4 then
		f4_local4:processEvent({
			name = "gain_focus",
			controller = f4_arg1
		})
	end
end

CoD.CommonChallengeType.UpdateChallengeImagePreview = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	f5_arg0.imagePreviewTitle:setText(Engine.Localize("MPUI_REWARDS"))
	local f5_local0 = 75
	local f5_local1 = 75
	local f5_local2 = 10
	if f5_arg3 then
		f5_arg0.challengeImage:setupDrawEmblemById(f5_arg1)
	else
		f5_arg0.challengeImage:setupDrawBackgroundById(f5_arg1)
		f5_local0 = 280
		f5_local1 = 70
	end
	if f5_arg4 then
		f5_arg0.lockImage:setAlpha(1)
		f5_arg0.xpReward:setText(Engine.Localize("RANK_XP", f5_arg2))
	else
		f5_arg0.lockImage:setAlpha(0)
		f5_arg0.xpReward:setText("")
	end
	f5_arg0.challengeImageContainer:setLeftRight(false, false, -f5_local0 / 2, f5_local0 / 2)
	f5_arg0.challengeImageContainer:setTopBottom(true, false, f5_local2, f5_local2 + f5_local1)
	f5_arg0.challengeImage:setAlpha(1)
end

CoD.CommonChallengeType.HideProgressBarForStatName = function (f6_arg0)
	if f6_arg0 == "challlenges" or f6_arg0 == "primary_mastery" or f6_arg0 == "secondary_mastery" or f6_arg0 == "weapons_mastery" then
		return true
	else

	end
end

CoD.CommonChallengeType.ButtonHighlighted = function (f7_arg0, f7_arg1)
	if f7_arg1.contentIndex then
		local f7_local0 = true
		local f7_local1 = f7_arg1.button
		f7_arg0.challengeTitle:setText(f7_local1.challengeName)
		f7_arg0.challengeDescription:setText(f7_local1.challengeDesc)
		f7_arg0.progressBar:hide()
		f7_arg0.completeText:hide()
		f7_arg0.tierDescText:hide()
		if CoD.CommonChallengeType.HideProgressBarForStatName(f7_local1.statName) then
			f7_local0 = false
		end
		local f7_local2 = f7_local1.currVal
		local f7_local3 = f7_local1.maxVal
		if f7_local1.isLocked and f7_local1.challengeUnlocked then
			if f7_local3 > 1 and f7_local0 and f7_local2 < f7_local3 then
				f7_arg0.progressBar:show()
				f7_arg0.progressBar:update(f7_local2, f7_local3)
			end
			local f7_local4 = f7_local1.isTieredChallenge
			local f7_local5 = f7_local1.currentChallengeTier
			local f7_local6 = f7_local1.maxChallengeTier
			if f7_local4 and f7_local5 and f7_local6 and f7_local5 ~= -1 and f7_local6 > 0 then
				f7_arg0.tierDescText:show()
				f7_arg0.tierDescText:setText(Engine.Localize("MENU_CHALLENGE_TIER_DESC", f7_local5 + 1, f7_local6 + 1, f7_local6 + 1))
			end
		elseif not f7_local1.isLocked then
			f7_arg0.completeText:show()
		end
		CoD.CommonChallengeType.UpdateChallengeImagePreview(f7_arg0, f7_arg1.button.imageID, f7_arg1.button.xpReward, f7_arg1.button.isEmblem, f7_arg1.button.isLocked)
	else
		f7_arg0.challengeTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f7_arg0.challengeDescription:setText("")
	end
end

