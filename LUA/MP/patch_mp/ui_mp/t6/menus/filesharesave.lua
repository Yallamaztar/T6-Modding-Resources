require("LUI.LUIVerticalList")
require("T6.Menus.FileshareManager")
require("T6.Menus.FileshareSummary")
require("T6.Menus.FilesharePopup")
CoD.FileshareSave = {}
CoD.FileshareSave.Buttons = {}
CoD.FileshareSave.Upload = {}
CoD.FileshareSave.BtnGainFocus = function (f1_arg0, f1_arg1)
	LUI.UIElement.gainFocus(f1_arg0, f1_arg1)
	f1_arg0.border:setAlpha(1)
	f1_arg0.text:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
end

CoD.FileshareSave.BtnLoseFocus = function (f2_arg0, f2_arg1)
	LUI.UIElement.loseFocus(f2_arg0, f2_arg1)
	f2_arg0.border:setAlpha(0)
	f2_arg0.text:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
end

CoD.FileshareSave.MoveUp = function (f3_arg0, f3_arg1)
	local f3_local0 = 0
	for f3_local1 = 1, #CoD.FileshareSave.Buttons, 1 do
		if CoD.FileshareSave.Buttons[f3_local1]:isInFocus() then
			f3_local0 = f3_local1
		end
	end
	local f3_local1 = f3_local0 - 1
	if f3_local1 < 1 then
		f3_local1 = #CoD.FileshareSave.Buttons
	end
	CoD.FileshareSave.Buttons[f3_local0]:processEvent({
		name = "lose_focus"
	})
	CoD.FileshareSave.Buttons[f3_local1]:processEvent({
		name = "gain_focus"
	})
end

CoD.FileshareSave.MoveDown = function (f4_arg0, f4_arg1)
	local f4_local0 = 0
	for f4_local1 = 1, #CoD.FileshareSave.Buttons, 1 do
		if CoD.FileshareSave.Buttons[f4_local1]:isInFocus() then
			f4_local0 = f4_local1
		end
	end
	local f4_local1 = f4_local0 + 1
	if f4_local1 > #CoD.FileshareSave.Buttons then
		f4_local1 = 1
	end
	CoD.FileshareSave.Buttons[f4_local0]:processEvent({
		name = "lose_focus"
	})
	CoD.FileshareSave.Buttons[f4_local1]:processEvent({
		name = "gain_focus"
	})
end

CoD.FileshareSave.Click = function (f5_arg0, f5_arg1)
	for f5_local0 = 1, #CoD.FileshareSave.Buttons, 1 do
		local f5_local3 = CoD.FileshareSave.Buttons[f5_local0]
		if f5_local3:isInFocus() and f5_local3.m_callback ~= nil and not f5_local3.m_disabled then
			f5_local3:m_callback(f5_arg0, f5_arg1)
		end
	end
end

CoD.FileshareSave.ButtonPress = function (f6_arg0, f6_arg1)
	if f6_arg0.m_inputDisabled then
		return nil
	elseif CoD.FileshareSave.Buttons and #CoD.FileshareSave.Buttons == 0 then
		return nil
	elseif f6_arg1.down == true then
		if f6_arg1.button == "up" then
			CoD.FileshareSave.MoveUp(f6_arg0, f6_arg1)
			return true
		elseif f6_arg1.button == "down" then
			CoD.FileshareSave.MoveDown(f6_arg0, f6_arg1)
			return true
		elseif f6_arg1.button == "primary" then
			CoD.FileshareSave.Click(f6_arg0, f6_arg1)
			return true
		end
	end
	f6_arg0:dispatchEventToChildren(f6_arg1)
	return nil
end

CoD.FileshareSave.UpdateButtonText = function (f7_arg0, f7_arg1)
	if f7_arg0:isInFocus() then
		f7_arg0:setText(f7_arg1.text)
	end
end

CoD.FileshareSave.BtnTitleClick = function (f8_arg0, f8_arg1)
	Engine.ExecNow(f8_arg1.m_controller, "demo_keyboard " .. f8_arg1.m_category .. "Name")
