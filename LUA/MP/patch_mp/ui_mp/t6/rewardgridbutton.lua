CoD.RewardGridButton = {}
CoD.RewardGridButton.glowBackColor = {}
CoD.RewardGridButton.glowBackColor.r = 1
CoD.RewardGridButton.glowBackColor.g = 1
CoD.RewardGridButton.glowBackColor.b = 1
CoD.RewardGridButton.glowFrontColor = {}
CoD.RewardGridButton.glowFrontColor.r = 1
CoD.RewardGridButton.glowFrontColor.g = 1
CoD.RewardGridButton.glowFrontColor.b = 1
CoD.RewardGridButton.new = function (f1_arg0)
	local f1_local0 = CoD.ContentGridButton.new(f1_arg0)
	f1_local0.statIndex = f1_arg0
	CoD.ContentGridButton.SetupButtonText(f1_local0, Engine.Localize(UIExpression.GetItemName(nil, f1_arg0)))
	CoD.RewardGridButton.SetupButtonImages(f1_local0, UIExpression.GetItemImage(nil, f1_arg0))
	f1_local0:setRestrictedImage(Engine.IsItemIndexRestricted(f1_arg0))
	f1_local0:registerEventHandler("update_class", CoD.RewardGridButton.UpdateClass)
	return f1_local0
end

CoD.RewardGridButton.SetupButtonImages = function (f2_arg0, f2_arg1)
	local f2_local0 = 130
	local f2_local1 = f2_local0
	local f2_local2 = -20
	local f2_local3 = f2_arg1 .. "_menu"
	local f2_local4 = CoD.ContentGridButton.TitleHeight + 4
	if f2_arg0.itemImage then
		f2_arg0.itemImage:close()
		f2_arg0.itemImage = nil
	end
	if f2_local3 then
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 2, -2)
		Widget:setTopBottom(true, true, 2, -f2_local4 - 1.5)
		Widget:setPriority(-70)
		f2_arg0:addElement(Widget)
		Widget:setUseStencil(true)
		f2_arg0.itemImage = LUI.UIImage.new()
		f2_arg0.itemImage:setLeftRight(false, false, -f2_local1 / 2, f2_local1 / 2)
		f2_arg0.itemImage:setTopBottom(true, false, f2_local2, f2_local2 + f2_local0)
		f2_arg0.itemImage:setImage(RegisterMaterial(f2_local3))
		Widget:addElement(f2_arg0.itemImage)
	end
	CoD.ContentGridButton.SetupButtonImages(f2_arg0, CoD.RewardGridButton.glowBackColor, CoD.RewardGridButton.glowFrontColor)
end

CoD.RewardGridButton.UpdateClass = function (f3_arg0, f3_arg1)
	f3_arg0:setMutuallyExclusive(nil)
	f3_arg0.selectedFill:setAlpha(0)
	f3_arg0.glowGradFront:setRGB(CoD.RewardGridButton.glowFrontColor.r, CoD.RewardGridButton.glowFrontColor.g, CoD.RewardGridButton.glowFrontColor.b)
	f3_arg0.glowGradFront:setAlpha(0.05)
	local f3_local0 = f3_arg1.controller
	local f3_local1 = CoD.CACUtility.GetClassData(f3_local0)
	local f3_local2 = CoD.GetUnlockablesByGroupName("killstreak")
	local f3_local3 = {}
	local f3_local4 = 1
	for f3_local8, f3_local9 in ipairs(f3_local2) do
		if CoD.Rewards.IsSelected(f3_local9, f3_local1) == true then
			f3_local3[f3_local4] = {}
			f3_local3[f3_local4].itemIndex = f3_local9
			f3_local3[f3_local4].momentumCost = UIExpression.GetItemMomentumCost(nil, f3_local9)
			f3_local4 = f3_local4 + 1
		end
	end
	f3_local5 = false
	f3_arg0.currentCostConflict = false
	for f3_local6 = 1, #f3_local3, 1 do
		if f3_arg0.contentIndex == f3_local3[f3_local6].itemIndex then
			f3_arg0.selectedFill:setAlpha(0.2)
			f3_arg0.glowGradFront:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
			f3_arg0.glowGradFront:setAlpha(0.2)
			f3_arg0:setHintText(Engine.Localize("MPUI_ITEM_CURRENTLY_EQUIPPED_IN_ANOTHER_SLOT"))
			f3_local5 = true
			break
		elseif UIExpression.GetItemMomentumCost(nil, f3_arg0.contentIndex) == f3_local3[f3_local6].momentumCost then
			f3_arg0.currentCostConflict = true
		end
	end
	if f3_local5 == false and (#f3_local3 == CoD.CACUtility.maxRewardSlots or f3_arg0.currentCostConflict == true) then
		f3_arg0:setInactive(true)
		f3_arg0.highlight:setRGB(1, 1, 1)
		f3_arg0.itemNameText:registerAnimationState("button_over", {
			red = 1,
			green = 1,
			blue = 1
		})
		f3_arg0:registerAnimationState("button_over", {
			alpha = 1,
			zoom = 40
		})
		if f3_arg0:isInFocus() then
			f3_arg0:animateToState("button_over")
		end
	else
		f3_arg0:setInactive(false)
		f3_arg0.highlight:setRGB(1, 1, 1)
		f3_arg0.itemNameText:registerAnimationState("button_over", {
			red = CoD.BOIIOrange.r,
			green = CoD.BOIIOrange.g,
			blue = CoD.BOIIOrange.b
		})
		f3_arg0:registerAnimationState("button_over", {
			alpha = 1,
			zoom = 40
		})
	end
	if UIExpression.IsItemLocked(f3_local0, f3_arg0.statIndex) ~= 0 then
		f3_arg0:setLocked(true)
	else
		f3_arg0:setLocked(false)
		if UIExpression.IsItemPurchased(f3_local0, f3_arg0.statIndex) ~= 0 then
			f3_arg0:setPurchased(true)
		else
			f3_arg0:setPurchased(false)
		end
	end
	if Engine.IsItemNew(f3_local0, f3_arg0.statIndex) then
		f3_arg0:setNew(true)
	else
		f3_arg0:setNew(false)
	end
	if f3_arg0.mutuallyExclusiveIcon == nil and f3_arg0.lockImage == nil and f3_arg0.tokenImage == nil then
		f3_arg0:setHintText(nil)
	end
end

