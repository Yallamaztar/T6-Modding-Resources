CoD.GameRockZombie = {}
CoD.GameRockZombie.gameRocksFront = nil
CoD.GameRockZombie.gameRocksBack = nil
CoD.GameRockZombie.ShouldStop = nil
CoD.GameRockZombie.RockTileWidth = 1800
CoD.GameRockZombie.RockTileHeight = 400
CoD.GameRockZombie.RockBackMaterial = RegisterMaterial("lui_bkg_zm_rocks_back")
CoD.GameRockZombie.RockFrontMaterial = RegisterMaterial("lui_bkg_zm_rocks_front")
CoD.GameRockZombie.RockFrontBMaterial = RegisterMaterial("lui_bkg_zm_rocks_front_forward")
CoD.GameRockZombie.RockFrontPath = {}
CoD.GameRockZombie.RockFrontTranslatingSpeed = 0.05
CoD.GameRockZombie.RockFrontPathNodeCount = 3
CoD.GameRockZombie.RockFrontPathNodeCurrentIndex = 1
CoD.GameRockZombie.RockFrontPath[1] = {
	x = -CoD.GameRockZombie.RockTileWidth * 0.8,
	y = CoD.GameRockZombie.RockTileHeight * 2.48
}
CoD.GameRockZombie.RockFrontPath[2] = {
	x = 0,
	y = CoD.GameRockZombie.RockTileHeight * 0.4
}
CoD.GameRockZombie.RockFrontPath[3] = {
	x = CoD.GameRockZombie.RockTileWidth * 0.8,
	y = CoD.GameRockZombie.RockTileHeight * -1.68
}
CoD.GameRockZombie.RockFrontBPath = {}
CoD.GameRockZombie.RockFrontBTranslatingSpeed = 0.07
CoD.GameRockZombie.RockFrontBPathNodeCount = 3
CoD.GameRockZombie.RockFrontBPathNodeCurrentIndex = 1
CoD.GameRockZombie.RockFrontBPath[1] = {
	x = -CoD.GameRockZombie.RockTileWidth * 0.8,
	y = CoD.GameRockZombie.RockTileHeight * 2.88
}
CoD.GameRockZombie.RockFrontBPath[2] = {
	x = 0,
	y = CoD.GameRockZombie.RockTileHeight * 0.8
}
CoD.GameRockZombie.RockFrontBPath[3] = {
	x = CoD.GameRockZombie.RockTileWidth * 0.8,
	y = CoD.GameRockZombie.RockTileHeight * -1.28
}
CoD.GameRockZombie.RockBackPath = {}
CoD.GameRockZombie.RockBackTranslatingSpeed = 0.02
CoD.GameRockZombie.RockBackPathNodeCount = 3
CoD.GameRockZombie.RockBackPathNodeCurrentIndex = 1
CoD.GameRockZombie.RockBackPath[1] = {
	x = CoD.GameRockZombie.RockTileWidth * 0.8,
	y = CoD.GameRockZombie.RockTileHeight * -2.48
}
CoD.GameRockZombie.RockBackPath[2] = {
	x = 0,
	y = CoD.GameRockZombie.RockTileHeight * -0.4
}
CoD.GameRockZombie.RockBackPath[3] = {
	x = -CoD.GameRockZombie.RockTileWidth * 0.8,
	y = CoD.GameRockZombie.RockTileHeight * 1.68
}
CoD.GameRockZombie.Init = function (f1_arg0, f1_arg1)
	f1_arg0:setLeftRight(true, true, 0, 0)
	f1_arg0:setTopBottom(true, true, 0, 0)
	CoD.GameRockZombie.gameRocksFront = f1_arg0
	CoD.GameRockZombie.InitPath()
	local f1_local0 = LUI.UIImage.new()
	f1_local0:setImage(CoD.GameRockZombie.RockFrontMaterial)
	f1_local0:setLeftRight(false, false, CoD.GameRockZombie.RockFrontPath[1].x - CoD.GameRockZombie.RockTileWidth * 0.5, CoD.GameRockZombie.RockFrontPath[1].x + CoD.GameRockZombie.RockTileWidth * 0.5)
	f1_local0:setTopBottom(false, false, CoD.GameRockZombie.RockFrontPath[1].y - CoD.GameRockZombie.RockTileHeight * 0.5, CoD.GameRockZombie.RockFrontPath[1].y + CoD.GameRockZombie.RockTileHeight * 0.5)
	f1_local0:setZRot(CoD.GameGlobeZombie.ShaderVector2X / CoD.GameGlobeZombie.DegreesToRadiansScale)
	f1_local0:registerEventHandler("transition_complete_move_to_next", CoD.GameRockZombie.RockFront1MoveToNextFinish)
	CoD.GameRockZombie.gameRocksFront.rock1 = f1_local0
	f1_arg0:addElement(f1_local0)
	local f1_local1 = LUI.UIImage.new()
	f1_local1:setImage(CoD.GameRockZombie.RockFrontMaterial)
	f1_local1:setLeftRight(false, false, CoD.GameRockZombie.RockFrontPath[1].x - CoD.GameRockZombie.RockTileWidth * 0.5, CoD.GameRockZombie.RockFrontPath[1].x + CoD.GameRockZombie.RockTileWidth * 0.5)
	f1_local1:setTopBottom(false, false, CoD.GameRockZombie.RockFrontPath[1].y - CoD.GameRockZombie.RockTileHeight * 0.5, CoD.GameRockZombie.RockFrontPath[1].y + CoD.GameRockZombie.RockTileHeight * 0.5)
	f1_local1:setZRot(CoD.GameGlobeZombie.ShaderVector2X / CoD.GameGlobeZombie.DegreesToRadiansScale)
	CoD.GameRockZombie.gameRocksFront.rock2 = f1_local1
	f1_arg0:addElement(f1_local1)
	local f1_local2 = LUI.UIImage.new()
	f1_local2:setImage(CoD.GameRockZombie.RockFrontBMaterial)
	f1_local2:setLeftRight(false, false, CoD.GameRockZombie.RockFrontBPath[1].x - CoD.GameRockZombie.RockTileWidth * 0.5, CoD.GameRockZombie.RockFrontBPath[1].x + CoD.GameRockZombie.RockTileWidth * 0.5)
	f1_local2:setTopBottom(false, false, CoD.GameRockZombie.RockFrontBPath[1].y - CoD.GameRockZombie.RockTileHeight * 0.5, CoD.GameRockZombie.RockFrontBPath[1].y + CoD.GameRockZombie.RockTileHeight * 0.5)
	f1_local2:setZRot(CoD.GameGlobeZombie.ShaderVector2X / CoD.GameGlobeZombie.DegreesToRadiansScale)
	f1_local2:registerEventHandler("transition_complete_move_to_next", CoD.GameRockZombie.RockFront3MoveToNextFinish)
	CoD.GameRockZombie.gameRocksFront.rock3 = f1_local2
	f1_arg0:addElement(f1_local2)
	local f1_local3 = LUI.UIImage.new()
	f1_local3:setImage(CoD.GameRockZombie.RockFrontBMaterial)
	f1_local3:setLeftRight(false, false, CoD.GameRockZombie.RockFrontBPath[1].x - CoD.GameRockZombie.RockTileWidth * 0.5, CoD.GameRockZombie.RockFrontBPath[1].x + CoD.GameRockZombie.RockTileWidth * 0.5)
	f1_local3:setTopBottom(false, false, CoD.GameRockZombie.RockFrontBPath[1].y - CoD.GameRockZombie.RockTileHeight * 0.5, CoD.GameRockZombie.RockFrontBPath[1].y + CoD.GameRockZombie.RockTileHeight * 0.5)
	f1_local3:setZRot(CoD.GameGlobeZombie.ShaderVector2X / CoD.GameGlobeZombie.DegreesToRadiansScale)
	CoD.GameRockZombie.gameRocksFront.rock4 = f1_local3
	f1_arg0:addElement(f1_local3)
	f1_arg1:setLeftRight(true, true, 0, 0)
	f1_arg1:setTopBottom(true, true, 0, 0)
	CoD.GameRockZombie.gameRocksBack = f1_arg1
	local f1_local4 = LUI.UIImage.new()
	f1_local4:setImage(CoD.GameRockZombie.RockBackMaterial)
	f1_local4:setLeftRight(false, false, CoD.GameRockZombie.RockBackPath[1].x - CoD.GameRockZombie.RockTileWidth * 0.5, CoD.GameRockZombie.RockBackPath[1].x + CoD.GameRockZombie.RockTileWidth * 0.5)
	f1_local4:setTopBottom(false, false, CoD.GameRockZombie.RockBackPath[1].y - CoD.GameRockZombie.RockTileHeight * 0.5, CoD.GameRockZombie.RockBackPath[1].y + CoD.GameRockZombie.RockTileHeight * 0.5)
	f1_local4:setZRot(CoD.GameGlobeZombie.ShaderVector2X / CoD.GameGlobeZombie.DegreesToRadiansScale)
	f1_local4:registerEventHandler("transition_complete_move_to_next", CoD.GameRockZombie.RockBack1MoveToNextFinish)
	CoD.GameRockZombie.gameRocksBack.rock1 = f1_local4
	f1_arg1:addElement(f1_local4)
	local f1_local5 = LUI.UIImage.new()
	f1_local5:setImage(CoD.GameRockZombie.RockBackMaterial)
	f1_local5:setLeftRight(false, false, CoD.GameRockZombie.RockBackPath[1].x - CoD.GameRockZombie.RockTileWidth * 0.5, CoD.GameRockZombie.RockBackPath[1].x + CoD.GameRockZombie.RockTileWidth * 0.5)
	f1_local5:setTopBottom(false, false, CoD.GameRockZombie.RockBackPath[1].y - CoD.GameRockZombie.RockTileHeight * 0.5, CoD.GameRockZombie.RockBackPath[1].y + CoD.GameRockZombie.RockTileHeight * 0.5)
	f1_local5:setZRot(CoD.GameGlobeZombie.ShaderVector2X / CoD.GameGlobeZombie.DegreesToRadiansScale)
	CoD.GameRockZombie.gameRocksBack.rock2 = f1_local5
	f1_arg1:addElement(f1_local5)
	CoD.GameRockZombie.StartMoving()
