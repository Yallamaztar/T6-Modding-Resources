require("T6.HUD.InGameMenus")
require("T6.Menus.CACUtility")
require("T6.SplitscreenClassPreview")
CoD.ChangeClass = {}
CoD.ChangeClass.Width = 840
CoD.ChangeClass.Height = 600
CoD.ChangeClass.IsOnlineGame = function ()
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == false and UIExpression.SessionMode_IsSystemlinkGame() == 0 then
		return true
	else
		return false
	end
end

CoD.ChangeClass.SetProfileLoadoutChoice = function (f2_arg0, f2_arg1)
	local f2_local0 = "lastLoadoutSystemlink"
	if CoD.ChangeClass.IsOnlineGame() == true then
		if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
			f2_local0 = "lastLoadoutLeague"
		else
			f2_local0 = "lastLoadoutOnline"
		end
	end
	Engine.SetProfileVar(f2_arg0, f2_local0, f2_arg1)
	Engine.CommitProfileChanges(f2_arg0)
end

CoD.ChangeClass.GetProfileLoadoutChoice = function (f3_arg0)
	local f3_local0 = "lastLoadoutSystemlink"
	if CoD.ChangeClass.IsOnlineGame() == true then
		if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) then
			f3_local0 = "lastLoadoutLeague"
		else
			f3_local0 = "lastLoadoutOnline"
		end
	end
	return Engine.GetProfileVarInt(f3_arg0, f3_local0)
end

CoD.ChangeClass.Button_RowGainFocus = function (f4_arg0, f4_arg1)
	CoD.CoD9Button.GainFocus(f4_arg0, f4_arg1)
	f4_arg0:dispatchEventToParent({
		name = "row_gain_focus",
		button = f4_arg0
	})
end

CoD.ChangeClass.RowGainFocus = function (f5_arg0, f5_arg1)
	if f5_arg1.button.disabled == nil then
		f5_arg0.classPreview:update(f5_arg1.button.controller, f5_arg1.button.classIndex, f5_arg1.button.className)
	else
		f5_arg0.informationPane:animateToState("hide", 0)
	end
end

CoD.ChangeClass.Button_RowLoseFocus = function (f6_arg0, f6_arg1)
	CoD.CoD9Button.LoseFocus(f6_arg0, f6_arg1)
end

CoD.ChangeClass.CheckFocus = function (f7_arg0)
	if f7_arg0.buttonList:getFirstChild() then
		local f7_local0 = f7_arg0.buttonList:getFirstChild()
		if not f7_local0:getFirstInFocus() then
			f7_arg0.buttonList:processEvent({
				name = "gain_focus"
			})
		end
	end
end

CoD.ChangeClass.AddButton = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4, f8_arg5, f8_arg6, f8_arg7)
	local f8_local0 = f8_arg0.buttonList:addButton(f8_arg2)
	f8_local0.classIndex = f8_arg6
	f8_local0.className = f8_arg5
	f8_local0.controller = f8_arg1
	f8_local0:setActionEventName(f8_arg3)
	f8_local0:registerEventHandler("gain_focus", CoD.ChangeClass.Button_RowGainFocus)
	f8_local0:registerEventHandler("lose_focus", CoD.ChangeClass.Button_RowLoseFocus)
	if f8_arg5 then
		f8_arg6 = Engine.GetClassIndexFromName(f8_arg5)
	else
		local f8_local1 = Engine.GetCustomClass(f8_arg1, f8_arg6)
		if Engine.GetMaxAllocation(f8_arg1) < f8_local1.allocationSpent then
			f8_arg4 = true
		end
	end
	local f8_local1 = Engine.GetCustomClass(f8_arg1, f8_arg6)
	local f8_local2 = f8_local1.primary
	local f8_local3 = f8_local1.secondary
	if not (not f8_local2 or Engine.HasDLCForItem(f8_arg1, f8_local2)) or f8_local3 and not Engine.HasDLCForItem(f8_arg1, f8_local3) then
		f8_arg4 = true
	end
	if f8_arg4 == true then
		f8_local0:disable()
		f8_local0:lock()
		f8_local0.lockImage:setLeftRight(true, false, -CoD.CoD9Button.Height, -6)
		f8_local0:makeNotFocusable()
	elseif f8_arg7 == f8_arg6 then
		f8_local0:processEvent({
			name = "gain_focus"
		})
	end
