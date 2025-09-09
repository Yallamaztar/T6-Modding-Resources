CoD.Border = {}
CoD.Border.DefaultBottomMaterialName = "menu_sp_cac_single_dip"
CoD.Border.DefaultBottomImageHeight = 8
CoD.Border.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	if not f1_arg5 then
		f1_arg5 = 0
	end
	if not f1_arg6 then
		f1_arg6 = f1_arg5
	end
	if not f1_arg1 then
		f1_arg1 = 1
	end
	if not f1_arg2 then
		f1_arg2 = 1
	end
	if not f1_arg3 then
		f1_arg3 = 1
	end
	if not f1_arg4 then
		f1_arg4 = 1
	end
	if f1_arg0 < 2 then
		f1_arg0 = 2
	end
	local Widget = LUI.UIElement.new()
	Widget.id = "Border"
	Widget:setLeftRight(true, true, f1_arg5, -f1_arg5)
	Widget:setTopBottom(true, true, f1_arg6, -f1_arg6)
	Widget:setAlpha(f1_arg4)
	local f1_local1 = LUI.UIImage.new()
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(true, false, 0, f1_arg0)
	f1_local1:setRGB(f1_arg1, f1_arg2, f1_arg3)
	Widget.topBorder = f1_local1
	Widget:addElement(f1_local1)
	local f1_local2 = LUI.UIImage.new()
	f1_local2:setLeftRight(true, true, 0, 0)
	if f1_arg7 then
		local f1_local3 = RegisterMaterial(CoD.Border.DefaultBottomMaterialName)
		local f1_local4 = CoD.Border.DefaultBottomImageHeight
		if f1_arg8 then
			f1_local3 = RegisterMaterial(f1_arg8)
		end
		if f1_arg9 then
			f1_local4 = f1_arg9
		end
		f1_local2:setTopBottom(false, true, -f1_local4 - 1, -1)
		f1_local2:setImage(f1_local3)
	else
		f1_local2:setTopBottom(false, true, -f1_arg0, 0)
	end
	f1_local2:setRGB(f1_arg1, f1_arg2, f1_arg3)
	Widget.bottomBorder = f1_local2
	Widget:addElement(f1_local2)
	local f1_local3 = LUI.UIImage.new()
	f1_local3:setLeftRight(true, false, 0, f1_arg0)
	f1_local3:setTopBottom(true, true, f1_arg0, -f1_arg0)
	f1_local3:setRGB(f1_arg1, f1_arg2, f1_arg3)
	Widget.leftBorder = f1_local3
	Widget:addElement(f1_local3)
	local f1_local4 = LUI.UIImage.new()
	f1_local4:setLeftRight(false, true, -f1_arg0, 0)
	f1_local4:setTopBottom(true, true, f1_arg0, -f1_arg0)
	f1_local4:setRGB(f1_arg1, f1_arg2, f1_arg3)
	Widget.rightBorder = f1_local4
	Widget:addElement(f1_local4)
	Widget.setRGB = CoD.Border.SetRGB
	return Widget
end

CoD.Border.SetRGB = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	f2_arg0.topBorder:setRGB(f2_arg1, f2_arg2, f2_arg3)
	f2_arg0.bottomBorder:setRGB(f2_arg1, f2_arg2, f2_arg3)
	f2_arg0.leftBorder:setRGB(f2_arg1, f2_arg2, f2_arg3)
	f2_arg0.rightBorder:setRGB(f2_arg1, f2_arg2, f2_arg3)
end

