CoD.DemoPopup = {}
local f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg0:goBack(f1_arg1.controller)
	if UIExpression.IsInGame() == 1 and f1_arg0.occludedMenu == nil then
		Engine.LockInput(f1_arg1.controller, false)
		Engine.SetUIActive(f1_arg1.controller, false)
	end
end

LUI.createMenu.Demo_Error = function (f2_arg0)
	local f2_local0 = CoD.Popup.SetupPopup("Demo_Error", f2_arg0)
	local f2_local1 = CoD.ButtonPrompt.new
	local f2_local2 = "primary"
	local f2_local3 = Engine.Localize("MENU_ACCEPT")
	local f2_local4 = f2_local0
	local f2_local5 = "action_ok"
	local f2_local6, f2_local7 = false
	f2_local0:addLeftButtonPrompt(f2_local1(f2_local2, f2_local3, f2_local4, f2_local5, f2_local6, f2_local7, false))
	f2_local0:registerEventHandler("action_ok", f0_local0)
	return f2_local0
end

local f0_local1 = function (f3_arg0, f3_arg1)
	f3_arg0:goBack(f3_arg1.controller)
end

local f0_local2 = function (f4_arg0, f4_arg1)
	Engine.Exec(f4_arg1.controller, "demo_savesegment 0")
	f0_local1(f4_arg0, f4_arg1)
end

local f0_local3 = function (f5_arg0, f5_arg1)
	Engine.Exec(f5_arg1.controller, "demo_keyboard segmentName")
end

local f0_local4 = function (f6_arg0, f6_arg1)
	Engine.Exec(f6_arg1.controller, "demo_previewsegment")
	f0_local1(f6_arg0, f6_arg1)
end

local f0_local5 = function (f7_arg0, f7_arg1)
	Engine.Exec(f7_arg1.controller, "demo_savesegment 1")
	f0_local1(f7_arg0, f7_arg1)
end

LUI.createMenu.Demo_Save_Popup = function (f8_arg0)
	local f8_local0 = CoD.Menu.NewSmallPopup("Demo_Save_Popup")
	f8_local0:setOwner(f8_arg0)
	f8_local0:addSelectButton()
	f8_local0:registerEventHandler("demo_close_save_popup", f0_local1)
	local f8_local1 = 5
	local f8_local2 = LUI.UIText.new()
	f8_local2:setLeftRight(true, true, 0, 0)
	f8_local2:setTopBottom(true, false, f8_local1, f8_local1 + CoD.textSize.Big)
	f8_local2:setFont(CoD.fonts.Big)
	f8_local2:setAlignment(LUI.Alignment.Left)
	f8_local2:setText(Engine.Localize("MENU_KEEP_SEGMENT"))
	f8_local0:addElement(f8_local2)
	local f8_local3 = CoD.ButtonList.new({})
	f8_local3:setLeftRight(true, true, 0, 0)
	f8_local3:setTopBottom(false, true, -CoD.ButtonPrompt.Height - CoD.CoD9Button.Height * 5 + 10, 0)
	f8_local0:addElement(f8_local3)
	local f8_local4 = f8_local3:addButton(Engine.Localize("MENU_AUTONAME_SEGMENT"))
	f8_local4:setActionEventName("autoname_and_save_segment")
	f8_local4:processEvent({
		name = "gain_focus"
	})
	f8_local0:registerEventHandler("autoname_and_save_segment", f0_local2)
	local f8_local5 = f8_local3:addButton(Engine.Localize("MENU_NAME_SEGMENT"))
	f8_local5:setActionEventName("name_and_save_segment")
	f8_local0:registerEventHandler("name_and_save_segment", f0_local3)
	local f8_local6 = f8_local3:addButton(Engine.Localize("MENU_PREVIEW_SEGMENT"))
	f8_local6:setActionEventName("preview_segment")
	f8_local0:registerEventHandler("preview_segment", f0_local4)
	local f8_local7 = f8_local3:addButton(Engine.Localize("MENU_DISCARD_SEGMENT"))
	f8_local7:setActionEventName("discard_segment")
	f8_local0:registerEventHandler("discard_segment", f0_local5)
	return f8_local0
end

CoD.DemoPopup.OpenSavePopup = function (f9_arg0, f9_arg1)
	if f9_arg1.menuName == "demo_save_clip" then
		f9_arg0:openPopup("Demo_Save_Popup", f9_arg1.controller)
	else
		CoD.perController[f9_arg1.controller].fileshareSaveCategory = "screenshot"
		CoD.perController[f9_arg1.controller].fileshareSaveIsCopy = false
		CoD.perController[f9_arg1.controller].fileshareSaveIsPooled = false
		f9_arg0:openPopup("FileshareSave", f9_arg1.controller)
	end
