CoD.ContentGridButton = {}
CoD.ContentGridButton.FontName = "ExtraSmall"
CoD.ContentGridButton.TitleHeight = CoD.textSize[CoD.ContentGridButton.FontName]
CoD.ContentGridButton.InactiveAlpha = 0.4
CoD.ContentGridButton.InUseDefaultSize = {
	width = 13,
	height = 13,
	left = 7,
	top = 15
}
if CoD.isSinglePlayer then
	CoD.ContentGridButton.InactiveTextColor = CoD.visorBlue1
	CoD.ContentGridButton.InactiveTextAlpha = 1 / CoD.ContentGridButton.InactiveAlpha
else
	CoD.ContentGridButton.InactiveTextColor = CoD.offWhite
	CoD.ContentGridButton.InactiveTextAlpha = 1
end
CoD.ContentGridButton.new = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.GrowingGridButton.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	}, f1_arg1)
	f1_local0.contentIndex = f1_arg0
	f1_local0.id = f1_local0.id .. f1_arg0
	f1_local0:registerAnimationState("active", {
		alpha = 1
	})
	f1_local0:registerAnimationState("inactive", {
		alpha = CoD.ContentGridButton.InactiveAlpha
	})
	f1_local0:animateToState("active")
	f1_local0:registerEventHandler("button_action", CoD.ContentGridButton.ButtonAction)
	f1_local0:registerEventHandler("button_over", CoD.ContentGridButton.ButtonOver)
	f1_local0:registerEventHandler("button_up", CoD.ContentGridButton.LoseFocus)
	f1_local0.setBottomTitle = CoD.ContentGridButton.SetBottomTitle
	f1_local0.setHintText = CoD.ContentGridButton.SetHintText
	f1_local0.setImage = CoD.ContentGridButton.SetImage
	f1_local0.setInactive = CoD.ContentGridButton.SetInactive
	f1_local0.setInUse = CoD.ContentGridButton.SetInUse
	f1_local0.setInUseFill = CoD.ContentGridButton.SetInUseFill
	f1_local0.setLocked = CoD.ContentGridButton.SetLocked
	f1_local0.setPurchased = CoD.ContentGridButton.SetPurchased
	f1_local0.setNew = CoD.ContentGridButton.SetNew
	f1_local0.setMutuallyExclusive = CoD.ContentGridButton.SetMutuallyExclusive
	if not CoD.isSinglePlayer then
		f1_local0.setRestrictedImage = CoD.ContentGridButton.SetRestrictedImage
	end
	return f1_local0
end

CoD.ContentGridButton.ButtonAction = function (f2_arg0, f2_arg1)
	if not f2_arg0.lockImage or f2_arg0.overrideLock then
		f2_arg0:setNew(false, f2_arg1.controller)
		if CoD.isSinglePlayer == false and f2_arg0.actionSFX ~= nil then
			Engine.PlaySound(f2_arg0.actionSFX)
		end
		f2_arg0:dispatchEventToParent({
			name = "content_button_selected",
			controller = f2_arg1.controller,
			contentIndex = f2_arg0.contentIndex,
			mutuallyExclusiveIndices = f2_arg0.mutuallyExclusiveIndices,
			button = f2_arg0
		})
	elseif CoD.isSinglePlayer == true then
		Engine.PlaySound(CoD.CACUtility.denySFX)
	end
	if f2_arg0.inUseImage == nil then
		f2_arg0:dispatchEventToParent({
			name = "select_button"
		})
	else
		f2_arg0:dispatchEventToParent({
			name = "deselect_button"
		})
	end
end

CoD.ContentGridButton.ButtonOver = function (f3_arg0, f3_arg1)
	CoD.GrowingGridButton.Over(f3_arg0, f3_arg1)
	if f3_arg0.lockImage == nil then
		f3_arg0.highlight:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	else
		f3_arg0.highlight:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	end
	if f3_arg0.inUseImage == nil then
		f3_arg0:dispatchEventToParent({
			name = "select_button"
		})
	else
		f3_arg0:dispatchEventToParent({
			name = "deselect_button"
		})
	end
	if f3_arg0.background ~= nil then
		f3_arg0.background:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f3_arg0.background:setAlpha(1)
	end
	f3_arg0:dispatchEventToParent({
		name = "content_button_highlighted",
		controller = f3_arg1.controller,
		contentIndex = f3_arg0.contentIndex,
		hintText = f3_arg0.hintText,
		hintImage = f3_arg0.hintImage,
		button = f3_arg0,
		locked = f3_arg0.lockImage ~= nil
	})
end

