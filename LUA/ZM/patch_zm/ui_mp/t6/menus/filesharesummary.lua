require("LUI.LUIVerticalList")
CoD.FileshareSummary = {}
CoD.FileshareSummary.RowHeight = 40
CoD.FileshareSummary.HighlightNormal = 1
CoD.FileshareSummary.HighlightBright = 2
CoD.FileshareSummary.HighlightDark = 3
CoD.FileshareSummary.GetShadedIconUpdate = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6)
	if f1_arg1 ~= nil and f1_arg2 ~= nil and f1_arg3 ~= nil then
		f1_arg0.iconBg:setRGB(f1_arg1, f1_arg2, f1_arg3)
	end
	if f1_arg4 ~= nil then
		f1_arg0.iconBg:setAlpha(f1_arg4)
	end
	if f1_arg5 ~= nil then
		f1_arg0.iconShading:setAlpha(f1_arg5)
	end
	if f1_arg6 ~= nil then
		f1_arg0.icon:setImage(RegisterMaterial(f1_arg6))
		f1_arg0.icon:setAlpha(1)
	else
		f1_arg0.icon:setAlpha(0)
	end
end

CoD.FileshareSummary.GetShadedIcon = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5)
	local Widget = LUI.UIElement.new()
	
	local iconBg = LUI.UIImage.new()
	iconBg:setLeftRight(true, true, 0, 0)
	iconBg:setTopBottom(true, true, 0, 0)
	Widget:addElement(iconBg)
	Widget.iconBg = iconBg
	
	local iconShading = LUI.UIImage.new()
	iconShading:setLeftRight(true, true, 0, 0)
	iconShading:setTopBottom(true, false, 0, 8)
	iconShading:setRGB(1, 1, 1)
	Widget:addElement(iconShading)
	Widget.iconShading = iconShading
	
	local icon = LUI.UIImage.new()
	icon:setLeftRight(false, false, -16, 16)
	icon:setTopBottom(false, false, -16, 16)
	Widget:addElement(icon)
	Widget.icon = icon
	
	Widget.update = CoD.FileshareSummary.GetShadedIconUpdate
	Widget:update(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5)
	return Widget
end

CoD.FileshareSummary.PulseOn = function (f3_arg0, f3_arg1)
	f3_arg0:completeAnimation()
	f3_arg0:beginAnimation("pulseon", 500)
	f3_arg0:setAlpha(0.8)
end

CoD.FileshareSummary.PulseOff = function (f4_arg0, f4_arg1)
	f4_arg0:completeAnimation()
	f4_arg0:beginAnimation("pulseoff", 500)
	f4_arg0:setAlpha(0.4)
end

CoD.FileshareSummary.NewGroupRow = function (f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	local f5_local0 = 3
	if f5_arg0.occupied < 0 then
		f5_arg0.occupied = 0
	end
	if f5_arg0.remaining < 0 then
		f5_arg0.remaining = 0
	end
	local f5_local1 = 1
	local f5_local2 = 0.6
	if f5_arg2 == CoD.FileshareSummary.HighlightDark then
		f5_arg0.r = 0.4
		f5_arg0.g = 0.4
		f5_arg0.b = 0.4
		f5_local1 = 0.3
		f5_local2 = 0.3
	end
	local f5_local3 = 0
	if f5_arg0.occupied + f5_arg0.remaining > 0 then
		f5_local3 = f5_arg0.occupied / (f5_arg0.occupied + f5_arg0.remaining)
	end
	local f5_local4 = 2
	local f5_local5 = (f5_arg1 - f5_local4 * (f5_arg0.occupied - 1)) / (f5_arg0.remaining + f5_arg0.occupied)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, 0, CoD.FileshareSummary.RowHeight)
	local f5_local7 = LUI.UIImage.new()
	f5_local7:setLeftRight(true, true, 0, 0)
	f5_local7:setTopBottom(true, true, 0, 0)
	f5_local7:setRGB(0, 0, 0)
	f5_local7:setAlpha(1)
	Widget:addElement(f5_local7)
	local f5_local8 = CoD.FileshareSummary.GetShadedIcon(f5_arg0.r, f5_arg0.g, f5_arg0.b, f5_local1, 0.3, f5_arg0.icon)
	f5_local8:setLeftRight(true, false, f5_local0, f5_local0 + 50)
	f5_local8:setTopBottom(false, false, -16, 16)
	Widget:addElement(f5_local8)
	for f5_local9 = 1, f5_arg0.occupied, 1 do
		local f5_local12 = CoD.FileshareSummary.GetShadedIcon(f5_arg0.r, f5_arg0.g, f5_arg0.b, f5_local2, 0.1)
		local f5_local13 = (f5_local5 + f5_local4) * (f5_local9 - 1)
		f5_local12:setLeftRight(true, false, f5_local0 + 52 + f5_local13, f5_local0 + 52 + f5_local13 + f5_local5)
		f5_local12:setTopBottom(false, false, -16, 16)
		Widget:addElement(f5_local12)
	end
	local f5_local9 = (f5_local5 + f5_local4) * f5_arg0.occupied
	if f5_arg2 == CoD.FileshareSummary.HighlightBright and f5_arg0.remaining > 0 and f5_arg3 == true then
		local f5_local10 = CoD.FileshareSummary.GetShadedIcon(f5_arg0.r, f5_arg0.g, f5_arg0.b, 0.8, 0.1)
		f5_local10:setLeftRight(true, false, f5_local0 + 52 + f5_local9, f5_local0 + 52 + f5_local9 + f5_local5)
		f5_local10:setTopBottom(false, false, -16, 16)
		f5_local10:registerEventHandler("transition_complete_pulseon", CoD.FileshareSummary.PulseOff)
		f5_local10:registerEventHandler("transition_complete_pulseoff", CoD.FileshareSummary.PulseOn)
		CoD.FileshareSummary.PulseOff(f5_local10)
		Widget:addElement(f5_local10)
	end
	f5_local10 = LUI.UIText.new()
	f5_local10:setLeftRight(true, true, 60, 0)
	f5_local10:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
	f5_local10:setText(Engine.Localize(f5_arg0.locName))
	f5_local10:setAlignment(LUI.Alignment.Left)
	Widget:addElement(f5_local10)
	local f5_local11 = LUI.UIText.new()
	f5_local11:setLeftRight(true, true, 0, -10)
	f5_local11:setTopBottom(false, false, -CoD.textSize.Default / 2, CoD.textSize.Default / 2)
	if f5_arg0.remaining == 0 then
		f5_local11:setText(f5_arg0.occupied .. " - " .. Engine.Localize("MENU_FILESHARE_FULL"))
		f5_local11:setRGB(CoD.brightRed.r, CoD.brightRed.g, CoD.brightRed.b)
	else
		f5_local11:setText(f5_arg0.occupied .. " / " .. f5_arg0.occupied + f5_arg0.remaining)
		f5_local11:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	end
	f5_local11:setAlignment(LUI.Alignment.Right)
	Widget:addElement(f5_local11)
	Widget:addElement(CoD.Border.new(1, 1, 1, 1, 0.2))
	if f5_arg2 == CoD.FileshareSummary.HighlightDark then
		f5_local10:setRGB(CoD.offGray.r, CoD.offGray.g, CoD.offGray.b)
		f5_local11:setRGB(CoD.offGray.r, CoD.offGray.g, CoD.offGray.b)
	end
	return Widget