end

CoD.ChangeClass.CustomClassText = function (f9_arg0, f9_arg1)
	local f9_local0 = CoD.CACUtility.GetLoadoutNameFromIndex(f9_arg1, f9_arg0)
	return f9_local0:get()
end

CoD.ChangeClass.SendMenuResponseCustomClassSelected = function (f10_arg0, f10_arg1)
	f10_arg0:saveState()
	f10_arg0:goBack(f10_arg1.controller)
	local f10_local0 = nil
	if f10_arg1.button.className ~= nil then
		Engine.SendMenuResponse(f10_arg1.button.controller, "changeclass", f10_arg1.button.className)
		f10_local0 = Engine.GetClassIndexFromName(f10_arg1.button.className)
	else
		Engine.SendMenuResponse(f10_arg1.button.controller, "changeclass", "custom" .. f10_arg1.button.classIndex)
		f10_local0 = f10_arg1.button.classIndex
	end
	CoD.ChangeClass.SetProfileLoadoutChoice(controller, f10_local0)
	HUD_IngameMenuClosed()
	local f10_local1 = LUI.roots.UIRootDrc
	if f10_local1 and f10_local1.drcChangeClassOpen and f10_arg1.controller == f10_local1.controller then
		f10_local1:processEvent({
			name = "press_view_panel_button",
			buttonName = "change_class"
		})
		local f10_local2 = Engine.GetCustomClass(f10_arg1.controller, f10_local0)
		f10_local1:processEvent({
			name = "change_class_button_material",
			material = UIExpression.GetItemImage(nil, f10_local2.primary)
		})
	end
	Engine.StreamSetCustomClass(f10_arg1.controller, f10_arg1.button.classIndex)
end

local f0_local0 = function (f11_arg0, f11_arg1)
	local f11_local0
	if UIExpression.IsItemLocked(f11_arg0, UIExpression.GetItemIndex(f11_arg0, f11_arg1)) ~= 1 or CoD.ChangeClass.IsOnlineGame() ~= true then
		f11_local0 = false
	else
		f11_local0 = true
	end
	return f11_local0
end

local f0_local1 = function (f12_arg0)
	local f12_local0 = f0_local0(f12_arg0, "FEATURE_CREATE_A_CLASS")
	if not f12_local0 then
		f12_local0 = Engine.GetGametypeSetting("disableCAC") == 1
	end
	return f12_local0
end

CoD.ChangeClass.AddPrestigeClassButtons = function (f13_arg0, f13_arg1, f13_arg2)
	if Engine.GameModeIsMode(CoD.GAMEMODE_LEAGUE_MATCH) == true then
		return 
	end
	local f13_local0 = f0_local1(f13_arg1) == false
	local f13_local1 = Engine.GetCustomClassCount(f13_arg1)
	if f13_local1 == nil then
		return 
	end
	for f13_local2 = 5, 9, 1 do
		if f13_local0 and CoD.ChangeClass.IsOnlineGame() == true and f13_local2 < f13_local1 then
			local f13_local5 = CoD.ChangeClass.AddButton
			local f13_local6 = f13_arg0
			local f13_local7 = f13_arg1
			local f13_local8 = CoD.CACUtility.GetLoadoutNameFromIndex(f13_arg1, f13_local2)
			f13_local5(f13_local6, f13_local7, f13_local8:get(), "sendMenuResponse_CustomClassSelected", nil, nil, f13_local2, f13_arg2)
		end
	end
end

CoD.ChangeClass.AddCustomClassButtons = function (f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = f0_local1(f14_arg1)
	for f14_local1 = 0, 4, 1 do
		CoD.ChangeClass.AddButton(f14_arg0, f14_arg1, CoD.ChangeClass.CustomClassText(f14_local1, f14_arg1), "sendMenuResponse_CustomClassSelected", f14_local0, nil, f14_local1, f14_arg2)
	end
	f14_arg0.buttonList:addSpacer(CoD.CoD9Button.Height / 2)
end

CoD.ChangeClass.IsDefaultClassButtonDisabled = function (f15_arg0, f15_arg1)
	local f15_local0 = Engine.GetCustomClassCount(f15_arg0)
	if f15_local0 == nil then
		return false
	elseif CoD.ChangeClass.IsOnlineGame() == true and not Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) and not f0_local1(f15_arg0) and f15_arg1 < f15_local0 then
		return true
	else
		return false
	end