CoD.ContentGridButton.LoseFocus = function (f4_arg0, f4_arg1)
	f4_arg0:setNew(false, f4_arg1.controller)
	f4_arg0:setInactive(f4_arg0.inactive)
	CoD.GrowingGridButton.Up(f4_arg0, f4_arg1)
	if f4_arg0.background ~= nil then
		f4_arg0.background:setRGB(CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b)
		f4_arg0.background:setAlpha(CoD.CACClassLoadout.DefaultButtonAlpha * 2)
		if f4_arg0.highlight ~= nil then
			f4_arg0.highlight:setAlpha(0)
		end
	end
	f4_arg0:dispatchEventToParent({
		name = "content_button_lose_focus",
		controller = f4_arg1.controller,
		contentIndex = f4_arg0.contentIndex
	})
end

CoD.ContentGridButton.SetBottomTitle = function (f5_arg0, f5_arg1, f5_arg2)
	if not f5_arg1 then
		if f5_arg0.itemNameText then
			f5_arg0.itemNameText:close()
			f5_arg0.itemNameText = nil
		end
		return 
	end
	local f5_local0 = CoD.textSize[CoD.ContentGridButton.FontName] * 0.85
	if CoD.isPS3 then
		f5_local0 = f5_local0 * 0.9
	end
	if not f5_arg0.itemNameText then
		if f5_arg2 == nil then
			f5_arg2 = {
				leftAnchor = true,
				rightAnchor = true,
				left = 7.5,
				right = 0,
				topAnchor = false,
				bottomAnchor = true,
				top = -f5_local0 - 15,
				bottom = -15,
				font = CoD.fonts[CoD.ContentGridButton.FontName],
				alignment = LUI.Alignment.Left
			}
		end
		f5_arg0.itemNameText = LUI.UIText.new(f5_arg2)
		f5_arg0.itemNameText:registerAnimationState("inactive", {
			red = CoD.ContentGridButton.InactiveTextColor.r,
			green = CoD.ContentGridButton.InactiveTextColor.g,
			blue = CoD.ContentGridButton.InactiveTextColor.b,
			alpha = CoD.ContentGridButton.InactiveTextAlpha
		})
		f5_arg0.itemNameText:registerAnimationState("button_over", {
			red = CoD.BOIIOrange.r,
			green = CoD.BOIIOrange.g,
			blue = CoD.BOIIOrange.b
		})
		LUI.UIButton.SetupElement(f5_arg0.itemNameText)
		f5_arg0:addElement(f5_arg0.itemNameText)
	end
	f5_arg0.itemNameText:setText(f5_arg1)
end

CoD.ContentGridButton.SetHintText = function (f6_arg0, f6_arg1, f6_arg2)
	f6_arg0.hintText = f6_arg1
	f6_arg0.hintImage = f6_arg2
end

CoD.ContentGridButton.SetImage = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)
	if f7_arg0.itemImage then
		f7_arg0.itemImage:close()
		f7_arg0.itemImage = nil
	end
	if f7_arg1 then
		if f7_arg4 then
			f7_arg0.itemImage = LUI.UIStreamedImage.new()
			f7_arg0.itemImage:setLeftRight(false, false, -f7_arg2 / 2, f7_arg2 / 2)
			f7_arg0.itemImage:setTopBottom(true, false, 5, 5 + f7_arg3)
			f7_arg0.itemImage:setImage(RegisterMaterial(f7_arg1))
			f7_arg0:addElement(f7_arg0.itemImage)
		else
			f7_arg0.itemImage = LUI.UIImage.new()
			f7_arg0.itemImage:setLeftRight(false, false, -f7_arg2 / 2, f7_arg2 / 2)
			f7_arg0.itemImage:setTopBottom(true, false, 5, 5 + f7_arg3)
			f7_arg0.itemImage:setImage(RegisterMaterial(f7_arg1))
			f7_arg0:addElement(f7_arg0.itemImage)
		end
	end
end

CoD.ContentGridButton.SetInactive = function (f8_arg0, f8_arg1)
	if f8_arg1 then
		f8_arg0:animateToState("inactive")
		f8_arg0:dispatchEventToChildren({
			name = "animate",
			animationStateName = "inactive"
		})
	else
		f8_arg0:animateToState("active")
		f8_arg0:dispatchEventToChildren({
			name = "animate",
			animationStateName = "active"
		})
	end
	f8_arg0.inactive = f8_arg1
end

