CoD.RTSResultPopup = {}
local f0_local0 = {
	r = 0.16,
	g = 0.15,
	b = 0.15
}
local f0_local1 = 0.85
local f0_local2 = {
	r = f0_local0.r * 4,
	g = f0_local0.g * 4,
	b = f0_local0.b * 4
}
local f0_local3 = {
	r = f0_local0.r * 2,
	g = f0_local0.g * 2,
	b = f0_local0.b * 2
}
local f0_local4 = 0.4
local f0_local5 = 0.5
local f0_local6, f0_local7, f0_local8, f0_local9 = nil
f0_local8 = function ()
	local f1_local0 = 720
	local f1_local1 = f1_local0 * Engine.GetAspectRatio()
	local f1_local2 = LUI.UIImage.new()
	f1_local2:setLeftRight(false, false, -f1_local1 / 2, f1_local1 / 2)
	f1_local2:setTopBottom(false, false, -f1_local0 / 2, f1_local0 / 2)
	f1_local2:setRGB(0, 0, 0)
	f1_local2:setAlpha(0)
	return f1_local2
end

f0_local7 = function (f2_arg0, f2_arg1)
	local f2_local0 = 0.01
	local f2_local1 = 0
	local f2_local2 = 0.1
	local f2_local3 = 0.1
	local f2_local4 = 0.2
	local f2_local5 = f2_arg1 * f2_local0
	local f2_local6 = f2_arg1 * f2_local2
	local f2_local7 = f2_arg0 * f2_local3
	local f2_local8 = f2_arg0 * f2_local4
	local f2_local9 = f2_arg0 * f2_local1
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, false, -f2_arg0 / 2 - f2_local9, f2_arg0 / 2 + f2_local9)
	Widget:setTopBottom(false, false, f2_arg1 / 2 - f2_local5, f2_arg1 / 2 - f2_local5 + f2_local6)
	local f2_local11 = LUI.UIImage.new()
	f2_local11:setTopBottom(true, true, 0, 0)
	f2_local11:setLeftRight(true, false, 0, f2_local7)
	f2_local11:setImage(RegisterMaterial("hud_strikeforce_map_bar_left"))
	f2_local11:setRGB(f0_local2.r, f0_local2.g, f0_local2.b)
	Widget:addElement(f2_local11)
	local f2_local12 = LUI.UIImage.new()
	f2_local12:setTopBottom(true, true, 0, 0)
	f2_local12:setLeftRight(false, true, -f2_local7, 0)
	f2_local12:setImage(RegisterMaterial("hud_strikeforce_map_bar_right"))
	f2_local12:setRGB(f0_local2.r, f0_local2.g, f0_local2.b)
	Widget:addElement(f2_local12)
	local f2_local13 = LUI.UIImage.new()
	f2_local13:setTopBottom(true, true, 0, 0)
	f2_local13:setLeftRight(false, false, -f2_local8 / 2, f2_local8 / 2)
	f2_local13:setImage(RegisterMaterial("hud_strikeforce_map_bar_center"))
	f2_local13:setRGB(f0_local2.r, f0_local2.g, f0_local2.b)
	Widget:addElement(f2_local13)
	local f2_local14 = LUI.UIImage.new()
	f2_local14:setTopBottom(true, true, 0, 0)
	f2_local14:setLeftRight(false, true, -f2_arg0 / 2 + f2_local8 / 2 - f2_local9, -f2_local7)
	f2_local14:setImage(RegisterMaterial("hud_strikeforce_map_bar_spacer"))
	f2_local14:setRGB(f0_local2.r, f0_local2.g, f0_local2.b)
	Widget:addElement(f2_local14)
	local f2_local15 = LUI.UIImage.new()
	f2_local15:setTopBottom(true, true, 0, 0)
	f2_local15:setLeftRight(true, false, f2_local7, f2_arg0 / 2 - f2_local8 / 2 + f2_local9)
	f2_local15:setImage(RegisterMaterial("hud_strikeforce_map_bar_spacer"))
	f2_local15:setRGB(f0_local2.r, f0_local2.g, f0_local2.b)
	Widget:addElement(f2_local15)
	return Widget
end

function Result(f3_arg0)
	local f3_local0 = LUI.UIText.new()
	f3_local0:setFont(CoD.fonts.Big)
	f3_local0:setLeftRight(true, true, 0, 0)
	f3_local0:setTopBottom(false, false, -CoD.textSize.Big / 2, CoD.textSize.Big / 2)
	if f3_arg0 ~= nil and f3_arg0 then
		f3_local0:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		f3_local0:setText(Engine.Localize("SO_RTS_MISSION_SUCCESS"))
	else
		f3_local0:setRGB(CoD.RTSColors.blue.r, CoD.RTSColors.blue.g, CoD.RTSColors.blue.b)
		f3_local0:setText(Engine.Localize("SO_RTS_MISSION_FAILED"))
	end
	f3_local0:registerAnimationState("fade_in", {
		alpha = 1
	})
	f3_local0:registerAnimationState("fade_out", {
		alpha = 0
	})
	return f3_local0
