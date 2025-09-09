require("T6.ProfileLeftRightSelector")
CoD.PartyPrivacy = {}
CoD.PartyPrivacy.UpdateHint = function (MaxPlayerSelectorChoice)
	MaxPlayerSelectorChoice.parentSelectorButton.hintText = MaxPlayerSelectorChoice.extraParams.associatedHintText
	local f1_local0 = MaxPlayerSelectorChoice.parentSelectorButton:getParent()
	if f1_local0 ~= nil and f1_local0.hintText ~= nil then
		f1_local0.hintText:updateText(MaxPlayerSelectorChoice.parentSelectorButton.hintText)
	end
end

CoD.PartyPrivacy.SelectionChanged = function (MaxPlayerSelectorChoice)
	Engine.SetProfileVar(MaxPlayerSelectorChoice.parentSelectorButton.m_currentController, MaxPlayerSelectorChoice.parentSelectorButton.m_profileVarName, MaxPlayerSelectorChoice.value)
	CoD.PartyPrivacy.UpdateHint(MaxPlayerSelectorChoice)
end

CoD.PartyPrivacy.Button_Player_SelectionChanged = function (MaxPlayerSelectorChoice)
	local PartyPlayerCount = Engine.PartyGetPlayerCount()
	if PartyPlayerCount ~= nil and PartyPlayerCount > MaxPlayerSelectorChoice.value then
		return false
	else
		CoD.PartyPrivacy.UpdateHint(MaxPlayerSelectorChoice)
		Engine.SetProfileVar(MaxPlayerSelectorChoice.parentSelectorButton.m_currentController, MaxPlayerSelectorChoice.parentSelectorButton.m_profileVarName, MaxPlayerSelectorChoice.value)
		return true
	end
end

CoD.PartyPrivacy.Button_Player_AddChoices = function (MaxPlayerSelector, f4_arg1)
	local PlayerLimitValues = {
		1,
		2,
		3,
		4
	}
	if CoD.isZombie == true then
		PlayerLimitValues = {
			2,
			3,
			4,
			5,
			6,
			7,
			8
		}
	elseif CoD.isMultiplayer == true then
		PlayerLimitValues = {
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			12,
			13,
			14,
			15,
			16,
			17,
			18
		}
	end
	for Index = 1, #PlayerLimitValues, 1 do
		MaxPlayerSelector:addChoice(tostring(PlayerLimitValues[Index]), PlayerLimitValues[Index], {
			associatedHintText = Engine.Localize("MENU_PLAYER_LIMIT_DESC")
		}, CoD.PartyPrivacy.Button_Player_SelectionChanged)
	end
end

CoD.PartyPrivacy.getCurrentUserMaxPlayerCount = function (f5_arg0)
	local MaxUserPlayerCount = Engine.GetMaxUserPlayerCount(f5_arg0.m_currentController)
	if MaxUserPlayerCount == nil then
		MaxUserPlayerCount = 18
	end
	return MaxUserPlayerCount
end

