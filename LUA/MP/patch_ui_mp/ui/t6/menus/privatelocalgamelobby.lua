require("T6.Menus.PrivateGameLobby")
require("T6.Menus.ServerBrowserPopup")
CoD.PrivateLocalGameLobby = {}
CoD.PrivateLocalGameLobby.PopulateButtons = function (f1_arg0)
	if f1_arg0.body == nil then
		return 
	end
	f1_arg0.body.buttonList:removeAllButtons()
	f1_arg0.body.widestButtonTextWidth = CoD.PrivateGameLobby.DefaultSetupGameFlyoutLeft
	local f1_local0 = CoD.PrivateGameLobby.IsHost(f1_arg0, f1_arg0.panelManager.m_ownerController)
	if f1_local0 == true then
		f1_arg0.body.startMatchButton = f1_arg0.body.buttonList:addButton(Engine.Localize("MPUI_START_MATCH_CAPS"))
		f1_arg0.body.startMatchButton.hintText = Engine.Localize("MPUI_START_MATCH_DESC")
		f1_arg0.body.startMatchButton:registerEventHandler("button_action", CoD.PrivateGameLobby.Button_StartMatch)
		f1_arg0.body.startMatchButton:registerEventHandler("start_game", f1_arg0.body.startMatchButton.disable)
		f1_arg0.body.startMatchButton:registerEventHandler("cancel_start_game", f1_arg0.body.startMatchButton.enable)
		f1_arg0.body.startMatchButton:registerEventHandler("gamelobby_update", CoD.PrivateGameLobby.Button_GameLobbyUpdate)
		f1_arg0.body.gameModeInfo = CoD.Lobby.CreateInfoPane()
		f1_arg0.defaultFocusButton = f1_arg0.body.startMatchButton
		CoD.PrivateGameLobby.Button_UpdateHostButton(f1_arg0.body.startMatchButton)
	end
	CoD.PrivateLocalGameLobby.PopulateButtons_Project(f1_arg0, f1_local0)
	if f1_local0 == false then
		f1_arg0.defaultFocusButton = f1_arg0.body.createAClassButton
	end
	CoD.PrivateGameLobby.UpdateHostButtons(f1_arg0)
	if f1_arg0.body.mapInfoImage ~= nil then
		f1_arg0.body.mapInfoImage:close()
	end
	local f1_local1 = 350 - CoD.CoD9Button.Height - 0
	local f1_local2 = f1_local1 / CoD.MapInfoImage.AspectRatio
	f1_arg0.body.mapInfoImage = CoD.MapInfoImage.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f1_local1,
		topAnchor = false,
		bottomAnchor = true,
		top = -f1_local2 - CoD.ButtonPrompt.Height - 15,
		bottom = -CoD.ButtonPrompt.Height - 15
	})
	f1_arg0.body.mapInfoImage:setPriority(200)
	f1_arg0.body:addElement(f1_arg0.body.mapInfoImage)
	CoD.PrivateGameLobby.AddDLCWarning(f1_arg0, f1_local0)
	CoD.GameLobby.PopulateButtons(f1_arg0, f1_local2)
	if not f1_arg0:restoreState() and CoD.useController == true and f1_arg0.defaultFocusButton ~= nil then
		f1_arg0.defaultFocusButton:processEvent({
			name = "gain_focus"
		})
	end
	CoD.PrivateGameLobby.UpdateButtonPaneButtonVisibility(f1_arg0)
end

CoD.PrivateLocalGameLobby.PopulateButtonPaneElements = function (f2_arg0)
	CoD.PrivateLocalGameLobby.PopulateButtons(f2_arg0)
end

CoD.PrivateLocalGameLobby.RebuildButtonPanel = function (f3_arg0, f3_arg1)
	CoD.PanelManager.RebuildPanel(f3_arg0.panelManager, "buttonPane")
end

LUI.createMenu.PrivateLocalGameLobby = function (f4_arg0)
	local f4_local0 = CoD.PrivateGameLobby.New("PrivateLocalGameLobby", f4_arg0)
	if CoD.isMultiplayer then
		f4_local0:setPreviousMenu("MainMenu")
	end
	local f4_local1 = Engine.Localize("PLATFORM_SYSTEM_LINK_CAPS")
	f4_local0:addTitle(f4_local1)
	f4_local0.populateButtonPaneElements = CoD.PrivateLocalGameLobby.PopulateButtonPaneElements
	f4_local0.populateButtons = CoD.PrivateLocalGameLobby.PopulateButtons
	f4_local0:updatePanelFunctions()
	f4_local0.populateButtons(f4_local0.buttonPane)
	f4_local0.panelManager.panels.buttonPane.titleText = f4_local1
	f4_local0:registerEventHandler("rebuild_button_panel", CoD.PrivateLocalGameLobby.RebuildButtonPanel)
	f4_local0.panelManager:setSlidingAllowed(false)
	return f4_local0
