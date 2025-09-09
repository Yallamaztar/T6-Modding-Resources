require("T6.MFSlide")
require("T6.MFSlidePanel")
require("T6.CoD9Button")
function CACGrenadeSelection_CreateGrenadesGrid(f1_arg0)
	local f1_local0 = f1_arg0.CAC
	local f1_local1 = 1
	local f1_local2 = 75
	local f1_local3 = CoD.ButtonGrid.new(4, {
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}, f1_local2, f1_local2 * f1_local1)
	f1_local3.maxSelections = CoD.CACUtility.maxGrenades
	f1_local3.typeName = "grenades"
	local f1_local4 = {}
	LUI.ConcatenateToTable(f1_local4, CoD.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames.primaryGrenade))
	LUI.ConcatenateToTable(f1_local4, CoD.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames.specialGrenade))
	table.sort(f1_local4, CoD.CACItemComparisonFunction)
	for f1_local8, f1_local9 in pairs(f1_local4) do
		local f1_local10 = f1_local3:addButton()
		f1_local10.itemIndex = f1_local9
		f1_local10.itemName = UIExpression.ToUpper(nil, Engine.Localize(UIExpression.GetItemName(nil, f1_local9)))
		f1_local10.itemDescription = Engine.Localize(UIExpression.GetItemDesc(nil, f1_local9))
		f1_local10.itemCost = UIExpression.GetItemAllocationCost(nil, f1_local9)
		f1_local10.CAC = f1_local0
		f1_local10.currentQuantity = 0
		f1_local10:registerEventHandler("button_over", CACWeaponSlot_ItemButtonOver)
		f1_local10:registerEventHandler("button_action", CACGrenadeSelection_GrenadeButtonAction)
		f1_local10:registerEventHandler("increment_quantity", CACGrenadeSelection_IncrementQuantity)
		f1_local10:registerEventHandler("decrement_quantity", CACGrenadeSelection_DecrementQuantity)
		local f1_local11 = RegisterMaterial(UIExpression.GetItemImage(nil, f1_local9))
		local f1_local12 = LUI.UIImage.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true,
			material = f1_local11,
			alpha = 1
		})
		f1_local12:registerAnimationState("disabled", {
			alpha = CoD.CAC.ButtonGridDisabledAlpha
		})
		f1_local10:addElement(f1_local12)
		local f1_local13 = LUI.UIText.new({
			left = -100,
			top = -CoD.textSize.Condensed / 2,
			right = 100,
			bottom = CoD.textSize.Condensed / 2,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false,
			red = 0,
			green = 0,
			blue = 0,
			alpha = CoD.textAlpha,
			font = CoD.fonts.Condensed
		})
		f1_local10:addElement(f1_local13)
		f1_local10.itemImage = f1_local12
		f1_local10.itemMaterial = f1_local11
		f1_local10.quantityLabel = f1_local13
		local f1_local14 = 5
		local f1_local15 = LUI.UIImage.new({
			left = -CoD.CAC.ButtonGridLockImageSize - f1_local14,
			top = -CoD.CAC.ButtonGridLockImageSize - f1_local14,
			right = -f1_local14,
			bottom = -f1_local14,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true,
			red = 1,
			green = 1,
			blue = 1,
			material = CoD.CAC.LockImageMaterial,
			alpha = 0
		})
		f1_local15:registerAnimationState("show", {
			alpha = 1
		})
		f1_local15:registerAnimationState("can_afford", {
			red = CoD.green.r,
			green = CoD.green.g,
			blue = CoD.green.b
		})
		f1_local15:registerAnimationState("cannot_afford", {
			red = 1,
			green = 1,
			blue = 1
		})
		f1_local10:addElement(f1_local15)
		f1_local10.lockImage = f1_local15
	end
	CoD.CAC.AddUnlockTokenText(f1_local3, "weapon_grenade", true, false)
	return f1_local3
end

