require("T6.Drc.DrcPanelButton")
require("T6.Drc.DrcControlsPanel")
if CoD.isMultiplayer and not CoD.isZombie then
	require("T6.Drc.DrcChangeClass")
	require("T6.Drc.DrcRewardSelection")
	require("T6.Drc.DrcCompassPanel")
elseif CoD.isZombie then
	require("T6.Drc.DrcZMMainPanel")
elseif CoD.isSinglePlayer then
	require("T6.Drc.DrcObjectivesPanel")
end
CoD.DrcView = {}
CoD.DrcView.ViewWidth = 1280
CoD.DrcView.ViewHeight = 720
CoD.DrcView.SnapAnimationDuration = 100
CoD.DrcView.DragThreshold = 20
CoD.DrcView.ScrollFriction = 0.05
CoD.DrcView.DisableScrollEvent = {
	name = "disable_scrolling"
}
CoD.DrcView.LeftMouseDownEvent = {
	name = "leftmousedown",
	x = 0,
	y = 0,
	inside = true
}
CoD.DrcView.LeftMouseUpEvent = {
	name = "leftmouseup",
	x = 0,
	y = 0,
	inside = true
}
if CoD.isWIIU then
	CoD.DrcView.PanelCollapseExpandSpeed = 150
else
	CoD.DrcView.PanelCollapseExpandSpeed = 333
end
CoD.DrcView.ControllerIconMaterials = {
	remote = "wiiu_controllerselect_wiiremote",
	classic = "wiiu_controllerselect_ccp",
	drc = "wiiu_controllerselect_drc",
	uc = "wiiu_controllerselect_uc"
}
local f0_local0 = function (f1_arg0, f1_arg1)
	local f1_local0 = 0
	local f1_local1 = f1_arg0:getFirstChild()
	while f1_local1 ~= nil do
		f1_local1:setPriority(f1_local0)
		f1_local1 = f1_local1:getNextSibling()
		f1_local0 = f1_local0 + 10
	end
end

local f0_local1 = function (f2_arg0, f2_arg1)
	f2_arg0.width = f2_arg0.width + f2_arg1
	local f2_local0 = CoD.DrcView.ViewWidth / 2
	f2_arg0.snapScrollMin = -f2_arg0.width + f2_local0
	f2_arg0.snapScrollMax = -f2_local0
	f2_arg0.limitScrollMin = f2_arg0.snapScrollMin - f2_local0 / 5
	f2_arg0.limitScrollMax = f2_arg0.snapScrollMax + f2_local0 / 5
end

local f0_local2 = function (f3_arg0)
	local f3_local0 = f3_arg0.horizontalList
	if f3_local0.width <= CoD.DrcView.ViewWidth then
		f3_local0.left = -CoD.DrcView.ViewWidth / 2
		f3_local0:beginAnimation("snap", CoD.DrcView.SnapAnimationDuration, false, true)
		f3_local0:setLeftRight(false, false, f3_local0.left, f3_local0.left + f3_local0.width)
		f3_local0:setTopBottom(true, true, 0, 0)
		f3_arg0.snapAnim = true
		local f3_local1 = f3_local0:getFirstChild()
		while f3_local1 do
			f3_local1.m_inputDisabled = false
			f3_local1 = f3_local1:getNextSibling()
		end
	end
end

local f0_local3 = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.panelToCloseMsg
	local f4_local1 = f4_arg0.nextPanelToCloseMsg
	if f4_local0 and f4_local0 ~= f4_local1 then
		f4_arg0:processEvent({
			name = f4_local0
		})
	end
	f4_arg0.panelToCloseMsg = f4_local1
	f4_arg0.nextPanelToCloseMsg = nil
end

local f0_local4 = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.buttonPanel.buttons[f5_arg1.buttonName]
	if f5_local0 then
		f5_local0.button:processEvent(CoD.DrcView.LeftMouseDownEvent)
		f5_local0.button:processEvent(CoD.DrcView.LeftMouseUpEvent)
	end
end

