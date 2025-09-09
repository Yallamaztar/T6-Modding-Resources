CoD.GameGlobeZombie = {}
CoD.GameGlobeZombie.gameGlobe = nil
CoD.GameGlobeZombie.ShaderVector2X = 0.52
CoD.GameGlobeZombie.ShaderVector2Z = 0.41
CoD.GameGlobeZombie.ShaderVector2XMax = math.pi / 2
CoD.GameGlobeZombie.ShaderVector2XMin = -math.pi / 2
CoD.GameGlobeZombie.ShaderVector2YMax = math.pi
CoD.GameGlobeZombie.ShaderVector2YMin = -math.pi
CoD.GameGlobeZombie.SelfRotationSpeed = math.pi / 10000
CoD.GameGlobeZombie.ManuRotationSpeed = math.pi / 2000
CoD.GameGlobeZombie.ManuRotationTime = 500
CoD.GameGlobeZombie.TranslatingSpeed = 0.9
CoD.GameGlobeZombie.ScalingSpeed = 1.3
CoD.GameGlobeZombie.CenterRadius = 240
CoD.GameGlobeZombie.CornerRadius = 360
CoD.GameGlobeZombie.MidRadius = 307
CoD.GameGlobeZombie.UpRadius = 360
CoD.GameGlobeZombie.FirstRadius = 512
CoD.GameGlobeZombie.DegreesToRadiansScale = math.pi / 180
CoD.GameGlobeZombie.PlaceYOffSet = -40
CoD.GameGlobeZombie.MoveToCenterPath = {}
CoD.GameGlobeZombie.MoveToCenterPathNodeCount = 5
CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = 1
CoD.GameGlobeZombie.MoveToCenterPathNodeMidIndex = 3
CoD.GameGlobeZombie.MoveToCenterPathDist = 0
CoD.GameGlobeZombie.XRotCurrent = 0
CoD.GameGlobeZombie.YRotCurrent = 0
CoD.GameGlobeZombie.ZRotCurrent = 0
CoD.GameGlobeZombie.MoveToCenterPath[1] = {
	x = -450,
	y = 100
}
CoD.GameGlobeZombie.MoveToCenterPath[2] = {
	x = -350,
	y = 69
}
CoD.GameGlobeZombie.MoveToCenterPath[3] = {
	x = -225,
	y = 30
}
CoD.GameGlobeZombie.MoveToCenterPath[4] = {
	x = -100,
	y = -9
}
CoD.GameGlobeZombie.MoveToCenterPath[5] = {
	x = 0,
	y = CoD.GameGlobeZombie.PlaceYOffSet
}
CoD.GameGlobeZombie.LowRumble = 0.4
CoD.GameGlobeZombie.HighRumble = 0.6
CoD.GameGlobeZombie.ShakingScaleSmall = 1
CoD.GameGlobeZombie.ShakingScaleMedium = 2
CoD.GameGlobeZombie.mapInfoContainer = nil
CoD.GameGlobeZombie.ShakingAnimTimeMedium = 15
CoD.GameGlobeZombie.ShakingAnimTimeLong = 30
CoD.GameGlobeZombie.ShakingAnimTimeFloating = 1500
CoD.GameGlobeZombie.Init = function (f1_arg0)
	f1_arg0:setLeftRight(false, false, -1200 - CoD.GameGlobeZombie.FirstRadius, -1200 + CoD.GameGlobeZombie.FirstRadius)
	f1_arg0:setTopBottom(false, false, 333 - CoD.GameGlobeZombie.FirstRadius, 333 + CoD.GameGlobeZombie.FirstRadius)
	f1_arg0:setShaderVector(2, CoD.GameGlobeZombie.ShaderVector2X, CoD.GameGlobeZombie.ShaderVector2YMin - 785 / CoD.GameGlobeZombie.TranslatingSpeed * CoD.GameGlobeZombie.SelfRotationSpeed, CoD.GameGlobeZombie.ShaderVector2Z, 0)
	f1_arg0:setScale(1)
	f1_arg0:registerEventHandler("transition_complete_map_in", CoD.GameGlobeZombie.MapIn)
	f1_arg0:registerEventHandler("transition_complete_rot_max_loop", CoD.GameGlobeZombie.RotMaxLoopFinish)
	f1_arg0:registerEventHandler("transition_complete_move_to_origin", CoD.GameGlobeZombie.MoveToOriginFinish)
	f1_arg0:registerEventHandler("transition_complete_move_to_corner_from_origin", CoD.GameGlobeZombie.MoveToCornerFromOriginFinish)
	f1_arg0:registerEventHandler("transition_complete_move_up", CoD.GameGlobeZombie.MoveUpFinish)
	f1_arg0:registerEventHandler("transition_complete_move_down_show", CoD.GameGlobeZombie.MoveDownShowFinish)
	f1_arg0:registerEventHandler("transition_complete_move_down", CoD.GameGlobeZombie.MoveDownFinish)
	f1_arg0:registerEventHandler("transition_complete_move_left", CoD.GameGlobeZombie.MoveLeftFinish)
	f1_arg0:registerEventHandler("transition_complete_next_map", CoD.SelectMapZombie.MapRotatingFinish)
	f1_arg0:registerEventHandler("transition_complete_next_map_intern", CoD.SelectMapZombie.NextMapInternFinish)
	f1_arg0:registerEventHandler("transition_complete_move_to_center", CoD.GameGlobeZombie.MoveToCenterFinish)
	f1_arg0:registerEventHandler("transition_complete_move_to_corner", CoD.GameGlobeZombie.MoveToCornerFinish)
	f1_arg0.isToLobby = false
	CoD.GameGlobeZombie.gameGlobe = f1_arg0
	CoD.GameGlobeZombie.gameGlobe.id = "gameglobe"
	CoD.GameGlobeZombie.InitialPath(f1_arg0)
