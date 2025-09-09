require("T6.RTSTutorialUnitPanel")
require("T6.Border")
CoD.RTSTutorialCard = {}
local f0_local0 = 0.04
local f0_local1 = 0.45
local f0_local2 = 0.4
local f0_local3 = 0.03
local f0_local4 = 0.02
local f0_local5 = 0.07
local f0_local6 = 0.04
local f0_local7 = 0.1
local f0_local8 = 0.07
local f0_local9 = 0.01
local f0_local10 = 0
local f0_local11 = 0.01
local f0_local12 = 0.48
local f0_local13 = 0.01
local f0_local14 = "Default"
local f0_local15 = CoD.fonts[f0_local14]
local f0_local16 = CoD.textSize[f0_local14] * 0.98
local f0_local17 = {
	r = 0.13,
	g = 0.11,
	b = 0.11
}
local f0_local18 = CoD.offWhite
local f0_local19 = "Default"
local f0_local20 = CoD.fonts[f0_local19]
local f0_local21 = CoD.textSize[f0_local19]
local f0_local22 = CoD.RTSColors.blue
local f0_local23 = CoD.RTSColors.yellow
local f0_local24 = {
	r = 0.16,
	g = 0.15,
	b = 0.15
}
local f0_local25 = 0.93
local f0_local26 = 0.3
local f0_local27, f0_local28, f0_local29, f0_local30, f0_local31, f0_local32, f0_local33, f0_local34, f0_local35, f0_local36, f0_local37, f0_local38, f0_local39, f0_local40, f0_local41, f0_local42, f0_local43, f0_local44, f0_local45, f0_local46, f0_local47 = nil
f0_local27 = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0 = 0
	local f1_local1, f1_local2, f1_local3, f1_local4 = GetTextDimensions(" ", f1_arg1, f1_arg2)
	local f1_local5 = f1_local3
	local f1_local6 = nil
	for f1_local16 in string.gmatch(f1_arg0, "[^\n]+") do
		f1_local6 = 0
		for f1_local10 in string.gmatch(f1_local16, "[^ ]+") do
			local f1_local12, f1_local13, f1_local14, f1_local15 = GetTextDimensions(f1_local10, f1_arg1, f1_arg2)
			f1_local4 = f1_local15
			f1_local3 = f1_local14
			f1_local2 = f1_local13
			f1_local1 = f1_local12
			if f1_local6 ~= 0 then
				f1_local6 = f1_local6 + f1_local5
			end
			if f1_arg3 < f1_local6 + f1_local3 then
				f1_local0 = f1_local0 + f1_local2
				f1_local6 = f1_local3
			else
				f1_local6 = f1_local6 + f1_local3
			end
		end
	end
	for f1_local16 in string.gmatch(f1_arg0, "[\n]") do
		f1_local0 = f1_local0 + f1_local2
	end
	return f1_local0 + f1_local2
end

f0_local28 = function (f2_arg0)
	if f2_arg0 ~= nil then
		local f2_local0 = LUI.UIImage.new()
		f0_local30(f2_local0)
		f2_local0:setRGB(f0_local24.r, f0_local24.g, f0_local24.b)
		f2_local0:setAlpha(f0_local25)
		f2_arg0:addElement(f2_local0)
	end
end

f0_local29 = function (f3_arg0)
	if f3_arg0 ~= nil then
		f3_arg0:beginAnimation("fade_in", 500)
		f3_arg0:setAlpha(1)
	end
end

f0_local30 = function (f4_arg0)
	if f4_arg0 ~= nil then
		f4_arg0:setTopBottom(true, true, 0, 0)
		f4_arg0:setLeftRight(true, true, 0, 0)
	end
end

function Center(f5_arg0, f5_arg1, f5_arg2)
	if f5_arg0 ~= nil then
		f5_arg0:setTopBottom(false, false, -f5_arg2 / 2, f5_arg2 / 2)
		f5_arg0:setLeftRight(false, false, -f5_arg1 / 2, f5_arg1 / 2)
	end
