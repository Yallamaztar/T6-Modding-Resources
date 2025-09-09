CoD.WeaponButton = {}
CoD.WeaponButton.FontName = "Default"
CoD.WeaponButton.WeaponImageHeight = 135
CoD.WeaponButton.WeaponImageRatio = 2
CoD.WeaponButton.WeaponImageWidth = CoD.WeaponButton.WeaponImageHeight * CoD.WeaponButton.WeaponImageRatio
CoD.WeaponButton.GrenadeImageHeight = 60
CoD.WeaponButton.GrenadeImageWidth = CoD.WeaponButton.GrenadeImageHeight
CoD.WeaponButton.PerkImageHeight = 60
CoD.WeaponButton.PerkImageWidth = CoD.WeaponButton.PerkImageHeight
CoD.WeaponButton.PerkCyclePeriod = 3000
CoD.WeaponButton.PerkCycleFadePeriod = 500
CoD.WeaponButton.SelectedAlpha = 1
CoD.WeaponButton.NotSelectedAlpha = 0.25
CoD.WeaponButton.SelectionPeriod = 300
CoD.WeaponButton.new = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = f1_arg0.bottom
	if f1_arg1 ~= "primaryWeapon" then
		f1_arg0.bottom = f1_arg0.bottom + CoD.textSize[CoD.WeaponButton.FontName]
	end
	local f1_local1 = LUI.UIButton.new(f1_arg0, f1_arg2)
	f1_local1.id = f1_local1.id .. ".WeaponButton." .. f1_arg1
	f1_local1.buttonName = f1_arg1
	local f1_local2 = 20
	local f1_local3 = CoD.SideBracketsImage.new()
	f1_local3:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = true,
		left = -f1_local2,
		right = f1_local2,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.textSize[CoD.WeaponButton.FontName],
		bottom = 0
	})
	f1_local3:animateToState("default")
	f1_local1:addElement(f1_local3)
	LUI.UIButton.SetupElement(f1_local3)
	f1_local1.buttonBrackets = f1_local3
	f1_local1.buttonBrackets:registerAnimationState("hide_button_bracket", {
		leftAnchor = true,
		rightAnchor = true,
		left = -f1_local2 * 3,
		right = f1_local2 * 3,
		alpha = 0
	})
	f1_local1.buttonBrackets:registerAnimationState("show_button_bracket", {
		leftAnchor = true,
		rightAnchor = true,
		left = -f1_local2,
		right = f1_local2,
		alpha = 1
	})
	f1_local1.buttonBrackets:animateToState("hide_button_bracket")
	
	local imageHolder = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -f1_local0,
		bottom = 0
	})
	imageHolder.id = imageHolder.id .. ".ImageHolder"
	LUI.UIButton.SetupElement(imageHolder)
	f1_local1:addElement(imageHolder)
	f1_local1.imageHolder = imageHolder
	
	CoD.WeaponButton.AddTextElement(f1_local1)
	f1_local1.weaponSetup = CoD.WeaponButton.WeaponSetup
	f1_local1.grenadeSetup = CoD.WeaponButton.GrenadeSetup
	f1_local1.perksSetup = CoD.WeaponButton.PerksSetup
	f1_local1.setNewAvailable = CoD.WeaponButton.SetNewItemAvailable
	f1_local1:registerEventHandler("move_to_center", CoD.WeaponButton.MoveToCenter)
	f1_local1:registerEventHandler("gain_focus", CoD.WeaponButton.GainFocus)
	f1_local1:registerEventHandler("lose_focus", CoD.WeaponButton.LoseFocus)
	f1_local1:registerEventHandler("button_action", CoD.WeaponButton.ButtonAction)
	f1_local1:registerEventHandler("button_over", CoD.WeaponButton.ButtonOver)
	f1_local1:registerEventHandler("button_up", CoD.WeaponButton.ButtonUp)
	return f1_local1
end

