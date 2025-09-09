require("T6.MFSlidePanelManager")
CoD.MFPopup = {}
CoD.MFPopup.FadeInTime = 250
CoD.MFPopup.FadeOutTime = 150
CoD.MFPopup.Width = 840
CoD.MFPopup.Height = 600
local f0_local0 = function (f1_arg0, f1_arg1, f1_arg2)
	if f1_arg2 == nil then
		f1_arg2 = CoD.MFPopup.FadeInTime
	end
	f1_arg0.title:setText(f1_arg1)
	f1_arg0.title:animateToState("fade_in_popup_title", f1_arg2, false, false)
end

local f0_local1 = function (f2_arg0, f2_arg1)
	if f2_arg1 == nil then
		f2_arg1 = CoD.MFPopup.FadeOutTime
	end
	f2_arg0.title:animateToState("fade_out_popup_title", f2_arg1, false, false)
end

local f0_local2 = function (f3_arg0, f3_arg1, f3_arg2)
	if f3_arg2 == nil then
		f3_arg2 = CoD.MFPopup.FadeInTime
	end
	f3_arg0.topTitle:setText(f3_arg1)
	f3_arg0.topTitle:animateToState("fade_in_popup_top_title", f3_arg2, false, false)
end

local f0_local3 = function (f4_arg0, f4_arg1)
	if f4_arg1 == nil then
		f4_arg1 = CoD.MFPopup.FadeOutTime
	end
	f4_arg0.topTitle:animateToState("fade_out_popup_top_title", f4_arg1, false, false)
end

local f0_local4 = function (f5_arg0, f5_arg1)
	if f5_arg1 == nil and f5_arg0.frame.slideContainer ~= nil then
		return f5_arg0.frame.slideContainer.currentSlide
	else
		return f5_arg1
	end
end

local f0_local5 = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = f0_local4(f6_arg0, f6_arg1)
	if f6_local0 ~= nil then
		f6_local0.m_inputDisabled = f6_arg2
	end
	if f6_arg1 == nil and f6_local0 ~= nil then
		f6_local0.frame.buttonPrompts.m_inputDisabled = f6_arg2
	end
	return f6_local0
end

local f0_local6 = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	local f7_local0 = f0_local5(f7_arg0, f7_arg3, true)
	if f7_arg1 == nil then
		f7_arg1 = CoD.MFPopup.FadeInTime
	end
	if f7_arg0.popupTitle ~= nil then
		f7_arg0:fadeInTitle(f7_arg0.popupTitle)
	end
	if f7_arg0.popupTopTitle ~= nil then
		f7_arg0:fadeInTopTitle(f7_arg0.popupTopTitle)
	end
	if UIExpression.IsInGame() == 1 then
		f7_arg0.darkenElement = LUI.UIImage.new({
			left = 0,
			top = 0,
			right = 0,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = true,
			bottomAnchor = true,
			red = 0,
			green = 0,
			blue = 0,
			alpha = 0.8
		})
		f7_local0:addElement(f7_arg0.darkenElement)
	else
		f7_arg0:setBlur(true)
	end
	if f7_arg2 == true then
		f7_arg0.slideIn = true
		f7_arg0:animateToState("show", 0)
		f7_arg0:animateToState("slide_in", f7_arg1, true, true)
	else
		f7_arg0:animateToState("slide_in", 0)
		f7_arg0:animateToState("show", f7_arg1, true, true)
	end
	f7_arg0.frame:addElement(f7_arg0)
end

local f0_local7 = function (f8_arg0)
	f8_arg0:close()
	if f8_arg0.noInputToParent == nil then
		f0_local5(f8_arg0, f8_arg0.parentPopup, nil)
	end
end

local f0_local8 = function (f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4)
	if f9_arg1 == nil then
		f9_arg1 = CoD.MFPopup.FadeInTime
	end
	f9_arg0.noInputToParent = f9_arg4
	f9_arg0.parentPopup = f9_arg3
	f9_arg0:addElement(LUI.UITimer.new(f9_arg1, "destroy_popup", true))
	if f9_arg2 == true then
		f9_arg0:animateToState("default", f9_arg1, true, true)
	else
		f9_arg0:animateToState("hide", f9_arg1, true, true)
	end
	f9_arg0:fadeOutTitle(f9_arg1)
	f9_arg0:fadeOutTopTitle(f9_arg1)
	if UIExpression.IsInGame() == 0 then
		if f9_arg3 == nil then
			f9_arg0:setBlur(false)
		else
			f9_arg3:setBlur(true)
		end
	end
	if f9_arg0.darkenElement ~= nil then
		f9_arg0.darkenElement:close()
	end
	f9_arg0:processEvent({
		name = "lose_focus"
	})
	Engine.PlaySound("uin_navigation_backout")
end

local f0_local9 = function (f10_arg0)
	f10_arg0.selectButton = CoD.ButtonPrompt.new("primary", Engine.Localize("MENU_SELECT_CAPS"), f10_arg0)
	f10_arg0.body.leftBottomButtonBar:addElement(f10_arg0.selectButton)
end

local f0_local10 = function (f11_arg0)
	f11_arg0.backButton = CoD.ButtonPrompt.new("secondary", Engine.Localize("MENU_BACK_CAPS"), f11_arg0, "button_prompt_back")
	f11_arg0.body.rightBottomButtonBar:addElement(f11_arg0.backButton)
end

