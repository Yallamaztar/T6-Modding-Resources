require("LUI.LUIVerticalList")
require("T6.ListBox")
require("T6.Menus.FileshareSummary")
require("T6.HUD.DemoPopup")
CoD.FileshareManager = {}
CoD.FileshareManager.Row = {}
CoD.FileshareManager.List = {}
CoD.FileshareManager.FileDetails = {}
CoD.FileshareManager.Delete = {}
CoD.FileshareManager.SkipMtx = false
LUI.createMenu.FileshareManager_Error = function (f1_arg0)
	local f1_local0 = CoD.Popup.SetupPopup("FileshareManager_Error", f1_arg0)
	f1_local0.title:setText(Engine.Localize("MENU_ERROR"))
	f1_local0.msg:setText(Engine.Localize("MENU_FILESHARE_ERROR"))
	f1_local0:addBackButton()
	return f1_local0
end

CoD.FileshareManager.Delete.Action = function (f2_arg0, f2_arg1)
	f2_arg0:openMenu("Fileshare_BusyPopup", f2_arg1.controller, {
		title = UIExpression.ToUpper(nil, Engine.Localize("MENU_DELETE")),
		message = Engine.Localize("MENU_FILESHARE_DELETE_WAIT", f2_arg0.m_categoryName),
		successNotice = Engine.Localize("MENU_FILESHARE_DELETE_SUCCESS", f2_arg0.m_categoryName),
		failureNotice = Engine.Localize("MENU_FILESHARE_DELETE_ERROR", f2_arg0.m_categoryName),
		actionCommand = f2_arg0.m_deleteAction,
		completionEvent = "fileshare_delete_slot_done",
		completionNotification = "fileshare_slots_refresh"
	})
	f2_arg0:close()
end

LUI.createMenu.FileshareManager_ConfirmDelete = function (f3_arg0, f3_arg1)
	local f3_local0 = CoD.Popup.SetupPopupChoice("FileshareManager_ConfirmDelete", f3_arg0)
	local f3_local1 = Engine.Localize(UIExpression.TableLookup(nil, "mp/filesharecategories.csv", 2, f3_arg1.category, 3) .. "_SMALL")
	f3_local0.title:setText(Engine.Localize("MENU_WARNING"))
	f3_local0.msg:setText(Engine.Localize("MENU_FILESHARE_DELETECONFIRMATION", f3_local1))
	f3_local0:addBackButton()
	f3_local0.m_deleteAction = f3_arg1.deleteAction
	f3_local0.m_categoryName = f3_local1
	f3_local0.choiceA:setLabel(Engine.Localize("MENU_YES"))
	f3_local0.choiceB:setLabel(Engine.Localize("MENU_NO"))
	f3_local0.choiceA:setActionEventName("fileshare_deleteconfirmation_yes")
	f3_local0.choiceB:processEvent({
		name = "gain_focus"
	})
	f3_local0:registerEventHandler("fileshare_deleteconfirmation_yes", CoD.FileshareManager.Delete.Action)
	return f3_local0
end

CoD.FileshareManager.StatPanelUpdate = function (f4_arg0, f4_arg1, f4_arg2)
	if f4_arg1 ~= nil then
		f4_arg0.value:setText(f4_arg1)
	else
		f4_arg0.value:setText("")
	end
	if f4_arg2 ~= nil then
		f4_arg0.iconBackground:setRGB(f4_arg2.r, f4_arg2.g, f4_arg2.b)
		f4_arg0.icon:setRGB(f4_arg2.r, f4_arg2.g, f4_arg2.b)
	end
end

CoD.FileshareManager.StatPanel = function (f5_arg0, f5_arg1, f5_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f5_arg0, f5_arg0 + 140)
	Widget:setTopBottom(true, false, f5_arg1, f5_arg1 + 50)
	Widget:addElement(CoD.Border.new(1, 0.2, 0.2, 0.2, 0.5))
	
	local iconBackground = LUI.UIImage.new()
	iconBackground:setLeftRight(true, false, 5, 37)
	iconBackground:setTopBottom(false, false, -16, 16)
	iconBackground:setImage(RegisterMaterial("menu_mp_lobby_views_bg"))
	Widget:addElement(iconBackground)
	Widget.iconBackground = iconBackground
	
	local icon = LUI.UIImage.new()
	icon:setLeftRight(true, false, 5, 37)
	icon:setTopBottom(false, false, -16, 16)
	Widget:addElement(icon)
	Widget.icon = icon
	
	local f5_local3 = 3
	local f5_local4 = LUI.UIText.new()
	f5_local4:setLeftRight(true, true, 50, 0)
	f5_local4:setTopBottom(true, false, f5_local3, f5_local3 + CoD.textSize.ExtraSmall)
	f5_local4:setFont(CoD.fonts.ExtraSmall)
	f5_local4:setAlignment(LUI.Alignment.Left)
	f5_local4:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(f5_local4)
	Widget.value = LUI.UIText.new()
	Widget.value:setLeftRight(true, true, 50, 0)
	Widget.value:setTopBottom(true, false, f5_local3 + CoD.textSize.ExtraSmall, f5_local3 + CoD.textSize.ExtraSmall + CoD.textSize.ExtraSmall)
	Widget.value:setFont(CoD.fonts.ExtraSmall)
	Widget.value:setAlignment(LUI.Alignment.Left)
	Widget.value:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget:addElement(Widget.value)
	if f5_arg2 == "views" then
		f5_local4:setText(Engine.Localize("MENU_FILESHARE_VIEWS"))
		icon:setImage(RegisterMaterial("menu_mp_lobby_views"))
		icon:setRGB(1, 1, 1)
	elseif f5_arg2 == "likes" then
		f5_local4:setText(Engine.Localize("MENU_FILESHARE_LIKES"))
		icon:setImage(RegisterMaterial("menu_mp_lobby_like"))
		icon:setRGB(CoD.green.r, CoD.green.g, CoD.green.b)
	elseif f5_arg2 == "dislikes" then
		f5_local4:setText(Engine.Localize("MENU_FILESHARE_DISLIKES"))
		icon:setImage(RegisterMaterial("menu_mp_lobby_like"))
		icon:setTopBottom(false, false, -14, 18)
		icon:setZRot(180)
		icon:setRGB(CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b)
	else
		error("Invalid panel type")
	end
	Widget.value:setText("0")
	Widget.update = CoD.FileshareManager.StatPanelUpdate
	return Widget
