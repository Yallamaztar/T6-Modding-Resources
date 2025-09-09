require("T6.ChallengeReticlesGridButton")
CoD.OpticChallengeType = {}
CoD.OpticChallengeType.reticlePreviewLineMaterialName = "menu_mp_cac_attach_line"
CoD.OpticChallengeType.GridTop = 60
CoD.OpticChallengeType.GridItemSpacing = 8
CoD.OpticChallengeType.GridColumns = 5
CoD.OpticChallengeType.GridItemWidth = (CoD.Menu.Width - CoD.OpticChallengeType.GridItemSpacing * (CoD.OpticChallengeType.GridColumns - 1)) / CoD.OpticChallengeType.GridColumns
CoD.OpticChallengeType.GridItemHeight = 50 + CoD.ContentGridButton.TitleHeight + 20
LUI.createMenu.OpticChallengeType = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("OpticChallengeType")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("content_button_highlighted", CoD.OpticChallengeType.ContentButtonHighlighted)
	local f1_local1 = CoD.perController[f1_arg0].OpticChallengeTypeData
	local f1_local2 = f1_local1.attachmentIndex
	local f1_local3 = f1_local1.attachmentRef
	f1_local0.attachmentIndex = f1_local2
	f1_local0.attachmentRef = f1_local3
	local f1_local4 = UIExpression.GetAttachmentName(nil, f1_local2)
	f1_local0.attachmentName = f1_local4
	f1_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_CHALLENGES_WEAPON_CHALLENGE_TYPE", f1_local4)))
	f1_local0.dualOpticReticle = f1_local0.attachmentRef == "dualoptic"
	local f1_local5 = 1
	if f1_local0.dualOpticReticle then
		f1_local5 = 2
	end
	f1_local0.numPreviewImages = f1_local5
	local f1_local6 = CoD.Menu.TitleHeight + 25
	f1_local0.contentGrid = CoD.ContentGrid.new(CoD.OpticChallengeType.GridColumns, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local6,
		bottom = 0
	}, CoD.OpticChallengeType.GridItemWidth, CoD.OpticChallengeType.GridItemHeight, CoD.OpticChallengeType.GridItemSpacing)
	f1_local0:addElement(f1_local0.contentGrid)
	local f1_local7 = 4
	f1_local6 = -40 + f1_local6 + CoD.OpticChallengeType.GridItemHeight * f1_local7 + CoD.OpticChallengeType.GridItemSpacing * (f1_local7 - 1) + 3 + CoD.HintText.Height + 5
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f1_local6, 0)
	f1_local0:addElement(Widget)
	local f1_local9 = 0
	local f1_local10 = CoD.Menu.Width * 0.33
	f1_local0.progressBar = CoD.ChallengeProgressBar.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f1_local10,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local9 + 105,
		bottom = 0
	}, f1_local10)
	Widget:addElement(f1_local0.progressBar)
	f1_local0.reticleTitle = LUI.UIText.new()
	f1_local0.reticleTitle:setLeftRight(true, false, 0, 1)
	f1_local0.reticleTitle:setTopBottom(true, false, f1_local9, f1_local9 + CoD.textSize.Big)
	f1_local0.reticleTitle:setFont(CoD.fonts.Big)
	f1_local0.reticleTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(f1_local0.reticleTitle)
	f1_local9 = f1_local9 + CoD.textSize.Big
	f1_local0.reticleDescription = LUI.UIText.new()
	f1_local0.reticleDescription:setLeftRight(true, false, 0, CoD.Menu.Width / 2 - 100)
	f1_local0.reticleDescription:setTopBottom(true, false, f1_local9, f1_local9 + CoD.textSize.Default)
	f1_local0.reticleDescription:setAlignment(LUI.Alignment.Left)
	f1_local0.reticleDescription:setFont(CoD.fonts.Default)
	f1_local0.reticleDescription:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.reticleDescription:setAlpha(0.4)
	Widget:addElement(f1_local0.reticleDescription)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -(CoD.Menu.Width / 2) + 10, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(Widget)
	local f1_local12 = 128
	local f1_local13 = f1_local12
	local f1_local14 = -100
	local f1_local15 = -120
	f1_local0.weaponImage = LUI.UIImage.new()
	f1_local0.weaponImage:setLeftRight(false, true, -f1_local12 + f1_local15, f1_local15)
	f1_local0.weaponImage:setTopBottom(true, false, f1_local14, f1_local14 + f1_local13)
	Widget:addElement(f1_local0.weaponImage)
	f1_local0.weaponImage:setImage(RegisterMaterial(UIExpression.GetAttachmentImage(nil, f1_local2)))
	local f1_local16 = 90
	local f1_local17 = 6
	local f1_local18 = -CoD.ButtonPrompt.Height - 22
	local f1_local19 = 120
	local f1_local20 = 300
	
	local reticlePreviewBackground = LUI.UIElement.new()
	reticlePreviewBackground:setLeftRight(true, false, f1_local17, f1_local17 + f1_local20)
	reticlePreviewBackground:setTopBottom(false, true, f1_local18 - f1_local19, f1_local18)
	Widget:addElement(reticlePreviewBackground)
	f1_local0.reticlePreviewBackground = reticlePreviewBackground
	
	local f1_local22 = "Default"
	local f1_local23 = CoD.fonts[f1_local22]
	local f1_local24 = CoD.textSize[f1_local22]
	f1_local0.reticlePreviewTitle = LUI.UIText.new()
	f1_local0.reticlePreviewTitle:setLeftRight(true, false, 0, 1)
	f1_local0.reticlePreviewTitle:setTopBottom(true, false, -f1_local24, 0)
	f1_local0.reticlePreviewTitle:setRGB(CoD.gray.r, CoD.gray.g, CoD.gray.b)
	f1_local0.reticlePreviewTitle:setFont(reticleTitleFont)
	f1_local0.reticlePreviewTitle:setAlignment(LUI.Alignment.Left)
	f1_local0.reticlePreviewTitle:setText(Engine.Localize("MPUI_REWARDS"))
	reticlePreviewBackground:addElement(f1_local0.reticlePreviewTitle)
	local f1_local25 = 48
	local f1_local26 = 22
	local f1_local27 = 25
	f1_local0.reticleImage = LUI.UIImage.new()
	f1_local0.reticleImage:setLeftRight(false, false, -f1_local25 / 2, f1_local25 / 2)
	f1_local0.reticleImage:setTopBottom(true, false, f1_local27, f1_local27 + f1_local25)
	f1_local0.reticleImage:hide()
	reticlePreviewBackground:addElement(f1_local0.reticleImage)
	local f1_local28 = 70
	local f1_local29 = f1_local28 * 4
	local f1_local30 = 10
	f1_local0.reticleUnlockImage = LUI.UIImage.new()
	f1_local0.reticleUnlockImage:setLeftRight(false, false, -f1_local29 / 2, f1_local29 / 2)
	f1_local0.reticleUnlockImage:setTopBottom(true, false, f1_local30, f1_local30 + f1_local28)
	reticlePreviewBackground:addElement(f1_local0.reticleUnlockImage)
	local f1_local31 = 20
	f1_local0.reticleImage1 = LUI.UIImage.new()
	f1_local0.reticleImage1:setLeftRight(false, false, -f1_local31 / 2 - f1_local25, -f1_local31 / 2)
	f1_local0.reticleImage1:setTopBottom(true, false, f1_local27, f1_local27 + f1_local25)
	f1_local0.reticleImage1:hide()
	reticlePreviewBackground:addElement(f1_local0.reticleImage1)
	f1_local0.reticleImage2 = LUI.UIImage.new()
	f1_local0.reticleImage2:setLeftRight(false, false, f1_local31 / 2, f1_local31 / 2 + f1_local25)
	f1_local0.reticleImage2:setTopBottom(true, false, f1_local27, f1_local27 + f1_local25)
	f1_local0.reticleImage2:hide()
	reticlePreviewBackground:addElement(f1_local0.reticleImage2)
	local f1_local32 = "Default"
	local f1_local33 = CoD.textSize[f1_local32]
	local f1_local34 = CoD.fonts[f1_local32]
	f1_local0.reticleXPReward = LUI.UIText.new()
	f1_local0.reticleXPReward:setFont(f1_local34)
	f1_local0.reticleXPReward:setLeftRight(true, true, 0, 0)
	f1_local0.reticleXPReward:setTopBottom(false, true, -f1_local33 - 10, -10)
	f1_local0.reticleXPReward:setAlignment(LUI.Alignment.Center)
	f1_local0.reticleXPReward:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
	reticlePreviewBackground:addElement(f1_local0.reticleXPReward)
	local f1_local35 = 32
	local f1_local36 = 5
	local f1_local37 = 5
	f1_local0.lockImage = LUI.UIImage.new()
	f1_local0.lockImage:setLeftRight(true, false, f1_local37, f1_local37 + f1_local35)
	f1_local0.lockImage:setTopBottom(false, true, -f1_local36 - f1_local35, -f1_local36)
	f1_local0.lockImage:setImage(RegisterMaterial(CoD.CACUtility.LockImageMaterial))
	f1_local0.lockImage:hide()
	reticlePreviewBackground:addElement(f1_local0.lockImage)
	reticlePreviewBackground.borderDip = CoD.BorderDip.new(1, 1, 1, 1, 0.05, nil, f1_local20, 1)
	reticlePreviewBackground:addElement(reticlePreviewBackground.borderDip)
	CoD.OpticChallengeType.AddReticles(f1_local0, f1_arg0)
	return f1_local0
