require("T6.Menus.EmblemEditor")
CoD.EmblemEditorCarousel = {}
CoD.EmblemEditorCarousel.AddCarousels = function (f1_arg0, f1_arg1)
	CoD.EmblemEditorCarousel.AddEmblemEditorCarousel("MENU_EMBLEM_EDITOR_CAPS", f1_arg0, f1_arg1)
end

CoD.EmblemEditorCarousel.OpenEmblemEditor = function (f2_arg0, f2_arg1)
	if Engine.IsFeatureBanned(CoD.FEATURE_BAN_EMBLEM_EDITOR) then
		Engine.ExecNow(f2_arg1.controller, "banCheck " .. CoD.FEATURE_BAN_EMBLEM_EDITOR)
		return 
	else
		f2_arg0:openMenu("EmblemEditor", f2_arg1.controller)
		f2_arg0:close()
	end
end

CoD.EmblemEditorCarousel.UpdateCard = function (f3_arg0, f3_arg1, f3_arg2)
	CoD.Barracks.SetupCarouselCard(f3_arg0, "", nil, 0, 0, 0)
	if Engine.IsEmblemEmpty(f3_arg2) then
		f3_arg0.title:setText(Engine.Localize("MENU_EMBLEM_NEW_EMBLEM"))
	else
		local f3_local0 = CoD.Barracks.HighlightedItemHeight - CoD.textSize.Default - CoD.Barracks.EmblemEditorIconOffset
		local f3_local1 = f3_local0
		local f3_local2 = -10
		f3_arg0.emblemPane = LUI.UIElement.new()
		f3_arg0.emblemPane:setLeftRight(false, false, -f3_local1 / 2, f3_local1 / 2)
		f3_arg0.emblemPane:setTopBottom(false, false, -f3_local0 / 2 + f3_local2, f3_local0 / 2 + f3_local2)
		f3_arg0.emblemPane:setupEmblem()
		f3_arg0:addElement(f3_arg0.emblemPane)
	end
	f3_arg0.popup = f3_arg1.popup
	f3_arg0:setActionEventName("open_emblemeditor")
end

CoD.EmblemEditorCarousel.AddEmblemEditorCarousel = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = f4_arg1:addCardCarousel("")
	CoD.EmblemEditorCarousel.UpdateCard(f4_local0:addNewCard(), f4_arg1, f4_arg2)
end

CoD.EmblemEditorCarousel.DeleteEmblem = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0:openPopup("ConfirmEmblemDelete", f5_arg1.controller)
end

CoD.EmblemEditorCarousel.AddEmblemEditorCarouselButtons = function (f6_arg0, f6_arg1)
	f6_arg0.rightButtonPromptBar:removeAllChildren()
	if not Engine.IsEmblemEmpty(f6_arg1) then
		f6_arg0:addRightButtonPrompt(f6_arg0.deleteEmblem)
	end
end

CoD.EmblemEditorCarousel.CreateButtonPrompts = function (f7_arg0)
	local f7_local0 = CoD.ButtonPrompt.new
	local f7_local1 = "alt2"
	local f7_local2 = Engine.Localize("MENU_EMBLEM_COPY")
	local f7_local3 = f7_arg0
	local f7_local4 = "button_prompt_copy"
	local f7_local5, f7_local6 = false
	local f7_local7, f7_local8 = false
	f7_arg0.copyEmblem = f7_local0(f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7, f7_local8, "C")
	f7_local0 = CoD.ButtonPrompt.new
	f7_local1 = "alt1"
	f7_local2 = Engine.Localize("MENU_EMBLEM_DELETE")
	f7_local3 = f7_arg0
	f7_local4 = "button_prompt_delete"
	f7_local5, f7_local6 = false
	f7_local7, f7_local8 = false
	f7_arg0.deleteEmblem = f7_local0(f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7, f7_local8, "DEL")
	f7_arg0:registerEventHandler("button_prompt_delete", CoD.EmblemEditorCarousel.DeleteEmblem)
	f7_local0 = CoD.ButtonPrompt.new
	f7_local1 = "select"
	f7_local2 = Engine.Localize("MENU_EMBLEM_EDIT_TITLE")
	f7_local3 = f7_arg0
	f7_local4 = "button_prompt_edit_title"
	f7_local5, f7_local6 = false
	f7_local7, f7_local8 = false
	f7_arg0.editEmblemTitle = f7_local0(f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7, f7_local8, "E")
end

CoD.EmblemEditorCarousel.CardLoseFocus = function (f8_arg0, f8_arg1)
	f8_arg0:dispatchEventToChildren({
		name = "hint_text_fade_out"
	})
end

CoD.EmblemEditorCarousel.CardGainFocus = function (f9_arg0, f9_arg1)
	f9_arg0:dispatchEventToChildren({
		name = "hint_text_fade_in",
		hintText = Engine.Localize("MENU_EMBLEM_HINTTEXT")
	})
end