end

CoD.FileshareManager.GetName = function (f6_arg0)
	local f6_local0 = Engine.Localize(UIExpression.TableLookup(nil, "mp/filesharecategories.csv", 2, f6_arg0.category, 3))
	if f6_local0 == nil then
		f6_local0 = ""
	end
	if not f6_arg0.isSupported then
		if CoD.isZombie == true then
			return Engine.Localize("MENU_MULTIPLAYER_CAPS") .. " " .. f6_local0
		else
			return Engine.Localize("MENU_ZOMBIE_CAPS") .. " " .. f6_local0
		end
	elseif f6_arg0.category == 6 then
		return Engine.Localize("MENU_EMBLEM_DEFAULT_TITLE")
	elseif f6_arg0.name ~= nil then
		return f6_arg0.name
	elseif f6_arg0.gameTypeName ~= nil then
		return f6_arg0.gameTypeName
	else
		return ""
	end
end

CoD.FileshareManager.SetThumbnailImage = function (f7_arg0, f7_arg1)
	local f7_local0 = 180
	local f7_local1 = 100
	local f7_local2 = nil
	if not f7_arg1.isSupported then
		if CoD.isZombie == true then
			f7_local2 = RegisterMaterial("menu_mp_fileshare")
		else
			f7_local2 = RegisterMaterial("menu_zm_fileshare")
		end
	elseif f7_arg1.map ~= nil then
		if CoD.isZombie then
			f7_local2 = RegisterMaterial("menu_" .. CoD.Zombie.GetMapName(f7_arg1.map) .. "_" .. UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, f7_arg1.gameType, 9) .. "_" .. f7_arg1.zmMapStartLoc)
		else
			f7_local2 = RegisterMaterial("menu_" .. f7_arg1.map .. "_map_select_final")
		end
	elseif f7_arg1.gameType ~= nil then
		f7_local0 = 100
		f7_local2 = RegisterMaterial(UIExpression.TableLookup(controller, CoD.gametypesTable, 0, 0, 1, f7_arg1.gameType, 4))
	elseif f7_arg1.category ~= nil and f7_arg1.category == 6 then
		f7_local0 = 100
		f7_local2 = RegisterMaterial("menu_mp_lobby_icon_emblem")
	end
	if f7_local2 == nil then
		f7_arg0:setAlpha(0)
	else
		f7_arg0:setImage(f7_local2)
		f7_arg0:setLeftRight(false, false, -f7_local0 / 2, f7_local0 / 2)
		f7_arg0:setTopBottom(false, false, -f7_local1 / 2, f7_local1 / 2)
		f7_arg0:setAlpha(1)
	end
end

CoD.FileshareManager.GetDescription = function (f8_arg0)
	if f8_arg0.isSupported == false then
		return ""
	elseif f8_arg0.description == nil then
		if f8_arg0.gameTypeName == nil or f8_arg0.mapName == nil then
			return ""
		else
			return Engine.Localize("MENU_FILESHARE_GAMEONMAP", f8_arg0.gameTypeName, Engine.Localize(f8_arg0.mapName))
		end
	else
		return f8_arg0.description
	end
end

CoD.FileshareManager.GetPlaylistString = function (f9_arg0)
	if f9_arg0.isSupported == false then
		return ""
	elseif false == CoD.isZombie and f9_arg0.playlistType ~= nil then
		local f9_local0 = nil
		if f9_arg0.playlistType == 0 then
			f9_local0 = Engine.Localize("MPUI_PUBLIC_MATCH_LOBBY")
		elseif f9_arg0.playlistType == 1 then
			f9_local0 = Engine.Localize("MENU_FILESHARE_CUSTOMGAMES")
		elseif f9_arg0.playlistType == 2 then
			f9_local0 = Engine.Localize("MENU_LEAGUE_PLAY")
		end
		if f9_local0 ~= nil and f9_local0 ~= "" then
			return Engine.Localize("MENU_FILESHARE_MODE", f9_local0)
		end
	end
	return ""
