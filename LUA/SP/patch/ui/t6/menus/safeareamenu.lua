CoD.SafeArea = {}
CoD.SafeArea.Maximum = 1.01
CoD.SafeArea.Minimum = 0.85
CoD.SafeArea.AdjustAmount = 0
CoD.SafeArea.ArrowMaterial = RegisterMaterial("menu_safearea_arrow")
CoD.SafeArea.AdjustSFX = "cac_safearea"
CoD.SafeArea.HandleGamepadButton = function (SafeAreaMenu, ClientInstance)
	if LUI.UIElement.handleGamepadButton(SafeAreaMenu, ClientInstance) == true then
		return true
	elseif ClientInstance.down == true then
		if ClientInstance.button == "primary" then
			SafeAreaMenu:dispatchEventToRoot({
				name = "accept_button",
				controller = ClientInstance.controller
			})
		end
		if ClientInstance.button == "secondary" then
			SafeAreaMenu:dispatchEventToRoot({
				name = "safearea_back_button",
				controller = ClientInstance.controller
			})
			return true
		end
	end
end

CoD.SafeArea.SafeArea_Move = function (SafeAreaMenu, ClientInstance)
	local safeAreaTweakable_vertical = tonumber(UIExpression.ProfileValueAsString(ClientInstance.controller, "safeAreaTweakable_vertical"))
	local safeAreaTweakable_horizontal = tonumber(UIExpression.ProfileValueAsString(ClientInstance.controller, "safeAreaTweakable_horizontal"))
	Engine.PlaySound(CoD.SafeArea.AdjustSFX)
	if ClientInstance.name == "safearea_move_up" then
		local NewSafeAreaValue = safeAreaTweakable_vertical + CoD.SafeArea.AdjustAmount
		if NewSafeAreaValue > CoD.SafeArea.Maximum then
			Engine.PlaySound(CoD.CACUtility.denySFX)
		else
			Engine.SetProfileVar(ClientInstance.controller, "safeAreaTweakable_vertical", NewSafeAreaValue)
		end
	elseif ClientInstance.name == "safearea_move_down" then
		local NewSafeAreaValue = safeAreaTweakable_vertical - CoD.SafeArea.AdjustAmount
		if NewSafeAreaValue < CoD.SafeArea.Minimum then
			Engine.PlaySound(CoD.CACUtility.denySFX)
		else
			Engine.SetProfileVar(ClientInstance.controller, "safeAreaTweakable_vertical", NewSafeAreaValue)
		end
	elseif ClientInstance.name == "safearea_move_left" then
		local NewSafeAreaValue = safeAreaTweakable_horizontal - CoD.SafeArea.AdjustAmount
		if NewSafeAreaValue < CoD.SafeArea.Minimum then
			Engine.PlaySound(CoD.CACUtility.denySFX)
		else
			Engine.SetProfileVar(ClientInstance.controller, "safeAreaTweakable_horizontal", NewSafeAreaValue)
		end
	elseif ClientInstance.name == "safearea_move_right" then
		local NewSafeAreaValue = safeAreaTweakable_horizontal + CoD.SafeArea.AdjustAmount
		if NewSafeAreaValue > CoD.SafeArea.Maximum then
			Engine.PlaySound(CoD.CACUtility.denySFX)
		else
			Engine.SetProfileVar(ClientInstance.controller, "safeAreaTweakable_horizontal", NewSafeAreaValue)
		end
	end
	SafeAreaMenu:dispatchEventToRoot({
		name = "update_safe_area",
		controller = ClientInstance.controller
	})
end

CoD.SafeArea.UpdateSafeArea = function (SafeAreaMenu, ClientInstance)
	Engine.ExecNow(ClientInstance.controller, "setupviewport")
	local LeftRight, TopBottom = Engine.GetUserSafeArea()
	SafeAreaMenu.backgroundContainer:setLeftRight(false, false, -LeftRight / 2, LeftRight / 2)
	SafeAreaMenu.backgroundContainer:setTopBottom(false, false, -TopBottom / 2, TopBottom / 2)
