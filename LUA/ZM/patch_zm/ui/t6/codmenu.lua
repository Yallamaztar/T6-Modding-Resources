require("T6.Menus.FriendPopup")
CoD.Menu = InheritFrom(LUI.UIElement)
CoD.Menu.Width = CoD.SDSafeWidth
CoD.Menu.Height = CoD.SDSafeHeight
if CoD.isSinglePlayer then
	CoD.Menu.TitleHeight = CoD.textSize.Condensed
	CoD.Menu.TitleFont = CoD.fonts.Condensed
else
	CoD.Menu.TitleHeight = CoD.textSize.Big
	CoD.Menu.TitleFont = CoD.fonts.Big
end
CoD.Menu.CanHideHud = false
CoD.Menu.MediumPopupWidth = CoD.Menu.Width
CoD.Menu.MediumPopupHeight = 430
CoD.Menu.SmallPopupWidth = 448
CoD.Menu.SmallPopupHeight = 256
CoD.Menu.SplitscreenSideOffset = 28
CoD.Menu.New = function (MenuName, MenuWidth, MenuHeight, f1_arg3)
	if MenuName == nil then
		error("LUI Error: Attempted to create a menu without a name.")
	end
	if MenuWidth == nil then
		MenuWidth = CoD.Menu.Width
	end
	if MenuHeight == nil then
		MenuHeight = CoD.Menu.Height
	end
	local Widget = CoD.Menu.NewFromState(MenuName, {
		leftAnchor = false,
		rightAnchor = false,
		left = -MenuWidth / 2,
		right = MenuWidth / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = -MenuHeight / 2,
		bottom = MenuHeight / 2
	}, f1_arg3)
	Widget.width = MenuWidth
	Widget.height = MenuHeight
	if CoD.isSinglePlayer then
		Widget:setBackOutSFX("uin_cmn_backout")
	else
		Widget:setBackOutSFX("cac_cmn_backout")
	end
	if CoD.useMouse and CoD.Mouse.MaterialsRegistered then
		CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_NORMAL)
		CoD.Mouse.Reset = true
	end
	return Widget
end

CoD.Menu.NewSmallPopup = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4)
	local f2_local0 = CoD.Menu.SmallPopupWidth
	local f2_local1 = CoD.Menu.SmallPopupHeight
	if f2_arg3 then
		f2_local0 = f2_arg3
	end
	if f2_arg4 then
		f2_local1 = f2_arg4
	end
	local f2_local2 = CoD.Menu.New(f2_arg0, f2_local0, f2_local1)
	f2_local2.leftButtonPromptBar:setLeftRight(true, true, -10, 0)
	if f2_arg1 ~= nil and f2_arg1 then
		f2_local2:addSmallSolidBackground(f2_arg2)
	end
	f2_local2:addSmallPopupBackground(nil, f2_local0, f2_local1)
	return f2_local2
end

CoD.Menu.NewMediumPopup = function (f3_arg0)
	local f3_local0 = CoD.Menu.New(f3_arg0, CoD.Menu.MediumPopupWidth, CoD.Menu.MediumPopupHeight)
	f3_local0:addMediumPopupBackground()
	return f3_local0
end

CoD.Menu.NewFromState = function (MenuName, AnimationState, f4_arg2)
	if MenuName == nil then
		error("LUI Error: Attempted to create a menu without a name.")
	end
	local Widget = LUI.UIElement.new(AnimationState)
	Widget:setClass(CoD.Menu)
	if RegisterOpenedMenu then
		RegisterOpenedMenu(Widget, MenuName)
	end
	Widget.menuName = MenuName
	Widget.userData = f4_arg2
	Widget.id = "Menu." .. MenuName
	Widget.leftButtonPromptBar = LUI.UIHorizontalList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height,
		bottom = 0,
		spacing = 10,
		alignment = LUI.Alignment.Left
	})
	Widget:addElement(Widget.leftButtonPromptBar)
	Widget.rightButtonPromptBar = LUI.UIHorizontalList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height,
		bottom = 0,
		spacing = 10,
		alignment = LUI.Alignment.Right
	})
	Widget:addElement(Widget.rightButtonPromptBar)
	return Widget
end

CoD.Menu.NewSafeAreaFromState = function (f5_arg0, f5_arg1)
	local f5_local0 = CoD.Menu.NewFromState(f5_arg0)
	f5_local0:sizeToSafeArea(f5_arg1)
	return f5_local0
end

CoD.Menu.close = function (f6_arg0)
	if CoD.isSinglePlayer == true then
		local f6_local0 = f6_arg0:getOwner()
		if f6_local0 == nil then
			f6_local0 = 0
		end
		Engine.SendMenuResponse(f6_local0, f6_arg0.menuName, "menu_close")
	end
	if UnregisterOpenedMenu then
		UnregisterOpenedMenu(f6_arg0, f6_arg0.menuName)
	end
	CoD.Menu.super.close(f6_arg0)
end

CoD.Menu.ButtonPromptBack = function (f7_arg0, f7_arg1)
	if not f7_arg0.previousMenuName and f7_arg0.occludedMenu then
		f7_arg0:setOwner(f7_arg1.controller)
		f7_arg0:animateOutAndGoBack()
	else
		f7_arg0:goBack(f7_arg1.controller)
	end
end

CoD.Menu.TransitionCompleteAnimatePopupOut = function (f8_arg0, f8_arg1)
	f8_arg0:goBack(f8_arg0:getOwner())
end

CoD.Menu.addBackButton = function (f9_arg0, f9_arg1)
	if not f9_arg1 then
		f9_arg1 = Engine.Localize("MENU_BACK")
	end
	f9_arg0.backButton = CoD.ButtonPrompt.new("secondary", f9_arg1, f9_arg0, "button_prompt_back")
	f9_arg0:addLeftButtonPrompt(f9_arg0.backButton)
end

CoD.Menu.removeBackButton = function (f10_arg0)
	if f10_arg0.backButton ~= nil then
		f10_arg0.backButton:close()
		f10_arg0.backButton = nil
	end
end

CoD.Menu.RemoveStartButtonPrompt = function (f11_arg0)
	if f11_arg0.startButtonPrompt ~= nil then
		f11_arg0.startButtonPrompt:close()
		f11_arg0.startButtonPrompt = nil
	end
end

CoD.Menu.addFriendsButton = function (f12_arg0)
	local f12_local0 = CoD.ButtonPrompt.new
	local f12_local1 = "alt2"
	local f12_local2 = Engine.Localize("MENU_FRIENDS")
	local f12_local3 = f12_arg0
	local f12_local4 = "button_prompt_friends"
	local f12_local5, f12_local6 = false
	local f12_local7, f12_local8 = false
	f12_arg0.friendsButton = f12_local0(f12_local1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6, f12_local7, f12_local8, "F")
	f12_arg0:addRightButtonPrompt(f12_arg0.friendsButton)
end

