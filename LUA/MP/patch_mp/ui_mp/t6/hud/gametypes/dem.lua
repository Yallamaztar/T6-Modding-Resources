CoD.dem = {}
LUI.createMenu.gametype_dem = function (f1_arg0)
	local f1_local0 = CoD.GametypeBase.new("gametype_dem", f1_arg0)
	f1_local0:setAlpha(0)
	f1_local0.objectiveTypes._a = CoD.ObjectiveBombSite
	f1_local0.objectiveTypes._b = CoD.ObjectiveBombSite
	f1_local0.objectiveTypes.defuse_a = CoD.ObjectiveDefuseSite
	f1_local0.objectiveTypes.defuse_b = CoD.ObjectiveDefuseSite
	local f1_local1 = 79
	local f1_local2 = 180
	local f1_local3 = 10
	if Engine.IsSplitscreen() == true then
		f1_local1 = f1_local1 - 10
		f1_local2 = f1_local2 - 45
	end
	local f1_local4 = CoD.SplitscreenScaler.new(nil, CoD.SplitscreenMultiplier)
	f1_local4:setLeftRight(true, false, 0, 0)
	f1_local4:setTopBottom(true, false, 0, 0)
	f1_local0:addElement(f1_local4)
	local f1_local5 = f1_local1 - f1_local3 - CoD.BombTimer.Width
	f1_local4:addElement(CoD.BombTimer.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local5,
		right = f1_local5 + CoD.BombTimer.Width,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local2,
		bottom = f1_local2 + CoD.BombTimer.Height
	}, "A"))
	local f1_local6 = f1_local1 + f1_local3
	f1_local4:addElement(CoD.BombTimer.new({
		leftAnchor = true,
		rightAnchor = false,
		left = f1_local6,
		right = f1_local6 + CoD.BombTimer.Width,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local2,
		bottom = f1_local2 + CoD.BombTimer.Height
	}, "B"))
	return f1_local0
end

LUI.createMenu.gametype_sd = LUI.createMenu.gametype_dem
