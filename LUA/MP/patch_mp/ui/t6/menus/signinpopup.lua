CoD.SignIn = {}
CoD.SignIn.GuestButton = function (f1_arg0, f1_arg1)
	Engine.Exec(f1_arg1.controller, "xsigninguest")
	f1_arg0:goBack(f1_arg1.controller)
end

CoD.SignIn.SubButton = function (f2_arg0, f2_arg1)
	Engine.Exec(f2_arg1.controller, "xsigninlive")
	f2_arg0:goBack(f2_arg1.controller)
end

LUI.createMenu.SignIn = function (f3_arg0)
	local f3_local0 = CoD.Menu.NewSmallPopup("SignIn")
	f3_local0:addTitle(Engine.Localize("MENU_SIGN_IN_CAPS"))
	f3_local0.m_ownerController = f3_arg0
	f3_local0.unusedControllerAllowed = true
	f3_local0:addBackButton()
	local f3_local1 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	f3_local0:addElement(f3_local1)
	local f3_local2 = f3_local1:addButton(Engine.Localize("MENU_USE_GUEST"))
	f3_local2:setActionEventName("signin_popup_guest")
	f3_local0:registerEventHandler("signin_popup_guest", CoD.SignIn.GuestButton)
	local f3_local3 = f3_local1:addButton(Engine.Localize("XBOXLIVE_SIGNIN"))
	f3_local3:setActionEventName("signin_popup_subuser")
	f3_local0:registerEventHandler("signin_popup_subuser", CoD.SignIn.SubButton)
	if CoD.useController then
		f3_local1:processEvent({
			name = "gain_focus"
		})
	end
	return f3_local0
end