local f0_local5 = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0.panel.horizontalList
	local f6_local1 = f6_local0.view
	f6_local0:removeElement(f6_local1.changeClassPanel)
	f0_local1(f6_local0, -f6_local1.changeClassPanel.width)
	f6_local0:beginAnimation("collapse")
	f6_local0:setLeftRight(false, false, f6_local0.left, f6_local0.left + f6_local0.width)
	f6_local0:setTopBottom(true, true, 0, 0)
	f6_local1.changeClassPanel.open = false
	LUI.roots.UIRootDrc.drcChangeClassOpen = false
	f0_local2(f6_local1)
end

local f0_local6 = function (f7_arg0)
	local f7_local0 = f7_arg0.panel.horizontalList
	local f7_local1 = f7_local0.view
	local f7_local2 = f7_local1.changeClassPanel
	Engine.PlaySound(f7_local1.slideSFX)
	if f7_local2 and f7_local2.open then
		f7_local1:processEvent({
			name = "animatedClose_changeclass"
		})
		return 
	end
	f0_local0(f7_local0)
	if not f7_local2 then
		f7_local2 = CoD.DrcChangeClass.new(f7_local1.controller)
	end
	f7_local2:setPriority(1)
	f7_local2:expand()
	f7_local2.open = true
	LUI.roots.UIRootDrc.drcChangeClassOpen = true
	f7_local1.changeClassPanel = f7_local2
	f7_local0:addElement(f7_local2)
	f0_local1(f7_local0, f7_local2.width)
	f7_local0:beginAnimation("expand", CoD.DrcView.PanelCollapseExpandSpeed)
	f7_local0:setLeftRight(false, false, f7_local0.left, f7_local0.left + f7_local0.width)
	f7_local0:setTopBottom(true, true, 0, 0)
	f7_local0.nextPanelToCloseMsg = "force_close_changeclass"
end

local f0_local7 = function (f8_arg0)
	f0_local3(f8_arg0.panel.horizontalList)
end

local f0_local8 = 600
local f0_local9 = {
	{
		name = "pulse_low_button_alert",
		anim = {
			alpha = 0.3
		}
	},
	{
		name = "pulse_high_button_alert",
		anim = {
			alpha = 1
		}
	}
}
local f0_local10 = function (f9_arg0)
	if f9_arg0.pulsing then
		f9_arg0:animateToState(f0_local9[1 + f9_arg0.pulseAnimationFrame].name, f0_local8)
		f9_arg0.pulseAnimationFrame = (f9_arg0.pulseAnimationFrame + 1) % 2
	end
end

local f0_local11 = function (f10_arg0)
	local f10_local0 = f10_arg0.panel.friendsButton
	if f10_local0 and not f10_local0.alertImage.pulsing then
		f10_local0.alertImage:setAlpha(1)
		f10_local0.alertImage:animateToState(f0_local9[1 + f10_local0.alertImage.pulseAnimationFrame].name, f0_local8)
		f10_local0.alertImage.pulseAnimationFrame = (f10_local0.alertImage.pulseAnimationFrame + 1) % 2
		f10_local0.alertImage.pulsing = true
	end
end

local f0_local12 = function (f11_arg0)
	local f11_local0 = f11_arg0.panel.horizontalList.view.controller
	local f11_local1 = "UIRoot" .. f11_local0
	local f11_local2 = f11_arg0.panel.friendsButton
	f11_local2.alertImage.pulsing = false
	f11_local2.alertImage:completeAnimation()
	f11_local2.alertImage:setAlpha(0)
	local f11_local3 = LUI.roots["UIRoot" .. f11_local0]
	local f11_local4 = f11_local3.friendsMenu
	if f11_local4 then
		f11_local3.friendsMenu = nil
		CoD.FriendsList.CloseMenu(f11_local4, {
			controller = f11_local0,
			fromDrc = true
		})
	else
		local f11_local5 = f11_local3.ingameClassMenu
		if f11_local5 and f11_local5:getParent() then
			f11_local3.ingameClassMenu = nil
			CoD.Class.ButtonPromptFriendsMenu(f11_local5, {
				controller = f11_local0
			})
		else
			f11_local3:processEvent({
				name = "drc_toggle_friends",
				controller = f11_local0
			})
		end
	end
