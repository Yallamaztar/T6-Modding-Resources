require("T6.Menus.EmblemEditorColors")
require("T6.Menus.EmblemEditorIconSelector")
CoD.EmblemEditor = {}
CoD.EmblemEditor.EMBLEMS_INVALID_ICON_ID = -1
CoD.EmblemEditor.EmblemWidth = 280
CoD.EmblemEditor.TotalLayers = 32
CoD.EmblemEditor.ItemWidth = 120
CoD.EmblemEditor.ItemHeight = 100
CoD.EmblemEditor.HighlightedItemWidth = CoD.EmblemEditor.ItemWidth * 1.2
CoD.EmblemEditor.HighligtedItemHeight = CoD.EmblemEditor.ItemHeight * 1.2
CoD.EmblemEditor.ClipboardWidgetWidth = 130
CoD.EmblemEditor.LayerPropertiesBoxWidth = 200
CoD.EmblemEditor.IsEditorModeActive = false
CoD.EmblemEditor.EmblemPaneY = CoD.textSize.Big + 15
CoD.EmblemEditor.MaximumGridLines = 9
CoD.EmblemEditor.GridLineSpacing = CoD.EmblemEditor.EmblemWidth / (CoD.EmblemEditor.MaximumGridLines + 1)
CoD.EmblemEditor.GridLinesVisible = true
CoD.EmblemEditor.ArrowSize = 30
CoD.EmblemEditor.ArrowDisplayTime = 500
CoD.EmblemEditor.ArrowFadeTime = 200
CoD.EmblemEditor.BorderWidth = 1
CoD.EmblemEditor.GridLineWidth = 2
CoD.EmblemEditor.PulseColorTransitionTime = 200
CoD.EmblemEditor.EMBLEM_FIXED_SCALE = 0
CoD.EmblemEditor.EMBLEM_FREE_SCALE = 1
CoD.EmblemEditor.ToggleEmblemMenuButtonsLayout = function (f1_arg0, f1_arg1)
	f1_arg0.popup.buttonPromptList:removeAllChildren()
	f1_arg0.popup.leftButtonPromptBar:removeAllChildren()
	f1_arg0.popup.rightButtonPromptBar:removeAllChildren()
	if f1_arg1 == true then
		CoD.EmblemEditor.AddEmblemMenuButtons(f1_arg0.popup)
	else
		CoD.EmblemEditor.AddEmblemMenuNewLayerButtons(f1_arg0.popup)
	end
end

CoD.EmblemEditor.SetScaleMode = function (f2_arg0, f2_arg1, f2_arg2)
	Engine.ExecNow(f2_arg1, "emblemSetScaleMode " .. f2_arg2)
	CoD.EmblemEditor.SetScaleButtomPromptText(f2_arg0, f2_arg1)
end

CoD.EmblemEditor.ToggleScaleMode = function (f3_arg0, f3_arg1)
	if Engine.GetEmblemScaleMode(f3_arg1.controller) == CoD.EmblemEditor.EMBLEM_FIXED_SCALE then
		CoD.EmblemEditor.SetScaleMode(f3_arg0, controller, CoD.EmblemEditor.EMBLEM_FREE_SCALE)
	else
		CoD.EmblemEditor.SetScaleMode(f3_arg0, controller, CoD.EmblemEditor.EMBLEM_FIXED_SCALE)
	end
end

CoD.EmblemEditor.SetScaleButtomPromptText = function (f4_arg0, f4_arg1)
	if Engine.GetEmblemScaleMode(f4_arg1) == CoD.EmblemEditor.EMBLEM_FIXED_SCALE then
		f4_arg0.scaleImage:setText(Engine.Localize("MENU_EMBLEM_FIXED_SCALE"))
	else
		f4_arg0.scaleImage:setText(Engine.Localize("MENU_EMBLEM_FREE_SCALE"))
	end
end

CoD.EmblemEditor.HiddenLayerBlueComplete = function (f5_arg0, f5_arg1)
	f5_arg0:beginAnimation("fade_blue", CoD.EmblemEditor.PulseColorTransitionTime, true, true)
	f5_arg0:setAlpha(0)
end

CoD.EmblemEditor.PulseSelectedEmblem = function (f6_arg0, f6_arg1, f6_arg2)
	f6_arg0.pulseEmblemLayer:setupEmblemHiddenLayer(Engine.GetSelectedLayerIconID(f6_arg1, f6_arg2), f6_arg2)
	f6_arg0.pulseEmblemLayer:completeAnimation()
	f6_arg0.pulseEmblemLayer:setAlpha(1)
	f6_arg0.pulseEmblemLayer:setRGB(1, 1, 0)
	f6_arg0.pulseEmblemLayer:beginAnimation("hidden_layer_blue", CoD.EmblemEditor.PulseColorTransitionTime, true, true)
	f6_arg0.pulseEmblemLayer:setRGB(0, 0, 1)
	f6_arg0.pulseEmblemLayer:setAlpha(0.8)
end

CoD.EmblemEditor.AnimateBottomLayerText = function (f7_arg0, f7_arg1, f7_arg2)
	if f7_arg2 == true then
		f7_arg0.bottomLayerElement:hide()
	elseif f7_arg1 == 0 then
		f7_arg0.bottomLayerElement:beginAnimation("showBottomLayerText", 500)
		f7_arg0.bottomLayerElement:setAlpha(0.6)
	else
		f7_arg0.bottomLayerElement:hide()
	end
end

CoD.EmblemEditor.CardGainFocus = function (f8_arg0, f8_arg1)
	Engine.ExecNow(f8_arg1.card.controller, "emblemSelect " .. f8_arg1.card.cardIndex - 1)
	CoD.EmblemEditor.PulseSelectedEmblem(f8_arg0, f8_arg1.card.controller, f8_arg1.card.cardIndex - 1)
	CoD.EmblemEditor.AnimateBottomLayerText(f8_arg0, f8_arg1.card.cardIndex - 1)
	if CoD.EmblemEditor.IsEditorModeActive == false then
		CoD.EmblemEditor.UpdateLayerButtons(f8_arg1.card, f8_arg1.card.controller)
	else
		CoD.EmblemEditor.UpdateLayers(f8_arg1.card, f8_arg1.card.controller)
		f8_arg0.cardCarouselList:dispatchEventToChildren({
			name = "fade_card",
			controller = f8_arg1.card.controller,
			selectedCardIndex = f8_arg1.card.cardIndex
		})
		if CoD.EmblemEditor.LayerMovementDirection == "left" then
			f8_arg0.cardCarouselList:processEvent({
				name = "show_arrows",
				controller = f8_arg1.card.controller,
				selectedCardIndex = f8_arg1.card.cardIndex,
				direction = "left"
			})
		else
			f8_arg0.cardCarouselList:processEvent({
				name = "show_arrows",
				controller = f8_arg1.card.controller,
				selectedCardIndex = f8_arg1.card.cardIndex,
				direction = "right"
			})
		end
		if f8_arg0.opacityValue ~= nil then
			CoD.EmblemEditor.UpdateOpacityDisplay(f8_arg0, f8_arg1.card.controller)
		end
	end
end

CoD.EmblemEditor.UpdateLayerButtons = function (f9_arg0, f9_arg1)
	local f9_local0 = Engine.GetSelectedLayerIconID(f9_arg1, f9_arg0.cardIndex - 1)
	local f9_local1 = Engine.GetUsedLayerCount(f9_arg1)
	if f9_local0 == CoD.EmblemEditor.EMBLEMS_INVALID_ICON_ID then
		f9_arg0:setActionEventName("chooseLayerImage")
		CoD.EmblemEditor.ToggleEmblemMenuButtonsLayout(f9_arg0, false)
		f9_arg0.emptyLayerText:setText(Engine.Localize("MENU_EMBLEM_EMPTY_LAYER_CAPS"))
	else
		f9_arg0:setActionEventName("editLayerIcon")
		CoD.EmblemEditor.ToggleEmblemMenuButtonsLayout(f9_arg0, true)
		f9_arg0.emptyLayerText:setText("")
	end
	f9_arg0.layerImage:setupEmblemSelector(f9_local0, f9_arg0.cardIndex - 1)
	f9_arg0.popup.MOfNLayersUsed:setText(Engine.Localize("MENU_EMBLEM_LAYERS_USED", Engine.GetUsedLayerCount(f9_arg1), CoD.EmblemEditor.TotalLayers))
end

CoD.EmblemEditor.UpdateLayers = function (f10_arg0, f10_arg1)
	local f10_local0 = Engine.GetSelectedLayerIconID(f10_arg1, f10_arg0.cardIndex - 1)
	local f10_local1 = Engine.GetUsedLayerCount(f10_arg1)
	if f10_local0 == CoD.EmblemEditor.EMBLEMS_INVALID_ICON_ID then
		f10_arg0.emptyLayerText:setText(Engine.Localize("MENU_EMBLEM_EMPTY_LAYER_CAPS"))
	else
		f10_arg0.emptyLayerText:setText("")
	end
	f10_arg0.layerImage:setupEmblemSelector(f10_local0, f10_arg0.cardIndex - 1)
	f10_arg0.popup.MOfNLayersUsed:setText(Engine.Localize("MENU_EMBLEM_LAYERS_USED", Engine.GetUsedLayerCount(f10_arg1), CoD.EmblemEditor.TotalLayers))
end

CoD.EmblemEditor.EmblemPaneSelected = function (f11_arg0, f11_arg1)
	local f11_local0 = CoD.EmblemEditor.GetSelectedCard(f11_arg0)
	if f11_arg1 == false then
		f11_arg0.border:setRGB(1, 1, 1)
		f11_arg0.border:setAlpha(0.1)
		f11_arg0:setTitle(Engine.Localize("MENU_EMBLEM_EDITOR_CAPS"))
	else
		f11_arg0.border:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f11_arg0.border:setAlpha(1)
		f11_arg0:setTitle(Engine.Localize("MENU_EMBLEM_EDIT_LAYER_TITLE"))
	end
	if CoD.isPC then
		f11_arg0.m_layerMoveMode = f11_arg1
	end
end

