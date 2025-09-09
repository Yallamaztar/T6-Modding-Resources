require("T6.Overlay")
require("T6.AccordionGroups")
CoD.NavOverlay = {}
CoD.NavOverlay.SlideInTime = 150
CoD.NavOverlay.SlideOutTime = 150
CoD.NavOverlay.new = function (f1_arg0, f1_arg1)
	local f1_local0 = f1_arg1:getMaxHeight()
	f1_arg1:registerAnimationState("offscreen", {
		top = f1_local0,
		bottom = 0,
		topAnchor = true,
		bottomAnchor = false
	})
	f1_arg1:animateToState("offscreen")
	local f1_local1 = CoD.Overlay.new(f1_arg0, {
		left = 0,
		top = -f1_local0,
		right = 0,
		bottom = -f1_arg0.bottomBorderHeight,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = true
	})
	f1_local1.navContainer = LUI.UIContainer.new()
	f1_local1:addElement(f1_local1.navContainer)
	f1_local1.navContainer:setUseStencil(true)
	f1_local1.infoPaneHeight = LUI.UIHeight - f1_local0
	f1_local1.infoPane = LUI.UIElement.new({
		left = 0,
		top = -f1_local1.infoPaneHeight,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f1_local1:addElement(f1_local1.infoPane)
	f1_local1.infoPane:registerAnimationState("fade_out", {
		alphaMultiplier = 0
	})
	f1_local1.infoPane:registerAnimationState("fade_in", {
		alphaMultiplier = 1
	})
	f1_local1.infoPane:animateToState("fade_out")
	f1_local1.accordionGroups = f1_arg1
	f1_local1.navContainer:addElement(f1_arg1)
	f1_local1:registerEventHandler("overlay_opened", CoD.NavOverlay.Opened)
	f1_local1:registerEventHandler("overlay_closing", CoD.NavOverlay.Closing)
	f1_local1:registerEventHandler("button_prompt_back", CoD.NavOverlay.Close)
	return f1_local1
end

CoD.NavOverlay.Opened = function (f2_arg0, f2_arg1)
	f2_arg0.accordionGroups:animateToState("default", CoD.NavOverlay.SlideInTime)
	f2_arg0.infoPane:animateToState("fade_in", CoD.NavOverlay.SlideInTime)
end

CoD.NavOverlay.Close = function (f3_arg0, f3_arg1)
	f3_arg0.infoPane:animateToState("fade_out", CoD.NavOverlay.SlideOutTime)
	f3_arg0.accordionGroups:animateToState("offscreen", CoD.NavOverlay.SlideOutTime)
	f3_arg0:addElement(LUI.UITimer.new(CoD.NavOverlay.SlideOutTime, "overlay_closing", true))
end

CoD.NavOverlay.Closing = function (f4_arg0, f4_arg1)
	CoD.Overlay.Close(f4_arg0)
end