end

CoD.OpticChallengeType.AddReticles = function (f2_arg0, f2_arg1)
	local f2_local0 = Engine.GetNumWeaponOptions(CoD.CACUtility.WEAPONOPTION_GROUP_RETICLE)
	local f2_local1 = nil
	for f2_local2 = 0, f2_local0 - 1, 1 do
		local f2_local5 = UIExpression.GetWeaponOptionGroupIndex(nil, f2_local2, CoD.CACUtility.WEAPONOPTION_GROUP_RETICLE)
		local f2_local6 = CoD.CACUtility.IsWeaponOptionMTX(f2_local5)
		if not f2_local6 and tonumber(UIExpression.TableLookup(nil, CoD.attachmentTable, 1, "reticle", 0, f2_local5, 9)) == 2 then
			f2_local6 = true
		end
		if not f2_local6 then
			local f2_local7 = CoD.ChallengeReticlesGridButton.new(f2_arg1, f2_local2, f2_arg0.attachmentRef, f2_arg0.attachmentIndex)
			f2_local7.actionSFX = nil
			f2_local7.attachmentIndex = f2_arg0.attachmentIndex
			f2_arg0.contentGrid:addButton(f2_local7)
			if not f2_local1 then
				f2_local1 = f2_local7
			end
		end
	end
	CoD.OpticChallengeType.AddImageUnlocks(f2_arg0, f2_arg1, f2_local0 + 1)
	f2_local1:processEvent({
		name = "gain_focus",
		controller = f2_arg1
	})