CoD.Menu.addFriendsButtonSPMainMenu = function (f13_arg0)
	local f13_local0 = CoD.ButtonPrompt.new
	local f13_local1 = "start"
	local f13_local2 = Engine.Localize("MENU_FRIENDS")
	local f13_local3 = f13_arg0
	local f13_local4 = "button_prompt_friends"
	local f13_local5, f13_local6 = false
	local f13_local7, f13_local8 = false
	f13_arg0.friendsButton = f13_local0(f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6, f13_local7, f13_local8, "F")
	f13_arg0:addRightButtonPrompt(f13_arg0.friendsButton)
end

CoD.Menu.addJoinButton = function (f14_arg0)
	local f14_local0 = CoD.ButtonPrompt.new
	local f14_local1 = "alt1"
	local f14_local2 = Engine.Localize("MENU_JOIN_GAME")
	local f14_local3 = f14_arg0
	local f14_local4 = "button_prompt_join"
	local f14_local5, f14_local6 = false
	local f14_local7, f14_local8 = false
	f14_arg0.joinButton = f14_local0(f14_local1, f14_local2, f14_local3, f14_local4, f14_local5, f14_local6, f14_local7, f14_local8, "J")
	f14_arg0:addRightButtonPrompt(f14_arg0.joinButton)
end