end

LUI.createMenu.Demo_Wait = function (f10_arg0, f10_arg1)
	local f10_local0 = CoD.Menu.NewSmallPopup("Demo_Wait")
	f10_local0:setOwner(f10_arg0)
	f10_local0:addBackButton()
	local f10_local1 = 5
	local f10_local2 = LUI.UIText.new()
	f10_local2:setLeftRight(true, true, 0, 0)
	f10_local2:setTopBottom(true, false, f10_local1, f10_local1 + CoD.textSize.Condensed)
	f10_local2:setFont(CoD.fonts.Condensed)
	f10_local2:setAlignment(LUI.Alignment.Left)
	f10_local2:setText(Engine.Localize("MENU_PLEASEWAIT"))
	f10_local0:addElement(f10_local2)
	return f10_local0
end

CoD.DOLLYCAM_SPEEDMODE_MANUAL = 0
CoD.DOLLYCAM_SPEEDMODE_LINEAR = 1
CoD.DOLLYCAM_SPEEDMODE_FIXED = 2
local f0_local6 = function (f11_arg0, f11_arg1)
	f11_arg0:goBack(f11_arg1.controller)
	Engine.LockInput(f11_arg1.controller, false)
	Engine.SetUIActive(f11_arg1.controller, false)
end

local f0_local7 = function (f12_arg0, f12_arg1)
	Engine.ExecNow(f12_arg1.controller, "demo_removedollycammarker -1")
	f12_arg0:setPreviousMenu(nil)
	f0_local6(f12_arg0, f12_arg1)
end

LUI.createMenu.RemoveAllMarkers = function (f13_arg0)
	local f13_local0 = CoD.Popup.SetupPopupChoice("RemoveAllMarkers", f13_arg0)
	f13_local0.title:setText(Engine.Localize("MENU_WARNING"))
	f13_local0.msg:setText(Engine.Localize("MENU_DEMO_DOLLYCAM_MARKER_REMOVE_ALL_CONFIRMATION"))
	f13_local0:addBackButton()
	f13_local0.choiceA:setLabel(Engine.Localize("MENU_YES"))
	f13_local0.choiceB:setLabel(Engine.Localize("MENU_NO"))
	f13_local0.choiceA:setActionEventName("remove_all_markers_accept")
	f13_local0.choiceB:processEvent({
		name = "gain_focus"
	})
	f13_local0:registerEventHandler("remove_all_markers_accept", f0_local7)
	return f13_local0
end

local f0_local8 = function (f14_arg0, f14_arg1)
	Engine.Exec(f14_arg1.controller, "demo_repositiondollycammarker " .. UIExpression.GetHighlightedCameraMarker())
	f0_local6(f14_arg0, f14_arg1)
end

local f0_local9 = function (f15_arg0, f15_arg1)
	Engine.Exec(f15_arg1.controller, "demo_removedollycammarker " .. UIExpression.GetHighlightedCameraMarker())
	f0_local6(f15_arg0, f15_arg1)
end

local f0_local10 = function (f16_arg0, f16_arg1)
	f16_arg0:openMenu("RemoveAllMarkers", f16_arg1.controller)
	f16_arg0:close()
end

local f0_local11 = function (f17_arg0, f17_arg1)
	local f17_local0 = UIExpression.GetHighlightedCameraMarker() + 1
	local f17_local1 = f17_arg0.speedSettingMode:getCurrentValue()
	f17_arg0.messageText:setText(UIExpression.ToUpper(nil, Engine.Localize("MENU_DEMO_DOLLYCAM_MARKER_NUMBER", f17_local0)))
	f17_arg0.speedSettingMode:refreshChoice()
	if f17_arg0.speedSettingValue ~= nil then
		if f17_local1 ~= "0" then
			if f17_arg0.speedSettingValueValid == false then
				f17_arg0.speedSettingValueSpacer:close()
				f17_arg0.speedSettingValue:addElementAfter(f17_arg0.speedSettingMode)
				LUI.UIVerticalList.UpdateNavigation(f17_arg0.buttonList)
				f17_arg0.speedSettingValueValid = true
			end
			f17_arg0.speedSettingValue.label:setText(Engine.Localize("MENU_DEMO_DOLLYCAM_SPEED_SETTING_SPEED", string.format("%.1f", UIExpression.DvarFloat(nil, "demo_dollycamMarkerTimeScaleValue"))))
		elseif f17_arg0.speedSettingValueValid == true then
			f17_arg0.speedSettingValue:processEvent({
				name = "lose_focus"
			})
			f17_arg0.speedSettingValue:close()
			f17_arg0.speedSettingValueValid = false
			f17_arg0.speedSettingValueSpacer:addElementAfter(f17_arg0.speedSettingMode)
			f17_arg0.speedSettingMode:processEvent({
				name = "gain_focus"
			})
			LUI.UIVerticalList.UpdateNavigation(f17_arg0.buttonList)
		end
	end
