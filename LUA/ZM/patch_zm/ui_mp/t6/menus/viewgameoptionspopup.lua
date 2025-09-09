require("T6.GameOptions")
CoD.ViewGameOptions = {}
CoD.ViewGameOptions.AddOptionsForGametype = {}
CoD.ViewGameOptions.Update = function (f1_arg0, f1_arg1)
	f1_arg0:processEvent({
		name = "button_update"
	})
	Engine.PlaySound(CoD.CAC.ButtonActionSound)
end

CoD.ViewGameOptions.Reopen = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.m_ownerController
	local f2_local1 = f2_arg0.occludedMenu
	f2_arg0:goBack(f2_local0)
	f2_local1:openPopup("ViewGameOptions", f2_local0)
end

CoD.ViewGameOptions.ConsumeButtonsCreated = function (f3_arg0, f3_arg1)
	CoD.GameOptions.AddSelectorButtons(f3_arg0, f3_arg1, nil, false)
	f3_arg0.buttonList:addSpacer(CoD.CoD9Button.Height)
	for f3_local3, f3_local4 in ipairs(f3_arg0.options) do
		f3_arg0.options[f3_local3] = nil
	end
end

CoD.ViewGameOptions.AddGametypeSpecificOptions = function (f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = UIExpression.DvarString(nil, "ui_gametype")
	f4_arg0.options = {}
	if f4_local0 and CoD.ViewGameOptions.AddOptionsForGametype[f4_local0] then
		CoD.ViewGameOptions.AddOptionsForGametype[f4_local0](f4_arg0, f4_arg1)
	end
	CoD.GameOptions.AddSelectorButtons(f4_arg0, f4_arg1, f4_arg0.options, f4_arg2)
end

CoD.ViewGameOptions.AddOptionsForGametype.dm = function (f5_arg0, f5_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.dm(f5_arg0, f5_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.tdm = function (f6_arg0, f6_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.tdm(f6_arg0, f6_arg1)
	CoD.GameOptions.Button_MultiTeam_AddChoices(f6_arg0, f6_arg1)
	CoD.ViewGameOptions.ConsumeButtonsCreated(f6_arg0, f6_arg1)
	CoD.GameOptions.Button_RoundBased_AddChoices(f6_arg0, f6_arg1)
	CoD.GameOptions.Button_RoundScoreCarry_AddChoices(f6_arg0, f6_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.pur = function (f7_arg0, f7_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.pur(f7_arg0, f7_arg1)
	CoD.GameOptions.AddOptionsForGametype.pur(f7_arg0, f7_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.sd = function (f8_arg0, f8_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.sd(f8_arg0, f8_arg1)
	CoD.GameOptions.AddOptionsForGametype.sd(f8_arg0, f8_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.sab = function (f9_arg0, f9_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.sab(f9_arg0, f9_arg1)
	CoD.GameOptions.AddOptionsForGametype.sab(f9_arg0, f9_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.dom = function (f10_arg0, f10_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.dom(f10_arg0, f10_arg1)
	CoD.ViewGameOptions.ConsumeButtonsCreated(f10_arg0, f10_arg1)
	CoD.GameOptions.AddOptionsForGametype.dom(f10_arg0, f10_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.koth = function (f11_arg0, f11_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.koth(f11_arg0, f11_arg1)
	CoD.GameOptions.AddOptionsForGametype.koth(f11_arg0, f11_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.hq = function (f12_arg0, f12_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.hq(f12_arg0, f12_arg1)
	CoD.GameOptions.AddOptionsForGametype.hq(f12_arg0, f12_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.ctf = function (f13_arg0, f13_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.ctf(f13_arg0, f13_arg1)
	CoD.GameOptions.AddOptionsForGametype.ctf(f13_arg0, f13_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.hun = function (f14_arg0, f14_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.hun(f14_arg0, f14_arg1)
	CoD.GameOptions.AddOptionsForGametype.hun(f14_arg0, f14_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.dem = function (f15_arg0, f15_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.dem(f15_arg0, f15_arg1)
	CoD.GameOptions.AddOptionsForGametype.dem(f15_arg0, f15_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.conf = function (f16_arg0, f16_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.conf(f16_arg0, f16_arg1)
	CoD.GameOptions.AddOptionsForGametype.conf(f16_arg0, f16_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.tdef = function (f17_arg0, f17_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.tdef(f17_arg0, f17_arg1)
	CoD.GameOptions.AddOptionsForGametype.tdef(f17_arg0, f17_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.bwars = function (f18_arg0, f18_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.bwars(f18_arg0, f18_arg1)
	CoD.GameOptions.AddOptionsForGametype.bwars(f18_arg0, f18_arg1)
end

CoD.ViewGameOptions.AddOptionsForGametype.hack = function (f19_arg0, f19_arg1)
	CoD.GameOptions.AddBaseOptionsForGametype.hack(f19_arg0, f19_arg1)
	CoD.ViewGameOptions.ConsumeButtonsCreated(f19_arg0, f19_arg1)
	CoD.GameOptions.AddOptionsForGametype.hack(f19_arg0, f19_arg1)
end

CoD.ViewGameOptions.AddElements = function (f20_arg0, f20_arg1)
	f20_arg0:addBackButton()
	f20_arg0:registerEventHandler("game_options_update", CoD.ViewGameOptions.Update)
	f20_arg0:registerEventHandler("gametype_update", CoD.ViewGameOptions.Reopen)
	local f20_local0 = UIExpression.DvarString(nil, "ui_gametype")
	local f20_local1 = UIExpression.TableLookup(f20_arg1, CoD.gametypesTable, 0, 0, 1, f20_local0, 2)
	local f20_local2 = UIExpression.TableLookup(f20_arg1, CoD.gametypesTable, 0, 0, 1, f20_local0, 3)
	local f20_local3 = RegisterMaterial(UIExpression.TableLookup(f20_arg1, CoD.gametypesTable, 0, 0, 1, f20_local0, 4))
	local f20_local4 = 200
	local f20_local5 = 180
	local f20_local6 = 250
	local f20_local7 = CoD.Menu.TitleHeight
	f20_arg0.gameModeIcon = LUI.UIImage.new()
	f20_arg0.gameModeIcon:setTopBottom(true, false, f20_local7, f20_local7 + f20_local4)
	f20_arg0.gameModeIcon:setLeftRight(false, false, f20_local5, f20_local4 + f20_local5)
	f20_arg0.gameModeIcon:setImage(f20_local3)
	f20_arg0:addElement(f20_arg0.gameModeIcon)
	f20_arg0.gametypeLabel = LUI.UIText.new()
	f20_arg0.gametypeLabel:setTopBottom(true, false, f20_local7 + f20_local4, f20_local7 + f20_local4 + CoD.textSize.Condensed)
	f20_arg0.gametypeLabel:setLeftRight(false, false, f20_local5, f20_local4 + f20_local5)
	f20_arg0.gametypeLabel:setFont(CoD.fonts.Big)
	f20_arg0.gametypeLabel:setAlignment(LUI.Alignment.Left)
	f20_arg0.gametypeLabel:setText(Engine.Localize(f20_local1))
	f20_arg0:addElement(f20_arg0.gametypeLabel)
	f20_arg0.gametypeDesc = LUI.UIText.new()
	f20_arg0.gametypeDesc:setTopBottom(true, false, f20_local7 + f20_local4 + CoD.textSize.Condensed, f20_local7 + f20_local4 + CoD.textSize.Condensed + CoD.textSize.ExtraSmall)
	f20_arg0.gametypeDesc:setLeftRight(false, false, f20_local5, f20_local5 + f20_local6)
	f20_arg0.gametypeDesc:setFont(CoD.fonts.Big)
	f20_arg0.gametypeDesc:setAlignment(LUI.Alignment.Left)
	f20_arg0.gametypeDesc:setText(Engine.Localize(f20_local2))
	f20_arg0:addElement(f20_arg0.gametypeDesc)
	local Widget = LUI.UIElement.new()
	Widget:setTopBottom(true, false, 10, 10 + CoD.CoD9Button.Height * 17)
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setUseStencil(true)
	f20_arg0:addElement(Widget)
	f20_arg0.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = CoD.ButtonList.DefaultWidth,
		topAnchor = true,
		bottomAnchor = true,
		top = f20_local7,
		bottom = 0
	})
	f20_arg0.buttonList.id = f20_arg0.id .. "buttonList"
	Widget:addElement(f20_arg0.buttonList)
	CoD.ViewGameOptions.AddGametypeSpecificOptions(f20_arg0, f20_arg1, false)
	f20_arg0.buttonList:addSpacer(CoD.CoD9Button.Height)
	CoD.GameOptions.AddBotSpecificOptions(f20_arg0, f20_arg1, false)
	if not f20_arg0.buttonList:restoreState() then
		f20_arg0.buttonList:processEvent({
			name = "gain_focus"
		})
	end
end

LUI.createMenu.ViewGameOptions = function (f21_arg0)
	local f21_local0 = CoD.Menu.New("ViewGameOptions")
	f21_local0:addLargePopupBackground()
	f21_local0.m_ownerController = f21_arg0
	f21_local0:addTitle("")
	f21_local0:setTitle(Engine.Localize("MPUI_VIEW_GAME_OPTIONS_CAPS"))
	Engine.ExecNow(f21_arg0, "beginCustomGametypeChanges")
	CoD.ViewGameOptions.AddElements(f21_local0, f21_arg0)
	return f21_local0
end

