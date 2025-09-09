require("T6.KeyboardButton")
require("T6.CodMenu")
CoD.Keyboard = {}
local f0_local0 = CoD.Keyboard
local f0_local1 = {}
local f0_local2 = {}
local f0_local3 = {}
local f0_local4 = "q"
local f0_local5 = "Q"
local f0_local6 = "1"
local f0_local7 = "["
f0_local3.up = " "
f0_local3.down = "a"
f0_local3[1] = f0_local4
f0_local3[2] = f0_local5
f0_local3[3] = f0_local6
f0_local3[4] = f0_local7
f0_local4 = {
	"w",
	"W",
	"2",
	"]"
}
f0_local5 = {
	"e",
	"E",
	"3",
	"{"
}
f0_local6 = {
	"r",
	"R",
	"4",
	"}"
}
f0_local7 = {
	"t",
	"T",
	"5",
	"#"
}
local f0_local8 = {}
local f0_local9 = "y"
local f0_local10 = "Y"
local f0_local11 = "6"
local f0_local12 = "%"
f0_local8.down = "g"
f0_local8[1] = f0_local9
f0_local8[2] = f0_local10
f0_local8[3] = f0_local11
f0_local8[4] = f0_local12
f0_local9 = {
	"u",
	"U",
	"7",
	"^"
}
f0_local10 = {
	"i",
	"I",
	"8",
	"*"
}
f0_local11 = {
	"o",
	"O",
	"9",
	"+"
}
f0_local12 = {
	"p",
	"P",
	"0",
	"="
}
f0_local2[1] = f0_local3
f0_local2[2] = f0_local4
f0_local2[3] = f0_local5
f0_local2[4] = f0_local6
f0_local2[5] = f0_local7
f0_local2[6] = f0_local8
f0_local2[7] = f0_local9
f0_local2[8] = f0_local10
f0_local2[9] = f0_local11
f0_local2[10] = f0_local12
f0_local3 = {}
f0_local4 = {}
f0_local5 = "a"
f0_local6 = "A"
f0_local7 = "-"
f0_local8 = "_"
f0_local4.up = "q"
f0_local4.down = "z"
f0_local4.spacer = {
	tv = 38,
	drc = 60
}
f0_local4[1] = f0_local5
f0_local4[2] = f0_local6
f0_local4[3] = f0_local7
f0_local4[4] = f0_local8
f0_local5 = {
	"s",
	"S",
	"/",
	"\"
}
f0_local6 = {
	"d",
	"D",
	":",
	"|"
}
f0_local7 = {
	"f",
	"F",
	";",
	"~"
}
f0_local8 = {
	"g",
	"G",
	"(",
	"<"
}
f0_local9 = {}
f0_local10 = "h"
f0_local11 = "H"
f0_local12 = ")"
local f0_local13 = ">"
f0_local9.down = "b"
f0_local9.up = "u"
f0_local9[1] = f0_local10
f0_local9[2] = f0_local11
f0_local9[3] = f0_local12
f0_local9[4] = f0_local13
f0_local10 = {
	"j",
	"J",
	"$",
	")",
	"INV"
}
f0_local11 = {
	"k",
	"K",
	"&",
	"INV"
}
f0_local12 = {
	"l",
	"L",
	"@",
	"INV"
}
f0_local3[1] = f0_local4
f0_local3[2] = f0_local5
f0_local3[3] = f0_local6
f0_local3[4] = f0_local7
f0_local3[5] = f0_local8
f0_local3[6] = f0_local9
f0_local3[7] = f0_local10
f0_local3[8] = f0_local11
f0_local3[9] = f0_local12
f0_local4 = {}
f0_local5 = {}
f0_local6 = "ABC"
f0_local7 = "abc"
f0_local8 = "#+="
f0_local9 = "123"
f0_local5.width = {
	drc = 5,
	tv = 15
}
f0_local5.down = " "
f0_local5.up = "a"
f0_local5.action = "shift"
f0_local5[1] = f0_local6
f0_local5[2] = f0_local7
f0_local5[3] = f0_local8
f0_local5[4] = f0_local9
f0_local6 = {
	"z",
	"Z",
	".",
	"."
}
f0_local7 = {
	"x",
	"X",
	",",
	","
}
f0_local8 = {
	"c",
	"C",
	"?",
	"?"
}
f0_local9 = {
	"v",
	"V",
	"!",
	"!"
}
f0_local10 = {
	"b",
	"B",
	""",
	"""
}
f0_local11 = {}
f0_local12 = "n"
f0_local13 = "N"
local f0_local14 = "'"
local f0_local15 = "'"
f0_local11.up = "j"
f0_local11[1] = f0_local12
f0_local11[2] = f0_local13
f0_local11[3] = f0_local14
f0_local11[4] = f0_local15
f0_local12 = {
	"m",
	"M",
	"_",
	"_"
}
f0_local13 = {}
f0_local14 = "Back"
f0_local13.down = "space"
f0_local13.action = "delete"
f0_local13.width = {
	tv = 20,
	drc = 20
}
f0_local13[1] = f0_local14
f0_local4[1] = f0_local5
f0_local4[2] = f0_local6
f0_local4[3] = f0_local7
f0_local4[4] = f0_local8
f0_local4[5] = f0_local9
f0_local4[6] = f0_local10
f0_local4[7] = f0_local11
f0_local4[8] = f0_local12
f0_local4[9] = f0_local13
f0_local5 = {}
f0_local6 = {}
f0_local7 = "123"
f0_local8 = "Abc"
f0_local6.width = {
	tv = 27,
	drc = 27
}
f0_local6.up = "ABC"
f0_local6.down = "q"
f0_local6.spacer = {
	tv = 45,
	drc = 60
}
f0_local6.action = "123"
f0_local6[1] = f0_local7
f0_local6[2] = f0_local8
f0_local7 = {}
f0_local8 = " "
f0_local7.width = {
	drc = 700,
	tv = 400
}
f0_local7.up = "b"
f0_local7.down = "6"
f0_local7.value = " "
f0_local7[1] = f0_local8
f0_local8 = {}
f0_local9 = "Enter"
f0_local8.up = "Back"
f0_local8.down = "p"
f0_local8.width = {
	tv = 47,
	drc = 47
}
f0_local8.action = "enter"
f0_local8[1] = f0_local9
f0_local5[1] = f0_local6
f0_local5[2] = f0_local7
f0_local5[3] = f0_local8
f0_local1[1] = f0_local2
f0_local1[2] = f0_local3
f0_local1[3] = f0_local4
f0_local1[4] = f0_local5
f0_local0.Qwerty = f0_local1
CoD.Keyboard.Layouts = {
	qwerty = CoD.Keyboard.Qwerty
}
CoD.Keyboard.ActiveLayout = "qwerty"
CoD.Keyboard.ButtonSize = {
	drc = {
		width = 120,
		height = 110,
		textHeight = 2.5 * CoD.textSize.Condensed
	},
	tv = {
		width = 77,
		height = 70,
		textHeight = 1.5 * CoD.textSize.Condensed
	}
}
CoD.Keyboard.BlinkCursor = function (f1_arg0, f1_arg1)
	if f1_arg0.cursor == "|" then
		f1_arg0.cursor = " "
	else
		f1_arg0.cursor = "|"
	end
	f1_arg0.textDisplay:setText(f1_arg0.text .. f1_arg0.cursor)
