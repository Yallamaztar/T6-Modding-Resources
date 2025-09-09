CoD.ChallengeReticlesGridButton = {}
CoD.ChallengeReticlesGridButton.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = UIExpression.GetWeaponOptionGroupIndex(nil, f1_arg1, CoD.CACUtility.WEAPONOPTION_GROUP_RETICLE)
	local f1_local1 = CoD.ContentGridButton.new(f1_arg1)
	f1_local1.reticleIndex = f1_arg1
	f1_local1.weaponOption = f1_local0
	f1_local1.attachmentRef = f1_arg2
	f1_local1.attachmentIndex = f1_arg3
	f1_local1.dualOpticReticle = f1_arg2 == "dualoptic"
	CoD.ContentGridButton.SetupButtonText(f1_local1, Engine.Localize("MPUI_RETICLE_" .. f1_arg2 .. "_" .. f1_arg1))
	CoD.ReticlesGridButton.SetupButtonImages(f1_local1, f1_arg2, f1_arg1, f1_local1.dualOpticReticle)
	f1_local1.gainFocusSFX = "cac_grid_nav"
	CoD.ChallengeReticlesGridButton.SetupButton(f1_local1, f1_arg0)
	return f1_local1
end

CoD.ChallengeReticlesGridButton.SetupButtonImages = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = 32
	local f2_local1 = (CoD.CACCamo.CamoGridItemHeight - CoD.ContentGridButton.TitleHeight + 4) / 2 + 2
	f2_arg0:setImage(UIExpression.GetWeaponOptionImage(nil, f2_arg1), 0, 0)
	f2_arg0.itemImage:setLeftRight(false, false, -f2_local0 / 2, f2_local0 / 2)
	f2_arg0.itemImage:setTopBottom(true, false, f2_local1 - f2_local0 / 2, f2_local1 + f2_local0 / 2)
	f2_arg0.itemImage:setPriority(-70)
	CoD.ContentGridButton.SetupButtonImages(f2_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
end

CoD.ChallengeReticlesGridButton.SetupButton = function (f3_arg0, f3_arg1)
	f3_arg0.selectedFill:setAlpha(0)
	f3_arg0.glowGradFront:setRGB(CoD.GrenadeGridButton.glowFrontColor.r, CoD.GrenadeGridButton.glowFrontColor.g, CoD.RewardGridButton.glowFrontColor.b)
	f3_arg0.glowGradFront:setAlpha(0.05)
	local f3_local0, f3_local1 = Engine.GetChallengeForItemOption(f3_arg0.attachmentIndex, f3_arg0.weaponOption)
	if f3_local0 ~= nil then
		local f3_local2 = "mp/statsmilestones" .. f3_local1 + 1 .. ".csv"
		local f3_local3 = UIExpression.GetAttachmentName(nil, f3_arg0.attachmentIndex)
		local f3_local4 = UIExpression.TableLookupGetColumnValueForRow(f3_arg1, f3_local2, f3_local0, 5)
		local f3_local5 = tonumber(UIExpression.TableLookupGetColumnValueForRow(nil, f3_local2, f3_local0, 7))
		f3_arg0.maxVal = tonumber(UIExpression.TableLookupGetColumnValueForRow(nil, f3_local2, f3_local0, 2))
		f3_arg0.xpReward = tonumber(UIExpression.TableLookupGetColumnValueForRow(nil, f3_local2, f3_local0, 6))
		f3_arg0.statsname = UIExpression.TableLookupGetColumnValueForRow(nil, f3_local2, f3_local0, 4)
		f3_arg0.hintText = Engine.Localize(f3_local4 .. "_DESC", f3_arg0.maxVal, f3_local3)
		f3_arg0.challengeValue = Engine.GetItemOptionChallengeValue(f3_arg1, f3_arg0.attachmentIndex, f3_arg0.weaponOption)
		local f3_local6 = nil
		if f3_local5 ~= nil and f3_local5 > 0 then
			local f3_local7 = tonumber(UIExpression.TableLookup(nil, f3_local2, 0, f3_local5, 2))
			local f3_local8 = Engine.GetPreReqChallengeValue(f3_arg1, f3_arg0.attachmentIndex, f3_local5)
			if f3_local8 ~= nil and f3_local8 < f3_local7 then
				f3_local6 = Engine.Localize("MPUI_RETICLE_PREREQ", "", Engine.Localize("MPUI_RETICLE_" .. f3_arg0.attachmentRef .. "_" .. string.gsub(UIExpression.TableLookup(f3_arg1, f3_local2, 0, f3_local5, 9), "reticle_", "")), "")
			end
		end
		if f3_local6 then
			f3_arg0.hintText = f3_local6
			f3_arg0:setLocked(true)
			f3_arg0.showProgressBar = false
		else
			f3_arg0.showProgressBar = true
			if f3_arg0.challengeValue and f3_arg0.maxVal and f3_arg0.challengeValue < f3_arg0.maxVal then
				f3_arg0:setLocked(true)
			else
				f3_arg0:setLocked(false)
				f3_arg0.showProgressBar = false
			end
		end
		if f3_arg0.dualOpticReticle and f3_arg0.lockImage then
			f3_arg0.itemImage1:hide()
			f3_arg0.itemImage2:hide()
		end
	end
end