CoD.Menu.addButtonPromptText = function (f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = CoD.fonts[CoD.ButtonPrompt.FontName]
	local f15_local1 = CoD.ButtonPrompt.TextHeight
	local f15_local2, f15_local3, f15_local4, f15_local5 = GetTextDimensions(f15_arg2, f15_local0, f15_local1)
	f15_arg1:setLeftRight(true, false, 0, f15_local4)
	f15_arg1:setTopBottom(false, false, -f15_local1 / 2, f15_local1 / 2)
	f15_arg1:setFont(f15_local0)
	f15_arg1:setAlignment(LUI.Alignment.Left)
	f15_arg1:setText(f15_arg2)
	f15_arg0:addRightButtonPrompt(f15_arg1)
end

CoD.Menu.addPartyPrivacyButton = function (f16_arg0)
	if UIExpression.SessionMode_IsOnlineGame() == 0 then
		return 
	end
	local f16_local0
	if UIExpression.GameHost(controller) ~= 1 and UIExpression.PrivatePartyHost(controller) ~= 1 then
		f16_local0 = false
	else
		f16_local0 = true
	end
	if f16_local0 then
		local f16_local1 = CoD.ButtonPrompt.new
		local f16_local2 = "alt1"
		local f16_local3 = Engine.Localize("MPUI_LOBBY_PRIVACY")
		local f16_local4 = f16_arg0
		local f16_local5 = "button_prompt_partyprivacy"
		local f16_local6, f16_local7 = false
		local f16_local8, f16_local9 = false
		f16_arg0.partyPrivacyButton = f16_local1(f16_local2, f16_local3, f16_local4, f16_local5, f16_local6, f16_local7, f16_local8, f16_local9, "P")
		f16_arg0:updatePartyPrivacyButton()
		f16_arg0:addRightButtonPrompt(f16_arg0.partyPrivacyButton)
	else
		f16_arg0.partyPrivacyButton = LUI.UIText.new()
		f16_arg0:addButtonPromptText(f16_arg0.partyPrivacyButton, f16_arg0:getPartyPrivacyText())
	end
end

CoD.Menu.getPartyPrivacyText = function (f17_arg0)
	local f17_local0 = UIExpression.GetPrimaryController()
	if f17_local0 == nil then
		return Engine.Localize("MPUI_LOBBY_PRIVACY")
	end
	local f17_local1 = Engine.GetProfileVarInt(f17_local0, "party_privacyStatus")
	local f17_local2 = "MENU_STATUS_OPEN_DESC_CAPS"
	if f17_local1 == 1 then
		f17_local2 = "MENU_STATUS_OPEN_FRIENDS_DESC_CAPS"
	elseif f17_local1 == 2 then
		f17_local2 = "MENU_STATUS_INVITE_ONLY_DESC_CAPS"
	elseif f17_local1 == 3 then
		f17_local2 = "MENU_STATUS_CLOSE_DESC_CAPS"
	end
	return Engine.Localize("MPUI_LOBBY_PRIVACY") .. ": " .. Engine.Localize(f17_local2)
end

CoD.Menu.updatePartyPrivacyButton = function (f18_arg0)
	if f18_arg0.partyPrivacyButton == nil then
		return 
	else
		f18_arg0.partyPrivacyButton:setText(f18_arg0:getPartyPrivacyText())
	end
end

CoD.Menu.addNATType = function (f19_arg0)
	if UIExpression.SessionMode_IsSystemlinkGame() == 0 and UIExpression.SessionMode_IsOnlineGame() == 0 then
		return 
	elseif f19_arg0.NATType ~= nil then
		f19_arg0.NATType:close()
		f19_arg0.NATType = nil
	end
	local f19_local0 = UIExpression.GetPrimaryController()
	if f19_local0 == nil then
		return 
	end
	local f19_local1 = UIExpression.GetSystemInfo(f19_local0, CoD.SYSINFO_NAT_TYPE_LOBBY)
	f19_arg0.NATType = LUI.UIText.new()
	f19_arg0:addButtonPromptText(f19_arg0.NATType, f19_local1)
end

CoD.Menu.addSelectButton = function (f20_arg0, f20_arg1, f20_arg2, f20_arg3)
	if CoD.isPC and (not f20_arg1 or not f20_arg3) then
		return 
	elseif not f20_arg1 then
		f20_arg1 = Engine.Localize("MENU_SELECT")
	end
	if f20_arg3 ~= nil then
		f20_arg0.selectButton = CoD.ButtonPrompt.new("primary", f20_arg1, f20_arg0, f20_arg3)
	else
		f20_arg0.selectButton = CoD.ButtonPrompt.new("primary", f20_arg1)
	end
	if not f20_arg2 then
		f20_arg2 = -10
	end
	f20_arg0.selectButton:setPriority(f20_arg2)
	f20_arg0:addLeftButtonPrompt(f20_arg0.selectButton)
end

CoD.Menu.removeSelectButton = function (f21_arg0)
	if f21_arg0.selectButton ~= nil then
		f21_arg0.selectButton:close()
		f21_arg0.selectButton = nil
	end
end

CoD.Menu.closeSelectButton = function (f22_arg0)
	if f22_arg0.selectButton then
		f22_arg0.selectButton:close()
	end
	if f22_arg0.customActionButtonPrompt then
		f22_arg0.customActionButtonPrompt:close()
		f22_arg0.customActionButtonPrompt = nil
	end
end

CoD.Menu.addSelectButtonWithPrestigeUnlock = function (f23_arg0)
	local f23_local0 = false
	local f23_local1 = false
	f23_arg0:removeSelectButton()
	if f23_arg0.backButton then
		f23_local0 = true
		f23_arg0:removeBackButton()
	end
	if f23_arg0.prestigeUnlockButton then
		f23_local1 = true
		f23_arg0.prestigeUnlockButton:close()
		f23_arg0.prestigeUnlockButton = nil
	end
	f23_arg0:addSelectButton()
	if f23_local0 == true then
		f23_arg0:addBackButton()
	end
	if f23_local1 == true then
		f23_arg0:addPrestigeUnlockButton()
	end
end

CoD.Menu.addSlideButton = function (f24_arg0)
	f24_arg0.slideButton = CoD.ButtonPrompt.new("left_stick_up", Engine.Localize("MENU_SLIDE"))
	f24_arg0:addLeftButtonPrompt(f24_arg0.slideButton)
end

CoD.Menu.addGlassesToggleButton = function (f25_arg0)
	local f25_local0 = CoD.ButtonPrompt.new
	local f25_local1 = "right_trigger"
	local f25_local2 = Engine.Localize("MENU_TURN_OFF_HUD")
	local f25_local3, f25_local4 = nil
	local f25_local5, f25_local6 = false
	f25_arg0.glassesToggleButton = f25_local0(f25_local1, f25_local2, f25_local3, f25_local4, f25_local5, f25_local6, false, "space")
	f25_arg0:addRightButtonPrompt(f25_arg0.glassesToggleButton)
end

CoD.Menu.addGlassesToggleOnButton = function (f26_arg0)
	local f26_local0 = CoD.ButtonPrompt.new
	local f26_local1 = "right_trigger"
	local f26_local2 = Engine.Localize("MENU_TURN_ON_HUD")
	local f26_local3, f26_local4 = nil
	local f26_local5, f26_local6 = false
	f26_arg0.glassesToggleButton = f26_local0(f26_local1, f26_local2, f26_local3, f26_local4, f26_local5, f26_local6, false, "space")
	f26_arg0:addRightButtonPrompt(f26_arg0.glassesToggleButton)
end

CoD.Menu.addPrestigeUnlockButton = function (f27_arg0)
	local f27_local0 = CoD.ButtonPrompt.new
	local f27_local1 = "shoulderr"
	local f27_local2 = Engine.Localize("MPUI_PERMANENT_UNLOCKS_OPTION")
	local f27_local3 = f27_arg0
	local f27_local4 = "prestige_unlock"
	local f27_local5, f27_local6 = false
	local f27_local7, f27_local8 = false
	f27_arg0.prestigeUnlockButton = f27_local0(f27_local1, f27_local2, f27_local3, f27_local4, f27_local5, f27_local6, f27_local7, f27_local8, "D")
	f27_arg0:addLeftButtonPrompt(f27_arg0.prestigeUnlockButton)
end

CoD.Menu.addLeftButtonPrompt = function (f28_arg0, f28_arg1)
	f28_arg0.leftButtonPromptBar:addElement(f28_arg1)
end

CoD.Menu.addRightButtonPrompt = function (f29_arg0, f29_arg1)
	f29_arg0.rightButtonPromptBar:addElement(f29_arg1)
end

CoD.Menu.addLargePopupBackground = function (f30_arg0)
	if CoD.isZombie == true then
		f30_arg0.largePopupBackground = LUI.UIImage.new()
		f30_arg0.largePopupBackground:setLeftRight(false, false, -640, 640)
		f30_arg0.largePopupBackground:setTopBottom(false, false, -360, 360)
		f30_arg0.largePopupBackground:setImage(RegisterMaterial("menu_zm_cac_backing"))
		f30_arg0.largePopupBackground:setPriority(-10)
		f30_arg0.largePopupBackground:setAlpha(0.7)
		f30_arg0:addElement(f30_arg0.largePopupBackground)
	else
		local f30_local0 = 19
		local f30_local1 = 1280
		local f30_local2 = 605
		local f30_local3 = 16
		f30_arg0.topFrame = LUI.UIImage.new()
		f30_arg0.topFrame:setLeftRight(false, false, -f30_local1 / 2, f30_local1 / 2)
		f30_arg0.topFrame:setTopBottom(false, false, -f30_local2 / 2 - f30_local0 - f30_local3, -f30_local2 / 2 - f30_local0)
		f30_arg0.topFrame:setAlpha(0.65)
		f30_arg0.topFrame:setImage(RegisterMaterial("menu_mp_backing_frame"))
		f30_arg0:addElement(f30_arg0.topFrame)
		f30_arg0.grayBG = LUI.UIImage.new()
		f30_arg0.grayBG:setLeftRight(false, false, -f30_local1 / 2, f30_local1 / 2)
		f30_arg0.grayBG:setTopBottom(false, false, -f30_local2 / 2 - f30_local0, f30_local2 / 2 - f30_local0)
		f30_arg0.grayBG:setRGB(0.16, 0.16, 0.16)
		f30_arg0.grayBG:setPriority(-10)
		f30_arg0.grayBG:setAlpha(0)
		f30_arg0:addElement(f30_arg0.grayBG)
		f30_arg0.bottomFrame = LUI.UIImage.new()
		f30_arg0.bottomFrame:setLeftRight(false, false, -f30_local1 / 2, f30_local1 / 2)
		f30_arg0.bottomFrame:setTopBottom(false, false, f30_local2 / 2 - f30_local0 + f30_local3, f30_local2 / 2 - f30_local0)
		f30_arg0.bottomFrame:setAlpha(0.65)
		f30_arg0.bottomFrame:setImage(RegisterMaterial("menu_mp_backing_frame"))
		f30_arg0:addElement(f30_arg0.bottomFrame)
		f30_arg0.dotsBG = LUI.UIImage.new()
		f30_arg0.dotsBG:setLeftRight(false, false, -f30_local1 / 2, f30_local1 / 2)
		f30_arg0.dotsBG:setTopBottom(false, false, -512, 512)
		f30_arg0.dotsBG:setImage(RegisterMaterial("menu_mp_cac_backing"))
		f30_arg0.dotsBG:setPriority(-10)
		f30_arg0.dotsBG:setAlpha(0.7)
		f30_arg0.dotsBG:setupTiles(8)
		f30_arg0.dotsBG:setTileVertically(false)
		f30_arg0.dotsBG:setShaderVector(0, 1, 1, 1, 1)
		f30_arg0:addElement(f30_arg0.dotsBG)
	end
end

CoD.Menu.addMediumPopupBackground = function (f31_arg0)
	local f31_local0 = 0.7
	if CoD.isZombie == true then
		if not Engine.IsInGame() then
			local f31_local1 = 640
			local f31_local2 = CoD.Menu.MediumPopupHeight / 2 + 125
			local f31_local3 = 20
			f31_arg0.mediumPopupBackground = LUI.UIImage.new()
			f31_arg0.mediumPopupBackground:setLeftRight(false, false, -f31_local1, f31_local1)
			f31_arg0.mediumPopupBackground:setTopBottom(false, false, -f31_local2 - f31_local3, f31_local2 - f31_local3)
			f31_arg0.mediumPopupBackground:setImage(RegisterMaterial("menu_zm_toomany_backing"))
			f31_arg0.mediumPopupBackground:setPriority(-10)
			f31_arg0.mediumPopupBackground:setAlpha(f31_local0)
			f31_arg0:addElement(f31_arg0.mediumPopupBackground)
		end
	else
		local f31_local1 = 1280
		local f31_local2 = CoD.Menu.MediumPopupHeight - 40
		local f31_local3 = 21
		local f31_local4 = 16
		if Engine.IsInGame() then
			f31_local0 = 0.9
		end
		f31_arg0.topFrame = LUI.UIImage.new()
		f31_arg0.topFrame:setLeftRight(false, false, -f31_local1 / 2, f31_local1 / 2)
		f31_arg0.topFrame:setTopBottom(false, false, -f31_local2 / 2 - f31_local3 - f31_local4, -f31_local2 / 2 - f31_local3)
		f31_arg0.topFrame:setAlpha(f31_local0)
		f31_arg0.topFrame:setImage(RegisterMaterial("menu_mp_backing_frame"))
		f31_arg0:addElement(f31_arg0.topFrame)
		f31_arg0.grayBG = LUI.UIImage.new()
		f31_arg0.grayBG:setLeftRight(false, false, -f31_local1 / 2, f31_local1 / 2)
		f31_arg0.grayBG:setTopBottom(false, false, -f31_local2 / 2 - f31_local3, f31_local2 / 2 - f31_local3)
		f31_arg0.grayBG:setRGB(0.16, 0.16, 0.16)
		f31_arg0.grayBG:setPriority(-10)
		f31_arg0.grayBG:setAlpha(0)
		f31_arg0:addElement(f31_arg0.grayBG)
		f31_arg0.bottomFrame = LUI.UIImage.new()
		f31_arg0.bottomFrame:setLeftRight(false, false, -f31_local1 / 2, f31_local1 / 2)
		f31_arg0.bottomFrame:setTopBottom(false, false, f31_local2 / 2 - f31_local3 + f31_local4, f31_local2 / 2 - f31_local3)
		f31_arg0.bottomFrame:setAlpha(f31_local0)
		f31_arg0.bottomFrame:setImage(RegisterMaterial("menu_mp_backing_frame"))
		f31_arg0:addElement(f31_arg0.bottomFrame)
		local f31_local5 = 512
		local f31_local6 = 13
		f31_arg0.dotsBG = LUI.UIImage.new()
		f31_arg0.dotsBG:setLeftRight(false, false, -f31_local1 / 2, f31_local1 / 2)
		f31_arg0.dotsBG:setTopBottom(false, false, -(f31_local5 / 2) - f31_local6, f31_local5 / 2 - f31_local6)
		f31_arg0.dotsBG:setImage(RegisterMaterial("menu_mp_toomany_backing"))
		f31_arg0.dotsBG:setPriority(-10)
		f31_arg0.dotsBG:setAlpha(f31_local0)
		f31_arg0.dotsBG:setupTiles(8)
		f31_arg0.dotsBG:setTileVertically(false)
		f31_arg0.dotsBG:setShaderVector(0, 1, 1, 1, 1)
		f31_arg0:addElement(f31_arg0.dotsBG)
	end
end

CoD.Menu.addSmallPopupBackground_Multiplayer = function (f32_arg0, f32_arg1, f32_arg2)
	local f32_local0 = f32_arg1
	local f32_local1 = f32_arg2
	local f32_local2 = 32
	local f32_local3 = 64
	local f32_local4 = 16
	local f32_local5 = 4
	local f32_local6 = 64
	local f32_local7 = f32_local2 + f32_local3 + f32_local6 + f32_local4
	local f32_local8 = 20
	local f32_local9 = math.ceil((f32_local1 - f32_local8 - f32_local7) / 4)
	f32_local1 = f32_local8 + f32_local7 + f32_local5 * f32_local9
	local f32_local10 = f32_local7 + f32_local5 * f32_local9
	local f32_local11 = f32_local0 + 50
	f32_arg0:setLeftRight(false, false, -f32_local0 / 2, f32_local0 / 2)
	f32_arg0:setTopBottom(false, false, -f32_local1 / 2, f32_local1 / 2)
	local f32_local12 = 16
	local Widget = LUI.UIElement.new()
	Widget:setPriority(-100)
	Widget:setLeftRight(false, false, -f32_local11 / 2, f32_local11 / 2)
	Widget:setTopBottom(false, false, -f32_local10 / 2 - f32_local12, f32_local10 / 2 - f32_local12)
	f32_arg0:addElement(Widget)
	local f32_local14 = 0
	local f32_local15 = LUI.UIImage.new()
	f32_local15:setLeftRight(true, true, 0, 0)
	f32_local15:setTopBottom(true, false, f32_local14, f32_local14 + f32_local2)
	f32_local15:setImage(RegisterMaterial("menu_mp_popup_top"))
	Widget:addElement(f32_local15)
	local f32_local16 = LUI.UIImage.new()
	f32_local16:setLeftRight(true, true, 0, 0)
	f32_local16:setTopBottom(true, true, f32_local2, -f32_local4)
	f32_local16:setImage(RegisterMaterial("menu_mp_popup_stretch"))
	Widget:addElement(f32_local16)
	f32_local14 = f32_local14 + f32_local2
	local f32_local17 = LUI.UIImage.new()
	f32_local17:setLeftRight(true, true, 0, 0)
	f32_local17:setTopBottom(true, false, f32_local14, f32_local14 + f32_local3)
	f32_local17:setImage(RegisterMaterial("menu_mp_dots_top_bottom_fade"))
	Widget:addElement(f32_local17)
	local f32_local18 = f32_local14 + f32_local3
	for f32_local19 = 1, f32_local9, 1 do
		local f32_local22 = f32_local19
		local f32_local23 = LUI.UIImage.new()
		f32_local23:setLeftRight(true, true, 0, 0)
		f32_local23:setTopBottom(true, false, f32_local18, f32_local18 + f32_local5)
		f32_local23:setImage(RegisterMaterial("menu_mp_dots_middle_repeat"))
		Widget:addElement(f32_local23)
		f32_local18 = f32_local18 + f32_local5
	end
	local f32_local19 = 0
	local f32_local20 = LUI.UIImage.new()
	f32_local20:setLeftRight(true, true, 0, 0)
	f32_local20:setTopBottom(false, true, -f32_local19 - f32_local4, -f32_local19)
	f32_local20:setImage(RegisterMaterial("menu_mp_popup_bottom"))
	Widget:addElement(f32_local20)
	f32_local19 = f32_local19 + f32_local4
	local f32_local21 = LUI.UIImage.new()
	f32_local21:setLeftRight(true, true, 0, 0)
	f32_local21:setTopBottom(false, true, -f32_local19 - f32_local6, -f32_local19)
	f32_local21:setXRot(180)
	f32_local21:setImage(RegisterMaterial("menu_mp_dots_top_bottom_fade"))
	Widget:addElement(f32_local21)
	f32_arg0.popupBG = Widget
end

CoD.Menu.addSmallPopupBackground = function (f33_arg0, f33_arg1, f33_arg2, f33_arg3)
	if CoD.isMultiplayer and not CoD.isZombie and not Engine.IsInGame() then
		CoD.Menu.addSmallPopupBackground_Multiplayer(f33_arg0, f33_arg2, f33_arg3)
		return 
	end
	local f33_local0 = f33_arg2 / 2 + 25
	local f33_local1 = f33_arg3 / 2 + 10
	local f33_local2 = 20
	f33_arg0.smallPopupBackground = LUI.UIImage.new()
	f33_arg0.smallPopupBackground:setLeftRight(false, false, -f33_local0, f33_local0)
	f33_arg0.smallPopupBackground:setTopBottom(false, false, -f33_local1 - f33_local2, f33_local1 - f33_local2)
	if f33_arg1 == nil then
		f33_arg1 = RegisterMaterial(CoD.MPZM("menu_mp_popup", "menu_zm_popup"))
	end
	f33_arg0.smallPopupBackground:setImage(f33_arg1)
	f33_arg0.smallPopupBackground:setPriority(-10)
	f33_arg0:addElement(f33_arg0.smallPopupBackground)
end

CoD.Menu.addSmallSolidBackground = function (f34_arg0, f34_arg1)
	local f34_local0 = 0.5
	if f34_arg1 then
		f34_local0 = f34_arg1
	end
	local f34_local1 = CoD.Menu.SmallPopupWidth / 2 + 25
	local f34_local2 = CoD.Menu.SmallPopupHeight / 2 + 10
	local f34_local3 = 20
	local f34_local4 = LUI.UIImage.new()
	f34_local4:setLeftRight(false, false, -f34_local1, f34_local1)
	f34_local4:setTopBottom(false, false, -f34_local2 - f34_local3, f34_local2 - f34_local3)
	f34_local4:setImage(RegisterMaterial("menu_mp_popup_bg"))
	f34_local4:setAlpha(f34_local0)
	f34_local4:setRGB(0, 0, 0)
	f34_local4:setPriority(-10)
	f34_arg0:addElement(f34_local4)
end

CoD.Menu.DebugReload = function (f35_arg0, f35_arg1)
	if f35_arg0.occludedBy then
		return 
	end
	local f35_local0 = f35_arg0.m_ownerController
	if not f35_local0 then
		f35_local0 = UIExpression.GetPrimaryController()
	end
	local f35_local1 = LUI.createMenu[f35_arg0.menuName](f35_local0)
	f35_local1.m_ownerController = f35_arg0.m_ownerController
	f35_local1.occludedMenu = f35_arg0.occludedMenu
	f35_local1.previousMenuName = f35_arg0.previousMenuName
	local f35_local2 = f35_arg0:getParent()
	f35_local2:addElement(f35_local1)
	f35_local1:updateBlur()
	f35_arg0:close()
end

CoD.Menu.goBack = function (f36_arg0, f36_arg1)
	if f36_arg0.backOutSFX ~= nil then
		Engine.PlaySound(f36_arg0.backOutSFX)
	end
	f36_arg0:returnToPreviousMenu(f36_arg1)
end

CoD.Menu.OcclusionChange = function (f37_arg0, f37_arg1)
	if f37_arg1.occluded then
		local f37_local0 = f37_arg0.occludedBy
		f37_arg0.occludedBy = f37_arg1.occludedBy
		if not f37_local0 then
			f37_arg0.m_inputDisabled = true
			f37_arg0:processEvent({
				name = "menu_occluded",
				menu = f37_arg0
			})
			f37_arg0:dispatchEventToChildren({
				name = "disable_input",
				stopAnimation = true
			})
		end
	else
		f37_arg0.m_inputDisabled = nil
		f37_arg0.occludedBy = nil
		f37_arg0:dispatchEventToChildren({
			name = "enable_input"
		})
		if f37_arg0.updateBlur then
			f37_arg0:updateBlur()
		end
	end
end

CoD.Menu.GamepadButton = function (f38_arg0, f38_arg1)
	if f38_arg0.m_inputDisabled then
		return 
	elseif f38_arg0.anyControllerAllowed == true or UIExpression.IsControllerBeingUsed(f38_arg1.controller) == 1 or f38_arg0.unusedControllerAllowed == true then
		if f38_arg0.anyControllerAllowed == true or f38_arg0.m_ownerController == nil or f38_arg0.m_ownerController == f38_arg1.controller then
			return f38_arg0:dispatchEventToChildren(f38_arg1)
		end
	else
		local f38_local0 = f38_arg1.name
		f38_arg1.name = "unused_gamepad_button"
		local f38_local1 = f38_arg0:dispatchEventToChildren(f38_arg1)
		f38_arg1.name = f38_local0
		return f38_local1
	end
end

CoD.Menu.swapMenu = function (f39_arg0, f39_arg1, f39_arg2, f39_arg3)
	local f39_local0 = f39_arg0:getParent()
	local f39_local1 = f39_arg0.menuName
	f39_arg0:close()
	f39_arg0 = nil
	local f39_local2 = LUI.createMenu[f39_arg1](f39_arg2, f39_arg3)
	if f39_local2.previousMenuName == nil then
		f39_local2:setPreviousMenu(f39_local1)
	end
	f39_local0:addElement(f39_local2)
	return f39_local2
end

CoD.Menu.openMenu = function (f40_arg0, f40_arg1, f40_arg2, f40_arg3)
	local f40_local0 = LUI.createMenu[f40_arg1](f40_arg2, f40_arg3)
	if f40_local0.previousMenuName == nil then
		f40_local0:setPreviousMenu(f40_arg0.menuName, f40_arg0.userData)
	end
	if f40_arg0.occludedMenu then
		f40_local0:setOccludedMenu(f40_arg0.occludedMenu)
	end
	f40_local0:addElementAfter(f40_arg0)
	return f40_local0
end

CoD.Menu.openPopup = function (Widget, MenuName, ClientIndex, f41_arg3)
	local Popup = LUI.createMenu[MenuName](ClientIndex, f41_arg3)
	Popup:setOccludedMenu(Widget)
	local WidgetParent = Widget:getParent()
	WidgetParent:addElement(Popup)
	if not CoD.Menu.disablePopupOpenCloseAnim then
		Popup:animateIn()
	end
	return Popup
end

CoD.Menu.openModelessPopup = function (f42_arg0, f42_arg1, f42_arg2, f42_arg3)
	local f42_local0 = LUI.createMenu[f42_arg1](f42_arg2, f42_arg3)
	local f42_local1 = f42_arg0:getParent()
	f42_local1:addElement(f42_local0)
	f42_local0:animateIn()
	return f42_local0
end

CoD.Menu.openPopupOnDrc = function (f43_arg0, f43_arg1, f43_arg2, f43_arg3)
	local f43_local0 = LUI.createMenu[f43_arg1](f43_arg2, f43_arg3)
	if not f43_local0.previousMenuName then
		f43_local0.previousMenu = f43_arg0
	end
	local f43_local1 = f43_arg0:getParent()
	f43_local1:addElement(f43_local0)
	f43_local1:removeElement(f43_arg0)
	f43_local0:animateIn()
	return f43_local0
end

CoD.Menu.returnToPreviousMenu = function (f44_arg0, f44_arg1)
	if f44_arg0.previousMenuName then
		local f44_local0 = f44_arg0:getParent()
		local f44_local1 = f44_arg0.previousMenuName
		local f44_local2 = f44_arg0.previousUserData
		local f44_local3 = f44_arg0.occludedMenu
		if not f44_local3 then
			f44_arg0:close()
			f44_arg0 = nil
		end
		local f44_local4 = LUI.createMenu[f44_local1](f44_arg1, f44_local2)
		f44_local0:addElement(f44_local4)
		if f44_local3 then
			f44_local4:setOccludedMenu(f44_local3)
		end
	elseif f44_arg0.occludedMenu then
		if f44_arg0.occludedBy then
			f44_arg0.occludedBy:setOccludedMenu(f44_arg0.occludedMenu)
		else
			f44_arg0.occludedMenu:processEvent({
				name = "occlusion_change",
				occluded = false
			})
		end
		if CoD.useMouse then
			f44_arg0.occludedMenu:dispatchEventToChildren({
				name = "mouseclear"
			})
		end
	end
	if CoD.useMouse and CoD.Mouse.MaterialsRegistered then
		CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_NORMAL)
		CoD.Mouse.Reset = true
	end
	if f44_arg0 ~= nil then
		f44_arg0:close()
	end
