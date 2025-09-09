CoD.FriendDetails = {}
if CoD.isMultiplayer and not CoD.isZombie then
	require("T6.PlayerIdentity")
end
CoD.FriendDetails.SocialFontName = "Default"
CoD.FriendDetails.new = function ()
	if CoD.isZombie == true then
		return CoD.FriendDetails.New_Zombie()
	else
		return CoD.FriendDetails.New_MultiPlayer()
	end
end

CoD.FriendDetails.New_MultiPlayer = function ()
	local f2_local0 = 110
	local f2_local1 = 20
	local f2_local2 = 2
	local f2_local3 = CoD.Menu.Width / 2 - f2_local1 * 2
	local f2_local4, f2_local5 = CoD.PlayerIdentity.New({
		leftAnchor = false,
		rightAnchor = true,
		left = -f2_local3,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = f2_local0,
		bottom = 0
	}, f2_local3, CoD.PlayerIdentity.Default, true)
	local f2_local6 = f2_local5 + 10
	local f2_local7 = f2_local3
	local f2_local8 = CoD.fonts[CoD.FriendDetails.SocialFontName]
	local f2_local9 = CoD.textSize[CoD.FriendDetails.SocialFontName]
	local f2_local10 = f2_local9 + 5
	f2_local4.socialNameContainer = LUI.UIElement.new()
	f2_local4.socialNameContainer:setLeftRight(false, false, -f2_local7 / 2, f2_local7 / 2)
	f2_local4.socialNameContainer:setTopBottom(true, false, f2_local6, f2_local6 + f2_local10)
	f2_local4.socialNameContainer:setUseStencil(true)
	f2_local4.socialNameContainer:setAlpha(0)
	f2_local4:addElement(f2_local4.socialNameContainer)
	local f2_local11 = LUI.UIImage.new()
	f2_local11:setLeftRight(true, true, 1, -1)
	f2_local11:setTopBottom(true, true, 1, -1)
	f2_local11:setRGB(0, 0, 0)
	f2_local11:setAlpha(0.6)
	f2_local4.socialNameContainer:addElement(f2_local11)
	local f2_local12 = 4
	local f2_local13 = LUI.UIImage.new()
	f2_local13:setLeftRight(true, true, f2_local12, -f2_local12)
	f2_local13:setTopBottom(true, false, f2_local12, f2_local10 * 0.6)
	f2_local13:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
	f2_local13:setAlpha(0.1)
	f2_local4.socialNameContainer:addElement(f2_local13)
	f2_local4.socialNameContainer.border = CoD.Border.new(1, 1, 1, 1, 0.1)
	f2_local4.socialNameContainer:addElement(f2_local4.socialNameContainer.border)
	f2_local4.socialIcon = LUI.UIImage.new()
	f2_local4.socialIcon:setLeftRight(false, false, 0, 0)
	f2_local4.socialIcon:setTopBottom(false, false, -f2_local9 / 2, f2_local9 / 2)
	f2_local4.socialIcon:setImage(RegisterMaterial("menu_lobby_icon_facebook"))
	f2_local4.socialNameContainer:addElement(f2_local4.socialIcon)
	f2_local4.socialName = LUI.UIText.new()
	f2_local4.socialName:setLeftRight(true, true, 0, 0)
	f2_local4.socialName:setTopBottom(false, false, -f2_local9 / 2, f2_local9 / 2)
	f2_local4.socialName:setAlignment(LUI.Alignment.Center)
	f2_local4.socialName:setFont(f2_local8)
	f2_local4.socialName:setText("")
	f2_local4.socialNameContainer:addElement(f2_local4.socialName)
	local f2_local14 = 20
	f2_local4.clanname = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = 175,
		right = 255,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local0 + f2_local14 + 30,
		bottom = f2_local0 + f2_local14 + 30 + CoD.textSize.Default,
		font = CoD.fonts.Default,
		alpha = 1
	})
	f2_local4:addElement(f2_local4.clanname)
	f2_local4.clanmotto = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = 175,
		right = 255,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local0 + f2_local14 + 60,
		bottom = f2_local0 + f2_local14 + 60 + CoD.textSize.Default,
		font = CoD.fonts.Default,
		alpha = 1
	})
	f2_local4:addElement(f2_local4.clanmotto)
	f2_local4.clanmotd = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = 175,
		right = 255,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local0 + f2_local14 + 90,
		bottom = f2_local0 + f2_local14 + 90 + CoD.textSize.Default,
		font = CoD.fonts.Default,
		alpha = 1
	})
	f2_local4:addElement(f2_local4.clanmotd)
	f2_local4.clanlevel = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = 325,
		right = 405,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local0 + f2_local14 + 30,
		bottom = f2_local0 + f2_local14 + 30 + CoD.textSize.Default,
		font = CoD.fonts.Default,
		alpha = 1
	})
	f2_local4:addElement(f2_local4.clanlevel)
	f2_local4.clanxp = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = 325,
		right = 405,
		topAnchor = true,
		bottomAnchor = false,
		top = f2_local0 + f2_local14 + 60,
		bottom = f2_local0 + f2_local14 + 60 + CoD.textSize.Default,
		font = CoD.fonts.Default,
		alpha = 1
	})
	f2_local4:addElement(f2_local4.clanxp)
	return f2_local4
end