CoD.ContentGridButton.SetInUse = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4, f9_arg5)
	if f9_arg0.mutuallyExclusiveIcon then
		return 
	elseif not f9_arg0.inUseBorder then
		if not f9_arg4 then
			f9_arg4 = CoD.ContentGridButton.InUseDefaultSize.width
		end
		if not f9_arg5 then
			f9_arg5 = CoD.ContentGridButton.InUseDefaultSize.height
		end
		if not f9_arg2 then
			f9_arg2 = CoD.ContentGridButton.InUseDefaultSize.left
		end
		if not f9_arg3 then
			f9_arg3 = CoD.ContentGridButton.InUseDefaultSize.top
		end
		f9_arg0.inUseBorder = LUI.UIElement.new()
		f9_arg0.inUseBorder:setLeftRight(true, false, f9_arg2, f9_arg2 + f9_arg4)
		f9_arg0.inUseBorder:setTopBottom(true, false, f9_arg3, f9_arg3 + f9_arg5)
		f9_arg0.inUseBorder:addElement(CoD.Border.new(1, CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b, 0.15))
		f9_arg0:addElement(f9_arg0.inUseBorder)
	end
	if not f9_arg1 and f9_arg0.inUseImage then
		f9_arg0.inUseImage:close()
		f9_arg0.inUseImage = nil
	elseif f9_arg1 and not f9_arg0.inUseText then
		f9_arg0.inUseImage = LUI.UIImage.new()
		if not f9_arg4 then
			f9_arg4 = CoD.ContentGridButton.InUseDefaultSize.width
		end
		if not f9_arg5 then
			f9_arg5 = CoD.ContentGridButton.InUseDefaultSize.height
		end
		if not f9_arg2 then
			f9_arg2 = CoD.ContentGridButton.InUseDefaultSize.left
		end
		if not f9_arg3 then
			f9_arg3 = CoD.ContentGridButton.InUseDefaultSize.top
		end
		f9_arg0.inUseImage:setLeftRight(true, false, f9_arg2, f9_arg2 + f9_arg4)
		f9_arg0.inUseImage:setTopBottom(true, false, f9_arg3, f9_arg3 + f9_arg5)
		f9_arg0.inUseImage:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		if not CoD.isSinglePlayer then
			f9_arg0.inUseImage:setImage(RegisterMaterial(CoD.CACUtility.EquipImageMaterial))
		end
		f9_arg0:addElement(f9_arg0.inUseImage)
	end
end

CoD.ContentGridButton.SetLocked = function (f10_arg0, f10_arg1, f10_arg2, f10_arg3)
	if not f10_arg1 and f10_arg0.lockImage then
		f10_arg0.lockImage:beginAnimation("unlocked")
		f10_arg0.lockImage:close()
		f10_arg0.lockImage = nil
		f10_arg0.itemImage:beginAnimation("unlocked")
		f10_arg0.itemImage:setAlpha(1)
		f10_arg0:setHintText(nil)
		if f10_arg0.itemNameText then
			f10_arg0.itemNameText:registerAnimationState("button_over", {
				red = CoD.trueOrange.r,
				green = CoD.trueOrange.g,
				blue = CoD.trueOrange.b
			})
		end
	elseif f10_arg1 and not f10_arg0.lockImage then
		local f10_local0 = -10
		local f10_local1, f10_local2, f10_local3 = nil
		if f10_arg3 then
			f10_local1 = CoD.CACUtility.ButtonGridBigLockImageSize
			f10_local2 = CoD.CACUtility.ButtonGridBigLockImageSize
			f10_local3 = RegisterMaterial(CoD.CACUtility.LockImageBigMaterial)
		else
			f10_local1 = CoD.CACUtility.ButtonGridLockImageSize
			f10_local2 = CoD.CACUtility.ButtonGridLockImageSize
			f10_local3 = RegisterMaterial(CoD.CACUtility.LockImageMaterial)
		end
		f10_arg0.lockImage = LUI.UIImage.new({
			leftAnchor = false,
			rightAnchor = false,
			left = -f10_local1 / 2,
			right = f10_local1 / 2,
			topAnchor = false,
			bottomAnchor = false,
			top = f10_local0 - f10_local2 / 2,
			bottom = f10_local0 + f10_local2 / 2,
			material = f10_local3,
			alpha = 1
		})
		f10_arg0.lockImage:registerAnimationState("button_over", {
			alpha = 1
		})
		f10_arg0:addElement(f10_arg0.lockImage)
		if CoD.isSinglePlayer and f10_arg0.inUseBorder ~= nil then
			f10_arg0.inUseBorder:close()
		end
		if f10_arg0.itemNameText then
			f10_arg0.itemNameText:registerAnimationState("button_over", {
				red = CoD.offWhite.r,
				green = CoD.offWhite.g,
				blue = CoD.offWhite.b
			})
		end
		f10_arg0:setInactive(true)
		LUI.UIButton.SetupElement(f10_arg0.lockImage)
		f10_arg0.itemImage:beginAnimation("locked")
		f10_arg0.itemImage:setAlpha(0)
		f10_arg0:setActionPromptString(nil)
		if CoD.isSinglePlayer then
			if f10_arg0.weaponItemIndex ~= nil then
				f10_arg0:setHintText(UIExpression.GetAttachmentUnlockString(f10_arg2, f10_arg0.weaponItemIndex, f10_arg0.attachmentNum), CoD.CACUtility.LockImageMaterial)
			elseif f10_arg0.camoItemIndex ~= nil then
				f10_arg0:setHintText(UIExpression.GetCamoUnlockString(f10_arg2, f10_arg0.statIndex), CoD.CACUtility.LockImageMaterial)
			else
				f10_arg0:setHintText(UIExpression.GetUnlockString(f10_arg2, f10_arg0.statIndex), CoD.CACUtility.LockImageMaterial)
			end
		elseif f10_arg0.weaponItemIndex == nil and f10_arg0.statIndex ~= nil and CoD.IsReward(f10_arg0.statIndex) then
			f10_arg0:setHintText(CoD.GetUnlockStringForItemIndex(f10_arg2, f10_arg0.statIndex))
		end
	end