end

f0_local6 = function (f4_arg0, f4_arg1, f4_arg2)
	if f4_arg0 ~= nil and f4_arg0.height then
		local f4_local0 = math.floor(f4_arg0.height / f4_arg2) * f4_arg1
		local f4_local1 = LUI.UIImage.new()
		f4_local1:setLeftRight(true, true, 0, 0)
		f4_local1:setTopBottom(true, false, f4_local0, f4_local0 + 1)
		f4_local1:setRGB(f0_local3.r, f0_local3.g, f0_local3.b)
		f4_local1:setAlpha(f0_local4)
		f4_arg0:addElement(f4_local1)
	end
end

function AddVerticalLine(f5_arg0, f5_arg1, f5_arg2)
	if f5_arg0 ~= nil and f5_arg0.width then
		local f5_local0 = math.floor(f5_arg0.width / f5_arg2) * f5_arg1
		local f5_local1 = LUI.UIImage.new()
		f5_local1:setTopBottom(true, true, 0, 0)
		f5_local1:setLeftRight(true, false, f5_local0, f5_local0 + 1)
		f5_local1:setRGB(f0_local3.r, f0_local3.g, f0_local3.b)
		f5_local1:setAlpha(f0_local4)
		f5_arg0:addElement(f5_local1)
	end
end

CoD.RTSResultPopup.new = function (f6_arg0)
	local f6_local0, f6_local1 = Engine.GetUserSafeArea()
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, true, 0, 0)
	local Widget = LUI.UIElement.new()
	Widget.height = f6_local1 * f0_local5
	Widget.width = Widget.height * 1.78
	Widget:setLeftRight(false, false, -Widget.width / 2, Widget.width / 2)
	Widget:setTopBottom(false, false, -Widget.height / 2, Widget.height / 2)
	Widget:setAlpha(0)
	Widget:registerAnimationState("fade_in", {
		alpha = 1
	})
	Widget:registerAnimationState("fade_out", {
		alpha = 0
	})
	Widget:addElement(LUI.UITimer.new(2000, "fade_in", true, Widget))
	Widget:registerEventHandler("fade_in", function (f7_arg0, f7_arg1)
		f7_arg0:animateToState("fade_in", 500)
		local f7_local0 = LUI.UITimer.new(50, "twinkle", false, Widget)
		f7_arg0.resultText.timer = 0
		f7_arg0.twinkleTimer = f7_local0
		f7_arg0:addElement(f7_local0)
	end)
	local f6_local4 = f0_local8()
	Widget.blackout = f6_local4
	Widget:addElement(f6_local4)
	f6_local4:registerAnimationState("fade_in", {
		alpha = 0.5
	})
	f6_local4:animateToState("fade_in", 2000)
	local f6_local5 = LUI.UIImage.new()
	f6_local5:setLeftRight(true, true, 0, 0)
	f6_local5:setTopBottom(true, true, 0, 0)
	f6_local5:setRGB(f0_local0.r, f0_local0.g, f0_local0.b)
	f6_local5:setAlpha(f0_local1)
	Widget.background = f6_local5
	Widget:addElement(f6_local5)
	f0_local6(Widget, 2, 12)
	f0_local6(Widget, 6, 12)
	f0_local6(Widget, 10, 12)
	AddVerticalLine(Widget, 1, 22)
	AddVerticalLine(Widget, 5, 22)
	AddVerticalLine(Widget, 9, 22)
	AddVerticalLine(Widget, 13, 22)
	AddVerticalLine(Widget, 17, 22)
	AddVerticalLine(Widget, 21, 22)
	local f6_local6 = Result(f6_arg0)
	Widget.resultText = f6_local6
	Widget:addElement(f6_local6)
	Widget:registerEventHandler("twinkle", function (f8_arg0, f8_arg1)
		if f8_arg0.resultText ~= nil then
			f8_arg0.resultText.timer = f8_arg0.resultText.timer + 50
			if f8_arg0.resultText.timer < 100 then
				return 
			elseif f8_arg0.resultText.timer % 100 == 0 then
				Widget.resultText:animateToState("fade_in", 23)
			else
				Widget.resultText:animateToState("fade_out", 47)
			end
			if f8_arg0.resultText.timer > 300 then
				Widget.resultText:animateToState("fade_in", 40)
				Widget.twinkleTimer:close()
			end
		end
	end)
	Widget:addElement(f0_local7(Widget.width, Widget.height))
	Widget:addElement(Widget)
	return Widget
end

