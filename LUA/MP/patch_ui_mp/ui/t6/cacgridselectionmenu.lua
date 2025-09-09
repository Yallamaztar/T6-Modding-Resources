require("T6.MFSlide")
CoD.CACGridSelectionMenu = {}
CoD.CACGridSelectionMenu.QuantityChangeUpArrowMaterial = RegisterMaterial("ui_arrow_left")
CoD.CACGridSelectionMenu.QuantityChangeArrowSize = 25
CoD.CACGridSelectionMenu.RightPaneWidth = 390
CoD.CACGridSelectionMenu.new = function (f1_arg0)
	local f1_local0 = CoD.MFSlide.new()
	if f1_arg0 == nil then
		f1_local0.title = Engine.Localize("MPUI_CREATE_A_CLASS_CAPS")
	else
		f1_local0.title = f1_arg0
	end
	f1_local0:registerEventHandler("add_slide_elements", CoD.CACGridSelectionMenu.AddSlideElements)
	f1_local0:registerEventHandler("slide_activated", CoD.CACGridSelectionMenu.Activated)
	f1_local0:registerEventHandler("slide_deactivated", CoD.CACGridSelectionMenu.Deactivated)
	f1_local0.updateUIFromClassData = CoD.CACGridSelectionMenu.UpdateUIFromClassData
	f1_local0.buttonGridItemsWide = 5
	f1_local0.buttonGridBorder = 30
	return f1_local0
end

