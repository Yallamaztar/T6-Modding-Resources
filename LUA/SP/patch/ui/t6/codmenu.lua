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
CoD.Menu.New = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	if f1_arg0 == nil then
		error("LUI Error: Attempted to create a menu without a name.")
	end
	if f1_arg1 == nil then
		f1_arg1 = CoD.Menu.Width
	end
	if f1_arg2 == nil then
		f1_arg2 = CoD.Menu.Height
	end
	local f1_local0 = CoD.Menu.NewFromState(f1_arg0, {
		leftAnchor = false,
		rightAnchor = false,
		left = -f1_arg1 / 2,
		right = f1_arg1 / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = -f1_arg2 / 2,
		bottom = f1_arg2 / 2
	}, f1_arg3)
	f1_local0.width = f1_arg1
	f1_local0.height = f1_arg2
	if CoD.isSinglePlayer then
		f1_local0:setBackOutSFX("uin_cmn_backout")
	else
		f1_local0:setBackOutSFX("cac_cmn_backout")
	end
	if CoD.useMouse and CoD.Mouse.MaterialsRegistered then
		CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_NORMAL)
		CoD.Mouse.Reset = true
	end
	return f1_local0
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

CoD.Menu.NewFromState = function (f4_arg0, f4_arg1, f4_arg2)
	if f4_arg0 == nil then
		error("LUI Error: Attempted to create a menu without a name.")
	end
	local Widget = LUI.UIElement.new(f4_arg1)
	Widget:setClass(CoD.Menu)
	if RegisterOpenedMenu then
		RegisterOpenedMenu(Widget, f4_arg0)
	end
	Widget.menuName = f4_arg0
	Widget.userData = f4_arg2
	Widget.id = "Menu." .. f4_arg0
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
	if CoD.isPC then
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

CoD.Menu.addSlideButton = function (f22_arg0)
	f22_arg0.slideButton = CoD.ButtonPrompt.new("left_stick_up", Engine.Localize("MENU_SLIDE"))
	f22_arg0:addLeftButtonPrompt(f22_arg0.slideButton)
end

CoD.Menu.addGlassesToggleButton = function (f23_arg0)
	local f23_local0 = CoD.ButtonPrompt.new
	local f23_local1 = "right_trigger"
	local f23_local2 = Engine.Localize("MENU_TURN_OFF_HUD")
	local f23_local3, f23_local4 = nil
	local f23_local5, f23_local6 = false
	f23_arg0.glassesToggleButton = f23_local0(f23_local1, f23_local2, f23_local3, f23_local4, f23_local5, f23_local6, false, "space")
	f23_arg0:addRightButtonPrompt(f23_arg0.glassesToggleButton)
end

CoD.Menu.addGlassesToggleOnButton = function (f24_arg0)
	local f24_local0 = CoD.ButtonPrompt.new
	local f24_local1 = "right_trigger"
	local f24_local2 = Engine.Localize("MENU_TURN_ON_HUD")
	local f24_local3, f24_local4 = nil
	local f24_local5, f24_local6 = false
	f24_arg0.glassesToggleButton = f24_local0(f24_local1, f24_local2, f24_local3, f24_local4, f24_local5, f24_local6, false, "space")
	f24_arg0:addRightButtonPrompt(f24_arg0.glassesToggleButton)
end

CoD.Menu.addPrestigeUnlockButton = function (f25_arg0)
	f25_arg0.prestigeUnlockButton = CoD.ButtonPrompt.new("shoulderr", Engine.Localize("MPUI_PERMANENT_UNLOCKS_OPTION"), f25_arg0, "prestige_unlock")
	f25_arg0:addLeftButtonPrompt(f25_arg0.prestigeUnlockButton)
end

CoD.Menu.addLeftButtonPrompt = function (f26_arg0, f26_arg1)
	f26_arg0.leftButtonPromptBar:addElement(f26_arg1)
end

CoD.Menu.addRightButtonPrompt = function (f27_arg0, f27_arg1)
	f27_arg0.rightButtonPromptBar:addElement(f27_arg1)
end

