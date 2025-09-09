require("T6.CategoryButton")
CoD.ChangeGameMode = {}
CoD.ChangeGameMode.Categories = {
	"standard",
	"party",
	"saved"
}
CoD.ChangeGameMode.CategoryIconNames = {
	"playlist_standard",
	"playlist_party",
	"playlist_party"
}
LUI.createMenu.ChangeGameMode = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("ChangeGameMode")
	f1_local0:addTitle(Engine.Localize("MPUI_CHANGE_GAME_MODE_CAPS"))
	f1_local0:addLargePopupBackground()
	f1_local0.m_ownerController = f1_arg0
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	local f1_local1 = CoD.CoD9Button.Height
	local f1_local2 = (CoD.Menu.Width - f1_local1 * 2) / 3
	local f1_local3 = 0
	f1_local0.categoryContainer = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local3,
		right = f1_local3 + f1_local2,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.Menu.TitleHeight,
		bottom = 0,
		alpha = 1
	})
	f1_local0.categoryContainer:registerAnimationState("disabled", {
		alpha = 0.5
	})
	f1_local0:addElement(f1_local0.categoryContainer)
	f1_local0.categoryButtonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	f1_local0.categoryButtonList.id = f1_local0.categoryButtonList.id .. ".CategoryButtonList"
	f1_local0.categoryContainer:addElement(f1_local0.categoryButtonList)
	f1_local3 = f1_local3 + f1_local2 - f1_local1
	f1_local0.gamemodeContainer = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local3,
		right = f1_local3 + f1_local2,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.Menu.TitleHeight,
		bottom = 0
	})
	f1_local0:addElement(f1_local0.gamemodeContainer)
	f1_local0.gameModeButtonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	f1_local0.gameModeButtonList.id = f1_local0.gameModeButtonList.id .. ".gameModeButtonList"
	f1_local0.gamemodeContainer:addElement(f1_local0.gameModeButtonList)
	f1_local3 = f1_local3 + f1_local2
	if CoD.useMouse then
		f1_local0.gameModeButtonList:setHandleMouseButton(true)
		f1_local0.gameModeButtonList:registerEventHandler("leftmouseup_outside", CoD.MainMenu.FlyoutBack)
	end
	local f1_local4 = f1_local2 + f1_local1 * 2
	f1_local0.infoContainer = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local3,
		right = f1_local3 + f1_local4,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.Menu.TitleHeight,
		bottom = 0
	})
	f1_local0:addElement(f1_local0.infoContainer)
	local f1_local5 = f1_local4 - 100
	local f1_local6 = f1_local5
	local f1_local7 = 0
	f1_local0.infoContainer.icon = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f1_local5 / 2,
		right = f1_local5 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local7,
		bottom = f1_local7 + f1_local6,
		alpha = 0
	})
	f1_local0.infoContainer:addElement(f1_local0.infoContainer.icon)
	local f1_local8 = f1_local6 * 1.7
	f1_local0.infoContainer.infoWidth = f1_local8
	f1_local7 = f1_local7 + f1_local6 + 15
	f1_local0.infoContainer.titleElement = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f1_local8 / 2,
		right = f1_local8 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local7,
		bottom = f1_local7 + CoD.textSize.Big,
		font = CoD.fonts.Big,
		alignment = LUI.Alignment.Left
	})
	f1_local0.infoContainer.titleElement:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.infoContainer:addElement(f1_local0.infoContainer.titleElement)
	f1_local7 = f1_local7 + CoD.textSize.Big + 5
	f1_local0.infoContainer.description = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f1_local8 / 2,
		right = f1_local8 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local7,
		bottom = f1_local7 + CoD.textSize.Default,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Left
	})
	f1_local0.infoContainer.description:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.infoContainer:addElement(f1_local0.infoContainer.description)
	f1_local0:registerEventHandler("category_button_gain_focus", CoD.ChangeGameMode.Button_GainFocus)
	f1_local0:registerEventHandler("category_button_lose_focus", CoD.ChangeGameMode.Button_LoseFocus)
	f1_local0:registerEventHandler("category_button_action", CoD.ChangeGameMode.CategoryButtonAction)
	f1_local0:registerEventHandler("game_mode_button_gain_focus", CoD.ChangeGameMode.Button_GainFocus)
	f1_local0:registerEventHandler("game_mode_button_lose_focus", CoD.ChangeGameMode.Button_LoseFocus)
	f1_local0:registerEventHandler("game_mode_button_action", CoD.ChangeGameMode.GameModeSelected)
	f1_local0.updateInfo = CoD.ChangeGameMode.UpdateInfo
	f1_local0.addGameModeButtons = CoD.ChangeGameMode.AddGameModeButtons
	CoD.ChangeGameMode.AddCategoryButtons(f1_local0)
	return f1_local0
end

