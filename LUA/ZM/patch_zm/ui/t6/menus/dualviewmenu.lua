CoD.DualViewMenu = {}
CoD.DualViewMenu.WarningFontName = "Default"
CoD.DualViewMenu.SelectionChangedCallback = function (f1_arg0, f1_arg1)
	if Dvar[f1_arg0.parentSelectorButton.m_dvarName]:get() ~= f1_arg0.value then
		f1_arg0.parentSelectorButton:dispatchEventToParent({
			name = "open_dual_view_confirmation_popup",
			controller = f1_arg0.parentSelectorButton.m_currentController
		})
	end
end

CoD.DualViewMenu.DualViewMenuConfirmation = function (f2_arg0, f2_arg1)
	f2_arg0:openPopup("DualViewMenuConfirmation", f2_arg1.controller)
end

CoD.DualViewMenu.WarningText = function (f3_arg0, f3_arg1)
	local f3_local0 = CoD.fonts[CoD.DualViewMenu.WarningFontName]
	local f3_local1 = CoD.textSize[CoD.DualViewMenu.WarningFontName]
	local f3_local2 = Engine.GetNumTextLines(f3_arg0, f3_local0, f3_local1, CoD.Menu.Width - 20)
	local f3_local3 = LUI.UIText.new()
	f3_local3:setLeftRight(true, true, 0, 0)
	f3_local3:setTopBottom(true, false, f3_arg1, f3_arg1 + f3_local1)
	f3_local3:setFont(f3_local0)
	f3_local3:setAlignment(LUI.Alignment.Left)
	f3_local3:setText(f3_arg0)
	return f3_local3, f3_local2
end

LUI.createMenu.DualViewMenu = function (f4_arg0)
	local f4_local0 = nil
	if UIExpression.IsInGame() == 1 then
		f4_local0 = CoD.InGameMenu.New("DualViewMenu", f4_arg0, Engine.Localize("MENU_DUAL_VIEW_SETTINGS_CAPS"))
	else
		f4_local0 = CoD.Menu.New("DualViewMenu")
		f4_local0:setOwner(f4_arg0)
		f4_local0:addTitle(Engine.Localize("MENU_DUAL_VIEW_SETTINGS_CAPS"))
		if CoD.isMultiplayer == true then
			f4_local0:addLargePopupBackground()
			f4_local0:registerEventHandler("signed_out", CoD.Menu.SignedOut)
		end
	end
	f4_local0.controller = f4_arg0
	f4_local0:registerEventHandler("open_dual_view_confirmation_popup", CoD.DualViewMenu.DualViewMenuConfirmation)
	f4_local0:addSelectButton()
	f4_local0:addBackButton()
	local f4_local1 = CoD.Menu.TitleHeight + 30
	local f4_local2 = 10
	local f4_local3 = CoD.fonts[CoD.DualViewMenu.WarningFontName]
	local f4_local4 = CoD.textSize[CoD.DualViewMenu.WarningFontName]
	local f4_local5 = f4_local4 * 12
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f4_local2, -f4_local2)
	Widget:setTopBottom(true, false, f4_local1, f4_local1 + f4_local5)
	f4_local0:addElement(Widget)
	local f4_local7 = 0
	local f4_local8 = LUI.UIText.new()
	f4_local8:setLeftRight(true, true, 0, 0)
	f4_local8:setTopBottom(true, false, f4_local7, f4_local7 + f4_local4)
	f4_local8:setFont(f4_local3)
	f4_local8:setAlignment(LUI.Alignment.Left)
	f4_local8:setText(Engine.Localize("PLATFORM_DUAL_VIEW_WARNING_TITLE_CAPS"))
	Widget:addElement(f4_local8)
	local f4_local9 = f4_local4 + 20
	local f4_local10, f4_local11 = CoD.DualViewMenu.WarningText(Engine.Localize("PLATFORM_DUAL_VIEW_WARNING_TEXT_1"), f4_local9)
	Widget:addElement(f4_local10)
	local f4_local12 = f4_local9 + f4_local4 * (f4_local11 + 1)
	local f4_local13, f4_local14 = CoD.DualViewMenu.WarningText(Engine.Localize("PLATFORM_DUAL_VIEW_WARNING_TEXT_2"), f4_local12)
	Widget:addElement(f4_local13)
	local f4_local15, f4_local16 = CoD.DualViewMenu.WarningText(Engine.Localize("PLATFORM_DUAL_VIEW_WARNING_TEXT_3"), f4_local12 + f4_local4 * (f4_local14 + 1))
	Widget:addElement(f4_local15)
	local f4_local17 = CoD.CoD9Button.Height * 3
	local f4_local18 = CoD.CoD9Button.Height * 3 - 20
	local f4_local19 = CoD.ButtonList.new()
	f4_local19:setLeftRight(true, false, f4_local2, f4_local2 + CoD.ButtonList.DefaultWidth)
	f4_local19:setTopBottom(false, true, -f4_local17 - f4_local18, f4_local18)
	f4_local0:addElement(f4_local19)
	local f4_local20 = f4_local19:addDvarLeftRightSelector(f4_arg0, Engine.Localize("MENU_DUAL_VIEW_SETTINGS_CAPS"), "r_dualPlayEnable", Engine.Localize("MENU_DUAL_VIEW_SETTINGS_DESC"))
	f4_local20:addChoice(f4_arg0, Engine.Localize("MENU_DISABLED_CAPS"), 0)
	f4_local20:addChoice(f4_arg0, Engine.Localize("MENU_ENABLED_CAPS"), 1)
	f4_local20.m_choices[1].callbackFunc = CoD.DualViewMenu.SelectionChangedCallback
	f4_local20.m_choices[2].callbackFunc = CoD.DualViewMenu.SelectionChangedCallback
	f4_local20:processEvent({
		name = "gain_focus"
	})
	Engine.PlaySound("cac_grid_nav")
	return f4_local0
