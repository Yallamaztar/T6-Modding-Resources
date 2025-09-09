CoD.ClanTag = {}
CoD.ClanTag.AddButton = function (f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = f1_arg0.buttonList:addButton(f1_arg1)
	f1_local0.selectedbuttonIcon = LUI.UIImage.new({
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
	f1_local0.selectedbuttonIcon:registerAnimationState("selected", {
		alpha = 1
	})
	f1_local0:addElement(f1_local0.selectedbuttonIcon)
	f1_local0:registerEventHandler("button_action", f1_arg2)
	return f1_local0
end

CoD.ClanTag.PrepareButtonList = function (f2_arg0, f2_arg1)
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
	f2_arg0:addElement(f2_local4)
	f2_arg0.buttonList = CoD.ButtonList.new({
		left = f2_local0,
		top = f2_local1,
		right = f2_local0 + f2_local3,
		bottom = f2_local1 + f2_local2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	f2_arg0:addElement(f2_arg0.buttonList)
	f2_arg0.clanName = CoD.ClanTag.GetClanName(f2_arg1)
	local f2_local5 = f2_arg0.clanName
	if f2_local5 == "" then
		f2_local5 = Engine.Localize("MPUI_CREATE_CLAN_TAG_CAPS")
	end
	f2_arg0.clanButton = CoD.ClanTag.AddButton(f2_arg0, f2_local5, CoD.ClanTag.Button_EditClanTag)
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
	f2_arg0:addElement(f2_local6)
	f2_arg0.buttonList:addSpacer(60)
	f2_arg0.clanTags = {}
	CoD.ClanTag.CreateClanTagColorButtons(f2_arg1, f2_arg0, 1, Engine.GetClanTagFeatureCount(f2_arg1))
	f2_arg0.buttonList:processEvent({
		name = "gain_focus"
	})
end

CoD.ClanTag.RefreshClanTagColorButtons = function (f3_arg0, f3_arg1)
	local f3_local0 = tonumber(CoD.ClanTag.GetSelectedClanTagFeature(f3_arg1))
	for f3_local1 = 1, Engine.GetClanTagFeatureCount(f3_arg1), 1 do
		local f3_local4 = UIExpression.GetClanTagFeatureName(f3_arg1, f3_local1)
		if f3_local0 == f3_local1 then
			f3_arg0.clanTags[f3_local4].button.selectedbuttonIcon:animateToState("selected")
		else
			f3_arg0.clanTags[f3_local4].button.selectedbuttonIcon:animateToState("default")
		end
	end
end

CoD.ClanTag.RefreshClanTag = function (f4_arg0, f4_arg1)
	local f4_local0 = CoD.ClanTag.GetClanName(f4_arg1.controller)
	if f4_arg0.clanName ~= f4_local0 then
		if f4_local0 == "" then
			f4_arg0.clanButton:setLabel(Engine.Localize("MPUI_CREATE_CLAN_TAG_CAPS"))
		else
			f4_arg0.clanButton:setLabel(f4_local0)
		end
		f4_arg0.clanName = f4_local0
	end
	CoD.ClanTag.RefreshClanTagColorButtons(f4_arg0, f4_arg1.controller)
end

CoD.ClanTag.Button_EditClanTag = function (f5_arg0, f5_arg1)
	Engine.Exec(f5_arg1.controller, "editclanname")
end

CoD.ClanTag.Button_ClanTagColor = function (f6_arg0, f6_arg1)
	Engine.Exec(f6_arg1.controller, "setClanTag " .. f6_arg0.index)
end

CoD.ClanTag.CreateClanTagColorButtons = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	local f7_local0 = tonumber(CoD.ClanTag.GetSelectedClanTagFeature(f7_arg0))
	for f7_local1 = f7_arg2, f7_arg3, 1 do
		local f7_local4 = UIExpression.GetClanTagFeatureName(f7_arg0, f7_local1)
		local f7_local5 = Engine.Localize("MPUI_CLANTAG_" .. f7_local4)
		f7_arg1.clanTags[f7_local4] = {}
		if f7_local0 == f7_local1 then
			f7_arg1.clanTags[f7_local4].button = CoD.ClanTag.AddButton(f7_arg1, f7_local5, CoD.ClanTag.Button_ClanTagColor)
			f7_arg1.clanTags[f7_local4].button.selectedbuttonIcon:animateToState("selected")
		else
			f7_arg1.clanTags[f7_local4].button = CoD.ClanTag.AddButton(f7_arg1, f7_local5, CoD.ClanTag.Button_ClanTagColor)
		end
		f7_arg1.clanTags[f7_local4].button.index = f7_local1
		f7_arg1.clanTags[f7_local4].button:registerEventHandler("button_action", CoD.ClanTag.Button_ClanTagColor)
	end
end

CoD.ClanTag.GetSelectedClanTagFeature = function (f8_arg0)
	return string.sub(UIExpression.GetClanName(f8_arg0), 3, 3)
end

CoD.ClanTag.GetClanName = function (f9_arg0)
	local f9_local0 = UIExpression.GetClanName(f9_arg0)
	if string.match(f9_local0, "^%[%^7") then
		return string.sub(f9_local0, 4, -2)
	else
		return string.sub(f9_local0, 2, -2)
	end
end

LUI.createMenu.ClanTag = function (f10_arg0)
	local f10_local0 = CoD.Menu.New("ClanTag")
	f10_local0:addLargePopupBackground()
	f10_local0:registerEventHandler("refresh_clantag", CoD.ClanTag.RefreshClanTag)
	f10_local0:addBackButton()
	f10_local0:addSelectButton()
	CoD.ClanTag.PrepareButtonList(f10_local0, f10_arg0)
	return f10_local0
end

