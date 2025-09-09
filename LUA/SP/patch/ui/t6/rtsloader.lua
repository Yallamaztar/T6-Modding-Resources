CoD.RTSLoader = {}
CoD.RTSLoader.MovementTime = 600
CoD.RTSLoader.TextFont = "Default"
CoD.RTSLoader.TextSize = CoD.textSize.Default
CoD.RTSLoader.ElementWidth = 350
CoD.RTSLoader.OnScreenTime = 8000
CoD.RTSLoader.StaggerTime = 2000
CoD.RTSLoader.InBetweenTime = CoD.RTSLoader.MovementTime
CoD.RTSLoader.TimeUntilOff = CoD.RTSLoader.OnScreenTime - CoD.RTSLoader.InBetweenTime
CoD.RTSLoader.FloatingSpeck = "hud_strikeforce_white_dot"
CoD.RTSLoader.SpeckPointCenters = {
	{
		x = 300,
		y = 100
	},
	{
		x = -500,
		y = 200
	},
	{
		x = 400,
		y = -200
	},
	{
		x = 100,
		y = -60
	},
	{
		x = -200,
		y = 40
	},
	{
		x = 300,
		y = 230
	},
	{
		x = 0,
		y = 100
	}
}
CoD.RTSLoader.MaxSpeckRange = 50
CoD.RTSLoader.SpeckAspectRatio = 0.5
CoD.RTSLoader.AspectRatio = Engine.GetAspectRatio()
local f0_local0 = CoD.RTSLoader
local f0_local1
if CoD.RTSLoader.AspectRatio <= 1.69 or CoD.RTSLoader.AspectRatio >= 1.87 then
	f0_local1 = false
else
	f0_local1 = true
end
f0_local0.IsWideScreen = f0_local1
CoD.RTSLoader.Left = CoD.RTSLoader.IsWideScreen and 200 or 40
CoD.RTSLoader.StandardTitleColor = CoD.offWhite
CoD.RTSLoader.StandardDescriptionColor = CoD.RTSColors.blue
CoD.RTSLoader.PrimaryDescriptionColor = CoD.RTSColors.yellow
CoD.RTSLoader.HeaderBackground = {
	r = 0.2,
	g = 0.2,
	b = 0.2
}
CoD.RTSLoader.Black = {
	r = 0,
	g = 0,
	b = 0
}
CoD.RTSLoader.ElementSpacing = 50
CoD.RTSLoader.BriefingBarTop = 80
CoD.RTSLoader.ObjectiveTop = CoD.RTSLoader.BriefingBarTop + 120
CoD.RTSLoader.InitBackground = "hud_strikeforce_bits_rectangle"
CoD.RTSLoader.LoadingBarBack = "hud_strikeforce_green_bar"
CoD.RTSLoader.LoadingBarFill = "hud_strikeforce_green_bar_fill"
CoD.RTSLoader.MissionBriefingBar = "hud_strikeforce_mission_red_bar"
CoD.RTSLoader.CompleteLoadBar = "hud_strikeforce_complete_green_bar"
CoD.RTSLoader.InitializingBar = "hud_strikeforce_initiat_red_bar"
CoD.RTSLoader.SpinningWheel = "hud_strikeforce_refill_circle"
CoD.RTSLoader.Background = "hud_strikeforce_background"
CoD.RTSLoader.TargetReticle = "hud_strikeforce_yellow_target_circle"
CoD.RTSLoader.TargetPulse = "hud_strikeforce_red_circle_line"
CoD.RTSLoader.MapBottomBar = "hud_strikeforce_map_bar"
CoD.RTSLoader.HeaderTextGrid = "hud_strikeforce_square_grid"
CoD.RTSLoader.IndicatorPinkTriangle = "hud_strikeforce_pink_triangle"
CoD.RTSLoader.new = function (f1_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	Widget:setAlpha(1)
	local f1_local1 = LUI.UIImage.new()
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, true, 0, 0)
	f1_local1:setRGB(0, 0, 0)
	Widget:addElement(f1_local1)
	Engine.PlaySound("bik_rts_ui_sfx")
	local f1_local2, f1_local3 = Engine.GetUserSafeArea()
	Widget.safeAreaHeight = f1_local3
	Widget.safeAreaWidth = f1_local2
	Widget.safeAreaLeft = -Widget.safeAreaWidth / 2
	Widget.safeAreaTop = -Widget.safeAreaHeight / 2
	Widget.levelName = f1_arg0
	if f1_arg0 and CoD.RTSLoader.LevelFunctions[f1_arg0] then
		Widget.animationData = CoD.RTSLoader.LevelFunctions[f1_arg0](Widget)
	else
		if f1_arg0 == nil then
			f1_arg0 = "nil"
		end
		DebugPrint("found unknown map name in RTSLoader of " .. f1_arg0 .. ". Using default map of dockside (singapore)")
		Widget.animationData = CoD.RTSLoader.LevelFunctions.so_rts_mp_dockside(Widget)
	end
	Widget:registerEventHandler("pause_bink", CoD.RTSLoader.PauseBink)
	Widget:registerEventHandler("bink_complete", CoD.RTSLoader.CreateInitialization)
	Widget:registerEventHandler("loading_complete", CoD.RTSLoader.BeginObjectiveAnimationQueue)
	Widget:registerEventHandler("remove_loading_screen", CoD.RTSLoader.LevelLoaded)
	CoD.RTSLoader.StartBink(Widget)
	Widget.close = CoD.RTSLoader.close
	return Widget
end

CoD.RTSLoader.StartBink = function (f2_arg0)
	local f2_local0 = 720
	local f2_local1 = f2_local0 * 16 / 9
	local f2_local2 = LUI.UIImage.new()
	f2_local2:setLeftRight(false, false, -f2_local1 / 2, f2_local1 / 2)
	f2_local2:setTopBottom(false, false, -f2_local0 / 2, f2_local0 / 2)
	f2_local2:setImage(RegisterMaterial("webm_720p"))
	f2_local2:setShaderVector(0, 0, 0, 0, 0)
	f2_local2:setAlpha(0)
	f2_arg0:addElement(f2_local2)
	f2_local2.id = f2_local2.id .. ".BinkImage"
	f2_arg0.binkImage = f2_local2
	f2_local2.cinematicId = Engine.StartLoadingCinematic("strike_force_bootup", false)
	f2_arg0:registerEventHandler("bink_check_time", CoD.RTSLoader.BinkCheckTime)
	f2_arg0:addElement(LUI.UITimer.new(16, "bink_check_time", true, f2_arg0))
end

CoD.RTSLoader.BinkCheckTime = function (f3_arg0, f3_arg1)
	if Engine.IsCinematicPreloading(f3_arg0.binkImage.cinematicId) == false then
		f3_arg0.binkImage:setAlpha(1)
		local f3_local0 = Engine.GetCinematicTimeRemaining(f3_arg0.binkImage.cinematicId)
		f3_arg0:addElement(LUI.UITimer.new((f3_local0 - 0.5) * 1000, "pause_bink", true, f3_arg0))
		f3_arg0:addElement(LUI.UITimer.new((f3_local0 - 4.5) * 1000, "bink_complete", true, f3_arg0))
	else
		f3_arg0:addElement(LUI.UITimer.new(16, "bink_check_time", true))
	end
end

CoD.RTSLoader.PauseBink = function (f4_arg0, f4_arg1)
	if f4_arg0.binkImage then
		Engine.Pause3DCinematic(f4_arg0.binkImage.cinematicId)
	end
end

CoD.RTSLoader.LevelLoaded = function (f5_arg0, f5_arg1)
	f5_arg0:dispatchEventToParent({
		name = "briefing_startplay"
	})
end

CoD.RTSLoader.RepositionSpeck = function (f6_arg0, f6_arg1)
	if f6_arg1 == nil then
		f6_arg1 = 500
	end
	local f6_local0 = f6_arg0.centerX + math.random(-CoD.RTSLoader.MaxSpeckRange, CoD.RTSLoader.MaxSpeckRange)
	local f6_local1 = f6_arg0.centerY + math.random(-CoD.RTSLoader.MaxSpeckRange, CoD.RTSLoader.MaxSpeckRange)
	f6_arg0:beginAnimation("move", f6_arg1)
	f6_arg0:setLeftRight(false, false, f6_local0 - f6_arg0.width / 2, f6_local0 + f6_arg0.width / 2)
	f6_arg0:setTopBottom(false, false, f6_local1 - f6_arg0.height / 2, f6_local1 + f6_arg0.height / 2)
	if f6_arg1 > 0 and not f6_arg0.visible then
		f6_arg0.visible = true
		f6_arg0:setAlpha(1)
	end
