CoD.EliteWelcomePopup = {}
CoD.EliteWelcomeFounderPopup = {}
CoD.EliteWelcomePopup.GoBack = function (f1_arg0, f1_arg1)
	Engine.Exec(f1_arg1, "resetThumbnailViewer")
	CoD.Menu.goBack(f1_arg0, f1_arg1)
end

CoD.EliteWelcomePopup.AcceptButtonPressed = function (f2_arg0, f2_arg1)
	f2_arg0:goBack(f2_arg1.controller)
	f2_arg0.occludedMenu:processEvent({
		name = "elite_registration_ended",
		controller = f2_arg1.controller
	})
end

CoD.EliteWelcomePopup.DescriptorsDone = function (f3_arg0, f3_arg1)
	f3_arg0.spinner:hide()
	local f3_local0 = Engine.GetMOTD()
	local f3_local1 = CoD.textSize.Big + 60
	f3_arg0.enlistLabel = LUI.UIText.new()
	f3_arg0.enlistLabel:setLeftRight(true, true, 0, 0)
	f3_arg0.enlistLabel:setTopBottom(true, false, f3_local1, f3_local1 + CoD.textSize.Default)
	f3_arg0.enlistLabel:setAlpha(0.4)
	f3_arg0.enlistLabel:setAlignment(LUI.Alignment.Left)
	f3_arg0.enlistLabel:setFont(CoD.fonts.Default)
	f3_arg0.enlistLabel:setText(Engine.Localize("MPUI_WELCOME_BACK_TITLE", UIExpression.GetSelfGamertag(controller)))
	f3_arg0:addElement(f3_arg0.enlistLabel)
	f3_local1 = f3_local1 + CoD.textSize.Default * 1.5
	f3_arg0.welcomeMsg = LUI.UIText.new(nil, true)
	f3_arg0.welcomeMsg:setLeftRight(true, false, 0, 500)
	f3_arg0.welcomeMsg:setTopBottom(true, false, f3_local1, f3_local1 + CoD.textSize.Default)
	f3_arg0.welcomeMsg:setAlignment(LUI.Alignment.Left)
	f3_arg0.welcomeMsg:setFont(CoD.fonts.Default)
	f3_arg0.welcomeMsg:setText(Engine.Localize("MPUI_WELCOME_BACK_MSG"))
	f3_arg0:addElement(f3_arg0.welcomeMsg)
	f3_arg0:addElement(CoD.EliteRegistrationPopup.GetLogoContainer(f3_local0, false))
end

LUI.createMenu.EliteWelcomePopup = function (f4_arg0)
	local f4_local0 = CoD.Menu.New("EliteWelcomePopup")
	f4_local0:setOwner(f4_arg0)
	f4_local0:addTitle(Engine.Localize("MPUI_COD_ELITE_CAPS"))
	f4_local0:addLargePopupBackground()
	f4_local0.goBack = CoD.EliteWelcomePopup.GoBack
	f4_local0:registerEventHandler("EliteWelcomePopup_AcceptButtonPressed", CoD.EliteWelcomePopup.AcceptButtonPressed)
	f4_local0:registerEventHandler("motd_image_descriptors_done", CoD.EliteWelcomePopup.DescriptorsDone)
	f4_local0.acceptButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_MOTD_ACCEPT"), f4_local0, "EliteWelcomePopup_AcceptButtonPressed")
	f4_local0:addLeftButtonPrompt(f4_local0.acceptButton)
	f4_local0:addBackButton()
	f4_local0.spinner = LUI.UIImage.new()
	f4_local0.spinner:setLeftRight(false, false, -32, 32)
	f4_local0.spinner:setTopBottom(false, false, -32, 32)
	f4_local0.spinner:setImage(RegisterMaterial("lui_loader"))
	f4_local0:addElement(f4_local0.spinner)
	Engine.Exec(f4_arg0, "resetThumbnailViewer")
	Engine.Exec(f4_arg0, "motdGetImageDescriptors")
	return f4_local0
end