CoD.EmblemEditor.SetupButton = function (f12_arg0)
	if f12_arg0.grid then
		f12_arg0.grid:close()
	end
	f12_arg0.outline = CoD.Border.new(1, 1, 1, 1, 0.1)
	f12_arg0.outline:setPriority(-100)
	f12_arg0:addElement(f12_arg0.outline)
	local f12_local0 = CoD.textSize[CoD.ContentGridButton.FontName] + 4
	local f12_local1 = 1
	local f12_local2 = LUI.UIImage.new()
	f12_local2:setLeftRight(true, true, 2, -2)
	f12_local2:setTopBottom(false, true, -f12_local0 - f12_local1, -f12_local1)
	f12_local2:setRGB(0, 0, 0)
	f12_local2:setAlpha(1)
	f12_local2:setPriority(-90)
	f12_arg0:addElement(f12_local2)
	f12_arg0.highlight = CoD.Border.new(1, CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b, 0)
	f12_arg0.highlight:setPriority(100)
	f12_arg0.highlight:registerAnimationState("default", {
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
	f12_arg0.highlight:registerAnimationState("button_over", {
		alpha = 1
	})
	LUI.UIButton.SetupElement(f12_arg0.highlight)
	f12_arg0:addElement(f12_arg0.highlight)
end

CoD.EmblemEditor.SetupCarouselCard = function (f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4, f13_arg5)
	if f13_arg5 == nil then
		f13_arg5 = 0
	end
	if f13_arg2 then
		f13_arg0.iconMaterial = RegisterMaterial(f13_arg2)
		f13_arg0.icon = LUI.UIImage.new()
		f13_arg0.icon:setLeftRight(false, false, -f13_arg3 / 2, f13_arg3 / 2)
		f13_arg0.icon:setTopBottom(false, false, -f13_arg4 / 2 + f13_arg5, f13_arg4 / 2 + f13_arg5)
		f13_arg0.icon:setImage(f13_arg0.iconMaterial)
		f13_arg0:addElement(f13_arg0.icon)
	end
	f13_arg0.title = LUI.UIText.new()
	f13_arg0.title:setLeftRight(true, true, 5, 0)
	f13_arg0.title:setTopBottom(false, true, -CoD.textSize.ExtraSmall - 4, -4)
	f13_arg0.title:setFont(CoD.fonts.ExtraSmall)
	f13_arg0.title:setRGB(CoD.offWhite.r, CoD.offWhite.b, CoD.offWhite.g)
	f13_arg0.title:setAlignment(LUI.Alignment.Center)
	f13_arg0.titleText = f13_arg1
	f13_arg0.title:setText(f13_arg0.titleText)
	f13_arg0.title:registerAnimationState("button_over", {
		red = CoD.BOIIOrange.r,
		green = CoD.BOIIOrange.g,
		blue = CoD.BOIIOrange.b
	})
	LUI.UIButton.SetupElement(f13_arg0.title)
	f13_arg0:addElement(f13_arg0.title)
	if f13_arg0.border then
		f13_arg0.border:close()
	end
	if f13_arg0.highlightedborder then
		f13_arg0.highlightedborder:close()
	end
	CoD.EmblemEditor.SetupButton(f13_arg0)
	f13_arg0.rightArrow = LUI.UIImage.new()
	f13_arg0.rightArrow:setLeftRight(false, true, -10, CoD.EmblemEditor.ArrowSize - 10)
	f13_arg0.rightArrow:setTopBottom(false, false, -CoD.EmblemEditor.ArrowSize / 2, CoD.EmblemEditor.ArrowSize / 2)
	f13_arg0.rightArrow:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	f13_arg0.rightArrow:setImage(RegisterMaterial("ui_arrow_right"))
	f13_arg0:addElement(f13_arg0.rightArrow)
	f13_arg0.rightArrow:hide()
	f13_arg0.leftArrow = LUI.UIImage.new()
	f13_arg0.leftArrow:setLeftRight(true, false, -CoD.EmblemEditor.ArrowSize + 10, 10)
	f13_arg0.leftArrow:setTopBottom(false, false, -CoD.EmblemEditor.ArrowSize / 2, CoD.EmblemEditor.ArrowSize / 2)
	f13_arg0.leftArrow:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	f13_arg0.leftArrow:setImage(RegisterMaterial("ui_arrow_left"))
	f13_arg0:addElement(f13_arg0.leftArrow)
	f13_arg0.leftArrow:hide()
end

CoD.EmblemEditor.LayerCard_Gamepad_Button = function (f14_arg0, f14_arg1)

end

CoD.EmblemEditor.EmblemEditorCarouselCardGainFocus = function (f15_arg0, f15_arg1)
	if Engine.GetSelectedLayerIconID(f15_arg1.controller, f15_arg1.card.cardIndex - 1) == CoD.EmblemEditor.EMBLEMS_INVALID_ICON_ID then
		f15_arg1.card.hintText = Engine.Localize("MENU_EMPTY_LAYER_DESC")
	else
		f15_arg1.card.hintText = Engine.Localize("MENU_USED_LAYER_DESC")
	end
	CoD.CardCarousel.CardGainFocus(f15_arg0, f15_arg1)
end

CoD.EmblemEditor.AddCarousels = function (f16_arg0, f16_arg1)
	local f16_local0 = f16_arg0:addCardCarousel("", true)
	f16_local0:registerEventHandler("card_gain_focus", CoD.EmblemEditor.EmblemEditorCarouselCardGainFocus)
	for f16_local1 = 1, CoD.EmblemEditor.TotalLayers, 1 do
		local f16_local4 = f16_local0:addNewCard()
		f16_local4:registerEventHandler("fade_card", CoD.EmblemEditor.FadeCard)
		f16_local4:registerEventHandler("undo_fade_card", CoD.EmblemEditor.UndoFadeCard)
		f16_local4:registerEventHandler("show_arrows", CoD.EmblemEditor.ShowArrows)
		f16_local4:registerEventHandler("hide_arrows", CoD.EmblemEditor.HideArrows)
		f16_local4:registerEventHandler("fade_out_arrows", CoD.EmblemEditor.FadeOutArrows)
		CoD.EmblemEditor.SetupCarouselCard(f16_local4, Engine.Localize("MENU_EMBLEM_LAYER_NUMBER", f16_local1))
		f16_local4.popup = f16_arg0.popup
		f16_local4.controller = f16_arg1
		f16_local4.emptyLayerText = LUI.UIText.new()
		f16_local4.emptyLayerText:setLeftRight(false, false, -1, 1)
		f16_local4.emptyLayerText:setTopBottom(false, false, -CoD.textSize.ExtraSmall / 2 - 10, CoD.textSize.ExtraSmall / 2 - 10)
		f16_local4.emptyLayerText:setFont(CoD.fonts.ExtraSmall)
		f16_local4.emptyLayerText:setAlignment(LUI.Alignment.Center)
		f16_local4.layerImage = LUI.UIElement.new()
		f16_local4.layerImage:setLeftRight(false, false, -35, 35)
		f16_local4.layerImage:setTopBottom(false, false, -45, 25)
		f16_local4.layerImage:setAlignment(LUI.Alignment.Center)
		local f16_local5 = Engine.GetSelectedLayerIconID(f16_arg1, f16_local1 - 1)
		if f16_local5 == CoD.EmblemEditor.EMBLEMS_INVALID_ICON_ID then
			f16_local4.emptyLayerText:setText(Engine.Localize("MENU_EMBLEM_EMPTY_LAYER_CAPS"))
		else
			f16_local4.layerImage:setupEmblemSelector(f16_local5, f16_local1 - 1)
		end
		f16_local4.hintText = ""
		f16_local4:addElement(f16_local4.layerImage)
		f16_local4:addElement(f16_local4.emptyLayerText)
	end
end

CoD.EmblemEditor.FadeCard = function (f17_arg0, f17_arg1)
	f17_arg0.highlight:hide()
	f17_arg0.highlight:registerAnimationState("button_over", {
		alpha = 0
	})
	if f17_arg0.cardIndex == f17_arg1.selectedCardIndex then
		f17_arg0:setAlpha(1)
	else
		f17_arg0:setAlpha(0.15)
	end
end

CoD.EmblemEditor.UndoFadeCard = function (f18_arg0, f18_arg1)
	f18_arg0:show()
	f18_arg0.highlight:registerAnimationState("button_over", {
		alpha = 1
	})
	if f18_arg0.cardIndex == f18_arg1.selectedCardIndex then
		f18_arg0.highlight:show()
	end
end

CoD.EmblemEditor.ShowArrows = function (f19_arg0, f19_arg1)
	if f19_arg0.cardIndex == f19_arg1.selectedCardIndex then
		if f19_arg1.direction == "left" then
			f19_arg0.leftArrow:show()
		else
			f19_arg0.rightArrow:show()
		end
		if f19_arg0.cardIndex == 1 then
			f19_arg0.leftArrow:hide()
		elseif f19_arg0.cardIndex == CoD.EmblemEditor.TotalLayers then
			f19_arg0.rightArrow:hide()
		end
		f19_arg0:addElement(LUI.UITimer.new(CoD.EmblemEditor.ArrowDisplayTime, {
			name = "fade_out_arrows",
			controller = f19_arg1.controller
		}, true))
	else
		f19_arg0.rightArrow:hide()
		f19_arg0.leftArrow:hide()
	end
end

CoD.EmblemEditor.HideArrows = function (f20_arg0, f20_arg1)
	f20_arg0.rightArrow:hide()
	f20_arg0.leftArrow:hide()
end

CoD.EmblemEditor.FadeOutArrows = function (f21_arg0, f21_arg1)
	f21_arg0.leftArrow:beginAnimation("fade_out_left_arrow", CoD.EmblemEditor.ArrowFadeTime, true, true)
	f21_arg0.leftArrow:hide()
	f21_arg0.rightArrow:beginAnimation("fade_out_right_arrow", CoD.EmblemEditor.ArrowFadeTime, true, true)
	f21_arg0.rightArrow:hide()
end

CoD.EmblemEditor.AddLayersCarousel = function (f22_arg0, f22_arg1)
	CoD.EmblemEditor.HintTextParams = {}
	CoD.EmblemEditor.HintTextParams.hintTextLeft = 0
	CoD.EmblemEditor.HintTextParams.hintTextWidth = 350
	CoD.EmblemEditor.HintTextParams.hintTextTop = -15
	local f22_local0 = CoD.CardCarouselList.new(nil, f22_arg1, CoD.EmblemEditor.ItemWidth, CoD.EmblemEditor.ItemHeight, CoD.EmblemEditor.HighlightedItemWidth, CoD.EmblemEditor.HighligtedItemHeight, CoD.EmblemEditor.HintTextParams)
	f22_local0.cardCarouselSize = CoD.EmblemEditor.HighligtedItemHeight
	f22_arg0.cardCarouselList = f22_local0
	f22_local0:setLeftRight(true, true, 0, 0)
	f22_local0:setTopBottom(false, true, -210, -90)
	f22_arg0:addElement(f22_local0)
	f22_local0.popup = f22_arg0
	CoD.EmblemEditor.AddCarousels(f22_local0, f22_arg1)
	if CoD.EmblemEditor.CurrentCarouselInfo then
		f22_local0:setInitialCarousel(CoD.EmblemEditor.CurrentCarouselInfo.carouselIndex, CoD.EmblemEditor.CurrentCarouselInfo.cardIndex)
	end
	f22_local0:focusCurrentCardCarousel(f22_arg1)
end

CoD.EmblemEditor.EditorHandleDpadLeftRight = function (f23_arg0, f23_arg1)
	if f23_arg1.qualifier ~= "dpad" then
		return 
	elseif CoD.isPC and not Engine.LastInput_Gamepad() and not f23_arg1.dummy then
		return 
	else
		CoD.CardCarouselList.Gamepad_Button(f23_arg0, f23_arg1)
	end
end

CoD.EmblemEditor.EditLayerIcon = function (f24_arg0, f24_arg1)
	CoD.EmblemEditor.IsEditorModeActive = true
	f24_arg0.cardCarouselList:registerEventHandler("gamepad_button", CoD.EmblemEditor.EditorHandleDpadLeftRight)
	f24_arg0.emblemPane:processEvent({
		name = "gain_focus"
	})
	local f24_local0 = CoD.EmblemEditor.GetSelectedCardIndex(f24_arg0)
	Engine.ExecNow(f24_arg1.controller, "emblemCopyLayer " .. f24_local0 - 1)
	CoD.EmblemEditor.PulseSelectedEmblem(f24_arg0, f24_arg1.controller, f24_local0 - 1)
	CoD.EmblemEditor.AnimateBottomLayerText(f24_arg0, f24_local0 - 1)
	Engine.ExecNow(f24_arg1.controller, "emblemBeginEdit")
	CoD.EmblemEditor.EmblemPaneSelected(f24_arg0, true)
	f24_arg0.buttonPromptList:removeAllChildren()
	f24_arg0.leftButtonPromptBar:removeAllChildren()
	f24_arg0.rightButtonPromptBar:removeAllChildren()
	CoD.EmblemEditor.AddEmblemEditorButtons(f24_arg0, f24_arg1.controller)
	CoD.EmblemEditor.ClipboardWidgetVisibility(f24_arg0, 0)
	f24_arg0.clipboardWidgetButtonPromptList:removeAllChildren()
	CoD.EmblemEditor.UpdateOpacityDisplay(f24_arg0, f24_arg1.controller)
	f24_arg0.opacityValue:show()
	if CoD.useMouse then
		f24_arg0.opacityControlBar:show()
	end
	if CoD.EmblemEditor.GridLinesVisible then
		f24_arg0.emblemEditorGrid:show()
	end
	CoD.EmblemEditor.SetScaleMode(f24_arg0, f24_arg1.controller, CoD.EmblemEditor.EMBLEM_FIXED_SCALE)
	f24_arg0.cardCarouselList:dispatchEventToChildren({
		name = "fade_card",
		controller = f24_arg1.controller,
		selectedCardIndex = f24_local0
	})
	if CoD.useMouse then
		f24_arg0.m_editLayerMode = true
		f24_arg0.emblemPane.m_editMode = true
		local f24_local1 = CoD.CardCarouselList.GetCarouselInFocus(f24_arg0.cardCarouselList)
		f24_local1:setMouseDisabled(true)
		f24_local1.mouseDragListener:setMouseDisabled(true)
	end
end

CoD.EmblemEditor.ChooseLayerIcon = function (f25_arg0, f25_arg1)
	local f25_local0 = CoD.CardCarouselList.GetSelectedCarousel(f25_arg0.cardCarouselList)
	CoD.EmblemEditor.CurrentCarouselInfo = CoD.CardCarousel.GetCurrentCarouselInfo(CoD.CardCarousel.GetCardByIndex(f25_arg0.cardCarouselList.cardCarousels[f25_local0], CoD.CardCarousel.GetSelectedCardIndex(f25_arg0.cardCarouselList.cardCarousels[f25_local0])))
	f25_arg0:openMenu("EmblemEditorIconSelector", f25_arg1.controller)
	f25_arg0:close()
end

CoD.EmblemEditor.ClearLayer = function (f26_arg0, f26_arg1)
	Engine.ExecNow(f26_arg1.controller, "emblemClear")
	local f26_local0 = CoD.CardCarouselList.GetSelectedCarousel(f26_arg0.cardCarouselList)
	CoD.EmblemEditor.UpdateLayerButtons(CoD.CardCarousel.GetCardByIndex(f26_arg0.cardCarouselList.cardCarousels[f26_local0], CoD.CardCarousel.GetSelectedCardIndex(f26_arg0.cardCarouselList.cardCarousels[f26_local0])), f26_arg1.controller)
end

CoD.EmblemEditor.RotateButtonPrompt = function ()
	local f27_local0 = LUI.UIText.new()
	f27_local0:setLeftRight(true, false, 0, 100)
	f27_local0:setTopBottom(false, false, -CoD.textSize[CoD.ButtonPrompt.FontName] / 2, CoD.textSize[CoD.ButtonPrompt.FontName] / 2)
	f27_local0:setFont(CoD.fonts[CoD.ButtonPrompt.FontName])
	f27_local0:setText(Engine.Localize("MENU_EMBLEM_LAYER_ROTATE_BUTTON"))
	return f27_local0
end

CoD.EmblemEditor.AddEmblemEditorButtons = function (f28_arg0, f28_arg1)
	CoD.EmblemEditor.SetScaleButtomPromptText(f28_arg0, f28_arg1)
	f28_arg0.emblemEditorLayerOptions:show()
	f28_arg0:addRightButtonPrompt(f28_arg0.layerOptionsPopup)
	if not CoD.isPC or Engine.LastInput_Gamepad() then
		f28_arg0:addButtonPrompt(f28_arg0.moveImage)
		f28_arg0:addButtonPrompt(f28_arg0.scaleImage)
		f28_arg0:addButtonPrompt(CoD.EmblemEditor.RotateButtonPrompt())
		f28_arg0:addButtonPrompt(f28_arg0.flipImage)
		f28_arg0:addButtonPrompt(f28_arg0.toggleOutline)
		f28_arg0:addButtonPrompt(f28_arg0.changeLayerOrder)
		f28_arg0:addRightButtonPrompt(f28_arg0.layerleft)
		f28_arg0:addRightButtonPrompt(f28_arg0.layerright)
		CoD.EmblemEditor.AddOpacityButtonPrompts(f28_arg0)
	elseif CoD.isPC then
		f28_arg0:addButtonPrompt(f28_arg0.moveImage_kbm)
		f28_arg0:addButtonPrompt(f28_arg0.scaleImage_kbm)
		f28_arg0:addButtonPrompt(f28_arg0.fixedScaleImage_kbm)
		f28_arg0:addButtonPrompt(f28_arg0.rotateImage_kbm)
		f28_arg0:addButtonPrompt(f28_arg0.flipImage)
		f28_arg0:addButtonPrompt(f28_arg0.toggleOutline)
		f28_arg0:addButtonPrompt(f28_arg0.layerright_kbm)
		f28_arg0:addButtonPrompt(f28_arg0.layerleft_kbm)
	end
	f28_arg0:addRightButtonPrompt(f28_arg0.toggleScaleMode)
	f28_arg0:addButtonPrompt(f28_arg0.editLayerColor)
	f28_arg0:addLeftButtonPrompt(f28_arg0.commitchange)
	f28_arg0:addLeftButtonPrompt(f28_arg0.editorBackbutton)
	if CoD.isPC then
		CoD.EmblemEditor.RefreshPromptInputSource(f28_arg0)
	end
end

CoD.EmblemEditor.AddEmblemMenuButtons = function (f29_arg0)
	f29_arg0.emblemEditorLayerOptions:hide()
	f29_arg0:addLeftButtonPrompt(f29_arg0.editLayer)
	f29_arg0:addLeftButtonPrompt(f29_arg0.backButton)
	f29_arg0:addRightButtonPrompt(f29_arg0.chooseDifferentEmblem)
	f29_arg0:addRightButtonPrompt(f29_arg0.openClearLayerPopup)
	f29_arg0:addRightButtonPrompt(f29_arg0.copyLayer)
	if CoD.isPC then
		CoD.EmblemEditor.RefreshPromptInputSource(f29_arg0)
	end
end

CoD.EmblemEditor.AddEmblemMenuNewLayerButtons = function (f30_arg0)
	f30_arg0:addLeftButtonPrompt(f30_arg0.chooseEmblem)
	f30_arg0:addLeftButtonPrompt(f30_arg0.backButton)
	if CoD.isPC then
		CoD.EmblemEditor.RefreshPromptInputSource(f30_arg0)
	end
end

CoD.EmblemEditor.GetSelectedCard = function (f31_arg0)
	local f31_local0 = CoD.CardCarouselList.GetSelectedCarousel(f31_arg0.cardCarouselList)
	return CoD.CardCarousel.GetCardByIndex(f31_arg0.cardCarouselList.cardCarousels[f31_local0], CoD.CardCarousel.GetSelectedCardIndex(f31_arg0.cardCarouselList.cardCarousels[f31_local0]))
end

CoD.EmblemEditor.EditorCommitChanges = function (f32_arg0, f32_arg1)
	CoD.EmblemEditor.IsEditorModeActive = false
	f32_arg0.cardCarouselList:registerEventHandler("gamepad_button", CoD.CardCarouselList.Gamepad_Button)
	f32_arg0.emblemPane:processEvent({
		name = "lose_focus"
	})
	Engine.ExecNow(f32_arg1.controller, "emblemEndEdit")
	CoD.EmblemEditor.EmblemPaneSelected(f32_arg0, false)
	f32_arg0.buttonPromptList:removeAllChildren()
	f32_arg0.rightButtonPromptBar:removeAllChildren()
	f32_arg0.leftButtonPromptBar:removeAllChildren()
	CoD.EmblemEditor.AddEmblemMenuButtons(f32_arg0)
	f32_arg0.emblemEditorGrid:hide()
	f32_arg0.opacityValue:hide()
	if CoD.useMouse then
		f32_arg0.opacityControlBar:hide()
	end
	local f32_local0 = CoD.EmblemEditor.GetSelectedCardIndex(f32_arg0)
	f32_arg0.cardCarouselList:dispatchEventToChildren({
		name = "undo_fade_card",
		controller = f32_arg1.controller,
		selectedCardIndex = f32_local0
	})
	f32_arg0.cardCarouselList:dispatchEventToChildren({
		name = "hide_arrows",
		controller = f32_arg1.controller,
		selectedCardIndex = f32_local0
	})
	local f32_local1 = CoD.EmblemEditor.GetSelectedCardIndex(f32_arg0)
	if CoD.useMouse then
		f32_arg0.m_editLayerMode = false
		f32_arg0.emblemPane.m_editMode = false
		local f32_local2 = CoD.CardCarouselList.GetCarouselInFocus(f32_arg0.cardCarouselList)
		f32_local2:setMouseDisabled(false)
		f32_local2.mouseDragListener:setMouseDisabled(false)
	end
end

CoD.EmblemEditor.FlipImage = function (f33_arg0, f33_arg1)
	Engine.ExecNow(f33_arg1.controller, "emblemToggleFlip")
end

CoD.EmblemEditor.ControllerChanged = function (f34_arg0, f34_arg1)
	if CoD.isWIIU then
		if UIExpression.GetControllerType(controller) == "remote" then
			f34_arg0.scaleImage.prompt = Engine.Localize("MENU_EMBLEM_LAYER_SCALE_BUTTON_WIIU_REMOTE")
		else
			f34_arg0.scaleImage.prompt = Engine.Localize("MENU_EMBLEM_LAYER_SCALE_BUTTON_WIIU")
		end
		f34_arg0.scaleImage.buttonImage:setText(f34_arg0.scaleImage.prompt)
		f34_arg0.scaleImage.forceMeasureButtonWidth = true
		CoD.ButtonPrompt.ResizeButtonPrompt(f34_arg0.scaleImage)
	end
end

CoD.EmblemEditor.ResetLayer = function (f35_arg0, f35_arg1)
	Engine.ExecNow(f35_arg1.controller, "emblemRevertLayerChanges " .. CoD.EmblemEditor.GetSelectedCardIndex(f35_arg0) - 1)
end

CoD.EmblemEditor.ToggleGridLines = function (f36_arg0, f36_arg1)
	if f36_arg1.state == 1 then
		CoD.EmblemEditor.GridLinesVisible = true
		f36_arg0.emblemEditorGrid:show()
	elseif f36_arg1.state == 0 then
		CoD.EmblemEditor.GridLinesVisible = false
		f36_arg0.emblemEditorGrid:hide()
	end
end

CoD.EmblemEditor.ToggleOutline = function (f37_arg0, f37_arg1)
	Engine.ExecNow(f37_arg1.controller, "emblemToggleOutline")
end

CoD.EmblemEditor.SaveEmblemConfirmation = function (f38_arg0, f38_arg1)
	if Engine.IsEmblemEmpty(f38_arg1.controller) then
		f38_arg0:goBack(f38_arg1.controller)
		CoD.EmblemEditor.CurrentCarouselInfo = nil
	else
		f38_arg0:openPopup("SaveEmblemConfirmationPopup", f38_arg1.controller)
	end
end

CoD.EmblemEditor.OpenLayerOptionsPopup = function (f39_arg0, f39_arg1)
	f39_arg0:openPopup("LayerOptionsPopup", f39_arg1.controller)
end

CoD.EmblemEditor.OpenClearLayerPopup = function (f40_arg0, f40_arg1)
	f40_arg0:openPopup("ClearLayerPopup", f40_arg1.controller)
end

CoD.EmblemEditor.LayerLeft = function (f41_arg0, f41_arg1)
	Engine.ExecNow(f41_arg1.controller, "emblemMoveLayerRelative " .. -1)
	local f41_local0 = CoD.CardCarouselList.GetSelectedCarousel(f41_arg0.cardCarouselList)
	local f41_local1 = CoD.CardCarousel.GetSelectedCardIndex(f41_arg0.cardCarouselList.cardCarousels[f41_local0])
	CoD.EmblemEditor.UpdateLayers(CoD.CardCarousel.GetCardByIndex(f41_arg0.cardCarouselList.cardCarousels[f41_local0], f41_local1), f41_arg1.controller)
	if f41_local1 > 1 then
		CoD.EmblemEditor.UpdateLayers(CoD.CardCarousel.GetCardByIndex(f41_arg0.cardCarouselList.cardCarousels[f41_local0], f41_local1 - 1), f41_arg1.controller)
	end
	CoD.EmblemEditor.LayerMovementDirection = "left"
	f41_arg0.cardCarouselList:processEvent({
		name = "gamepad_button",
		button = "left",
		down = true,
		qualifier = "dpad",
		dummy = true
	})
	f41_arg0.cardCarouselList:processEvent({
		name = "gamepad_button",
		button = "left",
		down = false,
		qualifier = "dpad",
		dummy = true
	})
end

CoD.EmblemEditor.LayerRight = function (f42_arg0, f42_arg1)
	local f42_local0 = CoD.CardCarouselList.GetSelectedCarousel(f42_arg0.cardCarouselList)
	local f42_local1 = CoD.CardCarousel.GetSelectedCardIndex(f42_arg0.cardCarouselList.cardCarousels[f42_local0])
	local f42_local2 = CoD.CardCarousel.GetCardByIndex(f42_arg0.cardCarouselList.cardCarousels[f42_local0], f42_local1)
	Engine.ExecNow(f42_arg1.controller, "emblemMoveLayerRelative " .. 1)
	CoD.EmblemEditor.UpdateLayers(f42_local2, f42_arg1.controller)
	if f42_local1 < CoD.EmblemEditor.TotalLayers then
		CoD.EmblemEditor.UpdateLayers(CoD.CardCarousel.GetCardByIndex(f42_arg0.cardCarouselList.cardCarousels[f42_local0], f42_local1 + 1), f42_arg1.controller)
	end
	CoD.EmblemEditor.LayerMovementDirection = "right"
	f42_arg0.cardCarouselList:processEvent({
		name = "gamepad_button",
		button = "right",
		down = true,
		qualifier = "dpad",
		dummy = true
	})
	f42_arg0.cardCarouselList:processEvent({
		name = "gamepad_button",
		button = "right",
		down = false,
		qualifier = "dpad",
		dummy = true
	})
end

CoD.EmblemEditor.CopySelectedLayer = function (f43_arg0, f43_arg1)
	Engine.ExecNow(f43_arg1.controller, "emblemCopyLayer " .. CoD.EmblemEditor.GetSelectedCardIndex(f43_arg0) - 1)
	CoD.EmblemEditor.ClipboardWidgetVisibility(f43_arg0, 1)
	f43_arg0:addClipboardButtonPrompt(f43_arg0.pasteLayerButton)
end

CoD.EmblemEditor.GetSelectedCardIndex = function (f44_arg0)
	return CoD.CardCarousel.GetSelectedCardIndex(f44_arg0.cardCarouselList.cardCarousels[CoD.CardCarouselList.GetSelectedCarousel(f44_arg0.cardCarouselList)])
end

CoD.EmblemEditor.PasteSelectedLayer = function (f45_arg0, f45_arg1)
	local f45_local0 = CoD.CardCarouselList.GetSelectedCarousel(f45_arg0.cardCarouselList)
	local f45_local1 = CoD.CardCarousel.GetSelectedCardIndex(f45_arg0.cardCarouselList.cardCarousels[f45_local0])
	Engine.ExecNow(f45_arg1.controller, "emblemPasteLayer " .. f45_local1 - 1)
	CoD.EmblemEditor.UpdateLayerButtons(CoD.CardCarousel.GetCardByIndex(f45_arg0.cardCarouselList.cardCarousels[f45_local0], f45_local1), controller)
end

CoD.EmblemEditor.EditLayerColor = function (f46_arg0, f46_arg1)
	f46_arg0.cardCarouselList.m_inputDisabled = true
	CoD.EmblemEditor.EmblemPaneSelected(f46_arg0, false)
	f46_arg0.cardCarouselList:hide()
	f46_arg0.leftButtonPromptBar:removeAllChildren()
	f46_arg0.rightButtonPromptBar:removeAllChildren()
	local f46_local0 = CoD.EmblemEditor.GetSelectedCardIndex(f46_arg0)
	f46_arg0.cardCarouselList:dispatchEventToChildren({
		name = "hide_arrows",
		controller = f46_arg1.controller,
		selectedCardIndex = f46_local0
	})
	CoD.EmblemEditor.AnimateBottomLayerText(f46_arg0, f46_local0 - 1, true)
	CoD.EmblemEditorColors.CreateWindow(f46_arg0, f46_arg1.controller)
end

CoD.EmblemEditor.CreateEmblemMenuControls = function (f47_arg0)
	local f47_local0 = Engine.IsAnyEmblemIconNew(f47_arg0:getOwner())
	f47_arg0.editLayer = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_EMBLEM_EDIT_LAYER"), f47_arg0, "editLayerIcon")
	f47_arg0.chooseEmblem = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_EMBLEM_CHOOSE_EMBLEM"), f47_arg0, "chooseLayerImage")
	f47_arg0.chooseEmblem:setNew(f47_local0)
	f47_arg0.backButton = CoD.ButtonPrompt.new("secondary", Engine.Localize("PLATFORM_EMBLEM_EDIT_DONE"), f47_arg0, "button_prompt_closeEmblemMenu")
	f47_arg0:registerEventHandler("button_prompt_closeEmblemMenu", CoD.EmblemEditor.SaveEmblemConfirmation)
	local f47_local1 = CoD.ButtonPrompt.new
	local f47_local2 = "alt1"
	local f47_local3 = Engine.Localize("MENU_EMBLEM_CLEAR_LAYER")
	local f47_local4 = f47_arg0
	local f47_local5 = "openClearLayerPopup"
	local f47_local6, f47_local7 = false
	local f47_local8, f47_local9 = false
	f47_arg0.openClearLayerPopup = f47_local1(f47_local2, f47_local3, f47_local4, f47_local5, f47_local6, f47_local7, f47_local8, f47_local9, "X")
	f47_arg0:registerEventHandler("openClearLayerPopup", CoD.EmblemEditor.OpenClearLayerPopup)
	f47_local1 = CoD.ButtonPrompt.new
	f47_local2 = "alt2"
	f47_local3 = Engine.Localize("MENU_EMBLEM_CHANGE_EMBLEM")
	f47_local4 = f47_arg0
	f47_local5 = "chooseLayerImage"
	f47_local6, f47_local7 = false
	f47_local8, f47_local9 = false
	f47_arg0.chooseDifferentEmblem = f47_local1(f47_local2, f47_local3, f47_local4, f47_local5, f47_local6, f47_local7, f47_local8, f47_local9, "E")
	f47_arg0.chooseDifferentEmblem:setNew(f47_local0)
	f47_local1 = CoD.ButtonPrompt.new
	f47_local2 = "select"
	f47_local3 = Engine.Localize("MENU_EMBLEM_LAYER_COPY")
	f47_local4 = f47_arg0
	f47_local5 = "button_prompt_copyLayer"
	f47_local6, f47_local7 = false
	f47_local8, f47_local9 = false
	f47_arg0.copyLayer = f47_local1(f47_local2, f47_local3, f47_local4, f47_local5, f47_local6, f47_local7, f47_local8, f47_local9, "C")
	f47_arg0:registerEventHandler("button_prompt_copyLayer", CoD.EmblemEditor.CopySelectedLayer)
end

CoD.EmblemEditor.CreateEmblemEditorControls = function (f48_arg0)
	f48_arg0.moveImage = CoD.ButtonPrompt.new("emblem_move", Engine.Localize("MENU_EMBLEM_MOVE_EMBLEM"))
	f48_arg0.scaleImage = CoD.ButtonPrompt.new("emblem_scale", Engine.Localize("MENU_EMBLEM_FIXED_SCALE"))
	f48_arg0:registerEventHandler("controller_changed", CoD.EmblemEditor.ControllerChanged)
	f48_arg0:processEvent({
		name = "controller_changed",
		controller = f48_arg0:getOwner()
	})
	f48_arg0.toggleScaleMode = CoD.ButtonPrompt.new("right_stick_pressed", "", f48_arg0, "button_prompt_rightstickpressed", true)
	f48_arg0:registerEventHandler("button_prompt_rightstickpressed", CoD.EmblemEditor.ToggleScaleMode)
	local f48_local0 = CoD.ButtonPrompt.new
	local f48_local1 = "alt1"
	local f48_local2 = Engine.Localize("MENU_OPTIONS")
	local f48_local3 = f48_arg0
	local f48_local4 = "button_prompt_openLayerOptionsPopup"
	local f48_local5, f48_local6 = false
	local f48_local7, f48_local8 = false
	f48_arg0.layerOptionsPopup = f48_local0(f48_local1, f48_local2, f48_local3, f48_local4, f48_local5, f48_local6, f48_local7, f48_local8, "O")
	f48_arg0:registerEventHandler("button_prompt_openLayerOptionsPopup", CoD.EmblemEditor.OpenLayerOptionsPopup)
	f48_local0 = CoD.ButtonPrompt.new
	f48_local1 = "alt2"
	f48_local2 = Engine.Localize("MENU_EMBLEM_COLOR_PICKER")
	f48_local3 = f48_arg0
	f48_local4 = "button_prompt_editLayerColor"
	f48_local5, f48_local6 = false
	f48_local7, f48_local8 = false
	f48_arg0.editLayerColor = f48_local0(f48_local1, f48_local2, f48_local3, f48_local4, f48_local5, f48_local6, f48_local7, f48_local8, "R")
	f48_arg0:registerEventHandler("button_prompt_editLayerColor", CoD.EmblemEditor.EditLayerColor)
	f48_local0 = CoD.ButtonPrompt.new
	f48_local1 = "select"
	f48_local2 = Engine.Localize("PLATFORM_EMBLEM_TOGGLE_FLIP")
	f48_local3 = f48_arg0
	f48_local4 = "button_prompt_flip"
	f48_local5, f48_local6 = nil
	f48_local7, f48_local8 = false
	f48_arg0.flipImage = f48_local0(f48_local1, f48_local2, f48_local3, f48_local4, f48_local5, f48_local6, f48_local7, f48_local8, "F")
	f48_arg0:registerEventHandler("button_prompt_flip", CoD.EmblemEditor.FlipImage)
	f48_local0 = CoD.ButtonPrompt.new
	f48_local1 = "start"
	f48_local2 = Engine.Localize("PLATFORM_EMBLEM_TOGGLE_OUTLINE")
	f48_local3 = f48_arg0
	f48_local4 = "button_prompt_toggleOutline"
	f48_local5, f48_local6 = nil
	f48_local7, f48_local8 = false
	f48_arg0.toggleOutline = f48_local0(f48_local1, f48_local2, f48_local3, f48_local4, f48_local5, f48_local6, f48_local7, f48_local8, "T")
	f48_arg0:registerEventHandler("button_prompt_toggleOutline", CoD.EmblemEditor.ToggleOutline)
	f48_arg0.editorBackbutton = CoD.ButtonPrompt.new("secondary", Engine.Localize("MENU_BACK"), f48_arg0, "button_prompt_back")
	f48_arg0:registerEventHandler("button_prompt_back", CoD.EmblemEditor.EditorCommitChanges)
	f48_arg0.commitchange = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_EMBLEM_CONFIRM_CHANGES"), f48_arg0, "button_prompt_commitchange")
	f48_arg0:registerEventHandler("button_prompt_commitchange", CoD.EmblemEditor.EditorCommitChanges)
	f48_arg0.changeLayerOrder = CoD.ButtonPrompt.new("dpad_lr", Engine.Localize("MENU_CHANGE_EMBLEM_LAYER_ORDER"))
	f48_arg0.layerleft = CoD.ButtonPrompt.new("left", "", f48_arg0, "button_prompt_layerleft", true, "dpad")
	f48_arg0:registerEventHandler("button_prompt_layerleft", CoD.EmblemEditor.LayerLeft)
	f48_arg0.layerright = CoD.ButtonPrompt.new("right", "", f48_arg0, "button_prompt_layerright", true, "dpad")
	f48_arg0:registerEventHandler("button_prompt_layerright", CoD.EmblemEditor.LayerRight)
end

CoD.EmblemEditor.CreateEmblemEditorControlsKBM = function (f49_arg0)
	f49_arg0.rotateImage_kbm = CoD.ButtonPrompt.new("", Engine.Localize("PLATFORM_EMBLEM_ROTATE_LAYER_KBM"), nil, nil, true)
	f49_arg0.moveImage_kbm = CoD.ButtonPrompt.new("", Engine.Localize("PLATFORM_EMBLEM_MOVE_LAYER_KBM"), nil, nil, true)
	f49_arg0.scaleImage_kbm = CoD.ButtonPrompt.new("", Engine.Localize("PLATFORM_EMBLEM_SCALE_LAYER_KBM"), nil, nil, true)
	f49_arg0.fixedScaleImage_kbm = CoD.ButtonPrompt.new("", Engine.Localize("PLATFORM_EMBLEM_FIXED_SCALE_LAYER_KBM"), nil, nil, true)
	local f49_local0 = CoD.ButtonPrompt.new
	local f49_local1 = "left"
	local f49_local2 = Engine.Localize("PLATFORM_EMBLEM_LAYER_DOWN_KBM")
	local f49_local3 = f49_arg0
	local f49_local4 = "button_prompt_layerleft"
	local f49_local5, f49_local6 = false
	local f49_local7, f49_local8 = false
	f49_arg0.layerleft_kbm = f49_local0(f49_local1, f49_local2, f49_local3, f49_local4, f49_local5, f49_local6, f49_local7, f49_local8, "A")
	f49_local0 = CoD.ButtonPrompt.new
	f49_local1 = "right"
	f49_local2 = Engine.Localize("PLATFORM_EMBLEM_LAYER_UP_KBM")
	f49_local3 = f49_arg0
	f49_local4 = "button_prompt_layerright"
	f49_local5, f49_local6 = false
	f49_local7, f49_local8 = false
	f49_arg0.layerright_kbm = f49_local0(f49_local1, f49_local2, f49_local3, f49_local4, f49_local5, f49_local6, f49_local7, f49_local8, "D")
	f49_arg0:registerEventHandler("input_source_changed", CoD.EmblemEditor.InputSourceChanged)
end

CoD.EmblemEditor.InputSourceChanged = function (f50_arg0, f50_arg1)
	if f50_arg0.m_editLayerMode then
		f50_arg0.buttonPromptList:removeAllChildren()
		if f50_arg0.m_layerMoveMode then
			if f50_arg1.source == 0 then
				f50_arg0:addButtonPrompt(f50_arg0.moveImage)
				f50_arg0:addButtonPrompt(f50_arg0.scaleImage)
				f50_arg0:addButtonPrompt(CoD.EmblemEditor.RotateButtonPrompt())
			else
				f50_arg0:addButtonPrompt(f50_arg0.moveImage_kbm)
				f50_arg0:addButtonPrompt(f50_arg0.scaleImage_kbm)
				f50_arg0:addButtonPrompt(f50_arg0.fixedScaleImage_kbm)
				f50_arg0:addButtonPrompt(f50_arg0.rotateImage_kbm)
			end
			f50_arg0:addButtonPrompt(f50_arg0.flipImage)
			f50_arg0:addButtonPrompt(f50_arg0.toggleOutline)
			if f50_arg1.source == 0 then
				f50_arg0:addButtonPrompt(f50_arg0.changeLayerOrder)
				CoD.EmblemEditor.AddOpacityButtonPrompts(f50_arg0)
			else
				f50_arg0:addButtonPrompt(f50_arg0.layerleft_kbm)
				f50_arg0:addButtonPrompt(f50_arg0.layerright_kbm)
			end
			f50_arg0:addButtonPrompt(f50_arg0.editLayerColor)
		elseif f50_arg1.source == 0 then
			f50_arg0:addButtonPrompt(f50_arg0.chooseSwatch)
			CoD.EmblemEditor.AddOpacityButtonPrompts(f50_arg0)
			f50_arg0:addButtonPrompt(f50_arg0.colormixer)
		else
			f50_arg0:addButtonPrompt(f50_arg0.colormixer)
		end
	end
	f50_arg0:dispatchEventToChildren(f50_arg1)
end

CoD.EmblemEditor.ControlBarUpdated = function (f51_arg0, f51_arg1)
	if f51_arg1.barName == "opacity" then
		Engine.ExecNow(f51_arg1.controller, "emblemSetOpacity " .. f51_arg1.value)
		CoD.EmblemEditor.UpdateOpacityDisplay(f51_arg0, f51_arg1.controller)
	end
end

CoD.EmblemEditor.RefreshPromptInputSource = function (f52_arg0)
	local f52_local0 = 1
	if Engine.LastInput_Gamepad() then
		f52_local0 = 0
	end
	f52_arg0:dispatchEventToChildren({
		name = "input_source_changed",
		controller = f52_arg0:getOwner(),
		source = f52_local0
	})
end

CoD.EmblemEditor.EmblemPane_ScaleUpDown = function (f53_arg0, f53_arg1)
	if f53_arg1.qualifier == "mwheel" and f53_arg0.m_editMode then
		local f53_local0 = 0.02
		if f53_arg1.button == "up" then
			Engine.ExecNow(f53_arg1.controller, "emblemScale " .. f53_local0 .. " " .. f53_local0)
		else
			Engine.ExecNow(f53_arg1.controller, "emblemScale " .. -f53_local0 .. " " .. -f53_local0)
		end
	end
end

CoD.EmblemEditor.CreateAllButtonPrompts = function (f54_arg0)
	CoD.EmblemEditor.CreateEmblemMenuControls(f54_arg0)
	CoD.EmblemEditor.CreateEmblemEditorControls(f54_arg0)
	if CoD.isPC then
		CoD.EmblemEditor.CreateEmblemEditorControlsKBM(f54_arg0)
	end
end

CoD.EmblemEditor.DecreaseOpacity = function (f55_arg0, f55_arg1)
	Engine.ExecNow(f55_arg1.controller, "emblemDecreaseOpacity")
	CoD.EmblemEditor.UpdateOpacityDisplay(f55_arg0, f55_arg1.controller)
end

CoD.EmblemEditor.IncreaseOpacity = function (f56_arg0, f56_arg1)
	Engine.ExecNow(f56_arg1.controller, "emblemIncreaseOpacity")
	CoD.EmblemEditor.UpdateOpacityDisplay(f56_arg0, f56_arg1.controller)
end

CoD.EmblemEditor.UpdateOpacityDisplay = function (f57_arg0, f57_arg1)
	local f57_local0 = Engine.GetSelectedLayerColor(f57_arg1)
	f57_arg0.opacityValue:setText(Engine.Localize("MENU_EMBLEM_LAYER_OPACITY_VALUE", math.floor(f57_local0.alpha * 100)))
	if CoD.useMouse then
		f57_arg0.opacityControlBar:setValue(f57_local0.alpha)
	end
end

CoD.EmblemEditor.CreateOpacityStringWithButtons = function ()
	local f58_local0 = LUI.UIText.new()
	f58_local0:setLeftRight(true, false, 0, 100)
	f58_local0:setTopBottom(false, false, -CoD.textSize[CoD.ButtonPrompt.FontName] / 2, CoD.textSize[CoD.ButtonPrompt.FontName] / 2)
	f58_local0:setFont(CoD.fonts[CoD.ButtonPrompt.FontName])
	f58_local0:setText(Engine.Localize("MENU_EMBLEM_LAYER_OPACITY_BUTTON"))
	return f58_local0
end

CoD.EmblemEditor.AddOpacityButtonPrompts = function (f59_arg0)
	f59_arg0.decreaseOpacity = CoD.ButtonPrompt.new("shoulderl", "", f59_arg0, "button_prompt_leftbumper", true)
	f59_arg0:registerEventHandler("button_prompt_leftbumper", CoD.EmblemEditor.DecreaseOpacity)
	f59_arg0.increaseOpacity = CoD.ButtonPrompt.new("shoulderr", "", f59_arg0, "button_prompt_rightbumper", true)
	f59_arg0:registerEventHandler("button_prompt_rightbumper", CoD.EmblemEditor.IncreaseOpacity)
	f59_arg0.opacityButtonPrmpt = CoD.EmblemEditor.CreateOpacityStringWithButtons()
	f59_arg0:addButtonPrompt(f59_arg0.opacityButtonPrmpt)
	f59_arg0:addRightButtonPrompt(f59_arg0.increaseOpacity)
	f59_arg0:addRightButtonPrompt(f59_arg0.decreaseOpacity)
	f59_arg0.leftBumperRepeater = LUI.UIButtonRepeater.new("shoulderl", {
		name = "gamepad_button",
		button = "shoulderl",
		down = true
	})
	f59_arg0.rightBumperRepeater = LUI.UIButtonRepeater.new("shoulderr", {
		name = "gamepad_button",
		button = "shoulderr",
		down = true
	})
	f59_arg0:addElement(f59_arg0.leftBumperRepeater)
	f59_arg0:addElement(f59_arg0.rightBumperRepeater)
end

CoD.EmblemEditor.addButtonPrompt = function (f60_arg0, f60_arg1)
	f60_arg0.buttonPromptList:addElement(f60_arg1)
end

CoD.EmblemEditor.addClipboardButtonPrompt = function (f61_arg0, f61_arg1)
	f61_arg0.clipboardWidgetButtonPromptList:addElement(f61_arg1)
end

CoD.EmblemEditor.ClipboardWidgetVisibility = function (f62_arg0, f62_arg1)
	f62_arg0.clipboardWidget:setAlpha(f62_arg1)
end

CoD.EmblemEditor.CreateClipboardWidget = function (f63_arg0, f63_arg1)
	local f63_local0 = 205
	
	local clipboardWidget = LUI.UIElement.new()
	clipboardWidget:setLeftRight(true, false, CoD.EmblemEditor.EmblemWidth + 20, CoD.EmblemEditor.EmblemWidth + 20 + CoD.EmblemEditor.ClipboardWidgetWidth)
	clipboardWidget:setTopBottom(true, false, f63_local0, f63_local0 + CoD.EmblemEditor.ClipboardWidgetWidth)
	clipboardWidget:hide()
	f63_arg0:addElement(clipboardWidget)
	f63_arg0.clipboardWidget = clipboardWidget
	
	local f63_local2 = LUI.UIText.new()
	f63_local2:setLeftRight(true, false, 0, CoD.EmblemEditor.ClipboardWidgetWidth)
	f63_local2:setTopBottom(true, false, 0, CoD.textSize.Default)
	f63_local2:setText(Engine.Localize("MENU_EMBLEM_LAYER_CLIPBOARD"))
	clipboardWidget:addElement(f63_local2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.EmblemEditor.ClipboardWidgetWidth - 40)
	Widget:setTopBottom(true, false, 28, CoD.EmblemEditor.ClipboardWidgetWidth - 18)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.1))
	clipboardWidget:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 2, CoD.EmblemEditor.ClipboardWidgetWidth - 44)
	Widget:setTopBottom(true, false, 30, CoD.EmblemEditor.ClipboardWidgetWidth - 20)
	clipboardWidget:addElement(Widget)
	Widget:setupEmblemCopyWidget()
	f63_arg0.clipboardWidgetButtonPromptList = LUI.UIVerticalList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.EmblemEditor.EmblemWidth + 20,
		right = CoD.EmblemEditor.EmblemWidth + 20 + CoD.EmblemEditor.ClipboardWidgetWidth,
		topAnchor = true,
		bottomAnchor = false,
		top = f63_local0 + CoD.EmblemEditor.ClipboardWidgetWidth - 20,
		bottom = f63_local0 + CoD.EmblemEditor.ClipboardWidgetWidth,
		alignment = LUI.Alignment.Left
	})
	f63_arg0:addElement(f63_arg0.clipboardWidgetButtonPromptList)
	f63_arg0.addClipboardButtonPrompt = CoD.EmblemEditor.addClipboardButtonPrompt
	local f63_local5 = CoD.ButtonPrompt.new
	local f63_local6 = "start"
	local f63_local7 = Engine.Localize("MENU_EMBLEM_LAYER_PASTE")
	local f63_local8 = f63_arg0
	local f63_local9 = "button_prompt_pasteLayer"
	local f63_local10, f63_local11 = false
	local f63_local12, f63_local13 = false
	f63_arg0.pasteLayerButton = f63_local5(f63_local6, f63_local7, f63_local8, f63_local9, f63_local10, f63_local11, f63_local12, f63_local13, "V")
	f63_arg0:registerEventHandler("button_prompt_pasteLayer", CoD.EmblemEditor.PasteSelectedLayer)