end

CoD.Menu.setBackOutSFX = function (f45_arg0, f45_arg1)
	f45_arg0.backOutSFX = f45_arg1
end

CoD.Menu.updateIngamePopupBg = function (f46_arg0)
	if f46_arg0.occludedMenu then
		local f46_local0 = nil
		if CoD.isSinglePlayer then
			f46_local0 = 0.7
		else
			f46_local0 = 0.8
		end
		if not f46_arg0.darkenElement then
			f46_arg0.darkenElement = LUI.UIImage.new({
				leftAnchor = false,
				rightAnchor = false,
				left = -2560,
				right = 2560,
				topAnchor = false,
				bottomAnchor = false,
				top = -720,
				bottom = 720,
				red = 0,
				green = 0,
				blue = 0,
				alpha = f46_local0
			})
			f46_arg0.darkenElement:setPriority(-100)
			f46_arg0:addElement(f46_arg0.darkenElement)
		end
	elseif f46_arg0.darkenElement then
		f46_arg0.darkenElement:close()
		f46_arg0.darkenElement = nil
	end
end

CoD.Menu.setOccludedMenu = function (f47_arg0, f47_arg1)
	f47_arg0.occludedMenu = f47_arg1
	if f47_arg1 then
		f47_arg1:processEvent({
			name = "occlusion_change",
			occluded = true,
			occludedBy = f47_arg0
		})
	end
	if CoD.isSinglePlayer or UIExpression.IsInGame() == 1 then
		f47_arg0:updateIngamePopupBg()
	end
	f47_arg0:updateBlur()