end

CoD.RTSLoader.GenerateSpecks = function (f7_arg0)
	local f7_local0 = LUI.UIContainer.new()
	for f7_local11, f7_local12 in ipairs(CoD.RTSLoader.SpeckPointCenters) do
		local f7_local13 = math.random(1, 7)
		local Widget = LUI.UIElement.new()
		Widget.centerX = f7_local12.x
		Widget.centerY = f7_local12.y
		Widget.width = math.random(2 * f7_local13, 4 * f7_local13)
		Widget.height = math.random(2 * f7_local13, 4 * f7_local13)
		Widget:setAlpha(0)
		for f7_local10 = 1, f7_local13, 1 do
			local f7_local4 = f7_local10
			local f7_local5 = LUI.UIImage.new()
			local f7_local6 = (math.random() - 0.5) * Widget.width
			local f7_local7 = (math.random() - 0.5) * Widget.height
			local f7_local8 = math.random(2, 4)
			local f7_local9 = math.random(2, 4)
			f7_local5:setLeftRight(false, false, f7_local6 - f7_local8 / 2, f7_local6 + f7_local8 / 2)
			f7_local5:setTopBottom(false, false, f7_local7 - f7_local9 / 2, f7_local7 + f7_local9 / 2)
			f7_local5:setImage(RegisterMaterial(CoD.RTSLoader.FloatingSpeck))
			f7_local5:setAlpha(math.random() * 0.3 + 0.3)
			Widget:addElement(f7_local5)
		end
		CoD.RTSLoader.RepositionSpeck(Widget, 0)
		Widget:alternateStates(0, CoD.RTSLoader.RepositionSpeck, CoD.RTSLoader.RepositionSpeck, 6000, 7500)
		f7_local0:addElement(Widget)
	end
	f7_arg0:addElement(f7_local0)
end

CoD.RTSLoader.CreateInitialization = function (f8_arg0, f8_arg1)
	CoD.RTSLoader.GenerateSpecks(f8_arg0)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, CoD.RTSLoader.Left - 15, CoD.RTSLoader.Left + CoD.RTSLoader.ElementWidth)
	Widget:setTopBottom(true, false, CoD.RTSLoader.BriefingBarTop, CoD.RTSLoader.BriefingBarTop + 100)
	local f8_local1 = LUI.UIImage.new()
	f8_local1:setImage(RegisterMaterial(CoD.RTSLoader.SpinningWheel))
	f8_local1.size = 100
	local f8_local2 = f8_local1.size * 0.75
	f8_local1:setLeftRight(true, false, -f8_local1.size / 2 - f8_local2 / 2, -f8_local1.size / 2 + f8_local2 / 2)
	f8_local1:setTopBottom(false, false, -f8_local2 / 2, f8_local2 / 2)
	f8_local1:setZRot(270)
	Widget:addElement(f8_local1)
	local f8_local3 = LUI.UIImage.new()
	f8_local3:setLeftRight(true, true, 0, 0)
	f8_local3:setTopBottom(true, true, 0, 0)
	f8_local3:setImage(RegisterMaterial(CoD.RTSLoader.InitBackground))
	Widget:addElement(f8_local3)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 15, CoD.RTSLoader.ElementWidth * 0.6)
	Widget:setTopBottom(true, false, 50 - CoD.RTSLoader.TextSize, 50)
	Widget:addElement(Widget)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, CoD.RTSLoader.ElementWidth * 0.5, CoD.RTSLoader.ElementWidth + 13)
	Widget:setTopBottom(true, false, 50 - CoD.RTSLoader.TextSize, 50)
	Widget:addElement(Widget)
	local f8_local6 = LUI.UIImage.new()
	f8_local6:setLeftRight(true, true, 0, 0)
	f8_local6:setTopBottom(true, true, 0, 0)
	f8_local6:setImage(RegisterMaterial(CoD.RTSLoader.MissionBriefingBar))
	Widget:addElement(f8_local6)
	local f8_local7 = LUI.UIText.new()
	f8_local7:setLeftRight(true, true, 5, -15)
	f8_local7:setTopBottom(false, false, -CoD.RTSLoader.TextSize / 2, CoD.RTSLoader.TextSize / 2)
	f8_local7:setAlignment(LUI.Alignment.Left)
	f8_local7:setText(Engine.Localize("RTS_LOADING_SCREENS_MISSION_BRIEFING_CAPS"))
	Widget:addElement(f8_local7)
	local f8_local8 = 9
	local f8_local9 = LUI.UIImage.new()
	f8_local9:setLeftRight(true, false, 37 - f8_local8, 37 + f8_local8)
	f8_local9:setTopBottom(false, true, -f8_local8, 0)
	f8_local9:setImage(RegisterMaterial(CoD.RTSLoader.IndicatorPinkTriangle))
	Widget:addElement(f8_local9)
	local f8_local10 = LUI.UIImage.new()
	f8_local10:setLeftRight(true, true, 0, 0)
	f8_local10:setTopBottom(true, true, 0, 0)
	f8_local10:setImage(RegisterMaterial(CoD.RTSLoader.InitializingBar))
	Widget:addElement(f8_local10)
	local f8_local11 = LUI.UIText.new()
	f8_local11:setLeftRight(true, true, 15, -5)
	f8_local11:setTopBottom(false, false, -CoD.RTSLoader.TextSize / 2, CoD.RTSLoader.TextSize / 2)
	f8_local11:setAlignment(LUI.Alignment.Right)
	f8_local11:setText(Engine.Localize("RTS_LOADING_SCREENS_INITIALIZING_CAPS"))
	Widget:addElement(f8_local11)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 15, -2)
	Widget:setTopBottom(true, false, 57, 73)
	Widget:addElement(Widget)
	local f8_local13 = LUI.UIImage.new()
	f8_local13:setLeftRight(true, true, 0, 0)
	f8_local13:setTopBottom(true, true, 0, 0)
	f8_local13:setImage(RegisterMaterial(CoD.RTSLoader.LoadingBarFill))
	f8_local13:setAlpha(0.5)
	Widget:addElement(f8_local13)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, 5, 0)
	Widget:setTopBottom(false, false, -3, 3)
	Widget:setUseStencil(true)
	Widget:addElement(Widget)
	local f8_local15 = LUI.UIImage.new()
	f8_local15:setLeftRight(true, true, -5, 5)
	f8_local15:setTopBottom(true, true, -5, 5)
	f8_local15:setImage(RegisterMaterial(CoD.RTSLoader.LoadingBarFill))
	f8_local15:setAlpha(1)
	Widget:addElement(f8_local15)
	Widget.stencil = Widget
	Widget.statusText = f8_local11
	Widget.statusImage = f8_local10
	f8_arg0.loadingContainer = Widget
	Widget:registerEventHandler("loading_animation", CoD.RTSLoader.LoadBarAnimation)
	Widget:processEvent({
		name = "loading_animation",
		left = 5,
		step = 0,
		previous = 0,
		total = CoD.RTSLoader.ElementWidth - 10
	})
	f8_arg0.backgroundCenterX = CoD.RTSLoader.IsWideScreen and 250 or 150
	f8_arg0.backgroundWidth = 600
	f8_arg0.backgroundCenterY = 0
	f8_arg0.backgroundHeight = 600
	if f8_arg0.levelName == "so_rts_mp_dockside" then
		f8_arg0.backgroundCenterX = CoD.RTSLoader.IsWideScreen and 250 or 100
	end
	f8_arg0.backgroundImage = LUI.UIStreamedImage.new({
		leftAnchor = false,
		rightAnchor = false,
		topAnchor = false,
		bottomAnchor = false,
		left = f8_arg0.backgroundCenterX - f8_arg0.backgroundWidth / 2,
		right = f8_arg0.backgroundCenterX + f8_arg0.backgroundWidth / 2,
		top = f8_arg0.backgroundCenterY - f8_arg0.backgroundHeight / 2,
		bottom = f8_arg0.backgroundCenterY + f8_arg0.backgroundHeight / 2,
		material = RegisterMaterial(f8_arg0.animationData.background),
		alpha = 0
	}, 15000)
	f8_arg0.backgroundImage.isBackground = true
	f8_arg0:registerEventHandler("background_loaded", CoD.RTSLoader.BackgroundLoaded)
	f8_arg0.backgroundImage:registerEventHandler("streamed_image_ready", CoD.RTSLoader.StreamedImageReady)
	f8_arg0:addElement(f8_arg0.backgroundImage)
	local f8_local16 = 70
	local f8_local17 = 50
	Widget:beginAnimation("initial")
	Widget:setLeftRight(true, false, f8_local16 + CoD.RTSLoader.Left - 15, f8_local16 + CoD.RTSLoader.Left + CoD.RTSLoader.ElementWidth)
	Widget:setTopBottom(true, false, f8_local17 + CoD.RTSLoader.BriefingBarTop, f8_local17 + CoD.RTSLoader.BriefingBarTop + 100)
	Widget:setAlpha(0)
	f8_arg0:addElement(Widget)
	Widget:beginAnimation("movement", 2000)
	Widget:setLeftRight(true, false, CoD.RTSLoader.Left - 15, CoD.RTSLoader.Left + CoD.RTSLoader.ElementWidth)
	Widget:setTopBottom(true, false, CoD.RTSLoader.BriefingBarTop, CoD.RTSLoader.BriefingBarTop + 100)
	Widget:setAlpha(1)
	f8_local1:beginAnimation("rotate_scale", 2500)
	f8_local1:setLeftRight(true, false, -f8_local1.size, 0)
	f8_local1:setTopBottom(false, false, -f8_local1.size / 2, f8_local1.size / 2)
	f8_local1:setZRot(0)
	f8_local1:registerEventHandler("spin_randomly", LUI.UIElement.spinRandomly)
	f8_local1:addElement(LUI.UITimer.new(2500, "spin_randomly", false, f8_arg0))