end

CoD.FileshareManager.GetGametypeString = function (f10_arg0)
	if f10_arg0.isSupported == false then
		return ""
	elseif false == CoD.isZombie and f10_arg0.gameType ~= nil then
		return Engine.Localize("MENU_GAME_TYPE") .. Engine.Localize(UIExpression.TableLookup(controller, CoD.gametypesTable, 0, 0, 1, f10_arg0.gameType, 7))
	else
		return ""
	end
end

CoD.FileshareManager.FileDetails.Refresh = function (f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	if f11_arg3 == true then
		f11_arg0.name:setText(Engine.Localize("MENU_MEDIA_STORAGE_PACK"))
		if CoD.FileshareManager.DisableMTXForPS3() then
			f11_arg0.description:setText(Engine.Localize("MENU_MTX_MEDIA_STORAGE_WARNING"))
			f11_arg0.description:setRGB(CoD.red.r, CoD.red.g, CoD.red.b)
		else
			f11_arg0.description:setText(Engine.Localize("MENU_MTX_MEDIA_STORAGE_DESC"))
			f11_arg0.description:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		end
		if f11_arg0.thumbnail ~= nil then
			f11_arg0.thumbnail:show()
			f11_arg0.thumbnail:setImage(RegisterMaterial("menu_purchase_unlock_token_128"))
			f11_arg0.thumbnail:setLeftRight(false, false, -50, 50)
			f11_arg0.thumbnail:setTopBottom(false, false, -50, 50)
		end
		if f11_arg0.playlistInfo ~= nil then
			f11_arg0.playlistInfo:hide()
		end
		if f11_arg0.durationBacking ~= nil then
			f11_arg0.durationBacking:hide()
		end
		if f11_arg0.durationText ~= nil then
			f11_arg0.durationText:hide()
		end
		if f11_arg0.profileShotInfo ~= nil then
			f11_arg0.profileShotInfo:hide()
		end
		if f11_arg0.author ~= nil then
			f11_arg0.author:hide()
		end
		if f11_arg0.date ~= nil then
			f11_arg0.date:hide()
		end
		f11_arg0.body:setAlpha(1)
		return 
	elseif f11_arg1 == nil or f11_arg1.valid == false then
		f11_arg0.body:setAlpha(0)
		return 
	end
	f11_arg0.body:setAlpha(1)
	f11_arg0.name:setText(CoD.FileshareManager.GetName(f11_arg1))
	f11_arg0.description:setText(CoD.FileshareManager.GetDescription(f11_arg1))
	f11_arg0.description:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	local f11_local0 = UIExpression.TableLookup(nil, "mp/filesharecategories.csv", 2, f11_arg1.category, 0)
	if CoD.isZombie == false then
		if f11_local0 == "film" or f11_local0 == "customgame" then
			f11_arg0.playlistInfo:setText(CoD.FileshareManager.GetGametypeString(f11_arg1))
			f11_arg0.playlistInfo:setAlpha(1)
		elseif f11_arg0.playlistInfo ~= nil then
			f11_arg0.playlistInfo:setAlpha(0)
		end
	end
	if not Engine.IsInGame() then
		if f11_local0 == "film" or f11_local0 == "clip" then
			f11_arg0.durationBacking:setAlpha(1)
			f11_arg0.durationText:setAlpha(1)
			f11_arg0.durationText:setText(f11_arg1.duration)
		else
			f11_arg0.durationBacking:setAlpha(0)
			f11_arg0.durationText:setAlpha(0)
		end
	end
	local f11_local1 = Engine.GetCombatRecordScreenshotInfo(f11_arg2, UIExpression.GetXUID(f11_arg2))
	f11_arg0.profileShotInfo:hide()
	if f11_local1 == f11_arg1.fileID then
		f11_arg0.profileShotInfo:show()
	end
	f11_arg0.author:show()
	if f11_arg1.category == 1 then
		f11_arg0.author:setText(Engine.Localize("MENU_FILESHARE_SAVED_BY") .. " " .. f11_arg1.author)
	else
		f11_arg0.author:setText(Engine.Localize("MENU_FILESHARE_AUTHOR") .. " " .. f11_arg1.author)
	end
	f11_arg0.date:show()
	f11_arg0.date:setText(f11_arg1.time)
	if not Engine.IsInGame() then
		CoD.FileshareManager.SetThumbnailImage(f11_arg0.thumbnail, f11_arg1)
	end
end

CoD.FileshareManager.GetProfileShot = function (f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = LUI.UIHorizontalList.new()
	f12_local0:setLeftRight(true, true, 0, 0)
	f12_local0:setTopBottom(true, false, f12_arg0, f12_arg0 + f12_arg2)
	f12_local0.starImage = LUI.UIImage.new()
	f12_local0.starImage:setLeftRight(true, false, 0, f12_arg2)
	f12_local0.starImage:setTopBottom(false, false, -f12_arg2 / 2, f12_arg2 / 2)
	f12_local0.starImage:setImage(RegisterMaterial("menu_mp_star_rating"))
	f12_local0.starImage:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
	f12_local0:addElement(f12_local0.starImage)
	f12_local0:addSpacer(5)
	f12_local0.profileShotInfoText = LUI.UIText.new()
	f12_local0.profileShotInfoText:setLeftRight(true, false, 0, f12_arg2)
	f12_local0.profileShotInfoText:setTopBottom(false, false, -f12_arg2 / 2, f12_arg2 / 2)
	f12_local0.profileShotInfoText:setFont(f12_arg1)
	f12_local0.profileShotInfoText:setText(Engine.Localize("MENU_PROFILE_SHOT"))
	f12_local0.profileShotInfoText:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
	f12_local0:addElement(f12_local0.profileShotInfoText)
	return f12_local0
end

CoD.FileshareManager.FileDetails.new = function (f13_arg0, f13_arg1, f13_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f13_arg1, 0)
	Widget:setTopBottom(true, false, f13_arg0, f13_arg0 + f13_arg2)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget.body = Widget
	Widget:addElement(Widget)
	local f13_local2, f13_local3, f13_local4, f13_local5 = nil
	local f13_local6 = 0
	if not Engine.IsInGame() then
		f13_local4 = 180
		f13_local5 = 100
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, 0, f13_local4)
		Widget:setTopBottom(true, false, f13_local6, f13_local6 + f13_local5)
		Widget.body:addElement(Widget)
		local Widget = LUI.UIImage.new()
		Widget:setLeftRight(false, false, -f13_local4 / 2, f13_local4 / 2)
		Widget:setTopBottom(false, false, -f13_local5 / 2, f13_local5 / 2)
		Widget.thumbnail = Widget
		Widget:addElement(Widget)
		Widget.durationBacking = LUI.UIImage.new()
		Widget.durationBacking:setLeftRight(false, true, -55, -8)
		Widget.durationBacking:setTopBottom(true, false, 5, 5 + CoD.textSize.ExtraSmall)
		Widget.durationBacking:setRGB(0, 0, 0)
		Widget.durationBacking:setAlpha(0.8)
		Widget:addElement(Widget.durationBacking)
		Widget.durationText = LUI.UIText.new()
		Widget.durationText:setLeftRight(false, true, -55, -8)
		Widget.durationText:setTopBottom(true, false, 5, 5 + CoD.textSize.ExtraSmall)
		Widget.durationText:setFont(CoD.fonts.ExtraSmall)
		Widget.durationText:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		Widget.durationText:setAlignment(LUI.Alignment.Center)
		Widget:addElement(Widget.durationText)
		f13_local3 = CoD.textSize.ExtraSmall
		f13_local2 = CoD.fonts.ExtraSmall
		f13_local4 = f13_local4 + 5
	else
		f13_local4 = 0
		f13_local5 = 80
		f13_local3 = CoD.textSize.Default
		f13_local2 = CoD.fonts.Default
	end
	local Widget = LUI.UIText.new()
	Widget:setLeftRight(true, true, f13_local4, 0)
	Widget:setTopBottom(true, false, f13_local6, f13_local6 + f13_local3)
	Widget:setAlignment(LUI.Alignment.Left)
	Widget:setFont(f13_local2)
	Widget:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	Widget.name = Widget
	Widget.body:addElement(Widget)
	f13_local6 = f13_local6 + f13_local3 + 10
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, f13_local4, 0)
	Widget:setTopBottom(true, false, f13_local6, f13_local6 + f13_local3 * 3)
	Widget:setUseStencil(true)
	Widget.body:addElement(Widget)
	local f13_local9 = LUI.UIText.new()
	f13_local9:setLeftRight(true, true, 0, 0)
	f13_local9:setTopBottom(true, false, 0, f13_local3)
	f13_local9:setAlignment(LUI.Alignment.Left)
	f13_local9:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f13_local9:setFont(f13_local2)
	Widget.description = f13_local9
	Widget:addElement(f13_local9)
	f13_local6 = f13_local5 + 10
	local f13_local10 = LUI.UIText.new()
	f13_local10:setLeftRight(true, true, 0, 0)
	f13_local10:setTopBottom(true, false, f13_local6, f13_local6 + f13_local3)
	f13_local10:setAlignment(LUI.Alignment.Left)
	f13_local10:setFont(f13_local2)
	f13_local10:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	Widget.author = f13_local10
	Widget.body:addElement(f13_local10)
	f13_local6 = f13_local6 + f13_local3 + 5
	local f13_local11 = LUI.UIText.new()
	f13_local11:setLeftRight(true, true, 0, 0)
	f13_local11:setTopBottom(true, false, f13_local6, f13_local6 + f13_local3)
	f13_local11:setAlignment(LUI.Alignment.Left)
	f13_local11:setFont(f13_local2)
	if not Engine.IsInGame() then
		f13_local11:setRGB(CoD.offGray.r, CoD.offGray.g, CoD.offGray.b)
	else
		f13_local11:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	end
	Widget.date = f13_local11
	Widget.body:addElement(f13_local11)
	f13_local6 = f13_local6 + f13_local3 + 5
	local f13_local12 = CoD.FileshareManager.GetProfileShot(f13_local6, f13_local2, f13_local3)
	Widget.profileShotInfo = f13_local12
	Widget.body:addElement(f13_local12)
	if CoD.isZombie == false then
		local f13_local13 = LUI.UIText.new()
		f13_local13:setLeftRight(true, true, 0, 0)
		f13_local13:setTopBottom(true, false, f13_local6, f13_local6 + f13_local3)
		f13_local13:setFont(f13_local2)
		f13_local13:setAlignment(LUI.Alignment.Left)
		f13_local13:setRGB(CoD.offGray.r, CoD.offGray.g, CoD.offGray.b)
		f13_local13:setAlpha(0)
		Widget.playlistInfo = f13_local13
		Widget.body:addElement(f13_local13)
	end
	Widget.body:setAlpha(0)
	Widget.refresh = CoD.FileshareManager.FileDetails.Refresh
	return Widget