end

CoD.Menu.setOwner = function (f48_arg0, f48_arg1)
	if CoD.isWIIU then
		f48_arg0:setOwnerControllerIndex(f48_arg1)
	end
	f48_arg0.m_ownerController = f48_arg1
end

CoD.Menu.getOwner = function (f49_arg0)
	return f49_arg0.m_ownerController
end

CoD.Menu.setPreviousMenu = function (f50_arg0, f50_arg1, f50_arg2)
	f50_arg0.previousMenuName = f50_arg1
	f50_arg0.previousUserData = f50_arg2
end

CoD.Menu.animateOutAndGoBack = function (f51_arg0, f51_arg1)
	local f51_local0 = 150
	if CoD.isZombie and f51_arg0.menuName == "class" and Engine.CanPauseZombiesGame() then
		f51_local0 = 1
	end
	f51_arg0.m_inputDisabled = true
	f51_arg0:setAlpha(1)
	f51_arg0:setZoom(0)
	f51_arg0:beginAnimation("animate_popup_out", f51_local0)
	f51_arg0:setAlpha(0)
	f51_arg0:setZoom(600)
	f51_arg0:registerEventHandler("transition_complete_animate_popup_out", f51_arg0.TransitionCompleteAnimatePopupOut)
end

CoD.Menu.animateIn = function (f52_arg0)
	f52_arg0:setAlpha(0)
	f52_arg0:setZoom(600)
	f52_arg0:beginAnimation("animate_popup_in", 250, false, true)
	f52_arg0:setAlpha(1)
	f52_arg0:setZoom(0)