CoD.EliteWelcomeFounderPopup.GoBack = function (f5_arg0, f5_arg1)
	Engine.Exec(f5_arg1, "resetThumbnailViewer")
	CoD.Menu.goBack(f5_arg0, f5_arg1)
end

CoD.EliteWelcomeFounderPopup.AcceptButtonPressed = function (f6_arg0, f6_arg1)
	Engine.Exec(controller, "resetThumbnailViewer")
	f6_arg0:goBack(f6_arg1.controller)
	f6_arg0.occludedMenu:processEvent({
		name = "elite_registration_ended",
		controller = f6_arg1.controller
	})
end

CoD.EliteWelcomeFounderPopup.DescriptorsDone = function (f7_arg0, f7_arg1)
	f7_arg0.spinner:hide()
	local f7_local0 = Engine.GetMOTD()
	local f7_local1 = CoD.textSize.Big + 45
	f7_arg0.enlistLabel = LUI.UIText.new()
	f7_arg0.enlistLabel:setLeftRight(true, true, 0, 0)
	f7_arg0.enlistLabel:setTopBottom(true, false, f7_local1, f7_local1 + CoD.textSize.Default)
	f7_arg0.enlistLabel:setAlpha(0.4)
	f7_arg0.enlistLabel:setAlignment(LUI.Alignment.Left)
	f7_arg0.enlistLabel:setFont(CoD.fonts.Default)
	f7_arg0.enlistLabel:setText(Engine.Localize("MPUI_WELCOME_BACK_TITLE", UIExpression.GetSelfGamertag(controller)))
	f7_arg0:addElement(f7_arg0.enlistLabel)
	f7_local1 = f7_local1 + CoD.textSize.Default * 1.5
	f7_arg0.signupLabel = LUI.UIText.new(nil, true)
	f7_arg0.signupLabel:setLeftRight(true, false, 0, 520)
	f7_arg0.signupLabel:setTopBottom(true, false, f7_local1, f7_local1 + CoD.textSize.Default)
	f7_arg0.signupLabel:setAlignment(LUI.Alignment.Left)
	f7_arg0.signupLabel:setFont(CoD.fonts.Default)
	f7_arg0.signupLabel:setText(Engine.Localize("MPUI_WELCOME_BACK_MSG_FOR_FOUNDERS"))
	f7_arg0:addElement(f7_arg0.signupLabel)
	f7_arg0:addElement(CoD.EliteRegistrationPopup.GetLogoContainer(f7_local0, true))
end

LUI.createMenu.EliteWelcomeFounderPopup = function (f8_arg0)
	local f8_local0 = CoD.Menu.New("EliteWelcomeFounderPopup")
	f8_local0:setOwner(f8_arg0)
	f8_local0:addTitle(Engine.Localize("MPUI_COD_ELITE_CAPS"))
	f8_local0:addLargePopupBackground()
	f8_local0.goBack = CoD.EliteWelcomeFounderPopup.GoBack
	f8_local0:registerEventHandler("EliteWelcomeFounderPopup_AcceptButtonPressed", CoD.EliteWelcomeFounderPopup.AcceptButtonPressed)
	f8_local0:registerEventHandler("motd_image_descriptors_done", CoD.EliteWelcomeFounderPopup.DescriptorsDone)
	f8_local0.acceptButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_MOTD_ACCEPT"), f8_local0, "EliteWelcomeFounderPopup_AcceptButtonPressed")
	f8_local0:addLeftButtonPrompt(f8_local0.acceptButton)
	f8_local0:addBackButton()
	f8_local0.spinner = LUI.UIImage.new()
	f8_local0.spinner:setLeftRight(false, false, -32, 32)
	f8_local0.spinner:setTopBottom(false, false, -32, 32)
	f8_local0.spinner:setImage(RegisterMaterial("lui_loader"))
	f8_local0:addElement(f8_local0.spinner)
	Engine.Exec(f8_arg0, "resetThumbnailViewer")
	Engine.Exec(f8_arg0, "motdGetImageDescriptors")
	return f8_local0
end

