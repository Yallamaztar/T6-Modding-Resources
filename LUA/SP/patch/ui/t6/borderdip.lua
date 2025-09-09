CoD.BorderDip = {}
CoD.BorderDip.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7)
	local f1_local0 = CoD.Border.new(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5)
	f1_local0.dipCount = f1_arg7
	f1_local0.bottomBorders = {}
	local f1_local1 = f1_arg6
	if f1_arg7 ~= 0 then
		f1_local0.bottomBorder:close()
		f1_local1 = f1_arg6 / f1_arg7
	end
	for f1_local2 = 1, f1_arg7, 1 do
		f1_local0.bottomBorder[f1_local2] = LUI.UIImage.new()
		f1_local0.bottomBorder[f1_local2]:setLeftRight(true, false, f1_local1 * (f1_local2 - 1), f1_local1 * f1_local2)
		f1_local0.bottomBorder[f1_local2]:setTopBottom(false, true, -9, -1)
		f1_local0.bottomBorder[f1_local2]:setImage(RegisterMaterial("menu_sp_cac_single_dip"))
		f1_local0:addElement(f1_local0.bottomBorder[f1_local2])
	end
	f1_local0.setRGB = CoD.BorderDip.SetRGB
	f1_local0.setAlpha = CoD.BorderDip.SetAlpha
	return f1_local0
end

CoD.BorderDip.SetRGB = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	f2_arg0.topBorder:setRGB(f2_arg1, f2_arg2, f2_arg3)
	f2_arg0.leftBorder:setRGB(f2_arg1, f2_arg2, f2_arg3)
	f2_arg0.rightBorder:setRGB(f2_arg1, f2_arg2, f2_arg3)
	for f2_local0 = 1, f2_arg0.dipCount, 1 do
		f2_arg0.bottomBorder[f2_local0]:setRGB(f2_arg1, f2_arg2, f2_arg3)
	end
end

CoD.BorderDip.SetAlpha = function (f3_arg0, f3_arg1)
	f3_arg0.topBorder:setAlpha(f3_arg1)
	f3_arg0.leftBorder:setAlpha(f3_arg1)
	f3_arg0.rightBorder:setAlpha(f3_arg1)
	for f3_local0 = 1, f3_arg0.dipCount, 1 do
		f3_arg0.bottomBorder[f3_local0]:setAlpha(f3_arg1)
	end
end