end

CoD.Menu.addTitle = function (f53_arg0, f53_arg1, f53_arg2)
	if f53_arg2 == nil then
		if CoD.isSinglePlayer then
			f53_arg2 = LUI.Alignment.Center
		else
			f53_arg2 = LUI.Alignment.Left
		end
	end
	f53_arg0.titleElement = LUI.UIText.new()
	f53_arg0.titleElement:setLeftRight(true, false, 0, CoD.Menu.Width)
	f53_arg0.titleElement:setTopBottom(true, false, 0, CoD.Menu.TitleHeight)
	if CoD.isSinglePlayer then
		f53_arg0.titleElement:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
	else
		f53_arg0.titleElement:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	end
	f53_arg0.titleElement:setAlignment(f53_arg2)
	f53_arg0.titleElement:setFont(CoD.Menu.TitleFont)
	f53_arg0:addElement(f53_arg0.titleElement)
	f53_arg0:setTitle(f53_arg1)
end

CoD.Menu.setTitle = function (f54_arg0, f54_arg1)
	f54_arg0.titleText = f54_arg1
	f54_arg0.titleElement:setText(f54_arg0.titleText)
end

CoD.Menu.updateBlur = function (f55_arg0)
	local f55_local0 = f55_arg0:getOwner()
	if f55_local0 == nil then
		f55_local0 = 0
	end
	if f55_arg0.occludedMenu then
		if 0 == UIExpression.IsInGame() then
			f55_arg0:setBlur(true)
		else
			Engine.BlurWorld(f55_local0, 2)
			Engine.LockInput(f55_local0, true)
			Engine.SetUIActive(f55_local0, true)
		end
	elseif 0 == UIExpression.IsInGame() then
		f55_arg0:setBlur(false)
	elseif f55_local0 then
		Engine.BlurWorld(f55_local0, 0)
		Engine.LockInput(f55_local0, false)
		Engine.SetUIActive(f55_local0, false)
	end
