CoD.GameMoonZombie = {}
CoD.GameMoonZombie.gameMoon = nil
CoD.GameMoonZombie.gameFlare = nil
CoD.GameMoonZombie.gameFlareLeft = nil
CoD.GameMoonZombie.gameSun = nil
CoD.GameMoonZombie.MeteorMaterial = RegisterMaterial("lui_bkg_zm_meteor")
CoD.GameMoonZombie.FlareMaterial = RegisterMaterial("lui_bkg_zm_flare")
CoD.GameMoonZombie.FlareLeftMaterial = RegisterMaterial("lui_bkg_zm_flare_left")
CoD.GameMoonZombie.SunMaterial = RegisterMaterial("lui_bkg_zm_sun")
CoD.GameMoonZombie.TranslatingSpeed = 0.2
CoD.GameMoonZombie.LobbyMovePath = {}
CoD.GameMoonZombie.LobbyMovePathNodeCount = 6
CoD.GameMoonZombie.LobbyMovePath[1] = {
	left = 800,
	bottom = -400,
	radius = 90
}
CoD.GameMoonZombie.LobbyMovePath[2] = {
	left = 700,
	bottom = -420,
	radius = 90
}
CoD.GameMoonZombie.LobbyMovePath[3] = {
	left = 600,
	bottom = -440,
	radius = 90
}
CoD.GameMoonZombie.LobbyMovePath[4] = {
	left = 500,
	bottom = -460,
	radius = 90
}
CoD.GameMoonZombie.LobbyMovePath[5] = {
	left = 400,
	bottom = -480,
	radius = 90
}
CoD.GameMoonZombie.LobbyMovePath[6] = {
	left = 300,
	bottom = -500,
	radius = 90
}
CoD.GameMoonZombie.MapMovePath = {}
CoD.GameMoonZombie.MapMovePathNodeCount = 12
CoD.GameMoonZombie.MapMovePathNodeMidIndex = 7
CoD.GameMoonZombie.MapMoveTranslateSpeedScale = 0.5
CoD.GameMoonZombie.MapMovePath[1] = {
	left = -1600,
	bottom = 1600,
	radius = 512
}
CoD.GameMoonZombie.MapMovePath[2] = {
	left = 0,
	bottom = 872,
	radius = 512
}
CoD.GameMoonZombie.MapMovePath[3] = {
	left = 200,
	bottom = 756,
	radius = 512
}
CoD.GameMoonZombie.MapMovePath[4] = {
	left = 400,
	bottom = 641,
	radius = 512
}
CoD.GameMoonZombie.MapMovePath[5] = {
	left = 600,
	bottom = 525,
	radius = 512
}
CoD.GameMoonZombie.MapMovePath[6] = {
	left = 1200,
	bottom = 179,
	radius = 512
}
CoD.GameMoonZombie.MapMovePath[7] = {
	left = 1600,
	bottom = -51,
	radius = 512
}
CoD.GameMoonZombie.MapMovePath[8] = {
	left = 1900,
	bottom = -224,
	radius = 15
}
CoD.GameMoonZombie.MapMovePath[9] = {
	left = 320,
	bottom = -500,
	radius = 14
}
CoD.GameMoonZombie.MapMovePath[10] = {
	left = 0,
	bottom = -500,
	radius = 13
}
CoD.GameMoonZombie.MapMovePath[11] = {
	left = -320,
	bottom = -500,
	radius = 14
}
CoD.GameMoonZombie.MapMovePath[12] = {
	left = -1600,
	bottom = -500,
	radius = 15
}
CoD.GameMoonZombie.PathNodeCurrentIndex = 1
CoD.GameMoonZombie.LowRumble = 0.4
CoD.GameMoonZombie.HighRumble = 0.6
CoD.GameMoonZombie.ShakingObj = nil
CoD.GameMoonZombie.ShakingObjShakingScale = 3
CoD.GameMoonZombie.FlareFadeDuration = 150
CoD.GameMoonZombie.Init = function (f1_arg0, f1_arg1, f1_arg2)
	f1_arg0:setImage(CoD.GameMoonZombie.MeteorMaterial)
	f1_arg0:setAlpha(0)
	f1_arg0:registerEventHandler("transition_complete_lobby_move", CoD.GameMoonZombie.LobbyMoveFinish)
	f1_arg0:registerEventHandler("lobby_move_update", CoD.GameMoonZombie.LobbyMove)
	f1_arg0:registerEventHandler("transition_complete_map_move", CoD.GameMoonZombie.MapMoveFinish)
	CoD.GameMoonZombie.gameMoon = f1_arg0
	CoD.GameMoonZombie.gameMoon.id = "gamemoon"
	CoD.GameMoonZombie.InitPaths()
	f1_arg1:setLeftRight(true, true, 0, 0)
	f1_arg1:setTopBottom(true, true, 0, 0)
	local f1_local0 = LUI.UIImage.new()
	f1_local0:setLeftRight(false, false, -CoD.Zombie.FullScreenSize.w * 0.5, CoD.Zombie.FullScreenSize.w * 0.5)
	f1_local0:setTopBottom(false, false, -CoD.Zombie.FullScreenSize.h * 0.5, CoD.Zombie.FullScreenSize.h * 0.5)
	f1_local0:setAlpha(0)
	f1_local0:setImage(CoD.GameMoonZombie.FlareMaterial)
	f1_arg1:addElement(f1_local0)
	CoD.GameMoonZombie.gameFlare = f1_local0
	local f1_local1 = LUI.UIImage.new()
	f1_local1:setLeftRight(false, false, -CoD.Zombie.FullScreenSize.w * 0.5, CoD.Zombie.FullScreenSize.w * 0.5)
	f1_local1:setTopBottom(false, false, -CoD.Zombie.FullScreenSize.h * 0.5, CoD.Zombie.FullScreenSize.h * 0.5)
	f1_local1:setAlpha(0)
	f1_local1:setImage(CoD.GameMoonZombie.FlareLeftMaterial)
	f1_arg1:addElement(f1_local1)
	CoD.GameMoonZombie.gameFlareLeft = f1_local1
	f1_arg2:setLeftRight(false, false, -CoD.Zombie.FullScreenSize.w * 0.5, CoD.Zombie.FullScreenSize.w * 0.5)
	f1_arg2:setTopBottom(false, false, -CoD.Zombie.FullScreenSize.h * 0.5, CoD.Zombie.FullScreenSize.h * 0.5)
	f1_arg2:setImage(CoD.GameMoonZombie.SunMaterial)
	CoD.GameMoonZombie.gameSun = f1_arg2
