require("T6.CACClassLoadout")
require("T6.SideBrackets")
require("T6.Menus.MissionBriefingCharacterPanel")
CoD.MissionBriefing = {}
CoD.MissionBriefing.MenuHeight = 512
CoD.MissionBriefing.LoadDefault = true
CoD.MissionBriefing.BriefingWidth = 450
CoD.MissionBriefing.ImageWidth = 800
CoD.MissionBriefing.lastMapName = ""
CoD.MissionBriefing.CustomizeLoadout = function (f1_arg0, f1_arg1)
	Engine.PlaySound("uin_main_enter")
	CoD.MissionBriefing.LoadDefault = false
	CoD.CACClassLoadout.PreviousSelection = ""
	CoD.CACLoadOutMenu.AnimateLoadout = true
	f1_arg0:swapMenu("CACLoadOutMenu", f1_arg1.controller)
	f1_arg0:close()
end

CoD.MissionBriefing.LaunchLevel = function (f2_arg0, f2_arg1)
	CoD.MissionBriefing.LoadDefault = true
	local f2_local0 = CoD.GetClassItem(f2_arg1.controller, CoD.perController[f2_arg1.controller].classNumInternal, CoD.CACUtility.loadoutSlotNames.primaryWeapon)
	if f2_local0 == nil or f2_local0 == 0 then
		return 
	end
	Dvar.ui_isrtstutorial:set(0)
	local f2_local1 = Dvar.ui_mapname:get()
	if f2_local1 == nil then
		f2_local1 = CoD.LEVEL_FIRST
	end
	Dvar.ui_aarmapname:set(f2_local1)
	Engine.Exec(f2_arg1.controller, "launchlevel " .. f2_local1)
end

CoD.MissionBriefing.OpenCombatRecord = function (f3_arg0, f3_arg1)
	CoD.MissionBriefing.LoadDefault = false
	CoD.CareerOverviewMenu.MapHighlight = Dvar.ui_aarmapname:get()
	CoD.StoryOverviewMenu.MapHighlight = CoD.CareerOverviewMenu.MapHighlight
	Engine.PlaySound(CoD.MissionSelect.CareerRecordActionSFX)
	f3_arg0:swapMenu("CareerOverviewMenu", f3_arg1.controller, {
		previousMenu = "MissionBriefingMenu"
	})
	f3_arg0:close()
end

CoD.MissionBriefing.ButtonPromptFriendsMenu = function (f4_arg0, f4_arg1)
	if not CoD.isPS3 or UIExpression.IsSubUser(f4_arg1.controller) ~= 1 then
		f4_arg0:openMenu("FriendsList", f4_arg1.controller, {
			previousMenu = "MissionBriefingMenu"
		})
		f4_arg0:close()
	end
end

