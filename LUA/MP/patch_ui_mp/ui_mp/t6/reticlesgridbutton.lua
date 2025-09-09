CoD.ReticlesGridButton = {}
CoD.ReticlesGridButton.new = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = UIExpression.GetWeaponOptionGroupIndex(nil, f1_arg0, CoD.CACUtility.WEAPONOPTION_GROUP_RETICLE)
	local f1_local1 = CoD.ContentGridButton.new(f1_arg0)
	f1_local1.itemIsOld = true
	f1_local1.reticleIndex = f1_arg0
	f1_local1.weaponOption = f1_local0
	f1_local1.attachmentRef = f1_arg1
	f1_local1.dualOpticReticle = f1_arg1 == "dualoptic"
	f1_local1.eAttachment = f1_arg2
	CoD.ContentGridButton.SetupButtonText(f1_local1, Engine.Localize("MPUI_RETICLE_" .. f1_arg1 .. "_" .. f1_arg0))
	CoD.ReticlesGridButton.SetupButtonImages(f1_local1, f1_arg1, f1_arg0, f1_local1.dualOpticReticle)
	f1_local1:registerEventHandler("update_class", CoD.ReticlesGridButton.UpdateClass)
	f1_local1.gainFocusSFX = "cac_grid_nav"
	f1_local1.actionSFX = "cac_grid_equip_item"
	return f1_local1
end