end

f0_local32 = function (f6_arg0, f6_arg1)
	f6_arg0.rightColumnHeight = f6_arg0.rightColumnHeight + f6_arg1
end

f0_local47 = function (f7_arg0)
	if f7_arg0 ~= nil then
		if f7_arg0.rightColumnItems > 0 then
			f7_arg0:addRightSpacer(f7_arg0.screenShotBorderPaddingSize)
		end
		local f7_local0 = f7_arg0.screenShotWidth - f7_arg0.screenShotOffset
		local f7_local1 = CoD.RTSTutorialUnitPanel.new(f7_local0 / 4, f7_arg0.screenShotHeight / 2.25)
		local f7_local2 = LUI.UIImage.new()
		f7_local2:setTopBottom(true, true, -1, 1)
		f7_local2:setLeftRight(true, true, -1, 1)
		f7_local2:setRGB(f0_local23.r, f0_local23.g, f0_local23.b)
		f7_local1:addElement(f7_local2)
		local f7_local3 = LUI.UIImage.new()
		f0_local30(f7_local3)
		f7_local3:setRGB(f0_local17.r, f0_local17.g, f0_local17.b)
		f7_local1:addElement(f7_local3)
		f7_local1:addUnitButton("hud_rts_talon", CoD.RTSTutorialUnitPanel.Direction.West, 2, false)
		f7_local1:setTopBottom(false, true, -f7_arg0.borderSize - f7_arg0.screenShotHeight / 2.25, -f7_arg0.borderSize)
		f7_local1:setLeftRight(false, true, -f7_arg0.borderSize - f7_local0, -f7_arg0.borderSize - 3 * f7_local0 / 4)
		f7_arg0.rightColumnHeight = f7_arg0.rightColumnHeight + f7_arg0.screenShotHeight / 2
		f7_arg0.rightColumnItems = f7_arg0.rightColumnItems + 1
		f7_arg0:addElement(f7_local1)
	end
end

f0_local46 = function (f8_arg0)
	if f8_arg0 ~= nil then
		if f8_arg0.rightColumnItems > 0 then
			f8_arg0:addRightSpacer(f8_arg0.screenShotBorderPaddingSize)
		end
		local f8_local0 = f8_arg0.screenShotWidth - f8_arg0.screenShotOffset
		local f8_local1 = CoD.RTSTutorialUnitPanel.new(f8_local0 / 4, f8_arg0.screenShotHeight / 2.25)
		local f8_local2 = LUI.UIImage.new()
		f8_local2:setTopBottom(true, true, -1, 1)
		f8_local2:setLeftRight(true, true, -1, 1)
		f8_local2:setRGB(f0_local23.r, f0_local23.g, f0_local23.b)
		f8_local1:addElement(f8_local2)
		local f8_local3 = LUI.UIImage.new()
		f0_local30(f8_local3)
		f8_local3:setRGB(f0_local17.r, f0_local17.g, f0_local17.b)
		f8_local1:addElement(f8_local3)
		f8_local1:addUnitButton("hud_rts_troops", CoD.RTSTutorialUnitPanel.Direction.West, 4, false)
		f8_local1:addUnitButton("hud_rts_sentry_gun", CoD.RTSTutorialUnitPanel.Direction.North, 3, false)
		f8_local1:addUnitButton("hud_rts_troops2_lit", CoD.RTSTutorialUnitPanel.Direction.East, 4, true)
		f8_local1:addUnitButton("hud_rts_claw", CoD.RTSTutorialUnitPanel.Direction.South, 1, false)
		f8_local1:setTopBottom(true, false, f8_arg0.rightColumnHeight, f8_arg0.rightColumnHeight + f8_arg0.screenShotHeight / 2.25)
		f8_local1:setLeftRight(false, true, -f8_arg0.borderSize - f8_local0, -f8_arg0.borderSize)
		f8_arg0.rightColumnHeight = f8_arg0.rightColumnHeight + f8_arg0.screenShotHeight / 2
		f8_arg0.rightColumnItems = f8_arg0.rightColumnItems + 1
		f8_arg0:addElement(f8_local1)
	end