CoD.ChangeGameMode.GameModeSelected = function (f2_arg0, f2_arg1)
	Engine.PlaySound("cac_slide_equip_item")
	f2_arg0.gameModeButtonList:saveState()
	Engine.Exec(f2_arg1.controller, "resetCustomGametype")
	local f2_local0 = CoD.IsGametypeTeamBased()
	Engine.SetGametype(f2_arg1.itemInfo.gametype)
	if f2_local0 ~= CoD.IsGametypeTeamBased() then
		Engine.SetDvar("bot_friends", 0)
		Engine.SetDvar("bot_enemies", 0)
		Engine.SetDvar("bot_difficulty", 1)
	end
	Engine.Exec(f2_arg1.controller, "xupdatepartystate")
	Engine.SetProfileVar(f2_arg1.controller, CoD.profileKey_gametype, f2_arg1.itemInfo.gametype)
	Engine.PartyHostClearUIState()
	Engine.CommitProfileChanges(f2_arg0.m_ownerController)
	Engine.SystemNeedsUpdate(nil, "game_options")
	Engine.SystemNeedsUpdate(nil, "lobby")
	f2_arg0:goBack(f2_arg0.m_ownerController)
end

CoD.ChangeGameMode.CategoryBack = function (f3_arg0, f3_arg1)
	f3_arg0.categoryButtonList:saveState()
	Engine.PartyHostClearUIState()
	Engine.CommitProfileChanges(f3_arg0.m_ownerController)
	CoD.Menu.ButtonPromptBack(f3_arg0, f3_arg1)
end

CoD.ChangeGameMode.GameModeBack = function (f4_arg0, f4_arg1)
	f4_arg0.gameModeButtonList:saveState()
	f4_arg0:registerEventHandler("button_prompt_back", CoD.ChangeGameMode.CategoryBack)
	f4_arg0.gameModeButtonList:removeAllChildren()
	CoD.ButtonList.DisableInput(f4_arg0.gameModeButtonList)
	CoD.ButtonList.EnableInput(f4_arg0.categoryButtonList)
	f4_arg0.categoryContainer:animateToState("default")
	f4_arg0.categoryButtonList:restoreState()
	if CoD.useMouse then
		f4_arg0.gameModeButtonList.m_backReady = nil
	end
end

CoD.ChangeGameMode.Button_GainFocus = function (f5_arg0, f5_arg1)
	f5_arg0.infoContainer.owner = f5_arg1.owner
	f5_arg0:updateInfo(f5_arg1.itemInfo)
end

CoD.ChangeGameMode.Button_LoseFocus = function (f6_arg0, f6_arg1)
	if f6_arg0.infoContainer.owner == f6_arg1.owner then
		f6_arg0:updateInfo(nil)
	end
end

CoD.ChangeGameMode.UpdateInfo = function (f7_arg0, f7_arg1)
	local f7_local0 = ""
	local f7_local1 = ""
	local f7_local2 = nil
	if f7_arg1 ~= nil then
		f7_local0 = f7_arg1.name
		f7_local1 = f7_arg1.description
		f7_local2 = f7_arg1.iconMaterial
	end
	f7_arg0.infoContainer.titleElement:setText(f7_local0)
	f7_arg0.infoContainer.description:setText(f7_local1)
	if f7_local2 ~= nil then
		f7_arg0.infoContainer.icon:registerAnimationState("icon", {
			material = f7_local2,
			alpha = 1
		})
		f7_arg0.infoContainer.icon:animateToState("icon")
	else
		f7_arg0.infoContainer.icon:animateToState("default")
	end
end

CoD.ChangeGameMode.CreateCategoryItemInfo = function ()
	local f8_local0 = {}
	for f8_local5, f8_local6 in ipairs(CoD.ChangeGameMode.Categories) do
		if f8_local6 ~= "saved" or Engine.SessionModeIsMode(CoD.SESSIONMODE_ONLINE) then
			local f8_local4 = {}
			if f8_local6 == "custom" then
				f8_local4.locked = true
			else
				f8_local4.locked = false
			end
			f8_local4.ref = f8_local6
			f8_local4.name = Engine.Localize("MPUI_CATEGORY_" .. f8_local6 .. "_CAPS")
			f8_local4.description = Engine.Localize("MPUI_CATEGORY_" .. f8_local6 .. "_DESC")
			f8_local4.iconMaterial = RegisterMaterial(CoD.ChangeGameMode.CategoryIconNames[f8_local5])
			table.insert(f8_local0, f8_local4)
		end
	end
	return f8_local0
end

