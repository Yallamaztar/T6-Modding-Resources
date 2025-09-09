require("T6.Menus.FileshareVote")
CoD.FileAction = {}
CoD.FileAction.AnyFileshareTaskInProgress = function (f1_arg0)
	if UIExpression.IsTaskInProgress(f1_arg0, "LiveFileShareRemoveFile") == 1 then
		return true
	elseif UIExpression.IsTaskInProgress(f1_arg0, "LiveFileShareWriteFile") == 1 then
		return true
	elseif UIExpression.IsTaskInProgress(f1_arg0, "LiveFileShareTransfer") == 1 then
		return true
	elseif UIExpression.IsTaskInProgress(f1_arg0, "LiveFileShareReadFile") == 1 then
		return true
	elseif UIExpression.IsTaskInProgress(f1_arg0, "LiveFileGetShareSummary") == 1 then
		return true
	else
		return false
	end
end

CoD.FileAction.GoToTheater = function (f2_arg0, f2_arg1)
	if UIExpression.CanSwitchToLobby(f2_arg1.controller, Dvar.party_maxplayers_theater:get(), Dvar.party_maxlocalplayers_theater:get()) == 0 then
		Dvar.ui_errorTitle:set(Engine.Localize("MENU_NOTICE_CAPS"))
		Dvar.ui_errorMessage:set(Engine.Localize("MENU_FILESHARE_MAX_LOCAL_PLAYERS"))
		CoD.Menu.OpenErrorPopup(f2_arg0, {
			controller = f2_arg1.controller
		})
	else
		local f2_local0 = f2_arg1.controller
		local f2_local1 = UIExpression.GameHost(f2_local0)
		local f2_local2 = UIExpression.InLobby(f2_local0)
		local f2_local3 = UIExpression.PrivatePartyHost(f2_local0)
		local f2_local4
		if f2_local1 ~= 1 or f2_local2 ~= 1 then
			f2_local4 = false
		else
			f2_local4 = true
		end
		f2_arg0:registerEventHandler("go_to_theater", CoD.NullFunction)
		f2_arg0:registerEventHandler("button_prompt_back", CoD.NullFunction)
		Engine.ExecNow(f2_local0, "xstopparty")
		if f2_local4 then
			Engine.ExecNow(f2_local0, "xstopprivateparty")
		end
		CoD.SwitchToTheaterLobby(f2_local0)
		Engine.ExecNow(f2_local0, "setactivemenu theater")
		CoD.FileAction.LoadFile(f2_arg0.info)
	end
end

CoD.FileAction.LoadFile = function (f3_arg0)
	local f3_local0, f3_local1 = nil
	if f3_arg0 == nil then
		return 
	end
	local f3_local2 = f3_arg0.controller
	Engine.SetDvar("ui_mapname", f3_arg0.map)
	Engine.SetDvar("ui_gametype", f3_arg0.gametype)
	if CoD.isZombie == true then
		Engine.SetDvar("ui_zm_mapstartlocation", f3_arg0.zmmapstartloc)
	end
	Engine.SetDvar("ui_demoname", "Film.demo")
	if f3_arg0.isPooled then
		f3_local0 = 0
	else
		f3_local0 = 1
	end
	if f3_arg0.authorXUID ~= nil then
		f3_local1 = f3_arg0.authorXUID
	else
		f3_local1 = 0
	end
	Engine.SetTheaterFileInfo(true, f3_arg0)
	Engine.Exec(f3_local2, "xpartyupdatedemo " .. f3_local0 .. " " .. f3_arg0.fileid .. " " .. f3_arg0.filesize .. " Film.demo " .. f3_local1)
	Engine.Exec(f3_local2, "xupdatepartystate")
end

CoD.FileAction.Open = function (f4_arg0, f4_arg1)
	if CoD.perController[f4_arg1.controller].fileActionInfo.category == "screenshot" then
		f4_arg0:openPopup("Screenshot_Viewer", f4_arg1.controller, f4_arg1.targetCarousel)
	elseif UIExpression.GameMode_IsMode(f4_arg1.controller, CoD.GAMEMODE_THEATER) == 1 then
		if UIExpression.GameHost() == 1 then
			CoD.FileAction.LoadFile(f4_arg1)
			f4_arg0:dispatchEventToRoot({
				name = "close_all_popups",
				controller = f4_arg1.controller
			})
		else
			Dvar.ui_errorTitle:set(Engine.Localize("MENU_NOTICE_CAPS"))
			Dvar.ui_errorMessage:set(Engine.Localize("MENU_FILESHARE_ONLY_HOST_ALLOWED_TO_LOAD"))
			CoD.Menu.OpenErrorPopup(f4_arg0, {
				controller = f4_arg1.controller
			})
		end
	elseif UIExpression.CanSwitchToLobby(f4_arg1.controller, Dvar.party_maxplayers_theater:get(), Dvar.party_maxlocalplayers_theater:get()) == 0 then
		Dvar.ui_errorTitle:set(Engine.Localize("MENU_NOTICE_CAPS"))
		Dvar.ui_errorMessage:set(Engine.Localize("MENU_FILESHARE_MAX_LOCAL_PLAYERS"))
		CoD.Menu.OpenErrorPopup(f4_arg0, {
			controller = f4_arg1.controller
		})
	else
		f4_arg0:openPopup("FileAction", f4_arg1.controller, f4_arg1)
	end