end

CoD.GameGlobeZombie.InitialPath = function ()
	local f2_local0, f2_local1, f2_local2, f2_local3, f2_local4 = nil
	local f2_local5 = 0
	local f2_local6 = 0
	for f2_local7 = 2, CoD.GameGlobeZombie.MoveToCenterPathNodeCount, 1 do
		f2_local0 = f2_local7 - 1
		f2_local2 = CoD.GameGlobeZombie.MoveToCenterPath[f2_local0].x - CoD.GameGlobeZombie.MoveToCenterPath[f2_local7].x
		f2_local3 = CoD.GameGlobeZombie.MoveToCenterPath[f2_local0].y - CoD.GameGlobeZombie.MoveToCenterPath[f2_local7].y
		f2_local4 = math.sqrt(f2_local2 * f2_local2 + f2_local3 * f2_local3)
		CoD.GameGlobeZombie.MoveToCenterPath[f2_local7].forwardTime = f2_local4 / CoD.GameGlobeZombie.TranslatingSpeed
		f2_local5 = f2_local5 + f2_local4
		CoD.GameGlobeZombie.MoveToCenterPath[f2_local7].forwardDist = f2_local5
	end
	CoD.GameGlobeZombie.MoveToCenterPathDist = f2_local5
	for f2_local7 = CoD.GameGlobeZombie.MoveToCenterPathNodeCount - 1, 1, -1 do
		f2_local1 = f2_local7 + 1
		f2_local2 = CoD.GameGlobeZombie.MoveToCenterPath[f2_local1].x - CoD.GameGlobeZombie.MoveToCenterPath[f2_local7].x
		f2_local3 = CoD.GameGlobeZombie.MoveToCenterPath[f2_local1].y - CoD.GameGlobeZombie.MoveToCenterPath[f2_local7].y
		f2_local4 = math.sqrt(f2_local2 * f2_local2 + f2_local3 * f2_local3)
		CoD.GameGlobeZombie.MoveToCenterPath[f2_local7].backwardTime = f2_local4 / CoD.GameGlobeZombie.TranslatingSpeed
		f2_local6 = f2_local6 + f2_local4
		CoD.GameGlobeZombie.MoveToCenterPath[f2_local7].backwardDist = f2_local6
	end
end

CoD.GameGlobeZombie.MapIn = function (f3_arg0, f3_arg1)
	if CoD.GameGlobeZombie.gameGlobe.currentMenu ~= nil then
		CoD.GameGlobeZombie.gameGlobe.currentMenu.m_inputDisabled = true
	end
	f3_arg0:beginAnimation("move_to_corner_from_origin", 785 / CoD.GameGlobeZombie.TranslatingSpeed)
	f3_arg0:setShaderVector(2, CoD.GameGlobeZombie.ShaderVector2X, CoD.GameGlobeZombie.ShaderVector2YMin, CoD.GameGlobeZombie.ShaderVector2Z, 0)
	f3_arg0:setLeftRight(false, false, -450 - CoD.GameGlobeZombie.CornerRadius, -450 + CoD.GameGlobeZombie.CornerRadius)
	f3_arg0:setTopBottom(false, false, 100 - CoD.GameGlobeZombie.CornerRadius, 100 + CoD.GameGlobeZombie.CornerRadius)
	CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = 2
	Engine.PlaySound("zmb_ui_globe_in_short_1")
end