end

CoD.GameRockZombie.InitPath = function ()
	local f2_local0 = 0
	local f2_local1 = 0
	local f2_local2 = 0
	local f2_local3 = 0
	for f2_local4 = 2, CoD.GameRockZombie.RockFrontPathNodeCount, 1 do
		f2_local3 = f2_local4 - 1
		f2_local0 = CoD.GameRockZombie.RockFrontPath[f2_local3].x - CoD.GameRockZombie.RockFrontPath[f2_local4].x
		f2_local1 = CoD.GameRockZombie.RockFrontPath[f2_local3].y - CoD.GameRockZombie.RockFrontPath[f2_local4].y
		CoD.GameRockZombie.RockFrontPath[f2_local4].forwardTime = math.sqrt(f2_local0 * f2_local0 + f2_local1 * f2_local1) / CoD.GameRockZombie.RockFrontTranslatingSpeed
		f2_local0 = CoD.GameRockZombie.RockFrontBPath[f2_local3].x - CoD.GameRockZombie.RockFrontBPath[f2_local4].x
		f2_local1 = CoD.GameRockZombie.RockFrontBPath[f2_local3].y - CoD.GameRockZombie.RockFrontBPath[f2_local4].y
		CoD.GameRockZombie.RockFrontBPath[f2_local4].forwardTime = math.sqrt(f2_local0 * f2_local0 + f2_local1 * f2_local1) / CoD.GameRockZombie.RockFrontBTranslatingSpeed
		f2_local0 = CoD.GameRockZombie.RockBackPath[f2_local3].x - CoD.GameRockZombie.RockBackPath[f2_local4].x
		f2_local1 = CoD.GameRockZombie.RockBackPath[f2_local3].y - CoD.GameRockZombie.RockBackPath[f2_local4].y
		CoD.GameRockZombie.RockBackPath[f2_local4].forwardTime = math.sqrt(f2_local0 * f2_local0 + f2_local1 * f2_local1) / CoD.GameRockZombie.RockBackTranslatingSpeed
	end
