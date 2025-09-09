CoD.GrowingGridButton = {}
CoD.GrowingGridButton.BackgroundMaterialName = "blue_square_glow"
CoD.GrowingGridButton.GridTilesMaterialName = "menu_mp_cac_grid_pattern"
CoD.GrowingGridButton.GrowAmount = 10
CoD.GrowingGridButton.GrowDuration = 150
CoD.GrowingGridButton.InnerBorder = 5
CoD.GrowingGridButton.RenderPriority = 100
CoD.GrowingGridButton.ShrinkDuration = CoD.GrowingGridButton.GrowDuration
CoD.GrowingGridButton.TitleFontName = "ExtraSmall"
CoD.GrowingGridButton.TitleFont = CoD.fonts[CoD.GrowingGridButton.TitleFontName]
CoD.GrowingGridButton.TitleFontHeight = CoD.textSize[CoD.GrowingGridButton.TitleFontName]
CoD.GrowingGridButton.SubtitleFontName = "ExtraSmall"
CoD.GrowingGridButton.SubtitleFont = CoD.fonts[CoD.GrowingGridButton.SubtitleFontName]
CoD.GrowingGridButton.SubtitleFontHeight = CoD.textSize[CoD.GrowingGridButton.SubtitleFontName]
CoD.GrowingGridButton.SubtitleTop = CoD.GrowingGridButton.TitleFontHeight
CoD.GrowingGridButton.Subtitle2Top = CoD.GrowingGridButton.SubtitleTop + CoD.GrowingGridButton.SubtitleFontHeight
CoD.GrowingGridButton.Subtitle3Top = CoD.GrowingGridButton.Subtitle2Top + CoD.GrowingGridButton.SubtitleFontHeight
if CoD.isSinglePlayer then
	CoD.GrowingGridButton.TitleColor = CoD.visorBlue2
	CoD.GrowingGridButton.TitleAlpha = 1
else
	CoD.GrowingGridButton.TitleColor = CoD.offWhite
	CoD.GrowingGridButton.TitleAlpha = 0.5
end
CoD.GrowingGridButton.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	f1_arg0.zoom = 0
	if f1_arg3 == nil then
		if CoD.isSinglePlayer then
			f1_arg3 = 15
		else
			f1_arg3 = 40
		end
	end
	local f1_local0 = LUI.UIButton.new(f1_arg0, f1_arg2)
	f1_local0.id = "GrowingGridButton"
	f1_local0:registerAnimationState("button_over", {
		zoom = f1_arg3
	})
	if f1_arg1 then
		f1_arg1(f1_local0)
	else
		CoD.GrowingGridButton.SetupElements(f1_local0)
	end
	if CoD.isSinglePlayer then
		local f1_local1 = LUI.UIImage.new()
		f1_local1:setTopBottom(true, true, 0, 0)
		f1_local1:setLeftRight(true, true, 0, 0)
		f1_local1:setImage(RegisterMaterial(CoD.MPZM("menu_mp_cac_grad_stretch", "menu_zm_cac_grad_stretch")))
		f1_local1:setRGB(CoD.CACClassLoadout.DefaultBackgroundColor.r, CoD.CACClassLoadout.DefaultBackgroundColor.g, CoD.CACClassLoadout.DefaultBackgroundColor.b)
		f1_local1:setAlpha(CoD.CACClassLoadout.DefaultBackgroundAlpha)
		f1_local0.backgroundGradient = f1_local1
		f1_local0:addElement(f1_local1)
	end
	f1_local0.overDuration = CoD.GrowingGridButton.GrowDuration
	f1_local0.overEaseIn = true
	f1_local0.overEaseOut = true
	f1_local0.upDuration = CoD.GrowingGridButton.ShrinkDuration
	f1_local0.upEaseIn = true
	f1_local0.upEaseOut = true
	f1_local0.addToBody = CoD.GrowingGridButton.AddToBody
	f1_local0.setNew = CoD.GrowingGridButton.SetNew
	f1_local0.setTitle = CoD.GrowingGridButton.SetTitle
	f1_local0.setSubtitle = CoD.GrowingGridButton.SetSubtitle
	f1_local0.setSubtitle2 = CoD.GrowingGridButton.SetSubtitle2
	f1_local0.setSubtitle3 = CoD.GrowingGridButton.SetSubtitle3
	f1_local0.highlightSubtitle = CoD.GrowingGridButton.HighlightSubtitle
	f1_local0.setHintText = CoD.GrowingGridButton.SetHintText
	f1_local0.addUnequipPrompt = CoD.GrowingGridButton.AddUnequipPrompt
	f1_local0.removeUnequipPrompt = CoD.GrowingGridButton.RemoveUnequipPrompt
	f1_local0.handleUnequipPrompt = CoD.GrowingGridButton.ButtonPromptUnequip
	f1_local0.setRestrictedImage = CoD.GrowingGridButton.SetRestrictedImage
	f1_local0.setLockedImage = CoD.GrowingGridButton.SetLockedImage
	f1_local0.setUnpurchasedImage = CoD.GrowingGridButton.SetUnpurchasedImage
	f1_local0:registerEventHandler("button_over", CoD.GrowingGridButton.Over)
	f1_local0:registerEventHandler("button_up", CoD.GrowingGridButton.Up)
	return f1_local0