end

CoD.FileshareManager.List.CreatorCallback = function (f14_arg0, f14_arg1)
	f14_arg1.icon = CoD.FileshareSummary.GetShadedIcon()
	f14_arg1.icon:setLeftRight(true, false, 6, 56)
	f14_arg1.icon:setTopBottom(false, false, -16, 16)
	f14_arg1:addElement(f14_arg1.icon)
	f14_arg1.rowText = LUI.UIText.new()
	f14_arg1.rowText:setLeftRight(true, true, 70, 0)
	f14_arg1.rowText:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
	f14_arg1.rowText:setFont(CoD.fonts.Default)
	f14_arg1.rowText:setAlignment(LUI.Alignment.Left)
	f14_arg1:addElement(f14_arg1.rowText)
	f14_arg1.starImage = LUI.UIImage.new()
	f14_arg1.starImage:setLeftRight(false, true, -32, 0)
	f14_arg1.starImage:setTopBottom(false, false, -16, 16)
	f14_arg1.starImage:setImage(RegisterMaterial("menu_mp_star_rating"))
	f14_arg1.starImage:setRGB(CoD.yellowGlow.r, CoD.yellowGlow.g, CoD.yellowGlow.b)
	f14_arg1.starImage:hide()
	f14_arg1:addElement(f14_arg1.starImage)
