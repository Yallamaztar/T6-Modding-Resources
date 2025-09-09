CoD.EliteAppDownloadPopup = {}
CoD.EliteAppLaunchExecPopup = {}
CoD.EliteAppDownloadPopup.AddButton = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = f1_arg0.buttonList:addButton(f1_arg1)
	f1_local0:setActionEventName(f1_arg2)
	return f1_local0
end

CoD.EliteAppDownloadPopup.YesButtonPressed = function (f2_arg0, f2_arg1)
	Engine.ELaunchAppStore(f2_arg1.controller)
	f2_arg0:goBack(f2_arg1.controller)
end

CoD.EliteAppDownloadPopup.NoButtonPressed = function (f3_arg0, f3_arg1)
	f3_arg0:goBack(f3_arg1.controller)
end

CoD.EliteAppDownloadPopup.GoBack = function (f4_arg0, f4_arg1)
	Engine.Exec(f4_arg1, "resetThumbnailViewer")
	CoD.Menu.goBack(f4_arg0, f4_arg1)
end

CoD.EliteAppDownloadPopup.DescriptorsDone = function (f5_arg0, f5_arg1)
	f5_arg0.spinner:hide()
	local f5_local0 = Engine.GetMOTD()
	local f5_local1 = CoD.CoD9Button.Height * 3
	local f5_local2 = CoD.ButtonPrompt.Height
	f5_arg0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -f5_local2 - f5_local1,
		bottom = -f5_local2
	})
	f5_arg0:addElement(f5_arg0.buttonList)
	local f5_local3 = CoD.EliteAppDownloadPopup.AddButton(f5_arg0, Engine.Localize("MPUI_ELITE_APP_DOWNLOAD_YES"), "EliteAppDownloadPopup_YesButtonPressed")
	local f5_local4 = CoD.EliteAppDownloadPopup.AddButton(f5_arg0, Engine.Localize("MPUI_ELITE_APP_DOWNLOAD_NO"), "EliteAppDownloadPopup_NoButtonPressed")
	f5_local4:processEvent({
		name = "gain_focus"
	})
	local f5_local5 = CoD.textSize.Big + 40
	f5_arg0.enlistLabel = LUI.UIText.new()
	f5_arg0.enlistLabel:setLeftRight(true, false, 0, 500)
	f5_arg0.enlistLabel:setTopBottom(true, false, f5_local5, f5_local5 + CoD.textSize.Default)
	f5_arg0.enlistLabel:setAlignment(LUI.Alignment.Left)
	f5_arg0.enlistLabel:setFont(CoD.fonts.Default)
	f5_arg0.enlistLabel:setText(Engine.Localize("MPUI_ELITE_APP_DOWNLOAD_DESC"))
	f5_arg0:addElement(f5_arg0.enlistLabel)
	local f5_local6 = CoD.EliteRegistrationPopup.GetLogoContainer(f5_local0, false)
	if f5_local6 ~= nil then
		f5_arg0:addElement(f5_local6)
	end
end

LUI.createMenu.EliteAppDownloadPopup = function (f6_arg0)
	local f6_local0 = CoD.Menu.NewMediumPopup("EliteAppDownloadPopup")
	f6_local0:setOwner(f6_arg0)
	f6_local0.goBack = CoD.EliteAppDownloadPopup.GoBack
	f6_local0:registerEventHandler("EliteAppDownloadPopup_YesButtonPressed", CoD.EliteAppDownloadPopup.YesButtonPressed)
	f6_local0:registerEventHandler("EliteAppDownloadPopup_NoButtonPressed", CoD.EliteAppDownloadPopup.NoButtonPressed)
	f6_local0:registerEventHandler("motd_image_descriptors_done", CoD.EliteAppDownloadPopup.DescriptorsDone)
	f6_local0:addTitle(Engine.Localize("MPUI_ELITE_APP_DOWNLOAD_TITLE"))
	f6_local0.titleElement:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f6_local0:addSelectButton()
	f6_local0:addBackButton()
	f6_local0.spinner = LUI.UIImage.new()
	f6_local0.spinner:setLeftRight(false, false, -32, 32)
	f6_local0.spinner:setTopBottom(false, false, -32, 32)
	f6_local0.spinner:setImage(RegisterMaterial("lui_loader"))
	f6_local0:addElement(f6_local0.spinner)
	Engine.Exec(f6_arg0, "resetThumbnailViewer")
	Engine.Exec(f6_arg0, "motdGetImageDescriptors")
	return f6_local0
end

CoD.EliteAppLaunchExecPopup.AddButton = function (f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = f7_arg0.buttonList:addButton(f7_arg1)
	f7_local0:setActionEventName(f7_arg2)
	return f7_local0
end

CoD.EliteAppLaunchExecPopup.YesButtonPressed = function (f8_arg0, f8_arg1)
	Engine.ELaunchAppExec(f8_arg1.controller)
	f8_arg0:goBack(f8_arg1.controller)
end

CoD.EliteAppLaunchExecPopup.NoButtonPressed = function (f9_arg0, f9_arg1)
	f9_arg0:goBack(f9_arg1.controller)
end

LUI.createMenu.EliteAppLaunchExecPopup = function (f10_arg0)
	local f10_local0 = CoD.Menu.NewSmallPopup("EliteAppLaunchExecPopup")
	f10_local0:setOwner(f10_arg0)
	f10_local0:registerEventHandler("EliteAppLaunchExecPopup_YesButtonPressed", CoD.EliteAppLaunchExecPopup.YesButtonPressed)
	f10_local0:registerEventHandler("EliteAppLaunchExecPopup_NoButtonPressed", CoD.EliteAppLaunchExecPopup.NoButtonPressed)
	f10_local0.buttonList = CoD.ButtonList.new({
		left = 0,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	})
	local f10_local1 = CoD.EliteAppLaunchExecPopup.AddButton(f10_local0, Engine.Localize("MPUI_YES"), "EliteAppLaunchExecPopup_YesButtonPressed")
	local f10_local2 = CoD.EliteAppLaunchExecPopup.AddButton(f10_local0, Engine.Localize("MPUI_NO"), "EliteAppLaunchExecPopup_NoButtonPressed")
	f10_local2:processEvent({
		name = "gain_focus"
	})
	f10_local0:addElement(f10_local0.buttonList)
	f10_local0.enlistLabel = LUI.UIText.new()
	f10_local0.enlistLabel:setLeftRight(true, true, 0, 0)
	f10_local0.enlistLabel:setTopBottom(true, false, 0, CoD.textSize.Big)
	f10_local0.enlistLabel:setRGB(CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b)
	f10_local0.enlistLabel:setAlignment(LUI.Alignment.Left)
	f10_local0.enlistLabel:setFont(CoD.fonts.Condensed)
	f10_local0.enlistLabel:setText(Engine.Localize("MPUI_ELITE_APP_LAUNCH_TITLE"))
	f10_local0:addElement(f10_local0.enlistLabel)
	f10_local0.signupLabel = LUI.UIText.new()
	f10_local0.signupLabel:setLeftRight(true, true, 0, 0)
	f10_local0.signupLabel:setTopBottom(true, false, 60, 60 + CoD.textSize.Default)
	f10_local0.signupLabel:setAlignment(LUI.Alignment.Left)
	f10_local0.signupLabel:setFont(CoD.fonts.Default)
	f10_local0.signupLabel:setText(Engine.Localize("MPUI_ELITE_APP_LAUNCH_MSG"))
	f10_local0:addElement(f10_local0.signupLabel)
	f10_local0:addSelectButton()
	f10_local0:addBackButton()
	return f10_local0
end

