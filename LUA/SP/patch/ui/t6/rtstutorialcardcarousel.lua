require("T6.CoDBase")
require("T6.RTSTutorialCard")
CoD.RTSTutorialCardCarousel = {}
local f0_local0 = 0.01
local f0_local1 = 0.08
local f0_local2 = 0.08
local f0_local3 = 0.03
local f0_local4 = 0.06
local f0_local5 = CoD.fonts.Condensed
local f0_local6 = {
	r = 1,
	g = 1,
	b = 1
}
local f0_local7 = CoD.RTSColors.yellow
local f0_local8 = {
	r = 0.16,
	g = 0.15,
	b = 0.15
}
local f0_local9 = "uin_tab_cycle"
local f0_local10, f0_local11, f0_local12, f0_local13, f0_local14, f0_local15, f0_local16, f0_local17, f0_local18, f0_local19, f0_local20, f0_local21, f0_local22, f0_local23, f0_local24, f0_local25 = nil
f0_local20 = function (f1_arg0)
	if f1_arg0 ~= nil then
		f1_arg0.background:setAlpha(1)
		f1_arg0.backgroundCorner:setAlpha(1)
		f1_arg0.text:setRGB(f0_local7.r, f0_local7.g, f0_local7.b)
		f1_arg0.isCurrentlySelected = true
	end
end

f0_local21 = function (f2_arg0)
	if f2_arg0 ~= nil then
		f2_arg0.background:setAlpha(0)
		f2_arg0.backgroundCorner:setAlpha(0)
		f2_arg0.text:setRGB(f0_local8.r, f0_local8.g, f0_local8.b)
		f2_arg0.isCurrentlySelected = false
	end
end

f0_local10 = function (f3_arg0, f3_arg1, f3_arg2)
	if f3_arg0 ~= nil and f3_arg1 ~= nil and f3_arg2 ~= nil then
		local f3_local0, f3_local1, f3_local2, f3_local3 = GetTextDimensions(f3_arg0, f3_arg1, f3_arg2)
		return f3_local2
	else

	end
end

f0_local12 = function (f4_arg0, f4_arg1, f4_arg2)
	if f4_arg1 ~= nil then
		local f4_local0 = LUI.UIImage.new()
		f4_local0:setLeftRight(true, true, 0, -f4_arg0.TitleButtonCornerWidth)
		f4_local0:setTopBottom(true, true, 0, 0)
		f4_local0:setImage(RegisterMaterial("hud_strikeforce_grey_section_center"))
		f4_arg1:addElement(f4_local0)
		local f4_local1 = LUI.UIImage.new()
		f4_local1:setLeftRight(false, true, -f4_arg0.TitleButtonCornerWidth, 0)
		f4_local1:setTopBottom(true, true, 0, 0)
		f4_local1:setImage(RegisterMaterial("hud_strikeforce_grey_section"))
		f4_arg1:addElement(f4_local1)
		f4_arg1.background = f4_local0
		f4_arg1.backgroundCorner = f4_local1
	end
end

f0_local11 = function (f5_arg0, f5_arg1)
	if f5_arg0 ~= nil and f5_arg1 ~= nil then
		local f5_local0 = f0_local10(f5_arg1, f0_local5, f5_arg0.TitleFontHeight) + f5_arg0.TitleButtonCornerWidth - f5_arg0.TitleButtonCornerOffsetWidth
		local Widget = LUI.UIElement.new()
		Widget:setLeftRight(true, false, f5_arg0.tabWidth, f5_arg0.tabWidth + f5_local0)
		Widget:setTopBottom(true, false, -f5_arg0.TitleButtonHeight, 0)
		f0_local12(f5_arg0, Widget, f5_local0)
		
		local text = LUI.UIText.new()
		text:setLeftRight(true, true, f5_arg0.TitleButtonPadding, 0)
		text:setTopBottom(false, false, -f5_arg0.TitleFontHeight / 2, f5_arg0.TitleFontHeight / 2)
		text:setRGB(f0_local7.r, f0_local7.g, f0_local7.b)
		text:setFont(f0_local5)
		text:setText(f5_arg1)
		text:setAlignment(LUI.Alignment.Left)
		Widget:addElement(text)
		Widget.text = text
		
		f5_arg0.tabWidth = f5_arg0.tabWidth + f5_local0
		return Widget
	else

	end
end

f0_local13 = function (f6_arg0, f6_arg1, f6_arg2)
	if f6_arg0 ~= nil then
		if f6_arg1 ~= nil and f6_arg1.id == "RTSTutorialCard" then
			local f6_local0 = f0_local11(f6_arg0, f6_arg2)
			table.insert(f6_arg0.cards, f6_arg1)
			table.insert(f6_arg0.tabs, f6_local0)
			f6_arg0:addElement(f6_local0)
			f6_arg0:addElement(f6_arg1)
			f6_arg0.size = f6_arg0.size + 1
			if f6_arg0.size ~= 1 then
				f6_arg1:setAlpha(0)
				f0_local21(f6_local0)
				f6_local0.isCurrentlySelected = false
			else
				f6_local0.isCurrentlySelected = true
			end
			if CoD.useMouse then
				f6_local0:setHandleMouse(true)
				f6_local0:registerEventHandler("leftmousedown", CoD.NullFunction)
				f6_local0:registerEventHandler("leftmouseup", f0_local23)
				f6_local0:registerEventHandler("mouseenter", f0_local24)
				f6_local0:registerEventHandler("mouseleave", f0_local25)
				f6_local0.index = table.getn(f6_arg0.tabs)
			end
		else
			error("The rtsTutorialCard parameter is not a RTSTutorialCard object.")
		end
	end