end

CoD.GameMoonZombie.InitPaths = function ()
	local f2_local0, f2_local1, f2_local2, f2_local3 = nil
	for f2_local4 = 2, CoD.GameMoonZombie.LobbyMovePathNodeCount, 1 do
		f2_local0 = CoD.GameMoonZombie.LobbyMovePath[f2_local4].left - CoD.GameMoonZombie.LobbyMovePath[f2_local4 - 1].left
		f2_local1 = CoD.GameMoonZombie.LobbyMovePath[f2_local4].bottom - CoD.GameMoonZombie.LobbyMovePath[f2_local4 - 1].bottom
		CoD.GameMoonZombie.LobbyMovePath[f2_local4].forwardTime = math.sqrt(f2_local0 * f2_local0 + f2_local1 * f2_local1) / CoD.GameMoonZombie.TranslatingSpeed
	end
	for f2_local4 = 1, CoD.GameMoonZombie.MapMovePathNodeCount, 1 do
		if f2_local4 == 1 then
			f2_local3 = CoD.GameMoonZombie.MapMovePathNodeCount
		else
			f2_local3 = f2_local4 - 1
		end
		f2_local0 = CoD.GameMoonZombie.MapMovePath[f2_local4].left - CoD.GameMoonZombie.MapMovePath[f2_local3].left
		f2_local1 = CoD.GameMoonZombie.MapMovePath[f2_local4].bottom - CoD.GameMoonZombie.MapMovePath[f2_local3].bottom
		CoD.GameMoonZombie.MapMovePath[f2_local4].forwardTime = math.sqrt(f2_local0 * f2_local0 + f2_local1 * f2_local1) / CoD.GameMoonZombie.TranslatingSpeed
		if f2_local4 > CoD.GameMoonZombie.MapMovePathNodeMidIndex then
			CoD.GameMoonZombie.MapMovePath[f2_local4].forwardTime = CoD.GameMoonZombie.MapMovePath[f2_local4].forwardTime / CoD.GameMoonZombie.MapMoveTranslateSpeedScale
		end
	end
