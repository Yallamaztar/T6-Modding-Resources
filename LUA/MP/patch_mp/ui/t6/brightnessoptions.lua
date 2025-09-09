CoD.Brightness = {}
CoD.Brightness.AdjustSFX = "cac_safearea"
CoD.Brightness.AddBrightnessShade = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -250, 250)
	Widget:setTopBottom(false, false, 0, 100)
	Widget:setRGB(f1_arg1, f1_arg2, f1_arg3)
	local f1_local1 = LUI.UIImage.new()
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, true, 0, 0)
	f1_local1:setRGB(f1_arg1, f1_arg2, f1_arg3)
	Widget:addElement(f1_local1)
	local f1_local2 = LUI.UIText.new()
	f1_local2:setLeftRight(false, false, 0, 0)
	f1_local2:setTopBottom(false, false, 0, CoD.textSize.Default)
	f1_local2:setRGB(0, 0, 0)
	f1_local2:setText(f1_arg4)
	Widget:addElement(f1_local2)
	f1_arg0:addElement(Widget)
end

CoD.Brightness.CloseFirstTime = function (f2_arg0, f2_arg1)
	f2_arg0:openMenu("AudioSettings", f2_arg1.controller)
	f2_arg0:close()
end

LUI.createMenu.Brightness = function (f3_arg0, f3_arg1)
	local f3_local0 = nil
	if UIExpression.IsInGame() == 1 then
		f3_local0 = CoD.InGameMenu.New("Brightness", f3_arg0, Engine.Localize("MENU_BRIGHTNESS_CAPS"), CoD.isSinglePlayer)
		if CoD.isSinglePlayer == false and UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
			f3_local0:sizeToSafeArea(f3_arg0)
			f3_local0:updateTitleForSplitscreen()
			f3_local0:updateButtonPromptBarsForSplitscreen()
		end
	else
		f3_local0 = CoD.Menu.New("Brightness")
		f3_local0:setOwner(f3_arg0)
		f3_local0:addTitle(Engine.Localize("MENU_BRIGHTNESS_CAPS"))
		if CoD.isSinglePlayer == false then
			f3_local0:addLargePopupBackground()
			f3_local0:registerEventHandler("signed_out", CoD.Menu.SignedOut)
		end
	end
	f3_local0.controller = f3_arg0
	if CoD.isSinglePlayer == true and CoD.perController[f3_arg0].firstTime then
		f3_local0.acceptButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_ACCEPT"), f3_local0, "accept_button")
		f3_local0:addLeftButtonPrompt(f3_local0.acceptButton)
		f3_local0:registerEventHandler("accept_button", CoD.Brightness.CloseFirstTime)
		CoD.Brightness.ListHeight = 511.25
	else
		f3_local0:addBackButton()
	end
	f3_local0.close = CoD.Options.Close
	local f3_local1 = 0
	if UIExpression.IsInGame() == 1 and CoD.isSinglePlayer == false and Engine.IsSplitscreen() == true then
		f3_local1 = CoD.Menu.SplitscreenSideOffset
	end
	local f3_local2 = CoD.ButtonList.new()
	f3_local2:setLeftRight(true, false, f3_local1, f3_local1 + CoD.ButtonList.DefaultWidth - 20)
	f3_local2:setTopBottom(true, false, CoD.Menu.TitleHeight, CoD.Menu.TitleHeight + 720)
	if CoD.isSinglePlayer == true then
		f3_local0:addElement(f3_local2)
		if f3_arg1 and f3_arg1.height ~= nil then
			f3_local2:setLeftRight(false, false, -CoD.Options.Width / 2, CoD.Options.Width / 2)
			f3_local2:setTopBottom(false, false, -f3_arg1.height / 2, f3_arg1.height / 2)
			CoD.Brightness.ListHeight = f3_arg1.height
		elseif CoD.Brightness.ListHeight then
			f3_local2:setLeftRight(false, false, -CoD.Options.Width / 2, CoD.Options.Width / 2)
			f3_local2:setTopBottom(false, false, -CoD.Brightness.ListHeight / 2, CoD.Brightness.ListHeight / 2)
		end
	else
		local f3_local3 = CoD.SplitscreenScaler.new(nil, 1.5)
		f3_local3:setLeftRight(true, false, 0, 0)
		f3_local3:setTopBottom(true, false, 0, 0)
		f3_local0:addElement(f3_local3)
		f3_local3:addElement(f3_local2)
	end
	if CoD.isPC then
		local f3_local3 = 480
		if CoD.isSinglePlayer then
			f3_local2:setLeftRight(false, false, -f3_local3 / 2, f3_local3 / 2)
		else
			f3_local2:setLeftRight(true, false, 0, f3_local3)
		end
	end
	local f3_local3 = f3_local2:addProfileLeftRightSlider(f3_arg0, Engine.Localize("MENU_BRIGHTNESS_CAPS"), "r_gamma", 0.5, 1.5, nil, nil, nil, CoD.Brightness.AdjustSFX)
	local f3_local4 = LUI.UIVerticalList.new()
	f3_local4:setLeftRight(false, false, 0, 0)
	f3_local4:setTopBottom(false, false, -100, 0)
	f3_local0:addElement(f3_local4)
	f3_local4.priority = -100
	if CoD.isPS3 then
		CoD.Brightness.AddBrightnessShade(f3_local4, 0.02, 0.02, 0.02, Engine.Localize("MENU_BRIGHTNESS_NOT_VISIBLE"))
		CoD.Brightness.AddBrightnessShade(f3_local4, 0.07, 0.07, 0.07, Engine.Localize("MENU_BRIGHTNESS_BARELY_VISIBLE"))
		CoD.Brightness.AddBrightnessShade(f3_local4, 0.21, 0.21, 0.21, Engine.Localize("MENU_BRIGHTNESS_EASILY_VISIBLE"))
	else
		CoD.Brightness.AddBrightnessShade(f3_local4, 0.06, 0.06, 0.06, Engine.Localize("MENU_BRIGHTNESS_NOT_VISIBLE"))
		CoD.Brightness.AddBrightnessShade(f3_local4, 0.12, 0.12, 0.12, Engine.Localize("MENU_BRIGHTNESS_BARELY_VISIBLE"))
		CoD.Brightness.AddBrightnessShade(f3_local4, 0.25, 0.25, 0.25, Engine.Localize("MENU_BRIGHTNESS_EASILY_VISIBLE"))
	end
	f3_local4:beginAnimation("fade_in", f3_local0.fadeInTime, false, false)
	f3_local4:setAlpha(1)
	if CoD.useController then
		f3_local3:processEvent({
			name = "gain_focus"
		})
	end
	Engine.PlaySound("cac_grid_nav")
	return f3_local0
end

