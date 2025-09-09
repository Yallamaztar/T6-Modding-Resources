CoD.AllocationSubtitle = {}
CoD.AllocationSubtitle.ArrowMaterial = RegisterMaterial("ui_arrow_right")
CoD.AllocationSubtitle.ChangeFadeTime = 500
CoD.AllocationSubtitle.MaxAllocation = CoD.MaxAllocation
CoD.AllocationSubtitle.NumBars = 10
CoD.AllocationSubtitle.BarSpacing = 3
CoD.AllocationSubtitle.Height = 50
CoD.AllocationSubtitle.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new(InstanceRef)
	Widget.width = HudRef
	local f1_local1 = LUI.UIText.new({
		left = 0,
		top = -CoD.textSize.Default,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		red = 0,
		green = 0,
		blue = 0
	})
	f1_local1:setText(Engine.Localize("MENU_COMBAT_LOAD_CAPS"))
	if CoD.isSinglePlayer == false then
		Widget:addElement(f1_local1)
	end
	if CoD.isSinglePlayer == false then
		CoD.AllocationSubtitle.AddBars(Widget)
	end
	local f1_local2 = LUI.UIText.new({
		left = 0,
		top = -CoD.textSize.Default,
		right = 0,
		bottom = 0,
		leftAnchor = false,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		red = 0,
		green = 0,
		blue = 0
	})
	Widget.remainingAllocationLabel = f1_local2
	if CoD.isSinglePlayer == false then
		Widget:addElement(f1_local2)
	end
	local f1_local3 = -250
	local f1_local4 = -500
	local f1_local5 = f1_local3 + CoD.textSize.Default
	Widget.xpBonusLabel = LUI.UIText.new({
		left = f1_local4,
		top = f1_local3,
		right = 0,
		bottom = f1_local5,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		font = CoD.fonts.Default
	})
	Widget.xpBonusLabel:registerAnimationState("hide", {
		alpha = 0
	})
	Widget.xpBonusLabel:registerAnimationState("show", {
		alpha = 1
	})
	Widget:addElement(Widget.xpBonusLabel)
	local f1_local6 = f1_local5
	Widget.xpBonusText = LUI.UIText.new({
		left = f1_local4,
		top = f1_local6,
		right = 0,
		bottom = f1_local6 + CoD.textSize.Big,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false,
		font = CoD.fonts.Big
	})
	Widget.xpBonusText:registerAnimationState("hide", {
		alpha = 0
	})
	Widget.xpBonusText:registerAnimationState("show", {
		alpha = 1
	})
	Widget:addElement(Widget.xpBonusText)
	Widget.setRemainingAllocation = CoD.AllocationSubtitle.SetRemainingAllocation
	Widget.setAllocationChange = CoD.AllocationSubtitle.SetAllocationChange
	Widget.commitChange = CoD.AllocationSubtitle.CommitChange
	Widget.canAfford = CoD.AllocationSubtitle.CanAfford
	if CoD.isSinglePlayer == false then
		Widget:setRemainingAllocation(CoD.AllocationSubtitle.MaxAllocation)
	end
	return Widget
end

CoD.AllocationSubtitle.SetRemainingAllocation = function (f2_arg0, f2_arg1, f2_arg2)
	if f2_arg0.remainingAllocation == nil then
		f2_arg0.remainingAllocation = f2_arg1
	end
	f2_arg0:processEvent({
		name = "allocation_change",
		before = CoD.AllocationSubtitle.MaxAllocation - f2_arg0.remainingAllocation,
		after = CoD.AllocationSubtitle.MaxAllocation - f2_arg1,
		duration = f2_arg2
	})
	f2_arg0.remainingAllocation = f2_arg1
	f2_arg0.remainingAllocationLabel:setText(CoD.AllocationSubtitle.MaxAllocation - f2_arg0.remainingAllocation .. "/" .. CoD.AllocationSubtitle.MaxAllocation)
	local f2_local0 = math.floor(f2_arg0.remainingAllocation / CoD.AllocationSubtitle.MaxAllocation * CoD.MaxAllocationBonus * 100)
	f2_arg0.xpBonusLabel:setText("Unallocated combat load XP bonus: ")
	f2_arg0.xpBonusText:setText("+" .. f2_local0 .. "%")
	if CoD.isSinglePlayer == true then
		f2_arg0.xpBonusLabel:close()
		f2_arg0.xpBonusText:close()
	end