CoD.ReticlesGridButton.SetupButtonImages = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	local f2_local0 = 32
	local f2_local1 = (CoD.CACCamo.CamoGridItemHeight - CoD.ContentGridButton.TitleHeight + 4) / 2 + 4
	local f2_local2 = f2_arg1 .. "_" .. f2_arg2
	f2_arg0.reticleImageName = f2_local2
	f2_arg0:setImage(f2_local2, 0, 0)
	f2_arg0.itemImage:setLeftRight(false, false, -f2_local0 / 2, f2_local0 / 2)
	f2_arg0.itemImage:setTopBottom(true, false, f2_local1 - f2_local0 / 2, f2_local1 + f2_local0 / 2)
	f2_arg0.itemImage:setPriority(-70)
	if f2_arg3 then
		f2_arg0.itemImage:hide()
		local f2_local3 = 20
		f2_arg0.image1MaterialName = "reflex_" .. f2_arg2
		f2_arg0.image2MaterialName = "acog_" .. f2_arg2
		if f2_arg2 == 0 then
			f2_arg0.image1MaterialName = "dualoptic_up_0"
			f2_arg0.image2MaterialName = "dualoptic_down_0"
		elseif f2_arg2 == 9 then
			f2_arg0.image1MaterialName = "dualoptic_up_9"
			f2_arg0.image2MaterialName = "dualoptic_down_9"
		end
		f2_arg0.itemImage1 = LUI.UIImage.new()
		f2_arg0.itemImage1:setLeftRight(false, false, -f2_local3 / 2 - f2_local0, -f2_local3 / 2)
		f2_arg0.itemImage1:setTopBottom(true, false, f2_local1 - f2_local0 / 2, f2_local1 + f2_local0 / 2)
		f2_arg0.itemImage1:setImage(RegisterMaterial(f2_arg0.image1MaterialName))
		f2_arg0:addElement(f2_arg0.itemImage1)
		f2_arg0.itemImage2 = LUI.UIImage.new()
		f2_arg0.itemImage2:setLeftRight(false, false, f2_local3 / 2, f2_local3 / 2 + f2_local0)
		f2_arg0.itemImage2:setTopBottom(true, false, f2_local1 - f2_local0 / 2, f2_local1 + f2_local0 / 2)
		f2_arg0.itemImage2:setImage(RegisterMaterial(f2_arg0.image2MaterialName))
		f2_arg0:addElement(f2_arg0.itemImage2)
		f2_arg0.itemImage1:setPriority(-80)
		f2_arg0.itemImage2:setPriority(-90)
	end
	CoD.ContentGridButton.SetupButtonImages(f2_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
end

CoD.ReticlesGridButton.UpdateClass = function (f3_arg0, f3_arg1)
	f3_arg0.selectedFill:setAlpha(0)
	f3_arg0.glowGradFront:setRGB(CoD.GrenadeGridButton.glowFrontColor.r, CoD.GrenadeGridButton.glowFrontColor.g, CoD.RewardGridButton.glowFrontColor.b)
	f3_arg0.glowGradFront:setAlpha(0.05)
	f3_arg0.currentlyEquipped = false
	if not (f3_arg1.equippedWeaponOption ~= nil or f3_arg0.reticleIndex ~= 0) or f3_arg1.equippedWeaponOption == f3_arg0.weaponOption then
		f3_arg0.selectedFill:setAlpha(0.2)
		f3_arg0.glowGradFront:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
		f3_arg0.glowGradFront:setAlpha(0.2)
		if f3_arg1.equippedWeaponOption == f3_arg0.weaponOption then
			f3_arg0.currentlyEquipped = true
			CoD.perController[f3_arg1.controller].currentlyEquippedReticleImage = f3_arg0.reticleImageName
			if f3_arg0.dualOpticReticle then
				CoD.perController[f3_arg1.controller].currentlyEquippedReticleImage1 = f3_arg0.image1MaterialName
				CoD.perController[f3_arg1.controller].currentlyEquippedReticleImage2 = f3_arg0.image2MaterialName
			end
		end
	end
	if Engine.IsWeaponOptionNew(f3_arg1.controller, f3_arg0.eAttachment, f3_arg0.weaponOption) then
		f3_arg0:setNew(true, f3_arg1.controller)
	else
		f3_arg0:setNew(false, f3_arg1.controller)
	end
	local f3_local0, f3_local1 = Engine.GetChallengeForItemOption(UIExpression.GetItemAttachment(nil, f3_arg0.weaponItemIndex, f3_arg0.attachmentIndex), f3_arg0.weaponOption)
	local f3_local2 = Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN)
	if not f3_local2 then
		f3_local2 = Engine.SessionModeIsMode(CoD.SESSIONMODE_SYSTEMLINK)
	end
	local f3_local3 = CoD.CACUtility.IsWeaponOptionMTX(f3_arg0.weaponOption)
	if not f3_local2 and not f3_local3 and f3_local0 ~= nil then
		local f3_local4 = "mp/statsmilestones" .. f3_local1 + 1 .. ".csv"
		local f3_local5 = Engine.GetAttachmentName(f3_arg0.weaponItemIndex, f3_arg0.attachmentIndex)
		local f3_local6 = UIExpression.TableLookupGetColumnValueForRow(controller, f3_local4, f3_local0, 5)
		local f3_local7 = tonumber(UIExpression.TableLookupGetColumnValueForRow(nil, f3_local4, f3_local0, 7))
		f3_arg0.maxVal = tonumber(UIExpression.TableLookupGetColumnValueForRow(nil, f3_local4, f3_local0, 2))
		f3_arg0.xpReward = tonumber(UIExpression.TableLookupGetColumnValueForRow(nil, f3_local4, f3_local0, 6))
		f3_arg0.statsname = UIExpression.TableLookupGetColumnValueForRow(nil, f3_local4, f3_local0, 4)
		f3_arg0.hintText = Engine.Localize(f3_local6 .. "_DESC", f3_arg0.maxVal, f3_local5)
		f3_arg0.challengeValue = Engine.GetItemOptionChallengeValue(f3_arg1.controller, UIExpression.GetItemAttachment(nil, f3_arg0.weaponItemIndex, f3_arg0.attachmentIndex), f3_arg0.weaponOption)
		local f3_local8 = nil
		if f3_local7 ~= nil and f3_local7 > 0 then
			local f3_local9 = tonumber(UIExpression.TableLookup(f3_arg1.controller, f3_local4, 0, f3_local7, 2))
			local f3_local10 = Engine.GetPreReqChallengeValue(f3_arg1.controller, UIExpression.GetItemAttachment(nil, f3_arg0.weaponItemIndex, f3_arg0.attachmentIndex), f3_local7)
			if f3_local10 ~= nil and f3_local10 < f3_local9 then
				f3_local8 = Engine.Localize("MPUI_RETICLE_PREREQ", "", Engine.Localize("MPUI_RETICLE_" .. f3_arg0.attachmentRef .. "_" .. string.gsub(UIExpression.TableLookup(f3_arg1.controller, f3_local4, 0, f3_local7, 9), "reticle_", "")), "")
			end
		end
		local f3_local9 = nil
		if f3_local8 then
			f3_arg0.hintText = f3_local8
			f3_arg0:setLocked(true)
			f3_local9 = true
			f3_arg0.showProgressBar = false
		else
			f3_arg0.showProgressBar = true
			if f3_arg0.challengeValue and f3_arg0.maxVal and f3_arg0.challengeValue < f3_arg0.maxVal then
				f3_local9 = true
				f3_arg0:setLocked(true)
			else
				f3_arg0:setLocked(false)
				f3_arg0.showProgressBar = false
			end
		end
		if f3_local9 and CoD.IsLeagueOrCustomMatch() then
			f3_arg0:setHintText(Engine.Localize("MENU_RETICLE_LOCKED_NON_PUBLIC"))
			f3_arg0.showProgressBar = false
		end
		if f3_arg0.dualOpticReticle and f3_arg0.lockImage then
			f3_arg0.itemImage1:hide()
			f3_arg0.itemImage2:hide()
		end
	elseif f3_local3 then
		local f3_local4 = CoD.CACUtility.GetWeaponOptionMTXName(f3_arg0.weaponOption)
		local f3_local5 = Engine.HasMTX(f3_arg1.controller, f3_local4)
		CoD.ContentGridButton.SetMTXPurchased(f3_arg0, f3_local5, controller)
		f3_arg0:setHintText(Engine.Localize("MPUI_MTX_PURCHASE_HINT", Engine.Localize("MPUI_" .. f3_local4)))
		if f3_local5 then
			f3_arg0:setActionPromptString(Engine.Localize("MENU_SELECT"))
		else
			f3_arg0:setActionPromptString(Engine.Localize("MENU_PURCHASE"))
		end
	end
end

