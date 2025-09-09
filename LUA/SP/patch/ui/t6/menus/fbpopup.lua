CoD.FBPopup = {}
local f0_local0 = function (f1_arg0, f1_arg1)
	Engine.Exec(f1_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_FACEBOOK_USER)
end

local f0_local1 = function (f2_arg0, f2_arg1)
	Engine.Exec(f2_arg1.controller, "ui_keyboard_new " .. CoD.KEYBOARD_TYPE_FACEBOOK_PASS)
end

local f0_local2 = function (f3_arg0, f3_arg1)
	f3_arg0:setLabel(f3_arg1.text)
end

local f0_local3 = function (f4_arg0, f4_arg1)
	Engine.Exec(f4_arg1.controller, "fbRegister")
	f4_arg0:goBack(f4_arg1.controller)
end

LUI.createMenu.FBPopup = function (f5_arg0)
	local f5_local0 = CoD.Menu.NewSmallPopup("FBPopup")
	f5_local0.m_ownerController = f5_arg0
	f5_local0:addBackButton()
	local f5_local1 = 50
	local f5_local2 = LUI.UIImage.new()
	f5_local2:setLeftRight(false, true, -f5_local1, 0)
	f5_local2:setTopBottom(true, false, 0, f5_local1)
	f5_local2:setImage(RegisterMaterial("menu_lobby_icon_facebook"))
	f5_local0:addElement(f5_local2)
	local f5_local3 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 5,
		bottom = 0
	})
	f5_local0:addElement(f5_local3)
	f5_local3:addText(Engine.Localize("MENU_USERNAME_CAPS"))
	local f5_local4 = f5_local3:addButton(Engine.Localize("MENU_USERNAME"))
	f5_local4:setActionEventName("fb_enter_username")
	f5_local4:registerEventHandler("fb_username_entered", f0_local2)
	f5_local0:registerEventHandler("fb_enter_username", f0_local0)
	local f5_local5 = LUI.UIImage.new()
	f5_local5:setLeftRight(true, true, 0, -f5_local1 * 2)
	f5_local5:setTopBottom(true, true, 0, 0)
	f5_local5:setRGB(0.5, 0.5, 0.5)
	f5_local5:setAlpha(0.5)
	f5_local4:addElement(f5_local5)
	f5_local3:addText(Engine.Localize("MENU_PASSWORD_CAPS"))
	local f5_local6 = f5_local3:addButton(Engine.Localize("MENU_PASSWORD"))
	f5_local6:setActionEventName("fb_enter_password")
	f5_local6:registerEventHandler("fb_password_entered", f0_local2)
	f5_local0:registerEventHandler("fb_enter_password", f0_local1)
	local f5_local7 = LUI.UIImage.new()
	f5_local7:setLeftRight(true, true, 0, -f5_local1 * 2)
	f5_local7:setTopBottom(true, true, 0, 0)
	f5_local7:setRGB(0.5, 0.5, 0.5)
	f5_local7:setAlpha(0.5)
	f5_local6:addElement(f5_local7)
	f5_local3:addSpacer(CoD.CoD9Button.Height)
	local f5_local8 = f5_local3:addButton(Engine.Localize("MENU_SIGN_IN_CAPS"))
	f5_local8:setActionEventName("fb_signin")
	f5_local0:registerEventHandler("fb_signin", f0_local3)
	f5_local4:processEvent({
		name = "gain_focus"
	})
	return f5_local0
end

