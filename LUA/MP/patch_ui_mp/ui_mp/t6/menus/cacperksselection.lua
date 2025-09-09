require("T6.MFSlide")
require("T6.MFSlidePanel")
require("T6.CoD9Button")
function CACPerksSelection_CreatePerksGrid(f1_arg0)
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
	f1_local3.maxSelections = CoD.CACUtility.maxPerks
	f1_local3.typeName = "perks"
	local f1_local4 = {}
	for f1_local5 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
		LUI.ConcatenateToTable(f1_local4, CoD.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames["specialty" .. f1_local5]))
	end
	table.sort(f1_local4, CoD.CACItemComparisonFunction)
	for f1_local8, f1_local9 in pairs(f1_local4) do
		local f1_local10 = f1_local3:addButton()
		f1_local10.itemIndex = f1_local9
		f1_local10.itemName = UIExpression.ToUpper(nil, Engine.Localize(UIExpression.GetItemName(nil, f1_local9)))
		f1_local10.itemDescription = Engine.Localize(UIExpression.GetItemDesc(nil, f1_local9))
		f1_local10.itemCost = UIExpression.GetItemAllocationCost(nil, f1_local9)
		f1_local10.CAC = f1_local0
		f1_local10:registerEventHandler("button_over", CACWeaponSlot_ItemButtonOver)
		f1_local10:registerEventHandler("button_action", CACPerkSelection_PerkButtonAction)
		local f1_local11 = RegisterMaterial(UIExpression.GetItemImage(nil, f1_local9) .. "_256")
		
		local itemImage = LUI.UIImage.new({
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
		itemImage:registerAnimationState("disabled", {
			alpha = CoD.CAC.ButtonGridDisabledAlpha
		})
		f1_local10:addElement(itemImage)
		f1_local10.itemImage = itemImage
		
		f1_local10.itemMaterial = f1_local11
		local f1_local13 = 5
		local f1_local14 = LUI.UIImage.new({
			left = -CoD.CAC.ButtonGridLockImageSize - f1_local13,
			top = -CoD.CAC.ButtonGridLockImageSize - f1_local13,
			right = -f1_local13,
			bottom = -f1_local13,
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
		f1_local14:registerAnimationState("show", {
			alpha = 1
		})
		f1_local14:registerAnimationState("can_afford", {
			red = CoD.green.r,
			green = CoD.green.g,
			blue = CoD.green.b
		})
		f1_local14:registerAnimationState("cannot_afford", {
			red = 1,
			green = 1,
			blue = 1
		})
		f1_local10:addElement(f1_local14)
		f1_local10.lockImage = f1_local14
	end
	CoD.CAC.AddUnlockTokenText(f1_local3, "specialty", true, false)
	return f1_local3
end

function CACPerkSelection_PerkButtonAction(f2_arg0, f2_arg1)
	if f2_arg0.disabled == true then
		return 
	end
	local f2_local0 = f2_arg0.CAC
	local f2_local1 = f2_local0.m_ownerController
	local f2_local2 = CoD.perController[f2_local1].classNumInternal
	local f2_local3 = f2_arg0.itemIndex
	local f2_local4 = f2_local0:getPanel("ItemsGrid")
	local f2_local5 = f2_local0:getAllocationSubtitle()
	CoD.CAC.PurchaseItemIfPossible(f2_arg0.CAC, f2_local1, f2_arg0)
	for f2_local6 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
		local f2_local9 = CoD.CACUtility.loadoutSlotNames["specialty" .. f2_local6]
		local f2_local10 = CoD.GetClassItem(f2_local1, f2_local2, f2_local9)
		if f2_arg0.selected == true then
			if f2_local10 == f2_local3 then
				CoD.SetClassItem(f2_local1, f2_local2, f2_local9, 0)
				break
			end
		end
		if (f2_local10 == nil or f2_local10 == 0 or f2_local10 == UIExpression.GetItemIndex(f2_local1, CoD.nullSpecialtyName)) and UIExpression.IsItemPurchased(f2_local1, f2_local3) ~= 0 then
			CoD.SetClassItem(f2_local1, f2_local2, f2_local9, f2_local3)
			break
		end
	end
	f2_local0:update()
	f2_local4:updateButtonGrid(f2_local5)
	if f2_arg0.selected == true then
		f2_local5:setAllocationChange(f2_arg0.itemCost)
	else
		f2_local5:setAllocationChange(-f2_arg0.itemCost)
	end
	Engine.PlaySound(CoD.CAC.ButtonActionSound)
end