end

CoD.PrivateLocalGameLobby.PopulateButtons_Project = function (f5_arg0, f5_arg1)
	if CoD.isZombie == true then
		CoD.PrivateGameLobby.PopulateButtons_Project_Zombie(f5_arg0, f5_arg1)
	else
		CoD.PrivateLocalGameLobby.PopulateButtons_Project_Multiplayer(f5_arg0, f5_arg1)
	end
end

CoD.PrivateLocalGameLobby.PopulateButtons_Project_Multiplayer = function (f6_arg0, f6_arg1)
	if f6_arg1 == true then
		local f6_local0 = Engine.Localize("MPUI_SETUP_GAME_CAPS")
		local f6_local1 = {}
		f6_local1 = GetTextDimensions(f6_local0, CoD.CoD9Button.Font, CoD.CoD9Button.TextHeight)
		f6_arg0.body.setupGameButton = f6_arg0.body.buttonList:addButton(f6_local0)
		f6_arg0.body.setupGameButton.hintText = Engine.Localize("MPUI_SETUP_GAME_DESC")
		f6_arg0.body.setupGameButton:setActionEventName("open_setup_game_flyout")
		f6_arg0.body.setupGameButton:registerEventHandler("button_update", CoD.PrivateGameLobby.Button_UpdateHostButton)
		if f6_arg0.body.widestButtonTextWidth < f6_local1[3] then
			f6_arg0.body.widestButtonTextWidth = f6_local1[3]
		end
		local f6_local2 = Engine.Localize("MENU_SETUP_BOTS_CAPS")
		local f6_local3 = {}
		f6_local3 = GetTextDimensions(f6_local2, CoD.CoD9Button.Font, CoD.CoD9Button.TextHeight)
		local f6_local4 = f6_local3[3]
		f6_arg0.body.botsButton = f6_arg0.body.buttonList:addButton(f6_local2)
		f6_arg0.body.botsButton:setActionEventName("open_bots_menu")
		f6_arg0.body.botsButton:registerEventHandler("gamelobby_update", CoD.PrivateGameLobby.BotButton_Update)
		if f6_arg0.body.widestButtonTextWidth < f6_local4 then
			f6_arg0.body.widestButtonTextWidth = f6_local4
		end
		local f6_local5 = LUI.UIImage.new()
		f6_local5:setLeftRight(true, false, f6_local4 + 5, f6_local4 + 5 + 30)
		f6_local5:setTopBottom(false, false, -15, 15)
		f6_local5:setAlpha(0)
		f6_local5:setImage(RegisterMaterial(CoD.MPZM("ui_host", "ui_host_zm")))
		f6_arg0.body.botsButton:addElement(f6_local5)
		f6_arg0.body.botsButton.starImage = f6_local5
		CoD.PrivateGameLobby.BotButton_Update(f6_arg0.body.botsButton)
		f6_arg0.body.buttonList:addSpacer(CoD.CoD9Button.Height / 2)
	end
	local f6_local0 = Engine.Localize("MENU_CREATE_A_CLASS_CAPS")
	local f6_local1 = {}
	f6_local1 = GetTextDimensions(f6_local0, CoD.CoD9Button.Font, CoD.CoD9Button.TextHeight)
	f6_arg0.body.createAClassButton = f6_arg0.body.buttonList:addButton(f6_local0)
	CoD.CACUtility.SetupCACLock(f6_arg0.body.createAClassButton)
	f6_arg0.body.createAClassButton:registerEventHandler("button_action", CoD.GameLobby.Button_CAC)
	if f6_arg0.body.widestButtonTextWidth < f6_local1[3] then
		f6_arg0.body.widestButtonTextWidth = f6_local1[3]
	end
	local f6_local2 = Engine.Localize("MENU_SCORE_STREAKS_CAPS")
	local f6_local3 = {}
	f6_local3 = GetTextDimensions(f6_local2, CoD.CoD9Button.Font, CoD.CoD9Button.TextHeight)
	f6_arg0.body.rewardsButton = f6_arg0.body.buttonList:addButton(f6_local2)
	f6_arg0.body.rewardsButton.hintText = Engine.Localize("FEATURE_KILLSTREAKS_DESC")
	CoD.SetupButtonLock(f6_arg0.body.rewardsButton, nil, "FEATURE_KILLSTREAKS", "FEATURE_KILLSTREAKS_DESC")
	f6_arg0.body.rewardsButton:registerEventHandler("button_action", CoD.GameLobby.Button_Rewards)
	if f6_arg0.body.widestButtonTextWidth < f6_local3[3] then
		f6_arg0.body.widestButtonTextWidth = f6_local3[3]
	end
end