end

CoD.GameRockZombie.RegisterMoveToNextState = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4)
	local f3_local0 = nil
	if f3_arg3 then
		if f3_arg4 == true then
			f3_local0 = CoD.GameRockZombie.RockFrontBPath[f3_arg2]
		else
			f3_local0 = CoD.GameRockZombie.RockFrontPath[f3_arg2]
		end
	else
		f3_local0 = CoD.GameRockZombie.RockBackPath[f3_arg2]
	end
	if not f3_arg1 then
		f3_arg0:beginAnimation("move_to_next", f3_local0.forwardTime)
	end
	f3_arg0:setLeftRight(false, false, f3_local0.x - CoD.GameRockZombie.RockTileWidth * 0.5, f3_local0.x + CoD.GameRockZombie.RockTileWidth * 0.5)
	f3_arg0:setTopBottom(false, false, f3_local0.y - CoD.GameRockZombie.RockTileHeight * 0.5, f3_local0.y + CoD.GameRockZombie.RockTileHeight * 0.5)
end

CoD.GameRockZombie.RockFront1MoveToNextFinish = function (f4_arg0, f4_arg1)
	if f4_arg1.interrupted == nil then
		if CoD.GameRockZombie.RockFrontPathNodeCurrentIndex == 3 then
			CoD.GameRockZombie.RegisterMoveToNextState(f4_arg0, true, 1, true)
			if not CoD.GameRockZombie.ShouldStop then
				CoD.GameRockZombie.RockFrontPathNodeCurrentIndex = 2
				CoD.GameRockZombie.RegisterMoveToNextState(f4_arg0, false, 2, true)
			else
				CoD.GameRockZombie.RockFrontPathNodeCurrentIndex = 1
			end
			CoD.GameRockZombie.RegisterMoveToNextState(CoD.GameRockZombie.gameRocksFront.rock2, false, 3, true)
		elseif CoD.GameRockZombie.RockFrontPathNodeCurrentIndex == 2 then
			CoD.GameRockZombie.RegisterMoveToNextState(f4_arg0, false, 3, true)
			CoD.GameRockZombie.RegisterMoveToNextState(CoD.GameRockZombie.gameRocksFront.rock2, true, 1, true)
			if not CoD.GameRockZombie.ShouldStop then
				CoD.GameRockZombie.RockFrontPathNodeCurrentIndex = 3
				CoD.GameRockZombie.RegisterMoveToNextState(CoD.GameRockZombie.gameRocksFront.rock2, false, 2, true)
			else
				CoD.GameRockZombie.RockFrontPathNodeCurrentIndex = 1
			end
		end
	end