end

CoD.ContentGridButton.SetPurchased = function (f11_arg0, f11_arg1, f11_arg2)
	if f11_arg1 and f11_arg0.tokenImage then
		f11_arg0.tokenImage:close()
		f11_arg0.tokenImage = nil
		f11_arg0:setHintText(nil)
		f11_arg0.itemImage:setAlpha(1)
		if f11_arg0.itemNameText then
			f11_arg0.itemNameText:registerAnimationState("button_over", {
				red = CoD.trueOrange.r,
				green = CoD.trueOrange.g,
				blue = CoD.trueOrange.b
			})
		end
	elseif not f11_arg1 and not f11_arg0.tokenImage then
		local f11_local0 = -(CoD.ContentGridButton.TitleHeight + 4 + 2)
		local f11_local1 = 4
		f11_arg0.tokenImage = LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = false,
			left = f11_local1,
			right = f11_local1 + 32,
			topAnchor = false,
			bottomAnchor = true,
			top = f11_local0 - 32,
			bottom = f11_local0,
			material = RegisterMaterial("menu_mp_lobby_token_64"),
			red = 1,
			green = 1,
			blue = 1,
			alpha = 1
		})
		f11_arg0.tokenImage:registerAnimationState("button_over", {
			alpha = 10
		})
		f11_arg0:addElement(f11_arg0.tokenImage)
		if f11_arg0.itemNameText then
			f11_arg0.itemNameText:registerAnimationState("button_over", {
				red = CoD.trueOrange.r,
				green = CoD.trueOrange.g,
				blue = CoD.trueOrange.b
			})
		end
		LUI.UIButton.SetupElement(f11_arg0.tokenImage)
		f11_arg0.itemImage:setAlpha(0.5)
		if CoD.isSinglePlayer ~= true then
			f11_arg0:setHintText(Engine.Localize("MPUI_UNLOCK_TOKEN_REQUIRED"))
		end
	end
end

CoD.ContentGridButton.SetMTXPurchased = function (f12_arg0, f12_arg1, f12_arg2)
	if f12_arg1 and f12_arg0.mtxImage then
		f12_arg0.mtxImage:close()
		f12_arg0.mtxImage = nil
		f12_arg0:setHintText(nil)
		if f12_arg0.dualOpticReticle then
			f12_arg0.itemImage1:setAlpha(1)
			f12_arg0.itemImage2:setAlpha(1)
		else
			f12_arg0.itemImage:setAlpha(1)
		end
		if f12_arg0.itemNameText then
			f12_arg0.itemNameText:registerAnimationState("button_over", {
				red = CoD.trueOrange.r,
				green = CoD.trueOrange.g,
				blue = CoD.trueOrange.b
			})
		end
	elseif not f12_arg1 and not f12_arg0.mtxImage then
		local f12_local0 = -(CoD.ContentGridButton.TitleHeight + 4 + 2)
		local f12_local1 = 4
		local f12_local2 = 32
		local f12_local3 = 32
		f12_arg0.mtxImage = LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = false,
			left = f12_local1,
			right = f12_local1 + f12_local2,
			topAnchor = false,
			bottomAnchor = true,
			top = f12_local0 - f12_local3 * 1.5,
			bottom = f12_local0 - f12_local3 * 0.5,
			material = RegisterMaterial("menu_purchase_unlock_token_64"),
			red = 1,
			green = 1,
			blue = 1,
			alpha = 1
		})
		f12_arg0.mtxImage:registerAnimationState("button_over", {
			alpha = 10
		})
		f12_arg0:addElement(f12_arg0.mtxImage)
		if f12_arg0.itemNameText then
			f12_arg0.itemNameText:registerAnimationState("button_over", {
				red = CoD.trueOrange.r,
				green = CoD.trueOrange.g,
				blue = CoD.trueOrange.b
			})
		end
		LUI.UIButton.SetupElement(f12_arg0.mtxImage)
		if f12_arg0.dualOpticReticle then
			f12_arg0.itemImage1:setAlpha(0.25)
			f12_arg0.itemImage2:setAlpha(0.25)
		else
			f12_arg0.itemImage:setAlpha(0.25)
		end
	end
