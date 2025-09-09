require("T6.MFTabManager")
require("T6.HUD.SpectatePlayerInfo")
require("T6.HUD.SpectateDisplayOptions")
CoD.SpectateSidePanel = InheritFrom(LUI.UIElement)
CoD.SpectateSidePanel.Width = 320
CoD.SpectateSidePanel.Padding = 5
CoD.SpectateSidePanel.PlayersTabIndex = 1
CoD.SpectateSidePanel.DisplayOptionsTabIndex = 2
CoD.SpectateSidePanel.TabPadding = -60
local f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg0.tabContentPane.playerInfo:setAlpha(1)
	f1_arg0.tabContentPane.playerInfo:setMouseDisabled(false)
	f1_arg0.tabContentPane.playerInfo:processEvent({
		name = "slide_in"
	})
	f1_arg0.tabContentPane.displayOptions:saveState()
	f1_arg0.tabContentPane.displayOptions:setAlpha(0)
	f1_arg0.tabContentPane.displayOptions:setMouseDisabled(true)
	f1_arg0.tabContentPane.displayOptions:processEvent({
		name = "lose_focus"
	})
	local f1_local0 = f1_arg0:getParent()
	f1_local0:dispatchEventToParent({
		name = "spectate_sidepanel_tab_changed",
		controller = f1_arg1
	})
	f1_local0.optionsTabText:setRGB(0.3, 0.3, 0.3)
	f1_local0.playerTabText:setRGB(1, 1, 1)
	f1_local0.optionsTabTop:setAlpha(0)
	f1_local0.optionsTab:setAlpha(0.5)
	f1_local0.playerTabTop:setAlpha(1)
	f1_local0.playerTab:setAlpha(0)
end

local f0_local1 = function (f2_arg0, f2_arg1)
	f2_arg0.tabContentPane.playerInfo:setAlpha(0)
	f2_arg0.tabContentPane.playerInfo:setMouseDisabled(true)
	f2_arg0.tabContentPane.playerInfo:processEvent({
		name = "lose_focus"
	})
	f2_arg0.tabContentPane.displayOptions:setAlpha(1)
	f2_arg0.tabContentPane.displayOptions:setMouseDisabled(false)
	if not f2_arg0.tabContentPane.displayOptions:restoreState() then
		f2_arg0.tabContentPane.displayOptions:processEvent({
			name = "gain_focus"
		})
	end
	local f2_local0 = f2_arg0:getParent()
	f2_local0:dispatchEventToParent({
		name = "spectate_sidepanel_tab_changed",
		controller = f2_arg1
	})
	f2_local0.playerTabText:setRGB(0.3, 0.3, 0.3)
	f2_local0.optionsTabText:setRGB(1, 1, 1)
	f2_local0.optionsTabTop:setAlpha(1)
	f2_local0.optionsTab:setAlpha(0)
	f2_local0.playerTabTop:setAlpha(0)
	f2_local0.playerTab:setAlpha(0.5)
end

CoD.SpectateSidePanel.SlideIn = function (f3_arg0, f3_arg1)
	f3_arg0:beginAnimation("spectate_sidepanel_slidein", 200)
	f3_arg0:setLeftRight(true, false, f3_arg1.safeX + f3_arg1.viewportWidth + CoD.SpectateSidePanel.Padding, f3_arg1.safeX + f3_arg1.viewportWidth + CoD.SpectateSidePanel.Padding + CoD.SpectateSidePanel.Width)
	f3_arg0:setAlpha(1)
	f3_arg0.tabManager:refreshTab(f3_arg1.controller)
	if f3_arg0.tabManager.tabSelected == CoD.SpectateSidePanel.DisplayOptionsTabIndex then
		f0_local1(f3_arg0.tabManager, f3_arg1.controller)
	else
		f0_local0(f3_arg0.tabManager, f3_arg1.controller)
	end
end

CoD.SpectateSidePanel.SlideOut = function (f4_arg0, f4_arg1)
	f4_arg0:beginAnimation("spectate_sidepanel_slideout", 200)
	f4_arg0:setLeftRight(false, true, 0, CoD.SpectateSidePanel.Width)
	f4_arg0:setAlpha(0)
	f4_arg0.playerInfo:processEvent({
		name = "lose_focus"
	})
	f4_arg0.displayOptions:processEvent({
		name = "lose_focus"
	})