end

CoD.RTSLoader.close = function (f9_arg0)
	if f9_arg0.binkImage then
		Engine.Stop3DCinematic(f9_arg0.binkImage.cinematicId)
	end
	if f9_arg0.tutorial then
		f9_arg0.tutorial:close()
		f9_arg0.tutorial = nil
	end
	LUI.UIElement.close(f9_arg0)
end

CoD.RTSLoader.BeginObjectiveAnimationQueue = function (f10_arg0, f10_arg1)
	if f10_arg0.animationData == nil then
		return 
	end
	f10_arg0:registerEventHandler("completed_cycle", CoD.RTSLoader.NextAnimation)
	local f10_local0 = f10_arg0.animationData
	if f10_local0.sfx then
		Engine.PlayMenuMusic(f10_local0.sfx)
	end
	if f10_local0.primaryObjective then
		local f10_local1, f10_local2 = CoD.RTSLoader.CreateObjectiveElement(f10_local0.primaryObjective, nil, true)
		CoD.RTSLoader.AddAnimationChainToElement(f10_local1, nil, CoD.RTSLoader.Left, CoD.RTSLoader.ElementWidth, CoD.RTSLoader.ObjectiveTop, f10_local2)
		f10_arg0:addElement(f10_local1)
		f10_arg0.elementTop = CoD.RTSLoader.ObjectiveTop + f10_local2 + CoD.RTSLoader.ElementSpacing
	end
	if f10_local0.location then
		f10_arg0.currentAnimation = 0
	else
		f10_arg0.currentAnimation = 1
	end
	if f10_local0.background then
		f10_arg0.backgroundImage:beginAnimation("fade_in", 300)
		f10_arg0.backgroundImage:setAlpha(1)
	end
	f10_arg0.timer = LUI.UITimer.new(CoD.RTSLoader.MovementTime * 2, "completed_cycle", true)
	f10_arg0:addElement(f10_arg0.timer)
end

CoD.RTSLoader.StreamedImageReady = function (f11_arg0, f11_arg1)
	if f11_arg0.isBackground then
		f11_arg0:dispatchEventToParent({
			name = "background_loaded"
		})
	else
		f11_arg0:beginAnimation("fade_in", 300)
		f11_arg0:setAlpha(1)
	end
end

CoD.RTSLoader.NextAnimation = function (f12_arg0, f12_arg1)
	local f12_local0 = f12_arg0.animationData
	if f12_arg0.previousFrames then
		for f12_local4, f12_local5 in ipairs(f12_arg0.previousFrames) do
			f12_local5:close()
			f12_local5 = nil
		end
	end
	f12_arg0.previousFrames = {}
	local f12_local1 = CoD.RTSLoader.OnScreenTime
	local f12_local2 = 0
	if f12_arg0.currentAnimation == 0 then
		local f12_local3, f12_local4 = CoD.RTSLoader.CreateLocationElement(f12_local0.location)
		CoD.RTSLoader.AddAnimationChainToElement(f12_local3, CoD.RTSLoader.TimeUntilOff, CoD.RTSLoader.Left, CoD.RTSLoader.ElementWidth, -f12_arg0.safeAreaTop - f12_local4, f12_local4)
		f12_arg0:addElement(f12_local3)
		table.insert(f12_arg0.previousFrames, f12_local3)
	elseif f12_arg0.currentAnimation <= #f12_local0.objectiveBranches then
		local f12_local3 = f12_arg0.elementTop
		local f12_local4 = CoD.RTSLoader.TimeUntilOff
		if f12_local0.objectiveBranches[f12_arg0.currentAnimation].animationTime then
			f12_local4 = f12_local0.objectiveBranches[f12_arg0.currentAnimation].animationTime
			f12_local1 = f12_local4 + CoD.RTSLoader.InBetweenTime
		end
		for f12_local18, f12_local19 in ipairs(f12_local0.objectiveBranches[f12_arg0.currentAnimation].objectives) do
			local f12_local20, f12_local21 = CoD.RTSLoader.CreateObjectiveElement(f12_local19)
			f12_local20:setTopBottom(false, false, f12_local3, f12_local3 + f12_local21)
			CoD.RTSLoader.AddAnimationChainToElement(f12_local20, f12_local4, CoD.RTSLoader.Left, CoD.RTSLoader.ElementWidth, f12_local3, f12_local21, CoD.RTSLoader.StaggerTime * (f12_local18 - 1))
			f12_arg0:addElement(f12_local20)
			if f12_local19.imageSet then
				for f12_local11, f12_local12 in ipairs(f12_local19.imageSet.imageData) do
					local f12_local13, f12_local14, f12_local15, f12_local16, f12_local17 = CoD.RTSLoader.CreateFloatingImage(f12_arg0, f12_local12)
					CoD.RTSLoader.AddAnimationChainToElement(f12_local13, f12_local4, f12_local14, f12_local15, f12_local16, f12_local17, CoD.RTSLoader.StaggerTime * (f12_local18 - 1))
					f12_arg0:addElement(f12_local13)
					table.insert(f12_arg0.previousFrames, f12_local13)
				end
			end
			f12_local3 = f12_local3 + f12_local21 + CoD.RTSLoader.ElementSpacing
			table.insert(f12_arg0.previousFrames, f12_local20)
		end
		f12_local2 = #f12_local0.objectiveBranches[f12_arg0.currentAnimation].objectives - 1
	else
		if f12_arg0.binkImage and not CoD.RTSTutorial.SeenTutorial() then
			if not CoD.RTSTutorial.Active then
				f12_arg0.tutorial = CoD.RTSTutorial.new()
				if f12_arg0.tutorial ~= nil then
					f12_arg0:addElement(f12_arg0.tutorial)
					CoD.RTSTutorial.AddChangePagesButton(f12_arg0)
					CoD.RTSTutorial.AddSelectButton(f12_arg0.tutorial)
					f12_arg0.tutorial:fadeOutBackground()
				end
			end
			return 
		end
		Engine.SetDvar("ui_luiLoadingScreen", 0)
	end
	f12_arg0.timer = LUI.UITimer.new(f12_local1 + CoD.RTSLoader.StaggerTime * f12_local2, "completed_cycle", true)
	f12_arg0:addElement(f12_arg0.timer)
	f12_arg0.currentAnimation = f12_arg0.currentAnimation + 1
end

