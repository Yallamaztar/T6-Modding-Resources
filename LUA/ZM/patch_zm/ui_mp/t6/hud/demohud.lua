require("T6.HUD.DemoHighlightReel")
CoD.DemoHUD = {}
CoD.DEMO_INFORMATION_SCREEN_NONE = 0
CoD.DEMO_INFORMATION_SCREEN_FILM_START_SCREEN_FADE_IN = 1
CoD.DEMO_INFORMATION_SCREEN_FILM_START_SCREEN_FADE_OUT = 2
CoD.DEMO_INFORMATION_SCREEN_TRANSITION = 3
CoD.DEMO_INFORMATION_SCREEN_WAITING_FOR_DOWNLOAD = 4
CoD.DemoHUD.LastActivatedInformationScreen = CoD.DEMO_INFORMATION_SCREEN_NONE
CoD.DemoHUD.AddHUDWidgets = function (f1_arg0, f1_arg1)
	local f1_local0 = UIExpression.IsDemoPlaying()
	local f1_local1 = f1_arg1.controller
	if f1_local0 == 0 then
		return 
	end
	f1_arg0:addElement(LUI.createMenu.DemoControls(f1_local1))
	CoD.DemoHUD.AddInformationScreen(f1_arg0)
	CoD.DemoHUD.AddDollyCamPictureWindow(f1_arg0, f1_local1)
	if Engine.IsDemoShoutcaster() == true then
		if f1_arg0.SpectateHUD == nil then
			f1_arg0:processEvent({
				name = "hud_update_spectate",
				controller = f1_local1
			})
		end
		f1_arg0:processEvent({
			name = "hud_update_spectate",
			controller = f1_local1
		})
	end
	if f1_arg1.activateDemoStartScreen then
		if CoD.DemoHUD.LastActivatedInformationScreen ~= CoD.DEMO_INFORMATION_SCREEN_FILM_START_SCREEN_FADE_OUT then
			CoD.DemoHUD.ActivateInformationScreen(f1_arg0, {
				controller = f1_local1,
				informationScreenType = CoD.DEMO_INFORMATION_SCREEN_FILM_START_SCREEN_FADE_IN,
				animationTime = 0,
				animationState = "fade_in"
			})
		end
	elseif f1_arg1.openHighlightStartScreen then
		CoD.DemoHighlightReel.OpenStartHighlightReel(f1_arg0, f1_arg1)
	end
end

CoD.DemoHUD.ActivateInformationScreen = function (f2_arg0, f2_arg1)
	CoD.DemoHUD.LastActivatedInformationScreen = f2_arg1.informationScreenType
	if LUI.roots.UIRootFull.demoInformationScreenBlackBackground == nil then
		return 
	elseif f2_arg1 == nil then
		return 
	end
	local f2_local0 = "fade_out"
	if f2_arg1.animationState ~= nil then
		f2_local0 = f2_arg1.animationState
	end
	if f2_arg1.informationScreenType == CoD.DEMO_INFORMATION_SCREEN_NONE then
		return 
	elseif f2_arg1.informationScreenType == CoD.DEMO_INFORMATION_SCREEN_FILM_START_SCREEN_FADE_IN or f2_arg1.informationScreenType == CoD.DEMO_INFORMATION_SCREEN_FILM_START_SCREEN_FADE_OUT then
		LUI.roots.UIRootFull.demoInformationScreenBlackBackground:animateToState(f2_local0, f2_arg1.animationTime)
		LUI.roots.UIRootFull.demoInformationScreenInformationText:setText(Engine.Localize("MENU_PREPARING"))
		LUI.roots.UIRootFull.demoInformationScreenInformationText:animateToState(f2_local0, f2_arg1.animationTime * 0.8)
		LUI.roots.UIRootFull.demoInformationScreenSpinner:animateToState(f2_local0, f2_arg1.animationTime * 0.8)
		if Engine.IsDemoShoutcaster() and f2_arg1.informationScreenType == CoD.DEMO_INFORMATION_SCREEN_FILM_START_SCREEN_FADE_OUT then
			f2_arg0:processEvent({
				name = "reload_shoutcaster_hud",
				controller = f2_arg1.controller
			})
		end
	end
	if f2_arg1.informationScreenType == CoD.DEMO_INFORMATION_SCREEN_TRANSITION then
		LUI.roots.UIRootFull.demoInformationScreenInformationText:setText("")
		LUI.roots.UIRootFull.demoInformationScreenInformationText:setAlpha(0)
		LUI.roots.UIRootFull.demoInformationScreenSpinner:setAlpha(0)
		LUI.roots.UIRootFull.demoInformationScreenBlackBackground:setAlpha(1)
		LUI.roots.UIRootFull.demoInformationScreenBlackBackground:animateToState(f2_local0, f2_arg1.animationTime)
	end
	if f2_arg1.informationScreenType == CoD.DEMO_INFORMATION_SCREEN_WAITING_FOR_DOWNLOAD then
		LUI.roots.UIRootFull.demoInformationScreenBlackBackground:animateToState("fade_out", f2_arg1.animationTime)
		LUI.roots.UIRootFull.demoInformationScreenInformationText:animateToState(f2_local0, f2_arg1.animationTime)
		LUI.roots.UIRootFull.demoInformationScreenInformationText:setText(Engine.Localize("MENU_BUFFERING"))
		LUI.roots.UIRootFull.demoInformationScreenSpinner:animateToState(f2_local0, f2_arg1.animationTime)
	end
