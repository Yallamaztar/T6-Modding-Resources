local f0_local0, f0_local1 = nil
function TutorialRetry(f1_arg0, f1_arg1)
	DebugPrint("RTS Tutorial Success Menu: Retry RTS tutorial")
	CoD.InGamePopups.RestartLevelEvent(f1_arg0, f1_arg1)
	Engine.LockInput(f1_arg1.controller, false)
	Engine.SetUIActive(f1_arg1.controller, false)
	f1_arg0:close()
	f1_arg0 = nil
end

function TutorialContinue(f2_arg0, f2_arg1)
	DebugPrint("RTS Failure Menu: Mission retried")
	Dvar.ui_isrtstutorial:set(0)
	Engine.Exec(f2_arg1.controller, "launchlevel " .. Dvar.ui_aarmapname:get())
	Engine.SendMenuResponse(f2_arg1.controller, "rts_action", "tutorial_complete")
	Engine.LockInput(f2_arg1.controller, false)
	Engine.SetUIActive(f2_arg1.controller, false)
	f2_arg0:close()
	f2_arg0 = nil
end

LUI.createMenu.RTSTutorialMenu = function (f3_arg0)
	local f3_local0 = CoD.InGamePopupMenu.New("RTSTutorialMenu", f3_arg0, "default", Engine.Localize("SO_RTS_TUTORIAL_COMPLETE"), Engine.Localize("SO_RTS_TUTORIAL_AVAILABLE"), {
		{
			text = Engine.Localize("SO_RTS_BEGIN_MISSION_CAPS"),
			event = "rts_tutorial_complete"
		},
		{
			text = Engine.Localize("SO_RTS_REPLAY_TUT_CAPS"),
			event = "rts_tutorial_retry"
		}
	})
	f3_local0:removeBackButton()
	f3_local0:removeSelectButton()
	f3_local0:removeButtonPrompts()
	CoD.Menu.RemoveStartButtonPrompt(f3_local0)
	f3_local0:registerEventHandler("rts_tutorial_retry", TutorialRetry)
	f3_local0:registerEventHandler("rts_tutorial_complete", TutorialContinue)
	Engine.LockInput(f3_arg0, true)
	Engine.SetUIActive(f3_arg0, true)
	return f3_local0
end