CoD.RTSLoader.CreateObjectiveRow = function (f13_arg0, f13_arg1, f13_arg2)
	return {
		title = f13_arg0,
		description = f13_arg1,
		imageSet = f13_arg2
	}
end

CoD.RTSLoader.CreateLocationRow = function (f14_arg0, f14_arg1, f14_arg2)
	return {
		name = f14_arg0,
		image = f14_arg1,
		imageHeight = f14_arg2
	}
end

CoD.RTSLoader.CreateObjectiveBranchRow = function (f15_arg0)
	return {
		objectives = {},
		animationTime = f15_arg0
	}
end

CoD.RTSLoader.AddObjectiveToBranch = function (f16_arg0, f16_arg1, f16_arg2, f16_arg3, f16_arg4, f16_arg5)
	table.insert(f16_arg0.objectives, CoD.RTSLoader.CreateObjectiveRow(f16_arg1, f16_arg2, f16_arg3, f16_arg4, f16_arg5))
end

CoD.RTSLoader.CreateImageSet = function ()
	return {
		imageData = {}
	}
end

CoD.RTSLoader.AddImageDataToSet = function (f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4, f18_arg5, f18_arg6)
	table.insert(f18_arg0.imageData, CoD.RTSLoader.CreateImageData(f18_arg1, f18_arg2, f18_arg3, f18_arg4, f18_arg5, f18_arg6))
end

CoD.RTSLoader.CreateImageData = function (f19_arg0, f19_arg1, f19_arg2, f19_arg3, f19_arg4, f19_arg5)
	return {
		material = f19_arg0,
		x = f19_arg1,
		y = f19_arg2,
		width = f19_arg3,
		height = f19_arg4,
		title = f19_arg5
	}
end

CoD.RTSLoader.CreateObjectiveElement = function (f20_arg0, f20_arg1, f20_arg2)
	if f20_arg1 == nil then
		f20_arg1 = CoD.RTSLoader.ElementWidth
	end
	local Widget = LUI.UIElement.new()
	local f20_local1 = 4
	local f20_local2 = CoD.textSize[CoD.RTSLoader.TextFont]
	Widget.header = CoD.RTSLoader.CreateHeader(f20_arg1, 0, f20_local2 + 2 * f20_local1, f20_arg0.title, CoD.offWhite)
	Widget:addElement(Widget.header)
	local f20_local3 = CoD.RTSLoader.StandardDescriptionColor
	if f20_arg2 then
		f20_local3 = CoD.RTSLoader.PrimaryDescriptionColor
	end
	local f20_local4 = f20_local2 + 2 * f20_local1
	Widget.descriptionContainer = CoD.RTSLoader.CreateStencilContainer(f20_local4)
	CoD.RTSLoader.AddTextToStencilObject(Widget.descriptionContainer, f20_arg1, 0, f20_local2, f20_arg0.description, f20_local3)
	Widget:addElement(Widget.descriptionContainer)
	f20_local4 = f20_local4 + CoD.textSize[CoD.RTSLoader.TextFont] * Engine.GetNumTextLines(f20_arg0.description, CoD.fonts[CoD.RTSLoader.TextFont], CoD.textSize[CoD.RTSLoader.TextFont], f20_arg1)
	Widget.useTopAlign = true
	return Widget, f20_local4
end

CoD.RTSLoader.CreateLocationElement = function (f21_arg0, f21_arg1)
	if f21_arg1 == nil then
		f21_arg1 = CoD.RTSLoader.ElementWidth
	end
	local f21_local0, f21_local1 = CoD.RTSLoader.CreateObjectiveElement(CoD.RTSLoader.CreateObjectiveRow(Engine.Localize("RTS_LOADING_SCREENS_LOCATION_CAPS"), f21_arg0.name))
	local Widget = LUI.UIElement.new()
	Widget:setTopBottom(true, false, f21_local1, f21_local1 + f21_arg0.imageHeight)
	Widget:setLeftRight(true, true, 0, 0)
	f21_local0:addElement(Widget)
	local f21_local3 = LUI.UIStreamedImage.new({}, 6000)
	f21_local3:setLeftRight(true, true, 2, -2)
	f21_local3:setTopBottom(true, true, 2, -2)
	f21_local3:setImage(RegisterMaterial(f21_arg0.image))
	f21_local3:setAlpha(0)
	f21_local3:registerEventHandler("streamed_image_ready", CoD.RTSLoader.StreamedImageReady)
	Widget:addElement(f21_local3)
	f21_local1 = f21_local1 + f21_arg0.imageHeight
	local f21_local4 = f21_arg1 / 8
	f21_local0.centeredText = CoD.RTSLoader.CreateStencilObject(f21_local1, f21_local4, f21_arg1, false, true, nil, true)
	f21_local0.centeredText.image:setImage(RegisterMaterial(CoD.RTSLoader.MapBottomBar))
	f21_local0:addElement(f21_local0.centeredText)
	f21_local1 = f21_local1 + f21_local4
	f21_local0.useTopAlign = false
	return f21_local0, f21_local1
end

CoD.RTSLoader.CreateStencilContainer = function (f22_arg0)
	local Widget = LUI.UIElement.new()
	if f22_arg0 == nil then
		f22_arg0 = 0
	end
	Widget:setTopBottom(true, true, f22_arg0, 0)
	Widget:setUseStencil(true)
	return Widget
end

CoD.RTSLoader.AddTextToStencilObject = function (f23_arg0, f23_arg1, f23_arg2, f23_arg3, f23_arg4, f23_arg5, f23_arg6)
	local f23_local0 = CoD.RTSLoader.StandardDescriptionColor
	if f23_arg5 ~= nil then
		f23_local0 = f23_arg5
	end
	f23_arg0.text = CoD.TypewriterText.new()
	if f23_arg6 then
		f23_arg0.text:setLeftRight(false, false, -f23_arg1 / 2 + 5, f23_arg1 / 2 - 5)
		f23_arg0.text:setAlignment(LUI.Alignment.Center)
	else
		f23_arg0.text:setLeftRight(true, false, 5, f23_arg1 - 10)
		f23_arg0.text:setAlignment(LUI.Alignment.Left)
	end
	f23_arg0.text:setTopBottom(true, false, f23_arg2, f23_arg2 + f23_arg3)
	f23_arg0.text.text = f23_arg4
	f23_arg0.text:setRGB(f23_local0.r, f23_local0.g, f23_local0.b)
	f23_arg0:addElement(f23_arg0.text)
end

CoD.RTSLoader.AddImageToStencilObject = function (f24_arg0, f24_arg1, f24_arg2, f24_arg3)
	f24_arg0.image = LUI.UIImage.new()
	if f24_arg3 then
		f24_arg0.image:setLeftRight(false, false, -f24_arg1 / 2, f24_arg1 / 2)
	else
		f24_arg0.image:setLeftRight(true, false, 0, f24_arg1)
	end
	f24_arg0.image:setImage(RegisterMaterial(f24_arg2))
	f24_arg0.image:setTopBottom(true, true, 0, 0)
	f24_arg0:addElement(f24_arg0.image)
end

CoD.RTSLoader.AddBackgroundToStencilObject = function (f25_arg0)
	f25_arg0.background = LUI.UIImage.new()
	f25_arg0.background:setLeftRight(true, true, 0, 0)
	f25_arg0.background:setTopBottom(true, true, 0, 0)
	f25_arg0.background:setRGB(CoD.RTSLoader.HeaderBackground.r, CoD.RTSLoader.HeaderBackground.g, CoD.RTSLoader.HeaderBackground.b)
	f25_arg0:addElement(f25_arg0.background)
end

CoD.RTSLoader.CreateHeader = function (f26_arg0, f26_arg1, f26_arg2, f26_arg3, f26_arg4)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f26_arg1, f26_arg1 + f26_arg2)
	Widget.backgroundStencil = CoD.RTSLoader.CreateStencilContainer(0)
	Widget.backgroundStencil:setLeftRight(true, false, 0, 0)
	Widget.backgroundStencil:setTopBottom(true, false, 0, 0)
	CoD.RTSLoader.AddBackgroundToStencilObject(Widget.backgroundStencil)
	Widget:addElement(Widget.backgroundStencil)
	Widget.boxPattern = LUI.UIImage.new()
	Widget.boxPattern:setLeftRight(true, true, -3, 4)
	Widget.boxPattern:setTopBottom(true, true, -6, 8)
	Widget.boxPattern:setAlpha(0)
	Widget.boxPattern:setImage(RegisterMaterial(CoD.RTSLoader.HeaderTextGrid))
	Widget:addElement(Widget.boxPattern)
	Widget.textStencil = CoD.RTSLoader.CreateStencilContainer(0)
	Widget.textStencil:setLeftRight(true, false, 0, 0)
	Widget.textStencil:setTopBottom(true, true, 0, 0)
	CoD.RTSLoader.AddTextToStencilObject(Widget.textStencil, f26_arg0, (f26_arg2 - CoD.RTSLoader.TextSize) / 2, CoD.RTSLoader.TextSize, f26_arg3, f26_arg4)
	Widget:addElement(Widget.textStencil)
	return Widget