end

CoD.GameRockZombie.RockFront3MoveToNextFinish = function (f5_arg0, f5_arg1)
	if f5_arg1.interrupted == nil then
		if CoD.GameRockZombie.RockFrontBPathNodeCurrentIndex == 3 then
			CoD.GameRockZombie.RegisterMoveToNextState(f5_arg0, true, 1, true, true)
			if not CoD.GameRockZombie.ShouldStop then
				CoD.GameRockZombie.RockFrontBPathNodeCurrentIndex = 2
				CoD.GameRockZombie.RegisterMoveToNextState(f5_arg0, false, 2, true, true)
			else
				CoD.GameRockZombie.RockFrontBPathNodeCurrentIndex = 1
			end
			CoD.GameRockZombie.RegisterMoveToNextState(CoD.GameRockZombie.gameRocksFront.rock4, false, 3, true, true)
		elseif CoD.GameRockZombie.RockFrontBPathNodeCurrentIndex == 2 then
			CoD.GameRockZombie.RegisterMoveToNextState(f5_arg0, false, 3, true, true)
			CoD.GameRockZombie.RegisterMoveToNextState(CoD.GameRockZombie.gameRocksFront.rock4, true, 1, true, true)
			if not CoD.GameRockZombie.ShouldStop then
				CoD.GameRockZombie.RockFrontBPathNodeCurrentIndex = 3
				CoD.GameRockZombie.RegisterMoveToNextState(CoD.GameRockZombie.gameRocksFront.rock4, false, 2, true, true)
			else
				CoD.GameRockZombie.RockFrontBPathNodeCurrentIndex = 1
			end
		end
	end