LUI.createMenu.MissionBriefingMenu = function (f5_arg0)
	local f5_local0 = CoD.Menu.New("MissionBriefingMenu")
	if Dvar.ui_campaignstate:get() ~= 0 then
		f5_local0:setPreviousMenu("CampaignMenu")
	else
		f5_local0:setPreviousMenu("DifficultyMenu")
	end
	f5_local0:addTitle(Engine.Localize("SPUI_MISSION_BRIEFING_CAPS"), LUI.Alignment.Center)
	f5_local0:registerEventHandler("button_prompt_launch_game", CoD.MissionBriefing.LaunchLevel)
	f5_local0:registerEventHandler("button_customize_loadout", CoD.MissionBriefing.CustomizeLoadout)
	f5_local0:registerEventHandler("button_combat_record", CoD.MissionBriefing.OpenCombatRecord)
	f5_local0.startMission = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_START_LEVEL"), f5_local0, "button_prompt_launch_game")
	f5_local0:addLeftButtonPrompt(f5_local0.startMission)
	f5_local0:addBackButton()
	local f5_local1 = CoD.ButtonPrompt.new
	local f5_local2 = "alt1"
	local f5_local3 = Engine.Localize("SPUI_CAREER_RECORD")
	local f5_local4 = f5_local0
	local Widget = "button_combat_record"
	local f5_local6, f5_local7 = false
	local f5_local8, f5_local9 = false
	f5_local0.openCombatRecordPrompt = f5_local1(f5_local2, f5_local3, f5_local4, Widget, f5_local6, f5_local7, f5_local8, f5_local9, "R")
	f5_local0:addLeftButtonPrompt(f5_local0.openCombatRecordPrompt)
	f5_local1 = CoD.ButtonPrompt.new
	f5_local2 = "alt2"
	f5_local3 = Engine.Localize("MENU_CUSTOMIZE_LOADOUT")
	f5_local4 = f5_local0
	Widget = "button_customize_loadout"
	f5_local6, f5_local7 = false
	f5_local8, f5_local9 = false
	f5_local0.customizeLoadout = f5_local1(f5_local2, f5_local3, f5_local4, Widget, f5_local6, f5_local7, f5_local8, f5_local9, "C")
	f5_local0:addRightButtonPrompt(f5_local0.customizeLoadout)
	if CoD.isWIIU then
		f5_local0:registerEventHandler("button_prompt_friends", CoD.MissionBriefing.ButtonPromptFriendsMenu)
		f5_local0:addFriendsButtonSPMainMenu()
	end
	if CoD.Campaign.MissionBriefingInfo == nil then
		CoD.Campaign.UpdateMissionBriefingInfo(f5_arg0)
	end
	if CoD.Campaign.Characters == nil then
		CoD.Campaign.UpdateCharacters(f5_arg0)
	end
	f5_local1 = Dvar.ui_mapname:get()
	f5_local0.mapAlias = UIExpression.TableLookup(f5_arg0, CoD.AARUtility.LevelTable, 1, f5_local1, 2)
	f5_local2 = UIExpression.TableLookup(f5_arg0, CoD.AARUtility.LevelTable, 1, f5_local1, 4)
	f5_local3 = CoD.MissionBriefing.BriefingWidth
	f5_local4 = 460
	Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f5_local3)
	Widget:setTopBottom(true, false, CoD.CACUtility.TopAnchor, CoD.CACUtility.TopAnchor + f5_local4)
	f5_local0:addElement(Widget)
	f5_local6 = 460
	f5_local7 = 0.12
	f5_local8 = RegisterMaterial("menu_visor_mid_bracket")
	f5_local9 = 10
	CoD.MissionBriefing.MapInfo(Widget, f5_local1, f5_local0.mapAlias)
	CoD.MissionBriefing.MissionInfo(Widget, f5_local0.mapAlias)
	Widget:addElement(CoD.MissionBriefingCharacterPanel.new(f5_local2))
	if f5_arg0 == nil then
		f5_arg0 = UIExpression.GetPrimaryController()
	end
	local f5_local10 = CoD.CACClassLoadout.new(f5_arg0, true)
	f5_local10.m_inputDisabled = true
	f5_local0:addElement(f5_local10)
	f5_local10:dispatchEventToChildren({
		name = "animate",
		animationStateName = "hide_button_bracket"
	})
	f5_local0.loadoutUI = f5_local10
	if CoD.MissionBriefing.LoadDefault then
		CoD.MissionBriefing.SetToDefaultClass(f5_local0, f5_arg0)
	end
	CoD.MissionBriefing.lastMapName = f5_local0.mapAlias
	CoD.MissionBriefing.CheckNewItemsAvailable(f5_local0, f5_arg0)
	return f5_local0
end

CoD.MissionBriefing.CheckNewItemsAvailable = function (f6_arg0, f6_arg1)
	local f6_local0 = false
	local f6_local1 = false
	for f6_local5, f6_local6 in pairs(CoD.CACUtility.CommonWeapons) do
		if f6_local6.name and f6_local6.text and Engine.WeaponGroupHasNewItem(f6_arg1, f6_local6.name) then
			f6_local1 = true
			break
		end
	end
	if not f6_local1 then
		if UIExpression.TableLookup(nil, "sp/levelLookup.csv", 1, CoD.MissionBriefing.lastMapName, 3) then
			for f6_local6, f6_local7 in pairs(CoD.CACUtility.EightiesOnlyWeapons) do
				if f6_local7.name and f6_local7.text and Engine.WeaponGroupHasNewItem(f6_arg1, f6_local7.name) then
					f6_local1 = true
				end
			end
		else
			for f6_local6, f6_local7 in pairs(CoD.CACUtility.TwentiesOnlyWeapons) do
				if f6_local7.name and f6_local7.text and Engine.WeaponGroupHasNewItem(f6_arg1, f6_local7.name) then
					f6_local1 = true
					break
				end
			end
		end
	end
	f6_arg0.loadoutUI:setNewWeaponsAvailable(f6_local1)
	if not f6_local0 then
		f6_local0 = f6_local1
	end
	f6_local1 = false
	f6_local2 = {}
	LUI.ConcatenateToTable(f6_local2, Engine.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames.primaryGrenade))
	LUI.ConcatenateToTable(f6_local2, Engine.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames.specialGrenade))
	for f6_local6, f6_local7 in pairs(f6_local2) do
		if Engine.IsItemNew(f6_arg1, f6_local7) then
			f6_local1 = true
			break
		end
	end
	f6_arg0.loadoutUI:setNewEquipmentAvailable(f6_local1)
	if not f6_local0 then
		f6_local0 = f6_local1
	end
	f6_local1 = false
	f6_local3 = {}
	for f6_local4 = 1, CoD.CACUtility.maxSpecialtySlots, 1 do
		LUI.ConcatenateToTable(f6_local3, Engine.GetUnlockablesBySlotName(CoD.CACUtility.loadoutSlotNames["specialty" .. f6_local4]))
	end
	for f6_local7, f6_local8 in pairs(f6_local3) do
		if Engine.IsItemNew(f6_arg1, f6_local8) then
			f6_local1 = true
			break
		end
	end
	f6_arg0.loadoutUI:setNewPerksAvailable(f6_local1)
	if not f6_local0 then
		f6_local0 = f6_local1
	end
	if f6_arg0.customizeLoadout and f6_local0 and f6_arg0.customizeLoadout.label then
		f6_local4 = LUI.UIImage.new()
		f6_local4:setLeftRight(false, true, -CoD.CACUtility.ButtonGridNewImageWidth, 0)
		f6_local4:setTopBottom(false, false, -CoD.CACUtility.ButtonGridNewImageHeight / 2, CoD.CACUtility.ButtonGridNewImageHeight / 2)
		f6_local4:setImage(RegisterMaterial(CoD.CACUtility.NewImageMaterial))
		f6_local4:addElementAfter(f6_arg0.customizeLoadout)
	end