LUI.createMenu.PartyPrivacy = function (LocalClientIndex)
	local PartyPrivacyPopupWidget = CoD.Menu.NewSmallPopup("PartyPrivacy")
	PartyPrivacyPopupWidget.m_ownerController = LocalClientIndex
	PartyPrivacyPopupWidget:addTitle(Engine.Localize("MPUI_LOBBY_PRIVACY_CAPS"))
	PartyPrivacyPopupWidget.partyHostcontroller = UIExpression.GetPrimaryController()
	PartyPrivacyPopupWidget:addBackButton()
	local PartyButtonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.textSize.Big + 20,
		bottom = 0
	})
	PartyPrivacyPopupWidget:addElement(PartyButtonList)
	local PartyPrivacySelector = PartyButtonList:addProfileLeftRightSelector(PartyPrivacyPopupWidget.partyHostcontroller, Engine.Localize("MPUI_LOBBY_PRIVACY_CAPS"), "party_privacyStatus", "", 260)
	PartyPrivacySelector:addChoice(Engine.Localize("MPUI_OPEN_CAPS"), 0, {
		associatedHintText = Engine.Localize("MENU_OPEN_DESC")
	}, CoD.PartyPrivacy.SelectionChanged)
	if CoD.isXBOX then
		PartyPrivacySelector:addChoice(Engine.Localize("MPUI_OPEN_FRIENDS_CAPS"), 1, {
			associatedHintText = Engine.Localize("MENU_OPEN_FRIENDS_DESC")
		}, CoD.PartyPrivacy.SelectionChanged)
		PartyPrivacySelector:addChoice(Engine.Localize("MPUI_INVITE_ONLY_CAPS"), 2, {
			associatedHintText = Engine.Localize("MENU_INVITE_ONLY_DESC")
		}, CoD.PartyPrivacy.SelectionChanged)
	end
	PartyPrivacySelector:addChoice(Engine.Localize("MPUI_CLOSE_CAPS"), 3, {
		associatedHintText = Engine.Localize("MENU_CLOSE_DESC")
	}, CoD.PartyPrivacy.SelectionChanged)
	if CoD.PartyPrivacy.ShouldShowPlayerLimitOpion() == true then
		PartyPrivacyPopupWidget.maxPlayerCap = PartyButtonList:addProfileLeftRightSelector(PartyPrivacyPopupWidget.partyHostcontroller, Engine.Localize("MENU_PLAYER_LIMIT_CAPS"), "party_maxplayers", "", 260)
		PartyPrivacyPopupWidget.maxPlayerCap.getCurrentValue = CoD.PartyPrivacy.getCurrentUserMaxPlayerCount
		PartyPrivacyPopupWidget.maxPlayerCap.currentProfileVarValue = CoD.PartyPrivacy.getCurrentUserMaxPlayerCount(PartyPrivacyPopupWidget.maxPlayerCap)
		PartyPrivacyPopupWidget.maxPlayerCap.currentValue = PartyPrivacyPopupWidget.maxPlayerCap.currentProfileVarValue
		CoD.PartyPrivacy.Button_Player_AddChoices(PartyPrivacyPopupWidget.maxPlayerCap, PartyPrivacyPopupWidget.partyHostcontroller)
		PartyPrivacyPopupWidget:registerEventHandler("partylobby_update", CoD.PartyPrivacy.UpdatePlayerCount)
		PartyPrivacyPopupWidget:registerEventHandler("gamelobby_update", CoD.PartyPrivacy.UpdatePlayerCount)
	end
	PartyPrivacyPopupWidget:registerEventHandler("button_prompt_back", CoD.PartyPrivacy.Back)
	if CoD.useController and not PartyPrivacyPopupWidget:restoreState() then
		PartyPrivacySelector:processEvent({
			name = "gain_focus"
		})
	end
	Engine.PlaySound("cac_loadout_edit_sel")
	return PartyPrivacyPopupWidget
end

CoD.PartyPrivacy.ShouldShowPlayerLimitOpion = function (f7_arg0)
	if Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) then
		return false
	elseif Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) and CoD.isZombie then
		return false
	else
		return true
	end
end

CoD.PartyPrivacy.Back = function (PartyPrivacyPopupWidget, ClientInstance)
	if not Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) or not CoD.isZombie then
		Engine.Exec(PartyPrivacyPopupWidget.partyHostcontroller, "xsessionupdate")
	end
	Engine.Exec(PartyPrivacyPopupWidget.partyHostcontroller, "xsessionupdateprivacy")
	Engine.Exec(PartyPrivacyPopupWidget.partyHostcontroller, "updategamerprofile")
	Engine.SystemNeedsUpdate(nil, "party")
	Engine.SystemNeedsUpdate(nil, "game_options")
	PartyPrivacyPopupWidget:saveState()
	PartyPrivacyPopupWidget:goBack(ClientInstance.controller)
end

CoD.PartyPrivacy.UpdatePlayerCount = function (PartyPrivacyPopupWidget, f9_arg1)
	local PartyPlayerCount = Engine.PartyGetPlayerCount()
	if PartyPlayerCount == 0 then
		return 
	elseif PartyPrivacyPopupWidget.maxPlayerCap:getCurrentChoiceValue() < PartyPlayerCount then
		PartyPrivacyPopupWidget.maxPlayerCap:setChoice(PartyPlayerCount)
	end
end

