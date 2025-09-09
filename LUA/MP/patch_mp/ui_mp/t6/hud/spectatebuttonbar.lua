require("LUI.LUIHorizontalList")
CoD.SpectateButtonBar = InheritFrom(LUI.UIElement)
CoD.SpectateButtonBar.Height = 32
CoD.SpectateButtonBar.HorizontalPadding = 50
CoD.SpectateButtonBar.MODE_DEFAULT = 1
CoD.SpectateButtonBar.MODE_MAP = 2
CoD.SpectateButtonBar.MODE_SCOREBOARD = 3
CoD.SpectateButtonBar.Mode = -1
CoD.SpectateButtonBar.ButtonEvent = function (f1_arg0, f1_arg1)
	f1_arg0:dispatchEventToParent(f1_arg1)
end

CoD.SpectateButtonBar.Hide = function (f2_arg0, f2_arg1)
	f2_arg0:setAlpha(0)
end

CoD.SpectateButtonBar.Show = function (f3_arg0, f3_arg1)
	if Engine.IsDemoShoutcaster() then
		return 
	else
		f3_arg0:setAlpha(1)
	end
end

CoD.SpectateButtonBar.GetSpectatorString = function (f4_arg0)
	local f4_local0 = ""
	if UIExpression.IsVisibilityBitSet(f4_arg0, CoD.BIT_IS_THIRD_PERSON) == 1 then
		f4_local0 = "MPUI_FIRST_PERSON_VIEW"
	else
		f4_local0 = "MPUI_THIRD_PERSON_VIEW"
	end
	return f4_local0
end

CoD.SpectateButtonBar.UpdateModeDefault = function (f5_arg0, f5_arg1)
	CoD.ButtonPrompt.SetText(f5_arg0.viewToggleBtn, Engine.Localize(CoD.SpectateButtonBar.GetSpectatorString(f5_arg0.m_ownerController)))
end

CoD.SpectateButtonBar.Update = function (f6_arg0, f6_arg1)
	if CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_DEFAULT then
		CoD.SpectateButtonBar.UpdateModeDefault(f6_arg0, f6_arg1)
	end
end

CoD.SpectateButtonBar.SetModeInternal = function (f7_arg0)
	f7_arg0.leftButtonList:removeAllChildren()
	if f7_arg0.m_isFullscreen == true then
		if CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_DEFAULT then
			f7_arg0.leftButtonList:addElement(f7_arg0.scoreboardBtn)
			f7_arg0.leftButtonList:addElement(f7_arg0.overheadMapBtn)
			if Engine.IsDemoShoutcaster() == false then
				f7_arg0.leftButtonList:addElement(f7_arg0.viewToggleBtn)
			end
			f7_arg0.leftButtonList:addElement(f7_arg0.hudToggleBtn)
			f7_arg0.leftButtonList:addElement(f7_arg0.spectatorControlsBtn)
			f7_arg0.leftButtonList:addElement(f7_arg0.menuBtn)
		elseif CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_MAP then
			f7_arg0.leftButtonList:addElement(f7_arg0.overheadMapBtn)
			f7_arg0.leftButtonList:addElement(f7_arg0.hudToggleBtn)
			f7_arg0.leftButtonList:addElement(f7_arg0.spectatorControlsBtn)
			f7_arg0.leftButtonList:addElement(f7_arg0.menuBtn)
		elseif CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_SCOREBOARD then
			f7_arg0.leftButtonList:addElement(f7_arg0.scoreboardBtn)
		end
	else
		if CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_DEFAULT then
			f7_arg0.leftButtonList:addElement(f7_arg0.overheadMapBtn)
			f7_arg0.leftButtonList:addElement(f7_arg0.hudToggleBtn)
			f7_arg0.leftButtonList:addElement(f7_arg0.hideSpectaterControlsBtn)
		elseif CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_MAP then
			f7_arg0.leftButtonList:addElement(f7_arg0.overheadMapBtn)
			f7_arg0.leftButtonList:addElement(f7_arg0.hudToggleBtn)
			f7_arg0.leftButtonList:addElement(f7_arg0.hideSpectaterControlsBtn)
		elseif CoD.SpectateButtonBar.Mode == CoD.SpectateButtonBar.MODE_SCOREBOARD then
			f7_arg0.leftButtonList:addElement(f7_arg0.scoreboardBtn)
			f7_arg0.leftButtonList:addElement(f7_arg0.hudToggleBtn)
			f7_arg0.leftButtonList:addElement(f7_arg0.hideSpectaterControlsBtn)
		end
		f7_arg0.rightButtonList:removeAllChildren()
		if f7_arg0.m_selectedTab == CoD.SpectateSidePanel.DisplayOptionsTabIndex then
			if not CoD.isPC then
				f7_arg0.rightButtonList:addElement(f7_arg0.changeDisplayOptions)
				f7_arg0.rightButtonList:addElement(f7_arg0.selectDisplayOptions)
			end
		elseif f7_arg0.m_selectedTab == CoD.SpectateSidePanel.PlayersTabIndex then
			f7_arg0.rightButtonList:addElement(f7_arg0.spectatePlayerBtn)
			if Engine.IsDemoShoutcaster() == false then
				if Engine.GetGametypeSetting("teamCount") == 1 then
					f7_arg0.rightButtonList:addElement(f7_arg0.listenInBtnFFA)
				else
					f7_arg0.rightButtonList:addElement(f7_arg0.listenInBtn)
				end
			end
			if not CoD.isPC then
				f7_arg0.rightButtonList:addElement(f7_arg0.highlightPlayerBtn)
			end
		end
	end
