CoD.AllocationBar = {}
CoD.AllocationBar.NumBars = 10
CoD.AllocationBar.BarSpacing = 5
CoD.AllocationBar.Height = 20
CoD.AllocationBar.BarHeight = 4
CoD.AllocationBar.HighlightTime = 400
CoD.AllocationBar.New = function (f1_arg0, f1_arg1, f1_arg2)
	local Widget = LUI.UIElement.new(f1_arg2)
	Widget.width = f1_arg1
	Widget.maxAllocation = Engine.GetMaxAllocation(f1_arg0)
	CoD.AllocationBar.AddBars(Widget)
	return Widget
end

CoD.AllocationSubtitle.CanAfford = function (f2_arg0, f2_arg1)
	if f2_arg0.remainingAllocation < f2_arg1 then
		return false
	else
		return true
	end
end

CoD.AllocationBar.AddBars = function (f3_arg0)
	local f3_local0 = f3_arg0.width
	local f3_local1 = f3_arg0.maxAllocation
	local f3_local2 = CoD.AllocationBar.BarSpacing
	local f3_local3 = f3_arg0.maxAllocation / f3_local1
	local f3_local4 = f3_local1 - 1
	local f3_local5 = CoD.AllocationBar.BarHeight
	local f3_local6 = (f3_local0 - (f3_local1 - 1) * f3_local2) / f3_local1
	for f3_local7 = 0, f3_local4, 1 do
		local f3_local10 = f3_local7 * (f3_local6 + f3_local2)
		local f3_local11 = f3_local3 * f3_local7
		local f3_local12 = CoD.AllocationBar.NewBar(f3_local6, f3_local11, f3_local11 + f3_local3)
		f3_local12:setLeftRight(true, false, f3_local10, f3_local10 + f3_local6)
		f3_local12:setTopBottom(false, false, -f3_local5, f3_local5)
		f3_arg0:addElement(f3_local12)
	end
end

CoD.AllocationBar.NewBar = function (f4_arg0, f4_arg1, f4_arg2)
	local Widget = LUI.UIElement.new()
	Widget.width = f4_arg0
	local f4_local1 = 0.35
	Widget.background = LUI.UIImage.new()
	Widget.background:setLeftRight(true, true, 0, 0)
	Widget.background:setTopBottom(true, true, 0, 0)
	Widget.background:setAlpha(f4_local1)
	Widget.background:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	Widget:addElement(Widget.background)
	Widget.fill = LUI.UIImage.new()
	Widget.fill:setLeftRight(true, true, 0, 0)
	Widget.fill:setTopBottom(true, true, 0, 0)
	Widget.fill:setRGB(CoD.BOIIOrange.r, CoD.BOIIOrange.g, CoD.BOIIOrange.b)
	Widget:addElement(Widget.fill)
	Widget.highlight = LUI.UIImage.new()
	Widget.highlight:setLeftRight(true, true, 1, -1)
	Widget.highlight:setTopBottom(true, true, 1, -6)
	Widget.highlight:setRGB(1, 1, 1)
	Widget.highlight:setAlpha(0.5)
	Widget:addElement(Widget.highlight)
	Widget.minAllocation = f4_arg1
	Widget.maxAllocation = f4_arg2
	Widget.allocationRange = Widget.maxAllocation - Widget.minAllocation
	Widget.calculateFillPercent = CoD.AllocationBar.CalculateFillPercent
	Widget:registerEventHandler("update_class", CoD.AllocationBar.AllocationChange)
	return Widget
end

CoD.AllocationBar.CalculateFillPercent = function (f5_arg0, f5_arg1)
	local f5_local0 = (f5_arg1 - f5_arg0.minAllocation) / f5_arg0.allocationRange
	if f5_local0 < 0 then
		f5_local0 = 0
	elseif f5_local0 > 1 then
		f5_local0 = 1
	end
	return f5_local0
end

CoD.AllocationBar.AllocationChange = function (f6_arg0, f6_arg1)
	local f6_local0 = f6_arg0:calculateFillPercent(f6_arg1.class.allocationSpent)
	local f6_local1 = f6_arg0.width * f6_local0
	local f6_local2 = f6_local0
	if CoD.previousAllocationAmount then
		f6_local2 = f6_arg0:calculateFillPercent(CoD.previousAllocationAmount)
	end
	f6_arg0.fill:registerAnimationState("hide", {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f6_local1,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 0
	})
	f6_arg0.highlight:registerAnimationState("hide", {
		leftAnchor = true,
		rightAnchor = false,
		left = 1,
		right = f6_local1 - 1,
		topAnchor = true,
		bottomAnchor = true,
		top = 1,
		bottom = -6,
		alpha = 0
	})
	f6_arg0.fill:registerAnimationState("allocation_change", {
		leftAnchor = true,
		rightAnchor = false,
		left = 0,
		right = f6_local1,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		alpha = 1
	})
	f6_arg0.highlight:registerAnimationState("allocation_change", {
		leftAnchor = true,
		rightAnchor = false,
		left = 1,
		right = f6_local1 - 1,
		topAnchor = true,
		bottomAnchor = true,
		top = 1,
		bottom = -5,
		alpha = 0.5
	})
	if f6_local2 ~= nil and f6_local2 < f6_local0 then
		f6_arg0.fill:animateToState("hide")
		f6_arg0.highlight:animateToState("hide")
		f6_arg0.fill:animateToState("allocation_change", CoD.AllocationBar.HighlightTime)
		f6_arg0.highlight:animateToState("allocation_change", CoD.AllocationBar.HighlightTime)
	else
		f6_arg0.fill:animateToState("allocation_change")
		f6_arg0.highlight:animateToState("allocation_change")
	end
end