end

CoD.MissionBriefing.SetToDefaultClass = function (f7_arg0, f7_arg1)
	if f7_arg0.mapName == nil then
		f7_arg0.mapAlias = UIExpression.TableLookup(f7_arg1, CoD.AARUtility.LevelTable, 1, Dvar.ui_mapname:get(), 2)
	end
	CoD.perController[f7_arg1].classNumInternal = Engine.GetClassIndexFromName("custom_" .. f7_arg0.mapAlias)
	Engine.EquipCustomClassToSession(f7_arg1, CoD.perController[f7_arg1].classNumInternal)
	CoD.CACUtility.SetCurrentSPMapDefaults(f7_arg1, f7_arg0.mapAlias)
	f7_arg0.loadoutUI:update(f7_arg1)
end

CoD.MissionBriefing.FadeIn = function (f8_arg0)
	if f8_arg0 ~= nil then
		f8_arg0:beginAnimation("fade_in", 300)
		f8_arg0:setAlpha(1)
	end
end

CoD.MissionBriefing.MapInfo = function (f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = RegisterMaterial("menu_visor_ms_" .. f9_arg2)
	local f9_local1 = CoD.MissionBriefing.ImageWidth
	local f9_local2 = f9_local1 * 0.5
	local f9_local3 = -40
	local f9_local4 = 0
	local f9_local5 = LUI.UIStreamedImage.new()
	f9_local5:setLeftRight(false, false, -(f9_local1 / 2) + f9_local3, f9_local1 / 2 + f9_local3)
	f9_local5:setTopBottom(false, false, -(f9_local2 / 2) + f9_local4, f9_local2 / 2 + f9_local4)
	f9_local5:setImage(f9_local0)
	f9_local5:setAlpha(0)
	f9_local5:registerEventHandler("streamed_image_ready", CoD.MissionBriefing.FadeIn)
	f9_arg0:addElement(f9_local5)
	local f9_local6 = -5
	local f9_local7 = "Big"
	local f9_local8 = LUI.UIText.new()
	f9_local8:setLeftRight(true, true, 0, 0)
	f9_local8:setTopBottom(true, false, f9_local6, CoD.textSize[f9_local7] + f9_local6)
	f9_local8:setFont(CoD.fonts[f9_local7])
	f9_local8:setAlignment(LUI.Alignment.Center)
	f9_local8:setRGB(CoD.visorBlue1.r, CoD.visorBlue1.g, CoD.visorBlue1.b)
	f9_local8:setText(Engine.Localize("SPUI_" .. f9_arg2 .. "_MISSION_NAME"))
	f9_arg0:addElement(f9_local8)
	local f9_local9 = f9_local6 + CoD.textSize[f9_local7]
	local f9_local10 = "Condensed"
	local f9_local11 = LUI.UIText.new()
	f9_local11:setLeftRight(true, true, 0, 0)
	f9_local11:setTopBottom(true, false, f9_local9, CoD.textSize[f9_local10] + f9_local9)
	f9_local11:setFont(CoD.fonts[f9_local10])
	f9_local11:setAlignment(LUI.Alignment.Center)
	f9_arg0:addElement(f9_local11)
	if CoD.Campaign.MissionBriefingInfo and CoD.Campaign.MissionBriefingInfo[f9_arg2] then
		f9_local11:setText(Engine.Localize("SPUI_" .. f9_arg2 .. "_LOCATION") .. " " .. CoD.Campaign.MissionBriefingInfo[f9_arg2].missionDate)
	else
		DebugPrint("Mission Briefing Information was not loaded for this map which SHOULD NEVER HAPPEN")
		f9_local11:setText("")
	end
end

CoD.MissionBriefing.MissionInfo = function (f10_arg0, f10_arg1)
	local f10_local0 = "Condensed"
	local f10_local1 = 107
	local f10_local2 = LUI.UIText.new()
	f10_local2:setLeftRight(true, true, 0, 0)
	f10_local2:setTopBottom(false, true, -f10_local1, -f10_local1 + CoD.textSize[f10_local0])
	f10_local2:setFont(CoD.fonts[f10_local0])
	f10_local2:setText(Engine.Localize("SPUI_LEVEL_OBJECTIVE") .. ": " .. Engine.Localize("SPUI_" .. f10_arg1 .. "_OBJECTIVE"))
	f10_arg0:addElement(f10_local2)
end