end

CoD.OpticChallengeType.ChangeReticlePreview = function (f3_arg0, f3_arg1)

end

CoD.OpticChallengeType.AddImageUnlocks = function (f4_arg0, f4_arg1, f4_arg2)
	for f4_local12, f4_local13 in ipairs(Engine.GetChallengeInfoForImages(f4_arg1, f4_arg0.attachmentRef)) do
		local f4_local14 = f4_local13.challengeRow
		local f4_local15 = f4_local13.tableNum
		local f4_local5 = ""
		local f4_local6 = ""
		local f4_local3 = nil
		local f4_local4 = -1
		local f4_local7 = -1
		if f4_local14 ~= nil then
			f4_local3 = "mp/statsmilestones" .. f4_local15 + 1 .. ".csv"
			f4_local4 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local3, f4_local14, 2))
			f4_local5 = Engine.Localize(UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local3, f4_local14, 5), "", f4_arg0.attachmentName, "")
			f4_local6 = Engine.Localize(UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local3, f4_local14, 5) .. "_DESC", f4_local4, f4_arg0.attachmentName)
			f4_local7 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f4_arg1, f4_local3, f4_local14, 6))
			local f4_local8 = CoD.ChallengeGridButton.new(f4_arg1, f4_arg2, f4_local5, f4_local13.imageID, f4_local13.isEmblem)
			f4_local8.maxVal = f4_local4
			f4_local8.xpReward = f4_local7
			f4_local8.statsname = UIExpression.TableLookupGetColumnValueForRow(nil, f4_local3, f4_local14, 4)
			f4_local8.hintText = f4_local6
			f4_local8.challengeValue = f4_local13.currChallengeStatValue
			f4_local8.isEmblem = f4_local13.isEmblem
			f4_local8.imageID = f4_local13.imageID
			f4_local8.actionSFX = nil
			local f4_local9 = 16
			local f4_local10 = 38
			local f4_local11 = f4_local10 * 4
			f4_local8.itemImage:setTopBottom(true, false, f4_local9, f4_local9 + f4_local10)
			f4_local8.itemImage:setLeftRight(false, false, -f4_local11 / 2, f4_local11 / 2)
			if f4_local8.challengeValue < f4_local4 then
				f4_local8:setLocked(true)
			end
			if f4_local8.statsname == "challenges" then
				f4_local8.showProgressBar = false
			end
			f4_arg0.contentGrid:addButton(f4_local8)
		end
	end
