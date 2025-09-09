CoD.VisorLeftBracket = {}
CoD.VisorLeftBracket.DefaultAlpha = 1
CoD.VisorLeftBracket.BracketWidth = 64
CoD.VisorLeftBracket.BracketHeight = 512
CoD.VisorLeftBracket.ExpandDuration = 250
CoD.VisorLeftBracket.MoveDuration = 500
CoD.VisorLeftBracket.ColorValue = {}
CoD.VisorLeftBracket.ColorValue.r = 0.7
CoD.VisorLeftBracket.ColorValue.b = 0.7
CoD.VisorLeftBracket.ColorValue.g = 0.7
CoD.VisorLeftBracket.new = function ()
	local f1_local0 = CoD.VisorImage.new("visor_left_bracket", nil, CoD.VisorLeftBracket.ColorValue)
	f1_local0:setLeftRight(false, false, -CoD.VisorLeftBracket.BracketWidth, 0)
	f1_local0:setTopBottom(false, false, 0, 0)
	f1_local0:setAlpha(CoD.VisorLeftBracket.DefaultAlpha)
	f1_local0:registerEventHandler("bootup_expand", CoD.VisorLeftBracket.BootupExpand)
	f1_local0:registerEventHandler("bootup_half_left", CoD.VisorLeftBracket.BootupHalfLeft)
	f1_local0:registerEventHandler("bootup_left", CoD.VisorLeftBracket.BootupLeft)
	f1_local0:registerEventHandler("bootup_switch_to_hud", CoD.VisorLeftBracket.BootupSwitchToHUD)
	CoD.VisorLeftBracket.LeftBracketUnwarpMaterial = RegisterMaterial("visor_left_bracket_unwarp")
	return f1_local0
end

CoD.VisorLeftBracket.BootupExpand = function (f2_arg0, f2_arg1)
	f2_arg0:beginAnimation("expand", CoD.VisorLeftBracket.ExpandDuration, true, true)
	f2_arg0:setTopBottom(false, false, -CoD.VisorLeftBracket.BracketHeight / 4, CoD.VisorLeftBracket.BracketHeight / 4)
end

CoD.VisorLeftBracket.BootupHalfLeft = function (f3_arg0, f3_arg1)
	local f3_local0, f3_local1 = Engine.GetUserSafeArea()
	f3_arg0:beginAnimation("half_left", CoD.VisorLeftBracket.MoveDuration, true, true)
	f3_arg0:setLeftRight(false, false, -f3_local0 / 4 - CoD.VisorLeftBracket.BracketWidth / 2, -f3_local0 / 4 + CoD.VisorLeftBracket.BracketWidth / 2)
	f3_arg0:setTopBottom(false, false, -CoD.VisorLeftBracket.BracketHeight / 4, CoD.VisorLeftBracket.BracketHeight / 4)
end

CoD.VisorLeftBracket.BootupLefttAnimation = function (f4_arg0, f4_arg1)
	if not f4_arg1 then
		f4_arg1 = 0
	end
	local f4_local0 = -20
	f4_arg0:beginAnimation("left", f4_arg1, true, true)
	f4_arg0:setLeftRight(true, false, f4_local0, CoD.VisorLeftBracket.BracketWidth + f4_local0)
	f4_arg0:setTopBottom(false, false, -CoD.VisorLeftBracket.BracketHeight / 2, CoD.VisorLeftBracket.BracketHeight / 2)
end

CoD.VisorLeftBracket.BootupLeft = function (f5_arg0, f5_arg1)
	CoD.VisorLeftBracket.BootupLefttAnimation(f5_arg0, CoD.VisorLeftBracket.MoveDuration)
end

CoD.VisorLeftBracket.BootupSwitchToHUD = function (f6_arg0, f6_arg1)
	CoD.VisorLeftBracket.BootupLefttAnimation(f6_arg0)
	if f6_arg1.isFrontEnd == false and Dvar.ui_mapname:get() ~= "karma" then
		f6_arg0.image:close()
		local f6_local0 = 8
		local f6_local1 = 5
		f6_arg0.image = LUI.UIImage.new()
		f6_arg0.image:setLeftRight(true, true, f6_local0, f6_local0)
		f6_arg0.image:setTopBottom(true, true, f6_local1, -f6_local1)
		f6_arg0.image:setImage(CoD.VisorLeftBracket.LeftBracketUnwarpMaterial)
		f6_arg0.image:setAlpha(0.25)
		f6_arg0:addElement(f6_arg0.image)
	end
end