end

CoD.SpectateSidePanel.updateSpectatePlayerInfo = function (f5_arg0, f5_arg1)
	f5_arg0.playerInfo:update()
end

CoD.SpectateSidePanel.RowSelected = function (f6_arg0, f6_arg1)
	f6_arg0:dispatchEventToParent(f6_arg1)
end

CoD.SpectateSidePanel.new = function (f7_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, 0, CoD.SpectateSidePanel.Width)
	Widget:setTopBottom(true, true, 0, 0)
	Widget.id = "SpectateSidePanel"
	Widget:setClass(CoD.SpectateSidePanel)
	Widget:setAlpha(0)
	Widget:registerAnimationState("sidepanel_slidein", {
		left = -CoD.SpectateSidePanel.Width,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget:registerAnimationState("sidepanel_slideout", {
		left = 0,
		top = 0,
		right = CoD.SpectateSidePanel.Width,
		bottom = 0,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	Widget.m_ownerController = f7_arg0
	Widget.playerTab = LUI.UIImage.new()
	Widget.playerTab:setLeftRight(true, false, CoD.SpectateSidePanel.TabPadding, 512 + CoD.SpectateSidePanel.TabPadding)
	Widget.playerTab:setTopBottom(true, false, 0, 64)
	Widget.playerTab:setImage(RegisterMaterial("spectator_pip_scoretop"))
	Widget.playerTab:setAlpha(0)
	Widget.playerTabTop = LUI.UIImage.new()
	Widget.playerTabTop:setLeftRight(true, false, CoD.SpectateSidePanel.TabPadding, 512 + CoD.SpectateSidePanel.TabPadding)
	Widget.playerTabTop:setTopBottom(true, false, 0, 64)
	Widget.playerTabTop:setImage(RegisterMaterial("spectator_pip_scoretop"))
	Widget.playerTabTop:setAlpha(0)
	Widget.optionsTab = LUI.UIImage.new()
	Widget.optionsTab:setLeftRight(true, false, CoD.SpectateSidePanel.TabPadding, 512 + CoD.SpectateSidePanel.TabPadding)
	Widget.optionsTab:setTopBottom(true, false, 0, 64)
	Widget.optionsTab:setImage(RegisterMaterial("spectator_pip_scoretop_middle"))
	Widget.optionsTab:setAlpha(0)
	Widget.optionsTabTop = LUI.UIImage.new()
	Widget.optionsTabTop:setLeftRight(true, false, CoD.SpectateSidePanel.TabPadding, 512 + CoD.SpectateSidePanel.TabPadding)
	Widget.optionsTabTop:setTopBottom(true, false, 0, 64)
	Widget.optionsTabTop:setImage(RegisterMaterial("spectator_pip_scoretop_middle"))
	Widget.optionsTabTop:setAlpha(0)
	Widget:addElement(Widget.optionsTab)
	Widget:addElement(Widget.playerTab)
	Widget:addElement(Widget.optionsTabTop)
	Widget:addElement(Widget.playerTabTop)
	local f7_local1 = CoD.ButtonPrompt.new("shoulderl", "")
	local f7_local2 = CoD.ButtonPrompt.new("shoulderr", "")
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 10, 0)
	Widget:setTopBottom(true, false, 24, 64)
	Widget:addElement(f7_local1)
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 252, 0)
	Widget:setTopBottom(true, false, 24, 64)
	Widget:addElement(f7_local2)
	Widget:addElement(Widget)
	Widget.playerTabText = LUI.UIText.new()
	Widget.playerTabText:setLeftRight(true, true, 53, 0)
	Widget.playerTabText:setTopBottom(true, false, 34, 34 + CoD.textSize.ExtraSmall)
	Widget.playerTabText:setText(Engine.Localize("MPUI_SHOUTCASTER_PLAYERS"))
	Widget.playerTabText:setAlignment(LUI.Alignment.Left)
	Widget.playerTabText:setFont(CoD.fonts.ExtraSmall)
	Widget:addElement(Widget.playerTabText)
	Widget.optionsTabText = LUI.UIText.new()
	Widget.optionsTabText:setLeftRight(true, true, 158, 0)
	Widget.optionsTabText:setTopBottom(true, false, 34, 34 + CoD.textSize.ExtraSmall)
	Widget.optionsTabText:setText(Engine.Localize("MPUI_SHOUTCASTER_OPTIONS"))
	Widget.optionsTabText:setAlignment(LUI.Alignment.Left)
	Widget.optionsTabText:setFont(CoD.fonts.ExtraSmall)
	Widget:addElement(Widget.optionsTabText)
	Widget.playerInfo = CoD.SpectatePlayerInfo.new(f7_arg0)
	Widget:addElement(Widget.playerInfo)
	Widget.playerInfoTimer = LUI.UITimer.new(500, {
		name = "spectate_update_player_list",
		controller = f7_arg0
	}, false)
	Widget:addElement(Widget.playerInfoTimer)
	Widget.displayOptions = CoD.SpectateDisplayOptions.new(f7_arg0)
	Widget:addElement(Widget.displayOptions)
	local f7_local5 = CoD.MFTabManager.new(Widget, {
		left = -CoD.SpectateSidePanel.Width + 30,
		top = 0,
		right = 0,
		bottom = 30 + CoD.ButtonPrompt.Height,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	}, true)
	f7_local5:keepRightBumperAlignedToHeader(true)
	f7_local5:disable()
	Widget.tabManager = f7_local5
	Widget:addElement(f7_local5)
	local f7_local6 = f7_local5:addTab(f7_arg0, "", f0_local0, true)
	local f7_local7 = f7_local5:addTab(f7_arg0, "", f0_local1, true)
	if CoD.useMouse then
		f7_local1:setHandleMouse(false)
		f7_local2:setHandleMouse(false)
		local f7_local8 = CoD.SpectateSidePanel.CreateMouseTabListener(f7_local6, 40)
		local f7_local9 = CoD.SpectateSidePanel.CreateMouseTabListener(f7_local7, 150)
		Widget:addElement(f7_local8)
		Widget:addElement(f7_local9)
	end
	Widget.listenIn = CoD.SpectateSidePanel.ListenIn
	return Widget
end

CoD.SpectateSidePanel.ListenIn = function (f8_arg0, f8_arg1)
	f8_arg0.playerInfo:listenIn(f8_arg1)
end

CoD.SpectateSidePanel.UpdateScores = function (f9_arg0, f9_arg1)
	f9_arg0:dispatchEventToChildren(f9_arg1)
end

CoD.SpectateSidePanel.Update = function (f10_arg0, f10_arg1)
	f10_arg0:dispatchEventToChildren(f10_arg1)
end

CoD.SpectateSidePanel:registerEventHandler("spectate_dock", CoD.SpectateSidePanel.SlideIn)
CoD.SpectateSidePanel:registerEventHandler("spectate_undock", CoD.SpectateSidePanel.SlideOut)
CoD.SpectateSidePanel:registerEventHandler("spectate_update_player_list", CoD.SpectateSidePanel.updateSpectatePlayerInfo)
CoD.SpectateSidePanel:registerEventHandler("spectate_row_selected", CoD.SpectateSidePanel.RowSelected)
CoD.SpectateSidePanel:registerEventHandler("hud_update_scores", CoD.SpectateSidePanel.UpdateScores)
CoD.SpectateSidePanel:registerEventHandler("update_spectate_hud", CoD.SpectateSidePanel.Update)
CoD.SpectateSidePanel.CreateMouseTabListener = function (f11_arg0, f11_arg1)
	local f11_local0 = 100
	local f11_local1 = 30
	local f11_local2 = 60
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f11_arg1, f11_arg1 + f11_local0)
	Widget:setTopBottom(true, false, f11_local2 - f11_local1, f11_local2)
	Widget:setHandleMouseButton(true)
	Widget.tabIndex = f11_arg0
	Widget:registerEventHandler("leftmousedown", CoD.NullFunction)
	Widget:registerEventHandler("leftmouseup", CoD.SpectateSidePanel.MouseListener_LeftMouseUp)
	return Widget
end

CoD.SpectateSidePanel.MouseListener_LeftMouseUp = function (f12_arg0, f12_arg1)
	f12_arg0:dispatchEventToRoot({
		name = "tab_clicked",
		controller = f12_arg1.controller,
		tabIndex = f12_arg0.tabIndex
	})
end

