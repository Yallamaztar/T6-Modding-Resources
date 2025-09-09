require("T6.Options")
CoD.GraphicsSettings = {}
CoD.GraphicsSettings.Button_SafeArea = function (safeAreaButton, ClientInstance)
	safeAreaButton:dispatchEventToParent({
		name = "open_safe_area",
		controller = ClientInstance.controller
	})
end

CoD.GraphicsSettings.OpenSafeArea = function (GraphicsSettingsWidget, ClientInstance)
	GraphicsSettingsWidget:saveState()
	GraphicsSettingsWidget:openMenu("SafeArea", ClientInstance.controller)
	GraphicsSettingsWidget:close()
end

CoD.GraphicsSettings.Button_Brightness = function (brightnessButton, ClientInstance)
	brightnessButton:dispatchEventToParent({
		name = "open_brightness",
		controller = ClientInstance.controller
	})
end

CoD.GraphicsSettings.OpenBrightness = function (GraphicsSettingsWidget, ClientInstance)
	GraphicsSettingsWidget:saveState()
	local ListHeight = {}
	if GraphicsSettingsWidget.buttonList ~= nil then
		ListHeight.height = CoD.GraphicsSettings.ListHeight
	end
	GraphicsSettingsWidget:openMenu("Brightness", ClientInstance.controller, ListHeight)
	GraphicsSettingsWidget:close()
end

CoD.GraphicsSettings.Open3D = function (GraphicsSettingsWidget, ClientInstance)
	GraphicsSettingsWidget:saveState()
	GraphicsSettingsWidget:openMenu("Stereoscopic3D", ClientInstance.controller)
	GraphicsSettingsWidget:close()
end

CoD.GraphicsSettings.Button_Stereoscopic3D = function (stereoscopic3dButton, ClientInstance)
	stereoscopic3dButton:dispatchEventToParent({
		name = "open_3d",
		controller = ClientInstance.controller
	})
end

CoD.GraphicsSettings.OpenDualView = function (GraphicsSettingsWidget, ClientInstance)
	GraphicsSettingsWidget:saveState()
	GraphicsSettingsWidget:openMenu("DualViewMenu", ClientInstance.controller)
	GraphicsSettingsWidget:close()
end

CoD.GraphicsSettings.Button_DualView = function (dualViewButton, ClientInstance)
	dualViewButton:dispatchEventToParent({
		name = "open_dual_view",
		controller = ClientInstance.controller
	})
end

CoD.GraphicsSettings.AnaglyphSelectionChangedCallback = function (anaglyphButton)
	Engine.SetDvar(anaglyphButton.parentSelectorButton.m_dvarName, anaglyphButton.value)
	anaglyphButton.parentSelectorButton:dispatchEventToParent({
		name = "update_buttonlist"
	})
end

CoD.GraphicsSettings.UpdateButtonList = function (GraphicsSettingsWidget, ClientInstance)
	if GraphicsSettingsWidget.stereoscopic3dButton then
		if Dvar.r_stereo3DAvailable:get() == false or Dvar.r_dualPlayEnable:get() == true or Dvar.r_anaglyphFX_enable:get() == true then
			GraphicsSettingsWidget.stereoscopic3dButton:disable()
		else
			GraphicsSettingsWidget.stereoscopic3dButton:enable()
		end
	end
	if GraphicsSettingsWidget.dualViewButton then
		if Dvar.r_stereo3DOn:get() == true or Dvar.r_anaglyphFX_enable:get() == true then
			GraphicsSettingsWidget.dualViewButton:disable()
		else
			GraphicsSettingsWidget.dualViewButton:enable()
		end
	end
end

CoD.GraphicsSettings.AddBackButtonTimer = function (GraphicsSettingsWidget, ClientInstance)
	GraphicsSettingsWidget:addBackButton()
	GraphicsSettingsWidget.backButtonTimer:close()
	GraphicsSettingsWidget.backButtonTimer = nil
end