end

CoD.SpectateButtonBar.SetMode = function (f8_arg0, f8_arg1)
	CoD.SpectateButtonBar.Mode = f8_arg1
	CoD.SpectateButtonBar.SetModeInternal(f8_arg0)
end

CoD.SpectateButtonBar.SetFullscreen = function (f9_arg0, f9_arg1, f9_arg2)
	CoD.SpectateButtonBar.m_isFullscreen = f9_arg1
	CoD.SpectateButtonBar.m_selectedTab = f9_arg2
	if CoD.SpectateButtonBar.Mode ~= -1 then
		f9_arg0:setMode(CoD.SpectateButtonBar.Mode)
	end
end

CoD.SpectateButtonBar.PlayerSelected = function (f10_arg0, f10_arg1)
	if f10_arg0.m_waitingForPlayers == true and f10_arg1.info.teamID ~= CoD.TEAM_SPECTATOR then
		f10_arg0.m_inputDisabled = false
		CoD.SpectateButtonBar.Show(f10_arg0, f10_arg1)
		f10_arg0.m_waitingForPlayers = false
	elseif f10_arg1.info.teamID == CoD.TEAM_SPECTATOR then
		f10_arg0.m_inputDisabled = true
		CoD.SpectateButtonBar.Hide(f10_arg0, f10_arg1)
		f10_arg0.m_waitingForPlayers = true
	end
end

CoD.SpectateButtonBar.UpdateButtonPrompts = function (f11_arg0, f11_arg1)
	if f11_arg1.invalidPlayer ~= nil and f11_arg1.invalidPlayer == true then
		f11_arg0.spectatePlayerBtn:setAlpha(0)
	else
		f11_arg0.spectatePlayerBtn:setAlpha(1)
		if CoD.isPC and not Engine.LastInput_Gamepad() then
			f11_arg0.spectatePlayerBtn:setAlpha(0)
		end
	end
end

CoD.SpectateButtonBar.SlideLeft = function (f12_arg0, f12_arg1, f12_arg2)
	f12_arg0.leftButtonList:beginAnimation("moveLeftList", 200)
	f12_arg0.leftButtonList:setLeftRight(true, false, f12_arg1, f12_arg1 + f12_arg2)
	f12_arg0.rightButtonList:beginAnimation("moveRightList", 200)
	f12_arg0.rightButtonList:setLeftRight(false, true, -CoD.SpectateButtonBar.HorizontalPadding, -20)
	f12_arg0.rightButtonList:setAlpha(1)