end

CoD.DemoHUD.AddInformationScreen = function (f3_arg0)
	if LUI.roots.UIRootFull.demoInformationScreenContainer then
		return 
	else
		local f3_local0 = LUI.UIContainer.new()
		f3_local0:setPriority(100)
		local f3_local1 = LUI.UIImage.new({
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
			alpha = 0
		})
		f3_local1:registerAnimationState("fade_in", {
			alpha = 1
		})
		f3_local1:registerAnimationState("fade_out", {
			alpha = 0
		})
		LUI.roots.UIRootFull.demoInformationScreenBlackBackground = f3_local1
		f3_local0:addElement(f3_local1)
		local f3_local2 = LUI.UIText.new({
			left = 0,
			top = -CoD.textSize.Condensed / 2,
			right = 0,
			bottom = CoD.textSize.Condensed / 2,
			leftAnchor = true,
			topAnchor = false,
			rightAnchor = true,
			bottomAnchor = false,
			font = CoD.fonts.Condensed,
			alignment = LUI.Alignment.Center,
			red = 1,
			green = 1,
			blue = 1,
			alpha = 0
		})
		f3_local2:registerAnimationState("fade_in", {
			alpha = 1
		})
		f3_local2:registerAnimationState("fade_out", {
			alpha = 0
		})
		LUI.roots.UIRootFull.demoInformationScreenInformationText = f3_local2
		f3_local0:addElement(f3_local2)
		local f3_local3 = 60
		local f3_local4 = LUI.UIImage.new({
			left = -f3_local3 / 2,
			top = CoD.textSize.Condensed,
			right = f3_local3 / 2,
			bottom = CoD.textSize.Condensed + f3_local3,
			leftAnchor = false,
			topAnchor = false,
			rightAnchor = false,
			bottomAnchor = false,
			red = 1,
			green = 1,
			blue = 1,
			alpha = 0,
			material = RegisterMaterial("lui_loader")
		})
		f3_local4:setShaderVector(0, 0, 0, 0, 0)
		f3_local4:registerAnimationState("fade_in", {
			alpha = 1
		})
		f3_local4:registerAnimationState("fade_out", {
			alpha = 0
		})
		LUI.roots.UIRootFull.demoInformationScreenSpinner = f3_local4
		f3_local0:addElement(f3_local4)
		LUI.roots.UIRootFull:addElement(f3_local0)
		LUI.roots.UIRootFull.demoInformationScreenContainer = f3_local0
	end
end

LUI.createMenu.DemoControls = function (f4_arg0)
	local f4_local0 = CoD.Menu.NewSafeAreaFromState("DemoControls", f4_arg0)
	local f4_local1 = 492
	local f4_local2 = 94
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f4_local1 / 2, f4_local1 / 2)
	Widget:setTopBottom(false, true, -f4_local2 - 6, -6)
	Widget:setupDemoControls()
	f4_local0:addElement(Widget)
	return f4_local0
end