end

local f0_local13 = function (f12_arg0)
	local f12_local0 = LUI.UIImage.new()
	f12_local0:setLeftRight(true, true, 0, 0)
	f12_local0:setTopBottom(true, true, 0, 0)
	f12_local0:setAlpha(0)
	f12_local0.pulsing = false
	f12_local0.pulseAnimationFrame = 0
	f12_local0:setImage(RegisterMaterial(CoD.DrcPanelButton.Highlightmaterial))
	f12_local0:registerAnimationState(f0_local9[1].name, f0_local9[1].anim)
	f12_local0:registerAnimationState(f0_local9[2].name, f0_local9[2].anim)
	f12_local0:registerEventHandler("transition_complete_" .. f0_local9[1].name, f0_local10)
	f12_local0:registerEventHandler("transition_complete_" .. f0_local9[2].name, f0_local10)
	f12_arg0.alertImage = f12_local0
	f12_arg0:addElement(f12_local0)
end

local f0_local14 = function (f13_arg0)
	local f13_local0 = f13_arg0.panel.horizontalList
	local f13_local1 = f13_local0.view
	if f13_local1.controlsPanel and f13_local1.controlsPanel.closing then
		f13_local0:removeElement(f13_local1.controlsPanel)
		f0_local1(f13_local0, -f13_local1.controlsPanel.width)
		f13_local0:beginAnimation("collapse", CoD.DrcView.PanelCollapseExpandSpeed)
		f13_local0:setLeftRight(false, false, f13_local0.left, f13_local0.left + f13_local0.width)
		f13_local0:setTopBottom(true, true, 0, 0)
		f13_local1.controlsPanel:close()
		f13_local1.controlsPanel = nil
		f0_local2(f13_local1)
	end
end

local f0_local15 = function (f14_arg0)
	local f14_local0 = f14_arg0.panel.horizontalList
	local f14_local1 = f14_local0.view
	if f14_local1.controlsPanel then
		if not f14_local1.controlsPanel.closing then
			f14_local1.controlsPanel:processEvent({
				name = "animated_close"
			})
		end
	else
		f0_local0(f14_local0)
		local f14_local2 = CoD.DrcControlsPanel.new(f14_local1, f14_local1.controller)
		f14_local2:setPriority(1)
		f14_local1.controlsPanel = f14_local2
		f14_local0:addElement(f14_local2)
		f0_local1(f14_local0, f14_local2.width)
		f14_local0:beginAnimation("expand", CoD.DrcView.PanelCollapseExpandSpeed)
		f14_local0:setLeftRight(false, false, f14_local0.left, f14_local0.left + f14_local0.width)
		f14_local0:setTopBottom(true, true, 0, 0)
		f14_local0.nextPanelToCloseMsg = "force_close_controls"
	end
	Engine.PlaySound(f14_local1.slideSFX)
end

local f0_local16 = function (f15_arg0, f15_arg1, f15_arg2, f15_arg3, f15_arg4)
	local f15_local0 = {
		leftAnchor = true,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = false,
		left = 0,
		right = 256,
		top = 0,
		bottom = 256
	}
	if not f15_arg3 then
		f15_arg3 = LUI.UITouchpadButton
	end
	local f15_local1 = CoD.DrcPanelButton.new(f15_local0, f15_arg2, f15_arg3, f15_arg4)
	f15_local1.debugName = f15_arg1
	f15_local1:setLabel(f15_arg1)
	f15_local1.label.downText = Engine.Localize("DRC_CLOSE")
	f15_local1.label.downColor = CoD.DrcOptionElement.HighlightColor
	f15_local1.label.upColor = CoD.DrcOptionElement.DefaultColor
	f15_arg0:addElement(f15_local1)
	local f15_local2, f15_local3, f15_local4, f15_local5 = GetTextDimensions(f15_arg1, CoD.fonts.Condensed, CoD.textSize.Condensed)
	local f15_local6 = f15_local5 - f15_local3
	f15_local1.label:registerAnimationState("focused", {
		leftAnchor = false,
		rightAnchor = false,
		topAnchor = false,
		bottomAnchor = false,
		left = -f15_local4 / 2,
		right = f15_local4 / 2,
		top = f15_local6 / 2 - 5,
		bottom = -f15_local6 / 2 - 5
	})
	if f15_arg0.gainFocusSFX ~= nil then
		f15_local1:setGainFocusSFX(f15_arg0.gainFocusSFX)
	end
	if f15_arg0.actionSFX ~= nil then
		f15_local1:setActionSFX(f15_arg0.actionSFX)
	end
	return f15_local1
