require("T6.Options")
CoD.GraphicsSettings = {}
CoD.GraphicsSettings.Button_SafeArea = function (f1_arg0, f1_arg1)
	f1_arg0:dispatchEventToParent({
		name = "open_safe_area",
		controller = f1_arg1.controller
	})
end

CoD.GraphicsSettings.OpenSafeArea = function (f2_arg0, f2_arg1)
	f2_arg0:saveState()
	f2_arg0:openMenu("SafeArea", f2_arg1.controller)
	f2_arg0:close()
end

CoD.GraphicsSettings.Button_Brightness = function (f3_arg0, f3_arg1)
	f3_arg0:dispatchEventToParent({
		name = "open_brightness",
		controller = f3_arg1.controller
	})
end

CoD.GraphicsSettings.OpenBrightness = function (f4_arg0, f4_arg1)
	f4_arg0:saveState()
	local f4_local0 = {}
	if f4_arg0.buttonList ~= nil then
		f4_local0.height = CoD.GraphicsSettings.ListHeight
	end
	f4_arg0:openMenu("Brightness", f4_arg1.controller, f4_local0)
	f4_arg0:close()
end

CoD.GraphicsSettings.Open3D = function (f5_arg0, f5_arg1)
	f5_arg0:saveState()
	f5_arg0:openMenu("Stereoscopic3D", f5_arg1.controller)
	f5_arg0:close()
end

CoD.GraphicsSettings.Button_Stereoscopic3D = function (f6_arg0, f6_arg1)
	f6_arg0:dispatchEventToParent({
		name = "open_3d",
		controller = f6_arg1.controller
	})
end

CoD.GraphicsSettings.OpenDualView = function (f7_arg0, f7_arg1)
	f7_arg0:saveState()
	f7_arg0:openMenu("DualViewMenu", f7_arg1.controller)
	f7_arg0:close()
end

CoD.GraphicsSettings.Button_DualView = function (f8_arg0, f8_arg1)
	f8_arg0:dispatchEventToParent({
		name = "open_dual_view",
		controller = f8_arg1.controller
	})
end

CoD.GraphicsSettings.AnaglyphSelectionChangedCallback = function (f9_arg0)
	Engine.SetDvar(f9_arg0.parentSelectorButton.m_dvarName, f9_arg0.value)
	f9_arg0.parentSelectorButton:dispatchEventToParent({
		name = "update_buttonlist"
	})
end

CoD.GraphicsSettings.UpdateButtonList = function (f10_arg0, f10_arg1)
	if f10_arg0.stereoscopic3dButton then
		if Dvar.r_stereo3DAvailable:get() == false or Dvar.r_dualPlayEnable:get() == true or Dvar.r_anaglyphFX_enable:get() == true then
			f10_arg0.stereoscopic3dButton:disable()
		else
			f10_arg0.stereoscopic3dButton:enable()
		end
	end
	if f10_arg0.dualViewButton then
		if Dvar.r_stereo3DOn:get() == true or Dvar.r_anaglyphFX_enable:get() == true then
			f10_arg0.dualViewButton:disable()
		else
			f10_arg0.dualViewButton:enable()
		end
	end
end

CoD.GraphicsSettings.AddBackButtonTimer = function (f11_arg0, f11_arg1)
	f11_arg0:addBackButton()
	f11_arg0.backButtonTimer:close()
	f11_arg0.backButtonTimer = nil
end

