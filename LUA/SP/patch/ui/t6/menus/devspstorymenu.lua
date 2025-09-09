CoD.DevSPStoryMenu = {}
CoD.DevSPStoryMenu.SelectionChanged = function (f1_arg0, f1_arg1)
	Engine.Exec(f1_arg0.controller, "setStoryStatDDL " .. f1_arg0.storyText .. " " .. f1_arg0.value)
end

CoD.DevSPStoryMenu.AddChoice = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = CoD.DevSPStoryMenu.SelectionChanged
	f2_arg1:addChoice(Engine.Localize("MENU_OFF_CAPS"), f2_local0, {
		controller = f2_arg0,
		storyText = f2_arg2,
		value = 0
	})
	f2_arg1:addChoice(Engine.Localize("MENU_ON_CAPS"), f2_local0, {
		controller = f2_arg0,
		storyText = f2_arg2,
		value = 1
	})
end

CoD.DevSPStoryMenu.CreateStoryOption = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg0.buttonList:addLeftRightSelector(f3_arg1, UIExpression.GetDStat(f3_arg0.controller, "PlayerCareerStats", "storypoints", f3_arg1), 400)
	CoD.DevSPStoryMenu.AddChoice(f3_arg0.controller, f3_local0, f3_arg1)
	table.insert(f3_arg0.buttonListTable, f3_local0)
end

LUI.createMenu.DevSPStoryMenu = function (f4_arg0)
	local f4_local0 = CoD.Menu.New("DevSPStoryMenu")
	f4_local0:addTitle("DEV STORY ELEMENTS", LUI.Alignment.Center)
	f4_local0:setPreviousMenu("MissionSelectMenu")
	f4_local0:addBackButton()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, CoD.Menu.TitleHeight, -CoD.ButtonPrompt.Height)
	f4_local0:addElement(Widget)
	local f4_local2 = CoD.Menu.TitleHeight + 15
	local f4_local3 = CoD.MFTabManager.new(Widget, {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f4_local2,
		bottom = f4_local2 + CoD.MFTabManager.TabHeight
	}, nil, CoD.trueOrange)
	f4_local3:setTabAlignment(LUI.Alignment.Center)
	f4_local3:setTabSpacing(80)
	f4_local0:addElement(f4_local3)
	f4_local3:addTab(f4_arg0, "CAMPAIGN PT 1 LEVELS", CoD.DevSPStoryMenu.CreateCampaignPT1LevelsTab)
	f4_local3:addTab(f4_arg0, "CAMPAIGN PT 2 LEVELS", CoD.DevSPStoryMenu.CreateCampaignPT2LevelsTab)
	f4_local3:addTab(f4_arg0, "RTS/WAR LEVELS", CoD.DevSPStoryMenu.CreateRTSWARLevelsTab)
	f4_local3:refreshTab(f4_arg0)
	return f4_local0
end

CoD.DevSPStoryMenu.CreateCampaignPT1LevelsTab = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	local f5_local1 = 500
	Widget.buttonList = CoD.ButtonList.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f5_local1 / 2,
		right = f5_local1 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = 90,
		bottom = 500 + 90
	})
	Widget:addElement(Widget.buttonList)
	Widget.buttonListTable = {}
	Widget.controller = InstanceRef
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "HARPER_SCARRED")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "KARMA_DEAD_IN_KARMA")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "KARMA_CAPTURED")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "DEFALCO_DEAD_IN_KARMA")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "FOUND_NICARAGUA_EASTEREGG")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "ALL_PAKISTAN_RECORDINGS")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "KRAVCHENKO_INTERROGATED")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "MASON_SR_DEAD")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "CHINA_IS_ALLY")
	Widget.buttonListTable[1]:processEvent({
		name = "gain_focus"
	})
	return Widget
end

CoD.DevSPStoryMenu.CreateCampaignPT2LevelsTab = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setUseStencil(true)
	local f6_local1 = 500
	Widget.buttonList = CoD.ButtonList.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f6_local1 / 2,
		right = f6_local1 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = 90,
		bottom = 500 + 90
	})
	Widget:addElement(Widget.buttonList)
	Widget.buttonListTable = {}
	Widget.controller = InstanceRef
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "HARPER_DEAD_IN_YEMEN")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "FARID_DEAD_IN_YEMEN")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "BRIGGS_DEAD")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "FARID_DEAD_IN_COMMAND_CENTER")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "KARMA_DEAD_IN_COMMAND_CENTER")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "DEFALCO_DEAD_IN_COMMAND_CENTER")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "G20_LEADERS_SAVED")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "DEFALCO_DEAD_IN_HAITI")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "MASONJR_DEAD_IN_HAITI")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "MENENDEZ_DEAD_IN_HAITI")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "MENENDEZ_CAPTURED")
	Widget.buttonListTable[1]:processEvent({
		name = "gain_focus"
	})
	return Widget
end

CoD.DevSPStoryMenu.CreateRTSWARLevelsTab = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	local f7_local1 = 500
	Widget.buttonList = CoD.ButtonList.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f7_local1 / 2,
		right = f7_local1 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = 90,
		bottom = 500 + 90
	})
	Widget:addElement(Widget.buttonList)
	Widget.buttonListTable = {}
	Widget.controller = InstanceRef
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_SINGAPORE_INTRO")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_SINGAPORE_SUCCESS")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_CARRIER_INTRO")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_CARRIER_SUCCESS")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_AFGHANISTAN_INTRO")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_AFGHANISTAN_SUCCESS")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_DRONE_INTRO")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_DRONE_SUCCESS")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_SOCOTRA_INTRO")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_SOCOTRA_SUCCESS")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_PAKISTAN_SUCCESS")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_HUB_ONE_INTRO")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_HUB_TWO_INTRO")
	CoD.DevSPStoryMenu.CreateStoryOption(Widget, "SO_WAR_HUB_THREE_INTRO")
	Widget.buttonListTable[1]:processEvent({
		name = "gain_focus"
	})
	return Widget
end