end

CoD.FileshareSave.BtnDescriptionClick = function (f9_arg0, f9_arg1, f9_arg2)
	Engine.ExecNow(f9_arg1.m_controller, "demo_keyboard " .. f9_arg1.m_category .. "Desc")
end

CoD.FileshareSave.BtnSaveClick = function (f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = nil
	if f10_arg1.m_saveSlot ~= nil then
		if f10_arg1.m_isCopy == false then
			if UIExpression.IsDemoPlaying(f10_arg2.controller) == 1 then
				local f10_local1 = Engine.GetDemoStreamedDownloadProgress()
				if f10_local1 < 100 then
					CoD.Menu.OpenDemoErrorPopup(f10_arg1, {
						controller = f10_arg2.controller,
						titleText = Engine.Localize("MENU_NOTICE"),
						messageText = Engine.Localize("MPUI_DEMO_DOWNLOAD_IN_PROGRESS", math.floor(f10_local1))
					})
					return 
				end
			end
			if f10_arg1.m_category == "clip" then
				f10_local0 = "demo_saveanduploadclip " .. f10_arg1.m_saveSlot
			elseif f10_arg1.m_category == "screenshot" then
				f10_local0 = "demo_savescreenshot 0 " .. f10_arg1.m_saveSlot
			elseif f10_arg1.m_category == "customgame" then
				f10_local0 = "gamesettings_upload " .. f10_arg1.m_saveSlot
			elseif f10_arg1.m_category == "render" then
				Engine.Exec(f10_arg2.controller, "demo_play film.demo RenderMovie " .. f10_arg1.m_matchID .. " " .. f10_arg1.m_saveSlot)
				return 
			end
		else
			local f10_local1 = 0
			if f10_arg1.m_isPooled == true then
				f10_local1 = 1
			end
			f10_local0 = "fileshareCopy " .. f10_arg1.m_fileID .. " " .. f10_local1 .. " " .. f10_arg1.m_saveSlot
		end
	end
	if f10_local0 ~= nil then
		local f10_local1 = Engine.Localize(UIExpression.TableLookup(nil, "mp/filesharecategories.csv", 0, f10_arg1.m_category, 3) .. "_SMALL")
		f10_arg1:openPopup("Fileshare_BusyPopup", f10_arg1.m_ownerController, {
			title = UIExpression.ToUpper(nil, Engine.Localize("MENU_FILESHARE_SAVE")),
			message = Engine.Localize("MENU_FILESHARE_SAVE_WAIT", f10_local1),
			successNotice = Engine.Localize("MENU_FILESHARE_SAVE_SUCCESS", f10_local1),
			failureNotice = Engine.Localize("MENU_FILESHARE_SAVE_ERROR", f10_local1),
			actionCommand = f10_local0,
			completionEvent = "fileshare_upload_complete",
			completionNotification = "fileshare_operation_complete",
			inPlace = true
		})
	end
end

CoD.FileshareSave.BtnFileshareManagerClick = function (f11_arg0, f11_arg1, f11_arg2)
	CoD.FileshareSave.OpenFileManager(f11_arg1, f11_arg2)
end

CoD.FileshareSave.BtnLeftMouseUp = function (f12_arg0, f12_arg1)
	f12_arg0:dispatchEventToParent({
		name = "fileshare_mouse_click",
		controller = f12_arg1.controller
	})
end

CoD.FileshareSave.MouseClick = function (f13_arg0, f13_arg1)
	if not f13_arg0.m_inputDisabled then
		CoD.FileshareSave.Click(f13_arg0, f13_arg1)
	end
end

CoD.FileshareSave.ButtonSetText = function (f14_arg0, f14_arg1)
	f14_arg0.text:setText(f14_arg1)
end

CoD.FileshareSave.ButtonDisable = function (f15_arg0, f15_arg1)
	f15_arg0.text:setRGB(CoD.offGray.r, CoD.offGray.g, CoD.offGray.b)
	f15_arg0.m_disabled = true
end

CoD.FileshareSave.ButtonEnable = function (f16_arg0, f16_arg1)
	f16_arg0.text:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f16_arg0.m_disabled = false
end

CoD.FileshareSave.NewButton = function (f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4, f17_arg5, f17_arg6, f17_arg7)
	local Widget = LUI.UIElement.new()
	if f17_arg7 == nil then
		f17_arg7 = false
	end
	Widget.id = "FileshareSaveButton"
	Widget.m_callback = f17_arg4
	Widget.m_isTextField = f17_arg6
	Widget.m_disabled = false
	Widget:setLeftRight(true, false, f17_arg0, f17_arg0 + f17_arg2)
	Widget:setTopBottom(true, false, f17_arg1, f17_arg1 + f17_arg3)
	Widget:makeFocusable()
	local f17_local1 = LUI.UIImage.new()
	f17_local1:setLeftRight(true, true, 0, 0)
	f17_local1:setTopBottom(true, true, 0, 0)
	f17_local1:setRGB(0.2, 0.2, 0.2)
	f17_local1:setAlpha(0.6)
	Widget:addElement(f17_local1)
	if f17_arg5 == nil then
		f17_arg5 = ""
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 5, -5)
	Widget:setTopBottom(true, false, 0, CoD.textSize.Default * 2)
	Widget:setUseStencil(true)
	Widget:addElement(Widget)
	local text = LUI.UIText.new()
	text:setLeftRight(true, true, 0, 0)
	text:setTopBottom(true, false, 0, CoD.textSize.Default)
	text:setText(f17_arg5)
	if f17_arg7 == false then
		text:setRGB(CoD.offGray.r, CoD.offGray.g, CoD.offGray.b)
	else
		text:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	end
	if f17_arg6 == true then
		text:setAlignment(LUI.Alignment.Left)
	else
		text:setAlignment(LUI.Alignment.Center)
	end
	Widget:addElement(text)
	Widget.text = text
	
	local f17_local4 = CoD.Border.new(1, CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b, 0, -5)
	Widget.border = f17_local4
	Widget.border:setAlpha(0)
	Widget:addElement(f17_local4)
	if f17_arg6 == true then
		local f17_local5 = LUI.UIImage.new()
		f17_local5:setLeftRight(true, true, 0, 0)
		f17_local5:setTopBottom(false, true, -1, 0)
		f17_local5:setRGB(0, 0, 0)
		Widget:addElement(f17_local5)
		local f17_local6 = LUI.UIImage.new()
		f17_local6:setLeftRight(true, true, 0, 0)
		f17_local6:setTopBottom(false, true, -1, 0)
		f17_local6:setRGB(0, 0, 0)
		Widget:addElement(f17_local6)
		local f17_local7 = LUI.UIImage.new()
		f17_local7:setLeftRight(true, true, 0, 0)
		f17_local7:setTopBottom(false, true, -1, 0)
		f17_local7:setRGB(0.3, 0.3, 0.3)
		Widget:addElement(f17_local7)
		local f17_local8 = LUI.UIImage.new()
		f17_local8:setLeftRight(false, true, -1, 0)
		f17_local8:setTopBottom(true, true, 0, 0)
		f17_local8:setRGB(0.3, 0.3, 0.3)
		Widget:addElement(f17_local8)
	end
	Widget.setText = CoD.FileshareSave.ButtonSetText
	Widget.disable = CoD.FileshareSave.ButtonDisable
	Widget.enable = CoD.FileshareSave.ButtonEnable
	Widget:registerEventHandler("gain_focus", CoD.FileshareSave.BtnGainFocus)
	Widget:registerEventHandler("lose_focus", CoD.FileshareSave.BtnLoseFocus)
	Widget:registerEventHandler("demo_keyboard_complete", CoD.FileshareSave.UpdateButtonText)
	if CoD.useMouse and (f17_arg7 or not f17_arg6) then
		Widget:setHandleMouse(true)
		Widget:registerEventHandler("leftmouseup", CoD.FileshareSave.BtnLeftMouseUp)
		Widget:registerEventHandler("leftmousedown", CoD.NullFunction)
	end
	return Widget
