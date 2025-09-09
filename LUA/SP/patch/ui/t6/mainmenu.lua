if CoD.MainMenu == nil then
	CoD.MainMenu = {}
end
if CoD.isWIIU then
	require("T6.UnifiedFriends")
end
CoD.MainMenu.MenuAnimationTime = 150
CoD.MainMenu.CarouselScrollTime = 150
CoD.MainMenu.OpenCampaign = function (f1_arg0, f1_arg1)
	local f1_local0 = f1_arg1.button.m_ownerController
	Engine.SetDvar("ui_skipMainLockout", 1)
	f1_arg0:openMenu("CampaignMenu", f1_local0)
	f1_arg0:close()
end

CoD.MainMenu.OpenMultiplayer = function (f2_arg0, f2_arg1)
	Engine.PlaySound("uin_navigation_click")
	Engine.SetDvar("ui_skipMainLockout", 1)
	Engine.SetDvar("ui_changed_exe", 1)
	Engine.Exec(f2_arg1.button.m_ownerController, "startMultiplayer")
end

CoD.MainMenu.OpenZombies = function (f3_arg0, f3_arg1)
	Engine.PlaySound("uin_navigation_click")
	Engine.SetDvar("ui_skipMainLockout", 1)
	Engine.SetDvar("ui_changed_exe", 1)
	Engine.Exec(f3_arg1.button.m_ownerController, "startZombies")
end

CoD.MainMenu.OpenQuitPopup = function (f4_arg0, f4_arg1)
	f4_arg0:openMenu("QuitPopup", f4_arg1.controller)
	f4_arg0:close()
end

CoD.MainMenu.OpenConfirmSwitchToMP = function (f5_arg0, f5_arg1)
	f5_arg0:openMenu("SwitchToMPPopup", f5_arg1.controller)
	f5_arg0:close()
end

CoD.MainMenu.OpenConfirmSwitchToZM = function (f6_arg0, f6_arg1)
	f6_arg0:openMenu("SwitchToZMPopup", f6_arg1.controller)
	f6_arg0:close()
end

CoD.MainMenu.SetQuickLaunchMode = function (f7_arg0, f7_arg1)
	if f7_arg0.carousel ~= nil then
		local f7_local0 = f7_arg0.carousel:getCurrentItemIndex()
		local f7_local1 = CoD.START_GAME_CAMPAIGN
		if f7_local0 == 2 then
			f7_local1 = CoD.START_GAME_CAMPAIGN
		elseif f7_local0 == 1 then
			f7_local1 = CoD.START_GAME_MULTIPLAYER
		elseif f7_local0 == 3 then
			f7_local1 = CoD.START_GAME_ZOMBIES
		end
		Engine.SetProfileVar(f7_arg1.controller, "quick_launch_mode", f7_local1)
		Engine.ExecNow(f7_arg1.controller, "updategamerprofile")
		Engine.PlaySound("uin_loadout_edit_sel")
	end
end

CoD.MainMenu.ButtonPromptFriendsMenu = function (f8_arg0, f8_arg1)
	if not CoD.isPS3 or UIExpression.IsSubUser(f8_arg1.controller) ~= 1 then
		f8_arg0:openMenu("FriendsList", f8_arg1.controller, {
			previousMenu = "MainMenu"
		})
		f8_arg0:close()
	end
end

CoD.MainMenu.AddSideBrackets = function (f9_arg0)
	local f9_local0 = 20
	local f9_local1 = 500
	local f9_local2 = CoD.SideBrackets.new()
	f9_local2:registerAnimationState("menu_close", {
		left = f9_local0,
		right = -f9_local0,
		leftAnchor = true,
		rightAnchor = true,
		top = 0,
		bottom = 0,
		topAnchor = false,
		bottomAnchor = false,
		alpha = 0.25
	})
	f9_local2:animateToState("menu_close")
	f9_local2:registerAnimationState("menu_open", {
		left = f9_local0,
		right = -f9_local0,
		leftAnchor = true,
		rightAnchor = true,
		top = -f9_local1 / 2,
		bottom = f9_local1 / 2,
		topAnchor = false,
		bottomAnchor = false,
		alpha = 0.25
	})
	f9_arg0:addElement(f9_local2)
end