end

CoD.GameRockZombie.RockBack1MoveToNextFinish = function (f6_arg0, f6_arg1)
	if f6_arg1.interrupted == nil then
		if CoD.GameRockZombie.RockBackPathNodeCurrentIndex == 3 then
			CoD.GameRockZombie.RegisterMoveToNextState(f6_arg0, true, 1, false)
			if not CoD.GameRockZombie.ShouldStop then
				CoD.GameRockZombie.RockBackPathNodeCurrentIndex = 2
				CoD.GameRockZombie.RegisterMoveToNextState(f6_arg0, false, 2, false)
			else
				CoD.GameRockZombie.RockBackPathNodeCurrentIndex = 1
			end
			CoD.GameRockZombie.RegisterMoveToNextState(CoD.GameRockZombie.gameRocksBack.rock2, false, 3, false)
		elseif CoD.GameRockZombie.RockBackPathNodeCurrentIndex == 2 then
			CoD.GameRockZombie.RegisterMoveToNextState(f6_arg0, false, 3, false)
			CoD.GameRockZombie.RegisterMoveToNextState(CoD.GameRockZombie.gameRocksBack.rock2, true, 1, false)
			if not CoD.GameRockZombie.ShouldStop then
				CoD.GameRockZombie.RockBackPathNodeCurrentIndex = 3
				CoD.GameRockZombie.RegisterMoveToNextState(CoD.GameRockZombie.gameRocksBack.rock2, false, 2, false)
			else
				CoD.GameRockZombie.RockBackPathNodeCurrentIndex = 1
			end
		end
	end
end

CoD.GameRockZombie.StartMoving = function ()
	CoD.GameRockZombie.Reset(CoD.GameRockZombie.gameRocksFront.rock1, CoD.GameRockZombie.RockFrontPath[1])
	CoD.GameRockZombie.Reset(CoD.GameRockZombie.gameRocksFront.rock2, CoD.GameRockZombie.RockFrontPath[1])
	CoD.GameRockZombie.RockFrontPathNodeCurrentIndex = 2
	CoD.GameRockZombie.RegisterMoveToNextState(CoD.GameRockZombie.gameRocksFront.rock1, false, CoD.GameRockZombie.RockFrontPathNodeCurrentIndex, true)
	CoD.GameRockZombie.Reset(CoD.GameRockZombie.gameRocksFront.rock3, CoD.GameRockZombie.RockFrontBPath[1])
	CoD.GameRockZombie.Reset(CoD.GameRockZombie.gameRocksFront.rock4, CoD.GameRockZombie.RockFrontBPath[1])
	CoD.GameRockZombie.RockFrontBPathNodeCurrentIndex = 2
	CoD.GameRockZombie.RegisterMoveToNextState(CoD.GameRockZombie.gameRocksFront.rock3, false, CoD.GameRockZombie.RockFrontBPathNodeCurrentIndex, true, true)
	CoD.GameRockZombie.Reset(CoD.GameRockZombie.gameRocksBack.rock1, CoD.GameRockZombie.RockBackPath[1])
	CoD.GameRockZombie.Reset(CoD.GameRockZombie.gameRocksBack.rock2, CoD.GameRockZombie.RockBackPath[1])
	CoD.GameRockZombie.RockBackPathNodeCurrentIndex = 2
	CoD.GameRockZombie.RegisterMoveToNextState(CoD.GameRockZombie.gameRocksBack.rock1, false, CoD.GameRockZombie.RockBackPathNodeCurrentIndex, false)
	CoD.GameRockZombie.ShouldStop = false
