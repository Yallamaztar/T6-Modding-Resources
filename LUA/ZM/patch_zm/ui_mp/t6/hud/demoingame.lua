require("T6.Menus.FileshareSave")
CoD.DemoInGame = {}
CoD.DemoInGame.Open = function (f1_arg0, f1_arg1)
	f1_arg0:openPopup("Demo_InGame", f1_arg1.controller)
	if Engine.IsDemoShoutcaster() == true and f1_arg0.SpectateHUD ~= nil then
		f1_arg0.SpectateHUD:processEvent({
			name = "spectate_ingame_menu_opened",
			controller = f1_arg1.controller
		})
	end
end

CoD.DemoInGame.Back = function (f2_arg0, f2_arg1)
	f2_arg0:clearSavedState()
	f2_arg0:goBack(f2_arg1.controller)
	if Engine.IsDemoShoutcaster() == true and f2_arg0.occludedMenu.SpectateHUD ~= nil then
		f2_arg0.occludedMenu.SpectateHUD:processEvent({
			name = "spectate_ingame_menu_closed",
			controller = f2_arg1.controller
		})
	end
end

local f0_local0 = function (f3_arg0, f3_arg1)
	f3_arg0:saveState()
	f3_arg0:openMenu("Demo_Manage_Segments", f3_arg1.controller)
	f3_arg0:close()
end

local f0_local1 = function (f4_arg0, f4_arg1)
	local f4_local0 = Engine.GetDemoStreamedDownloadProgress()
	if f4_local0 < 100 then
		CoD.Menu.OpenDemoErrorPopup(f4_arg0, {
			controller = f4_arg1.controller,
			titleText = Engine.Localize("MENU_NOTICE"),
			messageText = Engine.Localize("MPUI_DEMO_DOWNLOAD_IN_PROGRESS", math.floor(f4_local0))
		})
		return 
	else
		CoD.DemoPopup.isClipSaveScreen = true
		f4_arg0:saveState()
		CoD.perController[f4_arg1.controller].fileshareSaveCategory = "clip"
		CoD.perController[f4_arg1.controller].fileshareSaveIsCopy = false
		CoD.perController[f4_arg1.controller].fileshareSaveIsPooled = false
		f4_arg0:openMenu("FileshareSave", f4_arg1.controller)
		f4_arg0:close()
	end
end

local f0_local2 = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0:openPopup("CustomizeHighlightReel", f5_arg1.controller)
end

local f0_local3 = function (f6_arg0, f6_arg1)
	CoD.DemoInGame.Back(f6_arg0, f6_arg1)
	Engine.Exec(f6_arg1.controller, "demo_jumptostart")
end

local f0_local4 = function (f7_arg0, f7_arg1)
	f7_arg0:saveState()
	f7_arg0:openMenu("OptionsMenu", f7_arg1.controller)
	f7_arg0:close()
end

local f0_local5 = function (f8_arg0, f8_arg1)
	f8_arg0:openPopup("DemoInGameEnd", f8_arg1.controller)
end