end

CoD.ContentGridButton.SetNew = function (f13_arg0, f13_arg1, f13_arg2)
	if not f13_arg1 and f13_arg0.newImage then
		f13_arg0.newImage:close()
		f13_arg0.newImage = nil
		if not CoD.isSinglePlayer and f13_arg2 then
			if f13_arg0.eAttachment and f13_arg0.weaponOption then
				Engine.SetWeaponOptionAsOld(f13_arg2, f13_arg0.eAttachment, f13_arg0.weaponOption)
			elseif f13_arg0.weaponItemIndex and f13_arg0.weaponOption then
				Engine.SetWeaponOptionAsOld(f13_arg2, f13_arg0.weaponItemIndex, f13_arg0.weaponOption)
			elseif f13_arg0.weaponItemIndex and f13_arg0.contentIndex then
				Engine.SetAttachmentAsOld(f13_arg2, f13_arg0.weaponItemIndex, f13_arg0.contentIndex)
			end
		end
		if f13_arg2 and f13_arg0.contentIndex and f13_arg0.itemIsOld == nil then
			Engine.SetItemAsOld(f13_arg2, f13_arg0.contentIndex)
		end
	elseif f13_arg1 and not f13_arg0.newImage then
		f13_arg0.newImage = LUI.UIImage.new()
		local f13_local0 = CoD.CACUtility.ButtonGridNewImageWidth
		local f13_local1 = CoD.CACUtility.ButtonGridNewImageHeight
		if CoD.isSinglePlayer then
			f13_arg0.newImage:setLeftRight(false, true, -f13_local0 - 5, -5)
			f13_arg0.newImage:setTopBottom(true, false, 15, 15 + f13_local1)
		else
			f13_arg0.newImage:setLeftRight(true, false, 10, 10 + f13_local0)
			f13_arg0.newImage:setTopBottom(true, false, 15 - f13_local1 / 2, 15 + f13_local1 / 2)
		end
		f13_arg0.newImage:setImage(RegisterMaterial(CoD.CACUtility.NewImageMaterial))
		f13_arg0:addElement(f13_arg0.newImage)
	end
end

CoD.ContentGridButton.SetRestrictedImage = function (f14_arg0, f14_arg1)
	if f14_arg1 then
		if not f14_arg0.restrictedImage then
			if not CoD.GrowingGridButton.RestrictedMaterial then
				CoD.GrowingGridButton.RestrictedMaterial = RegisterMaterial("cac_restricted")
			end
			local f14_local0 = -(CoD.ContentGridButton.TitleHeight + 4) / 2
			local f14_local1 = 32
			f14_arg0.restrictedImage = LUI.UIImage.new()
			f14_arg0.restrictedImage:setLeftRight(false, false, -f14_local1 / 2, f14_local1 / 2)
			f14_arg0.restrictedImage:setTopBottom(false, false, f14_local0 - f14_local1 / 2, f14_local0 + f14_local1 / 2)
			f14_arg0.restrictedImage:setPriority(10)
			f14_arg0.restrictedImage:setImage(CoD.GrowingGridButton.RestrictedMaterial)
			f14_arg0:addElement(f14_arg0.restrictedImage)
		end
	elseif f14_arg0.restrictedImage then
		f14_arg0.restrictedImage:close()
		f14_arg0.restrictedImage = nil
	end
end