CoD.GameGlobeZombie.MoveToCornerFromOriginFinish = function (f4_arg0, f4_arg1)
	if f4_arg1.interrupted == nil then
		CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = 0
		if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == true or UIExpression.SessionMode_IsSystemlinkGame() == 1 then
			CoD.GameGlobeZombie.isMoveToCenterDirect = true
			CoD.GameGlobeZombie.MoveToCenter(CoD.GameGlobeZombie.gameGlobe.currentMenu.m_ownerController)
		else
			CoD.GameMoonZombie.FadeInFlare()
			CoD.GameGlobeZombie.isMoveToCenterDirect = false
			if nil ~= CoD.GameGlobeZombie.gameGlobe.currentMenu and nil == CoD.GameGlobeZombie.gameGlobe.currentMenu.occludedBy then
				CoD.GameGlobeZombie.gameGlobe.currentMenu.m_inputDisabled = false
			end
			local f4_local0, f4_local1, f4_local2, f4_local3 = CoD.GameGlobeZombie.gameGlobe:getShaderVector2()
			local f4_local4 = (CoD.GameGlobeZombie.ShaderVector2YMax - f4_local1) / CoD.GameGlobeZombie.SelfRotationSpeed
			CoD.GameGlobeZombie.gameGlobe:completeAnimation()
			CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, f4_local0, f4_local1, f4_local2, f4_local3)
			CoD.GameGlobeZombie.RotateMaxLoopAnim(f4_local4)
		end
	end
	CoD.GameMoonZombie.FadeOutSun()
end

CoD.GameGlobeZombie.RotMaxLoopFinish = function (f5_arg0, f5_arg1)
	if f5_arg1.interrupted == nil then
		f5_arg0:setShaderVector(2, CoD.GameGlobeZombie.ShaderVector2X, CoD.GameGlobeZombie.ShaderVector2YMin, CoD.GameGlobeZombie.ShaderVector2Z, 0)
		CoD.GameGlobeZombie.RotateMaxLoopAnim(2 * math.pi / CoD.GameGlobeZombie.SelfRotationSpeed)
	end
end

CoD.GameGlobeZombie.MoveToCenter = function (f6_arg0)
	if CoD.GameGlobeZombie.gameGlobe.currentMenu ~= nil then
		CoD.GameGlobeZombie.gameGlobe.currentMenu.m_inputDisabled = true
	end
	CoD.GameGlobeZombie.gameGlobe.controller = f6_arg0
	CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = 2
	local f6_local0, f6_local1, f6_local2, f6_local3 = CoD.GameGlobeZombie.gameGlobe:getShaderVector2()
	CoD.GameGlobeZombie.gameGlobe:completeAnimation()
	CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, f6_local0, f6_local1, f6_local2, f6_local3)
	CoD.GameGlobeZombie.XRotCurrent = f6_local0
	CoD.GameGlobeZombie.YRotCurrent = f6_local1
	CoD.GameGlobeZombie.ZRotCurrent = f6_local2
	CoD.GameGlobeZombie.RegisterMoveToCenterState()
	Engine.PlaySound("zmb_ui_globe_in_short_2")
	Engine.PlayRumble(f6_arg0, CoD.GameGlobeZombie.LowRumble, CoD.GameGlobeZombie.HighRumble)
	CoD.GameMoonZombie.FadeOutFlare()
end

CoD.GameGlobeZombie.RegisterMoveToCenterState = function ()
	local f7_local0 = CoD.GameGlobeZombie.MoveToCenterPath[CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex]
	local f7_local1 = CoD.GameGlobeZombie.MoveToCenterPath[CoD.GameGlobeZombie.MoveToCenterPathNodeMidIndex]
	local f7_local2 = 0
	local f7_local3 = 0
	if CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex <= CoD.GameGlobeZombie.MoveToCenterPathNodeMidIndex then
		f7_local2 = CoD.GameGlobeZombie.CornerRadius + (CoD.GameGlobeZombie.MidRadius - CoD.GameGlobeZombie.CornerRadius) * f7_local0.forwardDist / f7_local1.forwardDist
	else
		f7_local2 = CoD.GameGlobeZombie.MidRadius + (CoD.GameGlobeZombie.CenterRadius - CoD.GameGlobeZombie.MidRadius) * (f7_local0.forwardDist - f7_local1.forwardDist) / (CoD.GameGlobeZombie.MoveToCenterPathDist - f7_local1.forwardDist)
	end
	f7_local3 = f7_local0.forwardDist / CoD.GameGlobeZombie.MoveToCenterPathDist
	local f7_local4 = CoD.GameGlobeZombie.YRotCurrent + 5 * CoD.GameGlobeZombie.SelfRotationSpeed * f7_local0.forwardDist / CoD.GameGlobeZombie.TranslatingSpeed
	CoD.GameGlobeZombie.gameGlobe:beginAnimation("move_to_center", f7_local0.forwardTime)
	CoD.GameGlobeZombie.gameGlobe:setLeftRight(false, false, f7_local0.x - f7_local2, f7_local0.x + f7_local2)
	CoD.GameGlobeZombie.gameGlobe:setTopBottom(false, false, f7_local0.y - f7_local2, f7_local0.y + f7_local2)
	CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, CoD.GameGlobeZombie.XRotCurrent, f7_local4, CoD.GameGlobeZombie.ZRotCurrent, 0)
