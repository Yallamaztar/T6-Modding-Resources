CoD.MissionButton = {}
CoD.MissionButton.ButtonOverAnimTime = 150
CoD.MissionButton.ButtonActionSFX = "uin_main_enter"
CoD.MissionButton.DescTextFont = "Default"
CoD.MissionButton.ObjectiveFontName = "Condensed"
CoD.MissionButton.MissionNameNormalFontName = "Condensed"
CoD.MissionButton.MissionNameSelectedFontName = "Big"
CoD.MissionButton.LevelImageHeight = 100
CoD.MissionButton.LevelImageAspectRatio = 2
CoD.MissionButton.LevelImageSelectedScale = 4
CoD.MissionButton.FadeIn = function (f1_arg0)
	if f1_arg0 ~= nil then
		f1_arg0:beginAnimation("fade_in", 300)
		f1_arg0:setAlpha(1)
	end
end

CoD.MissionButton.new = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5)
	if f2_arg0 == nil then
		f2_arg0 = CoD.GetDefaultAnimationState()
	end
	local f2_local0 = LUI.UIButton.new(f2_arg0, f2_arg4)
	f2_local0.id = "MissionButton." .. f2_arg1
	f2_local0.loadName = f2_arg1
	f2_local0.setSFX = CoD.MissionButton.SetSFX
	f2_local0.m_animTime = CoD.MissionButton.ButtonOverAnimTime
	if f2_arg5 ~= nil then
		f2_local0.m_animTime = f2_arg5
	end
	f2_local0:registerAnimationState("carousel_set_start", {
		left = 0,
		right = 0,
		leftAnchor = false,
		rightAnchor = false,
		top = 0,
		bottom = 0,
		topAnchor = false,
		bottomAnchor = false
	})
	f2_local0.missionText = Engine.Localize(f2_arg2)
	local f2_local1 = LUI.UIText.new(nil, true)
	CoD.MissionButton.MissionName_DefaultAnim(f2_local1, 0)
	f2_local1:setLeftRight(true, true, 0, 0)
	f2_local1:setAlignment(LUI.Alignment.Center)
	f2_local1:setText(f2_local0.missionText)
	f2_local0.missionNameText = f2_local1
	f2_local0:addElement(f2_local1)
	local f2_local2 = UIExpression.TableLookup(nil, "sp/levelLookup.csv", 1, f2_arg1, 2)
	f2_local0.levelAliasName = f2_local2
	local f2_local3 = 100
	local f2_local4 = 2
	local f2_local5 = 4
	local f2_local6 = 25
	local f2_local7 = nil
	if f2_local2 == nil or f2_local2 == "" then
		f2_local7 = RegisterMaterial("menu_visor_ms_" .. f2_arg1)
	else
		f2_local7 = RegisterMaterial("menu_visor_ms_" .. f2_local2)
	end
	local f2_local8 = LUI.UIStreamedImage.new()
	CoD.MissionButton.MissionImage_DefaultAnim(f2_local8, 0)
	f2_local8:setImage(f2_local7)
	f2_local8:setAlpha(0)
	f2_local8:registerEventHandler("streamed_image_ready", CoD.MissionButton.FadeIn)
	f2_local0.levelImage = f2_local8
	f2_local0:addElement(f2_local8)
	f2_local0:registerEventHandler("button_action", CoD.MissionButton.ButtonAction)
	f2_local0:registerEventHandler("gain_focus", CoD.MissionButton.GainFocus)
	f2_local0:registerEventHandler("lose_focus", CoD.MissionButton.LoseFocus)
	f2_local0:registerEventHandler("carousel_scroll_complete", CoD.MissionButton.CarouselScrollComplete)
	f2_local0:registerEventHandler("carousel_start_set", CoD.MissionButton.CarouselStartSet)
	f2_local0:registerEventHandler("carousel_mouse_enter", CoD.MissionButton.CarouselMouseEnter)
	f2_local0:registerEventHandler("carousel_mouse_leave", CoD.MissionButton.CarouselMouseLeave)
	f2_local0:registerEventHandler("gamepad_button", CoD.MissionButton.GamepadButton)
	return f2_local0
