require("T6.CoDBase")
require("T6.Border")
require("T6.AdditiveTextOverlay")
require("T6.HorizontalCarousel")
require("T6.ScrollingVerticalList")
require("T6.RTSTutorialCardCarousel")
if CoD.isWIIU then
	require("T6.WiiUButtonLayout")
end
CoD.RTSTutorial = {}
CoD.RTSTutorial.Active = false
CoD.RTSTutorial.SeenTutorial = function ()
	return true
end

CoD.RTSTutorial.FadeOutBackground = function (f2_arg0)
	if f2_arg0 ~= nil then
		f2_arg0.fadeOut:beginAnimation("show", 1000)
		f2_arg0.fadeOut:setAlpha(1)
	end
end

CoD.RTSTutorial.AddChangePagesButton = function (f3_arg0)
	if f3_arg0 ~= nil then
		local f3_local0 = {}
		f3_local0 = GetTextDimensions(Engine.Localize("PLATFORM_CHANGE_PAGES"), CoD.fonts.Condensed, CoD.textSize.Condensed)
		local f3_local1, f3_local2 = Engine.GetUserSafeArea()
		local f3_local3 = LUI.UIButton.new()
		f3_local3:setLeftRight(false, false, -f3_local1 / 2, -f3_local1 / 2 + f3_local0[3])
		f3_local3:setTopBottom(false, false, f3_local2 / 2 - CoD.textSize.Condensed, f3_local2 / 2)
		f3_arg0:addElement(f3_local3)
		f3_local3.label = LUI.UIText.new()
		f3_local3.label:setLeftRight(true, true, 0, 0)
		f3_local3.label:setTopBottom(true, true, 0, 0)
		f3_local3.label:setFont(CoD.fonts.Condensed)
		f3_local3:addElement(f3_local3.label)
		f3_local3.label:setText(Engine.Localize("PLATFORM_CHANGE_PAGES_WITH_ICON"))
	end
end

function CreateBottomBar(f4_arg0, f4_arg1)
	local f4_local0 = 0.01
	local f4_local1 = 0
	local f4_local2 = 0.1
	local f4_local3 = 0.1
	local f4_local4 = 0.2
	local f4_local5 = f4_arg1 * f4_local0
	local f4_local6 = f4_arg1 * f4_local2
	local f4_local7 = f4_arg0 * f4_local3
	local f4_local8 = f4_arg0 * f4_local4
	local f4_local9 = f4_arg0 * f4_local1
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f4_arg0 / 2 - f4_local9, f4_arg0 / 2 + f4_local9)
	Widget:setTopBottom(false, false, f4_arg1 / 2 - f4_local5, f4_arg1 / 2 - f4_local5 + f4_local6)
	local f4_local11 = LUI.UIImage.new()
	f4_local11:setTopBottom(true, true, 0, 0)
	f4_local11:setLeftRight(true, false, 0, f4_local7)
	f4_local11:setImage(RegisterMaterial("hud_strikeforce_map_bar_left"))
	Widget:addElement(f4_local11)
	local f4_local12 = LUI.UIImage.new()
	f4_local12:setTopBottom(true, true, 0, 0)
	f4_local12:setLeftRight(false, true, -f4_local7, 0)
	f4_local12:setImage(RegisterMaterial("hud_strikeforce_map_bar_right"))
	Widget:addElement(f4_local12)
	local f4_local13 = LUI.UIImage.new()
	f4_local13:setTopBottom(true, true, 0, 0)
	f4_local13:setLeftRight(false, false, -f4_local8 / 2, f4_local8 / 2)
	f4_local13:setImage(RegisterMaterial("hud_strikeforce_map_bar_center"))
	Widget:addElement(f4_local13)
	local f4_local14 = LUI.UIImage.new()
	f4_local14:setTopBottom(true, true, 0, 0)
	f4_local14:setLeftRight(false, true, -f4_arg0 / 2 + f4_local8 / 2 - f4_local9, -f4_local7)
	f4_local14:setImage(RegisterMaterial("hud_strikeforce_map_bar_spacer"))
	Widget:addElement(f4_local14)
	local f4_local15 = LUI.UIImage.new()
	f4_local15:setTopBottom(true, true, 0, 0)
	f4_local15:setLeftRight(true, false, f4_local7, f4_arg0 / 2 - f4_local8 / 2 + f4_local9)
	f4_local15:setImage(RegisterMaterial("hud_strikeforce_map_bar_spacer"))
	Widget:addElement(f4_local15)
	return Widget
end