end

CoD.Menu.MenuChanged = function (f56_arg0, f56_arg1)
	if f56_arg0.occludedBy then
		if f56_arg0.occludedMenu == f56_arg1.prevMenu then
			f56_arg0:setOccludedMenu(f56_arg1.nextMenu)
		end
		return 
	elseif f56_arg0.occludedMenu then
		f56_arg0.previousMenuName = nil
		f56_arg0:goBack(f56_arg1.controller)
		f56_arg0.occludedMenu:processEvent(f56_arg1)
	end
end

CoD.Menu.UserSignedOut = function (f57_arg0, f57_arg1)
	if f57_arg0.occludedBy then
		return 
	elseif f57_arg0.occludedMenu then
		f57_arg0.previousMenuName = nil
		f57_arg0:goBack(f57_arg1.controller)
		f57_arg0.occludedMenu:processEvent(f57_arg1)
	end
end

CoD.Menu.SignedOut = function (f58_arg0, f58_arg1)
	if f58_arg0:getOwner() == f58_arg1.controller then
		local f58_local0 = f58_arg0:getRoot()
		f58_local0:processEvent({
			name = "close_all_popups",
			controller = f58_arg1.controller
		})
		f58_local0:processEvent({
			name = "open_popup",
			popupName = "signed_out",
			controller = f58_arg1.controller
		})
	end
end

CoD.Menu.ResolutionChanged = function (f59_arg0, f59_arg1)
	if f59_arg1.resolutionChanged and not f59_arg0.occludedBy then
		f59_arg0:processEvent({
			name = "occlusion_change",
			occluded = false
		})
	else
		f59_arg0:dispatchEventToChildren(f59_arg1)
	end
end

CoD.Menu.OpenRefetchWADConfirmationPopup = function (f60_arg0, f60_arg1)
	if not f60_arg0.occludedBy then
		f60_arg0:openPopup(f60_arg1.popupName, f60_arg1.controller)
		return true
	else

	end
end

CoD.Menu.OpenTexturePackConfirmationPopup = function (f61_arg0, f61_arg1)
	if not f61_arg0.occludedBy then
		f61_arg0:openPopup(f61_arg1.popupName, f61_arg1.controller)
		return true
	else

	end
end

CoD.Menu.OpenErrorPopup = function (f62_arg0, f62_arg1)
	if UIExpression.DvarString(f62_arg1.controller, "ui_errorMessage") ~= "" and not f62_arg0.occludedBy then
		local f62_local0
		if UIExpression.IsInGame() ~= 1 then
			f62_local0 = CoD.isSinglePlayer
		else
			f62_local0 = true
		end
		if not f62_local0 or not f62_arg0.occludedMenu then
			local f62_local1 = f62_arg0:openPopup("ErrorPopup", f62_arg1.controller)
			if f62_local0 then
				f62_local1:setOwner(f62_arg1.controller)
				Engine.LockInput(f62_arg1.controller, true)
				Engine.SetUIActive(f62_arg1.controller, true)
			end
		end
	end
end

CoD.Menu.OpenDemoErrorPopup = function (f63_arg0, f63_arg1)
	if f63_arg1.titleText ~= nil and not f63_arg0.occludedBy then
		local f63_local0 = UIExpression.IsInGame() == 1
		local f63_local1 = f63_arg0:openPopup("Demo_Error", f63_arg1.controller)
		f63_local1.title:setText(f63_arg1.titleText)
		f63_local1.msg:setText(f63_arg1.messageText)
		if f63_local0 then
			f63_local1:setOwner(f63_arg1.controller)
			Engine.LockInput(f63_arg1.controller, true)
			Engine.SetUIActive(f63_arg1.controller, true)
		end
	end
end

CoD.Menu.OpenWiiUControllerSelectorPopup = function (f64_arg0, f64_arg1)
	if not f64_arg0.occludedBy then
		local f64_local0 = f64_arg0:openPopup(f64_arg1.popupName, f64_arg1.controller)
		f64_arg1.newPlayerOption = false
		f64_local0:init(f64_arg1)
		return true
	else

	end
end

CoD.Menu.OpenKeyboardTextFieldPopup = function (f65_arg0, f65_arg1)
	if CoD.isPC and not f65_arg0.occludedBy then
		local f65_local0 = f65_arg0:openPopup("KeyboardTextField", f65_arg1.controller, {
			isPassword = f65_arg1.isPassword
		})
	end
end

CoD.Menu.OpenPopup = function (f66_arg0, f66_arg1)
	if f66_arg0.occludedBy then
		if f66_arg1.recursive then
			return 
		else
			return 
		end
	elseif f66_arg0.menuName ~= f66_arg1.popupName then
		f66_arg0:openPopup(f66_arg1.popupName, f66_arg1.controller)
	end
	return true
end

CoD.Menu.OpenDeadZoneFromDrc = function (f67_arg0, f67_arg1)
	f67_arg0:openMenu("WiiURemoteDeadZoneFromDrc", f67_arg1.controller)
	return true
end

CoD.Menu.GetOnlinePlayerCountText = function (f68_arg0)
	if CoD.isOnlineGame() then
		local f68_local0 = "live"
		if not CoD.isZombie then
			if f68_arg0 ~= nil then
				f68_local0 = "playlist/" .. Engine.GetPlaylistID()
			elseif Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH) == true then
				f68_local0 = "matchtype/public"
			elseif Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == true then
				f68_local0 = "matchtype/league"
			elseif Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) == true then
				f68_local0 = "matchtype/private"
			elseif Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) == true then
				f68_local0 = "matchtype/theater"
			end
		end
		local f68_local1 = Engine.GetPlayerGroupCount(f68_local0)
		if f68_local1 ~= "" then
			return Engine.Localize("MENU_PLAYERS_ONLINE", f68_local1)
		end
	end
	return ""
end

CoD.Menu.OpenPlayercard = function (f69_arg0, f69_arg1)
	if f69_arg0.occludedBy then
		return 
	elseif UIExpression.IsGuest(f69_arg1.controller) == 1 then
		f69_arg0:openPopup("popup_guest_contentrestricted", f69_arg1.controller)
		return 
	elseif f69_arg0.menuName ~= "FriendPopup" and f69_arg0.menuName ~= "MainMenu" then
		CoD.FriendPopup.SelectedPlayerXuid = f69_arg1.selectedPlayerXuid
		CoD.FriendPopup.SelectedPlayerName = f69_arg1.selectedFriendName
		f69_arg0:openPopup("FriendPopup", f69_arg1.controller)
	end
	return true
end

CoD.Menu.COD9ButtonIsEnabled = function (f70_arg0, f70_arg1)
	if f70_arg0.customActionButtonPrompt then
		f70_arg0.customActionButtonPrompt:close()
		f70_arg0.customActionButtonPrompt = nil
	end
	if f70_arg0.selectButton then
		f70_arg0:addLeftButtonPrompt(f70_arg0.selectButton)
	end
