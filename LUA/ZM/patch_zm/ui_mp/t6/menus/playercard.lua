require("T6.CoD9Button")
require("T6.MFPopup")
require("T6.Leaderboard")
require("T6.Menus.ClanTag")
if CoD.isZombie == false then
	require("T6.Menus.CombatRecord")
end
CoD.PlayercardPopup = {}
local f0_local0, f0_local1 = nil
CoD.PlayercardPopup.Open = function (f1_arg0, f1_arg1)
	local f1_local0 = CoD.MFPopup.new(f1_arg0, nil, nil, Engine.Localize("MENU_BARRACKS_CAPS"))
	f1_local0:registerEventHandler("button_prompt_back", CoD.PlayercardPopup.buttonPressedBack)
	f1_local0.parent = f1_arg0
	f0_local0(f1_local0, f1_arg1)
	f1_local0:openPopup(nil, true)
end

local f0_local2 = function (f2_arg0)
	local f2_local0 = f2_arg0.panelManager
	f2_local0:closePanel("buttonPanel")
	f2_local0:closePanel("emblemDisplay")
	f2_local0:closePanel("xpBarPanel")
end

CoD.PlayercardPopup.Close = function (f3_arg0)
	f0_local2(f3_arg0)
	f3_arg0:closePopup(nil, true, nil, true)
	Engine.PartyHostClearUIState()
end

CoD.PlayercardPopup.buttonOpenLeaderboard = function (f4_arg0, f4_arg1)

end

