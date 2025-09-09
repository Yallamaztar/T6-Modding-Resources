require("T6.CategoryButton")
CoD.ChangeMap = {}
CoD.ChangeMap.MaxCategories = 2
CoD.ChangeMap.CategoryNames = {
	"standard",
	"dlc"
}
CoD.ChangeMap.CategoryIndex = {
	CoD.CONTENT_ORIGINAL_MAP_INDEX,
	nil
}
CoD.ChangeMap.CategoryIconNames = {
	"playlist_map",
	"playlist_map"
}
LUI.createMenu.ChangeMap = function (f1_arg0)
	local f1_local0 = CoD.Menu.New("ChangeMap")
	f1_local0:addTitle(Engine.Localize("MPUI_CHANGE_MAP_CAPS"))
	f1_local0:addLargePopupBackground()
	f1_local0.m_ownerController = f1_arg0
	f1_local0:addSelectButton()
	f1_local0:addBackButton()
	local f1_local1 = CoD.CoD9Button.Height
	local f1_local2 = (CoD.Menu.Width - f1_local1 * 2) / 3
	local f1_local3 = 0
	f1_local0.categoryContainer = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local3,
		right = f1_local3 + f1_local2,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.Menu.TitleHeight,
		bottom = 0,
		alpha = 1
	})
	f1_local0.categoryContainer:registerAnimationState("disabled", {
		alpha = 0.5
	})
	f1_local0:addElement(f1_local0.categoryContainer)
	f1_local0.categoryButtonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	f1_local0.categoryButtonList.id = f1_local0.categoryButtonList.id .. ".CategoryButtonList"
	f1_local0.categoryContainer:addElement(f1_local0.categoryButtonList)
	f1_local3 = f1_local3 + f1_local2 - f1_local1
	f1_local0.mapContainer = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local3,
		right = f1_local3 + f1_local2,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.Menu.TitleHeight,
		bottom = 0
	})
	f1_local0:addElement(f1_local0.mapContainer)
	f1_local0.mapButtonList = CoD.ButtonList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0
	})
	f1_local0.mapButtonList.id = f1_local0.mapButtonList.id .. ".mapButtonList"
	f1_local0.mapContainer:addElement(f1_local0.mapButtonList)
	f1_local3 = f1_local3 + f1_local2
	if CoD.useMouse then
		f1_local0.mapButtonList:setHandleMouseButton(true)
		f1_local0.mapButtonList:registerEventHandler("leftmouseup_outside", CoD.MainMenu.FlyoutBack)
	end
	local f1_local4 = f1_local2 + f1_local1 * 2
	f1_local0.infoContainer = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local3,
		right = f1_local3 + f1_local4,
		topAnchor = true,
		bottomAnchor = true,
		top = CoD.Menu.TitleHeight,
		bottom = 0
	})
	f1_local0:addElement(f1_local0.infoContainer)
	local f1_local5 = f1_local4 - 100
	local f1_local6 = f1_local5
	f1_local0.infoContainer.icon = LUI.UIImage.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f1_local5 / 2,
		right = f1_local5 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = f1_local6,
		alpha = 0
	})
	f1_local0.infoContainer:addElement(f1_local0.infoContainer.icon)
	f1_local0.infoContainer.iconHeight = f1_local6
	local f1_local7 = f1_local6 * 1.7
	local f1_local8 = 136
	local f1_local9 = f1_local6 + 15
	f1_local0.infoContainer.titleElement = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f1_local7 / 2,
		right = f1_local7 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local9,
		bottom = f1_local9 + CoD.textSize.Big,
		font = CoD.fonts.Big,
		alignment = LUI.Alignment.Left
	})
	f1_local0.infoContainer.titleElement:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.infoContainer:addElement(f1_local0.infoContainer.titleElement)
	f1_local9 = f1_local9 + CoD.textSize.Big + 5
	f1_local0.infoContainer.description = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f1_local7 / 2,
		right = f1_local7 / 2,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local9,
		bottom = f1_local9 + CoD.textSize.Default,
		font = CoD.fonts.Default,
		alignment = LUI.Alignment.Left
	})
	f1_local0.infoContainer.description:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f1_local0.infoContainer:addElement(f1_local0.infoContainer.description)
	f1_local0:registerEventHandler("category_button_action", CoD.ChangeMap.CategoryButtonAction)
	f1_local0:registerEventHandler("category_button_gain_focus", CoD.ChangeMap.Button_GainFocus)
	f1_local0:registerEventHandler("category_button_lose_focus", CoD.ChangeMap.Button_LoseFocus)
	f1_local0:registerEventHandler("map_button_action", CoD.ChangeMap.MapSelected)
	f1_local0:registerEventHandler("map_button_gain_focus", CoD.ChangeMap.Button_GainFocus)
	f1_local0:registerEventHandler("map_button_lose_focus", CoD.ChangeMap.Button_LoseFocus)
	f1_local0.updateInfo = CoD.ChangeMap.UpdateInfo
	f1_local0.addMapButtons = CoD.ChangeMap.AddMapButtons
	CoD.ChangeMap.AddCategoryButtons(f1_local0)
	return f1_local0
