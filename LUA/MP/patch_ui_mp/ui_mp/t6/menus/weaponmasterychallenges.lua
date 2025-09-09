require("T6.ChallengeGridButton")
CoD.WeaponMasteryChallenges = {}
CoD.WeaponMasteryChallenges.GridTop = 60
CoD.WeaponMasteryChallenges.GridColumns = 4
CoD.WeaponMasteryChallenges.GridItemSpacing = 10
CoD.WeaponMasteryChallenges.GridItemWidth = (CoD.Menu.Width - CoD.WeaponMasteryChallenges.GridItemSpacing * (CoD.WeaponMasteryChallenges.GridColumns - 1)) / CoD.WeaponMasteryChallenges.GridColumns
CoD.WeaponMasteryChallenges.GridItemHeight = 50 + CoD.ContentGridButton.TitleHeight + 30
LUI.createMenu.WeaponMasteryChallenges = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("WeaponMasteryChallenges")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	local f1_local1 = CoD.perController[f1_arg0].weaponIndex
	local f1_local2 = CoD.perController[f1_arg0].weaponSlot
	f1_local0:setPreviousMenu("WeaponChallengeType")
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("content_button_highlighted", CoD.WeaponMasteryChallenges.ButtonHighlighted)
	local f1_local3 = 0
	f1_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_CHALLENGES_WEAPON_MASTERY", UIExpression.GetItemName(nil, f1_local1))))
	f1_local3 = f1_local3 + CoD.textSize.Big + 15
	f1_local0.contentGrid = CoD.ContentGrid.new(CoD.WeaponMasteryChallenges.GridColumns, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local3,
		bottom = 0
	}, CoD.WeaponMasteryChallenges.GridItemWidth, CoD.WeaponMasteryChallenges.GridItemHeight, CoD.WeaponMasteryChallenges.GridItemSpacing)
	f1_local0:addElement(f1_local0.contentGrid)
	local f1_local4 = 1
	f1_local3 = f1_local3 + CoD.WeaponMasteryChallenges.GridItemHeight * f1_local4 + CoD.WeaponMasteryChallenges.GridItemSpacing * (f1_local4 - 1) + 3 + CoD.HintText.Height + 5
	
	local infoContainer = LUI.UIElement.new()
	infoContainer:setLeftRight(true, true, 0, 0)
	infoContainer:setTopBottom(false, true, -200, 0)
	f1_local0:addElement(infoContainer)
	f1_local0.infoContainer = infoContainer
	
	CoD.WeaponMasteryChallenges.ChallengeLeftSideDesc(f1_local0)
	CoD.WeaponMasteryChallenges.ChallengeImagePreview(f1_local0)
	CoD.WeaponMasteryChallenges.AddMasteryChallengeButtons(f1_local0, f1_arg0, f1_local1, f1_local2)
	return f1_local0
end

CoD.WeaponMasteryChallenges.ChallengeLeftSideDesc = function (f2_arg0)
	local f2_local0 = 0
	f2_arg0.challengeTitle = LUI.UIText.new()
	f2_arg0.challengeTitle:setLeftRight(true, false, 0, 1)
	f2_arg0.challengeTitle:setTopBottom(true, false, f2_local0, f2_local0 + CoD.textSize.Big)
	f2_arg0.challengeTitle:setFont(CoD.fonts.Big)
	f2_arg0.challengeTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f2_arg0.infoContainer:addElement(f2_arg0.challengeTitle)
	f2_local0 = f2_local0 + CoD.textSize.Big
	f2_arg0.challengeDescription = LUI.UIText.new()
	f2_arg0.challengeDescription:setLeftRight(true, false, 0, CoD.Menu.Width / 2)
	f2_arg0.challengeDescription:setTopBottom(true, false, f2_local0, f2_local0 + CoD.textSize.Default)
	f2_arg0.challengeDescription:setAlignment(LUI.Alignment.Left)
	f2_arg0.challengeDescription:setFont(CoD.fonts.Default)
	f2_arg0.challengeDescription:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f2_arg0.challengeDescription:setAlpha(0.4)
	f2_arg0.infoContainer:addElement(f2_arg0.challengeDescription)
	f2_local0 = f2_local0 + CoD.textSize.Default + 25
	local f2_local1 = CoD.Menu.Width * 0.33
	f2_arg0.progressBar = CoD.ChallengeProgressBar.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f2_local1,
		topAnchor = true,
		bottomAnchor = true,
		top = f2_local0,
		bottom = 0
	}, f2_local1)
	f2_arg0.progressBar:hide()
	f2_arg0.infoContainer:addElement(f2_arg0.progressBar)