function CACGrenadeSelection_GrenadeButtonAction(f2_arg0, f2_arg1)
	if f2_arg0.disabled == true then
		return 
	end
	local f2_local0 = f2_arg0.CAC
	local f2_local1 = f2_local0.m_ownerController
	local f2_local2 = f2_local0:getPanel("ItemsGrid")
	local f2_local3 = f2_local0:getAllocationSubtitle()
	local f2_local4 = CoD.perController[f2_local1].classNumInternal
	local f2_local5 = f2_arg0.itemIndex
	local f2_local6 = f2_arg0.itemCost
	Engine.PlaySound(CoD.CAC.ButtonActionSound)
	if f2_arg0.locked == true then
		CoD.CAC.PurchaseItemIfPossible(f2_arg0.CAC, f2_local1, f2_arg0)
		return 
	elseif f2_arg0.m_disableNavigation == true then
		local f2_local7 = f2_arg0.currentQuantity
		local f2_local8 = CoD.GetClassItem(f2_local1, f2_local4, CoD.CACUtility.loadoutSlotNames.primaryGrenade)
		if UIExpression.IsItemPurchased(f2_local1, f2_local5) ~= 0 then
			if f2_local8 == nil or f2_local8 == 0 or f2_local8 == f2_local5 then
				CoD.SetClassItem(f2_local1, f2_local4, CoD.CACUtility.loadoutSlotNames.primaryGrenade, f2_local5, f2_local7)
			else
				CoD.SetClassItem(f2_local1, f2_local4, CoD.CACUtility.loadoutSlotNames.specialGrenade, f2_local5, f2_local7)
			end
		end
		CACGrenadeSelection_StopEditingQuantity(f2_local0)
		f2_local0:update()
		f2_local2:updateButtonGrid(f2_local3)
		if f2_arg0.selected == true then
			f2_local3:setAllocationChange(f2_arg0.itemCost)
		else
			f2_local3:setAllocationChange(-f2_arg0.itemCost)
		end
		return 
	end
	f2_arg0.currentQuantity = 1
	if f2_arg0.selected == true then
		f2_arg0.currentQuantity = 0
		CoD.RemoveItemFromClass(f2_local1, f2_local4, f2_local5)
		f2_local0:update()
		f2_local2:updateButtonGrid(f2_local3)
		if f2_arg0.selected == true then
			f2_local3:setAllocationChange(f2_arg0.itemCost)
		else
			f2_local3:setAllocationChange(-f2_arg0.itemCost)
		end
		return 
	end
	local f2_local7 = nil
	if CoD.GetMaxQuantity(f2_local5) == 1 then
		f2_local7 = true
	elseif f2_local3:canAfford(f2_local6 * 2) ~= true then
		f2_local7 = true
	end
	if f2_local7 == true then
		local f2_local8 = f2_arg0.currentQuantity
		CoD.CAC.PurchaseItemIfPossible(f2_arg0.CAC, f2_local1, f2_arg0)
		if UIExpression.IsItemPurchased(f2_local1, f2_local5) ~= 0 then
			local f2_local9 = CoD.GetClassItem(f2_local1, f2_local4, CoD.CACUtility.loadoutSlotNames.primaryGrenade)
			if f2_local9 == nil or f2_local9 == 0 or f2_local9 == f2_local5 then
				CoD.SetClassItem(f2_local1, f2_local4, CoD.CACUtility.loadoutSlotNames.primaryGrenade, f2_local5, f2_local8)
			else
				CoD.SetClassItem(f2_local1, f2_local4, CoD.CACUtility.loadoutSlotNames.specialGrenade, f2_local5, f2_local8)
			end
		end
		f2_local0:update()
		f2_local2:updateButtonGrid(f2_local3)
		if f2_arg0.selected == true then
			f2_local3:setAllocationChange(f2_arg0.itemCost)
		else
			f2_local3:setAllocationChange(-f2_arg0.itemCost)
		end
		return 
	end
	f2_arg0.m_disableNavigation = true
	f2_arg0.itemImage:animateToState("disabled")
	local f2_local8 = RegisterMaterial("ui_arrow_left")
	local f2_local9 = 25
	f2_arg0.upArrow = LUI.UIImage.new({
		left = -f2_local9 / 2,
		top = -f2_local9,
		right = f2_local9 / 2,
		bottom = 0,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		zRot = -90,
		red = 0,
		green = 0,
		blue = 0,
		material = f2_local8
	})
	f2_arg0.downArrow = LUI.UIImage.new({
		left = -f2_local9 / 2,
		top = 0,
		right = f2_local9 / 2,
		bottom = f2_local9,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		zRot = 90,
		red = 0,
		green = 0,
		blue = 0,
		material = f2_local8
	})
	f2_arg0.bigItemQuantityLabel = LUI.UIText.new({
		left = -100,
		top = -CoD.textSize.Condensed / 2,
		right = 100,
		bottom = CoD.textSize.Condensed / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		alpha = CoD.textAlpha,
		font = CoD.fonts.Condensed
	})
	f2_arg0:addElement(f2_arg0.bigItemQuantityLabel)
	f2_arg0.buttonRepeaterUp = LUI.UIButtonRepeater.new("up", "increment_quantity")
	f2_arg0:addElement(f2_arg0.buttonRepeaterUp)
	f2_arg0.buttonRepeaterDown = LUI.UIButtonRepeater.new("down", "decrement_quantity")
	f2_arg0:addElement(f2_arg0.buttonRepeaterDown)
	CACGrenadeSelection_UpdateQuantityChangeUI(f2_arg0)
	f2_local0.quantityButton = f2_arg0
	f2_local0:registerEventHandler("button_prompt_back", CACGrenadeSelection_StopEditingQuantity)