CoD.Menu.addLargePopupBackground = function (f28_arg0)
	if CoD.isZombie == true then
		f28_arg0.largePopupBackground = LUI.UIImage.new()
		f28_arg0.largePopupBackground:setLeftRight(false, false, -640, 640)
		f28_arg0.largePopupBackground:setTopBottom(false, false, -360, 360)
		f28_arg0.largePopupBackground:setImage(RegisterMaterial("menu_zm_cac_backing"))
		f28_arg0.largePopupBackground:setPriority(-10)
		f28_arg0.largePopupBackground:setAlpha(0.7)
		f28_arg0:addElement(f28_arg0.largePopupBackground)
	else
		local f28_local0 = 19
		local f28_local1 = 1280
		local f28_local2 = 605
		local f28_local3 = 16
		f28_arg0.topFrame = LUI.UIImage.new()
		f28_arg0.topFrame:setLeftRight(false, false, -f28_local1 / 2, f28_local1 / 2)
		f28_arg0.topFrame:setTopBottom(false, false, -f28_local2 / 2 - f28_local0 - f28_local3, -f28_local2 / 2 - f28_local0)
		f28_arg0.topFrame:setAlpha(0.65)
		f28_arg0.topFrame:setImage(RegisterMaterial("menu_mp_backing_frame"))
		f28_arg0:addElement(f28_arg0.topFrame)
		f28_arg0.grayBG = LUI.UIImage.new()
		f28_arg0.grayBG:setLeftRight(false, false, -f28_local1 / 2, f28_local1 / 2)
		f28_arg0.grayBG:setTopBottom(false, false, -f28_local2 / 2 - f28_local0, f28_local2 / 2 - f28_local0)
		f28_arg0.grayBG:setRGB(0.16, 0.16, 0.16)
		f28_arg0.grayBG:setPriority(-10)
		f28_arg0.grayBG:setAlpha(0)
		f28_arg0:addElement(f28_arg0.grayBG)
		f28_arg0.bottomFrame = LUI.UIImage.new()
		f28_arg0.bottomFrame:setLeftRight(false, false, -f28_local1 / 2, f28_local1 / 2)
		f28_arg0.bottomFrame:setTopBottom(false, false, f28_local2 / 2 - f28_local0 + f28_local3, f28_local2 / 2 - f28_local0)
		f28_arg0.bottomFrame:setAlpha(0.65)
		f28_arg0.bottomFrame:setImage(RegisterMaterial("menu_mp_backing_frame"))
		f28_arg0:addElement(f28_arg0.bottomFrame)
		f28_arg0.dotsBG = LUI.UIImage.new()
		f28_arg0.dotsBG:setLeftRight(false, false, -f28_local1 / 2, f28_local1 / 2)
		f28_arg0.dotsBG:setTopBottom(false, false, -512, 512)
		f28_arg0.dotsBG:setImage(RegisterMaterial("menu_mp_cac_backing"))
		f28_arg0.dotsBG:setPriority(-10)
		f28_arg0.dotsBG:setAlpha(0.7)
		f28_arg0.dotsBG:setupTiles(8)
		f28_arg0.dotsBG:setTileVertically(false)
		f28_arg0.dotsBG:setShaderVector(0, 1, 1, 1, 1)
		f28_arg0:addElement(f28_arg0.dotsBG)
	end
end

CoD.Menu.addMediumPopupBackground = function (f29_arg0)
	local f29_local0 = 0.7
	if CoD.isZombie == true then
		if not Engine.IsInGame() then
			local f29_local1 = 640
			local f29_local2 = CoD.Menu.MediumPopupHeight / 2 + 125
			local f29_local3 = 20
			f29_arg0.mediumPopupBackground = LUI.UIImage.new()
			f29_arg0.mediumPopupBackground:setLeftRight(false, false, -f29_local1, f29_local1)
			f29_arg0.mediumPopupBackground:setTopBottom(false, false, -f29_local2 - f29_local3, f29_local2 - f29_local3)
			f29_arg0.mediumPopupBackground:setImage(RegisterMaterial("menu_zm_toomany_backing"))
			f29_arg0.mediumPopupBackground:setPriority(-10)
			f29_arg0.mediumPopupBackground:setAlpha(f29_local0)
			f29_arg0:addElement(f29_arg0.mediumPopupBackground)
		end
	else
		local f29_local1 = 1280
		local f29_local2 = CoD.Menu.MediumPopupHeight - 40
		local f29_local3 = 21
		local f29_local4 = 16
		if Engine.IsInGame() then
			f29_local0 = 0.9
		end
		f29_arg0.topFrame = LUI.UIImage.new()
		f29_arg0.topFrame:setLeftRight(false, false, -f29_local1 / 2, f29_local1 / 2)
		f29_arg0.topFrame:setTopBottom(false, false, -f29_local2 / 2 - f29_local3 - f29_local4, -f29_local2 / 2 - f29_local3)
		f29_arg0.topFrame:setAlpha(f29_local0)
		f29_arg0.topFrame:setImage(RegisterMaterial("menu_mp_backing_frame"))
		f29_arg0:addElement(f29_arg0.topFrame)
		f29_arg0.grayBG = LUI.UIImage.new()
		f29_arg0.grayBG:setLeftRight(false, false, -f29_local1 / 2, f29_local1 / 2)
		f29_arg0.grayBG:setTopBottom(false, false, -f29_local2 / 2 - f29_local3, f29_local2 / 2 - f29_local3)
		f29_arg0.grayBG:setRGB(0.16, 0.16, 0.16)
		f29_arg0.grayBG:setPriority(-10)
		f29_arg0.grayBG:setAlpha(0)
		f29_arg0:addElement(f29_arg0.grayBG)
		f29_arg0.bottomFrame = LUI.UIImage.new()
		f29_arg0.bottomFrame:setLeftRight(false, false, -f29_local1 / 2, f29_local1 / 2)
		f29_arg0.bottomFrame:setTopBottom(false, false, f29_local2 / 2 - f29_local3 + f29_local4, f29_local2 / 2 - f29_local3)
		f29_arg0.bottomFrame:setAlpha(f29_local0)
		f29_arg0.bottomFrame:setImage(RegisterMaterial("menu_mp_backing_frame"))
		f29_arg0:addElement(f29_arg0.bottomFrame)
		local f29_local5 = 512
		local f29_local6 = 13
		f29_arg0.dotsBG = LUI.UIImage.new()
		f29_arg0.dotsBG:setLeftRight(false, false, -f29_local1 / 2, f29_local1 / 2)
		f29_arg0.dotsBG:setTopBottom(false, false, -(f29_local5 / 2) - f29_local6, f29_local5 / 2 - f29_local6)
		f29_arg0.dotsBG:setImage(RegisterMaterial("menu_mp_toomany_backing"))
		f29_arg0.dotsBG:setPriority(-10)
		f29_arg0.dotsBG:setAlpha(f29_local0)
		f29_arg0.dotsBG:setupTiles(8)
		f29_arg0.dotsBG:setTileVertically(false)
		f29_arg0.dotsBG:setShaderVector(0, 1, 1, 1, 1)
		f29_arg0:addElement(f29_arg0.dotsBG)
	end