end

f0_local31 = function (f9_arg0, f9_arg1)
	if f9_arg0 ~= nil then
		if f9_arg0.rightColumnItems > 0 then
			f9_arg0:addRightSpacer(f9_arg0.screenShotBorderPaddingSize)
		end
		local f9_local0 = LUI.UIStreamedImage.new()
		f9_local0:setTopBottom(true, false, f9_arg0.rightColumnHeight, f9_arg0.rightColumnHeight + f9_arg0.screenShotHeight)
		f9_local0:setLeftRight(false, true, -f9_arg0.borderSize - f9_arg0.screenShotWidth, -f9_arg0.borderSize + f9_arg0.screenShotBorderPaddingSize)
		f9_local0:setImage(RegisterMaterial(f9_arg1))
		f9_local0:setAlpha(0)
		f9_local0:registerEventHandler("streamed_image_ready", f0_local29)
		f9_arg0.rightColumnHeight = f9_arg0.rightColumnHeight + f9_arg0.screenShotHeight
		f9_arg0.rightColumnItems = f9_arg0.rightColumnItems + 1
		f9_arg0:addElement(f9_local0)
	end
end

f0_local44 = function (f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4)
	if f10_arg0 ~= nil then
		local f10_local0 = f10_arg0.width * f10_arg3
		local f10_local1 = f10_arg0.height * f10_arg4
		local f10_local2 = f10_arg0.width * f10_arg1
		local f10_local3 = LUI.UIImage.new()
		f10_local3:setTopBottom(true, false, f10_local1 - 1, f10_local1 + 1)
		f10_local3:setLeftRight(true, false, f10_local0 - f10_local2 / 2, f10_local0 + f10_local2 / 2)
		f10_local3:setRGB(f0_local23.r, f0_local23.g, f0_local23.b)
		f10_local3:setZRot(f10_arg2)
		f10_arg0:addElement(f10_local3)
		return f10_local3
	else

	end
end

f0_local45 = function (f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_arg4, f11_arg5)
	if f11_arg0 ~= nil then
		local f11_local0 = f11_arg5
		if f11_local0 == nil then
			f11_local0 = CoD.white
		end
		local f11_local1 = f11_arg0.width * f11_arg1
		local f11_local2 = f11_arg0.height * f11_arg2
		local f11_local3 = f11_arg0.width * f11_arg3
		local f11_local4 = f11_arg0.height * f11_arg4
		local Widget = LUI.UIElement.new()
		Widget:setTopBottom(true, false, f11_local2, f11_local2 + f11_local4)
		Widget:setLeftRight(true, false, f11_local1, f11_local1 + f11_local3)
		Widget:addElement(CoD.Border.new(1, f11_arg5.r, f11_arg5.g, f11_arg5.b, 1, -1))
		Widget:setRGB(f11_local0.r, f11_local0.g, f11_local0.b)
		f11_arg0:addElement(Widget)
		return Widget
	else

	end
end

f0_local43 = function (f12_arg0, f12_arg1, f12_arg2, f12_arg3, f12_arg4)
	if f12_arg0 ~= nil then
		local f12_local0 = f12_arg4
		if f12_local0 == nil then
			f12_local0 = CoD.white
		end
		local f12_local1 = f12_arg0.width * f12_arg2
		local f12_local2 = f12_arg0.height * f12_arg3
		local f12_local3, f12_local4, f12_local5, f12_local6 = GetTextDimensions(f12_arg1, f0_local15, f0_local16)
		local f12_local7 = LUI.UIText.new()
		f12_local7:setTopBottom(true, false, f12_local2 - f0_local16 / 2, f12_local2 + f0_local16 / 2)
		f12_local7:setLeftRight(true, false, f12_local1 - f12_local5 / 1.95, f12_local1 + f12_local5 / 1.95)
		f12_local7:setAlignment(LUI.Alignment.Center)
		f12_local7:setText(f12_arg1)
		f12_local7:setRGB(f12_local0.r, f12_local0.g, f12_local0.b)
		f12_local7:setFont(f0_local15)
		f12_arg0:addElement(f12_local7)
		return f12_local7
	else

	end