end

CoD.Keyboard.Back = function (f2_arg0, f2_arg1)
	f2_arg0:goBack(f2_arg1.controller)
end

CoD.Keyboard.ToggleNumbersAndSymbols = function (f3_arg0, f3_arg1)
	local f3_local0 = f3_arg0.numberKey
	local f3_local1 = f3_arg0.shiftKey
	local f3_local2 = (1 + f3_local0.showIndex) % 2
	f3_local0:indexLabel(f3_local2)
	local f3_local3 = nil
	if f3_local2 == 1 then
		f3_local3 = 2
		f3_local1:indexLabel(2)
	else
		f3_local3 = 0
		f3_local1:indexLabel(0)
	end
	for f3_local7, f3_local8 in ipairs(f3_arg0.keys) do
		f3_local8:indexLabel(f3_local3)
	end
end

CoD.Keyboard.ShiftKeyPressed = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.shiftKey
	if f4_local0.showIndex == 2 then
		f4_local0:indexLabel(3)
		for f4_local4, f4_local5 in ipairs(f4_arg0.keys) do
			f4_local5:indexLabel(3)
		end
	elseif f4_local0.showIndex == 3 then
		f4_local0:indexLabel(2)
		for f4_local4, f4_local5 in ipairs(f4_arg0.keys) do
			f4_local5:indexLabel(2)
		end
	else
		f4_local0:indexLabel((1 + f4_local0.showIndex) % 2)
		for f4_local4, f4_local5 in ipairs(f4_arg0.keys) do
			f4_local5:indexLabel((1 + f4_local5.showIndex) % 2)
		end
	end
end

CoD.Keyboard.DeleteKeyPressed = function (f5_arg0, f5_arg1)
	f5_arg0.text = string.sub(f5_arg0.text, 1, -2)
	f5_arg0.textDisplay:setText(f5_arg0.text .. f5_arg0.cursor)
	f5_arg1.button.background:animateToState("pressed", 0)
end