end

CoD.FileshareSave.PopulateDetails = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, 400)
	Widget:setTopBottom(true, false, 80, 600)
	local f18_local1 = 350
	local f18_local2 = 200
	local f18_local3 = 0
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, f18_local1)
	Widget:setTopBottom(true, false, 0, f18_local2)
	Widget:addElement(Widget)
	local f18_local5 = LUI.UIImage.new()
	f18_local5:setLeftRight(false, false, -f18_local1 / 2, f18_local1 / 2)
	f18_local5:setTopBottom(false, false, -f18_local2 / 2, f18_local2 / 2)
	Widget:addElement(f18_local5)
	f18_local3 = f18_local3 + f18_local2 + 10
	if not Engine.IsInGame() then
		if HudRef.m_skipThumbnail == false and (HudRef.m_category == "clip" or HudRef.m_category == "screenshot") then
			f18_local5:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_THUMBNAIL, tostring(HudRef.m_fileID))
		elseif HudRef.m_category == "customgame" then
			f18_local5:setLeftRight(false, false, -100, 100)
			f18_local5:setImage(RegisterMaterial(UIExpression.TableLookup(controller, CoD.gametypesTable, 0, 0, 1, Dvar.ui_gameType:get(), 4)))
		elseif HudRef.m_map ~= nil then
			if CoD.isZombie then
				if HudRef.m_gameType == nil then
					HudRef.m_gameType = Dvar.ui_gameType:get()
				end
				if HudRef.m_startLocation == nil then
					HudRef.m_startLocation = Dvar.ui_zm_mapstartlocation:get()
				end
				local f18_local6 = UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, HudRef.m_gameType, 9)
				if HudRef.m_map ~= nil and f18_local6 ~= nil and HudRef.m_startLocation ~= nil then
					f18_local5:setImage(RegisterMaterial("menu_" .. CoD.Zombie.GetMapName(HudRef.m_map) .. "_" .. f18_local6 .. "_" .. HudRef.m_startLocation))
				end
			elseif HudRef.m_map ~= nil then
				f18_local5:setImage(RegisterMaterial("menu_" .. HudRef.m_map .. "_map_select_final"))
			end
		else
			f18_local5:setAlpha(0)
		end
	elseif UIExpression.IsDemoPlaying(HudRef.m_ownerController) ~= 0 and HudRef.m_category ~= nil then
		Engine.ExecNow(HudRef.m_ownerController, "setupThumbnailForFileshareSave " .. HudRef.m_category)
		f18_local5:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_THUMBNAIL, 1)
	else
		f18_local5:setAlpha(0)
	end
	local f18_local6 = LUI.UIText.new()
	f18_local6:setLeftRight(true, true, 0, 0)
	f18_local6:setTopBottom(true, false, f18_local3, f18_local3 + CoD.textSize.Default)
	f18_local6:setText(Engine.Localize("MPUI_TITLE"))
	f18_local6:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f18_local6:setAlignment(LUI.Alignment.Left)
	f18_local6:setFont(CoD.fonts.Default)
	Widget:addElement(f18_local6)
	f18_local3 = f18_local3 + CoD.textSize.Default + 8
	HudRef.btnTitle = CoD.FileshareSave.NewButton(0, f18_local3, f18_local1, CoD.textSize.Default + 5, CoD.FileshareSave.BtnTitleClick, HudRef.m_defaultName, true, HudRef.m_canEdit)
	Widget:addElement(HudRef.btnTitle)
	f18_local3 = f18_local3 + CoD.textSize.Default + 12
	local f18_local7 = LUI.UIText.new()
	f18_local7:setLeftRight(true, true, 0, 0)
	f18_local7:setTopBottom(true, false, f18_local3, f18_local3 + CoD.textSize.Default)
	f18_local7:setText(Engine.Localize("MENU_FILESHARE_DESCRIPTION"))
	f18_local7:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f18_local7:setAlignment(LUI.Alignment.Left)
	f18_local7:setFont(CoD.fonts.Default)
	Widget:addElement(f18_local7)
	f18_local3 = f18_local3 + CoD.textSize.Default + 8
	HudRef.btnDescription = CoD.FileshareSave.NewButton(0, f18_local3, f18_local1, (CoD.textSize.Default + 5) * 2, CoD.FileshareSave.BtnDescriptionClick, HudRef.m_defaultDescription, true, HudRef.m_canEdit)
	Widget:addElement(HudRef.btnDescription)
	f18_local3 = f18_local3 + CoD.textSize.Default * 2 + 25
	if InstanceRef <= 0 then
		HudRef.saveButton = CoD.FileshareSave.NewButton(0, f18_local3, f18_local1, CoD.textSize.Default + 5, CoD.FileshareSave.BtnFileshareManagerClick, Engine.Localize("MENU_FILEMANAGER"), false, false)
	else
		HudRef.saveButton = CoD.FileshareSave.NewButton(0, f18_local3, f18_local1, CoD.textSize.Default + 5, CoD.FileshareSave.BtnSaveClick, UIExpression.ToUpper(nil, Engine.Localize("MENU_FILESHARE_SAVE")), false, false)
	end
	Widget:addElement(HudRef.saveButton)
	f18_local3 = f18_local3 + CoD.textSize.Default + 25
	local f18_local8 = LUI.UIImage.new()
	f18_local8:setLeftRight(true, false, 0, 32)
	f18_local8:setTopBottom(true, false, f18_local3, f18_local3 + 32)
	f18_local8:setImage(RegisterMaterial("cac_restricted"))
	HudRef.restrictedIcon = f18_local8
	Widget:addElement(f18_local8)
	local f18_local9 = LUI.UIText.new()
	f18_local9:setLeftRight(true, true, 40, 400)
	f18_local9:setTopBottom(true, false, f18_local3, f18_local3 + CoD.textSize.Default)
	if CoD.FileshareManager.ShouldShowMtx(HudRef.m_ownerController) then
		f18_local9:setText(Engine.Localize("MENU_FILESHARE_SLOTSFULL_MTX"))
	else
		f18_local9:setText(Engine.Localize("MENU_FILESHARE_SLOTSFULL"))
	end
	f18_local9:setRGB(CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b)
	f18_local9:setAlignment(LUI.Alignment.Left)
	f18_local9:setFont(CoD.fonts.Default)
	HudRef.txtFullWarning = f18_local9
	Widget:addElement(f18_local9)
	if InstanceRef <= 0 then
		HudRef.restrictedIcon:setAlpha(1)
		HudRef.txtFullWarning:setAlpha(1)
	else
		HudRef.restrictedIcon:setAlpha(0)
		HudRef.txtFullWarning:setAlpha(0)
	end
	for f18_local10 = 1, #CoD.FileshareSave.Buttons, 1 do
		local f18_local13 = f18_local10
		table.remove(CoD.FileshareSave.Buttons)
	end
	if HudRef.m_canEdit == true then
		table.insert(CoD.FileshareSave.Buttons, HudRef.btnTitle)
		table.insert(CoD.FileshareSave.Buttons, HudRef.btnDescription)
	end
	table.insert(CoD.FileshareSave.Buttons, HudRef.saveButton)
	HudRef.saveButton:processEvent({
		name = "gain_focus"
	})
	return Widget