CoD.DemoHUD.DollyCamPictureWindowUpdateVisibility = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg1.controller
	if UIExpression.IsVisibilityBitSet(f5_local0, CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN) == 0 and UIExpression.IsDemoPlaying(f5_local0) > 0 and UIExpression.IsDemoCameraEditMode(f5_local0) > 0 and UIExpression.GetDollyCamMarkerCount(f5_local0) > 0 and UIExpression.IsDemoClipPreviewRunning(f5_local0) == 0 then
		if not f5_arg0.visible then
			f5_arg0:setAlpha(1)
			f5_arg0.visible = true
		end
	elseif f5_arg0.visible then
		f5_arg0:setAlpha(0)
		f5_arg0.visible = nil
	end
end

CoD.DemoHUD.UpdateDollyCamPictureWindowInformation = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0:getParent()
	local f6_local1 = UIExpression.GetDollyCamMarkerInformationForTime(f6_arg1.controller, "previewMarkerDisplayName")
	if f6_local1 ~= f6_local0.previewCameraText then
		if f6_local1 == "" then
			f6_local0.gameTimer:setTopBottom(true, false, 10, 30)
			f6_local0.previewCameraTitle:setAlpha(0)
		else
			f6_local0.gameTimer:setTopBottom(true, false, 35, 55)
			f6_local0.previewCameraTitle:setText(f6_local1)
			f6_local0.previewCameraTitle:setAlpha(1)
			f6_local0.previewCameraSpeedTitle:setText(UIExpression.GetDollyCamMarkerInformationForTime(f6_arg1.controller, "timeScaleModeAndInterpolatedValue"))
			f6_local0.previewCameraSpeedTitle:setAlpha(1)
		end
		f6_local0.previewCameraText = f6_local1
	end
	if 0 < Engine.CurrentGameTime() then
		f6_arg0:setTimeLeft(Engine.CurrentGameTime(), true)
	end
end

CoD.DemoHUD.AddDollyCamPictureWindow = function (f7_arg0, f7_arg1)
	local f7_local0 = LUI.UIContainer.new()
	local f7_local1 = LUI.UIImage.new({
		left = 4,
		top = 4,
		right = 240,
		bottom = 240,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		red = 0,
		green = 0,
		blue = 0,
		alpha = 1,
		material = RegisterMaterial("demo_timeline_faded")
	})
	f7_local1:setPriority(-100)
	f7_local0:addElement(f7_local1)
	local f7_local2 = LUI.UIImage.new({
		left = 7,
		top = 7,
		right = 237,
		bottom = 237,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1,
		material = RegisterMaterial("dollycam2d")
	})
	f7_local2:setPriority(-50)
	f7_local0:addElement(f7_local2)
	f7_local0.gameTimer = CoD.DistFieldText.new({
		left = 10,
		top = 10,
		right = 237,
		bottom = 30,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1
	}, nil, nil, -1, -1, 0.08)
	CoD.CountdownTimer.Setup(f7_local0.gameTimer, 0, true)
	f7_local0.gameTimer:registerEventHandler("countdown_tick", CoD.DemoHUD.UpdateDollyCamPictureWindowInformation)
	f7_local0:addElement(f7_local0.gameTimer)
	f7_local0.previewCameraTitle = LUI.UIText.new({
		left = 10,
		top = 10,
		right = 237,
		bottom = 30,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0
	})
	f7_local0:addElement(f7_local0.previewCameraTitle)
	f7_local0.previewCameraSpeedTitle = LUI.UIText.new({
		left = 10,
		top = 215,
		right = 237,
		bottom = 235,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0
	})
	f7_local0:addElement(f7_local0.previewCameraSpeedTitle)
	f7_arg0.safeArea:addElement(f7_local0)
	f7_local0.gameTimer:setTimeLeft(100000)
	f7_local0.visible = true
	f7_local0.previewCameraText = nil
	CoD.DemoHUD.DollyCamPictureWindowUpdateVisibility(f7_local0, {
		controller = f7_arg1
	})
	f7_local0:registerEventHandler("update_dollycam_window_visibility", CoD.DemoHUD.DollyCamPictureWindowUpdateVisibility)
	f7_local0:registerEventHandler("hud_update_bit_" .. CoD.BIT_DEMO_ALL_GAME_HUD_HIDDEN, CoD.DemoHUD.DollyCamPictureWindowUpdateVisibility)
end

