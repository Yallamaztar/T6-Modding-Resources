local f0_local0, f0_local1, f0_local2, f0_local3, f0_local4 = nil
f0_local2 = function (f1_arg0, f1_arg1)
	if f1_arg0.disable ~= nil and f1_arg0.disable then
		return 
	else
		DebugPrint("RTS Failure Menu: Mission retried")
		Engine.SendMenuResponse(f1_arg1.controller, "rts_action", "mission_failed_retry")
		Engine.LockInput(f1_arg1.controller, false)
		Engine.SetUIActive(f1_arg1.controller, false)
		f1_arg0:close()
		f1_arg0 = nil
	end
end

f0_local3 = function (f2_arg0, f2_arg1)
	if f2_arg0.disable ~= nil and f2_arg0.disable then
		return 
	else
		DebugPrint("RTS Failure Menu: Mission retried")
		Engine.SendMenuResponse(f2_arg1.controller, "rts_action", "mission_failed_quit")
		Engine.LockInput(f2_arg1.controller, false)
		Engine.SetUIActive(f2_arg1.controller, false)
		f2_arg0:close()
		f2_arg0 = nil
	end
end

f0_local4 = function (f3_arg0, f3_arg1)
	f3_arg0.descText:setAlpha(f3_arg1)
	f3_arg0.titleText:setAlpha(f3_arg1)
	f3_arg0.buttonList:setAlpha(f3_arg1)
	if f3_arg0.unitsRemaining then
		f3_arg0.unitsRemaining:setAlpha(f3_arg1)
	end
end

function SetupMissionResult(f4_arg0)
	f4_arg0.descText:registerAnimationState("fade_in", {
		alpha = 1
	})
	f4_arg0.titleText:registerAnimationState("fade_in", {
		alpha = 1
	})
	f4_arg0.buttonList:registerAnimationState("fade_in", {
		alpha = 1
	})
	if f4_arg0.unitsRemaining then
		f4_arg0.unitsRemaining:registerAnimationState("fade_in", {
			alpha = 1
		})
	end
end

function ShowMenu(f5_arg0)
	f5_arg0.descText:animateToState("fade_in", 2000)
	f5_arg0.titleText:animateToState("fade_in", 2000)
	f5_arg0.buttonList:animateToState("fade_in", 2000)
	f5_arg0.leftButtonPromptBar:animateToState("fade_in", 2000)
	if f5_arg0.unitsRemaining then
		f5_arg0.unitsRemaining:animateToState("fade_in", 2000)
	end
	f0_local4(f5_arg0, 1)
end

f0_local0 = function (f6_arg0)
	local f6_local0 = 5000
	if f6_arg0.success then
		f6_local0 = 2000
	end
	f6_arg0.disable = true
	f6_arg0:addElement(LUI.UITimer.new(f6_local0, "hide_result", true, f6_arg0.resultText))
	if not f6_arg0.success then
		f6_arg0.resultText:registerEventHandler("hide_result", function (Sender, Event)
			Sender:animateToState("fade_out", 2000)
		end)
	end
	f6_arg0:addElement(LUI.UITimer.new(7500, "show_text", true, f6_arg0))
	f6_arg0:registerEventHandler("show_text", function (f10_arg0, f10_arg1)
		ShowMenu(f10_arg0)
		f10_arg0.disable = false
	end)
end

f0_local1 = function (f7_arg0, f7_arg1)
	local resultText = LUI.UIText.new()
	resultText:setLeftRight(true, true, CoD.InGamePopupMenu.SideAlign, -CoD.InGamePopupMenu.SideAlign)
	resultText:setTopBottom(false, false, -CoD.textSize.Big / 2, CoD.textSize.Big / 2)
	resultText:setFont(CoD.fonts.Big)
	resultText:setAlignment(LUI.Alignment.Center)
	if not f7_arg1 then
		resultText:setText(Engine.Localize("SO_RTS_MISSION_FAILED"))
		resultText:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
	else
		resultText:setText(Engine.Localize("SO_RTS_MISSION_SUCCESS"))
		resultText:setRGB(CoD.RTSColors.blue.r, CoD.RTSColors.blue.g, CoD.RTSColors.blue.b)
	end
	resultText:registerAnimationState("fade_out", {
		alpha = 0
	})
	f7_arg0:addElement(resultText)
	f7_arg0.resultText = resultText
	
end