end

CoD.Menu.addSmallPopupBackground_Multiplayer = function (f30_arg0, f30_arg1, f30_arg2)
	local f30_local0 = f30_arg1
	local f30_local1 = f30_arg2
	local f30_local2 = 32
	local f30_local3 = 64
	local f30_local4 = 16
	local f30_local5 = 4
	local f30_local6 = 64
	local f30_local7 = f30_local2 + f30_local3 + f30_local6 + f30_local4
	local f30_local8 = 20
	local f30_local9 = math.ceil((f30_local1 - f30_local8 - f30_local7) / 4)
	f30_local1 = f30_local8 + f30_local7 + f30_local5 * f30_local9
	local f30_local10 = f30_local7 + f30_local5 * f30_local9
	local f30_local11 = f30_local0 + 50
	f30_arg0:setLeftRight(false, false, -f30_local0 / 2, f30_local0 / 2)
	f30_arg0:setTopBottom(false, false, -f30_local1 / 2, f30_local1 / 2)
	local f30_local12 = 16
	local Widget = LUI.UIElement.new()
	Widget:setPriority(-100)
	Widget:setLeftRight(false, false, -f30_local11 / 2, f30_local11 / 2)
	Widget:setTopBottom(false, false, -f30_local10 / 2 - f30_local12, f30_local10 / 2 - f30_local12)
	f30_arg0:addElement(Widget)
	local f30_local14 = 0
	local f30_local15 = LUI.UIImage.new()
	f30_local15:setLeftRight(true, true, 0, 0)
	f30_local15:setTopBottom(true, false, f30_local14, f30_local14 + f30_local2)
	f30_local15:setImage(RegisterMaterial("menu_mp_popup_top"))
	Widget:addElement(f30_local15)
	local f30_local16 = LUI.UIImage.new()
	f30_local16:setLeftRight(true, true, 0, 0)
	f30_local16:setTopBottom(true, true, f30_local2, -f30_local4)
	f30_local16:setImage(RegisterMaterial("menu_mp_popup_stretch"))
	Widget:addElement(f30_local16)
	f30_local14 = f30_local14 + f30_local2
	local f30_local17 = LUI.UIImage.new()
	f30_local17:setLeftRight(true, true, 0, 0)
	f30_local17:setTopBottom(true, false, f30_local14, f30_local14 + f30_local3)
	f30_local17:setImage(RegisterMaterial("menu_mp_dots_top_bottom_fade"))
	Widget:addElement(f30_local17)
	local f30_local18 = f30_local14 + f30_local3
	for f30_local19 = 1, f30_local9, 1 do
		local f30_local22 = f30_local19
		local f30_local23 = LUI.UIImage.new()
		f30_local23:setLeftRight(true, true, 0, 0)
		f30_local23:setTopBottom(true, false, f30_local18, f30_local18 + f30_local5)
		f30_local23:setImage(RegisterMaterial("menu_mp_dots_middle_repeat"))
		Widget:addElement(f30_local23)
		f30_local18 = f30_local18 + f30_local5
	end
	local f30_local19 = 0
	local f30_local20 = LUI.UIImage.new()
	f30_local20:setLeftRight(true, true, 0, 0)
	f30_local20:setTopBottom(false, true, -f30_local19 - f30_local4, -f30_local19)
	f30_local20:setImage(RegisterMaterial("menu_mp_popup_bottom"))
	Widget:addElement(f30_local20)
	f30_local19 = f30_local19 + f30_local4
	local f30_local21 = LUI.UIImage.new()
	f30_local21:setLeftRight(true, true, 0, 0)
	f30_local21:setTopBottom(false, true, -f30_local19 - f30_local6, -f30_local19)
	f30_local21:setXRot(180)
	f30_local21:setImage(RegisterMaterial("menu_mp_dots_top_bottom_fade"))
	Widget:addElement(f30_local21)
	f30_arg0.popupBG = Widget