CoD.ContentGridButton.SetMutuallyExclusive = function (f15_arg0, f15_arg1)
	if f15_arg0.inUseBorder then
		f15_arg0.inUseBorder:close()
		f15_arg0.inUseBorder = nil
	end
	if f15_arg1 then
		if not f15_arg0.mutuallyExclusiveIcon then
			f15_arg0.mutuallyExclusiveIcon = LUI.UIImage.new()
			f15_arg0.mutuallyExclusiveIcon:setLeftRight(true, false, 7, 31)
			f15_arg0.mutuallyExclusiveIcon:setTopBottom(true, false, 15, 39)
			f15_arg0.mutuallyExclusiveIcon:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
			f15_arg0.mutuallyExclusiveIcon:setImage(RegisterMaterial(CoD.CACUtility.EquipImageMaterial))
			f15_arg0.mutuallyExclusiveIcon:setAlpha(0.5)
			f15_arg0:addElement(f15_arg0.mutuallyExclusiveIcon)
		end
		if not f15_arg0.mutuallyExclusiveIndices then
			f15_arg0.mutuallyExclusiveIndices = {
				f15_arg1
			}
		else
			table.insert(f15_arg0.mutuallyExclusiveIndices, f15_arg1)
		end
	elseif f15_arg0.mutuallyExclusiveIcon then
		f15_arg0.mutuallyExclusiveIndices = nil
		f15_arg0.mutuallyExclusiveIcon:close()
		f15_arg0.mutuallyExclusiveIcon = nil
	end
end

CoD.ContentGridButton.SetInUseFill = function (f16_arg0)
	f16_arg0:setMutuallyExclusive(f16_arg0.contentIndex)
	f16_arg0.glowGradFront:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f16_arg0.glowGradFront:setAlpha(0.2)
	f16_arg0.selectedFill:setAlpha(0.2)
	f16_arg0:setHintText(Engine.Localize("MPUI_ITEM_CURRENTLY_EQUIPPED_IN_ANOTHER_SLOT"))
	f16_arg0.mutuallyExclusiveIcon:close()
end

CoD.ContentGridButton.SetupButtonText = function (f17_arg0, f17_arg1)
	f17_arg0:setBottomTitle(f17_arg1, {
		leftAnchor = true,
		rightAnchor = true,
		left = 5,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.textSize[CoD.ContentGridButton.FontName] - 2,
		bottom = -2,
		font = CoD.fonts[CoD.ContentGridButton.FontName],
		alignment = LUI.Alignment.Left
	})
	f17_arg0.nameText = f17_arg1
end

local f0_local0 = function (f18_arg0, f18_arg1)
	f18_arg0:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f18_arg0:setAlpha(1)
	local f18_local0 = f18_arg0:getParent()
	if f18_local0 and (f18_local0.lockImage or f18_local0.isLocked) then
		f18_arg0:setRGB(1, 1, 1)
	end
end

local f0_local1 = function (f19_arg0, f19_arg1)
	f19_arg0:setRGB(1, 1, 1)
	f19_arg0:setAlpha(0.1)
end