end

CoD.SpectateButtonBar.SlideRight = function (f13_arg0)
	f13_arg0.leftButtonList:beginAnimation("moveLeftList", 200)
	f13_arg0.leftButtonList:setLeftRight(true, true, 0, 0)
	f13_arg0.rightButtonList:beginAnimation("moveRightList", 200)
	f13_arg0.rightButtonList:setLeftRight(false, true, 0, CoD.SpectateButtonBar.HorizontalPadding)
	f13_arg0.rightButtonList:setAlpha(0)
end

CoD.SpectateButtonBar.new = function (f14_arg0, f14_arg1, f14_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(false, true, -CoD.SpectateButtonBar.Height, 0)
	Widget:setClass(CoD.SpectateButtonBar)
	Widget.m_ownerController = f14_arg0
	Widget.m_inputDisabled = false
	Widget.m_waitingForPlayers = true
	Widget.m_listening = false
	local f14_local1 = (f14_arg2 - f14_arg1) / 2
	Widget.bg = LUI.UIImage.new()
	Widget.bg:setLeftRight(true, true, -f14_local1, f14_local1)
	Widget.bg:setTopBottom(true, true, 0, 0)
	Widget.bg:setImage(RegisterMaterial("hud_shoutcasting_bar_stretch"))
	Widget.bg:setAlpha(CoD.SpectateHUD.BgAlpha)
	Widget.leftButtonList = LUI.UIHorizontalList.new()
	Widget.leftButtonList:setLeftRight(true, true, 0, 0)
	Widget.leftButtonList:setTopBottom(true, true, 0, 0)
	Widget.leftButtonList:setSpacing(5)
	Widget.leftButtonList:setAlignment(LUI.Alignment.Center)
	Widget.rightButtonList = LUI.UIHorizontalList.new()
	Widget.rightButtonList:setLeftRight(false, true, 0, CoD.SpectateButtonBar.HorizontalPadding)
	Widget.rightButtonList:setTopBottom(true, true, 0, 0)
	Widget.rightButtonList:setSpacing(5)
	Widget.rightButtonList:setAlignment(LUI.Alignment.Right)
	local f14_local2 = CoD.SpectateButtonBar.GetSpectatorString(f14_arg0)
	local f14_local3 = CoD.ButtonPrompt.new
	local f14_local4 = "select"
	local f14_local5 = Engine.Localize("MPUI_SCOREBOARD")
	local f14_local6 = Widget
	local f14_local7 = "spectate_scoreboard"
	local f14_local8, f14_local9 = false
	local f14_local10, f14_local11 = false
	Widget.scoreboardBtn = f14_local3(f14_local4, f14_local5, f14_local6, f14_local7, f14_local8, f14_local9, f14_local10, f14_local11, "TAB")
	f14_local3 = CoD.ButtonPrompt.new
	f14_local4 = "alt1"
	f14_local5 = Engine.Localize("MPUI_OVERHEAD_MAP")
	f14_local6 = Widget
	f14_local7 = "spectate_overhead_map"
	f14_local8, f14_local9 = false
	f14_local10, f14_local11 = false
	Widget.overheadMapBtn = f14_local3(f14_local4, f14_local5, f14_local6, f14_local7, f14_local8, f14_local9, f14_local10, f14_local11, "M")
	f14_local3 = CoD.ButtonPrompt.new
	f14_local4 = "alt2"
	f14_local5 = Engine.Localize(f14_local2)
	f14_local6 = Widget
	f14_local7 = "spectate_toggle_view"
	f14_local8, f14_local9 = false
	Widget.viewToggleBtn = f14_local3(f14_local4, f14_local5, f14_local6, f14_local7, f14_local8, f14_local9, false, "mouse3", nil)
	f14_local3 = CoD.ButtonPrompt.new
	f14_local4 = "secondary"
	f14_local5 = Engine.Localize("MPUI_TOGGLE_TOOLBAR")
	f14_local6 = Widget
	f14_local7 = "spectate_toggle_hud"
	f14_local8, f14_local9 = false
	f14_local10, f14_local11 = false
	Widget.hudToggleBtn = f14_local3(f14_local4, f14_local5, f14_local6, f14_local7, f14_local8, f14_local9, f14_local10, f14_local11, "BACKSPACE")
	f14_local3 = CoD.ButtonPrompt.new
	f14_local4 = "right_trigger"
	f14_local5 = Engine.Localize("MPUI_SHOUTCASTER_CONTROLS")
	f14_local6 = Widget
	f14_local7 = "spectate_controls_open"
	f14_local8, f14_local9 = false
	f14_local10, f14_local11 = false
	Widget.spectatorControlsBtn = f14_local3(f14_local4, f14_local5, f14_local6, f14_local7, f14_local8, f14_local9, f14_local10, f14_local11, "F")
	f14_local3 = CoD.ButtonPrompt.new
	f14_local4 = "right_trigger"
	f14_local5 = Engine.Localize("MPUI_HIDE_SHOUTCASTER_CONTROLS")
	f14_local6 = Widget
	f14_local7 = "spectate_controls_close"
	f14_local8, f14_local9 = false
	f14_local10, f14_local11 = false
	Widget.hideSpectaterControlsBtn = f14_local3(f14_local4, f14_local5, f14_local6, f14_local7, f14_local8, f14_local9, f14_local10, f14_local11, "F")
	Widget.spectatePlayerBtn = CoD.ButtonPrompt.new("primary", Engine.Localize("MPUI_SPECTATE_PLAYER"))
	f14_local3 = CoD.ButtonPrompt.new
	f14_local4 = "left"
	f14_local5 = Engine.Localize("MPUI_TEAM_LISTEN_IN")
	f14_local6 = Widget
	f14_local7 = "spectate_listen_in"
	f14_local8 = nil
	f14_local9 = "dpad"
	f14_local10, f14_local11 = false
	Widget.listenInBtn = f14_local3(f14_local4, f14_local5, f14_local6, f14_local7, f14_local8, f14_local9, f14_local10, f14_local11, "L")
	f14_local3 = CoD.ButtonPrompt.new
	f14_local4 = "left"
	f14_local5 = Engine.Localize("MPUI_LISTEN_IN_ON")
	f14_local6 = Widget
	f14_local7 = "spectate_listen_in_ffa"
	f14_local8 = nil
	f14_local9 = "dpad"
	f14_local10, f14_local11 = false
	Widget.listenInBtnFFA = f14_local3(f14_local4, f14_local5, f14_local6, f14_local7, f14_local8, f14_local9, f14_local10, f14_local11, "L")
	f14_local3 = CoD.ButtonPrompt.new
	f14_local4 = "start"
	f14_local5 = Engine.Localize("MPUI_MENU")
	f14_local6 = Widget
	f14_local7 = "spectate_menu"
	f14_local8, f14_local9 = false
	Widget.menuBtn = f14_local3(f14_local4, f14_local5, f14_local6, f14_local7, f14_local8, f14_local9, false, "secondary")
	if not CoD.isPC then
		Widget.highlightPlayerBtn = CoD.ButtonPrompt.new("dpad_ud", Engine.Localize("MPUI_HIGHLIGHT_PLAYER"), Widget, "spectate_highlight_player")
		Widget.selectDisplayOptions = CoD.ButtonPrompt.new("dpad_ud", Engine.Localize("MPUI_SELECT_OPTION"))
		Widget.changeDisplayOptions = CoD.ButtonPrompt.new("dpad_lr", Engine.Localize("MPUI_CHANGE_SETTING"))
	else
		Widget.spectatePlayerBtn:registerEventHandler("input_source_changed", function (Sender, Event)
			if Event.source ~= 0 then
				Sender:setAlpha(0)
			else
				CoD.ButtonPrompt.InputSourceChanged(Sender, Event)
			end
		end)
	end
	Widget.setMode = CoD.SpectateButtonBar.SetMode
	Widget.setFullscreen = CoD.SpectateButtonBar.SetFullscreen
	Widget.slideLeft = CoD.SpectateButtonBar.SlideLeft
	Widget.slideRight = CoD.SpectateButtonBar.SlideRight
	Widget:addElement(Widget.bg)
	Widget:addElement(Widget.leftButtonList)
	Widget:addElement(Widget.rightButtonList)
	Widget:setFullscreen(true)
	Widget:setMode(CoD.SpectateButtonBar.MODE_DEFAULT)
	Widget.m_inputDisabled = true
	Widget:setAlpha(0)
	return Widget
end

CoD.SpectateButtonBar.DisableInput = function (f15_arg0, f15_arg1)
	f15_arg0.m_inputDisabled = true
end

CoD.SpectateButtonBar.EnableInput = function (f16_arg0, f16_arg1)
	if f16_arg0.m_waitingForPlayers == false then
		f16_arg0.m_inputDisabled = false
	end
end

CoD.SpectateButtonBar.ListenInFFA = function (f17_arg0, f17_arg1)
	if f17_arg0.m_listening == true then
		f17_arg0.m_listening = false
		CoD.ButtonPrompt.SetText(f17_arg0.listenInBtnFFA, Engine.Localize("MPUI_LISTEN_IN_ON"))
	else
		f17_arg0.m_listening = true
		CoD.ButtonPrompt.SetText(f17_arg0.listenInBtnFFA, Engine.Localize("MPUI_LISTEN_IN_OFF"))
	end
	f17_arg1.name = "spectate_listen_in"
	CoD.SpectateButtonBar.ButtonEvent(f17_arg0, f17_arg1)
end

CoD.SpectateButtonBar:registerEventHandler("spectate_scoreboard", CoD.SpectateButtonBar.ButtonEvent)
CoD.SpectateButtonBar:registerEventHandler("spectate_overhead_map", CoD.SpectateButtonBar.ButtonEvent)
CoD.SpectateButtonBar:registerEventHandler("spectate_toggle_view", CoD.SpectateButtonBar.ButtonEvent)
CoD.SpectateButtonBar:registerEventHandler("spectate_toggle_hud", CoD.SpectateButtonBar.ButtonEvent)
CoD.SpectateButtonBar:registerEventHandler("spectate_controls_open", CoD.SpectateButtonBar.ButtonEvent)
CoD.SpectateButtonBar:registerEventHandler("spectate_controls_close", CoD.SpectateButtonBar.ButtonEvent)
CoD.SpectateButtonBar:registerEventHandler("spectate_listen_in", CoD.SpectateButtonBar.ButtonEvent)
CoD.SpectateButtonBar:registerEventHandler("spectate_listen_in_ffa", CoD.SpectateButtonBar.ListenInFFA)
CoD.SpectateButtonBar:registerEventHandler("spectate_player_selected", CoD.SpectateButtonBar.PlayerSelected)
CoD.SpectateButtonBar:registerEventHandler("update_spectate_buttom_prompts", CoD.SpectateButtonBar.UpdateButtonPrompts)
CoD.SpectateButtonBar:registerEventHandler("spectate_disable_input", CoD.SpectateButtonBar.DisableInput)
CoD.SpectateButtonBar:registerEventHandler("spectate_enable_input", CoD.SpectateButtonBar.EnableInput)
CoD.SpectateButtonBar:registerEventHandler("update_spectate_hud", CoD.SpectateButtonBar.Update)
CoD.SpectateButtonBar:registerEventHandler("hide_spectate_hud", CoD.SpectateButtonBar.Hide)
CoD.SpectateButtonBar:registerEventHandler("show_spectate_hud", CoD.SpectateButtonBar.Show)