end

local f0_local17 = function (f16_arg0)
	local verticalList = LUI.UIVerticalList.new({
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		spacing = -100
	})
	verticalList.debugName = "DrcView.verticalList.buttonPanel.verticalList"
	verticalList.width = 250
	verticalList.controller = f16_arg0
	verticalList:registerEventHandler("open_changeclass", f0_local6)
	verticalList:registerEventHandler("close_changeclass", f0_local5)
	verticalList:registerEventHandler("open_radar", f0_local7)
	verticalList:registerEventHandler("show_game_on_drc", function (f22_arg0)
		if not f22_arg0.showGameOnDrcTimer then
			f22_arg0.showGameOnDrcTimer = LUI.UITimer.new(250, {
				name = "show_game_on_drc_now"
			}, true, f22_arg0)
			f22_arg0:addElement(f22_arg0.showGameOnDrcTimer)
		end
	end)
	verticalList:registerEventHandler("show_game_on_drc_now", function (f23_arg0)
		f23_arg0:dispatchEventToParent({
			name = "open_drc_popup",
			popupName = "DrcOutputDevicePopup",
			controller = f23_arg0.controller
		})
		f23_arg0.showGameOnDrcTimer = nil
	end)
	verticalList:registerEventHandler("toggle_controls", f0_local15)
	verticalList:registerEventHandler("close_controls", f0_local14)
	local f16_local1 = "DrcView.Panel"
	local f16_local2, f16_local3 = nil
	if CoD.gameMode == "MP" and not CoD.IsWagerMode() then
		f16_local2 = f0_local16(verticalList, Engine.Localize("DRC_CLASSES"), "open_changeclass", LUI.UITouchpadRadioButton, f16_local1)
		local f16_local4 = f16_local2:setIcon("menu_mp_weapons_tar21")
		f16_local4:setLeftRight(true, true, 32, -32)
		f16_local4:setTopBottom(false, true, -160, -64)
		f16_local2:registerEventHandler("change_class_button_material", function (f24_arg0, f24_arg1)
			f24_arg0:setIcon(f24_arg1.material)
		end)
	end
	local f16_local4 = f0_local16(verticalList, Engine.Localize("DRC_CONTROLS"), "toggle_controls", LUI.UITouchpadRadioButton, f16_local1)
	local f16_local5 = nil
	if not Engine.SessionModeIsMode(CoD.SESSIONMODE_OFFLINE) and not Engine.SessionModeIsMode(CoD.SESSIONMODE_SYSTEMLINK) then
		f16_local5 = f0_local16(verticalList, Engine.Localize("DRC_FRIENDS"), "toggle_friends", LUI.UITouchpadRadioButton, "drcview_friends")
		if UIExpression.IsGuest(f16_arg0) == 0 then
			f0_local13(f16_local5)
		else
			f16_local5.m_inputDisabled = true
		end
		local f16_local6 = f16_local5:setIcon("wiiu_friend_icon")
		f16_local6:setLeftRight(true, false, 64, 160)
		f16_local6:setTopBottom(false, true, -160, -64)
		LUI.roots.UIRootDrc.friendsButton = f16_local5.drawnContainer
		verticalList:registerEventHandler("friends_update_alert", f0_local11)
		verticalList:registerEventHandler("toggle_friends", f0_local12)
	end
	if Engine.WiiUGetDisplayConfiguration(CoD.DrcOutput.DisplayTv) ~= CoD.DrcOutput.ShowSplitScreen and Engine.IsHiDef() then
		local Widget = f0_local16(verticalList, Engine.Localize("DRC_DISPLAY"), "show_game_on_drc", LUI.UITouchpadButton)
		Widget.label.downText = nil
		local f16_local8 = Widget:setIcon("wiiu_controller_icon_drc_lit")
		f16_local8:setLeftRight(true, true, 72, -72)
		f16_local8:setTopBottom(true, true, 78, -66)
	end
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 0, verticalList.width)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:addElement(CoD.Border.new(3, 0.2, 0.23, 0.29, 1, 2))
	Widget:addElement(verticalList)
	Widget.verticalList = verticalList
	
	Widget.width = verticalList.width
	Widget.debugName = "DrcView.list.buttonPanel"
	Widget.classButton = f16_local2
	Widget.controlsButton = f16_local4
	Widget.friendsButton = f16_local5
	Widget.buttons = {}
	Widget.buttons.change_class = f16_local2
	Widget.buttons.controls = f16_local4
	Widget.buttons.friends = f16_local5
	verticalList.panel = Widget
	return Widget