end

CoD.SafeArea.BackButton = function (SafeAreaMenu, ClientInstance)
	SafeAreaMenu:processEvent({
		name = "button_prompt_back",
		controller = ClientInstance.controller
	})
end

CoD.SafeArea.CloseFirstTime = function (SafeAreaMenu, ClientInstance)
	if not CoD.Options.SupportsMatureContent() then
		Engine.ExecNow(ClientInstance.controller, "setprofile com_first_time 0")
		Engine.ExecNow(ClientInstance.controller, "updategamerprofile")
		SafeAreaMenu:dispatchEventToParent({
			name = "open_main_menu",
			controller = ClientInstance.controller
		})
		CoD.perController[ClientInstance.controller].firstTime = nil
	else
		SafeAreaMenu:openMenu("MatureContentPopup", ClientInstance.controller)
	end
	SafeAreaMenu:close()
end

CoD.SafeArea.LeftMouseDown = function (SafeAreaMenu, ClientInstance)
	SafeAreaMenu.m_curX = ClientInstance.x
	SafeAreaMenu.m_curY = ClientInstance.y
end

CoD.SafeArea.MouseDrag = function (SafeAreaMenu, ClientInstance)
	if SafeAreaMenu.m_curX == nil or SafeAreaMenu.m_curY == nil then
		return 
	end
	local f7_local0 = 10
	if f7_local0 < math.abs(SafeAreaMenu.m_curX - ClientInstance.x) then
		if SafeAreaMenu.m_curX < ClientInstance.x then
			SafeAreaMenu:processEvent({
				name = "safearea_move_right"
			})
		else
			SafeAreaMenu:processEvent({
				name = "safearea_move_left"
			})
		end
		SafeAreaMenu.m_curX = ClientInstance.x
	end
	if f7_local0 < math.abs(SafeAreaMenu.m_curY - ClientInstance.y) then
		if SafeAreaMenu.m_curY < ClientInstance.y then
			SafeAreaMenu:processEvent({
				name = "safearea_move_down"
			})
		else
			SafeAreaMenu:processEvent({
				name = "safearea_move_up"
			})
		end
		SafeAreaMenu.m_curY = ClientInstance.y
	end
end