end

CoD.WeaponMasteryChallenges.ChallengeImagePreview = function (f3_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -(CoD.Menu.Width / 2) + 10, 0)
	Widget:setTopBottom(true, true, 0, 0)
	f3_arg0.infoContainer:addElement(Widget)
	local f3_local1 = 64
	local f3_local2 = 5
	local f3_local3 = -CoD.ButtonPrompt.Height - 22
	local f3_local4 = 120
	local f3_local5 = 300
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f3_local2, f3_local2 + f3_local5)
	Widget:setTopBottom(false, true, f3_local3 - f3_local4, f3_local3)
	Widget:addElement(Widget)
	local f3_local7 = "Default"
	local f3_local8 = CoD.fonts[f3_local7]
	local f3_local9 = CoD.textSize[f3_local7]
	f3_arg0.imagePreviewTitle = LUI.UIText.new()
	f3_arg0.imagePreviewTitle:setLeftRight(true, false, 0, 1)
	f3_arg0.imagePreviewTitle:setTopBottom(true, false, -f3_local9, 0)
	f3_arg0.imagePreviewTitle:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	f3_arg0.imagePreviewTitle:setFont(f3_local8)
	f3_arg0.imagePreviewTitle:setAlignment(LUI.Alignment.Left)
	f3_arg0.imagePreviewTitle:setText("")
	Widget:addElement(f3_arg0.imagePreviewTitle)
	local f3_local10 = "Default"
	local f3_local11 = CoD.fonts[f3_local7]
	local f3_local12 = CoD.textSize[f3_local7]
	f3_arg0.xpReward = LUI.UIText.new()
	f3_arg0.xpReward:setLeftRight(true, true, 0, 0)
	f3_arg0.xpReward:setTopBottom(false, true, -10 - f3_local12, -10)
	f3_arg0.xpReward:setAlignment(LUI.Alignment.Center)
	f3_arg0.xpReward:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
	f3_arg0.xpReward:setFont(f3_local11)
	f3_arg0.xpReward:setText("")
	Widget:addElement(f3_arg0.xpReward)
	f3_arg0.challengeImageContainer = LUI.UIElement.new()
	f3_arg0.challengeImageContainer:setLeftRight(true, true, 0, 0)
	f3_arg0.challengeImageContainer:setTopBottom(true, true, 0, 0)
	Widget:addElement(f3_arg0.challengeImageContainer)
	f3_arg0.challengeImage = LUI.UIImage.new()
	f3_arg0.challengeImage:setLeftRight(true, true, 0, 0)
	f3_arg0.challengeImage:setTopBottom(true, true, 0, 0)
	f3_arg0.challengeImage:setAlpha(0)
	f3_arg0.challengeImageContainer:addElement(f3_arg0.challengeImage)
	local f3_local13 = CoD.CACUtility.ButtonGridLockImageSize
	f3_arg0.lockImage = LUI.UIImage.new()
	f3_arg0.lockImage:setLeftRight(false, false, -f3_local13 / 2, f3_local13 / 2)
	f3_arg0.lockImage:setTopBottom(false, false, -f3_local13 / 2, f3_local13 / 2)
	f3_arg0.lockImage:setAlpha(0)
	f3_arg0.lockImage:setImage(RegisterMaterial(CoD.CACUtility.LockImageMaterial))
	f3_arg0.challengeImageContainer:addElement(f3_arg0.lockImage)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.1, nil, nil, true, "menu_sp_cac_single_big_dip"))
end