end

CoD.OpticChallengeType.UpdateReticlePreview = function (f5_arg0, f5_arg1, f5_arg2)
	f5_arg0.reticleImage:hide()
	f5_arg0.reticleImage1:hide()
	f5_arg0.reticleImage2:hide()
	f5_arg0.reticleUnlockImage:hide()
	f5_arg0.lockImage:hide()
	f5_arg0.reticleXPReward:setText("")
	local f5_local0 = ""
	local f5_local1, f5_local2, f5_local3 = nil
	CoD.OpticChallengeType.ChangeReticlePreview(f5_arg0, f5_arg1.imageID ~= nil)
	if f5_arg1.dualOpticReticle then
		f5_local2 = f5_arg1.image1MaterialName
		f5_local3 = f5_arg1.image2MaterialName
	else
		f5_local1 = f5_arg1.reticleImageName
	end
	if f5_arg1.lockImage then
		if f5_arg1.xpReward then
			f5_local0 = Engine.Localize("RANK_XP", f5_arg1.xpReward)
		end
		f5_arg0.lockImage:show()
	end
	if f5_arg1.dualOpticReticle and f5_local2 then
		f5_arg0.reticleImage1:show()
		f5_arg0.reticleImage1:setImage(RegisterMaterial(f5_local2))
		f5_arg0.reticleImage2:show()
		f5_arg0.reticleImage2:setImage(RegisterMaterial(f5_local3))
	elseif f5_local1 then
		f5_arg0.reticleImage:show()
		f5_arg0.reticleImage:setImage(RegisterMaterial(f5_local1))
	elseif f5_arg1.imageID then
		f5_arg0.reticleUnlockImage:show()
		if f5_arg1.isEmblem then
			f5_arg0.reticleUnlockImage:setupDrawEmblemById(f5_arg1.imageID)
		else
			f5_arg0.reticleUnlockImage:setupDrawBackgroundById(f5_arg1.imageID)
		end
	end
	f5_arg0.reticleXPReward:setText(f5_local0)
end

CoD.OpticChallengeType.ContentButtonHighlighted = function (f6_arg0, f6_arg1)
	if f6_arg1.contentIndex then
		local f6_local0 = f6_arg1.button
		f6_arg0.reticleTitle:setText(f6_local0.nameText)
		if f6_arg1.hintText ~= nil then
			f6_arg0.reticleDescription:setText(f6_arg1.hintText)
		else
			f6_arg0.reticleDescription:setText("")
		end
		f6_arg0.progressBar:hide()
		if f6_local0.showProgressBar then
			f6_arg0.progressBar:show()
			f6_arg0.progressBar:update(f6_local0.challengeValue, f6_local0.maxVal)
		end
		CoD.OpticChallengeType.UpdateReticlePreview(f6_arg0, f6_local0, f6_arg1.controller)
	else
		f6_arg0.reticleTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f6_arg0.reticleDescription:setText("")
	end
end

