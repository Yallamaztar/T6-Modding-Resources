require("T6.Menus.ConfirmResumeGame")
require("T6.Menus.ConfirmOverwritePopup")
require("T6.Menus.ConfirmNoProfilePopup")
require("T6.Menus.ConfirmNoSaveDevicePopup")
require("T6.Menus.MissionSelectFirstTimePopup")
require("T6.Error")
if CoD.isWIIU then
	require("T6.WiiUControllerSettings")
end
CoD.Campaign = {}
CoD.CmMenu = {}
CoD.Campaign.ResumeGame = function (f1_arg0, f1_arg1)
	if UIExpression.DvarBool(nil, "sv_saveGameAvailable") == 1 then
		f1_arg0:openMenu("ConfirmResumeGame", f1_arg1.controller)
		f1_arg0:close()
	elseif UIExpression.DvarBool(nil, "sv_saveGameAvailable") == 0 and UIExpression.DvarBool(nil, "sv_saveGameNotReadable") == 1 then
		local f1_local0 = f1_arg0:openPopup("Error", f1_arg1.controller)
		f1_local0:setMessage(Engine.Localize("MENU_SAVE_CORRUPTED"))
		f1_local0:setPreviousMenu(f1_arg0.previousMenuName)
		f1_arg0:close()
	end
end

CoD.Campaign.NewGame = function (f2_arg0, f2_arg1)
	if UIExpression.IsProfileSignedIn(f2_arg1.controller) == 1 and UIExpression.DvarBool(nil, "sv_saveDeviceAvailable") == 0 then
		f2_arg0:openMenu("ConfirmNoSaveDevicePopup", f2_arg1.controller)
	elseif UIExpression.IsProfileSignedIn(f2_arg1.controller) == 0 then
		f2_arg0:openMenu("ConfirmNoProfilePopup", f2_arg1.controller, {
			nextMenuName = "DifficultyMenu",
			messageText = "MENU_CONFIRMNOPROFILE_Q_CAPS"
		})
	elseif UIExpression.IsProfileSignedIn(f2_arg1.controller) == 1 and UIExpression.DvarBool(nil, "sv_saveDeviceAvailable") == 1 then
		if UIExpression.DvarBool(nil, "sv_saveGameAvailable") == 1 or UIExpression.DvarBool(nil, "sv_saveGameNotReadable") == 1 then
			f2_arg0:openMenu("ConfirmOverwritePopup", f2_arg1.controller)
		elseif UIExpression.DvarBool(nil, "sv_saveGameAvailable") == 0 and UIExpression.DvarBool(nil, "sv_saveGameNotReadable") == 0 then
			f2_arg0:openMenu("DifficultyMenu", f2_arg1.controller)
			Dvar.ui_campaignstate:set(1)
			Engine.ExecNow(f2_arg1.controller, "new_campaign")
		end
	end
	f2_arg0:close()
end

CoD.Campaign.MissionSelect = function (f3_arg0, f3_arg1)
	if UIExpression.ProfileInt(controller, "com_first_time_mission_select") == 1 then
		f3_arg0:openMenu("MissionSelectFirstTimePopup", f3_arg1.controller)
	else
		f3_arg0:openMenu("MissionSelectMenu", f3_arg1.controller)
	end
	f3_arg0:close()
end

CoD.Campaign.Controls = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0:openMenu("WiiUControllerSettings", f4_arg1.controller, true)
	f4_local0:setPreviousMenu("CampaignMenu")
	f4_arg0:close()
end

CoD.Campaign.Options = function (f5_arg0, f5_arg1)
	if UIExpression.IsProfileSignedIn(f5_arg1.controller) == 0 then
		f5_arg0:openMenu("ConfirmNoProfilePopup", f5_arg1.controller, {
			nextMenuName = "OptionsMenu",
			messageText = "MENU_PROFILE_WARNING"
		})
	else
		if LUI.savedMenuStates.Menu.OptionsMenu then
			LUI.savedMenuStates.Menu.OptionsMenu = nil
		end
		f5_arg0:openMenu("OptionsMenu", f5_arg1.controller)
	end
	f5_arg0:close()
end