CoD.WeaponButton.ButtonOver = function (f2_arg0, f2_arg1)
	if f2_arg0.weaponType == "perks" then
		for f2_local0 = 1, #f2_arg0.weaponImage.perkImages, 1 do
			f2_arg0.weaponImage.perkImages[f2_local0]:beginAnimation("select", CoD.WeaponButton.SelectionPeriod)
			f2_arg0.weaponImage.perkImages[f2_local0]:setAlpha(CoD.WeaponButton.SelectedAlpha)
			f2_arg0.weaponImage.currentAlpha = CoD.WeaponButton.SelectedAlpha
		end
	elseif f2_arg0.weaponType == "grenade" then
		f2_arg0.weaponImage.primaryImage:beginAnimation("select", CoD.WeaponButton.SelectionPeriod)
		f2_arg0.weaponImage.primaryImage:setAlpha(CoD.WeaponButton.SelectedAlpha)
		f2_arg0.weaponImage.specialImage:beginAnimation("select", CoD.WeaponButton.SelectionPeriod)
		f2_arg0.weaponImage.specialImage:setAlpha(CoD.WeaponButton.SelectedAlpha)
	else
		f2_arg0.weaponImage:beginAnimation("select", CoD.WeaponButton.SelectionPeriod)
		f2_arg0.weaponImage:setAlpha(CoD.WeaponButton.SelectedAlpha)
	end
end

CoD.WeaponButton.ButtonUp = function (f3_arg0, f3_arg1)
	if f3_arg0.weaponType == "perks" then
		for f3_local0 = 1, #f3_arg0.weaponImage.perkImages, 1 do
			f3_arg0.weaponImage.perkImages[f3_local0]:beginAnimation("deselect", CoD.WeaponButton.SelectionPeriod)
			f3_arg0.weaponImage.perkImages[f3_local0]:setAlpha(CoD.WeaponButton.NotSelectedAlpha)
			f3_arg0.weaponImage.currentAlpha = CoD.WeaponButton.NotSelectedAlpha
		end
	elseif f3_arg0.weaponType == "grenade" then
		f3_arg0.weaponImage.primaryImage:beginAnimation("deselect", CoD.WeaponButton.SelectionPeriod)
		f3_arg0.weaponImage.primaryImage:setAlpha(CoD.WeaponButton.NotSelectedAlpha)
		f3_arg0.weaponImage.specialImage:beginAnimation("deselect", CoD.WeaponButton.SelectionPeriod)
		f3_arg0.weaponImage.specialImage:setAlpha(CoD.WeaponButton.NotSelectedAlpha)
	else
		f3_arg0.weaponImage:beginAnimation("deselect", CoD.WeaponButton.SelectionPeriod)
		f3_arg0.weaponImage:setAlpha(CoD.WeaponButton.NotSelectedAlpha)
	end
end

CoD.WeaponButton.MoveToCenter = function (f4_arg0, f4_arg1)
	f4_arg0:animateToState("move_to_center", f4_arg1.duration)
	f4_arg0.weaponImage:animateToState("center", f4_arg1.duration)
end

CoD.WeaponButton.GainFocus = function (f5_arg0, f5_arg1)
	LUI.UIButton.gainFocus(f5_arg0, f5_arg1)
	f5_arg0:processEvent({
		name = "move_to_center"
	})
	f5_arg0.buttonBrackets:animateToState("show_button_bracket", 150)
end

CoD.WeaponButton.LoseFocus = function (f6_arg0, f6_arg1)
	LUI.UIButton.loseFocus(f6_arg0, f6_arg1)
	f6_arg0:processEvent({
		name = "move_to_center"
	})
	f6_arg0.buttonBrackets:animateToState("hide_button_bracket")
end

CoD.WeaponButton.ButtonAction = function (f7_arg0, f7_arg1)
	f7_arg0:dispatchEventToParent({
		name = "weapon_button_action",
		controller = f7_arg1.controller,
		button = f7_arg0,
		type = f7_arg0.weaponType,
		loadoutSlot = f7_arg0.loadoutSlot
	})
end