LUI.createMenu.RTSFailedMenu = function (f8_arg0, f8_arg1)
	if f8_arg1 == nil then
		f8_arg1 = false
	end
	local f8_local0 = UIExpression.GetDStat(f8_arg0, "PlayerCareerStats", "unitsAvailable")
	local f8_local1 = Dvar.ui_singlemission:get() == 1
	local f8_local2 = nil
	if f8_arg1 then
		f8_local2 = CoD.InGamePopupMenu.New("MissionSuccess", f8_arg0, "default", "", "", {
			{
				text = Engine.Localize("MENU_CONFIRM_CAPS"),
				event = "rts_mission_failed_quit"
			}
		})
	elseif f8_local0 > 0 and not f8_local1 then
		f8_local2 = CoD.InGamePopupMenu.New("MissionFailed", f8_arg0, "default", Engine.Localize("SO_RTS_RETRY_MISSION"), Engine.Localize("SO_RTS_RETRY_MISSION_UNIT"), {
			{
				text = Engine.Localize("SO_RTS_CONTINUE_STORY_CAPS"),
				event = "rts_mission_failed_quit"
			},
			{
				text = Engine.Localize("SO_RTS_RETRY_CURRENT_MISSION_CAPS"),
				event = "rts_mission_failed_retry"
			}
		})
		f8_local2.titleText:setRGB(CoD.trueOrange.r, CoD.trueOrange.g, CoD.trueOrange.b)
		local f8_local3 = 20
		local f8_local4 = 120
		local f8_local5 = f8_local0 .. " " .. Engine.Localize("SO_RTS_UNITS_REMAINING")
		local f8_local6 = 10 + CoD.textSize.Default * Engine.GetNumTextLines(f8_local5, CoD.fonts.Default, CoD.textSize.Default, f8_local4)
		
		local unitsRemaining = LUI.UIText.new()
		unitsRemaining:setLeftRight(false, false, CoD.InGamePopupMenu.PopupWidth / 2 - f8_local3 - f8_local4, CoD.InGamePopupMenu.PopupWidth / 2 - f8_local3)
		unitsRemaining:setTopBottom(false, false, CoD.InGamePopupMenu.PopupHeight / 2 - CoD.textSize.Default - f8_local6, CoD.InGamePopupMenu.PopupHeight / 2 - f8_local6)
		unitsRemaining:setFont(CoD.fonts.Default)
		unitsRemaining:setAlignment(LUI.Alignment.Center)
		unitsRemaining:setAlpha(1)
		unitsRemaining:setText(f8_local5)
		f8_local2:addElement(unitsRemaining)
		f8_local2.unitsRemaining = unitsRemaining
		
	else
		local f8_local3 = nil
		local f8_local4 = {}
		if f8_local1 then
			f8_local3 = Engine.Localize("SO_RTS_RETRY_MISSION_QUESTION")
			table.insert(f8_local4, {
				text = Engine.Localize("MENU_RETRY_MISSION_CAPS"),
				event = "rts_mission_failed_retry"
			})
			table.insert(f8_local4, {
				text = Engine.Localize("MENU_QUIT_CAPS"),
				event = "rts_mission_failed_quit"
			})
		else
			f8_local3 = Engine.Localize("SO_RTS_NO_UNITS_FAILURE")
			table.insert(f8_local4, {
				text = Engine.Localize("MENU_CONFIRM_CAPS"),
				event = "rts_mission_failed_quit"
			})
		end
		f8_local2 = CoD.InGamePopupMenu.New("MissionFailed", f8_arg0, "default", Engine.Localize("MENU_MISSION_FAILED"), f8_local3, f8_local4)
	end
	f8_local2:setLeftRight(false, false, -CoD.Menu.SmallPopupWidth / 2, CoD.Menu.SmallPopupWidth / 2)
	f8_local2:setTopBottom(false, false, -CoD.Menu.SmallPopupHeight / 2, CoD.Menu.SmallPopupHeight / 2)
	f8_local2.success = f8_arg1
	f8_local2:removeButtonPrompts()
	f8_local2:removeBackButton()
	f8_local2.leftButtonPromptBar:registerAnimationState("fade_in", {
		alpha = 1
	})
	f8_local2.leftButtonPromptBar:setAlpha(0)
	f8_local2.leftButtonPromptBar:setLeftRight(true, true, 0, 0)
	f8_local2.leftButtonPromptBar:setTopBottom(false, false, CoD.Menu.SmallPopupHeight / 2 + CoD.ButtonPrompt.Height / 2, CoD.Menu.SmallPopupHeight / 2 + CoD.ButtonPrompt.Height * 1.5)
	CoD.Menu.RemoveStartButtonPrompt(f8_local2)
	f8_local2:registerEventHandler("rts_mission_failed_retry", f0_local2)
	f8_local2:registerEventHandler("rts_mission_failed_quit", f0_local3)
	Engine.LockInput(f8_arg0, true)
	Engine.SetUIActive(f8_arg0, true)
	f8_local2.setTextAlpha = f0_local4
	f8_local2:setTextAlpha(0)
	f0_local1(f8_local2, f8_local2.success)
	SetupMissionResult(f8_local2)
	f0_local0(f8_local2)
	return f8_local2
end

