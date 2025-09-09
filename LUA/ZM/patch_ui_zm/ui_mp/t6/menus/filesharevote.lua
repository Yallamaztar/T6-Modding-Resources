require("LUI.LUIVerticalList")
CoD.FileshareVote = {}
CoD.FileshareVote.Categories = {}
CoD.FileshareVote.ClosePopup = function (f1_arg0, f1_arg1)
	f1_arg0:goBack(f1_arg1.controller)
end

CoD.FileshareVote.VoteCast = function (f2_arg0, f2_arg1)
	f2_arg0.m_updateTarget:processEvent({
		name = "infopanel_update_votes"
	})
	f2_arg0.title:setTopBottom(true, false, 0, CoD.textSize.Big)
	f2_arg0.title:setFont(CoD.fonts.Big)
	f2_arg0.title:setText(Engine.Localize("MENU_NOTICE"))
	local f2_local0 = CoD.textSize.Big + 20
	local f2_local1 = LUI.UIText.new()
	f2_local1:setLeftRight(true, true, 0, 0)
	f2_local1:setTopBottom(true, false, f2_local0, f2_local0 + CoD.textSize.Default)
	f2_local1:setFont(CoD.fonts.Default)
	f2_local1:setAlignment(LUI.Alignment.Left)
	f2_arg0:addElement(f2_local1)
	if f2_arg1.success == true then
		f2_local1:setText(Engine.Localize("MENU_FILESHARE_VOTE_SUCCESS"))
	else
		f2_local1:setText(Engine.Localize("MENU_FILESHARE_VOTE_FAILED"))
	end
	if f2_arg0.loader ~= nil then
		f2_arg0.loader:setAlpha(0)
	end
	f2_arg0.leftButtonPromptBar:removeAllChildren()
	local f2_local2 = CoD.ButtonPrompt.new
	local f2_local3 = "primary"
	local f2_local4 = Engine.Localize("MENU_ACCEPT")
	local f2_local5 = f2_arg0
	local f2_local6 = "fileshare_upload_accept"
	local f2_local7, f2_local8 = false
	f2_arg0:addLeftButtonPrompt(f2_local2(f2_local3, f2_local4, f2_local5, f2_local6, f2_local7, f2_local8, false))
end

CoD.FileshareVote.GetVoteCategory = function (f3_arg0)
	if f3_arg0 == "film" then
		return 0
	elseif f3_arg0 == "clip" then
		return 1
	elseif f3_arg0 == "screenshot" then
		return 2
	elseif f3_arg0 == "customgame" then
		return 3
	elseif f3_arg0 == "emblem" then
		return 5
	else
		return -1
	end
end

CoD.FileshareVote.ButtonGainFocus = function (f4_arg0, f4_arg1)
	f4_arg0.text:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f4_arg0.imageBackground:setRGB(f4_arg0.m_highlightColor.r, f4_arg0.m_highlightColor.g, f4_arg0.m_highlightColor.b)
	f4_arg0.image:setRGB(f4_arg0.m_highlightColor.r, f4_arg0.m_highlightColor.g, f4_arg0.m_highlightColor.b)
	f4_arg0.hintArea:updateText(f4_arg0.hintText)
	f4_arg0.fileshareVote.leftButtonPromptBar:removeAllChildren()
	if f4_arg0.m_action == nil then
		f4_arg0.hintArea:updateText(Engine.Localize("MENU_FILESHARE_VOTE_WARNING"))
	else
		f4_arg0.fileshareVote:addSelectButton()
	end
	f4_arg0.fileshareVote:addBackButton()
	LUI.UIElement.gainFocus(f4_arg0, f4_arg1)
end

CoD.FileshareVote.ButtonLoseFocus = function (f5_arg0, f5_arg1)
	f5_arg0.text:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.imageBackground:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f5_arg0.image:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	LUI.UIElement.loseFocus(f5_arg0, f5_arg1)
end

