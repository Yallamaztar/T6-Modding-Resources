CoD.ScrollableTextContainer = {}
CoD.ScrollableTextContainer.PauseTime = 3000
CoD.ScrollableTextContainer.TimePerLineScroll = 3000
CoD.ScrollableTextContainer.FadeDuration = 1000
CoD.ScrollableTextContainer.FadeOutComplete = function (f1_arg0, f1_arg1)
	f1_arg0:setTopBottom(true, true, 0, 0)
	f1_arg0:beginAnimation("fade_in", CoD.ScrollableTextContainer.FadeDuration)
	f1_arg0:setAlpha(1)
end

CoD.ScrollableTextContainer.FadeInComplete = function (f2_arg0, f2_arg1)
	CoD.ScrollableTextContainer.ScrollingStartPauseState(f2_arg0)
end

CoD.ScrollableTextContainer.ScrollingEndPauseStateComplete = function (f3_arg0, f3_arg1)
	f3_arg0:setAlpha(1)
	f3_arg0:beginAnimation("fade_out", CoD.ScrollableTextContainer.FadeDuration)
	f3_arg0:setAlpha(0)
end

CoD.ScrollableTextContainer.MoveUpStateComplete = function (f4_arg0, f4_arg1)
	f4_arg0:beginAnimation("textScrollingEndPauseState", f4_arg0.pauseTime)
end

CoD.ScrollableTextContainer.ScrollingStartPauseStateComplete = function (f5_arg0, f5_arg1)
	f5_arg0:setTopBottom(true, true, 0, 0)
	f5_arg0:beginAnimation("textMoveUpState", f5_arg0.totalScrollingTime)
	f5_arg0:setTopBottom(true, true, -f5_arg0.verticalTextDisplacement, -f5_arg0.verticalTextDisplacement)
end

CoD.ScrollableTextContainer.ScrollingStartPauseState = function (f6_arg0)
	f6_arg0:setTopBottom(true, true, 0, 0)
	f6_arg0:beginAnimation("textScrollingStartPauseState", f6_arg0.pauseTime)
	f6_arg0:setTopBottom(true, true, 0, 0)
end

CoD.ScrollableTextContainer.SetupScrollingText = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4, f7_arg5, f7_arg6, f7_arg7, f7_arg8)
	if f7_arg0 ~= nil and f7_arg1 ~= nil and f7_arg2 ~= 0 then
		f7_arg0:removeAllChildren()
		if f7_arg5 == nil then
			f7_arg5 = CoD.fonts.Default
		end
		if f7_arg6 == nil then
			f7_arg6 = CoD.textSize.Default
		end
		if f7_arg7 == nil then
			f7_arg7 = CoD.ScrollableTextContainer.PauseTime
		end
		if f7_arg8 == nil then
			f7_arg8 = CoD.ScrollableTextContainer.TimePerLineScroll
		end
		f7_arg0.scrollableContainer = LUI.UIElement.new()
		f7_arg0.scrollableContainer:setLeftRight(true, true, 0, 0)
		f7_arg0.scrollableContainer:setTopBottom(true, true, 0, 0)
		f7_arg0.scrollableContainer:registerEventHandler("transition_complete_textScrollingStartPauseState", CoD.ScrollableTextContainer.ScrollingStartPauseStateComplete)
		f7_arg0.scrollableContainer:registerEventHandler("transition_complete_textScrollingEndPauseState", CoD.ScrollableTextContainer.ScrollingEndPauseStateComplete)
		f7_arg0.scrollableContainer:registerEventHandler("transition_complete_textMoveUpState", CoD.ScrollableTextContainer.MoveUpStateComplete)
		f7_arg0.scrollableContainer:registerEventHandler("transition_complete_fade_out", CoD.ScrollableTextContainer.FadeOutComplete)
		f7_arg0.scrollableContainer:registerEventHandler("transition_complete_fade_in", CoD.ScrollableTextContainer.FadeInComplete)
		f7_arg0:addElement(f7_arg0.scrollableContainer)
		f7_arg0.descElement = LUI.UIText.new()
		if not f7_arg4 then
			f7_arg0.descElement:setupUITextUncached()
		end
		f7_arg0.descElement:setLeftRight(true, true, 0, 0)
		f7_arg0.descElement:setTopBottom(true, false, 0, f7_arg6)
		f7_arg0.descElement:setFont(f7_arg5)
		f7_arg0.descElement:setRGB(0.6, 0.6, 0.6)
		f7_arg0.descElement:setAlignment(LUI.Alignment.Left)
		f7_arg0.scrollableContainer:addElement(f7_arg0.descElement)
		local f7_local0 = Engine.GetNumTextLines(f7_arg1, f7_arg5, f7_arg6, f7_arg2) - math.floor(f7_arg3 / f7_arg6)
		f7_arg0.descElement:setText(f7_arg1)
		if f7_local0 > 0 then
			f7_arg0.scrollableContainer.totalScrollingTime = f7_local0 * f7_arg8
			f7_arg0.scrollableContainer.pauseTime = f7_arg7
			f7_arg0.scrollableContainer.verticalTextDisplacement = f7_local0 * CoD.textSize.Default
			f7_arg0.scrollableContainer:completeAnimation()
			CoD.ScrollableTextContainer.ScrollingStartPauseState(f7_arg0.scrollableContainer)
		end
	end
end

