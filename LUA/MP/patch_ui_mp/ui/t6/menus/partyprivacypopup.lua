require("T6.ProfileLeftRightSelector")
CoD.PartyPrivacy = {}
CoD.PartyPrivacy.UpdateHint = function (f1_arg0)
	f1_arg0.parentSelectorButton.hintText = f1_arg0.extraParams.associatedHintText
	local f1_local0 = f1_arg0.parentSelectorButton:getParent()
	if f1_local0 ~= nil and f1_local0.hintText ~= nil then
		f1_local0.hintText:updateText(f1_arg0.parentSelectorButton.hintText)
	end
end

CoD.PartyPrivacy.SelectionChanged = function (f2_arg0)
	Engine.SetProfileVar(f2_arg0.parentSelectorButton.m_currentController, f2_arg0.parentSelectorButton.m_profileVarName, f2_arg0.value)
	CoD.PartyPrivacy.UpdateHint(f2_arg0)
end

CoD.PartyPrivacy.Button_Player_SelectionChanged = function (f3_arg0)
	local f3_local0 = Engine.PartyGetPlayerCount()
	local f3_local1 = f3_arg0.value
	if f3_local0 ~= nil and f3_local1 < f3_local0 then
		f3_local1 = f3_local0
		return false
	else
		CoD.PartyPrivacy.UpdateHint(f3_arg0)
		Engine.SetProfileVar(f3_arg0.parentSelectorButton.m_currentController, f3_arg0.parentSelectorButton.m_profileVarName, f3_local1)
		return true
	end
end

CoD.PartyPrivacy.Button_Player_AddChoices = function (f4_arg0, f4_arg1)
	local f4_local0 = {
		1,
		2,
		3,
		4
	}
	if CoD.isZombie == true then
		f4_local0 = {
			2,
			3,
			4,
			5,
			6,
			7,
			8
		}
	elseif CoD.isMultiplayer == true then
		f4_local0 = {
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
	for f4_local1 = 1, #f4_local0, 1 do
		f4_arg0:addChoice(tostring(f4_local0[f4_local1]), f4_local0[f4_local1], {
			associatedHintText = Engine.Localize("MENU_PLAYER_LIMIT_DESC")
		}, CoD.PartyPrivacy.Button_Player_SelectionChanged)
	end
end

CoD.PartyPrivacy.getCurrentUserMaxPlayerCount = function (f5_arg0)
	local f5_local0 = Engine.GetMaxUserPlayerCount(f5_arg0.m_currentController)
	if f5_local0 == nil then
		f5_local0 = 18
	end
	return f5_local0
end

LUI.createMenu.PartyPrivacy = function (f6_arg0)
	local f6_local0 = CoD.Menu.NewSmallPopup("PartyPrivacy")
	f6_local0.m_ownerController = f6_arg0
	f6_local0:addTitle(Engine.Localize("MPUI_LOBBY_PRIVACY_CAPS"))
	f6_local0.partyHostcontroller = UIExpression.GetPrimaryController()
	f6_local0:addBackButton()
	local f6_local1 = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.textSize.Big + 20,
		bottom = 0
	})
	f6_local0:addElement(f6_local1)
	local f6_local2 = f6_local1:addProfileLeftRightSelector(f6_local0.partyHostcontroller, Engine.Localize("MPUI_LOBBY_PRIVACY_CAPS"), "party_privacyStatus", "", 260)
	f6_local2:addChoice(Engine.Localize("MPUI_OPEN_CAPS"), 0, {
		associatedHintText = Engine.Localize("MENU_OPEN_DESC")
	}, CoD.PartyPrivacy.SelectionChanged)
	if CoD.isXBOX then
		f6_local2:addChoice(Engine.Localize("MPUI_OPEN_FRIENDS_CAPS"), 1, {
			associatedHintText = Engine.Localize("MENU_OPEN_FRIENDS_DESC")
		}, CoD.PartyPrivacy.SelectionChanged)
		f6_local2:addChoice(Engine.Localize("MPUI_INVITE_ONLY_CAPS"), 2, {
			associatedHintText = Engine.Localize("MENU_INVITE_ONLY_DESC")
		}, CoD.PartyPrivacy.SelectionChanged)
	end
	f6_local2:addChoice(Engine.Localize("MPUI_CLOSE_CAPS"), 3, {
		associatedHintText = Engine.Localize("MENU_CLOSE_DESC")
	}, CoD.PartyPrivacy.SelectionChanged)
	if CoD.PartyPrivacy.ShouldShowPlayerLimitOpion() == true then
		f6_local0.maxPlayerCap = f6_local1:addProfileLeftRightSelector(f6_local0.partyHostcontroller, Engine.Localize("MENU_PLAYER_LIMIT_CAPS"), "party_maxplayers", "", 260)
		f6_local0.maxPlayerCap.getCurrentValue = CoD.PartyPrivacy.getCurrentUserMaxPlayerCount
		f6_local0.maxPlayerCap.currentProfileVarValue = CoD.PartyPrivacy.getCurrentUserMaxPlayerCount(f6_local0.maxPlayerCap)
		f6_local0.maxPlayerCap.currentValue = f6_local0.maxPlayerCap.currentProfileVarValue
		CoD.PartyPrivacy.Button_Player_AddChoices(f6_local0.maxPlayerCap, f6_local0.partyHostcontroller)
		f6_local0:registerEventHandler("partylobby_update", CoD.PartyPrivacy.UpdatePlayerCount)
		f6_local0:registerEventHandler("gamelobby_update", CoD.PartyPrivacy.UpdatePlayerCount)
	end
	f6_local0:registerEventHandler("button_prompt_back", CoD.PartyPrivacy.Back)
	if CoD.useController and not f6_local0:restoreState() then
		f6_local2:processEvent({
			name = "gain_focus"
		})
	end
	Engine.PlaySound("cac_loadout_edit_sel")
	return f6_local0
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

CoD.PartyPrivacy.Back = function (f8_arg0, f8_arg1)
	if not Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) or not CoD.isZombie then
		Engine.Exec(f8_arg0.partyHostcontroller, "xsessionupdate")
	end
	Engine.Exec(f8_arg0.partyHostcontroller, "xsessionupdateprivacy")
	Engine.Exec(f8_arg0.partyHostcontroller, "updategamerprofile")
	Engine.SystemNeedsUpdate(nil, "party")
	Engine.SystemNeedsUpdate(nil, "game_options")
	f8_arg0:saveState()
	f8_arg0:goBack(f8_arg1.controller)
end

CoD.PartyPrivacy.UpdatePlayerCount = function (f9_arg0, f9_arg1)
	local f9_local0 = Engine.PartyGetPlayerCount()
	if f9_local0 == 0 then
		return 
	elseif f9_arg0.maxPlayerCap:getCurrentChoiceValue() < f9_local0 then
		f9_arg0.maxPlayerCap:setChoice(f9_local0)
	end
end