LUI.createMenu.SafeArea = function (LocalClientIndex)
	local SafeAreaMenu = nil
	if UIExpression.IsInGame() == 1 then
		SafeAreaMenu = CoD.InGameMenu.New("SafeArea", LocalClientIndex, Engine.Localize("MENU_SAFE_AREA_ADJUSTMENT_CAPS"), CoD.isSinglePlayer)
		if CoD.isSinglePlayer == false then
			if UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
				SafeAreaMenu:sizeToSafeArea(LocalClientIndex)
			end
			SafeAreaMenu:updateTitleForSplitscreen()
			SafeAreaMenu:updateButtonPromptBarsForSplitscreen()
		end
	else
		SafeAreaMenu = CoD.Menu.New("SafeArea")
		SafeAreaMenu:addTitle(Engine.Localize("MENU_SAFE_AREA_ADJUSTMENT_CAPS"))
		SafeAreaMenu:setOwner(LocalClientIndex)
		SafeAreaMenu:registerEventHandler("signed_out", CoD.Options.SignedOut_MPZM)
	end
	SafeAreaMenu.controller = LocalClientIndex
	SafeAreaMenu.close = CoD.Options.Close
	SafeAreaMenu:registerEventHandler("update_safe_area", CoD.SafeArea.UpdateSafeArea)
	Engine.ExecNow(LocalClientIndex, "setupviewport")
	local LeftRight, TopBottom = Engine.GetUserSafeArea()
	SafeAreaMenu.backgroundContainer = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -LeftRight / 2,
		right = LeftRight / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = -TopBottom / 2,
		bottom = TopBottom / 2
	})
	SafeAreaMenu:addElement(SafeAreaMenu.backgroundContainer)
	SafeAreaMenu.backgroundImage = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		red = 0.3,
		green = 0.3,
		blue = 0.3,
		alpha = 0.5
	})
	SafeAreaMenu.backgroundContainer:addElement(SafeAreaMenu.backgroundImage)
	SafeAreaMenu.instructions = LUI.UIText.new()
	SafeAreaMenu.instructions:setLeftRight(true, true, 0, 0)
	SafeAreaMenu.instructions:setTopBottom(false, false, -100, -100 + CoD.textSize.Default)
	SafeAreaMenu.instructions:setFont(CoD.fonts.Default)
	SafeAreaMenu.instructions:setText(Engine.Localize("PLATFORM_SAFEAREA_INSTRUCTIONS"))
	SafeAreaMenu:addElement(SafeAreaMenu.instructions)
	local f8_local3 = 64
	SafeAreaMenu.backgroundContainer:addElement(LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f8_local3,
		topAnchor = false,
		bottomAnchor = false,
		top = -(f8_local3 / 2),
		bottom = f8_local3 / 2,
		material = CoD.SafeArea.ArrowMaterial,
		zRot = 0
	}))
	SafeAreaMenu.backgroundContainer:addElement(LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -(f8_local3 / 2),
		right = f8_local3 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = f8_local3,
		material = CoD.SafeArea.ArrowMaterial,
		zRot = 270
	}))
	SafeAreaMenu.backgroundContainer:addElement(LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = true,
		left = -f8_local3,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -(f8_local3 / 2),
		bottom = f8_local3 / 2,
		material = CoD.SafeArea.ArrowMaterial,
		zRot = 180
	}))
	SafeAreaMenu.backgroundContainer:addElement(LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -(f8_local3 / 2),
		right = f8_local3 / 2,
		topAnchor = false,
		bottomAnchor = true,
		top = -f8_local3,
		bottom = 0,
		material = CoD.SafeArea.ArrowMaterial,
		zRot = 90
	}))
	local f8_local4 = -CoD.textSize.Default
	local SafeAreaAdjustHorizontalText = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -LeftRight / 2,
		right = LeftRight / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = f8_local4,
		bottom = f8_local4 + CoD.textSize.Default,
		font = CoD.fonts.Default
	})
	SafeAreaAdjustHorizontalText:setText(Engine.Localize("PLATFORM_SAFE_AREA_ADJUST_HORIZONTAL"))
	SafeAreaMenu:addElement(SafeAreaAdjustHorizontalText)
	f8_local4 = f8_local4 + CoD.textSize.Default
	local SafeAreaAdjustVerticalText = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -LeftRight / 2,
		right = LeftRight / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = f8_local4,
		bottom = f8_local4 + CoD.textSize.Default,
		font = CoD.fonts.Default
	})
	SafeAreaAdjustVerticalText:setText(Engine.Localize("PLATFORM_SAFE_AREA_ADJUST_VERTICAL"))
	SafeAreaMenu:addElement(SafeAreaAdjustVerticalText)
	SafeAreaMenu.button = LUI.UIButton.new({
		leftAnchor = false,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = 0,
		bottom = 0,
		alpha = 0
	})
	SafeAreaMenu.button.handleGamepadButton = CoD.SafeArea.HandleGamepadButton
	SafeAreaMenu:addElement(SafeAreaMenu.button)
	SafeAreaMenu.button:processEvent({
		name = "gain_focus"
	})
	SafeAreaMenu.buttonRepeaterUp = LUI.UIButtonRepeater.new("up", "safearea_move_up")
	SafeAreaMenu:addElement(SafeAreaMenu.buttonRepeaterUp)
	SafeAreaMenu.buttonRepeaterDown = LUI.UIButtonRepeater.new("down", "safearea_move_down")
	SafeAreaMenu:addElement(SafeAreaMenu.buttonRepeaterDown)
	SafeAreaMenu.buttonRepeaterLeft = LUI.UIButtonRepeater.new("left", "safearea_move_left")
	SafeAreaMenu:addElement(SafeAreaMenu.buttonRepeaterLeft)
	SafeAreaMenu.buttonRepeaterRight = LUI.UIButtonRepeater.new("right", "safearea_move_right")
	SafeAreaMenu:addElement(SafeAreaMenu.buttonRepeaterRight)
	SafeAreaMenu:registerEventHandler("safearea_move_up", CoD.SafeArea.SafeArea_Move)
	SafeAreaMenu:registerEventHandler("safearea_move_down", CoD.SafeArea.SafeArea_Move)
	SafeAreaMenu:registerEventHandler("safearea_move_left", CoD.SafeArea.SafeArea_Move)
	SafeAreaMenu:registerEventHandler("safearea_move_right", CoD.SafeArea.SafeArea_Move)
	if CoD.perController[LocalClientIndex].firstTime then
		SafeAreaMenu.acceptButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_ACCEPT"), SafeAreaMenu, "accept_button")
		SafeAreaMenu:addLeftButtonPrompt(SafeAreaMenu.acceptButton)
		SafeAreaMenu:registerEventHandler("accept_button", CoD.SafeArea.CloseFirstTime)
	else
		SafeAreaMenu.backButton = CoD.ButtonPrompt.new("secondary", Engine.Localize("MENU_BACK"), SafeAreaMenu, "safearea_back_button")
		SafeAreaMenu:addLeftButtonPrompt(SafeAreaMenu.backButton)
		SafeAreaMenu:registerEventHandler("safearea_back_button", CoD.SafeArea.BackButton)
	end
	if CoD.useMouse then
		SafeAreaMenu:setHandleMouse(true)
		SafeAreaMenu:registerEventHandler("leftmousedown", CoD.SafeArea.LeftMouseDown)
		SafeAreaMenu:registerEventHandler("mousedrag", CoD.SafeArea.MouseDrag)
		SafeAreaMenu:setLeftRight(true, true, 0, 0)
		SafeAreaMenu:setTopBottom(true, true, 0, 0)
		if SafeAreaMenu.titleElement then
			SafeAreaMenu.titleElement:close()
			local SafeAreaAdjustmentText = LUI.UIText.new()
			SafeAreaAdjustmentText:setLeftRight(true, true, 0, 0)
			SafeAreaAdjustmentText:setTopBottom(false, false, -150, -150 + CoD.textSize.Condensed)
			SafeAreaAdjustmentText:setFont(CoD.fonts.Condensed)
			SafeAreaAdjustmentText:setText(Engine.Localize("MENU_SAFE_AREA_ADJUSTMENT_CAPS"))
			SafeAreaMenu:addElement(SafeAreaAdjustmentText)
		end
		if SafeAreaMenu.leftButtonPromptBar then
			SafeAreaMenu.leftButtonPromptBar:close()
			SafeAreaMenu.leftButtonPromptBar:setLeftRight(false, false, -SafeAreaMenu.width / 2, SafeAreaMenu.width / 2)
			SafeAreaMenu.leftButtonPromptBar:setTopBottom(false, false, SafeAreaMenu.height / 2 - CoD.ButtonPrompt.Height, SafeAreaMenu.height / 2)
			SafeAreaMenu:addElement(SafeAreaMenu.leftButtonPromptBar)
		end
		if SafeAreaMenu.rightButtonPromptBar then
			SafeAreaMenu.rightButtonPromptBar:close()
			SafeAreaMenu.rightButtonPromptBar:setLeftRight(false, false, -SafeAreaMenu.width / 2, SafeAreaMenu.width / 2)
			SafeAreaMenu.rightButtonPromptBar:setTopBottom(false, false, SafeAreaMenu.height / 2 - CoD.ButtonPrompt.Height, SafeAreaMenu.height / 2)
			SafeAreaMenu:addElement(SafeAreaMenu.rightButtonPromptBar)
		end
	end
	Engine.PlaySound("cac_grid_nav")
	return SafeAreaMenu
end