end

CoD.MissionButton.SetSFX = function (f3_arg0, f3_arg1)
	f3_arg0.m_sfxName = f3_arg1
end

CoD.MissionButton.ButtonAction = function (f4_arg0, f4_arg1)
	if f4_arg0.m_sfxName ~= nil then
		Engine.PlaySound(f4_arg0.m_sfxName)
	else
		Engine.PlaySound(CoD.MissionButton.ButtonActionSFX)
	end
	if f4_arg0.actionEventName ~= nil then
		f4_arg0:dispatchEventToParent({
			name = f4_arg0.actionEventName,
			controller = f4_arg1.controller,
			button = f4_arg0
		})
	end
end

CoD.MissionButton.GainFocus = function (f5_arg0, f5_arg1)
	LUI.UIElement.gainFocus(f5_arg0, f5_arg1)
	CoD.MissionButton.CreateMissionDetails(f5_arg0)
	CoD.MissionButton.MissionImage_SelectedAnim(f5_arg0.levelImage, f5_arg0.m_animTime)
	CoD.MissionButton.MissionName_SelectedAnim(f5_arg0.missionNameText, f5_arg0.m_animTime)
	CoD.MissionButton.Element_Show(f5_arg0.detailsContainer, f5_arg0.m_animTime)
	f5_arg0:animateToState("default", f5_arg0.m_animTime)
end

CoD.MissionButton.LoseFocus = function (f6_arg0, f6_arg1)
	LUI.UIElement.loseFocus(f6_arg0, f6_arg1)
	CoD.MissionButton.RemoveMissionDetails(f6_arg0)
	CoD.MissionButton.MissionImage_DefaultAnim(f6_arg0.levelImage, f6_arg0.m_animTime)
	CoD.MissionButton.MissionName_DefaultAnim(f6_arg0.missionNameText, f6_arg0.m_animTime)
end

CoD.MissionButton.CarouselScrollComplete = function (f7_arg0, f7_arg1)
	CoD.MissionButton.Element_Show(f7_arg0.brackets, 0)
	CoD.MissionButton.AnimateBrackets(f7_arg0.brackets, f7_arg0.m_animTime)
end

CoD.MissionButton.CarouselMouseEnter = function (f8_arg0, f8_arg1)
	if not f8_arg1.isSelected then
		local f8_local0 = f8_arg0.missionNameText
		local f8_local1 = CoD.MissionButton.MissionNameNormalFontName
		local f8_local2 = CoD.textSize[f8_local1] * 1.2
		f8_local0:beginAnimation("mouse_highlight", f8_arg0.m_animTime)
		f8_local0:setAlpha(1)
		f8_local0:setTopBottom(true, false, 0, f8_local2)
		f8_local0:setFont(CoD.fonts[f8_local1])
		local f8_local3 = f8_arg0.levelImage
		local f8_local4 = CoD.MissionButton.LevelImageHeight * 1.2
		local f8_local5 = f8_local4 * CoD.MissionButton.LevelImageAspectRatio
		f8_local3:beginAnimation("mouse_highlight", f8_arg0.m_animTime)
		f8_local3:setLeftRight(false, false, -f8_local5 / 2, f8_local5 / 2)
		f8_local3:setTopBottom(false, false, -f8_local4 / 2, f8_local4 / 2)
	else
		local f8_local0 = f8_arg0.levelImage
		local f8_local1 = 25
		local f8_local2 = CoD.MissionButton.LevelImageHeight * CoD.MissionButton.LevelImageSelectedScale * 1.1
		local f8_local3 = f8_local2 * CoD.MissionButton.LevelImageAspectRatio
		f8_local0:beginAnimation("mouse_highlight", f8_arg0.m_animTime)
		f8_local0:setLeftRight(false, false, -f8_local3 / 2 - f8_local1, f8_local3 / 2 - f8_local1)
		f8_local0:setTopBottom(false, false, -f8_local2 / 2, f8_local2 / 2)
	end
end

