require("T6.CoDBase")
CoD.StrikeForceMenu = {}
CoD.StrikeForceMenu.ButtonPromptBack = function (f1_arg0, f1_arg1)
	Engine.SendMenuResponse(f1_arg1.controller, "strikeforce_action", "shutdown")
	f1_arg0:close()
end

CoD.StrikeForceMenu.ButtonAction = function (f2_arg0, f2_arg1)
	Engine.SendMenuResponse(f2_arg1.controller, "strikeforce_action", "launch")
	f2_arg0:close()
end

CoD.StrikeForceMenu.AddStrikeforceMission = function (f3_arg0, f3_arg1)
	local f3_local0 = CoD.NavButton.new(nil, Engine.Localize(UIExpression.TableLookup(nil, "sp/levelLookup.csv", 0, f3_arg1.data[1], 9) .. "_CAPS"), "")
	f3_local0:setupCarouselMode()
	f3_local0:registerEventHandler("carousel_scroll_complete", CoD.StrikeForceMenu.CarouselScrollComplete)
	f3_arg0.carousel:addItem(f3_local0)
	f3_arg0.carousel:scrollToItem(1, 0)
end

CoD.StrikeForceMenu.CarouselScroll = function (f4_arg0, f4_arg1)
	local f4_local0 = UIExpression.GetPrimaryController()
	if f4_arg0.carousel.m_currentItem < f4_arg0.current_item then
		Engine.SendMenuResponse(f4_local0, "strikeforce_action", "prev_target")
	elseif f4_arg0.current_item < f4_arg0.carousel.m_currentItem then
		Engine.SendMenuResponse(f4_local0, "strikeforce_action", "next_target")
	end
	f4_arg0.current_item = f4_arg0.carousel.m_currentItem
end

CoD.StrikeForceMenu.CarouselScrollComplete = function (f5_arg0, f5_arg1)
	f5_arg0:dispatchEventToParent({
		name = "scroll_changed"
	})
end

LUI.createMenu.StrikeForceMenu = function (f6_arg0, f6_arg1)
	local f6_local0 = CoD.Menu.New("StrikeForceMenu")
	f6_local0:registerEventHandler("button_prompt_nexttarget", CoD.StrikeForceMenu.ButtonPromptNextTarget)
	f6_local0:registerEventHandler("button_prompt_prevtarget", CoD.StrikeForceMenu.ButtonPromptPrevTarget)
	f6_local0:registerEventHandler("button_prompt_back", CoD.StrikeForceMenu.ButtonPromptBack)
	f6_local0:registerEventHandler("button_action", CoD.StrikeForceMenu.ButtonAction)
	f6_local0:registerEventHandler("scroll_changed", CoD.StrikeForceMenu.CarouselScroll)
	f6_local0:registerEventHandler("add_strikeforcemission", CoD.StrikeForceMenu.AddStrikeforceMission)
	f6_local0.selectButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_SELECT"), f6_local0, "button_action")
	f6_local0:addLeftButtonPrompt(f6_local0.selectButton)
	f6_local0:addBackButton()
	local f6_local1 = 400
	local f6_local2 = 200
	f6_local0.carousel = CoD.VerticalCarousel.new({
		left = 0,
		right = f6_local1,
		leftAnchor = true,
		rightAnchor = false,
		top = f6_local2,
		bottom = f6_local2 * 2,
		topAnchor = true,
		bottomAnchor = false
	}, 200, 50, 30, 1.2, CoD.StrikeForceMenu.CarouselScrollTime)
	f6_local0:addElement(f6_local0.carousel)
	local f6_local3 = LUI.UIText.new({
		left = 0,
		right = 0,
		leftAnchor = true,
		rightAnchor = true,
		top = 0,
		bottom = CoD.textSize.Default,
		topAnchor = true,
		bottomAnchor = false
	})
	f6_local3:setText(Engine.Localize("MENU_STRIKEFORCE_UNITS_REMAINING") .. f6_arg1)
	f6_local0:addElement(f6_local3)
	f6_local0.current_item = 1
	return f6_local0
end

