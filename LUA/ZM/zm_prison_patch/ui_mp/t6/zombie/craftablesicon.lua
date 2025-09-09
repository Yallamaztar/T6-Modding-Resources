CoD.CraftablesIcon = {}
CoD.CraftablesIcon.FontName = "ExtraSmall"
CoD.CraftablesIcon.GrungeAlpha = 0.45
CoD.CraftablesIcon.glowBackColor = {}
CoD.CraftablesIcon.glowBackColor.r = 1
CoD.CraftablesIcon.glowBackColor.g = 1
CoD.CraftablesIcon.glowBackColor.b = 1
CoD.CraftablesIcon.glowFrontColor = {}
CoD.CraftablesIcon.glowFrontColor.r = 1
CoD.CraftablesIcon.glowFrontColor.g = 1
CoD.CraftablesIcon.glowFrontColor.b = 1
CoD.CraftablesIcon.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = CoD.textSize[CoD.CraftablesIcon.FontName]
	if not f1_arg3 then
		f1_local0 = CoD.textSize[f1_arg3]
	end
	local f1_local1 = CoD.textSize[CoD.CraftablesIcon.FontName] + 4
	local f1_local2 = 1
	if not CoD.Zombie.LocalSplitscreenMultiplePlayers then
		local f1_local3 = LUI.UIImage.new()
		f1_local3:setLeftRight(true, true, 0, 0)
		f1_local3:setTopBottom(true, true, 0, 0)
		f1_local3:setRGB(0, 0, 0)
		f1_local3:setAlpha(0.3)
		f1_local3:setPriority(-110)
		f1_arg0:addElement(f1_local3)
		local f1_local4 = LUI.UIImage.new()
		f1_local4:setLeftRight(true, true, 2, -2)
		f1_local4:setTopBottom(true, true, 1, -f1_local1 - f1_local2)
		f1_local4:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
		f1_local4:setRGB(0, 0, 0)
		f1_local4:setAlpha(1)
		f1_local4:setPriority(-80)
		f1_arg0:addElement(f1_local4)
		if f1_arg1 ~= nil then
			local f1_local5 = 60
			f1_arg0.glowGradBack = LUI.UIImage.new()
			f1_arg0.glowGradBack:setLeftRight(true, true, 1, -1)
			f1_arg0.glowGradBack:setTopBottom(false, true, -f1_local2 - f1_local5, -f1_local2)
			f1_arg0.glowGradBack:setImage(RegisterMaterial("menu_mp_cac_grad_stretch_add"))
			f1_arg0.glowGradBack:setRGB(f1_arg1.r, f1_arg1.g, f1_arg1.b)
			f1_arg0.glowGradBack:setAlpha(0.05)
			f1_arg0.glowGradBack:setPriority(-80)
			f1_arg0:addElement(f1_arg0.glowGradBack)
		end
		if f1_arg2 ~= nil then
			local f1_local5 = 30
			f1_arg0.glowGradFront = LUI.UIImage.new()
			f1_arg0.glowGradFront:setLeftRight(true, true, 1, -1)
			f1_arg0.glowGradFront:setTopBottom(false, true, -f1_local1 - f1_local2 - f1_local5, -f1_local1 - f1_local2)
			f1_arg0.glowGradFront:setImage(RegisterMaterial("menu_mp_cac_grad_stretch_add_v2"))
			f1_arg0.glowGradFront:setRGB(f1_arg2.r, f1_arg2.g, f1_arg2.b)
			f1_arg0.glowGradFront:setAlpha(0.05)
			f1_arg0.glowGradFront:setPriority(-80)
			f1_arg0:addElement(f1_arg0.glowGradFront)
		end
		local f1_local5 = LUI.UIImage.new()
		f1_local5:setLeftRight(true, true, 5, -5)
		f1_local5:setTopBottom(true, false, 4, 44)
		f1_local5:setImage(RegisterMaterial("menu_mp_cac_grad_stretch"))
		f1_local5:setPriority(100)
		f1_local5:setAlpha(0.1)
		f1_arg0:addElement(f1_local5)
		if not CoD.CraftablesIcon.GrungeMaterial then
			CoD.CraftablesIcon.GrungeMaterial = RegisterMaterial("zom_hud_craftable_grunge")
		end
		f1_arg0.grunge = LUI.UIImage.new()
		f1_arg0.grunge:setLeftRight(true, true, 5, -5)
		f1_arg0.grunge:setTopBottom(true, false, 4, 44)
		f1_arg0.grunge:setImage(CoD.CraftablesIcon.GrungeMaterial)
		f1_arg0.grunge:setAlpha(0)
		f1_arg0:addElement(f1_arg0.grunge)
		f1_arg0.highlight = CoD.Border.new(1, 1, 1, 1, 0.1)
		f1_arg0.highlight:setPriority(100)
		f1_arg0.highlight:setLeftRight(true, true, 0, 0)
		f1_arg0.highlight:setTopBottom(true, true, 0, 0)
		f1_arg0.highlight:registerEventHandler("button_over", CoD.CraftablesIcon.HighlightButtonOver)
		f1_arg0.highlight:registerEventHandler("button_up", CoD.CraftablesIcon.HighlightButtonUp)
		f1_arg0:addElement(f1_arg0.highlight)
	else
		f1_arg0.highlight = LUI.UIElement.new()
		f1_arg0.highlight:setLeftRight(false, false, 0, 0)
		f1_arg0.highlight:setTopBottom(false, false, 0, 0)
	end
	f1_arg0:registerEventHandler("picked_up", CoD.CraftablesIcon.PickedUpUpdate)
end

CoD.CraftablesIcon.PickedUpUpdate = function (f2_arg0, f2_arg1)
	if f2_arg0.grunge then
		f2_arg0.grunge:setLeftRight(true, true, 0, 0)
		f2_arg0.grunge:setTopBottom(true, true, 0, 0)
		f2_arg0.grunge:setAlpha(1)
	end
end

CoD.CraftablesIcon.HighlightButtonOver = function (f3_arg0, f3_arg1)
	f3_arg0:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	f3_arg0:setAlpha(1)
end

CoD.CraftablesIcon.HighlightButtonUp = function (f4_arg0, f4_arg1)
	f4_arg0:setRGB(1, 1, 1)
	f4_arg0:setAlpha(0.1)
end

CoD.CraftablesIcon.PulseRedBright = function (f5_arg0, f5_arg1)
	f5_arg0:beginAnimation("turn_red", f5_arg1)
	f5_arg0:setAlpha(1)
	f5_arg0:setRGB(1, 0, 0)
end

CoD.CraftablesIcon.PulseRedLow = function (f6_arg0, f6_arg1)
	f6_arg0:beginAnimation("turn_red", f6_arg1)
	f6_arg0:setAlpha(0.1)
	f6_arg0:setRGB(1, 0, 0)
end

CoD.CraftablesIcon.PulseWhite = function (f7_arg0, f7_arg1)
	f7_arg0:beginAnimation("turn_white", f7_arg1)
	f7_arg0:setAlpha(0.1)
	f7_arg0:setRGB(1, 1, 1)
end

