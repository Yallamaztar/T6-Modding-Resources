CoD.ButtonGrid = {}
CoD.ButtonGrid.Spacing = 12
CoD.ButtonGrid.ItemSize = 65
CoD.ButtonGrid.UnselectedAlpha = 0.15
CoD.ButtonGrid.AppearTime = 50
CoD.ButtonGrid.FadeInTime = 200
CoD.ButtonGrid.DisappearTime = 50
CoD.ButtonGrid.FadeOutTime = 200
local f0_local0 = nil
CoD.ButtonGrid.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	if CoD.ButtonGrid.HighlightMaterial == nil then
		CoD.ButtonGrid.HighlightMaterial = RegisterMaterial("menu_select_highlight")
	end
	local Widget = LUI.UIElement.new(f1_arg1)
	if f1_arg4 == nil then
		f1_arg4 = CoD.ButtonGrid.Spacing
	end
	if f1_arg2 == nil then
		f1_arg2 = CoD.ButtonGrid.ItemSize
	end
	if f1_arg3 == nil then
		f1_arg3 = CoD.ButtonGrid.ItemSize
	end
	Widget.numItemsWide = f1_arg0
	Widget.spacing = f1_arg4
	Widget.itemWidth = f1_arg2
	Widget.itemHeight = f1_arg3
	Widget.buttons = {}
	Widget.animateIn = CoD.ButtonGrid.AnimateIn
	Widget.animateOut = CoD.ButtonGrid.AnimateOut
	Widget.addButton = CoD.ButtonGrid.AddButton
	Widget:registerEventHandler("animate_in_next", CoD.ButtonGrid.AnimateInNext)
	Widget:registerEventHandler("animate_out_next", CoD.ButtonGrid.AnimateOutNext)
	return Widget
end