end

CoD.ChangeClass.AddDefaultClassButtons = function (f16_arg0, f16_arg1, f16_arg2)
	local f16_local0 = Engine.GetClientNum(f16_arg1)
	local f16_local1 = CoD.TEAM_FREE
	if Engine.GetGametypeSetting("teamCount") >= 2 then
		f16_local1 = Engine.GetTeamID(f16_arg1, f16_local0)
	end
	CoD.CACUtility.SetGametypeSettingsCACRoot(f16_arg0:getOwner(), f16_local1)
	local f16_local2 = CoD.CACUtility.GetLoadoutNames(f16_arg0:getOwner())
	if not CoD.ChangeClass.IsDefaultClassButtonDisabled(f16_arg1, 5) then
		CoD.ChangeClass.AddButton(f16_arg0, f16_arg1, Engine.Localize(f16_local2[0]:get()), "sendMenuResponse_CustomClassSelected", nil, "class_smg", 10, f16_arg2)
	end
	if not CoD.ChangeClass.IsDefaultClassButtonDisabled(f16_arg1, 6) then
		CoD.ChangeClass.AddButton(f16_arg0, f16_arg1, Engine.Localize(f16_local2[1]:get()), "sendMenuResponse_CustomClassSelected", nil, "class_cqb", 11, f16_arg2)
	end
	if not CoD.ChangeClass.IsDefaultClassButtonDisabled(f16_arg1, 7) then
		CoD.ChangeClass.AddButton(f16_arg0, f16_arg1, Engine.Localize(f16_local2[2]:get()), "sendMenuResponse_CustomClassSelected", nil, "class_assault", 12, f16_arg2)
	end
	if not CoD.ChangeClass.IsDefaultClassButtonDisabled(f16_arg1, 8) then
		CoD.ChangeClass.AddButton(f16_arg0, f16_arg1, Engine.Localize(f16_local2[3]:get()), "sendMenuResponse_CustomClassSelected", f0_local0(f16_arg1, "FEATURE_CLOSEASSAULT"), "class_lmg", 13, f16_arg2)
	end
	if not CoD.ChangeClass.IsDefaultClassButtonDisabled(f16_arg1, 9) then
		CoD.ChangeClass.AddButton(f16_arg0, f16_arg1, Engine.Localize(f16_local2[4]:get()), "sendMenuResponse_CustomClassSelected", f0_local0(f16_arg1, "FEATURE_SNIPER"), "class_sniper", 14, f16_arg2)
	end
	CoD.CACUtility.SetDefaultCACRoot(f16_arg0:getOwner())
end

CoD.ChangeClass.PrepareButtonList = function (f17_arg0, f17_arg1)
	local f17_local0 = CoD.SplitscreenScaler.new(nil, 1.45)
	f17_local0:setLeftRight(true, false, 0, 0)
	f17_local0:setTopBottom(true, false, 0, 0)
	f17_arg1:addElement(f17_local0)
	local f17_local1 = 0
	if UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
		f17_local1 = CoD.Menu.SplitscreenSideOffset
	end
	f17_arg1.buttonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f17_local1,
		right = f17_local1 + 250,
		topAnchor = true,
		bottomAnchor = false,
		top = CoD.Menu.TitleHeight,
		bottom = CoD.Menu.TitleHeight + 720
	})
	f17_local0:addElement(f17_arg1.buttonList)
	if not Engine.IsSplitscreen() and (Engine.SessionModeIsMode(CoD.SESSIONMODE_ONLINE) or Engine.SessionModeIsMode(CoD.SESSIONMODE_PRIVATE)) then
		local f17_local2 = Engine.GetNumberOfClassSetsOwned(f17_arg0)
		if f17_local2 and f17_local2 > 0 then
			local f17_local3 = LUI.UIText.new()
			f17_local3:setLeftRight(true, false, 0, 0)
			f17_local3:setTopBottom(true, false, 0, CoD.textSize.Condensed)
			f17_local3:setFont(CoD.fonts.Condensed)
			f17_arg1.buttonList:addElement(f17_local3)
			f17_local3:setText(Engine.GetClassSetName(f17_arg0, Engine.GetCurrentClassSetIndex(f17_arg0)))
			f17_arg1.buttonList:addSpacer(CoD.CoD9Button.Height / 2)
		end
	end
	local f17_local2 = CoD.ChangeClass.GetProfileLoadoutChoice(f17_arg0)
	CoD.ChangeClass.AddCustomClassButtons(f17_arg1, f17_arg0, f17_local2)
	if not Engine.GameModeIsMode(CoD.GAMEMODE_PRIVATE_MATCH) then
		CoD.ChangeClass.AddPrestigeClassButtons(f17_arg1, f17_arg0, f17_local2)
	end
	CoD.ChangeClass.AddDefaultClassButtons(f17_arg1, f17_arg0, f17_local2)
	CoD.ChangeClass.CheckFocus(f17_arg1)
	LUI.UIVerticalList.UpdateNavigation(f17_arg1.buttonList)