end

CoD.Menu.addSmallPopupBackground = function (f31_arg0, f31_arg1, f31_arg2, f31_arg3)
	if CoD.isMultiplayer and not CoD.isZombie and not Engine.IsInGame() then
		CoD.Menu.addSmallPopupBackground_Multiplayer(f31_arg0, f31_arg2, f31_arg3)
		return 
	end
	local f31_local0 = f31_arg2 / 2 + 25
	local f31_local1 = f31_arg3 / 2 + 10
	local f31_local2 = 20
	f31_arg0.smallPopupBackground = LUI.UIImage.new()
	f31_arg0.smallPopupBackground:setLeftRight(false, false, -f31_local0, f31_local0)
	f31_arg0.smallPopupBackground:setTopBottom(false, false, -f31_local1 - f31_local2, f31_local1 - f31_local2)
	if f31_arg1 == nil then
		f31_arg1 = RegisterMaterial(CoD.MPZM("menu_mp_popup", "menu_zm_popup"))
	end
	f31_arg0.smallPopupBackground:setImage(f31_arg1)
	f31_arg0.smallPopupBackground:setPriority(-10)
	f31_arg0:addElement(f31_arg0.smallPopupBackground)
end

CoD.Menu.addSmallSolidBackground = function (f32_arg0, f32_arg1)
	local f32_local0 = 0.5
	if f32_arg1 then
		f32_local0 = f32_arg1
	end
	local f32_local1 = CoD.Menu.SmallPopupWidth / 2 + 25
	local f32_local2 = CoD.Menu.SmallPopupHeight / 2 + 10
	local f32_local3 = 20
	local f32_local4 = LUI.UIImage.new()
	f32_local4:setLeftRight(false, false, -f32_local1, f32_local1)
	f32_local4:setTopBottom(false, false, -f32_local2 - f32_local3, f32_local2 - f32_local3)
	f32_local4:setImage(RegisterMaterial("menu_mp_popup_bg"))
	f32_local4:setAlpha(f32_local0)
	f32_local4:setRGB(0, 0, 0)
	f32_local4:setPriority(-10)
	f32_arg0:addElement(f32_local4)
end

CoD.Menu.DebugReload = function (f33_arg0, f33_arg1)
	if f33_arg0.occludedBy then
		return 
	end
	local f33_local0 = f33_arg0.m_ownerController
	if not f33_local0 then
		f33_local0 = UIExpression.GetPrimaryController()
	end
	local f33_local1 = LUI.createMenu[f33_arg0.menuName](f33_local0)
	f33_local1.m_ownerController = f33_arg0.m_ownerController
	f33_local1.occludedMenu = f33_arg0.occludedMenu
	f33_local1.previousMenuName = f33_arg0.previousMenuName
	local f33_local2 = f33_arg0:getParent()
	f33_local2:addElement(f33_local1)
	f33_local1:updateBlur()
	f33_arg0:close()
end

CoD.Menu.goBack = function (f34_arg0, f34_arg1)
	if f34_arg0.backOutSFX ~= nil then
		Engine.PlaySound(f34_arg0.backOutSFX)
	end
	f34_arg0:returnToPreviousMenu(f34_arg1)
end

CoD.Menu.OcclusionChange = function (f35_arg0, f35_arg1)
	if f35_arg1.occluded then
		local f35_local0 = f35_arg0.occludedBy
		f35_arg0.occludedBy = f35_arg1.occludedBy
		if not f35_local0 then
			f35_arg0.m_inputDisabled = true
			f35_arg0:processEvent({
				name = "menu_occluded",
				menu = f35_arg0
			})
			f35_arg0:dispatchEventToChildren({
				name = "disable_input",
				stopAnimation = true
			})
		end
	else
		f35_arg0.m_inputDisabled = nil
		f35_arg0.occludedBy = nil
		f35_arg0:dispatchEventToChildren({
			name = "enable_input"
		})
		if f35_arg0.updateBlur then
			f35_arg0:updateBlur()
		end
	end
end

CoD.Menu.GamepadButton = function (f36_arg0, f36_arg1)
	if f36_arg0.m_inputDisabled then
		return 
	elseif f36_arg0.anyControllerAllowed == true or UIExpression.IsControllerBeingUsed(f36_arg1.controller) == 1 or f36_arg0.unusedControllerAllowed == true then
		if f36_arg0.anyControllerAllowed == true or f36_arg0.m_ownerController == nil or f36_arg0.m_ownerController == f36_arg1.controller then
			return f36_arg0:dispatchEventToChildren(f36_arg1)
		else

		end
	else
		local f36_local0 = f36_arg1.name
		f36_arg1.name = "unused_gamepad_button"
		local f36_local1 = f36_arg0:dispatchEventToChildren(f36_arg1)
		f36_arg1.name = f36_local0
		return f36_local1
	end
end