end

LUI.createMenu.FileAction = function (f5_arg0, f5_arg1)
	local f5_local0 = CoD.Menu.NewSmallPopup("FileAction")
	f5_local0:setOwner(f5_arg0)
	f5_local0.info = f5_arg1
	f5_local0:addSelectButton()
	f5_local0:addBackButton()
	f5_local0:registerEventHandler("go_to_theater", CoD.FileAction.GoToTheater)
	local f5_local1 = 5
	local f5_local2 = LUI.UIText.new()
	f5_local2:setLeftRight(true, true, 0, 0)
	f5_local2:setTopBottom(true, false, f5_local1, f5_local1 + CoD.textSize.Condensed)
	f5_local2:setFont(CoD.fonts.Condensed)
	f5_local2:setAlignment(LUI.Alignment.Left)
	f5_local2:setText(Engine.Localize("MENU_GO_TO_THEATER_CONFIRMATION"))
	f5_local0:addElement(f5_local2)
	local f5_local3 = CoD.ButtonList.new({})
	f5_local3:setLeftRight(true, true, 0, 0)
	f5_local3:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10, 0)
	f5_local0:addElement(f5_local3)
	local f5_local4 = f5_local3:addButton(Engine.Localize("MENU_YES"))
	f5_local4:setActionEventName("go_to_theater")
	local f5_local5 = f5_local3:addButton(Engine.Localize("MENU_NO"))
	f5_local5:setActionEventName("button_prompt_back")
	f5_local5:processEvent({
		name = "gain_focus"
	})
	return f5_local0
end

CoD.FileAction.GoToCustomGames = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.controller
	local f6_local1 = UIExpression.GameHost(f6_local0)
	local f6_local2 = UIExpression.InLobby(f6_local0)
	local f6_local3 = UIExpression.PrivatePartyHost(f6_local0)
	local f6_local4
	if f6_local1 ~= 1 or f6_local2 ~= 1 then
		f6_local4 = false
	else
		f6_local4 = true
	end
	Engine.ExecNow(f6_local0, "xstopparty")
	if f6_local4 then
		Engine.ExecNow(f6_local0, "xstopprivateparty")
	end
	Dvar.fshCustomGameName:set(f6_arg0.m_fileName)
	CoD.SwitchToPrivateLobby(f6_local0)
	Engine.SetActiveMenu(f6_arg1.controller, CoD.UIMENU_PRIVATELOBBY)
	Engine.Exec(f6_local0, "gamesettings_download " .. f6_arg0.m_fileID .. " " .. f6_arg0.m_gameType)
end

LUI.createMenu.LoadCustomGames = function (f7_arg0, f7_arg1)
	local f7_local0 = CoD.Menu.NewSmallPopup("LoadCustomGames")
	f7_local0:setOwner(f7_arg0)
	f7_local0.m_fileID = f7_arg1.fileID
	f7_local0.m_gameType = f7_arg1.gameType
	f7_local0.m_fileName = f7_arg1.fileName
	f7_local0:addSelectButton()
	f7_local0:addBackButton()
	f7_local0:registerEventHandler("go_to_customgames", CoD.FileAction.GoToCustomGames)
	local f7_local1 = 5
	local f7_local2 = LUI.UIText.new()
	f7_local2:setLeftRight(true, true, 0, 0)
	f7_local2:setTopBottom(true, false, f7_local1, f7_local1 + CoD.textSize.Condensed)
	f7_local2:setFont(CoD.fonts.Condensed)
	f7_local2:setAlignment(LUI.Alignment.Left)
	f7_local2:setText(Engine.Localize("MENU_GO_TO_CUSTOM_GAME_CONFIRMATION"))
	f7_local0:addElement(f7_local2)
	local f7_local3 = CoD.ButtonList.new({})
	f7_local3:setLeftRight(true, true, 0, 0)
	f7_local3:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 3 + 10, 0)
	f7_local0:addElement(f7_local3)
	local f7_local4 = f7_local3:addButton(Engine.Localize("MENU_YES"))
	f7_local4:setActionEventName("go_to_customgames")
	local f7_local5 = f7_local3:addButton(Engine.Localize("MENU_NO"))
	f7_local5:setActionEventName("button_prompt_back")
	f7_local5:processEvent({
		name = "gain_focus"
	})
	return f7_local0