end

CoD.RTSLoader.CreateStencilObject = function (f27_arg0, f27_arg1, f27_arg2, f27_arg3, f27_arg4, f27_arg5, f27_arg6)
	local Widget = LUI.UIElement.new()
	Widget:setUseStencil(true)
	Widget:setTopBottom(true, true, f27_arg0, 0)
	local f27_local1 = CoD[CoD.RTSLoader.StandardDescriptionColor]
	if f27_arg5 ~= nil then
		if type(f27_arg5) == "string" then
			f27_local1 = CoD[f27_arg5]
		else
			f27_local1 = f27_arg5
		end
	end
	if f27_arg4 then
		Widget.image = LUI.UIImage.new()
		if f27_arg6 then
			Widget.image:setLeftRight(false, false, -f27_arg2 / 2, f27_arg2 / 2)
		else
			Widget.image:setLeftRight(true, true, 0, 0)
		end
		Widget.image:setTopBottom(true, true, 0, 0)
		Widget:addElement(Widget.image)
	end
	if f27_arg3 then
		Widget.text = CoD.TypewriterText.new()
		if f27_arg6 then
			Widget.text:setLeftRight(false, false, -f27_arg2 / 2 + 5, f27_arg2 / 2 - 5)
			Widget.text:setAlignment(LUI.Alignment.Center)
		else
			Widget.text:setLeftRight(true, false, 5, f27_arg2 - 10)
			Widget.text:setAlignment(LUI.Alignment.Left)
		end
		Widget.text:setTopBottom(false, false, -f27_arg1 / 2, f27_arg1 / 2)
		Widget.text:setRGB(f27_local1.r, f27_local1.g, f27_local1.b)
		Widget:addElement(Widget.text)
	end
	return Widget
end

CoD.RTSLoader.CreateFloatingImage = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget.useLeftAlign = false
	local f28_local1 = LUI.UIImage.new()
	f28_local1:setAlpha(0)
	f28_local1:setImage(RegisterMaterial(CoD.RTSLoader.TargetPulse))
	Widget:addElement(f28_local1)
	local f28_local2 = InstanceRef.width
	local f28_local3 = InstanceRef.height
	local f28_local4 = 0
	if InstanceRef.title then
		f28_local4 = CoD.textSize[CoD.RTSLoader.TextFont] + 20
		f28_local3 = f28_local3 + f28_local4
		local f28_local5, f28_local6, f28_local7, f28_local8 = GetTextDimensions(InstanceRef.title, CoD.fonts[CoD.RTSLoader.TextFont], CoD.textSize[CoD.RTSLoader.TextFont])
		f28_local2 = math.max(f28_local2, f28_local7 - f28_local5 + 30)
		if InstanceRef.title ~= "" then
			Widget.centeredText = CoD.RTSLoader.CreateStencilObject(0, CoD.textSize[CoD.RTSLoader.TextFont], f28_local2, true, true, CoD.RTSLoader.Black, true)
			Widget.centeredText:setTopBottom(true, false, 0, CoD.textSize[CoD.RTSLoader.TextFont])
			Widget.centeredText.text:setText(InstanceRef.title)
			Widget.centeredText.image:setRGB(CoD.RTSColors.yellow.r, CoD.RTSColors.yellow.g, CoD.RTSColors.yellow.b)
			Widget:addElement(Widget.centeredText)
		end
		Widget.marker = LUI.UIImage.new()
		Widget.marker:setLeftRight(false, false, -10, 10)
		Widget.marker:setTopBottom(true, false, f28_local4 - 20, f28_local4)
		Widget.marker:setImage(RegisterMaterial(CoD.RTSLoader.IndicatorPinkTriangle))
		Widget.marker:setZRot(180)
		Widget:addElement(Widget.marker)
	end
	local f28_local5 = InstanceRef.x * HudRef.backgroundWidth / 2 + HudRef.backgroundCenterX - f28_local2 / 2
	local f28_local6 = InstanceRef.y * HudRef.backgroundHeight / 2 + HudRef.backgroundCenterY - f28_local3 - InstanceRef.height / 2
	Widget:setLeftRight(false, false, f28_local5, f28_local5 + f28_local2)
	Widget:setTopBottom(false, false, f28_local6, f28_local6 + f28_local3)
	Widget:setAlpha(0)
	local f28_local7 = LUI.UIImage.new()
	f28_local7:setLeftRight(false, false, -InstanceRef.width / 2, InstanceRef.width / 2)
	f28_local7:setTopBottom(true, false, f28_local4, f28_local4 + InstanceRef.height)
	f28_local7:setImage(RegisterMaterial(InstanceRef.material))
	Widget:addElement(f28_local7)
	f28_local1.width = InstanceRef.width
	f28_local1.height = InstanceRef.height
	f28_local1.centerY = f28_local4 + f28_local1.height / 2
	Widget.pulse = f28_local1
	return Widget, f28_local5, f28_local2, f28_local6, f28_local3
end

CoD.RTSLoader.Pulse_ShrinkIn = function (f29_arg0, f29_arg1)
	f29_arg0:beginAnimation("shrink", f29_arg1)
	f29_arg0:setLeftRight(false, false, -f29_arg0.width / 2, f29_arg0.width / 2)
	f29_arg0:setTopBottom(true, false, f29_arg0.centerY - f29_arg0.height / 2, f29_arg0.centerY + f29_arg0.height / 2)
end

CoD.RTSLoader.Pulse_AlphaIn = function (f30_arg0, f30_arg1)
	f30_arg0:beginAnimation("show", f30_arg1)
	f30_arg0:setAlpha(0.75)
end

CoD.RTSLoader.Pulse_GrowOut = function (f31_arg0, f31_arg1, f31_arg2)
	local f31_local0 = 2
	if f31_arg2.scale then
		f31_local0 = f31_arg2.scale
	end
	f31_arg0:beginAnimation("grow", f31_arg1)
	if f31_arg2.alpha then
		f31_arg0:setAlpha(f31_arg2.alpha)
	end
	f31_arg0:setLeftRight(false, false, -f31_arg0.width / 2 * f31_local0, f31_arg0.width / 2 * f31_local0)
	f31_arg0:setTopBottom(true, false, f31_arg0.centerY - f31_arg0.height / 2 * f31_local0, f31_arg0.centerY + f31_arg0.height / 2 * f31_local0)
end