end

CoD.GameRockZombie.StopMoving = function ()
	CoD.GameRockZombie.ShouldStop = true
end

CoD.GameRockZombie.Reset = function (f9_arg0, f9_arg1)
	f9_arg0:setLeftRight(false, false, f9_arg1.x - CoD.GameRockZombie.RockTileWidth * 0.5, f9_arg1.x + CoD.GameRockZombie.RockTileWidth * 0.5)
	f9_arg0:setTopBottom(false, false, f9_arg1.y - CoD.GameRockZombie.RockTileHeight * 0.5, f9_arg1.y + CoD.GameRockZombie.RockTileHeight * 0.5)
end

CoD.GameRockZombie.HideAll = function ()
	CoD.GameRockZombie.gameRocksFront:beginAnimation("hide", 100)
	CoD.GameRockZombie.gameRocksFront:setAlpha(0)
	CoD.GameRockZombie.gameRocksBack:beginAnimation("hide", 100)
	CoD.GameRockZombie.gameRocksBack:setAlpha(0)
end

CoD.GameRockZombie.ShowAll = function ()
	CoD.GameRockZombie.gameRocksFront:beginAnimation("show", 100)
	CoD.GameRockZombie.gameRocksFront:setAlpha(1)
	CoD.GameRockZombie.gameRocksBack:beginAnimation("show", 100)
	CoD.GameRockZombie.gameRocksBack:setAlpha(1)
end

CoD.Fog = {}
CoD.Fog.mapFog = nil
CoD.Fog.TileWidth = 2048
CoD.Fog.Path = {}
CoD.Fog.TranslatingSpeed = 0
CoD.Fog.PathNodeCount = 3
CoD.Fog.PathNodeCurrentIndex = 1
CoD.Fog.OverLap = 20
CoD.Fog.Path[1] = {
	x = -CoD.Fog.TileWidth + CoD.Fog.OverLap
}
CoD.Fog.Path[2] = {
	x = 0
}
CoD.Fog.Path[3] = {
	x = CoD.Fog.TileWidth - CoD.Fog.OverLap
}
CoD.Fog.Material = RegisterMaterial("menu_zm_map_fog")
CoD.Fog.Material2 = RegisterMaterial("menu_zm_map_fog_highrise")
CoD.Fog.Material3 = RegisterMaterial("menu_zm_map_fog_prison")
CoD.Fog.Material4 = RegisterMaterial("menu_zm_map_fog_buried")
CoD.Fog.Material5 = RegisterMaterial("menu_zm_map_fog_tomb")
CoD.Fog.Init = function (f12_arg0)
	f12_arg0:setLeftRight(true, true, 0, 0)
	f12_arg0:setTopBottom(true, true, 0, 0)
	f12_arg0:setAlpha(0)
	CoD.Fog.mapFog = f12_arg0
	CoD.Fog.InitPath()
	local f12_local0 = LUI.UIImage.new()
	f12_local0:setImage(CoD.Fog.Material)
	f12_local0:setLeftRight(false, false, CoD.Fog.Path[2].x - CoD.Fog.TileWidth * 0.5, CoD.Fog.Path[2].x + CoD.Fog.TileWidth * 0.5)
	f12_local0:setTopBottom(true, true, 0, 0)
	f12_local0:registerEventHandler("transition_complete_move_to_next", CoD.Fog.MapFog1MoveToNextFinish)
	CoD.Fog.mapFog.fogTile1 = f12_local0
	f12_arg0:addElement(f12_local0)
	local f12_local1 = LUI.UIImage.new()
	f12_local1:setImage(CoD.Fog.Material)
	f12_local1:setLeftRight(false, false, CoD.Fog.Path[1].x - CoD.Fog.TileWidth * 0.5, CoD.Fog.Path[1].x + CoD.Fog.TileWidth * 0.5)
	f12_local1:setTopBottom(true, true, 0, 0)
	CoD.Fog.mapFog.fogTile2 = f12_local1
	f12_arg0:addElement(f12_local1)