end

CoD.FileshareSummary.new = function (f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5)
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -f6_arg1, 0)
	Widget:setTopBottom(true, true, f6_arg0, 0)
	local f6_local1 = #f6_arg3
	local f6_local2 = 0
	local f6_local3 = 4
	local f6_local4 = CoD.textSize.ExtraSmall + 10 + f6_local1 * CoD.FileshareSummary.RowHeight + (f6_local1 - 1) * f6_local3
	if f6_arg4 ~= nil then
		f6_local4 = CoD.textSize.ExtraSmall + 10 + CoD.FileshareSummary.RowHeight
	end
	local f6_local5 = LUI.UIImage.new()
	f6_local5:setLeftRight(true, true, -8, 8)
	f6_local5:setTopBottom(true, false, 0, f6_local4)
	f6_local5:setRGB(0.2, 0.2, 0.2)
	f6_local5:setAlpha(0.3)
	Widget:addElement(f6_local5)
	local f6_local6 = LUI.UIText.new()
	f6_local6:setLeftRight(true, true, 0, 0)
	f6_local6:setTopBottom(true, false, f6_local2, f6_local2 + CoD.textSize.ExtraSmall)
	f6_local6:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f6_local6:setText(Engine.Localize("MENU_FILESHARE_SAVED_FILES"))
	f6_local6:setFont(CoD.fonts.ExtraSmall)
	f6_local6:setAlignment(LUI.Alignment.Left)
	f6_local6:setAlpha(1)
	Widget:addElement(f6_local6)
	local f6_local7 = LUI.UIText.new()
	f6_local7:setLeftRight(true, true, 0, 0)
	f6_local7:setTopBottom(true, false, f6_local2, f6_local2 + CoD.textSize.ExtraSmall)
	f6_local7:setRGB(CoD.offWhite.r, CoD.offWhite.g, CoD.offWhite.b)
	f6_local7:setText(Engine.Localize("MENU_FILESHARE_SLOTS_USED"))
	f6_local7:setFont(CoD.fonts.ExtraSmall)
	f6_local7:setAlignment(LUI.Alignment.Right)
	f6_local7:setAlpha(1)
	Widget:addElement(f6_local7)
	f6_local2 = f6_local2 + CoD.textSize.ExtraSmall + 5
	local f6_local8 = LUI.UIVerticalList.new()
	f6_local8:setLeftRight(true, true, 0, 0)
	f6_local8:setTopBottom(true, true, f6_local2, 0)
	f6_local8:setSpacing(f6_local3)
	Widget:addElement(f6_local8)
	for f6_local9 = 1, f6_local1, 1 do
		local f6_local12 = CoD.FileshareSummary.HighlightNormal
		if f6_arg4 ~= nil then
			if f6_arg3[f6_local9].name == f6_arg4 then
				f6_local8:addElement(CoD.FileshareSummary.NewGroupRow(f6_arg3[f6_local9], f6_arg2, CoD.FileshareSummary.HighlightBright, f6_arg5))
			end
		end
		f6_local8:addElement(CoD.FileshareSummary.NewGroupRow(f6_arg3[f6_local9], f6_arg2, f6_local12, f6_arg5))
	end
	return Widget
end

