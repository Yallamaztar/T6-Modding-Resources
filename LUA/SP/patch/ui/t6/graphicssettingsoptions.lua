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

LUI.createMenu.GraphicsSettings = function (f11_arg0, f11_arg1)
	local f11_local0 = nil
	if UIExpression.IsInGame() == 1 then
		f11_local0 = CoD.InGameMenu.New("GraphicsSettings", f11_arg0, Engine.Localize("MENU_GRAPHICS_SETTINGS_CAPS"), CoD.isSinglePlayer)
		if CoD.isSinglePlayer == false and UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
			f11_local0:sizeToSafeArea(f11_arg0)
			f11_local0:updateTitleForSplitscreen()
			f11_local0:updateButtonPromptBarsForSplitscreen()
		end
	else
		f11_local0 = CoD.Menu.New("GraphicsSettings")
		f11_local0:setOwner(f11_arg0)
		f11_local0:addTitle(Engine.Localize("MENU_GRAPHICS_SETTINGS_CAPS"))
		if CoD.isSinglePlayer == false then
			f11_local0:addLargePopupBackground()
			f11_local0:registerEventHandler("signed_out", CoD.Options.SignedOut_MPZM)
		end
	end
	f11_local0:setPreviousMenu("OptionsMenu")
	f11_local0.controller = f11_arg0
	f11_local0:setOwner(f11_arg0)
	f11_local0:registerEventHandler("open_safe_area", CoD.GraphicsSettings.OpenSafeArea)
	f11_local0:registerEventHandler("open_brightness", CoD.GraphicsSettings.OpenBrightness)
	f11_local0:registerEventHandler("open_3d", CoD.GraphicsSettings.Open3D)
	f11_local0:registerEventHandler("open_dual_view", CoD.GraphicsSettings.OpenDualView)
	f11_local0:registerEventHandler("update_buttonlist", CoD.GraphicsSettings.UpdateButtonList)
	if CoD.isSinglePlayer == true and CoD.perController[f11_arg0].firstTime then
		f11_local0.acceptButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_ACCEPT"), f11_local0, "accept_button")
		f11_local0:addLeftButtonPrompt(f11_local0.acceptButton)
		f11_local0:registerEventHandler("accept_button", CoD.GraphicsSettings.CloseFirstTime)
		f11_local0:registerEventHandler("remove_accept_button", CoD.GraphicsSettings.RemoveAcceptButton)
		f11_local0:registerEventHandler("readd_accept_button", CoD.GraphicsSettings.ReaddAcceptButton)
		CoD.GraphicsSettings.ListHeight = 421.25
	else
		f11_local0:addSelectButton()
		f11_local0:addBackButton()
	end
	f11_local0.close = CoD.Options.Close
	f11_local0.graphicsListButtons = {}
	local f11_local1 = 0
	if UIExpression.IsInGame() == 1 and CoD.isSinglePlayer == false and Engine.IsSplitscreen() == true then
		f11_local1 = CoD.Menu.SplitscreenSideOffset
	end
	local f11_local2 = CoD.ButtonList.new()
	f11_local2:setLeftRight(true, false, f11_local1, f11_local1 + CoD.Options.Width)
	f11_local2:setTopBottom(true, false, CoD.Menu.TitleHeight, CoD.Menu.TitleHeight + 720)
	if CoD.isSinglePlayer then
		f11_local0:addElement(f11_local2)
		if f11_arg1 and f11_arg1.height ~= nil then
			f11_local2:setLeftRight(false, false, -CoD.Options.Width / 2, CoD.Options.Width / 2)
			f11_local2:setTopBottom(false, false, -f11_arg1.height / 2, f11_arg1.height / 2)
			CoD.GraphicsSettings.ListHeight = f11_arg1.height
		elseif CoD.GraphicsSettings.ListHeight then
			f11_local2:setLeftRight(false, false, -CoD.Options.Width / 2, CoD.Options.Width / 2)
			f11_local2:setTopBottom(false, false, -CoD.GraphicsSettings.ListHeight / 2, CoD.GraphicsSettings.ListHeight / 2)
		end
	else
		local f11_local3 = CoD.SplitscreenScaler.new(nil, 1.5)
		f11_local3:setLeftRight(true, false, 0, 0)
		f11_local3:setTopBottom(true, false, 0, 0)
		f11_local0:addElement(f11_local3)
		f11_local3:addElement(f11_local2)
	end
	if UIExpression.SplitscreenNum() == 1 or UIExpression.IsPrimaryLocalClient(f11_arg0) == 1 and UIExpression.IsInGame() == 0 then
		f11_local0.safeAreaButton = f11_local2:addButton(Engine.Localize("MENU_SAFE_AREA_CAPS"), Engine.Localize("MENU_SAFE_AREA_DESC"))
		f11_local0.safeAreaButton:registerEventHandler("button_action", CoD.GraphicsSettings.Button_SafeArea)
		table.insert(f11_local0.graphicsListButtons, f11_local0.safeAreaButton)
	end
	if UIExpression.SplitscreenNum() == 1 or UIExpression.IsPrimaryLocalClient(f11_arg0) == 1 then
		f11_local0.brightnessButton = f11_local2:addButton(Engine.Localize("MENU_BRIGHTNESS_CAPS"), Engine.Localize("MENU_BRIGHTNESS_DESC"))
		f11_local0.brightnessButton:registerEventHandler("button_action", CoD.GraphicsSettings.Button_Brightness)
		table.insert(f11_local0.graphicsListButtons, f11_local0.brightnessButton)
	end
	if not CoD.isWIIU then
		f11_local0.anaglyphButton = f11_local2:addDvarLeftRightSelector(f11_arg0, Engine.Localize("MENU_ANAGLYPH_3D_CAPS"), "r_anaglyphFX_enable", Engine.Localize("MENU_ANAGLYPH_3D_DESC"))
		f11_local0.anaglyphButton:addChoice(f11_arg0, Engine.Localize("MENU_DISABLED_CAPS"), 0, nil, CoD.GraphicsSettings.AnaglyphSelectionChangedCallback)
		f11_local0.anaglyphButton:addChoice(f11_arg0, Engine.Localize("MENU_ENABLED_CAPS"), 1, nil, CoD.GraphicsSettings.AnaglyphSelectionChangedCallback)
		table.insert(f11_local0.graphicsListButtons, f11_local0.anaglyphButton)
		if true == Dvar.r_stereo3DOn:get() or true == Dvar.r_dualPlayEnable:get() then
			f11_local0.anaglyphButton:disable()
		end
	end
	if not Engine.IsBetaBuild() and not CoD.isWIIU and UIExpression.IsInGame() == 0 then
		f11_local0.stereoscopic3dButton = f11_local2:addButton(Engine.Localize("MENU_STEREO_3D_SETTINGS_CAPS"), Engine.Localize("MENU_STEREO_3D_SETTINGS_DESC"))
		table.insert(f11_local0.graphicsListButtons, f11_local0.stereoscopic3dButton)
		f11_local0.stereoscopic3dButton:registerEventHandler("button_action", CoD.GraphicsSettings.Button_Stereoscopic3D)
		if false == Dvar.r_stereo3DAvailable:get() or true == Dvar.r_dualPlayEnable:get() or true == Dvar.r_anaglyphFX_enable:get() then
			f11_local0.stereoscopic3dButton:disable()
		end
	end
	if not CoD.isWIIU then
		f11_local0.drawCrosshairButton = f11_local2:addProfileLeftRightSelector(f11_arg0, Engine.Localize("MENU_DRAW_CROSSHAIR"), "cg_drawCrosshair3D", Engine.Localize("MENU_DRAW_CROSSHAIR_DESC"))
		CoD.Options.Button_AddChoices_EnabledOrDisabled(f11_local0.drawCrosshairButton)
		table.insert(f11_local0.graphicsListButtons, f11_local0.drawCrosshairButton)
	end
	if not CoD.isWIIU and CoD.isSinglePlayer == false and UIExpression.IsInGame() == 0 then
		f11_local0.dualViewButton = f11_local2:addButton(Engine.Localize("MENU_DUAL_VIEW_SETTINGS_CAPS"), Engine.Localize("MENU_DUAL_VIEW_SETTINGS_DESC"))
		f11_local0.dualViewButton:registerEventHandler("button_action", CoD.GraphicsSettings.Button_DualView)
		table.insert(f11_local0.graphicsListButtons, f11_local0.dualViewButton)
		if true == Dvar.r_stereo3DOn:get() or true == Dvar.r_anaglyphFX_enable:get() then
			f11_local0.dualViewButton:disable()
		end
	end
	if CoD.useController and not f11_local0:restoreState() then
		f11_local0.graphicsListButtons[1]:processEvent({
			name = "gain_focus"
		})
	end
	f11_local0.buttonList = f11_local2
	return f11_local0
end