end

CoD.ChangeMap.MapSelected = function (f2_arg0, f2_arg1)
	Engine.PlaySound("cac_slide_equip_item")
	f2_arg0.mapButtonList:saveState()
	Engine.SetDvar("ui_mapname", f2_arg1.itemInfo.loadName)
	Engine.Exec(f2_arg1.controller, "xupdatepartystate")
	Engine.SetProfileVar(f2_arg1.controller, CoD.profileKey_map, f2_arg1.itemInfo.loadName)
	f2_arg0.occludedMenu:processEvent({
		name = "map_update",
		controller = f2_arg1.controller,
		map = f2_arg1.itemInfo.loadName
	})
	Engine.PartyHostClearUIState()
	Engine.CommitProfileChanges(f2_arg0.m_ownerController)
	Engine.SystemNeedsUpdate(nil, "lobby")
	Engine.SystemNeedsUpdate(nil, "game_options")
	f2_arg0:goBack(f2_arg0.m_ownerController)
end

CoD.ChangeMap.CategoryBack = function (f3_arg0, f3_arg1)
	f3_arg0.mapButtonList:saveState()
	Engine.PartyHostClearUIState()
	Engine.CommitProfileChanges(f3_arg0.m_ownerController)
	CoD.Menu.ButtonPromptBack(f3_arg0, f3_arg1)
end

CoD.ChangeMap.MapBack = function (f4_arg0, f4_arg1)
	f4_arg0.mapButtonList:saveState()
	f4_arg0:registerEventHandler("button_prompt_back", CoD.ChangeMap.CategoryBack)
	f4_arg0.mapButtonList:removeAllChildren()
	CoD.ButtonList.DisableInput(f4_arg0.mapButtonList)
	CoD.ButtonList.EnableInput(f4_arg0.categoryButtonList)
	f4_arg0.categoryContainer:animateToState("default")
	f4_arg0.categoryButtonList:restoreState()
	f4_arg0.infoContainer.icon:setLeftRight(false, false, -f4_arg0.infoContainer.iconHeight / 2, f4_arg0.infoContainer.iconHeight / 2)
	f4_arg0.infoContainer.icon:setTopBottom(true, false, 0, f4_arg0.infoContainer.iconHeight)
	if CoD.useMouse then
		f4_arg0.mapButtonList.m_backReady = nil
	end
end

CoD.ChangeMap.Button_GainFocus = function (f5_arg0, f5_arg1)
	f5_arg0.infoContainer.owner = f5_arg1.owner
	f5_arg0:updateInfo(f5_arg1.itemInfo)
end