LUI.createMenu.GraphicsSettings = function (f12_arg0, f12_arg1)
	local f12_local0 = nil
	if UIExpression.IsInGame() == 1 then
		f12_local0 = CoD.InGameMenu.New("GraphicsSettings", f12_arg0, Engine.Localize("MENU_GRAPHICS_SETTINGS_CAPS"), CoD.isSinglePlayer)
		if CoD.isSinglePlayer == false and UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
			f12_local0:sizeToSafeArea(f12_arg0)
			f12_local0:updateTitleForSplitscreen()
			f12_local0:updateButtonPromptBarsForSplitscreen()
		end
	else
		f12_local0 = CoD.Menu.New("GraphicsSettings")
		f12_local0:setOwner(f12_arg0)
		f12_local0:addTitle(Engine.Localize("MENU_GRAPHICS_SETTINGS_CAPS"))
		if CoD.isSinglePlayer == false then
			f12_local0:addLargePopupBackground()
			f12_local0:registerEventHandler("signed_out", CoD.Menu.SignedOut)
		end
	end
	f12_local0:setPreviousMenu("OptionsMenu")
	f12_local0.controller = f12_arg0
	f12_local0:setOwner(f12_arg0)
	f12_local0:registerEventHandler("open_safe_area", CoD.GraphicsSettings.OpenSafeArea)
	f12_local0:registerEventHandler("open_brightness", CoD.GraphicsSettings.OpenBrightness)
	f12_local0:registerEventHandler("open_3d", CoD.GraphicsSettings.Open3D)
	f12_local0:registerEventHandler("open_dual_view", CoD.GraphicsSettings.OpenDualView)
	f12_local0:registerEventHandler("update_buttonlist", CoD.GraphicsSettings.UpdateButtonList)
	if CoD.isSinglePlayer == true and CoD.perController[f12_arg0].firstTime then
		f12_local0.acceptButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_ACCEPT"), f12_local0, "accept_button")
		f12_local0:addLeftButtonPrompt(f12_local0.acceptButton)
		f12_local0:registerEventHandler("accept_button", CoD.GraphicsSettings.CloseFirstTime)
		f12_local0:registerEventHandler("remove_accept_button", CoD.GraphicsSettings.RemoveAcceptButton)
		f12_local0:registerEventHandler("readd_accept_button", CoD.GraphicsSettings.ReaddAcceptButton)
		CoD.GraphicsSettings.ListHeight = 421.25
	else
		f12_local0:addSelectButton()
		f12_local0:registerEventHandler("add_back_button", CoD.GraphicsSettings.AddBackButtonTimer)
		f12_local0.backButtonTimer = LUI.UITimer.new(350, {
			name = "add_back_button",
			controller = f12_arg0
		})
		f12_local0:addElement(f12_local0.backButtonTimer)
	end
	f12_local0.close = CoD.Options.Close
	f12_local0.graphicsListButtons = {}
	local f12_local1 = 0
	if UIExpression.IsInGame() == 1 and CoD.isSinglePlayer == false and Engine.IsSplitscreen() == true then
		f12_local1 = CoD.Menu.SplitscreenSideOffset
	end
	local f12_local2 = CoD.ButtonList.new()
	f12_local2:setLeftRight(true, false, f12_local1, f12_local1 + CoD.Options.Width)
	f12_local2:setTopBottom(true, false, CoD.Menu.TitleHeight, CoD.Menu.TitleHeight + 720)
	if CoD.isSinglePlayer then
		f12_local0:addElement(f12_local2)
		if f12_arg1 and f12_arg1.height ~= nil then
			f12_local2:setLeftRight(false, false, -CoD.Options.Width / 2, CoD.Options.Width / 2)
			f12_local2:setTopBottom(false, false, -f12_arg1.height / 2, f12_arg1.height / 2)
			CoD.GraphicsSettings.ListHeight = f12_arg1.height
		elseif CoD.GraphicsSettings.ListHeight then
			f12_local2:setLeftRight(false, false, -CoD.Options.Width / 2, CoD.Options.Width / 2)
			f12_local2:setTopBottom(false, false, -CoD.GraphicsSettings.ListHeight / 2, CoD.GraphicsSettings.ListHeight / 2)
		end
	else
		local f12_local3 = CoD.SplitscreenScaler.new(nil, 1.5)
		f12_local3:setLeftRight(true, false, 0, 0)
		f12_local3:setTopBottom(true, false, 0, 0)
		f12_local0:addElement(f12_local3)
		f12_local3:addElement(f12_local2)
	end
	if UIExpression.SplitscreenNum() == 1 or UIExpression.IsPrimaryLocalClient(f12_arg0) == 1 and UIExpression.IsInGame() == 0 then
		f12_local0.safeAreaButton = f12_local2:addButton(Engine.Localize("MENU_SAFE_AREA_CAPS"), Engine.Localize("MENU_SAFE_AREA_DESC"))
		f12_local0.safeAreaButton:registerEventHandler("button_action", CoD.GraphicsSettings.Button_SafeArea)
		table.insert(f12_local0.graphicsListButtons, f12_local0.safeAreaButton)
	end
	if UIExpression.SplitscreenNum() == 1 or UIExpression.IsPrimaryLocalClient(f12_arg0) == 1 then
		f12_local0.brightnessButton = f12_local2:addButton(Engine.Localize("MENU_BRIGHTNESS_CAPS"), Engine.Localize("MENU_BRIGHTNESS_DESC"))
		f12_local0.brightnessButton:registerEventHandler("button_action", CoD.GraphicsSettings.Button_Brightness)
		table.insert(f12_local0.graphicsListButtons, f12_local0.brightnessButton)
	end
	if not CoD.isWIIU then
		f12_local0.anaglyphButton = f12_local2:addDvarLeftRightSelector(f12_arg0, Engine.Localize("MENU_ANAGLYPH_3D_CAPS"), "r_anaglyphFX_enable", Engine.Localize("MENU_ANAGLYPH_3D_DESC"))
		f12_local0.anaglyphButton:addChoice(f12_arg0, Engine.Localize("MENU_DISABLED_CAPS"), 0, nil, CoD.GraphicsSettings.AnaglyphSelectionChangedCallback)
		f12_local0.anaglyphButton:addChoice(f12_arg0, Engine.Localize("MENU_ENABLED_CAPS"), 1, nil, CoD.GraphicsSettings.AnaglyphSelectionChangedCallback)
		table.insert(f12_local0.graphicsListButtons, f12_local0.anaglyphButton)
		if true == Dvar.r_stereo3DOn:get() or true == Dvar.r_dualPlayEnable:get() then
			f12_local0.anaglyphButton:disable()
		end
	end
	if not Engine.IsBetaBuild() and not CoD.isWIIU and UIExpression.IsInGame() == 0 then
		f12_local0.stereoscopic3dButton = f12_local2:addButton(Engine.Localize("MENU_STEREO_3D_SETTINGS_CAPS"), Engine.Localize("MENU_STEREO_3D_SETTINGS_DESC"))
		table.insert(f12_local0.graphicsListButtons, f12_local0.stereoscopic3dButton)
		f12_local0.stereoscopic3dButton:registerEventHandler("button_action", CoD.GraphicsSettings.Button_Stereoscopic3D)
		if false == Dvar.r_stereo3DAvailable:get() or true == Dvar.r_dualPlayEnable:get() or true == Dvar.r_anaglyphFX_enable:get() then
			f12_local0.stereoscopic3dButton:disable()
		end
	end
	if not CoD.isWIIU then
		f12_local0.drawCrosshairButton = f12_local2:addProfileLeftRightSelector(f12_arg0, Engine.Localize("MENU_DRAW_CROSSHAIR"), "cg_drawCrosshair3D", Engine.Localize("MENU_DRAW_CROSSHAIR_DESC"))
		CoD.Options.Button_AddChoices_EnabledOrDisabled(f12_local0.drawCrosshairButton)
		table.insert(f12_local0.graphicsListButtons, f12_local0.drawCrosshairButton)
	end
	if not CoD.isWIIU and CoD.isSinglePlayer == false and UIExpression.IsInGame() == 0 then
		f12_local0.dualViewButton = f12_local2:addButton(Engine.Localize("MENU_DUAL_VIEW_SETTINGS_CAPS"), Engine.Localize("MENU_DUAL_VIEW_SETTINGS_DESC"))
		f12_local0.dualViewButton:registerEventHandler("button_action", CoD.GraphicsSettings.Button_DualView)
		table.insert(f12_local0.graphicsListButtons, f12_local0.dualViewButton)
		if true == Dvar.r_stereo3DOn:get() or true == Dvar.r_anaglyphFX_enable:get() then
			f12_local0.dualViewButton:disable()
		end
	end
	if CoD.useController and not f12_local0:restoreState() then
		f12_local0.graphicsListButtons[1]:processEvent({
			name = "gain_focus"
		})
	end
	f12_local0.buttonList = f12_local2
	return f12_local0
end