end

function ScreenshotViewer_Back(f8_arg0, f8_arg1)
	Engine.ExecNow(f8_arg1.controller, "screenshotViewerAbortDownload")
	f8_arg0:goBack(f8_arg1.controller)
end

function ScreenshotViewer_DownloadScreenshot(f9_arg0, f9_arg1)
	if CoD.FileAction.AnyFileshareTaskInProgress(f9_arg0.info.controller) then
		return 
	else
		Engine.Exec(f9_arg0.info.controller, "screenshotViewerDownload " .. f9_arg0.info.fileID .. " " .. f9_arg0.info.fileSize)
		f9_arg0.downloadTimer:close()
	end
end

function ScreenshotViewer_ToggleControls(f10_arg0, f10_arg1)
	if f10_arg0.m_controlsVisible == true then
		f10_arg0.leftButtonPromptBar:setAlpha(0)
		f10_arg0.rightButtonPromptBar:setAlpha(0)
		f10_arg0.buttonBarBg:setAlpha(0)
		f10_arg0.m_controlsVisible = false
		if CoD.useMouse then
			f10_arg0.leftButtonPromptBar:setMouseDisabled(true)
			f10_arg0.rightButtonPromptBar:setMouseDisabled(true)
		end
	else
		f10_arg0.leftButtonPromptBar:setAlpha(1)
		f10_arg0.rightButtonPromptBar:setAlpha(1)
		f10_arg0.buttonBarBg:setAlpha(0.8)
		f10_arg0.m_controlsVisible = true
		if CoD.useMouse then
			f10_arg0.leftButtonPromptBar:setMouseDisabled(false)
			f10_arg0.rightButtonPromptBar:setMouseDisabled(false)
		end
	end
end

function ScreenshotViewer_GamepadButton(f11_arg0, f11_arg1)
	if f11_arg0.m_inputDisabled then
		return 
	elseif f11_arg1.qualifier == "mwheel" then
		local f11_local0 = 0.05
		if f11_arg1.button == "up" then
			Engine.Exec(f11_arg1.controller, "screenshotChangeZoom " .. f11_local0)
		else
			Engine.Exec(f11_arg1.controller, "screenshotChangeZoom " .. -f11_local0)
		end
	else
		f11_arg0:dispatchEventToChildren(f11_arg1)
	end
end

function ScreenshotViewer_DetailsFadeOut(f12_arg0, f12_arg1)
	f12_arg0.detailsPane:completeAnimation()
	f12_arg0.detailsPane:beginAnimation("fade_out", 750)
	f12_arg0.detailsPane:setAlpha(0)
end

function ScreenshotViewer_Vote(f13_arg0, f13_arg1)
	CoD.perController[f13_arg1.controller].voteData = f13_arg0.info
	CoD.perController[f13_arg1.controller].voteUpdateTarget = f13_arg0
	local f13_local0 = f13_arg0:openPopup("FileshareVote", f13_arg1.controller)
end

function ScreenshotViewer_CanMoveNext(f14_arg0)
	local f14_local0 = f14_arg0.cardCarousels[f14_arg0.m_currentCardCarouselIndex]
	if f14_local0 == nil then
		return false
	elseif f14_local0.horizontalList.cards[f14_local0.horizontalList.m_currentCardIndex] == nil then
		return false
	elseif f14_local0.horizontalList.m_currentCardIndex == #f14_local0.horizontalList.cards then
		return false
	else
		local f14_local1 = f14_local0.horizontalList.cards[f14_local0.horizontalList.m_currentCardIndex + 1]
		if f14_local1.fileData == nil or f14_local1.fileData.category ~= "screenshot" then
			return false
		else
			return true
		end
	end
end