end

local f0_local18 = function (f17_arg0)
	local f17_local0 = f17_arg0.compassPanel.width
	local f17_local1 = f17_arg0.compassPanel:toggleFullScreenMode()
	f0_local1(f17_arg0.horizontalList, f17_arg0.compassPanel.width - f17_local0)
	local f17_local2 = f17_arg0.horizontalList
	if f17_local1 then
		local f17_local3 = -665
		local f17_local4 = f17_local2:getFirstChild()
		while f17_local4 and f17_local4 ~= f17_arg0.compassPanel do
			f17_local3 = f17_local3 - f17_local4.width
			f17_local4 = f17_local4:getNextSibling()
		end
		f17_local2.left = f17_local3
		f17_arg0.compassPanel.border:setAlpha(0)
		f17_arg0.rewardPanel.border:setAlpha(0)
	else
		f17_local2.left = f17_local2.snapScrollMin
		f17_arg0.compassPanel.border:setAlpha(1)
		f17_arg0.rewardPanel.border:setAlpha(1)
	end
	f17_local2:beginAnimation("snap")
	f17_local2:setLeftRight(false, false, f17_local2.left, f17_local2.left + f17_local2.width)
	f17_local2:setTopBottom(true, true, 0, 0)
	f17_arg0.snapAnim = true
end

local f0_local19 = function (f18_arg0, f18_arg1)
	local f18_local0 = nil
	local f18_local1 = UIExpression.GetControllerType(f18_arg1.controller)
	if f18_local1:len() == 0 then
		f18_local1 = "drc"
	end
	local f18_local2 = f18_arg0.buttonPanel.controlsButton:setIcon(CoD.DrcView.ControllerIconMaterials[f18_local1])
	f18_local2:setLeftRight(true, true, 72, -72)
	f18_local2:setTopBottom(true, true, 78, -66)
	f18_arg0:dispatchEventToChildren(f18_arg1)
end

local f0_local20 = function (f19_arg0, f19_arg1)
	if f19_arg1.controller == f19_arg0.controller then
		f19_arg0.compassPanel:setAlpha(0)
		f19_arg0.rewardPanel:setAlpha(0)
	end
end

local f0_local21 = function (f20_arg0, f20_arg1)
	if f20_arg1.controller == f20_arg0.controller then
		f20_arg0.compassPanel:setAlpha(1)
		f20_arg0.rewardPanel:setAlpha(1)
	end
end