CoD.FileshareVote.ButtonSelected = function (f6_arg0, f6_arg1)
	if f6_arg0:isInFocus() and f6_arg0.m_action ~= nil then
		Engine.Exec(f6_arg1.controller, f6_arg0.m_action)
		local f6_local0 = f6_arg0.fileshareVote
		f6_local0.body:close()
		f6_local0.title:setText(Engine.Localize("MENU_FILESHARE_VOTING"))
		f6_local0.loader = LUI.UIImage.new()
		f6_local0.loader:setLeftRight(false, false, -32, 32)
		f6_local0.loader:setTopBottom(false, false, -32, 32)
		f6_local0.loader:setImage(RegisterMaterial("lui_loader"))
		f6_local0.loader:setShaderVector(0, 0, 0, 0, 0)
		f6_local0.loader:setAlpha(1)
		f6_local0:addElement(f6_local0.loader)
		f6_local0.leftButtonPromptBar:removeAllChildren()
		f6_local0:addBackButton()
	end
end

CoD.FileshareVote.ButtonPressed = function (f7_arg0, f7_arg1)
	f7_arg0.verticalList:dispatchEventToChildren(f7_arg1)
end

CoD.FileshareVote.CreateButton = function (f8_arg0, f8_arg1, f8_arg2, f8_arg3, f8_arg4, f8_arg5, f8_arg6, f8_arg7)
	local f8_local0 = LUI.UIButton.new({
		left = 0,
		right = 0,
		top = 0,
		bottom = 32,
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = false
	}, "vote_selected")
	f8_local0.fileshareVote = f8_arg0
	f8_local0.hintArea = f8_arg6
	f8_local0.hintText = f8_arg7
	
	local imageBackground = LUI.UIImage.new()
	imageBackground:setLeftRight(true, false, 0, 32)
	imageBackground:setTopBottom(false, false, -16, 16)
	imageBackground:setImage(RegisterMaterial("menu_mp_lobby_views_bg"))
	f8_local0:addElement(imageBackground)
	f8_local0.imageBackground = imageBackground
	
	local image = LUI.UIImage.new()
	image:setLeftRight(true, false, 0, 32)
	image:setTopBottom(false, false, -16, 16)
	image:setImage(RegisterMaterial(f8_arg1))
	if f8_arg2 ~= 0 then
		image:setTopBottom(false, false, -14, 18)
		image:setZRot(f8_arg2)
	end
	f8_local0:addElement(image)
	f8_local0.image = image
	
	local text = LUI.UIText.new()
	text:setLeftRight(true, true, 32, 0)
	text:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
	text:setFont(CoD.fonts.Default)
	text:setAlignment(LUI.Alignment.Left)
	text:setText(f8_arg3)
	f8_local0:addElement(text)
	f8_local0.text = text
	
	f8_local0:registerEventHandler("gain_focus", CoD.FileshareVote.ButtonGainFocus)
	f8_local0:registerEventHandler("lose_focus", CoD.FileshareVote.ButtonLoseFocus)
	f8_local0:registerEventHandler("vote_selected", CoD.FileshareVote.ButtonSelected)
	f8_local0.m_action = f8_arg5
	f8_local0.m_highlightColor = f8_arg4
	f8_local0.text:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f8_local0.imageBackground:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f8_local0.image:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	return f8_local0
end