function ScreenshotViewer_CanMovePrev(f15_arg0)
	local f15_local0 = f15_arg0.cardCarousels[f15_arg0.m_currentCardCarouselIndex]
	if f15_local0 == nil then
		return false
	elseif f15_local0.horizontalList.cards[f15_local0.horizontalList.m_currentCardIndex] == nil then
		return false
	elseif f15_local0.horizontalList.m_currentCardIndex == 1 then
		return false
	else
		local f15_local1 = f15_local0.horizontalList.cards[f15_local0.horizontalList.m_currentCardIndex - 1]
		if f15_local1.fileData == nil or f15_local1.fileData.category ~= "screenshot" then
			return false
		else
			return true
		end
	end
end

function ScreenshotViewer_UpdateButtonPrompts(f16_arg0)
	f16_arg0.rightButtonPromptBar:removeAllChildren()
	if CoD.isPS3 then
		f16_arg0:addRightButtonPrompt(CoD.ButtonPrompt.new("emblem_move", Engine.Localize("MPUI_PAN"), f16_arg0, nil))
	else
		local f16_local0 = CoD.ButtonPrompt.new
		local f16_local1 = "left_stick_up"
		local f16_local2 = Engine.Localize("MPUI_PAN")
		local f16_local3 = f16_arg0
		local f16_local4 = nil
		local f16_local5, f16_local6 = false
		f16_arg0:addRightButtonPrompt(f16_local0(f16_local1, f16_local2, f16_local3, f16_local4, f16_local5, f16_local6, false, "mouse1"))
	end
	local f16_local0 = CoD.ButtonPrompt.new
	local f16_local1 = "right_trigger"
	local f16_local2 = Engine.Localize("MPUI_ZOOM")
	local f16_local3 = f16_arg0
	local f16_local4 = nil
	local f16_local5, f16_local6 = false
	f16_arg0:addRightButtonPrompt(f16_local0(f16_local1, f16_local2, f16_local3, f16_local4, f16_local5, f16_local6, false, "wheelup"))
	f16_local1 = CoD.ButtonPrompt.new
	f16_local2 = "alt2"
	f16_local3 = Engine.Localize("MENU_FILESHARE_LIKEDISLIKE")
	f16_local4 = f16_arg0
	f16_local5 = "scr_vote"
	local f16_local6, f16_local7 = false
	local f16_local8, f16_local9 = false
	f16_arg0:addRightButtonPrompt(f16_local1(f16_local2, f16_local3, f16_local4, f16_local5, f16_local6, f16_local7, f16_local8, f16_local9, "L"))
	if ScreenshotViewer_CanMoveNext(f16_arg0.m_targetCarouselList) then
		f16_local2 = CoD.ButtonPrompt.new
		f16_local3 = "shoulderr"
		f16_local4 = Engine.Localize("MENU_NEXT")
		f16_local5 = f16_arg0
		f16_local6 = "scr_movenext"
		f16_local7, f16_local8 = false
		local f16_local9, f16_local10 = false
		f16_arg0:addRightButtonPrompt(f16_local2(f16_local3, f16_local4, f16_local5, f16_local6, f16_local7, f16_local8, f16_local9, f16_local10, "D"))
	end
	if ScreenshotViewer_CanMovePrev(f16_arg0.m_targetCarouselList) then
		f16_local2 = CoD.ButtonPrompt.new
		f16_local3 = "shoulderl"
		f16_local4 = Engine.Localize("MENU_PREVIOUS")
		f16_local5 = f16_arg0
		f16_local6 = "scr_moveprev"
		f16_local7, f16_local8 = false
		local f16_local9, f16_local10 = false
		f16_arg0:addRightButtonPrompt(f16_local2(f16_local3, f16_local4, f16_local5, f16_local6, f16_local7, f16_local8, f16_local9, f16_local10, "A"))
	end
end