CoD.RTSLoader.AddAnimationChainToElement = function (f32_arg0, f32_arg1, f32_arg2, f32_arg3, f32_arg4, f32_arg5, f32_arg6)
	f32_arg0:registerEventHandler("move_element", CoD.RTSLoader.MoveElement)
	f32_arg0:registerEventHandler("grow_element", CoD.RTSLoader.GrowElementMembers)
	f32_arg0:registerEventHandler("pulse_elements", CoD.RTSLoader.PulseElements)
	f32_arg0:registerEventHandler("write_text", CoD.RTSLoader.WriteTextMembers)
	if f32_arg6 == nil then
		f32_arg6 = 0
	end
	local f32_local0 = 0
	local f32_local1 = 0
	if f32_arg6 == 0 then
		f32_arg0:processEvent({
			name = "move_element",
			left = f32_arg2 + f32_local0,
			width = f32_arg3,
			top = f32_arg4 + f32_local1,
			height = f32_arg5
		})
		f32_arg0:processEvent({
			name = "grow_element",
			width = 0
		})
	else
		f32_arg0:addElement(LUI.UITimer.new(f32_arg6, {
			name = "move_element",
			left = f32_arg2 + f32_local0,
			width = f32_arg3,
			top = f32_arg4 + f32_local1,
			height = f32_arg5
		}, true, f32_arg0))
		f32_arg0:addElement(LUI.UITimer.new(f32_arg6, {
			name = "grow_element",
			width = 0
		}, true, f32_arg0))
	end
	f32_arg0:addElement(LUI.UITimer.new(f32_arg6 + CoD.RTSLoader.MovementTime, {
		name = "move_element",
		left = f32_arg2,
		width = f32_arg3,
		top = f32_arg4,
		height = f32_arg5,
		alpha = 1,
		time = CoD.RTSLoader.MovementTime
	}, true, f32_arg0))
	f32_arg0:addElement(LUI.UITimer.new(f32_arg6 + CoD.RTSLoader.MovementTime, {
		name = "grow_element",
		width = f32_arg3,
		alpha = 1,
		farAnchor = true,
		time = CoD.RTSLoader.MovementTime
	}, true, f32_arg0))
	f32_arg0:addElement(LUI.UITimer.new(f32_arg6 + 2 * CoD.RTSLoader.MovementTime, {
		name = "pulse_elements",
		flickerAlpha = 1,
		time = CoD.RTSLoader.MovementTime
	}, true, f32_arg0))
	f32_arg0:addElement(LUI.UITimer.new(f32_arg6 + 3 * CoD.RTSLoader.MovementTime, {
		name = "write_text",
		time = 30
	}, true, f32_arg0))
	if f32_arg1 ~= nil then
		f32_arg0:addElement(LUI.UITimer.new(f32_arg6 + f32_arg1 - CoD.RTSLoader.MovementTime, {
			name = "pulse_elements",
			flickerAlpha = 0,
			time = CoD.RTSLoader.MovementTime
		}, true, f32_arg0))
		f32_arg0:addElement(LUI.UITimer.new(f32_arg6 + f32_arg1, {
			name = "move_element",
			time = CoD.RTSLoader.MovementTime,
			left = f32_arg2 + f32_local0,
			width = f32_arg3,
			top = f32_arg4 + f32_local1,
			height = f32_arg5
		}, true, f32_arg0))
		f32_arg0:addElement(LUI.UITimer.new(f32_arg6 + f32_arg1, {
			name = "grow_element",
			flickerAlpha = 0,
			width = 0,
			time = CoD.RTSLoader.MovementTime
		}, true, f32_arg0))
	end
end

CoD.RTSLoader.MoveElement = function (f33_arg0, f33_arg1)
	local f33_local0 = 0
	if f33_arg1.time then
		f33_local0 = f33_arg1.time
	end
	local f33_local1 = 0
	if f33_arg1.alpha then
		f33_local1 = f33_arg1.alpha
	end
	local f33_local2 = true
	if f33_arg0.useLeftAlign ~= nil then
		f33_local2 = f33_arg0.useLeftAlign
	end
	local f33_local3 = false
	if f33_arg0.useTopAlign then
		f33_local3 = true
	end
	f33_arg0:beginAnimation("move_element", f33_local0)
	f33_arg0:setLeftRight(f33_local2, false, f33_arg1.left, f33_arg1.left + f33_arg1.width)
	f33_arg0:setTopBottom(f33_local3, false, f33_arg1.top, f33_arg1.top + f33_arg1.height)
	f33_arg0:setAlpha(f33_local1)
end

CoD.RTSLoader.GrowElementMembers = function (f34_arg0, f34_arg1)
	local f34_local0 = 0
	if f34_arg1.time then
		f34_local0 = f34_arg1.time
	end
	local f34_local1 = 1
	if f34_arg1.alpha then
		f34_local1 = f34_arg1.alpha
	end
	local f34_local2 = false
	if f34_arg1.farAnchor then
		f34_local2 = f34_arg1.farAnchor
	end
	if f34_arg0.header then
		local f34_local3 = f34_arg0.header
		if f34_local3.backgroundStencil then
			f34_local3.backgroundStencil:beginAnimation("grow_element", f34_local0)
			f34_local3.backgroundStencil:setLeftRight(true, f34_local2, 0, 0)
			f34_local3.backgroundStencil:setTopBottom(true, f34_local2, 0, 0)
		end
		if f34_local3.textStencil then
			f34_local3.textStencil:beginAnimation("grow_element", 0)
			f34_local3.textStencil:setAlpha(f34_local1)
			f34_local3.textStencil:setLeftRight(true, false, 0, f34_arg1.width)
		end
	end
	if f34_arg0.descriptionContainer then
		f34_arg0.descriptionContainer:beginAnimation("grow_element", f34_local0)
		f34_arg0.descriptionContainer:setLeftRight(true, false, 0, f34_arg1.width)
	end
	if f34_arg0.centeredText then
		f34_arg0.centeredText:beginAnimation("grow_element", f34_local0)
		f34_arg0.centeredText:setLeftRight(false, false, -f34_arg1.width / 2, f34_arg1.width / 2)
	end
end

CoD.RTSLoader.PulseElements = function (f35_arg0, f35_arg1)
	local f35_local0 = 0
	if f35_arg1.time then
		f35_local0 = f35_arg1.time
	end
	if f35_arg0.header then
		local f35_local1 = f35_arg0.header
		if f35_local1.boxPattern and f35_arg1.flickerAlpha then
			f35_local1.boxPattern:flicker(f35_local0, f35_arg1.flickerAlpha, 0, 0.8, 50, 100)
		end
	end
	if f35_arg0.pulse then
		f35_arg0.pulse:animationQueue({
			{
				funct = CoD.RTSLoader.Pulse_ShrinkIn,
				time = 100
			},
			{
				funct = CoD.RTSLoader.Pulse_AlphaIn,
				time = 250
			},
			{
				funct = CoD.RTSLoader.Pulse_GrowOut,
				time = 1000,
				scale = 3
			},
			{
				funct = CoD.RTSLoader.Pulse_GrowOut,
				time = 500,
				scale = 4,
				alpha = 0
			}
		}, nil, true)
	end
end

CoD.RTSLoader.WriteTextMembers = function (f36_arg0, f36_arg1)
	local f36_local0 = 0
	if f36_arg1.time then
		f36_local0 = f36_arg1.time
	end
	if f36_arg0.header then
		local f36_local1 = f36_arg0.header
		if f36_local1.textStencil then
			local f36_local2 = f36_local1.textStencil
			if f36_local2.text then
				f36_local2.text:processEvent({
					name = "typewrite",
					perLetter = f36_local0,
					text = f36_local2.text.text
				})
			end
		end
	end
	if f36_arg0.descriptionContainer then
		local f36_local1 = f36_arg0.descriptionContainer
		if f36_local1.text then
			f36_local1.text:processEvent({
				name = "typewrite",
				perLetter = f36_local0,
				text = f36_local1.text.text
			})
		end
	end
end

CoD.RTSLoader.LoadBarAnimation = function (f37_arg0, f37_arg1)
	local f37_local0 = f37_arg1.step
	if f37_local0 == 6 and not f37_arg0.backgroundLoaded then
		f37_arg0:addElement(LUI.UITimer.new(600, f37_arg1, true, f37_arg0))
		return 
	end
	local f37_local1 = f37_arg1.previous
	if f37_local1 == nil then
		f37_local1 = 0
	end
	local f37_local2 = f37_arg1.total
	local f37_local3 = 0
	if f37_local0 == 0 then
		f37_arg0.statusText:flicker(0)
		f37_local3 = 0
	elseif f37_local0 >= 6 then
		f37_arg0.statusText:beginAnimation("show")
		f37_arg0.statusText:setAlpha(1)
		f37_local3 = f37_local2
	else
		f37_local3 = f37_local2 / 6 * f37_local0 + math.random(-10, 10) / 120 * f37_local2
	end
	local f37_local4 = f37_arg0.stencil
	f37_local4:beginAnimation("next_load", 400 * (f37_local3 - f37_local1) / f37_local2)
	f37_local4:setLeftRight(true, false, f37_arg1.left, f37_local3)
	if f37_local0 < 6 then
		f37_arg0:addElement(LUI.UITimer.new(600, {
			name = "loading_animation",
			left = f37_arg1.left,
			step = f37_local0 + 1,
			previous = nextwidth,
			total = f37_local2
		}, true, f37_arg0))
	else
		f37_arg0.statusText:setText(Engine.Localize("RTS_LOADING_SCREENS_COMPLETE_CAPS"))
		f37_arg0.statusImage:setImage(RegisterMaterial(CoD.RTSLoader.CompleteLoadBar))
		f37_arg0.statusText:processEvent({
			name = "close_flicker_timer"
		})
		f37_arg0:dispatchEventToParent({
			name = "loading_complete"
		})
	end
