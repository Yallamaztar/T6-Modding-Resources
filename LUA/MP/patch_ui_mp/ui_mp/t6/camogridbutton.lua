CoD.CamoGridButton = {}
CoD.CamoGridButton.new = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.ContentGridButton.new(f1_arg1)
	f1_local0.weaponItemIndex = f1_arg0
	f1_local0.weaponOption = UIExpression.GetWeaponOptionGroupIndex(nil, f1_arg1, CoD.CACUtility.WEAPONOPTION_GROUP_CAMO)
	f1_local0.camoNum = f1_arg1
	f1_local0.itemIsOld = true
	CoD.ContentGridButton.SetupButtonText(f1_local0, Engine.Localize(UIExpression.GetWeaponOptionName(nil, f1_local0.weaponOption)))
	CoD.CamoGridButton.SetupButtonImages(f1_local0, f1_local0.weaponOption)
	f1_local0:registerEventHandler("update_class", CoD.CamoGridButton.UpdateClass)
	f1_local0.gainFocusSFX = "cac_grid_nav"
	f1_local0.actionSFX = "cac_grid_equip_item"
	return f1_local0
end

CoD.CamoGridButton.SetupButtonImages = function (f2_arg0, f2_arg1)
	local f2_local0 = 2
	local f2_local1 = CoD.ContentGridButton.TitleHeight + 4
	local f2_local2 = UIExpression.GetWeaponOptionImage(nil, f2_arg1)
	f2_arg0.camoImageName = f2_local2
	f2_arg0:setImage(f2_local2, 0, 0)
	f2_arg0.itemImage:setLeftRight(true, true, 8, -8)
	f2_arg0.itemImage:setTopBottom(true, true, 8, -f2_local1 - 7)
	f2_arg0.itemImage:setPriority(-70)
	if f2_arg1 == 0 then
		local f2_local3 = CoD.CACCamo.CamoGridItemHeight - f2_local1 - 7 - 8
		f2_arg0.itemImage:setLeftRight(false, false, -f2_local3 / 2, f2_local3 / 2)
	end
	CoD.ContentGridButton.SetupButtonImages(f2_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
end

CoD.CamoGridButton.HandleDoubleXpGroups = function (f3_arg0)
	if f3_arg0.doubleXpGroups and f3_arg0.doubleXpGroups ~= "" and string.find(f3_arg0.doubleXpGroups, "elite1") and Engine.IsEliteAvailable() then
		f3_arg0.overrideLock = true
		f3_arg0.customEvent = "locked_elite_camo_selected"
	end
end

CoD.CamoGridButton.UpdateClass = function (f4_arg0, f4_arg1)
	f4_arg0.selectedFill:setAlpha(0)
	f4_arg0.glowGradFront:setRGB(CoD.GrenadeGridButton.glowFrontColor.r, CoD.GrenadeGridButton.glowFrontColor.g, CoD.RewardGridButton.glowFrontColor.b)
	f4_arg0.glowGradFront:setAlpha(0.05)
	f4_arg0.currentlyEquipped = false
	if f4_arg0.contentIndex == f4_arg1.contentIndex or f4_arg0.contentIndex == 0 and f4_arg1.contentIndex == nil then
		f4_arg0.selectedFill:setAlpha(0.2)
		f4_arg0.glowGradFront:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		f4_arg0.glowGradFront:setAlpha(0.2)
		f4_arg0.currentlyEquipped = true
	end
	f4_arg0.showProgressBar = false
	if Engine.IsWeaponOptionNew(f4_arg1.controller, f4_arg0.weaponItemIndex, f4_arg0.weaponOption) then
		f4_arg0:setNew(true, f4_arg1.controller)
	else
		f4_arg0:setNew(false, f4_arg1.controller)
	end
	local f4_local0, f4_local1 = Engine.GetChallengeForItemOption(f4_arg0.weaponItemIndex, f4_arg0.weaponOption)
	local f4_local2 = CoD.CACUtility.IsWeaponOptionMTX(f4_arg0.weaponOption)
	if not f4_local2 and f4_local0 ~= nil then
		local f4_local3 = "mp/statsmilestones" .. f4_local1 + 1 .. ".csv"
		local f4_local4 = UIExpression.GetItemName(nil, f4_arg0.weaponItemIndex)
		f4_arg0.challengeValue = Engine.GetItemOptionChallengeValue(f4_arg1.controller, f4_arg0.weaponItemIndex, f4_arg0.weaponOption)
		local f4_local5 = UIExpression.TableLookupGetColumnValueForRow(f4_arg1.controller, f4_local3, f4_local0, 5)
		local f4_local6 = tonumber(UIExpression.TableLookupGetColumnValueForRow(f4_arg1.controller, f4_local3, f4_local0, 7))
		f4_arg0.maxVal = tonumber(UIExpression.TableLookupGetColumnValueForRow(f4_arg1.controller, f4_local3, f4_local0, 2))
		f4_arg0.rewardXP = UIExpression.TableLookupGetColumnValueForRow(f4_arg1.controller, f4_local3, f4_local0, 6)
		f4_arg0.statsname = UIExpression.TableLookupGetColumnValueForRow(f4_arg1.controller, f4_local3, f4_local0, 4)
		f4_arg0.doubleXpGroups = UIExpression.TableLookupGetColumnValueForRow(f4_arg1.controller, f4_local3, f4_local0, 22)
		f4_arg0.statType = UIExpression.TableLookupGetColumnValueForRow(f4_arg1.controller, f4_local3, f4_local0, 3)
		if f4_arg0.rewardXP == "" then
			f4_arg0.rewardXP = nil
		end
		local f4_local7 = CoD.GetLocalizedTierText(f4_arg1.controller, f4_local3, f4_local0)
		local f4_local8, f4_local9 = nil
		if f4_local6 ~= nil and f4_local6 > 0 then
			local f4_local10 = tonumber(UIExpression.TableLookup(f4_arg1.controller, f4_local3, 0, f4_local6, 2))
			local f4_local11 = Engine.GetPreReqChallengeValue(f4_arg1.controller, f4_arg0.weaponItemIndex, f4_local6)
			if f4_local11 ~= nil and f4_local11 < f4_local10 then
				f4_local8 = Engine.Localize("MPUI_CAMO_PREREQ", "", Engine.Localize(UIExpression.TableLookup(nil, CoD.attachmentTable, 4, UIExpression.TableLookup(f4_arg1.controller, f4_local3, 0, f4_local6, 9), 3)), f4_local7)
			end
		end
		if f4_arg0.statsname == "challenges" then
			if f4_arg0.statType and f4_arg0.statType == "group" then
				f4_local9 = Engine.Localize("CHALLENGE_MASTERY_EXPERT_GROUP_DESC", "", Engine.Localize("MPUI_" .. UIExpression.GetItemGroup(nil, f4_arg0.weaponItemIndex) .. "_WITH_S"), f4_local7)
			else
				f4_local9 = Engine.Localize("CHALLENGE_MASTERY_EXPERT_DESC", "", f4_local4, f4_local7)
			end
		end
		if f4_arg0.statsname ~= "digital_unlock" and (Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) or Engine.SessionModeIsMode(CoD.SESSIONMODE_SYSTEMLINK)) then
			f4_arg0:setHintText("")
			f4_arg0.showProgressBar = false
			return 
		end
		local f4_local10 = nil
		if f4_local8 ~= nil then
			f4_arg0:setHintText(f4_local8)
			f4_arg0:setLocked(true)
			f4_local10 = true
			f4_arg0.showProgressBar = false
		else
			local f4_local11 = Engine.GetItemOptionLocked(f4_arg1.controller, f4_arg0.weaponItemIndex, f4_arg0.weaponOption)
			if f4_arg0.challengeValue ~= nil and f4_arg0.maxVal <= f4_arg0.challengeValue and not f4_local11 then
				f4_arg0:setHintText(Engine.Localize("MPUI_CAMO_UNLOCKED"))
			elseif f4_arg0.challengeValue then
				f4_arg0:setLocked(true)
				f4_local10 = true
				f4_arg0.showProgressBar = true
			elseif f4_local11 then
				f4_arg0:setLocked(true)
				f4_local10 = true
			end
			if f4_local9 ~= nil then
				f4_arg0:setHintText(f4_local9)
				f4_arg0.showProgressBar = false
			else
				f4_arg0:setHintText(Engine.Localize(f4_local5 .. "_DESC", f4_arg0.maxVal, f4_local4, ""))
			end
		end
		if not f4_arg1.challengeMenu and f4_local10 and CoD.IsLeagueOrCustomMatch() and f4_arg0.statsname ~= "digital_unlock" then
			f4_arg0:setHintText(Engine.Localize("MENU_CAMO_LOCKED_NON_PUBLIC"))
			f4_arg0.showProgressBar = false
		end
		CoD.CamoGridButton.HandleDoubleXpGroups(f4_arg0)
	elseif f4_local2 then
		local f4_local3 = CoD.CACUtility.GetWeaponOptionMTXName(f4_arg0.weaponOption)
		local f4_local4 = Engine.HasMTX(f4_arg1.controller, f4_local3)
		CoD.ContentGridButton.SetMTXPurchased(f4_arg0, f4_local4, f4_arg1.controller)
		f4_arg0:setHintText(Engine.Localize("MPUI_MTX_PURCHASE_HINT", Engine.Localize("MPUI_" .. f4_local3)))
		if f4_local4 then
			f4_arg0:setActionPromptString(Engine.Localize("MENU_SELECT"))
		else
			f4_arg0:setActionPromptString(Engine.Localize("MENU_PURCHASE"))
		end
	end
end