end

CoD.GameGlobeZombie.MoveToCenterFinish = function (f8_arg0, f8_arg1)
	if f8_arg1.interrupted == nil then
		CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex + 1
		if CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex <= CoD.GameGlobeZombie.MoveToCenterPathNodeCount then
			CoD.GameGlobeZombie.RegisterMoveToCenterState()
		else
			CoD.SelectMapZombie.GoToFirstMap(f8_arg0, CoD.GameGlobeZombie.gameGlobe.controller, false)
			Engine.PlayRumble(CoD.GameGlobeZombie.gameGlobe.controller, 0, 0)
			CoD.GameMoonZombie.FadeInFlareLeft()
		end
	end
end

CoD.GameGlobeZombie.MoveToCorner = function (f9_arg0)
	if CoD.GameGlobeZombie.gameGlobe.currentMenu ~= nil then
		CoD.GameGlobeZombie.gameGlobe.currentMenu.m_inputDisabled = true
	end
	CoD.GameGlobeZombie.gameGlobe.isAnimating = true
	CoD.GameGlobeZombie.gameGlobe.controller = f9_arg0
	CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = CoD.GameGlobeZombie.MoveToCenterPathNodeCount - 1
	local f9_local0, f9_local1, f9_local2, f9_local3 = CoD.GameGlobeZombie.gameGlobe:getShaderVector2()
	CoD.GameGlobeZombie.gameGlobe:completeAnimation()
	CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, f9_local0, f9_local1, f9_local2, f9_local3)
	CoD.GameGlobeZombie.XRotCurrent = f9_local0
	CoD.GameGlobeZombie.YRotCurrent = f9_local1
	CoD.GameGlobeZombie.ZRotCurrent = f9_local2
	CoD.GameGlobeZombie.RegisterMoveToCornerState()
	Engine.PlaySound("zmb_ui_globe_out_short_1")
	Engine.PlayRumble(f9_arg0, CoD.GameGlobeZombie.LowRumble, CoD.GameGlobeZombie.HighRumble)
	CoD.GameMoonZombie.FadeOutFlareLeft()
end

CoD.GameGlobeZombie.RegisterMoveToCornerState = function ()
	local f10_local0 = CoD.GameGlobeZombie.MoveToCenterPath[CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex]
	local f10_local1 = CoD.GameGlobeZombie.MoveToCenterPath[CoD.GameGlobeZombie.MoveToCenterPathNodeMidIndex]
	local f10_local2 = 0
	local f10_local3 = 0
	if CoD.GameGlobeZombie.MoveToCenterPathNodeMidIndex <= CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex then
		f10_local2 = CoD.GameGlobeZombie.CenterRadius + (CoD.GameGlobeZombie.MidRadius - CoD.GameGlobeZombie.CenterRadius) * f10_local0.backwardDist / f10_local1.backwardDist
	else
		f10_local2 = CoD.GameGlobeZombie.MidRadius + (CoD.GameGlobeZombie.CornerRadius - CoD.GameGlobeZombie.MidRadius) * (f10_local0.backwardDist - f10_local1.backwardDist) / (CoD.GameGlobeZombie.MoveToCenterPathDist - f10_local1.backwardDist)
	end
	f10_local3 = f10_local0.backwardDist / CoD.GameGlobeZombie.MoveToCenterPathDist
	local f10_local4 = CoD.GameGlobeZombie.XRotCurrent + (CoD.GameGlobeZombie.ShaderVector2X - CoD.GameGlobeZombie.XRotCurrent) * f10_local3
	local f10_local5 = CoD.GameGlobeZombie.YRotCurrent + (CoD.GameGlobeZombie.ShaderVector2YMax - CoD.GameGlobeZombie.YRotCurrent) * f10_local3
	local f10_local6 = CoD.GameGlobeZombie.ZRotCurrent + (CoD.GameGlobeZombie.ShaderVector2Z - CoD.GameGlobeZombie.ZRotCurrent) * f10_local3
	CoD.GameGlobeZombie.gameGlobe:beginAnimation("move_to_corner", f10_local0.backwardTime)
	CoD.GameGlobeZombie.gameGlobe:setLeftRight(false, false, f10_local0.x - f10_local2, f10_local0.x + f10_local2)
	CoD.GameGlobeZombie.gameGlobe:setTopBottom(false, false, f10_local0.y - f10_local2, f10_local0.y + f10_local2)
	CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, f10_local4, f10_local5, f10_local6, 0)
