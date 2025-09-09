require("T6.Menus.Stereoscopic3DConfirmationPopup")
CoD.Stereoscopic3D = {}
CoD.Stereoscopic3D.WarningFontName = "Default"
CoD.Stereoscopic3D.Button_3D = function (f1_arg0, f1_arg1)
	f1_arg0:dispatchEventToParent({
		name = "open_stereo_confirmation_popup",
		controller = f1_arg1.controller
	})
end

CoD.Stereoscopic3D.OpenStereoConfirmationPopup = function (f2_arg0, f2_arg1)
	f2_arg0:openPopup("Stereoscopic3DConfirmation", f2_arg1.controller)
end

CoD.Stereoscopic3D.WarningText = function (f3_arg0, f3_arg1)
	local f3_local0 = CoD.fonts[CoD.Stereoscopic3D.WarningFontName]
	local f3_local1 = CoD.textSize[CoD.Stereoscopic3D.WarningFontName]
	local f3_local2 = Engine.GetNumTextLines(f3_arg0, f3_local0, f3_local1, CoD.Menu.Width - 20)
	local f3_local3 = LUI.UIText.new()
	f3_local3:setLeftRight(true, true, 0, 0)
	f3_local3:setTopBottom(true, false, f3_arg1, f3_arg1 + f3_local1)
	f3_local3:setFont(f3_local0)
	f3_local3:setAlignment(LUI.Alignment.Left)
	f3_local3:setText(f3_arg0)
	return f3_local3, f3_local2
end

LUI.createMenu.Stereoscopic3D = function (f4_arg0)
	local f4_local0 = nil
	if UIExpression.IsInGame() == 1 then
		f4_local0 = CoD.InGameMenu.New("Stereoscopic3D", f4_arg0, Engine.Localize("MENU_STEREO_3D_SETTINGS_CAPS"), CoD.isSinglePlayer)
	else
		f4_local0 = CoD.Menu.New("Stereoscopic3D")
		f4_local0:setOwner(f4_arg0)
		f4_local0:addTitle(Engine.Localize("MENU_STEREO_3D_SETTINGS_CAPS"))
		if CoD.isMultiplayer == true then
			f4_local0:addLargePopupBackground()
			f4_local0:registerEventHandler("signed_out", CoD.Options.SignedOut_MPZM)
		end
	end
	f4_local0.controller = f4_arg0
	f4_local0:registerEventHandler("open_stereo_confirmation_popup", CoD.Stereoscopic3D.OpenStereoConfirmationPopup)
	f4_local0:addSelectButton()
	f4_local0:addBackButton()
	local f4_local1 = CoD.Menu.TitleHeight + 30
	local f4_local2 = 10
	local f4_local3 = CoD.fonts[CoD.Stereoscopic3D.WarningFontName]
	local f4_local4 = CoD.textSize[CoD.Stereoscopic3D.WarningFontName]
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
	f4_local8:setText(Engine.Localize("PLATFORM_3D_WARNING_TITLE_CAPS"))
	Widget:addElement(f4_local8)
	local f4_local9 = f4_local4 + 20
	local f4_local10, f4_local11 = CoD.Stereoscopic3D.WarningText(Engine.Localize("PLATFORM_3D_WARNING_TEXT_1"), f4_local9)
	Widget:addElement(f4_local10)
	local f4_local12 = f4_local9 + f4_local4 * (f4_local11 + 1)
	local f4_local13, f4_local14 = CoD.Stereoscopic3D.WarningText(Engine.Localize("PLATFORM_3D_WARNING_TEXT_2"), f4_local12)
	Widget:addElement(f4_local13)
	local f4_local15, f4_local16 = CoD.Stereoscopic3D.WarningText(Engine.Localize("PLATFORM_3D_WARNING_TEXT_3"), f4_local12 + f4_local4 * (f4_local14 + 1))
	Widget:addElement(f4_local15)
	local f4_local17 = CoD.CoD9Button.Height * 3
	local f4_local18 = CoD.CoD9Button.Height * 3 - 20
	local f4_local19 = CoD.ButtonList.new()
	f4_local19:setLeftRight(true, false, f4_local2, f4_local2 + CoD.ButtonList.DefaultWidth)
	f4_local19:setTopBottom(false, true, -f4_local17 - f4_local18, f4_local18)
	f4_local0:addElement(f4_local19)
	local f4_local20 = {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = CoD.CoD9Button.Height
	}
	local f4_local21 = Dvar.r_stereo3DOn:get()
	local f4_local22 = CoD.LeftRightSelector.new(Engine.Localize("MENU_STEREO_3D_CAPS"), f4_local21, nil, f4_local20)
	f4_local22.hintText = Engine.Localize("MENU_STEREO_3D_DESC")
	CoD.ButtonList.AssociateHintTextListenerToButton(f4_local22)
	f4_local22:registerEventHandler("button_action", CoD.Stereoscopic3D.Button_3D)
	f4_local22:disableCycling()
	f4_local19:addElement(f4_local22)
	if UIExpression.IsInGame() == 1 then
		f4_local22:disable()
	end
	if f4_local21 then
		f4_local22.choiceText:setText(Engine.Localize("MENU_ENABLED_CAPS"))
	else
		f4_local22.choiceText:setText(Engine.Localize("MENU_DISABLED_CAPS"))
	end
	f4_local22:processEvent({
		name = "gain_focus"
	})
	return f4_local0
end