LUI.createMenu.FileshareVote = function (f9_arg0)
	local f9_local0 = CoD.Menu.NewMediumPopup("FileshareVote")
	local f9_local1 = CoD.perController[f9_arg0].voteData
	f9_local0:setOwner(f9_arg0)
	f9_local0.m_fileID = f9_local1.fileID
	f9_local0.m_updateTarget = CoD.perController[f9_arg0].voteUpdateTarget
	f9_local0.body = LUI.UIElement.new()
	f9_local0.body:setLeftRight(true, true, 0, 0)
	f9_local0.body:setTopBottom(true, true, 0, 0)
	f9_local0:addElement(f9_local0.body)
	local f9_local2 = 0
	f9_local0.title = LUI.UIText.new()
	f9_local0.title:setLeftRight(true, true, 0, 0)
	f9_local0.title:setTopBottom(true, false, f9_local2, f9_local2 + CoD.textSize.Big)
	f9_local0.title:setFont(CoD.fonts.Big)
	f9_local0.title:setAlignment(LUI.Alignment.Left)
	f9_local0.title:setText(Engine.Localize("MENU_SOCIAL"))
	f9_local0:addElement(f9_local0.title)
	local f9_local3 = f9_local2 + CoD.textSize.Big + 40
	local f9_local4 = LUI.UIVerticalList.new()
	f9_local4:setLeftRight(true, true, 0, 0)
	f9_local4:setTopBottom(true, false, f9_local3, f9_local3 + 300)
	f9_local4:makeFocusable()
	f9_local0.verticalList = f9_local4
	f9_local0.body:addElement(f9_local4)
	local f9_local5 = CoD.FileshareVote.GetVoteCategory(f9_local1.category)
	local f9_local6 = Engine.GetVote(f9_arg0, f9_local1.fileID, f9_local5)
	local f9_local7 = "vote_submitLike " .. f9_local1.fileID .. " " .. f9_local5
	local f9_local8 = "vote_submitDislike " .. f9_local1.fileID .. " " .. f9_local5
	if f9_local6 ~= nil then
		if f9_local6 == "like" then
			f9_local7 = nil
		elseif f9_local6 == "dislike" then
			f9_local8 = nil
		end
	end
	local f9_local9 = CoD.HintText.new()
	f9_local9:setLeftRight(true, false, 0, 350)
	f9_local9:setTopBottom(true, false, 200, 200 + CoD.HintText.Height)
	f9_local9:setColor(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b, 0.4)
	f9_local0.body:addElement(f9_local9)
	f9_local4:addElement(CoD.FileshareVote.CreateButton(f9_local0, "menu_mp_lobby_like", 0, Engine.Localize("MENU_FILESHARE_LIKE"), CoD.green, f9_local7, f9_local9, Engine.Localize("MENU_FILESHARE_VOTE_LIKEHINT")))
	f9_local4:addElement(CoD.FileshareVote.CreateButton(f9_local0, "menu_mp_lobby_like", 180, Engine.Localize("MENU_FILESHARE_DISLIKE"), CoD.brightRed, f9_local8, f9_local9, Engine.Localize("MENU_FILESHARE_VOTE_DISLIKEHINT")))
	f9_local3 = f9_local3 + CoD.textSize.Default * 2 + 22
	f9_local0:registerEventHandler("vote_selected", CoD.FileshareVote.ButtonPressed)
	f9_local0:registerEventHandler("vote_cast", CoD.FileshareVote.VoteCast)
	f9_local0:registerEventHandler("fileshare_upload_accept", CoD.FileshareVote.ClosePopup)
	f9_local0:addSelectButton()
	f9_local0:addBackButton()
	f9_local3 = 5
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -470, 0)
	Widget:setTopBottom(true, true, 0, 0)
	f9_local0.body:addElement(Widget)
	local f9_local11 = 250
	local f9_local12 = f9_local11 * 9 / 16
	local f9_local13 = LUI.UIImage.new()
	if f9_local1.category == "customgame" then
		f9_local11 = 128
		f9_local12 = f9_local11
		f9_local13:setImage(RegisterMaterial(UIExpression.TableLookup(f9_arg0, CoD.gametypesTable, 0, 0, 1, f9_local1.gameType, 4)))
	elseif f9_local1.category == "film" then
		if CoD.isZombie then
			if f9_local1.zmMapStartLoc == nil then
				f9_local1.zmMapStartLoc = Dvar.ui_zm_mapstartlocation:get()
			end
			f9_local13:setImage(RegisterMaterial("menu_" .. CoD.Zombie.GetMapName(f9_local1.map) .. "_" .. UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, f9_local1.gameType, 9) .. "_" .. f9_local1.zmMapStartLoc))
		else
			f9_local13:setImage(RegisterMaterial("menu_" .. f9_local1.map .. "_map_select_final"))
		end
	elseif f9_local1.category == "emblem" then
		if f9_local1.fromLobby == nil or f9_local1.fromLobby == false then
			f9_local13:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_EMBLEM, f9_local1.fileID)
			f9_local11 = 128
			f9_local12 = f9_local11
		else
			f9_local13:setupPlayerEmblemByXUID(f9_local1.selectedPlayerXuid)
			f9_local11 = 256
			f9_local12 = f9_local11
		end
	elseif f9_local1.fromLobby == nil or f9_local1.fromLobby == false then
		f9_local13:setupImageViewer(CoD.UI_SCREENSHOT_TYPE_THUMBNAIL, f9_local1.fileID)
	elseif f9_local1.map ~= nil then
		if CoD.isZombie then
			if f9_local1.zmMapStartLoc == nil then
				f9_local1.zmMapStartLoc = Dvar.ui_zm_mapstartlocation:get()
			end
			f9_local13:setImage(RegisterMaterial("menu_" .. CoD.Zombie.GetMapName(f9_local1.map) .. "_" .. UIExpression.TableLookup(nil, CoD.gametypesTable, 0, 0, 1, f9_local1.gameType, 9) .. "_" .. f9_local1.zmMapStartLoc))
		else
			f9_local13:setImage(RegisterMaterial("menu_" .. f9_local1.map .. "_map_select_final"))
		end
	end
	f9_local13:setLeftRight(true, false, 0, f9_local11)
	f9_local13:setTopBottom(true, false, f9_local3, f9_local3 + f9_local12)
	Widget:addElement(f9_local13)
	f9_local3 = f9_local3 + f9_local12
	if f9_local1.name ~= nil then
		local Widget = LUI.UIText.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, false, f9_local3, f9_local3 + CoD.textSize.Condensed)
		Widget:setFont(CoD.fonts.Condensed)
		Widget:setText(f9_local1.name)
		Widget:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		Widget:setAlignment(LUI.Alignment.Left)
		Widget:addElement(Widget)
		f9_local3 = f9_local3 + CoD.textSize.Condensed
	end
	if f9_local1.description ~= nil then
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, false, f9_local3, f9_local3 + CoD.textSize.Default * 3)
		Widget:setUseStencil(true)
		Widget:addElement(Widget)
		local f9_local15 = LUI.UIText.new()
		f9_local15:setLeftRight(true, true, 0, 0)
		f9_local15:setTopBottom(true, false, 0, CoD.textSize.Default)
		f9_local15:setFont(CoD.fonts.Default)
		f9_local15:setText(f9_local1.description)
		f9_local15:setRGB(CoD.offGray.r, CoD.offGray.g, CoD.offGray.b)
		f9_local15:setAlignment(LUI.Alignment.Left)
		Widget:addElement(f9_local15)
		f9_local3 = f9_local3 + CoD.textSize.Default * 3
	end
	if f9_local1.time ~= nil then
		local Widget = LUI.UIText.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, false, f9_local3, f9_local3 + CoD.textSize.Default)
		Widget:setFont(CoD.fonts.Default)
		Widget:setText(f9_local1.time)
		Widget:setRGB(CoD.offGray.r, CoD.offGray.g, CoD.offGray.b)
		Widget:setAlignment(LUI.Alignment.Left)
		Widget:addElement(Widget)
		f9_local3 = f9_local3 + CoD.textSize.Default
	end
	if f9_local1.author ~= nil then
		local Widget = LUI.UIText.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, false, f9_local3, f9_local3 + CoD.textSize.Default)
		Widget:setFont(CoD.fonts.Default)
		Widget:setText(Engine.Localize("MENU_FILESHARE_AUTHOR") .. " " .. f9_local1.author)
		Widget:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
		Widget:setAlignment(LUI.Alignment.Left)
		Widget:addElement(Widget)
		f9_local3 = f9_local3 + CoD.textSize.Default + 10
	end
	if f9_local1.views ~= nil then
		local Widget = CoD.FileshareManager.StatPanel(0, f9_local3, "views")
		Widget:update(f9_local1.views)
		Widget:addElement(Widget)
	end
	if f9_local1.likes ~= nil then
		local Widget = CoD.FileshareManager.StatPanel(145, f9_local3, "likes")
		Widget:update(f9_local1.likes)
		Widget:addElement(Widget)
	end
	if f9_local1.dislikes ~= nil then
		local Widget = CoD.FileshareManager.StatPanel(290, f9_local3, "dislikes")
		Widget:update(f9_local1.dislikes)
		Widget:addElement(Widget)
	end
	f9_local4:processEvent({
		name = "gain_focus"
	})
	return f9_local0
end

