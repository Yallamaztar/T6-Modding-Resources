require("T6.CamoGridButton")
require("T6.Menus.ChallengeProgressBar")
CoD.WeaponCamoChallenges = {}
CoD.WeaponCamoChallenges.GridTop = 60
CoD.WeaponCamoChallenges.GridColumns = 6
CoD.WeaponCamoChallenges.GridItemSpacing = 8
CoD.WeaponCamoChallenges.GridItemWidth = (CoD.Menu.Width - CoD.WeaponCamoChallenges.GridItemSpacing * (CoD.WeaponCamoChallenges.GridColumns - 1)) / CoD.WeaponCamoChallenges.GridColumns
CoD.WeaponCamoChallenges.GridItemHeight = 50 + CoD.ContentGridButton.TitleHeight + 20
LUI.createMenu.WeaponCamoChallenges = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("WeaponCamoChallenges")
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:setPreviousMenu("WeaponChallengeType")
	local f1_local1 = CoD.perController[f1_arg0].weaponIndex
	local f1_local2 = CoD.perController[f1_arg0].weaponSlot
	f1_local0:addBackButton()
	f1_local0:registerEventHandler("content_button_highlighted", CoD.WeaponCamoChallenges.ContentButtonHighlighted)
	local f1_local3 = 0
	f1_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize(UIExpression.GetItemName(nil, f1_local1)) .. " " .. Engine.Localize("MPUI_CAMO_CAPS")))
	f1_local3 = f1_local3 + CoD.textSize.Big + 15
	f1_local0.contentGrid = CoD.ContentGrid.new(CoD.WeaponCamoChallenges.GridColumns, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local3,
		bottom = 0
	}, CoD.WeaponCamoChallenges.GridItemWidth, CoD.WeaponCamoChallenges.GridItemHeight, CoD.WeaponCamoChallenges.GridItemSpacing)
	f1_local0:addElement(f1_local0.contentGrid)
	local f1_local4 = 4
	f1_local3 = -30 + f1_local3 + CoD.WeaponCamoChallenges.GridItemHeight * f1_local4 + CoD.WeaponCamoChallenges.GridItemSpacing * (f1_local4 - 1) + 3 + CoD.HintText.Height + 5
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, f1_local3, 0)
	f1_local0:addElement(Widget)
	local f1_local6 = 0
	f1_local0.camoTitle = LUI.UIText.new()
	f1_local0.camoTitle:setLeftRight(true, false, 0, 1)
	f1_local0.camoTitle:setTopBottom(true, false, f1_local6, f1_local6 + CoD.textSize.Big)
	f1_local0.camoTitle:setFont(CoD.fonts.Big)
	f1_local0.camoTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(f1_local0.camoTitle)
	f1_local6 = f1_local6 + CoD.textSize.Big
	f1_local0.camoDescription = LUI.UIText.new()
	f1_local0.camoDescription:setLeftRight(true, false, 0, 0.4 * CoD.Menu.Width)
	f1_local0.camoDescription:setTopBottom(true, false, f1_local6, f1_local6 + CoD.textSize.Default)
	f1_local0.camoDescription:setAlignment(LUI.Alignment.Left)
	f1_local0.camoDescription:setFont(CoD.fonts.Default)
	f1_local0.camoDescription:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.camoDescription:setAlpha(0.4)
	Widget:addElement(f1_local0.camoDescription)
	f1_local6 = f1_local6 + CoD.textSize.Default * 2 + 10
	local f1_local7 = CoD.Menu.Width * 0.33
	f1_local0.progressBar = CoD.ChallengeProgressBar.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f1_local7,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local6,
		bottom = 0
	}, f1_local7)
	Widget:addElement(f1_local0.progressBar)
	f1_local0.weaponContainer = LUI.UIElement.new()
	f1_local0.weaponContainer:setLeftRight(false, true, -(CoD.Menu.Width / 2) + 10, 0)
	f1_local0.weaponContainer:setTopBottom(true, true, 0, 0)
	Widget:addElement(f1_local0.weaponContainer)
	local f1_local8 = 280
	local f1_local9 = -70
	local f1_local10 = f1_local8 / 2
	f1_local0.weaponImage = LUI.UIImage.new()
	f1_local0.weaponImage:setLeftRight(false, true, -f1_local8, 0)
	f1_local0.weaponImage:setTopBottom(true, false, f1_local9, f1_local9 + f1_local10)
	f1_local0.weaponContainer:addElement(f1_local0.weaponImage)
	CoD.WeaponCamoChallenges.AddCamoReward(f1_local0, f1_local0.weaponContainer)
	CoD.WeaponCamoChallenges.AddCamos(f1_local0, f1_arg0, f1_local1, f1_local2)
	return f1_local0