CoD.ChangeGameMode.AddCategoryButtons = function (f9_arg0)
	local f9_local0 = CoD.ChangeGameMode.CreateCategoryItemInfo()
	local f9_local1 = UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, UIExpression.DvarString(nil, "ui_gametype"), 9)
	local f9_local2 = 1
	f9_arg0.categoryButtons = {}
	for f9_local6, f9_local7 in ipairs(f9_local0) do
		local f9_local8 = CoD.CategoryButton.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = false,
			top = 0,
			bottom = CoD.CoD9Button.Height
		}, "category_button_action", "category_button_gain_focus", "category_button_lose_focus", f9_local7)
		f9_local8:setLabel(f9_local7.name)
		f9_arg0.categoryButtonList:addElement(f9_local8)
		table.insert(f9_arg0.categoryButtons, f9_local8)
		if f9_local7.locked == true then
			f9_local8:disable()
		end
		if f9_local7.ref == f9_local1 then
			f9_local2 = f9_local6
		end
	end
	if #f9_arg0.categoryButtons > 0 then
		if CoD.useController and not f9_arg0.categoryButtonList:restoreState() then
			f9_arg0.categoryButtons[f9_local2]:processEvent({
				name = "gain_focus"
			})
		end
		f9_arg0:registerEventHandler("button_prompt_back", CoD.ChangeGameMode.CategoryBack)
	end
end

CoD.ChangeGameMode.CategoryButtonAction = function (f10_arg0, f10_arg1)
	Engine.PlaySound("cac_slide_equip_item")
	f10_arg0.categoryButtonList:saveState()
	CoD.ButtonList.DisableInput(f10_arg0.categoryButtonList)
	CoD.ButtonList.EnableInput(f10_arg0.gameModeButtonList)
	f10_arg0.categoryContainer:animateToState("disabled")
	if f10_arg1.itemInfo.ref == "saved" then
		if UIExpression.IsGuest(f10_arg1.controller) == 1 then
			CoD.ButtonList.EnableInput(f10_arg0.categoryButtonList)
			f10_arg0.categoryContainer:animateToState("default")
			local f10_local0 = f10_arg0:openPopup("Error", controller)
			f10_local0:setMessage(Engine.Localize("XBOXLIVE_NOGUESTACCOUNTS"))
		elseif Engine.CanViewContent() == false then
			CoD.ButtonList.EnableInput(f10_arg0.categoryButtonList)
			f10_arg0.categoryContainer:animateToState("default")
			f10_arg0:openPopup("popup_contentrestricted", f10_arg1.controller)
		else
			CoD.perController[f10_arg1.controller].codtvRoot = "customgames"
			f10_arg0:openMenu("CODTv", f10_arg1.controller)
			f10_arg0:close()
		end
	else
		f10_arg0:addGameModeButtons(f10_arg1.controller, f10_arg1.itemInfo.ref)
	end
end

CoD.ChangeGameMode.CreateGameModeInfo = function (f11_arg0, f11_arg1)
	return {
		name = Engine.Localize(f11_arg1.name),
		gametype = f11_arg1.gametype,
		description = Engine.Localize(UIExpression.TableLookup(f11_arg0, CoD.gametypesTable, 0, 0, 1, f11_arg1.gametype, 3)),
		iconMaterial = RegisterMaterial(UIExpression.TableLookup(f11_arg0, CoD.gametypesTable, 0, 0, 1, f11_arg1.gametype, 4))
	}
end

CoD.ChangeGameMode.AddGameModeButtons = function (f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = UIExpression.DvarString(nil, "ui_gametype")
	local f12_local1 = 1
	local f12_local2 = 0
	f12_arg0.gameModeButtons = {}
	for f12_local8, f12_local9 in pairs(Engine.GetGametypesBase()) do
		if f12_local9.category == f12_arg2 then
			local f12_local6 = CoD.ChangeGameMode.CreateGameModeInfo(f12_arg1, f12_local9)
			local f12_local7 = CoD.PlaylistButton.new({
				leftAnchor = true,
				rightAnchor = true,
				left = 0,
				right = 0,
				topAnchor = true,
				bottomAnchor = false,
				top = 0,
				bottom = CoD.CoD9Button.Height
			}, "game_mode_button_action", "game_mode_button_gain_focus", "game_mode_button_lose_focus", f12_local6, f12_local8)
			f12_local7:setLabel(f12_local6.name)
			f12_arg0.gameModeButtonList:addElement(f12_local7)
			table.insert(f12_arg0.gameModeButtons, f12_local7)
			f12_local2 = f12_local2 + 1
			if f12_local9.gametype == f12_local0 then
				f12_local1 = f12_local2
			end
		end
	end
	if #f12_arg0.gameModeButtons > 0 then
		if CoD.useController and not f12_arg0.gameModeButtonList:restoreState() then
			f12_arg0.gameModeButtons[f12_local1]:processEvent({
				name = "gain_focus"
			})
		end
		f12_arg0:registerEventHandler("button_prompt_back", CoD.ChangeGameMode.GameModeBack)
	end
end

