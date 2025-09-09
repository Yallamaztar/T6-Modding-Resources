CoD.WiiUSystemServices = {}
local f0_local0 = function (f1_arg0, f1_arg1)
	f1_arg0:goBack(f1_arg1.controller)
end

local f0_local1 = function (f2_arg0, f2_arg1)
	f2_arg0.typedText:setText(f2_arg1)
end

local f0_local2 = function (f3_arg0, f3_arg1)
	local f3_local0, f3_local1, f3_local2, f3_local3 = GetTextDimensions(f3_arg1, CoD.fonts.Default, CoD.textSize.Default)
	f3_arg0.currenText = f3_arg1
	local f3_local4 = 125
	if f3_local2 - f3_local0 < 400 then
		local f3_local5 = f3_local2 - f3_local0
		f3_arg0.typedText:setLeftRight(false, false, -f3_local5 / 2 - 10, f3_local5 / 2 + 10)
		f3_arg0.typedText:setTopBottom(true, false, f3_local4, f3_local4 + CoD.textSize.Default)
		f3_arg0.typedText:setAlignment(LUI.Alignment.Left)
	else
		f3_arg0.typedText:setLeftRight(true, true, 10, -10)
		f3_arg0.typedText:setTopBottom(true, false, f3_local4, f3_local4 + CoD.textSize.Default)
		f3_arg0.typedText:setAlignment(LUI.Alignment.Left)
	end
	if f3_arg0.blinkOn ~= nil then
		f3_arg1 = f3_arg1 .. "|"
	end
	f3_arg0.typedText:setText(f3_arg1)
end

local f0_local3 = function (f4_arg0, f4_arg1)
	f0_local2(f4_arg0, f4_arg1.text)
end

local f0_local4 = function (f5_arg0, f5_arg1)
	if f5_arg0.blinkOn == nil then
		f5_arg0.blinkOn = true
		f5_arg0.typedText:setText(f5_arg0.currenText .. "|")
	else
		f5_arg0.blinkOn = nil
		f5_arg0.typedText:setText(f5_arg0.currenText)
	end
end

LUI.createMenu.UseDRCKeyboardPopup = function (f6_arg0)
	local f6_local0 = CoD.Menu.NewSmallPopup("UseDRCKeyboardPopup")
	f6_local0:setOwner(f6_arg0)
	local f6_local1 = UIExpression.DvarString(nil, "ui_keyboardtitle")
	local f6_local2 = 80
	f6_local0.headerText = Engine.Localize(f6_local1)
	f6_local0.messageText = LUI.UIText.new()
	f6_local0.messageText:setLeftRight(true, true, 0, 0)
	f6_local0.messageText:setTopBottom(true, false, f6_local2, f6_local2 + CoD.textSize.Default)
	f6_local0.messageText:setFont(CoD.fonts.Default)
	f6_local0.messageText:setAlignment(LUI.Alignment.Center)
	f6_local0.messageText:setText(f6_local0.headerText)
	f6_local0:addElement(f6_local0.messageText)
	f6_local0.typedText = LUI.UIText.new()
	f6_local0.typedText:setFont(CoD.fonts.Default)
	f0_local2(f6_local0, "")
	f6_local0:addElement(f6_local0.typedText)
	local f6_local3 = 128
	local f6_local4 = 128
	local f6_local5 = -22
	local f6_local6 = LUI.UIImage.new({
		red = CoD.offWhite.r,
		green = CoD.offWhite.g,
		blue = CoD.offWhite.b,
		alpha = 1,
		material = RegisterMaterial("wiiu_controllerselect_drc")
	})
	f6_local6:setLeftRight(false, false, -f6_local3 / 2, f6_local3 / 2)
	f6_local6:setTopBottom(true, false, f6_local5, f6_local5 + f6_local4)
	f6_local0:addElement(f6_local6)
	f6_local0.cursor = "|"
	f6_local0:addElement(LUI.UITimer.new(900, {
		name = "blink_cursor"
	}, false, keyboardMenu))
	f6_local0:registerEventHandler("wiiu_keyboard_closing", f0_local0)
	f6_local0:registerEventHandler("wiiu_keyboard_text", f0_local3)
	f6_local0:registerEventHandler("blink_cursor", f0_local4)
	return f6_local0
end