end

local f0_local12 = function (f18_arg0, f18_arg1)
	Engine.SetDvar(f18_arg0.m_dvarName, f18_arg1)
	local f18_local0 = f18_arg0:getParent()
	if f18_local0 ~= nil then
		local f18_local1 = f18_local0:getParent()
		if f18_local1 ~= nil then
			f0_local11(f18_local1, nil)
		end
	end
end

local f0_local13 = function (f19_arg0)
	Engine.SetDvar(f19_arg0.parentSelectorButton.m_dvarName, f19_arg0.value)
	local f19_local0 = f19_arg0.parentSelectorButton:getParent()
	if f19_local0 ~= nil then
		local f19_local1 = f19_local0:getParent()
		if f19_local1 ~= nil and f19_local1.creatingSpeedSettingModeButton ~= true then
			f19_local1:processEvent({
				name = "demo_dollycam_marker_options_update",
				controller = f19_local1.controller
			})
		end
	end
end

local f0_local14 = function (f20_arg0, f20_arg1)
	local f20_local0 = UIExpression.GetHighlightedCameraMarker()
	Engine.Exec(f20_arg1.controller, "demo_updatedollycammarkerparameters " .. f20_local0)
	Engine.Exec(f20_arg1.controller, "demo_switchdollycammarker " .. f20_local0 .. " 0")
end

local f0_local15 = function (f21_arg0, f21_arg1)
	local f21_local0 = UIExpression.GetHighlightedCameraMarker()
	Engine.Exec(f21_arg1.controller, "demo_updatedollycammarkerparameters " .. f21_local0)
	Engine.Exec(f21_arg1.controller, "demo_switchdollycammarker " .. f21_local0 .. " 1")
end

local f0_local16 = function (f22_arg0, f22_arg1)
	Engine.Exec(f22_arg1.controller, "demo_updatedollycammarkerparameters " .. UIExpression.GetHighlightedCameraMarker())
	f0_local6(f22_arg0, f22_arg1)
end

