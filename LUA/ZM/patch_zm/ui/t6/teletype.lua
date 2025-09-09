if CoD == nil then
	CoD = {}
end
local f0_local0, f0_local1, f0_local2, f0_local3, f0_local4, f0_local5, f0_local6, f0_local7 = nil
CoD.Teletype = {}
CoD.Teletype.Height = CoD.textSize.Default
CoD.Teletype.Width = CoD.Teletype.Height
CoD.Teletype.new = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7)
	local f1_local0 = LUI.UIScrollable.new(f1_arg0, f1_arg1, 10000)
	f1_local0.verticalList = LUI.UIVerticalList.new({
		left = 0,
		top = 0,
		right = f1_arg1,
		bottom = f1_arg2,
		leftAnchor = true,
		topAnchor = true,
		rightAnchor = false,
		bottomAnchor = false
	})
	f1_local0:addElement(f1_local0.verticalList)
	f1_local0.verticalList:registerEventHandler("update_spacing", f0_local7)
	f1_local0.charTimer = LUI.UITimer.new(f1_arg3, "teletype_char_tick")
	LUI.UIElement.addElement(f1_local0, f1_local0.charTimer)
	f1_local0:registerEventHandler("teletype_char_tick", f0_local1)
	if f1_arg4 == true then
		f1_local0.lineScrollTimer = LUI.UITimer.new(f1_arg5, "teletype_line_scroll_tick")
		LUI.UIElement.addElement(f1_local0, f1_local0.lineScrollTimer)
		f1_local0:registerEventHandler("teletype_line_scroll_tick", f0_local2)
	end
	f1_local0:registerEventHandler("message_delay", f0_local3)
	f1_local0.boxWidth = f1_arg1
	f1_local0.boxHeight = f1_arg2
	f1_local0.itemHeight = CoD.textSize.Condensed
	f1_local0.font = CoD.fonts.Morris
	f1_local0.scrollEnabled = f1_arg4
	f1_local0.repeatAll = f1_arg6
	f1_local0.repeatDelay = f1_arg7
	f1_local0.skipFirstScroll = true
	f1_local0.addMessage = f0_local0
	f1_local0.removeText = f0_local5
	f1_local0.resetChars = f0_local6
	f1_local0.messagesArray = {}
	f1_local0.currentIndex = 1
	f1_local0.stringLength = 1
	f1_local0.lineCount = 1
	return f1_local0
end

f0_local0 = function (f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	local f2_local0 = LUI.UIText.new({
		left = 0,
		top = 0,
		bottom = f2_arg0.itemHeight,
		right = f2_arg0.boxWidth,
		topAnchor = true,
		leftAnchor = true,
		rightAnchor = false,
		bottomAnchor = false,
		font = f2_arg0.font,
		red = 1,
		green = 1,
		blue = 1,
		alpha = 1,
		alignment = LUI.Alignment.Left
	})
	f2_arg0.verticalList:addElement(f2_local0)
	table.insert(f2_arg0.messagesArray, f2_arg1)
	f2_local0.tempLineSpacing = f2_arg3
end

f0_local7 = function (f3_arg0, f3_arg1)
	f3_arg0:registerAnimationState("update_spacing", {
		spacing = f3_arg1.spacing
	})
	f3_arg0:animateToState("update_spacing", f3_arg1.duration)
end

f0_local3 = function (f4_arg0, f4_arg1)
	LUI.UIElement.addElement(f4_arg0, f4_arg0.charTimer)
	if f4_arg0.scrollEnabled == true then
		LUI.UIElement.addElement(f4_arg0, f4_arg0.lineScrollTimer)
	end
	f4_arg0:resetChars(0)
	f4_arg0.currentIndex = 1
end

f0_local6 = function (f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0.verticalList:getFirstChild()
	while f5_local0 ~= nil do
		f5_local0:setText("")
		f5_local0 = f5_local0:getNextSibling()
	end
	if f5_arg0.lineScrollTimer ~= nil then
		f5_arg0:scrollY(0, 0, true, true)
		f5_arg0.lineCount = 1
		f5_arg0.lineScrollTimer:reset()
		f5_arg0.skipFirstScroll = true
	end
end

f0_local5 = function (f6_arg0, f6_arg1)

end

f0_local1 = function (f7_arg0, f7_arg1)
	if f7_arg0.messagesArray == nil then
		return 
	end
	local f7_local0 = f7_arg0.messagesArray[f7_arg0.currentIndex]
	if f7_local0 == nil then
		return 
	end
	local f7_local1 = f0_local4(f7_local0, f7_arg0.stringLength)
	local f7_local2 = f7_arg0.verticalList:getFirstChild()
	for f7_local3 = 2, f7_arg0.currentIndex, 1 do
		local f7_local6 = f7_local3
		f7_local2 = f7_local2:getNextSibling()
	end
	f7_local2:setText(f7_local1)
	if f7_arg0.stringLength == #f7_local0 then
		f7_arg0.stringLength = 1
		if f7_arg0.currentIndex < #f7_arg0.messagesArray then
			local f7_local3 = 1
			if f7_local2.tempLineSpacing ~= nil then
				f7_local3 = f7_local2.tempLineSpacing
			end
			f7_arg0.verticalList:processEvent({
				name = "update_spacing",
				spacing = f7_arg0.itemHeight * f7_local3,
				duration = 0
			})
			f7_arg0.currentIndex = f7_arg0.currentIndex + 1
		else
			f7_arg0.charTimer:close()
			if f7_arg0.lineScrollTimer ~= nil then
				f7_arg0.lineScrollTimer:close()
			end
			if f7_arg0.repeatAll == true and f7_arg0.repeatDelay ~= nil then
				f7_arg0:addElement(LUI.UITimer.new(f7_arg0.repeatDelay, "message_delay", true, f7_arg0))
			end
		end
	else
		f7_arg0.stringLength = f7_arg0.stringLength + 1
	end
end

f0_local2 = function (f8_arg0, f8_arg1)
	if f8_arg0.skipFirstScroll == true then
		f8_arg0.skipFirstScroll = nil
		return 
	elseif f8_arg0 ~= nil then
		f8_arg0:scrollY(-f8_arg0.itemHeight * f8_arg0.lineCount, 1000)
		f8_arg0.lineCount = f8_arg0.lineCount + 1
	end
end

f0_local4 = function (f9_arg0, f9_arg1)
	if f9_arg0 ~= nil then
		return f9_arg0:sub(1, f9_arg1)
	else

	end
end