CoD.FriendDetails.New_Zombie = function ()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, 200, 200)
	Widget:setTopBottom(true, false, 150, 200)
	local f3_local1 = 200
	local f3_local2 = 200
	local f3_local3 = 25
	local Widget = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f3_local1 / 2,
		right = f3_local1 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f3_local3,
		bottom = f3_local3 + f3_local2
	})
	Widget:addElement(Widget)
	Widget.emblem = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	Widget:addElement(Widget.emblem)
	local f3_local5 = 0.25
	local f3_local6 = f3_local1 + 50
	local f3_local7 = f3_local6 * f3_local5
	local Widget = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f3_local6 / 2,
		right = f3_local6 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f3_local3 + f3_local2,
		bottom = f3_local3 + f3_local2 + f3_local7
	})
	Widget:addElement(Widget)
	Widget.backing = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		material = RegisterMaterial("menu_zm_gamertag"),
		alpha = 1
	})
	Widget:addElement(Widget.backing)
	local f3_local9 = CoD.textSize.Default
	Widget.gamerTag = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -1,
		right = 1,
		topAnchor = false,
		bottomAnchor = false,
		top = -f3_local9 / 2,
		bottom = f3_local9 / 2,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	Widget:addElement(Widget.gamerTag)
	local f3_local10 = 20
	Widget.status = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f3_local6 / 2,
		right = f3_local6 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f3_local3 + f3_local2 + f3_local7 + f3_local10,
		bottom = f3_local3 + f3_local2 + f3_local7 + f3_local10 + f3_local9,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	})
	Widget:addElement(Widget.status)
	local f3_local11 = f3_local1 / 4
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f3_local11,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = f3_local11
	})
	Widget:addElement(Widget)
	Widget.rankIcon = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 1
	})
	Widget:addElement(Widget.rankIcon)
	return Widget
end

CoD.FriendDetails.ShowMPRank = function (f4_arg0)
	local f4_local0
	if f4_arg0 == nil or f4_arg0.rank == nil or tonumber(f4_arg0.rank) <= 0 or Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) ~= false then
		f4_local0 = false
	else
		f4_local0 = true
	end
	return f4_local0
end

CoD.FriendDetails.hide = function (f5_arg0)
	f5_arg0:setAlpha(0)
end

CoD.FriendDetails.refresh = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	if CoD.isZombie == true then
		CoD.FriendDetails.Refresh_Zombie(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	else
		CoD.FriendDetails.Refresh_Multiplayer(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	end
end

CoD.FriendDetails.Refresh_Multiplayer = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)
	local f7_local0 = Engine.GetPlayerInfoByIndex(f7_arg1, f7_arg3, f7_arg4)
	f7_arg0:setAlpha(1)
	f7_arg0:update(f7_arg1, true, f7_arg2, f7_local0, nil)
	if f7_local0.socialName ~= nil and f7_local0.socialName ~= "" then
		f7_arg0.socialName:setText(f7_local0.socialName)
		local f7_local1 = CoD.fonts[CoD.FriendDetails.SocialFontName]
		local f7_local2 = CoD.textSize[CoD.FriendDetails.SocialFontName]
		local f7_local3, f7_local4, f7_local5, f7_local6 = GetTextDimensions(f7_local0.socialName, f7_local1, f7_local2)
		local f7_local7 = -(f7_local5 / 2) - 5
		f7_arg0.socialIcon:setLeftRight(false, false, f7_local7 - f7_local2, f7_local7)
		f7_arg0.socialNameContainer:setAlpha(1)
		f7_arg0.socialIcon:setAlpha(1)
	else
		f7_arg0.socialNameContainer:setAlpha(0)
	end
	if CoD.FriendsListPopup.Mode == CoD.playerListType.elite then
		f7_arg0.socialName:setText(f7_local0.clanname)
		f7_arg0.socialNameContainer:setAlpha(1)
		f7_arg0.socialIcon:setAlpha(0)
	else
		f7_arg0.clanname:setText("")
		f7_arg0.clanmotto:setText("")
		f7_arg0.clanmotd:setText("")
		f7_arg0.clanlevel:setText("")
		f7_arg0.clanxp:setText("")
	end
end

CoD.FriendDetails.Refresh_Zombie = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4)
	f8_arg0.playerInfo = Engine.GetPlayerInfoByIndex(f8_arg1, f8_arg3, f8_arg4)
	f8_arg0:setAlpha(1)
	if CoD.FriendDetails.ShowMPRank(f8_arg0.playerInfo) == true then
		local f8_local0 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f8_arg0.playerInfo.rank - 1, 3)
		if f8_arg0.playerInfo.daysPlayedInLast5Days == 5 then
			f8_local0 = UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f8_arg0.playerInfo.rank - 1, 4)
		end
		f8_arg0.emblem:setImage(RegisterMaterial(f8_local0))
		f8_arg0.rankIcon:setImage(RegisterMaterial(UIExpression.TableLookup(nil, CoD.rankIconTable, 0, f8_arg0.playerInfo.rank - 1, f8_arg0.playerInfo.daysPlayedInLast5Days + 5)))
	else
		f8_arg0.emblem:setImage(RegisterMaterial("menu_zm_rank_1"))
		f8_arg0.rankIcon:setImage(RegisterMaterial("hud_chalk_0"))
	end
	f8_arg0.backingMaterialName = "menu_zm_gamertag"
	f8_arg0.backing:setImage(RegisterMaterial(f8_arg0.backingMaterialName))
	local f8_local0 = ""
	if f8_arg0.playerInfo.clanTag ~= nil then
		f8_local0 = CoD.getClanTag(f8_arg0.playerInfo.clanTag)
	end
	f8_arg0.gamerTag:setText(f8_local0 .. f8_arg0.playerInfo.name)
	local f8_local1 = ""
	if f8_arg0.playerInfo.status ~= nil then
		f8_local1 = f8_arg0.playerInfo.status
	end
	f8_arg0.status:setText(f8_local1)
end