end

CoD.WeaponCamoChallenges.AddCamoReward = function (f2_arg0, f2_arg1)
	local f2_local0 = 100
	local f2_local1 = -80
	local f2_local2 = -CoD.ButtonPrompt.Height - 22
	local f2_local3 = f2_local0 + 30
	local f2_local4 = f2_local0 * 2 + 20
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f2_local1, f2_local1 + f2_local4)
	Widget:setTopBottom(false, true, f2_local2 - f2_local3, f2_local2)
	f2_arg1:addElement(Widget)
	local f2_local6 = "Default"
	local f2_local7 = CoD.fonts[f2_local6]
	local f2_local8 = CoD.textSize[f2_local6]
	f2_arg0.camoPreviewTitle = LUI.UIText.new()
	f2_arg0.camoPreviewTitle:setLeftRight(true, false, 0, 1)
	f2_arg0.camoPreviewTitle:setTopBottom(true, false, -f2_local8, 0)
	f2_arg0.camoPreviewTitle:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f2_arg0.camoPreviewTitle:setFont(camoTitleFont)
	f2_arg0.camoPreviewTitle:setAlignment(LUI.Alignment.Left)
	f2_arg0.camoPreviewTitle:setText("")
	Widget:addElement(f2_arg0.camoPreviewTitle)
	local f2_local9 = 20
	local f2_local10 = 70
	f2_arg0.camoImage = LUI.UIImage.new()
	f2_arg0.camoImage:setLeftRight(true, true, f2_local9, -f2_local9)
	f2_arg0.camoImage:setTopBottom(true, false, 12, 12 + f2_local10)
	f2_arg0.camoImage:setAlpha(0)
	Widget:addElement(f2_arg0.camoImage)
	local f2_local11 = "Default"
	local f2_local12 = CoD.textSize[f2_local11]
	local f2_local13 = CoD.fonts[f2_local11]
	f2_arg0.xpRewardText = LUI.UIText.new()
	f2_arg0.xpRewardText:setLeftRight(true, true, 0, 0)
	f2_arg0.xpRewardText:setTopBottom(false, true, -10 - f2_local12, -10)
	f2_arg0.xpRewardText:setAlignment(LUI.Alignment.Center)
	f2_arg0.xpRewardText:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
	Widget:addElement(f2_arg0.xpRewardText)
	local f2_local14 = 32
	f2_arg0.lockImage = LUI.UIImage.new()
	f2_arg0.lockImage:setLeftRight(true, false, 5, 5 + f2_local14)
	f2_arg0.lockImage:setTopBottom(false, true, -10 - f2_local14, -10)
	f2_arg0.lockImage:setImage(RegisterMaterial(CoD.CACUtility.LockImageMaterial))
	f2_arg0.lockImage:hide()
	Widget:addElement(f2_arg0.lockImage)
	Widget:addElement(CoD.BorderDip.new(1, 1, 1, 1, 0.05, nil, f2_local4, 1))
	f2_arg1:addElement(Widget)
end

CoD.WeaponCamoChallenges.UpdateCamoPreview = function (f3_arg0, f3_arg1, f3_arg2)
	f3_arg0.lockImage:hide()
	f3_arg0.camoImage:hide()
	f3_arg0.camoPreviewTitle:setText("")
	f3_arg0.xpRewardText:setText("")
	local f3_local0 = 20
	f3_arg0.camoImage:setLeftRight(true, true, f3_local0, -f3_local0)
	if f3_arg1.lockImage then
		f3_arg0.camoPreviewTitle:setText(Engine.Localize("MPUI_REWARDS"))
		f3_arg0.lockImage:show()
		if f3_arg1.rewardXP then
			f3_arg0.xpRewardText:setText(Engine.Localize("RANK_XP", f3_arg1.rewardXP))
		end
	end
	f3_arg0.camoImage:show()
	f3_arg0.camoImage:setImage(RegisterMaterial(f3_arg1.camoImageName))