end

CoD.FileshareSave.SlotsAvailable = function (f19_arg0, f19_arg1)
	f19_arg0.spinner:setAlpha(0)
	if f19_arg1.valid == false then
		f19_arg0.occludedMenu:openPopup("FileshareManager_Error", f19_arg1.controller)
		f19_arg0:close()
		return 
	end
	local f19_local0 = Engine.GetFileshareCategories(f19_arg1.controller)
	if f19_arg0.groupSummary == nil then
		f19_arg0.groupSummary = CoD.FileshareSummary.new(80, 400, 341, f19_local0, f19_arg0.m_groupName, true)
		f19_arg0:addElement(f19_arg0.groupSummary)
	end
	f19_arg0.m_slotsRemaining = 0
	for f19_local1 = 1, #f19_local0, 1 do
		if f19_arg0.m_groupName == f19_local0[f19_local1].name then
			f19_arg0.m_slotsRemaining = f19_local0[f19_local1].remaining
			break
		end
	end
	if f19_arg0.details == nil then
		f19_arg0.details = CoD.FileshareSave.PopulateDetails(f19_arg0, f19_arg0.m_slotsRemaining)
		f19_arg0:addElement(f19_arg0.details)
	end
	f19_arg0.m_saveSlot = Engine.GetFileshareNextSlot(f19_arg0.m_ownerController, f19_arg0.m_categoryID)