CoD.Campaign.UpdateCharacters = function (f6_arg0)
	local f6_local0 = "sp/characterLookup.csv"
	if CoD.Campaign.Characters == nil then
		CoD.Campaign.Characters = {}
		local f6_local1 = UIExpression.TableLookup(f6_arg0, f6_local0, 0, "maxnum_char", 1)
		for f6_local2 = 1, f6_local1, 1 do
			local f6_local5 = UIExpression.TableLookup(f6_arg0, f6_local0, 0, f6_local2 - 1, 1)
			CoD.Campaign.Characters[f6_local5] = {}
			CoD.Campaign.Characters[f6_local5].characterID = UIExpression.TableLookup(f6_arg0, f6_local0, 1, f6_local5, 2)
			CoD.Campaign.Characters[f6_local5].characterAge = UIExpression.TableLookup(f6_arg0, f6_local0, 1, f6_local5, 3)
			CoD.Campaign.Characters[f6_local5].characterEyeColor = UIExpression.TableLookup(f6_arg0, f6_local0, 1, f6_local5, 4)
			CoD.Campaign.Characters[f6_local5].characterHairColor = UIExpression.TableLookup(f6_arg0, f6_local0, 1, f6_local5, 5)
			CoD.Campaign.Characters[f6_local5].characterImage = RegisterMaterial(UIExpression.TableLookup(f6_arg0, f6_local0, 1, f6_local5, 6))
			CoD.Campaign.Characters[f6_local5].characterImageSide = RegisterMaterial(UIExpression.TableLookup(f6_arg0, f6_local0, 1, f6_local5, 6) .. "_side")
		end
	end
end

CoD.Campaign.UpdateMissionBriefingInfo = function (f7_arg0)
	local f7_local0 = "sp/levelLookup.csv"
	if CoD.Campaign.MissionBriefingInfo == nil then
		CoD.Campaign.MissionBriefingInfo = {}
		local f7_local1 = UIExpression.TableLookup(f7_arg0, f7_local0, 0, "map_count", 1)
		for f7_local2 = 1, f7_local1, 1 do
			local f7_local5 = UIExpression.TableLookup(f7_arg0, f7_local0, 0, f7_local2, 2)
			if CoD.Campaign.MissionBriefingInfo[f7_local5] == nil then
				CoD.Campaign.MissionBriefingInfo[f7_local5] = {}
				CoD.Campaign.MissionBriefingInfo[f7_local5].missionDate = UIExpression.TableLookup(f7_arg0, f7_local0, 0, f7_local2, 5)
				CoD.Campaign.MissionBriefingInfo[f7_local5].missionTOD = UIExpression.TableLookup(f7_arg0, f7_local0, 0, f7_local2, 6)
				CoD.Campaign.MissionBriefingInfo[f7_local5].missionWeather = UIExpression.TableLookup(f7_arg0, f7_local0, 0, f7_local2, 7)
				CoD.Campaign.MissionBriefingInfo[f7_local5].missionDesc = UIExpression.TableLookup(f7_arg0, f7_local0, 0, f7_local2, 9) .. "_DESC"
			end
		end
	end
end

CoD.Campaign.AddSelectLevel = function (f8_arg0, f8_arg1)
	local f8_local0 = CoD.NavButton.new(nil, Engine.Localize("MENU_MISSION_SELECT_CAPS"), "mission_select")
	f8_local0:setupCarouselMode()
	f8_arg0.carousel:addItem(f8_local0)
	f8_arg0.leftButtonPromptBar:removeElement(f8_arg0.toggleDevLevels)
	f8_arg0.toggleDevLevels = nil
end

CoD.Campaign.SaveGameStateChange = function (f9_arg0, f9_arg1)
	f9_arg0:openMenu("CampaignMenu", f9_arg1.controller)
	f9_arg0:close()
end

CoD.Campaign.ButtonPromptBack = function (f10_arg0, f10_arg1)
	Engine.SendMenuResponse(f10_arg1.controller, "luisystem", "cm_stop")
	CoD.Menu.ButtonPromptBack(f10_arg0, f10_arg1)
	f10_arg0:close()
end

CoD.Campaign.CmActivate = function (f11_arg0, f11_arg1)
	f11_arg0:openMenu("CmMenu")
	f11_arg0:close()
end

CoD.Campaign.ButtonPromptFriendsMenu = function (f12_arg0, f12_arg1)
	if not CoD.isPS3 or UIExpression.IsSubUser(f12_arg1.controller) ~= 1 then
		f12_arg0:openMenu("FriendsList", f12_arg1.controller, {
			previousMenu = "CampaignMenu"
		})
		f12_arg0:close()
	end
end