CoD.CACGridSelectionMenu.AddSlideElements = function (f2_arg0, f2_arg1)
	CoD.MFSlide.addSlideElements(f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.body
	f2_arg0:addBackButton()
	local f2_local1 = f2_arg0.buttonGridItemsWide
	local f2_local2 = f2_local1 * CoD.ButtonGrid.ItemSize + (f2_local1 - 1) * CoD.ButtonGrid.Spacing
	local f2_local3 = f2_arg0.buttonGridBorder
	local f2_local4 = f2_local3 + f2_local2
	local f2_local5 = CoD.frameSubtitleHeight + f2_local3
	
	local buttonGrid = CoD.ButtonGrid.new(f2_local1, {
		left = f2_local3,
		top = f2_local5,
		right = f2_local4,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		alphaMultiplier = 1
	})
	f2_local0:addElement(buttonGrid)
	f2_local0.buttonGrid = buttonGrid
	
	buttonGrid:registerAnimationState("fade_out", {
		alphaMultiplier = 0
	})
	local f2_local7 = CoD.CACGridSelectionMenu.RightPaneWidth
	local f2_local8 = f2_local3
	
	local rightPane = LUI.UIElement.new({
		left = 0,
		top = f2_local5,
		right = f2_local7,
		bottom = 0,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alphaMultiplier = 1
	})
	f2_local0:addElement(rightPane)
	f2_local0.rightPane = rightPane
	
	rightPane:registerAnimationState("slide_in", {
		left = 0,
		top = f2_local5,
		right = f2_local7,
		bottom = 0,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	rightPane:registerAnimationState("slide_out", {
		left = -f2_local7 - f2_local8,
		right = -f2_local8,
		leftAnchor = false,
		rightAnchor = true
	})
	rightPane:registerAnimationState("active", {
		alphaMultiplier = 1
	})
	rightPane:registerAnimationState("inactive", {
		alphaMultiplier = 0.25
	})
	local f2_local10 = 0
	local f2_local11 = 5
	
	local itemImage = LUI.UIImage.new({
		alpha = 0
	})
	rightPane:addElement(itemImage)
	f2_local0.itemImage = itemImage
	
	local itemNameLabel = LUI.UIText.new({
		left = -f2_local7,
		top = f2_local10,
		right = 0,
		bottom = f2_local10 + CoD.textSize.Big,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		red = 0,
		green = 0,
		blue = 0,
		alpha = CoD.textAlphaBlackDark,
		font = CoD.fonts.Big
	})
	rightPane:addElement(itemNameLabel)
	f2_local0.itemNameLabel = itemNameLabel
	
	f2_local10 = f2_local10 + CoD.textSize.Big + f2_local11
	
	local itemDescriptionHeader = LUI.UIText.new({
		left = -f2_local7,
		top = f2_local10,
		right = 0,
		bottom = f2_local10 + CoD.textSize.Default,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		red = 0,
		green = 0,
		blue = 0,
		alpha = CoD.textAlphaBlackLight,
		font = CoD.fonts.Default
	})
	rightPane:addElement(itemDescriptionHeader)
	f2_local0.itemDescriptionHeader = itemDescriptionHeader
	
	itemDescriptionHeader:setText(Engine.Localize("MPUI_DESCRIPTION_CAPS"))
	f2_local10 = f2_local10 + CoD.textSize.Default
	
	local itemDescriptionLabel = LUI.UIText.new({
		left = -f2_local7,
		top = f2_local10,
		right = 0,
		bottom = f2_local10 + CoD.textSize.Default,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		red = 0,
		green = 0,
		blue = 0,
		alpha = CoD.textAlphaBlackDark,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Right
	})
	rightPane:addElement(itemDescriptionLabel)
	f2_local0.itemDescriptionLabel = itemDescriptionLabel
	
	f2_local10 = f2_local10 + CoD.textSize.Default * 6 + f2_local11
	
	local itemCostHeader = LUI.UIText.new({
		left = -f2_local7,
		top = f2_local10,
		right = 0,
		bottom = f2_local10 + CoD.textSize.Default,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		red = 0,
		green = 0,
		blue = 0,
		alpha = CoD.textAlphaBlackLight,
		font = CoD.fonts.Default
	})
	rightPane:addElement(itemCostHeader)
	f2_local0.itemCostHeader = itemCostHeader
	
	itemCostHeader:setText(Engine.Localize("MPUI_ALLOCATION_CAPS"))
	f2_local10 = f2_local10 + CoD.textSize.Default
	
	local itemCostLabel = LUI.UIText.new({
		left = -f2_local7,
		top = f2_local10,
		right = 0,
		bottom = f2_local10 + CoD.textSize.Big,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		red = CoD.green.r,
		green = CoD.green.g,
		blue = CoD.green.b,
		alpha = 1,
		font = CoD.fonts.Big,
		alignment = LUI.Alignment.Right
	})
	itemCostLabel:registerAnimationState("cannot_afford", {
		red = CoD.red.r,
		green = CoD.red.g,
		blue = CoD.red.b
	})
	rightPane:addElement(itemCostLabel)
	f2_local0.itemCostLabel = itemCostLabel
	
	f2_local10 = f2_local10 + CoD.textSize.Default + f2_local11
	local f2_local18 = CoD.textSize.Condensed
	local f2_local19 = CoD.fonts.Condensed
	local f2_local20 = f2_local10
	
	local requirementText = LUI.UIText.new({
		left = 0,
		top = f2_local20,
		right = 0,
		bottom = f2_local20 + f2_local18,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		font = f2_local19
	})
	requirementText:registerAnimationState("can_afford", {
		red = CoD.green.r,
		green = CoD.green.g,
		blue = CoD.green.b
	})
	requirementText:registerAnimationState("cannot_afford", {
		red = CoD.brightRed.r,
		green = CoD.brightRed.g,
		blue = CoD.brightRed.b
	})
	requirementText:animateToState("cannot_afford")
	f2_local0:addElement(requirementText)
	f2_local0.requirementText = requirementText
	
	local f2_local22 = f2_arg0.addGridElements
	if f2_local22 ~= nil then
		f2_local22(f2_arg0)
	end
	f2_arg0:updateUIFromClassData()
	local f2_local23 = LUI.UIVerticalList.new({
		left = f2_local3,
		top = 440,
		right = f2_local4,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		alphaMultiplier = 0
	})
	f2_local0:addElement(f2_local23)
	f2_local23:registerAnimationState("fade_in", {
		alphaMultiplier = 1
	})
	f2_local0.buttonPromptContainer = f2_local23
	
	local unequipPrompt = CoD.ButtonPrompt.new("primary", Engine.Localize("MPUI_CLEAR_CAPS"))
	f2_local23:addElement(unequipPrompt)
	f2_local0.unequipPrompt = unequipPrompt
	
	f2_local0.confirmPrompt = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_ACCEPT"))
	
	local equipPrompt = CoD.ButtonPrompt.new("primary", Engine.Localize("MPUI_EQUIP"))
	f2_local23:addElement(equipPrompt)
	f2_local0.equipPrompt = equipPrompt
	
	if CoD.useController then
		local f2_local26 = buttonGrid.buttons[1]
		if f2_local26 ~= nil then
			f2_local26:processEvent({
				name = "gain_focus"
			})
		end
	end
end

CoD.CACGridSelectionMenu.Activated = function (f3_arg0, f3_arg1)
	CoD.MFSlide.activated(f3_arg0, f3_arg1)
	local f3_local0 = f3_arg0.body
	local f3_local1 = f3_arg0.fadeInTime
	f3_local0.buttonGrid:animateIn()
	f3_local0.buttonPromptContainer:animateToState("fade_in", f3_arg0.fadeInTime)
	f3_local0.rightPane:animateToState("slide_out", f3_arg0.fadeInTime)
end

CoD.CACGridSelectionMenu.Deactivated = function (f4_arg0, f4_arg1)
	CoD.MFSlide.deactivated(f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.body
	local f4_local1 = f4_arg0.fadeOutTime
	f4_local0.buttonGrid:animateToState("fade_out", f4_arg0.fadeOutTime)
	f4_local0.buttonPromptContainer:animateToState("default", f4_arg0.fadeOutTime)
	f4_local0.rightPane:animateToState("slide_in", f4_arg0.fadeOutTime)
end

CoD.CACGridSelectionMenu.AddItemsToButtonGrid = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = f5_arg0.body
	if f5_arg2 == nil then
		f5_arg2 = f5_local0.buttonGrid
	end
	local f5_local1 = f5_arg2.aspectRatio
	if f5_local1 == nil then
		f5_local1 = 1
	end
	local f5_local2 = f5_arg2.itemWidth
	local f5_local3 = f5_local2 / f5_local1
	if f5_arg1 ~= nil then
		for f5_local12, f5_local13 in pairs(f5_arg1) do
			local f5_local14 = f5_arg2:addButton()
			f5_local14.menu = f5_arg0
			f5_local14.itemIndex = f5_local13
			f5_local14.itemName = UIExpression.ToUpper(nil, Engine.Localize(UIExpression.GetItemName(nil, f5_local13)))
			f5_local14.itemDescription = Engine.Localize(UIExpression.GetItemDesc(nil, f5_local13))
			f5_local14.itemCost = UIExpression.GetItemAllocationCost(nil, f5_local13)
			f5_local14.momentumCost = UIExpression.GetItemMomentumCost(nil, f5_local13)
			local f5_local7 = CoD.GetMaxQuantity(f5_local13)
			if f5_local7 < 1 then
				f5_local7 = 1
			end
			f5_local14.quantityChoices = {}
			for f5_local8 = 1, f5_local7, 1 do
				f5_local14.quantityChoices[f5_local8] = {
					quantity = f5_local8,
					cost = f5_local14.itemCost * f5_local8
				}
			end
			f5_local14:registerEventHandler("button_over", CoD.CACGridSelectionMenu.ItemButton_Over)
			f5_local14:registerEventHandler("button_action", CoD.CACGridSelectionMenu.ItemButton_Action)
			f5_local14:registerEventHandler("equip", CoD.CACGridSelectionMenu.ItemButton_Equip)
			f5_local14:registerEventHandler("remove_all", CoD.CACGridSelectionMenu.ItemButton_RemoveAll)
			f5_local14:registerEventHandler("increment_quantity", CoD.CACGridSelectionMenu.ItemButton_IncrementQuantity)
			f5_local14:registerEventHandler("decrement_quantity", CoD.CACGridSelectionMenu.ItemButton_DecrementQuantity)
			local f5_local8 = UIExpression.GetItemImage(nil, f5_local13)
			local f5_local9 = RegisterMaterial(f5_local8)
			local f5_local10 = LUI.UIImage.new({
				left = -f5_local2 / 2,
				top = -f5_local3 / 2,
				right = f5_local2 / 2,
				bottom = f5_local3 / 2,
				leftAnchor = false,
				topAnchor = false,
				rightAnchor = false,
				bottomAnchor = false,
				material = f5_local9,
				alpha = CoD.ButtonGrid.UnselectedAlpha
			})
			f5_local14:addElement(f5_local10)
			f5_local10:registerAnimationState("selectable", {
				alpha = 1
			})
			f5_local14.image = f5_local10
			if CoD.IsPerk(f5_local13) == true then
				f5_local14.itemMaterial = RegisterMaterial(f5_local8 .. "_256")
			else
				f5_local14.itemMaterial = f5_local9
			end
			f5_local14.aspectRatio = f5_local1
			local f5_local11 = LUI.UIText.new({
				left = -100,
				top = -CoD.textSize.Default,
				right = 0,
				bottom = 0,
				leftAnchor = false,
				topAnchor = false,
				rightAnchor = true,
				bottomAnchor = true,
				red = 0,
				green = 0,
				blue = 0,
				alpha = CoD.textAlphaBlackDark,
				font = CoD.fonts.Default
			})
			f5_local14:addElement(f5_local11)
			f5_local14.quantityLabel = f5_local11
		end
	end
end

CoD.CACGridSelectionMenu.AddAttachmentsToButtonGrid = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = f6_arg0.body
	if f6_arg2 == nil then
		f6_arg2 = f6_local0.buttonGrid
	end
	local f6_local1 = f6_arg2.aspectRatio
	if f6_local1 == nil then
		f6_local1 = 1
	end
	local f6_local2 = f6_arg2.itemWidth
	local f6_local3 = f6_local2 / f6_local1
	if f6_arg1 ~= nil then
		local f6_local4 = CoD.perController[f6_arg0.m_ownerController].weaponSlot
		for f6_local12, f6_local13 in pairs(f6_arg1) do
			local f6_local14 = f6_local13.weaponItemIndex
			local f6_local15 = f6_local13.attachmentIndex
			local f6_local16 = Engine.GetAttachmentName(f6_local14, f6_local15)
			if f6_local16 ~= "MPUI_DW" then
				local f6_local8 = f6_arg2:addButton()
				f6_local8.menu = f6_arg0
				f6_local8.weaponIndex = f6_local14
				f6_local8.attachmentIndex = f6_local15
				f6_local8.loadoutSlot = CoD.GetLoadoutSlotForAttachment(f6_local4, f6_local14, f6_local15)
				f6_local8.itemName = UIExpression.ToUpper(nil, Engine.Localize(f6_local16))
				f6_local8.itemDescription = Engine.Localize(Engine.GetAttachmentDesc(f6_local14, f6_local15))
				f6_local8.itemCost = Engine.GetAttachmentAllocationCost(f6_local14, f6_local15)
				f6_local8.quantityChoices = {
					{
						quantity = 1,
						cost = f6_local8.itemCost
					}
				}
				f6_local8:registerEventHandler("button_over", CoD.CACGridSelectionMenu.ItemButton_Over)
				f6_local8:registerEventHandler("button_action", CoD.CACGridSelectionMenu.ItemButton_Action)
				f6_local8:registerEventHandler("equip", CoD.CACGridSelectionMenu.AttachmentButton_Equip)
				f6_local8:registerEventHandler("remove_all", CoD.CACGridSelectionMenu.AttachmentButton_RemoveAll)
				f6_local8:registerEventHandler("increment_quantity", CoD.CACGridSelectionMenu.ItemButton_IncrementQuantity)
				f6_local8:registerEventHandler("decrement_quantity", CoD.CACGridSelectionMenu.ItemButton_DecrementQuantity)
				local f6_local9 = RegisterMaterial(Engine.GetAttachmentImage(f6_local14, f6_local15))
				local f6_local10 = LUI.UIImage.new({
					left = -f6_local2 / 2,
					top = -f6_local3 / 2,
					right = f6_local2 / 2,
					bottom = f6_local3 / 2,
					leftAnchor = false,
					topAnchor = false,
					rightAnchor = false,
					bottomAnchor = false,
					material = f6_local9,
					red = 0,
					green = 0,
					blue = 0,
					alpha = CoD.ButtonGrid.UnselectedAlpha
				})
				f6_local8:addElement(f6_local10)
				f6_local10:registerAnimationState("selectable", {
					alpha = 1
				})
				f6_local8.image = f6_local10
				f6_local8.itemMaterial = f6_local9
				f6_local8.aspectRatio = f6_local1
				local f6_local11 = LUI.UIText.new({
					left = -100,
					top = -CoD.textSize.Default,
					right = 0,
					bottom = 0,
					leftAnchor = false,
					topAnchor = false,
					rightAnchor = true,
					bottomAnchor = true,
					red = 0,
					green = 0,
					blue = 0,
					alpha = CoD.textAlphaBlackDark,
					font = CoD.fonts.Default
				})
				f6_local8:addElement(f6_local11)
				f6_local8.quantityLabel = f6_local11
			end
		end
	end
end

CoD.CACGridSelectionMenu.AddRewardsToButtonGrid = function (f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = f7_arg0.body
	if f7_arg2 == nil then
		f7_arg2 = f7_local0.buttonGrid
	end
	local f7_local1 = f7_arg2.aspectRatio
	if f7_local1 == nil then
		f7_local1 = 1
	end
	local f7_local2 = f7_arg2.itemWidth
	local f7_local3 = f7_local2 / f7_local1
	if f7_arg1 ~= nil then
		for f7_local12, f7_local13 in pairs(f7_arg1) do
			local f7_local14 = f7_arg2:addButton()
			f7_local14.menu = f7_arg0
			f7_local14.itemIndex = f7_local13
			f7_local14.itemName = UIExpression.ToUpper(nil, Engine.Localize(UIExpression.GetItemName(nil, f7_local13)))
			f7_local14.itemDescription = Engine.Localize(UIExpression.GetItemDesc(nil, f7_local13))
			f7_local14.itemCost = UIExpression.GetItemAllocationCost(nil, f7_local13)
			f7_local14.momentumCost = UIExpression.GetItemMomentumCost(nil, f7_local13)
			f7_local14.quantityChoices = {}
			local f7_local15 = Engine.GetKillstreakVariants(f7_local13)
			if #f7_local15 == 0 then
				f7_local14.quantityChoices[1] = {
					quantity = 1,
					cost = f7_local14.itemCost
				}
			else
				f7_local14.quantityChoices[1] = {
					quantity = UIExpression.GetItemCount(nil, f7_local13),
					cost = f7_local14.itemCost
				}
			end
			for f7_local10, f7_local11 in pairs(f7_local15) do
				table.insert(f7_local14.quantityChoices, {
					itemIndex = f7_local11,
					quantity = UIExpression.GetItemCount(nil, f7_local11),
					cost = UIExpression.GetItemCost(nil, f7_local11),
					momentumCost = UIExpression.GetItemMomentumCost(nil, f7_local11),
					description = Engine.Localize(UIExpression.GetItemDesc(nil, f7_local11))
				})
			end
			f7_local14:registerEventHandler("button_over", CoD.CACGridSelectionMenu.ItemButton_Over)
			f7_local14:registerEventHandler("button_action", CoD.CACGridSelectionMenu.ItemButton_Action)
			f7_local14:registerEventHandler("equip", CoD.CACGridSelectionMenu.ItemButton_Equip)
			f7_local14:registerEventHandler("remove_all", CoD.CACGridSelectionMenu.ItemButton_RemoveAll)
			f7_local14:registerEventHandler("increment_quantity", CoD.CACGridSelectionMenu.ItemButton_IncrementQuantity)
			f7_local14:registerEventHandler("decrement_quantity", CoD.CACGridSelectionMenu.ItemButton_DecrementQuantity)
			f7_local7 = UIExpression.GetItemImage(nil, f7_local13)
			f7_local8 = RegisterMaterial(f7_local7 .. "_big")
			f7_local9 = LUI.UIImage.new({
				left = -f7_local2 / 2,
				top = -f7_local3 / 2,
				right = f7_local2 / 2,
				bottom = f7_local3 / 2,
				leftAnchor = false,
				topAnchor = false,
				rightAnchor = false,
				bottomAnchor = false,
				material = f7_local8,
				alpha = CoD.ButtonGrid.UnselectedAlpha,
				shaderVector0 = {
					0,
					1,
					0,
					0
				}
			})
			f7_local14:addElement(f7_local9)
			f7_local9:registerAnimationState("selectable", {
				alpha = 1
			})
			f7_local14.image = f7_local9
			if CoD.IsPerk(f7_local13) == true then
				f7_local14.itemMaterial = RegisterMaterial(f7_local7 .. "_256")
			else
				f7_local14.itemMaterial = f7_local8
			end
			f7_local14.aspectRatio = f7_local1
			f7_local10 = LUI.UIText.new({
				left = -100,
				top = -CoD.textSize.Default,
				right = 0,
				bottom = 0,
				leftAnchor = false,
				topAnchor = false,
				rightAnchor = true,
				bottomAnchor = true,
				red = 0,
				green = 0,
				blue = 0,
				alpha = CoD.textAlphaBlackDark,
				font = CoD.fonts.Default
			})
			f7_local14:addElement(f7_local10)
			f7_local14.quantityLabel = f7_local10
		end
	end
end

CoD.CACGridSelectionMenu.UpdateGridFromClassData = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg0.frame.allocationSubtitle
	local f8_local1 = f8_arg0.body.classData
	local f8_local2 = f8_arg1.buttons
	local f8_local3 = 0
	for f8_local8, f8_local9 in pairs(f8_local2) do
		if f8_local0 == nil or f8_local0:canAfford(f8_local9.itemCost) == true then
			f8_local9.image:animateToState("selectable")
			f8_local9.selectable = true
		else
			f8_local9.image:animateToState("default")
			f8_local9.selectable = nil
		end
		local f8_local7 = CoD.CACGridSelectionMenu.ItemButton_GetQuantity(f8_local9)
		if f8_local7 > 0 then
			f8_local3 = f8_local3 + 1
			f8_local9.image:animateToState("selectable")
			f8_local9.background:animateToState("selected")
			if #f8_local9.quantityChoices > 1 then
				f8_local9.quantityLabel:setText(Engine.Localize("MENU_MULTIPLIER_X", f8_local7))
			end
			f8_local9.selectable = true
		else
			f8_local9.background:animateToState("default")
			f8_local9.quantityLabel:setText("")
		end
		CoD.CACGridSelectionMenu.ItemButton_UpdateSelectionPreview(f8_local9)
	end
	f8_local4 = f8_arg1.maxSelections
	if f8_local4 ~= nil and f8_local4 <= f8_local3 then
		for f8_local9, f8_local7 in pairs(f8_local2) do
			if CoD.CACGridSelectionMenu.ItemButton_GetQuantity(f8_local7) == 0 then
				f8_local7.image:animateToState("default")
				f8_local7.selectable = nil
			end
		end
	end
end

CoD.CACGridSelectionMenu.UpdateUIFromClassData = function (f9_arg0)
	local f9_local0 = f9_arg0.body
	f9_local0.classData = CoD.CACUtility.GetClassData(f9_arg0.m_ownerController)
	CoD.CACGridSelectionMenu.UpdateGridFromClassData(f9_arg0, f9_local0.buttonGrid)
end

CoD.CACGridSelectionMenu.StopEditingQuantity = function (f10_arg0, f10_arg1)
	local f10_local0 = f10_arg0.quantityButton
	f10_arg0.quantityButton = nil
	f10_local0.currentQuantity = nil
	f10_local0.startingQuantity = nil
	f10_local0.buttonRepeaterDown:close()
	f10_local0.buttonRepeaterDown = nil
	f10_local0.buttonRepeaterUp:close()
	f10_local0.buttonRepeaterUp = nil
	f10_local0.bigItemQuantityLabel:close()
	f10_local0.bigItemQuantityLabel = nil
	f10_local0.downArrow:close()
	f10_local0.downArrow = nil
	f10_local0.upArrow:close()
	f10_local0.upArrow = nil
	f10_local0.m_disableNavigation = nil
	f10_local0:addElement(f10_local0.quantityLabel)
	f10_arg0:registerEventHandler("button_prompt_back", CoD.MFSlide.buttonPromptBack)
	f10_arg0.body.confirmPrompt:close()
	f10_arg0:updateUIFromClassData()
end

CoD.CACGridSelectionMenu.ItemButton_GetQuantity = function (f11_arg0)
	local f11_local0 = f11_arg0.menu
	local f11_local1 = f11_local0.m_ownerController
	local f11_local2 = CoD.perController[f11_local1].classNumInternal
	local f11_local3 = f11_local0.classData
	local f11_local4 = f11_arg0.itemIndex
	if f11_local4 ~= nil then
		local f11_local5 = CoD.CACUtility.HowManyInClassData(f11_local4, f11_local3)
		if f11_local5 > 0 then
			return f11_arg0.quantityChoices[1].quantity * f11_local5
		end
		for f11_local9, f11_local10 in pairs(f11_arg0.quantityChoices) do
			local f11_local11 = f11_local10.itemIndex
			if f11_local11 ~= nil then
				f11_local5 = CoD.CACUtility.HowManyInClassData(f11_local11, f11_local3)
				if f11_local5 > 0 then
					return f11_local10.quantity * f11_local5
				end
			end
		end
		return 0
	else
		local f11_local5 = f11_arg0.loadoutSlot
		if f11_local5 ~= nil then
			if CoD.GetClassItem(f11_local1, f11_local2, f11_local5) == f11_arg0.attachmentIndex then
				return 1
			else
				return 0
			end
		else

		end
	end
end

CoD.CACGridSelectionMenu.ItemButton_GetIndexForQuantity = function (f12_arg0, f12_arg1)
	for f12_local3, f12_local4 in pairs(f12_arg0.quantityChoices) do
		if f12_local4.quantity == f12_arg1 then
			return f12_local3
		end
	end
end

CoD.CACGridSelectionMenu.ItemButton_UpdateMomentumPreview = function (f13_arg0)
	local f13_local0 = f13_arg0.currentQuantity
	if f13_local0 == nil then
		f13_local0 = CoD.CACGridSelectionMenu.ItemButton_GetQuantity(f13_arg0)
	end
	local f13_local1 = f13_arg0.momentumCost
	local f13_local2 = CoD.CACGridSelectionMenu.ItemButton_GetIndexForQuantity(f13_arg0, f13_local0)
	if f13_local2 ~= nil then
		local f13_local3 = f13_arg0.quantityChoices[f13_local2].momentumCost
		if f13_local3 ~= nil then
			f13_local1 = f13_local3
		end
	end
	f13_arg0.menu:processEvent({
		name = "momentum_cost_preview",
		momentum = f13_local1
	})
end

CoD.CACGridSelectionMenu.ItemButton_UpdateSelectionPreview = function (f14_arg0)
	if not f14_arg0:isInFocus() then
		return 
	end
	local f14_local0 = f14_arg0.menu
	local f14_local1 = f14_local0.body
	local f14_local2 = f14_local1.classData
	local f14_local3 = CoD.CACGridSelectionMenu.ItemButton_GetQuantity(f14_arg0)
	local f14_local4 = f14_local1.itemCostLabel
	local f14_local5 = f14_local1.itemImage
	local f14_local6 = f14_arg0.itemCost
	local f14_local7 = CoD.CACGridSelectionMenu.ItemButton_GetIndexForQuantity(f14_arg0, f14_local3)
	local f14_local8 = nil
	if f14_local7 ~= nil then
		f14_local6 = f14_arg0.quantityChoices[f14_local7].cost
		f14_local8 = f14_arg0.quantityChoices[f14_local7].description
	end
	CoD.CACGridSelectionMenu.ItemButton_UpdateMomentumPreview(f14_arg0)
	if CoD.isSinglePlayer == true then
		local f14_local9 = Engine.GetCurrentTokens(controllerIndex, f14_local1.buttonGrid.weaponGroup)
	else
		local f14_local9 = UIExpression.GetDStat(controllerIndex, "unlockTokens", f14_local1.buttonGrid.weaponGroup)
	end
	if f14_local1.buttonGrid.unlockTokenText ~= nil then
		local f14_local9 = Engine.Localize("STATS_TYPE_" .. f14_local1.buttonGrid.weaponGroup)
		if CoD.isSinglePlayer == true then
			f14_local9 = CoD.CAC.GetUnlockNameForGroup(f14_local1.buttonGrid.weaponGroup)
		end
		f14_local1.buttonGrid.unlockTokenText:setText(currentTokens .. " " .. f14_local9 .. " " .. Engine.Localize("MPUI_UNLOCK_TOKENS_AVAILABLE"))
	end
	f14_local1.itemNameLabel:setText(f14_arg0.itemName)
	if f14_local8 == nil then
		f14_local1.itemDescriptionLabel:setText(f14_arg0.itemDescription)
	else
		f14_local1.itemDescriptionLabel:setText(f14_local8)
	end
	f14_local4:setText(CoD.separateNumberWithCommas(f14_local6))
	local f14_local9 = 300
	local f14_local10 = f14_local9 / f14_arg0.aspectRatio
	f14_local5:registerAnimationState("change_material", {
		left = -f14_local9,
		top = -f14_local10 / 2,
		right = 0,
		bottom = f14_local10 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false,
		material = f14_arg0.itemMaterial,
		alpha = 0.25
	})
	f14_local5:animateToState("change_material")
	local f14_local11 = f14_local0.frame.allocationSubtitle
	local f14_local12
	if f14_local11 ~= nil then
		f14_local12 = f14_local11:canAfford(f14_local6)
	else
		f14_local12 = true
	end
	local f14_local13 = f14_arg0.selectable
	if f14_local13 == nil and f14_local11 ~= nil then
		f14_local11:setAllocationChange(nil)
	elseif f14_local3 > 0 then
		if f14_arg0.attachmentIndex == nil and CoD.IsWeapon(f14_arg0.itemIndex) == true then
			if f14_local2.primaryWeapon ~= nil and f14_local2.primaryWeapon[1] ~= nil and f14_local2.primaryWeapon[1].itemIndex == f14_arg0.itemIndex then
				f14_local6 = CoD.SumClassItemCosts(f14_local2.primaryWeapon) + CoD.SumClassItemCosts(f14_local2.primaryAttachments)
			elseif f14_local2.secondaryWeapon ~= nil and f14_local2.secondaryWeapon[1] ~= nil and f14_local2.secondaryWeapon[1].itemIndex == f14_arg0.itemIndex then
				f14_local6 = CoD.SumClassItemCosts(f14_local2.secondaryWeapon) + CoD.SumClassItemCosts(f14_local2.secondaryAttachments)
			end
		end
		if f14_local11 ~= nil then
			f14_local11:setAllocationChange(f14_local6)
		end
	elseif f14_local11 ~= nil then
		if f14_local12 == true then
			f14_local11:setAllocationChange(-f14_local6)
		else
			f14_local11:setAllocationChange(nil)
		end
	end
	local f14_local14 = f14_arg0.requirementText
	if f14_local14 == nil then
		f14_local14 = f14_local1.requirementText
	end
	if f14_local14 ~= nil and f14_arg0.attachmentIndex == nil and UIExpression.IsItemPurchased(controllerIndex, f14_arg0.itemIndex) ~= 1 then
		f14_local14:setText(Engine.Localize("MPUI_UNLOCK_TOKEN_REQUIRED"))
		if UIExpression.GetItemCost(nil, f14_arg0.itemIndex) > currentTokens then
			f14_local14:animateToState("cannot_afford")
		else
			f14_local14:animateToState("can_afford")
		end
	else
		f14_local14:setText(Engine.Localize(""))
	end
	if f14_local12 == true then
		f14_local4:animateToState("default")
	else
		f14_local4:animateToState("cannot_afford")
	end
	local f14_local15 = f14_local1.buttonPromptContainer
	local f14_local16 = f14_local1.contextualPrompt
	if f14_local13 == nil then
		f14_local1.equipPrompt:close()
		f14_local1.unequipPrompt:close()
		if f14_local16 ~= nil then
			f14_local16:close()
		end
	elseif f14_local3 > 0 then
		f14_local15:addElement(f14_local1.unequipPrompt)
		if f14_local16 ~= nil then
			local f14_local17 = f14_local1.contextualCheck
			if f14_local17 ~= nil and f14_local17(f14_arg0) == true then
				f14_local15:addElement(f14_local16)
			else
				f14_local16:close()
			end
		end
		f14_local1.equipPrompt:close()
	else
		f14_local15:addElement(f14_local1.equipPrompt)
		f14_local1.unequipPrompt:close()
		if f14_local16 ~= nil then
			f14_local16:close()
		end
	end
	if f14_local13 == nil then
		f14_local1.rightPane:animateToState("inactive")
	else
		f14_local1.rightPane:animateToState("active")
	end
end

CoD.CACGridSelectionMenu.ItemButton_Over = function (f15_arg0, f15_arg1)
	LUI.UIButton.Over(f15_arg0, f15_arg1)
	CoD.CACGridSelectionMenu.ItemButton_UpdateSelectionPreview(f15_arg0)
end

CoD.CACGridSelectionMenu.IsQuantityVariant = function (f16_arg0, f16_arg1)
	if f16_arg1 == f16_arg0.itemIndex then
		return true
	end
	for f16_local3, f16_local4 in pairs(f16_arg0.quantityChoices) do
		if f16_arg0.quantityChoices[f16_local3].itemIndex == f16_arg1 then
			return true
		end
	end
	return false
end

CoD.CACGridSelectionMenu.Equip = function (f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = f17_arg1.itemIndex
	local f17_local1 = CoD.CACGridSelectionMenu.ItemButton_GetIndexForQuantity(f17_arg1, f17_arg2)
	if f17_local1 ~= nil then
		local f17_local2 = f17_arg1.quantityChoices[f17_local1].itemIndex
		if f17_local2 ~= nil then
			f17_local0 = f17_local2
		end
	end
	local f17_local2 = CoD.perController[f17_arg0].classNumInternal
	if CoD.IsWeapon(f17_local0) == true then
		CoD.SetClassItem(f17_arg0, f17_local2, CoD.perController[f17_arg0].weaponSlot, f17_local0)
	elseif CoD.IsPerk(f17_local0) == true then
		for f17_local3 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
			local f17_local6 = CoD.CACUtility.loadoutSlotNames["specialty" .. f17_local3]
			local f17_local7 = CoD.GetClassItem(f17_arg0, f17_local2, f17_local6)
			if f17_local7 == nil or f17_local7 == 0 or f17_local7 == UIExpression.GetItemIndex(f17_arg0, CoD.nullSpecialtyName) then
				CoD.SetClassItem(f17_arg0, f17_local2, f17_local6, f17_local0)
			end
		end
	elseif CoD.IsReward(f17_local0) == true then
		CoD.CAC.PurchaseItemIfPossible(f17_arg1.menu, f17_arg0, f17_arg1)
		for f17_local3 = 1, CoD.CACUtility.maxRewardSlots, 1 do
			local f17_local6 = CoD.CACUtility.loadoutSlotNames["reward" .. f17_local3]
			local f17_local7 = CoD.GetClassItem(f17_arg0, f17_local2, f17_local6)
			if UIExpression.IsItemPurchased(f17_arg0, f17_local0) ~= 0 and (f17_local7 == nil or f17_local7 == 0 or f17_local7 == UIExpression.GetItemIndex(f17_arg0, CoD.nullSpecialtyName) or CoD.CACGridSelectionMenu.IsQuantityVariant(f17_arg1, f17_local7) == true) then
				CoD.SetClassItem(f17_arg0, f17_local2, f17_local6, f17_local0)
			end
		end
	elseif CoD.IsGrenade(f17_local0) == true then
		local f17_local3 = CoD.GetClassItem(f17_arg0, f17_local2, CoD.CACUtility.loadoutSlotNames.primaryGrenade)
		if f17_local3 == nil or f17_local3 == 0 or f17_local3 == f17_local0 then
			CoD.SetClassItem(f17_arg0, f17_local2, CoD.CACUtility.loadoutSlotNames.primaryGrenade, f17_local0, f17_arg2)
		else
			CoD.SetClassItem(f17_arg0, f17_local2, CoD.CACUtility.loadoutSlotNames.specialGrenade, f17_local0, f17_arg2)
		end
	end
end

CoD.CACGridSelectionMenu.ItemButton_Equip = function (f18_arg0, f18_arg1)
	if f18_arg0:isInFocus() then
		CoD.CACGridSelectionMenu.Equip(f18_arg0.menu.m_ownerController, f18_arg0, f18_arg1.quantity)
	end
end

CoD.CACGridSelectionMenu.AttachmentButton_Equip = function (f19_arg0, f19_arg1)
	if f19_arg0:isInFocus() then
		local f19_local0 = f19_arg1.controller
		CoD.SetClassItem(f19_local0, CoD.perController[f19_local0].classNumInternal, f19_arg0.loadoutSlot, f19_arg0.attachmentIndex)
	end
end

CoD.CACGridSelectionMenu.ItemButton_Action = function (f20_arg0, f20_arg1)
	if f20_arg0.selectable == nil then
		return 
	end
	Engine.PlaySound("uin_navigation_select_main")
	local f20_local0 = f20_arg0.itemIndex
	local f20_local1 = f20_arg0.menu
	local f20_local2 = f20_local1.allocationSubtitle
	if f20_arg0.m_disableNavigation == true then
		local f20_local3 = f20_arg0.currentQuantity
		if f20_local3 == 0 then
			local f20_local4 = f20_arg1.controller
			CoD.RemoveItemFromClass(f20_local4, CoD.perController[f20_local4].classNumInternal, f20_local0)
		else
			f20_arg0:processEvent({
				name = "equip",
				quantity = f20_local3,
				controller = f20_arg1.controller
			})
		end
		if f20_local2 ~= nil then
			f20_local2:commitChange()
		end
		CoD.CACGridSelectionMenu.StopEditingQuantity(f20_local1)
		return 
	end
	local f20_local3 = CoD.CACGridSelectionMenu.ItemButton_GetQuantity(f20_arg0)
	if f20_local3 > 0 then
		f20_arg0:processEvent({
			name = "remove_all",
			controller = f20_arg1.controller
		})
		return 
	end
	local f20_local4 = nil
	if #f20_arg0.quantityChoices == 1 then
		f20_local4 = true
	elseif f20_local3 == 0 and f20_local2 ~= nil and f20_local2:canAfford(f20_arg0.quantityChoices[2].cost) ~= true then
		f20_local4 = true
	end
	if f20_local4 == true then
		f20_arg0:processEvent({
			name = "equip",
			quantity = f20_arg0.quantityChoices[1].quantity,
			controller = f20_arg1.controller
		})
		if f20_local2 ~= nil then
			f20_local2:commitChange()
		end
		f20_local1:updateUIFromClassData()
		return 
	end
	f20_arg0.m_disableNavigation = true
	f20_arg0.quantityLabel:close()
	local f20_local5 = CoD.CACGridSelectionMenu.QuantityChangeUpArrowMaterial
	local f20_local6 = CoD.CACGridSelectionMenu.QuantityChangeArrowSize
	f20_arg0.upArrow = LUI.UIImage.new({
		left = -f20_local6 / 2,
		top = -f20_local6,
		right = f20_local6 / 2,
		bottom = 0,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		zRot = -90,
		red = 0,
		green = 0,
		blue = 0,
		material = f20_local5
	})
	f20_arg0.downArrow = LUI.UIImage.new({
		left = -f20_local6 / 2,
		top = 0,
		right = f20_local6 / 2,
		bottom = f20_local6,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = true,
		zRot = 90,
		red = 0,
		green = 0,
		blue = 0,
		material = f20_local5
	})
	f20_arg0.bigItemQuantityLabel = LUI.UIText.new({
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
	f20_arg0:addElement(f20_arg0.bigItemQuantityLabel)
	f20_arg0.buttonRepeaterUp = LUI.UIButtonRepeater.new("up", "increment_quantity")
	f20_arg0:addElement(f20_arg0.buttonRepeaterUp)
	f20_arg0.buttonRepeaterDown = LUI.UIButtonRepeater.new("down", "decrement_quantity")
	f20_arg0:addElement(f20_arg0.buttonRepeaterDown)
	f20_arg0.startingQuantity = f20_local3
	if f20_local3 == 0 then
		f20_arg0.currentQuantity = f20_arg0.quantityChoices[1].quantity
	else
		f20_arg0.currentQuantity = f20_local3
	end
	CoD.CACGridSelectionMenu.ItemButton_UpdateQuantityChangeUI(f20_arg0)
	f20_local1.quantityButton = f20_arg0
	f20_local1:registerEventHandler("button_prompt_back", CoD.CACGridSelectionMenu.StopEditingQuantity)
	local f20_local7 = f20_local1.body
	f20_local7.equipPrompt:close()
	f20_local7.buttonPromptContainer:addElement(f20_local7.confirmPrompt)
end

CoD.CACGridSelectionMenu.ItemButton_UpdateQuantityChangeUI = function (f21_arg0)
	local f21_local0 = f21_arg0.menu
	local f21_local1 = f21_local0.frame.allocationSubtitle
	local f21_local2 = f21_arg0.itemCost
	local f21_local3 = f21_arg0.currentQuantity
	local f21_local4 = 0
	local f21_local5 = CoD.CACGridSelectionMenu.ItemButton_GetIndexForQuantity(f21_arg0, f21_arg0.startingQuantity)
	if f21_local5 ~= nil then
		f21_local4 = f21_arg0.quantityChoices[f21_local5].cost
	end
	local f21_local6 = CoD.CACGridSelectionMenu.ItemButton_GetIndexForQuantity(f21_arg0, f21_local3)
	local f21_local7 = f21_arg0.quantityChoices[f21_local6].cost
	local f21_local8
	if f21_local6 < #f21_arg0.quantityChoices then
		if f21_local1 ~= nil then
			f21_local8 = f21_local1:canAfford(f21_arg0.quantityChoices[f21_local6 + 1].cost - f21_local4)
		else
			f21_local8 = true
		end
	else
		f21_local8 = false
	end
	if f21_local8 == true then
		f21_arg0:addElement(f21_arg0.upArrow)
	else
		f21_arg0.upArrow:close()
	end
	if f21_local3 == f21_arg0.quantityChoices[1].quantity then
		f21_arg0.downArrow:close()
	else
		f21_arg0:addElement(f21_arg0.downArrow)
	end
	f21_arg0.bigItemQuantityLabel:setText(Engine.Localize("MENU_MULTIPLIER_X", f21_local3))
	if f21_local1 ~= nil then
		f21_local1:setAllocationChange(f21_local4 - f21_local7)
	end
	CoD.CACGridSelectionMenu.ItemButton_UpdateMomentumPreview(f21_arg0)
	local f21_local9 = f21_arg0.quantityChoices[f21_local6].description
	if f21_local9 == nil then
		f21_local9 = f21_arg0.itemDescription
	end
	f21_local0.body.itemDescriptionLabel:setText(f21_local9)
end

CoD.CACGridSelectionMenu.ItemButton_RemoveAll = function (f22_arg0, f22_arg1)
	if f22_arg0:isInFocus() then
		local f22_local0 = f22_arg0.itemIndex
		local f22_local1 = f22_arg1.controller
		local f22_local2 = CoD.perController[f22_local1].classNumInternal
		local f22_local3 = f22_arg0.menu
		local f22_local4 = f22_local3.allocationSubtitle
		CoD.RemoveItemFromClass(f22_local1, f22_local2, f22_local0)
		for f22_local8, f22_local9 in pairs(f22_arg0.quantityChoices) do
			local f22_local10 = f22_local9.itemIndex
			if f22_local10 ~= nil then
				CoD.RemoveItemFromClass(f22_local1, f22_local2, f22_local10)
			end
		end
		if f22_local4 ~= nil then
			f22_local4:commitChange()
		end
		f22_local3:updateUIFromClassData()
	end
end

CoD.CACGridSelectionMenu.AttachmentButton_RemoveAll = function (f23_arg0, f23_arg1)
	if f23_arg0:isInFocus() then
		local f23_local0 = f23_arg1.controller
		local f23_local1 = CoD.perController[f23_local0].classNumInternal
		local f23_local2 = f23_arg0.menu
		CoD.SetClassItem(f23_local0, f23_local1, f23_arg0.loadoutSlot, 0)
		f23_local2.frame.allocationSubtitle:commitChange()
		f23_local2:updateUIFromClassData()
	end
end

CoD.CACGridSelectionMenu.ItemButton_IncrementQuantity = function (f24_arg0, f24_arg1)
	local f24_local0 = CoD.CACGridSelectionMenu.ItemButton_GetIndexForQuantity(f24_arg0, f24_arg0.currentQuantity)
	local f24_local1 = 0
	local f24_local2 = CoD.CACGridSelectionMenu.ItemButton_GetIndexForQuantity(f24_arg0, f24_arg0.startingQuantity)
	if f24_local2 ~= nil then
		f24_local1 = f24_arg0.quantityChoices[f24_local2].quantity
	end
	if f24_local0 < #f24_arg0.quantityChoices then
		local f24_local3 = f24_arg0.menu.frame.allocationSubtitle
		local f24_local4
		if f24_local3 ~= nil then
			f24_local4 = f24_local3:canAfford(f24_arg0.quantityChoices[f24_local0 + 1].cost - f24_local1)
		else
			f24_local4 = true
		end
		if f24_local4 == true then
			f24_arg0.currentQuantity = f24_arg0.quantityChoices[f24_local0 + 1].quantity
		end
	end
	CoD.CACGridSelectionMenu.ItemButton_UpdateQuantityChangeUI(f24_arg0)
end

CoD.CACGridSelectionMenu.ItemButton_DecrementQuantity = function (f25_arg0, f25_arg1)
	local f25_local0 = 0
	local f25_local1 = CoD.CACGridSelectionMenu.ItemButton_GetIndexForQuantity(f25_arg0, f25_arg0.currentQuantity)
	if f25_local1 > 1 then
		f25_local0 = f25_arg0.quantityChoices[f25_local1 - 1].quantity
	end
	if 0 < f25_local0 then
		f25_arg0.currentQuantity = f25_local0
	end
	CoD.CACGridSelectionMenu.ItemButton_UpdateQuantityChangeUI(f25_arg0)
end