end

CoD.RTSLoader.BackgroundLoaded = function (f38_arg0, f38_arg1)
	f38_arg0.loadingContainer.backgroundLoaded = true
end

CoD.RTSLoader.LevelFunctions = {}
CoD.RTSLoader.LevelFunctions.so_rts_afghanistan = function (f39_arg0)
	local f39_local0 = {}
	local f39_local1, f39_local2 = nil
	local f39_local3 = "RTS_LOADING_SCREENS_AFGHANISTAN_"
	f39_local0.sfx = "mus_so_rts_afghanistan"
	f39_local0.primaryObjective = CoD.RTSLoader.CreateObjectiveRow(Engine.Localize("RTS_LOADING_SCREENS_PRIMARY_OBJECTIVE_CAPS"), Engine.Localize(f39_local3 .. "PRIMARY_OBJECTIVE"))
	f39_local0.location = CoD.RTSLoader.CreateLocationRow(Engine.Localize(f39_local3 .. "LOCATION"), "menu_visor_ms_war_afghanistan", 200)
	f39_local0.background = "compass_overlay_map_afghanistan"
	f39_local0.objectiveBranches = {}
	f39_local1 = CoD.RTSLoader.CreateObjectiveBranchRow(CoD.RTSLoader.OnScreenTime)
	CoD.RTSLoader.AddObjectiveToBranch(f39_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_1"), Engine.Localize(f39_local3 .. "OBJECTIVE_1"))
	CoD.RTSLoader.AddObjectiveToBranch(f39_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_2"), Engine.Localize(f39_local3 .. "OBJECTIVE_2"))
	table.insert(f39_local0.objectiveBranches, f39_local1)
	f39_local1 = CoD.RTSLoader.CreateObjectiveBranchRow(CoD.RTSLoader.OnScreenTime)
	CoD.RTSLoader.AddObjectiveToBranch(f39_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_3"), Engine.Localize(f39_local3 .. "OBJECTIVE_3"))
	CoD.RTSLoader.AddObjectiveToBranch(f39_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_4"), Engine.Localize(f39_local3 .. "OBJECTIVE_4"))
	table.insert(f39_local0.objectiveBranches, f39_local1)
	return f39_local0
end

CoD.RTSLoader.LevelFunctions.so_rts_mp_drone = function (f40_arg0)
	local f40_local0 = {}
	local f40_local1, f40_local2 = nil
	local f40_local3 = "RTS_LOADING_SCREENS_DRONE_"
	f40_local0.sfx = "mus_so_rts_mp_dockside"
	f40_local0.primaryObjective = CoD.RTSLoader.CreateObjectiveRow(Engine.Localize("RTS_LOADING_SCREENS_PRIMARY_OBJECTIVE_CAPS"), Engine.Localize(f40_local3 .. "PRIMARY_OBJECTIVE"))
	f40_local0.location = CoD.RTSLoader.CreateLocationRow(Engine.Localize(f40_local3 .. "LOCATION"), "menu_visor_ms_war_drone", 200)
	f40_local0.background = "compass_map_mp_drone"
	f40_local0.objectiveBranches = {}
	f40_local1 = CoD.RTSLoader.CreateObjectiveBranchRow(CoD.RTSLoader.OnScreenTime)
	f40_local2 = CoD.RTSLoader.CreateImageSet()
	CoD.RTSLoader.AddImageDataToSet(f40_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(435), CoD.RTSLoader.MarkerHelper(390), 30, 30, Engine.Localize(f40_local3 .. "DEFENSE_LOC_1"))
	CoD.RTSLoader.AddObjectiveToBranch(f40_local1, Engine.Localize(f40_local3 .. "DEFENSE_1"), Engine.Localize(f40_local3 .. "DEFENSE_LOC_1"), f40_local2)
	f40_local2 = CoD.RTSLoader.CreateImageSet()
	CoD.RTSLoader.AddImageDataToSet(f40_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(202), CoD.RTSLoader.MarkerHelper(141), 30, 30, Engine.Localize(f40_local3 .. "DEFENSE_LOC_2"))
	CoD.RTSLoader.AddObjectiveToBranch(f40_local1, Engine.Localize(f40_local3 .. "DEFENSE_2"), Engine.Localize(f40_local3 .. "DEFENSE_LOC_2"), f40_local2)
	f40_local2 = CoD.RTSLoader.CreateImageSet()
	CoD.RTSLoader.AddImageDataToSet(f40_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(371), CoD.RTSLoader.MarkerHelper(233), 30, 30, Engine.Localize(f40_local3 .. "DEFENSE_LOC_3"))
	CoD.RTSLoader.AddObjectiveToBranch(f40_local1, Engine.Localize(f40_local3 .. "DEFENSE_3"), Engine.Localize(f40_local3 .. "DEFENSE_LOC_3"), f40_local2)
	table.insert(f40_local0.objectiveBranches, f40_local1)
	f40_local1 = CoD.RTSLoader.CreateObjectiveBranchRow(CoD.RTSLoader.OnScreenTime)
	f40_local2 = CoD.RTSLoader.CreateImageSet()
	CoD.RTSLoader.AddImageDataToSet(f40_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(288), CoD.RTSLoader.MarkerHelper(310), 30, 30, Engine.Localize(f40_local3 .. "MARKER_4"))
	CoD.RTSLoader.AddObjectiveToBranch(f40_local1, Engine.Localize(f40_local3 .. "DEFENSE_NOTICE"), Engine.Localize(f40_local3 .. "DEFENSE_DOWN_WARNING"), f40_local2)
	table.insert(f40_local0.objectiveBranches, f40_local1)
	return f40_local0
end

CoD.RTSLoader.LevelFunctions.so_tut_mp_drone = function (f41_arg0)
	local f41_local0 = {}
	local f41_local1, f41_local2 = nil
	local f41_local3 = "RTS_LOADING_SCREENS_DRONE_TUT_"
	f41_local0.sfx = "mus_so_rts_mp_dockside"
	f41_local0.primaryObjective = CoD.RTSLoader.CreateObjectiveRow(Engine.Localize("RTS_LOADING_SCREENS_PRIMARY_OBJECTIVE_CAPS"), Engine.Localize(f41_local3 .. "PRIMARY_OBJECTIVE"))
	f41_local0.location = CoD.RTSLoader.CreateLocationRow(Engine.Localize(f41_local3 .. "LOCATION"), "menu_visor_ms_war_drone", 200)
	f41_local0.background = "compass_map_mp_drone"
	f41_local0.objectiveBranches = {}
	f41_local1 = CoD.RTSLoader.CreateObjectiveBranchRow(CoD.RTSLoader.OnScreenTime)
	CoD.RTSLoader.AddObjectiveToBranch(f41_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_1"), Engine.Localize(f41_local3 .. "OBJECTIVE_1"))
	CoD.RTSLoader.AddObjectiveToBranch(f41_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_2"), Engine.Localize(f41_local3 .. "OBJECTIVE_2"))
	table.insert(f41_local0.objectiveBranches, f41_local1)
	f41_local1 = CoD.RTSLoader.CreateObjectiveBranchRow(CoD.RTSLoader.OnScreenTime)
	CoD.RTSLoader.AddObjectiveToBranch(f41_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_3"), Engine.Localize(f41_local3 .. "OBJECTIVE_3"))
	table.insert(f41_local0.objectiveBranches, f41_local1)
	return f41_local0
end

CoD.RTSLoader.LevelFunctions.so_rts_mp_dockside = function (f42_arg0)
	local f42_local0 = {}
	local f42_local1, f42_local2 = nil
	local f42_local3 = "RTS_LOADING_SCREENS_DOCKSIDE_"
	f42_local0.sfx = "mus_so_rts_mp_dockside"
	f42_local0.primaryObjective = CoD.RTSLoader.CreateObjectiveRow(Engine.Localize("RTS_LOADING_SCREENS_PRIMARY_OBJECTIVE_CAPS"), Engine.Localize(f42_local3 .. "PRIMARY_OBJECTIVE"))
	f42_local0.location = CoD.RTSLoader.CreateLocationRow(Engine.Localize(f42_local3 .. "LOCATION"), "menu_visor_ms_war_singapore", 200)
	f42_local0.background = "compass_map_mp_dockside_rts"
	f42_local0.objectiveBranches = {}
	f42_local1 = CoD.RTSLoader.CreateObjectiveBranchRow(CoD.RTSLoader.OnScreenTime)
	f42_local2 = CoD.RTSLoader.CreateImageSet()
	CoD.RTSLoader.AddImageDataToSet(f42_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(284), CoD.RTSLoader.MarkerHelper(252), 30, 30, Engine.Localize(f42_local3 .. "MARKER_1"))
	CoD.RTSLoader.AddObjectiveToBranch(f42_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_1"), Engine.Localize(f42_local3 .. "OBJECTIVE_1"), f42_local2)
	CoD.RTSLoader.AddObjectiveToBranch(f42_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_2"), Engine.Localize(f42_local3 .. "OBJECTIVE_2"))
	table.insert(f42_local0.objectiveBranches, f42_local1)
	f42_local1 = CoD.RTSLoader.CreateObjectiveBranchRow(CoD.RTSLoader.OnScreenTime)
	f42_local2 = CoD.RTSLoader.CreateImageSet()
	CoD.RTSLoader.AddImageDataToSet(f42_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(181), CoD.RTSLoader.MarkerHelper(171), 30, 30, Engine.Localize(f42_local3 .. "MARKER_3"))
	CoD.RTSLoader.AddImageDataToSet(f42_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(381), CoD.RTSLoader.MarkerHelper(343), 30, 30, Engine.Localize(f42_local3 .. "MARKER_3"))
	CoD.RTSLoader.AddObjectiveToBranch(f42_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_3"), Engine.Localize(f42_local3 .. "OBJECTIVE_3"), f42_local2)
	CoD.RTSLoader.AddObjectiveToBranch(f42_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_4"), Engine.Localize(f42_local3 .. "OBJECTIVE_4"))
	table.insert(f42_local0.objectiveBranches, f42_local1)
	f42_local1 = CoD.RTSLoader.CreateObjectiveBranchRow()
	f42_local2 = CoD.RTSLoader.CreateImageSet()
	CoD.RTSLoader.AddImageDataToSet(f42_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(493), CoD.RTSLoader.MarkerHelper(280), 30, 30, Engine.Localize(f42_local3 .. "MARKER_5"))
	CoD.RTSLoader.AddObjectiveToBranch(f42_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_5"), Engine.Localize(f42_local3 .. "OBJECTIVE_5"), f42_local2)
	table.insert(f42_local0.objectiveBranches, f42_local1)
	return f42_local0
end

CoD.RTSLoader.LevelFunctions.so_rts_mp_overflow = function (f43_arg0)
	local f43_local0 = {}
	local f43_local1, f43_local2 = nil
	local f43_local3 = "RTS_LOADING_SCREENS_OVERFLOW_"
	f43_local0.sfx = "mus_so_rts_mp_overflow"
	f43_local0.primaryObjective = CoD.RTSLoader.CreateObjectiveRow(Engine.Localize("RTS_LOADING_SCREENS_PRIMARY_OBJECTIVE_CAPS"), Engine.Localize(f43_local3 .. "PRIMARY_OBJECTIVE"))
	f43_local0.location = CoD.RTSLoader.CreateLocationRow(Engine.Localize(f43_local3 .. "LOCATION"), "menu_visor_ms_war_pakistan", 200)
	f43_local0.background = "compass_map_mp_overflow"
	f43_local0.objectiveBranches = {}
	f43_local1 = CoD.RTSLoader.CreateObjectiveBranchRow(CoD.RTSLoader.OnScreenTime)
	CoD.RTSLoader.AddObjectiveToBranch(f43_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_1"), Engine.Localize(f43_local3 .. "OBJECTIVE_1"))
	f43_local2 = CoD.RTSLoader.CreateImageSet()
	CoD.RTSLoader.AddImageDataToSet(f43_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(109), CoD.RTSLoader.MarkerHelper(347), 30, 30, Engine.Localize(f43_local3 .. "MARKER_2"))
	CoD.RTSLoader.AddObjectiveToBranch(f43_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_2"), Engine.Localize(f43_local3 .. "OBJECTIVE_2"), f43_local2)
	table.insert(f43_local0.objectiveBranches, f43_local1)
	f43_local1 = CoD.RTSLoader.CreateObjectiveBranchRow(CoD.RTSLoader.OnScreenTime)
	CoD.RTSLoader.AddObjectiveToBranch(f43_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_3"), Engine.Localize(f43_local3 .. "OBJECTIVE_3"))
	CoD.RTSLoader.AddObjectiveToBranch(f43_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_4"), Engine.Localize(f43_local3 .. "OBJECTIVE_4"))
	table.insert(f43_local0.objectiveBranches, f43_local1)
	return f43_local0
end

CoD.RTSLoader.LevelFunctions.so_rts_mp_socotra = function (f44_arg0)
	local f44_local0 = {}
	local f44_local1, f44_local2 = nil
	local f44_local3 = "RTS_LOADING_SCREENS_SOCOTRA_"
	f44_local0.sfx = "mus_so_rts_mp_socotra"
	f44_local0.primaryObjective = CoD.RTSLoader.CreateObjectiveRow(Engine.Localize("RTS_LOADING_SCREENS_PRIMARY_OBJECTIVE_CAPS"), Engine.Localize(f44_local3 .. "PRIMARY_OBJECTIVE"))
	f44_local0.location = CoD.RTSLoader.CreateLocationRow(Engine.Localize(f44_local3 .. "LOCATION"), "menu_visor_ms_war_socotra", 200)
	f44_local0.background = "compass_map_mp_socotra"
	f44_local0.objectiveBranches = {}
	f44_local1 = CoD.RTSLoader.CreateObjectiveBranchRow(CoD.RTSLoader.OnScreenTime)
	f44_local2 = CoD.RTSLoader.CreateImageSet()
	CoD.RTSLoader.AddImageDataToSet(f44_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(377), CoD.RTSLoader.MarkerHelper(283), 30, 30, "")
	CoD.RTSLoader.AddImageDataToSet(f44_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(338), CoD.RTSLoader.MarkerHelper(355), 30, 30, "")
	CoD.RTSLoader.AddImageDataToSet(f44_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(223), CoD.RTSLoader.MarkerHelper(252), 30, 30, "")
	CoD.RTSLoader.AddImageDataToSet(f44_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(165), CoD.RTSLoader.MarkerHelper(337), 30, 30, "")
	CoD.RTSLoader.AddImageDataToSet(f44_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(153), CoD.RTSLoader.MarkerHelper(209), 30, 30, "")
	CoD.RTSLoader.AddObjectiveToBranch(f44_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_1"), Engine.Localize(f44_local3 .. "OBJECTIVE_1"), f44_local2)
	CoD.RTSLoader.AddObjectiveToBranch(f44_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_2"), Engine.Localize(f44_local3 .. "OBJECTIVE_2"))
	table.insert(f44_local0.objectiveBranches, f44_local1)
	f44_local1 = CoD.RTSLoader.CreateObjectiveBranchRow(CoD.RTSLoader.OnScreenTime)
	f44_local2 = CoD.RTSLoader.CreateImageSet()
	CoD.RTSLoader.AddImageDataToSet(f44_local2, CoD.RTSLoader.TargetReticle, CoD.RTSLoader.MarkerHelper(200), CoD.RTSLoader.MarkerHelper(102), 30, 30, Engine.Localize(f44_local3 .. "MARKER_3"))
	CoD.RTSLoader.AddObjectiveToBranch(f44_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_3"), Engine.Localize(f44_local3 .. "OBJECTIVE_3"), f44_local2)
	CoD.RTSLoader.AddObjectiveToBranch(f44_local1, Engine.Localize("RTS_LOADING_SCREENS_OBJECTIVE_4"), Engine.Localize(f44_local3 .. "OBJECTIVE_4"))
	table.insert(f44_local0.objectiveBranches, f44_local1)
	return f44_local0
end

CoD.RTSLoader.MarkerHelper = function (f45_arg0)
	return (f45_arg0 - 256) / 256
end

