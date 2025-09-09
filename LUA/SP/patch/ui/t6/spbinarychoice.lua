require("T6.Menus.Bracket")
CoD.SPBinaryChoice = {}
CoD.SPBinaryChoice.Width = 450
CoD.SPBinaryChoice.Height = 350
CoD.SPBinaryChoice.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5)
	local f1_local0 = CoD.SPBinaryChoice.Width
	local f1_local1 = CoD.SPBinaryChoice.Height
	local Widget = LUI.UIElement.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f1_local0 / 2,
		right = f1_local0 / 2,
		topAnchor = false,
		bottomAnchor = false,
		top = -f1_local1 / 2,
		bottom = f1_local1 / 2
	})
	local f1_local3 = f1_local1
	local f1_local4 = 0.12
	local f1_local5 = RegisterMaterial("menu_visor_mid_bracket")
	local f1_local6 = CoD.Bracket.CreateLeftBracket({
		leftAnchor = true
	})
	f1_local6:animateBracket()
	Widget:addElement(f1_local6)
	local f1_local7 = CoD.Bracket.CreateRightBracket({
		rightAnchor = true
	})
	f1_local7:animateBracket()
	Widget:addElement(f1_local7)
	local f1_local8 = "Default"
	local f1_local9 = 20
	local f1_local10 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local9,
		bottom = f1_local9 + CoD.textSize[f1_local8],
		font = CoD.fonts[f1_local8],
		alignment = LUI.Alignment.Center
	})
	f1_local10:setText(f1_arg0)
	Widget:addElement(f1_local10)
	local f1_local11 = f1_local9 + CoD.textSize[f1_local8] + 20
	local f1_local12 = LUI.UIText.new({
		leftAnchor = true,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = false,
		top = f1_local11,
		bottom = f1_local11 + CoD.textSize[f1_local8],
		font = CoD.fonts[f1_local8],
		alignment = LUI.Alignment.Left
	})
	f1_local12:setText(f1_arg1)
	Widget:addElement(f1_local12)
	local f1_local13 = 120
	local f1_local14 = 100
	local f1_local15 = 40
	local f1_local16 = LUI.UIVerticalList.new({
		leftAnchor = false,
		rightAnchor = false,
		left = -f1_local13 / 2,
		right = f1_local13 / 2,
		topAnchor = false,
		bottomAnchor = true,
		top = -f1_local14 - f1_local15,
		bottom = -f1_local15
	})
	f1_local16:makeFocusable()
	Widget:addElement(f1_local16)
	local f1_local17 = CoD.GetDefaultAnimationState()
	f1_local17.bottomAnchor = false
	f1_local17.bottom = 50
	local f1_local18 = CoD.NavButton.new(f1_local17, f1_arg2, f1_arg3)
	f1_local16:addElement(f1_local18)
	if f1_arg4 ~= nil then
		f1_local16:addElement(CoD.NavButton.new(f1_local17, f1_arg4, f1_arg5))
	end
	f1_local18:processEvent({
		name = "gain_focus"
	})
	return Widget
end

