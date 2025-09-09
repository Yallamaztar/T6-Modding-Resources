CoD.EditGameOptions = {}
CoD.EditGameOptions.Close = function (f1_arg0)
	Engine.Exec(event.controller, "endCustomGametypeChanges")
	Engine.Exec(event.controller, "checkIfCustomGametypeChanged")
	Engine.SetDvar("customGameMode", 1)
	Engine.Exec(event.controller, "xupdatepartystate")
	if AreGametypeSettingsDirty() then
		f1_arg0:processEvent({
			name = "game_options_update"
		})
	end
	CoD.Menu.close(f1_arg0)
end

local f0_local0 = function (f2_arg0, f2_arg1)
	f2_arg0:addChoice(f2_arg1, Engine.Localize("MPUI_RULES_UNLIMITED_CAPS"), 0)
	f2_arg0:addChoice(f2_arg1, Engine.Localize("MPUI_RULES_2_5MINUTES_CAPS"), 2.5)
	f2_arg0:addChoice(f2_arg1, Engine.Localize("MPUI_RULES_3MINUTES_CAPS"), 3)
	f2_arg0:addChoice(f2_arg1, Engine.Localize("MPUI_RULES_5MINUTES_CAPS"), 5)
	f2_arg0:addChoice(f2_arg1, Engine.Localize("MPUI_RULES_8MINUTES_CAPS"), 8)
	f2_arg0:addChoice(f2_arg1, Engine.Localize("MPUI_RULES_10MINUTES_CAPS"), 10)
	f2_arg0:addChoice(f2_arg1, Engine.Localize("MPUI_RULES_15MINUTES_CAPS"), 15)
	f2_arg0:addChoice(f2_arg1, Engine.Localize("MPUI_RULES_20MINUTES_CAPS"), 20)
	f2_arg0:addChoice(f2_arg1, Engine.Localize("MPUI_RULES_30MINUTES_CAPS"), 30)
end

local f0_local1 = function (f3_arg0, f3_arg1)
	local f3_local0 = UIExpression.DvarString(nil, "ui_gametype")
	if f3_local0 == "dom" or f3_local0 == "koth" or f3_local0 == "hq" then
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_10POINTS_CAPS"), 10)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_30POINTS_CAPS"), 30)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_50POINTS_CAPS"), 50)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_70POINTS_CAPS"), 70)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_100POINTS_CAPS"), 100)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_200POINTS_CAPS"), 200)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_250POINTS_CAPS"), 250)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_300POINTS_CAPS"), 300)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_500POINTS_CAPS"), 500)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_700POINTS_CAPS"), 700)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_750POINTS_CAPS"), 750)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_1000POINTS_CAPS"), 1000)
	elseif f3_local0 == "dm" or f3_local0 == "tdm" then
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_500POINTS_CAPS"), 500)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_750POINTS_CAPS"), 750)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_1000POINTS_CAPS"), 1000)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_1500POINTS_CAPS"), 1500)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_2500POINTS_CAPS"), 2500)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_3000POINTS_CAPS"), 3000)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_5000POINTS_CAPS"), 5000)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_7000POINTS_CAPS"), 7000)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_7500POINTS_CAPS"), 7500)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_10000POINTS_CAPS"), 10000)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_15000POINTS_CAPS"), 15000)
		f3_arg0:addChoice(f3_arg1, Engine.Localize("MPUI_RULES_30000POINTS_CAPS"), 30000)
	end
end

CoD.EditGameOptions.Button_Bot_SelectionChanged = function (f4_arg0)
	Engine.SetDvar(f4_arg0.parentSelectorButton.m_dvarName, f4_arg0.value)
	local f4_local0 = UIExpression.DvarInt(nil, "party_maxplayers") - 1
	local f4_local1 = UIExpression.DvarInt(nil, "bot_friends")
	local f4_local2 = UIExpression.DvarInt(nil, "bot_enemies")
	if f4_local0 < f4_local1 + f4_local2 then
		if f4_arg0.parentSelectorButton.m_dvarName == "bot_friends" then
			diff = f4_local0 - f4_local1 + 1
		else
			diff = f4_local0 - f4_local2 + 1
		end
		f4_arg0.extraParams.otherButton.m_currentChoice = diff
		f4_arg0.extraParams.otherButton:updateChoice()
	end
end

