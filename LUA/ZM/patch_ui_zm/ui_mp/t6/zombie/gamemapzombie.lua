CoD.GameMapZombie = {}
CoD.GameMapZombie.gameMap = nil
CoD.GameMapZombie.ScalingSpeed = 1.3
CoD.GameMapZombie.ShakingScaleSmall = 1
CoD.GameMapZombie.ShakingScaleMedium = 2
CoD.GameMapZombie.ShakingAnimTimeMedium = 15
CoD.GameMapZombie.ShakingAnimTimeLong = 30
CoD.GameMapZombie.ShakingAnimTimeFloating = 1500
CoD.GameMapZombie.BlurredImages = {}
CoD.GameMapZombie.Init = function (f1_arg0, f1_arg1)
	CoD.GameMapZombie.gameMap = f1_arg0
	CoD.GameMapZombie.gameMap.id = "gamemap"
	CoD.GameMapZombie.defaultMaterial = f1_arg1
	CoD.GameMapZombie.gameMap:setLeftRight(false, false, -CoD.Zombie.FullScreenSize.w * 0.5, CoD.Zombie.FullScreenSize.w * 0.5)
	CoD.GameMapZombie.gameMap:setTopBottom(false, false, -CoD.Zombie.FullScreenSize.h * 0.5, CoD.Zombie.FullScreenSize.h * 0.5)
	CoD.GameMapZombie.gameMap:registerEventHandler("transition_complete_move_down", CoD.GameMapZombie.MoveDownFinish)
	CoD.GameMapZombie.gameMap:registerEventHandler("transition_complete_move_up", CoD.GameMapZombie.MoveUpFinish)
end

CoD.GameMapZombie.SwitchToMapDirect = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = CoD.Zombie.GetUIMapName()
	local f2_local1 = "menu_" .. f2_local0 .. "_map"
	if f2_arg1 == true then
		f2_local1 = f2_local1 .. "_blur"
	end
	if not Engine.HasDLCContent(UIExpression.TableLookup(nil, CoD.mapsTable, 0, f2_local0, 11)) then
		CoD.GameMapZombie.gameMap:setAlpha(0)
	else
		if CoD.GameMapZombie.BlurredImages[f2_local1] then
			CoD.GameMapZombie.gameMap:setAlpha(1)
		else
			CoD.GameMapZombie.gameMap:setAlpha(0)
		end
		CoD.GameMapZombie.gameMap:setImage(RegisterMaterial(f2_local1))
	end
	CoD.GameMapZombie.gameMap:registerEventHandler("streamed_image_ready", function (Sender, Event)
		Sender:setAlpha(1)
		CoD.GameMapZombie.BlurredImages[f2_local1] = true
	end)
	CoD.GameMapZombie.gameMap:setupUIStreamedImage(0)
	if f2_arg2 ~= nil and f2_arg2 > 0 then
		CoD.GameMapZombie.gameMap:beginAnimation("map", f2_arg2)
	end
	CoD.GameMapZombie.gameMap:setScale(f2_arg0)
	CoD.GameRockZombie.HideAll()
end

CoD.GameMapZombie.SwitchToMap = function ()
	CoD.GameMapZombie.SwitchToMapDirect(1)
	CoD.Fog.Show(500 / CoD.GameMapZombie.ScalingSpeed)
	CoD.Fog.StartMoving()
	CoD.GameMapZombie.MoveUpAnim(500 / CoD.GameMapZombie.ScalingSpeed)
end

CoD.GameMapZombie.MoveDown = function (f4_arg0)
	CoD.GameMapZombie.MoveDownAnim(f4_arg0)
	CoD.Fog.Hide(f4_arg0)
end

CoD.GameMapZombie.MoveDownFinish = function (f5_arg0, f5_arg1)
	if f5_arg1.interrupted == nil then
		if CoD.GameGlobeZombie.gameGlobe.isToCorner == true then
			CoD.GameGlobeZombie.gameGlobe.currentMenu:processEvent({
				name = "confirm_leave_animfinished",
				controller = CoD.GameGlobeZombie.gameGlobe.controller
			})
		else
			f5_arg0.currentMenu:goBack(CoD.GameGlobeZombie.gameGlobe.controller)
		end
		CoD.GameMapZombie.DefaultAnim(0)
		CoD.GameRockZombie.ShowAll()
	elseif Engine.SessionModeIsMode(CoD.SESSIONMODE_SYSTEMLINK) == true and CoD.GameGlobeZombie.gameGlobe.isToCorner == true then
		CoD.GameGlobeZombie.gameGlobe.currentMenu:processEvent({
			name = "confirm_leave_animfinished",
			controller = CoD.GameGlobeZombie.gameGlobe.controller
		})
	end
end

CoD.GameMapZombie.MoveUpFinish = function (f6_arg0, f6_arg1)
	if f6_arg1.interrupted == nil then
		CoD.SelectStartLocZombie.ShowStartLoc(f6_arg0.currentMenu)
		f6_arg0:setLeftRight(false, false, -CoD.Zombie.FullScreenSize.w * 0.5, CoD.Zombie.FullScreenSize.w * 0.5)
		f6_arg0:setTopBottom(false, false, -CoD.Zombie.FullScreenSize.h * 0.5, CoD.Zombie.FullScreenSize.h * 0.5)
	end
end

CoD.GameMapZombie.DefaultAnim = function (f7_arg0)
	CoD.GameMapZombie.gameMap:setImage(CoD.GameMapZombie.defaultMaterial)
	CoD.GameMapZombie.gameMap:beginAnimation("default", f7_arg0)
	CoD.GameMapZombie.gameMap:setScale(1)
end

CoD.GameMapZombie.ShowAnim = function (f8_arg0)
	CoD.GameMapZombie.gameMap:beginAnimation("show", f8_arg0)
	CoD.GameMapZombie.gameMap:setAlpha(1)
end

CoD.GameMapZombie.HideAnim = function (f9_arg0)
	CoD.GameMapZombie.gameMap:beginAnimation("hide", f9_arg0)
	CoD.GameMapZombie.gameMap:setAlpha(0)
end

CoD.GameMapZombie.MoveUpAnim = function (f10_arg0)
	CoD.GameMapZombie.gameMap:beginAnimation("move_up", f10_arg0)
	CoD.GameMapZombie.gameMap:setScale(2)
end

CoD.GameMapZombie.MoveDownAnim = function (f11_arg0)
	CoD.GameMapZombie.gameMap:beginAnimation("move_down", f11_arg0)
	CoD.GameMapZombie.gameMap:setScale(1)
end