end

CoD.DualViewMenuConfirmation = {}
CoD.DualViewMenuConfirmation.Button_Confirm = function (f5_arg0, f5_arg1)
	Engine.Exec(f5_arg1.controller, "toggle r_dualPlayEnable")
	f5_arg0:goBack(f5_arg1.controller)
end

LUI.createMenu.DualViewMenuConfirmation = function (f6_arg0)
	local f6_local0 = CoD.Menu.NewSmallPopup("DualViewMenuConfirmation")
	f6_local0:registerEventHandler("confirm_action", CoD.DualViewMenuConfirmation.Button_Confirm)
	f6_local0:registerEventHandler("cancel_action", CoD.Menu.goBack)
	local f6_local1 = 5
	local f6_local2 = LUI.UIText.new()
	f6_local2:setLeftRight(true, true, 0, 0)
	f6_local2:setTopBottom(true, false, f6_local1, f6_local1 + CoD.textSize.Default)
	f6_local2:setFont(CoD.fonts.Default)
	f6_local2:setAlignment(LUI.Alignment.Left)
	f6_local0:addElement(f6_local2)
	if Dvar.r_dualPlayEnable:get() == true then
		f6_local2:setText(Engine.Localize("PLATFORM_DUAL_VIEW_OPTION_TITLE_OFF"))
	else
		f6_local2:setText(Engine.Localize("PLATFORM_DUAL_VIEW_OPTION_TITLE_ON"))
	end
	local f6_local3 = CoD.ButtonList.new()
	f6_local3:setLeftRight(true, true, 0, 0)
	f6_local3:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height - 21, -15)
	f6_local0:addElement(f6_local3)
	local f6_local4 = Engine.Localize("MENU_CONFIRM_CAPS")
	if CoD.isMultiplayer == true then
		f6_local4 = Engine.Localize("MENU_EMBLEM_CONFIRM_CHANGES")
	end
	local f6_local5 = f6_local3:addButton(f6_local4)
	f6_local5:setActionEventName("confirm_action")
	f6_local5:processEvent({
		name = "gain_focus"
	})
	return f6_local0
end