end

function CACGrenadeSelection_UpdateQuantityChangeUI(f3_arg0)
	local f3_local0 = f3_arg0.CAC
	local f3_local1 = f3_local0:getAllocationSubtitle()
	local f3_local2 = f3_arg0.itemIndex
	local f3_local3 = f3_arg0.itemCost
	local f3_local4 = f3_arg0.currentQuantity
	local f3_local5 = f3_local4 * f3_local3
	local f3_local6 = CoD.GetMaxQuantity(f3_local2)
	local f3_local7 = f3_local0:getPanel("ItemsGrid")
	if CoD.useMouse then
		f3_local7:restrictMouseInputTo(f3_arg0)
	end
	local f3_local8
	if f3_local4 < f3_local6 then
		f3_local8 = f3_local1:canAfford(f3_local5 + f3_local3)
	else
		f3_local8 = false
	end
	if f3_local8 == true then
		f3_arg0:addElement(f3_arg0.upArrow)
	else
		f3_arg0.upArrow:close()
	end
	if f3_local4 == 1 then
		f3_arg0.downArrow:close()
	else
		f3_arg0:addElement(f3_arg0.downArrow)
	end
	f3_arg0.bigItemQuantityLabel:setText(Engine.Localize("MENU_MULTIPLIER_X", f3_local4))
	if f3_local1 ~= nil then
		f3_local1:setAllocationChange(-f3_local5)
	end
end

function CACGrenadeSelection_IncrementQuantity(f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.CAC:getAllocationSubtitle()
	if f4_arg0.currentQuantity < CoD.GetMaxQuantity(f4_arg0.itemIndex) and f4_local0:canAfford((f4_arg0.currentQuantity + 1) * f4_arg0.itemCost) then
		f4_arg0.currentQuantity = f4_arg0.currentQuantity + 1
	end
	CACGrenadeSelection_UpdateQuantityChangeUI(f4_arg0)
end

function CACGrenadeSelection_DecrementQuantity(f5_arg0, f5_arg1)
	if f5_arg0.currentQuantity > 1 then
		f5_arg0.currentQuantity = f5_arg0.currentQuantity - 1
	end
	CACGrenadeSelection_UpdateQuantityChangeUI(f5_arg0)
end

function CACGrenadeSelection_StopEditingQuantity(f6_arg0)
	local f6_local0 = f6_arg0.quantityButton
	f6_arg0.quantityButton = nil
	local f6_local1 = f6_arg0:getPanel("ItemsGrid")
	if CoD.useMouse then
		f6_local1:restrictMouseInputTo(nil)
	end
	f6_local0.itemImage:animateToState("default")
	f6_local0.currentQuantity = nil
	f6_local0.buttonRepeaterDown:close()
	f6_local0.buttonRepeaterDown = nil
	f6_local0.buttonRepeaterUp:close()
	f6_local0.buttonRepeaterUp = nil
	f6_local0.bigItemQuantityLabel:close()
	f6_local0.bigItemQuantityLabel = nil
	f6_local0.downArrow:close()
	f6_local0.downArrow = nil
	f6_local0.upArrow:close()
	f6_local0.upArrow = nil
	f6_local0.m_disableNavigation = nil
	f6_arg0:registerEventHandler("button_prompt_back", CACLoadOut_GrenadesBack)
end