CoD.ContentGridButton.SetupButtonImages = function (f20_arg0, f20_arg1, f20_arg2)
	if f20_arg0.grid then
		f20_arg0.grid:close()
	end
	local f20_local0 = LUI.UIImage.new()
	f20_local0:setLeftRight(true, true, 0, 0)
	f20_local0:setTopBottom(true, true, 0, 0)
	f20_local0:setRGB(0, 0, 0)
	f20_local0:setAlpha(0.3)
	f20_local0:setPriority(-110)
	f20_arg0:addElement(f20_local0)
	local f20_local1 = CoD.textSize[CoD.ContentGridButton.FontName] + 4
	local f20_local2 = 1
	local f20_local3 = LUI.UIImage.new()
	f20_local3:setLeftRight(true, true, 2, -2)
	f20_local3:setTopBottom(true, true, 1, -f20_local1 - f20_local2)
	f20_local3:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f20_local3:setRGB(0, 0, 0)
	f20_local3:setAlpha(1)
	f20_local3:setPriority(-80)
	f20_arg0:addElement(f20_local3)
	if f20_arg1 ~= nil then
		local f20_local4 = 60
		f20_arg0.glowGradBack = LUI.UIImage.new()
		f20_arg0.glowGradBack:setLeftRight(true, true, 1, -1)
		f20_arg0.glowGradBack:setTopBottom(false, true, -f20_local1 - f20_local2 - f20_local4, -f20_local1 - f20_local2)
		f20_arg0.glowGradBack:setImage(RegisterMaterial("menu_mp_cac_grad_stretch_add"))
		f20_arg0.glowGradBack:setRGB(f20_arg1.r, f20_arg1.g, f20_arg1.b)
		f20_arg0.glowGradBack:setAlpha(0.05)
		f20_arg0.glowGradBack:setPriority(-80)
		f20_arg0:addElement(f20_arg0.glowGradBack)
	end
	if f20_arg2 ~= nil then
		local f20_local4 = 30
		f20_arg0.glowGradFront = LUI.UIImage.new()
		f20_arg0.glowGradFront:setLeftRight(true, true, 1, -1)
		f20_arg0.glowGradFront:setTopBottom(false, true, -f20_local1 - f20_local2 - f20_local4, -f20_local1 - f20_local2)
		f20_arg0.glowGradFront:setImage(RegisterMaterial("menu_mp_cac_grad_stretch_add_v2"))
		f20_arg0.glowGradFront:setRGB(f20_arg2.r, f20_arg2.g, f20_arg2.b)
		f20_arg0.glowGradFront:setAlpha(0.05)
		f20_arg0.glowGradFront:setPriority(-80)
		f20_arg0:addElement(f20_arg0.glowGradFront)
	end
	local f20_local4 = LUI.UIImage.new()
	f20_local4:setLeftRight(true, true, 5, -5)
	f20_local4:setTopBottom(true, false, 4, 44)
	f20_local4:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f20_local4:setPriority(100)
	f20_local4:setAlpha(0.1)
	f20_arg0:addElement(f20_local4)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 2, -2)
	Widget:setTopBottom(false, true, -f20_local1 - f20_local2, -f20_local2)
	Widget:setPriority(-90)
	f20_arg0:addElement(Widget)
	local f20_local6 = LUI.UIImage.new()
	f20_local6:setLeftRight(true, true, 0, 0)
	f20_local6:setTopBottom(true, true, 0, 0)
	f20_local6:setRGB(0, 0, 0)
	f20_local6:setAlpha(0.8)
	Widget:addElement(f20_local6)
	local f20_local7 = LUI.UIImage.new()
	f20_local7:setLeftRight(true, true, 0, 0)
	f20_local7:setTopBottom(true, false, 0, 12)
	f20_local7:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f20_local7:setAlpha(0.1)
	Widget:addElement(f20_local7)
	f20_arg0.highlight = CoD.Border.new(1, 1, 1, 1, 0.1)
	f20_arg0.highlight:setPriority(100)
	f20_arg0.highlight:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 0
	})
	f20_arg0.highlight:registerEventHandler("button_over", f0_local0)
	f20_arg0.highlight:registerEventHandler("button_up", f0_local1)
	f20_arg0:addElement(f20_arg0.highlight)
	f20_arg0.selectedFill = LUI.UIImage.new()
	f20_arg0.selectedFill:setLeftRight(true, true, 2, -2)
	f20_arg0.selectedFill:setTopBottom(true, true, 1, -1)
	f20_arg0.selectedFill:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f20_arg0.selectedFill:setAlpha(0)
	f20_arg0.selectedFill:setPriority(-110)
	f20_arg0:addElement(f20_arg0.selectedFill)
end