CoD.Menu.swapMenu = function (f37_arg0, f37_arg1, f37_arg2, f37_arg3)
	local f37_local0 = f37_arg0:getParent()
	local f37_local1 = f37_arg0.menuName
	f37_arg0:close()
	f37_arg0 = nil
	local f37_local2 = LUI.createMenu[f37_arg1](f37_arg2, f37_arg3)
	if f37_local2.previousMenuName == nil then
		f37_local2:setPreviousMenu(f37_local1)
	end
	f37_local0:addElement(f37_local2)
	return f37_local2
end

CoD.Menu.openMenu = function (f38_arg0, f38_arg1, f38_arg2, f38_arg3)
	local f38_local0 = LUI.createMenu[f38_arg1](f38_arg2, f38_arg3)
	if f38_local0.previousMenuName == nil then
		f38_local0:setPreviousMenu(f38_arg0.menuName, f38_arg0.userData)
	end
	if f38_arg0.occludedMenu then
		f38_local0:setOccludedMenu(f38_arg0.occludedMenu)
	end
	f38_local0:addElementAfter(f38_arg0)
	return f38_local0
end

CoD.Menu.openPopup = function (f39_arg0, f39_arg1, f39_arg2, f39_arg3)
	local f39_local0 = LUI.createMenu[f39_arg1](f39_arg2, f39_arg3)
	f39_local0:setOccludedMenu(f39_arg0)
	local f39_local1 = f39_arg0:getParent()
	f39_local1:addElement(f39_local0)
	if not CoD.Menu.disablePopupOpenCloseAnim then
		f39_local0:animateIn()
	end
	return f39_local0
end

CoD.Menu.openModelessPopup = function (f40_arg0, f40_arg1, f40_arg2, f40_arg3)
	local f40_local0 = LUI.createMenu[f40_arg1](f40_arg2, f40_arg3)
	local f40_local1 = f40_arg0:getParent()
	f40_local1:addElement(f40_local0)
	f40_local0:animateIn()
	return f40_local0
end

CoD.Menu.openPopupOnDrc = function (f41_arg0, f41_arg1, f41_arg2, f41_arg3)
	local f41_local0 = LUI.createMenu[f41_arg1](f41_arg2, f41_arg3)
	if not f41_local0.previousMenuName then
		f41_local0.previousMenu = f41_arg0
	end
	local f41_local1 = f41_arg0:getParent()
	f41_local1:addElement(f41_local0)
	f41_local1:removeElement(f41_arg0)
	f41_local0:animateIn()
	return f41_local0
end

CoD.Menu.returnToPreviousMenu = function (f42_arg0, f42_arg1)
	if f42_arg0.previousMenuName then
		local f42_local0 = f42_arg0:getParent()
		local f42_local1 = f42_arg0.previousMenuName
		local f42_local2 = f42_arg0.previousUserData
		local f42_local3 = f42_arg0.occludedMenu
		if not f42_local3 then
			f42_arg0:close()
			f42_arg0 = nil
		end
		local f42_local4 = LUI.createMenu[f42_local1](f42_arg1, f42_local2)
		f42_local0:addElement(f42_local4)
		if f42_local3 then
			f42_local4:setOccludedMenu(f42_local3)
		end
	elseif f42_arg0.occludedMenu then
		if f42_arg0.occludedBy then
			f42_arg0.occludedBy:setOccludedMenu(f42_arg0.occludedMenu)
		else
			f42_arg0.occludedMenu:processEvent({
				name = "occlusion_change",
				occluded = false
			})
		end
		if CoD.useMouse then
			f42_arg0.occludedMenu:dispatchEventToChildren({
				name = "mouseclear"
			})
		end
	end
	if CoD.useMouse and CoD.Mouse.MaterialsRegistered then
		CoD.Mouse.SetCursorState(CoD.Mouse.CURSOR_NORMAL)
		CoD.Mouse.Reset = true
	end
	if f42_arg0 ~= nil then
		f42_arg0:close()
	end
end

CoD.Menu.setBackOutSFX = function (f43_arg0, f43_arg1)
	f43_arg0.backOutSFX = f43_arg1
end

CoD.Menu.updateIngamePopupBg = function (f44_arg0)
	if f44_arg0.occludedMenu then
		local f44_local0 = nil
		if CoD.isSinglePlayer then
			f44_local0 = 0.7
		else
			f44_local0 = 0.8
		end
		if not f44_arg0.darkenElement then
			f44_arg0.darkenElement = LUI.UIImage.new({
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
				alpha = f44_local0
			})
			f44_arg0.darkenElement:setPriority(-100)
			f44_arg0:addElement(f44_arg0.darkenElement)
		end
	elseif f44_arg0.darkenElement then
		f44_arg0.darkenElement:close()
		f44_arg0.darkenElement = nil
	end
end