CoD.DrcView.new = function (f21_arg0)
	local f21_local0 = f0_local17(f21_arg0)
	local f21_local1, f21_local2, f21_local3 = nil
	local f21_local4 = f21_local0.width
	local f21_local5 = nil
	local f21_local6 = CoD.gameMode
	if f21_local6 == "MP" then
		f21_local1 = CoD.DrcCompassPanel.new(f21_arg0)
		f21_local2 = CoD.RewardSelectionDrc.new(f21_arg0)
		f21_local4 = f21_local4 + f21_local2.width + f21_local1.width
	elseif f21_local6 == "ZM" then
		f21_local3 = CoD.DrcZMMainPanel.new(f21_arg0)
		f21_local4 = f21_local4 + f21_local3.width
	elseif f21_local6 == "SP" then
		f21_local5 = CoD.DrcObjectivesPanel.new(f21_arg0)
	end
	local f21_local7 = CoD.DrcView.ViewWidth / 2
	local horizontalList = LUI.UIHorizontalList.new()
	horizontalList:setLeftRight(false, false, -f21_local7, f21_local7)
	horizontalList:setTopBottom(true, true, 0, 0)
	horizontalList:registerEventHandler("transition_complete_taper", function (f25_arg0, f25_arg1)
		TaperAnimation(f25_arg0)
	end)
	horizontalList:registerEventHandler("transition_complete_snap", function (f26_arg0, f26_arg1)
		f26_arg0.view.snapAnim = false
	end)
	horizontalList:registerEventHandler("transition_complete_expand", f0_local3)
	horizontalList:registerEventHandler("force_close_changeclass", function (f27_arg0)
		f27_arg0.view:processEvent({
			name = "animatedClose_changeclass"
		})
	end)
	horizontalList:registerEventHandler("force_close_controls", function (f28_arg0)
		local f28_local0 = f28_arg0.view.controlsPanel
		if f28_local0 then
			f28_local0:processEvent({
				name = "animated_close"
			})
		end
	end)
	horizontalList.width = 0
	f0_local1(horizontalList, f21_local4)
	horizontalList.left = -f21_local7
	horizontalList.velocityNumFrames = 0
	horizontalList.velocityCurFrame = 0
	horizontalList.velocityCache = {
		0,
		0,
		0,
		0
	}
	horizontalList.debugName = "DrcView.list"
	horizontalList:addElement(f21_local0)
	if f21_local6 == "MP" then
		horizontalList:addElement(f21_local1)
		horizontalList:addElement(f21_local2)
	elseif f21_local6 == "ZM" then
		horizontalList:addElement(f21_local3)
	elseif f21_local6 == "SP" then
		horizontalList:addElement(f21_local5)
	end
	f0_local0(horizontalList)
	f21_local0.horizontalList = horizontalList
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setUseStencil(true)
	Widget:addElement(horizontalList)
	Widget.horizontalList = horizontalList
	
	Widget.buttonPanel = f21_local0
	Widget.compassPanel = f21_local1
	Widget.rewardPanel = f21_local2
	Widget.controller = f21_arg0
	Widget.zmMainPanel = f21_local3
	Widget.objectivesPanel = f21_local5
	Widget.cannotDrag = 0
	Widget.cannotDragSource = 0
	Widget.cannotDragBecauseVerticalThreshold = 0
	Widget.debugName = "DrcView"
	Widget.slideSFX = "uin_panel_slide_drc"
	Widget:registerEventHandler("toggle_fullscreen_compass", f0_local18)
	Widget:registerEventHandler("disable_scrolling", View_ButtonDownDisableDrag)
	Widget:registerEventHandler("controller_changed", f0_local19)
	Widget:registerEventHandler("press_view_panel_button", f0_local4)
	if f21_local6 == "MP" then
		Widget:registerEventHandler("killcam_open", f0_local20)
		Widget:registerEventHandler("killcam_close", f0_local21)
	end
	Widget:registerEventHandler("hud_update_bit_" .. CoD.BIT_EMP_ACTIVE, function (f29_arg0, f29_arg1)
		if f29_arg1.enabled then
			f0_local20(f29_arg0, f29_arg1)
		else
			f0_local21(f29_arg0, f29_arg1)
		end
	end)
	horizontalList.view = Widget
	f21_local0.view = Widget
	Widget:processEvent({
		name = "controller_changed",
		controller = f21_arg0
	})
	LUI.roots.UIRootDrc.view = Widget
	return Widget
end