function ScreenshotViewer_Reload(f17_arg0, f17_arg1)
	f17_arg0.info = CoD.perController[f17_arg1].fileActionInfo
	if f17_arg0.info == nil or f17_arg0.info.category ~= "screenshot" then
		f17_arg0:goBack(f17_arg1)
		return 
	end
	f17_arg0.detailsPane:completeAnimation()
	f17_arg0.detailsPane:setAlpha(1)
	f17_arg0.name:setText(f17_arg0.info.name)
	f17_arg0.author:setText(Engine.Localize("MENU_FILESHARE_AUTHOR") .. " " .. f17_arg0.info.author)
	f17_arg0.description:setText(f17_arg0.info.description)
	local f17_local0 = 720
	local f17_local1 = 1280
	if not Dvar.hiDef:get() or not Dvar.widescreen:get() then
		f17_local1 = 960
		f17_local0 = f17_local1 * 9 / 16
	end
	local screenshot = LUI.UIImage.new()
	screenshot:setLeftRight(false, false, -f17_local1 / 2, f17_local1 / 2)
	screenshot:setTopBottom(false, false, -f17_local0 / 2, f17_local0 / 2)
	screenshot:setRGB(1, 1, 1)
	screenshot:setAlpha(1)
	screenshot:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_SCREENSHOT, tostring(f17_arg0.info.fileID))
	screenshot:setPriority(-5)
	f17_arg0:addElement(screenshot)
	f17_arg0.screenshot = screenshot
	
	if f17_arg0.downloadTimer ~= nil then
		f17_arg0.downloadTimer:close()
		f17_arg0.downloadTimer = nil
	end
	f17_arg0.downloadTimer = LUI.UITimer.new(2000, {
		name = "download_screenshot",
		controller = f17_arg1
	}, false)
	f17_arg0:addElement(f17_arg0.downloadTimer)
	if f17_arg0.detailsFadeOutTime ~= nil then
		f17_arg0.detailsFadeOutTime:close()
		f17_arg0.detailsFadeOutTime = nil
	end
	f17_arg0.detailsFadeOutTime = LUI.UITimer.new(10000, {
		name = "details_fadeout",
		controller = f17_arg1
	}, false)
	f17_arg0:addElement(f17_arg0.detailsFadeOutTime)
	ScreenshotViewer_UpdateButtonPrompts(f17_arg0)
	if CoD.isPC then
		Engine.Exec(f17_arg1, "screenshotZoom 0.0f")
	end
end

function ScreenshotViewer_SimulateMove(f18_arg0, f18_arg1, f18_arg2)
	if f18_arg0.m_targetCarouselList ~= nil then
		Engine.ExecNow(f18_arg2, "screenshotViewerAbortDownload")
		f18_arg0.screenshot:close()
		f18_arg0.m_targetCarouselList:processEvent({
			name = f18_arg1,
			controller = f18_arg2
		})
		ScreenshotViewer_Reload(f18_arg0, f18_arg2)
	end
end

function ScreenshotViewer_MoveNext(f19_arg0, f19_arg1)
	ScreenshotViewer_SimulateMove(f19_arg0, "move_next", f19_arg1.controller)
end

function ScreenshotViewer_MovePrev(f20_arg0, f20_arg1)
	ScreenshotViewer_SimulateMove(f20_arg0, "move_prev", f20_arg1.controller)
end