LUI.createMenu.GraphicsSettings = function (LocalClientIndex, ListHeightOverride)
	local GraphicsSettingsWidget = nil
	if UIExpression.IsInGame() == 1 then
		GraphicsSettingsWidget = CoD.InGameMenu.New("GraphicsSettings", LocalClientIndex, Engine.Localize("MENU_GRAPHICS_SETTINGS_CAPS"), CoD.isSinglePlayer)
		if CoD.isSinglePlayer == false and UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
			GraphicsSettingsWidget:sizeToSafeArea(LocalClientIndex)
			GraphicsSettingsWidget:updateTitleForSplitscreen()
			GraphicsSettingsWidget:updateButtonPromptBarsForSplitscreen()
		end
	else
		GraphicsSettingsWidget = CoD.Menu.New("GraphicsSettings")
		GraphicsSettingsWidget:setOwner(LocalClientIndex)
		GraphicsSettingsWidget:addTitle(Engine.Localize("MENU_GRAPHICS_SETTINGS_CAPS"))
		if CoD.isSinglePlayer == false then
			GraphicsSettingsWidget:addLargePopupBackground()
			GraphicsSettingsWidget:registerEventHandler("signed_out", CoD.Menu.SignedOut)
		end
	end
	GraphicsSettingsWidget:setPreviousMenu("OptionsMenu")
	GraphicsSettingsWidget.controller = LocalClientIndex
	GraphicsSettingsWidget:setOwner(LocalClientIndex)
	GraphicsSettingsWidget:registerEventHandler("open_safe_area", CoD.GraphicsSettings.OpenSafeArea)
	GraphicsSettingsWidget:registerEventHandler("open_brightness", CoD.GraphicsSettings.OpenBrightness)
	GraphicsSettingsWidget:registerEventHandler("open_3d", CoD.GraphicsSettings.Open3D)
	GraphicsSettingsWidget:registerEventHandler("open_dual_view", CoD.GraphicsSettings.OpenDualView)
	GraphicsSettingsWidget:registerEventHandler("update_buttonlist", CoD.GraphicsSettings.UpdateButtonList)
	if CoD.isSinglePlayer == true and CoD.perController[LocalClientIndex].firstTime then
		GraphicsSettingsWidget.acceptButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_ACCEPT"), GraphicsSettingsWidget, "accept_button")
		GraphicsSettingsWidget:addLeftButtonPrompt(GraphicsSettingsWidget.acceptButton)
		GraphicsSettingsWidget:registerEventHandler("accept_button", CoD.GraphicsSettings.CloseFirstTime)
		GraphicsSettingsWidget:registerEventHandler("remove_accept_button", CoD.GraphicsSettings.RemoveAcceptButton)
		GraphicsSettingsWidget:registerEventHandler("readd_accept_button", CoD.GraphicsSettings.ReaddAcceptButton)
		CoD.GraphicsSettings.ListHeight = 421.25
	else
		GraphicsSettingsWidget:addSelectButton()
		GraphicsSettingsWidget:registerEventHandler("add_back_button", CoD.GraphicsSettings.AddBackButtonTimer)
		GraphicsSettingsWidget.backButtonTimer = LUI.UITimer.new(350, {
			name = "add_back_button",
			controller = LocalClientIndex
		})
		GraphicsSettingsWidget:addElement(GraphicsSettingsWidget.backButtonTimer)
	end
	GraphicsSettingsWidget.close = CoD.Options.Close
	GraphicsSettingsWidget.graphicsListButtons = {}
	local SplitscreenHorizontalOffset = 0
	if UIExpression.IsInGame() == 1 and CoD.isSinglePlayer == false and Engine.IsSplitscreen() == true then
		SplitscreenHorizontalOffset = CoD.Menu.SplitscreenSideOffset
	end
	local GraphicsSettingsButtonList = CoD.ButtonList.new()
	GraphicsSettingsButtonList:setLeftRight(true, false, SplitscreenHorizontalOffset, SplitscreenHorizontalOffset + CoD.Options.Width)
	GraphicsSettingsButtonList:setTopBottom(true, false, CoD.Menu.TitleHeight, CoD.Menu.TitleHeight + 720)
	if CoD.isSinglePlayer then
		GraphicsSettingsWidget:addElement(GraphicsSettingsButtonList)
		if ListHeightOverride and ListHeightOverride.height ~= nil then
			GraphicsSettingsButtonList:setLeftRight(false, false, -CoD.Options.Width / 2, CoD.Options.Width / 2)
			GraphicsSettingsButtonList:setTopBottom(false, false, -ListHeightOverride.height / 2, ListHeightOverride.height / 2)
			CoD.GraphicsSettings.ListHeight = ListHeightOverride.height
		elseif CoD.GraphicsSettings.ListHeight then
			GraphicsSettingsButtonList:setLeftRight(false, false, -CoD.Options.Width / 2, CoD.Options.Width / 2)
			GraphicsSettingsButtonList:setTopBottom(false, false, -CoD.GraphicsSettings.ListHeight / 2, CoD.GraphicsSettings.ListHeight / 2)
		end
	else
		local SplitscreenScaler = CoD.SplitscreenScaler.new(nil, 1.5)
		SplitscreenScaler:setLeftRight(true, false, 0, 0)
		SplitscreenScaler:setTopBottom(true, false, 0, 0)
		GraphicsSettingsWidget:addElement(SplitscreenScaler)
		SplitscreenScaler:addElement(GraphicsSettingsButtonList)
	end
	if UIExpression.SplitscreenNum() == 1 or UIExpression.IsPrimaryLocalClient(LocalClientIndex) == 1 and UIExpression.IsInGame() == 0 then
		GraphicsSettingsWidget.safeAreaButton = GraphicsSettingsButtonList:addButton(Engine.Localize("MENU_SAFE_AREA_CAPS"), Engine.Localize("MENU_SAFE_AREA_DESC"))
		GraphicsSettingsWidget.safeAreaButton:registerEventHandler("button_action", CoD.GraphicsSettings.Button_SafeArea)
		table.insert(GraphicsSettingsWidget.graphicsListButtons, GraphicsSettingsWidget.safeAreaButton)
	end
	if UIExpression.SplitscreenNum() == 1 or UIExpression.IsPrimaryLocalClient(LocalClientIndex) == 1 then
		GraphicsSettingsWidget.brightnessButton = GraphicsSettingsButtonList:addButton(Engine.Localize("MENU_BRIGHTNESS_CAPS"), Engine.Localize("MENU_BRIGHTNESS_DESC"))
		GraphicsSettingsWidget.brightnessButton:registerEventHandler("button_action", CoD.GraphicsSettings.Button_Brightness)
		table.insert(GraphicsSettingsWidget.graphicsListButtons, GraphicsSettingsWidget.brightnessButton)
	end
	if not CoD.isWIIU then
		GraphicsSettingsWidget.anaglyphButton = GraphicsSettingsButtonList:addDvarLeftRightSelector(LocalClientIndex, Engine.Localize("MENU_ANAGLYPH_3D_CAPS"), "r_anaglyphFX_enable", Engine.Localize("MENU_ANAGLYPH_3D_DESC"))
		GraphicsSettingsWidget.anaglyphButton:addChoice(LocalClientIndex, Engine.Localize("MENU_DISABLED_CAPS"), 0, nil, CoD.GraphicsSettings.AnaglyphSelectionChangedCallback)
		GraphicsSettingsWidget.anaglyphButton:addChoice(LocalClientIndex, Engine.Localize("MENU_ENABLED_CAPS"), 1, nil, CoD.GraphicsSettings.AnaglyphSelectionChangedCallback)
		table.insert(GraphicsSettingsWidget.graphicsListButtons, GraphicsSettingsWidget.anaglyphButton)
		if true == Dvar.r_stereo3DOn:get() or true == Dvar.r_dualPlayEnable:get() then
			GraphicsSettingsWidget.anaglyphButton:disable()
		end
	end
	if not Engine.IsBetaBuild() and not CoD.isWIIU and UIExpression.IsInGame() == 0 then
		GraphicsSettingsWidget.stereoscopic3dButton = GraphicsSettingsButtonList:addButton(Engine.Localize("MENU_STEREO_3D_SETTINGS_CAPS"), Engine.Localize("MENU_STEREO_3D_SETTINGS_DESC"))
		table.insert(GraphicsSettingsWidget.graphicsListButtons, GraphicsSettingsWidget.stereoscopic3dButton)
		GraphicsSettingsWidget.stereoscopic3dButton:registerEventHandler("button_action", CoD.GraphicsSettings.Button_Stereoscopic3D)
		if Dvar.r_stereo3DAvailable:get() = false or Dvar.r_dualPlayEnable:get() = true or Dvar.r_anaglyphFX_enable:get() = true then
			GraphicsSettingsWidget.stereoscopic3dButton:disable()
		end
	end
	if not CoD.isWIIU then
		GraphicsSettingsWidget.drawCrosshairButton = GraphicsSettingsButtonList:addProfileLeftRightSelector(LocalClientIndex, Engine.Localize("MENU_DRAW_CROSSHAIR"), "cg_drawCrosshair3D", Engine.Localize("MENU_DRAW_CROSSHAIR_DESC"))
		CoD.Options.Button_AddChoices_EnabledOrDisabled(GraphicsSettingsWidget.drawCrosshairButton)
		table.insert(GraphicsSettingsWidget.graphicsListButtons, GraphicsSettingsWidget.drawCrosshairButton)
	end
	if not CoD.isWIIU and CoD.isSinglePlayer == false and UIExpression.IsInGame() == 0 then
		GraphicsSettingsWidget.dualViewButton = GraphicsSettingsButtonList:addButton(Engine.Localize("MENU_DUAL_VIEW_SETTINGS_CAPS"), Engine.Localize("MENU_DUAL_VIEW_SETTINGS_DESC"))
		GraphicsSettingsWidget.dualViewButton:registerEventHandler("button_action", CoD.GraphicsSettings.Button_DualView)
		table.insert(GraphicsSettingsWidget.graphicsListButtons, GraphicsSettingsWidget.dualViewButton)
		if Dvar.r_stereo3DOn:get() = true or Dvar.r_anaglyphFX_enable:get() = true then
			GraphicsSettingsWidget.dualViewButton:disable()
		end
	end
	if CoD.useController and not GraphicsSettingsWidget:restoreState() then
		GraphicsSettingsWidget.graphicsListButtons[1]:processEvent({
			name = "gain_focus"
		})
	end
	GraphicsSettingsWidget.buttonList = GraphicsSettingsButtonList
	return GraphicsSettingsWidget
end