end

CoD.GameGlobeZombie.MoveToCornerFinish = function (f11_arg0, f11_arg1)
	if f11_arg1.interrupted == nil then
		CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex - 1
		if CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex >= 1 then
			CoD.GameGlobeZombie.RegisterMoveToCornerState()
		else
			CoD.GameGlobeZombie.gameGlobe.isAnimating = nil
			local f11_local0, f11_local1, f11_local2, f11_local3 = CoD.GameGlobeZombie.gameGlobe:getShaderVector2()
			local f11_local4 = (CoD.GameGlobeZombie.ShaderVector2YMax - f11_local1) / CoD.GameGlobeZombie.SelfRotationSpeed
			CoD.GameGlobeZombie.gameGlobe:completeAnimation()
			CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, f11_local0, f11_local1, f11_local2, f11_local3)
			CoD.GameGlobeZombie.RotateMaxLoopAnim(f11_local4)
			if nil ~= CoD.GameGlobeZombie.gameGlobe.currentMenu and nil == CoD.GameGlobeZombie.gameGlobe.currentMenu.occludedBy then
				CoD.GameGlobeZombie.gameGlobe.currentMenu.m_inputDisabled = false
			end
			if not CoD.GameGlobeZombie.gameGlobe.skipOpenMenuWhenAnimFinishs then
				f11_arg0.currentMenu:goBack(CoD.GameGlobeZombie.gameGlobe.controller)
			end
			CoD.GameGlobeZombie.gameGlobe.skipOpenMenuWhenAnimFinishs = nil
			Engine.PlayRumble(CoD.GameGlobeZombie.gameGlobe.controller, 0, 0)
			if not CoD.GameGlobeZombie.isMoveToCenterDirect then
				CoD.GameMoonZombie.FadeInFlare()
				CoD.GameGlobeZombie.isMoveToCenterDirect = nil
			end
		end
	else
		CoD.GameGlobeZombie.gameGlobe.isAnimating = nil
	end
end

CoD.GameGlobeZombie.MoveUp = function (f12_arg0)
	if CoD.GameGlobeZombie.gameGlobe.currentMenu ~= nil then
		CoD.GameGlobeZombie.gameGlobe.currentMenu.m_inputDisabled = true
	end
	CoD.GameGlobeZombie.MoveUpAnim(500 / CoD.GameGlobeZombie.ScalingSpeed)
	CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = 2
	CoD.GameGlobeZombie.gameGlobe.controller = f12_arg0
	Engine.PlaySound("zmb_ui_map_zoom_in")
	Engine.PlayRumble(f12_arg0, CoD.GameGlobeZombie.LowRumble, CoD.GameGlobeZombie.HighRumble)
	CoD.GameMoonZombie.FadeOutFlareLeft()
end

CoD.GameGlobeZombie.MoveUpFinish = function (f13_arg0, f13_arg1)
	if f13_arg1.interrupted == nil then
		CoD.GameGlobeZombie.MoveUpHideAnim(500 / CoD.GameGlobeZombie.ScalingSpeed)
		CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = CoD.GameGlobeZombie.MoveToCenterPathNodeCount + 1
		Engine.PlayRumble(CoD.GameGlobeZombie.gameGlobe.controller, 0, 0)
		CoD.GameMapZombie.SwitchToMap()
	end
end

CoD.GameGlobeZombie.MoveDownShow = function (f14_arg0)
	if CoD.GameGlobeZombie.gameGlobe.currentMenu ~= nil then
		CoD.GameGlobeZombie.gameGlobe.currentMenu.m_inputDisabled = true
	end
	CoD.GameGlobeZombie.gameGlobe.controller = f14_arg0
	CoD.GameGlobeZombie.gameGlobe.isToCorner = false
	CoD.GameGlobeZombie.MoveDownShowAnim(500 / CoD.GameGlobeZombie.ScalingSpeed)
	CoD.GameMapZombie.MoveDown(500 / CoD.GameMapZombie.ScalingSpeed)
	Engine.PlaySound("zmb_ui_map_zoom_out")
end

CoD.GameGlobeZombie.MoveDownShowFinish = function (f15_arg0, f15_arg1)
	if f15_arg1.interrupted == nil then
		if f15_arg0.isToCorner == true then
			CoD.GameGlobeZombie.MoveLeftAnim(1000 / CoD.GameGlobeZombie.ScalingSpeed)
			f15_arg0.isToCorner = false
		else
			CoD.GameGlobeZombie.MoveDownAnim(500 / CoD.GameGlobeZombie.ScalingSpeed)
		end
		CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = CoD.GameGlobeZombie.MoveToCenterPathNodeCount - 1
		Engine.PlayRumble(CoD.GameGlobeZombie.gameGlobe.controller, CoD.GameGlobeZombie.LowRumble, CoD.GameGlobeZombie.HighRumble)
	end
