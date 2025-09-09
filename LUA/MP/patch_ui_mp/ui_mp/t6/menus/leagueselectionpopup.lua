require("T6.CategoryButton")
CoD.LeagueSelection = {}
CoD.LeagueSelection.AddLeagueButtons = function (f1_arg0, f1_arg1)
	local f1_local0 = Engine.GetLeagues()
	if f1_local0 == nil or #f1_local0 == 0 then
		DebugPrint("Unable to retrieve leagues!")
		return 
	end
	f1_arg0.leagueButtons = {}
	for f1_local4, f1_local5 in ipairs(f1_local0) do
		local f1_local6 = CoD.CategoryButton.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = false,
			top = 0,
			bottom = CoD.CoD9Button.Height
		}, "league_button_action", "league_button_gain_focus", "league_button_lose_focus", f1_local5)
		f1_local6:setLabel(UIExpression.ToUpper(nil, f1_local5.name))
		f1_arg0.leagueButtonList:addElement(f1_local6)
		table.insert(f1_arg0.leagueButtons, f1_local6)
	end
	if #f1_arg0.leagueButtons > 0 then
		if CoD.useController and not f1_arg0.leagueButtonList:restoreState() then
			f1_arg0.leagueButtons[1]:processEvent({
				name = "gain_focus"
			})
		end
		f1_arg0:registerEventHandler("button_prompt_back", CoD.LeagueSelection.LeagueBack)
	end
end

CoD.LeagueSelection.LeagueButtonGainFocus = function (f2_arg0, f2_arg1)
	f2_arg0.infoContainer.owner = f2_arg1.owner
	f2_arg0:updateInfo(f2_arg1.itemInfo)
end

CoD.LeagueSelection.LeagueButtonLoseFocus = function (f3_arg0, f3_arg1)
	if f3_arg0.infoContainer.owner == f3_arg1.owner then
		f3_arg0:updateInfo(nil)
	end
end

CoD.LeagueSelection.LeagueBack = function (f4_arg0, f4_arg1)
	f4_arg0.leagueButtonList:saveState()
	Engine.PartyHostClearUIState()
	f4_arg0:goBack(f4_arg1.controller)
end

CoD.LeagueSelection.LeagueButtonAction = function (f5_arg0, f5_arg1)
	f5_arg0.leagueButtonList:saveState()
	Engine.PartyHostClearUIState()
	f5_arg0:goBack(f5_arg1.controller)
	f5_arg0.occludedMenu:leagueSelected(f5_arg1.itemInfo.id)
end

CoD.LeagueSelection.UpdateInfo = function (f6_arg0, f6_arg1)
	local f6_local0 = ""
	local f6_local1 = ""
	local f6_local2 = nil
	if f6_arg1 ~= nil then
		f6_local0 = UIExpression.ToUpper(nil, f6_arg1.name)
		f6_local1 = f6_arg1.description
		f6_local2 = f6_arg1.icon
	end
	f6_arg0.infoContainer.title:setText(f6_local0)
	f6_arg0.infoContainer.description:setText(f6_local1)
	if f6_local2 ~= nil then
		f6_arg0.infoContainer.icon:registerAnimationState("icon", {
			material = f6_local2,
			alpha = 1
		})
		f6_arg0.infoContainer.icon:animateToState("icon")
	else
		f6_arg0.infoContainer.icon:animateToState("default")
	end
end

LUI.createMenu.LeagueSelection = function (f7_arg0)
	local f7_local0 = CoD.Menu.New("LeagueSelection")
	f7_local0:addTitle(Engine.Localize("MENU_LEAGUES_CAPS"))
	local f7_local1 = 0
	local f7_local2 = (CoD.Menu.Width - f7_local1 * 2) / 3
	local f7_local3 = f7_local1
	f7_local0.buttonContainer = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f7_local3,
		right = f7_local3 + f7_local2,
		topAnchor = true,
		bottomAnchor = true,
		top = f7_local1,
		bottom = 0,
		alpha = 1
	})
	f7_local0.buttonContainer:registerAnimationState("disabled", {
		alpha = 0.5
	})
	f7_local0:addElement(f7_local0.buttonContainer)
	f7_local0.leagueButtonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	f7_local0.leagueButtonList.id = f7_local0.leagueButtonList.id .. ".LeagueButtonList"
	f7_local0.buttonContainer:addElement(f7_local0.leagueButtonList)
	f7_local3 = f7_local3 + f7_local2 - f7_local1
	local f7_local4 = f7_local2 + f7_local1 * 2
	f7_local0.infoContainer = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f7_local3,
		right = f7_local3 + f7_local4,
		topAnchor = true,
		bottomAnchor = true,
		top = f7_local1,
		bottom = 0
	})
	f7_local0:addElement(f7_local0.infoContainer)
	local f7_local5 = 10
	local f7_local6 = f7_local4 - f7_local5 * 2
	local f7_local7 = f7_local6
	local f7_local8 = f7_local5
	local f7_local9 = 0
	f7_local0.infoContainer.icon = LUI.UIImage.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f7_local8,
		right = f7_local8 + f7_local6,
		topAnchor = true,
		bottomAnchor = false,
		top = f7_local9,
		bottom = f7_local9 + f7_local7,
		alpha = 0
	})
	f7_local0.infoContainer:addElement(f7_local0.infoContainer.icon)
	f7_local9 = f7_local9 + f7_local7 + 15
	f7_local0.infoContainer.title = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f7_local9,
		bottom = f7_local9 + CoD.textSize.Big,
		font = CoD.fonts.Big,
		alignment = LUI.Alignment.Center
	})
	f7_local0.infoContainer:addElement(f7_local0.infoContainer.title)
	f7_local9 = f7_local9 + CoD.textSize.Big + CoD.textSize.Big
	f7_local0.infoContainer.description = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f7_local9,
		bottom = f7_local9 + CoD.textSize.Default,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Center
	})
	f7_local0.infoContainer:addElement(f7_local0.infoContainer.description)
	f7_local0:registerEventHandler("league_button_gain_focus", CoD.LeagueSelection.LeagueButtonGainFocus)
	f7_local0:registerEventHandler("league_button_lose_focus", CoD.LeagueSelection.LeagueButtonLoseFocus)
	f7_local0:registerEventHandler("league_button_action", CoD.LeagueSelection.LeagueButtonAction)
	f7_local0.addLeagueButtons = CoD.LeagueSelection.AddLeagueButtons
	f7_local0.updateInfo = CoD.LeagueSelection.UpdateInfo
	f7_local0:addSelectButton()
	f7_local0:addBackButton()
	return f7_local0
end