end

CoD.GrowingGridButton.AddToBody = function (f2_arg0, f2_arg1)
	f2_arg0.body:addElement(f2_arg1)
end

CoD.GrowingGridButton.SetupElements = function (f3_arg0)
	f3_arg0.grid = LUI.UIImage.new()
	f3_arg0.grid:setLeftRight(true, true, 0, 0)
	f3_arg0.grid:setTopBottom(true, true, 0, 0)
	f3_arg0.grid:setRGB(0.3, 0.3, 0.3)
	f3_arg0.grid:setAlpha(0.1)
	f3_arg0:addElement(f3_arg0.grid)
	f3_arg0.body = LUI.UIElement.new()
	f3_arg0.body:setLeftRight(true, true, CoD.GrowingGridButton.InnerBorder, -CoD.GrowingGridButton.InnerBorder)
	f3_arg0.body:setTopBottom(true, true, CoD.GrowingGridButton.InnerBorder, -CoD.GrowingGridButton.InnerBorder)
	f3_arg0:addElement(f3_arg0.body)
	f3_arg0.body:registerAnimationState("small", {
		leftAnchor = true,
		rightAnchor = true,
		left = 100,
		right = -CoD.GrowingGridButton.InnerBorder,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.GrowingGridButton.InnerBorder,
		bottom = -CoD.GrowingGridButton.InnerBorder
	})
	if CoD.isSinglePlayer == true then
		f3_arg0.border = CoD.Border.new(2, 1, 1, 1, 0)
		f3_arg0.border:setPriority(100)
		f3_arg0:addElement(f3_arg0.border)
		f3_arg0.border:registerAnimationState("button_over", {
			alpha = 1
		})
	end
	f3_arg0.brackets = CoD.Brackets.new(12, CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	f3_arg0.brackets:setPriority(100)
	f3_arg0:addElement(f3_arg0.brackets)
	f3_arg0.brackets:registerAnimationState("hide", {
		alpha = 0
	})
	f3_arg0.brackets:animateToState("hide")
	f3_arg0.brackets:registerAnimationState("show", {
		alpha = 1
	})
end

CoD.GrowingGridButton.SetNew = function (f4_arg0, f4_arg1)
	if CoD.isSinglePlayer then
		if f4_arg0.titleText == nil then
			return 
		elseif f4_arg1 and not f4_arg0.newIcon then
			local f4_local0, f4_local1, f4_local2, f4_local3 = GetTextDimensions(f4_arg0.titleText, CoD.GrowingGridButton.TitleFont, CoD.GrowingGridButton.TitleFontHeight)
			local f4_local4 = CoD.CACUtility.ButtonGridNewImageWidth
			local newIcon = CoD.CACUtility.ButtonGridNewImageHeight
			local f4_local6 = 0
			local f4_local7 = f4_local2 - f4_local0
			local f4_local8 = f4_local1 - f4_local3
			local f4_local9 = f4_local7 + 10
			f4_local4 = f4_local4 * f4_local8 / newIcon
			newIcon = f4_local8
			
			local newIcon = LUI.UIImage.new()
			newIcon:setLeftRight(true, false, f4_local9, f4_local9 + f4_local4)
			newIcon:setTopBottom(true, false, f4_local6, f4_local6 + newIcon)
			newIcon:setImage(RegisterMaterial(CoD.CACUtility.NewImageMaterial))
			f4_arg0:addElement(newIcon)
			f4_arg0.newIcon = newIcon
			
		elseif not f4_arg1 and f4_arg0.newIcon then
			f4_arg0.newIcon:close()
			f4_arg0.newIcon = nil
		end
	elseif f4_arg1 then
		if not f4_arg0.newIcon then
			local f4_local0 = 0
			if f4_arg0.titleText then
				local f4_local1, f4_local2, f4_local3, f4_local4 = GetTextDimensions(f4_arg0.titleText, CoD.GrowingGridButton.TitleFont, CoD.GrowingGridButton.TitleFontHeight)
				f4_local0 = f4_local3 - f4_local1
			end
			local f4_local1 = CoD.CACUtility.ButtonGridNewImageWidth
			local f4_local2 = CoD.CACUtility.ButtonGridNewImageHeight
			local f4_local3 = 10
			local f4_local4 = f4_local0 + 10
			
			local newIcon = LUI.UIImage.new()
			newIcon:setLeftRight(true, false, f4_local4, f4_local4 + f4_local1)
			newIcon:setTopBottom(true, false, f4_local3 - f4_local2 / 2, f4_local3 + f4_local2 / 2)
			newIcon:setImage(RegisterMaterial(CoD.CACUtility.NewImageMaterial))
			f4_arg0:addElement(newIcon)
			f4_arg0.newIcon = newIcon
			
		end
	elseif f4_arg0.newIcon then
		f4_arg0.newIcon:close()
		f4_arg0.newIcon = nil
	end
end

CoD.GrowingGridButton.SetTitle = function (f5_arg0, f5_arg1)
	if f5_arg1 then
		if not f5_arg0.title then
			f5_arg0.title = LUI.UIText.new({
				leftAnchor = true,
				rightAnchor = false,
				left = CoD.GrowingGridButton.InnerBorder,
				right = CoD.GrowingGridButton.InnerBorder,
				topAnchor = false,
				bottomAnchor = false,
				top = -CoD.GrowingGridButton.TitleFontHeight / 2,
				bottom = CoD.GrowingGridButton.TitleFontHeight / 2,
				font = CoD.GrowingGridButton.TitleFont,
				red = CoD.GrowingGridButton.TitleColor.r,
				green = CoD.GrowingGridButton.TitleColor.g,
				blue = CoD.GrowingGridButton.TitleColor.b,
				alpha = CoD.GrowingGridButton.TitleAlpha
			})
			f5_arg0.title:registerAnimationState("top", {
				topAnchor = true,
				bottomAnchor = false,
				top = 0,
				bottom = CoD.GrowingGridButton.TitleFontHeight
			})
			f5_arg0:addElement(f5_arg0.title)
		end
		f5_arg0.title:setText(f5_arg1)
	elseif f5_arg0.title then
		f5_arg0.title:close()
		f5_arg0.title = nil
	end
	f5_arg0.titleText = f5_arg1
	CoD.GrowingGridButton.UpdateLayout(f5_arg0)
end

CoD.GrowingGridButton.UpdateLayout = function (f6_arg0)
	if f6_arg0.title then
		if f6_arg0.subtitle or f6_arg0.subtitle2 or f6_arg0.subtitle3 then
			f6_arg0.title:animateToState("top")
		else
			f6_arg0.title:animateToState("default")
		end
	end
	if f6_arg0.title or f6_arg0.subtitle or f6_arg0.subtitle2 then
		f6_arg0.body:animateToState("small")
	end
end

CoD.GrowingGridButton.AddUnequipPrompt = function (f7_arg0)
	if CoD.useMouse then
		CoD.GrowingGridButton.AddUnequipButton(f7_arg0)
	end
	f7_arg0:registerEventHandler("button_prompt_unequip", f7_arg0.handleUnequipPrompt)
	f7_arg0:dispatchEventToParent({
		name = "add_unequip_button"
	})
end

CoD.GrowingGridButton.RemoveUnequipPrompt = function (f8_arg0)
	if CoD.useMouse then
		CoD.GrowingGridButton.RemoveUnequipButton(f8_arg0)
	end
	f8_arg0:registerEventHandler("button_prompt_unequip", CoD.NullFunction)
	f8_arg0:dispatchEventToParent({
		name = "remove_unequip_button"
	})
end

CoD.GrowingGridButton.ButtonPromptUnequip = function (f9_arg0, f9_arg1)
	f9_arg0:removeUnequipPrompt()
	f9_arg0:dispatchEventToParent({
		name = "item_unequipped"
	})
end

CoD.GrowingGridButton.AddUnequipButton = function (f10_arg0)
	if f10_arg0.unequipButtonSize == nil then
		return 
	end
	local f10_local0 = f10_arg0.unequipButtonSize
	if f10_arg0.unequipButton == nil then
		local f10_local1 = 0
		local f10_local2 = 0
		local f10_local3 = 0
		if f10_arg0.topBorderOffset ~= nil then
			f10_local1 = f10_arg0.topBorderOffset
		end
		if f10_arg0.rightBorderOffset ~= nil then
			f10_local2 = f10_arg0.rightBorderOffset
		end
		f10_arg0.unequipButton = CoD.MouseButton.new({
			leftAnchor = false,
			rightAnchor = true,
			left = -f10_local2 - f10_local0,
			right = -f10_local2,
			topAnchor = true,
			bottomAnchor = false,
			top = f10_local1,
			bottom = f10_local1 + f10_local0
		}, "^BBUTTON_MOUSE_CLICK^", "^BBUTTON_MOUSE_CLICK_ACTIVE^")
		f10_arg0.unequipButton:setExpansionScale()
		f10_arg0.unequipButton:setActionEventName("button_prompt_unequip")
		if f10_arg0.zoomOffset ~= nil then
			f10_arg0.unequipButton:setupButtonImage(-f10_arg0.zoomOffset, 0)
		end
	end
	f10_arg0:addElement(f10_arg0.unequipButton)
end

CoD.GrowingGridButton.RemoveUnequipButton = function (f11_arg0)
	if f11_arg0.unequipButton ~= nil then
		f11_arg0.unequipButton:close()
		f11_arg0.unequipButton = nil
		f11_arg0:setHandleMouseButton(true)
	end
end

CoD.GrowingGridButton.SetSubtitle = function (f12_arg0, f12_arg1)
	if f12_arg1 then
		if not f12_arg0.subtitle then
			f12_arg0.subtitle = LUI.UIText.new({
				leftAnchor = true,
				rightAnchor = false,
				left = CoD.GrowingGridButton.InnerBorder,
				right = CoD.GrowingGridButton.InnerBorder,
				topAnchor = true,
				bottomAnchor = false,
				top = CoD.GrowingGridButton.SubtitleTop,
				bottom = CoD.GrowingGridButton.SubtitleTop + CoD.GrowingGridButton.SubtitleFontHeight,
				font = CoD.GrowingGridButton.SubtitleFont
			})
			f12_arg0:addElement(f12_arg0.subtitle)
		end
		f12_arg0.subtitle:setText(f12_arg1)
	elseif f12_arg0.subtitle then
		f12_arg0.subtitle:close()
		f12_arg0.subtitle = nil
		f12_arg0.subtitleContainer:close()
		f12_arg0.subtitleContainer = nil
	end
	CoD.GrowingGridButton.UpdateLayout(f12_arg0)
end

CoD.GrowingGridButton.SetPrimaryWeaponSubtitle = function (f13_arg0, f13_arg1)
	if f13_arg1 then
		if f13_arg0.subtitle then
			f13_arg0.subtitle:close()
			f13_arg0.subtitle = nil
		end
		f13_arg0.subtitle = LUI.UIText.new({
			leftAnchor = true,
			rightAnchor = false,
			left = CoD.GrowingGridButton.InnerBorder + 5,
			right = CoD.GrowingGridButton.InnerBorder,
			topAnchor = false,
			bottomAnchor = true,
			top = -CoD.GrowingGridButton.InnerBorder - CoD.textSize.Condensed,
			bottom = -CoD.GrowingGridButton.InnerBorder,
			font = CoD.fonts.Condensed
		})
		f13_arg0:addElement(f13_arg0.subtitle)
		f13_arg0.subtitle:setText(f13_arg1)
	elseif f13_arg0.subtitle then
		f13_arg0.subtitle:close()
		f13_arg0.subtitle = nil
	end
	CoD.GrowingGridButton.UpdateLayout(f13_arg0)
end

CoD.GrowingGridButton.SetSecondaryWeaponSubtitle = function (f14_arg0, f14_arg1)
	if f14_arg1 then
		if f14_arg0.subtitle then
			f14_arg0.subtitle:close()
			f14_arg0.subtitle = nil
		end
		f14_arg0.subtitle = LUI.UIText.new({
			leftAnchor = true,
			rightAnchor = false,
			left = CoD.GrowingGridButton.InnerBorder + 5,
			right = CoD.GrowingGridButton.InnerBorder,
			topAnchor = false,
			bottomAnchor = true,
			top = -CoD.GrowingGridButton.InnerBorder - CoD.textSize.Condensed,
			bottom = -CoD.GrowingGridButton.InnerBorder,
			font = CoD.fonts.Condensed
		})
		f14_arg0:addElement(f14_arg0.subtitle)
		f14_arg0.subtitle:setText(f14_arg1)
	elseif f14_arg0.subtitle then
		f14_arg0.subtitle:close()
		f14_arg0.subtitle = nil
	end
	CoD.GrowingGridButton.UpdateLayout(f14_arg0)
end

CoD.GrowingGridButton.SetSubtitle2 = function (f15_arg0, f15_arg1)
	if f15_arg1 then
		if not f15_arg0.subtitle2 then
			f15_arg0.subtitle2 = LUI.UIText.new({
				leftAnchor = true,
				rightAnchor = false,
				left = CoD.GrowingGridButton.InnerBorder,
				right = CoD.GrowingGridButton.InnerBorder,
				topAnchor = true,
				bottomAnchor = false,
				top = CoD.GrowingGridButton.Subtitle2Top,
				bottom = CoD.GrowingGridButton.Subtitle2Top + CoD.GrowingGridButton.SubtitleFontHeight,
				font = CoD.GrowingGridButton.SubtitleFont
			})
			f15_arg0:addElement(f15_arg0.subtitle2)
		end
		f15_arg0.subtitle2:setText(f15_arg1)
	elseif f15_arg0.subtitle2 then
		f15_arg0.subtitle2:close()
		f15_arg0.subtitle2 = nil
	end
	CoD.GrowingGridButton.UpdateLayout(f15_arg0)
end

CoD.GrowingGridButton.SetSubtitle3 = function (f16_arg0, f16_arg1)
	if f16_arg1 then
		if not f16_arg0.subtitle3 then
			f16_arg0.subtitle3 = LUI.UIText.new({
				leftAnchor = true,
				rightAnchor = false,
				left = CoD.GrowingGridButton.InnerBorder,
				right = CoD.GrowingGridButton.InnerBorder,
				topAnchor = true,
				bottomAnchor = false,
				top = CoD.GrowingGridButton.Subtitle3Top,
				bottom = CoD.GrowingGridButton.Subtitle3Top + CoD.GrowingGridButton.SubtitleFontHeight,
				font = CoD.GrowingGridButton.SubtitleFont
			})
			f16_arg0:addElement(f16_arg0.subtitle3)
		end
		f16_arg0.subtitle3:setText(f16_arg1)
	elseif f16_arg0.subtitle3 then
		f16_arg0.subtitle3:close()
		f16_arg0.subtitle3 = nil
	end
	CoD.GrowingGridButton.UpdateLayout(f16_arg0)
end

CoD.GrowingGridButton.HighlightSubtitle = function (f17_arg0, f17_arg1, f17_arg2)
	if f17_arg0.subtitle then
		if f17_arg1 == 1 and not f17_arg2 then
			f17_arg0.subtitle:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		elseif f17_arg1 == 1 then
			f17_arg0.subtitle:setRGB(CoD.DefaultTextColor.r, CoD.DefaultTextColor.g, CoD.DefaultTextColor.b)
		end
	end
	if f17_arg0.subtitle2 then
		if f17_arg1 == 2 and not f17_arg2 then
			f17_arg0.subtitle2:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		elseif f17_arg1 == 2 then
			f17_arg0.subtitle2:setRGB(CoD.DefaultTextColor.r, CoD.DefaultTextColor.g, CoD.DefaultTextColor.b)
		end
	end
	if f17_arg0.subtitle3 then
		if f17_arg1 == 3 and not f17_arg2 then
			f17_arg0.subtitle3:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		elseif f17_arg1 == 3 then
			f17_arg0.subtitle3:setRGB(CoD.DefaultTextColor.r, CoD.DefaultTextColor.g, CoD.DefaultTextColor.b)
		end
	end
end

CoD.GrowingGridButton.SetHintText = function (f18_arg0, f18_arg1)
	f18_arg0.hintText = f18_arg1
end

CoD.GrowingGridButton.Over = function (f19_arg0, f19_arg1)
	LUI.UIButton.Over(f19_arg0, f19_arg1)
	if f19_arg0.canBeRemoved and f19_arg0:isInFocus() then
		f19_arg0:addUnequipPrompt()
	end
	if not f19_arg0.big then
		f19_arg0.big = true
		local f19_local0 = f19_arg0:getParent()
		if f19_local0 then
			f19_arg0:close()
			f19_arg0:setPriority(CoD.GrowingGridButton.RenderPriority)
			f19_local0:addElement(f19_arg0)
		end
	end
	if f19_arg0.border then
		f19_arg0.border:setAlpha(1)
	end
end

CoD.GrowingGridButton.Up = function (f20_arg0, f20_arg1)
	LUI.UIButton.Up(f20_arg0, f20_arg1)
	f20_arg0:removeUnequipPrompt()
	if f20_arg0.big then
		local f20_local0 = f20_arg0:getParent()
		if f20_local0 then
			f20_arg0:close()
			f20_arg0:setPriority(0)
			f20_local0:addElement(f20_arg0)
		end
		f20_arg0.big = nil
	end
	if f20_arg0.border then
		f20_arg0.border:setAlpha(0)
	end
end

CoD.GrowingGridButton.SetRestrictedImage = function (f21_arg0, f21_arg1)
	if f21_arg1 then
		if not f21_arg0.restrictedImage then
			if not CoD.GrowingGridButton.RestrictedMaterial then
				CoD.GrowingGridButton.RestrictedMaterial = RegisterMaterial("cac_restricted")
			end
			f21_arg0.restrictedImage = LUI.UIImage.new()
			f21_arg0.restrictedImage:setLeftRight(false, false, -16, 16)
			f21_arg0.restrictedImage:setTopBottom(false, false, -16, 16)
			f21_arg0.restrictedImage:setPriority(10)
			f21_arg0.restrictedImage:setImage(CoD.GrowingGridButton.RestrictedMaterial)
			f21_arg0:addElement(f21_arg0.restrictedImage)
		end
	elseif f21_arg0.restrictedImage then
		f21_arg0.restrictedImage:close()
		f21_arg0.restrictedImage = nil
	end
end

CoD.GrowingGridButton.SetLockedImage = function (f22_arg0, f22_arg1)
	if f22_arg1 then
		if not CoD.GrowingGridButton.LockedMaterial then
			CoD.GrowingGridButton.LockedMaterial = RegisterMaterial(CoD.CACUtility.LockImageMaterial)
		end
		if not f22_arg0.lockedImage then
			f22_arg0.lockedImage = LUI.UIImage.new()
			f22_arg0.lockedImage:setLeftRight(false, false, -16, 16)
			f22_arg0.lockedImage:setTopBottom(false, false, -16, 16)
			f22_arg0.lockedImage:setPriority(10)
			f22_arg0.lockedImage:setImage(CoD.GrowingGridButton.LockedMaterial)
			f22_arg0:addElement(f22_arg0.lockedImage)
		end
	elseif f22_arg0.lockedImage then
		f22_arg0.lockedImage:close()
		f22_arg0.lockedImage = nil
	end
end

CoD.GrowingGridButton.SetUnpurchasedImage = function (f23_arg0, f23_arg1)
	if f23_arg1 then
		if not f23_arg0.unpurchasedImage then
			if not CoD.GrowingGridButton.TokenMaterial then
				CoD.GrowingGridButton.TokenMaterial = RegisterMaterial("menu_mp_lobby_token_64")
			end
			f23_arg0.unpurchasedImage = LUI.UIImage.new()
			f23_arg0.unpurchasedImage:setLeftRight(false, false, -16, 16)
			f23_arg0.unpurchasedImage:setTopBottom(false, false, -16, 16)
			f23_arg0.unpurchasedImage:setPriority(10)
			f23_arg0.unpurchasedImage:setImage(CoD.GrowingGridButton.TokenMaterial)
			f23_arg0:addElement(f23_arg0.unpurchasedImage)
		end
	elseif f23_arg0.unpurchasedImage then
		f23_arg0.unpurchasedImage:close()
		f23_arg0.unpurchasedImage = nil
	end
end

CoD.GrowingGridButton.SetupUnequipButton = function (f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4)
	if CoD.useMouse then
		f24_arg0.topBorderOffset = f24_arg1
		f24_arg0.rightBorderOffset = f24_arg2
		f24_arg0.unequipButtonSize = f24_arg3
		f24_arg0.zoomOffset = f24_arg4
	end
end