LUI.createMenu.Demo_DollyCam_Marker_Options = function (f23_arg0)
	local f23_local0 = CoD.Menu.NewSmallPopup("Demo_DollyCam_Marker_Options")
	f23_local0.controller = f23_arg0
	f23_local0:setOwner(f23_arg0)
	f23_local0:addSelectButton()
	f23_local0:addBackButton(Engine.Localize("MPUI_DONE"))
	f23_local0:registerEventHandler("button_prompt_back", f0_local16)
	f23_local0:registerEventHandler("demo_dollycam_marker_options_update", f0_local11)
	local f23_local1 = 0
	local f23_local2 = CoD.textSize.Condensed
	local f23_local3 = 240
	f23_local0.leftTopButtonBar = LUI.UIHorizontalList.new({
		left = f23_local1,
		top = -30,
		right = 0,
		bottom = 60,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		font = CoD.fonts.Condensed,
		alignment = LUI.Alignment.Left
	})
	f23_local0:addElement(f23_local0.leftTopButtonBar)
	f23_local0.leftTopButtonBar:addElement(CoD.ButtonPrompt.new("shoulderl", "", f23_local0, "switch_dollycam_marker_previous"))
	f23_local0:registerEventHandler("switch_dollycam_marker_previous", f0_local14)
	f23_local0.rightTopButtonBar = LUI.UIHorizontalList.new({
		left = 0,
		top = -30,
		right = -f23_local1,
		bottom = 60,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		font = CoD.fonts.Condensed,
		alignment = LUI.Alignment.Right
	})
	f23_local0:addElement(f23_local0.rightTopButtonBar)
	f23_local0.rightTopButtonBar:addElement(CoD.ButtonPrompt.new("shoulderr", "", f23_local0, "switch_dollycam_marker_next"))
	f23_local0:registerEventHandler("switch_dollycam_marker_next", f0_local15)
	f23_local0.messageText = LUI.UIText.new({
		left = 0,
		top = f23_local1,
		right = 0,
		bottom = f23_local1 + f23_local2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		font = CoD.fonts.Big,
		alignment = LUI.Alignment.Center
	})
	f23_local0.messageText:setText(UIExpression.ToUpper(nil, Engine.Localize("MENU_DEMO_DOLLYCAM_MARKER_NUMBER", UIExpression.GetHighlightedCameraMarker() + 1)))
	f23_local0:addElement(f23_local0.messageText)
	f23_local0.buttonList = CoD.ButtonList.new({
		left = f23_local1,
		top = f23_local1 + f23_local2 + 10,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	f23_local0:addElement(f23_local0.buttonList)
	f23_local0.creatingSpeedSettingModeButton = true
	f23_local0.speedSettingMode = f23_local0.buttonList:addDvarLeftRightSelector(f23_arg0, Engine.Localize("MENU_DEMO_DOLLYCAM_SPEED_SETTING_MODE"), "demo_dollycamMarkerTimeScaleMode", nil, f23_local3)
	local f23_local4 = f23_local0.speedSettingMode
	local f23_local5 = {}
	local f23_local6 = Engine.Localize("MENU_DEMO_DOLLYCAM_SPEED_SETTING_MANUAL")
	local f23_local7 = Engine.Localize("MENU_DEMO_DOLLYCAM_SPEED_SETTING_LINEAR")
	local f23_local8 = Engine.Localize("MENU_DEMO_DOLLYCAM_SPEED_SETTING_FIXED")
	f23_local4.strings = f23_local6
	f23_local0.speedSettingMode.values = {
		CoD.DOLLYCAM_SPEEDMODE_MANUAL,
		CoD.DOLLYCAM_SPEEDMODE_LINEAR,
		CoD.DOLLYCAM_SPEEDMODE_FIXED
	}
	for f23_local4 = 1, #f23_local0.speedSettingMode.strings, 1 do
		f23_local0.speedSettingMode:addChoice(f23_arg0, Engine.Localize(f23_local0.speedSettingMode.strings[f23_local4]), f23_local0.speedSettingMode.values[f23_local4], nil, f0_local13)
	end
	f23_local0.creatingSpeedSettingModeButton = false
	f23_local0.speedSettingValue = f23_local0.buttonList:addDvarLeftRightSlider(f23_arg0, Engine.Localize("MENU_DEMO_DOLLYCAM_SPEED_SETTING_SPEED", string.format("%.1f", UIExpression.DvarFloat(nil, "demo_dollycamMarkerTimeScaleValue"))), "demo_dollycamMarkerTimeScaleValue", 0.1, Dvar.demo_maxTimeScale:get(), nil, f23_local3)
	f23_local0.speedSettingValue:setSliderCallback(f0_local12)
	f23_local0.speedSettingValueValid = true
	f23_local0.speedSettingValueSpacer = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = CoD.CoD9Button.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f23_local0.repositionCamera = f23_local0.buttonList:addButton(Engine.Localize("MENU_DEMO_DOLLYCAM_MARKER_REPOSITION"))
	f23_local0.repositionCamera:setActionEventName("reposition_camera")
	f23_local0:registerEventHandler("reposition_camera", f0_local8)
	f23_local0.removeMarker = f23_local0.buttonList:addButton(Engine.Localize("MENU_DEMO_DOLLYCAM_MARKER_REMOVE"))
	f23_local0.removeMarker:setActionEventName("remove_marker")
	f23_local0:registerEventHandler("remove_marker", f0_local9)
	f23_local0.buttonList:addSpacer(CoD.CoD9Button.Height / 2)
	f23_local0.removeAllMarkers = f23_local0.buttonList:addButton(Engine.Localize("MENU_DEMO_DOLLYCAM_MARKER_REMOVE_ALL"))
	f23_local0.removeAllMarkers:setActionEventName("remove_all_markers")
	f23_local0:registerEventHandler("remove_all_markers", f0_local10)
	f23_local0.buttonList:processEvent({
		name = "gain_focus"
	})
	f23_local0:processEvent({
		name = "demo_dollycam_marker_options_update",
		controller = f23_arg0
	})
	return f23_local0
end

CoD.DemoPopup.OpenDollyCamMarkerOptionsPopup = function (f24_arg0, f24_arg1)
	f24_arg0:openPopup("Demo_DollyCam_Marker_Options", f24_arg1.controller)
end