end

f0_local17 = function (f7_arg0, f7_arg1)
	if f7_arg0 ~= nil and f7_arg1 ~= nil and f7_arg0.cards ~= nil then
		for f7_local3, f7_local4 in pairs(f7_arg0.cards) do
			if f7_local3 == f7_arg1 then
				if f7_local4 ~= nil then
					f7_local4:setAlpha(1)
					f0_local20(f7_arg0.tabs[f7_local3])
				end
			end
			if f7_local4 ~= nil then
				f7_local4:setAlpha(0)
				f0_local21(f7_arg0.tabs[f7_local3])
			end
		end
		if f7_arg1 == f7_arg0.size then
			f7_arg0.seenLast = true
		end
		Engine.PlaySound(f0_local9)
	end
end

f0_local15 = function (f8_arg0)
	if f8_arg0 ~= nil then
		return f8_arg0.size
	else

	end
end

f0_local14 = function (f9_arg0)
	if f9_arg0 ~= nil then
		return f9_arg0.height
	else

	end
end

f0_local16 = function (f10_arg0)
	if f10_arg0 ~= nil then
		return f10_arg0.width
	else

	end
end

f0_local18 = function (f11_arg0, f11_arg1)
	f11_arg0.currentCard = f11_arg0.currentCard + 1
	if table.getn(f11_arg0.cards) < f11_arg0.currentCard then
		f11_arg0.currentCard = 1
	end
	f0_local17(f11_arg0, f11_arg0.currentCard)
end

f0_local19 = function (f12_arg0, f12_arg1)
	f12_arg0.currentCard = f12_arg0.currentCard - 1
	if f12_arg0.currentCard < 1 then
		f12_arg0.currentCard = table.getn(f12_arg0.cards)
	end
	f0_local17(f12_arg0, f12_arg0.currentCard)
end

CoD.RTSTutorialCardCarousel.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new()
	Widget.width = HudRef
	Widget.height = InstanceRef
	if Widget.width == nil or Widget.height == nil then
		local f13_local1, f13_local2 = Engine.GetUserSafeArea()
		Widget.height = f13_local2
		Widget.width = f13_local1
	end
	Widget:setTopBottom(false, false, -Widget.height / 2, Widget.height / 2)
	Widget:setLeftRight(false, false, -Widget.width / 2, Widget.width / 2)
	Widget:addElement(LUI.UIButtonRepeater.new("right", "right_card"))
	Widget:addElement(LUI.UIButtonRepeater.new("left", "left_card"))
	Widget:registerEventHandler("right_card", f0_local18)
	Widget:registerEventHandler("left_card", f0_local19)
	if CoD.useMouse then
		Widget:registerEventHandler("tab_clicked", f0_local22)
	end
	Widget.tabs = {}
	Widget.cards = {}
	Widget.size = 0
	Widget.seenLast = false
	Widget.tabWidth = 0
	Widget.currentCard = 1
	Widget.TitleButtonHeight = Widget.height * f0_local1
	Widget.TitleButtonPadding = Widget.width * f0_local0
	Widget.TitleButtonCornerWidth = Widget.width * f0_local2
	Widget.TitleButtonCornerOffsetWidth = Widget.width * f0_local3
	Widget.TitleFontHeight = Widget.height * f0_local4
	Widget.addCard = f0_local13
	Widget.getHeight = f0_local14
	Widget.getSize = f0_local15
	Widget.getWidth = f0_local16
	Widget.selectCard = f0_local17
	Widget.rightCard = f0_local18
	Widget.leftCard = f0_local19
	return Widget
end

f0_local22 = function (f14_arg0, f14_arg1)
	f14_arg0.currentCard = f14_arg1.index
	if table.getn(f14_arg0.cards) < f14_arg0.currentCard then
		f14_arg0.currentCard = 1
	end
	local f14_local0 = table.getn(f14_arg0.cards)
	if f14_local0 < f14_arg0.currentCard then
		f14_arg0.currentCard = f14_local0
	end
	f0_local17(f14_arg0, f14_arg0.currentCard)
end

f0_local23 = function (f15_arg0, f15_arg1)
	if not f15_arg0.isCurrentlySelected then
		f15_arg0:dispatchEventToParent({
			name = "tab_clicked",
			controller = f15_arg1.controller,
			index = f15_arg0.index
		})
	end
end

f0_local24 = function (f16_arg0, f16_arg1)
	if not f16_arg0.isCurrentlySelected then
		f16_arg0.text:setRGB(f0_local7.r, f0_local7.g, f0_local7.b)
	end
end

f0_local25 = function (f17_arg0, f17_arg1)
	if not f17_arg0.isCurrentlySelected then
		f17_arg0.text:setRGB(f0_local8.r, f0_local8.g, f0_local8.b)
	end
end