end

CoD.EmblemEditor.AddTitle = function (f64_arg0)
	local f64_local0 = LUI.UIText.new()
	f64_local0:setLeftRight(true, false, 0, 0)
	f64_local0:setTopBottom(true, false, 0, CoD.textSize.Big)
	f64_local0:setFont(CoD.fonts.Big)
	f64_local0:setText(Engine.Localize("MENU_EMBLEM_EDITOR_CAPS"))
	f64_arg0:addElement(f64_local0)
end

CoD.EmblemEditor.SetupGridLines = function (f65_arg0, f65_arg1, f65_arg2, f65_arg3)
	local f65_local0 = CoD.EmblemEditor.GridLineSpacing * f65_arg3
	if f65_arg2 then
		f65_arg0:setLeftRight(true, false, f65_local0, f65_local0 + CoD.EmblemEditor.GridLineWidth)
		f65_arg0:setTopBottom(true, true, 0, 0)
		f65_arg0:setAlpha(f65_arg1)
	else
		f65_arg0:setLeftRight(true, true, 0, 0)
		f65_arg0:setTopBottom(true, false, f65_local0, f65_local0 + CoD.EmblemEditor.GridLineWidth)
		f65_arg0:setAlpha(f65_arg1)
	end
end

CoD.EmblemEditor.PrepareGrid = function (f66_arg0)
	local emblemEditorGrid = LUI.UIElement.new()
	emblemEditorGrid:setLeftRight(true, false, CoD.EmblemEditor.BorderWidth, CoD.EmblemEditor.EmblemWidth - CoD.EmblemEditor.BorderWidth)
	emblemEditorGrid:setTopBottom(true, false, CoD.EmblemEditor.EmblemPaneY + CoD.EmblemEditor.BorderWidth, CoD.EmblemEditor.EmblemPaneY + CoD.EmblemEditor.EmblemWidth - CoD.EmblemEditor.BorderWidth)
	f66_arg0:addElement(emblemEditorGrid)
	f66_arg0.emblemEditorGrid = emblemEditorGrid
	
	f66_arg0.emblemEditorGrid:hide()
	for f66_local1 = 1, CoD.EmblemEditor.MaximumGridLines, 1 do
		local f66_local4 = LUI.UIImage.new()
		if f66_local1 == (CoD.EmblemEditor.MaximumGridLines + 1) / 2 then
			CoD.EmblemEditor.SetupGridLines(f66_local4, 0.3, true, f66_local1)
		else
			CoD.EmblemEditor.SetupGridLines(f66_local4, 0.1, true, f66_local1)
		end
		f66_arg0.emblemEditorGrid:addElement(f66_local4)
	end
	for f66_local1 = 1, CoD.EmblemEditor.MaximumGridLines, 1 do
		local f66_local4 = LUI.UIImage.new()
		if f66_local1 == (CoD.EmblemEditor.MaximumGridLines + 1) / 2 then
			CoD.EmblemEditor.SetupGridLines(f66_local4, 0.3, false, f66_local1)
		else
			CoD.EmblemEditor.SetupGridLines(f66_local4, 0.1, false, f66_local1)
		end
		f66_arg0.emblemEditorGrid:addElement(f66_local4)
	end
