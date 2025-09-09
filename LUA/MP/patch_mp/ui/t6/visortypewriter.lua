CoD.VisorTypewriter = {}
CoD.VisorTypewriter.FontName = "ExtraSmall"
CoD.VisorTypewriter.MaxNumberOfLines = 3
CoD.VisorTypewriter.Blue = CoD.visorBlue
CoD.VisorTypewriter.Orange = CoD.trueOrange
CoD.VisorTypewriter.RemoveDuration = 500
CoD.VisorTypewriter.new = function ()
	CoD.VisorTypewriter.ContainerWidth = 300
	CoD.VisorTypewriter.ContainerHeight = 65
	CoD.VisorTypewriter.Font = CoD.fonts[CoD.VisorTypewriter.FontName]
	CoD.VisorTypewriter.FontSize = CoD.textSize[CoD.VisorTypewriter.FontName]
	local f1_local0 = 15
	local f1_local1 = 8
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(false, true, -CoD.VisorTypewriter.ContainerWidth - f1_local0, -f1_local0)
	Widget:setTopBottom(false, false, -CoD.VisorTypewriter.ContainerHeight / 2 - f1_local1, CoD.VisorTypewriter.ContainerHeight / 2 - f1_local1)
	Widget.id = Widget.id .. ".VisorTextContainer"
	Widget:registerEventHandler("hud_add_visor_text", CoD.VisorTypewriter.AddVisorText)
	Widget:registerEventHandler("hud_remove_visor_text", CoD.VisorTypewriter.RemoveVisorText)
	Widget:registerEventHandler("process_visor_text", CoD.VisorTypewriter.ProcessVisorText)
	Widget:registerEventHandler("update_list_layout", CoD.VisorTypewriter.UpdateListLayout)
	Widget.typewriterElements = {}
	Widget.curNumLines = 0
	Widget.totalNumLinesAdded = 0
	return Widget
end

CoD.VisorTypewriter.AddVisorText = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.data[1]
	local f2_local1 = Engine.Localize(Engine.GetIString(f2_local0, "CS_LOCALIZED_STRINGS"))
	local f2_local2 = nil
	local f2_local3 = f2_arg1.data[2] * 1000
	if f2_arg1.data[3] == 1 then
		f2_local2 = CoD.VisorTypewriter.Blue
	elseif f2_arg1.data[3] == 2 then
		f2_local2 = CoD.VisorTypewriter.Orange
	end
	local f2_local4 = f2_arg1.data[4] * 0.01
	local f2_local5 = f2_arg1.data[5]
	local f2_local6 = f2_arg1.data[6]
	local f2_local7 = f2_arg1.data[7]
	local f2_local8 = CoD.VisorTypewriter.FontSize
	local f2_local9 = CoD.VisorTypewriter.Font
	local f2_local10 = Engine.GetNumTextLines(f2_local1, f2_local9, f2_local8, CoD.VisorTypewriter.ContainerWidth)
	local f2_local11, f2_local12, f2_local13, f2_local14 = GetTextDimensions(f2_local1, f2_local9, f2_local8)
	local f2_local15 = (f2_local13 + f2_local11) * 8
	local f2_local16 = f2_local10 * f2_local8
	local f2_local17 = f2_arg0.totalNumLinesAdded * f2_local8
	f2_arg0.totalNumLinesAdded = f2_arg0.totalNumLinesAdded + f2_local10
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, true, 0, 0)
	Widget:setTopBottom(true, false, f2_local17, f2_local16 + f2_local17)
	Widget:setAlpha(0)
	Widget.id = Widget.id .. ".TextContainer"
	f2_arg0:addElement(Widget)
	Widget:registerEventHandler("remove", CoD.VisorTypewriter.TypeContainer_RemoveAnim)
	Widget:registerEventHandler("display_new_text", CoD.VisorTypewriter.DisplayNewText)
	Widget:registerEventHandler("update_parent_list", CoD.VisorTypewriter.UpdateParentList)
	if f2_local5 == 1 then
		Widget:flicker(0, f2_local4, nil, f2_local4, f2_local6, f2_local7)
	end
	Widget.textContainerTopOffset = f2_local17
	Widget.textContainerHeight = f2_local16
	Widget.textString = f2_local1
	Widget.textAnimationLength = f2_local15
	Widget.textLifetimeDuration = f2_local3
	Widget.textAlpha = f2_local4
	Widget.textFlash = f2_local5
	Widget.flickerLowTime = f2_local6
	Widget.flickerHighTime = f2_local7
	Widget.numLines = f2_local10
	Widget.stringID = f2_local0
	
	local visorTyperwriterText = CoD.TypewriterText.new()
	visorTyperwriterText:setLeftRight(true, true, 0, 0)
	visorTyperwriterText:setTopBottom(true, false, 0, f2_local8)
	visorTyperwriterText:setRGB(f2_local2.r, f2_local2.g, f2_local2.b)
	visorTyperwriterText:setFont(f2_local9)
	visorTyperwriterText:setAlignment(LUI.Alignment.Right)
	Widget:addElement(visorTyperwriterText)
	Widget.visorTyperwriterText = visorTyperwriterText
	
	table.insert(f2_arg0.typewriterElements, Widget)
	f2_arg0:processEvent({
		name = "process_visor_text"
	})
end