LUI.createMenu.Screenshot_Viewer = function (f21_arg0, f21_arg1)
	local f21_local0 = CoD.Menu.New("Screenshot_Viewer")
	f21_local0:setOwner(f21_arg0)
	f21_local0.info = CoD.perController[f21_arg0].fileActionInfo
	f21_local0.m_targetCarouselList = f21_arg1
	f21_local0.m_controlsVisible = true
	f21_local0:registerEventHandler("button_prompt_back", ScreenshotViewer_Back)
	f21_local0:registerEventHandler("download_screenshot", ScreenshotViewer_DownloadScreenshot)
	f21_local0:registerEventHandler("details_fadeout", ScreenshotViewer_DetailsFadeOut)
	f21_local0:registerEventHandler("scr_toggle_controls", ScreenshotViewer_ToggleControls)
	f21_local0:registerEventHandler("scr_vote", ScreenshotViewer_Vote)
	f21_local0:registerEventHandler("scr_movenext", ScreenshotViewer_MoveNext)
	f21_local0:registerEventHandler("scr_moveprev", ScreenshotViewer_MovePrev)
	local f21_local1 = 720
	local f21_local2 = 1280
	local f21_local3 = LUI.UIImage.new()
	f21_local3:setLeftRight(false, false, -f21_local2 / 2, f21_local2 / 2)
	f21_local3:setTopBottom(false, false, -f21_local1 / 2, f21_local1 / 2)
	f21_local3:setRGB(0, 0, 0)
	f21_local3:setAlpha(1)
	f21_local3:setPriority(-10)
	f21_local0:addElement(f21_local3)
	if CoD.isPC then
		f21_local1 = 720
		f21_local2 = f21_local1 * Engine.GetAspectRatio()
	elseif not Dvar.hiDef:get() or not Dvar.widescreen:get() then
		f21_local2 = 960
		f21_local1 = f21_local2 * 9 / 16
	end
	local f21_local4 = LUI.UIImage.new()
	f21_local4:setLeftRight(false, false, -f21_local2 / 2, f21_local2 / 2)
	f21_local4:setTopBottom(false, true, -28, 5)
	if CoD.isZombie == true then
		f21_local4:setRGB(0, 0, 0)
	else
		f21_local4:setImage(RegisterMaterial("hud_shoutcasting_bar_stretch"))
	end
	f21_local4:setAlpha(0.8)
	f21_local4:setPriority(-4)
	f21_local0.buttonBarBg = f21_local4
	f21_local0:addElement(f21_local4)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(false, true, -90, -25)
	f21_local0:addElement(Widget)
	local f21_local6 = LUI.UIImage.new()
	f21_local6:setLeftRight(false, false, -f21_local2 / 2, f21_local2 / 2)
	f21_local6:setTopBottom(true, true, 0, 0)
	f21_local6:setRGB(0, 0, 0)
	f21_local6:setAlpha(0.8)
	Widget:addElement(f21_local6)
	local f21_local7 = LUI.UIText.new()
	f21_local7:setLeftRight(true, true, 0, 0)
	f21_local7:setTopBottom(true, false, 0, CoD.textSize.Condensed)
	f21_local7:setAlignment(LUI.Alignment.Left)
	f21_local7:setText(f21_local0.info.name)
	f21_local0.name = f21_local7
	Widget:addElement(f21_local7)
	local f21_local8 = LUI.UIText.new()
	f21_local8:setLeftRight(true, true, 0, 0)
	f21_local8:setTopBottom(true, false, 0, CoD.textSize.Condensed)
	f21_local8:setAlignment(LUI.Alignment.Right)
	f21_local8:setText(Engine.Localize("MENU_FILESHARE_AUTHOR") .. " " .. f21_local0.info.author)
	f21_local0.author = f21_local8
	Widget:addElement(f21_local8)
	
	local description = LUI.UIText.new()
	description:setLeftRight(true, true, 0, 0)
	description:setTopBottom(true, false, CoD.textSize.Condensed, CoD.textSize.Condensed + CoD.textSize.ExtraSmall)
	description:setFont(CoD.fonts.ExtraSmall)
	description:setAlignment(LUI.Alignment.Left)
	description:setText(f21_local0.info.description)
	Widget:addElement(description)
	f21_local0.description = description
	
	f21_local0.detailsPane = Widget
	f21_local0:addBackButton()
	local f21_local10 = CoD.ButtonPrompt.new
	local f21_local11 = "select"
	local screenshot = Engine.Localize("MENU_DEMO_CONTROLS_TOGGLE_CONTROLS")
	local f21_local13 = f21_local0
	local f21_local14 = "scr_toggle_controls"
	local f21_local15, f21_local16 = false
	local f21_local17, f21_local18 = false
	f21_local0:addLeftButtonPrompt(f21_local10(f21_local11, screenshot, f21_local13, f21_local14, f21_local15, f21_local16, f21_local17, f21_local18, "TAB"))
	if not f21_local0.info.CRMode then
		ScreenshotViewer_UpdateButtonPrompts(f21_local0)
	end
	f21_local11 = LUI.UIText.new()
	f21_local11:setLeftRight(true, true, 0, 0)
	f21_local11:setTopBottom(true, false, 0, CoD.textSize.Big)
	f21_local11:setFont(CoD.fonts.Big)
	f21_local11:setAlignment(LUI.Alignment.Left)
	f21_local11:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f21_local11:setText(Engine.Localize("MPUI_SCREENSHOT_CAPS"))
	f21_local11:setPriority(-6)
	f21_local0:addElement(f21_local11)
	
	screenshot = LUI.UIImage.new()
	screenshot:setLeftRight(false, false, -f21_local2 / 2, f21_local2 / 2)
	screenshot:setTopBottom(false, false, -f21_local1 / 2, f21_local1 / 2)
	screenshot:setRGB(1, 1, 1)
	screenshot:setAlpha(1)
	screenshot:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_SCREENSHOT, tostring(f21_local0.info.fileID))
	screenshot:setPriority(-5)
	f21_local0:addElement(screenshot)
	f21_local0.screenshot = screenshot
	
	f21_local0.downloadTimer = LUI.UITimer.new(200, {
		name = "download_screenshot",
		controller = f21_arg0
	}, false)
	f21_local0:addElement(f21_local0.downloadTimer)
	f21_local0.detailsFadeOutTime = LUI.UITimer.new(10000, {
		name = "details_fadeout",
		controller = f21_arg0
	}, false)
	f21_local0:addElement(f21_local0.detailsFadeOutTime)
	if CoD.isPC then
		Engine.Exec(f21_arg0, "screenshotSetZoom 0.0f")
		f21_local0:registerEventHandler("gamepad_button", ScreenshotViewer_GamepadButton)
	end
	return f21_local0
