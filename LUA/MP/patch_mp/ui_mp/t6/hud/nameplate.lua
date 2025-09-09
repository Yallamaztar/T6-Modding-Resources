CoD.NamePlate = {}
CoD.NamePlate.Height = 60
CoD.NamePlate.Width = 240
CoD.NamePlate.PlayerEmblem_Size = 55
CoD.NamePlate.Alpha = 0.85
CoD.NamePlate.Spacing = 8
CoD.NamePlate.ClanTagWidth = 60
CoD.NamePlate.RankIconSize = 25
CoD.NamePlate.RankWidth = 20

CoD.NamePlate.New = function (LocalClientIndex, PlayerData, f1_arg2)
	local NamePlateWidget = CoD.SplitscreenScaler.new(nil, CoD.SplitscreenNotificationMultiplier)
	NamePlateWidget:setAlpha(CoD.NamePlate.Alpha)
	NamePlateWidget:setLeftRight(false, false, -CoD.NamePlate.Width / 2, CoD.NamePlate.Width / 2)
	NamePlateWidget:setTopBottom(false, true, -CoD.NamePlate.Height, 0)
	if PlayerData ~= nil then
		local NamePlateBackground = LUI.UIStreamedImage.new()
		NamePlateBackground:setLeftRight(true, true, 0, 0)
		NamePlateBackground:setTopBottom(true, true, 0, 0)
		local SameXUID = 1
		if UIExpression.GetXUID(LocalClientIndex) == PlayerData.xuid then
			SameXUID = 0
		end
		local NamePlateBackgroundMaterial = UIExpression.EmblemPlayerBackgroundMaterial(LocalClientIndex, PlayerData.xuid, SameXUID)
		if NamePlateBackgroundMaterial ~= nil then
			NamePlateBackground:setImage(RegisterMaterial(NamePlateBackgroundMaterial))
		end
		NamePlateWidget:addElement(NamePlateBackground)
		NamePlateWidget.namePlateSelectedBg = NamePlateBackground
		if f1_arg2 ~= nil then
			local f1_local5 = LUI.UIText.new()
			f1_local5:setLeftRight(true, true, 0, CoD.NamePlate.Width)
			f1_local5:setTopBottom(true, false, -CoD.textSize.ExtraSmall, 0)
			f1_local5:setFont(CoD.fonts.ExtraSmall)
			NamePlateWidget:addElement(f1_local5)
			f1_local5:setText(f1_arg2)
			f1_local5:setAlignment(LUI.Alignment.Left)
		end
		local PlayerNameText = LUI.UIText.new()
		PlayerNameText:setLeftRight(true, true, CoD.NamePlate.PlayerEmblem_Size, 0)
		PlayerNameText:setTopBottom(true, false, CoD.NamePlate.Spacing, CoD.NamePlate.Spacing + CoD.textSize.ExtraSmall)
		PlayerNameText:setFont(CoD.fonts.ExtraSmall)
		NamePlateWidget:addElement(PlayerNameText)
		PlayerNameText:setText(PlayerData.playerName)
		PlayerNameText:setAlignment(LUI.Alignment.Left)
		if PlayerData.clanTag ~= nil then
			local ClanTagText = LUI.UIText.new()
			ClanTagText:setLeftRight(true, false, CoD.NamePlate.PlayerEmblem_Size, CoD.NamePlate.PlayerEmblem_Size + CoD.NamePlate.ClanTagWidth)
			ClanTagText:setTopBottom(false, true, -CoD.NamePlate.Spacing - CoD.textSize.ExtraSmall, -CoD.NamePlate.Spacing)
			ClanTagText:setFont(CoD.fonts.ExtraSmall)
			NamePlateWidget:addElement(ClanTagText)
			ClanTagText:setText(CoD.getClanTag(PlayerData.clanTag))
			ClanTagText:setAlignment(LUI.Alignment.Left)
		end
		local EmblemServer = LUI.UIElement.new()
		EmblemServer:setLeftRight(true, false, 0, CoD.NamePlate.PlayerEmblem_Size)
		EmblemServer:setTopBottom(true, true, 0, 0)
		EmblemServer:setupPlayerEmblemServer(PlayerData.playerClientNum)
		NamePlateWidget:addElement(EmblemServer)
		local IconOffset = CoD.NamePlate.PlayerEmblem_Size + CoD.NamePlate.ClanTagWidth
		local RankIcon = LUI.UIImage.new()
		RankIcon:setLeftRight(true, false, IconOffset, IconOffset + CoD.NamePlate.RankIconSize)
		RankIcon:setTopBottom(false, true, -CoD.NamePlate.Spacing - CoD.NamePlate.RankIconSize + 3, -CoD.NamePlate.Spacing + 3)
		RankIcon:hide()
		NamePlateWidget:addElement(RankIcon)
		local RankTextOffset = IconOffset + CoD.NamePlate.RankIconSize + 5
		local RankText = LUI.UIText.new()
		RankText:setLeftRight(true, false, RankTextOffset, RankTextOffset + CoD.NamePlate.RankWidth)
		RankText:setTopBottom(false, true, -CoD.NamePlate.Spacing - CoD.textSize.ExtraSmall, -CoD.NamePlate.Spacing)
		RankText:setFont(CoD.fonts.ExtraSmall)
		RankText:setAlignment(LUI.Alignment.Left)
		RankText:hide()
		NamePlateWidget:addElement(RankText)
		if not Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
			if PlayerData.rankIcon ~= nil then
				RankIcon:setImage(RegisterMaterial(PlayerData.rankIcon))
				RankIcon:show()
			end
			if PlayerData.rank ~= nil and (not PlayerData.prestige or PlayerData.prestige ~= tonumber(CoD.MAX_PRESTIGE)) then
				RankText:setText(PlayerData.rank)
				RankText:show()
			end
		else
			if PlayerData.divisionIcon ~= nil then
				RankIcon:setImage(PlayerData.divisionIcon)
				RankIcon:show()
			end
			if PlayerData.subdivisionRank ~= nil then
				RankText:setText(PlayerData.subdivisionRank)
				RankText:show()
			end
		end
	end
	return NamePlateWidget
end

