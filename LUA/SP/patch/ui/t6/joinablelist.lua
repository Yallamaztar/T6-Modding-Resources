require("T6.PlayerList")
CoD.JoinableList = {}
CoD.JoinableList.Update = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	f1_arg1 = Engine.GetTitleFriendsOfAllLocalPlayers(f1_arg0.maxRows - f1_arg2)
	local f1_local0 = #f1_arg1
	local f1_local1 = #f1_arg1 - f1_arg0.maxRows - f1_arg2 + 1
	if f1_local1 >= 1 then
		f1_arg0.bottomText:setText(Engine.Localize("MENU_PLAYERLIST_MORE_PLAYING", f1_local1))
		f1_arg0.border:setTopBottom(true, true, 0, 25)
		f1_arg0.bottomText:setAlpha(0.5)
	else
		f1_arg0.border:setTopBottom(true, true, 0, 0)
		f1_arg0.bottomText:setAlpha(0)
	end
	if f1_local0 == 0 then
		f1_arg0.border:setAlpha(0)
	else
		f1_arg0.border:setAlpha(0.1)
	end
	CoD.PlayerList.Update(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
end

CoD.JoinableList.RowGainFocus = function (f2_arg0, f2_arg1)
	LUI.UIButton.gainFocus(f2_arg0, f2_arg1)
	Engine.SetDvar("ui_friendsListOpen", 1)
	f2_arg0:dispatchEventToParent({
		name = "playerlist_row_selected",
		playerName = f2_arg0.name,
		playerXuid = f2_arg0.playerXuid,
		leagueTeamID = f2_arg0.leagueTeamID,
		listId = f2_arg0.playerList.id,
		listIndex = f2_arg0.rowIndex,
		controller = f2_arg1.controller,
		joinable = true
	})
end

CoD.JoinableList.RowLoseFocus = function (f3_arg0, f3_arg1)
	Engine.SetDvar("ui_friendsListOpen", 0)
	CoD.PlayerListRow.LoseFocus(f3_arg0, f3_arg1)
end

CoD.JoinableList.AddMemberRow = function (f4_arg0, f4_arg1)
	local f4_local0 = CoD.PlayerList.AddMemberRow(f4_arg0, f4_arg1)
	local f4_local1 = "Condensed"
	local f4_local2 = CoD.fonts[f4_local1]
	local f4_local3 = CoD.textSize[f4_local1]
	local f4_local4 = 5
	local f4_local5 = f4_local3 + f4_local4 * 2 - f4_local4 * 2
	local f4_local6 = LUI.UIImage.new()
	f4_local6:setLeftRight(false, true, -f4_local4 - f4_local5, -f4_local4)
	f4_local6:setTopBottom(true, false, 0, f4_local5)
	f4_local6:setImage(RegisterMaterial("menu_mp_party_ease_icon"))
	f4_local0:addElement(f4_local6)
	f4_arg1.joinable = Engine.IsPlayerJoinable(controller, f4_arg1.xuid)
	if f4_arg1.joinable.isJoinable then
		f4_local6:setAlpha(1)
	else
		f4_local6:setAlpha(0)
	end
	f4_local0:registerEventHandler("gain_focus", CoD.JoinableList.RowGainFocus)
	f4_local0:registerEventHandler("lose_focus", CoD.JoinableList.RowLoseFocus)
	return f4_local0
end

CoD.JoinableList.New = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	local f5_local0 = CoD.PlayerList.New(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4)
	f5_local0.showVoipIcons = false
	f5_local0.addMemberRow = CoD.JoinableList.AddMemberRow
	f5_local0.update = CoD.JoinableList.Update
	f5_local0.bottomText = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = true,
		top = -CoD.textSize.Default / 2 + 5,
		bottom = CoD.textSize.Default / 2 + 5,
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		font = CoD.fonts.Default,
		alpha = 0.5
	})
	f5_local0:addElement(f5_local0.bottomText)
	f5_local0.border = CoD.Border.new(1, 1, 1, 1, 0.1, -10)
	f5_local0:addElement(f5_local0.border)
	return f5_local0
end