end

CoD.FileAction.VideoPlayer = {}
CoD.FileAction.VideoPlayer.CloseTimerHandler = function (f22_arg0, f22_arg1)
	if CoD.Codtv.WebMPlayback ~= nil then
		Engine.WebM_Close(CoD.Codtv.WebMPlayback)
		CoD.Codtv.WebMPlayback = nil
	end
	Engine.PlayMenuMusic("mus_mp_frontend")
	f22_arg0.m_closeTimer:close()
	f22_arg0.m_closeTimer = nil
	CoD.Menu.goBack(f22_arg0, f22_arg1)
end

CoD.FileAction.VideoPlayer.GoBack = function (f23_arg0, f23_arg1)
	Engine.SetDvar("lui_disable_blur", 0)
	Engine.SetDvar("ui_drawBuildNumber", 1)
	if f23_arg0 ~= nil then
		f23_arg0.webmVideo:setAlpha(0)
		if f23_arg0.webmImage ~= nil then
			f23_arg0.webmImage:setAlpha(1)
		end
	end
	if f23_arg0.m_closeTimer ~= nil then
		return 
	else
		f23_arg0.m_closeTimer = LUI.UITimer.new(150, "video_play_end", true)
		f23_arg0:addElement(f23_arg0.m_closeTimer)
	end
end

CoD.FileAction.VideoPlayer.CloseAllPopups = function (f24_arg0, f24_arg1)
	Engine.SetDvar("lui_disable_blur", 0)
	Engine.SetDvar("ui_drawBuildNumber", 1)
	CoD.FileAction.VideoPlayer.GoBack(f24_arg0, f24_arg1.controller)
end

CoD.FileAction.VideoPlayer.BackButtonFadeout = function (f25_arg0, f25_arg1)
	f25_arg0.leftButtonPromptBar:completeAnimation()
	f25_arg0.leftButtonPromptBar:beginAnimation("disappear", 1000)
	f25_arg0.leftButtonPromptBar:setAlpha(0)
end

CoD.FileAction.VideoPlayer.PlaybackEnded = function (f26_arg0, f26_arg1)
	Engine.SetDvar("lui_disable_blur", 0)
	Engine.SetDvar("ui_drawBuildNumber", 1)
	CoD.FileAction.VideoPlayer.GoBack(f26_arg0, f26_arg0.m_ownerController)
end

LUI.createMenu.Video_Player = function (f27_arg0)
	local f27_local0 = CoD.Menu.New("Video_Player")
	f27_local0:setOwner(f27_arg0)
	f27_local0.info = CoD.perController[f27_arg0].url
	local f27_local1 = 720
	local f27_local2 = 1280
	local f27_local3 = LUI.UIImage.new()
	f27_local3:setLeftRight(false, false, -f27_local2 / 2, f27_local2 / 2)
	f27_local3:setTopBottom(false, false, -f27_local1 / 2, f27_local1 / 2)
	f27_local3:setRGB(0, 0, 0)
	f27_local3:setAlpha(1)
	f27_local3:setPriority(-10)
	f27_local0:addElement(f27_local3)
	if CoD.isPC then
		f27_local1 = 720
		f27_local2 = f27_local1 * Engine.GetAspectRatio()
	elseif not Dvar.hiDef:get() or not Dvar.widescreen:get() then
		f27_local2 = 960
		f27_local1 = f27_local2 * 9 / 16
	end
	local webmImage = LUI.UIImage.new()
	webmImage:setLeftRight(false, false, -f27_local2 / 2, f27_local2 / 2)
	webmImage:setTopBottom(false, false, -f27_local1 / 2, f27_local1 / 2)
	webmImage:setRGB(0, 0, 0)
	webmImage:setAlpha(1)
	webmImage:setPriority(-4)
	f27_local0:addElement(webmImage)
	f27_local0.webmImage = webmImage
	
	local webmVideo = LUI.UIImage.new()
	webmVideo:setLeftRight(false, false, -f27_local2 / 2, f27_local2 / 2)
	webmVideo:setTopBottom(false, false, -f27_local1 / 2, f27_local1 / 2)
	webmVideo:setAlpha(0)
	webmVideo:setImage(RegisterMaterial(CoD.Codtv.WebMPlaybackMaterial))
	webmVideo:setPriority(-5)
	f27_local0:addElement(webmVideo)
	f27_local0.webmVideo = webmVideo
	
	f27_local0.goBack = CoD.FileAction.VideoPlayer.GoBack
	Engine.PlayMenuMusic("")
	Engine.SetDvar("lui_disable_blur", 1)
	Engine.SetDvar("ui_drawBuildNumber", 0)
	f27_local0.animateOutAndGoBack = function (f31_arg0, f31_arg1)
		f31_arg0:goBack(f31_arg0:getOwner())
	end

	f27_local0.animateIn = CoD.NullFunction
	f27_local0:addBackButton()
	f27_local0.leftButtonPromptBar:setPriority(100)
	f27_local0.detailsFadeOutTime = LUI.UITimer.new(5000, {
		name = "back_button_fadeout",
		controller = f27_arg0
	}, false)
	f27_local0:addElement(f27_local0.detailsFadeOutTime)
	f27_local0:registerEventHandler("back_button_fadeout", CoD.FileAction.VideoPlayer.BackButtonFadeout)
	f27_local0:registerEventHandler("video_playback_ended", CoD.FileAction.VideoPlayer.PlaybackEnded)
	f27_local0:registerEventHandler("close_all_popups", CoD.FileAction.VideoPlayer.CloseAllPopups)
	f27_local0:registerEventHandler("video_play_end", CoD.FileAction.VideoPlayer.CloseTimerHandler)
	return f27_local0