end

CoD.FileshareSave.UpdateSaveButtonState = function (f20_arg0, f20_arg1)
	if f20_arg0.m_slotsRemaining == nil or f20_arg0.m_slotsRemaining <= 0 then
		return 
	elseif f20_arg0.saveButton == nil then
		return 
	elseif Engine.PartyGetPlayerCount() <= 1 then
		if f20_arg0.saveButton.m_disabled then
			f20_arg0.saveButton:enable()
			f20_arg0.restrictedIcon:setAlpha(0)
			f20_arg0.txtFullWarning:setAlpha(0)
		end
	elseif not f20_arg0.saveButton.m_disabled then
		f20_arg0.saveButton:disable()
		f20_arg0.restrictedIcon:setAlpha(1)
		f20_arg0.txtFullWarning:setText(Engine.Localize("MENU_RENDER_TOO_MANY_PLAYERS"))
		f20_arg0.txtFullWarning:setAlpha(1)
	end
end

CoD.FileshareSave.OpenFileManager = function (f21_arg0, f21_arg1)
	local f21_local0 = f21_arg0:openMenu("FileshareManager", f21_arg1.controller, {
		category = f21_arg0.m_category,
		groupName = f21_arg0.m_groupName
	})
	f21_local0:setPreviousMenu("FileshareSave")
	f21_arg0:close()
