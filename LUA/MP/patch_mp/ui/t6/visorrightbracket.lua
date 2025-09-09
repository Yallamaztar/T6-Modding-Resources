CoD.VisorRightBracket = {}
CoD.VisorRightBracket.DefaultAlpha = 1
CoD.VisorRightBracket.BracketWidth = 64
CoD.VisorRightBracket.BracketHeight = 490
CoD.VisorRightBracket.ExpandDuration = 250
CoD.VisorRightBracket.MoveDuration = 500
CoD.VisorRightBracket.ColorValue = {}
CoD.VisorRightBracket.ColorValue.r = 0.7
CoD.VisorRightBracket.ColorValue.b = 0.7
CoD.VisorRightBracket.ColorValue.g = 0.7
CoD.VisorRightBracket.DataBoxesTopOffset = -28
CoD.VisorRightBracket.AmmoLeftOffset = -45
CoD.VisorRightBracket.AmmoTopOffset = 2
CoD.VisorRightBracket.new = function ()
	local f1_local0 = CoD.VisorImage.new("visor_right_bracket", nil, CoD.VisorRightBracket.ColorValue)
	f1_local0:setLeftRight(false, false, 0, CoD.VisorRightBracket.BracketWidth)
	f1_local0:setTopBottom(false, false, 0, 0)
	f1_local0:setAlpha(CoD.VisorRightBracket.DefaultAlpha)
	f1_local0:registerEventHandler("bootup_expand", CoD.VisorRightBracket.BootupExpand)
	f1_local0:registerEventHandler("bootup_half_right", CoD.VisorRightBracket.BootupHalfRight)
	f1_local0:registerEventHandler("bootup_right", CoD.VisorRightBracket.BootupRight)
	f1_local0:registerEventHandler("bootup_switch_to_hud", CoD.VisorRightBracket.BootupSwitchToHUD)
	CoD.VisorRightBracket.RightBracketUnwarpMaterial = RegisterMaterial("visor_right_bracket_unwarp")
	return f1_local0
end

CoD.VisorRightBracket.BootupExpand = function (f2_arg0, f2_arg1)
	f2_arg0:beginAnimation("expand", CoD.VisorRightBracket.ExpandDuration, true, true)
	f2_arg0:setTopBottom(false, false, -CoD.VisorRightBracket.BracketHeight / 4, CoD.VisorRightBracket.BracketHeight / 4)
end

CoD.VisorRightBracket.BootupHalfRight = function (f3_arg0, f3_arg1)
	local f3_local0, f3_local1 = Engine.GetUserSafeArea()
	f3_arg0:beginAnimation("half_right", CoD.VisorRightBracket.MoveDuration, true, true)
	f3_arg0:setLeftRight(false, false, f3_local0 / 4 - CoD.VisorRightBracket.BracketWidth / 2, f3_local0 / 4 + CoD.VisorRightBracket.BracketWidth / 2)
	f3_arg0:setTopBottom(false, false, -CoD.VisorRightBracket.BracketHeight / 4, CoD.VisorRightBracket.BracketHeight / 4)
end

CoD.VisorRightBracket.BootupRightAnimation = function (f4_arg0, f4_arg1)
	if not f4_arg1 then
		f4_arg1 = 0
	end
	local f4_local0 = 15
	local f4_local1 = -12
	f4_arg0:beginAnimation("right", f4_arg1, true, true)
	f4_arg0:setLeftRight(false, true, -CoD.VisorRightBracket.BracketWidth + f4_local0, f4_local0)
	f4_arg0:setTopBottom(false, false, -CoD.VisorRightBracket.BracketHeight / 2 + f4_local1, CoD.VisorRightBracket.BracketHeight / 2 + f4_local1)
end

CoD.VisorRightBracket.BootupRight = function (f5_arg0, f5_arg1)
	CoD.VisorRightBracket.BootupRightAnimation(f5_arg0, CoD.VisorRightBracket.MoveDuration)
end

CoD.VisorRightBracket.BootupSwitchToHUD = function (f6_arg0, f6_arg1)
	CoD.VisorRightBracket.BootupRightAnimation(f6_arg0)
	if f6_arg1.isFrontEnd == false and Dvar.ui_mapname:get() ~= "karma" then
		f6_arg0.image:close()
		local f6_local0 = 10
		local f6_local1 = 5
		f6_arg0.image = LUI.UIImage.new()
		f6_arg0.image:setLeftRight(true, true, -f6_local0, -f6_local0)
		f6_arg0.image:setTopBottom(true, true, f6_local1, -f6_local1)
		f6_arg0.image:setImage(CoD.VisorRightBracket.RightBracketUnwarpMaterial)
		f6_arg0.image:setAlpha(0.25)
		f6_arg0:addElement(f6_arg0.image)
	end
end