end

CoD.FileAction.CinematicPlayer = {}
CoD.FileAction.CinematicId = 0
CoD.FileAction.CinematicPlayer.GoBack = function (f28_arg0, f28_arg1)
	Engine.SetDvar("ui_drawBuildNumber", 1)
	if CoD.FileAction.CinematicId ~= 0 then
		if Engine.IsCinematicPreloading(CoD.FileAction.CinematicId) == false then
			Engine.Stop3DCinematic(CoD.FileAction.CinematicId)
		end
		CoD.FileAction.CinematicId = 0
		Engine.PlayMenuMusic("mus_mp_frontend")
	end
	f28_arg0:goBack(f28_arg1)
end

CoD.FileAction.CinematicPlayer.Cinematic_Update = function (f29_arg0, f29_arg1)
	if CoD.FileAction.CinematicId == 0 then
		return 
	elseif Engine.IsCinematicPreloading(CoD.FileAction.CinematicId) then
		return 
	elseif f29_arg0.image.isShowing == false then
		f29_arg0.image.isShowing = true
		f29_arg0.image:setAlpha(1)
	end
	if Engine.GetCinematicTimeRemaining(CoD.FileAction.CinematicId) > 0 then
		return 
	end
	CoD.FileAction.CinematicPlayer.GoBack(f29_arg0, f29_arg1)
end

LUI.createMenu.Cinematic_Player = function (f30_arg0)
	local f30_local0 = CoD.Menu.New("Cinematic_Player")
	f30_local0:setLeftRight(true, true, 0, 0)
	f30_local0:setTopBottom(true, true, 0, 0)
	f30_local0.image = LUI.UIImage.new()
	f30_local0.image:setLeftRight(true, true, 0, 0)
	if CoD.isPC then
		local f30_local1 = (1280 / Engine.GetAspectRatio() - 720) / 2
		f30_local0.image:setTopBottom(true, true, f30_local1, -f30_local1)
	elseif Dvar.wideScreen:get() == true then
		f30_local0.image:setTopBottom(true, true, 0, 0)
	else
		f30_local0.image:setTopBottom(true, true, 90, -90)
	end
	f30_local0.image:setImage(RegisterMaterial("webm_720p"))
	f30_local0.image:setShaderVector(0, 0, 0, 0, 0)
	f30_local0.image.isShowing = false
	if CoD.isPC then
		Engine.WebM_Clear("webm_720p", 0, 0, 0, 1)
	else
		f30_local0.image:setAlpha(0)
	end
	f30_local0:addElement(f30_local0.image)
	local f30_local2, f30_local1 = Engine.GetUserSafeArea()
	f30_local0.safearea = LUI.UIElement.new()
	f30_local0.safearea:setLeftRight(false, false, -f30_local2 / 2, f30_local2 / 2)
	f30_local0.safearea:setTopBottom(false, false, -f30_local1 / 2, f30_local1 / 2)
	f30_local0:addElement(f30_local0.safearea)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setupCinematicSubtitles()
	f30_local0.safearea:addElement(Widget)
	Engine.PlayMenuMusic("")
	Engine.SetDvar("ui_drawBuildNumber", 0)
	f30_local0:registerEventHandler("cinematic_update", CoD.FileAction.CinematicPlayer.Cinematic_Update)
	f30_local0:addElement(LUI.UITimer.new(16, "cinematic_update", false, f30_local0))
	return f30_local0
end