CoD.EmblemEditorCarousel.UpdateCarousel = function (f10_arg0, f10_arg1)
	CoD.EmblemEditorCarousel.AddEmblemEditorCarouselButtons(f10_arg0, f10_arg1.controller)
	if f10_arg0.cardCarouselList.cardCarousels then
		for f10_local0 = 1, #f10_arg0.cardCarouselList.cardCarousels, 1 do
			local f10_local3 = f10_arg0.cardCarouselList.cardCarousels[f10_local0]
			if f10_local3 then
				for f10_local4 = 1, #f10_local3.horizontalList.cards, 1 do
					CoD.EmblemEditorCarousel.UpdateCard(f10_local3.horizontalList.cards[f10_local4], f10_arg0.cardCarouselList, f10_arg1.controller)
				end
			end
		end
	end
	CoD.CardCarouselList.FocusCurrentCardCarousel(f10_arg0.cardCarouselList, f10_arg1.controller)
end

LUI.createMenu.EmblemEditorCarousel = function (f11_arg0)
	local f11_local0 = CoD.Menu.New("EmblemEditorCarousel")
	f11_local0:addLargePopupBackground()
	f11_local0:setOwner(f11_arg0)
	f11_local0:registerEventHandler("card_gain_focus", CoD.EmblemEditorCarousel.CardGainFocus)
	f11_local0:registerEventHandler("card_lose_focus", CoD.EmblemEditorCarousel.CardLoseFocus)
	f11_local0:registerEventHandler("open_emblemeditor", CoD.EmblemEditorCarousel.OpenEmblemEditor)
	f11_local0:registerEventHandler("update_carousel", CoD.EmblemEditorCarousel.UpdateCarousel)
	f11_local0:addSelectButton()
	f11_local0:addBackButton()
	f11_local0:setPreviousMenu("Barracks")
	CoD.EmblemEditorCarousel.CreateButtonPrompts(f11_local0)
	CoD.EmblemEditorCarousel.AddEmblemEditorCarouselButtons(f11_local0, f11_arg0)
	f11_local0:addTitle(Engine.Localize("MENU_EMBLEM_EDITOR_CAPS"))
	f11_local0.cardCarouselList = CoD.CardCarouselList.new(nil, f11_arg0, CoD.Barracks.ItemWidth, CoD.Barracks.ItemHeight, CoD.Barracks.HighlightedItemWidth, CoD.Barracks.HighligtedItemHeight, CoD.Barracks.HintTextParams)
	f11_local0.cardCarouselList:setLeftRight(true, true, 0, 0)
	f11_local0.cardCarouselList:setTopBottom(true, true, CoD.textSize.Big + 10, 0)
	f11_local0:addElement(f11_local0.cardCarouselList)
	f11_local0.cardCarouselList.popup = f11_local0
	CoD.EmblemEditorCarousel.AddCarousels(f11_local0.cardCarouselList, f11_arg0)
	CoD.CardCarouselList.FocusCurrentCardCarousel(f11_local0.cardCarouselList, f11_arg0)
	return f11_local0
end

CoD.EmblemEditorCarousel.DeleteEmblemComfirmed = function (f12_arg0, f12_arg1)
	Engine.ExecNow(f12_arg1.controller, "emblemclearall")
	Engine.ExecNow(f12_arg1.controller, "emblemsetprofile")
	if f12_arg0.occludedMenu then
		f12_arg0.occludedMenu:processEvent({
			name = "update_carousel",
			controller = f12_arg1.controller
		})
	end
	f12_arg0:goBack()
end

LUI.createMenu.ConfirmEmblemDelete = function (f13_arg0)
	local f13_local0 = CoD.Menu.NewSmallPopup("ConfirmEmblemDelete")
	f13_local0:addSelectButton()
	f13_local0:addBackButton()
	f13_local0:registerEventHandler("confirm_action", CoD.EmblemEditorCarousel.DeleteEmblemComfirmed)
	f13_local0:registerEventHandler("cancel_action", CoD.Menu.ButtonPromptBack)
	f13_local0:addTitle(Engine.Localize("MENU_EMBLEM_DELETE_POPUP_TITLE"))
	f13_local0.subTitle = LUI.UIText.new()
	f13_local0.subTitle:setLeftRight(true, true, 0, 0)
	f13_local0.subTitle:setTopBottom(true, false, CoD.textSize.Big, CoD.textSize.Big + CoD.textSize.Default)
	f13_local0.subTitle:setFont(CoD.fonts.Default)
	f13_local0.subTitle:setAlignment(LUI.Alignment.Left)
	f13_local0.subTitle:setText(Engine.Localize("MENU_EMBLEM_DELETE_POPUP_DESC"))
	f13_local0:addElement(f13_local0.subTitle)
	local f13_local1 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	f13_local0:addElement(f13_local1)
	local f13_local2 = f13_local1:addButton(Engine.Localize("MPUI_YES"))
	f13_local2:setActionEventName("confirm_action")
	local f13_local3 = f13_local1:addButton(Engine.Localize("MPUI_NO"))
	f13_local3:setActionEventName("cancel_action")
	f13_local3:processEvent({
		name = "gain_focus"
	})
	return f13_local0
end