end

CoD.GameGlobeZombie.MoveLeftFinish = function (f16_arg0, f16_arg1)
	if f16_arg1.interrupted == nil then
		local f16_local0, f16_local1, f16_local2, f16_local3 = CoD.GameGlobeZombie.gameGlobe:getShaderVector2()
		local f16_local4 = (CoD.GameGlobeZombie.ShaderVector2YMax - f16_local1) / CoD.GameGlobeZombie.SelfRotationSpeed
		CoD.GameGlobeZombie.gameGlobe:completeAnimation()
		CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, f16_local0, f16_local1, f16_local2, f16_local3)
		CoD.GameGlobeZombie.RotateMaxLoopAnim(f16_local4)
		CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = 0
		CoD.GameMoonZombie.FadeInFlare()
	end
	Engine.PlayRumble(CoD.GameGlobeZombie.gameGlobe.controller, 0, 0)
end

CoD.GameGlobeZombie.MoveDownFinish = function (f17_arg0, f17_arg1)
	if f17_arg1.interrupted == nil then
		if nil ~= CoD.GameGlobeZombie.gameGlobe.currentMenu and nil == CoD.GameGlobeZombie.gameGlobe.currentMenu.occludedBy then
			CoD.GameGlobeZombie.gameGlobe.currentMenu.m_inputDisabled = false
		end
		if CoD.GameGlobeZombie.gameGlobe.isToCorner == false then
			CoD.SelectMapZombie.GoToFirstMap(f17_arg0, CoD.GameGlobeZombie.gameGlobe.controller, true)
		end
		CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = 0
		CoD.GameMoonZombie.FadeInFlareLeft()
	end
	Engine.PlayRumble(CoD.GameGlobeZombie.gameGlobe.controller, 0, 0)
end

CoD.GameGlobeZombie.MoveToCornerFromUp = function (f18_arg0, f18_arg1)
	if CoD.GameGlobeZombie.gameGlobe.currentMenu ~= nil then
		CoD.GameGlobeZombie.gameGlobe.currentMenu.m_inputDisabled = true
	end
	CoD.GameGlobeZombie.gameGlobe.controller = f18_arg0
	CoD.GameGlobeZombie.gameGlobe.isToCorner = true
	if f18_arg1 == nil or f18_arg1 then
		CoD.GameGlobeZombie.MoveDownShowAnim(500 / CoD.GameGlobeZombie.ScalingSpeed)
	end
	CoD.GameMapZombie.gameMap.isToCorner = true
	CoD.GameMapZombie.MoveDown(500 / CoD.GameMapZombie.ScalingSpeed)
	Engine.PlaySound("zmb_ui_globe_in_short_1")
end

CoD.GameGlobeZombie.MoveToExpectedMap = function ()
	CoD.globe.shown = true
	CoD.GameGlobeZombie.gameGlobe:beginAnimation("move_to_expected_map")
	CoD.GameGlobeZombie.gameGlobe:setAlpha(0)
	CoD.GameGlobeZombie.gameGlobe:setZoom(600)
	CoD.GameGlobeZombie.gameGlobe:setLeftRight(false, false, -1440, 1440)
	CoD.GameGlobeZombie.gameGlobe:setTopBottom(false, false, -1440 + CoD.GameGlobeZombie.PlaceYOffSet, 1440 + CoD.GameGlobeZombie.PlaceYOffSet)
	CoD.GameGlobeZombie.gameGlobe:setShaderVector(0, 2, 2, 0, 0)
	local f19_local0 = CoD.Zombie.GetUIMapName()
	CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, tonumber(UIExpression.TableLookup(controller, UIExpression.GetCurrentMapTableName(), 0, f19_local0, 17)) * CoD.GameGlobeZombie.DegreesToRadiansScale, tonumber(UIExpression.TableLookup(controller, UIExpression.GetCurrentMapTableName(), 0, f19_local0, 16)) * CoD.GameGlobeZombie.DegreesToRadiansScale, CoD.GameGlobeZombie.ShaderVector2Z, 0)
end

CoD.GameGlobeZombie.MoveToUpDirectly = function ()
	CoD.GameGlobeZombie.MoveToExpectedMap()
	CoD.GameMapZombie.SwitchToMapDirect(2, true, 0)
	CoD.GameMoonZombie.FadeOutFlares()
	if Engine.GameModeIsMode(CoD.GAMEMODE_LOCAL_SPLITSCREEN) == true or UIExpression.SessionMode_IsSystemlinkGame() == 1 then
		CoD.GameGlobeZombie.isMoveToCenterDirect = true
	else
		CoD.GameGlobeZombie.isMoveToCenterDirect = false
	end