end

CoD.WeaponCamoChallenges.IsCamoHidden = function (f4_arg0)
	if string.find(UIExpression.TableLookup(nil, CoD.attachmentTable, 1, "camo", 0, f4_arg0, 4), "elite") and not Engine.IsEliteAvailable() then
		return true
	else
		local f4_local0 = tonumber(UIExpression.TableLookup(nil, CoD.attachmentTable, 1, "camo", 0, f4_arg0, 9))
		if not f4_local0 then
			return false
		else
			return f4_local0 > 1
		end
	end
end

CoD.WeaponCamoChallenges.AddCamos = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	local f5_local0 = f5_arg2
	f5_arg0.weaponItemIndex = f5_local0
	f5_arg0.weaponImage:registerAnimationState("weapon_image", {
		material = RegisterMaterial(UIExpression.GetItemImage(nil, f5_local0) .. "_big")
	})
	f5_arg0.weaponImage:animateToState("weapon_image")
	local f5_local1 = Engine.GetNumWeaponOptions(CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
	local f5_local2 = nil
	for f5_local3 = 1, f5_local1 - 1, 1 do
		local f5_local6 = UIExpression.GetWeaponOptionGroupIndex(nil, f5_local3, CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
		if not CoD.CACUtility.IsWeaponOptionMTX(f5_local6) then
			local f5_local7 = false
			local f5_local8 = CoD.WeaponCamoChallenges.IsCamoHidden(f5_local6)
			local f5_local9, f5_local10 = Engine.GetChallengeForItemOption(f5_local0, f5_local6)
			if f5_local9 ~= nil then
				local f5_local11 = "mp/statsmilestones" .. f5_local10 + 1 .. ".csv"
				local f5_local12 = UIExpression.GetItemName(nil, f5_local0)
				local f5_local13 = Engine.GetItemOptionChallengeValue(f5_arg1, f5_local0, f5_local6)
				local f5_local14 = UIExpression.TableLookupGetColumnValueForRow(f5_arg1, f5_local11, f5_local9, 2)
				local f5_local15 = UIExpression.TableLookupGetColumnValueForRow(f5_arg1, f5_local11, f5_local9, 4)
				f5_local7 = true
				if not (not f5_local8 or f5_local13 and f5_local13 >= tonumber(f5_local14)) or f5_local15 == "digital_unlock" then
					f5_local7 = false
				end
			end
			if f5_local7 or f5_local3 == 0 then
				local f5_local11 = CoD.CamoGridButton.new(f5_local0, f5_local3)
				f5_local11.actionSFX = nil
				f5_arg0.contentGrid:addButton(f5_local11)
				if not f5_local2 then
					f5_local2 = f5_local11
				end
			end
		end
	end
	f5_arg0:dispatchEventToChildren({
		name = "update_class",
		controller = f5_arg1,
		challengeMenu = true
	})
	f5_local2:processEvent({
		name = "gain_focus",
		controller = f5_arg1
	})
end

CoD.WeaponCamoChallenges.ContentButtonHighlighted = function (f6_arg0, f6_arg1)
	if f6_arg1.contentIndex then
		f6_arg0.camoTitle:setText(f6_arg1.button.nameText)
		if f6_arg1.hintText ~= nil then
			f6_arg0.camoDescription:setText(f6_arg1.hintText)
		else
			f6_arg0.camoDescription:setText("")
		end
		f6_arg0.progressBar:hide()
		if f6_arg1.button.showProgressBar and f6_arg1.button.challengeValue and f6_arg1.button.maxVal then
			f6_arg0.progressBar:show()
			f6_arg0.progressBar:update(f6_arg1.button.challengeValue, f6_arg1.button.maxVal)
		end
		CoD.WeaponCamoChallenges.UpdateCamoPreview(f6_arg0, f6_arg1.button, f6_arg1.controller)
	else
		f6_arg0.camoTitle:setText(Engine.Localize("MPUI_NONE_CAPS"))
		f6_arg0.camoDescription:setText("")
	end
end

