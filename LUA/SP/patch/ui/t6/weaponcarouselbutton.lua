require("T6.Border")
CoD.WeaponCarouselButton = {}
CoD.WeaponCarouselButton.BracketAnimTime = 0
CoD.WeaponCarouselButton.LeftEdge_Default = 10
CoD.WeaponCarouselButton.LeftEdge_Highlight = 10
CoD.WeaponCarouselButton.RightEdge_Default = -10
CoD.WeaponCarouselButton.RightEdge_Highlight = -10
CoD.WeaponCarouselButton.TopEdge_Default = 10
CoD.WeaponCarouselButton.TopEdge_Highlight = 10
CoD.WeaponCarouselButton.TopEdgeTabbed_Default = 10
CoD.WeaponCarouselButton.TopEdgeTabbed_Highlight = 10
CoD.WeaponCarouselButton.BottomEdge_Default = -10
CoD.WeaponCarouselButton.BottomEdge_Highlight = -10
CoD.WeaponCarouselButton.NewImageScale = 1.25
CoD.WeaponCarouselButton.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = f1_arg0:addNewCard()
	f1_local0.controller = f1_arg1
	f1_local0.itemIndex = f1_arg2
	f1_local0.weaponGroup = f1_arg3
	f1_local0.name = UIExpression.GetItemName(nil, f1_arg2)
	f1_local0.displayName = UIExpression.ToUpper(nil, Engine.Localize(f1_local0.name))
	f1_local0.description = Engine.Localize(UIExpression.GetItemDesc(nil, f1_arg2))
	f1_local0.id = "WeaponCarouselButton." .. f1_local0.name
	f1_local0.iconMaterial = RegisterMaterial(UIExpression.GetItemImage(nil, f1_arg2) .. "_big")
	f1_local0.icon = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 10,
		right = -10,
		topAnchor = true,
		bottomAnchor = true,
		top = 35,
		bottom = -15,
		red = 1,
		green = 1,
		blue = 1,
		material = f1_local0.iconMaterial
	})
	f1_local0:addElement(f1_local0.icon)
	f1_local0.title = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 10,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.textSize.Default - 10,
		bottom = -10,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Center
	})
	f1_local0.titleText = Engine.Localize(UIExpression.GetItemName(nil, f1_arg2))
	f1_local0.title:setText(f1_local0.titleText)
	f1_local0.title:setAlignment(LUI.Alignment.Left)
	f1_local0:addElement(f1_local0.title)
	if f1_local0.border then
		f1_local0.border:close()
	end
	if f1_local0.highlightedborder then
		f1_local0.highlightedborder:close()
	end
	f1_local0:registerAnimationState("fade_in", {
		alpha = 1
	})
	f1_local0:registerAnimationState("fade_out", {
		alpha = 0.2
	})
	f1_local0:registerAnimationState("fade_default", {
		alpha = 0.6
	})
	f1_local0.borderHolder = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	f1_local0.borderHolder:setPriority(100)
	f1_local0.leftTickAlign = -64
	f1_local0.borderHolder:registerAnimationState("big", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	f1_local0.borderHolder:registerEventHandler("card_small", CoD.WeaponCarouselButton.Border_CardSmall)
	f1_local0.borderHolder:registerEventHandler("card_big", CoD.WeaponCarouselButton.Border_CardBig)
	f1_local0:addElement(f1_local0.borderHolder)
	f1_local0.border = CoD.Border.new(1, CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b, CoD.CACClassLoadout.DefaultButtonAlpha, -1)
	f1_local0:addElement(f1_local0.border)
	if CoD.isSinglePlayer then
		local f1_local1 = LUI.UIImage.new()
		f1_local1:setTopBottom(true, true, 0, 0)
		f1_local1:setLeftRight(true, true, 0, 0)
		f1_local1:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
		f1_local1:setRGB(CoD.CACClassLoadout.DefaultBackgroundColor.r, CoD.CACClassLoadout.DefaultBackgroundColor.g, CoD.CACClassLoadout.DefaultBackgroundColor.b)
		f1_local1:setAlpha(CoD.CACClassLoadout.DefaultBackgroundAlpha)
		f1_local0.backgroundGradient = f1_local1
		f1_local0:addElement(f1_local1)
	end
	f1_local0:registerEventHandler("gain_focus", CoD.WeaponCarouselButton.GainFocus)
	f1_local0:registerEventHandler("lose_focus", CoD.WeaponCarouselButton.LoseFocus)
	f1_local0.setLocked = CoD.WeaponCarouselButton.SetLocked
	f1_local0.setNew = CoD.WeaponCarouselButton.SetNew
	f1_local0.setInUse = CoD.WeaponCarouselButton.SetInUse
	f1_local0.setRecommended = CoD.WeaponCarouselButton.SetRecommended
	f1_local0.setHintText = CoD.WeaponCarouselButton.SetHintText
	return f1_local0
end

CoD.WeaponCarouselButton.Border_CardSmall = function (f2_arg0, f2_arg1)
	f2_arg0:animateToState("default")
	f2_arg0:dispatchEventToChildren({
		name = "animate",
		animationStateName = "default"
	})
end

CoD.WeaponCarouselButton.Border_CardBig = function (f3_arg0, f3_arg1)
	f3_arg0:animateToState("big")
	f3_arg0:dispatchEventToChildren({
		name = "animate",
		animationStateName = "big"
	})
end

CoD.WeaponCarouselButton.GainFocus = function (f4_arg0, f4_arg1)
	f4_arg1.hintText = f4_arg0.hintText
	CoD.CardCarousel.Card_GainFocus(f4_arg0, f4_arg1)
	if f4_arg0.border ~= nil then
		f4_arg0.border:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f4_arg0.border:setAlpha(1)
		local f4_local0 = LUI.UIImage.new()
		f4_local0:setLeftRight(true, true, -63, 65)
		f4_local0:setTopBottom(true, true, -7, 8)
		f4_local0:setImage(RegisterMaterial("menu_mp_cac_caro_weapon_hl"))
		f4_arg0:addElement(f4_local0)
		f4_arg0.highlight = f4_local0
	end
	if not f4_arg0.lockImage then
		f4_arg0.title:beginAnimation("highlight", CoD.WeaponCarouselButton.BracketAnimTime)
		f4_arg0.title:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	end
	CoD.WeaponCarouselButton.Lock_Selected(f4_arg0.lockImage, CoD.WeaponCarouselButton.BracketAnimTime)
	CoD.WeaponCarouselButton.New_Selected(f4_arg0.newImage, CoD.WeaponCarouselButton.BracketAnimTime)
	CoD.WeaponCarouselButton.Equip_Selected(f4_arg0.inUseImage, CoD.WeaponCarouselButton.BracketAnimTime, locked)
	CoD.WeaponCarouselButton.Recommended_Selected(f4_arg0.recommendedText, CoD.WeaponCarouselButton.BracketAnimTime)
end

CoD.WeaponCarouselButton.LoseFocus = function (f5_arg0, f5_arg1)
	if f5_arg0.newImage then
		Engine.SetItemAsOld(f5_arg0.controller, f5_arg0.itemIndex)
		f5_arg0:setNew(false)
	end
	CoD.CardCarousel.Card_LoseFocus(f5_arg0, f5_arg1)
	if f5_arg0.border ~= nil then
		f5_arg0.border:setRGB(CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b)
		f5_arg0.border:setAlpha(CoD.CACClassLoadout.DefaultButtonAlpha)
		if f5_arg0.highlight ~= nil then
			f5_arg0.highlight:close()
		end
	end
	f5_arg0.title:beginAnimation("unhighlight", CoD.WeaponCarouselButton.BracketAnimTime)
	f5_arg0.title:setRGB(CoD.DefaultTextColor.r, CoD.DefaultTextColor.g, CoD.DefaultTextColor.b)
	CoD.WeaponCarouselButton.Lock_NotSelected(f5_arg0.lockImage, CoD.WeaponCarouselButton.BracketAnimTime)
	CoD.WeaponCarouselButton.Equip_NotSelected(f5_arg0.inUseImage, CoD.WeaponCarouselButton.BracketAnimTime, locked)
	CoD.WeaponCarouselButton.Recommended_NotSelected(f5_arg0.recommendedText, CoD.WeaponCarouselButton.BracketAnimTime)
end

CoD.WeaponCarouselButton.SetLocked = function (f6_arg0, f6_arg1)
	if not f6_arg1 and f6_arg0.lockImage then
		f6_arg0.lockImage:close()
		f6_arg0.lockImage = nil
	elseif f6_arg1 and not f6_arg0.lockImage then
		if f6_arg0.inUseImage ~= nil then
			f6_arg0.inUseImage:close()
		end
		local f6_local0 = 5
		f6_arg0.lockImage = LUI.UIImage.new()
		CoD.WeaponCarouselButton.Lock_NotSelected(f6_arg0.lockImage, 0)
		f6_arg0.borderHolder:addElement(f6_arg0.lockImage)
		LUI.UIButton.SetupElement(f6_arg0.lockImage)
		f6_arg0:setHintText(UIExpression.GetUnlockString(f6_arg0.controller, f6_arg0.itemIndex), CoD.CACUtility.LockImageMaterial)
		if f6_arg0.icon then
			f6_arg0.icon:beginAnimation("inactive")
			f6_arg0.icon:setAlpha(0.25)
		end
	end
end

CoD.WeaponCarouselButton.Lock_NotSelected = function (f7_arg0, f7_arg1)
	if not f7_arg0 then
		return 
	else
		local f7_local0 = CoD.CACUtility.ButtonGridLockImageSize
		local f7_local1 = CoD.CACUtility.ButtonGridLockImageSize
		local f7_local2 = CoD.WeaponCarouselButton.RightEdge_Default
		local f7_local3 = CoD.WeaponCarouselButton.TopEdgeTabbed_Default
		f7_arg0:beginAnimation("not_selected", f7_arg1)
		f7_arg0:setLeftRight(false, true, f7_local2 - f7_local0, f7_local2)
		f7_arg0:setTopBottom(true, false, f7_local3, f7_local3 + f7_local1)
		f7_arg0:setImage(RegisterMaterial(CoD.CACUtility.LockImageMaterial))
		f7_arg0:setRGB(1, 1, 1)
	end
end

CoD.WeaponCarouselButton.Lock_Selected = function (f8_arg0, f8_arg1)
	if not f8_arg0 then
		return 
	else
		local f8_local0 = CoD.CACUtility.ButtonGridLockImageSize
		local f8_local1 = CoD.CACUtility.ButtonGridLockImageSize
		local f8_local2 = CoD.WeaponCarouselButton.RightEdge_Highlight
		local f8_local3 = CoD.WeaponCarouselButton.TopEdgeTabbed_Highlight
		f8_arg0:beginAnimation("selected", f8_arg1)
		f8_arg0:setLeftRight(false, true, f8_local2 - f8_local0, f8_local2)
		f8_arg0:setTopBottom(true, false, f8_local3, f8_local3 + f8_local1)
		f8_arg0:setImage(RegisterMaterial(CoD.CACUtility.LockImageMaterial))
	end
end

CoD.WeaponCarouselButton.SetNew = function (f9_arg0, f9_arg1)
	if not f9_arg1 and f9_arg0.newImage then
		f9_arg0.newImage:close()
		f9_arg0.newImage = nil
	elseif f9_arg1 and not f9_arg0.newImage then
		local f9_local0 = 5
		f9_arg0.newImage = LUI.UIImage.new()
		CoD.WeaponCarouselButton.New_NotSelected(f9_arg0.newImage, 0)
		f9_arg0.borderHolder:addElement(f9_arg0.newImage)
		LUI.UIButton.SetupElement(f9_arg0.newImage)
	end
end

CoD.WeaponCarouselButton.New_NotSelected = function (f10_arg0, f10_arg1)
	if not f10_arg0 then
		return 
	else
		local f10_local0 = CoD.CACUtility.ButtonGridNewImageWidth * CoD.WeaponCarouselButton.NewImageScale
		local f10_local1 = CoD.CACUtility.ButtonGridNewImageHeight * CoD.WeaponCarouselButton.NewImageScale
		local f10_local2 = CoD.WeaponCarouselButton.RightEdge_Default
		local f10_local3 = CoD.WeaponCarouselButton.TopEdgeTabbed_Default
		f10_arg0:beginAnimation("not_selected", f10_arg1)
		f10_arg0:setLeftRight(false, true, f10_local2 - f10_local0, f10_local2)
		f10_arg0:setTopBottom(true, false, f10_local3, f10_local3 + f10_local1)
		f10_arg0:setImage(RegisterMaterial(CoD.CACUtility.NewImageMaterial))
	end
end

CoD.WeaponCarouselButton.New_Selected = function (f11_arg0, f11_arg1)
	if not f11_arg0 then
		return 
	else
		local f11_local0 = CoD.CACUtility.ButtonGridNewImageWidth * CoD.WeaponCarouselButton.NewImageScale
		local f11_local1 = CoD.CACUtility.ButtonGridNewImageHeight * CoD.WeaponCarouselButton.NewImageScale
		local f11_local2 = CoD.WeaponCarouselButton.RightEdge_Highlight
		local f11_local3 = CoD.WeaponCarouselButton.TopEdgeTabbed_Highlight
		f11_arg0:beginAnimation("selected", f11_arg1)
		f11_arg0:setLeftRight(false, true, f11_local2 - f11_local0, f11_local2)
		f11_arg0:setTopBottom(true, false, f11_local3, f11_local3 + f11_local1)
		f11_arg0:setImage(RegisterMaterial(CoD.CACUtility.NewImageMaterial))
	end
end

CoD.WeaponCarouselButton.SetInUse = function (f12_arg0, f12_arg1)
	if f12_arg0.inUseImage ~= nil then
		f12_arg0.inUseImage:close()
	end
	local Widget = LUI.UIElement.new()
	CoD.WeaponCarouselButton.Equip_NotSelected(Widget, 0)
	f12_arg0.inUseImage = Widget
	f12_arg0.borderHolder:addElement(f12_arg0.inUseImage)
	LUI.UIButton.SetupElement(f12_arg0.inUseImage)
	if f12_arg1 ~= nil and f12_arg1 then
		f12_arg0:setHintText(Engine.Localize("SPUI_ITEM_CURRENTLY_EQUIPPED"), CoD.CACUtility.EquipImageMaterial)
		local f12_local1 = LUI.UIImage.new()
		f12_local1:setLeftRight(true, true, 0, 0)
		f12_local1:setTopBottom(true, true, 0, 0)
		f12_local1:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f12_arg0.inUseImage:addElement(f12_local1)
	else
		f12_arg0.inUseImage:addElement(CoD.Border.new(1, CoD.CACClassLoadout.DefaultButtonBorderColor.r, CoD.CACClassLoadout.DefaultButtonBorderColor.g, CoD.CACClassLoadout.DefaultButtonBorderColor.b, CoD.CACClassLoadout.DefaultButtonAlpha, 0))
	end
end

CoD.WeaponCarouselButton.Equip_NotSelected = function (f13_arg0, f13_arg1)
	if not f13_arg0 then
		return 
	else
		local f13_local0 = CoD.CACUtility.ButtonGridLockImageSize
		local f13_local1 = CoD.CACUtility.ButtonGridLockImageSize
		local f13_local2 = CoD.WeaponCarouselButton.LeftEdge_Default
		local f13_local3 = CoD.WeaponCarouselButton.TopEdge_Default
		f13_arg0:beginAnimation("selected", f13_arg1)
		f13_arg0:setLeftRight(true, false, f13_local2, f13_local2 + f13_local0 * 0.75)
		f13_arg0:setTopBottom(true, false, f13_local3, f13_local3 + f13_local1 * 0.75)
	end
end

CoD.WeaponCarouselButton.Equip_Selected = function (f14_arg0, f14_arg1)
	if not f14_arg0 then
		return 
	else
		local f14_local0 = CoD.CACUtility.ButtonGridLockImageSize
		local f14_local1 = CoD.CACUtility.ButtonGridLockImageSize
		local f14_local2 = CoD.WeaponCarouselButton.LeftEdge_Highlight
		local f14_local3 = CoD.WeaponCarouselButton.TopEdge_Highlight
		f14_arg0:beginAnimation("selected", f14_arg1)
		f14_arg0:setLeftRight(true, false, f14_local2, f14_local2 + f14_local0)
		f14_arg0:setTopBottom(true, false, f14_local3, f14_local3 + f14_local1)
	end
end

CoD.WeaponCarouselButton.SetRecommended = function (f15_arg0, f15_arg1)
	if not f15_arg1 and f15_arg0.recommendedText then
		f15_arg0.recommendedText:close()
		f15_arg0.recommendedText = nil
	elseif f15_arg1 and not f15_arg0.recommendedText then
		f15_arg0.recommendedText = LUI.UIText.new()
		f15_arg0.recommendedText:setAlignment(LUI.Alignment.Left)
		f15_arg0.recommendedText:setText(Engine.Localize("SPUI_RECOMMENDED"))
		CoD.WeaponCarouselButton.Recommended_NotSelected(f15_arg0.recommendedText, 0)
		f15_arg0.borderHolder:addElement(f15_arg0.recommendedText)
		LUI.UIButton.SetupElement(f15_arg0.recommendedText)
	end
end

CoD.WeaponCarouselButton.Recommended_NotSelected = function (f16_arg0, f16_arg1)
	if not f16_arg0 then
		return 
	else
		local f16_local0 = CoD.textSize.ExtraSmall
		local f16_local1 = CoD.WeaponCarouselButton.RightEdge_Default
		local f16_local2 = CoD.WeaponCarouselButton.TopEdge_Default
		f16_arg0:beginAnimation("not_selected", f16_arg1)
		f16_arg0:setLeftRight(true, true, CoD.WeaponCarouselButton.LeftEdge_Default * 1.5 + CoD.CACUtility.ButtonGridLockImageSize * 0.75, f16_local1)
		f16_arg0:setTopBottom(true, false, f16_local2 * 0.75, f16_local2 * 0.75 + f16_local0)
		f16_arg0:setFont(CoD.fonts.ExtraSmall)
		f16_arg0:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	end
end

CoD.WeaponCarouselButton.Recommended_Selected = function (f17_arg0, f17_arg1)
	if not f17_arg0 then
		return 
	else
		local f17_local0 = CoD.textSize.Default
		local f17_local1 = CoD.WeaponCarouselButton.RightEdge_Highlight
		local f17_local2 = CoD.WeaponCarouselButton.TopEdge_Highlight
		f17_arg0:beginAnimation("selected", f17_arg1)
		f17_arg0:setLeftRight(true, true, CoD.WeaponCarouselButton.LeftEdge_Highlight * 2 + CoD.CACUtility.ButtonGridLockImageSize, f17_local1)
		f17_arg0:setTopBottom(true, false, f17_local2 * 0.75, f17_local2 * 0.75 + f17_local0)
		f17_arg0:setFont(CoD.fonts.Default)
		f17_arg0:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	end
end

CoD.WeaponCarouselButton.SetHintText = function (f18_arg0, f18_arg1)
	f18_arg0.hintText = f18_arg1
end

