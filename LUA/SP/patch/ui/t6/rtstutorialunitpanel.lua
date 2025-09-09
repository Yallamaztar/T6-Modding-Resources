CoD.RTSTutorialUnitPanel = {}
CoD.RTSTutorialUnitPanel.Direction = {}
CoD.RTSTutorialUnitPanel.Direction.North = "north"
CoD.RTSTutorialUnitPanel.Direction.South = "south"
CoD.RTSTutorialUnitPanel.Direction.East = "east"
CoD.RTSTutorialUnitPanel.Direction.West = "west"
local f0_local0 = 0.65
local f0_local1 = 0.65
local f0_local2 = 0.08
local f0_local3 = 0.15
local f0_local4 = 0.15
local f0_local5 = 0.6
local f0_local6 = "hud_rts_dpad_arrow"
local f0_local7 = "hud_rts_dpad_arrow_lit"
local f0_local8 = 180
local f0_local9 = 90
local f0_local10 = 270
local f0_local11 = 0
local f0_local12 = CoD.fonts.Default
local f0_local13 = {
	r = 1,
	g = 1,
	b = 1
}
local f0_local14, f0_local15, f0_local16, f0_local17 = nil
f0_local17 = function (f1_arg0, f1_arg1)
	local f1_local0 = LUI.UIText.new()
	f1_local0:setTopBottom(true, false, f1_arg0.iconOffset + f1_arg0.iconHeight / 2 - f1_arg0.textFontHeight / 2, f1_arg0.iconOffset + f1_arg0.iconHeight / 2 + f1_arg0.textFontHeight / 2)
	f1_local0:setLeftRight(true, false, f1_arg0.currentWidth + f1_arg0.width / 2 - f1_arg0.iconWidth / 2, f1_arg0.currentWidth + f1_arg0.width / 2 + f1_arg0.iconWidth / 2)
	f1_local0:setFont(f0_local12)
	f1_local0:setAlignment(LUI.Alignment.Center)
	f1_local0:setRGB(f0_local13.r, f0_local13.g, f0_local13.b)
	f1_local0:setText(f1_arg1)
	f1_arg0:addElement(f1_local0)
end

f0_local16 = function (f2_arg0, f2_arg1)
	local f2_local0 = LUI.UIImage.new()
	f2_local0:setTopBottom(true, false, f2_arg0.iconOffset, f2_arg0.iconHeight + f2_arg0.iconOffset)
	f2_local0:setLeftRight(true, false, f2_arg0.currentWidth + f2_arg0.width / 2 - f2_arg0.iconWidth / 2, f2_arg0.currentWidth + f2_arg0.width / 2 + f2_arg0.iconWidth / 2)
	f2_local0:setImage(RegisterMaterial(f2_arg1))
	f2_arg0:addElement(f2_local0)
end

f0_local15 = function (f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = nil
	if f3_arg1 == CoD.RTSTutorialUnitPanel.Direction.North then
		f3_local0 = f0_local8
	elseif f3_arg1 == CoD.RTSTutorialUnitPanel.Direction.South then
		f3_local0 = f0_local11
	elseif f3_arg1 == CoD.RTSTutorialUnitPanel.Direction.East then
		f3_local0 = f0_local9
	else
		f3_local0 = f0_local10
	end
	local f3_local1 = LUI.UIImage.new()
	f3_local1:setTopBottom(true, false, f3_arg0.iconHeight + f3_arg0.iconOffset, f3_arg0.iconHeight + f3_arg0.arrowHeight + f3_arg0.iconOffset)
	f3_local1:setLeftRight(true, false, f3_arg0.currentWidth + f3_arg0.width / 2 - f3_arg0.arrowHeight / 2, f3_arg0.currentWidth + f3_arg0.width / 2 + f3_arg0.arrowWidth / 2)
	if f3_arg2 == nil or not f3_arg2 then
		f3_local1:setImage(RegisterMaterial(f0_local6))
	else
		f3_local1:setImage(RegisterMaterial(f0_local7))
	end
	f3_local1:setZRot(f3_local0)
	f3_arg0:addElement(f3_local1)
end

f0_local14 = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	if f4_arg0 == nil or f4_arg1 == nil or f4_arg2 == nil then
		error("Unable to create a unit button with nil information")
	end
	f0_local16(f4_arg0, f4_arg1)
	f0_local15(f4_arg0, f4_arg2, f4_arg4)
	f0_local17(f4_arg0, f4_arg3)
	f4_arg0.currentWidth = f4_arg0.currentWidth + f4_arg0.width
end

CoD.RTSTutorialUnitPanel.new = function (f5_arg0, f5_arg1)
	if f5_arg0 == nil or f5_arg1 == nil then
		error("The creation of a RTSTutorialUnitPanel requires width and height information.")
	end
	local Widget = LUI.UIElement.new()
	Widget.width = f5_arg0
	Widget.height = f5_arg1
	Widget.id = "RTSTutorialUnitPanel"
	Widget.currentWidth = 0
	Widget.arrowWidth = Widget.width * f0_local3
	Widget.arrowHeight = Widget.height * f0_local4
	Widget.iconWidth = Widget.width * f0_local0
	Widget.iconHeight = Widget.height * f0_local1
	Widget.iconOffset = Widget.height * f0_local2
	Widget.textFontHeight = Widget.iconHeight * f0_local5
	Widget.addUnitButton = f0_local14
	return Widget
end

