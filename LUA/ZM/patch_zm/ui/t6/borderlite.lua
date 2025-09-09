CoD.BorderLite = {}
CoD.BorderLite.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5)
	if not f1_arg2 then
		f1_arg2 = 1
	end
	if not f1_arg3 then
		f1_arg3 = 1
	end
	if not f1_arg4 then
		f1_arg4 = 1
	end
	if not f1_arg5 then
		f1_arg5 = 1
	end
	local f1_local0 = LUI.UIImage.new()
	f1_local0:setLeftRight(true, true, 0, 0)
	f1_local0:setTopBottom(true, false, 0, f1_arg1)
	f1_local0:setRGB(f1_arg2, f1_arg3, f1_arg4)
	f1_local0:setAlpha(f1_arg5)
	f1_arg0.topBorder = f1_local0
	f1_arg0:addElement(f1_local0)
	local f1_local1 = LUI.UIImage.new()
	f1_local1:setLeftRight(true, true, 0, 0)
	f1_local1:setTopBottom(false, true, -f1_arg1, 0)
	f1_local1:setRGB(f1_arg2, f1_arg3, f1_arg4)
	f1_local1:setAlpha(f1_arg5)
	f1_arg0.bottomBorder = f1_local1
	f1_arg0:addElement(f1_local1)
	local f1_local2 = LUI.UIImage.new()
	f1_local2:setLeftRight(true, false, 0, f1_arg1)
	f1_local2:setTopBottom(true, true, 0, 0)
	f1_local2:setRGB(f1_arg2, f1_arg3, f1_arg4)
	f1_local2:setAlpha(f1_arg5)
	f1_arg0.leftBorder = f1_local2
	f1_arg0:addElement(f1_local2)
	local f1_local3 = LUI.UIImage.new()
	f1_local3:setLeftRight(false, true, -f1_arg1, 0)
	f1_local3:setTopBottom(true, true, 0, 0)
	f1_local3:setRGB(f1_arg2, f1_arg3, f1_arg4)
	f1_local3:setAlpha(f1_arg5)
	f1_arg0.rightBorder = f1_local3
	f1_arg0:addElement(f1_local3)
	f1_arg0.setBorderRGB = CoD.BorderLite.SetRGB
	f1_arg0.setBorderAlpha = CoD.BorderLite.SetAlpha
end

CoD.BorderLite.SetRGB = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	f2_arg0.topBorder:setRGB(f2_arg1, f2_arg2, f2_arg3)
	f2_arg0.bottomBorder:setRGB(f2_arg1, f2_arg2, f2_arg3)
	f2_arg0.leftBorder:setRGB(f2_arg1, f2_arg2, f2_arg3)
	f2_arg0.rightBorder:setRGB(f2_arg1, f2_arg2, f2_arg3)
end

CoD.BorderLite.SetAlpha = function (f3_arg0, f3_arg1)
	f3_arg0.topBorder:setAlpha(f3_arg1)
	f3_arg0.bottomBorder:setAlpha(f3_arg1)
	f3_arg0.leftBorder:setAlpha(f3_arg1)
	f3_arg0.rightBorder:setAlpha(f3_arg1)
end