end

CoD.GameMoonZombie.Reset = function ()
	if CoD.GameMoonZombie.gameMoon.LobbyTimer then
		CoD.GameMoonZombie.gameMoon.LobbyTimer:close()
	end
	CoD.GameMoonZombie.gameMoon:completeAnimation()
	CoD.GameMapZombie.gameMap:completeAnimation()
	CoD.GameGlobeZombie.gameGlobe:completeAnimation()
	CoD.GameGlobeZombie.mapInfoContainer:completeAnimation()
	local f3_local0 = CoD.GameMoonZombie.MapMovePath[1]
	CoD.GameMoonZombie.gameMoon:setLeftRight(false, false, f3_local0.left - f3_local0.radius, f3_local0.left + f3_local0.radius)
	CoD.GameMoonZombie.gameMoon:setTopBottom(false, false, f3_local0.bottom - f3_local0.radius, f3_local0.bottom + f3_local0.radius)
	CoD.GameMoonZombie.gameMoon:setAlpha(0)
	CoD.GameMoonZombie.controller = nil
	CoD.GameMoonZombie.PathNodeCurrentIndex = 1
end

CoD.GameMoonZombie.LobbyMoveStart = function (f4_arg0)
	if not CoD.GameMoonZombie.gameMoon.LobbyTimer then
		CoD.GameMoonZombie.gameMoon.LobbyTimer = LUI.UITimer.new(10000, "lobby_move_update", false)
		CoD.GameMoonZombie.gameMoon:addElement(CoD.GameMoonZombie.gameMoon.LobbyTimer)
	end
	CoD.GameMoonZombie.controller = f4_arg0
	CoD.GameMoonZombie.LobbyMove()
end

CoD.GameMoonZombie.LobbyMove = function ()
	local f5_local0 = CoD.GameMoonZombie.LobbyMovePath[1]
	CoD.GameMoonZombie.gameMoon:setLeftRight(false, false, f5_local0.left - f5_local0.radius, f5_local0.left + f5_local0.radius)
	CoD.GameMoonZombie.gameMoon:setTopBottom(false, false, f5_local0.bottom - f5_local0.radius, f5_local0.bottom + f5_local0.radius)
	CoD.GameMoonZombie.gameMoon:setAlpha(1)
	CoD.GameMoonZombie.PathNodeCurrentIndex = 2
	CoD.GameMoonZombie.LobbyMoveToNextNode()
end

CoD.GameMoonZombie.LobbyMoveToNextNode = function ()
	local f6_local0 = CoD.GameMoonZombie.LobbyMovePath[CoD.GameMoonZombie.PathNodeCurrentIndex]
	CoD.GameMoonZombie.gameMoon:beginAnimation("lobby_move", f6_local0.forwardTime)
	CoD.GameMoonZombie.gameMoon:setLeftRight(false, false, f6_local0.left - f6_local0.radius, f6_local0.left + f6_local0.radius)
	CoD.GameMoonZombie.gameMoon:setTopBottom(false, false, f6_local0.bottom - f6_local0.radius, f6_local0.bottom + f6_local0.radius)