local f0_local2 = function (f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = {
		"MPUI_0_BOTS",
		"MPUI_1_BOTS",
		"MPUI_2_BOTS",
		"MPUI_3_BOTS",
		"MPUI_4_BOTS",
		"MPUI_5_BOTS",
		"MPUI_6_BOTS",
		"MPUI_7_BOTS",
		"MPUI_8_BOTS",
		"MPUI_9_BOTS",
		"MPUI_10_BOTS"
	}
	local f5_local1 = {
		0,
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10
	}
	for f5_local2 = 1, #f5_local0, 1 do
		f5_arg0:addChoice(f5_arg2, Engine.Localize(f5_local0[f5_local2]), f5_local1[f5_local2], {
			otherButton = f5_arg1
		}, CoD.EditGameOptions.Button_Bot_SelectionChanged)
	end
end

local f0_local3 = function (f6_arg0, f6_arg1)
	f6_arg0:addChoice(f6_arg1, Engine.Localize("MENU_BASICTRAINING_EASY_CAPS"), 0)
	f6_arg0:addChoice(f6_arg1, Engine.Localize("MENU_BASICTRAINING_NORMAL_CAPS"), 1)
	f6_arg0:addChoice(f6_arg1, Engine.Localize("MENU_BASICTRAINING_HARD_CAPS"), 2)
	f6_arg0:addChoice(f6_arg1, Engine.Localize("MENU_BASICTRAINING_FU_CAPS"), 3)
end

local f0_local4 = function (f7_arg0, f7_arg1)
	f7_arg0:addChoice(f7_arg1, Engine.Localize("MENU_DISABLED_CAPS"), 0)
	f7_arg0:addChoice(f7_arg1, Engine.Localize("MENU_ENABLED_CAPS"), 1)
end

local f0_local5 = function (f8_arg0, f8_arg1)
	f8_arg0:addBackButton()
	f8_arg0:registerEventHandler("button_prompt_back", EditGameOptions_ButtonPromptBack)
	body.leftPane = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 600,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		alphaMultiplier = 1
	})
	body:addElement(body.leftPane)
	body.buttonList = CoD.ButtonList.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	body.leftPane:addElement(body.buttonList)
	f8_arg0.body.timeLimitButton = f8_arg0.body.buttonList:addDvarLeftRightSelector(f8_arg1, Engine.Localize("MPUI_RULES_TIME_LIMIT_CAPS"), "custom_timelimit")
	f0_local0(f8_arg0.body.timeLimitButton, f8_arg1)
	f8_arg0.body.scoreLimitButton = f8_arg0.body.buttonList:addDvarLeftRightSelector(f8_arg1, Engine.Localize("MPUI_RULES_SCORE_LIMIT_CAPS"), "custom_scorelimit")
	f0_local1(f8_arg0.body.scoreLimitButton, f8_arg1)
	f8_arg0.body.friendsButton = f8_arg0.body.buttonList:addDvarLeftRightSelector(f8_arg1, Engine.Localize("MPUI_FRIENDLY_PRACTICE_DUMMIES_CAPS"), "bot_friends")
	f8_arg0.body.enemiesButton = f8_arg0.body.buttonList:addDvarLeftRightSelector(f8_arg1, Engine.Localize("MPUI_ENEMY_PRACTICE_DUMMIES_CAPS"), "bot_enemies")
	f0_local2(f8_arg0.body.friendsButton, f8_arg0.body.enemiesButton, f8_arg1)
	f0_local2(f8_arg0.body.enemiesButton, f8_arg0.body.friendsButton, f8_arg1)
	f8_arg0.body.difficultyButton = f8_arg0.body.buttonList:addDvarLeftRightSelector(f8_arg1, Engine.Localize("MENU_BASICTRAINING_DIFFICULTY_CAPS"), "bot_difficulty")
	f0_local3(f8_arg0.body.difficultyButton, f8_arg1)
	f8_arg0.body.demoRecording = f8_arg0.body.buttonList:addDvarLeftRightSelector(f8_arg1, Engine.Localize("CUSTOM_GAME_RECORDING_CAPS"), "demo_recordPrivateMatch")
	f0_local4(f8_arg0.body.demoRecording, f8_arg1)
	local f8_local0 = 0 + 20
	f8_arg0.hintText = LUI.UIText.new({
		left = 0,
		top = f8_local0,
		right = 0,
		bottom = f8_local0 + CoD.textSize.Default,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		font = CoD.fonts.Default
	})
	body.leftPane:addElement(f8_arg0.hintText)
	body.buttonList:processEvent({
		name = "gain_focus"
	})
end

LUI.createMenu.EditGameOptions = function (f9_arg0)
	local f9_local0 = CoD.Menu.New("EditGameOptions")
	f9_local0.m_ownerController = f9_arg0
	f9_local0.close = CoD.EditGameOptions.Close
	f0_local5(f9_local0, f9_arg0)
	Engine.Exec(f9_arg0, "beginCustomGametypeChanges")
	return f9_local0
end