CoD.Menu.setOccludedMenu = function (f45_arg0, f45_arg1)
	f45_arg0.occludedMenu = f45_arg1
	if f45_arg1 then
		f45_arg1:processEvent({
			name = "occlusion_change",
			occluded = true,
			occludedBy = f45_arg0
		})
	end
	if CoD.isSinglePlayer or UIExpression.IsInGame() == 1 then
		f45_arg0:updateIngamePopupBg()
	end
	f45_arg0:updateBlur()
end

CoD.Menu.setOwner = function (f46_arg0, f46_arg1)
	if CoD.isWIIU then
		f46_arg0:setOwnerControllerIndex(f46_arg1)
	end
	f46_arg0.m_ownerController = f46_arg1
end

CoD.Menu.getOwner = function (f47_arg0)
	return f47_arg0.m_ownerController
end

CoD.Menu.setPreviousMenu = function (f48_arg0, f48_arg1, f48_arg2)
	f48_arg0.previousMenuName = f48_arg1
	f48_arg0.previousUserData = f48_arg2
end

CoD.Menu.animateOutAndGoBack = function (f49_arg0, f49_arg1)
	local f49_local0 = 150
	if CoD.isZombie and f49_arg0.menuName == "class" and Engine.CanPauseZombiesGame() then
		f49_local0 = 1
	end
	f49_arg0.m_inputDisabled = true
	f49_arg0:setAlpha(1)
	f49_arg0:setZoom(0)
	f49_arg0:beginAnimation("animate_popup_out", f49_local0)
	f49_arg0:setAlpha(0)
	f49_arg0:setZoom(600)
	f49_arg0:registerEventHandler("transition_complete_animate_popup_out", f49_arg0.TransitionCompleteAnimatePopupOut)
end

CoD.Menu.animateIn = function (f50_arg0)
	f50_arg0:setAlpha(0)
	f50_arg0:setZoom(600)
	f50_arg0:beginAnimation("animate_popup_in", 250, false, true)
	f50_arg0:setAlpha(1)
	f50_arg0:setZoom(0)
end

CoD.Menu.addTitle = function (f51_arg0, f51_arg1, f51_arg2)
	if f51_arg2 == nil then
		if CoD.isSinglePlayer then
			f51_arg2 = LUI.Alignment.Center
		else
			f51_arg2 = LUI.Alignment.Left
		end
	end
	f51_arg0.titleElement = LUI.UIText.new()
	f51_arg0.titleElement:setLeftRight(true, false, 0, CoD.Menu.Width)
	f51_arg0.titleElement:setTopBottom(true, false, 0, CoD.Menu.TitleHeight)
	if CoD.isSinglePlayer then
		f51_arg0.titleElement:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
	else
		f51_arg0.titleElement:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	end
	f51_arg0.titleElement:setAlignment(f51_arg2)
	f51_arg0.titleElement:setFont(CoD.Menu.TitleFont)
	f51_arg0:addElement(f51_arg0.titleElement)
	f51_arg0:setTitle(f51_arg1)
end

CoD.Menu.setTitle = function (f52_arg0, f52_arg1)
	f52_arg0.titleText = f52_arg1
	f52_arg0.titleElement:setText(f52_arg0.titleText)
end

CoD.Menu.updateBlur = function (f53_arg0)
	local f53_local0 = f53_arg0:getOwner()
	if f53_local0 == nil then
		f53_local0 = 0
	end
	if f53_arg0.occludedMenu then
		if 0 == UIExpression.IsInGame() then
			f53_arg0:setBlur(true)
		else
			Engine.BlurWorld(f53_local0, 2)
			Engine.LockInput(f53_local0, true)
			Engine.SetUIActive(f53_local0, true)
		end
	elseif 0 == UIExpression.IsInGame() then
		f53_arg0:setBlur(false)
	elseif f53_local0 then
		Engine.BlurWorld(f53_local0, 0)
		Engine.LockInput(f53_local0, false)
		Engine.SetUIActive(f53_local0, false)
	end
end

CoD.Menu.MenuChanged = function (f54_arg0, f54_arg1)
	if f54_arg0.occludedBy then
		if f54_arg0.occludedMenu == f54_arg1.prevMenu then
			f54_arg0:setOccludedMenu(f54_arg1.nextMenu)
		end
		return 
	elseif f54_arg0.occludedMenu then
		f54_arg0.previousMenuName = nil
		f54_arg0:goBack(f54_arg1.controller)
		f54_arg0.occludedMenu:processEvent(f54_arg1)
	end
end

CoD.Menu.ResolutionChanged = function (f55_arg0, f55_arg1)
	if f55_arg1.resolutionChanged and not f55_arg0.occludedBy then
		f55_arg0:processEvent({
			name = "occlusion_change",
			occluded = false
		})
	else
		f55_arg0:dispatchEventToChildren(f55_arg1)
	end
end

CoD.Menu.OpenRefetchWADConfirmationPopup = function (f56_arg0, f56_arg1)
	if not f56_arg0.occludedBy then
		f56_arg0:openPopup(f56_arg1.popupName, f56_arg1.controller)
		return true
	else

	end
end