end

CoD.AllocationSubtitle.SetAllocationChange = function (f3_arg0, f3_arg1, f3_arg2)
	if f3_arg1 == nil then
		f3_arg0.allocationWithChange = nil
	else
		local f3_local0 = f3_arg0.remainingAllocation
		if f3_local0 < -f3_arg1 then
			f3_arg1 = -f3_local0
		end
		f3_arg0.allocationWithChange = f3_local0 + f3_arg1
	end
	return f3_arg1
end

CoD.AllocationSubtitle.CommitChange = function (f4_arg0)
	local f4_local0 = f4_arg0.allocationWithChange
	if f4_local0 ~= nil then
		local f4_local1 = f4_arg0.remainingAllocation
		f4_arg0:setRemainingAllocation(f4_local0, CoD.AllocationSubtitle.ChangeFadeTime)
		f4_arg0:setAllocationChange(nil, CoD.AllocationSubtitle.ChangeFadeTime)
	end
end

CoD.AllocationSubtitle.CanAfford = function (f5_arg0, f5_arg1)
	if f5_arg0.remainingAllocation < f5_arg1 then
		return false
	else
		return true
	end
end

CoD.AllocationSubtitle.AddBars = function (f6_arg0)
	local f6_local0 = f6_arg0.width
	local f6_local1 = CoD.AllocationSubtitle.NumBars
	local f6_local2 = CoD.AllocationSubtitle.BarSpacing
	local f6_local3 = (f6_local0 - (f6_local1 - 1) * f6_local2) / f6_local1
	local f6_local4 = CoD.AllocationSubtitle.MaxAllocation / f6_local1
	local f6_local5 = f6_local1 - 1
	for f6_local6 = 0, f6_local5, 1 do
		local f6_local9 = f6_local6 * (f6_local3 + f6_local2)
		local f6_local10 = f6_local4 * f6_local6
		f6_arg0:addElement(CoD.AllocationSubtitle.NewBar(f6_local3, f6_local10, f6_local10 + f6_local4, {
			left = f6_local9,
			top = 0,
			right = f6_local9 + f6_local3,
			bottom = 0,
			leftAnchor = true,
			topAnchor = true,
			rightAnchor = false,
			bottomAnchor = true
		}))
	end
end

CoD.AllocationSubtitle.NewBar = function (f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	local Widget = LUI.UIElement.new(f7_arg3)
	Widget.width = f7_arg0
	Widget:addElement(LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		alpha = 0.6
	}))
	Widget.fill = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true,
		red = 0,
		green = 0,
		blue = 0
	})
	Widget:addElement(Widget.fill)
	Widget.minAllocation = f7_arg1
	Widget.maxAllocation = f7_arg2
	Widget.allocationRange = Widget.maxAllocation - Widget.minAllocation
	Widget.calculateFillPercent = CoD.AllocationSubtitle.Bar_CalculateFillPercent
	Widget:registerEventHandler("allocation_change", CoD.AllocationSubtitle.Bar_AllocationChange)
	Widget:registerEventHandler("delayed_allocation_change", CoD.AllocationSubtitle.Bar_DelayedAllocationChange)
	return Widget
end

CoD.AllocationSubtitle.Bar_CalculateFillPercent = function (f8_arg0, f8_arg1)
	local f8_local0 = (f8_arg1 - f8_arg0.minAllocation) / f8_arg0.allocationRange
	if f8_local0 < 0 then
		f8_local0 = 0
	elseif f8_local0 > 1 then
		f8_local0 = 1
	end
	return f8_local0
end

CoD.AllocationSubtitle.Bar_AllocationChange = function (f9_arg0, f9_arg1)
	f9_arg0.fill:registerAnimationState("allocation_change", {
		left = 0,
		top = 0,
		right = f9_arg0.width * f9_arg0:calculateFillPercent(f9_arg1.after),
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = true
	})
	f9_arg0.fill:animateToState("allocation_change")
end