LUI.createMenu.CampaignMenu = function (f13_arg0)
	local f13_local0 = CoD.Menu.New("CampaignMenu")
	f13_local0:addTitle(Engine.Localize("MENU_SINGLEPLAYER_CAPS"), LUI.Alignment.Center)
	f13_local0:setPreviousMenu("MainMenu")
	f13_local0:registerEventHandler("resume_game", CoD.Campaign.ResumeGame)
	f13_local0:registerEventHandler("new_game", CoD.Campaign.NewGame)
	f13_local0:registerEventHandler("mission_select", CoD.Campaign.MissionSelect)
	f13_local0:registerEventHandler("open_controls", CoD.Campaign.Controls)
	f13_local0:registerEventHandler("open_options", CoD.Campaign.Options)
	f13_local0:registerEventHandler("button_prompt_addSelectLevel", CoD.Campaign.AddSelectLevel)
	f13_local0:registerEventHandler("savegame_state_change", CoD.Campaign.SaveGameStateChange)
	f13_local0:registerEventHandler("button_prompt_back", CoD.Campaign.ButtonPromptBack)
	f13_local0:registerEventHandler("cm_activate", CoD.Campaign.CmActivate)
	Engine.SendMenuResponse(f13_arg0, "luisystem", "cm_start")
	f13_local0:addSelectButton()
	f13_local0:addBackButton()
	if CoD.isWIIU then
		f13_local0:registerEventHandler("button_prompt_friends", CoD.Campaign.ButtonPromptFriendsMenu)
		f13_local0:addFriendsButtonSPMainMenu()
	end
	local f13_local1
	if not (UIExpression.DvarBool(nil, "sv_saveGameAvailable") == 1 or UIExpression.DvarBool(nil, "sv_saveGameNotReadable") == 1) or UIExpression.IsProfileSignedIn(f13_arg0) ~= 1 then
		f13_local1 = false
	else
		f13_local1 = true
	end
	local f13_local2 = UIExpression.DvarBool(nil, "sv_saveGameAvailable")
	local f13_local3 = UIExpression.DvarBool(nil, "sv_saveGameNotReadable")
	local f13_local4 = UIExpression.GetDStat(f13_arg0, "PlayerStatsList", "HIGHESTLEVELCOMPLETED", "personalBest") ~= 0
	local f13_local5 = UIExpression.GetDStat(f13_arg0, "PlayerStatsList", "HIGHESTLEVELCOMPLETED", "StatValue")
	local f13_local6 = tonumber(UIExpression.TableLookup(f13_arg0, "sp/levelLookup.csv", 0, "maxnum_map", 1))
	if CoD.isPC then
		local f13_local7 = 2
		local f13_local8 = 50
		local f13_local9 = 30
		local f13_local10 = 300
		local f13_local11 = f13_local7 * (f13_local8 + f13_local9) - f13_local9
		local f13_local12 = CoD.ButtonList.new()
		f13_local12:setLeftRight(false, false, -f13_local10 / 2, f13_local10 / 2)
		f13_local12:setSpacing(f13_local9)
		f13_local0:addElement(f13_local12)
		local f13_local13 = nil
		if f13_local1 == true and f13_local5 < f13_local6 then
			f13_local13 = f13_local12:addNavButton(Engine.Localize("MENU_RESUMESTORY_CAPS"), "resume_game")
			f13_local7 = f13_local7 + 1
		end
		local f13_local14 = nil
		if f13_local4 == true then
			f13_local14 = f13_local12:addNavButton(Engine.Localize("MENU_MISSION_SELECT_CAPS"), "mission_select")
			f13_local7 = f13_local7 + 1
		end
		local f13_local15 = f13_local12:addNavButton(Engine.Localize("MENU_NEWGAME_CAPS"), "new_game")
		local f13_local16 = f13_local12:addNavButton(Engine.Localize("MENU_OPTIONS_CAPS"), "open_options")
		f13_local11 = f13_local7 * (f13_local8 + f13_local9) - f13_local9
		f13_local12:setTopBottom(false, false, -f13_local11 / 2, f13_local11 / 2 + 100)
		if f13_local13 then
			f13_local13:processEvent({
				name = "gain_focus"
			})
		else
			f13_local15:processEvent({
				name = "gain_focus"
			})
		end
	else
		local f13_local7 = 0
		local f13_local8 = f13_local0.width
		local f13_local9 = f13_local0.height - CoD.Menu.TitleHeight
		local f13_local10 = CoD.VerticalCarousel.new({
			left = -f13_local8 / 2,
			right = f13_local8 / 2,
			leftAnchor = false,
			rightAnchor = false,
			top = -(f13_local9 / 2) + f13_local7,
			bottom = f13_local9 / 2 + f13_local7,
			topAnchor = false,
			bottomAnchor = false
		}, 200, 50, 30, 1.2, CoD.MainMenu.CarouselScrollTime)
		f13_local0:addElement(f13_local10)
		if f13_local1 == true and f13_local5 < f13_local6 then
			local f13_local11 = CoD.NavButton.new(nil, Engine.Localize("MENU_RESUMESTORY_CAPS"), "resume_game")
			f13_local11:setupCarouselMode()
			f13_local10:addItem(f13_local11)
		end
		if f13_local4 == true then
			local f13_local11 = CoD.NavButton.new(nil, Engine.Localize("MENU_MISSION_SELECT_CAPS"), "mission_select")
			f13_local11:setupCarouselMode()
			f13_local10:addItem(f13_local11)
		end
		local f13_local11 = CoD.NavButton.new(nil, Engine.Localize("MENU_NEWGAME_CAPS"), "new_game")
		f13_local11:setupCarouselMode()
		f13_local10:addItem(f13_local11)
		if CoD.isWIIU then
			local f13_local12 = CoD.NavButton.new(nil, Engine.Localize("MENU_CONTROLLER_SETTINGS_CAPS"), "open_controls")
			f13_local12:setupCarouselMode()
			f13_local10:addItem(f13_local12)
		end
		local f13_local12 = CoD.NavButton.new(nil, Engine.Localize("MENU_OPTIONS_CAPS"), "open_options")
		f13_local12:setupCarouselMode()
		f13_local10:addItem(f13_local12)
		if f13_local1 == true or not f13_local4 == true then
			f13_local10:setStartItem(1)
		else
			f13_local10:setStartItem(2)
		end
		f13_local0.carousel = f13_local10
	end
	CoD.Campaign.UpdateCharacters(f13_arg0)
	CoD.Campaign.UpdateMissionBriefingInfo(f13_arg0)
	return f13_local0
