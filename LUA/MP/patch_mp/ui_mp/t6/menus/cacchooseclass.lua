require("T6.Menus.CACClassOptions")
require("T6.Menus.CACClassSetOptions")
CoD.CACChooseClass = {}
CoD.CACChooseClass.ItemWidth = CoD.SDSafeWidth
CoD.CACChooseClass.ItemHeight = 360
CoD.CACChooseClass.HighlightedItemWidth = CoD.SDSafeWidth
CoD.CACChooseClass.HighlightedItemHeight = 360
LUI.createMenu.CACChooseClass = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("CACChooseClass")
	CoD.CACUtility.SetDefaultCACRoot(f1_arg0)
	f1_local0:addLargePopupBackground()
	f1_local0:setOwner(f1_arg0)
	f1_local0:addTitle(Engine.Localize("MPUI_CHOOSE_CLASS_CAPS"))
	f1_local0:setBackOutSFX("cac_main_exit_cac")
	f1_local0.goBack = CoD.CACChooseClass.GoBack
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	local f1_local1 = CoD.ButtonPrompt.new
	local f1_local2 = "alt1"
	local f1_local3 = Engine.Localize("MENU_CLASS_OPTIONS")
	local f1_local4 = f1_local0
	local f1_local5 = "open_class_options"
	local f1_local6, Widget = false
	local f1_local8, f1_local9 = false
	f1_local0.classOptionsButton = f1_local1(f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, Widget, f1_local8, f1_local9, "O")
	f1_local0:addRightButtonPrompt(f1_local0.classOptionsButton)
	f1_local0:registerEventHandler("class_button_gain_focus", CoD.CACChooseClass.GainFocus)
	f1_local0:registerEventHandler("class_chosen", CoD.CACChooseClass.ClassChosen)
	f1_local0:registerEventHandler("class_set_copied", CoD.CACChooseClass.ClassSetCopied)
	f1_local0:registerEventHandler("open_class_options", CoD.CACChooseClass.OpenClassOptions)
	f1_local0:registerEventHandler("open_class_set_options", CoD.CACChooseClass.OpenClassSetOptions)
	f1_local0:registerEventHandler("prev_class_set", CoD.CACChooseClass.PrevClassSet)
	f1_local0:registerEventHandler("next_class_set", CoD.CACChooseClass.NextClassSet)
	f1_local0:registerEventHandler("mtx_changed", CoD.CACChooseClass.MTXChanged)
	f1_local0:registerEventHandler("purchase_class_sets", CoD.CACChooseClass.PurchaseClassSets)
	f1_local0:registerEventHandler("update_class_buttons", CoD.CACChooseClass.UpdateClassButtons)
	f1_local0:registerEventHandler("update_class_preview", CoD.CACChooseClass.UpdateClassPreview)
	f1_local0:registerEventHandler("update_class_set_header", CoD.CACChooseClass.UpdateClassSetHeader)
	if CoD.useMouse then
		f1_local0:registerEventHandler("select_class_set", CoD.CACChooseClass.SelectClassSet)
		f1_local0:registerEventHandler("update_pip_highlight", CoD.CACChooseClass.UpdatePipHighlight)
	end
	f1_local1 = CoD.Menu.TitleHeight + 10
	f1_local0.classPreviewTop = f1_local1
	f1_local2 = f1_local0.width / 3 - 50
	f1_local0.buttonListWidth = f1_local2
	f1_local3 = f1_local0.width - f1_local2
	f1_local0.classPreviewWidth = f1_local3
	f1_local0.classPreview = CoD.ClassPreview.New(f1_arg0, f1_local3)
	f1_local0.classPreview:setLeftRight(true, true, f1_local2, 0)
	f1_local0.classPreview:setTopBottom(true, true, f1_local1, 0)
	f1_local0:addElement(f1_local0.classPreview)
	f1_local2 = f1_local2 - 20
	f1_local4 = f1_local2
	f1_local5 = 35
	if 0 == UIExpression.IsInGame() and (Engine.SessionModeIsMode(CoD.SESSIONMODE_ONLINE) or Engine.SessionModeIsMode(CoD.SESSIONMODE_PRIVATE)) then
		f1_local6 = Engine.GetNumberOfClassSetsOwned(f1_arg0)
		if f1_local6 and f1_local6 > 0 then
			Widget = CoD.ButtonPrompt.new
			f1_local8 = "alt2"
			f1_local9 = Engine.Localize("MENU_CLASS_SET_OPTIONS")
			local f1_local10 = f1_local0
			local f1_local11 = "open_class_set_options"
			local f1_local12, f1_local13 = false
			local f1_local14, f1_local15 = false
			f1_local0.classSetOptionsButton = Widget(f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local14, f1_local15, "S")
			if f1_local6 > 1 then
				f1_local0:addRightButtonPrompt(f1_local0.classSetOptionsButton)
			end
			Widget = LUI.UIElement.new()
			Widget:setLeftRight(true, false, 0, f1_local4)
			Widget:setTopBottom(true, false, f1_local1, f1_local1 + f1_local5)
			f1_local0:addElement(Widget)
			Widget.classSetName = LUI.UIText.new()
			Widget.classSetName:setLeftRight(true, true, 0, 0)
			Widget.classSetName:setTopBottom(true, false, 0, CoD.textSize.ExtraSmall)
			Widget.classSetName:setFont(CoD.fonts.ExtraSmall)
			Widget:addElement(Widget.classSetName)
			f1_local8 = LUI.UIHorizontalList.new()
			f1_local8:setLeftRight(true, true, 0, 0)
			f1_local8:setTopBottom(true, false, CoD.textSize.ExtraSmall / 2 - CoD.ButtonPrompt.Height / 2, CoD.textSize.ExtraSmall / 2 + CoD.ButtonPrompt.Height / 2)
			f1_local8:setSpacing(f1_local4 - CoD.ButtonPrompt.Height * 2)
			Widget:addElement(f1_local8)
			f1_local9 = CoD.ButtonPrompt.new("shoulderl", "", f1_local0, "prev_class_set")
			f1_local8:addElement(f1_local9)
			f1_local10 = CoD.ButtonPrompt.new("shoulderr", "", f1_local0, "next_class_set")
			f1_local8:addElement(f1_local10)
			if CoD.useMouse then
				f1_local9.prompt2 = "^BBUTTON_CYCLE_LEFT_ACTIVE^"
				f1_local9:registerEventHandler("mouseenter", CoD.CACChooseClass.ButtonPrompt_MouseEnter)
				f1_local9:registerEventHandler("mouseleave", CoD.CACChooseClass.ButtonPrompt_MouseLeave)
				f1_local10.prompt2 = "^BBUTTON_CYCLE_RIGHT_ACTIVE^"
				f1_local10:registerEventHandler("mouseenter", CoD.CACChooseClass.ButtonPrompt_MouseEnter)
				f1_local10:registerEventHandler("mouseleave", CoD.CACChooseClass.ButtonPrompt_MouseLeave)
			end
			f1_local11 = Dvar.tu8_purchasedClassSetCount:get()
			f1_local12 = 10
			f1_local13 = 0
			f1_local14 = f1_local12 * f1_local11 + f1_local13 * (f1_local11 - 1)
			Widget.pips = {}
			for f1_local15 = 0, f1_local11 - 1, 1 do
				local f1_local18 = LUI.UIImage.new()
				local f1_local19 = (f1_local12 + f1_local13) * f1_local15
				f1_local18:setLeftRight(false, false, -f1_local14 / 2 + f1_local19, -f1_local14 / 2 + f1_local19 + f1_local12)
				f1_local18:setTopBottom(false, true, -f1_local12, 0)
				Widget:addElement(f1_local18)
				table.insert(Widget.pips, f1_local18)
				if CoD.useMouse then
					f1_local18.index = f1_local15
					f1_local18:setHandleMouse(true)
					f1_local18:registerEventHandler("leftmousedown", CoD.NullFunction)
					f1_local18:registerEventHandler("leftmouseup", CoD.CACChooseClass.ClassSetPip_LeftMouseUp)
					f1_local18:registerEventHandler("mouseenter", CoD.CACChooseClass.ClassSetPip_MouseEnter)
					f1_local18:registerEventHandler("mouseleave", CoD.CACChooseClass.ClassSetPip_MouseLeave)
				end
			end
			f1_local0.classSetHeader = Widget
			CoD.CACChooseClass.UpdateClassSetHeader(f1_local0)
			f1_local1 = f1_local1 + f1_local5 + 10
		end
	end
	f1_local0.classButtonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f1_local2,
		topAnchor = true,
		bottomAnchor = true,
		top = f1_local1,
		bottom = 0
	})
	f1_local0.classButtonList.gainFocusSFX = "cac_main_nav"
	f1_local0:addElement(f1_local0.classButtonList)
	if not Engine.AreAllItemsFree() then
		f1_local6 = Engine.GetPlayerStats(f1_arg0)
		if f1_local6.PlayerStatsList.PLEVEL.StatValue:get() < tonumber(CoD.MAX_PRESTIGE) then
			f1_local8 = CoD.CAC.CreateUnlockTokensFooter(f1_local0, f1_arg0)
			CoD.CAC.SetUnlockItemText(f1_local8, f1_arg0)
			f1_local0:addElement(f1_local8)
		end
	end
	f1_local6 = CoD.perController[f1_arg0].lastCustomClassButtonHighlightedRef
	f1_local8 = CoD.CACChooseClass.UpdateButtonList(f1_local0, CoD.perController[f1_arg0].classNum or 0)
	if f1_local8 ~= nil then
		f1_local8:processEvent({
			name = "gain_focus"
		})
	end
	CoD.perController[f1_arg0].lastCustomClassButtonHighlightedRef = f1_local6
	return f1_local0