end

CoD.GameGlobeZombie.MoveToCornerJoinLobby = function ()
	CoD.GameGlobeZombie.gameGlobe:setAlpha(1)
	CoD.GameGlobeZombie.gameGlobe:setZoom(0)
	CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, CoD.GameGlobeZombie.ShaderVector2X, CoD.GameGlobeZombie.ShaderVector2YMin, CoD.GameGlobeZombie.ShaderVector2Z, 0)
	CoD.GameGlobeZombie.gameGlobe:setLeftRight(false, false, -450 - CoD.GameGlobeZombie.CornerRadius, -450 + CoD.GameGlobeZombie.CornerRadius)
	CoD.GameGlobeZombie.gameGlobe:setTopBottom(false, false, 100 - CoD.GameGlobeZombie.CornerRadius, 100 + CoD.GameGlobeZombie.CornerRadius)
	CoD.GameGlobeZombie.RotateMaxLoopAnim(2 * math.pi / CoD.GameGlobeZombie.SelfRotationSpeed)
	CoD.GameMapZombie.DefaultAnim(0)
	CoD.GameRockZombie.ShowAll()
	CoD.GameMoonZombie.FadeInFlare()
end

CoD.GameGlobeZombie.MoveToOrigin = function ()
	if CoD.GameGlobeZombie.gameGlobe.currentMenu ~= nil then
		CoD.GameGlobeZombie.gameGlobe.currentMenu.m_inputDisabled = true
	end
	local f22_local0, f22_local1, f22_local2, f22_local3 = CoD.GameGlobeZombie.gameGlobe:getShaderVector2()
	CoD.GameGlobeZombie.gameGlobe:completeAnimation()
	CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, f22_local0, f22_local1, f22_local2, f22_local3)
	CoD.GameGlobeZombie.gameGlobe:beginAnimation("move_to_origin", 785 / CoD.GameGlobeZombie.TranslatingSpeed)
	CoD.GameGlobeZombie.gameGlobe:setLeftRight(false, false, -1200 - CoD.GameGlobeZombie.FirstRadius, -1200 + CoD.GameGlobeZombie.FirstRadius)
	CoD.GameGlobeZombie.gameGlobe:setTopBottom(false, false, 333 - CoD.GameGlobeZombie.FirstRadius, 333 + CoD.GameGlobeZombie.FirstRadius)
	CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, CoD.GameGlobeZombie.ShaderVector2X, f22_local1 + 785 / CoD.GameGlobeZombie.TranslatingSpeed * CoD.GameGlobeZombie.SelfRotationSpeed, CoD.GameGlobeZombie.ShaderVector2Z, 0)
	CoD.GameGlobeZombie.gameGlobe:setScale(1)
	CoD.GameGlobeZombie.gameGlobe:setZoom(0)
	CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = 2
	CoD.GameMoonZombie.FadeOutFlare()
	CoD.GameMoonZombie.FadeInSun()
	Engine.PlaySound("zmb_ui_globe_out_short_2")
end

CoD.GameGlobeZombie.MoveToOriginFinish = function (f23_arg0, f23_arg1)
	if f23_arg1.interrupted == nil then
		if nil ~= CoD.GameGlobeZombie.gameGlobe.currentMenu and nil == CoD.GameGlobeZombie.gameGlobe.currentMenu.occludedBy then
			CoD.GameGlobeZombie.gameGlobe.currentMenu.m_inputDisabled = false
		end
		CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex = 0
		CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, CoD.GameGlobeZombie.ShaderVector2X, CoD.GameGlobeZombie.ShaderVector2YMin - 785 / CoD.GameGlobeZombie.TranslatingSpeed * CoD.GameGlobeZombie.SelfRotationSpeed, CoD.GameGlobeZombie.ShaderVector2Z, 0)
	end
end

CoD.GameGlobeZombie.StartShake = function (f24_arg0, f24_arg1)
	f24_arg0.ShakingScaleCurrent = f24_arg1
	f24_arg0:registerEventHandler("transition_complete_shaking", CoD.GameGlobeZombie.ShakingFinish)
	CoD.GameGlobeZombie.RegisterShakingState(f24_arg0)
end