CoD.MissionButton.CarouselMouseLeave = function (f9_arg0, f9_arg1)
	if not f9_arg1.isSelected then
		CoD.MissionButton.MissionName_DefaultAnim(f9_arg0.missionNameText, f9_arg0.m_animTime)
		CoD.MissionButton.MissionImage_DefaultAnim(f9_arg0.levelImage, f9_arg0.m_animTime)
	else
		CoD.MissionButton.MissionImage_SelectedAnim(f9_arg0.levelImage, f9_arg0.m_animTime)
	end
end

CoD.MissionButton.Element_Hide = function (f10_arg0, f10_arg1)
	f10_arg0:beginAnimation("hide", f10_arg1)
	f10_arg0:setAlpha(0)
end

CoD.MissionButton.Element_Show = function (f11_arg0, f11_arg1)
	f11_arg0:beginAnimation("show", f11_arg1)
	f11_arg0:setAlpha(1)
end

CoD.MissionButton.MissionName_DefaultAnim = function (f12_arg0, f12_arg1)
	local f12_local0 = 0
	local f12_local1 = CoD.MissionButton.MissionNameNormalFontName
	f12_arg0:beginAnimation("default", f12_arg1)
	f12_arg0:setTopBottom(true, false, f12_local0, CoD.textSize[f12_local1] + f12_local0)
	f12_arg0:setFont(CoD.fonts[f12_local1])
	f12_arg0:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
	f12_arg0:setAlpha(0)
end

CoD.MissionButton.MissionName_SelectedAnim = function (f13_arg0, f13_arg1)
	local f13_local0 = 0
	local f13_local1 = CoD.MissionButton.MissionNameSelectedFontName
	f13_arg0:beginAnimation("selected", f13_arg1)
	f13_arg0:setTopBottom(true, false, f13_local0, CoD.textSize[f13_local1] + f13_local0)
	f13_arg0:setFont(CoD.fonts[f13_local1])
	f13_arg0:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	f13_arg0:setAlpha(1)
end

CoD.MissionButton.MissionImage_DefaultAnim = function (f14_arg0, f14_arg1)
	local f14_local0 = CoD.MissionButton.LevelImageHeight
	local f14_local1 = CoD.MissionButton.LevelImageAspectRatio
	f14_arg0:beginAnimation("default", f14_arg1)
	f14_arg0:setLeftRight(false, false, -(f14_local0 * f14_local1) / 2, f14_local0 * f14_local1 / 2)
	f14_arg0:setTopBottom(false, false, -f14_local0 / 2, f14_local0 / 2)
end

CoD.MissionButton.MissionImage_SelectedAnim = function (f15_arg0, f15_arg1)
	local f15_local0 = CoD.MissionButton.LevelImageHeight
	local f15_local1 = CoD.MissionButton.LevelImageAspectRatio
	local f15_local2 = CoD.MissionButton.LevelImageSelectedScale
	local f15_local3 = 25
	f15_arg0:beginAnimation("selected", f15_arg1)
	f15_arg0:setLeftRight(false, false, -(f15_local0 * f15_local1 * f15_local2) / 2 - f15_local3, f15_local0 * f15_local1 * f15_local2 / 2 - f15_local3)
	f15_arg0:setTopBottom(false, false, -(f15_local0 * f15_local2) / 2, f15_local0 * f15_local2 / 2)
end

CoD.MissionButton.AnimateBrackets = function (f16_arg0, f16_arg1)
	if not f16_arg0.width then
		return 
	else
		f16_arg0:beginAnimation("setup", 0)
		f16_arg0:setLeftRight(false, false, -f16_arg0.width / 2 - 20, f16_arg0.width / 2 + 20)
		f16_arg0:beginAnimation("animate", f16_arg1)
		f16_arg0:setLeftRight(false, false, -f16_arg0.width / 2, f16_arg0.width / 2)
	end
end