CoD.ChangeMap.Button_LoseFocus = function (f6_arg0, f6_arg1)
	if f6_arg0.infoContainer.owner == f6_arg1.owner then
		f6_arg0:updateInfo(nil)
	end
end

CoD.ChangeMap.UpdateInfo = function (f7_arg0, f7_arg1)
	local f7_local0 = ""
	local f7_local1 = ""
	local f7_local2 = nil
	if f7_arg1 ~= nil then
		f7_local0 = f7_arg1.name
		f7_local1 = f7_arg1.description
		f7_local2 = f7_arg1.iconMaterial
	end
	f7_arg0.infoContainer.titleElement:setText(f7_local0)
	f7_arg0.infoContainer.description:setText(f7_local1)
	if f7_local2 ~= nil then
		f7_arg0.infoContainer.icon:registerAnimationState("icon", {
			material = f7_local2,
			alpha = 1
		})
		f7_arg0.infoContainer.icon:animateToState("icon")
	else
		f7_arg0.infoContainer.icon:animateToState("default")
	end
end

CoD.ChangeMap.CreateCategoryItemInfo = function ()
	local f8_local0 = {}
	local f8_local1 = CoD.ChangeMap.MaxCategories
	for f8_local2 = 1, f8_local1, 1 do
		local f8_local5 = {
			name = Engine.Localize("MPUI_MAP_CATEGORY_" .. CoD.ChangeMap.CategoryNames[f8_local2] .. "_CAPS")
		}
		if CoD.ChangeMap.CategoryNames[f8_local2] == "dlc" then
			f8_local5.locked = false
		else
			f8_local5.locked = false
		end
		f8_local5.mapPackTypeIndex = CoD.ChangeMap.CategoryIndex[f8_local2]
		f8_local5.description = Engine.Localize("MPUI_MAP_CATEGORY_" .. CoD.ChangeMap.CategoryNames[f8_local2] .. "_DESC")
		f8_local5.iconMaterial = RegisterMaterial(CoD.ChangeMap.CategoryIconNames[f8_local2])
		if CoD.ChangeMap.CategoryNames[f8_local2] == "dlc" then
			if CoD.ChangeMap.ISAnyDLCMapAvailable() then
				table.insert(f8_local0, f8_local5)
			end
		end
		table.insert(f8_local0, f8_local5)
	end
	return f8_local0
end

CoD.ChangeMap.AddCategoryButtons = function (f9_arg0)
	local f9_local0 = CoD.ChangeMap.CreateCategoryItemInfo()
	local f9_local1 = UIExpression.TableLookup(nil, CoD.mapsTable, 0, UIExpression.DvarString(nil, "ui_mapname"), 11)
	local f9_local2 = 1
	f9_arg0.categoryButtons = {}
	for f9_local6, f9_local7 in ipairs(f9_local0) do
		local f9_local8 = CoD.CategoryButton.new({
			leftAnchor = true,
			rightAnchor = true,
			left = 0,
			right = 0,
			topAnchor = true,
			bottomAnchor = false,
			top = 0,
			bottom = CoD.CoD9Button.Height
		}, "category_button_action", "category_button_gain_focus", "category_button_lose_focus", f9_local7)
		f9_local8:setLabel(f9_local7.name)
		f9_arg0.categoryButtonList:addElement(f9_local8)
		table.insert(f9_arg0.categoryButtons, f9_local8)
		if f9_local7.locked == true then
			f9_local8:disable()
		end
		if f9_local7.mapPackTypeIndex == f9_local1 then
			f9_local2 = f9_local6
		end
	end
	if #f9_arg0.categoryButtons > 0 then
		if CoD.useController and not f9_arg0.categoryButtonList:restoreState() then
			f9_arg0.categoryButtons[f9_local2]:processEvent({
				name = "gain_focus"
			})
		end
		f9_arg0:registerEventHandler("button_prompt_back", CoD.ChangeMap.CategoryBack)
	end
end

