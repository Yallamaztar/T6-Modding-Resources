CoD.Bracket = {}
CoD.Bracket.Width = 16
CoD.Bracket.AnimationOffset = 16
local f0_local0, f0_local1, f0_local2 = nil
f0_local0 = function (f1_arg0)
	local f1_local0 = {}
	for f1_local4, f1_local5 in pairs(LUI.UIElement.m_defaultAnimationState) do
		f1_local0[f1_local4] = f1_local5
	end
	f1_local0.topAnchor = true
	f1_local0.bottomAnchor = true
	if f1_arg0 ~= nil then
		for f1_local4, f1_local5 in pairs(f1_arg0) do
			f1_local0[f1_local4] = f1_local5
		end
	end
	return f1_local0
end

f0_local2 = function (f2_arg0)
	f2_arg0:animateToState("offset", 250)
	f2_arg0:animateToState("default", 350)
end

CoD.Bracket.CreateLeftBracket = function (f3_arg0)
	local f3_local0 = f0_local0(f3_arg0)
	local f3_local1 = CoD.Bracket.Width
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(f3_local0.leftAnchor, false, f3_local0.left - f3_local1 / 2, f3_local0.left + f3_local1 / 2)
	Widget:setTopBottom(f3_local0.topAnchor, f3_local0.bottomAnchor, f3_local0.top, f3_local0.bottom)
	Widget:registerAnimationState("default", {
		leftAnchor = f3_local0.leftAnchor,
		rightAnchor = false,
		left = f3_local0.left - f3_local1 / 2,
		right = f3_local0.left + f3_local1 / 2
	})
	Widget:registerAnimationState("offset", {
		leftAnchor = f3_local0.leftAnchor,
		rightAnchor = false,
		left = f3_local0.left - f3_local1 / 2 - CoD.Bracket.AnimationOffset,
		right = f3_local0.left + f3_local1 / 2 - CoD.Bracket.AnimationOffset
	})
	local f3_local3 = LUI.UIImage.new()
	f3_local3:setLeftRight(true, false, 0, f3_local1)
	f3_local3:setTopBottom(true, false, 0, f3_local1)
	f3_local3:setImage(RegisterMaterial("menu_sp_bracket_end_lhs"))
	f3_local3:setRGB(f3_local0.red, f3_local0.green, f3_local0.blue)
	f3_local3:setAlpha(f3_local0.alpha)
	Widget:addElement(f3_local3)
	local f3_local4 = LUI.UIImage.new()
	f3_local4:setLeftRight(true, false, 0, f3_local1)
	f3_local4:setTopBottom(false, true, -f3_local1, 0)
	f3_local4:setImage(RegisterMaterial("menu_sp_bracket_end_rhs"))
	f3_local4:setRGB(f3_local0.red, f3_local0.green, f3_local0.blue)
	f3_local4:setZRot(180)
	f3_local4:setAlpha(f3_local0.alpha)
	Widget:addElement(f3_local4)
	local f3_local5 = LUI.UIImage.new()
	f3_local5:setLeftRight(true, false, 0, 1)
	f3_local5:setTopBottom(true, true, f3_local1 - 4, -f3_local1 + 4)
	f3_local5:setRGB(f3_local0.red, f3_local0.green, f3_local0.blue)
	f3_local5:setAlpha(f3_local0.alpha)
	Widget:addElement(f3_local5)
	Widget.animateBracket = f0_local2
	return Widget
end

CoD.Bracket.CreateRightBracket = function (f4_arg0)
	local f4_local0 = f0_local0(f4_arg0)
	local f4_local1 = CoD.Bracket.Width
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, f4_local0.rightAnchor, f4_local0.right - f4_local1 / 2, f4_local0.right + f4_local1 / 2)
	Widget:setTopBottom(f4_local0.topAnchor, f4_local0.bottomAnchor, f4_local0.top, f4_local0.bottom)
	Widget:registerAnimationState("default", {
		leftAnchor = false,
		rightAnchor = f4_local0.rightAnchor,
		left = f4_local0.right - f4_local1 / 2,
		right = f4_local0.right + f4_local1 / 2
	})
	Widget:registerAnimationState("offset", {
		leftAnchor = false,
		rightAnchor = f4_local0.rightAnchor,
		left = f4_local0.right - f4_local1 / 2 + CoD.Bracket.AnimationOffset,
		right = f4_local0.right + f4_local1 / 2 + CoD.Bracket.AnimationOffset
	})
	local f4_local3 = LUI.UIImage.new()
	f4_local3:setLeftRight(true, false, 0, f4_local1)
	f4_local3:setTopBottom(true, false, 0, f4_local1)
	f4_local3:setImage(RegisterMaterial("menu_sp_bracket_end_rhs"))
	f4_local3:setRGB(f4_local0.red, f4_local0.green, f4_local0.blue)
	f4_local3:setAlpha(1)
	Widget:addElement(f4_local3)
	local f4_local4 = LUI.UIImage.new()
	f4_local4:setLeftRight(true, false, 0, f4_local1)
	f4_local4:setTopBottom(false, true, -f4_local1, 0)
	f4_local4:setImage(RegisterMaterial("menu_sp_bracket_end_lhs"))
	f4_local4:setRGB(f4_local0.red, f4_local0.green, f4_local0.blue)
	f4_local4:setZRot(180)
	f4_local4:setAlpha(f4_local0.alpha)
	Widget:addElement(f4_local4)
	local f4_local5 = LUI.UIImage.new()
	f4_local5:setLeftRight(false, true, -1, 0)
	f4_local5:setTopBottom(true, true, f4_local1 - 4, -f4_local1 + 4)
	f4_local5:setRGB(f4_local0.red, f4_local0.green, f4_local0.blue)
	f4_local5:setAlpha(1)
	Widget:addElement(f4_local5)
	Widget.animateBracket = f0_local2
	return Widget
end