CoD.MissionButton.CreateMissionDetails = function (f17_arg0)
	if f17_arg0.detailsContainer then
		return 
	end
	f17_arg0.detailsContainer = LUI.UIElement.new()
	f17_arg0.detailsContainer:setLeftRight(true, true, 0, 0)
	f17_arg0.detailsContainer:setTopBottom(true, true, 0, 0)
	f17_arg0:addElement(f17_arg0.detailsContainer)
	local f17_local0 = CoD.textSize.Default + 15
	local f17_local1 = LUI.UIText.new()
	f17_local1:setLeftRight(true, true, 0, 0)
	f17_local1:setTopBottom(true, false, f17_local0, CoD.textSize.Default + f17_local0)
	f17_local1:setFont(CoD.fonts[normalTextSize])
	f17_local1:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	f17_local1:setAlpha(1)
	f17_arg0.detailsContainer:addElement(f17_local1)
	if CoD.Campaign.MissionBriefingInfo[f17_arg0.levelAliasName] ~= nil then
		f17_local1:setText(CoD.Campaign.MissionBriefingInfo[f17_arg0.levelAliasName].missionDate)
	end
	local f17_local2, f17_local3, f17_local4, f17_local5 = GetTextDimensions(f17_arg0.missionText, CoD.fonts.Big, CoD.textSize.Big)
	local f17_local6 = f17_local4 - f17_local2 + 30
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f17_local6 / 2, f17_local6 / 2)
	Widget:setTopBottom(true, false, 0, CoD.textSize.Default + f17_local0)
	Widget.width = f17_local6
	Widget:addElement(CoD.SideBracketsImage.new())
	f17_arg0.detailsContainer:addElement(Widget)
	f17_arg0.brackets = Widget
	local f17_local8 = 350
	local f17_local9 = 85
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f17_local8 / 2, f17_local8 / 2)
	Widget:setTopBottom(false, true, -f17_local9, 0)
	Widget:setAlpha(1)
	f17_arg0.detailsContainer:addElement(Widget)
	local f17_local11 = LUI.UIText.new()
	f17_local11:setLeftRight(true, true, 0, 0)
	f17_local11:setTopBottom(true, false, -28, -28 + CoD.textSize[CoD.MissionButton.ObjectiveFontName])
	f17_local11:setFont(CoD.fonts[CoD.MissionButton.ObjectiveFontName])
	f17_local11:setText(Engine.Localize("SPUI_MISSION_DETAILS"))
	f17_local11:setAlignment(LUI.Alignment.Center)
	f17_local11:setRGB(CoD.visorBlue2.r, CoD.visorBlue2.g, CoD.visorBlue2.b)
	Widget:addElement(f17_local11)
	local f17_local12 = -50
	local f17_local13 = 700
	local f17_local14 = 158
	local f17_local15 = LUI.UIImage.new()
	f17_local15:setLeftRight(false, false, -f17_local13 / 2, f17_local13 / 2)
	f17_local15:setTopBottom(true, false, f17_local12, f17_local12 + f17_local14)
	f17_local15:setImage(RegisterMaterial("mission_select_desc_bg"))
	Widget:addElement(f17_local15)
	local f17_local16 = LUI.UIText.new()
	f17_local16:setLeftRight(true, true, 0, 0)
	f17_local16:setTopBottom(true, false, 0, CoD.textSize[CoD.MissionButton.DescTextFont])
	f17_local16:setFont(CoD.fonts[CoD.MissionButton.DescTextFont])
	f17_local16:setAlignment(LUI.Alignment.Center)
	Widget:addElement(f17_local16)
	if CoD.Campaign.MissionBriefingInfo[f17_arg0.levelAliasName] ~= nil then
		f17_local16:setText(Engine.Localize(CoD.Campaign.MissionBriefingInfo[f17_arg0.levelAliasName].missionDesc))
	end
end

CoD.MissionButton.RemoveMissionDetails = function (f18_arg0)
	if f18_arg0.detailsContainer then
		f18_arg0.detailsContainer:close()
		f18_arg0.detailsContainer = nil
	end
end

CoD.MissionButton.GamepadButton = function (f19_arg0, f19_arg1)
	if f19_arg0:handleGamepadButton(f19_arg1) then
		return true
	elseif f19_arg0:isInFocus() and f19_arg1.down == true and f19_arg1.button == "primary" then
		if not f19_arg0.disabled then
			f19_arg0:processEvent({
				name = "button_action",
				controller = f19_arg1.controller
			})
		end
		return true
	else
		return false
	end
end