CoD.WeaponButton.AddTextElement = function (HudRef, InstanceRef)
	local weaponTextHolder = LUI.UIElement.new()
	weaponTextHolder:setLeftRight(false, true, 0, 0)
	weaponTextHolder:setTopBottom(true, false, 0, CoD.textSize[CoD.WeaponButton.FontName])
	weaponTextHolder.id = weaponTextHolder.id .. ".WeaponTextHolder"
	HudRef:addElement(weaponTextHolder)
	HudRef.weaponTextHolder = weaponTextHolder
	
	if InstanceRef == nil then
		local weaponText = LUI.UIText.new()
		weaponText:setLeftRight(true, true, 10, 0)
		weaponText:setTopBottom(true, true, 0, 0)
		weaponText:setAlpha(CoD.textAlpha)
		weaponText:setFont(CoD.fonts[CoD.WeaponButton.FontName])
		weaponText:setAlignment(LUI.Alignment.Left)
		weaponText.id = weaponText.id .. ".WeaponText"
		weaponTextHolder:addElement(weaponText)
		weaponTextHolder.weaponText = weaponText
		
	else
		weaponTextHolder.textList = {}
		weaponTextHolder.bracketList = {}
		for weaponText = 1, InstanceRef, 1 do
			local f8_local4 = LUI.UIText.new()
			f8_local4:setLeftRight(true, true, 10, 0)
			f8_local4:setTopBottom(true, true, 0, 0)
			f8_local4:setAlpha(CoD.textAlpha)
			f8_local4:setFont(CoD.fonts[CoD.WeaponButton.FontName])
			f8_local4:setAlignment(LUI.Alignment.Left)
			f8_local4.id = f8_local4.id .. ".WeaponText" .. weaponText
			f8_local4.isVisible = weaponText == 1
			if f8_local4.isVisible then
				f8_local4:setAlpha(1)
			else
				f8_local4:setAlpha(0)
			end
			weaponTextHolder:addElement(f8_local4)
			table.insert(weaponTextHolder.textList, f8_local4)
		end
	end
	weaponTextHolder.brackets = CoD.SideBracketsImage.new()
	weaponTextHolder:addElement(weaponTextHolder.brackets)
	weaponTextHolder.brackets:registerAnimationState("hide_text_brackets", {
		alpha = 0
	})
	weaponTextHolder.brackets:registerAnimationState("show_text_brackets", {
		alpha = 1
	})
	weaponTextHolder:registerEventHandler("update_text_length", CoD.WeaponButton.UpdateTextSize)
	weaponTextHolder.update = CoD.WeaponButton.UpdateTextSize
	weaponTextHolder:update()
end

CoD.WeaponButton.UpdateTextSize = function (f9_arg0)
	if f9_arg0.refText == nil and f9_arg0.textList == nil then
		return 
	elseif f9_arg0.textList == nil then
		local f9_local0, f9_local1, f9_local2, f9_local3 = GetTextDimensions(f9_arg0.refText, CoD.fonts[CoD.WeaponButton.FontName], CoD.textSize[CoD.WeaponButton.FontName])
		local f9_local4 = f9_local2 - f9_local0 + 15
		if f9_arg0.newImage then
			f9_local4 = f9_local4 + CoD.CACUtility.ButtonGridLockImageSize
		end
		f9_arg0:beginAnimation("update_text_length")
		f9_arg0:setLeftRight(false, true, -f9_local4, 0)
	else
		for f9_local3, f9_local4 in ipairs(f9_arg0.textList) do
			if f9_local4.isVisible and f9_local4.refText then
				local f9_local5, f9_local6, f9_local7, f9_local8 = GetTextDimensions(f9_local4.refText, CoD.fonts[CoD.WeaponButton.FontName], CoD.textSize[CoD.WeaponButton.FontName])
				local f9_local9 = f9_local7 - f9_local5 + 15
				if f9_arg0.newImage then
					f9_local9 = f9_local9 + CoD.CACUtility.ButtonGridLockImageSize
				end
				f9_arg0:beginAnimation("update_text_length", CoD.WeaponButton.PerkCycleFadePeriod)
				f9_arg0:setLeftRight(false, true, -f9_local9, 0)
			end
		end
	end
end

CoD.WeaponButton.WeaponSetup = function (f10_arg0)
	local f10_local0 = 35
	local f10_local1 = CoD.GetDefaultAnimationState()
	f10_local1.left = -f10_local0
	f10_local1.right = -f10_local0
	local f10_local2 = LUI.UIImage.new(f10_local1)
	f10_local2.id = f10_local2.id .. ".WeaponImage"
	LUI.UIButton.SetupElement(f10_local2)
	f10_arg0.imageHolder:addElement(f10_local2)
	f10_arg0.weaponImage = f10_local2
	f10_local2:registerAnimationState("center", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0
	})
	f10_local2:animateToState("default")
	f10_arg0.weaponType = "weapon"
end