end

f0_local42 = function (f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4, f13_arg5)
	if f13_arg0 ~= nil then
		local f13_local0 = f13_arg0.width * f13_arg2
		local f13_local1 = f13_arg0.height * f13_arg3
		local f13_local2 = f13_arg0.width * f13_arg4
		local f13_local3 = f13_arg0.height * f13_arg5
		local f13_local4 = LUI.UIStreamedImage.new()
		f13_local4:setTopBottom(true, false, f13_local1 - f13_local3 / 2, f13_local1 + f13_local3 / 2)
		f13_local4:setLeftRight(true, false, f13_local0 - f13_local2 / 2, f13_local0 + f13_local2 / 2)
		f13_local4:setImage(RegisterMaterial(f13_arg1))
		f13_local4:registerEventHandler("streamed_image_ready", f0_local29)
		f13_arg0:addElement(f13_local4)
		return f13_local4
	else

	end
end

f0_local39 = function (f14_arg0, f14_arg1, f14_arg2)
	if f14_arg0 ~= nil then
		local f14_local0 = LUI.UIImage.new()
		f14_local0:setTopBottom(true, false, f14_arg2 - f14_arg0.textDotSize / 2, f14_arg2 + f14_arg0.textDotSize / 2)
		f14_local0:setLeftRight(true, false, f14_arg1 - f14_arg0.textDotSize / 2, f14_arg1 + f14_arg0.textDotSize / 2)
		f14_local0:setImage(RegisterMaterial("hud_strikeforce_yellow_dot"))
		return f14_local0
	else

	end
end

f0_local40 = function (f15_arg0, f15_arg1, f15_arg2, f15_arg3)
	if f15_arg0 ~= nil then
		local f15_local0 = LUI.UIText.new()
		f15_local0:setTopBottom(true, false, f15_arg3 - f15_arg0.textDotSize / 2, f15_arg3 + f15_arg0.textDotSize / 2)
		f15_local0:setLeftRight(true, false, f15_arg2 - f15_arg0.textDotSize / 2, f15_arg2 + f15_arg0.textDotSize / 2)
		f15_local0:setAlignment(LUI.Alignment.Center)
		f15_local0:setText(f15_arg1)
		f15_local0:setRGB(0, 0, 0)
		f15_local0:setFont(f0_local15)
		return f15_local0
	else

	end
end

f0_local33 = function (f16_arg0, f16_arg1)
	f16_arg0.leftColumnHeight = f16_arg0.leftColumnHeight + f16_arg1
end

f0_local41 = function (f17_arg0, f17_arg1, f17_arg2)
	if f17_arg0 ~= nil then
		local f17_local0 = f17_arg0.width * f17_arg1
		local f17_local1 = f17_arg0.height * f17_arg2
		local f17_local2 = LUI.UIImage.new()
		f17_local2:setTopBottom(true, false, f17_local1 - f17_arg0.circleSize / 2, f17_local1 + f17_arg0.circleSize / 2)
		f17_local2:setLeftRight(true, false, f17_local0 - f17_arg0.circleSize / 2, f17_local0 + f17_arg0.circleSize / 2)
		f17_local2:setImage(RegisterMaterial("hud_strikeforce_yellow_target_circle"))
		f17_arg0:addElement(f17_local2)
	end
end