LUI.createMenu.MainMenu = function (f10_arg0)
	local f10_local0 = CoD.Menu.New("MainMenu")
	f10_local0:addTitle(Engine.Localize("MENU_MAIN_MENU_CAPS"), LUI.Alignment.Center)
	f10_local0:setPreviousMenu("LockOutMenu")
	Engine.SendMenuResponse(f10_arg0, "lockout", "glasses_boot_complete")
	f10_local0:registerEventHandler("open_campaign", CoD.MainMenu.OpenCampaign)
	f10_local0:registerEventHandler("open_multiplayer", CoD.MainMenu.OpenMultiplayer)
	f10_local0:registerEventHandler("open_zombies", CoD.MainMenu.OpenZombies)
	if CoD.isPC then
		f10_local0:registerEventHandler("open_quitpopup", CoD.MainMenu.OpenQuitPopup)
		f10_local0:registerEventHandler("button_prompt_back", CoD.MainMenu.OpenQuitPopup)
		f10_local0:registerEventHandler("open_mp_switch_popup", CoD.MainMenu.OpenConfirmSwitchToMP)
		f10_local0:registerEventHandler("open_zm_switch_popup", CoD.MainMenu.OpenConfirmSwitchToZM)
	end
	if CoD.isWIIU then
		f10_local0:registerEventHandler("button_prompt_friends", CoD.MainMenu.ButtonPromptFriendsMenu)
	end
	f10_local0:addSelectButton()
	f10_local0:addBackButton()
	if not CoD.isPC and UIExpression.IsProfileSignedIn(f10_arg0) == 1 then
		f10_local0.setDefault = CoD.ButtonPrompt.new("alt2", Engine.Localize("MENU_SET_DEFAULT"), f10_local0, "set_quick_launch_mode")
		f10_local0:addLeftButtonPrompt(f10_local0.setDefault)
		f10_local0:registerEventHandler("set_quick_launch_mode", CoD.MainMenu.SetQuickLaunchMode)
	end
	if CoD.isWIIU then
		f10_local0:addFriendsButtonSPMainMenu()
	end
	f10_local0:setBackOutSFX("uin_main_exit")
	if CoD.isPC then
		local f10_local1 = 50
		local f10_local2 = 30
		local f10_local3 = 300
		local carousel = 4 * (f10_local1 + f10_local2) - f10_local2
		local f10_local5 = CoD.ButtonList.new()
		f10_local5:setLeftRight(false, false, -f10_local3 / 2, f10_local3 / 2)
		f10_local5:setTopBottom(false, false, -carousel / 2, carousel / 2 + 100)
		f10_local5:setSpacing(f10_local2)
		f10_local0:addElement(f10_local5)
		local f10_local6 = f10_local5:addNavButton(Engine.Localize("MENU_MULTIPLAYER_CAPS"), "open_mp_switch_popup")
		local f10_local7 = f10_local5:addNavButton(Engine.Localize("MENU_SINGLEPLAYER_CAPS"), "open_campaign")
		local f10_local8 = f10_local5:addNavButton(Engine.Localize("MENU_ZOMBIES_CAPS"), "open_zm_switch_popup")
		local f10_local9 = f10_local5:addNavButton(Engine.Localize("MENU_QUIT_CAPS"), "open_quitpopup")
		f10_local7:processEvent({
			name = "gain_focus"
		})
	else
		local f10_local1 = 0
		local f10_local2 = f10_local0.width
		local f10_local3 = f10_local0.height - CoD.Menu.TitleHeight
		
		local carousel = CoD.VerticalCarousel.new({
			left = -f10_local2 / 2,
			right = f10_local2 / 2,
			leftAnchor = false,
			rightAnchor = false,
			top = -(f10_local3 / 2) - f10_local1,
			bottom = f10_local3 / 2 - f10_local1,
			topAnchor = false,
			bottomAnchor = false
		}, 200, 50, 30, 1.2, CoD.MainMenu.CarouselScrollTime)
		f10_local0:addElement(carousel)
		f10_local0.carousel = carousel
		
		local f10_local5 = CoD.NavButton.new(nil, Engine.Localize("MENU_MULTIPLAYER_CAPS"), "open_multiplayer")
		f10_local5:setupCarouselMode()
		carousel:addItem(f10_local5)
		local f10_local6 = CoD.NavButton.new(nil, Engine.Localize("MENU_SINGLEPLAYER_CAPS"), "open_campaign")
		f10_local6:setupCarouselMode()
		carousel:addItem(f10_local6)
		local f10_local7 = CoD.NavButton.new(nil, Engine.Localize("MENU_ZOMBIES_CAPS"), "open_zombies")
		f10_local7:setupCarouselMode()
		carousel:addItem(f10_local7)
		if CoD.isPC then
			local f10_local8 = CoD.NavButton.new(nil, Engine.Localize("MENU_QUIT_CAPS"), "open_quitpopup")
			f10_local8:setupCarouselMode()
			carousel:addItem(f10_local8)
		end
		carousel:setStartItem(2)
	end
	if f10_arg0 == nil then
		f10_arg0 = UIExpression.GetPrimaryController()
	end
	if CoD.isWIIU then
		Engine.EnableWiiURemotePointer(f10_arg0, false)
	end
	return f10_local0
end