end

CoD.EmblemEditor.AddEmblemDrawingArea = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, CoD.EmblemEditor.BorderWidth, CoD.EmblemEditor.EmblemWidth - CoD.EmblemEditor.BorderWidth)
	Widget:setTopBottom(true, false, CoD.EmblemEditor.EmblemPaneY + CoD.EmblemEditor.BorderWidth, CoD.EmblemEditor.EmblemPaneY + CoD.EmblemEditor.EmblemWidth - CoD.EmblemEditor.BorderWidth)
	HudRef:addElement(Widget)
	Widget:setupEmblem()
	HudRef.emblemPane = Widget
	
	local pulseEmblemLayer = LUI.UIElement.new()
	pulseEmblemLayer:setLeftRight(true, false, CoD.EmblemEditor.BorderWidth, CoD.EmblemEditor.EmblemWidth - CoD.EmblemEditor.BorderWidth)
	pulseEmblemLayer:setTopBottom(true, false, CoD.EmblemEditor.EmblemPaneY + CoD.EmblemEditor.BorderWidth, CoD.EmblemEditor.EmblemPaneY + CoD.EmblemEditor.EmblemWidth - CoD.EmblemEditor.BorderWidth)
	HudRef:addElement(pulseEmblemLayer)
	HudRef.pulseEmblemLayer = pulseEmblemLayer
	
	pulseEmblemLayer:registerEventHandler("transition_complete_hidden_layer_blue", CoD.EmblemEditor.HiddenLayerBlueComplete)
	if CoD.isPC then
		Widget.handleGamepadButton = CoD.EmblemEditor.EmblemPane_ScaleUpDown
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, CoD.EmblemEditor.EmblemWidth)
	Widget:setTopBottom(true, false, CoD.EmblemEditor.EmblemPaneY, CoD.EmblemEditor.EmblemPaneY + CoD.EmblemEditor.EmblemWidth)
	HudRef:addElement(Widget)
	HudRef.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	Widget:addElement(HudRef.border)
	CoD.EmblemEditor.PrepareGrid(HudRef)
