CoD.Difficulty = {}
CoD.Difficulty.DifficultySelection = function (f1_arg0, f1_arg1)
	local f1_local0 = f1_arg1.button
	if f1_arg0.isNewGame then
		Engine.SetProfileVar(f1_local0.m_ownerController, "g_gameskill", f1_local0.difficulty)
		Engine.Exec(f1_local0.m_ownerController, "updategamerprofile")
	else
		Dvar.ui_singlemission_difficulty:set(f1_local0.difficulty)
	end
	local f1_local1 = Dvar.ui_mapname:get()
	if CoD.MissionSelect.isRTSMapSelected then
		Engine.Exec(f1_local0.m_ownerController, "launchlevel " .. f1_local1)
		return 
	elseif f1_arg0.isNewGame then
		Engine.SendMenuResponse(f1_arg1.controller, "campaign_state", "start_difficulty")
	else
		CoD.MissionBriefing.LoadDefault = true
		CoD.CACLoadOutMenu.RestoreDefaults()
		local f1_local2 = f1_arg0:openMenu("MissionBriefingMenu", f1_arg1.controller)
	end
	f1_arg0:close()
end

CoD.Difficulty.AddDifficulty = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	local f2_local0 = CoD.NavButton.new(nil, Engine.Localize(f2_arg2), "difficulty_selection")
	f2_local0.difficulty = f2_arg1
	f2_local0.name = f2_arg2
	f2_local0.desc = f2_arg3
	f2_local0:setupCarouselMode()
	f2_arg0:addItem(f2_local0)
end

CoD.Difficulty.AddDifficultyToButtonList = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local f3_local0 = f3_arg0:addNavButton(Engine.Localize(f3_arg2), "difficulty_selection")
	f3_local0.difficulty = f3_arg1
	f3_local0.name = f3_arg2
	f3_local0.desc = f3_arg3
	return f3_local0
end

LUI.createMenu.DifficultyMenu = function (f4_arg0)
	local f4_local0 = CoD.Menu.New("DifficultyMenu")
	f4_local0:addTitle(Engine.Localize("MENU_SELECT_DIFFICULTY_CAPS"), LUI.Alignment.Center)
	if Dvar.ui_singlemission:get() ~= 0 then
		f4_local0.isNewGame = false
		f4_local0:setPreviousMenu("MissionSelectMenu")
	else
		f4_local0.isNewGame = true
		f4_local0:setPreviousMenu("CampaignMenu")
	end
	f4_local0:registerEventHandler("difficulty_selection", CoD.Difficulty.DifficultySelection)
	f4_local0:registerAnimationState("hide", {
		alpha = 0
	})
	f4_local0:addSelectButton()
	f4_local0:addBackButton()
	if CoD.isPC then
		local f4_local1 = 50
		local f4_local2 = 30
		local f4_local3 = 300
		local f4_local4 = 4 * (f4_local1 + f4_local2) - f4_local2
		local f4_local5 = CoD.ButtonList.new()
		f4_local5:setLeftRight(false, false, -f4_local3 / 2, f4_local3 / 2)
		f4_local5:setTopBottom(false, false, -f4_local4 / 2, f4_local4 / 2 + 100)
		f4_local5:setSpacing(f4_local2)
		f4_local0:addElement(f4_local5)
		local f4_local6 = {
			CoD.Difficulty.AddDifficultyToButtonList(f4_local5, 0, "MENU_RECRUIT_CAPS", "MENU_DIFF_RECRUIT_DESC"),
			CoD.Difficulty.AddDifficultyToButtonList(f4_local5, 1, "MENU_REGULAR_CAPS", "MENU_DIFF_REGULAR_DESC"),
			CoD.Difficulty.AddDifficultyToButtonList(f4_local5, 2, "MENU_HARDENED_CAPS", "MENU_DIFF_HARDENED_DESC"),
			CoD.Difficulty.AddDifficultyToButtonList(f4_local5, 3, "MENU_VETERAN_CAPS", "MENU_DIFF_VETERAN_DESC")
		}
		f4_local6[UIExpression.ProfileInt(f4_arg0, "g_gameskill") + 1]:processEvent({
			name = "gain_focus"
		})
	else
		local f4_local1 = 0
		local f4_local2 = f4_local0.width
		local f4_local3 = f4_local0.height - CoD.Menu.TitleHeight
		local f4_local4 = CoD.VerticalCarousel.new({
			left = -f4_local2 / 2,
			right = f4_local2 / 2,
			leftAnchor = false,
			rightAnchor = false,
			top = -(f4_local3 / 2) - f4_local1,
			bottom = f4_local3 / 2 - f4_local1,
			topAnchor = false,
			bottomAnchor = false
		}, 200, 50, 30, 1.2, CoD.MainMenu.CarouselScrollTime)
		f4_local0:addElement(f4_local4)
		CoD.Difficulty.AddDifficulty(f4_local4, 0, "MENU_RECRUIT_CAPS", "MENU_DIFF_RECRUIT_DESC")
		CoD.Difficulty.AddDifficulty(f4_local4, 1, "MENU_REGULAR_CAPS", "MENU_DIFF_REGULAR_DESC")
		CoD.Difficulty.AddDifficulty(f4_local4, 2, "MENU_HARDENED_CAPS", "MENU_DIFF_HARDENED_DESC")
		CoD.Difficulty.AddDifficulty(f4_local4, 3, "MENU_VETERAN_CAPS", "MENU_DIFF_VETERAN_DESC")
		f4_local4:setStartItem(UIExpression.ProfileInt(f4_arg0, "g_gameskill") + 1)
	end
	return f4_local0
end