function AddManualTextDot(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
	if f18_arg0 ~= nil then
		f18_arg0:addElement(f0_local39(f18_arg0, f18_arg0.width * f18_arg2, f18_arg0.height * f18_arg3))
		f18_arg0:addElement(f0_local40(f18_arg0, f18_arg1, f18_arg0.width * f18_arg2, f18_arg0.height * f18_arg3))
	end
end

f0_local38 = function (f19_arg0)
	if f19_arg0 ~= nil then
		local f19_local0 = 0
		if f19_arg0.lastItemWasText then
			f19_local0 = f0_local16 - f19_arg0.textPaddingRatio * 2
		end
		f19_arg0.dots = f19_arg0.dots + 1
		local f19_local1 = f19_arg0.leftColumnHeight + f19_arg0.textPaddingRatio + f19_local0 + f0_local16 / 2
		f19_arg0:addElement(f0_local39(f19_arg0, f19_arg0.borderSize / 2, f19_local1))
		f19_arg0:addElement(f0_local40(f19_arg0, f19_arg0.dots, f19_arg0.borderSize / 2, f19_local1))
	end
end

f0_local34 = function (f20_arg0, f20_arg1)
	if f20_arg0 ~= nil then
		f20_arg0.lastItemWasText = false
		if f20_arg0.leftColumnItems > 0 then
			f20_arg0:addLeftSpacer(f20_arg0.screenShotBorderPaddingSize)
		end
		local f20_local0 = LUI.UIImage.new()
		f20_local0:setTopBottom(true, false, f20_arg0.leftColumnHeight - f20_arg0.titleBackgroundHeightOffset, f20_arg0.leftColumnHeight + f20_arg0.titleHeight + f20_arg0.titleBackgroundHeightOffset)
		f20_local0:setLeftRight(true, false, f20_arg0.borderSize - f20_arg0.titleBackgroundLeftOffset, f20_arg0.borderSize + f20_arg0.leftColumnWidth + f20_arg0.titleBackgroundRightOffset)
		f20_local0:setImage(RegisterMaterial("hud_strikeforce_square_grid01"))
		f20_local0:setAlpha(f0_local26)
		f20_arg0:addElement(f20_local0)
		if f20_arg1 ~= nil then
			local f20_local1 = LUI.UIText.new()
			f20_local1:setTopBottom(true, false, f20_arg0.leftColumnHeight + f20_arg0.titleHeight / 2 - f0_local21 / 2, f20_arg0.leftColumnHeight + f20_arg0.titleHeight / 2 + f0_local21 / 2)
			f20_local1:setLeftRight(true, true, f20_arg0.borderSize + f20_arg0.textPaddingRatio, f20_arg0.borderSize + f20_arg0.leftColumnWidth - f20_arg0.textPaddingRatio)
			f20_local1:setFont(f0_local20)
			f20_local1:setAlignment(LUI.Alignment.Left)
			f20_local1:setText(f20_arg1)
			f20_local1:setRGB(f0_local22.r, f0_local22.g, f0_local22.b)
			f20_arg0:addElement(f20_local1)
		end
		f20_arg0.leftColumnHeight = f20_arg0.leftColumnHeight + f20_arg0.titleHeight
		f20_arg0.leftColumnItems = f20_arg0.leftColumnItems + 1
	end
end

f0_local36 = function (f21_arg0, f21_arg1)
	if f21_arg0 ~= nil then
		local f21_local0 = LUI.UIImage.new()
		f21_local0:setTopBottom(false, true, -f21_arg0.leftColumnBottomHeight - f21_arg0.titleHeight - f21_arg0.titleBackgroundHeightOffset, -f21_arg0.leftColumnBottomHeight + f21_arg0.titleBackgroundHeightOffset)
		f21_local0:setLeftRight(true, false, f21_arg0.borderSize - f21_arg0.titleBackgroundLeftOffset, f21_arg0.borderSize + f21_arg0.leftColumnWidth + f21_arg0.titleBackgroundRightOffset)
		f21_local0:setImage(RegisterMaterial("hud_strikeforce_square_grid01"))
		f21_local0:setAlpha(f0_local26)
		f21_arg0:addElement(f21_local0)
		if f21_arg1 ~= nil then
			local f21_local1 = LUI.UIText.new()
			f21_local1:setTopBottom(false, true, -f21_arg0.leftColumnBottomHeight - f21_arg0.titleHeight / 2 - f0_local21 / 2, -f21_arg0.leftColumnBottomHeight - f21_arg0.titleHeight / 2 + f0_local21 / 2)
			f21_local1:setLeftRight(true, true, f21_arg0.borderSize + f21_arg0.textPaddingRatio, f21_arg0.borderSize + f21_arg0.leftColumnWidth - f21_arg0.textPaddingRatio)
			f21_local1:setFont(f0_local20)
			f21_local1:setAlignment(LUI.Alignment.Left)
			f21_local1:setText(f21_arg1)
			f21_local1:setRGB(f0_local22.r, f0_local22.g, f0_local22.b)
			f21_arg0:addElement(f21_local1)
		end
		f21_arg0.leftColumnHeight = f21_arg0.leftColumnHeight + f21_arg0.titleHeight
		f21_arg0.leftColumnItems = f21_arg0.leftColumnItems + 1
	end
end

f0_local37 = function (f22_arg0, f22_arg1)
	if f22_arg0 ~= nil and f22_arg1 ~= nil then
		local f22_local0 = f0_local27(f22_arg1, f0_local15, f0_local16, f22_arg0.leftColumnWidth - f22_arg0.textPaddingRatio * 2) + f22_arg0.textPaddingRatio * 2
		local f22_local1 = LUI.UIImage.new()
		f22_local1:setLeftRight(true, false, f22_arg0.borderSize, f22_arg0.borderSize + f22_arg0.leftColumnWidth)
		f22_local1:setTopBottom(false, true, -f22_arg0.leftColumnBottomHeight - f22_local0, -f22_arg0.leftColumnBottomHeight)
		f22_local1:setRGB(f0_local17.r, f0_local17.g, f0_local17.b)
		f22_arg0:addElement(f22_local1)
		local f22_local2 = LUI.UIText.new()
		f22_local2:setTopBottom(false, true, -f22_arg0.leftColumnBottomHeight + f22_arg0.textPaddingRatio - f22_local0, -f22_arg0.leftColumnBottomHeight + f22_arg0.textPaddingRatio - f22_local0 + f0_local16)
		f22_local2:setLeftRight(true, false, f22_arg0.borderSize + f22_arg0.textPaddingRatio, f22_arg0.borderSize + f22_arg0.leftColumnWidth - f22_arg0.textPaddingRatio)
		f22_local2:setRGB(f0_local18.r, f0_local18.g, f0_local18.b)
		f22_local2:setFont(f0_local15)
		f22_local2:setAlignment(LUI.Alignment.Left)
		f22_local2:setText(f22_arg1)
		f22_arg0:addElement(f22_local2)
		f22_arg0.leftColumnBottomHeight = f22_arg0.leftColumnBottomHeight + f22_local0
	end
end

f0_local35 = function (f23_arg0, f23_arg1)
	if f23_arg0 ~= nil and f23_arg1 ~= nil then
		local f23_local0 = f0_local27(f23_arg1, f0_local15, f0_local16, f23_arg0.leftColumnWidth - f23_arg0.textPaddingRatio * 2) + f23_arg0.textPaddingRatio * 2
		local f23_local1 = 0
		if f23_arg0.lastItemWasText then
			f23_local1 = f0_local16 - f23_arg0.textPaddingRatio * 2
		end
		local f23_local2 = LUI.UIImage.new()
		f23_local2:setLeftRight(true, false, f23_arg0.borderSize, f23_arg0.borderSize + f23_arg0.leftColumnWidth)
		f23_local2:setTopBottom(true, false, f23_arg0.leftColumnHeight, f23_arg0.leftColumnHeight + f23_local0 + f23_local1)
		f23_local2:setRGB(f0_local17.r, f0_local17.g, f0_local17.b)
		f23_arg0:addElement(f23_local2)
		local f23_local3 = LUI.UIText.new()
		f23_local3:setTopBottom(true, false, f23_arg0.leftColumnHeight + f23_arg0.textPaddingRatio + f23_local1, f23_arg0.leftColumnHeight + f0_local16 + f23_arg0.textPaddingRatio + f23_local1)
		f23_local3:setLeftRight(true, false, f23_arg0.borderSize + f23_arg0.textPaddingRatio, f23_arg0.borderSize + f23_arg0.leftColumnWidth - f23_arg0.textPaddingRatio)
		f23_local3:setRGB(f0_local18.r, f0_local18.g, f0_local18.b)
		f23_local3:setFont(f0_local15)
		f23_local3:setAlignment(LUI.Alignment.Left)
		f23_local3:setText(f23_arg1)
		f23_arg0:addElement(f23_local3)
		f23_arg0.leftColumnHeight = f23_arg0.leftColumnHeight + f23_local0 + f23_local1
		f23_arg0.leftColumnItems = f23_arg0.leftColumnItems + 1
		f23_arg0.lastItemWasText = true
		return f23_local3
	else
		return nil
	end
end

CoD.RTSTutorialCard.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget.width = HudRef
	Widget.height = InstanceRef
	if Widget.width == nil or Widget.height == nil then
		local f24_local1, f24_local2 = Engine.GetUserSafeArea()
		Widget.height = f24_local2
		Widget.width = f24_local1
	end
	Center(Widget, Widget.width, Widget.height)
	f0_local28(Widget)
	Widget.id = "RTSTutorialCard"
	Widget.rightColumnItems = 0
	Widget.leftColumnItems = 0
	Widget.lastItemWasText = false
	Widget.dots = 0
	Widget.borderSize = Widget.height * f0_local5
	Widget.screenShotBorderPaddingSize = Widget.height * f0_local0
	Widget.screenShotBorderSize = Widget.height * f0_local4
	Widget.screenShotHeight = Widget.height * f0_local2
	Widget.screenShotWidth = Widget.width * f0_local1
	Widget.screenShotOffset = Widget.width * f0_local3
	Widget.titleHeight = Widget.height * f0_local8
	Widget.titleBackgroundHeightOffset = Widget.height * f0_local9
	Widget.titleBackgroundLeftOffset = Widget.width * f0_local10
	Widget.titleBackgroundRightOffset = Widget.width * f0_local11
	Widget.leftColumnWidth = Widget.width * f0_local12
	Widget.textPaddingRatio = Widget.height * f0_local13
	Widget.rightColumnHeight = Widget.borderSize
	Widget.leftColumnHeight = Widget.borderSize
	Widget.leftColumnBottomHeight = Widget.borderSize
	Widget.textDotSize = Widget.height * f0_local6
	Widget.circleSize = Widget.height * f0_local7
	Widget.addRightScreenshot = f0_local31
	Widget.addRightSpacer = f0_local32
	Widget.addLeftSpacer = f0_local33
	Widget.addLeftTitle = f0_local34
	Widget.addLeftText = f0_local35
	Widget.addTextDot = f0_local38
	Widget.addManualTextDot = AddManualTextDot
	Widget.addManualCircle = f0_local41
	Widget.addManualScreenshot = f0_local42
	Widget.addManualText = f0_local43
	Widget.addManualLine = f0_local44
	Widget.addManualBox = f0_local45
	Widget.addLeftBottomText = f0_local37
	Widget.addLeftBottomTitle = f0_local36
	Widget.addCustomRightElement = AddCustomRightElement
	Widget.addActiveUnitPanel = f0_local46
	Widget.addSquadUnitPanel = f0_local47
	return Widget
end