CoD.RTSTutorial.new = function ()
	local Widget = nil
	if not CoD.RTSTutorial.Active then
		CoD.RTSTutorial.Active = true
		Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, true, 0, 0)
		Widget:setTopBottom(true, true, 0, 0)
		Widget.fadeOut = LUI.UIImage.new()
		Widget.fadeOut:setLeftRight(true, true, 0, 0)
		Widget.fadeOut:setTopBottom(true, true, 0, 0)
		Widget.fadeOut:setAlpha(0)
		Widget.fadeOut:setRGB(0, 0, 0)
		Widget.fadeOut:registerAnimationState("show", {
			alpha = 1
		})
		Widget:addElement(Widget.fadeOut)
		Widget.close = CoD.RTSTutorial.close
		Widget.fadeOutBackground = CoD.RTSTutorial.FadeOutBackground
		local f5_local1, f5_local2 = Engine.GetUserSafeArea()
		local f5_local3 = f5_local2 * 0.76
		local f5_local4 = f5_local3 * 1.78
		local f5_local5 = CoD.RTSTutorialCardCarousel.new(f5_local4, f5_local3)
		Widget:addElement(f5_local5)
		Widget:addElement(CreateBottomBar(f5_local4, f5_local3))
		local f5_local6 = CoD.RTSTutorialCard.new(f5_local4, f5_local3)
		f5_local6:addRightScreenshot("hud_strikeforce_image_squard_select01")
		f5_local6:addActiveUnitPanel()
		f5_local6:addManualBox(0.69, 0.38, 0.12, 0.07, CoD.RTSColors.yellow)
		f5_local6:addManualLine(0.03, 90, 0.75, 0.48)
		f5_local6:addManualText(Engine.Localize("SO_RTS_ACTIVE_UNIT_PANEL_CAPS"), 0.75, 0.72, CoD.RTSColors.yellow)
		f5_local6:addLeftTitle(Engine.Localize("SO_RTS_SELECT_SQUADS_CAPS"))
		local f5_local7 = nil
		if CoD.isPC then
			f5_local7 = f5_local6:addLeftText(Engine.Localize("SO_RTS_SELECT_SQUADS_PC"))
		elseif CoD.isPS3 then
			f5_local7 = f5_local6:addLeftText(Engine.Localize("SO_RTS_SELECT_SQUADS_PS3"))
		else
			f5_local7 = f5_local6:addLeftText(Engine.Localize("SO_RTS_SELECT_SQUADS"))
		end
		CoD.RTS.SetupDpadOrCarouselText(f5_local7, "SO_RTS_SELECT_SQUADS_WIIU", "SO_RTS_SELECT_SQUADS_WIIU_CAROUSEL")
		f5_local6:addLeftBottomText(Engine.Localize("SO_RTS_SQUAD_ICON_INFO"))
		f5_local6:addLeftBottomTitle(Engine.Localize("SO_RTS_SQUAD_ICON_CAPS"))
		f5_local6:addSquadUnitPanel()
		f5_local5:addCard(f5_local6, Engine.Localize("SO_RTS_SELECTION_CAPS"))
		local f5_local8 = CoD.RTSTutorialCard.new(f5_local4, f5_local3)
		f5_local8:addRightScreenshot("hud_strikeforce_image_squard_com")
		f5_local8:addRightScreenshot("hud_strikeforce_image_squard_com01")
		f5_local8:addLeftTitle(Engine.Localize("SO_RTS_SQUAD_COMMANDS_WAYPOINTS_CAPS"))
		f5_local8:addTextDot()
		local f5_local9 = nil
		if CoD.isPC then
			f5_local9 = f5_local8:addLeftText(Engine.Localize("SO_RTS_SQUAD_COMMANDS_WAYPOINTS_PC"))
		else
			f5_local9 = f5_local8:addLeftText(Engine.Localize("SO_RTS_SQUAD_COMMANDS_WAYPOINTS"))
		end
		CoD.RTS.SetupDpadOrCarouselText(f5_local9, "SO_RTS_SQUAD_COMMANDS_WAYPOINTS_WIIU", "SO_RTS_SQUAD_COMMANDS_WAYPOINTS_WIIU_CAROUSEL")
		f5_local8:addTextDot()
		f5_local8:addLeftText(Engine.Localize("SO_RTS_SQUAD_COMMANDS_WAYPOINTS2"))
		f5_local8:addManualTextDot(1, 0.7, 0.35)
		f5_local8:addManualBox(0.69, 0.38, 0.12, 0.07, CoD.RTSColors.yellow)
		f5_local8:addManualTextDot(2, 0.7, 0.6)
		f5_local5:addCard(f5_local8, Engine.Localize("SO_RTS_COMMANDS_CAPS"))
		local f5_local10 = CoD.RTSTutorialCard.new(f5_local4, f5_local3)
		f5_local10:addRightScreenshot("hud_strikeforce_image_squard_obj")
		f5_local10:addRightScreenshot("hud_strikeforce_image_squard_enemy")
		f5_local10:addLeftTitle(Engine.Localize("SO_RTS_SQUAD_COMMANDS_TARGETING_CAPS"))
		f5_local10:addTextDot()
		f5_local10:addLeftText(Engine.Localize("SO_RTS_SQUAD_COMMANDS_TARGETING"))
		f5_local10:addLeftTitle(Engine.Localize("SO_RTS_SQUAD_COMMANDS_TARGETING_ENEMIES_CAPS"))
		f5_local10:addTextDot()
		f5_local10:addLeftText(Engine.Localize("SO_RTS_SQUAD_COMMANDS_TARGETING_ENEMIES"))
		f5_local10:addManualTextDot(1, 0.7, 0.25)
		f5_local10:addManualTextDot(2, 0.72, 0.58)
		f5_local5:addCard(f5_local10, Engine.Localize("SO_RTS_COMMANDS_CONT_CAPS"))
		local f5_local11 = CoD.RTSTutorialCard.new(f5_local4, f5_local3)
		f5_local11:addRightScreenshot("hud_strikeforce_image_tact")
		f5_local11:addLeftTitle(Engine.Localize("SO_RTS_STRATEGIC_VIEWS_CAP"))
		local f5_local12 = nil
		if CoD.isPC then
			f5_local12 = f5_local11:addLeftText(Engine.Localize("SO_RTS_TACTICAL_VIEW_INFO_PC"))
		else
			f5_local12 = f5_local11:addLeftText(Engine.Localize("SO_RTS_TACTICAL_VIEW_INFO"))
		end
		CoD.RTS.SetupDpadOrCarouselText(f5_local12, "SO_RTS_TACTICAL_VIEW_INFO_WIIU", "SO_RTS_TACTICAL_VIEW_INFO_WIIU_CAROUSEL")
		f5_local5:addCard(f5_local11, Engine.Localize("SO_RTS_TACTICAL_VIEW_CAPS"))
		if not CoD.isPC then
			local f5_local13 = CoD.RTSTutorialCard.new(f5_local4, f5_local3)
			local f5_local14 = tonumber(UIExpression.ProfileValueAsString(UIExpression.GetPrimaryController(), "gpad_buttonsConfig"))
			if CoD.isWIIU then
				CoD.WiiUButtonLayout.AddRTSControlElements(f5_local13)
			elseif CoD.isXBOX == true then
				f5_local13:addManualScreenshot("xenon_controller_top", 0.5, 0.5, 0.5, 0.9)
				f5_local13:addManualText(Engine.Localize("SO_RTS_TACTICAL_VIEW_CAPS"), 0.46, 0.1)
				f5_local13:addManualText(Engine.Localize("SO_RTS_SELECT_SQUADS_CAPS"), 0.45, 0.9)
				f5_local13:addManualLine(0.16, 90, 0.46, 0.28)
				f5_local13:addManualLine(0.16, 90, 0.44, 0.72)
				if f5_local14 ~= 2 then
					f5_local13:addManualText(Engine.Localize("SO_RTS_ISSUE_COMMANDS_CAPS"), 0.19, 0.16)
					f5_local13:addManualLine(0.19, -20, 0.26, 0.25)
				else
					f5_local13:addManualText(Engine.Localize("SO_RTS_ISSUE_COMMANDS_CAPS"), 0.81, 0.16)
					f5_local13:addManualLine(0.19, 20, 0.74, 0.25)
				end
			elseif CoD.isPS3 == true then
				f5_local13:addManualScreenshot("ps3_controller_top", 0.5, 0.5, 0.5, 0.9)
				f5_local13:addManualText(Engine.Localize("SO_RTS_TACTICAL_VIEW_CAPS"), 0.47, 0.1)
				f5_local13:addManualText(Engine.Localize("SO_RTS_SELECT_SQUADS_CAPS"), 0.38, 0.9)
				f5_local13:addManualLine(0.21, 90, 0.47, 0.32)
				f5_local13:addManualLine(0.18, 90, 0.38, 0.69)
				if f5_local14 ~= 2 then
					f5_local13:addManualText(Engine.Localize("SO_RTS_ISSUE_COMMANDS_CAPS"), 0.19, 0.16)
					f5_local13:addManualLine(0.19, -20, 0.26, 0.25)
				else
					f5_local13:addManualText(Engine.Localize("SO_RTS_ISSUE_COMMANDS_CAPS"), 0.81, 0.16)
					f5_local13:addManualLine(0.19, 20, 0.74, 0.25)
				end
			end
			f5_local5:addCard(f5_local13, Engine.Localize("SO_RTS_CONTROLS_CAPS"))
		end
		Widget:processEvent({
			name = "controller_changed",
			controller = controller
		})
		Widget.carousel = f5_local5
	end
	return Widget
end

CoD.RTSTutorial.close = function (f6_arg0)
	CoD.RTSTutorial.Active = false
	LUI.UIElement.close(f6_arg0)
end

CoD.RTSTutorial.SelectButtonAction = function (f7_arg0, f7_arg1)
	if not f7_arg0.seenLast then
		f7_arg0:processEvent({
			name = "right_card",
			controller = f7_arg1.controller
		})
	else
		f7_arg0:dispatchEventToParent({
			name = "briefing_startplay",
			controller = f7_arg1.controller
		})
	end
end

CoD.RTSTutorial.AddSelectButton = function (f8_arg0)
	local f8_local0 = UIExpression.GetPrimaryController()
	local f8_local1 = LUI.UIButton.new()
	f8_local1:setActionEventName("select_action")
	f8_arg0.carousel:addElement(f8_local1)
	f8_arg0.carousel:registerEventHandler("select_action", CoD.RTSTutorial.SelectButtonAction)
	LUI.UIButton.gainFocus(f8_local1, {
		controller = f8_local0
	})
end