end

CoD.GameMoonZombie.LobbyMoveFinish = function (f7_arg0, f7_arg1)
	if f7_arg1.interrupted == nil then
		CoD.GameMoonZombie.PathNodeCurrentIndex = CoD.GameMoonZombie.PathNodeCurrentIndex + 1
		if CoD.GameMoonZombie.PathNodeCurrentIndex <= CoD.GameMoonZombie.LobbyMovePathNodeCount then
			CoD.GameMoonZombie.LobbyMoveToNextNode()
		else

		end
	end
end

CoD.GameMoonZombie.MapMoveStart = function (f8_arg0)
	CoD.GameMoonZombie.controller = f8_arg0
	local f8_local0 = CoD.GameMoonZombie.MapMovePath[1]
	CoD.GameMoonZombie.gameMoon:setLeftRight(false, false, f8_local0.left - f8_local0.radius, f8_local0.left + f8_local0.radius)
	CoD.GameMoonZombie.gameMoon:setTopBottom(false, false, f8_local0.bottom - f8_local0.radius, f8_local0.bottom + f8_local0.radius)
	CoD.GameMoonZombie.gameMoon:setAlpha(1)
	CoD.GameMoonZombie.PathNodeCurrentIndex = 2
	CoD.GameMoonZombie.MapMoveToNextNode()
end

CoD.GameMoonZombie.MapMoveToNextNode = function ()
	local f9_local0 = CoD.GameMoonZombie.MapMovePath[CoD.GameMoonZombie.PathNodeCurrentIndex]
	CoD.GameMoonZombie.gameMoon:beginAnimation("map_move", f9_local0.forwardTime)
	CoD.GameMoonZombie.gameMoon:setLeftRight(false, false, f9_local0.left - f9_local0.radius, f9_local0.left + f9_local0.radius)
	CoD.GameMoonZombie.gameMoon:setTopBottom(false, false, f9_local0.bottom - f9_local0.radius, f9_local0.bottom + f9_local0.radius)
end

CoD.GameMoonZombie.MapMoveFinish = function (f10_arg0, f10_arg1)
	if f10_arg1.interrupted == nil then
		CoD.GameMoonZombie.PathNodeCurrentIndex = CoD.GameMoonZombie.PathNodeCurrentIndex % CoD.GameMoonZombie.MapMovePathNodeCount + 1
		if CoD.GameMoonZombie.PathNodeCurrentIndex ~= 1 then
			if CoD.GameMoonZombie.PathNodeCurrentIndex == 7 then

			elseif CoD.GameMoonZombie.PathNodeCurrentIndex == 3 then
				CoD.GameMoonZombie.StartShake(CoD.GameMapZombie.gameMap, CoD.GameMapZombie.ShakingScaleMedium, CoD.GameMapZombie.ShakingAnimTimeMedium)
				CoD.GameMoonZombie.StartShake(CoD.GameGlobeZombie.gameGlobe, CoD.GameGlobeZombie.ShakingScaleMedium, CoD.GameGlobeZombie.ShakingAnimTimeMedium)
			end
		end
		CoD.GameMoonZombie.MapMoveToNextNode()
	end
end

CoD.GameMoonZombie.StartShake = function (f11_arg0, f11_arg1, f11_arg2)
	f11_arg0.ShakingScaleCurrent = f11_arg1
	f11_arg0.AnimTime = f11_arg2
	f11_arg0:registerEventHandler("transition_complete_shaking", CoD.GameMoonZombie.ShakingFinish)
	CoD.GameMoonZombie.RegisterShakingState(f11_arg0)
end