end

CoD.CACChooseClass.SetActiveClassSet = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0:getOwner()
	local f2_local1 = Engine.GetCurrentClassSetIndex(f2_local0)
	local f2_local2 = Engine.GetNumberOfClassSetsOwned(f2_local0)
	if f2_local2 < f2_arg1 or f2_local1 < 0 then
		return 
	end
	f2_arg0.classSetHeader.currentClassSetIndex = f2_arg1
	if f2_arg1 < f2_local2 then
		Engine.CopyToClassSet(f2_local0, f2_local1)
		Engine.SetCurrentClassSetIndex(f2_local0, f2_arg1)
		Engine.CopyFromClassSet(f2_local0, f2_arg1)
		CoD.CheckClasses.CheckClasses()
		CoD.CACChooseClass.UpdateClassSetHeader(f2_arg0)
		f2_arg0.classButtonList:completeAnimation()
		f2_arg0.classButtonList:setLeftRight(true, false, -320 - f2_arg0.buttonListWidth - 20, -320)
		f2_arg0.classButtonList:beginAnimation("onscreen", 250, false, true)
		f2_arg0.classButtonList:setLeftRight(true, false, 0, f2_arg0.buttonListWidth - 20)
		f2_arg0:processEvent({
			name = "update_class_buttons",
			controller = f2_local0,
			classNum = CoD.perController[f2_local0].classNum
		})
		f2_arg0.classPreview:completeAnimation()
		f2_arg0.classPreview:setAlpha(0)
		f2_arg0.classPreview:beginAnimation("fade_in", 250, true, false)
		f2_arg0.classPreview:setAlpha(1)
		f2_arg0:addElement(f2_arg0.classPreview)
		if f2_arg0.blankClassPreview then
			f2_arg0.blankClassPreview:close()
		end
		f2_arg0:addRightButtonPrompt(f2_arg0.classOptionsButton)
		if f2_local2 > 1 then
			f2_arg0:addRightButtonPrompt(f2_arg0.classSetOptionsButton)
		end
	else
		f2_arg0.classPreview:close()
		CoD.CACChooseClass.UpdateClassSetHeader(f2_arg0)
		if not f2_arg0.classSetPurchaseButton then
			f2_arg0.classSetPurchaseButton = CoD.GrowingGridButton.new({})
			f2_arg0.classSetPurchaseButton:setLeftRight(true, true, 0, 0)
			f2_arg0.classSetPurchaseButton:setTopBottom(true, false, 0, CoD.CoD9Button.Height * 1.5)
			CoD.CustomClass.SetupButtonImages(f2_arg0.classSetPurchaseButton, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
			f2_arg0.classSetPurchaseButton:registerAnimationState("button_over", {
				zoom = 0
			})
			f2_arg0.classSetPurchaseButton.hintText = Engine.Localize("MENU_CLASS_SETS_UPGRADE_HINT")
			CoD.ButtonList.AssociateHintTextListenerToButton(f2_arg0.classSetPurchaseButton)
			f2_arg0.classSetPurchaseButton:setActionEventName("purchase_class_sets")
			if not CoD.isPC then
				f2_arg0.classSetPurchaseButton:setActionPromptString(Engine.Localize("MENU_PURCHASE"))
			end
			local f2_local3 = LUI.UIImage.new()
			f2_local3:setLeftRight(true, false, 5, 37)
			f2_local3:setTopBottom(false, false, -16, 16)
			f2_local3:setImage(RegisterMaterial("menu_purchase_unlock_token_64"))
			f2_arg0.classSetPurchaseButton:addElement(f2_local3)
			local f2_local4 = LUI.UIText.new()
			f2_local4:setLeftRight(true, false, 42, 42)
			f2_local4:setTopBottom(false, false, -CoD.textSize.Condensed / 2, CoD.textSize.Condensed / 2)
			f2_local4:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
			f2_local4:setFont(CoD.fonts.Condensed)
			f2_local4:setText(Engine.Localize("MENU_BUY_CLASS_SETS"))
			f2_arg0.classSetPurchaseButton:addElement(f2_local4)
			f2_arg0.blankClassPreview = CoD.ClassPreview.New(f2_local0, f2_arg0.classPreviewWidth)
			f2_arg0.blankClassPreview:setLeftRight(true, true, f2_arg0.buttonListWidth, 0)
			f2_arg0.blankClassPreview:setTopBottom(true, true, f2_arg0.classPreviewTop, 0)
			f2_arg0.blankClassPreview.allocationBar:processEvent({
				name = "update_class"
			})
			f2_arg0.classSetPurchaseButton.highlight.m_animationStates.button_over = nil
			f2_arg0.classSetPurchaseButton.highlight:beginAnimation("fade_out", CoD.CoD9Button.PulseDuration, true, false)
			f2_arg0.classSetPurchaseButton.highlight:setAlpha(0.2)
			f2_arg0.classSetPurchaseButton.highlight:registerEventHandler("transition_complete_fade_out", function (Sender, Event)
				if not Event.interrupted then
					Sender:beginAnimation("fade_in", CoD.CoD9Button.PulseDuration, false, true)
					Sender:setAlpha(1)
				end
			end)
			f2_arg0.classSetPurchaseButton.highlight:registerEventHandler("transition_complete_fade_in", function (Sender, Event)
				if not Event.interrupted then
					Sender:beginAnimation("fade_out", CoD.CoD9Button.PulseDuration, true, false)
					Sender:setAlpha(0.2)
				end
			end)
		end
		CoD.ButtonList.RemoveAllButtons(f2_arg0.classButtonList)
		f2_arg0.classButtonList:addElement(f2_arg0.classSetPurchaseButton)
		f2_arg0.classButtonList:processEvent({
			name = "gain_focus",
			controller = f2_local0
		})
		f2_arg0:addElement(f2_arg0.blankClassPreview)
		f2_arg0.classSetOptionsButton:close()
		f2_arg0.classOptionsButton:close()
	end
end

CoD.CACChooseClass.PrevClassSet = function (f3_arg0, f3_arg1)
	if not f3_arg0.classSetHeader then
		return 
	end
	local f3_local0 = #f3_arg0.classSetHeader.pips
	local f3_local1 = f3_arg0.classSetHeader.currentClassSetIndex - 1
	if f3_local1 < 0 then
		f3_local1 = f3_local0 - 1
	end
	Engine.PlaySound("cac_safearea")
	CoD.CACChooseClass.SetActiveClassSet(f3_arg0, f3_local1)
end

CoD.CACChooseClass.NextClassSet = function (f4_arg0, f4_arg1)
	if not f4_arg0.classSetHeader then
		return 
	else
		local f4_local0 = (f4_arg0.classSetHeader.currentClassSetIndex + 1) % #f4_arg0.classSetHeader.pips
		Engine.PlaySound("cac_safearea")
		CoD.CACChooseClass.SetActiveClassSet(f4_arg0, f4_local0)
	end
end

CoD.CACChooseClass.MTXChanged = function (f5_arg0, f5_arg1)
	if f5_arg1.controller ~= f5_arg0.m_ownerController then
		return 
	else
		CoD.CACChooseClass.SetActiveClassSet(f5_arg0, f5_arg0.classSetHeader.currentClassSetIndex)
	end
end

CoD.CACChooseClass.PurchaseClassSets = function (f6_arg0, f6_arg1)
	if UIExpression.IsGuest(f6_arg1.controller) == 1 then
		f6_arg0:openPopup("popup_guest_contentrestricted", f6_arg1.controller)
	elseif CoD.isPS3 then
		f6_arg0:openPopup("MTXPurchase", f6_arg1.controller, {
			mtxName = "mtx_storage",
			openingMenuName = "cac"
		})
	else
		Engine.SetStartCheckoutTimestampUTC()
		Engine.PurchaseMTX(f6_arg1.controller, "mtx_storage", "cac")
	end
end

CoD.CACChooseClass.UpdateClassSetHeader = function (f7_arg0)
	if not f7_arg0.classSetHeader then
		return 
	elseif not f7_arg0.classSetHeader.currentClassSetIndex then
		local f7_local0 = Engine.GetCurrentClassSetIndex(f7_arg0:getOwner())
		if f7_local0 >= Engine.GetNumberOfClassSetsOwned(controller) or f7_local0 < 0 then
			f7_local0 = 0
		end
		f7_arg0.classSetHeader.currentClassSetIndex = f7_local0
	end
	local f7_local0 = f7_arg0.classSetHeader.currentClassSetIndex
	f7_arg0.classSetHeader.classSetName:setText(Engine.GetClassSetName(f7_arg0:getOwner(), f7_local0))
	local f7_local1 = Engine.GetNumberOfClassSetsOwned(f7_arg0:getOwner())
	local f7_local2 = RegisterMaterial("menu_vis_carousel_pip")
	local f7_local3 = RegisterMaterial("menu_vis_carousel_pip_fill")
	for f7_local7, f7_local8 in ipairs(f7_arg0.classSetHeader.pips) do
		if f7_local0 == f7_local7 - 1 then
			f7_local8:setImage(f7_local3)
			f7_local8:setAlpha(1)
		end
		if f7_local7 - 1 <= f7_local1 then
			f7_local8:setImage(f7_local2)
			f7_local8:setAlpha(1)
		else
			f7_local8:setImage(f7_local2)
			f7_local8:setAlpha(0.1)
		end
	end
end

CoD.CACChooseClass.UpdateButtonList = function (f8_arg0, f8_arg1)
	CoD.ButtonList.RemoveAllButtons(f8_arg0.classButtonList)
	local f8_local0 = nil
	local f8_local1 = Engine.GetCustomClassCount(f8_arg0.m_ownerController)
	if f8_local1 == nil then
		f8_local1 = 5
	end
	if f8_local1 <= f8_arg1 then
		f8_arg1 = 0
	end
	local f8_local2 = nil
	if f8_arg0.classSetHeader then
		f8_local2 = Engine.Localize("MENU_CLASS_SETS_HINT")
	end
	for f8_local3 = 0, f8_local1 - 1, 1 do
		local f8_local6 = CoD.CACUtility.GetClassData(f8_arg0.m_ownerController, f8_local3)
		local f8_local7 = f8_arg0.classButtonList
		local f8_local8 = f8_local7
		f8_local7 = f8_local7.addButton
		local f8_local9 = CoD.CACUtility.GetLoadoutNameFromIndex(f8_arg0.m_ownerController, f8_local3)
		f8_local7 = f8_local7(f8_local8, f8_local9:get())
		f8_local7.classNum = f8_local3
		f8_local7.hintText = f8_local2
		if f8_arg1 ~= nil and f8_arg1 == f8_local3 then
			f8_local0 = f8_local7
		end
		f8_local7:registerEventHandler("button_action", CoD.CACChooseClass.Button_Action)
		f8_local7:registerEventHandler("gain_focus", CoD.CACChooseClass.Button_GainFocus)
		f8_local7:registerEventHandler("lose_focus", CoD.CACChooseClass.Button_LoseFocus)
	end
	return f8_local0
end

CoD.CACChooseClass.GainFocus = function (f9_arg0, f9_arg1)
	CoD.perController[f9_arg0.m_ownerController].lastCustomClassButtonHighlightedRef = nil
	CoD.perController[f9_arg0.m_ownerController].classNum = f9_arg1.classNum
	f9_arg0.classPreview:update(f9_arg0.m_ownerController, f9_arg1.classNum)
end

CoD.CACChooseClass.ClassChosen = function (f10_arg0, f10_arg1)
	local f10_local0 = CoD.perController[f10_arg1.controller]
	f10_local0.classNum = f10_arg1.classNum
	f10_local0.isPreset = false
	f10_local0.weaponSlot = nil
	f10_local0.grenadeSlot = nil
	f10_local0.perkCategory = nil
	f10_local0.slotIndex = nil
	f10_arg0:openMenu("CACEditClass", f10_arg1.controller)
	f10_arg0:close()
end

CoD.CACChooseClass.ClassSetCopied = function (f11_arg0, f11_arg1)
	CoD.CACChooseClass.SetActiveClassSet(f11_arg0, f11_arg1.classSetIndex)
end

CoD.CACChooseClass.OpenClassOptions = function (f12_arg0, f12_arg1)
	f12_arg0:openPopup("ClassOptions", f12_arg1.controller)
end

CoD.CACChooseClass.OpenClassSetOptions = function (f13_arg0, f13_arg1)
	f13_arg0:openPopup("ClassSetOptions", f13_arg1.controller)
end

CoD.CACChooseClass.UpdateClassButtons = function (f14_arg0, f14_arg1)
	local f14_local0 = CoD.CACChooseClass.UpdateButtonList(f14_arg0, f14_arg1.classNum)
	if f14_local0 ~= nil then
		f14_local0:processEvent({
			name = "gain_focus"
		})
	end
end

CoD.CACChooseClass.UpdateClassPreview = function (f15_arg0, f15_arg1)
	f15_arg0.classPreview:update(f15_arg0.m_ownerController, f15_arg1.classNum)
end

CoD.CACChooseClass.Button_Action = function (f16_arg0, f16_arg1)
	Engine.PlaySound("cac_main_edit_loadout")
	f16_arg0:dispatchEventToParent({
		name = "class_chosen",
		controller = f16_arg1.controller,
		classNum = f16_arg0.classNum
	})
end

CoD.CACChooseClass.Button_GainFocus = function (f17_arg0, f17_arg1)
	CoD.CoD9Button.GainFocus(f17_arg0, f17_arg1)
	f17_arg0:dispatchEventToParent({
		name = "class_button_gain_focus",
		classNum = f17_arg0.classNum
	})
	if CoD.useMouse then
		CoD.CACChooseClass.Button_AddClassOptionsButton(f17_arg0)
	end
end

CoD.CACChooseClass.Button_LoseFocus = function (f18_arg0, f18_arg1)
	CoD.CoD9Button.LoseFocus(f18_arg0, f18_arg1)
	if CoD.useMouse then
		CoD.CACChooseClass.Button_RemoveClassOptionsButton(f18_arg0)
	end
end

CoD.CACChooseClass.Button_AddClassOptionsButton = function (f19_arg0)
	local f19_local0 = 20
	if f19_arg0.classOptionsButton == nil then
		local f19_local1 = 200
		f19_arg0.classOptionsButton = CoD.MouseButton.new({
			leftAnchor = true,
			rightAnchor = false,
			left = f19_local1,
			right = f19_local1 + f19_local0,
			topAnchor = false,
			bottomAnchor = false,
			top = -f19_local0 / 2,
			bottom = f19_local0 / 2
		}, "^BBUTTON_MOUSE_EDIT^", "^BBUTTON_MOUSE_EDIT_ACTIVE^")
		f19_arg0.classOptionsButton:setExpansionScale()
		f19_arg0.classOptionsButton:setActionEventName("open_class_options")
	end
	f19_arg0:addElement(f19_arg0.classOptionsButton)
end

CoD.CACChooseClass.Button_RemoveClassOptionsButton = function (f20_arg0)
	if f20_arg0.classOptionsButton ~= nil then
		f20_arg0.classOptionsButton:close()
		f20_arg0:setHandleMouseButton(true)
	end
end

CoD.CACChooseClass.GoBack = function (f21_arg0, f21_arg1)
	Engine.PartyHostClearUIState()
	if UIExpression.IsInGame() == 0 then
		Engine.Exec(f21_arg1, "uploadstats")
		Engine.CommitProfileChanges(f21_arg1)
		if f21_arg0.occludedMenu then
			f21_arg0.occludedMenu:processEvent({
				name = "cac_closed",
				controller = f21_arg1
			})
		end
	end
	CoD.Menu.goBack(f21_arg0, f21_arg1)
end

CoD.CACChooseClass.ButtonPrompt_MouseEnter = function (f22_arg0, f22_arg1)
	if f22_arg0.prompt2 then
		f22_arg0.buttonImage:setText(f22_arg0.prompt2)
	end
end

CoD.CACChooseClass.ButtonPrompt_MouseLeave = function (f23_arg0, f23_arg1)
	if f23_arg0.prompt then
		f23_arg0.buttonImage:setText(f23_arg0.prompt)
	end
end

CoD.CACChooseClass.ClassSetPip_LeftMouseUp = function (f24_arg0, f24_arg1)
	if f24_arg1.inside then
		f24_arg0:dispatchEventToParent({
			name = "select_class_set",
			controller = f24_arg1.controller,
			index = f24_arg0.index
		})
	end
end

CoD.CACChooseClass.ClassSetPip_MouseEnter = function (f25_arg0, f25_arg1)
	f25_arg0:dispatchEventToParent({
		name = "update_pip_highlight",
		controller = f25_arg1.controller,
		index = f25_arg0.index,
		state = "highlight_on"
	})
end

CoD.CACChooseClass.ClassSetPip_MouseLeave = function (f26_arg0, f26_arg1)
	f26_arg0:dispatchEventToParent({
		name = "update_pip_highlight",
		controller = f26_arg1.controller,
		index = f26_arg0.index,
		state = "highlight_off"
	})
end

CoD.CACChooseClass.UpdatePipHighlight = function (f27_arg0, f27_arg1)
	if f27_arg1.index == f27_arg0.classSetHeader.currentClassSetIndex then
		return 
	end
	local f27_local0 = nil
	if f27_arg1.state == "highlight_on" then
		f27_local0 = RegisterMaterial("menu_vis_carousel_pip_fill")
	else
		f27_local0 = RegisterMaterial("menu_vis_carousel_pip")
	end
	f27_arg0.classSetHeader.pips[f27_arg1.index + 1]:setImage(f27_local0)
end

CoD.CACChooseClass.SelectClassSet = function (f28_arg0, f28_arg1)
	if not f28_arg0.classSetHeader then
		return 
	elseif f28_arg0.classSetHeader.currentClassSetIndex ~= f28_arg1.index then
		CoD.CACChooseClass.SetActiveClassSet(f28_arg0, f28_arg1.index)
	end
end