f0_local0 = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.panelManager
	f5_arg0:addSelectButton()
	f5_arg0:addBackButton()
	local f5_local1 = f5_local0:createPanel("buttonPanel")
	f5_arg0.leftPane = f5_local1
	CoD.MFSlidePanelManager.AddPanelElements(f5_local1)
	
	local buttonList = CoD.ButtonList.new({
		left = CoD.CoD9Button.Height,
		top = CoD.CoD9Button.Height,
		right = CoD.ButtonList.DefaultWidth,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	})
	f5_local1:addElement(buttonList)
	f5_local1.buttonList = buttonList
	
	buttonList:addSpacer(CoD.CoD9Button.Height)
	f5_local1.buttons = {}
	local f5_local3 = f5_local1.buttons
	local f5_local4 = buttonList:addButton(Engine.Localize("MENU_EMBLEM_EDITOR_CAPS"))
	CoD.SetupButtonLock(f5_local4, f5_arg1, "FEATURE_EMBLEM", "MPUI_EMBLEM_EDITOR_DESC")
	f5_local3.editPlayercard = f5_local4
	local f5_local5 = buttonList:addButton(Engine.Localize("MPUI_CLAN_TAG_CAPS"))
	f5_local5.playercardMenu = f5_arg0
	CoD.SetupButtonLock(f5_local5, f5_arg1, "FEATURE_CLAN_TAG", "MPUI_CLAN_TAG_DESC", PlayercardPopup_ButtonPressed_ClanTag)
	f5_local3.clanTag = f5_local5
	buttonList:addSpacer(CoD.CoD9Button.Height / 2)
	local f5_local6 = buttonList:addButton(Engine.Localize("MENU_CHALLENGES_CAPS"), Engine.Localize("MPUI_CHALLENGES_DESC"))
	CoD.SetupButtonLock(f5_local6, f5_arg1, "FEATURE_CHALLENGES", "MPUI_CHALLENGES_DESC")
	f5_local3.challenges = f5_local6
	local f5_local7 = buttonList:addButton(Engine.Localize("MENU_COMBAT_RECORD_CAPS"))
	f5_local7.playercardMenu = f5_arg0
	CoD.SetupButtonLock(f5_local7, f5_arg1, "FEATURE_COMBAT_RECORD", "MPUI_COMBAT_RECORD_DESC", PlayercardPopup_ButtonPressed_CombatRecord)
	f5_local3.combatRecord = f5_local7
	local f5_local8 = buttonList:addButton(Engine.Localize("MPUI_LEADERBOARDS_CAPS"), Engine.Localize("MPUI_LEADERBOARDS_DESC"))
	f5_local3.leaderboards = f5_local8
	f5_local8:registerEventHandler("button_action", CoD.PlayercardPopup.buttonOpenLeaderboard)
	f5_local8.parent = f5_arg0
	buttonList:addSpacer(CoD.CoD9Button.Height / 2)
	f5_local3.fileShare = buttonList:addButton(Engine.Localize("MENU_FILESHARE_MYSHARE_CAPS"), Engine.Localize("MPUI_FILE_SHARE_DESC"))
	f5_local3.recentGames = buttonList:addButton(Engine.Localize("MENU_FILESHARE_MYRECENTGAMES_CAPS"), Engine.Localize("MPUI_MY_RECENT_GAMES_DESC"))
	f5_local3.community = buttonList:addButton(Engine.Localize("MENU_FILESHARE_COMMUNITY_CAPS"), Engine.Localize("MPUI_COMMUNITY_DESC"))
	buttonList:addSpacer(CoD.CoD9Button.Height / 2)
	local f5_local9 = UIExpression.GetStatByName(f5_arg1, "HASPRESTIGED")
	if CoD.PrestigeFinish(f5_arg1) == false and CoD.PrestigeAvail(f5_arg1) == true then
		local f5_local10 = buttonList:addButton(Engine.Localize("MPUI_PRESTIGE_MODE_CAPS"), Engine.Localize("MPUI_PRESTIGE_MODE_DESC"))
		if tonumber(f5_local9) == 0 then
			f5_local10:showNewIcon()
		end
		f5_local3.prestige = f5_local10
	elseif CoD.PrestigeFinish(f5_arg1) == false and CoD.PrestigeAvail(f5_arg1) == false then
		local f5_local10 = buttonList:addButton(Engine.Localize("MPUI_PRESTIGE_MODE_CAPS"), Engine.Localize("MPUI_DESC_PRESTIGE2"))
		f5_local10:lock()
		f5_local3.prestige = f5_local10
	else
		buttonList:addSpacer(CoD.CoD9Button.Height)
	end
	buttonList:addSpacer(CoD.CoD9Button.Height / 2)
	local f5_local10 = f5_local0:createPanel("emblemDisplay", "right")
	local f5_local11 = 300
	local f5_local12 = 300
	
	local emblem = LUI.UIImage.new({
		left = -f5_local11 / 2,
		top = -(f5_local12 / 2) - 50,
		right = f5_local11 / 2,
		bottom = f5_local12 / 2 - 50,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		material = RegisterMaterial("white"),
		alpha = 0.25
	})
	f5_local10:addElement(emblem)
	f5_local10.emblem = emblem
	
	local f5_local14 = f5_local0:createPanel("xpBarPanel", "bottom")
	if CoD.CanRankUp(f5_arg1) == true then
		local f5_local15 = 2
		local f5_local16 = 7
		local f5_local17 = 3
		local f5_local18 = UIExpression.GetDStat(f5_arg1, "PlayerStatsList", "RANK", "StatValue")
		local f5_local19 = UIExpression.GetDStat(f5_arg1, "PlayerStatsList", "PLEVEL", "StatValue")
		local f5_local20 = UIExpression.GetDStat(f5_arg1, "PlayerStatsList", "RANKXP", "StatValue")
		local f5_local21 = UIExpression.TableLookup(f5_arg1, CoD.rankTable, 0, f5_local18, f5_local15)
		local f5_local22 = UIExpression.TableLookup(f5_arg1, CoD.rankTable, 0, f5_local18, f5_local16)
		local f5_local23 = UIExpression.TableLookup(f5_arg1, CoD.rankTable, 0, f5_local18, f5_local17)
		local f5_local24 = UIExpression.LocString(f5_arg1, "MPUI_AAR_XP_NEEDED_CAPS", f5_local22 - f5_local20)
		local f5_local25 = UIExpression.TableLookup(f5_arg1, CoD.rankTable, 0, f5_local18 + 1, 14)
		local f5_local26 = {
			r = 0.42,
			g = 0.9,
			b = 0.46,
			a = 0.5
		}
		local f5_local27 = 600
		local f5_local28 = 20
		local f5_local29 = (f5_local20 - f5_local21) / f5_local23 * f5_local27
		local Widget = LUI.UIElement.new({
			left = 0,
			top = -(CoD.CoD9Button.Height * 3),
			right = 0,
			bottom = -CoD.CoD9Button.Height,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = true
		})
		f5_local14:addElement(Widget)
		f5_local14.xpBarBG = LUI.UIImage.new({
			left = -f5_local27 / 2,
			top = -f5_local28 / 2,
			bottom = f5_local28 / 2,
			right = f5_local27 / 2,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false,
			material = RegisterMaterial("white"),
			alpha = 0.3,
			red = 0,
			green = 0,
			blue = 0
		})
		Widget:addElement(f5_local14.xpBarBG)
		f5_local14.xpBarShadow = LUI.UIImage.new({
			left = -f5_local27 / 2,
			top = -f5_local28 / 2,
			bottom = f5_local28 / 2,
			right = f5_local27 / 2,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false,
			material = RegisterMaterial("menu_mp_bar_shadow"),
			alpha = 0.2,
			red = 1,
			green = 1,
			blue = 1
		})
		Widget:addElement(f5_local14.xpBarShadow)
		f5_local14.xpBar = LUI.UIImage.new({
			left = -f5_local27 / 2,
			top = -f5_local28 / 2,
			bottom = f5_local28 / 2,
			right = -f5_local27 / 2 + f5_local29,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false,
			material = RegisterMaterial("menu_mp_combatrecord_bar"),
			alpha = 0.4,
			red = f5_local26.r,
			green = f5_local26.g,
			blue = f5_local26.b
		})
		Widget:addElement(f5_local14.xpBar)
		f5_local14.xpBarArrow = LUI.UIImage.new({
			left = -f5_local27 / 2 + f5_local29 - 10,
			top = f5_local28 / 2,
			bottom = f5_local28 / 2 + 20,
			right = -f5_local27 / 2 + f5_local29 + 10,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false,
			material = RegisterMaterial("ui_arrow_right"),
			alpha = f5_local26.a,
			red = f5_local26.r,
			green = f5_local26.g,
			blue = f5_local26.b,
			zRot = 90
		})
		Widget:addElement(f5_local14.xpBarArrow)
		f5_local14.nextLevelText = LUI.UIText.new({
			left = -f5_local27 / 2 - 100,
			top = -f5_local28 / 2,
			bottom = f5_local28 / 2,
			right = -f5_local27 / 2,
			red = 1,
			green = 1,
			blue = 1,
			alpha = 1,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false
		})
		f5_local14.nextLevelText:setText(Engine.Localize("MPUI_NEXT_LEVEL_CAPS"))
		Widget:addElement(f5_local14.nextLevelText)
		f5_local14.xpNeededToLevelUpText = LUI.UIText.new({
			left = -f5_local27 / 2 + 150,
			top = -f5_local28 / 2,
			bottom = f5_local28 / 2,
			right = -f5_local27 / 2,
			red = 1,
			green = 1,
			blue = 1,
			alpha = 1,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false
		})
		f5_local14.xpNeededToLevelUpText:setText(f5_local24)
		Widget:addElement(f5_local14.xpNeededToLevelUpText)
		f5_local14.nextLevelText = LUI.UIText.new({
			left = f5_local27 / 2 + 30,
			top = -f5_local28 / 2,
			bottom = f5_local28 / 2,
			right = f5_local27 / 2,
			red = 1,
			green = 1,
			blue = 1,
			alpha = 1,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false
		})
		if CoD.PrestigeNext(f5_arg1) == true then
			f5_local14.nextLevelText:setText(CoD.PrestigeNextLevelText(f5_arg1))
		else
			f5_local14.nextLevelText:setText(f5_local25)
		end
		Widget:addElement(f5_local14.nextLevelText)
		local f5_local31 = 30
		local f5_local32 = 30
		local f5_local33 = nil
		if CoD.PrestigeNext(f5_arg1) == true then
			f5_local33 = UIExpression.TableLookup(f5_arg1, CoD.rankIconTable, 0, 0, f5_local19 + 2)
		else
			f5_local33 = UIExpression.TableLookup(f5_arg1, CoD.rankIconTable, 0, f5_local18 + 1, f5_local19 + 1)
		end
		f5_local14.nextLevelIcon = LUI.UIImage.new({
			left = f5_local27 / 2 + 30,
			top = -f5_local32 / 2,
			bottom = f5_local32 / 2,
			right = f5_local27 / 2 + 30 + f5_local31,
			material = RegisterMaterial(f5_local33),
			alpha = 1,
			leftAnchor = false,
			topAnchor = false,
			bottomAnchor = false,
			rightAnchor = false
		})
		Widget:addElement(f5_local14.nextLevelIcon)
	end
	f5_local0:openPanel("buttonPanel", nil, nil, nil, 0)
	f5_local0:openPanel("emblemDisplay", nil, nil, nil, 0)
	f5_local0:openPanel("xpBarPanel", nil, nil, nil, 0)
	if CoD.useController and not f5_arg0.leftPane:restoreState() then
		f5_arg0.leftPane.buttons.editPlayercard:processEvent({
			name = "gain_focus"
		})
	end
end

CoD.PlayercardPopup.buttonPressedBack = function (f6_arg0, f6_arg1)
	f6_arg0.leftPane:saveState()
	f0_local2(f6_arg0)
	f6_arg0:closePopup(nil, true)
	Engine.PartyHostClearUIState()
end

function PlayercardPopup_ButtonPressed_ClanTag(f7_arg0, f7_arg1)
	CoD.ClanTagPopup.Open(f7_arg0.playercardMenu, f7_arg1.controller)
end

function PlayercardPopup_ButtonPressed_CombatRecord(f8_arg0, f8_arg1)
	CoD.CombatRecordPopup.Open(f8_arg0.playercardMenu, f8_arg1.controller)
end