CoD.GameGlobeZombie.RegisterShakingState = function (f25_arg0)
	local f25_local0 = math.random(-f25_arg0.ShakingScaleCurrent, f25_arg0.ShakingScaleCurrent)
	local f25_local1 = math.random(-f25_arg0.ShakingScaleCurrent, f25_arg0.ShakingScaleCurrent)
	f25_arg0:beginAnimation("shaking", 20 / f25_arg0.ShakingScaleCurrent)
	f25_arg0:setLeftRight(true, true, f25_local0, f25_local0)
	f25_arg0:setTopBottom(true, true, f25_local1, f25_local1)
end

CoD.GameGlobeZombie.ShakingFinish = function (f26_arg0, f26_arg1)
	if f26_arg1.interrupted == nil and CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex <= CoD.GameGlobeZombie.MoveToCenterPathNodeCount and CoD.GameGlobeZombie.MoveToCenterPathNodeCurrentIndex >= 1 then
		CoD.GameGlobeZombie.RegisterShakingState(f26_arg0)
	end
end

CoD.GameGlobeZombie.MoveUpAnim = function (f27_arg0)
	CoD.GameGlobeZombie.gameGlobe:beginAnimation("move_up", f27_arg0)
	CoD.GameGlobeZombie.gameGlobe:setZoom(300)
	CoD.GameGlobeZombie.gameGlobe:setLeftRight(false, false, -720, 720)
	CoD.GameGlobeZombie.gameGlobe:setTopBottom(false, false, -720 + CoD.GameGlobeZombie.PlaceYOffSet, 720 + CoD.GameGlobeZombie.PlaceYOffSet)
end

CoD.GameGlobeZombie.MoveUpHideAnim = function (f28_arg0)
	CoD.GameGlobeZombie.gameGlobe:beginAnimation("move_up_hide", f28_arg0)
	CoD.GameGlobeZombie.gameGlobe:setAlpha(0)
	CoD.GameGlobeZombie.gameGlobe:setZoom(600)
	CoD.GameGlobeZombie.gameGlobe:setLeftRight(false, false, -1440, 1440)
	CoD.GameGlobeZombie.gameGlobe:setTopBottom(false, false, -1440 + CoD.GameGlobeZombie.PlaceYOffSet, 1440 + CoD.GameGlobeZombie.PlaceYOffSet)
end

CoD.GameGlobeZombie.MoveDownAnim = function (f29_arg0)
	CoD.GameGlobeZombie.gameGlobe:beginAnimation("move_down", f29_arg0)
	CoD.GameGlobeZombie.gameGlobe:setZoom(0)
	CoD.GameGlobeZombie.gameGlobe:setLeftRight(false, false, -240, 240)
	CoD.GameGlobeZombie.gameGlobe:setTopBottom(false, false, -240 + CoD.GameGlobeZombie.PlaceYOffSet, 240 + CoD.GameGlobeZombie.PlaceYOffSet)
end

CoD.GameGlobeZombie.MoveDownShowAnim = function (f30_arg0)
	CoD.GameGlobeZombie.gameGlobe:beginAnimation("move_down_show", f30_arg0)
	CoD.GameGlobeZombie.gameGlobe:setAlpha(1)
	CoD.GameGlobeZombie.gameGlobe:setZoom(300)
	CoD.GameGlobeZombie.gameGlobe:setLeftRight(false, false, -720, 720)
	CoD.GameGlobeZombie.gameGlobe:setTopBottom(false, false, -720 + CoD.GameGlobeZombie.PlaceYOffSet, 720 + CoD.GameGlobeZombie.PlaceYOffSet)
end

CoD.GameGlobeZombie.MoveLeftAnim = function (f31_arg0)
	CoD.GameGlobeZombie.gameGlobe:beginAnimation("move_left", f31_arg0)
	CoD.GameGlobeZombie.gameGlobe:setZoom(0)
	CoD.GameGlobeZombie.gameGlobe:setLeftRight(false, false, -450 - CoD.GameGlobeZombie.CornerRadius, -450 + CoD.GameGlobeZombie.CornerRadius)
	CoD.GameGlobeZombie.gameGlobe:setTopBottom(false, false, 100 - CoD.GameGlobeZombie.CornerRadius, 100 + CoD.GameGlobeZombie.CornerRadius)
	CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, CoD.GameGlobeZombie.ShaderVector2X, CoD.GameGlobeZombie.ShaderVector2YMax, CoD.GameGlobeZombie.ShaderVector2Z, 0)
end

CoD.GameGlobeZombie.RotateMaxLoopAnim = function (f32_arg0)
	CoD.GameGlobeZombie.gameGlobe:beginAnimation("rot_max_loop", f32_arg0)
	CoD.GameGlobeZombie.gameGlobe:setShaderVector(2, CoD.GameGlobeZombie.ShaderVector2X, CoD.GameGlobeZombie.ShaderVector2YMax, CoD.GameGlobeZombie.ShaderVector2Z, 0)
end