CoD.Menu.OpenErrorPopup = function (f57_arg0, f57_arg1)
	if UIExpression.DvarString(f57_arg1.controller, "ui_errorMessage") ~= "" and not f57_arg0.occludedBy then
		local f57_local0
		if UIExpression.IsInGame() ~= 1 then
			f57_local0 = CoD.isSinglePlayer
		else
			f57_local0 = true
		end
		if not f57_local0 or not f57_arg0.occludedMenu then
			local f57_local1 = f57_arg0:openPopup("ErrorPopup", f57_arg1.controller)
			if f57_local0 then
				f57_local1:setOwner(f57_arg1.controller)
				Engine.LockInput(f57_arg1.controller, true)
				Engine.SetUIActive(f57_arg1.controller, true)
			end
		end
	end
end

CoD.Menu.OpenDemoErrorPopup = function (f58_arg0, f58_arg1)
	if f58_arg1.titleText ~= nil and not f58_arg0.occludedBy then
		local f58_local0 = UIExpression.IsInGame() == 1
		local f58_local1 = f58_arg0:openPopup("Demo_Error", f58_arg1.controller)
		f58_local1.title:setText(f58_arg1.titleText)
		f58_local1.msg:setText(f58_arg1.messageText)
		if f58_local0 then
			f58_local1:setOwner(f58_arg1.controller)
			Engine.LockInput(f58_arg1.controller, true)
			Engine.SetUIActive(f58_arg1.controller, true)
		end
	end
end

CoD.Menu.OpenWiiUControllerSelectorPopup = function (f59_arg0, f59_arg1)
	if not f59_arg0.occludedBy then
		local f59_local0 = f59_arg0:openPopup(f59_arg1.popupName, f59_arg1.controller)
		f59_arg1.newPlayerOption = false
		f59_local0:init(f59_arg1)
		return true
	else

	end
end

CoD.Menu.OpenKeyboardTextFieldPopup = function (f60_arg0, f60_arg1)
	if CoD.isPC and not f60_arg0.occludedBy then
		local f60_local0 = f60_arg0:openPopup("KeyboardTextField", f60_arg1.controller)
	end
end

CoD.Menu.OpenPopup = function (f61_arg0, f61_arg1)
	if f61_arg0.occludedBy then
		if f61_arg1.recursive then
			return 
		else
			return 
		end
	elseif f61_arg0.menuName ~= f61_arg1.popupName then
		f61_arg0:openPopup(f61_arg1.popupName, f61_arg1.controller)
	end
	return true
end

CoD.Menu.OpenDeadZoneFromDrc = function (f62_arg0, f62_arg1)
	f62_arg0:openMenu("WiiURemoteDeadZoneFromDrc", f62_arg1.controller)
	return true
end

CoD.Menu.GetOnlinePlayerCountText = function (f63_arg0)
	if CoD.isOnlineGame() then
		local f63_local0 = "live"
		if not CoD.isZombie then
			if f63_arg0 ~= nil then
				f63_local0 = "playlist/" .. Engine.GetPlaylistID()
			elseif Engine.GameModeIsMode(CoD.GAMEMODE_PUBLIC_MATCH) == true then
				f63_local0 = "matchtype/public"
			elseif Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == true then
				f63_local0 = "matchtype/league"
			elseif Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) == true then
				f63_local0 = "matchtype/private"
			elseif Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) == true then
				f63_local0 = "matchtype/theater"
			end
		end
		local f63_local1 = Engine.GetPlayerGroupCount(f63_local0)
		if f63_local1 ~= "" then
			return Engine.Localize("MENU_PLAYERS_ONLINE", f63_local1)
		end
	end
	return ""
end

CoD.Menu.OpenPlayercard = function (f64_arg0, f64_arg1)
	if f64_arg0.occludedBy then
		return 
	elseif UIExpression.IsGuest(f64_arg1.controller) == 1 then
		f64_arg0:openPopup("popup_guest_contentrestricted", f64_arg1.controller)
		return 
	elseif f64_arg0.menuName ~= "FriendPopup" and f64_arg0.menuName ~= "MainMenu" then
		CoD.FriendPopup.SelectedPlayerXuid = f64_arg1.selectedPlayerXuid
		CoD.FriendPopup.SelectedPlayerName = f64_arg1.selectedFriendName
		f64_arg0:openPopup("FriendPopup", f64_arg1.controller)
	end
	return true
end

CoD.Menu.LeftRightSelectorGainFocus = function (f65_arg0, f65_arg1)
	if f65_arg0.selectButton then
		f65_arg0.selectButton:close()
	end
end

CoD.Menu.LeftRightSelectorLoseFocus = function (f66_arg0, f66_arg1)
	if f66_arg0.selectButton then
		f66_arg0:addLeftButtonPrompt(f66_arg0.selectButton)
	end
end

CoD.Menu.LeftRightSilderGainFocus = function (f67_arg0, f67_arg1)
	if f67_arg0.selectButton then
		f67_arg0.selectButton:close()
	end
end

