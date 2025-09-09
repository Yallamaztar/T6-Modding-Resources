CoD.ChallengeGridButton = {}
CoD.ChallengeGridButton.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	local f1_local0 = CoD.ContentGridButton.new(f1_arg1)
	CoD.ContentGridButton.SetupButtonText(f1_local0, f1_arg2)
	CoD.ChallengeGridButton.SetupButtonImages(f1_local0, f1_arg3, f1_arg4)
	f1_local0.gainFocusSFX = "cac_grid_nav"
	return f1_local0
end

CoD.ChallengeGridButton.AddImage = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	if f2_arg0.itemImage then
		f2_arg0.itemImage:close()
	end
	f2_arg0.itemImage = LUI.UIImage.new()
	f2_arg0.itemImage:setLeftRight(false, false, -f2_arg1 / 2, f2_arg1 / 2)
	f2_arg0.itemImage:setTopBottom(true, false, f2_arg3, f2_arg3 + f2_arg2)
	f2_arg0:addElement(f2_arg0.itemImage)
end

CoD.ChallengeGridButton.SetupButtonImages = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = 5
	local f3_local1 = CoD.ContentGridButton.TitleHeight + 4
	local f3_local2 = 50
	local f3_local3 = 50
	if not f3_arg2 then
		f3_local0 = 6
		f3_local3 = 48
		f3_local2 = f3_local3 * 4
	end
	CoD.ChallengeGridButton.AddImage(f3_arg0, f3_local2, f3_local3, f3_local0)
	if f3_arg2 then
		f3_arg0.itemImage:setupDrawEmblemById(f3_arg1)
	else
		f3_arg0.itemImage:setupDrawBackgroundById(f3_arg1)
	end
	f3_arg0.itemImage:setPriority(-70)
	CoD.ContentGridButton.SetupButtonImages(f3_arg0, CoD.GrenadeGridButton.glowBackColor, CoD.GrenadeGridButton.glowFrontColor)
end