end

CoD.FileshareManager.List.DataCallback = function (f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = CoD.FileshareManager.ShouldShowMtx(f15_arg0)
	if CoD.FileshareManager.SkipMtx then
		f15_local0 = false
	end
	if f15_local0 then
		if f15_arg1 == 1 then
			f15_arg2.rowText:setText(Engine.Localize("MENU_MTX_BUY_MEDIA_STORAGE"))
			if CoD.FileshareManager.DisableMTXForPS3() then
				f15_arg2.rowText:setAlpha(0.5)
				f15_arg2.icon:hide()
			else
				f15_arg2.icon:update(1, 1, 1, 0, 0, "menu_purchase_unlock_token_64")
				f15_arg2.icon:show()
				f15_arg2.rowText:setAlpha(1)
				f15_arg2.starImage:hide()
			end
			return 
		end
		f15_arg1 = f15_arg1 - 1
	end
	local f15_local1 = Engine.GetFileshareData(f15_arg0, f15_arg1 - 1)
	if f15_local1 ~= nil and f15_local1.valid == true then
		f15_arg2.icon:update(f15_local1.r, f15_local1.g, f15_local1.b, 1, 0.3, f15_local1.groupIcon)
		f15_arg2.icon:setAlpha(1)
		f15_arg2.rowText:setText(CoD.FileshareManager.GetName(f15_local1))
		f15_arg2.m_fileID = f15_local1.fileID
		f15_arg2.m_category = f15_local1.category
		f15_arg2.starImage:hide()
		if Engine.GetCombatRecordScreenshotInfo(f15_arg0, UIExpression.GetXUID(f15_arg0)) == f15_local1.fileID then
			f15_arg2.starImage:show()
		end
	elseif f15_local1 ~= nil then
		f15_arg2.rowText:setText(Engine.Localize("MENU_ERROR"))
		f15_arg2.m_category = f15_local1.category
		f15_arg2.m_fileID = f15_local1.fileID
		f15_arg2.icon:setAlpha(0)
	end
end

CoD.FileshareManager.List.FocusChanged = function (f16_arg0)
	local f16_local0 = f16_arg0.listBox:getFocussedIndex()
	local f16_local1 = f16_arg0.listBox.getFocussedMutables()
	local f16_local2 = CoD.FileshareManager.ShouldShowMtx(f16_arg0.m_ownerController)
	if CoD.FileshareManager.SkipMtx then
		f16_local2 = false
	end
	local f16_local3 = false
	if f16_local2 then
		if f16_local0 == 1 then
			f16_local3 = true
		else
			f16_local0 = f16_local0 - 1
		end
	end
	if f16_local3 then
		if f16_arg0.m_fileDetails ~= nil then
			f16_arg0.m_fileDetails:refresh(data, f16_arg0.m_ownerController, true)
		end
	else
		local f16_local4 = Engine.GetFileshareData(f16_arg0.m_ownerController, f16_local0 - 1)
		if f16_arg0.m_fileDetails ~= nil then
			f16_arg0.m_fileDetails:refresh(f16_local4, f16_arg0.m_ownerController, false)
		end
	end
	local f16_local4 = f16_arg0.fileshareManager
	if f16_local4 ~= nil then
		f16_local4.leftButtonPromptBar:removeAllChildren()
		if f16_local3 then
			if f16_local4.buyButton ~= nil then
				f16_local4:addLeftButtonPrompt(f16_local4.buyButton)
			end
		else
			f16_local4:addLeftButtonPrompt(f16_local4.deleteButton)
		end
		f16_local4:addBackButton()
	end
end

CoD.FileshareManager.List.SelectionClicked = function (f17_arg0)
	local f17_local0 = f17_arg0.listBox:getFocussedIndex()
	local f17_local1 = CoD.FileshareManager.ShouldShowMtx(f17_arg0.m_ownerController)
	local f17_local2 = f17_arg0.fileshareManager
	if CoD.FileshareManager.SkipMtx then
		f17_local1 = false
	end
	if f17_local1 and f17_local0 == 1 then
		f17_local2:processEvent({
			name = "fileshare_buy_storage",
			controller = f17_arg0.m_ownerController
		})
	else
		f17_local2:processEvent({
			name = "fileshare_slot_deleteconfirmation",
			controller = f17_arg0.m_ownerController
		})
	end
end

CoD.FileshareManager.List.new = function (f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4, f18_arg5, f18_arg6)
	local Widget = LUI.UIElement.new()
	Widget.m_ownerController = f18_arg0
	Widget.m_fileDetails = f18_arg6
	local f18_local1 = CoD.FileshareManager.ShouldShowMtx(f18_arg0)
	if CoD.FileshareManager.SkipMtx then
		f18_local1 = false
	end
	if f18_local1 then
		f18_arg5 = f18_arg5 + 1
	end
	Widget:registerEventHandler("listbox_focus_changed", CoD.FileshareManager.List.FocusChanged)
	if CoD.isPC then
		Widget:registerEventHandler("listbox_clicked", CoD.FileshareManager.List.SelectionClicked)
	end
	Widget:setLeftRight(true, false, f18_arg1, f18_arg1 + f18_arg3)
	Widget:setTopBottom(true, false, f18_arg2, f18_arg2 + f18_arg4)
	local f18_local2 = LUI.UIImage.new()
	f18_local2:setLeftRight(true, true, -8, 8)
	f18_local2:setTopBottom(true, true, -8, 14)
	f18_local2:setRGB(0.3, 0.3, 0.3)
	f18_local2:setAlpha(0.2)
	Widget:addElement(f18_local2)
	Widget.listBox = CoD.ListBox.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	}, f18_arg0, 11, 42, f18_arg3, CoD.FileshareManager.List.CreatorCallback, CoD.FileshareManager.List.DataCallback, 0, 0)
	Widget.listBox:addScrollBar(30, 2)
	Widget.listBox.m_pageArrowsOn = true
	Widget:addElement(Widget.listBox)
	Widget.listBox:setTotalItems(f18_arg5, nil)
	Widget.listBox:refresh()
	return Widget