CoD.VisorTypewriter.ProcessVisorText = function (f3_arg0, f3_arg1)
	if #f3_arg0.typewriterElements == 0 then
		return 
	end
	for f3_local0 = 1, #f3_arg0.typewriterElements, 1 do
		local f3_local3 = f3_arg0.typewriterElements[f3_local0]
		if not f3_local3.beingProcessed then
			if f3_arg0.curNumLines + f3_local3.numLines <= CoD.VisorTypewriter.MaxNumberOfLines then
				f3_local3:setAlpha(f3_local3.textAlpha)
				if f3_local3.textFlash == 1 then

				else
					f3_arg0.curNumLines = f3_arg0.curNumLines + f3_local3.numLines
					f3_local3.beingProcessed = true
					f3_local3:processEvent({
						name = "display_new_text"
					})
					break
				end
				f3_local3:flicker(0, f3_local3.textAlpha, nil, f3_local3.textAlpha, f3_local3.flickerLowTime, f3_local3.flickerHighTime)
			end
		end
	end
end

CoD.VisorTypewriter.DisplayNewText = function (f4_arg0, f4_arg1)
	f4_arg0:addElement(LUI.UITimer.new(50, {
		name = "typewrite",
		text = f4_arg0.textString,
		duration = f4_arg0.textAnimationLength
	}, true, f4_arg0))
	f4_arg0:addElement(LUI.UITimer.new(f4_arg0.textAnimationLength + f4_arg0.textLifetimeDuration, {
		name = "update_parent_list",
		textContainer = f4_arg0
	}, true, f4_arg0))
end

CoD.VisorTypewriter.UpdateParentList = function (f5_arg0, f5_arg1)
	f5_arg0:dispatchEventToParent({
		name = "update_list_layout",
		textContainer = f5_arg1.textContainer
	})
end

CoD.VisorTypewriter.UpdateLayout = function (f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = f6_arg2 * CoD.VisorTypewriter.FontSize
	for f6_local1 = f6_arg1, #f6_arg0.typewriterElements, 1 do
		local f6_local4 = f6_arg0.typewriterElements[f6_local1]
		local f6_local5 = f6_local4.textContainerTopOffset - f6_local0
		f6_local4:beginAnimation("update_position", CoD.VisorTypewriter.RemoveDuration)
		f6_local4:setTopBottom(true, false, f6_local5, f6_local5 + f6_local4.textContainerHeight)
		if f6_local4.textFlash == 1 then
			f6_local4:flicker(0, f6_local4.textAlpha, nil, f6_local4.textAlpha, f6_local4.flickerLowTime, f6_local4.flickerHighTime)
		end
	end
end

CoD.VisorTypewriter.UpdateListLayout = function (f7_arg0, f7_arg1)
	local f7_local0 = f7_arg1.textContainer
	if f7_local0.textLifetimeDuration > 0 then
		local f7_local1 = f7_local0.numLines
		f7_arg0.curNumLines = f7_arg0.curNumLines - f7_local1
		f7_arg0.totalNumLinesAdded = f7_arg0.totalNumLinesAdded - f7_local1
		f7_local0.visorTyperwriterText:setAlpha(0)
		f7_local0:beginAnimation("remove", CoD.VisorTypewriter.RemoveDuration)
		f7_local0:setLeftRight(true, false, 0, 0)
		f7_local0:setTopBottom(true, false, f7_local0.textContainerTopOffset, 0)
		local f7_local2 = 0
		for f7_local3 = 1, #f7_arg0.typewriterElements, 1 do
			if f7_arg0.typewriterElements[f7_local3].stringID == f7_local0.stringID then
				f7_local2 = f7_local3
				break
			end
		end
		if f7_local2 ~= 0 then
			f7_arg0.typewriterElements[f7_local2]:close()
			table.remove(f7_arg0.typewriterElements, f7_local2)
		end
		local f7_local4 = f7_local1 * CoD.VisorTypewriter.FontSize
		for f7_local5 = f7_local2, #f7_arg0.typewriterElements, 1 do
			local f7_local8 = f7_arg0.typewriterElements[f7_local5]
			local f7_local9 = f7_local8.textContainerTopOffset - f7_local4
			f7_local8:beginAnimation("update_position", CoD.VisorTypewriter.RemoveDuration)
			f7_local8:setTopBottom(true, false, f7_local9, f7_local9 + f7_local8.textContainerHeight)
			if f7_local8.textFlash == 1 then
				f7_local8:flicker(0, f7_local8.textAlpha, nil, f7_local8.textAlpha, f7_local8.flickerLowTime, f7_local8.flickerHighTime)
			end
			f7_local8.textContainerTopOffset = f7_local9
		end
	end
	f7_arg0:processEvent({
		name = "process_visor_text"
	})
end

CoD.VisorTypewriter.RemoveVisorText = function (f8_arg0, f8_arg1)
	local f8_local0 = f8_arg1.data[1]
	local f8_local1 = 0
	for f8_local2 = 1, #f8_arg0.typewriterElements, 1 do
		if f8_arg0.typewriterElements[f8_local2].stringID == f8_local0 then
			f8_local1 = f8_local2
			break
		end
	end
	if f8_local1 == 0 then
		DebugPrint("VisorTypewriter: Could not find the string to be removed.")
		return 
	else
		local f8_local2 = f8_arg0.typewriterElements[f8_local1]
		f8_local2.textLifetimeDuration = 1
		f8_arg0:processEvent({
			name = "update_list_layout",
			textContainer = f8_local2
		})
	end
end