end

CoD.Fog.DefaultOverlapAndPath = function ()
	CoD.Fog.OverLap = 20
	CoD.Fog.Path[1] = {
		x = -CoD.Fog.TileWidth + CoD.Fog.OverLap
	}
	CoD.Fog.Path[2] = {
		x = 0
	}
	CoD.Fog.Path[3] = {
		x = CoD.Fog.TileWidth - CoD.Fog.OverLap
	}
	CoD.Fog.TranslatingSpeed = 0.01
	CoD.Fog.InitPath()
	CoD.Fog.StartMoving()
end

CoD.Fog.NoOverlapPath = function ()
	CoD.Fog.OverLap = 0
	CoD.Fog.Path[1] = {
		x = -CoD.Fog.TileWidth + CoD.Fog.OverLap
	}
	CoD.Fog.Path[2] = {
		x = 0
	}
	CoD.Fog.Path[3] = {
		x = CoD.Fog.TileWidth - CoD.Fog.OverLap
	}
	CoD.Fog.TranslatingSpeed = 0.01
	CoD.Fog.InitPath()
	CoD.Fog.StartMoving()
end

CoD.Fog.BuriedOverlapAndPath = function ()
	CoD.Fog.OverLap = 20
	CoD.Fog.Path[1] = {
		x = -CoD.Fog.TileWidth + CoD.Fog.OverLap
	}
	CoD.Fog.Path[2] = {
		x = 0
	}
	CoD.Fog.Path[3] = {
		x = CoD.Fog.TileWidth - CoD.Fog.OverLap
	}
	CoD.Fog.TranslatingSpeed = 0.03
	CoD.Fog.InitPath()
	CoD.Fog.StartMoving()
end

CoD.Fog.InitPath = function ()
	local f16_local0 = 0
	local f16_local1 = 0
	for f16_local2 = 2, CoD.Fog.PathNodeCount, 1 do
		f16_local1 = f16_local2 - 1
		CoD.Fog.Path[f16_local2].forwardTime = math.abs(CoD.Fog.Path[f16_local2 - 1].x - CoD.Fog.Path[f16_local2].x) / CoD.Fog.TranslatingSpeed
	end
end