end

function FileshareManager_ReloadList(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
	if f19_arg0.list ~= nil then
		f19_arg0.m_groupName = f19_arg3
		CoD.FileshareManager.Refresh(f19_arg0, {
			controller = f19_arg1
		})
	end
end

function FileshareManager_AllTab(f20_arg0, f20_arg1)
	CoD.FileshareManager.SkipMtx = false
	FileshareManager_ReloadList(f20_arg0.popup, f20_arg1, nil, nil)
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

function FileshareManager_VideosTab(f21_arg0, f21_arg1)
	CoD.FileshareManager.SkipMtx = true
	FileshareManager_ReloadList(f21_arg0.popup, f21_arg1, "render", "renders")
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

function FileshareManager_FilmsTab(f22_arg0, f22_arg1)
	CoD.FileshareManager.SkipMtx = false
	FileshareManager_ReloadList(f22_arg0.popup, f22_arg1, "film", "gamefilms")
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

function FileshareManager_ScreenshotsTab(f23_arg0, f23_arg1)
	CoD.FileshareManager.SkipMtx = false
	FileshareManager_ReloadList(f23_arg0.popup, f23_arg1, "screenshot", "screenshots")
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

function FileshareManager_CustomGamesTab(f24_arg0, f24_arg1)
	CoD.FileshareManager.SkipMtx = false
	FileshareManager_ReloadList(f24_arg0.popup, f24_arg1, "customgame", "customgames")
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

function FileshareManager_EmblemsTab(f25_arg0, f25_arg1)
	CoD.FileshareManager.SkipMtx = false
	FileshareManager_ReloadList(f25_arg0.popup, f25_arg1, "emblem", "emblems")
	return LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
end

CoD.FileshareManager.SlotsAvailable = function (f26_arg0, f26_arg1)
	f26_arg0.spinner:setAlpha(0)
	if f26_arg1.valid == false then
		f26_arg0.occludedMenu:openPopup("FileshareManager_Error", f26_arg1.controller)
		f26_arg0:close()
		return 
	elseif f26_arg0.tabManager == nil and f26_arg0.m_tabbed == true then
		local f26_local0 = {
			left = 0,
			top = 55,
			right = 0,
			bottom = CoD.ButtonPrompt.Height,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = false
		}
		f26_arg0.tabContentPane = LUI.UIElement.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = -CoD.ButtonPrompt.Height,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true
		})
		local f26_local1 = CoD.MFTabManager.new(f26_arg0.tabContentPane, f26_local0)
		f26_local1:keepRightBumperAlignedToHeader(true)
		f26_local1.popup = f26_arg0
		f26_arg0.tabManager = f26_local1
		f26_arg0:addElement(f26_local1)
		f26_local1:addTab(f26_arg1.controller, "MENU_FILESHARE_ALL", FileshareManager_AllTab)
		f26_local1:addTab(f26_arg1.controller, "MENU_FILESHARE_GAME_FILMSCLIPS", FileshareManager_FilmsTab)
		f26_local1:addTab(f26_arg1.controller, "MENU_FILESHARE_SCREENSHOTS", FileshareManager_ScreenshotsTab)
		f26_local1:addTab(f26_arg1.controller, "MENU_FILESHARE_CUSTOMGAMES", FileshareManager_CustomGamesTab)
		f26_local1:addTab(f26_arg1.controller, "MENU_FILESHARE_EMBLEMS", FileshareManager_EmblemsTab)
		f26_local1:addTab(f26_arg1.controller, "MENU_FILESHARE_RENDEREDVIDEOS", FileshareManager_VideosTab)
		f26_local1:refreshTab(f26_arg1.controller)
	end
	local f26_local0 = Engine.GetFileshareCategories(f26_arg1.controller)
	if f26_arg0.groupSummary == nil then
		if not Engine.IsInGame() then
			f26_arg0.groupSummary = CoD.FileshareSummary.new(287, 430, 371, f26_local0, f26_arg0.m_groupName, f26_arg0.m_pulse)
		else
			f26_arg0.groupSummary = CoD.FileshareSummary.new(270, 430, 371, f26_local0, f26_arg0.m_groupName, f26_arg0.m_pulse)
		end
		f26_arg0:addElement(f26_arg0.groupSummary)
	end
	if f26_arg0.details == nil then
		f26_arg0.details = CoD.FileshareManager.FileDetails.new(95, 430, 300)
		f26_arg0:addElement(f26_arg0.details)
	end
	local f26_local1 = 0
	for f26_local2 = 1, #f26_local0, 1 do
		if f26_arg0.m_groupName == nil then
			f26_local1 = f26_local1 + f26_local0[f26_local2].occupied
		end
		if f26_arg0.m_groupName == f26_local0[f26_local2].name then
			f26_local1 = f26_local1 + f26_local0[f26_local2].occupied
		end
	end
	if f26_arg0.list == nil then
		f26_arg0.list = CoD.FileshareManager.List.new(f26_arg1.controller, 0, 95, 385, 487, f26_local1, f26_arg0.details)
		f26_arg0.list.fileshareManager = f26_arg0
		f26_arg0:addElement(f26_arg0.list)
	end
	local f26_local2 = CoD.FileshareManager.ShouldShowMtx(f26_arg1.controller)
	if CoD.FileshareManager.SkipMtx then
		f26_local2 = false
	end
	f26_arg0.leftButtonPromptBar:removeAllChildren()
	if not f26_local2 then
		if f26_local1 > 0 then
			f26_arg0:addLeftButtonPrompt(f26_arg0.deleteButton)
		end
	elseif f26_arg0.buyButton ~= nil then
		f26_arg0:addLeftButtonPrompt(f26_arg0.buyButton)
	end
	f26_arg0:addBackButton()