CoD.ChangeMap.CategoryButtonAction = function (f10_arg0, f10_arg1)
	Engine.PlaySound("cac_slide_equip_item")
	f10_arg0.categoryButtonList:saveState()
	CoD.ButtonList.DisableInput(f10_arg0.categoryButtonList)
	CoD.ButtonList.EnableInput(f10_arg0.mapButtonList)
	f10_arg0.categoryContainer:animateToState("disabled")
	f10_arg0:addMapButtons(f10_arg1.controller, f10_arg1.itemInfo.mapPackTypeIndex)
	local f10_local0 = 384
	local f10_local1 = 192
	local f10_local2 = (f10_arg0.infoContainer.iconHeight - f10_local1) / 2
	f10_arg0.infoContainer.icon:setLeftRight(false, false, -f10_local0 / 2, f10_local0 / 2)
	f10_arg0.infoContainer.icon:setTopBottom(true, false, f10_local2, f10_local2 + f10_local1)
end

CoD.ChangeMap.CreateMapInfo = function (f11_arg0, f11_arg1)
	return {
		name = Engine.Localize(f11_arg1.name),
		loadName = f11_arg1.loadName,
		size = Engine.Localize("MPUI_MAPSIZE_" .. UIExpression.TableLookup(f11_arg0, CoD.mapsTable, 0, f11_arg1.loadName, 8)),
		description = Engine.Localize(UIExpression.TableLookup(f11_arg0, CoD.mapsTable, 0, f11_arg1.loadName, 6)),
		iconMaterial = RegisterMaterial("menu_" .. f11_arg1.loadName .. "_map_select_final")
	}
end

CoD.ChangeMap.ISAnyDLCMapAvailable = function ()
	for f12_local3, f12_local4 in pairs(Engine.GetMaps()) do
		if f12_local4.mapPackTypeIndex ~= CoD.CONTENT_ORIGINAL_MAP_INDEX then
			return true
		end
	end
	return false
end

CoD.ChangeMap.AddMapButtons = function (f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = UIExpression.DvarString(nil, "ui_mapname")
	local f13_local1 = 1
	local f13_local2 = 0
	f13_arg0.mapButtons = {}
	local f13_local3 = Engine.GetMaps()
	local f13_local4 = Engine.SessionModeIsMode(CoD.SESSIONMODE_OFFLINE)
	for f13_local10, f13_local11 in pairs(f13_local3) do
		if (f13_local4 == false or UIExpression.TableLookup(nil, CoD.mapsTable, 0, f13_local11.loadName, 10) ~= "NO") and (f13_local11.mapPackTypeIndex == f13_arg2 or f13_arg2 == nil and f13_local11.mapPackTypeIndex > CoD.CONTENT_ORIGINAL_MAP_INDEX) then
			local f13_local8 = CoD.ChangeMap.CreateMapInfo(f13_arg1, f13_local11)
			local f13_local9 = CoD.PlaylistButton.new({
				leftAnchor = true,
				rightAnchor = true,
				left = 0,
				right = 0,
				topAnchor = true,
				bottomAnchor = false,
				top = 0,
				bottom = CoD.CoD9Button.Height
			}, "map_button_action", "map_button_gain_focus", "map_button_lose_focus", f13_local8, f13_local10)
			f13_local9:setLabel(f13_local8.name)
			f13_arg0.mapButtonList:addElement(f13_local9)
			table.insert(f13_arg0.mapButtons, f13_local9)
			f13_local2 = f13_local2 + 1
			if f13_local11.loadName == f13_local0 then
				f13_local1 = f13_local2
			end
		end
	end
	if #f13_arg0.mapButtons > 0 then
		if CoD.useController and not f13_arg0.mapButtonList:restoreState() then
			f13_arg0.mapButtons[f13_local1]:processEvent({
				name = "gain_focus"
			})
		end
		f13_arg0:registerEventHandler("button_prompt_back", CoD.ChangeMap.MapBack)
	end
end