end

CoD.EmblemEditor.AddLayersUsedText = function (f68_arg0)
	local MOfNLayersUsed = LUI.UIText.new()
	MOfNLayersUsed:setLeftRight(false, true, -150, 0)
	MOfNLayersUsed:setTopBottom(true, false, CoD.EmblemEditor.EmblemPaneY, CoD.EmblemEditor.EmblemPaneY + CoD.textSize.Default)
	MOfNLayersUsed:setFont(CoD.fonts.Default)
	MOfNLayersUsed:setAlignment(LUI.Alignment.Right)
	f68_arg0:addElement(MOfNLayersUsed)
	f68_arg0.MOfNLayersUsed = MOfNLayersUsed
	
end

CoD.EmblemEditor.AddBottomLayerTextElement = function (f69_arg0)
	local bottomLayerElement = LUI.UIText.new()
	bottomLayerElement:setLeftRight(true, true, 0, 0)
	bottomLayerElement:setTopBottom(false, true, -215 - CoD.textSize.Default, -215)
	bottomLayerElement:setAlpha(0.6)
	bottomLayerElement:setFont(CoD.fonts.Default)
	bottomLayerElement:setAlignment(LUI.Alignment.Left)
	bottomLayerElement:setText(Engine.Localize("MENU_BOTTOM_LAYER"))
	f69_arg0:addElement(bottomLayerElement)
	f69_arg0.bottomLayerElement = bottomLayerElement
	