end

CoD.FileshareManager.SlotDeleteConfirmation = function (f27_arg0, f27_arg1)
	local f27_local0 = f27_arg0.list.listBox:getFocussedMutables()
	if f27_local0 ~= nil and f27_local0.m_fileID ~= nil then
		CoD.perController[f27_arg1.controller].FileshareManagerCurrFileID = f27_local0.m_fileID
		local f27_local1 = f27_arg0:openPopup("FileshareManager_ConfirmDelete", f27_arg1.controller, {
			deleteAction = "fileshareDelete " .. f27_local0.m_fileID,
			category = f27_local0.m_category
		})
		f27_local1.callingMenu = f27_arg0
	end
end

CoD.FileshareManager.Refresh = function (f28_arg0, f28_arg1)
	f28_arg0.spinner:setAlpha(1)
	f28_arg0.details:close()
	f28_arg0.details = nil
	f28_arg0.groupSummary:close()
	f28_arg0.groupSummary = nil
	f28_arg0.list:close()
	f28_arg0.list = nil
	f28_arg0.leftButtonPromptBar:removeAllChildren()
	f28_arg0:addBackButton()
	f28_arg0.m_isRefresh = true
	if f28_arg0.m_groupName == nil then
		Engine.Exec(f28_arg1.controller, "fileshareGetSlots")
	else
		Engine.Exec(f28_arg1.controller, "fileshareGetSlots " .. f28_arg0.m_groupName)
	end
end

CoD.FileshareManager.ShouldShowMtx = function (f29_arg0)
	if not Engine.IsMTXAvailable(Dvar.fshMtxName:get()) then
		return false
	elseif Engine.HasMTX(f29_arg0, Dvar.fshMtxName:get()) then
		return false
	else
		return true
	end