CoD.WeaponButton.GrenadeSetup = function (f11_arg0)
	local f11_local0 = LUI.UIHorizontalList.new({
		leftAnchor = false,
		rightAnchor = true,
		left = -CoD.WeaponButton.GrenadeImageWidth * 2 + 15,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.WeaponButton.GrenadeImageHeight / 2,
		bottom = CoD.WeaponButton.GrenadeImageHeight / 2,
		alignment = LUI.Alignment.Center
	})
	f11_local0.id = f11_local0.id .. ".WeaponImage"
	LUI.UIButton.SetupElement(f11_local0)
	f11_arg0.imageHolder:addElement(f11_local0)
	f11_arg0.weaponImage = f11_local0
	
	local primaryImage = LUI.UIImage.new()
	primaryImage:setLeftRight(false, true, -CoD.WeaponButton.GrenadeImageWidth, 0)
	primaryImage:setTopBottom(false, false, -CoD.WeaponButton.GrenadeImageHeight / 2, CoD.WeaponButton.GrenadeImageHeight / 2)
	primaryImage:setAlignment(LUI.Alignment.Right)
	primaryImage.id = primaryImage.id .. ".PrimaryImage"
	f11_local0:addElement(primaryImage)
	f11_local0.primaryImage = primaryImage
	
	local specialImage = LUI.UIImage.new()
	specialImage:setLeftRight(false, true, -CoD.WeaponButton.GrenadeImageWidth, 0)
	specialImage:setTopBottom(false, false, -CoD.WeaponButton.GrenadeImageHeight / 2, CoD.WeaponButton.GrenadeImageHeight / 2)
	specialImage:setAlignment(LUI.Alignment.Right)
	specialImage.id = specialImage.id .. ".SpecialImage"
	f11_local0:addElement(specialImage)
	f11_local0.specialImage = specialImage
	
	f11_local0.weaponImageTable = {}
	f11_local0.weaponImageTable[1] = primaryImage
	f11_local0.weaponImageTable[2] = specialImage
	f11_local0:registerAnimationState("center", {
		leftAnchor = false,
		rightAnchor = false,
		left = -CoD.WeaponButton.GrenadeImageWidth / 2,
		right = CoD.WeaponButton.GrenadeImageWidth / 2,
		alignment = LUI.Alignment.Center
	})
	f11_local0:registerAnimationState("selected", {
		alpha = 1
	})
	f11_arg0.weaponType = "grenade"
end

CoD.WeaponButton.PerksSetup = function (f12_arg0)
	local f12_local0 = 3
	f12_arg0:removeElement(f12_arg0.weaponTextHolder)
	CoD.WeaponButton.AddTextElement(f12_arg0, f12_local0)
	local f12_local1 = LUI.UIHorizontalList.new({
		leftAnchor = false,
		rightAnchor = true,
		left = -CoD.WeaponButton.GrenadeImageWidth * f12_local0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.WeaponButton.GrenadeImageHeight / 2,
		bottom = CoD.WeaponButton.GrenadeImageHeight / 2,
		alignment = LUI.Alignment.Center
	})
	f12_local1.id = f12_local1.id .. ".WeaponImage"
	LUI.UIButton.SetupElement(f12_local1)
	f12_arg0.imageHolder:addElement(f12_local1)
	f12_arg0.weaponImage = f12_local1
	f12_local1.currentAlpha = CoD.WeaponButton.SelectedAlpha
	f12_local1.perkImages = {}
	for f12_local2 = 1, f12_local0, 1 do
		local f12_local5 = LUI.UIImage.new()
		f12_local5:setLeftRight(false, true, -CoD.WeaponButton.GrenadeImageWidth, 0)
		f12_local5:setTopBottom(false, false, -CoD.WeaponButton.GrenadeImageHeight / 2, CoD.WeaponButton.GrenadeImageHeight / 2)
		f12_local5.id = f12_local5.id .. "PerkImage"
		local brackets = CoD.Brackets.new(5)
		brackets:setRGB(1, 1, 1)
		if f12_local2 == 1 then
			brackets:setAlpha(f12_local1.currentAlpha)
		else
			brackets:setAlpha(0)
		end
		brackets:setPriority(100)
		f12_local5:addElement(brackets)
		f12_local5.brackets = brackets
		
		f12_local5.perkLabel = ""
		table.insert(f12_local1.perkImages, f12_local5)
		f12_local1:addElement(f12_local5)
	end
	local f12_local2 = LUI.UITimer.new(CoD.WeaponButton.PerkCyclePeriod, "cycle_perks", false, f12_arg0)
	f12_arg0:registerEventHandler("cycle_perks", CoD.WeaponButton.CyclePerksName)
	f12_local1:addElement(f12_local2)
	f12_local1:registerAnimationState("center", {
		leftAnchor = false,
		rightAnchor = false,
		left = -(CoD.WeaponButton.GrenadeImageWidth * 6) / 2,
		right = CoD.WeaponButton.GrenadeImageWidth * 6 / 2
	})
	f12_arg0.weaponType = "perks"
