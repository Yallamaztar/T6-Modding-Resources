CoD.VisorTimer = {}
CoD.VisorTimer.ContainerWidth = 100
CoD.VisorTimer.ContainerHeight = 30
CoD.VisorTimer.FontAlpha = 0.75
CoD.VisorTimer.Blue = CoD.visorBlue
CoD.VisorTimer.new = function ()
	local f1_local0 = CoD.VisorLeftBracket.BracketWidth
	local f1_local1 = -CoD.VisorLeftBracket.BracketHeight / 2 + CoD.ObjectiveText.DefaultHeight + 20
	local Widget = LUI.UIElement.new()
	Widget:setLeftRight(true, false, f1_local0, CoD.VisorTimer.ContainerWidth + f1_local0)
	Widget:setTopBottom(false, false, -CoD.VisorTimer.ContainerHeight / 2 - f1_local1, CoD.VisorTimer.ContainerHeight / 2 - f1_local1)
	Widget.id = Widget.id .. ".VisorTimer"
	Widget:registerEventHandler("hud_create_timer", CoD.VisorTimer.CreateTimer)
	Widget:registerEventHandler("hud_destroy_timer", CoD.VisorTimer.DestroyTimer)
	return Widget
end

CoD.VisorTimer.CreateTimer = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg1.data[1] * 1000 or 600000
	local f2_local1
	if f2_arg1.data[2] ~= 0 then
		f2_local1 = true
	else
		f2_local1 = false
	end
	local f2_local2
	if f2_arg1.data[3] ~= 0 then
		f2_local2 = true
	else
		f2_local2 = false
	end
	local f2_local3
	if f2_arg1.data[4] ~= 0 then
		f2_local3 = true
	else
		f2_local3 = false
	end
	local f2_local4
	if f2_arg1.data[5] ~= 0 then
		f2_local4 = true
	else
		f2_local4 = false
	end
	local f2_local5 = f2_arg1.data[6]
	if f2_local5 then
		f2_local5 = f2_local5 * 1000
	else
		f2_local5 = 30000
	end
	local f2_local6 = CoD.fonts.Default
	local f2_local7 = CoD.textSize.Default
	local f2_local8 = LUI.UIText.new(nil, true)
	f2_local8:setLeftRight(true, true, 0, 0)
	f2_local8:setTopBottom(false, false, -f2_local7 / 2, f2_local7 / 2)
	f2_local8:setRGB(CoD.VisorTimer.Blue.r, CoD.VisorTimer.Blue.g, CoD.VisorTimer.Blue.b)
	f2_local8:setFont(f2_local6)
	f2_local8:setAlignment(LUI.Alignment.Left)
	f2_local8:setAlpha(CoD.VisorTimer.FontAlpha)
	f2_arg0:addElement(f2_local8)
	if f2_local1 == false then
		CoD.CountdownTimer.Setup(f2_local8, f2_local5, f2_local3)
		f2_local8:setTimeLeft(f2_local0)
	else
		CoD.CountupTimer.Setup(f2_local8, f2_local2, f2_local4)
		f2_local8:setTimeStart(f2_local0)
	end
	f2_arg0.timerText = f2_local8
end

CoD.VisorTimer.DestroyTimer = function (f3_arg0, f3_arg1)
	if f3_arg0.timerText then
		f3_arg0.timerText:close()
	end
end