CoD.Menu.LeftRightSilderLoseFocus = function (f68_arg0, f68_arg1)
	if f68_arg0.selectButton then
		f68_arg0:addLeftButtonPrompt(f68_arg0.selectButton)
	end
end

CoD.Menu.updateTitleForSplitscreen = function (f69_arg0)
	f69_arg0.titleElement:close()
	local f69_local0 = CoD.SplitscreenScaler.new(nil, 1.5)
	f69_local0:setLeftRight(true, false, 0, 0)
	f69_local0:setTopBottom(true, false, 0, 0)
	f69_arg0:addElement(f69_local0)
	f69_arg0.titleElement:setLeftRight(true, false, CoD.Menu.SplitscreenSideOffset, CoD.Menu.Width)
	f69_local0:addElement(f69_arg0.titleElement)
end

CoD.Menu.updateButtonPromptBarsForSplitscreen = function (f70_arg0)
	f70_arg0.leftButtonPromptBar:close()
	local f70_local0 = CoD.SplitscreenScaler.new(nil, 1.5)
	f70_local0:setLeftRight(true, false, 0, 0)
	f70_local0:setTopBottom(false, true, 0, 0)
	f70_arg0:addElement(f70_local0)
	f70_arg0.leftButtonPromptBar:setLeftRight(true, true, -10 + CoD.Menu.SplitscreenSideOffset, 0)
	f70_local0:addElement(f70_arg0.leftButtonPromptBar)
	f70_arg0.rightButtonPromptBar:close()
	local f70_local1 = CoD.SplitscreenScaler.new(nil, 1.5)
	f70_local1:setLeftRight(false, true, 0, -CoD.Menu.SplitscreenSideOffset)
	f70_local1:setTopBottom(false, true, 0, 0)
	f70_arg0:addElement(f70_local1)
	f70_arg0.rightButtonPromptBar:setLeftRight(true, true, 0, -CoD.Menu.SplitscreenSideOffset)
	f70_local1:addElement(f70_arg0.rightButtonPromptBar)
end

CoD.Menu.OpenFrontendSaveGameWarningPopup = function (f71_arg0, f71_arg1)
	f71_arg0:openPopup("FrontendSaveGameWarningPopup", UIExpression.GetPrimaryController(), f71_arg1)
end

CoD.Menu.OpenFrontendSaveGameErrorPopup = function (f72_arg0, f72_arg1)
	f72_arg0:openPopup("FrontendSaveGameErrorPopup", UIExpression.GetPrimaryController(), f72_arg1)
end

CoD.Menu:registerEventHandler("button_prompt_back", CoD.Menu.ButtonPromptBack)
CoD.Menu:registerEventHandler("debug_reload", CoD.Menu.DebugReload)
CoD.Menu:registerEventHandler("occlusion_change", CoD.Menu.OcclusionChange)
CoD.Menu:registerEventHandler("gamepad_button", CoD.Menu.GamepadButton)
CoD.Menu:registerEventHandler("menu_changed", CoD.Menu.MenuChanged)
CoD.Menu:registerEventHandler("close_all_popups", CoD.Menu.MenuChanged)
CoD.Menu:registerEventHandler("open_refetch_wad_confirmation_popup", CoD.Menu.OpenRefetchWADConfirmationPopup)
CoD.Menu:registerEventHandler("open_error_popup", CoD.Menu.OpenErrorPopup)
CoD.Menu:registerEventHandler("demo_error", CoD.Menu.OpenDemoErrorPopup)
CoD.Menu:registerEventHandler("open_controller_selector_popup", CoD.Menu.OpenWiiUControllerSelectorPopup)
CoD.Menu:registerEventHandler("open_keyboard_text_field_popup", CoD.Menu.OpenKeyboardTextFieldPopup)
CoD.Menu:registerEventHandler("open_popup", CoD.Menu.OpenPopup)
CoD.Menu:registerEventHandler("open_dead_zone_from_drc", CoD.Menu.OpenDeadZoneFromDrc)
CoD.Menu:registerEventHandler("open_friend_popup", CoD.Menu.OpenPlayercard)
CoD.Menu:registerEventHandler("left_right_selector_gain_focus", CoD.Menu.LeftRightSelectorGainFocus)
CoD.Menu:registerEventHandler("left_right_selector_lose_focus", CoD.Menu.LeftRightSelectorLoseFocus)
CoD.Menu:registerEventHandler("left_right_slider_gain_focus", CoD.Menu.LeftRightSilderGainFocus)
CoD.Menu:registerEventHandler("left_right_slider_lose_focus", CoD.Menu.LeftRightSilderLoseFocus)
CoD.Menu:registerEventHandler("resolution_changed", CoD.Menu.ResolutionChanged)
if CoD.isSinglePlayer then
	CoD.Menu:registerEventHandler("open_FrontendSaveGameWarningPopup", CoD.Menu.OpenFrontendSaveGameWarningPopup)
	CoD.Menu:registerEventHandler("open_FrontendSaveGameErrorPopup", CoD.Menu.OpenFrontendSaveGameErrorPopup)
end