CoD.Keyboard.GenericKeyPressed = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg1.button
	local f6_local1 = f6_local0.def[1 + f6_local0.showIndex]
	if f6_local1 == nil then
		f6_local1 = f6_local0.def[1]
	end
	local f6_local2 = nil
	if f6_local1 == " " then
		f6_local2 = " "
	else
		f6_local2 = f6_local1
	end
	local f6_local3 = f6_arg0.text .. f6_local2
	f6_arg0.text = f6_local3
	f6_arg0.textDisplay:setText(f6_local3 .. f6_arg0.cursor)
	f6_local0.background:animateToState("pressed", 0)
end

CoD.Keyboard.EnterKeyPressed = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg0.finishedEvent
	if f7_local0 ~= nil then
		if f7_local0.dvar ~= nil then
			Engine.SetDvar(f7_local0.dvar, f7_arg0.text)
		end
		f7_local0.recipient:processEvent({
			name = f7_local0.name,
			input = f7_arg0.text
		})
	end
	f7_arg1.button.background:animateToState("pressed", 0)
	print("CoD.Keyboard.EnterKeyPressed:  goBack")
	f7_arg0:goBack(f7_arg1.controller)
end

CoD.Keyboard.ShowOnDrc = function (f8_arg0)
	f8_arg0:setUI3DWindow(6)
end

CoD.Keyboard.ShowOnTv = function (f9_arg0)
	f9_arg0:addBackButton()
end

CoD.Keyboard.SetText = function (f10_arg0, f10_arg1)
	f10_arg0.text = f10_arg1
	f10_arg0.textDisplay:setText(f10_arg1 .. f10_arg0.cursor)
end

CoD.Keyboard.SetFinishedEvent = function (f11_arg0, f11_arg1)
	f11_arg0.finishedEvent = f11_arg1
end