end

CoD.EmblemEditor.LayerControlScheme = function (f70_arg0)
	local emblemEditorLayerOptions = LUI.UIText.new()
	emblemEditorLayerOptions:setLeftRight(true, false, CoD.EmblemEditor.EmblemWidth + 30, CoD.EmblemEditor.EmblemWidth + 170)
	emblemEditorLayerOptions:setTopBottom(true, false, CoD.EmblemEditor.EmblemPaneY, CoD.EmblemEditor.EmblemPaneY + CoD.textSize.Default)
	emblemEditorLayerOptions:setFont(CoD.fonts.Default)
	emblemEditorLayerOptions:hide()
	emblemEditorLayerOptions:setText(Engine.Localize("MENU_CONTROLS"))
	f70_arg0:addElement(emblemEditorLayerOptions)
	f70_arg0.emblemEditorLayerOptions = emblemEditorLayerOptions
	
	f70_arg0.buttonPromptList = LUI.UIVerticalList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.EmblemEditor.EmblemWidth + 30,
		right = CoD.EmblemEditor.EmblemWidth + 170,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.EmblemEditor.EmblemPaneY + CoD.textSize.Default + 5,
		bottom = 0,
		spacing = 5,
		alignment = LUI.Alignment.Left
	})
	f70_arg0:addElement(f70_arg0.buttonPromptList)
	f70_arg0.addButtonPrompt = CoD.EmblemEditor.addButtonPrompt