end

CoD.FileshareSave.Back = function (f22_arg0, f22_arg1)
	f22_arg0:goBack(f22_arg1.controller)
	if Engine.IsInGame() then
		Engine.Exec(f22_arg1.controller, "resetThumbnailViewer")
	end
end

LUI.createMenu.FileshareSave = function (f23_arg0)
	local f23_local0 = CoD.Menu.New("FileshareSave")
	f23_local0.m_category = CoD.perController[f23_arg0].fileshareSaveCategory
	f23_local0.m_isCopy = CoD.perController[f23_arg0].fileshareSaveIsCopy
	f23_local0.m_fileID = CoD.perController[f23_arg0].fileshareSaveFileID
	f23_local0.m_isPooled = CoD.perController[f23_arg0].fileshareSaveIsPooled
	f23_local0.m_map = CoD.perController[f23_arg0].fileshareSaveMap
	f23_local0.m_startLocation = CoD.perController[f23_arg0].fileshareZmMapStartLocation
	f23_local0.m_startLocationName = CoD.perController[f23_arg0].fileshareZmMapStartLocationName
	f23_local0.m_gameType = CoD.perController[f23_arg0].fileshareGameType
	f23_local0.m_matchID = CoD.perController[f23_arg0].fileshareSaveMatchID
	f23_local0.m_skipThumbnail = CoD.perController[f23_arg0].fileshareSaveSkipThumbnail
	if f23_local0.m_skipThumbnail == nil then
		f23_local0.m_skipThumbnail = false
	end
	if f23_local0.m_category ~= "render" and (f23_local0.m_isPooled == true or f23_local0.m_isCopy == false) then
		f23_local0.m_canEdit = true
	else
		f23_local0.m_canEdit = false
	end
	if f23_local0.m_isCopy == true or f23_local0.m_category == "customgame" then
		f23_local0.m_defaultName = CoD.perController[f23_arg0].fileshareSaveName
		f23_local0.m_defaultDescription = CoD.perController[f23_arg0].fileshareSaveDescription
		Engine.ExecNow(f23_arg0, "fileshareClearCopyParams")
	elseif f23_local0.m_category == "render" then
		f23_local0.m_defaultName = CoD.perController[f23_arg0].fileshareSaveName
		f23_local0.m_defaultDescription = CoD.perController[f23_arg0].fileshareSaveDescription
	else
		f23_local0.m_defaultName = UIExpression.GetDemoSaveScreenName(f23_local0.m_ownerController, f23_local0.m_category)
		f23_local0.m_defaultDescription = UIExpression.GetDemoSaveScreenDescription(f23_local0.m_ownerController, f23_local0.m_category)
	end
	f23_local0.m_categoryID = UIExpression.TableLookup(nil, "mp/filesharecategories.csv", 0, f23_local0.m_category, 2)
	f23_local0.m_groupName = UIExpression.TableLookup(nil, "mp/filesharecategories.csv", 0, f23_local0.m_category, 1)
	local f23_local1 = UIExpression.TableLookup(nil, "mp/filesharecategories.csv", 0, f23_local0.m_category, 3)
	if not Engine.IsInGame() then
		f23_local0:addLargePopupBackground()
	end
	f23_local0:setOwner(f23_arg0)
	f23_local0:addTitle(UIExpression.ToUpper(nil, Engine.Localize("MENU_FILESHARE_SAVE")) .. " " .. UIExpression.ToUpper(nil, Engine.Localize(f23_local1)), LUI.Alignment.Left)
	local f23_local2 = LUI.UIImage.new({
		shaderVector0 = {
			0,
			0,
			0,
			0
		}
	})
	f23_local2:setImage(RegisterMaterial("lui_loader"))
	f23_local2:setTopBottom(false, false, -32, 32)
	f23_local2:setLeftRight(false, false, -32, 32)
	f23_local0.spinner = f23_local2
	f23_local0:addElement(f23_local2)
	local f23_local3 = CoD.ButtonPrompt.new
	local f23_local4 = "select"
	local f23_local5 = Engine.Localize("MENU_FILEMANAGER")
	local f23_local6 = f23_local0
	local f23_local7 = "fileshare_open_manager"
	local f23_local8, f23_local9 = false
	local f23_local10, f23_local11 = false
	f23_local3 = f23_local3(f23_local4, f23_local5, f23_local6, f23_local7, f23_local8, f23_local9, f23_local10, f23_local11, "TAB")
	f23_local0:addSelectButton()
	f23_local0:addBackButton()
	f23_local0:addLeftButtonPrompt(f23_local3)
	f23_local0:registerEventHandler("fileshare_open_manager", CoD.FileshareSave.OpenFileManager)
	f23_local0:registerEventHandler("fileshare_slots_available", CoD.FileshareSave.SlotsAvailable)
	f23_local0:registerEventHandler("gamepad_button", CoD.FileshareSave.ButtonPress)
	f23_local0:registerEventHandler("button_prompt_back", CoD.FileshareSave.Back)
	f23_local0:registerEventHandler("fileshare_operation_complete", CoD.FileshareSave.Back)
	if CoD.useMouse then
		f23_local0:registerEventHandler("fileshare_mouse_click", CoD.FileshareSave.MouseClick)
	end
	if f23_local0.m_category == "render" then
		f23_local0:registerEventHandler("theaterlobby_update", CoD.FileshareSave.UpdateSaveButtonState)
		f23_local0:registerEventHandler("gamelobby_update", CoD.FileshareSave.UpdateSaveButtonState)
	end
	Engine.Exec(f23_arg0, "fileshareGetSlots")
	return f23_local0
end

