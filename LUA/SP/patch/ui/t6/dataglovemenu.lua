require("T6.CoDBase")
CoD.DataGloveMenu = {}
CoD.DataGloveMenu.OpenGame = function (f1_arg0, f1_arg1)
	local f1_local0 = f1_arg1.button.m_ownerController
	Engine.Exec(f1_local0, "vcs_start vcs/" .. f1_arg1.button.gamename .. ".bin")
	f1_arg0:openMenu("VcsMenu", f1_local0)
	f1_arg0:close()
end

CoD.DataGloveMenu.ButtonPromptBack = function (f2_arg0, f2_arg1)
	Engine.SendMenuResponse(f2_arg1.controller, "vcs_action", "shutdown")
	f2_arg0:close()
end

CoD.DataGloveMenu.ButtonPromptNextTrack = function (f3_arg0, f3_arg1)
	Engine.SendMenuResponse(f3_arg1.controller, "music_action", "next_track")
end

CoD.DataGloveMenu.ButtonPromptPrevTrack = function (f4_arg0, f4_arg1)
	Engine.SendMenuResponse(f4_arg1.controller, "music_action", "prev_track")
end

CoD.DataGloveMenu.CarouselScroll = function (f5_arg0, f5_arg1)
	if f5_arg0.carousel.m_currentItem == 1 then
		if f5_arg0.nextTrackButton == nil then
			f5_arg0:removeSelectButton()
			local f5_local0 = CoD.ButtonPrompt.new
			local f5_local1 = "alt1"
			local f5_local2 = Engine.Localize("MENU_NEXT_TRACK")
			local f5_local3 = f5_arg0
			local f5_local4 = "button_prompt_nexttrack"
			local f5_local5, f5_local6 = false
			local f5_local7, f5_local8 = false
			f5_arg0.nextTrackButton = f5_local0(f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6, f5_local7, f5_local8, "N")
			f5_arg0:addRightButtonPrompt(f5_arg0.nextTrackButton)
			f5_local0 = CoD.ButtonPrompt.new
			f5_local1 = "alt2"
			f5_local2 = Engine.Localize("MENU_PREV_TRACK")
			f5_local3 = f5_arg0
			f5_local4 = "button_prompt_prevtrack"
			f5_local5, f5_local6 = false
			f5_local7, f5_local8 = false
			f5_arg0.prevTrackButton = f5_local0(f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6, f5_local7, f5_local8, "P")
			f5_arg0:addRightButtonPrompt(f5_arg0.prevTrackButton)
		end
	elseif f5_arg0.nextTrackButton ~= nil then
		f5_arg0.nextTrackButton:close()
		f5_arg0.nextTrackButton = nil
		f5_arg0.prevTrackButton:close()
		f5_arg0.prevTrackButton = nil
		f5_arg0:removeBackButton()
		if f5_arg0.selectButton == nil then
			f5_arg0:addSelectButton()
		end
		f5_arg0:addBackButton()
	end
end

CoD.DataGloveMenu.CarouselScrollComplete = function (f6_arg0, f6_arg1)
	f6_arg0:dispatchEventToParent({
		name = "scroll_changed"
	})
end

LUI.createMenu.DataGloveMenu = function ()
	local f7_local0 = CoD.Menu.New("DataGloveMenu")
	f7_local0:registerEventHandler("button_prompt_back", CoD.DataGloveMenu.ButtonPromptBack)
	f7_local0:registerEventHandler("button_prompt_nexttrack", CoD.DataGloveMenu.ButtonPromptNextTrack)
	f7_local0:registerEventHandler("button_prompt_prevtrack", CoD.DataGloveMenu.ButtonPromptPrevTrack)
	f7_local0:registerEventHandler("scroll_changed", CoD.DataGloveMenu.CarouselScroll)
	f7_local0:addSelectButton()
	f7_local0:addBackButton()
	local f7_local1 = 1280
	local f7_local2 = 720
	f7_local0.carousel = CoD.HorizontalCarousel.new({
		left = -f7_local1 / 2,
		right = f7_local1 / 2,
		leftAnchor = false,
		rightAnchor = false,
		top = -(f7_local2 / 2),
		bottom = f7_local2 / 2,
		topAnchor = false,
		bottomAnchor = false
	}, 170, 170, 40, 3, CoD.DataGloveMenu.CarouselScrollTime)
	f7_local0.carousel:setUI3DWindow(1)
	f7_local0:addElement(f7_local0.carousel)
	local f7_local3 = CoD.ImageNavButton.new(nil, "audiocontrols_icon")
	f7_local3:setupCarouselMode()
	f7_local3:registerEventHandler("carousel_scroll_complete", CoD.DataGloveMenu.CarouselScrollComplete)
	f7_local0.carousel:addItem(f7_local3)
	local f7_local4 = {}
	for f7_local5 = 1, #f7_local4, 1 do
		f7_local0:registerEventHandler("open_" .. f7_local4[f7_local5], CoD.DataGloveMenu.OpenGame, f7_local4[f7_local5])
		f7_local3 = CoD.ImageNavButton.new(nil, "vcs_icon_" .. f7_local4[f7_local5], "open_" .. f7_local4[f7_local5])
		f7_local3.gamename = f7_local4[f7_local5]
		f7_local3:setupCarouselMode()
		f7_local3:registerEventHandler("carousel_scroll_complete", CoD.DataGloveMenu.CarouselScrollComplete)
		f7_local0.carousel:addItem(f7_local3)
	end
	f7_local0.carousel:setStartItem(1)
	CoD.DataGloveMenu.CarouselScroll(f7_local0, nil)
	return f7_local0
end