CoD.Fog.SetGameMap = function (f17_arg0, f17_arg1)
	if f17_arg1 == CoD.Zombie.MAP_ZM_HIGHRISE then
		CoD.Fog.mapFog.fogTile1:setImage(CoD.Fog.Material2)
		CoD.Fog.mapFog.fogTile2:setImage(CoD.Fog.Material2)
		CoD.Fog.DefaultOverlapAndPath()
	elseif f17_arg1 == CoD.Zombie.MAP_ZM_PRISON then
		CoD.Fog.mapFog.fogTile1:setImage(CoD.Fog.Material3)
		CoD.Fog.mapFog.fogTile2:setImage(CoD.Fog.Material3)
		CoD.Fog.NoOverlapPath()
	elseif f17_arg1 == CoD.Zombie.MAP_ZM_BURIED then
		CoD.Fog.mapFog.fogTile1:setImage(CoD.Fog.Material4)
		CoD.Fog.mapFog.fogTile2:setImage(CoD.Fog.Material4)
		CoD.Fog.BuriedOverlapAndPath()
	elseif f17_arg1 == CoD.Zombie.MAP_ZM_TOMB then
		CoD.Fog.mapFog.fogTile1:setImage(CoD.Fog.Material5)
		CoD.Fog.mapFog.fogTile2:setImage(CoD.Fog.Material5)
		CoD.Fog.BuriedOverlapAndPath()
	else
		CoD.Fog.mapFog.fogTile1:setImage(CoD.Fog.Material)
		CoD.Fog.mapFog.fogTile2:setImage(CoD.Fog.Material)
		CoD.Fog.DefaultOverlapAndPath()
	end
end

CoD.Fog.StartMoving = function ()
	CoD.Fog.Reset(CoD.Fog.mapFog.fogTile1, CoD.Fog.Path[2])
	CoD.Fog.Reset(CoD.Fog.mapFog.fogTile2, CoD.Fog.Path[1])
	CoD.Fog.PathNodeCurrentIndex = 3
	CoD.Fog.RegisterMoveToNextState(CoD.Fog.mapFog.fogTile1, false, CoD.Fog.PathNodeCurrentIndex)
	CoD.Fog.RegisterMoveToNextState(CoD.Fog.mapFog.fogTile2, false, CoD.Fog.PathNodeCurrentIndex - 1)
end

CoD.Fog.MapFog1MoveToNextFinish = function (f19_arg0, f19_arg1)
	if f19_arg1.interrupted ~= true then
		if CoD.Fog.PathNodeCurrentIndex == 3 then
			CoD.Fog.PathNodeCurrentIndex = 2
			CoD.Fog.RegisterMoveToNextState(f19_arg0, true, 1)
			CoD.Fog.RegisterMoveToNextState(f19_arg0, false, 2)
			CoD.Fog.RegisterMoveToNextState(CoD.Fog.mapFog.fogTile2, false, 3)
		elseif CoD.Fog.PathNodeCurrentIndex == 2 then
			CoD.Fog.PathNodeCurrentIndex = 3
			CoD.Fog.RegisterMoveToNextState(f19_arg0, false, 3)
			CoD.Fog.RegisterMoveToNextState(CoD.Fog.mapFog.fogTile2, true, 1)
			CoD.Fog.RegisterMoveToNextState(CoD.Fog.mapFog.fogTile2, false, 2)
		else
			local f19_local0 = nil
		end
	end
end

CoD.Fog.RegisterMoveToNextState = function (f20_arg0, f20_arg1, f20_arg2)
	local f20_local0 = CoD.Fog.Path[f20_arg2]
	if not f20_arg1 then
		f20_arg0:beginAnimation("move_to_next", f20_local0.forwardTime)
	end
	f20_arg0:setLeftRight(false, false, f20_local0.x - CoD.Fog.TileWidth * 0.5, f20_local0.x + CoD.Fog.TileWidth * 0.5)
end

CoD.Fog.Reset = function (f21_arg0, f21_arg1)
	f21_arg0:completeAnimation()
	f21_arg0:setLeftRight(false, false, f21_arg1.x - CoD.Fog.TileWidth * 0.5, f21_arg1.x + CoD.Fog.TileWidth * 0.5)
end

CoD.Fog.Hide = function (f22_arg0)
	CoD.Fog.mapFog:beginAnimation("hide", f22_arg0)
	CoD.Fog.mapFog:setAlpha(0)
end

CoD.Fog.Show = function (f23_arg0)
	CoD.Fog.mapFog:beginAnimation("show", f23_arg0)
	CoD.Fog.mapFog:setAlpha(1)
end