CoD.Keyboard.Create = function (f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = CoD.Menu.Width
	local f12_local1 = CoD.Menu.Height
	local f12_local2 = CoD.Menu.NewFromState(f12_arg0, f12_arg1)
	f12_local2.showOnDrc = CoD.Keyboard.ShowOnDrc
	f12_local2.showOnTv = CoD.Keyboard.ShowOnTv
	f12_local2.setText = CoD.Keyboard.SetText
	f12_local2.setFinishedEvent = CoD.Keyboard.SetFinishedEvent
	f12_local2.blinkCursor = CoD.Keyboard.BlinkCursor
	f12_local2.cursor = "|"
	f12_local2:addElement(LUI.UITimer.new(900, {
		name = "blink_cursor"
	}, false, f12_local2))
	f12_local2:registerEventHandler("key_pressed", CoD.Keyboard.GenericKeyPressed)
	f12_local2:registerEventHandler("enter", CoD.Keyboard.EnterKeyPressed)
	f12_local2:registerEventHandler("delete", CoD.Keyboard.DeleteKeyPressed)
	f12_local2:registerEventHandler("shift", CoD.Keyboard.ShiftKeyPressed)
	f12_local2:registerEventHandler("123", CoD.Keyboard.ToggleNumbersAndSymbols)
	f12_local2:registerEventHandler("blink_cursor", CoD.Keyboard.BlinkCursor)
	f12_local2.width = f12_local0
	f12_local2.height = f12_local1
	f12_local2:makeFocusable()
	local f12_local3 = {}
	f12_local2.keys = f12_local3
	f12_local2.genericKeyPressed = CoD.Keyboard.GenericKeyPressed
	f12_local2.deleteKeyPressed = CoD.Keyboard.DeleteKeyPressed
	f12_local2.text = ""
	f12_local2:registerEventHandler("button_prompt_back", CoD.Keyboard.Back)
	f12_local2:addElement(LUI.UIButtonRepeater.new("up", {
		name = "gamepad_button",
		button = "up",
		down = true
	}))
	f12_local2:addElement(LUI.UIButtonRepeater.new("down", {
		name = "gamepad_button",
		button = "down",
		down = true
	}))
	f12_local2:addElement(LUI.UIButtonRepeater.new("right", {
		name = "gamepad_button",
		button = "right",
		down = true
	}))
	f12_local2:addElement(LUI.UIButtonRepeater.new("left", {
		name = "gamepad_button",
		button = "left",
		down = true
	}))
	local f12_local4 = {
		tv = 25,
		drc = -300
	}
	local f12_local5 = {
		drc = 100,
		tv = 50
	}
	f12_local2.textDisplay = LUI.UITightText.new({
		leftAnchor = true,
		rightAnchor = false,
		left = 100,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f12_local4[f12_arg2],
		bottom = f12_local4[f12_arg2] + f12_local5[f12_arg2],
		font = CoD.fonts.Condensed
	})
	f12_local2:addElement(f12_local2.textDisplay)
	local f12_local6 = LUI.UIVerticalList.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -20,
		bottom = 0
	})
	f12_local2:addElement(f12_local6)
	f12_local6:makeFocusable()
	local f12_local7 = true
	local f12_local8 = 0
	local f12_local9 = CoD.Keyboard.ButtonSize[f12_arg2]
	local f12_local10 = f12_local9.width
	local f12_local11 = f12_local9.height
	local f12_local12 = CoD.Keyboard.Layouts[CoD.Keyboard.ActiveLayout]
	for f12_local24, f12_local25 in pairs(f12_local12) do
		local f12_local26 = LUI.UIHorizontalList.new({
			left = CoD.CoD9Button.Height,
			top = CoD.CoD9Button.Height,
			right = 0,
			bottom = f12_local11 + 28,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = false,
			spacing = 1
		})
		f12_local6:addElement(f12_local26)
		f12_local26:makeFocusable()
		for f12_local19, f12_local20 in pairs(f12_local25) do
			local f12_local22 = {
				leftAnchor = false,
				rightAnchor = false,
				left = 0,
				right = f12_local10,
				topAnchor = true,
				bottomAnchor = false,
				top = 0,
				bottom = f12_local11
			}
			local f12_local23 = f12_local20.spacer
			if f12_local23 ~= nil then
				f12_local26:addSpacer(f12_local23[f12_arg2])
			end
			local f12_local16 = f12_local20.action
			if f12_local16 == nil then
				f12_local16 = "key_pressed"
			end
			local button = CoD.KeyboardButton.new(f12_local20, f12_local22, f12_local2, f12_local16, f12_arg2, f12_local9.textHeight)
			f12_local26:addElement(button)
			f12_local20.button = button
			
			if f12_local7 then
				f12_local7 = false
				button:processEvent({
					name = "gain_focus"
				})
			end
			local f12_local18 = f12_local20[1]
			if f12_local18 == "ABC" then
				f12_local2.shiftKey = button
			end
			if f12_local18 == "123" then
				f12_local2.numberKey = button
			end
			if f12_local16 == "key_pressed" then
				f12_local8 = f12_local8 + 1
				f12_local3[f12_local8] = button
			end
		end
	end
	f12_local13 = table.getn(f12_local12)
	for f12_local14 = 1, f12_local13, 1 do
		local f12_local26 = f12_local12[f12_local14]
		local f12_local27 = table.getn(f12_local26)
		local f12_local28 = f12_local12[1 + f12_local14 % f12_local13]
		local f12_local21 = f12_local12[1 + (f12_local14 + f12_local13 - 2) % f12_local13]
		local f12_local19, f12_local20 = nil
		for f12_local22 = 1, f12_local27, 1 do
			local f12_local18 = f12_local26[f12_local22]
			if f12_local18.up ~= nil then
				f12_local19 = 1
				while f12_local19 <= table.getn(f12_local21) do
					if f12_local21[f12_local19][1] == f12_local18.up then
						break
					end
					f12_local19 = f12_local19 + 1
				end
			else
				f12_local19 = f12_local19 + 1
			end
			if f12_local18.down ~= nil then
				f12_local20 = 1
				while f12_local20 <= table.getn(f12_local28) do
					if f12_local28[f12_local20][1] == f12_local18.down then
						break
					end
					f12_local20 = f12_local20 + 1
				end
			else
				f12_local20 = f12_local20 + 1
			end
			f12_local19 = math.min(table.getn(f12_local21), f12_local19)
			f12_local20 = math.min(table.getn(f12_local28), f12_local20)
			local f12_local29 = f12_local18.button.navigation
			f12_local29.up = f12_local21[f12_local19].button
			f12_local29.down = f12_local28[f12_local20].button
		end
	end
	return f12_local2
end

LUI.createMenu.KeyboardMenuDrc = function ()
	local f13_local0 = CoD.Menu.Width
	local f13_local1 = CoD.Menu.Height
	local f13_local2 = CoD.Keyboard.Create("KeyboardMenuDrc", {
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = false,
		bottomAnchor = false,
		top = -40,
		bottom = 0
	}, "drc")
	f13_local2:setPreviousMenu("MainMenu")
	f13_local2:setUI3DWindow(6)
	return f13_local2
end

LUI.createMenu.KeyboardMenuTv = function ()
	local f14_local0 = CoD.Menu.Width
	local f14_local1 = CoD.Menu.Height
	local f14_local2 = CoD.Keyboard.Create("KeyboardMenuTv", {
		leftAnchor = false,
		rightAnchor = false,
		left = -f14_local0 / 2,
		right = f14_local0 / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = -f14_local1 / 2,
		bottom = f14_local1 / 2
	}, "tv")
	f14_local2:addBackButton()
	return f14_local2
end

