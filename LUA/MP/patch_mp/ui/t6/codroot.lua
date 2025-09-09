LUI.CoDRoot = {}
LUI.CoDRoot.ProcessEvent = function (f1_arg0, f1_arg1)
	if f1_arg1.immediate == true then
		LUI.CoDRoot.ProcessEventNow(f1_arg0, f1_arg1)
	else
		local f1_local0 = f1_arg0.eventQueue
		table.insert(f1_local0, f1_arg1)
		local f1_local1 = #f1_local0
		if f1_local1 > 20 then
			DebugPrint("LUI WARNING: Event queue exceeded 20 events! " .. f1_arg1.name .. ". Size is " .. f1_local1)
		end
	end
end

LUI.CoDRoot.ProcessEvents = function (f2_arg0, f2_arg1)
	local f2_local0 = f2_arg0.eventQueue
	local f2_local1 = 0
	local f2_local2 = #f2_local0
	if f2_local2 > 60 then
		f2_local1 = f2_local2
		DebugPrint("LUI WARNING: Event queue reached " .. f2_local1 .. "!. ** Emergency event processing kicked off. ** ")
	elseif f2_local2 > 40 then
		f2_local1 = math.floor(f2_local2 / 10)
		DebugPrint("LUI WARNING: Event queue reached " .. f2_local2 .. ". Processing " .. f2_local1 .. " events this frame.")
	else
		f2_local1 = 1
	end
	for f2_local3 = 1, f2_local1, 1 do
		local f2_local6 = f2_local3
		local f2_local7 = f2_local0[1]
		if f2_local7 ~= nil then
			table.remove(f2_local0, 1)
			LUI.CoDRoot.ProcessEventNow(f2_arg0, f2_local7)
		end
	end
end

LUI.CoDRoot.ProcessEventNow = function (f3_arg0, f3_arg1)
	if f3_arg1.name ~= "process_events" then
		Engine.EventProcessed()
	end
	f3_arg0:propagateEvent(f3_arg1)
	Engine.PIXBeginEvent(f3_arg1.name)
	local f3_local0 = LUI.UIElement.processEvent(f3_arg0, f3_arg1)
	Engine.PIXEndEvent()
	return f3_local0
end

LUI.CoDRoot.DontPropagateEvent = function (f4_arg0, f4_arg1)

end

LUI.CoDRoot.PropagateEventToPrimaryRoot = function (f5_arg0, f5_arg1)
	if LUI.primaryRoot ~= nil and LUI.primaryRoot ~= f5_arg0 and f5_arg1.name ~= "resize" and f5_arg1.name ~= "addmenu" then
		LUI.UIElement.processEvent(LUI.primaryRoot, f5_arg1)
	end
end

LUI.CoDRoot.CloseAll = function (f6_arg0, f6_arg1)
	f6_arg0:removeAllChildren()
end

LUI.CoDRoot.new = function (f7_arg0)
	local f7_local0 = LUI.UIRoot.new(f7_arg0)
	f7_local0.eventQueue = {}
	f7_local0.numEvents = 0
	f7_local0:registerEventHandler("process_events", LUI.CoDRoot.ProcessEvents)
	f7_local0:registerEventHandler("close_all", LUI.CoDRoot.CloseAll)
	if f7_arg0 == "UIRootDrc" then
		f7_local0.propagateEvent = LUI.CoDRoot.DontPropagateEvent
	else
		f7_local0.propagateEvent = LUI.CoDRoot.PropagateEventToPrimaryRoot
	end
	f7_local0.processEvent = LUI.CoDRoot.ProcessEvent
	if LUI.primaryRoot == nil then
		LUI.primaryRoot = f7_local0
	end
	return f7_local0
end