end

CoD.CmMenu.SetLevel = function (f14_arg0, f14_arg1)
	Engine.Exec(f14_arg1.controller, "sethighestlevelcomplete " .. f14_arg1.button.levelIndex)
	Engine.Exec(f14_arg1.controller, "savegame")
	Engine.Exec(f14_arg1.controller, "savestats")
	CoD.Menu.ButtonPromptBack(f14_arg0, f14_arg1)
	f14_arg0:close()
end

LUI.createMenu.CmMenu = function (f15_arg0)
	local f15_local0 = CoD.Menu.New("CmMenu")
	f15_local0:addTitle("", LUI.Alignment.Center)
	f15_local0:setPreviousMenu("CampaignMenu")
	f15_local0:registerEventHandler("set_level", CoD.CmMenu.SetLevel)
	f15_local0:addSelectButton()
	f15_local0:addBackButton()
	local f15_local1 = CoD.VerticalCarousel.new({
		left = -150,
		right = 150,
		leftAnchor = false,
		rightAnchor = false,
		top = -360,
		bottom = 360,
		topAnchor = false,
		bottomAnchor = false
	}, 200, 50, 30, 1.2, 0)
	f15_local0:addElement(f15_local1)
	local f15_local2 = UIExpression.TableLookup(f15_arg0, CoD.AARUtility.LevelTable, 0, "map_count", 1)
	if f15_local2 == nil or tonumber(f15_local2) == nil or tonumber(f15_local2) < 0 then
		return 
	end
	f15_local2 = tonumber(f15_local2)
	local f15_local3 = 1
	while f15_local3 <= f15_local2 do
		if UIExpression.TableLookup(f15_arg0, CoD.AARUtility.LevelTable, 0, f15_local3 .. "", 8) == "CMP" then
			local f15_local4 = CoD.NavButton.new(nil, Engine.Localize("MENU_" .. UIExpression.TableLookup(f15_arg0, CoD.AARUtility.LevelTable, 0, f15_local3 .. "", 1)), "set_level")
			f15_local4.levelIndex = f15_local3 - 1
			f15_local4:setupCarouselMode()
			f15_local1:addItem(f15_local4)
		end
		f15_local1:setStartItem(1)
		f15_local3 = f15_local3 + 1
	end
	return f15_local0
end

