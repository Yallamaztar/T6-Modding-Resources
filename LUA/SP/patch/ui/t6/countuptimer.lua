CoD.CountupTimer = {}
CoD.CountupTimer.Setup = function (f1_arg0, f1_arg1, f1_arg2)
	f1_arg0.setTimeStart = CoD.CountupTimer.SetTimeStart
	f1_arg0.showHours = f1_arg1
	f1_arg0.showMillliseconds = f1_arg2
	f1_arg0:registerEventHandler("count_tick", CoD.CountupTimer.CountTick)
end

CoD.CountupTimer.SetTimeStart = function (f2_arg0, f2_arg1)
	f2_arg0.countTime = f2_arg1
	local f2_local0 = nil
	local f2_local1 = 1000
	local f2_local2 = f2_local1 * 60
	local f2_local3 = f2_local2 * 60
	f2_local0 = f2_arg1 % 100
	local f2_local4 = math.floor(f2_arg1 / f2_local3)
	local f2_local5 = math.floor(f2_arg1 / f2_local2) - f2_local4 * 60
	local f2_local6 = math.floor(f2_arg1 / f2_local1) - f2_local4 * 60 * 60 - f2_local5 * 60
	local f2_local7 = math.floor(f2_arg1 / 100) - f2_local4 * 60 * 60 * 10 - f2_local5 * 60 * 10 - f2_local6 * 10
	if f2_local4 < 10 then
		f2_local4 = "0" .. f2_local4
	end
	if f2_local5 < 10 then
		f2_local5 = "0" .. f2_local5
	end
	if f2_local6 < 10 then
		f2_local6 = "0" .. f2_local6
	end
	if f2_local7 == 0 then
		f2_local7 = "00"
	else
		f2_local7 = "0" .. f2_local7
	end
	if f2_arg0.showHours == false then
		if f2_arg0.showMillliseconds == false then
			f2_arg0:setText(f2_local5 .. ":" .. f2_local6)
		else
			f2_arg0:setText(f2_local5 .. ":" .. f2_local6 .. ":" .. f2_local7)
		end
	elseif f2_arg0.showMillliseconds == false then
		f2_arg0:setText(f2_local4 .. ":" .. f2_local5 .. ":" .. f2_local6)
	else
		f2_arg0:setText(f2_local4 .. ":" .. f2_local5 .. ":" .. f2_local6 .. ":" .. f2_local7)
	end
	if f2_local0 == 0 then
		f2_local0 = 1
	end
	local CountupTimer = f2_arg0.CountupTimer
	if CountupTimer == nil then
		CountupTimer = LUI.UITimer.new(f2_local0, "count_tick")
		f2_arg0:addElement(CountupTimer)
		f2_arg0.CountupTimer = CountupTimer
		
	else
		CountupTimer.interval = f2_local0
	end
end

CoD.CountupTimer.CountTick = function (f3_arg0, f3_arg1)
	f3_arg0:setTimeStart(f3_arg0.countTime + f3_arg1.timeElapsed)
end