CoD.ContentGridButton.CarouselSetupButtonImages = function (f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4)
	if f21_arg0.grid then
		f21_arg0.grid:close()
	end
	local f21_local0 = LUI.UIImage.new()
	f21_local0:setLeftRight(true, true, 0, 0)
	f21_local0:setTopBottom(true, true, 0, 0)
	f21_local0:setRGB(0, 0, 0)
	f21_local0:setAlpha(0.3)
	f21_local0:setPriority(-110)
	f21_arg0:addElement(f21_local0)
	f21_arg0.outline = CoD.Border.new(1, 1, 1, 1, 0.1)
	f21_arg0.outline:setPriority(-100)
	f21_arg0:addElement(f21_arg0.outline)
	local f21_local1 = 1
	local f21_local2 = CoD.textSize[CoD.ContentGridButton.FontName] + 4
	local f21_local3 = CoD.textSize[CoD.ContentGridButton.FontName] + 4
	if f21_arg1 ~= nil then
		f21_local2 = f21_arg1
	end
	if f21_arg2 ~= nil then
		f21_local3 = f21_arg2
	end
	local f21_local4 = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 2,
		right = -2,
		topAnchor = true,
		bottomAnchor = true,
		top = 1,
		bottom = -f21_local2 - f21_local1
	})
	f21_local4:registerAnimationState("button_over", {
		leftAnchor = true,
		rightAnchor = true,
		left = 2,
		right = -2,
		topAnchor = true,
		bottomAnchor = true,
		top = 1,
		bottom = -f21_local3 - f21_local1
	})
	f21_local4:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f21_local4:setRGB(0, 0, 0)
	f21_local4:setAlpha(1)
	f21_local4:setPriority(-80)
	f21_arg0:addElement(f21_local4)
	LUI.UIButton.SetupElement(f21_local4)
	if f21_arg3 ~= nil then
		local f21_local5 = 60
		f21_arg0.glowGradBack = LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 1,
			right = -1,
			topAnchor = false,
			bottomAnchor = true,
			top = -f21_local2 - f21_local1 - f21_local5,
			bottom = -f21_local2 - f21_local1
		})
		f21_arg0.glowGradBack:registerAnimationState("button_over", {
			leftAnchor = true,
			rightAnchor = true,
			left = 1,
			right = -1,
			topAnchor = false,
			bottomAnchor = true,
			top = -f21_local3 - f21_local1 - f21_local5,
			bottom = -f21_local3 - f21_local1
		})
		f21_arg0.glowGradBack:setImage(RegisterMaterial("menu_mp_cac_grad_stretch_add"))
		f21_arg0.glowGradBack:setRGB(f21_arg3.r, f21_arg3.g, f21_arg3.b)
		f21_arg0.glowGradBack:setAlpha(0.05)
		f21_arg0.glowGradBack:setPriority(-80)
		f21_arg0:addElement(f21_arg0.glowGradBack)
		LUI.UIButton.SetupElement(f21_arg0.glowGradBack)
	end
	if f21_arg4 ~= nil then
		local f21_local5 = 30
		f21_arg0.glowGradFront = LUI.UIImage.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 1,
			right = -1,
			topAnchor = false,
			bottomAnchor = true,
			top = -f21_local2 - f21_local1 - f21_local5,
			bottom = -f21_local2 - f21_local1
		})
		f21_arg0.glowGradFront:registerAnimationState("button_over", {
			leftAnchor = true,
			rightAnchor = true,
			left = 1,
			right = -1,
			topAnchor = false,
			bottomAnchor = true,
			top = -f21_local3 - f21_local1 - f21_local5,
			bottom = -f21_local3 - f21_local1
		})
		f21_arg0.glowGradFront:setImage(RegisterMaterial("menu_mp_cac_grad_stretch_add_v2"))
		f21_arg0.glowGradFront:setRGB(f21_arg4.r, f21_arg4.g, f21_arg4.b)
		f21_arg0.glowGradFront:setAlpha(0.05)
		f21_arg0.glowGradFront:setPriority(-80)
		f21_arg0:addElement(f21_arg0.glowGradFront)
		LUI.UIButton.SetupElement(f21_arg0.glowGradFront)
	end
	local f21_local5 = LUI.UIImage.new()
	f21_local5:setLeftRight(true, true, 5, -5)
	f21_local5:setTopBottom(true, false, 4, 44)
	f21_local5:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f21_local5:setPriority(100)
	f21_local5:setAlpha(0.1)
	f21_arg0:addElement(f21_local5)
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 2,
		right = -2,
		topAnchor = false,
		bottomAnchor = true,
		top = -f21_local2 - f21_local1,
		bottom = -f21_local1
	})
	Widget:registerAnimationState("button_over", {
		leftAnchor = true,
		rightAnchor = true,
		left = 2,
		right = -2,
		topAnchor = false,
		bottomAnchor = true,
		top = -f21_local3 - f21_local1,
		bottom = -f21_local1
	})
	Widget:setPriority(-90)
	f21_arg0:addElement(Widget)
	LUI.UIButton.SetupElement(Widget)
	local f21_local7 = LUI.UIImage.new()
	f21_local7:setLeftRight(true, true, 0, 0)
	f21_local7:setTopBottom(true, true, 0, 0)
	f21_local7:setRGB(0, 0, 0)
	f21_local7:setAlpha(0.8)
	Widget:addElement(f21_local7)
	local f21_local8 = LUI.UIImage.new()
	f21_local8:setLeftRight(true, true, 0, 0)
	f21_local8:setTopBottom(true, false, 0, 12)
	f21_local8:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f21_local8:setAlpha(0.1)
	Widget:addElement(f21_local8)
	f21_arg0.highlight = CoD.Border.new(1, CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b, 0)
	f21_arg0.highlight:setPriority(100)
	f21_arg0.highlight:registerAnimationState("default", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 0
	})
	f21_arg0.highlight:registerAnimationState("button_over", {
		alpha = 1
	})
	LUI.UIButton.SetupElement(f21_arg0.highlight)
	f21_arg0:addElement(f21_arg0.highlight)
end

