CoD.ClanTag = {}
CoD.ClanTag.AddButton = function (ClanTagMenu, ClanName, ButtonFunc)
	local ClanTagButton = ClanTagMenu.buttonList:addButton(ClanName)
	ClanTagButton.selectedbuttonIcon = LUI.UIImage.new({
		left = -25,
		top = 8,
		right = -9,
		bottom = -8,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.green.r,
		green = CoD.green.g,
		blue = CoD.green.b,
		alpha = 0
	})
	ClanTagButton.selectedbuttonIcon:registerAnimationState("selected", {
		alpha = 1
	})
	ClanTagButton:addElement(ClanTagButton.selectedbuttonIcon)
	ClanTagButton:registerEventHandler("button_action", ButtonFunc)
	return ClanTagButton
end

CoD.ClanTag.PrepareButtonList = function (ClanTagMenu, LocalClientIndex)
	local f2_local0 = 20
	local f2_local1 = 60
	local f2_local2 = 350
	local f2_local3 = 300
	local f2_local4 = LUI.UIText.new({
		left = f2_local0,
		top = f2_local1 - 30,
		right = f2_local0 + f2_local3,
		bottom = f2_local1 - 5,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	f2_local4:setText(Engine.Localize("MPUI_EDIT_CLAN_TAG_CAPS"))
	ClanTagMenu:addElement(f2_local4)
	ClanTagMenu.buttonList = CoD.ButtonList.new({
		left = f2_local0,
		top = f2_local1,
		right = f2_local0 + f2_local3,
		bottom = f2_local1 + f2_local2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	ClanTagMenu:addElement(ClanTagMenu.buttonList)
	ClanTagMenu.clanName = CoD.ClanTag.GetClanName(LocalClientIndex)
	local ClanName = ClanTagMenu.clanName
	if ClanName == "" then
		ClanName = Engine.Localize("MPUI_CREATE_CLAN_TAG_CAPS")
	end
	ClanTagMenu.clanButton = CoD.ClanTag.AddButton(ClanTagMenu, ClanName, CoD.ClanTag.Button_EditClanTag)
	local f2_local6 = LUI.UIText.new({
		left = f2_local0,
		top = f2_local1 + 60,
		right = f2_local0 + f2_local3,
		bottom = f2_local1 + 85,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	f2_local6:setText(Engine.Localize("MPUI_CLAN_TAG_COLOR_CAPS"))
	ClanTagMenu:addElement(f2_local6)
	ClanTagMenu.buttonList:addSpacer(60)
	ClanTagMenu.clanTags = {}
	CoD.ClanTag.CreateClanTagColorButtons(LocalClientIndex, ClanTagMenu, 1, Engine.GetClanTagFeatureCount(LocalClientIndex))
	ClanTagMenu.buttonList:processEvent({
		name = "gain_focus"
	})
end

CoD.ClanTag.RefreshClanTagColorButtons = function (ClanTagMenu, LocalClientIndex)
	local f3_local0 = tonumber(CoD.ClanTag.GetSelectedClanTagFeature(LocalClientIndex))
	for f3_local1 = 1, Engine.GetClanTagFeatureCount(LocalClientIndex), 1 do
		local f3_local4 = UIExpression.GetClanTagFeatureName(LocalClientIndex, f3_local1)
		if f3_local0 == f3_local1 then
			ClanTagMenu.clanTags[f3_local4].button.selectedbuttonIcon:animateToState("selected")
		else
			ClanTagMenu.clanTags[f3_local4].button.selectedbuttonIcon:animateToState("default")
		end
	end
end

CoD.ClanTag.RefreshClanTag = function (ClanTagMenu, ClientInstance)
	local ClanName = CoD.ClanTag.GetClanName(ClientInstance.controller)
	if ClanTagMenu.clanName ~= ClanName then
		if ClanName == "" then
			ClanTagMenu.clanButton:setLabel(Engine.Localize("MPUI_CREATE_CLAN_TAG_CAPS"))
		else
			ClanTagMenu.clanButton:setLabel(ClanName)
		end
		ClanTagMenu.clanName = ClanName
	end
	CoD.ClanTag.RefreshClanTagColorButtons(ClanTagMenu, ClientInstance.controller)
end

CoD.ClanTag.Button_EditClanTag = function (ClanTagMenu, ClientInstance)
	Engine.Exec(ClientInstance.controller, "editclanname")
end

CoD.ClanTag.Button_ClanTagColor = function (ClanTagMenu, ClientInstance)
	Engine.Exec(ClientInstance.controller, "setClanTag " .. ClanTagMenu.index)
end

CoD.ClanTag.CreateClanTagColorButtons = function (LocalClientIndex, ClanTagMenu, StartIndex, ClanTagFeatureCount)
	local f7_local0 = tonumber(CoD.ClanTag.GetSelectedClanTagFeature(LocalClientIndex))
	for ClanTagFeatureNameIndex = StartIndex, ClanTagFeatureCount, 1 do
		local ClanTagFeatureName = UIExpression.GetClanTagFeatureName(LocalClientIndex, ClanTagFeatureNameIndex)
		local ClanName = Engine.Localize("MPUI_CLANTAG_" .. ClanTagFeatureName)
		ClanTagMenu.clanTags[ClanTagFeatureName] = {}
		if f7_local0 == ClanTagFeatureNameIndex then
			ClanTagMenu.clanTags[ClanTagFeatureName].button = CoD.ClanTag.AddButton(ClanTagMenu, ClanName, CoD.ClanTag.Button_ClanTagColor)
			ClanTagMenu.clanTags[ClanTagFeatureName].button.selectedbuttonIcon:animateToState("selected")
		else
			ClanTagMenu.clanTags[ClanTagFeatureName].button = CoD.ClanTag.AddButton(ClanTagMenu, ClanName, CoD.ClanTag.Button_ClanTagColor)
		end
		ClanTagMenu.clanTags[ClanTagFeatureName].button.index = ClanTagFeatureNameIndex
		ClanTagMenu.clanTags[ClanTagFeatureName].button:registerEventHandler("button_action", CoD.ClanTag.Button_ClanTagColor)
	end
end

CoD.ClanTag.GetSelectedClanTagFeature = function (LocalClientIndex)
	return string.sub(UIExpression.GetClanName(LocalClientIndex), 3, 3)
end

CoD.ClanTag.GetClanName = function (LocalClientIndex)
	local ClanName = UIExpression.GetClanName(LocalClientIndex)
	if string.match(ClanName, "^%[%^7") then
		return string.sub(ClanName, 4, -2)
	else
		return string.sub(ClanName, 2, -2)
	end
end

LUI.createMenu.ClanTag = function (LocalClientIndex)
	local ClanTagMenu = CoD.Menu.New("ClanTag")
	ClanTagMenu:addLargePopupBackground()
	ClanTagMenu:registerEventHandler("refresh_clantag", CoD.ClanTag.RefreshClanTag)
	ClanTagMenu:addBackButton()
	ClanTagMenu:addSelectButton()
	CoD.ClanTag.PrepareButtonList(ClanTagMenu, LocalClientIndex)
	return ClanTagMenu
end