end

CoD.WeaponButton.CyclePerksName = function (f13_arg0, f13_arg1)
	local f13_local0 = f13_arg0.weaponTextHolder
	local f13_local1 = 0
	local f13_local2 = 0
	if f13_local0 ~= nil and f13_local0.textList ~= nil then
		if #f13_local0.textList <= 1 then
			return 
		end
		for f13_local6, f13_local7 in ipairs(f13_local0.textList) do
			if f13_local7.isVisible then
				f13_local1 = f13_local6
				f13_local2 = f13_local6 + 1
			end
		end
	end
	if #f13_local0.textList < f13_local2 then
		f13_local2 = 1
		while not f13_local0.textList[f13_local2].shouldShow and f13_local2 ~= 1 do
			f13_local2 = f13_local2 + 1
			if #f13_local0.textList < f13_local2 then
				f13_local2 = 1
			end
		end
		if f13_local1 ~= f13_local2 then
			f13_local0.textList[f13_local1]:beginAnimation("hide", CoD.WeaponButton.PerkCycleFadePeriod)
			f13_local0.textList[f13_local1]:setAlpha(0)
			f13_local0.textList[f13_local1].isVisible = false
			f13_arg0.weaponImage.perkImages[f13_local1].brackets:beginAnimation("hide", CoD.WeaponButton.PerkCycleFadePeriod)
			f13_arg0.weaponImage.perkImages[f13_local1].brackets:setAlpha(0)
			f13_local0.textList[f13_local2]:beginAnimation("show", CoD.WeaponButton.PerkCycleFadePeriod)
			f13_local0.textList[f13_local2]:setAlpha(1)
			f13_local0.textList[f13_local2].isVisible = true
			f13_arg0.weaponImage.perkImages[f13_local2].brackets:beginAnimation("show", CoD.WeaponButton.PerkCycleFadePeriod)
			f13_arg0.weaponImage.perkImages[f13_local2].brackets:setAlpha(1)
			f13_arg0.weaponImage.perkImages[f13_local2]:beginAnimation("update_alpha", CoD.WeaponButton.PerkCycleFadePeriod)
			f13_arg0.weaponImage.perkImages[f13_local2]:setAlpha(f13_arg0.weaponImage.currentAlpha)
			f13_arg0:processEvent({
				name = "update_text_length"
			})
		end
	end
end

CoD.WeaponButton.SetNewItemAvailable = function (f14_arg0, f14_arg1)
	if f14_arg0.weaponTextHolder then
		if f14_arg1 and not f14_arg0.weaponTextHolder.newImage then
			local f14_local0 = LUI.UIImage.new()
			f14_local0:setLeftRight(false, true, -CoD.CACUtility.ButtonGridNewImageWidth, 0)
			f14_local0:setTopBottom(false, false, -CoD.CACUtility.ButtonGridNewImageHeight / 2, CoD.CACUtility.ButtonGridNewImageHeight / 2)
			f14_local0:setImage(RegisterMaterial(CoD.CACUtility.NewImageMaterial))
			f14_arg0.weaponTextHolder:addElement(f14_local0)
			f14_arg0.weaponTextHolder.newImage = f14_local0
			if f14_arg0.weaponTextHolder.weaponText then
				f14_arg0.weaponTextHolder.weaponText:setLeftRight(true, true, 0, -CoD.CACUtility.ButtonGridLockImageSize)
			end
		elseif not f14_arg1 and f14_arg0.weaponTextHolder.newImage then
			f14_arg0.weaponTextHolder.newImage:close()
			f14_arg0.weaponTextHolder.newImage = nil
			if f14_arg0.weaponTextHolder.weaponText then
				f14_arg0.weaponTextHolder.weaponText:setLeftRight(true, true, 0, 0)
			end
		end
		f14_arg0.weaponTextHolder:update()
	end
end