end

CoD.Menu.COD9ButtonIsDisabled = function (f71_arg0, f71_arg1)
	f71_arg0:closeSelectButton()
end

CoD.Menu.SetActionPromptString = function (f72_arg0, f72_arg1)
	f72_arg0:closeSelectButton()
	f72_arg0.customActionButtonPrompt = CoD.ButtonPrompt.new("primary", f72_arg1.promptString)
	f72_arg0.customActionButtonPrompt:setPriority(-10)
	f72_arg0:addLeftButtonPrompt(f72_arg0.customActionButtonPrompt)
end

CoD.Menu.LeftRightSelectorGainFocus = function (f73_arg0, f73_arg1)
	f73_arg0:closeSelectButton()
end

CoD.Menu.LeftRightSelectorLoseFocus = function (f74_arg0, f74_arg1)
	if f74_arg0.selectButton then
		f74_arg0:addLeftButtonPrompt(f74_arg0.selectButton)
	end
end

CoD.Menu.LeftRightSilderGainFocus = function (f75_arg0, f75_arg1)
	f75_arg0:closeSelectButton()
end

CoD.Menu.LeftRightSilderLoseFocus = function (f76_arg0, f76_arg1)
	if f76_arg0.selectButton then
		f76_arg0:addLeftButtonPrompt(f76_arg0.selectButton)
	end
end

CoD.Menu.updateTitleForSplitscreen = function (f77_arg0)
	f77_arg0.titleElement:close()
	local f77_local0 = CoD.SplitscreenScaler.new(nil, 1.5)
	f77_local0:setLeftRight(true, false, 0, 0)
	f77_local0:setTopBottom(true, false, 0, 0)
	f77_arg0:addElement(f77_local0)
	f77_arg0.titleElement:setLeftRight(true, false, CoD.Menu.SplitscreenSideOffset, CoD.Menu.Width)
	f77_local0:addElement(f77_arg0.titleElement)
end

CoD.Menu.updateButtonPromptBarsForSplitscreen = function (f78_arg0)
	f78_arg0.leftButtonPromptBar:close()
	local f78_local0 = CoD.SplitscreenScaler.new(nil, 1.5)
	f78_local0:setLeftRight(true, false, 0, 0)
	f78_local0:setTopBottom(false, true, 0, 0)
	f78_arg0:addElement(f78_local0)
	f78_arg0.leftButtonPromptBar:setLeftRight(true, true, -10 + CoD.Menu.SplitscreenSideOffset, 0)
	f78_local0:addElement(f78_arg0.leftButtonPromptBar)
	f78_arg0.rightButtonPromptBar:close()
	local f78_local1 = CoD.SplitscreenScaler.new(nil, 1.5)
	f78_local1:setLeftRight(false, true, 0, -CoD.Menu.SplitscreenSideOffset)
	f78_local1:setTopBottom(false, true, 0, 0)
	f78_arg0:addElement(f78_local1)
	f78_arg0.rightButtonPromptBar:setLeftRight(true, true, 0, -CoD.Menu.SplitscreenSideOffset)
	f78_local1:addElement(f78_arg0.rightButtonPromptBar)
end

CoD.Menu.OpenFrontendSaveGameWarningPopup = function (f79_arg0, f79_arg1)
	f79_arg0:openPopup("FrontendSaveGameWarningPopup", UIExpression.GetPrimaryController(), f79_arg1)
end

CoD.Menu.OpenFrontendSaveGameErrorPopup = function (f80_arg0, f80_arg1)
	f80_arg0:openPopup("FrontendSaveGameErrorPopup", UIExpression.GetPrimaryController(), f80_arg1)
end

CoD.Menu:registerEventHandler("button_prompt_back", CoD.Menu.ButtonPromptBack)
CoD.Menu:registerEventHandler("debug_reload", CoD.Menu.DebugReload)
CoD.Menu:registerEventHandler("occlusion_change", CoD.Menu.OcclusionChange)
CoD.Menu:registerEventHandler("gamepad_button", CoD.Menu.GamepadButton)
CoD.Menu:registerEventHandler("menu_changed", CoD.Menu.MenuChanged)
CoD.Menu:registerEventHandler("signed_out", CoD.Menu.UserSignedOut)
CoD.Menu:registerEventHandler("close_all_popups", CoD.Menu.MenuChanged)
CoD.Menu:registerEventHandler("open_refetch_wad_confirmation_popup", CoD.Menu.OpenRefetchWADConfirmationPopup)
CoD.Menu:registerEventHandler("open_texture_pack_confirmation_popup", CoD.Menu.OpenTexturePackConfirmationPopup)
CoD.Menu:registerEventHandler("open_error_popup", CoD.Menu.OpenErrorPopup)
CoD.Menu:registerEventHandler("demo_error", CoD.Menu.OpenDemoErrorPopup)
CoD.Menu:registerEventHandler("open_controller_selector_popup", CoD.Menu.OpenWiiUControllerSelectorPopup)
CoD.Menu:registerEventHandler("open_keyboard_text_field_popup", CoD.Menu.OpenKeyboardTextFieldPopup)
CoD.Menu:registerEventHandler("open_popup", CoD.Menu.OpenPopup)
CoD.Menu:registerEventHandler("open_dead_zone_from_drc", CoD.Menu.OpenDeadZoneFromDrc)
CoD.Menu:registerEventHandler("open_friend_popup", CoD.Menu.OpenPlayercard)
CoD.Menu:registerEventHandler("COD9ButtonIsEnabled", CoD.Menu.COD9ButtonIsEnabled)
CoD.Menu:registerEventHandler("COD9ButtonIsDisabled", CoD.Menu.COD9ButtonIsDisabled)
CoD.Menu:registerEventHandler("set_action_prompt_string", CoD.Menu.SetActionPromptString)
CoD.Menu:registerEventHandler("left_right_selector_gain_focus", CoD.Menu.LeftRightSelectorGainFocus)
CoD.Menu:registerEventHandler("left_right_selector_lose_focus", CoD.Menu.LeftRightSelectorLoseFocus)
CoD.Menu:registerEventHandler("left_right_slider_gain_focus", CoD.Menu.LeftRightSilderGainFocus)
CoD.Menu:registerEventHandler("left_right_slider_lose_focus", CoD.Menu.LeftRightSilderLoseFocus)
CoD.Menu:registerEventHandler("resolution_changed", CoD.Menu.ResolutionChanged)
if CoD.isSinglePlayer then
	CoD.Menu:registerEventHandler("open_FrontendSaveGameWarningPopup", CoD.Menu.OpenFrontendSaveGameWarningPopup)
	CoD.Menu:registerEventHandler("open_FrontendSaveGameErrorPopup", CoD.Menu.OpenFrontendSaveGameErrorPopup)
end