end

CoD.EmblemEditor.UploadDone = function (f71_arg0, f71_arg1)
	if f71_arg1.success == true then
		f71_arg0:goBack(f71_arg1.controller)
	end
end

CoD.EmblemEditor.AddEventHandlers = function (f72_arg0)
	f72_arg0:registerEventHandler("chooseLayerImage", CoD.EmblemEditor.ChooseLayerIcon)
	f72_arg0:registerEventHandler("editLayerIcon", CoD.EmblemEditor.EditLayerIcon)
	f72_arg0:registerEventHandler("card_gain_focus", CoD.EmblemEditor.CardGainFocus)
	f72_arg0:registerEventHandler("resetLayer", CoD.EmblemEditor.ResetLayer)
	f72_arg0:registerEventHandler("toggleGridLines", CoD.EmblemEditor.ToggleGridLines)
	f72_arg0:registerEventHandler("clearLayer", CoD.EmblemEditor.ClearLayer)
	f72_arg0:registerEventHandler("emblem_upload_done", CoD.EmblemEditor.UploadDone)
end

CoD.EmblemEditor.AddOpacityValue = function (f73_arg0, f73_arg1)
	local f73_local0 = CoD.EmblemEditor.EmblemPaneY + CoD.EmblemEditor.EmblemWidth
	local f73_local1 = Engine.GetSelectedLayerColor(f73_arg1)
	local f73_local2 = LUI.UIText.new()
	f73_local2:setLeftRight(true, true, 0, 0)
	f73_local2:setTopBottom(true, false, f73_local0, f73_local0 + CoD.textSize.Default)
	f73_local2:setFont(CoD.fonts.Default)
	f73_local2:setAlignment(LUI.Alignment.Left)
	f73_arg0.opacityValue = f73_local2
	f73_local2:hide()
	f73_arg0:addElement(f73_local2)
	if CoD.useMouse then
		local f73_local3 = f73_local0 + 15
		local f73_local4 = CoD.EmblemEditor.EmblemWidth * 0.5
		local f73_local5 = CoD.MouseControlBar.new("opacity", f73_local1.alpha, 0, 1, f73_local4)
		f73_local5:setLeftRight(true, false, f73_local4, f73_local4 + f73_local4)
		f73_local5:setTopBottom(true, false, f73_local3, f73_local3 + 10)
		f73_local5:hide()
		f73_arg0.opacityControlBar = f73_local5
		f73_arg0:addElement(f73_local5)
		f73_arg0:registerEventHandler("control_bar_updated", CoD.EmblemEditor.ControlBarUpdated)
	end
end

CoD.EmblemEditor.GoBack = function (f74_arg0, f74_arg1)
	Engine.ExecNow(f74_arg1, "emblemEndEdit")
	CoD.Menu.goBack(f74_arg0, f74_arg1)