CoD.WeaponMasteryChallenges.AddMasteryChallengeButtons = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	f4_arg0.weaponItemIndex = f4_arg2
	local f4_local0 = UIExpression.GetItemName(nil, f4_arg2)
	local f4_local1 = nil
	local f4_local2 = Engine.GetMasteryChallengesList(f4_arg1, f4_arg2)
	local f4_local3 = 1
	for f4_local13, f4_local14 in pairs(f4_local2.MasteryChallenges) do
		local f4_local15 = f4_local14.challengeRow
		local f4_local16 = f4_local14.tableNum
		local f4_local10 = ""
		local f4_local11 = ""
		local f4_local12 = -1
		if f4_local15 ~= nil then
			local f4_local7 = "mp/statsmilestones" .. f4_local16 + 1 .. ".csv"
			local f4_local8 = UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local7, f4_local15, 2)
			local f4_local9 = CoD.GetLocalizedTierText(f4_arg1, f4_local7, f4_local15)
			f4_local10 = Engine.Localize(UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local7, f4_local15, 5), "", f4_local0, f4_local9)
			f4_local11 = Engine.Localize(UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local7, f4_local15, 5) .. "_DESC", "", f4_local0, f4_local9)
			f4_local12 = UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local7, f4_local15, 6)
		end
		local f4_local7 = CoD.ChallengeGridButton.new(f4_arg1, f4_local3, f4_local10, f4_local14.imageID, f4_local14.isEmblem)
		f4_local7.challengeName = f4_local10
		f4_local7.challengeDesc = f4_local11
		f4_local7.imageID = f4_local14.imageID
		f4_local7.isEmblem = f4_local14.isEmblem
		f4_local7.isLocked = f4_local14.isLocked
		f4_local7.xpReward = f4_local12
		f4_local7.actionSFX = nil
		if f4_local7.isLocked then
			f4_local7:setLocked(true)
		end
		f4_arg0.contentGrid:addButton(f4_local7)
		if not f4_local1 then
			f4_local1 = f4_local7
		end
		f4_local3 = f4_local3 + 1
	end
	f4_local1:processEvent({
		name = "gain_focus",
		controller = f4_arg1
	})
end

CoD.WeaponMasteryChallenges.UpdateChallengeImagePreview = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1.imageID
	local f5_local1 = f5_arg1.xpReward
	local f5_local2 = f5_arg1.isEmblem
	local f5_local3 = f5_arg1.isLocked
	f5_arg0.imagePreviewTitle:setText(Engine.Localize("MPUI_REWARDS"))
	f5_arg0.xpReward:setText(Engine.Localize("RANK_XP", f5_local1))
	local f5_local4 = 75
	local f5_local5 = 75
	local f5_local6 = 10
	if f5_local2 then
		f5_arg0.challengeImage:setupDrawEmblemById(f5_local0)
	else
		f5_arg0.challengeImage:setupDrawBackgroundById(f5_local0)
		f5_local4 = 280
		f5_local5 = 70
	end
	if f5_local3 then
		f5_arg0.lockImage:setAlpha(1)
	else
		f5_arg0.lockImage:setAlpha(0)
	end
	f5_arg0.challengeImageContainer:setLeftRight(false, false, -f5_local4 / 2, f5_local4 / 2)
	f5_arg0.challengeImageContainer:setTopBottom(true, false, f5_local6, f5_local6 + f5_local5)
	f5_arg0.challengeImage:beginAnimation("show")
	f5_arg0.challengeImage:setAlpha(1)
end

CoD.WeaponMasteryChallenges.ButtonHighlighted = function (f6_arg0, f6_arg1)
	if f6_arg1.contentIndex then
		f6_arg0.challengeTitle:setText(f6_arg1.button.challengeName)
		f6_arg0.challengeDescription:setText(f6_arg1.button.challengeDesc)
		CoD.WeaponMasteryChallenges.UpdateChallengeImagePreview(f6_arg0, f6_arg1.button)
	else
		f6_arg0.challengeTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f6_arg0.challengeDescription:setText("")
	end
end

