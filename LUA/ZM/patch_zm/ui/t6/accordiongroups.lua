require("T6.CoD9Button")
require("T6.ButtonList")
require("T6.MFSlide")
CoD.AccordionGroups = {}
CoD.AccordionGroups.RowHeight = CoD.CoD9Button.Height
CoD.AccordionGroups.Spacing = 2
CoD.AccordionGroups.ExpandTime = 150
CoD.AccordionGroups.SectionHeight = 90
CoD.AccordionGroups.TextLeft = 20
CoD.AccordionGroups.new = function ()
	local f1_local0 = LUI.UIVerticalList.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 100,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f1_local0.rowHeight = CoD.AccordionGroups.RowHeight
	f1_local0.textLeft = CoD.AccordionGroups.TextLeft
	f1_local0.textHeight = CoD.CoD9Button.TextHeight
	f1_local0.spacing = CoD.AccordionGroups.Spacing
	f1_local0.sectionHeight = CoD.AccordionGroups.SectionHeight
	f1_local0.addGroup = CoD.AccordionGroups.AddGroup
	f1_local0.getMaxHeight = CoD.AccordionGroups.GetMaxHeight
	f1_local0.handleGamepadButton = CoD.AccordionGroups.HandleGamepadButton
	return f1_local0
end

CoD.AccordionGroups.GetMaxHeight = function (f2_arg0)
	return f2_arg0.m_numGroups * f2_arg0.rowHeight + (f2_arg0.m_numGroups - 1) * f2_arg0.spacing + f2_arg0.sectionHeight
end

CoD.AccordionGroups.AddGroup = function (f3_arg0, f3_arg1)
	if f3_arg0.m_groups == nil then
		f3_arg0.m_groups = {}
	end
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = f3_arg0.rowHeight,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = false
	})
	f3_arg0:addElement(Widget)
	Widget.background = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.CoD9Button.BackgroundColor.r,
		green = CoD.CoD9Button.BackgroundColor.g,
		blue = CoD.CoD9Button.BackgroundColor.b,
		alpha = CoD.CoD9Button.BackgroundColor.a
	})
	Widget:addElement(Widget.background)
	Widget.label = LUI.UIText.new({
		left = f3_arg0.textLeft,
		top = -f3_arg0.textHeight / 2,
		right = 0,
		bottom = f3_arg0.textHeight / 2,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = false,
		bottomAnchor = false,
		font = CoD.fonts.Condensed
	})
	Widget:addElement(Widget.label)
	Widget.label:setText(f3_arg1)
	local Widget = LUI.UIElement.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = false,
		rightAnchor = true,
		bottomAnchor = false
	})
	Widget:setUseStencil(true)
	Widget.m_inputDisabled = true
	Widget:registerAnimationState("expanded", {
		top = -f3_arg0.sectionHeight / 2,
		bottom = f3_arg0.sectionHeight / 2,
		topAnchor = false,
		bottomAnchor = false
	})
	f3_arg0:addElement(Widget)
	Widget.background = LUI.UIImage.new({
		left = 0,
		top = 0,
		right = 0,
		bottom = 0,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = true,
		bottomAnchor = true,
		red = CoD.MFSlide.SlideColor.r,
		green = CoD.MFSlide.SlideColor.g,
		blue = CoD.MFSlide.SlideColor.b,
		alpha = CoD.MFSlide.SlideColor.a
	})
	Widget:addElement(Widget.background)
	Widget.topShadow = CoD.EdgeShadow.new("top", true)
	Widget.topShadow:setPriority(100)
	Widget:addElement(Widget.topShadow)
	Widget.bottomShadow = CoD.EdgeShadow.new("bottom", true)
	Widget.bottomShadow:setPriority(100)
	Widget:addElement(Widget.bottomShadow)
	if f3_arg0.m_numGroups == nil then
		f3_arg0.m_numGroups = 0
		f3_arg0.m_currentGroup = 1
		Widget:animateToState("expanded")
		Widget.m_inputDisabled = nil
	end
	f3_arg0.m_numGroups = f3_arg0.m_numGroups + 1
	f3_arg0:addSpacer(f3_arg0.spacing)
	table.insert(f3_arg0.m_groups, {
		rowHeader = Widget,
		section = Widget
	})
	return Widget
end

CoD.AccordionGroups.HandleGamepadButton = function (f4_arg0, f4_arg1)
	if LUI.UIElement.handleGamepadButton(f4_arg0, f4_arg1) == true then
		return true
	end
	local f4_local0 = nil
	if f4_arg1.down == true then
		if f4_arg1.button == "up" then
			f4_local0 = -1
		elseif f4_arg1.button == "down" then
			f4_local0 = 1
		end
	end
	if f4_local0 ~= nil and f4_arg0.m_currentGroup ~= nil then
		local f4_local1 = f4_arg0.m_currentGroup
		f4_arg0.m_currentGroup = LUI.clamp(f4_arg0.m_currentGroup + f4_local0, 1, f4_arg0.m_numGroups)
		if f4_local1 ~= f4_arg0.m_currentGroup then
			f4_arg0.m_groups[f4_local1].section:animateToState("default", CoD.AccordionGroups.ExpandTime, true, true)
			f4_arg0.m_groups[f4_local1].section.m_inputDisabled = true
			f4_arg0.m_groups[f4_arg0.m_currentGroup].section:animateToState("expanded", CoD.AccordionGroups.ExpandTime, true, true)
			f4_arg0.m_groups[f4_arg0.m_currentGroup].section.m_inputDisabled = nil
		end
	end
end