end

CoD.ChangeClass.TouchWeaponTextures = function (f18_arg0, f18_arg1)
	Engine.StreamTouchWeaponTextures(f18_arg0:getOwner())
end

LUI.createMenu.changeclass = function (f19_arg0)
	local f19_local0 = CoD.InGameMenu.New("changeclass", f19_arg0, UIExpression.ToUpper(nil, Engine.Localize("MPUI_CHOOSE_CLASS_CAPS")))
	local f19_local1 = 20
	if UIExpression.IsInGame() == 1 and Engine.IsSplitscreen() == true then
		f19_local0:sizeToSafeArea(f19_arg0)
		f19_local1 = 0
		f19_local0:updateTitleForSplitscreen()
		f19_local0:updateButtonPromptBarsForSplitscreen()
	end
	CoD.CACUtility.SetDefaultCACRoot(f19_arg0)
	f19_local0:setOwner(f19_arg0)
	f19_local0:addButtonPrompts()
	local f19_local2 = CoD.SplitscreenScaler.new(nil, 1.5)
	f19_local2:setLeftRight(false, true, 0, 0)
	f19_local2:setTopBottom(true, false, CoD.Menu.TitleHeight, 0)
	f19_local0:addElement(f19_local2)
	local f19_local3 = 0
	local f19_local4 = CoD.Menu.Width - CoD.ButtonList.DefaultWidth + 110 - f19_local1
	if Engine.IsSplitscreen() then
		f19_local3 = -CoD.Menu.SplitscreenSideOffset
		f19_local4 = CoD.Menu.Width - CoD.ButtonList.DefaultWidth * 1.5
		f19_local0.classPreview = CoD.SplitscreenClassPreview.New(f19_arg0, f19_local4)
	else
		f19_local0.classPreview = CoD.ClassPreview.New(f19_arg0, f19_local4)
	end
	f19_local0.classPreview:setLeftRight(false, true, f19_local3 - f19_local4, f19_local3)
	f19_local0.classPreview:setTopBottom(true, true, 0, 0)
	f19_local0.classPreview:setAlpha(1)
	f19_local2:addElement(f19_local0.classPreview)
	f19_local0:registerEventHandler("row_gain_focus", CoD.ChangeClass.RowGainFocus)
	f19_local0:registerEventHandler("sendMenuResponse_CustomClassSelected", CoD.ChangeClass.SendMenuResponseCustomClassSelected)
	f19_local0:registerEventHandler("changeclass_streamtextures", CoD.ChangeClass.TouchWeaponTextures)
	f19_local0:addElement(LUI.UITimer.new(50, "changeclass_streamtextures", false, f19_local0))
	CoD.ChangeClass.PrepareButtonList(f19_arg0, f19_local0)
	local f19_local5 = LUI.roots.UIRootDrc
	if f19_local5 and not f19_local5.drcChangeClassOpen and f19_local5.controller == f19_arg0 then
		f19_local5:processEvent({
			name = "press_view_panel_button",
			buttonName = "change_class"
		})
		f19_local5.initialOpenClass = true
	end
	return f19_local0
end