end

CoD.FileshareManager.HasMtx = function (f30_arg0)
	return Engine.HasMTX(f30_arg0, Dvar.fshMtxName:get())
end

CoD.FileshareManager.BuyStorage = function (f31_arg0, f31_arg1)
	if UIExpression.IsGuest(f31_arg1.controller) == 1 then
		local f31_local0 = f31_arg0:openPopup("Error", controller)
		f31_local0:setMessage(Engine.Localize("XBOXLIVE_NOGUESTACCOUNTS"))
	elseif CoD.isPS3 then
		f31_arg0:openPopup("MTXPurchase", f31_arg1.controller, {
			mtxName = Dvar.fshMtxName:get(),
			openingMenuName = "fileshare"
		})
	else
		Engine.SetStartCheckoutTimestampUTC()
		Engine.PurchaseMTX(f31_arg1.controller, Dvar.fshMtxName:get(), "fileshare")
	end
end

CoD.FileshareManager.HandleMTXChanged = function (f32_arg0, f32_arg1)
	if f32_arg1.controller ~= f32_arg0.m_ownerController then
		return 
	else
		CoD.FileshareManager.Refresh(f32_arg0, f32_arg1)
	end
end

CoD.FileshareManager.DisableMTXForPS3 = function ()
	local f33_local0 = CoD.isPS3
	if f33_local0 then
		if Engine.GameModeIsMode(CoD.GAMEMODE_THEATER) ~= true or UIExpression.IsInGame() ~= 1 then
			f33_local0 = false
		else
			f33_local0 = true
		end
	end
	return f33_local0
end

LUI.createMenu.FileshareManager = function (f34_arg0, f34_arg1)
	local f34_local0 = CoD.Menu.New("FileshareManager")
	CoD.FileshareManager.SkipMtx = false
	if f34_arg1 ~= nil and f34_arg1.groupName ~= nil and f34_arg1.groupName == "renders" then
		CoD.FileshareManager.SkipMtx = true
	end
	if not Engine.IsInGame() then
		f34_local0:addLargePopupBackground()
	end
	f34_local0:setOwner(f34_arg0)
	f34_local0:addTitle(Engine.Localize("MENU_FILEMANAGER_CAPS"), LUI.Alignment.Left)
	if f34_arg1 ~= nil then
		f34_local0.m_category = f34_arg1.category
		f34_local0.m_groupName = f34_arg1.groupName
		f34_local0.m_pulse = true
		f34_local0.m_tabbed = false
	else
		f34_local0.m_pulse = false
		f34_local0.m_tabbed = true
	end
	f34_local0.m_isRefresh = false
	local f34_local1 = LUI.UIImage.new({
		shaderVector0 = {
			0,
			0,
			0,
			0
		}
	})
	f34_local1:setImage(RegisterMaterial("lui_loader"))
	f34_local1:setTopBottom(false, false, -32, 32)
	f34_local1:setLeftRight(false, false, -32, 32)
	f34_local0.spinner = f34_local1
	f34_local0:addElement(f34_local1)
	local f34_local2 = CoD.ButtonPrompt.new
	local f34_local3 = "alt1"
	local f34_local4 = Engine.Localize("MENU_DELETE")
	local f34_local5 = f34_local0
	local f34_local6 = "fileshare_slot_deleteconfirmation"
	local f34_local7, f34_local8 = false
	local f34_local9, f34_local10 = false
	f34_local0.deleteButton = f34_local2(f34_local3, f34_local4, f34_local5, f34_local6, f34_local7, f34_local8, f34_local9, f34_local10, "X")
	if not CoD.FileshareManager.DisableMTXForPS3() then
		f34_local2 = CoD.ButtonPrompt.new
		f34_local3 = "primary"
		f34_local4 = Engine.Localize("MENU_STORE_BUY")
		f34_local5 = f34_local0
		f34_local6 = "fileshare_buy_storage"
		f34_local7, f34_local8 = false
		f34_local9, f34_local10 = false
		f34_local0.buyButton = f34_local2(f34_local3, f34_local4, f34_local5, f34_local6, f34_local7, f34_local8, f34_local9, f34_local10, "B")
	end
	f34_local0:registerEventHandler("fileshare_slots_available", CoD.FileshareManager.SlotsAvailable)
	f34_local0:registerEventHandler("fileshare_slot_deleteconfirmation", CoD.FileshareManager.SlotDeleteConfirmation)
	f34_local0:registerEventHandler("fileshare_buy_storage", CoD.FileshareManager.BuyStorage)
	f34_local0:registerEventHandler("fileshare_slots_refresh", CoD.FileshareManager.Refresh)
	f34_local0:registerEventHandler("mtx_changed", CoD.FileshareManager.HandleMTXChanged)
	if f34_local0.m_category ~= nil then
		Engine.Exec(f34_arg0, "fileshareGetSlots " .. f34_local0.m_groupName)
	else
		Engine.Exec(f34_arg0, "fileshareGetSlots")
	end
	f34_local0:addBackButton()
	return f34_local0
end

