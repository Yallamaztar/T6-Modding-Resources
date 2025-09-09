require("T6.PipContainer")
CoD.LoadBlocks = {}
CoD.LoadBlocks.DefaultLeft = CoD.VisorLeftBracket.BracketWidth
CoD.LoadBlocks.DefaultTop = CoD.VisorLeftBracket.BracketHeight
CoD.LoadBlocks.AppearTime = 50
CoD.LoadBlocks.DisappearTime = 50
CoD.LoadBlocks.FadeInTime = 200
CoD.LoadBlocks.FadeOutTime = 200
CoD.LoadBlocks.BlockMaterial = "menu_vis_diamond"
CoD.LoadBlocks.BracketMaterial = "menu_vis_bracket"
CoD.LoadBlocks.BracketLeftMaterial = "menu_vis_bracket_left"
CoD.LoadBlocks.DefaultAlpha = 1
CoD.LoadBlocks.BracketAlpha = 0.5
CoD.LoadBlocks.BlockAlpha = 0.5
CoD.LoadBlocks.BootupRowCount = 3
CoD.LoadBlocks.BootupColCount = 3
CoD.LoadBlocks.BootupGridSize = 7
CoD.LoadBlocks.BootupGridSpacing = CoD.LoadBlocks.BootupGridSize / 2
CoD.LoadBlocks.BootupWidth = (CoD.LoadBlocks.BootupGridSize + CoD.LoadBlocks.BootupGridSpacing) * (CoD.LoadBlocks.BootupRowCount + 1)
CoD.LoadBlocks.BootupHeight = (CoD.LoadBlocks.BootupGridSize + CoD.LoadBlocks.BootupGridSpacing) * (CoD.LoadBlocks.BootupColCount + 1)
CoD.LoadBlocks.new = function (f1_arg0)
	local f1_local0 = -38
	local f1_local1 = -42
	local Widget = LUI.UIElement.new({
		leftAnchor = true,
		rightAnchor = false,
		left = CoD.LoadBlocks.DefaultLeft + CoD.LoadBlocks.BootupWidth / 2 + f1_local1,
		right = CoD.LoadBlocks.DefaultLeft + CoD.LoadBlocks.BootupWidth * 1.5 + f1_local1,
		topAnchor = false,
		bottomAnchor = false,
		top = -CoD.VisorLeftBracket.BracketHeight / 2 + CoD.LoadBlocks.BootupHeight / 2 + f1_local0,
		bottom = -CoD.VisorLeftBracket.BracketHeight / 2 + CoD.LoadBlocks.BootupHeight * 1.5 + f1_local0,
		alpha = CoD.LoadBlocks.DefaultAlpha
	})
	Widget.id = Widget.id .. ".PipBlockContainer"
	Widget.visible = true
	Widget:registerEventHandler("resize_pip_fullscreen", CoD.LoadBlocks.ResizePipFullscreen)
	Widget:registerEventHandler("dispatch_fullscreen_to_pip", CoD.LoadBlocks.DispatchFullscreenToPip)
	Widget:registerEventHandler("default_anim", CoD.LoadBlocks.DefaultAnimation)
	Widget:registerEventHandler("toggle_visibility", CoD.LoadBlocks.ToggleVisibility)
	Widget:registerEventHandler("hide_block_container", CoD.LoadBlocks.HideBlockContainer)
	Widget:registerEventHandler("show_block_container", CoD.LoadBlocks.ShowBlockContainer)
	Widget:registerEventHandler("bootup_switch_to_hud", CoD.LoadBlocks.BootupSwitchToHUD)
	Widget.pipContainer = CoD.PipContainer.new(f1_arg0)
	Widget:addElement(Widget.pipContainer)
	return Widget
end

CoD.LoadBlocks.DispatchFullscreenToPip = function (f2_arg0, f2_arg1)
	f2_arg0.pipContainer:processEvent({
		name = "fullscreen_animate",
		duration = f2_arg1.duration
	})
end

CoD.LoadBlocks.ResizePipFullscreen = function (f3_arg0, f3_arg1)
	local f3_local0 = 0
	local f3_local1 = 1280
	local f3_local2 = 720
	f3_arg0:beginAnimation("fullscreen_pip", f3_local0)
	f3_arg0:setLeftRight(false, false, -f3_local1 / 2, f3_local1 / 2)
	f3_arg0:setTopBottom(false, false, -f3_local2 / 2, f3_local2 / 2)
	f3_arg0:addElement(LUI.UITimer.new(f3_local0, {
		name = "dispatch_fullscreen_to_pip",
		duration = f3_arg1.duration
	}, true, f3_arg0))
end

CoD.LoadBlocks.ToggleVisibility = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg1.duration or 1000
	if f4_arg0.visible then
		f4_arg0:beginAnimation("hide", f4_local0)
		f4_arg0:setAlpha(0)
		f4_arg0.visible = nil
	else
		f4_arg0:beginAnimation("show", f4_local0)
		f4_arg0:setAlpha(CoD.LoadBlocks.DefaultAlpha)
		f4_arg0.visible = true
	end
end

CoD.LoadBlocks.DefaultAnimation = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1.duration or 500
	local f5_local1 = -38
	local f5_local2 = -42
	f5_arg0:beginAnimation("default", f5_local0)
	f5_arg0:setLeftRight(true, false, CoD.LoadBlocks.DefaultLeft + CoD.LoadBlocks.BootupWidth / 2 + f5_local2, CoD.LoadBlocks.DefaultLeft + CoD.LoadBlocks.BootupWidth * 1.5 + f5_local2)
	f5_arg0:setTopBottom(false, false, -CoD.VisorLeftBracket.BracketHeight / 2 + CoD.LoadBlocks.BootupHeight / 2 + f5_local1, -CoD.VisorLeftBracket.BracketHeight / 2 + CoD.LoadBlocks.BootupHeight * 1.5 + f5_local1)
	f5_arg0:setAlpha(CoD.LoadBlocks.DefaultAlpha)
end

CoD.LoadBlocks.HideBlockContainer = function (f6_arg0, f6_arg1)
	f6_arg0:dispatchEventToParent({
		name = "hide_objective_text",
		duration = f6_arg1.duration
	})
end

CoD.LoadBlocks.ShowBlockContainer = function (f7_arg0, f7_arg1)
	f7_arg0:dispatchEventToParent({
		name = "show_objective_text",
		duration = f7_arg1.duration
	})
end

CoD.LoadBlocks.CreateSmallGrid = function (f8_arg0, f8_arg1, f8_arg2)
	local f8_local0 = CoD.VisorImage.new(CoD.LoadBlocks.BlockMaterial, f8_arg0)
	f8_local0.id = f8_local0.id .. ".BoxImage_Row_" .. f8_arg1 .. "_Col_" .. f8_arg2
	f8_local0:registerAnimationState("hide", {
		alpha = 0
	})
	f8_local0:registerAnimationState("show", {
		alpha = 0.5
	})
	f8_local0:registerAnimationState("idle", {
		alpha = 0.5
	})
	f8_local0:registerAnimationState("fade_in", {
		alpha = CoD.LoadBlocks.BlockAlpha
	})
	return f8_local0
end

CoD.LoadBlocks.BootupSwitchToHUD = function (f9_arg0, f9_arg1)

end