local f0_local6 = function (f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0:openMenu("WiiUControllerSettings", f9_arg1.controller, true)
	f9_local0:setPreviousMenu("Demo_InGame")
	f9_arg0:close()
end

local f0_local7 = function (f10_arg0)
	local f10_local0 = UIExpression.IsDemoClipPlaying() == 1
	local f10_local1 = UIExpression.IsDemoClipRecording() == 1
	local f10_local2 = UIExpression.GetDemoSegmentCount()
	local f10_local3 = UIExpression.IsRepositioningCameraMarker() == 1
	local f10_local4 = UIExpression.IsDemoHighlightReelMode() == 1
	local f10_local5 = UIExpression.GameHost() == 1
	local f10_local6 = UIExpression.InLobby() == 1
	f10_arg0:registerEventHandler("manage_segments", f0_local0)
	f10_arg0:registerEventHandler("upload_clip", f0_local1)
	f10_arg0:registerEventHandler("customize_highlight_reel", f0_local2)
	f10_arg0:registerEventHandler("demo_jump_to_start", f0_local3)
	f10_arg0:registerEventHandler("open_options", f0_local4)
	f10_arg0:registerEventHandler("demo_end", f0_local5)
	if CoD.isWIIU then
		f10_arg0:registerEventHandler("open_controls", f0_local6)
	end
	local f10_local7 = CoD.ButtonList.new({})
	f10_local7:setLeftRight(true, false, 0, CoD.ButtonList.DefaultWidth)
	f10_local7:setTopBottom(true, true, CoD.Menu.TitleHeight, 0)
	f10_local7.uploadClip = f10_local7:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_UPLOAD_CLIP", f10_local2)))
	f10_local7.uploadClip:setActionEventName("upload_clip")
	if f10_local0 or f10_local1 or f10_local2 <= 0 or f10_local3 then
		f10_local7.uploadClip:disable()
	end
	f10_local7.manageSegments = f10_local7:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_DEMO_MANAGE_SEGMENTS")))
	f10_local7.manageSegments:setActionEventName("manage_segments")
	if f10_local0 or f10_local1 or f10_local2 <= 0 or f10_local3 then
		f10_local7.manageSegments:disable()
	end
	if f10_local4 then
		f10_local7.customizeHighlightReel = f10_local7:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_DEMO_CUSTOMIZE_HIGHLIGHT_REEL")))
		if f10_local1 or f10_local3 or not f10_local5 or not f10_local6 then
			f10_local7.customizeHighlightReel:disable()
		end
		f10_local7.customizeHighlightReel:setActionEventName("customize_highlight_reel")
	end
	f10_local7.options = f10_local7:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_OPTIONS")))
	f10_local7.options:setActionEventName("open_options")
	if CoD.isWIIU then
		f10_local7.controls = f10_local7:addButton(Engine.Localize("MENU_CONTROLLER_SETTINGS_CAPS"))
		f10_local7.controls:setActionEventName("open_controls")
	end
	f10_local7.jumpToStart = f10_local7:addButton(UIExpression.ToUpper(nil, Engine.Localize("MENU_JUMP_TO_START")))
	f10_local7.jumpToStart:setActionEventName("demo_jump_to_start")
	if f10_local1 or f10_local3 or not f10_local5 or not f10_local6 then
		f10_local7.jumpToStart:disable()
	end
	local f10_local8 = nil
	if f10_local0 then
		f10_local8 = UIExpression.ToUpper(nil, Engine.Localize("MENU_END_CLIP"))
	else
		f10_local8 = UIExpression.ToUpper(nil, Engine.Localize("MENU_END_FILM"))
	end
	f10_local7.endDemo = f10_local7:addButton(f10_local8)
	f10_local7.endDemo:setActionEventName("demo_end")
	f10_arg0.buttonList = f10_local7
	f10_arg0:addElement(f10_local7)
	if not f10_arg0:restoreState() then
		f10_arg0.buttonList.uploadClip:processEvent({
			name = "gain_focus"
		})
	end
end

LUI.createMenu.Demo_InGame = function (f11_arg0)
	local f11_local0 = UIExpression.IsDemoClipPlaying() == 1
	local f11_local1 = CoD.InGameMenu.New("Demo_InGame", f11_arg0, Engine.Localize("MENU_THEATER_CAPS"))
	f11_local1:setOwner(f11_arg0)
	CoD.InGameMenu.addButtonPrompts(f11_local1)
	f11_local1:registerEventHandler("button_prompt_back", CoD.DemoInGame.Back)
	f11_local1:registerEventHandler("button_prompt_start", CoD.DemoInGame.Back)
	f0_local7(f11_local1)
	return f11_local1
end

local f0_local8 = function (f12_arg0, f12_arg1)
	local f12_local0 = UIExpression.GameHost() == 1
	f12_arg0:goBack(f12_arg1.controller)
	if not f12_local0 then
		Engine.GameModeResetModes()
		Engine.SessionModeResetModes()
		Engine.Exec(f12_arg1.controller, "disconnect")
	else
		Engine.Exec(f12_arg1.controller, "xpartystopdemo")
	end
end

local f0_local9 = function (f13_arg0, f13_arg1)
	f13_arg0.occludedMenu:processEvent(f13_arg1)
	f13_arg0:goBack(f13_arg1.controller)
end

LUI.createMenu.DemoInGameEnd = function (f14_arg0)
	local f14_local0 = UIExpression.IsClipModified() == 1
	local f14_local1 = UIExpression.IsDemoClipPlaying() == 1
	local f14_local2 = UIExpression.GameHost() == 1
	local f14_local3 = CoD.Menu.NewSmallPopup("DemoInGameEnd")
	f14_local3:setOwner(f14_arg0)
	f14_local3:addSelectButton()
	f14_local3:addBackButton()
	f14_local3:registerEventHandler("leave_demo", f0_local8)
	f14_local3:registerEventHandler("upload_clip", f0_local9)
	local f14_local4 = 120
	local f14_local5 = 5
	local f14_local6 = LUI.UIText.new()
	f14_local6:setLeftRight(true, true, 0, 0)
	f14_local6:setTopBottom(true, false, f14_local5, f14_local5 + CoD.textSize.Big)
	f14_local6:setFont(CoD.fonts.Big)
	f14_local6:setAlignment(LUI.Alignment.Left)
	if not f14_local1 then
		if f14_local2 then
			f14_local6:setText(Engine.Localize("MPUI_LEAVE_FILM"))
		else
			f14_local6:setText(Engine.Localize("MPUI_END_FILM"))
		end
	elseif f14_local2 then
		f14_local6:setText(Engine.Localize("MPUI_LEAVE_CLIP"))
	else
		f14_local6:setText(Engine.Localize("MPUI_END_CLIP"))
	end
	f14_local3:addElement(f14_local6)
	f14_local5 = f14_local5 + CoD.textSize.Big + 10
	if f14_local0 then
		local f14_local7 = LUI.UIText.new()
		f14_local7:setLeftRight(true, true, 0, 0)
		f14_local7:setTopBottom(true, false, f14_local5, f14_local5 + CoD.textSize.Condensed)
		f14_local7:setFont(CoD.fonts.Condensed)
		f14_local7:setAlignment(LUI.Alignment.Left)
		f14_local7:setText(Engine.Localize("MENU_DEMO_UNUPLOADED_CLIP"))
		f14_local3:addElement(f14_local7)
	end
	local f14_local7 = CoD.ButtonList.new({})
	f14_local7:setLeftRight(true, true, 0, 0)
	f14_local7:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 4 + 10, 0)
	f14_local3:addElement(f14_local7)
	if not f14_local0 then
		f14_local7:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10, 0)
		local f14_local8 = f14_local7:addButton(Engine.Localize("MENU_YES"))
		f14_local8:setActionEventName("leave_demo")
		local f14_local9 = f14_local7:addButton(Engine.Localize("MENU_NO"))
		f14_local9:setActionEventName("button_prompt_back")
		f14_local9:processEvent({
			name = "gain_focus"
		})
	else
		local f14_local8 = f14_local7:addButton(Engine.Localize("MENU_SAVE_CLIP"))
		f14_local8:processEvent({
			name = "gain_focus"
		})
		f14_local8:setActionEventName("upload_clip")
		local f14_local9 = f14_local7:addButton(Engine.Localize("MENU_END_FILM_WITHOUT_SAVING"))
		f14_local9:setActionEventName("leave_demo")
		local f14_local10 = f14_local7:addButton(Engine.Localize("MENU_CANCEL"))
		f14_local10:setActionEventName("button_prompt_back")
	end
	return f14_local3
end

