CoD.AllocationStatus = {}
CoD.AllocationStatus.StatusFontName = "Condensed"
CoD.AllocationStatus.StatusFont = CoD.fonts[CoD.AllocationStatus.StatusFontName]
CoD.AllocationStatus.StatusFontHeight = CoD.textSize[CoD.AllocationStatus.StatusFontName]
CoD.AllocationStatus.Width = 100
CoD.AllocationStatus.Height = CoD.AllocationStatus.StatusFontHeight
CoD.AllocationStatus.new = function (HudRef, InstanceRef)
	local Widget = LUI.UIElement.new(InstanceRef)
	Widget.id = "AllocationStatus"
	Widget.maxAllocation = Engine.GetMaxAllocation(HudRef)
	Widget.text = LUI.UIText.new({
		leftAnchor = false,
		rightAnchor = true,
		left = 0,
		right = 0,
		topAnchor = true,
		bottomAnchor = true,
		top = 0,
		bottom = 0,
		red = CoD.BOIIOrange.r,
		green = CoD.BOIIOrange.g,
		blue = CoD.BOIIOrange.b,
		font = CoD.AllocationStatus.StatusFont
	})
	Widget.text:registerAnimationState("under_budget", {
		red = CoD.orange.r,
		green = CoD.orange.g,
		blue = CoD.orange.b
	})
	Widget.text:registerAnimationState("over_budget", {
		red = 1,
		green = 0.5,
		blue = 0.5
	})
	Widget.text:registerAnimationState("over_budget_flash", {
		red = 1,
		green = 0,
		blue = 0
	})
	Widget.text:registerEventHandler("transition_complete_over_budget", CoD.AllocationStatus.Text_OverBudget)
	Widget.text:registerEventHandler("transition_complete_over_budget_flash", CoD.AllocationStatus.Text_OverBudgetFlash)
	Widget:addElement(Widget.text)
	Widget:registerEventHandler("update_class", CoD.AllocationStatus.Update)
	return Widget
end

CoD.AllocationStatus.Update = function (f2_arg0, f2_arg1)
	if f2_arg0.maxAllocation < f2_arg1.class.allocationSpent then
		if not f2_arg0.overBudget then
			f2_arg0.overBudget = true
			f2_arg0.text:animateToState("over_budget_flash")
		end
		f2_arg0.text:setText("OVER BUDGET " .. f2_arg1.class.allocationSpent .. "/" .. f2_arg0.maxAllocation)
	else
		if f2_arg0.overBudget then
			f2_arg0.overBudget = nil
			f2_arg0.text:animateToState("under_budget")
		end
		f2_arg0.text:setText(f2_arg1.class.allocationSpent .. "/" .. f2_arg0.maxAllocation)
	end
end

CoD.AllocationStatus.Text_OverBudget = function (f3_arg0, f3_arg1)
	if not f3_arg1.interrupted then
		f3_arg0:animateToState("over_budget_flash", 150)
	end
end

CoD.AllocationStatus.Text_OverBudgetFlash = function (f4_arg0, f4_arg1)
	if not f4_arg1.interrupted then
		f4_arg0:animateToState("over_budget", 300)
	end
end