CoD.ButtonGrid.AnimateIn = function (f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = f2_arg0.animateOutTimer
	if f2_local0 ~= nil then
		f2_local0:close()
		f2_arg0.animateOutTimer = nil
	end
	f2_arg0.m_inputDisabled = nil
	for f2_local4, f2_local5 in pairs(f2_arg0.buttons) do
		f2_local5.flash:animateToState("default")
	end
	if f2_arg1 == nil then
		f2_arg1 = 0
	end
	if f2_arg2 == nil then
		f2_arg2 = 0
	end
	f2_arg0.transitionX = f2_arg1
	f2_arg0.transitionY = f2_arg2
	f2_arg0.currentButtonNumber = 0
	f2_arg0.numItemsTransitioned = 0
	f2_local1 = LUI.UITimer.new(CoD.ButtonGrid.AppearTime, "animate_in_next", nil, f2_arg0)
	f2_arg0.animateInTimer = f2_local1
	f2_arg0:addElement(f2_local1)
	CoD.ButtonGrid.AnimateInNext(f2_arg0)
	Engine.PlaySound("uin_navigation_wpn_alt")
end

CoD.ButtonGrid.AnimateOut = function (f3_arg0)
	local f3_local0 = f3_arg0.animateInTimer
	if f3_local0 ~= nil then
		f3_local0:close()
		f3_arg0.animateInTimer = nil
	end
	f3_arg0.m_inputDisabled = true
	local f3_local1 = 0
	for f3_local5, f3_local6 in pairs(f3_arg0.buttons) do
		if f3_local6:isInFocus() then
			f3_local1 = f3_local5 - 1
			break
		end
	end
	f3_local2 = f3_arg0.numItemsWide
	f3_local3 = f3_local1 % f3_local2
	f3_local4 = (f3_local1 - f3_local3) / f3_local2
	f3_arg0.transitionX = f3_local3
	f3_arg0.transitionY = f3_local4
	f3_arg0.currentButtonNumber = 0
	f3_arg0.numItemsTransitioned = 0
	f3_local5 = LUI.UITimer.new(CoD.ButtonGrid.DisappearTime, "animate_out_next", nil, f3_arg0)
	f3_arg0.animateOutTimer = f3_local5
	f3_arg0:addElement(f3_local5)
	CoD.ButtonGrid.AnimateOutNext(f3_arg0)
	return f3_local3, f3_local4
end

CoD.ButtonGrid.AnimateInNext = function (f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0.currentButtonNumber
	if f4_arg0.numItemsTransitioned == #f4_arg0.buttons then
		f4_arg0.animateInTimer:close()
		return 
	end
	local f4_local1 = f4_arg0.numItemsWide
	local f4_local2 = f4_arg0.transitionX
	local f4_local3 = f4_arg0.transitionY
	for f4_local9, f4_local10 in pairs(f4_arg0.buttons) do
		local f4_local11 = f4_local9 - 1
		local f4_local12 = f4_local11 % f4_local1
		if math.abs(f4_local12 - f4_local2) + math.abs((f4_local11 - f4_local12) / f4_local1 - f4_local3) == f4_local0 then
			local f4_local7 = f4_local10.flash
			f4_local10:animateToState("fade_in")
			f4_local7:animateToState("fade_in")
			f4_local7:animateToState("default", CoD.ButtonGrid.FadeInTime)
			local f4_local8 = f4_local8 + 1
		end
	end
	f4_arg0.currentButtonNumber = f4_local0 + 1
	f4_arg0.numItemsTransitioned = f4_local8
end

CoD.ButtonGrid.AnimateOutNext = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.currentButtonNumber
	if f5_local0 == nil then
		f5_arg0.animateOutTimer:close()
		f5_arg0.m_inputDisabled = nil
		f5_arg0:close()
		return 
	elseif f5_arg0.numItemsTransitioned == #f5_arg0.buttons then
		local f5_local1 = f5_arg0.animateOutTimer
		f5_local1.interval = CoD.ButtonGrid.FadeOutTime
		f5_local1:reset()
		f5_arg0.currentButtonNumber = nil
		return 
	end
	local f5_local1 = f5_arg0.numItemsWide
	local f5_local2 = f5_arg0.transitionX
	local f5_local3 = f5_arg0.transitionY
	for f5_local9, f5_local10 in pairs(f5_arg0.buttons) do
		local f5_local11 = f5_local9 - 1
		local f5_local12 = f5_local11 % f5_local1
		if math.abs(f5_local12 - f5_local2) + math.abs((f5_local11 - f5_local12) / f5_local1 - f5_local3) == f5_local0 then
			local f5_local7 = f5_local10.flash
			f5_local7:animateToState("fade_in")
			f5_local7:animateToState("default", CoD.ButtonGrid.FadeOutTime)
			f5_local10:animateToState("fade_out")
			local f5_local8 = f5_local8 + 1
		end
	end
	f5_arg0.currentButtonNumber = f5_local0 + 1
	f5_arg0.numItemsTransitioned = f5_local8
end

CoD.ButtonGrid.AddButton = function (f6_arg0)
	local f6_local0 = f6_arg0.numItemsWide
	local f6_local1 = #f6_arg0.buttons
	local f6_local2 = f6_local1 % f6_local0
	local f6_local3 = (f6_local1 - f6_local2) / f6_local0
	local f6_local4 = f6_arg0.itemWidth
	local f6_local5 = f6_arg0.itemHeight
	local f6_local6 = f6_arg0.spacing
	local f6_local7 = f6_local2 * (f6_local4 + f6_local6)
	local f6_local8 = f6_local3 * (f6_local5 + f6_local6)
	local f6_local9 = CoD.BracketButton.new({
		left = f6_local7,
		top = f6_local8,
		right = f6_local7 + f6_local4,
		bottom = f6_local8 + f6_local5,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	f6_local9:registerAnimationState("fade_out", {
		alphaMultiplier = 0
	})
	f6_local9:registerAnimationState("fade_in", {
		alphaMultiplier = 1
	})
	f6_local9:animateToState("fade_out")
	if f6_local2 > 0 then
		f0_local0(f6_arg0, f6_local9, f6_local1, "left", "right")
	end
	f0_local0(f6_arg0, f6_local9, f6_local1 - f6_local2 + 1, "right", "left")
	f0_local0(f6_arg0, f6_local9, f6_local1 - f6_local0 + 1, "up", "down")
	f0_local0(f6_arg0, f6_local9, f6_local2 + 1, "down", "up")
	f6_local9:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = 0,
		green = 0,
		blue = 0,
		alpha = CoD.slotContainerAlpha
	}))
	local f6_local10 = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = 0,
		material = CoD.ButtonGrid.HighlightMaterial
	})
	f6_local9:addElement(f6_local10)
	f6_local10:registerAnimationState("selected", {
		alpha = 1
	})
	f6_local9.background = f6_local10
	
	local flash = LUI.UIImage.new({
		left = f6_local7,
		top = f6_local8,
		right = f6_local7 + f6_local4,
		bottom = f6_local8 + f6_local5,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 0
	})
	flash:setPriority(50)
	flash:registerAnimationState("fade_in", {
		alpha = 0.5
	})
	f6_arg0:addElement(flash)
	f6_local9.flash = flash
	
	table.insert(f6_arg0.buttons, f6_local9)
	f6_arg0:addElement(f6_local9)
	return f6_local9
end

f0_local0 = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)
	local f7_local0 = f7_arg0.buttons[f7_arg2]
	if f7_local0 ~= nil and f7_local0 ~= f7_arg1 then
		f7_arg1.navigation[f7_arg3] = f7_local0
		f7_local0.navigation[f7_arg4] = f7_arg1
	end
end