end

LUI.createMenu.EmblemEditor = function (f75_arg0, f75_arg1)
	local f75_local0 = CoD.Menu.New("EmblemEditor")
	Engine.ExecNow(f75_arg0, "emblemFlushResults")
	CoD.EmblemEditor.IsEditorModeActive = false
	Engine.ExecNow(f75_arg0, "emblemEndEdit")
	Engine.Exec(f75_arg0, "resetThumbnailViewer")
	f75_local0:addLargePopupBackground()
	f75_local0:setOwner(f75_arg0)
	f75_local0:setPreviousMenu("CODTv")
	f75_local0.goBack = CoD.EmblemEditor.GoBack
	f75_local0:addTitle(Engine.Localize("MENU_EMBLEM_EDITOR_CAPS"), LUI.Alignment.Left)
	CoD.EmblemEditor.AddEventHandlers(f75_local0)
	CoD.EmblemEditor.AddLayersUsedText(f75_local0)
	CoD.EmblemEditor.LayerControlScheme(f75_local0)
	CoD.EmblemEditor.AddBottomLayerTextElement(f75_local0)
	CoD.EmblemEditor.CreateAllButtonPrompts(f75_local0)
	CoD.EmblemEditor.AddEmblemMenuButtons(f75_local0)
	CoD.EmblemEditor.AddEmblemDrawingArea(f75_local0, f75_arg0)
	CoD.EmblemEditor.AddOpacityValue(f75_local0, f75_arg0)
	CoD.EmblemEditor.AddLayersCarousel(f75_local0, f75_arg0)
	CoD.EmblemEditor.CreateClipboardWidget(f75_local0, f75_arg0)
	if f75_arg1 ~= nil and f75_arg1.openEditLayerEvent ~= nil then
		f75_local0:processEvent({
			name = f75_arg1.openEditLayerEvent,
			controller = f75_arg0
		})
	end
	return f75_local0
end

LUI.createMenu.SaveEmblemConfirmationPopup = function (f76_arg0)
	local f76_local0 = CoD.Popup.SetupPopupChoice("SaveEmblemConfirmationPopup", f76_arg0)
	f76_local0:registerEventHandler("saveChanges", CoD.EmblemEditor.SaveEmblem)
	f76_local0:registerEventHandler("saveChangesAndSetIdentity", CoD.EmblemEditor.SaveAndSetEmblem)
	f76_local0:registerEventHandler("discardChanges", CoD.EmblemEditor.ExitEmblemEditor)
	f76_local0.choiceList:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 4 + 10, 0)
	f76_local0:addBackButton()
	f76_local0.title:setText(Engine.Localize("MENU_SAVE_EMBLEM_CHANGES"))
	f76_local0.choiceA:setLabel(Engine.Localize("MENU_EMBLEM_SAVE_AND_SET"))
	f76_local0.choiceA:setActionEventName("saveChangesAndSetIdentity")
	f76_local0.choiceA:processEvent({
		name = "gain_focus"
	})
	f76_local0.choiceB:setLabel(Engine.Localize("MENU_EMBLEM_SAVE_CHANGES"))
	f76_local0.choiceB:setActionEventName("saveChanges")
	local f76_local1 = f76_local0.choiceList:addButton(Engine.Localize("MENU_EMBLEMS_DISCARD"))
	f76_local1:setActionEventName("discardChanges")
	Engine.PlaySound("cac_loadout_edit_sel")
	return f76_local0
end

CoD.EmblemEditor.SaveEmblem = function (f77_arg0, f77_arg1)
	if CoD.FileAction.AnyFileshareTaskInProgress(f77_arg1.controller) == false then
		Engine.Exec(f77_arg1.controller, "uploadstats")
		local f77_local0 = f77_arg0.occludedMenu
		f77_arg0:goBack(f77_arg1.controller)
		f77_local0:openPopup("Fileshare_BusyPopup", f77_arg1.controller, {
			title = Engine.Localize("MENU_EMBLEM_UPLOAD"),
			message = Engine.Localize("MENU_EMBLEM_UPLOAD_WAIT"),
			successNotice = Engine.Localize("MENU_EMBLEM_UPLOAD_SUCCESS"),
			failureNotice = Engine.Localize("MENU_EMBLEM_UPLOAD_FAILURE"),
			actionCommand = "emblemUploadToSlot " .. CoD.perController[f77_arg1.controller].emblemSaveSlot .. " 0",
			completionEvent = "fileshare_upload_complete",
			completionNotification = "emblem_upload_done"
		})
		CoD.EmblemEditor.CurrentCarouselInfo = nil
	end
end

CoD.EmblemEditor.SaveAndSetEmblem = function (f78_arg0, f78_arg1)
	if CoD.FileAction.AnyFileshareTaskInProgress(f78_arg1.controller) == false then
		Engine.Exec(f78_arg1.controller, "uploadstats")
		local f78_local0 = f78_arg0.occludedMenu
		f78_arg0:goBack(f78_arg1.controller)
		f78_local0:openPopup("Fileshare_BusyPopup", f78_arg1.controller, {
			title = Engine.Localize("MENU_EMBLEM_UPLOAD"),
			message = Engine.Localize("MENU_EMBLEM_UPLOAD_WAIT"),
			successNotice = Engine.Localize("MENU_EMBLEM_UPLOAD_SUCCESS"),
			failureNotice = Engine.Localize("MENU_EMBLEM_UPLOAD_FAILURE"),
			actionCommand = "emblemUploadToSlot " .. CoD.perController[f78_arg1.controller].emblemSaveSlot .. " 1",
			completionEvent = "fileshare_upload_complete",
			completionNotification = "emblem_upload_done"
		})
		CoD.EmblemEditor.CurrentCarouselInfo = nil
	end
end

CoD.EmblemEditor.ExitEmblemEditor = function (f79_arg0, f79_arg1)
	f79_arg0:goBack(f79_arg1.controller)
	f79_arg0.occludedMenu:goBack(f79_arg1.controller)
	CoD.EmblemEditor.CurrentCarouselInfo = nil
end

LUI.createMenu.LayerOptionsPopup = function (f80_arg0)
	local f80_local0 = CoD.Popup.SetupPopupChoice("LayerOptionsPopup", f80_arg0)
	Engine.ExecNow(f80_arg0, "emblemEndEdit")
	f80_local0:registerEventHandler("resetLayerButtonAction", CoD.EmblemEditor.ResetLayerButtonPressed)
	f80_local0:registerEventHandler("turnoffGridLines", CoD.EmblemEditor.TurnOffGridLines)
	f80_local0:registerEventHandler("turnOnGridLines", CoD.EmblemEditor.TurnOnGridLines)
	f80_local0:registerEventHandler("button_prompt_back", CoD.EmblemEditor.LayerOptionsBackButtonAction)
	f80_local0:addBackButton()
	f80_local0.title:setText(Engine.Localize("MENU_EMBLEM_LAYER_OPTIONS"))
	f80_local0.choiceA:setLabel(Engine.Localize("MENU_EMBLEM_RESET_LAYER"))
	f80_local0.choiceA:setActionEventName("resetLayerButtonAction")
	if CoD.EmblemEditor.GridLinesVisible then
		f80_local0.choiceB:setLabel(Engine.Localize("MENU_EMBLEM_GRID_LINES_TURNOFF"))
		f80_local0.choiceB:setActionEventName("turnoffGridLines")
	else
		f80_local0.choiceB:setLabel(Engine.Localize("MENU_EMBLEM_GRID_LINES_TURNON"))
		f80_local0.choiceB:setActionEventName("turnOnGridLines")
	end
	f80_local0.choiceA:processEvent({
		name = "gain_focus"
	})
	return f80_local0
end

CoD.EmblemEditor.ResetLayerButtonPressed = function (f81_arg0, f81_arg1)
	f81_arg0.occludedMenu:processEvent({
		name = "resetLayer",
		controller = f81_arg1.controller
	})
	CoD.EmblemEditor.LayerOptionsBackButtonAction(f81_arg0, f81_arg1)
end

CoD.EmblemEditor.TurnOnGridLines = function (f82_arg0, f82_arg1)
	f82_arg0.occludedMenu:processEvent({
		name = "toggleGridLines",
		controller = f82_arg1.controller,
		state = 1
	})
	CoD.EmblemEditor.LayerOptionsBackButtonAction(f82_arg0, f82_arg1)
end

CoD.EmblemEditor.TurnOffGridLines = function (f83_arg0, f83_arg1)
	f83_arg0.occludedMenu:processEvent({
		name = "toggleGridLines",
		controller = f83_arg1.controller,
		state = 0
	})
	CoD.EmblemEditor.LayerOptionsBackButtonAction(f83_arg0, f83_arg1)
end

CoD.EmblemEditor.LayerOptionsBackButtonAction = function (f84_arg0, f84_arg1)
	Engine.ExecNow(f84_arg1.controller, "emblemBeginEdit")
	f84_arg0:goBack(f84_arg1.controller)
end

LUI.createMenu.ClearLayerPopup = function (f85_arg0)
	local f85_local0 = CoD.Popup.SetupPopupChoice("ClearLayerPopup", f85_arg0)
	f85_local0:registerEventHandler("clearLayerConfirmed", CoD.EmblemEditor.ClearLayerConfirmed)
	f85_local0:addBackButton()
	f85_local0.title:setText(Engine.Localize("MENU_EMBLEM_CLEAR_LAYER_CAPS"))
	f85_local0.choiceA:setLabel(Engine.Localize("MENU_YES"))
	f85_local0.choiceA:setActionEventName("clearLayerConfirmed")
	f85_local0.choiceB:setLabel(Engine.Localize("MENU_NO"))
	f85_local0.choiceB:setActionEventName("button_prompt_back")
	f85_local0.choiceB:processEvent({
		name = "gain_focus"
	})
	Engine.PlaySound("cac_loadout_edit_sel")
	return f85_local0
end

CoD.EmblemEditor.ClearLayerConfirmed = function (f86_arg0, f86_arg1)
	f86_arg0.occludedMenu:processEvent({
		name = "clearLayer",
		controller = f86_arg1.controller
	})
	f86_arg0:goBack(f86_arg1.controller)
end