CoD.GameMoonZombie.RegisterShakingState = function (f12_arg0)
	local f12_local0 = math.random() * f12_arg0.ShakingScaleCurrent * 2 - f12_arg0.ShakingScaleCurrent
	local f12_local1 = math.random() * f12_arg0.ShakingScaleCurrent * 2 - f12_arg0.ShakingScaleCurrent
	local f12_local2 = true
	local f12_local3 = true
	local f12_local4 = true
	local f12_local5 = true
	f12_arg0:beginAnimation("shaking", f12_arg0.AnimTime)
	if f12_arg0.id == "gameglobe" then
		f12_arg0:setLeftRight(false, false, -CoD.GameGlobeZombie.CenterRadius + f12_local0, CoD.GameGlobeZombie.CenterRadius + f12_local0)
		f12_arg0:setTopBottom(false, false, -CoD.GameGlobeZombie.CenterRadius + CoD.GameGlobeZombie.PlaceYOffSet + f12_local1, CoD.GameGlobeZombie.CenterRadius + CoD.GameGlobeZombie.PlaceYOffSet + f12_local1)
	else
		f12_arg0:setLeftRight(false, false, -CoD.Zombie.FullScreenSize.w * 0.5 - f12_arg0.ShakingScaleCurrent + f12_local0, CoD.Zombie.FullScreenSize.w * 0.5 + f12_arg0.ShakingScaleCurrent + f12_local0)
		f12_arg0:setTopBottom(false, false, -CoD.Zombie.FullScreenSize.h * 0.5 - f12_arg0.ShakingScaleCurrent + f12_local1, CoD.Zombie.FullScreenSize.h * 0.5 + f12_arg0.ShakingScaleCurrent + f12_local1)
	end
end

CoD.GameMoonZombie.ShakingFinish = function (f13_arg0, f13_arg1)
	if f13_arg1.interrupted == nil and CoD.GameMoonZombie.PathNodeCurrentIndex >= 3 and CoD.GameMoonZombie.PathNodeCurrentIndex < 7 then
		CoD.GameMoonZombie.RegisterShakingState(f13_arg0)
	end
end

CoD.GameMoonZombie.FadeOutFlare = function ()
	CoD.GameMoonZombie.gameFlare:beginAnimation("hide", CoD.GameMoonZombie.FlareFadeDuration)
	CoD.GameMoonZombie.gameFlare:setAlpha(0)
end

CoD.GameMoonZombie.FadeInFlare = function ()
	CoD.GameMoonZombie.gameFlare:beginAnimation("show", CoD.GameMoonZombie.FlareFadeDuration)
	CoD.GameMoonZombie.gameFlare:setAlpha(1)
end

CoD.GameMoonZombie.FadeOutFlareLeft = function ()
	CoD.GameMoonZombie.gameFlareLeft:beginAnimation("hide", CoD.GameMoonZombie.FlareFadeDuration)
	CoD.GameMoonZombie.gameFlareLeft:setAlpha(0)
end

CoD.GameMoonZombie.FadeInFlareLeft = function ()
	CoD.GameMoonZombie.gameFlareLeft:beginAnimation("show", CoD.GameMoonZombie.FlareFadeDuration)
	CoD.GameMoonZombie.gameFlareLeft:setAlpha(1)
end

CoD.GameMoonZombie.FadeOutSun = function ()
	CoD.GameMoonZombie.gameSun:beginAnimation("hide", CoD.GameMoonZombie.FlareFadeDuration)
	CoD.GameMoonZombie.gameSun:setAlpha(0)
end

CoD.GameMoonZombie.FadeInSun = function ()
	CoD.GameMoonZombie.gameSun:beginAnimation("show", CoD.GameMoonZombie.FlareFadeDuration)
	CoD.GameMoonZombie.gameSun:setAlpha(1)
end

CoD.GameMoonZombie.FadeOutFlares = function ()
	CoD.GameMoonZombie.FadeOutFlare()
	CoD.GameMoonZombie.FadeOutFlareLeft()
	CoD.GameMoonZombie.FadeOutSun()
end

