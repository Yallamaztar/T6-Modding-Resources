require("T6.Border")
CoD.BorderDipSmall = {}
CoD.BorderDipSmall.SmallDip = "menu_sp_cac_single_dip_small_dbl"
CoD.BorderDipSmall.SmallDipWidth = 85.12
CoD.BorderDipSmall.SmallDipHeight = 8
CoD.BorderDipSmall.SmallDipLeftOffset = 3
local f0_local0 = nil
CoD.BorderDipSmall.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7)
	local f1_local0 = CoD.Border.new(f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7)
	f1_local0.bottomBorder:setLeftRight(true, true, 0, -CoD.BorderDipSmall.SmallDipWidth * f1_arg0 - CoD.BorderDipSmall.SmallDipLeftOffset)
	local f1_local1 = LUI.UIImage.new()
	f1_local1:setLeftRight(false, true, -CoD.BorderDipSmall.SmallDipLeftOffset, 0)
	f1_local1:setTopBottom(false, true, -f1_arg1, 0)
	f1_local1:setRGB(f1_arg2, f1_arg3, f1_arg4)
	f1_local0.bottomBorderFiller = f1_local1
	f1_local0:addElement(f1_local1)
	f1_local0.dips = {}
	for f1_local2 = 1, f1_arg0, 1 do
		table.insert(f1_local0.dips, f0_local0(f1_local0, f1_local2, f1_arg1, f1_arg5))
		f1_local0.dips[f1_local2]:setRGB(f1_arg2, f1_arg3, f1_arg4)
	end
	f1_local0.setRGB = CoD.BorderDipSmall.SetRGB
	return f1_local0
end

f0_local0 = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = LUI.UIImage.new()
	f2_local0:setLeftRight(false, true, -CoD.BorderDipSmall.SmallDipWidth * f2_arg1 - CoD.BorderDipSmall.SmallDipLeftOffset, -CoD.BorderDipSmall.SmallDipWidth * (f2_arg1 - 1) - CoD.BorderDipSmall.SmallDipLeftOffset)
	f2_local0:setTopBottom(false, true, -CoD.BorderDipSmall.SmallDipHeight, 0)
	f2_local0:setImage(RegisterMaterial(CoD.BorderDipSmall.SmallDip))
	f2_local0:setAlpha(alpha)
	f2_arg0:addElement(f2_local0)
	return f2_local0
end

CoD.BorderDipSmall.SetRGB = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	CoD.Border.SetRGB(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	f3_arg0.bottomBorderFiller:setRGB(f3_arg1, f3_arg2, f3_arg3)
	for f3_local0 = 1, #f3_arg0.dips, 1 do
		f3_arg0.dips[f3_local0]:setRGB(f3_arg1, f3_arg2, f3_arg3)
	end
end

