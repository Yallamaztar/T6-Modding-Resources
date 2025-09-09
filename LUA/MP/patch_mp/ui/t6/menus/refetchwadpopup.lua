CoD.RefetchWADPopup = {}
CoD.RefetchWADPopup.SetupRefetchWAD = function (f1_arg0, f1_arg1)
	local f1_local0 = LUI.UIImage.new()
	f1_local0:setLeftRight(false, false, -800, 800)
	f1_local0:setTopBottom(false, false, -400, 400)
	f1_local0:setRGB(0, 0, 0)
	f1_arg0:addElement(f1_local0)
	f1_arg0:addElement(LUI.UITimer.new(100, {
		name = "refetch_wad",
		controller = f1_arg1.controller
	}, false, f1_arg0))
end

CoD.RefetchWADPopup.RefetchWAD = function (f2_arg0, f2_arg1)
	Engine.Exec(f2_arg1.controller, "getLatestWAD")
end

CoD.RefetchWADPopup.AddButton = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = f3_arg0.buttonList:addButton(f3_arg1)
	f3_local0:setActionEventName(f3_arg2)
end

LUI.createMenu.RefetchWADConfirmationPopup = function (f4_arg0)
	local f4_local0 = CoD.Menu.NewSmallPopup("RefetchWADConfirmationPopup")
	f4_local0.anyControllerAllowed = true
	f4_local0:addSelectButton()
	f4_local0:addBackButton()
	f4_local0:registerEventHandler("setup_refetch_wad", CoD.RefetchWADPopup.SetupRefetchWAD)
	f4_local0:registerEventHandler("open_refetch_wad_confirmation_popup", CoD.NullFunction)
	f4_local0:registerEventHandler("refetch_wad", CoD.RefetchWADPopup.RefetchWAD)
	local f4_local1 = 5
	local f4_local2 = LUI.UIText.new()
	f4_local2:setLeftRight(true, true, 0, 0)
	f4_local2:setTopBottom(true, false, f4_local1, f4_local1 + CoD.textSize.Big)
	f4_local2:setFont(CoD.fonts.Big)
	f4_local2:setAlignment(LUI.Alignment.Left)
	f4_local2:setText(Engine.Localize("MENU_REFETCH_WAD_CONFIRMATION_TITLE"))
	f4_local0:addElement(f4_local2)
	f4_local1 = f4_local1 + CoD.textSize.Big + 10
	local f4_local3 = LUI.UIText.new()
	f4_local3:setLeftRight(true, true, 0, 0)
	f4_local3:setTopBottom(true, false, f4_local1, f4_local1 + CoD.textSize.Default)
	f4_local3:setFont(CoD.fonts.Default)
	f4_local3:setAlignment(LUI.Alignment.Left)
	f4_local3:setText(Engine.Localize("MENU_REFETCH_WAD_CONFIRMATION_MESSAGE"))
	f4_local0:addElement(f4_local3)
	f4_local0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10,
		bottom = 0
	})
	f4_local0:addElement(f4_local0.buttonList)
	CoD.RefetchWADPopup.AddButton(f4_local0, Engine.Localize("MENU_REFETCH_WAD_ACCEPT"), "setup_refetch_wad")
	CoD.RefetchWADPopup.AddButton(f4_local0, Engine.Localize("MENU_CANCEL"), "button_prompt_back")
	f4_local0.buttonList:processEvent({
		name = "gain_focus"
	})
	return f4_local0
end