function CoD_MFPopup_ButtonPromptBack(f12_arg0, f12_arg1)
	f12_arg0:closePopup(nil, f12_arg0.slideIn)
end

function CoD_MFPopup_SlideChanged(f13_arg0, f13_arg1)
	f13_arg0:closePopup(nil, nil, nil, true)
end

CoD.MFPopup.new = function (f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4, f14_arg5, f14_arg6)
	if f14_arg1 == nil then
		f14_arg1 = CoD.MFPopup.Width
	end
	if f14_arg2 == nil then
		f14_arg2 = CoD.MFPopup.Height
	end
	local Widget = LUI.UIElement.new({
		left = -f14_arg1 / 2,
		top = -f14_arg2 - 100,
		right = f14_arg1 / 2,
		bottom = -100,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	Widget.id = "MFPopup"
	Widget:registerAnimationState("slide_in", {
		left = -f14_arg1 / 2,
		top = -f14_arg2 / 2,
		right = f14_arg1 / 2,
		bottom = f14_arg2 / 2,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false
	})
	Widget:registerAnimationState("hide", {
		alpha = 0
	})
	Widget:registerAnimationState("show", {
		alpha = 1
	})
	Widget.slide = f14_arg0
	Widget.frame = f14_arg0.frame
	if f14_arg3 ~= nil then
		Widget.popupTitle = f14_arg3
		Widget.id = "MFPopup." .. f14_arg3
	end
	if f14_arg6 ~= nil then
		Widget.popupTopTitle = f14_arg6
	end
	local body = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = -CoD.ButtonPrompt.Height,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true
	})
	body.id = Widget.id .. ".body"
	Widget:addElement(body)
	Widget.body = body
	
	body:setUseStencil(true)
	local f14_local2 = CoD.MFSlidePanelManager.new()
	f14_local2:setSlide(f14_arg0)
	Widget.body:addElement(f14_local2)
	Widget.panelManager = f14_local2
	if f14_arg5 == nil then
		f14_arg5 = "menu_mp_tab_frame_inner"
	end
	local f14_local3 = 0
	if f14_arg4 == true then
		f14_local3 = CoD.textSize.Default
	end
	body.background = LUI.UIImage.new({
		left = 0,
		top = f14_local3,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		material = RegisterMaterial(f14_arg5)
	})
	body:addElement(body.background)
	local f14_local4 = 0
	Widget.titleContainer = LUI.UIElement.new({
		left = -CoD.textSize.Morris,
		top = f14_local4,
		right = 0,
		bottom = CoD.textSize.Morris + f14_local4,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		zRot = 90
	})
	Widget:addElement(Widget.titleContainer)
	Widget.title = LUI.UIText.new({
		left = -CoD.textSize.Morris,
		top = -CoD.textSize.Morris,
		bottom = 0,
		right = 0,
		leftAnchor = false,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		font = CoD.fonts.Morris,
		alpha = 0
	})
	Widget.title:registerAnimationState("fade_in_popup_title", {
		alpha = CoD.textAlpha
	})
	Widget.title:registerAnimationState("fade_out_popup_title", {
		alpha = 0
	})
	Widget.titleContainer:addElement(Widget.title)
	f14_local4 = -30
	Widget.topTitleContainer = LUI.UIElement.new({
		left = CoD.textSize.Default,
		top = f14_local4,
		right = 0,
		bottom = CoD.textSize.Default + f14_local4,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	Widget:addElement(Widget.topTitleContainer)
	Widget.topTitle = LUI.UIText.new({
		left = -24,
		top = -CoD.textSize.Default,
		bottom = 0,
		right = 500,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		font = CoD.fonts.Default,
		alpha = 0,
		alignment = LUI.Alignment.Left
	})
	Widget.topTitle:registerAnimationState("fade_in_popup_top_title", {
		alpha = CoD.textAlpha
	})
	Widget.topTitle:registerAnimationState("fade_out_popup_top_title", {
		alpha = 0
	})
	Widget.topTitleContainer:addElement(Widget.topTitle)
	local f14_local5 = 0
	body.rightBottomButtonBar = LUI.UIHorizontalList.new({
		left = 0,
		top = -f14_local5 - CoD.ButtonPrompt.Height,
		right = 0,
		bottom = -f14_local5,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = 10,
		alignment = LUI.Alignment.Right
	})
	Widget:addElement(Widget.body.rightBottomButtonBar)
	body.leftBottomButtonBar = LUI.UIHorizontalList.new({
		left = 0,
		top = -f14_local5 - CoD.ButtonPrompt.Height,
		right = 0,
		bottom = -f14_local5,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true,
		spacing = 10,
		alignment = LUI.Alignment.Left
	})
	Widget:addElement(Widget.body.leftBottomButtonBar)
	Widget.fadeInTitle = f0_local0
	Widget.fadeOutTitle = f0_local1
	Widget.fadeInTopTitle = f0_local2
	Widget.fadeOutTopTitle = f0_local3
	Widget.openPopup = f0_local6
	Widget.closePopup = f0_local8
	Widget.destroyPopup = f0_local7
	Widget.addBackButton = f0_local10
	Widget.addSelectButton = f0_local9
	Widget:registerEventHandler("button_prompt_back", CoD_MFPopup_ButtonPromptBack)
	Widget:registerEventHandler("destroy_popup", f0_local7)
	Widget:registerEventHandler("slide_changed", CoD_MFPopup_SlideChanged)
	return Widget
end

